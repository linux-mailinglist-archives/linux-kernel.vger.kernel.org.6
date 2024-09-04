Return-Path: <linux-kernel+bounces-314053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2461096AE32
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 04:02:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6AE71F2386C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 02:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 155111426C;
	Wed,  4 Sep 2024 02:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Fy1Sp3zh"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2071.outbound.protection.outlook.com [40.107.243.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A42AD529
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 02:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725415363; cv=fail; b=DTBJ+JHqi4O36HlJ9DEGUiz01q+rTyobDa/wrer0qSfMq7ClJ3sqvz9QR73DnZmTyo+e7KuOwttnqIpmkcrLJKuwCwFDEcy4Xqe1Lh0qf911p8TnGFTc9LafgWSGN1kb+Ml/b7/PIjTK2JqDfFtouRLfykKecfJ/mwKq0dUWGKg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725415363; c=relaxed/simple;
	bh=naWVWIgf0fasTMEopkpPGYBOgeIHq7Sb5k+mJKypKX0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qC1tkUgcnxtql06NyAe5iwjaAvXFKYyLi6SawE8lIoEB3DU9o/F0HhXITH5oZFAs9DCEw1oEz7JyNg7iNiLX9m/dr8SkxRLCJ4i9qpqHgNL5hzC1HHNdPZg3LyRGI/FulPxpNBv/9rudwvtG0534CNx8CRLnjtlJONTmO1HY3Hk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Fy1Sp3zh; arc=fail smtp.client-ip=40.107.243.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tPjMoPJppSY7A5CFxDl+U2Myknu1XqGn/22a+VyWP/8KhPBYFVku6ricseBFNvIJyqYqxfNdLdoZkY8x9ZLc7lGBUc46FJJOZJcZaDLEYdpjURxp+VcNoVXyV62v8KC7tbOoMxa7e/wXOUqYVKYG6FcLmyxMJ4BvX2utnjBojSeyuZhFXDUwkEmKq35dpKmbD5VtILGlrkZfBr9NlSXos5Ee5zkmy0j5db9eTKhabVW1Hy10tctu9tys6TpEcA+JdQkljiqTHbybu/ACbt6PDkyNm3dF5567WWX9vmWWSLBq77o7HIvYrmtSZkyzyCdLnLWHFtE23XubN+PgW8sJKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8TgVaSsrTkPRx9/oJZ8wWM3wsE2cmGG8QbB8UWaXEN0=;
 b=Ks3vl1YsDBJdSBXbAxMNuLp9qfX2dtZItFrG10/bF/7nwutlaWFMIzqgs+QnmEFtrh0A53OVyJvkFHQBlttUbx+xvAxIz+sVaR5pMug+tthS/zO1iUmRpVuzWOqeB6ZHdKjUItGIihjOBdrLB1pfc4RDuc9Z0DVD4W0/THMdNmQBQgIVG93PTpverFI9TDf/E7KFllbRu2ZWrEa3Hjco4gqvPhzhSURaaWVn8em3zlOSjYEBlwtbI1fRx29d0pvq/sH+JXguFg1/FFrV56O4ppr3tqNiXWVdrDOa9RK9NiBdub8FfQXeiDheWZhEWoc6Wy30LukKznmmqxK9MDJZfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8TgVaSsrTkPRx9/oJZ8wWM3wsE2cmGG8QbB8UWaXEN0=;
 b=Fy1Sp3zhsYhcTlTDxsRvl79WRMZRE74liEYVeL4Gs8GdWE3p2GZRrpSr4vMjstHJ/fi5Ef3uvVeIAAsWmXxWNBAWlb/O486QqDJmlLxQAgZQ4fhGiPdOuAKpFEF8zek68i4WrJqWGm75jpyG7vRKoty4DoFhhzI13IoD/jPHAgtHVhPlknYMdCW+lsHvWKJqsVl7cYJPWXcUPFyv6FOpaR6cU3zali7l6cWxMIJtm/XX/fI7ML1n57cCMCwt78swCPCM7+wg+OmQuTb0PO6TwKS8MsTT9NLYIbzcuUkfd/7ittcCNyewuXHKRUmaD1ucBijJtWdFlird6JHLvMY/qw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CYXPR12MB9320.namprd12.prod.outlook.com (2603:10b6:930:e6::9)
 by CYXPR12MB9387.namprd12.prod.outlook.com (2603:10b6:930:e6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Wed, 4 Sep
 2024 02:02:38 +0000
Received: from CYXPR12MB9320.namprd12.prod.outlook.com
 ([fe80::9347:9720:e1df:bb5f]) by CYXPR12MB9320.namprd12.prod.outlook.com
 ([fe80::9347:9720:e1df:bb5f%5]) with mapi id 15.20.7918.024; Wed, 4 Sep 2024
 02:02:38 +0000
From: Zi Yan <ziy@nvidia.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-mm@kvack.org, Oscar Salvador <osalvador@suse.de>,
 Vlastimil Babka <vbabka@suse.cz>, Johannes Weiner <hannes@cmpxchg.org>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Mel Gorman <mgorman@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 4/4] mm/page_isolation: remove migratetype parameter
 from more functions.
Date: Tue, 03 Sep 2024 22:02:32 -0400
X-Mailer: MailMate (1.14r6065)
Message-ID: <BDD48C59-0C42-4B1E-A4F3-FF97744FCF6D@nvidia.com>
In-Reply-To: <dff8fa34-9099-46f9-b39a-1a986af2b022@redhat.com>
References: <20240828202240.2809740-1-ziy@nvidia.com>
 <20240828202240.2809740-5-ziy@nvidia.com>
 <a43c866f-b281-49d3-b503-f5f86dadd306@redhat.com>
 <E48CFE6F-05A8-4D12-84D0-2B6F7484974E@nvidia.com>
 <dff8fa34-9099-46f9-b39a-1a986af2b022@redhat.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_ADD0248C-944F-40B3-9E6C-29820355DF13_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BY5PR17CA0047.namprd17.prod.outlook.com
 (2603:10b6:a03:167::24) To CYXPR12MB9320.namprd12.prod.outlook.com
 (2603:10b6:930:e6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR12MB9320:EE_|CYXPR12MB9387:EE_
X-MS-Office365-Filtering-Correlation-Id: dff65cf6-e845-4e4a-3d23-08dccc85a6ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/5qdnUxp/qSU+ONCpTIWA9vmPMLCTV68R6IGqbVEtKsdt+s5x/3r5Zwn7+Nl?=
 =?us-ascii?Q?kZ/PqDvH2m+uvI1zHF3j/HuUf97L9Qq1bB5Sc9r+4ogG2FXPcEd9gxYTM9U8?=
 =?us-ascii?Q?NV760DlVFwmC6TMkTLic1Z9Eurn6BWrPQjgS9W7HMQGgJLEpITNsRjyqFflm?=
 =?us-ascii?Q?RiFuy+Uk7sI9LXck+SfAmoiq8eXyzml2wIWbMfttWySBReMmxna1/cTBAGsK?=
 =?us-ascii?Q?oxx3KJZk5UkLCjPWExF84lgq9l+ss9i6F/lHHOjclSOLKvHmlDcY5qion3m9?=
 =?us-ascii?Q?Z1Sl8mMi3//mwMoYLypEX3uLbL/l2rUr0rRN4LEwNjVpAmaPkPwAXte5wVAq?=
 =?us-ascii?Q?2mO8p+JMUJ9Jy7vd4kWJ8M+GN7GpS9+Z9FE2EQDyAlldcq1HBOeqzepZDThT?=
 =?us-ascii?Q?lH5dhKOinq7W788JmaRXIIBWGqxMca1TXGnRaTuh25oBqib2jH+AZw/axWX3?=
 =?us-ascii?Q?MhbzhXb1K/Se+AiPDl7x84lNEfSvd+1r+Ad7954niPKIwB5qKdl4xpSKrFpL?=
 =?us-ascii?Q?sQlXBk8pXDvj78WmIzTAg4EVzju0YJLf/VKjkm1kK1y5oz9PU9xJZnc7VQu4?=
 =?us-ascii?Q?KkmLQQruhOHsN3pMsSTZnjWdO3bRWXgvvsOgVkA4nBDeBoTcSCRgQMF+k1c9?=
 =?us-ascii?Q?R/TYOoHljSbMEDLkSp1n7X3OGCWF4aOLETuCXlhYN6F3Y7Kq5feiBS9UtGxY?=
 =?us-ascii?Q?2x12bZpNsB9E3Y/rJfDgND8r42fVIE81TE1Eo1DBgX8KIVg5MDg4j1eTi9na?=
 =?us-ascii?Q?622zCQYMjcm0m15i9JCUI0Bdi1nRMe2Q4+pd055LeJxzJM4HmeO/i9lzVatU?=
 =?us-ascii?Q?ejaGz6J1yP3nMF1uGk+No5XTRRSQ3d16I4g44+dnoHoijs5csY2ePvkQuyNk?=
 =?us-ascii?Q?O/Ky/+DcD1VZWBtowgX7/Z4J/uiFREgK6BefilGWMDzcBLmppp/4o5a8PC7g?=
 =?us-ascii?Q?Un7j0SavANPogvKkfxYmJ8rg3iXtLM5HGnyJiAJPmtmx99DyfTMQHYobn06z?=
 =?us-ascii?Q?9NoV0/SWHwsHPS0734292H9k15ryD9kbfjzaw8s/JfD7Zsa2CPWaP81rk3Uh?=
 =?us-ascii?Q?9pvb7fpaCxcH8RReIkmoaXePozj8UioijWa6GuQ+uqZKt+qoP2uWmyUlZEWR?=
 =?us-ascii?Q?ohBG/LzFseYtT7BnAMC9AL94HTDbtfxGNkFofzKwA39jjsjDgU440NyLMpBS?=
 =?us-ascii?Q?NthFGyuPmExHhAcZqHIB9KC/7pD5FoIf/bcT+wesxJhMqdwuWZv62qBfUC73?=
 =?us-ascii?Q?RCCib4sMJFM4w6IaN55YVF4k5j5qsWeTNtUVP/+KUIMj8uQhXcgJoJS+4SeD?=
 =?us-ascii?Q?je4latH+Si59De+FOlLhmVw2wKp1yIoM1Bu3iwlEhln0mA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYXPR12MB9320.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xOOQGCPsD+ABduTloQZQTA4QPCPNm0qNrrj+L1SzOu8HoIcAjWfDMAwDjEuP?=
 =?us-ascii?Q?DzktRSz7HAiJZd0fwvZf2843YWnf3SucDoo2w6QJwXNnO2onMetLCGUi4W/7?=
 =?us-ascii?Q?1KRcOdgkwnJ8flrc3Hb8ncrf7nn7F2khdwQ0bEiEuCxeWoyEINjWPaQSnEwh?=
 =?us-ascii?Q?L3X2SaDXJaPltlVFYyawm5nPAJT+EYoL6sjtuwaA4x2MYYpZUhduEm63pzgA?=
 =?us-ascii?Q?fxC3e+UEE4iFRdUAEfPlTpwFCY1JDy89YC2ksy5aeEuHq+qP9Ap0eghokj+7?=
 =?us-ascii?Q?yUulBR1tp4Jq+KhuTMtv3uz8EZCqB+IAKL8O0thGe86j0sMPHkyMgEBwXDLV?=
 =?us-ascii?Q?dqjKfVnbc5aCmmTfNTHxkW/mWZMbcAmTiAhpTWsD+mjXSL1zeV4Yo8bU2GD4?=
 =?us-ascii?Q?vH3f0z7JmB0Cuy69RCACTlsVm73gDxvALyv80XaEZzjxMWQcMZBYH58KYhFv?=
 =?us-ascii?Q?rcGDiroZ/StU7YCC4WArCZwOw5WKEjC+C4ODh1zfzbs4Ir0COV/dHYiU47OL?=
 =?us-ascii?Q?uwmtsC/TxrJeVNm42uBulD4HjRX3efk4pQctpZrdItIu85vdGwLTkoZkG673?=
 =?us-ascii?Q?sFFuW/x0TZeq/0RNv8GGd2eDtczADCsOgh4SZS9iEOHXjkXhGimEmciSCQiO?=
 =?us-ascii?Q?/i3u20x6PXYxgR9dNXmUagDgsCwM77WWTiJYXBYdfcguZPa5AeZO2sv1k5XX?=
 =?us-ascii?Q?oP3A6irlu+ZFAKq7X3dVdHt5UB+yucX1vczqK5se+7v9pG9Ltr3Am0ZT5k3c?=
 =?us-ascii?Q?9fo8lXeXQB+scb2Hc8TkiXeWJvrD72QRvYB0Zyz8hy0+vSTOIhUSEQA0tk6a?=
 =?us-ascii?Q?0j5mcKstWqihR7DE5vdLZst9FlNY6KcmkrmUBDwpPExV5OIstlY+/dtjui7B?=
 =?us-ascii?Q?9cLcU59KatAi25PywTfUteYodw61yF6yFlkVknwuNgA/o8YCQzHIZY1OLW2Y?=
 =?us-ascii?Q?7GTC8j2aXiJes3vDboCJEmqETqzKSU0jrym+MJtzkwjri3EoV+gNzgOrFNDF?=
 =?us-ascii?Q?RZTFNnr3mrrXEbwowLEWZreGTJK5Vc7ExmmGgzTRXuNga6D0SN69ww4x4scM?=
 =?us-ascii?Q?iXyzJgEKNU1ss80Acc1iicCp/g7YXjXCEseCS1QKclGMiW8dsFSp39RNQAZ7?=
 =?us-ascii?Q?1sh0KEkL6HPAW5qcb4SUrQ28wDQeCWE5gQ7UTRQm7c+5PdUcncMNYOqoVR8E?=
 =?us-ascii?Q?TJwBd70VN4qbgrohoVd2PECfrlwtOzp9LwZj7eccvebDE+2VcYd6TQDQ4aHL?=
 =?us-ascii?Q?x9AaSq33zF2Kx1ylm1mfRH7FBtrPsmieduaScrrPsxH5QQrIgrSL2gpvmLXh?=
 =?us-ascii?Q?8XF/U/39pwXz1hAL6I81KiauapP20FWpYe0qdW4cXdqQD1oxHsb96t74azGn?=
 =?us-ascii?Q?fnoNW1WAu9PZ8/Y834JKJDjaFxk9fcyjmJypy8zlaXd5s05gDtnWWJV4U4RY?=
 =?us-ascii?Q?L1SOkwkPrhzAVvv/2tJEjnMEzANdiz4S3qnc7U732zwMlAWd1D/9b0y5oJjB?=
 =?us-ascii?Q?UXRLFYyQvH6sDMpeVbTAh/lIS1BN69yXpo/E85g5xBaKpd92CYMDYTgglmWM?=
 =?us-ascii?Q?SQG49kkTKnYt21nViipZpmY5vaciy1uAkQq7qxRI?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dff65cf6-e845-4e4a-3d23-08dccc85a6ae
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9320.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 02:02:37.9988
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9JkNjMXrDmJzFpijs7Ad/Suz78reJBKMHkhmHoUXdh9uM0PPyFQJ3ykTKst0d5QN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9387

--=_MailMate_ADD0248C-944F-40B3-9E6C-29820355DF13_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 2 Sep 2024, at 12:42, David Hildenbrand wrote:

> On 02.09.24 17:34, Zi Yan wrote:
>> On 2 Sep 2024, at 5:06, David Hildenbrand wrote:
>>
>>> On 28.08.24 22:22, Zi Yan wrote:
>>>> migratetype is no longer overwritten during pageblock isolation,
>>>> start_isolate_page_range(), has_unmovable_pages(), and
>>>> set_migratetype_isolate() no longer need which migratetype to restor=
e
>>>> during isolation failure. For has_unmoable_pages(), it needs to know=
 if
>>>> the isolation is for CMA allocation, so adding CMA_ALLOCATION to iso=
lation
>>>> flags to provide the information.
>>>>
>>>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>>>> ---
>>>>    include/linux/page-isolation.h |  3 ++-
>>>>    mm/memory_hotplug.c            |  1 -
>>>>    mm/page_alloc.c                |  4 +++-
>>>>    mm/page_isolation.c            | 27 +++++++++++----------------
>>>>    4 files changed, 16 insertions(+), 19 deletions(-)
>>>>
>>>> diff --git a/include/linux/page-isolation.h b/include/linux/page-iso=
lation.h
>>>> index c2a1bd621561..e94117101b6c 100644
>>>> --- a/include/linux/page-isolation.h
>>>> +++ b/include/linux/page-isolation.h
>>>> @@ -32,13 +32,14 @@ static inline bool is_migrate_isolate(int migrat=
etype)
>>>>     #define MEMORY_OFFLINE	0x1
>>>>    #define REPORT_FAILURE	0x2
>>>> +#define CMA_ALLOCATION	0x4
>>>>     void set_pageblock_migratetype(struct page *page, int migratetyp=
e);
>>>>     bool move_freepages_block_isolate(struct zone *zone, struct page=
 *page);
>>>>     int start_isolate_page_range(unsigned long start_pfn, unsigned l=
ong end_pfn,
>>>> -			     int migratetype, int flags, gfp_t gfp_flags);
>>>> +			     int flags, gfp_t gfp_flags);
>>>>     void undo_isolate_page_range(unsigned long start_pfn, unsigned l=
ong end_pfn);
>>>>   diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
>>>> index 4265272faf4c..fe0b71e0f307 100644
>>>> --- a/mm/memory_hotplug.c
>>>> +++ b/mm/memory_hotplug.c
>>>> @@ -1993,7 +1993,6 @@ int offline_pages(unsigned long start_pfn, uns=
igned long nr_pages,
>>>>     	/* set above range as isolated */
>>>>    	ret =3D start_isolate_page_range(start_pfn, end_pfn,
>>>> -				       MIGRATE_MOVABLE,
>>>>    				       MEMORY_OFFLINE | REPORT_FAILURE,
>>>>    				       GFP_USER | __GFP_MOVABLE | __GFP_RETRY_MAYFAIL);
>>>>    	if (ret) {
>>>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>>>> index 4d06932ba69a..c60bb95d7e65 100644
>>>> --- a/mm/page_alloc.c
>>>> +++ b/mm/page_alloc.c
>>>> @@ -6607,7 +6607,9 @@ int alloc_contig_range_noprof(unsigned long st=
art, unsigned long end,
>>>>    	 * put back to page allocator so that buddy can use them.
>>>>    	 */
>>>>   -	ret =3D start_isolate_page_range(start, end, migratetype, 0, gfp=
_mask);
>>>> +	ret =3D start_isolate_page_range(start, end,
>>>> +			migratetype =3D=3D MIGRATE_CMA ? CMA_ALLOCATION : 0,
>>>
>>> Can we have flags for alloc_contig_range() instead of passing in a (w=
eird) migratetype?
>>>
>>> Then, we should make sure that we warn if we try a CMA allocation on =
any pageblock that is not of type CMA.
>>
>> Sure. I will expose the existing isolation flags (MEMORY_OFFLINE, REPO=
RT_FAILURE,
>> and CMA_ALLOCATION) as alloc_contig_range() parameter to replace migra=
tetype one.
>>
>
> Maybe we want some proper, distinct alloc_contig_range() falgs "acr_fla=
gs_t". Might be cleanest, to express anything that doesn't fall into the =
gfp_t flag category.
>
> Exposing MEMORY_OFFLINE feels wrong, for example.

OK, it seems that I mixed up of start_isolate_page_range() flags with
alloc_contig_range() flags. Let me clarify them below.

For start_isolate_page_range(), memory offline calls it separately and
needs MEMORY_OFFLINE and REPORT_FAILURE; CMA allocation uses it via
alloc_contig_range() and needs a flag (like CMA_ALLOCATION) for its
own checks.

BTW, it seems to me that MEMORY_OFFLINE and REPORT_FAILURE can be merged,=

since they are always used together. Let me know if you disagree.

For alloc_contig_range(), migratetype parameter is what you are talking a=
bout
above. There are two callers: cma_alloc() and alloc_contig_pages().
The acr_flags_t is basically a caller id. Something like?
enum acr_flags_t {
	ACR_CMA_ALLOC,
	ACR_CONTIG_PAGES,
};

And ACR_CMA_ALLOC needs to be translated to CMA_ALLOCATION when
start_isolate_page_range() is called.

BTW, after removing migratetype parameter from alloc_contig_range(),
the tracepoint in __alloc_contig_migrate_range() needs to be changed to
use acr_flags_t, since I do not think we want to convert acr_flags_t
back to migratetype.


Best Regards,
Yan, Zi

--=_MailMate_ADD0248C-944F-40B3-9E6C-29820355DF13_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAmbXv7kPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKY0wP/2QwPT86xwX31mSrGoCofeWdIWmQT41iDsOD
Zx/Cd10ksSee894SnV1vDRHC14nO8noKWNGOkzbBp1ctcfJ+WaxxPq7abXwpZZYa
9m0xczXbOroQKu1mbg0/ciEJhbMSLvP5O307RnuKnGnCH3Sf7I++L648UQu3ZiGl
Iohif12shG6b4PnZ/79srmQEYMXhJcinZ6HwYRsaqTULRAzHvSALFNBm8J4YbO0Q
WzYUUh9gzjDHF+AFPen8mwGLh3jRqn2yD1D63UC+wcMlx2M2n2ws2M+65lxBbWzB
Iwlt1lzJ3OfwjrmFJ4reYZsXg9MHx8kuBOkitoshxIGnJfgtyg6SuJ4nCdVXtkUt
KBi1oLG1Raf0W0Hqp3Ita2qpeGLRXNaYul6JQUSxTzEu0Frel1WoUZlOHSsWQib1
p0Fg9wYxHuNP0sgCr/bE7KnBN+zVljyAk9EZKpVmrPn+Lc70kH0OLQm53C74D4Wx
soImGM9/ZQ99A5xtW8urJ5+RY7h8M4g6DgP9v5dhZCUylnjxED9Z5nmKcJwlLfJv
hlbx3poFRcfbIhFVG0pe851weABd75/AHApMerxbBnM1CWTL/BaaD8dU5I9VHqAw
i9XBgE0mrBiSNPvwJBmt5TsMpW/j3P1NalwUVleCC+IvbmDpC5ehiHNP4MGgkl8X
m1PpkTgc
=r5oK
-----END PGP SIGNATURE-----

--=_MailMate_ADD0248C-944F-40B3-9E6C-29820355DF13_=--


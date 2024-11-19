Return-Path: <linux-kernel+bounces-414591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF92A9D2A8E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 17:12:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5473283338
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 16:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26C8D1D0432;
	Tue, 19 Nov 2024 16:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TnZuHrVb"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2049.outbound.protection.outlook.com [40.107.212.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6BE1CCB4E
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 16:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732032734; cv=fail; b=MrKcyHbY8TihtHYSoZ1sUqpod+QJBg4S0ndpRVY8n5ZoAK/7Z8jgmgs2SzW631OkKVPW8utVlhHhV/dCgWLssx6RQu8FIwmaGDgos9ewcEaBqlXNV1xsdc/nETz7Ws7YJQKWDiYVOsXcY1yYZOe9i+yvftZjBgr3TWxmw18gK/Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732032734; c=relaxed/simple;
	bh=lsOh+FtTkqR6VDVz3N29jCUGJ7CxtFoCxhQ1l17apD8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AJGTYX6g7O5j3Sly2bRxW4Sxj3jFKPZnNqvIKjoVkiSxFNI9r4KGr8qvnsS16IrNSGkdPGatiGcR7TPMlU4j+Tm1G/xr8fx6VnfhE2lUutk1ufoZw8RoMu/LWdJXHdp6y3BqUFb0TbO8NE7jagm3yM4cgAbE9p9Zn2Dz0mz9wsw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TnZuHrVb; arc=fail smtp.client-ip=40.107.212.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nPPJqNlaOK0BXuiBHSasvCsaaRxlf63xp67ErNHp7W3X9hsANahS3MT3zSTFQy7LtBXasRfoe73YZYguykPJe1p2QecD9cfX1pPNn21fVYd3o34Me7pdJxqGdp8Nw3sIy70tVzWlIPYzWWi9x+fbWZ0TNYfR7lRNVUESwaYKRElgGr1hxXbcdUbx5ScfY5T3CNroojkgOsLXFBFn7LfQked1fRZlh/oYDHXYI0lEMG/5Flc1p+zUPjjVSNLcfoZRNC4kGyQ76QIE2aZz0xNG547jtfJCHMLmZf2mZqfPBvlFJtublVMdUDDkZ/QJWsct2JWB5e3NW/o1C0SzKZfGtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PijnlypyCNOwC24sYbI9QnzRaa6sLue+EnH5nB/pMiI=;
 b=uyCG630QxIMFrc/teLdIM5fo0Nne+gfigxX+Bs9W3eI3yKsl8slE3dxe16umd85TpwUzWgG26FPQUN6e/1s5Jv+nH/ZmJ04lwDpSZ3eUAqDLExu8UGjwvCLdFpa1c7G2tU7sejMNDH7qzSXB/YGZHwiCUwHWrrKkrLSIjGB8+UuaLyxCY1BWAem78H7jzT9xQOfBK85FeqZSwjt/6h0wCDSRoduytEtlpXpIecCHde4gaA7FVf9lNlcX1mZhGFDD7CMUzozIqXUKlbfOLiZEZiUJmS7HRZ1a7VAtX+0vZGmgQXO0tKM52RcSX3mpA0KWnKqfxqN/FIu9Z5rAdxXdPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PijnlypyCNOwC24sYbI9QnzRaa6sLue+EnH5nB/pMiI=;
 b=TnZuHrVbqE/k5ZRUCKzbTNwmWvq0BdcgTgACUk++H4sl7DDlAzeBq99pk4Vv1S/CKd8kjvvCMu5vwZgKfkcTEtjXIdO6uN7edVJ5eSw7UPiT8JUdeqzeSFMg34v6YYbF+sporfp7cr11SoGsa7Do3NKe9D2p8hMDsxCsRWfU3oORa+biK7KnsGNwjteW+EKRNFlmjBMptsYOvRvYI2GJkMh5DD9EzhjiSbyY+C9ZQHytXKcS2kHvvJdBP+MuWVJrTApp7hKbPKpKNOiVrPJYnvw17yYbZ7TA9Ga4v/YLE0gMh8Q3dWgomzvia1dB5MLOu63B7ew54Bdl+gjc0Q60eQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 PH7PR12MB5782.namprd12.prod.outlook.com (2603:10b6:510:1d1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.14; Tue, 19 Nov
 2024 16:12:08 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%7]) with mapi id 15.20.8158.023; Tue, 19 Nov 2024
 16:12:08 +0000
From: Zi Yan <ziy@nvidia.com>
To: David Hildenbrand <david@redhat.com>
Cc: Yu Zhao <yuzhao@google.com>, Andrew Morton <akpm@linux-foundation.org>,
 Muchun Song <muchun.song@linux.dev>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH mm-unstable v2 1/3] mm/contig_alloc: support __GFP_COMP
Date: Tue, 19 Nov 2024 11:12:06 -0500
X-Mailer: MailMate (1.14r6065)
Message-ID: <00721702-78FF-4690-8EAA-31C367FA9FC0@nvidia.com>
In-Reply-To: <402ff3e5-4fca-4452-97ba-5b1ec4a6eeb1@redhat.com>
References: <20240814035451.773331-1-yuzhao@google.com>
 <20240814035451.773331-2-yuzhao@google.com>
 <402ff3e5-4fca-4452-97ba-5b1ec4a6eeb1@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BL1PR13CA0087.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::32) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|PH7PR12MB5782:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c56e4b6-fa40-44fa-0f64-08dd08b4eb01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9pTTgnken7T4FckbT4lP35HQaQ6avKU/7VTpf9Xz+601Iixd+1UCEvEBes5A?=
 =?us-ascii?Q?nKboeGR2jSQ+vPmf0pSinOp0JP7cCvkojHz06GHYdtaY2+fXKgz1Y18iu4IC?=
 =?us-ascii?Q?s03mNZWqLvKo7iJene+am+STi+ZxQ6pDoY4whlrwui0m0rE/vpHlWZ61ew3g?=
 =?us-ascii?Q?Yksggb809QIeVSPk1kTQ4ZWbiK1t6AzFLIKQVnXb9xYdWEyo7azlz8uGKu5Z?=
 =?us-ascii?Q?Wjd+z5YDf7jPta2gC+IUWIxaqBMtLD82abdOuXFM+BTWDP+LV1rKQYzg41j6?=
 =?us-ascii?Q?FqhfcTOzXGdtxuqGAfoXA0IpJCoDIPKxCQaHNPs+cApLa3nh7dsUAHPpIVek?=
 =?us-ascii?Q?zTz/dvWFHuwWpIdLB35CfAYzBwEcBpToR4qzyIWtYa61RSWJ2iEih9rvuFKB?=
 =?us-ascii?Q?747C1AiEhPdSIY+EkwvlL9Ez9dWlwGcrWpXd4DSzSJT6WYjUCRrdTrBnFmy0?=
 =?us-ascii?Q?Mij9j43+ziBBWA5ICN6wDWtbNR2WdZJDGWasaCmmJWUgJd1fOSwgIIAIBkSO?=
 =?us-ascii?Q?jtm8PshldgISMCMsDlKDidkgA0XWPDSirAm6las3LpnWFdjBSkSv32AH3eGr?=
 =?us-ascii?Q?ugeKDQMkAbolI4XrZ/MFE8dYs+2cSoFr75Uy75RxuIZDB5J9fTnRYu4BEHKA?=
 =?us-ascii?Q?ATTFkWvMusS5AYAMGSt5ntASO6dk5Ee+tIUdbhAzZuGI+Et8q+jUEHrdfCPA?=
 =?us-ascii?Q?LnZjYqcxxUQUFV2shK1gtuMkny48TWSfND9wA+dI+NJE+Mk48nuLJIQh5nxF?=
 =?us-ascii?Q?16f5fsBN8xbPSEsrVlbRIRO67sabzS0BsOT4gKRZKz14Pu2M2+AdVqYgHOJG?=
 =?us-ascii?Q?gkAXwnZBrxLNAenL41QZGaXHGObn0Qm/ClmBv2KuTSLag8l6WGmhQDrmAw0S?=
 =?us-ascii?Q?/C/vh00BZD2eCH/yHC9kMJAcYUi2iNNC9tHh8gbOJpDEAV6vBDoxtEx0/MGY?=
 =?us-ascii?Q?aYyQD48fevFFAE6LF7PtpX7hjh4WQDvYzL+RNFFqn6wsQ/qOQRqYa87AOg/v?=
 =?us-ascii?Q?lTNfMmw4DtW0O3sVqPWavhIPjoSOzyEdcv0tfSRm8aCeGagjyowQ09AwIPXr?=
 =?us-ascii?Q?5AcZSjX3KXpjt28V4AOXID3IAu72xMWUOtYcV2GA9GZfz8rPbAFy5ppQwUUR?=
 =?us-ascii?Q?AMj+hyNE4TfG2/HzQ/5uFKkEL71sureaaSC+4MQGt7oq/WekAZAg/QWPQKmB?=
 =?us-ascii?Q?+qhzNfTJrECEvGgE4LhM8R9QkGZQo/KeQDTbZheW22yEV+8onei83UKSUayj?=
 =?us-ascii?Q?rjGaIntpsnfLCFbW/8EmRDRKJoqRvbqF3RceOJAig4IhahzyF/d8Pxz3gQUM?=
 =?us-ascii?Q?UfM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?m/uWreOGv9HzXVDdJwr/EnNltdGmlYk2mGyC4A15b44tp4vC6CQPzgDcd6nn?=
 =?us-ascii?Q?QBs3ECmo/Mnh2ivYyTCSkpo2zXYDMUseqXRz9CzamWIfFctewmn7HWq6yzry?=
 =?us-ascii?Q?0xNqOu82BrZyebiA0HQaCWBcCs26nF1aYbIncETQuEWdTRalJHWMCBLdGC/U?=
 =?us-ascii?Q?U6y47Ly6HcJMgdPTzxXv1shrXEXXWEoIKq5IT3f7FU1CChtCuGjsagdB3hbg?=
 =?us-ascii?Q?b1gzmR7dx7T9gjYCy3fgyYQYfkBoa/EnakMDfd7uNY82GKr64JvO/Es/w0b1?=
 =?us-ascii?Q?T/FzWQ1qR60tLX8rIaVALV9QS32BsSzuYZ3AElLuJ+hkZeLkZReYCK6tdOga?=
 =?us-ascii?Q?b/bSiUGbhFcwIVY1DwSUs42mEfiC+i6qYzu8gJ1L1aPJCvPKA/jFyQmV4w5R?=
 =?us-ascii?Q?ZAnKWel2IRV6q1u4QLpUxLen+9fhiAc0OZl1CAAIpGx4HzUD2y4kdqRKxU6K?=
 =?us-ascii?Q?e9TXVQkIFL1ELYNAV/LE1XrptnKeKn2kAiUiOE5/lb36edbfvc+0LiAen+CP?=
 =?us-ascii?Q?qdV4rMKHp8Bvn/6tCh561hVPQp+N/OiR8uiznooqtUVM/rRdtJMThwQB2VCf?=
 =?us-ascii?Q?acKrhYbMSyh6/0UXwdGr/8iCDmX9vfswHGk9SEbkt4Ln4m3H98sbI6tMunzj?=
 =?us-ascii?Q?WXyEoeQzzBLDCfJsAeeri6K90V2W/nD8ZfcUSmXqYI4ggs6k0oHw9P/4gXth?=
 =?us-ascii?Q?8MLPB7zzIYPlXdiaOf44eItjF3jsl/Zx3imtQNvbSIdDX+3WkXFj9S0KBJm8?=
 =?us-ascii?Q?aTIP+LMO72wxEhL7Qdn1hyD1ncoLByLDYUIbzBnc+jiLaArzpYKFvllkIa1L?=
 =?us-ascii?Q?BVRf8MzDOQelsdQ20SxO6MPpt/KFgYmKffJSLPQvMIn9jPVrxzguFOgZpFyA?=
 =?us-ascii?Q?0muDBntmUys1aApvLJjZg+L+IEVv2XYgHhb+ktA4i5effh3btBJdfzxtXa3C?=
 =?us-ascii?Q?sOXJvdQRJzxy+B9q1f2+VPJ2chVwD8A8Q3lv5R8jREJLRB9I8sp89Gu448cV?=
 =?us-ascii?Q?ntG9lRq+giXGHALMW2EvQ5z9bp6Hpshl06V9uoigt1aTZ9ZsnVtEuU+yeEaX?=
 =?us-ascii?Q?2RBgmCtIvanCmTuDkDaZOwJSjtSzF/pPdDDSEYNYrVkg1khH5o4XqcYMfITs?=
 =?us-ascii?Q?Fh8FKDkwUJ5IdevfOiJX44Ths3IsNC/j0yeELZeFXpUPD03zG1vudkQdQpyE?=
 =?us-ascii?Q?doY59H/0kzHtPKQCHIOuv4kNOUI4wTlbuSdr3Wr3j3SuogdFP93SpE6loA5Y?=
 =?us-ascii?Q?CSnIQG89TIMCo0TJ3NtTCQKYtW/gY5wwIPoQ851kddD2KXWXVSZH0PJlDHTL?=
 =?us-ascii?Q?Ozg5vVwTxO4Nav4Vzcjwl+Wi6Sncuuroj8DRxCevfleMsTkPfmGbKeEgsc1N?=
 =?us-ascii?Q?Fg2C4JI3mFa2HCfK4AhdrfOURwhbaN0qEAFv9U9F9Vk4hXYldOtuXVikZmAn?=
 =?us-ascii?Q?m63MG9BmJEaqmn4Lr/zX5BZTjA7MiDmBq+30RS4Rf3LffNRIx6R35CROhdlX?=
 =?us-ascii?Q?2yXbPGBkmqc52Uyr2pd6HhtPdtvZsLD5ZMuhJIIUgHGnxYjEQLY+9EaUjeGQ?=
 =?us-ascii?Q?gnGRb/NB+ybsjbA89kNfO7Dr7C1z9kBSiIlejum7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c56e4b6-fa40-44fa-0f64-08dd08b4eb01
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 16:12:08.7458
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4a4MsZ5Ts3h0/hyISCy8ie1R5qhnFWqTitp5du+wgtviQqdmUbTanuMqmqpw//mB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5782

On 19 Nov 2024, at 10:29, David Hildenbrand wrote:

>> +/* Split a multi-block free page into its individual pageblocks. */
>> +static void split_large_buddy(struct zone *zone, struct page *page,
>> +			      unsigned long pfn, int order, fpi_t fpi)
>> +{
>> +	unsigned long end =3D pfn + (1 << order);
>> +
>> +	VM_WARN_ON_ONCE(!IS_ALIGNED(pfn, 1 << order));
>> +	/* Caller removed page from freelist, buddy info cleared! */
>> +	VM_WARN_ON_ONCE(PageBuddy(page));
>> +
>> +	if (order > pageblock_order)
>> +		order =3D pageblock_order;
>> +
>> +	while (pfn !=3D end) {
>> +		int mt =3D get_pfnblock_migratetype(page, pfn);
>> +
>> +		__free_one_page(page, pfn, zone, order, mt, fpi);
>> +		pfn +=3D 1 << order;
>> +		page =3D pfn_to_page(pfn);
>> +	}
>> +}
>
> Hi,
>
> stumbling over this while digging through the code ....
>
>> +
>>   static void free_one_page(struct zone *zone, struct page *page,
>>   			  unsigned long pfn, unsigned int order,
>>   			  fpi_t fpi_flags)
>>   {
>>   	unsigned long flags;
>> -	int migratetype;
>>    	spin_lock_irqsave(&zone->lock, flags);
>> -	migratetype =3D get_pfnblock_migratetype(page, pfn);
>> -	__free_one_page(page, pfn, zone, order, migratetype, fpi_flags);
>
> This change is rather undesired:
>
> via __free_pages_core()->__free_pages_ok() we can easily end up here wi=
th order=3DMAX_PAGE_ORDER.

Do you have a concrete example? PMD THP on x86_64 is pageblock_order.
We do not have PMD level mTHP yet. Any other possible source?

>
> What your new code will do is split this perfectly reasonable MAX_PAGE_=
ORDER chunk via split_large_buddy() into pageblock-sized chunks, and let =
the buddy merging logic undo our unnecessary splitting.
>
> Is there a way to avoid this and just process the whole MAX_PAGE_ORDER =
chunk like we used to?

Probably split_large_buddy() can check the migratetypes of the to-be-free=
d
page, if order > pageblock_order. If all migratetypes are the same, the p=
age
can be freed at MAX_PAGE_ORDER, otherwise pageblock_order.

Best Regards,
Yan, Zi


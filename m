Return-Path: <linux-kernel+bounces-200758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0ABF8FB491
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 15:57:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56BFE1F218DD
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 13:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE2F8EEDA;
	Tue,  4 Jun 2024 13:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lfjyl2LY"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2061.outbound.protection.outlook.com [40.107.243.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A36FC2D6
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 13:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717509461; cv=fail; b=iP+quUi1aWyjED2GF94nqU+/xbNmS+UJPG/gQbah8cKvAysX+8idSb76nC5OZJXRpuzAr2n44tJCUJczbTan/V5HFvvWcRktFqe8rnNF7Itby8uZnKn0+JBfO3G0Xb75YLNBfyL7rnQhPa1Ff2FqIHXv9h+4agkB2wBZVExSprc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717509461; c=relaxed/simple;
	bh=1rtxCYIZXEh51iW4NTCXrLo1LTE2bM9jAuYlxh2OZps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XmUqdrvLuUS1Tpl5WXFDkVvFGJokRk4nnuQwqN9CoMY/L2MEpMYKmueyvPbztTgurW8MFhVwKFzlvyd09XscdUYJ9OYB9o1b40/5YI8hXKqTwnwYpFqyZG37TiE+TvH4r0QfgmBtopUmvRvRReGbaUagp6oOSwjSlu5S7IOvTDI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lfjyl2LY; arc=fail smtp.client-ip=40.107.243.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XJQ5Wklj3pqm6X26QNMX9ToWDSSFMCm2pnUKH3kSTV1aSNdMERYhPQf1nAlA+WbsQcBa56vKQbcoRKEWmbmOqiIX8WjspvliGKUasJH16i4goy958dcuit2FalQVCGoEPyOl99JjrdqfRuG8lay95eqH6yQcO7++BGdUsB8bJEkjnF5z0Vx/OGVB54xUqtE4DI0CiwpG/zhrA2eqIvK15BV1K4KqztDGsJhOO0Zomcgkzcb4s8Ab25QuMRBSkCU+e/leadsEsg2z8MJNkYHKMh6QF7V7tq4xf5YY243GeIugmJZir4p7PbDrBVA5CPHZeaSg3fV6+2oJSJSdmSesCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TcBmSp6rWsvrvlR7DUDwsYuoFQhJJkcmCopYRxehabQ=;
 b=GXhn0cmAoSw8fq1KkW5jVBuGHR49s0wpUfjB7iFUUSF5IUVKgh64cGHIPqqGXlHk7TIP1NiguyguVSFigXmHnijRaDHOjVsBBwPmNSIe866AKcSlhKLPsu+wB7VwqfutPTeQvI1ywtm/Vy4XoUipflF78aVBKrBxAuXJKwDHWx9oQXJFExL/e9AjrzpqFTJhWBWYAx2rSIz6BnbhZgI+ulcRgQcJIh6jW+TXlQJWeeJeXHDyUyLfD2/UsYqcpwflzj+jFrnVHH+B6L9fnnXqt1KYhJ2EbUD6v8Ok965TOrrJJqTzTmOqqeORx8J/1yG5DJAk3CIcDPG/cOjyuEk6iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TcBmSp6rWsvrvlR7DUDwsYuoFQhJJkcmCopYRxehabQ=;
 b=lfjyl2LYYIPPLgfQcLAYqi2h5WYlKRgVy6vRh//zMCzR9Shf7bNB9ni8YneuI0ur2qFa1KIcn+rczKHuITCTZD3S/Q7xNSajMmghGlQ09Z1AtYgGibkY94djYDhwe8fIepfJHxADYTxC6KbyIRKxg0eqHtjFXZ9iNqNusCus1n8JMpjFw9U0PAxyfCiIfk9CtCnMHwgba6V74Et8WrZxjJEYswol/xnTJlQAD++eOUoupR3ki2sAj2WRUcM5EiseaQAY3bYFUq3DDFU60dXN6meODWQoSbRbNgE1Zb9Ne2ZUq113GMupAsfe1iApy3Am8A8YibN6snwI43eMqe/Duw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 BY5PR12MB4068.namprd12.prod.outlook.com (2603:10b6:a03:203::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.27; Tue, 4 Jun
 2024 13:57:33 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f018:13a9:e165:6b7e]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f018:13a9:e165:6b7e%4]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 13:57:33 +0000
From: Zi Yan <ziy@nvidia.com>
To: Luis Chamberlain <mcgrof@kernel.org>,
 "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: xu.xin16@zte.com.cn, akpm@linux-foundation.org, v-songbaohua@oppo.com,
 mhocko@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 yang.yang29@zte.com.cn, David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH linux-next] mm: huge_memory: fix misused
 mapping_large_folio_support() for anon folios
Date: Tue, 04 Jun 2024 06:57:28 -0700
X-Mailer: MailMate (1.14r6030)
Message-ID: <E5C46860-D455-4300-98A0-A8C2081F6FF0@nvidia.com>
In-Reply-To: <E30FDAA1-B4D4-41C9-993C-0AD5044F30C0@nvidia.com>
References: <20240604134738264WKaKYb3q_YTE32hNAy2lz@zte.com.cn>
 <fe35d494-b54e-4302-8c75-24abc9094ea1@redhat.com>
 <E30FDAA1-B4D4-41C9-993C-0AD5044F30C0@nvidia.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_01E4B2E9-59F6-41DB-96D2-C9FD75587B8B_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BYAPR08CA0015.namprd08.prod.outlook.com
 (2603:10b6:a03:100::28) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|BY5PR12MB4068:EE_
X-MS-Office365-Filtering-Correlation-Id: 528f80c1-cfb0-4d4c-cdc2-08dc849e4831
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?I2nMkAXy9LnRFjuQhWQ/Fmj+EJKyidNOAhxU45KU2NeTPvcLV/uK0scPANoB?=
 =?us-ascii?Q?/tgBFlxurL9LkyBAjvlBC9Hd1eAs6+J2TZMy0w3J+PuIFn59aqJf+BGbDfMj?=
 =?us-ascii?Q?6+Vk4YgOMDtSybr0/nAYLmUB8lu2GH4AxW1epry4G8JebsRmUJv9usXYUqqI?=
 =?us-ascii?Q?WG6MeOJwsc23ouXTrBn/wsgtGYyyo31UevpE9yhbOIDoxn1pkDdoqkUP/TVJ?=
 =?us-ascii?Q?pSbhsY87DkLC9KMmKE++9gMK72AOUWXdNO/eAou8AD5FO2u9ECPRv00Z0PEn?=
 =?us-ascii?Q?wNrT0cr1Xq1arLpUjhVM0D51gudk6RhAHxHEWGwT2Tf3H3Ahh6/6IgpWz8Rl?=
 =?us-ascii?Q?CTTsVOBUb+TEdkY+iWjM+8k0K3zVm3DCFxiYkmm/3O//6fPXJ4KdJSENcLEi?=
 =?us-ascii?Q?NBY0LsY80rt+u3QV3dwwBwmPbDi0C5vAfo77uuCYino8ROjTH3/t2CdNxOEB?=
 =?us-ascii?Q?CZzPSiB72HsuPc5q2+JN/v4WS3DS0eo0blnPT1NM3YpgIDQJiRosHTT6J4Wl?=
 =?us-ascii?Q?wv5Pt91G6dL0gj2jsZ99DXmUqfliuccdtCi54ZzV//c5sK3h0p7muH0+U5o5?=
 =?us-ascii?Q?HrBJtcQ1jD1r0DtAsIRWpUuufgTu0TNuV8n0j8ZgoHy7y2RF/hFjdmuyd+K6?=
 =?us-ascii?Q?XKN2+4GBxUgee5QVI+Kn2fx8rWMxwNq9IUaq88RCxroknglQrabZK81L/wKQ?=
 =?us-ascii?Q?4RaJVgaNCP8wCCKqsF3WTN3NT9e3tH6Ix5HYF80NKbegh056IvhDtGVK4qa3?=
 =?us-ascii?Q?+hpRoeWAWIz7RngReJ25jUdbuAxssj6gWNIB/k56Vagva4td/L7NfzcgCGGr?=
 =?us-ascii?Q?Q3yycfP4jUd4KO2EEWqnHQXaT/oDfz48juSxgBJQLY19YtTJxZ9xxsRTKPgv?=
 =?us-ascii?Q?EU//0M0empRy3/3DY4xInKYGc6Oqx8Oi4NTroKQXOOSx1yeJkQOHb5XhzsHU?=
 =?us-ascii?Q?8rAXb4ZxVonrzh8Gj1XwDJ6K+aOa+fsDfsBtOTu1VTOIwlw/JOwNLB1o/HYd?=
 =?us-ascii?Q?LfxyhsC/ZVcv7j+46FaOCPvB7pktN1BMKzjEzM1TEhC2auUziMEEA2PsfGo5?=
 =?us-ascii?Q?eKlPGqEHkeAGs4Zo6rsUA1o3YfTnphzcw7HfVg6C0JMHj7vGvblffWtw5M4G?=
 =?us-ascii?Q?hyQqBWZnCxxdZ9AfxmfTdgtdm6JqA2AIpBx788a5/GNeLf5hqUH6lDA8YDWJ?=
 =?us-ascii?Q?ucz0vZXzPsYAJYNsvgNxRBelYbjqPsm7UPFPtlZJcSceVIyGgVwmPgq1QQYz?=
 =?us-ascii?Q?B5Mpwr2+Cdo9P3NDtP2f/hTHPKtR99XdN625zloLxJXRBlEA+aBmGUdA2JP/?=
 =?us-ascii?Q?QsT+V8iuiMXbL6S79ML+4FNc?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lZRncpShFs2p7xQ+SVOklWumugfIeEpCdtgPuj7ZJGNzydHdgBq9kbJTV5xU?=
 =?us-ascii?Q?PzDhleiWTu1q8c+EN1DjfYzp2wMUHXSVp1a/j1iOFVx69+mmrjCt6MhuYm1V?=
 =?us-ascii?Q?u7qmeW2vKt7rJc7YiYvJpnrhAaxIm78D92irYXByvgiVfQeOuAiwE0ayow3Y?=
 =?us-ascii?Q?b8EYtDOd9vGcck2s5lbPGbievhk23jsk9SIHDXfZVHYV17PNvDVkwFm5qK+t?=
 =?us-ascii?Q?IKccSe6CmJ9p8c/5YJzSs+EBu6RSly6sEJqZL6ZLkZRfJOAOIygi21GouUmK?=
 =?us-ascii?Q?E5zQ0f/4RVS30ZesjrUxgskJ6k/GJfO+L1cIdEK5M/vHi/y8KID4M9ow5RlQ?=
 =?us-ascii?Q?vFv5jHaT7pe8E81xmWK/DSJiTRbX+mBK1GL3Y1gXKDVqvvxWzmwJRbqbcFxk?=
 =?us-ascii?Q?nF3geOY/j+MnfXiBCvtIWJRfw3tp3CouCDdHHxlH6iCbyKtXzuUTz1vOmJOg?=
 =?us-ascii?Q?EcW9sAj3ZZ5HlC4x/3FmfBhynTc+kCzfYsHNqluyqZSFlN0XXS/KbikcN8+r?=
 =?us-ascii?Q?fQD1oRtYykOuUtSn533N1KahncUARu44JYmZ/hrJJjFDSY4DHRK0SJqCTCwi?=
 =?us-ascii?Q?iOPPmMRlO4guyGzpBrrtVJum+3erdYn2tj9MUsr22rHpL7FyjCc7xZPl/JSM?=
 =?us-ascii?Q?yk1u7l5KzNKOuAXv0YUXeczjz78gH8F3quQa6mg4xqKUSe9WWGaRaknWsdnM?=
 =?us-ascii?Q?NS4gTWMimIC2/q2S+7xFp/P6tcHLWmz+87fSM4hh3L38E5qaGezpMFR7emvV?=
 =?us-ascii?Q?+kyYVWcwcx9hQPeJFAYhAZBdH7mvsoO5NOEl0QoS7LwIYHpQFtW3FWSVy7sS?=
 =?us-ascii?Q?eZH1RNRGih3oOj4h5DgImOu8xVHDXMtXnNvgytVWJiAJzMUz884IlGA/rUW2?=
 =?us-ascii?Q?qIj/bCcQi1SUVF2p+EUXXE5E5NFvIc1ta6j3QuGCBH4+Da73qQ0qQLpQLXjy?=
 =?us-ascii?Q?m6/ZRhmr1PcsaVvXWQpGyqTaEyA0p4CtlfGad+mWEEWpCtoqqp5/TZocvCeq?=
 =?us-ascii?Q?v9686qqADbNjb7dQ0yqscxXJ7MBwFbxMFsVl0gVX9278mZCeI2IKoVdqXpZv?=
 =?us-ascii?Q?uKe7dwcUO9byq3p+TdaxZtK/VaWZlqHIH3Tvsnktf49Cl6+NDcX03FPAWpa8?=
 =?us-ascii?Q?REBXlHyw79PorRlW/KGsxswDxwlnCnR3ypH0HJu+a6xZAH2em+RqrADKGB7o?=
 =?us-ascii?Q?EBa3Q8NOJHE2XTJzcVZRFhL7oZ4IBwG2VLg+GrPd0iFB9g7dH5+tUEU11Kw3?=
 =?us-ascii?Q?/HoGN0HcuqIQcXfnWsiO7/8OcSo/HqIFesn/rmrqEIeHjmg5ITSPNvOE0uyu?=
 =?us-ascii?Q?dVPyiXlFlf9vw5MswdWp/gDH403wmmfNt4SI5T5hiBXpUBevU9rFeU5kV/as?=
 =?us-ascii?Q?0ZR1xW095MrFOYigeXxK7SL9tiz3RByUCEzwkL11aKd+dL18f66W/dDczb+w?=
 =?us-ascii?Q?TB+10VWgfJFjFT2OBQMZHO8bxUle14UHaweqrG7Nouz1xGaIefvek42btVp5?=
 =?us-ascii?Q?OsNWAG19IvFSb7+tMBQ3p0APp9qMicSfs5/1XRF8H1/Atmg33lbPvp19njpl?=
 =?us-ascii?Q?ClCDxhBJEmdGG5EUKSY=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 528f80c1-cfb0-4d4c-cdc2-08dc849e4831
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 13:57:33.1850
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qKs/I+dn+sBy3Hbu+In+SvJsC49z7Ijl9cwCRcXCJ4euZ4nNpHx7KhwCMzcwgkXj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4068

--=_MailMate_01E4B2E9-59F6-41DB-96D2-C9FD75587B8B_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

+Luis and Pankaj, who are working on enable bs > ps in XFS and touch spli=
t_huge_page_to_list_to_order().


On 4 Jun 2024, at 6:52, Zi Yan wrote:

> On 4 Jun 2024, at 0:57, David Hildenbrand wrote:
>
>> On 04.06.24 07:47, xu.xin16@zte.com.cn wrote:
>>> From: Ran Xiaokai <ran.xiaokai@zte.com.cn>
>>>
>>> When I did a large folios split test, a WARNING
>>> "[ 5059.122759][  T166] Cannot split file folio to non-0 order"
>>> was triggered. But my test cases are only for anonmous folios.
>>> while mapping_large_folio_support() is only reasonable for page
>>> cache folios.
>>
>> Agreed.
>>
>> I wonder if mapping_large_folio_support() should either
>>
>> a) Complain if used for anon folios, so we can detect the wrong use mo=
re easily. (VM_WARN_ON_ONCE())
>
> This is much better.
>
>>
>> b) Return "true" for anonymous mappings, although that's more debatabl=
e.
>
> This might fix the warning here, but the function might get wrong uses =
easily.
>
>>
>>>
>>> In split_huge_page_to_list_to_order(), the folio passed to
>>> mapping_large_folio_support() maybe anonmous folio. The
>>> folio_test_anon() check is missing. So the split of the anonmous THP
>>> is failed. This is also the same for shmem_mapping(). We'd better add=

>>> a check for both. But the shmem_mapping() in __split_huge_page() is
>>> not involved, as for anonmous folios, the end parameter is set to -1,=
 so
>>> (head[i].index >=3D end) is always false. shmem_mapping() is not call=
ed.
>>>
>>> Using /sys/kernel/debug/split_huge_pages to verify this, with this
>>> patch, large anon THP is successfully split and the warning is ceased=
=2E
>>>
>>> Signed-off-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
>>> Cc: xu xin <xu.xin16@zte.com.cn>
>>> Cc: Yang Yang <yang.yang29@zte.com.cn>
>>> ---
>>>   mm/huge_memory.c | 38 ++++++++++++++++++++------------------
>>>   1 file changed, 20 insertions(+), 18 deletions(-)
>>>
>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>>> index 317de2afd371..4c9c7e5ea20c 100644
>>> --- a/mm/huge_memory.c
>>> +++ b/mm/huge_memory.c
>>> @@ -3009,31 +3009,33 @@ int split_huge_page_to_list_to_order(struct p=
age *page, struct list_head *list,
>>>   	if (new_order >=3D folio_order(folio))
>>>   		return -EINVAL;
>>>
>>> -	/* Cannot split anonymous THP to order-1 */
>>> -	if (new_order =3D=3D 1 && folio_test_anon(folio)) {
>>> -		VM_WARN_ONCE(1, "Cannot split to order-1 folio");
>>> -		return -EINVAL;
>>> -	}
>>> -
>>>   	if (new_order) {
>>>   		/* Only swapping a whole PMD-mapped folio is supported */
>>>   		if (folio_test_swapcache(folio))
>>>   			return -EINVAL;
>>> -		/* Split shmem folio to non-zero order not supported */
>>> -		if (shmem_mapping(folio->mapping)) {
>>> -			VM_WARN_ONCE(1,
>>> -				"Cannot split shmem folio to non-0 order");
>>> -			return -EINVAL;
>>> -		}
>>> -		/* No split if the file system does not support large folio */
>>> -		if (!mapping_large_folio_support(folio->mapping)) {
>>> -			VM_WARN_ONCE(1,
>>> -				"Cannot split file folio to non-0 order");
>>> -			return -EINVAL;
>>> +
>>> +		if (folio_test_anon(folio)) {
>>> +			/* Cannot split anonymous THP to order-1 */
>>> +			if (new_order =3D=3D 1) {
>>> +				VM_WARN_ONCE(1, "Cannot split to order-1 folio");
>>> +				return -EINVAL;
>>> +			}
>>> +		} else {
>>> +			/* Split shmem folio to non-zero order not supported */
>>> +			if (shmem_mapping(folio->mapping)) {
>>> +				VM_WARN_ONCE(1,
>>> +					"Cannot split shmem folio to non-0 order");
>>> +				return -EINVAL;
>>> +			}
>>> +			/* No split if the file system does not support large folio */
>>> +			if (!mapping_large_folio_support(folio->mapping)) {
>>> +				VM_WARN_ONCE(1,
>>> +					"Cannot split file folio to non-0 order");
>>> +				return -EINVAL;
>>> +			}
>>>   		}
>>>   	}
>>
>> What about the following sequence:
>>
>> if (folio_test_anon(folio)) {
>> 	if (new_order =3D=3D 1)
>> 		...
>> } else if (new_order) {
>> 	if (shmem_mapping(...))
>> 		...
>> 	...
>> }
>>
>> if (folio_test_swapcache(folio) && new_order)
>> 	return -EINVAL;
>>
>> Should result in less churn and reduce indentation level.
>
> Yeah, this looks better to me.
>
> Best Regards,
> Yan, Zi


Best Regards,
Yan, Zi

--=_MailMate_01E4B2E9-59F6-41DB-96D2-C9FD75587B8B_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAmZfHUgPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKZREP/2JcrAqmQ85b4R30JsfmWOihbYj0UMpv25ih
ZVDC+K4ceHYApboC2ijOIIQUE7lsmDWP1y5TlF1SivcRysn9wX3oSpaOUdqOTHRa
tWiRI5A/e1LqzQsXFaW6N+O+sayR+3i58pjyGbp05e/bqYnEXnwR6Hju+B4VuEse
YpwHPfyt0QR+CJ/pMRNOl06ZrmGP2eOUEFpZVRiZa7FO8xD0xbuNcB4Ze93m4X/R
WNtD8g8ThVGRMeaD+yU22at/i1b9yfcO0tKbRN7Jxenh1E4tarXqccPFWqwckB9l
sn2AgOn70tHnwr2AnxirLFFq7frKtkd3ef6gYyO+7OKmgYbVs04INQ3+TVQfOyRr
74QjVW/kmejoivWlzksYWKXfGOoCInmOqPnSXuahWnv5NH7muBUSqeOu31GU+Q6a
vTLkrMkg1F/lN9uEHK7hzI6W58J5BM55JmXIhWO00ETqOeKV6sQncizt9WN8tzm9
d94dp8SYptvRfdT24OoYlW8R5iqQA5yAJJzIIDSpEha3qi5+f7DMLiiEP/HLS7x3
907mAItKzqzHjLk9S5CPHxqdu70nfCzuDfJLu4LC2/tgrIidN/Zhi4oyBhBayXjO
eemcoI6YS2QqGllS/VPxuJTn0aZbuZls8U23Ul1N4SBgqAPRtITtSsSxlh4M1XWg
MHMGm+/T
=JihK
-----END PGP SIGNATURE-----

--=_MailMate_01E4B2E9-59F6-41DB-96D2-C9FD75587B8B_=--


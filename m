Return-Path: <linux-kernel+bounces-400112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C7849C091B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 15:42:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E941A1F23A77
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 14:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7245212EE1;
	Thu,  7 Nov 2024 14:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lUVzNHta"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2088.outbound.protection.outlook.com [40.107.237.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23BE5212657
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 14:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730990532; cv=fail; b=CmILnzdyGxuxH0lZtjiPiMB0j43g3DI9RfHzQXIOrqC21PL3vS0FTUQZXJzXMubOtDFGEehIyCIk0Yzg3LEAGtKCKrY2dK8MwgNSzwIdkpUp8uPU6IyHFt4LEE+n035iXfxwXC6YYuyUyo7gtcXO9zozcTSlyrFhI4qcEmURLZ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730990532; c=relaxed/simple;
	bh=wWZGXq7Dum448gVU5lSaKGJsvHU8PJm3cwWRMHfd4pk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mgkCi/suJoyuX1ylW++1Tazr+m2CNLlOMHOZDyPhDUJBXcS56Q/2Icobm5lMTMizfZsSB9d6DWRqNcf60xTLgxT06A7d6VUNrIgeZp8NLJLrjbgNfTMzjZ2Zr+MkMenG3vziaTHr4hWIvCUzu6Mt4ycSk1EqvHzh/KXXGJ092AI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lUVzNHta; arc=fail smtp.client-ip=40.107.237.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TQKeTHpAzxMxUdJdBG1gphimMDU3Fv7iygtBj3Avv2wyfVYswsuvJ093bxK0FuB5QE9QAoCZUMyER+BwRJZezxkh617sCDFQ+fP7pIl8EKVQykUGgQth27DM2KJdteEVk74Fq4/LNMDyGWB/hglEhAmqYIbzYVM0qeECMnLKVc3KgehLe/68Kq0k350RLHWB5OIQpqjr7atqEfZm1KSyNZQkYUYLLj/O+9yfFB4rmoaFf64t8DOWXm3M2aZbQ33SLK+h05KCDbeXyLFkh5xakTXGWXUSB32462P9yRW9LDNXkczOcsmoUWRIO27tzABXqv81n+pb3jDaW1JYTGwJSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2LT4JaIG7KT+jCds6vmRMfKDrvG7ettO1V9LWaopN2A=;
 b=wT4bEGu8i2rnj+OMrg0vbmFgmG73t4OOuBrERXpMNy/32Iu3IbGRZYqhDaSUK6+ERJSW+SA2On7TjSkdJ9J08jhPg4Ju+MIjRrlAhsn8nb42jSjQoDfczX6uE66sHomkZvGnXuexQFxP7Y1rwMOrIBZpKC70xlr1tPZvr4mIG4M7vgP8x5omAFzKt0xVJ9GG3dKc6MnmJUGK0DnK6hjuI8FumVN5P8pBtJab4/oB85J3fimv15ZT5WOI9rgkEkF8eLdDkcTUpKM5Xk6QTi4WHC0lwxwdb5VQJT0j8mWxjrV8hxCv3GCe+GMopwPvk0LyEqZTTMARyN2YLGPeg6XWwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2LT4JaIG7KT+jCds6vmRMfKDrvG7ettO1V9LWaopN2A=;
 b=lUVzNHtapnyfL7y/lmqYbCNdgVyhaHeIwURxMwuKf5SygUDX7OptX8UnG8Cz2MZmA3H0Nv0Vtp1cm4V1+EJdf0xSfnAMsUD4arK3vNg0rb0qh6KADTPQjqpmzwJOlEZ2/3zFsG36DdXj8tcw3N76E5o8pOQm2YoiMTGDHx7w3/Qqt5Om2fO9VoeK4owXH4/+yy6yjoSFACYXiCCKVrMFWCLO5CnrPQfsmzHwZmUW9PPBddXgRZFf6NYspchyGn7xZsQlTj7jQ6HllAn6ymwHjlwyEsjGydBo+9BW3NPCMytlZc10JzTqduXJptPnjcBp25jnlINcqUKyjTqaR8pzDg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 SN7PR12MB7129.namprd12.prod.outlook.com (2603:10b6:806:2a1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.28; Thu, 7 Nov
 2024 14:42:07 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%7]) with mapi id 15.20.8137.019; Thu, 7 Nov 2024
 14:42:07 +0000
From: Zi Yan <ziy@nvidia.com>
To: "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-mm@kvack.org,
 Ryan Roberts <ryan.roberts@arm.com>, Hugh Dickins <hughd@google.com>,
 David Hildenbrand <david@redhat.com>, Yang Shi <yang@os.amperecomputing.com>,
 Miaohe Lin <linmiaohe@huawei.com>, Kefeng Wang <wangkefeng.wang@huawei.com>,
 Yu Zhao <yuzhao@google.com>, John Hubbard <jhubbard@nvidia.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/6] mm/huge_memory: add two new (yet used) functions
 for folio_split()
Date: Thu, 07 Nov 2024 09:42:05 -0500
X-Mailer: MailMate (1.14r6065)
Message-ID: <49DF696C-DD2A-4545-B6C5-BC84F4331560@nvidia.com>
In-Reply-To: <yu5u6srhyixvnx66qvin3rk5p3ve4yxu7v6qj4ymma3fnbk4fg@yneglqtwpvyc>
References: <20241101150357.1752726-1-ziy@nvidia.com>
 <20241101150357.1752726-2-ziy@nvidia.com>
 <e6ppwz5t4p4kvir6eqzoto4y5fmdjdxdyvxvtw43ncly4l4ogr@7ruqsay6i2h2>
 <C9096636-C91B-42C0-A236-F3B7D9876489@nvidia.com>
 <yu5u6srhyixvnx66qvin3rk5p3ve4yxu7v6qj4ymma3fnbk4fg@yneglqtwpvyc>
Content-Type: multipart/signed;
 boundary="=_MailMate_2D18459E-204C-4194-9BD7-CA5E4577249E_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN0P221CA0014.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:52a::34) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|SN7PR12MB7129:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a02ed00-af5e-42a4-3aca-08dcff3a5a5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZQEVaQxZhmpQXoNPWRZdVWP3jYZVtLLxXzwABj82XiE8HQ3nHvTt2dsRMGtn?=
 =?us-ascii?Q?Yj65a0333O6QLZ3s5r2hURCMMbH0K12wtIBMK8rtTt8GBKmP5+tQi1qQcTaa?=
 =?us-ascii?Q?QAQ/R+gZ3V1yenmpCzArzrFXWRUTb7ooQSVHLsSi4fCHoA/hBYOPwQmEy7w/?=
 =?us-ascii?Q?iol/GvCIwrByAdtfmIg7rbVZ129x4u+n3KruGcFHkLqXykwS8dzQFMhDT8qS?=
 =?us-ascii?Q?2c+xi6dFECyVQzi2aSRlqrNkpsm4JtmZ/P32UL+GlTxLmtYoRzRavL3t9IJo?=
 =?us-ascii?Q?S4xC/MNc/NAq9oa8g27gIR3JMxwJ72/unSSnHs893VxCneKWHNlRen8YgzPj?=
 =?us-ascii?Q?tUs8UpkrjeQpn3cr3vmTwCvGY/dI0nsNEbrxPOUiYCs8abP+j9+VO7ywXgFa?=
 =?us-ascii?Q?ImTWQuRZpSPAFDiB8UX7hPueqs552eVxtKePO9pYbedDjgWUR6x1MWE0iUIO?=
 =?us-ascii?Q?uqCEVoVUGdDwPbpO3AwBjm0o/8FZKNOs0+BHx7C0fBO7opjjM6yOCAAqlZoa?=
 =?us-ascii?Q?7zvrhWTYA3zIsjNQZuvJPt2v8g9N2ib5ztXl7/53W8zoLeh7lnpnh+2/q2+n?=
 =?us-ascii?Q?m168BG4TWl4/yOOnW8EW1ak0hGX0Kfz01VRLM708CVxD71kXzQUWJ3f3nY0B?=
 =?us-ascii?Q?UcLc+/4pufdI31uStC1UhnVhH+4AMOximS6d5H1QNCNuvjcnZEI0S0Xv7lRf?=
 =?us-ascii?Q?nUHw98r+JYpZEnD4n1P0SX4I2/k5wxAlx9amQC2wKjIKuJVuP0iyCjDPKPSW?=
 =?us-ascii?Q?ksA6G3s8PxbJC4aMupS0evVFmEk06hgAcZNXfMbM21kbTJMyEG31WLrguSKJ?=
 =?us-ascii?Q?JKlfWdVBl/3arinzbwyEUF32oOAS2VIgTgXUzLhXBhu0DReY/YaUGkTfxpFv?=
 =?us-ascii?Q?TZkJuMRiIyWoZNdQCH10vEFu8qzW7A5UhLflu1avOls9EisJ4KkRNxjnKw32?=
 =?us-ascii?Q?fRDmubXAqzyXc5/DBPz/esD4mrUoN62HeaLVqzeNTe721Urc0j+sRTYoTPbd?=
 =?us-ascii?Q?NcxoSjT29aERqkD85xRWZw1tlpIuLbLzxdev29wqJl7MwGCiA577RZvxxqim?=
 =?us-ascii?Q?+okRD8QALuPcpKct/AbPduXJ1+pCPl/ihW9251rJcXmWwUynAKUxAJCCbpK+?=
 =?us-ascii?Q?UtKd4W70j1KGo7reh0a6jMGAd+BBxF46Y6NXi8QHIlBmNiTwmMFQt1VOSoLv?=
 =?us-ascii?Q?qNxe2yJTyxQ6kUjt4X2FcRhbuYpRMTUDzDUK2+6HJncBniy7Mt8YO/Fe7a5q?=
 =?us-ascii?Q?SeF2kJWEt/J3vwR6A0x2tvM2iFklSGS9PIOQAcdjCzM0UoN6T/jtqqs5ETDF?=
 =?us-ascii?Q?fkhg8mqwoMp/3/QfeWbUVOi1?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zMVy1F9ASyf9rS1Gc5OWhREaWRxHlGvnNHtsKnF8IrlRHQXsUUTYFvjgpfsr?=
 =?us-ascii?Q?b02FAQ3qJp/HCUs2qZw8CJLyrdus4GEZaha3G1P1iIRH4bjBuV9kNpJ5OX8x?=
 =?us-ascii?Q?yOWde0dwiAAggLm85tIarkjZ6zt4JyWTxQvumCQKcmJ493hR1LVoETGHfwfY?=
 =?us-ascii?Q?uke/VYtnmanj5MOHs4HPeJ9H26z8Ge40iLOUELDB6ykepqSR6GUq1AiXzVYE?=
 =?us-ascii?Q?sPja3WQiP+jzdUAM+UabPxp8QtG0fDnJk03ttRuoMIly/dr0lngiBe/CU1p1?=
 =?us-ascii?Q?UoNTppwYx6CoMeKAOXeuD7aU8nJfg4m+cy6tvKDvQxBxsDGsQRIls9hkDIcq?=
 =?us-ascii?Q?+ssGVdSw1k2yrYB5ts01IdgHsUK4TqVC13rdl9fUxFaxNTT87UZEMXflbM8c?=
 =?us-ascii?Q?qAehcXXeM7EBnUXDeO/JXFbUMjvuie0bIkrFgyxqGMcJix8S7SOwV9jI21jQ?=
 =?us-ascii?Q?YsJAGi/lsb9Rr9iAOXSs4le9qom5pMU1Ve5y8AKCkmMW266A1ujXMpLd9Z0U?=
 =?us-ascii?Q?n7PREK5zlJZAax6+a7pQwpxk2fNHJcrVplXY0osMOUzyJrWnhdXZSXGNm4bN?=
 =?us-ascii?Q?Tk8FuW8Ml005OHgbEuHqBW2D0pj7LWk6W2AdLB874hVYUceWd2jGrYWyHURh?=
 =?us-ascii?Q?MztUiGfm47a2GHWVMJ0ZUSDwwg3bvPtjgbqr9mVZ4KRofA4HU0/v2wprJHAh?=
 =?us-ascii?Q?Q8eBvY8CowiyzyvOTZVZGcAhL82O+KwHbk8q5OZEsVXbILjBBAmJ3HZ03rCO?=
 =?us-ascii?Q?PvdrkBTv8dRkUj0fo8jbQ1HPWymkAsarNB8s6YNqn4S1gI2QdTe3VNJkdTVU?=
 =?us-ascii?Q?Qv4phSd/nB28GqrM6Xw0MqH2NsH6K94UJjTkyhzQg5fy74V2P54l1a+NCr/h?=
 =?us-ascii?Q?lAwAPQQBL7XbBpAMAr9cCWAnC1KJDfXzNLZeBH8UKTS7fADjDiltD0/7LzSM?=
 =?us-ascii?Q?vjd4jtDeScMBl4u8AMEp3IWxsfnpaE2uGvXoUFM10DBWvK/4gFM0sQdqtguu?=
 =?us-ascii?Q?fw0KLM7qIupC+5lgsWJoD/jDkv1fDfbC1P+cFOoKPouPtCgL2OPpL9VdH/uq?=
 =?us-ascii?Q?zFj/S/o7WVqtNbXNFF5iMxXAWaLFqdm1cv9vM27dSj3xyqHhR2qaQCXCRaDE?=
 =?us-ascii?Q?y3Ak3pC2LhcuR4WvoRJwRgR1GrE8jq3FbuWUOvLl2elAlgeTduga0g2wF95y?=
 =?us-ascii?Q?rV1CF9YWUQmJSshKRuJ9DecyhinRVatqDB4qDWqt6wwRIMEjsHvfRzkMeuRp?=
 =?us-ascii?Q?gUEpIw+/CdnL/WWISG00qC7jXn6pDMBxqUSeNEsqpXEaNzF91e7EHdva03N/?=
 =?us-ascii?Q?ekVDfXzv6drGk/xG0I+s+TzZAJJJmRQwnJp6BSuvmBOhT1bwjl3SP6W/jDp2?=
 =?us-ascii?Q?KrFP0PLlIkbRvOwO19dpPRVF0HSb7rZ28Sas46WIb6OBRsxVN5co4nZ8mT+j?=
 =?us-ascii?Q?7C6vSQRykhF+XVY8EVXlf7oO4SouKhFF18/cpW52YWWvbm3umPnw+HOnM/nG?=
 =?us-ascii?Q?dOhwlG2LSXc5FDCupOCPX4jzNVrfSF8UozqRCqo4VMiiCmNJ887s8w4Z7n0g?=
 =?us-ascii?Q?OBRalJqeN3sPDfMtdDk=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a02ed00-af5e-42a4-3aca-08dcff3a5a5c
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 14:42:07.0436
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3dW7kqjP/ylxbq2dy1H0UpiTGEydXD1PL+By1t9gM27HvTU6frh7vO88wSSlqgJk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7129

--=_MailMate_2D18459E-204C-4194-9BD7-CA5E4577249E_=
Content-Type: text/plain

On 7 Nov 2024, at 9:01, Kirill A . Shutemov wrote:

> On Wed, Nov 06, 2024 at 05:06:32PM -0500, Zi Yan wrote:
>>>> +		} else {
>>>> +			if (PageHead(head))
>>>> +				ClearPageCompound(head);
>>>
>>> Huh? You only have to test for PageHead() because it is inside the loop.
>>> It has to be done after loop is done.
>>
>> You are right, will remove this and add the code below after the loop.
>>
>> if (!new_order && PageHead(&folio->page))
>> 	ClearPageCompound(&folio->page);
>
> PageHead(&forlio->page) is always true, isn't it?

Yes. Will remove that if part. Thank you for pointing this out.

>
>>>> +	if (folio_test_anon(folio) && folio_test_swapcache(folio)) {
>>>> +		if (!uniform_split)
>>>> +			return -EINVAL;
>>>
>>> Why this limitation?
>>
>> I am not closely following the status of mTHP support in swap. If it
>> is supported, this can be removed. Right now, split_huge_page_to_list_to_order()
>> only allows to split a swapcache folio to order 0[1].
>>
>> [1] https://elixir.bootlin.com/linux/v6.12-rc6/source/mm/huge_memory.c#L3397
>
> It would be nice to clarify this or at least add a comment.

Sure. Will add a comment about it.

--
Best Regards,
Yan, Zi

--=_MailMate_2D18459E-204C-4194-9BD7-CA5E4577249E_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmcs0b0PHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUiVQP/j6krIgvLcp9ROXZcHVLBQcBNzzkYaE54wmY
ebX3MT0unCgeGW0zTOVrtCnlW8Wuwitzog9gCpAd6iIV3UOtquQjISkFj55bxmso
k3sE4JMglvOjQk8vflsTmgYWrx6MvJzshqSwRiOssurm24zoTi2I7COLVHM89Wbe
+HFEbGf+HFXbkap+3ohUPn1k3eV8ehGTmCxNY4a8YNYbNxoqE9K+x5incpcg7VJ9
211qUjKI/GH+PL+ZrCbhgBbv1xVXPCTCyaLSa2//Ywaf50XgVoSAzaRmjOArRA1X
EKQrzvj9+ftEUQ65yHPOlRuaBwqQjWSVQY4RPauKqP6tFEBpH2ivCgGiQ8oeyrbj
MeR82yilY1U687Vgi6yPca+HUyEFl8ziwcXHllhAgneMN1B07EdRvoWfJPgxEkK6
sNY+5pt9d6bWyDur+lA/UZ0wE+cB9eYf5nYSstaoOBP7X9wMUBd6oIl3BKME3Fip
ccEqxVsJs/d0NintjtMC25KUi37N8HtHIrkSFjo2hJKHUQjuTsPIob57wExmyvnZ
kO0dteuT5rhkmVnvtZ/ytkJemmWTYfUeDcCRconow6Tp9GT6cgz6SEqWyuHXmljx
Hp/g1krnO4vkwGfJ36aaw+g6Zj32mwmf3NeYtnKwEwrxmfe/DxkZiDSEsX6vLM65
b73kGmzi
=t6eV
-----END PGP SIGNATURE-----

--=_MailMate_2D18459E-204C-4194-9BD7-CA5E4577249E_=--


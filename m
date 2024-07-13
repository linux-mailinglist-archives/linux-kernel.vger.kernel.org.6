Return-Path: <linux-kernel+bounces-251285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D4ABC9302FD
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 03:19:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E652B2392A
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 01:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 077C8DF53;
	Sat, 13 Jul 2024 01:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dUxvGXro"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2045.outbound.protection.outlook.com [40.107.93.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289BF168B7
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jul 2024 01:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720833532; cv=fail; b=E91FWLYpD19cy0fQsUZJB0n0aoVfgVz1P/OSasaZFhezjHD5a6ELNK3pf9aXqKakP3eObgTafkAiPVoMSMEE7pcotpEhZ328Nqov/ZSZj5lqk3dbiwQeyCIJR1Gq6Oduap0TIiYDgmgEdEnb9uoH1cL8DSxDmEGaI4LvEs2DpgY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720833532; c=relaxed/simple;
	bh=OFjsom2zSr9oIevLCiEGVSdMK87kAnyyv7jR/9cECRA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=K+/YnoCoEwRgFt1ZloatQL7KbhBabr00s+U481jV9YpdHB8xs44AD2ZOyP8W+47FF0Ctk2Jwd30nhNFlYlBZhj7mYRGIyCtFK8oANaR/puGhTUUDjlCOqrsygfyA6I6TkbhIeB6Ji8rC/4D6AqPxXn0TxEkpjPdONRPPcpfvEhQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dUxvGXro; arc=fail smtp.client-ip=40.107.93.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EqSu3UveuZT5mHupfm0SEQIgRTs+7pSvHtqXiKZVtKtvyPWnnWsC2cGkMw4UYdj8nctfU4OEYx9OTPr/XRfZtU0n8QS2HXC0LfPW7FE3xmGqhATrqZudaOv+Vt4IcIHCgJuBAv5Hf7+S8FsDvmNkHL/+qATFdzVQJlngow2VJzCblANPoBPfu9os4/rsh7DqTplPCOOltQx9ALfsIWhvIPaJ9ZsOlIqQuTcSPuLjq433jNEv8myv80h+VSISX0rOKNL2Z82BHVnfvBwGrOMZSdFVWz2521vr8JarzQDJKTe5ONEfvkIseS3J5cVsjk/RLY3MbE5EIilyFOVjpgrttA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xrlr8sb7U+Wv4hZ/q2t3ps4qpeVCdpyDkbBM5rEsynY=;
 b=CZk6nsfFX5VNcpXRf/POMpqcB/jn/B0wvpwEog4eQA6ZLua1NmLaeuevyX9q4Q3VsPgQvA4swcLTw9PQAHFOWGQZo3BqO7Q051WlnFsQjWjmfWkYRX+Kww16mtvLd/j6EoRWWy8dqCsJH9CoRHv1D5Zom4G7W0eRth15PiSwmowvpfj29i7/du/hfUowRid60yz4MFvmrCZL4QHMphHpCwb8o1dJfjU1cToErsp/1NMVd1oc+/lbFD/7L0pX4VB3nRq35XGpU7cAtpoqoy66AUASoQsNeFFDaIa3/awfY0JbWMv52XNb1SQY5B3FGeBFv4cIhuyGfEfmhekZKf8tiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xrlr8sb7U+Wv4hZ/q2t3ps4qpeVCdpyDkbBM5rEsynY=;
 b=dUxvGXro0Hvz7Ty6D68hj/FHWUn6wasKnCz4s0kZOUq58534A6Jl7FvdUuquLWd4x7kvTtDD/vulhCj86yD9kIozjxJeBTUeGUV+KAD/5RH+DGLo/3x2RomD9ib7Lq7Ud2rBOCns857UCFZBltmRog4Q1vFL18zvRdNguz0iyqLiqHciGXQz5dQOZTM/6+3WDHBm2Qr8dgNJv69IQoMDnj+djdiQryPYLB1SnGrvuGYBBcNKjJ5WZZZ/P85VPbIWbohNjymaNZkUs5ufGrR9lx3UW3nqAsUNoXE+TmlpvKzgX0SCXPPMuUcnPdcHoUZBaQiPoIwElEb1jnvxBzcV3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 SA1PR12MB8918.namprd12.prod.outlook.com (2603:10b6:806:386::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.23; Sat, 13 Jul
 2024 01:18:47 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f018:13a9:e165:6b7e]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f018:13a9:e165:6b7e%4]) with mapi id 15.20.7762.020; Sat, 13 Jul 2024
 01:18:46 +0000
From: Zi Yan <ziy@nvidia.com>
To: David Hildenbrand <david@redhat.com>
Cc: "Huang, Ying" <ying.huang@intel.com>, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/3] memory tiering: read last_cpupid correctly in
 do_huge_pmd_numa_page()
Date: Fri, 12 Jul 2024 21:18:43 -0400
X-Mailer: MailMate (1.14r6038)
Message-ID: <65FBE843-2FEA-400B-9FFA-150E038F7BDA@nvidia.com>
In-Reply-To: <b62bbc37-ca90-4033-9fca-1cd11015211c@redhat.com>
References: <20240712024455.163543-1-zi.yan@sent.com>
 <20240712024455.163543-2-zi.yan@sent.com>
 <b62bbc37-ca90-4033-9fca-1cd11015211c@redhat.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_A4C0C62C-1D5D-40E2-B0B5-77F9BA2FD325_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR19CA0002.namprd19.prod.outlook.com
 (2603:10b6:208:178::15) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|SA1PR12MB8918:EE_
X-MS-Office365-Filtering-Correlation-Id: a7a6eb83-7805-48c1-283e-08dca2d9be7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?C3UCun044dhjJFgiVeo7thmzuiUt4Nfzz5WQLzkzzR5bwHAoYvbSMdycAXqQ?=
 =?us-ascii?Q?dGPvjyQIakEl2ZNcrLk2a+tMtkyqyr9RkDlvE5TU35hvRJ+iHnlJaotLJ31r?=
 =?us-ascii?Q?7zetriELYCwBf6+eNuzTkVFwVq7kjUTgQ6UBzMMKR82t48B4G8kTLh9jiaKT?=
 =?us-ascii?Q?EbPE9r+8RRqb91+3qmPD0qnHuFO5jfvpvMuvbeaxL2/igduWXH4VwbvEkiRp?=
 =?us-ascii?Q?pK+jh67pj6WgOEmElQ62pmZNcjbbWcBeWmUTNp48reYE/XuXIXVYNZfrMe5j?=
 =?us-ascii?Q?O5LdX5a83JYVXLZ1UZn740UcujenLDXFRZxzPsw72VLP0EJxmEK1Lnc9lDhs?=
 =?us-ascii?Q?VeMN3knYlDnyBzVPv6tmNVlOoo7GJrUXI4NrnEd/14tIl/ZSx/lLokBWtDNE?=
 =?us-ascii?Q?CDz0nxRFXMq1QbOfFw2AKXaZM+bb3WoScTCIggGsmv1p6KkuLVyPjCmYryjY?=
 =?us-ascii?Q?aI32XHei+UsTXhoU42dqhhbqWLtitS9obN3RYapbY/1VP/TNtmRWZW+Bx6qV?=
 =?us-ascii?Q?NQ24QU3Q0NAHijdq4C3iVxyVPSGlPOxHh5dAiqi81K4P2sAjuoDCHqoFiu0/?=
 =?us-ascii?Q?PrWFwVwrDDQazBXOi/2bWzfotpml0Y5yjse37RGJhGBDlMmHZ95wqEqUG2gg?=
 =?us-ascii?Q?42LC7gfzPZPTl5d+f46HThz+K6cwb4g9daJX+y5pCCmuHpet5rC5SJ06A0pi?=
 =?us-ascii?Q?dXOjnZTpa+qvpyY3cj+3NdVLvSwhEadjtVkue0xtwYoa8aXMJHemqCCr55Ts?=
 =?us-ascii?Q?eUX3v7KLCnvLvvER6cV8CX9ivcklHX2Zl7NCvQrR0yCktU5dp/2+9KHrxBm4?=
 =?us-ascii?Q?e1+4lXISgK3rsaaWZMDpkwV7rsYeqx9FPMjJwbEGkLI4zmM1ozKVk3nCXGr0?=
 =?us-ascii?Q?EiPEQU2JTZwrJorJ9UlKIY6GEd+6w0lV/DS/pfcGSpuLcBnNVoVXPWh8fjE5?=
 =?us-ascii?Q?JzoyU/rnQdaCZ9YysJL/sDfw9qT9I7fhrjjr+rw3rpAfS72Ec+mCSLgbqm/4?=
 =?us-ascii?Q?qzVuLT3C49b2w4ZTUu5f27G47jQdz4GHLtOhQ/nL4fr1oDHkSvL8VBf6k9V1?=
 =?us-ascii?Q?udSzgf/WI4E88YclWMjrDRnoEPe3S//N+Say/RTrCovkrkbkWFPfrKA6W2eo?=
 =?us-ascii?Q?30tY+mszHOkvZ55rNOy9rqZ6DTavhm+nKOmUWpodPknWgJo4sqYXa+Qy7R8I?=
 =?us-ascii?Q?SZK2Tml/v35+Fd4V/ltupLSCiD5XBWnFKXXxIwVWIUJgNxOyjHYX4ewhyoDc?=
 =?us-ascii?Q?sxpIR+IoV7Jj88Uaxim0gfG/i8fs767N8B5uXwhoNraHQj5RsYCrflWMDxq9?=
 =?us-ascii?Q?YU/azi6rI6qe0zfK1uMu65F29KYfevuPZy5JrS1MN4XbEWd+eD7zSUx0O4la?=
 =?us-ascii?Q?h+PHWVE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?G0m55cY7EisvIUl2qlnNZEydY2BFGfM3XKqiAdd1lMw2tePW3fK1g+VavN8C?=
 =?us-ascii?Q?yGeA1sA8Hdmp1SKK9D3IWCLc+pk04OEgbie74gR0P2W6u8ag5dlp0k5CXrM0?=
 =?us-ascii?Q?LzrMAhuyzmSaZhIe/r5LgRBHBF/ua9F6dgZzCk2QmrJaolodfkidB9pDKzfR?=
 =?us-ascii?Q?P3cIjYUS8M0WSb0szVIGT/Gug9kU9gJ4TK3Jd8dUD2t6iKHQphK1t9Sp8wO/?=
 =?us-ascii?Q?0v/UV9wCcQUE9lPSWVPg3i5UdeO35BRQAMhtrK6ncVaKiD1i69kS80v0SWyJ?=
 =?us-ascii?Q?sb/t461OLHoeoz1qrwZt2wMOiZqIC/RlAVDKEWbUVBCx91JZYOuMCr4VQRsq?=
 =?us-ascii?Q?q0pNskT+Tt4GPwub0of+RIHo6Rlemjtq68yxNdGfAFf/+Ztv4Uybb07DtFet?=
 =?us-ascii?Q?1ryMr7esOB1PLf59Fwia4CUOcYs4uOXyVzgIW4LiZCDmwvr9NOEyUi9wEbVp?=
 =?us-ascii?Q?+y05EqJtiPNH2C9vh5X3guIozuF3GUN+dgBsSuY+RqwPWbjszXuR7BZqITmi?=
 =?us-ascii?Q?yLFH0CA4gyFrDUGxiqAhOnTSxt8B9byLm4O/uT+wxl+JJ58dpwexYm170QWM?=
 =?us-ascii?Q?ohCOpcVLuQlaXu5eqVnKzLRtMIYkp8bkI/bMS1J6nofM+49o23792Bt4dLeH?=
 =?us-ascii?Q?zMCC05ya/hmwBAyoHrBh+K/wlbIU2n4MtoCk/u4J1Qgewjer8E35OJF/hQL6?=
 =?us-ascii?Q?TTNkjE8Y/2DSACdtFfjUeVdOf4d6kdABFduKUQwd3ImlvhB7OiZiOeGEcCme?=
 =?us-ascii?Q?p5Y7J9CVeGVTgbhTGKuGgzKUfdft3eMupXOcDJ0qXEoqsEBeXHK/lAZ/ZmlX?=
 =?us-ascii?Q?NmSg4m3bSMSCX+EdJzS2Dy+LOdNqtiQUJ+zNRhsUNXfva3gKKLCE1Om/AfHc?=
 =?us-ascii?Q?8wxe+HZXKpJMvcgPvxEHg78T+41Sy1kx30C9Meq7g+77uS8Ot5r4/HCeWIFv?=
 =?us-ascii?Q?qxeGT5g2rRUWwMs6Ad6fgS9DnuTDOfP9C37Od9tWZ3SOF8kj9ma5SbPyh6wP?=
 =?us-ascii?Q?eJO4PhcFigJoNOSDZo9DQVnvN7cM9UMnDWMI4+zqyBIsx3ydtVTVlW9GxSoZ?=
 =?us-ascii?Q?SDfBuf2b0ErwZXJpqruhjcsjYet4PauyYPPjboZHqeSRDqG8IethK1oVg2Ff?=
 =?us-ascii?Q?aFqOzSguu45W+aeXusfY+vMsAZIqoGgT/C0e8H1MHinvvxD92W6oZlgXisFM?=
 =?us-ascii?Q?QQx4BOQMiH5st/TZGaICIbO34ApHV77guqDQK0s7NzOPVZANSNKcRL66Xf+t?=
 =?us-ascii?Q?pBvezN0tonoOFKdVT4cb0c0Bu8ktWOxB2WbHa37bnRHvduIJ8IwifHO5QCDk?=
 =?us-ascii?Q?OtNHFm2fyXO9k8GnjN4AXEQBVcLlA0S6Vf3OW7GC6hKbX82Nx/CkLInv8ZNg?=
 =?us-ascii?Q?r+bPctJW74+I97Z9h395f4FkB6ttVUP4dY24uaIX11/vc3D1QaXsWBX6hEV6?=
 =?us-ascii?Q?hy4ulv9Vu7Q6iZtK6xWBXBRd5NIGjrO5u8xqFm4P9Q1JfFHmIVMjarCFEBUk?=
 =?us-ascii?Q?5U0YE7/N91XKbbqn/nzHAvg4xhwGrDeaEKWOcw/y92hTnln22GrAzfevehVh?=
 =?us-ascii?Q?lcK+uI8kvP+g2zTieP8=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7a6eb83-7805-48c1-283e-08dca2d9be7d
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2024 01:18:46.8234
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NjCi7AohxCWJ8+AFSn4msk2soQcLNpwwYldqnkdAcNTeJHqPksNaRBDmo6x4JqsV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8918

--=_MailMate_A4C0C62C-1D5D-40E2-B0B5-77F9BA2FD325_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 12 Jul 2024, at 21:13, David Hildenbrand wrote:

> On 12.07.24 04:44, Zi Yan wrote:
>> From: Zi Yan <ziy@nvidia.com>
>>
>> last_cpupid is only available when memory tiering is off or the folio
>> is in toptier node. Complete the check to read last_cpupid when it is
>> available.
>>
>> Before the fix, the default last_cpupid will be used even if memory
>> tiering mode is turned off at runtime instead of the actual value. Thi=
s
>> can prevent task_numa_fault() from getting right numa fault stats, but=

>> should not cause any crash. User might see performance changes after t=
he
>> fix.
>>
>> Fixes: 33024536bafd ("memory tiering: hot page selection with hint pag=
e fault latency")
>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>> ---
>>   mm/huge_memory.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index d7c84480f1a4..07d9dde4ca33 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -1705,7 +1705,8 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault=
 *vmf)
>>   	 * For memory tiering mode, cpupid of slow memory page is used
>>   	 * to record page access time.  So use default value.
>>   	 */
>> -	if (node_is_toptier(nid))
>> +	if (!(sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING) ||=

>> +	    node_is_toptier(nid))
>>   		last_cpupid =3D folio_last_cpupid(folio);
>>   	target_nid =3D numa_migrate_prep(folio, vmf, haddr, nid, &flags);
>>   	if (target_nid =3D=3D NUMA_NO_NODE)
>
> Reported-by: ...

Reported-by: David Hildenbrand <david@redhat.com>

I suppose your email[1] reports the issue based on code inspection.

> Closes: ...

Closes: https://lore.kernel.org/linux-mm/9af34a6b-ca56-4a64-8aa6-ade65f10=
9288@redhat.com/

Will add them in the next version.

>
> If it applies ;)
>
> Acked-by: David Hildenbrand <david@redhat.com>

Thanks.


[1] https://lore.kernel.org/linux-mm/9af34a6b-ca56-4a64-8aa6-ade65f109288=
@redhat.com/

--
Best Regards,
Yan, Zi

--=_MailMate_A4C0C62C-1D5D-40E2-B0B5-77F9BA2FD325_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmaR1fMPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUEFQQAJIoYslc347mono4ctuZFyO+fZp/M6RY3GnB
p4JPbILVqd26EaQhbO2UfHrWOhgqKOfMGhsEQq4dko1t9+M42wFsxvL+/2TtApiO
xUZ0/fyxJJYoaQux8xRBEzllqKDFSjowO1fEPaboBhWdci7XaQWJfhaqouDIw50r
LjYDstVu3j+CSR+SArVrgqIucB5rXs+0/qET90KR49Uqv7+fzEIkP+aTmk5vA83I
vCxG5U/aHkKtxkQucQPCcNSraEZriiNv42Jh3N1XqOidGh/fpFHkRC59yhcJ1cpg
tL4uQ7WasXM0WIw30r1VihAzfQO6xeUthUkCVs5er6BZzAGfSnxKHjNjOMt9Asvp
lneIQYachbtwynsVqFGLSvszjnW4XTseI38xPHfKVtyW7M13sw0VXQw2HLpBZTo2
3mPlOQIo1B+GzsaCR1ierFC3xjAZ6hTVfWHBuC3GvVX7kkDksRbtwmiFm2+dcisV
CVoKZrQs/jX344MWQ1r7DDVvECIvAz4j9jT99ZibnP7OXla/QHchJ1w75ltURvP/
eYnT8CRml8V2nLXz74hcOLB9bqRAlx6J/fQrYK3duhmnCnUJhUi5cyLByAjayjPE
NKZ0isCAvB8Ty4tYZ8dUq/1aRaRJVNrbsrFIFtR/OAh2e8FAkEujwRxECuMaJNpT
ruGqZWLW
=nOPw
-----END PGP SIGNATURE-----

--=_MailMate_A4C0C62C-1D5D-40E2-B0B5-77F9BA2FD325_=--


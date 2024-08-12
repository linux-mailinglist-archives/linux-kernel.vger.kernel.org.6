Return-Path: <linux-kernel+bounces-282727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A2DF94E7F9
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 09:41:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE3E028409A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 07:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AED815B0E2;
	Mon, 12 Aug 2024 07:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oM43PCZe"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2044.outbound.protection.outlook.com [40.107.94.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2C71474D3
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 07:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723448488; cv=fail; b=dNqdjQmMSk+Hhc7sMUElKHB3Civ1Z0v/YqwLRVuoO3LTULpDRAi/Z7C2dcStk8cOzcFBbK2PVw+S/7lAH+Sd6dIQUEVBv+6E8STSx1AvuEf5XWLpsR0MsNZX5X8IZ+kPQQE/UZ7KXfEAHsnwN5YgUt86yVzS30LCwOACBWWEN6g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723448488; c=relaxed/simple;
	bh=gZtIeS0Shq9oNy4mTVtOtsyGBcLBi5SrHY1aDK6v5zw=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 Content-Type:MIME-Version; b=EgsNN3XgOew5Iazu0nZ5r1dQdssdDH19t2d/b7+uaQXd4KXF+w3sCqWNExYVwJajnCijVibpjyWJKKDJyXTEMWUi+UTHZ4V2ZR+7uQ+37/AfsvACUHQUoa0uarMxe6/A1DRR4+nCawpnRA1K+WEKdHGyhSVb5KljE2jDRgTpkYg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oM43PCZe; arc=fail smtp.client-ip=40.107.94.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WU/W58F7d2plIJkpVeqeoE4X4C09UEXnH3ze+HW8Zw1EzDTQO35W7MJmFX1Ok2HanQDBWDsC9rv5ocmP6wylJ3cAJCSxS7xRQH+8VPP0jvkbGbzz50oxPyKKwHrwklWZEfXpB7qxc7lPIBFxL4rg/fKkvINCxq8RslKrzuEUXTTldCNM5yjaeLXLFjiqDv3EkO60ZKUxv03ov+IYJzbWFcocUwA1B/UIU/a4HT4TBKJQhzDGkNpWRXH0mgRmKSYluBiiRdzNBEEXv4BQePzSOaZJEUycQqUdtDo0aGtke0zaIKdmGawJTZ2ROKbOyQ82KCGJ/tlkVzkXavGArwffKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cDvAH+XQChKr368lRPvbYweEKu90NVqPaZWamve6WVY=;
 b=f6SmkdZ0J/Pnb1LcbOC0t3FdFhdb3akPcafDvPTLZV1yJHSqF4FloteFJW+Dwph8T2SxaaVJ0qecidEu3tHpEe4YjJaaoGOPu8lBltnPKOTh+rv/e5/wqy4IOT3T0wu/CnZ1ESHymTw4HC2cmeJF9ZgA/sorOyV5p2Ub8lWTlR9nOlMrEx+/YDSvXmrKFnzGBHW7oJOlGxF19E/pCgTgkjKxKmAzeZFUlGRH1EdUef9ufRlT48MvTMkkhwZHKT5gtqERruV5uziEQyFLb5CMZkLc6JMG91DRdHStBlZlDF79IbO79JnHNDIDXVeusSQdRPB5GnwFlyT1CzucZlMO4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cDvAH+XQChKr368lRPvbYweEKu90NVqPaZWamve6WVY=;
 b=oM43PCZedX8JwXNM5aFT2Y+uIqCMrYftNcthmc1kDvmCRR+nPwdYoYCfoO8R2aLHpbw4N8VsxyCGEs04ppoEzJppaAM+f2kVPBX6wbd/vQ5daZFfo71bnpFRYQ+vXGlHHopg267TgkmRljLXRs+mPZALJ6ahE5a8cIBiJCXDdhTDwQfqZiY7IIbxvY1rdaKSmFA6ibknrSzHlQ70d9/5+K67rp8BX7f/K9/CQuE9mxQJxeWLiffHq4syCto7xgj7GLg6QtK4aZkxETQWrz4MpVJpl1EHfXdUUaoMCPrllOCSmzZF0SIvX+eG/Lgu7ynmdJDfEaWMwCEJsIwIC69SUg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 MN0PR12MB5714.namprd12.prod.outlook.com (2603:10b6:208:371::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.22; Mon, 12 Aug 2024 07:41:22 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%2]) with mapi id 15.20.7849.019; Mon, 12 Aug 2024
 07:41:22 +0000
References: <20230810100011.14552-1-max8rr8@gmail.com> <87le17yu5y.ffs@tglx>
 <66b4eb2a62f6_c1448294b0@dwillia2-xfh.jf.intel.com.notmuch>
 <877ccryor7.ffs@tglx>
 <66b4f305eb227_c144829443@dwillia2-xfh.jf.intel.com.notmuch>
 <66b4f4a522508_c1448294f2@dwillia2-xfh.jf.intel.com.notmuch>
 <87zfpmyhvr.ffs@tglx>
 <66b523ac448e2_c1448294ec@dwillia2-xfh.jf.intel.com.notmuch>
 <87seve4e37.fsf@nvdebian.thelocal>
 <66b59314b3d4_c1448294d3@dwillia2-xfh.jf.intel.com.notmuch>
 <87zfpks23v.ffs@tglx>
User-agent: mu4e 1.10.8; emacs 29.1
From: Alistair Popple <apopple@nvidia.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Dan Williams <dan.j.williams@intel.com>, dave.hansen@linux.intel.com,
 luto@kernel.org, peterz@infradead.org, max8rr8@gmail.com,
 linux-kernel@vger.kernel.org, x86@kernel.org, jhubbard@nvidia.com, Kees
 Cook <keescook@chromium.org>
Subject: Re: [PATCH 1/1] x86/ioremap: Use is_vmalloc_addr in iounmap
Date: Mon, 12 Aug 2024 17:41:52 +1000
In-reply-to: <87zfpks23v.ffs@tglx>
Message-ID: <87o75y428z.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: SY5P300CA0006.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:1fb::15) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|MN0PR12MB5714:EE_
X-MS-Office365-Filtering-Correlation-Id: 9dd4a45d-d57e-4c44-e277-08dcbaa2296b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?K8oysvCkC1zeEAPJjJVfLMhbsW9PJ1vV9ru2EPsAj2ujPFzijGt3jP0HmDAK?=
 =?us-ascii?Q?bIsRaH8/9z05NNFU6XgYVu69hOpXuuVQCO5A4blotxPInR4cgGPn3vcjPG1E?=
 =?us-ascii?Q?OyiBsugtFRqD0bShDb7Ns24N44gOGfstA5OUl+wSM5WFNTXrpjkEcFgr4hfb?=
 =?us-ascii?Q?FkwQPKLk5FeVUDN1FxM/o6LSBx3QnAKFUqRzIKKl4NxoFYsknz0nnmPqM8Fs?=
 =?us-ascii?Q?RWK256qKjJhrvWasjEyt6BnyizKA9OWQYNnz2AFXKXmSajo4OKImkBWXi3HQ?=
 =?us-ascii?Q?ajyPfwDZmP9LsyEaHZmgs1kw9XXd7OwB0RhPwoRCIUs5K3oRTPOI87V2OP3c?=
 =?us-ascii?Q?7Rnjz31n83kyihTGmDocCNg3FH+sMpm8+u85SchiEzMrB8KbsJ0MFppvSxFj?=
 =?us-ascii?Q?vJUpSME6sXheeFd9w69/X0WZ7PLF795unDh/u1m1GE2pjuM2Mht3JyQ/zGQS?=
 =?us-ascii?Q?ggo5IVPPDzUJumhFHceGJ4Xs52G+gQyDmtif2TQcULQgtei/j30SPYlTogkD?=
 =?us-ascii?Q?sywaCnsynvc++HNzqry7MLi1wP2G3bKrk2U4SRw9UJaLbXVxp8XgZbhP/RNQ?=
 =?us-ascii?Q?yqavJ2fmsTPTE5Oft8EZC4H28lTUuvVQIswIxhmmzCN1OHos9A2BF2wE6czQ?=
 =?us-ascii?Q?Dw2KZcLpFIB4qoJHv2vTmvaDAjXySM8FeveOd4OF7rDLojeHIhybtRfHZTr0?=
 =?us-ascii?Q?Z3jykVzNBpqC6hRDLzOHyRAggizOD6W1UDO2bvEd7QKXIjqDTUE3K1+iNo7L?=
 =?us-ascii?Q?EXYCsDyxS/bUFtctwsU9ydv+EBWJe/JzYO4cK29KuynUchiNwXafU6/Izbjr?=
 =?us-ascii?Q?3b0p2DNb/SrdfEOJlbuOVAZ/c3DjtxyeROIb1GT3nbO/LnxmAzKIo03GOEtX?=
 =?us-ascii?Q?kjI+Lw5w/ooGQQ/3Bz0aPW/xBCdHFMFXiEitUc8ogaxovksPv4C6cTA9g3SJ?=
 =?us-ascii?Q?668b5mYhzjHP9BO1MI3iTH9/z6uBIaSB5c26ZXlNQWYqXHTJc7sBtVBo7PlW?=
 =?us-ascii?Q?uunCT+DkEiyz1mOzJoJWuKR5kH+27ZlrnAgxBSotaUgutZk+BHegilUhewlp?=
 =?us-ascii?Q?W0RXVPoA1zye6zWsxQpL6VGS+e+GJYIxvi3ZGk3dP3xK8vrIm1Zx8c8WQHX4?=
 =?us-ascii?Q?WVqQmilYQOS8dI1X0FJvmV6hAWpM7Klcm2igdXN2lm9L31GzMmN+f8Z4uS8t?=
 =?us-ascii?Q?CxOZCyYMvfRoc3VJsh5lsJ5vk9lAUltmplkcZYpNAvp27Q597AJ6uXqXRuYp?=
 =?us-ascii?Q?+AbnwJRUS484w2lJRldzzK/fYdSmfGl0cUGfFF0fs8xRLzeVTywAMp55eic5?=
 =?us-ascii?Q?vcA8T+171Cc3qZD6jr8V7INq?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rmJQy+CuE849j8mg8gprcGOF1tdvAcDZ7uraFGdDdUV6QzWzsz1jp3Nse1L+?=
 =?us-ascii?Q?5EMKJVQiZvIKwpFrFSiMe0W4DaHm7exxXn22AlQ0FbaalVs8fDtq8JAlBLZB?=
 =?us-ascii?Q?JgtQWHL8WlmRPRQ1jL5hsqbeE1tZoMdVHJVKk5YVzCogpox3qV8tCx90OJQ9?=
 =?us-ascii?Q?KFzZWkfX0F9m40NIUulh8Pq2GV8/wH5zd5zT1/tOfLcN3o7L/88oPjdhAJ+d?=
 =?us-ascii?Q?Xl52TvXentQf2xmBUFk2Sw9bwmlwcLKdcGHYnKi905q3R+SaG5/qlEN3l/aw?=
 =?us-ascii?Q?5tHximmSDDLgJTWc3Alb/z3OwjmWenymmclMognNSEd43EDpDdxFSh8wasnr?=
 =?us-ascii?Q?aH/LtAtcICsTfA5usksPPmoTa2OnwneU+I98SuQfahsCVz9ImcGn06E1d/gk?=
 =?us-ascii?Q?mjmAXok4GRit2iC2txlUnSnaM9lyK9lki/SIXOybQOi7Fp/Z6/RrKON8MU2K?=
 =?us-ascii?Q?tNGmiwm1mTS1GibYh3/dqFdIBXaB2D/Nk88VyM8FO02opLeOk0IvRWh5R7Fl?=
 =?us-ascii?Q?Vatdi1hka3+O5y7JK8Z7Th7cDiFDlfF0N9zNooT737SIG25L/5RvgIaUO8Jz?=
 =?us-ascii?Q?ch9denZRcxeDwO9rdsb5/nP2SnZejUCszNhsmTNKegR4+0U41vKIPYZWtekl?=
 =?us-ascii?Q?se1sFyKujkJF/+vqUlsPjsaNRvp5mk5ggMQLQLEPslngIDvlvn1zbi5sHhIP?=
 =?us-ascii?Q?4BBIjHw9PKCAiokMQXicO9Vm6I52tWhZGC01Jjk/9vtk3hEsweuAB9kgNb9j?=
 =?us-ascii?Q?VUMLW6nLFFsomuL44TLDoVUY6zt2tANEZOB2tjk7AtvkxCad48A6iwmBbel4?=
 =?us-ascii?Q?FnI4WPcq0NHI3p5ynBBZTJo3PKdv7wxR/KQ0ku3Vh1gonMBPDV3+3iYJsNoC?=
 =?us-ascii?Q?OaeL7j0zqrFgalYLYJCajpK7vXEDButVB8veThYuAEWAGqTG9Okye8j5sLtH?=
 =?us-ascii?Q?5sn71yL2u+XdIEuiiKe+dAc2v5g2Oj0QoCZiFDR/hfTY3EbDr2DJzI0lqMDV?=
 =?us-ascii?Q?W4bBeruqQ4IGQK+XMascPuQL2bccGqd54l+xNz5lLQmiLvqipaoGwtt3Z/a6?=
 =?us-ascii?Q?5g8l2CvyyTY122vV+HFyTlCk8StA2vrEBLQO30GqBjPOJtiI/V7QYp2z51fI?=
 =?us-ascii?Q?+lPKpTq4JDJpDPb429XlxEP5XoRE8RSnE8Bf+DfSCAHZ95OpuopYQt5H98RB?=
 =?us-ascii?Q?MsilzB8VfKj19GuWOYzm6CsQGgzMGDzbH1GslVPuVsYr917T8JbcZzb+P7Ix?=
 =?us-ascii?Q?asZazxtxSNcYxLAfy6909GczkOl7GGEjGfrYrS1FnvKXiqh0I1T80Xn54g7c?=
 =?us-ascii?Q?dtGwUJLjl6l8EP+lJXpjV1LxAHwMxUfWB4z+TKcqMzAESuAhS2r7a2C/FEcj?=
 =?us-ascii?Q?+DcAa79Rt/E/9Yvqy221xLg1YSXSeVg6rV3YtvQfGFpi8eL2F0lcN+a3Vs0W?=
 =?us-ascii?Q?BdC1kRRMYsZNt8A1qMszCMx5v3iX8W93BkgwtNiMnhGx7Lu44UevzqhmlKuK?=
 =?us-ascii?Q?pofkLir2sOR795zmwj0ZXhTsfYt9cOdHI/KmZQdKXsi5H3C6QuNkYSnvxVMH?=
 =?us-ascii?Q?if50Vi1gfQP9gwZ3j2WiHkUHi/MvVcnYNoBt13Gg?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dd4a45d-d57e-4c44-e277-08dcbaa2296b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2024 07:41:22.5202
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o/lspf1S1bkAcy9IlvAkWb/g0uJCfcUnCE+9KTGH2pmd+mirg9CcQf1lP5778C+vObvo6ASB9hkb2vrRK5VN7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5714


Thomas Gleixner <tglx@linutronix.de> writes:

> On Thu, Aug 08 2024 at 20:55, Dan Williams wrote:
>> Alistair Popple wrote:
>>> Dan Williams <dan.j.williams@intel.com> writes:
>>> > Thomas Gleixner wrote:
>>> >> Wait. MAX_PHYSMEM_BITS is either 46 (4-level) or 52 (5-level), which is
>>> >> fully covered by the identity map space.
>>> >> 
>>> >> So even if the search starts from top of that space, how do we end up
>>> >> with high_memory > VMALLOC_START?
>>> >> 
>>> >> That does not make any sense at all
>>> >
>>> > Max, or Alistair can you provide more details of how private memory spills over
>>> > into the VMALLOC space on these platforms?
>>> 
>>> Well I was hoping pleading ignorance on x86 memory maps would get me out
>>> of having to look too deeply :-) But alas...
>>> 
>>> It appears the problem originates in KASLR which can cause the VMALLOC
>>> region to overlap with the top of the linear map.
>>> 
>>> > I too would have thought that MAX_PHYSMEM_BITS protects against this?
>>> 
>>> Me too, until about an hour ago. As noted above
>>> request_free_mem_region() allocates from (1 << MAX_PHYSMEM_BITS) - 1
>>> down. Therefore VMALLOC_START needs to be greater than PAGE_OFFSET + (1
>>> << MAX_PHYSMEM_BITS) - 1.  However the default configuration for KASLR
>>> as set by RANDOMIZE_MEMORY_PHYSICAL_PADDING is to only provide 10TB
>>> above what max_pfn is set to at boot time (and even then only if
>>> CONFIG_MEMORY_HOTPLUG is enabled).
>
> Duh.
>
>>> Obviously ZONE_DEVICE memory ends up being way above that and crosses
>>> into the VMALLOC region.
>
> So we need to go through all usage sites of MAX_PHYSMEM_BITS and fix
> them up...
>
>>> 	@@ -2277,6 +2277,7 @@ config RANDOMIZE_MEMORY_PHYSICAL_PADDING
>>> 		depends on RANDOMIZE_MEMORY
>>> 		default "0xa" if MEMORY_HOTPLUG
>>> 		default "0x0"
>>> 	+       range 0x40 0x40 if GET_FREE_REGION
>>> 		range 0x1 0x40 if MEMORY_HOTPLUG
>>> 		range 0x0 0x40
>>> 		help
>
> That reduces the entropy to the minimum and papers over the problem with
> 4-level paging, but it won't solve the problem on systems with 5-level
> paging.

Actually I've never observed this problem on systems with 5-level page
tables, although I haven't tested extensively there. I don't know of any
reason we wouldn't though, so I guess with the increased entropy I've
just been lucky.

> There the 64T of padding are just not cutting it. MAX_PHYSMEM_BITS is 52
> for 5 level ....
>
>> 	 @@ -1824,10 +1824,11 @@ static resource_size_t gfr_start(struct resource *base, resource_size_t size,
>> 					  resource_size_t align, unsigned long flags)
>> 	  {
>> 		 if (flags & GFR_DESCENDING) {
>> 	 +               u64 kaslr_pad = CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING << 40;
>> 			 resource_size_t end;
>> 
>> 			 end = min_t(resource_size_t, base->end,
>> 	 -                           (1ULL << MAX_PHYSMEM_BITS) - 1);
>> 	 +                           (1ULL << MAX_PHYSMEM_BITS) - kaslr_pad - 1);
>> 			 return end - size + 1;
>> 		 }
>
> This needs a fixup of gfr_continue() too, but it does not work at
> all. The size of the direct map is calculated as:
>
>        memory_tb = DIV_ROUND_UP(max_pfn << PAGE_SHIFT, 1UL << TB_SHIFT) +
>                 CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING;
>
> That size is used to calculate the address above which the vmalloc area
> is placed.
>
> So assume 6T RAM installed + 10T space for hotplug memory. That means
> the vmalloc area can start right above 16T. But 64T - 10T = 54T which is
> slightly larger than 16T :)
>
> I came up with the uncompiled below. I fixed up the obvious places, but
> did not go through all usage sites of MAX_PHYSMEM_BITS yet.

I looked at more of the MAX_PHYSMEM_BITS usage today but nothing else
stood out as obviously wrong.

> Thanks,
>
>         tglx
> ---
> --- a/arch/x86/include/asm/pgtable_64_types.h
> +++ b/arch/x86/include/asm/pgtable_64_types.h
> @@ -187,6 +187,8 @@ extern unsigned int ptrs_per_p4d;
>  #define KMSAN_MODULES_ORIGIN_START	(KMSAN_MODULES_SHADOW_START + MODULES_LEN)
>  #endif /* CONFIG_KMSAN */
>  
> +#define DIRECT_MAP_END		(VMALLOC_START - 1)

If I'm understanding the KASLR implementation correctly then this
doesn't seem quite right - the entropy means there is a hole from the
end of the direct map (ie. the range PAGE_OFFSET to
PAGE_OFFSET+kaslr_regions[0].size_tb) and VMALLOC_START which shouldn't
be used.

In practice hotplugging memory into that range probably works, but it
seems like it would set us up for future bugs. It also means memory
hotplug could fail intermittently based on the per-boot entropy.

For example with CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING set to 10T one
could imagine hotplugging 16T would mostly work except on some system
boots if KASLR happens to randomly place VMALLOC_START close to the end
of the direct map.

Therefore to keep memory hotplug deterministic I think it would be
better to define DIRECT_MAP_END as a variable that KASLR sets/updates.

> +
>  #define MODULES_VADDR		(__START_KERNEL_map + KERNEL_IMAGE_SIZE)
>  /* The module sections ends with the start of the fixmap */
>  #ifndef CONFIG_DEBUG_KMAP_LOCAL_FORCE_MAP
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -97,6 +97,10 @@ extern const int mmap_rnd_compat_bits_ma
>  extern int mmap_rnd_compat_bits __read_mostly;
>  #endif
>  
> +#ifndef DIRECT_MAP_END
> +# define DIRECT_MAP_END	((1UL << (MAX_PHYSMEM_BITS-PAGE_SHIFT)) - 1)
> +#endif
> +
>  #include <asm/page.h>
>  #include <asm/processor.h>
>  
> --- a/kernel/resource.c
> +++ b/kernel/resource.c
> @@ -1826,8 +1826,7 @@ static resource_size_t gfr_start(struct
>  	if (flags & GFR_DESCENDING) {
>  		resource_size_t end;
>  
> -		end = min_t(resource_size_t, base->end,
> -			    (1ULL << MAX_PHYSMEM_BITS) - 1);
> +		end = min_t(resource_size_t, base->end, DIRECT_MAP_END);

This does not look right to me - isn't DIRECT_MAP_END a virtual address
where as the resource ranges are physical addresses? Ie. I think this
should be:

+		end = min_t(resource_size_t, base->end, __pa(DIRECT_MAP_END));

The same applies to the rest of the DIRECT_MAP_END users here. Perhaps
it would be better to define this as DIRECT_MAP_SIZE and calculate this
based off PAGE_OFFSET instead?

>  		return end - size + 1;
>  	}
>  
> @@ -1844,8 +1843,7 @@ static bool gfr_continue(struct resource
>  	 * @size did not wrap 0.
>  	 */
>  	return addr > addr - size &&
> -	       addr <= min_t(resource_size_t, base->end,
> -			     (1ULL << MAX_PHYSMEM_BITS) - 1);
> +	       addr <= min_t(resource_size_t, base->end, DIRECT_MAP_END);
>  }
>  
>  static resource_size_t gfr_next(resource_size_t addr, resource_size_t size,
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1681,7 +1681,7 @@ struct range __weak arch_get_mappable_ra
>  
>  struct range mhp_get_pluggable_range(bool need_mapping)
>  {
> -	const u64 max_phys = (1ULL << MAX_PHYSMEM_BITS) - 1;
> +	const u64 max_phys = DIRECT_MAP_END;
>  	struct range mhp_range;
>  
>  	if (need_mapping) {
> --- a/mm/sparse.c
> +++ b/mm/sparse.c
> @@ -129,7 +129,7 @@ static inline int sparse_early_nid(struc
>  static void __meminit mminit_validate_memmodel_limits(unsigned long *start_pfn,
>  						unsigned long *end_pfn)
>  {
> -	unsigned long max_sparsemem_pfn = 1UL << (MAX_PHYSMEM_BITS-PAGE_SHIFT);
> +	unsigned long max_sparsemem_pfn = (DIRECT_MAP_END + 1) >> PAGE_SHIFT;
>  
>  	/*
>  	 * Sanity checks - do not allow an architecture to pass



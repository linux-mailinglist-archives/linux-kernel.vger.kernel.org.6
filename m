Return-Path: <linux-kernel+bounces-375641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 208F39A9886
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 07:34:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F3EBB2213E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 05:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 101C614901B;
	Tue, 22 Oct 2024 05:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="g0ZiCYk0"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2086.outbound.protection.outlook.com [40.107.96.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB681494B5
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 05:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729575160; cv=fail; b=P4A1MhOsfvAL5DXJwWSAayOnhhxPRANkZgXe5Bb/RWpNo4GTqRbCjPTKnwh7ohfWF3K+duL661UpIdKeo1TA3O7RO8IEhQRlrmytKRSqERxUOhJDUcGBK16o0/+9p52gF5ydbC/4dAacf4QBRLcdCb0JEA4/WOh98gnxf5406Zo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729575160; c=relaxed/simple;
	bh=5qDcoFKAB1K5iz3sp+7uUo/HndygXvvR93iLBEEpYFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CdsGjkYZzdFjmVEnsSzuHKpT4gkUBzOkAwlTs1b/hmgNs9zomAA3KS8vWExR2zhCQtTrRPBd33NtgSXdvOlouMNs1SLVOfuqxuVS6uMgxUzxXJgF19+bbwXeiCawRdCCe/zTDX2VKYZ18bzH3fLslg20wBPhzfvBIK9/huA89Us=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=g0ZiCYk0; arc=fail smtp.client-ip=40.107.96.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FmiR8dt+h40i1mNKLUiqT+NiNkzNvuB5okSj/gNZERb/d6a3OXyxEWRA8MGxAMpoATrHAlAr1WFTR0RBgLibgE6fBakMZfmfeQ4/WwtxmvX8wviMe6Uq7D6h6nlKO94xADJNGjUWIZ4ii5z4HHdH66CR4GxLVeOxkKDh5GwQXNFDmDBoWYDjk27GKwN1JIEQ2ttcw0zCT0UdlvlWa2TAkW2OhJ6N6vS1a2dI6s8NHeKYoOcm5oh1ffEMmQl/Zv8T3NmMx3Dx+CpMDlV5V9B9BJ0uznLojMo2Gxi0ebHjWihImH3YavVU+GM8gtIFP1WB3vEJocJG1Rlc7Ore5zeduw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ORcfchizBvkzaV63Jgm7mjcmBc+Sg+8JxmC+p1sg3Ks=;
 b=lG2TtPdxoVPhs+pFE6q3c92jqxUaDjFMz76IRIn2JdfrkR1kjE98X1ULye0elnguLUutCsJ10fH6uWFuMNBgmyUmTL2BsJIPA6ifuKXbHobaT3EswL+mGEyIW2UTbjDJvxRAAQjKDRp6vjtMWWCj2I/Mx6IRNMo1O4qFFk93SDz5mFvS4KqvESq6pNc0aI7X45f7GrP1cew0aF+BslfNbwjjWV1birGJ0CZFEFaP4Mnc6WCOdyPYR/A5jt4XgeMPNuRjD1VrLAZa5U3VwsyN++iP7gzUtGaBBuB0Dn1+7EERZCezWlvuNOgFnIJPgTKG1zRQLOLisvz/8qjiQJWbFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ORcfchizBvkzaV63Jgm7mjcmBc+Sg+8JxmC+p1sg3Ks=;
 b=g0ZiCYk0dGFNoxKLhcvkCZ+h8AGq0+6p0naShcHDyqH4E/7JGH/tfxoxDDt4qovg6m39rqlqGmaBG1fKFSqmglMNxTF1JaFkUrP4b5CWKrOwNpAxj6t21DCR1T/FemrFFpph24LPoU4e8KgsPbKRznnrlKmwkmdvRsie7PPe0vt1U4cYpmtedBUrfMg70Atk0aWhJvwndx7N+cpVEVfUpe9jxgw4k2A2NitrR8RQ2bNtrrr71+yo3g3+D12syEp82SeBgg5zH4W1URuQxZpMdokom4gJ/xVurIb2k3SuFTmojQHRMbDfH1p6RT/3xkdIeJu2xjSvmaEt0Hyd/+QiSg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by CY5PR12MB6455.namprd12.prod.outlook.com (2603:10b6:930:35::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.27; Tue, 22 Oct
 2024 05:32:35 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%6]) with mapi id 15.20.8069.027; Tue, 22 Oct 2024
 05:32:35 +0000
Date: Tue, 22 Oct 2024 07:32:26 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched_ext: introduce LLC awareness to the default idle
 selection policy
Message-ID: <Zxc46lMpelf_BKHw@gpd3>
References: <20241021071304.27856-1-arighi@nvidia.com>
 <ZxazF56XRJ3CJ0mN@slm.duckdns.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxazF56XRJ3CJ0mN@slm.duckdns.org>
X-ClientProxiedBy: MI0P293CA0009.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::6) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|CY5PR12MB6455:EE_
X-MS-Office365-Filtering-Correlation-Id: c9627131-2c1d-4791-9915-08dcf25aeef8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mzP7IaCvKbnuLF7H6B6fkber98fwjDoZQYVXLOmfvdqeWvH3DVXfwj6fPF+h?=
 =?us-ascii?Q?hvkpJSdCDdagbXBsyco1n8VXFu6BaULJ5GBdzlX4IJFfOOQd/zS+Pbjz7AWa?=
 =?us-ascii?Q?QkE01ZTj5Om5pQja8fZIHFNHxwOfc5lOByy9nkUFPL1sXv+COgWowlh4MMEr?=
 =?us-ascii?Q?4FRpTQMBswacWjm08n0VEceDUWPMKQYTlkcqBkpAMyrE6zZUL66072pUqFUL?=
 =?us-ascii?Q?GeGWqyt2wzhlXIGEhvdRPsf/p/O3FDootjIYcJZR4DeKgvXWQbgv1hUZsEBF?=
 =?us-ascii?Q?EgbGwmertgZka2U/l7YBEzqIPTFrxwsvaMKkbko0TZ3JYcvSVj1lwuC+FySt?=
 =?us-ascii?Q?aS9eVTY7rVJ2Q29ABbeRv7M4m6bKEzvL56wYanALcM2zkREi1sBGe51LIx+V?=
 =?us-ascii?Q?/4BZTjtn4O3c3zXnMzMXRHEJ5LJFzXv+DDjV70RKiBlID+iOq6RWwKmTQtCK?=
 =?us-ascii?Q?4eDkYeupujM2XtRP7c7ECJbS/S3WIgZzE3pSWPRpTEDiG5Jj4muKgCRTs4ly?=
 =?us-ascii?Q?iElECUxVJoovAhiSS1md+sWTJ54sqwsyf/8HtCZK5qnZgQazVGBD9zMRAEbv?=
 =?us-ascii?Q?BYZ8/9MbsKV3HlCIGsNBm8oqxqRr183/cd68pxNDerqbLuopKWC24bNZaYvN?=
 =?us-ascii?Q?i/511g1qLlIj/D0xzwv32DXYO8GscjHhOAhXY+KvIb/pzZUdZM/VKadCToPn?=
 =?us-ascii?Q?ZBHSbRMcRhno3xMHVaEphJzoyxanqqTPpk3A0WFUx1j3aOYep6PrEX4KjzvY?=
 =?us-ascii?Q?PCagh2olewZY0tH9N8RvarWgyCeHwbVMGREZ4TXroVlwFXUKdfYgGrXlccUU?=
 =?us-ascii?Q?n3lY2l4jrqjW5/tP6HtfOyY3K3tehzz/kB6pW36PkzAIlbVdyEfVbjO8xnpC?=
 =?us-ascii?Q?eWDbSeWJ4Zmg+b0iozcXitvBuZiF7tJaw9aJ280OUv2BW2wxU0CZlyZCy6G7?=
 =?us-ascii?Q?2CGZc9xgFTk0q+72NPBRYBSltU2RScc3bCVJeS9R9tz22NOBwc4xxYxC9iei?=
 =?us-ascii?Q?uyhmNQ8WXqHFXumFVh3X8286xQasAGun5KXWxY63DBvn5OY5LYMkAwoQOM9+?=
 =?us-ascii?Q?Q2+xH2yK3qQrJ4W0SpafgEDL2hghYEV6RLSnbxhIddI9rdSyjasNySgJhyZs?=
 =?us-ascii?Q?mtszp1V6sqPf/dufEAVblXyOH8RZ2B1cyTKsEbFQe8BGE14yT7GQ7OsXlrOB?=
 =?us-ascii?Q?WAB88g7mLREXYsQsTEEpDTj6rwd3oauY+/mQKykz3Fqm41V4HjpZBLiuFs4W?=
 =?us-ascii?Q?3RY/vLva+LBpgIyM5WxauQDMUa7C/G79pC7uM/2xZNye6BkxTkIGIw6LfOtL?=
 =?us-ascii?Q?+y8dxbFdPKaSbgMZx9KRjzZR?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/pfKSNZ4fWlo7aPXKX/F2lKCbmLz/YjZMaY7q7VCvS0RPVRNcI1I3hywJlHm?=
 =?us-ascii?Q?GorCUWaOIBCv/Ou3l1UDdKh6BGhRjM1XJ9EF5PzTOPo8mvcsft8NqW/wF7aF?=
 =?us-ascii?Q?/P3wGT/BPMfljOzl6sjV+ffFDY2KCc2v5SSB7ftfwN9sgRd9GISOYf98wZvW?=
 =?us-ascii?Q?KkGuf4nm+5RS6S8bSaIddI1eI/8Ct0TmE+2N+QTMUgvcnI11gwee9MK3Cujv?=
 =?us-ascii?Q?J2/ApnC4pc7PSj522M387M9zuHLc4r+EE//KDfXVQwVit6UDnQjcIIj62x+k?=
 =?us-ascii?Q?+1DkpJNOq4WCoRJPNUbweoRzDj47vcGS+B5pfFeOu7v+6kljOp+MbsB9qR07?=
 =?us-ascii?Q?Sf8jT14aoWSIUqcTXljDLmhcxp6hSJvA3qhAI1pC8Zw1z3g9yEafylTn9Upw?=
 =?us-ascii?Q?/Kj3xPseuOUN0AHtR11DNSnpqLl1jiScffo5JIUNS58wGRAXmsYWEhb/DWqc?=
 =?us-ascii?Q?h/PBySB7cix0q1lzaQG8Unm7QCbV+BEeeagelRIrVpctYrvor4CGEu5Lofcw?=
 =?us-ascii?Q?qWMce7bCb38WlXLA4cose/oWoHnbpPj/ThuvM+Ur+tbjdHVENf9Cwq5clfdM?=
 =?us-ascii?Q?obd5TginlhSXBNRg1ljBkBDVDclkXzaNUwhQfT+kkVNiJJ+MrIEZ8HTmyi33?=
 =?us-ascii?Q?k6q/MIApf0ujep4gkgp3B0pfdHMfL78KdfoHLQv03xrmajTvV26CW10c9SGs?=
 =?us-ascii?Q?Xu01yNGIGitjjBngGBdV7Izz5mkr/FG9Fx6l24nhc8rF504FQUgXtoUTi+KU?=
 =?us-ascii?Q?gsJViUfCPjLNmcomJmHCozxMvCl/7xC4MyQJbXr7OJ+Nb3DBayX2O8vUbvN0?=
 =?us-ascii?Q?aSElA6f/V2S0vwyLt8CEPRERtr7joFytflF+8fVkA/AWBibH0XMK4fxEa5f6?=
 =?us-ascii?Q?1PgzjLD9UHlxDJDYYITJtgXt1Fv29i3EqpiOKEjjz1RMOuov1bANhpMkJEAU?=
 =?us-ascii?Q?sSZWzJzp0qAJmgiu76sQmvqhUu7q6wlIxsL5MGG2ZGDIDaR09rebKKexQD2q?=
 =?us-ascii?Q?GFq9o0Z14tGLK4nBgKQeahGp+QuJ/3RS77NB4j2UozvhZswmCf/IhABg4W75?=
 =?us-ascii?Q?7DBPPbxeToXO4dcnZ0kzApqLuYE2WTAOGGlMZDuU/XkGdDSsW8MEPS68Aar+?=
 =?us-ascii?Q?izwZK4OXqLZauUFEQwltO54YcmMhYdfEJmClta8kK4opXwBtaQXxwdBpjSAX?=
 =?us-ascii?Q?C/8HJOrkIIBj3zkcSyBNjrrFZXZSsy1dbHtcVGl75p34CGsZoJnwzvGLVubI?=
 =?us-ascii?Q?87rgQjTzh6I33pBkz657zrCekgrRb0c9rZpEUVVbzanPBlHCJt6ojSjdrjuC?=
 =?us-ascii?Q?1+HUPIgEEOFStTU5HzGxFJsukSCNXDJMeds+ma0nP5GhHw+vKpRcLcrkwWnS?=
 =?us-ascii?Q?JCpGV/xaa7NCUO8nK8skQt3clETWgt87LxvCDcKVWNQ869mOIgzNP4o/iZzI?=
 =?us-ascii?Q?H6TnG5LhynTD7LzNJazwot8CGPIb5K+N5lI1TZSrWHUNzyDVwI6dxdTOLJue?=
 =?us-ascii?Q?tg7w2PIn19EXG9wjSKyG1b7xluSkFjFqKPbJ949IIkpAD9fg3TpD5CLnABbw?=
 =?us-ascii?Q?aMHXVrM5tbPaqHRn1cZ66e839W4ZFdUMJ1L//DuA?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9627131-2c1d-4791-9915-08dcf25aeef8
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 05:32:35.1408
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3gg4cp+dR33i20JafWX3BjNJFGK2BuBI7qAvjauB70DItHE6TJbCb3+5Evugwo+3n6dIEMTTu6yMcnRZ9BNSng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6455

On Mon, Oct 21, 2024 at 10:01:27AM -1000, Tejun Heo wrote:
> External email: Use caution opening links or attachments
> 
> 
> Hello,
> 
> Overall, I think this is a great idea.
> 
> On Mon, Oct 21, 2024 at 09:13:04AM +0200, Andrea Righi wrote:
> ...
> > +     /*
> > +      * Determine the task's LLC domain.
> > +      */
> > +     sd = rcu_dereference(per_cpu(sd_llc, prev_cpu));
> > +     if (sd)
> > +             cpumask_and(llc_cpus, sched_domain_span(sd), p->cpus_ptr);
> > +     else
> > +             cpumask_copy(llc_cpus, p->cpus_ptr);
> 
> However, I wonder whether we can be a bit more efficient here. Always
> copying cpumasks can become noticeable in larger machines. It should be
> possible to cover most common cases without copying cpumasks - e.g. tasks
> which don't have any cpumask restrictions or affine within a single LLC
> (including tasks restricted to one CPU) don't need to compute a new cpumask
> each time. They can use either sched_domain_span() or p->cpus_ptr directly.

I agree, I was also thinking to improve this part to avoid doing the
copy. And I have a few other changes to apply, I'll send a v2 soon.

Thanks!
-Andrea

> 
> Thanks.
> 
> --
> tejun


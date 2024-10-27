Return-Path: <linux-kernel+bounces-383743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FC159B1FC3
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 19:52:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79C5B28130A
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 18:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0639156F45;
	Sun, 27 Oct 2024 18:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eZxfJye2"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2088.outbound.protection.outlook.com [40.107.244.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83D3161
	for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 18:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730055123; cv=fail; b=QuF89jslwn9Pqkw2pFywSQ6XJwgyiycxbp9/Tp9DTpT1nsDQZP33UCjVDIHO0ZjePbSUrrrG7jo2R6OafcyZem6ZJ9rNvQjkymJfaX8FW6XfEj8y7B4p5LVd+bITi742mZmE8ei4dM9jAGLy6BdBykKir9BibWtHREzTsNfJ/L8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730055123; c=relaxed/simple;
	bh=mQTZg683zdVYO054XAqBt6y+X8WXDD1EGVcWPeTEjBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=emQBT2G76vAuZkcSxD/xsiq17kSHRxsaATKwRMoZBTbPg1CHybg5xJDGtUNaguyfWPv5JTWzhzGxhVLbEabHeTDihnhAbp7IeeTGPXYFnMqjhlQEt7cPcWJqfkaTSJNdij1viE2q5AutjA8Az/HKAdS8mVuT8/VZ1PqG5GrNPsg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eZxfJye2; arc=fail smtp.client-ip=40.107.244.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZJREfAixVSf4p58RJT7nFlSiVlnAiPa+7aJjMLuMcarFhencnelivkdzWwAo5iufvbpvmr2DCsk6I4DWBUdYAJ4USge7N8GVKEtr4kLgqi/Jg9kzHhfUW5lfVxW9JsxKSFG2Zuijx7rPJHjPq+o+yASVV3VZ4Q4tfT2XE4VdMPiJQlzVOOo9jcNXhIsDtUr5FQKcocolxhkBxENPSU1DMYi1wMUhsua4jTgpZy8jNtV9Dov4nLPHN6mQtggrse+inI7CRs4nMA7CtyPcsima4GMrDLY54Myn+8OX3jOvOscsvAlF50DyZ0wpJWV6CU+DneLe7qo+W88VqQUC136gfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dEr60ExgtL+4k/oE/+KMOQ6IcG0y+px5+IEkqMj7gC4=;
 b=K0+OwS0vZHczPSwrs4ndxt6BVX6OThCEZEu1sitMx2rNL6OSCt0NZEmet7TjQ+TpC2EBOXZkEGdLjiHcC2s7hE9nMPU7Qi4FFGOcTIlzDPTsmwWChY4iouxJA9oAGaXVnc9gMmieWP/3Eq9BaftWMaKtZEzpsLnWNSjQKC5lCzdy2kLomc8JdHgRItSGf052//S9CzICw5twiRfSb9GrLzynzkGP3V9YLyDX9gecV6F2eVB+5y1hAuiX2hXQSXsV4ePJzdVxrYxVSz4vw54jMm/VgYPbEvFYZGjYF24lwoQ+ftg0GII8vaWPioMwQqZ3tdlSiRc0NOA7/O/j+n1y7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dEr60ExgtL+4k/oE/+KMOQ6IcG0y+px5+IEkqMj7gC4=;
 b=eZxfJye2j5BgkP/hiOkdYIFMxsPhV+kTT+SJDEltjJIclvejFIPEyZI1lMMQdxSVn+GkYwNc8w7gYIBZjYO5GS3qN3sLepMJ9WpauTBDFt+99QaBsmhslyRPCxHpviBMCKOpxoE1PSU8yPlwHjie28d3unDMOdt2K/xNApQgKnSMp2zjrvZOveNXVH/Vc6ma4YObX5qu/yihHmFtt/7VFI/XhwaMRFib+gAnbxPIUYQByXC10mu+sU/3itleyrHZVfvAD/1k/imVAE1n9kIZYY6daF4XO4ZdSgjzJv3uxmEhkf+dWhkaJ3dRYRMOArJJJcv4L0VOnj1uNYzXTKIdVw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by DM4PR12MB7550.namprd12.prod.outlook.com (2603:10b6:8:10e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.24; Sun, 27 Oct
 2024 18:51:58 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%6]) with mapi id 15.20.8093.024; Sun, 27 Oct 2024
 18:51:58 +0000
Date: Sun, 27 Oct 2024 19:51:53 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] sched_ext: Introduce NUMA awareness to the default
 idle selection policy
Message-ID: <Zx6LyQ-kIe0fXSrL@gpd3>
References: <20241027174953.49655-1-arighi@nvidia.com>
 <Zx6AiTja6jX7bC7R@slm.duckdns.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zx6AiTja6jX7bC7R@slm.duckdns.org>
X-ClientProxiedBy: ZR0P278CA0156.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:41::6) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|DM4PR12MB7550:EE_
X-MS-Office365-Filtering-Correlation-Id: cfd136e8-6218-4b4d-551e-08dcf6b86f71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?m6ukdNoBtoJ8aIDumPVxN1f8aTKFVtGVqfiNT5xAVJtAgAgU6mQHEVrYE7LF?=
 =?us-ascii?Q?YpB6ClRmu0K7WwdRDVmP/IlW9YaP/tgTcNSswSflTrAxydnCZkSu24odbA4l?=
 =?us-ascii?Q?hO/+A3ylNk964q6kKT8S1gbiL5+GoceARyeO0MFaBVR+4aPoqRDAZP03qrcJ?=
 =?us-ascii?Q?hIV5jAmCaP/BnjQQlpbizzhjlLmyOB96EbyzKhQKv52hDcyF9rioVWRBytSO?=
 =?us-ascii?Q?6PLTcCG69vnzEC0Cho+p147eoxSmsBctMa2Vrh89+ZdXUSlHDFb2rRasWeGg?=
 =?us-ascii?Q?5yUekDntUI4kPQl/chYlxosJARLfB+qt9RKXK5R/d4XX5k+pOSwF+BMRv3TG?=
 =?us-ascii?Q?/pIsnJwx+lCk13PRhppkiTsSc9RvI7N0+1NkaKcpJLgPoMjtlVrvQZdM75y7?=
 =?us-ascii?Q?gpUue1ZBZltxV6q63GyFiUFESbSRQmLNDAlDLGMETvzptJf3zJ++NJurmGTE?=
 =?us-ascii?Q?EFp6hu7zl4i8+Mx+U5Plc4HkjHDThDOnDgrWYQcTSn+spT6l85HQwzkZygrv?=
 =?us-ascii?Q?J1U7i/6ku6i/IKgpmbB4Lf3EDQgxcHgI7tF+kRG0WgBpflbRWvlFKVsIdK3f?=
 =?us-ascii?Q?yr/uSgMO3QM0gaTrINddY+oQPHip5Hi37QIaJJ6x/vQt4yJHdbUW1khMhfOp?=
 =?us-ascii?Q?3v7lF9mEvACsMVV8YhEH6LmzoHt19q4nT49nph50YtqcF5xQ+iBoIGY8Womz?=
 =?us-ascii?Q?xF4NIOLv7xb92x30WeOiNTac4cd8JpudsaKP6iIJjw8xbJAa/jfyW0vF5cst?=
 =?us-ascii?Q?se0ysEk34MVPgisKx8+AkEeUZit1/+zM0h7Vx6CudtuvuU6Qrw5nertdUHjE?=
 =?us-ascii?Q?0bypha7t8kUJbTPOSHuVdKDDhM41la/0MBrEHbXgKHP8bkJHMMnodt6qCFEX?=
 =?us-ascii?Q?AStRuSIQVE/ypjN+FgiOyQvnHdgu1TwxUT4GCw4S3HrlOtWT6cdUQzW4BZki?=
 =?us-ascii?Q?JEH+kvAfALFKH5EClRDek5ZWfADr7b90+Ajw/sjB5mD3N+GykpXoZkWhrMsf?=
 =?us-ascii?Q?wBbAfAd4PCLmTMiiPmxM3aGUOofk1WJyOfUtkJGqh3uLqDYtR9w2WSSKNLv0?=
 =?us-ascii?Q?Tadv+LHeoH6KaZQNmP4MtbyYYPmf23rHejEPJrDpVeZy/hxt50D/sLdiMAaH?=
 =?us-ascii?Q?nLBkeS19hv6+kb4lS2JL630nmQJB3/vfJVnTqS564WsjdCd/oc20I32A/uPO?=
 =?us-ascii?Q?4ed9fPMRJdLTiY+jJ90q2Fjk0tdQOa3Dh2Gm3p2E3gn5QkwGSUF4y4ktvJN3?=
 =?us-ascii?Q?FLlKvvaO0kgNPNYNb5jag5ippl+8ZkrNWNLpcvR7btgBFzeVIQYWPdVaK/au?=
 =?us-ascii?Q?YLxrmCKgUBAglMqtIRqdjJQ5?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lhXZxv1ffXhUjEGbck31Xgfs3COSRKZcokeOsY0iS3RuK8uWDFjoChkOuU5O?=
 =?us-ascii?Q?Yo/o391NMcc7ehBgpSeZp/JSabgHfi8nhGc55QZKSmsHwYrgMA0w0sNrGBKx?=
 =?us-ascii?Q?81Byge/9OTPwEt5kiwq92sycyrL41Utbk5PUrRyEb38AXSCKyJhlvBe1pY7d?=
 =?us-ascii?Q?vRh3j3nnXJVpprZ98qff/OEdOQC7z2KvaUyIjxIOoR52V2/OmvFIn9jMB/B+?=
 =?us-ascii?Q?2OusOEB/qcpNg4Pwxa1Dkg1zNBKPmVZaFzmEfVcSYsSkQHK4JpLP7Jnm2/mK?=
 =?us-ascii?Q?CerQaqTxBqIbSR3P1l3pY0ST1jt1oEOiQGtDaZWFvTG/8fUfX95TlVJZ8EzV?=
 =?us-ascii?Q?AlsvDWxYfV0c7mrjE6dc4pL6Rq9J3uAO39e9mfap94CWNXz0O1TANCrNlzf2?=
 =?us-ascii?Q?Qg0woS5j9vKO1cGMN5rxLm5iG5UAPWSw0ZXIyb5ZtNXoPdQIwnfltHcaCQ6H?=
 =?us-ascii?Q?nJPSSNdJ49E8M9u5m0WF75mS1KEjEM2g5y0zmpvLDtD8tDTIfCJOqDF/59m6?=
 =?us-ascii?Q?3oPC0E3SnQvUaUBbVR1yPFjJNcalPyllvESB/CcvmBP9brN8u7Kj7KtU1n6V?=
 =?us-ascii?Q?FgD9QflLZ1vNtM8ku2ydprD5sGq2TgTJbmItPI6x+VGfDiA3IonvLOtOh2Ei?=
 =?us-ascii?Q?5zqBlnnflUoXkmioR11ofNJCP10REO+KP76bhHogxH7CH2G/o1iI4HG6iiho?=
 =?us-ascii?Q?KoEgs+VfBbBYsBunV5E0SEgYj9VNUOyKeQnJZbFIaCAoudvIc/LuZAEf2Epr?=
 =?us-ascii?Q?wqstVcAouENyrlERjT3P4Z9O+hnvoCpfKA92HpFCP86GChpz7a5auZKvsC7q?=
 =?us-ascii?Q?6ZZPVlasued0ZCOYBz2T55hyPgNi8oebnWX34beQkwsx6fxPKZm9gxbXT9IR?=
 =?us-ascii?Q?2LdrP2qVkvtNPbd3Rlqq+Gr/Nmo8MnYc/FK2rxemh1EMc8ASUtm7nG9o0DoG?=
 =?us-ascii?Q?UIM3TG9Z6XPQC4vXYMBPsYye2aBbTnMeNsnzI9ltKSDtt/XVdWJxptwfkjBP?=
 =?us-ascii?Q?pZNIKEsSwtPFQa4f7uHQeS6qPqVNqs5Nr0BY2Fh/Cxk6OC5tZoK3EF4EZRr1?=
 =?us-ascii?Q?dz5n01JD7tYuPMlzJ49pN89tOB8EeXmbjJtea6kB2n0VMovsDkKj5hTJr1wv?=
 =?us-ascii?Q?BeH8gXbit66zyi5eSHaiX9Xn9tE4V54Az4a8YUJoyOF1GoMYVYOu7uZFBm0E?=
 =?us-ascii?Q?8aqnm6V2IfIZIlyx892ZIdlIOdUONMW7lQpbPXqPrIIpjQWEt1jIBZrJr1mm?=
 =?us-ascii?Q?UPvnspWjfGKbNnwn1VFadudb03bNsPM57eyekHHu7r6MbkhkZpWczVU+QkGB?=
 =?us-ascii?Q?GO/UdnIqW8mRpTzLf8FSOdvb43jqfZC0+RIUD9sToQ3Wmfv1zcTgDrl2I+nw?=
 =?us-ascii?Q?1fn5PkoTrSFG3SuLHr78BQDBGKpLTXzIbYYK1P52pP04dHsztN2gpQ/p/HCH?=
 =?us-ascii?Q?+Z4Gdi7KkCpba4iKR6UBliPJ15bwaLAzRqHoyYgupx0d+HmYIZ6WxFT1CGTb?=
 =?us-ascii?Q?K3b9kyRO3kXS/Ie9nppWTUt4A3Ju0QtWiihlmOW8+7Y+f3yFvQpQCAZN8eZf?=
 =?us-ascii?Q?1V7x3WEsjvqmUwNR4Xd0sFPHQ4VM2eFbadM2SH5B?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfd136e8-6218-4b4d-551e-08dcf6b86f71
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2024 18:51:58.6306
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qy//9aECOLx/09G4KDpDRE0U8TlPUiVEiXc+kG89Y4zoR8l7RTEpsR6VNllIvqLXpelxzxrm+6gpE8Qj6ixexw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7550

On Sun, Oct 27, 2024 at 08:03:53AM -1000, Tejun Heo wrote:
> Hello,
> 
> On Sun, Oct 27, 2024 at 06:49:53PM +0100, Andrea Righi wrote:
> ...
> > +static void update_selcpu_topology(void)
> >  {
> > +     bool enable_llc = false, enable_numa = false;
> > +     s32 cpu;
> >
> > +     rcu_read_lock();
> > +     for_each_possible_cpu(cpu) {
> > +             struct sched_domain *sd;
> > +             const struct cpumask *cpus;
> > +
> > +             sd = rcu_dereference(per_cpu(sd_llc, cpu));
> > +             if (sd) {
> > +                     cpus = sched_domain_span(sd);
> > +                     pr_debug("sched_ext: LLC cpu%d: %*pbl\n",
> > +                              cpu, cpumask_pr_args(cpus));
> > +                     if (cpumask_weight(cpus) < num_possible_cpus())
> > +                             enable_llc = true;
> > +             }
> > +
> > +             sd = highest_flag_domain(cpu, SD_NUMA);
> > +             if (sd) {
> > +                     cpus = sched_group_span(sd->groups);
> > +                     pr_debug("sched_ext: NUMA cpu%d: %*pbl\n",
> > +                              cpu, cpumask_pr_args(cpus));
> > +                     if (cpumask_weight(cpus) < num_possible_cpus())
> > +                             enable_numa = true;
> 
> This isn't a big problem but the loop looks a bit odd in that once both are
> set, it's obvious that there's no reason to continue. Doesn't this need to
> check only one CPU in fact? e.g. for the first possible CPU, if sd doesn't
> exist or cpumask_weight(sd) == num_possible_cpu(), don't we know for sure
> that llc or numa doesn't need to be enabled and vice-versa?

I was also wondering about this, but I wasn't sure if you can create
non-standard NUMA configurations (like assigning a CPU to multiple
heterogeneous NUMA node), for example with virtualization or NUMA
emulation.

I just checked with qemu and it seems that it doesn't allow to assign a
CPU to multiple NUMA nodes, so maybe it's a valid assumptions that we
won't have unusual overlapping NUMA configurations.

With this assumption, yes, we can just check the first CPU, and it's
probably reasonable to do so anyway.

> 
> >  static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
> >                             u64 wake_flags, bool *found)
> >  {
> > +     const struct cpumask *llc_cpus = NULL;
> > +     const struct cpumask *numa_cpus = NULL;
> >       s32 cpu;
> >
> >       *found = false;
> ...
> > +     if (p->nr_cpus_allowed >= num_possible_cpus()) {
> > +             if (static_branch_unlikely(&scx_selcpu_topo_numa))
> > +                     numa_cpus = cpumask_of_node(cpu_to_node(prev_cpu));
> > +
> > +             if (static_branch_unlikely(&scx_selcpu_topo_llc)) {
> 
> static_branch_maybe() is probably the better one for llc.

Ah, definitely!

Thanks! Will apply these changes and send a new patch.

-Andrea


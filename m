Return-Path: <linux-kernel+bounces-383492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A8FFF9B1C6D
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 09:09:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2475DB211DE
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 08:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 067DE42052;
	Sun, 27 Oct 2024 08:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pLmgTPBC"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2078.outbound.protection.outlook.com [40.107.220.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E098AF4FA
	for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 08:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730016531; cv=fail; b=QKvQph+ubbntsfVRnAJTYzIOw6O3wGNHTUObPjwvmpa3JBzhTWPN6gAX3Vd+GSdPUwlcYYt0LaBUg8862PBLtF0IVQ1vqN7vZkIWmSDQDOGZ4VG9D7lSGoO05prlSjJlG4A52tyFrCYvAOSdHhOXau4ev8/JYl6GbJOCetS0hlE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730016531; c=relaxed/simple;
	bh=hqguJe/KMGTHidklB5UTn4eSyGf5nsBpYrF3gTR/XAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XraTT48bEWXR1+FcVnQUnmmy7ekj2zksXbQ9LIRYAlAddFUdBJq1HQiJSC+pPk66P+kmPX58fRtA6p3eVx1/xn1C66EruZ7vAMrP/HkvKmGcyOn1DysqqbELrEVrTA3uRPyPqDGYaRwpmoh5tE9bYYrcf31a3RkBw3zLQjunGpM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pLmgTPBC; arc=fail smtp.client-ip=40.107.220.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l1vYXV2Ko4nK6EnXUQ4FOp3hgB0BF9hTv63vfptpZtglfacZFGF44DKZRQSRtWuk85M99Ks9qR1071bL7BFu7kmvk7p9UDFbpkZ1LK8SLnWA+rbl4lsEz1hKTAdK1ozMv8Vy98anKucYf8NXyRmJ+5SF9nkN3HngzFskE6h9W2pE1TZ+6GQ576F3FNh/D/1kEKV90X687xNWC9icB+27t7cQLWwG6KaDPfeoQ0sHdu7KJyF5mNf3jtweR5WZxPyCyAzr/vucRte08X0hnvXF1ptIOYQVbxcWOsIFazWk3MQx2kPnWhWZFC4Wpq7IRCyhjZuZoOl/4aZ61Mnl5KGB9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XGMq4N0x2sU6oWf4Vp0VtG9Yn9nLmLdTrETyTd4DRHg=;
 b=TLYZoRyYApChkNdXuLU/9OgF639eZ7o1YyBPHKW8+dlnA/OlCDCkSb8PFzecpSgiU/id1/lI6tcgX82v2NP9RJtm9nAhSgclT9LGk0fKNhKknR6pgBx8iK8E/jlinkIiDt4wbAwm+Au/C/L8eW9SE9n8ggw6kH8/V/Syz5HTyp3XWP3aIOBTAXF4VjSbZaoHsRE3mps/PQFox48zLJq66376Ib0goRsttUf8YcIu/POrCI8TVN1rvs+45gSXs6CNbME/rMCK15Z1YYY3tg2lhbGsAjGZ7M0SczxO+AESM4f2xYtzgSw7mqkYG+3EBSVK/qaH/G4MH8LJBh8cXfsANw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XGMq4N0x2sU6oWf4Vp0VtG9Yn9nLmLdTrETyTd4DRHg=;
 b=pLmgTPBCoXKGyI2S+GU/xPn0YtYq8kXAkq39JYEvqCQJjRQbsVDAZJcgfiIyweMIr6YPat/8AVDtEsHQOmKehFsbf1KJWHDYfRlhJCBDoTZWaRFnOVsq67uz8l/N3cttOzntwvbIq2aBJEtpU49esqbnpdqBZVEP/uvvMiUxVV91YHz3fCuBF8VPq3hUze4wvj8tNuyoatF2kICDjhmqD2OZs7ATsK9MH0/73CwRD3icT+7+FjthksqSpvo2BDuam9CQQeLhdbmQB5ouf0jMLq9y2wYPmeFR1lJJ6GPik4W4a/U0ewx4PCSJV3wouYMUQ0JfscPHVGd8Zev8hSIzGA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by SA1PR12MB7412.namprd12.prod.outlook.com (2603:10b6:806:2b2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.23; Sun, 27 Oct
 2024 08:08:45 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%6]) with mapi id 15.20.8093.024; Sun, 27 Oct 2024
 08:08:45 +0000
Date: Sun, 27 Oct 2024 09:08:40 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sched_ext: Introduce NUMA awareness to the default
 idle selection policy
Message-ID: <Zx31CNqrI4TWgSDI@gpd3>
References: <20241025162535.88059-1-arighi@nvidia.com>
 <Zxv5V5mwDAlGzpBb@slm.duckdns.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zxv5V5mwDAlGzpBb@slm.duckdns.org>
X-ClientProxiedBy: FR4P281CA0201.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e5::17) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|SA1PR12MB7412:EE_
X-MS-Office365-Filtering-Correlation-Id: 37cf9b70-c955-4c1a-e069-08dcf65e9402
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9RJdVfQSQS3PhNkp7qwCrsIVHaOuOaQ7OQsX/3W2PRRYhNwU2O8tchbHPQhO?=
 =?us-ascii?Q?ZF1M6uKwBKb+Na9fq80fco66uRE2FdOG1DJj8qpC/28mTaniEdpKEedEu8vu?=
 =?us-ascii?Q?0hpXDUKZw166OJF3sNveLhChBWJpcdN+AMzUmy8x1U1OeJNcny/YIcgTyefx?=
 =?us-ascii?Q?kyvu1py2SyCYwNmXQpuXW6edxUkVCDivfI6J//Od5gqIMA8lw4h/zo2x5Xex?=
 =?us-ascii?Q?A/JwFX451DibNR4vNJ4bZRz8eUd18p5pYMDPJTgsrCc55/H+/dS3wNfvz5cK?=
 =?us-ascii?Q?pA6HQWj9Ve7wvPwLdIP5jcmK9pPQKWZnXOhULM+5ZxW0m6EH5CbbMAREOvTg?=
 =?us-ascii?Q?g9fz9lhsFVeranelIjZ5g+pXb/UOZ5KKEuMwK20AXBEPiKO61SipkfH2cRQv?=
 =?us-ascii?Q?QM/C04dpdFRA+BXxObH9eLpntGHdoV304xbQ9NZGsHQOgvwNSWGCUGrkJLa8?=
 =?us-ascii?Q?3gazS+qIpeCHIu214U0BsckX9VLK5SBgLrOcIy7sq7MGfmZWGcOfdMpRWTC7?=
 =?us-ascii?Q?jrN31ofBYD4259y8O0supLnWUoQSTSnOZbkUgF1obFq/SpBNDNQ+KBYf6lIs?=
 =?us-ascii?Q?OQ4gWAYatiNeM5q9g579uB4nqwXD2eU07fcBNIf4D1VnvNyByqUReV+VDoxb?=
 =?us-ascii?Q?/zln0DYbOqX0QnkSBv7h1Lpbyz/v5htkD7x4whs3v4CiV7fgqrkMM8fH9c2l?=
 =?us-ascii?Q?3zCIxQrDSMu7hF1CvLTZZVDQQEIoPNE1ERmudrt8WfLZ1J1W7X1pX07piBnK?=
 =?us-ascii?Q?69pcgcOIL9wQxmB0MPr0+EJaJZZEBal9UQNkdZ5LAQRC/56+aeFRnc26m09a?=
 =?us-ascii?Q?p+kkC40FwVnBovB5G6hnNhicT2WUMQepd+uqqvzcPTu2fR4NXgZWZafwZes/?=
 =?us-ascii?Q?gLoMUhrtnFefh9wA13EQ6Mc3CgAZTDy9qoQFhBOxs3IFXF12ekDB3MmplTyM?=
 =?us-ascii?Q?6sVSJTqzAcvihg7V62Vv4Q2yNDY55ptP2QHipNzoo18iag9VjhXkMpHivxGg?=
 =?us-ascii?Q?907CMZtZABiS0XgAMxhhFnhJaPshN30ekSFvRJVUympW6Ra0K7zj7B2LRXxA?=
 =?us-ascii?Q?ufmvK77PW1bSEXQh67+lImWAKDaTxCfBw0/f/IobF54n23X5pcniw6vA9Ngm?=
 =?us-ascii?Q?MRPdNXjxPnDwKJFpoX/xFzXKWgYeG4GYnsUICIl5JlBsKHQjaU58h1ownL0K?=
 =?us-ascii?Q?Jz5pROhcPQZL7YvWqs5hfk/jaoY2jnMqvZ7gyR3DMbo6JU8SXLp04A61KFF2?=
 =?us-ascii?Q?aZ4GM3bHoT5ltQIlQVDeX+kEOkOGQTRQopFmEdxMAKtBzwkZtHa6WSYGNww1?=
 =?us-ascii?Q?rAnn/gh9q8OTiVpf3KKXs3Av?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZAG3HJW9fCYEMPgXc8AiqS9y/Lz3h20aCfL5tWogqGYrg19xwQn9gMeCVzk/?=
 =?us-ascii?Q?7paGx8Y8A5wNi01J4RtiQciL/oFGGK81LPSv//dBfBHMJwPlHFLmGHR+1Y9t?=
 =?us-ascii?Q?ua8oG14BVInI5SN0Vj83V9fGaWzwJ83wW/M1hO8CvWZ1QxyD29LoKlc1pdQE?=
 =?us-ascii?Q?QvbL8SqemW7muyG0X7lh9XjT78x6Uvb/lw2GqeQCTvUwl35rBir8NhlrtYFk?=
 =?us-ascii?Q?sPGn5dWes1J5EoLaw48g/0YcunokUd67Uc2MnjB+ggHFspKXUMoJmZcDXotn?=
 =?us-ascii?Q?YKoXiT4v2xAeqSh3x7dgyD+CU0OFnYR65g+9EaL0ALdeOgSuxedu5GR8J5V2?=
 =?us-ascii?Q?dve5bI2aZRnnkJvl7shiGLKcmniGpsBZjBeiLOm0Yoct3HuVR7+moxTlEVf/?=
 =?us-ascii?Q?fyyoZl6TxN4h41L4XLs+fstBKZ4O4c3No/nSrt5hMcM+grFeyhmMwoy/KxHq?=
 =?us-ascii?Q?D5cJNGe/r27OotON966yefvl05hZYqZPTbZIkyQOWKB8VncNPlUWuMsoP6WA?=
 =?us-ascii?Q?uBn2/cnjOcArLsB+HpowG/4mwnAvnN79KHQkmBrWW22DsqzwNx6oDpl33sh/?=
 =?us-ascii?Q?vJQ+HUAqr4xXP2CiCpWeVP6deEV8BPih1bcyGxTx5zvKFuB73/VIh+xip5K7?=
 =?us-ascii?Q?CvHZBkUie/AL+MmTcUhmKJXJJ36DN2KhpihNwzWi31MhA+zdHXn3hrokQ66b?=
 =?us-ascii?Q?0bEigm2wmm7GD4sga54aJt6srp3fRF8tcQKhwG8u2HzaU4Dbtpzy5Wc4yHFU?=
 =?us-ascii?Q?na9kkW+wWiHjnh2FgqoICmu046vjm/GQqa7veJmPAgd7EC248wZepdQ95t9h?=
 =?us-ascii?Q?fF0dAi8M82Z5ajvG5AdTUsnL12EOMh8+Oh0nXSuluz/OxKa7BPuS136Rmj1v?=
 =?us-ascii?Q?K1S6czPeBBM5BsoxJacRc9ZPi/FtWA5OKtcvuAMFUkZhaUxIAoG42k80kVbc?=
 =?us-ascii?Q?lGwaa0oueXPTZZfP2h+B8WJNKO0SGytq6DqJLNZQ8Ad4BQUg6NHSRZrCcUSV?=
 =?us-ascii?Q?Olh2NKs5e1h23ubNpFynDfavya9HozuxrykTYAyHeS06Lfz+0ERLJyBrW+ka?=
 =?us-ascii?Q?kDB159gHsyMbC6TOIRRKnF6nk783FNBlCZGcrvlU+QZozV4QUa72izXY9ig0?=
 =?us-ascii?Q?2N8QlF4Zi0Bvem6HM6t+++/pPFv3KsWYRzGiw+Ovezkx9/oii1akVL7hfhG8?=
 =?us-ascii?Q?7xaJ7GGQ+ITfsi1FUVCXeBD21oAjVm4C2e3z1rRNEhWn8k6KcCRq+VezYamW?=
 =?us-ascii?Q?eSotQ/QjNWtiPQYqdY6zHyuY4L3IM64GmmwIqVxfC2z71sT4xhorSRbbFP4F?=
 =?us-ascii?Q?bjI2fCxgnWjI0bXi4dZ0NMyIYj1SgKVI+hz07QjIu7ilAvT9vNW811ZAK/ql?=
 =?us-ascii?Q?M4WCnGdeeC4Ul1YRg2MDt6R2HN/XqInV46i07DYkrjsdjZVex4cYBb3Ny4+u?=
 =?us-ascii?Q?JfnxQRiWv1krZyyLnGfxvxJk0/d373fx1LbhTKlRO1ogwf7G8kQgkL16ir62?=
 =?us-ascii?Q?1PdEiTohJyKxFKL/JitwcmhI8MFpD/X03dvQUmv71gMBzQdU5DZI0uwTZZoJ?=
 =?us-ascii?Q?XUVfV65TRtYUdJG1armr9Mm1p2XHY9T8wsHe4KY+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37cf9b70-c955-4c1a-e069-08dcf65e9402
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2024 08:08:45.2770
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CiU0ls6iYYUWgMauoN0oBTbUNkRShhKuVUydbxQ+mfpFOJbZUZSFDOBk5hx+1cVq3mtU1ZX96H74Mb7To1mX0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7412

On Fri, Oct 25, 2024 at 10:02:31AM -1000, Tejun Heo wrote:
> External email: Use caution opening links or attachments
> 
> 
> Hello,
> 
> On Fri, Oct 25, 2024 at 06:25:35PM +0200, Andrea Righi wrote:
> ...
> > +static DEFINE_STATIC_KEY_FALSE(scx_topology_llc);
> > +static DEFINE_STATIC_KEY_FALSE(scx_topology_numa);
> 
> Maybe name them sth like scx_selcpu_topo_llc given that this is only used by
> selcpu?

Ok.

> 
> > +static void init_topology(void)
> 
> Ditto with naming.

Ok.

> 
> >  {
> > -     struct sched_domain *sd = rcu_dereference(per_cpu(sd_llc, cpu));
> > -     const struct cpumask *llc_cpus = sd ? sched_domain_span(sd) : NULL;
> > +     const struct cpumask *cpus;
> > +     int nid;
> > +     s32 cpu;
> > +
> > +     /*
> > +      * Detect if the system has multiple NUMA nodes distributed across the
> > +      * available CPUs and, in that case, enable NUMA-aware scheduling in
> > +      * the default CPU idle selection policy.
> > +      */
> > +     for_each_node(nid) {
> > +             cpus = cpumask_of_node(nid);
> > +             if (cpumask_weight(cpus) < nr_cpu_ids) {
> 
> Comparing number of cpus with nr_cpu_ids doesn't work. The above condition
> can trigger on single node machines with some CPUs offlines or unavailable
> for example. I think num_node_state(N_CPU) should work or if you want to
> keep with sched_domains, maybe highest_flag_domain(some_cpu,
> SD_NUMA)->groups->weight would work?

Ok, checking num_possible_cpus() instead of nr_cpu_ids makes more sense.

I was also thinking to refresh the static keys on hotplug events and
check for num_possible_cpus(), in this way the topology optimizations
should be always (more) consistent, even when some of the CPUs are going
offline/online. Old tasks won't update their p->nr_cpus_allowed I guess,
but worst case they may miss some NUMA/LLC optimizations. Maybe we can
add a generation counter and rely on scx_hotplug_seq to handle this case
in a more precise way (like updating a local cpumask), but it seems a
bit overkill...

About node_state(nid, N_CPU), I've done some tests and it doesn't seem
to work well for this scenario: it correctly returns 0 in case of
memory-only NUMA nodes, but for example if I start a VM with a single
NUMA node and I assign all the CPUs to that node, node_state(nid, N_CPU)
returns 1 (correctly), but in our case the node should be considered
like a memory-only node, since it includes all the possible CPUs.

I've also tried to rely on sd_numa (similar to sd_llc), but it also
doesn't seem to work as expected (this might be a bug? I'll investigate
separately), because if I start a VM with 2 NUMA nodes (assigning half
of the CPUs to node 1 and the other half to node 2), sd_numa still
reports all CPUs assigned to the same node.

Instead, highest_flag_domain(cpu, SD_NUMA)->groups seems to work as
expected, and since the logic is also based on sched_domain like the LLC
one, I definitely prefer this approach, thanks for the suggestions!

-Andrea

> 
> ...
> > +     for_each_possible_cpu(cpu) {
> > +             struct sched_domain *sd = rcu_dereference(per_cpu(sd_llc, cpu));
> > +
> > +             if (!sd)
> > +                     continue;
> > +             cpus = sched_domain_span(sd);
> > +             if (cpumask_weight(cpus) < nr_cpu_ids) {
> 
> Ditto.
> 
> ...
> > +     /*
> > +      * Determine the scheduling domain only if the task is allowed to run
> > +      * on all CPUs.
> > +      *
> > +      * This is done primarily for efficiency, as it avoids the overhead of
> > +      * updating a cpumask every time we need to select an idle CPU (which
> > +      * can be costly in large SMP systems), but it also aligns logically:
> > +      * if a task's scheduling domain is restricted by user-space (through
> > +      * CPU affinity), the task will simply use the flat scheduling domain
> > +      * defined by user-space.
> > +      */
> > +     if (p->nr_cpus_allowed == nr_cpu_ids) {
> 
> Should compare against nr_possible_cpus.
> 
> Thanks.
> 
> --
> tejun


Return-Path: <linux-kernel+bounces-430791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF669E35EF
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 09:51:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8CE89B2BFBA
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 08:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F9C91990DB;
	Wed,  4 Dec 2024 08:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="asz+vEaj"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2053.outbound.protection.outlook.com [40.107.243.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8282A18C03B
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 08:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733301713; cv=fail; b=dmX9aJkX62+4t9JOuhUBQdYjtQXjNXFZWyJ0chnO597BHpa/nMLzkwkLZtWBjKfX30b5JS4FVNlI67OYb8wdD3Omc+2Khv7ryZKgdMfIObx2u+nkP6qYlHouaka3cnhGgOIPX7L6or8xYIfUAi2/sQ+5Kn+QSJOxhqzJbwz84tM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733301713; c=relaxed/simple;
	bh=l/VWl62rjr8BQTWfvoQIMeikbimX5o7dak2EC/ndQSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fdD+d5hJS8Yw+S9AJPX55iJWKTJ66/rINGEJU2vGIXCrXv3AsOR+HQg9A0xhKMRtPyHDjk1ETZOy+7KtDuxLgwCgF9D8Jp2AM9JiyPwJ2I9oQhEY1MqqQYmnaR73Na+hiEsCivMo0S21hyL4camvIsFSbAUDUDXdDgJiFDOn1sc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=asz+vEaj; arc=fail smtp.client-ip=40.107.243.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YgViyFag/NVWYbNupaQXFGE9BVSP/pjo+T3W3+vb27C9uKqSsR2rXbWDSzF48Id/Zfd+tP7iEE0scQQ6Fexd42JszViy5dabwlf7NgCkn4fjot9JmJ8MFMm6KVHID/n/uvVZj/PQacGTTe4YdRXVjxbKOvL4wz4OaiP+scma1SE8WKyoADrp+6FFIaDPA+TL6KFKPlhiVXwmXtYeREFg3t3QSLUTG5tG599Rh0wM5/v7EH6rivHqnRUpvJmsYnD05d36icNOv2KAUjQyRsavsPaLm4qCmOPvryZuYLnNRrV+p4zYIfPWF2VrFw8Quy/bv5EuRkdfyJ1R7XxqeWDfKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=chxt+TLO4e+mVZHOF4bf6Qk+BWFOVu7U8YG1mDa1CvU=;
 b=zCA/1dhaxxqOtE5BCQTM7S5Vx20IZzcSBVl+z9di+RsmOg8rDDjxsejodGK8GsV1gwKEB91Jgfkkd0nWqd/5is+y6gOJwDeTYG0/uDd6b9ytw0Qqh6Ccui+UpOjyK8uzmI2ysgYtEst6333tp8vHzSuGj3kiQi/wjiV/tFdgwNkcQ8qrAbjDBfhfwqq4Uj64Srhnhg5UW8eB7LLltdfcj9eFieQd+OCliKHZ208Lc9SbfjUktGOo9K2x/yYT/fVpUcbOKGpo3SKYlUTL+Ii9A1+8nQP6ucFGPO4mOUFgMuKb62ZUrpTlaj3Fgw2xiY+JKUXsmG0dwmpRVqcOwTsE2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=chxt+TLO4e+mVZHOF4bf6Qk+BWFOVu7U8YG1mDa1CvU=;
 b=asz+vEajjDfIjnUsA4WzA+XVrEZoUrDxCVYcImPW5G0MiK2gcdZtpChJSNaYpZLodvkN7UQjWueNZVakOhkufBk60jStwuP6MIXJBzAwFCvXfdp+eSzW90PGObgmPckDPADvX5P+KGT2emnvIMUYlEmiEQd1bN3LK879ehoPrBjY1Usgh74KtPLumXnr3l6Oa+lWctIVHkZ0Bt1oBFzYsn+SH3AE9dKOz8bily6EYQXg4BwfzjHFiOESYf4LQmlU95597urIvuJSJ/4X6tr/CPPsc9olMXSRJrFmbmN4d33hFCRNfq7hZuy41o4Wm4nLEkxGjCbJ3Hdy02dmNgqmGA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by BL3PR12MB6643.namprd12.prod.outlook.com (2603:10b6:208:38f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Wed, 4 Dec
 2024 08:41:48 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%6]) with mapi id 15.20.8207.017; Wed, 4 Dec 2024
 08:41:48 +0000
Date: Wed, 4 Dec 2024 09:41:43 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Yury Norov <yury.norov@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] sched_ext: Introduce per-NUMA idle cpumasks
Message-ID: <Z1AVx-yUY_37uMCb@gpd3>
References: <20241203154917.123419-1-arighi@nvidia.com>
 <20241203154917.123419-3-arighi@nvidia.com>
 <Z0-cf7gUzV8jIWIX@slm.duckdns.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z0-cf7gUzV8jIWIX@slm.duckdns.org>
X-ClientProxiedBy: FR4P281CA0111.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:bb::12) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|BL3PR12MB6643:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c121005-5782-4bde-c28d-08dd143f7de0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uNKEkLXZ5994oF93JGHPcc8WcmZ/5PbdWd+HEtCDlaIsOx6L4qe1cOGfpakX?=
 =?us-ascii?Q?PnWkcmPtdLuhVh4ENEmqKIibpNNaOV/bReGyVLQSBoWoIYXK70Fi6kUG5Rrx?=
 =?us-ascii?Q?zQBbUvHFnoVJytnRwd/nFxg9gd3Qe+mQnZpM2yZmeyety6tu+4q20SJsNL0N?=
 =?us-ascii?Q?J3eNmEzzLXVOzCmbreg9ofWnIL3+MgXIy/udSYvCFwjLO6ppzFRyC9XwGOMt?=
 =?us-ascii?Q?sJLdO4kePKLRks9/KlTfvfH8XFRQnjLBqbDC1ToE90EOUncFgPs0d5ckYmxr?=
 =?us-ascii?Q?geL19rqWDgrlaFwdD+s04iQuOSSIrAWLhSMciBoqJZhlL0ByIlWdg7tGc3Hx?=
 =?us-ascii?Q?vbqyDnZSDOUk7hzuAxvd/U49qIuUK10fykbUfOIKc4dPgYngGxYEsVPQUGtw?=
 =?us-ascii?Q?fBKkwRnCAPGDRRufvOL/vM+nmwYQgXbmi1pNpZbclk8lrIotCJ4ZclUpVSKg?=
 =?us-ascii?Q?tNSGJVk3mZ6UjHEM6AbIkVSU/J8uoUeHv9Ndyif2lSwcAK3+kWIW3Pg9NIZ8?=
 =?us-ascii?Q?gq/VhhZR/ow+9ncc1A7qqBLg+rBYw6UvCTT47tLsbwcO8THUIWfIDh1byCIy?=
 =?us-ascii?Q?HRwKQBZx7OxRwZXdu0xL7jZq7AVch+IPIqhQJ9wdm6ieBCh7ogCUdW1OgZuN?=
 =?us-ascii?Q?wZFHdxkImA2PGpY5HjKxETngAcVP6oIYQgkBxQ0vqrHNtvN2PC7Rd0o/5+/i?=
 =?us-ascii?Q?uiVQ9srNyKtLk64HUPC39LKXy7PVdCHHHfPuXhtgfqA/yf9C14T1HzhF/s3c?=
 =?us-ascii?Q?bfeZx+Ian5IME3BTrNyqWA3tdQvHxsGtYkKW2kkY1Ua7h52DmUoXWtVtCVWO?=
 =?us-ascii?Q?af210boM6Tr5c2RCUWfN8QCwm+CfT9qJpLKzUre7zZLRi6LeKhNL0I1ONPPm?=
 =?us-ascii?Q?R6/aymzExqClEafGzKoribkIZezAUmq8XiCfawwZymN0IPdlPcFRMu2I7Mz3?=
 =?us-ascii?Q?22uf4020mZueZW41kvmmQ772UkM90WyUHzchdMs0f+LIWPmwNbXe0mk8yOef?=
 =?us-ascii?Q?pmnkoTpcl5BHTGP6sZRUYTRCE0nhQOt6npyzSQZsRxXQedoRyHKZ3HzhOaqx?=
 =?us-ascii?Q?MPw7Q0ntTcP6/fOa1YbxCpCrK+CzVk3g3fdhsiW1VZlUDOLM7uynO07ZCCFr?=
 =?us-ascii?Q?hBRPgvO99juA7v33FWF40jo1K6wCofHpN18oYbUJEbUAJJEJNERPRlMIL3/d?=
 =?us-ascii?Q?6RcX/qC9gGtw4/VzXZXXVfrfrWOxT1pHbocI4xts/wCsR0QeLbDIxmYuKkLI?=
 =?us-ascii?Q?tfmOvDmr0Yqa1YP/x24mcVdUHc58Y0rx1xKN+A5xT6AqergbEw2t1QVNvB+p?=
 =?us-ascii?Q?GmhsrSS3zMypI39OAgVhQnCmVlYOK4Y57vtV6NZ7delW1w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?96ItRjEbVXhKx685zRm1bq3GBkkdnAizWbKPL5hSwThdzVqyGM5YSQscM2cx?=
 =?us-ascii?Q?Yz9PFQKdFQ3g8Q6/HJUlCZvy5UXSYqKfdmgBis5Yl1x1YCqWLe32OyQALM68?=
 =?us-ascii?Q?tvWyO11xXsfqvdR9dVz0gulWyYsSER0sbhbTy2NJXASuTtv38VmS9+Ae14sk?=
 =?us-ascii?Q?cxanqb4XFsf04Om0SEb8rFNKY6Okw0J40ax2LquM/O5tSA7SEOWNihDnxNC0?=
 =?us-ascii?Q?iu04iBsyKYC5aOPOEyYFZXG9kbkT9M1EkE+0clpthBE+QTIj9Q0UqXt7Zut5?=
 =?us-ascii?Q?oLwLV4EQvbGl7q/je/qIXM7mIUU2qf69oIJcNcZO+xn19lJmo/2G0f0Q55H7?=
 =?us-ascii?Q?IvlMytiHMNaRRxtazAS9j0ZxF9kQCchKUKZlcXMm30lXA15ieXyxk2zR5ebS?=
 =?us-ascii?Q?nuERTDpdoGx93B7gjn4GNif6rHVy6sC5gQgZ4JaW36XGYRCv7EbxjSY8NWv3?=
 =?us-ascii?Q?QLvEQidTZYbIXQ7obmgBD/o3MA9KEuWtve3OW36YxxocjR6rTqiZEgB48gw5?=
 =?us-ascii?Q?nKLltioTtxn+g7aBYlXwgZwGj7ORLGzV3DLHFw23uVO0NQ8mQ04AILg2Jybq?=
 =?us-ascii?Q?tgjtAMZpt28W99IOzlshJ6JA/AhrRP33Unzwr0po6+GNFwShtmKYR2rgvsF7?=
 =?us-ascii?Q?XKmQIY4kMeQaNKh7dR50/HZGqecn/1HVFpLl6hjfKvoE4TTTOiGk0x1kipBm?=
 =?us-ascii?Q?kb1z9CC90LvaK9LNU2b69UI9YMNV4zDLQqM38rgMs+GFM8hu5v2fTDIpkvPW?=
 =?us-ascii?Q?sgKXVRm8zsiPrYzxwUFOjiIlWjER5z4IYL4CPcy/fYQAAerolfjQCPYPj+me?=
 =?us-ascii?Q?TaipGfFAZar9K6D0B83RRgi0HSdWAfNvTWNw/iMHxcrMB+VqdIHeyc5mGaFu?=
 =?us-ascii?Q?iDwz/KxqBkzzmPlOyWfWduSVVcklJNAOik/PceQK3/oUVKUeob8pH2fVjCc+?=
 =?us-ascii?Q?DhjYJn3gm9dAn0N2GX1sYJftDiCIFj5Vhf2xrCzqnzzM7kcsPWygdNcMMT+x?=
 =?us-ascii?Q?/0SFJOPNbmuvil9qp7f+efuNEiAYpleRYTZQ7zJbs+FOa+lfEquUI9ApKTVR?=
 =?us-ascii?Q?yTBr6IYUoryz8e44zsXi4G34Y1hyyA6jb/Ks58SlrkVsQWkJG3kWrhoUdV7u?=
 =?us-ascii?Q?GF7VWXqjdSmFb2/H5iGdNwJTLL+FEoDNtQCvGdDi4pAdbs4FhAWdSUnfpApj?=
 =?us-ascii?Q?mlcF6f17YdS44yY8Sx/e4fEiWJwzpa/RyVcMnuX3ERaIN2fAsHfzOBIZVrBx?=
 =?us-ascii?Q?fGFwka7oxGNEcY/lgKqHnKHSBLUUpR+Z6keCZmoYyr7UO4g+29/5Bb64rbxu?=
 =?us-ascii?Q?jRBn6SzioISTc6+AJS/gWp9uF8aVq4vjJoAe+Dgmx9CB2G5IRhVtPn2knoxP?=
 =?us-ascii?Q?z2vmaozjaur95BeMCR/iY5if09+cK9WFjs6c0wN3q1bsgfZ+yQg50uwg5Quu?=
 =?us-ascii?Q?Ml5jFiyGCuPKeiP+bgirPp7ydt7qwQhb55p9GnpoS4nPi2TfxEUDNlMCNHtC?=
 =?us-ascii?Q?W57kxmopsSkcQiZngls4kr/894hbgOXnUh5C+oOLJGJamg8kzDYDydOjNZ0U?=
 =?us-ascii?Q?01tebJcMyGWBe+WmCTJqRPCMANNfyl5lV+FdVhKu?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c121005-5782-4bde-c28d-08dd143f7de0
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 08:41:48.6269
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U+AkkVq5jrYsmyfEOkju2oiNcEI+v0sfGSePdxoMZ0Oujwkq4BOjnaHlfFpIzz4qpgDY0oqj7fXMcKbAB7fCgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6643

On Tue, Dec 03, 2024 at 02:04:15PM -1000, Tejun Heo wrote:
> External email: Use caution opening links or attachments
> 
> 
> Hello,
> 
> On Tue, Dec 03, 2024 at 04:36:11PM +0100, Andrea Righi wrote:
> ...
> > Probably a better way to solve this issue is to introduce new kfunc's to
> > explicitly select specific per-NUMA cpumask and modify the scx
> > schedulers to transition to this new API, for example:
> >
> >   const struct cpumask *scx_bpf_get_idle_numa_cpumask(int node)
> >   const struct cpumask *scx_bpf_get_idle_numa_smtmask(int node)
> 
> Yeah, I don't think we want to break backward compat here. Can we introduce
> a flag to switch between node-aware and flattened logic and trigger ops
> error if the wrong flavor is used? Then, we can deprecate and drop the old
> behavior after a few releases. Also, I think it can be named
> scx_bpf_get_idle_cpumask_node().

I like the idea of introducing a flag. The default should be flattened
cpumask, so everything remains the same, and if a scheduler explicitly
enables SCX_OPS_NUMA_IDLE_MASK (suggestions for the name?) we can switch
to the NUMA-aware idle logic.

> 
> > +static struct cpumask *get_idle_cpumask(int cpu)
> > +{
> > +     int node = cpu_to_node(cpu);
> > +
> > +     return idle_masks[node]->cpu;
> > +}
> > +
> > +static struct cpumask *get_idle_smtmask(int cpu)
> > +{
> > +     int node = cpu_to_node(cpu);
> > +
> > +     return idle_masks[node]->smt;
> > +}
> 
> Hmm... why are they keyed by cpu? Wouldn't it make more sense to key them by
> node?

I was trying to save some code, but it's definitely more clear to use
node as key and rename those get_idle_cpumask_node() /
get_idle_smtmask_node(). Will change this.

> 
> > +static s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, u64 flags)
> > +{
> > +     int start = cpu_to_node(smp_processor_id());
> > +     int node, cpu;
> > +
> > +     for_each_node_state_wrap(node, N_ONLINE, start) {
> > +             /*
> > +              * scx_pick_idle_cpu_from_node() can be expensive and redundant
> > +              * if none of the CPUs in the NUMA node can be used (according
> > +              * to cpus_allowed).
> > +              *
> > +              * Therefore, check if the NUMA node is usable in advance to
> > +              * save some CPU cycles.
> > +              */
> > +             if (!cpumask_intersects(cpumask_of_node(node), cpus_allowed))
> > +                     continue;
> > +             cpu = scx_pick_idle_cpu_from_node(node, cpus_allowed, flags);
> > +             if (cpu >= 0)
> > +                     return cpu;
> 
> This is fine for now but it'd be ideal if the iteration is in inter-node
> distance order so that each CPU radiates from local node to the furthest
> ones.

Ok.

Thanks,
-Andrea


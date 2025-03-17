Return-Path: <linux-kernel+bounces-564799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2863A65AE1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 18:34:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 066213B09C4
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 17:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7167116E863;
	Mon, 17 Mar 2025 17:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TM2qwPo3"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2055.outbound.protection.outlook.com [40.107.94.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F0F17A2E5
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 17:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742232666; cv=fail; b=VlhgvS6SDSZjiiI3Wp3Dre9afuaICFWNHqJ+6T13Az3QheHfUZrg5qQo4xlITW5mhiNjZ74rOO6q7wjqYfJaoCvaLgWg7afN5FUPa6UOq5sgP/nm7gOKg1t6K5FdrxZZljnDnmjMbLpOJAcA77mz8FmBoah8N7AiMJA0MOEHHTc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742232666; c=relaxed/simple;
	bh=xWc3PJkkrudL+tjaPEUB2PMo0upK2YzayvtQEJQuTEY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BODkN153dqwuW+3+vDXZG263crbeP9UuWB3pg8e8REPt5Xr6irlLycDPswF0VQXDhiFBcaVmBjGcW60OKEZ/YTq9frDKVGnyIgNR9Q99Atp5+Mo6jN6+2yfL0qKhR3OWeSR92LVbXwr6bZlBvK1vkNxJy3xUJIRYdF6XXfWLCA0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TM2qwPo3; arc=fail smtp.client-ip=40.107.94.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xs/cJAMfcAelRbIMeAFqA3xj2nqcFPdewCaMXMRT7Q6TvVfykrJhsKTlizF0Z11RxipVNCDbe5iLhxDbCHvAWEkfLXn6iBLygEqgB75uz3XCpLOxhdUqnQaRK3aKDOyBH6MnXoX00e71DjRS4tRIuq4kAWeO3MhBK4YVXY0LTWUOvfX7AEuvgTlqNCNmVIbIe0eg2/HDDPMXtT322U7uOwx9XRrGjllnfpj38exbkVzMpIokY4UkqbD84sZEw97jiEdRL5Lrm+htrNdwTw0wjjQSqK4s2iGR29LucyKhtbmH5oFcMu1s8fS3B5ERbOFqU4F0+bitT0Dfi2ViEV6Urg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m4tn01afTISaSaFEGwXKY6wL6PNx4JLNxQgIckAMwNQ=;
 b=NbrmnYW6uBnUH8Qf/9w84cDfiKw4pHOXBCirCVPO2+mO06IHAVIsemSXkmCQ26wGuT0PDnkzIaKF/eVTPzASPDb7hvkXsf6ALsTZCpGldHXptUB2IG1hQzzU70c5Ee12+3doJNzkjGAyXI0/1hAimduiYe4PNd+Xdp161lMgdNyNtuYmi5cNWUi76BDS4zzGEW+YiaYsD303JHp9z/1GZBRRpcT77bHK0caJ2kCw07FGj6jbj+6f1HEoPUGIF8tXBCyge6xr1nYkkqp8lOcGnF7L+pggj1C3KvN+qoWNaIBXE8Aq9OWrd1xFUMg5J2Mab4W7al1ZcR1zHEpI/Yy6Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m4tn01afTISaSaFEGwXKY6wL6PNx4JLNxQgIckAMwNQ=;
 b=TM2qwPo3yNeUqTLkBw0Ls2mCk5D99nBWjRbDVbK+wE5wDJdsMgn/uVBM+EyIt/OBuesCbH43CKFzLSlKmMGDMNHvwdK+fehXo8PmOHngwB6fiQCx0pMpv0VUFlcE0v8NePJ02fnerR6NvXz4I2xMUGYGJZoiPLNnw8oSVg1bZKok8DC2WjG9VEDSPFvMDd5NWH1D2MhKnm9klu0UxpqnMvAdrBOniR4c7xbF3yVdMZQipgpgGWa9mqrsI2VbmOan43XwxleppDNsxo6QslcD4eHGIrDwXNvNO8SMPeOIKNxP3oGaKXohJ2mOwYeisdQEd0ikx7dWop1/oVRScFFX+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by CH0PR12MB8530.namprd12.prod.outlook.com (2603:10b6:610:188::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 17:31:02 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%6]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 17:31:02 +0000
Date: Mon, 17 Mar 2025 18:30:57 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: Joel Fernandes <joelagnelf@nvidia.com>, linux-kernel@vger.kernel.org,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>
Subject: Re: [PATCH RFC] sched_ext: Choose prev_cpu if idle and cache affine
 without WF_SYNC
Message-ID: <Z9hcUSp6P72wT5ig@gpd3>
References: <20250317082803.3071809-1-joelagnelf@nvidia.com>
 <Z9hW_3cPN8u7VURV@slm.duckdns.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9hW_3cPN8u7VURV@slm.duckdns.org>
X-ClientProxiedBy: MI0P293CA0003.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::9) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|CH0PR12MB8530:EE_
X-MS-Office365-Filtering-Correlation-Id: 61bdf662-6fb5-4a77-0c63-08dd65797d20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uxXwkLBLGprm/NZIjP1BAXWRpgrgvFGo3iyDcfyRCZYa6RvjyD9rDyfmjG6m?=
 =?us-ascii?Q?iV6uBDnShfi2K6rZ3gZXdFX70KgL3UrCpebLGeW9HnidE+E4Rz/pbREQ46uL?=
 =?us-ascii?Q?MROuBIlLPnuVqD3iUt8CbQL8BOfLESukCWmr22VhfF13FPzYYFHNr+SDc9hp?=
 =?us-ascii?Q?jcVK1Ojk7d/E+21hzFSphPZTs6ecvszJT7YxdOO8+pUXBoX3y93VCxImyoNU?=
 =?us-ascii?Q?pTy1F9GXpTyCxTxww5GoUS2ZwIB4mg03Q9KrF+dVxxcJ6vvth9NMhQxNVA/E?=
 =?us-ascii?Q?e/R/rrt4nawiPLM2VIBRkSur8L3H6NYAdjM0ErXPRc69waAO8pZaXnDR3Rim?=
 =?us-ascii?Q?tA3RMQE6TyNlE6gJM/ss2p8VlNacmCej4IilusE06jTYLTOFijd2ZmKZ69Ok?=
 =?us-ascii?Q?HX/rVx+Ln8tpwTMgCWpLW4KHqrGHPWT1+/pctV+ttYnzukYuIgLNBXfykb4c?=
 =?us-ascii?Q?tiWjuRRruMHALukQppryTHC6koYbsnCwa90bnMmHaLa9nxGngINp5StMWjJu?=
 =?us-ascii?Q?DRBbynmvk7l9Jng8JtofvKhpYZT5DtouRMYuFfjQAoOqGHZE+Th2OXMYG8U+?=
 =?us-ascii?Q?eTK5t7jAV/JSDnWjfy8/ZKm5r1rOW/uAxbQW5sOIXh2Tv40lK77+tmRA65GH?=
 =?us-ascii?Q?7VlnwrTjoZSkG4kpeDwbkcjieQ3Hro/8XwVOZwjCOv84SR9IMSzt1v2TsmjC?=
 =?us-ascii?Q?CZ60D/1DTJYX8ISKbWEEQRiPiavYY3eoOeoSe+UXamtItw1wmw7C1QuJxymX?=
 =?us-ascii?Q?k91ZoYhumQqC0BkWzbNEKVePG7CwXnr7OGwJ/vGdMiq9fs6Lz7gjnusZpM4U?=
 =?us-ascii?Q?6uZiqxaWbQgbt4tIi0zg342C80nIFcitt+MdYwd2e8AUllFrRaUUdyW2vPVz?=
 =?us-ascii?Q?C/9FP9MOIWE8pFW2lDqXqqS2vS/+345wl2WXKcasDYr1DjNNILnvctVKflEt?=
 =?us-ascii?Q?EBBvS8sHaVzecTBQDSTcieq0dbknxY0lvsLf5nlxj9jR72A7Ug2LbghEZe2J?=
 =?us-ascii?Q?dULKZ914enwBruMewvzbNpVlzWwk94IZtRs8XP4IB27eKgMpDZClYqswHblU?=
 =?us-ascii?Q?4O3xSfY7EXdxrxrvwYRoSecXHxZk2Oo5//SEhiG0kSuN9ar7QZK/tm2YONHo?=
 =?us-ascii?Q?gjoPkDMfT5LnF0QjnFD4UnPP7Ti4n9YVIe8OzLGqsDRrj82n1cev7lL9bW6I?=
 =?us-ascii?Q?P5QFMM1KCpcUXDRVapWe7bP8xvFxMLN5wkFe+fLq6781XH3wUw0r2Nnj6Wfv?=
 =?us-ascii?Q?DhyaJsUZX4AQVHT8TrsB2qOKZ5hhnj3hpi9+x16NDjhudvzcQIOqkT6CtJBB?=
 =?us-ascii?Q?7flJd99ZgRUpgvx2RAglW0nf+FcYD5+eKWcpqSXg5bacBFV79ZoDsjgbmti9?=
 =?us-ascii?Q?8McJUpyYZYcOwFin/vVPFdwbaTjL?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jN6e1mX7R4Bu8eLsSbHb4C0vzftb/EhnHYjRG+bGGkmW+i6XmKZwTqufGrof?=
 =?us-ascii?Q?WCia8DE57DVFJU5P9YmsEggq8j6xMiJ7cQU6xyHzxmEC8QHg1yougo0Ig8eF?=
 =?us-ascii?Q?iajnsJ2EZrnWVMCMpMwq+KvpxNmWssnABUyEo3JR+E92H3hWAk6b5tMYV2pa?=
 =?us-ascii?Q?+upZPOMwLlYY8H1/6o1gWCwS3qHaiwMxRvq1MojboST9eYIA5pkyibmFa9MR?=
 =?us-ascii?Q?3z9hT308p5r0H559CRGQmhBOFz2rdBEC/b0dm84bosps3YekWvhMjputpwiB?=
 =?us-ascii?Q?8ngIIaxI+/ZzQqNiI3fOku5LT5jQRpTXPzXAf1Z7EP9gYvR1kEXkNk+c/89D?=
 =?us-ascii?Q?hFc5tMAN1S/sjXHO1V7OpbHxWz7pyI/XZ+Owu5f3ntquDSfEE00tmgI8FWdu?=
 =?us-ascii?Q?mUzBHsExhd//OTmuodU3yhDLMWIjrbH9Op7os1ONkyVH5rdWcMgzJrambC5G?=
 =?us-ascii?Q?K57FosK7Qcsqzg4AemKjkiOS7KHxR31TYDMf0EuhamYcuR7NSARy0TdUx+NW?=
 =?us-ascii?Q?hnKebR1eOFB2XDJui0EeWll0gmAUjorFa0T+Csn8kAc6P3O0v8AwpUMz3wok?=
 =?us-ascii?Q?dVNKLwG+Bpu2Iz4dcB5Aud4AIhdXhpysqhmHxSz9tAeA/PJHmSQJDsCWNCGB?=
 =?us-ascii?Q?oGZp6OMRWF/vAC8OvXynJq3lRHRTSut12uHjo95jWKYcvZFhlBT76a/SHMy4?=
 =?us-ascii?Q?4IyiPnZZoJLD8YF7PeOJgiOqQueBhl9sViUzSGU1a8/VolkvueGutJS2BGVZ?=
 =?us-ascii?Q?0JFM/013Sp3872XcGeEFXxdnIew8Jck+uf7x83vaDlf2OGvSMgjQRBOoCjfw?=
 =?us-ascii?Q?CB0XInOQt/yHCUsJSe6OXsQVFsNEIa9rnFrEB8Z2GlgaZG5t+ltvdivz3/YY?=
 =?us-ascii?Q?Ehx9Acco0AiYWFBVyQF9N38uneSbWmu+8bPypNxHcrVFoXZ2InL6HTZ7NomB?=
 =?us-ascii?Q?o+/dDGwMMLA33GVOaQNngcabYdlQA+g9+hk4X6/4i/FROPcmnMV2sr/2mz0K?=
 =?us-ascii?Q?mztg/4XdzgODeGQNqcXkiluT7175MRaCs/QIFZIzpLNAU4kjfxji4Kfg79bq?=
 =?us-ascii?Q?wHG5O4T8EQM+iL3zVkSELRsDbJxmjEsg2ORSbxV2E9gSpCJXRdyhiqjnYoxX?=
 =?us-ascii?Q?NQHBB2GuVz/qHcrx4CcVlTiEa4lhVcN+yYi3uX6jPcLW4qwS/DOXh+434R6x?=
 =?us-ascii?Q?YFeR1Jwzp50ddcB+v6Vk1UpdFm+89NcvELv5HbnCJZXJgG6m/Dw0rQw1YZMW?=
 =?us-ascii?Q?aGMYHut8nH9NXQ7bDJHevP3siNya4wJg7NBOnd4O9swJPQy4SVk31n0MKiJy?=
 =?us-ascii?Q?K4DD2u7d6nBQ1EIWmi4Ny8vpS1Rfj1EPedhpegBRR0yqM8T8KOLxciLaS3Y9?=
 =?us-ascii?Q?c879vnOuy/CdmaX66uY0SszU1sNdr44lotwe/8krkzdL7y1xok1kDOB4IR+C?=
 =?us-ascii?Q?aLbGldBAZFCUMzVtDDYZU+j/ijxR/mobFlUc5HY/UEPeNn9DO3aCon1+r+Yj?=
 =?us-ascii?Q?CzRWPdONSnYnaGF7rMZhVCsGCjzNd3HW+aKOGsgNJpyhbkSUr93DFAR4RYlW?=
 =?us-ascii?Q?3b5Mht3EytgvJpIsEmx+C9Kc80ildRDzub9nQVE5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61bdf662-6fb5-4a77-0c63-08dd65797d20
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 17:31:02.2666
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rK3UfUOTgijezN+hdIq/eVC+4KqUjUSwJBVzOwllsUIiusgG+oV+ijFVIGj7s1TeS9NDbTKaUhCVopOUkisaQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8530

On Mon, Mar 17, 2025 at 07:08:15AM -1000, Tejun Heo wrote:
> Hello, Joel.
> 
> On Mon, Mar 17, 2025 at 04:28:02AM -0400, Joel Fernandes wrote:
> > Consider that the previous CPU is cache affined to the waker's CPU and
> > is idle. Currently, scx's default select function only selects the
> > previous CPU in this case if WF_SYNC request is also made to wakeup on the
> > waker's CPU.
> > 
> > This means, without WF_SYNC, the previous CPU being cache affined to the
> > waker and is idle is not considered. This seems extreme. WF_SYNC is not
> > normally passed to the wakeup path outside of some IPC drivers but it is
> > very possible that the task is cache hot on previous CPU and shares
> > cache with the waker CPU. Lets avoid too many migrations and select the
> > previous CPU in such cases.
> 
> Hmm.. if !WF_SYNC:
> 
> 1. If smt, if prev_cpu's core is idle, pick it. If not, try to pick an idle
>    core in widening scopes.
> 
> 2. If no idle core is foudn, pick prev_cpu if idle. If not, search for an
>    idle CPU in widening scopes.
> 
> So, it is considering prev_cpu, right? I think it's preferring idle core a
> bit too much - it probably doesn't make sense to cross the NUMA boundary if
> there is an idle CPU in this node, at least.

Yeah, we should probably be a bit more conservative by default and avoid
jumping across nodes if there are still idle CPUs within the node.

With the new scx_bpf_select_cpu_and() API [1] it'll be easier to enforce
that while still using the built-in idle policy (since we can specify idle
flags), but that doesn't preclude adjusting the default policy anyway, if
it makes more sense.

I guess the question is: what is more expensive in general on task wakeup?
1) a cross-node migration or 2) running on a partially busy SMT core?

-Andrea

[1] https://lore.kernel.org/all/20250314094827.167563-1-arighi@nvidia.com/

> 
> Isn't the cpus_share_cache() code block mostly about not doing
> waker-affining if prev_cpu of the wakee is close enough and idle, so
> waker-affining is likely to be worse?
> 
> Thanks.
> 
> -- 
> tejun


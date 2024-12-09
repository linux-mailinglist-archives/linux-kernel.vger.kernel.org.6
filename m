Return-Path: <linux-kernel+bounces-438555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 724379EA2A4
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 00:23:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95858281DD6
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 23:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79F251FCFF8;
	Mon,  9 Dec 2024 23:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tUGMkpmx"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2047.outbound.protection.outlook.com [40.107.92.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395BD19E804
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 23:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733786593; cv=fail; b=HYkwsJGlpIHKLTJ6zb2nmg30+JEZth3y+eK/4cDL0o7Ul/0t20KmI15+dp2WWmR8aNYW6bOjCxezOtRujtmGb22g24UKDgxSf9+qUGtT5qMkr2tQfm9DhKzAU0NFkIKW1//wLz7IGqTrjbqJ0IewSK8F2nLcjke0DxQmlcVUUg4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733786593; c=relaxed/simple;
	bh=gGe/P0ThWPd+MwJccxHekiqcMfmkD4IvfVms72ZzZ2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VYlH3/7BY3FHk3KHuE2wE2s1xkCjYk2QVjwWS2vAAs9LkDzx/wZGi4gnax4v+0to3L9s08SA2KQIrmcvDUWrynud5c8uIEc1Ei08ZE/UYrt2DoIde4WIhZkTC/zOxwv5ViKpdT3WUxwt+ItB+TPtcPVqjBwdTPoVHsAJW3AEuWc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tUGMkpmx; arc=fail smtp.client-ip=40.107.92.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OIoFQe2YgdrAaRebEG04/g8Yv9ouOg9p6Ia2GGjhlkbx3RFO5/JXyfG8uKPhBH3bsD/oqzJPuQGPeFDOmOtANWG9BaB3FVgsMjYAZrvThhh+MNB+lBWAlXIz0FDPPd+WIjw6962+GKOFDd2PkghPlF8MzUbce8AR60fR1zkwFsZnhhdAv1EhXKBifSzGsT3ZgSK+FSSgui2atzSXEq9TdT1DyA56HLkYKXYcj+iQot6+Vgp3m6YYn/Bg19vBBqp5+AkOm74B0NetwnLwcSmmDDz0jcs1UXAzojs378v3A8JEtITjgXCy4ZuuzOXed5jdg9aCC9EpJdlT1u4ZzxhYjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fYZqN/XxbAXfYdGbYvZFvG6HXGeiXUpWhBE8Z9SI2fg=;
 b=jrXb/3/xJbAKKhDOCxY6440YSOKUf5tg6NPR7hTAFbut1k/yFQ9Yj9f8tK4DGUfnBAEYZYRwYilry/FCkUeKzd1y3G/aM0O33Czfkp5lm1xMcWh9bp/qPr3r86Y8MLob9NhrR9XdV6YquWZuDpm4IYk1ynhrpn3kFmPA+yXK5G45SCXZj0U7uFTxeq2sXXR6KnMAm0RnkXJCKBACXBxPjrleYQVGWWk4N2KYGQ7lWDpNWoMXnfA+rUwDTz+FVJTvqVNfjsaFd2VVU22YTaz9gGCKuxlpJZU9SSAJRdh1MWGIdXbwXksLvFumR7rWo5OwjuwponFB1IIRO9/R8Q3jxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fYZqN/XxbAXfYdGbYvZFvG6HXGeiXUpWhBE8Z9SI2fg=;
 b=tUGMkpmxRE5nqbOAu+uvwH0TnPLp6Vd8sStQbV+TKqB3aw9j0v5TzYYwT7AbjQpSJASYcXpqITgiy7ZAg8lGdVOxVTRph6/Tv1IWyB9lnTMqqT1erG/+oZ5AMHEr5EHC+mCzzn+RTDlQPNgNe+Kmf/2mVKawFEtO3eOSchcVjp7WYjLdDw3ejdghOyTsq/dhH0TeHYcLYgu7LxnylSdnMMKSXuzD1EAt0WVY3jhkNMek/2QFecSVGsaXODtjs71bqyhxf9snHWp2iXRh2RJo/IkRfwPUXP+E7nOxV4qagWQZDnSsjDBfo4n/tOSQK7HLiCU/CBvAmaYr0fYkcuE3Jw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by LV8PR12MB9133.namprd12.prod.outlook.com (2603:10b6:408:188::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Mon, 9 Dec
 2024 23:23:08 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%3]) with mapi id 15.20.8230.016; Mon, 9 Dec 2024
 23:23:08 +0000
Date: Tue, 10 Dec 2024 00:23:03 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>
Cc: Yury Norov <yury.norov@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET v6 sched_ext/for-6.14] sched_ext: split global idle
 cpumask into per-NUMA cpumasks
Message-ID: <Z1d714H-YSMrd0Dq@gpd3>
References: <20241209230242.775225-1-arighi@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209230242.775225-1-arighi@nvidia.com>
X-ClientProxiedBy: FR0P281CA0010.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::15) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|LV8PR12MB9133:EE_
X-MS-Office365-Filtering-Correlation-Id: c810bc67-cd66-4193-8926-08dd18a87106
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uSipaD1h7cFYqXdTNUvnWZhuvuzwKNoQ7MMPtqCCcwfH35thE4elJ7Ypx1LS?=
 =?us-ascii?Q?x6XjQTLPi6lU2u7mNLqYqnO9VCdJTKGoJJM5XWL1VSELEp2nzV4Tqc9zmszJ?=
 =?us-ascii?Q?thW9VmwZ5wMW2A7tkM46ax7nQSebvXcHfqFpHgVYTZz/qvJ+aG4vlWO2KhjB?=
 =?us-ascii?Q?4Kp3QKoTtNQkPwovDAO0Fx02LoXhSrhe+EnHjL7SFGfE6MOhYE6vC48OoJfN?=
 =?us-ascii?Q?lx5osDLnUBK4H+dNQCbWax+LSc6ehEtApcFOFXtnYxZEkzb0XCAhYzGfnMVm?=
 =?us-ascii?Q?cBAwuFQmG2u92jy+PBPt2hPnqPV7FKp2L5eQ/vOGGe6RCSyxe0Qq9ylMYccK?=
 =?us-ascii?Q?YSsV/bh/8EfR3fmOtD+WxkpqyM3rSh93TzJZPa76m3ACZLejrC2a1EFiZA7l?=
 =?us-ascii?Q?haScbbiy4Vt15KO2hgcespuwD+ggO8nUdKP4I/V3wd5Iw5UvkVitpxqZi+3L?=
 =?us-ascii?Q?C2+Z9ipclBxGQXJS2xYSRbPaRAl9C353hGm2ToWWOp8fATdUJT3lR1O5DET3?=
 =?us-ascii?Q?cumgtpB5fdCWsT9kfLqrLWChT5OGOsN5D1VWEQI9HMad/hburItGbnPvwKZY?=
 =?us-ascii?Q?Gmy4EWiiRPNi2Ag5BM/gcgOpeYrELTBCaWRzrAfGYAOTWwyIXiVv5Aq19G6o?=
 =?us-ascii?Q?Rvb4LWfHDP7wXqC/5yS8QeEf3PtL8Hx0dCSEHs/vVHSzD6VZba8rrCh1mb4A?=
 =?us-ascii?Q?yWQZ/QthN7Aj/AXwuWHCnRdfY7gcigCzXOtv+ItjMGWqT0ILsu2A9U9UGgK8?=
 =?us-ascii?Q?PWHy/oRq1WeSoq7PgYGzPatD+0lCrX/uFIbWP9vOIY2btyzY0Psb9vbGFBA+?=
 =?us-ascii?Q?Ciw9BOVZdgGK9LysIlT3G6gJ5a9rsKAJgg2UDGgIZelnEGQvVXPRzt0RlRUB?=
 =?us-ascii?Q?Fu2Eb7D4Jerps6EMkYRvTWMIWHv+MwxR4qGnRsULSr6RQyWuf/6pwmdTGUkU?=
 =?us-ascii?Q?y0G52D3tNWbCLkBVB0zjuiDzQS3wuk75Z5x/vQRM+ZJAizGPXhcQVT/gcJzq?=
 =?us-ascii?Q?oVzHE2CYmlZLY5ovEbrOfOTiLcVk+zgdSFdvPitTAKMbvPE06VyoQc9J86aI?=
 =?us-ascii?Q?weijz6pMMXBwgpc9IF/wzAD4H3at3X6xK1LLCAd8LTo6U3lFXm9Pu1Zq+YAL?=
 =?us-ascii?Q?d3Z/b2UH4MrQgAWwCgOj8qkQy8m3VPkujgVHcBx6ETfXqxmR6FENuRzEUNEw?=
 =?us-ascii?Q?Cy6t5HKkNyYLhoccJiL0Z+BKzRavW2d2k3DPfxU4c1m8iwX+X7qgDo5/Uevo?=
 =?us-ascii?Q?tsjKgpw2asLxJVejWQTdVCljX4C6+GbXgd7aPDxI+H45Fm8NXdA6KAb7gb4+?=
 =?us-ascii?Q?+lv0CcF4o6eBbbZ/d3L/GPSbNmqRJTYHjaZ21DMQ5jZ0dw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ta/QrgJAiQCb77sUmxTBYEmJvp4uDLUFR4uMdSjzj22rVRFR42eEYF8sq1IU?=
 =?us-ascii?Q?M/ErJT1mrT8aebW9AWZ/4A1hlaP9u23qImg52L0G+NzSBx3AdTS6RBj/N0p7?=
 =?us-ascii?Q?Adz9Ajop1Xog59vIUiNJ0dsH4Egga2/s4e980fDlh9tDhLMlGuvQ77XNBNA1?=
 =?us-ascii?Q?/C+EaaAWC3Ov+Pyf5dZPAiT2UWZxzM1oaZqTYqxigfC6dRfOoZAohNt7W9se?=
 =?us-ascii?Q?D3uI0tMbIPTXGiNRKt9jCWYL2aS4aXmRczTIwSJYaqade2NzQsDgKKEVLJg6?=
 =?us-ascii?Q?rFzPgeaYfcsQX3MD1Zs9WnFhIxiuquheZgdqF/aGkqD2V7kAynHUV9JMHVKi?=
 =?us-ascii?Q?ank+lmLLpaSifPOa4jLu9XHGg6nJ1pixXwI5hh1rOZoCjdCwUyt1s3fE0Ui3?=
 =?us-ascii?Q?b/9qINAlySozkSZ9ByKgTRZrR3PmnDporvr7xW270wwh3Ldgt1fIm5CYg/wy?=
 =?us-ascii?Q?eGrEkJpOarJH7MPH4AE7fuMZl36AQuJpFCZOkeV2doGNB83ZfuLLHCXYCds3?=
 =?us-ascii?Q?S9vr9GUFbHn49djGMLuvkbMBAqy0QE5+Z/zFZkp0i9oxEVxwLKKh5k9eV+P8?=
 =?us-ascii?Q?eDuAqKY3iOMDSXsQRuoDfKWf9YCxF89bWFhAJEvu6I/zHbNR0etPbWoh2UA+?=
 =?us-ascii?Q?cglNTfJniJOMoHIE7mx961UI73SREwzRXPBBMa9mMiT7ogDPYu7wTRox+cSM?=
 =?us-ascii?Q?SZxSoQIKDPXtZCrvZ5Cn1d6JEvmgzuqcJHn/vdfRW3droW2NxjdcruaVHbfC?=
 =?us-ascii?Q?BWImu7BYH0dFMKH6a4TtYVbbZqQFCZ8Rblp886rjjvh1Hw7d3O5wc3Ah2VfR?=
 =?us-ascii?Q?sHMzG4wgYfeCJEXpm29HWSxCNe4Ef3bIZE+bkgBlndM54uzuW8ZvJIY61+eQ?=
 =?us-ascii?Q?mcR6qJeu1BBE1npe+oisJqhcT4xuBeEaPT+PjuTa5h7zwyBS2coK5rcBZ9jE?=
 =?us-ascii?Q?W/BgENnnrymehrMoOE60uFaU16sJq/SGf5kLnP7xXFWsUUxnihTmfKE5ZaTD?=
 =?us-ascii?Q?YMQ093U0KjydGMV3x6LW1pm4hd8R5BfU/rgq2vEBM83t8X56hqKy8XzDY36A?=
 =?us-ascii?Q?xU/UYy5s0CPuUNhKJPF4HlByVmUiSpm7lSb8vTRuZvwf5HC0tWjh8gAZcdQF?=
 =?us-ascii?Q?SfOqK46yanp62D2QgADLVB19JVQRlNCUq2Qm/pNMZVI+MUHM/Zcirjpl9Ki0?=
 =?us-ascii?Q?iAhLi/cplYlKetvau5gudp2qlmUBVLYsX5X6duFaA1cXDLZzFHsUhQOv7ukk?=
 =?us-ascii?Q?ePSs1K8jhqYYh4ExTySgeLPlM24iNUZYfiiYx626oeRSR0mmOX/io+YA2Kkm?=
 =?us-ascii?Q?7leVfSn+1Rqsl6vh1cnM2GXMvM4zc6wO78guMI7TdvRbzsX1JUHRa8ljvdPw?=
 =?us-ascii?Q?rms/1c8qtGfVWCwbG5zg4WcPYXLk4Ndbi3MZakB3fnex/bv828IgPGg/VNhQ?=
 =?us-ascii?Q?tOCLvyuz6BRDsGvIYCIvMKAyFRQufkVWEyzLsHAfsf5dB7XmQk7JjJOGadIf?=
 =?us-ascii?Q?JLq+Ke0lcda0bEXtPFESp78LbCrJjW9fYDuxLS9oU8vcW9UFIQTkGwEigbgT?=
 =?us-ascii?Q?82Xla5qvhFHuL8gcOZb3tAsaCUxz2x/uZ7VBCZ9i?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c810bc67-cd66-4193-8926-08dd18a87106
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 23:23:08.7516
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0YU+g9hSz7z3rafOCvd6MC8S5z6TrtuIJ2jaJxRFAM5zwJTuwTVX4WrVAPPHgDLr4MdF8CG01tUSZHBFZrIMCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9133

On Mon, Dec 09, 2024 at 11:56:24PM +0100, Andrea Righi wrote:
...
> ChangeLog v5 -> v6:
>  - refactor patch set to introduce SCX_OPS_NODE_BUILTIN_IDLE before
>    the per-node cpumasks
>  - move idle CPU selection policy to a separate file (ext_idle.c)
>    (no functional change, just some code shuffling)

It seems that I totally missed some comments from Yury, I'll address
them in a new version. Apologize for the noise.

-Andrea


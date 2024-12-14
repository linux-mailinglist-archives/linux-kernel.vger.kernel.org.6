Return-Path: <linux-kernel+bounces-445873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BF0B9F1CE2
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 07:06:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F92F7A05B8
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 06:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 536997E76D;
	Sat, 14 Dec 2024 06:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XXN0mqji"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2041.outbound.protection.outlook.com [40.107.96.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ADAC27450
	for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 06:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734156384; cv=fail; b=izDT6E3fKym0jojZvSN34t2JhxvY8RxvpQ/LRl9Lh1DcLg3sVn009S0G9hz8/HdWeTGrwf0qyW0HEXtIfdTK4/A1hC83URH4HGNSkQd/LjeYVpgXjTEkIC6XWHpFpwFEUqgbHr8myOoBaVDBaqWpI4s0AcFmOiaAV4qXVXSz1nY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734156384; c=relaxed/simple;
	bh=VbMH2DtpWHWMoC4pXHWjKZzfaIlSrtuM7K2YIkxdx08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BC7je6ZH/B19PaDXEzh80uBp3xIGlJOYeKAlWRAAcojmXrGXRnAGTGNTMtf457IIo9xkFK7+NZ267+rwsNq7AXUlXstRUMH7xv/YdhiLn2FQpJ9MUEJhPi/CKyWKh5azr3DFP26Ln+ls0KZeZ7oaReFBqOjnkaEVgdprZp3pp24=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XXN0mqji; arc=fail smtp.client-ip=40.107.96.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h/AqYW0iZLD3/PpP8TG01NfInNYA9teciMZUKuI6KExNSEd3nd8N2T22TPri1o8Fk6DqxrBBoS1qD9t08iJpteOTkv/ds6SzYvSIf6kCI3wr6ofT+gOe1BfzdbLyN5/cykgXXBL40k5IGPOs3ZEGXl6hOYQcU85+MrjKy6MSk482iVysLBTaaKeI7cGMc22IhzBp/RwowMgz1mE5CKkm/y6DvBScP8W3dSzOipEkRey6093ewMDw//RDz1KprT2wE41DcADJ4++pDTHK+dnqg21Z9JXaioj44p96DwqLK5l2pnkVg2/XkA3A5SZxO8B5nUyp5Q1kZ839uPtBwTCa0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cYIKOI3UKNqZ+bI8gLtyB3hZ0ocSc7bMayL0SOGsQCc=;
 b=F6dF8j4b5dzUmSls9SzJeXsujPT64qMdCRrYVeczrQOlz0HKMCw336W/05OZtBHjzf0QZV3cfIR8ZLOe//71wiAaPJP9JLMtZZUI2XhJzo2m4jYtJoqoA6I5nXlxctN3jhLIBTdNfhrR+jXOA8Dt3Ge+Vd0CiNMYG1PRmmMVQIHV0Y+raCThq/20HRngCTjqz6Qnud39Em+Otcf81niRT7kzOP1pyb1krq5gCrmcql4jf1vhjWmjIjnvAaVfk0Z6mjI8fr+Zo8rcRxiIXBnNiHCXEfjw3sTfSWr0Cui0r6HsbWUtzMpytybzEvi69SjrpwV9oM0D7A0SOfZVF9WeJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cYIKOI3UKNqZ+bI8gLtyB3hZ0ocSc7bMayL0SOGsQCc=;
 b=XXN0mqjiOg1uqvn6sMG67iFf2vaF0fmgAs+W/0le3IM4pP9MFz+gT7szPWnFkzXbardurEIQUW2K1ZD97xRLqnW0JJxlNQNkPCg54pskzSbX2dpYBBQl2ipsCC8u9WR+7B7H7qrwymIc0OndzFSYcglMsV9qtyDXa2O1fYRNyJDzUy+dgsB5cjw4S7aVXWUCvnBluzF1ZAgDXxc5R4VcvBjIcGJcXdSPM7JQZBY4hmdJwReXx/vUIq4k+HfbUVM6Pl632rnC+Pnuv3Gu2roMNH7+VF8DYGkkqjBx9b7MtRh2zv20npVFZbUmTzKn92IIDaVRc1kqIc8KfMl59zTdSQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by MN2PR12MB4343.namprd12.prod.outlook.com (2603:10b6:208:26f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.19; Sat, 14 Dec
 2024 06:06:20 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%3]) with mapi id 15.20.8251.015; Sat, 14 Dec 2024
 06:06:19 +0000
Date: Sat, 14 Dec 2024 07:05:23 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Yury Norov <yury.norov@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] sched_ext: Introduce per-NUMA idle cpumasks
Message-ID: <Z10gI2wV1FJ5lyTZ@gpd3>
References: <20241209104632.718085-1-arighi@nvidia.com>
 <20241209104632.718085-2-arighi@nvidia.com>
 <Z1dF6HuEI2nyUD2V@yury-ThinkPad>
 <Z1eH8_rP16IyJ8LI@gpd3>
 <Z1ejJSBes62otQ0k@yury-ThinkPad>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z1ejJSBes62otQ0k@yury-ThinkPad>
X-ClientProxiedBy: FR4P281CA0066.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ce::15) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|MN2PR12MB4343:EE_
X-MS-Office365-Filtering-Correlation-Id: 23cd15ff-8000-4810-707f-08dd1c056d96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Y6o5/iZoUmSXngYJB3I9fvE7MWg//XPfBnwmWlUPS67Sw36gLoh2ybKeEgFj?=
 =?us-ascii?Q?mHBcVIEXAsG+8r15a2bv/+e9G7XJ/30KBbDno6XIfgN7u1NW2gz8v7jwgfgL?=
 =?us-ascii?Q?OFl9hohrZ+LYS+c3IQdlgdenX9zUeY/8+cU0mX6hmPHPiSsP4U/u3bsJWQhz?=
 =?us-ascii?Q?UU0fgzNj1G4RKe+ItjdlUAoeEzhnUZDSlWL4mW3MPdQM91oWHHJaCzxR0LKd?=
 =?us-ascii?Q?E8QS2TmyQQROPcjohQfwdprJUOe1QVr0QUXoFkolQWItEvwlpHYoYaj1Vp0f?=
 =?us-ascii?Q?uEQ9YWHPzQG/m7mKbbD69gzJ2wSPBEqf1fpo+ejUZ8mSzh4lbacbq6UdyGuW?=
 =?us-ascii?Q?TKUbk2LioqfZ9OYtFy6PntU6OQeNvUfqdNvvLAvY8aX2ZWgZxoo47HPEt1H5?=
 =?us-ascii?Q?bO3mmr1qhW9WCcSHHSMEuxOeZiVH+EuP76DjYH4cGSXiPmog7qvS2IataSkm?=
 =?us-ascii?Q?SoEI2uCIfnZ9VGG7czbIP8X8T+jDhFlzs5rAf1mZkY9wPI5S1Q6LT9xu4Tl2?=
 =?us-ascii?Q?dkqbw0wu3cvbKLLRaLqnCxNfqCPUGKQkY47VzMsZm8pzcvszko3gbYztAcBR?=
 =?us-ascii?Q?S7lF/iViFo3+2jFuhQIDPSSmb0ZnqATDn1VgOxxDXqECkWTDxLK4csR6v/Pd?=
 =?us-ascii?Q?aeVfb19ilMILDUHxU+jxOUTdGZ2AIowShGAgYhRncfm7qw+nO8BE/bWo/ZoU?=
 =?us-ascii?Q?OYtAdIkmDzZWQVe8sM+HdwbdgBaNX0cbEMX16BOknMqVrPgebh48qva0c6Zp?=
 =?us-ascii?Q?0amtWY0EtTWlEyX5ip8nEXFngdcu9NOnKeiDfNC+HEwoVaN/scKvPn3n5/Ws?=
 =?us-ascii?Q?T1kt4c4vbDO6s7qGO60Iic+xceiEmzZHoidr8QkmFzpaeFWe8FCYyxhrdCEX?=
 =?us-ascii?Q?HByTEl6tmhrtW6Uma2MbMhkci5TWMrdYU34HsA+TDp92tR6i/BG4uNmKrACc?=
 =?us-ascii?Q?plBjrGcLf/Mgiz4u7db/sZ27FYPZgUYDx73FAxuiSX0k915qQmpUpQPyA+HV?=
 =?us-ascii?Q?XWYG3GuiMwS+oNKF3BOHqqn5/lX0jvyy9KEAHSf9KXtHozp8YNdBCDZdHdFe?=
 =?us-ascii?Q?6a8dPCkdIUsACzpElbk6q8+9c6zksYHoOMFYv0/tkhOfFeBXTtMY7E2Acjnl?=
 =?us-ascii?Q?MjtcXXV4IlE+q441jJYMoxoz0goFud5e80TIqgNX/DeQnMynCRmsN9NFmtFq?=
 =?us-ascii?Q?DWzPyRMjeaRZ+FOx+tTIV1FOUYqqRc5auV2ozWcYy8laea2FAdcq6mb3NoOY?=
 =?us-ascii?Q?awEgkdUnCIuOv3qU3ucBAa/pdraYRrVR4Wqq7Wm2T2FoY0Hh2L0/t8jfk5lW?=
 =?us-ascii?Q?va/HwAg1ioWYQwSD8OoDTeadD2rAAVyS8MZqerb0YXdqRR+bKdty3JUz51VW?=
 =?us-ascii?Q?5gZp6/NYhPQ9s8VgTKUjP8xkDhXw?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fTJgAarWjj29kAxN2/SOGdUkSm6yObJmqyzW/k8Xi3Nchth7xm5w2MuEo3pM?=
 =?us-ascii?Q?VVHi2Qox7AF8U9FfB66fnI4iWmyle9wjAF6ax9XijQY6hV2P+qiby9/lUHQW?=
 =?us-ascii?Q?NFPjh6wLvM5WIC78PKy/ww4mwyIu/GFQSfy+zAJjNw0TaFoziq2DoCQPPBt7?=
 =?us-ascii?Q?ZNjm9aiHIQkGjaCphiuGxVR25erZbT8PIbTNl7VsFTcKv0PunynSZvrPr6Wy?=
 =?us-ascii?Q?Ks7+F2cV20nw3sopk49md5ENPlHDs+lltY+b1NosIhmJ5VQo0YjfpPGwcjB/?=
 =?us-ascii?Q?PqH3tYkyH0TW3/Sz4x6dK90ng3p0h5LVkDMBNp4WHObHHxPbimn5ILW7Lgg2?=
 =?us-ascii?Q?+bmnthTTDMozAYF2qYjUugpIZNoIBlP0Ll/g24n9XwPkRLXM/zdorsCC4gyV?=
 =?us-ascii?Q?QoCG+mCAVmejKBzLdzGd2Nc2j+RShz7yraNmGm7EEDEjx5cqL9t42ZQsWmni?=
 =?us-ascii?Q?buvdNsM8RLQ5xcXKjNUJF12B4Gj/b0w63+AEIFMKoA9apLwi1/UlYCnDlrz6?=
 =?us-ascii?Q?a9v20vmlb1+61G49J9MSB1dhx2EmnmFjJLn4+ueKnw1Do6tyMjO9eLqYHC6h?=
 =?us-ascii?Q?ZFsZe8lW9k105LK9CotkDe6L+ykIZhwsjD6oRvumt+nsSJtBl0VzlE/zCVli?=
 =?us-ascii?Q?7uMdC+dF9xB70MUCbVpKcjwZtav4yVk+1X53FUaZQ78q4VUIOLiOjJ0VfGBm?=
 =?us-ascii?Q?sMXIY+JEHK97gxSIQ2jonBcc9GrYqc3KRXbcFMJR778ExsEN+FIe1Ss9jlZL?=
 =?us-ascii?Q?zCsyDET82B5rSkGyBvIJptk4ot+bPIiQY/v0N3S09lKPpxAuHFybTK89e+y/?=
 =?us-ascii?Q?+A3SQKKfTBux8N4nnyGiZQIV/saO8TQ5IDCGWB39HHbVmTYIdv3U2QocUYjo?=
 =?us-ascii?Q?ZQKm8/oVcr2So/2383VNj8b+/eDu47I+Rt8qzHDLM3/glYY7ShKYWptJ4Jon?=
 =?us-ascii?Q?41fz06sy7t48sjnKcLN6LIxO/Sg0yPraw8RNsDZKlhiJ2fpMuFmTS3uYoB3S?=
 =?us-ascii?Q?y9s6DChgrkDwecTnGblGfNWnIgdL7oNAteg2LIJajkichWLcasmeNcqTQdpk?=
 =?us-ascii?Q?OqAYu8NMn+/+b9a1HpoP5sKzduOYARqmCvABALwGP4eYxmnnDOek9JjoOIBw?=
 =?us-ascii?Q?5XxRfjO3Ezf+vSww4xTuTzcQHSfa/q9SBgqcRUnGBKs87a8a52H1W7L+Bng9?=
 =?us-ascii?Q?LkJBlazaB0jeV7z0BUtXtWOWtEsi+xAgtorPaGcY/ricUXJuhOgTGYdHAUVy?=
 =?us-ascii?Q?C60fmtu70Y+sRLE4mX9opoGy8jtvSLrT0jeuMsCPaz5FW0tjLghwndx4JAAV?=
 =?us-ascii?Q?W+OHSBb36dsVwXq5dY6K0rgxfOtj2f5dVwRLyHWyJtqZasmDYFq97zBxlRcW?=
 =?us-ascii?Q?Dt7xk0/e3kvfE9qQwn2xJGEAyXAV4WYZ2UZevpAxw79UZXKi1qNzxq9asqja?=
 =?us-ascii?Q?dGu+YkWP7uLK2gl7No8o8yRDLB8sgUO4QXiNL31PCByh5vW47/Bx7+5hpNq3?=
 =?us-ascii?Q?XmQfQAISjsxiP1BD7Z3qVVK0MmpMc6Bm+x7CWX08+4NhDvZEZyGDsYS0Fnau?=
 =?us-ascii?Q?JMVcfO61Of/WgbZKMwWR29/v2iqJ8ZxDNnFLUi2/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23cd15ff-8000-4810-707f-08dd1c056d96
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2024 06:06:19.7164
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fleh6CqZXDIpkVp6DdNXA96gPn2FCSuyW+zn1bzDMY7LfUmejx2eYHbHvboWj2z7H5u6oPANIdF6xlpY+TBcFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4343

On Mon, Dec 09, 2024 at 06:10:45PM -0800, Yury Norov wrote:
> On Tue, Dec 10, 2024 at 01:14:43AM +0100, Andrea Righi wrote:
> > > And altogether this should look like:
> > > 
> > >  int scx_pick_idle_cpu_from_hop(struct cpumask *hop_cpus, struct cpumask *cpus_allowed)
> > >  {
> > >          int node, cpu, random_cpu;
> > > 
> > >          do {
> > > 
> > >                  /* Pick a 'random' CPU in the hop */
> > >                  random_cpu = cpumask_any_and_distribute(hop_cpus, cpus_allowed);
> > >                  if (random_cpu >= nr_cpu_ids)
> > >                          continue;
> > > 
> > >                  node = cpu_to_node(random_cpu);
> > > 
> > >                  /* Find an idle CPU in the same node */
> > >                  cpu = scx_pick_idle_cpu_from_node(node, cpus_allowed, flags);
> > >                  if (cpu >= 0)
> > >                          break;
> > > 
> > >                  /* No luck? Try other nodes */
> > >          } while (cpumask_andnot(hop_cpus, hop_cpus, cpumask_of_node(node)));
> > > 
> > >          return cpu;
> > >  }
> > > 
> > >  static s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, s32 prev_cpu, u64 flags)
> > >  {
> > >         const struct cpumask *next, *prev = cpu_none_mask;
> > >         int prev_node = cpu_to_node(prev_cpu);
> > >  ...
> > > 	for_each_numa_hop_mask(next, prev_node) {
> > >                 cpumask_andnot(hop_cpus, next, prev);
> > >                 cpu = scx_pick_idle_cpu_from_hop(hop_cpus, cpus_allowed);
> > >                 prev = next;
> > >         }
> > >  ...
> > >  }
> > > 
> > > Not tested, but should work.
> > 
> > Makes sense to me, I'll do some testing with this.
> 
> One thing you can do to optimize it is introducing a function that
> pulls nodes from the hop_cpus:
> 
>  void sched_get_hop_nodes(nodemask_t *hop_nodes, const struct cpumask *hop_cpus)
>  {
>         int cpu;
> 
>         for_each_cpu(cpu, hop_cpus) {
>                node_set(cpu_to_node(cpu);, hop_nodes);
>                cpu = cpumask_next_zero(cpu, cpumask_of_node(node)
>         }
>  }
> 
> This should be O(N), but it will let you to avoid O(N*M) in the loop
> condition inside scx_pick_idle_cpu_from_hop():
> 
>  int scx_pick_idle_cpu_from_hop(nodemask_t *hop_nodes, struct cpumask *cpus_allowed)
>  {
>         int node, idle_cpu, random_cpu;
> 
>         for_each_node_mask(node, &hop_nodes) {
>                 /* Pick a 'random' CPU in the node */
>                 random_cpu = cpumask_any_and_distribute(cpumask_of_node(node), cpus_allowed);
>                 if (random_cpu >= nr_cpu_ids)
>                         continue;
> 
>                 /* Find an idle CPU in the same node */
>                 idle_cpu = scx_pick_idle_cpu_from_node(node, cpus_allowed, flags);
>                 if (idle_cpu >= 0)
>                         break;
> 
>         }
> 
>         return cpu;
>  }
> 
> And at this point I'd also compare the above with non-randomized
> version:
> 
>  static s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, s32 prev_cpu, u64 flags)
>  {
>         const struct cpumask *next, *prev = cpu_none_mask;
>         int prev_node = cpu_to_node(prev_cpu);
>         nodemask_t hop_nodes;
>  ...
> 	for_each_numa_hop_mask(next, prev_node) {
>                 if (!cpumask_and_andnot(hop_cpus, next, cpus_allow, prev))
>                         goto cont;
> 
>                 sched_get_hop_nodes(hop_nodes, hop_cpus);
>                 for_each_node_mask(node, hop_nodes) {
>                         cpu = scx_pick_idle_cpu_from_node(node, cpus_allowed, flags);
>                         if (cpu >= 0)
>                                 goto found;
>                 }
> 
>         cont:
>                 prev = next;
>         }
>  ...
>  }
> 
> Don't know how it works, but it looks really good.

I've done some tests with multiple variations of this. I think one of the
issues is that we need to allocate hop_cpus and it seems to introduce some
overhead (or it could be the operations on the cpumasks), but it seems to
pretty much nullify the benefits of the per-node idle cpumasks.

However, I came up with this one, which doesn't seem to introduce much
overhead:

int sched_numa_hop_node(nodemask_t *hop_nodes, int start, unsigned int state)
{
        int dist, n, min_node, min_dist;

        if (state >= NR_NODE_STATES)
                return NUMA_NO_NODE;

        min_node = NUMA_NO_NODE;
        min_dist = INT_MAX;

        for_each_node_state(n, state) {
                if (n == start || node_isset(n, *hop_nodes))
                        continue;
                dist = node_distance(start, n);
                if (dist < min_dist) {
                        min_dist = dist;
                        min_node = n;
                }
        }
        if (min_node != NUMA_NO_NODE)
                node_set(min_node, *hop_nodes);

        return min_node;
}

#define for_each_numa_hop_node(__node, __start, __hop_nodes, __state)           \
        for (int __node = __start;                                              \
             __node != NUMA_NO_NODE;                                            \
             __node = sched_numa_hop_node(&(__hop_nodes), __start, __state))

It's O(N^2) with the number of nodes, but it shouldn't be too bad, unless
we are in MAXSMP systems maybe, but even in in this case scx schedulers
have the option to use scx_bpf_pick_idle_cpu_node(), instead of the generic
scx_pick_idle_cpu(), and define their own criteria to iterate on the NUMA
nodes.

I'll do more testing, if we don't find any issue I'm think I'll go with
this one in the next patch set.

-Andrea


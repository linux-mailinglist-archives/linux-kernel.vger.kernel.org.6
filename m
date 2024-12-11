Return-Path: <linux-kernel+bounces-442020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7A8B9ED6EE
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 20:59:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06EF22825D2
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 19:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F981205AB6;
	Wed, 11 Dec 2024 19:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ftQrW1CK"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2079.outbound.protection.outlook.com [40.107.220.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC88202F88
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 19:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733947162; cv=fail; b=Ig1/Vh1cyo6A52+50xdaskKZoU0ub3GmjG573FwewTCvrqn8o8CnYaSM40Y04DI2fLmgm9g48CGoeQbhAZnPDHufESDiKXBB35A3OXg59YajojZuekKDwfENHApkuBuynIypA38WmDQz4PJt5/lkrPOfcVu1MN5QRjTRF+b0kLY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733947162; c=relaxed/simple;
	bh=YprCHIj1o83+OIpTEPmJs0oeYKBp8D5rz6MsA8X3IZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BFgGAGQNRvMf/3Mr75zfM0xsoeHlQwh/zpJXJNK6H8THgHM7woqPtrOQSq9mJ4tS+sA62zqxnEH9GK0IR6OfMbaHylbCXGNyDk/rKiBxsaQGogRLNtsxp3DvOZEW/S58EtARxlc0s5NquAt3HWxr5X0TzpYYOraQNi+ido9pbk4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ftQrW1CK; arc=fail smtp.client-ip=40.107.220.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gjzlLdt3xq0456Ixqc0oGeywRUu6u2e0WcNj4ot7MpRNewO/cu85UCX7phcx8qw+YZsCQkYql5Fyv1cHzDctKwWOjMhAwBIgIlG1o7jyh34UCgdnOMJzIfaxm/2CmI+GSJnVLOdrUEGKVThNLPZDDWRqe4OChcw4bRqE+/aHJuxRdgTc20FSFCDsxxIMG9Ez4SimylrT67IPIXuDhFEh+Kh/dBUDqgDH3FPJgeaz3cbsx03Gk1kCjeA/v1ux2y8hwmP/5x/T0dVY8nWGqF8qYw6W2T8UY0vpuDhtPPnxq7u16p6y/n5eGbATIIHl43iG0zgqIvanPPRi2TH4+7nEsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cn/Ud2tYuVzJQUbLya7Gh+BPfLJAcwskDZqQmFBz+iE=;
 b=JyvVNDnYZ9I0OvIUz4s+2agSSQTIfAxM6X1a3FFB51Ny3ggP/j90vF2lbqeVESgVk75BFGL9ZTqQXTE5vexC4kh116oSh7I5U2eAdyfsZ0/aY705y4VA+FoUnMSbMNTOIicFu5BkEixbtg2QCFHXVatR725V4ybObaHfkjYUPu7kyblGBNon+KXieBOLgjLqINXV32ZewLZ8K0bd2dzAybnzvDrBTms19IJoqjO4U08NMfakv5SGCK7GEXDNBR8roNDeLhNqMo743EMj6hOluODWnpmxaoUUmZ1zDinTYDDm/gFpESteu3Y2bKnL3tJxVOfD1cG3r3I5DzcMHGa9NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cn/Ud2tYuVzJQUbLya7Gh+BPfLJAcwskDZqQmFBz+iE=;
 b=ftQrW1CK032LiNDeNK2g+fn1LCGj7eWkrY894sHFwyupvd8P51AiICJOAB2ohvfBihPbyiLyEX8cuOl/x6//wMgYX2F62FZzTwEs8TEzfnvdZ6GRq8Atj+qCDMXWS3xhArz3tg4Y4MNK0fOKNpDuhq5I13pHJsA2/d9afN94Ky2uNUCqhoRpKah2oiSMoK0P8K/g9+vKQZCEz87ScX2Rwx+UejiFLgYBY4ZQ2xnorXxjrHkd/eat2B4W+MFBYxlrX7MUKbScTScSWj2UceDKd+Bvvcewe5hPsiA3LVAb1w3xFsQCGtYBXwDVPTofc6tq86VD2uK0VpHxaPopLYXYng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by SA3PR12MB7999.namprd12.prod.outlook.com (2603:10b6:806:312::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.22; Wed, 11 Dec
 2024 19:59:17 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%3]) with mapi id 15.20.8230.016; Wed, 11 Dec 2024
 19:59:17 +0000
Date: Wed, 11 Dec 2024 20:59:09 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Yury Norov <yury.norov@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] sched_ext: Introduce SCX_OPS_NODE_BUILTIN_IDLE
Message-ID: <Z1nvDUlGrErZVEf9@gpd3>
References: <20241209104632.718085-1-arighi@nvidia.com>
 <20241209104632.718085-4-arighi@nvidia.com>
 <Z1nYPWeJvmizCvJJ@yury-ThinkPad>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z1nYPWeJvmizCvJJ@yury-ThinkPad>
X-ClientProxiedBy: FR4P281CA0306.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f6::17) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|SA3PR12MB7999:EE_
X-MS-Office365-Filtering-Correlation-Id: dfac3b3e-9acf-4628-a491-08dd1a1e4b44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jBd8rm6yW10BC2tn4glytrTezruvEqtUMadtu8FmpHkZ1Oi/6CBsMJNKNW/s?=
 =?us-ascii?Q?XEr3LQj6Ok364mOvinLbZrUJl0dnFb6AjoENAIHbtplsgy+HREmaefoRVmg/?=
 =?us-ascii?Q?7XwbGMJQYEK29eMWDEhyAjKvYCIac/z1nMwVG2t+iVtpQlcvvoS0lDXkvLSs?=
 =?us-ascii?Q?5xf1pdtfGUBAzXLtXXebYWqqxudxuIcNAVLRBdTSNov9B5mdp9yoyz6t1dkg?=
 =?us-ascii?Q?zlqfKif/DEvASlOwfJIgxoEXAFChKq6KyoQLDOxJbfccIoxIphGAgOEu0G6Q?=
 =?us-ascii?Q?zkvkSqZtjXgOxP9Pjt1YHuLyhAGehZ3NrXB/vmb/pv/gO3Yqz8L2uvdb1Vgw?=
 =?us-ascii?Q?GpqP9v4E38dc01XWc101kVLJK2okClDO6iaosg67lRokX1L8CfbnopxJsjn7?=
 =?us-ascii?Q?1Hp9Ay27RRgQN38S9Tvz9C1IsiD5C5u+1AiaqSdPuvyt4Nr/bMHyuxqZz1dn?=
 =?us-ascii?Q?jhZ3alVuGDy/FYezCb7rnk44qFPo9B7nGLCOfEip3WmnbnF1frcJ5UBVISV5?=
 =?us-ascii?Q?h72rrxCyatbRuJc1e5UIUN+T6S5FJHxdqvFr24GUU2ECGHuqKTxDJZ4vuOMW?=
 =?us-ascii?Q?25mEAulxXfWaxhSdUNpsEu+I6xFIqK315ayJNXvD1UGSgiXFngdrBlvJLG8R?=
 =?us-ascii?Q?An9pm4NZ0ph/GYqOQtUSGuQl9vish9UzWmzbEnwAPHBCzvFXRXOENLZJdC0o?=
 =?us-ascii?Q?iZFwizr7gvPapLRiDGsua8VmeuVo1V64te6+xfUTB9X8wVSrYyiO1OBwhokp?=
 =?us-ascii?Q?cfc0TrRkxQ5gPRWOSvAw/ojC83tZZDA6q576GAF8YASEWu++Vubc/2pOKA2X?=
 =?us-ascii?Q?pVVLrXknZjaXlcM6MwV+tpdaROZqz0rNLoY/PMkjgN0U6kiaPEKeUR0fLuLE?=
 =?us-ascii?Q?12iYtGhCTbuc7fotK66OwTgiR+qPz+9Psg+W5QWmccr9kRZCynNyg9m+LBko?=
 =?us-ascii?Q?gGwiKBwPRUB4SJKkHEqAX0TLt0IG351rf8sSEAWoiPExqJUbbGb+g8JQbbIK?=
 =?us-ascii?Q?JrO2Jd0/QBdPfx+johb7iNVClIjbFWe6YU1FdWMXGyYF/Pazv38e3KPrPPkT?=
 =?us-ascii?Q?8NfUNqGZe/N63P50gWT9vxRJCmGOHvdIUUNpY5XXzUyx/dncD9j7pcXgJA5f?=
 =?us-ascii?Q?+Gw+e1+eeyMTapjhRwrse10VELDoLzYxvG8bbJh6Pfm+g2EipJtJ9anmvH4B?=
 =?us-ascii?Q?f/h+2PS26160WadXS3VKbI6dXJHI8OVPQzr+HGxOF967BnGUVUv/qXyd6voC?=
 =?us-ascii?Q?rDP0NyICXikQ34kjYTIxRg/wa0ogsBO3DWUvwhsyhWH00Hjofql2oWmOZra3?=
 =?us-ascii?Q?KBiSIvO4rIYsm8Xvit/Ftahe1cAfvgdYzvie1oXObzMH9g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GBIvlom7alObs2E0dBYLBjJAcf4MANcZBfD0ta+ZfpALrfBLyPbtWiPeNLYJ?=
 =?us-ascii?Q?WYFikIticfbbnIpn1tKVN5R1dkade08X7DW19Vy8Sr6dMmiQ/TGrEi97BLBP?=
 =?us-ascii?Q?/uFZ7tHnTgGxPVw9/1R/XJVxRqBgiOuyxfC/L8cNmjwVAQtHpewZzwwasDZM?=
 =?us-ascii?Q?9x4T0A/bx/AWYKqFBl9eTQL3XfWmizF/xshTZO7oPl66Hk8j/x14R1wDPE6i?=
 =?us-ascii?Q?hq/V+/DvQmYrPB08AU5SJXhWPyWz9RVuTHyOpO7Utv3QDa3aQ2H64ySSXUYI?=
 =?us-ascii?Q?dhKF0AsRmOv6lIlHAKNpqDUB2HHh+0ABM0MgUNOJgGyEkg4oEMF1dgv1GEtg?=
 =?us-ascii?Q?bphIZ/bEDsNFl5Qlt2DUNdmxcJSMa7W+p2qtWVrfE9Yuy47QCGYiVEofpVbo?=
 =?us-ascii?Q?UKYLeHA7rqokEFem5sUqFcz5LtxtpPSZb81XohePgqy9uF8ucId+3EKWFVBs?=
 =?us-ascii?Q?7xjkC6AEVourdR/zIbTpG5kG3FsFYSAE499gSuar3e0Fp781vJihnLZd/Exe?=
 =?us-ascii?Q?RCLSSEXxGWaYgFclk4wFZhBPSw31ZJy6aUO9PPP3eEZTqZ54qAkuRY75HoS3?=
 =?us-ascii?Q?et7r7BL/n1e84XS7vQrhUkmgZnEOX5yV2UvrtDQw/vbx50XFcmkiHQzqKJ0K?=
 =?us-ascii?Q?EkygzpCj9uieSHU+KeM6zImOrMrenD7D6yB972Nxd1EfWb74Gxh3lqTJDS+i?=
 =?us-ascii?Q?Fm8cqzQWfk3lsqPeea1hMb3mV1Ru2IOdgx/fV9G96MsgqeCqddnM8AqdqcQH?=
 =?us-ascii?Q?JY4aqMLvLXeEujmejZftOJDgAvQ1j3NE7EZ0s0gTviZJFy86pvTwS81BPMmT?=
 =?us-ascii?Q?Gm5Ml9pRhQwaUKkkAd4luPyhrP4XeiHphaFZ0QHlzmGfmDmzQhYAHpyAG/lP?=
 =?us-ascii?Q?p9OXC1CTj6nHaPYCkd7z1JKyHd4I8aKCDvWc5eBkZ05VU7s0i+jVm/YnrmCS?=
 =?us-ascii?Q?E4LO5NNziA0ugVUzT525QPOK7fmtNC2EKGP3AvhvqMfaHFz1TlzEqBjJxxLU?=
 =?us-ascii?Q?96+3WMV5DkXIHYpYpaTUYg/sJtgA4JyUlwgNgkFcC5RFyusF28k/kZohYaJC?=
 =?us-ascii?Q?TDfLi+dXowoXZL9ztm/lzcc4CCOifo87QddiEruJvzhAwXXybFROCM6QN6sW?=
 =?us-ascii?Q?v87/iWJ9dsqXOMZzYkOyuouNWxn+mai1164k4WQ8Um/vVZE49qH62wHrtw88?=
 =?us-ascii?Q?Qq54+IkUvtDEK3IWaGXwRL/FRXnRUwQw39IWDHV0ZsHRq/FCJmoP96e99bbh?=
 =?us-ascii?Q?MlAL25jO7RnOoEdKzHBAwv2/dEktIsgZgeaCQI+k6cVnQy3iemkU6cSHrSya?=
 =?us-ascii?Q?xuZVnBUnlxG0vR0AMVLL3tP5tW7ZfcZJ9WpLfatdoR5H1HgyP3SwvfGnZ25c?=
 =?us-ascii?Q?AMRqSivwMY9syOZG8ghrc/Dn46fq+srjUO4HPjUTZassU2pMACSdZdnp9Bzi?=
 =?us-ascii?Q?UphEzP2GXd/x5JvD7zwQMRUVwa4DzgeimvKzZpX3Vwz97EW4vUT5xuJBdShQ?=
 =?us-ascii?Q?TUUdZep9oLxTHpG/ZyY5uUAWl/STxijJ7bVTGgYk/vlUbdYPOszODJIKCcgF?=
 =?us-ascii?Q?4aVaJ09P5RKP027do/CHLnWTlRag5nM8PlqMUFc+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfac3b3e-9acf-4628-a491-08dd1a1e4b44
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 19:59:17.2683
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oaQS0xp6lJuiw4079XN66L+TRukFt1gt+vbngB+NQoI/qRkNmaDjoxOLNEs5QJoqM7UeJHrB39qtmX2jGiwedQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7999

On Wed, Dec 11, 2024 at 10:21:49AM -0800, Yury Norov wrote:
...
> > +	/*
> > +	 * Check if we need to enable per-node cpumasks.
> > +	 */
> > +	if (ops->flags & SCX_OPS_BUILTIN_IDLE_PER_NODE)
> > +		static_branch_enable_cpuslocked(&scx_builtin_idle_per_node);
> > +	else
> > +		static_branch_disable_cpuslocked(&scx_builtin_idle_per_node);
> >  }
> 
> The patch that introduces the flag should go the very first in the series,
> but should unconditionally disable scx_builtin_idle_per_node.

Ack, that's a good idea.

> 
> The following patches should add all the machinery you need. The machinery
> should be conditional on the scx_builtin_idle_per_node, i.e. disabled for
> a while.
> 
> Doing that, you'll be able to introduce your functionality as a whole:
> 
>    static struct cpumask *get_idle_cpumask_node(int node)
>    {
>    	if (!static_branch_maybe(CONFIG_NUMA, &scx_builtin_idle_per_node))
>    		return idle_masks[0]->cpu;
>    
>    	return idle_masks[node]->cpu;
>    }
> 
> Much better than patching just introduced code, right?

Agreed.

> 
> The very last patch should only be a chunk that enables scx_builtin_idle_per_node
> based on SCX_OPS_BUILTIN_IDLE_PER_NODE.
> 
> This way, when your feature will get merged, from git-bisect perspective
> it will be enabled atomically by the very last patch, but those interested
> in internals will have nice coherent history.

Makes sense, I'll refactor this in the next version, thanks!

-Andrea


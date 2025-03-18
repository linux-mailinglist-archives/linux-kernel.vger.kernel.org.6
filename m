Return-Path: <linux-kernel+bounces-566590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87137A67A2F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 18:01:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF77F42024A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 17:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D8B20F069;
	Tue, 18 Mar 2025 17:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="K9UaOIHn"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2063.outbound.protection.outlook.com [40.107.237.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B275518C33B
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 17:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742317255; cv=fail; b=crkYLuc1YUgnd2mgfvR8DofPpSoGG6jbSdyTkaHPy6b3BHhG0moT5HN4IdMKKKXkBj/VBS+nBQ9VL9syhhcqcwVaJrJ/VRnQMJ45bjGOs8URoNNs3UGiS2F+xe6UenTkYCtqaef/cBHieoS3KD0AnmpLpNQHY3BZCTwnXGgDlCQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742317255; c=relaxed/simple;
	bh=0TXdVXc7t5bSUVO4cmgcyzY+Go5hj3wDzCh79pPZeNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ARWWV6LyfHfm3wpTFQuxKAS4AfwY/vB+PF60s0NGH4cblvWvHeYYmi8ifYlP668sFSirh58dp8Qdhhdvpl0ZF1V+nOb7yQjYejmTAQ3BEBS4TudlDI6UWH5XWqP6eBLOXw44Xq/tRX3P5KhIe65dUVAD3QVcj+gHjarcSF+FSb4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=K9UaOIHn; arc=fail smtp.client-ip=40.107.237.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TfSKBKYq69zXlnCuqRxuTLx4xSFF/Asa5NMlJFIwRcitIG+7NiGaDnNfIlwLtJYFKUi4C++tkDS0yLV1C3dEtTsL7mlixPx5dkkMRdR2e+o732Cql07FZuRY+0KED9S9sA9tpgYCCK++nNLFTACw7tNTWEeF7sTJ3Nux8OXBsjh0UVtQ//FIn0/Fv59xH2k1tPOs63uWRZ235gya7hFAOeH5PMuCIdClhQXIu6OXcjicMN3PDUIyYgP1n7qqeL6WZ8rewKvlSkq3legckQTHlRX+iPBav8lzd+L4RAxpbLpR29p+X7956DthoEKC2gmPbu1ORuuV5PnCgMLEiRF1WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/VMUX2MsYDLbF7WJCmNnf23MNuKDQp5HCU9jH4TbNUw=;
 b=LZyAmG/oArFVdMoT9FvFQ9f90HrlyaTgf9hgvFk1Mjh6pNMKRqkOIfdF6mvyqQDUhsoOVpj1Tx9DWFYtRmF/jtxQzvTvjrahMl8fWzjL7qnE+48hny7Vca0WC0keEgwSgAxTvi628DLOIaNvl1xFjdOxXjnsL9zMfx35/wqdgfcI0vvxgzkUP4IsWxpl+WlRDsgYs5S+Y3MrmVc+t8r4wYhYgeAt4DYx1LX0IPhUNigFxaDCTHEDM0Y40prvc7GbJ9NLuv3kdacZBqPhPoHcXtP7bTHN7rP1KNR/9QB0Wmveqjo8qerLiG/6nt8DMQBJNKSdJPzRIk2fQ3m9J1lNig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/VMUX2MsYDLbF7WJCmNnf23MNuKDQp5HCU9jH4TbNUw=;
 b=K9UaOIHnGMkxtT4XrPNwiuZxMp8d8RajvYR4PZFzLRRBJ5DKQeqOU59LXI/kJJIiprozdbdgi0Dg+HK/e03hXA67mio0D1zIvIBNS8Rc/wpVasHhb6AOTHEsRtEpXDrJgEg3gfMZuPRivqQZeAaGRhwK1pks0RP5bwcgxp13+P889B+tqm6VqVZ1cXMD0mG7fz2KjHJN1t4d7W7/tsJZ84dYHGIa10M1mTfSVWOaPYLRCWqCzCRORtmqdLJU0Gfn+BHaakz7AUopIHCKoqbQPsiBk+PHC93yQ2xy88XOoHTogTo6AnaR6Q1KmmJPmzhQmAuVsljCE3UWQf1bhBIaCg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by PH0PR12MB7862.namprd12.prod.outlook.com (2603:10b6:510:26d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 17:00:49 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%4]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 17:00:49 +0000
Date: Tue, 18 Mar 2025 13:00:47 -0400
From: Joel Fernandes <joelagnelf@nvidia.com>
To: Andrea Righi <arighi@nvidia.com>
Cc: Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org,
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
Message-ID: <20250318170047.GA3467630@joelnvbox>
References: <20250317082803.3071809-1-joelagnelf@nvidia.com>
 <Z9hW_3cPN8u7VURV@slm.duckdns.org>
 <Z9hcUSp6P72wT5ig@gpd3>
 <d9bbbf0c-64ad-4304-aca9-ea48febba402@nvidia.com>
 <Z9kAFnrTvqH_AzEj@gpd3>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9kAFnrTvqH_AzEj@gpd3>
X-ClientProxiedBy: BN9PR03CA0919.namprd03.prod.outlook.com
 (2603:10b6:408:107::24) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|PH0PR12MB7862:EE_
X-MS-Office365-Filtering-Correlation-Id: ac5ff86a-5061-4151-432c-08dd663e6eb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qQWVFMtkv+oDbZKHCnayEtDNvzX3abSwFWgcg5C/H4XRzg8/Pr/uRL0+au8h?=
 =?us-ascii?Q?TMYJW2adUwPOzVaRPPOR+KkUYewoAl5Vt/KlLcJIctJCarAYdgmNn7MEO2xK?=
 =?us-ascii?Q?oYW4kglvYvvqybWsmgKjfARxKnUgLWDdO88tnHOk6i6kYK4cS2W744qJhe8g?=
 =?us-ascii?Q?wGw5+vm1/lRIxd052Dmw6mlpsYPAee6xMlWXYSFMMrXW0ReZJJzQ9OdATvuX?=
 =?us-ascii?Q?8UamlQvQCTeIwSXgfF2V/abNZpcUIDA3gRjclBKyqX+Kv/p6zf27ceyYnxkL?=
 =?us-ascii?Q?42yt2syvlgKkP9j8ti26EeMWd993b8Ejum4F+HdbstaFnCS45IQ7Z9I7ekvS?=
 =?us-ascii?Q?TE7hBsomZFpY8RSLdfG/TbLIW7dELrGIf+TZSdBS2fB+GCLysNE+14u9PVjs?=
 =?us-ascii?Q?LgM1IGAu5Xs9tbQ1aUm/wYGylQo1CK6fJbkTUsq8FoPGBabjJkjZNgUm/xL+?=
 =?us-ascii?Q?5Blhjc79MpTlwfK+mpyJkdvHS0WFDPl4l7Wp6+lzu2mOwkQczU7X6sCcom23?=
 =?us-ascii?Q?WL3PXuVzYm9SmEYrUrr9qiiz91PFKo8n5KUPA8Sc4AjcL7eLn6YVX+yGE4iD?=
 =?us-ascii?Q?8Be/q299tW7MlwoJ47L6/pdxLVUXJd2qR4N3nikMED4/l/EZXUsp/CLk/Sbz?=
 =?us-ascii?Q?ohJfKH2spR2pfDyTutoRa4qtf0piKnkWxn1uct0WBWp22X5cQCC9s3slBfwK?=
 =?us-ascii?Q?bM/Rae03Af8oUpEaSUi5IY7V3F/iqAaFchgZJRY9ndDfUebKyK7Ylfy5gsmg?=
 =?us-ascii?Q?lLt5vvgZzLv7zJbaa/NwmhPxsp5WctVpQq54rewEi+5v8/pySCvEMpvhU0YD?=
 =?us-ascii?Q?J+Y1wp5HDHdM0CmBu/RZAT/osn/ws31Xm79rLq2YySSiPZaOQExa9VerlSF1?=
 =?us-ascii?Q?WxVYjxGUp6Ut3jgqoW6LF9EuZZTNTOtWJx55JtzhCbixCKSi6aP+krBF6P2U?=
 =?us-ascii?Q?+GMDFBsSyLGPDs2iS2t8RY0r4bMKtNZHlsvDm9S0SqQt97tPtC+ChIydynSc?=
 =?us-ascii?Q?SybYv4xm9HaRKiSnypQs7CDiQqrajttDgGE8Xt/LaQ/hUFH6QBQIvLO9tQq4?=
 =?us-ascii?Q?w40UEgCKxF8Jq4m+hNyueilGwr3g3aUmp9yPH1JF20rcokiRIin+n6PFVZ0X?=
 =?us-ascii?Q?tQse5yMDV8Wr3xEfrEnDEIX2uazHgPCsdbdC3FysBS6F+ezM05xVyl99gciY?=
 =?us-ascii?Q?9ZhN4Dt8hIUZZ1kweVbjnDQpzUYUHMzSpPXUXnp1rqn4CEGZOeIS+eiccTqh?=
 =?us-ascii?Q?oNyMjNA2ARZzosw7ckbyNPUVskuMPWmNIj08imzaG67QNd6+4wriXjLpWO8N?=
 =?us-ascii?Q?9CPq1Blo63S9pm4uqIGE4xMtvsyvxi871+7kQ+1HZUKroMAnFWoRGS8REIoD?=
 =?us-ascii?Q?KZvStpbyC/KDlgb2jF97k9mRaW7Y?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mxG0ZF3371iuzS/RtSkP6wqfSdxMJFgqmZMNahF7W4j3+0jD+UN7FcuQMsPl?=
 =?us-ascii?Q?NcMl76PIO1W7k3DpXSSvxhq/FyXzdOdT+b3nvNmZtJaX/c2Xobt6ey3asrhf?=
 =?us-ascii?Q?UN+mJf/7f3UJ3AEk57sD+p94W8xXtwGnkqpYBUqLbfdP+5NCAjV2pOEUdSwL?=
 =?us-ascii?Q?JX7mb9tURCJl3serkeFOTnWimSTvpoq/NDgNKfzb9n9813Y36X8h6DLfZwok?=
 =?us-ascii?Q?tOpPQFLJtBj3eNU92scjWbZ6reeoN3bhAk0ERvhIQVbHYlz3jiO7BA1TxGkI?=
 =?us-ascii?Q?4jejWlsV//yjSy2kud8fMNfblkfBK6lRFz4FmtaIkZYMyesXoJmwd62V1i3W?=
 =?us-ascii?Q?giMnNs+l6g26B4vpZfIepvV8Y94HSFkGxWRxROqrJgey2LCi+J7DTmfAXL7f?=
 =?us-ascii?Q?0BL9zzSpuk7CLbTbFfpiveOf4EFfm+a2A+THxO0J9RKfjmsWOkuxkNjmFwRZ?=
 =?us-ascii?Q?frYFS7Hg3NQtdmMpjl2l2+QOQjNSwm5J2YYj2Y5jQ2ySqgAs/14EValVLj5k?=
 =?us-ascii?Q?jCCH3ucpf7JvhtzhIuZ4laNtM3Sl5RBWydmbtlq2k/mPsZdGcT3TLWEys7eE?=
 =?us-ascii?Q?BTJKQJ4+ZDWxC5WwLsHwltdYmOX3Iq4eWHO4eGj7ztLUpY0Pu5LiFaz6OhJR?=
 =?us-ascii?Q?oX0x+PVih66Z49kxMIBZFGGex7LDw4A4ZmhAObY8x8B+Z0xr/CP7Y+mv9ACG?=
 =?us-ascii?Q?wBuNn5EawWqzh0UxqOxGvJUOzkDToFzKLMv/B4ExCLThDiebdWmlaUPAWtmT?=
 =?us-ascii?Q?bNxAAxwFdVkuPIdawsEfE8sRh1GXYPmLONlVy1KUQoXpBClKhrwRvPfhy/LN?=
 =?us-ascii?Q?b8NOsnVW1WeDrDvftFBPh7zjzV0hvElhc7I4uFPMQ40MhS3TooMwJKp5vP1A?=
 =?us-ascii?Q?FqIjgB9YvUuhD8cuA0AydaRGeVvRf8cCd7sEW6Fv+6HD8rEgjFdSAJSMmcIv?=
 =?us-ascii?Q?mWh7zVpdoDa0ArB0Y7Vv2bOm0EM44dtAm4TJOGiPMjQR4Ol0JWmftDX9gRkV?=
 =?us-ascii?Q?D5GZDEprwthUzfhbwQ8S12b5QxKtHDUE4Gt2znnM5Xn0YO45BJIvvvGL2FN9?=
 =?us-ascii?Q?2t1xO63kAOebTJ7O11HhIqcUOhBk6tDR/xHpkXa7YHvPSwF9wEtjR52rTStN?=
 =?us-ascii?Q?8SAb1hGfoWfg4w5cjax4zVCvqB8y/oDFyt5E+NkkGtkRiluf2vAjTfr6vBUG?=
 =?us-ascii?Q?5mKBILg+K9JEDb91jIRxnLvfRujIsiRaHjVQ0/RGhQJcsN/wI/0w/QDtENaA?=
 =?us-ascii?Q?rree0lR6M9x0Lmp7mMyovb8LPg0WZj+Mi9vlfzsv/QarPgXEJ1clXkheFoAn?=
 =?us-ascii?Q?u1WsJyS7Dyluyl00cIjhI49YVYwfbFdkXLrx37+XMHFtoL5cbwdskZLKQF/L?=
 =?us-ascii?Q?wjlsj28fTeyYUBIlct3D3VlHrZB87hzDrVDp1CEdOlrM+LWlRTe+0xZHQ3NH?=
 =?us-ascii?Q?I8HmRiIIdgmiWOKL2i2WmT15d5l5XBJhoiHHSEs965FO3Cl4q3NOWltd+Y23?=
 =?us-ascii?Q?+K46j92adRcGTMybp/FYYfYvGc10cYVGgdsf+0703pSvH4GYiDSfcnban2D8?=
 =?us-ascii?Q?lMr/UDOgk0KurBapmv+sgulIgUrOlwQMRgJkkjDx?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac5ff86a-5061-4151-432c-08dd663e6eb3
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 17:00:48.9323
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Mf6J3MJyAn+EG4mg0kDw2TZb3h+tXwB/aoKyCja9nlB5HeAjKk7TpmmdLWvlJziHEqKahXxASfJVoOK181IIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7862

On Tue, Mar 18, 2025 at 06:09:42AM +0100, Andrea Righi wrote:
> On Mon, Mar 17, 2025 at 11:11:08PM +0100, Joel Fernandes wrote:
> > 
> > 
> > On 3/17/2025 6:30 PM, Andrea Righi wrote:
> > > On Mon, Mar 17, 2025 at 07:08:15AM -1000, Tejun Heo wrote:
> > >> Hello, Joel.
> > >>
> > >> On Mon, Mar 17, 2025 at 04:28:02AM -0400, Joel Fernandes wrote:
> > >>> Consider that the previous CPU is cache affined to the waker's CPU and
> > >>> is idle. Currently, scx's default select function only selects the
> > >>> previous CPU in this case if WF_SYNC request is also made to wakeup on the
> > >>> waker's CPU.
> > >>>
> > >>> This means, without WF_SYNC, the previous CPU being cache affined to the
> > >>> waker and is idle is not considered. This seems extreme. WF_SYNC is not
> > >>> normally passed to the wakeup path outside of some IPC drivers but it is
> > >>> very possible that the task is cache hot on previous CPU and shares
> > >>> cache with the waker CPU. Lets avoid too many migrations and select the
> > >>> previous CPU in such cases.
> > >> Hmm.. if !WF_SYNC:
> > >>
> > >> 1. If smt, if prev_cpu's core is idle, pick it. If not, try to pick an idle
> > >>    core in widening scopes.
> > >>
> > >> 2. If no idle core is foudn, pick prev_cpu if idle. If not, search for an
> > >>    idle CPU in widening scopes.
> > >>
> > >> So, it is considering prev_cpu, right? I think it's preferring idle core a
> > >> bit too much - it probably doesn't make sense to cross the NUMA boundary if
> > >> there is an idle CPU in this node, at least.
> > >
> > > Yeah, we should probably be a bit more conservative by default and avoid
> > > jumping across nodes if there are still idle CPUs within the node.
> > >
> > 
> > Agreed. So maybe we check for fully idle cores *within the node* first, before
> > preferring idle SMTs *within the node* ? And then, as next step go looking at
> > other nodes. Would that be a reasonable middle ground?
> > 
> > > With the new scx_bpf_select_cpu_and() API [1] it'll be easier to enforce
> > > that while still using the built-in idle policy (since we can specify idle
> > > flags), but that doesn't preclude adjusting the default policy anyway, if
> > > it makes more sense.
> > 
> > Aren't you deprecating the usage of the default select function? If we are going
> > to be adjusting its behavior like my patch is doing, then we should probably not
> > also deprecate it.
> 
> I'm just extending the default select function to accept a cpumask and idle
> SCX_PICK_IDLE_* flags, so that it's easier for BPF schedulers to change the
> select behavior without reimplementing the whole thing.
> 
> The old scx_bpf_select_cpu_dfl() will be remapped to the new API for a
> while for backward compatibility and the underlying selection logic remains
> the same.
> 
> So, in this case for example, you could implement the "check full-idle then
> partial-idle SMT CPUs within the node" logic as following:
> 
> /* Search for full-idle SMT first, then idle CPUs within prev_cpu's node */
> cpu = scx_bpf_select_cpu_and(p, prev_cpu, wake_flags,
> 			     p->cpus_ptr, SCX_PICK_IDLE_IN_NODE)
> if (cpu < 0) {
> 	/* Search for full-idle SMT first, then idle CPUs across all nodes */
> 	cpu = scx_bpf_select_cpu_and(p, prev_cpu, wake_flags, p->cpus_ptr, 0)
> }

Thanks, Andrea! I adjusted the default selection as below, hope it looks good
now, will test it more as well. Let me know any comments.

----------------8<-----

From: Joel Fernandes <joelagnelf@nvidia.com>
Subject: [PATCH] sched/ext: Make default idle CPU selection better

Currently, sched_ext's default CPU selection is roughly something like
this:

1. Look for FULLY IDLE CORES:
    1.1. Select prev CPU (wakee) if its CORE is fully idle.
    1.2. Or, pick any CPU from fully idle CORE in the L3, then NUMA.
    1.3. Or, any idle CPU from fully idle CORE usable by task.
2. Or, use PREV CPU if it is idle.
3. Or any idle CPU in the LLC, NUMA.
4. Or finally any CPU usable by the task.

This can end up select any idle core in the system even if that means
jumping across NUMA nodes (basically 1.3 happens before 3.).

Improve this by moving 1.3 to after 3 (so that skipping over NUMA
happens only later) and also add selection of fully idle target (waker)
core before looking for fully-idle cores in the LLC/NUMA. This is similar to
what FAIR scheduler does.

The new sequence is as follows:

1. Look for FULLY IDLE CORES:
    1.1. Select prev CPU (wakee) if its CORE is fully idle.
    1.2. Select target CPU (waker) if its CORE is fully idle and shares cache
        with prev. <- Added this.
    1.3. Or, pick any CPU from fully idle CORE in the L3, then NUMA.
2. Or, use PREV CPU if it is idle.
3. Or any idle CPU in the LLC, NUMA.
4. Or, any idle CPU from fully idle CORE usable by task. <- Moved down.
5. Or finally any CPU usable by the task.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/sched/ext.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 5a81d9a1e31f..324e442319c7 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -3558,6 +3558,16 @@ static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
 			goto cpu_found;
 		}
 
+		/*
+		 * If the waker's CPU shares cache with @prev_cpu and is part
+		 * of a fully idle core, select it.
+		 */
+		if (cpus_share_cache(cpu, prev_cpu) &&
+		    cpumask_test_cpu(cpu, idle_masks.smt) &&
+		    test_and_clear_cpu_idle(cpu)) {
+			goto cpu_found;
+		}
+
 		/*
 		 * Search for any fully idle core in the same LLC domain.
 		 */
@@ -3575,13 +3585,6 @@ static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
 			if (cpu >= 0)
 				goto cpu_found;
 		}
-
-		/*
-		 * Search for any full idle core usable by the task.
-		 */
-		cpu = scx_pick_idle_cpu(p->cpus_ptr, SCX_PICK_IDLE_CORE);
-		if (cpu >= 0)
-			goto cpu_found;
 	}
 
 	/*
@@ -3610,6 +3613,15 @@ static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
 			goto cpu_found;
 	}
 
+	/*
+	 * Search for any full idle core usable by the task.
+	 */
+	if (sched_smt_active()) {
+		cpu = scx_pick_idle_cpu(p->cpus_ptr, SCX_PICK_IDLE_CORE);
+		if (cpu >= 0)
+			goto cpu_found;
+	}
+
 	/*
 	 * Search for any idle CPU usable by the task.
 	 */
-- 
2.43.0



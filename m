Return-Path: <linux-kernel+bounces-444183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF799F02A0
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 03:26:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5977D188C197
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 02:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81BB7433AB;
	Fri, 13 Dec 2024 02:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b="LHgT+XZ1"
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11010041.outbound.protection.outlook.com [52.101.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B461B3207
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 02:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734056790; cv=fail; b=NawfFY/OPIjP7P3WIp7N8TV/RWtZyaVpKHYBYITMHX90aV8MuvTPPZCSRzkniy9x4SCVu25CXI9rODy/ra47zuJUCNxS2ShC7uChvqWmHQuDzT1duBI05eQS2blxDx2XrQFfj5m0LbkE9ohuiV7QOD7VXS0nw4DhUWM9bJRyFOk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734056790; c=relaxed/simple;
	bh=+gpKkQRN6xPAZoYKSLB2ehxrF9Puz9SLiM8czMp5ux0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W6eF0uD8FC1Eb4sscF2cowNkt+WzuUa7YrFp3jYzNrsNlhZqozye6XO27CHpjBBMuvfMYDjnFBwB5HM5e5wVvnIpqPmW4BYTxTdOLpj2T2xW4Ay+gJsB1NFm+3L9GHfvhzJM4PDqvG/BAS+RoNAZ/YZmLrLmJoYy2b0Yn2gngJQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com; spf=pass smtp.mailfrom=oppo.com; dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b=LHgT+XZ1; arc=fail smtp.client-ip=52.101.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oppo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k43rKrPy+00Iod6RKW1YWFLrLapFXtch98Zu+ENxRjKM7aLoC+/iRwJQrVYhbZ9yWt4xGHQs20z80CQbpqbkzttOpg2eKV6WMN+a7DPREVYhwXk/e4XdWnwbdmAbjJ2Du8RgCE8oaKEdAPGPWji27c/O1w41aS/aqgotgY2ci1+Lnv6k4XslRMCJjgkRmjprqN+xjsgEkdZ42dttgnm+DIdjoc333tZx3ZGSDR3V337qj7IR7LDPYsHCeFHUHX4BV9n+2FtSFIknff1+tLCbe4nTb+uzI3i04dpXFyWBdjsIJDV6gpkrE6k/7bVjighwahBe7Q/XNQD/wBPDHefzVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FdLF0XcnNbbUmEzY9Rjbos+Db3BmJ3MMCmnAN44mNNQ=;
 b=y3Y4kuows9+BXhScfDoo9XMTYYkMOg3U9IVDKFzHO2vK6Qtel2yNjI0wB+bK8kLhzSc+874LEFEF5BvBKn6aeyyvblVbmQjWYdC1Uxj/AwgLHYC/hZ624SmyLN0JV+VURJmbyh9vF5NC44NJ/Jeuv3zv87glnvNShWreWwEW2tcL8YQjhqSMAj3rvpkOW+dSJxtfOnN8xserqqWt4JatNruaI5Z7fC9u+kWuEKo6r5ecazAPdQjkbkSMNBeP7crkf9y5D3i92lWTo8YkOfkI7LTX7ACCFt91jArCbgTDLy3pIqYYp9BBBlzpvnV85uSN+jNogGsD7y6GXQnJb86yFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 58.252.5.68) smtp.rcpttodomain=google.com smtp.mailfrom=oppo.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=oppo.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FdLF0XcnNbbUmEzY9Rjbos+Db3BmJ3MMCmnAN44mNNQ=;
 b=LHgT+XZ1eDl8Ja7hvyBDpb8Mj16/i1PndxMsvfZ9Qt2Vj3J+2sm+erK+Pm6DrDZZyrtUdxzfVIZXU0yViNTaYL66bMSnmHxc05o86/sPZEXbP/JaDpoFocoK6WUaALRBluPgbE8zBqZGRqttRAxlA5bu6EdtXmD+hAeWp6ldqv0=
Received: from SI2P153CA0034.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::17) by
 TYSPR02MB7417.apcprd02.prod.outlook.com (2603:1096:405:34::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.16; Fri, 13 Dec 2024 02:26:21 +0000
Received: from SG1PEPF000082E3.apcprd02.prod.outlook.com
 (2603:1096:4:190:cafe::de) by SI2P153CA0034.outlook.office365.com
 (2603:1096:4:190::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8272.6 via Frontend Transport; Fri,
 13 Dec 2024 02:26:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 58.252.5.68)
 smtp.mailfrom=oppo.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=oppo.com;
Received-SPF: Pass (protection.outlook.com: domain of oppo.com designates
 58.252.5.68 as permitted sender) receiver=protection.outlook.com;
 client-ip=58.252.5.68; helo=mail.oppo.com; pr=C
Received: from mail.oppo.com (58.252.5.68) by
 SG1PEPF000082E3.mail.protection.outlook.com (10.167.240.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Fri, 13 Dec 2024 02:26:20 +0000
Received: from oppo.com (172.16.40.118) by mailappw31.adc.com (172.16.56.198)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 13 Dec
 2024 10:26:19 +0800
Date: Fri, 13 Dec 2024 10:26:19 +0800
From: hailong <hailong.liu@oppo.com>
To: "T.J. Mercier" <tjmercier@google.com>
CC: <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <yuzhao@google.com>, <21cnbao@gmail.com>
Subject: Re: [RFC PATCH] mm/mglru: keep the root_memcg reclaim behavior the
 same as memcg reclaim
Message-ID: <20241213022619.ph22z2mxxyh3u3tw@oppo.com>
References: <20241212095646.16164-1-hailong.liu@oppo.com>
 <CABdmKX2__wuSLH2x=5=SqQR0wo86R-Xknua-q9BC44XQDjwgug@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABdmKX2__wuSLH2x=5=SqQR0wo86R-Xknua-q9BC44XQDjwgug@mail.gmail.com>
X-ClientProxiedBy: mailappw30.adc.com (172.16.56.197) To mailappw31.adc.com
 (172.16.56.198)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E3:EE_|TYSPR02MB7417:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a70d210-2f3e-435e-d601-08dd1b1d880d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z3E2Ynp2K2k2YW1pRnZQb0ZUNnM2ZTQySFlMZ3hWVUFEK05rdGJOUnpzdE55?=
 =?utf-8?B?MjRJMmxQWWFhNnBrb3dXRkRBUmdHakRmUFdodHBtNEJTUVNvWENidDZqVU9w?=
 =?utf-8?B?dElROU0wdm5jRlYzUG9qK2VDOUpMZW8zTFNUNzMxelNPazVvQlNOR1NNMitj?=
 =?utf-8?B?RGFmbnVnWGhXWHhqOUlHcVNJYVQ2WXp4eE0wc2VkbXpJOVBJMnR0NU85ZkdS?=
 =?utf-8?B?RjRMMzdOSlVRNE1uV0pjNGlrRDZEQ0JoVDNrTXFNUWVxS1ptcVVMSGNFRXVU?=
 =?utf-8?B?b2tFSG1scmtuTHQyNVBzVkVrUlFMUTRoYUhINndaNmpRbGdBYS8reTNsVWNO?=
 =?utf-8?B?bUlKQ1FiUk1IcWJQNVM4Z0FIakVPR1VrbHJ4dUQ0WlRkcG02UXJNUjUxMC9N?=
 =?utf-8?B?V3ltRlAzQlZJS3pmaWhTNEZHcHkySXlyVXBpTk5kWGVWcnZ2TnRtdWVsU3Fk?=
 =?utf-8?B?UHFYd0J5emN3Ykxja05tRC9nVGZqWVFFZHkxZ2ZrVEFRNS9wTnYxVEVUdzhR?=
 =?utf-8?B?QzZhLzkzYkcxUW9ucTZ2eERnSldDVHNseFV4dDNhaHlLbmpnQm1DQ1hMbmEv?=
 =?utf-8?B?VGh4dUtYcTdPQkczSHoyZ0NBWFpPN0lXT3pjeW1rMWEzZkJGcnJub00vY3ZY?=
 =?utf-8?B?NEcrREUrb3lTYno0TGZGVDNxZFJqVlE3YXNtMWhrK002QVk1UGFVZU1IRi9B?=
 =?utf-8?B?MCtkbXBMYVJSNHdsYjFHd2hwSmdQemx1MVVPZW5yZTN4N2lpNGIxTkdSQTZo?=
 =?utf-8?B?cU92bUtFejB4L2VNSGJQZnQwTTZ3ay90aSttZ2V2Q0J0b3gySEd0enBPMDJQ?=
 =?utf-8?B?Y0RsYk9ZVm9MUGhncUtwQk44VmltM0JKeEJyNDR6SmtQLzdUeXF3bUsvN3dp?=
 =?utf-8?B?VUdwWmpQQ1h4RU4vUm9xZGpod29zaUx0TGh1MDA2Z2xIRm9lQ05tMnRmak5K?=
 =?utf-8?B?QXZTZUJJczdLL016ZEo0RkZoOFNXcnFMRWxnV0tkZ0VSRTFvYjFwdzA4ekFU?=
 =?utf-8?B?Sk5TaVc4bVVlc1hRTWhTME5nWTRRb1pzQ1ludkpYQ2V2MmhQV1pUWFI4ZFBF?=
 =?utf-8?B?bm9Ebm1sYlN4ci9ScjI5V01WVzJXZmZmdmhJZFVKUW9pYlVhUjRmUmRzYlF1?=
 =?utf-8?B?YzFpU2xEUkJjQXRkbGF6N3ZzSUI3MzFQb3dIR1lqQjlaUXpIbm9JbUJKdWNa?=
 =?utf-8?B?SkovWk1yZjZnK1NnSy9jQUNqdGhRcnlEL05JY1VNUFZhcWU3eXNwQVBZcGll?=
 =?utf-8?B?Mnp1Umo0UlV5M2NzSXMwb2gxbVZrNW81SWhrS1FhaEdYRTB0UXVoazBYcFZ3?=
 =?utf-8?B?enU2eE5LaVdRUFVuM3AvV1lkcmhrOVpIWWl3V0FDS3lQSGhxSWxVczRRbjli?=
 =?utf-8?B?NDRuMnNFRjdaRXE5dGJhZnRKTWpHd04vcjZtMnlYMkRxVkY4VXViaFI4bDI4?=
 =?utf-8?B?SElSTHZFM29PUVh5aUJWMENIOE5ZZWg4YXpTbkJmWU1LWmwyVnkzeUNJbXZU?=
 =?utf-8?B?bEFUa0RhSzI1c2RNMEFpRThURWRoeGtZVk9qODd3b0lTanNZS3RxUjNSTXVr?=
 =?utf-8?B?bXZaZUVIMGI4RW5jeE0zQnYvM2RwV25FRTVZMDNLZjdQRkQ4b3U1Zm1teVpD?=
 =?utf-8?B?djlxV2lROUZOOFo3Uk5EelVRQVJZYml0K2J2dmp5eGZnY2ZvRld0NTVQalgw?=
 =?utf-8?B?SGlqeTlVajFaUU8xSDRORGp1UUNyT0kzTHVVQ2N2WjdPRXJIZi9aV1FNSStC?=
 =?utf-8?B?bW43OW83Tm1UL3dERkh0S2ZFYVlzMUs3QUdYSU5XV1prazVEL1M3TStlL256?=
 =?utf-8?B?NnZCVitZR2k1emxzMGpHQVZKaGpWaHpDVWVEdDEvVnVFbk1qcER4R25PYTFy?=
 =?utf-8?B?ckpjUnBrdXBEalU2ajIyMXRIWENsUkxnbVR0blJvZVlrallNQURoYVF5K2lX?=
 =?utf-8?Q?WkKwIvUASTQrMGgj1un1aeVwZvLUXeH3?=
X-Forefront-Antispam-Report:
	CIP:58.252.5.68;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.oppo.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 02:26:20.5838
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a70d210-2f3e-435e-d601-08dd1b1d880d
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f1905eb1-c353-41c5-9516-62b4a54b5ee6;Ip=[58.252.5.68];Helo=[mail.oppo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG1PEPF000082E3.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR02MB7417

On Thu, 12. Dec 10:22, T.J. Mercier wrote:
> On Thu, Dec 12, 2024 at 1:57 AM hailong <hailong.liu@oppo.com> wrote:
> >
> > From: Hailong Liu <hailong.liu@oppo.com>
> >
> > commit a579086c99ed ("mm: multi-gen LRU: remove eviction fairness safeguard") said
> > Note that memcg LRU only applies to global reclaim. For memcg reclaim,
> > the eviction will continue, even if it is overshooting. This becomes
> > unconditional due to code simplification.
> >
> > Howeven, if we reclaim a root memcg by sysfs (memory.reclaim), the behavior acts
> > as a kswapd or direct reclaim.
>
> Hi Hailong,
>
> Why do you think this is a problem?
>
> > Fix this by remove the condition of mem_cgroup_is_root in
> > root_reclaim().
> > Signed-off-by: Hailong Liu <hailong.liu@oppo.com>
> > ---
> >  mm/vmscan.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index 76378bc257e3..1f74f3ba0999 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -216,7 +216,7 @@ static bool cgroup_reclaim(struct scan_control *sc)
> >   */
> >  static bool root_reclaim(struct scan_control *sc)
> >  {
> > -       return !sc->target_mem_cgroup || mem_cgroup_is_root(sc->target_mem_cgroup);
> > +       return !sc->target_mem_cgroup;
> >  }
> >
> >  /**
> > --
> > Actually we switch to mglru on kernel-6.1 and see different behavior on
> > root_mem_cgroup reclaim. so is there any background fot this?
>
> Reclaim behavior differs with MGLRU.
> https://lore.kernel.org/lkml/20221201223923.873696-1-yuzhao@google.com/
>
> On even more recent kernels, regular LRU reclaim has also changed.
> https://lore.kernel.org/lkml/20240514202641.2821494-1-hannes@cmpxchg.org/

Thanks for the details.

Take this as a example.
	       root
	     /  |   \
        /	|    \
	   a	b     c
		    | \
		    |  \
		    d   e
IIUC, the mglru can resolve the direct reclaim latency due to the
sharding. However, for the proactive reclaim, if we want to reclaim
b, b->d->e, however, if reclaiming the root, the reclaim path is
uncertain. The call stack is as follows:
lru_gen_shrink_node()->shrink_many()->hlist_nulls_for_each_entry_rcu()->shrink_one()

So, for the proactive reclaim of root_memcg, whether it is mglru or
regular lru, calling shrink_node_memcgs() makes the behavior certain
and reasonable for me.

--

Help you, Help me,
Hailong.


Return-Path: <linux-kernel+bounces-302457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C5195FEE2
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 04:14:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DFF91B21800
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 02:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3007C8D7;
	Tue, 27 Aug 2024 02:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b="fnwMsC7B"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2051.outbound.protection.outlook.com [40.107.215.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901BCBE4A
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 02:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724724842; cv=fail; b=XLA1alDYUYzbwtK7Y5GM9TZNo4LJf4uQFj8paqCobc/wMLqoVcmjLqjaggFfApzGnjKpI3sIaBGFmDebyXLyuuWB92UlPCDoatnxKpM9IiXh/9dwUVvDDODrfCTJvd4Dx2Cd86ykX1GUXrlpzQ1xX0+8ZCV0Qeah3+LVUzm7wf8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724724842; c=relaxed/simple;
	bh=/AvP2WKSDYEqSDapoqvh/wm9RaEvT+0lwLcrf+461Ns=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l6kfRwz8sMkpUjv6aRC9c4MfeAzb2fDLO25axtdri4LVCjiOjxAu+HOq0RqVdHBT+gpVZ7mOLsnk4BOw+GYF+sqk73qB1tYJUWanouwlu+3b77yg0ufJOkL7w7vOCSRdDS4d8+HSAmLqze0Ih5OX/FfyUfJoTh4Jp46KoyypANw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com; spf=pass smtp.mailfrom=oppo.com; dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b=fnwMsC7B; arc=fail smtp.client-ip=40.107.215.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oppo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nERmyyUFaurwqToJN707iFHGosncMpjkuHTwSGM6dytzQeJor/sSI+SQC2WdVD05QiTD653XFL1Yw/Ljq7kiYMJuUV0zfShNSYT8N+TGPZaNeMM7vAVtjENZVytGut0wQ5Y4KPrxiOXmxjuTHF1znBueIDkSY4G7NglKzjdO2YFc9OP/uFMeWZo1RYWZefn7ZjS6+JM7NBQ+/kK5Xso2tFbswGYqETCLroSNvLvjM1jD5c3Tx7tPt+CcWTuvAW0o74ZuF5BUZBvD1MGKSayg0lLeOguX6hG2TxAZFXXjP0kGBSl3JqtcOfeRgzWQAaeRUEeJ6Y0FLHLw+gw/Ua+QbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/AvP2WKSDYEqSDapoqvh/wm9RaEvT+0lwLcrf+461Ns=;
 b=XwAbdkBQ+yQJVRlt8V+nZrKBOwKvkqp62nGAy6e93x4ZvyJugwmRTLGVfWfaGH5Ircs+JYG5wpnzTFPiDpr0rA159XXFmbhgWhTgSfUVDB5YUGtcRT8lM79mFZ93yE9UP4xdUGLROVhxkZcPOxZpSoS7Vj3Uhibw16FN9ff0A8DE1L0+Dg+a6iCxNm1CzuYjUrKQ6nbKNyB+7gw3ulkRhoKaNC415UBfUi1MvqVC3dhyGsuasgaYHirBo89jCcAXmaukA/eN4Yh5+dtDOFGNP1wTpQGzQnSHBKu9Ik4I9meOY+4K7PLZjv8lvd5VCDNo4URyYMB/FPPDGgb07sibuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 58.252.5.68) smtp.rcpttodomain=google.com smtp.mailfrom=oppo.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=oppo.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/AvP2WKSDYEqSDapoqvh/wm9RaEvT+0lwLcrf+461Ns=;
 b=fnwMsC7B9vZbXv78k6EHgRgt46JZBsCZK6k24yPoo7k+bkqLwhIAe7KvpLkPBa4XY520/AAUyz68iRGuYhWdgozYf94cUtKb7w4IB3EWweGM5xEeDZCwLsYRkw1nu2jxjdqMsw4OT7JYKkrk9ZR3N1GlRV3qH87x7JqXtwsP1F0=
Received: from SG2PR06CA0223.apcprd06.prod.outlook.com (2603:1096:4:68::31) by
 SEYPR02MB7097.apcprd02.prod.outlook.com (2603:1096:101:1a3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Tue, 27 Aug
 2024 02:13:53 +0000
Received: from SG2PEPF000B66D0.apcprd03.prod.outlook.com
 (2603:1096:4:68:cafe::23) by SG2PR06CA0223.outlook.office365.com
 (2603:1096:4:68::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25 via Frontend
 Transport; Tue, 27 Aug 2024 02:13:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 58.252.5.68)
 smtp.mailfrom=oppo.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=oppo.com;
Received-SPF: Pass (protection.outlook.com: domain of oppo.com designates
 58.252.5.68 as permitted sender) receiver=protection.outlook.com;
 client-ip=58.252.5.68; helo=mail.oppo.com; pr=C
Received: from mail.oppo.com (58.252.5.68) by
 SG2PEPF000B66D0.mail.protection.outlook.com (10.167.240.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Tue, 27 Aug 2024 02:13:52 +0000
Received: from oppo.com (172.16.40.118) by mailappw31.adc.com (172.16.56.198)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 27 Aug
 2024 10:13:51 +0800
Date: Tue, 27 Aug 2024 10:13:51 +0800
From: Hailong Liu <hailong.liu@oppo.com>
To: Lokesh Gidra <lokeshgidra@google.com>
CC: Suren Baghdasaryan <surenb@google.com>, Nicolas Geoffray
	<ngeoffray@google.com>, Barry Song <21cnbao@gmail.com>, Michal Hocko
	<mhocko@suse.com>, gaoxu <gaoxu2@honor.com>, Andrew Morton
	<akpm@linux-foundation.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Shaohua Li
	<shli@fb.com>, yipengxiang <yipengxiang@honor.com>, fengbaopeng
	<fengbaopeng@honor.com>, Kalesh Singh <kaleshsingh@google.com>
Subject: Re: [PATCH v2] mm: add lazyfree folio to lru tail
Message-ID: <20240827021351.iq6i7zkwm32xili3@oppo.com>
References: <f29f64e29c08427b95e3df30a5770056@honor.com>
 <ZsXho27uAbQ5rEgS@tiehlicka>
 <CAGsJ_4zgQ0MBV-yucc0-7BcDgjMMdCUDWK330mrd7SS4ej6Q8Q@mail.gmail.com>
 <CAJuCfpE7qsbFPseGzcBp27uNDhwtKLypKiPnqebE5=T8WDTyEQ@mail.gmail.com>
 <CA+EESO7BuywqjM9pk3KbgdfsYJerpU1-5d9AN20mBjA6e_97UQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CA+EESO7BuywqjM9pk3KbgdfsYJerpU1-5d9AN20mBjA6e_97UQ@mail.gmail.com>
X-ClientProxiedBy: mailappw30.adc.com (172.16.56.197) To mailappw31.adc.com
 (172.16.56.198)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66D0:EE_|SEYPR02MB7097:EE_
X-MS-Office365-Filtering-Correlation-Id: 25631ec3-8cad-416e-7993-08dcc63de594
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LCJpBo7td+/Pu/4bpDsXXzeLU4t7hdg6jrNMhR7P4LEEvx5wTFpyxm7LONX0?=
 =?us-ascii?Q?Zj+YarXP6MTBOUgvxnbRI24UsD3kaicCK2wrQ39QJ5rlK9wjd7XSJGZSh2+V?=
 =?us-ascii?Q?VjGDHQurghWXnAKqYmfseS3ZLWp84CYCacC8DnOMOGYrvEpLY6RnZBJypMnE?=
 =?us-ascii?Q?ZaAoiZgJ8q06/4lo3u8cEKnl/wk1hAvJOcH/gy4HCJExojbSSOvTH+dMN7AN?=
 =?us-ascii?Q?zqcLDp1cKrGO3LHSH8T4v93zjGcsOEQGaMAMz1SdkDyM6teLF6rWkvrQfk/U?=
 =?us-ascii?Q?Mwpl1VB4vY9GUa1/6XmSPhhFAXFpwIPHsUu5M/cBfNLGlFBlOJEtI5ColSsR?=
 =?us-ascii?Q?0iTPEzCtFjXdSwajzQqJGtWjCS8gz49gMojq5bj9XVeE6ggEKEp/tO3CukxY?=
 =?us-ascii?Q?4tQq+/89o9mh901FAkGZoJ0b8kpdjZQc2kRm6yHBwMTQmGOgAFAvuzpSIve6?=
 =?us-ascii?Q?bbcXcjdjsU+mCKjVJf1KNTsHQw5EuXT6sxdyAHRJQGvMFWyLiSnR1FY9XQeo?=
 =?us-ascii?Q?SAyy1af5CV9+YAQp/nh+FV35IJjRwmdC6jTotCOV+c8JpJoE5NG2lbIkiQLh?=
 =?us-ascii?Q?3T0o0vxLCLtkwWTJ7qM/wJBBtz3rzY1qhoGpxu0BFLQdgzU3wjVXfX2Ag+VK?=
 =?us-ascii?Q?yYoT94zug37TE9jyJQ5R/LXyi8hIaTueCoSYbHS/uPSapKv+OFsdW2fRXPim?=
 =?us-ascii?Q?4YBW2FrbQpuLhKRx0S13cns3YeLb3VedqNCaizZ6RfjFoV06ZXVejiU1D/wA?=
 =?us-ascii?Q?0Ptao/ZzSEakR2V6uIYYrHdVqmhrsJS/1e8t37ugTQusapAnFyODL0YMf4K+?=
 =?us-ascii?Q?NlrxM3PO5pmd5CWwQvpqkwUIwtxGDiJ+yqCixMRKaR5h+VZlU+Ud2qK/V9+f?=
 =?us-ascii?Q?+B5FYWvDlcnmlEf2KdBfcedjrvV1F/cBhzuUOptUSGB6NW5eulOQ9T5g0gPW?=
 =?us-ascii?Q?nBKmjtbrHg/MJljlbljwip1tMFnGqzaAx55UrEZlB6yQsxCzAsK4o2W7CBzB?=
 =?us-ascii?Q?AkPnXstOhe+FQRj+m+rV/qaMQbCBUo4tc8s0zPKBjcbL+vr1HU/tZeS4Wz2Q?=
 =?us-ascii?Q?EdUOTljT2/82cd29n2CDCakk8Y/gMPGlaD5No25nlP7E2OYVurMnmtmuULSz?=
 =?us-ascii?Q?gXWGcwVuzRaub2wJYXAa9VD8OKajAknT7egxyJP2wfXjK+R6qzG6D788dN6f?=
 =?us-ascii?Q?qzdAJpFvXTBAqg8+IMHQpPFNSMeefyQlI4tBTcboGxi5e47lajBbITLXHOvp?=
 =?us-ascii?Q?wyMrPxVrod5AKPWdVWsuEMBRqJ++bzfgmoBGLQuul87NZbBsQ2N6aYgCDjIZ?=
 =?us-ascii?Q?e6Qx1exLDewoGNPI8P+T/Jgy7v0NyuSHyWKDYrzjwSy7lMQ27LFoKwzkgCgN?=
 =?us-ascii?Q?aLeA40MAOuW05AF/K65ydnSdi9WfLhvU2lDy39FXa7A/Omhc99KRgOKl3LqR?=
 =?us-ascii?Q?sAG+9n4He8MeEzXqfEuQ8XU/oPVCENzc?=
X-Forefront-Antispam-Report:
	CIP:58.252.5.68;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.oppo.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 02:13:52.5847
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25631ec3-8cad-416e-7993-08dcc63de594
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f1905eb1-c353-41c5-9516-62b4a54b5ee6;Ip=[58.252.5.68];Helo=[mail.oppo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG2PEPF000B66D0.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR02MB7097

On Mon, 26. Aug 09:37, Lokesh Gidra wrote:
>
> IMHO, within LRU_INACTIVE_FILE, MADV_FREE'ed pages should be
> prioritized for reclamation over file ones.


> >
> > Adding Lokesh.
> > Lokesh, could you please comment on the reasoning behind the above
> > mentioned change?
>
> Adding Nicolas as well, in case he wants to add something.
IMHO, lruvec_add_folio is enough. if lruvec_add_folio_tail why not use
MADV_DONTNEED instead? In MM the reclaim policy prefer to reclaim file cache, if
MADV_FREE'd pages directly add to the tail, they might be reclaimed instantly.
Also the benefit of workingset_refault_file cannot be convinced for me.

So we should know the reasons and the benefits of the changes. page faults or ?
> >
> > >
> > > >
> > > > --
> > > > Michal Hocko
> > > > SUSE Labs
> > > >
> > >
> > > Thanks
> > > Barry
>

--

Help you, Help me,
Hailong.


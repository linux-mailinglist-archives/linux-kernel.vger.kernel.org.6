Return-Path: <linux-kernel+bounces-528917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 351D7A41DE9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 12:58:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA3CE189643B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 11:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08848264A86;
	Mon, 24 Feb 2025 11:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cixtech.com header.i=@cixtech.com header.b="Lk6Pmg49"
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11020132.outbound.protection.outlook.com [52.101.128.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D947825A33D;
	Mon, 24 Feb 2025 11:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740397005; cv=fail; b=mjf7ZI6Jh0ZGgHafqhyGy3Wt85iVF6ViDloWBz/a/5036yiCLyxXOii5bx+eZQZ/M7yH9VL/l1i372x4XtRuMkh+bL2WeMNskH93lT45vKStoVcNR0uf/CbpqhKfQUnHP0swvf73pH72NVtzWvgx6kltc4ErBzNKnQegLqQn3MM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740397005; c=relaxed/simple;
	bh=XC8PWEUSzSDtEFWuPkhzCcwacSQQ+KxOOJHRxb877bs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WuyHpuZzxhP3sTPKFFKQEkX7b13u5Ws3U3jH7Aqrnj61XmVmDI3JoQRbt9avINkahM+rnbHId3ipa2LxPUtSPnAeg5/zcXXpiAWcd8d6EjRHeseJ3NdHWhuZaDMPgjPUhlj56ANM7K+nFYUZGEIKXRQRrGrlInw6YTJBvKhwnVk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; dkim=pass (2048-bit key) header.d=cixtech.com header.i=@cixtech.com header.b=Lk6Pmg49; arc=fail smtp.client-ip=52.101.128.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IMpWF0PFIWn+Y1ZzfP2b9xOzuVQtxPiPCC+F0E9+JwtZnZviLhs2PPovE57uX5Cq1qSg+AaI224yuPFle6kKxUJoTCs2Nhf+2M0AF4oSuNUT0p4l/UgZVRFDHGfVpM2urEUlLbWZvFswkZE76ZLY/L+5FkxHjDyWDSDOR5kLxnu2Lvq7bbNIkGYv3pbgyvhBPFRaD7qtcV8hqckmNBLYQvBy5SoHglUeLre1KA0A82LLEjMci0Y42+DRAOgVx9cg2Wx9wX94vwZ1dquNms20z7a9OtHpaSHU3jxyhiU1GUi+COKkzUvMmZ0yOS5qsWZXNLj7/g8kfkD2REDAfodSaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gt/cmEL9D93k5bWb2cTiqgCz8cZnXiVXnIFSe3vC5VU=;
 b=eBC0Iytji2tVdIKcwGFtHM2f+2Vgh/RANDP7dh4QtJHMlzPxCx4WI2y9QwNPeqDOkP52GNrxQfrfP0Bb2BuFtsyY7leZU5I0h+SfiWclve+GE2RcL35nNpX1wnM2OoUSeIZUT5NnOlXusYxCXuPRKg7zhRT8ZiKf/pEetB6womZhvDT/7bmJYKNj8bOHk8BIDXs8AKfCX3npwEMnGB62si7Zvs4CTuC4gtD4oG6xFdRTHfg2ONIcWjvsK/gFt9S/j9D/vxOQdLmL2pwbCTZs56XuI5dgBQQRMjNd755izWnDPp0hjgzSk9QtNv4OaVnIbyUC6iu+8betHOkvr/rv0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=arm.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cixtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gt/cmEL9D93k5bWb2cTiqgCz8cZnXiVXnIFSe3vC5VU=;
 b=Lk6Pmg49+TWGHm6MNJfnFPTeHX4RYsst9eIdDP5fZilF6bAVlCnpEevbcytUJ7RCKYeU8x7y7MAYXQWzYdtRehGAgmJHJ/hUYRNLAAaD6zup3vlRm6gJmcdHHC2l9yE4WvyofrtwpNXeyVO2xr/fMhVvQPRWLDL5x+SmPjLep28IIXme0makG8wXIB5bbuLXv/FtiAFQXFYvp0ibxFPUy9eDfz+cOjj4EoKHYvw55zOj87u+kwKsRrBfrqMNRsxZhOCQhRXpm8Zi1TnzDONOrHkoS95PRO9Qn43clvJRHuiRrltV/5+cLZz/JCeEdN7JAdtInrtZOfmAG4BO5iAgfA==
Received: from SG2PR03CA0132.apcprd03.prod.outlook.com (2603:1096:4:91::36) by
 SEZPR06MB5174.apcprd06.prod.outlook.com (2603:1096:101:70::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.12; Mon, 24 Feb 2025 11:36:36 +0000
Received: from SG2PEPF000B66CC.apcprd03.prod.outlook.com
 (2603:1096:4:91:cafe::2c) by SG2PR03CA0132.outlook.office365.com
 (2603:1096:4:91::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.15 via Frontend Transport; Mon,
 24 Feb 2025 11:36:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 SG2PEPF000B66CC.mail.protection.outlook.com (10.167.240.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.11 via Frontend Transport; Mon, 24 Feb 2025 11:36:35 +0000
Received: from nchen-desktop (unknown [172.16.64.25])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id BC6CB4160CA0;
	Mon, 24 Feb 2025 19:36:33 +0800 (CST)
Date: Mon, 24 Feb 2025 19:36:32 +0800
From: Peter Chen <peter.chen@cixtech.com>
To: Marcin Juszkiewicz <marcin@juszkiewicz.com.pl>
Cc: "arnd@arndb.de" <arnd@arndb.de>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	cix-kernel-upstream <cix-kernel-upstream@cixtech.com>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Fugang Duan <fugang.duan@cixtech.com>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"robh@kernel.org" <robh@kernel.org>,
	"will@kernel.org" <will@kernel.org>
Subject: Re: [PATCH 6/6] arm64: dts: cix: add initial CIX P1(SKY1) dts support
Message-ID: <Z7xZwGTIKgj9_zNZ@nchen-desktop>
References: <20250220084020.628704-7-peter.chen@cixtech.com>
 <068655e7-2ad7-4497-aca7-4100ad478d99@juszkiewicz.com.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <068655e7-2ad7-4497-aca7-4100ad478d99@juszkiewicz.com.pl>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CC:EE_|SEZPR06MB5174:EE_
X-MS-Office365-Filtering-Correlation-Id: a86333e3-0ec7-469e-8b8e-08dd54c77e79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IdKrXEFKCLHep0YogcxKC+/ayGc74qXnEbHZvwDuBuk7jr+6omJEG0j0YExN?=
 =?us-ascii?Q?0ueYt1aLw3t06isU25lEq4IilB0EqG1JdCEfmNb6hVFXveGQLqXBqfuzkTKt?=
 =?us-ascii?Q?F+hmtvBh+hJBpFZjgF/Ii5Q3JY/g4tnrSwBv6XkHARKLJvm7oSrIR13i/qQB?=
 =?us-ascii?Q?DBvX5nmP29jg0R+fcCsoOfHmL/3K/tGnuQk6F8jNH7pTPA+k/BCfnhhk+E8l?=
 =?us-ascii?Q?OtwjXF4aPGxYoi8F6vnw90jMBvQneSQ+83unKJwWW3iYDociM9zaqnjqyJFo?=
 =?us-ascii?Q?1oRI5py1XAdF1x4PLVzIVBxbI6iBFSQJhYVHmAAp2NnE4TlGt0pRibnTDP8v?=
 =?us-ascii?Q?3hkDewBFRuYaLJQsWBD8/TRMCwszCgnQqjqbNlHEio2rCVU5GTYg5YdFJYd+?=
 =?us-ascii?Q?fbchKgMt30DiC1EOZe1Hp80I0ibQhNvIONmiKd86uxD1azqxHFGqmWcf5L4I?=
 =?us-ascii?Q?edp46PGlL0NQonawRhuHmiL9U0H17hMoFKE7u4ebQDadPjVlD4Qmo2MtlQNi?=
 =?us-ascii?Q?awUayMP30pE1g7ua9UnRbVUHCfxdxRyPXPDFbZ0YhOG5Z7HiPFcxDZpmgtmC?=
 =?us-ascii?Q?CGSv2bX4UMid9YtcFUJXNISpmz3kCiWXGWi20wS43GAeUGdi86bXFD0tpgM+?=
 =?us-ascii?Q?WcG0+qHTRNX0zR5ZsnsJSwYzEq+ficl+SEG1dCp3jSX3OaIbhs8qRAEbV7ts?=
 =?us-ascii?Q?K3zyQE13s6Hp/A9naBY0PBV8pkHLhudWxNddBxo+XjO0G26KWiDswivWhq17?=
 =?us-ascii?Q?cWqrVlvRfnk16JbfpFIV0Qq2nyL9nM0QGTZSL3dqm8KQBfIW/3ZkY6m7MldA?=
 =?us-ascii?Q?Sk3Ir4CzqgHQiM0ggiRPk/UKb+KDHHi/Q3i6IW2TURTCVkpfm7z8S0oL+G96?=
 =?us-ascii?Q?xHybYL+yQcHLcvyA0yzg6wUCrdtudtko+JMB7q+wgg0MYv5kgBQLQN8VX80a?=
 =?us-ascii?Q?e2LWFssDbJewDAL7Pho4nG8iXk0XUIdHRkkXzRxXdLjN47OxMkbOP1NOt31D?=
 =?us-ascii?Q?oJbEHkwRk6SQa4SrR6tJhTA9O8GtDenB8b9WbA7ri7gSOacfQwsU3LBumyHd?=
 =?us-ascii?Q?U6JE/njoGdWiTwh6cvFKlqCPjr8klGcKyTpLPVaQn5rLutVu4+8tQG7JeRvs?=
 =?us-ascii?Q?9N6s/pX6GhYWWP2QKLCbyvz9C1HMRUQxmYHxHrzxVlMRqVqN5T6MdvBtqDEh?=
 =?us-ascii?Q?spQ289gefC2R0OEEl8SQnj1KYMI+T4MD3atGssVVLttC8Zi1WEbkdmkYF7Ud?=
 =?us-ascii?Q?MybB7mDVSJNUzGE6Ht+l7bDbOLU+3cFSpM0lMFD7oNEeX1FohEWW2b/NZhXa?=
 =?us-ascii?Q?/f/Ioi0mJ9vjnFu9fmg+V/aEqSyAS1vDmcy4fuyquiRBx/PDkA1uut6uk1m6?=
 =?us-ascii?Q?ligLrKxyg8RgRve4Fv5LXul8m7/FM+kX61qkLhZhE/W988/JCxP0xoxMjKmV?=
 =?us-ascii?Q?v72z0V9ak/ncWe4X93nMAvVxAkJwDGCmcP/JdKL3vcRcqrIOBy4KCGv5R3YR?=
 =?us-ascii?Q?KfRU7IYIZC53Qsw=3D?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 11:36:35.1254
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a86333e3-0ec7-469e-8b8e-08dd54c77e79
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource: SG2PEPF000B66CC.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5174

On 25-02-23 04:05:10, Marcin Juszkiewicz wrote:
> 
> > diff --git a/arch/arm64/boot/dts/cix/sky1.dtsi b/arch/arm64/boot/dts/cix/sky1.dtsi
> > new file mode 100644
> > index 000000000000..d98735f782e0
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/cix/sky1.dtsi
> > @@ -0,0 +1,264 @@
> > +// SPDX-License-Identifier: BSD-3-Clause
> > +/*
> > + * Copyright 2025 Cix Technology Group Co., Ltd.
> > + *
> > + */
> > +
> > +#include <dt-bindings/interrupt-controller/arm-gic.h>
> 
> [..]
> 
> > +     arch_timer: timer {
> > +             compatible = "arm,armv8-timer";
> > +             interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,
> > +                          <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>,
> > +                          <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,
> > +                          <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>;
> > +             clock-frequency = <1000000000>;
> > +             interrupt-parent = <&gic>;
> > +             arm,no-tick-in-suspend;
> > +     };
> 
> This is not Arm v8.0 SoC so where is non-secure EL2 virtual timer?

It is the Arm v9 SoC and back compatible with Arm v8.

-- 

Best regards,
Peter


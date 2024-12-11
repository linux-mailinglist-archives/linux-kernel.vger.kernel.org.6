Return-Path: <linux-kernel+bounces-441699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B10969ED2C1
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 17:52:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D77D41882675
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 16:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 875391DDC3B;
	Wed, 11 Dec 2024 16:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="f/lRgIB3";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="f/lRgIB3"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2058.outbound.protection.outlook.com [40.107.22.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE321DE8BA
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 16:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.58
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733935885; cv=fail; b=t1JCEXUq4IR0xPdWyGDMEDlf9DvVxd7jOTHIuuOjygvB+UmT1EhZQ0pDq15Yhdgn/ycd+AyZ2vd0XbWLKQFVKUjAS9mZkcAu44Ruli6y+iU4qWJWIyHi1SyQ9yDDT0X9QweIxpdudNz/7VvmP91Bcy23mIThjhMbYosxjdQaHmE=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733935885; c=relaxed/simple;
	bh=etIDknxbtc1S0vQu+Jn/sK87Lkmm7aDS0DY3eZEGYn4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=COqAE9KICpVPo5bzOUviNt+h1qo2I/TBLDOdesGdJ0HY3IR9YI3NWaQ4ySIY3ys/iJUmGudJM21orCbL8JSjHsNRSA7wiWC7fYmHe3EBIxF2oy5TDsoeY4CoOGDifWdipPHQ/jNruKAtl9UCbz4FbeDIwokxhi6syhoTHFJJczs=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=f/lRgIB3; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=f/lRgIB3; arc=fail smtp.client-ip=40.107.22.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=Z4MML9G8sEh/97nAOSF69MHnJ8p58fBo/LFTndrFXBljvnIv8SL0g442z31K8mBMa+E7EtLjtUpYQzgaI7rO4ADEU0pm3mhpg5or1DMnNCINNPtCNZZKR/obQJlaEw1Abura4/gCrIs6gvcSb5LPVmpE6u7VFbtUS9hYB6Nc9KVCITk6xW/GTbgPvAtUyrAmjknQUF6pD4KhowAo+wFpJh1UTqGNmvii2nm+2UWch4LK8dA9YrM7GY/KnOq78eJRkgUC8cF3u7u1d0RNSaDoWAfYhfHgCVnWUQcn2RS++9p6fcp2Qsssz66+SUPh+3zDD1Hi3x2aS6kx4gdIgvkCMw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bKg/67rYZmh6NYjhU9gjQ53VEeK6A3Xe2GXQM/vg0RA=;
 b=mI17xF+CrgDTW3nH2n4GEFeU6GSqZj6cPFWxjiH1uOzShBOok01pNZRR922HlOmk9qlon2jFNsBujBOFKEunXMpSlYkJRKVUYRfg1uxsni/dxfLl3TIKtaS/TkQRGQkBIK+HEuCGXMi8thc6aOw8ndcle5wBLwK9fdNWgDD+z5V2ZqHm4WoGY7jN3ZHWNQYLp/OpairMrxBCopwQtZ84FAzAl03dN3a7PyWtcPACphVjmpQsBsmoXv/SYzeo2bgJ/x5w+fPdEjdCXDM81rtjgHoI92wp3uc8VfVDGbirglmnR2IqYKRo36YMVsFZ3Ro2jlM2igDujM6v+JpEywa2hQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bKg/67rYZmh6NYjhU9gjQ53VEeK6A3Xe2GXQM/vg0RA=;
 b=f/lRgIB3WwsDA92oUJsLaYiFWDCc3Lmk4rMMtmnJwRl08lIZme1i1/i5O8UgbOF/gSQQDvpkcIfQJZyJTkE6MnyApG206yASckrBpfgPiJfnzeglB6oeci5zUCxMDQaodsMOi5S4ahdO7nWlYc1d0TAXV0KahF9SnUwhyRvGRL0=
Received: from AS9PR0301CA0019.eurprd03.prod.outlook.com
 (2603:10a6:20b:468::29) by GV2PR08MB8677.eurprd08.prod.outlook.com
 (2603:10a6:150:b9::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Wed, 11 Dec
 2024 16:51:15 +0000
Received: from AMS1EPF0000004B.eurprd04.prod.outlook.com
 (2603:10a6:20b:468:cafe::d6) by AS9PR0301CA0019.outlook.office365.com
 (2603:10a6:20b:468::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.15 via Frontend Transport; Wed,
 11 Dec 2024 16:51:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AMS1EPF0000004B.mail.protection.outlook.com (10.167.16.136) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.15
 via Frontend Transport; Wed, 11 Dec 2024 16:51:14 +0000
Received: ("Tessian outbound 2d228e31de9a:v524"); Wed, 11 Dec 2024 16:51:14 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: e164a7827162b85c
X-TessianGatewayMetadata: wxMRNHlx9L39bHspbKxLxr3AW2TQwIOmcja+JkZbt6ndO7KrG6k7fbFn9JAVIFINwvb34QoJWgMk0+f77oTF0BCt/g562l/FRzjcvr95SyoAxnFTloAhkO29/FYta8QOeKVapRv/IPWKjaj6s25sXFY2/PQenyogqGHc+MkZSXw=
X-CR-MTA-TID: 64aa7808
Received: from Lf4c2a157c311.2
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 213540C7-8374-4E74-9716-3B02186A3045.1;
	Wed, 11 Dec 2024 16:51:08 +0000
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id Lf4c2a157c311.2
    (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
    Wed, 11 Dec 2024 16:51:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yF9QsjirKIV4mkm8N0xCPNHQzMBC4X35fdg1bEpzQARAW++4jBiXwkMCdIX0aYHOGmiFLGY6bNwVY4LJ+DBfqfyStLLt1MF9/i58wsfP/aZgaTya7saUDkoVB14DsYgR+dWyTG0Pw973H2waq76bceTa7ztw7JsnPz9nvq4F3f8lzYAEIrIbublMlMCTl4aEI2Pw3Y6oo82F9YDQqEU+ViHTbTi2SYiiFkaDAQw5M2frAmtxXYrPZajaqXxgMKs8nAX+mQ/w8OvM2msuixIcNazB7uCOyTDWhWm17wTTz+FJtS8P8I4/Kg3x4cTknnLds7SdOOn6IrkJ2begyhyKcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bKg/67rYZmh6NYjhU9gjQ53VEeK6A3Xe2GXQM/vg0RA=;
 b=rrY0Ptvf4H2LzMAIEExGZjXFrBbTk3RFGID0Bha3+olL+MOBnhNStUIvP21r5rhMiU7aH6Aj1n9vQ296B+hMso8thTV2GpA+3tAByp7wbWFv36/GSRKajOjJGBrFyNH6oGEXfrDa5D36pTMoXFPVf85wBRSA8Culfy6B9SDzCvO4KEQo1WPdbKg7dLGc+ojMjgYVxIz+fhDoZp99ce9mLVr8UqsN0UYuA68ooIni3tyMoMVUCdgqmPigGbWfAUlnispVtriQZrSz/uWFK7uTsZ9UfPN2JRlSx/IM0FBV6jwX7o8HS9Fd3ytmD0IyLvLn62KBiy77yNTj1nNfXESCug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bKg/67rYZmh6NYjhU9gjQ53VEeK6A3Xe2GXQM/vg0RA=;
 b=f/lRgIB3WwsDA92oUJsLaYiFWDCc3Lmk4rMMtmnJwRl08lIZme1i1/i5O8UgbOF/gSQQDvpkcIfQJZyJTkE6MnyApG206yASckrBpfgPiJfnzeglB6oeci5zUCxMDQaodsMOi5S4ahdO7nWlYc1d0TAXV0KahF9SnUwhyRvGRL0=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM6PR08MB3317.eurprd08.prod.outlook.com (2603:10a6:209:42::28)
 by DU0PR08MB8493.eurprd08.prod.outlook.com (2603:10a6:10:406::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.19; Wed, 11 Dec
 2024 16:51:04 +0000
Received: from AM6PR08MB3317.eurprd08.prod.outlook.com
 ([fe80::e42a:494c:6581:1897]) by AM6PR08MB3317.eurprd08.prod.outlook.com
 ([fe80::e42a:494c:6581:1897%7]) with mapi id 15.20.8230.016; Wed, 11 Dec 2024
 16:51:04 +0000
From: Lukas Zapolskas <lukas.zapolskas@arm.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
	Steven Price <steven.price@arm.com>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	=?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Mihail Atanassov <mihail.atanassov@arm.com>,
	nd@arm.com,
	Lukas Zapolskas <lukas.zapolskas@arm.com>
Subject: [RFC v2 7/8] drm/panthor: Add suspend/resume handling for the performance counters
Date: Wed, 11 Dec 2024 16:50:23 +0000
Message-Id: <20241211165024.490748-8-lukas.zapolskas@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241211165024.490748-1-lukas.zapolskas@arm.com>
References: <20241211165024.490748-1-lukas.zapolskas@arm.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0218.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:33a::19) To AM6PR08MB3317.eurprd08.prod.outlook.com
 (2603:10a6:209:42::28)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AM6PR08MB3317:EE_|DU0PR08MB8493:EE_|AMS1EPF0000004B:EE_|GV2PR08MB8677:EE_
X-MS-Office365-Filtering-Correlation-Id: 05174565-27f9-4219-1b05-08dd1a04068b
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?Q4MaBE183tweZDq/aeTaI4GBfoVDzQYgCcL6URYthgYr9aJdUtHpxI2NXw8/?=
 =?us-ascii?Q?ST7wYEQGv3GQ4y6izI7a1OxBzRLLctAJnApYuyMGQRtNmMtLpaq8JvGReL0Y?=
 =?us-ascii?Q?9EzbTLTDjNI78wvxFQ+E/dKTwZLLSUQ2yrhDSCVa3U6DgJ9Iw10rpGOkv8YP?=
 =?us-ascii?Q?1WKwowaYoazePZ3S2d/DfEcAZ+6IuX6MtF//je9USC2GhW5ScvdXsXww9NQv?=
 =?us-ascii?Q?RrzDJ/Rc/UbTrOro/Q5HMVGJ51ksMsoJ6NhnT6d8mdG+T636ap4N+J/ucuWf?=
 =?us-ascii?Q?ZVCVwdUxn3QyV0Xh7LnlZz5aqcFEycQLkwAQYmFwfSZPTiRZUC88dn4xRu8U?=
 =?us-ascii?Q?4eGaN2Rmy+G66WgaksB7v2K3VMd9BrcSwJJCvXBnARMJ4ymVqHc333HLJxEU?=
 =?us-ascii?Q?nlF0IVkPMCuBfo663b5RGCPFbaeqvDywN2b8EMMrNl0NMY6Af9e853v0D9GV?=
 =?us-ascii?Q?wl3486c+9vfxPZJm79SXn8KNv3S/71ZCOcZy0a0XIW0BC14mbBSmkpG7Nw0R?=
 =?us-ascii?Q?QJYUYqDctkwzdye1NIiXCXWMNwt54vhWxAwBOQshDehF69qUXy1It9rAoIjA?=
 =?us-ascii?Q?5VjLr83sFohuWPNnC//yUAcX66bkxyU9HjAPfN+3qJOE3Q9UYUtjxk3tIRvz?=
 =?us-ascii?Q?hPenQJz555Aqsv10P+Hn+1309GAu8VEuFUI5+SkSaT3hy8P9OMgp06N2StFG?=
 =?us-ascii?Q?h81q+IoEuV+E/ITzCntayMKBmOh4dg4VZLTGTqgcXJnRLACoesVfwWuWscu1?=
 =?us-ascii?Q?9CcsFdqaGbKILvnoDIDYk2oW4RjX5DoOJcH58IjRVkPh4+gj8qvZEH+6ibdh?=
 =?us-ascii?Q?Lmi7juAt1IG1nHZyQeMgfwNCmzEo6NbKnsBCth107EmUu/CZ4wXweT89y1Og?=
 =?us-ascii?Q?blooTyT2sk7VePS9aXjsbY8owj1dxnntcV0d84Q65lQnU0Xf3hzUwT5g52xC?=
 =?us-ascii?Q?88L3l0WQ2sY/6vuspOArhHsIqERKJznmYVKLLFRH7D7F3ZM9qRoqR8JSbUfv?=
 =?us-ascii?Q?iy4+eD7iApGtk/Lp/OLUAZQ3S78wGniitHx2YQVr4J5C66wRXwXiYEmKP5Dh?=
 =?us-ascii?Q?ujIRQc23ln5ddgP50BiGGIzoQ5e0gHDFmBK0oDb1qFp8+EwkMJ0wWCA9WmTw?=
 =?us-ascii?Q?6pMM6lpgoCCyaSoWU4g9wRp/hMJY8OxiyH32eH07y/SaL4aw091JWxg2JAvT?=
 =?us-ascii?Q?iN67f6kUMYDakQW+pRldQgRCOufThLnYunI1WtTLtKB/911x1pb7iJ5BHnQ3?=
 =?us-ascii?Q?Bsrl1Lc4YqhverYR0fdJxPcAsWGWk9xJ7J/EpUXTnSnuEidswqmpTevk3gnj?=
 =?us-ascii?Q?uNM3iqv/o2AvZN/9M3qTHp8asy4+w+XUp8cVPoNn6glwjQ=3D=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB3317.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8493
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:209:42::28];domain=AM6PR08MB3317.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS1EPF0000004B.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	9f9ca443-e79e-4f73-1fd8-08dd1a040060
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|14060799003|35042699022|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bMmBkJAgvXj9B3wCEc0BTmCXJVKRfsNIaS8aPAcNZ5ewnsrjnQYBK92Y8of6?=
 =?us-ascii?Q?t0mMoo55iLRZRzZ0qTtHH7EKd7x/NvI12WBpcCxydRDrGIiyk5xRZtST53Ng?=
 =?us-ascii?Q?oQ8Yi39lt1kfXeyUxvwyT7reQFMPNzu8lPZqJnp55tMPJwx8Xu5wu+4VpVUZ?=
 =?us-ascii?Q?WF7jYsQxtaPuY6yvrtpfQ19PYHSZJ6dLu6QGuT5JOQtSR948tZCsOQuQcUEu?=
 =?us-ascii?Q?SBxlwkpc6Ju28NwrRISivDF5S/JOGCgZ/fh5zEQV4+7QIiJEZet/vVr2fCCJ?=
 =?us-ascii?Q?UpIvDFVKfM0VgaMj5fMEOXBLd1gnA583F/nw9cGdvgDnciGIMvFMT9kLB+hL?=
 =?us-ascii?Q?3pgHA8Hh/h5vULzEeqCTlNqhLJu11ks830MYFpaiV1IQbp3CgZyICHMCnsKo?=
 =?us-ascii?Q?TAPSFfQR1nuDL3AXpPkhxeRgJsgUYBrCWSuOZ34ePWbbuY+xW0Th+BG1tR0A?=
 =?us-ascii?Q?BbnGm4Gf/RAJ1q+1EdKPNQePehZn/Y9+ElaCw50HhnM8HxiuzVx6YmMERz2H?=
 =?us-ascii?Q?kz3R2Vbct5hP5L8PK/WUpvVWqB4MydL3N7t97BVcHwhGouWe7+kZJkOxFdHk?=
 =?us-ascii?Q?7/DofKxlmzvBZhgZSIYmG+AP2SlTcXdgXG1EXlI+WqG6vyCgoYoU74yjeN4g?=
 =?us-ascii?Q?2MKgq7fYDnj2ldKVLsMZeJ54HuVu6xo85LXqqAM2/IyVxqnJw+HLcdUcjKU6?=
 =?us-ascii?Q?MsKem9bucjmz2VEQX8FeEDBn6wJ31QG9qWJdbsonvjjRGYpYzkN0K8Be1tgH?=
 =?us-ascii?Q?yGyNjlR4ZJtojGk4hPPFZjiM7efYctHLTYsoSAOUyV4mdGkb+Q6cNpjW6NK/?=
 =?us-ascii?Q?bDEkNNHPpZ5zAJnatSG1wTAB0HrQ3KEQd3O+XfJ0bSHnRmDsU027KR0s6/UF?=
 =?us-ascii?Q?tZxHBPZyy06Sr8oaVify/ZzDzk6ZiLtCq2agGGEojCJXU1i/3OzfjrrNo0mf?=
 =?us-ascii?Q?BpqDQkTr3iLqGIJKz5MYSvfq+H+fXIFBw929GDKb2REPoWh6Z/I3NuvzhSeJ?=
 =?us-ascii?Q?QWdsiWua9hcFaFHOrULTbr/E/HEEkvF2BjtHSsH88v1UxlRvSfKucpeTRotU?=
 =?us-ascii?Q?KETvgkx+PXyMYiJrQDzKh3DXHJxoy8kMASdFWcaGd5/kA9ihf0VDFEUHjGEE?=
 =?us-ascii?Q?LzHjID7GRwM4WuR0rG+pWdsULXvzG6u1ZweW+kFNiKb5SiDNaZeRi+dAdate?=
 =?us-ascii?Q?um590uGh8xaiS2Er9ZOAx9PHIrgv1SCEzP880mbIdrllnGPIMgLFYjkgN+0F?=
 =?us-ascii?Q?qKQ7oX5M/FzgeZngkfbtT+jLq3Y5aj+9zOisNoZpDyiJEYDrVoppZwpo/tQt?=
 =?us-ascii?Q?9BRz+PEB9rmdyRfVYWZ3nDBzMZozsf8JajW8RQXgo4DBzLOre1hRh/SO4bnv?=
 =?us-ascii?Q?AoZKUZWX4WgWdeeVF9Vkl+DwxJZRZuXpQXoD0E0WdKkKcy5OCNWF05hsAKdZ?=
 =?us-ascii?Q?mRjll0TU39JcEYrDm8/eRT4NuHg3GSoEoYnE88ZnCpGtV7NO5T7WSg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:64aa7808-outbound-1.mta.getcheckrecipient.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(14060799003)(35042699022)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 16:51:14.7668
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05174565-27f9-4219-1b05-08dd1a04068b
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF0000004B.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB8677

Signed-off-by: Lukas Zapolskas <lukas.zapolskas@arm.com>
---
 drivers/gpu/drm/panthor/panthor_device.c |  3 +
 drivers/gpu/drm/panthor/panthor_perf.c   | 86 ++++++++++++++++++++++++
 drivers/gpu/drm/panthor/panthor_perf.h   |  2 +
 3 files changed, 91 insertions(+)

diff --git a/drivers/gpu/drm/panthor/panthor_device.c b/drivers/gpu/drm/panthor/panthor_device.c
index 1a81a436143b..69536fbdb5ef 100644
--- a/drivers/gpu/drm/panthor/panthor_device.c
+++ b/drivers/gpu/drm/panthor/panthor_device.c
@@ -475,6 +475,7 @@ int panthor_device_resume(struct device *dev)
 		ret = drm_WARN_ON(&ptdev->base, panthor_fw_resume(ptdev));
 		if (!ret) {
 			panthor_sched_resume(ptdev);
+			panthor_perf_resume(ptdev);
 		} else {
 			panthor_mmu_suspend(ptdev);
 			panthor_gpu_suspend(ptdev);
@@ -543,6 +544,7 @@ int panthor_device_suspend(struct device *dev)
 	    drm_dev_enter(&ptdev->base, &cookie)) {
 		cancel_work_sync(&ptdev->reset.work);
 
+		panthor_perf_suspend(ptdev);
 		/* We prepare everything as if we were resetting the GPU.
 		 * The end of the reset will happen in the resume path though.
 		 */
@@ -561,6 +563,7 @@ int panthor_device_suspend(struct device *dev)
 			panthor_mmu_resume(ptdev);
 			drm_WARN_ON(&ptdev->base, panthor_fw_resume(ptdev));
 			panthor_sched_resume(ptdev);
+			panthor_perf_resume(ptdev);
 			drm_dev_exit(cookie);
 		}
 
diff --git a/drivers/gpu/drm/panthor/panthor_perf.c b/drivers/gpu/drm/panthor/panthor_perf.c
index d62d97c448da..727e66074eab 100644
--- a/drivers/gpu/drm/panthor/panthor_perf.c
+++ b/drivers/gpu/drm/panthor/panthor_perf.c
@@ -433,6 +433,17 @@ static void panthor_perf_em_zero(struct panthor_perf_enable_masks *em)
 		bitmap_zero(em->mask[i], PANTHOR_PERF_EM_BITS);
 }
 
+static bool panthor_perf_em_empty(const struct panthor_perf_enable_masks *const em)
+{
+	bool empty = true;
+	size_t i = 0;
+
+	for (i = DRM_PANTHOR_PERF_BLOCK_FW; i <= DRM_PANTHOR_PERF_BLOCK_LAST; i++)
+		empty &= bitmap_empty(em->mask[i], PANTHOR_PERF_EM_BITS);
+
+	return empty;
+}
+
 static void panthor_perf_destroy_em_kref(struct kref *em_kref)
 {
 	struct panthor_perf_enable_masks *em = container_of(em_kref, typeof(*em), refs);
@@ -1652,6 +1663,81 @@ void panthor_perf_session_destroy(struct panthor_file *pfile, struct panthor_per
 	}
 }
 
+static int panthor_perf_sampler_resume(struct panthor_perf_sampler *sampler)
+{
+	int ret;
+
+	if (!atomic_read(&sampler->enabled_clients))
+		return 0;
+
+	if (!panthor_perf_em_empty(sampler->em)) {
+		guard(mutex)(&sampler->config_lock);
+		panthor_perf_fw_write_em(sampler, sampler->em);
+	}
+
+	ret = panthor_perf_fw_start_sampling(sampler->ptdev);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int panthor_perf_sampler_suspend(struct panthor_perf_sampler *sampler)
+{
+	int ret;
+
+	if (!atomic_read(&sampler->enabled_clients))
+		return 0;
+
+	ret = panthor_perf_fw_stop_sampling(sampler->ptdev);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+/**
+ * panthor_perf_suspend - Prepare the performance counter subsystem for system suspend.
+ * @ptdev: Panthor device.
+ *
+ * Indicate to the performance counters that the system is suspending.
+ *
+ * This function must not be used to handle MCU power state transitions: just before MCU goes
+ * from on to any inactive state, an automatic sample will be performed by the firmware, and
+ * the performance counter firmware state will be restored on warm boot.
+ *
+ * Return: 0 on success, negative error code on failure.
+ */
+int panthor_perf_suspend(struct panthor_device *ptdev)
+{
+	struct panthor_perf *perf = ptdev->perf;
+
+	if (!perf)
+		return 0;
+
+	return panthor_perf_sampler_suspend(&perf->sampler);
+}
+
+/**
+ * panthor_perf_resume - Resume the performance counter subsystem after system resumption.
+ * @ptdev: Panthor device.
+ *
+ * Indicate to the performance counters that the system has resumed. This must not be used
+ * to handle MCU state transitions, for the same reasons as detailed in the kerneldoc for
+ * @panthor_perf_suspend.
+ *
+ * Return: 0 on success, negative error code on failure.
+ */
+int panthor_perf_resume(struct panthor_device *ptdev)
+{
+	struct panthor_perf *perf = ptdev->perf;
+
+	if (!perf)
+		return 0;
+
+	return panthor_perf_sampler_resume(&perf->sampler);
+}
+
 /**
  * panthor_perf_unplug - Terminate the performance counter subsystem.
  * @ptdev: Panthor device.
diff --git a/drivers/gpu/drm/panthor/panthor_perf.h b/drivers/gpu/drm/panthor/panthor_perf.h
index 3485e4a55e15..a22a511a0809 100644
--- a/drivers/gpu/drm/panthor/panthor_perf.h
+++ b/drivers/gpu/drm/panthor/panthor_perf.h
@@ -16,6 +16,8 @@ struct panthor_perf;
 void panthor_perf_info_init(struct panthor_device *ptdev);
 
 int panthor_perf_init(struct panthor_device *ptdev);
+int panthor_perf_suspend(struct panthor_device *ptdev);
+int panthor_perf_resume(struct panthor_device *ptdev);
 void panthor_perf_unplug(struct panthor_device *ptdev);
 
 int panthor_perf_session_setup(struct panthor_device *ptdev, struct panthor_perf *perf,
-- 
2.25.1



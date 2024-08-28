Return-Path: <linux-kernel+bounces-305428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 024F1962E77
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 19:28:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BD88B23F1D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 17:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E218D1A76D0;
	Wed, 28 Aug 2024 17:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ReNAqNPO";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ReNAqNPO"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2083.outbound.protection.outlook.com [40.107.21.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0191A76C0
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 17:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.83
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724866062; cv=fail; b=NJZ5D9/R19NBbob3H9tR9pF/21DVkniybELr/xRjUZN0LQDREpTBKR9zmz1jnnAX/4Cg0up9ePC8TxQHUZ3+BxXqKD9u6x0kL1wYIRmf99581k6CIjpo5J+5FoJSGhRFx8dq6/8bHU6i9t/l3OH+tbWC2yjtxx9vtGmNAG3rlXE=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724866062; c=relaxed/simple;
	bh=nBW1afqYCCRigr1U/cRvSaGEteChHLG3uuiFJksE2Ek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=njBwtZ4Vo5RoRoz3XfH0PgwaiPZheD1O7PFfJaDX0wYTGFupDy6D2+OG1BG4aNuqrrBhaax5JS2LanBNfaLbpwLbFf2O+IwVQ7doX0bfoD5rD/82kFE70nPbvDIIkCuudpV3byacr0QJ0YywSmRzS6uGrB27mdq1h7WCURTJtgM=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ReNAqNPO; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ReNAqNPO; arc=fail smtp.client-ip=40.107.21.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=HR7MjoawqxKnzjJz9y5Ystw+9yiJlfYMYbJIELe1zlQl24ORL/2vca//3W+8PzOiDgg3i9ls4upLDS+Z6efQPP+yLAB1n6vqXqGxHVB0MvJxWmNZKZ25eNiQ1akvQhU7G9P+zF2sN15b/mZFyf8ZfYZibMvEkdf/VTR92cpAPftCPwOCzlQJHOuOTMvP8nxdvhgOPF4Tc1R0ALL0lqsnsRbliHmzuilbLCVHPSxjMStcb7kRmpdZkx3DFvtv+VTeViFVjuXq7IVFAFi25ID0I6MFyYl0S/NNE84G6EC/anDb5W78n4z8yyQKYU6rhNe1UkXzvHyJt1NsDgPyqxGIwg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vmd1NFhAixuB392WGGWTY8mLiA3VFQLMI4H/ONrGpqg=;
 b=XAjqMnHleOthmJGMwo1k/8DQzQrfBYZg/trcrQjN6rniAh6F+GBdRffPbRU6cioHoCDAGcIY7KicOcfXrTRCIgi7R9sMzmVu3zZqupaVK1HRLMsGnrMzlkwh2XmLUnwCCXk6WtgKZP0DGHs3PC7o4C/oAVl3ySAGWwNLKdOyGaiwzZbrnVyAEeh3Yw21uOQUuMR5XLEDEJmQO9ByG2CChyiHy9Jms6rc8Qz59kY7wp3v9RElfWoNzuGRJ91p7UAfQ6TRg02HFLABMMySewz/BR0WcBLRR8FbD6zAG0Qm4O3N1jDycR5NXyKY0/i3njFCDN1BHVKbwVzenInoI9C65A==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vmd1NFhAixuB392WGGWTY8mLiA3VFQLMI4H/ONrGpqg=;
 b=ReNAqNPOE7cdbb9VUK/pHTuj9qwoPp4TDxQT+7vFZV6lEX3Hz5IfIIqoDy8uRq7A4INWIMOiiSER32mE0xw8nTq9LeidSuE3SQoDPr21LO94/Q668c5USkt97qFqZtG2QvB2UqlVsvvhJkl23NcqMYGV3JoAXCldEHnafK3Jhac=
Received: from DU6P191CA0026.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:53f::17)
 by GV2PR08MB8196.eurprd08.prod.outlook.com (2603:10a6:150:7c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.14; Wed, 28 Aug
 2024 17:27:33 +0000
Received: from DB1PEPF00050A00.eurprd03.prod.outlook.com
 (2603:10a6:10:53f:cafe::e5) by DU6P191CA0026.outlook.office365.com
 (2603:10a6:10:53f::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.27 via Frontend
 Transport; Wed, 28 Aug 2024 17:27:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB1PEPF00050A00.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7897.11
 via Frontend Transport; Wed, 28 Aug 2024 17:27:32 +0000
Received: ("Tessian outbound 8e666bd17457:v403"); Wed, 28 Aug 2024 17:27:32 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: b771c889ed2d3c06
X-CR-MTA-TID: 64aa7808
Received: from Lf6cffd2a39ab.1
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 9D0A480D-8F3E-4EF8-8850-1258E836B2E5.1;
	Wed, 28 Aug 2024 17:27:21 +0000
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id Lf6cffd2a39ab.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 28 Aug 2024 17:27:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kCk1B2iPLFOXzijNMUu6RGNhNI1BWyQfOyM9LfXOxlTA0WRuSNf7WEqyG8q8+lleVnYhl9/55nff/hxNpuwCVrwTfbPjxrgVnaeNqyl8KgWsQo6ozK5jPcTx6fBp3UIB9voy/HFaExpW65Pzgtio+t3/1gSLpbOC7GPguCGeQwW4IBog0hWRG7ijLgA3lkyWuyAOaib2XoJH+iLNzW3hGurRwfQrhFuCe0fcmBsv0fXS70BDnKNC3Y2+7ypHv09wzqL9etPZVTKuo4V/G8CGYtD7ub17J6e2sj9dkqxQeJZuyq49/Uw7uwEX17oEO0qkLqTSL4Yodf9a/KM0kKxinw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vmd1NFhAixuB392WGGWTY8mLiA3VFQLMI4H/ONrGpqg=;
 b=JXij3Fp6F+yNFiWV+RREEWvtZRVk0mmBjPzfhwCQrtbU7I8EvmHmtXBoYkG9+hrsdZUhnEuRLEwyvn9gLUArDkPMS9YxQE+72ZpnaELrlShcWZYIXOerQnKKuUAVeapibukzetxV71BLLGOpO+s95jrFkum+LBoY6iXl4Py3OIFHCPzv/ToSDbRLhR/7lhxCd+KtcQkZtwcfZcqY4um0pL+Ay9eRrcOYxRjzQc7F8BFRsG635UU2oOlcVHtfdcrVrsGfUAwC6PmKaM+MMIm6akJsUM4HNecMcyIJoIkQunU+hAJRAf3RmowGKQPGS79KBn3jDWmsJtmQNdc/fUBQOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vmd1NFhAixuB392WGGWTY8mLiA3VFQLMI4H/ONrGpqg=;
 b=ReNAqNPOE7cdbb9VUK/pHTuj9qwoPp4TDxQT+7vFZV6lEX3Hz5IfIIqoDy8uRq7A4INWIMOiiSER32mE0xw8nTq9LeidSuE3SQoDPr21LO94/Q668c5USkt97qFqZtG2QvB2UqlVsvvhJkl23NcqMYGV3JoAXCldEHnafK3Jhac=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AS8PR08MB6263.eurprd08.prod.outlook.com (2603:10a6:20b:290::9)
 by AS8PR08MB6551.eurprd08.prod.outlook.com (2603:10a6:20b:319::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.18; Wed, 28 Aug
 2024 17:27:19 +0000
Received: from AS8PR08MB6263.eurprd08.prod.outlook.com
 ([fe80::12b5:3f0a:2090:fa7c]) by AS8PR08MB6263.eurprd08.prod.outlook.com
 ([fe80::12b5:3f0a:2090:fa7c%7]) with mapi id 15.20.7918.012; Wed, 28 Aug 2024
 17:27:19 +0000
From: Mihail Atanassov <mihail.atanassov@arm.com>
To: linux-kernel@vger.kernel.org,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Steven Price <steven.price@arm.com>
Cc: dri-devel@lists.freedesktop.org,
	Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Xinhui Pan <Xinhui.Pan@amd.com>,
	Shashank Sharma <shashank.sharma@amd.com>,
	Ketil Johnsen <ketil.johnsen@arm.com>,
	Akash Goel <akash.goel@arm.com>,
	Mihail Atanassov <mihail.atanassov@arm.com>
Subject: [PATCH 8/8] drm/panthor: Add SYNC_UPDATE ioctl
Date: Wed, 28 Aug 2024 18:26:04 +0100
Message-ID: <20240828172605.19176-9-mihail.atanassov@arm.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240828172605.19176-1-mihail.atanassov@arm.com>
References: <20240828172605.19176-1-mihail.atanassov@arm.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P123CA0029.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600::17)
 To AS8PR08MB6263.eurprd08.prod.outlook.com (2603:10a6:20b:290::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AS8PR08MB6263:EE_|AS8PR08MB6551:EE_|DB1PEPF00050A00:EE_|GV2PR08MB8196:EE_
X-MS-Office365-Filtering-Correlation-Id: 46a14335-6687-4667-be29-08dcc786b36b
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?5d+T0opbfSDpM2cNxak+5DFUXzVYC6ahjTEXKIb/tweqt2GCYhoN6ydFYcIz?=
 =?us-ascii?Q?X7OhTbvHtJmFN1fokjJzyqN8HqNNBoOyPq4MbSlUxWd9XOUeZmo06IWZYl5Y?=
 =?us-ascii?Q?iIrpN9LfmOZNGemHjTPh0DxrznWo+rN4psuPqbIGPs3kpD7GxS/vZGIMbEi+?=
 =?us-ascii?Q?lAR/49S8q0aHZssSEeMM61qARaUC2KBY6dzqkN6kcZ7mW5YQoBFR9qoH84js?=
 =?us-ascii?Q?vflRNpmGVtPOyM4kfCNRcP8UH9k1xteUXB2ZyW6kOxSYCqOh7z62rm6ozqAG?=
 =?us-ascii?Q?4ErJxV+gu8MXrY79/+1+9mnfat7T6U6rx1rdQZvg/h34bfZNNZSU8ZfA00sq?=
 =?us-ascii?Q?PvvDCGihMaEBK9Pdw81dM2h0moB0aHogg5bIXwDeWnAbQ+kkAXRhf6Mh3IBG?=
 =?us-ascii?Q?vJhSteRXshJyN0WUu8nvgAdqPhnHikvCKJagMToqzSYOfFD4M8AOEZeVPafL?=
 =?us-ascii?Q?P5t55SD0SRRnBvWFef3I8BpbIaW0rDkQXV2Bj/rTuaUw/JeKMKh9tzeCV3PF?=
 =?us-ascii?Q?H3ZL1DTh1ofYN+2y8Zv3+sVXWzgYYj2rk9X28yeAfA6Os5CnVhemZrtukCdz?=
 =?us-ascii?Q?U40VFAaf0P0HPt7cAvABdHdmMAHfGswq8VFiS+65ezGx6u0RxkWcaQcx6dne?=
 =?us-ascii?Q?hq6VjgCt9Vv6cpkBUzw1W1+z5q4AG5I2EkHcA3JUZPsfaR5KJQc3/qERQy0M?=
 =?us-ascii?Q?moocQMksCUiodu5uaFgvqDW3+uXff/zt+2N/6XMNPVQQeXQ2udSQGWixgC7h?=
 =?us-ascii?Q?dU8mUxzqbN+QjyadzNPiyirbQfTkMR9njTuCOU4mtoDmwjqBTjkyOduFl0lG?=
 =?us-ascii?Q?7jPDZ81CIcKgdkVTIKfnk0UCLNhj4+AX6s8fYhxYnLj2krdqHIPN7KVFqQ4E?=
 =?us-ascii?Q?nh+dvIHLoYQbTT/aKTjJ0sdx87vNPCcW52vFlUnfeOTN8U0RLKR0zpB0Uw92?=
 =?us-ascii?Q?OF3Fq/8+deFk6ksD0+HERnGJkv6vs2zzlIbMuXBDrOjoeq4QmljkdUONHw9A?=
 =?us-ascii?Q?i0MAhhBLN1I9r9Wh6Tfu2eytt9NPelpdjVL/X7tytyhH7L5wBquwYaXGLh7C?=
 =?us-ascii?Q?tQe2q26UJKtTD3HB/CMFQqbL73usv+Ur7whjV/Idy4qkBHehxyP4AmNstsC5?=
 =?us-ascii?Q?uPQLSICDONODms1Df4717LWKAjqKkr66eNV43lnqU/EbDgW14im0ra9My+n6?=
 =?us-ascii?Q?padRS28I1qBCtIgnYzyd55TbwXNAt1+r0GFuapmvVwKx0hPWrJAwECoiuRVc?=
 =?us-ascii?Q?kt0M3iaXMGsOOD7EEOi+gNXIXkpvdEcPsgUACRCZ2/oUlvLfeFwmHRIUaewd?=
 =?us-ascii?Q?I3LEkhVjz8dHjDwr8mh2DAFypGzI97VEbRG25rQivxYB7Q=3D=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR08MB6263.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6551
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:20b:290::9];domain=AS8PR08MB6263.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF00050A00.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	561ef853-d6ec-40da-b0e7-08dcc786aac5
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|35042699022|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?i1vEAF95AGBkzWoNJ0bvYDMFHYbU6cmlQO+KU9hW5+r39aB8KNCLzRSLIeO9?=
 =?us-ascii?Q?3hS8hIfwYvgCLRbFpHjiVpCSrsrV6MPGYfBp98U6jQOl6R5QIkodDGyqiiN9?=
 =?us-ascii?Q?xyz2lf45qXnpO2q+yeNGAeMdEP4r+rLXJzXRoxhXKDVcTdFDlmkIW7PJZVTA?=
 =?us-ascii?Q?OW/rT1N1uriLANc1ajA+c81pLz4ghFfxka7tOiKuyV/SiLJFZTNxfSXT9NHs?=
 =?us-ascii?Q?JwklyA3v5BNULX7YoSrsnAAfM7HltKXan8PYaNduPt+YLbaCOs9lmnkTYaj8?=
 =?us-ascii?Q?XIqfFbxinVMamj6dNbwPJC4eCMTm1z7xuzP2JUBu2yeFe9X2VnPMxXTIROfo?=
 =?us-ascii?Q?mVrQzRA9Rb2tOwjjtJgoEVD6W3jfvj80Jeb5k1Z4KZnnqxHA1MTp78yKzkz5?=
 =?us-ascii?Q?x00Ejr9BtZmzULCo9i+DDEh/twnVB0HH1MX6ObkOZ8dxMSWpEUdB4dQAXvpY?=
 =?us-ascii?Q?9kIgIPgaFgYpn972ZgJPmc5hcVI2R/ltkAGuL54nl71fUtvwMbjxt8Ml6LNe?=
 =?us-ascii?Q?Lmo02I2yUOKFm3W+5oTfm4D+aJqR8KoYAjhqnalnGzLmb9lsw/+7RNoOvyog?=
 =?us-ascii?Q?KLm3XLC7+LNPGW/i+Z9PokofuINK8y358cmYyKM3MBRcRYwbrzuNMDXawTFT?=
 =?us-ascii?Q?Tw0FEVLZCHI+onXzAbDfAqrSQDbJTwg8/3mWbNgcx+uxN9bjGTrL8Cq941hR?=
 =?us-ascii?Q?6Jv+OYT3eKAwWjG84JFS00uGm1NDloHU1KQMPGEDXt7wN9E+C5XzaHY6uok1?=
 =?us-ascii?Q?rTMXcxmLnhHLfMlWc50EXtNBscS9cEg32o9Jp1d3DOyF5mJAj8G641qXMT9g?=
 =?us-ascii?Q?MtxdiBOspPESnZkRBYlr2u3SwoBZWICgSvXSgYapahnxNqg/gJ7fG3LrnpNW?=
 =?us-ascii?Q?lzFMcatqth4rBt0+VioZ76wOJx9hf6YegLSm12iBcV60R5L4PFocg8PZX0oX?=
 =?us-ascii?Q?70PzEIpobZ3m4CtjHr4yyiY9RMtx1Z6ayYOlhBFi9iZ7H/XOpqyCaUM6Ud9R?=
 =?us-ascii?Q?MEnZgtt+vpC8tMtWWVcPmufR554gsXG+AUsSKEiQge+JMg9Re6FiZL9+jaYp?=
 =?us-ascii?Q?jxW2Mzxx6DVON2HLk31bnH4QcNyEoTS85wSbWUpoQ25LS6NusN2sTfHEyl+m?=
 =?us-ascii?Q?CoOfAd1UPC/Njo0atFPlVUFIPdPMwOHLW1ZEzHGMSoB/aL2hU1QNONOzSf36?=
 =?us-ascii?Q?y85MzG7s0prNwUW0GBlln6ikJ5qgj1NWs69DZaMhif4gIphV3p2XNdev/qp8?=
 =?us-ascii?Q?eGldEPY5DVKNukSxifhDGeboTV2P8fXil5cb95CRagxg2pXqJR9FlVrzbTin?=
 =?us-ascii?Q?FAokOlsorbUp3XtUC0Mzax7gzsVHcwtDNz873lEJzCtZf2d5L16kiZWpFr8t?=
 =?us-ascii?Q?38QaFQ+3c2/21evCYbCTr558yyqkQUAHYDpzVhqnKQrATXVJKPLimUm7UlRw?=
 =?us-ascii?Q?klpj1Jl5yDat92T/8hxMbReRjQD9uFD3?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(35042699022)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 17:27:32.9183
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46a14335-6687-4667-be29-08dcc786b36b
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF00050A00.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB8196

From: Ketil Johnsen <ketil.johnsen@arm.com>

Similar to how the kernel driver notifies userspace about syncobj
modifications, the reverse notification is also necessary to let panthor
re-evaluate any queues (GPU or XGS) that were blocked on wait
operations.

Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>
Signed-off-by: Ketil Johnsen <ketil.johnsen@arm.com>
---
 drivers/gpu/drm/panthor/panthor_drv.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/panthor/panthor_drv.c
index 681ac09b6343..1734a52dc3b5 100644
--- a/drivers/gpu/drm/panthor/panthor_drv.c
+++ b/drivers/gpu/drm/panthor/panthor_drv.c
@@ -1426,6 +1426,28 @@ static int panthor_ioctl_xgs_queue_submit(struct drm_device *ddev, void *data,
 	return ret;
 }
 
+static int panthor_ioctl_sync_update(struct drm_device *ddev, void *data,
+				     struct drm_file *file)
+{
+	struct drm_panthor_sync_update *args = data;
+	struct panthor_device *ptdev = container_of(ddev, struct panthor_device, base);
+	struct panthor_file *pfile = file->driver_priv;
+
+	if (args->pad)
+		return -EINVAL;
+
+	if (pm_runtime_get_if_in_use(ddev->dev)) {
+		/* All sync wait ops will be re-evaluated when we ding the global doorbell */
+		gpu_write(ptdev, CSF_DOORBELL(0), 1);
+		pm_runtime_put_autosuspend(ddev->dev);
+	}
+
+	panthor_sched_sync_update(ptdev);
+	panthor_xgs_queue_pool_recheck(pfile);
+
+	return 0;
+}
+
 static int
 panthor_open(struct drm_device *ddev, struct drm_file *file)
 {
@@ -1508,6 +1530,7 @@ static const struct drm_ioctl_desc panthor_drm_driver_ioctls[] = {
 	PANTHOR_IOCTL(XGS_QUEUE_CREATE, xgs_queue_create, DRM_RENDER_ALLOW),
 	PANTHOR_IOCTL(XGS_QUEUE_DESTROY, xgs_queue_destroy, DRM_RENDER_ALLOW),
 	PANTHOR_IOCTL(XGS_QUEUE_SUBMIT, xgs_queue_submit, DRM_RENDER_ALLOW),
+	PANTHOR_IOCTL(SYNC_UPDATE, sync_update, DRM_RENDER_ALLOW),
 };
 
 static int panthor_mmap(struct file *filp, struct vm_area_struct *vma)
-- 
2.45.0



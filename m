Return-Path: <linux-kernel+bounces-305424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 040FC962E70
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 19:27:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36322B23782
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 17:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9744C1A7043;
	Wed, 28 Aug 2024 17:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="nGHL5dke";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="nGHL5dke"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2080.outbound.protection.outlook.com [40.107.22.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A181A7061
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 17:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.80
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724866020; cv=fail; b=NAbkSyF/tdsOgootXsJHZDnkXL4iAsEtNaQLVO27rrbI2s/Jw7+gZULQNU4/NX4XK/wfFMuuWJZehPc2HYxviPJXYNyd6JXTWR1o2OXdkliiiRwLJw9+T2hKY816llUgc6FfRgJ7TIVqtkUxzP+eb+qUbOU49ZB5eg10Xduqppg=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724866020; c=relaxed/simple;
	bh=38jnVqXzshy0B5dsYePucUcKl2dOs6osKFwQY7G6zwY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VQFMVVR+vkwfKLYvpQ9ExGAGBN+c+5pji4zChJbrB4LYXWhKHjO3P0TvUsC0uO9EYfWedkD81iAh1cyOIHAfh+irn9HYbUu0NYtZ2NCL9g5q4w0hGGhRp7E/xGt4cFf2c8hIRNpFIwM5NQXeicECXHCENpPQswZSm/C5RmPthDU=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=nGHL5dke; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=nGHL5dke; arc=fail smtp.client-ip=40.107.22.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=F7SRjE6r+YLTEZAJgzV5Y/A1D55Xn+SPrHBpYSPJfGLT7Y1km2vrUWAfIYGLMXeO0QNeXhLwKY+uptNkanreIvBJf/4wiwma3n4fgCvITQVccWz8n/pY5I2SKeHacZ3yyJUueXFdczeAfndMQPqUqbkEldSZ7zXJeqmTUHvVDNvx91rbJixZiU6Pi3c69+Q6xFpr3S6vNdpBZerSJHoFly36MB/rTodnzIPsCeqmbRuBnBiQZceMROxaPMW5XTISBjcUHxGlFX9D52kqrEQUI0k07SSljFrFiDtpFzPZzLNBEy32bk/DjTk/YDEsjUHHHUiI+Y2Puq3vWl9P7hAjvQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jsyr/X8MHIRhYF+PyOaSjkZn52wXKUqGIKzc+LyjLpw=;
 b=dK5XHKK7HMBHDgKJ4PzENsiXFUf8dvOMJuWziww/GAArMCYET04aZAv2bQ+WV2cBJL3znGaz7qE+y8OU97qJHYflWAZMPSsDlupZO+ChBrxy0BvuCcRU1VB4rXTUuLMIuwrxy9hkwXsqwSllTANMT9Uw1flzlxOrXmH1CzT4+Oukak5lJmdo+LnUggN1ApDnlDmQVTRQKp4ALtrv7mUNhtFO0aeJWZj0m4fdGvUmnEy0xsQEeBEEGAYXZhGgN293VXToB5Y9/X3hVaWtzPhsgEfXhtpPFxtmDG92INDRa781ORx2t5PNptuG5CyHgd13Y4hZFDKtwlU8wqkrJX/fYQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jsyr/X8MHIRhYF+PyOaSjkZn52wXKUqGIKzc+LyjLpw=;
 b=nGHL5dkeJfyQlJbcCC/2iAzM6OCBeRkwc6ojam3wRoGqX9I4oZRadf0TKRWBpIKANnMWeowQ2c6CsKQaoPVlLEUtYErqr3Q6C44848yPy2RKmnw06cOnLtytUvNDbvifYjr3jHjINTAF+VYvugv175pOzbs+8NTTfgyh6JrS1C8=
Received: from DB6PR0301CA0084.eurprd03.prod.outlook.com (2603:10a6:6:30::31)
 by AM8PR08MB6578.eurprd08.prod.outlook.com (2603:10a6:20b:36a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.17; Wed, 28 Aug
 2024 17:26:51 +0000
Received: from DB5PEPF00014B8A.eurprd02.prod.outlook.com
 (2603:10a6:6:30:cafe::33) by DB6PR0301CA0084.outlook.office365.com
 (2603:10a6:6:30::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.27 via Frontend
 Transport; Wed, 28 Aug 2024 17:26:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5PEPF00014B8A.mail.protection.outlook.com (10.167.8.198) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7918.13
 via Frontend Transport; Wed, 28 Aug 2024 17:26:50 +0000
Received: ("Tessian outbound de2677e4ad72:v403"); Wed, 28 Aug 2024 17:26:50 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: d05880de0e48030d
X-CR-MTA-TID: 64aa7808
Received: from Lf8210dc8d799.2
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id CBF86C59-D217-4141-B45D-DF5592FBC08C.1;
	Wed, 28 Aug 2024 17:26:39 +0000
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id Lf8210dc8d799.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 28 Aug 2024 17:26:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FA/8Nke9zGa91+MxQKVrdWGX0i9kqbZ5V0FGCdxLQXarAAHhNsDFKkux4E3sLcBwG0iEF8Mg9u7GeIrwIdfXPWAvEM/9rOfWmEO6PWluRG2eM0iGEy97rol3X28Bn5oSCk2BxPMxiLxbkBB5NILeuB8yGeZdMbe2S6tCjWbJdaWREMBYbJehFpqmWOLcpfBchoMi9FJ9IpLE2gZHRDsZaaAAWEmw/b0b6M2f6sAKZjK42vewk0N+lnnR5FXdasU/+VqP+RpnjyG1Oj8ucAHB3W92UnmsAdr1PRxzNp28eqjVIc7xM1+ZsbZ8mSNJ1UR9q7GonchMKV/irAheKG+N5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jsyr/X8MHIRhYF+PyOaSjkZn52wXKUqGIKzc+LyjLpw=;
 b=GuJ6NSqaEzTJ3M6BnoL4ThD5vv8hWEdB4D7QSOH0UqntZBM7olq3BsaCElXIrHKQSWLA3J2Imy4+Pc5x6L+SBpBFOcHbDo4to7R2S4iguDMAusMx7nKWveMt2lDJb810iyxhYN6v98/3MXa13F0T9sSxSiQqbQW+BVIe7XKPQa7N/NmhQ/55bNRWFbm3Mdnh+kJ86f4qCno1lQcPsX1FStziY54O18mAvvLtXKVAr+aHRzkaBpfnLhNR6ZO4oE19/GJrT7taPekrKWDWpK0ED4zSgvdPVicm7FJOQ0hi+jgjygMiCk2f6lDhh8FKOtEumC0hqSgqME2RLYSB35Pj6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jsyr/X8MHIRhYF+PyOaSjkZn52wXKUqGIKzc+LyjLpw=;
 b=nGHL5dkeJfyQlJbcCC/2iAzM6OCBeRkwc6ojam3wRoGqX9I4oZRadf0TKRWBpIKANnMWeowQ2c6CsKQaoPVlLEUtYErqr3Q6C44848yPy2RKmnw06cOnLtytUvNDbvifYjr3jHjINTAF+VYvugv175pOzbs+8NTTfgyh6JrS1C8=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AS8PR08MB6263.eurprd08.prod.outlook.com (2603:10a6:20b:290::9)
 by AS8PR08MB6551.eurprd08.prod.outlook.com (2603:10a6:20b:319::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.18; Wed, 28 Aug
 2024 17:26:36 +0000
Received: from AS8PR08MB6263.eurprd08.prod.outlook.com
 ([fe80::12b5:3f0a:2090:fa7c]) by AS8PR08MB6263.eurprd08.prod.outlook.com
 ([fe80::12b5:3f0a:2090:fa7c%7]) with mapi id 15.20.7918.012; Wed, 28 Aug 2024
 17:26:36 +0000
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
Subject: [PATCH 4/8] drm/panthor: Add GROUP_KICK ioctl
Date: Wed, 28 Aug 2024 18:26:00 +0100
Message-ID: <20240828172605.19176-5-mihail.atanassov@arm.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240828172605.19176-1-mihail.atanassov@arm.com>
References: <20240828172605.19176-1-mihail.atanassov@arm.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0076.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8::16) To AS8PR08MB6263.eurprd08.prod.outlook.com
 (2603:10a6:20b:290::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AS8PR08MB6263:EE_|AS8PR08MB6551:EE_|DB5PEPF00014B8A:EE_|AM8PR08MB6578:EE_
X-MS-Office365-Filtering-Correlation-Id: c8892a49-6e95-47ee-d67d-08dcc7869a5b
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?xGgHVKwEom//WAyiRqVILzEXylRXdBCZMJ3LN/Cou0l8gsvjp6rUv7+KVno3?=
 =?us-ascii?Q?h22njv/PkQszLL6q791HorrLjLjglLF7/crBbhwsV14BSNh2lZdgablFA3Pw?=
 =?us-ascii?Q?U5qy+oVh/DCDtjIygu6o/bKr87OSNzRAZy01t8OK0keVkjQC90t1rxgA/Arg?=
 =?us-ascii?Q?960BoxeDM0Romcw560CMbc84cf6+K/o2faMX00UM471+7oTeAglJxew33oaL?=
 =?us-ascii?Q?mE+c+8F6pRxD86vK7WdwOGlL4AN477TI+iBhurAIMQ5JhGSgLZH7trqND+02?=
 =?us-ascii?Q?jUUzs2EPdR76Wg1y6yM0Lk8+NCrOiplHoH0T4OZTGQkCY0jFopFxFd7LO9ho?=
 =?us-ascii?Q?Gh6W60sRIJHMxTe7eH43rW/hDrIIXGDCpIpawUJS10oAo6Lf/Z/kaKoIvxxu?=
 =?us-ascii?Q?LZ+WwqD0GWSkBh1vDd+rDxsNHt4eT6ABEXSfRF/gniogodjHsc/6BIOgiXry?=
 =?us-ascii?Q?un+oVgVeGofVLWz2JzeIeihnk8mijAEyqRTCC8TYNzRQ3WEFvQBCIFpalvkI?=
 =?us-ascii?Q?fQczK0CZZtg1Q/YpJFggiH4LLsPVA503GyhCKSGBo/rUI4bg8YqIW2uz7/mW?=
 =?us-ascii?Q?qiebPCfPNEnS4CvTxlB6f47AlkJKJCBempLkg6uk264Y34YYqdZO0cL229sq?=
 =?us-ascii?Q?qV2kx7Dz0/61XTdb4nYgolhxtfWkQ03HnA73U6gZeg9zxObwb4Hda/1DZCuy?=
 =?us-ascii?Q?+v8tAR4VSHgpKBM8inEbcyP/rlP/SrZHJ/kYTKEpgCnjbaSdnxph15faju3J?=
 =?us-ascii?Q?PAS3xF5WP6PpziJHxeZUr4hQ18O3iPh26Qt6H9mITlU5ESOamVAamf+kDlB4?=
 =?us-ascii?Q?UO2xHVmbbOB/Bsm3h+/O3BI/K1l5mdTTdrVVni/HlR4rRO/7onGhwgkEJLzh?=
 =?us-ascii?Q?6oAf69Yhx9i655FJAFSUnv/oYY2+gOWP+aQ0mkQ5QE0V01uGtZruq5RNuFZU?=
 =?us-ascii?Q?jbqv0fwltpWdgxiu6IDF7e6eKxxNQtqLMQmYohnSFvazZ/kfDpAjCYEta2qP?=
 =?us-ascii?Q?RpiE1cghStjKKJgVJxkWaOL+iKATJ6kwr9cdIiELxgBB7ngWMr83IiyubQ3z?=
 =?us-ascii?Q?j3ARxolq0Rv44Xd0v14+q15m/48F/m0lK7/+O9xYqNEF+j2FkmDwfgm75otm?=
 =?us-ascii?Q?X6dUKJLGsYpHPvCqMdUJnpfpZEcgWWgUQnKO4Cj3sf++5C/d2yWmKyxLg+EE?=
 =?us-ascii?Q?z1LV2TrqSg5HoRynoWgBqHWI4EgyFG01x/TkZQSzA1hpkyZ6MyegGHrMowRG?=
 =?us-ascii?Q?aiNnWxX+2uq2tXOO6O0elP1VLmlZPZvaYgr0ucu2JlIl5U0t+plOt9X625Bg?=
 =?us-ascii?Q?WfV/sKwp0VDJ+sPNdmdwcNnTf3H/G60kCvi51Dx3goR97Q=3D=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR08MB6263.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6551
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:20b:290::9];domain=AS8PR08MB6263.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB5PEPF00014B8A.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	a9bb92a3-99fe-420f-05ac-08dcc7869172
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VMNxux/Z1KJOQovM2Chv6hEOh4beeqSoXIk9bXdbLkEDtHXg9NHMgfTnmyre?=
 =?us-ascii?Q?As/AL0VFWEm57x3LUuqjg1yU1uv8TTANYW9cZV04u7OKVbI81gtnPYw0MfLm?=
 =?us-ascii?Q?jTydqlTKCoxTq5PuPTWHIgMO6i/65cGkeeByh86ip4dyRNEE76Y5Iz7kzFUd?=
 =?us-ascii?Q?Ln4XjFn8gW54g4POMDbBVfXvJZMlq5v8Q5dwy5HtDJSl7ybMNS0ai/WtDNEW?=
 =?us-ascii?Q?B34pvmvM/sdE5uzBuHTTU+P8RYFK4g0VlEFcw6pJIlFec1VVWqW1QgamGLQr?=
 =?us-ascii?Q?SPaGaeTIat3RbuHQH+JF6mA0c/g3pIabX6Rx8yzVc/f8LLhrTJctzy24W2kr?=
 =?us-ascii?Q?7O++zdR+5XE9PMRy6Q2dUwb1gslRN4Pn4BS4cuLO1sNBvC3erUK2adVK/pF7?=
 =?us-ascii?Q?7qhVmrqES1t8cXzEbJKyOm7v0HElRfcUpyrRe9y6oeaHtMZC58du55e1ZYZj?=
 =?us-ascii?Q?K3AeCnHymTY+xR4uTiivZVelOolbOkHj/KZypeUSx9H7upj0FHC7tIi9Cxuw?=
 =?us-ascii?Q?TJURSvoROYFGaTtJfDnNgHogpItIxGiWjl2a0zIJHf2L26q47fyYKUfpBksv?=
 =?us-ascii?Q?H6MzO6xjf0s0VEolQr0CO3HiZOYQoCDfizt7ArZ/OFSDB8JsgpxRv2L+hEgJ?=
 =?us-ascii?Q?jLXCUnbG9qpg+TbdcXuwcbk/YMYJuAageNV9pbE5KMNRZ2V7F2AResup78ZG?=
 =?us-ascii?Q?yCcr+sGjRCdc4SLQzLFsR6dVfCjQE6tot+0ZH3l1TKWlHsQMm3YL95VorwWm?=
 =?us-ascii?Q?EVBD/hLrQIZd61Oi+/0Lwd7ImU+uVL0SN/Qoy8W68SA4UQIukVSitbeIlT1B?=
 =?us-ascii?Q?Y3cUMEc9e9olshZ0a4IRqcfVRlnwYo5L9alLi2bXN6ZYaTMm+7uG7efwXR/a?=
 =?us-ascii?Q?d6LWGJ6c6cClEzXsXEWlchuOwTilKMnBGA9DKrlyevOsEOIwWCQJRT7odPBa?=
 =?us-ascii?Q?uaJtVRNNp8deJCgCLUUYQGk4RF9+uEnrheAxjzb298TQKVGn7g6wIlxHulhT?=
 =?us-ascii?Q?wP3roYrAUUSp7tWjukcaRNLkJnRK6qK68fl/i3sPW3ze0I5avSr87DHttKTj?=
 =?us-ascii?Q?jRvcePc7MvWqBn1RBmL/eWQN2wkAKil/J8MzbhdbgKrZCZVZuihmAFlyduP/?=
 =?us-ascii?Q?kvuUiNWN1DjNeFNjClQcbLgNsXaEPVOMlJtWTesHFMrg15HV/oa1TUG2w9Vc?=
 =?us-ascii?Q?0tALvYrnyB6CaYTfH46+XLfaB+6FLQ41O7gg/X9o+wgKljRjynUp3bD8tk70?=
 =?us-ascii?Q?U97OJRiWzn/+0CANfnZwTHaDQv/P/ILdRB4m0qcOeWxaCO/voz7uurI/IUTz?=
 =?us-ascii?Q?2h14of7xM4r0UvRlZlOMtVR8pR1yqnRLPHzxZSOkehaBwgI+TJdnb/Mugctj?=
 =?us-ascii?Q?oXbF6VNsZBcrTQS93hDM7RFfbWO9As4ScDrwcAiGgL6KykmQLN67zh/9jT85?=
 =?us-ascii?Q?PwAwo/rmFcdiS+uFmJizVy4tyRuISTf9?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230040)(35042699022)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 17:26:50.8710
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8892a49-6e95-47ee-d67d-08dcc7869a5b
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B8A.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB6578

From: Ketil Johnsen <ketil.johnsen@arm.com>

In the kernel submission flow, GROUP_SUBMIT will ensure that the group
gets assigned to a CSG. Conversely for the user submission flow, work
gets added to the ring buffer without kernel supervision, so there needs
to be a mechanism to trigger rescheduling. Use a new GROUP_KICK ioctl,
to keep it distinct from the existing submit flow.

Signed-off-by: Ketil Johnsen <ketil.johnsen@arm.com>
Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>
---
 drivers/gpu/drm/panthor/panthor_drv.c   | 12 +++++++++++
 drivers/gpu/drm/panthor/panthor_sched.c | 27 +++++++++++++++++++++++++
 drivers/gpu/drm/panthor/panthor_sched.h |  1 +
 3 files changed, 40 insertions(+)

diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/panthor/panthor_drv.c
index e391ab6aaab2..ce2fdcd3fb42 100644
--- a/drivers/gpu/drm/panthor/panthor_drv.c
+++ b/drivers/gpu/drm/panthor/panthor_drv.c
@@ -1305,6 +1305,17 @@ static int panthor_ioctl_vm_get_state(struct drm_device *ddev, void *data,
 	return 0;
 }
 
+static int panthor_ioctl_group_kick(struct drm_device *ddev, void *data,
+				    struct drm_file *file)
+{
+	struct drm_panthor_group_kick *args = data;
+	struct panthor_file *pfile = file->driver_priv;
+
+	panthor_sched_kick(pfile, args->handle, args->queue_mask);
+
+	return 0;
+}
+
 static int
 panthor_open(struct drm_device *ddev, struct drm_file *file)
 {
@@ -1375,6 +1386,7 @@ static const struct drm_ioctl_desc panthor_drm_driver_ioctls[] = {
 	PANTHOR_IOCTL(TILER_HEAP_CREATE, tiler_heap_create, DRM_RENDER_ALLOW),
 	PANTHOR_IOCTL(TILER_HEAP_DESTROY, tiler_heap_destroy, DRM_RENDER_ALLOW),
 	PANTHOR_IOCTL(GROUP_SUBMIT, group_submit, DRM_RENDER_ALLOW),
+	PANTHOR_IOCTL(GROUP_KICK, group_kick, DRM_RENDER_ALLOW),
 };
 
 static int panthor_mmap(struct file *filp, struct vm_area_struct *vma)
diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
index 471bb8f2b44c..3b56526a4b97 100644
--- a/drivers/gpu/drm/panthor/panthor_sched.c
+++ b/drivers/gpu/drm/panthor/panthor_sched.c
@@ -2845,6 +2845,33 @@ void panthor_sched_post_reset(struct panthor_device *ptdev, bool reset_failed)
 	}
 }
 
+void panthor_sched_kick(struct panthor_file *pfile, u32 group_handle, u32 queue_mask)
+{
+	struct panthor_group_pool *gpool = pfile->groups;
+	struct panthor_scheduler *sched = pfile->ptdev->scheduler;
+	struct panthor_group *group;
+
+	group = group_get(xa_load(&gpool->xa, group_handle));
+	if (!group)
+		return;
+
+	if (!group->queue_count)
+		goto err_put_group;
+
+	mutex_lock(&sched->lock);
+
+	if (group->csg_id < 0)
+		group_schedule_locked(group, queue_mask);
+	else
+		/* All queues share same doorbell page (for now), so we just need to ding one */
+		gpu_write(pfile->ptdev, CSF_DOORBELL(group->queues[0]->doorbell_id), 1);
+
+	mutex_unlock(&sched->lock);
+
+err_put_group:
+	group_put(group);
+}
+
 static void group_sync_upd_work(struct work_struct *work)
 {
 	struct panthor_group *group =
diff --git a/drivers/gpu/drm/panthor/panthor_sched.h b/drivers/gpu/drm/panthor/panthor_sched.h
index 0b3a2ee2a0ad..18fb7ad0952e 100644
--- a/drivers/gpu/drm/panthor/panthor_sched.h
+++ b/drivers/gpu/drm/panthor/panthor_sched.h
@@ -48,5 +48,6 @@ void panthor_sched_report_mmu_fault(struct panthor_device *ptdev);
 void panthor_sched_report_fw_events(struct panthor_device *ptdev, u32 events);
 
 u8 panthor_sched_doorbell_id(struct panthor_file *pfile, u32 group_handle);
+void panthor_sched_kick(struct panthor_file *pfile, u32 group_handle, u32 queue_mask);
 
 #endif
-- 
2.45.0



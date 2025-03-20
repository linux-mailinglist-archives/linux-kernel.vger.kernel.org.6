Return-Path: <linux-kernel+bounces-569568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B39A2A6A4C5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 12:18:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A9351889218
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 11:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC3401A072A;
	Thu, 20 Mar 2025 11:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="VFGrEGyu";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="VFGrEGyu"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2081.outbound.protection.outlook.com [40.107.20.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412BE21CA10
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 11:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.81
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742469499; cv=fail; b=ZcqBlQ3T/vgchsyKshLEOvzxgsuxAOC9YJvch/giN2UCPrEeuRHtOZyj45QXgiwHAD1f4AK0lIFuBoQeBfQv4SUh1YDNiz2VrJAzINwS1mfL+76KoLs4ReLp/aPnqKC1USl3bkHsoDDSmrkV4oZXy1njVrp6IzhfHlgFW26N5UQ=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742469499; c=relaxed/simple;
	bh=ui40z3uVM5uW7B7AUXSm/SnSgvMpQ5wG8cs4gMpt74s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=D26fWLXYH1mfdCyi9hD9obEUwNRZOk4ilXujOok5VJNj3l2ODmupZHbmC9o1cu+yr5a7kAlWJXURFzflPdfVHiakpul2ruSpmquAGDRs0O7b4h6TdHkCTmP2MqYJys6SJVGwQ1Z6ZYoFke2Ukqo781ba64l3t1tWUrR6K+4/fTM=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=VFGrEGyu; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=VFGrEGyu; arc=fail smtp.client-ip=40.107.20.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=baX6sxMdCt4zqYOAZh6g2aOF4ZiFCUNcxcb6Ant6GQoaA5o2VJnriJzR/btCiHy7nLTW31SHYQfhPsTshiWl1rTr9Dn7mx+NwwWGGS7FLszbqTd5o1Z19NI7mYt58ihEqapOaiykVLQovBoKch7VIPPEwptbBsoJyF3XokrMZfjKZVVN6PhI50yTxEmguCpGNCKwmf5qGvWTXuFDzIAJG+IQaGh6C3lzICCHhkmKAgI+nTxgzNdWGXTu65JB6FOV81of25MwQ8JWdsndFw3cJhgN3vCBtyIoMxkCGBtp/qIJppW7MZLRq58fWgnUXDsrX1huC1MwOty/WE2k/HjKLg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W+TFo7nvFg44nY03QWZMc5ZWqasdfjEG3iZmQUgJWyU=;
 b=nNhm63qXXH/9nuCFOZC9Fz1/BMXTIbpeUctjuOBcVinJSzo1AtvW27VCSjH71RQqb2TeeZLhmhx1DxT+wWqnUhOZW+Yng3aVTMwr//zRVBINQxq6yYedPMvopjcRay9SL2hw5mTpdPCYthF7TcI8sVRk8785R+oZfXKWXwv7IkzuKO8falgAxFo8P5/tjW/RIraKmo9g4v9eetVBediWeXpvq7WN/sYfA6nj8ldX4DmsEqVuVvxUcvCYM4Hu4YW2I/hThkLVaPIrC3fzzqjacwKScVBQzZw3E6M8G8cyMTqWGZCLRhIolT2TeGLoPexPEkCpXU7fyDRRZmSMl59KJw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W+TFo7nvFg44nY03QWZMc5ZWqasdfjEG3iZmQUgJWyU=;
 b=VFGrEGyuaFxPebGbWcmbco2wmC8Ti7xsNle4mZXglbZ3Nt8XTtN1jLfuEaQjiqHFIuHgXjSeXS0X6o4jTPLKg8GNq9zdkZG5DKsFrUj9K9TDiIZTpa78OKrhhsim0X/S2Pg5s620PqkiGRJTMFa1VqdkfRhBSQUstEvvEHrYs+c=
Received: from DU6P191CA0049.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:53e::8) by
 FRZPR08MB10950.eurprd08.prod.outlook.com (2603:10a6:d10:135::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Thu, 20 Mar
 2025 11:18:08 +0000
Received: from DB5PEPF00014B93.eurprd02.prod.outlook.com
 (2603:10a6:10:53e:cafe::ad) by DU6P191CA0049.outlook.office365.com
 (2603:10a6:10:53e::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.33 via Frontend Transport; Thu,
 20 Mar 2025 11:18:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5PEPF00014B93.mail.protection.outlook.com (10.167.8.231) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.20
 via Frontend Transport; Thu, 20 Mar 2025 11:18:07 +0000
Received: ("Tessian outbound ec1a125a00e6:v597"); Thu, 20 Mar 2025 11:18:07 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: d939b7781bfcf113
X-TessianGatewayMetadata: dNIp/+bC4J0yYanAvG9J0MPYT6WssB9VeLVyUbz3CSd7HTLydEie1wXGAvYMlDShdJ1pnH5sfof/UAREvqR+9f2TFyXamNPqApwHjAU0LLidAW8xAQLOdLoqk9oIOQc+UjB0HzPBn5pfuoS0/jQCIU4Mcl00jc1tSLkkp9XaEmc=
X-CR-MTA-TID: 64aa7808
Received: from Lb4d8711e3bea.1
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id A295BBC8-F3DE-4584-A8F7-05326D0DE16C.1;
	Thu, 20 Mar 2025 11:17:59 +0000
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id Lb4d8711e3bea.1
    (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
    Thu, 20 Mar 2025 11:17:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d2LUU3mX9oSHqju+AXf8vUIyFYEZqrjYA5o7tW9ak/dxIj1Yzyr+au36qWxnn7vnZJqSFGtkQDOCaHhA1/9gGT1HuTfRz3pzzhXzIJfnvHC0ewo691O7JkFSsoDrHenWMn4ofAB6DKouKlzRSliiRnwr+hXNKuBdmyw5NObiSF87Fd52iEjedw88Sr7mE09L27IRwYsbzXSVh8JQfDJulySr+zP31wP6kQmCNwfwfjLvDTN0Fs+kASVxi0du0UfwVS/MARF40WrXUUBcPHbejG2GjGsYdmA2+b0q72YgIWwGrXAkVEK1BQG4NlacK9OGLRrCnYXIYeyUeRJzM3yYPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W+TFo7nvFg44nY03QWZMc5ZWqasdfjEG3iZmQUgJWyU=;
 b=eUlc3sMvisdTkTGGZtoKy2AYz6q0iE7yhUVkcnDoZ+e5eNhKh+/HxG/kNCCxb6ZoBXQgeZAUJoD9U44LKvW7R5MOAClInbSQ7KU4RlmIVPe26pibTcA+pEqUStj8sI1wmp6IZAZpNoiihSiD53Y+DTHVgiyNJWBp95VI0uiCgKMYsGVF1FroOF3tBD3J8+l1kYNQnT5IBi2F98SaKg5F9fz2Jr0JbSY4XmX0AmV2nARnFCIVua6hcc9bL0o2sdiw8PEDdXkBrncx9dZqgNSQr0oSw2RgfEBW0os8Yt3xX4MP3DaV+zQao+vSqy6EIACzYVtafsGhhxyVLwNqUILLpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W+TFo7nvFg44nY03QWZMc5ZWqasdfjEG3iZmQUgJWyU=;
 b=VFGrEGyuaFxPebGbWcmbco2wmC8Ti7xsNle4mZXglbZ3Nt8XTtN1jLfuEaQjiqHFIuHgXjSeXS0X6o4jTPLKg8GNq9zdkZG5DKsFrUj9K9TDiIZTpa78OKrhhsim0X/S2Pg5s620PqkiGRJTMFa1VqdkfRhBSQUstEvvEHrYs+c=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18) by DB9PR08MB6715.eurprd08.prod.outlook.com
 (2603:10a6:10:26f::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Thu, 20 Mar
 2025 11:17:57 +0000
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::d594:64a:dfc:db74]) by VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::d594:64a:dfc:db74%5]) with mapi id 15.20.8534.034; Thu, 20 Mar 2025
 11:17:57 +0000
From: Karunika Choo <karunika.choo@arm.com>
To: dri-devel@lists.freedesktop.org
Cc: nd@arm.com,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Steven Price <steven.price@arm.com>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/9] drm/panthor: Add GPU specific initialization framework
Date: Thu, 20 Mar 2025 11:17:35 +0000
Message-ID: <20250320111741.1937892-4-karunika.choo@arm.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250320111741.1937892-1-karunika.choo@arm.com>
References: <20250320111741.1937892-1-karunika.choo@arm.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0487.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13a::12) To VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI0PR08MB11200:EE_|DB9PR08MB6715:EE_|DB5PEPF00014B93:EE_|FRZPR08MB10950:EE_
X-MS-Office365-Filtering-Correlation-Id: 0990b952-1279-485d-867a-08dd67a0e43d
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?/aeVOFfCqe0QfojEJzsQJgGtLsloqygehQBmZHMvSSMammVX8lLcJRUiDokO?=
 =?us-ascii?Q?GRB2xBD1Xoi9IEC95vmh2qURkmcEOVPWxRBB2kC0MM059tVBjykkpGujoi8o?=
 =?us-ascii?Q?emJl4OW3+IKPy/bujErxTWiM7vKhL+j1gw0kXjf6MCGPdgPvU+ls33jh8XBM?=
 =?us-ascii?Q?lThYPNgZ8XgC+hU1EA2yG2RVkJyv8QBF4wB4P11qulk+wx3uQlMf1WlSpBt9?=
 =?us-ascii?Q?Xpwy09NozOItGrFMPvPgBu6XucTvF2RiUpoeTZHHe5PHeMF6a6Xn2jo4Emcf?=
 =?us-ascii?Q?Hw8XQbHKtQhW1VsES+BnyhD1cB92K/PBBD62GEPhQ6KxhXoV3U+pQgsT4fES?=
 =?us-ascii?Q?cTkQS2SPFjXaVLr7PfHnUNoIDFfMKlnfyxXU6R8bD9dSNV4DycjZVGLcBqBS?=
 =?us-ascii?Q?tEkX6T99lPZY7bxaaH6SmDULOo57kNvLowmpDVh1KjyKtVIw9efIKfdsKVc8?=
 =?us-ascii?Q?D13a6cOgbFnA+YuYpQ54b7hLvqHUP6tT1oS1B1fQauhYxg5CkN+US1VaPpss?=
 =?us-ascii?Q?qrrYL2Prcup+fCxTsoX0HezIg+N54BrRRUyU0+uZYJFByVrUFUk4UG3JznJS?=
 =?us-ascii?Q?M2xdGxuJ/Nw15w4eExl6kZXEzvCEmIql4vJJT4rcUgXbAP1Ngq8BPpFzxTfV?=
 =?us-ascii?Q?aunhqoZK4iP0ftSq7VLoLQ9j9WYMKBWsZg7d7nEaEz5isZF6KbX7Zxd6OkZy?=
 =?us-ascii?Q?q7C/Y/0XcRrZvROrYShgqSFDNIFfunX1OqThBoDcQz9835UwI/S7azBpSgR9?=
 =?us-ascii?Q?ufbYFMKcBtkA6NTCdHbPxEKs8DVdIRKcQR/iqV0dehvKUG62HCaLE3iThn0d?=
 =?us-ascii?Q?YzaGDL/l10e9b7Jt6ULR+W8QI7WNPLbWLClJj8m7/eg4lMKLxQEdzDCpivgD?=
 =?us-ascii?Q?2s2Kxnjeb0BP0MOQVFlKWN5qBgXhjITTWddcmoVR89Kkn6X6N0Dow0XvU2XF?=
 =?us-ascii?Q?6u/FbjtCeyzsRhP+FAEJHuKsbqukZXFClbGSVlhzR9K6m724XAyQd6BlDrDq?=
 =?us-ascii?Q?lW/JMijS3SVX2JbX3yXhpC20x1ViZwQG6OpPWTfGPnBvbY21R6228FZjeM33?=
 =?us-ascii?Q?VsoudyZB3QV+bqs3jGjabadwxrJCGaf/utkTFPEl0WpH4kKfQSUcthB5K37Y?=
 =?us-ascii?Q?bsmihdIJyzwUGmx+FtmVt4JcNk8vQc9EN33FVdHnly32YZnnQ2NmFx3I3Izw?=
 =?us-ascii?Q?jCJQ4g5uByrawg/wHRZMyjW/PlQkTVhLK2KlsV0hti+KNN9ZlHbuOuT/XzJI?=
 =?us-ascii?Q?sjurfWgJhSd1fvSDisxBa1HvQ/XjuCzCQgKRMdknVkytoGhM3+YOMLVRO9qt?=
 =?us-ascii?Q?XBzPES9AO7ZDGPZzG+QZjd0hlrAN8NNskkruvLMllrcwQ99oOKcL22ibWg7o?=
 =?us-ascii?Q?gcuDnhxYWr944WVzmfuxRtJNTzQe?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB11200.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB6715
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:800:257::18];domain=VI0PR08MB11200.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB5PEPF00014B93.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	b1a0d67f-f23f-4cbb-eb11-08dd67a0dd7a
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|14060799003|35042699022;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+cUdtx1TkfJ50aUJ0kYyThxmw+hUReyEgP86sTdLlb2+BlHpplssYOWS01Dp?=
 =?us-ascii?Q?JOc+sHDqtdRauvuYdwRDcok+lCBp60IRsbxJcF1BmUjaWLJxhlspszGT86p2?=
 =?us-ascii?Q?EaQmM2zqD6h3qO4D26yJ+InW//SDzDbjQfk0/q822mPCP0YLVcK12K88w67i?=
 =?us-ascii?Q?3fnW2/w0+YR6zuQVPRO0WyoSUY/q011C6ic/OZBNALWmIgAX9itTLnXPzsEe?=
 =?us-ascii?Q?y0qMClJ0R3cU+Y88MWIZvwNuRF+NndyuxRUDj/PvUdZgVVJ+2HYk+3BbFabt?=
 =?us-ascii?Q?f8DWg2KnYCviRxDgg73EO+9CWagzyrElOTLYNncmn0k04Hz2ifRlehqbTL2V?=
 =?us-ascii?Q?k+V2alFDbLfgUtf4Dz/oJi5Djw5hiorUQxvOXehteo+pHKNU8lVDIj6bG9qr?=
 =?us-ascii?Q?aoDNZylZoFqEN482/EjmmNxarN5gTwp8ygItbRzuV/IGdstDAQaJTMDlDheY?=
 =?us-ascii?Q?XskmRv3loCWTaVvESj8QVIlErQCse8l5BhlVS8RU500hyD3ec4e7npI/EIPO?=
 =?us-ascii?Q?WYd9j5scDdnSSanjN+kXM7BEwW7LwUCqBbGKVuANM9Jkq9mUz/613y5JWKY1?=
 =?us-ascii?Q?Qk8dzOeRvE6bZClVlANw+N11MG519DjV5jQCI5rS7WPm4zmPhprp3Cxzt6ym?=
 =?us-ascii?Q?OX530fTMkzqU8QR2hDZszEhVMNeIsmh2ODPHCaXHAZvm5VNcN0pZhL8cL0Kr?=
 =?us-ascii?Q?wo8GB9+Cbq6AITJCvEKEMK5v4A9aBkD+15BHgrCjTUPw++YWc7VXqLX5Jo0i?=
 =?us-ascii?Q?aYEzaFw4mjdllNq8+D/s9D8pw1+5JYq+rhVle3TsKJOQMgZ47HSYCIP7utuh?=
 =?us-ascii?Q?VAiX3iczVjTyTZW6EexGbX+GuC16SOSA5sT8FWnXJJ1vXGlimf1+dI3iiyE1?=
 =?us-ascii?Q?hK81kDB1WErS4U0T4N5bO/1Q7QgCDQ8LZ3W6g7Fo1JE/qPb7H/NQzzU1sz6s?=
 =?us-ascii?Q?5zwePOf8DwRYTU3Ftq0080ijc9BaNaizNx7GSXU5/tnzgi1Y6DptM++3R7aw?=
 =?us-ascii?Q?pUz8HOb6ANLLkuA9gQsTC5t1HfitdBhrJVzAt40rwZAVxlvgpZBx9PhxQApJ?=
 =?us-ascii?Q?gpss8PSe3mH8OzDT2WgKDczG9CQZvCeX8weOIk1x9KrLrFDaFmEpm2kKrIEY?=
 =?us-ascii?Q?oq4nW2sLCGc9+ENOiHicXM4nAwnraSA18+TifGDBSJL75gQG9vpKzMtMwmhE?=
 =?us-ascii?Q?PpiltJZ5BoLK68d0mMMc6m132vZGn7G9sfqfYL45I7gK3V7BXsSxfYSinxBz?=
 =?us-ascii?Q?nlReMcO3dSbca3yKYfWHmq+vJNGXn9SvQo7eW+SVHsKCvEXTBWQepQUV2LTB?=
 =?us-ascii?Q?slR/4if1LUL01um3iZmM4eNRW0eeo1mmyJKsqLamZ4SrCkYbhb+DAC7vihJ/?=
 =?us-ascii?Q?ihI4OgvARv0CP5d7x2oOu9JEBBJrk6ZPzq4SHdK17a/ry8IkRA3AuWxzEJXX?=
 =?us-ascii?Q?Ou5+zBBHoBZqUG2eISGCB+bz2gfprilNI/Fb5m802ApcReT8fyD+tfT9mirP?=
 =?us-ascii?Q?5GiqnKW45CamAqE=3D?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:64aa7808-outbound-1.mta.getcheckrecipient.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(14060799003)(35042699022);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 11:18:07.7519
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0990b952-1279-485d-867a-08dd67a0e43d
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B93.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRZPR08MB10950

This patch aims to lay the foundation to provide support for multiple
Mali GPUs through a framework by which differences in registers,
functionality, and features can be managed.

It introduces the concept of the arch_id which is a 32-bit ID in the
format of ((arch_major << 16) | (arch_minor << 8) | arch_rev). The 8-bit
fields of the arch_id provides future proofing past the 4-bit fields of
the GPU_ID's arch_major, arch_minor, and arch_rev.

The arch_id is used to select the correct abstraction for the GPU, such
as function pointers for operations specific to the GPU, base addresses
describing changes in register offsets, and supported features.

Signed-off-by: Karunika Choo <karunika.choo@arm.com>
---
 drivers/gpu/drm/panthor/Makefile         |  1 +
 drivers/gpu/drm/panthor/panthor_device.c |  5 ++
 drivers/gpu/drm/panthor/panthor_device.h |  3 +
 drivers/gpu/drm/panthor/panthor_hw.c     | 70 ++++++++++++++++++++++++
 drivers/gpu/drm/panthor/panthor_hw.h     | 63 +++++++++++++++++++++
 drivers/gpu/drm/panthor/panthor_regs.h   |  2 +
 6 files changed, 144 insertions(+)
 create mode 100644 drivers/gpu/drm/panthor/panthor_hw.c
 create mode 100644 drivers/gpu/drm/panthor/panthor_hw.h

diff --git a/drivers/gpu/drm/panthor/Makefile b/drivers/gpu/drm/panthor/Makefile
index 15294719b09c..02db21748c12 100644
--- a/drivers/gpu/drm/panthor/Makefile
+++ b/drivers/gpu/drm/panthor/Makefile
@@ -8,6 +8,7 @@ panthor-y := \
 	panthor_gem.o \
 	panthor_gpu.o \
 	panthor_heap.o \
+	panthor_hw.o \
 	panthor_mmu.o \
 	panthor_sched.o
 
diff --git a/drivers/gpu/drm/panthor/panthor_device.c b/drivers/gpu/drm/panthor/panthor_device.c
index a9da1d1eeb70..a6fca6b3fabd 100644
--- a/drivers/gpu/drm/panthor/panthor_device.c
+++ b/drivers/gpu/drm/panthor/panthor_device.c
@@ -18,6 +18,7 @@
 #include "panthor_device.h"
 #include "panthor_fw.h"
 #include "panthor_gpu.h"
+#include "panthor_hw.h"
 #include "panthor_mmu.h"
 #include "panthor_regs.h"
 #include "panthor_sched.h"
@@ -243,6 +244,10 @@ int panthor_device_init(struct panthor_device *ptdev)
 			return ret;
 	}
 
+	ret = panthor_hw_init(ptdev);
+	if (ret)
+		goto err_rpm_put;
+
 	ret = panthor_gpu_init(ptdev);
 	if (ret)
 		goto err_rpm_put;
diff --git a/drivers/gpu/drm/panthor/panthor_device.h b/drivers/gpu/drm/panthor/panthor_device.h
index da6574021664..82741bf1a49b 100644
--- a/drivers/gpu/drm/panthor/panthor_device.h
+++ b/drivers/gpu/drm/panthor/panthor_device.h
@@ -120,6 +120,9 @@ struct panthor_device {
 	/** @csif_info: Command stream interface information. */
 	struct drm_panthor_csif_info csif_info;
 
+	/** @hw: GPU specific data. */
+	struct panthor_hw *hw;
+
 	/** @gpu: GPU management data. */
 	struct panthor_gpu *gpu;
 
diff --git a/drivers/gpu/drm/panthor/panthor_hw.c b/drivers/gpu/drm/panthor/panthor_hw.c
new file mode 100644
index 000000000000..234bfd50cf0d
--- /dev/null
+++ b/drivers/gpu/drm/panthor/panthor_hw.c
@@ -0,0 +1,70 @@
+// SPDX-License-Identifier: GPL-2.0 or MIT
+/* Copyright 2025 ARM Limited. All rights reserved. */
+
+#include "panthor_device.h"
+#include "panthor_hw.h"
+#include "panthor_regs.h"
+
+static struct panthor_hw panthor_hw_devices[] = {
+	{
+		.arch_id = GPU_ARCH_ID_MAKE(10, 0, 0),
+		.arch_mask = GPU_ARCH_ID_MAKE(0xFF, 0, 0),
+	},
+};
+
+static int init_gpu_id(struct panthor_device *ptdev)
+{
+	ptdev->gpu_info.gpu_id = gpu_read(ptdev, GPU_ID);
+
+	if (!ptdev->gpu_info.gpu_id) {
+		drm_err(&ptdev->base, "Invalid GPU ID (0x0)");
+		return -ENXIO;
+	}
+
+	return 0;
+}
+
+int panthor_hw_init(struct panthor_device *ptdev)
+{
+	struct panthor_hw *hdev = NULL;
+	u32 arch_id = 0;
+	int i, ret;
+
+	ret = init_gpu_id(ptdev);
+	if (ret)
+		return ret;
+
+	arch_id = GPU_ARCH_ID_MAKE(GPU_ARCH_MAJOR(ptdev->gpu_info.gpu_id),
+				   GPU_ARCH_MINOR(ptdev->gpu_info.gpu_id),
+				   GPU_ARCH_REV(ptdev->gpu_info.gpu_id));
+	if (!arch_id) {
+		drm_err(&ptdev->base, "Invalid arch_id (0x0)");
+		return -ENXIO;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(panthor_hw_devices); i++) {
+		u32 mask = panthor_hw_devices[i].arch_mask;
+		u32 hw_arch_id = panthor_hw_devices[i].arch_id;
+
+		if ((arch_id & mask) == (hw_arch_id & mask)) {
+			hdev = &panthor_hw_devices[i];
+			break;
+		}
+	}
+
+	if (!hdev) {
+		drm_err(&ptdev->base, "Unsupported GPU (arch 0x%x)", arch_id);
+		return -ENODEV;
+	}
+
+	ptdev->hw = hdev;
+
+	return 0;
+}
+
+bool panthor_hw_supports(struct panthor_device *ptdev,
+			 enum panthor_hw_feature feature)
+{
+	return test_bit(feature, ptdev->hw->features);
+}
+
diff --git a/drivers/gpu/drm/panthor/panthor_hw.h b/drivers/gpu/drm/panthor/panthor_hw.h
new file mode 100644
index 000000000000..5eb0549ad333
--- /dev/null
+++ b/drivers/gpu/drm/panthor/panthor_hw.h
@@ -0,0 +1,63 @@
+/* SPDX-License-Identifier: GPL-2.0 or MIT */
+/* Copyright 2025 ARM Limited. All rights reserved. */
+
+#ifndef __PANTHOR_HW_H__
+#define __PANTHOR_HW_H__
+
+#include <linux/types.h>
+#include <linux/bitmap.h>
+
+struct panthor_device;
+
+/**
+ * enum panthor_hw_feature - Bit position of each HW feature
+ *
+ * Used to define GPU specific features based on the GPU architecture ID.
+ * New feature flags will be added with support for newer GPU architectures.
+ */
+enum panthor_hw_feature {
+	/** @PANTHOR_HW_FEATURES_END: Must be last. */
+	PANTHOR_HW_FEATURES_END
+};
+
+/**
+ * struct panthor_hw_regmap - Register offsets for specific register blocks
+ */
+struct panthor_hw_regmap {
+
+};
+
+/**
+ * struct panthor_hw_ops - HW operations that are specific to a GPU
+ */
+struct panthor_hw_ops {
+
+};
+
+/**
+ * struct panthor_hw - GPU specific register mapping and functions
+ */
+struct panthor_hw {
+	/** @arch_id: Architecture id to match against */
+	u32 arch_id;
+
+	/** @arch_mask: Mask for architecture id comparison */
+	u32 arch_mask;
+
+	/** @features: Bitmap containing panthor_hw_feature */
+	DECLARE_BITMAP(features, PANTHOR_HW_FEATURES_END);
+
+	/** @map: Panthor regmap */
+	struct panthor_hw_regmap map;
+
+	/** @ops: Panthor HW specific operations */
+	struct panthor_hw_ops ops;
+};
+
+int panthor_hw_init(struct panthor_device *ptdev);
+
+bool panthor_hw_supports(struct panthor_device *ptdev,
+			 enum panthor_hw_feature feature);
+
+#endif /* __PANTHOR_HW_H__ */
+
diff --git a/drivers/gpu/drm/panthor/panthor_regs.h b/drivers/gpu/drm/panthor/panthor_regs.h
index 7ec4a1d04e20..ba452c1dd644 100644
--- a/drivers/gpu/drm/panthor/panthor_regs.h
+++ b/drivers/gpu/drm/panthor/panthor_regs.h
@@ -19,6 +19,8 @@
 #define   GPU_VER_MINOR(x)				(((x) & GENMASK(11, 4)) >> 4)
 #define   GPU_VER_STATUS(x)				((x) & GENMASK(3, 0))
 
+#define GPU_ARCH_ID_MAKE(major, minor, rev)		(((major) << 16) | ((minor) << 8) | (rev))
+
 #define GPU_L2_FEATURES					0x4
 #define  GPU_L2_FEATURES_LINE_SIZE(x)			(1 << ((x) & GENMASK(7, 0)))
 
-- 
2.47.1



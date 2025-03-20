Return-Path: <linux-kernel+bounces-569569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74650A6A4C6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 12:19:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37E98980CB1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 11:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9468D2206BB;
	Thu, 20 Mar 2025 11:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Q2ofoScg";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Q2ofoScg"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2049.outbound.protection.outlook.com [40.107.21.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A0221D3F8
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 11:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.49
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742469500; cv=fail; b=P8X83IW5iKJ+3tRJTgCmh0YfXZ0bCpcUTPebRZEcQCIsX6ivZTjMoEwm5KL+Y4FDNblc15bhxA6OeWiskodfN5Yc23ifS01//mAnstACButUoBhGP9pspDo+3YtHubQpgqqi9R5b91vZCY0pZVr8SHIjHHMvDqdC0wB8v+q0Dfk=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742469500; c=relaxed/simple;
	bh=G8HJzMEvYqoxz2mfRaR1D36V+CaPwvufbJVBRVLeGhw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fJqHHC0H2Ot9tLIngsTSDP0NNvrEUd5Z30W9Fcs0uZZIk7AU3ksOZBFPyjbUDf584WR1Cw2BlGYFilWvUuvqw8oTEx2+Tng0K0tQgLyJMs6Fui2lSQ66Yao0iNeedvW8TEkmxxrgJlqYniJ/6/bnf8Z3Ke0z3xE1QcCXrEy9Trk=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Q2ofoScg; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Q2ofoScg; arc=fail smtp.client-ip=40.107.21.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=uIaKjojrcAaUhSAI/YL/RA6royWQ/DgmIGsb3CWlDbi4zVmpnppDdeX/7L/G79NzzR/0L4r05BuIUuxZiqruiENL1do1m6/J3e7TvSv+ckmJtktVg0TKJhKhsCltuNZVASa/zHb6dqWSMD22nawjmWor0EVn0w1vkWEyTtZitmJYQNmqLor3ayW2+vyxhK4gmfGvL5gv/dIc/257f0+leFWfEriGIIq9rctqm4h1thI3Fj0JhuvqezBsMsdUdbQi7Mrj5YHa8/kDW0Git3jSZeCKrmzwuhYMMBbm8umwUm6fT5PqHxsxDL4JnuSYpx7LlQviGMmWAzgFQjUs8JJVgQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R5d4xgZ9tgZU2DQVZMu/08PNjeC6+iQchEjmRLDLoQo=;
 b=Bso15be2OiASqsVKON0bhDJHJOSpjFcaMaRHfvFx27Ek49A4YxTfF3ygrbtjlfbqg8FOQNpVpAKVoYOurQ0gpd11R+g8KR48wdalWzGRY7+dbvZ53cpLVu6Kr5hSd00J06/wk4R2Xv45JpLb3vmeGn3SP2h8Zdvp9Mg6ATp0SG8kjms9F1mc0v8NXexxd+eA7ozDUogqwvpL1AHx1wmuh0NQ6cRUCImL6qOHLcfw8HwvOI5GxqDcdcwyK6x67VBGnO62Z7dUdK//Kp+o1RfFQ/ZG9pQzVQEva7ZfhrYXLe5ujOqVaWFOHhhqreiNO6m+N1AWfMTnAxXIyCBFDOzcTg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R5d4xgZ9tgZU2DQVZMu/08PNjeC6+iQchEjmRLDLoQo=;
 b=Q2ofoScg6QXTadgz7c+PdigV9tqSpayj93uaPmtXddioLVHs4saX7Q/7IjdAobGDRi/JbTFhVnpUlERVRbCZZ2FOhmqNMpDmtfgLYcf6T6Sq4L1RuT7WuBIXt6RpMwBWoxCI1DSgCZsjcgWObbwKjVUe/o9FKV8xzCwbT/Bn8jk=
Received: from DU7P194CA0010.EURP194.PROD.OUTLOOK.COM (2603:10a6:10:553::13)
 by AS1PR08MB7428.eurprd08.prod.outlook.com (2603:10a6:20b:4df::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Thu, 20 Mar
 2025 11:18:13 +0000
Received: from DU6PEPF0000B622.eurprd02.prod.outlook.com
 (2603:10a6:10:553:cafe::4c) by DU7P194CA0010.outlook.office365.com
 (2603:10a6:10:553::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.33 via Frontend Transport; Thu,
 20 Mar 2025 11:18:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DU6PEPF0000B622.mail.protection.outlook.com (10.167.8.139) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.20
 via Frontend Transport; Thu, 20 Mar 2025 11:18:13 +0000
Received: ("Tessian outbound c7a7213353f4:v597"); Thu, 20 Mar 2025 11:18:13 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 6a5690335aeb3d42
X-TessianGatewayMetadata: FftYgYQ610SD7twKB3aH/5Ze2B9VPifnV3aLLfyH5anAAJLo+BkM/RY0tSZxBjSjQRuDN+h5MIKUMahayRTG+R6RZmNSxUCtFSDiR2Sc5KCVl2+TFTNhpIefA2yjwNYcx8iyEXJuM/2lJnz4OLl3OOofJmU1I0RwtfenwpLCo2k=
X-CR-MTA-TID: 64aa7808
Received: from L60ef98af60d8.1
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 461810E7-A79D-4819-B7C3-9F90DFE28AB8.1;
	Thu, 20 Mar 2025 11:18:05 +0000
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id L60ef98af60d8.1
    (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
    Thu, 20 Mar 2025 11:18:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y8mifUGJW4f5YLke0P1TDRY46l8BrKeqb9GtY3V0utAz41QxXXaEfC9d/sTwWER1pkZWzKK+/XlSPMWH4yFYjbdW2dGGALSDKxQVN6A1BTCL0N/P7rRZ9R/zmcJOKG0dhy7yYjDsekArauy7So1sxb1LXA9BPKrG60aZqrBxi5rQxiv40CF7jWcVoKWmRydIlTNH3WTmSFsnU6WKVkl9Na9k/vAkHn+j29EjGykv9pxwMkynSTDL2AFPA2/wGKJBAe7yRHJZG27PjNprPz6WKHUrH9VV0tlbYRUkXiUisjNGmIR8oOLlkcapqFQJQZNMV9qTB1CPunRXfe5qJlQxFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R5d4xgZ9tgZU2DQVZMu/08PNjeC6+iQchEjmRLDLoQo=;
 b=JiZPumzeivsV8e8HiABs13R8NrzDcl0TIfxpipMP9QCQz0dixTTL0EvfLoQI5BJmkD1sY28E+MCbw09PhlZV8WBd22CutxOGO58518FyLc9HYikYAkeEpvjm3QTjTrQVzX+rUnBGqCHaZd0iQfGQHlrUtxIqGeotTNtSizgpdfPbMktllJQZT/KspJOHiTlXMdTGS0enBTY5d+IqDk2b8uNGBJND7fevT/3bCHZmhWYEhtWLLKm+mCdMi+yEMBZVKyQakRetxeOM4KgTcYGvLmtuVXQk/hF978kOxLmXW1pKFY/00GQqYwncEX5FqjPpYozyVVq2XMm6EOYLa68BYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R5d4xgZ9tgZU2DQVZMu/08PNjeC6+iQchEjmRLDLoQo=;
 b=Q2ofoScg6QXTadgz7c+PdigV9tqSpayj93uaPmtXddioLVHs4saX7Q/7IjdAobGDRi/JbTFhVnpUlERVRbCZZ2FOhmqNMpDmtfgLYcf6T6Sq4L1RuT7WuBIXt6RpMwBWoxCI1DSgCZsjcgWObbwKjVUe/o9FKV8xzCwbT/Bn8jk=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18) by AS8PR08MB9193.eurprd08.prod.outlook.com
 (2603:10a6:20b:57d::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Thu, 20 Mar
 2025 11:18:02 +0000
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::d594:64a:dfc:db74]) by VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::d594:64a:dfc:db74%5]) with mapi id 15.20.8534.034; Thu, 20 Mar 2025
 11:18:02 +0000
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
Subject: [PATCH v2 7/9] drm/panthor: Support GPU_CONTROL cache flush based on feature bit
Date: Thu, 20 Mar 2025 11:17:39 +0000
Message-ID: <20250320111741.1937892-8-karunika.choo@arm.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250320111741.1937892-1-karunika.choo@arm.com>
References: <20250320111741.1937892-1-karunika.choo@arm.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0475.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a2::31) To VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI0PR08MB11200:EE_|AS8PR08MB9193:EE_|DU6PEPF0000B622:EE_|AS1PR08MB7428:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f598815-ea9e-45c4-3e10-08dd67a0e78e
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?JoDXSJa7VtIx3lbYaDRX43hC7bQOQCgh1jVahmxUGXj62fhHCplS3YdhPphB?=
 =?us-ascii?Q?H9xKAycHxfw1JegNxg3a7x72BCTbqmhexAh8PbLODXecu0LAh1ZPvTnFQ49e?=
 =?us-ascii?Q?p6Tf+yeE0vkQmNLK2Ue0vqYAvTprn233omf7rwQBDXZjPd+wwsUhXi1IZVP7?=
 =?us-ascii?Q?BnBHY6t+lCLfH+fJUpCju93xwf9NS5+eunI9tbGVFC9BxwHMlFFgi6WAwlnB?=
 =?us-ascii?Q?YFo/6cK31PDskeYO2SP+ybOcyOzTK+SD1LlbzKV54LInEcpCBdqHm1YLIbk6?=
 =?us-ascii?Q?46RjQG2G60dhP7IVnF6lIeZV8lHedBzJEiLmcKzbalr6nAII/fsMNR3vG+Ql?=
 =?us-ascii?Q?IQKr5jto1fAz4RvJkD54gPEH2LS290T8OdM9B8HrxkjomS8Vsx1kc/OmbUc8?=
 =?us-ascii?Q?129wM+vNDeLkTvRF4WS5++9trdSkIRe82U2rwyreujslAhG0F3ulqbnEhXXY?=
 =?us-ascii?Q?gpzJydmXDEDaUAP0R0eKWcNo0vQPwafiCDmNWWYwG+BqM2dSZLihF2TAHKyR?=
 =?us-ascii?Q?57a79/M4gQvPQOR57qa5TI4Wttcm205mZCXLXiSJq2UM7YygrsdPS4eBHL6U?=
 =?us-ascii?Q?1ugUWqNgLx4xV1/ivhvm4V8+FiNmSDd4smBUPdz0vgrnLYwGzCYd97Ms0VS8?=
 =?us-ascii?Q?rZTfWO0zyzfJJqzq3m3jO6iISTMth2Q4QD3k9COU1N4kohsoDiPnaLPAsik8?=
 =?us-ascii?Q?RKVno1xuFQzqV8W42khW7C0GbTwC8uzpIYU9MwDAHzYPc2L8NVf13TwlN/z9?=
 =?us-ascii?Q?lNUmDIonHnHqOYNZHfQPQG81LMfx7qUTHEWUSQRXcIRYb725HtPqasQnnefn?=
 =?us-ascii?Q?UAQnoVmSQaeIFnRZIh9OxqM36KZz1GUfR4JlSZO8H5NDrjE0knGyrMX3MCTS?=
 =?us-ascii?Q?MilD6DcfiRuoUO0PzgwAzlUMv6OXJdJVxB9Xwf8YT6Z7Frkv9mj4xqIO09B0?=
 =?us-ascii?Q?WT8DAvs2Z4lO2IBdH1Zmir+UgyqG9AM2xS7SqNdHdIJBe0lGv2mIA52V1dI8?=
 =?us-ascii?Q?HeXXW+AivtS82/AXxk6+Rp7XuuCYnmUyS6ogdEOElyFwn+uin9p003Q+jeiT?=
 =?us-ascii?Q?ifxscW2fEbGSlbhyFGfm6EH2c+xeFU/WBgEBCokWFpu2imr4YflzyY29FSsm?=
 =?us-ascii?Q?l5yjpSr6nrYDD1W5DtT7JJidDWoi3QNi0QrXnNAs0zZJifJaasyZTNuaPrMD?=
 =?us-ascii?Q?YxENCVzv3cVjcICEjub6gU/G0Dtn5KImfsv62GFsW2UFkASTcAJYFlyX4Oz9?=
 =?us-ascii?Q?RBW5qQfMS0rkfT0lrIHw3Rics+sC1WYIA7ZCUOKzoDFZ8ltQBzmGYTDjuKez?=
 =?us-ascii?Q?j3urdvxXLiSPee8Pb2dGAqtY1xgDDV5XUQf8mFkm6ujL6gn+CMzuw5CG5afp?=
 =?us-ascii?Q?JS0fuPWVzB2JX8NqRFrZg/8LjZPE?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB11200.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB9193
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:800:257::18];domain=VI0PR08MB11200.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU6PEPF0000B622.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	20fd3207-f844-4527-a828-08dd67a0e0de
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|35042699022|14060799003|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?z60X52ZYg+kSmw5AenH2j9NagSsZPOQLif0UUuWGDTeIwWq93RbniJB1kzIW?=
 =?us-ascii?Q?7bE+VT4XbPLG2XV/v9hkXXtwk0yiQvE0xL95JtC9MwYp0ZCdKOoxY1tLuTlZ?=
 =?us-ascii?Q?zvY9U8QWFqULtMHWR0gIDv3aaRUscefUaJk9t3y5DiVNdM9Um0gVR8f38LRv?=
 =?us-ascii?Q?7Pmohxld5HO5cgze2EZGB+rzmTJBGqive/cTJHmfo94+bbZfab0Derfdaj6S?=
 =?us-ascii?Q?QXyKyKaNchjIVGOZQoMoQui/x27q2rBc0fLcxXJacHEVWZ0X2XKI0gFr+TGN?=
 =?us-ascii?Q?TDGWGH26kXJN5GykyhJ7OKW+Kppr9ctEbfxsElK3C6r91W9pKS1Qck/vAsEX?=
 =?us-ascii?Q?UsSMJY+QhUv6a3jpQgIlEVOYWPNXTtHVihuMiq2lMekptav2yla8x2+bbbJn?=
 =?us-ascii?Q?lWxu/vjmQ1YutpHRYnZH9WH+8DZ58LrsyfSscq9elzbDHTxrFChQIqSRGudn?=
 =?us-ascii?Q?bQPAa/ECls3LYx3e+vOETYcXZP3OkDflH4jd0u1zUFVC8pqLBnC41OLWFrg1?=
 =?us-ascii?Q?22Ra5/mAGN5RwIskTddYa+6/F0lJtmwu6Tp3VUtVEkOLwaW3H1+6n59uiOUr?=
 =?us-ascii?Q?cOQuxDA4yNEU7XfhINIH9c9jF7YzEF3vw7gRn9MxdVbaEutSEXaN+RDO/ni7?=
 =?us-ascii?Q?MozjmPs5jIRq+KCEpvCmDarTcgqiBvYWaTyVSqnPwUTkAUqQ0blSRgLgNKEs?=
 =?us-ascii?Q?hhTVE5UCe9TWThuwPvldZk/8wpidsFsu9xCBw8AoD39zVW9u0QfYnCvJbBh/?=
 =?us-ascii?Q?8R4bm53Whc/hdq4cHuZdqvQ9zAnGWAY7MyzfDKlBt3y2JcSbDEU8E/yBZf4V?=
 =?us-ascii?Q?xkqjpcetG0eIM6CXJx0AlXgQhG1Y5dUAhEbslONtDIuWbRMFplryX+/ZpbXn?=
 =?us-ascii?Q?LZzpgWDJg7Ia7rr/kjiu6pZralUCfshksykBMScaL06DMEo84x0Rv7WilC4l?=
 =?us-ascii?Q?UJ/mhWabmoKH6GuK2fgdZYY+oqTTjOXA+osyz+iOUn9FdLxPWTcHVSAjqz2W?=
 =?us-ascii?Q?+DwUIsd2C8WhIVZM9u61+x7hC0wrFG6Hnnxzs2E3mc+6AnPQBdaeXO+jiUtG?=
 =?us-ascii?Q?qnfVtSAYEdm+5HYIX9UdHatS9B+92fcCKz4ylp027xDNMjqlMB9EAwQPQQnM?=
 =?us-ascii?Q?URD8SbPCNs69dXFbsVDRbTlGp/3M73OL1vkl3u1ROjud2HESzQSO6kUR2mF6?=
 =?us-ascii?Q?7M/7MnS8lqOcLW5Ll2TUpatt+S0CV0QvTWY+j5yhjZWy5Is3QmcPAl2ZTdVO?=
 =?us-ascii?Q?z0/Zg4qaKOsZ5P1Xs6JLveFv4MKyA492yTd4HMpr6E0jc2N1jZKvmuohKCd4?=
 =?us-ascii?Q?S8d2ywGtoKS8HIlzGoqRXet/J9KuqEsEf81h0uu/75cowciC4bU0TW/45whn?=
 =?us-ascii?Q?FNf6apHRB6vNmVACPI7UPCXiOZhDQK8E/cbAEy1kqxkoqY1QYMeVOEsRR3VP?=
 =?us-ascii?Q?uWqxuEXkXn5uynWrPVWea1AAPklwUI3HXrhS3S1DnhM+KHtrd891dTaQI0YK?=
 =?us-ascii?Q?nfW6+0T6TW+dNq4=3D?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:64aa7808-outbound-1.mta.getcheckrecipient.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(35042699022)(14060799003)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 11:18:13.3765
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f598815-ea9e-45c4-3e10-08dd67a0e78e
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000B622.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR08MB7428

As the FLUSH_MEM and FLUSH_PT commands are deprecated in GPUs from
Mali-G720 onwards, this patch adds support for performing cache
maintenance via the FLUSH_CACHES command in GPU_CONTROL, in place of
FLUSH_MEM and FLUSH_PT based on PANTHOR_HW_FEATURE_GPU_CTRL_CACHE_FLUSH
feature bit.

Signed-off-by: Karunika Choo <karunika.choo@arm.com>
---
 drivers/gpu/drm/panthor/panthor_hw.h  |  6 +++++
 drivers/gpu/drm/panthor/panthor_mmu.c | 35 +++++++++++++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/drivers/gpu/drm/panthor/panthor_hw.h b/drivers/gpu/drm/panthor/panthor_hw.h
index dfe0f86c5d76..4d67fdfe86f9 100644
--- a/drivers/gpu/drm/panthor/panthor_hw.h
+++ b/drivers/gpu/drm/panthor/panthor_hw.h
@@ -16,6 +16,12 @@ struct panthor_device;
  * New feature flags will be added with support for newer GPU architectures.
  */
 enum panthor_hw_feature {
+	/**
+	 * @PANTHOR_HW_FEATURE_GPU_CTRL_CACHE_FLUSH: Perform cache maintenance
+	 * via GPU_CONTROL.
+	 */
+	PANTHOR_HW_FEATURE_GPU_CTRL_CACHE_FLUSH,
+
 	/** @PANTHOR_HW_FEATURES_END: Must be last. */
 	PANTHOR_HW_FEATURES_END
 };
diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
index a0a79f19bdea..4ac8bf36177e 100644
--- a/drivers/gpu/drm/panthor/panthor_mmu.c
+++ b/drivers/gpu/drm/panthor/panthor_mmu.c
@@ -29,7 +29,9 @@
 
 #include "panthor_device.h"
 #include "panthor_gem.h"
+#include "panthor_gpu.h"
 #include "panthor_heap.h"
+#include "panthor_hw.h"
 #include "panthor_mmu.h"
 #include "panthor_regs.h"
 #include "panthor_sched.h"
@@ -568,6 +570,35 @@ static void lock_region(struct panthor_device *ptdev, u32 as_nr,
 	write_cmd(ptdev, as_nr, AS_COMMAND_LOCK);
 }
 
+static int mmu_hw_do_flush_on_gpu_ctrl(struct panthor_device *ptdev, int as_nr,
+				       u32 op)
+{
+	const u32 l2_flush_op = CACHE_CLEAN | CACHE_INV;
+	u32 lsc_flush_op = 0;
+	int ret;
+
+	if (op == AS_COMMAND_FLUSH_MEM)
+		lsc_flush_op = CACHE_CLEAN | CACHE_INV;
+
+	ret = wait_ready(ptdev, as_nr);
+	if (ret)
+		return ret;
+
+	ret = panthor_gpu_flush_caches(ptdev, l2_flush_op, lsc_flush_op, 0);
+	if (ret)
+		return ret;
+
+	/*
+	 * Explicitly unlock the region as the AS is not unlocked automatically
+	 * at the end of the GPU_CONTROL cache flush command, unlike
+	 * AS_COMMAND_FLUSH_MEM or AS_COMMAND_FLUSH_PT.
+	 */
+	write_cmd(ptdev, as_nr, AS_COMMAND_UNLOCK);
+
+	/* Wait for the unlock command to complete */
+	return wait_ready(ptdev, as_nr);
+}
+
 static int mmu_hw_do_operation_locked(struct panthor_device *ptdev, int as_nr,
 				      u64 iova, u64 size, u32 op)
 {
@@ -585,6 +616,10 @@ static int mmu_hw_do_operation_locked(struct panthor_device *ptdev, int as_nr,
 	if (op != AS_COMMAND_UNLOCK)
 		lock_region(ptdev, as_nr, iova, size);
 
+	if (panthor_hw_supports(ptdev,PANTHOR_HW_FEATURE_GPU_CTRL_CACHE_FLUSH))
+		if (op == AS_COMMAND_FLUSH_MEM || op == AS_COMMAND_FLUSH_PT)
+			return mmu_hw_do_flush_on_gpu_ctrl(ptdev, as_nr, op);
+
 	/* Run the MMU operation */
 	write_cmd(ptdev, as_nr, op);
 
-- 
2.47.1



Return-Path: <linux-kernel+bounces-311503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E869689EF
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 16:29:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A134528138E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 14:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFC9F19E98A;
	Mon,  2 Sep 2024 14:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="P4Xt4NVu";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="P4Xt4NVu"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2046.outbound.protection.outlook.com [40.107.249.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB3914A61B
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 14:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.46
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725287377; cv=fail; b=Xgknq5OyCAYPO63jG3sgsf8YLZ9ppW8Xac5MoNxxUXbg+Miwkl2iypD8ruBGYrVkNmvbmyFlzg28/oIvrW/1hbXTDG/TqDJ+e0SsvoL7rMFnATBHOB25L3cDncFLBqyzqpnqrmDI/Smyj3R0+8JLGgcUpKgVv9FV1In3OSgk404=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725287377; c=relaxed/simple;
	bh=9gjiDKoLXfj3beiGACVy+J75dhNyBlLDVbzBWIz5LdQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pXmPGmkO9IU2S+AIl/G79gMJViJvQGy0HHGNs5+M3MXvbnmpyUun+Pvb17h7ipqOYIwRlZ/HbsCjxLHq+yBUBXWFLsd7Ca9Yd63K9pity9kRsiQXJayaOjJINIX4l1Y2Wp64NWtUONJzwNPX03W01qPGqpzQHproKiHfefyqBaU=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=P4Xt4NVu; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=P4Xt4NVu; arc=fail smtp.client-ip=40.107.249.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=kJ1n+/MuAeS59Yi9Lr04LFnRA6QdyvQEQHiHiNahh4IcIgp4xs8jFNyFmF+2MPaq24vhrw3JHevVYf49X/A5flLR/BBszdh9F1HNuGITr8j3PdvMoDzIglN6CdoOaR50b4PixWOf8kgNiCAdYH7p9h+6XNdHMZ/3H7edvS4L6W4HI8xFMjVFAWZtgbRhGCjgARoBtYxbi3ox2pvCPXIrWi4N8nmh1fMKeAbyaHFISVyx8CYNSGKdhUVFocLxEZWFOLz2zvOZDiop92PfqIagvlROgO5SZ492Y8JdTjcePiBoJSOVBHs7hdm5EzytTzXnH/afckSg/LTWUFuBzIqfZA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0xLL2EmQBrxT6GqXW4tWEVD+e4YeZUot2UHJVn+PGpU=;
 b=mzbsQpZMLLxYHegsw6pkZN/xBl+ae+TYiElhVhNKeYXyfkJSWBfLR9Ps0iUydYdUmr2PMUdZa6PDGjkwrZkhrDtLLsd88VyMOb3bBPi0Y4zRTkajkJwWBumSBuhDsxoyLI9y/o+AOQMLFL2w8E0AKDCvzOOO5KiszzvKIvItd47KN7Qs3tgw0SSSLWGAoqfNKoN6PUYqoAhA4sBvZqI5Ba2i9td6q7YtWQHO/q/SboGynw0DSMYS9eYFozdIxOztyEeP+0Sj26/T4PHeEORHCqbqcAYL2ZKl1az61umgDn1KWGhXYIJVRtzJU3vW8Po1UYAtQPxZrH6pS8ayamXK8w==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0xLL2EmQBrxT6GqXW4tWEVD+e4YeZUot2UHJVn+PGpU=;
 b=P4Xt4NVutTXy8HctqBNBweTWiG7woxUMShM31kkuTaeTLXUNyUtk7YjZb1z7omqEywVjbv1YlwnO02gWf3xUvR8RXigjrWFNxldw638lEdmwYjGJI1TLc2BlptMzVz7yB5ZNbQ+yBPZK20pSfVVTeKAwrrKmjJkhVBBrKehaejk=
Received: from AM0PR01CA0105.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:10e::46) by DB8PR08MB5322.eurprd08.prod.outlook.com
 (2603:10a6:10:114::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Mon, 2 Sep
 2024 14:29:26 +0000
Received: from AM3PEPF00009B9E.eurprd04.prod.outlook.com
 (2603:10a6:208:10e:cafe::20) by AM0PR01CA0105.outlook.office365.com
 (2603:10a6:208:10e::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24 via Frontend
 Transport; Mon, 2 Sep 2024 14:29:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM3PEPF00009B9E.mail.protection.outlook.com (10.167.16.23) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7918.13
 via Frontend Transport; Mon, 2 Sep 2024 14:29:26 +0000
Received: ("Tessian outbound 901f45c3f9e8:v403"); Mon, 02 Sep 2024 14:29:26 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 84335adf86dc4128
X-CR-MTA-TID: 64aa7808
Received: from Lea1b76cc5504.1
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 6878B68A-5520-446D-AC34-B9B43DC54BC6.1;
	Mon, 02 Sep 2024 14:29:20 +0000
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id Lea1b76cc5504.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Mon, 02 Sep 2024 14:29:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i1cAK05zpJGHpM6KbZhHXxkWIWxgby4Tim6Vh7pQvjG1ir6NdRnN8ltadl9sXtTUI41bL/VDBHjXzXtoZR9qLJSoH75gdnvc77+OgbT6C8PyI5jgEKmaNpPj+ihEFEQusitEmsa5m9S1pRl+75z4p8znVyRZ/nonqE+I4jjHbQTzFTvRXvEnQUMPuKL7HEb/9XpwPaGZu9vjjYDN8pK2sm5RN4AdGWhauWVjcz/Q/yTaYKTWYn86JPYX8vzqooX8KnO6WAYRtDi+Whl/cFM1cf4+Vdx9a3j6h2qHfXXKvt/eJUJMSAZCOXMrN+A9cEnwxOGEm+H/tw8fG3X+4Qcevw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0xLL2EmQBrxT6GqXW4tWEVD+e4YeZUot2UHJVn+PGpU=;
 b=ZDmJNrueBh6tP+6ztHTG+Wl7mRgTANHlCcbPkiV/XHXzmlEiFkyJC7b0PLjXaopeQkcs+HvEDHmFkhKgA6qc2UPOVzErJPLeBP9Kt0JDglq7NAoffyJxqg9jzqkntsMnmQzWgLWvOA15iNGBPoS0ipuwhr7tcLfUbjWtEu05kST4H+kE+J2cLruWmR+zDtfz4wugVx2HvpbizFmloT9a7fSH/hXjMGoifh4MtS2uVEQ8EHw18INrGzfrB7kyS/cUNH8INKsoT/ejiHAAGxlZ27ZlLD4/bJq2xxJBIDCugTSAKqfKHucU1c9ICAEAVx2DdlafzQ+1g1FSfo/QCA4XTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 40.67.248.234) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0xLL2EmQBrxT6GqXW4tWEVD+e4YeZUot2UHJVn+PGpU=;
 b=P4Xt4NVutTXy8HctqBNBweTWiG7woxUMShM31kkuTaeTLXUNyUtk7YjZb1z7omqEywVjbv1YlwnO02gWf3xUvR8RXigjrWFNxldw638lEdmwYjGJI1TLc2BlptMzVz7yB5ZNbQ+yBPZK20pSfVVTeKAwrrKmjJkhVBBrKehaejk=
Received: from DB8PR06CA0036.eurprd06.prod.outlook.com (2603:10a6:10:100::49)
 by AM0PR08MB5410.eurprd08.prod.outlook.com (2603:10a6:208:182::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.23; Mon, 2 Sep
 2024 14:29:17 +0000
Received: from DB5PEPF00014B9E.eurprd02.prod.outlook.com
 (2603:10a6:10:100:cafe::17) by DB8PR06CA0036.outlook.office365.com
 (2603:10a6:10:100::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25 via Frontend
 Transport; Mon, 2 Sep 2024 14:29:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 40.67.248.234)
 smtp.mailfrom=arm.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 40.67.248.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=40.67.248.234; helo=nebula.arm.com; pr=C
Received: from nebula.arm.com (40.67.248.234) by
 DB5PEPF00014B9E.mail.protection.outlook.com (10.167.8.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Mon, 2 Sep 2024 14:29:17 +0000
Received: from AZ-NEU-EXJ01.Arm.com (10.240.25.132) by AZ-NEU-EX03.Arm.com
 (10.251.24.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 2 Sep
 2024 14:29:15 +0000
Received: from AZ-NEU-EX03.Arm.com (10.251.24.31) by AZ-NEU-EXJ01.Arm.com
 (10.240.25.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 2 Sep
 2024 14:29:14 +0000
Received: from e122338.kfn.arm.com (10.50.2.57) by mail.arm.com (10.251.24.31)
 with Microsoft SMTP Server id 15.1.2507.39 via Frontend Transport; Mon, 2 Sep
 2024 14:29:12 +0000
From: Yulia Garbovich <yulia.garbovich@arm.com>
To: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC: <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
	<tzimmermann@suse.de>, <airlied@gmail.com>, <daniel@ffwll.ch>,
	<liviu.dudau@arm.com>, <rosen.zhelev@arm.com>, Yulia Garbovich
	<yulia.garbovich@arm.com>
Subject: [PATCH v2] drm: drm_fourcc: adding 10/12/14 bit formats
Date: Mon, 2 Sep 2024 17:29:10 +0300
Message-ID: <20240902142910.2716380-1-yulia.garbovich@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 1
X-MS-TrafficTypeDiagnostic:
	DB5PEPF00014B9E:EE_|AM0PR08MB5410:EE_|AM3PEPF00009B9E:EE_|DB8PR08MB5322:EE_
X-MS-Office365-Filtering-Correlation-Id: de06418d-c2d2-4b9a-a4a4-08dccb5ba5e0
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?KeOJf5FBCJTFEJMh+7qKntCOxoqjkOAM+gLni0oI644oi5wY5OfrSSTKCWZh?=
 =?us-ascii?Q?7UJzvyDxWuYUBbUlpCg31fFZXLwCv2uWT84lOtLfu0LbkkbNXkpMwicVMrkT?=
 =?us-ascii?Q?AdmFR9AwfU9Ign0NShA6pYR3wO7Fo/d05thpACMsaAx6Pr0L86HfOT8vBo6r?=
 =?us-ascii?Q?iXm2EStmKJhDVWIWyx4mWfG0P9xEv0lbv0ls5hzl5e+g014acIFOIAgA9VW8?=
 =?us-ascii?Q?xTB55eJ1OHKGJaL79VY9oUXZb37EtNRDicGOkMaWWsP6oqKvIqJjJSSnE4S6?=
 =?us-ascii?Q?fkadHBz6lSB9wiaRcj63KQjuS7To+U4zh4RSol7nYA1k9cV7tDFM3G5LOLeM?=
 =?us-ascii?Q?INwTOUUV7Oxw3GsXB1klet50lBnZbgcgjeJ1FzrcBdVshA+adTf7TDUqOWbM?=
 =?us-ascii?Q?9w7YN2gb00zrjnMLGmtgERJBvZ3PUHBmaFZ4I+7rP8fY2gAX0kVL288xgvur?=
 =?us-ascii?Q?KsJS3U8WAVQql6e35rp0JE3EGAgNr+Rgva6Q9RVBvcgoAxYBT9FfO5EtolZk?=
 =?us-ascii?Q?k19/cycYY6bT9yibPNJogM1lOVwMxIseYKC0M6zFHuV2t3NsQ2jxIvhuvoSM?=
 =?us-ascii?Q?OHKJoNsheW/bQaG3A15fTmcPYDznwvBNAnF/DvYm2aItlYQMpLAY2ySb7Hdd?=
 =?us-ascii?Q?YsTQv4tXDW59xmCRZalzIDWwQpMGBIosVabMnjcXmOPXVOn6mlflUDGdw8Nz?=
 =?us-ascii?Q?IXcH1bdlgAldRdwJUk6i17hNz1R3kpFAHJMg3fdzwDAtNWANH1Q+HRQO0bWa?=
 =?us-ascii?Q?nzUddiGN04n+OzmD1psh1KSLbUQT3UqGTvnfJ+Gi1jkgabRRlIWo3Aqm9xjz?=
 =?us-ascii?Q?gxbAXsc9tk0giCxeV6nQiV5XDQ6GhCc4v4fqhgF5eVn24/9wnnJCY4/nSnoi?=
 =?us-ascii?Q?4JD+s4Mfi6yHNICL0h/txpy7y4EGw6LHg62lM6thinLxb4TXP5+Xrp+ni65R?=
 =?us-ascii?Q?0XB/nYk5Pa4qEGnBfcvfKs13QDAEsBKBJWJP3YmwmoKfms6B0KAZAlXHCL7g?=
 =?us-ascii?Q?t+bCTDFQudYvmy+m3XaXAl4uX7rzaT+sRwO0j0GjNNU2lgMyoOScydxYt8uh?=
 =?us-ascii?Q?0yCKVKsMTVktYuw9j4giLGLpy3ABq7EcOiE2vRsGom2EDAmGuaOr8UklTdNK?=
 =?us-ascii?Q?RaZfNc/cHnBxTYIIPkDfdPR71v5uI471j71Qk+kUs73vd84PPEO1HdorvjEM?=
 =?us-ascii?Q?TKwdUkQ9ql8ZOfwWnPDg4JCdPZQGwtMlX7az26M0UaQLEZTAzzRrg893I206?=
 =?us-ascii?Q?L2JOCVJkMKSxmpSGRLWY4b22nuWa9lreuUutQnxLN+MvclAYAaEOp4DsCrkK?=
 =?us-ascii?Q?mCKo3CykSiXDbzfiHPuqdNgcxwVYRmdf3RZEnC+wn4kmHYobyTKLLvIa9TJ6?=
 =?us-ascii?Q?Wix25ehxzS3OzCQH71Y+UM6lfM8gyLUJt+DyE+S57Onskl5WeT7LuIH8CLMz?=
 =?us-ascii?Q?LUk3rxke8fTcV9IbyzibHsdIMVudBnQo?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:40.67.248.234;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:nebula.arm.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5410
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:10:100::49];domain=DB8PR06CA0036.eurprd06.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM3PEPF00009B9E.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	db327067-e1fd-4dd5-1706-08dccb5ba03f
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026|35042699022;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?P9ye9YsBA8A3rN56jYKoUwRmjt82six5tNHaFy5hHKnCyQ2crxBgsH7LHChz?=
 =?us-ascii?Q?lKQJI6XZSKAHZ91BIH1FGs5dIu1T7AaB+4mF0UnpWXRYk3D7O99khT3uuK4a?=
 =?us-ascii?Q?2I8epwyRDBKpHHnRD6kzMwHE1U9ClpB2Zog6OJKOtkyU0nBgIS1E1ks6ZNkI?=
 =?us-ascii?Q?/wB6mCm5Z7alymheyIC4jtlJyUYO2UF/kHdxn5sgsy2/ZPRQh/U5atwmMl+m?=
 =?us-ascii?Q?v5ybDdddjTk+D++IR/5f4B+xUSyPzaRbWsV8mI4xFac/d4h2UBcEHSoVJvI4?=
 =?us-ascii?Q?OLucHw3v9hWXNS6hQ+jyKVI+UejSWRXnWerqYeZLIvVq7rbxVorEKsDm8VuS?=
 =?us-ascii?Q?jtBqd0eOJYUUI7AdW6Rc9stAZg1Tr/wjVTGUKilPI2C73EXKm+0bCqnVbRz8?=
 =?us-ascii?Q?5GDBm3mDFpRa27VYfrQtBYYEQvILv9GFbk0e/z+tt57jEs/xhnG38Ulcr3cq?=
 =?us-ascii?Q?4fmhqIAj9yquLO+JE8uH8kSc2SX2qNEwxG7zZh3O1nuKpC4gHbLmqBQlalck?=
 =?us-ascii?Q?gmkegJayJkVs2PynXF31rmYl2LNOeJb1EZ4CfuWHtHxF/JbuKQgHs8eVWCN7?=
 =?us-ascii?Q?iNUdNgd2nSBpGEaFJhHfDa74mXeBkqfvKjeXUSumN3L3UvdIQ7bKJJy5V4pb?=
 =?us-ascii?Q?TzYnh8FJgrc+fFm9E+CL2c8Vkff4XR9zaGxZEfB7yRcdNjYCVP//NaRhuYy7?=
 =?us-ascii?Q?yiW/M34qUDjpasY3aD2TD50ljazjSpvwq6NRC0LiHk37lowBpB2dev4rBqVy?=
 =?us-ascii?Q?lzUxPgimv7WgSxFtvCIriiyNjEJu7nkJkvws2s9wied6u6t95Vow8u+oz9m1?=
 =?us-ascii?Q?WKkiKB9ijsw8KuhRaEmEX7cCXYUrd9T1lBlDx5/v2rs1KLA2KS97L7MR1sxx?=
 =?us-ascii?Q?58ZLjIacf32lZ+pa+EhG6g7HthdRE8wKT7illrh/uj3zYV4u3NiiesKy3x8W?=
 =?us-ascii?Q?2IiRsw1C4GSuB+O/chCo1C8w1i7rNvITWgD6c+DjVOcN1Nna8pguyrzgYG4I?=
 =?us-ascii?Q?2DBQD+sy15F+SMbY84hqRXucUCyLPIry1+23J3ZdCznY+w8V+sk/cZoKMZMm?=
 =?us-ascii?Q?vJMVpN7myYbpXQ/zbJ3S9c/BHtlL/kOw2FUOATwfSGCW1ztxRwZ98iHrhCIc?=
 =?us-ascii?Q?Kwpgi27qtu5Ykk8GY7FKFwrv8fz1I8kcRcch4m9aKTHksqsb0TgWqOrJNW3Y?=
 =?us-ascii?Q?dXzNYnaUSWo4CqJ13DUgr2sogoobuBAXb/l57ijwiFSfcdlYygBuPdtfZKto?=
 =?us-ascii?Q?H1QnWQFMiWpjYE5nuE0bcx+mQrqdCMT1qoqcAPHSaTPpIBnK1HNe0qOrhiEB?=
 =?us-ascii?Q?t7TnVYPiclF8YrliAvre/Itc/QV7C2EJ6VFubnvvqpg/7hKjoz0a3O3YBcee?=
 =?us-ascii?Q?VLB/9+Z/BznyOR49HSpcyjhoSChzDhKjVsrSQ9r47jhrnTuTqGNa6LOM/Fsv?=
 =?us-ascii?Q?PFir5A24fWy6E4FEe1uD3tqjfghYfDNh?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026)(35042699022);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2024 14:29:26.4255
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de06418d-c2d2-4b9a-a4a4-08dccb5ba5e0
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF00009B9E.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5322

Adding the following formats
     - DRM_FORMAT_RX106
     - DRM_FORMAT_GXRX106106
     - DRM_FORMAT_RX124
     - DRM_FORMAT_GXRX124124
     - DRM_FORMAT_AXBXGXRX124124124124
     - DRM_FORMAT_RX142
     - DRM_FORMAT_GXRX142142
     - DRM_FORMAT_AXBXGXRX142142142142

They are useful for communicating Bayer data between ISPs and GPU by emulating GL_R16UI and GL_RG16UI formats

Signed-off-by: Yulia Garbovich <yulia.garbovich@arm.com>
---
 drivers/gpu/drm/drm_fourcc.c  |  8 +++++
 include/uapi/drm/drm_fourcc.h | 61 +++++++++++++++++++++++++++++++++--
 2 files changed, 67 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_fourcc.c b/drivers/gpu/drm/drm_fourcc.c
index 193cf8ed7912..cd5f467edfeb 100644
--- a/drivers/gpu/drm/drm_fourcc.c
+++ b/drivers/gpu/drm/drm_fourcc.c
@@ -170,6 +170,9 @@ const struct drm_format_info *__drm_format_info(u32 format)
 		{ .format = DRM_FORMAT_R8,		.depth = 8,  .num_planes = 1, .cpp = { 1, 0, 0 }, .hsub = 1, .vsub = 1 },
 		{ .format = DRM_FORMAT_R10,		.depth = 10, .num_planes = 1, .cpp = { 2, 0, 0 }, .hsub = 1, .vsub = 1 },
 		{ .format = DRM_FORMAT_R12,		.depth = 12, .num_planes = 1, .cpp = { 2, 0, 0 }, .hsub = 1, .vsub = 1 },
+		{ .format = DRM_FORMAT_RX106,	.depth = 0,  .num_planes = 1, .cpp = { 2, 0, 0 }, .hsub = 1, .vsub = 1 },
+		{ .format = DRM_FORMAT_RX124,	.depth = 0,  .num_planes = 1, .cpp = { 2, 0, 0 }, .hsub = 1, .vsub = 1 },
+		{ .format = DRM_FORMAT_RX142,	.depth = 0,  .num_planes = 1, .cpp = { 2, 0, 0 }, .hsub = 1, .vsub = 1 },
 		{ .format = DRM_FORMAT_RGB332,		.depth = 8,  .num_planes = 1, .cpp = { 1, 0, 0 }, .hsub = 1, .vsub = 1 },
 		{ .format = DRM_FORMAT_BGR233,		.depth = 8,  .num_planes = 1, .cpp = { 1, 0, 0 }, .hsub = 1, .vsub = 1 },
 		{ .format = DRM_FORMAT_XRGB4444,	.depth = 0,  .num_planes = 1, .cpp = { 2, 0, 0 }, .hsub = 1, .vsub = 1 },
@@ -200,6 +203,9 @@ const struct drm_format_info *__drm_format_info(u32 format)
 		{ .format = DRM_FORMAT_XBGR8888,	.depth = 24, .num_planes = 1, .cpp = { 4, 0, 0 }, .hsub = 1, .vsub = 1 },
 		{ .format = DRM_FORMAT_RGBX8888,	.depth = 24, .num_planes = 1, .cpp = { 4, 0, 0 }, .hsub = 1, .vsub = 1 },
 		{ .format = DRM_FORMAT_BGRX8888,	.depth = 24, .num_planes = 1, .cpp = { 4, 0, 0 }, .hsub = 1, .vsub = 1 },
+		{ .format = DRM_FORMAT_GXRX106106,	.depth = 0,  .num_planes = 1, .cpp = { 4, 0, 0 }, .hsub = 1, .vsub = 1 },
+		{ .format = DRM_FORMAT_GXRX124124,	.depth = 0,  .num_planes = 1, .cpp = { 4, 0, 0 }, .hsub = 1, .vsub = 1 },
+		{ .format = DRM_FORMAT_GXRX142142,	.depth = 0,  .num_planes = 1, .cpp = { 4, 0, 0 }, .hsub = 1, .vsub = 1 },
 		{ .format = DRM_FORMAT_RGB565_A8,	.depth = 24, .num_planes = 2, .cpp = { 2, 1, 0 }, .hsub = 1, .vsub = 1, .has_alpha = true },
 		{ .format = DRM_FORMAT_BGR565_A8,	.depth = 24, .num_planes = 2, .cpp = { 2, 1, 0 }, .hsub = 1, .vsub = 1, .has_alpha = true },
 		{ .format = DRM_FORMAT_XRGB2101010,	.depth = 30, .num_planes = 1, .cpp = { 4, 0, 0 }, .hsub = 1, .vsub = 1 },
@@ -219,6 +225,8 @@ const struct drm_format_info *__drm_format_info(u32 format)
 		{ .format = DRM_FORMAT_ARGB16161616F,	.depth = 0,  .num_planes = 1, .cpp = { 8, 0, 0 }, .hsub = 1, .vsub = 1, .has_alpha = true },
 		{ .format = DRM_FORMAT_ABGR16161616F,	.depth = 0,  .num_planes = 1, .cpp = { 8, 0, 0 }, .hsub = 1, .vsub = 1, .has_alpha = true },
 		{ .format = DRM_FORMAT_AXBXGXRX106106106106, .depth = 0, .num_planes = 1, .cpp = { 8, 0, 0 }, .hsub = 1, .vsub = 1, .has_alpha = true },
+		{ .format = DRM_FORMAT_AXBXGXRX124124124124, .depth = 0, .num_planes = 1, .cpp = { 8, 0, 0 }, .hsub = 1, .vsub = 1, .has_alpha = true },
+		{ .format = DRM_FORMAT_AXBXGXRX142142142142, .depth = 0, .num_planes = 1, .cpp = { 8, 0, 0 }, .hsub = 1, .vsub = 1, .has_alpha = true },
 		{ .format = DRM_FORMAT_XRGB16161616,	.depth = 0,  .num_planes = 1, .cpp = { 8, 0, 0 }, .hsub = 1, .vsub = 1 },
 		{ .format = DRM_FORMAT_XBGR16161616,	.depth = 0,  .num_planes = 1, .cpp = { 8, 0, 0 }, .hsub = 1, .vsub = 1 },
 		{ .format = DRM_FORMAT_ARGB16161616,	.depth = 0,  .num_planes = 1, .cpp = { 8, 0, 0 }, .hsub = 1, .vsub = 1, .has_alpha = true },
diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
index 84d502e42961..7248b96ecf7e 100644
--- a/include/uapi/drm/drm_fourcc.h
+++ b/include/uapi/drm/drm_fourcc.h
@@ -146,6 +146,24 @@ extern "C" {
 /* 12 bpp Red (direct relationship between channel value and brightness) */
 #define DRM_FORMAT_R12		fourcc_code('R', '1', '2', ' ') /* [15:0] x:R 4:12 little endian */
 
+/*
+ * 1-component 16 bpp format that has a 10-bit R component in the top 10 bits of the word
+ * in bytes 0..1 with the bottom 6 bits of the word unused
+ */
+#define DRM_FORMAT_RX106	fourcc_code('R', '0', '1', '0') /* [15:0] R:x 10:6 little endian */
+
+/*
+ * 1-component 16 bpp format that has a 12-bit R component in the top 12 bits of the word
+ * in bytes 0..1 with the bottom 4 bits of the word unused
+ */
+#define DRM_FORMAT_RX124	fourcc_code('R', '0', '1', '2') /* [15:0] R:x 12:4 little endian */
+
+/*
+ * 1-component 16 bpp format that has a 14-bit R component in the top 14 bits of the word
+ * in bytes 0..1 with the bottom 2 bits of the word unused
+ */
+#define DRM_FORMAT_RX142	fourcc_code('R', '0', '1', '4') /* [15:0] R:x 14:2 little endian */
+
 /* 16 bpp Red (direct relationship between channel value and brightness) */
 #define DRM_FORMAT_R16		fourcc_code('R', '1', '6', ' ') /* [15:0] R little endian */
 
@@ -157,6 +175,27 @@ extern "C" {
 #define DRM_FORMAT_RG1616	fourcc_code('R', 'G', '3', '2') /* [31:0] R:G 16:16 little endian */
 #define DRM_FORMAT_GR1616	fourcc_code('G', 'R', '3', '2') /* [31:0] G:R 16:16 little endian */
 
+ /*
+ * 2-component  32bpp  format that has a 10-bit R component in the top 10 bits of the word
+ * in bytes 0..1, and a 10-bit G component in the top 10 bits of the word in bytes 2..3,
+ * with the bottom 6 bits of each word unused.
+ */
+#define DRM_FORMAT_GXRX106106	fourcc_code('G', 'R', '1', '0') /* [31:0] G:x:R:x 10:6:10:6 little endian */
+
+/*
+ * 2-component  32bpp  format that has a 12-bit R component in the top 12 bits of the word
+ * in bytes 0..1, and a 12-bit G component in the top 12 bits of the word in bytes 2..3,
+ * with the bottom 4 bits of each word unused.
+ */
+#define DRM_FORMAT_GXRX124124	fourcc_code('G', 'R', '1', '2') /* [31:0] G:x:R:x 12:4:12:4 little endian */
+
+/*
+ * 2-component  32bpp  format that has a 14-bit R component in the top 14 bits of the word
+ * in bytes 0..1, and a 14-bit G component in the top 14 bits of the word in bytes 2..3,
+ * with the bottom 2 bits of each word unused.
+ */
+#define DRM_FORMAT_GXRX142142	fourcc_code('G', 'R', '1', '4') /* [31:0] G:x:R:x 14:2:14:2 little endian */
+
 /* 8 bpp RGB */
 #define DRM_FORMAT_RGB332	fourcc_code('R', 'G', 'B', '8') /* [7:0] R:G:B 3:3:2 */
 #define DRM_FORMAT_BGR233	fourcc_code('B', 'G', 'R', '8') /* [7:0] B:G:R 2:3:3 */
@@ -229,11 +268,29 @@ extern "C" {
 #define DRM_FORMAT_ABGR16161616F fourcc_code('A', 'B', '4', 'H') /* [63:0] A:B:G:R 16:16:16:16 little endian */
 
 /*
- * RGBA format with 10-bit components packed in 64-bit per pixel, with 6 bits
- * of unused padding per component:
+ * 4-component, 64bpp format that has a 10-bit R component in the top 10 bits of the word in bytes 0..1,
+ * a 10-bit G component in the top 10 bits of the word in bytes 2..3, a 10-bit B component in the top 10 bits of the word
+ * in bytes 4..5, and a 10-bit A component in the top 10 bits of the word in bytes 6..7,
+ * with the bottom 6 bits of each word unused.
  */
 #define DRM_FORMAT_AXBXGXRX106106106106 fourcc_code('A', 'B', '1', '0') /* [63:0] A:x:B:x:G:x:R:x 10:6:10:6:10:6:10:6 little endian */
 
+/*
+ * 4-component, 64bpp format that has a 12-bit R component in the top 12bits of the word in bytes 0..1,
+ * a 12-bit G component in the top 12 bits of the word in bytes 2..3, a 12-bit B component in the top 12 bits of the word
+ * in bytes 4..5, and a 12-bit A component in the top 12 bits of the word in bytes 6..7,
+ * with the bottom 4 bits of each word unused.
+ */
+#define DRM_FORMAT_AXBXGXRX124124124124	fourcc_code('A', 'B', '1', '2') /* [63:0] A:x:B:x:G:x:R:x 12:4:12:4:12:4:12:4 little endian */
+
+/*
+ * 4-component, 64bpp format that has a 14-bit R component in the top 14 bits of the word in bytes 0..1,
+ * a 14-bit G component in the top 14 bits of the word in bytes 2..3, a 14-bit B component in the top 14 bits of the word
+ * in bytes 4..5, and a 14-bit A component in the top 14 bits of the word in bytes 6..7,
+ * with the bottom 2 bits of each word unused.
+ */
+#define DRM_FORMAT_AXBXGXRX142142142142	fourcc_code('A', 'B', '1', '4') /* [63:0] A:x:B:x:G:x:R:x 14:2:14:2:14:2:14:2 little endian */
+
 /* packed YCbCr */
 #define DRM_FORMAT_YUYV		fourcc_code('Y', 'U', 'Y', 'V') /* [31:0] Cr0:Y1:Cb0:Y0 8:8:8:8 little endian */
 #define DRM_FORMAT_YVYU		fourcc_code('Y', 'V', 'Y', 'U') /* [31:0] Cb0:Y1:Cr0:Y0 8:8:8:8 little endian */
-- 
2.34.1



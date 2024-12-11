Return-Path: <linux-kernel+bounces-441695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F6B99ED2BB
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 17:51:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43035282300
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 16:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F3221DE4F8;
	Wed, 11 Dec 2024 16:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Qj4CMfTS";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Qj4CMfTS"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2089.outbound.protection.outlook.com [40.107.20.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571E81DDC3B
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 16:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.89
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733935876; cv=fail; b=Sk9Igx7YJvuekHnVWGxK/WHOMEGxskj9afF29iOUt/mgrdZ6zyk+56pSzaLedIyVAIzEjll7zRqfsh0vtwJ93jTGtI551ry1jsY786BxT9woaMHtvUap4TxF6+sf47+kqyoxr4OZDYiwjAUr55Cuui7e7l332ID2iPLO6yIzN6s=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733935876; c=relaxed/simple;
	bh=mH/z1bcjsA6H5jBdCOkm7ygmUJMhweIYTcjw4WeuznI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pCVzwjZhRBLygQLAdQVSKeLMq+HLC27iGhGSMrp7cW+HeVkIlTywjoWvXoqkXXN23Ucf37Nuq6MIRbc/SF12ZwUEEfVn9NRmO+Gq4nnqipBSBREQHk4AZ2c1NTPNpFCcxEOKU+1KrieM4CpzI9/qXXuKiT8c/efJoUU4Fx0GksI=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Qj4CMfTS; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Qj4CMfTS; arc=fail smtp.client-ip=40.107.20.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=GqwfasLYvItlrL+2Ughcn8Dl11OHPjeHkPngLUBoaSMknoa8VTth8hxGX24DyNn34WbvQJUWNORHRj2L+ARvmWdx6RDs8J/+boZPd/ON1sVaCHA5i7wTQQOszO4xQrRd+Wx9d+/678UgAHT3K8J9gsJgE8LFa9g3Z7Knrm7Wfqsh807xpVhjR5k1bIdqbAMddJyswo5V+tOftRH3gZcM/innesW2yKwbRQh+TUoAb59xXgQ3dpxC2N97+qmK5kkW2Xq3qJQlNWyazU8pMJLzUQziREgturxNqf0AG3ARuGFXPbdx8pJd4WlYJ4AGbJLWF66vH3+aa9AST3kgho0xGw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HPFjvHzurYcGRDPl+eZz5UpIXNhjbNaySmNYBE0/D/4=;
 b=RMhNqR4G5L+fzI5KKwBSKxiCCM6y4kCgkQFOks4MUxQj8lLK3N7339RIpVnsIwBufiVa0YRrHZeuIvh5yi/zY4qsRGzu2C5r/8T2ygNQqB9ZdK9kfi8p1BZlvdrWL2GRXQeKhPL1tuj5q502zdkHftx8tgNtoN6M1E6YmnIlXD1GK7OO9/8QhtRbQt7juA5ENEnQYEsAdAJobBbJZ6aE6FIpt6LKX0jUbfk0I5FGy2NKERB8YDV2iIgCrXg1fizf1RYIMWjE8hUinMBmQxYbbsQV6FZCJhZv4kfR7usbbz7AeZX9uGgEVsedKSmKUnxbxeWtHH8THD/27Ap/Yd5gkA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HPFjvHzurYcGRDPl+eZz5UpIXNhjbNaySmNYBE0/D/4=;
 b=Qj4CMfTS+CWqpeVVkek4FwE7VYzXG1cNs8RSPHrQptRmLRDZrK0bAsMUGX5a7yAyeu3EZtaJWo87WrRx9kxb+rRR2egk07UKPyNFZSvIl0ud6D8aW7b07didUuInF3mYiZjq+zn52hiiMM4RpDMSQd8qKhCOh0RTN49Ivhkr+FU=
Received: from DU2PR04CA0007.eurprd04.prod.outlook.com (2603:10a6:10:3b::12)
 by DB4PR08MB9261.eurprd08.prod.outlook.com (2603:10a6:10:3fa::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Wed, 11 Dec
 2024 16:51:06 +0000
Received: from DB5PEPF00014B98.eurprd02.prod.outlook.com
 (2603:10a6:10:3b:cafe::b4) by DU2PR04CA0007.outlook.office365.com
 (2603:10a6:10:3b::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.15 via Frontend Transport; Wed,
 11 Dec 2024 16:51:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5PEPF00014B98.mail.protection.outlook.com (10.167.8.165) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.15
 via Frontend Transport; Wed, 11 Dec 2024 16:51:05 +0000
Received: ("Tessian outbound 20d64b55c711:v524"); Wed, 11 Dec 2024 16:51:05 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: d5046944b1377f70
X-TessianGatewayMetadata: lKDehNbMszKsgNrnshmMjwjqk/rb/dPNqPQwW1p/B414W0QqvtU8IAgqrZZ1mpQdjicC3M/53+/KRHu5if/qhnQkLZnBQNfa21aDzJom7vOU97jTHsXunXR+2kvI9Y2tmXNGp/k4feLqjsiKNg2+riZvRRW2i1wU16sGO7h0jKk=
X-CR-MTA-TID: 64aa7808
Received: from L0461535056b5.1
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 0E5C8FBF-BB58-4C81-8256-20ADBF4A650D.1;
	Wed, 11 Dec 2024 16:50:58 +0000
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id L0461535056b5.1
    (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
    Wed, 11 Dec 2024 16:50:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jrP90VwBL4RMsJH2Tcsvxxv/PJdGMkVHiNSdcpOJFkOiBXoeCQvJhAfUYfPBpkFa6ueQFHI7OFcBIGeq/BYXE1xhkyGINMZ5hZxbgdUCuG/YaRu2Lrv8uwWowkz/QJZfouxA0tK0P8YTUtcDwjkBa98X5yQkwvtM62TT4FsSQwV5wxfQiTWsWyf72gCQGOFkN6gBIb6vf7geyyu0QePBUUo8WQwWyWUG7NVQPu6J2cms1Om/X8aH57AektMtIZwrYMSjVF3gk8PTCRqO87/LgcfgJVFS50vdDc7LB/fglB+DVGWPAmOdOUdylJdqtsFo7BetCj+tY+JZnSATzfqW+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HPFjvHzurYcGRDPl+eZz5UpIXNhjbNaySmNYBE0/D/4=;
 b=guCIir2yg1Hp/FB6Sr7V2OE8fM9RHrQtz9L+Lo4ZlLHjHojWVLgkldWKLdKW6v/cYBdx51rDDk4mKEz0d/TBrKTpOiNasED/bo17LpOtbaqqJY7oRBSc/BmxvRif+QORFB+e7Sekf8e3CY/rYauCnIe5UYJ66j/W2udVZ5RH87GPC+nOw+7RY/Rxja+mC/skzcsvNAMJY+4bOURSQKdzMxlVcXKnZvoTvVRy6szbbt74Td6he/v6hP4FaC0iuFtQjBOP85cW5pFdcFBANFaD0x1n8r0e3Y6YT12dHFJn5jhDsvPc7cCV28rffztYKNyf0ac1CnXfLeClaS5yj541cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HPFjvHzurYcGRDPl+eZz5UpIXNhjbNaySmNYBE0/D/4=;
 b=Qj4CMfTS+CWqpeVVkek4FwE7VYzXG1cNs8RSPHrQptRmLRDZrK0bAsMUGX5a7yAyeu3EZtaJWo87WrRx9kxb+rRR2egk07UKPyNFZSvIl0ud6D8aW7b07didUuInF3mYiZjq+zn52hiiMM4RpDMSQd8qKhCOh0RTN49Ivhkr+FU=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM6PR08MB3317.eurprd08.prod.outlook.com (2603:10a6:209:42::28)
 by DU0PR08MB8422.eurprd08.prod.outlook.com (2603:10a6:10:406::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Wed, 11 Dec
 2024 16:50:56 +0000
Received: from AM6PR08MB3317.eurprd08.prod.outlook.com
 ([fe80::e42a:494c:6581:1897]) by AM6PR08MB3317.eurprd08.prod.outlook.com
 ([fe80::e42a:494c:6581:1897%7]) with mapi id 15.20.8230.016; Wed, 11 Dec 2024
 16:50:56 +0000
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
Subject: [RFC v2 3/8] drm/panthor: Add panthor_perf_init and panthor_perf_unplug
Date: Wed, 11 Dec 2024 16:50:19 +0000
Message-Id: <20241211165024.490748-4-lukas.zapolskas@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241211165024.490748-1-lukas.zapolskas@arm.com>
References: <20241211165024.490748-1-lukas.zapolskas@arm.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0069.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:60::33) To AM6PR08MB3317.eurprd08.prod.outlook.com
 (2603:10a6:209:42::28)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AM6PR08MB3317:EE_|DU0PR08MB8422:EE_|DB5PEPF00014B98:EE_|DB4PR08MB9261:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a729c14-15d7-430f-3f4c-08dd1a04013d
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?CZi/BeiXLDmTi6vumbQKSLWbyaJx6rpwHCSNpe9UMVZceNZryzuDTHKGTRqm?=
 =?us-ascii?Q?TmwTI5mVS8LoFjWCZ9u7lM9VUHNTxueWUZPzuQLQEoPftKOUXgrFVgdaMlU4?=
 =?us-ascii?Q?I8QfTujHQrdioXKvFbc/IPq1XlfBy4yVheOg94T/IV4FR03L3pJ7nQCoRPbL?=
 =?us-ascii?Q?dkIVNci92mUKqbewQwaEYEQdt3/CHrmOqX7UhmRa4sBWAnfBJ4byWnlIFm04?=
 =?us-ascii?Q?E9sH9i0xbHxESFr6KnVx6/Lt3Kmy2Q11oMGv8UCYU3H661dIc2aKnWfj4hyd?=
 =?us-ascii?Q?CPVADyMkMrZQRUPGXIkqWE3AGFO7igWmEbhU7UrJ1SAffbCg+9giToPr1iul?=
 =?us-ascii?Q?nKighefjvhTFcYK4U6I3nPWmVeI3E8I7c6wMG207Bj2IJJ4kvk1F6xGc4RdG?=
 =?us-ascii?Q?kiezcUZRwCGnGISUXCJE+HvGkjEqmJ0SsP1QMve905pQHEz67I0ODZib1rSF?=
 =?us-ascii?Q?ff5OW56iwQzQ/ALn98EGChiu90/jtLKkg2Mib5vC5ztEt980c3u/YS0yQwdN?=
 =?us-ascii?Q?xqOvvCHWdDxhK3XdL6gg/qBbjZNTDkIDnBBZgRAKmDF7F3cknltPb423aN4/?=
 =?us-ascii?Q?eYurTM0gxRUQhfBp1Z97kUDp5NnVok7H1gm7txpl4R9hIAEz0sWY89qSg3cK?=
 =?us-ascii?Q?DEegeVywcGpap50VveQpz3mF11dLcPtPEXVFNxBpZW49Dnf3feONQYspA3KH?=
 =?us-ascii?Q?qwEB/xxUkkrwjy9ABrt8Fa8rCzbnkZ+PseXEI89uhEjM91Yw+6wgeV3mvwYN?=
 =?us-ascii?Q?bkRcRJxTOAfuLTG4ZOc4xbsZlbDxST5IIw6376vM7mluAiHRgXTS6FNlI2QR?=
 =?us-ascii?Q?vkkaVka0WZf4lKf7PKtzPJKbYD8bpchG83rh2saLEkMoO33mwuqyhn56u4wg?=
 =?us-ascii?Q?Hw9o9si8hfVR5uabP5SuOUztaDjbE4BVQw4JvdSENbBCoR1MeYAeMofPf39s?=
 =?us-ascii?Q?d3cb9n+pkhpYMie4hXEUeiXBY3k7o43zMcpYZgqmXume/kiGrAnxE8xkCkFB?=
 =?us-ascii?Q?dY3FjFGTY5qaiESG2XrEukaQuEyactUQU/qaPWKQQRtgUqQiGO7cgEkbhLQ7?=
 =?us-ascii?Q?qVaX0rwHGqDQS/Mdv8wfbEMKNSVxuzUDWvaPNAvpfqRXXba4X67im5lmCVzF?=
 =?us-ascii?Q?2tXT3PHNFt7wVGC6HeE6clHl/bXVrlcRmtOVIuup0HIrZIFbLCObvpDWjayP?=
 =?us-ascii?Q?+w9GMUlJ65ourf7KYynnrUUXD1y+8MvF0zFQcV9M/cPHCNCGHtxsQHm+0syZ?=
 =?us-ascii?Q?xUmpVP0fOzANFkcIS59IUZ+yMRgXxKicqF7Tk/OwzoYwNasfM1MwrFQkgoDb?=
 =?us-ascii?Q?AjE8BmXMSTa2LA476+7IRcbaNKDmkWspSLn5FYwtgsYkQg=3D=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB3317.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8422
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:209:42::28];domain=AM6PR08MB3317.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB5PEPF00014B98.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	c1d530cb-7b09-4c56-ca7e-08dd1a03fb80
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|14060799003|35042699022|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4G/FcSOeJghJsqFcj9cDuwdOPyZavtz5wgfUHSL8EyTX4x7Ii5swgIouTskO?=
 =?us-ascii?Q?MDu9uY9sSNuSXF8pYmDFJTwmCSau2dGR1j0ebrBo3YJF/2l8hgWGk4NIm0sh?=
 =?us-ascii?Q?YbFbU3yEluKB50MQoys9CPGbmakhAxLNNHK4eOg9DX9g8DP7gjHzMmmxhuIL?=
 =?us-ascii?Q?6SShyGxwn7Qu6vSwokBgz/+2JndcjqIZqRSIvJjSvcSgVvymD2sluAw1UtDU?=
 =?us-ascii?Q?dY70xoo1D/GR07bdLHtiucw5ACoZuraxYRYJk8YmfnaNUsv04vtEye2KYoLP?=
 =?us-ascii?Q?34zrJXu/RnIDkgPTBzGfnZBM1zXg3PSQGU+BD3yKkFMha3UJNGiv4xgPCD1J?=
 =?us-ascii?Q?Q+JSkLunTO+S0uhlF6GJLzTdfUffvNq2F+90W6rAMv9jF5KjTldbzSoHUoeT?=
 =?us-ascii?Q?zSuOh5AcLbdJHR42bOAVOEL6jQcw2j+445hwxBRbmj0lrs8Dm76g+EcURyGh?=
 =?us-ascii?Q?cq5TxA+o8gUqxfcWobzGAbE8cPjWbndRMa5jYEvi6wvMpeSBG+oAZxVPYu/B?=
 =?us-ascii?Q?Rzcfxaa4LB4FmDA4b09A3nezXhAGh5j2dl2dRYKScoCKB+bmAM3UORVFYXyq?=
 =?us-ascii?Q?UYv/OtEYK/k1BSNRSYY3Dz37ZyqKw0VJS0NIN2AQsRvN4SJHUWxvz8V6H7PL?=
 =?us-ascii?Q?Sbq21+rQdsKQfYaFG6/DkI3LMIZd77W4it/QoESQ8M8oSRtEr9ZYvfVxJQfQ?=
 =?us-ascii?Q?6JQ8cxPtvD+1Hkk5JMTb6FMHAQcTH4ajiIRRD9xqs1Gso9WX8axDgXtbjYJL?=
 =?us-ascii?Q?DbE1Eezz7S0b4s3yweTOl5KYUcU5N1YTTDvmAXMxHFQpJ+uWNxyCHKH+bF9c?=
 =?us-ascii?Q?U3aJV7Lp4EeX7nTVsWgTurM4+8fRtkGjUW4Yw7TqrkPumFWldzbxQLlJo6gM?=
 =?us-ascii?Q?aUScUToIO5N5Lxmo10AL493awPbNJZ1Ee5KAL2rSfpBd+J7yKRiC7FwoEhau?=
 =?us-ascii?Q?W6K3dWWrL4J/ujD5B9q4+4T+3LuaIwB4d5+kx2L4RFUUnXCgMjJpWBXSHYD3?=
 =?us-ascii?Q?ZTQIELvywoCQeWq4lYutavxyZAbhVWW8ZijiyyAH6nFVtjOPMHa/cVDQDgDt?=
 =?us-ascii?Q?6TLcIu3ceIwE+VE+Q3pjxrIC0LPUw6beYFiAi1sMFksuaHYMN4MjQtX26AZ1?=
 =?us-ascii?Q?WSEwo0IESrVgZo9WOpEu/S4WyGoE9148o2AjevZbGW9lkcRx6WFdkygBNP10?=
 =?us-ascii?Q?H56JZC8UV2KiwxT3ftdGPMc6XZ76Kh/oZtuST0X8cRTRj5F2BvaEPMfBN+ZF?=
 =?us-ascii?Q?do2nCHv5IF6KjBe5/xZtroBP578XzcdVDJDoPqmjkvAtgKVjUJpA1UFY42WC?=
 =?us-ascii?Q?UQpXVmEak5+f1WELarX1yHlc+gwISrUFp02WrtSFOSYjLBTK6fjYCH4ulvj0?=
 =?us-ascii?Q?AlANHXlJFe+XFGQTtGWtFxmfgK8xz/9lMEcU0Fvef2ixoMJ+NoyetE9ew+c6?=
 =?us-ascii?Q?SM+u6DSU2YyEL8k+h7BaImKd5lr999lWyedQdKk7mgED297vHjfVdw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:64aa7808-outbound-1.mta.getcheckrecipient.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(14060799003)(35042699022)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 16:51:05.8992
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a729c14-15d7-430f-3f4c-08dd1a04013d
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B98.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR08MB9261

Added the panthor_perf system initialization and unplug code to allow
for the handling of userspace sessions to be added in follow-up patches.

Signed-off-by: Lukas Zapolskas <lukas.zapolskas@arm.com>
---
 drivers/gpu/drm/panthor/panthor_device.c |  7 +++
 drivers/gpu/drm/panthor/panthor_device.h |  5 +-
 drivers/gpu/drm/panthor/panthor_perf.c   | 77 ++++++++++++++++++++++++
 drivers/gpu/drm/panthor/panthor_perf.h   |  3 +
 4 files changed, 91 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panthor/panthor_device.c b/drivers/gpu/drm/panthor/panthor_device.c
index 00f7b8ce935a..1a81a436143b 100644
--- a/drivers/gpu/drm/panthor/panthor_device.c
+++ b/drivers/gpu/drm/panthor/panthor_device.c
@@ -19,6 +19,7 @@
 #include "panthor_fw.h"
 #include "panthor_gpu.h"
 #include "panthor_mmu.h"
+#include "panthor_perf.h"
 #include "panthor_regs.h"
 #include "panthor_sched.h"
 
@@ -97,6 +98,7 @@ void panthor_device_unplug(struct panthor_device *ptdev)
 	/* Now, try to cleanly shutdown the GPU before the device resources
 	 * get reclaimed.
 	 */
+	panthor_perf_unplug(ptdev);
 	panthor_sched_unplug(ptdev);
 	panthor_fw_unplug(ptdev);
 	panthor_mmu_unplug(ptdev);
@@ -262,6 +264,10 @@ int panthor_device_init(struct panthor_device *ptdev)
 	if (ret)
 		goto err_unplug_fw;
 
+	ret = panthor_perf_init(ptdev);
+	if (ret)
+		goto err_unplug_fw;
+
 	/* ~3 frames */
 	pm_runtime_set_autosuspend_delay(ptdev->base.dev, 50);
 	pm_runtime_use_autosuspend(ptdev->base.dev);
@@ -275,6 +281,7 @@ int panthor_device_init(struct panthor_device *ptdev)
 
 err_disable_autosuspend:
 	pm_runtime_dont_use_autosuspend(ptdev->base.dev);
+	panthor_perf_unplug(ptdev);
 	panthor_sched_unplug(ptdev);
 
 err_unplug_fw:
diff --git a/drivers/gpu/drm/panthor/panthor_device.h b/drivers/gpu/drm/panthor/panthor_device.h
index 636542c1dcbd..aca33d03036c 100644
--- a/drivers/gpu/drm/panthor/panthor_device.h
+++ b/drivers/gpu/drm/panthor/panthor_device.h
@@ -26,7 +26,7 @@ struct panthor_heap_pool;
 struct panthor_job;
 struct panthor_mmu;
 struct panthor_fw;
-struct panthor_perfcnt;
+struct panthor_perf;
 struct panthor_vm;
 struct panthor_vm_pool;
 
@@ -137,6 +137,9 @@ struct panthor_device {
 	/** @devfreq: Device frequency scaling management data. */
 	struct panthor_devfreq *devfreq;
 
+	/** @perf: Performance counter management data. */
+	struct panthor_perf *perf;
+
 	/** @unplug: Device unplug related fields. */
 	struct {
 		/** @lock: Lock used to serialize unplug operations. */
diff --git a/drivers/gpu/drm/panthor/panthor_perf.c b/drivers/gpu/drm/panthor/panthor_perf.c
index 0e3d769c1805..e0dc6c4b0cf1 100644
--- a/drivers/gpu/drm/panthor/panthor_perf.c
+++ b/drivers/gpu/drm/panthor/panthor_perf.c
@@ -13,6 +13,24 @@
 #include "panthor_perf.h"
 #include "panthor_regs.h"
 
+struct panthor_perf {
+	/**
+	 * @block_set: The global counter set configured onto the HW.
+	 */
+	u8 block_set;
+
+	/** @next_session: The ID of the next session. */
+	u32 next_session;
+
+	/** @session_range: The number of sessions supported at a time. */
+	struct xa_limit session_range;
+
+	/**
+	 * @sessions: Global map of sessions, accessed by their ID.
+	 */
+	struct xarray sessions;
+};
+
 /**
  * PANTHOR_PERF_COUNTERS_PER_BLOCK - On CSF architectures pre-11.x, the number of counters
  * per block was hardcoded to be 64. Arch 11.0 onwards supports the PRFCNT_FEATURES GPU register,
@@ -45,3 +63,62 @@ void panthor_perf_info_init(struct panthor_device *ptdev)
 	perf_info->shader_blocks = hweight64(ptdev->gpu_info.shader_present);
 }
 
+/**
+ * panthor_perf_init - Initialize the performance counter subsystem.
+ * @ptdev: Panthor device
+ *
+ * The performance counters require the FW interface to be available to setup the
+ * sampling ringbuffers, so this must be called only after FW is initialized.
+ *
+ * Return: 0 on success, negative error code on failure.
+ */
+int panthor_perf_init(struct panthor_device *ptdev)
+{
+	struct panthor_perf *perf;
+
+	if (!ptdev)
+		return -EINVAL;
+
+	perf = devm_kzalloc(ptdev->base.dev, sizeof(*perf), GFP_KERNEL);
+	if (ZERO_OR_NULL_PTR(perf))
+		return -ENOMEM;
+
+	xa_init_flags(&perf->sessions, XA_FLAGS_ALLOC);
+
+	/* Currently, we only support a single session at a time. */
+	perf->session_range = (struct xa_limit) {
+		.min = 0,
+		.max = 1,
+	};
+
+	drm_info(&ptdev->base, "Performance counter subsystem initialized");
+
+	ptdev->perf = perf;
+
+	return 0;
+}
+
+/**
+ * panthor_perf_unplug - Terminate the performance counter subsystem.
+ * @ptdev: Panthor device.
+ *
+ * This function will terminate the performance counter control structures and any remaining
+ * sessions, after waiting for any pending interrupts.
+ */
+void panthor_perf_unplug(struct panthor_device *ptdev)
+{
+	struct panthor_perf *perf = ptdev->perf;
+
+	if (!perf)
+		return;
+
+	if (!xa_empty(&perf->sessions))
+		drm_err(&ptdev->base,
+				"Performance counter sessions active when unplugging the driver!");
+
+	xa_destroy(&perf->sessions);
+
+	devm_kfree(ptdev->base.dev, ptdev->perf);
+
+	ptdev->perf = NULL;
+}
diff --git a/drivers/gpu/drm/panthor/panthor_perf.h b/drivers/gpu/drm/panthor/panthor_perf.h
index cff537a370c9..90af8b18358c 100644
--- a/drivers/gpu/drm/panthor/panthor_perf.h
+++ b/drivers/gpu/drm/panthor/panthor_perf.h
@@ -9,4 +9,7 @@ struct panthor_device;
 
 void panthor_perf_info_init(struct panthor_device *ptdev);
 
+int panthor_perf_init(struct panthor_device *ptdev);
+void panthor_perf_unplug(struct panthor_device *ptdev);
+
 #endif /* __PANTHOR_PERF_H__ */
-- 
2.25.1



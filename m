Return-Path: <linux-kernel+bounces-389698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 960059B7016
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 23:55:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4BF61C212BB
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 22:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89E80217655;
	Wed, 30 Oct 2024 22:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="k9VtfyeZ";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="k9VtfyeZ"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2068.outbound.protection.outlook.com [40.107.22.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26E421744E
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 22:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.68
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730328891; cv=fail; b=VvWOu52IANdJHtMkWemh25jeBTtyhwR0WqyS8BW8piizUbmPtDl4YMUtbnEotIRTzpAarPPFKwQrPEdNJ2blpH5Pzed2/mNFpAYbGtYBY6ISWZ6kaGp5/7LxZL+niKQrvqBMIMXk3J0xHOUYOGmEpkyN+qxnJ3FCkskZO95cQHU=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730328891; c=relaxed/simple;
	bh=Q5BurkxwjtlnA6rD9jYlyMLkAnxnPKg4FAj7J3MAmbs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=O0OTeJy/jDSCf25zwdyw12mWeD2tc+qxKDHECjJOIcLtWeI87L/2nh7ijbIlyIWDvPx95SfukjOEQZdMWf916LV8a/1tGi1U0ZCDO4GSAumptB2PKNu4RnDtrenPnAgLCIsFh4gW++7w0V46l3kZj2s39bPHwcVL6axSrhRicwU=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=k9VtfyeZ; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=k9VtfyeZ; arc=fail smtp.client-ip=40.107.22.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=aG2j1xD6/0OpKgCRrh2d8dpcQKU5wzjb1sCo+lbMg/n7Gwru3KNwqbApQmONtTQt1xMFuTBhLxeq3GVMcRe8fMJClWKm8npSX4iX+hLepcBt2SpNbA/Pp3DPqA5G5xvJ1G8g5dgPYyDI+V7W6BTRoiPqPUL1IkthLQREKaGVKYRh29qb+mnumINkHqOJz+7sphZ0CxmnoDvt0tKTU8FstGwqnna6Hzy3p8Lv/hzqdaST3p3QC4BuAPtP3TNPSsM7BymAfJQi9pD3yImf6q6kBEtxPFftu5Xhicmwd8kpD/7M9btlCzP272iaSZKLvftMXQzefe1s8LTiVA3T5Ke0TA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zMjEiFJDS7pfTQ12HBPYix4Wsu56U4W7SjBRDXijWKs=;
 b=F5H87Mk27sentn21TXovgU9/L3zmL4+v4Vh58+xe70aXo85ISnKGDeyh43HFj5Y4bcR3852vjqPZztq1ZoabSk/fLW4Sy5eLSRNxxgB3SbQ6x0SQsOiGVUEih9XD/u+NtO2SIEi5RhILziitV3QqIfS3jqRmrTPaGjyXJFc8J7UQXXMu5OcweYEkZ+0U3NEMQXQtrdNIz7NNu/LGjm0avOrkoow/UtHpDqEFKBfYY6a/eoWNNXDDY8/1YvGfHIMG9PIShuDrfR7QRweJblvGyZGGFVkbWH1RF/Zkcv0Lxlgr7LqYEF5M6cJv5jpij4weC2pGeiHotxECwmj5b089sw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zMjEiFJDS7pfTQ12HBPYix4Wsu56U4W7SjBRDXijWKs=;
 b=k9VtfyeZ3lyuuNbXrCKSEicvE7ljva8lMrTpanchBOgSXKqfZFsMg+nOuylzC5vt6SkKvywzpNN9WUe5gMXcy5YSDQIG99470+P8czwFgPvmcPJAKcYmy+O0PJPKER1hxVGe9RNbHBWwwlR40FD8EPxaHHLkznf3Hxa4D+jdtlQ=
Received: from DU7P195CA0015.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:54d::33)
 by AS2PR08MB8670.eurprd08.prod.outlook.com (2603:10a6:20b:55d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Wed, 30 Oct
 2024 22:54:44 +0000
Received: from DB1PEPF00050A01.eurprd03.prod.outlook.com
 (2603:10a6:10:54d:cafe::c) by DU7P195CA0015.outlook.office365.com
 (2603:10a6:10:54d::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20 via Frontend
 Transport; Wed, 30 Oct 2024 22:54:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB1PEPF00050A01.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8114.16
 via Frontend Transport; Wed, 30 Oct 2024 22:54:42 +0000
Received: ("Tessian outbound 4f9bb016c0c5:v490"); Wed, 30 Oct 2024 22:54:42 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 2d4efa4434dfa321
X-TessianGatewayMetadata: Rx3sBlQ52DKUc3Zt/UamjSRSV1wsJv49TempBwChk16twhk/pi2oNzg97zmHNbBYt9gOYIPcarHfxe7o/VaNPQiqVSIpmML8NNmK/zJvJDEic7tPGzBqG6ozWQkwrbrecHcaxAhHLPFpoXo2lGVtJ5Vho2FnHQNbNaQGxUI/Swc=
X-CR-MTA-TID: 64aa7808
Received: from Ldd73cf7404fa.1
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 3A86D0CC-2661-41AB-8984-6760F4569D3F.1;
	Wed, 30 Oct 2024 22:54:35 +0000
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id Ldd73cf7404fa.1
    (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
    Wed, 30 Oct 2024 22:54:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B8rIGdu9iEA+obyC8FqNK1/cT25duO/ioqTNIzJKGouTCneJvAHAN4g0fAV2p6ZSoNfXPzcdeQzmrrjUwGR8jcJD7t+5mNbPStnTDuwv1nOb0lRX1n9w42BWR+8LCES9tqMug9PMP+D2vutza1HXCCOIAfkWn6SAhO49P1+GrYwWw94zOoua1q5sfCPFYocciSYnCgRxIw/XIVP2b/XAY46hXbw2+yXk0E6ygurDj5YdMfJDqFTeWeYcGZQFVDcvP8ZBIK7vZhMkZ8k8kMQm33rqglxuV9iNY0xtbzYw6pezCUCA+A9kILshXYYMxHCMtWjiUWCpT6AI3Rokczjcow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zMjEiFJDS7pfTQ12HBPYix4Wsu56U4W7SjBRDXijWKs=;
 b=Y3Q/h40UJA3SSIfDDoCKwuZN+BlxtWj+ZyNtZBF0HlXHbC8CkxMyaloZDlf5Rkd6TIbHU1wZsY+rWXD/6Hf65pvHRaLBNEv/ojzzyoD+2MqumXdvYc5ti2GP7uQepUB95rmPXVJDC15roFrM4S4cMBcVsAGs79WE8SP5C2yajViks7K2bO5wNDrGO01L14vWDucViev6Zt+WNvQHxn/3Njq9nYh87zFTt6s2JSQh/SFBBu8oHDjOrUePRLgkAYkNbmeren25bPVm9sIfu7okmsZzGKawdRkzyZXEy5xXRlMSXiUOzBQyw/jvqomtPZ4W7qpdJm5ohqmJ7sUlWe9E4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zMjEiFJDS7pfTQ12HBPYix4Wsu56U4W7SjBRDXijWKs=;
 b=k9VtfyeZ3lyuuNbXrCKSEicvE7ljva8lMrTpanchBOgSXKqfZFsMg+nOuylzC5vt6SkKvywzpNN9WUe5gMXcy5YSDQIG99470+P8czwFgPvmcPJAKcYmy+O0PJPKER1hxVGe9RNbHBWwwlR40FD8EPxaHHLkznf3Hxa4D+jdtlQ=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM9PR08MB6982.eurprd08.prod.outlook.com (2603:10a6:20b:415::16)
 by AS8PR08MB6182.eurprd08.prod.outlook.com (2603:10a6:20b:291::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Wed, 30 Oct
 2024 22:54:33 +0000
Received: from AM9PR08MB6982.eurprd08.prod.outlook.com
 ([fe80::5d5d:a4a7:198c:fbdd]) by AM9PR08MB6982.eurprd08.prod.outlook.com
 ([fe80::5d5d:a4a7:198c:fbdd%3]) with mapi id 15.20.8114.015; Wed, 30 Oct 2024
 22:54:33 +0000
From: Akash Goel <akash.goel@arm.com>
To: boris.brezillon@collabora.com,
	liviu.dudau@arm.com,
	steven.price@arm.com
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	mihail.atanassov@arm.com,
	ketil.johnsen@arm.com,
	florent.tomasin@arm.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	nd@arm.com,
	Akash Goel <akash.goel@arm.com>
Subject: [PATCH v2 2/3] drm/panthor: Explicitly set the coherency mode
Date: Wed, 30 Oct 2024 22:54:06 +0000
Message-Id: <20241030225407.4077513-3-akash.goel@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241030225407.4077513-1-akash.goel@arm.com>
References: <20241030225407.4077513-1-akash.goel@arm.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0102.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bc::17) To AM9PR08MB6982.eurprd08.prod.outlook.com
 (2603:10a6:20b:415::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AM9PR08MB6982:EE_|AS8PR08MB6182:EE_|DB1PEPF00050A01:EE_|AS2PR08MB8670:EE_
X-MS-Office365-Filtering-Correlation-Id: 445398bd-e571-48c5-bbc1-08dcf935d7c9
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?jVF3gbCcPHnEAfLzsW8h6WTZOUNQKj8sDk4OvjxHNOWqYDCFqxT5WJHE0H0/?=
 =?us-ascii?Q?KX/hjmG/f5RbdOzvitOkKjrns8dKLfMX1XINaVBSlwS0bgEc6oFdRQbWIZa0?=
 =?us-ascii?Q?rfnIqwv0udr5uoLhU61R6GiqN46coXGUUCDBpBOh3KLEfvXGYRD64eC6wUUl?=
 =?us-ascii?Q?BxVQXELmgB0WHI5rLfqTl1nk7iAdhALXPr+9kQGV5Nwusi12bvMNedoYVJM7?=
 =?us-ascii?Q?nbplEXnhKs3oflrbW2KHukoo5QWaVSlAjo26KCCelrj8E+sIiIT86As3oDot?=
 =?us-ascii?Q?WoLo/l35tROZqPgVsmj7Kf6qGYhL+DKtW0W9aS7u1v/zPXu9VIpB2UQ97pBG?=
 =?us-ascii?Q?5ddPex0SzElPdbv5hAYnag65Vh8ZPjczPmqd/pj/wxM7rHgCDKANPRsb39bR?=
 =?us-ascii?Q?z/K5ZFdToTNVrKqBzeHgmE1Gc6U23nY9Fj0pAb1dg6gDO5ub/Dk+iw0f4R7N?=
 =?us-ascii?Q?43cIf7E/C1qt3HHM8VXnUD2Z3gRjnAoTiTMsqPx6JVcvkmVoiJkzHsPNAtlz?=
 =?us-ascii?Q?2J21C/GrwPDeatGh5CksJU9uRLCIja/AhU1WWGBsvyB1qIQTP6ic+PP1wW9q?=
 =?us-ascii?Q?TgYYoC/2QiQiXm6Oa04DSIhsh9ilYu7FBGG9QnJPrIkfaaRv6+CTC2OfMJd/?=
 =?us-ascii?Q?Pyjm1PORmA8nZ0YoVgzZdxHzXGmPCBcCnkT1pYPKblb/RZ2HeYHhpnPfItVq?=
 =?us-ascii?Q?ZMAuQRlpaApdWc3XxN6Sz9bSZ3KSom93++TWSJqLDB5lgH/w1DwCw4A96ErH?=
 =?us-ascii?Q?2rz/FCYQJsfpgB6cs4tU0FWHJlQr/IVCbBMO0UmrokN1d+9JWdKtVkE6+fr4?=
 =?us-ascii?Q?rY8UBFPpdxgG0/CQqr0tjqBHBAPKCk+Cu4LSAvV7xo4+3OBinr6vsRJ5jYz6?=
 =?us-ascii?Q?8Ouy7v8YvzKow0EpmIVAPyyrnXPXWVm9RlH1ziBHfwqq0E2/03vb+CBAFnRx?=
 =?us-ascii?Q?xqcRujn1F8Sugdgp1pf6FlIV7rfcsLLK8lVdMRG8w+LXg61y3/NXtDaP0TEd?=
 =?us-ascii?Q?REiKrhIGs23EdcZQGyZii7aeeimkeqQ3Oa85OjsPIjQO0MkyepbN7nc9Exkw?=
 =?us-ascii?Q?bdV9tZIIGBH34JbuZ5kPKSClQ7Hu17Lt1N+Bsxj9hWi+b68bMSAIPIMfHOjp?=
 =?us-ascii?Q?SLhS/jSn1whZlojrnkGE5edC0aTzLy4OU09jRRF1gDf+cwB7YkaNZ/ENNxSb?=
 =?us-ascii?Q?23sWWSUtocgm8Utu21EQhsPYtI1xhV8IMX9eEWSjq2QAZ7wt2nCn0m1+/y5r?=
 =?us-ascii?Q?Q80TVU81pzXIODo0f51y6ax9IhFBo2mh9aST9wM6HKBrn5LpN0YOlRIaLtK4?=
 =?us-ascii?Q?6o0=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB6982.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6182
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:20b:415::16];domain=AM9PR08MB6982.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF00050A01.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	7fbaa608-e7b4-4f46-3ab2-08dcf935d231
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024|35042699022;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uoJKw4AJ+/kDhEECmoG/XUy9JY5RvlZkmHvEi6PhkuSk3PCRwz7CgjnZSEkV?=
 =?us-ascii?Q?ePJeE5AyasudhavbFTQyA5SxYnh9OJnq5XebbmpR34QLOMIrezufhkujMudh?=
 =?us-ascii?Q?/J1wuPQ+8KuNiHB8SEhtWcBCklzuH5u3Xa9BJcvSCiKZTlT31tsm3Yyi9V8l?=
 =?us-ascii?Q?Q1Te0VwmHBuz7FJqK87dmN7T6zuW88p/T8PqFyQ9CtOLgt5NWM9w/kaajSJA?=
 =?us-ascii?Q?IyHf5jF8q4P2h3mD8sueM7UCCZnq8j4O9VEHGPV4ST4Pyf5cjtxV87a5HZjn?=
 =?us-ascii?Q?RuBh0KmJXWCQWRCPQZf4piXpFURTF7phZZPqXyHRLN/9wHxuGGXFanhOTW4I?=
 =?us-ascii?Q?LcVxgnGSmA5mfgG2zYHZVaK67z0MqTi5XwKuYrhFSEKi4FyoVJuCRh6RlwgS?=
 =?us-ascii?Q?czLH2gqciAJeSgrcns2B+7wgiv0JKg8ihTzOA6+FG2CNP6DC0RN/qpND4Ygg?=
 =?us-ascii?Q?WNdKIkTVz3/wk+/i9VY5bgiF7xbr07q/d6PO3vYRp3hKd4GjBYxRHhG3JF1A?=
 =?us-ascii?Q?sz7E8pXEz+LeXKTs8EC5LEvIlBbwlz8270SBbt4G3CIkuy9ixDvqdOUARoXk?=
 =?us-ascii?Q?yriMRWlVzkdOG3w6JmmTVnom+DY1O5KTJpMYDIlfDAIrrVH/sYXVCkDrJ7/z?=
 =?us-ascii?Q?NJhZQOtT/gWZs5eYHabRvDNoMzRPPwcvoEc+1VhzTFbHYVp2zxlJrV61hq8N?=
 =?us-ascii?Q?NN/kxnJu4CVIxbul51ctpaxLzrr4A6lZfHk9y++YiNs48xxOV44brWcLDbaH?=
 =?us-ascii?Q?uH/vtxwDKvlemN5LUhyAy3XEzFL3jfPWoVw1shgvpdqK+4PuyH3fBETUl/gz?=
 =?us-ascii?Q?K6AEiOKd9qp0sr1zn9tzn5kZ9nS2QHOZw3AUo8y14sqdp3FeLpT7pYtpulMG?=
 =?us-ascii?Q?J+PY+aD3pvLcBPMzD8+TdgpH1Iu9GP5TRToauzcsWbuPsmRXSdXZ0HSWO2I1?=
 =?us-ascii?Q?EXNbLXXD1bYb4YDz9zZiATyWSfYGdMtO1iy+NcS6kVYFlT8WOxhM5n0qJtsF?=
 =?us-ascii?Q?i8Dy3AmiNxNFseqk9zf3+B5ASEmx2UffSlQ1Jk0mqBzZNBM250f/AZb1mS4+?=
 =?us-ascii?Q?wiRIgzNx8yeQ/y/p60W6LDmwsYeVnTwdaC6MmxUcBYhC3PgEKgA0f/QN8rPn?=
 =?us-ascii?Q?60NO7tx7409QGkWov/1tBgobV7mh6w1d7P7tLz7PzTp9gE11MxdtOMAwKJ4J?=
 =?us-ascii?Q?yyHo3xSSqA6t5eG/syyHNOOAl7AtYHa1pxfEHUDw6eV7FspvB3TArMrUDsTO?=
 =?us-ascii?Q?4qxCQmRGSTRs+qvLrnf+m6YdL+QFf6DvpBClsmI03vVc0KCx5V2X6ebH7DMJ?=
 =?us-ascii?Q?cNUcm9lIN+BELf4rEweTnCrgfBGDgxDRTIyVKPjyNU9ohIH4hDgdK6W2LvHT?=
 =?us-ascii?Q?IgsVxhto7NCClRSTphpdma6v0KWMlV25gYudSTpGkuyUJ+4qCQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024)(35042699022);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 22:54:42.8672
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 445398bd-e571-48c5-bbc1-08dcf935d7c9
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF00050A01.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB8670

This commit fixes the potential misalignment between the value of device
tree property "dma-coherent" and default value of COHERENCY_ENABLE
register.
Panthor driver didn't explicitly program the COHERENCY_ENABLE register
with the desired coherency mode. The default value of COHERENCY_ENABLE
register is implementation defined, so it may not be always aligned with
the "dma-coherent" property value.
The commit also checks the COHERENCY_FEATURES register to confirm that
the coherency protocol is actually supported or not.

v2:
- Added R-b tags

Signed-off-by: Akash Goel <akash.goel@arm.com>
Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
Reviewed-by: Steven Price <steven.price@arm.com>
---
 drivers/gpu/drm/panthor/panthor_device.c | 22 +++++++++++++++++++++-
 drivers/gpu/drm/panthor/panthor_gpu.c    |  9 +++++++++
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panthor/panthor_device.c b/drivers/gpu/drm/panthor/panthor_device.c
index 4082c8f2951d..984615f4ed27 100644
--- a/drivers/gpu/drm/panthor/panthor_device.c
+++ b/drivers/gpu/drm/panthor/panthor_device.c
@@ -22,6 +22,24 @@
 #include "panthor_regs.h"
 #include "panthor_sched.h"
 
+static int panthor_gpu_coherency_init(struct panthor_device *ptdev)
+{
+	ptdev->coherent = device_get_dma_attr(ptdev->base.dev) == DEV_DMA_COHERENT;
+
+	if (!ptdev->coherent)
+		return 0;
+
+	/* Check if the ACE-Lite coherency protocol is actually supported by the GPU.
+	 * ACE protocol has never been supported for command stream frontend GPUs.
+	 */
+	if ((gpu_read(ptdev, GPU_COHERENCY_FEATURES) &
+		      GPU_COHERENCY_PROT_BIT(ACE_LITE)))
+		return 0;
+
+	drm_err(&ptdev->base, "Coherency not supported by the device");
+	return -ENOTSUPP;
+}
+
 static int panthor_clk_init(struct panthor_device *ptdev)
 {
 	ptdev->clks.core = devm_clk_get(ptdev->base.dev, NULL);
@@ -156,7 +174,9 @@ int panthor_device_init(struct panthor_device *ptdev)
 	struct page *p;
 	int ret;
 
-	ptdev->coherent = device_get_dma_attr(ptdev->base.dev) == DEV_DMA_COHERENT;
+	ret = panthor_gpu_coherency_init(ptdev);
+	if (ret)
+		return ret;
 
 	init_completion(&ptdev->unplug.done);
 	ret = drmm_mutex_init(&ptdev->base, &ptdev->unplug.lock);
diff --git a/drivers/gpu/drm/panthor/panthor_gpu.c b/drivers/gpu/drm/panthor/panthor_gpu.c
index 5251d8764e7d..1e24f08a519a 100644
--- a/drivers/gpu/drm/panthor/panthor_gpu.c
+++ b/drivers/gpu/drm/panthor/panthor_gpu.c
@@ -77,6 +77,12 @@ static const struct panthor_model gpu_models[] = {
 	 GPU_IRQ_RESET_COMPLETED | \
 	 GPU_IRQ_CLEAN_CACHES_COMPLETED)
 
+static void panthor_gpu_coherency_set(struct panthor_device *ptdev)
+{
+	gpu_write(ptdev, GPU_COHERENCY_PROTOCOL,
+		ptdev->coherent ? GPU_COHERENCY_PROT_BIT(ACE_LITE) : GPU_COHERENCY_NONE);
+}
+
 static void panthor_gpu_init_info(struct panthor_device *ptdev)
 {
 	const struct panthor_model *model;
@@ -365,6 +371,9 @@ int panthor_gpu_l2_power_on(struct panthor_device *ptdev)
 			      hweight64(ptdev->gpu_info.shader_present));
 	}
 
+	/* Set the desired coherency mode before the power up of L2 */
+	panthor_gpu_coherency_set(ptdev);
+
 	return panthor_gpu_power_on(ptdev, L2, 1, 20000);
 }
 
-- 
2.25.1



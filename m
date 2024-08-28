Return-Path: <linux-kernel+bounces-305426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F243962E75
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 19:27:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30668B23973
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 17:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2EDC1A7077;
	Wed, 28 Aug 2024 17:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="kGg8/Kny";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="kGg8/Kny"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2070.outbound.protection.outlook.com [40.107.20.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882471A7043
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 17:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.70
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724866049; cv=fail; b=DAaEIZPHnsYyogCZ/42GqwFR/lRGsWKVd60bgcbwxr9GvxYAxFi/+Fa2GB5fcMqR81Kt0I0Tgg+zip7luqV80kF4G1QiKb+3qiuzc2EbfITFj0haVGTEpTsWpb0ksa0WmhLh5nAOhZa6WpHy2SI8D/hQT9Pket2b+MY8ARwx940=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724866049; c=relaxed/simple;
	bh=QVC/HmalOpJvTf/KVsEFN2MQ+AdkquZ8baW3RYELMT4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=f3aTaoyD+N9JUd+kPsOLUEdfLlRYGfu35KFSvObmLVWGn6ZxwNm1RET35m+0PVyqgcqWDukHidn4c47xeVG/tJ8bE4Hr8Nw4w8+HGF6cQQU7przqASBQGObGoOdas1XPkprIX+BkYlsr3CK0bdGmvZavlpR+V6Et4fGcgn+JEEA=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=kGg8/Kny; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=kGg8/Kny; arc=fail smtp.client-ip=40.107.20.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=F2U5F736ysAlP9ja3B53QZepO9aoelI6sAgfWXaA7XKoZB439YsBf7kC9Rzh4Fej/5YhToP+I/zEAw3aok3yp3u3H/oWiBHD4N0tLLQYEVr5HI++joMN9KS5bNkxox407OvbD2kk96b9FcQSqHnbyCX1y7YZp8BhYdrf/7NkIzbIdvEED4CXdzX4pDDD4tFNuhKQ1tFrEj2veDZ4c6TiwBO+wZPqz8Nue/40juvt3rIzhLvbvmVKYUEJxQspzt6aM9rx1ghGvLR7JjOjA1SyZpeN7ehEZ2NCjy/zKkFJx56DbqT/8Fwd7UsZJUFqLE/2OQyQLpJ7wOjrwSv0VlXv3Q==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bISh8gDHA2aB6rJ/FU9XT0iKSAxjuwvzXzNlpSL3RQI=;
 b=PENkHX9E8bbK+qL2GlKtR9CgufJ+QVfCDahQGzoGuwk8B+AGPOWS6F7rizses0+lSysBPjk8hxyRj7OTqsOXzfFRWU8as+GjbnWluVcSMalSF3BPrKjY3STyHdN/i0j1d/xILI5uGnEzRffBFqI6Y8RERYFinfZEUZ2qrLthjsxxtkrACOLUVVdad5v/F5APLzJu3eFWvzA9mtYQJRLdH7I0OhDUgZeCV8XyVrWORb4apwGLPS7kGptLE+sPgm7aHIFmdwcfwPouHLgCqpOtdYDth7U/WkIBPmOvRWAr9UexHf4/kemzYde5u1wZQVAjcOD5t57rW56djNSP6zJOzg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bISh8gDHA2aB6rJ/FU9XT0iKSAxjuwvzXzNlpSL3RQI=;
 b=kGg8/KnyBJpeUMmlWzCOQXctJTks+PDmmKatJsjDzPS9AR+1P6TIJIl6Uv5Lc280xIUXilZdjzLB3WP23s99feLbTA15ItyUVnuFZ3N4/bk8/A1mvGl5Ml1AxxxuHqhhoTR14Xc4zTU5NE7lT4E9/W9vEtO0LUfpsKBHG2+Y04w=
Received: from DB7PR02CA0019.eurprd02.prod.outlook.com (2603:10a6:10:52::32)
 by AM8PR08MB5809.eurprd08.prod.outlook.com (2603:10a6:20b:1db::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.18; Wed, 28 Aug
 2024 17:27:23 +0000
Received: from DB5PEPF00014B9B.eurprd02.prod.outlook.com
 (2603:10a6:10:52:cafe::32) by DB7PR02CA0019.outlook.office365.com
 (2603:10a6:10:52::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28 via Frontend
 Transport; Wed, 28 Aug 2024 17:27:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5PEPF00014B9B.mail.protection.outlook.com (10.167.8.168) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7918.13
 via Frontend Transport; Wed, 28 Aug 2024 17:27:22 +0000
Received: ("Tessian outbound bc251c670828:v403"); Wed, 28 Aug 2024 17:27:22 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 2eba0d675f59de90
X-CR-MTA-TID: 64aa7808
Received: from L738b975a3c72.2
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id F3E66A33-4DC5-42D8-80B1-9C7B4D8BCA14.1;
	Wed, 28 Aug 2024 17:27:15 +0000
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id L738b975a3c72.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 28 Aug 2024 17:27:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oTpGFBU4ylFc7VDxGevQCl71FXDYTAZjlYniIVIix1X0v/cvJvvh1+jrcNI9plYGCez1Wq/4PdZCgVWsGoZzFnkDpr1lCOgYWtvR84+EpQtjSK3KJQj2fUNn+1vBPOEbApjsTxbxtOfGQRoz1WfdpkM0iX5/JLC4jNAe4g1M8/cdF/EKiOHAe5DU7r+ncsv6NgI4771+BinbBAMCjoUARCpEVpOHAYF83Jb8Ah6om7JadYzUvLCdFzc5hKieKxH+F858xRtj0i+F6kuza+7xyr1TEFanwiR9fePN4PRJR6eGn3yC9weQ4IQI88ZBlhzyXFvlCVme+g7SDtza/w9DZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bISh8gDHA2aB6rJ/FU9XT0iKSAxjuwvzXzNlpSL3RQI=;
 b=jy+NCMsX3EkGJR6/Um9e453bV7Wln1h6gzyZQZz037nsZbQWNyHinQlwdQ8434i2dF9As1Kgzu9EObzsmbWiOZphz+lOIp+41EmH2KAHwfeAVod5UwgsWZIRw1Rm6G/aqiWZV7cHVaIyt1FjTaAd0zAh6CSz4aiEzoCYPIVV9vPlc5YB2XKjkZvRvIxt+P/zlBHFW5RvoOFoMGDMKL+czeFFdoMthx36of1NMuA6JoCC0kjBttEIhWdefskMxIpz8173Iq3Xxe9UYLYJJDaz3+295Ng/xDq+RETN8qFDcc5UHKF2LWCml6KzXiet2MCROjpyXEtAy9ibR1DtSxBNAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bISh8gDHA2aB6rJ/FU9XT0iKSAxjuwvzXzNlpSL3RQI=;
 b=kGg8/KnyBJpeUMmlWzCOQXctJTks+PDmmKatJsjDzPS9AR+1P6TIJIl6Uv5Lc280xIUXilZdjzLB3WP23s99feLbTA15ItyUVnuFZ3N4/bk8/A1mvGl5Ml1AxxxuHqhhoTR14Xc4zTU5NE7lT4E9/W9vEtO0LUfpsKBHG2+Y04w=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AS8PR08MB6263.eurprd08.prod.outlook.com (2603:10a6:20b:290::9)
 by AS8PR08MB6551.eurprd08.prod.outlook.com (2603:10a6:20b:319::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.18; Wed, 28 Aug
 2024 17:27:13 +0000
Received: from AS8PR08MB6263.eurprd08.prod.outlook.com
 ([fe80::12b5:3f0a:2090:fa7c]) by AS8PR08MB6263.eurprd08.prod.outlook.com
 ([fe80::12b5:3f0a:2090:fa7c%7]) with mapi id 15.20.7918.012; Wed, 28 Aug 2024
 17:27:13 +0000
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
Subject: [PATCH 7/8] drm/panthor: Add sync_update eventfd handling
Date: Wed, 28 Aug 2024 18:26:03 +0100
Message-ID: <20240828172605.19176-8-mihail.atanassov@arm.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240828172605.19176-1-mihail.atanassov@arm.com>
References: <20240828172605.19176-1-mihail.atanassov@arm.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0596.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:295::10) To AS8PR08MB6263.eurprd08.prod.outlook.com
 (2603:10a6:20b:290::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AS8PR08MB6263:EE_|AS8PR08MB6551:EE_|DB5PEPF00014B9B:EE_|AM8PR08MB5809:EE_
X-MS-Office365-Filtering-Correlation-Id: e6153375-e716-40a2-3c54-08dcc786ad6a
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?tk43Yx9zNIgKswtzWoTtsvQUXlFt13pQTi07QyUf3hqqW43Wk3mqAuM9NBOu?=
 =?us-ascii?Q?kecATUoBWui0cxKvftvz1GLHtNdfiW5yeVcAU4YG6grP+e4dvAVN5+wQaBVb?=
 =?us-ascii?Q?FZiEqr0/FlretXiU/iPPLTN+tQCzZWg3wDH/m+zeQwpiE4DCGRsn7rbc6yIC?=
 =?us-ascii?Q?Ptxn0f+MoMTnyv8Jz6VjVi4kuUe4OznsXc6txSDT1wog9VUj+b/lTgLj+W2E?=
 =?us-ascii?Q?0pe29zCXj2Gu19PVKbDteE6e7WvHwXDh1HP/Xp0/Ep1ujJFkgajSQvah4Q6x?=
 =?us-ascii?Q?qKjuaI+oPIiD/0rn3R+NIOIzer2jpw4hwob+PZDkzrZ0eO6hWKb80mNR39Pf?=
 =?us-ascii?Q?5B/p5RPNgX7nwi6TmxQcyx91cWGZ8irqdXZuBnriqUtXW1RvlqjNzk+DU+A7?=
 =?us-ascii?Q?rUxSx93pC82Z5agDUJRgwfcv77T1b1zabDmpwolIIvCWxazAAlBwcthiIL8T?=
 =?us-ascii?Q?9ltuBMLAdG+Hsdg40sd0jcA7bbAnVnEOU9GQAUNTtBsQeUl82Abo38ovN3Bs?=
 =?us-ascii?Q?qVyvLW/opSP0sWyB+mbWGR/MvefKSvkM5pTS6nLQj08BElyFeKucZDx8Drvf?=
 =?us-ascii?Q?NoKzqZLJZeHoOJEJbJEgVyi/ziZocVvXj3c4Mi0plzGm2EpUwNvwqFJoc1b4?=
 =?us-ascii?Q?l+sn7gzXiXciQzufuduxQR5ai9A0JWV9qBmMftXbDpEWfMFnoOX12QpqMTa7?=
 =?us-ascii?Q?76O93UzzqenSdXtKGUuoHUAwDBkeRDHvdduJS/wn9ICMsm85FlavitsX22w5?=
 =?us-ascii?Q?4c3yE2Obm5ZJRaM3EgK14R8eoX4ApoufQOWSYna2Kwf1qd7J8sCBmtdTndg1?=
 =?us-ascii?Q?yXlkImY7VNnzXclQJw5UALzZ6kFP9ns9YOrmj51Gfqtur+9+4qTNZmpnSorM?=
 =?us-ascii?Q?HR9/tIJhXziB2F69DIk1DStKn+A8LfTDeumJocbJzuDOCkSnCeyTdt759GD1?=
 =?us-ascii?Q?zwcd6BiREt+N6QG+lIY3PhKICBrw37bT/4yycI7/cBqi5XsWT3RuKe8IujIB?=
 =?us-ascii?Q?BO8hX6LiluZ4gZe27y4dcfQWcoDzmW7/X0cKRC56ofuPHQCfjOWdyXjpO8Py?=
 =?us-ascii?Q?1SZPZSAOUbnhhucShZ19cFgoEPi/CJw6y3gHzf87C1VvxPmOciTjn5/KlKK3?=
 =?us-ascii?Q?kj33TnFkNjy2k6i/Y5iGhtT0f2CF+GE/4GottK7ConNEk305vxImidHnqQOG?=
 =?us-ascii?Q?reHiSY1u3C2UL36+142uEntBevP3iLFD3j3NPvI52qfOJrD5U+eH26wsMcJq?=
 =?us-ascii?Q?PVUbju7BjGDzc7gnfr5GjEfH6S4Fce6OydLmUm2Bk0qXgYtF1tpZ51lUHOgV?=
 =?us-ascii?Q?Jfr8g1NQvV0cvjY3eM+wGp4p3VEzqhMM9w2/jA/hA+8AQw=3D=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR08MB6263.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6551
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:20b:290::9];domain=AS8PR08MB6263.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB5PEPF00014B9B.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	b5e35f7c-6a63-444e-c411-08dcc786a7fc
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|35042699022|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IXBtTczd2sb4lC1N6j0Sr2FYBYjXDCYs/859w8dG09dQBjWeFlvw/tRzKG+h?=
 =?us-ascii?Q?7OBaXyrE/OLUZaunlTRgS4pNnzm+eO5QSuN4b+NobI1FR1hB/XiOHq+k8bxx?=
 =?us-ascii?Q?ZeQ6CVdzSbMjKBrna7yxDzr5XtLj4XPEDMEJIvljhi6shdpPMNuzvNSpGJld?=
 =?us-ascii?Q?1EcQrrLtzO2ZPRalRtOGc8AbT8B69ZpdhTy+WmV+weshysCMheoAUH9j3QH/?=
 =?us-ascii?Q?BjCupIVBgDIIowP5a/xekErC4/1gonW46bakvCid8yckDJ7Oa35roYqnX8hb?=
 =?us-ascii?Q?TikH60msYmcAhswybD27XkkEwiqkAOKtg/BlzAoUwdym5q9Gu4EgboIo/FPL?=
 =?us-ascii?Q?HZUKfVx6yDI3xxNRxd/38l+PjossjMAT2d3PFfCNZWIHj1EiJyaHzcw43BkK?=
 =?us-ascii?Q?PwT8lTyt5EWu+Omx7Vrcw8RTohLoiKkvutmOBf3XepxBeq7sTMehCVD949CS?=
 =?us-ascii?Q?rNG76+Url6C0F+x/FO+UtI8QHsXWC11xqGdgbg04D/a+gj0BIyKmNMZidRPs?=
 =?us-ascii?Q?iAFwIN5Gw5YUKPaSaWVG5QQwt02fz6z5sjYZ3airpJhQagOucv7XcvBcjhah?=
 =?us-ascii?Q?TvJU7gNrVvknOKK+kP2/XCUPvqQzIzM0xPXDZK+5LLp8wqI7VdsFBG94rF30?=
 =?us-ascii?Q?cJ1aqJaxKWZPbRF89ku8q0iJIMA7Z4yi90zmjCfOebuYVjzDPwanLNfrsTPM?=
 =?us-ascii?Q?wAi2nuXsqBQ8R8KLysfy2XbDaLmw8i+QFeo4dgOgPZK7PPwbYYbgt7KNUJFn?=
 =?us-ascii?Q?o6vPkK4twaE0CYUgAWqagIDlEOIkAxMBExvXN3zESu/uCSR0uba7c6TcrouY?=
 =?us-ascii?Q?a749gU94qp9J5Z7h3BP36STiQWznaQtJOwBDJi1x3Hk/YBTSr6WeWkbkCBDI?=
 =?us-ascii?Q?ojNexZp18d6n254w/0ezEL0HjbYNHxqpcPushU6W4eDJXIk19QCrvixSSzVU?=
 =?us-ascii?Q?kQUoORGkOssatjOnzPGkezYBEqn+ATyZMv4QiGRgi3MXvWDSc+/mY7jAYrvl?=
 =?us-ascii?Q?4Gz0aFuKMNdKDycy2B9i6FfS/tFszAWh/dUleml2odabUdwA+73bhX5ehFpB?=
 =?us-ascii?Q?NDiNpjFnLU8QaaN455gloVwxj35I8Rm4v7V9YkGKFTL7nY/tiR1WSKA+Mejx?=
 =?us-ascii?Q?sKd5ltpnlsTx6oAxBC0KVg/uRWo0u4POABc933GLYTW/doUCaKWn9IPk7wUJ?=
 =?us-ascii?Q?7G4r8b65K0mJhVRoQbXi2OECap12ZNB+ssm8lh1/jtIRyTVzaS58sg0SrGJw?=
 =?us-ascii?Q?LUlHIOdDwvRLgqswT2SEaTYbWZ7G/0xV3Ql7VEziiOjxvtYC4DC9GrIzGzNA?=
 =?us-ascii?Q?hXRsuL4qwK9ui23eVuof/j0R0DHCT4hiXEl4vjPdudeQRvdCLX9wyZe8QY2o?=
 =?us-ascii?Q?FO8Rp0WeCmthPQQyFuqn6V6zGomRGH9/vqr3L8O3wY7Edsh1o7mPMuMNlSYC?=
 =?us-ascii?Q?X5EVzZyGWdJTe/aSJd2vmizBvckCQT/I?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230040)(82310400026)(35042699022)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 17:27:22.8264
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6153375-e716-40a2-3c54-08dcc786ad6a
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B9B.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB5809

Expose the SYNC_UPDATE event to userspace so it can respond to changes
in syncobj state.

Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>
---
 drivers/gpu/drm/panthor/panthor_sched.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
index 92172b2c6253..67c27fcc3345 100644
--- a/drivers/gpu/drm/panthor/panthor_sched.c
+++ b/drivers/gpu/drm/panthor/panthor_sched.c
@@ -643,6 +643,9 @@ struct panthor_group {
 	 * panthor_group::groups::waiting list.
 	 */
 	struct list_head wait_node;
+
+	/** @eventfd_sync_update_ctx: eventfd context to signal on GPU_SYNC_UPDATE */
+	struct eventfd_ctx *eventfd_sync_update_ctx;
 };
 
 /**
@@ -797,6 +800,10 @@ static void group_release_work(struct work_struct *work)
 	panthor_kernel_bo_destroy(group->syncobjs);
 
 	panthor_vm_put(group->vm);
+
+	if (group->eventfd_sync_update_ctx)
+		eventfd_ctx_put(group->eventfd_sync_update_ctx);
+
 	kfree(group);
 }
 
@@ -1501,6 +1508,9 @@ static void csg_slot_sync_update_locked(struct panthor_device *ptdev,
 		/* Rerun XGS jobs immediately, as this can potentially unblock the group */
 		panthor_xgs_queue_pool_recheck(group->pfile);
 
+		if (group->eventfd_sync_update_ctx)
+			eventfd_signal(group->eventfd_sync_update_ctx);
+
 		if (!group->user_submit)
 			group_queue_work(group, sync_upd);
 	}
@@ -3204,9 +3214,18 @@ int panthor_group_create(struct panthor_file *pfile,
 	INIT_WORK(&group->tiler_oom_work, group_tiler_oom_work);
 	INIT_WORK(&group->release_work, group_release_work);
 
-	if (group_args->flags & DRM_PANTHOR_GROUP_CREATE_USER_SUBMIT)
+	if (group_args->flags & DRM_PANTHOR_GROUP_CREATE_USER_SUBMIT) {
 		group->user_submit = true;
 
+		if (group_args->eventfd_sync_update >= 0) {
+			group->eventfd_sync_update_ctx = eventfd_ctx_fdget(
+				group_args->eventfd_sync_update);
+			ret = PTR_ERR_OR_ZERO(group->eventfd_sync_update_ctx);
+			if (ret)
+				goto err_put_group;
+		}
+	}
+
 	group->vm = panthor_vm_pool_get_vm(pfile->vms, group_args->vm_id);
 	if (!group->vm) {
 		ret = -EINVAL;
-- 
2.45.0



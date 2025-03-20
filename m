Return-Path: <linux-kernel+bounces-569571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 578BFA6A4CC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 12:20:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE63E46028B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 11:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C04922172B;
	Thu, 20 Mar 2025 11:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="VmU7/wtf";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="VmU7/wtf"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2053.outbound.protection.outlook.com [40.107.21.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7C3221546
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 11:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.53
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742469504; cv=fail; b=rpFKMgS7klVVOCW8xgB5tr47mqUcD30VrKEqEqH7SHa6s0SgXEQtEl8Y01rSar5TXXLwJXT5hQ5sW871C6MvLM2gmqRkPIGIgCU+cn/R41DySIbKlrJVTGmo55toWTALFDx59AUfT6PzgOTX/PnI06oh8YYfMTyxdsWQD3ZS12k=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742469504; c=relaxed/simple;
	bh=raaCU434ASnPS01CFmHdYzehaMcTQXKgLtY1lL6agxc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HNWVKIJXplNA2hHD7E0kvA3jUuJ4WKVM7gkHcAEAnf4YsoGvzF8CYDwL1l7jbOQwBOuE1YxHxZofkI/Q1ZMm7TFuCStotQ+5GsHr6SaduW//4XNyBTkcUb3BzxYZR3ahkQbuXkOpVLogpKpfw5kYjBP5kpQuZ53LvZ+EUlPYxrE=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=VmU7/wtf; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=VmU7/wtf; arc=fail smtp.client-ip=40.107.21.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=bIjfQDWo/7nit3gTaXDiy2BFqI8tZcV2mOH0TpWJXFcB1YvohU6WvO4g+E21e8PkgrmIuwALo9r0SGuEOfxsibZFQMTGu0n0QM/4ZA4/mas7K/YhTHfTfCdlPisPNX0GCmTXO2Ccp2NO/1kAOAAZtSIER/76qHc9irO9e9S5ns1mNSocGBc58A1agYMgpPUJa6p8N3zJDKB0y2ig1TyykFPtbHekTu7hVhSvJRn1020cH5skwo3g9G+5V+1ntaDa8G2FLq5BCerGcpb0EhN+XsTTS2KLdfWUW1yN8HEwo2QbjBHV2WAXkRyZexbttpbXp6ML0Yb1HIiKjUU2tUoT5A==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f2G4dnHPG+/Jbtvg6WwpbH7GZ9NIWomafe+0TBZXYf0=;
 b=gCOdy+wMo8s4XT/du88FXH1vtfSRKc5DUsCFo1o20m3FWnMVio5FC7GjKbdrFk7xOKZUORy580ELBfxWdel/4J+k0tLbZWFfhfk8DiqdZIGFQTOrO86ERCMfKxbO1Bt7OWSXAAFk8JNeItxPPB0CmGeFpj8aqbvIu4dErQwPpETPYulVO0zReuLdSqqosyWYTZWz2GTndiIqv3Bd+3DyMTdp1b/WsmnkgVV+JOQL3tHk+wBrx1PA4atE3pWAeH8lfC+O+67fs6cXApXHW6BHFYQsJ6+uRMtUpiz+s41bsUO79a8ibU7WobJMHv9AWkJo8j4wEWfpCFyN0l7q1SL5Bg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f2G4dnHPG+/Jbtvg6WwpbH7GZ9NIWomafe+0TBZXYf0=;
 b=VmU7/wtfsxygXGR39vBasoS0S+ri4ZMNf7IA99m82YLd7cs6JiNegzKfs3UbqcWmJEoYD2qhrfF9xs/w3jFFAN4bLN4tQOtLV6RDEaHLcsNxvyQOOzcggm3dZ5UpKE/mXs0ycDrYXIuFAywmT8LUlNHWveyhUg9vNayMa9poZYc=
Received: from DUZPR01CA0216.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b4::14) by PAXPR08MB6541.eurprd08.prod.outlook.com
 (2603:10a6:102:15a::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Thu, 20 Mar
 2025 11:18:16 +0000
Received: from DB5PEPF00014B91.eurprd02.prod.outlook.com
 (2603:10a6:10:4b4:cafe::7) by DUZPR01CA0216.outlook.office365.com
 (2603:10a6:10:4b4::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.34 via Frontend Transport; Thu,
 20 Mar 2025 11:18:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5PEPF00014B91.mail.protection.outlook.com (10.167.8.229) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.20
 via Frontend Transport; Thu, 20 Mar 2025 11:18:16 +0000
Received: ("Tessian outbound ed5a7291b0f8:v597"); Thu, 20 Mar 2025 11:18:16 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 457d5d99dff2f2eb
X-TessianGatewayMetadata: gwiPtrxeC3A+4lKXFsalqXJHQiC0hVyDYnYZtPQ/FlTxvafxRErMoYYJajleu6wXPyUILtDrTUCfKh953E66WSeRJVNzgYrTaVYMMz71C1cparlo9YQvh8xFVgUhwZC4m/yjClV8UI3Dfy4eY0Dxd3O2V3TlYR+8D6Y1Kx9oxAE=
X-CR-MTA-TID: 64aa7808
Received: from Lb4d8711e3bea.7
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 0369B50D-4125-483D-9009-3E51DA6236E7.1;
	Thu, 20 Mar 2025 11:18:04 +0000
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id Lb4d8711e3bea.7
    (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
    Thu, 20 Mar 2025 11:18:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FT89JDMVmYlC/LiIWsrfr9nh14V3YcKwzuBvmkbc29t8cEe39IHuLDK8CbmfUuJH/mj2EYnGC53txanZTRsug0S2Q7838spnI9dfiFFma+7kSWT7z1suhrl1q8ibNHjDgGnhY8jgz0BhcKwMS20wSL9x/gOxEYKE5obvBQEVLczgSU9sjY947TUkSseTl3SQbEgfk74vO562a3fGbEhuXepup1glj8kgVXlxu48TaKh8RcAJFqn0eYIahx+vLgu7QZV/fhtdvaqTF7IONRlNguI3PzhcNB3cVPxOfmL+Uvul6lvzjd5wp+CFMCjI5bkRmmVL1y2P3euFYLEwt+5yBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f2G4dnHPG+/Jbtvg6WwpbH7GZ9NIWomafe+0TBZXYf0=;
 b=VduVFcWiU8/IgPTuccESf8O8Mc/1JtS6iK4SFo7joJO8T6vzbQq+VngVRdWufrYFvg7eKpzFa61CVi7AsfSyZFcrI+4NjBEEvKY+XYoP1aEQMweabt8uR5Y1dFwJ80WCIVn53hWWV4tUasaO1pdyebI1dubi0I8SpQJuuUsThzp3g7lD8gFtsNXxwnhTjSc60mAtFAYiiQKmPV1tSKf+NZKFjZhF6Ccs0isP2g0Gb8QYTlpVdhr/y+Mnq1WSOfkth52hxU9s5hYnZdLQXBe58p6mXFSp+mvZPHJUUTdOtcyrTBW/U1v7y3x+cvJS0bSCeq/fqN6wsDITzOzFj0ra0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f2G4dnHPG+/Jbtvg6WwpbH7GZ9NIWomafe+0TBZXYf0=;
 b=VmU7/wtfsxygXGR39vBasoS0S+ri4ZMNf7IA99m82YLd7cs6JiNegzKfs3UbqcWmJEoYD2qhrfF9xs/w3jFFAN4bLN4tQOtLV6RDEaHLcsNxvyQOOzcggm3dZ5UpKE/mXs0ycDrYXIuFAywmT8LUlNHWveyhUg9vNayMa9poZYc=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18) by DB9PR08MB6715.eurprd08.prod.outlook.com
 (2603:10a6:10:26f::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Thu, 20 Mar
 2025 11:18:01 +0000
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::d594:64a:dfc:db74]) by VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::d594:64a:dfc:db74%5]) with mapi id 15.20.8534.034; Thu, 20 Mar 2025
 11:18:00 +0000
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
Subject: [PATCH v2 6/9] drm/panthor: Add support for Mali-G715 family of GPUs
Date: Thu, 20 Mar 2025 11:17:38 +0000
Message-ID: <20250320111741.1937892-7-karunika.choo@arm.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250320111741.1937892-1-karunika.choo@arm.com>
References: <20250320111741.1937892-1-karunika.choo@arm.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0212.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a5::19) To VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI0PR08MB11200:EE_|DB9PR08MB6715:EE_|DB5PEPF00014B91:EE_|PAXPR08MB6541:EE_
X-MS-Office365-Filtering-Correlation-Id: 39e5ffd3-54ad-4991-9408-08dd67a0e98e
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?Uprzjcj9Q3ph6vbnwU3kXRbsok/B8JdvWgJ6Psv+tGbDIh+Iy+JLdBMm9k71?=
 =?us-ascii?Q?wECTxmHpfXds4sP81DA5aZvV9d3R2YP22/EtGk+va/3QAy853GBRF4vvzgbS?=
 =?us-ascii?Q?g5B4HhsmYI/OkzOGerpjmF33fbZaeSXa/jqKO4VPWLs2EYwOP2fC+66v3Jva?=
 =?us-ascii?Q?64dV+jLmnvMkU6rHcka8gCEbLI5I2BUaXdD8aUlkwgL/QFy5/af0WHzDQAYN?=
 =?us-ascii?Q?mqr8F4l2n3AAHJeduDDjm2SfRd1vduXnmQf8FX3ZKpTrjTzhCA+g/4+CW0sK?=
 =?us-ascii?Q?2vnhriS2xbZx4ttnNneJ4fwwLHAkxk+bi+FTlqnp0uYdBpEXBnN1XA2MEuYM?=
 =?us-ascii?Q?g29QfJlz6ppj9CazGUhLUF44MuS5Ph4yP8jCeII+0vvZQiePNwFlAwAv/XFX?=
 =?us-ascii?Q?Es7BfPYYjq2qxlg0xOG0J03k6mOyknNk+XTDWwJ1poJE9pihA6M2FUHkwK3Y?=
 =?us-ascii?Q?O/bqvpHksNrPGBLZPZcwbGOCp3n0vG489/LycQFSo8Ho4VM95cHcuUR6/jlk?=
 =?us-ascii?Q?6MfdqPMcrRlF8f0l8sDGrQJcvxzEcsP3cFEegwn0LpKG6t/eTtdNI+I9M+eh?=
 =?us-ascii?Q?0+hAdbmBeugXYwq5UfEBFAB3D22TQNzl1e8e7o6Ywp39UhJrhghCsOutYOm1?=
 =?us-ascii?Q?BJPNAP/MxrCYPtGatATAUcaqkEWkXjGjpJWv0dWUH8BaVSqFLSsagqlKksdP?=
 =?us-ascii?Q?4xnVba0CuQL+poB5cUEEWX5/iv26Kus03cI+WFQqPki5N9SIc07UXr7cRQC+?=
 =?us-ascii?Q?dGU6UD5sKggdsM7/58ZcDWLIuMesRIux4oJK/e8fLSsuThly9eAdUMpWAItv?=
 =?us-ascii?Q?Uw4mXzZp6/sdTmQAVYL3xJVEXxxPL2Pn2uIb0aSpHgeXPksG1QxzM2RFgxP6?=
 =?us-ascii?Q?3IZg4PSXzi7rEKzUtrt45MZtxijTaT73nle1F0WL78vDOBgk/K1e+DWoAFbS?=
 =?us-ascii?Q?oa9dEXz6K3v9Z9WPY3BwxaRyW36bxpSaxT952V9KsrnILEEtvLHqL7f8thWj?=
 =?us-ascii?Q?n7w/he19JZDkoc16m0iPDft6luh6r+L9HqnaLmjJdeA/75vSvswfNt1m9vDX?=
 =?us-ascii?Q?ca/F547dcOyDZF5JdeipjP6EiaBWS7BcCmkusEQyPKTSuqPYjYa9h1Z2csPH?=
 =?us-ascii?Q?n8kOy4oiM8nx3TmFyRSkglq++PvOZwNzrRdANTWDWPBtaWEQPWG9+NV/1InG?=
 =?us-ascii?Q?KanGWlrXcpZy/K4bXYSUAu7KuenHyT1XpWFt2xIlsOvaf8qcU8Q3hqbMWLjX?=
 =?us-ascii?Q?CDRjzY5HGKDYlfw81fmxodpd5p1vzZFH0WEhPwNRC9EHKedW0nisanVI0zCq?=
 =?us-ascii?Q?P6Oo5Q48YOkHrcQ6chSBGaTBlsc+o9D8nJ/zMx+bfHIOSJfQBWpBsMfQQPJM?=
 =?us-ascii?Q?YBOt3nfT1Urm7ODxPHMn80GDEGdc?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB11200.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB6715
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:800:257::18];domain=VI0PR08MB11200.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB5PEPF00014B91.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	47d6ac15-4e23-4349-22dc-08dd67a0dffc
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|14060799003|35042699022|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yb/bqP7mj7h+wwA7INt/tZq7kWK3XP5OpxA1VDzZvACBOUaezG63sA/OvBI2?=
 =?us-ascii?Q?ER0ZUwBfXPuWNdtoHRC3VIc7lzOyy2OJFpXvF9q9ho+UVB4YT1MPCuwZqSD+?=
 =?us-ascii?Q?RspcR3Y+P1j91urzSRdMhp32F6iew9mfAFL8ahcm+/xy3p0eV9Mw+qYdXnEj?=
 =?us-ascii?Q?bO9VjCCAAxyUFSuioBvaV7mncCvtq52+/Oa6jaKWjYLUEsGZFiOSGI/1K90i?=
 =?us-ascii?Q?+W5PGU/CmKmaDNyfjFidwa/Hl4CdQQ2D/53zzYiTcwJ+fXDJVvwoFalSPOKd?=
 =?us-ascii?Q?uEXdI5R48qBzgne3efGZkoKcrHXppxBz4i4Opf20kNsdAFXqQmmka9tnCA4g?=
 =?us-ascii?Q?+DhgFWkFxwOApbeHftLmB5Zq0vsE+WSHo7lN3hxNdpIRwWU3Axje/hmkq7rM?=
 =?us-ascii?Q?AiGXSckfAk2rSaX4JSo5B5kEu5zZ5ksM3WyFVbwsYMhUv6Thk/oZbwZK/INt?=
 =?us-ascii?Q?CdTaRILFegfhAfwmQadnj/o/Y2w/O9g7h0VAH99OC/fl0HpDYQk3EnJ+WtFj?=
 =?us-ascii?Q?bf0PzYkQnRSvaO8jvhpDM7wrePw6s6+U8cOv3cIckKNfdY9L8hhqK0567Z76?=
 =?us-ascii?Q?lP0ySruqPg73CY8vUuF9IqjivjNInY1nkpWDbdYCxM/zGcmePXBx0ZyI2zxt?=
 =?us-ascii?Q?TrorIS/EIOiNzmuSR/EY6jbahFIcLPTMcx2Lgg+MGzs0YAexTar97Fj5txmX?=
 =?us-ascii?Q?Nbssgim7D604nj6goeTJNqOuKSQ0PROs0Yc/4MUu8RNNbFh4iJX/eVXMwHjo?=
 =?us-ascii?Q?hefJpKn7TkZ28cGYNQgLv5+ZysAPom+nWbD6NE+lY7u/9lphXHiinGYtd1B4?=
 =?us-ascii?Q?FKuWvDN+mPD5DSw5sHRrhkOsT8b7pGer8Xg13FraCT8nWpuuZQwtvhaXjO9d?=
 =?us-ascii?Q?+fI+ZUMLScQ0gYhK4s5KbjDxxdruBKVpHRYpkOGTsfVLMXBiCtZ64DGFibL0?=
 =?us-ascii?Q?MTqG22GHhU5r9H/0aGlXgE5GND4An9TjRYAnN77PJ/F4KedpPAM6kuHlZn6+?=
 =?us-ascii?Q?8B6ZgpAUMvaw0VAtwj/Xe2vt+BUT6ALWOuxKdW9YOgffNy75GIq+yfRWPWuG?=
 =?us-ascii?Q?JofEujMiPiBirdZsonBdFvLAFw7SQ6idqLo/sG4PmtaVkF19xynn3/xXBOdC?=
 =?us-ascii?Q?H1mFKVpR7n5RRz5Z1IkopPUwXVYWB+ZH69T/EBdE7gwAa4C1JyV9l2rfWUIW?=
 =?us-ascii?Q?Wmkfd9cEYkEZW7BUKYui94Ncg3GKckiKoO2S7rTYJ+NQKRMyKd6Nv5jEoTLY?=
 =?us-ascii?Q?ASKVTUhPLnmHCpznKvsIkUX+H0e4aQYhL0qSs2+PGad25yhgh0DlrDnbTE5+?=
 =?us-ascii?Q?PJIfe6f0daNA2ImmkwuRQQU3UXUTioYS3wJwz4e79Uk3hSOeRbul4DPlpLfU?=
 =?us-ascii?Q?4IGsNmtRkYguB3U1/wz16Bw1ZL4iG4FF76k4afVIeIGPPJ5nhsWO6Lo7xRLz?=
 =?us-ascii?Q?SIGwbEvhHWq5hiJOp5pX3aCs4+cyJ6kchLNxAKshLUdbJZoRMvdzUw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:64aa7808-outbound-1.mta.getcheckrecipient.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(14060799003)(35042699022)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 11:18:16.7342
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39e5ffd3-54ad-4991-9408-08dd67a0e98e
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B91.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB6541

Mali-G715 introduces a new GPU_FEATURES register that provides
information about GPU-wide supported features. The register value will
be passed on to userspace via gpu_info. It also adds the following
registers that are specific to the kernel driver only:
- ASN_HASH_0~2
- DOORBELL_FEATURES
- PRFCNT_FEATURES
- SYSC_ALLOC0~7
- SYSC_PBHA_OVERRIDE0~3

Additionally, Mali-G715 presents an 'Immortalis' naming variant
depending on the shader core count and presence of Ray Intersection
feature support.

This patch adds:
- support for correctly identifying the model names for the Mali-G715
  family of GPUs.
- arch 11.8 FW binary support
- reading and handling of GPU_FEATURES register

Signed-off-by: Karunika Choo <karunika.choo@arm.com>
---
 drivers/gpu/drm/panthor/panthor_fw.c   |  1 +
 drivers/gpu/drm/panthor/panthor_hw.c   | 26 ++++++++++++++++++++++++++
 drivers/gpu/drm/panthor/panthor_regs.h | 12 ++++++++++++
 include/uapi/drm/panthor_drm.h         |  3 +++
 4 files changed, 42 insertions(+)

diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panthor/panthor_fw.c
index ecfbe0456f89..0b3fab95f26b 100644
--- a/drivers/gpu/drm/panthor/panthor_fw.c
+++ b/drivers/gpu/drm/panthor/panthor_fw.c
@@ -1398,3 +1398,4 @@ int panthor_fw_init(struct panthor_device *ptdev)
 }
 
 MODULE_FIRMWARE("arm/mali/arch10.8/mali_csffw.bin");
+MODULE_FIRMWARE("arm/mali/arch11.8/mali_csffw.bin");
diff --git a/drivers/gpu/drm/panthor/panthor_hw.c b/drivers/gpu/drm/panthor/panthor_hw.c
index 12183c04cd21..d04c8723ac98 100644
--- a/drivers/gpu/drm/panthor/panthor_hw.c
+++ b/drivers/gpu/drm/panthor/panthor_hw.c
@@ -32,15 +32,34 @@ static void arch_10_8_gpu_info_init(struct panthor_device *ptdev)
 	ptdev->gpu_info.l2_present = gpu_read64(ptdev, GPU_L2_PRESENT_LO);
 }
 
+static void arch_11_8_gpu_info_init(struct panthor_device *ptdev)
+{
+	arch_10_8_gpu_info_init(ptdev);
+
+	ptdev->gpu_info.gpu_features = gpu_read64(ptdev, GPU_FEATURES_LO);
+}
+
 static char *get_gpu_model_name(struct panthor_device *ptdev)
 {
 	const u32 gpu_id = ptdev->gpu_info.gpu_id;
 	const u32 product_id = GPU_PROD_ID_MAKE(GPU_ARCH_MAJOR(gpu_id),
 						GPU_PROD_MAJOR(gpu_id));
+	const bool ray_intersection = !!(ptdev->gpu_info.gpu_features &
+					 GPU_FEATURES_RAY_INTERSECTION);
+	const u8 shader_core_count = hweight64(ptdev->gpu_info.shader_present);
 
 	switch (product_id) {
 	case GPU_PROD_ID_MAKE(10, 7):
 		return "Mali-G610";
+	case GPU_PROD_ID_MAKE(11, 2):
+		if (shader_core_count > 10 && ray_intersection)
+			return "Mali-G715-Immortalis";
+		else if (shader_core_count >= 7)
+			return "Mali-G715";
+
+		fallthrough;
+	case GPU_PROD_ID_MAKE(11, 3):
+		return "Mali-G615";
 	}
 
 	return "(Unknown Mali GPU)";
@@ -84,6 +103,13 @@ static struct panthor_hw panthor_hw_devices[] = {
 			.gpu_info_init = arch_10_8_gpu_info_init,
 		},
 	},
+	{
+		.arch_id = GPU_ARCH_ID_MAKE(11, 8, 0),
+		.arch_mask = GPU_ARCH_ID_MAKE(0xFF, 0xFF, 0),
+		.ops = {
+			.gpu_info_init = arch_11_8_gpu_info_init,
+		}
+	},
 };
 
 static int init_gpu_id(struct panthor_device *ptdev)
diff --git a/drivers/gpu/drm/panthor/panthor_regs.h b/drivers/gpu/drm/panthor/panthor_regs.h
index d9e0769d6f1a..7bc2d838e704 100644
--- a/drivers/gpu/drm/panthor/panthor_regs.h
+++ b/drivers/gpu/drm/panthor/panthor_regs.h
@@ -74,6 +74,11 @@
 #define GPU_PWR_OVERRIDE0				0x54
 #define GPU_PWR_OVERRIDE1				0x58
 
+#define GPU_FEATURES_LO					0x60
+#define GPU_FEATURES_HI					0x64
+#define   GPU_FEATURES_RAY_INTERSECTION			BIT(2)
+#define GPU_PRFCNT_FEATURES				0x68
+
 #define GPU_TIMESTAMP_OFFSET_LO				0x88
 #define GPU_TIMESTAMP_OFFSET_HI				0x8C
 #define GPU_CYCLE_COUNT_LO				0x90
@@ -88,6 +93,8 @@
 
 #define GPU_TEXTURE_FEATURES(n)				(0xB0 + ((n) * 4))
 
+#define GPU_DOORBELL_FEATURES				0xC0
+
 #define GPU_SHADER_PRESENT_LO				0x100
 #define GPU_SHADER_PRESENT_HI				0x104
 #define GPU_TILER_PRESENT_LO				0x110
@@ -132,6 +139,8 @@
 
 #define GPU_REVID					0x280
 
+#define GPU_ASN_HASH(n)					(0x2C0 + ((n) * 4))
+
 #define GPU_COHERENCY_FEATURES				0x300
 #define GPU_COHERENCY_PROT_BIT(name)			BIT(GPU_COHERENCY_  ## name)
 
@@ -140,6 +149,9 @@
 #define   GPU_COHERENCY_ACE_LITE			1
 #define   GPU_COHERENCY_NONE				31
 
+#define GPU_SYSC_PBHA_OVERRIDE(n)			(0x320 + ((n) * 4))
+#define GPU_SYSC_ALLOC(n)				(0x340 + ((n) * 4))
+
 #define MCU_CONTROL					0x700
 #define MCU_CONTROL_ENABLE				1
 #define MCU_CONTROL_AUTO				2
diff --git a/include/uapi/drm/panthor_drm.h b/include/uapi/drm/panthor_drm.h
index 97e2c4510e69..4aba8146af3b 100644
--- a/include/uapi/drm/panthor_drm.h
+++ b/include/uapi/drm/panthor_drm.h
@@ -307,6 +307,9 @@ struct drm_panthor_gpu_info {
 
 	/** @pad: MBZ. */
 	__u32 pad;
+
+	/** @gpu_features: Bitmask describing supported GPU-wide features */
+	__u64 gpu_features;
 };
 
 /**
-- 
2.47.1



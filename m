Return-Path: <linux-kernel+bounces-569570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 528B0A6A4C7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 12:19:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00E3A1894AED
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 11:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F036221710;
	Thu, 20 Mar 2025 11:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="hcj6Aj0p";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="hcj6Aj0p"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2065.outbound.protection.outlook.com [40.107.249.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10ECD2206AE
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 11:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.65
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742469503; cv=fail; b=XegOueON1aogtA8EMy+UNBTCuz3S5rXPBDaXcgG+KqrW9zSvTtglCDmg92Ctqcd/04XMkoTauyPpGLNURDWhR2hH+oR0o7ikcpsKXUBQ+kOTdWiex7D/rVAIizR2maxPPVahXWIcCMUo6CNCBy4mEYNochxWbj5J95rtacfcCcc=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742469503; c=relaxed/simple;
	bh=eTO8bQuAfrp9sACOzR60YOEjmrxWuicLCpyb051mO6s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Wew41LKgnOsMmZuTVal/kapWoeyFnDLytd7i/ZFBaM9J/fyiHkKslYvDVq3ymPLysc4xHxhmtp6kZWFwv68AhybcShVZRWDn2TJbMVYJ18hXP3lyYH2YcglJib6oyJFoMhsK6KQkccnW2mm6fPgLwQUDU+7VM20A9X+CB1L4nm4=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=hcj6Aj0p; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=hcj6Aj0p; arc=fail smtp.client-ip=40.107.249.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=H2JpoV/eeBo4E4DA3dFQ8FJ1uIEbl3XMchK19tHcToaIbopAjIULtty4NdF7+lfp5lwj8f59lJ9MRDW5ngQs2D77jn+ijI7PjUPLGFGalYuRVLTkfygb7zUlg3UQA5tGfMJ+Y2lWITJdlPJ0H2gPyraf64fDkP0J37AiA4TyxTWpGa8VL9Gnqk5e4ajMho8pQD/5/rgU3A7UGVMIwO8ZCS3sjaOFg66j+S4hkN6Hy/Dhzh0tUtNIRXbl43c5NUabhz52b2oGd5IHD7p5CzjQXE7xP/vpXsLKjuRAXFzgQkVBOGyxjfug8zOESliSRWieZ4iIOV3QPg9cUpqTiTzQdA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MWGZUOKv4kRlzngdUj4wYUwTX2X0lnyADL0RYRzoixo=;
 b=OyU+TMxODG7/myahuKtf4Xux4dDMxlNfGB9fEKpajT1Ng7iJRcJghb3702aA0AT82YnCGTidjAQIfVkRQLdkTtzwXwdjFwHEbah0/X7snpCtlNALXPx7tTndOrNvfL/yDPZ++yMl54asl37povh8wqdhx3god51Gm+V20UiuEOs1f8DASwy1bqWdN3Rqau5jtrp8wFVi92l8PFJ4brRkcLBjl8ymHS8+rz9gDZQ/vG12CM5CWLzlIKE2PKV4wnHLQxR84QTBEw9h5WS5YGMmYHffSQXw0VI50zJkvVOwKK7jHJu/1Vy7R1xztxO7lfU134Ep60IWDu6P18hRR1Srmw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MWGZUOKv4kRlzngdUj4wYUwTX2X0lnyADL0RYRzoixo=;
 b=hcj6Aj0pd6XCk6i88JOCErZHOh8wzwPFBolADbGz7GnPETczgSC/Jwg1FEo7gvlIYLCw2qJeX9q5vXEoMjE7CTLwtP1OuhSqlGLOGGYLr0hWSaW5nGtE/aFgOJKYe3pEmXEtP9BgfYJ3c3VKapYx2cV/bS225HoQYmTn2ACszQk=
Received: from DB8PR03CA0004.eurprd03.prod.outlook.com (2603:10a6:10:be::17)
 by VI1PR08MB5469.eurprd08.prod.outlook.com (2603:10a6:803:132::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Thu, 20 Mar
 2025 11:18:15 +0000
Received: from DU2PEPF0001E9C0.eurprd03.prod.outlook.com
 (2603:10a6:10:be:cafe::de) by DB8PR03CA0004.outlook.office365.com
 (2603:10a6:10:be::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.35 via Frontend Transport; Thu,
 20 Mar 2025 11:18:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DU2PEPF0001E9C0.mail.protection.outlook.com (10.167.8.69) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.20 via
 Frontend Transport; Thu, 20 Mar 2025 11:18:15 +0000
Received: ("Tessian outbound bf3b9ac19d92:v597"); Thu, 20 Mar 2025 11:18:14 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 5ab7a45a1d0c25b7
X-TessianGatewayMetadata: dX8luGvamWxAlT9lUwWFTQJkf9KCDg+91PHDrkiGzrPZQyv0TKy1UARjIjEp8OjUCpdxurXOEJQycXuZDV7McufGFzj+pKuLrhWtDmdA5rvjQXaINI78lsssjHS6lEfBCSp6N4f4kOoT7FuiEFTSdQ5k/f6Nb29RRHwXMfgIK0w=
X-CR-MTA-TID: 64aa7808
Received: from Lb4d8711e3bea.5
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id B3C14635-39A3-4A96-B62F-8988F8DC1D9C.1;
	Thu, 20 Mar 2025 11:18:02 +0000
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id Lb4d8711e3bea.5
    (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
    Thu, 20 Mar 2025 11:18:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N40hqXr+1x/dgjfNdMLFvZf4aNluSEQwthKluzGDXbB846hDVmiG6bn4jiQGhBll1rEHYvbXJ70OaabX/Bel7k9lsri17Axez3x5nvbophyI1YFGH7IKPOQt6oyMF+K/qQEBAYGmQ5Kguis56Ab751ZBZzjSlAgEerlF39gSrZkv0/SUOA4rPv4JPGOPVE4jQ5Up6v+MocYu3wTxQKQQc7v2I+SkmKATUEhwTgp78TaPeWGfarg6jm8L2XUYIJzqTZtGF6hp2IcOEUSYPla4z3z07k7+AZxL8M9DWDoMPDD7oWHjwGU+7tB2uth5r0RgIR8lq6d61md4XFYbTD1kvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MWGZUOKv4kRlzngdUj4wYUwTX2X0lnyADL0RYRzoixo=;
 b=QCdPjaRTkkpJK4/zVdMRWI6xsfHlI7ZAIjn+1EXokO0MWKM9/Jgg3KJMf68ONRB5Le+rkUqzLBMsv8DphtBG9NbUlXc5W2KU9ASUwnkHCZUwBydeI+jIe1F5JiT7JIFSicV05isSSYjMaI2YGk0KRbMqpqpmk7CBFFCoysdN+u8fsj0FS2JvZ8F8U1FgVs+Oo5tUyh7xUFSJltVRfjw2vKysg5Nt63GoVFbIJ+gFyn6RMLhM0VBB85FbvWB5WIwvCclxXH29ayEfSdgD/npoya9hWjo1duaJZ7KnuB7opC+jfo0EGJwu/dhnJZnR/MimvJU2xM2/huQ11Eq1Porw9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MWGZUOKv4kRlzngdUj4wYUwTX2X0lnyADL0RYRzoixo=;
 b=hcj6Aj0pd6XCk6i88JOCErZHOh8wzwPFBolADbGz7GnPETczgSC/Jwg1FEo7gvlIYLCw2qJeX9q5vXEoMjE7CTLwtP1OuhSqlGLOGGYLr0hWSaW5nGtE/aFgOJKYe3pEmXEtP9BgfYJ3c3VKapYx2cV/bS225HoQYmTn2ACszQk=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18) by DB9PR08MB6715.eurprd08.prod.outlook.com
 (2603:10a6:10:26f::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Thu, 20 Mar
 2025 11:17:59 +0000
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::d594:64a:dfc:db74]) by VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::d594:64a:dfc:db74%5]) with mapi id 15.20.8534.034; Thu, 20 Mar 2025
 11:17:59 +0000
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
Subject: [PATCH v2 5/9] drm/panthor: Make getting GPU model name simple and extensible
Date: Thu, 20 Mar 2025 11:17:37 +0000
Message-ID: <20250320111741.1937892-6-karunika.choo@arm.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250320111741.1937892-1-karunika.choo@arm.com>
References: <20250320111741.1937892-1-karunika.choo@arm.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0057.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2af::14) To VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI0PR08MB11200:EE_|DB9PR08MB6715:EE_|DU2PEPF0001E9C0:EE_|VI1PR08MB5469:EE_
X-MS-Office365-Filtering-Correlation-Id: e6080d8e-6a95-40ed-d19b-08dd67a0e8bc
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?A76k3l5/PhU01iLXKjfMwVClLCwAGUXcTQHd/dS9TKvEzpGwv9sh4Yme9bTK?=
 =?us-ascii?Q?UmYbPU9jwz49s2Xg7kNzRjAn0vms1v9FlSFSVvpvRhlpi8oFbwLRE6TTr34+?=
 =?us-ascii?Q?i5KtmKz3z6IQ4SQ+EYyiBqnw13QunnKT39tgEJgN/LIGVx9mUfDKdI8uzTus?=
 =?us-ascii?Q?3TtpDdSin+P84vCgmpBZD0CCh7HOsOarjNu9KB+Ogn07Bwq8MyFOUlBfHBKG?=
 =?us-ascii?Q?/M02K5pECXxAlReyatyhegbPGecL+dB/Lh0Aa8Vt4ZFShUgTteWcGB/DS4xU?=
 =?us-ascii?Q?8veBVV0fGOWLDDphY2fzq0kuki9U7q4YGcnrIz0WnU1X4SvwU4JIHV5a02p2?=
 =?us-ascii?Q?Emb8jqD7UNUNfQRoOnVem4tTCq0tTR6bi2YCysORcC7Wl+kaoWm8r+tS36An?=
 =?us-ascii?Q?HZec/lIk/UCpKOGoRINVWAPJqh+49y/ChrMwhSsRSF/9nOtDD7GEpdevx5lW?=
 =?us-ascii?Q?rnelZC09LScfzuhhP6gyl/oazsWkmF3bhlNswNfmu1nwn12ZTKv4fo47Cp2/?=
 =?us-ascii?Q?QS2LBOkazNkW3xQlFrGPyZNUZcaSqogFEhv99uKfCSQy3LZ/1joGQVryRjPK?=
 =?us-ascii?Q?g+Kpfj4uGMJd6CZDe9bikXBbilONfCtAlfJ18ne9StXEei7VSt/NgbmkFmDX?=
 =?us-ascii?Q?pVG/AmRbbrrPSPepSAFRBsAEBYIuxLkeclLzupIkaGXhhwwFgwjoKqTFsXYd?=
 =?us-ascii?Q?7EPXavq+PCqF3cO3KkEOUYvW8Yj7eXY5MqWjXuRJiv8bBKZeQww2X9wE9Oxc?=
 =?us-ascii?Q?fiGf3ouNp6Vnxj/giCSoNvodRAIGhJUGn3dCWaLm9wRkZs5v79qzfjB1LUTP?=
 =?us-ascii?Q?F0sMJfWkZs0EFVTbcY0tkx0E09QhvCdV5KNWQcGn1LDiLTa6VdOa754yqh6p?=
 =?us-ascii?Q?2ju/aqBw5zOq7BJ2YMmTCRSQuo3GZtMLOSDdjONgEv0kIs0bK504Ox5EMEVf?=
 =?us-ascii?Q?Gky2w+7u/1jEfOtUBxi4BRFbwN/h8CtroTrzEt7mNHNflEH6+IERYQVZqF/y?=
 =?us-ascii?Q?/o732sMj2iTVuLGJnyUhDP7AHJdHuKdKNUpj7YD/1/pNEBfKF8upXdQnx4nh?=
 =?us-ascii?Q?JYcZf5+Um3M7CDAYB+16+WhpvCLhyvE4zd6X+gpzz5YuUxUmH3Z8QjIqt9RH?=
 =?us-ascii?Q?FN8xrlmiKf2a4k5gU0jgHVWbk5qSEiRPTZptGo7twjg/WFYdTNPFIFjt8Gxy?=
 =?us-ascii?Q?xtrnDJeOcognSBmc3dzTTS3QxRruKomZbDSfPckAhS1uJpfeMhtfdUZIx6/7?=
 =?us-ascii?Q?RUkpUjarBwnz3iaclLZZzBkPNnBdbcQB7oz9ysGJZVNH4EN8D6ncL3Ec1hBt?=
 =?us-ascii?Q?JTWAg3Gup/zPTfujflBrhgOOrd/5cE9F/6nusp/YIumGd2ERnWXBEpZYmkOr?=
 =?us-ascii?Q?7K3hZ60cfKk0fpDJ7+gXqoTz9YEz?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB11200.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB6715
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:800:257::18];domain=VI0PR08MB11200.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU2PEPF0001E9C0.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	2251d176-b702-4140-0f2f-08dd67a0df27
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|14060799003|376014|35042699022|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LwHMe6eCsYgjGQnTR2ZI7AbbYDAgFzMYC8ian+q5gQ3UBkWwmhRQ/WYQThN4?=
 =?us-ascii?Q?fZ1T8GW15rNQt7RP4tA31be2nVsDEqXfuKEmp0jpDuw/R3kZ7sw2zi6isSQT?=
 =?us-ascii?Q?PhtMqYXrc3awfT9Sbo0CBMVW+ILQQoHpssh0+tCvIHM4IbRmYe5ujLtQaa84?=
 =?us-ascii?Q?wYt6K5W4AUM648k/GvvvwlZvbEM3EcYm07Cgn3EGrX2B/f8+0yyvHxsbWY0W?=
 =?us-ascii?Q?C2m4zVOvz6+DZJEW/O5mW91wKSrK6Gcc6lTOZ76xQ+6VclNo05OHmPlrZYEb?=
 =?us-ascii?Q?vEDPMSywhI6Nv/1Yw/pGXCkMj31XjdEK1Jn0JaQrbg+eHz5E/+zcZDcRJWoA?=
 =?us-ascii?Q?Ji5NYTcd0fbtMd/FP6Yqskiyp64q0XTRDo2iawJ1yVv3UCfDYBJ+tW3Nsl3V?=
 =?us-ascii?Q?haZRk+tiO3fZ5mcYQdbXLopNOnfAV/VycLwXEWysNCReknEo27UAw8Yt6hR8?=
 =?us-ascii?Q?HRwqr5Z3gIIKi9xqyI5eUwqGNFC1v9EDEbon1a/ca4SEWNTet0mV5myY0pgz?=
 =?us-ascii?Q?U4VrNBZlGDQsFEJonoeu9x93aVjpfn8rq0yJMB+Ws9d68q9E9TZ4iNTtt6CM?=
 =?us-ascii?Q?WDN6KAoiiHs37n4ZRAIwLaH3I1Q/VwWEUDD2mm+iAbw5fBqWzOBcyXAl22VB?=
 =?us-ascii?Q?GEsFE3gt6qN7cSyJR8tqBH2ve40F8Y5FWTJba8r8ok/7Ttx8G9/vl0uFHXN6?=
 =?us-ascii?Q?lGrZkalb3m8qaBmae3AiOoqpCkQdARogtcUjxovQxIAlY5snDasxp8vIbd+V?=
 =?us-ascii?Q?po9D75ugzSdyFrbGwgFHwOXaRIs520ZrCC9VEHRjoapy7NkL1hUH9tASxYHv?=
 =?us-ascii?Q?sao2tyui6ksGvbq8cmZAQhHei+S/DWRVC38CnUntcPhsn5lMvVcks2IA8NKU?=
 =?us-ascii?Q?V16FTNqFVOrQ0zHew/L5MSV9bpt+osLzLbcOmROcMpcA24gO2Dhjnx4arLPr?=
 =?us-ascii?Q?A7MOFHh9xWd6zNoa7XAVIrw2VmdSx/l1qEuZUi6LDOq2TMlphYgiVT2yvGVo?=
 =?us-ascii?Q?2MjXa57eIwf03enx3e5BPfloHsRXpk37roZGO3cQA44RuSdtfV3DTVszuS3F?=
 =?us-ascii?Q?gIRt+giGUJc5HlsAhoFV1wZhFCe61/vp5xAOzYzTAuBiANwNv9d6BWwpmwrk?=
 =?us-ascii?Q?imxM7aOXRZ9FadO8HRQlwPwxeaEEIHPnOikxc97DXnqeJ5/hx7/d8LJ8nYzL?=
 =?us-ascii?Q?bLm3/DVTojZsVJUKjO/TBL0Ncp8HqziMsqIGAFvV6NBDc+1MWk48cMR7J5pP?=
 =?us-ascii?Q?7BXKyWYGAh5XC4N2Z2luA9ZkypIGNQjkO1AUguOshyTxDsAdbAM6cow6RUJ9?=
 =?us-ascii?Q?VuWzBgq9vbQfjpzCr2RrwLK/2eIMkrjG+unv/swCcsgeRYTQldsi4W0rHGKN?=
 =?us-ascii?Q?u3kAvDT6TEhCosus9Pi333bgHVU9G/c+Cw/Ya6S70meIQekfh0w6Plok3wuY?=
 =?us-ascii?Q?Qt/SkccZMEC9jEUQNB8H+7N8uyg6GpPonVj+OjPw4E1ztTaYhB3DUg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:64aa7808-outbound-1.mta.getcheckrecipient.com;CAT:NONE;SFS:(13230040)(1800799024)(14060799003)(376014)(35042699022)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 11:18:15.3595
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6080d8e-6a95-40ed-d19b-08dd67a0e8bc
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF0001E9C0.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB5469

This patch replaces the previous panthor_model structure with a simple
switch case based on the product_id, which is in the format of:
        ((arch_major << 24) | product_major)

This not only simplifies the comparison, but also allows extending the
function to accommodate naming differences based on GPU features.

Signed-off-by: Karunika Choo <karunika.choo@arm.com>
---
 drivers/gpu/drm/panthor/panthor_hw.c   | 63 +++++++-------------------
 drivers/gpu/drm/panthor/panthor_regs.h |  1 +
 2 files changed, 18 insertions(+), 46 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_hw.c b/drivers/gpu/drm/panthor/panthor_hw.c
index 4cc4b0d5382c..12183c04cd21 100644
--- a/drivers/gpu/drm/panthor/panthor_hw.c
+++ b/drivers/gpu/drm/panthor/panthor_hw.c
@@ -5,40 +5,6 @@
 #include "panthor_hw.h"
 #include "panthor_regs.h"
 
-/**
- * struct panthor_model - GPU model description
- */
-struct panthor_model {
-	/** @name: Model name. */
-	const char *name;
-
-	/** @arch_major: Major version number of architecture. */
-	u8 arch_major;
-
-	/** @product_major: Major version number of product. */
-	u8 product_major;
-};
-
-/**
- * GPU_MODEL() - Define a GPU model. A GPU product can be uniquely identified
- * by a combination of the major architecture version and the major product
- * version.
- * @_name: Name for the GPU model.
- * @_arch_major: Architecture major.
- * @_product_major: Product major.
- */
-#define GPU_MODEL(_name, _arch_major, _product_major) \
-{\
-	.name = __stringify(_name),				\
-	.arch_major = _arch_major,				\
-	.product_major = _product_major,			\
-}
-
-static const struct panthor_model gpu_models[] = {
-	GPU_MODEL(g610, 10, 7),
-	{},
-};
-
 static void arch_10_8_gpu_info_init(struct panthor_device *ptdev)
 {
 	unsigned int i;
@@ -66,29 +32,34 @@ static void arch_10_8_gpu_info_init(struct panthor_device *ptdev)
 	ptdev->gpu_info.l2_present = gpu_read64(ptdev, GPU_L2_PRESENT_LO);
 }
 
+static char *get_gpu_model_name(struct panthor_device *ptdev)
+{
+	const u32 gpu_id = ptdev->gpu_info.gpu_id;
+	const u32 product_id = GPU_PROD_ID_MAKE(GPU_ARCH_MAJOR(gpu_id),
+						GPU_PROD_MAJOR(gpu_id));
+
+	switch (product_id) {
+	case GPU_PROD_ID_MAKE(10, 7):
+		return "Mali-G610";
+	}
+
+	return "(Unknown Mali GPU)";
+}
+
 static void panthor_gpu_init_info(struct panthor_device *ptdev)
 {
-	const struct panthor_model *model;
-	u32 arch_major, product_major;
+	const char *gpu_model_name = get_gpu_model_name(ptdev);
 	u32 major, minor, status;
 
 	ptdev->hw->ops.gpu_info_init(ptdev);
 
-	arch_major = GPU_ARCH_MAJOR(ptdev->gpu_info.gpu_id);
-	product_major = GPU_PROD_MAJOR(ptdev->gpu_info.gpu_id);
 	major = GPU_VER_MAJOR(ptdev->gpu_info.gpu_id);
 	minor = GPU_VER_MINOR(ptdev->gpu_info.gpu_id);
 	status = GPU_VER_STATUS(ptdev->gpu_info.gpu_id);
 
-	for (model = gpu_models; model->name; model++) {
-		if (model->arch_major == arch_major &&
-		    model->product_major == product_major)
-			break;
-	}
-
 	drm_info(&ptdev->base,
-		 "mali-%s id 0x%x major 0x%x minor 0x%x status 0x%x",
-		 model->name ?: "unknown", ptdev->gpu_info.gpu_id >> 16,
+		 "%s id 0x%x major 0x%x minor 0x%x status 0x%x",
+		 gpu_model_name, ptdev->gpu_info.gpu_id >> 16,
 		 major, minor, status);
 
 	drm_info(&ptdev->base,
diff --git a/drivers/gpu/drm/panthor/panthor_regs.h b/drivers/gpu/drm/panthor/panthor_regs.h
index ba452c1dd644..d9e0769d6f1a 100644
--- a/drivers/gpu/drm/panthor/panthor_regs.h
+++ b/drivers/gpu/drm/panthor/panthor_regs.h
@@ -20,6 +20,7 @@
 #define   GPU_VER_STATUS(x)				((x) & GENMASK(3, 0))
 
 #define GPU_ARCH_ID_MAKE(major, minor, rev)		(((major) << 16) | ((minor) << 8) | (rev))
+#define GPU_PROD_ID_MAKE(arch_major, prod_major)	(((arch_major) << 24) | (prod_major))
 
 #define GPU_L2_FEATURES					0x4
 #define  GPU_L2_FEATURES_LINE_SIZE(x)			(1 << ((x) & GENMASK(7, 0)))
-- 
2.47.1



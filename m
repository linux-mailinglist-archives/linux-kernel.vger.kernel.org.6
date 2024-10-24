Return-Path: <linux-kernel+bounces-380140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A94839AE970
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 16:55:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68CB82859DD
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 14:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E1581E8857;
	Thu, 24 Oct 2024 14:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ATJuv2LB";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ATJuv2LB"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2047.outbound.protection.outlook.com [40.107.105.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122BC1E631A
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 14:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.47
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729781720; cv=fail; b=VK8efGyrqC0WOwlbszfjGUOXTod/2w4v5GhYPtqpPwjg+0FIIRyAIRyPCz1W5eQg3ETk05pWfKG8xrzpUwukbCWCe6DX5zXHMcpw0xW1ggaTnbwFKy0dV9l8fBoI8iaJaT/4Dnqt62SBchONUNECCdZvnwKgHoEhdZTr7NpF2Sw=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729781720; c=relaxed/simple;
	bh=z1r8QdXPwTHhN0eubZj2wkWp9ImQUIF3M7FPC8MeUn0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cYG7A5cRCJlcHdOMuDSWlySTJSd3LOcj1rKDsz+fxT23AVwPgSN4olAiMC2sQqZ+AhG312zKZOyKePZUOLgA+sH4/JA/gLr9Ipw5xptGGaX+2zktKgboNtjhX/Jxe9oQ379OTGSH8gRSRM5boW8eb6BD2kNrTGdxkSKHl3P3U0U=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ATJuv2LB; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ATJuv2LB; arc=fail smtp.client-ip=40.107.105.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=LNmEHe1XTeALGJpTOvzGs8CjjzY0sg7ZjzCcVRGapNcRaVlHuuuOW+9u+OQK3mDMQnvVE7CKzA/yk7YjTKr4u6NckRILV1pRSYZWnnchoaLY8CLCVnHJDaa1fOl/BJMCz6jo9zURLwC0+1LuL1uxNfbFVCmhAmd8m1AZxN+PHLyzA6qtVSjRo0Ys+OmBajmeqGFB0ahokBrJQgKnxfmyQh9QrIeKxunMzMDx62Ye0Mf4Hz+5NJo0Lb3TrWTXb17E8yGPcQ8qUk+Htf0BAOas66V0XVs4kmDOesZB9n02pqjzEHObNYjhb94tpzew6jqYgobA1lvcRbLhiKcaT37Pag==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y9scCfDORPSH8x2FzZou9SIUQuCUSGsR2CCaTY9VGBc=;
 b=xwZysK8L3VhXDdYIwp7kloKahgxYu7hw7K9kJEFdBxsS5nr8vjnJQyvrXYy1bTbBT8/BQOKFnAWggJlSYMGOKEYXJCKMspsnrqmZzvNuezZ0sqkz43nQ9Yb737/QdNhC575DwRicG0MikfOtXZFTsPuLw3K+BBMU5aJfzxZdxvat24XFtR8sscxMWYzpYb3WutRO3gBzd9vZEuDHWTvHhJOedhGx4iwaEc3/Ug0HvesBAqEndZwFesKFCAtOVJObptxl/qCPo+iYD8VV/nz5Qfyoj0Bmk7NeptsX4o70SlK3YEKUb01ndDSnEItW3Tb9CuXwivD+8wW7ggmubeLgzQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y9scCfDORPSH8x2FzZou9SIUQuCUSGsR2CCaTY9VGBc=;
 b=ATJuv2LBv2BeDvIaiRciRB2oaFonfm/mNmj1Lg/+y250iFG2y11AGLS9yt9mpjGXPx2IYOXaENlniyLAq+yxu25X0p0c663NMz/ffhgUWZILqhvFv7/NUFxiFxUkTUd2sUP9K4p+SRj5O8nfJ5caSqGxYizx7NVICuSqwUHiV6c=
Received: from AS4P189CA0034.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:5dd::12)
 by DB9PR08MB10380.eurprd08.prod.outlook.com (2603:10a6:10:3d8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21; Thu, 24 Oct
 2024 14:55:12 +0000
Received: from AM4PEPF00027A67.eurprd04.prod.outlook.com
 (2603:10a6:20b:5dd:cafe::11) by AS4P189CA0034.outlook.office365.com
 (2603:10a6:20b:5dd::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20 via Frontend
 Transport; Thu, 24 Oct 2024 14:55:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM4PEPF00027A67.mail.protection.outlook.com (10.167.16.84) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8093.14
 via Frontend Transport; Thu, 24 Oct 2024 14:55:11 +0000
Received: ("Tessian outbound 99870d44e01c:v490"); Thu, 24 Oct 2024 14:55:11 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 38642131af2d5fce
X-TessianGatewayMetadata: E/gheL5YIo3CGH9/C8UQs7ToJ4LI4qjaHV+w0wUESYkjfzFOZ+UYfzK8Hw3/4SiSjER6/gbedA4yUGyGAFnrZ+oS4oA0kLhM8uHNghPHp2MTQ2xUpOWzTgblFjwsTG2NhPsrMHFDLAir58WkTd92QZp76IswQjWKVZW71I4wMv8=
X-CR-MTA-TID: 64aa7808
Received: from L2869cc968543.1
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 11190802-E05E-43C6-86F8-F172746A2D96.1;
	Thu, 24 Oct 2024 14:54:58 +0000
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id L2869cc968543.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 24 Oct 2024 14:54:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v558CKjbY3MRK2zSTonMQJdvQ8FNDGXrge4YQIBzekUzM82vgLcfHJOlRo+pYB6kf9QLmKDUKWYShIRTL9rVsROXwoH4c0KiURCwZhwfeeNmcWImNVvyoYNZMkSDjeawJUH6K5U1sEKGGaJowSp+w8FPPLP7ExwVVNy5/oi1DxsjzRcnsYCU1UV9L3bgZAV0JyKirQ+NqMTiRCdN4umjBB5bND/bylVYirjSixwOwOeQukI9t6V48X1c+KVKAMHY467iAofS82rbX2phs7bNLEC+HG399HsR9MPnJDYHuWQgl2saJdTsZxzLe8uSiurskKmadLY8QVje9qkEXHZgXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y9scCfDORPSH8x2FzZou9SIUQuCUSGsR2CCaTY9VGBc=;
 b=LHqYkISJalAI2m+2lkvu9X2WccegeaZbap/RIVfkVYJd7ZOjGfenxqiPTh0Os8NXCf5oRKDM4YkAnvkhKeF1JOjSBXzYlTCw6D39SU6WUtlu6LP53GMVoxi3cC5zidgDOrNcRiIZy0HVUgSj0+3wUL5NsYxl8Xhx6f4s4yF5eLErBCJUaTQHPdpejb7eqZMRTEpIzmDVzzymKj8rSUMUEOSp4XO0dh09fF8Ewz0tLUXkaaw0blTwP0Lvs0aHjMn7bFhagcBYCAVRehbd1gzECaYzqiUaRhei7/1I3yI5hJ78p5/VJIAFc4/RE9huy3/JHPvOF2/yCdtmVq6bVrs5Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y9scCfDORPSH8x2FzZou9SIUQuCUSGsR2CCaTY9VGBc=;
 b=ATJuv2LBv2BeDvIaiRciRB2oaFonfm/mNmj1Lg/+y250iFG2y11AGLS9yt9mpjGXPx2IYOXaENlniyLAq+yxu25X0p0c663NMz/ffhgUWZILqhvFv7/NUFxiFxUkTUd2sUP9K4p+SRj5O8nfJ5caSqGxYizx7NVICuSqwUHiV6c=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM9PR08MB6982.eurprd08.prod.outlook.com (2603:10a6:20b:415::16)
 by PAVPR08MB9650.eurprd08.prod.outlook.com (2603:10a6:102:31a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.18; Thu, 24 Oct
 2024 14:54:56 +0000
Received: from AM9PR08MB6982.eurprd08.prod.outlook.com
 ([fe80::5d5d:a4a7:198c:fbdd]) by AM9PR08MB6982.eurprd08.prod.outlook.com
 ([fe80::5d5d:a4a7:198c:fbdd%3]) with mapi id 15.20.8069.016; Thu, 24 Oct 2024
 14:54:56 +0000
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
Subject: [PATCH 1/3] drm/panthor: Update memattr programing to align with GPU spec
Date: Thu, 24 Oct 2024 15:54:30 +0100
Message-Id: <20241024145432.934086-2-akash.goel@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241024145432.934086-1-akash.goel@arm.com>
References: <20241024145432.934086-1-akash.goel@arm.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0056.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:153::7) To AM9PR08MB6982.eurprd08.prod.outlook.com
 (2603:10a6:20b:415::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AM9PR08MB6982:EE_|PAVPR08MB9650:EE_|AM4PEPF00027A67:EE_|DB9PR08MB10380:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f412061-adad-4456-4cd5-08dcf43bdc7e
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?ZzG0/YsK2HHTcyOpBDxwtQ/EjY5hJfXqfYagsj7znURJDXJjFV6vIMBuycXg?=
 =?us-ascii?Q?JlVMmyOeWmPE1iczTNAi8amMMWKxOHUpgqB7baO+jTyk/we8xSbzeaaRDxst?=
 =?us-ascii?Q?kpwROZ/+8F2rvxd1oVErpLbonY0R6yuRCKxGWqUocqaEdSFCVOu4cUZUfpX7?=
 =?us-ascii?Q?OARfOAC/fibD/75MVC6Q0tqbA0QCMGoyKRTxGD9bQ+FPAyVaC1qh+ET+E66L?=
 =?us-ascii?Q?aePsd4q2hW1DugUU/GmckBOIAqHCAlJUAhoz5kIPhlDiGY0H/YksCTK5ZvYf?=
 =?us-ascii?Q?LXsuHD8IRtR+twjosz4hPgB7xkCVyaCRqLJXPqJmi91SYgb6+oHcxpXX8bKT?=
 =?us-ascii?Q?Y/AP7K4TrIxEK1RNgM6x4Q3MHXlK/QYQG32/mpRCf1K6HvNMQ05Y0MxZoWMv?=
 =?us-ascii?Q?GHzCsDUmF/M657Zsva6pmC0LsKtpvxKGBRNpF6s1LMp4UqUvmxL9Q+m0/Yme?=
 =?us-ascii?Q?mJOj8IyIZsWaeeLsGw5JE0LQ+Y3eWzqYurzl0miimZU4x2TpbbG/UuCdFaUl?=
 =?us-ascii?Q?aCKS7YmPcZ8vHN2CNwDjjHbdkDceHslFXav4wz8QRSIGSvGzdyrNZpZRltop?=
 =?us-ascii?Q?LEPERBLrt7vO4wor3fagVsZBFCpdrO1jIjkE8V5s4dYPQE49/i36uU55tghK?=
 =?us-ascii?Q?Kx15e0HDpQeir1tc2hivP5k2Q6u4TMu1zRBBBs/u6xbtHAfEevMMmIW9cUbj?=
 =?us-ascii?Q?Pkgn2FJP5pG0HbkO4aK60yLSHZuGb47pWpAA3F4FcEaK3CWE/fCzo8IswIXA?=
 =?us-ascii?Q?U10pZABPqCoTEYbzUKrJ8MqziOErOFKPCsYawCBHaKanSLB08nnhPtQKKp4I?=
 =?us-ascii?Q?ZRH60B7GbQONC4k3vhdPSECUvBXpNSj4qjDLGDAzGIo4pYnq9Z3cK3A11D86?=
 =?us-ascii?Q?hpgjo/D53JwaRHnx6L0amSmvPQErXXUAq3du7Jr6i9HESJ4dq6nOs0x0YEWT?=
 =?us-ascii?Q?b7g0aEXF1eaVSTsjhWmFX4AOYEdwYHa2r8Xkd8U/xJq2rkUwoKI2+Mc5BIBQ?=
 =?us-ascii?Q?Vifglq3yS1J3VrcDYwyirXk1tgRwPuNOwk3LvLawDnUa5FgOtC7HPrfrnGpc?=
 =?us-ascii?Q?Lks53a2/cifGUWjtWTuLPA2IcOtb1nt4lBw706udnk98EMpyw67FREeK5EBv?=
 =?us-ascii?Q?nCwNStT6oLy5ZRZ9tupsgtPIhjyfGesMH/tF23CEOsT8C879IWIE0jAopEw+?=
 =?us-ascii?Q?valtEBE3ahqEx6kJUxvap7C6VitFIcWuoZmfWTbFAznMXU7cI3GYuXR8Cd4V?=
 =?us-ascii?Q?WLR1pUD85YusPMQadWiI4UItgunh15g1hsoJ/SAJjj1Qgwh6vPEChCy6RCd+?=
 =?us-ascii?Q?nH2ghRUJKU53vMeTyWIyG8ZG?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB6982.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB9650
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:20b:415::16];domain=AM9PR08MB6982.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM4PEPF00027A67.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	05d963d0-3dcd-4465-fa3e-08dcf43bd34f
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|35042699022|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/DtAuBlJMGX1lS618efIv8I+53EUgmwI9dq22DHmrHbJMuzy5KLRs1XX42RC?=
 =?us-ascii?Q?r07RUjl2RUGt+2P9FmGohOp/GO92GY2EzafXv+hPCOb1bjkyfOaxawxiek6o?=
 =?us-ascii?Q?o3OoYdYS0FPD0AUhA7QKUSzawi7vPbdmbRuF8KBezLMQVQb6qjBdkTNNPqDV?=
 =?us-ascii?Q?fLOZK0ERi4lo6aDGO/+8NEFuP47y2bv1LRBmwgXXj3RVUGWygKj1WvzRgafH?=
 =?us-ascii?Q?aWmfM/XGfpI2BtepqOf05BiWNAs8Ta6jw2qlD1DQ3dpa9kQ0avJb3yttl77o?=
 =?us-ascii?Q?isnuAS128GBlzw+t6sO3g5RswQhLX+ZyuC1WTy24FRZIPmzYEd2WbYNf7lpK?=
 =?us-ascii?Q?NuHyVJ4iZmfsZa14Gzb0WSaWYlkwAPQNlsHjVn7fJWOBG+lOi9Es4BvpMMxV?=
 =?us-ascii?Q?O3cCqIbDJv77EJK776+6Aarbk6h9tBTAg7i5LAG4SvpEJ0GwhP4BgnE2ZVr1?=
 =?us-ascii?Q?BjhQWuDF3oEUypWwFzN1zpAvnPRwSai/E4CoysVRj0HEVsIHsLE3K0+N93BT?=
 =?us-ascii?Q?2aktovsNHPw8hahO7wH9ziQfIOr0zZ5xgNlHxy1gAoYuBnBfrZ+HI+yUP8qI?=
 =?us-ascii?Q?lZeuDW7pG9VjvYm0cKtare5SgSI/pf04ZWHCT4Ea9LIspkZrkxW9PLvlvAuY?=
 =?us-ascii?Q?28ttlAfueg2Rpi4XSSfDAn80W3Y1GSX8va91iAyy59RAdC79/udvNkmT9tWW?=
 =?us-ascii?Q?XFMsgKmyu3w0pTdmfnXyUFVhpRfIJvfnV5vlrLj+nE7sY7qeprv3AuZOVMII?=
 =?us-ascii?Q?80Y3CwbdQQnPvQRJrbutciZMKCrHWnhYOuD1Da9GwpGBVJtE1Qy/76QacmNs?=
 =?us-ascii?Q?tS8GZws1cFXgl5ccHvQ7aBJCnf0464CxWldkADbbfAsShxywu0vCLfQTOu0b?=
 =?us-ascii?Q?pbi+x4Uvt6APBsEOT6y2kF+F/wMk6AhDfBOuHRXOg6oQ2zJFU1HANvsrWDpX?=
 =?us-ascii?Q?GmIMCJpdiVGhfd1RrYx2t9uVeExMi2efmo0stduBAbbj+7BGJizeKEUqj/GA?=
 =?us-ascii?Q?QO6KutTkGHaf91k2+ws+WEfJQuk6rfJ/wPXbIHQ9szBVspr9c52kOK1Kto+K?=
 =?us-ascii?Q?MlcTjhma2YpBBpn6CHvWieWqmzxswaSZ1uJcSG+voC70aOAnZUEdDpsogMy4?=
 =?us-ascii?Q?ZjFycxm9REoRZBXAQ+2z9Y9H9S6Fnezj4JU0kOGq8Ns9B7ei7W8tbo6kn1tt?=
 =?us-ascii?Q?+rMFRsvjI3CXe9ZZV40sPqbDxm/3bNRLzp7d1yU9Tb4N0Q1qeCKGyUIiencU?=
 =?us-ascii?Q?RLVnbeG08FIypVtdyY4fwiV2MbkF9hrgzbkQezlRTf6zLIYTOOkB9B9tDU5v?=
 =?us-ascii?Q?G3++n19rmFVKBAlqqUL9Hj1bW4+OS22BW57yz3Dj4wWp1nVnsDqNyBAAYLUE?=
 =?us-ascii?Q?ycEpXT5mbduMmc7KS819QoMBdRIni+qJTaXEIiRHZc6j7S7KKQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(35042699022)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 14:55:11.8811
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f412061-adad-4456-4cd5-08dcf43bdc7e
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00027A67.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB10380

Mali GPU Arch spec forbids the GPU PTEs to indicate Inner or Outer
shareability when no_coherency protocol is selected. Doing so results in
unexpected or undesired snooping of the CPU caches on some platforms,
such as Juno FPGA, causing functional issues. For example the boot of
MCU firmware fails as GPU ends up reading stale data for the FW memory
pages from the CPU's cache. The FW memory pages are initialized with
uncached mapping when the device is not reported to be dma-coherent.
The shareability bits are set to inner-shareable when IOMMU_CACHE flag
is passed to map_pages() callback and IOMMU_CACHE flag is passed by
Panthor driver when memory needs to be mapped as cached on the GPU side.

IOMMU_CACHE seems to imply cache coherent and is probably not fit for
purpose for the memory that is mapped as cached on GPU side but doesn't
need to remain coherent with the CPU.

This commit updates the programming of MEMATTR register to use
MIDGARD_INNER instead of CPU_INNER when coherency is disabled. That way
the inner-shareability specified in the GPU PTEs would map to Mali's
internal-shareable mode, which is always supported by the GPU regardless
of the coherency protocal and is required by the Userspace driver to
ensure coherency between the shader cores.

Signed-off-by: Akash Goel <akash.goel@arm.com>
---
 drivers/gpu/drm/panthor/panthor_mmu.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
index f3ee5d2753f1..f522a116c1b1 100644
--- a/drivers/gpu/drm/panthor/panthor_mmu.c
+++ b/drivers/gpu/drm/panthor/panthor_mmu.c
@@ -1927,7 +1927,7 @@ struct panthor_heap_pool *panthor_vm_get_heap_pool(struct panthor_vm *vm, bool c
 	return pool;
 }
 
-static u64 mair_to_memattr(u64 mair)
+static u64 mair_to_memattr(u64 mair, bool coherent)
 {
 	u64 memattr = 0;
 	u32 i;
@@ -1946,14 +1946,21 @@ static u64 mair_to_memattr(u64 mair)
 				   AS_MEMATTR_AARCH64_SH_MIDGARD_INNER |
 				   AS_MEMATTR_AARCH64_INNER_ALLOC_EXPL(false, false);
 		} else {
-			/* Use SH_CPU_INNER mode so SH_IS, which is used when
-			 * IOMMU_CACHE is set, actually maps to the standard
-			 * definition of inner-shareable and not Mali's
-			 * internal-shareable mode.
-			 */
 			out_attr = AS_MEMATTR_AARCH64_INNER_OUTER_WB |
-				   AS_MEMATTR_AARCH64_SH_CPU_INNER |
 				   AS_MEMATTR_AARCH64_INNER_ALLOC_EXPL(inner & 1, inner & 2);
+			/* Use SH_MIDGARD_INNER mode when device isn't coherent,
+			 * so SH_IS, which is used when IOMMU_CACHE is set, maps
+			 * to Mali's internal-shareable mode. As per the Mali
+			 * Spec, inner and outer-shareable modes aren't allowed
+			 * for WB memory when coherency is disabled.
+			 * Use SH_CPU_INNER mode when coherency is enabled, so
+			 * that SH_IS actually maps to the standard definition of
+			 * inner-shareable.
+			 */
+			if (!coherent)
+				out_attr |= AS_MEMATTR_AARCH64_SH_MIDGARD_INNER;
+			else
+				out_attr |= AS_MEMATTR_AARCH64_SH_CPU_INNER;
 		}
 
 		memattr |= (u64)out_attr << (8 * i);
@@ -2325,7 +2332,7 @@ panthor_vm_create(struct panthor_device *ptdev, bool for_mcu,
 		goto err_sched_fini;
 
 	mair = io_pgtable_ops_to_pgtable(vm->pgtbl_ops)->cfg.arm_lpae_s1_cfg.mair;
-	vm->memattr = mair_to_memattr(mair);
+	vm->memattr = mair_to_memattr(mair, ptdev->coherent);
 
 	mutex_lock(&ptdev->mmu->vm.lock);
 	list_add_tail(&vm->node, &ptdev->mmu->vm.list);
-- 
2.25.1



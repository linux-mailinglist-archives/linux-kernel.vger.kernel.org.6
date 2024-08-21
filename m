Return-Path: <linux-kernel+bounces-295266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB6195992B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 13:10:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D6EB28301A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 11:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F02A1FFA7C;
	Wed, 21 Aug 2024 09:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="cbrT5Ix5"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2041.outbound.protection.outlook.com [40.107.215.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5CC71FFA63;
	Wed, 21 Aug 2024 09:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724233401; cv=fail; b=CC9aRWhmLNlD+8XQYKM9dSgHDqZ/X1SJ4ZSDEhvRuzFQ3LIec2L+9MAMdUkGVxucT7YGiTkEQU3bxiPNxB5cPDSg3STs0Bgsi0vO671kQ4PiZOypPBPBEPTPJ3sEfRCaNUyJ6rt6rewNonKfil7qUecS2V8ZTEy5J5OLiwJ1mY0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724233401; c=relaxed/simple;
	bh=javoh9yV7WrDdF6nED6Caxxup6WdbdzzX/IVbBhNWOw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GX+lsCpl3cZDKahc0O/UDWL9PHqXaOQz8CYB3BHzlQWuvkSZl0+Yjoqsac2VzhRGsn2oGgj/jGvoXCfW+KdExoAfhcuwWFk5guttkITqgu1sxXd2X82MypFA1EF1rgWlY8Z9bcaiLhV00pg8YtVXEftpQJkUg28bxZu1r9EZRpE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=cbrT5Ix5; arc=fail smtp.client-ip=40.107.215.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qJXGbVY7DXTaFEWjOKp4od8tLp99wd3ONEsrtGD7K563q+kQFh8O0Sr71Ifl0cUrEzVIi3+CiCAYgndveiNtLAf5784wVuYzEYCoEOEUTdQ8QYsjO5RtSzXfFpsJWs6wiFPY6zQS/yb17mYM9YZzRQsbxGZ+xUurfsaZrFZdiBA0U3/pkaE26fjH1+m/9rye0vxsV1EeyCfWe54L585Pj/d+myyo0tTvC+pqyEotBFewVmvRuHxw1VtFeVtWvcxAsM+k8RtMk8azrjuXMbGw6wzo3lncxLqUojCDsv0KWt+Qv0OyyikpJmTEF8t0Ef9NO2MnUjZiENgZ3TOoNKMJ/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CE8IuzdQZjntYqD6nUPQnwn7C+BubHdv/yTEbKi/B1Q=;
 b=HIz/kTW1hnMQYI82YuXTdva8kJKvHmygOsFyma2AOkPkOoBw/SkRh63KKsA0tXn2FJMHYOAoqXkDfvxnU62FDFq0ja6iNN7L8j/CWwawdOR4SpvHzVEUsif2gDcXncL74gvGXrcYswkjwxjQzuqBV/VJuevuWEy5zc0vuz1FKL8VsbCgHTZFKNijoAutQmTdQxu+JDOhf/d7HP/0gVmSXycjK5LfTe12NonqUgNqm5wznEvDRbHmOaG9f1McqFFGUefRrVAJEBt4BMMEPHqmeQDREePERsFRlbiW4MtSSvORVuOrmCpzo1bh6/atvLKCMv/xw3/g9TwlGEt4iAg0Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CE8IuzdQZjntYqD6nUPQnwn7C+BubHdv/yTEbKi/B1Q=;
 b=cbrT5Ix5tFtkmtBqecONcZeJP9pU3NZxnUNTeCbXAwDC6K+wKXyb6LHo3RWQC4gmOxZMu6x7isO+ap+dSEJjI9GuKlBQHb3WgJIKvO+Rr+JcpRXKFEipENY8uqyS3hGdJRWwihLhm4GdlYb3oXTC/etzIO1vaqFmg+2pmeuWLlMMCoZtvm23BTciZTgy57z4cvedwRk1AZfwSnYODHzVNtchL+0MbZEXlzhXfxO3FzphJdNnYwmNvsfCIk13o9doGIDqW/AFZ2p2pVH5tDL3qHhFBXwqXFLOrdNPepmPZZnen4Iay6GCKmWoWnSajYWALFi84yNBDt9EviwsWbmvWQ==
Received: from SI2PR02CA0034.apcprd02.prod.outlook.com (2603:1096:4:195::9) by
 TY0PR04MB5636.apcprd04.prod.outlook.com (2603:1096:400:1bf::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Wed, 21 Aug
 2024 09:43:12 +0000
Received: from SG2PEPF000B66CB.apcprd03.prod.outlook.com
 (2603:1096:4:195:cafe::5c) by SI2PR02CA0034.outlook.office365.com
 (2603:1096:4:195::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.18 via Frontend
 Transport; Wed, 21 Aug 2024 09:43:12 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 SG2PEPF000B66CB.mail.protection.outlook.com (10.167.240.24) with Microsoft
 SMTP Server id 15.20.7897.11 via Frontend Transport; Wed, 21 Aug 2024
 09:43:11 +0000
From: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
To: patrick@stwcx.xyz,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v13 24/29] ARM: dts: aspeed: yosemite4: add XDP710
Date: Wed, 21 Aug 2024 17:40:35 +0800
Message-Id: <20240821094043.4126132-25-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240821094043.4126132-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240821094043.4126132-1-Delphine_CC_Chiu@wiwynn.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CB:EE_|TY0PR04MB5636:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: aa21f077-d8da-4300-e0e6-08dcc1c5ac48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LcmIFYIMH0BvzEfSmrIhIXZP3+Nmz32R+VIsjZN7tkMzkr76w0HngK4Z9oX7?=
 =?us-ascii?Q?9d7h8ShKv8iJH0vs975JIHJ9OsbV8IXTBuTU6NhxaDRBho1DFbNAZQBliMXJ?=
 =?us-ascii?Q?2zWLVWKtP8/apguDCnu9y17uCEEdqj78+EUuDsJgZYqVdTabgscNmsQ55LqC?=
 =?us-ascii?Q?jZutWBXwsvkOlbaHFfkorS2eXn2x8quUnWjtAvdgF4FflP4b5ot8A58A66Pt?=
 =?us-ascii?Q?9nA2/ELRgPx7D3jEC9mPNlfkDTXjyNFqWCQbqKX9EPr6B9D2wP/4FaN24OtK?=
 =?us-ascii?Q?k7HoFEmg1KWc84StsNZMt6qJzundcCVk92T82YV6MtPx2oIOgOQ+YyO68gnU?=
 =?us-ascii?Q?qyGp/aZHJkzZxqssiGP7PJrethWBRA/Q9nDQY9CjOvnkxOy4sGxefVVcnalK?=
 =?us-ascii?Q?8Aheiu6YZVd5tQht9wj/5GfLMRIZy+3meGCeI/jWP/hwtsQPUpJ1u1XhReDX?=
 =?us-ascii?Q?GDOezyJYFze/MVZf7AsipsM945jbKugpcW624/GsTnDk9fxP2i5zBExzmKv8?=
 =?us-ascii?Q?RluxPRSrC+OccIOpTKYXTGyukDQwWsx4MtBfDUjcO+HEWTiEFAmGBkR5/WjN?=
 =?us-ascii?Q?aljtKmG2AkWWX0Vz7dm0GqBIiy5F6ashzsKYpqx3WC5Z5Wiz+zNHE6x78fp9?=
 =?us-ascii?Q?7xneOeVm6FFsDojq0NWNK6g0ztcm5U5ONkKiUR/SzghLMuxbyC7yRuqGWwmW?=
 =?us-ascii?Q?7OoNqzf8HRydk422pFej+GIPD7YMFqSPhR060W9XyQUduxsNilymKk4THgIM?=
 =?us-ascii?Q?+DIFsrwSEasvq73czO7f+u2Gt8xVkJcZFMxyozuAbXBb6i40IOgCWaUkBR90?=
 =?us-ascii?Q?T5CRAiQ84xIdSkawYv6fHPG5qOj3bge2baa2w/MGP9jAxcDnzUxkk2pjDxpD?=
 =?us-ascii?Q?bS2rP504oG0xk71z/1LmWD04KwsdzBn0JFGWluQZueOshmJzZDkz6uZkWqgT?=
 =?us-ascii?Q?VH9rmkk/3+TQE48X5BLjEdFND77tzPl0xAzU4KM4xP+GKXJy8JoLvZpDNh2S?=
 =?us-ascii?Q?6Ia6RW0FKaqFwjHvNTn8TBtMAr3MLsiRRX6SGqUP117f6kkfmPVkCTZIRC0K?=
 =?us-ascii?Q?EgY9X5AIPiSDN8KfN/fNqrLaxxgQkPkGWTUyLzrXOaCJeYFqBFJ4nQZ7kq6H?=
 =?us-ascii?Q?uo+ro1tUHWFnary4mOCMBRSgMRDiSxj6KV5WYG/DrqM0nXF70008c8IcA/4C?=
 =?us-ascii?Q?Exv+LnKgR1DO1JhpDVVecr5gZdj21mKVdUJoEHq+D1OsE1VoJ3937HSecmUl?=
 =?us-ascii?Q?0M9K1DpcjjQatI2FFZlZPehLiT3cqN79c5sRahPBsnsWRE1lYvmiU9Q7OA0S?=
 =?us-ascii?Q?85Lg9SK3XGQ0IgmfAwqzLjT+wn8GNZb8ljQjVlGd4UG5wQvSTS8zm1mJWAfj?=
 =?us-ascii?Q?quc5Xkt+SHOIObliRW2K+QgGqM3sk8sSO8vN3ZubM7foSAfiUPMb+GPuILRa?=
 =?us-ascii?Q?9kd9k21BuAHH3WjEoOuIF4VtwYHHVmEL?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 09:43:11.6380
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa21f077-d8da-4300-e0e6-08dcc1c5ac48
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	SG2PEPF000B66CB.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR04MB5636

Add XDP710 in yosemite4 DTS.

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts  | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 2f4e9c5edd5a..f73719b3c2f1 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -978,11 +978,21 @@ power-sensor@10 {
 		reg = <0x10>;
 	};
 
+	power-sensor@11 {
+		compatible = "infineon,xdp710";
+		reg = <0x11>;
+	};
+
 	power-sensor@12 {
 		compatible = "adi,adm1272";
 		reg = <0x12>;
 	};
 
+	power-sensor@13 {
+		compatible = "infineon,xdp710";
+		reg = <0x13>;
+	};
+
 	gpio@20 {
 		compatible = "nxp,pca9555";
 		pinctrl-names = "default";
-- 
2.25.1



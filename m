Return-Path: <linux-kernel+bounces-230376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A8C32917C01
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 11:11:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17CB7B25FE4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 09:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 336221802A5;
	Wed, 26 Jun 2024 09:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="xe2dE0TH"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2077.outbound.protection.outlook.com [40.107.255.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2EFD17F383;
	Wed, 26 Jun 2024 09:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719392935; cv=fail; b=Pc3Y68U/I/7XweY97pge3KRmOrpj8g2H9dhd5LNN1+Kvlpx8JJ6N22SE0VMCZSatehdxQPKxGgLu5xeTW/ydlCu4WRMF1Qd7nxJ2UKkJaqDBrBzj/5QxLsTExRPeKKL9YW4ubN07e7roaRLsbPh1U0WTrwsYdgOBC0FuA0Hx9kQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719392935; c=relaxed/simple;
	bh=zxSLAJW6pbU3CgfYbjG8pJzx4jH9s83cmqcWyMwgprg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tTHIrgksNu27Al9Ih9HUwu4qBBRFgO5NqV08ZcV31gBVZWDAxhXI3todrjMue0vzBzTQxFYESaTL55iivkMPyqq6VxSfJqBkh3AATmIJuEhjXsWAaPITE6FIw6FBQr0eLhkpuN/p6zcIK1OCtQftvMqz0H+bryryKRWHS4X9pks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=xe2dE0TH; arc=fail smtp.client-ip=40.107.255.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RZPzX8EWip/2Nb1H3DXR2raXgkyMf3lmixot/L8lgx4VLhjFy+04x0KJb4JJV0qb8E5rkdBMqC2nMe4bcJb0ux9ld+YHzPZOCU9npfndm0fuyhdgaeRv6LPnF/uXIifQp/7webSQ/TU8R2usnoTjj7L0dtlg0GycBfXQRl7E62TLEMysnADboLn4yzlfikFxmnAMU/52HAD+7nPJxTFhUPsMiLBc/qFvJN7ghykG+wnUDSlb7GaPoFRTJzxRXx2+Y/wEMa6xulvmE7THf9gXNIyKNXhJW9nKqe91k+UCFtCBWKLrzAm/+XFehlQOB9pzUnrBH71VcFQb3gI5o/a2hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ajdRlofMdvo42OVOqGXyRTdshC61xKgWuLqNg7HObWU=;
 b=GLVhWZYiDVbtcqQnixw3ETh4YKFuMkCTu7fAqkyKGOlGou0mqN7Njn2F4WuXIV+bnSuPSyYEQVKsPBrhebzs+xXdKO8G6UXZKjzVcizAs7kn6AjVyL1dplJfZ1D1ETAmOQUkvNlhupz3j7rumPOVTtrLGUp4UCneGMwpA0yPO2LAd78JCYJNaC0qJHwC6DJWAXjZKQlwnMWhRCJMwCDwcMxZk/n6ptqGh/czBuJ6HEsE5j8Nwe9HOzR3zJGHcFVS1etfg/sJB17Vf6wHu5hvL2zAwIKiajf4gQBzIYaykhPPSGXurEcLLXBtW9stwIXyBgic8DMR3r1Iwev6Oz4OCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ajdRlofMdvo42OVOqGXyRTdshC61xKgWuLqNg7HObWU=;
 b=xe2dE0THJx970zU1MOis1CdeQSeJNeapxNskgVCzeUfDVi6mjw4Ob2atpDQrqHl43RlTxxtbAhaSNiayQjqz5US/VgETODWZlkTLiuW1/yyZ2YugfMm/Ur0FlJ2j4ZCKXrD72m3WyVAVWmJBSJQYtp9958Euok+IyzXXpO4WrKvE1yCbVFmFB0Z5cAxVu6Vqonv8M+/lzGRg5qwfKD75WQVE3aKC7EROMA/ajMvjm4exXTX/5Bvh9CPF8C9VEjttyCW947jIaIlReK2nwIvu4pxQYL37BWUptGVx/Alrt9fwmwumpgYikUpp04LIocCEISkpYom0+UW1hsLXJ3q6IA==
Received: from KL1PR02CA0009.apcprd02.prod.outlook.com (2603:1096:820:c::14)
 by KL1PR04MB7291.apcprd04.prod.outlook.com (2603:1096:820:101::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.22; Wed, 26 Jun
 2024 09:08:51 +0000
Received: from HK2PEPF00006FB4.apcprd02.prod.outlook.com
 (2603:1096:820:c:cafe::5a) by KL1PR02CA0009.outlook.office365.com
 (2603:1096:820:c::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.22 via Frontend
 Transport; Wed, 26 Jun 2024 09:08:51 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK2PEPF00006FB4.mail.protection.outlook.com (10.167.8.10) with Microsoft SMTP
 Server id 15.20.7677.15 via Frontend Transport; Wed, 26 Jun 2024 09:08:50
 +0000
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
Subject: [PATCH v9 15/26] ARM: dts: aspeed: yosemite4: Remove idle state setting for yosemite4 NIC connection
Date: Wed, 26 Jun 2024 17:07:31 +0800
Message-Id: <20240626090744.174351-16-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240626090744.174351-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240626090744.174351-1-Delphine_CC_Chiu@wiwynn.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FB4:EE_|KL1PR04MB7291:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 5c4270d9-e722-4ce5-5352-08dc95bf9882
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230038|82310400024|376012|7416012|1800799022|36860700011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DUaLpTlz9YYNJ2HozkxxiAN4qmgImrZvv7Yz/DIADWtOPqTRcCXsVIruL3+4?=
 =?us-ascii?Q?j4f/weQBgllXMbyRNCO3m3RwO88UEDnkejTveTomYnV1J//xaBe3tfp33zxL?=
 =?us-ascii?Q?AXrWhaW7D4ve2Am0AQ5r8kWfCQhvf92ikZET4JZtbkv8xNTZmpu4kUTr5ZDC?=
 =?us-ascii?Q?eo6UePVJv90JRb5CukpaxHlLMW+YjZkpf/+n+a0eMeGJsd6xp/dWK2V2LVtW?=
 =?us-ascii?Q?qIKTDYsT9tXeiHFSy5plVijHwvpoWQ2pADXUzaqFf13ol9v9cqMKA5bo5byT?=
 =?us-ascii?Q?XpMNhtUlSXNnVUg+MCxGCJPp671zSr0fG2dL680w5dzuAO82At+n5akAHr/H?=
 =?us-ascii?Q?HBNi5z2qYdjlJGJLSRexxWV2UeZseEaFifTpefDOs/c5NkR2uB2BgOw8RAeK?=
 =?us-ascii?Q?MmAvszs7kniLHeWC6G9icHdLlmKDackJEUAveobLQQgkS7VEqGiy3coSiHR2?=
 =?us-ascii?Q?duFiDnZJcNRDs7MtZ6vboMvQlFU/jFwlgn0OlG3hXujrDVC7t4263OYCi37/?=
 =?us-ascii?Q?U2XnNeKOx6WcLQF1R2RH/4FKgxJ0NqO3DOps4JR2Fchj/scQydDxziuZgs71?=
 =?us-ascii?Q?OO1Kg1MRpq4L9+k3oc3LkXCpURz/sl4G3bKKqmbkbVMM5pATfAjUMdmemFqN?=
 =?us-ascii?Q?j4kKJWHI/vyvcA5AGU121f0YuK6GeacohUrPlbtFoDpRi9FERKfxZWI5DkxE?=
 =?us-ascii?Q?L0/xAGqXx/g2O31AKvmwqfcqoBdR6FfXW+UyRuUEq/SSNCebauu9wr3WS16s?=
 =?us-ascii?Q?usd00rGt6KcTi/BcK8bQNBY1UPtF8SdC6qRCpXSTC34MGS+mW2W/lutpNusY?=
 =?us-ascii?Q?/bDssR7KcVYjXBLkuo6gguYguHOswCVkS/anm5fczT9r0GoSxL6sLZ44smTe?=
 =?us-ascii?Q?IkQ+TJKRaF1V4rWsnYBRKc2KrCM8JVKxud4TUgNTNopiQq5pecW+UyS+xwl5?=
 =?us-ascii?Q?o64F+O8IZEBIPOpa6tGLKPLMpthR9ykIJ14rFqz/iDfhtkmE8wZeaXpSc3x7?=
 =?us-ascii?Q?gIYUo8+FONKsanUc9fyxmnsmvewABCsOTFTmZjctRQ/xECWvfycaangrsPhw?=
 =?us-ascii?Q?0xDwq2mTK2qHhtQN5EIPOK7H7hniZGqJ6mlU7BXgnvoQ0gKDsuvsaM9UT/rh?=
 =?us-ascii?Q?5DYfV2A5j4ch1g43LhWLVAfo11Go7DYNQPhGAfggKmi7wu4l4V02Ysj187bl?=
 =?us-ascii?Q?MO2NMq09/n1NRAnRsTEERG/XTbd2KVj05eRtGFTXsM8Mvob42U3R6zjHiYMk?=
 =?us-ascii?Q?jO3V1OUpQlGu3FlkDCh12IdGTVuld5re5dkeTtWihtTNppDWOF5HkecFmFfd?=
 =?us-ascii?Q?eoh71HMFU3OR6WLPSf1TfSp5RsfI6o5DP8im8g9h6jO5dfCxL24fFr7NAH12?=
 =?us-ascii?Q?KLHrQNqAdlzWpk54kmTA8Q7wzkdl92aCQvMnYLgeKYuia/G/TQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230038)(82310400024)(376012)(7416012)(1800799022)(36860700011);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 09:08:50.6612
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c4270d9-e722-4ce5-5352-08dc95bf9882
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK2PEPF00006FB4.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR04MB7291

Remove idle state setting for yosemite4 NIC connection

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 67e3c787d675..8b23b012d6f5 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -1235,7 +1235,6 @@ mctp@10 {
 
 	i2c-mux@72 {
 		compatible = "nxp,pca9544";
-		i2c-mux-idle-disconnect;
 		reg = <0x72>;
 
 		imux24: i2c@0 {
-- 
2.25.1



Return-Path: <linux-kernel+bounces-322648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87725972BD9
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 10:15:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E7EA2822F1
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 08:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A36E4185B4F;
	Tue, 10 Sep 2024 08:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="NtNE0YP4"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2077.outbound.protection.outlook.com [40.107.117.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F8617E004;
	Tue, 10 Sep 2024 08:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725955803; cv=fail; b=Bq8ouNfWl62wv9iVRK67E4MrvQ990FD02AFUwLNXdDmcCh6z913bFP4W2i9rT8ljdhfzYd+W1lOcRgBqFlrJs/xz3AFLEF2AnkXbCLr4fzjQ9tgcCTyfwYGXCjRNkfypbg1BXq6igWLYjzNaSXzq+Wdbjl4UNxYaq0E0haYPBvM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725955803; c=relaxed/simple;
	bh=dnLP/PwBapWKYDIDfqxxOkTa6KjlcBj2PcW6kv4Mwl8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=TthS6KQ4GPfjg8Fmw+RX3c3lTxO17AVFOIpuPGMyjaub0Q/YfnOSBCDSnPz5Il3xnL9N9DBEaoIEdqcj0GSWxC6hWaV7LRzL7qjfMCfFdHkCAnqM2Jda1LkjKD/qkA5sw/mSYBQ47eUq85i2arNaDawIRY7sJGT1Bu9taVfo1Gk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=NtNE0YP4; arc=fail smtp.client-ip=40.107.117.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=shRJoR1v6Ai2gu8XKy2Y0HMCsFzkBEqc8yp+3Vwdoy73jhRbGjWKuyc6U6V1ICV4pSb+ItzPmxXPp9zG0MCB1osNXY/n3sIAww/NhvJEbKYKRt6n1Hcc6H/dgKJON85BT7csOFjd2phMP7aR9gbUqOye3aO1kP2TupZn7ZB7D91M8j70q2VuwvnFdmxO26+rozrAWWwC59ft5RW+hsi7TUr3mTC0pTeJ15UxoHEXaJzeyplvJpxZeXNi5lsf0H+ngWZbc7Z38NwxE+QeyffH756Cgx/ItYZGh5Cu9EqEayIcF7Xls4Pw/y9lt7xZgRz6ySQkw2T0GbCxS/yH1GmTAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xpkLZTzj7qJmqrWlI6+MhHyN7YKsyeUth7XT/8GrtLo=;
 b=df2aEzem7URqhRSgWLThpCcEJPbu3Uva/wtOtH98h0v0fjhGpRl577CDR4BIJLAop9SAZMep9vkU2ekEat3E3u63U2A77oBRYlIAIrU7nBQjPp39M5vKh+POQtAI+XeV53nx7mIesAUM5X0y4HycbfEXBVoLB4ydpNrx9E21lU6VJblaTFsmsJy3KlVpZubPbeafc2OueK3EMcla9EL2khRrxhyNTEFMN1JE0DilWoXS8EBIuUzeENkXYL4+Bjy39budPUK50GJi8+L7LMUpKSDEbkEvzqNLXW8DIkixPy2mQ+jUwPSoMoisIkneDXEKUiSbZx/A0DgazixcpUHOWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xpkLZTzj7qJmqrWlI6+MhHyN7YKsyeUth7XT/8GrtLo=;
 b=NtNE0YP4/WuDacvRub4Pv4M0V+igV3NhMdOXYv+mbUp2XkJHBLMIF0UweQZQB3hUW7nt9YOGuN+7EIhqHQhbrvbh33YN3fyQC6/YXF0LwuykYx5j0tdiJ3QuRVzCFxLx3eXMdLJ8f0d8F4oCQeqAj8kue2hU1pcZU4Yb3cijycoFdFnPniuwSxhkR+IRkXIPr/5zQXSy7AsYZsM8Sb1ioFbW6eGv3IKTEPUhLSfUpUluQsJJAi48dRjGRCZ6vimuVXoUGnocvJMepdE60JElldOR7ZFSrqxjXyfippLalVpUtsDh/zCI3LbxiEx8kI9ou7EGhpNphMcsgekYFjVuYw==
Received: from SI2P153CA0018.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::9) by
 TYUPR04MB6761.apcprd04.prod.outlook.com (2603:1096:400:354::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24; Tue, 10 Sep
 2024 08:09:56 +0000
Received: from SG1PEPF000082E8.apcprd02.prod.outlook.com
 (2603:1096:4:140:cafe::4f) by SI2P153CA0018.outlook.office365.com
 (2603:1096:4:140::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.6 via Frontend
 Transport; Tue, 10 Sep 2024 08:09:55 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 SG1PEPF000082E8.mail.protection.outlook.com (10.167.240.11) with Microsoft
 SMTP Server id 15.20.7918.13 via Frontend Transport; Tue, 10 Sep 2024
 08:09:53 +0000
From: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
To: patrick@stwcx.xyz,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>,
	Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] ARM: dts: aspeed: yosemite4: Enable watchdog2
Date: Tue, 10 Sep 2024 16:09:50 +0800
Message-Id: <20240910080951.3568594-1-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E8:EE_|TYUPR04MB6761:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 75aedda1-d33b-4718-fb2b-08dcd16ff413
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RPNy3DrzPL8pvhR3Zep4oHBAMpScE+F7HsVkC9UiwWS4ppSxY29XPdgxGGBL?=
 =?us-ascii?Q?H2LrUkDowevuD5amO38gCYs/L8kK6O8buOPe7zEelso6hIT7YUpdej/E7ATt?=
 =?us-ascii?Q?6V03Ssvl9phbsWfedFJx6a5rkaEToc+RhgeN8Q9FeFUqT/Y9cOga75vKv1aG?=
 =?us-ascii?Q?zu+I+3NNAZ61idfbr91lDg+Rw0fgS2TkNkMmpc0Vm9LO+fLnOjdBNea+yaEa?=
 =?us-ascii?Q?hZE8nhnIXkFOS5Uvf4q1smZDgdfrS21/zB2AkKLoGtaf7Z6pdPnSFXJmvyEr?=
 =?us-ascii?Q?ppkeb209RNXXM27aSJQF9x3OXQisIl7JEEtYD+qtZxyb7hAVLQ+ItWYLQaE5?=
 =?us-ascii?Q?MEVasqZZv+TVDava6IwIiGwADqZ+HZeeF+c/crH9QUyLmZyfXUq1v/1+XNMQ?=
 =?us-ascii?Q?c6W42rnkYlgbxd1EfjVSX37neBPJ81dpF8SDZbTikfZA34VjmGq63xjBa+yX?=
 =?us-ascii?Q?nqy7vxZ+PcL8kNdBuAxINtZWfoA1acim+lPdtBRQPZeLhINL0IMT/gOaAuP8?=
 =?us-ascii?Q?ZsJ446Iars6wD4TfXw8j9T0f2BVCPA9ogpZb7KLHjcsCLjcn4Upp3jOnIemp?=
 =?us-ascii?Q?b13vt6XuzPNVJvNf6NrYM1r18vsp89NV0SDZLMmh/07+m0nyp+4v3X7RKPsE?=
 =?us-ascii?Q?VRJCiLLPgTEUOG0OQUbX20oqum5NHDDbiiFLvo3lgPHGOm/9nRfw2Xk55nTL?=
 =?us-ascii?Q?V8bxBSPOEBJykC90oya9FgRjfZjNcWAxZ/9NK22JE7tKLTng0/BMV3EEkBxp?=
 =?us-ascii?Q?8sQkfnX+QyP8L1kyX5Ddn0njKnL6hwhe1mP7EbJOXxLtQ6Ns0zAONSUHajih?=
 =?us-ascii?Q?rEKkxmf7pKT4UkgEmAFNUIdSKw0s7PR9lcoEuGKDaFFGri4oTfNCbC9yTKLs?=
 =?us-ascii?Q?U5GUr4gasSNBC5vyrRgJx70vEjuMnh+LIR/6UytjNn8ii9+XA/bnRAXpnNC5?=
 =?us-ascii?Q?xDaP6ZXJR2ADuoTbJJ0Xm2k6sIaqZwb8b+sFbVZPBoK4W6Zyx8Ln2e01Ewue?=
 =?us-ascii?Q?g0uKcPSQRB8FSW70E38J5ZIrQ2WbPVZN2AqF/trqDu7DEeDHT3zmWNyMgrr7?=
 =?us-ascii?Q?3ic4vTC1pmmLqPAGrH8bhIyTrEwHcgCb56fq7RGKhdjpZSh+VzHOUetbtFjN?=
 =?us-ascii?Q?SEG88JnWYwP84u/vZToCNYau6VIe5GuiGD9DvUaiGky76/5l7djYChS9Fdgz?=
 =?us-ascii?Q?WfmbNJL3jLof/vOhttM5AY5tieA0kiIsq2PqmHckHnngSGXnzyz3ziuR1yq6?=
 =?us-ascii?Q?9k8jdWvMIpGMMFKo8R/p/EUBbveJ9w1dysYTHT6lthuDU8/yWG9xaVk7a9xw?=
 =?us-ascii?Q?P0oFNdNg6QUC5BTYQ6LiXxo+UDHSwMrvsqrGdcNAEX6kG6BHDHPnHgm55WkN?=
 =?us-ascii?Q?WtAeWw99hVycGEkVS62Gj7YHWufnp12q+nrfkVGkU4Dzq83mb+MlW8t7IihX?=
 =?us-ascii?Q?F41OXmAWoA+jXiWwHwkYG4m76d62Hh/a?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 08:09:53.9574
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75aedda1-d33b-4718-fb2b-08dcd16ff413
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	SG1PEPF000082E8.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR04MB6761

From: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>

Enable watchdog2 setting for yosemite4 system.

Signed-off-by: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>
Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 98477792aa00..c2dd17e0c5fd 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -83,6 +83,13 @@ &wdt1 {
 	aspeed,ext-pulse-duration = <256>;
 };
 
+&wdt2 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_wdtrst2_default>;
+	aspeed,reset-type = "system";
+};
+
 &mac2 {
 	status = "okay";
 	pinctrl-names = "default";
-- 
2.25.1



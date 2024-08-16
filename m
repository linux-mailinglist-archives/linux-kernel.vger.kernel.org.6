Return-Path: <linux-kernel+bounces-289376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF5219545A3
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 11:27:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B404D1C20D70
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 09:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C8C154C0A;
	Fri, 16 Aug 2024 09:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="05ub2pty"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2049.outbound.protection.outlook.com [40.107.117.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27C01547E7;
	Fri, 16 Aug 2024 09:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723800322; cv=fail; b=LICBv+hi3dNQ+lUsvCGQOzcGST9QQPBisPhu/RT1kvjFGo9UYYgJvliPPEtkPc+VgYwAb87ITnoHDJIADRRN7Oz9AYo0R+r3EbUfAdQmEFuE78IKx2Q7SnvRUsyCNyVTptzPn6Vo2jf3kuxG8AfoyC+2XCFjsOmV2pT1+QE/Rbk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723800322; c=relaxed/simple;
	bh=WC/dcjR1tUqtqDip0Xs2AM5RqTGhPS8rf/xSzw8zvQQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=umXpf/40Uehw5iYrWlUpRvx/30cJ3UP5UAfqy6W/Yilh4lIV2upNwPLIpNETEtgQ9/3x/ImaNXtxLyVuxaN0MeYcyfe0dDVO6K7ouAvQUQMUjDUZO79F+gEpXcsp4kNmtjZuWJ2LusrDAJnNAybHwOk0DE7mM3tQTXirqsJUUvA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=05ub2pty; arc=fail smtp.client-ip=40.107.117.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oyTWIM8kiCXhliZDwifHDEvR3PupBJ6SK0HJG5j3Ovr5UlrGsF+YRgAmhNWcj3tnwC0mtwVLVfu/utnpoNLN3BG74HZ7VhCflnZJDH6Bh9yykeU9eoysIRBfyyGZ19BXb5idstepEHv/zYzEjdocjnuYEQmL4yIPagO/Xdtj/xvYE4ZRNXFlUQ5Onok9OBNQEpRxpMgEeK4BQvLCzKMBthowzqeiL/IQYu83Bgwe/IM3rr63cE5+iisNvf9LCinjGvdjtBdfyNBMGB9tIGU/+aa9NTGYAf9APnVwb0wXx2aKtnH86X9p6FvC4bW5WFzaFfrExce3NDcUNf31syimxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fKZ5ogJ9/YHI36u51f7OMva5yJpzuLKM9pz7+UUgD64=;
 b=G8TJGoY4/KfYNbTXKDpe4Zs7gwLKAfOwSIGnzsFA4O6XiZTDM87J5vMN6H7KYzyhTPoEiTAEQ5QHyrPNJY53InfELLeice4yTqnlpK8a0pozJeiYjxArAWN/ivq1LYQn+lxtee4vRJ0JAKImpMFydpDL7PzruqH8IpbOOQU1KM470FO1+ecue7Fwl95My+Byn5IJNMD9ezQpOlLJtnAH8l6Y7ALeAzGjBtVGMeODsgvI90fr4fCy5+GQp8IciaUvB/MW4NDXa9WyZa2BZRouGKfxhBlXuahUS16A3G6heGk0EkfmjMrIfgku0H+G27FhNs5pv5P1jaG6bl09Bny/6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fKZ5ogJ9/YHI36u51f7OMva5yJpzuLKM9pz7+UUgD64=;
 b=05ub2ptyAc9AAgIMIqikOUQ3DJu2aTvqyAUCtXJCvNdknrWxMnUNThtpE9huL/NuOVjcpRjLWOkRR5fx0Cm21zfwZMj/8brm+PqTrMbLo6HPofDt8yjhawVIbpyXq20lslUFwwvpCIJ2965nSh619EkgVIR0SIpt1pst0EeP65PFixx2RY7ggXHKVtI+Yq5wXyNyqcYouDU8hWuvwXG2gCrD0on58xkId3zu1x1InZMg19UEVnlll984ofgw8vHGRSZh3+lRqieoA9YB3vLpd5PTuXQJMT/r5b4kpOyi3I7ZLyCa7csTT+VuUleZGQsR0cBJOFUtdBiY050ED4EotQ==
Received: from SI2PR01CA0039.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::16) by KL1PR04MB6757.apcprd04.prod.outlook.com
 (2603:1096:820:d2::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19; Fri, 16 Aug
 2024 09:25:12 +0000
Received: from HK3PEPF0000021D.apcprd03.prod.outlook.com
 (2603:1096:4:193:cafe::9) by SI2PR01CA0039.outlook.office365.com
 (2603:1096:4:193::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19 via Frontend
 Transport; Fri, 16 Aug 2024 09:25:12 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF0000021D.mail.protection.outlook.com (10.167.8.39) with Microsoft SMTP
 Server id 15.20.7849.8 via Frontend Transport; Fri, 16 Aug 2024 09:25:12
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
Subject: [PATCH v12 10/28] ARM: dts: aspeed: yosemite4: Add power sensor for power module reading
Date: Fri, 16 Aug 2024 17:23:57 +0800
Message-Id: <20240816092417.3651434-11-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240816092417.3651434-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240816092417.3651434-1-Delphine_CC_Chiu@wiwynn.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK3PEPF0000021D:EE_|KL1PR04MB6757:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: d721b589-5c9a-48fd-7a01-08dcbdd554aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7pa49oYdwJ0efriCl2AHwxZW7OuBBeSToUIc5InIEW+Et6+kajK3ApGeyMf2?=
 =?us-ascii?Q?HAMZXw5zg4L8Jf+mrPFdpocAAC8Cv1t6uIhnyTMYxIaFCppTHUNDJ3Ffu4Hp?=
 =?us-ascii?Q?JJgKT4U6h224Sdh2rO8duYVkigOtklE80oM/380H31/KdyIIAINmEQNASSXU?=
 =?us-ascii?Q?0KPIEF2Dbnxs0a1+UPTXIn9rdHH6QFPVEQirCX6iwkyciHWNjmB7/MqH7fHJ?=
 =?us-ascii?Q?tT0rkvN0gb1cMdvftzYkG8zb+3JW5VUGpLBLh5vkc5Wfe6tf2T6D0qqwma4n?=
 =?us-ascii?Q?tmklujk/WcugIsC6+fuimKoX47mnmWmIxknuGhlNoFFD3UxfOlMArMINxKLW?=
 =?us-ascii?Q?knmWhm2uncRfEfMPZQ5V+JROVz63C0/5NRHV3i2Bj1pCizcp5kZDCZGHQsUg?=
 =?us-ascii?Q?eoArL4CwdGoIa+Axa5fJbtJw4avMZT6JESsmIdrJMYxg3pOQsfXj04WjE0Tq?=
 =?us-ascii?Q?6Rlzo23dVyA0TWxWf1g+zwJZiIDNQ4hMs+E17QgWyZq45nL7ICPjshLDCC2C?=
 =?us-ascii?Q?bBgLeaZnHicX8BNQT/uRJewSybRjPuJ6tp5j215dpZ+1Xhd6n0eN4q1T3iQa?=
 =?us-ascii?Q?tZePoyohNLCv9XMlUBe3K5fErdCk0mPKThVq4ij0bVoejEAEamJNPObVda1T?=
 =?us-ascii?Q?M1hadDXXNNVnRdBpG3Iif4YNBYbZtXNYMzG02ex5ag0inEfJ6NvykeuG7qNC?=
 =?us-ascii?Q?RvzKkDYlxw/CGD4EySwAUr3aK8XwVv1uVkoFshAxb0yzODgHzSMTBZWgxkrh?=
 =?us-ascii?Q?1MHlsV7oEtBOBDfdCy8iN49F2MkAsJ7HgVp9SyqrOOv4VvAIix8sfrv6eMXA?=
 =?us-ascii?Q?4yGcqG9u5s2YcIbtaf7Q+PJtn9lOXgK37jjs2CUKm67o1Myo5hxlm80haix4?=
 =?us-ascii?Q?LlVXC3PdrYwb1qdZFIPxl+T1VBGnFSeM580mTx3R/6OrNkEfBWM20Ui8b/BF?=
 =?us-ascii?Q?49/pEvTJk4LKAtSVJQEA21XoUFhVVa3tgUfkNUTXUGOf6TYIOlK3Zj2PNvD2?=
 =?us-ascii?Q?0yu9knNLWzFXsg7u0MdkhVql6IArEYhyfa+0ipoo6uLM59iIVtJnEOQsoJm8?=
 =?us-ascii?Q?TIQbDsc7DyOLWD0gqbX8JQuBLsFIo078NQcvDqeMmUwjfE9ay0882GEA22Ll?=
 =?us-ascii?Q?kV8oU0jxZob1Dimlty3Hnnkk2uThQjPghqVUOMnLwFqXpTkrvvgCnDtD+2Pu?=
 =?us-ascii?Q?yRTwF6KFDHknxKEYUhDoSQO2vIVT8iL6yxVVnIMODl8V5nvA6esEhPKOsno/?=
 =?us-ascii?Q?ES8E2olVHgf6VlbitoLODYgb3bS6Few5YZUJ7VQhKWtj3H9rOSTJq8xu6MbV?=
 =?us-ascii?Q?onmUWUQdzygKXIrUNZltD0h+tTbUKeksvB4DmiB1GPbd9R/PbRO1GfhPEPDj?=
 =?us-ascii?Q?10jRzTd/MPWXkl6AZ+IIJerE5/i+sgQwarSDp+8uvprmkTkmjABS+kFI0+Qm?=
 =?us-ascii?Q?2VvDN0HrmrL4Z9Zeb54YseuI0rdmk2tV?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 09:25:12.3722
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d721b589-5c9a-48fd-7a01-08dcbdd554aa
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF0000021D.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR04MB6757

Add power sensor for power module reading

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 09bbbcb192f5..139a09de24cf 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -906,6 +906,11 @@ gpio@23 {
 		"HSC7_ALERT2_R_N","HSC8_ALERT2_R_N";
 	};
 
+	power-sensor@40 {
+		compatible = "mps,mp5023";
+		reg = <0x40>;
+	};
+
 	temperature-sensor@48 {
 		compatible = "ti,tmp75";
 		reg = <0x48>;
@@ -930,6 +935,26 @@ eeprom@54 {
 		compatible = "atmel,24c256";
 		reg = <0x54>;
 	};
+
+	power-sensor@62 {
+		compatible = "pmbus";
+		reg = <0x62>;
+	};
+
+	power-sensor@64 {
+		compatible = "pmbus";
+		reg = <0x64>;
+	};
+
+	power-sensor@65 {
+		compatible = "pmbus";
+		reg = <0x65>;
+	};
+
+	power-sensor@68 {
+		compatible = "pmbus";
+		reg = <0x68>;
+	};
 };
 
 &i2c12 {
-- 
2.25.1



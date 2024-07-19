Return-Path: <linux-kernel+bounces-256992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 573979373AD
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 08:03:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA0041F2378A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 06:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 183CC12DD88;
	Fri, 19 Jul 2024 06:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="sl0VYhRn"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2085.outbound.protection.outlook.com [40.107.117.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5555F876;
	Fri, 19 Jul 2024 06:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721368835; cv=fail; b=AP0Tj9fKDVGtltqIb/HRmh1RdscKiIdz+hqKi5E+zK/4VqXomYh3HuGTg1frNg2xHtjbNAdEfdzX04TVhS82YTNtSIxwvfvn2/RdNFDgGJme9GvwEtfl4MzUvpB4/ng3EIvnLrHdmJSC4Tz0o5jxE73yiLD5lEMaxrbFWK+ZRf4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721368835; c=relaxed/simple;
	bh=zaOozxHUVJiMg10Ow5jRJ4oxfkoLBzQis4kr0nEJ4aY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hJOX23zxn/MOsjQEc7K0UikZEt52usiA2UPZBF/tCF6Z1Rh43DZ2Jyw3ebJ32qxvNHpG0mmkry0HfkwsX98VP+NVpPub1ct4qKb5RNQGfIHr+TFdJpJcdZhaFpgTv4pRh4kkzxRcj3QYbMT+yPM/hzMRP/tDwX4lhCsjd3Ux2Rc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=sl0VYhRn; arc=fail smtp.client-ip=40.107.117.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OZiwsFN20AdA4gL6BJSTT3HmMsgw8mAgg1qPYXD0ZO05jG2JmnU+TNadnNm/2c9UAzQlEcx4Ce6baREhFZNXvSOODjN8wRtjgQnodzlh218fpNEbJ8nQTkHhucgNb/yjdPeUsHyKNrTlFqFn/hjRSChYur6Htak/YmBBW9dLkscbQR5byJpNC5EtCQzOINVwUtV9XNvD39bLsFNylQYJUxzHpxm8Pg/ZktphU9PjGYVtB1qEVkSRsNMyVNkEhPcO0YOuw1Z8/qnRicZ+qOJwE2meTqIrK5VkmYCqJ16eTZebcRhaqdfnJ6FfMAA9AGLHlrXaCxS9hmgeoT8EQZG11w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9aG2tAObnqGVyXWs4nhAzlLQoN7HCq1EYScCcl7VH/s=;
 b=hWlicmnCaI4D5SEqbpaffebXPAi71sEqiVNdoG3jH/mTbSwTJthm/DFIYop3QPcoRc47D1KkIrrOv/GFdQ4+lBPb3ffffCed21YNwR+hQhXSvkFul084zHWJ/Co4Wel7+xOhNmnOdAuqdPgQ1/I0gCzsIAND24X6Ai9+pyLjpR9GAqX0uy73ZoJGldfCWDAXs961suczI1zJv0J6e8QSXuvjtHtSq8yhG4VAeu/o5Sg+dcg/rWW/AvCrNlkRVeREBCF8sfETON7T6d0o48gPMixp9+5EinnLZcd2lHJBSnIY/JK6/DEVwr+wjLMvnd18wf+P5Ps+AqF9kKUxhJ0f6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9aG2tAObnqGVyXWs4nhAzlLQoN7HCq1EYScCcl7VH/s=;
 b=sl0VYhRncoc4+Z00mj3b6DXOSGYWh0S0ZhOijMu8RfRx/u1/lnIMduaLwzW5FClBqOIOUwNGuTilrspdVZSIKElYATD9vqnQO0zyG8gCRkAPIdR8YMEoHElF5cMyMsFOINNY0Z4OiQCVzJAzVh0+rIjqCzzM5rlvP+TPHyAVpsGACtMmHQ+0anh4nHTg036Y+S7LhGLJEHaqjvHy/MAQSfqGLsS+KBaivCwErKUcZIy4Lurr9y2Lrdf06k3laQKPuQT4868RFWhXYRiBnGmSdsYRjXmqAJtTQKR49KeFgByb2XXuwSwPTz2swXm+TLf6ur3jviPpdqluoOpKx46KPw==
Received: from KL1PR0401CA0033.apcprd04.prod.outlook.com (2603:1096:820:e::20)
 by SEYPR04MB7646.apcprd04.prod.outlook.com (2603:1096:101:1e5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.14; Fri, 19 Jul
 2024 06:00:24 +0000
Received: from HK3PEPF00000221.apcprd03.prod.outlook.com
 (2603:1096:820:e:cafe::64) by KL1PR0401CA0033.outlook.office365.com
 (2603:1096:820:e::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20 via Frontend
 Transport; Fri, 19 Jul 2024 06:00:23 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF00000221.mail.protection.outlook.com (10.167.8.43) with Microsoft SMTP
 Server id 15.20.7784.11 via Frontend Transport; Fri, 19 Jul 2024 06:00:23
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
Subject: [PATCH v10 17/27] ARM: dts: aspeed: yosemite4: Revise mx31790 fan tach config
Date: Fri, 19 Jul 2024 13:58:46 +0800
Message-Id: <20240719055859.4166887-18-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240719055859.4166887-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240719055859.4166887-1-Delphine_CC_Chiu@wiwynn.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK3PEPF00000221:EE_|SEYPR04MB7646:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 1b2d9546-cbc2-454f-c2b5-08dca7b81463
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|376014|34020700016|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?v6f8oMhDgC2gNZ6O7xe2hM9O8MR1+56foZ7YAls6K8QuETa/bv1+byB4Q8lr?=
 =?us-ascii?Q?ubftmlHXdPdwYGV63qqwcioAZHDzRhSrWP3M1LQzcwTrbzmXMyyiTqdLyS6l?=
 =?us-ascii?Q?0PkCu+29rVfyZlEmD4ZzsBatXmScjcLM3dUQ2hiQyaY8byPpjkXkm14BT9wu?=
 =?us-ascii?Q?KcESextoIeM1svo2Pd+DokgibkJT1aya++NLVv4/26ssPHbcNcrLh1tJTX0z?=
 =?us-ascii?Q?6+L/3usZSZ0+J5kY27klAFVN9gJHO3NZmLfCDMcqe9nBIMtjsJHrWgk8HAiu?=
 =?us-ascii?Q?saM9YaF4zdXFlzcASrc/y3R2WXNqwYvaXmLqb7qKYlJ/uD4pAhahANaRZYe7?=
 =?us-ascii?Q?w0r5JGwwpdcIruejOhPkYSwmsCmqDuylrkFevslexKawNUF3bNp0MNSPYYYH?=
 =?us-ascii?Q?ESikNviO5txX7RdEgP/9zLeg2HUQ2g1ujoM4CPbu8orbnpK2VL5v96kPpHwf?=
 =?us-ascii?Q?iShgbTv3B1xtUlW/znD91g80lF7g8PwjlJK3An0rxqsUP/7zFwpG1wTxoaR1?=
 =?us-ascii?Q?Abj/wtVoEVeIThap8R8Kn9M/Ly8lYNVQYAJdeY+qMsFoJeMCGMuTQG3lkgHo?=
 =?us-ascii?Q?0zTXWA4ImIMLV37shx7G0MtLMD6dvjotRkLS28oR0faJHahjl1+Qb0cAKLtq?=
 =?us-ascii?Q?IPUwNKUh2REiGYY7+8XPkZpDhxjSGZn3ItIin3SgxvBbN+muUj5ZlzMNxdhz?=
 =?us-ascii?Q?7jd7m29TMnCBmmn92E9rp6VXXOSzG81UrU3XQ9/fx3QRYwiUpLkPbIzKcgC9?=
 =?us-ascii?Q?tc2idmkuQO82FsBFC8bM3ulHNg75jTMKO3PwI2RsNJZrFh5roxJ+D0XFQqpj?=
 =?us-ascii?Q?yHhXvBqpTNlnAMtDPFCRWsGtYRV7HzBVRlmNmZ0iUb9/QJYEABYkWNA41p+b?=
 =?us-ascii?Q?BDD4u5lXJCSjnDKF8adngqw1iccamWliJV7DysL/QT40bLW0PWPI4sPWuToG?=
 =?us-ascii?Q?GCh0BIOKVVMWfu1t6iWjx6xvSj1izKPe+Z1gTTXD5BpdhvI5hIR6COGGXJZm?=
 =?us-ascii?Q?/BHsJFgIhaq8xDGoZGHyz2uBlxxiTA0pkHMiVMwXu4Swot746G8AXeHUPPrs?=
 =?us-ascii?Q?yJTIyzLfTfutWtNcN4+UZd/Nbk78PyDXbRje/LIygTvM9S6q8LTqGrzB03Ho?=
 =?us-ascii?Q?oBF8aYMBcDYApy935o6TBWYF0uTAtb4kWqmPKModOy/qkl/Fp8NDXTjEiLla?=
 =?us-ascii?Q?sIl6W5xozLqpPQh9hO6AjviI/rg+BljEy5Zdl05AXA/S9fXm+WCjj/EWgNs+?=
 =?us-ascii?Q?/ml2kjwMJXAe5PnltSKfPFYUh/I1gEvCNodQ4u4RWnDxo5qnJgkaybcgFptS?=
 =?us-ascii?Q?nJ1am6mh7ctaZ1ysQ1zgQ2Y/dcc02UrqSI6zRpdy2x/QlDX5gWHGR9fTdSYO?=
 =?us-ascii?Q?VsWNJqBses+N2bOcQW4qT1q9pGYt7/MY3HgqYq/MmHXJThgCq2wB3MJRAdFy?=
 =?us-ascii?Q?oRDkgczZ5al8sMDRhrLv+oLbGfq3mqCL?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(376014)(34020700016)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2024 06:00:23.5171
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b2d9546-cbc2-454f-c2b5-08dca7b81463
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF00000221.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR04MB7646

Revise fan tach config for max31790 driver change

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 48 +++++++++++++++++--
 1 file changed, 44 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 3baf1df11a81..59615a6958ec 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -1103,8 +1103,18 @@ adc@1f {
 
 			pwm@20{
 				compatible = "maxim,max31790";
-				pwm-as-tach = <4 5>;
+				#address-cells = <1>;
+				#size-cells = <0>;
 				reg = <0x20>;
+				channel@4 {
+					reg = <4>;
+					sensor-type = "TACH";
+				};
+
+				channel@5 {
+					reg = <5>;
+					sensor-type = "TACH";
+				};
 			};
 
 			gpio@22{
@@ -1116,8 +1126,18 @@ gpio@22{
 
 			pwm@2f{
 				compatible = "maxim,max31790";
-				pwm-as-tach = <4 5>;
+				#address-cells = <1>;
+				#size-cells = <0>;
 				reg = <0x2f>;
+				channel@4 {
+					reg = <4>;
+					sensor-type = "TACH";
+				};
+
+				channel@5 {
+					reg = <5>;
+					sensor-type = "TACH";
+				};
 			};
 
 			adc@33 {
@@ -1153,8 +1173,18 @@ adc@1f {
 
 			pwm@20{
 				compatible = "maxim,max31790";
-				pwm-as-tach = <4 5>;
+				#address-cells = <1>;
+				#size-cells = <0>;
 				reg = <0x20>;
+				channel@4 {
+					reg = <4>;
+					sensor-type = "TACH";
+				};
+
+				channel@5 {
+					reg = <5>;
+					sensor-type = "TACH";
+				};
 			};
 
 			gpio@22{
@@ -1166,8 +1196,18 @@ gpio@22{
 
 			pwm@2f{
 				compatible = "maxim,max31790";
-				pwm-as-tach = <4 5>;
+				#address-cells = <1>;
+				#size-cells = <0>;
 				reg = <0x2f>;
+				channel@4 {
+					reg = <4>;
+					sensor-type = "TACH";
+				};
+
+				channel@5 {
+					reg = <5>;
+					sensor-type = "TACH";
+				};
 			};
 
 			adc@33 {
-- 
2.25.1



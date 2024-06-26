Return-Path: <linux-kernel+bounces-230378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E941917C05
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 11:12:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D54F7289946
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 09:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6209180A95;
	Wed, 26 Jun 2024 09:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="aEZ7d8vV"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2049.outbound.protection.outlook.com [40.107.215.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419B9180A76;
	Wed, 26 Jun 2024 09:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719392943; cv=fail; b=SbkNnPiR1+f93eQTaGPhM+zWd/drT8ZrOqwmD/CFfTqrSD34C0TbKR23dawc1unmqokyvVmvzYzpTbhxh1Jo8Y/U0ph3ZQqPnyirKMxjjZIPokeHRMdaJJIUoar6KnS5nRT8wPi/Yzrgv4tZ00w6azl97LBtgWTLk3cH0Wmjd88=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719392943; c=relaxed/simple;
	bh=zaOozxHUVJiMg10Ow5jRJ4oxfkoLBzQis4kr0nEJ4aY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LkWr3qUbUs+xJO3jBei7rzy1zEi15NyYy8auu26p9CPfotVO/SKnVbIT/jVzbQKXx315X9VFcdFOVwX4rd/mnOpi0oqDgv5mzKCRgRhe97gC7wub8axDoJzo9+YTwoWKRPRLJbwAdoZa9gUMqUPpIuC6+qxXhzi//0uSkxZOsmI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=aEZ7d8vV; arc=fail smtp.client-ip=40.107.215.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U2PNHKbinxPgM3are9YOYbnUZA2+7WS6c5/EB05ZaZXEpSwR/38yjijnOeN65Y6lt57hGKl1dNqGOSlmtEkzpZiaY012YKwjxfoX5QuXNbPQQTmdUfHQ3pguG0yHHH210fEL6qsF4rSlNC8JoWpF024LgNw/AknP4WF01+NVQQIJqZDM+LP5rPPIQsmCUM4w8NXT7wnoUIiWaw6jifO8BEEvUHra3yCjmMbTVapj9wNvqaH5G+zoRJhSQoD3tuQEbVaYq/yl7s5o4BzdRGwEWsEBtyBEwXeUK3A7I0N5bvtc+UL5o7Z2jlT2d5557Yi0E+SvPeOb0LHqRykbU5wCCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9aG2tAObnqGVyXWs4nhAzlLQoN7HCq1EYScCcl7VH/s=;
 b=M/zP+/VmOx93/wN1YKRIVidwsF+GiU5aqRmImTUZidYIj9Q8IVSpZ6m6jQnUZxzdu5E+KhRG0G853atnvYtholFqWFDI5lIhxujo2kFocSt6tso0O7P/wC8N0JY53wjmNlBn3AhkbsYX+0uN/nCXFJeEq7943nLn1u4xuCoTmFaOIKg63jqb8r63vXkjxnN19+EEAHW3saZGpeReEH3wUHtBevDOM5nd99rPRR1OFQsOJvA1kAlCuWD1HsKX/VZ9CSa5T/NfdtDMkKpbrvtiW4bFlS7/EkXVtsjTm7GHijge/Jq5UGmqfDusE7AODaM1Z2IhrZjwpgJ4qU80nCrImw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9aG2tAObnqGVyXWs4nhAzlLQoN7HCq1EYScCcl7VH/s=;
 b=aEZ7d8vV9Bhx0FGZbjbUKuA5BGB94NBtj8noCjrbR4KbZQhf+Mt9rbJqgsmdmc0EOiN3kyhszZzB/9O4+EIKCO85nZ+HcWpfwEzr9Lso/Vi+yDY1OAHNiC1YJ0T2LNj68E4C0UjWCBVzaP2FjuALjn5LO1wj3nkxFjJUVAqdLUlDorqMbixLWcmdB08frd/ipRfeXt2keTrTHPvRsu/QJ1LyA8ibSMduMPAA5vDTmkHvMZP4xuiUtvKo2lit2WlxRTJfJU3sG42z9ycivR+ECcIT9YgGU/ZWe7aVxjcBuZ+LLnn3gZhDhvhaR+kfpUAj3u1MClc/wMPnzJWyffnzFw==
Received: from PS2PR04CA0008.apcprd04.prod.outlook.com (2603:1096:300:55::20)
 by SEZPR04MB6874.apcprd04.prod.outlook.com (2603:1096:101:e7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.28; Wed, 26 Jun
 2024 09:08:57 +0000
Received: from HK2PEPF00006FB4.apcprd02.prod.outlook.com
 (2603:1096:300:55:cafe::f9) by PS2PR04CA0008.outlook.office365.com
 (2603:1096:300:55::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.22 via Frontend
 Transport; Wed, 26 Jun 2024 09:08:57 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK2PEPF00006FB4.mail.protection.outlook.com (10.167.8.10) with Microsoft SMTP
 Server id 15.20.7677.15 via Frontend Transport; Wed, 26 Jun 2024 09:08:57
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
Subject: [PATCH v9 17/26] ARM: dts: aspeed: yosemite4: Revise mx31790 fan tach config
Date: Wed, 26 Jun 2024 17:07:33 +0800
Message-Id: <20240626090744.174351-18-Delphine_CC_Chiu@wiwynn.com>
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
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FB4:EE_|SEZPR04MB6874:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 8c0fc099-1581-4885-d7e1-08dc95bf9c72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230038|1800799022|82310400024|36860700011|7416012|376012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Gkproa7rro0XWpkl24pcHSlwtWbb8+zPerZ4TKBTF8oIeMbWiUtO54Ds2eTu?=
 =?us-ascii?Q?CdWMwfpdiw0akAOdYeBcHHSC4i7lh8lyieR0fmEl+w+DK+fmElvIIYztwUJO?=
 =?us-ascii?Q?O3MJmSkQJmQl+Z9OL6I6N59xTr22dSKCBOAWBAoWvpLTG5oWfMaVbu51OM+i?=
 =?us-ascii?Q?PPYBsPQ9qYgFg5slQe8TSwesf1sYksJIy6eM/Wfl92uAOBUSfVe1QY0cIaDw?=
 =?us-ascii?Q?FTOGKTe+VUxItSSj8ujvQWeX8J1LKc8e/tdW+nxCUWDq9M55rWNOBrermxNB?=
 =?us-ascii?Q?fLnweXPZB8rfK3BmMb17xUoGyJr0c05hx65xFVqY5mOB02XUkXmJD64Q3RCw?=
 =?us-ascii?Q?ApBcMs5kYMwMHiaoyW1dHghcf3jdBb0bWk5Kv+nq/bwRoKeAsGClnqi4Hfx7?=
 =?us-ascii?Q?3xVpKIUfKb9cbIm48/GHIoFeTAg8Aj27621h/Y54LAsQhC8PwfhLX+NdU2NK?=
 =?us-ascii?Q?nDfrUDZmxnrmF3IjLHV+9cxOlFABUaYqIO4XPI/T643uGNWU1wC6sWlIY8e7?=
 =?us-ascii?Q?mf3U43edOQXoAQT1yNThEIiZYlM0Lw97DiVHOt5Rn/VnPeqm7S8sX3q7bPHc?=
 =?us-ascii?Q?AVSI/eNVIysfkZddKlUD0kfZUV+LuwDdyht+eZDId/tyGtZSbfZEWh9bx6AU?=
 =?us-ascii?Q?p97uWX0lAwQTsHodHp9/S8z0KwmHlKyfFPJRpw8Za+FUxACgzoNjbONsn+0/?=
 =?us-ascii?Q?hrunU4fYymIS7ZonCXwnjbdxjk1oypAxUPzhLv8SYWZovBZ4snfFqBKHfsKS?=
 =?us-ascii?Q?bNYORbNM1Hh9mbGwsrTXxQcbRe/YSYlhSJK5dlrusiiEdFAWlvNifB590OcN?=
 =?us-ascii?Q?Me0vOcZLqrDpXaG3YrmPRsraEaqQCqLJWmx64msXsCwYf6teJWgoQ7/H1fcY?=
 =?us-ascii?Q?ZEPlS1+i+M8DVWciz6YL+zubnojTe/SJicUzIfbaW2X70vzZebUkufmigIAz?=
 =?us-ascii?Q?rs4WaB/j7l4ZXo9CmnOuTG7z39bt+2ATZoVgfPBE/QZB0ROFvlBWuTsKh3RS?=
 =?us-ascii?Q?jReg08YI7INJN32SWRhr4ggoFoH/QZI1i1AI4P9K4Y86a17s3JCXL7AMVa+h?=
 =?us-ascii?Q?YMN9ERJgwZHEmPb5bjCu36Hq5AUDuJ6J338PahYaDrCt83fmgN3PRIDCT/9+?=
 =?us-ascii?Q?9Oamr1iNgkP+Gzz4p//KDvRmrfPUPRDodJiwZjUG0edLv9/MwkpC4z5DO7HL?=
 =?us-ascii?Q?5/nFXX36lZqiYvb1vLffjUgF1T473us157Xc4Q3n6P7lMM7PYGOK0PzWGOnP?=
 =?us-ascii?Q?ZjqPPZO4XbdyShkYcucW9o6yM6MC/1p0sjAGRciCn9OtmGgLse3tvLm7a7pe?=
 =?us-ascii?Q?d4lbaPXyywGNqbLbMtU3kZeOdg8s/vC7jktqWD3GwFduJKEH26DPZHvwySPi?=
 =?us-ascii?Q?lziD97m4palgFY0WMeB2TYMVT4VZyOec1fNikwM02pZRPwBxSw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230038)(1800799022)(82310400024)(36860700011)(7416012)(376012);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 09:08:57.3644
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c0fc099-1581-4885-d7e1-08dc95bf9c72
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK2PEPF00006FB4.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR04MB6874

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



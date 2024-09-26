Return-Path: <linux-kernel+bounces-339849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AA0E986B59
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 05:29:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8EE4283865
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 03:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F329189509;
	Thu, 26 Sep 2024 03:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="J55nHojH"
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11010071.outbound.protection.outlook.com [52.101.128.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28EB188939;
	Thu, 26 Sep 2024 03:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727321322; cv=fail; b=a5zPcP3kJunZM/bAIR9TijJOKPtwbfB28AfpfchMvp43FFlqNBPPJZSjEYowjJlwzBwzJLpeh+54Q+ifDituBgtZV125XGVigx95otN+g5Q8IR5IHid71ygrFaUd3tRU9yr74dnkpi8JWrQGECWy2zRIrOV5yUPw+j6yYKXXgTo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727321322; c=relaxed/simple;
	bh=tgD1BYp0PnHXgVpJqko32siJ7bKTo6ZEAE2v+scyGOw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RsJn1CeYwx+T0/UDn9AZZ3cJp1z2CkiWdNdMOlySXnP2lZ5euw2gPzVBZeg5TnQpfcDmEvR6TT9VJogh8fHl3SHk6/TnwjWjuP0iMN8FF5E5TAq+QaTMfJy5UykmOkyaQ5oE/fuWUuBPu3Iq9r0cska623PaHqiLP5F9yxvH6ao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=J55nHojH; arc=fail smtp.client-ip=52.101.128.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eQsS3MBYVc1WmVRCzwlFCRKSg5IEZfdVfe/zoei8/3M0LzPc9OM+JoXI5/F3flDa+S7kfdlROifUJsEO60gmtdagP0AJXDxeQ24B46muySa7qoj8uGT/Ts9T2y4ai8klC0xDxXxEF+QkvoSAwR0DTua7pYAaMF9PRS2zvqjWGPmPGQ6wug2XEb5VzVKQhL77bCPKzzc4SlD3MNXywVnzs54wEuWjhhI5/QLicpgrEnppCjz5wHc1tsjLMZLXnnuJr9kBDb7jPHIdic1TCWESif4NTbCwECtPyEuFKblNiqJAvxZF6Nenq/XlF25ilpbU/KcrW9AR9eHQo+rn4K4Ivg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AR1SsfuaDtJuUM11jKKgeG1FQIwUxjS6cqjv5SFPDDQ=;
 b=PiKZQggwTtHr4JTjbAmXp4tCyfVH6cB6TKhGKIKHyu0EgMdeYFdY5+/G6gkrEJ1sjYHvHNHdpEFhcbxZL0v+uwlGA9ha+WDAr6zBm25b6kMYWqMbmGihkUtURk04rwqnwL0pjKK3gkt4/XyqZjtrb1QZDTmrK1vRUgqJW166DaDkkNan72NtFSzx43tnSLkULyRiFDQ1ibpGuyfXseW4rRxkvQV9y3RTXTkqcaXZ6ICzaPfGdKAI5nxIAkjMp402QOgYhTRPLDqu6VkTvwvtADaOV92NUpRdOUtjpD9QRn3AZm/5u/an/4MeN+fcykbmrt4YHIV+k8JSZTAFMCDmng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AR1SsfuaDtJuUM11jKKgeG1FQIwUxjS6cqjv5SFPDDQ=;
 b=J55nHojHvKhIh1X6WAFkaelHzkojy8R01QUYfGVdzkXwkycvH9rwxKzTzSvt2Y7Zk6zwysBosUuA9MRT1VeDKC8GKOBsSJYCPZSUAQs2tUEbYZxIiStAOVndBwjbctVv6Z+M+xNu/HkSmeLItKZfQMP4n5brMVNo+APfvXUFxkBPMATlAp7pqsjJEYgTuZasrGtj4gkb7eYxcUIwyJJUn5uwsmK25ETF5g0E0gG6ICSZNYBYwZr2BwzvUVobu/eXqPyqM6NN3D+Pcmt8EkBik0zDhnoQTMHhIuqTKvHOIox96FAQ9uKl7MGbYxMiMtRc5hXGzOHu7CDNRhYrUu/c+w==
Received: from SG2P153CA0018.APCP153.PROD.OUTLOOK.COM (2603:1096::28) by
 SEZPR04MB6855.apcprd04.prod.outlook.com (2603:1096:101:e8::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7982.27; Thu, 26 Sep 2024 03:28:36 +0000
Received: from SG2PEPF000B66CC.apcprd03.prod.outlook.com
 (2603:1096::cafe:0:0:b7) by SG2P153CA0018.outlook.office365.com
 (2603:1096::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.3 via Frontend
 Transport; Thu, 26 Sep 2024 03:28:35 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 SG2PEPF000B66CC.mail.protection.outlook.com (10.167.240.25) with Microsoft
 SMTP Server id 15.20.8005.15 via Frontend Transport; Thu, 26 Sep 2024
 03:28:35 +0000
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
Subject: [PATCH v1 5/5] ARM: dts: aspeed: yosemite4: Add i2c-mux for ADC monitor on Spider Board
Date: Thu, 26 Sep 2024 11:28:21 +0800
Message-Id: <20240926032821.4171466-6-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240926032821.4171466-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240926032821.4171466-1-Delphine_CC_Chiu@wiwynn.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CC:EE_|SEZPR04MB6855:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 64826c1b-1c57-409e-5777-08dcdddb4e1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wvRjxKQWG2sewg2YKSyz0MtIrNamJh5t6kVpvrJ6WNmvR1aAEOU2+R0bEyRM?=
 =?us-ascii?Q?ed1iZYL49jeGt4yfxpJjdVcsak/3MuB30+vsb2oAJA1JVA+Wl0tfHPUwdO/A?=
 =?us-ascii?Q?D9rF9NmXLnjJeDzF8CBN/nfmAwCYiyPmRx4Z8IEwV8EHmihRcuVV4qcBGESm?=
 =?us-ascii?Q?kVFV3bRJQDjVfv87AfreU1Fb1YkpYMQFzFx8c8TrlKlMcjklTnTCXwMK8upP?=
 =?us-ascii?Q?yZX4Sv8WG8NGoUHkK006i4syxqT/aWS2RV/xWr9tlMHXMJxdalUmMwsTD6Yy?=
 =?us-ascii?Q?rjn9fAiHQ9Nf/qHQyRbRIMiBWGG9V/sXrrSK9FmlW39c90IjLWA3E7YHg/JK?=
 =?us-ascii?Q?L7uO09yh7hk2LU3629ibNjb1m/ho7CvE+Aeam4+KT3L82gaQU7lww5Wm4tAo?=
 =?us-ascii?Q?F05CyH6CkEfZmJsyWkLUo0YnW9E+Xz0Zd60CzM9kcT9mJP1dKWmoZOaBjsTg?=
 =?us-ascii?Q?2RwsHe9xFjDY1OLWParFJjyFMGp3cdOKI+SWpSp+R/NYUWbJG7MeQtjYzj+s?=
 =?us-ascii?Q?bXtJgqe+OmeZXDHJYrmfk4DFiUZq8UVLdJifG5vItzSKjkGCTGkPOYn84Ggl?=
 =?us-ascii?Q?FDCLabmYatYMy5WFwlcyeph7/9pByAZGe93nJCv4NSbLfm0BneQSj6652X8G?=
 =?us-ascii?Q?I6w8fDzcZqXjo0NpJz62iIXg10O+xfwywlb9Rt3xK93Ef8ekc0oIWRFXAuQ2?=
 =?us-ascii?Q?z41l++XjiGWL8Uk+TFvjLyvRm191asMj7h4CXaLKTRrRvvdnPB+WBjcGehDz?=
 =?us-ascii?Q?/vftMAbsj1zmUweUQ++U41l2cmoPUyQXvSvG75gZYnNt7pDKkGijhbdy+ObK?=
 =?us-ascii?Q?3RgMRSbuPftiFYXEtjdP0xh2Acpcagn4dbcITE2j7TGpGEjpL1Dwk8E5+7RV?=
 =?us-ascii?Q?VkrVeJWRn48vORCKqQ9N/6HkZL1c0vHS6Dk1Ty2vfYO4OXIVTZrQyFuauszl?=
 =?us-ascii?Q?h68C3YL58uEVDu2PsMQaRDVcuFKPUWOph9FFQrSL7onQXUu2s9N7QUmuKL9L?=
 =?us-ascii?Q?kSeW35Bm1wVFLTOoMYO6pIiQuGlYWXI0TfW27O5Pv31l6MyKNEsX3ZA3qQ3Q?=
 =?us-ascii?Q?fRDC+58Rif111LzyKX1P7AQkA4kFIseKVH/MqZs2UNIilNyWbjNBMugzfAbz?=
 =?us-ascii?Q?8TO+ulQCH7ci3Dl50N1slrA7hI6DIbv3IR4R7dYwnkeCJ/udbSWv4USYi+uj?=
 =?us-ascii?Q?q+m/ILS/XnuC6fnDj5ZWSnsBli9uWDLmsVPAl8DtBMWisyXrmdRY29J6B0kc?=
 =?us-ascii?Q?xvi8lppN1g95MpY59mJDkX049ed1NHuM15HCXjefgYpNAObdOIWsWJOWwkGp?=
 =?us-ascii?Q?g7F3mFpsmJnfWDf7d5+UTV33FPcApwEe5sjE8T+yymn3RRhdPHb1630SV0cV?=
 =?us-ascii?Q?dohpilRu7Abl3rmEK5F2cWX4f3Mo?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2024 03:28:35.0611
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64826c1b-1c57-409e-5777-08dcdddb4e1e
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	SG2PEPF000B66CC.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR04MB6855

From: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>

Add I2C mux for ADC monitor on Spider Board.

Signed-off-by: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>
Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../dts/aspeed/aspeed-bmc-facebook-yosemite4.dts | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 29dd109ebd08..40f6090fcb36 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -20,6 +20,8 @@ aliases {
 
 		i2c30 = &imux30;
 		i2c31 = &imux31;
+		i2c32 = &imux32;
+		i2c33 = &imux33;
 	};
 
 	chosen {
@@ -447,29 +449,25 @@ eeprom@51 {
 
 	i2c-mux@73 {
 		compatible = "nxp,pca9544";
+		reg = <0x73>;
 		#address-cells = <1>;
 		#size-cells = <0>;
-
-		idle-state = <0>;
 		i2c-mux-idle-disconnect;
-		reg = <0x73>;
 
-		i2c@0 {
+		imux32: i2c@0 {
+			reg = <0>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			reg = <0>;
-
 			adc@35 {
 				compatible = "maxim,max11617";
 				reg = <0x35>;
 			};
 		};
 
-		i2c@1 {
+		imux33: i2c@1 {
+			reg = <1>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			reg = <0>;
-
 			adc@35 {
 				compatible = "maxim,max11617";
 				reg = <0x35>;
-- 
2.25.1



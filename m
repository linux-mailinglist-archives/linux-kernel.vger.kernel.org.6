Return-Path: <linux-kernel+bounces-514174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA6D0A35391
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 02:16:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 276073AC018
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 01:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0BC533993;
	Fri, 14 Feb 2025 01:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="w+UJSSR5"
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11010027.outbound.protection.outlook.com [52.101.128.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3A42753F4;
	Fri, 14 Feb 2025 01:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739495771; cv=fail; b=BewZiUKUrIvw7U83eWHm196OxxKkYrrXlMrfWJNXLZPWXwEn3OIZkr93D3N7vI3YncTFrmaxyIm/hPzsryX1eenk0hQEz2HSGwsYnQhT9VwUaTiObNeGOiwdQ2G5YRYVt2Tjhi/FjCUki84ABICF2Lr7br223TwywY7ZywikH0M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739495771; c=relaxed/simple;
	bh=hLoE8s6hfZ1Le8aMcg/4UJMF0L5bmVK+pZIvcTLz75U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=hJcKhMhvJgLCVL8tRpB8Lxa0Y+F0Z8krkp1wXFD2DcrNjypefVKTZX4cEEzyIf9IRK/Z/Z0GZYKSDQ2UzlG1pFcaolfI7mxgYWzgAv5LYEGoExyouM9aM65v/Np9Ub/G++xCdwkBpDP2Rvntdz6JAmjoFZUG+PNRyuuHZJovjNc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=w+UJSSR5; arc=fail smtp.client-ip=52.101.128.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H9QgMYzWIigPnW56Bza9oK6jJ6RLVC7OcUci4PCMbBxDhvfz1HkOh/9POSoBmkV4jx0Pw3NlWOuaAVRtNUt4xsqhzsLaWfNlFFwGyqeWwf/Ik1QQ9oQ8RC491vNK9XigmYrzVwxPg/cx6SW7is+o3ZluqF6lL8/jSXZMRz+KngDCXM5MKjUCG7laTD0y4gZbItgdPRf5HYNqL9KLfVffxKmuAR7zLKfPPR8gQNMjt1n4DL7XU1+GZ0qA/t7Gsh2115eorwBIKEt9RcooCmWuNG4dkG+MQAHJQBFfJJkR2DPGrONtXY6AUPvba/psZIC0l9NgtqPvJ5ukWe4FpXUO0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XhBYabwod4LpaU83iHbE0xRxkIKJmiQo9VgFLEJXSFg=;
 b=SBvztswhTc46f0kdV1b/8ed3aIUNa2NC/erkzAlIV0W7lB7oySa8wqYCHvmnMHdnao38fV1TIyhHxCQqmU90NppP5Pk91tbfSVmgZ6gO9mxxgoBlH7Yxez05A7g+/3B9BMsfX4ccSGyKpTAZJesMcjQ6eZUW/FyT1aHGjiEc4Q5JSBvFMvlq+g3Ybv1dUG/GevJSgme2DD8SJvKN/ZoQMXSeh1LUXVrpgrhBkuDrbH7tRpXXCFFLsdvNqnM7zgTkLAbTyu7gFLE1b7Hnet/Unmj0A8f5o4g6twtOnyVSyOHQwSggramuBNHFugPfBw9560GRyq80zDFk/83VUbJpig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XhBYabwod4LpaU83iHbE0xRxkIKJmiQo9VgFLEJXSFg=;
 b=w+UJSSR5U0zepu5HRVAIFZvjvZRV6DpXl6WvSu3mGIY3uC02MWC0PJ+oQ4eQjSvrEywlNH69FwlXmTnbrbj9pDdVCrPd+2Eunp2FF/ZzvxlI9eKndeF/3T3tE5wQAPYp6LHsWL+cXHkPnWRKa7nEyGgMCnDyUo3VRrOeLzVVg7VHLt9z5ugHavcRsnmRNi9Twz7/P48cNXZLRfJSsLEE34bh9EuCg6paBcJa90O/12eg03MU/9GPaaIlluzbi2OzaUX/s2ac1AdMhqhrwgmTL7pXLxOje93v+Ll+l+GXEktKhUD0yQpV61i/9VxmfgBDoC9gKnkmlGJSsC40Os0pVA==
Received: from SG2PR03CA0124.apcprd03.prod.outlook.com (2603:1096:4:91::28) by
 SEYPR04MB6752.apcprd04.prod.outlook.com (2603:1096:101:dd::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.16; Fri, 14 Feb 2025 01:16:00 +0000
Received: from SG1PEPF000082E6.apcprd02.prod.outlook.com
 (2603:1096:4:91:cafe::d3) by SG2PR03CA0124.outlook.office365.com
 (2603:1096:4:91::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.8 via Frontend Transport; Fri,
 14 Feb 2025 01:15:59 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 SG1PEPF000082E6.mail.protection.outlook.com (10.167.240.9) with Microsoft
 SMTP Server id 15.20.8445.10 via Frontend Transport; Fri, 14 Feb 2025
 01:15:58 +0000
From: MarshallZhan-wiwynn <marshall_zhan@wiwynn.com>
To: patrick@stwcx.xyz,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: MarshallZhan-wiwynn <marshall_zhan@wiwynn.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH dev 6.6 v3] ARM: dts: aspeed: yosemite4: add I3C config in DTS
Date: Fri, 14 Feb 2025 09:15:55 +0800
Message-Id: <20250214011556.1891113-1-marshall_zhan@wiwynn.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E6:EE_|SEYPR04MB6752:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: ed2b0c0b-b767-4a30-fc5b-08dd4c9523f6
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KgrmApvqD4NtljMrZz0G4zZkl/xTIOkdeo1IbwkFqLOS+nN8mnv+QsHX3Qsd?=
 =?us-ascii?Q?9DR8gq9EB0ChAWJkkDIp8h/VGGoin1FA7+mvMvZZ3nyfu/V/GOCgyhkbyH+D?=
 =?us-ascii?Q?0L1/OzRQgeCqCA3nFfu5wqtpWsSPzMyXTeqYQmEIa0GQRG+iFfsHOCESPmQN?=
 =?us-ascii?Q?BXU5ceLSWFu7SnFTaZAkYC2olDV9zdFpLXibh47IhGa2qA54H2SZevoADL9t?=
 =?us-ascii?Q?dnAb8om227XIzPpOHRX4PkPhSO3FPA7wdfKXCQLebKYckc59YajnsUH045TD?=
 =?us-ascii?Q?1hMUlYuFC6fM5ZNNtxFkfdVm7mi8E7UwGnC4vWh/j4egHUEzN3Zy+d9gVFNF?=
 =?us-ascii?Q?dVmYI25dEk2J6GGzkbhC7HEoxVaLkie3f+T5REHY7zm1DINyNn+0QD6j6/H+?=
 =?us-ascii?Q?JxjxBUZgnRlO9zHueGnyiySDibJSmm2w8/5A16vD+0Rsd4lHQ8XrJshztPGy?=
 =?us-ascii?Q?UrazGkEOKuVTPr6xI+3X/2QVfwl++UXBuwKy3Bf0aICnDcXxdv+iO0+svwFo?=
 =?us-ascii?Q?c3Ul2TtjdFmWvXhcMcX0UfAUWBZkAgH/FbQUIaDmiANjA89iVE7flqX+ibsH?=
 =?us-ascii?Q?lxbWjoQmi5rISKXUmCFbwLEkhgqg8igz0ULA4eTX1ppwdK3+3Xs8g98SZmh2?=
 =?us-ascii?Q?+I9Xi35zuPBS5wNiWnxwI9c/m0vNnOBooqHaPOSJddteosinUh7eySr/SeqC?=
 =?us-ascii?Q?vxuc8zp9PRipBgoV/Tvl2/I2DeKJfzIH0Q6m1k+qlkoTaR/8MTXKEhkHp+LF?=
 =?us-ascii?Q?/YLLMlMFvz7q47h9KXf7iaCxzgMTjXd62SD+VPLJthErHHqfXLZ7NRxic+7+?=
 =?us-ascii?Q?WrzLlOnVi6GLLMqSxDer9tCTBz45U/YZ16gpaLo+542fzNokqgKoW9gTIYq+?=
 =?us-ascii?Q?jD4F/rksMeNE/uL7rwUyX1rrP181uOAlMKVHgmaRmSGbif583Lyz2q3zyBv5?=
 =?us-ascii?Q?i3Ldm2tGjShoEA/dnluAaItkgzpHv6fzrirO0y8+tZr9DRvOk/AzJVei7dcR?=
 =?us-ascii?Q?sBnzSUOwyGq/6rm/UnvllILcqA3AleBZXakeQUQSQlgEZirEM75uCy1b8yJv?=
 =?us-ascii?Q?4xt9Jvcu9ceslmrgQbgM4JlttMbeswmTfLjrHcAS+CRVdO7p9dZzL6gilERJ?=
 =?us-ascii?Q?A2auf1StHh3ShrMParIxg9E9nEVj/coKXE9eN8yQUxq2YbkB/9flm+kJso+/?=
 =?us-ascii?Q?3JlXOlPTYu402F5jlEG/2P8CMQJZrMHN5b0dtsC4ddT8WdC7UDpTrHuLUe9c?=
 =?us-ascii?Q?G4JpdtLvsEQVLggUrUDw8pUDOXts+Q/L3jQRdyez7TRMw602X5SYPnlm4JAa?=
 =?us-ascii?Q?vaQBXkWd5Rg3tpBFpHRQDW9s3+cPB2EiOvbw3Zcq3sHfjumGlbG0c33L8Y7Y?=
 =?us-ascii?Q?bfz6HrkGKq3VzhGF+hZzq1IhnJt2AvApBj+102+yyc7W7QNKEzt2QZdet4Ou?=
 =?us-ascii?Q?gq2jTCc6MCXR3OaGoOmzalUNSTd60UUYgCR0RHW3NNAasLwmWQxP+U1gzcjq?=
 =?us-ascii?Q?5FSXlVDuY9UOdUY=3D?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 01:15:58.6517
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed2b0c0b-b767-4a30-fc5b-08dd4c9523f6
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	SG1PEPF000082E6.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR04MB6752

Set I3C config in yosemite4 DTS.

Test plan:
Tested pass with aspeed I3C patches and I3C hub driver.

Signed-off-by: MarshallZhan-wiwynn <marshall_zhan@wiwynn.com>
---
 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 88 +++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/a=
rch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index ab4904cf2c0e..3f98e67674d0 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -1317,6 +1317,94 @@ eeprom@50 {
        };
 };

+&i3c0 {
+       status =3D "okay";
+       pinctrl-names =3D "default";
+       pinctrl-0 =3D <&pinctrl_i3c1_default>;
+       i3c-scl-hz =3D <8000000>;
+       i3c-pp-scl-hi-period-ns =3D <62>;
+       i3c-pp-scl-lo-period-ns =3D <63>;
+       i3c-od-scl-hi-period-ns =3D <380>;
+       i3c-od-scl-lo-period-ns =3D <620>;
+       sda-tx-hold-ns =3D <10>;
+
+       mctp-controller;
+       hub@0x70 {
+               reg =3D <0x70 0x3c0 0x00700000>;
+               cp0-ldo-en =3D "disabled";
+               cp1-ldo-en =3D "disabled";
+               cp0-ldo-volt =3D "1.2V";
+               cp1-ldo-volt =3D "1.2V";
+               tp0145-ldo-en =3D "disabled";
+               tp2367-ldo-en =3D "disabled";
+               tp0145-ldo-volt =3D "1.2V";
+               tp2367-ldo-volt =3D "1.2V";
+               tp0145-pullup =3D "2k";
+               tp2367-pullup =3D "2k";
+
+               target-port@0 {
+                       mode =3D "i3c";
+                       pullup =3D "enabled";
+               };
+               target-port@1 {
+                       mode =3D "i3c";
+                       pullup =3D "enabled";
+               };
+               target-port@2 {
+                       mode =3D "i3c";
+                       pullup =3D "enabled";
+               };
+               target-port@3 {
+                       mode =3D "i3c";
+                       pullup =3D "enabled";
+               };
+       };
+};
+
+&i3c1 {
+       status =3D "okay";
+       pinctrl-names =3D "default";
+       pinctrl-0 =3D <&pinctrl_i3c2_default>;
+       i3c-scl-hz =3D <8000000>;
+       i3c-pp-scl-hi-period-ns =3D <62>;
+       i3c-pp-scl-lo-period-ns =3D <63>;
+       i3c-od-scl-hi-period-ns =3D <380>;
+       i3c-od-scl-lo-period-ns =3D <620>;
+       sda-tx-hold-ns =3D <10>;
+
+       mctp-controller;
+       hub@0x70 {
+               reg =3D <0x70 0x3c0 0x00700000>;
+               cp0-ldo-en =3D "disabled";
+               cp1-ldo-en =3D "disabled";
+               cp0-ldo-volt =3D "1.2V";
+               cp1-ldo-volt =3D "1.2V";
+               tp0145-ldo-en =3D "disabled";
+               tp2367-ldo-en =3D "disabled";
+               tp0145-ldo-volt =3D "1.2V";
+               tp2367-ldo-volt =3D "1.2V";
+               tp0145-pullup =3D "2k";
+               tp2367-pullup =3D "2k";
+
+               target-port@0 {
+                       mode =3D "i3c";
+                       pullup =3D "enabled";
+               };
+               target-port@1 {
+                       mode =3D "i3c";
+                       pullup =3D "enabled";
+               };
+               target-port@2 {
+                       mode =3D "i3c";
+                       pullup =3D "enabled";
+               };
+               target-port@3 {
+                       mode =3D "i3c";
+                       pullup =3D "enabled";
+               };
+       };
+};
+
 &adc0 {
        status =3D "okay";
        pinctrl-0 =3D <&pinctrl_adc0_default &pinctrl_adc1_default
--
2.25.1

WIWYNN PROPRIETARY
This email (and any attachments) contains proprietary or confidential infor=
mation and is for the sole use of its intended recipient. Any unauthorized =
review, use, copying or distribution of this email or the content of this e=
mail is strictly prohibited. If you are not the intended recipient, please =
notify the sender and delete this email immediately.


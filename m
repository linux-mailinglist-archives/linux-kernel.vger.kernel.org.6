Return-Path: <linux-kernel+bounces-187236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E5588CCEEB
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 11:19:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0EA81C2105A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 09:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2FE3140E3D;
	Thu, 23 May 2024 09:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="Pa8/7Ha7"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2089.outbound.protection.outlook.com [40.107.215.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3315113F429;
	Thu, 23 May 2024 09:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716455915; cv=fail; b=OPO2u344plH+aTOMjnvrm0T/Ozp1EVMe8Pg/OtNIxIKxt7blTdZJuFpMq7tPIx9LTXOjIcgO72HORAU253tFp36tyAxryFn1BCzAA18Tby7w5YUcSzlKItqZsxS8hhPGOqZYURHb7PlF2PF1O/BQaIq+jd65YqFLLooxPU8duyM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716455915; c=relaxed/simple;
	bh=v8A+lpCk2uYYWBD3hEpdnkWDTM2NUZHCqXbrsIQNIGo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iKzNzYkYvYzM3sYni95avkJ/Puip2m/G8voXiR4BoD3usl7G7R1sBQ61Ab0S4ldand/UNjJfs+6baVP8jVJjMPudEaPJLhI4wlv8404vUgejtiomSkfnqlrlTdxLsJeD1C7QJbAlP8be4DbKs5uJ7Cx6xiltXG++tNwnJsQBBbM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=Pa8/7Ha7; arc=fail smtp.client-ip=40.107.215.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kAgOMVjKP482Lq6vXi/CzBIDw2BqB/DZxJLIrsoq3RttMgoqnlvzcJxrrIwWBgDmmqyvsv53exkYEMGB6/8gmE9pc0/wlCEG4nTH/yGcH37XVjATuR2fm955A9C1eHBWHISMGR3t4keYuMFHNEqYoV6knk/qRRgUOapiM1SYDPPqjEjnhQtnXgP2PlzXkn5VMjXCh/P+1wTRnlkyAA8QnX8/UbgB791PaW9Wf/T9StJnqbh0fSN4+BHA8Mo/ZDiMvePp528bBjpFfXvAYWjeBlXD1Y6NTMZtI7YLpLXecXdBbVfssKkppUpuK/qEWeQ7ybMkZnaS6ooTQVb4VYYymA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S+DlfI1otun1CAydzoG/8ZXnTLi77JYQ8A3Djz4rKnY=;
 b=Pox37cKGgnERH/N4JvLUZG7mn6LA5R2SWg+v42y8p9ged11hTrwHYe4L65aj3x/FNJOYm7sGvRBu2P1IrUGu6f+sT8tBCtzw8+OceI4rXNicntmsgenSioe3SqtlmTkPHlkoH/LKQFYUnNF+M08DhGj3Spnu2DSwZS7x8rVgHU2KGvy1OhlzqniuMn8iLo+7zuitMYYN6jHJDa+YvhdPRYHihlbGaxnwSIdEnvjTrL7BDVe/iu89exxEFizgEnRd4FG+j7xaOaH6Lxkg/GyMufPCIZ5hTXdkwfEYkcuCkieaoPn0A2NOdRrYu6nzpSCCntxOHqlGp5nO5x1n0OLBLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S+DlfI1otun1CAydzoG/8ZXnTLi77JYQ8A3Djz4rKnY=;
 b=Pa8/7Ha7BfQx1CqKjZxL2Iu/oTjZcnsXi/T5jYiGkYUc9qvK3scph+1qGNKb9GGKi09Vv8L8NCWdCZe+FT8ckU5z37ffdRDxUI+NORdasCjzI5Ez/+UbGzuvsYqwkzB7LBNOH8hwkRB7qfEQ2ikZVNtFbxJMfxLeGxnXEB+G+IG/fhftUqNVeSrJ8Lch/u7dUGN41Kw5f9D1hL/k9Ec5G9hlwM5hEJh+dvFrQCTPCtKuQHuPh8WLyIyvHVsUOXrrx2fq/tZjgvveBVF7B9sDJBWz7y55LXOrpcajr9YNElnOOxrbosdxSBdJXm93WDXBnAgW+69pZUGXM60xpJsOlA==
Received: from PS2PR03CA0021.apcprd03.prod.outlook.com (2603:1096:300:5b::33)
 by SG2PR04MB5939.apcprd04.prod.outlook.com (2603:1096:4:1ba::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Thu, 23 May
 2024 09:18:29 +0000
Received: from HK3PEPF0000021E.apcprd03.prod.outlook.com
 (2603:1096:300:5b:cafe::1d) by PS2PR03CA0021.outlook.office365.com
 (2603:1096:300:5b::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19 via Frontend
 Transport; Thu, 23 May 2024 09:18:28 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF0000021E.mail.protection.outlook.com (10.167.8.40) with Microsoft SMTP
 Server id 15.20.7611.14 via Frontend Transport; Thu, 23 May 2024 09:18:28
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
Subject: [PATCH v8 04/23] ARM: dts: aspeed: yosemite4: Enable watchdog2
Date: Thu, 23 May 2024 17:17:51 +0800
Message-Id: <20240523091812.2032933-5-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240523091812.2032933-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240523091812.2032933-1-Delphine_CC_Chiu@wiwynn.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK3PEPF0000021E:EE_|SG2PR04MB5939:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: c5e0e109-6ef1-42cb-75cb-08dc7b094edd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|376005|7416005|1800799015|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gmSH2o4TIl6eChkf7W5inxWfZiMlktq1JbFCR6YbgcR1v6EXVBb2eXFqGX5o?=
 =?us-ascii?Q?mmKx5Yl7Ihhx5V9Y3UHFquKqlx53WF2ycx92xUL+L9jSMIW9zC6BiGukOFzd?=
 =?us-ascii?Q?6ljgZEv3DbCCEbvgpdOg/sDSfrh/PtFYDiLNhNsC6mN6S59bkSQuaCjY0Tbv?=
 =?us-ascii?Q?uUxwVj1HzJoF+2hTNGDLES+Yju7ABYpszyrAAOxaBWhFYZzyk3LvnNvzrhOZ?=
 =?us-ascii?Q?7FA4o9XskdZML9E6dDIbqJFdYsW7HRefRlbo/e7MRUhJOtQ9yCRCGw73zzmB?=
 =?us-ascii?Q?znvPOPTddmrYldIpY7DZAcX56VmK+Oox09bSCqfQntwLYCPsYUnxGL8P7GuZ?=
 =?us-ascii?Q?r4rR4z0K1rvEJsgiNpLlIEzEqJWEGylJxD9Oib3Zm7XZ4a6mkGH/tF+cu2X+?=
 =?us-ascii?Q?c0cjrsj9WQIRaIoC6RxTVcm9qwyQcwbNqLbAbG+lZ4oMDBRJiH+/goQdlVXP?=
 =?us-ascii?Q?6RvWZOVFubLhVFOgBqhejc+abw9BpEBn2qPqjO16OZk4WbuGzM6mcxZC0UJ2?=
 =?us-ascii?Q?th20dI0x8/QHkZvRZT+wGR2sdZ6RNHvv+NKfhdVIlE4nm+5LHpbCvnOI2xyM?=
 =?us-ascii?Q?vTMUwevWWg6RJCvB5amGc7ihZQauekS5eXMSOPvvivT/duRo7k4E2Epwsvw4?=
 =?us-ascii?Q?3AWzZcLivioU4hAGPuhDB7DE+OLrzl+Ntn8bOgQCEfHuGSNN1SABfLmxiw+O?=
 =?us-ascii?Q?bI3Pl6KtKj/5MTgHnY76j67R9BBZSh8/+19h6QtAQ2KiocAwAX/Mvg0upczS?=
 =?us-ascii?Q?zaLfIwvV9segeNB4rylP6UvgM099aJn068GSwocf70HZOrRE+f9kybLCgOC3?=
 =?us-ascii?Q?yN7Y1CsFsgGCbSnoPu7OIJT+8iwhWPaE3Drbi5GDtlKsda6oaby+MQsYG6Ki?=
 =?us-ascii?Q?+1IqUS5HHYrvMsR19JHACcYMd8m50QPQqaNdUr8PeD/96mZvtapJsPJupX03?=
 =?us-ascii?Q?XrQiAfh3z8jVDeICI4ADW/E+DCak25aj3zI92/u0utDlh+cK+28ul56M+ays?=
 =?us-ascii?Q?5tzX4OWOUedk6JkMu5z/zWCnMzMamnCVbExEqjpwsvD3i1uJTEgwwR5jH3ta?=
 =?us-ascii?Q?rFZszqk85IAAiHe9OpjD652Ub+832Cdrn7XRQhSImdHdQ5ypxIKhtpF3p+sQ?=
 =?us-ascii?Q?WXAqxvTQnEvLUJSaGSMlFqNwclHP317mdXoHCSi4cKhkCTBHL0DUQtYgw76j?=
 =?us-ascii?Q?qBFiUwkz6T8k84bYDVYphN/InlExdtANeITGvIXHs5l1oDf1790KOvRnuYGr?=
 =?us-ascii?Q?ffHy5lfWDpvBJ8hqsSRcYxkgKjRpE4vHF06ZT8ekQorS9NPpcgEc6Hcx5ZWR?=
 =?us-ascii?Q?rm5sIYZQGIqOoWyWrOeu88o7/Ek+nuSqVqNomVPoAUQG3eF3qA9xysSqrQ+D?=
 =?us-ascii?Q?icPYAv0=3D?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(36860700004)(376005)(7416005)(1800799015)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 09:18:28.5638
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c5e0e109-6ef1-42cb-75cb-08dc7b094edd
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF0000021E.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR04MB5939

enable watchdog2 setting

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index effc2af636a4..b0643e8aefee 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -120,6 +120,13 @@ &wdt1 {
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



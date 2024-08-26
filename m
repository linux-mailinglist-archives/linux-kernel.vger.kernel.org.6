Return-Path: <linux-kernel+bounces-300794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8312495E87F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 08:25:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02CE91F2132A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 06:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB5284A50;
	Mon, 26 Aug 2024 06:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="NXPKjTaA"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2059.outbound.protection.outlook.com [40.107.117.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E6C82890;
	Mon, 26 Aug 2024 06:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724653476; cv=fail; b=OMwYVQas+uXFZ6oXPyrsk3Xx1T6evixoBWP415AeIV+gkhnlImncDSaTMz8Nc1oBPFZsSefUCXbHo1x52W1agF6ePsd4KJ9iqkkZriFDyhAbXeNVYOlG/r4wF9ASrIdvkFKdmJcFQ/XYnYvgUrtSQ2PSxtc09eYvDu2VS6cCJsU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724653476; c=relaxed/simple;
	bh=73ACY2H/XC8HiFGPQdCgZZUhtUWvlcJspY0j/8nbnW8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tsMPH50yUPkxjXq/Jfw/3ouwGGKB/krwfS2gQbTe6IkYfhZ2ayEYZ2wgZV24zsESvxF/MCBUncS967SE1rh72Of3pevQl3qZugHLJeCWkillRYcRibxeLbIelE7oa+H9xCM/XYsVrGO91Ua1afVKXfLlgkR9+Z9CUtFo9jXX9wk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=NXPKjTaA; arc=fail smtp.client-ip=40.107.117.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A2AWErY1K/xkbjYftUN6rhY0Af8ShvPUNpiLpC+VrUTJxgDTq4QMpm1sairexxyEYUdYZGs/CTUiMPJpxdaQkruAWZopHzdqSyOI3Gufw/EQ8UDFI/S9LZUWSfWfpZkonZCsi1BQvpNRI7TIU3mm6jVdxosZhDUtQJRFY+LDLST1cinvva3789lKdFYLmRGpFwGyRcPGyFMx4sQEsfI6LWrKAL4NPemUi9DU00t41UDTGKPDwETwBry1XrfuAkf8r5/yN613uO3NPw4BqM+3T6b0+k6eirJ8n2geM4uHjCqePvsSr3rDZW6ZMi5UUZ7Va0prp+GlmM0ivX06z3W5hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WmNKl6yn93kcqul1yKpNviuiMr4uSmPfzjmHAX59pcs=;
 b=m0xnM64B4FMjl/gHEAXt5Jwpbihm9pa2oOujpR+XYzlRY8qIRYa+7Kz0TLYFqEfAFp015UqQ4E2cj5ossuKxgMZ/ku5T3zQpk6e8Kqm7tTH4rY+MhVYWuSXDjoYiYn8/KoJwLzYTDNnMzCjCkDZe5kXltAxBclbsjn9l5LUVDSK9w9cbtDguD5l2ypKcWQ4aryG/P4mlFaXUZQ203Ml3EyQfjM7+CMObg8iQvfBiYX6mefqKjSL/MgCj0HVGovf7MRr+dwcUxur/t3Se1n3hAxZuZDHbjGY/hYX0PYncxGzEnSy/TB8swzdKX4ulr9/G64x3jdWVNs3lIL+/nMkAxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WmNKl6yn93kcqul1yKpNviuiMr4uSmPfzjmHAX59pcs=;
 b=NXPKjTaA4Gm7HbAnGKmQWU9s+ZLmYBGoDSZL0UY39pJ+MnOxw3j1cRQZJPLY6hpodujq2Sruh54Rj6nKWPmXr9kw4mFdNqKa4Hko0CTXZWGJ2LW5cuDPbEwBsyCz0MnTk3sk35tuiZhbJBDGLXZtEXRver1yLNZHb3wWB0C5dULZyBAablwj/+EfMnU9YfLPBFXHn1PuGM6/2AYQplE3Mla9ShTLg5V42BOLcmaSyj3WfTQpWHLUtgiOykYeA71REgNJ3ppfbUoYKxV1vKLptkJ52usXWXfwgUgWvZaQNHJ72cYi/5/HViLByWxQLhP++3lV+vc8+sbpCxdfgT4cYA==
Received: from PUZP153CA0018.APCP153.PROD.OUTLOOK.COM (2603:1096:301:c2::14)
 by SEZPR04MB7185.apcprd04.prod.outlook.com (2603:1096:101:17c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 26 Aug
 2024 06:24:27 +0000
Received: from HK2PEPF00006FB0.apcprd02.prod.outlook.com
 (2603:1096:301:c2:cafe::26) by PUZP153CA0018.outlook.office365.com
 (2603:1096:301:c2::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.14 via Frontend
 Transport; Mon, 26 Aug 2024 06:24:26 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK2PEPF00006FB0.mail.protection.outlook.com (10.167.8.6) with Microsoft SMTP
 Server id 15.20.7918.13 via Frontend Transport; Mon, 26 Aug 2024 06:24:26
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
Subject: [PATCH v14 02/31] ARM: dts: aspeed: yosemite4: Enable adc15
Date: Mon, 26 Aug 2024 14:23:36 +0800
Message-Id: <20240826062408.2885174-3-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240826062408.2885174-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240826062408.2885174-1-Delphine_CC_Chiu@wiwynn.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FB0:EE_|SEZPR04MB7185:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: a0853a50-02d9-4b49-611b-08dcc597bc38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+fFvpQsHvICaBPVxN9sPYH4R3Z9NkV+5KKb+t+snsfFtlqEikB+FHyR8yD/N?=
 =?us-ascii?Q?jOf57s2Yq+R7QyEPre+YT1uAZMFtI4bu7Yq9spMDQTjqQCBzSy2TtthTRfuu?=
 =?us-ascii?Q?yQuTA1V9lnh/fPVw1EzxEF3YgJbhAZESuVI6LPhDZUQ3d1kh4iFwOw2pP3cj?=
 =?us-ascii?Q?kksqlnhcPdRSi1Pk1AjQJIySOhIPwLj1HPiXjr3UI9BOj494UdZKwUpJrIAf?=
 =?us-ascii?Q?97imfvn/pZdNuVktrZdtwAXm0aKXidP5TwV6Q6PktffTg2s/Phk4rRbFLF/H?=
 =?us-ascii?Q?XbLb/bPeVtcprFvqksj8NQaNStNSgfIHkfafrWwWmxVw2pYogHaRqbKRExKi?=
 =?us-ascii?Q?r7hOn4gQ8MfgdXyH+9mQvW+MlE7sRNdoUh0PYybNKpcQtsOufByjCGeSAI3C?=
 =?us-ascii?Q?cMOJ1wa1FksN5dkQU5b5e1kM13ZJ4ACeHGEV+Vu8Y/YTO6RMF5V5CceW68Y1?=
 =?us-ascii?Q?2A+rCXyhJOsmNj37qfP5/W9S/JcMWHGllah4rwzL9/UyI+YYLbQdFpoXjs1O?=
 =?us-ascii?Q?cbtjUP96b3y541/5ckP7QMbdSzFPomnJQILpHvHEr8fwE02cKy6Aw9ISPwfU?=
 =?us-ascii?Q?PfRBw1G41gmjDBHjZNJdwqORvxmfshcGwhHtEyLNRzJctHxrv1A6hXNNgLCE?=
 =?us-ascii?Q?ld5EHf46J84zJ3s6Hrk6NvA/lxvhUQWY0PGizO1rpZHhJyHK6osDSvJjzte+?=
 =?us-ascii?Q?+/e3kp3Jmgafc4LEC1CbpuOh6v4f/l+78x+JfGVZyCa1R+HmiUQdHRuibeYJ?=
 =?us-ascii?Q?JPaqAFSMwDvO4PEkAfr6tgrmcAYVVic+FV2NXXJYSzzngPazwGMRsSqE3qDl?=
 =?us-ascii?Q?rQSNwdZ5Wa62JQ0I6hZb8HGpVLUwoeVdtjFzbxpTCK2ZtOBnNo2RNtTMKPhK?=
 =?us-ascii?Q?RNBT7bSTAvIZoF2JHtq8M0l5O7Zh/UN86BZ5z2dUDi+Pgbh2wwsh56Hnd+CO?=
 =?us-ascii?Q?QdA/rMehFgOJTQdD5n3v/1kWYNpsxjCGba/5WJbQ0FGbw7cvIHjGe1wcnio2?=
 =?us-ascii?Q?ZHaMJw/ZQyA68emlILl00YBfDiuvo9hg/zSH2BZ/eayzmccQqLDyo+QBLUoM?=
 =?us-ascii?Q?2hyU2e5xhU2tsGvZSAmrUeeVl8TiJ8mNRf+a0SG8cfJhxhORacvHYN9x1qYj?=
 =?us-ascii?Q?EpDL/vKSRkUbQJCyyhVjvH28Xu7N1p5io9aT647MrUTSOjNLrRw+UqK+YjtG?=
 =?us-ascii?Q?QyIeHsTF3x/YTG6eWZFrEX46M4BX1JoqSul+pUtWUijNIYJ3Xcexp6pNz5kt?=
 =?us-ascii?Q?gG85EI8xwFfHcGWaTGKEGmS8z2OVHU2NWwMk/Sj7B8TT5RuxjQSu3o1V0SLZ?=
 =?us-ascii?Q?nsYl9RZUreTnve6l/1LQ/Ejup6xMs7fUjmV/Mcuq6QKIdhNma8J0qPEbFxAN?=
 =?us-ascii?Q?ysesF5tFk2B/ehoC/md9wWcPn5bW20Z38VZpiBLQJ9vrTHBRpk1tkLYQnB2A?=
 =?us-ascii?Q?Ir+0cB9yo3c=3D?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(7416014)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 06:24:26.5344
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0853a50-02d9-4b49-611b-08dcc597bc38
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK2PEPF00006FB0.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR04MB7185

Enable Yosemite 4 adc15 config

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index ce206e2c461b..0d659ee2bc19 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -51,7 +51,7 @@ iio-hwmon {
 		compatible = "iio-hwmon";
 		io-channels = <&adc0 0>, <&adc0 1>, <&adc0 2>, <&adc0 3>,
 				<&adc0 4>, <&adc0 5>, <&adc0 6>, <&adc0 7>,
-				<&adc1 0>, <&adc1 1>;
+				<&adc1 0>, <&adc1 1>, <&adc1 7>;
 	};
 };
 
@@ -925,10 +925,10 @@ &pinctrl_adc4_default &pinctrl_adc5_default
 
 &adc1 {
 	status = "okay";
-	pinctrl-0 = <&pinctrl_adc8_default &pinctrl_adc9_default>;
+	pinctrl-0 = <&pinctrl_adc8_default &pinctrl_adc9_default>
+			&pinctrl_adc15_default>;
 };
 
-
 &ehci0 {
 	status = "okay";
 };
-- 
2.25.1



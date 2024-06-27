Return-Path: <linux-kernel+bounces-232003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F2391A16B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 10:27:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 585891C21D12
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 08:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8D99137757;
	Thu, 27 Jun 2024 08:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="sMeUNKl3"
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2088.outbound.protection.outlook.com [40.107.241.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 032D2757EA;
	Thu, 27 Jun 2024 08:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719476818; cv=fail; b=UUlKHCR7JHH85t6zS/7rfd3B7EYJP8OwieTYxg+vSExGFpuMhC8rdwB5AjQKABH8z380DQVOOYvSVIUVDj8g8yGSb82zfbpvB6gvcxgD/GWL3y8vemvIMNf6HuX/hVYsr2nrMgAr8bdUsDrX82mMvtoGBaFwBZDPBmshZvKmFfU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719476818; c=relaxed/simple;
	bh=gQT5Ex8gffizdxeEwhJIjboK1q1LfeHy4PmbLwgo/pA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jVed1AMxHXMKw2kexMpAtc0P/FBP9a6608GsfZIH3Hn/eYj0MtKK0PqUmY42d1Y0YtkDC4ifA6bjXErO7nYveMDP+9tdn+unyf8txLDcux+BySYCpdiGFxEDVcillTsK0Wrhqjk0SBgNgOsLxjr1X18d9pQ8uUIn0mczGwu/Lr4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=sMeUNKl3; arc=fail smtp.client-ip=40.107.241.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aYvNqSUHeGvJAagOaCSVS5Or+RtEgSG3DieWjmP2Yc0h43PiJ7wemRjtlNH+wWgygX/Y+6b7+hdL2AtRggU3mJQGXuwD8OhI8N187lDiYWme/cA3YS6lNpZcfXXtYlKgqs/3EFkisAQXharnLhDbS4BU3QiYV4gGemnidPNce6BePJYEJr3T247Ve2fmEX/uDYQCJW252JDaZ9QaZ6yxsQNV1H7Te1q1yfV5SFsKzQbteVsx7Xqxcoyu6aFAQzpjEWVyNdfUOwHkGYDQ7kBOm4USXEHwFsz0eq4dw8QsMiziEBnHm5Vf7dpCwTbTVrfjsHgPwpC5S5vyNx0b3W6yjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2QZH2YX3rWAv4l6hHsJW4LfTksut3YCn6Qp65bhVg3s=;
 b=R+v0cYwlEksk7E36fPrEil3XksDo7ZFdbNOt8G0+ECq4SHzSkwbt09F7Gv4ENvVxkRlQ5qAC14Ytuw7j2nNvSfaroG0vL8L55N9tCEnMIlkPiaf3mVhR9M7lhXP6vEdmo/b3t+BKUdwz54pvXGmS+OlpzryXKM/TJcfT1NRThFVZ+wmH9ygQXi/WS0I8Ai3MxNQLGTsBb85nRfWhJMgkQkuSsqcYmrQbTbKnSdSzdp3PsfmNP33HP6Mil1x4QssOzx2cGosrFair9/Slwo4xQFwwLjIw5yKBoJtIVKUYjymarA24AguH+YYY3XVue4UO6Q15mvrRTHU0iuW3Cc9bLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2QZH2YX3rWAv4l6hHsJW4LfTksut3YCn6Qp65bhVg3s=;
 b=sMeUNKl3KKBrZf97KOWVuWFGV2/hYaa8uY73snRcHdUHSIb/kTfc3IN2pT8u/keshXRYvYlL2xmFGRzfr9QzHamws0CY8Vwg+/aYg6HtN67cspCMk15UhY91ZnzRcf7xqqqrdCX9ZksKXPYICgKIrlMmZLQv4Xx1fHkKwV/zExY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB8PR04MB7065.eurprd04.prod.outlook.com (2603:10a6:10:127::9)
 by DBAPR04MB7432.eurprd04.prod.outlook.com (2603:10a6:10:1a9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Thu, 27 Jun
 2024 08:26:54 +0000
Received: from DB8PR04MB7065.eurprd04.prod.outlook.com
 ([fe80::8af7:8659:9d42:bd84]) by DB8PR04MB7065.eurprd04.prod.outlook.com
 ([fe80::8af7:8659:9d42:bd84%4]) with mapi id 15.20.7698.033; Thu, 27 Jun 2024
 08:26:54 +0000
From: Pengfei Li <pengfei.li_1@nxp.com>
To: krzk+dt@kernel.org,
	robh@kernel.org,
	abelvesa@kernel.org,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	ping.bai@nxp.com,
	ye.li@nxp.com,
	peng.fan@nxp.com,
	aisheng.dong@nxp.com,
	frank.li@nxp.com
Cc: kernel@pengutronix.de,
	festevam@gmail.com,
	linux-clk@vger.kernel.org,
	imx@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] dt-bindings: clock: imx93: Drop IMX93_CLK_END macro definition
Date: Thu, 27 Jun 2024 16:24:26 +0800
Message-Id: <20240627082426.394937-3-pengfei.li_1@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240627082426.394937-1-pengfei.li_1@nxp.com>
References: <20240627082426.394937-1-pengfei.li_1@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR01CA0128.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:168::33) To DB8PR04MB7065.eurprd04.prod.outlook.com
 (2603:10a6:10:127::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR04MB7065:EE_|DBAPR04MB7432:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e5ca596-8049-4a01-6271-08dc9682e67a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|7416014|376014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IzLNp16bJRl4dydnA4AaJrKmxj/MKIgCjgugvlOEBkOvv/A5BheiiE9Bt9yk?=
 =?us-ascii?Q?eQzgo0iEdsqo8wPF6Ww1k7J/HcEw56ZmTM8n2z+1w34/Vjc8RYPuCU76SaUq?=
 =?us-ascii?Q?EMFQotShQLB8fTfzMYLCULg8lw/Rh/OciIFtRIcTOjjiwnFdYwzsMb/CfEi6?=
 =?us-ascii?Q?jRoFKHVfMbb8flyP4dPULB3LFwds2YI1tdb0TlXqFxtJpY038agfy4VZ8uob?=
 =?us-ascii?Q?LBxkapAzB+Rj/G3d9OQEEnD4xktzckEbqrnfidG6Di1659lQt+guiXpxuOig?=
 =?us-ascii?Q?2UvWFoEZHUjjbSdB9tZnoS4nofI+Y2/f4VRCU+Q6WVyUoLZOf6saPa7epHWA?=
 =?us-ascii?Q?G1vecCX4c0GYn4q7zx3fmc++Doe72AgBtmrIwIGMLHLuUIi2XSZ0t2BDiaaN?=
 =?us-ascii?Q?/xoq+10eJJMKhGe/NkOUyxbnVQiF7w6kVMxZ7QTIEHfEKgnMSiZdbohLn3yL?=
 =?us-ascii?Q?49oKz9bKqkKsKTJ81V6LIMCc9gFXzsNr66OdQZwukksIf3QI5FHxgXhXI4o9?=
 =?us-ascii?Q?khd76LhMhA2/H5RFqrydHQgUwvqpWi6kyYrGRMO1FEAjS7uQ7ej/g9jbfTJW?=
 =?us-ascii?Q?ncY9YVn2gzU8FAbjOgI3g6vtXis6QteZ4X8ftYZWWVX7+IupdZryaT18YZsd?=
 =?us-ascii?Q?DstmmCMFG0atcHCTcq0tS79z6ZQBaReWuknBbufcYbNBq0VOHDv6KtcYkQSs?=
 =?us-ascii?Q?lanNY3sYHdjVJwp+2UPerymD0QsWvneU30Gce/rALRPX3PVwyB5m2JBV248j?=
 =?us-ascii?Q?kd61Y9ZaGVZQZidk/j+Qh2hUgWOWjLqxP0k77Lxyi+fA/oyCgesct95muAIc?=
 =?us-ascii?Q?IJuppkDCIeZXL68N4xRYsrH9FBTMlsB3TJSthD8nW+KoxA9NWAfAYnaVFEhc?=
 =?us-ascii?Q?epAQ+mLG2SWeZV+pupPgsP9wWhAOLX79qM/8Vc5K/rjjWphA46kQAzDXT8pe?=
 =?us-ascii?Q?OR6vYfgAZqM4VNwiWuDBM0MA0uJSVzgqgn1Vwc8Kjt4/MKnBcbaNdHn0Ceci?=
 =?us-ascii?Q?M1Oox+fUiqbKtoEm+FXu4eq9UHzy5u+0bt3faAdbUV7SemOdiaQoyC+6LvSn?=
 =?us-ascii?Q?I5M8DrrPtfgZmKasJyNp1/NVt1ZLneJWy7D4/7QLID6atUSYujVd3eN3fSlh?=
 =?us-ascii?Q?wQOXm17Z1jNXroSEjxPJgEnAUQPJVzPangeZ7M9BOFjzFc84WCeyEegxyyRR?=
 =?us-ascii?Q?bbzzOzUGdbJLndVPgfAvX8/tO2uzNRmtPOq2jduTs6AI02vZEGeaWvcIm/Of?=
 =?us-ascii?Q?TmDeAARZnDg8MgKouXjI/K6vOEqRxxAurLGQoamW0kC8R0nqiXAcg5uV2UZr?=
 =?us-ascii?Q?ZgbKWfJO3onUjXq/IxS4Wjzm8uAUaYKKGUcziCHD5/+R1S/qmR7ExrUvR9q5?=
 =?us-ascii?Q?jF0M/57nVdN9bbXalriAkmj7kywgIMQ6u5ZEM3epX3S9JF09x6Ue7nJ0zo8K?=
 =?us-ascii?Q?C0Ubq7gu4nU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB7065.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(7416014)(376014)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?npHjFpvfCtDdEx+hlKDyHPmlGoFaCFKwtnkzDESZP1wf6WOLssvm1dt/6o9e?=
 =?us-ascii?Q?ga3Ht0IQ7AGIQ9HBDu8/D12+STpFiCna7UQCnsv1/jWpjPMxAyx708ibhHpP?=
 =?us-ascii?Q?iLwhpCy3V3Prreu8qLq5djpw8NISGPfNErg+7H3DVgocKCAc0xvX3+m3y4Ci?=
 =?us-ascii?Q?lgN3fXsgOTQ3b3u3k2LYgRLBEFNGu1rrytm6imNucYUs+qP8HBlRSVqFofWS?=
 =?us-ascii?Q?foxxUF9E/hIHlkn8PSZmuQQ9sdPRxBAelAWGGrR+KN5Yxz9NHrxL+a+lQI/u?=
 =?us-ascii?Q?xsQ/Wsc4UvZXclTNnVJPdOU3m3Jy2CGjPSCvsEzsKG06UCUoujGzzmR3tTse?=
 =?us-ascii?Q?xta/ljdAVKYckagXeoNmMwqXKy+PZqwwgpm1V5OIusMi9z5RnjQXYphqXeaX?=
 =?us-ascii?Q?qirLrUAjiETYmuleGiDlrXSUo2+XKIWaSb393rVXDv4Pv4RAL/mOFE9eqQhP?=
 =?us-ascii?Q?SxhigyRm8qEp6Mcv5s/vBtEPfhjTT4jG61RnydxOd0p3TjvqAArxG3CORZtW?=
 =?us-ascii?Q?dyki3E317vb1G5QyEbZpkx2BQzCPMFO1xEkQAM9q2zrPbYeyntTiRJ0Q4+fh?=
 =?us-ascii?Q?tH97TLtFk6vKUF0QT8M48CqXutSjlQoFX2xr2oQHsZMRfo/QbDtxXuqbFAqR?=
 =?us-ascii?Q?tTxah6UtBpH8SxO+zZ6dpG3DnfI6tkKlAqVHhnU2Bi5MFX4XDnYnEDunY1LP?=
 =?us-ascii?Q?0gv6/AWlqJFdi7pjZOIIYibfXdAyzecChHIrPZMv2ErtjJgm1mDWYxcwm6iA?=
 =?us-ascii?Q?qSgUUwi55ZYvNdZM/Qn+T/OnPCFF9eErmI9VbNHnnbnR/r/Swf6MXtUrvavt?=
 =?us-ascii?Q?VX24EEyqz2fCUOzYTrC4DB6c4SK7ISLDWk/5BWRshvWna5OM7bujfY1Cs4UH?=
 =?us-ascii?Q?fSga+WrxTxVFZozH5sD4ino71EXOsQ7AL5E4IM8uQayNV/JXqVE+ZajHtRtS?=
 =?us-ascii?Q?mpRJ0o1Qsp9m11YjX2pV9Vr1NO0Y7Y6dRTuWsYM5FkxwcWQES/ojhnwcsoRq?=
 =?us-ascii?Q?G5Zj9GE+2vcgXubm3ux5j/QoDgk2U9I3pxn4z1iyf62Bfnf/lmL+yIb0hQpp?=
 =?us-ascii?Q?dp7KTFYe1wfvoiIwiAFS1WvNjNuIP4QFJtMArXxgnktY8os4+i9vojSH7id9?=
 =?us-ascii?Q?sg0gS6NKc3H532rqUBmS9YreMfANtPYSLMLv433x9ed/P9/s+nHJLWPgxyYD?=
 =?us-ascii?Q?BeRMp3hsWQjfnxci+z3gXP1C+vETRPzP94pHldjSGm3w4b44FehyAYBP0MNe?=
 =?us-ascii?Q?eulAJypGY7WGVHw1YJIVRif0hm1AHwNgnSVO+xXMa94+zNCznvjWo6csy743?=
 =?us-ascii?Q?Rkd1eiBGHjlVDkJ/+AErhHZGwJdzybj4ZAtlpEmmAqEpdjvLlqAa0ZAplXtI?=
 =?us-ascii?Q?DoYjM8xopQcmE8a9ijTU+8/YNAZdO+TdZtE2Fmm+/QP5RGmt4S7tsXn8M1ZJ?=
 =?us-ascii?Q?2lQFuf2nBJ8VjuRcd8GRxFfkzwlfaHlXg9l7xQLt8di2QKlKy4LW1RbvglYR?=
 =?us-ascii?Q?gweDFPygSLEP+zSBbdlo5qef/UD/Vhk1dCo7F8sgvUbcWqDmC++CHMS/CEYi?=
 =?us-ascii?Q?SNexgo0PcS34uhzWxP7qklki8X7CbDSIyvK/kywM?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e5ca596-8049-4a01-6271-08dc9682e67a
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB7065.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 08:26:54.1089
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sQaRj2T+LLMzT1AsKTIGlD2xzjDc6eHyiDcQtGxLyRjCb4q7wS9Hngc7EAaeVK5mvPkodU+YxE4Sl0dK107zfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7432

IMX93_CLK_END should be dropped as it is not part of the ABI.

Signed-off-by: Pengfei Li <pengfei.li_1@nxp.com>
---
 include/dt-bindings/clock/imx93-clock.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/dt-bindings/clock/imx93-clock.h b/include/dt-bindings/clock/imx93-clock.h
index 787c9e74dc96..a1d0b326bb6b 100644
--- a/include/dt-bindings/clock/imx93-clock.h
+++ b/include/dt-bindings/clock/imx93-clock.h
@@ -204,6 +204,5 @@
 #define IMX93_CLK_A55_SEL		199
 #define IMX93_CLK_A55_CORE		200
 #define IMX93_CLK_PDM_IPG		201
-#define IMX93_CLK_END			202
 
 #endif
-- 
2.34.1



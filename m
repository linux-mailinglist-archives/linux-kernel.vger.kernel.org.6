Return-Path: <linux-kernel+bounces-228176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 09468915BE5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 03:50:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58FC1B22138
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 01:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92A7E3BB23;
	Tue, 25 Jun 2024 01:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZH2e17df"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2074.outbound.protection.outlook.com [40.107.21.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3649A22087;
	Tue, 25 Jun 2024 01:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719280222; cv=fail; b=su+t17MKVyMt8UySswsNVrLsLRdjQtQSxB7tro6yN6Be+Ri2Cp3nIuiLJbAcsalCkVJD8kBMwYWAlpASZwZBqjZ9h9fqO6DonleR02wjfNw9rtv/SSRr7vFrPhUvulwQDqySM9dj2kdhMJWI1+oJzQTx+NwWdP155zEVRBbPufs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719280222; c=relaxed/simple;
	bh=gQT5Ex8gffizdxeEwhJIjboK1q1LfeHy4PmbLwgo/pA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tX71+JWgPMAfmqYH+CWfLcqSbYupqDhJYV24fVKnb0VS7VA8ezTfd3gFkyO5mD+lYhWZmMTqXNAcFD1RZUP3AQo/e0t/WbqzqrQ7wGTpKQwRgtucL7CJUmR6f0uo6P0Iuc3bwSMBy0Qxm3Of218VNcOwD1sntYxAEddbcGet29c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZH2e17df; arc=fail smtp.client-ip=40.107.21.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hQdklvFdAMaamdGZM5buujI/1X3vzeurmlLQ9nLfYox8JBdi/ScgFRy+0ADG7XUqAbfEXERSu/Ltrsqc8uOmazq5hDdlYi65geFlFx1KaAfdnIVCjpB1WVD3Vxfu4kpeXz4NhEtCXJQiNp8JlEQQH8IR+uhHK2wrmyI7fdyNvIVPDX0db260G7GO4blt8QxkqaIggrdhiU6hNVWwex+/v6swmldamMjA0v23iLEql6J4zSk1WZ0853ay2HwrhU+UKtL2rP7YbNrxJatSdKZuFxp8Ojau/jqRqRF4RpAPH/zu1X2WMYtFHjfTT2uxfgQep4xRU7Nnyza1U1aYvX/saQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2QZH2YX3rWAv4l6hHsJW4LfTksut3YCn6Qp65bhVg3s=;
 b=iXlI80hZsd4z06Tnxpg23krfAoNraumxyO/dPq+2X9nGZ+mvpd0kCYarDpAL+8enFV7Sen/7cEw8K0fW7UkDnkTkFHSrXkEv/7wITnfu4TrLe4Ehc++HZP6BhQswBAPEVe89ZGx0ZRY9QnGwXYG3uLQKGiXDupMtHK6foOGPNgz58H2BW74vPUrO1XZA3YwGhpx2Wv4pMIHTIa4XUJbQWJLK/acGiLFgnMs7e0ayoEU3Fi97gpxVEV2DeUZYEsffpLpSN18vM6+lcx0ZsaSFG3tgrJ24XLOJzeMBkFQ7dISFALWAquwx6Y2VlM+K0z+hoIjXiJOr6gDVbZNtr5IGmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2QZH2YX3rWAv4l6hHsJW4LfTksut3YCn6Qp65bhVg3s=;
 b=ZH2e17dfEMGPPnX+wqpemGDcHMMIwH52vZdVFgJ0d74VOxpiliT4EnOqfDHmtqKbMXjEE3PXef0HWbgQhaA+u90vM3OGpZ7C1UB0v6HbPBfR2PxvMKNZTRJ4ERuNHWdgtz0VuOh3V23Y7am0YEpozZkI5Cm9TTWN2g+7nzxms/A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB8PR04MB7065.eurprd04.prod.outlook.com (2603:10a6:10:127::9)
 by DU2PR04MB8965.eurprd04.prod.outlook.com (2603:10a6:10:2e0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Tue, 25 Jun
 2024 01:50:17 +0000
Received: from DB8PR04MB7065.eurprd04.prod.outlook.com
 ([fe80::8af7:8659:9d42:bd84]) by DB8PR04MB7065.eurprd04.prod.outlook.com
 ([fe80::8af7:8659:9d42:bd84%4]) with mapi id 15.20.7698.025; Tue, 25 Jun 2024
 01:50:17 +0000
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
Subject: [PATCH 2/2] dt-bindings: clock: imx93: Drop IMX93_CLK_END macro definition
Date: Tue, 25 Jun 2024 10:51:47 -0700
Message-Id: <20240625175147.94985-3-pengfei.li_1@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240625175147.94985-1-pengfei.li_1@nxp.com>
References: <20240625175147.94985-1-pengfei.li_1@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM9P250CA0017.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:21c::22) To DB8PR04MB7065.eurprd04.prod.outlook.com
 (2603:10a6:10:127::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR04MB7065:EE_|DU2PR04MB8965:EE_
X-MS-Office365-Filtering-Correlation-Id: 01079968-ed46-4fc5-7884-08dc94b929c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|376011|7416011|52116011|366013|1800799021|921017|38350700011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3MJW+rJ2kIU7vIP5a+IswvpGZBmbIvaXVFEmRiNFnXC40CnKtBnxA226jRRb?=
 =?us-ascii?Q?4kVoLM1XZ2f326sYVCQY+E6XhZKzibrkzz0It2K5iq0jAZmUBiudEspI78yi?=
 =?us-ascii?Q?SHFxIXstPrU3NsIEYzRYkWgkNj1Q1MN/UBPqHYGc5G3SvuN7KgAOsgcwh3iv?=
 =?us-ascii?Q?kI8HSrwinQ80oNq0w4H0woeDTMBAazai8Km5qRZdYKnpqSnZg90Dwe1rZ2Bk?=
 =?us-ascii?Q?rmqgZCDB/BxX9DAgwIeWOWj3o3VfkbnxbzOBJoCKLE+WGQXBDEO/aE2FnC4k?=
 =?us-ascii?Q?KC2Ny/hkhup5O5raCqFx02+2CYeYVUmco629Ypq+YUhirwAcvXKLncwm3nYb?=
 =?us-ascii?Q?Mr4WITMaHWRLyT334lxMZwPRMdLUELXXETsg/GICidjnwzYZ2uWmvxY/Lj6o?=
 =?us-ascii?Q?ewQNY0pQD+hcU1dbdSTE+XzGixW0SUPeZZVatikeRygL4SGObYd3pv555tyq?=
 =?us-ascii?Q?mH7Pk4IblV67NGqCKQ7tq492sJS1w2wfYOiZe2fnilmMLd6UtrUz5Un6rY8x?=
 =?us-ascii?Q?Lc1ihuHcmJ4Acw7iwbFB33oYxcNcz8/CH/NT7zzLlOierlgYFOVSqAs1kvYd?=
 =?us-ascii?Q?7IDzYJRE4ydaXYtdhxygHGLV3yoNQKgtEFlw9seVUPIOM5DBUVNR/ojwDgiW?=
 =?us-ascii?Q?2EMLUHqUPB+7+Nym4q5e49FpEr9UJ2HzN+2HVZYfqxNazE3jh7lWVrCtGetK?=
 =?us-ascii?Q?Euo15fPTpyHESpaBPAoVQzrcOweX2xuDL6pYlLrDC9av7ajJN1LM9YrXnMsw?=
 =?us-ascii?Q?1CoiO2sr6a1RGeN0pMBM3rXfAszLjZzJXRCiaZHDu6G39fHzJI0JiROMxr4g?=
 =?us-ascii?Q?c9/BuKvpw1QCU4/EGXwPVDFNN2FHXwhHm6U6Vd/CF1q+YbKHkAjrq0b5RuwJ?=
 =?us-ascii?Q?T6ecTLyTCOiXZOLz5MZsONgLDy6VPJXQyEQNMa7vP4Ws7bqPI6yuYV5hnZa/?=
 =?us-ascii?Q?482GjuLr+/jDEnL3Ke3HeU1vFrDzr3ZPiuq+n624U0msfeySi2ibCI5ND4jY?=
 =?us-ascii?Q?nsUDUd2NSOEd8W7KTWTbPjdpOa+YrnwMdNpO026u50yaeUJAlnXx4O+6tsNt?=
 =?us-ascii?Q?PDZE5JWBDbtS/abFptJG9v9V/cq17/phgM7DajnOk0aBV5a3T03SnJqK5B6M?=
 =?us-ascii?Q?DpBsrHiJkTFEAaksFmEgXJlQ08fQq+9AGqAbt/OqoByAbHfzPJMnpaKC4AYF?=
 =?us-ascii?Q?rnbNaaFbuMwtIihfZlSL7TT6vycfuybXxYjtBNbamB39yoSG+DSnR0l7BvL8?=
 =?us-ascii?Q?ysxkdF3Fx/vF7nrg4vp0ZFPt+fhwScmOQs9bCgXQLonruPjrHI3EiOuqt1gu?=
 =?us-ascii?Q?cVVybja1GbX8yl4D6QT4fgEH68TYSyJn5d+p9hSr47Dctdqn1FvkdmAK4trs?=
 =?us-ascii?Q?sf3bqa0eq+pbHyGN3CV1/egJ9j+m?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB7065.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(7416011)(52116011)(366013)(1800799021)(921017)(38350700011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4LUaWAfbXJ3OCUECMENWJrOIWdVtyK6MlyeDmNm5sUO7YRcRYQb4zTJDtCeP?=
 =?us-ascii?Q?353NxBz7Xc2oxxXJSOER8zc7s3kJ+rexXMSqWpFXEtQLqBNnavOMeXpGMz5A?=
 =?us-ascii?Q?AXtPGj5nRkZj0KAQzL+asYgTaAh818EKJjLHNjWe7WkRHvxK8HabX0j6m/VK?=
 =?us-ascii?Q?6ik1nT5KPdmx9YepdS9NQdEJrhvagywi3RjQAJUOZQU6yEs9Jc3uh8gT4mV5?=
 =?us-ascii?Q?cQEOn1VV+D8vPdEidFTqy7xJ7P7jkovP0agv8ntiHKS47oX1tUKbFs772T1U?=
 =?us-ascii?Q?4T0R3Rcsp02x4xduUwWr0OkiSw1OT9+hTd/c0T+MBXAomk2mmiV4J+hwpFvQ?=
 =?us-ascii?Q?I+369XgSEEoj2Xb7mHR0jaEubZ3sU42Rh2Iepq77/3DJMavOR9bHWrSmg+no?=
 =?us-ascii?Q?5nBPuWfa3hrPqGx9KNY7VBnSV/FnvaYkPXiV0KGRdrlWPJfUe8MWbpMXKA9x?=
 =?us-ascii?Q?IT+bJu0jAlON4wmNGLflqA9u9+a+4cchTyu5ma9A5kDL/1hQ7H+NW4+6+n9G?=
 =?us-ascii?Q?FuKt2UvRLxV3/ZCpIouNZPmFliskDlEimHG0PI7dTJuKNJSja8sSX3/VVcuI?=
 =?us-ascii?Q?kVvakFHtgsGDh0YCTqcdesHB0Z9aEVsBsyI4hqWLDe4Hv1XIdp0Xll0YkDuW?=
 =?us-ascii?Q?rV6QzTh9xKHzx3BJMxGah8KFioFLZTyhbjbViP8717uHtoEybqA6WocQRDLG?=
 =?us-ascii?Q?S41SNkBi9OUAhJxi52PtBNcANohKX8s58IYyXHZiTltknujj2mwus841dnY/?=
 =?us-ascii?Q?yuMkwOEjkvpyiQFlhScC/ZFHVaTWKesTodpLZ4qFZ9wx4QRRxTPg0cTLaywx?=
 =?us-ascii?Q?B7Cjm/YnvQrWyAEFaZg7WaCjapNdcgYHVxjwsbKZHjZQEVyArZrN7SOq1+bJ?=
 =?us-ascii?Q?I8sq+nqfyV297cECDunlZTnsYaV3ksET5PR9NoT+udMevO23j8BYzdbYNJxa?=
 =?us-ascii?Q?oJJmmpkVtZZO1WgIe3PPyfYBQ/Z7dE43HGqHirsW3IU2TI8WcYzsACVOLhm0?=
 =?us-ascii?Q?5i8ifxgilwJzSD5vqayA815qnfvxdNF5+qTM0FsmD7BlnwMOF9vNxepXFx7a?=
 =?us-ascii?Q?vjRMqrVbzKVkGtck4c6zsSlFyrzXBvpmhOL5DTMnavYkLllVJk8+81rU0SOj?=
 =?us-ascii?Q?Gm2lnkkhiPLk5AEdpKEp38BjgJJCQswCNvEwQP8bpx4bcu4IXQTgMxXtKlLd?=
 =?us-ascii?Q?E/wj/XH5uuxW0MNUa7Uh95ABPdq1U8C0F7/PN/AwCaL86hB69caDDZO3IOiy?=
 =?us-ascii?Q?l5ZSK/1GKEdO4vsETiDehCdT4Zniuuy6EbgtbN+2Sthfe5KXm7GEcqnLcQj4?=
 =?us-ascii?Q?vtvn4ABnhA8gG4ehra90Hmw01ADdxPmFFgHO254/PZu5WwfAzhIPwYuFvX1u?=
 =?us-ascii?Q?5fe0ZMAOuW/Y9FAkL0WDIJ5KjTP7zxdaNtm65pa0rk/56lJU/gnRJqjO0Xe8?=
 =?us-ascii?Q?8+eWLX/k2byUF5x6gidr9IdMOFXJJzKumMtV74mDzn4aTLS5l2W+j8IEvQGQ?=
 =?us-ascii?Q?aacJ1WRulKIk4TGyoA7GJcxGruyaVp31HHLvnlW95aP25+7nHZc0u7yO1DB9?=
 =?us-ascii?Q?7KxhKQuWRDDY36RrmAANiPeyT/v1WGtB5w8Keahz?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01079968-ed46-4fc5-7884-08dc94b929c5
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB7065.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2024 01:50:17.5507
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bn7OIeUyIB3s5TOEJIaMyvw/fZo2kzDZJYTrg/Io3TPYYmigsyr/ZsqxDDMoRLTSmGEjyVqJxVDRiM419bE/Gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8965

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



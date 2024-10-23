Return-Path: <linux-kernel+bounces-377239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D6EA9ABBD4
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 04:48:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FD51284C32
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 02:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BAF973176;
	Wed, 23 Oct 2024 02:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="jTRkAOUt"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2047.outbound.protection.outlook.com [40.107.104.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CF61384BF;
	Wed, 23 Oct 2024 02:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729651657; cv=fail; b=TSnJsom9cgBYQZvuXW/L80ItErwo9gilYynLxLNN/+//4HPIN55k90Lk92nWG679PdPRpLRnKs+PaK9Bam3xTy9s6lVroHiJ6Fn74XHMA8q+JrS12Mcv+hWc1pcCxjIMcGOPTFGYYJmrLSZ8UeuKecBcNYG9HhyZ9QAaoczuaoY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729651657; c=relaxed/simple;
	bh=y8Ppxl90zorPlqLUk38jXQH/WPGiq4hxJL6TkOoxBgc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XnEb1qvn50bhczJrrbbcu8ChONriHAGMV4NwH5Ll03XebGAP+jzQIpr1uvTruUwY+PdKPQ6ea324GYxtDMqWEKWtmBUkwP+aLdVkgKPVmRUEG0zenk/OOBaXf+q/HSfrKhpi/dJ9zvrSoTetH0ihKOeqklmCn0ENWr21OyD8Alg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=jTRkAOUt; arc=fail smtp.client-ip=40.107.104.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lh8fskZTt2MfTXxM3R8RJNdx16HwCKVvQGkQ+mb38I+Qi9oqzupYbsGmNAVfRGOlB8iYbar18ibUcvC77ZNMyWF9FGUhrbt4uYIsnA7tJYlhvQ7aZZqTCOYogJeASJ1BGrYycyPJa76pRxRTBRB9NvLkPTmj9MvvWOnJivkFMNciGUBaxBIv/AKCUfPKIHr02E5igF3lYsmYur0b67ZFXxUUkAr15LQP3RZeU5AYcsYaMQk9ACIesASwT9ybRzNdDgzGbyONFJf0ftOLp8IoNtZe7wYOkjvz6UNune7D/gXir4P0YrTx5btuCV5gecDarsrj97uRUKej55IOPr0hXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c2HNXhTaV09438FPwaxBxpX3LsGkzxD1G2+lVD0T40c=;
 b=ZTHmpZ6ujVxaWv9OcWGDbXqXDsUVHJ1iPjZ4Lpq3C0BZAu/yuqpQiS7Oy6OigVh8T4BrNY38SM0B+pDZvEPV9Xrf/PijhGbasXAga2NdjFo9ArX3XbrL88zqXbLT34Pwm/WHJ1ePT+nvg1w7p6elROEHHzgnnLj/BqB+1gQqm8vGPzkQNH3SJihu+Y0Yeei/N21hrd12ztpuDhxSlpC5oiXpe89Gi87aZzvBQZoz8IdAm/GE5IYMlkCUnZICmNCnXyNvsImLe5iUBKYWBfGif1g21bSOKAumCbBTWxoblkimBDtVIWwG8AJiNFCy/rtuWOAgUMLRrCv4j6aO91JUVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c2HNXhTaV09438FPwaxBxpX3LsGkzxD1G2+lVD0T40c=;
 b=jTRkAOUtRTY5UHII4MBf60LjoC94eIYP416SuIDZht2/qR3c3bRTz9oNcMk/G/1srQCWdERjieSq1QShhLLCMIAlDcjJaezirDO7vmR1d+wlP32zT6PF1RqtN63HL3iJ//QkBB/d0x6oppI1p82JpBGBshQcEA3C53mF1J3XA+icmkGSadnzN7ghtvsL/3UactYlBx6U1THNivLLkEJi247DVEk966yx8TkQgzc+i2Z+i20W1IHQQ2RJEKRTMfXDh7psUEMn7BPAZonLSuj6IxY0vZMqISdlqvSHStytjuuboNQSm78YIQ7tHdowGRgzdsA2M3OZaCF9fg5DGew3Yg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB8PR04MB7065.eurprd04.prod.outlook.com (2603:10a6:10:127::9)
 by GV1PR04MB9216.eurprd04.prod.outlook.com (2603:10a6:150:2b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Wed, 23 Oct
 2024 02:47:33 +0000
Received: from DB8PR04MB7065.eurprd04.prod.outlook.com
 ([fe80::8af7:8659:9d42:bd84]) by DB8PR04MB7065.eurprd04.prod.outlook.com
 ([fe80::8af7:8659:9d42:bd84%6]) with mapi id 15.20.8069.027; Wed, 23 Oct 2024
 02:47:33 +0000
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
Subject: [PATCH v6 3/4] dt-bindings: clock: Add i.MX91 clock support
Date: Wed, 23 Oct 2024 11:46:49 -0700
Message-Id: <20241023184651.381265-4-pengfei.li_1@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241023184651.381265-1-pengfei.li_1@nxp.com>
References: <20241023184651.381265-1-pengfei.li_1@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0118.apcprd03.prod.outlook.com
 (2603:1096:4:91::22) To DB8PR04MB7065.eurprd04.prod.outlook.com
 (2603:10a6:10:127::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR04MB7065:EE_|GV1PR04MB9216:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d978561-7106-4079-9201-08dcf30d0b34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|366016|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tdmntU/zi4UnexPjVZF/mOOfWp/o/N/tlATjlLXVnRixzKSdGnZ5tuSx7nBH?=
 =?us-ascii?Q?hnXfvXQszukocpdaNBKtgql0e2ipoxxJ6AftSzxLi9faZRikINyYK2BKC5y5?=
 =?us-ascii?Q?0Y2Bt4Sw3JhSH0Ydk8yUtD0NVjDwMdu2gh4QGjpnhUAPaZcI59VyX3LB3GFY?=
 =?us-ascii?Q?zSLiBh8cp4Ue/A0i+Py8vbf3uxhFF3OdCLhvfWzO9Kv+2molsKEXqPbVgxHJ?=
 =?us-ascii?Q?xjrfNaOjJWMRfUhv0pC8ekvdE7GAwo6610Od04SqrWmeTQ6tCa/dbq9wIJIK?=
 =?us-ascii?Q?1MskoIWnlnVLpHQI90ziS47HA1QOL+W6nt9Yt57g4GT25YflkvENzbPIzhLQ?=
 =?us-ascii?Q?7s1cmeapA1zHN6PqTSKGKUg7RNjscINeVOzymi8X82RD3C7VgT7j7o4VOcBp?=
 =?us-ascii?Q?G/09B29huIp+0wV8jlSnqEFQc8rQd1PeBxH3XWbooFMSVWwF/W4Ws2+E41t+?=
 =?us-ascii?Q?rtmQ8LNLTGeDUakrZcXDQ1+5EkRLEr1Wy80zyaF3a4QvAi+njHxGTidva6Hd?=
 =?us-ascii?Q?cFOLmmqiQTHD2UN0dFmSWLOdjqOpl8t+nrRdavpjPvBZFxDt6ybhhSPJtX4y?=
 =?us-ascii?Q?OXeSdPq6rucl40xf5ZcHw/G+2g7XX20Xmoun1s7ns8503NtRrfXHstIjgL4V?=
 =?us-ascii?Q?+eS+EhVxbRLt9zqND50pynCr4ajcyLrhMze5pP60Hs29PDh7Qwe61P6f5ORl?=
 =?us-ascii?Q?9gv4Og1zmkFLtTdgRz4H6T2t0oLjdy57RJxWxuVw9B2RMGDf7UFFQXTHSSEq?=
 =?us-ascii?Q?6tE+kaSV/WzpgFjSEan1IrNRb48bdak6X6BAvZiEa03qV6isYnWHo7s1Z7a3?=
 =?us-ascii?Q?oX53BAaVZ3XYS03cige5unKyGImbG9xaVlsVJm197HDboow8BKm3jLU5OEiX?=
 =?us-ascii?Q?FXXjrxdke4bVjR8uctQD4S356M994xpIQmOT1Jc4PE6oynFqNowkglGdC5WU?=
 =?us-ascii?Q?tNiHhP2aqsiNh0aOnPU/iKDB7X7u6QrLFChtIZFDYhRSnFCBw1ScQWQ7C/CQ?=
 =?us-ascii?Q?tqRS/kZQRuw1su7zZh6QbeYkDWa5fgubls22G+L+NeDbpSR6f9L0f8H/pr8y?=
 =?us-ascii?Q?R0/NBtclwmgTUq0z0Cd6EnDtIMXqp6axTZaopjFVVbJ8YPlo/achqhvGUUoX?=
 =?us-ascii?Q?iYANodLL7iFl65XJDcHAL1wPMr1mCvgJTgLxeqLZ9s9nNXZbRkn18wyXIfsB?=
 =?us-ascii?Q?d4X12qr1b5frucrPt/20tLCvcVVpQXKDlU6Hux8h6AXh7fOSvcPn+urst1E7?=
 =?us-ascii?Q?yYOMoPZhrxCXscjLRmEpgzg1I6g80Ap7PcH8Ye4JBY1noOV7I9uO3MbR9U/x?=
 =?us-ascii?Q?UWqVJuQ79sagF+1K3qrO5lU86tou7cjljDba9wksixfOddowXm7Piad8e9+T?=
 =?us-ascii?Q?vjkEu9kbDl2mtmrL8f/s4yq0IOho?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB7065.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(366016)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uXQtwMgcNInmc5VzHq1TgPAjX2UezppLcFAORoT648qNOmmHS+RPQEUsfDGe?=
 =?us-ascii?Q?e2vFMryhw3ABvqhDXxpLQBzuTc0cLtW5rQBY+mPYs7wF4QLnS9QREqbPMhxF?=
 =?us-ascii?Q?xuNHm3KbIiId2Os+DDLKrH5haYhCqLGICopAu2LIOSAn8DluvuFXapZFphi+?=
 =?us-ascii?Q?e7frYesqY6g141jpmxSPFcX0dkxoS1Mty69BFyGCUjU4VHpGSlQDkBtnNf9c?=
 =?us-ascii?Q?8kSEUQcCqzxcevy9jB1KHLM1/6mBJ8zdE/339j9Bwpi1i1FK4qGEz+2CJPW/?=
 =?us-ascii?Q?aBoSpjgciZ0R3XsJG62YzOcRDTJtpnTck8OpK56hLhgY3mG/JLTh8iZc5yNc?=
 =?us-ascii?Q?h5i80wk1WZr6XnceoO/SZqsieQgeP1dx7wLA1pizYEco2ggU2dvkKC7pKbZf?=
 =?us-ascii?Q?YADD8tzps09lCPn07Gwu/444ZoVaTH9w2EjY4jLeZvIsVqfoPCkv086PMEOm?=
 =?us-ascii?Q?DmW4MufJzJkIDzcYFC+UqhuNw/y4LT0RK6+acqqqNau8kkQoXRGpvIthJsPW?=
 =?us-ascii?Q?iTIqDXT93HFQU9b6V0jXmTxlx4lk5ZhRZx53JugnKNKg+pKYNcv4vEWMlttr?=
 =?us-ascii?Q?PiRZPBHwy0LqQOc4E9syYjvIcbLXQ3QTrNUyFKD/rRLBw0lCUCEWisiI+lcW?=
 =?us-ascii?Q?EMuG8sHgzE7BBedoWKHRJC3S3a5/lePFYflK02dzjs2c8ib6nuBD7DoUqkUJ?=
 =?us-ascii?Q?Tpz5cuYSFnVH4OJLfg4Jt0jIiZdS+vVcJplHIQ/fmrk8oZJaTxZ+/TMMv8hc?=
 =?us-ascii?Q?NScIvJo/eACq70npd1ErZjnqCXV0ztZmLADy2WrbVOj9yeS23hw6UNBFggDi?=
 =?us-ascii?Q?hh8l7ePAWrr5MwwWJh9T+1mI5pOjBCw3/cmVgaLiim0W5u+/GyPIogUVPyN6?=
 =?us-ascii?Q?eJ9c1GjfFMqzN2FkZM5wEV+UN94IBlEb7BdUnDi+UI9PnWBR9QYvcqiyOMoB?=
 =?us-ascii?Q?McAnW6RA15dtFkw0b9cNwEjNYN1XfkQ3uGO90bTqIvTzk8rotkesh9pYjfq/?=
 =?us-ascii?Q?qCiqg+yBVpxZ26GdQfx0y4GsHWScrKV+jFFovst4FLFrx/YynHjigUqLwnUw?=
 =?us-ascii?Q?JBYDKnackUMEbGPj6nyZiVMCPDrwIEyfuY6/5QLEhxftGZsJpIyndg6/ncZn?=
 =?us-ascii?Q?cUQehatCMipqGlpOCNxrHX4+moSM2wegYf0ectGiaHE3jRXQjOIZCPTNV1vh?=
 =?us-ascii?Q?0jb6k3b8OA3EVnLhKa90i3vlt5UV0LvRzYlMC1q8hbMsxD7ME51+ZDI81CVn?=
 =?us-ascii?Q?lAr3nw3GqJ7LNkDA5CEkHIg3vYxEF46AbPvOMFroKE3M7/WEUT2oPRNjvCoc?=
 =?us-ascii?Q?8uKRZRtg6hrcbciSs3MXr/iu9eC7jDsn2vjIAYnH4dSUIHFetRq8Uiza02C+?=
 =?us-ascii?Q?eadLVD06IbtRhONvTq4kNN+05mQORq0eoyhLCy2JK/qZl+nOD6b7phlH2zP5?=
 =?us-ascii?Q?3gpD5AR31bco432Xl4S/+NSiePPU0sAa1ENWTmuAf2I2DHTBqER42OSe9MHV?=
 =?us-ascii?Q?GaaWfcQLjcFGVg9ykBID5eDq8XiufWuJeeFlaQo2n7x8lfd2bfO2qY3TEYRx?=
 =?us-ascii?Q?66oGhujDvrvzRPa2NviLP1O75V/tIX8vdLbDrwWS?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d978561-7106-4079-9201-08dcf30d0b34
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB7065.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 02:47:32.9447
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OsYDJZFjWxqy7FPrZM2aHqFnnd5fEEtuZ3FBuQKgXSHfFMVkid7fgDxiZkFquc2roQNLnYK8Dkqov5g7EHebdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9216

i.MX91 has similar Clock Control Module(CCM) design as i.MX93, only add
few new clock compared to i.MX93.
Add a new compatible string and some new clocks for i.MX91.

Signed-off-by: Pengfei Li <pengfei.li_1@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/clock/imx93-clock.yaml | 1 +
 include/dt-bindings/clock/imx93-clock.h                  | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/imx93-clock.yaml b/Documentation/devicetree/bindings/clock/imx93-clock.yaml
index ccb53c6b96c1..98c0800732ef 100644
--- a/Documentation/devicetree/bindings/clock/imx93-clock.yaml
+++ b/Documentation/devicetree/bindings/clock/imx93-clock.yaml
@@ -16,6 +16,7 @@ description: |
 properties:
   compatible:
     enum:
+      - fsl,imx91-ccm
       - fsl,imx93-ccm
 
   reg:
diff --git a/include/dt-bindings/clock/imx93-clock.h b/include/dt-bindings/clock/imx93-clock.h
index a1d0b326bb6b..6c685067288b 100644
--- a/include/dt-bindings/clock/imx93-clock.h
+++ b/include/dt-bindings/clock/imx93-clock.h
@@ -204,5 +204,10 @@
 #define IMX93_CLK_A55_SEL		199
 #define IMX93_CLK_A55_CORE		200
 #define IMX93_CLK_PDM_IPG		201
+#define IMX91_CLK_ENET1_QOS_TSN     202
+#define IMX91_CLK_ENET_TIMER        203
+#define IMX91_CLK_ENET2_REGULAR     204
+#define IMX91_CLK_ENET2_REGULAR_GATE		205
+#define IMX91_CLK_ENET1_QOS_TSN_GATE		206
 
 #endif
-- 
2.34.1



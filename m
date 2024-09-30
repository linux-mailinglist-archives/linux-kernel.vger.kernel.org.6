Return-Path: <linux-kernel+bounces-343364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 170E4989A1A
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 07:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82DB7B2184B
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 05:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C7F7149C50;
	Mon, 30 Sep 2024 05:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="lvUrHre2"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010023.outbound.protection.outlook.com [52.101.69.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D66155312;
	Mon, 30 Sep 2024 05:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727674172; cv=fail; b=hygVqACZlihD1GEYlsQ4gskLSgqRoTX3lR9yP7Q9LCQ3G01t+h3rZ+cTjF5FXEaaBGsA8Xoii2t2wTORpkgwJi/8Sylnh22mPNRIfX7MV4CUp7KDur/hGH+hCf/M6lOAl1FjBFn297TP4O/VCE+7cA6Rgf63f+h/aCTjCDsjme0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727674172; c=relaxed/simple;
	bh=e3YsFxGI0LQwIlJBn3RXhOoBonKj2aDKiIwHM2ZhqQA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DDOY9O0Td7Tk7QF0Rx8PmcShe7lK8+b1ltspbdND++RmL3tFih2Cxpz4nw1Lt9r9zw14lOMforwIz8apmRNcGWf+h2lZnNDX3WcJbVCRFO078YLr3kymtlOwbz1k6f4s+SUeZGfhnyH3Yy+6JkOPp5sNt3h5Ag9S6FxmoLyvYHU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=lvUrHre2; arc=fail smtp.client-ip=52.101.69.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ryqJzzlp50bJ/md9BIsoNP5+qA6TnwumRzM+Az/qykB5L/Yk/ZGKnjYB/4p9DBdWFLko3WWTcDG+CmfO1AgSvie8hpDYk7QQlJxcWS7BSxP9qMD1mtwDSFGOg0/5zGA502na11A7RzMNn6KCYnG46w7N0oyTzKVyKKpQZejZ84N/ulcgmL9f4Bb1s4yQhfM9QEMdIFZQRHaQ7hQcArwDaDTok/aoECuDqDFsWh6AXw05KNi1ITtZvQktN5pnwO1mgcWypyKb7DnK26MMTbaq8yLb/U0nA5D+jqWnDII5Hye8EyhOhpjyo/fWrB5lUZ/dm71rKKOuS9zLXYl+W0nwiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cHBqa3+OL2Qfk9ygLdKmIKmRg+wTlyOij3iu7z6WS50=;
 b=kA8uMS4AkWELPlETPG2+Z1DJam886Vc2m9agSKUdric6sx9vlYen/AWXiK+NgVofyc2hzkFEFZIXQ2RyCVMa5+HZnm9UFz8sCwh4pGiZW59CoihXrhj1b5uJxIaFdSm63CfPA0RC18wM3jSJPzYTcnuwD9hRdv9E8pXD8AyVxWzv6ouoIaYebNJRHbGacMR6aPVrmHRFMJ6eidUsa2/VCfMtRpNs7Bm0BaunA1Lx1vsR+Nx/5RvrsPJjeTkPQTuHkIqP7GMzE18fuSeSrX9i7RQAU1QBbiUSwVvoJCFzymemnSJisAikUPpb26DR5dnAmyQyqwwoskz5H2mGsbMOvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cHBqa3+OL2Qfk9ygLdKmIKmRg+wTlyOij3iu7z6WS50=;
 b=lvUrHre2YRlH0c76VtHEZftN7Xqb8V/ePjmUbTxfudNthNrVFsHq6UBWxUwIZ4avj0m9aXMPqKa7r/73qAjYKsF2W8jV3QDDVdHcGtvKTWchFUGWJ5lNGbsH4XjAu+xO+ZpzktawKTk6ydq9UlXCfdq3DqQD2J384avQiyJI/MBFHE6PEnuQXeXoLHrOC8STcavB17M/AA1QsatPNo/tnLeby2hs7svgquE2krnDzFkyZ4LoxdHRbWXIh8idIRwJI6D2CKq7wuR0lEUdEDnwBjjzuyYF6Jf6hOpneTU8SmQoZmLMEV+thRqWYPzUo9YFc/SNRRwpIgQsO2geWO/Mlg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by GV1PR04MB10536.eurprd04.prod.outlook.com (2603:10a6:150:208::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Mon, 30 Sep
 2024 05:29:27 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::d1ce:ea15:6648:6f90]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::d1ce:ea15:6648:6f90%4]) with mapi id 15.20.8005.024; Mon, 30 Sep 2024
 05:29:27 +0000
From: Liu Ying <victor.liu@nxp.com>
To: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Cc: andrzej.hajda@intel.com,
	neil.armstrong@linaro.org,
	rfoss@kernel.org,
	Laurent.pinchart@ideasonboard.com,
	jonas@kwiboo.se,
	jernej.skrabec@gmail.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	catalin.marinas@arm.com,
	will@kernel.org,
	quic_bjorande@quicinc.com,
	geert+renesas@glider.be,
	dmitry.baryshkov@linaro.org,
	arnd@arndb.de,
	nfraprado@collabora.com,
	o.rempel@pengutronix.de,
	y.moog@phytec.de
Subject: [PATCH 4/8] drm/bridge: fsl-ldb: Use clk_round_rate() to validate "ldb" clock rate
Date: Mon, 30 Sep 2024 13:28:59 +0800
Message-Id: <20240930052903.168881-5-victor.liu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240930052903.168881-1-victor.liu@nxp.com>
References: <20240930052903.168881-1-victor.liu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0015.apcprd06.prod.outlook.com
 (2603:1096:4:186::7) To AM7PR04MB7046.eurprd04.prod.outlook.com
 (2603:10a6:20b:113::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR04MB7046:EE_|GV1PR04MB10536:EE_
X-MS-Office365-Filtering-Correlation-Id: d3b65d07-1b42-49c8-3732-08dce110da04
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|1800799024|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?zQxLsW+h7SYZR/xYzy8v27XPmcbnmH9KbVogVwsci3gzktY0JUkbE+dYm1Wh?=
 =?us-ascii?Q?Z2AHNImLAhj4j+d8Ughn9xALhVUK25VYl8saFNVYURWh4wEJnZRsMYLzt5dP?=
 =?us-ascii?Q?0qpAisFR75qJu+Rk+pATzinx9idkFWCmHo9f3u+adeZg5Og94uicSYIZgPqn?=
 =?us-ascii?Q?NRw6U36UKw0fZzqCNuUmb5+5oadF7Abya9SfnWd1mW7IrD8s9NiZggqtdKsj?=
 =?us-ascii?Q?X50l5CMLosOe6LMokZhyrEM6mWs7ygW0oCG4ZWJtP/wCUGF6g+IHaNAPBG3r?=
 =?us-ascii?Q?2goEEiXgn0nrWpqByllH9u5I1im6AfEfh0kqBtvzOwePh0E+L7cWe+wpro3C?=
 =?us-ascii?Q?eOYFAuQEGi0Esv/fcpfpu8tcTj1rvZuTPYzEiNYHa0y3y9jW1pMyasjeNAfH?=
 =?us-ascii?Q?ejR0ftigxA1Fj4eXe0whOUAcBWy2s9SHCA6KiG41qRHhTvNpDMS4lHtoGKP/?=
 =?us-ascii?Q?cfcgnc92kI/1uUcF/NbMbb8VR3JxasBZOg4o75CZbqa5mlcbUKlAJzpSHtSk?=
 =?us-ascii?Q?Tf/hy0A8v1KmoLKGtDHe22f4UBybRte1V1Umji4VUulPPG9PKUVX74WpDb+O?=
 =?us-ascii?Q?YNoiJTrUtsgfxyqVIsOqNxbAyxbcn86I+h6zMsEszVfUf/7Y2bo9LvSDhFls?=
 =?us-ascii?Q?YhJEJK9R3BUbsiPK5xMdnvFxGwXePFxnQ0IMwB4Q2NqspoWHlNp1ZsdwPhO0?=
 =?us-ascii?Q?ygJFrZVKPVmLXZuxx9RS2RIGECYwZfaQfOOu7j34FBGgo0iT8N5qFlYvntwD?=
 =?us-ascii?Q?g7K1jx+aaj9imOAD+G/lSZ3hAts728tBIpXP17tTSfOjfzmI19dgAUYVaGjh?=
 =?us-ascii?Q?6V2dACZcs2535X8KxUQD2VGpvCjFK+2+d8YuTeJWmn/V+KQSOFE1KtXzj0CI?=
 =?us-ascii?Q?N8RCsGFriJi7NVBhZJpYnbmo+Uyd1V3rtAlA8UzkkhOjDYxXDON4qjVTKApD?=
 =?us-ascii?Q?ha7zxwDj0czRHwvvy/ZBvOtLP/IxChHpd4jXZvd9AQFvrCaRDOl0tbgPxKOY?=
 =?us-ascii?Q?+2OMh3kw6rneIbPuzOkUT3IKLfbRcqr2c+xM9HXzaKi8Q4guaqzSrU1pSgPr?=
 =?us-ascii?Q?KGvUHtOrsfNsDzm2mhOJu4ZjLFD3gqEH2h3pHvUPTqW8s5JNio+EBOymDHFK?=
 =?us-ascii?Q?lRrZDxXRcYCiELDFRPUIr03Dg3ml92PoA8X2G5iIx6ReoDSrDU8/d0gja7s/?=
 =?us-ascii?Q?SyWPY2rY9jgIhynl0h83ulI9V5PHvrJ2IIRnw8T7rDuv4BKIYGhWza8r2N7U?=
 =?us-ascii?Q?Cc+liP50C1gKuzp2lEGEtO4KEBEG3NAhBwwM8hjlYiwQgNMKRTT+QNHb0hSx?=
 =?us-ascii?Q?Lz+QP5KenTFNLpaH4AR8/gvro+j2AajZLf5TyQKu5WZr7PgjZE67FCfV3RTd?=
 =?us-ascii?Q?iRm5d1iH/9tZJJZFzA/uz7b4nKWT/Dcr6ck73xdMu76x+9ZY3w=3D=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?+1o8AakIeMmKB2N8hkOi1nbobbQ4c+Uv40jZGNooOIO8uhOgLQJ9m6wsl9Oo?=
 =?us-ascii?Q?b60rY8jrTtg/V8jJ/+pBsBrTI6ukPTYW3/GTjkVoCUMQv4wU0FcUu6R+YAKY?=
 =?us-ascii?Q?y0WBqoS1yGXItJxReUp/cWqgUIP0H09rDRS4p+eXutrwLKnKEe69a3c++vi4?=
 =?us-ascii?Q?lL22QOtH9E4n6ukS4d6Iie6OnH580bLb0lKNgBBXXrNaX5SvPeOlUBsG/MUr?=
 =?us-ascii?Q?GBK6wzEgPUMMvAXaeQet8fqobbQxg8K6dEHq0FaMAOmAzBhJkP517765MoCd?=
 =?us-ascii?Q?VlqVXUXhM5Uz8MDFlJeo0teYSLInK12qA4hnLlNzQbuJYwMGOGbSw42Ie5xu?=
 =?us-ascii?Q?QW7hiPCVWlbPaBWp4VNjMNoNBaBn3ugTREpKysb8GmEnOtMlgDb2u9qbuMky?=
 =?us-ascii?Q?PhkzY0p32TGApwFbFpYAZWvUrCT9gvk4JwYU+fDvSTkxa7o2jP/b+j8pV9yN?=
 =?us-ascii?Q?PulnFKO2fP4zqsHVmLBtEwboBRm9VHn3upM9kY/BdFU3kPQOkh9LzgSjzhTE?=
 =?us-ascii?Q?R/lJAoPiwluOBaGgwnjgqF/VO0DpfMqp4GMCMyGutG6X9Yz9tTVSkoNrWnaq?=
 =?us-ascii?Q?Dw28mOPFReJA1g4Q+cS3GNYQQdOiU89NQk2G6xczrvZSD+cJhKYengucoVeK?=
 =?us-ascii?Q?gp/UszHbMQygptd5UuXKzn5Y1DSue6PoSUpHBtHpjeh1BgrXFF7/ESMgue7K?=
 =?us-ascii?Q?t80KhEW0NfACy/pjUrREakdQrfIRO5r94wopIqALh5vmTf7MsGurgCwQoW6P?=
 =?us-ascii?Q?cCsRX3cYEMLd93VzqRROT7fVHZgnKxYKXQEgOW5hqiQaNPUtHPfJ73BgIamd?=
 =?us-ascii?Q?QNUYPMhLBKTjOboI7HbYHA6/pHQjsyJ5DbRi9rjw6KvoxdPu9Sp0YbbvaS40?=
 =?us-ascii?Q?r8n0GKwmdSb9ULtOL3YMnPoxtClzh6bYxHteS+n2qMqSMh9Oy0nCjuVArn3C?=
 =?us-ascii?Q?o8FaECCVovIwZY6eOhzb9dp3xqvQWC5sAVrTpWx5AXwYcdvAjluSkPY8FrVS?=
 =?us-ascii?Q?0hltQGIA/tng7g9808IiOpe38C5TMllI2jBEzi46ZpFQMToidqiUUOUvJ70b?=
 =?us-ascii?Q?86ANmh85+E1Akl7Ij1sT3kI/k5uyPzzkgVC6nXLP80/5rzlNOFk4Fja86vZH?=
 =?us-ascii?Q?HpKSm3/XlI9gXvq6BozQPVwbNilUjRV/x79RBrWKxH6TgUpcJQlLB7YUvFB7?=
 =?us-ascii?Q?0bPLWSsD4sADCh0A0wimvmOuUoGANWifsc2H5oZa2nUPr8vVPpuq5iDCOcBC?=
 =?us-ascii?Q?KvtkIcKVdjfx2DPdlpOfeavNae4ETZ2R+4RToYaSJKbbGptoDHXqdgP/5rGd?=
 =?us-ascii?Q?01fZRLWxps5FrvxAmqybysiVpO90DTiYlhafu2t4amdxOfaCUjUm4vQlP0gA?=
 =?us-ascii?Q?sjc5H2zRPUV+WUBV7qJAbqfVmNUY/sXXVhX0LN1/UaCf23WsgPvchOZ+0mad?=
 =?us-ascii?Q?LYsEFdw6RiFW7V3z5z1j/LwuTE2U+SPIwYmoWIQPBYCkgnEmZA8bZbf/QUvY?=
 =?us-ascii?Q?ANXSXrhg8eqJS+rYie9OsBYq9Ji0K8s3JNrMyxQDki8tOIPNaLCF5VVlrEXU?=
 =?us-ascii?Q?ovygrqTRwCFu/J8h7Ee6nlpymxWoO1BrFO2BZBn8?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3b65d07-1b42-49c8-3732-08dce110da04
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 05:29:27.5818
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5BfrBRs845fs/jtkbnCjVJ/GWnNEE3SmCJJmkhk4gNCFQB71qsD5hVAwF98FXTPy+aYd+nRWkE+oJ7YEihgF8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10536

Multiple display modes could be read from a display device's EDID.
Use clk_round_rate() to validate the "ldb" clock rate for each mode
in drm_bridge_funcs::mode_valid() to filter unsupported modes out.

Also, if the "ldb" clock and the pixel clock are sibling in clock
tree, use clk_round_rate() to validate the pixel clock rate against
the "ldb" clock.  This is not done in display controller driver
because drm_crtc_helper_funcs::mode_valid() may not decide to do
the validation or not if multiple encoders are connected to the CRTC,
e.g., i.MX93 LCDIF may connect with MIPI DSI controller, LDB and
parallel display output simultaneously.

Signed-off-by: Liu Ying <victor.liu@nxp.com>
---
 drivers/gpu/drm/bridge/fsl-ldb.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/gpu/drm/bridge/fsl-ldb.c b/drivers/gpu/drm/bridge/fsl-ldb.c
index b559f3e0bef6..ee8471c86617 100644
--- a/drivers/gpu/drm/bridge/fsl-ldb.c
+++ b/drivers/gpu/drm/bridge/fsl-ldb.c
@@ -11,6 +11,7 @@
 #include <linux/of_graph.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
+#include <linux/units.h>
 
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_bridge.h>
@@ -64,6 +65,7 @@ struct fsl_ldb_devdata {
 	u32 lvds_ctrl;
 	bool lvds_en_bit;
 	bool single_ctrl_reg;
+	bool ldb_clk_pixel_clk_sibling;
 };
 
 static const struct fsl_ldb_devdata fsl_ldb_devdata[] = {
@@ -74,11 +76,13 @@ static const struct fsl_ldb_devdata fsl_ldb_devdata[] = {
 	[IMX8MP_LDB] = {
 		.ldb_ctrl = 0x5c,
 		.lvds_ctrl = 0x128,
+		.ldb_clk_pixel_clk_sibling = true,
 	},
 	[IMX93_LDB] = {
 		.ldb_ctrl = 0x20,
 		.lvds_ctrl = 0x24,
 		.lvds_en_bit = true,
+		.ldb_clk_pixel_clk_sibling = true,
 	},
 };
 
@@ -269,11 +273,29 @@ fsl_ldb_mode_valid(struct drm_bridge *bridge,
 		   const struct drm_display_info *info,
 		   const struct drm_display_mode *mode)
 {
+	unsigned long link_freq, pclk_rate, rounded_pclk_rate;
 	struct fsl_ldb *fsl_ldb = to_fsl_ldb(bridge);
 
 	if (mode->clock > (fsl_ldb_is_dual(fsl_ldb) ? 160000 : 80000))
 		return MODE_CLOCK_HIGH;
 
+	/* Validate "ldb" clock rate. */
+	link_freq = fsl_ldb_link_frequency(fsl_ldb, mode->clock);
+	if (link_freq != clk_round_rate(fsl_ldb->clk, link_freq))
+		return MODE_NOCLOCK;
+
+	/*
+	 * Use "ldb" clock to validate pixel clock rate,
+	 * if the two clocks are sibling.
+	 */
+	if (fsl_ldb->devdata->ldb_clk_pixel_clk_sibling) {
+		pclk_rate = mode->clock * HZ_PER_KHZ;
+
+		rounded_pclk_rate = clk_round_rate(fsl_ldb->clk, pclk_rate);
+		if (rounded_pclk_rate != pclk_rate)
+			return MODE_NOCLOCK;
+	}
+
 	return MODE_OK;
 }
 
-- 
2.34.1



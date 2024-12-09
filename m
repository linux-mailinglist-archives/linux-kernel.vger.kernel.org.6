Return-Path: <linux-kernel+bounces-436718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 037B99E89EF
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 04:43:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C91CA1884067
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 03:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2713198E75;
	Mon,  9 Dec 2024 03:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="XqS8whj2"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2055.outbound.protection.outlook.com [40.107.247.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2023198E6D;
	Mon,  9 Dec 2024 03:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733715681; cv=fail; b=lLyY6i1+DyEEiOb588g/AZdaMcVMBd4jclprsloxn0vF1a1oZs3SJCgtoHq+u58lv2WQLxBfqHpfvXU+5mqelX+z3rJu6zwLqCO3lpF8/2+PlihFs5zwZhteD3ts3taHBYE9+rIcIbeDF2WGxRE1uZVV4byPTe6jMGXs1aVr9e8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733715681; c=relaxed/simple;
	bh=Wl+vEWkJ60XZXMlDVAZjene7cvEaJ4byOz491tLzr5k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VK7uYOyrja8dZomVe8Q8GdbPx/rDEGxf33fbEGJxf+E5bY0WIlkx7taRo3FLKcknmokVPwIY0qQhMjC2GRcAleJ8CAf/G6ypwI5uAzEl22phkcqvTQ3f5AvPFHAoMIwdemdx4ChKuDUvsNaV6mGoDvRkcVITn/GSVqk8he4Zdgo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=XqS8whj2; arc=fail smtp.client-ip=40.107.247.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DOgmGMUCaSNPVV/hkQ68dmq/qGbC3uGTKmlL3vv8x3jKB749CPYTDmXv9304oXNIW3IDLnDdB4cLOJa3rl2CHHyDVJRkuVo0RvypcF52wEjTQUP1IejJkcEBfSMkyq3BNOt9waTVb3z6P68Fq2+7sscz4q/Fl9xfgkP+1Sz18Zp3UAgfM9dKqxPPj3bCI5+DsrH1rivUzHfH0YwytdJf4Ruy07YDOBhO9O/redizeNgod98hjGKI8z5PnlSQJY20f6AdWat5ioTZ6GX/JPA4a2oLYDRPUEWgYTDKjsdUCr7ufwgs3UcEsFbEO/MM7QRiHAHaqVII27JPivim1hHN/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jf2UT7q+iiUtNPwi2YGw6gKPwQLYjmrvLy3aFLYNKEM=;
 b=sAzZOXelQufn6NFuog9bSq/5eaAdpgc1tNrgdcInHQnyVjrFowS6tMJKka4BbdLl9iU5OkJ7rhJH3UwTM+Vqb8V2Zn+ZHVpTBe6rkvvDSdQqPLzaZPtyTRFGOnud9BJWJrGL+Q65QOsP2kpkfnWdaBaIpgCwoutJWYd5NuxyCPuetULsaULZtSrmFyh7NdflEkxVtAAIAvt/n1qpEE5VRzy6Ll5KgItGy33mQ93wybkCnvgAw5tB/9CtnB1FJA+0hyFVUDYyQTuvh/mRLgx9LGQANx4gYIhzp8Dld+P6sg5D3PQdsP2jyCRMAgwnBehyFDE1JjucTX4JRAFsQW73nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jf2UT7q+iiUtNPwi2YGw6gKPwQLYjmrvLy3aFLYNKEM=;
 b=XqS8whj2I1QNvWKfApF9/E1iJ8N4vGlx7+u+lvYYhYKtXpzcLtDYwyQ75pb/6gKXFoP0LO30zuVphXaoBZiRThWii9SLlFWzHldLF3m+xcHKjolV7ZU24a3pCDnHkk7WfzobmnbJaKrh9W2Uj3NDyN8KdBJnXBEnpa0dqkbMSFHmed5HlrMDPFQC/J0MdBlx5BSNa8oginm19k+Yva0Vx1xw0E8586u7XlTxmidcbECgZxvplbjos8B6UkZVbTK8BItyJnMpvRZ8WeUOPvfvLAX/2tLLpTfmDBfZ4Bilgz9HhHjX304hUBOby2+d5YaHDbREdBgil9PzEIoGJEEENg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by PA4PR04MB9438.eurprd04.prod.outlook.com (2603:10a6:102:2aa::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Mon, 9 Dec
 2024 03:41:16 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::d1ce:ea15:6648:6f90]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::d1ce:ea15:6648:6f90%6]) with mapi id 15.20.8230.016; Mon, 9 Dec 2024
 03:41:16 +0000
From: Liu Ying <victor.liu@nxp.com>
To: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org
Cc: p.zabel@pengutronix.de,
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
	tglx@linutronix.de,
	vkoul@kernel.org,
	kishon@kernel.org,
	aisheng.dong@nxp.com,
	agx@sigxcpu.org,
	francesco@dolcini.it,
	frank.li@nxp.com,
	dmitry.baryshkov@linaro.org,
	u.kleine-koenig@baylibre.com
Subject: [PATCH v6 13/19] MAINTAINERS: Add maintainer for i.MX8qxp Display Controller
Date: Mon,  9 Dec 2024 11:39:17 +0800
Message-Id: <20241209033923.3009629-14-victor.liu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241209033923.3009629-1-victor.liu@nxp.com>
References: <20241209033923.3009629-1-victor.liu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0006.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::18)
 To AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR04MB7046:EE_|PA4PR04MB9438:EE_
X-MS-Office365-Filtering-Correlation-Id: ba2c9c7b-d062-4a33-7910-08dd1803559b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|52116014|366016|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8+objy4fbM/aCF3I4OXU0JgtC80vE0mBgA1rFxlvs6aXHQ1WODdHlrrJ9b41?=
 =?us-ascii?Q?2rlUf6VOqq7e0JAsTPcrYSwclFJyRk6AgykIVIXLDoiEMIiHNPhn1L3baZ1N?=
 =?us-ascii?Q?VUwScSD6SBUh/ICB6lCFpOvMQVzj7PXg7I3Qk8NaXzwLRfxkfUtrmD1ZNBl2?=
 =?us-ascii?Q?fBF2mxLBf4AH+7XBVbh08sEnxIEJ/7FfLrosIjV3A3sTAfRv5498FiLRpRRo?=
 =?us-ascii?Q?c8Zn35Aa/UgphG0kZiWA6HMELLZu1eO1HeZqkoc34hgkSXwvpGrm5BZ0PKGH?=
 =?us-ascii?Q?unFpHwqM6S5E1bTRT3xfhXstfA22vPsUB5gaqabYAreRrP3su5F0JpzaLH/H?=
 =?us-ascii?Q?cQPaLZ04RrVYz0IbXWFVIndHfbIOgccj/uXARulTC/oB8OhuMY0UwpFXm4CA?=
 =?us-ascii?Q?ouoYnWhaSdm88UkbIwKzmqWk7hrbF5XwzcotUExz3COPQu3BJJeWFo1RFcIk?=
 =?us-ascii?Q?9E4CdngFLdJZmbIsrDEA20tNhyn27ydKwhekewBkOqPxMO6CykPd/MWzGUrT?=
 =?us-ascii?Q?0vKVv4dHfjVz8X3nSbKfZmi9V8dF2HGfzrGpLnWjAA6k5mmfhLs7/G7o81IA?=
 =?us-ascii?Q?h6sQ3M08FyLiGqDvXy4wPpI4UUPN3ihBtV3mWev5DjmjT51I3ZU5lQibkHdv?=
 =?us-ascii?Q?l1POVOJXDRQA7HEl0mbRkyaSdQBxWMgd3doOMPUmjf3dAM0Ri+fcQoPaAqzr?=
 =?us-ascii?Q?786P3u+R0Ah1cInFW7oE0w7WnIVzPgF1m/Pw0PnWVRd+jVh0kMr282o3ceg+?=
 =?us-ascii?Q?V793Oid+Bgpx4u++4JYCMBHQmIhFJcQZXfoKOVzA12RB86F/5jczrZ7PohZR?=
 =?us-ascii?Q?wNHyAVpbv76jgtlQQVsZUqp7z39uG1NmM0YGbEb/6rwJuln22vOsqUvdqdTF?=
 =?us-ascii?Q?IKu3O2IWLssa52EJcekmp1gDLZ4O90JoeS/PmKf4ErrJmgLwT02nta+uAJCQ?=
 =?us-ascii?Q?zp4nT+1+/lwPwSnaENKwgHG5WKGx3ggUrbGIJATLz7GKnQgrIOPG+3XxGtr9?=
 =?us-ascii?Q?DwwvnGQ3APtYONgwrXEPS+FFMv1Iz0ak/E9cRglKwO6zrvwxRsALGuE9craK?=
 =?us-ascii?Q?lkLLEXfjhZjFAEPnz0Eg8VacCD+HMoweeDfkLS5wunKKRqM87awywtywjwAI?=
 =?us-ascii?Q?NrH9kIjVPjp7dTRuVtnLrQz67rCfSYmgxWK7t1AACRfADzkcvL6vRv6x1BPJ?=
 =?us-ascii?Q?WIpXLSqmoJAJwWYu7XO6qFTOtDj+/KjeTSqzUU/IAi2JO0Rej+00og89sHVX?=
 =?us-ascii?Q?Yfk6BYDIcM+fPuAnGjwEMN48IAw3SHbzzfdziPJCOpcfjtiC7uKOAQowF0/J?=
 =?us-ascii?Q?Aea03XhVHeUql2qIhUKfMsSw1kj3LHZqzwNBMXMv0wTmwuzg6yfyJ3sKFFHx?=
 =?us-ascii?Q?/8X3BME=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(52116014)(366016)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dpy+NJmOVcqqTm1AEkzcJOJlT/OeF4MJCieOMTWBXy9aYaiXvi4Gzcq6QGgS?=
 =?us-ascii?Q?MthiJQ70agV3l8UbeHnINBei+X0bW3mDt4SM2f3QmffjCk7dstXI7UdRl5EJ?=
 =?us-ascii?Q?UFWOx5YTlxzj3JfG0k9LHPBuLNadYG33k3UNL7XvGn2D9fCTWM1z59HyxTkS?=
 =?us-ascii?Q?BLOiXpmewuQey8SMcwFeYOD8gejzrqdx69hg2+1R99Nol7argC1eWYj9E7ws?=
 =?us-ascii?Q?HA466jD/A+jHgL8ZANfh34r9zIoOWasecPJk4CmJ9/qYA+GSoqxMWEEThNLM?=
 =?us-ascii?Q?8pMWP7SV5smJA2p/IeE7E3tmrZzzyoXaor3o+SVrtaRLNkF3piPOm5IzOGSM?=
 =?us-ascii?Q?824ZBW1zGHzceJTWGQ9wn/J2BUHg5MZ9nShGq+YRIQ2i6WnafTuBdX/9uS73?=
 =?us-ascii?Q?OJ92UXC33ri2+DoPDLnSxt5JAx3d/gjX7FVGVuiP5r4caUPTZRcmld4aX+qY?=
 =?us-ascii?Q?6tw8ao7Ln4D08ahs8yaA0tejxtja27MjA0PQUbPbruzr3TZ5oybbu7qBbm5M?=
 =?us-ascii?Q?3IWgKT13qt56vfd8i0OfeplDqw9CkXW8EXLj2qSls5tTjhcir0du1KYqOt6d?=
 =?us-ascii?Q?TtCJdPpTi21Wqt/O9m7NaK+/q43vFvy4JOdnOCX2W/tYWULrn/q9HhuTYahZ?=
 =?us-ascii?Q?p6QhGI9/isMNt35Iks4qUdnTuJ7LcXlNOq54ekBJGfeIVWoXfp4998BZyeaZ?=
 =?us-ascii?Q?dGsiuL391RdNXYRHJ4yHVNJFSX7cp4VudiHpV71zFZmIyrI7rOSa+tuEgZTo?=
 =?us-ascii?Q?uPkqlX4Ja09VOdgWDyjVytKsD2umPwZahFiqHW+7XupBBqNSC+EqjRI7BaFc?=
 =?us-ascii?Q?6KvLrNIzZMAfxvVR6lCb0+nBKcOdB4caNU0glbQxphGjDvL8bplTEiqjtwRg?=
 =?us-ascii?Q?2R6wcVW5LIv/1F8DapHNN0Sir/WOB6slahyVNzBysUDmED8fk2s5BHKGLspn?=
 =?us-ascii?Q?BEbTEMTf0L5kxggA0aKTBzrkM6X91tyaD2wGogmGwJoo4q3TQDRrqsyrUHYK?=
 =?us-ascii?Q?h8Eug+GT14k30EI9xqJRMOVkhw1A96HfGfHhfG0hzBHfcqxZPVWCQVeNguj+?=
 =?us-ascii?Q?u64htNl0M5xLD9JHtnYLRqpJ9Dsd9SRDIupMyN11qL1PdrFUxctuckIh5cM6?=
 =?us-ascii?Q?6s2xrju618FuK3YqwY7fVJf4RG59n59DplI0LXWeLTtlUcQeu/m1qXf23gBk?=
 =?us-ascii?Q?6b09rejfpy4YfUHaZJ/+j/OESuvwdnON5vkJPxhRq8gImdIvlQPlCKQEkpKo?=
 =?us-ascii?Q?xwb0RmXIidH7B2xVtqDpJlFHgFyugShvoO7vIrz0OLp/XL7g5e2+rcnFrOt+?=
 =?us-ascii?Q?YgFXelOqnivxZ1fIhoHijIkmHZIRD15+gDah7MkJ8KhwKE8C+3EfsZ12NFHK?=
 =?us-ascii?Q?v32nIK2GQPNr8WlVjNMfqbGveknHuzoFTwWDIsbloi6KFK4vmBbJQ4udWPUh?=
 =?us-ascii?Q?o5I9mHWMIbSk+AQl4Jzf+a0ZqE+at9x1NmvC9UdQL+Kc9m077X/B1Pj2xoXY?=
 =?us-ascii?Q?T7vGGvO82hO8Yzlt3WFmB8b6vNFUya1INP/e39/EPCczOUiMCb3TqL9JFExS?=
 =?us-ascii?Q?Q9a8YEcVJtfcJOva6qKTAwzR8xFdqMV0AqWk37LV?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba2c9c7b-d062-4a33-7910-08dd1803559b
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 03:41:15.9823
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WYoY0oPKa6Vdm34ppyC9nbjjCEVnbJWACHhrr7DJzZ8zLUotUa20mG5LC6bmcY1TFRUlARbiDmcuxHl8BRENXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9438

Add myself as the maintainer of i.MX8qxp Display Controller.

Signed-off-by: Liu Ying <victor.liu@nxp.com>
---
v6:
* No change.

v5:
* No change.

v4:
* No change.

v3:
* No change.

v2:
* Improve file list. (Frank)

 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 77dbb2ff906f..e12e899d10ae 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7695,6 +7695,14 @@ F:	Documentation/devicetree/bindings/display/imx/
 F:	drivers/gpu/drm/imx/ipuv3/
 F:	drivers/gpu/ipu-v3/
 
+DRM DRIVERS FOR FREESCALE IMX8 DISPLAY CONTROLLER
+M:	Liu Ying <victor.liu@nxp.com>
+L:	dri-devel@lists.freedesktop.org
+S:	Maintained
+T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
+F:	Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dc*.yaml
+F:	drivers/gpu/drm/imx/dc/
+
 DRM DRIVERS FOR FREESCALE IMX BRIDGE
 M:	Liu Ying <victor.liu@nxp.com>
 L:	dri-devel@lists.freedesktop.org
-- 
2.34.1



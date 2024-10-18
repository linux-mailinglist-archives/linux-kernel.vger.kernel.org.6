Return-Path: <linux-kernel+bounces-371083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CAD19A360D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 08:51:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22A2A1F25D0B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 06:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDAAA18EFC8;
	Fri, 18 Oct 2024 06:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="UDcoUJNW"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2089.outbound.protection.outlook.com [40.107.247.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360B1188591;
	Fri, 18 Oct 2024 06:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729234121; cv=fail; b=syZFgmrdAp68+qeMDL9x1TrUXhwH61YAhnnYGuqBupy22isMY/k1FFBAiLRCt2PofVlWkIdP3ruxP2t/Hq/JWS7AQ4hXELgMfcupBaV1mBnqFOUPpI+meDiqofR7NtePPxCI67poVv3lzr1/8XIQXqVsYb4OUMELyKHwNVdX164=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729234121; c=relaxed/simple;
	bh=KLOCICtliJdnjdEbs24yLUuFDF4BU3dLTeko+zXzVQg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pMHigWSUXEjwKmF4OSN7Oim0IDPdigUqb7EUcwIhmtfFSOko4PZbiPqbbJmLSEJm9KS5vv/snSK09r+CelXBITAD+IChMm5e+yRfbO3nmAqXl5qaIbwXCuXoxdkTGaY256/hcVl/kH9qS/Tnojd5Ap6rdccEqE8j0okBRkwc+oM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=UDcoUJNW; arc=fail smtp.client-ip=40.107.247.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nshbs9BsrYxm/CfvvaguOhLGeKtalJKKyHJobmyFfZU36VHFSMcsAJjM1Zq+88x7oTToGIqo4NgFpjVmRIVr35ESk7oYzkcLBnp80aiyDCkm8rf+sx/Qw4JqO8y4LRqZA3qG+L0BZvbyS9QDwjcHGKG4tTTq960JStWIbtAF4kLf11h8P/HnoVZKbUlrKTd4VGAs/BirQt6wYmlAh6WufEI7M2Da6ebYoBuLOs3w8//sAQMQQQ0bDBQh01ftJ0YQW2MQ3vR0fWVsQ4dVMfSw9wDvLZgcBhTqKa8aEqQG9In9kHpdlMRFg2Gd4eBy5SCmwGUbarfFMSx4w5haM7Vf3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zwSh//d1CaRqxOSZh6QlhILY+X1BgTdgaYR7pJsi57M=;
 b=glCAvg5uGR/KCUY5xC9viL9iGu5hNqu1C2kW+kEipHZPjM1k8O3QjIHbfPN+pd3tt8KSNWV98RWq8x76namhl1TG3p9sQ5ah+bURLeyirZANm+mq3j0/sM6JXya47jACa7I5cuBMDLfWHuZHposf1g3+r/IjZ1seHqkuuMIt7p/8d103nTjxQA8uA1BABb/wF0yxobHvOynS/LoyUC0YiUKfGE5UbQWe+VUub1dVhHXl0uPeADsRiU8YeOea0lymu/gDaozGUJ140bdOagv/twFouNYWf6uJoPLQ3FGmQOeim0BfRNiJWvivAc1Rg4Wj7jQlgH9tRSrYOC1dat2FRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zwSh//d1CaRqxOSZh6QlhILY+X1BgTdgaYR7pJsi57M=;
 b=UDcoUJNWbQ0NyXwyDB7tUYnEy89bUwDtoSPziXNrbGAxAeItFVI1GK+mXwQqbo7djYhMVCG7IJ/tXCchuQ0A54m3JBMVybnbPxoRaC7vkLnGfTum/L8B7ohuV0HNrND/rHmoPNx+E0VPPX0djXuW0NW3gU5YthtpIRRWsH17LRXJvoN8AWlTJi2KFLXyanpY8dVAqghwGE4txfF8Qic2sFUi3yl0l0oE2ZKtbxzoEgx2NbjenHTxsmTaAYnmUd4O9LCNWfPY4plcsT/iIcF70qaMfFMi5CgZb8RCtpH5xGt5Ni4bRf+WYF6VoClh+Z4G8Nl0CRh/geNFYmT/weKpDQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by VI1PR04MB9787.eurprd04.prod.outlook.com (2603:10a6:800:1d8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Fri, 18 Oct
 2024 06:48:35 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::d1ce:ea15:6648:6f90]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::d1ce:ea15:6648:6f90%4]) with mapi id 15.20.8069.020; Fri, 18 Oct 2024
 06:48:35 +0000
From: Liu Ying <victor.liu@nxp.com>
To: devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	andrzej.hajda@intel.com,
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
	marex@denx.de,
	stefan@agner.ch,
	dmitry.baryshkov@linaro.org
Subject: [PATCH 5/5] drm: lcdif: Use drm_bridge_connector
Date: Fri, 18 Oct 2024 14:48:13 +0800
Message-Id: <20241018064813.2750016-6-victor.liu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241018064813.2750016-1-victor.liu@nxp.com>
References: <20241018064813.2750016-1-victor.liu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0204.apcprd04.prod.outlook.com
 (2603:1096:4:187::16) To AM7PR04MB7046.eurprd04.prod.outlook.com
 (2603:10a6:20b:113::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR04MB7046:EE_|VI1PR04MB9787:EE_
X-MS-Office365-Filtering-Correlation-Id: 248c1190-f928-4c4e-addb-08dcef40e31d
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?TQtdneAbOqSU9/IE47q8irRGA6D2M2py9mbdu7OaESwkQ42NpV4hgNpUAZgA?=
 =?us-ascii?Q?aFAV1PuYBfi8T03MZd44JNOq+avtU/jUcw6vzuxe7bIT9aeZWTZc8Kun5atZ?=
 =?us-ascii?Q?rWlTpjcYVqaV4a5ArXac/GW6Grp0/e/ncyqh3XQTrGQ2Bf5g1uZyTyolXtJV?=
 =?us-ascii?Q?a1+CImvf8KyZLQgxjUK4xI0UtV9uTwvK2R/Ae0C1xXTgOv2lOfLV/5DpuiIm?=
 =?us-ascii?Q?9KFyfNcIdh2fEpOfg21qes5F/+bgvhQ3OYx4Y7d2W9CwkxzXOjSKZSOmDEXb?=
 =?us-ascii?Q?y5IsGyS4dW6iuGQPIO76lG1LECM5LpcEj1shIye0Dg3PnsLyJHD/UrAdP7YK?=
 =?us-ascii?Q?1vQBtBPtbfa+1sg8eQyG4eKE07ZIs+u308n+7khPnBTvPREAOl+W7olabtt/?=
 =?us-ascii?Q?MnxtFvSQ6KAzF7/DfGi5/kpNjQRJtKaRlDGPw9gqaMfwH0KWtg5aSVERMo/I?=
 =?us-ascii?Q?Rtadfnn1/UfDNjzOW/DVksGKSsb0IX1WJzkqmQ1fE7Qz0UlB9u7ZHs87u8Ah?=
 =?us-ascii?Q?nog5BZEMITTFEhxhQWxiiXiTo6fmdpY51XZd2ODKj3weo6X2t/F7EoHytGpL?=
 =?us-ascii?Q?rcxJSFBRW2iqnIAVEYraOszggBp+h0UbOXyNDSfDudVZZLQVVBQzM8/qYhvU?=
 =?us-ascii?Q?oeZe0Md96dDJNnmTnazXKbauHaQRJSA2x9dt8V2OmJUL8hlwHuRSu9KKzH+w?=
 =?us-ascii?Q?arU38Zjhta6HPoo/kSgM1gitRiVQl48yp7yFL8l9bsebYBDlJhdfZt3F9+9u?=
 =?us-ascii?Q?juONUxXZmNUgzVzZhNw0uXGjo0HEbbGRAkjyBKXaVQBDx4e4afzDYpEBfbh9?=
 =?us-ascii?Q?o1+eK8PR8OyNfDcD/bfsamfqLS3SEYijZlnoTR4YCoE8cyjWHr2FDNEHzStV?=
 =?us-ascii?Q?MFUVj+OHXyTJqIJAx8hiNz8u6ym/0yBcjLZPxXTDyBo8/C90MwJ5004ULRPF?=
 =?us-ascii?Q?oolhTRgYPE/AFpZDBkrEvYOx5bqWchzNplI1Y+oWsNQfZNQeWX2Cl/YK3Zbv?=
 =?us-ascii?Q?cDY2spgKXood4vhw1yUB+RXXAcybHIXvEGX4Vg31bP5tsPLqSEg23iLcfOYx?=
 =?us-ascii?Q?vyLSsnhWWMef7ORocUWPXyeoW8j2mEONrAxZTQ1k9FW67+ebbOL88w/25j8X?=
 =?us-ascii?Q?kTENsXwIKshjZzZP/VdMld5qwB9KPov2p8RGRJ5pu9fv0MlrO/Y1u7tmEKsy?=
 =?us-ascii?Q?Fl1JPqUGid9DZn3jCCwCeMgAK/mjTNw/L+piymu5lhwu9aVQ/NswSOmOFhlr?=
 =?us-ascii?Q?bxAiTXq5Oc+mMef3CG9FLdX24ggwQqmX41PqY/ociRrKp8X1+n9yaZkvWcQo?=
 =?us-ascii?Q?PMEJS9h6ghimEeVIDgj5r8DH20QZnAe88HDFnbd3X/xNrmMJTtRmRE/P0hz6?=
 =?us-ascii?Q?QyUcRcI=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?3EwSxJdXLDEu/JgcugezO0m9T7m2jbn4JFcmVLYGbkRWfme7TAaHDTJZ2cxr?=
 =?us-ascii?Q?UN2Mc8ZCoNHZGX2woeftr++9JZ5lngJevtYft5IfTpPuAaT2sTvEltI1tNW8?=
 =?us-ascii?Q?Ml8gOjP1A/ISP8ikF7l4tCfXn2x5o1tWS0sNkAiakB9qfCQQIjMkDOoHqEZr?=
 =?us-ascii?Q?chH0Rq56rxJo2u4aWb9jLFOAlE/LfN6DLauZfvPvt8ls0e8wMG26B8bxKrpe?=
 =?us-ascii?Q?YHiW5HwSGCzUSazYMzypEGOyx4oVPZGS7gvbvva0rfhWdOxzLtvqBEMH3AZ9?=
 =?us-ascii?Q?4awiouviIKwQ5TK1UF4q0bHTtVYVERIF+nkIbjuCVsCpGnu6zDWvbAKsyA7b?=
 =?us-ascii?Q?/INF/3NieQXyiPLeh9+pQKIMoNth5MATFi7R48Rv2XBuUROyeM/zsEI0wS0A?=
 =?us-ascii?Q?iUni9DHkdpdzdxACHJTaKNa1h5h+Z2f8QwEmjEEku0cBO+r6N77qhuteRWE+?=
 =?us-ascii?Q?fNJ6Dl2oAj7hxCHLjnCYCCbE52+1IuMU01ASbJPNcjvXSujuRPCY1OYSZapW?=
 =?us-ascii?Q?PMg5Lu1cucuIGdrcAT4YSCNRLaRgrlPEo3Z4p3tZAUW95YjY4jKflJYcYMxm?=
 =?us-ascii?Q?4YjvdTST3zjMfIfxZ/5biR0JlElxHj/oDEVQ/cgtOCwpUqpJir6qSatYWSY5?=
 =?us-ascii?Q?UZq+7nbBQugtz3opkgrZ5qSgPVp1ARYeJZpcuwAKDw7gbp0vC7c9ERc8BWCK?=
 =?us-ascii?Q?x1Tac1ooG8UfrwLJuNHlfLrEsqxikKNZfFWFFY45TiwUOQ70uDJYa6abIR5A?=
 =?us-ascii?Q?bFyb1tuQn2FsKbftpjsI3XT9wvfrhHa5kRlt3bUnGzbkd+xrS1+yb6SgCtmH?=
 =?us-ascii?Q?/7ZliPAilMyePywttSuYMaaA4GzK/KgGlDNFP9tat086tfsvb7oyqNe9fe9+?=
 =?us-ascii?Q?b/HJkK5mbOVPn7O18y28jLF67G0MCyue4w900m5uzrfZ9HXRE+sWzM2artDQ?=
 =?us-ascii?Q?YIZ4mgyDmbiFmNa5tzfc21vMasj2JNRKpvGj1GpQMRFPL8hzCL5HsFf4xWbW?=
 =?us-ascii?Q?ft5A6nFgy4I5b955B/nvrovbME/U2G7GtvALwMRcdgjlhX9DyjXHYEZW+5px?=
 =?us-ascii?Q?pJkw19yqgpyg0wkNA6NqOZeVx4B2Z0+kMWW29Bs6Aetha/GABoT7AL4cz11/?=
 =?us-ascii?Q?QPBczzrWqfNlMp1ulVoRmAC4sRUaHKAOMGGR+rdwyh158lPjRB4yNiibeVBS?=
 =?us-ascii?Q?g15omZ7cCBnumQPJWb3+svS3kVCkMwZkl8FSH+5PrmXlAommREdzkONz7Olq?=
 =?us-ascii?Q?NDqVte74UO74tKdyYtKFUAAjpTLU2mb08MkYm43Zd45ywscqptdjYNArqK2s?=
 =?us-ascii?Q?MICkp7xlfAC8FaXR1H9mHTDUa6UUCwn3qZg5rJcYVjm+9LGOu0p6oABxnPeK?=
 =?us-ascii?Q?XX/ZyRC7W1WLFEf6m45u9k2hOe9obdOt4HneUdZPtCdyoDborPqsXmLp+dTz?=
 =?us-ascii?Q?4ERBsIL6cAcrz39xvpKpNSJZaH4zkdbtQtYbQeZEPZtwEuCvlZhF9HAq2l3s?=
 =?us-ascii?Q?FFyktywJ2dAxIEKLYZhs7bsshyR3TjuFY/En7i4rrlFo5ooGQgvtqxS8COGZ?=
 =?us-ascii?Q?coYIIsc7cU28vjxxvTLdY9SvrgY6nXtFx3893t+7?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 248c1190-f928-4c4e-addb-08dcef40e31d
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 06:48:34.9886
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S9Nv6ftxpUDn4c+dAE6w3tuyELWUYZhKmczAa1xakPFP1ZOn5yzGKzNkhv1u9IBBz/iTy4o9q7zq6/a9ApUwBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9787

Initialize a connector by calling drm_bridge_connector_init() for
each encoder so that down stream bridge drivers don't need to create
connectors any more.

Signed-off-by: Liu Ying <victor.liu@nxp.com>
---
 drivers/gpu/drm/mxsfb/Kconfig     |  1 +
 drivers/gpu/drm/mxsfb/lcdif_drv.c | 17 ++++++++++++++++-
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mxsfb/Kconfig b/drivers/gpu/drm/mxsfb/Kconfig
index 264e74f45554..06c95e556380 100644
--- a/drivers/gpu/drm/mxsfb/Kconfig
+++ b/drivers/gpu/drm/mxsfb/Kconfig
@@ -27,6 +27,7 @@ config DRM_IMX_LCDIF
 	depends on DRM && OF
 	depends on COMMON_CLK
 	depends on ARCH_MXC || COMPILE_TEST
+	select DRM_BRIDGE_CONNECTOR
 	select DRM_CLIENT_SELECTION
 	select DRM_MXS
 	select DRM_KMS_HELPER
diff --git a/drivers/gpu/drm/mxsfb/lcdif_drv.c b/drivers/gpu/drm/mxsfb/lcdif_drv.c
index 58ccad9c425d..d4521da6675e 100644
--- a/drivers/gpu/drm/mxsfb/lcdif_drv.c
+++ b/drivers/gpu/drm/mxsfb/lcdif_drv.c
@@ -16,7 +16,9 @@
 
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_bridge.h>
+#include <drm/drm_bridge_connector.h>
 #include <drm/drm_client_setup.h>
+#include <drm/drm_connector.h>
 #include <drm/drm_drv.h>
 #include <drm/drm_encoder.h>
 #include <drm/drm_fbdev_dma.h>
@@ -56,6 +58,7 @@ static int lcdif_attach_bridge(struct lcdif_drm_private *lcdif)
 		struct device_node *remote;
 		struct of_endpoint of_ep;
 		struct drm_encoder *encoder;
+		struct drm_connector *connector;
 
 		remote = of_graph_get_remote_port_parent(ep);
 		if (!of_device_is_available(remote)) {
@@ -97,13 +100,25 @@ static int lcdif_attach_bridge(struct lcdif_drm_private *lcdif)
 			return ret;
 		}
 
-		ret = drm_bridge_attach(encoder, bridge, NULL, 0);
+		ret = drm_bridge_attach(encoder, bridge, NULL,
+					DRM_BRIDGE_ATTACH_NO_CONNECTOR);
 		if (ret) {
 			of_node_put(ep);
 			return dev_err_probe(dev, ret,
 					     "Failed to attach bridge for endpoint%u\n",
 					     of_ep.id);
 		}
+
+		connector = drm_bridge_connector_init(lcdif->drm, encoder);
+		if (IS_ERR(connector)) {
+			ret = PTR_ERR(connector);
+			dev_err(dev, "Failed to initialize bridge connector: %d\n",
+				ret);
+			of_node_put(ep);
+			return ret;
+		}
+
+		drm_connector_attach_encoder(connector, encoder);
 	}
 
 	return 0;
-- 
2.34.1



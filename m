Return-Path: <linux-kernel+bounces-408782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD09C9C8384
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 07:59:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33DFE1F22D58
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 06:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DB491F6668;
	Thu, 14 Nov 2024 06:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="lo2fD/b6"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2053.outbound.protection.outlook.com [40.107.21.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09DE1EBFE2;
	Thu, 14 Nov 2024 06:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731567515; cv=fail; b=jN8ROltuVYs6W1iWw+DITqg7ZfvTFTCSXerrcOFyWTLdQHCrO0eowr3o1ZfW1pc7imIYTDtght1yOS0GfE/t1B93t1pEtSdUH5Y4k5tq5wUQEaN2clQrbtn4x5RZ6ha83+p0oUNcZVoExiGZHm0mG5Ve2+AJLkcVeNXGoSedATU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731567515; c=relaxed/simple;
	bh=TAd4ihyoki6zL+DyLFYnQSs9OboOGPkpc3C0pV2KNLo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dWNO102pf6vFGZP0KDOLzixu6yBnMpGGwfg9vPriyNnw1w1gV7CSwMhtddTcy3fOz+fdyQSQPljZQKaCOhW4qxgtNNB1DMxaIIU9WyRNFYVmwj3nagovgahVAtJwRQqpYB5pSXaRuwXvROsdlRAt5fNEc8Oy9fVftk5TSdoeYs0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=lo2fD/b6; arc=fail smtp.client-ip=40.107.21.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=njYxR3d7M6/2Q8ytamd2Y7/9Qy0SVMSBri2L/RASzTi1L+JzuQ22h49mxauWnN9ct71NLRt0ch8nEI98psBcR0QVAmB/yLpn+pzpSUUj4ZGVq7UC2C0GqHVsZJweJvcJh7nTK+2A0EaeSScGU5WqUjmquzDyK9jPMu4aMjsmQ1d+naO7i+1OWXAM/0ZaAxexUNYlg3QNdCogZVISgnaN5Z9vCfl/KIgw7mbxGrhgUKGOEw3EYxiy4ijdtGZhm1RY+uu3x+nMpYcbr25kYvtl+yV7Btb53K3Lw+vaBugFO4Ewm5H01JK9ZboyBiZdjmH6rPMNzYLa7Ukm/O7pN1XU8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EOvavuMtr3fhljxErEXqpchKljXV3glZ6msFtDr83AY=;
 b=TTIy8TZK967mMAHJXbdU6JbDpdE3hmywIsVdx0SWHX9sIBm0Wnb+RIrrgUzvNXyscugKmCYGEbVOAlxl6YKioaM0ppsIM1OddivjQcs8hj2MCZLFdaVwVVHRJ1T2i7ieRvveWst6evA3sgYOWLKLN2MTh57/308ogPJbcYw13bWGN6S+Bg6sJGqS1zF3/g0Qd+CiuEK1fhwjYnEWhp4Z5HzCfMmDvrdiOqDRL6z0zZyhTWaroMLiQChW7EUUAGA/B1n1+n62vHv2GB5zwOTXf5KYHj/OSlEkb8g/iSQCX3wdB5OlBQm/0vwVK/LeJrIIvcgFW313d6N8qhWMta3IUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EOvavuMtr3fhljxErEXqpchKljXV3glZ6msFtDr83AY=;
 b=lo2fD/b6u54d9pfe6A3Zu3sqHWnC5ArhjAP2o0FH7CmI0U1VKTvCjA92P9IziisQ1FafLlkOprCoRDa3KpgwdDs+ni+IhrmGeVV3EnyKehKKueZ3PYV2W/9I+/or3tUAhzIiaZQm/ciAxUQqcvVv5XoMKaWcx2LGFW0OWJPx7xUHcDpf/IS8yPujiPa1magTG0HvhR+7DzIMs8hixmFoFFS49btn2PfO8ONFHPEK0ub70O2yUXnwPL5q9soLi3IOi28ZAiEj3H84v4aAf66TMyATd2ONMPvPNUYcxpcPGWqaqICmEY4CpNA7YtoQ62vzQ/sbQdb4KxoZ9n7LT6Zs3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by AS8PR04MB9510.eurprd04.prod.outlook.com (2603:10a6:20b:44a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Thu, 14 Nov
 2024 06:58:30 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::d1ce:ea15:6648:6f90]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::d1ce:ea15:6648:6f90%5]) with mapi id 15.20.8137.027; Thu, 14 Nov 2024
 06:58:30 +0000
From: Liu Ying <victor.liu@nxp.com>
To: imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Cc: shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	catalin.marinas@arm.com,
	will@kernel.org,
	abelvesa@kernel.org,
	peng.fan@nxp.com,
	mturquette@baylibre.com,
	sboyd@kernel.org,
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
	quic_bjorande@quicinc.com,
	geert+renesas@glider.be,
	dmitry.baryshkov@linaro.org,
	arnd@arndb.de,
	nfraprado@collabora.com,
	marex@denx.de
Subject: [PATCH v7 4/7] drm/bridge: fsl-ldb: Use clk_round_rate() to validate "ldb" clock rate
Date: Thu, 14 Nov 2024 14:57:56 +0800
Message-Id: <20241114065759.3341908-5-victor.liu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241114065759.3341908-1-victor.liu@nxp.com>
References: <20241114065759.3341908-1-victor.liu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0048.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::17)
 To AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR04MB7046:EE_|AS8PR04MB9510:EE_
X-MS-Office365-Filtering-Correlation-Id: e271d7ca-b38a-43e3-6668-08dd0479bf36
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|52116014|7416014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?uY8kLeMza7t9htw+1xO8mdBP2tXtHq2nu9RSmjN/4gE6pLaYWafek2dljO+O?=
 =?us-ascii?Q?TVPlBdAtm/XscSwq+NqwGntnmTJUc+Z1Ng4Sy9Eo4o4Ltb+Is9OwxmmAEXEk?=
 =?us-ascii?Q?yjH7+ZB4QAcP33dqu1UC82hsqpqucUnyR7MVtwGo2h1acdDBT0HptkNPHk6h?=
 =?us-ascii?Q?c59ceusp6/MFAh34bI3H4cA2HDJtaXWvQz188BgDK9jSBH4T0BdUo/X/XftL?=
 =?us-ascii?Q?cKAzitSFUiF3Qn2eiR5D0dtUf4Au99f1yxEntWhvz2jyQciiDBV8NKcN+LRn?=
 =?us-ascii?Q?KaPxC2znAR+EQOi5XmDFwba22LRxMvR7P16RFG63bvDlBIHEgXHXRTZRSnUl?=
 =?us-ascii?Q?zFsii/pTQGeej59751C5cTDuigkPV2BdNuWeli7aETnbqmVBQ6SWvHa+YKCb?=
 =?us-ascii?Q?GD403laRJuiaBcWiJTISTe9xJ1QllZlMsdHPV7ztBWz9h8Np4tWB/X1YARHu?=
 =?us-ascii?Q?6GLYYY7AHgxF/2kRhVU0JKrRqMlyWMCnKjHk53pCJfKsh2sBfgAeJkWzzUnL?=
 =?us-ascii?Q?xUV0+O4kYLSWqevRBiVpbdpxQ0NC8AQEy1LAQoNDJwS7Gw5KDDRRpAyhAOsQ?=
 =?us-ascii?Q?V8r39zG3AiQCA1fzAUTIzh5lJ64ukmf2ASVyRSOe9IgSLy1yqapE4YD70n1c?=
 =?us-ascii?Q?QEBQbkmrdEHik1709Ug2Gj0EjqJx0UceKtANVqA1fMxxNKrWMG5KJ4VgYqbr?=
 =?us-ascii?Q?mCPbS5l3Rq9B/YIZcSxJYXaXZH9NlHZSrDttcTvYgM70D22yK0WY5bpWhucF?=
 =?us-ascii?Q?zFk2/MtXMhNVACRg1HDifj/h5m4Ob39T+Ld790IofyjHLL7FWPqF/NaEWl+1?=
 =?us-ascii?Q?cw5KMgMTXohivrn6ZBFSGVHu0x0Z98nII9TnsDi18ujCzw4HIYxdE+bejyZS?=
 =?us-ascii?Q?HXfXCxmDgEJds0K+jon/EFPjUXXqI9M+EcjsG50nHPCyE06RKJUd8+4DVC8z?=
 =?us-ascii?Q?niKxVXMXw+GUZYDWsLz9KcG9ipuenqvzURc/gDmb1n/q9IrfTG4MuMlNHR3n?=
 =?us-ascii?Q?jx0mwoKeSRVHd6z6FxhiYTT35lzGzO5qV0sru4H45nQbP0CoixuFjA0tjJTi?=
 =?us-ascii?Q?DfGl8VZwEc3EZ/dUYETl+CExV/nKy5XLO7wCbonFwmufebC/EOsdbKop31kF?=
 =?us-ascii?Q?QMIVHjM+hXXXujFaEOiqRNQDukl+Z540tgma9q8PBB/YnGkJz3LZKPPxlKUO?=
 =?us-ascii?Q?0HzKc/n3O6YrsC2cHMsZo2/Yi4GxZ7XRiJ3I4lo7nrDkV9myYTm9ZndTbOyu?=
 =?us-ascii?Q?QambY9+8VX9BRhQNFGeMx3WX2hwLMxUKdCgtpv/NS7Dl0VSTCd5O68gyMHO8?=
 =?us-ascii?Q?elMYxdJee2qa4vokXZpEHjFqgog0h6nG8XT9LMhVwtwtgRkGWErWQzM3+PJD?=
 =?us-ascii?Q?QgFVUu+L+mbQUbs2ErbUGTlrTyQR?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(7416014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?4dcNR8YxTAH8uQhjPX3NLdtvBn4DUsOux9gjV4Gjc+d+blZNNsKYY0MwbELF?=
 =?us-ascii?Q?Ry7WNajVPA9Dsut/THEjH01iL0HR0gC8jZfztMVCaqA8rNvzRnMXrSrWuxeP?=
 =?us-ascii?Q?xO57nn+qfaAn1To1B9YOUJ2o3s0kRvGmCPsbwPzB8sKZUQttFWmqnIyYPVz0?=
 =?us-ascii?Q?6JhISv97/SCMbwghBLf9MrAgBDS1D9WH0CyFjuGHzxaoWA0z7QyrMxHZ1mRK?=
 =?us-ascii?Q?6NYYf5LsLVZAEEbMqtaqsv2CFp/JT3UWe0KmvvBJ+BntXfpUtQsEU29wZ8FR?=
 =?us-ascii?Q?yDkAPkNJJlZLuATcW9dKX42v6k3soKFyIKtvFs6kMzzg5fR0ulSX5jbH/qRs?=
 =?us-ascii?Q?lMcqB7CthIPbG7YlS2gn56yB8lSFa2Kx4Rbdm0uOeFljsFekMdrgzfquCQl9?=
 =?us-ascii?Q?9rNoyupSIPoNaSKixw0X2chaENJYPUS+ZZ4TPErWCMBZABu9cTyt6XmLUfqg?=
 =?us-ascii?Q?B2rO61I8ZceA6SeeAueycj0VwHs4MX82TSXeR5k7oQwfec4eoz7Zh+F48hnw?=
 =?us-ascii?Q?0b+5ak3TSj2RDk5ZPJvbfBk/CDcEKvVeVtvdF/eWHjgEA7pwCDUPMHiApoTn?=
 =?us-ascii?Q?G7HsQLRa7+we5wWst/346Y6F+Bi5kL6oQzFeO21Y7YkOR7ghWcTzB1G5grqR?=
 =?us-ascii?Q?FFpH8I/E6Uq/lo63l5Mv1fRJCUX8xD/ZX5cEpWBOsOf7y/2ZoDAFGHjeHzj8?=
 =?us-ascii?Q?cG1bm+aH+GzX/OhPn6+viC14mCFQ66st3jrDjk8XZU9em+AacHGsveq9K6Az?=
 =?us-ascii?Q?p4UOqM1BzIUjyHuVcjV8GfqHvF/J3o5Y1NtPpn/2O/UPdwFYs6nSmshKHt6D?=
 =?us-ascii?Q?f5/VbaR/2HNeEeQ7Nf85XtKxZ6TVMYEjYN5ojX0khgyl3gf4g/1zgvm8gktb?=
 =?us-ascii?Q?awkJoRKMyfUwSE4UR1d7ddKql4rMCY4z90+ebB7I6TzzEJGh49kszukEFZsu?=
 =?us-ascii?Q?X6FOCHPUUgkaod7HdAm301Y9jcnUh9qT2uoUFzkh/hK7JDXxWeCVUgSRM08m?=
 =?us-ascii?Q?mPf+TrTXjljWMWBaAPSs6EdEOv3XEYLAkVkqQT99KhUrxDGm6ABN9m1Vc3ds?=
 =?us-ascii?Q?Yi5LDxVOqpQdeAXJOjOde4kfAB1kbDhQlge86NEdmOaVe9J7hPGqFR2W2fGH?=
 =?us-ascii?Q?s/qjitKufDOoUSDjeLf+0Q1AdiD7iPv/sgf1tJwWvIlLyshdNw9cDsqBWJQB?=
 =?us-ascii?Q?n2upTVL4XMiBNu1B9oqIAkfqGWEp9eSOKkQ6/Me+qZB1JYr1jq/FE9z+X0HP?=
 =?us-ascii?Q?tnbcQHG4LI1J9ZDxOLg8UBFzZXKP3gVjhYBoq6s6LwoHAu5dUS9Kf5hC1uk9?=
 =?us-ascii?Q?gp5H2+UN/xldnSPhbKy0GHd/B/+zqUiWwjMQ7eyDCVyCmbFzJorrvcUhlM2B?=
 =?us-ascii?Q?CNm3RTVIv4W57oG3QdKVfWFfjzLQEtVEa29w66sfx+nSgLfPXZKhAOoKagfJ?=
 =?us-ascii?Q?TmIJhI+GoAv5dC1iBoVECgojRsgfMCwTalumihWSRgfI/xIscFeeaZIS5Q3E?=
 =?us-ascii?Q?Lzl2TRYFX9oAc19gpIRR1zLkJM+LvhAKe9u8+x8XcNn3AGm6kHa/q3z7CFaN?=
 =?us-ascii?Q?+uspWHYVYvQgDtofDSkBwJBwC2Fsj3pgxUPhQchK?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e271d7ca-b38a-43e3-6668-08dd0479bf36
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 06:58:30.5281
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kUpM4xkFyj219qm6Qvh84yfLL4tzh6289b/EibCQQTZTia+cJwCeAD2XPiW8Mx3CRqiRPrv1aaR6qzJvQ8bhIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9510

Multiple display modes could be read from a display device's EDID.
Use clk_round_rate() to validate the "ldb" clock rate for each mode
in drm_bridge_funcs::mode_valid() to filter unsupported modes out.

Signed-off-by: Liu Ying <victor.liu@nxp.com>
---
Note that this patch depends on a patch in shawnguo/imx/fixes:
https://patchwork.kernel.org/project/linux-arm-kernel/patch/20241017031146.157996-1-marex@denx.de/

v7:
* No change.

v6:
* Drop pixel clock rate validation.

v5:
* No change.

v4:
* No change.

v3:
* No change.

v2:
* Add more comments in fsl-ldb.c and commit message about pixel clock
  rate validation.  (Maxime)

 drivers/gpu/drm/bridge/fsl-ldb.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/bridge/fsl-ldb.c b/drivers/gpu/drm/bridge/fsl-ldb.c
index b559f3e0bef6..d9436ff9ccc3 100644
--- a/drivers/gpu/drm/bridge/fsl-ldb.c
+++ b/drivers/gpu/drm/bridge/fsl-ldb.c
@@ -270,10 +270,16 @@ fsl_ldb_mode_valid(struct drm_bridge *bridge,
 		   const struct drm_display_mode *mode)
 {
 	struct fsl_ldb *fsl_ldb = to_fsl_ldb(bridge);
+	unsigned long link_freq;
 
 	if (mode->clock > (fsl_ldb_is_dual(fsl_ldb) ? 160000 : 80000))
 		return MODE_CLOCK_HIGH;
 
+	/* Validate "ldb" clock rate. */
+	link_freq = fsl_ldb_link_frequency(fsl_ldb, mode->clock);
+	if (link_freq != clk_round_rate(fsl_ldb->clk, link_freq))
+		return MODE_NOCLOCK;
+
 	return MODE_OK;
 }
 
-- 
2.34.1



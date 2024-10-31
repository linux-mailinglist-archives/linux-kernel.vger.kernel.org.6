Return-Path: <linux-kernel+bounces-391403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 391AE9B8634
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 23:42:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE1801F2258E
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 22:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E63D919F430;
	Thu, 31 Oct 2024 22:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="PThU9YB+"
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010037.outbound.protection.outlook.com [52.101.229.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791451E481
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 22:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730414538; cv=fail; b=Hjgjaka3UYyHjvcP7Pb4h9dl6XNMCcGDY96b0FnQuNarAfjZ7gF+DheXMjlWiXKJfEFVWIjN74K2D+JZu6hklvH+vPYJDF5EbVg8T6LzPNSXWlk6NHxZOKaas9IX4thZqtivRDQOkbHYn4psHuhlD7auJBbWKck2ajWSKYeF5yQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730414538; c=relaxed/simple;
	bh=cEnrOGYKqfYb676ec6LRlPZykpMz0BLsYSwPOsnJusA=;
	h=Message-ID:From:To:Cc:Subject:Content-Type:Date:MIME-Version; b=qqlAnaj5u5unAgFoYcsLIGtUU5TSCU354m3WTf52yQSri6mD6b2/+esJw5or4aYXo4lrFMIBT+nbwo52nQCAHDvqlfMdDYm+eZ1dtMmQTNbvIvMQEUfhQd9EgRAwkR7asMb0tEmzrdpC0Bpmdh4vlewsqkd+0GB006C2jzs0tes=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=PThU9YB+; arc=fail smtp.client-ip=52.101.229.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jD0lodGX/f6HSwyxMOptVWIfY5vgh38sC7zg0WOQ5LjlFcp7gKU14iU7Y7x5cw/mKbp5v8g4zuyX+AuUpM/6VQ9KATyI/2Oa95dIlGL/5eZ2Jqwz/KULG8p/4IYRTA0FUHRXXlGfu2mjaoqdMWtdzOZ/sqgnmfxLlrqMiTeXL8SYubd76TTIRsMnmgEtcOJREw1xdDrDQawNiXohhi5vjeLDDF8RyiSCLPouBk5V3qZs9ddFSNfokcMSNslADwmJ7bLoNgkdUoLOAopFU6W60jvQIDdCdsgO8S2sHOgFuGOa2DY8hmWcjZNTmT6jj1KgNBz3QW135PIDZba3Rrswgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZnXy/TrXXZ/7OyH0wCOOF0RSj1r1kTICGhTmNrMpzGg=;
 b=BA8Q9GPAZ8DXuZYjI5Qm8RBYwRexVO7VhwO2TxI0fXVXmuE5PFxKSzUCZSFV/89WEJxXuea8X1RsXcTZXdCaWjlopXOWg0/+7rdnDrDzk0CtyB5AJuY6tzo4u2uhKZDFSk98Ctx67EserTAmJEfaZs6IijbMBgvYNGsOXIvaFgtJVWyM6iW83A+QmP1wLpJmjE9LmO+c/vfFwU0+FqLWWXOHX4gGVYoqLchzmXjF0oE8u9yJFghTwgtZyey2HabOwM2Geu5+dHl7lAbUR9/WjrZrAEtczFDeuRML0XlFQxDTC2AY0omI2d7aRbX9JdjCYEaAlCQcQApQki+XNxPC5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZnXy/TrXXZ/7OyH0wCOOF0RSj1r1kTICGhTmNrMpzGg=;
 b=PThU9YB+RBh8umTko3p7Brq1DZBPPJd5/aCrT7vRtpOQfmWFWhevl2XtJVSLHou1I/hleMhG8OUza6idnyQMtVQ2lZI7OkEBg7eIEPWcdxorGmhNWB2EJvr9rLhgYZCa5dEY2vBsBmnU4KSXWsmkRf+nrdR5Dmhnq2g0hBdaZuk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11) by OS3PR01MB9851.jpnprd01.prod.outlook.com
 (2603:1096:604:1ee::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.18; Thu, 31 Oct
 2024 22:42:07 +0000
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11]) by TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11%6]) with mapi id 15.20.8114.015; Thu, 31 Oct 2024
 22:42:07 +0000
Message-ID: <87frob3neo.wl-kuninori.morimoto.gx@renesas.com>
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
To: Rob Herring <robh@kernel.org>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Thierry Reding <treding@nvidia.com>,	Daniel Vetter <daniel@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>, Florian Fainelli <florian.fainelli@broadcom.com>, Alexey Brodkin <abrodkin@synopsys.com>
Cc: dri-devel@lists.freedesktop.org, Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v6] gpu: drm: replace of_graph_get_next_endpoint()
User-Agent: Wanderlust/2.15.9 Emacs/29.3 Mule/6.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Date: Thu, 31 Oct 2024 22:42:07 +0000
X-ClientProxiedBy: TY2PR06CA0015.apcprd06.prod.outlook.com
 (2603:1096:404:42::27) To TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB10914:EE_|OS3PR01MB9851:EE_
X-MS-Office365-Filtering-Correlation-Id: 22238998-226f-4cb6-ba7d-08dcf9fd3fde
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|366016|7416014|376014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xRuUFOA+9Q/EPMCyRgh3bxJNyPDUIL6WkHutQN0cCQI7XLi2pOD7CNKUCSyu?=
 =?us-ascii?Q?rXHQnfHQddCL+65nHSTBPtpgc2WJ0OrPFiXX7P22or+QnffA1YE/TKfbCkSW?=
 =?us-ascii?Q?ySTgCIACq5unq30QvBjvYAYKZqMXwcdQD/kx2E59BPTjGTlfvfNga+WqMWE/?=
 =?us-ascii?Q?x5D7zK2jMMSBYwDzE/T04vScIRlgxTu1pk9c5ZH9TKLsG1S6EXiXAeb9Mbyf?=
 =?us-ascii?Q?pD+vHsHYGFWIjJy+G/z0TUNaetB7MIebm+PaxXiSZo74nGbklBBbBE4CpDFX?=
 =?us-ascii?Q?JrobT0EaJzzQ/BzAiXUn3xwZNrZZEVHNgh/qTqB4oXLo+41ddOsr2t3AgR7o?=
 =?us-ascii?Q?+7ggWx9WxvYKFj/rtA5OEdrlmIxNruxdpkXQn2at+hypYVMCcwE06YaC6ZuG?=
 =?us-ascii?Q?XtjITYwW1Dn1YMHXyeSsR6+Ct4vvOaUzrrlSOqEiQzbUGTeYtvTv9U9vIH8p?=
 =?us-ascii?Q?JKxACnSWS2hiEmCgBRp2ZEoAf2cIC0s8Rgmx5Q272kjVppInq8i6ENZhkcGO?=
 =?us-ascii?Q?YWNbLHH5Bc5OG2vQlzfuYtywobu+xggErTe4Heyu30NlIFVl5fsnbncU4PmU?=
 =?us-ascii?Q?ODoH6mVHfjaFBoJq8nTSwTvF13xk6ySDMUVZmDw0510CPNWkLUsrGbCkpxpc?=
 =?us-ascii?Q?0gpKSFueskTNr6DW/Z0WMsbfIa4paZ+FIGZwHU5M7WlIrwf6wOHt5MmuQWpT?=
 =?us-ascii?Q?ioK0CkP7Hwh64fHWv0ZkQP+QOCpRu+yx7Th5S4m1gLRnOwhpbbbmA9Q9Z0Fh?=
 =?us-ascii?Q?90ftdnxxJVI8Ufr4Ym2jzo+CWgs6GSaoA0XCDATll4LR1lC/q09DB2U3hs7B?=
 =?us-ascii?Q?UVNXTUAdDhx+3/GaIefGQNaX0lwes02lyPV66tJDLIjp7Z4Pc9H+sJfkCKfg?=
 =?us-ascii?Q?Ug0tbTBJrqzMtYFc41WZmHHJH82AII8vNrmZABxnvH7rKIoGP2TCrXlCtn1e?=
 =?us-ascii?Q?XPKLTRG5bUU2MQk+AVoAhpqcVNItxv+5j3EncLpzIJwC2I33XmVLIJ3VxLsI?=
 =?us-ascii?Q?rubv0FMh4ToAqxw0OgoCT3X2L1tQu2FeC0m9mQlWG3hnYOhB6QUauaJHoS/2?=
 =?us-ascii?Q?jdQ6Gf0iDm65laaryfEm4b2uYARTRwIRuDvsJ4zgxBooKKwnYXkhLQtncwWI?=
 =?us-ascii?Q?W6qSWa/4CYBzVTTeMHzjjjtjdpn4mXEDUKoihTPmSgOcSJHBmusrsDBZjkf9?=
 =?us-ascii?Q?6lDuFTeCfb4vTtaKQyvF4kyYpjjd7kKrzguRYLboMj9lQ+Q6xbwEAD+DTpqO?=
 =?us-ascii?Q?rwWBpqxAqSSGiDUKvgcrLTt6Hl9tlsPi0ASyZP+8bPy2j0dndP8f/hw4nKhi?=
 =?us-ascii?Q?ctZyA4vBnc2BXvNRpEtnmwVYPLHKVKuwfzqUAWpMjYa3BVvAJuze4b8oG51u?=
 =?us-ascii?Q?jTuuUwjohFF8JYLqKgfBDtN7Wobl?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10914.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(366016)(7416014)(376014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TlsTKOFTouX+Kbc2d/ncwkd6pY1M9cz9DTvF6g2/pzmQjMuhC6x/dO0h5nC2?=
 =?us-ascii?Q?HIjh88ETZXOeXnn7t7eizWklc/MqG8kN/cmXHYZZ/kKVmgKHysewLVaYlYg4?=
 =?us-ascii?Q?+fEZF7zWdqgqP0mz8YQGVq0CZw0mwjMQxG4L74m9sSMHHb0ttEFBaN6xIrvh?=
 =?us-ascii?Q?/6XcllWjCf9wL2023EjDPZR8vIMw8klLiH/gO64PdskRmzZCl+ZtI+kKKnRz?=
 =?us-ascii?Q?IAobzGqKc4XViGdP3l9rpXpB+xcbYQoZNkUVvSlVfC7bI/mF58fqFLYKFsFi?=
 =?us-ascii?Q?aVsB0NDe1d2IFDqYrFm5zmBhi6daGEIWH/Dhn3NkL7Z9ifhYTPH9L+Y5jDgI?=
 =?us-ascii?Q?lSOPSJmndV22+tN3Okx+yeIwMFPmGUxJMAoJN23sb0+xDoWYpVDOGE3cq1xT?=
 =?us-ascii?Q?jG35UHTZhuWVYUVhg2ij2LbbdAEcIUq+/6MGBNB+4QWkXKhLQ9BHyb099OKg?=
 =?us-ascii?Q?Jubp2XikYw2mi1icC+Xd9S4YXpuHA19t7NFBNFmbLYNZ61lMWhCxbgtjK37A?=
 =?us-ascii?Q?Nd7e72btbqzn1ycMV8da0r9LCJNUP9fF/35UFw4MCFAfO64IZcjSACSW5on2?=
 =?us-ascii?Q?fpR5GMphNN1VUN3VZMAiqOjR8CfVtJk+9+PmXoedHmNOmjGBucnckg4s69Bm?=
 =?us-ascii?Q?dSPWNUY1PToqCaoqTEMhELENSRLuIdOfR9swjNsxvAGEXaXyACcHL6qhaioe?=
 =?us-ascii?Q?Jdr6kURBLOSpqpuME6TsI4XL4jRqrBE9XcwxxGkhyDGr63RfwT/W7zX0i0RE?=
 =?us-ascii?Q?nV7Ea0fqz1v+v+Rvr2L+Vs5fo6CfQYMJCCVkygwQH+Cg8UrJP2bXQTA33E6R?=
 =?us-ascii?Q?77r1NBB1H+8RJy1KgFNKN0roJ5Xx7uGvAFI7CZt0KfoPCnKvLZJbOKgs/SVv?=
 =?us-ascii?Q?QTNg5GlB8VY7vyC1Lp/wrTf3d20jA7yRuYR78kcOQInoFPwhUh5o5kf1jRsz?=
 =?us-ascii?Q?a/Cr0+Bjhje4g4Sa56LhebXjmYwm+SiV8CS5UC8nIBV3lyalDFlt/T2dXLRJ?=
 =?us-ascii?Q?WkVlpUOWpH2+kNYr8Yk0eAfJhptL45ukOFYTv2OAOHKiNEI39O1LJUU/Nfd3?=
 =?us-ascii?Q?ajj5qA358ktypREOS/w9t9NDWc9mSl7A+2HXgBk12SoP0exevmU1yZBDTbFm?=
 =?us-ascii?Q?v3PBksX3Dme9l9etdQc3xcFYpTN/aeZoxjV6Uxry7zh7FxASXbVpVKcLRTEv?=
 =?us-ascii?Q?g3ndvjJY9/krHvdzWBVt4M5/sMxX7aJe3ZkxmxGnjebstGiZgncIvotE3PDN?=
 =?us-ascii?Q?qIJMXJCZWpBVBK4mwoPnCnAmx7xYvyXs/EqXA/Pb3ON9R7aHra9HA/77BEyR?=
 =?us-ascii?Q?Qra/7IMK/aLs8VTJFE4nfIWbNP2GPN281531PTblUIBifSY7ymrhe9Gz62KN?=
 =?us-ascii?Q?eqhZj4BUIfi2lWepl7hc91ko1yoW/3kazmHPFev0969tTwL9oL7LsB+TBZMF?=
 =?us-ascii?Q?Ebm/qd/mr9WDVsHQCN5ujqPWuX2U0460yxds1CQHEPNPZIGYrW3rsvzQNPLP?=
 =?us-ascii?Q?mTPRwAPGsWtYu1OCvsQppsKijbKu+6IMcJI7mvD2OSaQZvUjLbodBIzqoUg8?=
 =?us-ascii?Q?Sqx779iplhxRsyA2L0o1D2ysm1gYcUbXf5XNuAoVZonWPhFpnBWGfT5f3cQj?=
 =?us-ascii?Q?1N6KBUJzr8v40HM3LWehd+8=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22238998-226f-4cb6-ba7d-08dcf9fd3fde
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10914.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 22:42:07.4261
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PDDkt9NbccdjwWlCgS6LBzfCcGnVeVlOhy60B6cXnB0nqVBYEXoYJYTX1leGwWZj5TZCfyCS/AsAurvOU168cuqqECO/IVIbDEUVO8AVGGNqecQQtTGiRy3gX5HWYbnm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB9851

From DT point of view, in general, drivers should be asking for a
specific port number because their function is fixed in the binding.

of_graph_get_next_endpoint() doesn't match to this concept.

Simply replace

	- of_graph_get_next_endpoint(xxx, NULL);
	+ of_graph_get_endpoint_by_regs(xxx, 0, -1);

Link: https://lore.kernel.org/r/20240202174941.GA310089-robh@kernel.org
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
v5 ->v6
	- based on latest kernel branch

 drivers/gpu/drm/drm_of.c                              | 4 +++-
 drivers/gpu/drm/panel/panel-raspberrypi-touchscreen.c | 2 +-
 drivers/gpu/drm/tiny/arcpgu.c                         | 2 +-
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/drm_of.c b/drivers/gpu/drm/drm_of.c
index 177b600895d3c..b6b2cade69aeb 100644
--- a/drivers/gpu/drm/drm_of.c
+++ b/drivers/gpu/drm/drm_of.c
@@ -504,6 +504,8 @@ EXPORT_SYMBOL_GPL(drm_of_get_data_lanes_count_ep);
  * Gets parent DSI bus for a DSI device controlled through a bus other
  * than MIPI-DCS (SPI, I2C, etc.) using the Device Tree.
  *
+ * This function assumes that the device's port@0 is the DSI input.
+ *
  * Returns pointer to mipi_dsi_host if successful, -EINVAL if the
  * request is unsupported, -EPROBE_DEFER if the DSI host is found but
  * not available, or -ENODEV otherwise.
@@ -516,7 +518,7 @@ struct mipi_dsi_host *drm_of_get_dsi_bus(struct device =
*dev)
 	/*
 	 * Get first endpoint child from device.
 	 */
-	endpoint =3D of_graph_get_next_endpoint(dev->of_node, NULL);
+	endpoint =3D of_graph_get_endpoint_by_regs(dev->of_node, 0, -1);
 	if (!endpoint)
 		return ERR_PTR(-ENODEV);
=20
diff --git a/drivers/gpu/drm/panel/panel-raspberrypi-touchscreen.c b/driver=
s/gpu/drm/panel/panel-raspberrypi-touchscreen.c
index 4618c892cdd65..e10e469aa7a6c 100644
--- a/drivers/gpu/drm/panel/panel-raspberrypi-touchscreen.c
+++ b/drivers/gpu/drm/panel/panel-raspberrypi-touchscreen.c
@@ -400,7 +400,7 @@ static int rpi_touchscreen_probe(struct i2c_client *i2c=
)
 	rpi_touchscreen_i2c_write(ts, REG_POWERON, 0);
=20
 	/* Look up the DSI host.  It needs to probe before we do. */
-	endpoint =3D of_graph_get_next_endpoint(dev->of_node, NULL);
+	endpoint =3D of_graph_get_endpoint_by_regs(dev->of_node, 0, -1);
 	if (!endpoint)
 		return -ENODEV;
=20
diff --git a/drivers/gpu/drm/tiny/arcpgu.c b/drivers/gpu/drm/tiny/arcpgu.c
index 4f8f3172379e3..8c29b719ea626 100644
--- a/drivers/gpu/drm/tiny/arcpgu.c
+++ b/drivers/gpu/drm/tiny/arcpgu.c
@@ -288,7 +288,7 @@ static int arcpgu_load(struct arcpgu_drm_private *arcpg=
u)
 	 * There is only one output port inside each device. It is linked with
 	 * encoder endpoint.
 	 */
-	endpoint_node =3D of_graph_get_next_endpoint(pdev->dev.of_node, NULL);
+	endpoint_node =3D of_graph_get_endpoint_by_regs(pdev->dev.of_node, 0, -1)=
;
 	if (endpoint_node) {
 		encoder_node =3D of_graph_get_remote_port_parent(endpoint_node);
 		of_node_put(endpoint_node);
--=20
2.43.0



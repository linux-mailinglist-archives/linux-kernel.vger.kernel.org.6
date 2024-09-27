Return-Path: <linux-kernel+bounces-342204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EA41988BA1
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 22:56:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3BF51F21F44
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 20:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FAAE1C2DD8;
	Fri, 27 Sep 2024 20:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="WdVowDGT"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010029.outbound.protection.outlook.com [52.101.69.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3AA158DDF;
	Fri, 27 Sep 2024 20:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727470599; cv=fail; b=mJ84SaAzUZolL+uaB42unHOdBIjw6CodYh38wv3Q12y9XtQgXrfdsNDMJRj9goH5qoy5xQlBfKwnHQyyBD8fFeNJUkVmqekQyg8iuLIw7rVE/u5ydmmoqLKTpyaLBYDysEY0BlTtFN1+O0MjeH1go8xf8tazRuQNCW3iIgxq73A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727470599; c=relaxed/simple;
	bh=hiOokwGNJxUa8n/NFsjTFhErKGH4SZ9Inp9wXtGp6Sg=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=k/xLBAbHNYt/ERm/4jmb4se2DPmt5OZhKWY+1woXRz9WGyxDTBJlrgqfT2LT2gXjAiio7FpMR6LNkq65macLpRu5B1AgxkeY3qYKLgwj9o1K3kGb2QZLIzrDbTuwdM+7fP4ROz4TVF0U6E2+cKvHKhQkNXj4snDx5zrSlwqbGvA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=WdVowDGT; arc=fail smtp.client-ip=52.101.69.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lWlO6FPJsPqB5fWpJGfM12ofLKQMX9OTQCKrXPgw0owegRxslvRVyUfLNCB2xvTVEo69npcQQgz1azruU+mf5xZyQ9oIb9NPNnlDQSA7aPezMOvNREjt5/2xCDUXjDHUiDxWYd5aIRhatjjY3PyL8mzqO0OPH6aiRU5uBE9/5gwhGvF9sXMeyQuQIeZyofkvdrywdgSi1luJUEE3KcJyfFltNqF7TiH5pXdFdBoY/2vsQ09/h3xKyruddjt3mGphLPULIJVVXAIgk/RA1KowybZnGnizchhQoVL8XpdHUjqecKNVOzBp8xznJvu30tH0QJwoW9FU7k6s1Nmns5SHcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sBx4RzYfPxUaparABcNMFdUADuJkQWBgCAwsPybFZXQ=;
 b=aCp6NZ/TijnN/JQ6mRzwtz11qmKoJLRj9KDYThwvJx71QUhW+K4fMSYkRQ0mPVntgb1wj5ZxPTvleY2SEsn8sphFd+abBLawEBkjNfOAvzBUQB1LAFwf8VtUOuPqRDJJev75xiwe/jbbaoMGdqjE6CpUGyI4/x8j+tdIctLr1d8n4r3Ur1yLzEiD4MYI+vDLzMCR4oOgxNBgjGcq4pK/XQf0jpaxrsPyA3ss0L5NvnhVLoZ/VR9JooxcwVc04KlTUoBhesgmL2MJe3Kvj8fViwHrr6FoVEa1u8+sJczld/pfBvHBG07+An5Qr8z0TM007BvNkgqJrPJx3monhNuYGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sBx4RzYfPxUaparABcNMFdUADuJkQWBgCAwsPybFZXQ=;
 b=WdVowDGTIgRbkjtTcExC1FLLELib0BiTeB+Ji6e3z35YU86IeJzVgMT97f82HtGte9AT7NRqHSadvFeZzAXHQdh2UWnvHfPmefdJCYP1Y5KC8nv9tvFpfsloQNzYVBr2iDTAVOMrpK4mJ217b/nPtW/6sEAOSqzy7VNsWI8oi73mQYaXFi2/UyqDcck2XV0k9LRw7V4vJiegKtBeCmXUD84SeBwgxtG644jshmxjRrg2pydkjalPh8OR2pR+JzBG+rTINw4PSygzAv9YXZvErnkBckQdxlw9g+b7AZwDT6JjDsX0LhcIOnQQ8MKPJ0+rC8OSTAC6i9XRVHACyv+ZqQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA2PR04MB10411.eurprd04.prod.outlook.com (2603:10a6:102:424::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.30; Fri, 27 Sep
 2024 20:56:34 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7982.022; Fri, 27 Sep 2024
 20:56:34 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	linux-sound@vger.kernel.org (open list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM...),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/1] ASoC: dt-bindings: fsl-esai: Add power-domains for fsl,imx8qm-esai
Date: Fri, 27 Sep 2024 16:56:18 -0400
Message-Id: <20240927205618.4093591-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR17CA0059.namprd17.prod.outlook.com
 (2603:10b6:a03:167::36) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA2PR04MB10411:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d467676-e879-459e-49bb-08dcdf36df27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?n0Ku2lmRwcuI28/RBU8ShAdZGqfHXx+kEvKOfRWvrpZR5j5iZCF4RQ/iaIUL?=
 =?us-ascii?Q?2e94fj0r0wMfMfGZFy0Fh0hNDw2wvEy0a5qQ383Iq0xYeAWFd9QW85SiZ1Wg?=
 =?us-ascii?Q?yl4nuDT09UIA+A63F2cM+GbryXUzjiC15qrYoCZYp7cf6s47jWcInv7PgGBj?=
 =?us-ascii?Q?LFtL3ER0rz5UKpd8cMPzLWSIaM7BfeYDYHlK2vhey+FTbFX3HMG4Zist7734?=
 =?us-ascii?Q?Bqfwl7D6rNpaeQy2b/ESKYIjqIyCiyP4wV5c09qrM2aH7+dfna1TxpW7Kotv?=
 =?us-ascii?Q?t4kIvi4Inn+nnLmFViwjOtul8Zb/6HPSCw8HFcdGv6YljIFllPPWZpDmqVAW?=
 =?us-ascii?Q?XPbw+s8ip62q6LlB8yc1aOy24CyjSXFvXCPSHc7ckkb/diwnKXQ5JXs9j2rX?=
 =?us-ascii?Q?T0AMv5VXyQD9KNCCDxh+NZnOft5d16P7uOJvpJmAvPh35txbWFBg8HUZeGqh?=
 =?us-ascii?Q?Pt1V1hsUxGU1zVL4dI4q9PXWK+VH+z0UmkCPIN7y0pQNTips254+VKGBNLxW?=
 =?us-ascii?Q?EH+kB0L8kQuIVSSrvQd4izNv4XvnG0HIc5y8FTg7MYxo9HCkl9N3XSOIMnKp?=
 =?us-ascii?Q?SEQaawztCfr/4NYrHTr0psQDqXnfx0UhMNXOoTIgRIgELrJdIWbpnjJTXA7Q?=
 =?us-ascii?Q?vYdFKX8+Q6AsZIc78VwZxXNMZKuvLTj8wYDYQ+wcN9OIQeUvYip1Qns0nRhr?=
 =?us-ascii?Q?ayja/MOC9GgCBLkv6F47WmDY2xNQ0Hk/QaeWQn0PlilTOEuInJSR0VwlYApr?=
 =?us-ascii?Q?e6+QXJJvJmQ7OAkvELr3rP6zoRE7r+ue5Tas1iW97KHpCBbbl/BZr9ZeZ50z?=
 =?us-ascii?Q?31lmzReUGw/UJsoD/g6dYB1doC9qPoSLtdjhjFJ4fChPHjHcKY70GDWywEC0?=
 =?us-ascii?Q?Za+fxOjIAuMCf7s+lTvSrjMdml1PVFYy9KnVohyCp4POHnfzzgTJHofftLfp?=
 =?us-ascii?Q?pJ9hXpVM1V0kI/Dr26pSWmTNuHJrlJR8LnYySl/GTBd/XJdYSNvmCECB9hZ3?=
 =?us-ascii?Q?4RBy4pRWtqx6XMubrY5zzgBJUMoGIMe0q5srHMW7DOARZY94OpJ09n4SoWMI?=
 =?us-ascii?Q?MC9VqM53ZD/TEeOb8J1wA2rTrErlFQzP1D7Y3stYIxiNIzYXjrntn8Yeb8u8?=
 =?us-ascii?Q?PMhZu+h0WxnuYqd37bnkyeE9cjlT6fQ7ZuPea6UqiqB9Xbyd6GFl3cYeLfU0?=
 =?us-ascii?Q?fAJI1prlnfPcn1m71Qz7jdeBeEpE6GzbNb19jZucVtRY1/azn1V0P2zuTqkC?=
 =?us-ascii?Q?VmlzXorXtg40r632ERqxzfu4oYD9lfQOmDsDJuAxXaKHylOzxOMX8nSTBRhm?=
 =?us-ascii?Q?jbNn596+3TlxYjbUpl7P5r/7nPQRte+vHMYyfJJC/8m4/Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vZRpbf4PI1jwb7zYfSfzr7cf0RqFYi3uWtdTC1JY+0hZIcucodJcqHGHSheV?=
 =?us-ascii?Q?l4ylipPc78WBSHuEsAnjHnmkCbs50Qc7HKo90RaFGBy7/EawZpc6o2Sgj0Ks?=
 =?us-ascii?Q?kGskT8XZbezaq0GKKUIwcZmOBERnqUbxh/FYJIDaOfLODLQGbabZjWs9bwZP?=
 =?us-ascii?Q?h/yqg+jinjUx63D5CLnlD10YcU9IHebqIBuZanuzwJa+yY0kWEcPNTDX4Gwb?=
 =?us-ascii?Q?IONSvtsYRddVikCFA12YXDolgFM2qfGkZeqpGsnPk1chjnbLqZpyi3AzFEFf?=
 =?us-ascii?Q?x38yFh+K9I2Wg//+olBuA+sc/zUYiE28NK1kj+TUxOSJXd3/C1AfMN531P5F?=
 =?us-ascii?Q?wmrQLu5/oHsZmyVxiOIOlDuJtuNu5/586cDGkVWyEVCM56cZsoU8EG9IRkgU?=
 =?us-ascii?Q?NqE0Xqu5Rg7rHQPJNoBXb/3w0hk2K1v6D80/nMOX27DRMXKO8KrjFXHA35rr?=
 =?us-ascii?Q?1TXcRu3ip8pyqFKTbWHaSHEkZgD3x1L5vTxF8TRzirox3l+c1lKrHyQ4cF+Q?=
 =?us-ascii?Q?BUGaqZTMRRUIuvjmQBsV5c4kBR3WgvP60OtttsKQFNWxhMEEoGHWm2e9xhSt?=
 =?us-ascii?Q?IQlQAM2p7+eWUeYDUEvHvJNwF33Pk4UqEFRfNLYe/uhWP63fgcH2zxoIzMwN?=
 =?us-ascii?Q?x9igUCY9fPTlYCyI8lHyyuq2mn+HXvNQG6ijR1slNCwVp+J8Y9rTDP26FsCX?=
 =?us-ascii?Q?jEC7uoR0KmkI2z2OXoH6bdvNvmzpqG9bq9z/mANiOUHcty1Qbpqwb3ayeA8m?=
 =?us-ascii?Q?G2GMEgwkX0djgdUrdq5EnlxYUEqwasHg2m7ZuSRsynSAHrOzU7EaRMsnqNhZ?=
 =?us-ascii?Q?Lke8b/V1tacnuuZChS5vQM29UjjFUlO3tFq4uzfjC1uxAgzFkGPZFlNpOz7f?=
 =?us-ascii?Q?3lPX78XT26DWzqRzgY0WioS3KXx+nn5VsPKf+r5db5oFL6rv4gbe5Rcfwyzh?=
 =?us-ascii?Q?i8Z578D7jUGPSJ0nWSBpJkQxgGoMJSDFoP2XJcQLlMy/0aFeFS8slfJIbEjf?=
 =?us-ascii?Q?+KItodvAU8CwF6UobV4an6QTvYfcjUV0VxfbyN+7VQ5ChOm9huVV1OJ4r8mW?=
 =?us-ascii?Q?cqtbVyl1p4qIP+4jLsnfXEZDc3JM4olbq2BeWx2jsPXSqe5rBigtt3v/WIVg?=
 =?us-ascii?Q?BLPSeuhHe9IhUhbvUqE1NblCmZA8/joktehhOVobixCBPVhXeHXH7xepwEKY?=
 =?us-ascii?Q?eDOQ9WQjgMduXpe7+Jwv9K+euMMOVOTMVQEZTfabxeZHsrR5ubG5o2IKDjKn?=
 =?us-ascii?Q?OdiWRziATHKt4q0+giaFA2bkcyxv6ZqbI/OTw1U/2apnhDSkCbCfc+mZeC7x?=
 =?us-ascii?Q?3TzNnsj1r0e26RnmCb42YpKZxn1EVY200vXSfyDRIOcE1xUQ5MogTK/gm7Ab?=
 =?us-ascii?Q?U/ieaHkC3t9+VN4gF2FKmvp6eYJkF0Iak8yVWkKk6+lewkW2o3OCifidVha4?=
 =?us-ascii?Q?30K5XmKNv3T7Bal4udAzRhhxnpzisMIsOqkGTqD5rqfM6NE86PTM5aDrPCGB?=
 =?us-ascii?Q?Nd2oAUDgowCedi9j4/jzmARS5QK39/mpLcXDK54Y1ievyq5oDfhr6x/q8mrG?=
 =?us-ascii?Q?3ddGwjPiKDVqS25vYcg=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d467676-e879-459e-49bb-08dcdf36df27
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2024 20:56:34.7750
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ff8KZV3lSTewNya31fIMYrdKRC8Y6AOmCeD5xFpYEUY2dVtfbgNn1bS3BpkzZuer5vgktu1R9Qh31GkqsOvPzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10411

i.MX8QM's esai require power-domains property. Keep the same restriction
for other compatible string.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 .../devicetree/bindings/sound/fsl,esai.yaml        | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/fsl,esai.yaml b/Documentation/devicetree/bindings/sound/fsl,esai.yaml
index f99ed20fa684a..d1b4e23f1c95f 100644
--- a/Documentation/devicetree/bindings/sound/fsl,esai.yaml
+++ b/Documentation/devicetree/bindings/sound/fsl,esai.yaml
@@ -65,6 +65,9 @@ properties:
       - const: rx
       - const: tx
 
+  power-domains:
+    maxItems: 1
+
   fsl,fifo-depth:
     $ref: /schemas/types.yaml#/definitions/uint32
     default: 64
@@ -101,6 +104,17 @@ unevaluatedProperties: false
 
 allOf:
   - $ref: dai-common.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: fsl,imx8qm-esai
+    then:
+      required:
+        - power-domains
+    else:
+      properties:
+        power-domains: false
 
 examples:
   - |
-- 
2.34.1



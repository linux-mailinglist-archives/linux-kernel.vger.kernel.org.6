Return-Path: <linux-kernel+bounces-436704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AE2E9E89BC
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 04:40:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37D4E280CC8
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 03:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB619155C8A;
	Mon,  9 Dec 2024 03:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="PAVGp8dy"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2053.outbound.protection.outlook.com [40.107.22.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FEAC1487DC;
	Mon,  9 Dec 2024 03:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733715596; cv=fail; b=fqDZXYAT3eCRvqzQ7fyoGOVXV6LNRPCXL7VmU4BLRV1XJBtHP/3ANt7YLn7aiUVR/UyqVO8avjHa+yPBpOnRrBm4HtwIBn7BfPqvK/2fQcw2/672+n+tqdCp7ACItsJfdx3limQMHebruWIJhOvsK8DU3VS9QVzNg0O+79vk2lg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733715596; c=relaxed/simple;
	bh=nJx5EVRSpC5pmdaMfPpYVoVttVHa6fTHXyxj37zQDcs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=J9qp8YpkagdKwHNBYms6g0X76EGFfar7Mjt8ahAvn1gfLTS7ZDjain9Z0A5XKLU9Xgw5xtQzL0s/BabkGokvdm7BDrcPS7yFXCyQexKcxIR4I/ckpay4xEILn5zL+mOsiCa0p22Vu3hn7SgW1VBHuAvkxd6kUP/SVxZYAgEIQ4w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=PAVGp8dy; arc=fail smtp.client-ip=40.107.22.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cis4FKdOZsZNeMJ3H837PXgnUpJ5Bqg+RewA3aM5H84D8PZ3bfGSG9fjz1Crwzvyysh1MI7DLWQLmhk1KuwPvkVMM8AZ6eu0wh3iYrLADv4ATApcvv1a5KZvLHogCcy6DO3GXXm1ZorzhEPFtnv1jsbHTy3V4+IodcNF7S4NlGu3qC6aDKvupplEiqSGHh/K2MA+RYX6YFJwoTebgLv2cVQ19czJR0Q+S+nUxr27L+TXPd+aO00FkJeCS+mK1nXTgOnfzFFUu3ja8GewxeFb1ON5wIFa9xACy1zY84xsOolkyGoLrtT/xGgZfkhpRe7sxzgXUcqxBmB7B8TjSryVIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HhTuTA/CfAhsx7pQ+ckjFvgD9mch/n4eRTFSH7/gJi8=;
 b=n/ytAK2xX97HCG215KsM/O+rr3ROOy/1qJ9uP3GGfDO/imhkDoYrTERwcA/vP1j0UzWKgOuKeRtyVPhhC/eqgb7QeP1gTLLLgmRoO4ACJjpKiXz9OeAfKuhdSYiv0b3S0NzG9iDc0Av31tC/Z7I75+Gs3o+8ZxOBg1bcyIEsV4jSUovceAH3bPf5WSThjBkUg/EPEN541cE+eiayg6e1oHnEPoxw0KRBILNmXAzOFCXzjRXbPwBWV6BOtp7CFjOBjiMg3ig24pQ7/KnHnheoLNvuIuugXLJhLfXmGffAVz30eDVU419Pq/9+LQ27+hbtOrvTiVm2DA+Yx5YdlECkVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HhTuTA/CfAhsx7pQ+ckjFvgD9mch/n4eRTFSH7/gJi8=;
 b=PAVGp8dyov6vRGQE4xSbEOItIxxFi5JiYvGgZgzGRt1RHjo4bXJuC4gis6p2mzRuXf5yreJgJDkj0P6nN2qaaKh9izRKg4vGRtKNeSA7P52jJ/AcjLAWjofGlwtln+H+1eYmdn10bDYodBO7FjsZXBqYtoJbU8Rr8SLKe39BwM6YrHhRe52J1piz+Ct59BVtHJ0+J9oaGYGTvX3YlowM5QzcjXBQEOJLSBCGrIq1nI6Crr5MZjD1fjfAf6FsudvlAf6SNVuCNrpWsnyTT18tvSyyL9rkmK7h/4am41IO4cDrnnCdlgMzbQNM91CSL4ASXThzD5zt8pXEgH+zxZEZug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by VI0PR04MB10212.eurprd04.prod.outlook.com (2603:10a6:800:243::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Mon, 9 Dec
 2024 03:39:51 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::d1ce:ea15:6648:6f90]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::d1ce:ea15:6648:6f90%6]) with mapi id 15.20.8230.016; Mon, 9 Dec 2024
 03:39:51 +0000
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
Subject: [PATCH v6 02/19] dt-bindings: display: imx: Add i.MX8qxp Display Controller blit engine
Date: Mon,  9 Dec 2024 11:39:06 +0800
Message-Id: <20241209033923.3009629-3-victor.liu@nxp.com>
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
X-MS-TrafficTypeDiagnostic: AM7PR04MB7046:EE_|VI0PR04MB10212:EE_
X-MS-Office365-Filtering-Correlation-Id: 59889d0d-8328-4672-c7c0-08dd18032376
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5mUscJvLDCVAH5QjeOp6+oQ98gDLLm9uUwWQcNEhWvCx2Gsm32TCymGdkATP?=
 =?us-ascii?Q?oGPdsOUA4OvVbKtd9ldWh6j3Z3gZeez14AvU1ZRjQSXRUA7Re0eA9lo0woMO?=
 =?us-ascii?Q?S5KjsUGkG8u4xXtqH+eTDi8C7Q88kmZSpxyEzSZKDc8NooP6aknbo0RXyRzU?=
 =?us-ascii?Q?PbFFXwEyU4q1ajVqFHuRRAqDQvFaOpxypBcSatRHEWIvXx0D9HESAX4r6zcW?=
 =?us-ascii?Q?dvNczf6D5lya2zmSLKu0qtaTQ+6LAeTo3iwsZHG2eHAB3JH8tXNOIdL1pUy9?=
 =?us-ascii?Q?0zJJvO6/rLnVju8/RYRTquPeLmMD7/9Orf6sV3FjCp73T7hX7zOvVU/0jOC7?=
 =?us-ascii?Q?0ekAsaTAOHs74PpBdgQJjVSzHLIq20GCgqX8WEDQ6AH8KgUA/CjDSaGjBdIF?=
 =?us-ascii?Q?zOZQdiqUyX951F5S726cGM2Q0oa17DJvrCzoI4RP9+2SysmtNqCKczIxJG/x?=
 =?us-ascii?Q?0XfInw9fNGMtVQpu1jQQLkWfpgyJAqLVEyW3FpW0XFc8EGcR46aJpbGVtWCH?=
 =?us-ascii?Q?2QUlwsJpGP8q5FVg8m9b8A+V6LyBKziP3xomFGF3xiwXy5t4IUGdG8Df6T83?=
 =?us-ascii?Q?Qp/9YpDOhqe1PNqwQYkO4nhHF3732z43bWy/Mjky7t17+mhaAJ8sqy/IcPqZ?=
 =?us-ascii?Q?60MB+duTce6FVXk4cCvAO5z3PoHL5gwkTbiCSqP3vZWjHS6XuXzq2uaOkX7Y?=
 =?us-ascii?Q?IG612JNWKSX/mm0PDeZKB8IO3cR0dBGgET1KdPO7z2eKI1yKn61HLUaXprIx?=
 =?us-ascii?Q?hw8qycJkMFU5lR0jueiq9VMZRRS5a36GngHsDmAgvZcP2KQU9IxlysQb5qQI?=
 =?us-ascii?Q?fG1HLovctxrb9IoHE9RZLnGPQpofll2x0aoDBZo5hvPpqVCzOc2gZOleLl9M?=
 =?us-ascii?Q?dVzpTzE0y2aiFyGIDyRCtmVRVAd5UfaEzYiEXI7/l2yV7ADO1/MfjFTItsR4?=
 =?us-ascii?Q?72MtLJdhlGANkTFypormtXRSHvUuItHgv/wU3UNiGGNqEsv5v0Yg2DGo6oLN?=
 =?us-ascii?Q?zzfDYFechk09Ac6tuuU9HVfPVTcIdcuvVSRozb27T/PqwKYS4q06MwtPwVQS?=
 =?us-ascii?Q?Oyvl5TAKqppyhf8fYzmJmB7nod0lWpuu6H3ZVXGUpyIlWSMtv6aXO3c7tWLd?=
 =?us-ascii?Q?7pkzRSnmfSXxTbWlSiVjodx53vWmMEou/kz6wIZdJZQwDVUGtcXS8BikaOi8?=
 =?us-ascii?Q?i9GqcKFSFsLpmMwgSqfN3YjxHP3lmrvsIkBy/bJwOQg2AeZpiriEp8Qa8U09?=
 =?us-ascii?Q?MZFpLzvDo3yfs4+JzXYkSMWGmvd+pBBO5JDeuyyz02rZaGL8qZ1wkvjhwS9W?=
 =?us-ascii?Q?ZvUFTBBRaQzi5YJE+TZgyDnDL8V/ex1cAMzdSmhGZh39CQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pRJt7GElwjbCZIkcRxuOXzTrEpd801X+mmHzAbn7pEGjn2Zt6S7NbUAIXSV9?=
 =?us-ascii?Q?2i8WJlxPJBddCP1+FmCCJ+x0Z0Kplz+xhcJzS16IByPKAmcIWHqDW9+yfewh?=
 =?us-ascii?Q?/jx5CaxjwZpbFubu56aP9e3BUm9dZVCoNsUlIAie2zzMe8UReqpanzmE6KX2?=
 =?us-ascii?Q?yD4thBnC+zhV/+j58t5qalxa9rm9+fDAi/j/GNGisDnHBVUfxK9z3i0nV9Zj?=
 =?us-ascii?Q?LO0fXsZ3MnnL7SCu0vXEAff80O6A50/+gCu3cdX7FejQl4DqR86F+4CoPV37?=
 =?us-ascii?Q?ekuZBNVO9TEqJPz8O+sddMJbtPZ9I4mm9OX7D5YLa/Oc8yj34drr/utRW5Sy?=
 =?us-ascii?Q?V6tCvrVSuYykcMgc8zgmR4dDRMhUqitL9uLFEvPz3h0zK78lmLfnwTfTZP2C?=
 =?us-ascii?Q?1mt25D6NauoEwr7kKQA+MCa0BoNI0dEfNMfm9/fAWxWcX38B+UqqPx8peTE5?=
 =?us-ascii?Q?v42u3n05SWDuqCsCfClEmjtwDbY674O8CZePzn7+qtF3S4RgrP/VqbfzMONy?=
 =?us-ascii?Q?KJph+l3fUMOA46ZbgziMIjWzIjAkPYx/sygsqK4JZOv5VQ4Dol/p4Yk0633X?=
 =?us-ascii?Q?HhK50D6c9+GRyxrChlcuhlHXmri7kcWD1vCtJXiPrqNo+rZGXeYxGmmxl5q1?=
 =?us-ascii?Q?ZiHuxb9M1BbIl9h9Ude4/o6HHVWleDeDdGRtT9LxIrqjwozClVwWo5XM3k3Q?=
 =?us-ascii?Q?1vo8VLkFfqUWLPgkJk2NUsbcrJq9slSxao817X4aQzkOAK9dppqM8g/V+FIq?=
 =?us-ascii?Q?DnuA2KJEJUIS99VDG3hy/IJBa4TT3L7vPzR9h5d6ZDxsxxsvS8YxprEz4gqM?=
 =?us-ascii?Q?yui8H/YKcfD8/wvOUELLbTXygFSD5XLQslBwmR4ahBoPDoPIZVpVXMmf6MOO?=
 =?us-ascii?Q?QtwkvPd/Tieo/q4rujjtGwUDRZHy8GEnwbDSnRYqFP09/kKale6Ncbe2hDiu?=
 =?us-ascii?Q?Y6O/5IUB4MHOvp8S3aP1T0oz5GWAM+q+Zfpfgpz+P2MhrO613dHImD+8pzNE?=
 =?us-ascii?Q?KaulBvb2t3gD0/cK3R48D4HVcf3G+AF7lgW3dgMKcIkmmBVAQC5C+bOwI8LS?=
 =?us-ascii?Q?K5RolOqjj5gl6k/ly5Xr8JSFY1MYBL6o2g6xwa1Yb32lWwCelBe18kS2kmfr?=
 =?us-ascii?Q?KGSqZHEkOuYSE+I+L41uncw3zQih1+Bcpl9oNTfjNK7j05M292oo5BTQkkrw?=
 =?us-ascii?Q?rjs1osIIiHF+RjCs+2EavL3ok+OKvo3uKkCnlmislEK3senhJPd3dcRR2YmM?=
 =?us-ascii?Q?4J5gd5pM5xtHgIEVq2jET5YM27CdmqdgF9vK3K9onjKiSniaI8tUFI82QJB4?=
 =?us-ascii?Q?rOpHOmKATB1pd4bDqG3NS8gOcZ3VVfEfrmXUvfWfY67BYIz+CQJfCIaPeJVy?=
 =?us-ascii?Q?scQXFOvH1dq6OY2B2FdTInhNyIUzfUT161nWPTTOU6Mntp9MPQ8td4+POno/?=
 =?us-ascii?Q?dhyrPyID21FR3rrviEwARYS+xgs4ECPWwyf19xpUwjvqmDL7gw2UIne8KGmd?=
 =?us-ascii?Q?SxaaWCs4Hp/804nq0EFl3F6ObjqMqWQXVh12L+iENpPF83OUz4kHnGl7lAqU?=
 =?us-ascii?Q?25/rBZ6+FeMGKP/Twab9MWkYYf6WKLUPgX6vYVBM?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59889d0d-8328-4672-c7c0-08dd18032376
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 03:39:51.7399
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MZTQbS1/IKS7C3Ai42jpCzVGe4bAQputQTHtUHlQXRG9YC8hZszCMkAfBLzVKuHmL46oWqfG3bbeymn9Khb7Vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10212

i.MX8qxp Display Controller contains a blit engine for raster graphics.
It may read up to 3 source images from memory and computes one destination
image from it, which is written back to memory.

Signed-off-by: Liu Ying <victor.liu@nxp.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
v6:
* No change.

v5:
* No change.

v4:
* Collect Rob's R-b tag.

v3:
* New patch. (Rob)

 .../imx/fsl,imx8qxp-dc-blit-engine.yaml       | 204 ++++++++++++++++++
 1 file changed, 204 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dc-blit-engine.yaml

diff --git a/Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dc-blit-engine.yaml b/Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dc-blit-engine.yaml
new file mode 100644
index 000000000000..45db6da39e20
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dc-blit-engine.yaml
@@ -0,0 +1,204 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/imx/fsl,imx8qxp-dc-blit-engine.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale i.MX8qxp Display Controller Blit Engine
+
+description: |
+  A blit operation (block based image transfer) reads up to 3 source images
+  from memory and computes one destination image from it, which is written
+  back to memory. The following basic operations are supported:
+
+  * Buffer Fill
+    Fills a buffer with constant color
+
+  * Buffer Copy
+    Copies one source to a destination buffer.
+
+  * Image Blend
+    Combines two source images by a blending equation and writes result to
+    destination (which can be one of the sources).
+
+  * Image Rop2/3
+    Combines up to three source images by a logical equation (raster operation)
+    and writes result to destination (which can be one of the sources).
+
+  * Image Flip
+    Mirrors the source image in horizontal and/or vertical direction.
+
+  * Format Convert
+    Convert between the supported color and buffer formats.
+
+  * Color Transform
+    Modify colors by linear or non-linear transformations.
+
+  * Image Scale
+    Changes size of the source image.
+
+  * Image Rotate
+    Rotates the source image by any angle.
+
+  * Image Filter
+    Performs an FIR filter operation on the source image.
+
+  * Image Warp
+    Performs a re-sampling of the source image with any pattern. The sample
+    point positions are read from a compressed coordinate buffer.
+
+  * Buffer Pack
+    Writes an image with color components stored in up to three different
+    buffers (planar formats) into a single buffer (packed format).
+
+  * Chroma Resample
+    Converts between different YUV formats that differ in chroma sampling rate
+    (4:4:4, 4:2:2, 4:2:0).
+
+maintainers:
+  - Liu Ying <victor.liu@nxp.com>
+
+properties:
+  compatible:
+    const: fsl,imx8qxp-dc-blit-engine
+
+  reg:
+    maxItems: 2
+
+  reg-names:
+    items:
+      - const: pec
+      - const: cfg
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 1
+
+  ranges: true
+
+patternProperties:
+  "^blitblend@[0-9a-f]+$":
+    type: object
+    additionalProperties: true
+
+    properties:
+      compatible:
+        const: fsl,imx8qxp-dc-blitblend
+
+  "^clut@[0-9a-f]+$":
+    type: object
+    additionalProperties: true
+
+    properties:
+      compatible:
+        const: fsl,imx8qxp-dc-clut
+
+  "^fetchdecode@[0-9a-f]+$":
+    type: object
+    additionalProperties: true
+
+    properties:
+      compatible:
+        const: fsl,imx8qxp-dc-fetchdecode
+
+  "^fetcheco@[0-9a-f]+$":
+    type: object
+    additionalProperties: true
+
+    properties:
+      compatible:
+        const: fsl,imx8qxp-dc-fetcheco
+
+  "^fetchwarp@[0-9a-f]+$":
+    type: object
+    additionalProperties: true
+
+    properties:
+      compatible:
+        const: fsl,imx8qxp-dc-fetchwarp
+
+  "^filter@[0-9a-f]+$":
+    type: object
+    additionalProperties: true
+
+    properties:
+      compatible:
+        const: fsl,imx8qxp-dc-filter
+
+  "^hscaler@[0-9a-f]+$":
+    type: object
+    additionalProperties: true
+
+    properties:
+      compatible:
+        const: fsl,imx8qxp-dc-hscaler
+
+  "^matrix@[0-9a-f]+$":
+    type: object
+    additionalProperties: true
+
+    properties:
+      compatible:
+        const: fsl,imx8qxp-dc-matrix
+
+  "^rop@[0-9a-f]+$":
+    type: object
+    additionalProperties: true
+
+    properties:
+      compatible:
+        const: fsl,imx8qxp-dc-rop
+
+  "^store@[0-9a-f]+$":
+    type: object
+    additionalProperties: true
+
+    properties:
+      compatible:
+        const: fsl,imx8qxp-dc-store
+
+  "^vscaler@[0-9a-f]+$":
+    type: object
+    additionalProperties: true
+
+    properties:
+      compatible:
+        const: fsl,imx8qxp-dc-vscaler
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - "#address-cells"
+  - "#size-cells"
+  - ranges
+
+additionalProperties: false
+
+examples:
+  - |
+    blit-engine@56180820 {
+        compatible = "fsl,imx8qxp-dc-blit-engine";
+        reg = <0x56180820 0x13c>, <0x56181000 0x3400>;
+        reg-names = "pec", "cfg";
+        #address-cells = <1>;
+        #size-cells = <1>;
+        ranges;
+
+        fetchdecode@56180820 {
+            compatible = "fsl,imx8qxp-dc-fetchdecode";
+            reg = <0x56180820 0x10>, <0x56181000 0x404>;
+            reg-names = "pec", "cfg";
+        };
+
+        store@56180940 {
+            compatible = "fsl,imx8qxp-dc-store";
+            reg = <0x56180940 0x1c>, <0x56184000 0x5c>;
+            reg-names = "pec", "cfg";
+            interrupt-parent = <&dc0_intc>;
+            interrupts = <0>, <1>, <2>;
+            interrupt-names = "shdload", "framecomplete", "seqcomplete";
+        };
+    };
-- 
2.34.1



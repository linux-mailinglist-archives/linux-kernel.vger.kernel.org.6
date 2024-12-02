Return-Path: <linux-kernel+bounces-426824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 814899DF921
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 03:56:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C6DE162984
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 02:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EAA32BAEF;
	Mon,  2 Dec 2024 02:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="b8+8jj+M"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2072.outbound.protection.outlook.com [40.107.247.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30CF12AF10;
	Mon,  2 Dec 2024 02:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733108206; cv=fail; b=nQVelmFmI1tXx3oggWCNLXNbexuG+mQy0Zmsk6PzWSPEoDOmzSnALsoVmtMPepcs++BLoeo9YYV56s6aigv1tmOY/hFG0mEztP78nDZ9bxbM9LB2HK3PRUcMBuNCTjVrjUzp5OtxgpYa5GmP7NqpbaJ43BhgJuzG1wWu6bIP6OU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733108206; c=relaxed/simple;
	bh=U9UHmw9eYCLFJK0Zf8Zn35Yp4yCighlv2Nuve0wOpNs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AXf68Hl6cxY80ax4Y4Ft7GRI+9qhAA2fGTvsHyxmg+5LI9GrFPHxT8cb1AdGMFalSmGQ6WpI5nCYRn+LgrF5BsGPEDAkifOn2wFI7oQx6US9GLbsuLsZztmTJYpDFaYcIKs+guICjEaaPODPXl33VjaDmJS1/3rYubBxvCqXOzE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=b8+8jj+M; arc=fail smtp.client-ip=40.107.247.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sHMVEhQAFoDNgsFh+03ymhjnVjnjx/GAHklVB1n0/14AvUGzk92xrxELvXQUfp/yJEUMbUKxVgpvnCrNxX29T8klQOU/QyrKRk/BANhUy7hIzVzFWORbxR6WQhwKevQIjte6knPj+EMXwfHr9hsRuaVghC7KdjTqJ0rt5+4WPx75c7z8cIyHhTGvEeXZCzajmlArOCqMAzpMf3+ltXpoixGNr2I9DRmJ5+Ioid9GNRaM8ajY5ylvRwPnOCY6+lcCPrNXGZdPgqSBFatBzWH1337VYz7bwMjfo4vGCJ7NLE5C+7JHQFuoy5ZJ1d3i/t7GjoeAawigKtI/z5hTCPKfSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v8rdLYlsISRXjMhXguHypg1GnRFtRZ5/eKFl3surBVM=;
 b=bLFWW/2r4ugUcq7K2T75oEqw0awyqxT5oTKPZwNUXskAKxYDruypPe1cTabVeKgW08nbeD3tGRmGgZPBZvvpVkmo6sBBqiBdOEtUu4J0BeQJGnDWnyK67Hr2hSacMsJoJLnIuetARzLlF/eKAn9TmdjnojAlVXmA6MR/E6nPXxY8sSnFctmJc0OiX0on7MYy1FeMITzcYinKoNWoZaWoA3VVVt9jMOAK2GLNVwAUcZ3gIGwRPkLl3rwcaJ5jr/Zqn53gqRKoMrm6X6DKFQTqhPeseGWQcd+UfUQ4h9uaujTO0eUi2DK8yKtRWtxTtjjKRQE44mcnxGh4JGIS7M4vaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v8rdLYlsISRXjMhXguHypg1GnRFtRZ5/eKFl3surBVM=;
 b=b8+8jj+MNSSIcV4UIn4yn+40BNKX7H3w3V6tvtYls8uPoI/HEOgGsNLXef0eoG3VBlNFRPdIUBGNy/Z2sLjTYvTNykw4zEY/d2exugOXhtPgPYqQ/O9dFoFD9yRCp+4gZM1uiEKYH8+e+Ec9pTtZ3KqRTNBeM3uFDixIlk1RGzG7OkjWu/PldIDO6lymt9H9guYoP/nyfgasgclKL5sgBp3pSGhputydewYYmsj+5VD0P6Ej5cojTiwN3g0z4lSK6R2JEXLTArFvy/9fCD9pggd6nu/Um98Y3wQlyK0C6Oimkou4zG1WbmJ7Mpr1dOSQ6GbUBKwdJqg4Od0Gts3Z2g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by PA4PR04MB9318.eurprd04.prod.outlook.com (2603:10a6:102:2a5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.17; Mon, 2 Dec
 2024 02:56:41 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::d1ce:ea15:6648:6f90]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::d1ce:ea15:6648:6f90%6]) with mapi id 15.20.8207.017; Mon, 2 Dec 2024
 02:56:41 +0000
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
	glx@linutronix.de,
	vkoul@kernel.org,
	kishon@kernel.org,
	aisheng.dong@nxp.com,
	agx@sigxcpu.org,
	francesco@dolcini.it,
	frank.li@nxp.com,
	dmitry.baryshkov@linaro.org,
	u.kleine-koenig@baylibre.com
Subject: [PATCH v5 02/19] dt-bindings: display: imx: Add i.MX8qxp Display Controller blit engine
Date: Mon,  2 Dec 2024 10:56:18 +0800
Message-Id: <20241202025635.1274467-3-victor.liu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241202025635.1274467-1-victor.liu@nxp.com>
References: <20241202025635.1274467-1-victor.liu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0005.apcprd06.prod.outlook.com
 (2603:1096:4:186::12) To AM7PR04MB7046.eurprd04.prod.outlook.com
 (2603:10a6:20b:113::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR04MB7046:EE_|PA4PR04MB9318:EE_
X-MS-Office365-Filtering-Correlation-Id: 58c0f405-c214-4173-466b-08dd127cf2a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KDmNJd5d4UifPicWVGBOPZK5mkZu16tNPYLMUtdjmoGbiGWqfQhqR5ogLTZX?=
 =?us-ascii?Q?9I+Pvd9aoq9lnrIebWeXYGlZ50KNuOc0PfOuaw8oIf1s91nhhZ4W0mOy4ttP?=
 =?us-ascii?Q?hl97FZ9cd6cY03Yifx9uFeQPo8JxbkzflMGhl5VxZOt+7218gHOEbezLBhGE?=
 =?us-ascii?Q?nvgjVNL5wvDgoKiGjsHVd9HO03qFCIKgl6nvPrKeQ7QzDEc++7SuMvnPngg6?=
 =?us-ascii?Q?AyiEph5g8VFKNf8lgN1SMikw8Smq9zzpnKjmdb0a4GvWZWFNrVx3XnwEtyeU?=
 =?us-ascii?Q?qjYnCob6IiSW0gx/pLObOXbozuA50eXqMeuRod+zO7VB5pofCpHYIFRwNxwL?=
 =?us-ascii?Q?i8Pe70s3WQaizTsZTzyBm7XCd2uSzzRk4BeNEjBio01Ll9o/81PGs0qpKyvB?=
 =?us-ascii?Q?UbO+xfKpxSiEXBtOyPje6DPlmxDIF7rMAFeR4rtNBNGZTcpD094Eaetef8Rd?=
 =?us-ascii?Q?53pY/prCWMixpreYaMMg2MvjsroXYVKx7NQoqpbyNhkDrsW5/sQOaq+daqFO?=
 =?us-ascii?Q?2otQCzyGgn7xmSv+5w38S+4Z7f7wYAmigNV6U4JAcDozHMAja0j3HH/4w6v8?=
 =?us-ascii?Q?lGctXyFQU6VYFx/mtsaF5nJ0Dwav1OsqcVUECT9fcIwDE9I0uiaGO3jtAIZg?=
 =?us-ascii?Q?CjTUccJQtWBTQac59yegw2S01SIf1/fDGAnMFP/sQ+KpGiQRc8442cvWvU3V?=
 =?us-ascii?Q?Bqe+aNqgcX5iHq9PgeE5vTIvbGRuVGHsrVlodID8xdgfw7wnhV8WIT57ykD2?=
 =?us-ascii?Q?m8d1U9kSVvDtf2KGYB+RYk2E7ODVPd4YzNcRnvhzKwYLNcsL3jKYTLAokoKv?=
 =?us-ascii?Q?USoWmZvEy+RfHq1nJs8IBccGylnm9M+a/UX3779kiEo0nhrc5qPrcYNCfQMz?=
 =?us-ascii?Q?iZrXxUFsuB69j/VR/nuLpYPTIL+WplGLOmCLQkZjUZDYyd1xWf9HPHuwZq2E?=
 =?us-ascii?Q?TqoBXphiNRYzLvaQBGeU1uFa5hyQ2PLdSkXRy3TUxTg2/lJ0CUWSqjhvBpCn?=
 =?us-ascii?Q?4IOV/AZWJPOqcwL2RGbVNEYvRCye1S7XVG4iGu/o6zdoPSIbx0QlwwiuT9hg?=
 =?us-ascii?Q?4BWKVaMyG14q2ExxQOyFnnnJxK597rv4ZMgkrcWdrNMTI1CB7kNaZF+n4xqI?=
 =?us-ascii?Q?GXIZ2N2P3MXUT2VmZin+dlwRempCfe2ptjmBhWD2rkQsZtfLiVEGHl0z6Gnq?=
 =?us-ascii?Q?ogemLw3gyqHHwcq58XhGVu4MpuxvKZYfCoadroTDBA8RfynuZDFvtpvpwe4A?=
 =?us-ascii?Q?nEoOAMRprPej3RJNxfCd+p0kBnAGDQBU80awHjwey9qrOlSXbKur35rRvYSD?=
 =?us-ascii?Q?wu6SxwROGFYJoKaIFjd7LihCd0SrUbjLuxREFOnh+fRMGw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lHhk52u9985XobOK06zAt45noMuw2XyZGBptDCU+RhKtq/cR3Lnh7laWme8h?=
 =?us-ascii?Q?GVozr7D7HMUgA8LK+QGHU+hMp63o3mldtl9zj0L6Y9FCK7bMODjoWBJ6SKmc?=
 =?us-ascii?Q?pRmTFmDCD10u4RV6Xj7HcEdXWmU8WgrHf2LOk+HuHNuHC4ELS4TO7dRLdvho?=
 =?us-ascii?Q?yAT1AdgSJw30TAVeIMx7KRkzB/Kth29OO/o6aTHzjwkcNK0UNPlbJWGoQTs4?=
 =?us-ascii?Q?PJBDXr5EqhCcHDAe2puja5FkXaXSzRxE1HJQfFEQcAAr4Fv8/BvNIboWUQ44?=
 =?us-ascii?Q?aaWGvyPK54rBLC37mGHRk+gu2kPSefrZ6ccxCJIEWXNKxmS/UXGYIbngYQKm?=
 =?us-ascii?Q?an29SDY1xzG1oXX35onLm5LK5LtujYP+3m3sDeH8BtjKj7QLi6x/8b/ia+k8?=
 =?us-ascii?Q?x8FCfbbqXBEUd7D1iATKPz0Y4nLEWyGaTBYRTPep4jRUIBJn9QejNpcC3IR2?=
 =?us-ascii?Q?HJgfDhCnr/58OW5n5En3S7OeMPXAhOiMmiEWw3HVlTjDDQOxfSs86caoSuvh?=
 =?us-ascii?Q?agfXztCUJMNLs0i352jnf5a3ApxKxg+95Ht0FFfOX8R2GSlDuErvJ8D/AGG5?=
 =?us-ascii?Q?eoDT39NE82FyIEKIXN/iv4TAmNKg+55nffiSnn28GA5MvX50SN5aqClDMbxz?=
 =?us-ascii?Q?bGyv3+qLIsXaZSyzSNQfjmEShIvlvkN6+fS80q+xP1Ve+LjUHQ0X2ies5J29?=
 =?us-ascii?Q?Tfzbl79gL/QFmkGWkzVuMlMua+P1StvCx6NGLNttgWUUuU1SsAwyt9EwjRta?=
 =?us-ascii?Q?oq//LF5eqyljgjtGBInapq2vZ7wXI+oxfEtSgEShQmkEjHYRCBChqoJLOFbi?=
 =?us-ascii?Q?t6qBGFidPtTpRCfCOy6S4MQ5jX3eQG1p4WlJUmT4iiMLD+HhlfckH+CKiUvh?=
 =?us-ascii?Q?BoFK81EhTPYGFirKboGXsAkJTjncz7m3YRLZqW8Iayc6mq8RgzQCXNWeTfHY?=
 =?us-ascii?Q?DZJuMXchDFC8c0L3YRdTDSlN+MYX+gsFdrCxi8eB98Ujvij+f+vf5EwI+AEx?=
 =?us-ascii?Q?eqHYDDFdmd9ErcOIUtwIltDoaPTJLzU+2HpwoQqnn/efB0LZ3CKiFhL6oLSk?=
 =?us-ascii?Q?4Ld+tsuTyYj3C2sniTUAjJwLeu2fX7loBoN6TmV1SFNQoR/f3FeKPpFUYgcW?=
 =?us-ascii?Q?MLGg24lxaDoMJFh/isaqw3Jyy6A/T2H3pUf0ShVEyAJmjoX092zM9iGFu8mZ?=
 =?us-ascii?Q?qNo2prVCPKtdU7hq79GCCVPIFPTwLNl6Q3fnAMF0V50FpAfLOVEq0vm03qaP?=
 =?us-ascii?Q?Lv8EpfmiENa3fAQ6uSYiSH4KBoYzlze72MSSRF86kgZa4AZt/1nGrg5uIkM2?=
 =?us-ascii?Q?yueVeaHy9n9pKWoadGUSmuTEH2werPN4NSNhkQ4sCs0nngD0Y9tvEpI3TC3v?=
 =?us-ascii?Q?aBgJI1YIcdXE/PHbXM8lQs5M+e7v6JHJakmO9raUk5NkrMv+TioO6nbnKqoo?=
 =?us-ascii?Q?iexNexd7MrEAJNA2WC23VhTUP3QjCTCMPBFNlNaZyMRE+Wy0gYO5yVDT/j6X?=
 =?us-ascii?Q?qfKXciz5CaDaeup7U/D+N7SQXgxIABEmhxzhBlzTiBQpIeNbE+9GW1O4uiAn?=
 =?us-ascii?Q?0r68gQiOXbeg5qs6PxJYCv3DQuPC/m1/pON31SAJ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58c0f405-c214-4173-466b-08dd127cf2a9
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 02:56:41.4893
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UYLnsJ7CeMPMfDrwEKilYXzC+IWE0KYBiCvUthwjcCmlZmSfCLriVMUKdwz1KfdXaiGUnB6InnH9bovyAJUJgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9318

i.MX8qxp Display Controller contains a blit engine for raster graphics.
It may read up to 3 source images from memory and computes one destination
image from it, which is written back to memory.

Signed-off-by: Liu Ying <victor.liu@nxp.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
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



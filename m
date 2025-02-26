Return-Path: <linux-kernel+bounces-533483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC480A45B2F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 11:06:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D03623ABE2D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 10:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C555724DFEC;
	Wed, 26 Feb 2025 10:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="L9DGSYH7"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2081.outbound.protection.outlook.com [40.107.20.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C782459D3;
	Wed, 26 Feb 2025 10:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740564381; cv=fail; b=DdKP/VBs+DHl8pWEnhUSbtIyY2lNHX7Mm24LFg8u5Lbgm2P248Q7NwK9wKyV9Yxvp9a980kMWvxbQGrjWipYB9nfbASJ9U/gmlIJuZfrZTbcUAXH+R9jHEOo+oZDUvp2QgjT2h9GY5OHeUQ5O/9QJOdW7JZAS3oxgXBDzvDpKAI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740564381; c=relaxed/simple;
	bh=wTz/KcKzhX774tvq6AamwubWxtCnuiV/KIBkRfEUPvA=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ncSmcXwJA6BKTZk8Q4XX/2HcRJcMdDQNQpGCku8Ckx7a3ASVpJOBu5N1P9lV0LGd3ZEK0a4DoYnZJWpgsII6Abmr54/BIckr3k9OP+Sy+9iuar2ulIpZNADjvlnR6h8qY4kbySW3aBs64wZq/3KmuRj8KFBKrVUApK7ABd6cQas=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=L9DGSYH7; arc=fail smtp.client-ip=40.107.20.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Usqr1AQ+ipKQ51EC5prw00esjmjSQCIBGlfRVBtnCDXSNa4L2u1mLwv5kRktTjHY4W/2+0UibEvkZaoD0rTgBL9iEwQUjSjpwN3/JUY1+TSEO4AUMpBcXPlxlSaaxPfpKay1fSVAKciLjGDhYSniEVrSXVKTVKJuDGnDThxptMEvx0slDocxd+9Ut8Tc7Qv2jNNUgDD25tZ20kHgWTFBw4Tw0VRUSyUGwNwITM54IxHkoXO7882O+hSs4MWgX3alqnXp+uFfy0bEqPGBC0HU7wMV3UVA72CHnb5BzjcZZCfw/if0aFrKXCap8phpDjK+kk8C/O5cVjpIhZcDh8TSZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NbDSAZ8oeYz7WtS0T/jXbbVyN3+Ph8IGVUmtEVvLUwk=;
 b=Ypgz3XoVcqnccUL/uOhPiIQiSnkXciI3x42JO9EIDDoqPcrWzjVK+lef/+YZoFz6o4hS3zLH2TMjNgeEGsIB/N9BzjBF0zuGpRPsk9G3vcsj7aVL0lh6g+6MfFpN9O1kvUvqPQe1z+MfgCUKeCr3Yx35OhE0NPzO1tl/vwBzfXxMR3ZfbP6GW9TmOJJuAPzvUr0bxw4vAUD2lnlCQHIMii03vrbVMMPfbESSkjdPNcLrKrB6mOZcvBNTd0k0rOEBHP7VYUgbfPxskCGALlGHyW1OxvqcvD7RKsUI7t5PMmjqoK3NBppk6av5WzpU6eYvljgImxuycTeEUUECXY6xPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NbDSAZ8oeYz7WtS0T/jXbbVyN3+Ph8IGVUmtEVvLUwk=;
 b=L9DGSYH7YS1Kdar7N+LodUziLqphtKEobb3JSSig62rcjjSElrvUrWTXX6nje2y+3VVoQTNj+0gcj1BV4LhabKjarcGMCw0kKDNJiBhrP+RSZ3Xf4XlhnBrO8m35dm3cV/y2dh+iakopdWaC8V8gHBWDjfJg29wNAvmEQr5O5Su6shyTaG7i5cjuFnSamYKzbyaj/oHorVVFx6Tl9Qpqeo3TB+Xf4qum9ICxOXftLADj3hhAeKRno6jINuXwQydHTMJTe08qW95OZExoEPv1UFBJ7rNlIaFVBncH2iwiVLJm7F0/ZCyU7iswCq8p9xyxvXpgwO1NleNKie7jcVe2Yg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com (2603:10a6:208:191::20)
 by DUZPR04MB9946.eurprd04.prod.outlook.com (2603:10a6:10:4db::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Wed, 26 Feb
 2025 10:06:16 +0000
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::7be0:296:768c:e891]) by AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::7be0:296:768c:e891%3]) with mapi id 15.20.8489.018; Wed, 26 Feb 2025
 10:06:16 +0000
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: shengjiu.wang@gmail.com,
	Xiubo.Lee@gmail.com,
	festevam@gmail.com,
	nicoleotsuka@gmail.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH 1/4] ASoC: dt-bindings: fsl,sai: Document audio graph port
Date: Wed, 26 Feb 2025 18:05:05 +0800
Message-Id: <20250226100508.2352568-2-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250226100508.2352568-1-shengjiu.wang@nxp.com>
References: <20250226100508.2352568-1-shengjiu.wang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0233.apcprd06.prod.outlook.com
 (2603:1096:4:ac::17) To AM0PR04MB7044.eurprd04.prod.outlook.com
 (2603:10a6:208:191::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB7044:EE_|DUZPR04MB9946:EE_
X-MS-Office365-Filtering-Correlation-Id: d44ae4a3-1636-492b-1cfc-08dd564d357b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|7416014|366016|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0WiffHYCQ/xosKM3OrOEp77fNK2zMFHQQ1jNxUwmPaNJPue1/Jp6+LpDcbsC?=
 =?us-ascii?Q?BKu6IcUxPN0eGU981USZn8s5QQNFxXquXdysbskPxhMTEl2kWtAtbFn6cJSU?=
 =?us-ascii?Q?ZkmBDFA8a+CJfeE+Rj7jbr0Xa/88x/xS4Gh8ai1XN5Xe3RbX2zvXRciOa/wS?=
 =?us-ascii?Q?+jcRxSftesnXKpRRrhVDf/GeVpsMslBzyCah/7NELIbjWNklCI6qHLb4cIGi?=
 =?us-ascii?Q?I3/AqQqKAm0wLvO8/y3+IoHQTa/EpaCJDbyMppQKnwVKSDydGfZB0PGZPr5I?=
 =?us-ascii?Q?Rmxe+T7PCLOunwXpHw2m3yEqJEyzR8OTyn5sahzvMgtXZtTDEbRRTaMvdTaE?=
 =?us-ascii?Q?VG7n9kMxoplL89VOPgdR3C5+JCxolv8u6ZQfqLrB+zQbmKXxW4hLDVbjSlLd?=
 =?us-ascii?Q?+HFfEketE+/z5ewsm22lzdUgCeU/p2Ddlqe3LXojKP3zpu5/21vXBTqGyiGM?=
 =?us-ascii?Q?mpF5xVYRvrCYdZNt3GLGVVB52En3xuxLCiU3igfjJ74VdPjqv0EdHNR3Lazj?=
 =?us-ascii?Q?9Sy2eccJKY4Q9eKYiUVifVUqO17BjzXLOuvLZjB8xY8YZU+PHamGnRv494oy?=
 =?us-ascii?Q?2CEdpCDBUiJJd+KyQNoAhdhXM3hXDPj3n9wBDSqANsqnatcNvA9+Rpy8ksUU?=
 =?us-ascii?Q?+4Pd6QFGzsmB3qlDN8sbK0gVlUW8aj6GDqbLgB61gCahuci5cYXsrTc+a+Ch?=
 =?us-ascii?Q?qu+jT4zn2RmHCYLV5rIyUogSZ6J53N8SbhvoWtBdWhZnnBqMfLPjM7scAqe3?=
 =?us-ascii?Q?lIbqcWqDOZ3paDE4EAObMPohzUGFOQ8nw6nD0cNqk13/HU6FsHAwOYhAXSRj?=
 =?us-ascii?Q?TzZt47P/AjyL3RPSYHD2nUc9+KyA86qFtlROGi2yvW7YTN1oRQpPy3b7BurS?=
 =?us-ascii?Q?W+sUCciiPSLJkoT01oeRGKR0GQtmJti8mxMUukr3G9dpRxPS9BkCgmxebx1u?=
 =?us-ascii?Q?Nq0JL3DuhfApIGcerrUPObp0TpQ9lbEd/RR+wtgXdcNswAlYE/4YzjEW01b5?=
 =?us-ascii?Q?kDfEqWJj9WFlKlHbwlAu60D1J7HhCObOFRs6gYWFyi2shZtsi1bZqntm2S7n?=
 =?us-ascii?Q?yMmXb4aDxVvsYtaHNIx6K+LudEreC+akHgNn3CWRMogcY5Y7m+7btuSlZddv?=
 =?us-ascii?Q?rhDT49YPoJuDoSrEAAFugIurjp0A5UA0h1JUgjJDDusE46HAxwJfutWz6ZMc?=
 =?us-ascii?Q?2TtD0FpbWukVMbu7/dzZPVeTwicwurxbaIwR6vU/dKhdsYkCnn9AOxneTT1s?=
 =?us-ascii?Q?LVrHdfOMgehhsG6KZ2RMqRRtLXdAcfuer3BA5KQ8x/YXF2c6937yC4MChXKa?=
 =?us-ascii?Q?imNmawfvkwWwBIcXlLasmTmJJtE8TrjDmKrWfXgXPg0LpCWTu4wm0nbMU91I?=
 =?us-ascii?Q?bE7o3dZkRTO4k1znYjacYwpN6mJCWRYMazhdfdqCqOukZ5cz01QGjhv1R5mh?=
 =?us-ascii?Q?0S5LWW64FIgiiUR3JIbHSswiRBfRGHLaxziPB4aUFhLpm0RbNtE0nA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB7044.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(366016)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bC/zi86T6AQgAzHjqrJNx57//cHgKoilkeDDctQa5SqBkaURQLDBpNYzjqBW?=
 =?us-ascii?Q?3sXvtj10IYj74lvWG/FYTuh0IWfCnwQSFRcUaO3VPOW9MfbreZOkcqIM3LQu?=
 =?us-ascii?Q?eqxCOnCkQphpiJ5RC3bZZB3FV8SX816fV6vF3uFhXQMTcGtCm5BCpZeHEif3?=
 =?us-ascii?Q?c7uYi5icqYi5SDOm3hNV55AVsa2HUC07ecnOQwN5UUt5+0XKQmjORHm0eWpU?=
 =?us-ascii?Q?2gDVQCIcN6BPpJBxJ8832H+lAn+NPRz3gs96TW64B3aNOS/L3G3sy+S+rhq5?=
 =?us-ascii?Q?G+3quBojdjVeVZ0KoilBb68Ykng/ONOuDbUg9XfhkUunOdRtqLNWscrWickw?=
 =?us-ascii?Q?zLBm8FipLnc24hmyXmHvfVZiUQuNmDetQemKMBfAIrdx1D3NsdAI/f9IhgG8?=
 =?us-ascii?Q?Yjh3G69KosNlAcoeB0U1DD1oJpOOutLkkNemmVcUJ6xGJ4e9ULZnZPYA58on?=
 =?us-ascii?Q?LdLOP8ETOa/k/a7Xrw9fSFhY2DCaT7B3kz3++HOgAX4XwWnfIvaQm5+pjbfl?=
 =?us-ascii?Q?a+XGller+H9fZjw/me2daOtTWJGO6GsvNypiNhl6nAlLnNqYI5Ua4sA66JTZ?=
 =?us-ascii?Q?wP8l/GlLnt0w5ZJ2AXIG63cGB/YSnxRk14G3uydFT2PVsEGLTvsOkIv3uOFz?=
 =?us-ascii?Q?fHK/2ZWF3AmNrUnqXZXNUH2KBGe2VWRhmvrxwj1/CgeP1K74luz2EokACz3i?=
 =?us-ascii?Q?CQ1AhsS+FHdOUul1icbD2JzbQGZyJdprIlSEZND6usKbr+8uQx8kMwfRUpBr?=
 =?us-ascii?Q?2b8XeJ6iyJpI2C+4gXPciykkjAzHTw7yX6sYvRu32g9XdeljGYkXKWcNPWu1?=
 =?us-ascii?Q?DjEJ1QEps2RDKkW98PI+ADJZACnhW9MxuNMXzyC3aNm6DeFZlcYnnPonzecF?=
 =?us-ascii?Q?lLVP0GobfNQTz8bMArY87LDGxxrNVppaEc8p0AXDj64jv+2sNxrrE4wWjMnO?=
 =?us-ascii?Q?b3qsTebOpNmHt67XdrTfJuCeqd0IGYC4j8Ryv1cjGsSFtr+yx+P/y9kiIiOH?=
 =?us-ascii?Q?fJ5PO/9HY8c+ug9St/YSCo+nHE/KfRkWS5axrya/U0MzeQYXiryVaRv9AE5U?=
 =?us-ascii?Q?Sb0OC58cwLW/tFEODw1vOPsvtx42dVA8g1qlTfVbx3eXwKY8TZI5Gv9Ezvf1?=
 =?us-ascii?Q?BRy7ckIIT6aAGEIRMfRRqGvl3rhpwx3qURWNVQ8mRqzAJabzmIp0DRU/FRdA?=
 =?us-ascii?Q?G4E5XvKJhf1vcIk6Fia7mUsWs59aZ9uofrwY7ic+trquyyAnhynmj9swqJQg?=
 =?us-ascii?Q?JZwP5XOOSl1IQJSNG24HKhG8Wc9adpLsgzsf+yBc8aEq2GqNi3HRH20DimIc?=
 =?us-ascii?Q?dgzfoV1CMIMdnkqsZYzlsgcJ6pjLdhty2j2MPrrJpQuMYXufr89S8IdOr5Kw?=
 =?us-ascii?Q?rvw8yxvbJt5Y24e7mHun5IWgcFNAaxzKuRww9w7mpy0qmwshK7g23eWhaAPC?=
 =?us-ascii?Q?zMrViOSgaIjO5BFg7tybO2XdiPUPEF7Vg9FnXBxhynBMMfB/jI5cz2pPp2k9?=
 =?us-ascii?Q?oUVnwkdYu2MU8dltLF6oebrexP43OWIDUd++0jPWp9nnoXoEN5TzUixsNdGs?=
 =?us-ascii?Q?icecktjSUnCmbNvg9+CHrW1mOTp0NZbxxz1X+EKJ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d44ae4a3-1636-492b-1cfc-08dd564d357b
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB7044.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 10:06:16.8814
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TOScXwJk2iDPBa8mMEnSJ1hAySSLlpTNk7Y/ZaoTz4azLHXT9m9xnPyr9V8cq8ht5G+dLadNN0F3SYhqL0JOiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9946

This device can be used in conjunction with audio-graph-card to provide
an endpoint for binding with the other side of the audio link.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 .../devicetree/bindings/sound/fsl,sai.yaml    | 51 +++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/fsl,sai.yaml b/Documentation/devicetree/bindings/sound/fsl,sai.yaml
index a5d9c246cc47..5c95508ee707 100644
--- a/Documentation/devicetree/bindings/sound/fsl,sai.yaml
+++ b/Documentation/devicetree/bindings/sound/fsl,sai.yaml
@@ -93,6 +93,24 @@ properties:
     items:
       - description: receive and transmit interrupt
 
+  ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+    properties:
+      port@0:
+        $ref: audio-graph-port.yaml#
+        unevaluatedProperties: false
+        description: port for TX and RX
+
+      port@1:
+        $ref: audio-graph-port.yaml#
+        unevaluatedProperties: false
+        description: port for TX only
+
+      port@2:
+        $ref: audio-graph-port.yaml#
+        unevaluatedProperties: false
+        description: port for RX only
+
   big-endian:
     description: |
       required if all the SAI registers are big-endian rather than little-endian.
@@ -204,4 +222,37 @@ examples:
         dma-names = "rx", "tx";
         fsl,dataline = <1 0xff 0xff 2 0xff 0x11>;
         #sound-dai-cells = <0>;
+
+        ports {
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            port@1 {
+                reg = <1>;
+                playback-only;
+
+                sai1_endpoint0: endpoint {
+                   dai-tdm-slot-num = <8>;
+                   dai-tdm-slot-width = <32>;
+                   dai-tdm-slot-width-map = <32 8 32>;
+                   dai-format = "dsp_a";
+                   bitclock-master;
+                   frame-master;
+                   remote-endpoint = <&mcodec01_ep>;
+                };
+            };
+
+            port@2 {
+                reg = <2>;
+                capture-only;
+
+                sai1_endpoint1: endpoint {
+                    dai-tdm-slot-num = <8>;
+                    dai-tdm-slot-width = <32>;
+                    dai-tdm-slot-width-map = <32 8 32>;
+                    dai-format = "dsp_a";
+                    remote-endpoint = <&fe02_ep>;
+                };
+            };
+        };
     };
-- 
2.34.1



Return-Path: <linux-kernel+bounces-206416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9594490095E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 17:41:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF05DB2348B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 15:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 010271991DB;
	Fri,  7 Jun 2024 15:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="D25HrCpj"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2057.outbound.protection.outlook.com [40.107.21.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C7F1667DE;
	Fri,  7 Jun 2024 15:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717774902; cv=fail; b=rEW7qlf0e2I4NX4cF9y4UXIhnsmB9H7tgn1AEeGZ9CHGtbhJ4Vtmeq09pz7V4+cttAkzf6F/kW5e8P/7HA8QYILsS4jgv3h8tECVYwchgM46gtz7cErfnQjcoM/OQREiR+gR0X9h0XBJ+CtEAdgMZyeK3fZqRhq7Lb2k3Lg7z6c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717774902; c=relaxed/simple;
	bh=375alDv6D2y/YQOqZmqyEtmYGu+LeAXh9p0tA0zR+UE=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=DLwQ+k/t/MsJtZNcJurBSXEulB7gJuBmi9tmrfEXJuvuktDldzsC5fx0NnU4ku+XcI4V0yU+/2+Ll/6NpiUFYgQO/D7HNjJM2alzl3FzMvCWsM++Bu+TfwZLFpo2NEaO4xX0sPi4QSz0Luwo8druvSDTExOi5mw5wA6mbzIh1aM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=D25HrCpj; arc=fail smtp.client-ip=40.107.21.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X7f0bsRBmnDBhSZ/s6iPz+eZ/rLm0AZLrA9URT700z7r1BjuFrnu74tD9DwK4kv5rH8jlKRGJ7kw41FQXVvWKezh0kFwvoDVw+5ZrS1S9rY6tx7MwAFK2YTvOMJTg3Sc/kwwOHF6foERQ/PJyzT+gJdjOkKSh7e6OYW1nFwcKpFyYIXvQOFIG4nUOhqyu4T1rMGNmlGz9HTDOymEH8vGgF5FNNd3/cNyofFib/VVcPym0n+o0BNkHL4VAe/m6Dt5FwKzEUrmlHbcf2GZZZgEOrjlghRTM6y1hcsWJBIJpSWrBdFY70fY9DRMeBmcZL5eTmMjQnEiUyAGhGj0G8OwDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=89I21VWJ9LAjxQ8NOx4YFHYv7JrSE7ToxeaiT69lacA=;
 b=Z5lPsANL+O+wPXCivEy5fYrYSKi+YBZh9HSi8p2XXwEd961rXbr3SL4Qi88kJXWWVpC7Xj3NazN60+8QEZNjQ4qqwobEebQCAFGacsvE33/HwnHtr7rzvndjuGvoAHdxAiPkp9rVPtDB3aHvvGDJUYZ7ia7/OteIv4VutmV+kYcfFzcnI+eAm1sgykin+2/xgVXWCB4QSMHpBCtd+g94BvliXzUiSOcvdXtb1sj+8AA3iy1PvcVC/XCffs8nw1dkHio9SW//ise1QZsM5ff6jeqgVW/dHK+mv7ajmEvUIl9fr6ujtw0MMdgUMNfr69nnW0NEyw3WNtK7PnghkqtAvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=89I21VWJ9LAjxQ8NOx4YFHYv7JrSE7ToxeaiT69lacA=;
 b=D25HrCpjEsPVSoUfgdSR01Ar31pZRy9tDNjw76RF3FcvNgQnfQkZiNgNAAbsdVJchSC0H+tV3cnSqR6QnW5jhoN91JtmIFP6Fou8GNfngcda0H09hBwBzQ5V9L/VvRnGKDDA/FHb0oaX1X75PkMuwVLuTCqISg5VD4KlxiiKJHI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB8179.eurprd04.prod.outlook.com (2603:10a6:20b:3b5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.34; Fri, 7 Jun
 2024 15:41:37 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7633.033; Fri, 7 Jun 2024
 15:41:37 +0000
From: Frank Li <Frank.Li@nxp.com>
To: krzk@kernel.org
Cc: Frank.Li@nxp.com,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	gregkh@linuxfoundation.org,
	imx@lists.linux.dev,
	krzk+dt@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	pawell@cadence.com,
	peter.chen@kernel.org,
	robh@kernel.org,
	rogerq@kernel.org
Subject: [PATCH v2 1/1] dt-bindings: usb: cdns,usb3: use common usb-drd yaml
Date: Fri,  7 Jun 2024 11:41:19 -0400
Message-Id: <20240607154119.1543290-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0013.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::18) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB8179:EE_
X-MS-Office365-Filtering-Correlation-Id: b11a9c6b-bdbc-45e1-2923-08dc87085145
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|7416005|376005|52116005|366007|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KcIIXmsvl1WUv507gQKs2r1/ixl/ThnfOSVnsbTsFkOxTlWfrRn57DsfUBEJ?=
 =?us-ascii?Q?nFE2Rdb47DalO83xT4+ua8nO9a/cFpNkw1RBLIEPPeWIAv9thK5wdnuDKyM4?=
 =?us-ascii?Q?N9RWgepDfePadqfBKIzyOHdf48kNp7AFoeKOxapv3Php6RYZcwnK50KG3OEo?=
 =?us-ascii?Q?7YAs2eFppzYWE7R1y5DHj9rB3GHsqU7NFL18/php6dg0NWw6RXMA+c/7xYvp?=
 =?us-ascii?Q?XxS3RiaS2UoaWNBw3sWQJ7DXEfeH8Jy6ZnSWXYrflp6dtn9E+A91wIvkKr+P?=
 =?us-ascii?Q?pE6GMKt7apLrJ2mMKH7VUD+RclMMuGRgimqDkNitn1U1sgx47EVkZOPhzFaz?=
 =?us-ascii?Q?xdf1/mgNuVlprISZulwqycFcTUEGtw5ZriU6Kcr50WRyBREBMl/cGeYACISh?=
 =?us-ascii?Q?DoXT2UnY3FtHygvASmrnTRI7449R08KQD0aEgipPkk0X2rSWkfWt9XzaBxW0?=
 =?us-ascii?Q?Ona+DIN5+Hf9m136UGMIS1x5V48vhO3Vd7ir/xLkqHQsK372rrHozeIIOeUO?=
 =?us-ascii?Q?eBy4SuuGgjIbjOKJR4AUMvwqZ98iw5oZfFwvKKuBtspkTePeX2j44GTWYSeK?=
 =?us-ascii?Q?wonStjzl3NoSb972DQbaR0rvYUuwZQgY7kcDjIWCoVSVSAOftMRY4Eri40Io?=
 =?us-ascii?Q?TrIcCPm0apcA2a54Nj6nYmoS2Cenw0diBqqajwy0EHJHhs28hFrKIgDDrWGw?=
 =?us-ascii?Q?ld2w5tdOvWVzUmiArSzEyU4KPAzTU3qJSSbXoZSqe8ICKbFM5LkpNuIlHEgH?=
 =?us-ascii?Q?C8Fy8bTOkf+XpP50krWlGmjIRbtrZB8gkHDfMYrwhkTzUVcQ0GfetS3x0MqT?=
 =?us-ascii?Q?B5YQ3EUn6Cz1LfMkV/5Dgdf6ZVVTZrDazt29NcZiRKW35VKsVs4OmQnT0hz9?=
 =?us-ascii?Q?bUdtkSOZSHHdB4V1S29wVHoRfX22RwT8rlzNXluygtmahq9qJI8wpK7c+oJt?=
 =?us-ascii?Q?C1cCsk2nkelwvCyoL1cnQOv+17V2rd/U8SogfnQ5hj2otVWAyM/YLD7x6RYW?=
 =?us-ascii?Q?saVmall1sfRpUmtGnkbxGKKJld5zlrXGIJ/qHHlcK+vJxePfRmWPPGHH6CWX?=
 =?us-ascii?Q?bDfA97bmmd2Tb383m6hNsmxxl8X9bQgtg93lyYjoKBm7IwLDjKls2tJEGk5e?=
 =?us-ascii?Q?/psqjz/+Vihm0Z3ihXx8lnquV5yI1NNANf3xEnPnZ80eBPuVm0c3vY08kyxj?=
 =?us-ascii?Q?9raLxdHLTNRWXXRKsVpj0+fq1L0rVCfWz53X5gGdGjygBwRVKjNuah7AEdr6?=
 =?us-ascii?Q?uapMnLhM///xX16HgdHc7irh4omZbROkv+glPpjD4SLqvWd4WW+gQhAYXeVZ?=
 =?us-ascii?Q?XuxrsY6zQg6AO+O9K0xSagvS1rk1tYtNwdwkccOBxOGUkQJXoAo+PV9MYbJc?=
 =?us-ascii?Q?WFUzFK4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(52116005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Y38miWiLanXztJOelqofD6VG20vnrGwJF3tCcZhtzgwXmsTwna7Q6lTKBDKS?=
 =?us-ascii?Q?NsYni3HYN4pCOjNLmleJ1LKaAMaKEzxaJ6WS9ID9w7JZFAQK+6vWAuiYCk49?=
 =?us-ascii?Q?F+687H3fpHktWXgh4xQhKaXePfBYd3hplhZ2s7zZa0IJCy4PfRvXMFbeK/E3?=
 =?us-ascii?Q?DkY5XdogzTAi9DckCZdKWn9psQYxzzUXQSFRALdQzInpnWnnjF3maksuJIk1?=
 =?us-ascii?Q?4r9KKx+WS//R0E5u1D2IOxWXVCuxLo15vo9Lacj/XaOreO+mevVf9CNiKcyJ?=
 =?us-ascii?Q?QipQ5jAYX88BlkrXrk/ypKPj68DMzwrkdgQCr8PJxhS4gT1KufW5mqijbU3D?=
 =?us-ascii?Q?zbPbJY8w+F/2fjgkIcjs+rnVnbyIqV+Ek00TO43crrG64th8uGEKD8iIM1Lr?=
 =?us-ascii?Q?nu4K+UTvoUaYDJl7jwUxol0ZuUOTPavBXhgNE165HZdTY5WGBkubMpEnKGk3?=
 =?us-ascii?Q?tlL0RkdbGpDaIDl1eW06SoqKG3Pb/MA7DEM0Ctnx8FmKIMDVAO5pjUIdTL7t?=
 =?us-ascii?Q?OAskaFK3Lm+NP4I0j1fvLGa9dNu63rwAY5YWScpUUbGvypYyphNDa86sFoof?=
 =?us-ascii?Q?o0VtkHi5OAD3IjYFSvAwDSxWBvCVrE14zGt1jgAGy6gOAtrWdCYH9bxpVAjx?=
 =?us-ascii?Q?oAZNDgQ5ceC5NCObinoKzdsXhaIz71IQhdnKOeXjd3vRuS/z86CIta0LpzmR?=
 =?us-ascii?Q?7F9d0OjDjQzzWxPJeqcUcBQmMhBW8+/OfeT1a5Wt6bXJs9BDVavtFZ9jnxHU?=
 =?us-ascii?Q?X0SloVerIAB8kQR75bMVWKSTvOOq10TJZv55GnNHRNNwwgzphEDJOoLMlQTT?=
 =?us-ascii?Q?dB5BMwuqX0AGmAoWRfVzsa10SAmNi+Mx1IdV8ezYjuAmDVtKr81I5isKmck+?=
 =?us-ascii?Q?l3I43aAT+IRV2W/aIrs8liM6q7a2jYwb5b5+kN9OgKbdMHONBFJ3b4eBENHd?=
 =?us-ascii?Q?u89PR8jPnN+p7nkkFi7mPrmm9RcVQGGDaA8MXzjV1jhkJ8FdR/j5rvp1gdWr?=
 =?us-ascii?Q?AQvf+viEP4TiPb9Opuc3+e5IUkhrHgju6c9+ecqHaZra8zLVjY/Zr1cLSsJS?=
 =?us-ascii?Q?jMPswSkDI2L4MSWJku8Sy6joZuJLqfcAJJcXZBt2eDMobyyvSbbjk0+KQu6o?=
 =?us-ascii?Q?YJ7/jslVEKBdj0oskKv48UUcCUNtk6B0cV3VvGCd32YCSBm1Pn7wzdeDdJ5w?=
 =?us-ascii?Q?q1yb5A2xSnJ+uTATgB2vLLai5tpDqt4X+Q/K43F/Yxy9Sg1Ka5qrRtq4XKRi?=
 =?us-ascii?Q?8OxfKAQcoU7m7SVfR0qZ0u9+5wZKBvBSPEEWtPYwxwHHhS1a33yNTEhml0Ts?=
 =?us-ascii?Q?TK4Q2hbJd1LpokZymqxKtHrtXV1lD8HeUfU+/+MppHPnT/syZniWeEQxctpM?=
 =?us-ascii?Q?zHUhjKDoyUOH04xsqydnd7RNMa4XEp3rroi9PLHILFQRnmjeZB7sSRv13JwL?=
 =?us-ascii?Q?S9akMyzJK1nd6Iiym4NcIJcSbCZWuMornT+sSvPkvSm0ZWQ7s+rgfFPoH8Oo?=
 =?us-ascii?Q?oTymYEZyRBHYemKHnZq3Fo26e0he2SW4kSH7C7BcZZMzZxC/36YJGe6j184J?=
 =?us-ascii?Q?CND6S+U9BJFe72U9+6gYe7pb+BUgAW2hs+IgOYch?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b11a9c6b-bdbc-45e1-2923-08dc87085145
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 15:41:37.4095
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YR2y25h1dCIG/mCxgPbB3OmOF9E2tLjxfsGakkWzV13fDQVaZm4goJtxzmtB5KqK1Ohal9+f9wR7Wl3WcALCPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8179

Use common usb-drd yaml for usb OTG related propteries to fix below
DTB_CHECK warning.

arch/arm64/boot/dts/freescale/imx8qxp-mek.dtb: usb@5b110000: usb@5b120000: 'port', 'usb-role-switch' do not match any of the regexes: 'pinctrl-[0-9]+'

Add "port" proptery to use connect type C connector and fix below warning.
arch/arm64/boot/dts/freescale/imx8qxp-mek.dtb: usb@5b110000: usb@5b120000: Unevaluated properties are not allowed ('port' was unexpected)

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    change from v1 to v2
    - add dependences
    - remove dr-mode : true and usb-role-switch: true
    - update commit message
    
    pass dt_binding_check
    
    make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -j8  dt_binding_check DT_SCHEMA_FILES=cdns,usb3.yaml
      SCHEMA  Documentation/devicetree/bindings/processed-schema.json
      CHKDT   Documentation/devicetree/bindings
      LINT    Documentation/devicetree/bindings
      DTEX    Documentation/devicetree/bindings/usb/cdns,usb3.example.dts
      DTC_CHK Documentation/devicetree/bindings/usb/cdns,usb3.example.dtb

 .../devicetree/bindings/usb/cdns,usb3.yaml        | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/cdns,usb3.yaml b/Documentation/devicetree/bindings/usb/cdns,usb3.yaml
index 69a93a0722f07..f454ddd9bbaa6 100644
--- a/Documentation/devicetree/bindings/usb/cdns,usb3.yaml
+++ b/Documentation/devicetree/bindings/usb/cdns,usb3.yaml
@@ -42,8 +42,11 @@ properties:
       - const: otg
       - const: wakeup
 
-  dr_mode:
-    enum: [host, otg, peripheral]
+  port:
+    $ref: /schemas/graph.yaml#/properties/port
+    description:
+      This port is used with the 'usb-role-switch' property to connect the
+      cdns3 to type C connector.
 
   maximum-speed:
     enum: [super-speed, high-speed, full-speed]
@@ -70,6 +73,9 @@ properties:
     description: Enable resetting of PHY if Rx fail is detected
     type: boolean
 
+dependencies:
+  port: [ usb-role-switch ]
+
 required:
   - compatible
   - reg
@@ -77,7 +83,10 @@ required:
   - interrupts
   - interrupt-names
 
-additionalProperties: false
+allOf:
+  - $ref: usb-drd.yaml#
+
+unevaluatedProperties: false
 
 examples:
   - |
-- 
2.34.1



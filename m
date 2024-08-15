Return-Path: <linux-kernel+bounces-288185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B00AC953707
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 17:22:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C72AA1C23604
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 15:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AD471AD3FF;
	Thu, 15 Aug 2024 15:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="UxZcRqAh"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2085.outbound.protection.outlook.com [40.107.22.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB361ABEBC;
	Thu, 15 Aug 2024 15:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723735340; cv=fail; b=nABNgCQnlJoKtfCcr8mE/NEmqbiw6nttK+xBiVYn2qqyOBiCu9DuQK90BiIEWH/jTg0TM70gkQOM/tTIWErT1OgoG1Nn4VSsopAJcg7ZveU2mWCopiarbVpNkc/s0jb8sWBCqrALIf0Ktdc/tqotbzuZwAJG4LEMzse8cpYQRpA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723735340; c=relaxed/simple;
	bh=DuQvaMJKxVvC1xvSvHgx1N6PIU6W5AT/8j9ua78ESxI=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=glUjvRkiGwaH9YKfF4Imzos1DRlGFs8dm6mZBjEO5tyf68m3qaX6kehI3ISViOiohLwRqIRvluFbsMAWNf8fpFz0L3gSsJ3RQzqOsHNZqpUS75cahQhgIktDJyQuK38dm6p/muqg50cKUpvPXf/elZ5JpG0Y8bherD8A/dPHmec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=UxZcRqAh; arc=fail smtp.client-ip=40.107.22.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XP7lbE/giuPAaoAN4FSmdvh3d+GFh1jHH7QFCxrkYVffhsQI3Lwvoq0sMAZkepcLTB3qW+7D3roY1W1H7l6hJKNG0pt70/J0zOLuXCe3paxeZqAV2pjGkSE6bx8H7Pr7JjFoDNvO69WQN3iLHY3sldZGYrTBYwrJhHZxpQCqs4VOi1dnSmqNdpF5gIqr4t8QB/j93PeQYrvZqFUqO6NtyZsMZBAszmr2Mm5b3vdJyucZLJ4FOCVa4NpMeW3oM1gdHdtb0l36H44jOJkFq3pvOmEPdKsR3Ntk6/ov/i/J9uxZpkQFlqCKoNkRf1EY+TLVbL/7PzVLX8ikeIlQ7mMaMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tXqUAhCkkFo/6ANdxtPZFi/EmJBngkMm9MtlsoQ5+3s=;
 b=L6l/UHRqOA7BzlwtdlzMap2nu3IUQAHGvYCipvdmsJZXgqKAHnRnEDnHTO822wrrpL8a29sEZGiq5Im7jtcnd24Taux7Yolh3n8mN5WnhcKGKyOxwAEUnEuIJrAAdJH6X6iOo9PkRSf5nU3lkgGz7z5n1HhHgPJDFJdsdpBY4aLzpOftNuQi2Kmsje1zpv5WV/sDAa7t4ZSoicUkPnJBu3m2iIu69e5jvPuYGnhYDqzrbDU7JJoC6I6LBRSUCHaYn1C6U24ipxUG5lfBuxAbckKUE0jNDKmRyrx3/uAJWO4l3/ANFDFzYfc+uBBmvFh/fFBdmdFmSAJzmhjeio5lBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tXqUAhCkkFo/6ANdxtPZFi/EmJBngkMm9MtlsoQ5+3s=;
 b=UxZcRqAhKJu9dFBPwcMdXluVpM7RgTF0rI8XqisGUVJJwEzIn9+RT9d/lts9YazNn129CaCifDNF4CqK+UX229HKoCQ7yUP3TTmEArgoh2BwG96WHdUIHD+H/W8E/9e/I2OcoRObWU1dpB4eg+6nQhZgPzOVauN/mcSfM4cw7NyeBKqbuxVAGGLR0AJrGQAoCLFB85JjdHyoxAFY9CKzGW0aztN4OnyzcvXBOaI7e6aatTVV4S4jvAyC0EZPr5AdmeRdnquMC1NP2D4VsVbbKrhzkGSXdQvm1gvGkry6oSO9vWcwxb5Q9gojh229izHOWOSQK3gSpLOD1HV5HKep5w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI0PR04MB10212.eurprd04.prod.outlook.com (2603:10a6:800:243::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Thu, 15 Aug
 2024 15:22:15 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.7875.016; Thu, 15 Aug 2024
 15:22:15 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-usb@vger.kernel.org (open list:USB SUBSYSTEM),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH 1/1] dt-bindings: usb: add layerscape super speed usb support
Date: Thu, 15 Aug 2024 11:21:58 -0400
Message-Id: <20240815152159.4177782-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0055.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::30) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI0PR04MB10212:EE_
X-MS-Office365-Filtering-Correlation-Id: 95ab00d0-63de-427d-605d-08dcbd3e0b1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SLt/sTSXh64s2mZwMyjKR5pEFDkPsw1wN6ymOfYBIRk7PFayIoVnWW15BfQd?=
 =?us-ascii?Q?3/xcbXmAcExuHfpcfw8S6cuasFkEfLpOn6U+R12peTd6o8rogw3bR3IWLh8H?=
 =?us-ascii?Q?NtykbsmcGf9cLPmao51kmYpoOpM2pImaWMnpaUQcWteQuGaewdciy0TruDgS?=
 =?us-ascii?Q?zCBpcmljcai3NmSvWzkFN1D5Pq86pRm2l+V547JadVSVxn4T4dpRP7oUNk9a?=
 =?us-ascii?Q?kPsTPauCCA7/LOuxxna/yBSBSBOa6WwaUblvC28kOiHG/hZ5XEh0Y+yCeAAe?=
 =?us-ascii?Q?EZQH/qfNHBaBablZLxGdq73VDVknWF4enEw114PUs3+AQCPBl9WunvMKwXNz?=
 =?us-ascii?Q?P8Eq7aYTnROkQghO84Fu5+mI/lQcR0alHkTXy0dDVvG1zNUFGAKa2SHduAd3?=
 =?us-ascii?Q?lfv70LuoJ2w1hAwIYQr65HmsIVh0HckDYmWWZNjvugDQyDrNdKaHE+i7fCG6?=
 =?us-ascii?Q?hXZVIbENgXXiciMs/wTZTi+fQwjTlyKbdoMxVBtmNfJLh5KgcHU8Gx3LKWnn?=
 =?us-ascii?Q?EJI3LUoDNcKTTd/BRMxiRTKDeS4eR+OM5zDw8Oy89h/zbxf4uCpwhRWpHxRJ?=
 =?us-ascii?Q?i6FAv4MTgfuhkR4Zofp2GHhK+9Q4ySeHe5V9Dgl/QKps1Dfl84lgWeyaAKSz?=
 =?us-ascii?Q?QeTgGjENRpFpQSXp0jmjQmH0seia3mArj4BUNfjRMeDBSRWtetdBki/u0kwv?=
 =?us-ascii?Q?6zJrVM8/sRazec/3tpDujgSkdoVAfI9e1au1gLEy0D/22AfbfsOreCNSiaOF?=
 =?us-ascii?Q?6dpR79BX/1N/OaxrwOwcNOITqzNVRoxBdhjSPd7izEPYiwM0hDZ5Lt3pW9Hv?=
 =?us-ascii?Q?+34uACt4CvjbeBtkc61CXw3gskpj+1JFtbSBw2+ZraB2JUt1k1qPeEIDGXkm?=
 =?us-ascii?Q?lxRqWmCt2JztQqqfQMTc4hIz0BQnExbap4nvw/4ih7VHYX2GxMf0pACCR7IM?=
 =?us-ascii?Q?sHqdW3yXw73h6v/f8UupJOc3O5oD2RpHwDPGKSYiyvZwRWPSC5tF7/dl6u+7?=
 =?us-ascii?Q?JatRQPx6rFRFuQ2spwkiwMnLegakrSKekWkEvVUIJmhvyI1TEeTbVomNNSdw?=
 =?us-ascii?Q?l6dAaIRmq8IMmSEj6zmCWeM8Dh2D4ccXrDxohqkIbbdgd2iGI0K4jeBPlhRh?=
 =?us-ascii?Q?P4FWjmxCPareFvA6TGIjbzQd9q3Oj45i6s24G0wpYCJPaIvnw5r5x/SEKLIt?=
 =?us-ascii?Q?zPWiAD9xrbML3+n+3mLXes/IE+UzlmjzyeVw3AcT33je28O1NAIPohVb+3HV?=
 =?us-ascii?Q?jlfbNlg3h7Garm19yhLF+7sSfM/8+u1QzakiuLxeQ7rBKmEXkyH3Kxf70IiG?=
 =?us-ascii?Q?Dpm3Y5uArN1vwnMNbpnM5pIYD9LYGc4JQxL7V909MbQePJbtzSkWksYR4P7j?=
 =?us-ascii?Q?vUh9n0I=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iXLkVw3fGKEAIW5w9EFsgKD5nxIHqj7uVGCkUjbSuQ+wK7WY4TvnCI/iQl0T?=
 =?us-ascii?Q?xuIgisfgDq7InubaN7Tl9FND8/XM1oBzi0vk34jSrZ4Q+4R3pvFTlQZifB7t?=
 =?us-ascii?Q?Y/8PVYBUk5dv7Yk9InnxIj5nSkJj3ISiKm1upNlJopeUwci+KjnyyAKCWM+P?=
 =?us-ascii?Q?bs51myTdBBHW6fgWjtlvICY+xksKgraLM/XTJNZfTbtba93RSs5DWm3QoRaX?=
 =?us-ascii?Q?Sgy1W4Qz3GwAp9wU7Nm5rithcWnSnGPEBUzYXJzrthMv2ATDhDEICatpZlZk?=
 =?us-ascii?Q?2YIW/N1GB7sjPBFBNVu2t4tQ/Sg14MPmTFWgflpjGs73gbwEzeGQ8n78brJO?=
 =?us-ascii?Q?AqLLLQTsS2aZj3yO7mF1SdmIQdOMhkjTaKgnANvhx5PbYezZy0zLhNw2iw+d?=
 =?us-ascii?Q?cO+kfvOdrip3hmw1O8cnNQrFkkG60xIibfXB2Mx/rxri4shS5MyljdA0goQG?=
 =?us-ascii?Q?sRypyAXMgp2bUnt9fdkm4eRBESHbf9ciR99upja8z/bgNmQw/GjGZXQ1qyWa?=
 =?us-ascii?Q?g0uCmtaqYVLwOUAAziYPfcZ4hLn0n3+esKogJO5Vh7iMPe3j+t9KNZOTO7Ae?=
 =?us-ascii?Q?+qqquVGTKvOya9W0nhk5b5dfCFsSoJFzMMZIrCD2DnDY2GfG/uyN77OeVT1c?=
 =?us-ascii?Q?MX4uBnT2CGDyKGIORgq+l166+u5Q17eat47hUqdsYbCMB0XomCw/F6Lb8Kps?=
 =?us-ascii?Q?Hc/1PLQwV7V3NbiQ5O7HLnqmWcg1CbRo56JTDCnNNWUK+93ls8Uincxl1Bd3?=
 =?us-ascii?Q?ok2qvB0VLxwrhxLLhKddoz0UVfT1kJHxlPsWtYO0ckBVVaWcSiV4AUHpN4T8?=
 =?us-ascii?Q?GmcBU2gawDUkAYYLj+Ap+MVffSxkHzL/QE8AVCZMXpWZColzC22RNLvmtpEZ?=
 =?us-ascii?Q?qtY6kVEeRp/iKvJo+Gm09mDECaFncJzoadk7JENV+Oh6bEoDLNp63Ozda6Bu?=
 =?us-ascii?Q?JcKhrHmn5cuPWYHrkYGJNReP+MEB9NRHYUTRBejvmPKARa7hS7b1X85f9jnk?=
 =?us-ascii?Q?QrZIH9K9EP28mMsmfSJ4Wez+HCcZT7LwZTeV+q5LyaacBupHQ1GA4KebhmHf?=
 =?us-ascii?Q?VksVdDMNweG8q5lYK651reOxCYKoANY/fBYn7ZXkWeqA+BUtxxdASt0+Qg4R?=
 =?us-ascii?Q?R0ha3GbmXdSallOAtS1R8DDw2vGHGuYZbl07lp9yR/TX1yRvnZvUhHS8MUGd?=
 =?us-ascii?Q?ZOXlUev9eZ5fE6dRhIIyLcKzKUdzIcHD092PnaE3QL3miNZJEUgvI6v5Wb2K?=
 =?us-ascii?Q?ygIGqb7p1tkEjXK2cTsxDk0u8D2Yr0vqoT2WOOA6nsYE/qQqEH71HzNAt0mW?=
 =?us-ascii?Q?u5OyBOc1QWprnXg/Vl4r/rqfpiS1BPyU9DcmgWLzs7asE0iKeLHOWL5TZ1QU?=
 =?us-ascii?Q?a/Nx6p8ibo+8gUxUqJnZQ8RWvwU7xZ+RHS4qOZqOJUSJ2dhF5XHauiCcbFnP?=
 =?us-ascii?Q?MB4uElMLugXFH62ZhbOq8Om9T9mLp2vTgqOEz9OUXXUHZD5q6rRDU/wMohRH?=
 =?us-ascii?Q?nKvxB5dhO1yDkSqI7gtl/8yr8Un/rUy3+fp43k9BCZjdp73g3CeajtqvBlL0?=
 =?us-ascii?Q?H7L8UsfONqrJhVzd4h/q03ACJ7fcKFwhjVL1xpVy?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95ab00d0-63de-427d-605d-08dcbd3e0b1f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 15:22:15.3294
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vD1qkLMtE//UMrfHkb6rnIHBlprmeIJ5IQ8JdI5yDUAKTW5/016ISM3SY1s67zviSRcfPLRbNseur+Au5F9VIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10212

Add missed binding doc for layerscape dwc3 usb controller.

Fix below warning:
arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-kbox-a-230-ls.dtb: /soc/usb@3100000:
	failed to match any schema with compatible: ['fsl,ls1028a-dwc3', 'snps,dwc3']

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 .../devicetree/bindings/usb/fsl,ls1028a.yaml  | 52 +++++++++++++++++++
 1 file changed, 52 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/fsl,ls1028a.yaml

diff --git a/Documentation/devicetree/bindings/usb/fsl,ls1028a.yaml b/Documentation/devicetree/bindings/usb/fsl,ls1028a.yaml
new file mode 100644
index 0000000000000..a44bdf391887f
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/fsl,ls1028a.yaml
@@ -0,0 +1,52 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/usb/fsl,ls1028a.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale layerscape SuperSpeed DWC3 USB SoC controller
+
+maintainers:
+  - Frank Li <Frank.Li@nxp.com>
+
+select:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - fsl,ls1028a-dwc3
+  required:
+    - compatible
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - fsl,ls1028a-dwc3
+      - const: snps,dwc3
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+allOf:
+  - $ref: snps,dwc3.yaml#
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    usb@fe800000 {
+        compatible = "fsl,ls1028a-dwc3", "snps,dwc3";
+        reg = <0xfe800000 0x100000>;
+        interrupts = <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>;
+    };
-- 
2.34.1



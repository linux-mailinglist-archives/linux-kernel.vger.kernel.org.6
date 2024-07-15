Return-Path: <linux-kernel+bounces-253148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AEF3D931D58
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 00:54:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3ED231F21B93
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 22:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B26F13E40F;
	Mon, 15 Jul 2024 22:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="i3FN+2TU"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011055.outbound.protection.outlook.com [52.101.70.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BBB33BBC2;
	Mon, 15 Jul 2024 22:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721084052; cv=fail; b=R7ne7/EE/McglXzf/NI0cLqQIrscSwtHrRSGRM4gzRf4AHlzINm2QEGeCrOF3NxyopAP0bZkhuxq2Mol+2Yrl+SMaue16YfZFOUaSDXG8UIh45hptNT+60w5mVVMle0jToxGCCDQnOVsOrpQAOyAEYqfg50gO/dsRgzXQqRBHzg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721084052; c=relaxed/simple;
	bh=eJGYjyy2+/AAn5LRS7ekD4voF98roh8b+/mecV7Zd04=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=LuPzA6t8fMk5g9IIkHq6ov6WIiqKzG/q7fWlgqLWpPgCr4HdSHygF3uLwFH5WzMWoO6CpY3Ystxr0r6HmA8xOc44C5+gvr2aiGVsV2eFrCmDISa0Eo0V7J5cT1D+0Yky3bAwTUAOMMR/I4xrg2g6oy+eIT8vSO1gLVKfrVH9kVA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=i3FN+2TU; arc=fail smtp.client-ip=52.101.70.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qblMoy+lyLnYCp1I1+rQKEd7M6+ebJxKXDSobc1+6tyR690M3T+y0Ko+6WG1aQz4Q7X9frELa/EVvR3tkrO/J7inAxyS+3jOEnljfFvYeE1h/ZR8tBy++2PEsZJBi6+k0hFYbAcCO9A6olkPn9U5Ly5tpGLSe4327HCeKKc00HnRMF0+T7ZQ/Ybh73hQTCACKK5/P0zoZo/pJJGbQK6/s2lFaGGTJiBQgM6J9XEBsFoOGjFW55wXQeQQMLp+VgNPCqYBcc/eeX9iH5JRhZINlHH0geCydBDbVVR6m8+GMlECvQjqw86uUbIW1P3osr+pkJDtbQWD4swQNd38g2Orcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yPH23LFMgAbUUYmqG73yuG4FV3P9ta+eYzNlAMag3s0=;
 b=es3riojWIuVYgs9VV+9PZ0awZTxk5Ip/OxkqqNXLLWH6rjXAxNuSkcUSOz5HlC1+lek2RIH6cLe+BjGF0Pq2MbrlqsFykQLZ1Hm73rdsVBR/dNLHW4+/xQujM7zD00wgT+2iJL1G7Vno6T95HrIvzHZO+VRR5G5CFRucS3yyRbqZA1EkjmzcgT2reNesScg2saBvIZ1x27qguhAtmSRAsnMIRYL5RqlbFn14CndDwoBtlnqmFKnlfCoeL9189KB/R1IbdbbIY/kvty0zCBYplWXZpHWzYuKAdA+2bpxeWGXJ/NXaVvyjx8kiRYAXuP1sAYGYN1JH6+i44ie+JtnPKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yPH23LFMgAbUUYmqG73yuG4FV3P9ta+eYzNlAMag3s0=;
 b=i3FN+2TUzRIbwLmgzNtETasd4leULHnrSvhs2fRjibkezZ8sLAfTHAbg4IydicYk0qSa4FqmTPwO30XqRXJzfdsi4qKgGImfi57Xi1lcfLzGUQvBg34Zd0ClSnWBmnsYJv5CmEbmHgHyPJ1w8SAYZVNdUaEf72QCeygsv+Nr2T4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB9PR04MB8074.eurprd04.prod.outlook.com (2603:10a6:10:24a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Mon, 15 Jul
 2024 22:54:07 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7762.027; Mon, 15 Jul 2024
 22:54:07 +0000
From: Frank Li <Frank.Li@nxp.com>
To: krzk@kernel.org
Cc: Frank.Li@nxp.com,
	alexandre.belloni@bootlin.com,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	krzk+dt@kernel.org,
	linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	miquel.raynal@bootlin.com,
	robh@kernel.org
Subject: [PATCH v2 1/1] dt-bindings: i3c: add header for generic I3C flags
Date: Mon, 15 Jul 2024 18:53:51 -0400
Message-Id: <20240715225351.3237284-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0096.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::11) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB9PR04MB8074:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d13bcd8-e381-47b3-fd2d-08dca5210859
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|7416014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hJkITxf/DbZfM8POmzhApL6XGiYzItMddHi2iwkJxVbp+yzaOX01iuZQj/Ef?=
 =?us-ascii?Q?8weM0C0/w+6Kye7eeD7oj69WI36Ksc/gd6FZtVyN+hIOMiFxbNKNUSiN7S5g?=
 =?us-ascii?Q?ImpweKBMmflNFicOHNHSMNW2pD7OWmj8NBb4NUBTNGX4B0EVesSuPv6Xmv/i?=
 =?us-ascii?Q?Owk9B7qHuihABcY4leJD2WeumoQW8Q/QawasI8D4E3HS/SLjLa8Q96JmC977?=
 =?us-ascii?Q?IPoRfVCj8kbrQkpkiBKjko5yClvyHAKIPkve/sDHvGXBA3piqjrJHOZH2Ebi?=
 =?us-ascii?Q?h1ce34eXLdQ6wAzhKGOTGZ87fSZGQwMN05jFHbAFqXdtXExSQx4e0UJ3TJM5?=
 =?us-ascii?Q?LWfNlYEj4JgRjsvfgc+GLy2Qi6mHbVU6cwQMy2H3JQRuNEAYJLjw+zlq5stn?=
 =?us-ascii?Q?5rEZCAAb63FeE2gcY4U5RXFtLO/Qd4i5ZXnPQ/kIyf6MidHgN+7OqrkDBj1P?=
 =?us-ascii?Q?uKyopRBvlZCnCAJUnYaKWJIIx8GoAgww3HKFysW4M6+SXJudNuPHimVEc14Q?=
 =?us-ascii?Q?gIChMNNnub4uyNaAhoyCOEBvh5xGGA4UjI7m+ZjEazQy1WMPJe77QOeugBM3?=
 =?us-ascii?Q?7wOvhu1vKVeaCORjDhZ8p8f+zWqj/A4qdZjo8AUBiyoOCcOoOjDFESq8X56G?=
 =?us-ascii?Q?PkRsDbMnn2eq+9ugXwWNx4Qh0iH2ZdDOryRvy1gD088toG6WTrteDjT3++Zp?=
 =?us-ascii?Q?8/ZB4H8JnLizdTNM0n58HreGnCGxAd57YiIB0uo1nDxGL4ZzcZcWvu/zh8J/?=
 =?us-ascii?Q?wE3MlTEiLT9tpa3DqsBMQi6uK99PljN+kTuiuTp/IGst31xeCAFkXZN87aeW?=
 =?us-ascii?Q?keY96p8Y4HBG1Tl4iGTlbdfQ7vzlmP/+MnSBlJZI4yDIJFhkR3sWkZhzYJbi?=
 =?us-ascii?Q?CV86JCLN9EWibIp+hwzWz26cVPJTxSUw9uSmPqlJgT6qDSt9M2cmJFzEIMfF?=
 =?us-ascii?Q?zhN0dZ35vF0K8FNtOSEoyHRHmk+qHwky4YezRMCxPV9PUh04j88an/HuLj32?=
 =?us-ascii?Q?1Jsu1ZLAHPX2WF42B4aokCv020oTGLnHe/cLlLLXoTj7MixBwNVJGTxEpfwg?=
 =?us-ascii?Q?yH/h51YQ+/jlqI/OlAlotlTbEWkXTSh5e1mNZbKRMbh1PkZ17PM3+ULSDsJX?=
 =?us-ascii?Q?8eGdlaSvL1+IDJKmL3PjhqWKWpjgcWL/qxdBrBLVUxsykApWQ8NGGgFB0yao?=
 =?us-ascii?Q?mOdACUT9a9nSA71pg4XnnEsxG7mVfP+VjMyyoxHNKyw0bIXwi2hzoLP+3PAx?=
 =?us-ascii?Q?4teL+XT/aFuXO2zDpqtahMAMsKiKhuuwG5QFeB3EM6x21NXRuUhJ5ngTR79c?=
 =?us-ascii?Q?EN2VmPoKv/Gw24SrXZ7/2R8WlxEE9xQOenQvnyk3DwJJ3tp2WsDpBXywFTSx?=
 =?us-ascii?Q?Kgq/xPCqACG5jHls9snziuUQnOcS27yTfmxZijdj//pvuGxyJw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(7416014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OOuAqtQry5xtF/+WLNlYP1trSvSSFs4pU8JTydHKe6MxpWX4wA+haP0Azc6z?=
 =?us-ascii?Q?1luSzQkm2br6tu9LbOaLhW9Hw8VGEBQJcpQJgpyCO29nreUv8psbYxLyI0Ri?=
 =?us-ascii?Q?4Hz5FvRtOeqBp11fiU7PvKxIbavPB0GqYwx8uLvnike8awDmV6EMt8nRguLI?=
 =?us-ascii?Q?wkDZujEP7DBHmGLaOPXRHSa0tniVwUdSc+R5GSPHH/gHPDmY2fHAg96TXnPV?=
 =?us-ascii?Q?yWDJZUGFgM99xf6FPJmCoPMJbTYHV0ozmBmp3mqxDzXzXhL/X2f9Dpf6lxic?=
 =?us-ascii?Q?pCNBHIvrrR0WCIZWj/YLmZUh2KsxfMspCSZqyT1XC6Cbxy9i0eaoXoN4ydmS?=
 =?us-ascii?Q?a7x3JzJvKub2tXPBlBmeKIPL3jm4V7L84oNBxOkBgY+sMp/YMiNz5/yruaB3?=
 =?us-ascii?Q?i9cIip9mDTvRY9+Fm9EtfXGMN0QE5CU1Q3tj1h4N9Mnrp0N7TMwhVePIQzd8?=
 =?us-ascii?Q?hyHkltyjdJh6tyz8tR0BsDqMEsFKStcrjHLlE48Sl+uPBTjanyiEkvpvQ4g5?=
 =?us-ascii?Q?hjYqVdOrtloDjTexLlNI+/q77Zzu9O8UHc9q8jRnPheTQiz+OS52Puq90dVL?=
 =?us-ascii?Q?7YwnmCOnmd2JbiPkpNy1XbTzL5GJkF5zSILdl3Inm6bb50BCnbFZIlar3Lm1?=
 =?us-ascii?Q?ERCK9c8QQqj0DQjx46Dv4EacOIhVXCHhcOSuPX9xDzKxVotNeRbt0PZTKDRJ?=
 =?us-ascii?Q?mL/IJYQ+zLHtbN018g4Yha760tfeoGaORy1o9mA+iQpRFhOoSQ0JJ/pHUmuK?=
 =?us-ascii?Q?sTmuqGUdRYBqodUfdH7stkXaSUimMTgSKrBw64BV5D+DALuamYxla+mWsBYA?=
 =?us-ascii?Q?/pDoXi/0dhJ9g566zLWeaaKlXI8FjQA/2fB3/eBHchJky82JaHAmKiVRydlK?=
 =?us-ascii?Q?VCNX00jrgZ/7RoIAXC/SYvvmhbaPxcE04Xp3BmjtfKBGeLUP8sbJOA/eONEj?=
 =?us-ascii?Q?Hg7UtuoVWPCi7QiEobWc1+k9CpcBE8DsZwPnsMbRjd8uQDFpHNHuDhVAPH4A?=
 =?us-ascii?Q?vvq6T/0E7em+9GEKt6j9xY4CbyLFy32k6KnQOJlusExYGFrmQH1acASvKeIi?=
 =?us-ascii?Q?LSq2XiTp39K38KbrmG2KRQ3ZvNciKv8aZcWeibR9aBDLXLMTsRnlmWNx11PS?=
 =?us-ascii?Q?aYFcSdROP/tgLQSjYG8iz1wzqWj9neqc5FiV+k36QXxV2zmtGZvTd6ZO1jOd?=
 =?us-ascii?Q?+3bkfP+8DuKvScl4158IfDZD+YtcNGBwlaN2F8X28RMywc2bGgUf1q8JQHzV?=
 =?us-ascii?Q?NweEZFe7Y3nw9GgdwWetbBo0fzxxY7K1TwiZUuxienDokUt1guKRD56sESWz?=
 =?us-ascii?Q?3AtvMS+FeReRuoFIjFjHCGifczndXfOYRFdJEK+QQeFZfqnxDN4aW9aDO5pY?=
 =?us-ascii?Q?kxVKoS+gIyT2UC1D9tGVq+D7CeSzSfD+A2oif8M7fDxZDwoyMJnjfpqL9FMs?=
 =?us-ascii?Q?hOjNBnzLwHAw1JGXeFKL6xYiTAf7LarVE6xZQDo+ps4tdmHMYm2xjKSiI8nz?=
 =?us-ascii?Q?c77hj8DhDSkaoClkRINupCFT85gKClYe8yHocNOm/ioN+PmBpZbkEmVQVG+2?=
 =?us-ascii?Q?tGg9zN6gd9CvWdTFYe0Hc9ZGf6C3SjFcAXA8cH1k?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d13bcd8-e381-47b3-fd2d-08dca5210859
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2024 22:54:07.4085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D7hkr72AZ5ZQj/JClLw8RRtHXOHUo67i10mrGgVBHLIurA7pVEgAgiB14QrUM93y++lDzAGxuKi0irBxRv+43w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8074

From: Carlos Song <carlos.song@nxp.com>

Add header file for generic I3C flags to avoid hard code in dts file.

Signed-off-by: Carlos Song <carlos.song@nxp.com>
Reviewed-by: Frank Li <frank.li@nxp.com>
Acked-by: Jason Liu <jason.hui.liu@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v1 to v2
- use full path for include header
- s/MIT/BSD-2-Clause/
---
 Documentation/devicetree/bindings/i3c/i3c.yaml |  5 ++++-
 MAINTAINERS                                    |  1 +
 include/dt-bindings/i3c/i3c.h                  | 16 ++++++++++++++++
 3 files changed, 21 insertions(+), 1 deletion(-)
 create mode 100644 include/dt-bindings/i3c/i3c.h

diff --git a/Documentation/devicetree/bindings/i3c/i3c.yaml b/Documentation/devicetree/bindings/i3c/i3c.yaml
index 113957ebe9f1d..e25fa72fd7857 100644
--- a/Documentation/devicetree/bindings/i3c/i3c.yaml
+++ b/Documentation/devicetree/bindings/i3c/i3c.yaml
@@ -91,6 +91,7 @@ patternProperties:
               - const: 0
               - description: |
                   Shall encode the I3C LVR (Legacy Virtual Register):
+                  See include/dt-bindings/i3c/i3c.h
                     bit[31:8]: unused/ignored
                     bit[7:5]: I2C device index. Possible values:
                       * 0: I2C device has a 50 ns spike filter
@@ -153,6 +154,8 @@ additionalProperties: true
 
 examples:
   - |
+    #include <dt-bindings/i3c/i3c.h>
+
     i3c@d040000 {
         compatible = "cdns,i3c-master";
         clocks = <&coreclock>, <&i3csysclock>;
@@ -166,7 +169,7 @@ examples:
         /* I2C device. */
         eeprom@57 {
             compatible = "atmel,24c01";
-            reg = <0x57 0x0 0x10>;
+            reg = <0x57 0x0 (I2C_FM | I2C_FILTER)>;
             pagesize = <0x8>;
         };
 
diff --git a/MAINTAINERS b/MAINTAINERS
index 3c4fdf74a3f9d..f0ce22e04d467 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10479,6 +10479,7 @@ F:	Documentation/ABI/testing/sysfs-bus-i3c
 F:	Documentation/devicetree/bindings/i3c/
 F:	Documentation/driver-api/i3c
 F:	drivers/i3c/
+F:	include/dt-bindings/i3c/
 F:	include/linux/i3c/
 
 IBM Operation Panel Input Driver
diff --git a/include/dt-bindings/i3c/i3c.h b/include/dt-bindings/i3c/i3c.h
new file mode 100644
index 0000000000000..373439218bba6
--- /dev/null
+++ b/include/dt-bindings/i3c/i3c.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause */
+/*
+ * Copyright 2024 NXP
+ */
+
+#ifndef _DT_BINDINGS_I3C_I3C_H
+#define _DT_BINDINGS_I3C_I3C_H
+
+#define I2C_FM      (1 << 4)
+#define I2C_FM_PLUS (0 << 4)
+
+#define I2C_FILTER  (0 << 5)
+#define I2C_NO_FILTER_HIGH_FREQUENCY    (1 << 5)
+#define I2C_NO_FILTER_LOW_FREQUENCY     (2 << 5)
+
+#endif
-- 
2.34.1



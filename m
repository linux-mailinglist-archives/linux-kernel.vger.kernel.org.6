Return-Path: <linux-kernel+bounces-180699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E87F8C71FC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 09:22:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F8AF1C209E9
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 07:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF7084645B;
	Thu, 16 May 2024 07:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="kC4wathi"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2047.outbound.protection.outlook.com [40.107.21.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0EF512BEA9;
	Thu, 16 May 2024 07:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715844092; cv=fail; b=Cqw3lhfHfvh4KvDF919pqxfIptrEFm8ngp4on+3F6z4JCXXVbvhCzw+orhXABUke4tKkZRuAKn9AcBo4m1EgmI4vwq5GxgHxX6KdCkDPY64emOX7f/8cXhB1R44b6Xnx9p7U6S0GHTg+M63sdUV53JfkpEZJDywWHGwHTxjpt5s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715844092; c=relaxed/simple;
	bh=iFsluABJnDx7E7/HqelOMMvPVMf+HPoV/4X7YhF7cH4=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=ZGqfnQxuOxivS9mVyrHU9t9Ig0NfllDeq9XXOoAgbNPCexvIZNlpSyS6NHma9ALi6rFFJYnQ+UlSKvnV47A1RzFpSiXAf8Ruj47FQqq/s2t1b5bk9yVtXY0NJNUyM6mVWqKV4sQUESwsIrO2N6ND9uSxRGw/YjE9LYLvpvEShgQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=kC4wathi; arc=fail smtp.client-ip=40.107.21.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ky9AVr6h8EFBERNVMr3kqH0crxfeqK6T3LOy562U2y4JyKlIOA9e/XZGRmkLlGneVCugn1p86li2gSnwP4BpTpVVW2hku4h/4YHqdAFiVuW+ENfVEHR9ofUpHR8EbdTfit7Ks9f6jU76KPmYV9PkVLWAFDQM8OWp1wL3ELMXcoVifAFf4VnWiWtq+YmeQjcn+/i+hWw1V6G+be0x2cuGBlQNrzzv46PahEq3/cl632Aj0POCL2FZZG5mVqiKIMwYzJTESEhO6eccUG/C5ACP1ynR94DvbK8/ykakfygZ85xtYqQyzxl2hGVC7TnIi2ya5aWMM8wC++hUJE5f8zJfDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FtUWzdcs5M8fBsfAw7e9gGAEA3QwEZfGTZsMfCRQlq8=;
 b=JbDV3hk5CLYwlGekI9Hr2tbKJGYevT+WLj/NeXdrsI82tMsOd26lSLCwop9FVJz4vv2poGGKcKDCsL0PBd1GaZimKXlGhnoFjbq2eni0T0QAp0AJL69WvZwLvBWrgMwpnmMhN+jI0WfSRKM3qn2PlJcWSAZZV+kpvuVVETEM320O36KT0vebRzvJKy+saHoCG3z+neY4E0V5tpAhX+Fs/FD631aOi4xW9R9je7kSxLLFKtWvL95tf7wkyH2rUfTkGn2hlWxP977OGCmHqE0q/JzLKCzbnoB/AdUV3xsJUS1oDRyNEHlB5eSF6Fvu43pA+UxPnU2lxWC/SfXK/n4kDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FtUWzdcs5M8fBsfAw7e9gGAEA3QwEZfGTZsMfCRQlq8=;
 b=kC4wathiv8o0CNGfwqeui7zHujzxtDnwMD+wTUkBVgycjDd3nM0MuQQY6HdAHhQy0XYsD1lDWTQ9YPf7iKZ9cVAHTua39M0wey/y1ZwUh2sxLVnK+3njKTHaQkJAQS6UUleY2rcOMWitLVtfmFGfoSKkFe1CDaX699aeXDfNFW4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB8PR04MB6778.eurprd04.prod.outlook.com (2603:10a6:10:111::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.28; Thu, 16 May
 2024 07:21:22 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::557f:6fcf:a5a7:981c]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::557f:6fcf:a5a7:981c%6]) with mapi id 15.20.7587.026; Thu, 16 May 2024
 07:21:22 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: linus.walleij@linaro.org,
	sudeep.holla@arm.com,
	cristian.marussi@arm.com,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de
Cc: linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	festevam@gmail.com,
	imx@lists.linux.dev,
	aisheng.dong@nxp.com,
	Peng Fan <peng.fan@nxp.com>
Subject: [RFC] dt-bindings: firmware: arm,scmi: Add properties for i.MX95 Pinctrl OEM extensions
Date: Thu, 16 May 2024 15:30:12 +0800
Message-Id: <20240516073012.1699795-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0087.apcprd02.prod.outlook.com
 (2603:1096:4:90::27) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DB8PR04MB6778:EE_
X-MS-Office365-Filtering-Correlation-Id: 17d807cd-dd54-448f-2407-08dc7578c998
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|366007|376005|52116005|7416005|1800799015|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?md7AT8i/SgVhkRhF1ihcjDFkTWJpvr3YLyQE9Ym5Bv2yN0c3wpBXYUYFdb37?=
 =?us-ascii?Q?3HqW0NOR1u2aHHDgt/3WZia3cLdMv4MDjjlELEkff98CJsd6fGEhHW2WVef7?=
 =?us-ascii?Q?orDEMRlsNAjBbtdDIYY9voYq7bCY6WK+yvXY4LUB3R6o8X518t0Qv+4o5ODH?=
 =?us-ascii?Q?WWxHryqXNRtUjRM5caYOTwaqULr1iELlZ4RZsi8FGNqST1dZJH5/nflslCsq?=
 =?us-ascii?Q?G5Tg9kXAXFed/zBUhyWh2yokZ2Xa89ENMFMLYLEIqy5jPCBwTzERGq39bIim?=
 =?us-ascii?Q?VkQJq3O0VECykxsHWn3DCQV6mzqVaF4ypsOSgsmKMPs2GxfjEaeP6KK+XgPc?=
 =?us-ascii?Q?fk6Jzz6bBhsXUxMu1AR5ISDSQ0IRUdKihq5sBXoFEZl0hy3jOGil/FLKu2Y+?=
 =?us-ascii?Q?YWvm3jx1AiFaKBuszDeVLWZ0cy1rsGscbcvDFBZ1RkvVKjyUW73SthSIhJjY?=
 =?us-ascii?Q?87+DMIa0NsassyOVNNfmUfjLsdPEFcrJzuwsJv4oUsU712CX8m03Pr0EKCd9?=
 =?us-ascii?Q?A8d3XahEiUWH63FeoflW1DJX9OtugaLnFgOH//UgO8Z5EeIZsgj840YFbfD4?=
 =?us-ascii?Q?0VILHR0ilj7ZioXMNmubk63+5JcEyFG+SSYOTyfurzi2W8aspF/Z4KuzusPb?=
 =?us-ascii?Q?L0pztplumV0OTDsWpSiBrELAxRPykHuexhfIQF2GVhPn75OZtSfPxIEVBl8E?=
 =?us-ascii?Q?LV9P2829Y4PDYE/kS4JQl4zhQtbzyeaOrtoQCEQGcvl/FR8763RfSIz9KQVX?=
 =?us-ascii?Q?d6NVFKqoYL5Lu1uD2qdR5+EP91GdC9mtIG6RAbKtpxw4oXvX+FDqdHddZFiE?=
 =?us-ascii?Q?8018NnIicPkoTjmx+f68P403fjl83zmtVUz4nQYHtypbhof4GRef7APOPWY0?=
 =?us-ascii?Q?ZtWDE9RBtiOjgKWck4JCUldvNfeCSWOlVQ3u+oB3/wjgYdX4JU/+Yi7pvUW6?=
 =?us-ascii?Q?wXnmeFV18MgT9kwXYbTR4qAEgwlJlZMUIapbpg7+aqx7G46Kb3TPkX21fWva?=
 =?us-ascii?Q?O6GkQV94QDsP5H5zxy+n6H+5Wub0wYWdxRkgtFTF4hubcRsV8C+OLblCzhEo?=
 =?us-ascii?Q?qCvi8P1s9TjkY5Bw9sTg+qntU2LHE1EpUbY59b+6MZViDqhMlxNjnvNOnh+U?=
 =?us-ascii?Q?DCi0c6vmu2cwcwQu5SpFs9rRgLl4R0MWnhf6gxHGeBM4FddPrrwJFQmO3Qz8?=
 =?us-ascii?Q?YHBeBlnxxbdiJ0q2vCqw8gHRWTTu2Tf3xV9+ySBIzZXRidlNCYoLLV/QcXIn?=
 =?us-ascii?Q?W040aUly0UE3PGT6hHKqo8wWj6KjhrvZoST5UYQqNxEnWxxuEWemhZk5haBw?=
 =?us-ascii?Q?ops=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(52116005)(7416005)(1800799015)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VvLA8Kd7laory7qfNVKFgdwNzZHOHRH1pEK6wWwYyUj9ux4KqqJyaJDBoJMh?=
 =?us-ascii?Q?QPNz6mOzd/Fl8UCZVr4FhcWemKNfIzqY7Sp4NlQSsFFO4PmY2CK/4vzl5g5c?=
 =?us-ascii?Q?CLTGy35P9O8uikg/UzYjms5BRYQj8pCX8B6W02U2y9zpS36K5iKccAsoBqPl?=
 =?us-ascii?Q?xgB4Lsb90YPOl3jXjpLBAw2d+EuSJPoadgM34u4PDTVK7+9aV9SUdbaV9j7X?=
 =?us-ascii?Q?Ak23zBGNOIXW9Ds9rTrgQQQluMp+3OUQYJgzMPJRrCp3SCUqZetUrTRggmn+?=
 =?us-ascii?Q?BHEF3iOJugNa70YAhLUN40RXMfEf7Xa9+zAsHzwhowlPjeqfDdJLnlgajfdo?=
 =?us-ascii?Q?4jX6yxhxvHP6LLmDF2ljpeqrzlslsOYfZqFb8PFGhfXLd2aFiVcJMVjh1rTL?=
 =?us-ascii?Q?6faBta2cS+kOx4jiOfe9bhNuvwn3OcXn5YUsZoLofiCUMd5xN7c8Y0zojrYy?=
 =?us-ascii?Q?c1F02+idORcDTDg5EwB06kHEpWLHyyZNlfU8C891vBmLWPJnKCrFGJVfAqp0?=
 =?us-ascii?Q?Ija0EQhCJ+Ci37z9Gzeps4zfHBcuPICZqQUcbNJLkHCUYilBWYRMuynP4Gp1?=
 =?us-ascii?Q?snuYU1KNNQP8yoILvIFlDrXbYqgAWA5neThPcDi4p10detfNfH/IQfiZLzHL?=
 =?us-ascii?Q?5/Ug8rmLqDeunejoc0Gp37MnyNDTQVGZNzW+WGSTDMSjiisLx7bVPX8rnlAh?=
 =?us-ascii?Q?ghRFRtDPU3ZPHDtL2L1DhYc0onGf7gLPjZwCyy2x2f7/7VdtJ8H0C2EFPn5J?=
 =?us-ascii?Q?H7qVavDWDMRmfTCkGISE5jFsocleDPGi8a88Jp7aVcJhaF9oYcey0ITpoSYL?=
 =?us-ascii?Q?9+eMMEtgJMbWWrlWp/lfHXgwf2UAKTDOqvN5yTJyuvZOdkzj0S2IwGOG8OLv?=
 =?us-ascii?Q?Mi0+GicQhOBYubIXNLHbz0eiCbvXLK3pbt+z/jdARs8qqr98DoBVG8J9Ardz?=
 =?us-ascii?Q?LVhAbnK4cTEL4wq+4egFwN5LIxHYvjGk5aFxxtnoqJclb/BzTJMOqHRJpABY?=
 =?us-ascii?Q?sQ+7TuV2LYLp8jLPqEjke3DJiwX7hFHVRqwHf/hiug/1NM4MVXnu3YaGnLdr?=
 =?us-ascii?Q?+DtDv5Ujw9HUoMcH5FdlCguZbtoN8n60tPtqliD3T+BBIyv69uN9nhtUN8F0?=
 =?us-ascii?Q?tGFCtiS3m0UdOz35xWJMeZ9m97l9+Tlsa2DLqXXVjccuoleNFMzwSeCtpk5Q?=
 =?us-ascii?Q?JKY7sjX6FzIfN55aNQ6rxDS/0HiZ6vgyv8oouEVTRBnavf93TwsE8XbAwWHL?=
 =?us-ascii?Q?f0ICva1YCux6RTaSt/JfPlgyrYuZRimjc2kVQc9pO6WS4LevNTqdxAYHn/7q?=
 =?us-ascii?Q?C626oTjEvjh8YPRB5fzYVV3gm2LClzfDLMskF2Ni4jVGJD36yt+a6lTRTv2V?=
 =?us-ascii?Q?Atjj/F1V3r+Au8jJoHp7mdf6NR4AmgbgpxgqZ+0sFlWD0U6CGdQJpreFDDih?=
 =?us-ascii?Q?sWKvjJxiGMgIfumxqPPoZh1UrWOAjBgdIvanafPRhtCR3AqduS/m3AgQON8F?=
 =?us-ascii?Q?JD8AeEHSzW1e7aY3f60+fQV7fslDrTxJGfBpOr9LgGu2e9Y4DZiefJbCaNvJ?=
 =?us-ascii?Q?MHvuan+c2NPYXKijmF2iGQmxb5aoQnHsBikiPix2?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17d807cd-dd54-448f-2407-08dc7578c998
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2024 07:21:22.1359
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fP3wD5DZK3P+BMF3Lq+K5S7QrtC3uhGs09RleLhIrnmBBpQ/ndq2CWj4yypHQSwZqFqz2Zx7e6tC10dsoYcHgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6778

From: Peng Fan <peng.fan@nxp.com>

i.MX95 Pinctrl is managed by System Control Management Interface(SCMI)
firmware using OEM extensions. No functions, no groups are provided by
the firmware. So add i.MX95 specific properties.

To keep aligned with current i.MX pinctrl bindings, still use "fsl,pins"
for i.MX95.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V1:
 There is already a v6 version for i.MX95 pinctrl with binding got reviewed by
 Rob, https://lore.kernel.org/all/20240513-pinctrl-scmi-oem-v3-v6-1-904975c99cc4@nxp.com/
 But after NXP internal discussion, to keep "fsl,pins" for i.MX95 would make
 it aligned with current i.MX93/8M/7 bindings which people are familiar with,
 and easy to understand.

 Sorry to bring back so late after your reviewing in previous generic binding
 patch. This is not to reject the v6 patch, just wanna to see whether you are
 happy with "fsl,pins" for i.MX95. If people are happy to accept, I will post
 out driver together with this patch in new patchset to reject v6. If people are
 not happy, we could continue with v6.

 v6: https://lore.kernel.org/all/20240513-pinctrl-scmi-oem-v3-v6-0-904975c99cc4@nxp.com/

 Thanks,
 Peng

 .../bindings/firmware/arm,scmi.yaml           |  4 +-
 .../firmware/nxp,imx95-scmi-pinctrl.yaml      | 54 +++++++++++++++++++
 2 files changed, 57 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/firmware/nxp,imx95-scmi-pinctrl.yaml

diff --git a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
index 7de2c29606e5..f7a48b1e9f62 100644
--- a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
+++ b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
@@ -251,7 +251,9 @@ properties:
     type: object
     allOf:
       - $ref: '#/$defs/protocol-node'
-      - $ref: /schemas/pinctrl/pinctrl.yaml
+      - anyOf:
+          - $ref: /schemas/pinctrl/pinctrl.yaml
+          - $ref: /schemas/firmware/nxp,imx95-scmi-pinctrl.yaml
 
     unevaluatedProperties: false
 
diff --git a/Documentation/devicetree/bindings/firmware/nxp,imx95-scmi-pinctrl.yaml b/Documentation/devicetree/bindings/firmware/nxp,imx95-scmi-pinctrl.yaml
new file mode 100644
index 000000000000..3f28c4a171c7
--- /dev/null
+++ b/Documentation/devicetree/bindings/firmware/nxp,imx95-scmi-pinctrl.yaml
@@ -0,0 +1,54 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright 2024 NXP
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/firmware/nxp,imx95-scmi-pinctrl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: i.MX System Control and Management Interface (SCMI) Pinctrl Protocol
+
+maintainers:
+  - Peng Fan <peng.fan@nxp.com>
+
+allOf:
+  - $ref: /schemas/pinctrl/pinctrl.yaml
+
+patternProperties:
+  'grp$':
+    type: object
+    description:
+      Pinctrl node's client devices use subnodes for desired pin configuration.
+      Client device subnodes use below standard properties.
+
+    unevaluatedProperties: false
+
+    properties:
+      fsl,pins:
+        description:
+          each entry consists of 6 integers and represents the mux and config
+          setting for one pin. The first 5 integers <mux_reg conf_reg input_reg
+          mux_val input_val> are specified using a PIN_FUNC_ID macro, which can
+          be found in <arch/arm64/boot/dts/freescale/imx95-pinfunc.h>. The last
+          integer CONFIG is the pad setting value like pull-up on this pin. Please
+          refer to i.MX8M Plus Reference Manual for detailed CONFIG settings.
+        $ref: /schemas/types.yaml#/definitions/uint32-matrix
+        items:
+          items:
+            - description: |
+                "mux_reg" indicates the offset of mux register.
+            - description: |
+                "conf_reg" indicates the offset of pad configuration register.
+            - description: |
+                "input_reg" indicates the offset of select input register.
+            - description: |
+                "mux_val" indicates the mux value to be applied.
+            - description: |
+                "input_val" indicates the select input value to be applied.
+            - description: |
+                "pad_setting" indicates the pad configuration value to be applied.
+
+
+    required:
+      - fsl,pins
+
+additionalProperties: true
-- 
2.37.1



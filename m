Return-Path: <linux-kernel+bounces-287212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64BE29524CE
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 23:30:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D677C1F24271
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 21:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FDED1C7B6D;
	Wed, 14 Aug 2024 21:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="br5H8ZMH"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011028.outbound.protection.outlook.com [52.101.70.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811897346D;
	Wed, 14 Aug 2024 21:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723671022; cv=fail; b=pbGklBF3YIoVSfxb4BdlvkwNzqlXDBMqg3N2gbOJhkL/DeCxCXSagGGecCyE0B1L6g4DIz79J4FZBV7zkk3Tf8kZptA05Fu4J8o4u8gI4G/KQ4V3GpAeDBI2SJrrBzfUv6tIwhqlq1bnXz36wNcVl+nm1g8ahwUixVj5EUMGFX0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723671022; c=relaxed/simple;
	bh=I5mcScewewjBVT7bYRHFYeybCpgmv25/BlTmvFYq0Tg=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=W6lsd4A1jM5jZ3aqmejgH9IDs8hW7+jMkI5OWXOQZqmi87YUfSJMsKeo474y4Nxh+ZE6VsllB6NQ+6KewrFGZv6zfXfi7jOr+VxBGOCFtFMnjlZ01VJ4l8V2BPSj5b6ZvuOQ8/Nv/39N5ZNdpJTFPh4SeZL7FpP7IZUFH1R1qrI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=br5H8ZMH; arc=fail smtp.client-ip=52.101.70.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IVYLs1TrhkI5H+z43XS+Y8i18lU1uD+dT9zKWfdozXONZuQc64bkcy0NmllqdLPsIPca50yfALc6qTEjvZff/+MC164FUWdshFR7fE0bQPry9JuMUKeZQg4j21n+7HOIlWzlmvgQxPRroxFt4EUXc6dyuHDftsllGB3QLJMJlSo5MP8yO6jdpoDoUZeESKotZbyg5Du/fYgqldgjJDbkZZrCYcqqAOsrD8yd2etZBQVTgG+2RRU96r32sC4/w4Y8ZDyqVIfM7Ciu37fnmlKRDxS+pWM99iLRyksDiirub2eo1Uvglz8NWwfIpk7iUq8BfHQPGGX44eBmt8bJKzwcgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UCuFdBBg3yBW+KzCHdczGldYqiV1IacFly2eIvly7pY=;
 b=GyM+NeWYYPecIL5KEk+/j3uHWlE5PkMORg1fFj6O/OAQmSAV0eCvz0g7IY0WcDZSh0uxdOZOTz4Grlw1R9GV37H77150bHmxtrqex3BSW/RPbhh6tWiNB5rFPuJFU02YW3gpiuvnGqEMz6AKkSFEVZk1eiFGt8vYGfmgacgFsiqDVLDRxedHkyKSWWZPmluHpjf8tM74QabTRGiz3Hyj7MewraCWxuGSNREn/E00ZovH4aYjKbhFUXvxX7rh1QvWoRrcOPLSKniGxBDMmGY+suGSaMK3LMDo2+pFaRaO38yoAlnyGX6ga6pFEyC6jiuZWLG1Xi/g8KLgvN7xIg55Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UCuFdBBg3yBW+KzCHdczGldYqiV1IacFly2eIvly7pY=;
 b=br5H8ZMHOUSsbqsTnznKflo2T4vsTy+/q5ZmKkvvmY1uvaQpeWUb7y18znPYW+a2KhLrTOrbSAAKhh5GjQM2Nklv2qpl3yQTntbqORnjTxV4aL2vdtFfE8Ezv6DsddaEJdSrs6y6OrCzTD028JJoilt5fJDuDq/2c9GssCHQy9V2NOPBfIGEupDLhhIBkt7itx9O3JvzozJSJbdB33jzKZCaGGMpc71b1mtRVK6yBUMnkGXXdl1UB82rZap5D8DIQcvsXIa82LTwpT74w7gSiMkGmwTnjFoRHBgssB2uHMQk2cBtwcZaAx2tGp13n2eRgxT0Z42ITXa0l8i8MI6vRQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB8860.eurprd04.prod.outlook.com (2603:10a6:20b:40b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.17; Wed, 14 Aug
 2024 21:30:15 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.7875.016; Wed, 14 Aug 2024
 21:30:14 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Walle <mwalle@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	linux-kernel@vger.kernel.org (open list:MEMORY CONTROLLER DRIVERS),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
Cc: imx@lists.linux.dev
Subject: [PATCH v2 1/1] dt-binding: memory-controllers: fsl,ifc: add compatible string fsl,ifc-nand
Date: Wed, 14 Aug 2024 17:29:57 -0400
Message-Id: <20240814212958.4047882-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0120.namprd05.prod.outlook.com
 (2603:10b6:a03:334::35) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB8860:EE_
X-MS-Office365-Filtering-Correlation-Id: 6893d09f-e8c1-4547-e1c9-08dcbca848cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TSIjJttfaSU4MPgCaYwZ4uJwpA03ROK8S916hj2pL62HdlgEgT9pnETe2SaC?=
 =?us-ascii?Q?TaZN45zjgeZBqksut8Wi4+NDizNickxedXWbikudejsKgCiSyl365kWQ8MIR?=
 =?us-ascii?Q?qze9h2fCDHxvcznU+veCuAgOPhHnyu2E3tWppdAnTigeJQk5fBdk4t75N18M?=
 =?us-ascii?Q?K02lU7MM2x2ftdadB+uiBNGp6Yg2Rq8nJ0+rIyG4BG4qbNcPbx2uH3fdrKPP?=
 =?us-ascii?Q?gtffcXjp0YYFOxaP0aM11+uEjckgxQy2Lisd8iitwNnP6NZQXYwuyEvVfI/S?=
 =?us-ascii?Q?qyhsfZVlfQojB4PDW8sPbvxMmEdAecy3DsKhCmd2Wm42oYBxU16PPZTAlheU?=
 =?us-ascii?Q?kN08FFUUu7j1ZERYO7CybXWHQzxOV3Q8ZbklRth9BWanwF+nkqxlJOhgSqwd?=
 =?us-ascii?Q?P5/h5s8QExj6p8KBQPlJHrw6msqIuega6yrnSIlljysuvOv7rDbfVjV+pEI5?=
 =?us-ascii?Q?fW1tmOM3gNQxw8Ou5aldgDxUKtDrKKFBi9eegwH+AxOhaZXhLRGk0WV5fqzp?=
 =?us-ascii?Q?Bb9dbAjxPbdoKhOdLPKwa/fgy4af+b1wfVp+rx5Q9Ne35EQimfNo6pc1rF4m?=
 =?us-ascii?Q?ypD9IVCbyL6m2VhLE6+4j8RkOLYL3JPEuS1ez8ixETfePUt/gnTnCJq2p/0n?=
 =?us-ascii?Q?U4aWXa0Q+gRtXpgm9aWskncebjkOLFGYHYbTLf2RQV4TzkUuwlR2sNGlPGFR?=
 =?us-ascii?Q?EmemnXznam1M/92b11/ZD4bKlpr+1pL6FqmrTu3KBggD+Dp34Ihg68ZXlYae?=
 =?us-ascii?Q?1rkmP16AiS0pKLmpJV066vO8IJsDOBaIE6um3cfKiAEg6AgJuOnMhYkQ5H20?=
 =?us-ascii?Q?P+I++J2/8JFYl885Xyi3C0g3aU6U7Op3nIUFwOD4FBuoB3l4feEvUHVdA89E?=
 =?us-ascii?Q?Kst1eyvSoAERDWTv8yJNfa2bsEdWFFQyv/58QOSTUcmryTKuWgRJ8n8nP7Mf?=
 =?us-ascii?Q?3jvZ5zas4n++iowJR2AL0lwK8qO6zJn/qfPxpXXri52C3HDOiX5sOQiWGzqF?=
 =?us-ascii?Q?CLmAztkZoJ5k6qYMslEn46/QG+3qrYbFZ5+UeFcLaTvOCjrwJQ5luSEVIHfx?=
 =?us-ascii?Q?PMOiDxCpp8FI3FVhzb209wJgqwGP1XPEbB60CnmGQedcEILgViDxrlQTef2i?=
 =?us-ascii?Q?P1Cj42CmFL5HTrxP68VLTraqSq0wz/rCH9U4cd+FLkfznK3+ISCH85r4PdPk?=
 =?us-ascii?Q?quk5tlz9esojRZ5zsV3Et+XZ38oOAz3rlSKH4ZCCuJREr8qR491NI7Fz9Pf1?=
 =?us-ascii?Q?OvDQhwVsUVXGdxfoyxP3C3hi9qB3UuALSBjPPoAw5UL0UphCP8sGi91JxfMz?=
 =?us-ascii?Q?EpKQRpEnHfdkOONd+rwrjSLtUCX6Mm8EzyomScNbqUFSmbM7ILTj3gMkvItl?=
 =?us-ascii?Q?F1Cm1Dc7p+q1uEACCEZlWWVEzVXDTJpfVLh2JwBUyko6Zycgag=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oVoA317Mtc1XXW8Tlp2Iy2IuM/qyZha1k4BMSEbSl3gPfO207yZdtbJPpK8p?=
 =?us-ascii?Q?Z/4ghXRRyNgoHCbievks0dS3LJKdzUk+1LSl25K04pHGf0dYlUtGK8CmF0wh?=
 =?us-ascii?Q?+6H2Sa9h160L9Ro6hrFh/5HeYLk04XANxX+DMj808VpYhTUtgQ9IkT5kV0qC?=
 =?us-ascii?Q?rhVXAkv5Xwmc2q/sCAJxuKlfd9sxGFWiqAEilWFlJ/qt0IntHnfx9W15qRUD?=
 =?us-ascii?Q?mnPuNQNZOj3O5nFhoBg4Weuhp1ZhWBf59JbA7oUAYj6CXiTTo+LZSnmBUdMU?=
 =?us-ascii?Q?Xq74bE6rz5iEtd2ld1CapffAnwo0rIRUyMsqN7/7GluQCvvQ3dX56h+3FTmh?=
 =?us-ascii?Q?P4RbnU3AVMAGOFuElsXwSb9kS7dFBuBPFsvDcE4yesEPGJ2JJxKUu4uYUBPU?=
 =?us-ascii?Q?MjvMPZte3oVj8TG83AvzyBrKE6AuxpKJWkOPUCTRrK4rZhkXvVol6tn4NRde?=
 =?us-ascii?Q?eouISXOSQ6FZ/BFp/KWyRvjIeAz7QAYoTFd9cfS/4jDVLt16y9g5m3v44rm+?=
 =?us-ascii?Q?cyp5CpG55yYxnJyteq7tMYCNIqKylEjzTmTQuTtjfgfWvb+Eno8iTWjidRYt?=
 =?us-ascii?Q?aNIo++fBGjAZEHX2flK1PFzPxPIKHQadwtf9+eWXsDg0GBTWt0OLCkpdL37G?=
 =?us-ascii?Q?nzElW6bu37Hm7eB4gqHr4LLAgD0VSv+Nz93jKIGNXLjnzab9TXAa/evQvpw+?=
 =?us-ascii?Q?SuzGp+bAci70IvuRFfMtM/cNl5nrGfI0Kk3FTx0KhIC/Dzfggvth4REIi8xg?=
 =?us-ascii?Q?zfyqtd+nxO7tDSyHv3w2ETY3WI3F9fxiWzxFr+FxEKEj2cFVPRVRwvcf9XSt?=
 =?us-ascii?Q?n5so9YcV94STcA4fz+r2vw92iBkLYl8tqQZuf+SiOB/7yc8TbLC/Jtxmdm0j?=
 =?us-ascii?Q?NivjOfETKEm5/A7YLwFsyaNVvtcPFE/AVc0RAKJS7virRHryo6BO3f9+o4Bf?=
 =?us-ascii?Q?66j/YpBpi++OFtrOYGCyAmWqI/9GtrAdoPVwuve4Q3cylivsABqWgrG4643O?=
 =?us-ascii?Q?IhBdyR2pMk4/Njqfvj4GkCMabbgc1wRI2mrqUN2Ul37QqvuosxAwN+6waXuC?=
 =?us-ascii?Q?UD4Rzc7hli2Azo3Q+Qba6WULFPOwq8vxXEkUOzy9kfMLzsWVU5STNdlsSOHC?=
 =?us-ascii?Q?N9xUpDNgedyM4T5fbIvI57bO+ODyw212qlgJLk8zI0w91Csu+F1MZsFAo85+?=
 =?us-ascii?Q?nwaSE1ZX3oTW7TPjKgFhDPOliyX0CvmMicfNEj74j9Qy6cde/uo/FxZj0mD0?=
 =?us-ascii?Q?qxIog1M3lQcfB9bxmWq4T/EeKJ0CTSoF1MfZ7yKhxbUtBs5KKmCvN5BGcgMN?=
 =?us-ascii?Q?Mvm6QQ85YCp6wZaTZHCtxSsFTleFS9tn+xRPMhzxGXTJ/B+stHvF+P1MFAT0?=
 =?us-ascii?Q?6Va+cTb4uOvdIdnc6jVUGhTg0qr9BYTqlYBhGC+Ydck3qhgZFrLQW2T4xxgr?=
 =?us-ascii?Q?bAAwIqEFQuA7de+jE503DAg5HJfPgnNNbnhtqiUVnys6O9e0jrnNl16tq5M/?=
 =?us-ascii?Q?WXN0emCfcx7PIQb3DbklhCog5DpjFtV3Fzps2GOHvce65AyTbXzb+PSAFXoR?=
 =?us-ascii?Q?CdJqrWXtpKEiGTk8nSE=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6893d09f-e8c1-4547-e1c9-08dcbca848cf
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 21:30:14.3486
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yjKRFd3WkuyAI8jGeyRg2id4MUVHL5ikqslcs22T5bHRIFuzJB2G2Z+R3ePcjGdUE5aTkidMk6Yzz3TYvclXvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8860

ifc can connect nor, nand and fpag. Add child node "nand@" under fsl,ifc
and compatible string "fsl,ifc-nand" when ifc connect to nand flash.

Fix below warning:
arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dtb: /soc/memory-controller@1530000/nand@1,0:
	failed to match any schema with compatible: ['fsl,ifc-nand']

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v1 to v2
- add address-cells and size-cells
---
 .../memory-controllers/fsl/fsl,ifc.yaml       | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/Documentation/devicetree/bindings/memory-controllers/fsl/fsl,ifc.yaml b/Documentation/devicetree/bindings/memory-controllers/fsl/fsl,ifc.yaml
index d1c3421bee107..c12bb7f51db62 100644
--- a/Documentation/devicetree/bindings/memory-controllers/fsl/fsl,ifc.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/fsl/fsl,ifc.yaml
@@ -58,6 +58,27 @@ properties:
       access window as configured.
 
 patternProperties:
+  "^nand@[a-f0-9]+(,[a-f0-9]+)+$":
+    type: object
+    properties:
+      compatible:
+        const: fsl,ifc-nand
+
+      reg:
+        maxItems: 1
+
+      "#address-cells":
+        const: 1
+
+      "#size-cells":
+        const: 1
+
+    required:
+      - compatible
+      - reg
+
+    additionalProperties: false
+
   "^.*@[a-f0-9]+(,[a-f0-9]+)+$":
     type: object
     description: |
-- 
2.34.1



Return-Path: <linux-kernel+bounces-552043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED71BA574A6
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 23:07:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FBEE3AEEDB
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 22:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7A9325A323;
	Fri,  7 Mar 2025 22:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="VYGluy/s"
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013013.outbound.protection.outlook.com [40.107.162.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27ACF256C90;
	Fri,  7 Mar 2025 22:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741385137; cv=fail; b=gri/YOnMHZufUXJCnbZscBxv+sl4eDsq1iad0n9B1MTTVVjRk7goGCkCUfOhH5NV9SaC84MWn1vtxMWv9C4BN4fo79FvRS9afSt6GDny7BYwD7KjAM+VoxnafScK1bBNcCkTKZyu6EFOP90Tzy3ttfahAOQiE+oslu93euMvw9g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741385137; c=relaxed/simple;
	bh=egf5GFTOlcfXaoiezUT4oMsR18TrYPYfzi7q90G0ZDw=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=rFxx/t8o3l3f8M5trw4SFegTAX5kkSesjwsP9Mem8YbhMahM4P48EpeIBg19/uom21lUYMtJaqSZBLIV89KVAouErrDej6aAWMaWw1+JWoruqRqG5LZkThfmcWftcSoyPpoSpIbTsDdN8kPFbEuXx0GBr4CVwyp/D4bGCEwLYvo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=VYGluy/s; arc=fail smtp.client-ip=40.107.162.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VOoDviyTzMVAg5/gNyApmsvws4TIyJZTUtJrUyYAQWDoakOVMIDbuiKasz4FzYmoyiEhCvCfOEls53lgQbIp5qnSgmVkxftWHuwSl8Oj5lsNgv0qBzTOLqgHddgYjOEgqZSajMfkyyLnWAWQl8zOYSu0clEMisjfNHK+DseQYy3t6Qg+Fx3m6f/Mf8HyBwaJeK7JI/1U9myU8w0iy3yEH+ivBfhnwRV14OYCX7qDxUHoUBTMZBXoJ+wtk4ZgDuqi4D4qauYhvqnBAqRuQNZasGHiac0ck5i/hkWvxfcPN2X//jxONuycozEMC16/BSh1TDD5k9Vg6CtzLM50D1KH7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EMvy/g0U9h6ZdSmXeaTPa0Ycyw7HCboGj7zJB41RsfM=;
 b=h5QbXECcNry+NoMLIrUUrkTM/n6UlI1Ev8cbPb7isReXtIEfbS9zc1VxCJrZ7j9Y2+MxvH+VOWMAaoIMwwOMaIuTh2b8WsE/wxBaQUFL5r+PSpxmKlJ7hPfPwGUGWTyMU9u0chmfCFn/g2pKhFYHv6inFlEdd86XHnUJZDGbcmHn++EJIQssDvTvmzJ9+9R+Q1YlHKz1R9VAkuqXdZaAeL34tW4Z3AmgVkAqBTdLgt5h/VhiYroDc0LwMqpTMorkYj2ZfiUGu3w9sMeBmyGrLiZQ5NM+SePr/gwz84T95JUXDfFFo0VcqYLIqltKHeMcJXtR9SSkGAdPY5eHarmKLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EMvy/g0U9h6ZdSmXeaTPa0Ycyw7HCboGj7zJB41RsfM=;
 b=VYGluy/sYuodHzlOVK7ghDdCmM5d+FN+xvVmPRfuQiC3xl0Tj1q21s+S1GDvg+C6DXH7ebbup4cJVibS1blXS+dj88Xs2PHwW/5LkczAAVuvflEgYQb3hJyufkRkIKWllSyVA6lFXa+M1INTfeL+sJ0d5cA4XpSgqKFOBbKkO8OeXjxIVn4jozR0nU7K7WoTCvgSpu9SH3QfX1aXm67Qm90Wv3bcsR9apoGEONT+uWxOy5wChAnqGXZd5LZShhpEzaOQGYKgWKSLw7v12mcSFvefJsuNhhRgklmkyxgAMdCvfWr5tyr9omvidfzfyIaYTZFySrpjNdRzfayFwj9Ixg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB7639.eurprd04.prod.outlook.com (2603:10a6:20b:23e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.22; Fri, 7 Mar
 2025 22:05:32 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%6]) with mapi id 15.20.8511.017; Fri, 7 Mar 2025
 22:05:32 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Han Xu <han.xu@nxp.com>,
	linux-mtd@lists.infradead.org (open list:MEMORY TECHNOLOGY DEVICES (MTD)),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH] dt-bindings: mtd: gpmi-nand: Add compatible string for i.MX8 chips
Date: Fri,  7 Mar 2025 17:05:15 -0500
Message-Id: <20250307220515.3282954-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0099.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::40) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB7639:EE_
X-MS-Office365-Filtering-Correlation-Id: dce5f8f8-c0cc-424f-17fb-08dd5dc42db4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|7416014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YgL4bNkU2cEqzbJTrYVQSiIB4xC2VStgAiS7fVNI5W+80fckhOSMmz+5vxh/?=
 =?us-ascii?Q?uPdufcQ20JzihDN/q3XDjjRvFjpEvOHsWJjxQdhTzJpSfriTgi7VGmq8IG4p?=
 =?us-ascii?Q?8JWdxxZ8PHdKAw/aBxhZ0JGfPdQ0glo9XXfAVbJbmZysJupvQB/jfoypVOMU?=
 =?us-ascii?Q?VeFKguPUED+9tnWh8UgTN98FVzu9fE6KAdACeRbKOTymRPwsCC/9EbbtvWNz?=
 =?us-ascii?Q?303DHPzD3EZBUkAlT9sND7jAZQZI1zvD/HNFnClqYHEichJNp2vjE8U7FmHr?=
 =?us-ascii?Q?2MV6xdoYcYbIW3gwKoYPCUtPe1swoZ3ePiDpetKCdzHF5OVnmtRFKf2Lib9E?=
 =?us-ascii?Q?ZCTnSrhCqmJNnyWpN68LjVmwl8zJF0J9Dhuz0DOOgldKveLu0BIn7bODrbUD?=
 =?us-ascii?Q?SlQlHOL1wVQg/klkg/Zzkc453zSl4j76GrDd5gcuXJCvvkCXuU7FWE64O2L8?=
 =?us-ascii?Q?MtDDvQRoPp8rqSKOgXd99x6ebAkDUyuiqcuoO7J5IXAaSR71nK7X358phFOl?=
 =?us-ascii?Q?il4hzdZkrcBO8Ri8aZShTFGNOJtj+5zxpmlGC1sHicUIB3lhNjYX9xHOUq7P?=
 =?us-ascii?Q?nl2Q5MwqgVP/GRw8AQtikw7Jg4vbqzmCPE+KEMvSZXfNtiUBLOI/BDqzRdZG?=
 =?us-ascii?Q?l5cTxEtPlkJkTdYtr1BcrG/XNCM0r+FzRyFVq3S1//SuOLQ5m3cJPAxBWxnI?=
 =?us-ascii?Q?RG3ia6rvtzM/rUWa079V7lKYxitWPBJtGy+wuHHoiakkCScOE89sMTOqpSr6?=
 =?us-ascii?Q?z5nQx9kciTrde5j6QsnsR8OzLa5Z0/j0z4qMmC1PkOfSDexMN+Sax0JZgpw7?=
 =?us-ascii?Q?CXfFdAVFi5eWDo7I6jw0kwUv2oMZZdfBfyO4OAWZmN/IK8ezCrQU5n8bnwZq?=
 =?us-ascii?Q?0Rreae1CrS7JxDV9lQA0MrXphNwOzG8yOEap7MCFrRhRKsIa1b0Dpm4zCIuH?=
 =?us-ascii?Q?q3r/y5719d8q+s96nCFSGgDKYVOJnyDo5HLD20aBDBf2BirpPHa1e+Z51pk/?=
 =?us-ascii?Q?azxeyBWphp2G176Rj7JrvctDbnZO4B+vSyK7s6AKE0aj1P1PKgV8njcYcKSD?=
 =?us-ascii?Q?I+/YKpPyHm0nUSgDwIRM4q01rKJv1D93QBYRgIXdsm4m4s6LYpl+j/b4nm+s?=
 =?us-ascii?Q?GgjuAiu4KTBCAb/syrhm2KSI9lsyV19yg96uewJO1zCvoy4yizl32sulPweq?=
 =?us-ascii?Q?5ylvESb4T3koYcrFoqj4eh4WSn6mHueuGnKr+85gM+eNBi3JHNa9F2L/Tygy?=
 =?us-ascii?Q?aIb7JQme3S0GDIhjmLLQsHbNfgAZk7HkzOdDRrxLdE+qhKdhOfIJ1iJby325?=
 =?us-ascii?Q?6bqNI8mNdHI/QFZBPM/wF6iV3CZXzECcMIVlZWIc3ATGljEsAUhUOlQAkB8j?=
 =?us-ascii?Q?rU8ySlWi9G3qWiOXEZtedsoEkoy0F1eh9Cjb4Pdu0AEaZ6b0OjfoJ+VsJY7v?=
 =?us-ascii?Q?KNeVsz/uCNAzyW+i+OykoN4wYaoCJ7Kex4XdUu3y4rV2A47mVEztmA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(7416014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?I8urlLx1p9m3xtWThWIDJ0sBJPlK1cWcZlcScv6JwMilo60QfhJJuRXXn9yF?=
 =?us-ascii?Q?KjsFfyMmTIts4p/ESc7kJ79ig940qE5IoHD6/w0+++Ke1j7OM/KCEyheS1VQ?=
 =?us-ascii?Q?wJzjJRR9noCsT1FEtu2V/zFhh2QHZpSfnnjRcivDwDKfBlfVDDy9ZwsJLHNP?=
 =?us-ascii?Q?/B59hWhmACMMgW95Y8laZyemwj5XiFZq0TxSKKk2kKFx9cvgFFHUi2n2PT13?=
 =?us-ascii?Q?PtbgpSdhpbUHFfTimiswK7/Vw+YZ9eb2ZUQybZIcY4cWZ52HFI4lPLfsfNBm?=
 =?us-ascii?Q?OhSYkanaDRiXFJ1p9luSIXtPW5sS7zBF0ng+M1rmKFQiJWCVhppEdDltBFqH?=
 =?us-ascii?Q?kDohGT+vAd13yZKtL5nxcjXh2cKnWVTym1f8pR1lqEHsxiv8bdCkdZGvaRcs?=
 =?us-ascii?Q?2Nt02547FvALKjvnlvAgxwYJALw4GGLt+BfBUWaX9Gv46gvNnELXY+83IdPZ?=
 =?us-ascii?Q?pGvX8iZLIiNTe2o9Mt4cLazsOTFgE2nGWp4dnpkauYsbzpGBKzeZB5ucDbmO?=
 =?us-ascii?Q?lhSL1QKyqnX3tJgFjATgOfWJS4BOh0RFTH+fIEx3wS2t3Z3HB/Edgc0i5AHf?=
 =?us-ascii?Q?rO/qEYbjf+0yt950DLdSMw2NHou71/8u3njLnL4QuAHS8ks3lgNUIOcsGdZP?=
 =?us-ascii?Q?Rlc9JWhz0wbV7kEFs3aW1cs77c8a1647+00UM/XUPsYYHGt6GUCEIHKNYEZb?=
 =?us-ascii?Q?gSxukXQf0Yo4Zs+rxtfW74MCPeBC8eMbI73AZda1a82elO2hMMoAhKEsfNpk?=
 =?us-ascii?Q?Qk7rbghCT/T5i+nRtmmPTKam7EBw4wmZObdPRsrPhiy5pEhHKGAuUYuRnkKj?=
 =?us-ascii?Q?f9HLuBMypPPjKKytMjKEyBUat3Nz7gTUY1M0O53si2OVM3v6Cg1yZa1utxdI?=
 =?us-ascii?Q?MvlGeUphN4dL2XvUbbO7XFC5RDfON23q5feoMrrXDi+p539h5cP4DEVjGdOF?=
 =?us-ascii?Q?IN1byXjRih30dIua7gBANhhsaJ1VHnedzIPpgSoRJtGMaVwUqqI+PsbKgr4Y?=
 =?us-ascii?Q?SSuxCOixI3zHmFC4nAkVwuss7skaxXdmITQQfXK5eZ8m4hUipIoLK3rXYAKe?=
 =?us-ascii?Q?6sIwC0kFKYUdwl1cDLZUvTFp+x6XFdMTbGqKlnm3a4pEaL8QjTnxJt+LnosB?=
 =?us-ascii?Q?O/t8+0ERVajCE8B2RDNvi/ErzUYvzfR6z2PbI6AeoqymLriscQOvYISwPhod?=
 =?us-ascii?Q?xtOzSZl+FTmBuKDvGFb02be0XP8pUK6q1sN+BDgZDNXNxji1C3LUsO/JvmCC?=
 =?us-ascii?Q?wGmx8u1A18sD17QrhyoHxUZyykQrrIXze8Em+kUUjBVCQyetaZHTVyyHtChy?=
 =?us-ascii?Q?FpWo7jBj9iTmA440fQNhQFbaebBxGI3+nrk1SxCoq38tsLofI3n0ZLYf21d+?=
 =?us-ascii?Q?aeVl2dsiKEYDlWr+YyDP0k5oV7Y2z6YFFyFsQEE2HcJhCUhzo20Ji40PEF1w?=
 =?us-ascii?Q?/iJ6lWJzBWoXYVdcwtE4DwTJqrK3H/aaBWRn4anb/x2T3cgwkNX3vpJoingu?=
 =?us-ascii?Q?145P/gVX+uTfZ+j4qZpVL2kCX0o20DIaU0YetoE+8F9R96V4RIbHUP6oMWQu?=
 =?us-ascii?Q?3301n+2XjX26FzUsIEtJGw4m2G30dtGFdcMEY1sV?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dce5f8f8-c0cc-424f-17fb-08dd5dc42db4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 22:05:32.1564
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xn294xnv8F343R8cnEJ1ur1w92yijR4teplZosq05nwIlRPuuOBhoVM2YM0Z3EHbdYhd4xup7uLGzK2fI6O1gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7639

Add compatible string "fsl,imx8mp-gpmi-nand" and "fsl,imx8mq-gpmi-nand",
which back compatible with i.MX7D. So set these fall back to
"fsl,imx7d-gpmi-nand".

Add compatible string "fsl,imx8qm-gpmi-nand" and "fsl,imx8dxl-gpmi-nand",
which back compatible with i.MX8QXP. So set these fall back to
"fsl,imx8qxp-gpmi-nand".

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 Documentation/devicetree/bindings/mtd/gpmi-nand.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/mtd/gpmi-nand.yaml b/Documentation/devicetree/bindings/mtd/gpmi-nand.yaml
index f9eb1868ca1f4..0badb2e978c74 100644
--- a/Documentation/devicetree/bindings/mtd/gpmi-nand.yaml
+++ b/Documentation/devicetree/bindings/mtd/gpmi-nand.yaml
@@ -29,7 +29,14 @@ properties:
           - enum:
               - fsl,imx8mm-gpmi-nand
               - fsl,imx8mn-gpmi-nand
+              - fsl,imx8mp-gpmi-nand
+              - fsl,imx8mq-gpmi-nand
           - const: fsl,imx7d-gpmi-nand
+      - items:
+          - enum:
+              - fsl,imx8dxl-gpmi-nand
+              - fsl,imx8qm-gpmi-nand
+          - const: fsl,imx8qxp-gpmi-nand
 
   reg:
     items:
-- 
2.34.1



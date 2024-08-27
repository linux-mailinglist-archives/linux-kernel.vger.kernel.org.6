Return-Path: <linux-kernel+bounces-303859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6C64961632
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 20:00:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CEFA28229F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 18:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0F6F1D278A;
	Tue, 27 Aug 2024 18:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="lYn7yEpp"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011043.outbound.protection.outlook.com [52.101.70.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980D0199BC;
	Tue, 27 Aug 2024 18:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724781650; cv=fail; b=KB6A/ghu4SASyYYG07YIuJUk47pqw3i0+MLLl5hYY2S4TVVVr07I4/Ni+kwqs7SeAbFmZJjS3DzWeFisYkllbU4ng6qdw6UVpfntDf9xl+kAMLVyZd2PFOU0wgUEwVV8b2LZLMWfy8dfSxtXNIvVoIYnA1FrwQPjzcUZlO2M3o8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724781650; c=relaxed/simple;
	bh=AsP5i2ZTn7ds0GxDloOYvf1bPfgmLdEXbR4Vp3tXr2s=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=rqwqdN/0RFaDu/m4affE0p+9DXML7qcLq90rtuger6Snt/IXVqoW7q/hKPubh9853d7uozwTxLy1jhWJUWv3StCOuF+u3pd5S5IduCTp3fZ/4rRJEy+DDmslPj77QdIQd/TBLSXX6PWMabmUCSAjKwl7RmeDej3lvmnMinkYqhY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=lYn7yEpp; arc=fail smtp.client-ip=52.101.70.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BFiQEnMetpF6B6+RZAt1fHT6ofty4RV1f6saYPUfkxIaa9EjUkUp/z9ghaoZJ7bN/izaiz/zDnFPbQ6XfnPj0GuUvT/tOOaHTiIOLY2m/Xaos6Dl27a+JALKurXBwiGF4k7nV8pPvOUJfy4NylzxPkqYC4ABILWKizBa8RwNKWFq1HPj3VbRet3rDu6xFxHAGhBQiwbEjxe29H9bKsHE6/xvfAX+4QtYXtX5tT1Lv62RwqB+I1aNmGT9sJcRhEyPFy3IPRrflq0VE3GR7hjt7YzAueWNROCSrV0hTw6ZGqkbW53w2X2/Xm13CiX1lnx1+e6t+OdUpF8QNd1VwajjgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bx2rE0nrbu8JdUVkO6cpn4EtdcvDpmVomzSsZnaPbbA=;
 b=IdGdgZUp6A+1CunfAbmBWDfwC9DpBETG2gekAv58/SIUqYOOPvnJ7/PMnebJvUspNKoEQg5WDEsF+DTVJyGTK9vo2YyqOdnBKa45jEz36+pxdoWWAjBsVE929HkSSJ0dJoKZz2KGkS2C/BgwqSffIUkc77MqlHpGuPy3OiFSXYbIKwXJvAPKYIlm6P/uQkmhHx+o3Md6fY10QOCaMr02i3nTKVtGsIvnyOf4b6CgdzxV6zsE0Dkwir80CxBarJQn7Nyh4f5tEOIFjJ2uAVeS+vFppQiC9Rd/WyFxsamWsf0HBEVTYCN8XhUc+ktc+FkenUx83/wkLgp4jx8JZ4xPsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bx2rE0nrbu8JdUVkO6cpn4EtdcvDpmVomzSsZnaPbbA=;
 b=lYn7yEppXJWR9Bm03m5P0tfVqkZ/yUmad/uQHRIqZ1TMCD1YUbGAV8V/O80pqCTkZE1DN+iyA+kptkUUnljgNJ1dA9fC228y83MSYUUuncKfeC5PDkKOpqDwciZFVrjVtIoie+ryNDTIHgNN+uHImUQlxtMRL4jKkdUjJCnOKOpZCqyNzKhE7SrUr6tzt3FbVgE5JrllpH8+GHTYLnqVV73DLpX6R8v8V+00Od7Q6bdHwDiXDIHR9qEtqDsSL+s6V3b5RAcvgOLkVQWE7mkKk5zr1wPMBV3dC/rAUnw+wN2MkgXBG/cOmPFnywf1qp190tvBp09dZZ8StL7f037dfg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU0PR04MB9249.eurprd04.prod.outlook.com (2603:10a6:10:350::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Tue, 27 Aug
 2024 18:00:44 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7875.019; Tue, 27 Aug 2024
 18:00:43 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH 1/1] dt-bindings: misc: fsl,qoriq-mc: remove ref for msi-parent
Date: Tue, 27 Aug 2024 14:00:25 -0400
Message-Id: <20240827180028.1009902-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0250.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::15) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU0PR04MB9249:EE_
X-MS-Office365-Filtering-Correlation-Id: ec6ea497-f341-4579-dc11-08dcc6c22b79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?knbiwk2ZViF7SWf4+/d5RTyIT4KmEVEqQ3dudJOfa/Epa+xB5c67t/w0LREY?=
 =?us-ascii?Q?D8qKmyF4Bu130JCB10LOmf3dPN3GE7g8ar40GGdb6TaJLuioHGlh/B2cwGWa?=
 =?us-ascii?Q?2vtAmWG7gnK1qTmSUJtCeTPkR3QHY/HN8iokeTvAk4PKiiuaEf5jEdLdhDDM?=
 =?us-ascii?Q?grE1d6ZPxoi3O0xjkGIu5Zebi6SObHrS+u7Oiz7VI+MvBEL441gAeil3xnWF?=
 =?us-ascii?Q?MJmyvX12yWBusmAebjhHgU/VKgjXeZF7JzQMkDeMMuA4owxvH5m223D7ms5x?=
 =?us-ascii?Q?O/zdE02z7h0LEfWKVZskWoNbyzWymtUtY3XoPmtZ7gTaSx+vtPUEVjSc3+Td?=
 =?us-ascii?Q?6Frtjs0brqFNNgHai5mrBqqF2iAfiU4f93l0HS18ucnCMd2ACyZkY5SyrjhE?=
 =?us-ascii?Q?x+Gq4cDo7BqQ4YMtagJULnd9987kwnSMP7889VhYRS1copUrJgVRZDR+cpYX?=
 =?us-ascii?Q?Vbcdx8FSUkIuxX1Ha1wJSDjRp8fBttHf10zjoXgqJ0OEbtZXYbjSvAI3ZgVQ?=
 =?us-ascii?Q?RKoeRRVFNPV/bAnriVacKdPJwiyx8tA4LgDUMO3jt4mBWJHZIJBjrr9FzbhQ?=
 =?us-ascii?Q?jqDZFulmwxWqrZuXwuw8pbcG50bBXjftqqAz2+0nEWRp9m3c9kTqvZ/wrYsu?=
 =?us-ascii?Q?0yZb0QtqT3z0PlCGX3x2+ew/0lP3+HyQRIlspyQqE7L9ybTFIwWLz7jqzQMx?=
 =?us-ascii?Q?ZvuRslGiURheI2F8Ut4JGbfke+bL0gprQcTdNmw0EkkOioGgXP/zXTAv8Br6?=
 =?us-ascii?Q?7kgFm2xQRHXZZrZ95708EJt4a1ZzlNE9IPDsAzb8WFHTCvJlb5X9S/OthmWu?=
 =?us-ascii?Q?mVQzPNLhXweECQfhUGsD+QpxSBBzmnRdV5gKIfSPCupYorKqXPyFJErtIxzN?=
 =?us-ascii?Q?/UIIJSPLsEY4BlB4jkW9udlt0RtFaOnVw5m2rFFehK+XqGrRgkTAsIVJD/0t?=
 =?us-ascii?Q?WcAyqvsHF+gHJPQDwfvPTIHYyZg3MV7dfa8rbDXQfLu5bPX5ws8q6iX7IPK3?=
 =?us-ascii?Q?7ceIsTgghxW1nTXIHY7UKXSKH5l7yCS4fhlpr9hchb+zzZBuKKyNmMQduxHh?=
 =?us-ascii?Q?xpKJBprRTzVNa+Ug5aaM2JHNYxP+U+tAgbulXSzHEx9JaDC40oQymhYhTCmv?=
 =?us-ascii?Q?IzY8O29cXofYil+IqmXUa65KyxG7Fk9QXnCs+mkmuHy6lGNIEAJc8xMtALbn?=
 =?us-ascii?Q?/3/8kQqOyXIUXnfa23hnB10/xOcyVgAmT8/+Ea7yyOAOZbHYnsJhK1cXF+Tu?=
 =?us-ascii?Q?ZGYoTfmvn8uLQJQPqHR60n4Lh6H+0ktMfL1CDT+K1GFTpkOv1/yrV73hZMVe?=
 =?us-ascii?Q?v+kSPs0BhL4y+31JBKQf1WwSDN4/VhxqtYb4dfuZZuRrEfH2GnZchxs2lyjk?=
 =?us-ascii?Q?gqzCRyVBYi2i5jrjxefV/uPTWBczdj6oMRWsdylAjdoRYMwXlw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?X1vpNOOVLmQWP/MShNw1UBbBsaf3p4rhSEZZP2m1s2DCZrdwGWbXGuG8tvOZ?=
 =?us-ascii?Q?89RoCJnOOAZC7IfreZSUw+AZ1M3tgXNILPbEVACGcuEG7cM0boGK0Ld9ISDX?=
 =?us-ascii?Q?NK1NoDKKipV57k8Lnugu/+0k0Irq5+coMaIMUqwiR4GEAi5qPthhU1oNL+B+?=
 =?us-ascii?Q?M6kpdTnezjRL9M/Ql4CYip6KbjAchKGfC4jjkHgoX4OyOhAB50fCXYDrRt2c?=
 =?us-ascii?Q?G6sLH/IWKdk0/WjUq2PRpsBSYjBTyqy22xh0iWxyHCXLKAELFD3X7Qll0MA7?=
 =?us-ascii?Q?yh9j1Wy4/u893xSX+GvsKlp7J3GCcI40Kh8XhDQz6WhDGkPDqQm2o8/aRQbf?=
 =?us-ascii?Q?iJ085XwZzjE08a8KJHPfcp2mE/tuEH3zcKrNSvBgHoBnV1LRWIfAxb5TVJYT?=
 =?us-ascii?Q?iL9sPOItl+bGDa893M3n2REv9/1Mozvv1xZ1ivnrG7bHasBbiKxKIuWA57vR?=
 =?us-ascii?Q?hGV46HPEgXn1D1vubGNDGZb+s6AAxD92ZTvBxES6oQESNQAsbbBxTxWRRlZy?=
 =?us-ascii?Q?GMdo5GtOKnmfBODPrwtAchhvNejGJdxZhhRmepK6qN0PocAyVyQxhh8tCEv9?=
 =?us-ascii?Q?IfRkYg9lTrxMnx1G9MYzc5fwLAGTcJZ0WZe8ZQ8iLAzFK8jjBPkCzpn6C2LB?=
 =?us-ascii?Q?/w8/fDwXgfy/rkt3doSyVU5zl/O58ciCtwMlzDSPxlkkxNQl1Vep7IriDxuo?=
 =?us-ascii?Q?T03QVP2LFniTtdnmHfgWbeWTlPSkRkceRZaSVyAkQfaOx4oj9FZugLbQ3r0S?=
 =?us-ascii?Q?XJdZRmC3mgGbv9UU/faYjNTagoJ+cG58ByU+UjIf8+4hJAJbuY5wauL5zqun?=
 =?us-ascii?Q?gseS3mIhTOjyZlH0bQAi4SevLClzuYhjLb991rLN7E9ijcdNHtbH4Iur/jjr?=
 =?us-ascii?Q?eR/HO3pPkNvB+6iwS856NvXBJaoUo3obEiBi3BqAYSMNioUogJgdpnfkO0HJ?=
 =?us-ascii?Q?4nD1dHDhRgAfyRY5uGzGWEPd/RX+dzQgDXM/g29tVGpfoDJQaRq6SO8ackbj?=
 =?us-ascii?Q?+BRzPR8acn5d8cIUpM7Vw6tXByRoxnjKdqDWlvsnEqJ6xlcXWD1aXOq31APi?=
 =?us-ascii?Q?5DwE9Qfp84QmkO8EzgG4JWMq4LeuEXEx2t/x2pbB+DDj0iXsi5R5l8lz8iSk?=
 =?us-ascii?Q?DN3p7omDVjbfS97EQjIVKkQXdKGQXSIaW/LUleDll7JQFZYHhh8Y+jiFg6oA?=
 =?us-ascii?Q?MjCDZz5rN+L58ihKyAigTlPtnlhZgKH3q9vE6rb22eWlbH1MZcGnHV86LP7p?=
 =?us-ascii?Q?yBHFyI0Bt+yeKqS70QRVWN+oWGFEO9omBtTYcK/cDtDihRz4xCLtiKJSyvuK?=
 =?us-ascii?Q?nNbpqulR+RDtuX4KxlY2l9Q2niiNJTwkZu7tiIIhXvj44nd2NVrvDUK337DH?=
 =?us-ascii?Q?ZU5AnrIUsbwR6jQPuH+8CWz9xgZ8GDGRGmy5ZcspAkqjyMF/D4Z4zi4hwP1i?=
 =?us-ascii?Q?6HIAqF6SknSEHHMb6N5oHcv431owUuor5xWUOcv4lO7FKtkKOoHVZnNfAgXt?=
 =?us-ascii?Q?tP8GZt1kgoYEM5Lh8T/yfmsNKTFlBfIiX4bRupLRTbHXjBtljoas5p2t1KSK?=
 =?us-ascii?Q?QXXD8JT4rOpwPi3cUDgs7kK1ysnfdOLcQl6EmhY/?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec6ea497-f341-4579-dc11-08dcc6c22b79
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 18:00:43.8438
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r+K7WmIi3yio5WbZfgNhJwlOPdAorWpVRvRTcmr9POFESmhPqIBuws9nprX79Ek/Y1pbPzJDKq8xVvHu0nmMlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9249

msi-parent is standard property. Needn't ref to phandle.
Fix below warning:
  arch/arm64/boot/dts/freescale/fsl-ls1088a-ten64.dtb: fsl-mc@80c000000: msi-parent:0: [16, 0] is too long

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 Documentation/devicetree/bindings/misc/fsl,qoriq-mc.yaml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/misc/fsl,qoriq-mc.yaml b/Documentation/devicetree/bindings/misc/fsl,qoriq-mc.yaml
index 01b00d89a9921..8c64e2f7bc3c3 100644
--- a/Documentation/devicetree/bindings/misc/fsl,qoriq-mc.yaml
+++ b/Documentation/devicetree/bindings/misc/fsl,qoriq-mc.yaml
@@ -113,7 +113,6 @@ properties:
 
   msi-parent:
     deprecated: true
-    $ref: /schemas/types.yaml#/definitions/phandle
     description:
       Describes the MSI controller node handling message
       interrupts for the MC. When there is no translation
-- 
2.34.1



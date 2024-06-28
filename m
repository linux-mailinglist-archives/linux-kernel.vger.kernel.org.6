Return-Path: <linux-kernel+bounces-234017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E9691C0EF
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 16:29:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98493B22CB5
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 14:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DE531C0DD2;
	Fri, 28 Jun 2024 14:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="h5If+WXi"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2040.outbound.protection.outlook.com [40.107.20.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235FE1C0067;
	Fri, 28 Jun 2024 14:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719584916; cv=fail; b=YXD/AMEaZ6Yq9lgOSA3TlJ4Gtuwsc2kZpmXmFwjRrOrGJSz/jque8Y4h6P9ZavYH/g2HP5VIp+AFMVq1J/vALhwkYagYnqg+jf6Wde9A4RiQJ0WCA0/hERchUkmtWk4l0LQF+GkbkITb8ZUcQES6O8xYgGejM79/zqO1vYmEx0I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719584916; c=relaxed/simple;
	bh=+33JQS/pQKTRusI8QySj1yD4HY8EfQRrjo/abFxnXCQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nOkstDNR5pjYUnSNu1RQV/Q4JYcOWFbNQ5bUpqV15rsJODE+irBaZ5l2V+69MushNugiZQUG5WdvO+HIKSBnIzxcdqBNSYbIEnXh3zADowhmFCTPSGdrHgKfR6Yu3JeX+qYzlUbehybKVQliB0y/vJH0xIOtD6tcWOYE5zH1HoE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=h5If+WXi; arc=fail smtp.client-ip=40.107.20.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QOK1o4eOiX3sukqhshIfJQsXXpXcT/+PwcBlLelimFaYKdWAHmiC/0UQl2JOIKvFFGtvZjEj4jOqGTs0n2IO1MRuLNU2fx4NGM9gSwbWPuEfqJgVxXtCDOig9RS0hMVI/bnnp5nsK3G8uH3ltHL2gBhmChS1HpYzqpl43RZqJY0b4KbaoxAHbkOnHIljfHOJqJ6//wwvubdwTLg8Me/ak8cnItS6Ka+ACdCz7EMs9/NpKjzsOEZPs/0TgD21d5E4pXcLISVD6B8GE3/ko/RHH5Sz6c8naUNR79GvgAgU0TjCtRnLsmupi2EomoyLHXxp4wZcrgXkMfgLOlU+5OiZxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rdCGrgnDOEjwLvHuZ5THOSwP8I4rGZrZ1KNs8DsZKPM=;
 b=PEtNnEUEAVez93Lq8K5eFZcX8MEurM+iqOkjm/n0fxLF94pC3NSSGTWSDOhpswpfY7gvaxauMGRqeviblRqvOrUcnjG1p8s6JhKR3ZR7XYnG8IlV2+kqoV/2r+H2Q5IezLWzVGpr634phGqud4RDk3/YXeko1MYiurK1/DskGWdPrR+r5iPCaJYRqELCgGPcZ1aTMm9X0gfcAL6SLktzY6cIOtJN9BHtzJTWsJHGJlnTIeZlGhtVPFAkrrobj9Ro+uQGWkXaW3LpQQxZoFhQxxSOYDkX/JqNdK6El2aKTYgrriOSjNKR83gZwFE5R/dui4VqvS+ia7CGYqBu7Ahrdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rdCGrgnDOEjwLvHuZ5THOSwP8I4rGZrZ1KNs8DsZKPM=;
 b=h5If+WXi45msC1TUHxoWvPqK8DbXn5PlRbGQ6BElB2fF408F+FpOHhWJIYlNRveRhwX6e1iVx4/X9jIu3qeDFhDLJiwGyOnM6LVPASqupQOhY23q+JbSqbbSFweKGF0y0PC6tjChkUDsFXv7Eu6zmqTPxmEBKXr5q0Un6UTWUps=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8513.eurprd04.prod.outlook.com (2603:10a6:20b:340::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.35; Fri, 28 Jun
 2024 14:28:32 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7719.022; Fri, 28 Jun 2024
 14:28:32 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE LAYERSCAPE ARM ARCHITECTURE),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH 3/3] arm64: dts: layerscape: use common pcs-handle property
Date: Fri, 28 Jun 2024 10:28:08 -0400
Message-Id: <20240628142809.2327824-3-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240628142809.2327824-1-Frank.Li@nxp.com>
References: <20240628142809.2327824-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0060.namprd07.prod.outlook.com
 (2603:10b6:a03:60::37) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB8513:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c3abc9c-3e2a-4370-dee1-08dc977e9649
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4FM7K0XgqlHGWonayDkuTv6LjB6MUQnSv+OFzktZ0MDd2RqZ/UlFZfFqtdQI?=
 =?us-ascii?Q?+zUhvzR9UpLfZsK/z7Fr+ID/MfEElM/VyVXaTanxVwG1bR04ENrwxRt2RYFv?=
 =?us-ascii?Q?ZDGAKaUcCaxnhQ4OCimedm/dUGajc+BiB96bGdt67CS4Le1M0Ix5yTI+ynWX?=
 =?us-ascii?Q?Y21w4uBMAL/uLBjw2CR17LFaf6SjVLZw01QvS/3SLy3NLC+NGmPhQKDlwolL?=
 =?us-ascii?Q?wKL6lCzEtZSJYqQqVFNtxpWfMOyOHqLaI07dOwPE+E6WsIZnD+YJNNdHhyQv?=
 =?us-ascii?Q?esrHCTR+BozKEY/vEaz1Z1+wQlj1imYmoxYxK0UoddiSbO8MdpsIol6Se9ai?=
 =?us-ascii?Q?W1yuY3+LX20tPYpU1QyPyWe8VXpktVTUD+V3VHwwIGo0Dzbqj86hbJfFV2jn?=
 =?us-ascii?Q?wEiuYb26Tcq8U3gQGoDgAOJAXaROA+Zi7Jl7vN6CsFZ+cnolVycAZihuQIfr?=
 =?us-ascii?Q?eodPuELDTi5KxvPtNOpl6lTcdTyix+bQdtnoLf20kHiz+Swxj+jPGKNy+Km/?=
 =?us-ascii?Q?TXHUc1qkaL+DpE+LaT4i1BxAo987thBrlY/RdXdDowBOXg54YcZTn6+3+41J?=
 =?us-ascii?Q?7o0Rdf5bdsLJ7DQqzwJpSwLRWmI3vTUyOi1xVC73/2icKSTPpu7DO06SO4br?=
 =?us-ascii?Q?+g+D34tWKou+HST7UFxpWCTGlNNUxYbPDEy5uVPESrklp31c1l7zbAQhXla2?=
 =?us-ascii?Q?jVmcgrSUaENB24f4v5b+GurG8+h4TliZJ1ArPH6cXnhUvh/NzVSfocnHc59n?=
 =?us-ascii?Q?3tGphTn0rKX1bkj8QP9xjwuyB2KPpibvnwPZm3hfhF2F9ob+CkoF/zxDrCna?=
 =?us-ascii?Q?WQyv/N+vTYH/KFSgaO1zcXk3ratS4JOgLlHIbEKISvy01JPufJaTWeX5SnjO?=
 =?us-ascii?Q?9mB8DW2EPtqlHngj4ZFaZGbtuGYSX66qHzGuGs+I943qRYzLT3Od6/VWcUDx?=
 =?us-ascii?Q?sA3xpDnlaDWTKdx/5ehFLbHJuavY/cKM3iJZMDBHYO7m0HyoFK58ykN4++Eh?=
 =?us-ascii?Q?nbpOND+fs6q36gwGmVgh3ob9hQo86Z2bcpqYzdGKj0++nL6MIa5gg43GN5Zl?=
 =?us-ascii?Q?JH3zgDhsrYWcxU5UCFfrCMGdRFcCNgoKt4ivyPMPlRht3PXpa7CSkBOPRNIk?=
 =?us-ascii?Q?aoRWvI5fkUpEw55/fZQzEhkI3h9ds9jIfVG6tYCf2TxQMXY1b2gxSakzwdO1?=
 =?us-ascii?Q?zmfJcPr9Mqm19kDL89yCycVCXKs228SL9chqh4NJOGCcV1UZXhxpk8Agvduv?=
 =?us-ascii?Q?jRphfVYd5gQf+T+qSyANwkrVXsicPZkM2PFH3wg9DtS3hI8Zxk4NoaJJ8tGV?=
 =?us-ascii?Q?7BHlCLExKip0CZX78oG4iB3fK49oNpGSSqaBqULhuIrg/L3lAmXggmeKdTIe?=
 =?us-ascii?Q?VXaeQJc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?h+52LHCxSkf7JqMAVQbXttB2XAFGBQ0tw3cTbvuOdZJcGeJchrHDVcUW9vKN?=
 =?us-ascii?Q?NQVCQX6cxUvqIM9E+ocZMcZtq9XqohFaDL5xXldZMjbqE2g7eyiAZXiprp45?=
 =?us-ascii?Q?qzWQ6jxUtco9guJy22psOR++veEki/8RPHykRx+2Slr7Wu0bsknc3H/xCBtA?=
 =?us-ascii?Q?36ivgcBXJfgTVdJ/d2X1liE8lgtANtZcWJUHOh7PzbZXJT+qBX7aYZrF/P2y?=
 =?us-ascii?Q?dqbGcylm/j0yTzrj/L5P5jUxqLvK5NJv9AtydiKSyDdkE6mTuXpPrtOv8Cu2?=
 =?us-ascii?Q?foFGrtHZNeV3s+9q/FF9yxxj+47x4a9C08HFvVFZuaVqbqVMAOwobJzeGFc4?=
 =?us-ascii?Q?2V3pzb4qoge+OeGK+RonDWTlUyuZUdyzmzBsrVdc9gTfGkugc056mcvct1Vr?=
 =?us-ascii?Q?vVPfjz5Vqw4nAJVNj64SFL8G4cY5CG/L60/pSa34CmLp0ms7Gtw/qu2jVJg9?=
 =?us-ascii?Q?KGM0BqrDjLBvTD/OGPxSOfnMqIJnuaUpxVgpb966yoRhRKgeorpGUKDHyfkO?=
 =?us-ascii?Q?f5/YJTmca++mYGfFZEp04qpqJQ1ULNkOUJydBJhZItgIaOU2kVoSyp1+p2Fh?=
 =?us-ascii?Q?tpwlj8KMYt41IG74c7LiaVeTkMc/UIvTkjP3/4m2L3cFKuFG9WxxgYF9IKD6?=
 =?us-ascii?Q?HGCTDWCHCzo0oiP+p+WAvlWIV5zbb4LlskiqhUMG8Ik6S+Jd2DZjGRpOpH7f?=
 =?us-ascii?Q?fwwsgK5UaLl5kK06WN66dALTt2nlF1rHtenPpQFzey0Hbl35Og2VE3yssY3o?=
 =?us-ascii?Q?m09iNYZP0VSDxiJFXanm4TuR0YqTnwauoZwRxpizKgzyodBK0qjyOCx+mR/c?=
 =?us-ascii?Q?a7yho9DkFda6V/oBXmXObdN2+R5r2yL375/WfPj4tDz4Mr5UWez0VwlR3zWU?=
 =?us-ascii?Q?q3RMtjxhrvYB5Sx7qJu3RsvGBj18CT/AjK9YETcqTlAu6NpRS1/BNFxcxw5G?=
 =?us-ascii?Q?xMgyhvt3ezIm+jqMeaEVxjo3zLrNhI0tZzBXVdaCd6QGVQqqntpiHNLe0qiZ?=
 =?us-ascii?Q?aKTm8GTDFKGQ7cwQtGXPg13g54GapTgNOqh50gI3++ZkGSEY1zK5S4sFw3hC?=
 =?us-ascii?Q?OrlujQAoPNWRUbVZkepG8y70WE4vppdHi0o9FE9MjD4pwhkbekOr3FOma24U?=
 =?us-ascii?Q?fzFjNNzulAw/DUMr52zfWFUhU+eJxw1DgZOFVT67Ealf9sBFkoiZWHuZSOyb?=
 =?us-ascii?Q?cZWDJblLJvxLPYSNWtR8iZmZLHMm5HAOnuUZM/cGfcojdSnl5L4LsZPcszOi?=
 =?us-ascii?Q?6hByRPxsojvmQlOUZ60jT3waYboS4uTJz9Y+41y4FThorPD7vhOGnt99KhfQ?=
 =?us-ascii?Q?eY7m4NavBoTedan66FoCWxoMUa6L+yoxQDAzHiz4fbxP2qvXr63O4GuncrBp?=
 =?us-ascii?Q?mX2VAwV4uUVMrbSj62LIocRBrV+YJF8WpjXu9TNAEphBJ5GZMCKhvbE7FUbv?=
 =?us-ascii?Q?HQ8CPzno6hHEomLwRzLtb20wgKr1aPdbfF3pDMv/mB6vN0BSAagFGCCUZkny?=
 =?us-ascii?Q?H+kRUoLyfj43VoCtJngzWw+K6qDDIYwRmOxrVLo0TnnOjyw6Ls+wcVW2fkUo?=
 =?us-ascii?Q?8enOI+2o7zbMpK8n5A9/bJPuvvHpZz66WS21eAo5?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c3abc9c-3e2a-4370-dee1-08dc977e9649
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2024 14:28:32.4144
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lM69rS0sOlKeVj45wCHCup2NVgnUS05Awt3T5kR0nvuhTJae+YFeK8/CwO8hAPiE3ylPPDoUp076t+l7QS+/bQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8513

pcsphy-handle already deprecated according to binding fsl,fman-dtsec.yaml.
Add new common pcs-handle at dts and fix below CHECK_DTBS warning.

arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dtb: fman@1a00000: ethernet@e0000: 'pcs-handle' is a dependency of 'pcs-handle-names'
        from schema $id: http://devicetree.org/schemas/net/fsl,fman.yaml#

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1043-post.dtsi     | 3 +++
 arch/arm64/boot/dts/freescale/fsl-ls1046-post.dtsi     | 4 ++++
 arch/arm64/boot/dts/freescale/qoriq-fman3-0-10g-0.dtsi | 1 +
 arch/arm64/boot/dts/freescale/qoriq-fman3-0-10g-1.dtsi | 1 +
 arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-0.dtsi  | 1 +
 arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-1.dtsi  | 1 +
 arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-2.dtsi  | 1 +
 arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-3.dtsi  | 1 +
 arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-4.dtsi  | 1 +
 9 files changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043-post.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1043-post.dtsi
index 5c4d7eef8b615..ca7cd7a33c017 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043-post.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043-post.dtsi
@@ -29,6 +29,7 @@ enet0: ethernet@e0000 {
 
 	enet1: ethernet@e2000 {
 		pcsphy-handle = <&pcsphy1>, <&qsgmiib_pcs1>;
+		pcs-handle = <&pcsphy1>, <&qsgmiib_pcs1>;
 		pcs-handle-names = "sgmii", "qsgmii";
 	};
 
@@ -40,11 +41,13 @@ enet3: ethernet@e6000 {
 
 	enet4: ethernet@e8000 {
 		pcsphy-handle = <&pcsphy4>, <&qsgmiib_pcs2>;
+		pcs-handle = <&pcsphy4>, <&qsgmiib_pcs2>;
 		pcs-handle-names = "sgmii", "qsgmii";
 	};
 
 	enet5: ethernet@ea000 {
 		pcsphy-handle = <&pcsphy5>, <&qsgmiib_pcs3>;
+		pcs-handle = <&pcsphy5>, <&qsgmiib_pcs3>;
 		pcs-handle-names = "sgmii", "qsgmii";
 	};
 
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046-post.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046-post.dtsi
index 4e33450939436..15ff7c569d288 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046-post.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046-post.dtsi
@@ -24,6 +24,7 @@ &fman0 {
 	/* these aliases provide the FMan ports mapping */
 	enet0: ethernet@e0000 {
 		pcsphy-handle = <&qsgmiib_pcs3>;
+		pcs-handle = <&qsgmiib_pcs3>;
 		pcs-handle-names = "qsgmii";
 	};
 
@@ -38,11 +39,13 @@ enet3: ethernet@e6000 {
 
 	enet4: ethernet@e8000 {
 		pcsphy-handle = <&pcsphy4>, <&qsgmiib_pcs1>;
+		pcs-handle = <&pcsphy4>, <&qsgmiib_pcs1>;
 		pcs-handle-names = "sgmii", "qsgmii";
 	};
 
 	enet5: ethernet@ea000 {
 		pcsphy-handle = <&pcsphy5>, <&pcsphy5>;
+		pcs-handle = <&pcsphy5>, <&pcsphy5>;
 		pcs-handle-names = "sgmii", "qsgmii";
 	};
 
@@ -51,6 +54,7 @@ enet6: ethernet@f0000 {
 
 	enet7: ethernet@f2000 {
 		pcsphy-handle = <&pcsphy7>, <&qsgmiib_pcs2>, <&pcsphy7>;
+		pcs-handle = <&pcsphy7>, <&qsgmiib_pcs2>, <&pcsphy7>;
 		pcs-handle-names = "sgmii", "qsgmii", "xfi";
 	};
 
diff --git a/arch/arm64/boot/dts/freescale/qoriq-fman3-0-10g-0.dtsi b/arch/arm64/boot/dts/freescale/qoriq-fman3-0-10g-0.dtsi
index 65f7b5a50eb51..1b2b20c6126dc 100644
--- a/arch/arm64/boot/dts/freescale/qoriq-fman3-0-10g-0.dtsi
+++ b/arch/arm64/boot/dts/freescale/qoriq-fman3-0-10g-0.dtsi
@@ -27,6 +27,7 @@ ethernet@f0000 {
 		reg = <0xf0000 0x1000>;
 		fsl,fman-ports = <&fman0_rx_0x10 &fman0_tx_0x30>;
 		pcsphy-handle = <&pcsphy6>;
+		pcs-handle = <&pcsphy6>;
 	};
 
 	mdio@f1000 {
diff --git a/arch/arm64/boot/dts/freescale/qoriq-fman3-0-10g-1.dtsi b/arch/arm64/boot/dts/freescale/qoriq-fman3-0-10g-1.dtsi
index 3f70482c98c30..55d78f6f7c6ca 100644
--- a/arch/arm64/boot/dts/freescale/qoriq-fman3-0-10g-1.dtsi
+++ b/arch/arm64/boot/dts/freescale/qoriq-fman3-0-10g-1.dtsi
@@ -27,6 +27,7 @@ ethernet@f2000 {
 		reg = <0xf2000 0x1000>;
 		fsl,fman-ports = <&fman0_rx_0x11 &fman0_tx_0x31>;
 		pcsphy-handle = <&pcsphy7>;
+		pcs-handle = <&pcsphy7>;
 	};
 
 	mdio@f3000 {
diff --git a/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-0.dtsi b/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-0.dtsi
index 78841c1f32527..18916a860c2ed 100644
--- a/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-0.dtsi
+++ b/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-0.dtsi
@@ -26,6 +26,7 @@ ethernet@e0000 {
 		fsl,fman-ports = <&fman0_rx_0x08 &fman0_tx_0x28>;
 		ptp-timer = <&ptp_timer0>;
 		pcsphy-handle = <&pcsphy0>;
+		pcs-handle = <&pcsphy0>;
 	};
 
 	mdio@e1000 {
diff --git a/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-1.dtsi b/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-1.dtsi
index 1f43fa6662221..e90af445a293d 100644
--- a/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-1.dtsi
+++ b/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-1.dtsi
@@ -26,6 +26,7 @@ ethernet@e2000 {
 		fsl,fman-ports = <&fman0_rx_0x09 &fman0_tx_0x29>;
 		ptp-timer = <&ptp_timer0>;
 		pcsphy-handle = <&pcsphy1>;
+		pcs-handle = <&pcsphy1>;
 	};
 
 	mdio@e3000 {
diff --git a/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-2.dtsi b/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-2.dtsi
index de0aa017701dd..fec93905bc818 100644
--- a/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-2.dtsi
+++ b/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-2.dtsi
@@ -26,6 +26,7 @@ ethernet@e4000 {
 		fsl,fman-ports = <&fman0_rx_0x0a &fman0_tx_0x2a>;
 		ptp-timer = <&ptp_timer0>;
 		pcsphy-handle = <&pcsphy2>;
+		pcs-handle = <&pcsphy2>;
 	};
 
 	mdio@e5000 {
diff --git a/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-3.dtsi b/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-3.dtsi
index 6904aa5d8e547..2aa953faa62b1 100644
--- a/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-3.dtsi
+++ b/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-3.dtsi
@@ -26,6 +26,7 @@ ethernet@e6000 {
 		fsl,fman-ports = <&fman0_rx_0x0b &fman0_tx_0x2b>;
 		ptp-timer = <&ptp_timer0>;
 		pcsphy-handle = <&pcsphy3>;
+		pcs-handle = <&pcsphy3>;
 	};
 
 	mdio@e7000 {
diff --git a/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-4.dtsi b/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-4.dtsi
index a3d29d470297e..948e39411415e 100644
--- a/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-4.dtsi
+++ b/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-4.dtsi
@@ -26,6 +26,7 @@ ethernet@e8000 {
 		fsl,fman-ports = <&fman0_rx_0x0c &fman0_tx_0x2c>;
 		ptp-timer = <&ptp_timer0>;
 		pcsphy-handle = <&pcsphy4>;
+		pcs-handle = <&pcsphy4>;
 	};
 
 	mdio@e9000 {
-- 
2.34.1



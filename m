Return-Path: <linux-kernel+bounces-225107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4402C912BDD
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 18:54:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 667861C26DE2
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 16:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCB54176FB3;
	Fri, 21 Jun 2024 16:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="lkLNli+h"
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2078.outbound.protection.outlook.com [40.107.14.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFABD16A936;
	Fri, 21 Jun 2024 16:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.14.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718988733; cv=fail; b=dHFOj7PrMuAj86xJDaXDZtQX5M8slQr/KBzWykPMZwG/U8miCU52QD/3oVaTOUYljW9P00fxwc1Bn3to1TEP75ljjUXAe29k0+aSx/ovpC9rt4eYKMkMJIffTTHgvOWlr7pM+LzarCeweQUoBJ2jeIEHmDVALMw2BoCKmjWe5HA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718988733; c=relaxed/simple;
	bh=XepUEO9yKpKGW06EcWbY5xfLZwD52I4QKsYtIiW0ID4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Jr9KfQqHWG2Er7ZU8RdHiAlDXbMEHhKKcBwiKE74TxpQtvMYhLaUvlU7e9haZ4ZGCjIBY6HJHuLhQkPnaznve+FjO+dkbhBRdX4Id6DnsX4Y6PKcBn6RBecxYPMLt8AknAhJaULnmICpnEknHFM11jaMZJTy7vpL5iM1M45t2Ec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=lkLNli+h; arc=fail smtp.client-ip=40.107.14.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MVwrvm79G1X9i7aC+0fHPcE7cA/pX3IDTDoDfWnVibQWQJy7zHAM3uzRozykX27IBq5Q1cuf13ZdfMcea2xL231xRHcXy4f4+3z0GuzjhUCHRf5ceB7G6YljMDhx3mdmow6TehgxVRWCRwE6xB34u6YWD9SlGwR3bTOsSdTrTqqJzrG8PIKDsg6vku7nWNEKpctUrqe/bSRwu5ielW9+QuPWAo3rqO1b//Oj9wsPp0zuvuAO3Cr4gJheL3tuv2aytoWSicZuvqysyOV2+0TuuafvM8hQEJBnVMKTYzD6Rnm/mNWkT9X55hzxBF6qVvJbsbmBeLJOYjkl8x82ZjVNig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TeIbn/KddCJucoZ/by2tNwSKhTj1MbcmGDVsMnnDMVw=;
 b=TxiJEmROcadNXSFF4CvDUInvoa47lUlIOaf039a5KBKL5OLoFEyqFL+8kr2KCmyr4XwLqdwfAC7YTDnfEq6SZ3EM6L/jEC+Bbo7I+KQBfA0XKcERzZ6WQAWdMxox3+gU3Pxj64Ebk+ZUy0knfalg+DDWN+y83N9R4pr2DXjn8HfpRPVrxS5C+jsMTfmvc8WK19HBkt5nEsC5xNVYP2zYDY2yniyWuHyMD2/qXwTmkY5saisS6HrLTeOwA7/KCngnWRRXyho9oFjVMDthdzSpD6lazc2py3cd3HY6eCBiBn+3mr3QFLfoPgvz2m4aPcrBpsSN0qODw77mD/whtmoKEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TeIbn/KddCJucoZ/by2tNwSKhTj1MbcmGDVsMnnDMVw=;
 b=lkLNli+hThaG6g2M8FLk+g0jBUOqbH351HFbOpzsF8r2pIoSMYtBpkY8u8ANk0B2WJ1WXPo7Zn11cCfp+c+Tz6ckYUscXYTEJ8Akgl/LSthEP+v6TkxfYlM3p46wMIQi7l9usDC3ap6eP5ThL4air2cGRLvk4b1nuTmTI4TH04U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM8PR04MB7937.eurprd04.prod.outlook.com (2603:10a6:20b:248::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Fri, 21 Jun
 2024 16:52:08 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7698.020; Fri, 21 Jun 2024
 16:52:08 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE LAYERSCAPE ARM ARCHITECTURE),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH 2/6] arm64: dts: fsl-lx2160a: fix #address-cells for pinctrl-single
Date: Fri, 21 Jun 2024 12:51:45 -0400
Message-Id: <20240621165149.2275794-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240621165149.2275794-1-Frank.Li@nxp.com>
References: <20240621165149.2275794-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0054.namprd05.prod.outlook.com
 (2603:10b6:a03:74::31) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM8PR04MB7937:EE_
X-MS-Office365-Filtering-Correlation-Id: bfad8103-3745-4bb6-3a13-08dc92127cde
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|52116011|376011|1800799021|366013|38350700011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GqF7pslAVYnvXzEgTv/cyFmpD9kldoSd4icNogtz9yhpNyuLXyEMr5J1NvUO?=
 =?us-ascii?Q?uNfimQKGg1UGpmALLc+dRJEk4g6G9gxjZiPIKRuq975s0IJyMWbYZC9oP/VG?=
 =?us-ascii?Q?TbWcJ329uRyLp83jxyVD+jlG9jxHO1xsIxF0l7ePbOBN3vBXKE+kdGVdZmYN?=
 =?us-ascii?Q?0IlYU+N/s7aZFmAmbuoLqPDICCfqHfxd3cV1RJiLvb8gOr0RJuro6tsEUP3X?=
 =?us-ascii?Q?wwYCFGqhOdCHZqGworYWIpErMxE9GMTXGgZXl2EUJP4Kvy7rlVvDYP/HVGzj?=
 =?us-ascii?Q?JpwD0wEDIoCmB2G25ShFBVe8y5JhAKpPZnGgc77s9mil1CazJHkTl130Hoet?=
 =?us-ascii?Q?OojpctVxQ6C0TY4drHjSCo3iSScCLjTL3svORjHvJWkP2fpbLJEwOmLW4sAS?=
 =?us-ascii?Q?0iWF51zAu55qyqHGqhk15AjTkgaUGrBpLbKZEAGZsA2rPWgWALG0QVjz5i2E?=
 =?us-ascii?Q?3t4M+7FdZCYzbpf/4RK05sDROTZweVVuHXUBsdeWX4cSFr9kXovGQ49Ijzqn?=
 =?us-ascii?Q?yifvDWQgBLZveOhJVXd6vrnH+u7Xk2klhd6KCZiiLTtEitzS/XNVy/LDF9Nf?=
 =?us-ascii?Q?A95yYCu9sMup/tEtIAh1j4DjpRWr2925Wv1FC3HYYC82AHMvWthGwiHjEtFU?=
 =?us-ascii?Q?Ccko388KuksMLTMDJk7spC0FDyi3Nwp8kUCgrPPakyQb+FXh7Q+mNA8tYiby?=
 =?us-ascii?Q?NaWr9cjCsqV3rrfzgIGl4YXS3yPADBEziby/PneUnMV9zVjOkacfKJR9tbnb?=
 =?us-ascii?Q?qY1lFbwfj2svVhrqP9C5Z9DDJcrX32++j7kWNpA1hbrLaZT4+V4suoYq+ANx?=
 =?us-ascii?Q?0AG9MF66Kor8NcZcJW8fGFax3zZfPfvD7umZ6FlvwJKA+BN3kMoNbFWTONJp?=
 =?us-ascii?Q?I4KKIvdHkF5dvKswcckUCE6kT2FOiVFCO2x2GyjHFkAkRUfpE76TWMSiCmBS?=
 =?us-ascii?Q?UcLo/kc/d2OoCjZ8AomVs9BYdMglw074ovt8KnmYKoRfHmpK+COiC58R0SOf?=
 =?us-ascii?Q?gMmP34ML3TQ5zZWflRXuCFr7VxSzW2699CNt1ltstIxoAk985je+GdUsK7vg?=
 =?us-ascii?Q?d0iR2O7Od/tydhgRVD0e+fFcRiz72IGSREUOoGBuyHhqRR56T+UmAOfc+P+f?=
 =?us-ascii?Q?GzxF95KQXZJTyJMCYjmZziG27G9y8d1rFFKFhtpYLsJlzdy/PMjP3UGOkzzJ?=
 =?us-ascii?Q?BOdWEjesWpFl+S4P7bnaanOqx1lpbgyzdw5cQ+5TjvPIxP9st1ePVU5wSFAo?=
 =?us-ascii?Q?bdPtDUIPqp8zFvPWOEiQX6G0RxGltzS0cipClg4E1TwRk2piL6lyytVw0J9x?=
 =?us-ascii?Q?Y8BT/wBy8A3bypQxiZ1KqB/U?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(52116011)(376011)(1800799021)(366013)(38350700011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dHqHz++2tHiXW9iUVwan75fpsnzSgGBE+wz3lekz7XsDYU5yjoOe70WERcQ5?=
 =?us-ascii?Q?vf2tFMqp5TnTVIdQT6BFvHRUfJSOiHvFNRfcDTMQa/9In7HH9d9DdZNkXeGt?=
 =?us-ascii?Q?BvLjsl97oBPuXgsoQmn0hzWeqawLrof4AjTCD3d9VWYg5e8EAJ67NuUTFM9o?=
 =?us-ascii?Q?+gMYBljwZbJ5WRBoRaiMESyXcWVdu3RkLqUZ9/pJkVbBWpH1ESeytTHvcX4Q?=
 =?us-ascii?Q?AGmquAsidDg/u3Z0Ksl3cC33tWlzX+NGxEiN4iswznjLblBatmEs7EJYXri5?=
 =?us-ascii?Q?lOinicaEFg4prwmhAiT8eMxpkRsCKnVgwXY2pgLosaFsdmJ9GqZLZoQjqa9D?=
 =?us-ascii?Q?S5qVxTx6A/T5noPKS6XR7v/wJWGaS2gRz8hhEs+L904EMNl4+t3aIIyzBh6G?=
 =?us-ascii?Q?E1aUYYEDG+adK+9Ai2bz8ZcioIgTRqzgO83sY6CbOX2ax0fAtQqiVxleRxwx?=
 =?us-ascii?Q?T1oyrYfPgYhRx4GsoRUOOeHQlNoPGXLWbqHCsbCkCll+mA24+KjVfsAPTK1h?=
 =?us-ascii?Q?ZwQBlbE8rlDEmzKjsUI9i3joww9nW6PrryMrKobb/SOaiimyHvcmcP458jYg?=
 =?us-ascii?Q?GcFMc7MHATd04qjSvMLUeVXP52HduVxU429Z4sfPKHHP4u9xaGOzrgxAm9V8?=
 =?us-ascii?Q?eQUt6bPZsPB/eXj3qCza60cfxv2GPc//+t+1HKnQ53zskVVucHWhL5p+u+tk?=
 =?us-ascii?Q?1y/djNt3MPUJlq1e4e0+Ueo2EreeB6C2/Cs0ipRnH4uS8DqPpUL6N8kZObOc?=
 =?us-ascii?Q?WkHoIXZkOXQEufJSebKDBHYR4zkQi6mgrjMatrSz++chnF8XH/BuY3X2hZX3?=
 =?us-ascii?Q?hLXq/GcMje/WxqwlZfQxpAH0Yw2Y1PN0iuCR42HcVTmTueA918LZb/kGpysi?=
 =?us-ascii?Q?Kl3sxc/8mgs6cyHLWDT8zXAwtbUGaTVxiiGLaVUlRHZjSe4bFiNbGzkjzlMZ?=
 =?us-ascii?Q?VcTYhrynDizWWGMIhYr6oIgjcsvLqU9HT3g0g05PIcgQs81mwIo+2vPflA79?=
 =?us-ascii?Q?o0bemUW/R59U1MqFDeQVkv1avojV/hzXbzV2XFgLpDWw8Yu0wB/k1hVcDOpn?=
 =?us-ascii?Q?G+VrLIYmItyZnEG4dxZfp+yVoQVUdJBC0coqruWk9/kGA1nazu6738pZssZj?=
 =?us-ascii?Q?3hHvo6RTJHcdYCwBvHzWG3B7QYXrIefddUZynFW9O3X00mYonvec2fGFj0NQ?=
 =?us-ascii?Q?9P10v6yJ7bRavxORHdP2qOa3VRsmjnSQxK8H6ykokrJKsuQbD2TwutHCAR+N?=
 =?us-ascii?Q?CfR3q0VdPLcKZGd7zBa+vx+ZBjMBXMxI6LP7Zdtd3EEJ5JDeGKvdSz3AZRwy?=
 =?us-ascii?Q?N9tdicA5VSNu8TRXNPwkFv1qXXtyQOd5oOSIsJBzWa3tufTP33+6A0dKyRMW?=
 =?us-ascii?Q?vwTk3Kic18ZQHeFtptALeVREsLJQqOyjSSZHS7s2eTNfYonpNoXk07EEFBYh?=
 =?us-ascii?Q?c+1DCnrme2mmmXD9d0lWpVYaZZX+MkrbaCrmyOrRPYRTFgWL4nZmQD6SEad7?=
 =?us-ascii?Q?nt0GunvYht5J62KRli/mIq8i1jxlFJI4GwPSNHIdXHdNI35lqdWGNe6DFkTb?=
 =?us-ascii?Q?4MokzwEzXixEfS5hqunb/Ib8IjwmzKpWhSiPgRj/?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfad8103-3745-4bb6-3a13-08dc92127cde
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 16:52:08.5227
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wn9u2UePglcG5w4EG2mAhT/53WYppfgR0k4Pb9ugJ+OcRN4AiXGwrdwHZo2WwjtwwNILJjWzz9VFJ/UuxfBSGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7937

Change #addres-cells to 1 and #size-cells to 0 to align binding doc
requiremement.

Fix below warning:
arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dtb: pinmux@70010012c: #address-cells:0:0: 1 was expected
	from schema $id: http://devicetree.org/schemas/pinctrl/pinctrl-single.yaml#

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
index 83431dd5d2872..26c7ca31e22e7 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
@@ -1702,8 +1702,8 @@ pcs18: ethernet-phy@0 {
 		pinmux_i2crv: pinmux@70010012c {
 			compatible = "pinctrl-single";
 			reg = <0x00000007 0x0010012c 0x0 0xc>;
-			#address-cells = <2>;
-			#size-cells = <2>;
+			#address-cells = <1>;
+			#size-cells = <0>;
 			pinctrl-single,bit-per-mux;
 			pinctrl-single,register-width = <32>;
 			pinctrl-single,function-mask = <0x7>;
-- 
2.34.1



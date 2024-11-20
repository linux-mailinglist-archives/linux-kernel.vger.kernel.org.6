Return-Path: <linux-kernel+bounces-415527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE979D3793
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 10:53:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9954B1F21E45
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 09:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D91CB19F436;
	Wed, 20 Nov 2024 09:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="I83z2fdQ"
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2084.outbound.protection.outlook.com [40.107.241.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0469319F105;
	Wed, 20 Nov 2024 09:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732096373; cv=fail; b=AgC9+XzUO0sE+x05uoNXtAcCkCn+M/fll66LJWqFNI4lplOhzoimBOZCAxJqt0nEGBJHhLCE72CB0BbJx1njPo3bU/IJwh201ATpEJ7M6IV3QSQpsnwkA/xGmM4EXSvXARm7b0x0HGuhCXZrzeZAtsmBkSYVjUfG67dwGWlkfxk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732096373; c=relaxed/simple;
	bh=zqBkWKoXotoIM19pB6Ef4p8kxb1rKlC1dfzt+6hBn9c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DjeBaVpbeRR3KSckhcknTLfA3INa2PQiJgXfcd0pg6+NgYy1Bwczy0U+P2gblRdu9rG5JI/FJ9W8k01tCn4Q47IqpaQG4aSBP6NgHb00yml+Ai1+VrGZkqPmnKmPmmE3kbVhWQByItAF6Q0KfHoQyV5CRrqBGqr7rEz2c36jl8U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=I83z2fdQ; arc=fail smtp.client-ip=40.107.241.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wm7n05rZA2tPkNsfEw6yaAqsLgkRw7YpVMZ3kmEh26ux7YDYapNeVjVLDyfR1T2YT+lNnaAmB56mknBGD8DpQn9KBy/RwI7zjAHKF6xNtFz4My++QxSTc3tehK3nEnyHZ8ryHR5KPScJosf1bXO408z1n95N/DQ1eNnCmtKmIc+mip4N37NmgiciRqGIlzaiNVZtso2FJkVDz1ycfGy+klxWounX5dqXDuTwyykixxZ4cR9A12ZTK+TqyFX0q5QXarF+7DrQkRoAj5L6sctxXHH75bGfC3EThBGV6H1PBl2QwaNyvRpE3MpuJSZN03pESwK9C1pMNM4gwNiTOuy4cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B6qaWb14HL+Knbhffdql1dw5GhccHqJwbBK1crGOS+8=;
 b=iGa2oGbs3T06UdlVHvgE+l1bZHcZc+dDDKCgAbRWfZ4iYDEidTMcK3TBV8kbb6KNwZLG9GTcMUdoB2pwNqdZ+pOSHctgFL76X+8EXEJkW6nxMKMBEw6rbv2VOHtVqRwUUY2B4fzQ7Nf8NzVQH5luB45Zybhh8gSBEHQ6XmOeR43snlFyFtm4ZitSZ09XZ6puE/x7D5E4Eim9Iinx6oOI5kSDHBzoh4kZKfT3Sz5lgLyA3G8Vee8oniptpnrmLeWHYWoCtEl6w99DP2xjEsRktnqQudezlJsE6iN4v5wu5Ugrh+S6fNZt5379abLZXVOOsiM3OIWdYTY/eWy6/cE28g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B6qaWb14HL+Knbhffdql1dw5GhccHqJwbBK1crGOS+8=;
 b=I83z2fdQdph5vkDOsw3ciCW5wcR2hYjyJ4lSMUAr34awAMB5qZZl2k0UTLb8kbFKMAIU3mnYhLVq1tTphwhIG2Ja9+bFxMNPOClAA9R0HH0KaTiIvhZEN9eQlgQ/NPP1fqtEd515mkt76coLFMxm68ABlwrUjc1nHXRVk31n43c+X1beFNLUNqShi+4tH6StRBDe+M5NCyOiVHYQfj4GZY2h+W7WS0UlKANH6exDH1jWTmafvnj6cKr90adP9Zv7GjvdCQJ7rW7+oxkfp7jgHakIUmLOnptQfkQTuw7Rsw9bSDDiz84nJeQlXoM+Py2hrHL6QE7RTIzhmdD5sSeWDQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB8PR04MB7065.eurprd04.prod.outlook.com (2603:10a6:10:127::9)
 by GV1PR04MB10128.eurprd04.prod.outlook.com (2603:10a6:150:1af::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Wed, 20 Nov
 2024 09:52:47 +0000
Received: from DB8PR04MB7065.eurprd04.prod.outlook.com
 ([fe80::8af7:8659:9d42:bd84]) by DB8PR04MB7065.eurprd04.prod.outlook.com
 ([fe80::8af7:8659:9d42:bd84%4]) with mapi id 15.20.8158.023; Wed, 20 Nov 2024
 09:52:46 +0000
From: Pengfei Li <pengfei.li_1@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	catalin.marinas@arm.com,
	will@kernel.org,
	kernel@pengutronix.de,
	festevam@gmail.com
Cc: joao.goncalves@toradex.com,
	marex@denx.de,
	hvilleneuve@dimonoff.com,
	hiago.franco@toradex.com,
	peng.fan@nxp.com,
	frieder.schrempf@kontron.de,
	alexander.stein@ew.tq-group.com,
	m.othacehe@gmail.com,
	mwalle@kernel.org,
	Max.Merchel@ew.tq-group.com,
	quic_bjorande@quicinc.com,
	geert+renesas@glider.be,
	dmitry.baryshkov@linaro.org,
	neil.armstrong@linaro.org,
	arnd@arndb.de,
	nfraprado@collabora.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	ping.bai@nxp.com,
	ye.li@nxp.com,
	aisheng.dong@nxp.com,
	frank.li@nxp.com,
	carlos.song@nxp.com
Subject: [PATCH v3 1/4] dt-bindings: arm: fsl: Add i.MX91 11x11 evk board
Date: Wed, 20 Nov 2024 17:49:42 +0800
Message-Id: <20241120094945.3032663-2-pengfei.li_1@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241120094945.3032663-1-pengfei.li_1@nxp.com>
References: <20241120094945.3032663-1-pengfei.li_1@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0035.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::8) To DB8PR04MB7065.eurprd04.prod.outlook.com
 (2603:10a6:10:127::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR04MB7065:EE_|GV1PR04MB10128:EE_
X-MS-Office365-Filtering-Correlation-Id: ca48edde-35e8-404d-7b44-08dd094915aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dH/9IJflrxinoOHBD+J4KiSjEg5DNhwfsbCBX3sSUykNhVs/i7BvKAj+4Nsh?=
 =?us-ascii?Q?JBlpUPmHVk7YFpn/byelK5JY8Sm+Wb7Y+3lATmoMw2ZHvC8gGmemIr0a/vrf?=
 =?us-ascii?Q?Glu/eSefYhKxDcWNPdCUR5bWxUNN6L3Ry284WpXxWDFyaW40ZA8ZXYR+huar?=
 =?us-ascii?Q?jj2TucfFFKkmZTEsiIjIbBdhvS4zavyur6VjSnmGgSI1YU5C+YMCJ4G9Ga6x?=
 =?us-ascii?Q?jcy70tGA0Tg7edwn6VtMUxv6rQDrmiweNDDE3+u91Iltonfohm/9onb6haOv?=
 =?us-ascii?Q?MedvwXGpQ9yHPeCTaYddeboQrV+7q3jyjt65wRqnueCqOqUin69mnY5t6++2?=
 =?us-ascii?Q?apJ3a0qJwTxdyA+89EHD//cmKgW6QNzhgn+UNXgnlu4YvtuIiHfk+iFCZP2n?=
 =?us-ascii?Q?H71MlGLKNJfSVbxQ74H2zruUIgt0vf2cZUVm4Mg2JVgxZOV5udYaPmltf469?=
 =?us-ascii?Q?ica4/NbxAIyYikV5zC6jPRiKUHGKqRut8sZlgSg1sEqCq9J9a3Jv8bIq2/ei?=
 =?us-ascii?Q?Mn9MB0vkqWkpTM71SB+jytqoelXBxaJQNrhqCXsuvmlvucnfZ+bU8D1l/w9J?=
 =?us-ascii?Q?Gy9jvOwrYHfoCFr7qXvCovb9QCz06YpdtuW2f9b/wVQaXKDbGVF88Kw0W3Na?=
 =?us-ascii?Q?Z11sq3khUxhlQWm8+KQKqQ7Zrzy1tV2/SPSc/rX9vfJg3sls5Bm9TEFo5yJ7?=
 =?us-ascii?Q?AJnhwQYCuizUPr2v1Ev+J1bYQyrOlA+nkJzjunFdVWFPH/EivTGp54Xs7QCB?=
 =?us-ascii?Q?t/IBn/dHo3DHh/4OEHszDnkjunMIO3EUMJAA1iSH6r1OgieZbOpNhh2TTpIB?=
 =?us-ascii?Q?891+D5ItGdTTW1LaUmvXPG1vbJSMEhy3xeGwl/iUUdvp4esX6uIYXqIhD0c+?=
 =?us-ascii?Q?ZKyCxPMri9sCg5/9xwj55n4t8WqYcnoJZmdybuSFBWwORBbH2jO24t0I1pIy?=
 =?us-ascii?Q?0l2uTSOhQmXcesoCWK1j5KoukBGAN81gi509LGFlUEmTE2m7tXNfPkzf3dAT?=
 =?us-ascii?Q?qeUfrOfHZYLkULspMue6oUFNrwoROm7LmDVjGBebvQzgGQfZl1mYX8v2fy2G?=
 =?us-ascii?Q?TUDAlN0MDKycfbtR+OMLUJwchlH453SXLl3vWssGJj0mXJUWCpYRgCWZYZOD?=
 =?us-ascii?Q?Kva7zVOpmuVOfrT5cPswCBi8IZZkGID+Bv0/gPChRdd5xihIT8i5ewGUoKUR?=
 =?us-ascii?Q?BIscw4/RXFnlZ9xjhhdlq8UfuADsW5r6fHfvSC4l6ueeC3lZFyDPhhMCiJ1t?=
 =?us-ascii?Q?/dZnfaEdl7Op79eTfB1Z4U+V/v4lLeq1vMzQuHIDHSC6WdCN3mjn74JGwtjE?=
 =?us-ascii?Q?u/jopwamSRZRSlyRFhMLXqiqkmbOIOhrrsOh77yebb7iuyMDyyrPh54SpLVY?=
 =?us-ascii?Q?ypGjcYs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB7065.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tY4LarMxgZ2O8gjTCMt4AGIxgGGhcMfopsKaHnQs2zvuH47j+Y700FA5RGxc?=
 =?us-ascii?Q?4edW4glwrSFtrLHs/BXx9BfnI/fSHC/up2SSu86UKPpkyCSEWnTzb5UOa3Yj?=
 =?us-ascii?Q?32cc8FRt+qG6ihpDPdv5lbAuktrk0AArBjrFZ7J/HCsA8sJYNtsPm0Unern/?=
 =?us-ascii?Q?T89NB7+dcO/0YRPaIlTkbcOJcoqcjAM30ul/JYnqpej6uQQd+x6I2388rJGV?=
 =?us-ascii?Q?EVLw/HS9nM+IoC38FsVBIrXntqiU+TN4aEx9d9pOYEiBtveJcOeqRaS++IYF?=
 =?us-ascii?Q?O7/XJun/cmbXNh1B3dhsg+xmIubBbFu/d1hJBqQuVVdJyD5e9nPfFG8Dx4/U?=
 =?us-ascii?Q?E5l0/mhbNlhYVSstEigJ70jRIMQCeg8u7Z3gAWD3OR5QYyasBqJqUaJkxDnJ?=
 =?us-ascii?Q?IgEHwKkzhOwGvv95p0zzJU6u/pNtjvgeeum33KXdgyCocNXUkK/dNdjYImt7?=
 =?us-ascii?Q?/rbMnD8tTu71jhE2BdPTmRdufx4ix/ZIMAXrdGFq5rGTUXCdSkRzYEdOfFJu?=
 =?us-ascii?Q?lkF+6qSTmiQh005ytOTy9fSRjRFzkYGpccwTATbpKQFOGYy0zyv6jEOMJ+m4?=
 =?us-ascii?Q?yBTOJ37aMFfxZCAMqno1HMA6QosaWCICgHHsOqVhau+a0eaqCYynPHoBWjkh?=
 =?us-ascii?Q?Zn24qD6nCEsXk2Afcds8s0shDnmqc700go1nZ1d5vtJLYGuL4sjEL2SrEVaR?=
 =?us-ascii?Q?UsGQam4r5vfOG4Xl4Oe+h3GLy213NzFH3XFCAVSha639DEOQHIJiwsVxeXkU?=
 =?us-ascii?Q?iHDqvUlAcGJETcQtIHqRltEvzoCoCKaM/kANHLVgj/wAA6XhMSKoDFq04BoY?=
 =?us-ascii?Q?AJfoDNIjF8488BPh3qAaMDA6HkjEgNfepRrLKba+qYteRyQsEtUX3zKgpaqC?=
 =?us-ascii?Q?L2QQP029gB53DV7pKso+oRhqoqWB8Pe3T5ADVFgkj+cGfaMQf/Rz75BPJ/aq?=
 =?us-ascii?Q?l+H7LD8M2OYQkuSLGgRA/Q3Y7170x07GzA1JJSAisKEIhcy261Ib3iB793Nm?=
 =?us-ascii?Q?9EyDeOh0ZQOFw4L5XdFaQqvsqANvbz7i1r4ATA6P5dwvhmyUb8FaL4WRrHcD?=
 =?us-ascii?Q?CItOuMwOAvgnBRvYcxE4VR4ie6P+GzqdpDYrZJtNteEQZGZfT/S/FNNExGge?=
 =?us-ascii?Q?ZQlV9UmL7QYrjB85vqK0xebzhCvcKjBcoUrU7S0UY7P02sOCB2bzPC3vQNK9?=
 =?us-ascii?Q?aVOJxaqVeA+9f/FmQAasNHsA7h2Ey+aQC7NifoZ2TAFeC2n8OQtF2ymINPzh?=
 =?us-ascii?Q?scgFWJts61rMhSGIyKM9pVC3E5NdRLLHTYJUcaQoS2ZuMgZ1sKJodN5vvl7S?=
 =?us-ascii?Q?yBLB9CtycHSy4+XtJEtcLsb7Z4fGFBgON1TD1ZxKCBsVz/yQIpBnd9GskNSZ?=
 =?us-ascii?Q?eI6ITrZmGkFC6OWxhejEZrexsS1qD/G/M73wLhVdDxz96vn2iljiWWzdfLpW?=
 =?us-ascii?Q?lVQep1xRcbIsibsWs6WcnvGE568T8Olc1IIndtJgKlc8oXDVBlQuBbDeWsC2?=
 =?us-ascii?Q?jMwiZK+3HYuS3JBDLzP77X/W48Yl/gJVEicYEj9eIacuNAUsPyAjzs/QVJwD?=
 =?us-ascii?Q?t98/Oclu+ECEI+AYlX5L233BdjgZgsVmw9zINTRw?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca48edde-35e8-404d-7b44-08dd094915aa
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB7065.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2024 09:52:46.0963
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3ICxbFUMocQGGft9XioHHhtSUx/FPjM4pWBXxMLHVFwdHiXfbxlNdENJLBKrR9aS60WW+liMHk6aL1ZeUZcKWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10128

Add the board imx91-11x11-evk in the binding docuemnt.

Signed-off-by: Pengfei Li <pengfei.li_1@nxp.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 6e0dcf4307f1..5951317ce900 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -1332,6 +1332,12 @@ properties:
               - fsl,imx8ulp-evk           # i.MX8ULP EVK Board
           - const: fsl,imx8ulp
 
+      - description: i.MX91 based Boards
+        items:
+          - enum:
+              - fsl,imx91-11x11-evk       # i.MX91 11x11 EVK Board
+          - const: fsl,imx91
+
       - description: i.MX93 based Boards
         items:
           - enum:
-- 
2.34.1



Return-Path: <linux-kernel+bounces-412408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B85BE9D08BE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 06:19:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7841B281A7D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 05:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 968FA13D886;
	Mon, 18 Nov 2024 05:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="oCHTPodV"
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2049.outbound.protection.outlook.com [40.107.103.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F140F13957E;
	Mon, 18 Nov 2024 05:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731907173; cv=fail; b=kF6sJkF4ZK1VNnDQ4GE8pZMnL82fUDYCdyU9wbPqXqANmkhKewbb3AkNjWTheLO9jzB9dmsvmEIRHZ3Wpw1Lvd6v/qtQr5JTLZHt/VDwJ76/z+/9lAl5D8Xhuxc0BL197qLbQ+rT7ct1dSqehTsN9ADlRy0pU72jPBpi6fYkRfY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731907173; c=relaxed/simple;
	bh=3bCZx6m5Ly6sfot6sLPsY3HD/4V+IUEgpoQBk+COQng=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=G9ujhB64TRWwNB3KV5r4vlI6OXrIcG/mwyfsxwNPRGEUUKder9Gb0cK9CS36TfND5qdkI8QYS1LlAU8cjSu1qzfHZZAaNOL6IyaHscoAm89jP3Budy8+8ir1QevPIUyEJ43CJjgEQd2NOEjp0jPCs01lctTJr8xnE3J4bz7SZgA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=oCHTPodV; arc=fail smtp.client-ip=40.107.103.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=psOgwcHaMzLBgOLMxwTT+R1SuOU0LH2zDYSEpzfBHdFvKDIg+ENxmxjIHCCyZQHzstIT5/ivj741GK9AtaSSUGFFxcSHDX0dF8jTfG8+2QoQKJwv2amEPhYqazvvhJ8M7G82Ng2QE8+8k8b8Eai5MON6JziEaGStg6RG6GQW8A3rF0dkFFEG+MfR09+0jp1vgFTRmPt+/YDzPFyhTo5DRpz0C7R6zTeI2ahphxo4hF5BPDGMQiiSE/CSH3vZqVdhJdjJ8hgACnYF/vEd5mnhL1jNNT9YSLmeDICu8tuUwQFjkfnBXgr5Gr1GKah2SE7oIIU2ru78M4scesRaukSTZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PSqDiX6Nn/ynabAOnhIsO1T3H5ygxOOgQt2vOxuAeHo=;
 b=GLlMCR/gBIlH1VRG+KaQ+3IovEiUUbXbKtPv4PGItMNMTyxDJZu7+A7NYybPZAljyxtKZQQr8Fddr3VIpsbpsGg1YcrrI/nHQ9Lm5nBVOTFqO8DMrYFSQ7DkTZUelyz/4Sr+IOBtqFjSjCZKakedrNxtzWs725NHNbC/8cdzockhjKxniepwTBrkBosqV0tjp08QryPjMmdQBMBCNjbEl5zJAznFTnZTqWLc+FJXZQSP/z1uhMK19QVo+iLlpP5iYjOBBce8cJ1NFPmbn+3Lza4ruKe13/kgWIoyogOnVGJQayIcH6rg5FcWmpwlz2o1tAKtsb/ntGAdGAjg0hQ/nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PSqDiX6Nn/ynabAOnhIsO1T3H5ygxOOgQt2vOxuAeHo=;
 b=oCHTPodVLcI1tu8ZpX/Qc2t8bGbPuRZpXNAIV6cU6b6Y2FhJo8V/HT4GMBqVEvWar7SRVbjBqAY5Ui7CTkRc8yC+UlchPuor+Cc19uniiyLyxh0OkANtL8a2bzTYAJbQn7ePtlGZGfiFQuI+XGDQQdGGuUTtK0JJzoY6aZCsKBDqcFj799Ma8+Cb0wkn0oSsYa/A5VY2uHc1jrvkxLalDV3HwD8mSju1LauL9AbvrzcYbPFuV4MElLbeJe13yQpwB538++OF0naF4rY/JIm1KqV3hTEKSaG87EbXXZLuwesUDrJwqSTYwYBSPxVntpdzYT2nXZKVZYj6k+gV1TO4eA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB7058.eurprd04.prod.outlook.com (2603:10a6:208:195::24)
 by AM9PR04MB7508.eurprd04.prod.outlook.com (2603:10a6:20b:283::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Mon, 18 Nov
 2024 05:19:28 +0000
Received: from AM0PR04MB7058.eurprd04.prod.outlook.com
 ([fe80::d7ed:56bd:30e4:4ed5]) by AM0PR04MB7058.eurprd04.prod.outlook.com
 ([fe80::d7ed:56bd:30e4:4ed5%3]) with mapi id 15.20.8158.023; Mon, 18 Nov 2024
 05:19:28 +0000
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
Cc: francesco.dolcini@toradex.com,
	joao.goncalves@toradex.com,
	marex@denx.de,
	hvilleneuve@dimonoff.com,
	peng.fan@nxp.com,
	hiago.franco@toradex.com,
	frieder.schrempf@kontron.de,
	alexander.stein@ew.tq-group.com,
	mwalle@kernel.org,
	m.othacehe@gmail.com,
	Max.Merchel@ew.tq-group.com,
	tharvey@gateworks.com,
	quic_bjorande@quicinc.com,
	geert+renesas@glider.be,
	dmitry.baryshkov@linaro.org,
	konradybcio@kernel.org,
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
	frank.li@nxp.com
Subject: [PATCH v2 1/4] dt-bindings: arm: fsl: Add i.MX91 11x11 evk board
Date: Mon, 18 Nov 2024 13:15:38 +0800
Message-Id: <20241118051541.2621360-2-pengfei.li_1@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241118051541.2621360-1-pengfei.li_1@nxp.com>
References: <20241118051541.2621360-1-pengfei.li_1@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0040.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::7) To AM0PR04MB7058.eurprd04.prod.outlook.com
 (2603:10a6:208:195::24)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB7058:EE_|AM9PR04MB7508:EE_
X-MS-Office365-Filtering-Correlation-Id: f84d9a00-3277-4fa5-36ce-08dd07909346
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?h4pYm4L9IsyPmGCIggDbaqTlEJf27uY4JGj4yhuWhcp/XwU4GqRoWjkEF81w?=
 =?us-ascii?Q?pKLFjUtBiWU92STP/nRKZp+CQZWM9N6zSk245B040dgzPHzgXt6bw8Qrp/rO?=
 =?us-ascii?Q?QV8rfMfdLcCp++dwE7StbvdPSmdSWfIbMYTLN2cDzN0Hpm1Q9T807/+DR4ke?=
 =?us-ascii?Q?6Mk4wYLnuIUjTJusTfaoZ70lp2KMbMglx+4+60i2hNOWnXqBQLZ+kTR+Cc7Z?=
 =?us-ascii?Q?zM7WreJiLanWbEmXBViK4q7UMm2aDvAAbI1/7j+r5sfeR4BzPkSJKld9Lu5G?=
 =?us-ascii?Q?8U8fbF2s2ZRrryzUJ9W0kdHz/fXInaPGvMYNwt3uCC8Y9jFJl+cNLikH5AwW?=
 =?us-ascii?Q?mxf64Z7awCNsGYb56qg7u5nASFdAihXowav0k0gkxm9RWolpBLb+Okz+JfeK?=
 =?us-ascii?Q?a7TGh+BpYXoWnSECWHMeZYJXFTjPn7qQ+miiYINDTAOYsY8pcSmyVauAz7rX?=
 =?us-ascii?Q?6cEJBZBoQt1ABqrqMOv8ydgUeJ7U16MSSmHKP+AqO1gJNr1wkpq9dfQ2I1Zg?=
 =?us-ascii?Q?OjeYFnfoEoIF3rdtfkx3R3cUZC+aXNHvSUikSle9auY8ZKZDa2eEeIvnS/Qk?=
 =?us-ascii?Q?luFzrH49eUhgy+9kjC/mmZ5bfwOfJdOV70W82IRnhD1FJrJh6v2+qov8FCsf?=
 =?us-ascii?Q?YaqmNMbwfWF7d+KwTp7xghpiDCo6h9kbe8h+dwwNtyhXI51Le7qc9+pVfFO1?=
 =?us-ascii?Q?sDruHgv6/RYxODg2GvzKTfnQZS5olFb9W3SAY6hO0UaB13+6RmytlXZYN0Yp?=
 =?us-ascii?Q?nfqwGiO01MetYIxh0aOSmUnRA9Z5rSv7Nz+S3O6BHA43oyEKV4XprEN5y7tI?=
 =?us-ascii?Q?eyucC5K+pe4MFKHbbVH2R5xjJ5a4lymqpusNZghJliFSs8IC5NwUL1FkUOdl?=
 =?us-ascii?Q?lEjMR082VP1/50BeyF6W5zUoB+j27r4F4ybzjTuHz1YGKuxsFxHh75pNDhdp?=
 =?us-ascii?Q?vfnAvcZcEJNHfctOr9p1+2ckiqGiuMPffvBCurWv9A/6AH11qhs3yInxD1Pg?=
 =?us-ascii?Q?gy+YxjPGNy0evJ2llltRqIh2E11P6LMKSLAxOTzAtNk1uIR8r/yJiKdCNvMe?=
 =?us-ascii?Q?70Js/wOEGoL1XpDrwSa1c/ScOAaJtxAjJ40Wa9CfjPZIP52mK+QrPUsB6Zcb?=
 =?us-ascii?Q?hNE47F3TN30+ten/HUjdmEGI47NUEe8Vllbg9TiuDIc3OyWfxo/Kyyye2cNA?=
 =?us-ascii?Q?8Wz9Y39e4L0AAP1v1gCE+HSOUk8UGojTFuZ1VD5x2MEWg1qDWn4K4xBxVu6R?=
 =?us-ascii?Q?YQcsBv1GbxIMNGFJgggJ/g5K78nIQ72xJilKkuohz+1jw9fhDD9HIP/SnFm5?=
 =?us-ascii?Q?FPMtyQQ056Sa+qjTrrIRhIbHE+EiWIl8O5gU9/H40hlxCDy7zMlFcGgXiltD?=
 =?us-ascii?Q?k9dPFo4=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB7058.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?GKXlYL2QeZxtajT+YTptWCF2tDP6wqAwW06buVw2m3gXEXbVOjleolCLDzLA?=
 =?us-ascii?Q?TXw5sGkZjE87/wSiFGtgCC7HP5IJOBrobIl0YW5lzsd2j+BYxu8U+XbFZmGd?=
 =?us-ascii?Q?JLE4JMA9XJ97yaj8orm3mR2pT6K0/Yf6RK6UWOOZxxiSizBV9zwkWoL8/SLG?=
 =?us-ascii?Q?gzfQNoNwDuxnEid/aTHFznhy7+gHiNkmrzkt6l/vCQZjsAUu9dcvAAO1IxUC?=
 =?us-ascii?Q?/Ruumc4OQny448TJ7+33njgBAmdE1tX4UEn1tj99oFLsxUlA63ZhU3EPkzEK?=
 =?us-ascii?Q?fFP9QiFt0ghBncLKR4mGlsKxxmtsHTDg6TVKfOrS1XA21WPKuVZVpK94fV7c?=
 =?us-ascii?Q?sdyei493rquFXNwWwtFcRPOdiIQ/IySMdFnOK1SRgyVTVD/jxJNKV5MfMXz0?=
 =?us-ascii?Q?GH3kU84k+25IhEko2IFVOAi04r123DEh9jWgfbd4sHuUlD4/73hCHW3jzkam?=
 =?us-ascii?Q?k2BASTZQBTYUugFLK4Svk5E3IYhm8zxq11LUah5o7ioHUnrlOI5CeSUh43ll?=
 =?us-ascii?Q?EYA4JjTc8wN8ui5zy2WEuZSyEiu1otNgv/gbBj7EuFvOFNdhgFYc5RgVAL5U?=
 =?us-ascii?Q?8Iu6eleGUVKY5oOGaTU9RdjlKZJk83aYlCcF+y3I8m6acSCnOzc0QK9oDkHh?=
 =?us-ascii?Q?71NyCboNs1I3rsSmtcpqqOh4q7KCT/IFtVKneS4dSyAAsWzCJou+PDO9hzqq?=
 =?us-ascii?Q?VNR85W0vy8A10MgkDmQqmjI3yJdIeSLxcXravvxCC7XhvdEtuq0iSiP7DhZq?=
 =?us-ascii?Q?Q2P6o7kBEhEaIl923CwowifPTrXxpS8h3Gp41LF17uYLfB6HSPPYgxEuL/ke?=
 =?us-ascii?Q?qTUcx6uFDyrAkuFjSubBs5eRbooc5+YrQN30BtDwxX0bGVndluls3+U4h5rN?=
 =?us-ascii?Q?LCm5IHDN5Btym6FsbgXZbxjDlc8xuK4WjgQDBd4UqEvm/ZHpsQ0RpfGdwZ5Q?=
 =?us-ascii?Q?un/2I70rWcDqow9gpRCRHHvDX9vZjmD6VV+lKAVaMmsKBtLgMAZdlB92+Jje?=
 =?us-ascii?Q?0cn6ErCfgqolZsXCzXoB2JCrkoODkpiFN0tZTltsN5vvKAmeCOBY1zmtuZgD?=
 =?us-ascii?Q?ME7vqgN7nTbKSBktr+eugh6GMz5aYu1u2Ci4+g2OWDXd2LEAtUldwCQChw0z?=
 =?us-ascii?Q?klp3ZTAPZ1+xP4muwjzqGpEIde/V1vRuxtFeomMZryoicTK1Mv1Lftj1Nwd1?=
 =?us-ascii?Q?TV+JfPgcVAWbX04zIrZwVmEpEqKAf5GN7KR733RKUx1a/yFIfELlje8JStMg?=
 =?us-ascii?Q?y+K0rgNXAFP9BlXvLVEU7qR70IdGgFodgOOeA2UsB0ceZ5QPkMn1e3FX+GRb?=
 =?us-ascii?Q?nA0R5SzGKGEIaLc5BicD9+IMgYzxuEZamdR7N1P016ozEcNORI5TKec4ySTt?=
 =?us-ascii?Q?1YKl2RE50GxbYJXKU5tB5I5u0QUkeMz5tsJeD5joaGSbdM+QcWTFAc5vKo39?=
 =?us-ascii?Q?4OcqcnLfLqjB4pxvo3cpSfdWLCAdM+exJyGEPoz3iOdyfL6qrKeG2k+s709T?=
 =?us-ascii?Q?bVXRrVek5lOhl/0E8KuLiaM/qIIrOnd0sobxmIhFxFzhgseKN6O2ach4WmVe?=
 =?us-ascii?Q?LNXxWO8sWF2XItV/K45I7SGi0kCurAAk3h6GsIFy?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f84d9a00-3277-4fa5-36ce-08dd07909346
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB7058.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 05:19:28.8385
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QrdimyWUz9ld29spNg4fCjd81+P367r9HHUqbhTMmZNtT/xMbFIbYjN6kXtgng5ZPyyFVdAhdzvjQ4OOtNUoGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7508

Add the board imx91-11x11-evk in the binding docuemnt.

Signed-off-by: Pengfei Li <pengfei.li_1@nxp.com>
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



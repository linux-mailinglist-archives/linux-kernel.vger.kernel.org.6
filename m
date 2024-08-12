Return-Path: <linux-kernel+bounces-283701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C5A394F7F4
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 22:08:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 236DE28129C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 20:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03E9519307D;
	Mon, 12 Aug 2024 20:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="hmG+1GVu"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2065.outbound.protection.outlook.com [40.107.22.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F704317C;
	Mon, 12 Aug 2024 20:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723493316; cv=fail; b=tSA51Yl2fQHSDsQNOuubDHjCgqGJTE4Jzg0ecpNAwbuh0YOuHBySNdwIiy+YG8zLEJhvRif7kY9w4oGqV0PRgVwSFH73J1JnekuuVzKrXXx8AUqnlYslN5f5B7HUxolcLLCEg+jSdQvQ8yl9r3Xh6TGQHqApiC9pdNRNknXR3Qs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723493316; c=relaxed/simple;
	bh=UXv6E3ZDLICLqj7kCnQTsFzoLCxkDkHsmUfO0ucVkP0=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=XgW80cbWq0/TzojHGopw26AwUOD2oHzlx2GFqBOBeKc7WuwcfrHNktFxT9EB+dTHPdHN8qdbBZpib6uNbbsQvBzqsmU0UTFlnfXRihSH3rXZCsDBXatbxxLFO9oFLxJTvMfFW+fOQrxqo9h1x3uVXVI17XS/jTnyU8ZMXd8KrXY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=hmG+1GVu; arc=fail smtp.client-ip=40.107.22.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nB3pwl8+FKo1aWV2B3z4k6tW7Zh2rYZCBQNuxvG8ooc/mYmpXAiBW9cOZb/urX/a2KzBhAlf/4Qe/GIBCxzRelKj99Qsw+Q00YSq+3PSS/ipa+0CmSanHdH3Jz1nme2oQxwvfsSxfFzJiYyagUUkxQrtox11dBxxa3WaBVJCfXoJaP/RCW3PBRD03c0u/qvOqhELXzOtQ2d9pZ8ogVd5bm+46mDRzfyZRRzq8MKjmOf+sr6nN92o+vfFw24wIaCMPbVxnEFpqP/lfYFVt1NkHT6LFpM6BXXFc+jdXFFU0zeMPOVYuJkl9CNfBjROnoAOLZyxmyFfYcV4/IV4PxPC1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/FQ0sGKgLfeABzCjgwJp/ixnaaBpMmgnNuNWZD80NWk=;
 b=ZjIZzrKwZln6QTgVS0kbfytKRWzblSSebM0CLpkmtWocQ6NW7/vZQrBniYeGwoKngvF63FCAf2pBqyCCiK5RBZaLRZ1h0/sdlwMQWWkvIZ1kc8f7bfs5mJLWJ7b0TqYkP5ansXXVTssxLA2FNVuxFEyPcZ0zM6Z7CHQb68XU4yv7PfYBqsspFhxvd6QKpF+zp35mc/BYAPSEsbvjUWEgg7wzVA+Zh70aKE+UAwg7QEqWLruPaZyQ/dV+LlbmNB127iYCItLLCT089MFhiTbSXVMNEPAhL2fRxyO9323mRfu3FYX738DRiJyWuQSALrY6zfcGpy3LmTm7od1O0vA18Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/FQ0sGKgLfeABzCjgwJp/ixnaaBpMmgnNuNWZD80NWk=;
 b=hmG+1GVu+pzvVOEg4UAvWIOl5jPSddXMx0k/X5GJny7rJZqOf2ElET0Ruy9oezhhpEg+8gTwQjUbtq9gIbe9eFZIjt1iq9LSUU+H2YQ3cPSWyhX6cMx8ozF/ZCln2gIDyNvrs5uITczkye6gmfkroJV/3Newd1IfrtmCxL7QRcwXDijiPdkUSHVZB3aZgIanmnvTYCiy2S0ZL7xyiU2YZf48cBZOmL3FaBcT9PXkwXsnZHuCu3BnZg+UlpIrZBmuCpfe3mks/PsLwZ4jUDpQmn5naSMV5CBa78la54Xe7qmVsgVUX+EUg9uxx5gZr/c9mkbt/dnzyWl7Mkr/fXISGg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB7927.eurprd04.prod.outlook.com (2603:10a6:20b:2ad::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.20; Mon, 12 Aug
 2024 20:08:31 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.7849.019; Mon, 12 Aug 2024
 20:08:31 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Hiago De Franco <hiago.franco@toradex.com>,
	Joao Paulo Goncalves <joao.goncalves@toradex.com>,
	Gregor Herburger <gregor.herburger@ew.tq-group.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Peng Fan <peng.fan@nxp.com>,
	Mathieu Othacehe <m.othacehe@gmail.com>,
	Michael Walle <mwalle@kernel.org>,
	Fabio Estevam <festevam@denx.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH 1/1] dt-bindings: arm: fsl: add fsl-ls2081a-rdb board
Date: Mon, 12 Aug 2024 16:08:15 -0400
Message-Id: <20240812200816.3828649-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0002.namprd05.prod.outlook.com
 (2603:10b6:a03:254::7) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB7927:EE_
X-MS-Office365-Filtering-Correlation-Id: 7140cf3e-8963-4341-0eb0-08dcbb0a89a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|52116014|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2yCq9U5CsxQs29UQoyQGkIxaPF3tTIcVpXaeHaqf/SSLuq2zDHwGoy7wOCIe?=
 =?us-ascii?Q?AzcItKdrpEN0qGlltX8HTlsz+b2p1d1yWSJf+W/tfxsith04A6gunGHsvQD0?=
 =?us-ascii?Q?G+pa4JMpP2AtvvD8gyJSAx3duVOxqPYfM3aHrd0z/0pQJ3UBe8rOiSRU+bGp?=
 =?us-ascii?Q?AgXI4C0tVuL7od5upWTzj9eVVnwPkMP3e1It3unPCk98TdSWbmEzkiY64FPQ?=
 =?us-ascii?Q?hfZfx6n/9juQPUmg8TR5C4ZoE5752xg8Ij2fJ7eqe018fx7kD/jSDLgoLjsC?=
 =?us-ascii?Q?BpGLI5WzDsKDZyIxLNJ7kBlnhyzbIQqNZB/gGUZnfw6Tbz558erozkZ/qegA?=
 =?us-ascii?Q?zy0XPr6nENI9ADMH0q36//QCgzYF6UsHAGKZ5tUMts2yuNl4isIwbnz+XE2n?=
 =?us-ascii?Q?KjxC0b4ybwbKQV0pTtVXkxiNRF3BBZNZ4vM6eWGqPZc0Ep2hLdsW5TlSe2Wq?=
 =?us-ascii?Q?WlK5hhdVhofnYx8CajFea/2UVe+y7D02jQbVDe5oWBVSf2Ngg3ASKV+F+gEg?=
 =?us-ascii?Q?lYgN9CtNzGYXXHJZI3wM9CO/GWqSMvbnR1KkqSfBn7nw0HW/zWpnGeKpc0Ei?=
 =?us-ascii?Q?xXtMsnEb6aMLGtDK1ztuETXmeJtKdzSJ/I0T0dcCS3vGHP8Qg0v4KSHAhVKj?=
 =?us-ascii?Q?+Ko8QiWolLg2EY+0EqGBK5MdccaLiPsylu/1px+TWmN5qwB/QTE4UuIdnu4/?=
 =?us-ascii?Q?+QCPUWhqIgjndCEzXJYNdq3AnilkjaMW5MHHQ1ojTSeXYRiyxwbOWIDttkxU?=
 =?us-ascii?Q?q6P4Ao049Cj8H6cVdxzW+9JHvTrY7/aukRkWdzCu9HSrr71xiGNJzshaQRHQ?=
 =?us-ascii?Q?ZM4CJ7WPqXgUwEseDl+2dGcdv2/yK8RcxKb6cvJRdO1mnbkmz7p916YTRqE6?=
 =?us-ascii?Q?A7F1aRxPO+Z7sEstWTVsuALJOwHhUI7nd9Jf4jwHmRr913gsRkDgJPWyCUbo?=
 =?us-ascii?Q?ywgvTTBL/FOWWrTO5STENWSFISXTYaoQUe9jpmBOe/abSHNaj0lDWC+Q10re?=
 =?us-ascii?Q?PV9kV4poYtNWllwPW1NS3W/o9Lg7J+g0bmNSsOsw/NIPtxJ7w6XaOK8Or8br?=
 =?us-ascii?Q?goFHI9lRuhVe1lGcbSP8gGY/7D0lheKgWpFzGcLFfLH9cv5HiDVQS+MJ6JRB?=
 =?us-ascii?Q?CDFv5Y5JJ5AXxeCboyd1sZGx5Vc7jMD43B45hakvwms2L9Ba/X6r3K3aXgkA?=
 =?us-ascii?Q?6svq5Qk6z44yIID0wFT+hLIHL0XM4UFb/n+y2kBViWR0AUdQLUgCKIDTzwDz?=
 =?us-ascii?Q?rDIl+BDV4Dr3iuYGbWsRdq4bm4+70vrhVPHhoLBf6RTqMaJYJpvu/HOsfVv/?=
 =?us-ascii?Q?NK+V/9ryEYujeYtPdUQFQr9aLeHEZzZVn8PXbzt32JNf653fjc3noPWBKrTP?=
 =?us-ascii?Q?y2Um8k/C8fb2hrc8z7TLjLnoUBKDsEbs6iztmwrAUZiNGWNYRPyNoFC/T8zz?=
 =?us-ascii?Q?5e0AGPdft2w=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(52116014)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XTn7i0Tp9rFKRSaUJ2kKOC1dZtl3UhKYfLqT/0Lkk7cubzFqQ+UeTOsIAIXG?=
 =?us-ascii?Q?EiRx//3XmAUkfBn1rpFLhdMCXyP58MPxhgEHcf9dUX1MwnZQVHHcmZb3oyG4?=
 =?us-ascii?Q?o649SO4mxXx4o+fayOkbip5lMRvlDdZmyrDr7apQFEtq9WsZF2sf1WXjp50y?=
 =?us-ascii?Q?lHTKAtY3azSkWt5Fk/2g+p1bquKu+L0baQ1WtmPerl/6qB+koBxf5gNBuKcd?=
 =?us-ascii?Q?n2wHGc97jU2wIpXPMg4SaDv8f0SUPAz8FyK1wELl8395KvwIEOEO7fT3uX48?=
 =?us-ascii?Q?uVuHgxSxAdITGhbWmUHOdiHNWGpXCROpLwGFh5N11zgX+pG97GfCvXjx2hZm?=
 =?us-ascii?Q?vgXJpNKFvPJy7ojVUZqii6FYTe8r/8U8vFKlxa6Y0am3oZXoZFUpV4tAV0Lh?=
 =?us-ascii?Q?hwCLXqk/9HzXs7i/WjLP2S6uiUtTMCkQ0/dqsGbTdXU/dxvXNj/3g102/Tbo?=
 =?us-ascii?Q?ZNjNEYAEx+CuQdsjVA47wfpvzsbTuXHf19Sy1cV3vUbqc3S+WH5fZDnYESXd?=
 =?us-ascii?Q?hxq94M4Gt3xdB52zwpfC0gr4j68LKHOsAi9c0iIew3twThAY2ZGSjGlHkJR8?=
 =?us-ascii?Q?Y8KlF9zZzEIYKATSeQW/UXn2iSq1xgtu56oFkaIUOPFIMW80IWbgmIzEgYQP?=
 =?us-ascii?Q?7rF8zsSNg0faZ25m7MS9ihs+fJyvWSu/lostSIvbQGRc49UWCnQG4K8tY7+x?=
 =?us-ascii?Q?PgjF+YyeungMtVeYnMoxU3OoPo+1ViXeSh3JUFUs7WtzIHdsqbZA7sSApVcM?=
 =?us-ascii?Q?638kBKoRTEieQyBHIwphGmpLzEuL5cgXAKeUpGB1qF+FERnMZoMtfGTzYYiE?=
 =?us-ascii?Q?r+IL8UXGwqMkPySUMPsxfohZAfYg+Vmxwt+Zc+yva7nAdBC3ZNFG6dyn9A2H?=
 =?us-ascii?Q?JWuXWT2rZD0k9Hxth+70yYht/mpcdQmB29mwW1Dl45aOc709VlrcwILFrkk0?=
 =?us-ascii?Q?RhV0D/7A0JbjTr+S5d3ORnVieWt5hQAun8vCUzUZuaZNeyzm12Eh0db8DVhd?=
 =?us-ascii?Q?VvGDvqgf2LRmyOr6K3m1OC8nyactKe4BIZjZAQeRQCy7yej9LCaEvXqxOtWJ?=
 =?us-ascii?Q?DN9dL5I2YSk7tQQGvLb4PCBI2iRYSQwUVQvqYPRg64wE5IYQz0a7X/72NAok?=
 =?us-ascii?Q?yjWbETCtriy5Wd53Ac95zqktBG4N6TfRpo3nNxelrVCZfz/38B5seV/xpF/d?=
 =?us-ascii?Q?uxVsz9uH1g+owBv2avo+Ix4QIJ+SjiSeJPLE5SqklOjo8gpK28s81jL5Fmua?=
 =?us-ascii?Q?J07Ni9mLsqFUfffEA4dkBHMNplbp+IONw7PTTq9npPKUyqTZxSMR/SUGVFQb?=
 =?us-ascii?Q?dDdpLPwLRP4imH3XmfqfYFMDMunspvo3kLYb6tnXaJ2ucuHMshxEn99pfahL?=
 =?us-ascii?Q?UeAjZ35SSOrvEqVXdTqRVxNvAZ+Yees9GKQuYwJImOcCL4eUCe2m3kzAgdkP?=
 =?us-ascii?Q?DZAkNv6E3DsCx2jj9a0Bzff6NCliu/PNWR5f0fXhqELiNrk9pO967WtALF+1?=
 =?us-ascii?Q?/+/laAvamGzfjMUgs9oO9wV0XjcdH3yb/DPYUB4FNC87C+4ZahLJxurWbYPK?=
 =?us-ascii?Q?O2sWmAn+MW3xnu7sT3Q=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7140cf3e-8963-4341-0eb0-08dcbb0a89a0
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2024 20:08:31.5667
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rW/2O+ux7C3uj8NV2OMMVsl+7kwOlrYUjZO9ygbfXiSvVNWUDby9weaCuDmMsOj3gWX6BeD9yXknfMNVfyojwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7927

Add compatible string fsl-ls2081a-rdb for ls2081a rdb boards to fix below
warning:

arch/arm64/boot/dts/freescale/fsl-ls2081a-rdb.dtb: /:
	failed to match any schema with compatible: ['fsl,ls2081a-rdb', 'fsl,ls2081a']

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 1abdeb8044685..44a6249b62bd0 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -1524,6 +1524,12 @@ properties:
               - fsl,ls2080a-rdb
           - const: fsl,ls2080a
 
+      - description: LS2081A based Boards
+        items:
+          - enum:
+              - fsl,ls2081a-rdb
+          - const: fsl,ls2081a
+
       - description: LS2088A based Boards
         items:
           - enum:
-- 
2.34.1



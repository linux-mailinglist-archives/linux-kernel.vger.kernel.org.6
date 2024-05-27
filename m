Return-Path: <linux-kernel+bounces-190172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A183A8CFA86
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 09:51:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57B5B2817C2
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 07:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACA8A3C488;
	Mon, 27 May 2024 07:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="UVjHouIo"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2086.outbound.protection.outlook.com [40.107.6.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8CB44C68;
	Mon, 27 May 2024 07:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716796267; cv=fail; b=RQ5kXsx63GQdf3ZF2SxJK49cYME4/fZgq8X3f4O+ldNA+bHNSUVDx2CyqKP1QUyZjfTlZrUFGO9U3Q5ysll2WFSulnk36byLmmsJXGyd4Ansjj5BEd5CjwZ/d3HJjAGEN1DpU3JdUTuhR0WuTuHLWSCGPP1fujQkw6k+KsiQuho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716796267; c=relaxed/simple;
	bh=n7VoF4Rjjm/r/SArEpBsCSFx8Rl4IQSW/q2KApckpkg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=syLXnTTGHFY4hvSivTGEmO5hvVmbxUEKzUYPTLqsa1Y/jHHuFekCeOr5WhIF1Tr91wOzA25nFOxVvB0qrGUP/J7vK7timUzrShn44z/ueT7aBo3XPAKrpMeMTa2Ms99F3+e6eC52onQfbvXsDtUcB1johqCJcR2dk2fIywUgsBI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=UVjHouIo; arc=fail smtp.client-ip=40.107.6.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bzfJ3bQBn4sHzL0rZfujdQGDQZ3JGn2bbRV/EwmXWRpd5QiGqX4CPchRvln7iEvyD2+B2BhXHS+5hAHw6uEQLrO8g0F8iszAp6WJfZiWtIsfmLuZCZpKAO3+5RhR0AJ/zoQMlhkTFfY6PWyGSXOsciE8oNk5VMWx0Y2BzOEV2UfMj49cWP3D4naU7E7kdW3yUZ6pSgeI400SD4Ugqqapm+PXvg1QQ/JIaUU+IwbvFqFapUFHbpJgQ82yPPn850pCeWhapUBoNGLnP1T88ohYLG2Q7qzXjjpvW80ygMoba83o84S+1D4Lp5XIsp463ZfncNSuGD2qhFDgRHfKa5cpzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EG/qZtVKtO0uDw77N6cSzsCXRaRSyEPip4JXRowEIOE=;
 b=btlJqQZ6WbotXKEsJC3HMtqumCBpksRHEHU+m8YD2Z/JbwzH5w/cr531wmqki9jIsr7oqUaJRcAqQyVLlsnLjKGvgBfGMrSuTcr3gZjOFD7AzkHq2pOF7s0hyUXEbXrwXsfEMASY3bQJz4v30e0t+1edOAeY2vsP6Y/Pwbqyc6MdTZHAebDMR2oKqjRfqk+MsDzgjkxu1ZFRI0fQxPcJD3tcn8ID+HC38P0yzc0grlwytzzZUXMI20nggUKGQX9izwrjbqmleayy4jzQEFUB1rxQxBWgZfVAF/ZReYvZVyjbhacp2LN7wCkOEvrDOmtQwltR5lGbxDA3dA7TQfP5qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EG/qZtVKtO0uDw77N6cSzsCXRaRSyEPip4JXRowEIOE=;
 b=UVjHouIoucadEsE7CJmrYJEIBt8bjTZPapRE8V9vy9BbR9Yru+Bh7buCTmLG7cC7Tw5RW6F1xtk97v3TZyTSyuMlr0XDQxFrM931aWqtaghIzon0jUAF5mJAi1XaUWaClr5EyAqu3aC7j7SnzYDbRJNIcmMcGV7P32PivMAmrpg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB8PR04MB7065.eurprd04.prod.outlook.com (2603:10a6:10:127::9)
 by PAXPR04MB8781.eurprd04.prod.outlook.com (2603:10a6:102:20c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Mon, 27 May
 2024 07:51:03 +0000
Received: from DB8PR04MB7065.eurprd04.prod.outlook.com
 ([fe80::8af7:8659:9d42:bd84]) by DB8PR04MB7065.eurprd04.prod.outlook.com
 ([fe80::8af7:8659:9d42:bd84%4]) with mapi id 15.20.7611.025; Mon, 27 May 2024
 07:51:03 +0000
From: Pengfei Li <pengfei.li_1@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	abelvesa@kernel.org,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	ping.bai@nxp.com,
	ye.li@nxp.com,
	peng.fan@nxp.com,
	aisheng.dong@nxp.com,
	frank.li@nxp.com
Cc: tharvey@gateworks.com,
	alexander.stein@ew.tq-group.com,
	gregor.herburger@ew.tq-group.com,
	hiago.franco@toradex.com,
	joao.goncalves@toradex.com,
	hvilleneuve@dimonoff.com,
	Markus.Niebel@ew.tq-group.com,
	m.felsch@pengutronix.de,
	m.othacehe@gmail.com,
	bhelgaas@google.com,
	leoyang.li@nxp.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	pengfei.li_1@nxp.com
Subject: [PATCH 4/5] dt-bindings: arm: fsl: Add i.MX91 11x11 evk board
Date: Mon, 27 May 2024 16:51:57 -0700
Message-Id: <20240527235158.1037971-5-pengfei.li_1@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240527235158.1037971-1-pengfei.li_1@nxp.com>
References: <20240527235158.1037971-1-pengfei.li_1@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0118.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::22) To DB8PR04MB7065.eurprd04.prod.outlook.com
 (2603:10a6:10:127::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR04MB7065:EE_|PAXPR04MB8781:EE_
X-MS-Office365-Filtering-Correlation-Id: 05546b35-28fa-473b-a4ea-08dc7e21c1c9
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230031|366007|52116005|376005|7416005|1800799015|38350700005|921011;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?+rsa81Pj5sGsghbY8Ll6wBzNKuT41INhWs3xQ1kNQLgpznt2jBcQcTdW7ZFW?=
 =?us-ascii?Q?k+WHX+FAP1Us+89jdfDxknwNwA8oEmtEswST+TFA8Z1CGG5xRox3ywcZHniY?=
 =?us-ascii?Q?3DECsplmYAKyVVzGtkKxolG8ZCpnW+3WKlrV3lYa4KSyze0HX5b9osRlckMg?=
 =?us-ascii?Q?h2xBTTykUS0lcN8YhRH1UbEGpA4YwqDMPZM+lFRscSVsmIYitI52UWD+CD0J?=
 =?us-ascii?Q?YcpC34xyfnvFCNLs1KSM3rZLKtPlDTIWv2O3ae3F+rEt9b4eHIH7/Xf7MMZS?=
 =?us-ascii?Q?oVNjvF/lr/xwvFcplia8Xr97eW5dMxFjBDOs/x/HmxaD84ibk5N6xv+MftnW?=
 =?us-ascii?Q?IEScKKOlkIoitwckXMNc4/aCO/de1XEosXIBQ2LALvGCtl8fX617qufaLn9D?=
 =?us-ascii?Q?Qly3pQFQ4tME2dV6XhTxmN/JHsOgqJePKLeJtrtA2e4uR3fpbcijbRxEPq0B?=
 =?us-ascii?Q?PAmrJnSWiwkOAiGcyMXAA1Bcht+ilJ6EoDVgwvvVLr4wjj0sgIAHZoZQib8c?=
 =?us-ascii?Q?OjP7gtIrIOuQ1+1QDFqPT+NgwQQKDrjpx2t9KmJryjY4dKb17/UkXC813Y2+?=
 =?us-ascii?Q?DkGudc2cWGK3T4TtQIkI65lzmH9M4zOK//q9kfueLJVrBwv1khBW7jE8ATy9?=
 =?us-ascii?Q?UluZF4OP8qj8iCC9QDZFsRAfEY41ZD6gJFvEzMYKl58gN7P17ZvdJ5RYY+wQ?=
 =?us-ascii?Q?xhQnqvHlgrDD9CvG9vEZg6yFeVexT23l+jWY9I9SPhKF1I5EaG+c1oEGKts6?=
 =?us-ascii?Q?xheIN0MhR1rCwT9Ve0A1zyL8pVTG/TKrIruZANxM0LMAWPYVTVAfs9T4S/bV?=
 =?us-ascii?Q?fTDrHd1ws6y2xEdjk7qjMSCyptuqzDXUP7K+M9efCgvLPmfPH6bIX3+r+3cB?=
 =?us-ascii?Q?Pvtl7LWbUP3UJPdsAihPOpwxuni3xrFcWaleoVnNCrJyLxGUj75ZSSULkDHP?=
 =?us-ascii?Q?aeMTXAMj2U+gYbzz3zrc+Eo/AtjCGpKF/zo2Sqozw6zqMuggjI+ez6ZhXYkD?=
 =?us-ascii?Q?nhgNBbc6NqfuUDI2fLPe7WYRKbxfCji89ptWkGne4xELwzhEl//qga6eeRK5?=
 =?us-ascii?Q?XyL0aTY+TdlnNOvY2G3gaVmu3EMpF8T1urKbc+r/cpnxZEvBzhd//3cUrmTB?=
 =?us-ascii?Q?YKSQAHHfLfjmpTZ1i3gxSwF6ZQ5aIbkB/Ug7WWwIBOe/JljTJpCq9JxxiGN8?=
 =?us-ascii?Q?Ut29c4vZpbOpyGg84JfJtwykIoyv8ix+CUFQjv+pHjE5I9FbfQZ5TxqeeFor?=
 =?us-ascii?Q?TZotgfeJ5y544mU5WdVBWCifZ4VI1Zq11reyDI5hfVfr9HpazrkjwQuVpHko?=
 =?us-ascii?Q?vcfytTr8g+XZg6YJLnByk/eByvYn5nyYqix0y3UwRV2NfsYvJqLFB3Hkkxq2?=
 =?us-ascii?Q?Bo2y+y8=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB7065.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(52116005)(376005)(7416005)(1800799015)(38350700005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?WOYzk5Y9rmwP1l9qoA9hPY5N71+GAT5Q/Bd0T8wSW4Z7JpVE5TxsWRfr5Ad+?=
 =?us-ascii?Q?z+5A6fOGy5QJGhgESPBOtyQ7LIvm2gUtfVC72uiBybD4Kx8EI4fLgvnvA6Ug?=
 =?us-ascii?Q?jm4vxcuvJSWjy1jGzw6VlbuUCZOYRh5X2unT47TLzLFF1xuWXFoiNg1bRm6A?=
 =?us-ascii?Q?6o9qmiXQjb25FhgLyl3lX62WsP7Y9v/G+74o2fTWVaAtL6Jk649k9r+sKM12?=
 =?us-ascii?Q?BHW74tK0k3Kku3TL+eQReTA9Ci7pMBGB12Xn+4lUWbGlbr7HietskmZK9pDY?=
 =?us-ascii?Q?QMfspqCoIVfEDbh0wm6bONm7mQsdq8b8s8W8O/xreucOTvn2w9pTKD+HdFhD?=
 =?us-ascii?Q?WmUbWTdRmSF5rtgQv9pFUlICJ2MRlDGZk4HuxJff0TLSEW6r3MjGbvt8wOyL?=
 =?us-ascii?Q?/Y04mLpKh9MPDe2jMRJkLcrqUm6u2g0jKFI77JIGPNQRrp8ZF/D03/EhYIvG?=
 =?us-ascii?Q?FMod2XmE7hKJe+SQShSlqD7KiezSRdWtTKHrSt4JXwGUiB5Zlb5CT1qWj0aR?=
 =?us-ascii?Q?cZ2xYFey47OG6RI1t/iQieyQZ1O3q77gNUhJzaR1Mox0nfvGsu5VcNAV0TQE?=
 =?us-ascii?Q?DCfvXkiWUNTvF8uffexN0XHAPXlSMrEtwWC6Zcl4IC35pe23mgazjdrfFFMo?=
 =?us-ascii?Q?bGjRvy6ffVVA5w2/dqlsVPeB/grpiChfODMm3IYSrueJtLFYzPyvpMJ+amRa?=
 =?us-ascii?Q?0QLHc1eyhgBAR0VFzSg6fxYlgsEfU3SMT2E2xxfNN3AwQTaM68E2jnA+njqE?=
 =?us-ascii?Q?OShfbiSgV76ZdrSAMe+fSEr/kPHm5IbphFIA7EP6x8Dyu+SdlMFF6izEDbey?=
 =?us-ascii?Q?avPGyUyEi0jxKx8LzxZpG6VKeIAlJDc4DC88T3PPYgSzNo7Bmdm6LRctfZ3R?=
 =?us-ascii?Q?PiqJUX8aUdet829BR7L91Ri08ieYfzEccpnQEtRyb+5cv3MQMXgZ8nSFy/FG?=
 =?us-ascii?Q?eqANaGyA+uYGqqnBdNj/gwmnuSG5rTcsoBQ8JXiLwT9o8hpBoaToEvg74szV?=
 =?us-ascii?Q?dXEHyqqPO8USO4/oXiRKsoHUcrBl7EbVEs5Zj/aBt+PSPyFd6DgkHwSZCnSs?=
 =?us-ascii?Q?SX+iLq0Hd5afaJX9pGu03WgMtGwrzBrCMgv5bg9ULQSxeBx0+cBWYsWIX/zG?=
 =?us-ascii?Q?FD405cEMAwF6X4H9kOixGOa1asvNiPHEo4QxlI1H9FiD805qQ+ehv3pd7zlw?=
 =?us-ascii?Q?6t0C/ccGBHgH1haBd9oGT88c9qBiJAqm+3yQJBdbnDtWqgELtRTXtcqpwEA9?=
 =?us-ascii?Q?WAl/L1JyMkJMqmcr7hWBY8uV/sMTKr4JvSmeWoQtxi1z7TioerXlEYuh56+v?=
 =?us-ascii?Q?moaJHooai0V8d4avmBeVU25A8DinnXzhrjUv2U6PtMHYsKf1Y5beq3ayiwji?=
 =?us-ascii?Q?VVsjzHxZu5WnJOqHSDv2XtWS0Q4lUtcokxsG+3rQ3kqN0+cKqcg9Wou2kvE5?=
 =?us-ascii?Q?DzaqG2R6G2B9/GIR8tRqYqgPByBpaYwNQ3ltIo1QZeTEDWmndebuhwzDRbOH?=
 =?us-ascii?Q?xWSPEcVUN6JvlTogff8sHWY0i2XnkagfdSPjAsLmGcHBCD4YAPRzOFcP4M9N?=
 =?us-ascii?Q?kp3pHmbGSMniTmasi+rn42n+nClxWugrKWoWp7xr?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05546b35-28fa-473b-a4ea-08dc7e21c1c9
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB7065.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2024 07:51:03.3217
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: egfRnZvPA8d+DJiSwiu+vt6i9WUSzg2umZsLNgx593/wWOx6hxnn5gWG9S3i91Z1GBZ+faReh2iyIqtIj1I90g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8781

Add the board imx91-11x11-evk in the binding docuemnt.

Signed-off-by: Pengfei Li <pengfei.li_1@nxp.com>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 6d185d09cb6a..41b487ed27fd 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -1275,6 +1275,12 @@ properties:
               - fsl,imx93-11x11-evk       # i.MX93 11x11 EVK Board
           - const: fsl,imx93
 
+      - description: i.MX91 based Boards
+        items:
+          - enum:
+              - fsl,imx91-11x11-evk       # i.MX91 11x11 EVK Board
+          - const: fsl,imx91
+
       - description: i.MXRT1050 based Boards
         items:
           - enum:
-- 
2.34.1



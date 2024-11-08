Return-Path: <linux-kernel+bounces-399649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0772C9C0255
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 11:27:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAB1E28381D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 10:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A4F11EE039;
	Thu,  7 Nov 2024 10:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="QnHB5xAk"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2065.outbound.protection.outlook.com [40.107.22.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76BAF1EC017;
	Thu,  7 Nov 2024 10:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730975263; cv=fail; b=jm8df7kqiZCbaJXgt0XepAKGlDlxHUCGu2kuxVKSZBGSFc8UPDciKh1MdbEFIWZrVSkwbca6VM8wozbCjZGdseRlD95pNp21L4wQEE9Tvp9BGaqmE25dr+mel0sDj2VGG5W63CnLM3NBS3DEqj3Q8b4ponPnADGJ8YQx4UPsa3A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730975263; c=relaxed/simple;
	bh=XV2Y+5DBNuBNb36XwJMpWayedeTX7iq39fLh7uc7F7w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZWPfFXhGy91VJZ8y63wDA79pHTydlNQlBkcWcAWXydqV3lgJZ/QTrwsBqffPZ2G1FEaFfeKFPM7vSkZ1L0UfhT7WjFAWzCiStaa8ynrsdjCJzNzZ3slYaGU2UND8d0E+UQ8eoVWyjkLhMQPcc1a0KTkCD1zIlvwkqvRG3lme0tw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=QnHB5xAk; arc=fail smtp.client-ip=40.107.22.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cu5UZR2T2IOdGtOluuAmAymLVeoIqCJXxwZNYBaAalmsT4os5ZBUnuCvaBmQXz2SiVZawlj7X0+oo/XoecqmgOlREsYq69b/xJ97KbbrvSQZP2/yQixzKLt9MQqPhnwH/dSG1J3C/lhSnj09cQ8YN/BotxvloiyOBDMaXaGLKzpJUaunbI26PeuUkHO5bBL0UAlaGDFf8dK/4XD+lallg4qckSH0L12UYBISQR0aJzX36nltAcm6uvbqx4ibQnVa7mFox36hrgHhZOqihizT85g4vTJhUeUmdKKM+aX8yQF1RFoOUJwQaf8ebOg3rjz3ygFJaak90nuaKXcr6NYFMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lG5zltP4E7EK+vg9U/6tpH+Gg8oMCHMpyrq5ca8ZaYI=;
 b=N2Tw+KJbbD/qHUts/DeN9bcVSUI8Eb32SA9M5e8F6dOLapfBatbVCnvn4HAGHQYF7hOE1850h4IgNtKyX/1ZQaQAHboRkHEe/DfgnuDFcFiMfDGE6y7VPXDJIimNo6reRy9btAgntBq98U44ljfJxuAJ+f+5n4OODW+PEVnChvpoaG6SKo2CFmwKCqk314TPeex3YwC8vRKOYtYuyIL3l3y0EfodGAk60d++Hmv51sIttDFDYY5BRxlUAFrQelVQlmdq3hvQkhE7pQLwQwlPwAJfUrxOpFFkjalSG5htTWYRBLw5XXO6CF9NYWGUTe3hIJ1au1ly58Zhxnk4A4Kj2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lG5zltP4E7EK+vg9U/6tpH+Gg8oMCHMpyrq5ca8ZaYI=;
 b=QnHB5xAkjajt7QRdzSi3ZfKRaA+A37KroeB7rHewVQA9c94GwAPH7l/Jl+jbcEMBKBwnLSqc7eQOQ2azbtan+Q4t96SQQ+J4ikoUvKUCmzhIOcjE05h2s55mmPs5E2XbQsrCrmpCd1upd/G1R0R6R8D4003OVhynBPOyp56ARyp3nPDU86UC6UNWrD6Qgh/81tnIYUOWPPKEIRI3jqzoobXuehc4EVFxqjYDbK4vPA213/soGOGn09iN6/qBlwDBBf/5ZJyl3kCKD9klfHnF+7TXLW2W6fPWFrp5WEowf+l4HysDfkgv/C3i/BHnrpHaud5WbVZctT4aA5TWcLWWUA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB8PR04MB7065.eurprd04.prod.outlook.com (2603:10a6:10:127::9)
 by AM9PR04MB8290.eurprd04.prod.outlook.com (2603:10a6:20b:3e3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Thu, 7 Nov
 2024 10:27:37 +0000
Received: from DB8PR04MB7065.eurprd04.prod.outlook.com
 ([fe80::8af7:8659:9d42:bd84]) by DB8PR04MB7065.eurprd04.prod.outlook.com
 ([fe80::8af7:8659:9d42:bd84%3]) with mapi id 15.20.8137.018; Thu, 7 Nov 2024
 10:27:37 +0000
From: Pengfei Li <pengfei.li_1@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com
Cc: joao.goncalves@toradex.com,
	frieder.schrempf@kontron.de,
	marex@denx.de,
	hvilleneuve@dimonoff.com,
	peng.fan@nxp.com,
	alexander.stein@ew.tq-group.com,
	m.othacehe@gmail.com,
	mwalle@kernel.org,
	Max.Merchel@ew.tq-group.com,
	hiago.franco@toradex.com,
	tharvey@gateworks.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	ping.bai@nxp.com,
	ye.li@nxp.com,
	aisheng.dong@nxp.com,
	frank.li@nxp.com
Subject: [PATCH 1/3] dt-bindings: arm: fsl: Add i.MX91 11x11 evk board
Date: Thu,  7 Nov 2024 18:27:01 -0800
Message-Id: <20241108022703.1877171-2-pengfei.li_1@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241108022703.1877171-1-pengfei.li_1@nxp.com>
References: <20241108022703.1877171-1-pengfei.li_1@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGAP274CA0001.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::13)
 To DB8PR04MB7065.eurprd04.prod.outlook.com (2603:10a6:10:127::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR04MB7065:EE_|AM9PR04MB8290:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f1fe38c-1d4f-4bf1-1170-08dcff16cc91
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|52116014|7416014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?YFUqn+mvPw8+yUdAbYMYE6m+eES4RSWUttTTQytxcLXuTZMJ+Cpbt2VRgz+T?=
 =?us-ascii?Q?m2u2QJitMOJ+tTfpLz+qp3BF9nmH+HqiniMaNelK42cRrTnTe+uwnZnl8X6/?=
 =?us-ascii?Q?5TAXfYwt/9aZKAnzL7VkZRia58rE1C7GASQ/d66o8O4FmXqadWjsEWFDv0Iu?=
 =?us-ascii?Q?IM893cwnTSYAWgvWYGnEQorDmyFbztfTDOU2rZezvpEsyPaYITwNPqL4SatM?=
 =?us-ascii?Q?nhwKpYyZLRhxpP00ujtJUrY6uHD4Na3Hbh+L1aH8BvgcVEdE23zYuBseho1M?=
 =?us-ascii?Q?oaoJfTsmRyScHONc/oFb8X1mZAJqSip4AVEomdeq4XQ4hyumCVjEUJzYdKFn?=
 =?us-ascii?Q?A6c2+tf8XgDhiKZ1Ja1xmkGk+e83HzMizrGJx4xJiaOn9ERoJCznJ8Nj+Vhp?=
 =?us-ascii?Q?BMjvHkzWZUWB30m+ZSevNjDwzgSm0Wl4lJi0QZnNEq18FvkbNmCKrQgBtGhP?=
 =?us-ascii?Q?2IXBzLFVdWEj0rvDbci4YecRmidNGoZiEELGq2fNIEEJosCls18AeySLXTAI?=
 =?us-ascii?Q?7mTI3gfsAPce+hTwufTURAHV7zrINF91cbZ8+/v/Lpj1hGk7+oydyKqHwqo4?=
 =?us-ascii?Q?EEJ6K5hcE3pqBRGrlOacsjuFmZWV5GeOrPvAKrQi78TgxkuO4pmJlXhzmruc?=
 =?us-ascii?Q?1yR4L9LI4paolXqCAhudRDtvIuI0O9Ew/FEzGyY5Wgno19+DmMYwlY2tjx7A?=
 =?us-ascii?Q?jhL1JLFLBmP2TUCQEXoRd9VuUTrwYOkJyWkmMVPdjLyKm++LyFGGpMHB/tYS?=
 =?us-ascii?Q?ZdIYhPd4D7ALnVbDTEvAw5p0zltkld/ZCc+G/UMdVhWfove305T7V0MwEv6l?=
 =?us-ascii?Q?ovz+YnHvXZj/7xxqJRMUPzHfcpbcfJstuSk9L1O9aa/OyGj+LRwj7hiKqoeC?=
 =?us-ascii?Q?PNoUqjJG0YBAdD1P9aNowTnMYHIljat91vhSnng2C4ZlWIzLU+SHJM1N3dyi?=
 =?us-ascii?Q?f8MybjUzf8Y8uTldA5oHHtz6NDXNmS4af1Pbv3pQlmMwz1SO34RwVeiWj3JL?=
 =?us-ascii?Q?fbDMzLxZhtUlc3QZSmcaFkyuE8FV7sdCxy1yCJta9Kba4sCS4rWg6iL4lOBt?=
 =?us-ascii?Q?BBomrKY0BO/IRyoSm27wTt6+HHG9PVyAIegNwZ4oVkY2vp0qE1jYdD6n8owF?=
 =?us-ascii?Q?rmAvfEp4IXhOGvqLiyBNI2JLyHE45bZMlqkHw88YRmgiGR/sTXgKc06+MIep?=
 =?us-ascii?Q?xgWh0vpKjNNV0Eg7ycJbxRe40lUyFVPI9549eJyerwogX3bv2fMPcna6rTHD?=
 =?us-ascii?Q?/HjE+dDoyZoZXg0j01VGVo8icmDCXu1fys6UZ8b/SYZ8ZfJvQ+/LabcK+R8a?=
 =?us-ascii?Q?bX1CHt/UbR3SXPVsq3bdVpVktOxMEy2ujbthE+thcKS3dzhScZuITGGXJlW5?=
 =?us-ascii?Q?QwIYtLg=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB7065.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?Z0h2Hn1fzYzV2l7A5sVCLUk5yA1gmxO3Ls/Km0CSuN7m6qlkz4vqH+PnoNYl?=
 =?us-ascii?Q?lmfSiwXlVnD0+q8+SH5BubGDC8rpQgQbT8c3tZLmn2se4y/6iKUP5oh3ItEM?=
 =?us-ascii?Q?/l/bSyD+JBF6vg34oaIHQYk3LlIIcTO8B6BqrDQRmwpC1JJrSVtpVSiMcZc9?=
 =?us-ascii?Q?M5LpSGoaBm5FXfWQlm0Vob56iFBgv5ADLkdoA0ZWA5JdqvHsGnY+jOuRHAKP?=
 =?us-ascii?Q?GoLlHy536/eP8Emm8lJ3XwBgBpJPHmEn4v3VutSSAiP4OnYyH/gzzpGuB5zc?=
 =?us-ascii?Q?syqtGzztVf2yVYZmOpdDJQ41hNuHt0LDMsEacKp12BJ99R5+8oCSs9ZYdKAx?=
 =?us-ascii?Q?13TLflUhaqdB5BaEas0iyNKDXfsZBinr2AeHIXtnuQ6cmTzhmYzYq7IzeleV?=
 =?us-ascii?Q?aMqwlkJspOQGtnSSoUD2A3oxsmP7sKceXUd+a3XXERd/Japki5I3/Ct7evhl?=
 =?us-ascii?Q?VG1X4JtQgR/gtWlsF/OY+60Flip713xi6/cfVrXs+6ERO6/H+bQDuqdFVoVj?=
 =?us-ascii?Q?LlO1BK73Nj4IYRzZD0M1EqDint9LMvJzwOOeEE17blAJgSCMmyWRHXXdvLIq?=
 =?us-ascii?Q?pK2yYCeAI6AzQYTwTZcczK7VgDZlM3TNCSC6I/k73lkYkrT5rKh7wBmcJwct?=
 =?us-ascii?Q?Ped85vkxv8Fn5Qb6n1agFXbW8426tOfvKVh6H/H+6OQySaPRanPgFE9yJu0T?=
 =?us-ascii?Q?TxNHuCJ1Ta266qQnF9iIieFDFZ4j4Qnuxp0sS6AEPoKXACQ8z6+WHCaucUFE?=
 =?us-ascii?Q?KyVPmFeLWP7a6HGTsQO0/+vSXSzEIuKT1Nptkr/64BlfAAMFwbT75/CwioyN?=
 =?us-ascii?Q?2jL2yrYWVNMt24R/ikvr67HG9AWorlZR4Dk+nrL4wvv1/Es/qrxmC6rEvYvZ?=
 =?us-ascii?Q?NQb2phvKEsKoyAyHR0WCDGDHgdn9iAHpHf7j9Fmd+RvbIDEx6Hmj20AsXDXi?=
 =?us-ascii?Q?CBk0ym9F9761+mfNFUtPwdiU3sdUG1HWvk/X+bVU2AN/4j8vLl9puUGoEejV?=
 =?us-ascii?Q?oMBOT6ndevzFxApWKR4NlS1m0ySLjdTi4/NgGzUmbKQsCve+Ds5th1GVq5hi?=
 =?us-ascii?Q?YZRygX9kECd48dGJq4klodf1EZAdL68z2prPL8t4wpE3HBHG7KOObi0AOlni?=
 =?us-ascii?Q?viL5pW2K7PTC772pv6BWj1WBrhLmpUcgJ4y5rYqbEJHYy6R+pE9c5+G0W0xh?=
 =?us-ascii?Q?gMIpvjp/5eShJC1IKumHyoOz9X0aQuRYQAg3RhKWX3aF9LnNzK6HMsS7e5yj?=
 =?us-ascii?Q?sX1hZgPRPXuhihVAC9WIj+vpL32D67Mabmoe91DwVlzapv6GYaFbWrKK387l?=
 =?us-ascii?Q?ph3cFzXnCioJ5WP4JNwCd+ppjhN0xpFYcNARX6ZF+SQgkO+poDbcQyCIYLvv?=
 =?us-ascii?Q?Fa8M2TegUjbhB0kLp7iQd9D4yPGPVxK4GInm1SLc6RkOo9wLyyNKplsRQ1rs?=
 =?us-ascii?Q?vD8pDoB/ZnHJ6m4zzT1HW+4aPH4ije/u4Vb/dxrg0n2qx5NJhkpVDD5QREQN?=
 =?us-ascii?Q?HR95D4B78rPeqCuzvCeR8w5F3T9AHl69tND+wRUHwtVJ5Du+y/DxgHNC0d/o?=
 =?us-ascii?Q?/80DKA/U+5M2tw7mwQZmIrtkqjMsgixfocDN5NAA?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f1fe38c-1d4f-4bf1-1170-08dcff16cc91
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB7065.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 10:27:36.9891
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aLl27ogJkl3TXRXFND/p8gbmyjila/gGweY2tsiTARWYH7UePaHaGCZk7d/Udm+iHm0JTukgKM2sDDhTlIDqmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8290

Add the board imx91-11x11-evk in the binding docuemnt.

Signed-off-by: Pengfei Li <pengfei.li_1@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
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



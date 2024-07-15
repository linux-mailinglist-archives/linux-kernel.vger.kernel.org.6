Return-Path: <linux-kernel+bounces-252508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63667931434
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 14:28:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAED51F2213E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 12:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A602B18C342;
	Mon, 15 Jul 2024 12:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="HEenaJJr"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012027.outbound.protection.outlook.com [52.101.66.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C057418C19A
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 12:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721046467; cv=fail; b=kyrC+7BVjzzK7XeHFHZG2CI4ew75eYPOaq3Y5nMyMY2tdKFObXE5d8HO1C+OIYgUVOmyt9/nyVKqaLBp8w8eT3m4i2RahRk2bbprsHAsN6lfHXCGH1ipHS0Z5NqcV9Ht11f2wBXWWf7YFJGTGD4gkypXD2Mgd3NpVXzywkDTEEI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721046467; c=relaxed/simple;
	bh=kGdg0yM2T2YPRWbQWx9lCydIj3HD/YLjAWcDe6EcHFE=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=JmPR9kX44jomjyMlS4QnJ3aP6Fi7wjE/vF0HT8cpo+tA6QtBaxbx4kbRXlrAROwLXV3Om79g8bWr56IvE8apkc/L77CLREEkq0imhfRg/OP58GKhaK8ilTvSFbpwWQSfBiAo3jblSFlmhSBvw+Ti1DXaVAEu357W+Lv7PeCyJHY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=HEenaJJr; arc=fail smtp.client-ip=52.101.66.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PedaxwGpPugWNoVZW3cuiaXdvukpTznfWacok91aKZ+4E3cT+gn4diHXoEOc7QcccezOLYtCERD6ZFyXOHJEDY0dR5/gWCiL9U6o0I4Swqjeh59ZH1tCiVGfE7nZkldM5KSxMx7WTcoK4qIXPy/dafuSNdy1uUQZX/MS8L3goHJLtHT25jlDDyNMEMlxk4ymv2w3rVLcv6Ptaa0N7X10BQD6CguMewe+nE1gNV3rtN7ePF42/IZRu98QvZ8NUt8VTdm1YSjYERlmOzuny2H6czV+CRMQKkJRUeeDjyZH8aaLa0WYiKF6k4AxLqoJEbCWIbsyPHSbCa8zSA+UFsLV1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M5BBuSj2ok8N4XRaPRsEOP5pbER5be7ZO5sLCJ25+sA=;
 b=aDHdq2e1lRwVKeUVpJREKR/dnh2ln9CN7PYl29fpq7TUPrQJ1AjB6U9q229B60vuyeQFBTg+s6RGRWO2VsD5Q7PUwW7DHyvrIalIf5WGxkZU5ZY4jeRyLAKSQrEqKy8wBOqu/SHCo3P+pL/WfsBSbn1HnasZjWpT/r7lzdNsyT3i+q/8qBnQDL0qyJlM47n1XH+tXCVxgdm8YVNqzZYj+1AFf0Ecf9k7UXsX3ds2j1ttaClx1o9LsabPzZCFecqEdD+9BbjoFYCPNr0u/TR2GYQUDRB8vUac4S+kMgOykmpSCL3EwP0rxiGUrAjRKhk1Up3dGKdF9pJdjk6ifAQlqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M5BBuSj2ok8N4XRaPRsEOP5pbER5be7ZO5sLCJ25+sA=;
 b=HEenaJJrD0k37R0EXNAmZMi0TTn7kxmsZrriybiwCmnuqYOquywIT5Prdge0Sr9GthXlvayFu5rJbb8kZUjXmYGQ5m4hhlijAkwOHM1SOzgRWqDSgNcwdbIXkBczuWtKPtfJ1fqhqIithusdzOLl24hLeZ1Uo8pVb6HBk0Xhphs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com (2603:10a6:10:2cf::20)
 by AS4PR04MB9650.eurprd04.prod.outlook.com (2603:10a6:20b:4cd::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.24; Mon, 15 Jul
 2024 12:27:42 +0000
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197]) by DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197%5]) with mapi id 15.20.7762.020; Mon, 15 Jul 2024
 12:27:42 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: shawnguo@kernel.org,
	s.hauer@pengutronix.de
Cc: kernel@pengutronix.de,
	festevam@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] arm64: defconfig: Enable i.MX SCMI PINCTRL driver
Date: Mon, 15 Jul 2024 20:36:35 +0800
Message-Id: <20240715123635.2894222-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0011.apcprd04.prod.outlook.com
 (2603:1096:4:197::10) To DB9PR04MB8461.eurprd04.prod.outlook.com
 (2603:10a6:10:2cf::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB8461:EE_|AS4PR04MB9650:EE_
X-MS-Office365-Filtering-Correlation-Id: d4e39b69-0a30-4e3a-d487-08dca4c984da
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OhohSuqVtzkWnJpCE9YSfNUx/IkMzg8o/k0mean031ibyPR5V1LZJ05dQ7TV?=
 =?us-ascii?Q?CT12lFm3Zox7QzKxB3t1DDlNvRsw/NgK8zzUlAuKCnErFrKIvTnzqUvBUPEp?=
 =?us-ascii?Q?ZpYRoMeTfv6AeNk36tHQBCFPHdaHDVkPeabqG25VQFNW/tQdSbIe/Zcy+SgI?=
 =?us-ascii?Q?gNnXlqB1roC4Pnd2YZEXjPKI53gyNMtBZbTYBR08SCQkWueWjs6B+qcS0XBa?=
 =?us-ascii?Q?KT3aWqObk66WoH9PuwSTRt1Eaf4ev8wbZ6GXZuw43fezBIkod8txttzCzjR7?=
 =?us-ascii?Q?Yq3HhJR3G8gIND5qM5SVMlQFj4KLpo0/qUrAH7xylO0s13x2HeEv+HEJiOan?=
 =?us-ascii?Q?QHAOJP9HSQnERnQMLW8a5SzPBXSMY3gqdNvxQwmeSGhitgahyowwVXcRIxsQ?=
 =?us-ascii?Q?z/uEVCREUQwvWYRMOnwUvKnM3r+0ewDS1ZQSY1DgFXf+VSY7G3nty5zMSJVW?=
 =?us-ascii?Q?7vCB7nampLPeg8uDANuOI6vLjiv2/ToN34AcuK55oyOvsWV2e17HR+d2LXmk?=
 =?us-ascii?Q?6A4Xs9pxVA3JrTlj9PQFt99Q/uo5SIe7NSLgzX11Goeln1rRIzcJCfUL0cXZ?=
 =?us-ascii?Q?zikN9fBoYxD6u7YZn9MxxA+cFUJ7kc2AuTmV82jCncspsrZhXZ0a8CCo77OS?=
 =?us-ascii?Q?tYT5pKsMzLPIpGEOonZ2KqrvkB/VqdSBvaS4ALLj6XHj78nPOSYO/xgnDBUp?=
 =?us-ascii?Q?kxiVNiQ9pNMA8N/8eR/2rLXDpcwfQ5guumRvr23AoPZjvFmfuRgPUJgElNTp?=
 =?us-ascii?Q?ugX3c0F9CCotzqFMU+v90shM5dMuYylyPFo5uhszQp0Fln+voLpnZFHgLVaZ?=
 =?us-ascii?Q?eGbJURGHtUCkXrepzQIrE4sRoFh8OYzRpTDql2hDFA6O9UhzkmQA314kmmE5?=
 =?us-ascii?Q?eElhkekscCFQ7Ob5OOPXjm+ZXdBI4GYKrTNTqCOK0mDo8N23EyAPFfJQ0Dz4?=
 =?us-ascii?Q?LuJsaraC5NQpRuqIM8/MGehOjlYCZVGn7429wz7soBDSVeIvoVHMewo7KR9d?=
 =?us-ascii?Q?1yvd6c5eFQXU2RS4gYitSdV++sqtJvHCcHnJECjkDKFKJuzXo9gxGzXAXHoJ?=
 =?us-ascii?Q?m7STc/x7hM2/aEtl9Re7jE/VSvSwcj46A/lBV5ZpuHevQPDf32kaeN/cCdQf?=
 =?us-ascii?Q?7Yq0Rg+1wzUK4x3upMOByeA0IxSJBRoxCMe8n8i7Ss8Dx2sKWu/BqR8NcG6i?=
 =?us-ascii?Q?+Kh8Wv7psCkfPvFIXE/TErrwu70pi62LjDG4NF6LkME1yXLYDX6Vm3jGiivw?=
 =?us-ascii?Q?1CD0jGvqc0brHoPq+U+F5HibgjFosVU1WALmgPD2IizVd6S8f5S2Zkck3LUr?=
 =?us-ascii?Q?Da793u2vf+W0G3LjOx5BHFcPreW11h1ZixFQGAiAuXjECB7l2WR0eGRAubB7?=
 =?us-ascii?Q?wshVUQnz819piYMZCUiqSpIHUK10oc/Nv1J8bOOwQxFpsGoGUw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8461.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aAMzZicNmcN0Es35xVPiyEGxleM0UOm7GcwTwFKdchvXH3azu8UAe0KOg53G?=
 =?us-ascii?Q?STJr3b+WJnnKXGJXfEvtghIbyRnDKI9UppY+i87EfNO92e1b4SrZDKClGztb?=
 =?us-ascii?Q?6MqIdStKQ5eetY1RzMS/TTWnnvysADo1+x7RLMPhMmVkuMxIZukWwrEbH6mM?=
 =?us-ascii?Q?aOURLg3xM6+Fe2AJj4ogNBBLJAOjpI89ytKo2CHy7LBL+VZwBKVaX72g1djw?=
 =?us-ascii?Q?NtZyAHjETVoYqrXRUeZXh6K6Kn0g8QBBkakGKlLtuM8nyAstNdVvJOFsNQ5R?=
 =?us-ascii?Q?SxRvxGDMcDhEtrXLafawMj5of2jv2YpBgTIBrVLsxCjcQAjDNQtIPpXsql7Z?=
 =?us-ascii?Q?CZYtF/lZLuIi8a5hv/sLp4/KafgPundNHLqXc7DyVh1kcig1Gj3EXMtBTQHV?=
 =?us-ascii?Q?8gfSw5z2u9/iiMmsgu1vcF1ugoJbl8SUiqraJR5LtBiwh5W9y1U9NR5V5dlk?=
 =?us-ascii?Q?EoIj4ns1bZ4h+cIqHCx0lFVNpdRJQwTDz4KYSyfqpWA3oZZwFYLjHZsVczUb?=
 =?us-ascii?Q?DBUF3sO5n/z5IzDgRMOMNYtmR54IMTTFh8dryqQJOhPc7XLrsyXCCkz20AuT?=
 =?us-ascii?Q?fTLItTc6xnWZdg+urW7LyePxU62/dFtKz6t43dEyn2mwrynUDF7QYUe1/ILI?=
 =?us-ascii?Q?aPqmNX5L8k427dq7yNXuxYifejBI55XpbHODDiBzegr+P1E2IbTinotDhL3G?=
 =?us-ascii?Q?PCyWzdnnO5v/2YBspdrA6nVixBJboZkvFP2o63NUMB+bHItpF2svfu/e2o95?=
 =?us-ascii?Q?MEBv6mlKDNyNdEbqMGaUfYGi3wloFCZdIW6PSUkCEv/ZyWvAAnm3RVNRV1KO?=
 =?us-ascii?Q?vMw1hIycm1+kxHXlIWmN6lrYHvF+gLUziRBDWHqMEDKIqqwZli3Fl4OXtTqB?=
 =?us-ascii?Q?pNI5lqg9ge1dE11Z48R5uen5+mBuL8d0j9QChgiOGvyS+qINxJBykC6+JV+1?=
 =?us-ascii?Q?/wFWbSwPWX4gkW7V/DiXvHn36vMon8FE62qmfYhIMXjgYY+42CZTHEkhkUX4?=
 =?us-ascii?Q?2i/dCAlrwVMbp48qBYrMwnW953E2I/5Ge7Tk7N3g2jfDfJvSeKJqs7QTWEV9?=
 =?us-ascii?Q?h2rDrzlUcHKXE0lHPxEe1ZXjaq+Lo/E0qovhE9+KkBkcB5w16Vkt2fWR1qtX?=
 =?us-ascii?Q?dWFEDhJecZGZYILUGPmy/8/ocLTtUOG7V4R+cCc4tuvECZJnUpkcmaEIqsim?=
 =?us-ascii?Q?5tyhkPwAfBpf2ceL3BuDXmkRibKY6dsXkIANcih52pVUr3hnVaEFRCZ4hlXP?=
 =?us-ascii?Q?wu768xPqO8y/qH97LgFwoAws5JZTPPYUxZanNBsYsrHTbroAwi1I97rZzqNp?=
 =?us-ascii?Q?/W7xWw4IWY07KkrMIJcjh927JaWsIfGQjG5ttqRNspFg22Cf3vbTNDd4Hguj?=
 =?us-ascii?Q?nNdL5SqTYHWpp7JY/hLZiavrPS9iaRdSHVjpSAkncQNe5lynrqQ/XCpOFYde?=
 =?us-ascii?Q?+FvEJjLP047NNGC0hbu7gSPaXTKsHFOzVc+ktyE/jKFUY2ACuiLHGSBsbur0?=
 =?us-ascii?Q?JA87MDuUTHPDZ/61ZxaW+ktHRnNnh8XQKqVS2luFQLDSSwbsDp5z+89QI8Hw?=
 =?us-ascii?Q?KQDIASSAXO58UXKaSqtMLBHjcMXnnz5flUrtRWni?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4e39b69-0a30-4e3a-d487-08dca4c984da
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8461.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2024 12:27:42.0538
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VsObL4LzHqxc9JVCebYEFaajrk4D8V86eItFzdc1uLVsvuznhSk2G5exZoyq10yU9O9dPZoOOl0NLHih7IwGAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9650

From: Peng Fan <peng.fan@nxp.com>

Enable i.MX SCMI Pinctrl driver which is for i.MX95 IOMUXC settings

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 7d32fca64996..764d9b6ade3f 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -581,6 +581,7 @@ CONFIG_PINCTRL_SINGLE=y
 CONFIG_PINCTRL_OWL=y
 CONFIG_PINCTRL_S700=y
 CONFIG_PINCTRL_S900=y
+CONFIG_PINCTRL_IMX_SCMI=y
 CONFIG_PINCTRL_IMX8MM=y
 CONFIG_PINCTRL_IMX8MN=y
 CONFIG_PINCTRL_IMX8MP=y
-- 
2.37.1



Return-Path: <linux-kernel+bounces-383574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B2E9B1D84
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 12:50:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFC951C20A9B
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 11:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 819A215DBB3;
	Sun, 27 Oct 2024 11:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="YQcTkask"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2057.outbound.protection.outlook.com [40.107.20.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7574B143748;
	Sun, 27 Oct 2024 11:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730029811; cv=fail; b=V8q2Oth1EqIG9Mahqdn3mOEGZsndFPlYR2c73J5gqWwn5MajckWOT7tSd8cazOATmI9vzyZV778XIO6oFfgni4sqgLfXK98kQJ3BZV9RC4rB7DEl//TGE2lvQyW0/LKbVayWFV0BbI7zBftbAbDlVX/ARyPt/ABJMPf5e924ErY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730029811; c=relaxed/simple;
	bh=v8ksMBxvbeVAy80xC/9SxZUA+6+FZGxZgqOBK4nC2MI=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=WinffXDGB8AmbpHULMkoyGpLZDSEhiG3P8sKTnkjVoOk+01DBAF1NRgmiATejNqS4PTae47bdCWAQ8jh6wp3FLkGHF1cpgJ4099K4k6mS/yIw8N/FKDrewW6+O6M3hBAE2d2WlTC5/kgN11i2QjahavbZxoazpRx00vtqgVcbb4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=YQcTkask; arc=fail smtp.client-ip=40.107.20.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=piBVuTTKK06eVHqGqS43YEnuv9Z9lJ0g521YaOyihZnFW1/aJIvZvjdSiuN4O3WOlpQNCNaVTmd3wFRjhtbKG45/T9wV7DhSK8gqskPk/gO8dsn/4Bc+N3dQsDPwBrSnYNmJPHp7rrPYsakpdMFe9Pv4OJFRb6Vhvnw2D4l42jVMh+2lVqcuaPqD51SS3NiwXBSUMjzbTIGrmnRbKr+l5jGt7Eey+2fdlVtCXxJ9xArRk4JwGPMEpu06Vd1aiDDJ+rkMG+HhZTMzZE9TE2tSwKnHynH8TPDx4pmuLYvis0k/jaX5X8jnfSITwKcwB+ffgO0so6ALvCVNJYKOhZkJxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tll9CQpoI2JYPFCpRJcMtd6vZ7urFG2dHGkXxAOPskU=;
 b=xwOc0zGRpcFFjA3pMTlXRC/tfqNd30tGlAQteqAJvQc6oMxuUMGr6eRS9/mLVTmaT/7ItZJObzR1Q2UU2BlW1Hehbg9DdzyeIn6qkRAdgGIlbIllEGJb+HIMy/IvCFYG337/pGYH0NEEsuHHutnUTMy4Vr76bxvC6/da3NQ4XgmCE5xy5ZgSnyt6ubDEOsqWm01qQDm4w6LMn1eTq9WByiBx3jeOEFtkUogjvyCmhlV1M1n1PvqT2ipQ7wKFDOsw5/pFZ010ookIg6dAtTSGFyttPunZ9yMbe6f9hRBOY7UNBeIwUTzkmCMusVOU1LjB3bMgJG/aPCpZQmYBtM+78Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tll9CQpoI2JYPFCpRJcMtd6vZ7urFG2dHGkXxAOPskU=;
 b=YQcTkaskB3Kf4CuLdrp72dQroFURhmPGTQReBlZOnKaVABcAwwGXgpurBVFcXeArX+pmeiRGTd9aEnyULn2oN8oBYNXI5OJMCGuphLeHUh0ccCfUfvAHlep3x5YXL7s74/QqtlxPOMOzPKDlvIh+4qx2QArWS5ucWQBEtl83unlucKt0L3CS5dMMH+d5kgwFXOgLMKYV9f7Z8AuS+uANiB1cTFrMlOk+4joxUh2OtFU+dOMiJl17FwyxSnq9O/PAOrHhz7ZXj3xl6vCwvK4yt9AUgngTLOOVC8d2UCCdGJe2KcKl6p0grdEhb95YLyn/AgjdeV01fuk3GOW1TfGutw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com (2603:10a6:10:2cf::20)
 by AS8PR04MB8689.eurprd04.prod.outlook.com (2603:10a6:20b:428::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.24; Sun, 27 Oct
 2024 11:50:06 +0000
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197]) by DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197%5]) with mapi id 15.20.8069.016; Sun, 27 Oct 2024
 11:50:06 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Sun, 27 Oct 2024 20:00:08 +0800
Subject: [PATCH v3 2/5] clk: imx: fracn-gppll: correct PLL initialization
 flow
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241027-imx-clk-v1-v3-2-89152574d1d7@nxp.com>
References: <20241027-imx-clk-v1-v3-0-89152574d1d7@nxp.com>
In-Reply-To: <20241027-imx-clk-v1-v3-0-89152574d1d7@nxp.com>
To: Abel Vesa <abelvesa@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Aisheng Dong <aisheng.dong@nxp.com>
Cc: linux-clk@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Abel Vesa <abel.vesa@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Jacky Bai <ping.bai@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730030419; l=1523;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=Sv4CHyV16UexiFdZ+yIX03Ey/S7U3vzUPoU0hMATx6E=;
 b=49dTChbtqNlnbbplHLJZs31aa3JMeZB8wQmI3HcIGYjWcHArhOOQo1+zpUfbsOUg/q8r8bdpW
 raQGeeSPMZSDY/3QieffMt3cBIzDxzf+6Kjj9SfZTHUnJwaVnajluWv
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2P153CA0011.APCP153.PROD.OUTLOOK.COM (2603:1096::21) To
 DB9PR04MB8461.eurprd04.prod.outlook.com (2603:10a6:10:2cf::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB8461:EE_|AS8PR04MB8689:EE_
X-MS-Office365-Filtering-Correlation-Id: ff829c43-855e-47a4-77cb-08dcf67d8074
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|1800799024|366016|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R3NCUVZJS09UV2RvQzRkM0d4Mm9qVFg4TGpZQlZsZjdtbnZMVEtlaHNYLzRz?=
 =?utf-8?B?R1pNbzEzMTdBWmNOVmNtclVnMjlCT3F3dTA3bVFQN01oa1RTd3AyWkIxNDBM?=
 =?utf-8?B?T0hGcEVDWlhEUlFuRWsxcEZQeTE2NUliVjNWaDNiRktpMlU3aC9oQ1NOeThB?=
 =?utf-8?B?bTFXTlVhSVdZYS9RcW5sL3I4QUZ2MTY4ZXRSRmlzOXN4aER2QnFOSkpDcEpk?=
 =?utf-8?B?TTViWGV5MHF0UEJmY0FOK05CcXpWSlJJSnNzM1lLcThWSlJtZ016NDJYVGFy?=
 =?utf-8?B?M24yK3M3OUMyR3VMN1hyeGpvWWhGM0hocWlqeCtkeGFBT2FsSzdoc1NITmxM?=
 =?utf-8?B?TGpxcTh4NUMrNVhxbGlPaUY4dmYyUDFDVmxrNFZPR1plTzFpTFhpQWsrUlpy?=
 =?utf-8?B?VEJnOVBFbDZYU0ZoRzYxQWgzS2RZRDcwTEVzQnRXS2s3YlFJQWdqc3JXN0Fx?=
 =?utf-8?B?WDZBSmdPSS9ONjl2c2VSeDRQdWNPTEZJS0crRURYWDRXUFlzekhwbEY1WjNn?=
 =?utf-8?B?S1dOakF4ZnNjUC9JQmRUNzhxVTlKMzdmMW5yaHhqVllKWnRSUkkvT0VHNVRR?=
 =?utf-8?B?V0F2djhXY3pCbElVYkRYWVc1V081TVR3QzlnSm1vVE4xMnZqdzc2TGNxUDVW?=
 =?utf-8?B?akhidHIwQVRpV1AyMThhYjNiOVI1a0phWHNOVTdjaXBjQ1dCRE5adHppdVVa?=
 =?utf-8?B?d1R6TUxBZHJxT29WYzFuMkducjJEejM4OVJodDM0aFM0MjQybEZtdVpuTm1K?=
 =?utf-8?B?NFE2blQzc2ZhNWQ1YWRJTXBTMTdSMG1GV1ZSSEFuMlZsa2UyL1pjUmJTemVm?=
 =?utf-8?B?M3VWVW95R3FyU0UzcnBLaEFKQ1VSM1RWN0M4SU5NNWI1MXJabG92Z1JFZ3JG?=
 =?utf-8?B?bEZ4U1R3WjEzamlCMmJyc3VIZW43NmRZMnBXd2Nkd1lheEt3RjJvMUI3bFN1?=
 =?utf-8?B?dkFsYXBsVlZKVVBNUVhDd2ZUN1BpZkJTQmt0dWVtMVhpckZrMUtQR2FIbjBH?=
 =?utf-8?B?eC8wZkd1VHZuazB0Vjhrd2VzOWsvZFc2QTJxSVdObk9zUDhBa1JMaGU5elJX?=
 =?utf-8?B?a1BMaHRoVXBndVc1TTB0bHVBbm9yYVRrcFNQLzB0cWRLRy9TQ3Rhc3l0UWcz?=
 =?utf-8?B?aklUWU1OanVDd3FUc3VXWnlFSXJNdGtGTm5LdDlTZ2tvSnFlUU9QQ29GMnpv?=
 =?utf-8?B?MHlEQkRiNHlzbDRycHI2eHF5Z1RWYlZGWm94VCtkcW5qVWR4VzR4dmo4a3Rm?=
 =?utf-8?B?U3RlWVFlWU1DaGl2SktHR2xNbW5OM3FLSDlaa3BRbTdYTXhIeUVpYkI2WlBL?=
 =?utf-8?B?cncrbHR1ZUQzTXN6eVhRSmxLeDZVWlM1UGwrQ0JYeEx5MmZ5akZUQVBBVllX?=
 =?utf-8?B?NDNvQ2ZYN1lUT09IZk1LTVlaWjFkQ2FCb3lCRXJkYjhEaFRJQnJWSExPOEM5?=
 =?utf-8?B?SU52Q3VzOUNHbVFuZ0FoL0t6SUhoeXFjVHZFR21SM3VNdnRuMTFOamRwd1Nr?=
 =?utf-8?B?YVZEeGFTdFZqaEtjOE5MVjEyZHM2MFdSdXA4ekNWWWRHeEJIT25pV1JiVzlZ?=
 =?utf-8?B?QTcxbFU4S0g0dTJmOG1YZXZTc1ZSbm5zQ2JUdGFLRmU3L29OUVVjYWFmcGtt?=
 =?utf-8?B?VHU0bDFQYlUvNDgxa0xST0ZsN3dTUmh6R2kra1I0NnBLV1JWd1RDUmZTR2Rz?=
 =?utf-8?B?RHhzY0QrKzZyT1NZZHBNUkltSE9sY2RPOGFRZzh4Vi94Mm9ocU96d001ZmhO?=
 =?utf-8?B?S1MzR1hHRUVYSnYzVllFVkRSRys0eXByc3p2dlIva1FyVnBWbi9sYzlCanpB?=
 =?utf-8?Q?KgtNJTaJo/YLGQ/fdYZ/ChXdi03wYLkbxFuSw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8461.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(1800799024)(366016)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UE5semtyUllxRkVnOFFHZGNJSFovLzZXVm45ZW9wYXRYV0xBZjZrRFByb3lS?=
 =?utf-8?B?bXEwR1JSYjYxT0haVWlhdEpnWWZkSHBoNDVrVFYrWUJsdTdYbU1vdjdaQ2Fh?=
 =?utf-8?B?R0tQSkRMeHhsdUtzRytVWGhBa2JmbnpUQ1h5MkVIWE1DV245NXk1VlpCZS90?=
 =?utf-8?B?NjBjcWQ3UW1qR284aWdOOVZzQTJrQnNjSlJVeWlLYnBNRWNibkM5UWlXeFN5?=
 =?utf-8?B?YkJZOXdyTHAxOHZiRUMzS2hmb1pFdEVaVGJ5SHdObHJhUkJXZkI0MEZTbUlU?=
 =?utf-8?B?VkU3WWFUNkhNdkQybVlIbmdlblZBRENQTUtKTDlCK012ZTIwU1dOSUFodUZV?=
 =?utf-8?B?aHF4dmhnbEhXOXVtTmRUUjdUSjdScWFLQkJKbVptVnBEQjJ6Y2tXcG8wbnFj?=
 =?utf-8?B?aXN6bXloSHRVbktGd3BzMGVCTlhxYkFrVlhUQVVER2ptejMxcmIwMEN6VC9F?=
 =?utf-8?B?bHRZd0U3YUZIbStPTjFrUkFkUGwwZDhCaWpFQkx0KzliQjZMUGxNSkxOVU5x?=
 =?utf-8?B?VWpxOGNmL2crTXdWV0ZzMFFxYUxqMXdqVDJqLzlkVEd5VkdHeVFBeEI2d2Ri?=
 =?utf-8?B?eEJOeXhmRFZtd0Q0ZUZXeEd4d2YrY3FlRFRZNEpiM2pYd3NSUlBIQjR3SFA2?=
 =?utf-8?B?ajhIelo5WVdhV1NSejV1TkxJd2dZNXdDWWEweHo4b1ZOeGkwUmR4TFBINXJG?=
 =?utf-8?B?enZNWFdjeUtnT1JidUlHc2VjenFLTHNZRE04RFAyWmRuNUlSRVRLb01CMGpB?=
 =?utf-8?B?L2Y3RDhYWHZSVnJ5MmNEN3VoR2V5V1BFTmpZaVVLbDVZODhUYUpZYzVLWjlq?=
 =?utf-8?B?SFpnNnprcFhtWGxmWlc0Y3o3Sk93ZEQrSnBWRGROUmZPck1Kdm0ybEM1N09Z?=
 =?utf-8?B?aCs4R2xuZVVsS0FKamRZbVlYdXVPUWRrTGZzYnhYdEdVU20zeXVQOXlpZldG?=
 =?utf-8?B?OGg4S3ExOXA0ZUFPWlYvRmRENnpFY0pEN1dyYVNiZk8xbDVWM09aVXFmaTFN?=
 =?utf-8?B?N0JubTZaRkR1V3poVmhQa2dMSkFhMlNrWGFUaC9DQmYxWUdGY1E4WU1VZkEv?=
 =?utf-8?B?REVGV2hiSlN2ZnppNkc2elZsVk05TlJ0NEhUUWVtQVRzdWQ3TTdVZWJRcHhG?=
 =?utf-8?B?a0ZvaEVvQXhubW5KY2srb1ZjQ1V1SGZkUmJHQ1I0SVhxQUMxV05DQy9oM0Rk?=
 =?utf-8?B?OG9INEtVTDZGV1NZaFIxVFNBU0o4ajVxWVVBSytFcXo4VW1CR1dGUTNYU1ov?=
 =?utf-8?B?RkFpMkZGcjRpYXd6Rmg0T1gxQzNzLzN0Rlc1OWdjTzYvS0VOU2JBaVJIeStk?=
 =?utf-8?B?a1hmZlNlY2JySXpqNmFSVjJvWGZCUFlTaEpEZWpWR3pmQmFCUUliaG0xTFZI?=
 =?utf-8?B?eHpRc1BDTHhOS0p4TDNkbzVHTGk5bUdDc1dVLzY0SVo2NlhYRU9QclgwQUIr?=
 =?utf-8?B?eUZNVDV6RS9oMkVtSmI1Yjl2T1ZXK1AyT2x5UXlzaU9PSDNTZVp3eTlabFJL?=
 =?utf-8?B?KzIrQ3B3SDJaemd0TmxxMXd5andWRjgxWndXdGN2Q3JjYlh3Vkdsd2wrQ3VE?=
 =?utf-8?B?b2FubFVFRVBLK1Z0QVpKUnR5RG4vNGVERDQ0dWhYT0VzSjRFZDAweUNNUktF?=
 =?utf-8?B?UlBld3pCK0lUTUpUbnRiM28rVE9FZm5NdnRyazVaaUx2cGhyRzYvTUZYZXAy?=
 =?utf-8?B?eVpOVkhqODJkdjdoNlZrK2FXNmp0WUZ2TnV1UnJGS1QvOVZQS2F5cU1tUGJ6?=
 =?utf-8?B?bDVpL0lDNXpuU1B0ZmtIajhwTFJyZW8rYWJGTG9kMlNVMWtSYmJzS0p0N3Rj?=
 =?utf-8?B?bDQrMUtVTHp6dUMvSFBjOGw2RlVwUTNoa1JmR2dHOUJhYWVja1F5UGw5UllJ?=
 =?utf-8?B?U0RvMXVxK2JYUzloNkova1FEVDBaNTJtRW9PYjhQazFRMUM4YjdtSDhaR0pY?=
 =?utf-8?B?bzhMV1o1aDE0U25UUW04SkxzRFl3Y25idVNQN1l5L0FXWDFPT0JRdVk5QVov?=
 =?utf-8?B?ellhdXp0cSt3NXZ4R3YyTHdiS20rbDlhLy8xb2l2aG1qN1pxOFQ5aDZrRHBF?=
 =?utf-8?B?OFNzd0dWMUY1bWVvK1lWbHhwazdNWXA0UlFrWHVNVzRsc0dJUUxiU0pkVkZE?=
 =?utf-8?Q?77MjeT9gicBzXFQGaZWKN3shH?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff829c43-855e-47a4-77cb-08dcf67d8074
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8461.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2024 11:50:06.7154
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2wIsLrDTn//xcATs80vZQV7UC4xs1icLhT900I2aA5/iLuADWkSnMWclpAQm3Us35yO61OQZeuN4Lradzcdt/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8689

From: Peng Fan <peng.fan@nxp.com>

Per i.MX93 Reference Mannual 22.4 Initialization information
1. Program appropriate value of DIV[ODIV], DIV[RDIV] and DIV[MFI]
   as per Integer mode.
2. Wait for 5 μs.
3. Program the following field in CTRL register.
   Set CTRL[POWERUP] to 1'b1 to enable PLL block.
4. Poll PLL_STATUS[PLL_LOCK] register, and wait till PLL_STATUS[PLL_LOCK]
   is 1'b1 and pll_lock output signal is 1'b1.
5. Set CTRL[CLKMUX_EN] to 1'b1 to enable PLL output clock.

So move the CLKMUX_EN operation after PLL locked.

Fixes: 1b26cb8a77a4 ("clk: imx: support fracn gppll")
Co-developed-by: Jacky Bai <ping.bai@nxp.com>
Signed-off-by: Jacky Bai <ping.bai@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-fracn-gppll.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/imx/clk-fracn-gppll.c b/drivers/clk/imx/clk-fracn-gppll.c
index 591e0364ee5c113859a7b6271c8c11e98a0e0ffc..4749c3e0b7051cf53876664808aa28742f6861f7 100644
--- a/drivers/clk/imx/clk-fracn-gppll.c
+++ b/drivers/clk/imx/clk-fracn-gppll.c
@@ -303,13 +303,13 @@ static int clk_fracn_gppll_prepare(struct clk_hw *hw)
 	val |= POWERUP_MASK;
 	writel_relaxed(val, pll->base + PLL_CTRL);
 
-	val |= CLKMUX_EN;
-	writel_relaxed(val, pll->base + PLL_CTRL);
-
 	ret = clk_fracn_gppll_wait_lock(pll);
 	if (ret)
 		return ret;
 
+	val |= CLKMUX_EN;
+	writel_relaxed(val, pll->base + PLL_CTRL);
+
 	val &= ~CLKMUX_BYPASS;
 	writel_relaxed(val, pll->base + PLL_CTRL);
 

-- 
2.37.1



Return-Path: <linux-kernel+bounces-383575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 36B6A9B1D86
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 12:50:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3DD9B21519
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 11:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7156166F1A;
	Sun, 27 Oct 2024 11:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="g7akjn5B"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2060.outbound.protection.outlook.com [40.107.21.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD4615FD13;
	Sun, 27 Oct 2024 11:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730029816; cv=fail; b=svp6YZhP3VdYURfPWgXNc/tU3q8oqx3chLZphi2TWK1cgRPH+iSCIAz9T+UTFtj0x6x6qKslBAf2yywPVDMt9Lz5tGOAfAVHQzakOUGdHqqW3TYoPKL0ojtmwIzInGcDg8p35OpW6g5fqmVLbPN4AeFlS64vZrnmgUJmILUt2F0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730029816; c=relaxed/simple;
	bh=YZFP2ut1ozz6BeuzTp96FlzaXbQr4fqELBEGph/16b0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=QJD+4L51ZiNGLD8OiznNwrVx6EXOBr/s55VoKoIFlPBroQtmUnimlDyneTLXXPch8PZVfyLOT25itSSaCs09+ol0LJINfCG0SFbmLbTf0FvPm10N0vGLz1/smDBRNBu2Ih/OKnVAPsY1oNzwgVNt9+9C6dPlyvRwmTp3gUjGJ0g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=g7akjn5B; arc=fail smtp.client-ip=40.107.21.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hCGutQkIS7sgX13CToNa41S5UBPbHjz3p83yOscqv2uyDLcFPxqFY1/VOG8NofFXovK508AUwvaIuACU7ReZoc0nNouxiRPFDVpVCOS85EINpoMB/y4mP/vYCI+UT0SqHAflHIDLOI1LdnLUyZeGV5AbEzX+oddHOJy2Xfyn/5At+47No6zLxE3feIZxU3c7c0yGTSpS+5cOb5jIi/iGLCJ0IYmSO7m6DCXU7nEPJLGeJnwzBzTYoHYRlCVGhpGLVmskaXIrQqxM/uAd9CUjzW/Q6A1cCgwkqGHncXd/3gmn3COmMUcBs7Cn3m2FuSwbqz6o7EF0hulU0NrA4m4YiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B+kcPrphzLGA7BGzbN1UZPB/S9IXEYPjoakvnz0Egv0=;
 b=IXI3+6wKnBlY0hj9yy9OW0go5RrkcT0XNmGKiCFFngKyYlBtcoROdXOinwV/dqk+ytAlbCmoDQhhZrlNOL1WtyhYvMTLdB64YPAujJxiqxZ77/sdEXu5AOrEuur0UKW/inyzFxds5IsUB80Z17eWSgoiLkBrbYoV1kYA9bOQ9uzZc6uEMpLO7gmlCAV4ivlwdvViNJnTWCO84blAnX+J6zJAfnmZoiMmVuol34TtLrUzMa8ek1D9rTS31rBi6bGqzcljcZxCuWWTa32rTrYMD4KzqOIeTC2/8kx0YlZ62jJf0e2+n9azD+JzUSnBksXlshkfB6+0Bq01jkhDzQf5Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B+kcPrphzLGA7BGzbN1UZPB/S9IXEYPjoakvnz0Egv0=;
 b=g7akjn5BIaGonBhgXjsnT4UXvvHr5yYqvUsPPny1BzL7e8LryCqfdAxtBJyQRZxWQC5ME/pF7CrEd67fAbboUv5uFTyc6M9v6QwKfP4KVBOn1P978dhM7SYBmif34GqwgzlyQug8+YscLEH8VqDWIpYqCbgdwjwl9fx4qRgF1lOOWG+2Rk1vZ+e5kt3JTG41vTZxjvm8mfgbhy61U5PbXrAtHzUaznTeEDt+Ns7mBzHK4mcttMFVHBmodF0p+Z1+LQ7TA6X9FBnOMd9hlBlkAOjQrJZzUn8xyz63hYjvZtWP1G2qLeQKTAPgUwVIjQt7WYJ0yFiZsf4mm98PXgaUXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com (2603:10a6:10:2cf::20)
 by AS8PR04MB8689.eurprd04.prod.outlook.com (2603:10a6:20b:428::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.24; Sun, 27 Oct
 2024 11:50:11 +0000
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197]) by DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197%5]) with mapi id 15.20.8069.016; Sun, 27 Oct 2024
 11:50:11 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Sun, 27 Oct 2024 20:00:09 +0800
Subject: [PATCH v3 3/5] clk: imx: fracn-gppll: fix pll power up
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241027-imx-clk-v1-v3-3-89152574d1d7@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730030419; l=3036;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=84M7E9SFxBK3SAqAyey+G62IZbKKHtL8RhiilZogEI0=;
 b=1dp4lIBmYsrpsEeHK/aDU9oJ0s/10g4Ap6rgDp309cycMXdhfpczYI2Qo9LNwe/TMNS53+dZV
 THPz6oe0exlBhtyz1KVCFihhhDnLgOeF7Q1BRNtePTL94Cv/6eEyRhI
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
X-MS-Office365-Filtering-Correlation-Id: 4feeefce-3023-4681-d159-08dcf67d831a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|1800799024|366016|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QjJYRk5HREZDL1plWjMybER0NmkvZ3pCQkFlNllzR3RJMDBVZjV4aDArQVc3?=
 =?utf-8?B?WFBXajJON0Nlam92bHlPT1NLRjRaWWVRQ2k2bWhVWVpoaStCVDJSUWlVcEha?=
 =?utf-8?B?K20wclp5Y00xYllPQWJFd2RpVWtMaXBVWndlakZ5Q0g2YnZCaytnWjVMeVE4?=
 =?utf-8?B?MXk2Rko1dnpYeDBwZ0NxYWJjMnpZVjVNOU9CS1F3eEp2d1VOQm95bkRPVWZo?=
 =?utf-8?B?aXdvb2RwS3hRcFYwdGM1ZkgzeTNBR0FmL0NqNUtkY3NUaE14RXRtTk15ZFFX?=
 =?utf-8?B?L041bTZpSi9DcnJlWTdlSUJHR05OQ0EwajEwSlNocXFQc3RjNlJsNERPQlE4?=
 =?utf-8?B?MkhwRnVIUGdkaGl4SWdZczJNaFd3bFVqbERuZVJHQ25KTGRDV1NTSXR4ekcz?=
 =?utf-8?B?VTNlYU5oTXdkWHRSQU5NZXE0Tmo4TWU3ZEM0TVB5aCtUS2lMaUV2dmw1K2Ur?=
 =?utf-8?B?Zm5ZVXNyeHpuVXFCTnVDRzlkV1d4NUU0RGlvT242QnF4RTIwWkJxSkpXaUxx?=
 =?utf-8?B?S0lMSU5JbWZQOFZUSE5CQzZkelMrU2VucWRlUEFEYlEyTUE5cWFnQ2ZubWJR?=
 =?utf-8?B?UndvSEJwYzZGdC80a0NVNUVPeW5MclArZkpIWDV3Ulp6ODdmbUhOamQrdS9V?=
 =?utf-8?B?djAxK21BeTc4eVhDeVhQdjBoY0dyU1dwVU1IN3F5cXpkWjlPWFNTTjVQZTVS?=
 =?utf-8?B?RHp6WEZYOU5sMjVDNWFMTC9OaGhoM3RqbzZvbG1LL2d6TCt5Z0E3ZmJiNEZm?=
 =?utf-8?B?a21MNStvVjZ0SFNZSTl3WTc5Mkt4Zkk4NjdsZ0NscWNheGN0TUtuR0VBN2hX?=
 =?utf-8?B?QUovWHQxb3owM0hVRTYxRGthZ0lXQzEwU3pTeEtvcDcvaGN6cVR1TlJNOG9L?=
 =?utf-8?B?UFlmYkhqSGR4eWZKRHVFdHQ4THhXcEtrbGlORmN0MnNMN3RvNldPUjFPMTRo?=
 =?utf-8?B?THNTUWUxUnBmNEJyRStHU1NmNjZrK1JWdUtGL1ZhNUwvb2pBbVEzVld3Zm1K?=
 =?utf-8?B?VzVDNForYWJhUTNXa2xld2FWWXlKQVFnSG5LaXhXUHQ1eVZhTHBqTjlHbWZh?=
 =?utf-8?B?WjlMSitQL3VwVlVWSlc1OENFalhJWE1QY0RQNnJWdmhJdFFJYkRrQjJ4bXhS?=
 =?utf-8?B?cXJSN0puRkVzWkREczJrUzgvbnkvNkhySVdwWTJGcFRPSjZyYURpZXdkMWdX?=
 =?utf-8?B?UWZPeE9WSkVYaVFQZCtiM0dDU0N5c1BUcDdOc2hLR09wQzl2akFrZS9DOEg2?=
 =?utf-8?B?enFqVms5aFppY1g4cW1zTm1uay9Xb1IwSzJaaEdISVdmdjJxbkJoYm91bWRh?=
 =?utf-8?B?akFWNXZuSnZKL1QyMmlYTmRxVkVsc2JNRG5QOGtjMGNUUlVqRWdlMUhIQUFX?=
 =?utf-8?B?bm5URVlrSkxRZmZxMmNEa252YlFuR09vWGNsUmdtaFp3WEpFalNMQXhSbDFR?=
 =?utf-8?B?dUZ0RCs1cWRlTEtZVlRYa0N3cFBsdW9acGhQcWdsaEdKd0pwWS9VdjBMaFE5?=
 =?utf-8?B?elVteXFROHZlMWRaNVZsblpSb29QZDRBT1JVQnorblVlbDdPRHp6STJwODdE?=
 =?utf-8?B?TUNCcjdaUmhsSGxwSDluaDVXSGR2eTJrMG9PRExjMG9ITUw4Yzl0aGo1cTRs?=
 =?utf-8?B?bjl2SWllZC84Um55REZzZmNneTZnakRlN1dqTXpnOHY4bzEvbllrMU9JRjRy?=
 =?utf-8?B?aWorRHZoblBYcW1EWTAvOWJ5K0FDYkFKMlM0b1VISEcvZmtoeFU2YlNvRkts?=
 =?utf-8?B?QS9BV05SOXFZa1dNTFBEWEl0cGlsRzNWcVN2eFBwTGUyVjdsdjViNmMrUGZO?=
 =?utf-8?Q?yb/V/AYOcDyOrxvvU/7GLufJsXzra+ovauz0A=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8461.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(1800799024)(366016)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WWlBbVltQUc0dS8xSkNYbVk5bW5KbWhGN2NkSHJvSllRL1lSYjBlVUpFWG5p?=
 =?utf-8?B?MVQ4Q1FDY1JYQmtHVjRmWU9aVnVNdlRJNDc3SnI1Mm5YRjE1Wmh1MVlYVnVh?=
 =?utf-8?B?aDNZMGdxNDYyM0kwN1F2YkxTN0t6bXNNNW9CblRBU0xDbndsbThUeXllK3Js?=
 =?utf-8?B?MURJa1Y4ZGUzZnpNa0d3RmhuaFV6VWpZcUxlVHJFSHFCbCtEakZ3L3hPS1RU?=
 =?utf-8?B?RE5mdTdTWll2cGV3R0FaS3FGY1hpZkNobjV4OGJvVXEraGtjZWdhZTFLWGZD?=
 =?utf-8?B?VXRZMmpUcHV6OEViRkdmUE5WOEttWnhVNHVHSkQ5Z3dtdW9lOVBPNzhxQ3Vj?=
 =?utf-8?B?UkVmb3MxQmhYbEQ1aERNK3dFYWtQMkpZZ0MvUVRnb01tSDNTc3V1djFKR2Z6?=
 =?utf-8?B?MzA3OVFSa2hiUEFXZ2NkaUtjTGY2V0theWJ4QnNoVzlkaEdPOXM5YktJaWwz?=
 =?utf-8?B?VU1HZUxBa0NwNEhCQ3h1VFVLNHQydUx0UEI2MTFXcEEvWnpQemthSEl0d05N?=
 =?utf-8?B?amdvQzlNU0V6VHJ4YVgyTHhEd3RJRU9FRWcrRzI5OFJNQzdHYllGZ1hTK2ZG?=
 =?utf-8?B?QTZXMmNHSnh1SUk0bC9tWnFxY1ljQjJlQTc4bzc5Y2Q2RlNyaHJrdnRvZThw?=
 =?utf-8?B?OWppYXk1bmRMbm1ncjhIZzJuM2ZIcHhjam5WQWNRek5Sd3l0a012VUxac2JN?=
 =?utf-8?B?VDd3cXpMMWZZaEpMeUoxbEg2cGwrb2REbE0vMkU2ZTYzQkZQMzZickVDd3h3?=
 =?utf-8?B?QVdKY2IzTUJBVG41QzRVUnJjWkRmK2xjZURxOWk2cGtnTlhXdkoyZUN2RTB6?=
 =?utf-8?B?Q01NUFRCWDdFNGFHTGY5NFEwUytSYTQzSTdOaW9CNnFCa2RMY2NRRGJLTy84?=
 =?utf-8?B?Y0dVeHkwMVJ1WkZ6NXFRK3JsblBMVHpaV29pWEdpWFJIZnUwYUpxcXpaTjll?=
 =?utf-8?B?b1hSWURoSUtENFk1KzNISWxOcUNHNGYxaGFuSFJOdmZSOTZROG10d1NCVk9S?=
 =?utf-8?B?WFZMbm5ZSHprcHNhcFZhckxzcmpETEZlUy9oR2NPdWx1elZKd0szM3A2YU5w?=
 =?utf-8?B?dlhGOG5GajBkbUQxZEN4blpQVWZLbUxwWFVFL1QvZ0N6SlRYaE5DUDBUUURu?=
 =?utf-8?B?UlBiUWMwcjh0eVp3c1ExWmIyQjYvZ1p5N3VHSXJKR2llQ3gwMzVYWHI2czBJ?=
 =?utf-8?B?bGY0OWdhNWdzVUcwY3RZR1NoblZLbmdaY3JaMS84cWdiSzVPVVFZQ3BFYjV1?=
 =?utf-8?B?ZkU2bG1UbWJJNHEzMEhYZDVwUlNlamxtSmdCeW9Eb2lsYnFrWnBST0lEck5v?=
 =?utf-8?B?by94aDB2R2FCNXN2MXhyT21tNGNDOFMwWHphKzlYRWYzQ1MwOW82RStSRU1O?=
 =?utf-8?B?dGZoc1VYNjJoS1Q4NkRwWGJSdmtDRFpmN1RXUi9aOGhXTkNqbzliYU9VUlhD?=
 =?utf-8?B?NVArNUFIQ2FzS0sweG5xRGlraUV5WlMwUDdDekYxeEtzZUNtaG1pMGdEOWxB?=
 =?utf-8?B?bTZPNlZVRExvcWdEbmhmd0RZSmlIRHBKVmhNeFR2S3A0R0w3MHFvYUVBNDJB?=
 =?utf-8?B?WlUxaHgxNnFiSmZGa00zZWI3a1JFcksvWjNFS2MwM2VIdE4wdzZSaWI2M1da?=
 =?utf-8?B?a3dvWVBWWVB3WklKdm5yb3ZOckE1ZGhOT1A3cHgwcTRmdnpmMzVOaUlqQi9p?=
 =?utf-8?B?dFg3dDcwdmxTUWpESUIraENVTjlGSURGampITE81Z3QrY04yTU5VQjZmeXpQ?=
 =?utf-8?B?VXhiRDFSM1Z3bG13ZzdWd1A1MXJQeVhHMjIzSHpNTTVTbnlhR0lETzl3SG91?=
 =?utf-8?B?cTRXZWpyeHNWMDlJajZWUTJSeWp3ZGNVdWRqd0dhS2UwNXVuL25iRW5VZEV6?=
 =?utf-8?B?NUZyUnFoQktLV1puOG9scnIxdE9vQUR0RjRYa2dXMnJ2UjRoNmNPYkxmZHZS?=
 =?utf-8?B?ZndlUWNBOExIc2FzOU5NVE5jOHBYemlTOEd1QjB2azNsaU1uZ2VOWVNZUWxS?=
 =?utf-8?B?Ym1qV1lreWh6V1BHSlc5SFpBMW5IZnh5N0c0Y0FVQ3dHMnBjcFIzelYwa2sx?=
 =?utf-8?B?YUZYZFZqVTcwLzFwc25vVmtzWXNrSEFCck1SZnJlaDlCS20zR25UWEI0dmtn?=
 =?utf-8?Q?MEFB1ktK/7HoC26jrjeHoaEZL?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4feeefce-3023-4681-d159-08dcf67d831a
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8461.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2024 11:50:11.1615
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G2ru4uWvSfJqeZ9D5TFrtqKkBAa+Cf/qeaA5+z9OXvmlodrQlt7p+j0mS5L/6lq006hG2H4pbqwT7r/UXgHW3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8689

From: Peng Fan <peng.fan@nxp.com>

To i.MX93 which features dual Cortex-A55 cores and DSU, when using
writel_relaxed to write value to PLL registers, the value might be
buffered. To make sure the value has been written into the hardware,
using readl to read back the register could achieve the goal.

current PLL power up flow can be simplified as below:
  1. writel_relaxed to set the PLL POWERUP bit;
  2. readl_poll_timeout to check the PLL lock bit:
     a). timeout = ktime_add_us(ktime_get(), timeout_us);
     b). readl the pll the lock reg;
     c). check if the pll lock bit ready
     d). check if timeout

But in some corner cases, both the write in step 1 and read in
step 2 will be blocked by other bus transaction in the SoC for a
long time, saying the value into real hardware is just before step b).
That means the timeout counting has begins for quite sometime since
step a), but value still not written into real hardware until bus
released just at a point before step b).

Then there maybe chances that the pll lock bit is not ready
when readl done but the timeout happens. readl_poll_timeout will
err return due to timeout. To avoid such unexpected failure,
read back the reg to make sure the write has been done in HW
reg.

So use readl after writel_relaxed to fix the issue.

Since we are here, to avoid udelay to run before writel_relaxed, use
readl before udelay.

Fixes: 1b26cb8a77a4 ("clk: imx: support fracn gppll")
Co-developed-by: Jacky Bai <ping.bai@nxp.com>
Signed-off-by: Jacky Bai <ping.bai@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-fracn-gppll.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/clk/imx/clk-fracn-gppll.c b/drivers/clk/imx/clk-fracn-gppll.c
index 4749c3e0b7051cf53876664808aa28742f6861f7..85771afd4698ae6a0d8a7e82193301e187049255 100644
--- a/drivers/clk/imx/clk-fracn-gppll.c
+++ b/drivers/clk/imx/clk-fracn-gppll.c
@@ -254,9 +254,11 @@ static int clk_fracn_gppll_set_rate(struct clk_hw *hw, unsigned long drate,
 	pll_div = FIELD_PREP(PLL_RDIV_MASK, rate->rdiv) | rate->odiv |
 		FIELD_PREP(PLL_MFI_MASK, rate->mfi);
 	writel_relaxed(pll_div, pll->base + PLL_DIV);
+	readl(pll->base + PLL_DIV);
 	if (pll->flags & CLK_FRACN_GPPLL_FRACN) {
 		writel_relaxed(rate->mfd, pll->base + PLL_DENOMINATOR);
 		writel_relaxed(FIELD_PREP(PLL_MFN_MASK, rate->mfn), pll->base + PLL_NUMERATOR);
+		readl(pll->base + PLL_NUMERATOR);
 	}
 
 	/* Wait for 5us according to fracn mode pll doc */
@@ -265,6 +267,7 @@ static int clk_fracn_gppll_set_rate(struct clk_hw *hw, unsigned long drate,
 	/* Enable Powerup */
 	tmp |= POWERUP_MASK;
 	writel_relaxed(tmp, pll->base + PLL_CTRL);
+	readl(pll->base + PLL_CTRL);
 
 	/* Wait Lock */
 	ret = clk_fracn_gppll_wait_lock(pll);
@@ -302,6 +305,7 @@ static int clk_fracn_gppll_prepare(struct clk_hw *hw)
 
 	val |= POWERUP_MASK;
 	writel_relaxed(val, pll->base + PLL_CTRL);
+	readl(pll->base + PLL_CTRL);
 
 	ret = clk_fracn_gppll_wait_lock(pll);
 	if (ret)

-- 
2.37.1



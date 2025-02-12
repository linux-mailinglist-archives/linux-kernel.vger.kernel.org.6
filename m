Return-Path: <linux-kernel+bounces-510664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF531A32021
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 08:42:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CC64188C25C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 07:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CA09204C03;
	Wed, 12 Feb 2025 07:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="v8w2C3WX"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2083.outbound.protection.outlook.com [40.107.22.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A4D2054E8;
	Wed, 12 Feb 2025 07:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739346108; cv=fail; b=U+VOXf/dpbkLp8V4LsrrbozlOdvyj3gRHzjDrcLHX1aqvz5hsc4/Epos1wUVvXhuAVgJKqPmzQIZHmN8odBU0/ACPRGXzY4apTrh4ACMKiohbL7PVtPjt8DLH1Z1SVokz/d0bh5U5UrNZMpe5sJmSLv5j7g+ZkvIPOSk+rnGSUE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739346108; c=relaxed/simple;
	bh=Imj1aqsCz/elYzETT9yhSOLkfO/Rl3aLjzPaRtfaOcg=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=F7Dd4ieMUWF1dKSCvTtlpxtzu74whQEAYV/ldp1Ru3iV9+OqFRJDjVH0IOnoIycOnyp+PoIl+rcsXQL3qGm2cAZf2AngtQDq8HvTIR6/szx96s6b8cbhm6sYA2297npZAksTRED6ZpWJjaMOWBX/5jr7IaA8LCqDHkYyjdfpJJQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=v8w2C3WX; arc=fail smtp.client-ip=40.107.22.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TNmVHjNcPltsKMYvyxeD6STrq7LI0Iqgw49OiLqCSjgq/j2vvygPTcpy64qxehMM6MxLGrtTjbf6a+12Z0X4HC/dSJkDHxrCli2unMx1N5AOJundoy2SlqAdgTNQ57Pefikgdv0zDkQn+YBlBa5EELWG4ShI61QbshC7+QNsQto4Xu3qVuKj8NmiKXV05xbNIIsKRdFAUTpGS2zjRYiE58QNyMaj/57kO3BhSX8V3TkIUu+N6NDxfH/l51hAC0bFMS88jpstTljEphGQnJyHRfNc6EmtaCO6+/C17SmmhPcs0XIRtkawG/qOKxabDlOBJk8QMvhAIpXSGbgLn63a7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ZV94HHvgsE9LVMm/kVq9QaGyh+zF78/pIcWhUA4ofo=;
 b=Z7fi8+yja3/9YMtmJdb00m20KVL514m7cZOLOkgZWeewNyEL885mk0/qRTO4KFDFCQ5qFfjcKwcVioXO+wFhJ7XijXFJLQrf0UCtBdqEocjKAEF8f0yoqsypISlq3GzQtAk/DiH1P4Z07TZucshHJIwbcoIbtVXhLhaR53uQa62CS3mg5QapFI65jLMfVo2CJ4XESuk+0Im5GK/P67XZtah1aIADYOMUioMLlwaYnVNOobxi5lMhDAgYMhMKX4lF2NxpbVJoHgZIjZJ9mbgXL6wMthmvNSIhpDQwDEu4fLyAG6MbY1T8d9//rlxYV7AJLJ2IjspdjlLZr4avUeS3AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ZV94HHvgsE9LVMm/kVq9QaGyh+zF78/pIcWhUA4ofo=;
 b=v8w2C3WXaBKThYCzVYUGVV9QGzPZpUfhm5U8JKZkDp7/VVBK+cOHrJx0+J3Ws5P8fBrI7LD4SEVi17IjUrUDPauvqAph9gR25U7NP1bDmKgs6Mftpk9TI+QGGo39gyd2ZUvhO2uZ129y2FX/MczENlOOlrUqtN9r8V/SZaqr9Qmv2hEFVLLr8GJ3vFmF4F+Bp/s4eEym78yZSCNc6RBHRGxXfkuDD1TUSesU655aH67cRW/Wf/zO7Xd45Isp4s512IY4YHVshrkFfbEnLeVTb6XIqMjAk+rGRW7B2y7EM2hBUdctYtZNmLw/fxnj10sNiO83nc0E9RWgfrcztXP7VQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA1PR04MB10865.eurprd04.prod.outlook.com (2603:10a6:102:48a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Wed, 12 Feb
 2025 07:41:43 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%3]) with mapi id 15.20.8445.008; Wed, 12 Feb 2025
 07:41:43 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Wed, 12 Feb 2025 15:40:27 +0800
Subject: [PATCH v2 5/7] firmware: imx: Add i.MX95 SCMI LMM driver
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250212-imx-lmm-cpu-v2-5-3aee005968c1@nxp.com>
References: <20250212-imx-lmm-cpu-v2-0-3aee005968c1@nxp.com>
In-Reply-To: <20250212-imx-lmm-cpu-v2-0-3aee005968c1@nxp.com>
To: Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, linux-kernel@vger.kernel.org, 
 arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 imx@lists.linux.dev, devicetree@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739346036; l=5885;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=Y5YiY9EjHk3+0onquYZWlfsbcy9uIDhrsDG5HbDra3A=;
 b=S4yzzrarCecvGolZ0kijrvCM1rNIys93EejRC3DdizpOs7C6osovfxclvs9YinRfqT/39aIQa
 DoGv/EI5rbwAUHqOq/kRwqqIBm6xNdETHm4jQf1I6wi9W243Ay1XU/D
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2P153CA0014.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::6)
 To PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PA1PR04MB10865:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f5e1181-f702-495a-24cf-08dd4b38b22e
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MHRCQ1pPdkZEMFhDMzNZeTNYUjBUdVJTcHJ6YndLMzNJQ3lyTURSMlZKcWJI?=
 =?utf-8?B?UzNJbXhkWU9QZSt0RGU1bUt2UTU2bWpaVlRRS3l6cmFtcDdwUEJKUnhkOVg4?=
 =?utf-8?B?TjBZRzgzQ1RVVzRGRFZHTHJNWDFqRmhHRDliRktZMWtMSllBa2t3UVBaeitw?=
 =?utf-8?B?RDFhTWZ5a1I3MFF0R1ZEcU1zWG9vengzc2EweVBNczZxSm93cVRRS1ZIcFVr?=
 =?utf-8?B?TjAxWFVLQzY5ZVlqc2tsRm1Dc0RYaTFtajEwbjVqSTdnK3cxaDB6ZHFCNWJN?=
 =?utf-8?B?RHJDYkd1L0ovV1pkb1BnOEMrRmw0ZzQ5QTg3OXRoYU1xUG9EVVcxT2djN1JC?=
 =?utf-8?B?bVRBd1BvTVcxc2grcXpFUlUwVytyTVh6eUVmaGVsWWFDaXVMRm95NWE5V1FG?=
 =?utf-8?B?UnNJZys0aG1iSjBtOVpDL2hJdHZQT243L3RkUWZvaGx4TDFhL0tNc1lTanRB?=
 =?utf-8?B?Q1VMcUdtdExBOXhjaUtHcDJnQk4ybmlVL3NQNys1MGJWN09JejRmY2t5dE51?=
 =?utf-8?B?TU14VTIyVmJhVXpjcDAzMWwzQjlIR0hUQkFhb3ZVZVhBT2V6RUR1YWRQWXhp?=
 =?utf-8?B?U3VCb3Ntc1Qvb3NXVExoaHZ1TFdESHExbHc5VWZ3MllhZkFBVmgyNlFrUGVZ?=
 =?utf-8?B?WFRUVHBiY1R3UmFZR1IvanRtOEMrVUhtVmhrbEZRUXZMaHdZY1kyaEtodzFL?=
 =?utf-8?B?bXh2NnBCdWtQTFlCN1RKeGg4SjNHS0xkOW1LSG52ZVY3ZzNlZWs4cDRJYjND?=
 =?utf-8?B?R2x1Q0kwM2dkTm1paWtOQTk5SndoYlVDeWw3QmVCWWNUc2ovYkpxRzdNcmNM?=
 =?utf-8?B?eW5BaFo1NnVHTFR5TWoxTXFUOFlNRnlsa3dGblVrMWN4MkxTQUN4akY2cHVi?=
 =?utf-8?B?MllqOHArRVhWQzZoVDRPZHNVdzdRaWYvelg3NWgwdzU2NDJiWHo1SDJLSVZv?=
 =?utf-8?B?OXJlamFXUDYvOXN4d0EzaUNIUFpDdURzNHlnZDUzd1o2RE5zU1RZRjVOWjRn?=
 =?utf-8?B?ZDJzSlBydVpnU0NxVXhXc3JhWGgxOTBkdEtSalgyVnF0SEFqMUFMY2ZZVXVL?=
 =?utf-8?B?UWdmN3I0OXc0aHhGOTg2Wnd0bkJscUVxMkZNNkVWdWkxUE13NTNUQlVHNVpZ?=
 =?utf-8?B?ZmRCQTluNWdsWFJ0cWI2OHhUbk1kbm1OQVVpVzYza053RnJwc3RyRzBvc2Jy?=
 =?utf-8?B?cFNKSW03M1lBc0hCSm5SZTE1b0k2MllORFhzNnRremJQVGtjeS9nN0ZGQm10?=
 =?utf-8?B?bVFHR0xSQm5iMkRNSjQrVHBoSm4yWFBwWWx5WDg1T2NwQTZ4TFNOUXUwWThr?=
 =?utf-8?B?TlRvSFFBOWNMWndJS1ZEbDNmbk5xdFJXTlp5c1dyK0hsK1UyL0FZMDNEUHR3?=
 =?utf-8?B?VkJKME90MTMzYWNldk1ENkVYV3dSNUMrTlpsWWNTVVJNbkh0UkVwbnVkclhB?=
 =?utf-8?B?RnZwaEdGdUd0VW8xTzVUQ2JSc2c2QVpFUmZaWGRTdExQSnNLUEs3aHlZdGQ0?=
 =?utf-8?B?ajNZL1RkYW8wZEpqVitGWlFVOUQwekEzY3Fja0tnWHg3WkcxdjJyeFBXT0F4?=
 =?utf-8?B?Rkh6dHRzOTFpb3F5cmdtRTZXUDdCeVk5L2lWNFRtVDh2S1RydFhRSS9UK2ZW?=
 =?utf-8?B?cUdRQTlXdlZkS0pHWXJiMFhxeFZwQVFVeENSQ0RxbGsvb0pCOU9yRTl5SUZF?=
 =?utf-8?B?MVVURzUyR3RzNmsveCt1S1M5L1psTDFMTThBWlNxUitOMXc3NkdZYXV6bktV?=
 =?utf-8?B?Z2pkczRuclRTQ1hlZ2JnYTJFWWxjVThzb3JoK1d4Mno0bEhIS2VuMW9Gc1Yv?=
 =?utf-8?B?OG5wODIwaThWSlJFRTZhUjJDVStKckVlM2JNemtUNWREb1pncFE1U3NEU0FE?=
 =?utf-8?B?dWtibUllS2piQTdnQjNyVXM5T29ETk9SaldINHluaFd1aFRXL1MrRlRnTzBL?=
 =?utf-8?Q?KJYO9B10FlrHT0e5iiRv4R4klQKcUCu4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dHlQYkJtdFNHYk5UV2M4OUMrVHZES0xqZUg5WEdvSUc0a0FOWDJSWnE0TmJI?=
 =?utf-8?B?OGZWUklSZnZjdmpBVDdOeU9zdk9ISllxUFJKRVJrT1N5R3JQOS85SlA5VDBG?=
 =?utf-8?B?OUVqK2VCcWpKaXJmT3lYUzNUMlhPVDJsSE9BYmlPR2xxL3B6bUcyMldGZ0Jr?=
 =?utf-8?B?dHdNUTdkZDQ4M2w4MXFsOWxNSmhha2g3N1VhL3BQRjhUQVNrTmFreHowalRu?=
 =?utf-8?B?WGw1aDdacWpTQmhlaFhLa3NRZnkxQkJxd0s1M0ovMTVTVHlmZVpqdjRBeC9h?=
 =?utf-8?B?NzZKMUxOa0JWYWtWV2xEMlNHR1IwMnVTaUVITlZFVGZCOGRHTjRxRGErMjk0?=
 =?utf-8?B?anJlRkgvZzJ2QjUyMzQ4WGFhdkhsYktoZUR6bVdoWTc4UWFpNEFXSVlvMnZ3?=
 =?utf-8?B?cFFaSG5UaFZVQUN3aXJDTXNQRzRsRllHSTZja1NQSll0WFMvY0NFQU5lM0JH?=
 =?utf-8?B?QkJYeTQvaFV5RFBRQ2J2dTRPN3hMM2t4RWo5LzhJS2w3WXFvdzFWS2ZOV1R1?=
 =?utf-8?B?MUFWcURZczMyc2xnNzU3UzdUbm9BeDBEbVptdC8yODRuejMyU2crbkRhS0k3?=
 =?utf-8?B?YTdWQ3Vtbm1LSmVvKzhCU09IMVh4NWVjMVZKZjQxeUpyYXhBekpGMXZZWjl1?=
 =?utf-8?B?THhjWW9WU0ZVN3UraVJpaWVHWTI5dXlhUEQrMWhqbVQ4ZDRxZXlTM3hQNGYx?=
 =?utf-8?B?eHYvdHRRL3dRQXZDYTBndUs5Q3BQbHZ6RUNWUkxXaGpzRzBMc25oYndXa3hl?=
 =?utf-8?B?NG9KUzBBSGRXbUM3UHNmU0ZVd254U29sQnd0bWZhUmt5ZzFTWlE4NWpyS1Nr?=
 =?utf-8?B?UERQblM2c3A4M24xNUo3VHJJbWNRVTRFbFE1eGQ1TTlWQXNTSnpRTkV4NHJK?=
 =?utf-8?B?RmpRU2VHdVRkMXJ4L0lPU1hvRHFOa3JJZ1NOUjhCakl5M28wSEIyZGtMc0ti?=
 =?utf-8?B?SmIybWVpVE9ReWppcVNtWnBoOEdwbTgzOFd0V0JITlRSVUdna2dXdUt4enI4?=
 =?utf-8?B?TEN5K0NBbzhZNFJlWWNra3RhN0N0Z1Z3UVRkSHpGb0NMMHY3c2lkVHd4V2Fa?=
 =?utf-8?B?ZUdKbmc5bzJHdUZ3MWtzSnFMbUJ5RzBjYUtrMDI5YVRSSGs1dTdpVnEza1NF?=
 =?utf-8?B?NHdmQUZza2ZoekhBMi9LZ3M3STB6NUJ3Q2FtQ0lIY1NYdUQ2VTlRTTM2eXRt?=
 =?utf-8?B?VkRUSlNNTXozTnJ3NUE0dE1IQ2pyd1Y2TjZNY1MvYVVacDMrcFh6dGM3TVlZ?=
 =?utf-8?B?a2Y0TVVFeGVFSk10M3pBYUxJUFMxQWxmK3A1cXlzcC80UHFoR1o0TWc2b1Rk?=
 =?utf-8?B?cWova3gvSTlIcEp3KzJjelFnWmMyenpGM1ZJQkVsVnVVcm5DNEhlV3F2QlV2?=
 =?utf-8?B?SHh4NzhnV2tjWFV0aUVmeVVGWlBUUVllRW9aMVBEQmhQLzYvUENERkZ4R0FI?=
 =?utf-8?B?bkRDYkk5dkwrTTlnRmx4cFFxSXplaWF5V0RZRU9MQ05rTGRSWHZBMkgxM3Va?=
 =?utf-8?B?OGVOb3RrcnVDVm1JYWJCeEJ6QkhmNS9wK3ZvYmRBSmJWUys5T0Zlc0I0ZlN6?=
 =?utf-8?B?ODdQMk1QMXVjaThGMFhPN1pLdXdaMTFOMXhZZHpuSkR3WlVBemJSYkNENHUx?=
 =?utf-8?B?TkxHMyt4RmFsMEhJWXhyaHRXQXhMcndEWVJTMW1RdGYxRkIyMkF5Yy8rcGlH?=
 =?utf-8?B?Z2IyOGN0MVdNVitleTQ1YU5NdzM1KzlUcHBIcUE5dGFVbmRVK0t2UTMwSkpm?=
 =?utf-8?B?a204Z2UxS2M5aCtjNkhsaW95ZGVteXV2L0VINWhpaHhWU2V4bmlBck93R3N1?=
 =?utf-8?B?enlhdEs1Qi83a2ZwQXVPeUtiM3YvRnBacG45cDdWb1FOdlpGNE52Tk5XUGZk?=
 =?utf-8?B?VTYxQURZUlRSZFdCVUVwNVQ3Sy9STlBhYTVaNHRUNXozd0dvSlRMMEd1M0cy?=
 =?utf-8?B?NVJ3UWVlWi9oUnZ5cU1LSHUrWEhrRVpwckp3Qzk5ZjZkcWo3WlJ0Q05rUCtW?=
 =?utf-8?B?dFRuZ2NuVW5QNUlGRWN0ZUVQU3pjaEwweW5aZkRvbm91L0w5TTZoTDRETEpR?=
 =?utf-8?B?K2w1V2N6UDk0L2lWMkErbG9RTVIvNksyM2I2SmFoMEczcGQ2UjFnR3NhbGJx?=
 =?utf-8?Q?NqXCBV+NMBIXvGAQkcH6c36g8?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f5e1181-f702-495a-24cf-08dd4b38b22e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 07:41:43.7249
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5ocLmyvZDq1Q9YoAhnAfI5lgz5xQcZEO3ei7ZPZFsmbpMuwenUWqtzFAUi8JQd+7uWl1j3rqJz5DiJ+J2QltOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10865

From: Peng Fan <peng.fan@nxp.com>

The i.MX95 System manager exports SCMI LMM protocol for linux to manage
Logical Machines. The driver is to use the LMM Protocol interface to
boot, shutdown a LM.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/firmware/imx/Kconfig    | 11 +++++
 drivers/firmware/imx/Makefile   |  1 +
 drivers/firmware/imx/sm-lmm.c   | 98 +++++++++++++++++++++++++++++++++++++++++
 include/linux/firmware/imx/sm.h | 33 ++++++++++++++
 4 files changed, 143 insertions(+)

diff --git a/drivers/firmware/imx/Kconfig b/drivers/firmware/imx/Kconfig
index 907cd149c40a8b5f1b14c53e1c315ff4a28f32ac..c3e344d6ecc645df1f0e3ee8078934c47f347fd7 100644
--- a/drivers/firmware/imx/Kconfig
+++ b/drivers/firmware/imx/Kconfig
@@ -23,6 +23,17 @@ config IMX_SCU
 	  This driver manages the IPC interface between host CPU and the
 	  SCU firmware running on M4.
 
+config IMX_SCMI_LMM_DRV
+	tristate "IMX SCMI LMM Protocol driver"
+	depends on IMX_SCMI_LMM_EXT || COMPILE_TEST
+	default y if ARCH_MXC
+	help
+	  The System Controller Management Interface firmware (SCMI FW) is
+	  a low-level system function which runs on a dedicated Cortex-M
+	  core that could provide Logical Machine management features.
+
+	  This driver can also be built as a module.
+
 config IMX_SCMI_MISC_DRV
 	tristate "IMX SCMI MISC Protocol driver"
 	default y if ARCH_MXC
diff --git a/drivers/firmware/imx/Makefile b/drivers/firmware/imx/Makefile
index 8d046c341be878bb6dd1e6277992ff66ae90e292..7762855d2a771169d4f1867d27e0d51be7c9ad03 100644
--- a/drivers/firmware/imx/Makefile
+++ b/drivers/firmware/imx/Makefile
@@ -2,3 +2,4 @@
 obj-$(CONFIG_IMX_DSP)		+= imx-dsp.o
 obj-$(CONFIG_IMX_SCU)		+= imx-scu.o misc.o imx-scu-irq.o rm.o imx-scu-soc.o
 obj-${CONFIG_IMX_SCMI_MISC_DRV}	+= sm-misc.o
+obj-${CONFIG_IMX_SCMI_LMM_DRV}	+= sm-lmm.o
diff --git a/drivers/firmware/imx/sm-lmm.c b/drivers/firmware/imx/sm-lmm.c
new file mode 100644
index 0000000000000000000000000000000000000000..ed9650a8cb7ca878874e8609f0a5c83b5e46204a
--- /dev/null
+++ b/drivers/firmware/imx/sm-lmm.c
@@ -0,0 +1,98 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2025 NXP
+ */
+
+#include <linux/firmware/imx/sm.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/scmi_protocol.h>
+#include <linux/scmi_imx_protocol.h>
+
+static const struct scmi_imx_lmm_proto_ops *imx_lmm_ops;
+static struct scmi_protocol_handle *ph;
+
+int scmi_imx_lmm_boot(u32 lmid)
+{
+	if (!ph)
+		return -EPROBE_DEFER;
+
+	return imx_lmm_ops->lmm_boot(ph, lmid);
+};
+EXPORT_SYMBOL(scmi_imx_lmm_boot);
+
+int scmi_imx_lmm_info(u32 lmid, struct scmi_imx_lmm_info *info)
+{
+	if (!ph)
+		return -EPROBE_DEFER;
+
+	if (!info)
+		return -EINVAL;
+
+	return imx_lmm_ops->lmm_info(ph, lmid, info);
+};
+EXPORT_SYMBOL(scmi_imx_lmm_info);
+
+int scmi_imx_lmm_reset_vector_set(u32 lmid, u32 cpuid, u32 flags, u64 vector)
+{
+	if (!ph)
+		return -EPROBE_DEFER;
+
+	return imx_lmm_ops->lmm_reset_vector_set(ph, lmid, cpuid, flags, vector);
+}
+EXPORT_SYMBOL(scmi_imx_lmm_reset_vector_set);
+
+int scmi_imx_lmm_power_on(u32 lmid)
+{
+	if (!ph)
+		return -EPROBE_DEFER;
+
+	return imx_lmm_ops->lmm_power_on(ph, lmid);
+};
+EXPORT_SYMBOL(scmi_imx_lmm_power_on);
+
+int scmi_imx_lmm_shutdown(u32 lmid, u32 flags)
+{
+	if (!ph)
+		return -EPROBE_DEFER;
+
+	return imx_lmm_ops->lmm_shutdown(ph, lmid, flags);
+};
+EXPORT_SYMBOL(scmi_imx_lmm_shutdown);
+
+static int scmi_imx_lmm_probe(struct scmi_device *sdev)
+{
+	const struct scmi_handle *handle = sdev->handle;
+
+	if (!handle)
+		return -ENODEV;
+
+	if (imx_lmm_ops) {
+		dev_err(&sdev->dev, "lmm already initialized\n");
+		return -EEXIST;
+	}
+
+	imx_lmm_ops = handle->devm_protocol_get(sdev, SCMI_PROTOCOL_IMX_LMM, &ph);
+	if (IS_ERR(imx_lmm_ops))
+		return PTR_ERR(imx_lmm_ops);
+
+	return 0;
+}
+
+static const struct scmi_device_id scmi_id_table[] = {
+	{ SCMI_PROTOCOL_IMX_LMM, "imx-lmm" },
+	{ },
+};
+MODULE_DEVICE_TABLE(scmi, scmi_id_table);
+
+static struct scmi_driver scmi_imx_lmm_driver = {
+	.name = "scmi-imx-lmm",
+	.probe = scmi_imx_lmm_probe,
+	.id_table = scmi_id_table,
+};
+module_scmi_driver(scmi_imx_lmm_driver);
+
+MODULE_AUTHOR("Peng Fan <peng.fan@nxp.com>");
+MODULE_DESCRIPTION("IMX SM LMM driver");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/firmware/imx/sm.h b/include/linux/firmware/imx/sm.h
index 9b85a3f028d1b0a5287b453eb3ad8412a363fe6c..e02b7b558afb6f430f6fbeeaf3ee1f59feea3c1b 100644
--- a/include/linux/firmware/imx/sm.h
+++ b/include/linux/firmware/imx/sm.h
@@ -8,6 +8,7 @@
 
 #include <linux/bitfield.h>
 #include <linux/errno.h>
+#include <linux/scmi_imx_protocol.h>
 #include <linux/types.h>
 
 #define SCMI_IMX_CTRL_PDM_CLK_SEL	0	/* AON PDM clock sel */
@@ -20,4 +21,36 @@
 int scmi_imx_misc_ctrl_get(u32 id, u32 *num, u32 *val);
 int scmi_imx_misc_ctrl_set(u32 id, u32 val);
 
+#if IS_ENABLED(CONFIG_IMX_SCMI_LMM_DRV) || IS_ENABLED(CONFIG_COMPILE_TEST)
+int scmi_imx_lmm_boot(u32 lmid);
+int scmi_imx_lmm_info(u32 lmid, struct scmi_imx_lmm_info *info);
+int scmi_imx_lmm_reset_vector_set(u32 lmid, u32 cpuid, u32 flags, u64 vector);
+int scmi_imx_lmm_power_on(u32 lmid);
+int scmi_imx_lmm_shutdown(u32 lmid, u32 flags);
+#else
+static inline int scmi_imx_lmm_boot(u32 lmid)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int scmi_imx_lmm_info(u32 lmid, struct scmi_imx_lmm_info *info)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int scmi_imx_lmm_reset_vector_set(u32 lmid, u32 cpuid, u32 flags, u64 vector)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int scmi_imx_lmm_power_on(u32 lmid)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int scmi_imx_lmm_shutdown(u32 lmid, u32 flags)
+{
+	return -EOPNOTSUPP;
+}
+#endif
 #endif

-- 
2.37.1



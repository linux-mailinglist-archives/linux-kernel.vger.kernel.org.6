Return-Path: <linux-kernel+bounces-265006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53FA593EB1C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 04:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA05E1F21FE9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 02:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB01A77F1B;
	Mon, 29 Jul 2024 02:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="X8V4jPef"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2087.outbound.protection.outlook.com [40.107.21.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18481B86D6;
	Mon, 29 Jul 2024 02:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722219721; cv=fail; b=G41gjcoetjSejpjQbVhgZD1BiwjBKklad+qj6DmVAiYZwul+lQ3wqImi3Vr/ihpQWrAi1vAw2GhsonKdJslTK3Qz0cPitwZo6vO88rWBuvXA1/bSi2anHaUkWR71+qZBL5yXoGhQNJEJA8ihu1AQLgeinhRtY4N1epWbffA2KZ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722219721; c=relaxed/simple;
	bh=isxcVIR1/oP/CzipTWVwRp0MpiIA0vFVPAbvMaTgwzU=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=qQ5mWmRzljs+JaByksXFyEjPrflhMNlb+nQ8oP5XhUpck+sm7Q18kRE3ZLd6yQenOenPgvABT/B+Zaq44kGbdpVLggI07kxfu+a9we8Zc03Xz8cBpE3I9kqaQ3oZWdaH+mH1V7P2XnqBmoxd1H3dONKUPxHW3ZkrKQ0M9evn2LI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=X8V4jPef; arc=fail smtp.client-ip=40.107.21.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pPnfvQJ/h3Fit7mEAH7Sv1i46Asn27Bz1J/vSeK3UfiIVC/r0feoPfXKrm0xvea6eWP+/I6YMFL7POCVZ74WBbfuQcCnErIcHYwsMGgeMc/rvCdXiptXYxl64kNcXPWplKU4cp12t8kiMIaEekqtuFPcmDnhumLnFM0xUbMK1g0dFnZPkkcGubHw0EXxHGaxFc6SlnL/N/tHS32DUetFprx0OwqI8HVPYbgL3qAyFckntY3w9+CgctKHBGzHV/s3MTa2CUAl0rCVzcuRo68CxUdO6d7lixp93l6GePQbuSv6r6nxVoxNe8UQi6APXEJwvjlZcuXXDM6pqqVC4tzkig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2WKpOtZE8e5pgzJ2YrVfWs+ZSpXq8svqlzJ7xDVF+1M=;
 b=YHmAERdliAa9AVV/KfD/nVzJNpzPCOyyr4F6yMOIGhQ0K1AaVRVSxwXmV4mnZUS22wqKKk6dja7eCjeuIf98Y9xt+lDp7lsV/eirU3kEHNTGPTCsLbMn3G0FNl4enWeHBDomeiQWbCkbA9e9Ujg3/QpngBolECiefeXBFMtTmfBkE3WYJyP3igr4bw3htOTDAE3s8spVlMybvVBHTb8R7JnAdHyuyxfRQU5HT/nqX9SG7OwEaEQIKFdDhnyfpSMJuYC+1LdcdYfzJZark5H/dlT2kWQyofXW2ZCAS/9OE6cU2yveAz+blaHNxFe0NH+X/KjMsd/rmPrmnPpMct6xhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2WKpOtZE8e5pgzJ2YrVfWs+ZSpXq8svqlzJ7xDVF+1M=;
 b=X8V4jPef2wQgjB2Sq6sBXZyx1ZJteCAeVhr98At0IbZYsail0MaYY8e+XZvtT1Pnk2YC1Sa4zlSdrIfBePfpfdffaLqbsP1g5tZ9srMyV3U1vpp9h+W4QBsqRsl7xl7bgeu9HHqbXuANfRtl7HbqapD5OrLbuin3p6AM/EyMMrAhGv68NJRIdJsNi5bpAK3eV1+RtlLenucQNNsx9Ip+jujktZew7D8Qcbm4MCZXSh4M5qTtjXxZIxJyiiH21OogQGHQB1qrGp/uRGzS49TTmFJbMX38gE420mWIUBrvag9za22uXzadjr4P6XP6pFa9S4BTp6ff4IbZCmjr5Wk1pQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DBAPR04MB7368.eurprd04.prod.outlook.com (2603:10a6:10:1ad::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Mon, 29 Jul
 2024 02:21:56 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.7784.020; Mon, 29 Jul 2024
 02:21:56 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH v2 0/2] clk: add assigned-clock-rates-u64
Date: Mon, 29 Jul 2024 10:30:51 +0800
Message-Id: <20240729-clk-u64-v2-0-ffa62ee437e6@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANv+pmYC/2WMQQ7CIBBFr9LM2jEwEGxceY+mi0rBTlRoQJuah
 ruL3bp8/7+8DbJL7DKcmw2SWzhzDBXo0ICdhnBzyGNlIEFaGJJoH3d8G40nYbVSygvfCqj2nJz
 ndS91feWJ8yumzx5e5G/9bywSBY7UDkbKK9XnEtb5aOMT+lLKF3XUg8GcAAAA
To: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-clk@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722220263; l=1183;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=isxcVIR1/oP/CzipTWVwRp0MpiIA0vFVPAbvMaTgwzU=;
 b=Vb+2IDY72XBWPIIxiZJvuMLUD9LejcqVn9TZhqXxI8pCJNhbrUcO1AeOElFFWUndpw58pG0VA
 kX2TPc6D4jVB5QyEzqWSvMnHH9L/rdJCT4SwZ3J/Yx7IXaNz6KoAcS0
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2PR02CA0001.apcprd02.prod.outlook.com
 (2603:1096:3:17::13) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DBAPR04MB7368:EE_
X-MS-Office365-Filtering-Correlation-Id: 944337b5-af49-437f-149f-08dcaf7537a5
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dmxVMmtJUlI1UkxnZUs3aWJ2NDZ6Qmg0QW1SaGdaRlJvNGFDZ01kd1BZQmcy?=
 =?utf-8?B?RERwYXpjVDU5dHhqeGNLNnlvNUhlaTdIelBTNW1lVDVXaUYzY1hTOE1mRFNH?=
 =?utf-8?B?akswSHVBNU0xRWp6MmtaQ1dPVUxvbXVDeTlnQ2xoMDdzT0UzakR4QTJ6cUtL?=
 =?utf-8?B?S2orUlh3WW5LL01HUWwzNFhuTkJqZklKU0svMjFXY25DN1VQcHdqa0NSZWla?=
 =?utf-8?B?K2NUNUVZN2lSdXIzRUt2UzN5bjhsUkpxeUYvaWRaMkpwZ3l0Y2t4Z2Ewc2Zz?=
 =?utf-8?B?b0ovL3pGQTdPUm9kUXR4ZG1lcHpHcUhGSURYdUhIREUzWUdLKzVqWE9mRWgr?=
 =?utf-8?B?bWpad1dHcG5xNnpQWFR0dy8rVUdQY3BKWlRrekZmNnZ2eVRMa2IxbktrTWdS?=
 =?utf-8?B?T0I5QktqMlZIZEZwVmw2bm1ZVzhJTGlEcit2ZVdBNXpnVUpVVTd6amF6VWVt?=
 =?utf-8?B?ZUp0YWVYZXE4TlFHMU10d3JSOXp2dm1ZTVltb2RTMUR4d011d1I3bkFOZUhy?=
 =?utf-8?B?ZVRiUm5qS3BSbnQrMCt0OGVFTUFxTTNaQjZvTGZmL3VJb2wvQUt0SXg4SU9U?=
 =?utf-8?B?RmxoS3ZKMG13UUJFOUFobENqT0VBRlVCUUVudjVFcEVoRDFzS0RRSG03bmdN?=
 =?utf-8?B?OUN1RHRMUUNGaXJBZFBXL0JYMWZuUld0dmZNVVNPVlgyT0M1bGUzZFZGZEli?=
 =?utf-8?B?QURwNGxHdlBlc2FkY213T0w5WVJQaDNMY0l6MC9EeFBEVmlOMTNhVXV1UHBF?=
 =?utf-8?B?WlZaTWlML3lPSE5TZGNLM3czT2ZTaVhhZGVoSkNPbU9CNWhMQVJaU1huYkVu?=
 =?utf-8?B?YzY5eERSSEpkeUIrOUx2T2V4K0hnbTdwVm1zdEMrT1lxSGhEZStIZXNtWVRP?=
 =?utf-8?B?c0puOEFGbEdmbU5aVHFuQWZacnNvcUxlNEZXV0JUUUFORkxPSWFxZ1BsbVhp?=
 =?utf-8?B?S0tKNWloTSt2aHVxZVhYTG1STkttZ2ZmM1hRMGkxYjA3UCtrQ3R3K09SNHkr?=
 =?utf-8?B?VVhWOHJHYTJOVVZCNUV6Ykcwb1RUU09kN01YNDBlTVlhZ1hwUEhWRnhtaUVL?=
 =?utf-8?B?aWlHZlNIcDNFUVUzS013SG85aVJCUjJ5RE9aUFI1eENnVjk5OXFjMHgxblJ6?=
 =?utf-8?B?K1FNY0dVZUZmcnpkV0s2NmlXZ0ZIZlFwWGY2aGtZNDRRY29sL2M2TFBlNFRy?=
 =?utf-8?B?YVpHeC9VclZQTVNUVndKdFd1NVgxUE1HNlpSbThUajFYUEdSWHRzUVU0T3Vy?=
 =?utf-8?B?SjNnNDZwMzE1NDJ0cXlBaHh6MjBmS3pFQWRMWG5TUGJSanNKMEJEWnZYdGFO?=
 =?utf-8?B?dTNXSFJYUFYwemJjZWUraUxPQlFzTUtGUTM4S0pwU1k1ejJHaWNXS2FTZjZ3?=
 =?utf-8?B?bVFkQTIzUnJDWDVGamh3R3NEazlza0RqNTVvQStBTWplMWdkaTJWVGRML1I2?=
 =?utf-8?B?SnZjQTh3SzZRVDlydk9BcEVpOHpoZnQzM00rcDNZRUoxMUh2bmwzQmdOcnA1?=
 =?utf-8?B?U0owMjJ6RE9FOXVyU2plNVA4QkgvY0NmdE9DL2hiL1MrQXp2clJtUzZJc2di?=
 =?utf-8?B?aWovNUJLUE5hNkNVYmpYaUorNkRBMDNSWWNFOVdQamI4MlR1MFJzN2pWa1FK?=
 =?utf-8?B?SnN5Z3lWLysxZG4yN3RrYkJ6ZDA0ZjhoakRFYmcxRXNEaEU2VE1YOFFXdnpF?=
 =?utf-8?B?N2tQWFJhbUlqQ2dzZ1ZSOWY0d0szZDE1aTRJUHBIZGYwMzJVdlUwYUVycWRK?=
 =?utf-8?B?dlFxV2JCVVprT2xLY291VlpRZkFla2Y0MXBwOTB5Nk52d29rSG9SUHhpdFRr?=
 =?utf-8?Q?A5LhaxtKzpPzwEp9fzqZpL1RF7C7S2DIeoSbM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NUFPcVlaclVXZklkM2ovUy8reTU4WnQrRUNDQzN0QjRMUStHRDFaNnB2d3Ni?=
 =?utf-8?B?ZHZEdHowSUdWbFdKRGx0Unc1UmlOZDR0VER1ajBOOG5KU2xzZ2R0SGFGNGM4?=
 =?utf-8?B?SlFYNXVSRC9oK3F3WXBoRjZmVFRNYmlaRHhNb0ZnblIxekRrL05KYndLckxm?=
 =?utf-8?B?ZjRTd3ZYWlBZSzZzZW9UbU5XeitWMUROTnVudVZkZWp4S0xuK3dBSjUxcUpn?=
 =?utf-8?B?Wng5cVJaY05mNjJOWVhabzM1OHErQVhYKy9XL082OUpUL20yenlxSldzTWZK?=
 =?utf-8?B?a3UyRkYxdlB4UkVaRC9rcFd5YzVWVGdQQ3NqWFE1NzA4UlVEOFZaUFdJanVJ?=
 =?utf-8?B?dXdHUE9aRWNiT0Nyd3lFOFg2MERFV0NsNDBMODJlZEZiVUNUeTE5aCtQOGlS?=
 =?utf-8?B?Vm02QmpxVE9Ud0VLVTZ6VXJ4ZnIrYkdCaEQzQnNDQ0pteEhvRStCNXVDRnNB?=
 =?utf-8?B?Z1prU09RRVk2S2NNRXNTcFRSRFFqbUpkYUdncTc2YXJCdXkyeUtoSVRKQUE4?=
 =?utf-8?B?d01ncWdNazIxbG0rZXYzSlAweEFWdHpCMW5qZVJINUpVVno4eE5iWmpHYkFU?=
 =?utf-8?B?ajN4dDdjOXpFeWlqdnZLWW5zMU9QRVExMk9CRzk3VXJZRFpNcDhhdWdlTTVD?=
 =?utf-8?B?ckNXeEVTaTF4MWpxbm1pd1NKSXJlV1E0THJGY0s0UjFjMlBtRkM0NGNCeXdV?=
 =?utf-8?B?cGc1UG1PQ1RONUJrdWJESHRaQVl4b2hpMjdhSUJ5RkdFb3ErdWEzNnNGVlQv?=
 =?utf-8?B?TVRjaEhUcjFuMG9NcHFxN1k4bE1WM3dHc3BEMWtFNVF4TDZEZjI3c0kyOXJS?=
 =?utf-8?B?TDd1c3FTSFF4eVZMalEyTy9LN0RseDlpTzdYRlRQKzBiMVpGNE1NLzl1UWNK?=
 =?utf-8?B?UmNmQ3k2U0RHdERHQ1FSSGd5M0JaOWpsY1Z3RzdtV2JHZEx1eXZpazJpSUVp?=
 =?utf-8?B?aUJQc2NpQ24rSXlRNXpENk4zdUtham1MMURlZ3BJZFJIc1ZSa0ZDYk9RTEpM?=
 =?utf-8?B?aXVOdzhUMU5mUXRIWWhHeUd6Z1RFVERDWjlEOWFxTFFra3FUNysvRHVibzgw?=
 =?utf-8?B?d09jM3Z5NVYzSk5rYnpBMHRGNk1YVk5iVjZqeWJ1dWU4blVBY2QzY2t6eVk0?=
 =?utf-8?B?ME5hL251THpxUm5lOXdyUHpZRFAzUFhvSWs5aUZhTVV4NWw1VjJLK1RGeTZV?=
 =?utf-8?B?L2M5bWNzL2k0WDIvM1lxb3NMVk5kZ09CbGUxc1VaTmhFT2NwUVNadEJyamdm?=
 =?utf-8?B?a00wbE9kaU5yL0QwQ2t4Znl6TVZjNVF4SUlDT3VzVjMrU2tOSmFuYkMrRFZN?=
 =?utf-8?B?dExTVE5kRmpObVhjQ2FmNWZ3amtBNVdWZ0t4RDBYTzFxWVlkRm9nMnJOWjhG?=
 =?utf-8?B?MSsrQlhNM0N3a0pDTEpiMEkwTzJiaE9mT0ZKSGxONThGUkZTeG9RTWVRbXJO?=
 =?utf-8?B?UEd2dGZnODU1RGVOOHUxNlRzZjkyOWNvTENVbTMrNFBPUlBYaFNzOVNwcnBV?=
 =?utf-8?B?TTdYeVV4aEREc3czSkU5NnNLK0JqY3dqOExqTy9uYmdaNDk5bVJTY0hieHY5?=
 =?utf-8?B?N3RNY29oQ1F4c1U0WWdKdS9zdVVubmdnWmZ5WTkyNkQyUnYrMmVERWYxTGho?=
 =?utf-8?B?R1lJb2xZNjN3SzYva3BRQ09UUFZYMXVIUUljdGQyMys5QTFDYWlTUDNEZGU3?=
 =?utf-8?B?SFB5Y1RzaWZsNjFwMm1wNWNhZUttR2szK3E0UFNmaUhpTjNMWVN0RStERURj?=
 =?utf-8?B?Q09uUURJRU10a1c0SFl4Nk1sRjVTZzRNdlExNk5Wa3VRV2xWSS9GL3ZTSmxN?=
 =?utf-8?B?UnZRZlRUT0RiaUJzeUo2RlBKOS9mblY2ZlRRYm1mcGMvL2E4RmlRS0xjdEo2?=
 =?utf-8?B?aUNhRWZEZTRadWY5VmFhMHlzY1ptNG16ZHpOTThTb1pUYzk2VUk5alR0Ly94?=
 =?utf-8?B?dC8yRVhuVGNNUG9HdlBTRzcwT1d5Q3EvRm9NYVpweStNazFGbEVsNmVKWXd3?=
 =?utf-8?B?MTMyaFZvVnFWNStxekpOWndLMzdSaWthZnYzMXllNUszN1U2YWNOeGFkL2ZF?=
 =?utf-8?B?aENXZHRxbjQ3ZGZRKzZZcS9IL0Z0WmNBdFlRODREVnlVVWlCRmtSQ1IzTDVm?=
 =?utf-8?Q?qyfLaoFkGExThLHdfMXDE5FMo?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 944337b5-af49-437f-149f-08dcaf7537a5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2024 02:21:56.2264
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7U6nbP1Wqox6cq5hO6ldJCFr+6GccWeJpatXLhut54BaguKGyXApkNDnUT3nnj5QAVS7RgsqNW1jb5kitFtGMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7368

i.MX95 PLL VCO supports rates that exceeds UINT32_MAX, and the
i.MX95 System Controller Management Firmware(SCMI) server exports
PLL VCO for SCMI Agents to configure. So introduce
assigned-clock-rates-u64 to support rates that exceeds UINT32_MAX.
And introduce of_property_for_each_u64 to iterate each u64 rate.

The PR to add assigned-clock-rates-u64 to dt-schema has been merged:
https://github.com/devicetree-org/dt-schema/pull/140

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Changes in v2:
- Follow what Luca did to of_property_for_each_u32 to write of_property_for_each_u64
- Link to v1: https://lore.kernel.org/r/20240621-clk-u64-v1-0-d28a611b2621@nxp.com

---
Peng Fan (2):
      of: property: add of_property_for_each_u64
      clk: clk-conf: support assigned-clock-rates-u64

 drivers/clk/clk-conf.c | 104 ++++++++++++++++++++++++++++++++++---------------
 drivers/of/property.c  |  23 +++++++++++
 include/linux/of.h     |  23 +++++++++++
 3 files changed, 119 insertions(+), 31 deletions(-)
---
base-commit: 668d33c9ff922c4590c58754ab064aaf53c387dd
change-id: 20240621-clk-u64-70c4333f0f80

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>



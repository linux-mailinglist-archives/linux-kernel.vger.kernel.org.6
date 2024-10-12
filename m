Return-Path: <linux-kernel+bounces-362302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B32AB99B34F
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 13:11:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42EC31F22215
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 11:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D60BB178388;
	Sat, 12 Oct 2024 11:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="t+l++bEJ"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2067.outbound.protection.outlook.com [40.107.20.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C14B170A26;
	Sat, 12 Oct 2024 11:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728731448; cv=fail; b=kADanqxgc1xtNaXkp5XaMGYv2NNLNXND/lR/tQvm1xXX+JoHCPN+sjH5Xzi4JKE3tO6Ya/k7GBTluUjcMU+z+E++X+6lLjHaELXt9YI2aJmBnFdCbQURncLfZipa3umwK12WtwO2/0EIcH+B/1FaRNs7X3BKenZo4cheIKto8po=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728731448; c=relaxed/simple;
	bh=oAvYe+U0N4h8CJO/K6WSInSPzrvkssz6TuAWz3DZTYk=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=XMlSC3RgQt6PvKz0vvfPsXvpk15nFb8usiINw767SGXoK5tyXpT+pMmcK0H4SIpmZDd33j6kHyLbxK5ne8Z3+IijD3zDtjyrKJvwnM1J/PCL6+Zkd1O+2lABfoRlG8hbLu3C3f4VuQSAV45DKhf6TQDxNrM/iXsSPy/lDG/CyCg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=t+l++bEJ; arc=fail smtp.client-ip=40.107.20.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v9Is+YetuSAX+0YLO7gYR+qRfxmPW0FsT/4r85kKPbFimItR/ROQT8jcpHp2B4d9b/RH1Dl5kIPdfbOMuaIcVgOvdBF4qJj0d4lTyT9ykKL332Jss5gWwWwJwmmuG8yuWBGQ7WY9gMW3EJDuX1XpYC6badtPPJ3lUqIdIc/agEZuzY3tDigg4jNMV8OHJeruf/GLkcwnfvKGq9gJaftMbNDaaIofcBUP87o6NWYFZQ9muBXh/rqQ9VPVlliHVPjHsPZwKhMMZVyrE7ASOe91zhVxYpzYLmDWEyxCN+D9Wk2cm35EkzsDpaTy7RFxOVBo1xXN5QhSp7ox0Qceow9ESA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oJlEsqJBZUW2xJpwCYcHTiSLzYNDFXLrdNGOBNRJ28E=;
 b=IC8Oiu9ZFHOy+eNYIoJpsBIgL4zQBB9lXEbijf+f/rZXoyMyCO8ScHlllKeA3pYYcOg3Xsw27GDELQ6kA+GKMmG7BLBKOkDM9rU/ZSUO/dXOs6SibrLv5WdkQnWTxmVhyJFmhEqMIENAFRRUux1wk0jOBOJnoxZjq096VbxhIzyqJfMJObHhvVttVJZOQNdKKHym18pKAso3mZ3Rn7eIe9wAmiM6PfmTzQPUD9tHDNVTPLRgqwvO7FjuhIoOHoJBUXpAWhyzGzTnAWUS38fQdrOUYt7Ekb1ynMVhRQRwIm8xY2MQJ36LQ8OnIR8cIZR6qQ8HrP0PngsCgt7E1g6ERQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oJlEsqJBZUW2xJpwCYcHTiSLzYNDFXLrdNGOBNRJ28E=;
 b=t+l++bEJAXEGY3gkLVjjOt6mOes3mPbUv6whbqBFaKQUqDkmb2lox6U/guNK6B1l0u+wm6S7rCnM1IYI8ISWRN02EAxnyd0oIpdr4+SmJ1vkLAFUIUfKHNCxqBxs+l4S/6F1iGxesRKODRsFoHnBtap7OTKPMWynhsXquIutqW3EE5w309swljrCDaHQQ8bxC0aZYUiTql5anyY6OL7q7h0URZQ5m2MeQYQA6XOk7Bjec5Lt0oIgGSnl1/swdrXebUXl/jNMepMgJPVTgaXNXcL/sQgh1RnOztlxr/O53HbhqiERRByYy4f5jEhpVKLJ+DqVODcv9cbF2V1IvCS4iQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM0PR04MB6771.eurprd04.prod.outlook.com (2603:10a6:208:18d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Sat, 12 Oct
 2024 11:10:45 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8048.020; Sat, 12 Oct 2024
 11:10:44 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Sat, 12 Oct 2024 19:19:10 +0800
Subject: [PATCH v3 3/7] arm64: dts: imx95: update a55 thermal trip points
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241012-imx95-dts-new-v3-3-edfab0054c71@nxp.com>
References: <20241012-imx95-dts-new-v3-0-edfab0054c71@nxp.com>
In-Reply-To: <20241012-imx95-dts-new-v3-0-edfab0054c71@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728731962; l=925;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=/qrui9u5qofjt1RUcwml/MfuYITi/XfZnTB2etBFkzI=;
 b=2NK0+6KUnIiwMcvyWt4FH6b5KXX9sIjSe3jsMsK1V4wmsHKSz0i4LAj4SeEQ8zpsz0JBpUx/j
 leypjJgE/UiD9XQFl9UtEA89y+bg3L7rEK/lqi+mbDhbhU16sSloEuA
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG3P274CA0020.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::32)
 To PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AM0PR04MB6771:EE_
X-MS-Office365-Filtering-Correlation-Id: 22fa1797-e606-4d8e-580b-08dceaae8480
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|1800799024|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dGdhMnIzdkwxSUhRNEdXS3Y0Nmw2aUtnSjUyM1FkY0dab2NVNjZ2UEZnNGpI?=
 =?utf-8?B?N1lEZW1EQVNDZllDTDhvZVVoeDRnU2ppNnZzYVJDa29zUU50cC9zL0NOY0Nh?=
 =?utf-8?B?cXd3aE10dkN3czVUc2Y5SjQxWTRoeGVmU1NyaC8zRGxKcHJEZTJtWWVLN3VL?=
 =?utf-8?B?UEVPTUFtMkd4REV6TDJTaE5rWW5GMkRyZTRaSERuWGhiZDFUV1BDQnBOK1Ba?=
 =?utf-8?B?R1RIdUc0bnFUNm84ZXY3bnVLTHN6SlFzMytkNHkweFZyRWlyZzBNdGpZMzlX?=
 =?utf-8?B?bFh0ZXVPeVJKWlM4UnQyazFWcTJ2WW5EQk5LRlg2dnRsWm42aWZ2b1hwcXVq?=
 =?utf-8?B?VXFTZXZYTURvNU5XYW9zckVuc1hZeXZ5YkM0d1FFQktEd1E2eVl5Tjcwb1FP?=
 =?utf-8?B?QmFYSnlVczRGMWNwbGhTZmwvU3ptVmxhdU5NbkxGeHVIVnBVK3BtbEduVWNZ?=
 =?utf-8?B?NTcrZlRvaFZvNi91S1JRbGR2ZG9VR3laTnBxK3Y2QVg4WU9iSWhMU2pZeGZE?=
 =?utf-8?B?Qk4wd25VcnRoMDd0ZWhjV09JRVpPL2NnbkhBUm5qOWtMZGUvb3JIV0RJRGRG?=
 =?utf-8?B?K2NjN0ZyaWZoT2FKT3FZazJNUVluTHZ2di9zalFKZSs4SWUydEJ0SUlJTlc1?=
 =?utf-8?B?OEczeE1EZTJQdVFkdC9qYTVSdnhUcjdWN1RldFdKekNCMjhPWWU4RCtYQjN4?=
 =?utf-8?B?cEpxUy9HVXdTYVphL1Y1L1loSDR6V2dPbnZZZGpmNUticjBoYVppYW91YnM5?=
 =?utf-8?B?YXpONmdDQUxEU1RNWDh3S2JKbjB1OFZQY252WDl5bXlNWFFJQS9Fd29kRUJs?=
 =?utf-8?B?VFpGUkV5bk9heU0zd1pqZEFkNVYzdkEreGE4SE93TTV0TXJHNjRSZ3ErQUxJ?=
 =?utf-8?B?Nms5STdyMExTQ1N3dzZ3YTdwVzBBbXRGQjNXL0VhUUh0UUhoNHZCcS9KUzc5?=
 =?utf-8?B?amNQczFvNzlUMHNVTmtvUmtWZlVXSzlqM2l6dU15dDFISTlwTVhvOEFqVUJj?=
 =?utf-8?B?Zkw3MVU1WGpWcWJ2M0Y0UDMraUl4cHJrL2laLzJUWUNwQUc0UW54L1R5eVBC?=
 =?utf-8?B?VENWK2NkdW9HcTI4NkwxMzV0Mm5aMTUrdk16aGlDMXZKU0hlaHBhaGs4cnJK?=
 =?utf-8?B?ZTJPV2ZKR3VJbTJ5RmlYSEtJY25tUXoyb0pvM1lWaXBXSktVdlJIeVM2QzBa?=
 =?utf-8?B?RHBWVitySjREaE1FVlhPMEZnMHJ2bFhuRnQ2bzZqUEpKR1E4Ty9WcjIrZjRY?=
 =?utf-8?B?K3BBRUZzaXQ5dWw1bGtWSi9OUHpvcHRzenZmQlF0ZVhNUDQ0bHljRy82QXdW?=
 =?utf-8?B?Q083cjY5STdhZ3h6RjVzOU81cnVOSFlTSU9paS9JV3NWQjgyZS8zN2FPUGd2?=
 =?utf-8?B?NnVqYjlrNFAxbUVndS9hcVBpcFYxYXo1b2NLcUFnTzN2MDJEWGZkN0ZKTy85?=
 =?utf-8?B?RXZoQWdtMStOVjNMVmwxeEExZVJ3NkFxSnpFZ3hEelZkQjJ0aXl6MWcraGYz?=
 =?utf-8?B?ZEMxaDZKVzVVOWE1RnIwSFpVeVNCNUh3eFI1OEdFQmUzOXZueHNiSjZJSHgx?=
 =?utf-8?B?aFBUTkVUeHFJa1JZb0F5TmdLMXlLNWN3N2t5Ly9JWTd1UTRrN1NvbEl3K2VW?=
 =?utf-8?B?dWx6VXpwVGo5Ry95ZUgzVndTeEVMbEFmN1dmeFM1VHNWbGg5TXVzazFiK04y?=
 =?utf-8?B?b24wRjQ0NVZYMm5qSjVUUnFuaytjTUpDQVVLNHVMaUxaQVJWcEpDb1pyWWIy?=
 =?utf-8?B?a1F3MEVRWDdqNU5ZODRjQ2ZKQ2UzTjMxRWxEN2g0NDY5dSsyZmwrdTNsVjNo?=
 =?utf-8?B?ejhBVUhHRXkxWTRHM1RmZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(1800799024)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MFRwY0dWSTI3bGFOTHd4OWRiSGlWTjdkQzFvZHRJejEzakxxcy9haVhvV2lF?=
 =?utf-8?B?bFFCTTZndTQvY1I3WFpSbjlSODR2VkI4cXVEOUFDbGJFcE1SazE3QzJRVEtP?=
 =?utf-8?B?U0tBVjROdzRDS0VJaFNrT1dyVUkraG9Nc0p2NUJjeXYrQmVsdTF3Ky9PNXpP?=
 =?utf-8?B?Q0VQTmZFREc2d3VlRGtCaHliZjdsS0p1Wk9pb0Y5dkVaWEN4cXExdnBXbkx3?=
 =?utf-8?B?VFVLb0VnNzM3aFhWME4wNjBnQ2ovRW9WMGdBTHRxN3RiWWRjWWZCSmlJT2Y2?=
 =?utf-8?B?R1pVVFNSN1FXa3h5UzJTbEpLM0RDM1RmUmZlSloxTnBycEtNeXVvaVZvTUdF?=
 =?utf-8?B?YWJyT2tuaS9OaVNFQTVDTTQ2YUJsMEpvUUVudWx2MVI0bjFzbkRicDk1Rmtl?=
 =?utf-8?B?elVMVlNxUlRLUTF5Q1Nvd3R2NHo0bWRXN3E3clRBQ2RpZ0Q1VDdWM0FFOEhs?=
 =?utf-8?B?akhtTWRyWk1pL1dHTi9jd0J6WjhUS2M0V1FOejZoNGN3cFVZTHlwbFc4Z3pm?=
 =?utf-8?B?V3hxT1pWOEVLU2txSmIxdDUrbjdBUHZhd01HWHdlZnVzdDZRR0J3cEF3Z3lY?=
 =?utf-8?B?SEdocFlkajRNeVErUTk3MW1mN0tsRDliYURmUzBYM2ZCbndjOU1LbDMyTkJ1?=
 =?utf-8?B?WmRib20yR0ppYmx2eHpLS3c0QXd4c003NVJyNWJhbW9SR2RtZWdBbzl2Y1Z3?=
 =?utf-8?B?Tkw5TWdWTTd5ZzJ5OHRWUmh3Y2VEZlVEUkxrSFJWVnVlRWdDSmZUUUxPaHdN?=
 =?utf-8?B?OCtOYy83ZjNyWU4zbGRwbkFWZ2YrQ0ZJQzBkRXJvbjVwYXQxY0srb1dRaTBh?=
 =?utf-8?B?MHZybmdQb1Jqb0hqVmR4MzJmYWtwb2xmR3JiTTc2QUloSzZQUFBFbHhqRGN6?=
 =?utf-8?B?a1hxUjNsQWFENHUyN3g4UTU3OGZzLzJvK1dWUDhDbEpCWGVSMnZScWVyYm9w?=
 =?utf-8?B?eSt1blZaQ01teDRxc2dwZlB6Y056c01XbDNDSDk0S3hHRXN0Y2cxd3hQSlMz?=
 =?utf-8?B?dUdwUkdEUXVSRTJZaTVFRWtTLzRuL1JvR1UwbUk2ZTBDM2pzNW8wNnc5cWJp?=
 =?utf-8?B?YzcyVUxHSVZETXNyWW9VOHVuWUxLMGZyNEZYTVREMGkzZWxmYmo1bHYxY0Rk?=
 =?utf-8?B?elF5R0tPVkJwcFl5MXFjTERpbTNmR3c2anN6bmxjSVhoUkpjOHJvRmN3NVYr?=
 =?utf-8?B?d1dXK1NnRmc1QWg1NmJwV2FSSVB4RlFKN0VEc0M1QlVqeno4SUt1eHhCK3Y0?=
 =?utf-8?B?OVRDVGxDWGZmYkwrNFJuMEVjZU1yc2hMcHVtazM3enlOQVY5NDdJWFk0NndF?=
 =?utf-8?B?aHBiMHZsNHg1ZG9oQkUrWmhPWGl4ZStFMWJuYlQ5UzUwcjJDcXI5U2pJa3hE?=
 =?utf-8?B?RzY5MGtrWkl2RmVpa0dEYU45YmZKQ3RDdmgrcm1OQ2pTSXByQWx5SXNRdmc4?=
 =?utf-8?B?VTUwblZqd2dNRkdpdnNXSHA5b1N3MHJCOUpoQTl2WENxdWhGRzBGdS9TcERz?=
 =?utf-8?B?aXdkdkp6NksvT1pTNzFXL0huRW80ejdhM2docDEvY1ZDeUdwVldLMFhaMzJM?=
 =?utf-8?B?S1VKY1h4dzNjUTVqTmUxdUEybllXVlNraThVQ0lvYzQrYnp6emZIRzNldFdm?=
 =?utf-8?B?cVRKU2lCWGw3NW02SkdVMjFhUjhCWUR1SHZJdDRHZmpzdXJadmU5Q3V3eEZH?=
 =?utf-8?B?My9ncmlCcDZUTDlSdzJIOWhQUG5FVmoxM0dHNVdpbTUza2pvMk55aTRESnNN?=
 =?utf-8?B?bXFpQzNReU1idzJuQmIyc2E4bzZ2ZVltMWhUa2o5d3VyS2dJSnM2VFpUamF2?=
 =?utf-8?B?R0hHYmNWMTNhZmdkay9DenA4NEVVd2Rka0lmcjd4WVdvRzhzcDNkYVZ0NlR1?=
 =?utf-8?B?eVFvRThLR2lxOFlQSklQcUhFR2xqUnliMGh1cmN5dUxoQk9RanVmNEVGV1dI?=
 =?utf-8?B?TC9VVjc2R3hjM3RXbzJDVzA2VDV4WVFmY0ordHJscFI5c1FkWE1OTVNtTlho?=
 =?utf-8?B?Rm1BWVRySzVEMGR0c1lGUlRRRk1QUytaZGk1YnFTOWxML1Q4RlhPRnk5VlFy?=
 =?utf-8?B?clZHUUhXMjhLWFlUY1ZRNHBFUnFWdE4ydVcybFdVZ2ZZR0hLd0xCZnVKTGM0?=
 =?utf-8?Q?qEGofW10YxVnARx89swnfwdpL?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22fa1797-e606-4d8e-580b-08dceaae8480
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2024 11:10:44.8907
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xYU03xXRopupFU+ORBgW5lAPuPYGAkOHtVtFbCm1LxA/7IMtz8N7OqW87N2XTp3DS6J2/r0e4oCgpDMDgqKnUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6771

From: Peng Fan <peng.fan@nxp.com>

Update the thermal trip points for automotive and extended industrial
temperature qualification processors.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx95.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx95.dtsi b/arch/arm64/boot/dts/freescale/imx95.dtsi
index 7f4e7579cdb395177c28f41159df36b871a6384e..a96bf8e6a1a29f06741cdf5ac20e414ce71b5c03 100644
--- a/arch/arm64/boot/dts/freescale/imx95.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx95.dtsi
@@ -346,13 +346,13 @@ a55-thermal {
 
 			trips {
 				cpu_alert0: trip0 {
-					temperature = <85000>;
+					temperature = <105000>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
 
 				cpu_crit0: trip1 {
-					temperature = <95000>;
+					temperature = <125000>;
 					hysteresis = <2000>;
 					type = "critical";
 				};

-- 
2.37.1



Return-Path: <linux-kernel+bounces-362304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F39B99B353
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 13:11:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D644A28539A
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 11:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB9041925A8;
	Sat, 12 Oct 2024 11:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="mQ27Bf51"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2056.outbound.protection.outlook.com [40.107.20.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F06186E43;
	Sat, 12 Oct 2024 11:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728731457; cv=fail; b=Fc/tS+NmGGDeSCf/nDqglRIbNF9Mpo9aCxYq6/GMEmh7PjozNOPJcGc7MkmlzL2BSkH0Tt4TtgRbHKMQS2JUv1UvKyh/veNbrLkfnPDn3W2C26VmKnB1ncRn8yxTw0YZfghYkNhWgYQUrP/PwWkZzE4gHY4ua9skO1LSqSQDw7o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728731457; c=relaxed/simple;
	bh=CdrfpMsoUSC+zOrkeTqk4wUz1KXavbJPyZPAXyCQmYg=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=DqgLDG/RH7+5YZgZMaVYC8fwmTj7JTE5h9aELPOgHMsM4pfVig7TezE6yPsIK4sZb1NgI906lev5iSphp7HsJaOtvujZdIEfPUgZDCXi6AQ6HfCWQLEjrLz8dndUamot4sBV7OLAMpsrzNWPjQ4MrHgHlRqvmgHET+Q/8Rcp3jc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=mQ27Bf51; arc=fail smtp.client-ip=40.107.20.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lckGyceTZCBh0q4p/m0zvoEDY7habk5GnU24sCoodPB4qyUYBIT7qc188aevcNt5RsMsr0Piwp9wJS2nkGDTblUSOJb4StIb1cs3bZeZDtKsthsxeYQ29o3CuTq1NjUroylNd6fj93ApttwU0cUFeL/VC3gDmBG/DtKUcB0OKfCLBkGnUtAXV6K7A402VKnI+B3faOZ53U7v0WE7WMfmh6SxGJjILryP5sllGENwyK1WGwsPrA1K8OHPeTGJTP5unZLHpQEz01qNZYqmrU6iHNLPv3VaMYO+IV0uUFxpN5cJuwhEy21zI6PxUR1J3I+ncOuxzJjYvTlejRR9HSRNkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pHtZJfnKYH4Raz62u/mXr3814p/67aHo/XXP6EMdTy0=;
 b=pa++AqjCUOBsO+yhZDYCDEdoHPiudbJOaqGKqbgyrqDKJam3DyXW4uWmEEspvPXgsJ5mRbkUie55m1H2QaVvINcurcP2GltSpEVDuyLRJpPiOnftt3ZXabpN8dBcIwfzlnjjPppRJOwJAYrEN7ulGv9ax8AiSSzlJ4b2HBaViFUCu9iJeGXUmXDxuH/vtIe6+OnnfU9X8AZl2oTYpuenilxjXQn7UcxbR1zuEXoKByb2yHHAmlurKE4cJYD/5pvQWgMN/X2yr6xmquYqA4MNf44REz34KvgXFeA4M3K143TbGW3d5/WDEmHm1rbJ3KyXIGJ35YGxTf8w4UClGrAVCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pHtZJfnKYH4Raz62u/mXr3814p/67aHo/XXP6EMdTy0=;
 b=mQ27Bf51VwXQr8BuxkMFFGNgKYdjqIplNfF44SsRdlsRrAT7Oobz3NHqPcA1B+/QupZU/kV8fLw6Ow7CAx93eMoXA4YAegmNqRDSgt+fASJZhJdMF/p/j2KPMwVAmf/5xnsQnUtj6c8GtqC6DzvcPTOMs+GW8kquezAzKzdmsy8PY4fHEHBwr/Wz+azn3Sa0Dia7VFt6si9Ib7jFeb5GUJY711nhLZ47sjIu7ITmLbKcbBy/GkqWrR6Cx3hhR3hOzUZ3dT+4o3WO/Kfl5v9w/wkYyjSdojtDBrB7v+6X09EH0DoPEKcYm1puKX5qXtTbzXXOygZkHA8ayr4FLXacxg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM0PR04MB6771.eurprd04.prod.outlook.com (2603:10a6:208:18d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Sat, 12 Oct
 2024 11:10:52 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8048.020; Sat, 12 Oct 2024
 11:10:52 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Sat, 12 Oct 2024 19:19:12 +0800
Subject: [PATCH v3 5/7] arm64: dts: imx95: enable A55 cpuidle
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241012-imx95-dts-new-v3-5-edfab0054c71@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728731962; l=2534;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=3oXehUSG9ONYaFOa4/UhRkXn4vzA3SRO/Jg+dr7/9zk=;
 b=Zy8DIIDcf1phPv4q4Ap67SipL04rHqtbL0iZEX3y/NnrEsMC4yem/35Dnvdw2OGRGgK8iYP2I
 okoKZUKhNPzC9hwKeQayyO2VXXFnLuCB7iVP5brM8qp1oG+TR9GmVmw
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
X-MS-Office365-Filtering-Correlation-Id: d77e501a-0a18-4e53-d91f-08dceaae88b9
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|1800799024|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cElLLzVnZDZqUTBMYlpqeVAxa0NCSE52dlNRYjA2OFg4ekFtN2VyRTFMbXFn?=
 =?utf-8?B?RkR0bFBOZTNMZVEvK0crOEpQNVZpZDI1UmtzemJ0aEJxMGM1ZEVVa0grTUU0?=
 =?utf-8?B?YWNTblQ1eEpNdWRHM2pZUmo3LzYvQVM0RXhkb3JzYk1QQnlPZTBKSEJXSUdm?=
 =?utf-8?B?MXVwdVM4SFpjRC80eGlHbjdYQzVTS3IyMGY5UzZkVGtDckNqTUxKejRUNERa?=
 =?utf-8?B?bDVRaTVGQ2k2QVdtU3NPU1Y5Q3hSQ0IyU21yaHU1YXFIYkp2UGxoNWxOTDdF?=
 =?utf-8?B?Tm9mQlI5d21wNmN0cU5lNlJ3VCtMOGxDc3BvUDYraVZzcU9UY2VHc0d1c0Rj?=
 =?utf-8?B?a20yVnFtUC9nSzh0NWdDZ0gwYVlwZUF4NllrSTM3bVU0anBMOGhTcVkvbkpD?=
 =?utf-8?B?aEc1eTIwNmNxMW40YVBpb1ZGaDNsQWtnS3J0UDhNdDdzVHc2S3BJVWkxeDFS?=
 =?utf-8?B?T1p0T3hhRHJHcFh2c2luOFd0TmFzc3FPR28wREt6T3krUWt5UXRtZTVUQ1Vr?=
 =?utf-8?B?NzI2Y0lGMEdUMFVhMTJOUkh4dWV0WVIyVFloaVVtT3BIeFBnN0w5NVFYNVha?=
 =?utf-8?B?WXhDVWNEYit0RTBkR0hLVzR2Z200OG5oNzhXWEZwdnBzKzdXN1RqL2g4Z1Jp?=
 =?utf-8?B?Nll4S0M5MkRiSmhnRVBDbTgrZFd3MXIrZDNhUFFvdHdWekg2WEVVL1lUUUls?=
 =?utf-8?B?WFUrbEIxY0NuNWdsRjZNZkltTGNpaUREd2IrUW1GZW93L0NFUSt5bm1RMUFo?=
 =?utf-8?B?WXdDMjF2ZUVMemU5Ny84SEo2Nm93czFTVHBEYkFqMnQyNmJNOHgwZ0UyNG5F?=
 =?utf-8?B?MTBYNkJRZGxkWTk1VXVJSVM3cVRsUFVJUnFlWUxIWHlid3pIMlZpUFVneGVN?=
 =?utf-8?B?amhIMnBSamlHb1A0QlNDUHAvU3Vxb0Jxb0VxQlV2YWh0bTBFdmZYTUNwVGxL?=
 =?utf-8?B?QTJ0ZW9XOVpKUnl1aldXN1V6dzdDSHJaVDd1RE5mU1lPbzFDRWNmTWNpRjdG?=
 =?utf-8?B?RVQxVkQxWDJ6QUZHNUJNMklJc2p6Umt1WjFXcHhBbG53c1VLSW15YTRYUFFv?=
 =?utf-8?B?VVJRWHIvVUN6cTVUUUJ4dyt4TFdUOEMyWTRndTVTY3A0NkcwS2tFUm5SMTBQ?=
 =?utf-8?B?bGdEZ2JuTFBaTGxNQVRXREdPQ3NlcFhHZHVmellLZ0JzMzZ3K2RjWjJRYTUr?=
 =?utf-8?B?T0lqK0w2MHBWalR5Tnd2SGFNZ0c4ZHA5T3BxMlVlOUtpbnE3ai96UzBGSjFK?=
 =?utf-8?B?V3NvVXJCYjhMOENwTEhtVTZaMmx6M01TUngrYjdrUllNdlpiRkx1YVNZdThH?=
 =?utf-8?B?VkV2TTB4OFc3N3kwRnMwTnhYa1gvQ1dORjVVSjJzVW5LNUwzK3BOWmJkdUV2?=
 =?utf-8?B?RnNTTHFLak85SW1nWjdyZUpTYm9wUjhoaFBma3ZpWFhoeXMydHcxb3pzSWp4?=
 =?utf-8?B?L0JuK2FZV2sveUpDSHF5d2lNb25DVW4rYng1MEdRV2YvdVB6Wms1VE1VQXpl?=
 =?utf-8?B?cFdaRytmaEI1MittOHNCSmJ1UHg3SVVxbi82QXNDTWNTZHc5bkZobGJOTmZE?=
 =?utf-8?B?bkN0U1V4ODRUQS9GYWZ3aDQxR3NxUWMrajNwcjhGUzVXNlhPRDNrcHJkVjNw?=
 =?utf-8?B?N0g3T0lrbldFU3BidmR4S1liM2FVSHJPb0NsY0ZGZ2xDNFkwZUpXQzgya1ZO?=
 =?utf-8?B?QUxaMmpVaWtzUGgrc29QUVBWZWRIY3VBQ2FRazQ5bU5ncWRUV3pBWHZXN3BJ?=
 =?utf-8?B?ZnpYalg0aDZPRkFUc2R4dUhTL0xrWWpVVVFrd1RVRENhQllmSURmaE1oT1Fj?=
 =?utf-8?B?MVBSS1o0MU5NcjJ0Z2x6dz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(1800799024)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V0tJcEtnOVZUY0k3U3ZFWkRLVUFxMUNOaWI4eGNHYlJSUC9aZVZRZjFNRHVv?=
 =?utf-8?B?R3poaEhvdFM3YjZMeXZMa0lwUU9LQWsyRmlYZmNhVmo4ZkxXRVRiN2pIWjlO?=
 =?utf-8?B?eU5TcjVXMExkL2VYd3liQWxMdldTRDZHYmNPYk0va2s5YmsrMDNQaEpMTlRu?=
 =?utf-8?B?aXpCY0ZCWFdLSnk1TjgxL2gxZlRIbHp5U3RCK1FxNjBDUHFJeDI1ZnI0aW5H?=
 =?utf-8?B?ZFVRS2VrcitNMVl1K05sU21sUFBNQ1k4ZnZVUkZ1UXk1YkRYNmlqMndDWkVo?=
 =?utf-8?B?NXhsc0k2azl1MkNoaGRNOEhpaWZoWXllN05KTFk2WGFXdmhUNUpxWEdlcHFH?=
 =?utf-8?B?WVlKOEJ5clBGaDMycjUySWVDb2lMRC9xbTFKNk1RaWhWS0hVb21nOUREcHVI?=
 =?utf-8?B?bVFiSFl1OFc5K1NOREhRemNSWU1WWDdVSjc2b09yOEpDc2U2dlhwRmRlcU9o?=
 =?utf-8?B?eFc5M1FWOGRoYTRxbW9Da1RYZVBvRWlST3ZZcDBpcDZ1VldTNzUzQW9PVGpI?=
 =?utf-8?B?WmV2dkMrVW9sUVRYQ2JOVVhaM1dleVNhd0xWQkdLd1hDQ3RyTFRocTlzTlJV?=
 =?utf-8?B?QTFLblAzRWFuZE0rWHFpWnFHV0ZMV2JrYzcvK1VPeWlRWkprZnBzMXpKWWgy?=
 =?utf-8?B?dlZ4VVFMSjVvd21tTkFmNGkwNUwvdG5BMStwdVkycVdkWmFMQzg3MXl3ZlFi?=
 =?utf-8?B?VjNWbVNncDA3SkdEQmJxYU9FYldDbzZ4VWZBcm5BZ2lYY09SNnYzbHp5OTdG?=
 =?utf-8?B?andBNnpUZFkxRVpPaTFNeW5Cc041Y01uczdRSXNZd0tQRXNqb1ljQnpHMFhy?=
 =?utf-8?B?aTFadXBGL0MzN0xJeUhTbDN2TU5uNlVHUmlBbTlsdVlEV1JpRHJBQU9aa28w?=
 =?utf-8?B?NE10djZkUHU3MzArUnRVRTdGdXIrd3k2UEFncEMvZ0RTdUxSWTZYaGVzWDFi?=
 =?utf-8?B?Q2pxRmZhenhsOVpRWFNEUFRyak5ienJsb0FEdVd3QXBwaUlFdHNrVDdkRlpM?=
 =?utf-8?B?Y2t5a09taGFDcllHTHFMdGtEeUhQYnNueUJoN2FRaEN2Rm5tYmlLUFlHRWtp?=
 =?utf-8?B?RkdIYy81eUM2d1NMaytOTm1RVnkyMm9MS2lyS2ozdEhrOFE5ZE1VZU5sUklF?=
 =?utf-8?B?OHlBdU55SmpURGtlU3VTblpLWE4yOVM2RDFhYTZaVDZlQkdaVzVpM0E2MUVL?=
 =?utf-8?B?dElkQW4wQk5jM0dXbU5NTHZsbTJtNVU2WDhnNlZkQkNXbkhhMFRadDcyUjA1?=
 =?utf-8?B?NUdiL0V4aHEvREZ2UXRRRXp1Wm1YM3hjanpvLzdvcm55VCtWdEczR3JmV1B0?=
 =?utf-8?B?a1A2NktWTFU1a29DWE45NXh4bmlWdHlPdEZnelFadWI5dlp2bUx1UU4rN3lR?=
 =?utf-8?B?Ui9zSVhJTW9Ka1VFeW80RjBINkVNTGFRdmFFL25RRW9CWUp5NmFCK0EyOTAy?=
 =?utf-8?B?YkxjZyt6eTFWaEh0cklxUEM4NG1uYU5aZjdPSmw4T2lmQ01FN2dQbFhYaE9B?=
 =?utf-8?B?TGIwSDNTN1p5SDRwanJMWlBMMENmQ2JxRFcweC9iNU1HYTg1MEhCa1A4aFIx?=
 =?utf-8?B?VjVuTUc5UEhtaTg1a01lWWdFYThabmlZQXlvR2pFREtZVU1UaVZsWlp3elpz?=
 =?utf-8?B?VFNFZlBGY2wreFJreEsrMXl2dzYwNmN2eTJ1YXFkTnh2YmlxeGRXVSt5ZVJX?=
 =?utf-8?B?VngwenRlOEtCc0ttK2VUdXFyZTNDZjAzeDFReWZtSE9zMklrd0pBVGJQSzZP?=
 =?utf-8?B?d04yL3ZtZmh6YzNOTlVGVlU5YnpQaGRjZkZLTnFJUVRSb3RMR0UwU2t3aHBs?=
 =?utf-8?B?MkNSZG0wTjVBOVVLM0IzY2lqdmtEUDFyK25iL3VZOVJzVGlhS0V1QjlpVms3?=
 =?utf-8?B?VUdEZmdBYTRFTmxGanRuM2E5dFRKcVl6RklZSW9jUG5pcURqa1JHWkxiWURk?=
 =?utf-8?B?aUo0UElHL2VsZmF6cTYycmN3TEl2K05ycXkzaDV0ZmdtSmlrU1RtQWRqVHFp?=
 =?utf-8?B?UktnWjhBcEhpYUtYanlVL1Q2eHNCeDRXWFdwZFVjNVVYRWNmYjRubldLR2ZS?=
 =?utf-8?B?WnR4cHpVNEZJeXczV3dDV1k2ck5pMXJRS21xNWhVZU1JWXBCVmR1ZmFaNzcw?=
 =?utf-8?Q?tEVRLgW4WmcnkruUznHV8tODX?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d77e501a-0a18-4e53-d91f-08dceaae88b9
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2024 11:10:51.9715
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 33XSyO7m2P0LxKGUylvotAvNjFVISvNSiiixve1G9TKVYwDcY31KIzjkJD49s6TX88S6JdPQ7vLRBXigkdTZxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6771

From: Peng Fan <peng.fan@nxp.com>

Add cpuidle node and enable cpuidle for A55.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx95.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx95.dtsi b/arch/arm64/boot/dts/freescale/imx95.dtsi
index ae8e09203ef431d8869fdce79df9f31a3e55971c..62bb526ba507b9fefc8d90743d653e9dadf030ef 100644
--- a/arch/arm64/boot/dts/freescale/imx95.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx95.dtsi
@@ -22,12 +22,27 @@ cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
 
+		idle-states {
+			entry-method = "psci";
+
+			cpu_pd_wait: cpu-pd-wait {
+				compatible = "arm,idle-state";
+				arm,psci-suspend-param = <0x0010033>;
+				local-timer-stop;
+				entry-latency-us = <10000>;
+				exit-latency-us = <7000>;
+				min-residency-us = <27000>;
+				wakeup-latency-us = <15000>;
+			};
+		};
+
 		A55_0: cpu@0 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a55";
 			reg = <0x0>;
 			enable-method = "psci";
 			#cooling-cells = <2>;
+			cpu-idle-states = <&cpu_pd_wait>;
 			power-domains = <&scmi_perf IMX95_PERF_A55>;
 			power-domain-names = "perf";
 			i-cache-size = <32768>;
@@ -45,6 +60,7 @@ A55_1: cpu@100 {
 			reg = <0x100>;
 			enable-method = "psci";
 			#cooling-cells = <2>;
+			cpu-idle-states = <&cpu_pd_wait>;
 			power-domains = <&scmi_perf IMX95_PERF_A55>;
 			power-domain-names = "perf";
 			i-cache-size = <32768>;
@@ -62,6 +78,7 @@ A55_2: cpu@200 {
 			reg = <0x200>;
 			enable-method = "psci";
 			#cooling-cells = <2>;
+			cpu-idle-states = <&cpu_pd_wait>;
 			power-domains = <&scmi_perf IMX95_PERF_A55>;
 			power-domain-names = "perf";
 			i-cache-size = <32768>;
@@ -79,6 +96,7 @@ A55_3: cpu@300 {
 			reg = <0x300>;
 			enable-method = "psci";
 			#cooling-cells = <2>;
+			cpu-idle-states = <&cpu_pd_wait>;
 			power-domains = <&scmi_perf IMX95_PERF_A55>;
 			power-domain-names = "perf";
 			i-cache-size = <32768>;
@@ -98,6 +116,7 @@ A55_4: cpu@400 {
 			power-domain-names = "perf";
 			enable-method = "psci";
 			#cooling-cells = <2>;
+			cpu-idle-states = <&cpu_pd_wait>;
 			i-cache-size = <32768>;
 			i-cache-line-size = <64>;
 			i-cache-sets = <128>;
@@ -115,6 +134,7 @@ A55_5: cpu@500 {
 			power-domain-names = "perf";
 			enable-method = "psci";
 			#cooling-cells = <2>;
+			cpu-idle-states = <&cpu_pd_wait>;
 			i-cache-size = <32768>;
 			i-cache-line-size = <64>;
 			i-cache-sets = <128>;

-- 
2.37.1



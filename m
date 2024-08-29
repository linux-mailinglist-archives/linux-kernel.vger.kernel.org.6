Return-Path: <linux-kernel+bounces-307702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 037F79651A3
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 23:17:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF6DB28692B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 21:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B87401BBBD5;
	Thu, 29 Aug 2024 21:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="cLEZiZsF"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011068.outbound.protection.outlook.com [52.101.70.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8A718C01E
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 21:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724966121; cv=fail; b=dTQ02KLzEiI6c/uEKVJUc95E0dxfp8W1vQxtpCnxRrdaQBdNJzVugTsgf9b+PuVmzCJu9q7cCAy4zF53w2VJ1yQP5v6yga+xAWifK5ll/ucopi/wRA4bKnzEm2UbBB6asn2ZLBx8+J34+hNz0DOMKfbZekoyBxyXl1Clef2cKdE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724966121; c=relaxed/simple;
	bh=NDB+qerLSlJSMe5Bx3V4/wTHzJgVDT0s38KcjNPNozk=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=YDehaxrzDxIBQzjEKgjMx1JwGnJITjM71Ntrdbd2Lu5dZ8qlOnArrT/GQUaJZ6ZuUB2WIzSHdIZPZxrVcVEKojoEZm9gxFR4ThDdo8elb/ha3zrQUO1wBoMFN+Rw6FxtWOivM4Yrq2zYMD3IQUA6ag4G5cdNeWM4AQSPobjywtk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=cLEZiZsF; arc=fail smtp.client-ip=52.101.70.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qqyw4T9w8WyvrF0XYfSopzomCqIrf2YjFuiIrREvHP7pV1invaIZebZ/7qwL9vMyqG2T4zuc8Z/BXsgxwrjiE2i8Ksbso4gJgjxRFiNDHI6u/N2BnkWGD0JX98+HHvmsrW28eWrfVpgH4LXg2BvTb8q5B4Sa/KH+yjlHTtDV8gvUmOfA90I518+W+krUXwiP5Cmgbzujd0rNiOCHlJLhwCY+SZiGVRwCSpxB9J3jwHq7sIJeL1ZLnMRuyntT61EVyFIuGPkJOeuV9lRaeWTyhyblSw7SJCiW3Ur8QKWq6DqRyQ78mfvc5YIL8pHXMpohvbnEnZO8Zhk7PLX4GDjCaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PCE5o8DgP/NdFwqb2zh1wIauPY2CTq86zMl6jwYhWFE=;
 b=GkLV4daMfEUS5qkS4Dmdh8S01foz75A5Y2uLkjUbERrP4dP2DqUsnDmxDCnXK+op9c3VM3A85k/Bg/Oq+ihlSCnBsbvTDMv7auOqinK2rrtWnFE4wxSwzyP57fvgnY3vJtK8w8J9S7LowDtwd32N76DTtzch2g5oS2y7fAkeYUT8YXTUjyyX4K6if6bDeJsq9bEO26ssRQvKjh5g7CO0LLUP0yxgSUPdQf2T5ParRFOhJUJyetLPB0Fpgn1PPjoo4EJ7F0wkRiLE3E+l+Bm+SYrs5Ya6e2xFHzLZ33bhIJZhMY0VjYddpZbhvu6Fibo//k0rh2jIufYKlx45holRbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PCE5o8DgP/NdFwqb2zh1wIauPY2CTq86zMl6jwYhWFE=;
 b=cLEZiZsFH/yNERwW0bF0le03C6lglDFj9lYbzKvy6dy9J6B7RGNszHvlV6bAERVYsz8p2ByK8hghNW87SOnCxpA2sb1wpDBRPNcRVofADQ5A+yNHdnV/eO+SgApHYtQynO9DDBS3LqvKKVIvYzo0gIdscCulXeueH5hWS+4A2lbYxr96WGLufsMQ6yZOrlF9nkXZcZrwGzpWD0EUt1tC2/6p4EJWtQosVQkhtPEur2lTRxGclJ80VcvCrNRH/wXDWC957GxsexRIzedZvDRUaHeiePyGaLFEnNzrY8DS1QUzesL04aPSsxfUjP4n0pe45KSXZltVW9yzozjJYMI33g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB8971.eurprd04.prod.outlook.com (2603:10a6:20b:40a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Thu, 29 Aug
 2024 21:15:18 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7897.027; Thu, 29 Aug 2024
 21:15:18 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 29 Aug 2024 17:14:07 -0400
Subject: [PATCH v4 10/11] i3c: master: svc: wait for Manual ACK/NACK Done
 before next step
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240829-i3c_fix-v4-10-ebcbd5efceba@nxp.com>
References: <20240829-i3c_fix-v4-0-ebcbd5efceba@nxp.com>
In-Reply-To: <20240829-i3c_fix-v4-0-ebcbd5efceba@nxp.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Boris Brezillon <boris.brezillon@collabora.com>, 
 Parshuram Thombare <pthombar@cadence.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Boris Brezillon <bbrezillon@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Conor Culhane <conor.culhane@silvaco.com>
Cc: linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724966083; l=3288;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=NDB+qerLSlJSMe5Bx3V4/wTHzJgVDT0s38KcjNPNozk=;
 b=q2n5Lsj5KFX1WFbYvjRQ2b8KMqUdUqNDdixIN/PnXZTIUoA6kE4xlWbSYZhZVt0OfStXm3vuc
 3YPriMDXn4UCx/fDL6ea+YjqWu7xpajqmG+Hzik5rQcriQTLpbMVc9Z
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0219.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::14) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB8971:EE_
X-MS-Office365-Filtering-Correlation-Id: 67de2b13-e2eb-4948-25f8-08dcc86faef3
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|1800799024|52116014|7416014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?aGxtd1JySWlxdTlleFl3NExRVHp3U2RXUXZTRmJJU0xoVHNDTUJsa2Rkek5t?=
 =?utf-8?B?QVd1SW5nUnpCWUx5cHpoNlpBaEdrN0NpN0JsNEVORU5RQXlQNHZCUldYYUk2?=
 =?utf-8?B?eUthejVzcENYRzJ3eWt2dWFtSG05ckxPWmZqb2pKVVNVMnNDbFVOZmNHc29h?=
 =?utf-8?B?aXpKNEZsaWYxcEJiVVF4eUtkU0VINzNBdFZtZ0RjTms2RWdiM0x3RTJ5cVV1?=
 =?utf-8?B?SjBmNHVyd3dQUVNkZ0dETXBpazQ4VTM3cEhKOVRPL2UwUEtVSDc0K0lCRzYz?=
 =?utf-8?B?RU9RSWhpcHRhNkNkc2FoT2xBV3B1RTRJZGhYeS8zS2VxN3orTFpqRHZndWhw?=
 =?utf-8?B?bmtRUjJvazlsb3A4L3NFc1JqVVB6RExhSnJTUkRrSno4NGhaL0xnWnYrTFlU?=
 =?utf-8?B?SzZIRzNOMVVmL0RNKytGNWdYdGVYeHQ0TnNkUjBQMHFLZzFTaUJXOTZHV0Rz?=
 =?utf-8?B?dkc4U2pXQmNvODE1NURPQUZQS2M2VFRhaGZUT0s5VWVqR3lOSThKSjRtOFBL?=
 =?utf-8?B?NHpTZng2WmVmd1ArdEdlVTJLeTdjNFVmbHF2aURtaWJ6aWRJSFVYSWpZemp4?=
 =?utf-8?B?MGlFVHY3VmZQVStaeUcraTRtMDYrSTRpZlp2a3RHRC90S01ocmtZZFdtTThR?=
 =?utf-8?B?TGdvcmtLUzB5N3ZhSWVjUm1ad0YyVUhaeXBmS0VUVkRIRVJjOUhycnRVK3FD?=
 =?utf-8?B?N2tZSCtkcGFvT285UEw0cTVBaEtlZ09vejZyL2pGcEgzUWZ1K2JBOExROU9v?=
 =?utf-8?B?cUdKMW9OeVFLcndickJRazI3WElmUFYvODFaK0pxajZkSXludi9FZW53R3F6?=
 =?utf-8?B?WVMvbm5QRWYxeGpZRklnVStMQzN5Z2dCTTc1bDUwbTVIZVlZMlBhVHFQcWpt?=
 =?utf-8?B?SnFXZldncXFYYVNjNzRnRDJaQ1RGeXZ5clM4RzBvUmZ5MlpieHdYbGEzcUxk?=
 =?utf-8?B?VlZMQTdKdThYS20weFBaak50UnFWTTNYYUF0ZjM3bkk4UXcwUkdHbUZSUk5i?=
 =?utf-8?B?T3IxL2NKV0k3VmpsOERjRWYrOTE1OGFqTVJ0UjBOTy9IQks0Mm9iNWtmbktP?=
 =?utf-8?B?azlhN0Z4c0hTNEZwaDlMTytEQVFxdDBIdmx1bC8xdkd1bFFRblVzVXU0dXUr?=
 =?utf-8?B?YWdweXh6cGVjUHNQSmVzakNoZ2R5V01EUlhtcGd3bnN3UC9zb1NOVS8wZzky?=
 =?utf-8?B?S0FnaE8zRFFxWTdmSDZvcWlkVVdkTmwrVkhXc05NL0tYTWZkbFJ2cHRrdGR1?=
 =?utf-8?B?N21UTWltWEJPT0FOQktnWVMyLy8wZDIwVkQwOWZmbkl4RkI2dkg1TEdOeDNw?=
 =?utf-8?B?b3YzMkx3WnZURUE0L09hbitObDFBUmIrUFl0ZHdXdjNrN3VpUVh5b2ZLejBj?=
 =?utf-8?B?bWFPL1dONTZsM3VlMkhaaXhIa0JYL0hUVUhVVHp0b3BEcElTYlJJcGw4VmFo?=
 =?utf-8?B?K0Y5L0JJaThUaVYyUk9BT2I3cmlNUWI5V3l6UnVYQ1BUejBiZnRpaE4xSGQ3?=
 =?utf-8?B?WGw2RjZoeGs3SDdONGJEK2E1TzV1em9nNjNYS0thZWVLUDNNbW5LUWM2M2FU?=
 =?utf-8?B?NzkwNmNWZmdHRTdTMFEyNEMzQWkzMnZDVjZwcmxHTlQyQ1RFYlVBMkRVUlJI?=
 =?utf-8?B?SHRDd0xCaHRTMXhGbkVDUUpoTm9nVVJubnpGV2NpSklROXdVVGFiTDNaRmxP?=
 =?utf-8?B?cVhnQkZaMlFvODVndkloUXR2WmIzU0VEL1NvS1NEelNHU25kQU5ZREFMQko5?=
 =?utf-8?B?TDFlKzNsRTJmQVJUNWZtLzYrb2RtT29KTE1qYjFGcTNvZGY1SVRZQjMrbFl0?=
 =?utf-8?B?MkVWa2ZOL1dObDNtOUtCUWlqd2wrUTFDRzZUUHV3YllqcWI5c1lTbnR3NjY4?=
 =?utf-8?B?Zk1PM1RFSzVPcE5ZcnI2K3JISzRDdkg1ck9tYWxpeGRWNlE9PQ==?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(52116014)(7416014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?c0xPVTIyTHZTOXhxcFRKMy93Y29obXNjVElja1U5bFVGNW9ETm42cXhYRlNT?=
 =?utf-8?B?WkRYZnpJeEVaVzJZbjlLSzV5U0NxTzVJMjdvOGFRdXRzS3hqQ3dUbGRFcnh2?=
 =?utf-8?B?amVUczhLb3VoWm5MalZMNFk5dUE2bFVCeU1IUEIydzgzVnMwSkVneUR6encx?=
 =?utf-8?B?OVVGdGZzazUrWGZhSjBRcTZaMDVJNDAwcTZRQ0RuRE51L0lrQkZrVHR4VXRu?=
 =?utf-8?B?ZWYrOStkRHdwOERMSVhMUW1Vam9YODBPbEQzbk9jU2F3TExMbDREczdJeERX?=
 =?utf-8?B?ZHYvNGVvM0czUUd2WkdQVEFxbUlKYUJhSDkyQ3dzVyt1aU14ODNBY3Y2TTFF?=
 =?utf-8?B?ZFpTRW5ZVVZNNkVpeFdmUnRKNEhTRDVKTHlMTUYyRVRKUDR1aHd5MFo0akl6?=
 =?utf-8?B?a0RQWmRZQTU1elNkU015b0EwUVFJUThTN0VKTnhLY0VPdk12MTRRakh2K2Rt?=
 =?utf-8?B?bUR6UzBLdnMya0thSnVaNjRhcWtJL2FrTTRBT2ZhVHFZS3VFUnVwTkNnZ0hw?=
 =?utf-8?B?RkpXeGsvUjNITHIvVlk4RlllT0c4ZjB4OTU4T2RMQmRBSnltUTNWUGxva3R5?=
 =?utf-8?B?MnFCVVVHR3o5LzlrWlhuMWhVWlBxTUdiV3dqRVFHNFBxNVNEcC9MWG1JOEwx?=
 =?utf-8?B?Q1gxVGN1cmN4NXQ5SEFjWDd0eTE2Tk1WY1V4SHhhYzNyRkNQNzExMWhJL1BY?=
 =?utf-8?B?VGpVWmtQU0x4N25hTUxYNHdYSU5SZFhYbXBEOG5FYUpaL01rU3Q5QjZSSjg3?=
 =?utf-8?B?R3l5SFZmSG9GRkhaMGJMTDhXeEViQU9hRWxCYTZuSVZzMTVLMmpRWnpYeE54?=
 =?utf-8?B?L3BmcEhTTGNxcE05bHZPRzJDNkhVbHBXOENIYU9XdWI0S2ZCamRkS2xPaXVp?=
 =?utf-8?B?cnZleVNHb2F4emQyd3lwbnR2eG8wOGY0NW50VW1vaTlYOW14SkhQclBWK0or?=
 =?utf-8?B?eE1qU0IrOWpqWUlOait0L1NQbmxWUTVIQmNaZXdDRzdrUERNVFNKUG5ucENZ?=
 =?utf-8?B?RktYZjJ4NmZuUmtWL3VoTTVaakhVMHl0eU1ycmlBcGQzY3RhRzFCQ0tUQnFR?=
 =?utf-8?B?VmZmc0hQbWt4K0RJMFY0RDBtM2JNVC9tOUd1MnE4QTdBdURPT3NPUnpkRDY1?=
 =?utf-8?B?MWl1RnRKc21DR2NiS0l4dUlJcjhOWnhGS3NibkhSeDRJdU9kUElIeThwaDFo?=
 =?utf-8?B?RWFnZjFUT3JHVFlkM0hZV2VYeTIvcFIrNE1KM2pndFA1bitzb2tTNmpEZHVp?=
 =?utf-8?B?b3BHVm8wVHRPVDZFeEFENkdJMjlzeHhPNmVRcHgrc3d4ZE9SeU5ES0FPM2tZ?=
 =?utf-8?B?WU0yM3lGMnFCQ25zOVVXazdkeWMzZUg4UjdTck41bSs2WVFnUHNSVkwreHB2?=
 =?utf-8?B?bFJZc1NobWFPSFh2bGpQd2NIZ2dGdjBXRFREVGkxYmV3TmlhWUg3N0pjdjh2?=
 =?utf-8?B?VVRXSzM4ZWh0bkVscGU4bUE4ckJybVhJdVJWUForeU56N1VOLzE3aHR3T2ht?=
 =?utf-8?B?dEQveUtMM2g3T2FsZ2lLaHdjcW52bXh6L0JaWmxkT29DR0tmL2huY0FXZk4w?=
 =?utf-8?B?bUw4SXpRaFV3NS9DU001SW9YSTk5SDRUVWE5RXpvTG1sOUozUWR4QzdrVXVV?=
 =?utf-8?B?RUJtSHpucStVcnlxN01FNHlWSnhMbnBEaUR5NWVmb2ZXQ1BoRXdWREdBSmRk?=
 =?utf-8?B?TjFlcFFkeVh2ZER2WnB0czBpYkVSVkNXaUcxS05PRmc2Q0xjbVgwL3pIOVRB?=
 =?utf-8?B?USswUFd0cDd5UTZFMndjOVd0OVF0SDY5S21OMDMrUGRrMVdKdTVmRmVrNnJv?=
 =?utf-8?B?T1I0QlVKQUN3aGlyaDh2SzEvaWJKbDFzVUJ5Z0dFM2hVSnBrTmM0eUREaUNz?=
 =?utf-8?B?VDVCaHEwOTlMeHcvNWZWQ0VJOXM4bk9FYXdLNlp1VVMrTDNxMzVLbmVwNE1N?=
 =?utf-8?B?clgxdVpxNjV2MkUwUXVvUzQwNUtTSDVzOER4dkJmK2RnckNrUHFTVThsUm1y?=
 =?utf-8?B?MWkySXhEeWpkZlB3R0Y1aXp4T3MrdGk4OCtJNVcxVTRQNkxyNm1zdlJYaFNn?=
 =?utf-8?B?Qy9oT1JmSXJNWExHU2VKRk9qR3h2RFlVQkJjbDVESTFKeEZ3Q1A4azJzZVY1?=
 =?utf-8?Q?MowNEnncTbr+6LbQGNvfsb1lr?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67de2b13-e2eb-4948-25f8-08dcc86faef3
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 21:15:18.2784
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 63nWXblq+KeUyN8xSoD53dvQPCOyZ+iXwzI/0ksBqwuQ2Oeit6Q5DRbjac4L+bmCMMveHHXgiUZFF7gUiXawnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8971

Wait for the controller to complete emitting ACK/NACK, otherwise the next
command may be omitted by the hardware.

A "command done" check in svc_i3c_master_nack(ack)_ibi() and change the
return type to int to flag possible timeouts.

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v3 to v4
- rework commit message
- add miquel's review tag
- directly return readl(...)
---
 drivers/i3c/master/svc-i3c-master.c | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index 2b000f446f1cc..83b2943074866 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -384,10 +384,11 @@ static int svc_i3c_master_handle_ibi(struct svc_i3c_master *master,
 	return 0;
 }
 
-static void svc_i3c_master_ack_ibi(struct svc_i3c_master *master,
+static int svc_i3c_master_ack_ibi(struct svc_i3c_master *master,
 				   bool mandatory_byte)
 {
 	unsigned int ibi_ack_nack;
+	u32 reg;
 
 	ibi_ack_nack = SVC_I3C_MCTRL_REQUEST_IBI_ACKNACK;
 	if (mandatory_byte)
@@ -396,18 +397,30 @@ static void svc_i3c_master_ack_ibi(struct svc_i3c_master *master,
 		ibi_ack_nack |= SVC_I3C_MCTRL_IBIRESP_ACK_WITHOUT_BYTE;
 
 	writel(ibi_ack_nack, master->regs + SVC_I3C_MCTRL);
+
+	return readl_poll_timeout_atomic(master->regs + SVC_I3C_MSTATUS, reg,
+					 SVC_I3C_MSTATUS_MCTRLDONE(reg), 1, 1000);
+
 }
 
-static void svc_i3c_master_nack_ibi(struct svc_i3c_master *master)
+static int svc_i3c_master_nack_ibi(struct svc_i3c_master *master)
 {
+	int ret;
+	u32 reg;
+
 	writel(SVC_I3C_MCTRL_REQUEST_IBI_ACKNACK |
 	       SVC_I3C_MCTRL_IBIRESP_NACK,
 	       master->regs + SVC_I3C_MCTRL);
+
+	ret = readl_poll_timeout_atomic(master->regs + SVC_I3C_MSTATUS, reg,
+					SVC_I3C_MSTATUS_MCTRLDONE(reg), 1, 1000);
+	return ret;
 }
 
 static int svc_i3c_master_handle_ibi_won(struct svc_i3c_master *master, u32 mstatus)
 {
 	u32 ibitype;
+	int ret = 0;
 
 	ibitype = SVC_I3C_MSTATUS_IBITYPE(mstatus);
 
@@ -417,10 +430,10 @@ static int svc_i3c_master_handle_ibi_won(struct svc_i3c_master *master, u32 msta
 	switch (ibitype) {
 	case SVC_I3C_MSTATUS_IBITYPE_HOT_JOIN:
 	case SVC_I3C_MSTATUS_IBITYPE_MASTER_REQUEST:
-		svc_i3c_master_nack_ibi(master);
+		ret = svc_i3c_master_nack_ibi(master);
 	}
 
-	return 0;
+	return ret;
 }
 
 static void svc_i3c_master_ibi_work(struct work_struct *work)
@@ -871,7 +884,9 @@ static int svc_i3c_master_do_daa_locked(struct svc_i3c_master *master,
 			if (ret)
 				break;
 		} else if (SVC_I3C_MSTATUS_IBIWON(reg)) {
-			svc_i3c_master_handle_ibi_won(master, reg);
+			ret = svc_i3c_master_handle_ibi_won(master, reg);
+			if (ret)
+				break;
 			continue;
 		} else if (SVC_I3C_MSTATUS_MCTRLDONE(reg)) {
 			if (SVC_I3C_MSTATUS_STATE_IDLE(reg) &&
@@ -1145,7 +1160,9 @@ static int svc_i3c_master_xfer(struct svc_i3c_master *master,
 		 * start.
 		 */
 		if (SVC_I3C_MSTATUS_IBIWON(reg)) {
-			svc_i3c_master_handle_ibi_won(master, reg);
+			ret = svc_i3c_master_handle_ibi_won(master, reg);
+			if (ret)
+				goto emit_stop;
 			continue;
 		}
 

-- 
2.34.1



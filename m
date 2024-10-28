Return-Path: <linux-kernel+bounces-385712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 713E69B3AC4
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 20:50:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 301D3282AE3
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 19:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AB1F1E0084;
	Mon, 28 Oct 2024 19:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="VCDiKjV5"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2052.outbound.protection.outlook.com [40.107.21.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A50E1DFE25;
	Mon, 28 Oct 2024 19:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730144999; cv=fail; b=aCAQfxAAABj9T+Xvs0rHaigzbFNh6e+La4Uh4mNgQ6jAnOleLVhnmBRfW5G21ebOEsx2+p7GoeFxEO09lgJ253OhbJP+bzdcteYuiPp18HLsePHwOYlaEbIwTAsyuy2hVxQgXPXRza5UXMqXnzbvaVRh7BurWgyO/HKX6yx7dGw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730144999; c=relaxed/simple;
	bh=8w8y6/iWTISCJMgUDwN8ixtlbxfq8jTHmTGN0OK/1Ew=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=olgZ51yjdxj+wbWECPn1I4RcZWC2U4rwzrmMe6lwn1zBwAlvGj9ke9PLpZfBoOWi8lcBPg/HDXJiQnF8LcdtYVD5aaN0tqLuBdkK+mFJqIyZXN11W9XwkNHhpmtvjo/HYpUXIfi1dnrkwtFy7B+VZXUvVOF0j27jqx5RadMZ0lU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=VCDiKjV5; arc=fail smtp.client-ip=40.107.21.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LEK6+VuMH/8uGlUNHMoIHs5IrYS4pT66TXPkoBOLZtZ8f7vihnkOUMF8KdRxQpiPjl2CjwB/rVAtNJIWN430Q3LvGtGaplG6P4vdKohzIV3VJW8LSQfb4ABhe5Nr5hAmDp/tLozYvOKkObVmzanIHNyBiyNUdDQobuOh+nHdE17w9lsRyWmdERzUkYzdaEagiVFLQiswg4cVr00r8RSVtB4H5jBg5vkVkgg0E29Qwb7jSqG29JumHbyx+CLRMCod2yIzOlvrEV4Vd9aAmrB0nysQTCaDWwTA1DznVxzNSJAERDgGX1Fa3KlmK3/vFG6UNYycf6M5/mnd24HxJf/G7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KXrpBZ5gbVrKk6Hjy1/jpq8IQ4DweKMkq1dhcdt3bZA=;
 b=Ynx0w1ITMCFkh7eWA4m4SBfCDmzX9NItP0sfx5uCZqpxon5epGlsTbyb9nboVTygBE5U/lP8r9N8VbVIDd7UNZxFVruaT1q6i1Ht2iLCnreCa68eRmmXzl8V1/f6TObsmrOrJM3CYu4wbuRsIOXxOEbhUatQA0Uo2h1JGdu8FWyrsQJ6hWxaVUQE/93lEzKSmuXRfLl51Q6UszWr73e6o/XVrCJRbibfzJ638gsGJdbMYz8OeJjJz3XOI0HtMivSlIdrRsx3axxWnBdHF80QiaE64Y15f3kecRtkvaJAQD15nsuKal2xJ/UvBh/OsWE8RoObE1z0uHkoJDmkjfrQjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KXrpBZ5gbVrKk6Hjy1/jpq8IQ4DweKMkq1dhcdt3bZA=;
 b=VCDiKjV5Z3XBv0TckxRpuG8HjNqNU2y7anC4aH/i1SHJkxTaJpRIGqCFZbmvhVY6feuwnY1sW7661LD1kcLKjfGhU7psTJhzfKWfP3oRw46xnLxGDHEGJsPvJ41Dt4BhpzSacWxn11q4I2TZwBPw2YwRydEeM6DfN6NKhwr0Jpj8VF+bubZnLjApjhy5k2GYagijOHw9UeQQwaZvMqiVpyDbf6zFkg/aByCIcgyq5EUu2v8V6CiWz86pQkL2vozdpuaLt6znRb8XLaJR50ivBZh3/t9xf2J5qbqcoaNaIHtxZjaiRxpw39yPpg2X1dHivT+RUbVrg2i4c/RHsIX4Bg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB9PR04MB9332.eurprd04.prod.outlook.com (2603:10a6:10:36c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20; Mon, 28 Oct
 2024 19:49:54 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8093.021; Mon, 28 Oct 2024
 19:49:54 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 28 Oct 2024 15:49:32 -0400
Subject: [PATCH 2/2] arm64: dts: imx8-ss-audio: add fallback compatible
 string fsl,imx6ull-esai for esai
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241028-esai_fix-v1-2-3c1432a5613c@nxp.com>
References: <20241028-esai_fix-v1-0-3c1432a5613c@nxp.com>
In-Reply-To: <20241028-esai_fix-v1-0-3c1432a5613c@nxp.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shengjiu Wang <shengjiu.wang@nxp.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730144982; l=1478;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=8w8y6/iWTISCJMgUDwN8ixtlbxfq8jTHmTGN0OK/1Ew=;
 b=KIVDAol3chc/5tRB/IU7jsb89uaU2VUDcrxA5lFZr4GGqgFOK3rwXYcZRqgDjW1HJHdtBKkSm
 ehDNwEaYKAYD0I2tjAAWa4sguznr9NFQiGUqDfbIkDM6OEhKNd+ZcWH
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0043.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::18) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB9PR04MB9332:EE_
X-MS-Office365-Filtering-Correlation-Id: c96343d7-a42c-41a5-65c2-08dcf789b1a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|52116014|7416014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dmdDdGVxZENnT1VGc01Rc3JJOUN4QkhhMDZzSUQ5Mm4zYjBtdnF1TjhyTWln?=
 =?utf-8?B?SUNnMGsxOG9YSlZ5bnJhWnlraEt6M3ltZDNvbzJGWFM3ZUJzcjJiSjNTazI1?=
 =?utf-8?B?QlRkUlNIVFF2N2ZVMTNWZmE5OVJ6RGhBK2FRZXVNd0htZU5Ua0lva1JkRS9z?=
 =?utf-8?B?VExKbmUvelUxTUR3eXlmMURhejNkODVUcllxQmU1ZGoxWjl3djhSY1FVSGJW?=
 =?utf-8?B?cnJjZDBSRHY1RDFFT2Joa3VxejZsb1pYeVZGa01CTCtpY3pGSmt2aFdrTFhi?=
 =?utf-8?B?Z3AyM2RQNFZrV0JhbmFRVjI1SGtTekQ4UzZ0dTZtNVE4VXBJbkFvKy9KRkZt?=
 =?utf-8?B?bVZoblllb3NXQWp2bmZsOHQyWXNXeFFSdlQ1VVlHMTFHWENjblRYWFpqOFpS?=
 =?utf-8?B?aVIyKzRhZ0FTd3owems5THBEYzNCbWZYRnMxK3lTYWFpTlRESmhsUXlqcTgx?=
 =?utf-8?B?NTR2bXhMSCszQXh2aWp2Uy9BVkJVdkk1N3dsb3poQWJBY3NFOXJCdURkME51?=
 =?utf-8?B?SGlrOWtWdm9GODkvbnFpT2RPdkxFQnd6WXdOUTcvWmw3ZWMrU0tiWnJmYkNo?=
 =?utf-8?B?SE1yRW8rNVVVejYzcERXMEh1aHg2MkxQYUNVMEZhODVIVXl4OGY5VmNzMDN5?=
 =?utf-8?B?UWU0cThXS3ZEYUNNNWFWVlBSZnEyY05xNjcvN0FVdmY3R0t1eGdzSUZoZVVC?=
 =?utf-8?B?bDBxWHZWUjQrNzlkNFpON1JkRHZOdG14THFVdkR3UUdmSTQ4TlZsWkE5SVhK?=
 =?utf-8?B?cWpLVjB4Qk1BWjVtMzdSWEcvY0tlck1FZEF6eVRoZ01QdzhBaFA3Y2k1UnZj?=
 =?utf-8?B?R3g3Yi9sb01Dd0NWRDJVZEFHcWRoUlNFbHQvTEpYY294bDdvTSsvSDJqRlEy?=
 =?utf-8?B?V200NHJ5UnBKbkR2SWtXOGtIMnJuNWtiL3pIM3dzeElHUkRrRWxMSmFvVzdk?=
 =?utf-8?B?TEpTeWRMS0gvSzJ3c0pMSklBYTFaMm53ejR2eVRwelNjRE9TakJBOVBySXkz?=
 =?utf-8?B?Q0wweWVEd3dQZDdOMXZ0TWJLQ2hBeE5qcDdoTE5GWmhWeTQ3YnRWaHIzeFNL?=
 =?utf-8?B?VnFET3YxaFJaZStMcGdsYS9PeWY4dzZmTkhzWVJEVmRCL25rVVpMNU81ai9L?=
 =?utf-8?B?RitBWU5ENzJlOUtJNWZydC9sNUxZa29hVFRCeTdrR3R5VFZvbUZDaU1OVjFB?=
 =?utf-8?B?YmpBY0xOb3NqTzkwbjNWazZJTTNPaEdJNVQ5TDJYaUZ6R05SQ09MVTYxTEM2?=
 =?utf-8?B?OW42Z1g5Q1J0czB0elFFa1JDdFBza2JOcUM1YmNMR3VnNzdiQ3BncFdIakww?=
 =?utf-8?B?MDg4MG8wRStrRVV0Rjl1bVk2SFBXc094T3BhbFBvZytkSXE4bTdzV3BPVWUv?=
 =?utf-8?B?REhROCtONlBjcW9hdHJESE5oUThQTDYzWWRBRFBVeTZ3RDNZOGNTelF2MXNj?=
 =?utf-8?B?Wjd5aWd0U2tvRGl6N2c0ZFl0aEZkTVZCRUo3WmMxMHZzUjZFS1c5dU1MUlQv?=
 =?utf-8?B?Tk50c2ZTelVPemhsSFZiQ0ord1JURkU0ZkxWTXdoNXI1akEvNzVSOTFDTUd5?=
 =?utf-8?B?S0hoWE95eGJJaU9DcXFIRGRWb2pRS1FvaXpqT0l3NHlVNkNvV3NJTThaa2JH?=
 =?utf-8?B?WWl4aFhhK3lLVm5hbWo3R2lhY3ZMNEFOd2xueVZTTERMNVc1dlZrbElzUzBL?=
 =?utf-8?B?dXlWWUV5dUtyb3dBNTljRlp5V3hvZUpTUlg1am9FODNneE5Dc1dVVnROcXl5?=
 =?utf-8?B?UENhcXEyKy9NNmtMdUVpeEJUdHo3VDVqbVNWQmtDdFZuUFIyMnF6RTZwRktX?=
 =?utf-8?B?YnFwaXF4bE04U3FvbUs5aFhqTmdPMjFmdzRhbE9WeW5uN1FhNHJhdzFpU1g0?=
 =?utf-8?Q?ZjyO1XpbA16na?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(52116014)(7416014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c1dmbkxsVERVYzFwcEN6N2wzeXZQc3paRzBpdnJoUUlNTTVVRDVnRzlESy9Z?=
 =?utf-8?B?dGl5YzlYTlB4RlFFV0pDVVBvVjZxbFd6QkN6NUs3QzVaTCtBQWQrNEh1b25J?=
 =?utf-8?B?aVl6YjVaUC9sZ0JISEFKZllXVDgyTWRROXo4U2JpcUduUVNlTkp1T2FCVEl4?=
 =?utf-8?B?N2hrVXQ3ZzFiQ3c5WHBUWDRzdzlJdlcrdmU5OVUyVVNJeWQzaWowMFoxRzBw?=
 =?utf-8?B?bEUvSDNRV2pqYXQ4MjBlWkgyTzZKZU9KYW80elJTWC9hWXhrSjN2OUQ0YWhk?=
 =?utf-8?B?V1NBK09INWVyaXZzbnNGTnJaZ0JLa2c5dWE2SmVqT3pxQVo3QnF0N0JwTGJG?=
 =?utf-8?B?L3BDb2d6Z1M2OGI5bnhHcEROeWlIN28wTW10V2pIeW9lK01IV0VLUDI4VzMr?=
 =?utf-8?B?YXpkTk1YSHFEczNRcjZwcHRJSjB5UnhpRS9adm1PTGx6RTF0bHRiUUJCSUhN?=
 =?utf-8?B?VysyZThpRTREdVpWYUZhdWZwemZhT2FhR0lOTnA0ekhXWUFLVGxFV004eGpz?=
 =?utf-8?B?S1hYTU1IeXhyOGRGYkNscGVOcFVMVG9vU0FFbHV6S0tETk1KeldxOUJaWFBI?=
 =?utf-8?B?b081bmtYOHlkamE3L0VBS3NINC9HK1hhMzY3aEdkandTa0RCSm1iOXpCZklU?=
 =?utf-8?B?MHdFSmlDaXZxdENsaVZ5QldUYkdvR2YybnRoOGh3aVNpQ3pUOVNWYU5QY0Rv?=
 =?utf-8?B?ZmtBVzEzYUg1QlBtcnJNeG5mbTZlZGFid1JxRDZZRWsvZ21GRGk4OG84UWVw?=
 =?utf-8?B?T0VBcWNzbkY2d2g1emZzM1NWVmR1dUFoVFVlWnBMLzFQTmRzZFh1eFZ6MkQy?=
 =?utf-8?B?QW5ReDNrU2pKM1BheUMyeFVjZjREZDZISzcvQUdZZmRqTmdzTXNzWU1UNWZ2?=
 =?utf-8?B?MkxrU2lvU2hXNUdTSCs5WFMycGo1ZDNMUmZ3eUdudkJMUUxxdWJsVVZRYlBa?=
 =?utf-8?B?RWhqUnpHM3RUNGN4bm1ERU5tN2p1cWFjV2V6Y3lwRks0UExEdE4wVmhRZHJN?=
 =?utf-8?B?MEt4b3NxSzVUd3NLWTJ1a2FYWnVOemxiQmhwQlM5T3Q4MDRJU2Y5QzA1M3FT?=
 =?utf-8?B?RkRXYUw3RWtkb0FPdEI0WnB2ZzlaUUxVUUJkQm9yaWRNNUlhRkREbm5KZ2pV?=
 =?utf-8?B?OGhwMEVWeGFFeVJTSEpkVVFyQmNKYUhkY0Vrc0ZlRGdyeXRSNzBSV3V5c21E?=
 =?utf-8?B?bUx0Qi8wZGo5L1hzWXE1TlpLME94MWZlUDh2aWtrbDB4T1pxc1RqbGRLUXJo?=
 =?utf-8?B?UUR6SW1pamRUckl0NUYybktjN0tZMjhvRElQNzk3c3F3SCtUZUtQYWJXalIx?=
 =?utf-8?B?aTNmbmpuYmcvWjZxdDl1UWJXWG04VHJvVXViWGFFeWVHcldGY1BLRC9JOWR3?=
 =?utf-8?B?WTdsV3B5N0ZweGhYeUdvcXhFOVpyR3l2d0h0T0FHQi9mNUwyd0VxS1QxQWVP?=
 =?utf-8?B?SGxvdk9LY1dneTk5N2ZaYUJBS0xEb0J1WFhhcGZmVjJiMUkrSE5IOG03a3hZ?=
 =?utf-8?B?VnBZMHJ0RVQ3YXBuaWJ3dHQxd1dCenFUbHdTUlVIVDRCdHAxbGhuSGhHbGZS?=
 =?utf-8?B?OUlkWjJpaUdobG0xZUJvb0lsQzhXcjFZOEZPV0NHajZRanFMSFFkWVdlQmFD?=
 =?utf-8?B?NUdXZUNsR2IzZ1ZkQzUwejBqTHpNZTloZ3A3R2Q4TDkyMTJEWkUvUDNFcjhF?=
 =?utf-8?B?dHdVNUZ2TDVjRm9WUTQwd2Ywc0Ric1hOQjlXZzNFcmNMZ1Zoc2NHQWNqdmpW?=
 =?utf-8?B?Y05oUlRJWEYrRDFMdm5tSW40UlJFU29XaUNOWnlFaTFJeE9tU2M3SVpXYjFI?=
 =?utf-8?B?eGJBVk5Sc0VJTkthTEZvRmpPd2VEd1JBN1RIa0J2ZGYxWmIzbjRSZWZSZUVQ?=
 =?utf-8?B?a2c0VmRzUlJyWEtLSkdHaTNoZjk5QVlkRmYyUnR1RE9MLytCcWJOWDhEN0xl?=
 =?utf-8?B?WlkzYmh1VzRiT3VubnJUdXA0UXRJbHpadXp4M1VZYmFqRXJ5cmMvRmRFdkR4?=
 =?utf-8?B?UjFDTjVOS3EvSng4bnpHOE1IZGJOQXhPMHBMTnJ2d2doa1ZveVR4NUZzMHA5?=
 =?utf-8?B?NXpYWWNyejh3M2huU0xQS3lrbU4xYW1mMmdJU0JGT3pPeVh0cUlOWGZweWxi?=
 =?utf-8?Q?/Yhs23vqF59r8nqoBPnWgwRtV?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c96343d7-a42c-41a5-65c2-08dcf789b1a6
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 19:49:54.3824
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pUa72jUAbFqvs10VOvzmCxmHariQZn+De+vyNmZN0YC4LqyfQHDxgiWKoU128LNutZml7ERU8jjbo9Oa+/KpYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9332

The ESAI of i.MX8QM is the same as i.MX6ULL. So add fsl,imx6ull-esai for
esai.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8-ss-audio.dtsi   | 2 +-
 arch/arm64/boot/dts/freescale/imx8qm-ss-audio.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-audio.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-audio.dtsi
index ff5df0fed9e96..739be5273c51f 100644
--- a/arch/arm64/boot/dts/freescale/imx8-ss-audio.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-audio.dtsi
@@ -165,7 +165,7 @@ asrc0: asrc@59000000 {
 	};
 
 	esai0: esai@59010000 {
-		compatible = "fsl,imx8qm-esai";
+		compatible = "fsl,imx8qm-esai", "fsl,imx6ull-esai";
 		reg = <0x59010000 0x10000>;
 		interrupts = <GIC_SPI 409 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&esai0_lpcg IMX_LPCG_CLK_4>,
diff --git a/arch/arm64/boot/dts/freescale/imx8qm-ss-audio.dtsi b/arch/arm64/boot/dts/freescale/imx8qm-ss-audio.dtsi
index e24e639b98ee7..c9b55f02497ab 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm-ss-audio.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qm-ss-audio.dtsi
@@ -134,7 +134,7 @@ sai5_lpcg: clock-controller@59490000 {
 	};
 
 	esai1: esai@59810000 {
-		compatible = "fsl,imx8qm-esai";
+		compatible = "fsl,imx8qm-esai", "fsl,imx6ull-esai";
 		reg = <0x59810000 0x10000>;
 		interrupts = <GIC_SPI 411 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&esai1_lpcg IMX_LPCG_CLK_0>,

-- 
2.34.1



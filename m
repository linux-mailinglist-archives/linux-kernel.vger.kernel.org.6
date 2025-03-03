Return-Path: <linux-kernel+bounces-540908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9F5AA4B653
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 03:55:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A84D3AD41F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 02:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF4F31C5D4B;
	Mon,  3 Mar 2025 02:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="CD0/hRcj"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2072.outbound.protection.outlook.com [40.107.21.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6634A1DA31D;
	Mon,  3 Mar 2025 02:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740970483; cv=fail; b=ul66ovOff1chL5s0nae9G25IniGBSeyv7uZmnO9jv0A438KCWpHY1urKlvdMdZCqv2uzUgWohqpzYJrI6HUIERZSoAtYhOVyJck0CFzq5NiCPc+/fMny1Dl5W8oYOmne7GEsMqcCo2OthVoTDlFcklt1YCWHezwNyp1RM/VM96k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740970483; c=relaxed/simple;
	bh=KlB2r0Yg8B/2G0URaahBMjIf7vfb65DpWW0Ywkn7vdk=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=JH0JAuZj2gDnmnLYXwlgqC4ttrm0Fj7KncoMxIoxUPK4nHQGAskIF3PZYGvUuKoXxXXrRhLTLxR6NWELCfptYflhbTRVeIDTnANjssACOrp73ibc525XjaPBjExuhW8BLbAvO6yJZ96xRDtTt2d7z5/EbEt6/Fxabn5ttJWCMg0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=CD0/hRcj; arc=fail smtp.client-ip=40.107.21.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wOAZq4fFmxR8qZbJJ6hMuXuJvoLShYidyORr33dyoLyikcMG7sCJRwOAMbyvenvvujdqMxZ/x+1T7k51BP9I6QHwauvv89b5znZ/0r7uZGjVaSDCsh71YRMYY3nkwztQ42PTgJjhkMdGiH60Zpe8BWgSB3j+zFXJEuXy5dhYSNpPx1uYOyrR1C91n6uEL6Ap6jooqW4W9PoNDAXXdMP49QvsiWe1CXTwojNR+yAkhVJqK6w+Mb3/0Pxtv3+wu40YNTmWpAJxrCIP3SWYX8KPvoRKPe20X5yCEkiWOV+SZgtQoczrIabpdhsfWNApFT4sQTejFyNzZUKLMPqDvY/Pfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RTJU2LSZH/a4Snc0eHG9ppB4nXWE3SaBO4x0PidCjuM=;
 b=hDq9a3mZk8eI0vEFw15A0ZTCZBYy5Xndm3rmTokNVInnAbtgGGXbUefDf0X3hUdoQXviXi8iWsDbG+r6GMkyW2TjC8rxLs81hHT/hdtyN/T9QB35rZelQZTT+u0XcwmshaekZZut3k/kZ8VSw0U1dyxuhZN5WP8zfpx095MOz5ssXKE68Qmi0/IdRBNlWI2p+F1ptsz91LBu7OKc1h0WyFiJbId35dCcYg97RyW64QwEsYCQ4ilWdqHTVcojHhPmDi5VaRUXConiRknse9FxBaCpLmxmM5xBIyIz919AiHq2mOMCafGK3ppm2NCTqpf7T0hVMkIMhFLo00m28uJgiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RTJU2LSZH/a4Snc0eHG9ppB4nXWE3SaBO4x0PidCjuM=;
 b=CD0/hRcjjLTmZvaPfk4986lCyyqdEge+KUSTGcwGz1MO6T/wXGDXQy/Ry2ezMnN08fz2yDJkZrTX08giBJG2m98AwDxA1Swh9DBBptVUlZ6eYxIL2BVHDPemHtP6JkK94T2/IVlO/W/Kvgo+kqLF2OXn1Earx/o9Nlx+6RvF1GHEP6zcNjcR7TysTfEFbhJLYyy/ajAwNRkFNEXnxVTxdZabtPgysE0rXuaeUIEzqZJ06aaQ3NpwWBwkRhGbdNvvEEbzazfToRCmHegknCQEMpiAnSpCd5Nmr1OeyErRG5eDRIgMprAQbQFQuHr/gmRzbJe2KKdWF0tSW5IDh3AG5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM9PR04MB8308.eurprd04.prod.outlook.com (2603:10a6:20b:3e3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.27; Mon, 3 Mar
 2025 02:54:38 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 02:54:38 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Mon, 03 Mar 2025 10:53:24 +0800
Subject: [PATCH v3 3/7] firmware: arm_scmi: imx: Add i.MX95 LMM protocol
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250303-imx-lmm-cpu-v3-3-7695f6f61cfc@nxp.com>
References: <20250303-imx-lmm-cpu-v3-0-7695f6f61cfc@nxp.com>
In-Reply-To: <20250303-imx-lmm-cpu-v3-0-7695f6f61cfc@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740970413; l=10476;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=BzUid/SowDeLCOlaJZfYyf1Brti466FL1p93GAdRZFU=;
 b=71fARmeF3lfszi+2r0wtbz110lGXvzO/mnymMzZA/X6xexA2wNn/6IWIq8zKubdQEhgA7dKxE
 aqAh5dOKeD4CkyTDbcgcw7NNQcQK+6H5gsZq6k0OeRUwrjmwp4iUJyf
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AM9PR04MB8308:EE_
X-MS-Office365-Filtering-Correlation-Id: c6ee3c24-9079-4a01-aa93-08dd59febce5
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bXNqTFRIYU9oVURQMTFMZmNVd2hoT2RiTmlRU3hTcHEzcmNZZVpscFhXTGcz?=
 =?utf-8?B?NFhhNmJzZ0lFc0M0SUt1U2MrZDZxbmJQRkh4eVFnSWZMMFExZkpJTWVuODZi?=
 =?utf-8?B?Nnp5ZEtzT2RnRWd6b3MwY01kdk15SG91UmoxZGF3eG9scnZrV3JueVpzcmVC?=
 =?utf-8?B?cyszcHp3RkNvdHpaZUVEUnc5aWR5MnJpeXplRVY1c2R1OFFtSVYzVlRra2ts?=
 =?utf-8?B?QVVYWitnSXA3WHEzZFA0Y2dod3lRTklMNlJDRTA2czZ2RzNFN3VGbldsaHlO?=
 =?utf-8?B?eG51WHBLZ1RxK0NGNW16cmx4aEovcm9mbkZ1T25IZk1xSFBTdHBiZFFZcWNl?=
 =?utf-8?B?cldKT01WTTQ1WGZ0VStIMDhTcXA0RGlDcE1DT0UrZmtyUmhtamVGWW13UGEw?=
 =?utf-8?B?Q21ScVZhL2puOHdmejlxZnA5SDZvL0JURlFBaFVrSkNHZU94RTRFak00RWEx?=
 =?utf-8?B?bEhNaGkzRDd6QlRKckgzQ21vUFBkcSt3eTU1ZlhZRWZaZmFHU2V4ekwxR2JZ?=
 =?utf-8?B?VHh5UDZFQWhRWFVlZFViSkpyTDRPVmJkK1grYmE2c1dtdWx6V2k1Mlhpd2FR?=
 =?utf-8?B?ZEpYU2F5MUVjUzhEaWdaUnNDVGp1SGtsNjV4M2JlZUNKK1lyb0xCRkYyWGpj?=
 =?utf-8?B?Rkt4WG5PYWIxZTBSYkk5UTVOdHdTU0lWSU5lbHNEcHY2eEFLMGt3ZmlHbVY4?=
 =?utf-8?B?enRwcG5OZXhCMk9zOTdoT25ZQ2MydExRaEhXZmNjYmlXc0szcFFLVEFhazZl?=
 =?utf-8?B?R0hWUExOMFFOemJWdFBaWi9ha3hJcnc3WGFtelQyeGt2Smo4N0xlaXBRdXNh?=
 =?utf-8?B?NjRqUlNxMHNGWkZNQndEazQrTXhjQ1dtMkx0Z3B5cE9VTUhMeC9mMzgwdVpv?=
 =?utf-8?B?QmxRc0ZKdStWOXEzek91b1FSMU12cmpxZktGNjliZ0lZazhFbjRmUVorUzN4?=
 =?utf-8?B?eVA3MzloaVp5eVBRMDd4Z2c3WEQzaFBnU001dTJpODZkSzl5N1l4T3EraW9L?=
 =?utf-8?B?cWkxTGFSWE45TVdYUVEzSm8rZjJmYXlHVVJLQXE1RWNFMVhaTTFVNTFHeGsr?=
 =?utf-8?B?Y0hOeEFvODh4eWJzSXEyb2hFM2xZWlVHOWpIRzVDU3Bob1FzNk9tVFJIQlZB?=
 =?utf-8?B?amdSK3lUOWhScUIrbE5ibGhUUWhtTUxFZWpaUCtqdjhqS2gyN3BRMVorcXlE?=
 =?utf-8?B?Wkp0N1dTV0k1ZkNJczg4ZDhnTmJ4YnB1QzJjN0pOWDQ4dGQySGN2ZHZXc0tL?=
 =?utf-8?B?OFFheWtXSTBkOVViM0FkZGZKanhQUnZFaEt1aXJZQTRwOG5XbXJ1NjU2Y3g4?=
 =?utf-8?B?ZHlSV0lwU3dEekdlU1grQ3hTWXJRN09lVllSdjZlUWtQOXR5WE1wUS9JSkxa?=
 =?utf-8?B?TER3ZG9oeFQxWjFmMmlTY200WFpKa09DY1cxN3NOYVJmZ2NuVStiSS9zRTU4?=
 =?utf-8?B?VWdKOUxEQWI4VGVIZkdnUmpMZHArdG9GQS90ZkowaTdnNzNvbGp6SHF6SFdr?=
 =?utf-8?B?K1B0VXhQelc0bUd2cEZYWjZKcDFaMHNaM1VUbWpsWkg2R1o2cmE5cHBLaHlO?=
 =?utf-8?B?ZFlNb2QwbzVQZnNIdnVyWkJyTU1KTFhnOEphc1BGekpCK0hmVDlMVmpHSktB?=
 =?utf-8?B?S1oyUThpY2FtbkVqdWo4M1N0Zm92TXYzSUdKUERmR3Z1cWJXY0I3MTVaSGxk?=
 =?utf-8?B?U0xlNklYWEpoQWV1Z0RYNzZzV1ppenpQalZPbldVVmFNNGRkWXFzOWVDbFlH?=
 =?utf-8?B?U2YrbitYa1RJMWduREEydjU1M2NTSHhLemcvK1c2VjZ6QStoSDZhR3gvR0RY?=
 =?utf-8?B?RHdzYnJtUWRsRmR4STJvYXhwUTZVRVdmRmJiRTRIbmdhMDBoajZSTHVneisr?=
 =?utf-8?B?eEZwNk5UejAwekRRSU9YeER4bDVySU9pOWs0THMvVmN6a3FtdU4xZmltU1FS?=
 =?utf-8?Q?ROFNbCuE05ewIkHUWIdZPV4TkBLFssJz?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UURXdGFodXZYSXZ2NWhBMDNaMEhoazc2SFVFeG55ZnVkaHE2emhVSHd3dWgy?=
 =?utf-8?B?bVorMkg3VS9KUHI0VXFQMVg2QUg4ckkwdDk0aFBDUURjdHVSMlpoMC9rZlBu?=
 =?utf-8?B?MG53SnhndXAyT3R1VEhTbnVZcm1OOHVrSzNuMERsR2JkalVQOTkzYVdaNlcr?=
 =?utf-8?B?UkJZcDdNYndKYS9zUVpaT0VxY21CY0pBL0J3SEx1THBaN0REVnVaNnFhSHp0?=
 =?utf-8?B?bitkbDFXY1YxbW5aQ0xjYVBEaktrTTNWaCtlMElSWkhhYnVFeVFXVEd4R2pH?=
 =?utf-8?B?OUJXak1yUFl3ZXZTTnFiUlhLbXZBd3lQdkI5eHdnQmlwMlhhOE9DQm1oOURi?=
 =?utf-8?B?SlpvL1JBMzFuUG41YkdkbTN1a296TlQ5R2lGQmNyaVdxMGJnK3dtZ21iQjVo?=
 =?utf-8?B?R1E2VmxQbW5qM2FON2ZUdGlqaWRyL0xKTGF3NnNHYld0SGxjOWNCN3pUNlRz?=
 =?utf-8?B?QWJxRjJadEtPZTZweGhJNTJQYmwzRWozc3ErbkM1bDdWTnp2RjNPTFJOYm0z?=
 =?utf-8?B?Zk95UWU0aVd5OFNua1NEbjZSVHV2YmZ4L25hdlRjWWQ3WVdyalhlclhRVXVO?=
 =?utf-8?B?c0N1SDNDMFdVMTdJWVF3TjlYdUEzaTFFRk9pMVNhUFFMaVZHSklYOHlycVJm?=
 =?utf-8?B?VkU4czIzcmR5QWE4ckFHNU5meFdLU21kZllqYUhVMDZuUTI0UGNxYkpQNnUx?=
 =?utf-8?B?d1BRSUVNbFhSVTA2N1dqa1E5RStsclJFZE1qRWNLQTFIRkJ1Y2JjRndFMzhk?=
 =?utf-8?B?ck1CSU1yQW5aaUk3M21nRUtJSUEzZUw3dVk4M2JUWWZSOVUzQ1h3c2MzSWZy?=
 =?utf-8?B?Y2VWcmNMMjhacFFSR1lvZUh6bE1YREJOVSt5MEZFYkFjR0VvVVZBNEdxMis5?=
 =?utf-8?B?MVNNR013TUk4VWRJdjhqUHlsM1B1b0NSMmVmR0UwSVdTRzkvSnRsaFBQWVpl?=
 =?utf-8?B?WTJKYUdXM2NvckFQY3BqME9Ra0JhK3piTU1XWmJqOWhNczJJYkVWVnFqY3B2?=
 =?utf-8?B?TUM0VENzdmdNZFM2WlFKdzBqSjVVMkw4VDR5Mm1rRWY2TlMvdWdrT1g2WWJh?=
 =?utf-8?B?eExZM3RYeFNWR2lwU3Aza3pmQ2NDdzRlbzIzQ2ZIU1pVb1Fxd3Y3M2FrMCtE?=
 =?utf-8?B?blpZUHAxSDcvWm5CdGd1NkgxUFZIUDhvcER3TENtK1lTMEZ4alJNQ1dYcytT?=
 =?utf-8?B?eTBNcldJenB4ZFI0dnA4cXdmUmNpRUJYZkFxMXIweWw4cy84WEdLTkpHS0d4?=
 =?utf-8?B?cFJHVGZwZEZ4OGpvUGZ1UTFsbmxIcEpiOSs5Ym9TS2xNelVlVFduS3NuTHdB?=
 =?utf-8?B?akIrTTJLRGhvSFZVeTRzcWZQQnNGNEhKc0JHbVlwWS9VYkhxaVVZUkFLdHox?=
 =?utf-8?B?WUJ1dnB3ZFFYRW40L25ZVUxNT1dJZ1hZK1dVQzV4VmQxQzAyaEFId2gzVVI1?=
 =?utf-8?B?YlMxTkJCMmZCTCtQZ043T2RnZDl6U084T0FUblRLOVc2NzlkYXYwYWxNRnZ2?=
 =?utf-8?B?azdpbzlNSUx0Zi9iZVdEa0YxbUNaUjEzL1drcUhWWjM2MWJtV0R1N0RvZVJ6?=
 =?utf-8?B?Rk5qN0EvL0ZMSjBQTFZ5NytSd2ZkVnFrcm5aUGNXdWFCMENKcVpWZzVoZXBs?=
 =?utf-8?B?UDZkN0pnc0QxNWk0L3dWeEcxT0xMRjV0UU9KdFNHQUE5QWt2WVUyR2VLMjBa?=
 =?utf-8?B?VDN3bUNmK2dlRXY5aG1qQ21OQi9pVm9TZmlPbm1pL0F6RmFrZVl6RUZXdFZ1?=
 =?utf-8?B?aW1ETzJ2MjZORWl4bTFJN1JDV3p3OEE3VmN1ekxkSTV5SktNRkNLVHB2TG9Y?=
 =?utf-8?B?RndZT2ViSjFlQXVsMkFZaDZpZXI0MzlGN0dZN1JZWVF4dG1zaFJaQUNUbWJF?=
 =?utf-8?B?QTJBUm5ab0I2bHhSZXVmaExtSEpGcC84alNQU1dpU3lEM0dDUGJHcUw0Mngr?=
 =?utf-8?B?UHZBWkYxMjlQY0VPcWMrcG9ySnN1b3VTd2ZkWUhFZ0JHZnkrd0dtblgvc1Vn?=
 =?utf-8?B?M3pKbUExblBoUkxkaUlWWkp0cU1wL1pUajNWNHc1MEw2blBWbHlyc2JwTkdC?=
 =?utf-8?B?U2lzNzhFc2d6WXBXaWdhTWdPbGxhaWpjY09WT1NpSUR6Z0s3MEZycFhJdjZF?=
 =?utf-8?Q?l+1Odo+24DXkA4XsXvH8C6ywg?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6ee3c24-9079-4a01-aa93-08dd59febce5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 02:54:38.3273
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aEvYMAE9WEvvzjYoncCXIcMG+4+hJtyQz0nlFv2kvB+s7B9KsGfXIKUkvNvuhAonJg/8v/Tt7WeroZ/E91ck0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8308

From: Peng Fan <peng.fan@nxp.com>

Add Logical Machine Management(LMM) protocol which is intended for boot,
shutdown, and reset of other logical machines (LM). It is usually used to
allow one LM to manager another used as an offload or accelerator engine.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/firmware/arm_scmi/vendors/imx/Kconfig      |  11 +
 drivers/firmware/arm_scmi/vendors/imx/Makefile     |   1 +
 drivers/firmware/arm_scmi/vendors/imx/imx-sm-lmm.c | 257 +++++++++++++++++++++
 include/linux/scmi_imx_protocol.h                  |  32 +++
 4 files changed, 301 insertions(+)

diff --git a/drivers/firmware/arm_scmi/vendors/imx/Kconfig b/drivers/firmware/arm_scmi/vendors/imx/Kconfig
index a01bf5e47301d2f93c9bfc7eebc77e083ea4ed75..1a936fc87d2350e2a21bccd45dfbeebfa3b90286 100644
--- a/drivers/firmware/arm_scmi/vendors/imx/Kconfig
+++ b/drivers/firmware/arm_scmi/vendors/imx/Kconfig
@@ -12,6 +12,17 @@ config IMX_SCMI_BBM_EXT
 	  To compile this driver as a module, choose M here: the
 	  module will be called imx-sm-bbm.
 
+config IMX_SCMI_LMM_EXT
+	tristate "i.MX SCMI LMM EXTENSION"
+	depends on ARM_SCMI_PROTOCOL || (COMPILE_TEST && OF)
+	default y if ARCH_MXC
+	help
+	  This enables i.MX System Logical Machine Protocol to
+	  manage Logical Machines boot, shutdown and etc.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called imx-sm-lmm.
+
 config IMX_SCMI_MISC_EXT
 	tristate "i.MX SCMI MISC EXTENSION"
 	depends on ARM_SCMI_PROTOCOL || (COMPILE_TEST && OF)
diff --git a/drivers/firmware/arm_scmi/vendors/imx/Makefile b/drivers/firmware/arm_scmi/vendors/imx/Makefile
index d3ee6d5449244a4f5cdf6abcf1845f312c512325..f39a99ccaf9af757475e8b112d224669444d7ddc 100644
--- a/drivers/firmware/arm_scmi/vendors/imx/Makefile
+++ b/drivers/firmware/arm_scmi/vendors/imx/Makefile
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-$(CONFIG_IMX_SCMI_BBM_EXT) += imx-sm-bbm.o
+obj-$(CONFIG_IMX_SCMI_LMM_EXT) += imx-sm-lmm.o
 obj-$(CONFIG_IMX_SCMI_MISC_EXT) += imx-sm-misc.o
diff --git a/drivers/firmware/arm_scmi/vendors/imx/imx-sm-lmm.c b/drivers/firmware/arm_scmi/vendors/imx/imx-sm-lmm.c
new file mode 100644
index 0000000000000000000000000000000000000000..b56a566fb96ee72c025096c025847f4e9d0fefe9
--- /dev/null
+++ b/drivers/firmware/arm_scmi/vendors/imx/imx-sm-lmm.c
@@ -0,0 +1,257 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * System control and Management Interface (SCMI) NXP LMM Protocol
+ *
+ * Copyright 2025 NXP
+ */
+
+#include <linux/bits.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/scmi_protocol.h>
+#include <linux/scmi_imx_protocol.h>
+
+#include "../../protocols.h"
+#include "../../notify.h"
+
+#define SCMI_PROTOCOL_SUPPORTED_VERSION		0x10000
+
+enum scmi_imx_lmm_protocol_cmd {
+	SCMI_IMX_LMM_ATTRIBUTES	= 0x3,
+	SCMI_IMX_LMM_BOOT = 0x4,
+	SCMI_IMX_LMM_RESET = 0x5,
+	SCMI_IMX_LMM_SHUTDOWN = 0x6,
+	SCMI_IMX_LMM_WAKE = 0x7,
+	SCMI_IMX_LMM_SUSPEND = 0x8,
+	SCMI_IMX_LMM_NOTIFY = 0x9,
+	SCMI_IMX_LMM_RESET_REASON = 0xA,
+	SCMI_IMX_LMM_POWER_ON = 0xB,
+	SCMI_IMX_LMM_RESET_VECTOR_SET = 0xC,
+};
+
+struct scmi_imx_lmm_priv {
+	u32 nr_lmm;
+};
+
+#define SCMI_IMX_LMM_NR_LM_MASK	GENMASK(7, 0)
+struct scmi_msg_imx_lmm_protocol_attributes {
+	__le32 attributes;
+};
+
+struct scmi_msg_imx_lmm_attributes_out {
+	__le32 lmid;
+	__le32 attributes;
+	__le32 state;
+	__le32 errstatus;
+	u8 name[LMM_MAX_NAME];
+};
+
+struct scmi_imx_lmm_reset_vector_set_in {
+	__le32 lmid;
+	__le32 cpuid;
+	__le32 flags; /* reserved for future extension */
+	__le32 resetvectorlow;
+	__le32 resetvectorhigh;
+};
+
+struct scmi_imx_lmm_shutdown_in {
+	__le32 lmid;
+#define SCMI_IMX_LMM_SHUTDOWN_GRACEFUL	BIT(0)
+	__le32 flags;
+};
+
+static int scmi_imx_lmm_validate_lmid(const struct scmi_protocol_handle *ph, u32 lmid)
+{
+	struct scmi_imx_lmm_priv *priv = ph->get_priv(ph);
+
+	if (lmid >= priv->nr_lmm)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int scmi_imx_lmm_attributes(const struct scmi_protocol_handle *ph,
+				   u32 lmid, struct scmi_imx_lmm_info *info)
+{
+	struct scmi_msg_imx_lmm_attributes_out *out;
+	struct scmi_xfer *t;
+	int ret;
+
+	ret = ph->xops->xfer_get_init(ph, SCMI_IMX_LMM_ATTRIBUTES, sizeof(u32), 0, &t);
+	if (ret)
+		return ret;
+
+	put_unaligned_le32(lmid, t->tx.buf);
+	ret = ph->xops->do_xfer(ph, t);
+	if (!ret) {
+		out = t->rx.buf;
+		info->lmid = le32_to_cpu(out->lmid);
+		info->state = le32_to_cpu(out->state);
+		info->errstatus = le32_to_cpu(out->errstatus);
+		strscpy(info->name, out->name);
+		dev_dbg(ph->dev, "i.MX LMM: Logical Machine(%d), name: %s\n",
+			info->lmid, out->name);
+	} else {
+		dev_err(ph->dev, "i.MX LMM: Failed to get info of Logical Machine(%u)\n", lmid);
+	}
+
+	ph->xops->xfer_put(ph, t);
+
+	return ret;
+}
+
+static int
+scmi_imx_lmm_power_boot(const struct scmi_protocol_handle *ph, u32 lmid, bool boot)
+{
+	struct scmi_xfer *t;
+	u8 msg_id;
+	int ret;
+
+	ret = scmi_imx_lmm_validate_lmid(ph, lmid);
+	if (ret)
+		return ret;
+
+	if (boot)
+		msg_id = SCMI_IMX_LMM_BOOT;
+	else
+		msg_id = SCMI_IMX_LMM_POWER_ON;
+
+	ret = ph->xops->xfer_get_init(ph, msg_id, sizeof(u32), 0, &t);
+	if (ret)
+		return ret;
+
+	put_unaligned_le32(lmid, t->tx.buf);
+	ret = ph->xops->do_xfer(ph, t);
+
+	ph->xops->xfer_put(ph, t);
+
+	return ret;
+}
+
+static int scmi_imx_lmm_reset_vector_set(const struct scmi_protocol_handle *ph,
+					 u32 lmid, u32 cpuid, u32 flags, u64 vector)
+{
+	struct scmi_imx_lmm_reset_vector_set_in *in;
+	struct scmi_xfer *t;
+	int ret;
+
+	ret = ph->xops->xfer_get_init(ph, SCMI_IMX_LMM_RESET_VECTOR_SET, sizeof(*in),
+				      0, &t);
+	if (ret)
+		return ret;
+
+	in = t->tx.buf;
+	in->lmid = cpu_to_le32(lmid);
+	in->cpuid = cpu_to_le32(cpuid);
+	in->flags = cpu_to_le32(0);
+	in->resetvectorlow = cpu_to_le32(lower_32_bits(vector));
+	in->resetvectorhigh = cpu_to_le32(upper_32_bits(vector));
+	ret = ph->xops->do_xfer(ph, t);
+
+	ph->xops->xfer_put(ph, t);
+
+	return ret;
+}
+
+static int scmi_imx_lmm_shutdown(const struct scmi_protocol_handle *ph, u32 lmid,
+				 u32 flags)
+{
+	struct scmi_imx_lmm_shutdown_in *in;
+	struct scmi_xfer *t;
+	int ret;
+
+	ret = scmi_imx_lmm_validate_lmid(ph, lmid);
+	if (ret)
+		return ret;
+
+	ret = ph->xops->xfer_get_init(ph, SCMI_IMX_LMM_SHUTDOWN, sizeof(*in),
+				      0, &t);
+	if (ret)
+		return ret;
+
+	in = t->tx.buf;
+	in->lmid = cpu_to_le32(lmid);
+	if (flags & SCMI_IMX_LMM_SHUTDOWN_GRACEFUL)
+		in->flags = cpu_to_le32(SCMI_IMX_LMM_SHUTDOWN_GRACEFUL);
+	else
+		in->flags = cpu_to_le32(0);
+	ret = ph->xops->do_xfer(ph, t);
+
+	ph->xops->xfer_put(ph, t);
+
+	return ret;
+}
+
+static const struct scmi_imx_lmm_proto_ops scmi_imx_lmm_proto_ops = {
+	.lmm_power_boot = scmi_imx_lmm_power_boot,
+	.lmm_info = scmi_imx_lmm_attributes,
+	.lmm_reset_vector_set = scmi_imx_lmm_reset_vector_set,
+	.lmm_shutdown = scmi_imx_lmm_shutdown,
+};
+
+static int scmi_imx_lmm_protocol_attributes_get(const struct scmi_protocol_handle *ph,
+						struct scmi_imx_lmm_priv *priv)
+{
+	struct scmi_msg_imx_lmm_protocol_attributes *attr;
+	struct scmi_xfer *t;
+	int ret;
+
+	ret = ph->xops->xfer_get_init(ph, PROTOCOL_ATTRIBUTES, 0,
+				      sizeof(*attr), &t);
+	if (ret)
+		return ret;
+
+	attr = t->rx.buf;
+
+	ret = ph->xops->do_xfer(ph, t);
+	if (!ret) {
+		priv->nr_lmm = le32_get_bits(attr->attributes, SCMI_IMX_LMM_NR_LM_MASK);
+		dev_info(ph->dev, "i.MX LMM: %d Logical Machines\n",
+			 priv->nr_lmm);
+	}
+
+	ph->xops->xfer_put(ph, t);
+
+	return ret;
+}
+
+static int scmi_imx_lmm_protocol_init(const struct scmi_protocol_handle *ph)
+{
+	struct scmi_imx_lmm_priv *info;
+	u32 version;
+	int ret;
+
+	ret = ph->xops->version_get(ph, &version);
+	if (ret)
+		return ret;
+
+	dev_info(ph->dev, "NXP SM LMM Version %d.%d\n",
+		 PROTOCOL_REV_MAJOR(version), PROTOCOL_REV_MINOR(version));
+
+	info = devm_kzalloc(ph->dev, sizeof(*info), GFP_KERNEL);
+	if (!info)
+		return -ENOMEM;
+
+	ret = scmi_imx_lmm_protocol_attributes_get(ph, info);
+	if (ret)
+		return ret;
+
+	return ph->set_priv(ph, info, version);
+}
+
+static const struct scmi_protocol scmi_imx_lmm = {
+	.id = SCMI_PROTOCOL_IMX_LMM,
+	.owner = THIS_MODULE,
+	.instance_init = &scmi_imx_lmm_protocol_init,
+	.ops = &scmi_imx_lmm_proto_ops,
+	.supported_version = SCMI_PROTOCOL_SUPPORTED_VERSION,
+	.vendor_id = SCMI_IMX_VENDOR,
+	.sub_vendor_id = SCMI_IMX_SUBVENDOR,
+};
+module_scmi_protocol(scmi_imx_lmm);
+
+MODULE_ALIAS("scmi-protocol-" __stringify(SCMI_PROTOCOL_IMX_LMM) "-" SCMI_IMX_VENDOR);
+MODULE_DESCRIPTION("i.MX SCMI LMM driver");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/scmi_imx_protocol.h b/include/linux/scmi_imx_protocol.h
index 53b356a26414279f4aaaa8287c32209ed1ad57b4..2a96fc29cb6f4dd1e4c29e0aaaa614ae9783da4a 100644
--- a/include/linux/scmi_imx_protocol.h
+++ b/include/linux/scmi_imx_protocol.h
@@ -11,8 +11,10 @@
 #include <linux/bitfield.h>
 #include <linux/device.h>
 #include <linux/notifier.h>
+#include <linux/scmi_protocol.h>
 #include <linux/types.h>
 
+#define SCMI_PROTOCOL_IMX_LMM	0x80
 #define	SCMI_PROTOCOL_IMX_BBM	0x81
 #define	SCMI_PROTOCOL_IMX_MISC	0x84
 
@@ -57,4 +59,34 @@ struct scmi_imx_misc_proto_ops {
 	int (*misc_ctrl_req_notify)(const struct scmi_protocol_handle *ph,
 				    u32 ctrl_id, u32 evt_id, u32 flags);
 };
+
+/* See LMM_ATTRIBUTES in imx95.rst */
+#define	LMM_ID_DISCOVER	0xFFFFFFFFU
+#define	LMM_MAX_NAME	16
+
+enum scmi_imx_lmm_state {
+	LMM_STATE_LM_OFF,
+	LMM_STATE_LM_ON,
+	LMM_STATE_LM_SUSPEND,
+	LMM_STATE_LM_POWERED,
+};
+
+struct scmi_imx_lmm_info {
+	u32 lmid;
+	enum scmi_imx_lmm_state state;
+	u32 errstatus;
+	u8 name[LMM_MAX_NAME];
+};
+
+struct scmi_imx_lmm_proto_ops {
+	int (*lmm_power_boot)(const struct scmi_protocol_handle *ph, u32 lmid,
+			      bool boot);
+	int (*lmm_info)(const struct scmi_protocol_handle *ph, u32 lmid,
+			struct scmi_imx_lmm_info *info);
+	int (*lmm_reset_vector_set)(const struct scmi_protocol_handle *ph,
+				    u32 lmid, u32 cpuid, u32 flags, u64 vector);
+	int (*lmm_shutdown)(const struct scmi_protocol_handle *ph, u32 lmid,
+			    u32 flags);
+};
+
 #endif

-- 
2.37.1



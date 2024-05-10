Return-Path: <linux-kernel+bounces-175501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 881C58C207B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 11:14:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D3C4282665
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 09:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A4DF170844;
	Fri, 10 May 2024 09:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="T4Hj+GTR"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2074.outbound.protection.outlook.com [40.107.6.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7524D1649DD;
	Fri, 10 May 2024 09:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715332320; cv=fail; b=uK9VbpK/EbZ7r7AEZpGlxcIAjrrfrSNc+EJ21e+gW2aCBHrPWmbII+6PMJFxeq8i3iQ85BrRGHLFlTvskJ0By4bZckpz9AM1mkBr3x+iTj/2xHuZv6CqIiQmehxh+0k/mtqvHH82Hpv1GaoLG1i5Uh+dddCL5KI9EZdoJqsKukw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715332320; c=relaxed/simple;
	bh=tTnmH/6Qnb9N9OjP7YpZL6Z0qYEvJ4SWgZIDAnZMSPo=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=ZRts7eoh+I2WpGpDIVlVBo0Gj4jW/EkBd0vLbPjB78tA31DiA11mN6POo/cidqhMVeVlgCiATeD4gsqW9bJRW+nI4YAAuH3kDsBI1GfkNdg3vm4kNay7DqmrRTLaevGaIdisr0DB9oy9IB8Pwk3hUmM7QsOPtQo51Wwq0ZWUQbI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=T4Hj+GTR; arc=fail smtp.client-ip=40.107.6.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UN+FbZbx0j1mSOmshnjvhnedBCaTB4zT+MBt0Yrz61DjAm0EVUe34u8IpIMLvc1HzqNJtRhiqbTeVoWVgNWbx2C/CICzgiiSU3QE/kUjIJD+TNJvswSmVqc6a6VgcTcN/6rh7cgNLKPVypUJZ1J97cfDzKASj0oMnIjUJlyWu9bANeX/D8q7ci45FCtAxsfPDlLBIQ7ZCv+KHqIyZsTFKYodWEnoeA+5RKtuxCbkHWyLXwjtzHX2uxEg+eJt82bGu35S4MWJEx2TKc6r29BvEaPYXN6Nc/VN2CAQomXp3Z0zRE6rhrqc5EzCMLdioe0lLXTuILk6TX+4Rf/J8ZIUmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=shqQpCU+zit6vu8mozb5Ood+1gNMCo0go1qiqqcoK28=;
 b=e2R4iqP/fOUqtREmJVUf5EIaPnZjSP0V1CikVWgi7K6Dm6uThrSP/Fya2XyPUMvprss8cx04Ek67MCtiGLwa7nHsLAykwzjMsxAOO84ULu6Ic5jD17PsWhXWRbxSqYpVKE+s+E1hd5WHU4I6XsvYOeZLQb32PoN5CBXpCjcsbFzVIwI3CAqPyEzhK0WpDhJeDfiCED58YnTKmnNjV3lZtFZhOalsiMdMqmMa7ybdqsVF1iCPvo6A4qDy4qmQE4k4e7mPcO1I7XfFrB+WPUshvYzmc81ACary6fYDFiRA7FZS9daKjQAVgL85WNpCRnLxHbDqf/wr1WfzoGEIikJsjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=shqQpCU+zit6vu8mozb5Ood+1gNMCo0go1qiqqcoK28=;
 b=T4Hj+GTRuZN/y58gdURv3u8olNkmjss/UAfdQk/cBOZnOTuNU1K5Qmq/ufS/gU/mX1+IEH2EynjV9sPkd2Uiync/xKy71V7Kdr33JKSvaGGHbaag1NaF3OIpJK2HlpnYAVDYcR1XQbOkj8eIilM8v16V8iy3oLL1aWgWcPqzqe0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PA1PR04MB10399.eurprd04.prod.outlook.com (2603:10a6:102:452::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.47; Fri, 10 May
 2024 09:11:55 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7544.046; Fri, 10 May 2024
 09:11:55 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Fri, 10 May 2024 17:19:04 +0800
Subject: [PATCH v2 09/17] clk: imx: Remove CLK_SET_PARENT_GATE for DRAM mux
 for i.MX7D
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240510-imx-clk-v2-9-c998f315d29c@nxp.com>
References: <20240510-imx-clk-v2-0-c998f315d29c@nxp.com>
In-Reply-To: <20240510-imx-clk-v2-0-c998f315d29c@nxp.com>
To: Abel Vesa <abelvesa@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Jacky Bai <ping.bai@nxp.com>, 
 Ye Li <ye.li@nxp.com>, Dong Aisheng <aisheng.dong@nxp.com>
Cc: linux-clk@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Abel Vesa <abel.vesa@linaro.org>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715332748; l=2512;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=tawkmb4o3zsB4Mw7AonWFpkCgwbnD1LyifvXX0BKqZk=;
 b=kP5gJRE7VvRevnaIu1GoCAYVqRE47ZC5cdgIcdz9kKUTODsSbYV8uyLzOAoj+ILGMOdpbUAiY
 XjvUaRXWVVVD5MNHbMPPydZ1p1RTkdGCJM8p5ni0VDUdSYbhcfHM+eJ
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2PR02CA0008.apcprd02.prod.outlook.com
 (2603:1096:4:194::12) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PA1PR04MB10399:EE_
X-MS-Office365-Filtering-Correlation-Id: b0f7530c-883c-4a0a-0a93-08dc70d13d02
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|1800799015|52116005|7416005|366007|38350700005|921011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?djBsNGtKdHFBeDY2T0JTZWRlVXZCNDFpSFJZbTBKUlBFOXZYL2FLV3Znc1ZD?=
 =?utf-8?B?NDZ0Sjc3QWFiT1dDVWhTcDFlYWZwTjVXK0hlOVhKbWo2cDNrV2hoYmZobmpu?=
 =?utf-8?B?OEM1dEIyY29MbThqYlFJSHRQOFZRU3p4REppRVVrTWRzeU5GUXRVcURlVHJn?=
 =?utf-8?B?Z2h5Q2Q2VVQ1d1hhak5tb3JLcUlPYkl6YVNyd1Z4azB2d1M5THU2QzliK0w1?=
 =?utf-8?B?RmxndS9ySE16ZGpJU2xOM2g3WExnU3RkWWF1elkrK1FnZmxObTlSVmVXbTd3?=
 =?utf-8?B?ODdsa0J6TWZ2Y3ErdjNOWUo3MDJkd2Z0UlRESDl6N1FzTGZ5ZWNmOHFuRjlD?=
 =?utf-8?B?SkhCOSt1YU5VYkxEN0pJZVhlMEt3TFcwa2cvMVRtTUhzcEVHV3F4bUY3d0dM?=
 =?utf-8?B?TDBmeVNPSGJ4a3U3YXJSZVd5VUg2WDNpMkRKd2ZrbTcvd3A3aGVJaXRLREpS?=
 =?utf-8?B?V1BaNCtyU0hHTktPdGNnSFRiUm5sMnlxMU1nWUhoZ1lOVDQvTkhQMUw0dFJZ?=
 =?utf-8?B?eUhkZXVaL1F4YXZqejd3VkRWUzRLdDhHalhlczVOYWRFQ2ppYlUySkpJeVFW?=
 =?utf-8?B?Y1BmbE5JUm5yK21RZWtId2hyQ21JOWs5Y0R4NDJMOTdWV3JzMThUNHlIeTVP?=
 =?utf-8?B?SVpMejhZd0lVZXVzamgxOHpjVWdwNi9sQ3d1T2NhaGdBUXllSTRJT0pINFd0?=
 =?utf-8?B?NjFmOWplZWVOWDVHRzBSY0ZjQmt2THpJVll6bjR0WWl5QzA5K01tRDNoZzdB?=
 =?utf-8?B?OTEyNVcxckZ0citvczN0RW9ZNlJ6bWRJZ1J2Z3ZyeTJtbXVNTDRQZ2haZWlR?=
 =?utf-8?B?T1d2Y09ENXdNbG5pVFJETmVDdTNQamlXVDcwcFVONHBWcGUyTHVScW8ydzBk?=
 =?utf-8?B?VDJnVG5iTlRaYU5mc3RhZ1llcWpjaGZFK1o1bXgwcTZCQzBtcHhGTkpvQjh5?=
 =?utf-8?B?L2w3WkZnNmxhSXdrMGowUTlHMGRWTEp1a0lKR1o4RzAwYzZPcEdjYS8xMUMr?=
 =?utf-8?B?allMdSsyUG5VSSsySTJRUFkwSFpITEZ5by9oVGlpWE5hbzFtaC9vTjBQSzFL?=
 =?utf-8?B?MDJFTlJnTUsrUlBGd0YySGpxbnBtN0JQNzVTOGs5UEtuaFJLaHdkT2VOV2cy?=
 =?utf-8?B?UXRCQ05vNHM1bzZjaVNqaDYxNHNjNXVCWnRzWDJ0MDhwRk1BVm9hLzRMYmpr?=
 =?utf-8?B?UkEwY3lGeXp4bzRqNU85T3FwOTBTanNXNGFSMWRrZFFqcHVvTG5lcS9VV09F?=
 =?utf-8?B?QVNYbGJqbVBFcWVzUHUrR0lLMGRmR05MejkrLzRjaWdTSG5iOWRlVDkrYXRi?=
 =?utf-8?B?MGMwQU9OWlZxUkQ2S0JNcmdBUU51WC9mcEpFZHpCRU8xUjM5dzVPRUZwd0dB?=
 =?utf-8?B?QmtpRnhuL2lScnh3RFdlMHZGV3lUUW1zcVp3RlVQcHkxL0h5a0pwTVVpdHRs?=
 =?utf-8?B?bjFyVDZyRmZlVGN6WW5UMW5URVo5VFRBQndoeG5YY09HL2FBM1h6YndSbVQ3?=
 =?utf-8?B?NjljZ0ZaQmZGMTBWNk1Cc3gwOUJDbmc4SjlvYXRsL0pSdXRCZWIrMEh6MTFs?=
 =?utf-8?B?K29tdGV6akRQNXFlekJhR283RkdoUzd4dndJNDc5UFBsRTNpcW9RV2hpNVBX?=
 =?utf-8?B?a3hlOHdhVmJSQ2N1Q1ZheXRGUDJlSWljN25hTTFqaVg3eElaSlMyUXNvZ204?=
 =?utf-8?B?aFE2MjVJbHl2NkxQR1RPckhDeXNKbXlSN0sxSkdFSUN6emI0RjJKSjRXdys3?=
 =?utf-8?B?dDZpTkNUaFlCOXMwUnAyNFBTK2swbzkycmNOM09xYjZxV0JZekFVSnhhVE5h?=
 =?utf-8?Q?QfBuYr2bDhRWx7vPsDlmS5nnjmBOQybStBrLM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(52116005)(7416005)(366007)(38350700005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aDgrb1hMNGhpMWFselJLeHNFTWJwUGNTeEFiNkRaZGhlSmdUeTFUS0lDbEFw?=
 =?utf-8?B?N1hlaHhBMkhXcE1id3NnWHVQVGtvZWJvcks0MmszdWk3K01WUC91YmRWRmQx?=
 =?utf-8?B?cWZTMGI2Tk9VWC8zdTRvVm95R3pnZWk0ZWFyTGFXQ21PeS9FVldXYWcrRWIy?=
 =?utf-8?B?MGRYRmcycFhxb1FzbnZZNWRkcEpqWVBiTlIzdjZ0bzM4eHZpTWhhOHB3UXVB?=
 =?utf-8?B?UE1zbDAzRERnaGQxUzFHUXhjOTV0L1JKVXh3TXJlV3FqRzVBd2xKM3BWTWJl?=
 =?utf-8?B?TUZoam9Uckx5RlhDNmY2WHpqbE5yazQ1ZENTem04ekhPU1JPbmU1aWM2MkZU?=
 =?utf-8?B?Wk9ERWNFLzU1K3d2SUh2dTRrVG1Ed0xSMjY3MXV0a3kvbklwVjJTUi9tR3d4?=
 =?utf-8?B?OEw3ckZPQmhDbjlwalBaaVlQUlpYaGtDcnlwTkVack40OGdNNjZMdEZTSVpM?=
 =?utf-8?B?MHZYbVp6N0cvQWh6L3g5OWFhR3pSRWJGK2dCR2VSWE9NK3o3ZW54SlNpU2Rr?=
 =?utf-8?B?Z2dnbjBMeXRmcHJiRmdWUDFUUFRVZHJaTTdKaEUzUnlmOVFXSmxMRXd2Qml0?=
 =?utf-8?B?OE40RS9IZzVvYUdLbWp1Rkp1RzAyWVZ4R2dCRHNoektSVkFHTDk0Q3VyMkN5?=
 =?utf-8?B?aWtDKzU3TFlQc0JObXI4cDd5VFhvK3VEV1hYZW9wTUk1OXhoOGVVQnJ2ZStB?=
 =?utf-8?B?R29XSnEzS2txSHdSOGRoS0JRcVUwSHFyb2c3clFrN1VHdXQrQkFxOHRTRHRk?=
 =?utf-8?B?YlJuZlFTcFdmTTV5Yi9kUzA3WUhZUHM4ZTl3ZEpqQ0FWYkgzR0V4b0ludDB1?=
 =?utf-8?B?V3d6NG1RV04vT3IybXZhNzZzdGlMTDBhTVVRRldoS1hybXp6TTJvRDRYMTNX?=
 =?utf-8?B?cEZSaGlyUFNkaWNhajVnNU5manZMTkRhMzNzVFpSM1hjSUhpREhobkJsVHRG?=
 =?utf-8?B?TmZWZUpiTnBtVmZ3NjNObmZYemgvbFVhZm54bG95cnVzVWhRdFhPTDdVQ1F4?=
 =?utf-8?B?UUxCVjI5WHBnVVFBenFSYVpBamU5bEthVExTVzA2VnAwYmN2M3o5MjdBUXM5?=
 =?utf-8?B?TnE2QkxOZXhZUVp2WW5DajJWNlJsMFB3SlVDZlRLVWVDbHVpTzRBaW9abHVY?=
 =?utf-8?B?dzJKOGV3c21Cb2QxNVJsSjI2WUJtNGdRZmJaSW1UdDdvMkkvZWxyL3J1ZnpG?=
 =?utf-8?B?ZXNtc1lKY2I5ay8yTDZrOWxCSHhnd25KRUxMNkUvb1liek1tVElSa24zbnc5?=
 =?utf-8?B?dmMySXhZVnZkQ2lhVmljdjM2U05FdDZGdlBid0l0eDlCVE5UQldqUzVOY09t?=
 =?utf-8?B?UEc5WFRMQnZQWlJEWStFRHZ4d3d6QVQ1SDFQVkVxenNEK0gzelI3NklNM3J0?=
 =?utf-8?B?YUQ5OWFNL05GTzVZZ2hNTXQrU28yYzJGQWtzcDFVU3EzNndBUGlkbW90OFVx?=
 =?utf-8?B?c3NUVC9USDR4aVA0TlNQK0E2YXowdGNQMkE4WHJJSkZYTkpKSXRiclVZTy9G?=
 =?utf-8?B?d2tSdXBFNlVlRGcxak1IcysxOXZCalNyU1NMTzRNUWRtQUxBL3R0MHgxWFpU?=
 =?utf-8?B?RTBXZ0RFVGgvc3VXc29kU3d1WnhrdEtvNVY0Y3F6ckVxZGErTmlGbnRZMkZB?=
 =?utf-8?B?YXlJUzVPKzVjak9vcmZCc0RTNzVEMy9vVXpMSElwanN2Mk90RmNGdnVEU2RM?=
 =?utf-8?B?MXU5d0dNMDJ5VTI5dk9SL0ZKWnNhckNJNy9DQktyR0dyQXE4b1QyeC9wcnh1?=
 =?utf-8?B?TE5WZE1SN0pSNGZtWlVLdXpzNkRYRWJQT1BRd2pEVjB0QzdaWVZjQUpSRm9z?=
 =?utf-8?B?eWtLK1hWOVJUaGF5VGdVbTRZMndzVTYvRGRBNk1CL0h0aGhwdFI2cWtIM0V6?=
 =?utf-8?B?UzhCVGtHT003N253dHFqemVrZFpLV3lHWndXKzJLWWRQM0dlNmtmOU9ON1BH?=
 =?utf-8?B?dG1PT1g2ZDNMTEdpT2tTSVBSU2lPSUlqak83T2U5Z2tYRzJmNzBYL1U1ZzV5?=
 =?utf-8?B?WldhcHVIQlhRbS9XMWVycExTUkt3blJGODltUWRIcHlabHJkR1d2TWF1bGZj?=
 =?utf-8?B?dlV2ZFZTaE9wbUs0OHBBT3NxVnNRL1BzaTZYYWxRU01uVFlwNGlxZHhGUmxX?=
 =?utf-8?Q?Rzr6Hnx0rYx+86ylpaTP9zlUr?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0f7530c-883c-4a0a-0a93-08dc70d13d02
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 09:11:55.5463
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 348JiIgJMVrekWjPkG7zqNJvXvISWCQCXWd0lt3VuyMA7Yo8juwfS4Z6uUNV2ElnW8XFeKpB6jTsI03XMbUgrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10399

From: Peng Fan <peng.fan@nxp.com>

For i.MX7D DRAM related mux clock, the clock source change should ONLY
be done done in low level asm code without accessing DRAM, and then
calling clk API to sync the HW clock status with clk tree, it should never
touch real clock source switch via clk API, so CLK_SET_PARENT_GATE flag
should NOT be added, otherwise, DRAM's clock parent will be disabled when
DRAM is active, and system will hang.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-imx7d.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/imx/clk-imx7d.c b/drivers/clk/imx/clk-imx7d.c
index 2b77d1fc7bb9..1e1296e74835 100644
--- a/drivers/clk/imx/clk-imx7d.c
+++ b/drivers/clk/imx/clk-imx7d.c
@@ -498,9 +498,9 @@ static void __init imx7d_clocks_init(struct device_node *ccm_node)
 	hws[IMX7D_ENET_AXI_ROOT_SRC] = imx_clk_hw_mux2_flags("enet_axi_src", base + 0x8900, 24, 3, enet_axi_sel, ARRAY_SIZE(enet_axi_sel), CLK_SET_PARENT_GATE);
 	hws[IMX7D_NAND_USDHC_BUS_ROOT_SRC] = imx_clk_hw_mux2_flags("nand_usdhc_src", base + 0x8980, 24, 3, nand_usdhc_bus_sel, ARRAY_SIZE(nand_usdhc_bus_sel), CLK_SET_PARENT_GATE);
 	hws[IMX7D_DRAM_PHYM_ROOT_SRC] = imx_clk_hw_mux2_flags("dram_phym_src", base + 0x9800, 24, 1, dram_phym_sel, ARRAY_SIZE(dram_phym_sel), CLK_SET_PARENT_GATE);
-	hws[IMX7D_DRAM_ROOT_SRC] = imx_clk_hw_mux2_flags("dram_src", base + 0x9880, 24, 1, dram_sel, ARRAY_SIZE(dram_sel), CLK_SET_PARENT_GATE);
+	hws[IMX7D_DRAM_ROOT_SRC] = imx_clk_hw_mux2("dram_src", base + 0x9880, 24, 1, dram_sel, ARRAY_SIZE(dram_sel));
 	hws[IMX7D_DRAM_PHYM_ALT_ROOT_SRC] = imx_clk_hw_mux2_flags("dram_phym_alt_src", base + 0xa000, 24, 3, dram_phym_alt_sel, ARRAY_SIZE(dram_phym_alt_sel), CLK_SET_PARENT_GATE);
-	hws[IMX7D_DRAM_ALT_ROOT_SRC]  = imx_clk_hw_mux2_flags("dram_alt_src", base + 0xa080, 24, 3, dram_alt_sel, ARRAY_SIZE(dram_alt_sel), CLK_SET_PARENT_GATE);
+	hws[IMX7D_DRAM_ALT_ROOT_SRC]  = imx_clk_hw_mux2("dram_alt_src", base + 0xa080, 24, 3, dram_alt_sel, ARRAY_SIZE(dram_alt_sel));
 	hws[IMX7D_USB_HSIC_ROOT_SRC] = imx_clk_hw_mux2_flags("usb_hsic_src", base + 0xa100, 24, 3, usb_hsic_sel, ARRAY_SIZE(usb_hsic_sel), CLK_SET_PARENT_GATE);
 	hws[IMX7D_PCIE_CTRL_ROOT_SRC] = imx_clk_hw_mux2_flags("pcie_ctrl_src", base + 0xa180, 24, 3, pcie_ctrl_sel, ARRAY_SIZE(pcie_ctrl_sel), CLK_SET_PARENT_GATE);
 	hws[IMX7D_PCIE_PHY_ROOT_SRC] = imx_clk_hw_mux2_flags("pcie_phy_src", base + 0xa200, 24, 3, pcie_phy_sel, ARRAY_SIZE(pcie_phy_sel), CLK_SET_PARENT_GATE);

-- 
2.37.1



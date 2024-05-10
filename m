Return-Path: <linux-kernel+bounces-175506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B498C2088
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 11:15:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA21E28394B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 09:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A559168AF9;
	Fri, 10 May 2024 09:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="e9seynFI"
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2082.outbound.protection.outlook.com [40.107.241.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8A416C443;
	Fri, 10 May 2024 09:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715332351; cv=fail; b=dh3teuLEb5ean4Ld5bAviFAAhTXiYdyfPlU93sC+gcGGRmldC5aRxLKmMlQAfwDax0AoiTZpNuDRHuRkxc7MupHCjP0Vi3vxbMiMZ0RWxswtjUifQKTk1tCz/MGGSfUr9vtgVs7aA1MwguYqujaFQOG0LpXA25K1YGVE+JlO4VM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715332351; c=relaxed/simple;
	bh=ol6T1q1Aq60j4vSh/rwMrCMDOxf8jPJ9kodS4MqsQqw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=dXr/79nBUoNYv2Oh0SzaXd9Sa3jS5m6nlBiIWtA5OdPLifExxi8rYHrqJhC61cxd7N4d0gdbfmlJA/NlqBkGI2VhVIR88KnYA9nKcUMMwy1kAAXR7Xq2j2A1OkYIk9RwTfgGiJZpUbFFm7K9xkdH+7el94oxawLySfKHdf06nPA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=e9seynFI; arc=fail smtp.client-ip=40.107.241.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D+SsfIe1xiXyHm6tAOb1BckE8AU+beUzFbmV597qC/ry2OHDb36MvPTiRFRT+10giec2KeB3nlYOZYvYRk8ZGMpwqCuwVRTrLr4+Br3RTX5MwFsA6yCmge6eIbE/7i8GKBmysAyHgS4Pw/24nrXzD+FFrTHlfVCLhvHItUa8B5ICHv6id97cutlz1Wz3rvsPd4IrbV6+UzDFC1UlKU46K6l/VPja7akUsO/lum/N9FArylCWkOeUjcrritocwW1G0bfcaTXPzTGGL1deSv0PfP6i2+ZhC1Jk+LN8zldvK7Pbbx1iHIE1d2jZMYMf1L+BFyoc+kqGo2QhaA2GEZrKyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=haZ6P9kChEQ6LyhfR+Vw1ypeLFvLrcIo+nuKLMbxpNM=;
 b=bTjg66388YgwT438bzItJ3u0lSHF25exM4p7VYILi6OXVc7iOvIaCCla1sU8GPUuyYUO7wRFlTpEth7De2WrTKInIri7tddwBji6cuzg6w/c57+NVXKPFbxdHf5VCFcMkXxWzPQB3qZRT52efI89tP/aULJn6RMCdW32xgiAVa5CGWSFUwRiabNqWOJOcU3EHnE0pqNm7mJ4pBlgaoozKUUvVGJWzdicitxUmc453Mx8aBjApRngVn/qZDJVCubPzcyvy4iN/SxKcBvhinvGmvFnzPy0U83Mmg+LrzcnEsIIf6N0eF5DkNekY1Ib9asba7P7PyEgXQOvrdIw2dOirw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=haZ6P9kChEQ6LyhfR+Vw1ypeLFvLrcIo+nuKLMbxpNM=;
 b=e9seynFI4yNN0tPJOxOx/lqqL6Ma/9ju3bFQnBUZSTojKuTPE4eUGfqbGFvNQA34GUFeRgrceuzh2HRdfAW4TYoMwK3HA9E6+z+7rSdfPPdKrpl1ChRa+22zxYtqTPQqcvT5+ZnpnpF7WQg1vtmVg3soDef/4mHG15ZNUgEH7IE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB8065.eurprd04.prod.outlook.com (2603:10a6:20b:3ee::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.49; Fri, 10 May
 2024 09:12:24 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7544.046; Fri, 10 May 2024
 09:12:24 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Fri, 10 May 2024 17:19:09 +0800
Subject: [PATCH v2 14/17] clk: imx: imx8qxp: Add clock muxes for MIPI and
 PHY ref clocks
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240510-imx-clk-v2-14-c998f315d29c@nxp.com>
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
 Abel Vesa <abel.vesa@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 "Oliver F. Brown" <oliver.brown@oss.nxp.com>, 
 Robert Chiras <robert.chiras@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715332748; l=4040;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=xxTNiTDPAbopWXYDXxGIv8y1Vyhx+iZ9rQ5/X96xIkk=;
 b=mb95VFrXtXxKBvPuZVas9MNORM2HsBtVp6AdxtJgHEUlZ2Dc9KulgzsWPgReknP4EDvEW5Qsz
 U9bgbweau6OAkFW661w66udLTq3EiL4jl9hYbPHFjpsmwE/6mBUQ0Ya
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
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM9PR04MB8065:EE_
X-MS-Office365-Filtering-Correlation-Id: 388681d4-54b3-4770-0b40-08dc70d14e04
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|52116005|366007|1800799015|376005|7416005|921011|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L3hBTms0ZHlBMGlicWk1K3RxK1JVbFJpTFdidksweEhEWlpvV0lkdlNXRUZB?=
 =?utf-8?B?UDQwbmZKWjU1Y0VCbDA0RFdaR0h4clNxbmttNTJ0QjdTemlvMXg0UDEvVUVR?=
 =?utf-8?B?N0ZPOWtVWWVOU2lnSzB4QUJ3emhub3o5T1EwL2VDalJKSjlaTlZlNlhIM0to?=
 =?utf-8?B?b21qS1M5NUFWbUU4Z214T0RpUVBDc2pvTWpVUUU5Y3pLYStKREl5ZmJ2UGNZ?=
 =?utf-8?B?djRSRWp4ckduYXJDU1llQXdZRDV1Q3FOTFo4TmZvV0hYaHEzT2VIWWNYQytH?=
 =?utf-8?B?M0dDSlZ5RnlyaFlaV1N2Rm8yTmlHL1ZlWXBobXBVemRGNXN0ZHhYaGlmOEJz?=
 =?utf-8?B?emh1NUlkWVJpRTBnZFo4ZE9xb0VramI2ODVOQ0IyblFVUWR6aGw2aGkrdS9D?=
 =?utf-8?B?TFJ2MS9FOUFxaE0rSXhQNW5uMUI4YlYxRmdOejV3bU5RYVJlVW1BcS9IVWtW?=
 =?utf-8?B?UHM4MHV5QVV4L1JKZEdkMHFwaGpJTHRRaVpIRmloa1dUL1dxbkk0Q2ZVSEU0?=
 =?utf-8?B?ajAxZ090bDBUWkVURU5Sa2hqaUdQdUNxeE1kQzcyU21KWWYwNGZzU1ZzckFN?=
 =?utf-8?B?MVdQWDRqVGpGSG9LeGZaSkxxdzRSYkJQWWFkZkxTQXNtaFVTT2g0WGNRZ3Fv?=
 =?utf-8?B?ZDMwYUx4REkycFRSbzh3dG1DSGt4SUx2RDk2VE1rei9xTkxlcXJIR29weVpn?=
 =?utf-8?B?R1JUcm1RdUd2eUtRczlyQXEzREkrdkhnWkxWZEs4VGVxeWJadzZwTzh6ODNa?=
 =?utf-8?B?V2RubHQrN2xtblVMeG5kRFVQOEwyNkxONHd5MGUwck1nWTRzNlZ3Qmtud0Jn?=
 =?utf-8?B?VXlRYWoxYnNzZ1BJQVJoVzFCOVhEMitSNDlsRG5ZNlRpR2kwZHQ0MS81RGRx?=
 =?utf-8?B?anVYejdFa0JMZTI3Mm5SNjgyRjdFZysvVi9SQklrVHVXSXJkbEpGMVp4VW8x?=
 =?utf-8?B?bGtnaEljYkV4ZFVyTzM5TkdIeUM1Y2I1N1R4V1c3NjNLR3VxRzdIRGVuS2VV?=
 =?utf-8?B?TWQxd1BJdUdTdVJJR0dsQW95N0MxQjN4OU1TeC9lZk9uVlhDYm5nVGVqLzFZ?=
 =?utf-8?B?VUdIZHFEV0xreEpCb1dZdnN6WWdRL3hOVnRORHh3ZUt0RklaQmVxV0VZelVE?=
 =?utf-8?B?Rks3WXN1dE1KRnlZMGZYV1NDYmVQM3ArZEJCRG9xRnNWRjdmY0ppaitIb0kr?=
 =?utf-8?B?ZThKUjA1YkNYUkdPeDJ6MGMwWE9pb0dTMTBOdE9zbkoyWVBaVkp4SzNNZG9Z?=
 =?utf-8?B?ZmUwS2VMc2RGY0NIQmVyUml0MmpRTW1CaFl1dzBPL0x4UTcxeVVNUUM2enpt?=
 =?utf-8?B?d1hlQ0QxTlpGV1ViZ2hrY0pHRnJLbitZVjgyU21HaVU2U2FSM2s0MWowQUJy?=
 =?utf-8?B?Qnh5OWJBYm1KWmE1QW9HVjllMFZlQ2s5Z0ZMeDg1ckJTODc5bEJxeDgwYUhG?=
 =?utf-8?B?V2lwZ0dTNmlLblB6djNFN2ppbW4zN01yc3RyMEw3eVBCMEdIZXFkbFJBb1lW?=
 =?utf-8?B?L1Zxam5XUUV1MExycHJ0dUJCK1dvMFM1aS9nOVIvQlJ0c0Fkc1VmOVoyUHZa?=
 =?utf-8?B?UVNuV0xHNzlEVWwrT0J1MDByZ3JkblB0UGpZcjh6SUlNRS8rRlZQVndjTWo5?=
 =?utf-8?B?NGdKWStPVGVTVEUvTXQ3ZzVEZlpBSkh4VTdETzRZUXhSanZUejVnekJySE1t?=
 =?utf-8?B?eVBjaE5aMUlkYW14SDdmKzRPeTlZRmNhV2tINEF6UWprM0pFK3RWQW5wcHBa?=
 =?utf-8?B?WGF4ME90dzFFRG5xeVN2dVhEd05TUVhFUTJUeGszU0Z1MEdqZnFlZHdNRllV?=
 =?utf-8?Q?Uyf4YRwTMSEKAXZMFUQTckS9khdS0bpq+rmRs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(366007)(1800799015)(376005)(7416005)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L3FqVUNFMkhWbFhucHh4aWMwOEttckp5Rit4YWVNNElHY1ltbUxHVloxWkFG?=
 =?utf-8?B?VHlCaXNXajdFMWJ4NHlwWm1QMlJSaE1EcjBNY0RsOFBGd1pWUFdCVkJFeGZ5?=
 =?utf-8?B?dlltSjcxVXlPSTdNQTZPT2tvRnZuTzRzY3ZvQmtTTUxMclkxK2F2UDZlR0lN?=
 =?utf-8?B?Mlpka2tscVhleHNLZkJVM3hmNC9hOXJoaVErYWNtcitWblpDOHZBdjgxdjZN?=
 =?utf-8?B?WGNJMDNOakhpc1hiWlg0bnRQeGZXS2FUUlpYVzh2K1lUWi8yY2RUcCtoakFo?=
 =?utf-8?B?c0QzY3lxVlBGOE53UmFUSkFYSWdqeDhLWU1iOGFVOVNmQWE0V24rRlJyK0E5?=
 =?utf-8?B?eTNTSnRud0J3WHlXaU1JeXAxbVB4RE5nZHIvN3FYdk5SbGF3TG54aXBJSWpC?=
 =?utf-8?B?Q0JESlN6OTRrYU1vSEY0TlVOTlk1TGN2RC8vdG56MU8wR0pCT1ZPY1NYQ0J0?=
 =?utf-8?B?emFiYmNtbFNvdnltcDIvSkNndTZaTkM0RjRQdU5xK3RlVmpVZ0hvZXB5S2hw?=
 =?utf-8?B?ODVOcmFVeUt1ZnQ1WmJGb3lVQ09jbDRGdTJmVlhJcU9qNEpkTWIzZkdpdEhi?=
 =?utf-8?B?ZEJ3aGdMU1dkSHp5K0hDY2xIajdxVUZCc0VvMWZYd2NaL3pxZVVkN1B1cUR1?=
 =?utf-8?B?YUdyYTdlZlh5MHFzVVY1TG53L2VHK2dlSFB5TlozZklCMVJuckRtdWd2WW9r?=
 =?utf-8?B?OVVVc3dDaVFsRExNSFErWWo1TFRDb1krOEVoSjBVbk1lc0ZCaTJFWGRBUEd5?=
 =?utf-8?B?QWpEZWpvZi9HdS9aaFRCQ2xMdDRWcUR1VUNQblpocDdoY05KaTlWazRlTVpD?=
 =?utf-8?B?VXN5eGVYalczTDM1MWxGM1FGc0tUNXFpVkNmSHpmS3FOMXJYaDdCbEJkZVFm?=
 =?utf-8?B?SlhuRyt6Z3oxNUJraEhldHhISmduNTF1U3R0RmM0L2oyWTBNaUkrWjJ6eEln?=
 =?utf-8?B?ZlowaE5ZWDljYVBxSDVkdkZzQUNaYXNjdERvOEFma1ZjR2FFeDQwTi82VW5K?=
 =?utf-8?B?RXIvV2w0SDRPRk0yR0hjNnpQbDhIeGx4aUNrUHUrZjNiaVZFckZ5blpaTXdz?=
 =?utf-8?B?a3JScll0ZW81K3dBMXZiME9YOVE4TUl3Z0svRU04a0liNW91VDhNbnowbnRm?=
 =?utf-8?B?N284Tk05UlZyOGU0UndGTHFsVXBaTmk4TzBNQ0VsUWJvcEwvcHJGTXNJSU1Y?=
 =?utf-8?B?MEZmUWRETG1SOTBSOEpjWFhyczB1cnZUdXAxelpPYlBxdVpBbzg0U2czM2Uz?=
 =?utf-8?B?MXY1NTlYNmtVKzhZY2gyZmFHenQxYkdCOHlhS2lZZjVvdk5ub1crMkgvVUcy?=
 =?utf-8?B?QWxYaThUUUM5bG5qaVpjait1ZjQ4b1NQdUFhTUZyWFBpS2xFYTVRVUFPYUht?=
 =?utf-8?B?VU5YWHVRQnY3OHRrUXp4YXB3WG1DdHZVeXdiUks5QWgyM2RmVFNLSklZdXRv?=
 =?utf-8?B?WHljbnUrSE4rZnRaU3JMSEVOZGh5eUU0VW4vZVM2c1RyUkZ3UmZ3QVpyYmNK?=
 =?utf-8?B?Mk9xWmlGemo3UmYraGc0eEFCMm9IRHVYb0J3VGJ1RWh5VDIzTkpFMjV6RHdD?=
 =?utf-8?B?ZkI2WFB4NVp6TUJnZ2JKUVJYUTdDQVVBR2xOUkxhMHZNZ1dYdFhrU3c2REtm?=
 =?utf-8?B?NWltTFlyK05Ubnd6L0N0N1B5Q3hVTjh3YVhUelpkOFFoQ2hOc09hUzUvcU1Z?=
 =?utf-8?B?a3ZwOU9uVEVyK21BNkc3U0h4Z2cram1MSC9FU0F1YTgzbDBUQ0lUQnJ1WTda?=
 =?utf-8?B?aGZXK3lzS1ZJNWJyQ2cxYmxaTU9ORVJxZ1J4ZzkvMU5IeU9ON2xGTDNLN0hN?=
 =?utf-8?B?eFFURXlTdnN5R1ppUEp4K1RUL29GNkdTTnM4eHU3SXFERmFObkM2SXdHQXdW?=
 =?utf-8?B?MHozbjhqU0p1YmdXUEdQUmhEVG52N3h6Rlkxdlcwbi8xYjRxSHQ4VUtpYzl4?=
 =?utf-8?B?NHJGWDFLQ1BKMDIwWk5xUjlXZGZqQkYyOXlXUTNmSjVIMW5HN1RHSHhYelBJ?=
 =?utf-8?B?cXBBME5qSGxxOWxhTkkvVXVYZXlsYlY2M0gwUzl3a3VRVmtWUG8wNndvbUJ2?=
 =?utf-8?B?TC9wUGwxdjB4Z2NmaUN2MVZEMnZmdDE2STdsR0lzeGR2RGd5aWpuY25YcWFu?=
 =?utf-8?Q?OGEIoG7KdQriDHBsPLzA8IFXa?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 388681d4-54b3-4770-0b40-08dc70d14e04
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 09:12:24.0340
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 75auL1o/E2C+Ob0fVLe8yzH0zO9CBRyPey+PWh7Cska7O0eH4LoMvYTJOvM40KBF8pRrPOpjMwnOBJVhyZ9osw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8065

From: "Oliver F. Brown" <oliver.brown@oss.nxp.com>

The MIPI Pixel and PHY Reference can use the bypass clock as a source. The
MIPI bypass clock is the Pixel clock from the Display controller via the
pixel link. Using the pixel clock for the PHY reference allows the MIPI bit
clock match the pixel rate exactly.

The MIPI pixel clock is currently set to be source from the bypass clock in
the SCFW. This patch allows the pixel clock parent to be set by the kernel
in the event that the SCFW default clock parent may change in the future.

Signed-off-by: Oliver F. Brown <oliver.brown@oss.nxp.com>
Signed-off-by: Robert Chiras <robert.chiras@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-imx8qxp.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/imx/clk-imx8qxp.c b/drivers/clk/imx/clk-imx8qxp.c
index a0654edaae83..fe6509be6ce9 100644
--- a/drivers/clk/imx/clk-imx8qxp.c
+++ b/drivers/clk/imx/clk-imx8qxp.c
@@ -90,6 +90,22 @@ static const char * const mipi_sels[] = {
 	"clk_dummy",
 };
 
+static const char * const mipi0_phy_sels[] = {
+	"clk_dummy",
+	"clk_dummy",
+	"mipi_pll_div2_clk",
+	"clk_dummy",
+	"mipi0_bypass_clk",
+};
+
+static const char * const mipi1_phy_sels[] = {
+	"clk_dummy",
+	"clk_dummy",
+	"mipi_pll_div2_clk",
+	"clk_dummy",
+	"mipi1_bypass_clk",
+};
+
 static const char * const lcd_sels[] = {
 	"clk_dummy",
 	"clk_dummy",
@@ -222,25 +238,25 @@ static int imx8qxp_clk_probe(struct platform_device *pdev)
 
 	/* MIPI-LVDS SS */
 	imx_clk_scu("mipi0_bypass_clk", IMX_SC_R_MIPI_0, IMX_SC_PM_CLK_BYPASS);
-	imx_clk_scu("mipi0_pixel_clk", IMX_SC_R_MIPI_0, IMX_SC_PM_CLK_PER);
+	imx_clk_scu2("mipi0_pixel_clk", mipi0_phy_sels, ARRAY_SIZE(mipi0_phy_sels), IMX_SC_R_MIPI_0, IMX_SC_PM_CLK_PER);
 	imx_clk_scu("lvds0_bypass_clk", IMX_SC_R_LVDS_0, IMX_SC_PM_CLK_BYPASS);
 	imx_clk_scu2("lvds0_pixel_clk", lvds0_sels, ARRAY_SIZE(lvds0_sels), IMX_SC_R_LVDS_0, IMX_SC_PM_CLK_MISC2);
 	imx_clk_scu2("lvds0_phy_clk", lvds0_sels, ARRAY_SIZE(lvds0_sels), IMX_SC_R_LVDS_0, IMX_SC_PM_CLK_MISC3);
 	imx_clk_scu2("mipi0_dsi_tx_esc_clk", mipi_sels, ARRAY_SIZE(mipi_sels), IMX_SC_R_MIPI_0, IMX_SC_PM_CLK_MST_BUS);
 	imx_clk_scu2("mipi0_dsi_rx_esc_clk", mipi_sels, ARRAY_SIZE(mipi_sels), IMX_SC_R_MIPI_0, IMX_SC_PM_CLK_SLV_BUS);
-	imx_clk_scu2("mipi0_dsi_phy_clk", mipi_sels, ARRAY_SIZE(mipi_sels), IMX_SC_R_MIPI_0, IMX_SC_PM_CLK_PHY);
+	imx_clk_scu2("mipi0_dsi_phy_clk", mipi0_phy_sels, ARRAY_SIZE(mipi0_phy_sels), IMX_SC_R_MIPI_0, IMX_SC_PM_CLK_PHY);
 	imx_clk_scu("mipi0_i2c0_clk", IMX_SC_R_MIPI_0_I2C_0, IMX_SC_PM_CLK_MISC2);
 	imx_clk_scu("mipi0_i2c1_clk", IMX_SC_R_MIPI_0_I2C_1, IMX_SC_PM_CLK_MISC2);
 	imx_clk_scu("mipi0_pwm0_clk", IMX_SC_R_MIPI_0_PWM_0, IMX_SC_PM_CLK_PER);
 
 	imx_clk_scu("mipi1_bypass_clk", IMX_SC_R_MIPI_1, IMX_SC_PM_CLK_BYPASS);
-	imx_clk_scu("mipi1_pixel_clk", IMX_SC_R_MIPI_1, IMX_SC_PM_CLK_PER);
+	imx_clk_scu2("mipi1_pixel_clk", mipi1_phy_sels, ARRAY_SIZE(mipi1_phy_sels), IMX_SC_R_MIPI_1, IMX_SC_PM_CLK_PER);
 	imx_clk_scu("lvds1_bypass_clk", IMX_SC_R_LVDS_1, IMX_SC_PM_CLK_BYPASS);
 	imx_clk_scu2("lvds1_pixel_clk", lvds1_sels, ARRAY_SIZE(lvds1_sels), IMX_SC_R_LVDS_1, IMX_SC_PM_CLK_MISC2);
 	imx_clk_scu2("lvds1_phy_clk", lvds1_sels, ARRAY_SIZE(lvds1_sels), IMX_SC_R_LVDS_1, IMX_SC_PM_CLK_MISC3);
 	imx_clk_scu2("mipi1_dsi_tx_esc_clk", mipi_sels, ARRAY_SIZE(mipi_sels), IMX_SC_R_MIPI_1, IMX_SC_PM_CLK_MST_BUS);
 	imx_clk_scu2("mipi1_dsi_rx_esc_clk", mipi_sels, ARRAY_SIZE(mipi_sels), IMX_SC_R_MIPI_1, IMX_SC_PM_CLK_SLV_BUS);
-	imx_clk_scu2("mipi1_dsi_phy_clk", mipi_sels, ARRAY_SIZE(mipi_sels), IMX_SC_R_MIPI_1, IMX_SC_PM_CLK_PHY);
+	imx_clk_scu2("mipi1_dsi_phy_clk", mipi1_phy_sels, ARRAY_SIZE(mipi1_phy_sels), IMX_SC_R_MIPI_1, IMX_SC_PM_CLK_PHY);
 	imx_clk_scu("mipi1_i2c0_clk", IMX_SC_R_MIPI_1_I2C_0, IMX_SC_PM_CLK_MISC2);
 	imx_clk_scu("mipi1_i2c1_clk", IMX_SC_R_MIPI_1_I2C_1, IMX_SC_PM_CLK_MISC2);
 	imx_clk_scu("mipi1_pwm0_clk", IMX_SC_R_MIPI_1_PWM_0, IMX_SC_PM_CLK_PER);

-- 
2.37.1



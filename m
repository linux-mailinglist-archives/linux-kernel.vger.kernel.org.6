Return-Path: <linux-kernel+bounces-284098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A42294FCE0
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 06:38:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99727B22ADC
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 04:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6FDE2374C;
	Tue, 13 Aug 2024 04:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="LaoNbYdC"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2070.outbound.protection.outlook.com [40.107.249.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC99A282FC;
	Tue, 13 Aug 2024 04:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723523755; cv=fail; b=o+xXDii6aNv92MmJRTjB7o1Kas2HTXxUIeuBxQDWip0G0VCZXyq4oX3mVc0GBJyYhgbdiHJ3y2Oep70HNMYX+X0ve3dTx15IZklyfF1w7zMspJVOq/gvwav6BWAk5vDf40gSYmDH7N5b/F6DKBOOJ7mudqiJQHXlNB3uvmoJ5w0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723523755; c=relaxed/simple;
	bh=vkbgRWF6aL3Q+gxCh2kNoOFh3pFKBWzxSbAtViUvmQ8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=lDT7TZK4wBH8nmzRFosoVMbf1Eklwl+WIegT/H/8+VePac7A6tz1bKnRRPKq+P5uV18l3nfYNOgmpWfCQZJb+9zDi3feDr2YDlEDHyMwkRzLyiDYvBOcINXFLIAtJJlYb+7ypsvMC+Q2mC5IXVkcPlPj6DJpyF9WYLlDBe+gWzI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=LaoNbYdC; arc=fail smtp.client-ip=40.107.249.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qi1HcrjiyqJyn5XmvmKcr+W4xaY1yQcQP/EWKh/JjGFevcNpbbdGsIskxib0AzrHGVxyQPpXTMks+8V8abjdbz9Z3yq/BevEXtY86RrmMTWsPvuNrn8sYiKpAkhnnq84VT+g9QTFPv5l4cE4k+BrddtJo7SwKUohzjjqDYrQVjfy1m76LMJoqcHAHc+/1IEZ6Q0nqil44r7ZqNWhvXy08RR7X6wXcPMFFhpoPWcIhkzLf/X0Rv0pKLhxEPT+h0ZwoxNWalVEb6wP7NLsx/osum1uOAEkR2NyHgD8JhPE+D1gp39Yyk/+pvyGFWf+za4EshzirfqDENyzvambbKcxEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vuQxqy8Pmxjlf/JKlt5/YF/y/08sxs3O2QPputgW9Sk=;
 b=ROJ//HbDv4oGuNLCuwu1QSTGRcG0D3WS6rddljvDy+tDXJTkWt/sfHpjZ6RSYU5tA40p01EXnQeAA3NpnymxYDcD629f9GbHj4DMuuo5IqbulCCa7SWp2vA2YWQFebJe+v3liXau3l37vgamyS5IgGKxw8O3HUU4McCn10WxP5rk8sH0ZKQ+NabkB/vHqXxrz7ql7aQx73Ol/wik5rb3teq+9OW+/5hF40oidvNauDLZiQfkOVcRpwQxH5BYkVK8P1qOZiAQjllE2BwKEIJGduiMcOUxDQIJgroMPlXMghKmPuikdduOkIGqkDELazXFDSIQNmcgG0qzmgmcFLGOYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vuQxqy8Pmxjlf/JKlt5/YF/y/08sxs3O2QPputgW9Sk=;
 b=LaoNbYdCUnIbn6AC+m0WyUxGqvLEn/aN5qCDv/aI0t5X8YzeVg+ooasdJvxvlHrfPvQkB4fSRsr1dYEhHdzZNgStvWWVrIBybS1ZFTShT3MA4Ri8svyuWIZu4n882IJr1bqyBXO9Krf7rKc/5rMPfMlLXWuJf2X0Z941nUgwGMEB+opPGO4XurgQwApcaYDnjDCi8TKiSFSIDKd1og1J2rGQUUrhz2sEzoXA+sgCLMvWkAvy8CN7xrCjhoR2OcAJl1yHcDGFJ7tIHLdfxu3D7HFsvXh0L+aS5uth69VLvzcfnUUpovZbEqCnCsPUiafcP68TTknuO+pHgPSbdHFpBA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA1PR04MB10321.eurprd04.prod.outlook.com (2603:10a6:102:44f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Tue, 13 Aug
 2024 04:35:50 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.7849.019; Tue, 13 Aug 2024
 04:35:50 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 13 Aug 2024 00:35:06 -0400
Subject: [PATCH 11/17] arm64: dts: fsl-lx2160a-tqmlx2160a: change "vcc" to
 "vdd" for hub*
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240813-imx_warning-v1-11-3494426aea09@nxp.com>
References: <20240813-imx_warning-v1-0-3494426aea09@nxp.com>
In-Reply-To: <20240813-imx_warning-v1-0-3494426aea09@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Gregor Herburger <gregor.herburger@ew.tq-group.com>, 
 Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux@ew.tq-group.com, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723523705; l=1230;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=vkbgRWF6aL3Q+gxCh2kNoOFh3pFKBWzxSbAtViUvmQ8=;
 b=Nzpw3uFRlyHiGyf6IOSmRS+2cORU7HSKF4Jq4a1+QaBOiG0MQ+ccPrbdQl2i7lXcyPKwO8QJB
 bX4+kOqXR2XBqJXAs9IN8MYDezbqTEf50JeklNCue354ky/RE3xh/WU
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY3PR04CA0020.namprd04.prod.outlook.com
 (2603:10b6:a03:217::25) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA1PR04MB10321:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f220b59-f554-48d7-2656-08dcbb516897
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TWVQcklPQ0xoSnloeW5PYitPclN5c2kzbjJiZGdITTBFWnlJTHNJcnJ1ZkUz?=
 =?utf-8?B?aTVjWEs5YjJTOVJxWkZ6V1podld2NUpQZEc3MENDUndwNW9RM3B6M0NER1lE?=
 =?utf-8?B?VzBGN3EwUnhmK0sydG5odTdyVmhhaWRhY29sL1FMTi9SblNTMjd4TXpqbUJa?=
 =?utf-8?B?LzRTWDNkU1VFc3duZUZmTTlBc0g2VUpLVUFhUS9IV3hMOS81K2pad3dtQ3Zs?=
 =?utf-8?B?UUtEMmRpeDE5dStIS2I4Zk12U29OOHo4LzdPYmlObUlkVW5KcmFoZFJDcUh2?=
 =?utf-8?B?aUYwOHlnbGRMRG5pYUloOVRBL3Q5dzd2eWpIdE5DeTEzMkxQRWxXOHJhY1B4?=
 =?utf-8?B?NGUyTzJrWk5aNFdQbG1kcU0xSG5IaFFhdi9EMWpwOEY5andjSUVWZDJ4elN2?=
 =?utf-8?B?TVptdE40WUlnMXpRd0c2ZmR6aTRBb3dkVnZBS0RGbkwrZmNuZG5kaDcwRlJ4?=
 =?utf-8?B?M0JKampOaEI1Z2IxWm5WUEtLWmVhSFFXL0w2eW8yOTFnM0cxZUpBTGJFeGZG?=
 =?utf-8?B?QW84V2kyVE5xNkJYdHcrWi9tN3hKSk5YeU53c0pqR2gwczl3c3dyMUo3YXhJ?=
 =?utf-8?B?Ym45ZFpVZHluRzFjTDdzNWFEOVRqUStSODdCd1RaaGJKNGVCVkpmdmF3b2JM?=
 =?utf-8?B?eWxZenovOTRFYzhoNHVIdGRKVDQ0bzErWE5ndWJyeTVzMFVYVG95KzUrUjI2?=
 =?utf-8?B?NlpBTUV4dGp6T09YZ1dQTDBZY0pqWnpJVGd2ZUlRYXEwTkNMSVBsUUU2TnZz?=
 =?utf-8?B?VGg3dmNmb3ltc0s0Sm9DOHdJeTE0Q1ArYWZ2OHNXSHdVdTBYTmhqa2NDS3py?=
 =?utf-8?B?M3E2SjNDT3FFQlY2eXRWbHp6UUNwT0kxZ3ZiK1ltS3cxbXRHcklZSTJvdWc3?=
 =?utf-8?B?c1RBd2FxSGs5WW1Sb0xteFFpbndmTUlPKzlDbGVaem1HaDI3cU14Tm5hdDU0?=
 =?utf-8?B?OWtvR2xPWW1sWnBpWHpPcTB6bUhHQlFPd0o2V2plVkR2Mnp4bCtJWjQ5MSta?=
 =?utf-8?B?TXV5UXQ5YklvQTI5TGZyS3hJSmJYMDhKQ3lWRmR6RUVCRHlRSzZabjRFMVdi?=
 =?utf-8?B?OHFIOWxmSC9sR09XTlFmcjlWVG82L3Q0VHVrUkoyVTh2enczeG8zd0ptZXdk?=
 =?utf-8?B?dWNoeUx2YmhLTXE4bE5wTjhkUnpKQVpzeE50R3pNT0VDd3FzRGNFZEY2WGxr?=
 =?utf-8?B?anhlaElqQ1RsZDFzcmdZQUZlMm9LNG0xWE9VTkJ6U3d0R0tnUEZuc0RyL1lz?=
 =?utf-8?B?eEFiUWs1bVcyOGtLeStGWFo1cEY0eDJFMWhGNjQ5WitDMXN0L0Nld1BSd0Z5?=
 =?utf-8?B?M3M4WFBDMC9EZDFBMTJXNHl6QjI0WDZYT0YxVHFuQzIxaHVmd0xzenJzVzFO?=
 =?utf-8?B?Qmltd1Y3d1RPN2V1bVQ0LzVQbmxWUC9vaTd3a256Vk5yWjlsR2IwTFdiOG8y?=
 =?utf-8?B?SVdYNjZEb1ZsSGRBYlA3aXRmdndlc1hnNU1WM3pzTWV1cjJzNDZRVU9Kc0Ni?=
 =?utf-8?B?dTczcmxHeHIxR3Q0VkZ1Q09KdXQwYlZYbFVZRTIrd0Q3M3dLak9ZbGswMFdR?=
 =?utf-8?B?YkNOTUdkZ3FsNEVOMjlyYnRJd05ncjJvaHRkMjd2a1paQlZaUVlhcnJaNTB4?=
 =?utf-8?B?dXNZeG44ZmQwM0NQOHhUY0g0Z3lEQURDR0pQeXR0SFVhTGVjcUxadnhkR1Jr?=
 =?utf-8?B?TTMrbU5IWUp5NEo2VkpLRFNhZXpSenBGeE11cGVYbk5uRXljQVlOUVBMR2FG?=
 =?utf-8?B?ZXpHZ3NUZ3NNcFRnaVZwaFJHZndpS01lZE5rMWpmZlpvaHl3T1lXeXZyc0hn?=
 =?utf-8?B?WGdOVUZVajh5dU9PNi9KaFVxRDBvT2tmMks2MTlLL0J3WksrRitkWW5abTAz?=
 =?utf-8?B?MFR3VjU5SW1YbThqRzluUWhjYTRscjMySnAyeVZoVWx1Unc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a0Z2ZTdrNlo1RXZuVDUzSncxajRBamNPMkpySk5XYnE5NmRvZ3FFdzlYT3Aw?=
 =?utf-8?B?N25hc1oyS0dubFFQbkVLT09BbkdaUno3Y05zTng5aUQyL0VsZm55Qkg3QU5X?=
 =?utf-8?B?RytSeFdMd1IzUmtUS3FESWZ3OGJYRVg5TnhQVVNoNUVSanhHOUVWbEZmNkx6?=
 =?utf-8?B?R1Jmc25DYzV2dmZTbEFobUF5Z0NndHlxU01KSStpSzZYNjYyZWNRWmtma2NT?=
 =?utf-8?B?bkNoTm8vUjhKUHpnbWVwdFdPeXlVVVJpS0dPcUlzT05vcnlCcitVZ2pndUhj?=
 =?utf-8?B?MjIrVzlMelQxVEJGTW54RlBBcU0xZkIxSGkvNXNqZ1FTekpQbTc1bHA5Z0lW?=
 =?utf-8?B?T2trc0sraWpGOHluOFZQUVFvZWtUK3JPTVk5M3ovNkF3Zi81WHgvSWVvYi9Z?=
 =?utf-8?B?cVhydzRHdnZWZ1FZSTZySUl2WWlqa0RBSjgvNXMvZ0h3VG90YWlCTDdNTG5o?=
 =?utf-8?B?eGxpeEUzMHgvbHV4QlZQMnFUWDhvbk4wM3ZaWkNvdndiNWkyZitHLy9IZjE4?=
 =?utf-8?B?dGJ0L3pCSHF1cGdESEdMYUtYc3k0dzEvMlB4TkZ1WkZlcGlmSnF4MEhrOWRO?=
 =?utf-8?B?RXdhbWlxbGpMVzFXUDkwQTR1a3VVZUNTdEdpdkVwN1RBU1hvS2FXS2NUY2tM?=
 =?utf-8?B?REYzVEc0QnlORHkwMHFrMFQ3RHpNT29ucG94VWpHQ3p5SHhlQmI2bFc1SlJh?=
 =?utf-8?B?ZExiYUdheGdXNFIyU0dsRVlYaWlUWUpnQ1pkK0RUTDgyTndiMmlWejBNcmJP?=
 =?utf-8?B?QnJlNHU0QmNHcmFVSWxGTzBIaVkwMzdXdXhVOEpFUFB3RWpDSlhMMERjT0pU?=
 =?utf-8?B?Wkk4UTFYUlNDOGhDOWRMU3k3OXc2U0M1K3pFWXZ0NzNHSzZpK24zd3djK2dK?=
 =?utf-8?B?MlI0bytYOXJObkJ1WVlyLzVOU1JoZlBOTTRXNkVjYWYzT25PVEFRQitHRHZx?=
 =?utf-8?B?STBqdU81RHhqTFMvckJOUEl0Zml3a3ZPVWJmdnpGeVhvK09xejlWVmprWUEx?=
 =?utf-8?B?TkVXWU1KSlQxSmpYVU5jRHFPQ0Zob1JVRHZEK3E5cmJYQ2FUdTNGd1BWYXQ4?=
 =?utf-8?B?VmxZV0pRdHFPNDJXN2o0c2xFaE8rdnNrZ2wvZEUvQ3VDLzdJemZneSt6MDlw?=
 =?utf-8?B?TVZGNkE1NVc0VGxrQ3FWbmprREFkRGY1TEo5TWZIVzgwdU1TaXkxRlNEUlV3?=
 =?utf-8?B?TnpsQTZHZXIrZTRzVHlMb1BmYkZmdVI2YUo5QWNWZDJnQ21KcXFvRDRSSSto?=
 =?utf-8?B?M0lhTVFGWmI4SERlVGhtYXN5Szc5ZUZ3bWcxcEhHN24zY01uWVMvZUgzeUhz?=
 =?utf-8?B?MUlzQXdtRkVOeVU1eEtaNCsyeFB4M2UyWDlaMGF1bDFmTDVVeUZTeERzZXRG?=
 =?utf-8?B?bmo5bGRWZ2RjcE9CZmhMUkhHZ2F1QWtVM1dZTmRlejVvSjQ2elV0K1U3aHhN?=
 =?utf-8?B?TEh5dDlWN3ZDSktoVHVCM0VRbHVBSFgvanArM3k0T2svcjhQc0JIU05LblJn?=
 =?utf-8?B?bnhJek5IU29tN0xFeHM5ZG04QjVNNGtYczhJM2UzZk9mVnU0T1p5YVltK3Fy?=
 =?utf-8?B?V2E2Z1JqL3FvNXFpWUlrV202alJTMkRXOWZEMEQydGZyQUY0RExpQnEwWlVl?=
 =?utf-8?B?b1pPV1lVTFRIUEVyWVB5K2w5ZENIWElhSWpVcUNqb1VZR0xRanB0UGlpWWho?=
 =?utf-8?B?RG9paEVsM3drU0Iza0t6RjFnMy9VQUpCSllKTkxUZmRtYlhsUHR3V2Z5YkNC?=
 =?utf-8?B?Y081M1g2K21XOVZNSm5QUVpDZlVtOE5pRHhJcnlzeVBMMHYyak1UcXZzYVQ5?=
 =?utf-8?B?dTBqb2h2S3EyWUE3K3BuVTBHTnVSdDZPWlRpOC9oekZvaHpSSUR0NjJSZSth?=
 =?utf-8?B?MXZYWXg4ZU9uS1MwbEtzbEJBUGJqOXArVjlZTFdHeGxTZDFmQWFQU0xIcHVW?=
 =?utf-8?B?TjVKeXZLbnZYQ25PWUpWelVHY2Y3bStKb0FaNk1IaHRGQUVRYXJ6akZLUHFW?=
 =?utf-8?B?Q1VoRmFQa3VNdjBweG1ieWVndXNXSnBVcWppYjRFOG1yREpUcjQza0ZSNVZU?=
 =?utf-8?B?L0NQNzVxUm5SR0Z6NkxQWmdXNmZYOXg2bDhrYkdPMHEyOWxXZlp3U0QvMmxu?=
 =?utf-8?Q?WARMrb2a4GkO4w4GiiEpWH6E1?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f220b59-f554-48d7-2656-08dcbb516897
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2024 04:35:50.2348
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qwEUOyLpZ/AFr9T73KD++W01naFvpps7umOpE4AUZwruUcMHv3hgoQJqsHNchGWWeSGgeoY3O3NPeVw2q1/igQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10321

According to binging doc usb/ti,usb8041.yaml and in
drivers/usb/misc/onboard_usb_dev.h

ti_tusb8041_data = { .supply_names = { "vdd" },};

It should vdd-supply instead vcc-supply.

Fixes: 04b77e0124ef ("arm64: dts: freescale: add fsl-lx2160a-mblx2160a board")
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-lx2160a-tqmlx2160a-mblx2160a.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a-tqmlx2160a-mblx2160a.dts b/arch/arm64/boot/dts/freescale/fsl-lx2160a-tqmlx2160a-mblx2160a.dts
index da0f58e26b9aa..f6a4f8d543015 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a-tqmlx2160a-mblx2160a.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a-tqmlx2160a-mblx2160a.dts
@@ -320,7 +320,7 @@ hub_2_0: hub@1 {
 		reg = <1>;
 		peer-hub = <&hub_3_0>;
 		reset-gpios = <&gpioex1 0 GPIO_ACTIVE_LOW>;
-		vcc-supply = <&reg_vcc3v3>;
+		vdd-supply = <&reg_vcc3v3>;
 	};
 
 	hub_3_0: hub@2 {
@@ -328,7 +328,7 @@ hub_3_0: hub@2 {
 		reg = <2>;
 		peer-hub = <&hub_2_0>;
 		reset-gpios = <&gpioex1 0 GPIO_ACTIVE_LOW>;
-		vcc-supply = <&reg_vcc3v3>;
+		vdd-supply = <&reg_vcc3v3>;
 	};
 };
 

-- 
2.34.1



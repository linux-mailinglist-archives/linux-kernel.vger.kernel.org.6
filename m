Return-Path: <linux-kernel+bounces-343654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2A84989DD0
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 11:15:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0496B1C21E26
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 09:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B030318A6D4;
	Mon, 30 Sep 2024 09:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="otHwHU16"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011054.outbound.protection.outlook.com [52.101.70.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95AC7189B9D;
	Mon, 30 Sep 2024 09:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727687649; cv=fail; b=GFtWy9G/M3CjpkQIFm3/X5pEiMnsyItUyt2EzwyPL66SpZ7VWhU7T5hfw0q2+eIhysnQ4UcCXl7itxylrmlg7Mj/mwY6ASB7gtkFH8g2JL7r2pS1m6HjE3zwxftSRSGK7VOLNTvR56tBYWFVbD8nLfM7WbwjAlHkHTVXeri7kqQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727687649; c=relaxed/simple;
	bh=X1K32EimHAVnTC2ODs+CrvHoaSPoplW+DLX28iP9rXA=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=owCqwO8jo/X5yTNnkedXLlp9RLwc4LW25NbcuxfHiNDv+0/kuQLOF2hIUMCnjLnalkzf0cKkZDl7KdI7/ga4GWEzQBdybPIAPfamLWBRYu+TMkFTn2EOrlvfOuvq80wSMvRT7PXUE061aciqghRMbuy47+xNfCXmpMLpFj5skuI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=otHwHU16; arc=fail smtp.client-ip=52.101.70.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sFe9Mfz0MMnzfmhgrSe50ZNNa32RCmvQAMF0D5RoaFWbknamF03evtHM1bfbioTh//6A2HJZvl5H1/Uidhaq22IFyCP7tdiJ1kGK7aU8JyzSC8xrFyX2njPwbVzuRJ/Eq44s1pFcIfISr7G9jJ0CpnmUVl+0IdEahuMTUGofys6S0bSB73GpOQsXvOK4xJ5X8MRNn6oxdfR/FoWWWMmOe8DE/Mi6QKjPUWNLm36g68A5P047ps7b6zNevK6xeZP1tYk5xtbQBY4LquNgoN/WqayC32Fr3QuKEmfzv18bI4zCsoy29MIaGVFG+7EUfUBk5h0bCidjkUyqB6QDiSJ1LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MboKSzgGk6AJ901e0vhMqshKxikNQu03vaA4EA+qlj0=;
 b=wF5xumEkaayOMu5xZWWF5ur/dc0jVfrMxPkydLX2krjqw9Cp8xf42AyyVB0oQvf3wTMB0V7QOXNpI4U6T+m3HOMYGKguuQkTZlyv4JiSzhfOO62MjaQ2/CFpkJ7hjbiw6uCeie7Iitdsr/i5T5543NUsZ4mElsW8kJFEAfirAzkY2uJ+CmXdAz6pk0RZL3zG2zzb3e8xmLYn9Qz8lvMJ+BZ+FKuTG1xSa4rfv4bhqKuzQw0/hpjocS+t0erv2vvGp/uZh7WZQc76KMZ092Siiu8c5w1EzgD3tgYjY13p3rFpwRiDJWEFuBZJ/ebg2NsxoyCtM12RkeXcUnFoNAEwsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MboKSzgGk6AJ901e0vhMqshKxikNQu03vaA4EA+qlj0=;
 b=otHwHU16+iv8z1AlefpY26WRVMKnOhBCXCZh9kvCK1cU1EKw78887o1xCXmyD7OZNrlvNt8hA44g0mbMXkwWvHN+vTsjh+beu7Mb3mww0Off+jfqazw7u9hqEDS4QcraBcQKkTg2HGx0IrKOrwsyx1dD8Em9Qe7CuYnoPraZoSD2eWDagJcwuSV94B78S37UZ31QBkjn+hMvSBQZ66CyC5r7nfuKXXDnhoqEL0uxNA5WfXuqvtAHr1bZ18On/HbRu3qTmMYgNB7b+F+W96y+hvX1BKeUyXF6fWLxdeRWwIMZWaL5I2odb+cwDBFR83OlM20xwFyBot9/SzDlFpR6KA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS8PR04MB9173.eurprd04.prod.outlook.com (2603:10a6:20b:448::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.23; Mon, 30 Sep
 2024 09:14:00 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7982.018; Mon, 30 Sep 2024
 09:14:00 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Mon, 30 Sep 2024 17:22:26 +0800
Subject: [PATCH v2 3/3] arm64: dts: imx93-11x11-evk: add overlays for
 flexspi flash
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240930-spi-v2-3-ed7f6bcbe0df@nxp.com>
References: <20240930-spi-v2-0-ed7f6bcbe0df@nxp.com>
In-Reply-To: <20240930-spi-v2-0-ed7f6bcbe0df@nxp.com>
To: Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Marco Felsch <m.felsch@pengutronix.de>
Cc: linux-mtd@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727688153; l=4277;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=ZqvguUiQsUfx/RBcd1BVPDtrroCvCtLF7yJnubT2Mz4=;
 b=NrByZ6zIMtBFwZOJI+jpgueiNSa6/G9WOd/uvB3spSsVdpKYHvCz1H9h3qH/1INWOhxVW6wXc
 Kv8paa9YRhlCZPAtySrnsSLYDu/4k7NttoafUKXON/NXgmEF5neuy+T
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2PR01CA0017.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::19) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AS8PR04MB9173:EE_
X-MS-Office365-Filtering-Correlation-Id: b3c29497-0f23-43e3-683e-08dce130386a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|1800799024|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VDZ3MENock5oVUdITERMYy93S0o5aGNpMk9vMzZNZTVQMEZvdkVkanFIdTB1?=
 =?utf-8?B?SWlvL0tiZUMxL21ud2liKytXdHZnc016TTF1SkVkQXZ0RFhNWG9HT29OWlVZ?=
 =?utf-8?B?dDNMQnAramZFQTd1OEFVNmRXTWNqa0oyTndrL2VOWGhMZDg1Q0cxTjZ4VkZN?=
 =?utf-8?B?YnRGVCtLR0E3Rm9OaENOU2t5bjdjN1J6YzNHMjNtZHpHbkl5NlBxa3pzeGlW?=
 =?utf-8?B?Z2NvSUdQaWV6WXdPRitPVER5QWxrTElCZFYyZXNIWXBrczV0MFRjVFM5SWRy?=
 =?utf-8?B?TmVzK3NzT3hJbGZMWDdodHpOMlZLWXBYU3lYYVFFNW1QUmhFN0VwV1dsQSto?=
 =?utf-8?B?Sks3anc5ZEsyVWp3c2FJS2dNQXVxV3llVHAzcUsxNnFSQXJkK2pFT3ZKRTFk?=
 =?utf-8?B?SmpJaVlDZHJ1V3pQd1pWdVI1VUpRcng0cjd4dVVPK2t4SDVwTy92TjVhRE93?=
 =?utf-8?B?eHgrVFhsZWp2R09iY1VVa1NuYU9jUjJ1bzBoU2dXU3YrT2U1QXR6d1hhYStv?=
 =?utf-8?B?TTJNT2w3WlVjRzJWMG03TVdXZ0MxVUVzN0gvUW9yOUMvWUJkWWNpNWs4d1F2?=
 =?utf-8?B?V0EwM0grVVZxdmRiVldnVDB3K1doUy9XOENGQnZWdGYvdXlWNUoveGJyNHIx?=
 =?utf-8?B?aHROTkJSNDFlSXdYNDh6YVYxV3NzMGRhcHY5VFZkNXRtVjdsSmlvQVBZVlZH?=
 =?utf-8?B?Zkc2cDl1eXRwdlJmK0xmdWdNVHVpWFhwT3pqQkJiNVA3dGw2ZWVuUm1TS2xH?=
 =?utf-8?B?SER2ZzUweWRYcm1jalpnWkF5cDZlc2hFSUhBQWRuTW5wVk5QY3ZYZ3pUZ0JT?=
 =?utf-8?B?QXlTaXdaNkF3L0o1ZndOSXNnOHR6bTYzMEYyWnlIc2RSQ2I5U0RsZkx3ZEE5?=
 =?utf-8?B?dHlKUDZGcjBZT0Q0Wm13TEJuZ1VTYUZsTWU4aWJqZytzekhjdDh3MnhYeGZG?=
 =?utf-8?B?d3dsMmRVeCtLYitkUWZYa3dhV2RJaW1xR3VETy9LTlovcExXSXF4ZjAwU3NR?=
 =?utf-8?B?QTExNnEwS2N6Y1JiOXVhbVQxM05oQUZmM1I0dDc1MjNpOFRNeEJSMGVXY25K?=
 =?utf-8?B?bm5ERi9hQ1QrSWZycjBXUXJ2WWZDR3JTdzZQNHRnTTgrNmorZGI3aGpDTGtR?=
 =?utf-8?B?Z2t0WGIxWTFPUFFlcHk1ZFI0THNkZnpSdlRKZFY0dXVXMnpjZ0pvYXphNlk3?=
 =?utf-8?B?QzBPV1hEYzhaM1FFWDk4V05JR3RlanRhVTBJV3dyTGZaR2t3RDRMaUhVdXVr?=
 =?utf-8?B?K3FoM0hDMkdhbDh6L1dGQjZNSCtKdVRCS1dkdHpKeHM2NU0yZDAwZEpKUFZa?=
 =?utf-8?B?Y2NCT00yOHF4emVwTnFSSEF0aCticDBrbE9ZaDNCeHgzeWtjREZhNzZ2ZFAx?=
 =?utf-8?B?bTA0OWNLdllzY2RXWVJBdS9CK21nS0RBdFBUTVNvYmJETUNUMlpXSWIva2t4?=
 =?utf-8?B?QlBiN1FScDhRUHR6RHlZL0YrSHVpOEk5Q1RuMUFJQ1lJOGd3UFRraFpNQ2hm?=
 =?utf-8?B?Z0s3cThEeVJvNjZhMktOdU1URTUzOHQwWU1PUlpMSnZ3Rm1maGJ4Q1ptN3ow?=
 =?utf-8?B?RlM1NSs0VGR3LzF2MGZrbkxueVFrTFJlK3BkSGs4SDBydEJaeFJXcnZEUFJp?=
 =?utf-8?B?YzNqNnVXeWxtVjhXalRpKzhKdkFoNHFicXp5d2xlM0J0TCtSSldyVEl6dEV2?=
 =?utf-8?B?VkF3eXVjbGpZRUU5eHBWTEF4Q0kxMmNtODJPTG1RUkpTakF0TUR6eTQvMTN1?=
 =?utf-8?B?MHYwaHo0ZVZMNmhDYU82MmVkaHlMNVMxY2RYc3h0V09JSVdPZ0xyZ1NYc01u?=
 =?utf-8?B?ZTVtR2Q3RVlJODVtMEZJR1RxQ3hYNDlsTTQ4RVVhVHZvVzVlTE5ObzhRa1E1?=
 =?utf-8?B?bXZMT1dUMG1UazYxZmNpSFM3WDBHQy9UdG1IaWxnRVRZdzBMRFRXUVAwcVow?=
 =?utf-8?Q?I3+yWXG/y90=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(1800799024)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QzhSK0h1RDQ0Y05KbldlYTI3V2twY3lFajBvVTh6dWZxNkc0WE0ycXNQRW1D?=
 =?utf-8?B?Uzd5S0ZMRDhkUExScnZGdDRRN2dlY3cxdFdTT3RHTUo3a0JNc1hOTU1iQ3A4?=
 =?utf-8?B?TW5ld3hHaXVVMGdkR2V4dFpYQTVPMmhmc01zcWk1cjZvN0phc1ZrTWZqaEFt?=
 =?utf-8?B?UUc5UUVkM21lZnFMT000T2FCRTZCTDJNM25rajBmaFJwNWo5OTVpOUU1bWIw?=
 =?utf-8?B?c2g4TjMxdG52TXJ0WVhsNGxiRlIvM0tadTdnY0RGcUFLVDVpNHo0OE9kQjUr?=
 =?utf-8?B?YTNJcktaWk1HMjdTWGJxaUQxdFJrdEo4SnBoMStOd0pHeUNWekN1Rm5lYitF?=
 =?utf-8?B?VlV4TWV2Ym9KVHBaY0hyYnhUcXljL3dTcDVaQ3JVN0NsM0pQSnlMWkU0Rmtl?=
 =?utf-8?B?SFgvSHpaVFdTVGcrOGJ1Y3lNenhxa21tanN1ZkZSWEV6UVk3bFNpb1p2bk9s?=
 =?utf-8?B?NG9Qa041YWxmU0lSbXlZL3NOWTBUaUJhcWFSWDVRaEVhVVk5Y2lnQlcrQ3BR?=
 =?utf-8?B?OFlKYlJRbERQOXRUTG51M1pkbnJXSmNvSDY2UUFQRGdMOFRJZG1WemFQUHZR?=
 =?utf-8?B?N1o2dEswN0pNclFxaDM1NzFCM2RUVlZJZ2dPQWZWRmJuUUJMWldlK0RVblk1?=
 =?utf-8?B?eWlsaTVvbk83LzdPRTZHZW5QSUdOMnYrdGpkZWRHc3N2OEc0ekx4eGN3RFd6?=
 =?utf-8?B?UGtYR1RjN0ZIcERXU1RKKzRkRkVzM2R1Rm1JSHRqSWNMc00xdkNKcUw3VEI0?=
 =?utf-8?B?NkM4cWREbWgxRHJVSFhUUUczRVVDUlg4NzlsdlZtU3BOSnBrMnAwdDgvNGlt?=
 =?utf-8?B?NWtZcFlYWGl4MzNNaUpTNDIxeWtRQzJ5WFkrSnl0aFZCdFJpT1hXWDhrVXhE?=
 =?utf-8?B?NVBSTHh1M1BCem0wWEM3U04xR2xoOUpEK2Yxb0JReDNkczJITXh0RnZtaUpp?=
 =?utf-8?B?MUduT05Rck80cDBXbzM4NVNXUFczQko2M205RFVJb0pVU3ZoUEI1c0VKV0Rx?=
 =?utf-8?B?Sm13L2RKbjF3TGdWWC92ZjB3NWc1WUt5Z1JVYzg2eTBSZkZoMnBWaDFzZWM2?=
 =?utf-8?B?TFVsOWJPSmpFVzRncXV4SkNPbUJackRXUzNDYWh6Ym4wbHdTN0FuUGlkQ1hX?=
 =?utf-8?B?Skd6VGhCTzdGS1hOQzVQK2YzQW50WlFzS0xPZjJlK2FkUmo3RUFjODJybHJO?=
 =?utf-8?B?VWhrOUFMblh2d2ErSkZLaUQ4ZURRRjZIVnYyYnZ5ayt0NGVsYXFPYnJQeVlS?=
 =?utf-8?B?TmdSUkJpWmVWWmM0MzRzYnNLQ2V4REZaODk5d3NSbkxIUndGczJxeVJZN2g3?=
 =?utf-8?B?Nm1GdGhiZ2NpODUvSk1Ca092RmhDaWZrU0F3R0IzcDRMZ0s0T2tBWlYxOHFO?=
 =?utf-8?B?UkU5d0s2cnpUZFZhK3NoVzgrcmk0MmZzcm5oOUVwQkZRclpJWnN3d0FQQzR6?=
 =?utf-8?B?eUswekkrMGFJdExQZEVTSDd6U0tmeFhqS0Y1RGZpMDN4aG04KzJTR0phNkQw?=
 =?utf-8?B?YUk3NWJrSzZ5bC9Jei8waTN4VS9hSDlJUk4zZlFseVE5citmMUNIemJXc1FX?=
 =?utf-8?B?WFYvMWZqVERESCs0eEltWThWNnZxMHZtVlNLZkc0NVZkbFVTMHZ2ZkpPYzFS?=
 =?utf-8?B?SitaQVZzeklrNXN2ZC9TTUtpSWM0bjdUcmpxeC85ME1RZXFRSTVhMCtycUc0?=
 =?utf-8?B?L3pibEVSOUFCOEhmcFVlZXZqUnl2bVpGVGtoMHJTb21Qd2ZnS2Qzd0RSYmtk?=
 =?utf-8?B?eWcrcVptQlZ2dDJ5eS9MOGtnc0lYUUhBeElubUQ4dm9xN0NRMTBWbTJuUFZo?=
 =?utf-8?B?b1A3cDdTOUExRFdZWE9rcXp1ZWc2a2lkWVdCU0puMmFmbDhxQ3AzSFNLZHUz?=
 =?utf-8?B?c1ROS1djdTBTQnFzcTNWOGdjUG9HMEpISG1POVlLZGdxWWc4KzcrbnpmMHZn?=
 =?utf-8?B?R0RCTUZKVk94ZEoycGw4blFPQjBNaGg4SVZsZndIdm94Q0dtL3RhREJod0Fq?=
 =?utf-8?B?bXk0WFFvTml1WU1vSVlvcDR2UDNuUmN2OHBHV3U0WlpuYW5xUDlLbnRyc1VT?=
 =?utf-8?B?QS9hRjcrT1czVEN0YXJxMTFDL3hzYmpoVzNheDEwbEJpUjlad0JhMEZhUVpu?=
 =?utf-8?Q?CcBF0pOHh1A14DelO6V/i+7EK?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3c29497-0f23-43e3-683e-08dce130386a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 09:14:00.2677
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aIS7jODKp8D6VpLlTDTINRFEQGTIGqc4bt5A5dbVJxFeq9h7eisrXTXqkPwvysW7P2uwD58wimUXW9tORr9T3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9173

From: Peng Fan <peng.fan@nxp.com>

Add overlays for the flexspi flash connected using M.2 interface.
The M.2 interface could be connected with M.2 flash card.
The M.2 interface needs PCIE power to work properly, the flash card
needs 1.8V voltage to work properly.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/Makefile             |  3 ++
 .../dts/freescale/imx93-11x11-evk-flexspi-m2.dtso  | 59 ++++++++++++++++++++++
 arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts  | 10 ++++
 3 files changed, 72 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index 9d3df8b218a2..8f82aae85fe0 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -241,6 +241,7 @@ dtb-$(CONFIG_ARCH_MXC) += imx8qxp-tqma8xqp-mba8xx.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8ulp-evk.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx93-9x9-qsb.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx93-11x11-evk.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx93-11x11-evk-flexspi-m2.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx93-14x14-evk.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx93-kontron-bl-osm-s.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx93-phyboard-segin.dtb
@@ -249,6 +250,8 @@ dtb-$(CONFIG_ARCH_MXC) += imx93-tqma9352-mba93xxla.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx93-var-som-symphony.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx95-19x19-evk.dtb
 
+imx93-11x11-evk-flexspi-m2-dtbs	:= imx93-11x11-evk.dtb imx93-11x11-evk-flexspi-m2.dtbo
+
 imx8mm-venice-gw72xx-0x-imx219-dtbs	:= imx8mm-venice-gw72xx-0x.dtb imx8mm-venice-gw72xx-0x-imx219.dtbo
 imx8mm-venice-gw72xx-0x-rpidsi-dtbs	:= imx8mm-venice-gw72xx-0x.dtb imx8mm-venice-gw72xx-0x-rpidsi.dtbo
 imx8mm-venice-gw72xx-0x-rs232-rts-dtbs	:= imx8mm-venice-gw72xx-0x.dtb imx8mm-venice-gw72xx-0x-rs232-rts.dtbo
diff --git a/arch/arm64/boot/dts/freescale/imx93-11x11-evk-flexspi-m2.dtso b/arch/arm64/boot/dts/freescale/imx93-11x11-evk-flexspi-m2.dtso
new file mode 100644
index 000000000000..f307789546a2
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx93-11x11-evk-flexspi-m2.dtso
@@ -0,0 +1,59 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright 2024 NXP
+ */
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+#include "imx93-pinfunc.h"
+
+/dts-v1/;
+/plugin/;
+
+&{/} {
+	reg_spinor_vcc: regulator-spinor {
+		compatible = "regulator-fixed";
+		regulator-name = "SPINOR";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		vin-supply = <&reg_m2_pwr>;
+		gpio = <&pcal6524 20 GPIO_ACTIVE_HIGH>;
+		startup-delay-us = <2000>;
+		enable-active-high;
+	};
+};
+
+&usdhc3 {
+	status = "disabled";
+};
+
+&flexspi1 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_flexspi1>;
+	status = "okay";
+
+	mt25qu512abb8e12: flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		vcc-supply = <&reg_spinor_vcc>;
+		reset-gpios = <&pcal6524 12 GPIO_ACTIVE_LOW>;
+		spi-max-frequency = <133000000>;
+		spi-tx-bus-width = <4>;
+		spi-rx-bus-width = <4>;
+	};
+};
+
+&iomuxc {
+	pinctrl_flexspi1: flexspi1grp {
+		fsl,pins = <
+			MX93_PAD_SD3_CLK__FLEXSPI1_A_SCLK	0x3fe
+			MX93_PAD_SD3_CMD__FLEXSPI1_A_SS0_B	0x3fe
+			MX93_PAD_SD3_DATA0__FLEXSPI1_A_DATA00	0x3fe
+			MX93_PAD_SD3_DATA1__FLEXSPI1_A_DATA01	0x3fe
+			MX93_PAD_SD3_DATA2__FLEXSPI1_A_DATA02	0x3fe
+			MX93_PAD_SD3_DATA3__FLEXSPI1_A_DATA03	0x3fe
+		>;
+	};
+};
diff --git a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
index 8d036b3962e9..2eefa65fbfa8 100644
--- a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
@@ -78,6 +78,16 @@ reg_vref_1v8: regulator-adc-vref {
 		regulator-max-microvolt = <1800000>;
 	};
 
+	reg_m2_pwr: regulator-m2-pwr {
+		compatible = "regulator-fixed";
+		regulator-name = "M.2-power";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&pcal6524 13 GPIO_ACTIVE_HIGH>;
+		startup-delay-us = <2000>;
+		enable-active-high;
+	};
+
 	reg_usdhc2_vmmc: regulator-usdhc2 {
 		compatible = "regulator-fixed";
 		pinctrl-names = "default";

-- 
2.37.1



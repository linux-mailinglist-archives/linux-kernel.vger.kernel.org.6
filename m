Return-Path: <linux-kernel+bounces-296680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA9995ADA5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 08:37:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17FD81C222A9
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 06:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAFD213B7AE;
	Thu, 22 Aug 2024 06:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="QKldowH6"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010061.outbound.protection.outlook.com [52.101.69.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C955913B580;
	Thu, 22 Aug 2024 06:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724308637; cv=fail; b=ObVR4T3mOBpmN7c1zKcx7BUt9/BjoDl86tldBuA8RCKvRFyBKRtgAVTvFK7x/jwmucJHAe1uLDO+GeZ0ltiPkQMGS4PHFhzLxKvftJC3RSRq073uU7h7aJsgvG8iNd7TG1WBEIunAMzdfx3k7IJ9Ld18l4DtUNnxi1n88d4lbB4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724308637; c=relaxed/simple;
	bh=Z/I482sWcvJqFiEvoMmszY+w9+n4QEikYYFfJn1OF94=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cquNZWf1St37P6KU+08vlxnvXXfmSiQOpwNboCOHfkeO8QwkRTLAuNQVsgNxQJ7LTPzHU6s04GBeyIinN5XsBKfOE7QEryZQO8wLdmgKsj2rAP5Wz6/5VBHyHyYNEDv0Gr5ZOqsyPLd8hoPSfBV1DuyDlKLswZNd0qJ/5iTPxZ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=QKldowH6; arc=fail smtp.client-ip=52.101.69.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W81OD+b1icit2goDf6CbV98opo3mCFPVfoAYHgpbjsAJ3Q2qMM/01CrP9IlZajiyxq33wE8Iv8cy1nl8V1a0gvq00E2Xiv77HNoK4aefdSTHSOCQf9YNoqtThyh7t+59+tzxIx91VAHYF3YYoEikr8goAPkuK+O0ZagZPSrTw8+cQAnYNXfxepQrt0rzmaoIE0c2G7Phsh/wixHQb6o0hVpr7zXcAiSx3Rr2+FDS1+S4955v4wIFfu4vX3CL/5S7ziMGdV2xj1aKZw1DquCMgPd4Ep12Kd+yGESe33ystXUTdY06PwuklHZ87XeX7ynVtubmdsdckzE8BvPp6eutNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wQA8bTsm7LiGBXA9+WzhFLBQdsoR0ToDhz+0w2uMy90=;
 b=KdLsivLL50W/zGm7Lv03rvDYR2JQ83HDw/H6Rq3PNmokIBbNU21EfjSZQR/2yjRA/groz6qHQB4I3T+AcLc4Ct2sQhIN8wHu57qlnaWFa3LoyC552tGCnQ7vHrUq9pP6UnjAd65a8859DYIYwaVxN8T7Z7vG6PQJRtDqSbiAt3oIc8OWeyGDJDsjqImieEFpvXcME2baqV2v+8IdCVWxWLr6R25+phabCV4cFOP6tHJm33MoWAzWP4fEHbp+o4v9V3osKwiKkWvW3AXPJ3vDnK/YuMevceCRozEqibjjiiDdD3Adna4AU0WvoIaFonrhPaiDeSnryvAxmR8kFnLVQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wQA8bTsm7LiGBXA9+WzhFLBQdsoR0ToDhz+0w2uMy90=;
 b=QKldowH6vBb5TqD9AEhbK+35em3x/HjpxjuRg6hPpplpJP7r9ITfPHnefQHl87AvDGmzouUnNF5/YFsOEMGYXSIo2Q11/5sJuZyLxQIF0QeveC+TSK3pnP68xaYUy+yfFhA+qwNm0XLY0OEE5gZtm42LlIB+/aQ6KMpMLTuVyF+oM+gI3wOVQv2zJmBcBk0J7xfxs6Vj7dU1B+Ovb/IcrXxsjwrrbdDIdUtN3f+EBot26R6ZcO2WrqhbCzDqH21sfyjsE3rSjCjNh0Or9aGJ04OUzuPhE5lI2R7aRdWpSmWN7bm34trvU6V4nG3atmkjL2QI6MKC0aCZnnx/6YIqiw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by VI1PR04MB7085.eurprd04.prod.outlook.com (2603:10a6:800:122::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.18; Thu, 22 Aug
 2024 06:37:11 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::d1ce:ea15:6648:6f90]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::d1ce:ea15:6648:6f90%2]) with mapi id 15.20.7897.014; Thu, 22 Aug 2024
 06:37:11 +0000
Message-ID: <c3b73039-86b7-4456-b059-4467abf3e287@nxp.com>
Date: Thu, 22 Aug 2024 14:37:40 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: imx8mp-evk: Add native HDMI output
To: Alexander Stein <alexander.stein@ew.tq-group.com>,
 devicetree@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
 festevam@gmail.com
References: <20240822033318.753724-1-victor.liu@nxp.com>
 <3830047.kQq0lBPeGt@steina-w>
From: Liu Ying <victor.liu@nxp.com>
Content-Language: en-US
In-Reply-To: <3830047.kQq0lBPeGt@steina-w>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG3P274CA0015.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::27)
 To AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR04MB7046:EE_|VI1PR04MB7085:EE_
X-MS-Office365-Filtering-Correlation-Id: 9575a7d9-5c76-4307-454c-08dcc274da67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N050M0hhOXZUMDBMVHJSYnBPV09XU3ZIRVZTdlkzWWUvOVJGaDk2YnE3U3NM?=
 =?utf-8?B?enhabHFxRFhWVjRJaWM4U0hYbWdIbFlkYVF0Vy82M0ZIVW5DQW9EZHVOU1VT?=
 =?utf-8?B?aUdIRncwNCtpcFhaeHJWc2xwOU5RTHIyYmJ0Skh6MUNPUEV1Y1pxMUVQbXIr?=
 =?utf-8?B?UnhDZTNqd0NXNFVuYXZLTDZmcWtBSGpYWWtuZlVxcm5heFhsZEtTU3VzRll3?=
 =?utf-8?B?NHJPUEpVSnJKRmJKVkR0U0l6djU1b2g3OWNsaXJpR1lQMmRVM041RE5sWS9F?=
 =?utf-8?B?QkE0eWlwWlowUk5BazYwTlB1WG05cHJ0WHhsakFpazd0K3hyVjF5bnlNNXNS?=
 =?utf-8?B?RXpkcHNJVUppaUFoVHo0WW1xYkFNR1RCMENGZ05SWWhCNUJLaUtxYjFOVmtH?=
 =?utf-8?B?cXdPSHZLT0U0d00vN1lMVjJTbXdjOEp5eVZRWkRkdVF4NjlabVZYdHhCNWtI?=
 =?utf-8?B?b3VqZENpRDRnK0dkRHl6ZEdOczR5aldDMGxvSVdxNkJYZWM5d1RWWWNHYmlj?=
 =?utf-8?B?VDdnd3BpRmdoRE1OUnRSNTRETkxMZDV5cUFpZElNTUs2L3dteEtkbEZUMjBM?=
 =?utf-8?B?K21kUm1Kak9DUFkyeDFrcVlnVUwwQy9LdFNyeHdocVhRU3IzWWgyK01GdzdC?=
 =?utf-8?B?eHVQU1FxUU5NN0QvSXVpckgvNXBVN2MwZ2N4eURGUGJoT05WRGZEVThKaFMr?=
 =?utf-8?B?WlVlVjIrN21jeDBxSXhpYVUwVFR3ZE4rNW5DbEpXdmRjek1RZnRrUTUySFlZ?=
 =?utf-8?B?VEYzYkFUL2VOY2JPZDkrbEsyTys1U1pPVnRIUTVBZXRjdDZwaStjR0NLdUN4?=
 =?utf-8?B?VWVFejlKV2o2MnpBVDlLb1p4cDlzWGdUdm1GNDB5NGRKcy9aZWhReVZkLzBn?=
 =?utf-8?B?NXVjVjJIVHF2eHIvTS9vWXBmWGVraWVtVjJTQ29BT3NLVXgyVDhlb1Y4L0lK?=
 =?utf-8?B?Q3dmUHY1aE1yNnRGYWdTYzNEYmJoSHFKNFAwbUsza3dRQ2pGNzEyLzdEUzl4?=
 =?utf-8?B?VWlQQjhWcno4cUdjRmE1Rk1jWXlKYWNPdTJ1MVdOWlRPUmZsZmlCcmt3UlVv?=
 =?utf-8?B?WmVubG5udHlraU96RnpJWmNPTGdML1FoUkJMZmpyNklBUEtZY0YrdFdWTXhM?=
 =?utf-8?B?N0hsMm5yRlk5c1YvV0RpQ296VGNUVGRGTFIrbmZibi9mVnNGb2hMSVAxRXF3?=
 =?utf-8?B?Ri9HTDJSbGE4V0g0VDEwUEU5RVZVcjR0ZWdlWHhlbjVTd0lsdmZBaFliY2lL?=
 =?utf-8?B?djBQemRJVEZDaVRjSHEyZ2J5RnYxTVRVeEtIZjZCZHFZVFlLVjdFcnBZdUl5?=
 =?utf-8?B?d2dkRUN4V2FaQXdLSThTbEo2a2h1U2Q2MDVkOFVDb1dBcTROYTY0bHBRZWZ0?=
 =?utf-8?B?REdEalB0SDIyNmFWTmtLSE9rNWlmdU81VWJ1S3MyMjhUQmMwRnh5TGFVQ0xZ?=
 =?utf-8?B?YytSdFJZaUFDdlQ0VVNUZFJkYXlxMERtNWo2OXg3UUZEc2xUVktObDJxaG91?=
 =?utf-8?B?bWFZZHBKUWJmTFZkRGYvZ3h1N2JITGcxTVcyVjlRTjBERFM2NVVrYVVDUjMz?=
 =?utf-8?B?QlZtclpuWFRqUERWZzAxYStSSUlwR2thR1FTUFhna1IyVzljNmpUZ2tXY29Z?=
 =?utf-8?B?eUJrNU1CYUMzNlkxUndJUHFpazlFK3UxT21YSVlKMDJLSmJUTHZrMzNKNmh3?=
 =?utf-8?B?TTkzUGZUYkhUUjR4MFlFZFVGNjJGME80ZU9ENHlpclYrRkVoZy9tVnA1S01M?=
 =?utf-8?B?VzErbFN0U0tNSTJONU9FdU1iaEU3R3hSSEphKzdwWldUQ3V6NGhSaXh2cGg4?=
 =?utf-8?B?Skx5WkpOTjlhY0JwSFpFdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RHNadnBIQW5IK3o2eVY1bE1MalhBM2NSNmNlb2Z0SmU0dTd6SGlCclRxNEVD?=
 =?utf-8?B?YnJGYVJsUUxhbVFUR3lmRVFMMDZBZWVlS1hPV0o5VmxLcW93Uk5kSUEzUVhN?=
 =?utf-8?B?eWM5TjdqWjdBTml5bWl3K2ZCL0xma2hMR0hWWEtsc21SL2E5LzM2V1h0ekdz?=
 =?utf-8?B?Q3hwSkNMQnRwcys4MHFDUjVSRmZEUlFLbTNrczlGcjNoMUx1QlQ4dTFscmVV?=
 =?utf-8?B?UDZDY1ZUL1pKNCsvU1RxMFdMdXdMRVJwUU90RmJtZlJaOEZ5UW53Vkg2cTRU?=
 =?utf-8?B?bW82UFdDZ2pYRGhTSFlZS29SZ0Y3eVhRZmNMQzRTdTd0QXJMUmM5cEZ6UGtU?=
 =?utf-8?B?OFZ1ZTRPNDc0b0VBckNSbnRiczFQYnNsWWZ1ejRGL0ljaGxvRWNXZ2VPNTQx?=
 =?utf-8?B?QWowcEVtMlZ6Z05PNk1ISW5FUGxBeEdRWXVraTFqYzVKczl5TW9naFU4U3Uw?=
 =?utf-8?B?S3Y0bmNJcU1QQk45ZjBPSEJUdjR1TG82bFpqMXptMU0rV01xcEw4d3YxaHhG?=
 =?utf-8?B?VCtZT0hKZ0liZmFiMU5wbUxrQWt6d1pmbEwwa0ZBOU9RTlpFR29pQVo3N1dB?=
 =?utf-8?B?UldGaVFRREpiRTJBS1JLN09oajNXV203ZjNIM085RFhvd3phcGdQWGJJT2JP?=
 =?utf-8?B?cFAwek8yZm1kWDdLdWE2bkZxUllGMzM5azB3U3JtQUpWVUF2RUNueUxodWFw?=
 =?utf-8?B?U2wzTjNwTVA1cHdWWkhSUkltUitHdTBoQlkvck9uOUNCVUxvODQ0ZTlZZDkz?=
 =?utf-8?B?Yy8rakx1SHk5TXVNVm9HaDZFK2ZJNXQrcG1qaU8xNmtGeU51dzAza2ZWN2xq?=
 =?utf-8?B?Rmp0NVU5U243c1BMUTBKaEQ5ejRnZjY3ZzUzOG9WUENMSzVHR2lmaG81cGkw?=
 =?utf-8?B?ZE5yYnN2S0VNMnM3ZnpyakZCOWdYWFoxUENQQ3l3RGxUTUVlSWZOTXRRYTM1?=
 =?utf-8?B?NUgrbVhmK2NVV3ljdUxSM1M1V1dMcGU2Qy8vOGRYMkhUSE91NEsrSjZ4dVg3?=
 =?utf-8?B?MmE2aWVjaUw3VWs2Wmo5UlNiRFZQNmJnY0c3VjJCcjZmdWdkNmkwL3RpNzhu?=
 =?utf-8?B?dFpuVkl2OTExMmxpbXQyY1U3elZGeXQvVS9aNVU4RmhyVEtBaGFYRGtIbU1H?=
 =?utf-8?B?OUxTUXRnY21QWEpGYWNaVEVkZlBUQW81SWZkZVJUZHRWV2VjTHU5UGc4Q3do?=
 =?utf-8?B?RG12c2YzY24vakkwUUNWV2JhcDB6REh2Y01vRnZXMjg4WWkwTHlEUHFmWTJJ?=
 =?utf-8?B?dExmOGRXWW5rYjR1OVkrV3FNcmNuL2JHVnlSeFhvTDc3bzZNeDM5RWxHTnV5?=
 =?utf-8?B?Q04vZ3d5ejIxUXIwUStlWmFsWDRTdUNNRnpveHJ4Y0hUSENQWEVxbUxaUjlm?=
 =?utf-8?B?T0ZoeWU2bzFjVjBLenowTE9OU2FOcXZLUDZyUWhsdFQrWEF5THBUYWZZd0RL?=
 =?utf-8?B?UGlyaGNXYTJaMHdxSmlCWUtkcFdHYTAyM3ptWDNaQjdXU0RNNEVITDU1M3I3?=
 =?utf-8?B?OFhCMkxKSUVXeWxHYzlNTVBOMkhmWVdybkJkb1d3am5TSnc1dDRxOEc0M0VL?=
 =?utf-8?B?ZXZFWWxMbG1HeHAxeE5Ld1hDVG55NVR2MDZrTDZGOUpvY05NU1BiQUZaUGF5?=
 =?utf-8?B?dVZlQVpzbVBLcVVXYUdUQnFCNzV0STJhYVFGSW5wMUZxUjNhTlVieGdmS3pw?=
 =?utf-8?B?SjNCVFB3c3NqM09mVlBNUUpCNDREUlJ0bWhjMTZLN1BEUmJ0MlQrYkJOdlVH?=
 =?utf-8?B?QytncXFkbngzd3Z3dHRzZ0VMRG1NaFNNOW9CQXJMUzZmcG1DL3AvOUdpakJW?=
 =?utf-8?B?cjFaU3R0L0l6bUp1QlZoSTZDRHVDV2xUN2lPa3hwblVPNERoU012KzJBeWw4?=
 =?utf-8?B?TGZQT1pvS21lZlpKYTRpUXZ5SkNNU0ZZNE9zQUlDMVlkWXJNSkFzVTlsOHcr?=
 =?utf-8?B?L0xhKzZoc0M0UFBSSmlnRUxWUmRycThoMENmcWtpVnB5dVJrN0lkdW1xeTM2?=
 =?utf-8?B?RUNMZ2pLTjJWeXdaYXdwemszNFk5MmVFT3h4UzdSR0ZqbkZQaTUyS0lNeWxM?=
 =?utf-8?B?cEd3N2FWMXZMMi8zRU1NWVF4dUVhQVdSQkw0Ym14Vk1YM2FvR2U4bXNLQXd2?=
 =?utf-8?Q?C2w71Jx9erVHztKP94Lv9rEY5?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9575a7d9-5c76-4307-454c-08dcc274da67
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 06:37:11.6939
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uott/hMii6TyM/dTOFJVgQPi6J7WvCB0ubJip/SNu0PaVmBmwVuJLXof2aDmPZkWBri8NCMCIzMVvPTbPxyzSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7085

On 08/22/2024, Alexander Stein wrote:
> Hi,

Hi,

> 
> Am Donnerstag, 22. August 2024, 05:33:18 CEST schrieb Liu Ying:
>> J17 on i.MX8mp EVK base board is a HDMI type A connector.
>> It connects with i.MX8mp HDMI PHY.  Add support for it.
>>
>> Signed-off-by: Liu Ying <victor.liu@nxp.com>
>> ---
>>  arch/arm64/boot/dts/freescale/imx8mp-evk.dts | 46 ++++++++++++++++++++
>>  1 file changed, 46 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
>> index 938347704136..f118fe8ab5ac 100644
>> --- a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
>> +++ b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
>> @@ -56,6 +56,18 @@ memory@40000000 {
>>  		      <0x1 0x00000000 0 0xc0000000>;
>>  	};
>>  
>> +	native-hdmi-connector {
> 
> Is there a non-nativ HDMI connector? If not this is somewhat misleading.

Yes, there is a 'hdmi-connector' node in this file.
It is for ADV7535 MIPI DSI to HDMI bridge.

> 
>> +		compatible = "hdmi-connector";
>> +		label = "HDMI OUT";
>> +		type = "a";
>> +
>> +		port {
>> +			hdmi_out: endpoint {
> 
> That's an input port of the HDMI connector. It should be called hdmi_in or similar.
> Right now it's connecting 'hdmi_out' and 'hdmi_tx_out' which looks confusing.

I'll use hdmi_in in next version.  Thanks.

> 
> Best regards,
> Alexander
> 
>> +				remote-endpoint = <&hdmi_tx_out>;
>> +			};
>> +		};
>> +	};
>> +
>>  	pcie0_refclk: pcie0-refclk {
>>  		compatible = "fixed-clock";
>>  		#clock-cells = <0>;
>> @@ -408,6 +420,28 @@ &flexcan2 {
>>  	status = "disabled";/* can2 pin conflict with pdm */
>>  };
>>  
>> +&hdmi_pvi {
>> +	status = "okay";
>> +};
>> +
>> +&hdmi_tx {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_hdmi>;
>> +	status = "okay";
>> +
>> +	ports {
>> +		port@1 {
>> +			hdmi_tx_out: endpoint {
>> +				remote-endpoint = <&hdmi_out>;
>> +			};
>> +		};
>> +	};
>> +};
>> +
>> +&hdmi_tx_phy {
>> +	status = "okay";
>> +};
>> +
>>  &i2c1 {
>>  	clock-frequency = <400000>;
>>  	pinctrl-names = "default";
>> @@ -604,6 +638,10 @@ &lcdif1 {
>>  	status = "okay";
>>  };
>>  
>> +&lcdif3 {
>> +	status = "okay";
>> +};
>> +
>>  &micfil {
>>  	#sound-dai-cells = <0>;
>>  	pinctrl-names = "default";
>> @@ -858,6 +896,14 @@ MX8MP_IOMUXC_NAND_READY_B__GPIO3_IO16	0x140
>>  		>;
>>  	};
>>  
>> +	pinctrl_hdmi: hdmigrp {
>> +		fsl,pins = <
>> +			MX8MP_IOMUXC_HDMI_DDC_SCL__HDMIMIX_HDMI_SCL	0x1c2
>> +			MX8MP_IOMUXC_HDMI_DDC_SDA__HDMIMIX_HDMI_SDA	0x1c2
>> +			MX8MP_IOMUXC_HDMI_CEC__HDMIMIX_HDMI_CEC		0x10
>> +		>;
>> +	};
>> +
>>  	pinctrl_hog: hoggrp {
>>  		fsl,pins = <
>>  			MX8MP_IOMUXC_HDMI_HPD__HDMIMIX_HDMI_HPD		0x40000010
>>
> 
> 

-- 
Regards,
Liu Ying



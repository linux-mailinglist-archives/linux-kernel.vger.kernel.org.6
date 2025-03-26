Return-Path: <linux-kernel+bounces-577007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A273EA71739
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 14:16:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B9BE3B931A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 13:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 673FC1DF963;
	Wed, 26 Mar 2025 13:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="oAzoAHzK"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011032.outbound.protection.outlook.com [52.101.65.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B46F1EDA19;
	Wed, 26 Mar 2025 13:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742994920; cv=fail; b=gaH+iVvbcEVqpPMRQwax/fJVQXrg70fJFpyLL0OLSUhZavj2qSfTbOfHv2cq0wuQ2lSsze50wjhEzUwLOvSGRjp861tFWoj0f4KSy48EoH9O+dCNVz7MABW1KPFtl43ucDBcgfJsFByNKMlmtsWAUGp9OVSg5xy94dSe59p7SYM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742994920; c=relaxed/simple;
	bh=x46GPrAXCNE6NZYHZlvm+lLo6wiB7ucFqA87IFILO74=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=O3zldXyIBR8KBI8SBPaf/KOkPwij3oYVyi839nCddl5HYLKx5GD8m4TS9QMkiOQ5yHLg0P44+VIBpIEsNfkvc7A4X6gY2W3cfksHvM+lQRyOf0itGJdPupk7YQGgzsjfgqyNC1gAAcQX+zCiEPhEwb0ACyY5wiW5dMw75nBtwuw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=oAzoAHzK; arc=fail smtp.client-ip=52.101.65.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JOjtNhOpJxa+fN7Eb/bQftBFurG5niQg57wt2z7ZywlNI88WJOK/BcpajxYDiIxaOYBjWBndOqCMq6wDKoxF2LJ7YBxcSMVFnDtYkgZHmZhH9+10thQVQwWOll+n6hxS2XVULxoYtLOFq99aIlNxKwxcxP4xSGRSI4NGfhp3yIgzzaSnwnXKZBYRCIjzBITVu3xruIMxdRSdZZO8Bgwj1WyBwDIX74GRPd4fhy05CcjRBU94hAvBgrpEkk/Y+fZmMyzmW3iIC0qkIpVmbf8Z8ViZVEcUcBcBHO6u1J9Kivg0gclVpfQS4WsjTZaHBBstUYG1waMCMsACrUiWBqW11A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VbIqE7IC6vIxpIXZJoa7BqK7zTm7yS9o2G8fp5SWkEQ=;
 b=uUHS4hh3EXnsu86Se/fooArTY1PVePBc7W8IjmUEIpp6CpDLgmyNkAMcd8Wm9XRkFIQyAdNCjZ+OcVYXv5sMMF6k4pidxzFnZbBA1x+0Ox6m+N+S+fy9y5o16TR/DhMmDkbH0F4l/cbmuKlW8mBwAwbm0gTyY9o1uzc2+JcvQIbDyNjb/A8ldTvLir7qOnqFieqeaGDSxdzXFd4wPTB5OYcelzC9R17c6IteLLRRvhDEOHF8hUA+IhJzSfnR6EpoVcJl5oWamJ5XdarVpB1PBZMAiFq6zFEGTaFq5N2bqbCAKuajIUR3twrZupT9g9ElO2tZUY0f4GAEUwdbueMVUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VbIqE7IC6vIxpIXZJoa7BqK7zTm7yS9o2G8fp5SWkEQ=;
 b=oAzoAHzKo/LapN8stB0wfFT9Yx+oa6HI1DCu8XY8Vzxio/YB/E8QpP8x97JobhWoQKtI1sAxYpxFuRhjeIVTHwuPRCgWHti+6lBpnr3cfpve/1uiCjbc3mdWc4nVuYZwE1ej9z54BQzUOjn6tKFxLL2VF3Nnr+fEWH/iF8PN/LphzDg5dHtgjWWE0VsiUBGwetdlFwNCZYk2noVJ+3wpYsiY7SbsnKZ3unKeLKAHnfZq/CpZ2qa+MYGQAwxD2DHUDHeI+CikglDSkghO4d2tpzL9GmDVOqh2d3IVKU8g6IAz4M9QjzRBkshE4DtM5bbW1y0zrQ5bgHE2MJ0O9hrAKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21)
 by AM9PR04MB8828.eurprd04.prod.outlook.com (2603:10a6:20b:40b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 26 Mar
 2025 13:15:14 +0000
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827]) by AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827%5]) with mapi id 15.20.8534.043; Wed, 26 Mar 2025
 13:15:14 +0000
From: Pankaj Gupta <pankaj.gupta@nxp.com>
Date: Thu, 27 Mar 2025 00:08:01 +0530
Subject: [PATCH v14 5/6] firmware: imx: device context dedicated to priv
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250327-imx-se-if-v14-5-2219448932e4@nxp.com>
References: <20250327-imx-se-if-v14-0-2219448932e4@nxp.com>
In-Reply-To: <20250327-imx-se-if-v14-0-2219448932e4@nxp.com>
To: Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Pankaj Gupta <pankaj.gupta@nxp.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1743014302; l=5512;
 i=pankaj.gupta@nxp.com; s=20240523; h=from:subject:message-id;
 bh=x46GPrAXCNE6NZYHZlvm+lLo6wiB7ucFqA87IFILO74=;
 b=16vpPmMS1/FEMy5Ys1yR/ewphQAVZlL5xZXFxVS9uNhnV0PZBpQACWzJak93nFmP3/XvCTfpk
 h8Qauacf7wKCqlUix4Ze7QvgKcOFfbvNlBoIbqvo3CTvJAjaevQNmVk
X-Developer-Key: i=pankaj.gupta@nxp.com; a=ed25519;
 pk=OA0pBQoupy5lV0XfKzD8B0OOBVB6tpAoIf+0x1bYGRg=
X-ClientProxiedBy: SG2P153CA0047.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::16)
 To AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8604:EE_|AM9PR04MB8828:EE_
X-MS-Office365-Filtering-Correlation-Id: d8313c92-722d-4344-b602-08dd6c683e95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N29aMEg3dzJINFJVSVdxRy9GR2QxbkdCK1EzdkZ4MCtVY0x2c3pWeGhqOGxy?=
 =?utf-8?B?WmZ2NUp1Rkd6YlMwQlFtZTZrUlNTc3VHTU1PdEdyYW5BTCswMFRuUFdXZ3pZ?=
 =?utf-8?B?cE8wZTZmdnFEeGZDMVVXWEVYWm9hSWZObzdMM0s3dTdsT2hyTTcvMmNJU29v?=
 =?utf-8?B?VndjbERpcmR5ZzFRUS8ydjQyTUUxei9qTVlXQnNDVW9CMXNHUEZVcHBzR25S?=
 =?utf-8?B?cW40dEM0eFBaMWZpZ2NMaEZsSVc5dHdDQzhFNlRxc0FlTzU4K1BNMjU0YTc2?=
 =?utf-8?B?Z3p2dXZzc1pjMWNhd3Y2WnJTbnU0S0czUm1BYlhKNjlHQzR2WktTcFI0Ti9S?=
 =?utf-8?B?VWVRL0NWZnBpK0h4QVV6ZUtMTWJKV1lvdzZOVkVaWW1vaVoyd2I3NnprOTlQ?=
 =?utf-8?B?Z0RHOWQ3bHRjbWwyZzIreEJBbGE1MHIxenhiK2xnSlEveXh4NDBoTjFaRWFP?=
 =?utf-8?B?dWljd1ByMExNMkdMM0NrYnRLajNGTWtIZUhZYUI3Vk5lVU5vSFVwb2p0Nmdu?=
 =?utf-8?B?YXhqcHJTVnExcW1mM0FFYmtqeG1aOS8yRHBod3B1YXdxYUM4SUVyKzdad0hp?=
 =?utf-8?B?SHo4dzh0SkpFblJzbDRLQytTY01hVXphenE0WXYzeDFqU3MvVm5oR3doODU4?=
 =?utf-8?B?OUwwVGs2bHVYRmxvanZlRGJ6ZUtUQWlSMEpXbjIzOGxqTUhQV0F4SEtwV2Zy?=
 =?utf-8?B?UTBmUStPckdyNitCdnE0b2JUdGR5TlhyTHVnVzdPN1B3K05id2hteWpzdmNO?=
 =?utf-8?B?U21SYUppT1A3VVVlT3N4M092bVlPbmJVWUFuNTRxeFM1SjU0bnByQkVKM2lY?=
 =?utf-8?B?S01BMlR0Wkw3N1EzN2lzbERtTVNxY091MFhic0k2S01jZithYVJweWhyR1Rq?=
 =?utf-8?B?OWRyUG5RRmZvdXZRUGloeWswNHF1V1laWHFIS1hPeHlXOWI3M3VMV2x6WVg2?=
 =?utf-8?B?NzVUOUxUeWs3Rk1kOThjYmdlcjNrL2cwU1dhV1FNdllPRmQwN1VzUlVPYXBD?=
 =?utf-8?B?a1RzQklKeCt1S1FXQ3BFSVhKT1JZVUM0bGw1bTJSN1NyWjNqQm5vVjlCelN3?=
 =?utf-8?B?MXJ3TkJ6TUU2TldTMVI3YWNXMGJOMko3RnNXZjkxc09LZDBFcndZeUs4QVA1?=
 =?utf-8?B?dVNGZWcyZHRaL3dQQjQwR1FZTUozMVMzTGkwKzl4OVFDRFdMeTVLWUlwOXVw?=
 =?utf-8?B?OHVsYi9VSnZkOWNYdHdPdWM5dU00V0N1ZU5ncXpYNmwySU9ubUxUL3lZMmd3?=
 =?utf-8?B?b0ZZa3pwb1A0QVBqQzlVL1JzV3Q1M2ZwamliKzYvRldrdFNkazZCbXBBOTM5?=
 =?utf-8?B?VVNOQnBuR3VVNyt3WDArWDRqeENHUnR6Z1BHd3ZaTFQweGprMDVTc2RxU1I4?=
 =?utf-8?B?YWw0ckRVdFVIZ2psWUE0V3c2b2JYQUhBb3M2VnJJSG94TFg3Q28ySFVwVlZw?=
 =?utf-8?B?c0pJQTNxOTliMDlvd2x4VHNaR1FJbVFaeUlRclJ4ai9PR2NnVTNSMGxtQXpH?=
 =?utf-8?B?bHVZVjFiUTNKZER6TTRLUzhEWEFlMHo3L3d5bGJqSlM5bnc5WS95MVFHci9R?=
 =?utf-8?B?UmNPNitGbEEyVnZNWG1ESFNGY1JpNTcyd2VpZTMrNlRvSHF1WTZaMTZjRUpV?=
 =?utf-8?B?WUUzd0hTK28wUlhFK01CQ0xERzNoT1F3V1VJeVZiMHZ4eFRLR1h2UXMxOTJI?=
 =?utf-8?B?WlNEcytLRUZKaE4wRFZpZzIrZlZWYzUycnYwOFpMZm5pVlFzVVJsd1N5azlZ?=
 =?utf-8?B?ak9aNGNINzZ4WFc0QVdlYWU3ZElMY0ZjQVJaQUF0QWlKV0hEcEo5b0JRdHky?=
 =?utf-8?B?cFNwejV2bU1CTkNVZ29Wbloyc2hhbjBMdlBzU1RjVWQ0OGI0ckFlOFYvRmVw?=
 =?utf-8?B?VU9uTWVRbEswNWxseGhQRGdFWEJubnlENWdXMHZoWHhDemdpUFcxNWVJL0U3?=
 =?utf-8?Q?VFqtixS9/Ft/P058hN4/milRkPYVai2x?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8604.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VW4rSnczOVF2TGNCelFHYzhIVW10WFpCV2lsa0hFZkwra3NNdjk4cWNYM2R0?=
 =?utf-8?B?UGdNempWVlI0OVNoY25DcGFEdGRUZnVtQyt5QmkxZHpKb2l3RGVXVEhqZUh5?=
 =?utf-8?B?TE96TjZvbjhteG9hbzlKNnljbHlwSTJaS0RIeHpxSmU4Mm8vMWJ5cVBoWUE1?=
 =?utf-8?B?TTc1bFNjQ3Q2TkJsT0NBdU5qNmlORkRFenIzQkU2YnRhY0NQVlRMWCtZbXRm?=
 =?utf-8?B?SkZjVGVieTRQTkhxZXFRR3JoR3RNSllnU3dLeGJZSXVKOHJZMUdsNUh4U1Ns?=
 =?utf-8?B?ZkVJU3ZVWmJzVE1CSHVPWXg4d1ZnWDMvQm5XTk9KcE5BOUlwSVhXQjhqYk5E?=
 =?utf-8?B?RVc1dzFPNDFsZEFyZGVkazVkL3N4bFY0ZjZBVllRQWJDVUVnMEFYMmJxblpJ?=
 =?utf-8?B?bzZHWHNadXBCQk5RQ24vcFNmL3dNekZTc0prSVBleit5Z2o5aTZYWXVLckdm?=
 =?utf-8?B?aFg0V2tKM0o3VWx3dVprNTVLK0VhKzhqZlM1UDR1NEphLzUxeWR6dHQvTWdL?=
 =?utf-8?B?MVVuTHZUUjhDZzljelI5UFlockZkcjBQS3pyRDFJV2t1R2k1aDBiRmZZZUZT?=
 =?utf-8?B?RWRUNUtjeGs1NnR5c3gzUUNaN3BwdksrbHR5NnFka0xSYlFIN0VFaXJpb1Y0?=
 =?utf-8?B?MzJHbFFIUWREZmszcjNVZkREUnB6T0V2WWFtOW16TlZJVU1NMjFORDV2c3h3?=
 =?utf-8?B?MzRPSjZsenlnV29jSVZSaVJyZGNtcmcwRDF5OWxnMGNocEZ4WWJsaHdTU2ZO?=
 =?utf-8?B?b2lld3RlWHVyRkkyM1U1NjVlWFJTUzAvR2hTRkQ2dG14VGJRY0xHRjRjUzJt?=
 =?utf-8?B?MU03Ykx3RjVkd3ZzQjBvVlVKWnoyU2NDOVQxOW9PaWhkM1hlazZFU0hTWitC?=
 =?utf-8?B?ekd1WjIybTdGQ244cmZhdUhOR092d2xDeG5BTFZkM2hpZHdGclh4MCtaOHhR?=
 =?utf-8?B?TlMvcmNQMGd3ZUZ1SVlvNkw4VnQrTGp6SjFIUzNYU1poQXVEL2VwV2oyeFdP?=
 =?utf-8?B?OG13T3V4U2hLRDMvTUlTY2doTFdzK0tsSzhMSm9rYm5EU0ZmRFZMM0RHcHVz?=
 =?utf-8?B?SEZWRUJwQXVMeFBWeXhacm9oNms1VituWktiaVM0NCtTUXhCcG5CMThkV2Ey?=
 =?utf-8?B?TGZhMUNPNTBkclAxRkMyMVZDSEJSNEs1T2ZrcE1vcEVPdlRKRTVGUTlyU1dk?=
 =?utf-8?B?aEV0VUwwY0lIRHQxSjlicUNDOFgveGlvTjl3REhtWHkxWi8zc1FLY01yQ3Zs?=
 =?utf-8?B?ZElFZzlocDZScTZ2bmtpVGwwa2QwWjY0WldPWk1vV1hiakZiYUE4elFwenlz?=
 =?utf-8?B?MHV1Q1hXL2p2OXRyMGY3Vk13WG1FZGRzaDJ4ZEpscGJyWmExODU0aTYrNzd6?=
 =?utf-8?B?OFE3ek5DOTI1azZFTXdaL0cySGtBck9QTzJ6N1UxaVB2WHpEdHRwUlZud0I2?=
 =?utf-8?B?Smpub0VMTVFnblFDdC83TVZsNzlZR2lLTS8rTUpmaHVWRUZoR0Q4K1RYRytD?=
 =?utf-8?B?SjY2d2NCbFdEQ01OSUkzdk42ZFVCc0RMdlRJbXhHL04ydXgrK002djBrRVZ1?=
 =?utf-8?B?eFFMaFRyQy9uYmsxRHYvSUxCdWlMS2Z0TDM2Q3phRXFrYkdUeDI0NG1tdVBZ?=
 =?utf-8?B?NHY0R3Qyb3RKeS9oWDExbjg1UjNObmRLWXNmSmdUUWtvbDMzMVgzRHYwYnF2?=
 =?utf-8?B?QW9VdnRNYzRxYWJLbTZINEZxK1oxa2h1ZFBVOUNZSzlqb2tWazQ4R3NGeHVY?=
 =?utf-8?B?TzB5RmRWT3VFbFRsMkZuU21ObTZ3Y005NG9WVkxyWE4wd3M3VGs3M08yRHFL?=
 =?utf-8?B?M21jREFHK3IxZ3ZxV3U2aDhyUWZOT3BhWTl0aCttQVJnNnVtenNCSGs4WkEz?=
 =?utf-8?B?OWQxK243RGRXYzlNV1ZXZGZyd3Y0MnM3MTlNOHRQYk5OcHZUQXBnWHNQSE9K?=
 =?utf-8?B?dlRMQjJCV3lFVkgxM3ZvRElrdnlFUDJiT2U5YUd4L04zKy9HQm5uZ0JBc3dn?=
 =?utf-8?B?cDVMKzNJdGgxS3QxWXpyb1JPcGd4Y0JHclNsMXR4dXl0K01iQmdycEU3eHhU?=
 =?utf-8?B?Wm12T2t6NzRva0d6Y2NkMm1VYkVBbFgvczdQcmZ5RnY0WHM3aUZPZUMzbUhD?=
 =?utf-8?Q?ZWiitpbY1K0CKRGl4K9uLBLvH?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8313c92-722d-4344-b602-08dd6c683e95
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8604.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 13:15:14.3537
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dS9fsyqPpM/tmpa3L4DwT6QkvmiUUEJ/mQwQgpNFyA4VEa+VLo9CXFeWm8I9LjNPmGjvhEPqPULPeVsjwIDglg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8828

Add priv_dev_ctx to prepare enabling misc-device context
based send-receive path, to communicate with FW.

No functionality change.

Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
---
 drivers/firmware/imx/ele_base_msg.c | 10 +++++-----
 drivers/firmware/imx/ele_common.c   |  3 ++-
 drivers/firmware/imx/ele_common.h   |  2 +-
 drivers/firmware/imx/se_ctrl.c      | 31 +++++++++++++++++++++++++++++++
 drivers/firmware/imx/se_ctrl.h      |  8 ++++++++
 5 files changed, 47 insertions(+), 7 deletions(-)

diff --git a/drivers/firmware/imx/ele_base_msg.c b/drivers/firmware/imx/ele_base_msg.c
index 3839c93f8212..c07c21f1fbbd 100644
--- a/drivers/firmware/imx/ele_base_msg.c
+++ b/drivers/firmware/imx/ele_base_msg.c
@@ -62,7 +62,7 @@ int ele_get_info(struct se_if_priv *priv, struct ele_dev_info *s_info)
 	tx_msg->data[0] = upper_32_bits(get_info_addr);
 	tx_msg->data[1] = lower_32_bits(get_info_addr);
 	tx_msg->data[2] = sizeof(*s_info);
-	ret = ele_msg_send_rcv(priv,
+	ret = ele_msg_send_rcv(priv->priv_dev_ctx,
 			       tx_msg,
 			       ELE_GET_INFO_REQ_MSG_SZ,
 			       rx_msg,
@@ -122,7 +122,7 @@ int ele_ping(struct se_if_priv *priv)
 		return ret;
 	}
 
-	ret = ele_msg_send_rcv(priv,
+	ret = ele_msg_send_rcv(priv->priv_dev_ctx,
 			       tx_msg,
 			       ELE_PING_REQ_SZ,
 			       rx_msg,
@@ -174,7 +174,7 @@ int ele_service_swap(struct se_if_priv *priv,
 	if (!tx_msg->data[4])
 		return -EINVAL;
 
-	ret = ele_msg_send_rcv(priv,
+	ret = ele_msg_send_rcv(priv->priv_dev_ctx,
 			       tx_msg,
 			       ELE_SERVICE_SWAP_REQ_MSG_SZ,
 			       rx_msg,
@@ -227,7 +227,7 @@ int ele_fw_authenticate(struct se_if_priv *priv, phys_addr_t addr)
 	tx_msg->data[0] = lower_32_bits(addr);
 	tx_msg->data[2] = addr;
 
-	ret = ele_msg_send_rcv(priv,
+	ret = ele_msg_send_rcv(priv->priv_dev_ctx,
 			       tx_msg,
 			       ELE_FW_AUTH_REQ_SZ,
 			       rx_msg,
@@ -275,7 +275,7 @@ int ele_debug_dump(struct se_if_priv *priv)
 	do {
 		memset(rx_msg, 0x0, ELE_DEBUG_DUMP_RSP_SZ);
 
-		ret = ele_msg_send_rcv(priv,
+		ret = ele_msg_send_rcv(priv->priv_dev_ctx,
 				       tx_msg,
 				       ELE_DEBUG_DUMP_REQ_SZ,
 				       rx_msg,
diff --git a/drivers/firmware/imx/ele_common.c b/drivers/firmware/imx/ele_common.c
index be4dabeeb64c..f75a8237e353 100644
--- a/drivers/firmware/imx/ele_common.c
+++ b/drivers/firmware/imx/ele_common.c
@@ -89,12 +89,13 @@ int ele_msg_send(struct se_if_priv *priv,
 }
 
 /* API used for send/receive blocking call. */
-int ele_msg_send_rcv(struct se_if_priv *priv,
+int ele_msg_send_rcv(struct se_if_device_ctx *dev_ctx,
 		     void *tx_msg,
 		     int tx_msg_sz,
 		     void *rx_msg,
 		     int exp_rx_msg_sz)
 {
+	struct se_if_priv *priv = dev_ctx->priv;
 	int err;
 
 	guard(mutex)(&priv->se_if_cmd_lock);
diff --git a/drivers/firmware/imx/ele_common.h b/drivers/firmware/imx/ele_common.h
index c95e45123b5b..a6bf93f0048f 100644
--- a/drivers/firmware/imx/ele_common.h
+++ b/drivers/firmware/imx/ele_common.h
@@ -18,7 +18,7 @@ int ele_msg_rcv(struct se_if_priv *priv,
 int ele_msg_send(struct se_if_priv *priv,
 		 void *tx_msg,
 		 int tx_msg_sz);
-int ele_msg_send_rcv(struct se_if_priv *priv,
+int ele_msg_send_rcv(struct se_if_device_ctx *dev_ctx,
 		     void *tx_msg,
 		     int tx_msg_sz,
 		     void *rx_msg,
diff --git a/drivers/firmware/imx/se_ctrl.c b/drivers/firmware/imx/se_ctrl.c
index be381980fec0..144a727bbfe0 100644
--- a/drivers/firmware/imx/se_ctrl.c
+++ b/drivers/firmware/imx/se_ctrl.c
@@ -191,6 +191,31 @@ static int get_se_soc_info(struct se_if_priv *priv, const struct se_soc_info *se
 	return 0;
 }
 
+static int init_misc_device_context(struct se_if_priv *priv, int ch_id,
+				    struct se_if_device_ctx **new_dev_ctx)
+{
+	struct se_if_device_ctx *dev_ctx;
+	int ret = 0;
+
+	dev_ctx = devm_kzalloc(priv->dev, sizeof(*dev_ctx), GFP_KERNEL);
+
+	if (!dev_ctx)
+		return -ENOMEM;
+
+	dev_ctx->priv = priv;
+
+	dev_ctx->devname = devm_kasprintf(priv->dev, GFP_KERNEL, "%s%d_ch%d",
+					  SE_TYPE_STR_HSM,
+					  priv->if_defs->se_instance_id,
+					  ch_id);
+	if (!dev_ctx->devname)
+		return -ENOMEM;
+
+	*new_dev_ctx = dev_ctx;
+
+	return ret;
+}
+
 /* interface for managed res to free a mailbox channel */
 static void if_mbox_free_channel(void *mbox_chan)
 {
@@ -317,6 +342,12 @@ static int se_if_probe(struct platform_device *pdev)
 					    "Failed to init reserved memory region.");
 	}
 
+	ret = init_misc_device_context(priv, 0, &priv->priv_dev_ctx);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Failed[0x%x] to create device contexts.",
+				     ret);
+
 	if (if_node->if_defs.se_if_type == SE_TYPE_ID_HSM) {
 		ret = get_se_soc_info(priv, se_info);
 		if (ret)
diff --git a/drivers/firmware/imx/se_ctrl.h b/drivers/firmware/imx/se_ctrl.h
index 177623f3890e..f0893c5c9145 100644
--- a/drivers/firmware/imx/se_ctrl.h
+++ b/drivers/firmware/imx/se_ctrl.h
@@ -35,6 +35,12 @@ struct se_imem_buf {
 	u32 state;
 };
 
+/* Private struct for each char device instance. */
+struct se_if_device_ctx {
+	struct se_if_priv *priv;
+	const char *devname;
+};
+
 /* Header of the messages exchange with the EdgeLock Enclave */
 struct se_msg_hdr {
 	u8 ver;
@@ -79,6 +85,8 @@ struct se_if_priv {
 
 	struct gen_pool *mem_pool;
 	const struct se_if_defines *if_defs;
+
+	struct se_if_device_ctx *priv_dev_ctx;
 };
 
 #endif

-- 
2.43.0



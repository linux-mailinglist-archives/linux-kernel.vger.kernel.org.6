Return-Path: <linux-kernel+bounces-288942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 238F9954079
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 06:12:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2E851F25FE3
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 04:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A833014AD1A;
	Fri, 16 Aug 2024 04:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="a+igd/xR"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2109.outbound.protection.outlook.com [40.107.215.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F5E14831E;
	Fri, 16 Aug 2024 04:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723781223; cv=fail; b=PqeQLcuEUcI4326lIWwboWxBrP9qZXf+Wup78sai9DEYJmPpYpmMG9OiHBACz8GZE3JCNlKOt91hrnIROuxsrvIIQlyhvp4KW+oAtmQfQu+R8L76R6JuXr+K/tHnWcQ7r6fI3cEYm1V5VaQoSVdMRUEcIhte2cwERHIIi0QStH4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723781223; c=relaxed/simple;
	bh=44XNdGOvL7gwgrNWUih6rcyA8Bglsaza/DyPhHbu+/c=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=I7kq5ej3hOonOtlMpTbJ/YjzQInqhZRohmiSpiLp0lst57+Q6AmWud3yPFWKgWqLQZfTomXowUlVz/eWSINLvJT3cBOCLTPYpMPIngCMy5/W22h/pIhrE05owqcChJ2hfH+ISGcnBWkBUGlF0EcBudTLpCTrc3Yky6+Q7N4otcI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=a+igd/xR; arc=fail smtp.client-ip=40.107.215.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fatiQMsVXwdKmxGjXHkRB7j3KqpRPeE6f6Ci4NHRF3//YqL1cgwjP+HEDo9gMihJlZh3WQRlGJES38uQVxbDE7+DiIb2JZR1RWFKV55qYuZ613WZep1TvDeLzCQfDpi7aedRrRledur5p7ase93hhrFwU7/tudbz/TtIkarYhVKHszCMUj7uW9OUfrZIaLKKBcj2e5QGRSmm3vuA9C5O1KKo/09kcqPxTUbv6Mq1ZpEsNVbCx12/aOgiOD/CSqsu8AX6I9YlwaOTnrlqj1ou20Vkqg5BsEQB/3SUx7Ro/ybhEwt6KnBcIyf630bp8ZPaMmSzDiEybpMyqN07fcLWnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=44XNdGOvL7gwgrNWUih6rcyA8Bglsaza/DyPhHbu+/c=;
 b=ZmSkvVdJ/YD+HFnIba7vlr4wSlaEw64e0V8EyDDFJomqlPQDRPJMnPo58yPbf7CP1ol6YW3m5hOrFR21ZL6GkdQMIyS6jkxNOpM6BxvnjzNu6mLhxwAy04GYtSXaHK3s7dkin82Tw0+n+jg5q3b3IY1Z337svkpmPszz/pMOhUjM167Z/BjnFdjtad3FVRa4r3I0vx47EGNfGkYZFJNqZpWiwXTxOhCgS3ToXIsYUsCNxhMnzI0fJWDf4vboEleyFcTLGRCJkrv03CB0inlgPaaOjUPWvgowQyDcZZAckOjBRGvkI4CAOvNXqiQLXI/MJ/xD2c1VeTy13rXo293peg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=44XNdGOvL7gwgrNWUih6rcyA8Bglsaza/DyPhHbu+/c=;
 b=a+igd/xRBPmBZEMJKDP/6PjUUdOX6WM5uA2owHU6qxjqu+lDhkJWoWnrPmZEF03DGt1q1NeK2iRmPosJ1y8GzgHyN9swgfa1HMU31bim3vVamAEmon0Lpx1C18ICv9zuuO8qngRMDt4OuyUE54Ac79un7zEOFM+0dqCPoJ80IRprFwOtQx5EwzGjxPnZTvqwEIfcANaw1CWPagkg1Xrko/faxoHHLRqbVsk9qONaAI7ctvlOtY4DYOiguEthZULUZd1jLt+vOHYrg9UbhArTJJkcEBATZ8oqgSiUEOuTjVunQoaLW/UDRflfY67qVOFNv9fffq7wmeqCOFdsyA6njw==
Received: from PSAPR06MB4949.apcprd06.prod.outlook.com (2603:1096:301:ad::9)
 by KL1PR0601MB5510.apcprd06.prod.outlook.com (2603:1096:820:ba::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Fri, 16 Aug
 2024 04:06:58 +0000
Received: from PSAPR06MB4949.apcprd06.prod.outlook.com
 ([fe80::7bdd:639a:6b94:37bf]) by PSAPR06MB4949.apcprd06.prod.outlook.com
 ([fe80::7bdd:639a:6b94:37bf%7]) with mapi id 15.20.7875.018; Fri, 16 Aug 2024
 04:06:58 +0000
From: Kevin Chen <kevin_chen@aspeedtech.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "joel@jms.id.au"
	<joel@jms.id.au>, "andrew@codeconstruct.com.au"
	<andrew@codeconstruct.com.au>, "lee@kernel.org" <lee@kernel.org>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>, "will@kernel.org"
	<will@kernel.org>, "arnd@arndb.de" <arnd@arndb.de>, "olof@lixom.net"
	<olof@lixom.net>, "soc@kernel.org" <soc@kernel.org>,
	"mturquette@baylibre.com" <mturquette@baylibre.com>, "sboyd@kernel.org"
	<sboyd@kernel.org>, "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
	"quic_bjorande@quicinc.com" <quic_bjorande@quicinc.com>,
	"geert+renesas@glider.be" <geert+renesas@glider.be>,
	"dmitry.baryshkov@linaro.org" <dmitry.baryshkov@linaro.org>,
	"shawnguo@kernel.org" <shawnguo@kernel.org>, "neil.armstrong@linaro.org"
	<neil.armstrong@linaro.org>, "m.szyprowski@samsung.com"
	<m.szyprowski@samsung.com>, "nfraprado@collabora.com"
	<nfraprado@collabora.com>, "u-kumar1@ti.com" <u-kumar1@ti.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>
Subject: RE: [PATCH v1 03/10] clk: ast2700: add clock controller
Thread-Topic: [PATCH v1 03/10] clk: ast2700: add clock controller
Thread-Index: AQHa30uJFTBC1kHXk02g5GjokodakLII2w8AgCBtFOA=
Date: Fri, 16 Aug 2024 04:06:58 +0000
Message-ID:
 <PSAPR06MB49494F02CBA521CBA34132E689812@PSAPR06MB4949.apcprd06.prod.outlook.com>
References: <20240726110355.2181563-1-kevin_chen@aspeedtech.com>
 <20240726110355.2181563-4-kevin_chen@aspeedtech.com>
 <fb3489cf-b288-426e-ace0-abf1d6b0fe0c@kernel.org>
In-Reply-To: <fb3489cf-b288-426e-ace0-abf1d6b0fe0c@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAPR06MB4949:EE_|KL1PR0601MB5510:EE_
x-ms-office365-filtering-correlation-id: 836202a9-12d6-4c33-dc9b-08dcbda8df7f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?Z2xmb0xxQW1PdVU4VGNrM2lPcDFzb0xrMUg3MnhZUk9hcUpRc2NiWWtqMC9o?=
 =?utf-8?B?VVdkdHFSdFFFdEo4WElEM2g3WFplSTJZdmtRK0pBL0ZxZW5BSm9WanJWMlZO?=
 =?utf-8?B?TEd6U0VYc3czdmxUWGdNRUpUV04rUEY1T2JzemNTMDRHaS9SdFRNNXlvejA4?=
 =?utf-8?B?cVlRK3lxUm42THFxTDZ5SWtLWUhLakxDZHErczUrV0dJMlZrSjc4YTBmM2I5?=
 =?utf-8?B?b1llQytHaFF6azZWc3R5THdtbnhFSVFGblFBd3JuVk1obi9Cbk5OMnRleW5w?=
 =?utf-8?B?ckJJemg3Y0xrSWllNWs2S2N3NEhwVFA1SXA5M3hOYVFmaHhUaFFCZnBNV09J?=
 =?utf-8?B?aDR2RlpDcXc1djhxbC8yN0tManFKeXUvQWVXQmloai9pTjlwZmF2Qnp6RVB4?=
 =?utf-8?B?Vm8zSU1kMlRETkUzNytKd3FhNFRWNWhza1BWT0JsUGJlUmh2SlF5SEZqNW53?=
 =?utf-8?B?bUhhZFZONnlyb0dSTjRpS3ZQRXp0eENlYTlBbDN2anBTR1ozUjdLUFRoTU5q?=
 =?utf-8?B?SUd4YUxtK0JvODBhTkQ5c2g4MzNqTWpyeDEzVkwxQ2lFRWdlK1o4bFpkUWM3?=
 =?utf-8?B?aUlGSVVmV1oxL3phVHE4V0ZjWmg1V2tCRGNObUZiOEhLdmZOeXY5czdKbno1?=
 =?utf-8?B?S3FsOTdqV2xFbVBTMno2UnR1dlpXbUIrRmQ5NUg0YTd5VnhGU29HUVJ4aE5q?=
 =?utf-8?B?TEJnZ1o5NlZuTGZabDRjMkZnOWZFbkJtcUxZd3YveWJrMDBESzBVbzRpK1dv?=
 =?utf-8?B?anczTGI3NSttbVd4R3d0MCs1UERjcTk5K0dadjNEMVVFbVZzMVNITEJweVZF?=
 =?utf-8?B?bi9ZMTVROUlhbjVpUTlvaWFZcjVrTUlEczZZSjlud2RPWTVZWDl2Q0YveHRt?=
 =?utf-8?B?VS9xMUpLSFB5N2I5M2tCYVROVVBlRnpKK3NiTWVuSTFTOThoSzJHSU5UTVBG?=
 =?utf-8?B?YU9OaSsvYU5PQytvRjJyWWFhMlJUKytHOWMvczFwL0ZycXBVK08vdG5NM3Rp?=
 =?utf-8?B?OU13MUxGMnBBUWwrVXFqa0Ntc29FVzErNWkrNWFoRjltMlFOUnUwRjI0S0lH?=
 =?utf-8?B?Q0wxc2EzMWxwT0NuZTRSb2dhNTQ2TFVkRWxyWTNSc3hKUXdkQVJ6QjB0U2V2?=
 =?utf-8?B?MEpsMUkybzA2YU1GWWJUUTZaZ01LRGhUZnV3QWx0WEdJei9Zd3dKbXY4MmlM?=
 =?utf-8?B?OEdGMlA1R2JONFRYQ2w2SVpkbVM2Q0txNEFBL2FsMHJmSGRUVDVObEFhL2Rs?=
 =?utf-8?B?UXErYlFVcmFYSDdmMFZvb1pDd3NuRjA3Uk5rQ2FBTkFMR2RjazlNQURjS2NK?=
 =?utf-8?B?UmtLQjk3d0E5R3QzRTVSV3NRTEp2MS9JZGEvVEJRTDgvTkMycDJ5YTgvNkhT?=
 =?utf-8?B?WG1HTVJhSThkbytCN3ZDd2VQL0d0U1huM0R0eEZhNkRVNkhFMFMrbXFqY1Z3?=
 =?utf-8?B?SlVHMWlnaTgvY05vYTl5TWVRelVuSzU0NzhIMi90MksrL0pRUU1YL04wcUpX?=
 =?utf-8?B?aG9IeWErME5GTnJMajhHWDdUbXFkckM4Ymgyb0t3VW0vUWtCNm5RampYTnJz?=
 =?utf-8?B?NldKWStLUXpoaFdYQWt1OTVKSTBOZ2FWYytLcnhpajZVamUxSTJ1VEl6ZXBq?=
 =?utf-8?B?UGc1WWQ5RmozNmczdFFTL2tOdlhJOGh1VDJKSkFRb0dNd0NRZnQ2UGNoalNq?=
 =?utf-8?B?VXcxRUtWSWpNRGI3SEIvaU5qVWluZlVPL3FlTmtwYjIraHc4ejJzZEFMOWwx?=
 =?utf-8?B?T1RpRWpQNXh4NWhpRjFSUVdjaHNjVXZIcXVEcng2UXlvUlkvUWtJQUdUM1Nl?=
 =?utf-8?B?U3RmVUlmMk5OMWEvSDJGNzg3UmI4WllaQXZkRWJHbHNrOUtMb3lKaGFmSzJY?=
 =?utf-8?B?eDVXYjYvVUhCTnJIcjF3dmVQM2xNb0NtSksxRUJ1dEJxOE1IcCtZTURzTFhH?=
 =?utf-8?Q?NtdT3tmfVDE=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR06MB4949.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WWtEVnJUcnRvb2dSUXlja1BCSlJBWmVPV1NjQ1dGanhWOWx6RG1zTU5jU1pK?=
 =?utf-8?B?Qy9nUTdNUlhCR0o0bTlHSkh4bnhQeEtQckt1NmYzVkVwQWFXMHFUYVJQSVRT?=
 =?utf-8?B?cUFYNklwRk5heklaK05XRTJPTDI2NmMrOTI1bHJRd2lFYVBybURnZFB4cjRk?=
 =?utf-8?B?Zjh6RnJPWVlyM3IzR3JjangzUXpnNHdVUWdwUXRkU3VKT1MyUFVtSWpiTnQ4?=
 =?utf-8?B?VlR0VGIzRzV3RGJsbXRpMEVsRHhOeVppd3Q3VFJDemhxTXpLT1lJZmdTNlNv?=
 =?utf-8?B?dFZJMmZwUmk3WTdqd1YzMDRsYkhPL1o5dkt5WXdVYWJtTUlBeHNaMStLdzBn?=
 =?utf-8?B?a0JnNS9MeW9uN2ZremtZOEVlU0ZOeS9td3dPNjhVemd5SXpvMTZQeGFSVHNT?=
 =?utf-8?B?TzRLYXE2d1VPd1N3QTY0OW53c2d4UHZrWU03TCsrYjYxZG5MWXluTkt4SDBj?=
 =?utf-8?B?Z29rV0lvMGZ3VUMvcFlHbk1PWGFzbHZrRU8wQ3pWUzdLNFJxM1gxVlg5cW5p?=
 =?utf-8?B?d1ZrMXpsU0RucFdhSm1SbGhPbWVQN0djRTFGYXE3VXQyZ3IwdytuQ3QzbDB6?=
 =?utf-8?B?UzlNRG5xR3NTMzFOWDZMckNDQWJWVi9BRmxjZnRwRUNLcE5BRWJ0aXZSZzZI?=
 =?utf-8?B?a0lMeUpGNitKYkh4Q0N0OVRXNWgyRGg3dmlOS0hqdlJaTHp2Y2taU1lCZ2xw?=
 =?utf-8?B?THZGRlAwc2hlN0pHQ2ZoaUdhdWZDR09OZmJxWWV2SFVjYlRxdm5Fd1hEN2FB?=
 =?utf-8?B?TVY4a21yNXBmYU84RFFUY1MyMGFLOENKZlBHc1pVWDQvSjNOL3RLdnRxU0NC?=
 =?utf-8?B?QXQxTGVMVkp4dkEwVGRqOE8zcXdGK0V4YTgxVGorcStqV1hpNnJwQzNSWVFj?=
 =?utf-8?B?SEQxUU9ZbzYxN0grQVlYYU9nSDVhQWl3US83c3dBNnJLcEI2OUszMzdBbDUw?=
 =?utf-8?B?WGV5eHpFTGttMVBQT2ZQMHhTdGxuVmZhMnZ2SkVJMjZFT2VLY2RIakowdnRG?=
 =?utf-8?B?MVlxS2w4WG9Gdk5peXJ5MDZBRWhiQTY5a3VGMTRwYkRXVzRyUUkyaTNIZ3Fm?=
 =?utf-8?B?eHJ5djFpeE4weTFHdWNsMENzZStsYXlFVkFPcHZKWkliLzFNcytleG9aY2lF?=
 =?utf-8?B?RjVsNUtaNFpjeTdQSTcyMkNnTEhqSmV5RW9ySDA2NDZabWhuVld0UWNjQVU0?=
 =?utf-8?B?eXZVSTI5REErdU84SngvOUQ5NUMrNkFBSVhHZ1ZFY3RvWlVLY1A4R0I2ZTVv?=
 =?utf-8?B?NHFIRFNyMDNrYVlPTWtkdkR5eUdGN09FVFNSa2dpaFd2RFJwZENtNnoyOGdU?=
 =?utf-8?B?ajRFUkExZHQwSFNPNGxlcUcvMU83MC90dGdUZzJaSGdxN3ZSbDNGQ2h5cHhR?=
 =?utf-8?B?eXBGRkFUUDF5L1BiRUh3QzRQWndKeHBvQ3NKam81VGRIUzdZaEI1eGRzWkxK?=
 =?utf-8?B?WDBzVDcxNEd3cHQ2dFNhRUl4amdydDlqNHI0N293NlRvUjRQMGd0ZmpNMHM1?=
 =?utf-8?B?M0ZiV2VYMnppMXZPeXRtUEpnYmFaWEZkR0lkdHhVV0VpOTdSTTYza1I4aE9q?=
 =?utf-8?B?bGl1UlRhb0txVkI5SC9yZklDNXhFMjhvUXNPdjBuZGJ0bVI2aUdXZnJPWnNE?=
 =?utf-8?B?QjJ2K0dvVzZGbjB4VXlHMlZUb3pwb2JYZitTZVQ0ZDN6bURsUTZaKzZCaEJy?=
 =?utf-8?B?d1hNd2hDTlZwcVYzMUVQUmdqalVpa1JCcVArc09xb1dMcGVURkR4OTZoSldu?=
 =?utf-8?B?SXMzWVdNWEhQU0RUd2RWdHAzcTJBaVQxRFRLQkt3OGJMR3lVTFVGVlJTUDdk?=
 =?utf-8?B?N3J3TXJnbXRucnU2SEJIV0dyeWVVV1VzYW9EQTIwcm1jdEx5cHFiZGdCMEkz?=
 =?utf-8?B?TTZLQWVmQmwwRG4yZVphdEFOOWVGZXpkaUl0NG9ZMUk0Uk1hYjdCdE8xajk1?=
 =?utf-8?B?ZkdYaDZKQVpYWlBvUDJXeFBaaVZWYkVmZ09tM2hYdXVSOHRZbWl2bUwwQWhi?=
 =?utf-8?B?ZTRSSWt5eDRreUpHVWxET2FyM1dYV3pZekovVTgza01CRWdYYjJjZzdaNmtX?=
 =?utf-8?B?QlFqM3ZCdk1JY25ubDZiRUZlVDZmL2VPV242MTcvZ2YzV1ZFL051cW1EeXlJ?=
 =?utf-8?Q?HtI9we2X/a85nRsmfKXvxP7+B?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PSAPR06MB4949.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 836202a9-12d6-4c33-dc9b-08dcbda8df7f
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2024 04:06:58.1006
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6KqQBkpDgEVSiaVaKtsIEIrjSRLOZjH0SbEiJM2noYyTw9KvF+n5P54MiCWsiCHCP5wgjTu3nz0HOgR3XKoQZ0b0ZZdvg2Y3XbBy5prNHjU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB5510

SGkgS3J6aywNCg0KSSB3aWxsIHNlcGFyYXRlIGNsb2NrIHBhcnQgaW4gdGhlIHYzIHBhdGNoIGlu
dG8gUnlhbidzIGNsb2NrIHNlcmllcy4NCj4NCj4gU28geW91IGRpZCBub3Qgd3JpdGUgY29tbWl0
IG1zZ3MgdG8gbm9uZSBvZiB0aGUgY29tbWl0cz8NCj4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9j
bGsvTWFrZWZpbGUgICAgICB8ICAgIDEgKw0KPiA+ICBkcml2ZXJzL2Nsay9jbGstYXN0MjcwMC5j
IHwgMTE2Ng0KPiA+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiAg
MiBmaWxlcyBjaGFuZ2VkLCAxMTY3IGluc2VydGlvbnMoKykNCj4gPiAgY3JlYXRlIG1vZGUgMTAw
NjQ0IGRyaXZlcnMvY2xrL2Nsay1hc3QyNzAwLmMNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL2Nsay9NYWtlZmlsZSBiL2RyaXZlcnMvY2xrL01ha2VmaWxlIGluZGV4DQo+ID4gZjc5M2Ex
NmNhZDQwLi4wZDU5OTJlYTBmYTQgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9jbGsvTWFrZWZp
bGUNCj4gPiArKysgYi9kcml2ZXJzL2Nsay9NYWtlZmlsZQ0KPiA+IEBAIC0zOCw2ICszOCw3IEBA
IG9iai0kKENPTkZJR19DT01NT05fQ0xLX0ZTTF9TQUkpICArPSBjbGstZnNsLXNhaS5vDQo+ID4g
IG9iai0kKENPTkZJR19DT01NT05fQ0xLX0dFTUlOSSkgICAgICAgICAgICArPSBjbGstZ2VtaW5p
Lm8NCj4gPiAgb2JqLSQoQ09ORklHX0NPTU1PTl9DTEtfQVNQRUVEKSAgICAgICAgICAgICs9IGNs
ay1hc3BlZWQubw0KPiA+ICBvYmotJChDT05GSUdfTUFDSF9BU1BFRURfRzYpICAgICAgICAgICAg
ICAgKz0gY2xrLWFzdDI2MDAubw0KPiA+ICtvYmotJChDT05GSUdfTUFDSF9BU1BFRURfRzcpICAg
ICAgICAgICAgICAgKz0gY2xrLWFzdDI3MDAubw0KPg0KPiAuLi4NCj4NCj4gPiArDQo+ID4gK3N0
YXRpYyBjb25zdCBjaGFyICpjb25zdCBwc3BjbGtfc2VsW10gPSB7DQo+ID4gKyAgICJzb2MwLW1w
bGwiLA0KPiA+ICsgICAic29jMC1ocGxsIiwNCj4gPiArfTsNCj4gPiArDQo+ID4gK3N0YXRpYyBj
b25zdCBjaGFyICpjb25zdCBzb2MwX3VhcnRjbGtfc2VsW10gPSB7DQo+ID4gKyAgICJzb2MwLWNs
azI0TWh6IiwNCj4gPiArICAgInNvYzAtY2xrMTkyTWh6IiwNCj4gPiArfTsNCj4gPiArDQo+ID4g
K3N0YXRpYyBjb25zdCBjaGFyICpjb25zdCBlbW1jY2xrX3NlbFtdID0gew0KPiA+ICsgICAic29j
MC1tcGxsX2RpdjQiLA0KPiA+ICsgICAic29jMC1ocGxsX2RpdjQiLA0KPiA+ICt9Ow0KPiA+ICsN
Cj4gPiArc3RhdGljIGludCBhc3QyNzAwX3NvYzBfY2xrX2luaXQoc3RydWN0IGRldmljZV9ub2Rl
ICpzb2MwX25vZGUpIHsNCj4gPiArICAgc3RydWN0IGNsa19od19vbmVjZWxsX2RhdGEgKmNsa19k
YXRhOw0KPiA+ICsgICB2b2lkIF9faW9tZW0gKmNsa19iYXNlOw0KPiA+ICsgICBzdHJ1Y3QgYXN0
MjcwMF9yZXNldCAqcmVzZXQ7DQo+ID4gKyAgIHN0cnVjdCBjbGtfaHcgKipjbGtzOw0KPiA+ICsg
ICBpbnQgZGl2Ow0KPiA+ICsgICB1MzIgdmFsOw0KPiA+ICsgICBpbnQgcmV0Ow0KPiA+ICsNCj4g
PiArICAgY2xrX2RhdGEgPSBremFsbG9jKHN0cnVjdF9zaXplKGNsa19kYXRhLCBod3MsIFNPQzBf
TlVNX0NMS1MpLA0KPiBHRlBfS0VSTkVMKTsNCj4gPiArICAgaWYgKCFjbGtfZGF0YSkNCj4gPiAr
ICAgICAgICAgICByZXR1cm4gLUVOT01FTTsNCj4gPiArDQo+ID4gKyAgIGNsa19kYXRhLT5udW0g
PSBTT0MwX05VTV9DTEtTOw0KPiA+ICsgICBjbGtzID0gY2xrX2RhdGEtPmh3czsNCj4gPiArDQo+
ID4gKyAgIGNsa19iYXNlID0gb2ZfaW9tYXAoc29jMF9ub2RlLCAwKTsNCj4gPiArICAgaWYgKFdB
Uk5fT04oSVNfRVJSKGNsa19iYXNlKSkpDQo+DQo+IERyb3AgV0FSTl9PTg0KSSByZW1pbmQgUnlh
biBmb3IgdGhpcyBmaXguIEhlIHdpbGwgcmVwbHkgaW4gdGhlc2Ugc2VyaWVzLg0KaHR0cHM6Ly9w
YXRjaHdvcmsua2VybmVsLm9yZy9wcm9qZWN0L2xpbnV4LWNsay9wYXRjaC8yMDI0MDgwODA3NTkz
Ny4yNzU2NzMzLTUtcnlhbl9jaGVuQGFzcGVlZHRlY2guY29tLw0KDQo+DQo+ID4gKyAgICAgICAg
ICAgcmV0dXJuIFBUUl9FUlIoY2xrX2Jhc2UpOw0KPiA+ICsNCj4gPiArICAgcmVzZXQgPSBremFs
bG9jKHNpemVvZigqcmVzZXQpLCBHRlBfS0VSTkVMKTsNCj4gPiArICAgaWYgKCFyZXNldCkNCj4g
PiArICAgICAgICAgICByZXR1cm4gLUVOT01FTTsNCj4gPiArDQo+ID4gKyAgIHJlc2V0LT5iYXNl
ID0gY2xrX2Jhc2U7DQo+ID4gKw0KPiA+ICsgICByZXNldC0+cmNkZXYub3duZXIgPSBUSElTX01P
RFVMRTsNCj4gPiArICAgcmVzZXQtPnJjZGV2Lm5yX3Jlc2V0cyA9IFNPQzBfUkVTRVRfTlVNUzsN
Cj4gPiArICAgcmVzZXQtPnJjZGV2Lm9wcyA9ICZhc3QyNzAwX3Jlc2V0X29wczsNCj4gPiArICAg
cmVzZXQtPnJjZGV2Lm9mX25vZGUgPSBzb2MwX25vZGU7DQo+ID4gKw0KPiA+ICsgICByZXQgPSBy
ZXNldF9jb250cm9sbGVyX3JlZ2lzdGVyKCZyZXNldC0+cmNkZXYpOw0KPiA+ICsgICBpZiAocmV0
KSB7DQo+ID4gKyAgICAgICAgICAgcHJfZXJyKCJzb2MwIGZhaWxlZCB0byByZWdpc3RlciByZXNl
dCBjb250cm9sbGVyXG4iKTsNCj4gPiArICAgICAgICAgICByZXR1cm4gcmV0Ow0KPiA+ICsgICB9
DQo+ID4gKw0KPiA+ICsgICAvL3JlZmNsaw0KPg0KPiBXZWlyZCBjb21tZW50LiBQbGVhc2UgcmVh
ZCBDb2RpbmcgU3R5bGUuDQpJIHJlbWluZCBSeWFuIGZvciB0aGlzIGZpeC4gSGUgd2lsbCByZXBs
eSBpbiB0aGVzZSBzZXJpZXMuDQpodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3Byb2plY3Qv
bGludXgtY2xrL3BhdGNoLzIwMjQwODA4MDc1OTM3LjI3NTY3MzMtNS1yeWFuX2NoZW5AYXNwZWVk
dGVjaC5jb20vDQoNCj4NCj4NCj4gPiArICAgY2xrc1tTQ1UwX0NMS0lOXSA9DQo+ID4gKyAgICAg
ICAgICAgY2xrX2h3X3JlZ2lzdGVyX2ZpeGVkX3JhdGUoTlVMTCwgInNvYzAtY2xraW4iLCBOVUxM
LCAwLA0KPiA+ICtTQ1VfQ0xLXzI1TUhaKTsNCj4gPiArDQo+ID4gKyAgIGNsa3NbU0NVMF9DTEtf
MjRNXSA9DQo+ID4gKyAgICAgICAgICAgY2xrX2h3X3JlZ2lzdGVyX2ZpeGVkX3JhdGUoTlVMTCwg
InNvYzAtY2xrMjRNaHoiLCBOVUxMLCAwLA0KPiA+ICtTQ1VfQ0xLXzI0TUhaKTsNCj4gPiArDQo+
ID4gKyAgIGNsa3NbU0NVMF9DTEtfMTkyTV0gPQ0KPiA+ICsgICAgICAgICAgIGNsa19od19yZWdp
c3Rlcl9maXhlZF9yYXRlKE5VTEwsICJzb2MwLWNsazE5Mk1oeiIsIE5VTEwsIDAsDQo+ID4gK1ND
VV9DTEtfMTkyTUhaKTsNCj4gPiArDQo+ID4gKyAgIC8vaHBsbA0KPiA+ICsgICB2YWwgPSByZWFk
bChjbGtfYmFzZSArIFNDVTBfSFdTVFJBUDEpOw0KPiA+ICsgICBpZiAoKHZhbCAmIEdFTk1BU0so
MywgMikpICE9IDApIHsNCj4gPiArICAgICAgICAgICBzd2l0Y2ggKCh2YWwgJiBHRU5NQVNLKDMs
IDIpKSA+PiAyKSB7DQo+ID4gKyAgICAgICAgICAgY2FzZSAxOg0KPiA+ICsgICAgICAgICAgICAg
ICAgICAgY2xrc1tTQ1UwX0NMS19IUExMXSA9DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgIGNsa19od19yZWdpc3Rlcl9maXhlZF9yYXRlKE5VTEwsICJzb2MwLWhwbGwiLCBOVUxMLCAw
LA0KPiAxOTAwMDAwMDAwKTsNCj4gPiArICAgICAgICAgICAgICAgICAgIGJyZWFrOw0KPiA+ICsg
ICAgICAgICAgIGNhc2UgMjoNCj4gPiArICAgICAgICAgICAgICAgICAgIGNsa3NbU0NVMF9DTEtf
SFBMTF0gPQ0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICBjbGtfaHdfcmVnaXN0ZXJf
Zml4ZWRfcmF0ZShOVUxMLCAic29jMC1ocGxsIiwgTlVMTCwgMCwNCj4gMTgwMDAwMDAwMCk7DQo+
ID4gKyAgICAgICAgICAgICAgICAgICBicmVhazsNCj4gPiArICAgICAgICAgICBjYXNlIDM6DQo+
ID4gKyAgICAgICAgICAgICAgICAgICBjbGtzW1NDVTBfQ0xLX0hQTExdID0NCj4gPiArICAgICAg
ICAgICAgICAgICAgICAgICAgICAgY2xrX2h3X3JlZ2lzdGVyX2ZpeGVkX3JhdGUoTlVMTCwgInNv
YzAtaHBsbCIsIE5VTEwsIDAsDQo+IDE3MDAwMDAwMDApOw0KPiA+ICsgICAgICAgICAgICAgICAg
ICAgYnJlYWs7DQo+ID4gKyAgICAgICAgICAgfQ0KPiA+ICsgICB9IGVsc2Ugew0KPiA+ICsgICAg
ICAgICAgIHZhbCA9IHJlYWRsKGNsa19iYXNlICsgU0NVMF9IUExMX1BBUkFNKTsNCj4gPiArICAg
ICAgICAgICBjbGtzW1NDVTBfQ0xLX0hQTExdID0gYXN0MjcwMF9zb2MwX2h3X3BsbCgic29jMC1o
cGxsIiwNCj4gInNvYzAtY2xraW4iLCB2YWwpOw0KPiA+ICsgICB9DQo+ID4gKyAgIGNsa3NbU0NV
MF9DTEtfSFBMTF9ESVYyXSA9IGNsa19od19yZWdpc3Rlcl9maXhlZF9mYWN0b3IoTlVMTCwNCj4g
InNvYzAtaHBsbF9kaXYyIiwgInNvYzAtaHBsbCIsIDAsIDEsIDIpOw0KPiA+ICsgICBjbGtzW1ND
VTBfQ0xLX0hQTExfRElWNF0gPSBjbGtfaHdfcmVnaXN0ZXJfZml4ZWRfZmFjdG9yKE5VTEwsDQo+
ID4gKyJzb2MwLWhwbGxfZGl2NCIsICJzb2MwLWhwbGwiLCAwLCAxLCA0KTsNCj4gPiArDQo+ID4g
KyAgIC8vZHBsbA0KPg0KPg0KPg0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0KDQotLQ0K
QmVzdCBSZWdhcmRzLA0KS2V2aW4uQ2hlbg0KKioqKioqKioqKioqKiBFbWFpbCBDb25maWRlbnRp
YWxpdHkgTm90aWNlICoqKioqKioqKioqKioqKioqKioqDQrlhY3osqzogbLmmI46DQrmnKzkv6Hk
u7Yo5oiW5YW26ZmE5Lu2KeWPr+iDveWMheWQq+apn+Wvhuizh+ioiu+8jOS4puWPl+azleW+i+S/
neitt+OAguWmgiDlj7Dnq6/pnZ7mjIflrprkuYvmlLbku7bogIXvvIzoq4vku6Xpm7vlrZDpg7Xk
u7bpgJrnn6XmnKzpm7vlrZDpg7Xku7bkuYvnmbzpgIHogIUsIOS4puiri+eri+WNs+WIqumZpOac
rOmbu+WtkOmDteS7tuWPiuWFtumZhOS7tuWSjOmKt+avgOaJgOacieikh+WNsOS7tuOAguisneis
neaCqOeahOWQiOS9nCENCg0KRElTQ0xBSU1FUjoNClRoaXMgbWVzc2FnZSAoYW5kIGFueSBhdHRh
Y2htZW50cykgbWF5IGNvbnRhaW4gbGVnYWxseSBwcml2aWxlZ2VkIGFuZC9vciBvdGhlciBjb25m
aWRlbnRpYWwgaW5mb3JtYXRpb24uIElmIHlvdSBoYXZlIHJlY2VpdmVkIGl0IGluIGVycm9yLCBw
bGVhc2Ugbm90aWZ5IHRoZSBzZW5kZXIgYnkgcmVwbHkgZS1tYWlsIGFuZCBpbW1lZGlhdGVseSBk
ZWxldGUgdGhlIGUtbWFpbCBhbmQgYW55IGF0dGFjaG1lbnRzIHdpdGhvdXQgY29weWluZyBvciBk
aXNjbG9zaW5nIHRoZSBjb250ZW50cy4gVGhhbmsgeW91Lg0K


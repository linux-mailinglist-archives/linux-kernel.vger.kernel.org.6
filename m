Return-Path: <linux-kernel+bounces-177570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D08A8C40E8
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 14:42:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A0541C2158B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 12:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B463114F9CE;
	Mon, 13 May 2024 12:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="p9OwHkpp"
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2055.outbound.protection.outlook.com [40.107.13.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B7E14BFAB;
	Mon, 13 May 2024 12:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.13.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715604128; cv=fail; b=XXRIswuI2DYOC7MfYj/2N0PrgojJ8LNXCGtJ/xdjS2whJJ4YdNLOER41N2hwiZCbNhNjY7IwrBt3E6uLnFu1og4O4lK8Npa8qo64dulEdKliGqEl5ELIafoXjlaKr5Wn0oSHuwZ8+sctsMdZS+dPXhBXGogdUrnI0FkO+dVlwSU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715604128; c=relaxed/simple;
	bh=rVXMRkibz3NGDlyZik7urzdfxRLQoxrh6Vy3LpoA5P8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kTaOJ9DL68D4jC4R8h+iI2IvCgOv+LvY/ODCIB8X/UbINPfCNUuDk+3r7aZUxeSakv9nVr+3CaOr4yahs2ZTAWrLp/ff8OftwEJWoGSPnDSNkibqKxXw1eON19K7zimgpkLOyWgouxx+V2ebAD2nWwW+0s7zyJi0BqpW8jQZjvk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=p9OwHkpp; arc=fail smtp.client-ip=40.107.13.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UuZZ5elN4I2NE56eCwhEmQYyU3KlcX0PIsygviA+K36NEI26pPT++S8dfCc4K0kxPoG+vCYKX5KWNl9yDuewg3Mem99LRPmO2JNKN4fT43d779ejlpjn4aiidX5/Dvk2DEkD76CwZqlU0L7JHnwmW86aa1pgGNBMKw0qIQtCrzjeL7zStJj0+V5WCJwwad3BXh6u6UMU6IeRwwDUTZFMQvSARd4SP6AofQZv/h5xPizu1RG1Zoao1pJ53M4ML9/jnvesiykmiRaBS0M0SR26YGbCv4HvtG2RVrrXy5moVbAuLx7fyu12LzzU2TOliqAnGsSvqPa/E0XxxYjAeaOs/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rVXMRkibz3NGDlyZik7urzdfxRLQoxrh6Vy3LpoA5P8=;
 b=HgB54cwWdek/M2w0MtTGb5TMpTpnpsFgbsFP1cj5EBNZN5KyMPKTTeTsqRbfUeuxInj8cjtZTqI23FUNj9bB3FoFW8LklZQts6yxQRiHzrhsof6ATsAPo6AcJkp6YsbYJJoWOg2L1h55PZ8VW5oxYl8DYVwef1ljDj3pd7XYIXex/zuqA2pIhVW43KaKQFGdbTB+UWYApJ8KPemBsWPJD8yoHPsbecKFHPAkhH/HCl1HNLQPg94LtKjWxDlkFuZAlzmPa0kWaPc/MI0l7O8dN4PfgqlW/1R+IyR6YXu1BsS6OkqOO2moE6LTH5VL1zUMk/95VqsO8Cn73TF+rhdVbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rVXMRkibz3NGDlyZik7urzdfxRLQoxrh6Vy3LpoA5P8=;
 b=p9OwHkppPaupYKbZ8M/TWtze0/tO4ZKNtq8BuWFaM2YM9c48aaWg1fgobYfF4MzBLccVI5SpjKBtsDon59sRP9oKthlDi3qlwzq5PYFOUuO3qGhiC6h6t7qnjKmyyPOLu7CCt+0snC6bUbCgkSXY/E0AeYChK+cBTr+3dhFjsjY=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PA2PR04MB10348.eurprd04.prod.outlook.com (2603:10a6:102:41d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 12:42:03 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7544.052; Mon, 13 May 2024
 12:42:03 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>, "Peng Fan (OSS)"
	<peng.fan@oss.nxp.com>, Abel Vesa <abelvesa@kernel.org>, Michael Turquette
	<mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Shawn Guo
	<shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
	Jacky Bai <ping.bai@nxp.com>, Ye Li <ye.li@nxp.com>, Aisheng Dong
	<aisheng.dong@nxp.com>
CC: "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Abel Vesa <abel.vesa@linaro.org>, "S.J. Wang"
	<shengjiu.wang@nxp.com>, Chancel Liu <chancel.liu@nxp.com>
Subject: RE: [PATCH v2 05/17] clk: imx: pll14xx: Add constraint for fvco
 frequency
Thread-Topic: [PATCH v2 05/17] clk: imx: pll14xx: Add constraint for fvco
 frequency
Thread-Index: AQHaoroMvImi844DX0SJs1FVr1w0MLGVHIwAgAADTNA=
Date: Mon, 13 May 2024 12:42:03 +0000
Message-ID:
 <DU0PR04MB9417C72E3558D576FDF8EF5588E22@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240510-imx-clk-v2-0-c998f315d29c@nxp.com>
 <20240510-imx-clk-v2-5-c998f315d29c@nxp.com>
 <2867ae55-ab4e-4a69-b24b-0535bc77ef31@prevas.dk>
In-Reply-To: <2867ae55-ab4e-4a69-b24b-0535bc77ef31@prevas.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|PA2PR04MB10348:EE_
x-ms-office365-filtering-correlation-id: da3d8174-f670-4cdd-c1e4-08dc734a176c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|376005|7416005|1800799015|366007|921011|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?TzlqdnpPaE1QU3hBQ2RVeE5pVXpCVXBnME5uNDMxcGNoMWx5T3c0WXFvYlVh?=
 =?utf-8?B?QjcvT1E2Y2R3N2p5TzN1bEtYVEdQT0xEVTk3ZExDaHNwOWxoYmRPZ0RLOFpQ?=
 =?utf-8?B?dmJSdUs4djJNbWFYK0l2QmFZQ2ZsM0I4dkYyVjIvdjRNMXQ3QkFEOGl3WWlT?=
 =?utf-8?B?emZIZHRKZUoxbzBTbWpHTGVmcEZGSGJSdzd3NWFHcktIYlc2UFpsN3ZBNFJi?=
 =?utf-8?B?WTJaQnFBbTJPT3RVaTh1cDZScTFHamtzME1lMlFxSHhtYkNpQXZ2cW9yZS9r?=
 =?utf-8?B?YVowV25hYzgxU01vZkZXZ0dpa2pQK0cxRTBEZm0vOWd3SzdrZmJva2JITjdC?=
 =?utf-8?B?d0dmdURrT3VPYWV5R0k3L0JJSkFld1pRSDBld1pRQVlFOHNlWkZkK1JxYjdM?=
 =?utf-8?B?ZEoxUUxUTWNGQnhKdkh1UklqYkN3VWd0dm9mblUrZ2dkWDRROU1ENWl3YmUy?=
 =?utf-8?B?c3JxOTByNXN4M0p0bSt4cFRURStacFN3aSt6dGRwcDVkNW1sc2Nlejkva3Za?=
 =?utf-8?B?MFdZRnhVOGRmUGNtdEtpb2EyK0F2TkxlU2ZRVUt3V2tqazNNM3B2TE55S0JD?=
 =?utf-8?B?Ny8wWDM3RVVvQVg4K0kzd1dHRmNoL3RqaEZ0ZnQ2eDcxaFF5d1BCeXNGdGkw?=
 =?utf-8?B?TnhDSTVVeG43U2hzVFRlL0tGVlZVQmpOTThuNVRwVWVqYllnYkNNVE45bnhm?=
 =?utf-8?B?K2JaS2R5VVI1MXVMclYwL2tWNTR4UjkwUXFMSEo2TzBxNnRnaW81eWxXUk8z?=
 =?utf-8?B?dWdHN29vWFl6NnVwbGxXa3dmalpIWlVSMTFwYnhuTjI1bVEzdEd5d21ub3Rr?=
 =?utf-8?B?d1ZlcERoRW1razU2OXArMXlrbVc5WitRWS81UFcwbHdaVDR6dmZUVWRKZ0xB?=
 =?utf-8?B?QmtyZUp4QmU3eFRmZE95Uzc4R2hKYTJWR3RFanMrMWs5ZmNMRFM4THhYSWFk?=
 =?utf-8?B?MzVibkR1SldGN21HOEpQOCtDYUhmMCtVMUFxQlRoMVpuN29kZFg5cU9nR1lw?=
 =?utf-8?B?ektPakcrWitObXJTRzNyMGd6OVRLT3p6aHFZOTVVYjNmanc4R2tWaUw0eVpD?=
 =?utf-8?B?ZlRmYmx6TzJROU9JUVpER0FJb1o1NzlBT1RuYWt0akR2cVFJbUo4T000TUJ0?=
 =?utf-8?B?V3g3MThLMjNNQVZCSk1UTGI0ZHRUY1JCa1c1WWUzL0VOSmV5UmZxZ1UzbDE2?=
 =?utf-8?B?T0xkVHlwamFwdnpvMk9JMkwrU1hIT0xveDZEVWZIYTlwS1hDUmgwZ3BzYjQw?=
 =?utf-8?B?dnRtdURHVXlzRnJxNW9JemZQZjRIMVVKSmRuMVIrU2FCOXZmZ0FhaSsxTXR3?=
 =?utf-8?B?SnFTSk9mQXdtYW4wV2NRb1VDQkRNVTdPR1BPK21MV2Vnbk1BeFMvYWluelp2?=
 =?utf-8?B?cm1oYUNaUlR3T3lML3FjZjRkS1U3QXhVcWVEaVVyS0lyMFNTdGZKbFdrempt?=
 =?utf-8?B?bHhwaUNBLzh0cldqL0xJdHZxQ0h2d243dUFmS0I1clZQbFFSQUJpaTJBZGxU?=
 =?utf-8?B?ZFNVbCs3bTZTUmFyRVE4QkdRcmhNUCtsY3M0ZllPdGFOekJKNjJ0T3JDRWxx?=
 =?utf-8?B?bFp0emloTTNzRXJBcFcwK1NwUnZMbXBtd2RpeElSOXJZL0xwd0NQVDJLZWlm?=
 =?utf-8?B?VDNwd3hobktFN1FGWTFDeGh0QzlaaHFzVVNJU3pKRlNFUTFHYkwwSEw1dm9L?=
 =?utf-8?B?TDJtMCszRUZ3RWwxR2ZQNTNLMFJMOTEwTFl4TWtZaE9YOTJrd3Zxcm8xVVlz?=
 =?utf-8?B?U0V1S240YUV3dVNpdXlkeXNCRG5Dc2c5YmlxNjhPb21lSkpHWXhyOWpKSnB0?=
 =?utf-8?B?Q2c3VGw3V28xT1l6QnE1QT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007)(921011)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cFhDYm9DNHpCdkxadnhTKzZQU0xqNjIrNDJXZFc0V1RuZzg2dUs4Z2x6Z1V0?=
 =?utf-8?B?VlJjdkw2NTVwUHp5eHlLLzI1bTRtL2lhY25wckJSeDFiYmYrS01zWVR6Sm9t?=
 =?utf-8?B?NTFxOC9Sc2I3NVZpTzYwT3d5ZUFRaEpTM2grak01RFpGcVdRTnRidDBEUktq?=
 =?utf-8?B?NWdWMUZTa1R1aGhGTGNDN1BjY3c1M1NzR05RQmZzSXo2TWFXQ2NST0htQ0lp?=
 =?utf-8?B?MXQ3ZDAwQ21Tb1psZUpoWk9KMWlJWWY2azhzdm9Beno5RUk2c3YzT1dJZzJT?=
 =?utf-8?B?UDU2OHNyVEdMQ3pvTFNDRWRXa1E5MlpVV1ZzRXhIR2tFSjhnYlNUc0RKQkp4?=
 =?utf-8?B?bHdxUWNkZ0dUN0RFVzQ3UllTaGwvcTQybkxNWnR2bFREZmFXN2NFYUFuRC9W?=
 =?utf-8?B?Z3lWck9rZlR5RzJJMk54cUYzWGF1YWF3MkJvUk9VY1hReUJLSHoweklSbE9p?=
 =?utf-8?B?Njdla21ERGFKM2RvaVVoV0tjRmpMR01VeStZZEVmZ1c2VHpiT2RIaGNqOFpS?=
 =?utf-8?B?WWNaR3JGc3pSYzFZeE0wSE85TmpubnlqdUZaM1VxaWdPTkpERFgvUFhLWXhJ?=
 =?utf-8?B?dDhuYk1VZ1VmOHp5cHcxd2lYMkYxNU93ZDJJenRQTjQ1MmcvWGhjWVJ2Wk5V?=
 =?utf-8?B?RnRYakNYZEs4RTBGK05ldS9heVIwRHZhVEVKbUViZCthMEdzekZlQTg4UXpr?=
 =?utf-8?B?TTBweUpnRUNlSm5SaXJmaDBKS1RGUmZ5V3JnaGRubllJZ0hQV05sS2lBakJS?=
 =?utf-8?B?Zi9McHIyOW9ROUZFelNnNVRCdGtabGFlNHNGdFdyOWhBQ2NORlRwOXFvWmdQ?=
 =?utf-8?B?K3Q0bUpsNkExQkF6ci82WVoyMWtDcXNOMTZ3U1dlRS8vS3dtaVE2WmFRQkhJ?=
 =?utf-8?B?S0FxRkl2ZVdHWlc1clpqeFcyQUNXTmR3dXNlcU14TDlhS3pSbW5JZ3JVL2pX?=
 =?utf-8?B?YTJkZmpoSTFkOUVMRUNvVk1QbXgrdzFFNmozb2U2RGVycy9KRGFNWG9sT3hB?=
 =?utf-8?B?Z0hRRi92VkdHanZvVXFyUUlQNU04M2c0Q05LbnZOZVBsV24wT0JYRWRub2NE?=
 =?utf-8?B?YXRjZytNQ3JyL1hOTkhJL0lvaHgzTHpSQXM3cU9lb3l1L0tBeUI2Y1pCMUhU?=
 =?utf-8?B?V0tqU3ZNTWNZU3VKai9ibjgrOENZdVpyNlRLcXpucGdJa1dMSTF5UGZpZ1p1?=
 =?utf-8?B?aEl6bUp1WWVpQ3pGaVp3K0VxUlVOYjdMa2pUdnR4L1dkZDFOMkRheTJrV29v?=
 =?utf-8?B?UWpTK29kZjNWY21iZDdocTE2Z1BLQnp3OWR5amVOWVdQbFJJMCtGTmpETWtr?=
 =?utf-8?B?Njc5Q1B0ZlQxeHQrWXlSRnJENDhOMnV0TWVPL1o2b1RYbjNPU3VZU1lIUjU4?=
 =?utf-8?B?M1pTVHl5K1ZoRnY4NnF3NWxxODFZc3JGL3ltc3RMd2JkZVhHVGlEL25BY29v?=
 =?utf-8?B?SWwyUFkvY2JTcFQzdHh0cG9DMDdYYWswbCtsYTdNTzdHT01KSHg3ZGkxNC90?=
 =?utf-8?B?NXdBeHIvVUgrczBWMHR5eENtU2JReTVKV2xVdmVUdVNRYXVjbWxBVStrZWps?=
 =?utf-8?B?VFVWeFF3STUwd0JoTURiajVmZ2NsWnE0Y2RrbXp0V212Ni9UaFJTc3pBM3Az?=
 =?utf-8?B?SCtGSzF4dGx1RHB2NGZSKzZFQ1VBdVRrOURWd3JVQnpiY2MxdUtuVDhjY3V2?=
 =?utf-8?B?OWNmQmp3ajlWVXNVbWRFbW9qckI2dVZmblZvTDlDQnRRbC9DQ1k5WHhyRmtE?=
 =?utf-8?B?emRCVzUxcndBeExUSHBnOTE5TnhrTXI0VlhpdnRZNVg2dUQxRm5Qb0FoZ1JI?=
 =?utf-8?B?VWRMUS9rRHJ5T0RiVk1QaGNVYjdOTGFGNzR2d0ZNZW9YNkxzeFNWYnplNWdO?=
 =?utf-8?B?WHdCM29YM04yd0JIU2s5K3ZmQkttUHFWOHhYdHdGOVVvYkFrWkF3K1BtcDdW?=
 =?utf-8?B?cHIwd0FXdisxbWdXRlBYSFhxSlB0QkhXb3NBVktYUVVHTkJMTEtJYm5rdWU3?=
 =?utf-8?B?clFQdFRaTWR2VDlab0FubDdnWjNSR2RtWVZrMjR4QUxTd2xCcFcvaGM5Uk9h?=
 =?utf-8?B?YVdLUW5UN2tTZGlXR2hqaWFmM3FUR3dOUk9yeUlsV01UVGttSTJmTzlQN0Y5?=
 =?utf-8?Q?CrjI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da3d8174-f670-4cdd-c1e4-08dc734a176c
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2024 12:42:03.7426
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nVsHcb85M0m7jvmW5gH78PbyL6VFuOMj0QDbmqocGh6CTRJ3POwV/KsHvPpKhElUBRmynsMK7AznuvHaDv+W9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10348

PiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIDA1LzE3XSBjbGs6IGlteDogcGxsMTR4eDogQWRkIGNv
bnN0cmFpbnQgZm9yIGZ2Y28NCj4gZnJlcXVlbmN5DQo+IA0KPiBPbiAxMC8wNS8yMDI0IDExLjE5
LCBQZW5nIEZhbiAoT1NTKSB3cm90ZToNCj4gPg0KPiA+IEFzbG8gY29ycmVjdCB0aGUgbmFtZSBm
b3IgZnZjbyBhbmQgZm91dCBjbG9jay4NCj4gDQo+IEJ0dy4sIHRoYXQgcGFydCBvZiB0aGUgY29t
bWl0IGxvZyBpcyBtaXNsZWFkaW5nLiBUaGUgcGF0Y2ggZG9lcyBubyBzdWNoIHRoaW5nLA0KPiBh
cyB0aGF0IHBhcnQgaXMgYWxyZWFkeSBkb25lIGluIGY1MmYwMDA2OTg4OCB0aGF0IHdlbnQgaW50
byB2Ni44Lg0KPiANCj4gUGxlYXNlIGRvbid0IG1pbmRsZXNzbHkgY2hlcnJ5LXBpY2sgc3R1ZmYg
ZnJvbSB0aGUgTlhQIGZvcmsgYW5kIGZpeHVwIHN0dWZmIHNvDQo+IGl0IGJ1aWxkcyBhbmQganVz
dCBpZ25vcmUgd2hldGhlciB0aGUgY29tbWl0IGxvZyBzdGlsbCBtYWtlcyBzZW5zZS4NCg0KTXkg
YmFkLiB3aWxsIGdvIHRocm91Z2ggdHJlZSBoaXN0b3J5IG5leHQgdGltZSBiZWZvcmUgcG9zdCB0
aGVzZS4NCg0KUmVnYXJkcywNClBlbmcuDQoNCj4gDQo+IFJhc211cw0KDQo=


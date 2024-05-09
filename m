Return-Path: <linux-kernel+bounces-174414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6988D8C0E66
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 12:47:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0621B233DB
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 10:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3691149E0B;
	Thu,  9 May 2024 10:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="be4/6d/A"
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2134.outbound.protection.outlook.com [40.107.13.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C0B131723;
	Thu,  9 May 2024 10:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.13.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715251587; cv=fail; b=G2vhNKVvHR0RGRP3fkrwYaULg/Yt4xKgFtMixPSq5k7pjqalDszuRhNzov0xAEDnS768kDTJFjSlv0etKKOFRwP87BAXknIezEYgApCNM840wqR409yJT9e8NaUMvfa8vmmtQSziccxOQXLhbXVK9ZQhLaxnfyQCj4SoV3tn+2w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715251587; c=relaxed/simple;
	bh=HJ1tXtqHGkSbvzhquIQocuR/CsjrNg/NSuhddS10sVk=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=MexxABB8RyTT7ndbHhHtEK9cJnS9wf6gJK7pKZjZUKbL8KZCtkOoK4V0xAaPmpbVXPIsOx7TU/0TLdWZF3hpg5SWBHRVcLGuBJYiZMuhTUAMw45mgzaP27TlDON3p0xoDzgOVWF51lEhaVhSp/s36kKwxF5OOTW06w5VD6OVTyM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=be4/6d/A; arc=fail smtp.client-ip=40.107.13.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U6Ya4rl5m37gECso5dVOQ/RKbMPjlA6cC8PfA4lJK6lD1c5BaoDBJTMsqGWjYTf6PqWHw1WKnv42bu7J9d5Ingy40UCwYoy6wIsEOXnqG//BkFNeqElY1bmKVOOkui0em2rx82iCGOfr90lwBCeUgj3RZhle67ol+iU583lsJnQ4DQVM1qiSF3TSp+kFOWAyYXWp8MTSvW+I2eZ+8Vv2Ia4kyLxkGuawON0xRTXswJgDLeTNaUqdOKY0i73jusm0npbRmW6OjWdupMtpxJ45SlJ33fPYfQQGh629UpLhtnKTAj8cW/IuxH5ByPLv/+zjaopFUXAE/KwRY4/PfTCRBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8hyYmoNGGsx0t83zxzNRt5wI/CGEJXhYf5ckVHqG0Wc=;
 b=l8xjp86ricIm2W5F2MgmHgjDJ7LanCumjTMZTK4N0xs/RzKmfgXq0nijaWGF2PUXEqwhhprhai3a+EEtDZqP0EzOQpbQz3o1xL2MvZwoWQezMXu0kQiMN00tzXp6Mpj7GGVJss0BL9p6bKquqOc3q3h4cKXL2BrYt2mReRoA1qrO+rLsJvCklcGQCZb3w4b/k7dQzKCLrMKaR97hC3dPuRoPgau2R9NCkeL+v0AaUcnp7Sn6aqlPDbu9aBH4Ekg7qcaGszS1TI9uHjTJL3SidZzIqwwa/7uwMP3Nlc3suY/+ado77KxwWXAHJ7Yiee6XoDfszZ9yxJxyRrijPAFcgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8hyYmoNGGsx0t83zxzNRt5wI/CGEJXhYf5ckVHqG0Wc=;
 b=be4/6d/A3lRxnj5s+FnFrpG4SvrlcfaJOJiUsBAPYcCJ80JzLd5GcCXwRVtW4pVaJ0NIaVZzpw58BgUTHwlQD+6S/dd1GGA495P7xnpXUT5gEyhOVyxhHd1GWtbOHiqkgabpRyaKDgScc+q0aFRPZUXS1p5YM6kc0fG1bJoyJ5M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by DBBPR04MB7612.eurprd04.prod.outlook.com (2603:10a6:10:202::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.47; Thu, 9 May
 2024 10:46:12 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529%7]) with mapi id 15.20.7544.045; Thu, 9 May 2024
 10:46:12 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Thu, 09 May 2024 12:46:08 +0200
Subject: [PATCH v5 4/4] arm64: dts: add description for solidrun cn9131
 solidwan board
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240509-cn9130-som-v5-4-95493eb5c79d@solid-run.com>
References: <20240509-cn9130-som-v5-0-95493eb5c79d@solid-run.com>
In-Reply-To: <20240509-cn9130-som-v5-0-95493eb5c79d@solid-run.com>
To: Andrew Lunn <andrew@lunn.ch>, 
 Gregory Clement <gregory.clement@bootlin.com>, 
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>
Cc: Yazan Shhady <yazan.shhady@solid-run.com>, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Josua Mayer <josua@solid-run.com>
X-Mailer: b4 0.12.4
X-ClientProxiedBy: FR0P281CA0092.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::13) To AM9PR04MB7586.eurprd04.prod.outlook.com
 (2603:10a6:20b:2d5::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB7586:EE_|DBBPR04MB7612:EE_
X-MS-Office365-Filtering-Correlation-Id: cb697dc5-5354-4f7a-2f55-08dc70153e24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|52116005|376005|7416005|1800799015|366007|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VVhuNVFReWlmUTJBMm9naE9YRjgyN212Zmt4ME9ySXdpS1N1a01sQVY5dmhU?=
 =?utf-8?B?YzdPWnRRM1lKZWljM0UzcmhiS2x6QjlZakZaSENjaXdDZUZhOGc3czFCL0Vs?=
 =?utf-8?B?TGRaRjVObXFJNFZlWE9GU05FbUpua2JGeU12OEEvL1ZsTlZkRjdjUmhyTzU3?=
 =?utf-8?B?Sml3UEVDUzRnT3huVnRHVlhHdENWQVVDWlR6eXhvL3kzMm1qQjZkVjJCbE5o?=
 =?utf-8?B?Y25SN3drOHFDamdDWU1aeHNzU0sxRllMczJndU1BUHV6VnRjb3FRTDNkWjZw?=
 =?utf-8?B?MFVaVnZEckIxUlBUMTljM1UxYzdCdzFOWXZXOXArbGx2amZoZ3pHV3ZvWlVY?=
 =?utf-8?B?dHJjbXlFaDNGT21GY2s3a2oza2I5eFd6MGZOQ3ppSUZnbklpZHJZSUxhTS9G?=
 =?utf-8?B?Vmk1Z0YxNWFwSTJEZXFxSlFzSHpTRlVvVEdBZ2xXSWQ0cUl2T0hBN0xSeVQ4?=
 =?utf-8?B?VFNzTmo5V1haWU1nWVJ5TUhoSmVHK0ZSbCs1bW1admZBenF1TEJzUjQ5Qk5W?=
 =?utf-8?B?K1VseUR5bXl6bnFhNlFhdXREeUZtOGdOVVlJSGZ1VUtZVnJmbStieUY1VGto?=
 =?utf-8?B?dWNtVzhXY0MrOUlrdHV6d0xjWmxvRWtRWWVHWWxXOFY1NU9iTU5QWEt3bWkr?=
 =?utf-8?B?TzJ5UkNUWnNEdm14aldRWm1GRjVjUmpndlVlVTllZkV0dFV0cUU3UFl1N3Rv?=
 =?utf-8?B?R0VURk1aNjZ2N2k2M3JuSFh1QVVDaXJMZ2RxK2h0NStWR2c0dXVzdGErMUJm?=
 =?utf-8?B?VEtKd3BDNUV0QVIxbHAwK0R3dktxMXRscHFKeFBGYXAzcklBM29ZTExrN2ZN?=
 =?utf-8?B?SlduVk1xakt2VzNhQ0R4dldDMW1SeVB1RlBXUnVFWWFNelhaL09SdTBuMklE?=
 =?utf-8?B?S2J6TmR1M1I1a0ROVWhFZDdXZW96N1BQOXNkSmFmcDB6b1BUaGwydWhpWjg4?=
 =?utf-8?B?dFRlOTg0b2ZnakV5SlFNQWVZdTQrQ3hsZEk3Q2N0Z09pV3laTXA4TkhUbndx?=
 =?utf-8?B?dnRiRTNOdjIwdHVTRlRkWnVpL2JrYk9EZytOdlYyRVRaazVTV2pQYjdjUVdy?=
 =?utf-8?B?UXNlS3ZmZGRNY2JXZW9CWHF2T1BCMHNjMzNGZGFrbmpYK25tUmpKN0FJdU5L?=
 =?utf-8?B?QXYydDJUMDFRaFFEeFBhRC82Wnl1cWQyOVYxVkZtaXBsdEd5RUxNejM0ODVV?=
 =?utf-8?B?c0thTEh3YXY3ZStpTFI3djdUb3dlS1gwRXB2dk11MmNHRXJHYjFvcSsyRjlh?=
 =?utf-8?B?dFZNdTdsdUgvRFB1b1VUbjRublhraUtCMXRFdGJjNmZYR2tqR1NWQVloODJL?=
 =?utf-8?B?MW91Wk9yRUx1cVRvKzBWV3B1YUN5aVprWWpobEY0K3UzbmlYdmdZWVhOd3ZM?=
 =?utf-8?B?a2hQdE1mY3doS2lKbml2ZjZpV0lkWnB0YTVmV0dQQXJwUXdWbVhRRnpIQ0kx?=
 =?utf-8?B?Mkd1N0FmNnZacHl3eUFjcDlzWEZLODltd3laQWFhRUhFRnNZWG5SNjBRTG9y?=
 =?utf-8?B?d3g1QXMycDZRWi9Kc3BBcDlrR3BqdDZudEU2NzV2MzcxVkN2c0NPbXBCZFJ3?=
 =?utf-8?B?YzVCbGdlc2IzVFJpcVZDcmZkQldNMU93WmdBdmdNSzZNY3VTdDV2dUNLSDUy?=
 =?utf-8?B?YkR1R3k5bWF6SldiOUNsWFBWeit4aHNjVVZ0QzJDOWZYdDBlcitCVzZSdmEw?=
 =?utf-8?B?M3dmUzhKUlFVNEZuUGxqanVvWURHcDJZQ1N6Mlpta2F1UThXaGRUbnJDalFH?=
 =?utf-8?B?VWV4L1NHYVZOeEhrN05DRy9rM1ovZUNFUmtxZzVhbzdQM3ZEVG43Ly9YOVlN?=
 =?utf-8?B?TU1CcWRlRXVpbG9SRkh6UT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(376005)(7416005)(1800799015)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YlV5cGg5elhGY1ZyZ0djNkNYUzQxWDBhcEdNKzZ6bXNja3lvckpkUGlrN0FO?=
 =?utf-8?B?S1lNdlFmVWpYcGJneENHeDh1NThVbVBrUklleWNtRlRnT1dZTCtaTWlYMEwz?=
 =?utf-8?B?UlBIcVVINkFyZ0tBNXBaVHMxZmUzUnVpOU9tLzZGaVRmOFBGSklUazNaNGNy?=
 =?utf-8?B?VlBpTXUzUzlkd2FNOG1jNStUN0ZaUHRIVVRUNUNsTEtRU1k1TGsycUt5MS9i?=
 =?utf-8?B?Q1ZEeG9tQ3c3bFFtMHk2ako5VDhHTmlUSkFBSE9LaDRyWFhJUWMxQjFUc011?=
 =?utf-8?B?Q0xPMjBiaFVoa294ZGJYbVdIVnlNN2R3L0xxS3lhQ0h0NWMyN1ZPd3M5SjZX?=
 =?utf-8?B?VzhYOGtlaHEvMWVudk9zSmh1R1h4dC9KWEk0NWRhaWl0aEJ2TWYzMVlCZE96?=
 =?utf-8?B?bUVYUnJxZy91a0wvTVh0bFFwUEdFb0Y0NEpubDZhLzYwUStCMSs1QUIwUTNQ?=
 =?utf-8?B?bGhKdW5Uak93ZTVoNVRvRmEveU5vVFJueTlLeHFrb1ZtUyttWVNpbnUyTHc0?=
 =?utf-8?B?RGpiUnlqOENWOGlGdzltRUxqWFM2V2kvRVV2UGFGYmRTZkpUTEcreEVwUlV3?=
 =?utf-8?B?TG5ZK1hPLytUbGZJOVYvRXBXbXRZam9HMmt3cCtDL2pacTFFaytPWERSUUFH?=
 =?utf-8?B?VGxlcmwvdm9lV1o5WlRDTlRQK3pTZE5icEdSOVBOL2VxcFJpWlVUbm03THNr?=
 =?utf-8?B?OVRJNVcwalNjdXNJK1hVZ1BpaVZBU1Q2dDdSekErS2gyQXBIREFiekVId3d4?=
 =?utf-8?B?K3FyV1VTUEdTZHVjTEhrNkJQVHgzbXIzYzdyZHZxTmEyb3l4KzV5SjZseTFx?=
 =?utf-8?B?aGhXUWJ6VkhOQ0p6T2U0dnhYVVRreCt3TGlIWFpyZ3ZxWEN4aG9BK1F6VGdJ?=
 =?utf-8?B?NmFlb0ZYeTVUWFdJYm00a25zRld5cVE1eVNtNkxsVlpmMVpRVDlRcWNNNk9I?=
 =?utf-8?B?R3oyaTZLSHB0eTk3YnlDZ0ZrWDAvV3JrUGNiZmhaNmxYOFFZV2tXV0VDeURF?=
 =?utf-8?B?VmVQanJDYUJLRUI3ZEhURVhaQWdaTVFtMUROZHhPcEhwb1lxVXlFTzRMWFZ4?=
 =?utf-8?B?ZktpUXRNbjgva3k1YWlzTGhBVnpvdWVlaEJMTFMvdlA4Y3U2RDNUTXhpWW1Y?=
 =?utf-8?B?MnZ2N053dkNIZ0JzZit5ZTdiM2NFdlA4SmJ5VXhVTnNhOFJZd0xPZDJkVFNj?=
 =?utf-8?B?U1VIZzFHY3JsV2tRTEl2S3ZJN0xSbkFiZDVXbjVJN3Y1VUJjVkIxUDRMSE1E?=
 =?utf-8?B?bTR6YlY0dWg1NXRMM3lYNmxaNGl1WXJ5Ym9Ocmh2RVBqdzAwNHVOdFlHeEVU?=
 =?utf-8?B?cms0Mm9LbUtTYW9FazFIS3BGVVgzajg3YUJZZFh6cXRzU2tIcW5jQ3FodXhh?=
 =?utf-8?B?SXlvVEFSNTA5emNYc0F0d3Myb21DSEdXWHpFbkdiajhaYktPTlFnbUtCOElB?=
 =?utf-8?B?OWpOZHRHVHVYT2xVY0RTbVJSajN1RlJIbGRURVJMQlBaOVUxSnhlUGJLZTZm?=
 =?utf-8?B?REluYk9SSzhsdkNRRUJPSWRhTHJ2bXJWbnpRdTlNRWtRV0dUV2lqTkpmakZH?=
 =?utf-8?B?Mk05d1NmaENoTHFaS0plL0NpTnJTQ0l6amxXMWM0T0lTaWZyTDBIaXIxM2NY?=
 =?utf-8?B?SU1mT0RXTmNmbXBFVUszSTlqTy9DMGlzS29tVEVPbkc1T1ZlRzBWbjRCaVI2?=
 =?utf-8?B?RXltWjcveG5CaU5pUzlHczc2eGJkTWQ1dm12SGhxVTFFeGJqZ0ZNRHhvbUZk?=
 =?utf-8?B?dVJKTWVmQ1hYL0pnWFZFdXlOaU9VSUNSZWhoZlNOdks5OXNZMk1NUWM1NnFh?=
 =?utf-8?B?UkhNOWVkUkZVdG52eXNGVEU4NXBqMmFrUnNFUjk0bGI1Um1nYy81VW1rNmZI?=
 =?utf-8?B?KzhHeG9xbTJtVmlpSnVQdHV3Um9zTTlDbERndGlxckhiS0Y0N2NyMldsRm1I?=
 =?utf-8?B?ZHhCdWR3NVM2bjZwL2hrMk9kRWdHTmZFeS9jRGlTT0phTmwvREc4U2dwNUNG?=
 =?utf-8?B?WjlkMStWQU1MbS9lY0U5eFVLWktENEdUU0xxVk0xdzBjTk5pMmxOUGhMaFh2?=
 =?utf-8?B?eGFjaEJsakhiL2V2V2Q2YlM3TDlScHZWKzJUb2pVL0J5R2JqTTBlNktpWHVw?=
 =?utf-8?Q?WxFCEMlYNvkqQMrhOd70c9ZEU?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb697dc5-5354-4f7a-2f55-08dc70153e24
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2024 10:46:11.9637
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K2XcfP8vB3FAxzrvuupwKd5RtyKtukRCtH+Q3AI+9Ankyb441cH2EYp3Us7cYU0Sr+B0uPCqcHRR5MmhOf/PQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7612

Add description for the SolidRun CN9131 SolidWAN, based on CN9130 SoM
with an extra communication  processor on the carrier board.

This board differentiates itself from CN9130 Clearfog by providing
additional SoC native network interfaces and pci buses:
2x 10Gbps SFP+
4x 1Gbps RJ45
1x miniPCI-E
1x m.2 b-key with sata, usb-2.0 and usb-3.0
1x m.2 m-key with pcie and usb-2.0
1x m.2 b-key with pcie, usb-2.0, usb-3.0 and 2x sim slots
1x mpcie with pcie only
2x type-a usb-2.0/3.0

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 arch/arm64/boot/dts/marvell/Makefile               |   1 +
 arch/arm64/boot/dts/marvell/cn9131-cf-solidwan.dts | 641 +++++++++++++++++++++
 2 files changed, 642 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/Makefile b/arch/arm64/boot/dts/marvell/Makefile
index 019f2251d696..16f9d7156d9f 100644
--- a/arch/arm64/boot/dts/marvell/Makefile
+++ b/arch/arm64/boot/dts/marvell/Makefile
@@ -30,3 +30,4 @@ dtb-$(CONFIG_ARCH_MVEBU) += ac5x-rd-carrier-cn9131.dtb
 dtb-$(CONFIG_ARCH_MVEBU) += ac5-98dx35xx-rd.dtb
 dtb-$(CONFIG_ARCH_MVEBU) += cn9130-cf-base.dtb
 dtb-$(CONFIG_ARCH_MVEBU) += cn9130-cf-pro.dtb
+dtb-$(CONFIG_ARCH_MVEBU) += cn9131-cf-solidwan.dtb
diff --git a/arch/arm64/boot/dts/marvell/cn9131-cf-solidwan.dts b/arch/arm64/boot/dts/marvell/cn9131-cf-solidwan.dts
new file mode 100644
index 000000000000..f41e5dd22c7e
--- /dev/null
+++ b/arch/arm64/boot/dts/marvell/cn9131-cf-solidwan.dts
@@ -0,0 +1,641 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2024 Josua Mayer <josua@solid-run.com>
+ *
+ * DTS for SolidRun CN9130 Clearfog Base.
+ *
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/leds/common.h>
+
+#include "cn9130.dtsi"
+#include "cn9130-sr-som.dtsi"
+
+/*
+ * Instantiate the external CP115
+ */
+
+#define CP11X_NAME		cp1
+#define CP11X_BASE		f4000000
+#define CP11X_PCIEx_MEM_BASE(iface) (0xe2000000 + (iface * 0x1000000))
+#define CP11X_PCIEx_MEM_SIZE(iface) 0xf00000
+#define CP11X_PCIE0_BASE	f4600000
+#define CP11X_PCIE1_BASE	f4620000
+#define CP11X_PCIE2_BASE	f4640000
+
+#include "armada-cp115.dtsi"
+
+#undef CP11X_NAME
+#undef CP11X_BASE
+#undef CP11X_PCIEx_MEM_BASE
+#undef CP11X_PCIEx_MEM_SIZE
+#undef CP11X_PCIE0_BASE
+#undef CP11X_PCIE1_BASE
+#undef CP11X_PCIE2_BASE
+
+/ {
+	model = "SolidRun CN9131 SolidWAN";
+	compatible = "solidrun,cn9131-solidwan",
+		     "solidrun,cn9130-sr-som", "marvell,cn9130";
+
+	aliases {
+		ethernet0 = &cp1_eth1;
+		ethernet1 = &cp1_eth2;
+		ethernet2 = &cp0_eth1;
+		ethernet3 = &cp0_eth2;
+		ethernet4 = &cp0_eth0;
+		ethernet5 = &cp1_eth0;
+		gpio0 = &ap_gpio;
+		gpio1 = &cp0_gpio1;
+		gpio2 = &cp0_gpio2;
+		gpio3 = &cp1_gpio1;
+		gpio4 = &cp1_gpio2;
+		gpio5 = &expander0;
+		i2c0 = &cp0_i2c0;
+		i2c1 = &cp0_i2c1;
+		i2c2 = &cp1_i2c1;
+		mmc0 = &ap_sdhci0;
+		mmc1 = &cp0_sdhci0;
+		rtc0 = &cp0_rtc;
+		rtc1 = &carrier_rtc;
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&cp0_led_pins &cp1_led_pins>;
+
+		/* for sfp-1 (J42) */
+		led-sfp1-activity {
+			label = "sfp1:green";
+			gpios = <&cp0_gpio1 7 GPIO_ACTIVE_HIGH>;
+		};
+
+		/* for sfp-1 (J42) */
+		led-sfp1-link {
+			label = "sfp1:yellow";
+			gpios = <&cp0_gpio1 4 GPIO_ACTIVE_HIGH>;
+		};
+
+		/* (J28) */
+		led-sfp0-activity {
+			label = "sfp0:green";
+			gpios = <&cp1_gpio2 22 GPIO_ACTIVE_HIGH>;
+		};
+
+		/* (J28) */
+		led-sfp0-link {
+			label = "sfp0:yellow";
+			gpios = <&cp1_gpio2 23 GPIO_ACTIVE_HIGH>;
+		};
+	};
+
+	/* Type-A port on J53 */
+	reg_usb_a_vbus0: regulator-usb-a-vbus0 {
+		compatible = "regulator-fixed";
+		pinctrl-0 = <&cp0_reg_usb_a_vbus0_pins>;
+		pinctrl-names = "default";
+		regulator-name = "vbus0";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpios = <&cp0_gpio1 27 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		regulator-always-on;
+	};
+
+	reg_usb_a_vbus1: regulator-usb-a-vbus1 {
+		compatible = "regulator-fixed";
+		pinctrl-0 = <&cp0_reg_usb_a_vbus1_pins>;
+		pinctrl-names = "default";
+		regulator-name = "vbus1";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpios = <&cp0_gpio1 28 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		regulator-always-on;
+	};
+
+	sfp0: sfp-0 {
+		compatible = "sff,sfp";
+		pinctrl-0 = <&cp0_sfp0_pins>;
+		pinctrl-names = "default";
+		i2c-bus = <&cp0_i2c1>;
+		los-gpios = <&cp0_gpio2 2 GPIO_ACTIVE_HIGH>;
+		mod-def0-gpios = <&cp0_gpio2 0 GPIO_ACTIVE_LOW>;
+		tx-disable-gpios = <&cp0_gpio2 1 GPIO_ACTIVE_HIGH>;
+		tx-fault-gpios = <&cp0_gpio1 31 GPIO_ACTIVE_HIGH>;
+		maximum-power-milliwatt = <2000>;
+	};
+
+	sfp1: sfp-1 {
+		compatible = "sff,sfp";
+		pinctrl-0 = <&cp1_sfp1_pins>;
+		pinctrl-names = "default";
+		i2c-bus = <&cp1_i2c1>;
+		los-gpios = <&cp1_gpio2 2 GPIO_ACTIVE_HIGH>;
+		mod-def0-gpios = <&cp1_gpio2 18 GPIO_ACTIVE_LOW>;
+		tx-disable-gpios = <&cp1_gpio2 1 GPIO_ACTIVE_HIGH>;
+		tx-fault-gpios = <&cp1_gpio2 17 GPIO_ACTIVE_HIGH>;
+		maximum-power-milliwatt = <2000>;
+	};
+};
+
+&cp0_ethernet {
+	status = "okay";
+};
+
+/* SRDS #2 - SFP+ 10GE */
+&cp0_eth0 {
+	managed = "in-band-status";
+	phy-mode = "10gbase-r";
+	phys = <&cp0_comphy2 0>;
+	sfp = <&sfp0>;
+	status = "okay";
+};
+
+/* SRDS #3 - SGMII 1GE */
+&cp0_eth1 {
+	managed = "in-band-status";
+	phy-mode = "sgmii";
+	/* Without mdio phy access rely on sgmii auto-negotiation. */
+	phys = <&cp0_comphy3 1>;
+	status = "okay";
+};
+
+/* SRDS #1 - SGMII */
+&cp0_eth2 {
+	/delete-property/ pinctrl-0;
+	/delete-property/ pinctrl-names;
+	managed = "in-band-status";
+	phy-mode = "sgmii";
+	phy = <&cp0_phy1>;
+	phys = <&cp0_comphy1 2>;
+};
+
+&cp0_gpio1 {
+	pcie0-0-w-disable-hog {
+		gpio-hog;
+		gpios = <6 GPIO_ACTIVE_LOW>;
+		output-low;
+		line-name = "pcie0.0-w-disable";
+	};
+
+	/* J34 */
+	m2-full-card-power-off-hog {
+		gpio-hog;
+		gpios = <8 GPIO_ACTIVE_LOW>;
+		output-low;
+		line-name = "m2-full-card-power-off";
+	};
+};
+
+&cp0_i2c0 {
+	/* assembly option */
+	fan-controller@18 {
+		compatible = "ti,amc6821";
+		reg = <0x18>;
+	};
+
+	expander0: gpio@41 {
+		compatible = "nxp,pca9536";
+		reg = <0x41>;
+
+		usb-a-vbus0-ilimit-hog {
+			gpio-hog;
+			gpios = <0 GPIO_ACTIVE_LOW>;
+			input;
+			line-name = "vbus0-ilimit";
+		};
+
+		/* duplicate connection, controlled by soc gpio */
+		usb-vbus0-enable-hog {
+			gpio-hog;
+			gpios = <1 GPIO_ACTIVE_HIGH>;
+			input;
+			line-name = "vbus0-enable";
+		};
+
+		usb-a-vbus1-ilimit-hog {
+			gpio-hog;
+			gpios = <2 GPIO_ACTIVE_LOW>;
+			input;
+			line-name = "vbus1-ilimit";
+		};
+
+		/* duplicate connection, controlled by soc gpio */
+		usb-vbus1-enable-hog {
+			gpio-hog;
+			gpios = <3 GPIO_ACTIVE_HIGH>;
+			input;
+			line-name = "vbus1-enable";
+		};
+	};
+
+	carrier_eeprom: eeprom@52 {
+		compatible = "atmel,24c02";
+		reg = <0x52>;
+		pagesize = <8>;
+	};
+
+	/* usb-hub@60 */
+
+	/* assembly option */
+	carrier_rtc: rtc@68 {
+		compatible = "st,m41t83";
+		reg = <0x68>;
+		pinctrl-0 = <&cp1_rtc_pins>;
+		pinctrl-names = "default";
+		interrupt-parent = <&cp1_gpio1>;
+		interrupts = <12 IRQ_TYPE_EDGE_FALLING>;
+		reset-gpios = <&cp1_gpio1 13 GPIO_ACTIVE_LOW>;
+	};
+};
+
+&cp0_i2c1 {
+	/*
+	 * Routed to SFP.
+	 * Limit to 100kHz for compatibility with SFP modules,
+	 * featuring AT24C01A/02/04 at addresses 0x50/0x51.
+	 */
+	clock-frequency = <100000>;
+	pinctrl-0 = <&cp0_i2c1_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&cp0_mdio {
+	/*
+	 * SoM + Carrier each have a PHY at address 0.
+	 * Remove the SoM phy node, and skip adding the carrier node.
+	 * SGMII Auto-Negotation is enabled by bootloader for
+	 * autonomous operation without mdio control.
+	 */
+	/delete-node/ ethernet-phy@0;
+
+	/* U17016 */
+	cp0_phy1: ethernet-phy@1 {
+		reg = <1>;
+		/*
+		 * Configure LEDs default behaviour:
+		 * - LED[0]: link is 1000Mbps: On (yellow)
+		 * - LED[1]: link/activity: On/blink (green)
+		 * - LED[2]: high impedance (floating)
+		 */
+		marvell,reg-init = <3 16 0xf000 0x0a17>;
+
+		leds {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			led@0 {
+				reg = <0>;
+				color = <LED_COLOR_ID_YELLOW>;
+				function = LED_FUNCTION_LAN;
+				default-state = "keep";
+			};
+
+			led@1 {
+				reg = <1>;
+				color = <LED_COLOR_ID_GREEN>;
+				function = LED_FUNCTION_LAN;
+				default-state = "keep";
+			};
+		};
+	};
+};
+
+/* SRDS #0 - miniPCIe */
+&cp0_pcie0 {
+	num-lanes = <1>;
+	phys = <&cp0_comphy0 0>;
+	status = "okay";
+};
+
+/* SRDS #5 - M.2 B-Key (J34) */
+&cp0_pcie2 {
+	num-lanes = <1>;
+	phys = <&cp0_comphy5 2>;
+	status = "okay";
+};
+
+&cp0_pinctrl {
+	pinctrl-0 = <&cp0_m2_0_shutdown_pins &cp0_mpcie_rfkill_pins>;
+	pinctrl-names = "default";
+
+	cp0_i2c1_pins: cp0-i2c1-pins {
+		marvell,pins = "mpp35", "mpp36";
+		marvell,function = "i2c1";
+	};
+
+	cp0_led_pins: cp0-led-pins {
+		marvell,pins = "mpp4", "mpp7";
+		marvell,function = "gpio";
+	};
+
+	cp0_m2_0_shutdown_pins: cp0-m2-0-shutdown-pins {
+		marvell,pins = "mpp8";
+		marvell,function = "gpio";
+	};
+
+	cp0_mmc0_pins: cp0-mmc0-pins {
+		marvell,pins = "mpp43", "mpp56", "mpp57", "mpp58",
+			       "mpp59", "mpp60", "mpp61";
+		marvell,function = "sdio";
+	};
+
+	cp0_mpcie_rfkill_pins: cp0-mpcie-rfkill-pins {
+		marvell,pins = "mpp6";
+		marvell,function = "gpio";
+	};
+
+	cp0_reg_usb_a_vbus0_pins: cp0-reg-usb-a-vbus0-pins {
+		marvell,pins = "mpp27";
+		marvell,function = "gpio";
+	};
+
+	cp0_reg_usb_a_vbus1_pins: cp0-reg-usb-a-vbus1-pins {
+		marvell,pins = "mpp28";
+		marvell,function = "gpio";
+	};
+
+	cp0_sfp0_pins: cp0-sfp0-pins {
+		marvell,pins = "mpp31", "mpp32", "mpp33", "mpp34";
+		marvell,function = "gpio";
+	};
+
+	cp0_spi1_cs1_pins: cp0-spi1-cs1-pins {
+		marvell,pins = "mpp12";
+		marvell,function = "spi1";
+	};
+};
+
+/* microSD */
+&cp0_sdhci0 {
+	pinctrl-0 = <&cp0_mmc0_pins>;
+	pinctrl-names = "default";
+	bus-width = <4>;
+	no-1-8-v;
+	status = "okay";
+};
+
+&cp0_spi1 {
+	/* add pin for chip-select 1 */
+	pinctrl-0 = <&cp0_spi1_pins &cp0_spi1_cs1_pins>;
+
+	flash@1 {
+		compatible = "jedec,spi-nor";
+		reg = <1>;
+		/* read command supports max. 50MHz */
+		spi-max-frequency = <50000000>;
+	};
+};
+
+/* USB-2.0 Host to USB-Hub */
+&cp0_usb3_0 {
+	phys = <&cp0_utmi0>;
+	phy-names = "utmi";
+	dr_mode = "host";
+	status = "okay";
+};
+
+/* SRDS #4 - USB-3.0 Host to USB-Hub */
+&cp0_usb3_1 {
+	phys = <&cp0_comphy4 1>, <&cp0_utmi1>;
+	phy-names = "comphy", "utmi";
+	dr_mode = "host";
+	status = "okay";
+};
+
+&cp0_utmi {
+	status = "okay";
+};
+
+&cp0_utmi {
+	status = "okay";
+};
+
+&cp0_utmi1 {
+	status = "disabled";
+};
+
+&cp1_ethernet {
+	status = "okay";
+};
+
+/* SRDS #4 - SFP+ 10GE */
+&cp1_eth0 {
+	managed = "in-band-status";
+	phy-mode = "10gbase-r";
+	phys = <&cp1_comphy4 0>;
+	sfp = <&sfp1>;
+	status = "okay";
+};
+
+/* SRDS #3 - SGMII 1GE */
+&cp1_eth1 {
+	managed = "in-band-status";
+	phy-mode = "sgmii";
+	phy = <&cp1_phy0>;
+	phys = <&cp0_comphy3 1>;
+	status = "okay";
+};
+
+/* SRDS #5 - SGMII 1GE */
+&cp1_eth2 {
+	managed = "in-band-status";
+	phy-mode = "sgmii";
+	phy = <&cp1_phy1>;
+	phys = <&cp0_comphy5 2>;
+	status = "okay";
+};
+
+&cp1_gpio1 {
+	status = "okay";
+
+	/* J30 */
+	m2-full-card-power-off-hog-0 {
+		gpio-hog;
+		gpios = <29 GPIO_ACTIVE_LOW>;
+		output-low;
+		line-name = "m2-full-card-power-off";
+	};
+
+	/* J44 */
+	m2-full-card-power-off-hog-1 {
+		gpio-hog;
+		gpios = <30 GPIO_ACTIVE_LOW>;
+		output-low;
+		line-name = "m2-full-card-power-off";
+	};
+};
+
+&cp1_gpio2 {
+	status = "okay";
+};
+
+&cp1_i2c1 {
+	/*
+	 * Routed to SFP.
+	 * Limit to 100kHz for compatibility with SFP modules,
+	 * featuring AT24C01A/02/04 at addresses 0x50/0x51.
+	 */
+	clock-frequency = <100000>;
+	pinctrl-0 = <&cp1_i2c1_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&cp1_mdio {
+	pinctrl-0 = <&cp1_mdio_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	cp1_phy0: ethernet-phy@0 {
+		reg = <0>;
+		/*
+		 * Configure LEDs default behaviour:
+		 * - LED[0]: link is 1000Mbps: On (yellow)
+		 * - LED[1]: link/activity: On/blink (green)
+		 * - LED[2]: high impedance (floating)
+		 */
+		marvell,reg-init = <3 16 0xf000 0x0a17>;
+
+		leds {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			led@0 {
+				reg = <0>;
+				color = <LED_COLOR_ID_YELLOW>;
+				function = LED_FUNCTION_LAN;
+				default-state = "keep";
+			};
+
+			led@1 {
+				reg = <1>;
+				color = <LED_COLOR_ID_GREEN>;
+				function = LED_FUNCTION_LAN;
+				default-state = "keep";
+			};
+		};
+	};
+
+	cp1_phy1: ethernet-phy@1 {
+		reg = <1>;
+		/*
+		 * Configure LEDs default behaviour:
+		 * - LED[0]: link is 1000Mbps: On (yellow)
+		 * - LED[1]: link/activity: On/blink (green)
+		 * - LED[2]: high impedance (floating)
+		 */
+		marvell,reg-init = <3 16 0xf000 0x0a17>;
+
+		leds {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			led@0 {
+				reg = <0>;
+				color = <LED_COLOR_ID_YELLOW>;
+				function = LED_FUNCTION_LAN;
+				default-state = "keep";
+			};
+
+			led@1 {
+				reg = <1>;
+				color = <LED_COLOR_ID_GREEN>;
+				function = LED_FUNCTION_LAN;
+				default-state = "keep";
+			};
+		};
+	};
+};
+
+/* SRDS #0 - M.2 (J30) */
+&cp1_pcie0 {
+	num-lanes = <1>;
+	phys = <&cp1_comphy0 0>;
+	status = "okay";
+};
+
+&cp1_rtc {
+	status = "disabled";
+};
+
+/* SRDS #1 - SATA on M.2 (J44) */
+&cp1_sata0 {
+	phys = <&cp1_comphy1 0>;
+	status = "okay";
+
+	/* only port 0 is available */
+	/delete-node/ sata-port@1;
+};
+
+&cp1_syscon0 {
+	cp1_pinctrl: pinctrl {
+		compatible = "marvell,cp115-standalone-pinctrl";
+		pinctrl-0 = <&cp1_m2_1_shutdown_pins &cp1_m2_2_shutdown_pins>;
+		pinctrl-names = "default";
+
+		cp1_i2c1_pins: cp0-i2c1-pins {
+			marvell,pins = "mpp35", "mpp36";
+			marvell,function = "i2c1";
+		};
+
+		cp1_led_pins: cp1-led-pins {
+			marvell,pins = "mpp54", "mpp55";
+			marvell,function = "gpio";
+		};
+
+		cp1_m2_1_shutdown_pins: cp1-m2-1-shutdown-pins {
+			marvell,pins = "mpp29";
+			marvell,function = "gpio";
+		};
+
+		cp1_m2_2_shutdown_pins: cp1-m2-2-shutdown-pins {
+			marvell,pins = "mpp30";
+			marvell,function = "gpio";
+		};
+
+		cp1_mdio_pins: cp1-mdio-pins {
+			marvell,pins = "mpp37", "mpp38";
+			marvell,function = "ge";
+		};
+
+		cp1_rtc_pins: cp1-rtc-pins {
+			marvell,pins = "mpp12", "mpp13";
+			marvell,function = "gpio";
+		};
+
+		cp1_sfp1_pins: cp1-sfp1-pins {
+			marvell,pins = "mpp33", "mpp34", "mpp49", "mpp50";
+			marvell,function = "gpio";
+		};
+	};
+};
+
+/*
+ * SRDS #2 - USB-3.0 Host to M.2 (J44)
+ * USB-2.0 Host to M.2 (J30)
+ */
+&cp1_usb3_0 {
+	phys = <&cp1_comphy2 0>, <&cp1_utmi0>;
+	phy-names = "comphy", "utmi";
+	dr_mode = "host";
+	status = "okay";
+};
+
+/* USB-2.0 Host to M.2 (J44) */
+&cp1_usb3_1 {
+	phys = <&cp1_utmi1>;
+	phy-names = "utmi";
+	dr_mode = "host";
+	status = "okay";
+};
+
+&cp1_utmi {
+	status = "okay";
+};

-- 
2.35.3



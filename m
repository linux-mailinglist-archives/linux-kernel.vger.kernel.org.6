Return-Path: <linux-kernel+bounces-174413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26E208C0E64
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 12:47:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2AB3281850
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 10:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C6F7131736;
	Thu,  9 May 2024 10:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="INt3PrJq"
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2134.outbound.protection.outlook.com [40.107.13.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2B6131182;
	Thu,  9 May 2024 10:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.13.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715251584; cv=fail; b=vAR30npFUlSsW0iDgcCXFHsqrGaAonlikL6lTgCpRK2aBhSWjfrSVOuL6HNy3mVpBsThGnmOvwPd6Dss7zqnQsGnbpv6+j2pUFnupZ1Pcn9yMeTWq26nj9gyBoedWyPA3GX6Nsr49UAu2A7wR/hc/HiMHNrWIdqWt9L9Rpq/ZQY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715251584; c=relaxed/simple;
	bh=kES2HB3UmJwXWYZulDjoJS0K/eITeISVm+N26XBUkUI=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=oABN2jhApGGUM8VA488BQmcu8XRdEe/JhWnb4tyzr4POlcBaD1h95gqfrXSchtLzPIfmGRgkK1VdSvjLMLkNEVCHeXNyq7hj7BPoVzur9bDsLz4a64ZG85wCydfbI9ptPg7ZDHQgbG3LJDF6aHuHidlnxCPcZ3NgYM9h42bueQc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=INt3PrJq; arc=fail smtp.client-ip=40.107.13.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZBt77tM8msGeUD+1yriHH286qAGze2h9V17/2ekDnC35xLik6okg0veLHfKI0UXS1N3CbMrwARmWH4gH8P6XDVLC5ZZe5EAPTifjof3aN7b5nEpmHVhrY8SwUYATDeWxHJ4x/pJQuJklnysLpY0vijoF1rfQGQguovjld6kxA4nL9wWCkwXXavaXGNZIm6USw+9nuvCbsNkwDlcrpDDWz6wNIzoJii2ka73Dn5RAOirSqAEioF/XKdoo2X+ersLzIttYPt4Q5OHqb4YjGyL/hX8AHdpuC7NPlXsJHttnx0Ms6feB9eWYp2fovh9SxHxPaYp56J4100iEEqGflB7Fyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4d05q49xYLdldzIAJAOLYnFweox24PXDvvTxGws5LHM=;
 b=KMirxxjUeTSyb1B/TxlYy4Qw54oNDuGKZjcPtMh+hR3EZkmsVSLhPgUdZ4AcZ4JkmC4qDAm6NxpH85EGCQyO2gVf3f03Tr8zxNgGkn2vKHf3Riw/u6FmiqHYSebi7l6gHMBcTApiYCuChL316OZimQN+0qhUagfS/t6MXnk+oDjSgABVq/xjD//AmsiQ9x0rvpu8jZscC1Jq2Tcrk875unEl44tX1MbKDqVkO6fnGq1hLx/XIvJbym85vIwYU5gyUyNRH1V/MAN1ibYlCmppQHwy9nOnU9XSNraLq9CUY7u9begNqdAGh8m+Y6HazUW0PJFPxcJu25TdEJx+8jIhHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4d05q49xYLdldzIAJAOLYnFweox24PXDvvTxGws5LHM=;
 b=INt3PrJqt5X7ahthpsNE6514x2THMmqK1YliIFN0hcAqPLfbjke96v7XMx/wlP/DMm1eshGK91IWsyPBxe3mBj/hJNqWX7voyeU7n5NBHJezijPlj/qs2mVBfzPauDXAC0uqCsiUchTiNQtAzxiY/HItVNztPABgwHtSA5hw48I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by DBBPR04MB7612.eurprd04.prod.outlook.com (2603:10a6:10:202::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.47; Thu, 9 May
 2024 10:46:11 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529%7]) with mapi id 15.20.7544.045; Thu, 9 May 2024
 10:46:11 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Thu, 09 May 2024 12:46:07 +0200
Subject: [PATCH v5 3/4] arm64: dts: add description for solidrun cn9130 som
 and clearfog boards
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240509-cn9130-som-v5-3-95493eb5c79d@solid-run.com>
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
X-MS-Office365-Filtering-Correlation-Id: 79c5ae95-77aa-43c9-a7a7-08dc70153ddf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|52116005|376005|7416005|1800799015|366007|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cC9xUFFuaUw5Lys0UzNFQzVqNUtTYkF0bFE1ay9oczFRSU1oU0FtNVRqdGU1?=
 =?utf-8?B?UmF6NEdKMk9Cci9YOGlVZkRBM1pTa3FnS0VqTHNNb204ODdWVUk5Y3hscnFY?=
 =?utf-8?B?ZThjVlkxSW1kckdZc0lGa05XVzFDTFhaOEJwVkdiWXd3M1lPM2xQbDd6Mldi?=
 =?utf-8?B?SmxNU0lCWUdJS0crSEdkd1JOcWgvL3VIcGsvY2JMREhnOTVxRlFMTXdNdVYr?=
 =?utf-8?B?VEZneTE3YTZOcFdUcjhaWlQxSnB3Z0tNelBMdDBLeFRwZmNTVlM0ZDV5blNi?=
 =?utf-8?B?QjAxKzUxdDhDR2pFMlgzbUJLY2NlaHd6d09CejY0bEVqTjZuVGFzZldFT2tX?=
 =?utf-8?B?d29hSXc3bldyQm84M2MyZTZ4R251Zk40U2E5VENyamZFazFmNTdTZU1yMjNM?=
 =?utf-8?B?K2FYMDVnTTNETVlLT2JzcXMzZWczclFiV1EyV05taG10UHJXMG1KVlFzdTdy?=
 =?utf-8?B?aHlwZWx1MUNWNlQxUUR2eGh6WURsWWRyaHpkTDg4d3hDZnAzUGg1T2lWWHRt?=
 =?utf-8?B?TElsdk5sWG5IQXcvTHNtT3FNQkFrRlRnTzdWY3NvNStWMSt0WFNoZHQxL2JX?=
 =?utf-8?B?NEJBaXBvckdtamZPM2p2Uzh0dFpzWTErRUlBSTl2MmFUS1Erb01aNG1ZYnFN?=
 =?utf-8?B?bmM3cWhUTDJFbEM0YThwSWNzVFpRSlk3Smt2UDZlYWtLTFFRNW9sMHIyejdi?=
 =?utf-8?B?K0Jwa25ybW80ODVZQ0RvaHBNajlLK3dmTjNiTUptRVRrU0d2M2hoOWRCc0ZZ?=
 =?utf-8?B?UFR4N3VXeExoMzRrbVZWczk1YjRVbDEwbEhxdDZXTlRKZHBzZ0krN2RsVGg2?=
 =?utf-8?B?UEJmSHRXcG9DdFYxa0pxaVVkaC9LTVJoNDRpUldTenRFcGV6bUNDUTdFMTZ4?=
 =?utf-8?B?Y0MzKy9lR1hwYkpLMmc4aGgyWGtMMURzVnNsVi9mOWNRd01xcEdaV044MWUr?=
 =?utf-8?B?Tmp5d2dMc21ldG5QbjJxOUpUT0ZHT0VvOE9QQW02TjNDYkZ4ckROTXllVzd2?=
 =?utf-8?B?MDh4M2xUQVk0UXFPM2JHY1psUGJFelFIUFE2dUsxYWZlRTRrZHYrQXB5QlF5?=
 =?utf-8?B?Ukh1OGpUYzBDaGY5dEtrYkpKbWtDTFBQaUlKSi9PM1hQU3ZkNndqaVhJTklq?=
 =?utf-8?B?d01JSnZJc3lOcU5mTXllSE5PbSt4T3Ayb2FrNFhZeVUvNHRkb0N5ZGFBNzZJ?=
 =?utf-8?B?bDdEbzZtN0FFMVFCSU1qKzFCTDRSZXVybHlIZUlLK0RGc2dXa3JQYTI2Y3Zw?=
 =?utf-8?B?K1pLREVnbHhTTGpja1lCQ3dmNTNJT3BKenV3S2lwblFpZVY4WDQ1RDBHYnpr?=
 =?utf-8?B?dXJJeHM5UWp6a2I2SGpKc0V2RHl3YU8rWFNUdXBWdUZIZDkxTGx1ZHRkcDN1?=
 =?utf-8?B?UXQvQjY2TEc3dkcyUVFsdWo5MVFHSkVPdzB2c2JQOFhFelhMc2FjemFWd21S?=
 =?utf-8?B?U3RSS0hNQnc5MVZiRU1Dem9aM3k4a25sTkFtdlpxV3hTaE10SXo2dnFEVVdo?=
 =?utf-8?B?cG56U0wyQjRxMEV1d3B4R3BDQzIwaU53bTBua0RvRFFTNjQ2dk4wdmI5cy9k?=
 =?utf-8?B?UlMwa3ZKMU1EOWZiRldlTmNCblk5MWEzWFNtSURERkt5TW5zNkJRMnd3a1ND?=
 =?utf-8?B?M2JGcVVyaGRIVVRYKzZqTFFSZS9keVB3dDE1UEpRSmxHL1k3RnY4WEhWTGdK?=
 =?utf-8?B?Zk54RmJleUg2TDZlSzlJK2FjN2tvZTNsQjVKdjN5ajAxcXF1TURDRW9zU1Fy?=
 =?utf-8?B?cnhvSHNCTnpVV1YvM2ZkczlqTkZQbVpka2tqWEhIZkVtTXJKZ3J6TEVlRTds?=
 =?utf-8?B?L0hNZ2dwK0xWeVVsY28xUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(376005)(7416005)(1800799015)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WU9Vcm83NFpudkVDWWpjeXNRRzB4bVRvRWF1RWozMmFwQmorRVQ3UlBXMHdp?=
 =?utf-8?B?VUplODdtNi9RNzJjRStRc3NMdkNWUzlFcGRsMUZJdEh0VDhkYy9RT1M5bjdL?=
 =?utf-8?B?dUljMDNFTENnN3RxL3kvOU5jejViTXBkT3ZUQ1hLTGRneVdNNm5jOTlyaFNs?=
 =?utf-8?B?WkJReUZTV0lvalM0NDZycDFJcUh5TVVYZ0hBdll5a1NiTUNCNURiMHdOL3pZ?=
 =?utf-8?B?QVUwZjlUQUFtQXoza05xRzRFQ3lpaG5iK21LSXVHdHY5d0M5Q3JuUTFjazZH?=
 =?utf-8?B?L3E4T0VMMmRCd2JjbDhLUk9WTUZNVm5tWWxucGJKUFJ0S0c5cTV2ZnpXODlu?=
 =?utf-8?B?d3BjSWlKYmsvKy9xdmZLd3BlMHRwaWsxQUJscmF6SkRIK3lEVDRjZythbzha?=
 =?utf-8?B?RFZUbmwvUEJhTzZWZ2wzc0RpNDZmTkVMbU91dFJkMzROWEE4TTFyVUVWY29w?=
 =?utf-8?B?amRQUWhUcE5NdnFWUjltMUZpRGttNW9QcmVoUWV3TzNiTTlFQTgvQ0xsUDZY?=
 =?utf-8?B?b1owc3REdkV6MGJINXhGVXhSN0cyYy9YcWpabEhEdWVDMnZoU2VmT2gwS0dY?=
 =?utf-8?B?SzYxSURVV2NTUlhYRzkvSm0ySjVTUVJUa3EvcXpoMlZ2TzVaSmNkbVU3eXBK?=
 =?utf-8?B?bFNWMWpnVEFyTE4vVU84cXNpbkpqc0kwUWdTdzE5YmZDRHkzYTVwUFB4YllN?=
 =?utf-8?B?QjQrNWdtTU4veEk5dDI0bThFV3d0eHNTeUdFczYyT0RSdEtXbU1ISWVCR3Vt?=
 =?utf-8?B?QWErRWF5V08yY3QwRDZNS2p4MUhCSFkzR0p1T3hOeTgrQUtVdm1nNzRINW5k?=
 =?utf-8?B?TDhIQyt1SC91amk0aWRtWU9IMzdReEJNVTZ3SnpMeVVBTk9PS3QxQmhQSFhV?=
 =?utf-8?B?QlZFcHV2c3p0R0NnVkhLSXo5Yzk5M1ZtdU93VXJqdnpYK2t4ZEVKZ0pwMkZH?=
 =?utf-8?B?UCtaUjdwN2dxRFAxMEtGSE5aZGtZcXVjak5IVnFtNmM0b2RaRWJZdmdLZkVY?=
 =?utf-8?B?WHgzS0ZZSG5Cc0UxcDE1MzRmZFNFTHY1eStmUEp4eTJ6N05GTStJYTlyYWpX?=
 =?utf-8?B?OVYyOHpjbTBJaVQxN0tzcnlZZmNUSlVDaDdyR1A4K3JjL3BOZHg2VTZieS81?=
 =?utf-8?B?UkswbTQ2c2VGV0tnRnNMcmhvb1BianhXdmFCUGVNQU5uWVh5Nk1SeFV0MlRQ?=
 =?utf-8?B?eHEzY043UzlyS1l0YWkyUW9VOXBtelVPVkRDd3dpcmsxZG96Z1ZHVHlKOFpW?=
 =?utf-8?B?S280eUpib0hObDFBb3gwYVM0anRZcDg1WUpnVUZJcVloMDNzejk4a2IxTngz?=
 =?utf-8?B?dzlSNHBVQi9PVkRSdG1RdXFpaXc2KzhqcjBLVm1YcnZmV2NWSVQ5cnU3bEJC?=
 =?utf-8?B?ZWUzM2N6YUQ3T1FkMi9MKzg5bFJiUnNScDlaVThOcFR2V3duWVh2ZkxRTzMr?=
 =?utf-8?B?bVdqUnFCS053RzhINXR1KzBzTDc5ZUdnM1hJdm04Mi8vQXpLaWtkS1ZuT0xo?=
 =?utf-8?B?SHd1N3lvQ1VRaW9mQWdsOUFPNEVqa2JmZWt3bnhLRDN0U2lRSUFKd3ZXUDZ5?=
 =?utf-8?B?ZG5wL1lRZWw2Vkt6Z3NWMkEyR2RYUmpWd05NU09rNFBNT1lVSy8zYzdBbVlB?=
 =?utf-8?B?MlpZYkNIektMbWovODRuWXRpZzZkV25BM0pkaG0zc1BJUVFmbzhWZHVadGJY?=
 =?utf-8?B?ZS9wK1dFeXFrblFjZ1RRNHBEZkxYU1VVWVJlc20wRWxWWFBlYzBSdWNRdC9p?=
 =?utf-8?B?TDRleklNajRkd0pTcGI3UDB5alQ5S3BNTTZ0SElXZndsY3Y4UGswZHo0cFFS?=
 =?utf-8?B?ZDZQaktCY3RrNlh5ZUxBcS82eHhRWlJpRkIrcy9LVThWZXdtYnBEYlpEVGd4?=
 =?utf-8?B?SXZVY0pIeWhQaEpTVVNZYnR2eThDMi9IRjJwelE2akFnYUtBL0hHbVh3cS9S?=
 =?utf-8?B?aU16UTN0WUZiYTh5VTJMd0FnbEp0SzR2enRscXpOMzJ6Qk9hSjBxMFVxS1A5?=
 =?utf-8?B?UzhPdjE5M1B3emVYbk9UQWdURXg3dDZ5dUdSbCtYcTBrTWQzZ2xlKzBQSEN2?=
 =?utf-8?B?bkFhOW0raytXaEk3T0VRMENoYitwK0ozc3RsRUZpZ2hDQmZNb3Z1RXhCYlZF?=
 =?utf-8?Q?rBc2UBX1fcUdLR21PYMsmzd9n?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79c5ae95-77aa-43c9-a7a7-08dc70153ddf
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2024 10:46:11.5146
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rniGGoUFQcdlkGctL7wEPvsWVusEx2cdiv6AegKNZSP2pWXkRsB+kvbPITI+wqRDPFV4rUGhcFNPm7MUrX/J0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7612

Add description for the SolidRun CN9130 SoM, and Clearfog Base / Pro
reference boards.

The SoM has been designed as a pin-compatible replacement for the older
Armada 388 based SoM. Therefore it supports the same boards and a
similar feature set.

Most notable upgrades:
- 4x Cortex-A72
- 10Gbps SFP
- Both eMMC and SD supported at the same time

The developer first supporting this product at SolidRun decided to use
different filenames for the DTBs: Armada 388 uses the full
"clearfog" string while cn9130 uses the abbreviation "cf".
This name is already hard-coded in pre-installed vendor u-boot and can
not be changed easily.

NOTICE IN CASE ANYBODY WANTS TO SELF-UPGRADE:
CN9130 SoM has a different footprint from Armada 388 SoM.
Components on the carrier board below the SoM may collide causing
damage, such as on Clearfog Base.

Signed-off-by: Josua Mayer <josua@solid-run.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm64/boot/dts/marvell/Makefile           |   2 +
 arch/arm64/boot/dts/marvell/cn9130-cf-base.dts | 178 ++++++++++++
 arch/arm64/boot/dts/marvell/cn9130-cf-pro.dts  | 375 +++++++++++++++++++++++++
 arch/arm64/boot/dts/marvell/cn9130-cf.dtsi     | 197 +++++++++++++
 arch/arm64/boot/dts/marvell/cn9130-sr-som.dtsi | 160 +++++++++++
 5 files changed, 912 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/Makefile b/arch/arm64/boot/dts/marvell/Makefile
index 99b8cb3c49e1..019f2251d696 100644
--- a/arch/arm64/boot/dts/marvell/Makefile
+++ b/arch/arm64/boot/dts/marvell/Makefile
@@ -28,3 +28,5 @@ dtb-$(CONFIG_ARCH_MVEBU) += cn9130-crb-A.dtb
 dtb-$(CONFIG_ARCH_MVEBU) += cn9130-crb-B.dtb
 dtb-$(CONFIG_ARCH_MVEBU) += ac5x-rd-carrier-cn9131.dtb
 dtb-$(CONFIG_ARCH_MVEBU) += ac5-98dx35xx-rd.dtb
+dtb-$(CONFIG_ARCH_MVEBU) += cn9130-cf-base.dtb
+dtb-$(CONFIG_ARCH_MVEBU) += cn9130-cf-pro.dtb
diff --git a/arch/arm64/boot/dts/marvell/cn9130-cf-base.dts b/arch/arm64/boot/dts/marvell/cn9130-cf-base.dts
new file mode 100644
index 000000000000..788a5c302b17
--- /dev/null
+++ b/arch/arm64/boot/dts/marvell/cn9130-cf-base.dts
@@ -0,0 +1,178 @@
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
+#include "cn9130-cf.dtsi"
+
+/ {
+	model = "SolidRun CN9130 Clearfog Base";
+	compatible = "solidrun,cn9130-clearfog-base",
+		     "solidrun,cn9130-sr-som", "marvell,cn9130";
+
+	gpio-keys {
+		compatible = "gpio-keys";
+		pinctrl-0 = <&rear_button_pins>;
+		pinctrl-names = "default";
+
+		button-0 {
+			/* The rear SW3 button */
+			label = "Rear Button";
+			gpios = <&cp0_gpio1 31 GPIO_ACTIVE_LOW>;
+			linux,can-disable;
+			linux,code = <BTN_0>;
+		};
+	};
+
+	rfkill-m2-gnss {
+		compatible = "rfkill-gpio";
+		label = "m.2 GNSS";
+		radio-type = "gps";
+		/* rfkill-gpio inverts internally */
+		shutdown-gpios = <&expander0 9 GPIO_ACTIVE_HIGH>;
+	};
+
+	/* M.2 is B-keyed, so w-disable is for WWAN */
+	rfkill-m2-wwan {
+		compatible = "rfkill-gpio";
+		label = "m.2 WWAN";
+		radio-type = "wwan";
+		/* rfkill-gpio inverts internally */
+		shutdown-gpios = <&expander0 8 GPIO_ACTIVE_HIGH>;
+	};
+};
+
+/* SRDS #3 - SGMII 1GE */
+&cp0_eth1 {
+	phy = <&phy1>;
+	phys = <&cp0_comphy3 1>;
+	phy-mode = "sgmii";
+	status = "okay";
+};
+
+&cp0_eth2_phy {
+	/*
+	 * Configure LEDs default behaviour:
+	 * - LED[0]: link/activity: On/blink (green)
+	 * - LED[1]: link is 100/1000Mbps: On (yellow)
+	 * - LED[2]: high impedance (floating)
+	 */
+	marvell,reg-init = <3 16 0xf000 0x0a61>;
+
+	leds {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		led@0 {
+			reg = <0>;
+			color = <LED_COLOR_ID_GREEN>;
+			function = LED_FUNCTION_WAN;
+			default-state = "keep";
+		};
+
+		led@1 {
+			reg = <1>;
+			color = <LED_COLOR_ID_YELLOW>;
+			function = LED_FUNCTION_WAN;
+			default-state = "keep";
+		};
+	};
+};
+
+&cp0_gpio1 {
+	sim-select-hog {
+		gpio-hog;
+		gpios = <27 GPIO_ACTIVE_HIGH>;
+		output-high;
+		line-name = "sim-select";
+	};
+};
+
+&cp0_mdio {
+	phy1: ethernet-phy@1 {
+		reg = <1>;
+		/*
+		 * Configure LEDs default behaviour:
+		 * - LED[0]: link/activity: On/blink (green)
+		 * - LED[1]: link is 100/1000Mbps: On (yellow)
+		 * - LED[2]: high impedance (floating)
+		 *
+		 * Configure LEDs electrical polarity
+		 * - on-state: low
+		 * - off-state: high (not hi-z, to avoid residual glow)
+		 */
+		marvell,reg-init = <3 16 0xf000 0x0a61>,
+				   <3 17 0x003f 0x000a>;
+
+		leds {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			led@0 {
+				reg = <0>;
+				color = <LED_COLOR_ID_GREEN>;
+				function = LED_FUNCTION_LAN;
+				default-state = "keep";
+			};
+
+			led@1 {
+				reg = <1>;
+				color = <LED_COLOR_ID_YELLOW>;
+				function = LED_FUNCTION_LAN;
+				default-state = "keep";
+			};
+		};
+	};
+};
+
+&cp0_pinctrl {
+	pinctrl-0 = <&sim_select_pins>;
+	pintrl-names = "default";
+
+	rear_button_pins: cp0-rear-button-pins {
+		marvell,pins = "mpp31";
+		marvell,function = "gpio";
+	};
+
+	sim_select_pins: cp0-sim-select-pins {
+		marvell,pins = "mpp27";
+		marvell,function = "gpio";
+	};
+};
+
+/*
+ * SRDS #4 - USB 3.0 host on M.2 connector
+ * USB-2.0 Host on Type-A connector
+ */
+&cp0_usb3_1 {
+	phys = <&cp0_comphy4 1>, <&cp0_utmi1>;
+	phy-names = "comphy", "utmi";
+	dr_mode = "host";
+	status = "okay";
+};
+
+&expander0 {
+	m2-full-card-power-off-hog {
+		gpio-hog;
+		gpios = <2 GPIO_ACTIVE_LOW>;
+		output-low;
+		line-name = "m2-full-card-power-off";
+	};
+
+	m2-reset-hog {
+		gpio-hog;
+		gpios = <10 GPIO_ACTIVE_LOW>;
+		output-low;
+		line-name = "m2-reset";
+	};
+};
diff --git a/arch/arm64/boot/dts/marvell/cn9130-cf-pro.dts b/arch/arm64/boot/dts/marvell/cn9130-cf-pro.dts
new file mode 100644
index 000000000000..a27fe0042867
--- /dev/null
+++ b/arch/arm64/boot/dts/marvell/cn9130-cf-pro.dts
@@ -0,0 +1,375 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2024 Josua Mayer <josua@solid-run.com>
+ *
+ * DTS for SolidRun CN9130 Clearfog Pro.
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
+#include "cn9130-cf.dtsi"
+
+/ {
+	model = "SolidRun CN9130 Clearfog Pro";
+	compatible = "solidrun,cn9130-clearfog-pro",
+		     "solidrun,cn9130-sr-som", "marvell,cn9130";
+
+	gpio-keys {
+		compatible = "gpio-keys";
+		pinctrl-0 = <&rear_button_pins>;
+		pinctrl-names = "default";
+
+		button-0 {
+			/* The rear SW3 button */
+			label = "Rear Button";
+			gpios = <&cp0_gpio2 0 GPIO_ACTIVE_LOW>;
+			linux,can-disable;
+			linux,code = <BTN_0>;
+		};
+	};
+};
+
+/* SRDS #3 - SGMII 1GE to L2 switch */
+&cp0_eth1 {
+	phys = <&cp0_comphy3 1>;
+	phy-mode = "sgmii";
+	status = "okay";
+
+	fixed-link {
+		speed = <1000>;
+		full-duplex;
+	};
+};
+
+&cp0_eth2_phy {
+	/*
+	 * Configure LEDs default behaviour similar to switch ports:
+	 * - LED[0]: link/activity: On/blink (green)
+	 * - LED[1]: link is 100/1000Mbps: On (red)
+	 * - LED[2]: high impedance (floating)
+	 *
+	 * Switch port defaults:
+	 * - LED0: link/activity: On/blink (green)
+	 * - LED1: link is 1000Mbps: On (red)
+	 *
+	 * Identical configuration is impossible with hardware offload.
+	 */
+	marvell,reg-init = <3 16 0xf000 0x0a61>;
+
+	leds {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		led@0 {
+			reg = <0>;
+			color = <LED_COLOR_ID_GREEN>;
+			function = LED_FUNCTION_WAN;
+			label = "LED2";
+			default-state = "keep";
+		};
+
+		led@1 {
+			reg = <1>;
+			color = <LED_COLOR_ID_RED>;
+			function = LED_FUNCTION_WAN;
+			label = "LED1";
+			default-state = "keep";
+		};
+	};
+};
+
+&cp0_mdio {
+	ethernet-switch@4 {
+		compatible = "marvell,mv88e6085";
+		reg = <4>;
+		pinctrl-0 = <&dsa_clk_pins &dsa_pins>;
+		pinctrl-names = "default";
+		reset-gpios = <&cp0_gpio1 27 GPIO_ACTIVE_LOW>;
+		interrupt-parent = <&cp0_gpio1>;
+		interrupts = <29 IRQ_TYPE_EDGE_FALLING>;
+
+		ethernet-ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			ethernet-port@0 {
+				reg = <0>;
+				label = "lan5";
+				phy = <&switch0phy0>;
+
+				leds {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					led@0 {
+						reg = <0>;
+						color = <LED_COLOR_ID_GREEN>;
+						function = LED_FUNCTION_LAN;
+						label = "LED12";
+						default-state = "keep";
+					};
+
+					led@1 {
+						reg = <1>;
+						color = <LED_COLOR_ID_RED>;
+						function = LED_FUNCTION_LAN;
+						label = "LED11";
+						default-state = "keep";
+					};
+				};
+			};
+
+			ethernet-port@1 {
+				reg = <1>;
+				label = "lan4";
+				phy = <&switch0phy1>;
+
+				leds {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					led@0 {
+						reg = <0>;
+						color = <LED_COLOR_ID_GREEN>;
+						function = LED_FUNCTION_LAN;
+						label = "LED10";
+						default-state = "keep";
+					};
+
+					led@1 {
+						reg = <1>;
+						color = <LED_COLOR_ID_RED>;
+						function = LED_FUNCTION_LAN;
+						label = "LED9";
+						default-state = "keep";
+					};
+				};
+			};
+
+			ethernet-port@2 {
+				reg = <2>;
+				label = "lan3";
+				phy = <&switch0phy2>;
+
+				leds {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					led@0 {
+						reg = <0>;
+						color = <LED_COLOR_ID_GREEN>;
+						function = LED_FUNCTION_LAN;
+						label = "LED8";
+						default-state = "keep";
+					};
+
+					led@1 {
+						reg = <1>;
+						color = <LED_COLOR_ID_RED>;
+						function = LED_FUNCTION_LAN;
+						label = "LED7";
+						default-state = "keep";
+					};
+				};
+			};
+
+			ethernet-port@3 {
+				reg = <3>;
+				label = "lan2";
+				phy = <&switch0phy3>;
+
+				leds {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					led@0 {
+						reg = <0>;
+						color = <LED_COLOR_ID_GREEN>;
+						function = LED_FUNCTION_LAN;
+						label = "LED6";
+						default-state = "keep";
+					};
+
+					led@1 {
+						reg = <1>;
+						color = <LED_COLOR_ID_RED>;
+						function = LED_FUNCTION_LAN;
+						label = "LED5";
+						default-state = "keep";
+					};
+				};
+			};
+
+			ethernet-port@4 {
+				reg = <4>;
+				label = "lan1";
+				phy = <&switch0phy4>;
+
+				leds {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					led@0 {
+						reg = <0>;
+						color = <LED_COLOR_ID_GREEN>;
+						function = LED_FUNCTION_LAN;
+						label = "LED4";
+						default-state = "keep";
+					};
+
+					led@1 {
+						reg = <1>;
+						color = <LED_COLOR_ID_RED>;
+						function = LED_FUNCTION_LAN;
+						label = "LED3";
+						default-state = "keep";
+					};
+				};
+			};
+
+			ethernet-port@5 {
+				reg = <5>;
+				label = "cpu";
+				ethernet = <&cp0_eth1>;
+				phy-mode = "sgmii";
+
+				fixed-link {
+					speed = <1000>;
+					full-duplex;
+				};
+			};
+
+			ethernet-port@6 {
+				reg = <6>;
+				label = "lan6";
+				phy-mode = "rgmii";
+
+				/*
+				 * Because of mdio address conflict the
+				 * external phy is not readable.
+				 * Force a fixed link instead.
+				 */
+				fixed-link {
+					speed = <1000>;
+					full-duplex;
+				};
+			};
+		};
+
+		mdio {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			switch0phy0: ethernet-phy@0 {
+				reg = <0x0>;
+			};
+
+			switch0phy1: ethernet-phy@1 {
+				reg = <0x1>;
+				/*
+				 * Indirectly configure default behaviour
+				 * for port lan6 leds behind external phy.
+				 * Internal PHYs are not using page 3,
+				 * therefore writing to it is safe.
+				 */
+				marvell,reg-init = <3 16 0xf000 0x0a61>;
+			};
+
+			switch0phy2: ethernet-phy@2 {
+				reg = <0x2>;
+			};
+
+			switch0phy3: ethernet-phy@3 {
+				reg = <0x3>;
+			};
+
+			switch0phy4: ethernet-phy@4 {
+				reg = <0x4>;
+			};
+		};
+
+		/*
+		 * There is an external phy on the switch mdio bus.
+		 * Because its mdio address collides with internal phys,
+		 * it is not readable.
+		 *
+		 * mdio-external {
+		 *	compatible = "marvell,mv88e6xxx-mdio-external";
+		 *	#address-cells = <1>;
+		 *	#size-cells = <0>;
+		 *
+		 *	ethernet-phy@1 {
+		 *		reg = <0x1>;
+		 *	};
+		 * };
+		 */
+	};
+};
+
+/* SRDS #4 - miniPCIe (CON2) */
+&cp0_pcie1 {
+	num-lanes = <1>;
+	phys = <&cp0_comphy4 1>;
+	/* dw-pcie inverts internally */
+	reset-gpios = <&expander0 2 GPIO_ACTIVE_HIGH>;
+	status = "okay";
+};
+
+&cp0_pinctrl {
+	dsa_clk_pins: cp0-dsa-clk-pins {
+		marvell,pins = "mpp40";
+		marvell,function = "synce1";
+	};
+
+	dsa_pins: cp0-dsa-pins {
+		marvell,pins = "mpp27", "mpp29";
+		marvell,function = "gpio";
+	};
+
+	rear_button_pins: cp0-rear-button-pins {
+		marvell,pins = "mpp32";
+		marvell,function = "gpio";
+	};
+
+	cp0_spi1_cs1_pins: cp0-spi1-cs1-pins {
+		marvell,pins = "mpp12";
+		marvell,function = "spi1";
+	};
+};
+
+&cp0_spi1 {
+	/* add pin for chip-select 1 on mikrobus */
+	pinctrl-0 = <&cp0_spi1_pins &cp0_spi1_cs1_pins>;
+};
+
+/* USB-2.0 Host on Type-A connector */
+&cp0_usb3_1 {
+	phys = <&cp0_utmi1>;
+	phy-names = "utmi";
+	dr_mode = "host";
+	status = "okay";
+};
+
+&expander0 {
+	/* CON2 */
+	pcie1-0-clkreq-hog {
+		gpio-hog;
+		gpios = <4 GPIO_ACTIVE_LOW>;
+		input;
+		line-name = "pcie1.0-clkreq";
+	};
+
+	/* CON2 */
+	pcie1-0-w-disable-hog {
+		gpio-hog;
+		gpios = <7 GPIO_ACTIVE_LOW>;
+		output-low;
+		line-name = "pcie1.0-w-disable";
+	};
+};
diff --git a/arch/arm64/boot/dts/marvell/cn9130-cf.dtsi b/arch/arm64/boot/dts/marvell/cn9130-cf.dtsi
new file mode 100644
index 000000000000..ad0ab34b6602
--- /dev/null
+++ b/arch/arm64/boot/dts/marvell/cn9130-cf.dtsi
@@ -0,0 +1,197 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2024 Josua Mayer <josua@solid-run.com>
+ *
+ * DTS for common base of SolidRun CN9130 Clearfog Base and Pro.
+ *
+ */
+
+/ {
+	aliases {
+		/* label nics same order as armada 388 clearfog */
+		ethernet0 = &cp0_eth2;
+		ethernet1 = &cp0_eth1;
+		ethernet2 = &cp0_eth0;
+		i2c1 = &cp0_i2c1;
+		mmc1 = &cp0_sdhci0;
+	};
+
+	reg_usb3_vbus0: regulator-usb3-vbus0 {
+		compatible = "regulator-fixed";
+		regulator-name = "vbus0";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpios = <&expander0 6 GPIO_ACTIVE_LOW>;
+	};
+
+	sfp: sfp {
+		compatible = "sff,sfp";
+		i2c-bus = <&cp0_i2c1>;
+		los-gpios = <&expander0 12 GPIO_ACTIVE_HIGH>;
+		mod-def0-gpios = <&expander0 15 GPIO_ACTIVE_LOW>;
+		tx-disable-gpios = <&expander0 14 GPIO_ACTIVE_HIGH>;
+		tx-fault-gpios = <&expander0 13 GPIO_ACTIVE_HIGH>;
+		maximum-power-milliwatt = <2000>;
+	};
+};
+
+/* SRDS #2 - SFP+ 10GE */
+&cp0_eth0 {
+	managed = "in-band-status";
+	phys = <&cp0_comphy2 0>;
+	phy-mode = "10gbase-r";
+	sfp = <&sfp>;
+	status = "okay";
+};
+
+&cp0_i2c0 {
+	expander0: gpio-expander@20 {
+		compatible = "nxp,pca9555";
+		reg = <0x20>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		pinctrl-0 = <&expander0_pins>;
+		pinctrl-names = "default";
+		interrupt-parent = <&cp0_gpio1>;
+		interrupts = <4 IRQ_TYPE_LEVEL_LOW>;
+
+		/* CON3 */
+		pcie2-0-clkreq-hog {
+			gpio-hog;
+			gpios = <0 GPIO_ACTIVE_LOW>;
+			input;
+			line-name = "pcie2.0-clkreq";
+		};
+
+		/* CON3 */
+		pcie2-0-w-disable-hog {
+			gpio-hog;
+			gpios = <3 GPIO_ACTIVE_LOW>;
+			output-low;
+			line-name = "pcie2.0-w-disable";
+		};
+
+		usb3-ilimit-hog {
+			gpio-hog;
+			gpios = <5 GPIO_ACTIVE_LOW>;
+			input;
+			line-name = "usb3-current-limit";
+		};
+
+		m2-devslp-hog {
+			gpio-hog;
+			gpios = <11 GPIO_ACTIVE_HIGH>;
+			output-low;
+			line-name = "m.2 devslp";
+		};
+	};
+
+	/* The MCP3021 supports standard and fast modes */
+	adc@4c {
+		compatible = "microchip,mcp3021";
+		reg = <0x4c>;
+	};
+
+	carrier_eeprom: eeprom@52 {
+		compatible = "atmel,24c02";
+		reg = <0x52>;
+		pagesize = <8>;
+	};
+};
+
+&cp0_i2c1 {
+	/*
+	 * Routed to SFP, M.2, mikrobus, and miniPCIe
+	 * SFP limits this to 100kHz, and requires an AT24C01A/02/04 with
+	 *  address pins tied low, which takes addresses 0x50 and 0x51.
+	 * Mikrobus doesn't specify beyond an I2C bus being present.
+	 * PCIe uses ARP to assign addresses, or 0x63-0x64.
+	 */
+	clock-frequency = <100000>;
+	pinctrl-0 = <&cp0_i2c1_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+/* SRDS #5 - miniPCIe (CON3) */
+&cp0_pcie2 {
+	num-lanes = <1>;
+	phys = <&cp0_comphy5 2>;
+	/* dw-pcie inverts internally */
+	reset-gpios = <&expander0 1 GPIO_ACTIVE_HIGH>;
+	status = "okay";
+};
+
+&cp0_pinctrl {
+	cp0_i2c1_pins: cp0-i2c1-pins {
+		marvell,pins = "mpp35", "mpp36";
+		marvell,function = "i2c1";
+	};
+
+	cp0_mmc0_pins: cp0-mmc0-pins {
+		marvell,pins = "mpp43", "mpp56", "mpp57", "mpp58",
+			       "mpp59", "mpp60", "mpp61";
+		marvell,function = "sdio";
+	};
+
+	mikro_spi_pins: cp0-spi1-cs1-pins {
+		marvell,pins = "mpp12";
+		marvell,function = "spi1";
+	};
+
+	mikro_uart_pins: cp0-uart-pins {
+		marvell,pins = "mpp2", "mpp3";
+		marvell,function = "uart1";
+	};
+
+	expander0_pins: cp0-expander0-pins {
+		marvell,pins = "mpp4";
+		marvell,function = "gpio";
+	};
+};
+
+/* SRDS #0 - SATA on M.2 connector */
+&cp0_sata0 {
+	phys = <&cp0_comphy0 1>;
+	status = "okay";
+
+	/* only port 1 is available */
+	/delete-node/ sata-port@0;
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
+	/* CS1 for mikrobus */
+	pinctrl-0 = <&cp0_spi1_pins &mikro_spi_pins>;
+};
+
+/*
+ * SRDS #1 - USB-3.0 Host on Type-A connector
+ * USB-2.0 Host on mPCI-e connector (CON3)
+ */
+&cp0_usb3_0 {
+	phys = <&cp0_comphy1 0>, <&cp0_utmi0>;
+	phy-names = "comphy", "utmi";
+	vbus-supply = <&reg_usb3_vbus0>;
+	dr_mode = "host";
+	status = "okay";
+};
+
+&cp0_utmi {
+	status = "okay";
+};
+
+/* mikrobus uart */
+&cp0_uart0 {
+	pinctrl-0 = <&mikro_uart_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/marvell/cn9130-sr-som.dtsi b/arch/arm64/boot/dts/marvell/cn9130-sr-som.dtsi
new file mode 100644
index 000000000000..4676e3488f54
--- /dev/null
+++ b/arch/arm64/boot/dts/marvell/cn9130-sr-som.dtsi
@@ -0,0 +1,160 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (C) 2024 Josua Mayer <josua@solid-run.com>
+ *
+ */
+
+#include <dt-bindings/gpio/gpio.h>
+
+/ {
+	model = "SolidRun CN9130 SoM";
+	compatible = "solidrun,cn9130-sr-som", "marvell,cn9130";
+
+	aliases {
+		ethernet0 = &cp0_eth0;
+		ethernet1 = &cp0_eth1;
+		ethernet2 = &cp0_eth2;
+		i2c0 = &cp0_i2c0;
+		mmc0 = &ap_sdhci0;
+		rtc0 = &cp0_rtc;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	v_1_8: regulator-1-8 {
+		compatible = "regulator-fixed";
+		regulator-name = "1v8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+	};
+
+	/* requires assembly of R9307 */
+	vhv: regulator-vhv-1-8 {
+		compatible = "regulator-fixed";
+		regulator-name = "vhv-1v8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		pinctrl-0 = <&cp0_reg_vhv_pins>;
+		pinctrl-names = "default";
+		gpios = <&cp0_gpio2 9 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+};
+
+&ap_pinctrl {
+	ap_mmc0_pins: ap-mmc0-pins {
+		marvell,pins = "mpp0", "mpp1", "mpp2", "mpp3", "mpp4", "mpp5",
+					   "mpp6", "mpp7", "mpp8", "mpp9", "mpp10", "mpp12";
+		marvell,function = "sdio";
+		/*
+		 * mpp12 is emmc reset, function should be sdio (hw_rst),
+		 * but pinctrl-mvebu does not support this.
+		 *
+		 * From pinctrl-mvebu.h:
+		 * "The name will be used to switch to this setting in DT description, e.g.
+		 * marvell,function = "uart2". subname is only for debugging purposes."
+		 */
+	};
+};
+
+&ap_sdhci0 {
+	bus-width = <8>;
+	pinctrl-0 = <&ap_mmc0_pins>;
+	pinctrl-names = "default";
+	vqmmc-supply = <&v_1_8>;
+	status = "okay";
+};
+
+&cp0_ethernet {
+	status = "okay";
+};
+
+/* for assembly with phy */
+&cp0_eth2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&cp0_eth2_pins>;
+	phy-mode = "rgmii-id";
+	phy = <&cp0_eth2_phy>;
+	status = "okay";
+};
+
+&cp0_i2c0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&cp0_i2c0_pins>;
+	clock-frequency = <100000>;
+	status = "okay";
+
+	som_eeprom: eeprom@53 {
+		compatible = "atmel,24c02";
+		reg = <0x53>;
+		pagesize = <8>;
+	};
+};
+
+&cp0_mdio {
+	pinctrl-0 = <&cp0_mdio_pins>;
+	status = "okay";
+
+	/* assembly option */
+	cp0_eth2_phy: ethernet-phy@0 {
+		reg = <0>;
+	};
+};
+
+&cp0_spi1 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&cp0_spi1_pins>;
+	/* max speed limited by a mux */
+	spi-max-frequency = <1800000000>;
+
+	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		/* read command supports max. 50MHz */
+		spi-max-frequency = <50000000>;
+	};
+};
+
+&cp0_syscon0 {
+	cp0_pinctrl: pinctrl {
+		compatible = "marvell,cp115-standalone-pinctrl";
+
+		cp0_eth2_pins: cp0-ge2-rgmii-pins {
+			marvell,pins = "mpp44", "mpp45", "mpp46", "mpp47",
+				       "mpp48", "mpp49", "mpp50", "mpp51",
+				       "mpp52", "mpp53", "mpp54", "mpp55";
+			/* docs call it "ge2", but cp110-pinctrl "ge1" */
+			marvell,function = "ge1";
+		};
+
+		cp0_i2c0_pins: cp0-i2c0-pins {
+			marvell,pins = "mpp37", "mpp38";
+			marvell,function = "i2c0";
+		};
+
+		cp0_mdio_pins: cp0-mdio-pins {
+			marvell,pins = "mpp40", "mpp41";
+			marvell,function = "ge";
+		};
+
+		cp0_spi1_pins: cp0-spi1-pins {
+			marvell,pins = "mpp13", "mpp14", "mpp15", "mpp16";
+			marvell,function = "spi1";
+		};
+
+		cp0_reg_vhv_pins: cp0-reg-vhv-pins {
+			marvell,pins = "mpp41";
+			marvell,function = "gpio";
+		};
+	};
+};
+
+/* AP default console */
+&uart0 {
+	pinctrl-0 = <&uart0_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};

-- 
2.35.3



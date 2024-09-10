Return-Path: <linux-kernel+bounces-322605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7F20972B62
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 10:03:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 254EEB22848
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 08:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6081618C021;
	Tue, 10 Sep 2024 08:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="BOIwyVGN"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2077.outbound.protection.outlook.com [40.107.255.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1EA41779B1;
	Tue, 10 Sep 2024 08:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725955262; cv=fail; b=ifUYCbo7vSQv3qEkzsJghyCWnZsK0qTI43XuM5XB1lWAQrX34PcBq6utfO2rhoK8j9XLTKl3aVO9VSMyWoL+LErbNSQ6neApudb93cbNtdMn18e/LuJ7ke1jxVJJkRb1MEbC2ORQVCgBVgDYg+iIBEhg2ILXd8TRKOLMcm86vrA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725955262; c=relaxed/simple;
	bh=YJknxjCC2/bj9pVQFS3qXWuYiUV6fX6l5Es3jkSuw14=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=c4xj/gfniP0K6ZB7LR+8N5E76rmqDQ2jkjXT7GCYdQgxssMEU9oSXxN19GoYNQRuIUDRnDBI5JR2pXQ5NbWgkr2M2KSUaXgTMpXO2IAx5/gc9s8QhmVuVlYvNwOvRue+mhFeSi8cYCXeZqkS/d4rSHPl1FGU5DnCH1NyL5Ci0tU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=BOIwyVGN; arc=fail smtp.client-ip=40.107.255.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kcWRx7i7Rcu9SrRrz6s6arNxuuq3jJcSb2KFJaBCAuKfspvhzaAMctp7Z/bFKTcFc8eupLcbjT1o9Q1XY8UtK/x7ZtP5vSIGXSoQ5RQA22ngs89loaMXSbkseWRBe2f45YCGzU7y2uO26os1DPJYHdjhg+YU8JKiAQIGmOTnYvwXPOcePvgVSCDH0cOl64qRBOGXjBl/TUKM3OOCzV44OOHTLKdXN3ZNEQibNd+wAW2MpjBEDXebtw3vLUxBOQxyU+4Zpk82Igm680DeYiUp1yApZvMidtFAElo0n4B0J11VDqNXMhKrbxw7STiLky9lUZ6Sl/NTBbM4qCvvRErEzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YJknxjCC2/bj9pVQFS3qXWuYiUV6fX6l5Es3jkSuw14=;
 b=qQQq5r+pEJUkvSq3VVBeF3NlPUn7Ab2jTnl1CWWxWKh2WC/yoGdTgS2F//ayVEOHLfg4h6IJ3DnI3w7R6itgH5tVYvz9AWkkjkuk+AP8TFuvVs6Avlme5Nwhx4lSEKEKXe5rN+2+rvc3ThwOD8KAIqmexNBPuOtZ1Uxr1hEzqSTsFkB6MpBAY96CQw2sY70OT7E5BnssFYncff6ev3gmnydqeLugXEQ+SvLRc/eGW3rL8BKRD7dtWV5hxrctYK+UiVy0a/lhGf7PRieX5MFDwb8JNNDW6u5jS/iMwqeFqHIBz4rsFhWGNPlwsMRhhw8899BPN689ePsFfoT10GOdcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wiwynn.com; dmarc=pass action=none header.from=wiwynn.com;
 dkim=pass header.d=wiwynn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YJknxjCC2/bj9pVQFS3qXWuYiUV6fX6l5Es3jkSuw14=;
 b=BOIwyVGNCFz1FazwK00pTDbadxSy3vB7vkGmPdtH7GV9Uo15DnEEMAJpQ8N64T2gCbB9664h2KxCJXfz856yDwOQlxFXx+THbtdCq09bNWyV49rPMx5ittFi8ZAoBiDnbnoHPUDwB2KV5o3sTKU2hTbDmQRBoR3EYyxk6mkp1OIGaT1gnlupMFgbnhoCZoZEbRqYkKyMSXEfoPhCjv9ByCjBdVLr3/ta7+vbxj+Rq+Cd76NyH71G3valqc2Alv6ImecFUu2OYpvYlKxztKyHsguLAO1rWfzMefnJndHOxaufFxGC68pUyCtJVuEppxI5Cl+DDN8Q2JKCkz8hLRLopA==
Received: from TYZPR04MB5853.apcprd04.prod.outlook.com (2603:1096:400:1f3::5)
 by TYZPR04MB5736.apcprd04.prod.outlook.com (2603:1096:400:1fa::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24; Tue, 10 Sep
 2024 08:00:57 +0000
Received: from TYZPR04MB5853.apcprd04.prod.outlook.com
 ([fe80::ae7d:7486:9319:8d96]) by TYZPR04MB5853.apcprd04.prod.outlook.com
 ([fe80::ae7d:7486:9319:8d96%6]) with mapi id 15.20.7939.022; Tue, 10 Sep 2024
 08:00:56 +0000
From: Delphine_CC_Chiu/WYHQ/Wiwynn <Delphine_CC_Chiu@wiwynn.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Delphine_CC_Chiu/WYHQ/Wiwynn
	<Delphine_CC_Chiu@wiwynn.com>, "patrick@stwcx.xyz" <patrick@stwcx.xyz>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery
	<andrew@codeconstruct.com.au>
CC: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1] ARM: dts: aspeed: yosemite4: Enable watchdog2
Thread-Topic: [PATCH v1] ARM: dts: aspeed: yosemite4: Enable watchdog2
Thread-Index: AQHbA1OBubztkEY750ecUrPichXVX7JQqEKw
Date: Tue, 10 Sep 2024 08:00:56 +0000
Message-ID:
 <TYZPR04MB58530ED42D2087D9E2441207D69A2@TYZPR04MB5853.apcprd04.prod.outlook.com>
References: <20240910031420.2295727-1-Delphine_CC_Chiu@wiwynn.com>
 <08b9c12d-1b53-4036-88fa-4ed086f6938d@kernel.org>
In-Reply-To: <08b9c12d-1b53-4036-88fa-4ed086f6938d@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wiwynn.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR04MB5853:EE_|TYZPR04MB5736:EE_
x-ms-office365-filtering-correlation-id: 631ce1e1-3d89-4384-a156-08dcd16eb393
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?dWlXT29nT0hXVlk1TGs2MmR2ZGc5bWR5UUp2T1Q5ZVU4NUpLYkNNTVN4TjhB?=
 =?utf-8?B?cVBmQWRDYVhrUWlTYStWV1NRRzBmekZGWHRPMEN1dHBPZXQ5b3pybzZXZHhs?=
 =?utf-8?B?bFJpQ2IyNm1zRzljcjNPbitOOFc2WFBtdDhIMXhvUnNGQ2JJWG5TQmdEaWk1?=
 =?utf-8?B?RnZaSUhBVHpTcDFJK0VFTWJFWXMrM1Z4dENtcTFuNEFVT0M5amNSckdVNDhs?=
 =?utf-8?B?VzhmcEFWcFk0MG05VGYwY2FKTTlyT01wYTliZDM2dXRSamJHUWd5Y0NZOEFk?=
 =?utf-8?B?RG5uYnBMUmtWeFBVUk4zUFQ0VXIvLzlxMzFLMUdmWUR0ZDlFV3NIRERobjdQ?=
 =?utf-8?B?cXBwa1BvSmtpUWRiaEt0QUNQOGF3dGcyaXpkdXhQRnBwME9QUStKbWxIbmRn?=
 =?utf-8?B?enZNSDRlU1RXWTY4a0wyODZpZWpnY2pIU21qTFM0ZHkrdTBkbk9aRVVDTUoz?=
 =?utf-8?B?NG5tUWNmOUxodnA1QXhjc2trQlJHQWFNYkVWQW9BSXFOT3Fmc1JWNlowNW1R?=
 =?utf-8?B?akNjbHZMdklMUnA2Yzd0VTVaQkwraUhNakx0cENQWG5kMXUzOXh0Q1pxRWpG?=
 =?utf-8?B?ekdON1hYYnliWHBTcUV2Q3pMK2hrd204MVEyUHRjZ0Q2anl6S1Jpbk1laWkr?=
 =?utf-8?B?RmZCMHA3QXhvQVBWbTNwMVkzUnVscHhzeElRNjZoQ3BpOUpTSThZZ2RoWEdm?=
 =?utf-8?B?dVFlWFNNaDBiYlhpNTZHWVJ3all1Vis4V2JWT2pFbStBZXB5NmNKcG9yN2Nh?=
 =?utf-8?B?Z3h0RnFGR2NvejFVbjBGd1NaK3RGU2tMVkhqMm1SZGFBS0p3bFU5SzhCYVBJ?=
 =?utf-8?B?cVMzRkc2Yll3aURacnk2dTNhZFBvdXpSRUpOSk8xRUl2ZlkvbHpnZlJQeDJh?=
 =?utf-8?B?dG5JOUdMVW5VNEhNd2pDUXVHN1FIajVJV0w3Y2VJV1JGU1FDdUIrSXE3T3Jq?=
 =?utf-8?B?RVA4aHNwaVRMdDFDYmsvSFVsS0Nic3VNOUJtc3RSQWdUVnIwOHlmUUphR3BT?=
 =?utf-8?B?Ym9tS0o1cjMveklTZXRuaXVmOUtHbC9LYmorbEN0d0dhTTMzdlpTckxXNWxs?=
 =?utf-8?B?blFVSHpGbG15Z1o5WE5Ed2pVeHZHakxnZ3U0a0NaWkl0VUlFTkZBQlRwSHRt?=
 =?utf-8?B?OHpuaTFDNkY2VnNNRlIyRjVINW4xTDJWQkxEbTVlS3BWN04vL1pNZlJUenV3?=
 =?utf-8?B?SE03ZlkwMXBwS1l1bXhEQzc4bS82ak9PQTR6OEJqc0JOcEp6a0RJR2JhTGlx?=
 =?utf-8?B?dlREWFhHZUtsVEpKYzFYZW5tZVJDcm1YcXVjWUpzUUtCZ2l2bU1LdHE0OXlV?=
 =?utf-8?B?N3lhTDJieWVsVDJ4dGhteWE3VTZsMGlxcUEzbWZtbjQrTnZZMGwvd0RsYktl?=
 =?utf-8?B?UUFNdi9qWFVGeDYxUVhYWGpXVkJIcXQ5L1RMOWVHOXpSWnFaVHlpWG9jY1NV?=
 =?utf-8?B?M3phbDU2RlYzME9wRjBYcVJyd3Rwa2NsajdMdTAyc3l6bUtnRVNqR01IZURr?=
 =?utf-8?B?cXo5cWk5MGNoOWFiZExzMmNveVB4MlJLWDFnU2tBNlFJZG5PbDRGK3Y0ZTNy?=
 =?utf-8?B?STdBSXpwSEZuWjB4eHRVRW5ZZlM1dlJUOFhEUDUremIwcEdrQVZMK3p2d3BB?=
 =?utf-8?B?c0o2UWpFNWtVK25SaCtNcXpkRkhESGJOOXdIZWxoOTdtNHdxMWZDbmZtNlgr?=
 =?utf-8?B?aXptNjZYTVJhZmtjMlFaZi9rOWdSZVF5RStFTy8zZE00MHVRTWpOcVhCa0Fo?=
 =?utf-8?B?dTNoTVoyTHBYb1lJamVJTEZjVml5TEdpMGpjRmROOVJOZStPMnliVDMxWjVo?=
 =?utf-8?B?ZlJGQzVlNDcvYjM2Q3JsMkVHNEhYTU14aEtDTzlzZ2gvU3U4ak5CdVRJWHRP?=
 =?utf-8?B?UkliZkVxTXVaTkhxcUxRZDl4ZDA2eHlxU1BicHhnVlB2Rmc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR04MB5853.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UFhHVjF5Yjgvb1NZcmRpWFNGOVZ0c29DcXlEaWx0aHlpdnBGdUE0QmlYWnlv?=
 =?utf-8?B?WllHVlVUYkJnUm1BN0NnYzB6aDB0MWNQSDJpOTJKUUZlVkY5U1hYNldWVlU4?=
 =?utf-8?B?bGtrTFlmSzl0ZkQzNEZTS053dVNMdkUxdEhRaDM4WmJSd2l0elg4b3ZiYnRZ?=
 =?utf-8?B?N1dmMytWVnVNMGpybE55YWVhSTVZSjJISlBseVVSL3ZkeFNHU3RmZDYwMGxE?=
 =?utf-8?B?akVwTlNzQllucW1CSHBiSHJ0U2ZsU0JyL252TkJ0cVZTUGEzZWI3ZndIRDFs?=
 =?utf-8?B?bGg0cEFrYVZTR0pTcmRBMmV5WkpHTlFYdlFrQnVGcmtVWnB1Q1pRVFE2ZXhF?=
 =?utf-8?B?L3Jud1RzZmNxZ0ZiTVgzakJFWXBTZVg3VXVkVGRzdXRTQ0NmMExpZ1VyNnpY?=
 =?utf-8?B?MlhJQkU4VzE3SUs1SDRiQVJ2RW9FenBWZnZXZEIvMnF1RWEydytISkxnTHJk?=
 =?utf-8?B?bXRpK0xIM3U1UHltMFBOcDdUaExtWXRrYXR6cXNpMjRQNkZFT1VpU0ZiOGsr?=
 =?utf-8?B?MGJNOGIyZ0dFZnI4aGpnS3diN09jYlBncy9nbmZXdThmSkpwVHJRUmFVR0Vo?=
 =?utf-8?B?d0tMa1FJSlVxYVkwMFRKOG1pNy9UMHdSdlRZa3dVaHdyWm1qVGZyYU1aMVZD?=
 =?utf-8?B?RWwvVFRndE1RS1FSa1gzQU4va0pnK1RUWlhud3dDaE5rRmNvN2VJaHkzdTdO?=
 =?utf-8?B?QzhKcjdLclh4OW41ZmtjdXVSdlBTMkRXRVVLYTl5MHh5MlNSMTdHTUpYaGFN?=
 =?utf-8?B?eWVBdk9OYm1FcGJNdkdJUHVLV3RJOTNWTDFUaEs0TFFrK2gvSUhab1BKY2Zq?=
 =?utf-8?B?UEhCNEN1dTRuaTVyTHg2ZURUSzdSblZRV3MrRGVwN0Z4dExmaGgrclY4cUc1?=
 =?utf-8?B?STZ0ZktUSXNpMmR5QWNPZVBKQW9GYjZrbEZ0M2trMDljOG1CRHJjNVdxNTNY?=
 =?utf-8?B?WDhkeWRHOWJpazZYbC9kWngvRkQ2M0p1K3lOaitPdUVSelhnd0w4dkh3ZDRZ?=
 =?utf-8?B?QXpFeXZpSDFsYkI0RUhHRW4rZ1kyR1JTWmFCb2xFbjFlWkdSVmdPbnV0Skts?=
 =?utf-8?B?K0hvclRadzF6Q29SMEhwZGI5aUY1aUZTbkFjUkkveGRWRlRPN0tqS0M5UmdY?=
 =?utf-8?B?Nmt5L091RzRVOHFiWlQ2T0QyVUVvN2lDS25xUmk1ZHJnSnJsbllkQkhFUWh4?=
 =?utf-8?B?UjdwcEM4RitPTnJ2YW1HdnBRbktBSlFXS3hXNVM5c0tYWGdJN09EMXJ2MHJV?=
 =?utf-8?B?Yng0TnBLRFpMNUttN2g3ZFVKZ1NMaXVmVUZUNHZYdW84dU9lVkFFekNNUTN1?=
 =?utf-8?B?WmtuQVNTZTRDZGpycEhzbVloTTQwYmN4TUlpZU81N1p5dHlFZTlsaUUvOVN5?=
 =?utf-8?B?TXhkdEswcWcwMUx2ciswMjl5TzM4MmFWNVFmdzBsa1BocEV6Wk10RnF0ODRj?=
 =?utf-8?B?eGxCL25VWXEyWnByVFd6N2dwbTErR2xHa3BuVkxXUmJXdlNJbXYyci9YdUM0?=
 =?utf-8?B?bzFNTTFGOW5iQ242ZndqcjNOUlY0cVVhenY2NUQwUVI4Q28wVG9pMXkxaGdC?=
 =?utf-8?B?N2ZxTUtZV1JIRXJ3UmI5MXdSdkZiSTFKbkEwaG1iVEYyNXFhTGNSaVJ6TExr?=
 =?utf-8?B?RmxjejlBU2oxOVFYdmxNOXZ6NU9rMlpYcCtWNVl2V1kxR0oxUEVwck9wTEo4?=
 =?utf-8?B?WW1zY29NMnF0TFhPOE5JQWJ1RWZnakNMTDNBeGhUUGNrMUZTM1NnR0s0S1d6?=
 =?utf-8?B?VDZBUEFpcFNBbDRRVGgxVlBsRDhqMTQ5MXllV3h4ck9nTHdNbjNLaVZXVUtj?=
 =?utf-8?B?anAxMERoVFdOamlrU1RKd29lY01wbGpSQ0NPa0U2Q0poUU5kVFAvdUUrMkNO?=
 =?utf-8?B?a3JMQ3pqYnY5TWhoUFg3blpCcjZjTXlrQTRIQUg1czRuMXNnMTM1VEJEM08x?=
 =?utf-8?B?a0FtSjlVNldCUmNGSU50MGEvbkFqbmlXTkRCVXB2WnQxMUNyQmtSdEZvNnEz?=
 =?utf-8?B?b1hRK0tjNklhQW96NUp2d2dKMVNPVmZTN29vSmZXUGZ5Q0czcnQwNEpVVnRV?=
 =?utf-8?B?ZXNRb0kxN2ttWURKLzE2dEVxbzllbjJKakU3VmE5YmgxMzhjaVpkTUpaZW80?=
 =?utf-8?Q?yTeqFJTY7C4x7HVplGRFCelPR?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR04MB5853.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 631ce1e1-3d89-4384-a156-08dcd16eb393
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2024 08:00:56.8959
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /WjzxJ5zn/0ldFIsKfADdsh0Q2lkATu2+mWgeB5JSmfBLHvR6yQkj1R2mUZr+Xe+pKpauoLj2YseN3hijdpT+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR04MB5736

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3J6eXN6dG9mIEtvemxv
d3NraSA8a3J6a0BrZXJuZWwub3JnPg0KPiBTZW50OiBUdWVzZGF5LCBTZXB0ZW1iZXIgMTAsIDIw
MjQgMzozMSBQTQ0KPiBUbzogRGVscGhpbmVfQ0NfQ2hpdS9XWUhRL1dpd3lubiA8RGVscGhpbmVf
Q0NfQ2hpdUB3aXd5bm4uY29tPjsNCj4gcGF0cmlja0BzdHdjeC54eXo7IFJvYiBIZXJyaW5nIDxy
b2JoQGtlcm5lbC5vcmc+OyBLcnp5c3p0b2YgS296bG93c2tpDQo+IDxrcnprK2R0QGtlcm5lbC5v
cmc+OyBDb25vciBEb29sZXkgPGNvbm9yK2R0QGtlcm5lbC5vcmc+OyBKb2VsIFN0YW5sZXkNCj4g
PGpvZWxAam1zLmlkLmF1PjsgQW5kcmV3IEplZmZlcnkgPGFuZHJld0Bjb2RlY29uc3RydWN0LmNv
bS5hdT4NCj4gQ2M6IFJpY2t5IENYIFd1IDxyaWNreS5jeC53dS53aXd5bm5AZ21haWwuY29tPjsN
Cj4gZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5m
cmFkZWFkLm9yZzsNCj4gbGludXgtYXNwZWVkQGxpc3RzLm96bGFicy5vcmc7IGxpbnV4LWtlcm5l
bEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MV0gQVJNOiBkdHM6IGFz
cGVlZDogeW9zZW1pdGU0OiBFbmFibGUgd2F0Y2hkb2cyDQo+IA0KPiAgW0V4dGVybmFsIFNlbmRl
cl0NCj4gDQo+ICBbRXh0ZXJuYWwgU2VuZGVyXQ0KPiANCj4gT24gMTAvMDkvMjAyNCAwNToxNCwg
RGVscGhpbmUgQ0MgQ2hpdSB3cm90ZToNCj4gPiBGcm9tOiBSaWNreSBDWCBXdSA8cmlja3kuY3gu
d3Uud2l3eW5uQGdtYWlsLmNvbT4NCj4gPg0KPiA+IEVuYWJsZSB3YXRjaGRvZzIgc2V0dGluZyBm
b3IgeW9zZW1pdGU0IHN5c3RlbS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFJpY2t5IENYIFd1
IDxyaWNreS5jeC53dS53aXd5bm5AZ21haWwuY29tPg0KPiANCj4gTm90aGluZyBpbXByb3ZlZC4N
Cj4gDQo+IEkgZG9uJ3QgdW5kZXJzdGFuZCB3aHkgeW91IGtlZXAgc2VuZGluZyB0aGUgc2FtZSwg
aWdub3JpbmcgZmVlZGJhY2suDQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0KU29y
cnkgZm9yIG1pc3NpbmcgdGhlIFNvQiBpbiB0aGlzIHBhdGNoLg0KSSdsbCB1cGRhdGUgdGhlIFNv
QiBpbiB2MiBwYXRjaC4NCg==


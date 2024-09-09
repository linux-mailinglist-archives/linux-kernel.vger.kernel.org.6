Return-Path: <linux-kernel+bounces-320498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D98C970B46
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 03:34:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27BD9B21403
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 01:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 433FE175AE;
	Mon,  9 Sep 2024 01:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="glez4UNh"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2064.outbound.protection.outlook.com [40.107.255.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574FB12B64;
	Mon,  9 Sep 2024 01:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725845670; cv=fail; b=Fg+6mvv2B1wymwNinvh/Iyzbp8QgHsunR12+9W20PPy5+Zc4iDKKfDf3hw9FjXX9JrvFzJI2ha+o9T8vmMVAN8hja+trweiWKdUwWjHAzmlYJnKLJ9p0x/1/VW+9BGdPen2unS9i8to0fMF+YjYxK5FnIx0pmestzudsaN1q+xA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725845670; c=relaxed/simple;
	bh=izGOhggFgKKwR9sktfo8THbtNnCpVv1Rfc7KrjVSplM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ahyyhjuOZR5HH6xHzSutPyKOL/CLk5YqBf26a87/8RlZfqKqpoIGCtd6RCULmANVuM10s2/yJ+DsEiLnNz0WjZ00sUWqNlks443YY4BhXXnkiu1hK7GxmPYpk2Z+ReICT/IkhphGF1PtNN8aeW3fXYtYCstkUgHNEHFQXizYyIQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=glez4UNh; arc=fail smtp.client-ip=40.107.255.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SlIYE9t08+Ewe6rBshhFdwgNARB/TQbm+i2siTQAJl1S3KXAl4wOIAqKuf6WT8acS7iovd6qxK6ZhrRy+eIBb7/tZpBuux+yOvIr0apzG3pvcJ+ExtWmQjgTD3WN4Eehap/yEZS1WIRPwz+9JiicIwX4IncksC1N9YWkODdv3KAVA9VRHHE71sDAHkFkwmkFKiMsdadxckTTajBpeUUNAOXDiLEDyP2Ejaupp9NebnztwVqtYozmcK0xOL/v8lclaWlUbUPtDtvud3Ox8IwEeAhnKSd7NY7ZjS32q3D0c65+zJ9wWhR3jPXV62/b9w5wbg1ap6Age6KNHPFEElfE7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=izGOhggFgKKwR9sktfo8THbtNnCpVv1Rfc7KrjVSplM=;
 b=ZSK0hF0iCDQiZltEAC9af8mQlTUvO37lXwE6DSPd3Nsff67m/wvW02RYLDfcWfr6JcJ+YuAijVPymhGk7Y2k8aRAPI1KtMBS/plFrMVlG4SUEzWakr4ZypxfrJKqXwrqEXUpvBYbYFWgFkFEpOAqe+v173FZXhPq1xzE8XvsXOmSJk8crn3EI3G4Cj5OUfgi2xlG9P8BAvwGXZr+9o8w/9qWPSXpLk/4sDF/5KQtMgQQ6fsbZ+6soz7pYUq/RouJzi1oNvzhleimcwX37E7nkLGMHsFBNPp57ysla2UMnqh3wD92idz1T2NQJJbDHtdKOFPNqUYKNXp1ikkCTdfelA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wiwynn.com; dmarc=pass action=none header.from=wiwynn.com;
 dkim=pass header.d=wiwynn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=izGOhggFgKKwR9sktfo8THbtNnCpVv1Rfc7KrjVSplM=;
 b=glez4UNhhJZ/P7kZU3hTsBauNUy460sNqoCO6P1++xphaGGAdttBHe4wuCRDqVdsDv/+jVdZuJ2/9k5E9Sd9uiRwJZGilH/VKQIKE5yZc6e/UEn8HLChIUnhswiL5rh7Gh+COyeg95ZFqPfZuPwsUThF0N3e3ow6b4ibx0oWV0Yu93uc2l0HAweQFUMqnFG0S9NDB/ZaQA2Sd/A6NPAHhQHZ03cInsM2VJiQ/G+AAZkZRz7B6mVEehWsuCWvN7oBscWOZezLL4//X6to/FQ9gYOSkVWsSHSGEbO0y31IomMu43AUood7N7nyxGqRPUh/G9IU9xrLv36EGO0x8UM++g==
Received: from TYZPR04MB5853.apcprd04.prod.outlook.com (2603:1096:400:1f3::5)
 by TYZPR04MB5854.apcprd04.prod.outlook.com (2603:1096:400:1f2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.20; Mon, 9 Sep
 2024 01:34:25 +0000
Received: from TYZPR04MB5853.apcprd04.prod.outlook.com
 ([fe80::ae7d:7486:9319:8d96]) by TYZPR04MB5853.apcprd04.prod.outlook.com
 ([fe80::ae7d:7486:9319:8d96%6]) with mapi id 15.20.7939.022; Mon, 9 Sep 2024
 01:34:24 +0000
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
Subject: RE: [PATCH v16 1/3] ARM: dts: aspeed: yosemite4: Revise i2c-mux
 devices
Thread-Topic: [PATCH v16 1/3] ARM: dts: aspeed: yosemite4: Revise i2c-mux
 devices
Thread-Index: AQHbAFNZUdZFaIsylUCg3g3GXtkl9rJOrxwQ
Date: Mon, 9 Sep 2024 01:34:24 +0000
Message-ID:
 <TYZPR04MB5853405445CB5CC1B7E95A09D6992@TYZPR04MB5853.apcprd04.prod.outlook.com>
References: <20240906092438.1047225-1-Delphine_CC_Chiu@wiwynn.com>
 <20240906092438.1047225-2-Delphine_CC_Chiu@wiwynn.com>
 <e89bf774-12e3-4360-919e-f93148ce3456@kernel.org>
In-Reply-To: <e89bf774-12e3-4360-919e-f93148ce3456@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wiwynn.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR04MB5853:EE_|TYZPR04MB5854:EE_
x-ms-office365-filtering-correlation-id: eca13c43-7f8f-4e0b-3ff0-08dcd06f8996
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Z2EzQzd1MzdacmdoUGhta1pKbnMwK2dmNmoxRkJEczV5V1JCRGk2cFFCUVkr?=
 =?utf-8?B?bDhsaVZzdTR0dXAvcDdDbGpxbTJzMXpwRHdsTDZReFRuNEp4WHRCaURybWg0?=
 =?utf-8?B?UXRRaGZId2pqMEtRV0JESXZhbUE5TVNpTjdGQzRtaUwyM2JPT3hQVkxJWkpi?=
 =?utf-8?B?ZlE2b3F5Q09NbjlDeGpwaURGWXJWK2xyOEdVbmNlcUJoYkF3UVV4elhFWFpp?=
 =?utf-8?B?clh5dDJPNFdHK3pEYmp4dDlReXpSYUtwbkNwM1QzdlVKaHZHZ00yeFBTY3JM?=
 =?utf-8?B?c25TNTZYYTBRc3krMzNzaUJzMGl4RGJBVzNtUFVxa2xTZzYwQUFQc1FKd1NT?=
 =?utf-8?B?cERCbGE0WVFxOU5wOGJiRkVEZWRMekpRYlZGUmNGZkVnN3d5Z1cvNjB4aGhP?=
 =?utf-8?B?UDBld1BFTi92YUFUMHc4ZDFhdzlndVA2OEc0aGpRZUN1c3FDUGczSnhJMi9n?=
 =?utf-8?B?TzlWajFVTTNsZ3FlTXEwOTBkVGNhVmJlWkVNUzI4R3V3Qy95WmgrUFFQT1d3?=
 =?utf-8?B?MktMMzh1T1k4ZTJtcVNyVnFXTzB5a05CV0JpUXRwcEtzRVFtVVV4TTEzT0xy?=
 =?utf-8?B?Q0E2VTNVZGIvQnZ3NDJ5SEYybFU3a0U2QndtQ3NjT2N6alBXaTA3dDVpOE9k?=
 =?utf-8?B?Y0RNTzRwVjlFSHZsRmJyM05OVkNqVEJObVBqUENxUWJ0YlNFekNoTDMxVUVx?=
 =?utf-8?B?U0RFazZTZ1BHTWNlRFhsNEJLQkF0TzBqa3ZSTGliaG5hWFdmNXdYR0tvN3Nv?=
 =?utf-8?B?WkowUTlZcGFwNHZFbDN0a3FkQWxRSnVpbkZkODZxUlJ4bkY4RTF5akxpNm5T?=
 =?utf-8?B?UC8xdDNiOGdacGIrZVRUNENhcVdRbWdVVVFFVUVRbW5Ib2taaXpYMzUrdHY5?=
 =?utf-8?B?MVM4amxLb3JYYlpDTFpzSStSUXRoMHJzWlc4aW9DQmtISEE5cWg1ZWhVNW1h?=
 =?utf-8?B?VFNjUVdoM0E5eVdnY3JWWG0vV0RHejRxNGVTSXRVa2ZwYVpLYlhIQlRtWExq?=
 =?utf-8?B?a2NTVUZEMHM5THphM2ExZjdpbGJZVnd6bWRMcnRmWFdTT05GTzUxVmtGbDdV?=
 =?utf-8?B?Sm5nRnM0S2RNMzV6SkJoNWw3TmVlWW50QXBDNDRHby9FcHFQZHJIY0o1cU1O?=
 =?utf-8?B?ckxCL3VzcGF4NlBEUElhWFYvdnl1YU16cm5YOEQ2R3FoaVVwVTNLUVJDZ2JX?=
 =?utf-8?B?SVRrUDVHUUQ3NXZONWk2ZUp3ZWdsOG81VE0rUWRQSHF5WHVFNExaT0VnbDVU?=
 =?utf-8?B?SDB2R0RVOWJzaW1zUXlRN0k5bHM2Vzh2S1cyWTYxQWRlNzdHRGFHMkFYZk1I?=
 =?utf-8?B?KzgvcERoQ3BxWnJ2OW1RV0JvQnVsR2trSGFDaWlidm1EL1VOQ1RnbmdWWEl5?=
 =?utf-8?B?aG1tNDI5Nm9vVDVOWER1V0NzUWhsNUtNdXN5ZmxiR1pMQTRpdWhEd1BVTzdv?=
 =?utf-8?B?dklsMmszbUV0STc0aU9KRGRucGE5NVVZQ1BmaUh3WGNuWnVjOUZCOXNVaVJw?=
 =?utf-8?B?WkNYL2x5c3A5Qm52MVFQQ2lyOVBIKzVPTnlzZXcxMkpDNzNUTEpOMXFmbzAw?=
 =?utf-8?B?L0NmVmtkaWNKZDU1dG85b242WGgwYzhVNW5CaTFpN2Y2MlV0cmFSdXFCVk9E?=
 =?utf-8?B?TzlFbFQ3WHhmaDNuaFUrZTAwWEFuRmQ1RTN6NmtmR2xpQXBKYUV2M1gxRklW?=
 =?utf-8?B?MDRya2tYOGJaN2gyNktJU3d6KzhYUk9ZUkNoTHZKcllHQnFmdFlJOE5KSDRU?=
 =?utf-8?B?V0dFRW5nRWRJdGx0OFdPdmxVTXJ1QzZLc1VKWVplRTdhdExRS01ZNm0yWGFt?=
 =?utf-8?B?Uk0ybHVsdWZOSG45YUFBOVB4MXkyTDlZY3UvQ0l6REZ0RTRNZlNsZXdjSHAz?=
 =?utf-8?B?eGZmWURtb1pvVno5Q25zK1EwSE41Ui9tdy9oa0FBZVNoSXc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR04MB5853.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UklNNTdNcllpS2RJK3hMZGdlL2cra3FuaG9MbTZqQmZwajBuclBydzRMKzln?=
 =?utf-8?B?bmh4U2RHcGZpNHVNNUVaZjEwVXVLakFPdEs1ZElWbCs2aFJ0ZkdIZHNZa01m?=
 =?utf-8?B?SWU1TWRGbkNpRE9wUy9LTS84UXlLcmtjY3dtUWx2YWo5Vi9VQ3M1YlBJM3Vv?=
 =?utf-8?B?OW1BMkV5MytCVUxDVkhldVN4WS9ZMmhqVmVic0Zha3dOUWxrK1hNTk1KWGlP?=
 =?utf-8?B?d015b2NWOVdkTXovcmRPa0FQTmZyK2dTQ2Q2RlYzS09CZG11cmYrOWtkbnNr?=
 =?utf-8?B?UHN6cFNGVzBCaEt5bGdCaDB6dXF2WlY1em4vQnVZRlU1SWJNR3d5KzlWTmxp?=
 =?utf-8?B?elExZDN2UTN5L1diOEFndkd6T3prelRUNStzRkZodmo5cStRYmlERlE3T09u?=
 =?utf-8?B?cU5mcWNlTDFrUE9zMEk2SEtXekdXU3pWclFacUpYMEVvd1R1aVhiSjUwU29C?=
 =?utf-8?B?WkJ6bGxXVndCMW92YzNHOUZkOWxiSElGNG5mZEFTWExLQUh6blREU0RyUlBU?=
 =?utf-8?B?M0NZaGhwVVdONXhpc08xcjNFVTNFTUhJTTlPYzhXc2NQWnR5L282TEZqU2R1?=
 =?utf-8?B?Tzk2T3BxTHBpYkl0VU0xMWtIa29nU282Q1dSdFBScHFGTFk0UDNWNFh1cEZT?=
 =?utf-8?B?R2kzODYvT2dlUGtnVnNlbkR2VVVyMVg3cUZ5aU0wTFNhYmEvUWtMa1phczZC?=
 =?utf-8?B?Y3dIejczNEhQR01FbG13NGxuWTJTUHlIbmdzd1BSQjJkZFpvMVE3ZnZhRkNs?=
 =?utf-8?B?WUxWL1J2eFBVbjY3K0RaUzltcnlsVWtha0x0aVJZcGhGdHVvd29sQ1VqL1pz?=
 =?utf-8?B?UnY0bVJManZwSjQ0eUVGQ1Zud1YxWFU2RjVLODZIVGZFRGNYQ2lWS011U25S?=
 =?utf-8?B?cGk4Q1N3R3M1dlZCdzJjdjJ4bm5EbHI0elZ4TnNOSkJlWWFOSjljMnZoUE42?=
 =?utf-8?B?QlBSVWRZdzJMbitadWJjQkdhVFgwK2JzUGkxV0hlTkFWdnhuUTR0UFhCVmlG?=
 =?utf-8?B?SWE5TlBnU2FjOVV6NDhDNHVEa29IYmxhZXh2azZPME0vb2pDNWoxclpUMVNR?=
 =?utf-8?B?aGx2NHljTThudHpiVG5XaVpkb0tYUHlvRWxOZngyVlZtSE9PWUJ0UHprQTNQ?=
 =?utf-8?B?UFBrOG9naW0wdmFrTzlIMUFBT0JjQWlRMWhjbDdTcmM4MmxwN0JCc2E4aGc3?=
 =?utf-8?B?bTcwVXNuOUkyb3lVdVdPQTc5VVNwMENCeXpxcG5EZFVXdllYWlZwY3lBbVBn?=
 =?utf-8?B?SkpORGhCNFRlamFoK040YmdEMWsrWG5WVEU5TVEzMTJ5M01IbUtjczY3NTRp?=
 =?utf-8?B?SVQ2a0gvSGpUOWhGWkIzVTRDcUxab2Nva2lmZ0NpRFFMNEpVVmlCLzF2Rm0w?=
 =?utf-8?B?ekduZWM1RDZFNnJwSUJOUlVxNVdkMjEwNU1HbFNmb1JoS0JWMGpXZDFray9E?=
 =?utf-8?B?UlVrNWxtRjZreS9Wd1U4ak9BRFBFZnFmWkJLS2paUTdBOUVJa3NqbUxXYjBL?=
 =?utf-8?B?d240MFA1dzB3R21aMGN2Z0xZTHVNUWttV3BKNjg5bUYxUHpzY1IrdlF1bUNY?=
 =?utf-8?B?VUZEYk9sRVlzVTR6M1RUdzJVK0xONlFIc2Z0NlZYelZKVXhVUGxON2txK1Y2?=
 =?utf-8?B?R0tCeXF1WUduNThxdWdhRzh6alZGd01oQWsxcVhDWGFxYjFiZ0N4SzVuTmxD?=
 =?utf-8?B?YmlkdHFSRTZiM2UwSkZTd2JRcWJhMnFYNnBaU1lGcW1DU0RsVENWUHFxV3Vi?=
 =?utf-8?B?NU9oT3E4cnUwT0ZJS2ZWNnBsVW1vaXpiV1VPZmVmNEhtbFpCSSs5eGlZanVZ?=
 =?utf-8?B?VHZpbnczMDk0UTcyVXM1SjhxZGlqZHJxZ010cFdTVko1YUpMeEQwMDgyaDBO?=
 =?utf-8?B?dm9vbUpITmpZQnRkU0EybGpDR2pQbUdCcis0c3ExMkI2TTk1M1VXK1FPbEJx?=
 =?utf-8?B?WG82M1QwbXNBdjlPemx0bGlsU3dqcDMyWENrWTdLZWh6cWJHMndmQ25OMmYw?=
 =?utf-8?B?ZXFESFFYWVhmYy9kOXltQ2orbGRwbUtCWFNjYkxoMk4rNmYvWlM4Q2tMdSsy?=
 =?utf-8?B?MHdwNm0wWS8rclZOcXN1ZWVJWHZGcUc2R1liNmQ4NExLaU4vWEVwZHMvM1B0?=
 =?utf-8?Q?y64a+3Qy8Fj5jig+yIoH/oBpA?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: eca13c43-7f8f-4e0b-3ff0-08dcd06f8996
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2024 01:34:24.7534
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QMM9rbtjE/55B+0sjk6i0NKlqXZ52QFEKNzB2p37i+XcAjqt5K4aWYu/pGsPhXt/yFu+z/6qYdQCaG1ZP1JDxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR04MB5854

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3J6eXN6dG9mIEtvemxv
d3NraSA8a3J6a0BrZXJuZWwub3JnPg0KPiBTZW50OiBGcmlkYXksIFNlcHRlbWJlciA2LCAyMDI0
IDY6MDQgUE0NCj4gVG86IERlbHBoaW5lX0NDX0NoaXUvV1lIUS9XaXd5bm4gPERlbHBoaW5lX0ND
X0NoaXVAd2l3eW5uLmNvbT47DQo+IHBhdHJpY2tAc3R3Y3gueHl6OyBSb2IgSGVycmluZyA8cm9i
aEBrZXJuZWwub3JnPjsgS3J6eXN6dG9mIEtvemxvd3NraQ0KPiA8a3J6aytkdEBrZXJuZWwub3Jn
PjsgQ29ub3IgRG9vbGV5IDxjb25vcitkdEBrZXJuZWwub3JnPjsgSm9lbCBTdGFubGV5DQo+IDxq
b2VsQGptcy5pZC5hdT47IEFuZHJldyBKZWZmZXJ5IDxhbmRyZXdAY29kZWNvbnN0cnVjdC5jb20u
YXU+DQo+IENjOiBSaWNreSBDWCBXdSA8cmlja3kuY3gud3Uud2l3eW5uQGdtYWlsLmNvbT47DQo+
IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJh
ZGVhZC5vcmc7DQo+IGxpbnV4LWFzcGVlZEBsaXN0cy5vemxhYnMub3JnOyBsaW51eC1rZXJuZWxA
dmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjE2IDEvM10gQVJNOiBkdHM6
IGFzcGVlZDogeW9zZW1pdGU0OiBSZXZpc2UgaTJjLW11eA0KPiBkZXZpY2VzDQo+IA0KPiAgW0V4
dGVybmFsIFNlbmRlcl0NCj4gDQo+ICBbRXh0ZXJuYWwgU2VuZGVyXQ0KPiANCj4gT24gMDYvMDkv
MjAyNCAxMToyNCwgRGVscGhpbmUgQ0MgQ2hpdSB3cm90ZToNCj4gPiBGcm9tOiBSaWNreSBDWCBX
dSA8cmlja3kuY3gud3Uud2l3eW5uQGdtYWlsLmNvbT4NCj4gPg0KPiA+IFJldmlzZSBZb3NlbWl0
ZSA0IGRldmljZXRyZWUgZm9yIGRldmljZXMgYmVoaW5kIGkyYy1tdXgNCj4gPiAtIEFkZCBncGlv
IGFuZCBlZXByb20gYmVoaW5kIGkyYy1tdXgNCj4gPiAtIFJlbW92ZSByZWR1bmRhbnQgaWRsZS1z
dGF0ZSBzZXR0aW5nIGZvciBpMmMtbXV4DQo+ID4gLSBSZXZpc2UgYWRkcmVzcyBvZiBtYXgzMTc5
MCBkZXZpY2VzIGFmdGVyIGkyYy1tdXguDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBSaWNreSBD
WCBXdSA8cmlja3kuY3gud3Uud2l3eW5uQGdtYWlsLmNvbT4NCj4gDQo+IE1pc3NpbmcgU29CLiBP
biBhbGwgeW91ciBwYXRjaHNldHMuDQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0K
SGkgS3J6eXN6dG9mLA0KU29ycnkgdG8gYm90aGVyIHlvdSB3aXRoIHRoZSBwcmV2aW91cyB2ZXJz
aW9uIG9mIHRoZSBwYXRjaGVzLg0KV2UgYXJlIHJlb3JnYW5pemluZyB0aGUgcGF0Y2hlcyBhbmQg
d2lsbCBydW4gZHRzIGNoZWNrIGJlZm9yZSBzZW5kaW5nDQp0aGUgcGF0Y2hlcyB0byBrZXJuZWwg
b3JnLg0KDQpJIHdpbGwgdXBkYXRlIHRoZSBTb0IgaW4gdGhlIGNvbW1pdHMgaW4gdjE3IHBhdGNo
ZXMuIFRoYW5rcy4NCg==


Return-Path: <linux-kernel+bounces-353073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2CFE992807
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 11:26:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B201528147C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 09:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 854A018E372;
	Mon,  7 Oct 2024 09:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="Y+f80+CF"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2091.outbound.protection.outlook.com [40.107.215.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12401741E0;
	Mon,  7 Oct 2024 09:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728293182; cv=fail; b=U78hxFWCyuuIS40NJmPBAJ1OD00OHNUo4Ue1ua5mSyCC0/MN+W7zs93KS2NO5vHsf0oiaar/sSElbR66XpTan0yXK4FT8AWkK09gvxZGWy2RgOkQYo48SBUWapc2Hzfnk7HIInnkOQ4Fu3pLFoDQd1NvRNs2ilFleEc3Nt6nBOs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728293182; c=relaxed/simple;
	bh=Y+TaKZ3sESFl5JI/I36r1BTH9Lrxt5A4BzpWIv0QEKo=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oR1TrfzgBmOm9+j6WmRJXGNL6VJt15gxMN7G79yH0D31uY6CTRp1JRq+oB4vh21AYy1Dr2azUYNPR4XJXczKv8dLa/h8B3TVXJEaaANFMGUz9h3iuVJnbHCXw+THX65VYhLtiMR7DerzARFOlxKbW4qFtl7LnQ6688O7xPVbxho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=Y+f80+CF; arc=fail smtp.client-ip=40.107.215.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yNKU7dVmHodJRfM35kfPtrIqEZgZhU8lPMDhq58HslvZ/oJykamEG9PPBfXFe9sKckTnuOuVgI+B/Cei+jg1o3R66+tdDWbiVTGStYU0dZXvVNsz/BeY73fWVhzFrqWNkekNQiJ+PLCwqidnmAG1CQhWYVU+OpcU6A2Ab/VieE3vDsB1CU1jfZ94KFd4pKAG9eNIEYKyHCdXgrL3X7fD7TkX2XEl/exUsK6KhNFzKIjBwFFe9Eh3XiWVbZa8FZBLL1Wagg2qQzuFg6+Fv1J4K5c5xXdnHZuhHPDNDbqqAU/5p3gFSK2Hzay44YTuxSrTIUu5m/LtHDgcMFZaHgWBZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y+TaKZ3sESFl5JI/I36r1BTH9Lrxt5A4BzpWIv0QEKo=;
 b=BpsmYDpRIhpI4HsAE2vCjdZB93gcAJ2VMCOt3dcc62McU0SVmKML2cS1q4+ff5n7QSA10nsPkidOPcrUVCadcJYM7WkZIwOd0U2W7mftvk1OmGYMusge2rymbTAIt4q2XYEBHb3wzssQBiAv4Me81d+Tz8uKl3Of1r5CjtRTJToWgA0eXx7m80Llfs6QlNv8U2ty34xWj403382nF8MTw5UrN2mrDVKPO1mDz8bekdARC5Y/EDPmCoRkRoVxjEYiLYGJHQokvDJ/0u8MiiBD/shOskCooMONql0ccZKsLxvDeityuPg4iXqfBCPZOn96626TwFHd1A3jz5bDL2W9QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y+TaKZ3sESFl5JI/I36r1BTH9Lrxt5A4BzpWIv0QEKo=;
 b=Y+f80+CFgEw7/yYwZEi2F+Nv5p9/VLqVlcHpm77QbBE3tF54pKir6/Qq9GuqRq0+MbQHgmV0DQ69g9e3D62QQbjITmm5ehm32KcecFzS7NRFH35vvtYrgxkeOwJYsPiqIeD7j/6KgxSzRGbOPNwpwFEO/D9mUq8HXQSL1/xwk13tPHcqRp0IyYgSLOGq9mVOMajYZI6vu0F6PyjXpm16svGYQcN0mWndtsYfajE5UQGAMS2E4d2Xnb9l6iwLRGzdqtIOqhM3AhHXiMyXO5JeDQRSJsUMJxnMIWYmt7YKnrioP9K7zLGfeB7ZWjf2Q/NrUYzNPvbNvDx2EhjJF0z59A==
Received: from PSAPR06MB4949.apcprd06.prod.outlook.com (2603:1096:301:ad::9)
 by SEYPR06MB6984.apcprd06.prod.outlook.com (2603:1096:101:1de::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.13; Mon, 7 Oct
 2024 09:26:13 +0000
Received: from PSAPR06MB4949.apcprd06.prod.outlook.com
 ([fe80::7bdd:639a:6b94:37bf]) by PSAPR06MB4949.apcprd06.prod.outlook.com
 ([fe80::7bdd:639a:6b94:37bf%5]) with mapi id 15.20.8048.013; Mon, 7 Oct 2024
 09:26:13 +0000
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
	<linux-clk@vger.kernel.org>, BMC-SW <BMC-SW@aspeedtech.com>
Subject: RE: [PATCH v1 06/10] dt-bindings: arm: aspeed: Add aspeed,ast2700-evb
 compatible string
Thread-Topic: [PATCH v1 06/10] dt-bindings: arm: aspeed: Add
 aspeed,ast2700-evb compatible string
Thread-Index: AQHa30uNq/e/f5bPiEuBrDgfXf+vPLII244AgCBsrWCAADBKgIBR6S9Q
Date: Mon, 7 Oct 2024 09:26:13 +0000
Message-ID:
 <PSAPR06MB494943F3F34881D23CEEBD9A897D2@PSAPR06MB4949.apcprd06.prod.outlook.com>
References: <20240726110355.2181563-1-kevin_chen@aspeedtech.com>
 <20240726110355.2181563-7-kevin_chen@aspeedtech.com>
 <371a7c7b-de32-4f97-b4c7-3c0ad0732e1a@kernel.org>
 <PSAPR06MB4949F7F617DB4A371567EB4789812@PSAPR06MB4949.apcprd06.prod.outlook.com>
 <2b40d7e4-10f5-406a-9ac9-f9292a52a659@kernel.org>
In-Reply-To: <2b40d7e4-10f5-406a-9ac9-f9292a52a659@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAPR06MB4949:EE_|SEYPR06MB6984:EE_
x-ms-office365-filtering-correlation-id: 57b77939-a45c-4d70-6516-08dce6b21673
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|366016|1800799024|376014|38070700018|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?V3B1TDFMZlhEOVJ3bUVrZXQ2SkkzN24yeWZhWXAybzIrYk9PekRDbitkZFNY?=
 =?utf-8?B?emVZa0k1bzhwcCt3OStuNVV1ZmlMR0x3aFFXbEYwR3dTWGc5TXpLNzJWOGVl?=
 =?utf-8?B?K3B6bFQvWWxpSHd1SHJIK3hUdmVUcmZ3VEFqdUczSFZCZlFjRTAxc3lnUFg2?=
 =?utf-8?B?RVQ5M2lNT0pKS3BVT1NwVUxSRUVlT1V2OWtLRG9GeHMrSnl0TVdZV21mMXdm?=
 =?utf-8?B?WVdzcjlUTFAzRmljN0JWOFBxajk1QWhWV2VyUzBieFVTUkIrbnAyV0h1Wk9u?=
 =?utf-8?B?dEFidVV1b2UvZzIzUWdvWm9HMytsbU9CcGNYbGNsOTBqaHRvUXZkZW1TSDJl?=
 =?utf-8?B?bzJuU1BPWUFSOExtZktWc3gyS2ptNXhmSy9IOUlBdGZqcVZlRzlaeEFDR3BY?=
 =?utf-8?B?Z2VtUjVCSFprbE1xRUtDZHVBVUNiME8xWk45MnpaMW5kOEh0azcrZmtVaEIr?=
 =?utf-8?B?eEthU242U21JQ2hzWmNnNm5tMktJY1hDSUlkQ3daTThvbEFaSHEzZlV3NEpB?=
 =?utf-8?B?N1d4d1ZVZHRpeExwL3I1dFR1djJ1WTVDMzMxeWFHcGhkRjdaMWl0endNemdT?=
 =?utf-8?B?RUxKZGdDZCthZXgvdG45cmxUazVBNWI3cnZqakZGOWx3dEszM0Mza0lqZFlq?=
 =?utf-8?B?ekFJa0pzak5jV1F0aGQ0aXRrWGNRRFFuQUlxNDVpRjN2cDI1S2hZeVFtc3gx?=
 =?utf-8?B?cklJc2l2Q0IwcXorcWllWGhoSFpPelJNZlA1Z0pueGVRTkIzcDdIV0JlSlFU?=
 =?utf-8?B?MXh3eS9Pc0ZHalNPM1M3bkw5Wmh6MHJHZXl6U2ZVWERiTUdLeFhSc2x0dXZv?=
 =?utf-8?B?ellheldNdUJJNmJEL3B0NC90U3c2OHA1ZzYxT2RLaHJJWVovNlAyUGtJL3ZN?=
 =?utf-8?B?Uk4yMEVzdWVNNmd4bXExY25KdmVwdDlrNmFmek05Y2VEY0RqN1krSWUwTHhR?=
 =?utf-8?B?WCtuQXloN0pGa0trY3JFM2lpeERBRm1iRlo1NzVMdTRoeWNYRjF5MmJleXJw?=
 =?utf-8?B?TVNEZmtUb25RVWF0aU5rSWl5d0FDZjJJVVE3V0wvL1hCUUdUZEsvdTRHeUhE?=
 =?utf-8?B?RVJoMTFUU1h6c2VlVjJPSTNSNWsxODFjbk5YWjVJTTFBd0c3dWRkMlQ0U1pw?=
 =?utf-8?B?MEQyOVV1NEk2cjNvSVVHZEh1VVBadVZjeVgwOXJyS0lXWlRQbENGV1VVanVF?=
 =?utf-8?B?UncwYlo4MHVCWGpzbitkNWk2RG5Ga0ZUcmdDK2czR05ydEZ1SzZiSTdlYjdV?=
 =?utf-8?B?V2NCaXFMVlJ0RGNpMHZjcEE4UmZnUlJDZStDVE1Yb2tJU3lubmtabm1ueEN4?=
 =?utf-8?B?NGl4ZUJWZVRyQVE3bmFaUWdvMUFoOTYvVFo2a2ZaZWFNbkthZW5VZ3N6cHZj?=
 =?utf-8?B?TjJhMU8yS1B5SjNISDFlUm5WNFBhY2xDQ0dCVWR6Si91SE5Fa0NFRGNnY3V1?=
 =?utf-8?B?RmtVaWgrRFdyWXVFd2NMYWtOSjFTUVBvanR4UysrSWF4RmFGdnF6azFqVEJz?=
 =?utf-8?B?UGFoUitDTGN3U1FGN0duOWkxRnVLVlRRQWZoeTFaSUhDd2pnTDdHdTc4Ym5p?=
 =?utf-8?B?WktMZEwxcFUrNmEvRE52Z3BTbXdGVkNhMUxpUnR3N1U4MWc3RlV3MWd4dGVz?=
 =?utf-8?B?OENka0JxdlZCTktZcUVCbk42c2QrdHBJL1ZYdld5Q0ZSeWJjcjhHUHZVczFY?=
 =?utf-8?B?cVZHRjFzenpYeEcwaGRua1dpVlhackxWUXJZbGIvSXV0d0VLcUx6Z3gwVzVr?=
 =?utf-8?B?Q2EyV0VwbmVsVmUyL01wM3h1UThXc3poR1ZPbzVEbFE3MlBnOTdUOEtNdW1n?=
 =?utf-8?Q?Q68vgiivqHco1aG6m2yupEkM46mVmE8S7H8oo=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR06MB4949.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014)(38070700018)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MVVHV25FV0tlNmdyMFhCZmVCbDJWTXZUd1ZrdCtjelFwZmR0bjc2Ym9hSmx6?=
 =?utf-8?B?WTdzV0lOcWdIckdwWndXMVZQay8vV2c2bnRMZS9XUGZXaVdpdHlkNWVSdHBk?=
 =?utf-8?B?RExoQ0llM04wQlpIbFhLankxSEF2WVc4ekhHbFBKK3NDRVk0Z25iZWdDRTJy?=
 =?utf-8?B?TlhjWnFnZkZuWHNaNU9EVHVHR0Y4R1dzbTlqc05rTndjOHM3Qk9hWkkzZElk?=
 =?utf-8?B?U2MvdGRHa042Z1o1VGNiT0M5cDBGTk8zaTBLTXdJU0MrVmdJSWdZRVJkZjdF?=
 =?utf-8?B?NERCN2hTbEMrMWhMek5FcDB4bXl3b1Vqek14STJIUktnU21TcEk4VW42NzRG?=
 =?utf-8?B?bHBMSU5GUTU1UXZMS1NyalJ2bUg2d0JSdDJLYkNyejBjOUVjNHdMU25yL2xO?=
 =?utf-8?B?OVJVT2kvRmNZQkhUREs2Y2F2VmcxYlk5TjVyZlhUM3lTdUFzVUpVTVNYSnNN?=
 =?utf-8?B?SmtWYWtlV2V4djhsdzkvajRWRGhmdnduTUZ0VE1zR1hXWXJ0WkJwTmZSTHpo?=
 =?utf-8?B?K2d5b0Ivb05UdXh5YXF3OFV4a0xxYXNkQjUzOURtZ051c1NVTTdNd011TWhh?=
 =?utf-8?B?NjdhaEJ3Z2ZybnBsMURtemltTGNVR1hKbnpJNmxpMWsrM3p5Rk10WmljY1N5?=
 =?utf-8?B?aFg2QmNkcHl3TTVzczJBaHJKYnJmSnNJWm92UXJiS2ZSNFRGQ3M4MUh5TXQr?=
 =?utf-8?B?dm95NVBpclVkVWVWVmFvemEvVkxEU0VoSUF0WkVIQkFtMDd1RnNNeGV6V3E5?=
 =?utf-8?B?alFFbFB5UGtvVmkrV2cwSVhTREJTZXdvZWNKYzBYdlpZbGlzYnhNODRNM1RU?=
 =?utf-8?B?M0RXM0kwWTRna1dzZkJxbThxSjFOQ3J6QTV1N1F5OVJUeXVUM1ZZZDhRQzB0?=
 =?utf-8?B?S29HYWdqTWxidVd4UURMQTJKbXZqVmVXNGRUemY3bnhKWnJGcVRMQ245VTlp?=
 =?utf-8?B?TUpvWWpMKzVJYTRZdmxKSll3NTJPMVZPMTh6M3hwUmVla2xJSGxQNHViNnMw?=
 =?utf-8?B?Y3A5NFlia2NINzMxTjRsdGNnY09XSitZS0lwYkJYQThsc1hLUnFiQ0ZsMUJU?=
 =?utf-8?B?dkZFVVp6ZEVjRUxWTUxrL25wRVVzQ1V5d1oyTHJUdktLWnZVTFV2dHUrMHQx?=
 =?utf-8?B?WXNrT09TZDJ5WDBjSmY3WUNtWFhOMEgxMFlpbGhxNUNCbTFQZGpVN1ZzcVk3?=
 =?utf-8?B?YVUrWWNOcUljYWxGUklZeks4Q1BQV1dXKzV1eXB4TUNPbWQzKysxd0E3OEpZ?=
 =?utf-8?B?OXkyU2xUMUJyend5aVhmSGNKQ0cvL1ZZc2ZHb1JaVnJpOEpudEdaR24zNXJH?=
 =?utf-8?B?OTFXUmg5NWVoOXNmTEhZTFRRaXN2K1VBNUNaMC8ycjBlQlYxdjBMQ3psNFpk?=
 =?utf-8?B?Wm1lN05hZGpOaS9QcGNPUVc4MnJRV2lvblpZcm10aXcvRjRiV3RuYlhjdHVB?=
 =?utf-8?B?Nlc1QTZuY2lnaGNhamtZMVZKZW1LWFJzem1LR2xmeGhGWlA2RWFHa2ZhQTNS?=
 =?utf-8?B?aG95Rjl2aG04VVJPOTJPa0wreGZmcGtqNWJIZDBQYTlkS2JveEpkeHJ3OENM?=
 =?utf-8?B?YlRHT1pXT01vaXQ4Y2ZXVlBEdDZKbXpMUE5iQU4zeFRwWEdONTJQRkNodzVX?=
 =?utf-8?B?RGhVNUlpN0krM1RIcG9rTnlhWjV3Vms5MDU4M003QTVUcGo4MTA1NmlqOTFn?=
 =?utf-8?B?UHJYS3JEdllWZWl4ZEpuVDBucFN6VWEyckljUUZTdXpRNVBQWVIwZXVrUkZy?=
 =?utf-8?B?VkVqRytnY0tJcE95cTUwaiswVnRGd3orek1MYnFvVHE0Z1dJVFVia1VtN3p1?=
 =?utf-8?B?aFFycnEzMXI5Y3Mxb3JuWTNuSGVZbGtyTWpTSEw4Sm1GMjlYWEZ0ZzE0eENj?=
 =?utf-8?B?bk1PdVZ0bzRVdGhxVmc1MjlLM3JMWWxvdVhacG54OFFoMCs1VjREUlRGdmts?=
 =?utf-8?B?d1lZQVVmR2NnTTNTZHB4dG9raGRwTjQ0b2dXbXVuSjFTV0EwdU9qdVk1R0Vw?=
 =?utf-8?B?RnhYN1BxV3NNTWlnZXM1cUw0cm9HbHI5cGtnWHE5Zm9hRkZCWTdydERIalVV?=
 =?utf-8?B?a3pLOEc5NTJSNUY5dDg5Wkc0LzRYZENuQzdDTGFwelZsZXVBSTMyU0Vkc0FG?=
 =?utf-8?Q?bKKVt0S4TgEokmxlE/PjaJL9I?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 57b77939-a45c-4d70-6516-08dce6b21673
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2024 09:26:13.4863
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0BQb0Tn7IMVYX0PtAJyrLlzO+AK4W1HEhXsWE/VhtMW3V1vTMst1IhUxLiCJ3gWvguCj5Zgud7nQ8U8GpBfhv37GayHRVLIiothRU4Wt2d4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6984

PiA+IEhpIEtyemssDQo+ID4NCj4gPj4+IC0tLQ0KPiA+Pj4gIERvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9hcm0vYXNwZWVkL2FzcGVlZC55YW1sIHwgNSArKysrKw0KPiA+Pj4gIDEg
ZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKykNCj4gPj4+DQo+ID4+PiBkaWZmIC0tZ2l0DQo+
ID4+PiBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vYXNwZWVkL2FzcGVl
ZC55YW1sDQo+ID4+PiBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vYXNw
ZWVkL2FzcGVlZC55YW1sDQo+ID4+PiBpbmRleCA3MWMzMWMwOGE4YWQuLmIyMTU1MTgxN2Y0NCAx
MDA2NDQNCj4gPj4+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0v
YXNwZWVkL2FzcGVlZC55YW1sDQo+ID4+PiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
YmluZGluZ3MvYXJtL2FzcGVlZC9hc3BlZWQueWFtbA0KPiA+Pj4gQEAgLTk5LDQgKzk5LDkgQEAg
cHJvcGVydGllczoNCj4gPj4+ICAgICAgICAgICAgICAgIC0gdWZpc3BhY2UsbmNwbGl0ZS1ibWMN
Cj4gPj4+ICAgICAgICAgICAgLSBjb25zdDogYXNwZWVkLGFzdDI2MDANCj4gPj4+DQo+ID4+PiAr
ICAgICAgLSBkZXNjcmlwdGlvbjogQVNUMjcwMCBiYXNlZCBib2FyZHMNCj4gPj4+ICsgICAgICAg
IGl0ZW1zOg0KPiA+Pj4gKyAgICAgICAgICAtIGVudW06DQo+ID4+PiArICAgICAgICAgICAgICAt
IGFzcGVlZCxhc3QyNzAwLWV2Yg0KPiA+Pg0KPiA+PiBOQUssIHRoaXMgY2Fubm90IGJlIGFsb25l
LiBMb29rIGF0IGFsbCBvdGhlciBleGFtcGxlcy4gV2h5IGFyZSB5b3UNCj4gPj4gZG9pbmcgdGhp
bmdzIGRpZmZlcmVudGx5Pw0KPiA+IERpc2FncmVlLCBhc3QyNzAwLWV2YiBpcyA3dGggZ2VuZXJh
dGlvbiBJQyBpbiBBU1BFRUQuDQo+IA0KPiBJIGdhdmUgeW91IGFyZ3VtZW50IGFuZCB5b3UganVz
dCByZXNwb25kICJkaXNhZ3JlZSIgd2l0aCB1bnJlbGF0ZWQNCj4gc3RhdGVtZW50Pw0KPiA+IEl0
IG5vdCBpbiB0aGUgc3ViLXNldCBvZiBBU1QyNDAwL0FTVDI1MDAvQVNUMjYwMCBiYXNlZCBib2Fy
ZHMuDQo+IA0KPiANCj4gPyBUaGF0IGRvZXMgbm90IGFuc3dlciBhdCBhbGwgbXkgY29uY2VybnMu
IEJyaW5nIG1lIGFueSBleGFtcGxlIGRvaW5nIHRoaXMNCj4gdGhhdCB3YXk6IHNpbmdsZSBib2Fy
ZCBjb21wYXRpYmxlLg0KSW4gY3VycmVudCBzdGFnZSwgd2Ugb25seSBoYXZlIG9uZSBraW5kIG9m
IEFTUEVFRCBBU1QyNzAwIGV2YWx1YXRpb24gYm9hcmQuDQpTaG91bGQgSSBhZGQgY29uc3QgZm9y
IGFzcGVlZCxhc3QyNzAwIGFzIHRoZSBmb2xsb3dpbmcuDQogICAgICAtIGRlc2NyaXB0aW9uOiBB
U1QyNzAwIGJhc2VkIGJvYXJkcyANCiAgICAgICAgaXRlbXM6IA0KICAgICAgICAgIC0gZW51bTog
DQogICAgICAgICAgICAgIC0gYXNwZWVkLGFzdDI3MDAtZXZiIA0KICAgICAgICAgIC0gY29uc3Q6
IGFzcGVlZCxhc3QyNzAwDQoNCj4gDQo+IEFuc3dlciB0byB0aGUgYXJndW1lbnQsIGluc3RlYWQg
b2YgYnJpbmdpbmcgdXNlbGVzcyB0ZXh0ICJhc3QgaXMgYSBib2FyZCIuIFllYWgsDQo+IG9mIGNv
dXJzZSBpdCBpcy4gV2hhdCBlbHNlIGNvdWxkIGl0IGJlPyBBIHNoaXA/IEEgY2FyPw0KDQo+IA0K
PiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0KDQo=


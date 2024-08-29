Return-Path: <linux-kernel+bounces-306340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A41C6963DB0
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 09:52:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B4FC286C88
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 07:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67916189F54;
	Thu, 29 Aug 2024 07:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="N/hdZ+M/"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011031.outbound.protection.outlook.com [52.101.70.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6E315821A;
	Thu, 29 Aug 2024 07:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724917931; cv=fail; b=RHw2fInUFOdXQ+uLcqzJRHRvt7gBuzU+9Fb09nRE1HxeoaURFoTQ9SWE2agzvI6CvNTe+6/zgwKdDYGm3rcTtJGMi57047YvtsPXjX1xuL0ISmiqwrGPJPapbe8mEdJEmH5y2WTrd7I0S3i6vlStl9oZO6jT9f+TFHC6j9Lo0m0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724917931; c=relaxed/simple;
	bh=r3dmJSfb6jebHq+Uc0ofMjLuzmmw+3US2ZZO3SstV0U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Iw6Dhkf5NG9VjMIeuzw0L8QcqzZyMqKj2ed1WNSSD5msiEKIIQGfkWQNVovotxucGi3mA5TMeONtwtPOswzwSPwK1s2rbhCG9rFvza9YC0yCWbsMwjyTaO15H9LyuzeRFqiR+FZsMqHQ2rilqQnGuTKzzRwKAlCqgGY3xPzZOZc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=N/hdZ+M/; arc=fail smtp.client-ip=52.101.70.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F0TEeUgg+aT/TEgg6TPwTmvt/WIeXq3/3xu3rC2ogrRzFRYA/fZ/+WB0gn+cUQ8TMOpgs3eB20rgPhEM7gMzZZSprUTfiHi92EAfPru85n4AKPQzaS4vDBJVFUc3MB/SuKnY9eBK0Ok0IIF2uAo2GrNXqGJHvECznA30UdE/fYveCGhykDrWPmk8z+4BphQXBesOF7hCDKTYi/Bn0iJeTHZcFKOdeBURm7GTOEAgaMd+DNyPvtJ4v4srf4IYIjffRuSI/9saIE3HjbNWXaijqFQHD3NqPstgD7KxPA9Fi5dGEnSDcZ6kwmIDRXM5ZEMloCa7J0zJgp1fhVWHCspALg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r3dmJSfb6jebHq+Uc0ofMjLuzmmw+3US2ZZO3SstV0U=;
 b=hkCnC9ljF82XYX0+jwikpv2dD/w6NT+j1ht2Zc24ySDB1AbztfjEtcgnWlcfjhAnuZnpd+QmC1h5xUo/V91w5TWDYNcTqhFTXpxM34ny0YwWRm4quIZP9wCYpns/VYDYvUxLLW1NjAYzXH3rWilkR2czd9E8BKCB8NftW/jMVwC5tgNm/drRiB9E32W5EbUr9teVKvyO5PXCdnjqdCQhh+OPTTU9znK0YZIIgBqh6X00+e2FOzgloHU73LAACfKq6tLvJxAur1XtbKoFbCP5yOderTOdUxF8Ld8ing4p3worwmtiR9/6Q/ZR9phWQIUQaF6dHTJhVkAEpSURiwhRlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r3dmJSfb6jebHq+Uc0ofMjLuzmmw+3US2ZZO3SstV0U=;
 b=N/hdZ+M/iiJtRS08Hc8SG/tARNLCmv07XQUFx5IIwVa5ICblVmpkvYdRT6FZSp/odSJS58QqYo1fhCRzGpJvkNR/WZN2jXCOG0qe6KRGlbWASC0o329VgMTE+DL4NHV5qcTV/AIxz0oLOm4J3g/tg9JtjMtw7v8ivmeJNzvLQUCaRH8oGDo/N47uFS0pCtCkXoG/Yy6Uze4RqsWG45u/ovV8pkVbcD1tnJcUzh1+C0aAL592jacu1C+6cygibn5EOXB1LHRVxdNmtjSbWpDfOsfIjirFbngnCNlj+JqPOGzok/Po2qbcgFYGDeipungINSU8d1WPn0bX8MXJlsiw+Q==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS8PR04MB8370.eurprd04.prod.outlook.com (2603:10a6:20b:3b1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Thu, 29 Aug
 2024 07:52:05 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7897.027; Thu, 29 Aug 2024
 07:52:05 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Abel Vesa <abel.vesa@linaro.org>, "mturquette@baylibre.com"
	<mturquette@baylibre.com>, "sboyd@kernel.org" <sboyd@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "shawnguo@kernel.org" <shawnguo@kernel.org>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "festevam@gmail.com"
	<festevam@gmail.com>, "abelvesa@kernel.org" <abelvesa@kernel.org>, Wei Fang
	<wei.fang@nxp.com>
CC: "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [Patch v3 0/4] add NETCMIX block control support on i.MX95
Thread-Topic: [Patch v3 0/4] add NETCMIX block control support on i.MX95
Thread-Index: AQHa+bNxSEovYvmLMUKMf3wXSyujtrI93MUAgAAAQoA=
Date: Thu, 29 Aug 2024 07:52:05 +0000
Message-ID:
 <PAXPR04MB8459B39210600F6639453C8D88962@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20240829011849.364987-1-wei.fang@nxp.com>
 <172491778768.2521946.17064463983702008243.b4-ty@linaro.org>
In-Reply-To: <172491778768.2521946.17064463983702008243.b4-ty@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|AS8PR04MB8370:EE_
x-ms-office365-filtering-correlation-id: 5bc67580-c69f-4fa1-fd3c-08dcc7ff79bb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bmk3czNGZTBaTmZNQzN2ME5JT3pna2JBUElwckI5V0FaS3daL1JNVnRac1Bz?=
 =?utf-8?B?S0R1WXU5a09qV01nUVZGTC9EMitRbHdLeVRXR0lsV0dxOUlOK0ZOWUtkTGV3?=
 =?utf-8?B?K3lBSkZLMmRuUUJsdU5JL2VNc2dxQkR5UU52L0NBMWtBVmtQanUydVh4Wm1M?=
 =?utf-8?B?RTJaUmZZdFNhbFVyTWpZVHYyWWRsQzMyekUwaFd5WTREbllEcENPSzZ6QlFU?=
 =?utf-8?B?STRCaHJXbDR4SkVaUTErcFMvOGh5ZDV3R01UTjRsOERUVTJUQ2VIMysraWdN?=
 =?utf-8?B?WmJVOW1mS2hzeUJPR3VlZlo2M0l1bGR4OFJCcWc2YnRnM1NVdFVnUjNuUUtl?=
 =?utf-8?B?SnJXaXRjRXNlaUVWWVBvb3EwVElscGRya3Fyd2lXWkZWQmJWMXNRcm1CWVNu?=
 =?utf-8?B?akxqM0E2ZG9SajFRMnRFR08xQTNVclR2d3ZYR0NvR2t5NlhkWVN4Mi93ZFlk?=
 =?utf-8?B?eFI2TEpoV2JoQnpBVVpyQkhITm5kM0pyK3V4OUhPV05VM09lNStjc1MzYis2?=
 =?utf-8?B?VjNkYWE2eVlZUXFhMUJjWkF0VG5OUFp5czJWVUdLNHNhSVYwSlJLQ1IwVTJ0?=
 =?utf-8?B?NElQSW5aWFptdysxU0tkcHpYeG0wdGQyNVpEcUZwdmxqcWprMTF4eGZrWndR?=
 =?utf-8?B?cWlDNmFRS3Zmcnl3MXJSVEFKbmNKRUhGS2Rwb2hjSHFYcWZqZEJLUzlDZENp?=
 =?utf-8?B?RUVIeEpWd0U3dXNNSDliNm1FVUxldnNYS2xDbzR1bDIxN1gwbmFXRGY0STJa?=
 =?utf-8?B?WFBFQmIybndBZjVTYndXYzBhckJlSlpzVmpoc1FCMk5nbWdBeWRzREt3cWRD?=
 =?utf-8?B?cEJ3emRZaGxxbHlhWEN0QlE3VmkreE5HNmJsV1hMaHRYb3hUTmd6MVlPZDBW?=
 =?utf-8?B?UHpwL1liUkxUNEZVb0xSMVQ0U2UvZklEZHhVcEwramdXRmJKS3dyMFB4MzFD?=
 =?utf-8?B?RXJxZUluWUtoanduMkVQSm9sdlVqWHovaFphQ05WUVUwT0ZRaTkxcG12T1FR?=
 =?utf-8?B?WlhSSS9UVUl3dEFaY2NqbmtCbVBBb2xrUFJJUmNReGJlQ3lmZHFuZjBzc2pK?=
 =?utf-8?B?UFZHb2trNjNCTzNEaXVHM01mNDcyTk5HSThvaU1IUW5qcmRrVFpIRmNKc2ZH?=
 =?utf-8?B?QUtsNEFqUUVpVmR1WXBIK3Vpem1zcml0OXZFaDNkblp2eWdQRVhxVDVGQWhS?=
 =?utf-8?B?ajI5NGJxWVkxa2RMYnkrdHdlZDREbVpVV1lKTkdDY2NjVmo4N1M3dFBTZW5P?=
 =?utf-8?B?d01nRTZyc3ZCSFduckxGZ1RIR2VRMTh2V05IdjdPN0pLNE1qbUdxckh3ZnhT?=
 =?utf-8?B?cStKeVRUYU9ubXFLVm42TnJqSGI3UFdBQmxoMlRvc3dxcHdCTHhjOVczUjlK?=
 =?utf-8?B?YmdmMXRLbEJ3M25JblZoeFJTUlRsL3pKSFh0RUcwTE9PTS9EYm00amZKSm9p?=
 =?utf-8?B?WURMbUF6cmNwaGhjZEZEKytyUmJxaGs1Tm9PdjdZSXJzZXFnZHRFejlrRWdt?=
 =?utf-8?B?ZUNqdlU0YnBRT1hqWHZ0RmY1QXIzMVc4cjAycDFoVjdFa0JUelpHck1MdkRH?=
 =?utf-8?B?cnprMUZmaFEvSFdjSEZ2SDlkNE5tSjhQUWUybG1KTXp5M2twdm5KeDNmMDFq?=
 =?utf-8?B?SmJzSEJ3SkFHSDJVbGNwMWpPN210N25NZ0tQaUdEYndTdnprNDVuckZqMWdI?=
 =?utf-8?B?NG4reEhsdzIxZ1pEbGZ4OFF2VjRmVkora0gwWXhXSVZnblBEakRoQk8xN1Bi?=
 =?utf-8?B?SkZEYWtoMGpCL2pMSUFldHV2WTdsdm9icThUempxeGQ3TGpWR0U4enVQM21U?=
 =?utf-8?B?eXMyVUpsQmYzRjF6ZW9sTmRpMURTaUJaQVpERkc5YnNDT0N6eXVKdTEvK1cz?=
 =?utf-8?B?R251UTZ6T01KdER6cVBLbWVDUjNXbjFFQXpScUNicFlSWk9UZmlDWkZaUHhK?=
 =?utf-8?Q?a6CGngVI/dM=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VmdoMVhDTjIrNDBDSVcvVmZxUGF1RldlNWh5cGdUQjNpdUhRMTJKRnJQTG9m?=
 =?utf-8?B?ZlQrU2FpZTVIaGtqMi85WE5JOGZHUnFMdFFrSzhGV25pYStVSEtmZnFxbHdk?=
 =?utf-8?B?Vmc4ejI4T1pOUENuNFpMclNLMlVjcUUwUnpicnhZeWxmR2JnSndDMnBGS2Rm?=
 =?utf-8?B?L3MxTjQ1ZDJPOFdTRW1lNGhMem0vd2FPM3lja0drVG9wRWU3U0NjNk5rbWRQ?=
 =?utf-8?B?NUdmZkRyZnpaNTZxbWhyZERXYVBqbVVhelBpM1dpeXdTa05zNi9taHZPV2Nn?=
 =?utf-8?B?R0h4TVNWSVpOYmtZeGRkQmJZNGNaV21qaFVXQXFsa290bDlveTVlOXBUZVBD?=
 =?utf-8?B?REcrV3Q1QnRSZHZiZ2dOUFoyU1l4dC9ja3kyUVBHcnVlQ1dhT3ZUK3Exd0Jl?=
 =?utf-8?B?cTcwK3FmRVpjd0x5ZFNhOExMVzlHVlA5R0VPZG1WTFBScGZYK3E1Tmxva0d4?=
 =?utf-8?B?UndwN3FLNkx0WWlRa29KVlFWOFNlcmhkbFlSUU91amIrc2FEL0FweFV2blNn?=
 =?utf-8?B?SURzUmRybVdLb1UrNDRPcDJrNFM2cVNNdkdaTTVUUUdxZ0xmV0NTUFZ3eVEr?=
 =?utf-8?B?M0xrbFhNZlZnanpkQmwyTUJIL2U5a09GOUVFSnpEVG5lak5kNjFMY09aRWNC?=
 =?utf-8?B?WCs1aTgvMkY5czZ1VXZOZEYzamtNVEJDSDM4dnpnSkhyRzNha3ZZNTlFeEVy?=
 =?utf-8?B?SXd3SGNZOFcvT3VuaCt5dThsMnJPb2RWdjE4Y0h6RGk0Z0VPMnhEencxcWUz?=
 =?utf-8?B?MFNLVnpJak84eFM2SXdlZmFlUElaS3IvUXJveG4xdUpIREE0RklMOEt0dHFS?=
 =?utf-8?B?aWpNbFRtTG5NNUF2S3ZUM0Z4QlAvWWx1YVorS2pLNnMyNDFDRkJXdWNlRXF4?=
 =?utf-8?B?UCtCaUxjamV5NXNoNHFJYlVENHIwaG16VUR4Z2d0M3VEdzdnNjNjWnIrWExJ?=
 =?utf-8?B?d3cxcHg3SUx2MnE1Zys4U1Nlb3FxSS9taXFaUVVxRjByZ3Z1WlAvOG1ibTgr?=
 =?utf-8?B?TXMrWUF6RVd0cEx1UzUzVFZ0ZHhZVVlzUEhxbXAyUmRrTzFOQWxEZ1hqalRl?=
 =?utf-8?B?T3UyNXkyYzlpRit0Sk9oZTh0Y2E5enN3RncrR3NMNUpQU3Y3amUzcW1iWjJz?=
 =?utf-8?B?QUNDMWNiOXhrN3VMMHFzOWJmN0JNMWtXRjEvZWJLck5aNndLTVhKRnFwNm9K?=
 =?utf-8?B?Y3FJdTlSY1A2Ymt0Q0VrNkpVSXlvaGovL0pxOVhYQmRHbDFHb3ZlMGQyYlJi?=
 =?utf-8?B?S0k4RFdUL1puWSs3ZXpEbitMWWE0WVFRcVhqcWxIYUxjMTJ3VWE5b3JUaDhX?=
 =?utf-8?B?UkFmYzlxVS9SVTJGbWxFM3p5U0R4cEUrZ2FoaHVJRHdEeTNtYXdnb1lQa3dG?=
 =?utf-8?B?KzQySDJVUVNXUHFOZUF6YVYxdWZ5Q0RGUzFMMkdaMXlvR0o2bE9kckNETWd0?=
 =?utf-8?B?V3lQNE9ZRUIrYTJLWHJQeTNGT0dQOTZGbVpJOVVVUWhiS1hVek5vSGhuOTlr?=
 =?utf-8?B?em43ZXJLNGR3U0hNRjNQc2h2TStuWWdNcjNXWU13ZzB0ZisyT0VlZURMdDJQ?=
 =?utf-8?B?cmIzWjhvaFVPSzE0WmRPMXRTRjQ4Ri9IQmxBNTNSd1Z2dWdxdUNVNVJCNlpQ?=
 =?utf-8?B?VDd4b25Ienh3S3Z5cXlIdncrZ1dCRm5oZEloOFpQdjBta3AzQXlRWmwvbTlo?=
 =?utf-8?B?STNCOG9aZmcxTHAxRjJrMTVuZndNWSt0SytrQ2VUWHh0eEdvQUczS1ZJck1E?=
 =?utf-8?B?VzVtSCs5c0pPSW5USTBHN1ZNcGhEWGkyL1BRTVhXVjhsT04wcGJWNXo1aFd0?=
 =?utf-8?B?bkZHZHBFVEt6ei9sbUpGL1hKWVNhbFBHWGFobGRSR21QRGwzeVlhWTNWamVC?=
 =?utf-8?B?Y1dnclYwVG0vcVZHNVZOVGExcVpSU0JMcERTbUFBUThVaFErVC8xa25VcWl0?=
 =?utf-8?B?YnQya1g5TFJNeXlJTVRUMTlnZGgxTHBNbkowRDYxZ1RZQzFCYlJsaThlYTBa?=
 =?utf-8?B?c2VBMGw2OHpoYTEzMlVPTld0eG8yT0ZiYjFYUlV1MzV4cWxubzJPck0yVnpI?=
 =?utf-8?B?QVE1Y2hxcDZOS3BlQml5eDN4cThBZVJTeTNpQ2VXdVJtWXQ4ckk4cCtDL29B?=
 =?utf-8?Q?1jM4=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bc67580-c69f-4fa1-fd3c-08dcc7ff79bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2024 07:52:05.2403
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p0689bNxoScJdi0gj9e4BbSBayjZjK29p85sKa8TUg99kLV49ZZKZSjVTPSjWkkwxihu+qeswGOT2fEbG55wAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8370

SGkgQWJlbCwNCg0KPiBTdWJqZWN0OiBSZTogW1BhdGNoIHYzIDAvNF0gYWRkIE5FVENNSVggYmxv
Y2sgY29udHJvbCBzdXBwb3J0IG9uDQo+IGkuTVg5NQ0KPiANCj4gDQo+IE9uIFRodSwgMjkgQXVn
IDIwMjQgMDk6MTg6NDUgKzA4MDAsIFdlaSBGYW5nIHdyb3RlOg0KPiA+IFRoZSBORVRDTUlYIGJs
b2NrIGNvbnRyb2wgY29uc2lzdHMgb2YgcmVnaXN0ZXJzIGZvciBjb25maWd1cmF0aW9uIG9mDQo+
ID4gcGVyaXBoZXJhbHMgaW4gdGhlIE5FVEMgZG9tYWluLCBzdWNoIGFzIE1RUywgU0FJIGFuZCBO
RVRDLiBTbyBhZGQNCj4gdGhlDQo+ID4gTkVUQ01JWCBibG9jayBjb250cm9sIHN1cHBvcnQgb24g
aS5NWDk1IHBsYXRmb3JtLg0KPiA+DQo+IA0KPiBBcHBsaWVkLCB0aGFua3MhDQo+IA0KPiBbMS80
XSBkdC1iaW5kaW5nczogY2xvY2s6IGFkZCBpLk1YOTUgTkVUQ01JWCBibG9jayBjb250cm9sDQo+
ICAgICAgIGNvbW1pdDogNGI3OGI1NDc2MmRiZmMyZjIyZjI4NjU1ZmEzY2Y2ZjVkNTBkZTE5Nw0K
PiBbMi80XSBkdC1iaW5kaW5nczogY2xvY2s6IGFkZCBSTUlJIGNsb2NrIHNlbGVjdGlvbg0KPiAg
ICAgICBjb21taXQ6IGI0ZjYyMDAxY2NkM2ZhOTUzNzY5Y2NiZDMxM2M5YTdhNGY1ZjhmM2QNCj4g
WzMvNF0gY2xrOiBpbXg5NTogZW5hYmxlIHRoZSBjbG9jayBvZiBORVRDTUlYIGJsb2NrIGNvbnRy
b2wNCj4gICAgICAgY29tbWl0OiA0MmRjNDI1ZmE4YjViZTk4MmJjYzIwMjVkNWJmMzBiZThiMjZk
YTg2DQo+IFs0LzRdIGFybTY0OiBkdHM6IGlteDk1OiBBZGQgTkVUQ01JWCBibG9jayBjb250cm9s
IHN1cHBvcnQNCj4gICAgICAgKG5vIGNvbW1pdCBpbmZvKQ0KDQpQYXRjaCA0IG5lZWRzIHRvIGdv
IHRocm91Z2ggc2hhd24ncyB0cmVlIHRvIGF2b2lkIG1lcmdlDQpjb25mbGljdA0KDQpSZWdhcmRz
DQpQZW5nLg0KDQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IC0tDQo+IEFiZWwgVmVzYSA8YWJlbC52
ZXNhQGxpbmFyby5vcmc+DQo=


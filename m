Return-Path: <linux-kernel+bounces-278816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E8D594B544
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 04:59:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A30C21C20E3E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 02:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 806822A1DF;
	Thu,  8 Aug 2024 02:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="fOsqXc9z"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011045.outbound.protection.outlook.com [52.101.70.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586B56EB5B;
	Thu,  8 Aug 2024 02:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723085963; cv=fail; b=iU4ltHDs+oXiYR7/oFwWlHnTEnrJ9ThzVeoqv2ZrzUMyqFyQ77Bkw8ZRCKOIRdwc1EyLEpjLn4nIJjR9GB9Vv7zcoDIV3g4RYAdTNQcYntokG9kwOo3AOzHcjQX9I67xtpRUWjCOdLHKA/IqdoVXE1wN+oBsasf7NcT0KvVW8RY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723085963; c=relaxed/simple;
	bh=ykIG0W+ThrQYAOUFNtKADlZnsPzGVcXoa/sTnW6Kvlw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=A/uHpKTFOuHaxTKGKaO+dLsnCSP5SBL/o/nlUs0WmvSgH+aomzsrvT1jZnabn45k6Jd6SmLQPM8Mp76TPCgq+om4ERcIXoa4eeSNvWKZ3H38E0c1Jcio0Yp2sPj/Um13E6pxgnOqf7Y2yCuiMeFiG1hemnd0vjJXzeRuUrN5WgU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=fOsqXc9z; arc=fail smtp.client-ip=52.101.70.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vJfYP01o3n0nUlLXF4I1P3b2iRxzPBwbSls/5uhHWhPre5VWjE2XIkjleHxWemrFS6rVqNMGoEb1lvbyKao/DogRGNYtbFEsoRE2x0A4kmaP3ClzT26vrplkATBwCPneUfRVQ7NangjA/GBaOriRiARPXP9zJTGtO+12QilgR5dyU7vx9IYNZrSMqipCA39Npqzi1uzKIZL8OX7Kppivb04O+DmgtwA3pEf2R3DLRLO1+PisKOCDSDmbodtogx1XRd+dcTa7yQA8+9edDmGKyJMh1xyMZtzMk8DZKisg91cPUXxK0OHTaorLJK9XmYwnGpgdrMllGfB8cKmp1RF93w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ykIG0W+ThrQYAOUFNtKADlZnsPzGVcXoa/sTnW6Kvlw=;
 b=ocvAWltqwsiKAzSFkni7XypSeR9c9hQeXYtunNzaOkfFk/krfCGDjooEQUVDp8odflzndBM/T39DFCuXzoUEGuGGExYTtRjMjpJlcoGfS4n2T+HO6QZNz++Uk/BZ8BU0ot35XeONlDmdZik4BHCrMVVUSlK7RVZkH1jk4KMMqC7SXEOMk/PuOl3VKCv2j5lzHNmA8WpeuwgwZsHX+h2NQRpxQ4OjQvwQbkjws6U/grESzLZ+p7ov0tk3Jm9giGUC49tIiK45WVkbUqK6v5jo4yydMa2AVxbXJdZo6ZWu3+51u6Cfx4RQx9EGX4CyNIll0V/ZWQa/5xAi4iswoXtKwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ykIG0W+ThrQYAOUFNtKADlZnsPzGVcXoa/sTnW6Kvlw=;
 b=fOsqXc9zEsiJMMS/ZmOZQLCi7bLgIYoDU1iox/ZaU17F3SaKjjqOX+Be2w/ckEyElzg0Sz8qmu1Jf9IR/ojm2HV3JyPUZXrU15MWL3Z7QnCPIswLJeeWTDDB4IgZU3MQBAmkNV66R5Eo5UgpmrgEkjIKc88zF/vIiyK7ZE12F01kIzcGwKAfEwWzHITyyfPoqHJ9HhXcI+FRsXa27EpMSAWvxq+tEZ8qHPzMSlWIbdzB1XUCZ4fC5eH+vHlQJ6z4be976Y/aZVohK5KkjiFX/Gp9QLRoZ9vGuoZxHVeMbRgfwfv6SxPw8AnCA+Wm2VKgAAbucgV5hloYAYLCtHgajg==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI1PR04MB6958.eurprd04.prod.outlook.com (2603:10a6:803:137::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Thu, 8 Aug
 2024 02:59:18 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.7784.020; Thu, 8 Aug 2024
 02:59:18 +0000
From: Peng Fan <peng.fan@nxp.com>
To: =?utf-8?B?Sm/Do28gUGF1bG8gR29uw6dhbHZlcw==?=
	<jpaulo.silvagoncalves@gmail.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Shawn Guo
	<shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>
CC: Marcel Ziswiler <marcel.ziswiler@toradex.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, =?utf-8?B?Sm/Do28gUGF1bG8gR29uw6dhbHZlcw==?=
	<joao.goncalves@toradex.com>
Subject: RE: [PATCH] arm64: dts: imx8mp-verdin: drop limit to sdio wi-fi
 frequency to 100 mhz
Thread-Topic: [PATCH] arm64: dts: imx8mp-verdin: drop limit to sdio wi-fi
 frequency to 100 mhz
Thread-Index: AQHa51/KkuZZ1qyyHEeVIendWI8wCbIcrulA
Date: Thu, 8 Aug 2024 02:59:18 +0000
Message-ID:
 <PAXPR04MB84599440EA42D060FBBAD1BC88B92@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20240805174814.1944742-1-jpaulo.silvagoncalves@gmail.com>
In-Reply-To: <20240805174814.1944742-1-jpaulo.silvagoncalves@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|VI1PR04MB6958:EE_
x-ms-office365-filtering-correlation-id: 59a597f3-5cea-4dbb-c414-08dcb756183f
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?eXJ3VG11ait3M1Q4Z2JQV2tVYVl1Z3dJdmVtNTFYS0JoTllEcktMQ3BrWlhV?=
 =?utf-8?B?UW1pRFlPVmRJQ3p3bHlPMTdOYTVYSGNNK1BsRmtWMnQ2WitKU2JkcUtpK2dH?=
 =?utf-8?B?a09rSFRuSlEyS1Z4d2t3SkdjWWZPMmdsZVNqVXNaQ1o3WFJud0R2VGtKYzBE?=
 =?utf-8?B?V2liNzlKR291VTRLYVRXK0hWZDhIMmtBeElSYVQ4b3VrbWMwOHphVlBQZ095?=
 =?utf-8?B?QlJJMmJaQnc5dERhVWJReEtWckJMVUNsT1JNT2RMdFZQMU9URlIrWjdSUnA0?=
 =?utf-8?B?MnAxRElEM1FuQ1BxRHhVR2drYmh4emhVaUdwS0JoT2h1SjFpbHI5Q0lGNC9J?=
 =?utf-8?B?YmtCYmZvTTVyaW1yYktmR0lia1E1czd4RkhMN2JQM3VmS3BYdDBPcXpwUGxk?=
 =?utf-8?B?ZWphTkxRMGtvWTlmWmRhKzFSbklKb0hkSnpVc3hhT3NuUFNYd2JnSTVXSkZV?=
 =?utf-8?B?VTlCZzhEa1lybWFMQTZydEVmSDVldnpzcnZzVTV5cTN6cWw5cUNGdmdVdUFh?=
 =?utf-8?B?VytLNFJwOS9DeEo3M0hMRVBHYUZEWUxqRVF1VDlWdVc0akM2U2V0eG5tWjNr?=
 =?utf-8?B?NjFMbGVTMEJ0bldMWUZRQ0RUMFdSb1BEZnFrL3IvQW1ITjc4dEcyS1VuNlZy?=
 =?utf-8?B?YVJOZHdoWTZoZWt2QzVLenl1V2lrUlU4dWdncTZDbGt1cGFVRElua2dlaDJI?=
 =?utf-8?B?QlFMLzNaWTRGUzFWKytJMi9oN1RMM091QnFEU0tBOTU4bGtVVzBsV2pmeWwy?=
 =?utf-8?B?M0NtR3oyb1R5YlpWOFp1YTJ2WkdkbDRydUpEb280bjJybkxrN04xd1RqZUc0?=
 =?utf-8?B?SkN3V2R2dTgzTTlCanJDOWcvVFJkYmd0NWZNbmRYczJIK3JRZ1J6Tml5NFVH?=
 =?utf-8?B?TzRQa1FVbjYxdURUQjU3YzZhTU9pTERNZFgxWFdHdzRFRHc2Mml1ZytUN2RU?=
 =?utf-8?B?UnlNajU1cVhqOGFod09lVDZqNkhYZkZ6dzJVYWt0QnJrdWFOaUdTWk43NEdy?=
 =?utf-8?B?eVI5QWZVODMxbS9qdTZNZEVqSWdvbE55ZXBVakVUSWg1Y1phOTJRQmlXZ0RF?=
 =?utf-8?B?NkhtbzlxbnVnMWppUHRBVVhpZy9PeXc3WVh1VzFoSzlJR1psYW5xTzdMaHJF?=
 =?utf-8?B?MlhvQ3Y3YW8rcDlyZHFrcTNqOHVJVi9xSTQzYkRXQmdKMDVHYWpXcS9mZ2tH?=
 =?utf-8?B?SzZPa0JHVUF2WWNaMWVPRkJLWmRrVzhaemlBZ1JYakNLZE5vVno2L21laHJB?=
 =?utf-8?B?YUlNaE5RNzFhSndkZ0pTN0JVNi9XWGZ5M0JnMnVla25uMitMLzVxaU1ablRI?=
 =?utf-8?B?eGxVbkVPN2N6bmtEbnI4L3VzNkNzM21mRUJLemR3SlQyckFQWnFpS2tpdEl6?=
 =?utf-8?B?QU9NV3pxajZoZGM0MkEyVnNmSFpxK3hxaEs1YUVBZCtrRW9LRk90K1pFT3ha?=
 =?utf-8?B?cVlTMzhSTVRqOElWOXEvaHpLU0Vxd0k0cEg2cG0xLytNVkVRelVBRW53RTNC?=
 =?utf-8?B?d1NGSGZTQ09XUzJ5cmZ0T2k0bk9qQ3ZBTFlrVnVOVjNmNm9aS01CNkJnQWhz?=
 =?utf-8?B?TDJ5NDFId2c0TUxnNFJGY0xxMld3WFJOTVp5dDVLSUwrU0NjblpEZmpYU3BJ?=
 =?utf-8?B?bVJFVXV1elhZMzFIcDJIdHR2ekEwdTVhS3Z2clhGUldSZ3IybWhOOHZSU01K?=
 =?utf-8?B?T2Q0TUNtR2hZa0JPQUt5QUdFSmVlY2VHQ1hVNlNHSUwram9pQzdJQ3FxbFJH?=
 =?utf-8?B?c2hRYnRDb2hUaUZ5ZjEraWxkYUg2YXA4R1IyNDc3R3RUbEh5V3BIRW12dzc5?=
 =?utf-8?B?Mm9FcWFHaHcycFNhOHhaemhxN3hEQXdYQ214UXEwdDNrNGw2aWp3N3lTdlN1?=
 =?utf-8?B?dXV1SEhMaGdEWW1yVi81MEFxUHUwZSs3V1JRK1NVK1hVZ3c9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dXlQTlcraVBZbUVBbElHOU1hYldkTDhqd1ZidjkvUW5uS1ZCVzkreGxBUW43?=
 =?utf-8?B?ZmwzM0Z2ZGVmb1lKS0FKand6WUNaVjM5cFp1bzNubEZHQ1RVZVhPL2RuYzJ5?=
 =?utf-8?B?cm1kdzZJckU0L0pjSEZtRHNISnVnUGZTM0dWNHdRVDM0Zit6Ui9qb3hDTDg4?=
 =?utf-8?B?bldtVWZGOU0ySThJSFdSb042ck42dEltZ05yMzZhOXFHMmdpeUlmTkRZUUdR?=
 =?utf-8?B?NzZrWU04aDhxK2FHMzcwYVVTNHNlKzJIWWZuL1dxYzB2THM2amg2aHo2T3lp?=
 =?utf-8?B?VHNVSWs4amFqdU5WYzFUbUdUMW9pZ3ozTXpmZFdaS21WKy9SR3pydU1ObUZY?=
 =?utf-8?B?ajlWRUYyeElldHJMeUZjUWVRV3pNRkh3SCtta3h0L3lyOG9HamZVTEl6WHE2?=
 =?utf-8?B?Mkxhck9jMG9rUzRFczVUS21VTGhSR2pGWmtYcitFQm00VWtQeEFzRVdVYVlR?=
 =?utf-8?B?aVhnbXd5SVpXdkYxNXRzV21nbk9NQkFBQXhUNmFXVkVmWktqVW5WRXNHTnRJ?=
 =?utf-8?B?VUk1QW5wRnQrR3dzSmlVZzN2bkN4Nm4xblluckV5a3M5NjNGMVEvVVBaajhU?=
 =?utf-8?B?MUthMlIvSDNETldEbW5lRE9yODhWWldoVnF6ejRzT3J6MWE1NkFwMWtaZXh2?=
 =?utf-8?B?TG9lMXNlU1Y3RXRzSk8vZnhIOVQvWTBjVWU2WEd1VVpQRmhLTmt2djlLdTNv?=
 =?utf-8?B?MlBEV0c4bGVWODFYQmdjUGN3TW1neVdjM1M5b01GUXROWTlMOUNDYVBFN0dS?=
 =?utf-8?B?SXdmMU9pdW16RXd3V1hBc3NrTnVXejduMlF3bk1xOG9YWWlEc1ltWjRaQTV5?=
 =?utf-8?B?dUU3Q2RRdTdSclFlNGlLV2ZxcmRGVDU4ejVUVlhHMzZkMm53VStNSDhDL1Vh?=
 =?utf-8?B?ZHZMTW1Ld1ErNWF6bkF1S0ROVVdkZDBTM0FISzV1dVRBZlJXY0pnNnoxV0NP?=
 =?utf-8?B?aGEvMytrSmZrTHAvR1d4Q3N1a0Vjdy9PZmQ2ZktMV1h0OXdNNThjVW14eVl4?=
 =?utf-8?B?U2xvbnNlZndoOGFrZllKYVUwRVZaQmgyeEFhckpNZmVLMHY5bm5UOG1ubDNq?=
 =?utf-8?B?anE3SmRGNy9GZmxrQ0xMRWpJSkF5NzB4ZEQvMktJV1M0V2ViY2ZFakpHTGp5?=
 =?utf-8?B?cEJvYTRkQVRjNUVOYVBjM2ZsZ3NrN3BYNEUrcGN2Sk1UWFptTWNEdkcxdWE1?=
 =?utf-8?B?bEp3RTJaKzRkMER2eWllTjllQlpUV2hFb0hIOXNrdGlPQ0VCZnltWStCYnZ1?=
 =?utf-8?B?aVRzVGxtQ3lZSlI1WlIvN1RzaXdnOVI5Y0NhVEdGcEdLc0RkaExmUWNtdnUz?=
 =?utf-8?B?blVEMzcrRTVld1BVUFlwSnorWEMxSWUzN0M3Ty9GbFFQcm5JY0JJMFI2VHJO?=
 =?utf-8?B?UzJkNWhSSFdyZzdPSk5SNU1TcUR5QkI5b3hPajMyZ0pjNFU4Z0E4eVBiVlBD?=
 =?utf-8?B?MStHa1ZUaUlXL2l4V2RiS2Z3N0dJNGprdjN2YzNLVnA4dmpoTWcvS0NBQkt3?=
 =?utf-8?B?c2hGRDlmSS9udkUrZlowellGTjZCd1psVjUyVjhtZ3dXRjQwclhUZEZNMml1?=
 =?utf-8?B?YkhWQ2JsMFk1ajBPMklBUEkvQmFIYVpaL3phZEIwaTRrMmhDa2p0QmNPSjZK?=
 =?utf-8?B?cGx5V0dQQ3NTcjYzRHRDbUtvM1JRWU4zR3k5bStUdGd3dkV0QTRhMEs0UEhK?=
 =?utf-8?B?Q0ZCcHgxakNiUGlQMGplWGxkZDd1aE5nakdJbC9GbFNZN2pSdHBIbGM1UjZn?=
 =?utf-8?B?ZGRHVzhJeHdiSHM3alFwQ1crL2FWNEpuK1VvVWdLTHJ4N3IyYnFBbFBHVzMv?=
 =?utf-8?B?RUhGTDNEblJMejJDNU5QbUUvN1U5cHJzSnNnM056aTFrZHVYR29CS0c4Z2N6?=
 =?utf-8?B?SUYyK2xmc0FXM0VPRFoya1dndFcrRUNjSGJ0dHkyYWduN0VCdW4zRnpYbDF3?=
 =?utf-8?B?SmdaMVpCTit4NlhlMytYKy9RTXFlenVHa1pSbkx0dGVVU2pSM3JFMFlFcEF0?=
 =?utf-8?B?SlcwMWtWRERacUtSaTgvL1dHZXVpYTBKM1ZQNHRXTzdJSGNHcitRb25YdFdx?=
 =?utf-8?B?NzVzU1FrbW9UYTQ3ZUlEQVM5OXAvSlZmdTVzZ2RTanBFMTJOS1RMZkJwOEht?=
 =?utf-8?Q?iFZk=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 59a597f3-5cea-4dbb-c414-08dcb756183f
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2024 02:59:18.1646
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rxuSjYzEPtozUyPmo3e92ZyUolsI0o7e7aHISLo0vEbOlAo9GmqikL3XkSvdJpGekBif1BikQkrswvQfBeeGmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6958

PiBTdWJqZWN0OiBbUEFUQ0hdIGFybTY0OiBkdHM6IGlteDhtcC12ZXJkaW46IGRyb3AgbGltaXQg
dG8gc2RpbyB3aS1maQ0KPiBmcmVxdWVuY3kgdG8gMTAwIG1oeg0KPiANCj4gRnJvbTogTWFyY2Vs
IFppc3dpbGVyIDxtYXJjZWwuemlzd2lsZXJAdG9yYWRleC5jb20+DQo+IA0KPiBTRElPIGZyZXF1
ZW5jeSB3YXMgbGltaXRlZCB0byB3b3JrYXJvdW5kIHNvbWUgaW5zdGFiaWxpdGllcywgaG93ZXZl
cg0KPiBpdCB0dXJuZWQgb3V0IHRoYXQgdGhlIGluc3RhYmlsaXR5IGhhZCBub3RoaW5nIHRvIGRv
IHdpdGggdGhlIHNwZWVkIGJ1dA0KPiB3YXMgYmVjYXVzZSBvZiBhbiBpc3N1ZSB3aXRoIHRoZSBV
U0RIQyBJUCB0aGF0IHdhcyBmaXhlZCBpbiBjb21taXQNCj4gNTJlNGMzMmJhZWQyICgibW1jOiBz
ZGhjaS1lc2RoYy1pbXg6IG9ubHkgZW5hYmxlIERBVFswXSBhbmQgQ01EDQo+IGxpbmUgYXV0byB0
dW5pbmcgZm9yIFNESU8gZGV2aWNlIikuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBNYXJjZWwgWmlz
d2lsZXIgPG1hcmNlbC56aXN3aWxlckB0b3JhZGV4LmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogSm/D
o28gUGF1bG8gR29uw6dhbHZlcyA8am9hby5nb25jYWx2ZXNAdG9yYWRleC5jb20+DQo+IC0tLQ0K
PiAgYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1wLXZlcmRpbi13aWZpLmR0c2kg
fCAxIC0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0
IGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1wLXZlcmRpbi13aWZpLmR0c2kN
Cj4gYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bXAtdmVyZGluLXdpZmkuZHRz
aQ0KPiBpbmRleCBlZmNhYjAwYzAxNDIuLmNhZTA2Y2I2N2NkMyAxMDA2NDQNCj4gLS0tIGEvYXJj
aC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1wLXZlcmRpbi13aWZpLmR0c2kNCj4gKysr
IGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1wLXZlcmRpbi13aWZpLmR0c2kN
Cj4gQEAgLTc1LDcgKzc1LDYgQEAgYmx1ZXRvb3RoIHsNCj4gICZ1c2RoYzEgew0KPiAgCWJ1cy13
aWR0aCA9IDw0PjsNCj4gIAlrZWVwLXBvd2VyLWluLXN1c3BlbmQ7DQo+IC0JbWF4LWZyZXF1ZW5j
eSA9IDwxMDAwMDAwMDA+Ow0KPiAgCW5vbi1yZW1vdmFibGU7DQo+ICAJcGluY3RybC1uYW1lcyA9
ICJkZWZhdWx0IiwgInN0YXRlXzEwMG1oeiIsICJzdGF0ZV8yMDBtaHoiOw0KPiAgCXBpbmN0cmwt
MCA9IDwmcGluY3RybF91c2RoYzE+LCA8JnBpbmN0cmxfd2lmaV9jdHJsPjsNCj4gLS0NCj4gMi4z
NC4xDQo+IA0KUmV2aWV3ZWQtYnk6IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPg0KDQo=


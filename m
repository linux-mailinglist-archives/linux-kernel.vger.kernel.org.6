Return-Path: <linux-kernel+bounces-174669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 729B88C1293
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 18:15:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28830281B0E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 16:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAA0016F85D;
	Thu,  9 May 2024 16:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="KNXSTwoX"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2117.outbound.protection.outlook.com [40.107.20.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98FFC14B097;
	Thu,  9 May 2024 16:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715271325; cv=fail; b=ETl818QOsLfG4rbSmoJ1M+dSnYyxN1a4SfuKHtrTnhQ1FEaSX8wuHqsQEKZh4zwdVnonsJw51GNirVNqdcR8PPQaWQgOye3N5DX8x2r2oji0fSVI7WOeCDBVXdSEYjcFeyuBEuKFUz9oRdDjUbkN19b3qhha8mJAb2p8jMSyhvk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715271325; c=relaxed/simple;
	bh=kHawvgQ0XBrAMisqnqW0HlaI8j0y0ACPDkbiOhVX2rA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dlxBkCDtFl+Er+Su+UFXuJordz6iOhUYO1MkYRG9YAbeOi/8uVMqfBTRcGcsMmEzg2pSRaDMTuThrJ4ZoPDn6D6sd9mL3r4Vkw7vrz5DmnnOAyt8hzYZks7llHiUVYC8XPD33bI9Q6QC7OKIIYPwRPQaKj4+gIcyqEbzwbzhfZA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=KNXSTwoX; arc=fail smtp.client-ip=40.107.20.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XLz1C53fQdqE2ni64AiiPK+d+as8PKkA13HuspepYOsZgaN8HfKkynV7taeSSem69f9kdkIy5v9toYYXYPoaE3B8Qi91ejWTgLSRnR0ikkp4xE9dtR5elV+bT5OsSTGY9c6sSGzlh9iwW/cX78l1+tAe+z/abGqSVK2o6J96gc2TwVgCeJ4rSQWHbAqiSTrsqEWT104kICQgK2fNDOjy7E6VBO9kwYyHf6UjtvHh435DQQxCFp6PPRcMXjR6+2TYB2WfI3fY+odAwnNkMDH1qcokPXN0jjsFXvfbDXS83vzGQRmOoxfbEDRReBFtduKBLKgE71Pu33MRHhvrSz5p1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kHawvgQ0XBrAMisqnqW0HlaI8j0y0ACPDkbiOhVX2rA=;
 b=SCK0aF7IxjjUqTY4K/Mwkwn8M1Ya4uC+UcnHdVE08ChsHwKc0GYFdGhZOBWaILiEwdgWJ52ZnIkHiDqfBgRRHS9KSk6YBv8DyzPbaIZDDhbh0CrYGbzyqJ2pKFZlPkebV9GYjOvoLmFA0MGKWHUwmjT3/2x2JC8QKlv4xMEdZbsWKJeWXo/tVjLIQryHys5NKF7cYhlAAWuUPR1+BjqdwhwsNYtb53RPmZ5go90nBF1aGax1QBi/9KRdzP6+sZ6PE+udNeO+90Mhqn9xOFdjqvNaP77zgbfy7m0Wcl+l7fX2lqgYkTwBVL/+MJ+gi/4rVhsnC9pH2pD/ZKt6vny2Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kHawvgQ0XBrAMisqnqW0HlaI8j0y0ACPDkbiOhVX2rA=;
 b=KNXSTwoXVb7CZtZFedkLaoTBEwwryzRpe0rkLeD7/TGsJSAKWiR2oBUgjM2j1xoM5088i0NdtSa/0nTkY/cTs9VqfAVa85mnSPZNeCPthuBh8wPdQG112qP/pP95bVAuGEBERRZNtjAmYakeUKbzOhlagchsAX3X1Cjcuc8oh8k=
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by DB8PR04MB7164.eurprd04.prod.outlook.com (2603:10a6:10:129::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.47; Thu, 9 May
 2024 16:15:20 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529%7]) with mapi id 15.20.7544.045; Thu, 9 May 2024
 16:15:20 +0000
From: Josua Mayer <josua@solid-run.com>
To: Conor Dooley <conor@kernel.org>
CC: Andrew Lunn <andrew@lunn.ch>, Gregory Clement
	<gregory.clement@bootlin.com>, Sebastian Hesselbarth
	<sebastian.hesselbarth@gmail.com>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
	<conor+dt@kernel.org>, Rob Herring <robh@kernel.org>, Yazan Shhady
	<yazan.shhady@solid-run.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v5 2/4] dt-bindings: arm64: marvell: add solidrun cn9132
 CEX-7 evaluation board
Thread-Topic: [PATCH v5 2/4] dt-bindings: arm64: marvell: add solidrun cn9132
 CEX-7 evaluation board
Thread-Index: AQHaof4bfE9Ueli+tk+h7rTggD3oW7GOuREAgABW2ICAAARGgA==
Date: Thu, 9 May 2024 16:15:20 +0000
Message-ID: <4ba3114b-14d5-491f-b697-0e4406a1e622@solid-run.com>
References: <20240509-cn9130-som-v5-0-95493eb5c79d@solid-run.com>
 <20240509-cn9130-som-v5-2-95493eb5c79d@solid-run.com>
 <5da207e2-1579-4056-9e3f-c25f5b14e225@solid-run.com>
 <20240509-recycler-flask-0b3b7e2802f9@spud>
In-Reply-To: <20240509-recycler-flask-0b3b7e2802f9@spud>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB7586:EE_|DB8PR04MB7164:EE_
x-ms-office365-filtering-correlation-id: 50a95419-9822-4907-cf90-08dc704338fd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|376005|7416005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?NWhYeW5aT3h4RGpJUjh3am94L3FaMWNKYU9NRjRNNytPOFNBMGZ6RlhDWk5G?=
 =?utf-8?B?dEtYQ0NNMFdjS0RVdGFxcmtnSXF2U2RUZTM0TWRwam1LMElPZmFDbDhtTFpE?=
 =?utf-8?B?RThhY2hDU0x4dS9rNFNKdXlFYTYyUS85OG04TjdmeXZSNlBzeVUxdjl3clkv?=
 =?utf-8?B?elBoNUJGSCtKUzYwZ2NzYm9uZ21BSkpNZ082NWNkOGwxRGhIM2Rvc2VtTGFO?=
 =?utf-8?B?c1V4dWtDUEpPdFFMQlpMb3Z6YXFvK2o5VXAwT04zYlNCN1pEWFpmczA4K0k3?=
 =?utf-8?B?dkdsaVAvNzRDeDdCZ1J2TVRQbm8wam9JK1ZPd1FDYWhidjB5RzdJUytZYjdy?=
 =?utf-8?B?MEkrenVPMXFtWCtlaHZ5UHFqcWluTUM3U0xHdHRZa09WZEVnV2tTQmxwMFE3?=
 =?utf-8?B?cEp4WnJxZ1dnS0RRR25yekdBbHptSDhGTzJPcnRid0dqM25XL0hSQVRVazRs?=
 =?utf-8?B?UU1teU9mVVk0RVBUL2dQalZ2VVJGSFRpZklCWVhYS1lEb1lUdG9TTnFsbVRx?=
 =?utf-8?B?VmFHcnZJcHV6STJLdTE5QXNLVUdkRjhlWWxmSEFmclEyZFAwYVB6WURScjdT?=
 =?utf-8?B?ZW5DdjM0WGVSMTRpYXlRNHZqSmUwS2pSbDFsS2Z4a250elR4dFJmSE92SlJ6?=
 =?utf-8?B?MU9WazdQYVlUQ09zOExtSHhqZ1NUdkRYUUR5OS9BRGpqa0xLd3g5Y1IwNnVp?=
 =?utf-8?B?cmxFR2xndXByY1g1U3VFeG9kaXJmREYzTmtRV1dXTEpRU2lxOUJ3ZmVVUCtB?=
 =?utf-8?B?dmFpZHFpLzV5ei9XSXhIT1FjL1NEMS9DUDBFSStjcFdocFo5UVh2djNrbUxG?=
 =?utf-8?B?c0U2L3RDcXdxVm5pYXhPVDVkZFNtekNOSEQrY3Ftd1BqUjZjc0x5dkZ1Z25U?=
 =?utf-8?B?T3pndnR1cmZQd20yWlNwVnlYZU5iUW5TM0kxcUpIN3VReldCNjAyMWIveitx?=
 =?utf-8?B?aWVRTXVtWEVoaUppS3d5cDdwaVV5UVQrZ2ZCR3ZYa0M1ZVZsZkxMem5HdFAz?=
 =?utf-8?B?eTBDK3lEUVF1SVlqa3RrdThNajNLeVROcU9YTzdnTU9EY3dJUE1Ba2JQeEdU?=
 =?utf-8?B?Y3hwcGhiTjBOUlRDRjBlMyt1ZkVDUHU4VUZMWFJoNyt4NkFwbEF3OEhiajdD?=
 =?utf-8?B?V3dBSk1jN3pQcy9RZGI1K0t0UElYZjJaT2piZG5ISHNScDZvcGE1dXB6Qll1?=
 =?utf-8?B?VjRmRUp6eWdCYTMzS0doZHZZRW9mV2doKzB2Ukt0U21EYWM3c2ZXZnZJOGQ0?=
 =?utf-8?B?TDRhZDBQNUFoSFB6akpjTGRWcHFTZEM4MGdqeUJtQno3V0FDSmZuQWFLcXJI?=
 =?utf-8?B?ZjZhYkdkZVBhR1hjcVI2elVOMGMvRk5UR2hBM1VKam05SkN4OFdIeS8rK3lL?=
 =?utf-8?B?czVBMDBKYkJDenN6b1hncWkxbWlRbWlxOGJXamV1eVJZQzFMSFNwRkM4aFFT?=
 =?utf-8?B?NDRiWkdPaDJ3V21uWGs1YjNiZlhEUm9vM3NDK1JSdmpQYk1WaDZIeFJUNHUv?=
 =?utf-8?B?eTNwZ0VKK2VkdWt4cDF0YVFmTnUrRjFPWHBzY0F0ZkV0MHc0dUsvamNPclBE?=
 =?utf-8?B?WlVnUDAvbXBIWGlPSEZCK0VMbTVvNGpnR2FkM0FBVi9rb0hEVFJoVzgxeEJK?=
 =?utf-8?B?djV5QVd3d3dEZnY4MndlTndIaTg5c2llUDF5ZCtoNWZnNk9hdEtRVy9QSzFx?=
 =?utf-8?B?YjBBdjZaSjZrS0JGdUY3aUhoMXRpcGhBSlFTUzhLaUpUZW82SGxlMFlBYVVP?=
 =?utf-8?B?VXFjZ1lCUXB2R0dpTmlCMVFBRE1velhWSlpzSXMybFVUWlZIdE0ybEVtQnpY?=
 =?utf-8?B?UVhWU2JnMXhadEQ5QXA5Zz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dVBsU1R5MC9VQ0JhYk9qdFkrQUx6cWlYVjJ0Z0JobzNtVjN6T2wzTFdtaEZr?=
 =?utf-8?B?WGVoUXRiaTMxd0F3aFJ3ejNDSitjQlJ5b0trWFdwVjFmYXluYVA3eDVMWDhS?=
 =?utf-8?B?WE1NSE90dDlyM1ZBUERFMDB6T2VjRkxiS0NDYzJiM1R0ZFFDRDNxMk9qOVFi?=
 =?utf-8?B?c3dTVDFlSDJmM2Z2azJXMzE1TTFkVlp4dGoyV0JPbzNZbHFIUkNjU0VONVNO?=
 =?utf-8?B?czlDQlFNaUJzMGFuT1UyTVkrOThtTllIcEltZVVQcUlxN1dTdHFHN1pNRTFw?=
 =?utf-8?B?QTRrK3hrSXhFWFNQcXFEeG1DdEU2Q1ordTRYWHpWZ21qZ3M3STA2VVpId3pQ?=
 =?utf-8?B?SmVUekY4NENOMXk2SUVsN0huY2JpYjd3bVVickNiQUhNK0tVQkJxS3lSdjZN?=
 =?utf-8?B?RlArV0hyM1lrT1VPMGZBSENqMkFLQlNNZ2RyUWFJblB1bFphY3lRYUJVOXBF?=
 =?utf-8?B?U01NUEhuRVFFbGxqdzlsVzBtaG05RVEreHpvSHREbW1sYVdONHBERU5aa3Ft?=
 =?utf-8?B?RzFwYyt0R09OaDlLeVEwZ2hST1k3MW5IaHY3Wk1rU0FiUnN1c3Y4RVlHUERp?=
 =?utf-8?B?N0ZYZi9vNm9EcExHL0RHM0F0TWFXemFnSHlXNTM3VnltYmpHaXhnWW45NTF2?=
 =?utf-8?B?TUh0VkRiT1c4ekRmNHlnQ0k3Q0J5Q0s5VE1XakNxNTJwR094WnQyUzRWL29F?=
 =?utf-8?B?bjl6Skg3aERZYlE5MnE5YXhRTFRBN28vdXloQmlOYUl5Z25uVTVSTWRKd0lt?=
 =?utf-8?B?MlVXTzZTUDQzWmVxWTFPRlZxaHdWc045WGYxNlcwc1hqajRFM2J0bmZDNlRz?=
 =?utf-8?B?bkkzbktiVldFa3ZzTXYrZVVTanpEbzNodUJVZytwU2xIaGQyTWlwM1g5WjE0?=
 =?utf-8?B?RXpTcFVPOU5NM1hpUVlEZzBNM2M5WlVqdXZTYmtWSUg1akNmMkdLTDk4eFRK?=
 =?utf-8?B?UXhiRlV2M0FTSmoxQUw3UDZzV0FFN1VBV2tGYjdlOW9HODhCOFB4NFdNQjFn?=
 =?utf-8?B?bVpJcUYvTGhmMVg2WkoxNnc0OHo3ek4xZHVGT0g3b09YcWw4UjhSV2NPSjJo?=
 =?utf-8?B?OE5Ua01lMzlvbG5KaHRGdUxlSWEwNWpZb050Z2tTTDdYNFVoenUvVVRyOHF1?=
 =?utf-8?B?TWlwVEVmUnh5RUloSUU0Y0VCRm50M0JTbHpFU0x0WVVUbXppM1lvdEMzNEY0?=
 =?utf-8?B?ZTZvNlc5L2N5bklDZ2tQdjRQVDlRcmhkU3BkMHAyd0ZyZjNOeUNMdnkvZjFL?=
 =?utf-8?B?TTZ2OXhxUDR4eEZsMnFNTisvSW5XY0x3TkRkSnZsMm9PcmJYRi90RVBleG81?=
 =?utf-8?B?UCtqMDFVTG5jZVBQVjg4UGs3UVQ2ZDdBREZJYUUra3A5Tzd4RGxITExKeUY4?=
 =?utf-8?B?NUlhVVZMVDhTa0VZRXVaYTU3ekNydVVpWTdmMEpweWdzSHZRUDhOQkVTWGpl?=
 =?utf-8?B?U21pVDdYR0duYTJ2ZFFxaE01UFBrUmJ4bnE4dGJxeW8yZlVTbVdxays1ZnhX?=
 =?utf-8?B?aHk0M3BFUUxNU3pHMVJhd3pwODdmY3hVbldRVGRvOGIvcHIwUnZXSmZyTVcx?=
 =?utf-8?B?TWRWTDFkVEFPdm5XbHByZUV0SzBqbzlJTjVNOS9CbTZJM0N1TGpYbzY4NmZD?=
 =?utf-8?B?SEw0Z0NmRG9Lc1NLZ21rQSs2eUo5YnJzTzBnRDNUeUJBV1VpOUhucjladGtm?=
 =?utf-8?B?SVN5MmROcGFMQjdQc1p1RDI3dTh0WDNpcWZxbG9BVUR1dVBKb3ExaEFmN0w4?=
 =?utf-8?B?cDlHcHFUTHcrM0w1UXlMcGoxZ0tQV3MyeEREWGNsekN5bXNQRzFMM3Vwamto?=
 =?utf-8?B?bHRTT2o1MnY1a2FhblhEeGlGUnhPc3dmZExiOUpvM0FZeGVkZFVZdEY4OW85?=
 =?utf-8?B?MDlHTW1qUWZXMEZYL21rMFprZnVaSUZpRWRkRy9LLzV5TWFRSlF1VjJ1Nk9L?=
 =?utf-8?B?YzVPR3IycU5xVWFiUTdnbUpGcy9HZTlQcVdxQkczNHc3aWxzakxTMVFhQjZC?=
 =?utf-8?B?UEZlSmxlV0tKK0JCTmhkZXkyUGpWUjBYNk42dFAzeVhWUGxmTzRCVUdZTFNp?=
 =?utf-8?B?YkxUclJhY0Mrb21Cb3daT2M5SFJKNWhZcFBXd0sxcW96WnRZcm1FamNTTEVq?=
 =?utf-8?Q?x+ITRa1xdzs/AQ4yn/JnuNQBz?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1E429E452917944290BD61461D5CA5CF@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50a95419-9822-4907-cf90-08dc704338fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2024 16:15:20.0584
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5BMDe2CJs2PjrDstQA4IT5ZrtknP6+ejBAinbYqWAjicFjH2OZ/yHWSKhgrcKpVB66deJHspgxNracQbgm6KmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7164

QW0gMDkuMDUuMjQgdW0gMTg6MDAgc2NocmllYiBDb25vciBEb29sZXk6DQo+IE9uIFRodSwgTWF5
IDA5LCAyMDI0IGF0IDEwOjQ5OjEzQU0gKzAwMDAsIEpvc3VhIE1heWVyIHdyb3RlOg0KPj4gQW0g
MDkuMDUuMjQgdW0gMTI6NDYgc2NocmllYiBKb3N1YSBNYXllcjoNCj4+PiBBZGQgYmluZGluZ3Mg
Zm9yIHRoZSBTb2xpZFJ1biBDTjkxMzIgQ09NLUV4cHJlc3MgVHlwZSA3IGV2YWx1YXRpb24gYm9h
cmQuDQo+Pj4gVGhlIENFWCBpcyBiYXNlZCBvbiBDTjkxMzAgU29DIGFuZCBpbmNsdWRlcyB0d28g
c291dGhicmlkZ2VzLg0KPj4+DQo+Pj4gQmVjYXVzZSBDTjkxMzIgYW5kIDkxMzEgYXJlIGp1c3Qg
bmFtZXMgZm9yIGRpZmZlcmVudCBkZXNpZ25zIGFyb3VuZCB0aGUNCj4+PiBzYW1lIFNvQywgbm8g
c29jIGNvbXBhdGlibGVzIGJlc2lkZSBtYXJ2ZWxsLGNuOTEzMCBhcmUgbmVlZGVkLg0KPj4+DQo+
Pj4gU2lnbmVkLW9mZi1ieTogSm9zdWEgTWF5ZXIgPGpvc3VhQHNvbGlkLXJ1bi5jb20+DQo+Pj4g
QWNrZWQtYnk6IEtyenlzenRvZiBLb3psb3dza2kgPGtyenlzenRvZi5rb3psb3dza2lAbGluYXJv
Lm9yZz4NCj4+PiBSZXZpZXdlZC1ieTogQW5kcmV3IEx1bm4gPGFuZHJld0BsdW5uLmNoPg0KPj4+
IC0tLQ0KPj4+ICBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL21hcnZlbGwv
YXJtYWRhLTdrLThrLnlhbWwgfCA4ICsrKysrKysrDQo+Pj4gIDEgZmlsZSBjaGFuZ2VkLCA4IGlu
c2VydGlvbnMoKykNCj4+Pg0KPj4+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvYXJtL21hcnZlbGwvYXJtYWRhLTdrLThrLnlhbWwgYi9Eb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3MvYXJtL21hcnZlbGwvYXJtYWRhLTdrLThrLnlhbWwNCj4+PiBp
bmRleCA3NGQ5MzVlYTI3OWMuLjUzOGQ5MWJlODg1NyAxMDA2NDQNCj4+PiAtLS0gYS9Eb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL21hcnZlbGwvYXJtYWRhLTdrLThrLnlhbWwN
Cj4+PiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL21hcnZlbGwv
YXJtYWRhLTdrLThrLnlhbWwNCj4+PiBAQCAtOTIsNCArOTIsMTIgQEAgcHJvcGVydGllczoNCj4+
PiAgICAgICAgICAgIC0gY29uc3Q6IHNvbGlkcnVuLGNuOTEzMC1zci1zb20NCj4+PiAgICAgICAg
ICAgIC0gY29uc3Q6IG1hcnZlbGwsY245MTMwDQo+Pj4gIA0KPj4+ICsgICAgICAtIGRlc2NyaXB0
aW9uOg0KPj4+ICsgICAgICAgICAgU29saWRSdW4gQ045MTMyIENPTS1FeHByZXNzIFR5cGUgNyBi
YXNlZCBzaW5nbGUtYm9hcmQgY29tcHV0ZXJzDQo+Pj4gKyAgICAgICAgaXRlbXM6DQo+Pj4gKyAg
ICAgICAgICAtIGVudW06DQo+Pj4gKyAgICAgICAgICAgICAgLSBzb2xpZHJ1bixjbjkxMzItY2xl
YXJmb2cNCj4+PiArICAgICAgICAgIC0gY29uc3Q6IHNvbGlkcnVuLGNuOTEzMi1zci1jZXg3DQo+
Pj4gKyAgICAgICAgICAtIGNvbnN0OiBtYXJ2ZWxsLGNuOTEzMA0KPj4+ICsNCj4+PiAgYWRkaXRp
b25hbFByb3BlcnRpZXM6IHRydWUNCj4+Pg0KPj4gSXQgYXBwZWFycyBJIHdpbGwgbm90IGJlIGFi
bGUgdG8gc3VibWl0IGFjdHVhbCBkZXZpY2UtdHJlZSBmb3IgdGhpcw0KPj4gYm9hcmQuIFRoZXJl
Zm9yZSB3aGVuIGFwcGx5aW5nIHRoaXMgcGF0Y2gtc2V0LCBpdCBtYXkgYmUgc2tpcHBlZC4NCj4+
DQo+PiBJIGFtIG5vdCBzdXJlIGFib3V0IHRoZSBwb2xpY3kgaW4gdGhpcyBjYXNlLA0KPj4gaWYg
aXQgaXMgYmV0dGVyIHRvIHBpY2sgb3Igc2tpcC4NCj4gV2hhdCBkbyB5b3UgbWVhbiBteSAibm90
IGJlIGFibGUgdG8iPw0KSSBtYXkgbm90IGJlIGFibGUgdG8gZG8gaXQgaW4gdGltZSBmb3IgY2xv
c2luZyBvZiBtZXJnZSB3aW5kb3cuDQo+IERvZXMgdGhlIGRldmljZSBleGlzdD8NClllcywgaXQg
ZXhpc3RzLCBhbmQgd2UgaGF2ZSBhIChsb3cgcXVhbGl0eSkgZG93bnN0cmVhbSBkdHMuDQo+IElm
IGl0IGRvZXMNCj4gdGhlbiwgSSBhdCBsZWFzdCwgaGF2ZSBubyBvYmplY3Rpb24gdG8gZG9jdW1l
bnRpbmcgYSBjb21wYXRpYmxlIGZvciBpdC4NCkdyZWF0LCBpbiB0aGlzIGNhc2UgcGxlYXNlIGtl
ZXAgaXQsIHRoYW5rcyENCg==


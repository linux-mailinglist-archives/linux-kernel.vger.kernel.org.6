Return-Path: <linux-kernel+bounces-327542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5509D977755
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 05:27:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7AAD0B23E65
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 03:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5103B18BB87;
	Fri, 13 Sep 2024 03:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="gjSwDalS"
Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazon11011001.outbound.protection.outlook.com [52.101.129.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ECB554BD4;
	Fri, 13 Sep 2024 03:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.129.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726198015; cv=fail; b=TCjbXXhzYB1/y/jM0FgSc5SI6HH14tkMlJafQzocTXzASTO7V3FbGr/FrDl9BMhj43nmuw5rwBZwDJqlc9ALcHjNvtqLRL2L0KYxrEzs8pofQzCKVJOqzRuGIYDNnskdMrDw3kQEA5Aku7ZcAoVSuQ/RPz2EOy8R5TVTE/W7K6U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726198015; c=relaxed/simple;
	bh=iczMHLwAZqqPMjX6B0kvfAFEsaoHi4WBHxXqDk6VfYg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TIVzJcXs6Da1UubHYZqZkIfYee40ITVE8t/KNQ40vXndCGfBC7ALAgP9db7sEOSryt4JmzCYotEdzErRAJ2bg3KexWmugnbXpceMFkfnDnvtRxHZxpguYGhcH4FG9/PgjAccPhDH3bHjJ6jyex2HmxjiD4GdXA830W6f4Ay5hb4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=gjSwDalS; arc=fail smtp.client-ip=52.101.129.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K8GLkGGr4qWJEDYCT92yS+6iR7u1Oeo5AXSgMX5MFe4pZAiMHdb3UDk+i8JO0DTtkliHZPhSQ4P+0spKGbpj33lGkw4471zyMA37mp2lPHfd8FBrNLzB5oKjzxFpQ1yxkYb2yPDb9EUvixpn1fwOX4E+fo50UjuNddgFfWE5+z9mm98/pPlnh5Qw0o/G3VUNIGaFaa7ohHM9LJroix4fxVCB3T+e4N7ZLVxPbSOcH60eXdvlTiRvUmDfEdZxqz4cZT20PShAAv2RPimxE4qdVmaR0pZd0aY6Ox4W6IwdkCGvKvqH4I10hATQTOxbUUJI9MArHp2/7206YXWJdM0EFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iczMHLwAZqqPMjX6B0kvfAFEsaoHi4WBHxXqDk6VfYg=;
 b=qYvZFt5TYzeJ740Oqt7YjL71yBXIpGhMKl6v0iWrC5/SMBqDeOp7EcqYXMF/LhVUE10eJpng/vvbGt8ZSwiCTCzBs4PeDJs1up0xCDjif5upY4VGexLvGQvWosLRvLdZFcCI3+JDP8ihvHQp0UV7bEjRri5XA45jA9XfcmVgHMbSYgt2bT/osuTnUmvLlD4z0YenuIpkKc0XafU0PoI4ZVDxvfVoOakH0kTKbyTQpUpLnst14qAymiBV2OLHlu8UWKwQDXX+9tY0Wmb4DG3YA0B5ODbvD4Ys3ZP0e7bFgJZrWbRk80B9CU2H1xLSmwzgSHGUYGLSUXS552wUZwCpGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wiwynn.com; dmarc=pass action=none header.from=wiwynn.com;
 dkim=pass header.d=wiwynn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iczMHLwAZqqPMjX6B0kvfAFEsaoHi4WBHxXqDk6VfYg=;
 b=gjSwDalSlNi09c0dQ+58bhdYJhchzjC4OR4gVH8Gm7JNJHi4HUX1zAfUiZI+viS8WAJfOkvjZbZv9SFanwu2qtwImgKfT68ASqzHnXgJVtgn0vzzuwsEhHscTO48A48C7I8/XfEyEaCelsX3tdKftVWsJi3LOzzkPp5N+J5CNaEFfaJhkLRC+xcy6LM4NPv0kVw/4KoPgL20HceviT34q0oZHxTzjTe+MrvdcvGtNniQ2gNE6JeG7GY8DiicNAtH8noUCYOC71FoacNhAnbe75PLWtKZMsJIVxSsg+xK/q/4IcuzDcLrdugSO6o1P2KEHTWItAtmODBJ89rNq1du5A==
Received: from TYZPR04MB5853.apcprd04.prod.outlook.com (2603:1096:400:1f3::5)
 by SEZPR04MB8334.apcprd04.prod.outlook.com (2603:1096:101:23c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.19; Fri, 13 Sep
 2024 03:26:47 +0000
Received: from TYZPR04MB5853.apcprd04.prod.outlook.com
 ([fe80::ae7d:7486:9319:8d96]) by TYZPR04MB5853.apcprd04.prod.outlook.com
 ([fe80::ae7d:7486:9319:8d96%6]) with mapi id 15.20.7962.018; Fri, 13 Sep 2024
 03:26:47 +0000
From: Delphine_CC_Chiu/WYHQ/Wiwynn <Delphine_CC_Chiu@wiwynn.com>
To: Delphine_CC_Chiu/WYHQ/Wiwynn <Delphine_CC_Chiu@wiwynn.com>, Andrew Jeffery
	<andrew@codeconstruct.com.au>, "patrick@stwcx.xyz" <patrick@stwcx.xyz>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>
CC: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1 2/2] ARM: dts: aspeed: yosemite4: Add gpio pca9506 for
 CPLD IOE
Thread-Topic: [PATCH v1 2/2] ARM: dts: aspeed: yosemite4: Add gpio pca9506 for
 CPLD IOE
Thread-Index: AQHbA0UHYnKTipIy9EyxznCx6Ypb1bJTa20AgAGQKZCAABa04A==
Date: Fri, 13 Sep 2024 03:26:47 +0000
Message-ID:
 <TYZPR04MB5853062387962EB4CA08A366D6652@TYZPR04MB5853.apcprd04.prod.outlook.com>
References: <20240910054751.2943217-1-Delphine_CC_Chiu@wiwynn.com>
	 <20240910054751.2943217-3-Delphine_CC_Chiu@wiwynn.com>
 <ccef1d90b9a7eb343e99afa2c6cd6ea7407b0541.camel@codeconstruct.com.au>
 <TYZPR04MB5853B6611AF9AA5C3E5AE778D6652@TYZPR04MB5853.apcprd04.prod.outlook.com>
In-Reply-To:
 <TYZPR04MB5853B6611AF9AA5C3E5AE778D6652@TYZPR04MB5853.apcprd04.prod.outlook.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wiwynn.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR04MB5853:EE_|SEZPR04MB8334:EE_
x-ms-office365-filtering-correlation-id: 5a7bf91f-45e4-4f50-ebb4-08dcd3a3e5f6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bGM1cjRLREtKRTBEb2lpRW1vSGJUZDYrWlArakNQVTk5VEJwUEx0Vnl3clpo?=
 =?utf-8?B?TTU3L0N0NEpiTXhXOFp3RWtCU0pmQk5WdWhoeXh5RDBHTUkyVnovRlNRakxm?=
 =?utf-8?B?WTR4M0pHUS9Od2hkSkp4Zmdvck5hMWtnNnRjeGtPa0ZsdmxGbFpWN0dMTnpK?=
 =?utf-8?B?R3JPdHlwanNLUVJMQnd4M3JDemdIM3ZYWExQVkx0VllxY2x6Uno2UWJXeVUw?=
 =?utf-8?B?SEpybUZ4SmFTWjFPTitSSnkzNGtXQ1gycFBXb1NnY29reTl2TnZyWm0rZmJr?=
 =?utf-8?B?em5tWkN4eHlVdDRqbHdDUWtFaWhRT2tpd2N4YnlEcWhPQS92NVR4M0YyRW8x?=
 =?utf-8?B?UkVpVTc3OVZWeGd6YTFQVGFVa2VMQXMxa29RUG9oOGpEUVoyaVNLcWs3dEJl?=
 =?utf-8?B?b1dZZnJuSkQrV3YyZG9rYlBrUVhjejZyR1hlRTdGMTREak9INFRkWFlnNjBz?=
 =?utf-8?B?NEpseTdoQjRLTnNGN2ZiNStrbGdSVWtCS2IwWVh5MWFHR3FOSlRaRS96QjJJ?=
 =?utf-8?B?S1V6a3NyVXlRVXRabk1EMWFwS3V1Y2NCYmU5d1NBL081KzNEZ3hiMHpZWGps?=
 =?utf-8?B?WklZdzc0cWRmbm1FL3JTT3RLa09vRGJPUmdSajlyR3BUSkVxVSthZUVyeW44?=
 =?utf-8?B?cm5JckRuanFDeWlqM3EwU3lJamRzK0gwcy82bkpsMzN3ekF0aDhyRXVGcFZR?=
 =?utf-8?B?Nm1McFo5L3gxYjVaVU9rVGx0ZVhXaWZHalF4dWswYmRlSS9UMVFCMEhlanE3?=
 =?utf-8?B?b1c2OXJySXl0ZWxWUFM0cDNlY3dBdzFwKzMyMjlIOUlEYTU2Yy9GNXR5UUpT?=
 =?utf-8?B?a3BYcTZZM2JaYmp2bDBNdFVzMTZLaTFoMFhPcVV3cExjNXNPZ2hKY2ZuWlJH?=
 =?utf-8?B?RUQyNmZoUmx6RnRQR3Z2RkNRc2pNeWhoK29PeUVvMjhRSHRzZzI1MVB1SkUy?=
 =?utf-8?B?cW9BR0ovR1BpeTVEOENodzhEdjJzMG1IVEtkV1pjNUh6OCtJR3R1cm1GTU5l?=
 =?utf-8?B?bERuY2VBZWgwZ2lJM2l4OWFuNFdRM3hEalZMRnVQOWJKWDZvYVNHSllOVUlr?=
 =?utf-8?B?YllJc3JUS1NzejQ0N2JjYzNNQ3dvRjZhOUlONlh4SjJtdlFlVEI0b2U2U3h6?=
 =?utf-8?B?U3FGVm5uRFphWTVkWDFlQko0VVdkMldlcWc2NnlSYlRNZm81WHE3NUdiZWhI?=
 =?utf-8?B?eExDaXZNbGU2Ulg2RDhKT1JISVRMMEtTU3JacWd5dFlrRTRUQUtxSUdlSHlv?=
 =?utf-8?B?cWg3cXB0V3BqNjc1SWR3dmgvN0dHa1dWem84VmxZTUlSRklWQ3ZobzhKNmRF?=
 =?utf-8?B?MzVlOXJUaWo5VDhHeDl3anAxUzNGeW52bEhpRXVFZlhDOVpmdCtaYWIxVGVi?=
 =?utf-8?B?YUN1MnFkOUhVYWxEVlEzMVdSby9KbThUUXRIRTB5UmVUQ1VTSU1lQ01kdWQy?=
 =?utf-8?B?ak1OTDFlcXRrZHBwbm9qQVdidERFcTFlL3JZRU1KajlraTRIMzVLVVhKbUg0?=
 =?utf-8?B?ZndqZUJzQm9FTitaTzV0am5NVlZCbzUwSWd2UWNlN0t5bGQ2bzczTUVUbzNM?=
 =?utf-8?B?enNuWjcxa0hwUFBxbXhvc3hNUGdZbGVBZkpQVndSRDJGQkROQmx3WjdSeThy?=
 =?utf-8?B?S3kzTEZtR0RadXFXZzlUMnE0MTVZN3BTMmMrYjB1UGhsOTZ2THhvaWp4YUpI?=
 =?utf-8?B?L1ZobTB3ejY1NDNkQkxmT0tkV0JHY05Eb0dPNWhDcTNJUWpIZ0FMZGJrYnlC?=
 =?utf-8?B?dkt0dHFYN1BJTG5ZN08wQTI4MXpMLzladDFWaE9ZZ2dXNW5zSFk0SUQzV3dJ?=
 =?utf-8?B?TVBjYmlLSXZYNGI0Ujk3dz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR04MB5853.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QUF1R1BVVjdoMmI5dVNRYkl5ZlEvV0FEMWJpMjVBQi9GOUZwTkxTNEx2eldL?=
 =?utf-8?B?SXJCNnRwNTBDNmFOdFdzNVdJYW5NWjU3YnVWdGIySFBhaktzUWgyZDJBUDl0?=
 =?utf-8?B?UFZCWUhQWlVFRTBHWmlJcGNDNklteE1ZU21leDB2YjNmQzVIZjZ4dXZMengy?=
 =?utf-8?B?MG9tWEh0QlV6dFlhdlVFSmdBMi8zMlorK2RTdzZwaC9HVFFaSHQ4dUN3YkY2?=
 =?utf-8?B?c3lHVnNGczJRdFBXOFp4UnJ0bDhqdWZBMzZ1SkdYRmpHRHhmSmxlY3ByVXo4?=
 =?utf-8?B?OGlBb0l6UUw4bHpxallyKzQxdklzRFpKRzFiaFRrVEozYkUxaXlFbkhaRUlz?=
 =?utf-8?B?UWVsUjRkVGZxRWg0MHl4WWF3bkI4Y2RkWHpBbkhBcXhNZXdpamdEbHhlMGJG?=
 =?utf-8?B?WjJHNHU1aE1scXVCZXhYRkJoNEkvTVR2Z0Z6dEhhSFd1ajFFVTBBWDlhdEJq?=
 =?utf-8?B?QklreDJwb0dhMDUzb01QNGdlQm1YNGtmZzJDRnJyUjd6aFFTWVJVQnh6VC9R?=
 =?utf-8?B?ZEdtQ2tRczhXYUZWN2lBbWlpNlBScm9tc0FRK0JnV2xRZmpHbmpYMld1eDF3?=
 =?utf-8?B?WFJLTFA2djMzZy9RQ0FCMTlnS0w4N1BhSVhnb2lYOC91aUp4QlprWWxVSGlV?=
 =?utf-8?B?ZDBnYndCZyt0U0t5cXNYYk1sUXJFMEx6THhyY1RVcVR5RjBuTi9WQWJZZXJR?=
 =?utf-8?B?Qm85UllJVnhLVXpxb2xUd2Jka0cvUE1SaGVWREhVTFVXMmJPdVlMb0JmWXhY?=
 =?utf-8?B?MElkUXJIV3FiTHlDWkRYMkFKY3MzMkk1K1VEa2VSbjFjcGJNYnNNb3lHNURE?=
 =?utf-8?B?MDluemF5ZXhuZnJMYU0rL3FJMUp6ZUFxYVBxc0djekhScFFKbHJvMUFZVFpK?=
 =?utf-8?B?ZzFKd3VKMmZrR1JwemdvZTdTdTh2M21iWk40YUlHSDdmVXNvVGphY2VEZzJn?=
 =?utf-8?B?N1B2ZDhIb3hHZytScjRSSXFZOUtINFlPNVoxVW12bmkxdG4vQ2lQbzdDVVpv?=
 =?utf-8?B?MU00akN6eGZUYjYzOUVZaVhzNS9ETWxJb0lmTDBJWmhmTmZnMWpoblQwYU12?=
 =?utf-8?B?dHdLUDNjdjVsYkFnTmlOM3h6QTFmUGFEZXhmWEdzekExNjIyNlVYTUQvRkpv?=
 =?utf-8?B?ZHJZYWgvUkUreVJSR0NrL0hFeXRPUSttM3NwaFA1UGN3LzVMZTBPeWl3cUxD?=
 =?utf-8?B?UVJNbEwyWkI3TTRha2hqam8xanV0OTFwK09YOTc1V1c5Y1RubEhqcXc4M1d3?=
 =?utf-8?B?TE9tczZiMVpvcjVuMTk3RDBNMFNONGpBaGR5SzFpL0dja2hSNXlTNDFnQ2tw?=
 =?utf-8?B?Z2RSYVJwSGVNMlJGeTdBNmJmK29MRkpIS3ZHdWZvZmFlWmEwcDBBVnVPeDU1?=
 =?utf-8?B?VFg0RWJpaTlEWG93TDJYUmhMQms4TXRUejRvWm10RHpJZjV0ZjVRc0Q5WlI1?=
 =?utf-8?B?WG5GU0dxV3cyZlFkYVNYVWZlL1lmZWQ3cWFFY3RlR2JKblNibnlLTEprb21q?=
 =?utf-8?B?UE9tZ3JmTEwxTUhvZW9WTTNNRGZGUCtrSU5NbzNuOE1WMnFCRVNMMlJCY0Qz?=
 =?utf-8?B?ZGFid2FSMThZS0MrZUZvc2ZuQzFUTzVlTXliMmZOeDlPRjNJdS82WWMwNFNQ?=
 =?utf-8?B?aUp0RC9wU1RqNmd4cVhVTjk5MFRkUml6dUt1T0NxT3Y5VituaHFDZ2ZtN296?=
 =?utf-8?B?ZEFyV01kY2xFZUsvbU9Pd2svcS9LVGlLdTJrNlRNNVBXTmNaMjUrU3JKOUV4?=
 =?utf-8?B?TVFxT0tOQTM2T09ZZDBHY2k4N05LNWhvU25qTVUyUEVHc0t2aFo4QWpXOThk?=
 =?utf-8?B?MnhyYkxqY3AyVzFqV0Z0ejdTaitnUytjaXdwekVZa1M4Nk1yR1VRVkF6Mm1x?=
 =?utf-8?B?QVN5L1orQjh4dDZHbnVMWWQxOVZ5OVFGb3h2YTltTkszM2VIZ21tZW1NQ1Bz?=
 =?utf-8?B?MVU1VndvV1RpZ1pmalBzSi9LeGpJSzV1K3l0RXN5RHBvYndOSXdoeDM5bG8x?=
 =?utf-8?B?RFM1am1yNUE5Mk1CbkJycFo2aFREN0I2M0pqOHZXNW11WVNINlBYSEFwazg5?=
 =?utf-8?B?WjhjNUpseUF6NHU1YXNLTHh4YmpzYnpSeFJtSDBzOTVPcmhFYjBHaEtJMDRZ?=
 =?utf-8?Q?oEn/tQFkIFkwV5JuTxiddFr7C?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a7bf91f-45e4-4f50-ebb4-08dcd3a3e5f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2024 03:26:47.0687
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2bKGtPIXElVTYT1H3vmAElMtSFRULMgLzKH/isG6xH/K7gd/lHZh+J6RiPZ6m9JpttdLkIKPzqhA/IWyQgxsDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR04MB8334

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRGVscGhpbmVfQ0NfQ2hp
dS9XWUhRL1dpd3lubg0KPiBTZW50OiBGcmlkYXksIFNlcHRlbWJlciAxMywgMjAyNCAxMDowOCBB
TQ0KPiBUbzogQW5kcmV3IEplZmZlcnkgPGFuZHJld0Bjb2RlY29uc3RydWN0LmNvbS5hdT47DQo+
IERlbHBoaW5lX0NDX0NoaXUvV1lIUS9XaXd5bm4gPERlbHBoaW5lX0NDX0NoaXVAd2l3eW5uLmNv
bT47DQo+IHBhdHJpY2tAc3R3Y3gueHl6OyBSb2IgSGVycmluZyA8cm9iaEBrZXJuZWwub3JnPjsg
S3J6eXN6dG9mIEtvemxvd3NraQ0KPiA8a3J6aytkdEBrZXJuZWwub3JnPjsgQ29ub3IgRG9vbGV5
IDxjb25vcitkdEBrZXJuZWwub3JnPjsgSm9lbCBTdGFubGV5DQo+IDxqb2VsQGptcy5pZC5hdT4N
Cj4gQ2M6IFJpY2t5IENYIFd1IDxyaWNreS5jeC53dS53aXd5bm5AZ21haWwuY29tPjsNCj4gZGV2
aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFk
Lm9yZzsNCj4gbGludXgtYXNwZWVkQGxpc3RzLm96bGFicy5vcmc7IGxpbnV4LWtlcm5lbEB2Z2Vy
Lmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUkU6IFtQQVRDSCB2MSAyLzJdIEFSTTogZHRzOiBhc3Bl
ZWQ6IHlvc2VtaXRlNDogQWRkIGdwaW8gcGNhOTUwNg0KPiBmb3IgQ1BMRCBJT0UNCj4gDQo+IA0K
PiANCj4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+IEZyb206IEFuZHJldyBKZWZm
ZXJ5IDxhbmRyZXdAY29kZWNvbnN0cnVjdC5jb20uYXU+DQo+ID4gU2VudDogVGh1cnNkYXksIFNl
cHRlbWJlciAxMiwgMjAyNCAxMDoxMSBBTQ0KPiA+IFRvOiBEZWxwaGluZV9DQ19DaGl1L1dZSFEv
V2l3eW5uIDxEZWxwaGluZV9DQ19DaGl1QHdpd3lubi5jb20+Ow0KPiA+IHBhdHJpY2tAc3R3Y3gu
eHl6OyBSb2IgSGVycmluZyA8cm9iaEBrZXJuZWwub3JnPjsgS3J6eXN6dG9mIEtvemxvd3NraQ0K
PiA+IDxrcnprK2R0QGtlcm5lbC5vcmc+OyBDb25vciBEb29sZXkgPGNvbm9yK2R0QGtlcm5lbC5v
cmc+OyBKb2VsIFN0YW5sZXkNCj4gPiA8am9lbEBqbXMuaWQuYXU+DQo+ID4gQ2M6IFJpY2t5IENY
IFd1IDxyaWNreS5jeC53dS53aXd5bm5AZ21haWwuY29tPjsNCj4gPiBkZXZpY2V0cmVlQHZnZXIu
a2VybmVsLm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOw0KPiA+IGxp
bnV4LWFzcGVlZEBsaXN0cy5vemxhYnMub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3Jn
DQo+ID4gU3ViamVjdDogUmU6IFtQQVRDSCB2MSAyLzJdIEFSTTogZHRzOiBhc3BlZWQ6IHlvc2Vt
aXRlNDogQWRkIGdwaW8NCj4gPiBwY2E5NTA2IGZvciBDUExEIElPRQ0KPiA+DQo+ID4gIFtFeHRl
cm5hbCBTZW5kZXJdDQo+ID4NCj4gPiAgW0V4dGVybmFsIFNlbmRlcl0NCj4gPg0KPiA+IE9uIFR1
ZSwgMjAyNC0wOS0xMCBhdCAxMzo0NyArMDgwMCwgRGVscGhpbmUgQ0MgQ2hpdSB3cm90ZToNCj4g
PiA+IEZyb206IFJpY2t5IENYIFd1IDxyaWNreS5jeC53dS53aXd5bm5AZ21haWwuY29tPg0KPiA+
ID4NCj4gPiA+IFdlIHVzZSBDUExEIHRvIGVtdWxhdGUgZ3BpbyBwY2E5NTA2IEkvTyBleHBhbmRl
ciBvbiBlYWNoIHNlcnZlcg0KPiA+ID4gYm9hcmRzLg0KPiA+ID4gVGhlcmVmb3JlLCBhZGQgcGNh
OTUwNiB0byBwcm9iZSBkcml2ZXIgZm9yIHRoZSBDUExEIEkvTyBleHBhbmRlci4NCj4gPg0KPiA+
IEkgdGhpbmsgaXQgbWlnaHQgYmUgYmVzdCBpZiB5b3UgYWRkIHlvdXIgb3duIGNvbXBhdGlibGUg
dG8gdGhlIGxpc3QgaW4NCj4gPiB0aGUgZ3Bpby1wY2E5NXh4IGJpbmRpbmcganVzdCBpbiBjYXNl
IHRoZXJlIGFyZSBzb21lIGJlaGF2aW91cmFsDQo+ID4gcXVpcmtzIG9mIHlvdXIgQ1BMRCBpbXBs
ZW1lbnRhdGlvbj8gTm90IHN1cmUgaWYgdGhpcyBzaG91bGQgYmUNCj4gPiAiZmFjZWJvb2sscGNh
OTUwNiIgb3IgInd5d2lubixwY2E5NTA2IiwgYnV0IGFzc3VtaW5nIGZhY2Vib29rLCBmcm9tDQo+
ID4gdGhlcmUgeW91IGNhbiBzcGVjaWZ5DQo+ID4NCj4gPiAgICAgY29tcGF0aWJsZSA9ICJmYWNl
Ym9vayxwY2E5NTA2IiwgIm54cCxwY2E5NTA2IjsNCj4gPg0KPiA+IFRoaXMgYWxsb3dzIHlvdSB0
byBhZGQgdGhlIHF1aXJrcyB0byB0aGUgZHJpdmVyIGFzIHJlcXVpcmVkIGluIHRoZQ0KPiA+IGZ1
dHVyZSB0aHJvdWdoIHRoZSBtb3JlLXNwZWNpZmljIGNvbXBhdGlibGUuDQo+ID4NCj4gPiBBbmRy
ZXcNCj4gDQo+IEhpIEFuZHJldywNCj4gDQo+IFRoYW5rcyBmb3IgdGhlIHJldmlldy4NCj4gSSds
bCBhZGQgdGhlICJmYWNlYm9vayxwY2E5NTA2IiBpbiBncGlvLXBjYTk1eHggYmluZGluZyBpbiBu
ZXh0IHZlcnNpb24gb2YNCj4gcGF0Y2hlcy4NCg0KSGkgQW5kcmV3LA0KDQpJIHRyaWVkIHRvIGFk
ZCAiZmFjZWJvb2sscGNhOTUwNiIgaW4gdGhlIGNvbXBhdGlibGUgbGlzdCBvZiBncGlvLXBjYTk1
eHggYmluZGluZw0KYW5kIGFkZCBjb21wYXRpYmxlID0gImZhY2Vib29rLHBjYTk1MDYiLCAibnhw
LHBjYTk1MDYiIGJ1dCBnb3QgZm9sbG93aW5nIGZhaWxlZA0KbWVzc2FnZXM6DQogICAgZ3Bpb0Ay
MTogY29tcGF0aWJsZTogJ29uZU9mJyBjb25kaXRpb25hbCBmYWlsZWQsIG9uZSBtdXN0IGJlIGZp
eGVkOg0KICAgICAgICBbJ2ZhY2Vib29rLHBjYTk1MDYnLCAnbnhwLHBjYTk1MDYnXSBpcyB0b28g
bG9uZw0KICAgICAgICAnZGlvZGVzLHBpNGlvZTV2NjUzNHEnIHdhcyBleHBlY3RlZA0KICAgICAg
ICAnbnhwLHBjYWw2NTM0JyB3YXMgZXhwZWN0ZWQNCiAgICAgICAgZnJvbSBzY2hlbWEgJGlkOiBo
dHRwOi8vZGV2aWNldHJlZS5vcmcvc2NoZW1hcy9ncGlvL2dwaW8tcGNhOTV4eC55YW1sIw0KV291
bGQgbGlrZSB0byBhc2sgZG8geW91IGhhdmUgYW55IHN1Z2dlc3Rpb25zPyBUaGFua3MuDQo=


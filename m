Return-Path: <linux-kernel+bounces-200961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FC268FB79B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 17:41:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51CBDB275AB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 15:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE556143C7B;
	Tue,  4 Jun 2024 15:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asem.it header.i=@asem.it header.b="ujez5/fn"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2069.outbound.protection.outlook.com [40.107.244.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3A0144303;
	Tue,  4 Jun 2024 15:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717515087; cv=fail; b=t8iSDHc8FRO2/Pqr2zpOujxb0qfIU4vZu4AJm8Fh9Mw5x9lsDmEdsc+bzOvQqUmBIluVSDTgOQYhESIWC6FMjGikh+g3M4i28tyX/Um1mOWmYXrXSgV2po2PPnZTfzmdieYsQibCvaei/iQZZRKUBjzTB/LNlO3jYWby6NwJswo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717515087; c=relaxed/simple;
	bh=/F1KfEKhpIZi2d6LSgkuejULkpmbf4FYzUrPyBRNDGE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=r7yQLxYi8dtAFYByN2EamjnWdyc7pc3MkEHuQSUVgyNyqhxdmbOnqwnDF2KpOVj9KRIA0rIZoRIA3cggF2Fp850+ddORBFVLvnCnusCY61gw/NHdFd0Eox/hKJJ9oTtENrVo7rPu8oN+QhHVreIFEdR2AKFqFoC1NlDYI0TeKVY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asem.it; spf=pass smtp.mailfrom=asem.it; dkim=pass (2048-bit key) header.d=asem.it header.i=@asem.it header.b=ujez5/fn; arc=fail smtp.client-ip=40.107.244.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asem.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asem.it
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b3GtlgLT+YOpJF5MA/Ekrr+89lUXEGgAeK2m1cQjL4jYZ4wLF+Ue/q1wtJYJKkS+yquxyXf0rs7LvchZsBqjpDzdqHdLQYUAwcLYsfY1uajSauqXNq0plVFDgWaEXDwnABFdxVG5D7qRXfRqeJJqDtLNmcK+QQL57+OMY4SaJWVEXvzLaaGmx+e77uSdlpn+hzFHEcalkNpBFLjcmfNUUgV01cLw9nbCP3zqyVBm0stSjrgKcAwLbXxwosZUj8MXlYno/ly3sTuu0uCHvprAiqyF2xMIPvSTzzrT4boIFlDRI6dPYW/5Ac2BMnWBUyTWWpmaBLTN1FxEHP+Sewf9hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/F1KfEKhpIZi2d6LSgkuejULkpmbf4FYzUrPyBRNDGE=;
 b=kAu8Qjoqy49BFBMlY8RG0iYgFLPKJs2RBlityiHMMZZYWBwnbY8o3cIjnBqg0nE7pjgxHF8eM0Pgmf7Wt0X7uALRAvpHNPhXUjGyE4WFud/8fLClifvOjvNT6CY6qixmeggcR1XwAb+yhCY+3UR93ZkDmTRFHDf4FdqOL+eJ7W1IXuBEBsZ9RrYl/9+2Sy3hZDWye4VilAwJ7y1w3yU/N5++uflZxQWTt+cp7G9mS9BLpDvhyKaPr8nNWaNyYC8Nj68KKxOJwqnTpThWQcE9ma5t+gBFmWS2IDy1LV9X4FjnhfwjA7dRJFX8mp7dqIKE5I7HLNX98SFUm0bq/oSCzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=asem.it; dmarc=pass action=none header.from=asem.it; dkim=pass
 header.d=asem.it; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=asem.it; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/F1KfEKhpIZi2d6LSgkuejULkpmbf4FYzUrPyBRNDGE=;
 b=ujez5/fnPNaFtOwyYoW20dnJ8Bz6oRRINQKqSnGZpO+Sa4MizXeTrJvAdZInZPhSdpFZifFsfvxIBrgX5deOhShlvHLr7PPQpQFr4XUTdteBCmGrkBmQJVufQ75X73gBGEOjCjXwzrYUyjZp1XPnwp8fcQTeKHORJ/VwmxUgTXx2suNYAyaw+fDhI7beO8YT2RtYe3VXwsHlabxk36dTRuhnIy7tEQef9W2Mqkw1UCk4A77CzKCqNbD8O2QFXdb9tmLKNo7YFOZ/tzKD68ts5CcYQlqYChM6ZGng+fBI37aiNoXM1i5fE1/XcmPcyE3cCVAtWb7zFwOLF/v/OhGJDQ==
Received: from PH0PR22MB3789.namprd22.prod.outlook.com (2603:10b6:510:29c::11)
 by BY1PR22MB5557.namprd22.prod.outlook.com (2603:10b6:a03:4aa::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.25; Tue, 4 Jun
 2024 15:31:21 +0000
Received: from PH0PR22MB3789.namprd22.prod.outlook.com
 ([fe80::e21a:e0c7:aff:b839]) by PH0PR22MB3789.namprd22.prod.outlook.com
 ([fe80::e21a:e0c7:aff:b839%4]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 15:31:21 +0000
From: FLAVIO SULIGOI <f.suligoi@asem.it>
To: 'Michael Walle' <mwalle@kernel.org>, Tudor Ambarus
	<tudor.ambarus@linaro.org>, Pratyush Yadav <pratyush@kernel.org>, Miquel
 Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
CC: "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	=?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= <u.kleine-koenig@pengutronix.de>,
	Thorsten Scherer <t.scherer@eckelmann.de>, Marek Vasut <marex@denx.de>, Imre
 Kaloz <kaloz@openwrt.org>, Andrew Lunn <andrew@lunn.ch>
Subject: RE: EXTERNAL: [PATCH] dt-bindings: mtd: spi-nor: deprecate Everspin
 MRAM devices
Thread-Topic: EXTERNAL: [PATCH] dt-bindings: mtd: spi-nor: deprecate Everspin
 MRAM devices
Thread-Index: AQHatlLKRKOhNYntBkyzBolAkIG/5rG3shNw
Date: Tue, 4 Jun 2024 15:31:21 +0000
Message-ID:
 <PH0PR22MB3789629B835FB187E3E94510FAF82@PH0PR22MB3789.namprd22.prod.outlook.com>
References: <20240604074231.1874972-1-mwalle@kernel.org>
In-Reply-To: <20240604074231.1874972-1-mwalle@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=asem.it;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR22MB3789:EE_|BY1PR22MB5557:EE_
x-ms-office365-filtering-correlation-id: 83f37af7-1906-4679-a05d-08dc84ab630d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|376005|1800799015|366007|7416005|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?RHd0bE1Xb21LZ1JIQ0JvUkg3VVEyUDc2aFRUbDhYMk95aEp3UEJZRXZnN3dl?=
 =?utf-8?B?NTBTcEJXZC9XbVdabkhVbTl1Um5Ccjh5VzJxQytlM0RkREFzOTVuc3dPTCs0?=
 =?utf-8?B?YzVCUXdGY0Jqa3lEdEkrSE9TR2RSMEhEYjJsREJ0RWJYZW8zVVp1NDJ4OC9F?=
 =?utf-8?B?STkzcWJoVDZZZ05EZXNTYktNaGtHNUlUT2tiSXNrdDRLZzdjOWJ0YUlIZ2RV?=
 =?utf-8?B?U1c5bWVsS1cvMHFXc2lWb0dTMUtJZ2QxVzlkdnFGSld6MEhYR0YxeXVxVnEr?=
 =?utf-8?B?Q1pWMDUrZ2ZBY3FSaWJrcnFra2tNOFU5K3dpcVU4SCtZRWE2NHUxU21WTVln?=
 =?utf-8?B?L09rUjUwT0NMVjExUVN3MzcrWjFoZk9CN1Fkc3p5TXFxUHJLM2pyYVgvaWcx?=
 =?utf-8?B?SlB1TE1sZTgxSnJmZkJSOFBrckZqTWJzc016bVMyUnZJRTNjdk9Ucndaa0dD?=
 =?utf-8?B?T2xJc3ZMamFramR3Z0kwUG14Qy9ZdVUzZ3g5UzJsUG5SMVAwOHFuS3ordU5K?=
 =?utf-8?B?MDVEdkQ5SHlMeElaMlVibjloT0pIb3VPTTB2SUF6TTFUUkczOW1VdmxpR3R6?=
 =?utf-8?B?bmxHUFlqMFovMFdlVFovb09PYjdUTklWSE83Um41VDUwb1p2OWxaRVdLN0NB?=
 =?utf-8?B?enp0cHBDTk1sc2xHbGxHRjk1cEdGdnVoZktuc3JSQ1lLQ0MxZnhBeEFxdGJl?=
 =?utf-8?B?K2pyRnpzRlhDOFgrU0JETTc5anN1MmxXYUJuNTArWkE1VzkycjBjMExTaURJ?=
 =?utf-8?B?ejByZVllVm1NdTNGYld6Q0h5VmcrZGJjY2Vib3JpcWRjOU1mSzUyc0xiL1BN?=
 =?utf-8?B?Q2dKd3lRN3kyZGt6L1ZXTHErbmhYb2F1clNSUlFMdGg3WGdTK01kenp6WkpQ?=
 =?utf-8?B?K0ZvTTJJWVRuN2wzQmU1Q3hZaFJaT2cveTlaUUNyRXlqYjdiTnpXS1pUVUtT?=
 =?utf-8?B?bzZyZkRkT2xtZ0FLaGdxUEg2d1JhbXVubWdrSmJJZ29YRVFZOTdoU1hWUXpG?=
 =?utf-8?B?Nmt6QTQyN1dIeEVmQUVrWEJYSTlwUk5waWtHclJyUk9Nek9VSDkwb1I4YUl6?=
 =?utf-8?B?K2tMb3h5K3h5MjByL2RNQm9PcEJ6a3RscHpETGFFTUVjWUN0YnFaa1B3NzlJ?=
 =?utf-8?B?bHhsT1NjZ3VOS1Y5RmEyelpoQmlldHlGZWd4ZUdHbjlCUE9OQ0Z6blQxWWhT?=
 =?utf-8?B?OXJNSkdwcHYzdHlGeXlHYmtkWTNHMzc0cHp1eXo4SW02cVd5eHZiOFpEUUFs?=
 =?utf-8?B?ZUFub3gwTGhVaC93cUVSQWFSbTJiZ0ZSV1FmLzAzVlNLL0tjUDdGaVpCWlZo?=
 =?utf-8?B?dXR3OXBnQlFOM1I5bkw2Ukd6VmVEWVZtTDZKRWJFeUhqeE5FQUJZc1lJdWxu?=
 =?utf-8?B?TmgvVklNSUpBbVNTUGdyUUpQVkNxKzNxVm42QmhGL2xxWWl1eFEvMG5mTFRq?=
 =?utf-8?B?WVd5OWM4TWM2YmlxN2Jmem9vNFFYQXpaTFNhTWtnY1dkU3VvSzUzbnFHOGds?=
 =?utf-8?B?Z2x6OWpvMFVLZDAxWUtIUmt0Tm9NYURSaXRjYXhGeFYvaUVPT1RwTkFFWlpY?=
 =?utf-8?B?OXVQM1FJalU1L3I3T2ZzVkwxd1NCRVFqMTU1ZWhOc2VyVzRpME9BOXZGZUhC?=
 =?utf-8?B?UUllOEFJbXhBZkFFWlp2UnZ1a2JEOWZ3Z3pyZFJmQllOalphcyt5M3VZK0xt?=
 =?utf-8?B?UlhYdXU0UWRvdnJlNjYzakVLV2gzN1prUWc0NHFUbzRiWGx1M2FmVHpxTkNr?=
 =?utf-8?B?UHlkOEJ3SFhWTkY1cTluR0pZYnV1UnQwTmhXUjFRcnhSaWpvUklkdVhuR3BY?=
 =?utf-8?B?bUNtNnpVSTVzY25GSzI0UT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR22MB3789.namprd22.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(7416005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZEx2dUphYzNZZ1NqdWNMaUFTNDVwSzV6amN5cVdsdEQwQ1BnQkFGWW9sZzR0?=
 =?utf-8?B?ZVdsK0lLOVVJcHBHYzh2Z3JpWnM2RGxxWVhRWEw2VXJnSUh3SzAzc2VOelUv?=
 =?utf-8?B?YlFmekpXUDRrc2NiditHV2dIanNDNEIxa0dGUndoMmVyMnNTbkwyZEoxbmtC?=
 =?utf-8?B?WGpYMXBqUGs3UENPNy9zUkc3TWpsVk9mMTk5N0tjUzlNcWpjT3Q0akhQQmRk?=
 =?utf-8?B?OGRPR0ZuWWkxTm5qdHNlcWNTOWxwRzBlYTAwVjJralJKa2tEdXhkWlVzTU1i?=
 =?utf-8?B?NHdjcm4wTVlWcEtSZyt2bEV6UlFEWkhoU0NDaG54UXBSdHQ4eG5IQnFkb25j?=
 =?utf-8?B?ZFNOM0c4UE9kY1l6ZU9KaHh6ZGtMMll1TW1YTHkwcXNTSnp4L28vTlR4UE1P?=
 =?utf-8?B?WDJqdEttcTJBdkV2Ym9wdWdXUW1va1lnZm96blhieGxUd0U5QkNzaTJwUXZM?=
 =?utf-8?B?dTk3dldqb2NONkZ0dWJDQy9QMWZ4SHlNSVVJU3M5WmpJektwQUpSWi92SWlE?=
 =?utf-8?B?enlTRk5mODFJc2ROZ3h3b1FCQitIbzdLSm9hNE15aEtIMldiMDVham5jV3Rj?=
 =?utf-8?B?eUJsdzVCditCQ1RCWGhwaWZQWXZ6UGVXNm96djRiL1dFNXhDOWNqTUx3VXpL?=
 =?utf-8?B?KzdIOExlQnVhYWI2U0NybVdSa2hIb2I1SUR5NWR1b1FVMGRGQnE5UWViZmhp?=
 =?utf-8?B?V01CVEJKbDBKcUZ5YkJ1Y1RJNzBSRjVkdFlTc1N2eXQ1clVVTVBDNGtFMW55?=
 =?utf-8?B?QXdGL0drVTltZ1VBdThLZ0dpMXhaYlFMV2JBbktoL2xPcXpyZFk5QjcyTmdO?=
 =?utf-8?B?RFZhWTgxWlEya211cEN5RDNLS0xxcjFXODdrRHA4WkFrMGRCMzQ0RjRUWEZS?=
 =?utf-8?B?dzBlQnRrODJ0MzZKOXR2Q0pHbnFRU1lVTDZvYXdLZWxxRU9PRmV0OWFQd3Q1?=
 =?utf-8?B?M3M3YlA0eXQ4NW9wOWtTM05nZ3M0WTQzMVlicVZ2RHMrd2RaMXJOZFZXNjBL?=
 =?utf-8?B?ZWZQQ2lxdGFlbDdvMm55dEZvMjJRUDdUa3FlMjRMcXhheTFPLzFEb1JPK2hD?=
 =?utf-8?B?d1ZuTGNmVEtOWm5WNC9GNmpXNzNKSHNVd0FuT0szRTI0QlEyZFJPcjdUQ0xm?=
 =?utf-8?B?ZW1XNmdTL0wraUVGakFEZ3BGSDM3aGpNTmx1YkVBQyt1RTFwMS9JSFJFRlF6?=
 =?utf-8?B?UU54MzJJSEVNTnpvSnBDR1NQRkZ6WjJ0MEJPak1Ic3lORHduNFN5eVNJN1dW?=
 =?utf-8?B?VXRvdmhrZ2F0bGxtUGxFMUN0Vmd2WFdMUE5hRUZUd3Z6RVJmRzRWdEt0MlBw?=
 =?utf-8?B?QjY4TnF4N3g5dFlsd1AxVmVzc0xOd1Y1RGtaOXdJYXcrL01weW1ILzh6RUli?=
 =?utf-8?B?Tk1IS1NyY0M4NnRMaHhiL00rbE5SZVFjdWF4Q1Q2QTNRY0JTTnM3SytsV0Ni?=
 =?utf-8?B?V2pIVzIyd1RHb1lJa1JFT2JUSmN0dlZldUdLRlZLVWI0ZnZLTloyWXFidHZu?=
 =?utf-8?B?MmpMSWlBc3Y2SEpINm9VemxNSVR5d3p4R3NHVkJnRzcvMEU2a1I5d2h0NWZ2?=
 =?utf-8?B?eXBoVWI1R25admdDeDFXNTEvTUF4TGk4cGZlWnBlcGJvQnpYY0RCSVFhTVhk?=
 =?utf-8?B?L3JXSlVjKzBBZnF3bkErc1NYUVJvU2hCTzFrMjZudGZMdExweVBsQmFFK1pB?=
 =?utf-8?B?ZnRkNm43YWtuTFpyekk1akJqWUVWeWJyVzRsTTlZVHZOQzlyL3Q1ZUVabEV4?=
 =?utf-8?B?c0JzVmIrUlNQeDBaUHhtbTBzR1BqTjlwMVJCSlFPSnoxS0RVSUlIaFdnQ0xo?=
 =?utf-8?B?NnVhcXJVMmxlZW5mTmtGVUFhZlpDUmoyWCsyQVpNeDc4Y3p4YWRNbHY1UjFj?=
 =?utf-8?B?QTd4cFpGS2pBeUZhdW94UFdlUllGRzBldVUwNlFPbXRQV0kwVjhqUDFQaUxz?=
 =?utf-8?B?a1dORGhvQzY1NnoxTUVVVUVqaUI1b2VFYThNWS9iT3FRYWNIYjMzdWxGdkc4?=
 =?utf-8?B?UG1HbFd1VHkvd0V2ZWpNWUlrdTgzeGdiMHJSQ1lqZTRJd3IzVEk1M2JiOHY5?=
 =?utf-8?B?UUJ3TDdMRkpvbnBqRXFRSmI2bEEydzRSWXpyNERRcWRtb3lmUmdzMjNKandK?=
 =?utf-8?B?KythbHJiR2NyUWZkNVFwcjZxR05iRmR2V0dGVWFoZFV5YTAwWGJlK3A3eTdv?=
 =?utf-8?Q?u8rJfrLyKBFnktcS7wQK6ms=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: asem.it
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR22MB3789.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83f37af7-1906-4679-a05d-08dc84ab630d
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2024 15:31:21.5308
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 855b093e-7340-45c7-9f0c-96150415893e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4mkk9+eA1Cm8Pb/gLi/h33bEhM2jztZBJyNlBh9JODo/dJszL6a5UleiL7GxR9sbegMuTnMJC90eS6e83rBzHa9+YPN2gRV856TQlrE7tdWBcgw1ahZ9gUg4H4SmrCqB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR22MB5557

SGkgTWljaGFlbCwNCg0KLi4uDQo+IC0tLQ0KPiBUaGUgcmVmZXJlbmNlZCBiaW5kaW5nIG9ubHkg
c3VwcG9ydHMgdGhlIHRydWUgQVQyNSBjb21wYXRpYmxlIEVFUFJPTXMNCj4gd2hlcmUgeW91IGhh
dmUgdG8gc3BlY2lmeSBhZGRpdGlvbmFsIHByb3BlcnRpZXMgbGlrZSBzaXplIGFuZCBwYWdlIHNp
emUNCj4gb3IgY3lwcmVzcyBGUkFNIGRldmljZXMgd2hlcmUgYWxsIHRoZSBwcm9wZXJ0aWVzIGFy
ZSBkaXNjb3ZlcmVkIGJ5IHRoZQ0KPiBkcml2ZXIuIEkgZG9uJ3QgaGF2ZSB0aGUgYWN0dWFsIGhh
cmR3YXJlLCB0aGVyZWZvcmUgSSBjYW4ndCB3b3JrIG9uIGENCj4gcHJvcGVyIGRyaXZlciBhbmQg
YmluZGluZy4gQnV0IEkgcmVhbGx5IHdhbnQgdG8gZGVwcmVjYXRlIHRoZSB1c2Ugb2YNCj4gdGhl
c2UgRUVQUk9NIGxpa2UgZGV2aWNlcyBpbiBTUEktTk9SLiBTbyBhcyBhIGZpcnN0IHN0ZXAsIG1h
cmsgdGhlDQo+IGRldmljZXMgaW4gdGhlIERUIGJpbmRpbmdzIGFzIGRlcHJlY2F0ZWQuDQo+IA0K
PiBUaGVyZSBhcmUgdGhyZWUgaW4tdHJlZSB1c2VycyBvZiB0aGlzLiBJIGhvcGUgSSd2ZSBDQ2Vk
IGFsbCB0aGUgcmVsZXZhbnQNCj4gcGVvcGxlLiBXaXRoIHRoZSBzd2l0Y2ggdG8gdGhlIGF0MjUg
ZHJpdmVyIGFsc28gY29tZXMgYSB1c2VyLXNwYWNlDQo+IGZhY2luZyBjaGFuZ2U6IHRoZXJlIGlz
IG5vIG1vcmUgTVREIGRldmljZS4gSW5zdGVhZCB0aGVyZSBpcyBhbiAiZWVwcm9tIg0KPiBmaWxl
IGluIC9zeXMgbm93LCBqdXN0IGxpa2UgZm9yIGV2ZXJ5IG90aGVyIEVFUFJPTS4NCj4gDQo+IE1h
cmVrIGFscmVhZHkgZXhwcmVzc2VkLCB0aGF0IHRoZSBzcHMxIGR0cyBjYW4gbGlrZWx5IGJlIHJl
bW92ZWQNCj4gYWx0b2dldGhlci4gSSdkIGxpa2UgdG8gaGVhciBmcm9tIHRoZSBvdGhlciBib2Fy
ZCBEVFMgbWFpbnRhaW5lcnMgaWYNCj4gdGhleSBzZWVtIHNvbWUgcHJvYmxlbXMgbW92aW5nIHRv
IHRoZSBFRVBST00gaW50ZXJmYWNlIC0gb3IgbWF5YmUgdGhhdA0KPiBkZXZpY2UgaXNuJ3QgdXNl
ZCBhdCBhbGwgYW55d2F5LiBTbyBpbiB0aGUgZW5kLCB3ZSBjYW4gaG9wZWZ1bGx5IG1vdmUNCj4g
YWxsIHRoZSB1c2VycyBvdmVyIHRvIHRoZSBhdDI1IGRyaXZlci4NCg0KR29vZCBpZGVhLCBJIGhh
ZCBhbHJlYWR5IHRyaWVkIGEgc2ltaWxhciBFdmVyc3BpbiBNUkFNLCB0aGUgRU0wMDA0TFhCLA0K
dXNpbmcgdGhlIGF0MjUgZHJpdmVyLCBhbmQgaXQgd29ya3MgZmluZS4NCg0KPiAtLS0NCj4gIERv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tdGQvamVkZWMsc3BpLW5vci55YW1sIHwg
OSArKysrKysrKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyksIDEgZGVsZXRp
b24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3MvbXRkL2plZGVjLHNwaS1ub3IueWFtbA0KPiBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy9tdGQvamVkZWMsc3BpLW5vci55YW1sDQo+IGluZGV4IDZlM2FmYjQyOTI2ZS4uMmRj
Y2I2YjA0OWVhIDEwMDY0NA0KPiAtLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3MvbXRkL2plZGVjLHNwaS1ub3IueWFtbA0KPiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvbXRkL2plZGVjLHNwaS1ub3IueWFtbA0KPiBAQCAtMjEsNyArMjEsNiBAQCBw
cm9wZXJ0aWVzOg0KPiAgICAgICAgICAgICAgICAobTI1cCg0MHw4MHwxNnwzMnw2NHwxMjgpfFwN
Cj4gICAgICAgICAgICAgICAgbjI1cSgzMmJ8MDY0fDEyOGExMXwxMjhhMTN8MjU2YXw1MTJhfDE2
NGspKSl8XA0KPiAgICAgICAgICAgICAgICBhdG1lbCxhdDI1ZGYoMzIxYXw2NDF8MDgxYSl8XA0K
PiAtICAgICAgICAgICAgICBldmVyc3BpbixtcjI1aCgxMHw0MHwxMjh8MjU2KXxcDQo+IA0KPiAo
bXhpY3l8bWFjcm9uaXgpLG14MjVsKDQwMDVhfDE2MDZlfDY0MDVkfDgwMDV8MTI4MDVkfDI1NjM1
ZSl8XA0KPiAgICAgICAgICAgICAgICAobXhpY3l8bWFjcm9uaXgpLG14MjV1KDQwMzN8NDAzNSl8
XA0KPiAgICAgICAgICAgICAgICAoc3BhbnNpb24sKT9zMjVmbCgxMjhzfDI1NnMxfDUxMnN8MDA4
a3wwNjRrfDE2NGspfFwNCj4gQEAgLTQyLDYgKzQxLDE0IEBAIHByb3BlcnRpZXM6DQo+ICAgICAg
ICAgICAgICAgIC0gc3BhbnNpb24sczI1ZnM1MTJzDQo+ICAgICAgICAgICAgLSBjb25zdDogamVk
ZWMsc3BpLW5vcg0KPiAgICAgICAgLSBjb25zdDogamVkZWMsc3BpLW5vcg0KPiArDQo+ICsgICAg
ICAjIERlcHJlY2F0ZWQgYmluZGluZ3MNCj4gKyAgICAgIC0gaXRlbXM6DQo+ICsgICAgICAgICAg
LSBwYXR0ZXJuOiAiXmV2ZXJzcGluLG1yMjVoKDEwfDQwfDEyOHwyNTYpJCINCj4gKyAgICAgICAg
ICAtIGNvbnN0OiBqZWRlYyxzcGktbm9yDQo+ICsgICAgICAgIGRlc2NyaXB0aW9uOg0KPiArICAg
ICAgICAgIERlcHJlY2F0ZWQgYmluZGluZywgdXNlDQo+IERvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy9lZXByb20vYXQyNS55YW1sLg0KPiArICAgICAgICBkZXByZWNhdGVkOiB0cnVl
DQo+ICAgICAgZGVzY3JpcHRpb246DQo+ICAgICAgICBTUEkgTk9SIGZsYXNoZXMgY29tcGF0aWJs
ZSB3aXRoIHRoZSBKRURFQyBTRkRQIHN0YW5kYXJkIG9yIHdoaWNoDQo+IG1heSBiZQ0KPiAgICAg
ICAgaWRlbnRpZmllZCB3aXRoIHRoZSBSRUFEIElEIG9wY29kZSAoMHg5RikgZG8gbm90IGRlc2Vy
dmUgYQ0KPiBzcGVjaWZpYw0KPiAtLQ0KPiAyLjM5LjINCg0KDQpSZXZpZXdlZC1ieTogRmxhdmlv
IFN1bGlnb2kgPGYuc3VsaWdvaUBhc2VtLml0Pg0KDQoNCkZsYXZpbw0KDQo=


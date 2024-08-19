Return-Path: <linux-kernel+bounces-291570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A9B2956429
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 09:12:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 170F3B228D4
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 07:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AA0215746F;
	Mon, 19 Aug 2024 07:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="GoTrSVXv"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2111.outbound.protection.outlook.com [40.107.215.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0735CDDDC;
	Mon, 19 Aug 2024 07:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724051546; cv=fail; b=ebUIKn/RDv8y+NEpS1akm+/c5O1ekECPCt+DkjRi94bhXLjNyaQGWrTqSjelgCaMKxud2GKwGPV01tjGvlXSNPfJG36agaczNbgzH9kLVVn/CAwMqkoPKF4zoVdm5jGKFJQopKA2BqBRS6TpH0dc0+LxRiF/EMYjUIFyCM1v9so=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724051546; c=relaxed/simple;
	bh=YQQcfuvIJwXIqqLNYEJES4EaD9amB0iBYvwNaVK8lEs=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hCNJr7bmo4Z7wkGcQskE32GU/Is6GUh2U00BE65MttaNoXLTgcjGhuvZXOB7PsT45XfSRWTsRlV0Dv3NuUbarwEk1U+5D2Vn5AQVi42itjKNPVdtgUKo1PVyZrWyF3299viQvTKCFKiO8TJrzALJTgYzl+NDh3uGqb874vyXfEc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=GoTrSVXv; arc=fail smtp.client-ip=40.107.215.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DzEtAcHCFMaA0WnuXJSVjWAolLwbpI1PlwJh11j0g0JPrZyvlqx69rKSasom4nx7h2NWiPbm0jLl85c1bObIiASuZR6YqoV2fsRhOoGRpFJKyxEeYH6FQZWCC5sZdoJldEn03La0K7/jJXGxKa+hI5YdrK7/OfEA4mUShxW/ckf7WyQZ+Bf89KNjnpuuZiBfvEU/y5XOTIQcvUFwiyoXkUPytn6qAuc14/1HsZRFkoZxk3NMlUsZyMxvP7q4N1es9WAceUegrNDsuPvxe9PFj1wlgnqFjPF6uY+WbUl4l0fC7L1na0BYJJ1BYvnFxuoIvOXmJ/FC5z2fQE+AnKNnKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YQQcfuvIJwXIqqLNYEJES4EaD9amB0iBYvwNaVK8lEs=;
 b=bwLNyKiIBPscfftISGLK6kLVzzhh6iBbdWKi2kY+iXFtvhDMHCb/baSPSWaWfhLUJgb+d+d57GUv0SJBb456Ue6OfgrXHqmx8WjhkXVJW8pT+3IRvoWWyglcP4QJhCpqhbrod6RE0IkA1/VzHWMrDIpW32NzVUCQQuv2/2iDf/qiNMne8J9aQ/DLhOQiya03rjwfiyp2CsG/wj6wT7nrzTbm/sG4YLT2zWbqnfoRnOiqNv2NxmKF8fbStXQXeVYqCUi/v9LITZ1JlUNAq/xmflCpHqsjcdOoKReCbAsOQh80H7SgO4dgCKGdxagzsw/kCdCf9Gr1iZBXG9f6rTUTtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YQQcfuvIJwXIqqLNYEJES4EaD9amB0iBYvwNaVK8lEs=;
 b=GoTrSVXvmD8hLG7NEwJ4Op0a1jILZh3ByM4nPbrFNj74sgnyLdpKLWNpdz+Ra2JPtHzTTOewDJnNsdQJQuBdCr/B962Pg6Tdgi3UTL6F5dMvl1oeqJjmsYN2dyPCofSnm4qGTj5yb1g97a5UdP//arOftUBi/S0GCkgteu09CA8rSmQzrZz5cUf+p1ZoqRowzXij7M0/A9aNHxgldg40tpt729rStklOt2wtx3/3cQ8nf9FRL7P7ntYdr0Md1aakXmp0mm/I5HRuFhHKKN32vrowy+q3o4EJdFIjtCbxxOAyFvbCFDKsbRAog6ZMaj8oJx/r9COEKwO0WGGp+XbU2A==
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com (2603:1096:604:2b1::11)
 by JH0PR06MB7327.apcprd06.prod.outlook.com (2603:1096:990:a5::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19; Mon, 19 Aug
 2024 07:12:18 +0000
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11]) by OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11%5]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 07:12:17 +0000
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Lee Jones <lee@kernel.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery
	<andrew@codeconstruct.com.au>, Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>
Subject: RE: [PATCH 4/4] dt-bindings: clock: Add AST2700 clock bindings
Thread-Topic: [PATCH 4/4] dt-bindings: clock: Add AST2700 clock bindings
Thread-Index: AQHa6Wjwl4xNR6r8FUS4yGT/m49yXrIdJasAgBEAqXCAAAFigIAADiyA
Date: Mon, 19 Aug 2024 07:12:17 +0000
Message-ID:
 <OS8PR06MB7541950B1E249E07FA542B90F28C2@OS8PR06MB7541.apcprd06.prod.outlook.com>
References: <20240808075937.2756733-1-ryan_chen@aspeedtech.com>
 <20240808075937.2756733-5-ryan_chen@aspeedtech.com>
 <b089c9e5-8640-47f3-a6a3-8919b610f49d@kernel.org>
 <OS8PR06MB7541B310B81108B9A801AEFEF28C2@OS8PR06MB7541.apcprd06.prod.outlook.com>
 <e0162031-f20f-4eef-9f7e-08c7dbf92b7a@kernel.org>
In-Reply-To: <e0162031-f20f-4eef-9f7e-08c7dbf92b7a@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS8PR06MB7541:EE_|JH0PR06MB7327:EE_
x-ms-office365-filtering-correlation-id: 21f9d9ce-799c-470b-2c82-08dcc01e42a3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?eGRkcS8yY1dCWjFyNzhGLzlacWhOT3lpVGxXYmZJUVc0K2Y5d0xkSnJVQWoy?=
 =?utf-8?B?YUFYWm9xdVVvZUMwalJpOGprK2xSZ0Z4STQ2N3prUERrdFdMVXFPNEJYR0lh?=
 =?utf-8?B?cWFIYjlKSEVIR3RZNHFRT0tHTVp0NE5wTUwwMVgzUFl1Q1VrblhoMHFuZzFL?=
 =?utf-8?B?eGR6aHpDc0NUNFIyWVFQTGd4ejNReUtxM2hobWlNb2pGdWtYeElwTDhCUzd3?=
 =?utf-8?B?dlZReFIzUVJyWXRrRFlQNlliT1pGRmh1ZUl5ekhCdXJHdnBDNmpXZ1ZXZ1BV?=
 =?utf-8?B?NHJxbkNkYzAwQjg0eGNVR1JROXNpT1hDbWRIeG41dC9saVR6ZFp4dENQbDBv?=
 =?utf-8?B?SnA0OFBSaWh0SUdsejB6Z1hLd3VKYWhOZ3JsZWJIa0doVDV4Y0g4Z0ZpRkd4?=
 =?utf-8?B?YWljc2xUaWErWVArMTFhaWwyNURnWG0zYmE1dGFTRTV3WXVtMmxxVWRLaTcw?=
 =?utf-8?B?djhIc2o4TS84YUxabkdsR2ZIS1ZaRmxYOU5RdU9OVlpsdnZ2c0t1dkxvS0Rj?=
 =?utf-8?B?S1JHL3NYR3ZlYjdhekJrVjZXUjU0NlR4L0lkc25iT2dhNHNBWW1YY0RlaXUx?=
 =?utf-8?B?a1g0V3Q3WGNqbXFpM1M5d1dNM2NScENrY0ZjZi83SW04L0Y5YUZQUzdaVlpz?=
 =?utf-8?B?cGNOYUpnbGZZSnd5WmRUUXJVQXhvb2lMSStkcy9jUXlBYmxuSDdGVGQ1dGFt?=
 =?utf-8?B?cGQyODRsNVZueTQrTTl5MmF3RTI1MlpqQXlvL2t0TDV4OTZ3Vjk4OGk1dVRW?=
 =?utf-8?B?d2RkaERxK2JqUmhqbXArcVpmbFhRSk5OQnd2dnpFSGIrVHZ1TDhtTEh3NEti?=
 =?utf-8?B?b1NDTnRiOFpvVHBWQTBBRFZrM2Z0eVczUGJGM1BndjBZRDJ4UlpJSE5ycDky?=
 =?utf-8?B?VEtjWUJxZXZZUXp3RHgwSXU1WTdrY0lvbnBSSHJmYVFOVWY2N2N4bUN5NHRp?=
 =?utf-8?B?RHB1cjFYbjgvL212RXlPSmlDWkhDYnViT1VhTWNWaFlzdG5OVGRjYnduZlV0?=
 =?utf-8?B?aEg5czZvbGduYlR3TWRNWjY1Rk5SVDBOU0N4V1lDQ3kzZVUwcDh4NEZsMW5R?=
 =?utf-8?B?SHQ1ZUlad1hSN2pBSWEwQzhkUmhJdTVDQnVHSUNTQWwzRWYzZzBUZlZHUWNH?=
 =?utf-8?B?ZTgyMmY0U2dsZG9XUDZQaFA5RE9MNHRaQ2txUVFmOE9oSTAvenFmSU0rYTdi?=
 =?utf-8?B?YXRFRk9TUTBRWkxXYjdTdEUyYzIrSW9VRVBUR041bzk1SWlzMVhFbVhrbW9p?=
 =?utf-8?B?VEV5ZnN6bU1NWE04N3pmOWNyeW8yRmZKT3k5dnBJNWFRbkFqcm9iK0JpWXFr?=
 =?utf-8?B?TkNnTmlNYUZMdXppVkVKVzg1L2lHQVlpMDAxcXptb3dBZmdVaEM2dEZMRzhB?=
 =?utf-8?B?N2NaNW13UXUzYy83a25lTUVyeTFoeHNKcTcrRDd1QjFzYWdYN2hjMDRQdFRZ?=
 =?utf-8?B?b3FnRHhWQUY4cEpJMlI3aEJGYlpxUzdwamw1NUFaRGwzV2NCcTdqT0NweFUy?=
 =?utf-8?B?aVhvTmF2UVNCS2YwZm81Q09zS3lKclJjRE41T3VJWVhSRUdQY0xyUUJuN1Ny?=
 =?utf-8?B?QkVzSmRhSGNDdzVDMlo0Uy9Ba3FjRjRzZldSeHlqMDJKMW91NjFSTG5teGZU?=
 =?utf-8?B?NlFZcnJXdVN2aGVKUGVnQzZEdVJhK09Kb3hmdDcwK1JwWFR3VFJzSFlKMGN1?=
 =?utf-8?B?RjBFeGFKdHN5VU5jSUdRUWlKbDg2MFN1L3ZoNEx0RHF5NnJKVkR6ZVpWQnR3?=
 =?utf-8?B?RFpSVzVUZEwwNHBOa0VGeHZMZkpja1RzNnd2eG5qMmxkb3UrRmZxQVlRMWRK?=
 =?utf-8?B?bnpndGdMSlRPRTBMRGEyRmVWUlpKbi9Bai9MZDJRR3pFbmpTbFJtb2VMMW1C?=
 =?utf-8?B?bGk0S3BFb0hUMGE1Z2kvdjEyRERqNzdBS1oycDdzSmdCWk5wdXpCR05kYXZj?=
 =?utf-8?Q?AA3t/RJYDpc=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS8PR06MB7541.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VlBtWGtNSUNWekszc2NuaXBONGRRaVBqSUlQb0NIWmNZN3dQcmdBLzJsbHg5?=
 =?utf-8?B?bTY4WisxcnNNVmxNUHBiaVlSM2lzaVY3ZWJadFNCeWROOG1wSkdpbnozU2RS?=
 =?utf-8?B?SGI4bVhmcnMyZWZGWlAzYmt1V05IVGoxNVlsa0RSeGtyYzJEWUVtajlYakpi?=
 =?utf-8?B?MUdwNmZGSDRqWnRGb2E2dzIyejEzdktrTExiVzF1eDMrbEltckxCcStUMEtQ?=
 =?utf-8?B?S2ZrbDRHTHlwdW11SGk2WUFaUE04T1RTOTNqeFh5ZC8rbHh4U2FKQUdZMUhm?=
 =?utf-8?B?eGZ4ZTVML2p2Mnp6dmFUeDZGL2JkWEhpWlY5T3R4YnJ0SXdLVDdzOUc0QUhR?=
 =?utf-8?B?K3kvNjdYUnQ5Z0lsbi9aTVdYUHN6TjI3bTBFNzRrTVJZYkNpcHlZNFNoQm1P?=
 =?utf-8?B?bWhKa29UUEZ0YlVhM01lak1iL251OHV1cEk2bWd2YS9MakxlQkNZL2Z1RDFV?=
 =?utf-8?B?ZXRuZ241L2U5Wm1BM2lIUVlBZHQyL0J0Z0MzZHlxSDVhWEpRZjRQNTFsZ2xC?=
 =?utf-8?B?d1RqYTJTdWhRNXlDV25yVVFGeDdKM0w3UzBwNkVLby9ldFkxYnZQSlg5TEJO?=
 =?utf-8?B?a0lmMkU4Rmp5RnVJbkQ2UzUyQjJFYVlRSDg2L3hKSTlaY3QrWXR0RVhmalZN?=
 =?utf-8?B?dXZOZ01sY0dpYUpjZFZlUE5kOEloY3M4Z0F4Ukt2MUs0T1JGODY0STk4S25i?=
 =?utf-8?B?ZGNiL0NhcmUwQ1VaaTFTMnJ2aS9ocmpxYlpINHlCRGx1QXJIZCttSWNOM0x2?=
 =?utf-8?B?UVhjd1dOTldBQzZOZVNaUVZNTklkOTlPRmJOM1JCWWxEbSthZ3F2QkxPVnFI?=
 =?utf-8?B?Z2d1ZUQ0ZDh1R2cyOCszN21RQXNSL0c4RHpFMk9ONjhHTzFsZ216Sk1uM0xF?=
 =?utf-8?B?MmJXOC83dHhPVFRTT3A4K2c5SUsxanA4SjBuSENtcHl6MGIxMCtsS0p0T2NT?=
 =?utf-8?B?L0FOM1drZEg2a0VRRndvOThsbUpUL1RuVjVSMnRaTWt2REF2UW9oV0VCL3JF?=
 =?utf-8?B?djZLZkQwOGJ2R3J1Z0hUV2t3L1hDZGVpcUF6K2VoOFhWWDBqL3ord0pUSk1i?=
 =?utf-8?B?NmxRb1lDQWR4RHc0QTNJZ0NzRXJRa1kyWm95bFRNejlUNms3elVhcmpoTDdt?=
 =?utf-8?B?TkpWTHdoZFd1bGg3UExOdnBBODdvaXM1ZU9BUzJGak9YMjY0S0hyZFdkVnRl?=
 =?utf-8?B?c1M5SWZqakZFSjloRE5HVFg2bFZ0RG9aYUlhRzQ4ZWoxR3UrVFA4aW92QzZQ?=
 =?utf-8?B?MTlJZEFpak1pdlVZYzFod0w2a0Q1ZVpMMXRvMDNGZTR2cFY5dTVnd3lkbm9u?=
 =?utf-8?B?YjFZajNjTkJ5ZitObmEwOXA0Z0tlVWlsK2pHK3A3K3Ivb1lpRVRiekd6MzdO?=
 =?utf-8?B?djY0SnhaVngrZW5mZ01kRDVycUZrNFJTWmVnNVpYWXRDN3gya0MyYlYyY2VG?=
 =?utf-8?B?TTdXMFlLS2NsUmt6dXNZVzFHcE1Rb2lWd2pLcXArM2Iwb0pyMXg1Ri84Rmxu?=
 =?utf-8?B?bUpwdVpoVE5tcHZ2WHlXeSt0TThCL1cyNTBkZjdmaDBmT2lLS2VnWkg2WWd1?=
 =?utf-8?B?WDk2eXFIaVFGanlEMDRMQm9RWEhQNEVpQ3dHR0tZVTMrZE5lbDdWMFB3SFlC?=
 =?utf-8?B?d2xDNXQ0Y1BLdWc1aWdyU3g0dkZGT0xqU2lMQW92YjNYbU5LdjF4VTNyM3ho?=
 =?utf-8?B?K2o1L3o3SmNwem00SDU1Z3ZKS2Ezd0d5MnF6MmhZL3FPYmlXVTNhNCt1Szc5?=
 =?utf-8?B?elF1andlL1BSdGpMckFmQkZNWFlVN1NWamxXS09PQm4wQ2lkSmYrcVhFU0h1?=
 =?utf-8?B?YXlkTTkrL21TSXcrRmlGa0t0VThxamh3UUhqZEk0ZXRZbFlyNllRVG9TMXZH?=
 =?utf-8?B?OVF6UjY4aG9yK1R2bENNOExRaFNhdnBrVDN4NUh1V3JjK3FGN1JmMHVHRHFv?=
 =?utf-8?B?Wkp5QUFyVkZEZXpCdFYyTnJ4UU9GNWJFZGNQNEt4QjdFRnNpWDBDZCtFZXJP?=
 =?utf-8?B?WjFaaENub2R2TUN2UGdmbS9HMUgwZzY5VlZGMXhtSzdmdEd6eGJNQjBrS3F5?=
 =?utf-8?B?Rm9uSEF5dDdCNnJLcmducnA0TGNOaUwzYkx0ZkpGWlhCSUc0TksvcloyTmxq?=
 =?utf-8?Q?AUG573nD9JgX0AL/GPwieESG4?=
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
X-MS-Exchange-CrossTenant-AuthSource: OS8PR06MB7541.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21f9d9ce-799c-470b-2c82-08dcc01e42a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2024 07:12:17.8920
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1yu8cErVvoGKMoenelLOFfHdXT9wIFPr8u82y4ab/aJuKPK5JHZf9R3FGy/91B9On8xa5mQHuNgCMQ6hTBRqeEWr++162yK4ILX26cHswtU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB7327

PiBTdWJqZWN0OiBSZTogW1BBVENIIDQvNF0gZHQtYmluZGluZ3M6IGNsb2NrOiBBZGQgQVNUMjcw
MCBjbG9jayBiaW5kaW5ncw0KPiANCj4gT24gMTkvMDgvMjAyNCAwNzo1NywgUnlhbiBDaGVuIHdy
b3RlOg0KPiA+PiBTdWJqZWN0OiBSZTogW1BBVENIIDQvNF0gZHQtYmluZGluZ3M6IGNsb2NrOiBB
ZGQgQVNUMjcwMCBjbG9jayBiaW5kaW5ncw0KPiA+Pg0KPiA+PiBPbiAwOC8wOC8yMDI0IDA5OjU5
LCBSeWFuIENoZW4gd3JvdGU6DQo+ID4+PiBBZGQgZHQgYmluZGluZ3MgZm9yIEFTVDI3MDAgY2xv
Y2sgY29udHJvbGxlcg0KPiA+Pj4NCj4gPj4+IFNpZ25lZC1vZmYtYnk6IFJ5YW4gQ2hlbiA8cnlh
bl9jaGVuQGFzcGVlZHRlY2guY29tPg0KPiA+Pg0KPiA+PiBOQUssIHRoYXQncyB3cm9uZyBvbiBz
byBtYW55IGxldmVscy4gVGhlcmUgYXJlIG5vIGJpbmRpbmdzIGhlcmUhDQo+ID4+DQo+ID4+IFlv
dSBpZ25vcmVkIHByZXZpb3VzIGZlZWRiYWNrIGdpdmVuIHRvIEFzc3BlZC4NCj4gPg0KPiA+IFdp
bGwgbW9kaWZ5IHN1YmplY3QgdG8gImNsazogYXNwZWVkOiBhZGQgYXN0MjcwMCBjbGsgZHJpdmVy
Ig0KPiANCj4gUmVzcG9uZCBhbmQgaW1wbGVtZW50IGZpcnN0IGZlZWRiYWNrIHdoaWNoIHdhcyBn
aXZlbiB0byBBc3BlZWQuDQo+IA0KU29ycnksIEkgY2hlY2sgeW91ciBmaXJzdCBmZWVkYmFjaywg
SSB3aWxsIHJlbW92ZSAiRHJvcCBXQVJOX09OIiwgIldlaXJkIGNvbW1lbnQiDQpodHRwczovL3Bh
dGNod29yay5rZXJuZWwub3JnL3Byb2plY3QvbGludXgtY2xrL3BhdGNoLzIwMjQwNzI2MTEwMzU1
LjIxODE1NjMtNC1rZXZpbl9jaGVuQGFzcGVlZHRlY2guY29tLw0KV2hhdCBlbHNlIEkgbWlzcyB3
aXRoIHlvdXIgcmVzcG9uc2U/DQoNCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCg0K


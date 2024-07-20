Return-Path: <linux-kernel+bounces-257957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7841F938171
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 15:19:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C688281C0A
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 13:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC1E712D1F1;
	Sat, 20 Jul 2024 13:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="JvDPHqCU"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11021100.outbound.protection.outlook.com [52.101.65.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5F0179AF;
	Sat, 20 Jul 2024 13:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721481568; cv=fail; b=tO1DrX3NBqrG8SniJs6w+mZBr7SHtQaZpVOlKdK99DayFM5v5pkZL7ozLD4us3sewyCowSvnh+KPurAREFjuVVHSGuqGzRTaVcMQhxQceJdKPZ8LvbeWE8iHb7+uKUu1mXkpaMAAx20lb4m3E22dliG5hCXguh+HHBLuOj5YwtI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721481568; c=relaxed/simple;
	bh=WlWQf2Z9dK30gcCUxfn8bXWAQKC9E7sAPvvTqeZMvxg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=i5MP/gPO3x4X78ciZnKpWOLflPly2bsQArPUNeup5CDmN92xPDDjqQnLUM0nlcIUHznTIF910CFFkfr20gwqnzzfcQXb9wqbQIVqv440USYYINgVrR4vfZchrxVayeuKqexe3uEdrxIZsjsrGPtvhPY59aRk0xIR9igOgdjZ9/c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=JvDPHqCU; arc=fail smtp.client-ip=52.101.65.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WbdYj3GyIntbqT+qCMX3K5haA2LXbmuYjw8IfLSjxFI4/+EUP/olgh9cMsd/dfo+hmAh1Tpgo1lArE3iBx+MHuStzVXfCDak9PxJCgE5MmX1ZPSjlisRl//HOlXrV8YLEvsbhxqiMKDo7lGD/hkO+Lay86K0C+Cf//Fs++rV9HQ0vuTGgxC6o5S+xfZvfCufN0D7Mce4pB3nSzGIyQL3ww+ecedllzoN7UeuiMQB7MhdXGXFl+MdGrBipz0X+4OzViKj3kQtR9SazB4Y5hRnufwGHob+OtGxv6UEVuuz4HqPZ1KZrjxdauHcQk01cdkulNOhJ5YgYmf5YsiOWtUD5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WlWQf2Z9dK30gcCUxfn8bXWAQKC9E7sAPvvTqeZMvxg=;
 b=OagHX4v7mvbAIBJMgcL+X1T22zwNqwJDYaCiD5Bats30cL2GXvBrvXiFTdkLqrkrd9D+PbMglsNH/lxI9Xi/TKi976XKAR5n9xrJKh5oI3bQNFawBOFfPzYzTLGJuCGSr8Rcl1A0EdZ6MjZyj4UPdAeThMtexXeGtoEI4R2uk74+yNxEmV8nzBO+zZxA/rkpFyZrG986xivLIPez8cn/2rnfU8OBCOoq8uxf/asOfvat8vLKH3ubAXedz9JmZ7cDYSEtcOeJ/GrJEoa23Op051/kQZwsL12vGSsKzWQm3pXpB77N5JeEje4zy5v0qYd60egXgvtRxBoXYOpTXirTsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WlWQf2Z9dK30gcCUxfn8bXWAQKC9E7sAPvvTqeZMvxg=;
 b=JvDPHqCUs29NA0RpeLW+S9PbgvrF0d9YeRdd/tkT9JNoSDxh6QTL7TFhOpGV4QEpLfxvEylsBBgnlaUYFSOrZYXMvZ9C8smenLRs6UROqCagimVZFdpxBvjbyKwHRU9zM0xWCAPH5PlDszyLjx3Sb1/BCy1aXW1TkyJGeD+m2k0=
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by GV1PR04MB10752.eurprd04.prod.outlook.com (2603:10a6:150:203::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Sat, 20 Jul
 2024 13:19:22 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529%3]) with mapi id 15.20.7762.027; Sat, 20 Jul 2024
 13:19:22 +0000
From: Josua Mayer <josua@solid-run.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@bootlin.com>, Sebastian Hesselbarth
	<sebastian.hesselbarth@gmail.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
CC: Yazan Shhady <yazan.shhady@solid-run.com>, "linux-phy@lists.infradead.org"
	<linux-phy@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: Re: [PATCH RFC v2 2/4] arm: dts: marvell: armada-38x: add description
 for usb phys
Thread-Topic: [PATCH RFC v2 2/4] arm: dts: marvell: armada-38x: add
 description for usb phys
Thread-Index: AQHa18Ib0mOp0sUHb0mRWleiPTSZX7H602kAgATL74A=
Date: Sat, 20 Jul 2024 13:19:21 +0000
Message-ID: <2a7936ef-3a50-49df-b6a9-337b38d33c57@solid-run.com>
References: <20240716-a38x-utmi-phy-v2-0-dae3a9c6ca3e@solid-run.com>
 <20240716-a38x-utmi-phy-v2-2-dae3a9c6ca3e@solid-run.com>
 <44ce546d-c043-44ad-9e2c-eaf052e5531b@kernel.org>
In-Reply-To: <44ce546d-c043-44ad-9e2c-eaf052e5531b@kernel.org>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB7586:EE_|GV1PR04MB10752:EE_
x-ms-office365-filtering-correlation-id: 6f00aecb-e762-4c82-3a2e-08dca8be919b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Z2F4cDMyNWxBZHVsT0tDNTE5dHVKWWs0K01ZZUw0a2pjZGE2eCswcEJEM3Jw?=
 =?utf-8?B?RHNtSzlOVGRLeXBMaVRSc1hiVFQrSm5ZbHg4azJ5cEM4YVltbXVDd2hOSmdw?=
 =?utf-8?B?THFiRmZsOEJXaGtZMHQzc0RtN1d5a2FDTmxUUTc3dVFYNmNidkdnQnNEcXZy?=
 =?utf-8?B?YmJxRUltQ1ljSzA3NlpyQjRlcUJuSkk2cFBDYjN6MUdMWlM5a3pid25sNzV5?=
 =?utf-8?B?eWFacVFtQWwwNnRBaFp5TkM4dlV3cGhjR0tpYVU4SHpHdE1rNm9NYnlLZVdQ?=
 =?utf-8?B?YXNNcDcxUXE3MUQ1V3dQbUo4MkRwM3JkZGgzUnA0ay91MDRvU1RCZ25FbG4y?=
 =?utf-8?B?YmV3ZXFScUxMUjBUMDd2K25pS0VyaG00Zlp0QnRLOEE5d0ZoMWJYd09tZkVs?=
 =?utf-8?B?Y3pPMnRpdDAvOTZ0T2doRUtUbllNbnZnUUpCWkl6SzBwODlQTlNVLzFMWEtp?=
 =?utf-8?B?TGVNOE8rbjZRVExvVkdhR3lEUmlFWndhWHVvKzVYQlY1eU9Vd0NBNndqVUJl?=
 =?utf-8?B?WDNkTXUxNVJIL2g0dUJYTnRWOHFvdzVuVW9TQ2EwdFI4RkRqSS8vUzJjeFpB?=
 =?utf-8?B?anVNbW9NV3VITmVQdzN0UGZIc3ZjV0dvSk8xWmFVYVFLL2sxM2hUb2JMZk5M?=
 =?utf-8?B?Rk42KzA4dWR3RDZLa3ZxSGlpZ2EzUGtOL1RyWmRFT25Md01NZURwbytNZjJL?=
 =?utf-8?B?ajRuQ2gwVVpIc05weUVLNXErSUFYRWsvOWE3ZlZlNFdTY3c3ZFRQRjZoOUlF?=
 =?utf-8?B?TGlyU3RWUXZUS3NlUHFjdGFrVWcrVWFPVGovd0t6VkVweEpHUGxIZEpndFpq?=
 =?utf-8?B?UEpMOUtaYjgxU2FsMTg1dUV5NGpwOUhvVlFTako3eW1KZU94QXNNelVZdmoz?=
 =?utf-8?B?bzB6cFljVVFPaWtGVjRnK2hTZGg0Qm90YUNIWWlYdHVZZ0pjU2RnZEw2SjV0?=
 =?utf-8?B?OTRpMURKSnd0WWhVWmwxTTBTTE1LeDZKRzY2Uzl4RkRmNTdhQ3VjYlRhcXlO?=
 =?utf-8?B?Y3huQzhmOFpKZ2dIaDdSSEdsVUl6NEFEcUE1UzNZLzBQT1JURGxkSUMzSG1a?=
 =?utf-8?B?bngvUTA4Yk1RUUJYZEdtSmVscEp3aHFGSFUySnU5OXJiMFhkNis2VGhQbTlG?=
 =?utf-8?B?OHk1NFczdjN6OHJyVTVCUEpyOU9yNjUzSGU3VXg3Y1hQZ0o0SzcxQWhZeDV5?=
 =?utf-8?B?Ly9SeGJTaDF2eUYxcXFIRnVwWk95SnVyMTBnQ29RMU1SVXBuVkN3T2ZuMkJr?=
 =?utf-8?B?bUZXOEEveGVVWU1IY0tLUVRXbFBmSTRyS1ZTNFN4RFFTQ2U2Mkx4TFVNWkM5?=
 =?utf-8?B?TzlWcGxNbGJuOUtyYWRJTVUveW9kN1N6UGVZZHNYTjF1aWFuaXpSZGVqb1Bo?=
 =?utf-8?B?Wmt4MGd4eHU4UHpFVFVKNE03SmVpRFZVenB0OTc4Ulc1dERyOGl4N09NNXhq?=
 =?utf-8?B?aHF3VUVJZnkxN2x6REhoRTFtQWN2aWR2V2ZweFF4NVpBZTVzdDVsR2xDMm9B?=
 =?utf-8?B?aUhHS2NuekZ3cTIzOWZzbVVoVWhhdGRDaE53MFQwbDZJODFSeW02MlpBN2hZ?=
 =?utf-8?B?UEhrdXNudC9VVDlLR0p0a0pMOHpPVndOVktBSlREcXdNTXJmR2RDZU1VRGV4?=
 =?utf-8?B?VnREUG4wS3hGdXVhQnJxU0JpZkxQWFpDNGpxWUNiWFJ5KzlRTW0zY0NodEVR?=
 =?utf-8?B?bnR1TS94MFlWaWo0ODVsRHdjTTZjS0NKVkNGZWN5N2N4Qk81QmFLWEZET3hp?=
 =?utf-8?B?RFBJazVwZEcwMWEyNXlTUVBCQW5Vd2hYb051a09uRGZybHJCVWhxMzd1U1FD?=
 =?utf-8?B?a0tITzlPNURZbTNMSzN0bDV0RFk4eFZ5QU5Rb21Yd21XOTdzTG9lb1QvcW1k?=
 =?utf-8?B?N0txRFZkVzdXTzdqSGQ5aUx6U29mQXhVT3pWUG9Qa0k0cmc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NGV1NiswK29XN3h5bk9PVGlFdHAxbkc1V2xja1pxcnNnS1kzSlFqNU01L3F1?=
 =?utf-8?B?ZjdxNGNFK2hJaUltMkVvb1M5VlVuMGFDUEtKYzBBc25YN1dwSkpZM0VmN2Za?=
 =?utf-8?B?N2MxZnhtWldpWjJ5UW4rNkZpQThMbHljWVJhQVVJVXZxZWd0WGNzdERBRStn?=
 =?utf-8?B?Vjc5dHVjbmpGaEZ5Y0w2RGFhTlJBTEJTZVBvQVM3WWMwNkhOSlZTcXVva01E?=
 =?utf-8?B?U0RaTThSd3AyYW1lT0V5RkNjRWs3d3Nsd3NHbGh5V0dsY2ZZbnJrTCtkN0Rp?=
 =?utf-8?B?UHN2YUcwSXB4TUxMK1NTR1lnUnZxb3g5WDdZdTNHMzRBcU5WdGh0cWZGcit0?=
 =?utf-8?B?Uzg5K1ZKaGUwbGlWSWR6Mi80SUZMTlU5Uk9pWnRxbjVBNGk5RnVxbHZJdEFF?=
 =?utf-8?B?aFRSU2syeUlRUERrYzd6ZFE2eFZoMS9wUkYyN29Ja0JBWmNNVDEzL0c3ODk1?=
 =?utf-8?B?d0M5dHdwMno1ZlNRZ3prcWY1d0JjS3g4TnZlRkVNNDBxODhXRi9zd3RFWDB1?=
 =?utf-8?B?SmRiaThPL0pha1IyRERLUXZnTFF6U01LUm9MQTVlSDhZWmFTMHZRUlQ5WEF5?=
 =?utf-8?B?VzdaUTY4Ukx2ZUFwUE53UmlIcnhzYjRpMjE0bXhwMFVmM2RzOGo0d2dZdXU3?=
 =?utf-8?B?SUkvayswTkVmaTlTYWFkeG5LN2ZYTGczaE9xckZYQkRBYnp6Q1JRTmlGN2g5?=
 =?utf-8?B?dVdQdjlwYktEYjZ6aHVONC9ZTVF5NUtNaURZU1hDYzVMTFh3ZlgzN3NIS2ww?=
 =?utf-8?B?WGJvWGNxSFFIeUtpZGg3dlhOVU5PR20xS2dBV3B0eVVrU3dhcXlpVGFhbXV0?=
 =?utf-8?B?dWJHNUJBRmpYd0dycGsyVkdKQWw3SjhRRjg1UkNUZjUrMlpaZEIxTjd0Nkll?=
 =?utf-8?B?bzJyRFBiMnNvc0ZEcStXUUt5QmxUMlhyNHJpUHNPSVljV2lvcEgrZ3h6V1Fj?=
 =?utf-8?B?MWtpdnd0ZlhiaER5QVg3N2YwZGxEZzM0Y2tpMDZac2dFRTdhTXpRUmxQcXho?=
 =?utf-8?B?Q0JXOEJPaVc4SjZRTFBCOHhGOEg3U3BmV2c3ZE4wMFErOUVCK1IzMjVsZXRy?=
 =?utf-8?B?YitxYmhZZ2JyUzRKbGNqeG5wajlxSm9RUURrOGdEYmtRYmFwNVFmQU5qR1Y3?=
 =?utf-8?B?U1d2N3l4UFJ1ZFV6U2prdEhobWRieGE0V0lxRXh2UlF1Q2VxeVZEVW1GRW91?=
 =?utf-8?B?djhsRk1yQlZmTUtFNElvTzhFMUxod1dIQjdSVi8wOU1zVEtDNXgxRkhKaEZH?=
 =?utf-8?B?Rk5aZ1dMamtFRE5zUmhjV2lvcjRkM1dabkpGUXg5cUJKWjd1MnJxTzZRVE92?=
 =?utf-8?B?YWFKbWRXdEtkQlB2WGtpNU1IM0toY0RhaEZkMlByN3BodzJ3SnZRaDR3ZkZt?=
 =?utf-8?B?U3I3Y3c2UGpWeVFxSTlXblZzeXE0NjJ4RzREZ1ptbVE3SmpVUTZFMUVueHlX?=
 =?utf-8?B?SW9FVXYzRUs5Qk5OVklxanNnbHEyTFVhcjhPRnVZTEl4U2NuU1Y0bDdBTm9v?=
 =?utf-8?B?aXkvMGYwQ1Nmb0hoZkJ1ZjRGVWJ0QlFaKzJQOXJZMW9SSldLV25LaFNyaVBr?=
 =?utf-8?B?b3MzNllndEpYY001MDVOZGl6SDJyTTlkcTVJbkN6STVZb3Uzcm15QkE4TmVo?=
 =?utf-8?B?UVVLelRoSzRpOHNJbmZqNGhXdFRqcHdQVnhkd2k3bFBxWTVxdmlSTlc1OWw1?=
 =?utf-8?B?OHkzbjJEZlRsTTZRd0JSbFVtdldybDJPY3E5ZHF0MW1mNHdsUDlxd2MyNUl0?=
 =?utf-8?B?ZE1UVEQySlh3cFhFMHhvek1wRktCRWx5aXVUUTF1amRzWDgxTlR6QVM4Zk54?=
 =?utf-8?B?ci9DOEJqQzA5ZnRHUnp2S3JsODV0RU1kWlB4OWphVUZGVzFSelU3dG41b3lQ?=
 =?utf-8?B?NlFzdHBaTzQyVWE2SmpRMXUwNW9NZzZDeUZIRnZmamtLRnJzMytTd2t0MS9T?=
 =?utf-8?B?U0psbnpoeFJyUVFLWjZweUltSUhVNXo0NXc2dUZsVUkxeTlwL212Y1A3NmxH?=
 =?utf-8?B?UU43ZEE2M2RGR1RaNjgyMTJyeTQ0WWU1aDg0VU5IRVdjSEtVa2EzVVRCWEtx?=
 =?utf-8?B?NVJjT3ZUaUZvb3pybnVLY2IwbTFtSFUwUzZwNUFnUkd3eXoxN1JKT3NQdllJ?=
 =?utf-8?Q?JYOc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <449FBC4ABB2A824DA5AC30B15B3A23F4@eurprd04.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f00aecb-e762-4c82-3a2e-08dca8be919b
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2024 13:19:21.9262
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3oPPO5Vb/RPhBynBZobJZH9l3kb1EW8J7uK2BfAEnN6rgkLemxhLCuR4gpp9DBnCZmSuF+7xy0T9nsn65ZDdlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10752

QW0gMTcuMDcuMjQgdW0gMTQ6MDQgc2NocmllYiBLcnp5c3p0b2YgS296bG93c2tpOg0KPiBPbiAx
Ni8wNy8yMDI0IDIyOjUyLCBKb3N1YSBNYXllciB3cm90ZToNCj4+IEFybWFkYSAzOHggaGFzIDN4
IFVTQi0yLjAgdXRtaSBwaHlzLiBUaGV5IGFyZSBhbG1vc3QgaWRlbnRpY2FsIHRvIHRoZSAyeA0K
Pj4gdXRtaSBwaHlzIG9uIGFybWFkYSA4ay4NCj4+DQo+PiBBZGQgZGVzY3JpcHRpb25zIGZvciBh
bGwgMyBwaHkgcG9ydHMuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogSm9zdWEgTWF5ZXIgPGpvc3Vh
QHNvbGlkLXJ1bi5jb20+DQo+PiAtLS0NCj4+ICBhcmNoL2FybS9ib290L2R0cy9tYXJ2ZWxsL2Fy
bWFkYS0zOHguZHRzaSB8IDI5ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+PiAgMSBm
aWxlIGNoYW5nZWQsIDI5IGluc2VydGlvbnMoKykNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvYXJjaC9h
cm0vYm9vdC9kdHMvbWFydmVsbC9hcm1hZGEtMzh4LmR0c2kgYi9hcmNoL2FybS9ib290L2R0cy9t
YXJ2ZWxsL2FybWFkYS0zOHguZHRzaQ0KPj4gaW5kZXggNDQ2ODYxYjZiMTdiLi43MDFhMWMwYzE5
YWQgMTAwNjQ0DQo+PiAtLS0gYS9hcmNoL2FybS9ib290L2R0cy9tYXJ2ZWxsL2FybWFkYS0zOHgu
ZHRzaQ0KPj4gKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvbWFydmVsbC9hcm1hZGEtMzh4LmR0c2kN
Cj4+IEBAIC0zOTIsNiArMzkyLDExIEBAIGNvbXBoeTU6IHBoeUA1IHsNCj4+ICAJCQkJfTsNCj4+
ICAJCQl9Ow0KPj4gIA0KPj4gKwkJCXN5c2NvbjA6IHN5c3RlbS1jb250cm9sbGVyQDE4NDAwIHsN
Cj4+ICsJCQkJY29tcGF0aWJsZSA9ICJzeXNjb24iLCAic2ltcGxlLW1mZCI7DQo+IFRoYXQncyBu
b3QgYSB2YWxpZCBwYWlyLiBUaGV5IGNhbm5vdCBiZSBhbG9uZS4NCkN1cmlvdXMhIEkgaGF2ZSBz
ZWVuIGl0IGluIGFybWFkYS1jcDExeC5kdHNpLg0KDQpIb3dldmVyIHRoaXMgaXMgbXkgbWlzdGFr
ZSwNCmVzcGVjaWFsbHkgc2luY2Ugd2l0aCB2MiB0aGUgc3lzY29uIG5vZGUgaXMgbm90IGFjdHVh
bGx5IHVzZWQuDQoNCnNpbmNlcmVseQ0KSm9zdWEgTWF5ZXINCg==


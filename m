Return-Path: <linux-kernel+bounces-168946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E94D18BC00C
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 12:28:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 991BC281B48
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 10:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9206BE4A;
	Sun,  5 May 2024 10:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="GZQv7qik"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2115.outbound.protection.outlook.com [40.107.21.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA2117556;
	Sun,  5 May 2024 10:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714904880; cv=fail; b=Kxh/p1KUaRya3K/ZRI1jX/MxJgtVIi25NBqENa0YtAcpfJmG3oH/2QkEq9og1mX70eLwSOhsPwCmfdzOG1N4JG7hdPJqSCeHeSf7bjzbF2OBaWjp6NWtXJQmq2b3hJzThQZD1RNkL2vCVYFvAWh5AuntpGFx2ZrkjHG2wljOFSo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714904880; c=relaxed/simple;
	bh=GK70lPsXrhPnsVJGjPNCaUG6lpAly6wP6v4OeURqb6M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Wh+O36xSXcRguTw1yf8Ybv370pqsteg1YSWQBGbzPCT35htPREcGr9JWWv9SiRMgqwchVlVDNK7ZcH0lLBLZ2QWZss0UqCNGWHvgNLamBa2hIRmDAI/iYcfiBF9Slz89bw0alJZce25T+c0aARJqubNTHmT0b7KKJZL0I1PaiW0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=GZQv7qik; arc=fail smtp.client-ip=40.107.21.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bHrqNf22svrxcD8E0f6RvNtmvGM9ZPivKa9YpFzujaZavolAMuAUkISX9T8rhywvRxiwjaBw3IrmBgI1ddFXTnDMbeFq46S70WlxpBy8Nfaan+QiR2IHLdCVUNCIdVvVrJMx+ChlSo6FGjQzwta5l/7OGnfCzgAM7TlTgd+kaKYlqZ6iDQTeqCMQPEoBFwhBfp/FmUhuMUOH6/oH8Fhve1TUipqPjYJVnT+753OJUv5csVDG/WaTpVwdm8FCDIXIil/j7RwAuV04BEUabPfWcUizwMXEZr2uJ6w9l9yKf5kGOz9vzgpMJ+bUps3RIbEtgRM2ZiVe8rDD0FpvfWaYnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GK70lPsXrhPnsVJGjPNCaUG6lpAly6wP6v4OeURqb6M=;
 b=VV9imVkepeVQP3/sGG6PT7iZ69wUgn5GafIAJoYMaVZLlD9fSC0sbCASJ2LPjieE/qSfMP1kX9DNX/hQ5GPGX0qSPzjfLsgJ7z0FfNQeYUTk6zGrf7nmzdtMCUIjRPW+1V1nvEjZ9NxJOFwEwkLU2v3GEvjRqGr5e9w0mILdQhWVWoUHVc+665+k5AG1528kYPBGwL8NwE0xLMRTBphYJDD8EmNYhPG6WsQNjYbCT06PAX/JJwXXAVOLkPLExBFF1Y6J6JiNxbwPTLUSHB9U9M/V4PrWYpfKK5xuz4ltPiBsERgAsb7b4juKYEDDs2zFaUEgMMPDWblYJOu5zMeu+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GK70lPsXrhPnsVJGjPNCaUG6lpAly6wP6v4OeURqb6M=;
 b=GZQv7qikQ6djBedZLBnn3YzTOkAUYOQVH6n3MlIfm7MXcMxKdgoEgm0nlSfKIUKIAeBJ6L59MO0aMqn++3FfJ17SvhX+/nagQpBRDBgzzQ7EwLVbBzKU2ECXojCED1ke3KwyIh7/1h27tKqE2KiNlgthNMiPOMDdEe2YMBhAxp0=
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by PA4PR04MB7663.eurprd04.prod.outlook.com (2603:10a6:102:e9::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.28; Sun, 5 May
 2024 10:27:55 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529%7]) with mapi id 15.20.7544.036; Sun, 5 May 2024
 10:27:55 +0000
From: Josua Mayer <josua@solid-run.com>
To: Rob Herring <robh@kernel.org>
CC: Andrew Lunn <andrew@lunn.ch>, Gregory Clement
	<gregory.clement@bootlin.com>, Sebastian Hesselbarth
	<sebastian.hesselbarth@gmail.com>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	Yazan Shhady <yazan.shhady@solid-run.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 4/4] arm64: dts: add description for solidrun cn9131
 solidwan board
Thread-Topic: [PATCH v4 4/4] arm64: dts: add description for solidrun cn9131
 solidwan board
Thread-Index: AQHanIzFj3t0e7qcckiINn2lwLvOULGENTeAgAFMLgCAAvNJgA==
Date: Sun, 5 May 2024 10:27:55 +0000
Message-ID: <e9f29c03-e5f2-4ed9-a768-cdbf195fb8ae@solid-run.com>
References: <20240502-cn9130-som-v4-0-0a2e2f1c70d8@solid-run.com>
 <20240502-cn9130-som-v4-4-0a2e2f1c70d8@solid-run.com>
 <d72c7637-e59f-4104-93e9-6faab2da0836@solid-run.com>
 <20240503132438.GA460984-robh@kernel.org>
In-Reply-To: <20240503132438.GA460984-robh@kernel.org>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB7586:EE_|PA4PR04MB7663:EE_
x-ms-office365-filtering-correlation-id: f3066dd0-79a5-4b21-862e-08dc6cee06d7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?L0I0NjUrSjN6d2RkcGErYklHQjRlaUhESGZmUGJ5Tml4aWVzdE12WTVpdmxi?=
 =?utf-8?B?alhUZkdkWTliZW5HV20wenF0bXFQRkhpKytpbmZTU0hvSDdOVWNXRlRrbzhF?=
 =?utf-8?B?Z29rcWsxNUhTWFdJMk1qM0dTZnBseEFOZ0lxTUl1S1hmeEs2aXRBYmI3K0pk?=
 =?utf-8?B?cUFNeldNU2N3Z2U3cUVwY3ZpQTh3cnI1Y1FFampPTVVCa0RxQ1FjckhYb05n?=
 =?utf-8?B?TzZZZ013TXBBanlnU2R6WmRiajVaOVM3M3ZRVFJmcWt2YUl1RElHMlUxVWdW?=
 =?utf-8?B?eDNsQlFtS0VWMXdueEJ1VzJyTEhsRGNreUZ1UkVRbUt0Tk9JanM5dHhQcWpD?=
 =?utf-8?B?MlB4dW1RYSs3bzV0ZU1GNm1KVkp5ZlV2dzNEYWxURnRKMm11RXBhY3BiYk5z?=
 =?utf-8?B?RCtNMURJTGZobDkvMGZPM1FFenVJYUdiTU9xNzQwdWw1bTRhUkFNQnU0b0Nt?=
 =?utf-8?B?WkRmYS90QTJtREZlWDNHY1NoSnFIOExGaVQ2T1hER1VxVjYzT1l6SnF3TUts?=
 =?utf-8?B?dnpKZDF4Vm9aOGNFbUhOdlBUblRPd00rRFpxQUJpTVpZZU5JY082cUMrOFp5?=
 =?utf-8?B?YkJuOHdqdHJncjE5cHRtMy95SHlnUndPVDRIRGJDN2pWSnh0VEt5c2FXVENB?=
 =?utf-8?B?clpLeGVPZnZLdml6VXgwVTZSeHpYcE5kU0ZFUWdabGFpTUVGUGU3RmYyNTIx?=
 =?utf-8?B?dHpwck9VL09vMFQwYmhBYmdJZWZkRWx2cGhKSVBSVnVuTENCSHlpR2k2NzhJ?=
 =?utf-8?B?T0FnUjRsVStsbU1kNy80NVVxaHdqTHUzYmExVTl4alFDS0pNRkhrTitiRTNM?=
 =?utf-8?B?ZHN6NDFCL3JyZ0pHQTF6TFBSN01nWnhJUmVneFRKZHZ0NktKQjlKdGM4Uks0?=
 =?utf-8?B?bGFLUE55dU0rV09MMGxFdkhONVhjdUpYbVFaWk1qMlFmWW5SVnBXc29yQ0lW?=
 =?utf-8?B?OXd0SFp5RzR3MDhqbkV6dmw5c2lYcllkT3hjK0JhOVRnT21jWnlIY1ZtNW13?=
 =?utf-8?B?QUt4a3hiZnNkZG1hL0hQYWgrTSt2ZXI1dStRNW5UKytRWEFDZDc0RmhEejdy?=
 =?utf-8?B?NFZLanRldWVuNFA5VEtWYjhjOGtlL21OYjdVYXhDOUhiMy9uUklaTENSZWdJ?=
 =?utf-8?B?S1dXMVdNT1dZY0xHTDNCaUZiZ0RXYXEwU1Q4RkdnMjRBRW9nK3BKUmVJSkZI?=
 =?utf-8?B?aVdKUE16eEJWRW1RZ3Bvcy9adzJTeGl6VGJkWGFUNEw5eEtyV0tUc3VkZmVS?=
 =?utf-8?B?bTdnbFk2anhoT2RLRGNOdzAwWTk3L25VN0ZreWZqc3NRUEIrdWZzT1MwM253?=
 =?utf-8?B?cW9SQnR6RUt6R3U3MlIyQUd0NTFFT2doRE9GK3UwdWNGMW0xRUJ6Q3EybmRQ?=
 =?utf-8?B?UjZGT2hCNVg4bldISW9kNGRSSHJqeldET0FHRUVLOFBKbzE4MGZvV2VoeWp3?=
 =?utf-8?B?cEZ0cEFjY0pNdXc1aFE0MTNlc0l4TThEWlBIYWJORWpMWC9xRTdxYjVXeFN0?=
 =?utf-8?B?OXdMalVxb3I4UmVNUHlYYVd4ZkF6ODBmY3dWU080TmdwdG8rSGRodHA4UkJ2?=
 =?utf-8?B?a0tGdTJuWXNrWEk1OUdCVDJybk1UNlFJNW9GbC91Uzdxb2VzZWkyRitLRW5q?=
 =?utf-8?B?dnJ6Mm80TXUvOVdqMUFvZ3NUem1VV1AvenVnYVp4NW1wRlJUZ1d6aGxhYytJ?=
 =?utf-8?B?dWNUWFg0ZTYxL1kwcUFldWxKNjB2UTZNZEdCcW5keWZiUjZ0MHVlRXhyZXNq?=
 =?utf-8?B?Mm43NTNUL3NVeGRObVZ4ampEYVR2Zk1xOUZReER6ZVE5T2tRajlRR3NNVkdO?=
 =?utf-8?B?UUdyYmFnZWg0RS9XRDJRQT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?anAvS0pxLy9ZUnBCdjJLTG4wUWUwc09rQ1N6UmRBb2RRbm96UXhzdTM0Znpl?=
 =?utf-8?B?cEIybnhYaE5IcmJrSjg4WjZHK3VlS0pqYy8zRUFhcjdmRllHNk1QWXhDOElT?=
 =?utf-8?B?WHNISkhwdm5NMkJUUThPcXdPMzRsWmZGa291VDBxTXRJc05WajVzZkV5bVBU?=
 =?utf-8?B?RGIrem9XUFF0M3NZWjREbkpLRlRmTGVPYitxZzc1bTNRQS9kTk5HeDFlOEky?=
 =?utf-8?B?Vm82VlJOMGRzMGlkZUc0bFV4Q0wzVXhvekxZenFDZjFORW1VMDFON3hvbDhs?=
 =?utf-8?B?M2tteVpXdTdNNzlsTUtUS1NJbExEYUlXUmVZdDl4Qk85cUhvUDhCK0NlNDJj?=
 =?utf-8?B?emF5Z252bEFKcFVLaEFINldiR0ZENGg0TXVJaDhYQ2IxTlZnSnAwNWlnQWFH?=
 =?utf-8?B?bW03amtuOXdXN0xIdDUxVkhRempyVURLVUUrQkJlOS9nRkZBZ1ZzQzFsWXlw?=
 =?utf-8?B?YXhXZTNxdW1wRlRYdmNhRFV0ZWpHSGd2Z3l6YitmYkl0T1NWOXhvTUltTndR?=
 =?utf-8?B?K0VZS3Jwanl6bDJ6Z1pFQko1TFVRSThiMnBLY01VZ1NsY1FDV3NianNhMkRI?=
 =?utf-8?B?YWhyZmJVaXN5SmNCYnFBUWlWOGJGdGNPQ0IwQis5VmhZSjVzRDBPNlFCYnl0?=
 =?utf-8?B?NThGSnVNRkNQWktwV0NEN0d4Q3pId0tXV0hNdFRpOXoxRnJ0TTFhdHNQNU91?=
 =?utf-8?B?VndkUXVCUUNVSC9HZk9tMHFpbjNodTdzNnhuWkZldWE1MDZxUzdycXIxMEk4?=
 =?utf-8?B?V3JwMEJpZGl5SXZtVW5BQ0dkYStiWSs3MmxXTzN4a1BOYnVDOWZkd1I3QWwz?=
 =?utf-8?B?TFVaTWM2Vk81ZWdDc2k0R2Ercm5qcVVHRFR1U1hmS2hUcWJLWWw2dlF3bUJL?=
 =?utf-8?B?TjVzNmF1Z1BScVBEellvOUhrWXZ0L3AyMkM2UU9TQlhSY25ZRjZmRHJwekRF?=
 =?utf-8?B?aEszakJWSGxOaldib0ZQenBSY3VvR3JkcE13QXVuSm5SdWdFYnZMK1RBS2Fo?=
 =?utf-8?B?SWFKRjVGL1J5NEZHcnVsOVV5Z2pWQ0RuT1lneVJnSU9adHMySTBhOUoxSzZr?=
 =?utf-8?B?L05mT0Z2ZDFHTmNTOHdVaXhqZGZ4L3laa0JTcVlYcms2a1QrS0xvV0VGNG9Y?=
 =?utf-8?B?YmpGdzhTck1DblY1eGsra0VMeGFsb3A1bHpRa1RjL0ZBOGU0dkM4NjRBeFhZ?=
 =?utf-8?B?Nml4bHJkSFdKQkI2bkUrRDNPc3Y3Njlrbko2YzN4MklhZ2h4WGVaUnRFK2pZ?=
 =?utf-8?B?TXBhdENBME51VzZlVlYwTWNpNVdpb21QZ0s1MHVUMTRpU1c5NmNDZmdWZGRH?=
 =?utf-8?B?MGVtelpRUm04NVhCTVVtWXlmZmZHUTl3TjlTcFo5bUQzMlh5VjA0MVIwYU9D?=
 =?utf-8?B?Z0hOVFhPUGxwNlU0YmlTQUxJTDRnUFJrZzRzUDl1enVkcEViU0srUDFmdGZD?=
 =?utf-8?B?Z2EwQjR4R21CZC9aUGFZVy9YYnl6UmZOdzV6VHpTelV6QVZLMnU0UVVZeUZU?=
 =?utf-8?B?b0RKdzJzMENGWEhoWHZhSUZJd2gvQlMwNUs5YkpGcS9yNlFDYjFVaUdBSHhY?=
 =?utf-8?B?bFQwY1NtTXdOOWhzMXFIR1p0TDNHSGNFL1hya0o0cDV4Z1BtRTBQREx2Nnk1?=
 =?utf-8?B?bjdxQjcrdGtiYzR4QWZMREhGQUh6U0tRalNMb1crSlU2U2hRcE5xTFZ1M0Jj?=
 =?utf-8?B?enhHb2FkZ1RyYnNiNWtpa21aMno5TUR0WmdCeit0Sm5YTEFDSUZlVm5PWTdC?=
 =?utf-8?B?bi9kZVUvL3h4T0lLeDJSUE9teWxock44c0JYdnZOTk5MajdJUVVIcHRHSC9C?=
 =?utf-8?B?RFRNV0FPRWgxSEsxc2MzNUdXL0IyVnhiWHM3TnRYS2VtQVJkamFpc2tvVTFj?=
 =?utf-8?B?TGUvS01vUnFvN2FwaWo3WnVuZ1ZjbExhVnYwNEZyd3VLeGV6YTlRVklzSVBw?=
 =?utf-8?B?Tm92VVhxcmFVWGZiUWZoWno5SkFkZWd5amJnd1hZKzViVHhLQ0VtemdrSjdy?=
 =?utf-8?B?NmpXTldKZ0lCaFp4QXY5YjlSS3FVN1JOOFBLb25qbGdHMTYyTG1UZVJVanJK?=
 =?utf-8?B?N0lVTENJMmdZTnJaMm44cmZ4U1JKRGVwK0dKZHIxaHk3djBLMmVSNHM4ZnZI?=
 =?utf-8?Q?GIKQkHsUtFbJdxA+X3qxkFCA4?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <042CF7AA8DBD7E47910D5F856C9106DB@eurprd04.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f3066dd0-79a5-4b21-862e-08dc6cee06d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2024 10:27:55.2233
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tP7NYMVAbI/lQijIlbJ7ZQH5chC2BVUSL6fUj2/mZ+YnNqyb+86Ez5w1Yy8f9P9ZaB+ff8CLqCCVQYtaX9VgLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7663

QW0gMDMuMDUuMjQgdW0gMTU6MjQgc2NocmllYiBSb2IgSGVycmluZzoNCj4gT24gVGh1LCBNYXkg
MDIsIDIwMjQgYXQgMDU6MzU6NDRQTSArMDAwMCwgSm9zdWEgTWF5ZXIgd3JvdGU6DQo+PiBBbSAw
Mi4wNS4yNCB1bSAxNDozMiBzY2hyaWViIEpvc3VhIE1heWVyOg0KPj4+IEFkZCBkZXNjcmlwdGlv
biBmb3IgdGhlIFNvbGlkUnVuIENOOTEzMSBTb2xpZFdBTiwgYmFzZWQgb24gQ045MTMwIFNvTQ0K
Pj4+IHdpdGggYW4gZXh0cmEgY29tbXVuaWNhdGlvbiAgcHJvY2Vzc29yIG9uIHRoZSBjYXJyaWVy
IGJvYXJkLg0KPj4+DQo+Pj4gVGhpcyBib2FyZCBkaWZmZXJlbnRpYXRlcyBpdHNlbGYgZnJvbSBD
TjkxMzAgQ2xlYXJmb2cgYnkgcHJvdmlkaW5nDQo+Pj4gYWRkaXRpb25hbCBTb0MgbmF0aXZlIG5l
dHdvcmsgaW50ZXJmYWNlcyBhbmQgcGNpIGJ1c2VzOg0KPj4+IDJ4IDEwR2JwcyBTRlArDQo+Pj4g
NHggMUdicHMgUko0NQ0KPj4+IDF4IG1pbmlQQ0ktRQ0KPj4+IDF4IG0uMiBiLWtleSB3aXRoIHNh
dGEsIHVzYi0yLjAgYW5kIHVzYi0zLjANCj4+PiAxeCBtLjIgbS1rZXkgd2l0aCBwY2llIGFuZCB1
c2ItMi4wDQo+Pj4gMXggbS4yIGIta2V5IHdpdGggcGNpZSwgdXNiLTIuMCwgdXNiLTMuMCBhbmQg
Mnggc2ltIHNsb3RzDQo+Pj4gMXggbXBjaWUgd2l0aCBwY2llIG9ubHkNCj4+PiAyeCB0eXBlLWEg
dXNiLTIuMC8zLjANCj4+Pg0KPj4+IFNpZ25lZC1vZmYtYnk6IEpvc3VhIE1heWVyIDxqb3N1YUBz
b2xpZC1ydW4uY29tPg0KPj4+IC0tLQ0KPj4+ICBhcmNoL2FybTY0L2Jvb3QvZHRzL21hcnZlbGwv
TWFrZWZpbGUgICAgICAgICAgICAgICB8ICAgMSArDQo+Pj4gIGFyY2gvYXJtNjQvYm9vdC9kdHMv
bWFydmVsbC9jbjkxMzEtY2Ytc29saWR3YW4uZHRzIHwgNjQzICsrKysrKysrKysrKysrKysrKysr
Kw0KPj4+ICAyIGZpbGVzIGNoYW5nZWQsIDY0NCBpbnNlcnRpb25zKCspDQo+Pj4NCj4+IGN1dA0K
Pj4+ICsJLyogVHlwZS1BIHBvcnQgb24gSjUzICovDQo+Pj4gKwlyZWdfdXNiX2FfdmJ1czA6IHJl
Z3VsYXRvci11c2ItYS12YnVzMCB7DQo+Pj4gKwkJY29tcGF0aWJsZSA9ICJyZWd1bGF0b3ItZml4
ZWQiOw0KPj4+ICsJCXBpbmN0cmwtMCA9IDwmY3AwX3JlZ191c2JfYV92YnVzMF9waW5zPjsNCj4+
PiArCQlwaW5jdHJsLW5hbWVzID0gImRlZmF1bHQiOw0KPj4+ICsJCXJlZ3VsYXRvci1uYW1lID0g
InZidXMwIjsNCj4+PiArCQlyZWd1bGF0b3ItbWluLW1pY3Jvdm9sdCA9IDw1MDAwMDAwPjsNCj4+
PiArCQlyZWd1bGF0b3ItbWF4LW1pY3Jvdm9sdCA9IDw1MDAwMDAwPjsNCj4+PiArCQlyZWd1bGF0
b3Itb2MtcHJvdGVjdGlvbi1taWNyb2FtcCA9IDwxMDAwMDAwPjsNCj4+IElzIGl0IGNvcnJlY3Qg
dG8gc3BlY2lmeSBvdmVyLWN1cnJlbnQgcHJvdGVjdGlvbiBmb3IgYSANCj4+IHJlZ3VsYXRvci1m
aXhlZD8gSXQgY2F1c2VzIGtlcm5lbCBtZXNzYWdlczoNCj4+DQo+PiBbIDcuOTg4MzM3XSB2YnVz
MDogSUMgZG9lcyBub3Qgc3VwcG9ydCByZXF1ZXN0ZWQgb3Zlci1jdXJyZW50IGxpbWl0cyANCj4+
IFsgNy45OTQ3NTZdIHZidXMwOiBJQyBkb2VzIG5vdCBzdXBwb3J0IHJlcXVlc3RlZCBvdmVyIHZv
bHRhZ2UgbGltaXRzIA0KPj4gWyA3Ljk5ODc5Nl0gdmJ1czE6IElDIGRvZXMgbm90IHN1cHBvcnQg
cmVxdWVzdGVkIG92ZXItY3VycmVudCBsaW1pdHMNCj4+IC4uLg0KPiBTZWVtcyBsaWtlIHlvdSBo
YXZlIHlvdXIgYW5zd2VyLi4uDQpPa2F5LCBJIHdpbGwgcmVtb3ZlIHRob3NlIGZvciB2NS4NCj4N
Cj4+IFRoZSByZWFzb24gSSBwdXQgdGhlIHByb3BlcnR5IHdhcyB0aGF0IHRoZSAxQSBsaW1pdCBp
cyBhIHByb3BlcnR5IG9mIA0KPj4gdGhlIHJlZ3VsYXRvciBjb21wb25lbnQgKE5DUDM4MC0xLjBB
KS4gTWF5YmUgdGhhdCBpcyB0aGUgd3JvbmcgcHJvcGVydHk/DQo+Pg0KPj4gSXQgYWxzbyBnZW5l
cmF0ZXMgYW4gaW50ZXJydXB0IGZvciB3aGljaCBJIGZvdW5kIG5vIHN1aXRhYmxlIGRlc2NyaXB0
aW9uLg0KPiBUaGVuIHlvdSBzaG91bGQgZGVzY3JpYmUgdGhlIGFjdHVhbCBkZXZpY2UgYmVjYXVz
ZSBpdCBpcyBub3QganVzdCBhIA0KPiByZWd1bGF0b3ItZml4ZWQuIEkgc3VwcG9zZSB3ZSBjb3Vs
ZCBjb25zaWRlciBhZGRpbmcgYW4gaW50ZXJydXB0IHRvIA0KPiByZWd1bGF0b3ItZml4ZWQsIGJ1
dCB0aGVuIGl0cyBmdW5jdGlvbiBjYW4gb25seSBiZSBmb3IgKHByZXN1bWFibHkpIA0KPiBvdmVy
LWN1cnJlbnQuIEV2ZW4gZGV0YWlscyBvbiBob3cgdG8gaGFuZGxlIGl0IGNvdWxkIHZhcnkgYXMg
d2VsbC4NCg0KQmV5b25kIHNpZ25hbGluZyB0byB1c2Vyc3BhY2UgSSBzZWUgbm8gYWN0aW9ucyB0
aGF0IGNhbiBiZSB0YWtlbi4NCg0KVGhlIHBhcnQgb3BlcmF0ZXMgYXV0b25vbW91c2x5LCBpbmNs
dWRpbmcgdHVybmluZyBvZmYgdGhlIG91dHB1dA0KdGVtcG9yYXJpbHksIGFuZCBtZXJlbHkgc2ln
bmFscyBhbnkgZXJyb3JzIChlLmcuIG92ZXItY3VycmVudCwNCm92ZXItaGVhdGluZykgb24gdGhl
IGludGVycnVwdCBsaW5lLg0KDQpJIHdvdWxkIGFjdHVhbGx5IHByZWZlciB0byBzdGljayB3aXRo
IGZpeGVkLXJlZ3VsYXRvci4NClRoZSBpbnRlcnJ1cHQgY291bGQgYmUgdmVyeSBicm9hZCwgZm9y
IGFueSByZWd1bGF0b3IgZmF1bHQuDQpCdXQgSSBjb3VsZCBhbHNvIGp1c3Qgb21pdCBpdC4NCg0K


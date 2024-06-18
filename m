Return-Path: <linux-kernel+bounces-220037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC8FD90DBC3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 20:40:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DBFA1F23348
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 18:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDDB416A924;
	Tue, 18 Jun 2024 18:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs-soprasteria.com header.i=@cs-soprasteria.com header.b="g0ABV3Hf"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2064.outbound.protection.outlook.com [40.107.22.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E2C168491;
	Tue, 18 Jun 2024 18:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718735910; cv=fail; b=IYk0BXgqFTUOgTrs/qU8ckvARiTNEwmzGFZxeiGZGy8Txy7LzQ0x5CTF2sjpdH7S9DTcUL5/JEb/Jo9pN/9iLyd5dhltBZJDfNIfFZ/WlB9ErPHALUFPe4cBkPtpHQ11jJBo9BUf51MgwNTDAf9KsS5oYsXnxuvFMO6uP3JGKbU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718735910; c=relaxed/simple;
	bh=kR1pY4bPhLp3Eleq4e17d0dxMdZ0+XXGT8PIzxo5HkI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XLbbK9SsBtf8vO32LO1v5nZNHZNIqCId6XDiD5vwt5MvVFx22kRhkRoKwVJzlYjYuh0g3wTW+orMXH/xs6mcUYhMYKynvDSldHCrJDN7rQhj/Q04K9/jRU8/ht4gk20WmmvFfz9dvrTBabEMNKklYFPngKB0ZB/qHDpvT3Cu+pw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs-soprasteria.com; spf=pass smtp.mailfrom=cs-soprasteria.com; dkim=pass (2048-bit key) header.d=cs-soprasteria.com header.i=@cs-soprasteria.com header.b=g0ABV3Hf; arc=fail smtp.client-ip=40.107.22.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs-soprasteria.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs-soprasteria.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c3LNrc8DyFdY2OfxmVlGWLghucH5rZ0ICGAI+0FBdKQ6V2UyzJ9EISkZYWLsdpA4H971zAsuPpslY/JtvOnH7RptHURWagddpg3QAvZf1iPyy7sMdOW8btDOnLmocblUun5ETC6r+zYdTDT4J8OFqOBtotIF3LR6II8sPhsLHjbrkf8cmeG/n+kmqS3r9GoDWnBEgpDRFQp1BJ5BKAsAVxqgQRghM+TgiTP4NHSbgLfu6h8hKJzPr4qkAqJk8Ng6JjXYZotW622VZ4rI49sdHGvfiXPHi8yT2VXwHpN5w3heGE5PEfxAjU5ZIwGiAGitMdFgq4Mmlm0AwRwFNJuVwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kR1pY4bPhLp3Eleq4e17d0dxMdZ0+XXGT8PIzxo5HkI=;
 b=akOGUhD/nLM59KX2PXAJKR7GNFoofWi4975JxSlgvut73L322n+pI7hXZ6zVr0R0TMAQvL2+IAS7Djz1eQWKcgZZizl1XTMjUPshPuCJZNI7TS/qKclEXQmxe87RF0UfrpjfwoynWY1lGcOem8XPEQQ0dQK2aQd/JheKMVIlM6kFtelSqBxLlYw0dJCTL6xZ+0VgdlQxk8Xb36JZ5CjzeVruzgon5t4W93OIpYO2Vx+h5Q19gO4NcnT6Bt6OxEcw/c0LH+LuS7Gw7cPAPGRgPJNh/k2Okp1qbU+OWWbtpALuwxUetdIxJrQfnmdH3j00LIKxbsx5NwqfZEt8udAjlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cs-soprasteria.com; dmarc=pass action=none
 header.from=cs-soprasteria.com; dkim=pass header.d=cs-soprasteria.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cs-soprasteria.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kR1pY4bPhLp3Eleq4e17d0dxMdZ0+XXGT8PIzxo5HkI=;
 b=g0ABV3HfNaVn7B066Y3l/KuSwicT+t1xODHn/ydSXiJcT42EcZyyuITH0in748s3XtLTQhjZEayuOpF8L3q76JNprcKkUT0PhtubkvNmgV3Be0fwbuPb2z2GIYQgrMHTU05LtScK9zll1UDaqDVnD9gwZyRxwTAiyELJ7wnuf2sFN55YdxS0M3aad+3VzsTsS4LN0cBl0xa9NIUlheXLbzv4uu87xl605PmTGT2RRXkBmKfrOYRGxhMKMjZVNX/+IlS1BBicjoRDMOeTO+NyY0BU58cqXCB5GKR3f+uX5OpNDRY5KIgGCBWtZrA1FV9nE/F1CIRnRZBKelsp9SBsoQ==
Received: from AM0PR07MB4962.eurprd07.prod.outlook.com (2603:10a6:208:f3::19)
 by AS8PR07MB8118.eurprd07.prod.outlook.com (2603:10a6:20b:371::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.16; Tue, 18 Jun
 2024 18:38:24 +0000
Received: from AM0PR07MB4962.eurprd07.prod.outlook.com
 ([fe80::6724:2919:9cbb:2bb2]) by AM0PR07MB4962.eurprd07.prod.outlook.com
 ([fe80::6724:2919:9cbb:2bb2%4]) with mapi id 15.20.7698.017; Tue, 18 Jun 2024
 18:38:24 +0000
From: LEROY Christophe <christophe.leroy2@cs-soprasteria.com>
To: Maxwell Bland <mbland@motorola.com>, "linux-mm@kvack.org"
	<linux-mm@kvack.org>
CC: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Andrew Morton <akpm@linux-foundation.org>,
	Ard Biesheuvel <ardb@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 1/5] mm: add ARCH_SUPPORTS_NON_LEAF_PTDUMP
Thread-Topic: [PATCH v4 1/5] mm: add ARCH_SUPPORTS_NON_LEAF_PTDUMP
Thread-Index: AQHawY1yjMHcSLIVrke3l17Tw6hdZbHN2kAA
Date: Tue, 18 Jun 2024 18:38:24 +0000
Message-ID: <194624e9-125e-40aa-b8dc-08895489150e@cs-soprasteria.com>
References: <aw675dhrbplkitj3szjut2vyidsxokogkjj3vi76wl2x4wybtg@5rhk5ca5zpmv>
 <fgvecau2k64sfzvxbs2yxrhzimseogdt2qk4izboywnrtco4od@ezdoxozrt2yj>
In-Reply-To: <fgvecau2k64sfzvxbs2yxrhzimseogdt2qk4izboywnrtco4od@ezdoxozrt2yj>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cs-soprasteria.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR07MB4962:EE_|AS8PR07MB8118:EE_
x-ms-office365-filtering-correlation-id: f0ff9638-57d3-4b65-4f0d-08dc8fc5d63f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230037|366013|376011|7416011|1800799021|38070700015;
x-microsoft-antispam-message-info:
 =?utf-8?B?RGg0ZlhYb3hTSDFXcnFCVnpPdDA5SEJCMEs0RjVUblp2K2VqTUFSTy9nSnJ0?=
 =?utf-8?B?bzg0WmdBZ2dhUEdPM0loT2tTNXJWZXl5RURtVXhXU3czcy9vdzdVMFRvekMy?=
 =?utf-8?B?ZnpOWE0xb1A0cG9GMjBMeFpyZ0NvZGxtdzdjMEpsMkFraTREeExabXR3YTA0?=
 =?utf-8?B?WkVZZWxUTjY2SlVuMzBpcEtGRWQ2VDQvNFVCa0Izb3Z2OXV2dGhNWlR6R1pN?=
 =?utf-8?B?K2dyVUh3dDhVcFhEbmFkMGNMOEtxWG5QVlZHU3pDUjh4dWtHdTRiR1lJMUdP?=
 =?utf-8?B?dzNuazA2dm5HSENDZ2xNWHVKaXRwVStuRUR3ZnIzV2x0R1BjV1JMN084YWVo?=
 =?utf-8?B?cDhCUVlvd3plZFgveFBpMlEwYm14d1liOEJqUkIzTVhLdlI4Q2dNMnEyVWQr?=
 =?utf-8?B?ZnRmL3pmaDJuSC9pdXRKbDN0YSs0RGM1TnltMlhZZ291VzZhQ2oxbnRpRHdu?=
 =?utf-8?B?Y04rTkpFN1k1N01oUXVPQnVsb3BsSEgvVmlvMkdpQWlWWFVoUkJoR1E0QUZF?=
 =?utf-8?B?YmkrYktDNUFEelRsME1xTnlqMFc0bmQrYVZNSmJWNDlMYkV3VnJDMVBtYTl4?=
 =?utf-8?B?MkxldFdpT3VaaDBoekFqVHNXOTd5V1k3N1dibnZkdklJckc5UzJpZUhjYWps?=
 =?utf-8?B?VVBLVGI0aXkrenpPTmVTWjc2WlpTdjNTUzhEcHkrM3ZZMXBQeTg2WnhpQXd6?=
 =?utf-8?B?b0dmOU5raVVEeXpZU29rRHNjdFBmdSt5SldxNVFnNEJhU2JBaVJlaUNGbXVm?=
 =?utf-8?B?Z21HbGVraUlXZHNCVXZndVB2QXdvTXZwSjFRbWlmNnRhb3ZtVlowYi9TNGZU?=
 =?utf-8?B?eWd0UW5XR09nMHpTclF0Rks1N1RnMWQzSzFVeU9yVFVXOW5aTm5ZODBTbEQy?=
 =?utf-8?B?OTQ1VkFLNlJBUGVMS21XZFlaYVRuUzlOYkJ5cGpsQUJRT084MTF6RDdqSUZI?=
 =?utf-8?B?ZWhDeVRTTmY2YzZmS283MUV4NEtYT0U2T0xhNk5JUnZCdFFQWDJZbWxJd3V5?=
 =?utf-8?B?NWJiLzdVdEZId2o4K201WERPYVFRQ2Jjcnk5UUM0S3RMTUNBYnNzRTRWR0pS?=
 =?utf-8?B?SXk1eFNnRnFITEFtaFAvN25STFVmWUdaTUFqVXZqR2l0anZzZ3JXVWs1MCtF?=
 =?utf-8?B?L3krbHpVR3pUU05VQ3RKOVF6UkozUkxnbGdYWDVLYVpDVTFSNzloTEIyOFZq?=
 =?utf-8?B?d202Q1VPLzE5WmJTMkpZMnVibXNHM3BGWXBFcEE3c0JsSmNvMk5tdkF3angv?=
 =?utf-8?B?S2UxakV2M1VYNWNwYlhVdzI4RndzQUtWYjRNOExFTVl0Q1dIMit4U2tmUlpF?=
 =?utf-8?B?aWhlQVg1cDV6NEJiNDRVcURRZktXeUVPZHdFWUg4Ym1USkZ2anh5SjdYcncy?=
 =?utf-8?B?UkhERUlXbTMvdjVDRDdaQ1RYSzc1YURFQzc4ZFQ5dmRxMzNFblRJcS9UNXBx?=
 =?utf-8?B?aXNmZmRCSC91bm1Kc3lpODV2WlM1NnU4QjVKeWlPRldOVHJQdE9Qalljb0RX?=
 =?utf-8?B?Ri9EcW1DNlJSYUhKcHZqL3BtTGlOSlRWa0g3ZVFCMS9lQ0ZFSjJQREdueVZl?=
 =?utf-8?B?bzV0VVpEdGVOM1ZXVnBBK1ZQTkUyak5DSWx0UkcwK3R6M08zQUxlOFp0SEp0?=
 =?utf-8?B?YWZzcHNQVHhGdGFkSm9CMnd6V29zTW5nMkoyckpjMmNPcUR0UFJ3eGM3NDc2?=
 =?utf-8?B?UVFXcXpQU0ZiaC9qcW1VWUtJci9MNTZzS0xqRm5FNTJkVnVKVEV1dWhsYlE5?=
 =?utf-8?B?U210WmZ2Q20ybTZGZ0pOOVQydzBtZ1BEOGtqRFViT3Jma0F4cnVKc0lpbm0z?=
 =?utf-8?Q?BZtK/87+zccEdrhWrQlgSwEpCo44Pg3jIl6Wo=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR07MB4962.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(7416011)(1800799021)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QVVCYUFQZjl1enR0T1g0UUdnN0tlYlFUMENCNFluSTFzUVlURGVJN2d6dWd6?=
 =?utf-8?B?c2FDWEZjaVhBRmFkSk04T2EwNnR3M2IzSldNdXRrbWdNQ3NITkZRUFNqaFhI?=
 =?utf-8?B?cnBSeHhNRkJCcWtVQWlNeHhDSUo4WTdRdUQ4aWFqdFMxUWtHTjU4VWQ2Vmc2?=
 =?utf-8?B?d3NVZ0ErT3NyMUdWUnFqenJjcEI2MjQzZi83NkhaRVlSYUFLdGYvY3VwL1Z0?=
 =?utf-8?B?YnNEbWhQTGY5bTFtU1FnbUMxdUl4Zngwd1RudGhHbW5OcGlVZVBjeE1GWXhH?=
 =?utf-8?B?Q1pacS9kMEtiTWptUVFKaUFCRkF4ZHdPZjdlRWFldkFRMTVEdjduM0o2aUEx?=
 =?utf-8?B?WEVvN0FBb3AzRURGSXM3TmtBU2JiM1JOQWJOSzQyQy93aEJhdWk3b2tKVGda?=
 =?utf-8?B?c0MxMEc3N1hOcHVtWTF2V3ZkRDdTaGsvSVpUc3BTWEtUNUl5bzZ5TDF1b3cx?=
 =?utf-8?B?bzFvU2x0OWRNZjl0bXp2bGRLYnA4clo4U2RxUFU2WktlbllBYVRWTGV5NHdm?=
 =?utf-8?B?d2RSUjk3anpVb2F2SU56RVZnMjJQNmVZL3puKzhSUk5jR2ptMnZqVE5aWk5x?=
 =?utf-8?B?UTdTL3FGUVNockpSTFQvbVp2aWJXWFgrYW9NR0dVa0hjWnZFN3FqWFFvUEM3?=
 =?utf-8?B?OW5TdWxCbEdJWXZtUzQvWUsyNWw4aEt1d1NUa0dFSytHeFFBdzJtTitDdEpz?=
 =?utf-8?B?Y0UvSTNKRUt1andKTXExSmZMNWI3MU1wY25Za0xJWHFMQW9oVXJUZjhSa3hY?=
 =?utf-8?B?TGtZb250V0themVmamt5STBrQWs3TmMrSHRBQXpRQkFteXRvU1VMR0xHSjVS?=
 =?utf-8?B?ckFlbFZ6TnB5blovL3JBSEw3OHJHcm1wdHRDendrUnU0a200S0ZpYTNob3F4?=
 =?utf-8?B?am1VT1d3cHdjcVIwV1hENktKdy9FdkNPY3JPODJCcnVVOHFhclVwQzhvUG5C?=
 =?utf-8?B?eGZ5SFhmRUZWVEduREwyTDRWN1k3MkxTNlNheGVlckxXY1VvQkJtdmRXMVdZ?=
 =?utf-8?B?OGFoYVNYbVNWN1ZCZ0Zla3VSbW5PMUlvUXBhT2lEeW16TmZlYXdiZFRGbDVR?=
 =?utf-8?B?cktwR2dDN3NGUXdqb2lwanVOTEVzWEF6MjZCelFpQktUMXIwdlpueXNpank0?=
 =?utf-8?B?Y2xJTGJuNHFSUHAwK2pNRUtEamhlZTdqRHVwVEZSZm1Vby9zM3dHQ2t4eU9Q?=
 =?utf-8?B?dzhTY1d2NmcxUWRUTklvWDkzMlYyUlBrT3h1QU1ndU51WHU4WkdITFdOdUo1?=
 =?utf-8?B?eWltNFQzM1NKQWRxNHk0RUlDWmh1RW43MHM3UlNmakNqbjFHdlo3SW8xM04z?=
 =?utf-8?B?b05oTGdzMjIxeW5LN1VpcEk1YzZZeU8rdzFzcG1lb1hYUzhScDBQSTR6TWJ3?=
 =?utf-8?B?eUd2aWNva1FFZTFsMmtueUl1VGlOMDF4cENSWVV0bGhzU0VlNUN2eTlYVkRG?=
 =?utf-8?B?U0gzWExXanFyWkIxWmlhQ3RDWlEzSTVlQjhDZXFqQTM4elFNeHBWVjBSRko2?=
 =?utf-8?B?c0tSOXUrYjlXYldaTUpSUlVZbmx5TVQrMXhDbWVSQjl4UGNuWnlmVGw2c1pr?=
 =?utf-8?B?aWpieVZBSkI2d29SOGpJanhXL0huY1UzN2E3NXZidXo0bS9KRkpDYlltMXBX?=
 =?utf-8?B?djRvVWlRWWdkaW1FSnpiaEcvNnc3Uk1SZ3JOZnVXd2tIaW9rSlZvalRYMkJG?=
 =?utf-8?B?eGQzNHFCdFkycUV6OVp3RGFVbDQzNUpWMWVxSWNoRFBqMGhQdzVWOUZwRDVi?=
 =?utf-8?B?NDVtWEVLM0xSSGRiTXVBZUxTa1hzcHdyZ3dSSHBlMUJudFhsc3FyQitUaVVL?=
 =?utf-8?B?THJIeHZDamNPeHlPZzNOaE5ZT2lrSVZ1M2xONGZvaUYyR29OcVJ4NlI2WmNV?=
 =?utf-8?B?Y2pMNzJDdkI5TmdwM1AvQkFZZlE3a0I2dTI1NnFrend1Ni9zMzgxVzlRWWZR?=
 =?utf-8?B?SkcrSEZ0dkpDUDdkc3V0aFkvbkkrMko2RG8zRVBDeUtUdFBkU2w5MnVGeVNK?=
 =?utf-8?B?WDd4UC84T2IreUE1NWxiT0tSdFY0WFRTcDhlRXNsOTEvMVdSMHVIN05TbjdP?=
 =?utf-8?B?N0NHYzJZVGN3TWU0MnBCYWR3SG1tU1pZV0RPbytTdmxhY1N0ZTVyRmR0QXVx?=
 =?utf-8?B?VFJsV3NpcmNTQzhQMnB0bE14bE9nZHRhalcyNHRqWkI2UXhzdTFWK21zVEwv?=
 =?utf-8?Q?wUfLO28R0hbLQWfT1GIsA2g=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <19FCAA26BCD4A047A1D2C21725D09D84@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: cs-soprasteria.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR07MB4962.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0ff9638-57d3-4b65-4f0d-08dc8fc5d63f
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2024 18:38:24.5150
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8b87af7d-8647-4dc7-8df4-5f69a2011bb5
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wD8zF+Znh/RmxgJtrQhlsvD2UNpCFSdeFX36H/8Stol9ecb2avUF8fzSUv8bDyh7V3S8s13PnbGBPJzW39aBxMydYVanwZeTDnfevNMw/O5Kk+5SBISerGvu0tRRaeH0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB8118
X-MS-Exchange-CrossPremises-AuthAs: Internal
X-MS-Exchange-CrossPremises-AuthMechanism: 04
X-MS-Exchange-CrossPremises-AuthSource: AM0PR07MB4962.eurprd07.prod.outlook.com
X-MS-Exchange-CrossPremises-TransportTrafficType: Email
X-MS-Exchange-CrossPremises-SCL: 1
X-MS-Exchange-CrossPremises-messagesource: StoreDriver
X-MS-Exchange-CrossPremises-BCC:
X-MS-Exchange-CrossPremises-originalclientipaddress: 84.198.128.222
X-MS-Exchange-CrossPremises-transporttraffictype: Email
X-MS-Exchange-CrossPremises-antispam-scancontext: DIR:Originating;SFV:NSPM;SKIP:0;
X-MS-Exchange-CrossPremises-processed-by-journaling: Journal Agent
X-OrganizationHeadersPreserved: AS8PR07MB8118.eurprd07.prod.outlook.com

DQoNCkxlIDE4LzA2LzIwMjQgw6AgMTY6NDAsIE1heHdlbGwgQmxhbmQgYSDDqWNyaXTCoDoNCj4g
W1ZvdXMgbmUgcmVjZXZleiBwYXMgc291dmVudCBkZSBjb3VycmllcnMgZGUgbWJsYW5kQG1vdG9y
b2xhLmNvbS4gRD9jb3V2cmV6IHBvdXJxdW9pIGNlY2kgZXN0IGltcG9ydGFudCA/IGh0dHBzOi8v
YWthLm1zL0xlYXJuQWJvdXRTZW5kZXJJZGVudGlmaWNhdGlvbiBdDQo+IA0KPiBQcm92aWRlIGEg
S2NvbmZpZyBvcHRpb24gaW5kaWNhdGluZyBpZiBub3RlX3BhZ2UgY2FuIGJlIGNhbGxlZCBmb3IN
Cj4gaW50ZXJtZWRpYXRlIHBhZ2UgZGlyZWN0b3JpZXMgZHVyaW5nIHB0ZHVtcC4NCj4gDQo+IFNp
Z25lZC1vZmYtYnk6IE1heHdlbGwgQmxhbmQgPG1ibGFuZEBtb3Rvcm9sYS5jb20+DQo+IC0tLQ0K
PiAgIG1tL0tjb25maWcuZGVidWcgfCAgOSArKysrKysrKysNCj4gICBtbS9wdGR1bXAuYyAgICAg
IHwgMjEgKysrKysrKysrKysrKy0tLS0tLS0tDQo+ICAgMiBmaWxlcyBjaGFuZ2VkLCAyMiBpbnNl
cnRpb25zKCspLCA4IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL21tL0tjb25maWcu
ZGVidWcgYi9tbS9LY29uZmlnLmRlYnVnDQo+IGluZGV4IGFmYzcyZmRlMGYwMy4uNmFmNWVjZmRl
ZjkzIDEwMDY0NA0KPiAtLS0gYS9tbS9LY29uZmlnLmRlYnVnDQo+ICsrKyBiL21tL0tjb25maWcu
ZGVidWcNCj4gQEAgLTIwMSw2ICsyMDEsMTUgQEAgY29uZmlnIFBURFVNUF9ERUJVR0ZTDQo+IA0K
PiAgICAgICAgICAgIElmIGluIGRvdWJ0LCBzYXkgTi4NCj4gDQo+ICtjb25maWcgQVJDSF9TVVBQ
T1JUU19OT05fTEVBRl9QVERVTVANCj4gKyAgICAgICBib29sICJJbmNsdWRlIGludGVybWVkaWF0
ZSBkaXJlY3RvcnkgZW50cmllcyBpbiBwYWdldGFibGUgZHVtcHMiDQo+ICsgICAgICAgZGVmYXVs
dCBuDQo+ICsgICAgICAgaGVscA0KPiArICAgICAgICAgRW5hYmxlIHRoZSBpbmNsdXNpb24gb2Yg
aW50ZXJtZWRpYXRlIHBhZ2UgZGlyZWN0b3J5IGVudHJpZXMgaW4gY2FsbHMNCj4gKyAgICAgICAg
IHRvIHRoZSBwdGR1bXAgQVBJLiBPbmNlIGFuIGFyY2hpdGVjdHVyZSBkZWZpbmVzIGNvcnJlY3Qg
cHRkdW1wDQo+ICsgICAgICAgICBiZWhhdmlvciBmb3IgUEdELCBQVUQsIFA0RCwgYW5kIFBNRCBl
bnRyaWVzLCB0aGlzIGNvbmZpZyBjYW4gYmUNCj4gKyAgICAgICAgIHNlbGVjdGVkLg0KPiArDQo+
ICAgY29uZmlnIEhBVkVfREVCVUdfS01FTUxFQUsNCj4gICAgICAgICAgYm9vbA0KPiANCj4gZGlm
ZiAtLWdpdCBhL21tL3B0ZHVtcC5jIGIvbW0vcHRkdW1wLmMNCj4gaW5kZXggMTA2ZTFkNjZlOWY5
Li42MTgwNzA4NjY5ZmUgMTAwNjQ0DQo+IC0tLSBhL21tL3B0ZHVtcC5jDQo+ICsrKyBiL21tL3B0
ZHVtcC5jDQo+IEBAIC00MSwxMCArNDEsMTEgQEAgc3RhdGljIGludCBwdGR1bXBfcGdkX2VudHJ5
KHBnZF90ICpwZ2QsIHVuc2lnbmVkIGxvbmcgYWRkciwNCj4gICAgICAgICAgaWYgKHN0LT5lZmZl
Y3RpdmVfcHJvdCkNCj4gICAgICAgICAgICAgICAgICBzdC0+ZWZmZWN0aXZlX3Byb3Qoc3QsIDAs
IHBnZF92YWwodmFsKSk7DQo+IA0KPiAtICAgICAgIGlmIChwZ2RfbGVhZih2YWwpKSB7DQo+ICsg
ICAgICAgaWYgKElTX0VOQUJMRUQoQ09ORklHX0FSQ0hfU1VQUE9SVFNfTk9OX0xFQUZfUFREVU1Q
KSB8fCBwZ2RfbGVhZih2YWwpKQ0KPiAgICAgICAgICAgICAgICAgIHN0LT5ub3RlX3BhZ2Uoc3Qs
IGFkZHIsIDAsIHBnZF92YWwodmFsKSk7DQo+ICsNCj4gKyAgICAgICBpZiAocGdkX2xlYWYodmFs
KSkNCj4gICAgICAgICAgICAgICAgICB3YWxrLT5hY3Rpb24gPSBBQ1RJT05fQ09OVElOVUU7DQo+
IC0gICAgICAgfQ0KPiANCj4gICAgICAgICAgcmV0dXJuIDA7DQo+ICAgfQ0KPiBAQCAtNjQsMTAg
KzY1LDExIEBAIHN0YXRpYyBpbnQgcHRkdW1wX3A0ZF9lbnRyeShwNGRfdCAqcDRkLCB1bnNpZ25l
ZCBsb25nIGFkZHIsDQo+ICAgICAgICAgIGlmIChzdC0+ZWZmZWN0aXZlX3Byb3QpDQo+ICAgICAg
ICAgICAgICAgICAgc3QtPmVmZmVjdGl2ZV9wcm90KHN0LCAxLCBwNGRfdmFsKHZhbCkpOw0KPiAN
Cj4gLSAgICAgICBpZiAocDRkX2xlYWYodmFsKSkgew0KPiArICAgICAgIGlmIChJU19FTkFCTEVE
KENPTkZJR19BUkNIX1NVUFBPUlRTX05PTl9MRUFGX1BURFVNUCkgfHwgcGdkX2xlYWYodmFsKSkN
Cg0KRG9uJ3QgeW91IG1lYW4gcDRkX2xlYWYoKSBoZXJlIGluc3RlYWQgb2YgcGdkX2xlYWYoKSA/
DQoNCj4gICAgICAgICAgICAgICAgICBzdC0+bm90ZV9wYWdlKHN0LCBhZGRyLCAxLCBwNGRfdmFs
KHZhbCkpOw0KPiArDQo+ICsgICAgICAgaWYgKHA0ZF9sZWFmKHZhbCkpDQo+ICAgICAgICAgICAg
ICAgICAgd2Fsay0+YWN0aW9uID0gQUNUSU9OX0NPTlRJTlVFOw0KPiAtICAgICAgIH0NCj4gDQo+
ICAgICAgICAgIHJldHVybiAwOw0KPiAgIH0NCj4gQEAgLTg3LDEwICs4OSwxMSBAQCBzdGF0aWMg
aW50IHB0ZHVtcF9wdWRfZW50cnkocHVkX3QgKnB1ZCwgdW5zaWduZWQgbG9uZyBhZGRyLA0KPiAg
ICAgICAgICBpZiAoc3QtPmVmZmVjdGl2ZV9wcm90KQ0KPiAgICAgICAgICAgICAgICAgIHN0LT5l
ZmZlY3RpdmVfcHJvdChzdCwgMiwgcHVkX3ZhbCh2YWwpKTsNCj4gDQo+IC0gICAgICAgaWYgKHB1
ZF9sZWFmKHZhbCkpIHsNCj4gKyAgICAgICBpZiAoSVNfRU5BQkxFRChDT05GSUdfQVJDSF9TVVBQ
T1JUU19OT05fTEVBRl9QVERVTVApIHx8IHBnZF9sZWFmKHZhbCkpDQoNCkRvbid0IHlvdSBtZWFu
IHB1ZF9sZWFmKCkgaGVyZSBpbnN0ZWFkIG9mIHBnZF9sZWFmKCkgPw0KDQo+ICAgICAgICAgICAg
ICAgICAgc3QtPm5vdGVfcGFnZShzdCwgYWRkciwgMiwgcHVkX3ZhbCh2YWwpKTsNCj4gKw0KPiAr
ICAgICAgIGlmIChwdWRfbGVhZih2YWwpKQ0KPiAgICAgICAgICAgICAgICAgIHdhbGstPmFjdGlv
biA9IEFDVElPTl9DT05USU5VRTsNCj4gLSAgICAgICB9DQo+IA0KPiAgICAgICAgICByZXR1cm4g
MDsNCj4gICB9DQo+IEBAIC0xMDgsMTAgKzExMSwxMiBAQCBzdGF0aWMgaW50IHB0ZHVtcF9wbWRf
ZW50cnkocG1kX3QgKnBtZCwgdW5zaWduZWQgbG9uZyBhZGRyLA0KPiANCj4gICAgICAgICAgaWYg
KHN0LT5lZmZlY3RpdmVfcHJvdCkNCj4gICAgICAgICAgICAgICAgICBzdC0+ZWZmZWN0aXZlX3By
b3Qoc3QsIDMsIHBtZF92YWwodmFsKSk7DQo+IC0gICAgICAgaWYgKHBtZF9sZWFmKHZhbCkpIHsN
Cj4gKw0KPiArICAgICAgIGlmIChJU19FTkFCTEVEKENPTkZJR19BUkNIX1NVUFBPUlRTX05PTl9M
RUFGX1BURFVNUCkgfHwgcGdkX2xlYWYodmFsKSkNCg0KRG9uJ3QgeW91IG1lYW4gcG1kX2xlYWYo
KSBoZXJlIGluc3RlYWQgb2YgcGdkX2xlYWYoKSA/DQoNCj4gICAgICAgICAgICAgICAgICBzdC0+
bm90ZV9wYWdlKHN0LCBhZGRyLCAzLCBwbWRfdmFsKHZhbCkpOw0KPiArDQo+ICsgICAgICAgaWYg
KHBtZF9sZWFmKHZhbCkpDQo+ICAgICAgICAgICAgICAgICAgd2Fsay0+YWN0aW9uID0gQUNUSU9O
X0NPTlRJTlVFOw0KPiAtICAgICAgIH0NCj4gDQo+ICAgICAgICAgIHJldHVybiAwOw0KPiAgIH0N
Cj4gLS0NCj4gMi4zOS4yDQo+IA0KPiANCg==


Return-Path: <linux-kernel+bounces-243464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C60A929672
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 06:14:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C77BE282125
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 04:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD79A7482;
	Sun,  7 Jul 2024 04:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="fSzk3vPJ"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11olkn2084.outbound.protection.outlook.com [40.92.20.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D8846B8;
	Sun,  7 Jul 2024 04:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.20.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720325666; cv=fail; b=iAtXROW2RGB3mvl7frN+NPUFXqMN3GHYnh0cZjQI4QFFk8s+muwTc14pvgKJDR6oDp7cgjDkeynm9LR+zPcZO6D/VGHj3FSeKYbWt2dW4sxt7ei8j5OZOqfhJ3bBAF+cwnUcav46qUR49GFVhNWlEDhMkX2q5niD5lV4UaMuVEA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720325666; c=relaxed/simple;
	bh=70gPKI9TqAARRZyymG25TG26ZO7FTeB56IVE7fIFExc=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=pD9n6t/fSIqH8RqNOtvOIproenNsPp357h/p0a5M3Nlo42yX1/K6gqe6tELH44IUz4yWvDEv/DxNmstPWv7FDiMuroS72YqnkggIKDrlsGysbQpJtz5lq5Jxuz0FvezglxXf7iblBx2+O/NeZ1uB/ZXLADT44LlLeyYOqc8sx7s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=fSzk3vPJ; arc=fail smtp.client-ip=40.92.20.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CqnPNsTEVsyyptTLZX5+EujPgTHzQz+7gZiXX2I2ag48m3rX3n/637cblLmINIH+Q1Sh6FDgjpMrzbDOWLZiUWhceLjrNSGEV+plD2XoAiVWw74qoff7ELKatEl4sxrrjFwxPs9LQol3nYKqSbp5ycia4PwBs9aQj9/hleanX2lfGpYPEQotZt0usZXNPW3GfPnM3YwOaE7k3+7t/bZKo5g1IsjIa1HplW5BopeZqRdEyuzUYD/Lk8hQQxJ4D/ZuBBZV0hoCyztkbjrmdkDUJ5vNBNOE0aDmShkcWQte9wq42HXvQzJoDd9K5h9UNea9YY+y8UVWTvswnRzEo75kBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=70gPKI9TqAARRZyymG25TG26ZO7FTeB56IVE7fIFExc=;
 b=JHcqE60TCOpsmLEGVfiSvyRhnSv8aFbsRm484MtvqFLf44MM7wI8FdcfonKX/W0CzkFO/na77nJBulohRrdL4QXaOQcefPwrRJPBsylNGsHc/H4k/GtbuXMPcSqH7tT57aE1vWRLep3PthjESVA7CfRcGMQmTx8pmvinrjfNDaUGpz8VFTVfRO0VdkFHz+K35RCkkM94swPsZpZnwbmHc4uXBl4b6Vunzuoh50HIUFDBh2hfUsFssW34adRPcillW8nTGOzEglGOBL0RRGt5p+6HDGmp5I/OxclOhRufoxFMDS/6drx4npcqvfnGF+XiQ2tmnvf8lRtj0nH6Eej3zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=70gPKI9TqAARRZyymG25TG26ZO7FTeB56IVE7fIFExc=;
 b=fSzk3vPJNiOKYneoIU7iBPTbAm2AZgSS2/+7kH0dPCB0X6ZKP7U8hMDPX2htIOsDeGthc90YnR+BjId14fM8EIOGfO7jvsKETTuTFpt2UK0GKvV7zRGoGFUFQZeHEVGvI6j5M3F5+kfDdUY3SKHCtwnsuzzdI8MveOKFNZ1y35cE9njXxdNMLKD+enQNgXwAjSlDVMh+3fmSMMGJ5cQMHsJuYhgt5mGlLLcurHT/ElD0PBzhGrXBeh21/5bUmPG6nQMqv/P6fPSk46S3NLRKgh8HnEP2wZ301spaU2gIXR77pw+EtaPC6PO9WcCHUljxB24ilEVpP0ZoFpqPeCvadQ==
Received: from DM4P223MB0541.NAMP223.PROD.OUTLOOK.COM (2603:10b6:8:b3::14) by
 SJ2P223MB0798.NAMP223.PROD.OUTLOOK.COM (2603:10b6:a03:545::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7741.34; Sun, 7 Jul 2024 04:14:21 +0000
Received: from DM4P223MB0541.NAMP223.PROD.OUTLOOK.COM
 ([fe80::17db:c539:a782:454e]) by DM4P223MB0541.NAMP223.PROD.OUTLOOK.COM
 ([fe80::17db:c539:a782:454e%5]) with mapi id 15.20.7741.033; Sun, 7 Jul 2024
 04:14:21 +0000
From: Gold Side <goldside000@outlook.com>
To: "krzk@kernel.org" <krzk@kernel.org>, "perex@perex.cz" <perex@perex.cz>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
	"linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>
Subject: [PATCH 1/3] Removed extra asterisks from comment beginnings, and
 removed unnecessary comment end
Thread-Topic: [PATCH 1/3] Removed extra asterisks from comment beginnings, and
 removed unnecessary comment end
Thread-Index: AQHa0CHI8axgrHoe4kSQ+0PlQHKNTw==
Date: Sun, 7 Jul 2024 04:14:20 +0000
Message-ID:
 <DM4P223MB0541357D7B105C83EF9FCFD5F7D92@DM4P223MB0541.NAMP223.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn: [Si86YnHK85SXJLdDT54Th/U1SEyKFgSE]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4P223MB0541:EE_|SJ2P223MB0798:EE_
x-ms-office365-filtering-correlation-id: 8b38e98d-1aa9-4720-db3c-08dc9e3b466b
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|8060799006|19110799003|102099032|3412199025|440099028;
x-microsoft-antispam-message-info:
 FpGlwTytWZQO47VYNQJ4FQsd20DuYyqSg7Y5DedqDpri2+8M0gutcHf2nnNPQ5/v6D8HI6q1ApS7j8k/q3ETN9bg5To/G6241gyIzZ9O+FxEemEKrHcK2QLmKKt20gNwWujoZ5mPuRXrFe2lRxe7F9DSqQiQIMnAvAf8GMztRFxAumhIiAiigiUMrK6DTvraHuTjQCxPXHqlL28+fcDl+kHMXJPoRUeVwpCsMk7AWMCx6l37/muDe+BpCm1IF+JB+aq0VSzsJ77X/4qowogKXB5rmVS2cVA8dA1ct9U8hTLUd6cVojO5WvZoX7xcdLN7uegztD4hkj0nkMAAgEql29dcvtjiL9Cc9o8UcdwvbH7VSdlFWFQU+b0sz1z6WjtCR5fxQOqYTW3mQL6DAB/W4sMDzrs7a6m99VCnYmi25L6IaX9AQkjBx+GbYQzG5w4qBroHay+tp6N/GDHvRouwWYjAr36OjjDaK89+fd1yfwBPnVb0rjlrHO5vQ4+tY54DDOIyDLXvtovq03evKPPiq19zrU8icQD4Bn3ozHsiC6saFT4ag38cy2RkH8nUoN2mB2Kuz2k+mlAT74v3vA3Tt2WtTZSwT5kA3dQZrewgTKWbLAK4RhNKGKhvg4mQ6jEfHAkEqdnjUJAWnIk8ciXs7g==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YW1BQzV4RXh0UGFvbGRmMjhZN2JwdWdGS0U5UDdGUVhIYUZTZjNxRkZTRTZB?=
 =?utf-8?B?WFJPcnFNK1VTaFRFc0YzNXQ4Ui9obzBGdlJFOGd4YmxpRUZWMjhBTEIvWURN?=
 =?utf-8?B?YnRpZU15RDRLOUZrSGlGQzBnUzBiWkcxYlZLY3Nmclhmam5pdFhKWks3alVO?=
 =?utf-8?B?UnoxcWxLaDdDK2hwQmcrbEtQUlNadUpsbUIwN0dGcXFEeEhFRjRTbDlaZmFV?=
 =?utf-8?B?OTFVL252bGhCVkNxWlhhVXJLL2tnWXJpbnM5WnBNZGtxaUY0dkxla005b2FO?=
 =?utf-8?B?MlhmaUlUa0RUZHpGTXk1cDErUHB4SUZzYklUQWc5SjF0YTZLRUhuUVd1RFBk?=
 =?utf-8?B?VHc1NnFMcUFaYlFjdnFTOW94c1EvWkpBamw3SzBjVi9CRjJPbmtnYllYWGpP?=
 =?utf-8?B?SE1UTmJ6MjNCTDAwRi83a3hlL3JFR1V0elBkK1dXTjhjZmh1WUhnOUVzQlJC?=
 =?utf-8?B?NFYzK2Y3WGhQYlZ6WlpZNlMwUXc5S0s1ektZVXA3b2FWN1JVbDd0Q0xya21J?=
 =?utf-8?B?RytpOHU4R0lWOVo1ZmpDYmU0QjFnaVlCcE5odVZZeFB4Q0dOTERXRTJxRzFW?=
 =?utf-8?B?WHYyYTJMMEJsOUIvNkM3MnpmMVErenlLL055QktuNllBR0lUVVZsOEJXdUNY?=
 =?utf-8?B?SUdXSFBDMTRiVll1R0xPWUZ1dHZiR2wveFFjSGJ5RzBzY3pTb08reTJqL1Qy?=
 =?utf-8?B?TXhMSGpkME91OW1NVHdzeXB2T2IxYUtkempRc1hKRDEvYURVc0hKTk9aSFg2?=
 =?utf-8?B?Rm9VTUZOcWM1ZTNGQmV4cVUvTVdQb2tzN1VIcGxqcTYwL0VKREVOejkrM0Ir?=
 =?utf-8?B?emZ6cWpQQmwxSHIzTklSRmpSNEgwRm85R2tNRUxoOFR4M3ZwRDVxNTE2T09i?=
 =?utf-8?B?dFVrbC9JNlJYWFV4STR0ZGRKVVBhVnNueHlkWVhmUTRVbjlwTlpGMVhjOXlz?=
 =?utf-8?B?VCtubjBESThwYXdYaVUwTENkNjBwZE4vUGQrMzUzWDRBNm5kMkNGc2xkUHBD?=
 =?utf-8?B?NEh5eUZyeFA3NXR5VnVwZ1BkQ2tGeTNORE9OVDhXWlIzNXNnRXduTDVCemsr?=
 =?utf-8?B?TzByRk8rTzFUbXVEWUJhU29kVlRQaEsxWEFnR0d3eUFTNDY3aTI1RXVhVW9M?=
 =?utf-8?B?NzBBczNrbFI4TzdCMDB2bzIwMkp0TGU2WGhLVHJ1YzNlNzdUcUJWSVNoMHlm?=
 =?utf-8?B?enlpdlo5YmgrU3JHVndDSEZUemNJQnBNNUFIWTNncTBmVGdhcUpZQjNNdWMz?=
 =?utf-8?B?RUZINGhTdUQyZEJWQisvSnIzWnltb2tRY2xIbStudmFiZzVEMEVsYnN0dTR4?=
 =?utf-8?B?Uk5XMjlma3BuczRsUVVsdUVBRXlDZ2o4NGtiVDRHakI2Q1dJbityYnBsZ2xk?=
 =?utf-8?B?Z0YxbDhlMHBrMU5QYi8vTDVNZG4zVUNZRlVGZHdzdEZJYmJsTjlJVkRLYnpV?=
 =?utf-8?B?ZUw0R3FNcUFxUzJ5c1pVbTVaTmJNazEyUVNrcS9OSzByMTk5dDc1eGpqTndF?=
 =?utf-8?B?Ri9sbWV5c00vTDFxbDFPZjYyYlhKWlVBR3EwVmtOTjN5dC83c1N1eVJGWUtB?=
 =?utf-8?B?OWs2bWhhVU1vYlovaElSa2ZROEVvSXl3SHZjWm85alg0ZXRSVGtscThqUStG?=
 =?utf-8?Q?ajs78niLuGlsYsLmf0XF8cyPklMT6q+SuVp/YZLlMdFQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4P223MB0541.NAMP223.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b38e98d-1aa9-4720-db3c-08dc9e3b466b
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2024 04:14:20.1485
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2P223MB0798

RnJvbSAzNTc0ZjA1MTQyMDdmOTYxMGE2OWQ4MmQzZGQwZDAxOGQ2ZGNlNWRkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTdGV2ZW4gRGF2aXMgPGdvbGRzaWRlMDAwQG91dGxvb2suY29t
PgpEYXRlOiBUdWUsIDIgSnVsIDIwMjQgMjI6NTc6MjQgLTA0MDAKU3ViamVjdDogW1BBVENIIDEv
M10gUmVtb3ZlZCBleHRyYSBhc3RlcmlzayBmcm9tIGNvbW1lbnQgYmVnaW5uaW5nCgpJdCBzYXZl
cyBhIGJ5dGUuIEknZCBpbWFnaW5lIGJ5dGVzIGFyZSB2YWx1YWJsZSBpbiBhIHByb2plY3QgbGlr
ZSB0aGlzLgpQUzogUGxlYXNlIGZvcmdpdmUgbXkgcHJldmlvdXMgcGF0Y2ggZW1haWwsIEkgZGlk
bid0IGtub3cgdGhlIGd1aWRlbGluZXMgd2VsbC4KU2lnbmVkLW9mZi1ieTogU3RldmVuIERhdmlz
IDxnb2xkc2lkZTAwMEBvdXRsb29rLmNvbQotLS0KwqBrZXJuZWwvbW9kdWxlL21haW4uYyB8IDIg
Ky0KwqAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYg
LS1naXQgYS9rZXJuZWwvbW9kdWxlL21haW4uYyBiL2tlcm5lbC9tb2R1bGUvbWFpbi5jCmluZGV4
IGQxOGE5NGI5NzNlMTAyLi4yNWU0NTZmNDM4MWM3MSAxMDA2NDQKLS0tIGEva2VybmVsL21vZHVs
ZS9tYWluLmMKKysrIGIva2VybmVsL21vZHVsZS9tYWluLmMKQEAgLTQ1MCw3ICs0NTAsNyBAQCBi
b29sIF9faXNfbW9kdWxlX3BlcmNwdV9hZGRyZXNzKHVuc2lnbmVkIGxvbmcgYWRkciwgdW5zaWdu
ZWQgbG9uZyAqY2FuX2FkZHIpCsKg4oCC4oCC4oCC4oCC4oCCcmV0dXJuIGZhbHNlOwrCoH0KwqAK
LS8qKgorLyoKwqAgKiBpc19tb2R1bGVfcGVyY3B1X2FkZHJlc3MoKSAtIHRlc3Qgd2hldGhlciBh
ZGRyZXNzIGlzIGZyb20gbW9kdWxlIHN0YXRpYyBwZXJjcHUKwqAgKiBAYWRkcjogYWRkcmVzcyB0
byB0ZXN0CsKgICo=


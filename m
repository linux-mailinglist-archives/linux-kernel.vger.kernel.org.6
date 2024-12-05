Return-Path: <linux-kernel+bounces-433897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA59B9E5E7A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 19:52:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 342DE282451
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 18:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C993822D4CB;
	Thu,  5 Dec 2024 18:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="QqdXbALE"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11olkn2056.outbound.protection.outlook.com [40.92.19.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B81225797
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 18:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.19.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733424760; cv=fail; b=uhS5N/r4z+vqfBCGpbvftrQ8DonUqjqi/NXeYxG+wD7O6k24V0dTK9dSpocJ6RWXLDASIKy63CFDjdvYi3R5p2B0Lxis7gy1bz9SnN/9VofqWFiOYVcFgrm/KEIEymidNClYyQDyhiKx8u2WquwFn7k+9Puhvo/+oi8rcqV0Dm0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733424760; c=relaxed/simple;
	bh=TaW+dlnEuqXA692hxZiCajmWA6/ouRYc8pddKipuIF0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Hl7k0WuL4JXNZROQg/4cMhWpAY0xIcUNduvoQ0TDCgNGjGrzoOPgTA6KHhDxcBb5E2/QnB6Lm9GY/v/mB0JqfcqvjvmpDcu6hmbOv+lY0oKDAaqw5WHf/UJBYuu9H160DyMgcoLUFJ4AFgBHHKrDGWYaXx8+qDLT7HyL0ideZQA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=QqdXbALE; arc=fail smtp.client-ip=40.92.19.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LgNKrhAxUuhcMcZh8DZ31KSSFaFbuB5jMN4oHFD3mnmr6keYaDj8hqzfUbOASRtw+roFvmqJtgShCYNBLN8xwKlweShvL/KWSo9lfwYS0sF0Tz6H6h7Zt84qNdRcZWgz+skzAwjIC6S1mSNVpzKblUCPZX2dmKHfy6BTqohZlPpJzk1ohoc011743RHbxUQRNPgsO59x1okUjngt/FQxk6nZolt/r5VfW901HHR5VEW3EeNjIJbz7vJ+vFpPuer6TJfGX7atRe6NjUKyEBFPMwsePs9rPg8T2wFjLWhk78p80rdsXqsP3wM2Rbv5xbLvoLLX415ENsOE5p9PIUt9Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TaW+dlnEuqXA692hxZiCajmWA6/ouRYc8pddKipuIF0=;
 b=OcXrMEvpGJIbD9GooHSThOvS5e5nbbs/K7Mfy/BzrDCdKiTIptONX2v4KiUeI4hTTcqRC3OSXiqRDsWln/C+PyFeMqwicCdZgx7oSFmZvjiT69uyUdEmNe8Wpf4SwBbiiYctAX0v6B1XGur5c90oHItnjUMcJOa/LphaNXwLcNBHYrIUXaOmeWCKDvjNjOd9zcovgZoFQRkrgevZQyVKwtLPUzvdE5CPdWkKJhgwIKcxMEtihfSoIEMjSbt0Md9UUCIsyPDlWuD0sKE/nE2wZDJ32YmbpAXfbVyc77y/RWQnFXO2mnHOKnBrYg6MYkASOs+VCNJd8qTrnxBML7qHwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TaW+dlnEuqXA692hxZiCajmWA6/ouRYc8pddKipuIF0=;
 b=QqdXbALEgyIBAdTixtZxIk7y0do6BQp+XW0l6bgYiXZvadnz+qVkq07zWToI05mFtragAbcXEFL1fRaQToq0Fzbbx6LKWEcQfsawEPyA59CUM952viXm12puYP6NYcqnOo8zOf+SpxjeizRR62F+ghBbIHBsBvt3YCwhHf2c68OGFnbFeIicyJynA41wdxKkupH7pV4CIpPkdPL0x8inG5hjK/HLQlQCPHUmNDhZGcUCok9MOkALRdlaI4LUr1OUPP+huRVG0FUw3m8zXwEdLd53DsKbRI7zZhX3vz8/mHqTAqFXsRoRSdnNkkRJKw6wtcl2wmbtAqIzeEsyBF3Hjw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CH3PR02MB9562.namprd02.prod.outlook.com (2603:10b6:610:129::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Thu, 5 Dec
 2024 18:52:36 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%7]) with mapi id 15.20.8207.017; Thu, 5 Dec 2024
 18:52:35 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Petr Tesarik <ptesarik@suse.com>, Ryan Roberts <ryan.roberts@arm.com>
CC: Andrew Morton <akpm@linux-foundation.org>, Anshuman Khandual
	<anshuman.khandual@arm.com>, Ard Biesheuvel <ardb@kernel.org>, Catalin
 Marinas <catalin.marinas@arm.com>, David Hildenbrand <david@redhat.com>, Greg
 Marsden <greg.marsden@oracle.com>, Ivan Ivanov <ivan.ivanov@suse.com>, Kalesh
 Singh <kaleshsingh@google.com>, Marc Zyngier <maz@kernel.org>, Mark Rutland
	<mark.rutland@arm.com>, Matthias Brugger <mbrugger@suse.com>, Miroslav Benes
	<mbenes@suse.cz>, Will Deacon <will@kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: RE: [RFC PATCH v1 00/57] Boot-time page size selection for arm64
Thread-Topic: [RFC PATCH v1 00/57] Boot-time page size selection for arm64
Thread-Index: AQHbHifr7Pi067ctQ0iGvwc5NuWBOLKK46gAgAABW4CATVKKAIAAGCZg
Date: Thu, 5 Dec 2024 18:52:35 +0000
Message-ID:
 <SN6PR02MB41571E0BD384C44C46127B49D4302@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20241014105514.3206191-1-ryan.roberts@arm.com>
	<20241017142752.17f2c816@mordecai.tesarici.cz>
	<aa9a7118-3067-448e-aa34-bbc148c921a2@arm.com>
 <20241205182008.2b36476a@mordecai.tesarici.cz>
In-Reply-To: <20241205182008.2b36476a@mordecai.tesarici.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CH3PR02MB9562:EE_
x-ms-office365-filtering-correlation-id: c97a6b35-7c8c-44ca-ae01-08dd155dfbcc
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799006|19110799003|8062599003|461199028|8060799006|102099032|3412199025|440099028;
x-microsoft-antispam-message-info:
 =?utf-8?B?UnFvNUltUUFZV1JlNjlGTk1ISU5ZODErSkxWSTdQZ1ozUjBUY0FjYThpd1JI?=
 =?utf-8?B?RjM0Qk1RM3Izd2hyNXlGMlBZZlFzd3dQV1J1TUhEc2FIc052MnlKajQ4ZDZO?=
 =?utf-8?B?T3FoTDJ6S2J4RWxMMHQvV2Jxbm5GMFA0VkhIT2pFOFNjQVR1amhsMEVQYjZB?=
 =?utf-8?B?WE1yNHRudytpNjV2eVpYejRsTkRzbmJMUDhrQXRyM1krRm5VcW5YR1lyeXlo?=
 =?utf-8?B?VGJoSkU4aHFKYTRPYjZrbGhqZjhLRmd4RjhIRmN6Tms3cDFpNzF6ZzlqeVVn?=
 =?utf-8?B?N2xidmtkazZZV2FXR2hmdjVIODdlakpIYS9PcE5iaDBnV2dndUN0U2hmMnJ5?=
 =?utf-8?B?VWJuVDlJWStKc2l4eW8vNkEza3QyM1VwbWpabkR1V3VvMW5EYW95NUR2WG5I?=
 =?utf-8?B?QjA3MlkxdnZab2ZTNG9YNUFsb1MzU29MYTlSVE96cUpUbGJJdTVFSUc5VXdp?=
 =?utf-8?B?MEF1TVZuWHpFRm1sc1JRY3pDSFMzUlN5MjIzSnRLa1dZWURtbXE1QUh0dEh5?=
 =?utf-8?B?RjhaQWppOWFvN0RxYTA5MjkvYU9YbTY3S0Evb2ZQY1dMU1BDbkU1Tmg4ZUpL?=
 =?utf-8?B?U2FYeUxuUGV4eWEzTHh3ZjM4NHpvMkd6RXdrVVJzRWFZeTJ3bG8wdUtiN3Nq?=
 =?utf-8?B?TXRhdEI4cW9qTlcrQjdFUDI5b0JsQXVQOE1LRzFJSXRER2E2cE94aCtySVN0?=
 =?utf-8?B?SURVWUhGQldqVEQvV0NJQzlrYllOWk13VUNHa1ptWnVPZFNjQ3dlNHlGbTZ1?=
 =?utf-8?B?aGtHWFE1L3JHZDZTUG5waU1ScnVNZzc0QndYaURvTnhMOUlBNGtnTW9CUU9R?=
 =?utf-8?B?ekQ4WmJpb3NwQ1F0TnNYNVlSTnhITHo5VVNDZ2JRemlUOWpOU2JGRk5NKzJh?=
 =?utf-8?B?TjNGR1k5MjBBem9LNkEyNHptU1ZsZFBrbWpyUWFnM1llM0ZVNjR5Vmt2cU9a?=
 =?utf-8?B?WGhMYld1R254cTdTLzF3TE8zejcxb1NYRk0xbWlZRW1RVmFucUNGYTZXWEdI?=
 =?utf-8?B?aVQya1p5djlpY3F0LzRreFBFcVB4b3NvMEFJdVc1d2lxQmtxOCtlK0YvWVVI?=
 =?utf-8?B?dzZuNklrbzhpK25lRUQvMUhvWis1empGaFk1ZFd6aTVTTjdWVTE4ZFowU3BL?=
 =?utf-8?B?VS95RjdXYUN0blN5b0E4cDlnUCtvTDNkRFNMWEV6WnAyUEdDVU52OHlVSGo3?=
 =?utf-8?B?Mm0rSTllUmlxdnhkdTJNRGM5QUtYN0MrZGdzSHFxd0Q2UFF5b1NxSnlJZTlz?=
 =?utf-8?B?S3JyMjVPaVVWMTd6NXUzTDN4Yk4xb3FBQnZmN2JrRE92YmpmNGNxQkt3Vnh5?=
 =?utf-8?B?a0NVTDB2ZzloTzkvcEhUeXFWTDJqOHlic2ZubityZDBTVmJhZjdVZnd4QWVE?=
 =?utf-8?B?ZlRlY29EdFA4Q0E9PQ==?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VDhhOExXNVlXQ3lGSTVSaVFndjhwYUpkK2pnVG9qWE1JWkpBdTYzWldiOTJ3?=
 =?utf-8?B?T204OXdpM01ZbjZmYStkL01xNXNTekpXMVV1Q2JoTlJobGR6T2dWY0lzMi9B?=
 =?utf-8?B?UFFmUitjaFFRd2d5ZHBvbit2ZlNnNXpxYUFlS1RZRWo3amxCRWFxWGdhSERW?=
 =?utf-8?B?Vy8zUXNJV1JHZGVpYlFwdlJJUFlvcGR5eXJjeFArTWtaQVY2bXVtRkFsYTBP?=
 =?utf-8?B?SzE4RG5rNjhYWGlCNVFXNlI0YU5BUnV1Z0JRZW1jMEdTYVV4N1p4bWFIT1NB?=
 =?utf-8?B?c2xrRDdOWVVPNFdTekx4NllTMVdFUXJOL3JHVWZNR0g3dDVqQmFNb05rZnpt?=
 =?utf-8?B?b1N3VmZUck9nUlpZSGpObThreWFTOGl2YmtVZWNQczZGR29JNzVMOHdxMDNm?=
 =?utf-8?B?WmNqSXZJWjJFSlY4RmZzQzErNWVZZ1JWcVN1QTRTSkxZTy85b243Sm9rb3Jk?=
 =?utf-8?B?L1ZmYkhXNXVFdDNQM3Ywa1hrTnJhQlJKcm0wTlBXQ1FHUStXeC9zL2U5UmRV?=
 =?utf-8?B?V2RHek1lK1VCV1pQdzlsT3FDUDBQRGRCNDZVWDlRSkpuRFFXcUxmeWNBekZT?=
 =?utf-8?B?dFgxelhSU1NqZCtkcmRKb2U5R21uTG5tTnhXTkZTVkUxMmJOQzBjVXlrYTVy?=
 =?utf-8?B?b0VRVnk3Tk5BTTNCV1ArWkNHT25mNjg4d2xVaVp5OFhkdWlnT0xqZ2xJWk9B?=
 =?utf-8?B?MEQrWUgrRzI2cEV2L0h3UU9NOFI0dUtaL3ZxYVAzYnJrRXgwdStGMXp5eUIv?=
 =?utf-8?B?d3JVcEpHUUlwaThQd1d6Z25ib0lMMkNjbzkrQkVDZUJYWjcrVTB6ZWg4MVNJ?=
 =?utf-8?B?UzNjK1A4RWFKRDlTTzJEL3FRUmRTa0Q1RzNsQkVVYnNPczJ1VmVDd3dOOXNS?=
 =?utf-8?B?Tjc1VnVLSEdleWljTXZsWjRFcWtmUytQMUhjdHZDZjJBVks4a3VYbXR0Mks0?=
 =?utf-8?B?U2I3cVByaGU4VWoyVzNHZUovWGMxKytkZjh4WGNGeGNEMVp0YTczSkhxOG9t?=
 =?utf-8?B?MHIwelM2djI5Z0h0U0I4d0xhVmJGUTQwbXd6UGlwR3VGQ1JWRVlnckZ5dk41?=
 =?utf-8?B?LzhKbFl2Umk1S3NZNS83VUw4QTdDQnhFcjFPcm1wNWZxV1dBR05GUHo5ZW81?=
 =?utf-8?B?cEc1TGpOTXBsSmRkdExHbGJBYVBiNFU2bWw5UHdxLzhrRXNMZDFMK2xJWkNo?=
 =?utf-8?B?ckVQc2VaK054SGpLdTFkQUh6dFdwVmU3SWV0eDI4OFhSRWxodm5Od3hIQnNy?=
 =?utf-8?B?QXlNbXVRbVUyUUNnamh4ZUNTYWRFSnNGZStzVVBoNkhVRXBxMjlSWk1EdmtG?=
 =?utf-8?B?THd1R2JCS3NOOEl0dWdJWG51QlZXVnVHQmJzL0c3R1FHcFVjWmlLU3JDcCtq?=
 =?utf-8?B?M2VEdzE2V29SK1hMSmdidEJjMSt5TldNTXp4eHFEc1dRb0pJZW81YnB2NkFV?=
 =?utf-8?B?SDRwLzdYRHNnampQaUovOEt1d09iTDRSS1dUY3pNS3E2Y25lczUwWEh4UE9G?=
 =?utf-8?B?clUyWFZpd1laVGM4VUtVZmVBNmFnRTdXSG9CNkJkOEluUlhTNWlCV2VYZUN0?=
 =?utf-8?B?N2VpL29RbVRrT2dUQTRwTzQ5YytzYnNibmFPMmVFY1EzQkJQNDRRbk5Xa3pi?=
 =?utf-8?Q?C6jSCVmQa9xIUxs2QlU9UCU5+dAOxlwMZQ8rGbmYajro=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4157.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: c97a6b35-7c8c-44ca-ae01-08dd155dfbcc
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2024 18:52:35.6742
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR02MB9562

RnJvbTogUGV0ciBUZXNhcmlrIDxwdGVzYXJpa0BzdXNlLmNvbT4gU2VudDogVGh1cnNkYXksIERl
Y2VtYmVyIDUsIDIwMjQgOToyMCBBTQ0KPiANCj4gSGkgUnlhbiwNCj4gDQo+IE9uIFRodSwgMTcg
T2N0IDIwMjQgMTM6MzI6NDMgKzAxMDANCj4gUnlhbiBSb2JlcnRzIDxyeWFuLnJvYmVydHNAYXJt
LmNvbT4gd3JvdGU6DQo+IA0KPiA+IE9uIDE3LzEwLzIwMjQgMTM6MjcsIFBldHIgVGVzYXJpayB3
cm90ZToNCj4gPiA+IE9uIE1vbiwgMTQgT2N0IDIwMjQgMTE6NTU6MTEgKzAxMDANCj4gPiA+IFJ5
YW4gUm9iZXJ0cyA8cnlhbi5yb2JlcnRzQGFybS5jb20+IHdyb3RlOg0KPiA+ID4NCj4gPiA+PiBb
Li4uXQ0KPiA+ID4+IFRoZSBzZXJpZXMgaXMgYXJyYW5nZWQgYXMgZm9sbG93czoNCj4gPiA+Pg0K
PiA+ID4+ICAgLSBwYXRjaCAxOgkgICBBZGQgbWFjcm9zIHJlcXVpcmVkIGZvciBjb252ZXJ0aW5n
IG5vbi1hcmNoIGNvZGUgdG8gc3VwcG9ydA0KPiA+ID4+ICAgCQkgICBib290LXRpbWUgcGFnZSBz
aXplIHNlbGVjdGlvbg0KPiA+ID4+ICAgLSBwYXRjaGVzIDItMzY6ICBSZW1vdmUgUEFHRV9TSVpF
IGNvbXBpbGUtdGltZSBjb25zdGFudCBhc3N1bXB0aW9uIGZyb20gYWxsDQo+ID4gPj4gICAJCSAg
IG5vbi1hcmNoIGNvZGUNCj4gPiA+DQo+ID4gPiBJIGhhdmUganVzdCB0cmllZCB0byByZWNvbXBp
bGUgdGhlIG9wZW5TVVNFIGtlcm5lbCB3aXRoIHRoZXNlIHBhdGNoZXMNCj4gPiA+IGFwcGxpZWQs
IGFuZCBJJ20gcnVubmluZyBpbnRvIHRoaXM6DQo+ID4gPg0KPiA+ID4gICBDQyAgICAgIGFyY2gv
YXJtNjQvaHlwZXJ2L2h2X2NvcmUubw0KPiA+ID4gSW4gZmlsZSBpbmNsdWRlZCBmcm9tIC4uL2Fy
Y2gvYXJtNjQvaHlwZXJ2L2h2X2NvcmUuYzoxNDowOg0KPiA+ID4gLi4vaW5jbHVkZS9saW51eC9o
eXBlcnYuaDoxNTg6NTogZXJyb3I6IHZhcmlhYmx5IG1vZGlmaWVkIOKAmHJlc2VydmVkMuKAmSBh
dCBmaWxlIHNjb3BlDQo+ID4gPiAgIHU4IHJlc2VydmVkMltQQUdFX1NJWkUgLSA2OF07DQo+ID4g
PiAgICAgIF5+fn5+fn5+fg0KPiA+ID4NCj4gPiA+IEl0IGxvb2tzIGxpa2Ugb25lIG1vcmUgcGxh
Y2Ugd2hpY2ggbmVlZHMgYSBwYXRjaCwgcmlnaHQ/DQo+ID4NCj4gPiBBcyBtZW50aW9uZWQgaW4g
dGhlIGNvdmVyIGxldHRlciwgc28gZmFyIEkndmUgb25seSBjb252ZXJ0ZWQgZW5vdWdoIHRvIGdl
dCB0aGUNCj4gPiBkZWZjb25maWcgKmltYWdlKiBidWlsZGluZyAoaS5lLiBubyBtb2R1bGVzKS4g
SWYgeW91IGFyZSBjb21waWxpbmcgYSBkaWZmZXJlbnQNCj4gPiBjb25maWcgb3IgY29tcGlsaW5n
IHRoZSBtb2R1bGVzIGZvciBkZWZjb25maWcsIHlvdSB3aWxsIGxpa2VseSBydW4gaW50byB0aGVz
ZQ0KPiA+IHR5cGVzIG9mIGlzc3Vlcy4NCj4gPg0KPiA+IFRoYXQgc2FpZCwgSSBkbyBoYXZlIHNv
bWUgcGF0Y2hlcyB0byBmaXggSHlwZXItViwgd2hpY2ggTWljaGFlbCBLZWxsZXkgd2FzIGtpbmQN
Cj4gPiBlbm91Z2ggdG8gc2VuZCBtZS4NCj4gPg0KPiA+IEkgdW5kZXJzdGFuZCB0aGF0IFN1c2Ug
bWlnaHQgYmUgYWJsZSB0byBoZWxwIHdpdGggd2lkZXIgcGVyZm9ybWFuY2UgdGVzdGluZyAtIGlm
DQo+ID4gdGhhdCdzIHRoZSByZWFzb24geW91IGFyZSB0cnlpbmcgdG8gY29tcGlsZSwgeW91IGNv
dWxkIHNlbmQgbWUgeW91ciBjb25maWcgYW5kDQo+ID4gSSdsbCBzdGFydCB3b3JraW5nIG9uIGZp
eGluZyB1cCBvdGhlciBkcml2ZXJzPw0KPiANCj4gVGhpcyBwcm9qZWN0IHdhcyBkZS1wcmlvcml0
aXNlZCBmb3Igc29tZSB0aW1lLCBidXQgSSBoYXZlIGp1c3QgcmV0dXJuZWQNCj4gdG8gaXQsIGFu
ZCBvbmUgb2Ygb3VyIHRlc3Qgc3lzdGVtcyB1c2VzIGEgTWVsbGFub3ggNSBOSUMsIHdoaWNoIGRp
ZCBub3QgYnVpbGQuDQo+IA0KPiBJZiB5b3Ugc3RpbGwgaGF2ZSB0aW1lIHRvIHdvcmsgb24geW91
ciBwYXRjaCBzZXJpZXMsIHBsZWFzZSwgY2FuIHlvdQ0KPiBsb29rIGludG8gZW5hYmxpbmcgTUxY
NV9DT1JFX0VOPw0KPiANCj4gT2gsIGFuZCBoYXZlIHlvdSByZWJhc2VkIHRoZSBzZXJpZXMgdG8g
Ni4xMiB5ZXQ/DQo+IA0KDQpGV0lXLCBoZXJlJ3Mgd2hhdCBJIGhhY2tlZCB0b2dldGhlciB0byBj
b21waWxlIGFuZCBydW4gdGhlIG1seDUgZHJpdmVyIGluDQphIEh5cGVyLVYgVk0uICBUaGlzIHdh
cyBhZ2FpbnN0IGEgNi4xMSBrZXJuZWwgY29kZSBiYXNlLg0KDQpNaWNoYWVsDQoNCmRpZmYgLS1n
aXQgYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9tZWxsYW5veC9tbHg1L2NvcmUvcGFnZWFsbG9jLmMg
Yi9kcml2ZXJzL25ldC9ldGhlcm5ldC9tZWxsYW5veC9tbHg1L2NvcmUvcGFnZWFsbG9jLmMNCmlu
ZGV4IGQ4OTRhODhmYTlmMi4uZDBiMzgxZGYwNzRjIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9uZXQv
ZXRoZXJuZXQvbWVsbGFub3gvbWx4NS9jb3JlL3BhZ2VhbGxvYy5jDQorKysgYi9kcml2ZXJzL25l
dC9ldGhlcm5ldC9tZWxsYW5veC9tbHg1L2NvcmUvcGFnZWFsbG9jLmMNCkBAIC02Niw5ICs2Niwx
MCBAQCBzdHJ1Y3QgZndfcGFnZSB7DQogDQogZW51bSB7DQogCU1MWDVfTUFYX1JFQ0xBSU1fVElN
RV9NSUxJCT0gNTAwMCwNCi0JTUxYNV9OVU1fNEtfSU5fUEFHRQkJPSBQQUdFX1NJWkUgLyBNTFg1
X0FEQVBURVJfUEFHRV9TSVpFLA0KIH07DQogDQorI2RlZmluZSBNTFg1X05VTV80S19JTl9QQUdF
CSgoaW50KShQQUdFX1NJWkUgLyBNTFg1X0FEQVBURVJfUEFHRV9TSVpFKSkNCisNCiBzdGF0aWMg
dTMyIGdldF9mdW5jdGlvbih1MTYgZnVuY19pZCwgYm9vbCBlY19mdW5jdGlvbikNCiB7DQogCXJl
dHVybiAodTMyKWZ1bmNfaWQgfCAoZWNfZnVuY3Rpb24gPDwgMTYpOw0KZGlmZiAtLWdpdCBhL2lu
Y2x1ZGUvbGludXgvbWx4NS9kZXZpY2UuaCBiL2luY2x1ZGUvbGludXgvbWx4NS9kZXZpY2UuaA0K
aW5kZXggYmE4NzVhNjE5Yjk3Li4yZDM5YmE3N2I1OTEgMTAwNjQ0DQotLS0gYS9pbmNsdWRlL2xp
bnV4L21seDUvZGV2aWNlLmgNCisrKyBiL2luY2x1ZGUvbGludXgvbWx4NS9kZXZpY2UuaA0KQEAg
LTI1NSwxMiArMjU1LDE0IEBAIGVudW0gew0KIAkJCQkJICBNTFg1X05PTl9GUF9CRlJFR1NfUEVS
X1VBUiwNCiAJTUxYNV9NQVhfQkZSRUdTCQkJPSBNTFg1X01BWF9VQVJTICoNCiAJCQkJCSAgTUxY
NV9OT05fRlBfQkZSRUdTX1BFUl9VQVIsDQotCU1MWDVfVUFSU19JTl9QQUdFCQk9IFBBR0VfU0la
RSAvIE1MWDVfQURBUFRFUl9QQUdFX1NJWkUsDQotCU1MWDVfTk9OX0ZQX0JGUkVHU19JTl9QQUdF
CT0gTUxYNV9OT05fRlBfQkZSRUdTX1BFUl9VQVIgKiBNTFg1X1VBUlNfSU5fUEFHRSwNCiAJTUxY
NV9NSU5fRFlOX0JGUkVHUwkJPSA1MTIsDQogCU1MWDVfTUFYX0RZTl9CRlJFR1MJCT0gMTAyNCwN
CiB9Ow0KIA0KKw0KKyNkZWZpbmUJTUxYNV9VQVJTX0lOX1BBR0UJCSgoaW50KShQQUdFX1NJWkUg
LyBNTFg1X0FEQVBURVJfUEFHRV9TSVpFKSkNCisjZGVmaW5lCU1MWDVfTk9OX0ZQX0JGUkVHU19J
Tl9QQUdFCSgoaW50KShNTFg1X05PTl9GUF9CRlJFR1NfUEVSX1VBUiAqIE1MWDVfVUFSU19JTl9Q
QUdFKSkNCisNCiBlbnVtIHsNCiAJTUxYNV9NS0VZX01BU0tfTEVOCQk9IDF1bGwgPDwgMCwNCiAJ
TUxYNV9NS0VZX01BU0tfUEFHRV9TSVpFCT0gMXVsbCA8PCAxLA0K


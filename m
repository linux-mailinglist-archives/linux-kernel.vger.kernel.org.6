Return-Path: <linux-kernel+bounces-546728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F95A4FE16
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 12:57:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6B7916C3F3
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 11:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D7C1241C8B;
	Wed,  5 Mar 2025 11:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="TtEf+UPQ"
Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010002.outbound.protection.outlook.com [52.103.68.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A3A1514CC;
	Wed,  5 Mar 2025 11:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741175833; cv=fail; b=TBEjFgNwbz2eVo8lUcKeZLlfmTjECBXqIqR9fhk2dPqTBn/P+rnGZ8yODmktFQuwUp+6o01lEOQ0b4ymvARI7mBUasDzkzJZ/86X8rQXNWAO+SB6cTO12khhHFFQtBvEdWeZPvrt+Zq32i1HSxBZK0h0JQfYusd3Vt77SdQmrKc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741175833; c=relaxed/simple;
	bh=rKzSgNF5SOVNjQc3i0WzM4dt3ddgxnUWv+9bSvexRsg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PV75YZegmFxJsh6CvSauR2sfN0N9X/7Zp3TGab02wYggOJRIhlPMCOXYvUyb/HA2JzM917H/iknQDmfv+Qj33c3xicnVeZ/HT1R/MFgrv/FIS/xfG/J164VDBqBtcDHkB1tMRq9sFm0FbOqRnU+sD1sHUOUmr9YIP6UWWFP8OT8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=TtEf+UPQ; arc=fail smtp.client-ip=52.103.68.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YCw0Szx8VFV3GeiwD1/YPUCRcSSS5kq+HRFU1eN7SltZwH8HCInHJhlRgYW1R2UxSE3wIlRiqOK3nDNW+53pNByN62nYvVltfO8h3qvUwv3aPuVnaScMjZmcZq4VtcdZ1OvBnd9G4jJEvgOB1JcmPMUhMmV+zwicV4OZHQYw7POoSSYgj4yarUTkeHzzw0TBqgQZzmUtsKrhAi24iINozoK6tegt/awZJw0I2EAey71i6LZxYnrSom8TdCpQ7O+NPH6Z1Ya2Rw6hB1AZDQPcKB2J+DJp8Z9tPpwsmb68ywbDGeG+kfyQyYXC6j5nm17V5KRSZ+6/8yvqOsKXmM1N9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rKzSgNF5SOVNjQc3i0WzM4dt3ddgxnUWv+9bSvexRsg=;
 b=DeJ+LpOeJuFgkM3cOMeTd1WXyT+wkFcLpORHWnKV7+RLOO91xYGEBPXB5uosM4tC/WNwzpXNecVLS3SimSsA6mYCHT2oRrtsFBuJD6ANgTlcwQuzGN4YI++2TmZV0ri1ZCfL+rqHtGhI0Zb8vNwphTBuH6Rs3XV/YqOIPXJnrCUgHcXFddjQf5Mq+hHSprDlNRHeTtgr9P5bUJXVz6rqZFXTk2PM/NXKisGOBYmSF7xn6btHUBbS1WHy6lgXw7WY7txGAuWcVXtB7M+cf+ydMbPdT/A4aN9sYRubexoCwPDQUf1A7nxqWMA7o+VJuCy1STPMfJPdpwzzLaygqYQmJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rKzSgNF5SOVNjQc3i0WzM4dt3ddgxnUWv+9bSvexRsg=;
 b=TtEf+UPQcv022pHKJaAkMnucAdYLm3R3cv84IKeiZg5bj5ZhNth1c2Dzrh7yVja/O9AYGeahHXOmgosH75kg0MnHfCbSSTkjeNsLNiT63oAu47Mmw5mmzzZfKfiOSlRPREfqzZEKUzkcyTVh4O76uwbuYxqngPxW4fYsjYwF2W/nRfKM8faNl1SswHiflPpYH5IoLLX1LJMJCY6u2SCJ5CS2BXzqvpB2L1U/nkgxYucuY0TuTQOqgUixHdv2DwRzc3e8OB9VfE600kyWCc5aBCtftx2j2KGesNxX82OrG2sDxzx9VbIkmZ34Q3ILxTw4zOYFVtbelBPoNsUCW4sKVg==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PNXPR01MB6947.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:c2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Wed, 5 Mar
 2025 11:57:04 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%7]) with mapi id 15.20.8489.028; Wed, 5 Mar 2025
 11:57:04 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>,
	"andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, "senozhatsky@chromium.org"
	<senozhatsky@chromium.org>, Jonathan Corbet <corbet@lwn.net>, Andrew Morton
	<akpm@linux-foundation.org>, "apw@canonical.com" <apw@canonical.com>,
	"joe@perches.com" <joe@perches.com>, "dwaipayanray1@gmail.com"
	<dwaipayanray1@gmail.com>, "lukas.bulwahn@gmail.com"
	<lukas.bulwahn@gmail.com>
CC: "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>, Hector Martin
	<marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>, Janne Grunau
	<j@jannau.net>, Alyssa Rosenzweig <alyssa@rosenzweig.io>, Asahi Linux Mailing
 List <asahi@lists.linux.dev>
Subject: Re: [PATCH v6] lib/vsprintf: Add support for generic FourCCs by
 extending %p4cc
Thread-Topic: [PATCH v6] lib/vsprintf: Add support for generic FourCCs by
 extending %p4cc
Thread-Index: AQHbixRzcsdGsxY6vkuy3v4oKgAXcrNkdTQA
Date: Wed, 5 Mar 2025 11:57:04 +0000
Message-ID: <11F973B4-D5B5-48F8-B53B-693C8DED5DA1@live.com>
References: <1A03A5B4-93AC-4307-AE6A-4A4C4B7E9472@live.com>
In-Reply-To: <1A03A5B4-93AC-4307-AE6A-4A4C4B7E9472@live.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|PNXPR01MB6947:EE_
x-ms-office365-filtering-correlation-id: 08fb27e7-f46c-44c5-a58b-08dd5bdcd8a3
x-microsoft-antispam:
 BCL:0;ARA:14566002|19110799003|8062599003|461199028|7092599003|8060799006|15080799006|10035399004|102099032|3412199025|440099028|4302099013|1602099012;
x-microsoft-antispam-message-info:
 =?utf-8?B?NE5COGpPaUVsMDlXUVFSY2ROcE9WQTZMYUFBam15anZDc3VtN1lIWVV6TnA1?=
 =?utf-8?B?KzFjaUFDaE4vTlZpT2dRTElxZU5yVHhsS2VDTjBmRGM4UFpwSERUTzRtaFNQ?=
 =?utf-8?B?dXBDUkprVEIxQkhkSU8vcktPS05GWG9RWDN4WTdLWG5rRTlBN2x2VkpHYys2?=
 =?utf-8?B?QktlOUFaTTVwV0J1OEJMdnZYbTJKaEtURXlTQUlqclAxK3U5OUpiZzJGZ2Uz?=
 =?utf-8?B?Y2NUanNwSk9aUzYzVFM3K01aTDg3RlJHN3U0eXlMbHhhOFl4eFRYcitQMEha?=
 =?utf-8?B?bXZlbDZ3VURKa3o1d0plQ1A2dkI2UCszT2pTQWEzVG5IeW0yZlVtUkNmQnZK?=
 =?utf-8?B?NzA0T2tFb2Z2cEdHMEtFbmVmTVkrUGpZMDFpYnJHVHArZC8ranp2VVpRVWZH?=
 =?utf-8?B?bkE5QUtaZlhLV0hvUElRZ1dsNXFSQWNDSGlhYmVOTlhlbjhPUE1RcXNkSEZD?=
 =?utf-8?B?Q25RRDBXTk1SVy9zblVhRnVzcS9YL1RFOFdKa0tLdjBTbWRVQTVDbEk3bFc4?=
 =?utf-8?B?TXZRUG5lREFrY2oyaWVtclBHVS90bkt4R3NtYkhaUEJQdmtkdVlHbDZ5UGp0?=
 =?utf-8?B?WDZrZ1k3Zit2UlNoaWppY0hqU0duSHlBRk12cWNvaVNhZEpUb1hTU2lKMXdM?=
 =?utf-8?B?OFpzY2cwZGZaRXRQbUNRbklRQTcxTk1GT1hLNE5adFRJcjBVOHJyZ1ZCQnZ4?=
 =?utf-8?B?VjVMaWE1Z0wrVllNUFFvZ2tZTGo3VU41QW9qYlpFc0h0SUdBK1ZKbW1pbFo4?=
 =?utf-8?B?L0N1YmNjNXF5QmkzMk5wMk0zR2grN1A0NkVsUUZvQXA4YzQxTVRrUHdCT1pQ?=
 =?utf-8?B?aHZOMnViWlFRM2VTd2htZWNQdGNDeUVRM1piK096NG9HSUMvWVZTMzRlTXBl?=
 =?utf-8?B?eThxS093SlhSMWdUVW16TWhpQXA0WGphd1JMVWZ1U0kvNVJYSTZqb1FFWkU0?=
 =?utf-8?B?cnFRQStCbDdzUnloV0l0azBvNHVYOEFmd2hobHZ5MlJkTTc3R095L1pHSWtK?=
 =?utf-8?B?UFBjZ2RSQmRQVnFHUWtEeU10VjZVOHV2V0g2bExUcHZiOUdjNVJscFd4ZHhj?=
 =?utf-8?B?MVVMc3EybDhPcGgxTnlsaGduYStpN0FCVGJQRmExT0dXblFSdU4yTkhWSkFt?=
 =?utf-8?B?cjBEWGNEd2lacXI0UkovZ0FLWkVaTVFUODZzQXZMeEM3US96VnZ6RWtTTkxU?=
 =?utf-8?B?UzRKWjNDSXdqYXhKVHdvWmVHZjFIZ0txQkM1bi9Dck1iNng5SnFxeUZ0TFdB?=
 =?utf-8?B?Tk4vZDdwak9LK1ZCVHZsVHRsU09UT05ZcjMzSllnME9tbCtkRFNhMlZUdmgz?=
 =?utf-8?B?VVNiT2Jtd0NVZVM2RUdxUms1YlFjYm8wNnR0QmF2TkxCZFJaK2t6YXJETm9Y?=
 =?utf-8?B?cUthWUlkdnY4TUNzZkVPeTU5SW1CYXUrdEJ2RHRKR3hhYUR3S2xRZnRHREw4?=
 =?utf-8?B?cGErNWd0NGFjaG9YZFduMVJhYUlneFdxK2dvRVBvZkdYV2xsNDRuM3VFbHhG?=
 =?utf-8?B?SHg1MjNqRlhiYWgyVFM2dWs1NGpEOEJpYjVBV3MxQk9abzhTT2pqcXM1eGYw?=
 =?utf-8?B?OGNmdWlodTZyNWJpbWxvdDJDa1VSRkpXWHE5UmNzakN2Vi9MSHcwbmprT1E1?=
 =?utf-8?Q?g8X2wfSoTFNZkT3CTaH7PPachJPpdp47sUcovT3djh38=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?R0lKbVgrWFNldSt4N1JLUzN0SGpEd3hsMWhIRkhDZFFvUFFiVUtocWxoVEor?=
 =?utf-8?B?OFFjL2JOc3VuV2lneGFNdVlmNFlJa3BEb0FNWW5RRlRHMGZKZDFaNVdDZk56?=
 =?utf-8?B?d1ZxZmNMQUFOWkRoK0ZweFM0d0VMV093V1J5U3l3eGdrVjdHRjU0dVJiZnB0?=
 =?utf-8?B?aC82OEZGdnZ1WFpmWk4xaTB1a1FVZ0NQY09GcFZ3ZkU3aXJESVBwb05vUG5Z?=
 =?utf-8?B?aWE3ZCt4Q2lCZEQyaG9IL2lZK2drZ0JuaytFVVpXUXIxUTBZRXpzWHRWZlYx?=
 =?utf-8?B?SHhIRXFwckJDRi9RZ0lYV1IvbXBLdUs2S3k1bUlWOUVrMVpISnk0bnVMczYy?=
 =?utf-8?B?TXNmeXdEbmVLU2Fic3RhV1d5MVVxVStRRWNIYzJHYjZ1T29wR21ONlU5M3Bw?=
 =?utf-8?B?TW1BWHNNdUI0UGlLaVpaMlpSc3dpL3Z2YWRZdk9zREZkcklnMFFxUElQYSs5?=
 =?utf-8?B?aGFwQ1dRNWZ2YS9QeXVXc0xQWkR1dExBU3BwbUhEcnB6TTQzYWk3cGFsb1BH?=
 =?utf-8?B?dTF2bzVKcWZUMi9PTkhqTFFvenB3bHdqZXVDRm1Lb2dGOWhPU0F6Nko4TGo3?=
 =?utf-8?B?eURFTm1FQmlIT3g3ODNxbEtaL1JCcm9haHVkWHZSR0J3VGRseGhmVjNBR0dL?=
 =?utf-8?B?L1RrZjZqT2FSV2ltUjloWU0xbFZ0UW5EY2xOclphZ3dnSThVNVdRSk5Eb0Nl?=
 =?utf-8?B?V0RIUS9ka0oySnFGbEVDU2FkSjRCN0Fhc1AxQk9NTzY5cEV0cHFCMWtJc1g3?=
 =?utf-8?B?eks3MHlMbEJTc1FQWTBxUHFMeFNDMHFJbjYzUWl0VWlSdE1NQ3JxNXZZYXpy?=
 =?utf-8?B?K3NRbDR6Mk9UWGxYTUFaRnN0S0JVM3BhVzk0a0ovZ2ZPVVJaZmxkTkZFRDBw?=
 =?utf-8?B?RHdZelNpZTltQ09Zb285MWFOYVQ5ZHVyR1NVUnBoaU9aUlVyRk03NXZ1R0xr?=
 =?utf-8?B?RGJBbVZTa1ErS3ZQbllIQTVGSXdkTnBHMU1qbkJmc21aTDNHRUFjUWRaRyto?=
 =?utf-8?B?aWwxQWt3OHFDemFpM1lhUXBZc1duRHIrWkx2NWhkZElGcVRyTEIwN2grN2NZ?=
 =?utf-8?B?QlU5U2dnUjE2aXora3hydERVUGt5ZVY4WlJOS2ljL3ZzOHlQZ0lTOEh0dk5j?=
 =?utf-8?B?dCt0c0RsVVI5TXQwRTJaWXlNV09qTXgreFJ3VU9QR3VSak9pSXNzOGFMa0Y2?=
 =?utf-8?B?SHhDRWJtMW9oWEI2Y2MxTk8rMEEvZ1dtVnVyWmhTVERjTGFMM2I5aStpUWto?=
 =?utf-8?B?emRrQnIyeUtKK0dJajdrNmZjdlBtd2Q5U2dJOVB5WVRGMHdsM1N3TzVYSVFC?=
 =?utf-8?B?ay96Z0s0V2RLMjJvYkdYcmRrSEVKeTZ3czlSUUZEY2p1Z1h0Z29BTEE3VHRj?=
 =?utf-8?B?aXZRRXQwNlI1RkJ6VGxranFtUjZrUWhQdEM1WjdJWkd2cEozSHhVSCtVVSts?=
 =?utf-8?B?UmR6VTlneUN4VXJkVnRDSVltM1J0WFFrQ05SclJ2b2YxMjFFVEFSTzY5RzVZ?=
 =?utf-8?B?amVhVm5rZXFGT294Z1RTVEVwd01iTEVKN1VIRW9Fb3o4Y0lqdW5DWlFiRU5J?=
 =?utf-8?B?djE4SHdDUDliN0hXdlZKTE9xN1VlcFFKdFZSYnRkaU1vWVJqRllGbmROODB0?=
 =?utf-8?B?WEpUU3ZtTWNOTnpBZlZwd0pJdzhpZGZBVGZSQUNrbVVGU0JLa0t1RkxIbld6?=
 =?utf-8?B?WWJRd3dEYURIUmZxQzV0Tk5IamU1SWV0anNwMWxST3dzc3FsL1Y3L2lrV2Zz?=
 =?utf-8?Q?WH96dqmD+7A01Gt3NEHH1qLBEjI6PnFUMbPvnzR?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <02A51343AB57DF4888F729CA91023480@INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-ae5c4.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 08fb27e7-f46c-44c5-a58b-08dd5bdcd8a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2025 11:57:04.1426
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PNXPR01MB6947

DQoNCj4gT24gMiBNYXIgMjAyNSwgYXQgNzoxMuKAr0FNLCBBZGl0eWEgR2FyZyA8Z2FyZ2FkaXR5
YTA4QGxpdmUuY29tPiB3cm90ZToNCj4gDQo+IEZyb206IEhlY3RvciBNYXJ0aW4gPG1hcmNhbkBt
YXJjYW4uc3Q+DQo+IA0KPiAlcDRjYyBpcyBkZXNpZ25lZCBmb3IgRFJNL1Y0TDIgRm91ckNDcyB3
aXRoIHRoZWlyIHNwZWNpZmljIHF1aXJrcywgYnV0DQo+IGl0J3MgdXNlZnVsIHRvIGJlIGFibGUg
dG8gcHJpbnQgZ2VuZXJpYyA0LWNoYXJhY3RlciBjb2RlcyBmb3JtYXR0ZWQgYXMNCj4gYW4gaW50
ZWdlci4gRXh0ZW5kIGl0IHRvIGFkZCBmb3JtYXQgc3BlY2lmaWVycyBmb3IgcHJpbnRpbmcgZ2Vu
ZXJpYw0KPiAzMi1iaXQgRm91ckNDcyB3aXRoIHZhcmlvdXMgZW5kaWFuIHNlbWFudGljczoNCj4g
DQo+ICVwNGNoIEhvc3QgYnl0ZSBvcmRlcg0KPiAlcDRjbiBOZXR3b3JrIGJ5dGUgb3JkZXINCj4g
JXA0Y2wgTGl0dGxlLWVuZGlhbg0KPiAlcDRjYiBCaWctZW5kaWFuDQo+IA0KPiBUaGUgZW5kaWFu
bmVzcyBkZXRlcm1pbmVzIGhvdyBieXRlcyBhcmUgaW50ZXJwcmV0ZWQgYXMgYSB1MzIsIGFuZCB0
aGUNCj4gRm91ckNDIGlzIHRoZW4gYWx3YXlzIHByaW50ZWQgTVNCeXRlLWZpcnN0ICh0aGlzIGlz
IHRoZSBvcHBvc2l0ZSBvZg0KPiBWNEwvRFJNIEZvdXJDQ3MpLiBUaGlzIGNvdmVycyBtb3N0IHBy
YWN0aWNhbCBjYXNlcywgZS5nLiAlcDRjbiB3b3VsZA0KPiBhbGxvdyBwcmludGluZyBMU0J5dGUt
Zmlyc3QgRm91ckNDcyBzdG9yZWQgaW4gaG9zdCBlbmRpYW4gb3JkZXINCj4gKG90aGVyIHRoYW4g
dGhlIGhleCBmb3JtIGJlaW5nIGluIGNoYXJhY3RlciBvcmRlciwgbm90IHRoZSBpbnRlZ2VyDQo+
IHZhbHVlKS4NCj4gDQo+IFJldmlld2VkLWJ5OiBBbmR5IFNoZXZjaGVua28gPGFuZHJpeS5zaGV2
Y2hlbmtvQGxpbnV4LmludGVsLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogSGVjdG9yIE1hcnRpbiA8
bWFyY2FuQG1hcmNhbi5zdD4NCj4gU2lnbmVkLW9mZi1ieTogQWRpdHlhIEdhcmcgPGdhcmdhZGl0
eWEwOEBsaXZlLmNvbT4NCj4g4oCUDQoNCkZXSVcsIFJhc211cyBoYWQgYWNrZWQgdGhpcyBwYXRj
aCBpbiBteSB2MyBzdWJtaXNzaW9uIFsxXSAsIEkgZm9yZ290IHRvIHB1dCBpdC4gU28sDQoNCkFj
a2VkLWJ5OiBSYXNtdXMgVmlsbGVtb2VzIDxsaW51eEByYXNtdXN2aWxsZW1vZXMuZGs+DQoNClsx
XSBodHRwczovL2xvcmUua2VybmVsLm9yZy9hc2FoaS9DQUt3aUhGaV9ubmd0aHRoMHdaa2FQdmlW
ZVMrOFNXRHRUdzZnSmNEQUhDcWl3WEFHMkFAbWFpbC5nbWFpbC5jb20vDQoNCg0K


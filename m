Return-Path: <linux-kernel+bounces-576357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0E3AA70E39
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 01:26:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 249683AD0B4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 00:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B61CF4A35;
	Wed, 26 Mar 2025 00:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="P2ESlS8O"
Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011037.outbound.protection.outlook.com [52.103.68.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6CE2563
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 00:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742948775; cv=fail; b=qhD/BxzCh+TtvTxmePJ9XhFOhJ4veW+XidRo/Q6yffOe5cd/fTbXaN/V6sRbZ/lDGfaibiLGZFYsDZyB0eCq5+cr7vLvR469ruUdr3tlyJUJxFgeHvL5DDDGsvHEMBxXE3wM/kFZJ47nAKafp6G+aXwWLLjhQ0SY4BUP6kg7PbY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742948775; c=relaxed/simple;
	bh=XqWBWfVotwpaBasisQ1Agz1RZoDOaUH0aXWSOMV99u8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RNgyRyeqi/KtwXPB5hMMEOGoLh7dzn2Lwv2/OiGu3mrGtMLo3mHpOjtHjWCQ4/n3M7tuBcgy1uTKD4kkri+bGQ1PK0+1DbHk+gXHAixSVYbR8TJmd6LUSKEceKD6qkII7y5UbWc7FSNTaNbm1czA7yIMg+ZwesbnrVan2rJcNaQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=P2ESlS8O; arc=fail smtp.client-ip=52.103.68.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K68/UhKkwDfswzFAp2/UnZWqXU0LzDWIzY6YdaE73Sa6ASIkKe4i/0WTroJnvvbMVoQ3CK35rT0tbtrfnkxJohu9D+sBij3Ky4gslCoqBttCW6+koRChYA5g2gGHKfOCYTu7L+SoTzd82O2hVNaDO0/745HgQlzkyAwIMzeoCAIgkKC/rI9xCZSccDV5eEl+XiC5dOSnEazB/WOvdQn5bg5hQEnQRCScF7PfuDt+CHvaHLf4RtSogy72yzQchGR752V5SRVDhPzI9AHA64CkXJg6JlW7LcOM2U62bRvb7rOnzGgeX6AEVNzr/BYAYVU0WfMtKCOtOjZ64wtjuvyr/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XqWBWfVotwpaBasisQ1Agz1RZoDOaUH0aXWSOMV99u8=;
 b=uJppPcT//MyGE/xKcD9cg5Ml2DfdmFTHiJb73uptweTtWxQCjT9r2v/IRGIdaOdHe7zQ7yRt+NiDxEBGKa/phVau4fr1jJy/QubSTUDa2SEUSNIH1BvldJ3KsdJ3Pz9woXsJe0rz0gEgiBfndwC150g9zd6xPaPFC1xIxV2cUpFEljjgaQukrTxMqHUWHBRJVleHW179dLOgyj40eYvvspW/HSxONnXgBFAQ7EocfqKzKyyi11mDK02h7sBCcLXpuR20IfbqLRUcFuncP7a3YJ1LLhThctgUhxM+Opj/aXAtqJSGfSHwLrCzqBIF+1PQd/2tn71Z0oCY0LgdoSEwtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XqWBWfVotwpaBasisQ1Agz1RZoDOaUH0aXWSOMV99u8=;
 b=P2ESlS8OgA2oh07+Xiras/LVO1lboVccdNeIRYUh2iNbpy6WgzJZF3+L+oG7uDWaFXnaq39ruplpDggHVSi5Z4Wk9FioAEopCFpTiHvz5YOTGwc1kvt2v8heHEqiyx/pJWnjZMhqL3bbJrW54bTO8QrunVzFwJ4qm2WMeHLZr4WIOkKWn9YKoq8mtLQCvb4bVbBKR7O1OhpyvDdhmCTsLK4X8TV3yHxFZ2DbR8eUjuHWK6BjacyyaoZ0EiFBi9wqvh0XoTAhW6WyVngDqFgYmaDxb/4aZ06H+kCCJLlOYzz306NmHfpdHKUzEXKVSLp2URYMNHbUBKkDTK2Sf1U8dQ==
Received: from PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:10c::9)
 by PN2PPFB684E5E74.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c04:1::3a3) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 26 Mar
 2025 00:26:08 +0000
Received: from PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::5b05:29d:5646:39aa]) by PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::5b05:29d:5646:39aa%3]) with mapi id 15.20.8534.040; Wed, 26 Mar 2025
 00:26:08 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Kees Cook <kees@kernel.org>
CC: "tamird@gmail.com" <tamird@gmail.com>, Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>, Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>, Rasmus Villemoes
	<linux@rasmusvillemoes.dk>, Sergey Senozhatsky <senozhatsky@chromium.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] printf: add tests for generic FourCCs
Thread-Topic: [PATCH] printf: add tests for generic FourCCs
Thread-Index: AQHblJN29TpfMnJ0tk2R2endOOpYG7OEVL2AgABNcHk=
Date: Wed, 26 Mar 2025 00:26:08 +0000
Message-ID:
 <PN0PR01MB958842137184723FD29694E7B8A62@PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM>
References: <4378DDFE-3263-497A-8364-433DC1984FEE@live.com>
 <202503251247.086BD45C@keescook>
In-Reply-To: <202503251247.086BD45C@keescook>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN0PR01MB9588:EE_|PN2PPFB684E5E74:EE_
x-ms-office365-filtering-correlation-id: b5d6bb7a-47d5-47b5-76be-08dd6bfccdc1
x-microsoft-antispam:
 BCL:0;ARA:14566002|7092599003|6072599003|15080799006|461199028|8060799006|19110799003|8062599003|102099032|1602099012|10035399004|440099028|3412199025|4302099013|34005399003|12091999003;
x-microsoft-antispam-message-info:
 =?utf-8?B?cHd4bmpYendSN3BXUmlnQTcyUEw5alU0YmZIalpHQkR2cFRMbjlhNnVTRm5X?=
 =?utf-8?B?OWN4TXJwem1sRm1HVHNGUnRuSkJ0Nm9taEJmSUpzZ1g4dTZld21JRENJODhw?=
 =?utf-8?B?VU1yNWNoWjcyUCtJZEdOQzJLTUtjYnR6a2RYQWVnd3ZsSFBtYkpPaEMxUG9Y?=
 =?utf-8?B?cDB5eDcxYlhtTnJ5M2RPSmNNWUtSNCsyMWlmcnBiczkvWndKVzhOOHpCUnI4?=
 =?utf-8?B?ZmV2OTlLcERqWkI2TVorQUp4Y1IvZGR0QlBPUWxXSklET2diR1BQMHVWSHo0?=
 =?utf-8?B?c1drSG9jL0tIUVZrb2N0VkFtL0d6TmtRZ0J0RW1PQzRwblFDdHpjZmpaUlRQ?=
 =?utf-8?B?M2VYRVQzT1ExQTlWSTgvMUN2aTBNeFJJcGVSNllBT0hQTHQxeUJhcHdwTTRu?=
 =?utf-8?B?c3owNWpKMHNUajBETkdjcnV4bTFCNlFRcW14cXlaR2I3WnhWOGhFb1lGSDRU?=
 =?utf-8?B?bHNOanVmNE5EbVNONlM2Qm8zK2xHQWpOWWlZbnhKR2VieG14YlF2djNMaWhO?=
 =?utf-8?B?NDdoUGxCK1BkZGs2amFUOHIxdEZvVUxhVTdYL0t6YzZUVldvakJKTVo3Q0JY?=
 =?utf-8?B?RXZDZDNzOWFzY2hZbVFoWUNqaSttTS80WEEzTVRmaDJUOE1meFIwSUJSeGdn?=
 =?utf-8?B?eE84K2hiUUlUazBEZjBnOHFTZ1p3RHpmT1RMWHoreG9PUElwQmtCKzlLM3lI?=
 =?utf-8?B?RDA3bnFxZFJPVDZtd2JDQWRROFdTeGFDNG5ZZHpCV2F5RjcxZnRTUjNMSVlL?=
 =?utf-8?B?dGNQSmVCNmttQ3hTOFZCaEZ0UFZMcTMyYm93TlREUTNSMi9hbjlqTGMrL3J6?=
 =?utf-8?B?NUdDSVJkRzFDM0JKalM4eGRDMVRaN0dzZjNHNS90YmZ6WXNFcWVRRmlOTWpM?=
 =?utf-8?B?YThOOEV3YWFUZ1hScFBIL0NhZ0xwMkpIUXpmcEtncW1BSDB3Q3hab2Vic0JN?=
 =?utf-8?B?dW1ZaE5FRVVQRnNCNnBhaUROUFl0a3dpSFhYdko4RExraEJEbVltZnB6NC96?=
 =?utf-8?B?S3NlOWZVaTVFSzRZQmtTRWlqVEQ5OVhTMHNja0VxbXpsTm5xQ3ladk5FbHJ1?=
 =?utf-8?B?UkdXY2FQblFvSVc2Ukt0UnNjbm1NQUdYNndWK1UrZ0x2NlJRaC9vOU14bW8r?=
 =?utf-8?B?Q0JMM2xqalBWd0c0Myt0aXVBYVdNS3lweThObUhBMlJDalUyb1YwVVJTZVlI?=
 =?utf-8?B?emJGM0RVUUpORUFJU2VCODhDNldrR2drNmZpMTMxSHdJZ0F2Z0JiQjZFN0pz?=
 =?utf-8?B?S0MrMnhvRVZnZktLY1cxdEh0OEd3enRIYlVPbTM4cjdIOHR0UlI4TW91TU9W?=
 =?utf-8?B?UUFhREpwZmw5elBPWWZvb3p0eFFoeXlJMWhudXowZE44NXl3MW52ekNJMUxq?=
 =?utf-8?B?T2UrV0NPWWdRUy92cUFTNnNYd0Z1WjlCS0dzUlFlRXFubW43ZWRMT0d2Rndw?=
 =?utf-8?B?RW5VNGRoTW9ZZkRiV0kybzE3R21NeDROaUFERjJqY1VRUDh1YVVoR0FnMWVG?=
 =?utf-8?B?SW1wNTRWNU84ZUlaUlNwTjZ5NDZuWm5hSDJYMjc0V2lNSWRJZkZ3VVJwTTZm?=
 =?utf-8?B?N3U1RXF4Q3kzK29sRytmZzZIZFVzYWl6SXJBd1h0emlnRmc2Y29kalhxeUVK?=
 =?utf-8?B?SWpSS3RObDkrR1FyK1dKMUVrdlJaSVlmUjZjSjB1TmlndDI2ZC9VZzA2ejlC?=
 =?utf-8?B?ejRFT20wZXI5NWxzSjlQakN0dE5XTHlNZWpTNDlRSzZGY0xvMjVBTEpNNkZ0?=
 =?utf-8?B?Wm4zeEw5ZWNhSDNxOVE5SndzRzJUNVFrSGdNMGNQRm1yNG1tNDdSUVhTZzZh?=
 =?utf-8?B?MlF5NEFSbVpXZWlMUjl4Zz09?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dlc1WTR5LzBjMlFkZU5pUm5uaFBTRWx6a3RnNzRuYXJCcVI3MGRYeGRkRnV4?=
 =?utf-8?B?VTNzYWlSVTQ4eWVDTTFhaU1NNE5jQk85U0EydG92OVcrOVhCNExrYytDWS9S?=
 =?utf-8?B?Qlk4QmcyOGF2NENUd0UwMWVCbVZiM1NOMnpSTWg1UDY2cFQvbklSZEZjZVUv?=
 =?utf-8?B?L0t1OUVRNGplbHlwNDlnUWhIaHpqY29JOWFrZ01sKysxcllkcXVSN21pSytT?=
 =?utf-8?B?eFh4OGNSK3BjekxUMEdQNGxXK3FTQ3g3N0I0SkhMSHI3SWRJMiszUDcwSERJ?=
 =?utf-8?B?Z01wWXpCa3JmVVhnY25MYTVRelZKemJPbGlZZmxidEpkWTIycmxaS01uMk4w?=
 =?utf-8?B?NzdYbFc0ZnJrOEZ4bzROMWRadE9IRWg3TGtzME1hckJXM3lHN1dnMWFQYlBQ?=
 =?utf-8?B?Zmc3NEk2VUpESytpZjh1bTVVVzlhUy9MT3Ztc2dTN3NmYWFqTXJoMWV1ZzZ6?=
 =?utf-8?B?V25rYnovOUQweFY0MW14UU5qdUprL3ZmdXFzamJCa05SSjJyd1FYUk1LYk1N?=
 =?utf-8?B?VTZRcXVxdE5YbDRmekdTa2lzQUE1NTJnUEtuTVY2R1o3Wk41clVrdnM4SlBX?=
 =?utf-8?B?TlR4cGVHSVVzVzRGSXkwOEVaMXlqa2ltY3FsN0hiaHpOSkhhRXhyTTB2dkZL?=
 =?utf-8?B?M0dqWlRBT2poQkpaWU5qWHU1UlhxeUNvbmFZbTlOc2pLRCsvdzkxbkR3cU5m?=
 =?utf-8?B?WkhwdVU0ekZNZ1czc3gxSndwd3RGakJabWprcmlmdU5KSnFzcUZnNXNGc3U5?=
 =?utf-8?B?ellKbGVPYUpNbk9DMVpZMkVxUHgrOHlOMFFJMGJEYmpGTXY2Mk5tWWFMT25x?=
 =?utf-8?B?dnM1eHo1OW1TcHdSSmRZalJkQkZ6ZS8vUGplQThzUFZMdWNZcE1icy8vcG0x?=
 =?utf-8?B?VnNtQUp0MjQreDFwcWhJSVJXa0JhQVprS0lDT0lqZGFHVGVwL3RkeTYrWnpp?=
 =?utf-8?B?UHNiU1NKQkN3OWQ2Zmt3M0hPL0tKVUY0MC9YZTFJTFhYL0Z0Z3RUQTZ5a1ZC?=
 =?utf-8?B?bkgvUFI5RDJyemJOeHZ1d3ZZWE1acWNieDNpZUMvNGQvTzRFMkdtdkhPR3BD?=
 =?utf-8?B?ZFgxb1IxREU5dkViNDZSUTBxSGhVM0RpVXNhMk5NOTF6cFlkV2pJWjd0QVVs?=
 =?utf-8?B?bjNCeFdxT2VDN2hLNGgvZ25ZaGJoNVNHZkRBMWVuN2RTSGN3MUVHQjAyTmxP?=
 =?utf-8?B?YWY4L05jeTh1NU5pSTFxS1E4eW1IaFR2QnhwTVR3WlF3NllmQ01kVGtZakVY?=
 =?utf-8?B?MWhHdHpJWmNCcS9wUFgwOGV6aVptaTBpdEx4a2t0WmU5c1FKR3dPOExXNm14?=
 =?utf-8?B?ZjJWNnlCSy9EQ2EvaTAxWm5NNk5MV1FCQ2lZZXRTa0dXSjgrTm15cHVYTVF3?=
 =?utf-8?B?cjZwZ0J5NWpMbEhaSXBpTEhTRTNTM1ZjeGhndXBHdjV2bVNzU05VelZnNmc1?=
 =?utf-8?B?UFZFUHFxMk1CRXl2b2RmZkc5U2ZQZEp4eGlhT1NnV0haQ0FhWDhsU2Fxak1I?=
 =?utf-8?B?dHhWVEV5enFkYXNhR2dHa3N4WEY4MXY4eFdKMUM5Qm5CeS9WRjlOYkhzNHhk?=
 =?utf-8?B?ZEUvZjZZQUp1TXNsL1VkMlE3T2EvYVJRaCsxRWVSZU05TWpYMDE5UFZJRzZU?=
 =?utf-8?B?Z1lFK1dEamlhcjhJMDRmT1Azb2RVc1BnbU1rdWZKYk52aEJTcmJsbmh2am5p?=
 =?utf-8?B?RXVYWjZabDZDSjFhaU9MRkNSWGpNemVZZEpCYXI2OW1lWG9CNEVhbnIwZFdn?=
 =?utf-8?Q?OJyRYa9I8oje/eREas=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-ae5c4.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: b5d6bb7a-47d5-47b5-76be-08dd6bfccdc1
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2025 00:26:08.4155
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2PPFB684E5E74

DQoNCj4gT24gMjYgTWFyIDIwMjUsIGF0IDE6MTnigK9BTSwgS2VlcyBDb29rIDxrZWVzQGtlcm5l
bC5vcmc+IHdyb3RlOg0KPiANCj4g77u/T24gRnJpLCBNYXIgMTQsIDIwMjUgYXQgMDM6NDU6MDFB
TSArMDAwMCwgQWRpdHlhIEdhcmcgd3JvdGU6DQo+PiBGcm9tOiBBZGl0eWEgR2FyZyA8Z2FyZ2Fk
aXR5YTA4QGxpdmUuY29tPg0KPj4gDQo+PiBGb3JtYXQgc3BlY2lmaWVycyBmb3IgcHJpbnRpbmcg
Z2VuZXJpYyAzMi1iaXQgRm91ckNDcyB3ZXJlIHJlY2VudGx5IGFkZGVkDQo+PiB0byB2c3ByaW50
Zi4gVGhleSBhcmUgZ29pbmcgdGhyb3VnaCB0aGUgRFJNIHRyZWUgYWxvbmd3aXRoIHRoZSBhcHBs
ZXRiZHJtDQo+PiBkcml2ZXIuIFNpbmNlIHRoZSBwcmludGYgdGVzdHMgYXJlIGJlaW5nIGNvbnZl
cnRlZCB0byBrdW5pdCwgdGhpcyBzZXBhcmF0ZQ0KPj4gcGF0Y2ggZm9yIHRoZSB0ZXN0cyBzaG91
bGQgbWFrZSBpdCBlYXNpZXIgdG8gcmViYXNlIHdoZW4gdGhlIG1lcmdlIHdpbmRvdw0KPj4gb3Bl
bnMuDQo+PiANCj4+IExpbms6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2RyaS1kZXZlbC83OUZB
M0Y0MS1GRDdBLTQxRDktODUyQi1EMzI2MDZBRjVFQjRAbGl2ZS5jb20vVC8jdQ0KPj4gU2lnbmVk
LW9mZi1ieTogQWRpdHlhIEdhcmcgPGdhcmdhZGl0eWEwOEBsaXZlLmNvbT4NCj4+IC0tLQ0KPj4g
bGliL3Rlc3RzL3ByaW50Zl9rdW5pdC5jIHwgMzkgKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKystLS0tLS0tDQo+IA0KPiBMaW51cyBoYXMgYXBwbGllZCB0aGUga3VuaXQgL2xpYiBtb3Zl
IHRyZWUsIHNvIHRoaXMgcGF0Y2ggY2FuIGxhbmQgdmlhDQo+IHJlZ3VsYXIgdHJlZXMgbm93LiBX
aG8gc2hvdWxkIHRha2UgaXQ/DQoNCkZvciBzb21lIHJlYXNvbiBEUk0gaGFzIG5vdCB0YWtlbiB1
cCB0aGUgcGF0Y2ggc2V0IHlldCwgZXZlbiBhZnRlciBhcHByb3ZhbHMuDQpJIGFzc3VtZSBpdCdz
IHBhcnRseSBiZWNhdXNlIGdpdGxhYi5mcmVlZGVza3RvcC5vcmcgd2FzIGRvd24gZm9yIGEgd2hv
bGUgd2Vlay4NCk5vdyB0aGF0IG1lcmdlIHdpbmRvdyBpcyBvcGVuLCBJIG15c2VsZiBkdW5ubyB3
aGF0IGlzIGdvbm5hIGhhcHBlbiB3aXRoIHRob3NlIHBhdGNoZXMuDQpBbHNvLCBJIGRvdWJ0IERS
TSB3YW50cyB0byB0YWtlIHRoaXMgdXAgbGF0ZXIuIFNvLCBJIGhhdmUgMiBvcHRpb25zOg0KDQox
LiBKdXN0IHdhaXQgYSBiaXQgbW9yZSwgcHJvYmFibHkgdGlsbCBtZXJnZSB3aW5kb3cgc2V0dGxl
cyBzbyB0aGF0IERSTSBjYW4gdGFrZSB1cCB0aG9zZSBwYXRjaGVzIGFuZCB0aGVuIHlvdSB0YWtl
IHRoaXMgb25lIHVwLg0KMi4gSSdsbCBqdXN0IHNlbmQgeW91IHRoZSBub24gRFJNIHBhdGNoLCBh
bmQgdXBzdHJlYW0gaXQgdmlhIHlvdSBzbyB0aGF0IGF0bGVhc3QgeW91IGNhbiBnZXQgZnJlZS4g
VGhlbi4gSSdsbCB0ZWxsIERSTSB0byBqdXN0IHVwc3RyZWFtIHRoZSBEUk0gcmVsZXZhbnQgcGF0
Y2gsIGFnYWluIGFmdGVyIG1lcmdlIHdpbmRvd3Mgc2V0dGxlcy4gVGhlIHBhdGNoIGlzIGFueXdh
eXMgYSBidWcgZml4LCByYXRoZXIgdGhhbiBzb21ldGhpbmcgbmV3Lg0KDQpDaG9pY2UgaXMgeW91
cnMgOikNCj4gDQo+IC0tDQo+IEtlZXMgQ29vaw0K


Return-Path: <linux-kernel+bounces-186275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2DAC8CC20F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 15:24:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DAB9B214FA
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 13:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C897713E036;
	Wed, 22 May 2024 13:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Ngf8SFm/"
Received: from AUS01-ME3-obe.outbound.protection.outlook.com (mail-me3aus01olkn2171.outbound.protection.outlook.com [40.92.63.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEBF38061B;
	Wed, 22 May 2024 13:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.63.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716384254; cv=fail; b=ZFIo94IP9mcVYhjkcYGdSMHP/a9iYphUQHm9mnQ2BkL/wNKkJKIoYr9Ox+uEQ3CvU3AKAXhu5zJFD1PC0sTuY9789UBHDA+oPhXfSDFIgm+ML5Nxh0TTdRjmAZClV5jqAO9Ao3BUN6eZPKCPbaaL6lnEQg3FIekpoVu3Go76Nqk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716384254; c=relaxed/simple;
	bh=kTcgD9E3zAIZkqNRZ4/dlQmGE/GlOrPKGx8VWanF+CY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NRsYVnPL/ZDpKqIkC6p4Sn1ONzALfSO5bQP8uCBSxhZEup+9gjahFHi2QdaSYlTuZnT3PMMJwLwLbyFBkMxcu04o69sUAsl+LFWK7eY/1D4u0BanIxO0Py2C21Wk04DjJ7Go917TKHI+Q3b+rQfsaJ9GymvO0gUUpesm6us/tao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Ngf8SFm/; arc=fail smtp.client-ip=40.92.63.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k4I5bsc79awvBgw+jTX46gNDFTXTFLlz/4WiBSRmK3SI4SA6IqPziucWL/RjBqI1Vf1qYsy8PZd/skR8UU8jWBpz2CSQ7UHERbUM+AgZiuVx6K7y1ZJmiE4KYFqDo7rsvjm7C6yiptDZGpFmXXPpPXQkaIm58/TKSk1ZlUdGOG9OFPL/Kcn5j8AACwOg+Z0NPGGBsS2i4xdunOfqO5sAWp1z+Xio4CevTDPObCcdUCCGpN5BDcEHXfNBY8jvOWbPE1TjCHCVh0Iwfy0xY3tUGobGC1YXkMg4AdecH4CmQ1RwW3iWE3NDOcFLU3qt/LNplRmsHOjbYTPw5J7ovYHvBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kTcgD9E3zAIZkqNRZ4/dlQmGE/GlOrPKGx8VWanF+CY=;
 b=BfwRpn/3qZdaI68XAwcgXsZ9nfMIYMQJfkQ0wrXw5BHJxZWGpaZ0kue+hHzU9/TO9gBBxHPyi9H4zeCHgf/lFUZgx5NKFW4ucXgI3fUxFoZIteY6e0O8+448ZEk6gVlX4AN57D0qEgkwlVPEUc9s4uZS73ZUqyDSfSzYs394Jl8j51oVdiIJqtP6oy45wqgP72sEEQCHSvMrNxVxIPak2yWo/qdqE2D5gG0uWAwLF9nOtfdbo44eiIB8yF6eVgTFrXpuA6UueT0HSH887QovCWY0wo+bDKt/aJVhuScVQ2pUf1fXGwvoGb8q3y99alULb+HZkRMcAHeICobf5Rx6Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kTcgD9E3zAIZkqNRZ4/dlQmGE/GlOrPKGx8VWanF+CY=;
 b=Ngf8SFm/4FWr66ICMT2wFgnP4Ra3Gu12QSEwFewo7cUFsb2oX2z5VDhgoKIjGonN3j5NsKk05iclp9bGxbu3yGE2WtW/6PYRh/VTg4TPGztspIMsoaJdahkEJWMHpH0pUQVzhNYKgkyLNEJpSgutUzfBX5ERopQTHNwyRYbQ3dySLHzYiwe8TnLyShiSzsYvT8+JK6Pjl1Rq9rPZEuqV82gBDQD9FNYhJeUz3vJ0FIinbGL1H5a5E1f7SanadIa7NTp4R0qKtpOLIp7Fms1kI9U9322oUDk2YM2X3mDGXiyaKAiG9FXk53hGOvX7XQDc2kApc13FfJRwVqg/G2JOoQ==
Received: from ME0P282MB4890.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:228::21)
 by MEYP282MB3482.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:17e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.21; Wed, 22 May
 2024 13:24:08 +0000
Received: from ME0P282MB4890.AUSP282.PROD.OUTLOOK.COM
 ([fe80::d384:a02f:2370:f33e]) by ME0P282MB4890.AUSP282.PROD.OUTLOOK.COM
 ([fe80::d384:a02f:2370:f33e%7]) with mapi id 15.20.7587.035; Wed, 22 May 2024
 13:24:08 +0000
From: Xu Roland <mu001999@outlook.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
CC: "ojeda@kernel.org" <ojeda@kernel.org>, "boqun.feng@gmail.com"
	<boqun.feng@gmail.com>, "rust-for-linux@vger.kernel.org"
	<rust-for-linux@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject:
 =?utf-8?B?5Zue5aSNOiBbUEFUQ0hdIHJ1c3Q6IGtlcm5lbDogbWFrZSBpbXBsX2hhc193?=
 =?utf-8?Q?ork_compatible_with_more_complex_generics?=
Thread-Topic: [PATCH] rust: kernel: make impl_has_work compatible with more
 complex generics
Thread-Index: AQHarENxWIjlBOOAWkqGotVt1EqetLGjMW+AgAAMGeI=
Date: Wed, 22 May 2024 13:24:08 +0000
Message-ID:
 <ME0P282MB489066874E4B485121D8C2D4CCEB2@ME0P282MB4890.AUSP282.PROD.OUTLOOK.COM>
References:
 <ME0P282MB48901A79E405F9CF615FF2F1CCEB2@ME0P282MB4890.AUSP282.PROD.OUTLOOK.COM>
 <CANiq72nz1a2hm0co80er+Xx3F99gjNfc4Xs6Fpp138EPhdU49A@mail.gmail.com>
In-Reply-To:
 <CANiq72nz1a2hm0co80er+Xx3F99gjNfc4Xs6Fpp138EPhdU49A@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn: [5lWc1hZdWKkOXi52BIJL3TFQARp0Lfmg]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ME0P282MB4890:EE_|MEYP282MB3482:EE_
x-ms-office365-filtering-correlation-id: 6e6c8670-9b14-4bb4-3178-08dc7a627618
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199019|1602099003|440099019|3412199016|102099023|3430499023;
x-microsoft-antispam-message-info:
 EDJRTXwJiEMU+l6PwT8k1rnBrKB9v4EVfzljC8LbBOw3epLkKMN+y9q+R5M4g6ANHgv7O+8nnLjtm5c9Y1XuNXGzbPQWsayEGxUHEph7yhv3b+JJgayroHgkpQDKltV0Drm091vvDO7UoBFa/a5OlxSzsC1zXBA/Kz7zrj/3Nt1gMfBrT8/SNWwsgL8DJbahPIM/weaphWvKkZcoudZ0V6kjdwUw78lVxDZmEK8MHGEqvYsCRBglc9BaHV/hTCJ3ePyf4lkeI+4AI30MyNjiDIIaTFYBhS9+ByZFpouCs1fzaXo2L2R3NJQ7yRflpNacze+Ye6GwPGC5/St6eXEZBOk4jbt/IFxWtn+5GzbUotcjltkuLRwLWLTDzWkupTe1i9y2F8wd2qYoRefesDKFrCUxKn3RZ6Z/c864yK5NTzF/jMLNbqkINknUN3n1/3oBORcuen4iG+CjHJnX5vy4zy2gNOtYJ67lBKt3JVwLxbVGigZ+M7SQwIfgE07+hbpf6dd3NtCaVC7JXvl0bIaNPq+7Qldkop1nQ8Zu2yF5+J+8hIIF3cHFB5EiGb4CTet9ollLrM+LuVSE6w92IZ3j35BI5MQlPIRytb2xousDkqIUPlnCtBGHaynoqzINzqYaTtmnx61tIf99rCuFH5yM4+4F7WcB2xu/80OI09iQ6dw=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Q1pDa2s1U0hkNXNkdjh6L1JudFdpcFhyUVRaL1FuUm1xb2dzWnlndnBWbDlu?=
 =?utf-8?B?bDJCT2ZzeWx0ZWZ4UlFIYndYdG5TWDh2RlJ0NUpqVitpd1JtZFNRT1pyVHVJ?=
 =?utf-8?B?STlIK3pLZXBRODF1bndYQ2pneG53R25jeExSdDdNRzc0NWREZHVNZThGUUhj?=
 =?utf-8?B?SklmZDQ2OW9mM2RlMjJJbDRCWlJsR3IzdmNhSElxWkw3aTJEQlFGSjRoaEV2?=
 =?utf-8?B?L1BsYkloeW1za0lnZmpjMnRGZlFlTnZlR0Z4WHBPVWxaNkxjaFpleHNWS0dE?=
 =?utf-8?B?bFpHR3dwRk9sNHZ1M1MzZUU1cndIZFFBQjczUmpKaHYxTXcwZm9zejBGUXhV?=
 =?utf-8?B?Y2djZ2ZoVjF5NU9WVzNhYmdnTkxkSjgrdmxveVRDNHBubWphZVFzWERrdUx0?=
 =?utf-8?B?SUJRYXFOckJHaUFRaWlUYWRSM3JwSlRIZE5YYkRIdURUeG5KTEh0UVhDZUFk?=
 =?utf-8?B?b3JLSGg2Sm9wWllwUTZDRE1sSytDSFJGSHFHZG1vVTdFZGs1WmJFZlF4R3ZG?=
 =?utf-8?B?RTQ4MldsdDVPamNXdXhzOGQ2WlRQYzE5bjN6YjF6NDZBUXFxOVIzUHFNR1FV?=
 =?utf-8?B?MyszV01sMkRISkdIS3M5VHhTUGhzaC8rYjJNcDhBdStkdW8ybUlmTjNUdXNm?=
 =?utf-8?B?WWVwOU1FZGNNbHVRRzRoMGhBc1BOSXBjODRWQngzTkpaazkxQk5nTGJYLytQ?=
 =?utf-8?B?T1RsdmFWYTNnOEJ6UDh6TWp4ekhHQnExMmlZcExyWkgySjJvVVQreWdWbHlC?=
 =?utf-8?B?L3JsbmZIMm9LL0d2ZG90VEpXU2E3SFBmM1dRQjhYSkx1L1U3RFVmY3JPdUpr?=
 =?utf-8?B?UTZlVXNGTmpFczhTOFVPb1VCVEdlbGZqaXZDZWNIK2ZRME5sYm9GaEViN1pX?=
 =?utf-8?B?OEJ3THpuNjhocldJYUZnOEdJeFBFSS9WN09EREw3Ulc5SHBCREpiVUc3YVdH?=
 =?utf-8?B?UnYzYmNURHlZUDZoQUxFTTRyVkk0bCs3K2tCWWhDekZHMG5ETjVtYWlDV2dU?=
 =?utf-8?B?bXlrSkVWbGZSSHZqNm8xM3JqdWZ5bi9XM2Q0MnUzOUcxUUdEVVNxeEJLUTlR?=
 =?utf-8?B?aVhNUHZLTUIrS3l5S1R1Yzc2c3U1SzZyMllwR0c2NkhibVloZ1Q0TVlhcGlN?=
 =?utf-8?B?SWw0N0hPREJPZzliRzQxY2JmQVZLeWZJV3M0WWo2SlZqUG1UK2R1dnVRL2Vr?=
 =?utf-8?B?VVY1d3BDVFdZUC92aURKcmdzM05QdUQzNGEzanJmWDVFemZPdCtGN0JFd3A4?=
 =?utf-8?B?MnJWQWhGcHZyczBNKzBvWk81VlRuN3RmdmN5S1RacTQ5OHFUaWthbmRFVS9Q?=
 =?utf-8?B?YTg2N1NVWXU4RmRhYUJITVJ5d2ZicDBKdEl4WVhqVXFjbGg0ZVkyQTQyeWcv?=
 =?utf-8?B?czdOaWcwa0xhV3U2RmVXbndDQmwwK25hM0NhOVpocXR1dnpQclNKcnJsTFZ4?=
 =?utf-8?B?QUgrZEVCejQ2dVBFd0swOXcxYjJxWjF5QWVRWmFyMWoyc2hLYk5JcGFla0hq?=
 =?utf-8?B?TnpTVHhOdWx6WFVlNW8zT1VKUGRVMW8zbld5T3pyRUUySVZlYTNyaHIrY0ov?=
 =?utf-8?B?QUtxZHZIN1drUTZtekFYUEg5MG9Zcm5LK29kWFp1ZHNYU2RGSy9LYytMc293?=
 =?utf-8?B?RWpqK2lTcEpqT1JGMFRtWHBnS09la2c9PQ==?=
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
X-MS-Exchange-CrossTenant-AuthSource: ME0P282MB4890.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e6c8670-9b14-4bb4-3178-08dc7a627618
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2024 13:24:08.6052
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MEYP282MB3482

TWlndWVsIE9qZWRhIFdyb3RlOg0KPiBUaGUga2VybmVsIHJlcXVpcmVzIGEgImtub3duIGlkZW50
aXR5IiAoaXQgZG9lcyBub3QgYWNjZXB0IGFub255bW91cw0KPiBjb250cmlidXRpb25zKQ0KDQpT
b3JyeSwgSSBzZW50IGFub3RoZXIgZW1haWwgYW5kIHVzZSB0aGUgZm9ybWFsIG5hbWUuDQoNCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCuWPkeS7tuS6ujogTWlndWVs
IE9qZWRhIDxtaWd1ZWwub2plZGEuc2FuZG9uaXNAZ21haWwuY29tPg0K5Y+R6YCB5pe26Ze0OiAy
MDI05bm0NeaciDIy5pelIDIwOjM4DQrmlLbku7bkuro6IG11MDAxOTk5DQrmioTpgIE6IG9qZWRh
QGtlcm5lbC5vcmc7IGJvcXVuLmZlbmdAZ21haWwuY29tOyBydXN0LWZvci1saW51eEB2Z2VyLmtl
cm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCuS4u+mimDogUmU6IFtQQVRD
SF0gcnVzdDoga2VybmVsOiBtYWtlIGltcGxfaGFzX3dvcmsgY29tcGF0aWJsZSB3aXRoIG1vcmUg
Y29tcGxleCBnZW5lcmljcw0KDQpPbiBXZWQsIE1heSAyMiwgMjAyNCBhdCAyOjI34oCvUE0gbXUw
MDE5OTkgPG11MDAxOTk5QG91dGxvb2suY29tPiB3cm90ZToNCj4NCj4gU2lnbmVkLW9mZi1ieTog
bXUwMDE5OTkgPG11MDAxOTk5QG91dGxvb2suY29tPg0KDQpUaGUga2VybmVsIHJlcXVpcmVzIGEg
Imtub3duIGlkZW50aXR5IiAoaXQgZG9lcyBub3QgYWNjZXB0IGFub255bW91cw0KY29udHJpYnV0
aW9ucykgLS0gcGxlYXNlIHNlZQ0KaHR0cHM6Ly9kb2NzLmtlcm5lbC5vcmcvcHJvY2Vzcy9zdWJt
aXR0aW5nLXBhdGNoZXMuaHRtbCNzaWduLXlvdXItd29yay10aGUtZGV2ZWxvcGVyLXMtY2VydGlm
aWNhdGUtb2Ytb3JpZ2luLg0KDQpDaGVlcnMsDQpNaWd1ZWwNCg==


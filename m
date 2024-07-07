Return-Path: <linux-kernel+bounces-243466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B290929677
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 06:15:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F4FC1F21499
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 04:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF97611725;
	Sun,  7 Jul 2024 04:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="kL3rKJfV"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11olkn2068.outbound.protection.outlook.com [40.92.18.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5280EEAF9;
	Sun,  7 Jul 2024 04:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.18.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720325676; cv=fail; b=fiLF4u6J95XIVfPV7bNyPD5QmjFlnJljtyGGPJKCFSN3uLydr61p/Z6AVvTwMTU4Yf3SWFhdwgfoG6udNiCDYXH7scHQz8fnsM++zZZMcA4Tr1/HBsmio6aatRbAXzpUtfAyjPi+MJTrBQR5+zg3NqvBtEU47FVVwrqE+m1X9fk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720325676; c=relaxed/simple;
	bh=Vw898ZTG7cp7zhXo5Tar7JkRJxinCtZN2wXITTfzco0=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=MhAReHRBOca0YCDg1gngzBVe4ImPQdM9hfSVvE3LnSljAEfO5VrwhW6T58rGntJ1NHBCXmn/ANLxO3NXfHwG7p6rLelVTBCCjPmmP2wI3PJ8j6+vNhb4rd/UVnfVs7ScM43BN8NGrFmhz2Khmy6gAx6wEvffuen0dApdky9egCQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=kL3rKJfV; arc=fail smtp.client-ip=40.92.18.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IiQNIHtlddgnoymIcPFAqA4WgOGiqWW8vDNX6vOQ+duYM8gdR17UtYuuzaxcSzLN7Fm69N4v1WHX0FADZonXMEu7dP8II4Z9T1tWEsKpKm4nGzR0jd6QuLKuIchamyaWSFBS45UirucZGDPvRtZkKPzsFCZAXSGZ8efug6jl0Mbz/50HR1PinuBf8ueGwLPByjgUe6hfvf4IkVwxx4wqFG81abVfuf3r/Wh67f5UmGoCHX2anPQ+Pt7B1yoANsnnkpOjTZ79TQdgMTC7KeOj6/coXcscFrSgMpbkBAlvpn30hafd9Y/AR2y1wYa99GIOUVhBxKxYWyCHvS6hSpVbfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vw898ZTG7cp7zhXo5Tar7JkRJxinCtZN2wXITTfzco0=;
 b=fnivZAuE4+hqx7TuidS9obSdz7eLk9Qomb5CamKbdT2QGSQYL8rO5JEt6r01+9ge6vK71s5juF5rqKuaUd79SOtDuds8QsJK0Rqrdw3ZzvU9WJE3O22i2V2jWR4a6qz7goZU8Bl3NbSg3A1WaqiQ0yFM19iRS6nN9wlAUKeUblvncXWefGlEglzU6htF0aiI7eGpxtXqk8+gBtKfn5c1k17Nw9JeMVsi67gvzUkbbgdXGs3KrOPZZSejGbjdpZJ6mPBrSfJQtIwBiQvNyE+cNQw34KP5wuKi4peztcnIGiy31TyJCbI6riPy9YcazjgKglx6wieEvxnWhB0ebJDRsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vw898ZTG7cp7zhXo5Tar7JkRJxinCtZN2wXITTfzco0=;
 b=kL3rKJfVgEMFv2ULCW2aGA+m+kYZeV9jjFbt4IhevlueE3Fe+lK5Dzy/F5U7njxSFeusWeXCziob3SqdlgPpVUMDl44XqCXG7QJmAhWbieih38gX0tf39d/t2RGJbjSBXKPg8oVZOTnqyIxsPbwiOkBftLIxgFe1d1GubTe4dNhlvX+5Pbk6MB4jJscVLnFcoK2MeazleyPIj76/jj1u/z5qiSNCIgApa3vRA4kpY/OA8WuQDC36x1vlE+E2ygqBxUbUC9pOBKq37JoKnRSfvdGRqnwbrejiELPIC9J7LJjShR8HTAVZD1Dv0RSuOzKmPfadYS7Jq5P8hJVy2aOH7Q==
Received: from DM4P223MB0541.NAMP223.PROD.OUTLOOK.COM (2603:10b6:8:b3::14) by
 SJ2P223MB0798.NAMP223.PROD.OUTLOOK.COM (2603:10b6:a03:545::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7741.34; Sun, 7 Jul 2024 04:14:33 +0000
Received: from DM4P223MB0541.NAMP223.PROD.OUTLOOK.COM
 ([fe80::17db:c539:a782:454e]) by DM4P223MB0541.NAMP223.PROD.OUTLOOK.COM
 ([fe80::17db:c539:a782:454e%5]) with mapi id 15.20.7741.033; Sun, 7 Jul 2024
 04:14:33 +0000
From: Gold Side <goldside000@outlook.com>
To: "perex@perex.cz" <perex@perex.cz>, "krzk@kernel.org" <krzk@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
	"linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>
Subject: [PATCH 3/3] Removed extra asterisks from comment beginnings, and
 removed unnecessary comment end
Thread-Topic: [PATCH 3/3] Removed extra asterisks from comment beginnings, and
 removed unnecessary comment end
Thread-Index: AQHa0CLNLEwJ1gY9TkW7FCjanI60LA==
Date: Sun, 7 Jul 2024 04:14:33 +0000
Message-ID:
 <DM4P223MB054192AAFD5EA92A22AC8323F7D92@DM4P223MB0541.NAMP223.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn: [XANzwGdGqlqYlw9VLUykIRMfsHZhlD+e]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4P223MB0541:EE_|SJ2P223MB0798:EE_
x-ms-office365-filtering-correlation-id: b63b65ac-3aee-488e-79f3-08dc9e3b4e3e
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|8060799006|19110799003|102099032|3412199025|440099028;
x-microsoft-antispam-message-info:
 3S0ivoBbetTNebo1nmtzku00SKnRGzAD9Bl+yZi6kv8dOfLtoq/GkCn2QKDQsE7/7+TK8LJvJVYxMGUR7/Wh949XQCznIwlurlOXUZOzU/wEio3AkP65ZA8vcUTGr3xsHxcxs/51VxxG4SaxccminwV21LOX2Se7fuEZ8l6AW74q54RUlJ+UrHnMUSQyno30dBmQgtLDNx4yJpSxttCdpUV0mRpV28YJHgir/dMKEI7hq92u+m78KU3MtpYxfbS47D5fLXROhpIrY8tfOnPxxRLHSUy7jP2NG5kqiAVpRNlqJK5WN3ztmYyH6GTzYC2sbmvkgHvvTvwcpu3Res+hiiMS1s1WwbM4lzWw/UysczyQlLMPvLCkdUPhXYtcIO/EYJMovPaVhG6LIu4SVV6fOLyoFlcmM4n1RLzpQEJ7GDMzQmRvltOuzdu64Ig0BEiS3++6oAD1ngSJDwX3odw6FnZPf1IKFbUySguI10cYqLIRuE667RGkpQaDMstxiwqSrv8UtYkIdyy3qVA9NTHkcGMz3UW6PCWSIPU0immoMdQk4C+2QwQQY3U6+bUmw/h88pORs1ypZTvNND8fgL0+ewo+R3EC3WR7qjyLC+LY4YNi2fo4OjNQf5DjSSMePx3HqqoDmJMJ+yjyZZPs7vbGsg==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NUVUV0pTK08zM3BmUkJDVTdneitUdmhYU2FiZkZKR0t1bDQzclR6cmQ1VGJT?=
 =?utf-8?B?eVc1QjJ5ck9PSTVQNUxJVmZmRURFSkYxWXpzRGtuL3hHejNXUDllNFM1TkVj?=
 =?utf-8?B?MEg4SGZDa1QxempRRFl4YVd6SlQyclN6WWpHVkczaVFhNUZjUURjMnYxK3Rw?=
 =?utf-8?B?YStLWmJBbFRFL2VFZGgwY0REbXB6S3ZDZWtuWTFESjAvQ2xJTUp1R2FMTGQw?=
 =?utf-8?B?M201TVNhSzIzY0VyMzl3bnQreG1rZ2k1VlhKUmtjZzF4N2p5ekdXOFdBdjdH?=
 =?utf-8?B?aFhXaWtjMHpPeHJRTERPQUJpMHNCL0doVmhncXV2bWIzZjhHbDJnbEI5aGQ4?=
 =?utf-8?B?UXR6N2VRSEpDUzBPVFQ1WVM4UVNpMmNGbkJqMTJhVzhHVGR3OUNlVXpjRTJW?=
 =?utf-8?B?MGYxUUJOMzlZNEwyd0hLZ2h3RXZTMENPQlBRWC94VDdtRUlwTGw3MjFvMVZL?=
 =?utf-8?B?SDNyNEZ3TXBWMlY3SDlvYkdpNUNOdTN5S0xibTQveXhIT0YxQ05vYnM3RHlo?=
 =?utf-8?B?OFh3WHRsS3hCdFlabm1tZjd2eEV4cjJKVlFqY0xFWXRGejByQ3FCYnpocjIz?=
 =?utf-8?B?SjZJdXFjb1dwNmVkajBpemk3a0xzM2IwSHJzOW9qQlBwT3lxOGtiTnVlU2dL?=
 =?utf-8?B?bWVYQzVabFJuR1RPOGF4bmhpYmN4a09xUnZRUFNyUmxIOWE1ZXhlMWlwclcv?=
 =?utf-8?B?c3JraElXVmh5L3JOV0hjQzZhMkloZkhkQkxYeE8wSVpnQXhnaUwxVFBlbktR?=
 =?utf-8?B?NENVRjdKanRXM1h6Qzl6ZWJYaUc5enpScGlGVlVTMVVrRGdVOUlPa0hjSTNy?=
 =?utf-8?B?NjRGM0s5dmVLdTZFN3lieStOMTA0VHhsR0xLVlZCanFHVmp0eVhPTFNYdmJI?=
 =?utf-8?B?NjkrQnZyaTJoUmVrRzdOOWpPQWRSb0NkSkJGNDVuZDZPekZvdzN3dU92TVdy?=
 =?utf-8?B?YUNyRlJpS2hLRjg0Z3BmUDI4bm15Z1FuNTlYNTZTamVPanUxTkpxVnBjV0ZT?=
 =?utf-8?B?OC9IaVhtcTAvNzd0T2ZNNkNzV01iRC83MVJEb3NZYWkyVkVnZWp4Vmt5c0Y4?=
 =?utf-8?B?ejlSM1lSMS9ZeGRJNStwMVRNKzN6Rkt2QUhRRGptanVVVVJodjJMaDliZHVy?=
 =?utf-8?B?bXRkZFFRRHZBdUFUSDdCRml0TTFUQkVMK3ZzT28xbEhwdWpiZUJvMFQyaDBF?=
 =?utf-8?B?U29BWEZaN0dIbEhqWFVOZjQrNHllK3JDWTVCS1Z2TXppdk5EdXpTMS9Ybjln?=
 =?utf-8?B?YmZuUVRxKzc3ay94NTRKQ2gveTN6Mk1WMHJHc1Npd0k5ZHEyS0Z3c2tPeW1o?=
 =?utf-8?B?SW5MUncxVUhWTzl0amZoaE05Rmdzd3ArRDJ3OFJxNnhHNTJpZnlIaExMWVZE?=
 =?utf-8?B?OThsNzdTeE1sd1ZSMGZWT2hHcnAyVXYwTUQ3cis1UFYwejErRnhnZXNuY2F5?=
 =?utf-8?B?MVVyRDg3VHIzYi9JSkdOOTlEMHpHVHpwTjZDSldKT0IxQ1ZaUzRQczM2Ym9p?=
 =?utf-8?B?bGVOZldkR21Oa3UzMXlDTVJ5WTVCVU5Lb0NsbjBTbXRQZXd6MjNRc0R6by9v?=
 =?utf-8?B?VTlVMU4wS09tT0xuVVcxR3RsRzBTbk5xVm1OYy8ybjFSTCswc0JwaGRyM0hO?=
 =?utf-8?Q?Mu7U8wbHIMC7ODOO08QvarMkDw/W0D8+Eg6K/qk28XW4=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b63b65ac-3aee-488e-79f3-08dc9e3b4e3e
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2024 04:14:33.2489
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2P223MB0798

RnJvbSAwNzJhNTYyNGNmNjc2MTRhN2Y2NGQ2YmExNTc3M2Y4NWVlNWEyZTFkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTdGV2ZW4gRGF2aXMgPGdvbGRzaWRlMDAwQG91dGxvb2suY29t
PgpEYXRlOiBXZWQsIDMgSnVsIDIwMjQgMTY6MDA6MTUgLTA0MDAKU3ViamVjdDogW1BBVENIIDMv
M10gUmVtb3ZlZCwgbGlrZSwgMzAsMDAwIG1vcmUgdXNlbGVzcyBhc3Rlcmlza3MKCklzIHRoZXJl
IGEgcmVhc29uIGZvciB0aG9zZSBleHRyYSBhc3Rlcmlza3MgdG8gYmUgaW4gdGhlcmU/IFNlZW1z
IHVubmVjZXNzYXJ5LgpTaWduZWQtb2ZmLWJ5OiBTdGV2ZW4gRGF2aXMgPGdvbGRzaWRlMDAwQG91
dGxvb2suY29tPgotLS0KwqBzb3VuZC9zb3VuZF9jb3JlLmMgfCAxMiArKysrKystLS0tLS0KwqAx
IGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdp
dCBhL3NvdW5kL3NvdW5kX2NvcmUuYyBiL3NvdW5kL3NvdW5kX2NvcmUuYwppbmRleCBkODFmZWQx
YzEyMjY5OS4uNmQ0NDZjNWJiOTRhMGYgMTAwNjQ0Ci0tLSBhL3NvdW5kL3NvdW5kX2NvcmUuYwor
KysgYi9zb3VuZC9zb3VuZF9jb3JlLmMKQEAgLTMzMSw3ICszMzEsNyBAQCBzdGF0aWMgdm9pZCBz
b3VuZF9yZW1vdmVfdW5pdChzdHJ1Y3Qgc291bmRfdW5pdCAqKmxpc3QsIGludCB1bml0KQrCoArC
oHN0YXRpYyBzdHJ1Y3Qgc291bmRfdW5pdCAqY2hhaW5zW1NPVU5EX1NURVBdOwrCoAotLyoqCisv
KgrCoCAq4oCC4oCC4oCCcmVnaXN0ZXJfc291bmRfc3BlY2lhbF9kZXZpY2UgLSByZWdpc3RlciBh
IHNwZWNpYWwgc291bmQgbm9kZQrCoCAq4oCC4oCC4oCCQGZvcHM6IEZpbGUgb3BlcmF0aW9ucyBm
b3IgdGhlIGRyaXZlcgrCoCAq4oCC4oCC4oCCQHVuaXQ6IFVuaXQgbnVtYmVyIHRvIGFsbG9jYXRl
CkBAIC00MTgsNyArNDE4LDcgQEAgaW50IHJlZ2lzdGVyX3NvdW5kX3NwZWNpYWwoY29uc3Qgc3Ry
dWN0IGZpbGVfb3BlcmF0aW9ucyAqZm9wcywgaW50IHVuaXQpCsKgCsKgRVhQT1JUX1NZTUJPTChy
ZWdpc3Rlcl9zb3VuZF9zcGVjaWFsKTsKwqAKLS8qKgorLyoKwqAgKuKAguKAguKAgnJlZ2lzdGVy
X3NvdW5kX21peGVyIC0gcmVnaXN0ZXIgYSBtaXhlciBkZXZpY2UKwqAgKuKAguKAguKAgkBmb3Bz
OiBGaWxlIG9wZXJhdGlvbnMgZm9yIHRoZSBkcml2ZXIKwqAgKuKAguKAguKAgkBkZXY6IFVuaXQg
bnVtYmVyIHRvIGFsbG9jYXRlCkBAIC00NDMsNyArNDQzLDcgQEAgRVhQT1JUX1NZTUJPTChyZWdp
c3Rlcl9zb3VuZF9taXhlcik7CsKgICrigILigILigIJpbiBvcGVuIC0gc2VlIGJlbG93LgrCoCAq
LwrCoMKgCi0vKioKKy8qCsKgICrigILigILigIJyZWdpc3Rlcl9zb3VuZF9kc3AgLSByZWdpc3Rl
ciBhIERTUCBkZXZpY2UKwqAgKuKAguKAguKAgkBmb3BzOiBGaWxlIG9wZXJhdGlvbnMgZm9yIHRo
ZSBkcml2ZXIKwqAgKuKAguKAguKAgkBkZXY6IFVuaXQgbnVtYmVyIHRvIGFsbG9jYXRlCkBAIC00
NjYsNyArNDY2LDcgQEAgaW50IHJlZ2lzdGVyX3NvdW5kX2RzcChjb25zdCBzdHJ1Y3QgZmlsZV9v
cGVyYXRpb25zICpmb3BzLCBpbnQgZGV2KQrCoArCoEVYUE9SVF9TWU1CT0wocmVnaXN0ZXJfc291
bmRfZHNwKTsKwqAKLS8qKgorLyoKwqAgKuKAguKAguKAgnVucmVnaXN0ZXJfc291bmRfc3BlY2lh
bCAtIHVucmVnaXN0ZXIgYSBzcGVjaWFsIHNvdW5kIGRldmljZQrCoCAq4oCC4oCC4oCCQHVuaXQ6
IHVuaXQgbnVtYmVyIHRvIGFsbG9jYXRlCsKgICoKQEAgLTQ4Myw3ICs0ODMsNyBAQCB2b2lkIHVu
cmVnaXN0ZXJfc291bmRfc3BlY2lhbChpbnQgdW5pdCkKwqDCoArCoEVYUE9SVF9TWU1CT0wodW5y
ZWdpc3Rlcl9zb3VuZF9zcGVjaWFsKTsKwqAKLS8qKgorLyoKwqAgKuKAguKAguKAgnVucmVnaXN0
ZXJfc291bmRfbWl4ZXIgLSB1bnJlZ2lzdGVyIGEgbWl4ZXIKwqAgKuKAguKAguKAgkB1bml0OiB1
bml0IG51bWJlciB0byBhbGxvY2F0ZQrCoCAqCkBAIC00OTgsNyArNDk4LDcgQEAgdm9pZCB1bnJl
Z2lzdGVyX3NvdW5kX21peGVyKGludCB1bml0KQrCoArCoEVYUE9SVF9TWU1CT0wodW5yZWdpc3Rl
cl9zb3VuZF9taXhlcik7CsKgCi0vKioKKy8qCsKgICrigILigILigIJ1bnJlZ2lzdGVyX3NvdW5k
X2RzcCAtIHVucmVnaXN0ZXIgYSBEU1AgZGV2aWNlCsKgICrigILigILigIJAdW5pdDogdW5pdCBu
dW1iZXIgdG8gYWxsb2NhdGUKwqAgKgo=


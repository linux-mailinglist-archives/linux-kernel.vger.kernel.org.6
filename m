Return-Path: <linux-kernel+bounces-243462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E96AC929669
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 05:13:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 137AD1C20CDD
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 03:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 983816AB6;
	Sun,  7 Jul 2024 03:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="QIFxDONY"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11olkn2038.outbound.protection.outlook.com [40.92.18.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC6E63A9;
	Sun,  7 Jul 2024 03:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.18.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720322020; cv=fail; b=nGiZZg2iL57Wbag5e4ZRAjSkt0+YjH3sE0r2uQxUunlIOaYTaqWgi1bdWsmry9EkXl6pkds+4Kyq60l/klGoigy0pi5P2DvJ5GFT/pWo5vPADvQ0k7VIMlQQiS3XkO/XUgPAB/t6DonNw/zX6XEZjMfn1XykH/Z9vmcAuBhmp8Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720322020; c=relaxed/simple;
	bh=oT3vChwzumuMWjdEi3B8g7B5O45auRVUlsuiJxcJUec=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=RVoyv73CjOlTrnbs0miS8GdP7czOLNynrAkT1z4Ra3Y4+5wsMhOiT+K/0R4E/BEr/2A2gQ0AE+DZkE2ihNRC91V1+H6/E/mxxw03LYto8i2nVIYo6xQxY7NoecaDZKF49suLfzgTgLzWUxCgAkh31u1OSs0MeNrtHTeLBNdwkUY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=QIFxDONY; arc=fail smtp.client-ip=40.92.18.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PJNgiwqoEFEeYCXZscv/djf3l+jt5aJSG2Bw0zy2Ejnif8I7Ll3PP3YzxV7pjP/W7B1MKFp/Ahgg4pgYW8GgPB4TOt7udNX0YiKS3o9bnIEGMuaSheNaU932ZYb30rX+lzFI5rdrBEwABgA6xrwGRklWosaf6hXAMoiSkClTouQVnk0MQ7Ie7m1HAMElq6WqvCSsoRPXszAPMAq21hjSNvt4095s9TsxZ2K4pUkpGGwSBgmvKeXKeyR41YMt5M1ASv7u5DuoXKpGL2EzQ53G1e6of6sJ6g8ukjluoh0il7NwmFU/qyuFvZeF4VIhdM0hSHoEkNG+KjW9T/+WW74jZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U/n+BuipNhvDJfIRb8K6tFLqmjq9pfzOcx4QxO9BJTc=;
 b=AmScxG2/0cX/1/Ik8FMWrXRaj0WBu9jBC/+/OSNeOY5ftPNdU0CfEhp9SV3IZJJvxwu6X9iQ01DfBM8p3QE57bQXiYz1t4t0G539V0qwbA1PweHNgFpi9kvcJqqtCdlnfc6ilNxPZ1TGc8QYF1zxOyktnF/tJ0UGOnAMwKkLOsgbZ5m993uWRqnuTaBiTdtMA51yACbXzfkeWLlX+JaRnftI29LCbTG1qgIhz7DXHfgk/PvEonXeIcO3QY5gMEolN+S8kun23Z12VMzY/jctAXx+ZO54YwLe298peBQflD6s6wR+wfSb21zPs0cb2pkX1GGnxAisiPx4BIK3rWrJww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U/n+BuipNhvDJfIRb8K6tFLqmjq9pfzOcx4QxO9BJTc=;
 b=QIFxDONYhz4lfNC4wWHwCS+2Ac6Ts772oKma8I34TqBeC+ZsAzo2ahxXlhvZ+K2kzWGC97A29WIwxM2iFiaMLJw6ILAQmJRfla+O+ty11jF4EN+XQVVhKq9G9YpLJeAuNcButD78WydTNqV+CRK3EFeDYiou3VPO7hJNN246G4CYZEuybtgn7xHAXQsTMt4E9vDUWXBSKIaQMxSxgeYSC6i5W2i8gqkxUEUyVDKEPNIJpbLq7T9JYTWlCA/5Q/ip9BPYhEGZtnUOeM5wIGyYn+qjUwanukn3k4e8r0/0fryu5lBS7xi1xNenaNsDefry6Wnwke87L7vKv/FIRrJe8g==
Received: from DM4P223MB0541.NAMP223.PROD.OUTLOOK.COM (2603:10b6:8:b3::14) by
 PH7P223MB0644.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:1af::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7741.34; Sun, 7 Jul 2024 03:13:36 +0000
Received: from DM4P223MB0541.NAMP223.PROD.OUTLOOK.COM
 ([fe80::17db:c539:a782:454e]) by DM4P223MB0541.NAMP223.PROD.OUTLOOK.COM
 ([fe80::17db:c539:a782:454e%5]) with mapi id 15.20.7741.033; Sun, 7 Jul 2024
 03:13:36 +0000
From: Gold Side <goldside000@outlook.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
	"linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>
Subject: [PATCH] Removed extra asterisks from comment beginnings, and removed
 unnecessary comment end
Thread-Topic: [PATCH] Removed extra asterisks from comment beginnings, and
 removed unnecessary comment end
Thread-Index: AQHa0Btkk4oR7VhfD0egeUg6XA1G+A==
Date: Sun, 7 Jul 2024 03:13:34 +0000
Message-ID:
 <DM4P223MB0541567CC7F936E69CC200F9F7D92@DM4P223MB0541.NAMP223.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
msip_labels:
x-tmn: [ttalD4UCSaKKnJ/bIQMFP+TTCfzKnsdO]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4P223MB0541:EE_|PH7P223MB0644:EE_
x-ms-office365-filtering-correlation-id: efa0f9f3-9e37-4d1d-81c9-08dc9e32c983
x-microsoft-antispam:
 BCL:0;ARA:14566002|6092099012|461199028|19110799003|850799032|102099032|3412199025|440099028;
x-microsoft-antispam-message-info:
 DKBJurJiirbsTHtW7Ah6l73Uq5gVuk6qom8tc7gNwQJ4xepwmTGBzm21fAYLee8oMV8dZHHwXUakpUaRB0aLh2BLb6Fo1TSqI0t32R26+khmkN4/tlTALLLJYsvs56oZA/uSdQ1EftyV5i2KLBye8Pg7jBxpT8KZfxo3xiVIWJc6utKt5O/sX89+GHN2GDO33ETf4I8prvVIxenfIgs8oDn/4J0IlpMTtMZx7R1mlpuYHBsyMjiE+1v80yVgtB3J3aVAXh6qG/wf5qc5rpn4jq4CsFOpDAEB827AdpEunOgiuu3Lh22zwfnNwawIxAK9pNF5NKDrXUo9ESKo+Y9ZHPpS373YcWDQgL7cL13BURdCV7jJq2YCGB9YDsr6S5eb3K6JsjkqlYxqjXpBBJ0ZiQ==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?iFpxmQSZzXuKKEvULH6CJmknKI/3jbijja4iLymjOUvlehc1OfjZ5966iJ?=
 =?iso-8859-1?Q?FtEOn7VLZMXMGKbnoaGYEz42elpegazqnL3opejSKCuRmLMQLVI4TTy36t?=
 =?iso-8859-1?Q?7f7RO5SHPDygOKTTpjsJ2JkYpBHe79dlRD2qHRYlZ5TlPfjboURW0a67m2?=
 =?iso-8859-1?Q?+zUqW3UKYWY2R9zRGXRCekDgD4r4Q3BtzuA8dbjiSTy3WUaoq2AIwRlRL5?=
 =?iso-8859-1?Q?JOXBr3L1LK4RMcQPZy89e9laakN5tnj9W3r9T4DZwZ2uyfHsY4d4xp6pp0?=
 =?iso-8859-1?Q?ZGuCY6l9kFYnq9l2Mlc4Hf9vtD3YAGPsxpDgkX/E4bkwfut8kgZbDYpCQ8?=
 =?iso-8859-1?Q?XCpvDR7yf3eDwMiPJ37B4HFK81RWYpqsgugUc3kI7XCQ7FVl4joBj2Xe1h?=
 =?iso-8859-1?Q?EFrJsC0hDD0lpvkc2z/ijvXz8/McTO3hjI8SoPLrh4ahGkcdpPswcqSbZT?=
 =?iso-8859-1?Q?2J01EdQ4OG08ajfWDETNCXYWbkV7gtU9r0BtQnLJeAAeJw8lmChfRTSt1u?=
 =?iso-8859-1?Q?OSl6yrckBjZjsqf7ATO8lyAM2VEZ2JsNm6ZzXwt1AXHKz1rm4aQJFJd21N?=
 =?iso-8859-1?Q?7S65lXO67Kh+c+Bko/Fp2npEkLcRWgcPd9pf+OO2pXlrKXLBqJFDeKStff?=
 =?iso-8859-1?Q?TS54thT/CcrhfIHM3FNySGsPnZTs6d4dmCzKSs+JfdPH2UDHjiIrUEfCJH?=
 =?iso-8859-1?Q?2uADEG/r8a9ancmYek+WCpYGQDP3BQFdGWSuD/a6e9eac2GYGNLn0fEokN?=
 =?iso-8859-1?Q?6DBYnrc9Y+mr3wkr0DdTBLetCWmTDP/8YGNUqivN505RjMavvGMpiG46ko?=
 =?iso-8859-1?Q?aJaoI+uatszzINEu0/3ZssdgakD8CIK/2k1RXzntPUSXQp3Ul2FePTKtCF?=
 =?iso-8859-1?Q?3/N1bGSa0SLYSOIG5mVVEDMXZiDP2YEFElknuUbNY3LBGBWI5MhraJQfyM?=
 =?iso-8859-1?Q?PsPsinOWaWE3OUX5GxB6m3vPOD1XGrXXUn4QOU3VD3ojfFKCMTM+9YwEki?=
 =?iso-8859-1?Q?VuOEcBYuKqzzkxjz4i8Se997atT7gIwAWNJTlLGJjZdU1v8e9TmVJ/T8e4?=
 =?iso-8859-1?Q?1Z4ZgwQt4XXWZhUJC+b4DyiaMBjuiXBnkSQl/shMIXaDx1or1qbPaAxplI?=
 =?iso-8859-1?Q?TYH/xZtcB+EHJNJ+BHRJi3nOCbQaMNGFYGI1GE5GBfQgiDY34XPd4lMYaa?=
 =?iso-8859-1?Q?WZH+HawqmXqB6O9Ic3KXe6drFH2AuCUkcKH2/STio+wuxb09LhPSNBMmWX?=
 =?iso-8859-1?Q?GOwEzHh+p8a+Am8RlKRWX0HrbepX99mnd0UXEJWcE=3D?=
Content-Type: multipart/mixed;
	boundary="_002_DM4P223MB0541567CC7F936E69CC200F9F7D92DM4P223MB0541NAMP_"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: efa0f9f3-9e37-4d1d-81c9-08dc9e32c983
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2024 03:13:34.6036
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7P223MB0644

--_002_DM4P223MB0541567CC7F936E69CC200F9F7D92DM4P223MB0541NAMP_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


--_002_DM4P223MB0541567CC7F936E69CC200F9F7D92DM4P223MB0541NAMP_
Content-Type: application/octet-stream; name="903.patch"
Content-Description: 903.patch
Content-Disposition: attachment; filename="903.patch"; size=3442;
	creation-date="Sun, 07 Jul 2024 03:13:29 GMT";
	modification-date="Sun, 07 Jul 2024 03:13:29 GMT"
Content-Transfer-Encoding: base64

RnJvbSAzNTc0ZjA1MTQyMDdmOTYxMGE2OWQ4MmQzZGQwZDAxOGQ2ZGNlNWRkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTdGV2ZW4gRGF2aXMgPGdvbGRzaWRlMDAwQG91dGxvb2suY29t
PgpEYXRlOiBUdWUsIDIgSnVsIDIwMjQgMjI6NTc6MjQgLTA0MDAKU3ViamVjdDogW1BBVENIIDEv
M10gUmVtb3ZlZCBleHRyYSBhc3RlcmlzayBmcm9tIGNvbW1lbnQgYmVnaW5uaW5nCgpJdCBzYXZl
cyBhIGJ5dGUuIEknZCBpbWFnaW5lIGJ5dGVzIGFyZSB2YWx1YWJsZSBpbiBhIHByb2plY3QgbGlr
ZSB0aGlzLgotLS0KIGtlcm5lbC9tb2R1bGUvbWFpbi5jIHwgMiArLQogMSBmaWxlIGNoYW5nZWQs
IDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEva2VybmVsL21vZHVs
ZS9tYWluLmMgYi9rZXJuZWwvbW9kdWxlL21haW4uYwppbmRleCBkMThhOTRiOTczZTEwMi4uMjVl
NDU2ZjQzODFjNzEgMTAwNjQ0Ci0tLSBhL2tlcm5lbC9tb2R1bGUvbWFpbi5jCisrKyBiL2tlcm5l
bC9tb2R1bGUvbWFpbi5jCkBAIC00NTAsNyArNDUwLDcgQEAgYm9vbCBfX2lzX21vZHVsZV9wZXJj
cHVfYWRkcmVzcyh1bnNpZ25lZCBsb25nIGFkZHIsIHVuc2lnbmVkIGxvbmcgKmNhbl9hZGRyKQog
CXJldHVybiBmYWxzZTsKIH0KIAotLyoqCisvKgogICogaXNfbW9kdWxlX3BlcmNwdV9hZGRyZXNz
KCkgLSB0ZXN0IHdoZXRoZXIgYWRkcmVzcyBpcyBmcm9tIG1vZHVsZSBzdGF0aWMgcGVyY3B1CiAg
KiBAYWRkcjogYWRkcmVzcyB0byB0ZXN0CiAgKgoKRnJvbSAzM2RjMGFhMzk3MzkxM2YzMTA4NDBj
YzhmN2Q1ZDU5OWQ1NzNjMjk3IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBTdGV2ZW4g
RGF2aXMgPGdvbGRzaWRlMDAwQG91dGxvb2suY29tPgpEYXRlOiBUdWUsIDIgSnVsIDIwMjQgMjM6
NDM6MTUgLTA0MDAKU3ViamVjdDogW1BBVENIIDIvM10gUmVtb3ZlZCB1bm5lY2Vzc2FyeSBjb21t
ZW50IGVuZAoKSXQgc3RpbGwgd29ya3MgdGhlIHNhbWUgd2l0aG91dCB0aGF0IGNvbW1lbnQgZW5k
LCBzbyB3aHkgaXMgaXQgaW4gdGhlcmU/Ci0tLQogaW5jbHVkZS9tZW1vcnkvcmVuZXNhcy1ycGMt
aWYuaCB8IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigt
KQoKZGlmZiAtLWdpdCBhL2luY2x1ZGUvbWVtb3J5L3JlbmVzYXMtcnBjLWlmLmggYi9pbmNsdWRl
L21lbW9yeS9yZW5lc2FzLXJwYy1pZi5oCmluZGV4IGI4ZmEzMGZkNmI1MDBjLi41OTFkZDg2ZjU1
Zjg3OSAxMDA2NDQKLS0tIGEvaW5jbHVkZS9tZW1vcnkvcmVuZXNhcy1ycGMtaWYuaAorKysgYi9p
bmNsdWRlL21lbW9yeS9yZW5lc2FzLXJwYy1pZi5oCkBAIC0xLDQgKzEsNCBAQAotLyogU1BEWC1M
aWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAgKi8KKy8qIFNQRFgtTGljZW5zZS1JZGVudGlmaWVy
OiBHUEwtMi4wCiAvKgogICogUmVuZXNhcyBSUEMtSUYgY29yZSBkcml2ZXIKICAqCgpGcm9tIDA3
MmE1NjI0Y2Y2NzYxNGE3ZjY0ZDZiYTE1NzczZjg1ZWU1YTJlMWQgTW9uIFNlcCAxNyAwMDowMDow
MCAyMDAxCkZyb206IFN0ZXZlbiBEYXZpcyA8Z29sZHNpZGUwMDBAb3V0bG9vay5jb20+CkRhdGU6
IFdlZCwgMyBKdWwgMjAyNCAxNjowMDoxNSAtMDQwMApTdWJqZWN0OiBbUEFUQ0ggMy8zXSBSZW1v
dmVkLCBsaWtlLCAzMCwwMDAgbW9yZSB1c2VsZXNzIGFzdGVyaXNrcwoKSXMgdGhlcmUgYSByZWFz
b24gZm9yIHRob3NlIGV4dHJhIGFzdGVyaXNrcyB0byBiZSBpbiB0aGVyZT8gU2VlbXMgdW5uZWNl
c3NhcnkuCi0tLQogc291bmQvc291bmRfY29yZS5jIHwgMTIgKysrKysrLS0tLS0tCiAxIGZpbGUg
Y2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3Nv
dW5kL3NvdW5kX2NvcmUuYyBiL3NvdW5kL3NvdW5kX2NvcmUuYwppbmRleCBkODFmZWQxYzEyMjY5
OS4uNmQ0NDZjNWJiOTRhMGYgMTAwNjQ0Ci0tLSBhL3NvdW5kL3NvdW5kX2NvcmUuYworKysgYi9z
b3VuZC9zb3VuZF9jb3JlLmMKQEAgLTMzMSw3ICszMzEsNyBAQCBzdGF0aWMgdm9pZCBzb3VuZF9y
ZW1vdmVfdW5pdChzdHJ1Y3Qgc291bmRfdW5pdCAqKmxpc3QsIGludCB1bml0KQogCiBzdGF0aWMg
c3RydWN0IHNvdW5kX3VuaXQgKmNoYWluc1tTT1VORF9TVEVQXTsKIAotLyoqCisvKgogICoJcmVn
aXN0ZXJfc291bmRfc3BlY2lhbF9kZXZpY2UgLSByZWdpc3RlciBhIHNwZWNpYWwgc291bmQgbm9k
ZQogICoJQGZvcHM6IEZpbGUgb3BlcmF0aW9ucyBmb3IgdGhlIGRyaXZlcgogICoJQHVuaXQ6IFVu
aXQgbnVtYmVyIHRvIGFsbG9jYXRlCkBAIC00MTgsNyArNDE4LDcgQEAgaW50IHJlZ2lzdGVyX3Nv
dW5kX3NwZWNpYWwoY29uc3Qgc3RydWN0IGZpbGVfb3BlcmF0aW9ucyAqZm9wcywgaW50IHVuaXQp
CiAKIEVYUE9SVF9TWU1CT0wocmVnaXN0ZXJfc291bmRfc3BlY2lhbCk7CiAKLS8qKgorLyoKICAq
CXJlZ2lzdGVyX3NvdW5kX21peGVyIC0gcmVnaXN0ZXIgYSBtaXhlciBkZXZpY2UKICAqCUBmb3Bz
OiBGaWxlIG9wZXJhdGlvbnMgZm9yIHRoZSBkcml2ZXIKICAqCUBkZXY6IFVuaXQgbnVtYmVyIHRv
IGFsbG9jYXRlCkBAIC00NDMsNyArNDQzLDcgQEAgRVhQT1JUX1NZTUJPTChyZWdpc3Rlcl9zb3Vu
ZF9taXhlcik7CiAgKglpbiBvcGVuIC0gc2VlIGJlbG93LgogICovCiAgCi0vKioKKy8qCiAgKgly
ZWdpc3Rlcl9zb3VuZF9kc3AgLSByZWdpc3RlciBhIERTUCBkZXZpY2UKICAqCUBmb3BzOiBGaWxl
IG9wZXJhdGlvbnMgZm9yIHRoZSBkcml2ZXIKICAqCUBkZXY6IFVuaXQgbnVtYmVyIHRvIGFsbG9j
YXRlCkBAIC00NjYsNyArNDY2LDcgQEAgaW50IHJlZ2lzdGVyX3NvdW5kX2RzcChjb25zdCBzdHJ1
Y3QgZmlsZV9vcGVyYXRpb25zICpmb3BzLCBpbnQgZGV2KQogCiBFWFBPUlRfU1lNQk9MKHJlZ2lz
dGVyX3NvdW5kX2RzcCk7CiAKLS8qKgorLyoKICAqCXVucmVnaXN0ZXJfc291bmRfc3BlY2lhbCAt
IHVucmVnaXN0ZXIgYSBzcGVjaWFsIHNvdW5kIGRldmljZQogICoJQHVuaXQ6IHVuaXQgbnVtYmVy
IHRvIGFsbG9jYXRlCiAgKgpAQCAtNDgzLDcgKzQ4Myw3IEBAIHZvaWQgdW5yZWdpc3Rlcl9zb3Vu
ZF9zcGVjaWFsKGludCB1bml0KQogIAogRVhQT1JUX1NZTUJPTCh1bnJlZ2lzdGVyX3NvdW5kX3Nw
ZWNpYWwpOwogCi0vKioKKy8qCiAgKgl1bnJlZ2lzdGVyX3NvdW5kX21peGVyIC0gdW5yZWdpc3Rl
ciBhIG1peGVyCiAgKglAdW5pdDogdW5pdCBudW1iZXIgdG8gYWxsb2NhdGUKICAqCkBAIC00OTgs
NyArNDk4LDcgQEAgdm9pZCB1bnJlZ2lzdGVyX3NvdW5kX21peGVyKGludCB1bml0KQogCiBFWFBP
UlRfU1lNQk9MKHVucmVnaXN0ZXJfc291bmRfbWl4ZXIpOwogCi0vKioKKy8qCiAgKgl1bnJlZ2lz
dGVyX3NvdW5kX2RzcCAtIHVucmVnaXN0ZXIgYSBEU1AgZGV2aWNlCiAgKglAdW5pdDogdW5pdCBu
dW1iZXIgdG8gYWxsb2NhdGUKICAqCg==

--_002_DM4P223MB0541567CC7F936E69CC200F9F7D92DM4P223MB0541NAMP_--


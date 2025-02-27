Return-Path: <linux-kernel+bounces-535687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D611A475FA
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 07:31:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 314283B23E9
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 06:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63ED5217F5D;
	Thu, 27 Feb 2025 06:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="sJ/ST2Ti"
Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazolkn19011034.outbound.protection.outlook.com [52.103.67.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421BEBE65;
	Thu, 27 Feb 2025 06:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740637859; cv=fail; b=B5ddbVdtjm3zE3V1SGIYHQo3tgHnYDaSIpLZ+K0El9SHg6eq9dusb5DZL4+HNw0NCIUyPBiNdrRjGMCT1uIPICjxrrt6mur28NRDOPrgMZQ/9KLv0qcpgQTIaM9YY35QZUL21d0CPW8OtoS6NNDIxQ4rYgXt6o0Bn/6NfAXlFzE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740637859; c=relaxed/simple;
	bh=DBYaoJuJb2FLMy8Ul0+MSId3TWjorboVGhlazxhTPxI=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=PgyKDva2PmBpUWKJWfxC65tBggFBAom1L5m5laxHRN7oIO9lYMppVECnseCzR71mAkqT1ikH6kom9EwwkZ8D8LF+jsRQphgq9xoYYG/s8MdbideOcbAcl9fQmG5Fgj08vwbfDAnJhYP/dzgpnvvPJLp+ZqsbkauklYhxb1f1jHc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=sJ/ST2Ti; arc=fail smtp.client-ip=52.103.67.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uACtZywvBhlu/XoiIKUbNdStCG1rLD51kY0DgaAnGJ88aLWNQiEDZl5OdpXXTUuv1CCLIWaRIY9mRJFPwURSuIsKtN/VCp6JmTdrxdx8VVPIG3NHXyqxAso5k9aHadGnZokXvWEwU6T3llUz0GvTU6PgQG11Bt7M+rKiDDQ+uFjvPUXYdEUDMNJ9JwCZov4GhtI3Sio3BKjkbe+czcRLJowjb7HcFUV6pnMkma5g/JZHEiFJ/G/sfmo3Gh8luk+axMT4eQJhLJHxd74tCHLfcAv1O22rQTJlN5LiwPfnRpl1XiQDLDOdp9wyCWOMOMx90eU+2IOp0yHLSu+K3R4Ucw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lcLDrcYi06qNpJI7ZbVzo7ziCxcDZ8a40gbN1gk57Ng=;
 b=UnkkP2O6THchS9jRBdy9crFMH3KEgDqgDKlnbil2RtVCUY39NV/FDDWRaq0KWmyGLDuLkJfkJEJ1dXyqfvSJrn8d8R8QfazZAS27Yymqx59hbl2lz7IqX9YfZINOQaH4ZauVh+W3vQbgXmMG/EX6XHthdqLyyvLeh/kgXdG3U1790Oy9e2QYglEiLvGGcMcY4kSEIlGvwC59TzIteM1OIQmkFMSzV2br2yM1E7Hx9tog43RhOqM0YSKPhePnfCCv3RqCruBlzvDHAC/1YIwKaxd2TB20SJbw3aM+Du/bAaJulsPcIq5GKrYawoiLVACbl253i0uPJPDNp07Fl5SXoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lcLDrcYi06qNpJI7ZbVzo7ziCxcDZ8a40gbN1gk57Ng=;
 b=sJ/ST2TiPmexxYBXeDX8IQbIxRdHBByq2NlRCInfExfQCSzcMBK1LlwItn/jXWtie/Ui8/k2WyfqvnH9ee+a/uhmbzCe50aKo4WPSt7rgFBnLiTp0Xb2f9QACQsQYJyCeuv4jynxNFZOkvYQqhhEsxETX9Qgm5vzeTGDiLizTI/dC8Oo6FgBTs9fSTBsxCZ8n6RRGeAwI6ie+hXgxmrSSyY5U4T/o3lSmIo2WV5FsXnktoJPSq9qd/K2oAsJML6L4CqsjHP9pjK3r6qvM3CD+BqCX1Yg8FugVXGVNXciUA8TKYomzfYqookeQ0kwn3J20cYH0fmcm7Xv24PhR52Sew==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN0PR01MB6073.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:68::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Thu, 27 Feb
 2025 06:30:48 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%7]) with mapi id 15.20.8489.021; Thu, 27 Feb 2025
 06:30:48 +0000
From: Aditya Garg <gargaditya08@live.com>
To: "pmladek@suse.com" <pmladek@suse.com>, Steven Rostedt
	<rostedt@goodmis.org>, "andriy.shevchenko@linux.intel.com"
	<andriy.shevchenko@linux.intel.com>, Rasmus Villemoes
	<linux@rasmusvillemoes.dk>, "senozhatsky@chromium.org"
	<senozhatsky@chromium.org>, "corbet@lwn.net" <corbet@lwn.net>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "apw@canonical.com"
	<apw@canonical.com>, "joe@perches.com" <joe@perches.com>,
	"dwaipayanray1@gmail.com" <dwaipayanray1@gmail.com>,
	"lukas.bulwahn@gmail.com" <lukas.bulwahn@gmail.com>
CC: "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Hector Martin
	<marcan@marcan.st>, "sven@svenpeter.dev" <sven@svenpeter.dev>, Janne Grunau
	<j@jannau.net>, "alyssa@rosenzweig.io" <alyssa@rosenzweig.io>, Asahi Linux
 Mailing List <asahi@lists.linux.dev>
Subject: [PATCH v4] lib/vsprintf: Add support for generic FOURCCs by extending
 %p4cc
Thread-Topic: [PATCH v4] lib/vsprintf: Add support for generic FOURCCs by
 extending %p4cc
Thread-Index: AQHbiOEjwrNcQUtqr06OLzayPn0LOw==
Date: Thu, 27 Feb 2025 06:30:48 +0000
Message-ID: <DB7F502D-1477-49C9-A36D-1DEE408ED23C@live.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|PN0PR01MB6073:EE_
x-ms-office365-filtering-correlation-id: b1037f1d-bcf3-45cd-e783-08dd56f8461e
x-microsoft-antispam:
 BCL:0;ARA:14566002|8062599003|19110799003|8060799006|7092599003|15080799006|461199028|3412199025|440099028|41001999003|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?MsiAjc6acS4Wy2WRgBmpMFbdJRojuTHMTKaIkZgsojYf85cVdggiwWC8VuZ2?=
 =?us-ascii?Q?FU/hjxf7e5Ww/HyoSWc843j9M987V4kkFZDHC2w4k2hjpWsMUhpn66VERkA4?=
 =?us-ascii?Q?Y+Gs8R3u/+xeyumdOpklOV8M8rnyZ+s8YA++VJlgWbpi0czo6nGkz1dlmvuB?=
 =?us-ascii?Q?gQb1XT8LXK7DvxFWzNYANC9BJCBL/PYK0bxg307HsCG0k9ntVJxrKaRAgIzU?=
 =?us-ascii?Q?V2Y4xF2HHaJ5RjpmLvW4srKkkocjo0zA0AqOS6lVpKNKN6vW76wuvgOsRlP0?=
 =?us-ascii?Q?cdraQ8ATuGkGnA0fe2FQs0v2YAcDAVydPbsAKM67thJlhCuuanVliJ4XFdSX?=
 =?us-ascii?Q?lnRUnjlj1DXACQ8CUdsYsGbjgT8E5xrmSDjdIcyxBYZ1I0czOqxXKvcX/ln9?=
 =?us-ascii?Q?AilzEMXQyE2JgFgYTpchCcH+FfcVlf8sIQxuPqh1hFOYerSrwnqkS8WEjz8Z?=
 =?us-ascii?Q?qb5PjVB9zRXabc8bkZxOrlKMdDcOA75x8aw79atkXVsQZ54MJ5WqzEoJxu2W?=
 =?us-ascii?Q?+rIrmEEeSy3e7DP6/L8ly951sjGvVguiOk5U2tHO2NvW0MPBFR1enkQ74Bha?=
 =?us-ascii?Q?6EzHCkeEOEJbyj3abUrjDn5OMumg2KwzD7fvR4kWtmAqdY3mRh7mFieNTl+2?=
 =?us-ascii?Q?/s5BjHQ7u2ak50PrKCcuOzZUsV8EECNvqEgcueDQy793wDnTQAM5ubOugAIO?=
 =?us-ascii?Q?+Z5vuDH4n2DyX/WOQiApOR3OQqxEoztpDvgK3YZbG2VWb6b9gWuoaGPoRj51?=
 =?us-ascii?Q?oMWkLdC6pv2C71xKPWTqFZC59QNU++d7eMA8CTYSbWg9FNlMh7UU7Ebvb6Om?=
 =?us-ascii?Q?cXJ56q6sh65FlJwFTp8rNd7g4n/b8yNnRPTgdThu2iJ62FF61jgMaUMv2uhm?=
 =?us-ascii?Q?BdeNn7RjeaxACDc7hmRBWcXBeT6vhIgV92CkGjE6ojvxQE2OrNr+hWQcmwJa?=
 =?us-ascii?Q?1N3S7F3F7vq6xoyC/aLg++P6VYU+1m9MZguCV4ZIAvKcS2vjGR6ftTTwDY+8?=
 =?us-ascii?Q?MtI29JPmY1Qa4eHK18El20VVbjUPAybrpBF5UaKdGuTs9qCxtwPm/Gi/JoEq?=
 =?us-ascii?Q?yof0j3FIjof2DEfhXF8aQ2RSB7kj+9YUAgJYqJwWIRD8Bu2Ks7o=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?wei0IWrXNGloRLLf/Jf8ySni3JqaaC68qsIhMVny3kEf4y6ZDRRtr6IZtJdy?=
 =?us-ascii?Q?D3KV8gqAtj61Lixa30SCVTu3pvXGmGeBNRZsl5Q+DkIBvw43coNZLNpIRQ7I?=
 =?us-ascii?Q?KK/y3+ur/am6U1N5tj7FA2TU+avdsYtgRNE7WxMek8g6vdLTcqDut0Vb0Q8g?=
 =?us-ascii?Q?p2uBbo9HiAgac1YJsv/vjeR0aeeopvQO3Xe4+YySrRfCMqCviuSoqTp5erLK?=
 =?us-ascii?Q?lrBswLloaSAr9I8Gz9TVeUjlknBNZPOWBkSpqaHi9EkBiI/io6VTXtJsHDgM?=
 =?us-ascii?Q?uzbVypeC3zkEZqQQUNm8fZmZ2na1G5ruxrBoPSTtz2+GjIrV7oowXTIgAiNS?=
 =?us-ascii?Q?uBc7N8HL3Ozdy1aha//1dCA71btsm1bsHEZ5n0X3keUtvlkczZ2ul7Dg1RMb?=
 =?us-ascii?Q?ZXSOb8OtBQRt/oR50TfN7u9dFM2OwsKlagpVorYDfBKR51EusVcG9uMFRgf7?=
 =?us-ascii?Q?OsFA0h63Mb5VEYb7gpD4kxKNSI+RyuKCVp2ZgmyAuDCvYc5KPKLI08EXBNi6?=
 =?us-ascii?Q?TgLVjPPEaGUhdOL7qjYzYNJxccKNZbhPDwHhS3c/CYTAJTRCvUlALHPQnNi4?=
 =?us-ascii?Q?kE9mdqvoGDBwXPmeSBpI1LXZSv9UqCBk3Pr8plkkJBsB1c3EnuYn+jvmlH2J?=
 =?us-ascii?Q?hFN+J5MyACVFlgDFJ6xEA5nF79VXETKl7bTofHFEKuPe68N3IoBKgQEu/SRd?=
 =?us-ascii?Q?Ywwektl7e1BP9MyJru44h0ykIjss86ZCZTdP0rOuUU6nTtGm8EYAwblYNYBT?=
 =?us-ascii?Q?CFgxxikHnDgp94XhAWWQgWdK3aGaaDkoxnp4r+974qvbjlH5Aod9pYKrOuW+?=
 =?us-ascii?Q?yzK8D5OZZghfkFUP7oCLCEivactnwDAjiHhK1Ap/doqoYef7Prz9TKXddkqz?=
 =?us-ascii?Q?PUyMidenHvP/BsSeOSjSGPfVxEOROxM+yYcmHdFFEQyIpbkDfGS8827PFhbv?=
 =?us-ascii?Q?7Fjb1ezeM4t9UlohCtzw7pdZ4Bx40PBYX2LpIXNKFh6ycXr44YIk12LiLl8+?=
 =?us-ascii?Q?fXGZhjt+PIGGAb3wSv7t4Y52wrEFeBU5Mf6nJoUJWouPA75Z8Qb03H9PFOsI?=
 =?us-ascii?Q?eUA7aXm94+omMtNpixLouqrk5CmubNHgpQRbwr59idM6/ATyEVyXp4ql21MT?=
 =?us-ascii?Q?ILNHaX0Ju6hGgUrjRQWk2WT/aH57e2dVYlc9H0NtECNuzctg+kjn4P/juGzV?=
 =?us-ascii?Q?jMpTy2S7fS/WekAKOGVbyOI2kLzHmRy4XqhQ/t0zuprPFTJGcGyEXhvvq6e1?=
 =?us-ascii?Q?aGqYI6PsE0EPr8JmxWCv/IFj/pkpRufG/GEUIZQ1sWbgkdgUPxLhYTrKmiIA?=
 =?us-ascii?Q?dvb6izQZFf+pN47121d/5vhF?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <67B98F3697A66A40AD0090B64EE2E5B4@INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b1037f1d-bcf3-45cd-e783-08dd56f8461e
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2025 06:30:48.4486
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0PR01MB6073

From: Hector Martin <marcan@marcan.st>

%p4cc is designed for DRM/V4L2 FOURCCs with their specific quirks, but
it's useful to be able to print generic 4-character codes formatted as
an integer. Extend it to add format specifiers for printing generic
32-bit FOURCCs with various endian semantics:

%p4ch   Host-endian
%p4cl	Little-endian
%p4cb	Big-endian
%p4cr	Reverse-endian

The endianness determines how bytes are interpreted as a u32, and the
FOURCC is then always printed MSByte-first (this is the opposite of
V4L/DRM FOURCCs). This covers most practical cases, e.g. %p4cr would
allow printing LSByte-first FOURCCs stored in host endian order
(other than the hex form being in character order, not the integer
value).

Signed-off-by: Hector Martin <marcan@marcan.st>
Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
v2 ->=20
- Add this patch to appletbdrm patchset

v3 ->
- Make array static

v4 ->
- Fix code error
- Fix sparse warnings
- Make this patch separate from drm

Documentation/core-api/printk-formats.rst | 32 +++++++++++++++++++
lib/test_printf.c                         | 39 +++++++++++++++++++----
lib/vsprintf.c                            | 38 ++++++++++++++++++----
scripts/checkpatch.pl                     |  2 +-
4 files changed, 97 insertions(+), 14 deletions(-)

diff --git a/Documentation/core-api/printk-formats.rst b/Documentation/core=
-api/printk-formats.rst
index ecccc0473..9982861fa 100644
--- a/Documentation/core-api/printk-formats.rst
+++ b/Documentation/core-api/printk-formats.rst
@@ -648,6 +648,38 @@ Examples::
	%p4cc	Y10  little-endian (0x20303159)
	%p4cc	NV12 big-endian (0xb231564e)

+Generic FourCC code
+-------------------
+
+::
+	%p4c[hrbl]	gP00 (0x67503030)
+
+Print a generic FourCC code, as both ASCII characters and its numerical
+value as hexadecimal.
+
+The additional ``h``, ``r``, ``b``, and ``l`` specifiers are used to speci=
fy
+host, reversed, big or little endian order data respectively. Host endian
+order means the data is interpreted as a 32-bit integer and the most
+significant byte is printed first; that is, the character code as printed
+matches the byte order stored in memory on big-endian systems, and is reve=
rsed
+on little-endian systems.
+
+Passed by reference.
+
+Examples for a little-endian machine, given &(u32)0x67503030::
+
+	%p4ch	gP00 (0x67503030)
+	%p4cr	00Pg (0x30305067)
+	%p4cb	00Pg (0x30305067)
+	%p4cl	gP00 (0x67503030)
+
+Examples for a big-endian machine, given &(u32)0x67503030::
+
+	%p4ch	gP00 (0x67503030)
+	%p4cr	00Pg (0x30305067)
+	%p4cb	gP00 (0x67503030)
+	%p4cl	00Pg (0x30305067)
+
Rust
----

diff --git a/lib/test_printf.c b/lib/test_printf.c
index 59dbe4f9a..056929c06 100644
--- a/lib/test_printf.c
+++ b/lib/test_printf.c
@@ -776,21 +776,46 @@ static void __init fwnode_pointer(void)
	software_node_unregister_node_group(group);
}

+struct fourcc_struct {
+	u32 code;
+	const char *str;
+};
+
+static void __init fourcc_pointer_test(const struct fourcc_struct *fc, siz=
e_t n,
+				       const char *fmt)
+{
+	size_t i;
+
+	for (i =3D 0; i < n; i++)
+		test(fc[i].str, fmt, &fc[i].code);
+}
+
static void __init fourcc_pointer(void)
{
-	struct {
-		u32 code;
-		char *str;
-	} const try[] =3D {
+	static const struct fourcc_struct try_cc[] =3D {
		{ 0x3231564e, "NV12 little-endian (0x3231564e)", },
		{ 0xb231564e, "NV12 big-endian (0xb231564e)", },
		{ 0x10111213, ".... little-endian (0x10111213)", },
		{ 0x20303159, "Y10  little-endian (0x20303159)", },
	};
-	unsigned int i;
+	static const struct fourcc_struct try_ch =3D {
+		0x41424344, "ABCD (0x41424344)",
+	};
+	static const struct fourcc_struct try_cr =3D {
+		0x41424344, "DCBA (0x44434241)",
+	};
+	static const struct fourcc_struct try_cl =3D {
+		le32_to_cpu(0x41424344), "ABCD (0x41424344)",
+	};
+	static const struct fourcc_struct try_cb =3D {
+		be32_to_cpu(0x41424344), "ABCD (0x41424344)",
+	};

-	for (i =3D 0; i < ARRAY_SIZE(try); i++)
-		test(try[i].str, "%p4cc", &try[i].code);
+	fourcc_pointer_test(try_cc, ARRAY_SIZE(try_cc), "%p4cc");
+	fourcc_pointer_test(&try_ch, 1, "%p4ch");
+	fourcc_pointer_test(&try_cr, 1, "%p4cr");
+	fourcc_pointer_test(&try_cl, 1, "%p4cl");
+	fourcc_pointer_test(&try_cb, 1, "%p4cb");
}

static void __init
diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 56fe96319..2ac90aba2 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -1781,27 +1781,53 @@ char *fourcc_string(char *buf, char *end, const u32=
 *fourcc,
	char output[sizeof("0123 little-endian (0x01234567)")];
	char *p =3D output;
	unsigned int i;
+	bool pixel_fmt =3D false;
	u32 orig, val;

-	if (fmt[1] !=3D 'c' || fmt[2] !=3D 'c')
+	if (fmt[1] !=3D 'c')
		return error_string(buf, end, "(%p4?)", spec);

	if (check_pointer(&buf, end, fourcc, spec))
		return buf;

	orig =3D get_unaligned(fourcc);
-	val =3D orig & ~BIT(31);
+	switch (fmt[2]) {
+	case 'h':
+		val =3D orig;
+		break;
+	case 'r':
+		orig =3D swab32(orig);
+		val =3D orig;
+		break;
+	case 'l':
+		orig =3D (__force u32)cpu_to_le32(orig);
+		val =3D orig;
+		break;
+	case 'b':
+		orig =3D (__force u32)cpu_to_be32(orig);
+		val =3D orig;
+		break;
+	case 'c':
+		/* Pixel formats are printed LSB-first */
+		val =3D swab32(orig & ~BIT(31));
+		pixel_fmt =3D true;
+		break;
+	default:
+		return error_string(buf, end, "(%p4?)", spec);
+	}

	for (i =3D 0; i < sizeof(u32); i++) {
-		unsigned char c =3D val >> (i * 8);
+		unsigned char c =3D val >> ((3 - i) * 8);

		/* Print non-control ASCII characters as-is, dot otherwise */
		*p++ =3D isascii(c) && isprint(c) ? c : '.';
	}

-	*p++ =3D ' ';
-	strcpy(p, orig & BIT(31) ? "big-endian" : "little-endian");
-	p +=3D strlen(p);
+	if (pixel_fmt) {
+		*p++ =3D ' ';
+		strcpy(p, orig & BIT(31) ? "big-endian" : "little-endian");
+		p +=3D strlen(p);
+	}

	*p++ =3D ' ';
	*p++ =3D '(';
diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 7b28ad331..21516f753 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -6904,7 +6904,7 @@ sub process {
					    ($extension eq "f" &&
					     defined $qualifier && $qualifier !~ /^w/) ||
					    ($extension eq "4" &&
-					     defined $qualifier && $qualifier !~ /^cc/)) {
+					     defined $qualifier && $qualifier !~ /^c[chlbr]/)) {
						$bad_specifier =3D $specifier;
						last;
					}
--=20
2.43.0



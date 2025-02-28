Return-Path: <linux-kernel+bounces-538912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AEC65A49EC9
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 17:29:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 900CC174BC1
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 16:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 554B4274267;
	Fri, 28 Feb 2025 16:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="UdtyQRLV"
Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011027.outbound.protection.outlook.com [52.103.68.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D863271818;
	Fri, 28 Feb 2025 16:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740760162; cv=fail; b=hf3KINm7LhobnlN+uriP4BZDHu1EbUVXG3w19lEGB8pJNbNBeiT9YgNKVmKOIQx16RId4Zw3oF1W2CjsF7ptI/bw/qPpxHaJxWb3IlVlZmDee6NF8k8rinb4u1zOl6LhMmC0YqDgqbVHcAZyadToZOFfMYTZf2egjTW7lw99yMo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740760162; c=relaxed/simple;
	bh=QWHOeDVGuuUKbLaTSurJIPL//WcT1sAslnGcKCWBnQ4=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=JB6PddVxDtjboH/snnMtPQ9ryYhXm2EtsLx/JheU866zf3IONw0Ba+1I5YbEfxi3Pry0P6IwiI9e8ouUv5Q++sSA44ZihZKWReFg5AlRI5XfU47ihkCqGEP3WvA6f7fHZDftr2r7hhzBjXRVNxj6HsmaYCSYrxWvUGPgrfw86uQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=UdtyQRLV; arc=fail smtp.client-ip=52.103.68.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZRwFsEhsLN87XkNMERV0ktA4fboviVBT1Fg8PJP8AgAvRoboBnApg2MmD1v0wGsot1Ui9w05JmVaazk9e+EfJUZeGr0wkHEE9vS1o4vK/6P+9kbvJGGS81oLg/+kfWvY22xUcJq7yeS6CqA4zMEYH/gyP4UaKjKfof1HScp/86xM5NrGwwCIjH+NG383SG6iLMxRyrtWidAYDM5ypR6is8cGi1FtUxoXPg9C+hTOiQzSHX1NCwzn2meNaYwSvXbsxoUGcXIdk/NoWJmcROHZRzUzCKK16Q2S20maxbiMT3PBb2ZKK8p4C3elw96HlrMLyowkKauOKkJH0M2sSksCOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KTHyXNFGxzv8w0IeQIME4PjuBcLWY07Hmko5EUVCg8s=;
 b=pJ/k9x460fmxg1iOJLLhdtoFh1L7ItlN3x9/6ipON9J6wQopY7S5zV9owD9K5dP5vbsPxbfN7Q8uNDS1rfg+2SMpS17snWlvLOSgfd5tP/WbLhavuwDr1EF0DxzAzJEEOI6byWP+6rMO4lW5auMru+/9xLKJ5mSCeH22fqha2223i8837/yHg7ymIzEoV8la+JZRTUZwBLbdX1oNiOy/My5uWKqgZ/E/x2Y5oXTR0iubWUJyigSnR6cnS/qER/c4iuUEpzo91sHF7T25XWLK3vqyQIjxQsHk0BAL/vUecXM0YQ3LGtlXx9kR4xIDiTCHQLGfrxvGjRM80rov4h2XeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KTHyXNFGxzv8w0IeQIME4PjuBcLWY07Hmko5EUVCg8s=;
 b=UdtyQRLV5BD7ia/QUf8fmlKmfeTvanrMerWFV5nnfCxsYnQOGgXYwPR/I2e2e7EvdZZ2PTa6W+0EjmdbF33C/y8bu2lwKqLOMT2kLLtFiDD990BX4E+UeEItaaMfZN8KzWv2Oa/5CIBSS/85itqUEz5aeDCJiNj2s+5SgK9aDGBKeMtsiEHEV7acKP1zy3QoLnkQrf7mUlPYpi9fMnLl2xewWRqllDaGjUQV47CgRo8iyL6pqTBaEsUCqUfc79KuaGsYneRC5h9Nm0h/H7FAv7tdLJPZI8cb3giBshn+XKOlOFKtZtvoDkDY2khzQ0NHg7ulyrwoNg2EYH2lDNLbCg==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MAXPR01MB4215.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Fri, 28 Feb
 2025 16:29:12 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%7]) with mapi id 15.20.8489.021; Fri, 28 Feb 2025
 16:29:12 +0000
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
Subject: [PATCH v5] lib/vsprintf: Add support for generic FourCCs by extending
 %p4cc
Thread-Topic: [PATCH v5] lib/vsprintf: Add support for generic FourCCs by
 extending %p4cc
Thread-Index: AQHbif3m0fVtNIw4P0+tvW5JFWwrTA==
Date: Fri, 28 Feb 2025 16:29:12 +0000
Message-ID: <2C9622E6-A2DB-4681-A971-604C79F9955E@live.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|MAXPR01MB4215:EE_
x-ms-office365-filtering-correlation-id: d062bf87-7c97-49db-55bb-08dd581508f9
x-microsoft-antispam:
 BCL:0;ARA:14566002|8062599003|19110799003|8060799006|461199028|15080799006|7092599003|440099028|3412199025|41001999003|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?IILKdSP7qtssFkqhyWfOWxdek71WyDn5kFSY2TAb1OHcZcxzkEFDysp6vXYe?=
 =?us-ascii?Q?d8iaFuu3szHeot4Rpub4Xws0DDfrrTyHRK8Kz9IxB6IUT3jHzCB9ilbCRwIo?=
 =?us-ascii?Q?28UM9ugSoh2BtOjxej5GQJtEz2Xf5pz5JCk8mDuYtPbgYWBw/xMmnYf2Zpi3?=
 =?us-ascii?Q?OX68E2JViu/gmURhJ9P29Red7cLq7p5bzxtUSp9+utoREqDSBKP0wFIxUqKC?=
 =?us-ascii?Q?1Z0aUpLF1ETQkau/Ye1VHg/DzCE3ize5WyKA+OY1EePp8zWlhaeZnm8/mOo8?=
 =?us-ascii?Q?1QF53/DNdIscBEWLcrg64PwVAaSOkisZIIexGAHhlMw4GqChoI2OMQLiwgfH?=
 =?us-ascii?Q?DFoYu16CC+VF8U3k3SmN6jmnxTgkz6qPOaHpgT5/j+4B+vXVNNUzLhFirSF7?=
 =?us-ascii?Q?Epkc1SLeBNXzYqx9maWwb3BUVbf/TspjIoykFycwhLWId7yJglJmQcbNqfgK?=
 =?us-ascii?Q?t5UHYPv1bdPOQzuCqGwsBoyA2LkuwA550bhetiWHQnCtvpEnJh//v/eL/5Em?=
 =?us-ascii?Q?pL+gWk/WyOni+3+qaPvk1OBYBnbGobR+AWzVDr9zcGJzw15BbfawbefEajwi?=
 =?us-ascii?Q?jkiAYREz7mAA8KR1ojSoscxKKhMN6sIVFTkHo/+7mCd5HDWcpB9IiLbtigOL?=
 =?us-ascii?Q?50xSNr3quAkrbaXJTh+hhZlD+CeH1bfUR9UJRpK5810LzztDhUv8WeKO422+?=
 =?us-ascii?Q?EgCQ83PeHXcsJQcbzpQ4kYXTp4+pPEhfVfO0wO6vvkEYZdzA6rcyGYGwWaBu?=
 =?us-ascii?Q?fhLXcKnZbs4YqNgBbLj0hwHEYNPVv/DWjMZGFCSdYBfNCHNhJWzVcIsVdtEk?=
 =?us-ascii?Q?sSLegDPb8nvDkoovJdGzdnGTWD8nLnHhmVGHm8IO7B4ySz0xzP/N2gQcNapn?=
 =?us-ascii?Q?i9f7MZqjwGkwSw1POY7lAp3UqVMoBzih01m/4HPFnHmeP302fDSpp/TZOCOa?=
 =?us-ascii?Q?vY7vz9OX5xuiBaZnThzDA3tXGbX843HHZqzL2dL6v9+HKM3pKuOE+TfCtcvE?=
 =?us-ascii?Q?2ofd9o1Ku9yV1cmvxqy/7rp7mwfW6Mx78EzZ0mej8GIu/fERAlZKzsWDcKd3?=
 =?us-ascii?Q?puhe43Z+x8fdIGBWxAC2lCDEkJQn0V5ep3cR4l8PrUIfi7/xFIY=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Soq97hkW6JEzgGdRoVDsWKGS+RHL+t2ymOe1xUmw4C+e4NJfWa7hjcbxmoRK?=
 =?us-ascii?Q?IL1RAE9mzz2xtqLW95fuiROAs3utKKO/MwkfsmZ2frx3MEFR9HDJme0M6U33?=
 =?us-ascii?Q?Wgf6rTg45pbQZ7RlRmCvQO90R+JOxni4/XIOtXqBdDVnMHJKP7zA8EjbjsfY?=
 =?us-ascii?Q?94DFMN6SIjo1cYJVSRNfRjrZJwE05tvVEawZ/m4q36E4mdSxXrauWbDmSIN/?=
 =?us-ascii?Q?0RDuRCe1SZL6D6paQFtJ3uDJPyQ5KJxfbItINDxXbjxRvQYalt7vDMP1Ei8q?=
 =?us-ascii?Q?bDsFiYQJEAeGNYtak3y9KpLUUOr5kCNp/TvTzL1Ym6VhIRTs3hOJPfIXcfei?=
 =?us-ascii?Q?8qsOXNrj1+qykO+7AyKUkMRp3cDJUjoRy73/PyGxI+D8Z2URzlpzhMp8jXyY?=
 =?us-ascii?Q?SfRafuBT4ieq5x78RWs3tY3WdenGM2QvppKWabKEeTFQab6q4StlFp9SRXxM?=
 =?us-ascii?Q?yEWseA/2ETGSBzf14Hj/YqjMWK3v9UVFBQUSQcy7OC/0mjL9h8t2eYe6LRzP?=
 =?us-ascii?Q?x2AYzFih8R6392l83XNRfW4Ro6YGqRSDoz5W1R336lHddsFhIJBIwH5yRUHE?=
 =?us-ascii?Q?UQ81BJNB6DApP1MjTca3zSlvOGlrvjeJwAVNz7xwQ6Mgr8B1CxFJLPGmkgIW?=
 =?us-ascii?Q?x40eAyXBn2RmRAelRthbcw4M8mLd0Wwd9dM122a6Wlap/4maNRmWEeNQ0oVR?=
 =?us-ascii?Q?kQsLfiaXKOHLPiG9ojADqdutEMhssSztFV2RDjdSZryGN5iUakFN8CECCrNb?=
 =?us-ascii?Q?0aqB9JLLdkBSE7cl4FkQW5V4vZu59jsEX+F4Itu8jThz478CM0hPvJzZwYxp?=
 =?us-ascii?Q?oyEFHdckq1BU6HI3G0ICz4TTen171IibfIbeg2FRga7TUFDnH8edM7nc7Xyc?=
 =?us-ascii?Q?ROCysDztlj0k2rSK0KLRe/7Qbl1SsC7SplcSfGQVHFUvhm1wEcFJInqBy6DP?=
 =?us-ascii?Q?+/eYBsz0hcuPKiqZp92SVB2NXGizpVPVgcTd/ZaDJ661fyWs3Ml5BtGYh7RY?=
 =?us-ascii?Q?lN5YtC0snQMz5de8FMt0VQqPD0oO+ttWit8kJG+rIBa9n8D1AjqbdmE1BGzf?=
 =?us-ascii?Q?b8JnGyuot1ffUwR6T7Iv75khXyG7VZcXf6BIspS1Ekehja6N3iPA1VQT2LKh?=
 =?us-ascii?Q?z5V5bgHju51ItN19zFimbqp0rAlVZKMogrz2ITRYq3uJRjahe/KWZxh6xCYw?=
 =?us-ascii?Q?iZJZk3Tt8GFj46fQtMcHJyit/ocww8igVOqcnG9ZN2Zi7q0BVXKmeZ4CmICp?=
 =?us-ascii?Q?JC28WxTSiZPmWWuZCtby7MqYYMXAI0T87vhveaklInhopOZm+WamEFau3LMl?=
 =?us-ascii?Q?xZRc8wObJaMoPO4HzPaTmiXX?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2F0D0A33C768F043ACE34F1B9F2ADA1D@INDPRD01.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d062bf87-7c97-49db-55bb-08dd581508f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2025 16:29:12.4076
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAXPR01MB4215

From: Hector Martin <marcan@marcan.st>

%p4cc is designed for DRM/V4L2 FourCCs with their specific quirks, but
it's useful to be able to print generic 4-character codes formatted as
an integer. Extend it to add format specifiers for printing generic
32-bit FourCCs with various endian semantics:

%p4ch	Host-endian
%p4cn	Reverse-endian
%p4cl   Little-endian
%p4cb	Big-endian

The endianness determines how bytes are interpreted as a u32, and the
FourCC is then always printed MSByte-first (this is the opposite of
V4L/DRM FourCCs). This covers most practical cases, e.g. %p4cn would
allow printing LSByte-first FourCCs stored in host endian order
(other than the hex form being in character order, not the integer
value).

Signed-off-by: Hector Martin <marcan@marcan.st>
Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
v2 ->
- Add this patch to appletbdrm patchset

v3 ->
- Make array static

v4 ->
- Fix code error
- Fix sparse warnings
- Make this patch separate from drm

v5 ->
- Improve documentation
- Use better logic to assign value of val
- Use 'n' instead of 'r' for reverse endian
- Use ARRAY_SIZE() instead of hardcoding 1

 Documentation/core-api/printk-formats.rst | 32 +++++++++++++++++++
 lib/test_printf.c                         | 39 +++++++++++++++++++----
 lib/vsprintf.c                            | 35 ++++++++++++++++----
 scripts/checkpatch.pl                     |  2 +-
 4 files changed, 94 insertions(+), 14 deletions(-)

diff --git a/Documentation/core-api/printk-formats.rst b/Documentation/core=
-api/printk-formats.rst
index ecccc0473..14853295a 100644
--- a/Documentation/core-api/printk-formats.rst
+++ b/Documentation/core-api/printk-formats.rst
@@ -648,6 +648,38 @@ Examples::
 	%p4cc	Y10  little-endian (0x20303159)
 	%p4cc	NV12 big-endian (0xb231564e)
=20
+Generic FourCC code
+-------------------
+
+::
+	%p4c[hnlb]	gP00 (0x67503030)
+
+Print a generic FourCC code, as both ASCII characters and its numerical
+value as hexadecimal.
+
+The generic FourCC code is always printed in the big-endian format,
+the most significant byte first. This is the opposite of V4L/DRM FourCCs.
+
+The additional ``h``, ``n``, ``l``, and ``b`` specifiers define what
+endianness is used to load the stored bytes. The data might be interpreted
+using the host-endian, reverse-host-endian, little-endian, or big-endian.
+
+Passed by reference.
+
+Examples for a little-endian machine, given &(u32)0x67503030::
+
+	%p4ch	gP00 (0x67503030)
+	%p4cn	00Pg (0x30305067)
+	%p4cl	gP00 (0x67503030)
+	%p4cb	00Pg (0x30305067)
+
+Examples for a big-endian machine, given &(u32)0x67503030::
+
+	%p4ch	gP00 (0x67503030)
+	%p4cn	00Pg (0x30305067)
+	%p4cl	00Pg (0x30305067)
+	%p4cb	gP00 (0x67503030)
+
 Rust
 ----
=20
diff --git a/lib/test_printf.c b/lib/test_printf.c
index 59dbe4f9a..80d9fd374 100644
--- a/lib/test_printf.c
+++ b/lib/test_printf.c
@@ -776,21 +776,46 @@ static void __init fwnode_pointer(void)
 	software_node_unregister_node_group(group);
 }
=20
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
+		{ 0x41424344, "ABCD (0x41424344)", },
+	};
+	static const struct fourcc_struct try_cn =3D {
+		{ 0x41424344, "DCBA (0x44434241)", },
+	};
+	static const struct fourcc_struct try_cl =3D {
+		{ le32_to_cpu(0x41424344), "ABCD (0x41424344)", },
+	};
+	static const struct fourcc_struct try_cb =3D {
+		{ be32_to_cpu(0x41424344), "ABCD (0x41424344)", },
+	};
=20
-	for (i =3D 0; i < ARRAY_SIZE(try); i++)
-		test(try[i].str, "%p4cc", &try[i].code);
+	fourcc_pointer_test(try_cc, ARRAY_SIZE(try_cc), "%p4cc");
+	fourcc_pointer_test(try_ch, ARRAY_SIZE(try_ch), "%p4ch");
+	fourcc_pointer_test(try_cn, ARRAY_SIZE(try_cn), "%p4cn");
+	fourcc_pointer_test(try_cl, ARRAY_SIZE(try_cl), "%p4cl");
+	fourcc_pointer_test(try_cb, ARRAY_SIZE(try_cb), "%p4cb");
 }
=20
 static void __init
diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 56fe96319..56511a994 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -1781,27 +1781,50 @@ char *fourcc_string(char *buf, char *end, const u32=
 *fourcc,
 	char output[sizeof("0123 little-endian (0x01234567)")];
 	char *p =3D output;
 	unsigned int i;
+	bool pixel_fmt =3D false;
 	u32 orig, val;
=20
-	if (fmt[1] !=3D 'c' || fmt[2] !=3D 'c')
+	if (fmt[1] !=3D 'c')
 		return error_string(buf, end, "(%p4?)", spec);
=20
 	if (check_pointer(&buf, end, fourcc, spec))
 		return buf;
=20
 	orig =3D get_unaligned(fourcc);
-	val =3D orig & ~BIT(31);
+	switch (fmt[2]) {
+	case 'h':
+		break;
+	case 'n':
+		orig =3D swab32(orig);
+		break;
+	case 'l':
+		orig =3D (__force u32)cpu_to_le32(orig);
+		break;
+	case 'b':
+		orig =3D (__force u32)cpu_to_be32(orig);
+		break;
+	case 'c':
+		/* Pixel formats are printed LSB-first */
+		pixel_fmt =3D true;
+		break;
+	default:
+		return error_string(buf, end, "(%p4?)", spec);
+	}
+
+	val =3D pixel_fmt ? swab32(orig & ~BIT(31)) : orig;
=20
 	for (i =3D 0; i < sizeof(u32); i++) {
-		unsigned char c =3D val >> (i * 8);
+		unsigned char c =3D val >> ((3 - i) * 8);
=20
 		/* Print non-control ASCII characters as-is, dot otherwise */
 		*p++ =3D isascii(c) && isprint(c) ? c : '.';
 	}
=20
-	*p++ =3D ' ';
-	strcpy(p, orig & BIT(31) ? "big-endian" : "little-endian");
-	p +=3D strlen(p);
+	if (pixel_fmt) {
+		*p++ =3D ' ';
+		strcpy(p, orig & BIT(31) ? "big-endian" : "little-endian");
+		p +=3D strlen(p);
+	}
=20
 	*p++ =3D ' ';
 	*p++ =3D '(';
diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 7b28ad331..5595a0898 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -6904,7 +6904,7 @@ sub process {
 					    ($extension eq "f" &&
 					     defined $qualifier && $qualifier !~ /^w/) ||
 					    ($extension eq "4" &&
-					     defined $qualifier && $qualifier !~ /^cc/)) {
+					     defined $qualifier && $qualifier !~ /^c[hnlbc]/)) {
 						$bad_specifier =3D $specifier;
 						last;
 					}
--=20
2.43.0



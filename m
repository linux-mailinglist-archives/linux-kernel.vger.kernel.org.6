Return-Path: <linux-kernel+bounces-540163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FB04A4AEAA
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 02:43:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58FEA189498B
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 01:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C2F818EAB;
	Sun,  2 Mar 2025 01:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="SLa9TLL8"
Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010012.outbound.protection.outlook.com [52.103.68.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395FDA31;
	Sun,  2 Mar 2025 01:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740879799; cv=fail; b=qPic7vE6ZgBbVbyKm3mA1aCuucOV8skz4ibdXbnFl51oeP1iuN+m0jUNHM/y8Jng9uvEqWuKOdnkECrRs4EHupbSf0vAaHSjC8MkK4KedE1jgEp4Jrc3NP7uv1cb/bS/Lov1WOvY6toTchCESLXa8TeHQDt59NyLRUWpFLLQce8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740879799; c=relaxed/simple;
	bh=y26SmxpjBQYYty/qbU0d98ay508bK9k+V+YQ6sQ100s=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=CicK0TT9MQG8ZHqmq1Qmg9TbBAh84H70bofok9c102HuWex6DfRH4G6Fhay98KNyCWdcPkvIYr7QayaNGvpgvPqjcUf1ifbbOkJa/r1w3Eiwif3L5O1ChQCVyY3YOfvPgIWHiD1lZDa8irE3/7pjmxxRrrl3BNhSOMN6gbY9YjQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=SLa9TLL8; arc=fail smtp.client-ip=52.103.68.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=poMUw+V4pPIrzo99ZND+tUmH24qG600ovogFYpqIuvAUa7AXmE1ZO1aCXXmk+IZvKBGtEZl5TJSD4mnI/1pm/ixWvTH89Ycv731dYMgIRqtCA09vyGz/tWm2TvGlGKaTTSlg97VgroJbCoeQg2C7DUBmgGrptIJ+B4IIKMeSs4gi6eDz9gKL7jSp2KznbOpjfKLp7o/15UN4LBxVxwHuOK2sTYD5+su+TnLo0KPq73PVwTiJtYmPS65VWSQsb8D6ieHp2S3JTI6b6FrI82F6UmC3zC8jdP2j49gGTh4v++95cFioJVA/TAyYAPqNKsV6Xby9woNsSk349o8oeqH8/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I18/k0/QAOM0yZvx8EtlknGHY7DJpck0VrqLlZQ09D0=;
 b=qbe3HAlJW+OfQ2+BOhGCcLD09whwu80GPNIJoAfbRfI3SI25N4j0WQDXg7CUvCUeGxwnBP7xFA2VVyAfAPKs2Y97agaqqvnPMzfGaKDT+l0d3ACpiPuMP7EyN8FfNEoT1yiTKrJnH4Q/p7t0Woa9tIrBF56oH4zkHOPqZPHd86JlOb1afnhGZrXYqXiZtV8+UtpzhVR8tzJ/lGhW0lHDYWDJFzz1lkOeRf7E724PPABbkzfRlR7TCrGMPB3M6FSKHYJpXSNBTuyf+L4MAMVCabCHXcjmxW1AoN8C7PwIZbK7w6JFIDcP+LEZoWdW+NyCXgIU9TGp/EkdAexVyALq3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I18/k0/QAOM0yZvx8EtlknGHY7DJpck0VrqLlZQ09D0=;
 b=SLa9TLL8n4Tb+xTRU3Ofh8e09q+kB/66t7t1GkifNgC5fCskG8xo47fV6Tna5TWXWHl5b/vZsjl0vRZ1DB/7GYIeV/But1sNqLeuaGxND4FvyCWj1k3Afcyce3utYj1uE7d4VA1Gv2FVObl0mA1RUTtmAiv6/iT981s/pi9jbHIIEnc34NBGLqLtML41Rh995duVKT2KK9wvInsfaQS9/w9XDL1pA93CjGocvTV/MC88sSS2F49oAU1AkMCqCLjuJu8H2ybV6q9byZAh9rmjkX1xuk3Qy0XMbkoNHUcWmCS9aZrQaYY+kbGNl8oHvDTUIBffWNaBOLR8/6a212gyOQ==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN1PPF2C9F37535.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c04:1::40c) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.26; Sun, 2 Mar
 2025 01:43:09 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%7]) with mapi id 15.20.8489.025; Sun, 2 Mar 2025
 01:43:09 +0000
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
Subject: [PATCH v6] lib/vsprintf: Add support for generic FourCCs by extending
 %p4cc
Thread-Topic: [PATCH v6] lib/vsprintf: Add support for generic FourCCs by
 extending %p4cc
Thread-Index: AQHbixRzZz86BudIMkS/mPowpM+2/w==
Date: Sun, 2 Mar 2025 01:43:08 +0000
Message-ID: <1A03A5B4-93AC-4307-AE6A-4A4C4B7E9472@live.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|PN1PPF2C9F37535:EE_
x-ms-office365-filtering-correlation-id: dae2ba1f-59da-4bf1-c932-08dd592b95d6
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799006|8060799006|19110799003|8062599003|461199028|7092599003|3412199025|440099028|41001999003|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?B9iKStvVzrDUHwm/LpAHjmbH4pdTkxACfvJfPPoRVfx55qpRdg8120TwVT2V?=
 =?us-ascii?Q?N9IzYhDnJq/3XBIm23PILmertAqzbeZ54e0NzNG6BUtzZ9Imr/wLv2aSZ2dN?=
 =?us-ascii?Q?gQXrUB8/yrVg76NRvmP5ZeQrknk8Fp/f5BYZULFK8arArccE8XY/cIYj/TCO?=
 =?us-ascii?Q?FBy+fvYw2LNzEfz3k9CuOFAamB+bTsPh0hcAdGTJ57ksUPgv96hcUK01GiNM?=
 =?us-ascii?Q?CkP/RBOxvIZileLVbb8SM9zIqVz7aDNUd958O7A9VDnlOr6MKVnGUQYyw9jh?=
 =?us-ascii?Q?+Saa3MMGcXI/LDT+ybWMpIq6skIJUfqpIl1g5Zw/8PahoXRcDM8WodB3/omW?=
 =?us-ascii?Q?EFt8PSyEZiB+Vv+nYtUwhTd/1zoWBOTKPxnN/bAqnHKrUTv6UTVF1ZKJxfAa?=
 =?us-ascii?Q?Oytkx3Cie5ExCSgqipUZq95Xc+fmYL/kN0j1o5eJ9XeFKhrsVdMvv5y7Gih1?=
 =?us-ascii?Q?PWkX8mwVSdW/obC7yL5YtgQswjRdwI+AYznM02b8V3zFUJNjgmNfX8AUgw3U?=
 =?us-ascii?Q?hdZHMfEYLxtZjNI9L4yi3WiueiAkliTmT4VoUiRkqGYS/lZ5dNLvVxQyxqOS?=
 =?us-ascii?Q?yxLwPvXyaoYrOTWI5IauN9c8MdGqehsIBYdeXrb1iKGKuIRlCyjo2IwrTMAI?=
 =?us-ascii?Q?lIAVFKf9YLSf37OY58HCc7isRyFeciybsjyGuUPnDjlb9MsR2m2aDR425Lpd?=
 =?us-ascii?Q?AlKuZZEuc2YNff1lqr60JSLtWCcOTFTMpIGewwU/cvoIsQYk9Y1UCF+xlhVT?=
 =?us-ascii?Q?2Q22oBMNmud/aYHrWEJHsvP3VP5Zuw3kKtoSRFGJi3nVW5N8CfTFrCuqiyVA?=
 =?us-ascii?Q?t+PhGOxEPglrdbkxPc/dPkukoI1OAzMUo8Iy2bKa29F6e/AS7NlA2MG98bo9?=
 =?us-ascii?Q?W0DpEphBF2MasYAxVnKV4uKlOFJmkc5IPRwxDiUfuuwQ2NkinFXfvGyHzgdz?=
 =?us-ascii?Q?gnQ7BD2BxaMdcCxn0XC0YCgc48B2P6bLh1syp3D4iP4f9Jt1hDDgipKKIpRR?=
 =?us-ascii?Q?wNFw8L19zclJp3ATcPpyzw4qrDxuGRRxkuTm5M7vRqmdy3D89dy/ZRCUsBGw?=
 =?us-ascii?Q?k3j7ZtOY2EURsBSyAPU442NIPkwTcWgRYOFZdavZXGEVoYrEzDM=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?NTI7YRVuPyEOy00+6UQ4R7ap4FOxFdSL5apSP9EZgcu/w5LJxnECgF3ovfeQ?=
 =?us-ascii?Q?2J7+TMVwtZx8ewhWrExbtplch3V8k0tWufXKt2c8b/ApZ66Igwcjyr02bE8k?=
 =?us-ascii?Q?gq/uJ8MKbHHJqWD56go/7gszE5ZuXrXy0tzocVYOLMScaioN1zL+dmxUcw7/?=
 =?us-ascii?Q?LEWfZgWSlzcVIzznHyo2sowAh5xjJ4vk+wWosSot8L72BI9JUTAlHNZa4G99?=
 =?us-ascii?Q?5kAmLmHncv6YVtyf+U1VHdsw+0nn6+xdQTEtI7TW5Bn3SfDScHI50stUHh64?=
 =?us-ascii?Q?sNTpfhCVeiiJk7aXXVNtUnoipteLrV7USQO9pvS45tMXUC3cxzh8SdITuJpb?=
 =?us-ascii?Q?hDmNMKnWgy+QL4D2P3oVlCFhEdegNQHLMRbvBSfK3oP7oM5FOmzxT80aEQl5?=
 =?us-ascii?Q?TgSLOczgBnyM1bLn4EFZsemev10btdhxrGzYHoO6XIMdZT2Bc9i3vBMyflD8?=
 =?us-ascii?Q?f9qMa3aBmJiulvENaIg27knT6dJ/ZK00Uli1DrB7h0iVHvBIlkbYeT48u/H8?=
 =?us-ascii?Q?2TiXsASuGVkFCYoZO4zrf4MmulIjuqf+lb6ZhMMFr37XSzZ/4Nb7RAWsOaE3?=
 =?us-ascii?Q?75c2fQcRBX1A/2fTPuYbNQFqmkHFrTup5K+HJxIX+A4t4rufzd44Z7yzHFzT?=
 =?us-ascii?Q?El+tu3F1mG5t1hJ704U86fKIugbwsvVr5L7xkcxRobVUzG66gCXAj9pkDnnJ?=
 =?us-ascii?Q?29R+PfgiNZMgZGPsMX/MlXCRFJguewysZ8YT8Rc84sxTNmUEORcl4TeRVaE+?=
 =?us-ascii?Q?v/0+WCSy5M7WT0uXKH+RtesS6Cqhumytrrfrgm9qg5igJk1msU5HI4hwS7um?=
 =?us-ascii?Q?pXKePnhAspfyGuaHDKlsYyCNUzhkpyCYzOOT9h540+ijGB9mPmZIABo9axsI?=
 =?us-ascii?Q?K/x+KgSV7OqhHHUrhmvgNW0p3qwKo18a4f4IUxjK2JU0UJLoYAfECzf6i7AF?=
 =?us-ascii?Q?vvGXgNa1pYQoKlbl497MNi2c5UqOeO3je8o/p+166TTv1tH6bsewSuANMDH4?=
 =?us-ascii?Q?eDhgNF7XQcU2b3O7NLnwHAkDLVu1RN6zbgfQNdyzsJIz42eDlQq6gdYQRfiq?=
 =?us-ascii?Q?ASFZb1sKn/m3GlA5LpL9Jw+MxeQUBVJpKhpJP5N5+v2vZ5ccdaVnBsZetXVZ?=
 =?us-ascii?Q?PJfDfbnMuHvfRTeMvMFpXUUeGCL8ZBLRRqq7u03Bf2hK4so6dter7+BcfWFM?=
 =?us-ascii?Q?uZgDz0Mvs/X4UwMw8lbfM0Lm0Kw7mlxF7+UzlEKAs8FkdMlZAayxcad+v9Vk?=
 =?us-ascii?Q?yz1fuecimP5GMvQDogBB2AdC8bEHH1686VoA9qDxTVwAD1tbgp0qco2nP1bw?=
 =?us-ascii?Q?OErF82T7VR8/1G6jmwbrWOn7?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FF2E2D899D4D4E47B9CBD456BFAC7896@INDPRD01.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: dae2ba1f-59da-4bf1-c932-08dd592b95d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2025 01:43:08.8532
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN1PPF2C9F37535

From: Hector Martin <marcan@marcan.st>

%p4cc is designed for DRM/V4L2 FourCCs with their specific quirks, but
it's useful to be able to print generic 4-character codes formatted as
an integer. Extend it to add format specifiers for printing generic
32-bit FourCCs with various endian semantics:

%p4ch	Host byte order
%p4cn	Network byte order
%p4cl	Little-endian
%p4cb	Big-endian

The endianness determines how bytes are interpreted as a u32, and the
FourCC is then always printed MSByte-first (this is the opposite of
V4L/DRM FourCCs). This covers most practical cases, e.g. %p4cn would
allow printing LSByte-first FourCCs stored in host endian order
(other than the hex form being in character order, not the integer
value).

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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

v6 ->
- Replace spaces with tabs
- Add missing []
- Use host byte order and network byte order terms
- Fix sparse warning in test_printf.c

 Documentation/core-api/printk-formats.rst | 32 +++++++++++++++++++
 lib/test_printf.c                         | 39 +++++++++++++++++++----
 lib/vsprintf.c                            | 35 ++++++++++++++++----
 scripts/checkpatch.pl                     |  2 +-
 4 files changed, 94 insertions(+), 14 deletions(-)

diff --git a/Documentation/core-api/printk-formats.rst b/Documentation/core=
-api/printk-formats.rst
index ecccc0473..bd420e8aa 100644
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
+using the host byte order, network byte order, little-endian, or big-endia=
n.
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
index 59dbe4f9a..4019de09e 100644
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
+	static const struct fourcc_struct try_ch[] =3D {
+		{ 0x41424344, "ABCD (0x41424344)", },
+	};
+	static const struct fourcc_struct try_cn[] =3D {
+		{ 0x41424344, "DCBA (0x44434241)", },
+	};
+	static const struct fourcc_struct try_cl[] =3D {
+		{ (__force u32)cpu_to_le32(0x41424344), "ABCD (0x41424344)", },
+	};
+	static const struct fourcc_struct try_cb[] =3D {
+		{ (__force u32)cpu_to_be32(0x41424344), "ABCD (0x41424344)", },
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
2.47.1



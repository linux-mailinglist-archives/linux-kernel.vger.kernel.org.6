Return-Path: <linux-kernel+bounces-560659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7784AA607D7
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 04:45:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 119157AA321
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 03:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A299F61FFE;
	Fri, 14 Mar 2025 03:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="MR4DOxSE"
Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazolkn19011033.outbound.protection.outlook.com [52.103.67.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA79F13B2B8
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 03:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741923909; cv=fail; b=u36uTOflXgOglYXIRgQYvA0Gdx3wzLEvqITFJ/KiJ8ELa70BQ8TfdoEmUJs79gAS8VMOiIcsOCfWrruDUgwnv1Ko3GwhWAsfGCXQ2EAH0170SdLpy4+IRZBxjwd5FLAoYufB5QRNWZRpTk8eimILms5zR9ghSgyCJM5oytQMLuQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741923909; c=relaxed/simple;
	bh=obyI+LG3Axsm7TgkpRY2n6Xvfp3evfBz3qnS1LXTs2A=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=NUBshpk7GKNX7+KIsyliGT8Gqd3RH72UBG8TrTi07Z0KC+Tc62md/t5NgwIqkUmdKKIdKYdg1EXufoKstyyabS9fDskP5s+xoDMAE0WmE8s5lK43IBNS5pwjRq/U9WAhnXXgUqE/fxrzkwxuRDGrqP+Mn2EnJQWYKmIlReRNPAA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=MR4DOxSE; arc=fail smtp.client-ip=52.103.67.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t7S5nvAFKFZ4kz59XCcuyg9dY4mv0+FHroa9lbgaZIDB0y4HdLul8e4ra4zWtRiNGpnqbSSE/fIovELhuMve1KokDGzYirmmRsfkq0HYYWfiy6ywmFc9baWbNpVKcM/8hnQy/dNuO6FxYdWdQDWNQ1AtGojKCKmTfTRZSRDLgArT9x32DLUTWoKkOON43oDR5/s7gBi0t11HrMocr2N7MfjLjkxNwObDLBeVxKCo2wR/e0q+T63DH4n7RQLjmKHGcFJuwrlWRLcwM2d6FkYu5zBHXimMINd1sCbEHqOE6vWlyizZzjFhxLtXhyZejgekWmZUkXUcwOhUf4Ws6l/GrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CcQsxj62tTGe6X6se7W3jD7oUGRDVByqz8NWnj5lqkQ=;
 b=vqXlSc5qFLkmFWZ3rf2JdcYfU3CM5gFxCrjihdFocplqDOFAKnteD3VUMwHUVY1pARkK9L2EEZ08whD4RIEyff/t6a7KVxrn2jm8kTBRgjlp0vN9lphg5Yfnn1E1Xdo0x5PqpAAj1jhoToD3zMoYnxX9Vh1nXM81aZed9kNG7bwQhHSp6TQ8ljRZ/pxzck9cLfT9Q94h8QTH1NEF9a5fHnauTHlba8VaO1JYXNUdNqYTNYEijajpf6wFhTvnN4RpROiU/7mhNS383mMhx0bpgJ13fN/uVdlxouAPoh7oB3esnxSrUakZCP4SJ/nPl8RzVjT7bjaNn5D2Sp8fVSJ10g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CcQsxj62tTGe6X6se7W3jD7oUGRDVByqz8NWnj5lqkQ=;
 b=MR4DOxSEKgYgVHSXdptA6aXdv7TVpuN30o9eKuvEUyDroGc8LD776xW7Oiutd2PA5C8f/gbA2iRWRyCN4+B+8cE9pIpVNKmm4mQLSQhGOwKEDWuyhycT2S5lt1WQaw89FmzgTu2PX6yeUdG4W8UvKpElER3U9al19qR2r3TaGaA2YCm+LV4PxU5w56mD9HxH4SZsFgxycjnLwsgDyH0F+42E7N+2+fN3GR6vxwiHu8yBqxsVF2/zC0Rz6N4bxK05Yq2xPnfGOJASN6RyuDfQz01sRCtGsBhEbNuapvY6SMgMLJHUJT1Iatv40zPPtVtWxmmk8v+rp+1TfG5/DGtF7w==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MA1PPF8F457A31C.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a04::9f) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.29; Fri, 14 Mar
 2025 03:45:01 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%7]) with mapi id 15.20.8534.025; Fri, 14 Mar 2025
 03:45:01 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Kees Cook <kees@kernel.org>, "tamird@gmail.com" <tamird@gmail.com>, Petr
 Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, Andy
 Shevchenko <andriy.shevchenko@linux.intel.com>, Rasmus Villemoes
	<linux@rasmusvillemoes.dk>, Sergey Senozhatsky <senozhatsky@chromium.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] printf: add tests for generic FourCCs
Thread-Topic: [PATCH] printf: add tests for generic FourCCs
Thread-Index: AQHblJN2owK9Bwn+sUKhi7LARyATYg==
Date: Fri, 14 Mar 2025 03:45:01 +0000
Message-ID: <4378DDFE-3263-497A-8364-433DC1984FEE@live.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|MA1PPF8F457A31C:EE_
x-ms-office365-filtering-correlation-id: 81f5b38d-3b7c-4066-55e5-08dd62aa9937
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799006|7092599003|5062599005|8062599003|8060799006|461199028|19110799003|1602099012|102099032|440099028|10035399004|4302099013|3412199025;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?YPUnEsrZsvmbita/2H1teu7Vh20VPbixLVCVOW5uyzTxy5n8ru4f/hq+WFRi?=
 =?us-ascii?Q?JnWt+rrphkH1xzMrH8PxnPErLbgFjztQgEaZdgcS+x+I6YiLbAwbLCVuy6Ue?=
 =?us-ascii?Q?ydYkcuoorgvfgp7mfRPmPam9cRdZgTjzX8j5oNcj05WLit76Ci6d7+vsFtKs?=
 =?us-ascii?Q?vFhfnLDUYJnbYR6Vs3bzDWO19+O7JS6qm0MXiMDLXA2BQ3M5HAoMgYdw9UN8?=
 =?us-ascii?Q?Y3Mk0APsd0uhl+Uz8MTUDenp0eM+ut3nrDi/LMuKFzl/uh9CPXKkMywfzpLr?=
 =?us-ascii?Q?R2pGErxmOVSq8F6JTAprFaQ0OX68UrUuvFYw1m5ReBdHpz3yOkVwZt4iQ61Q?=
 =?us-ascii?Q?V7Bv0xkQSr5VhwT5+NgpQWRxpvSd0rv2iUro5I07H71woK/e8p+yFvFEBFXE?=
 =?us-ascii?Q?3hCuOR77Mf/xlS7bZYGsLIs2VRW3ftCCk/rKn8EOFCR3DUsCHcUBv+uejyak?=
 =?us-ascii?Q?Xx8JV9dnd2Ct/vqiGWBmhOgBaI4+rhVvY2PeeitFzJn/xIYGP3vA/hMueFQn?=
 =?us-ascii?Q?tTj4gDilD4g91HUs+7cGz2/na50QKHEdy6ikt/8lEYx2n62bFBQrE8CIMSqH?=
 =?us-ascii?Q?O6/d3XIxLmeGJFkkcfMPsKUepxFnWw+CZ2hpc9v7Xyq+Ax6CkGmEdh5ozzBs?=
 =?us-ascii?Q?hxqFbLMPDxLOBMkmuJqbVvP24ht3RiNWlRU00bXDs9UBnnoc+GEf61SG7FaK?=
 =?us-ascii?Q?nEvmKRM6irgb5iJSpLPt7pbbOZpaioNKNxIdBgLGutP4qBkrKWTcE4qDOo1B?=
 =?us-ascii?Q?bczzQcQFmLZkAzQfDYR1LybiFeicv8qklAusxVkX0ikwwmTS0+cep8wmI891?=
 =?us-ascii?Q?Xf1+IKhCbphxHCWajAYCuyDq/prVZBWLDYW5qJG1S7hdehF2jthp1IC4BAtz?=
 =?us-ascii?Q?1ubq+0vG4E9bG82i8M6Nd9b6sUM+QBQhK/KlZMhat/OpLyhCUqN9+LGdfiJG?=
 =?us-ascii?Q?tHem/juftnQs+EwQoqIIsdiMGfsGdlytq/1G6tB2556t1gFBQqwaASclUmTz?=
 =?us-ascii?Q?QBk86VD2VdrhfFKvE8fEd9Psg7ms95ReME3WahQwzCMAtyVzi6LC70kRwvZl?=
 =?us-ascii?Q?a0NJMEno2DxY34hgDrNC/xuReaFIXWVEsX0BMtfBzz83Qybh0pAKo9YzEO8v?=
 =?us-ascii?Q?S4UBO5VA7J46AXT8jJn1CuQnsoZQFEcbWvv/stekK9zdxNVZjoWdOVcVIELn?=
 =?us-ascii?Q?3ZQWSkAD3pYBEZaqEkW1s7wT4xtpBMcp7LLXJl4LKZNZGY5It6KQckPzhJyf?=
 =?us-ascii?Q?O2b5lp2Xnf1q4XrC/LIC?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Ex1t4K81DTUhKoScImUgKDAzTlxhkiDqFtwm36fs6ff3XbNI/EHTANn+iiDW?=
 =?us-ascii?Q?Ud2GAxK0Wvn+DTJjDNxX62n9ru2cBxCLRli3HZABQ5j5pZ3bLq1pi+tzL7aD?=
 =?us-ascii?Q?pl8PTBsdeaCm3OQhzCHcSSHJv98DvGSe/tg9oozCiRx0MiI30ABDhX/GXt9m?=
 =?us-ascii?Q?kz6NlO5uHrvLvBM4iuaR/+K4nsLoDU8l/DZ0UQODI154DfgncDnUToK2wH8k?=
 =?us-ascii?Q?kJzcbZLOuvQH49ndgfn9J1j8DiuRGVjp/3Xu3hpID64tDADkUSNXQ8NfW4XO?=
 =?us-ascii?Q?TWZIYoBcDus3yDPafZhaO6ZtRIGQaqj1G5Gp7ApxeB2nCAzYgr2aLsWC1vbz?=
 =?us-ascii?Q?U44Xc3R6GaSHRWmnK2cPwQGFeVgvblNHH9zyBBmdmsE1AscbAym7W2/HVMDv?=
 =?us-ascii?Q?FBHHCltBX5NdQJGUl8+qti1DHzAUtYq4paoDHPmrzH8C1uIdk85b22CdTUej?=
 =?us-ascii?Q?DMOfzD35T68I4otm57zoqUsumUPike+c8wk6KSkp9/oNfm+7CZeUqhwaHhvn?=
 =?us-ascii?Q?kV6XHvp++VbjmKkmn1RoCOwcMVB81hhps39d3icgKy1Uvxk90lMtUaZDPpLO?=
 =?us-ascii?Q?zEVpoD3LdBb2mWw7AZA0MNgY9mCNT9rjX93LM/ZTXef8K2ffsid2HAZeNytt?=
 =?us-ascii?Q?sQbLhBfS9eTiFyOIKPxrftaKBcynGRxBYawbqkYY0a/19cyYQZaYNmpT6bPJ?=
 =?us-ascii?Q?dW4TfdpxuofuRsdwa3nlZWOY+eSr/e2jVuW3qLkIJBEYD0Xrff1BqJXQYxbt?=
 =?us-ascii?Q?7flTgyT+TgnFAcupW21KWtABz2iOSuw/bCpjvJ99y96iTmMAs7RlaGKLqUCk?=
 =?us-ascii?Q?crDgNO44GCVEQsdvYor+Wy481u1r3YQzCQLjcc2ZoaugAxQQAj7SoAUn5bhP?=
 =?us-ascii?Q?UJ2ptLlDF4kFXrB++FdYh4JKA9055OpY06e+abFTG5dkmp2ZPQ4t1o17MdT0?=
 =?us-ascii?Q?c6Yyt5ig76JMTH5KFVLdSC1pvzCFuKJxxhkGlGFUfw3NY05sssEkf2YXNkG3?=
 =?us-ascii?Q?yblJwqt2KsX5wuFnxaBkMfiab/tZ5ywVRYH0xC+dlquKGdb51GaX3zQE0uMw?=
 =?us-ascii?Q?d1Z+uiZh9PyvgCqFVkTHrk8QHuOzAae3ZwupI62llflOq/bKBtwoFMVcC86R?=
 =?us-ascii?Q?2fXUGHvzHV+fWo9lB7vRNUAVZPc1lTOGgd4wLFeNBHtz/S3VeS47iEGYa49f?=
 =?us-ascii?Q?Sew5BvVscVxi9LtkpV7fEXa3o1zjj9Zi3WwESRTKWNTvG1BUtRu05Rgt51if?=
 =?us-ascii?Q?VFll0DtAhp4Ehc8u1feLZi7SeiUFQUAD9ncfosN0HsnAHeKodGnI2c982w/r?=
 =?us-ascii?Q?B0BHsmNbL0h9oe5Rf6dQuXs3?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5B2757E59980604197DF269A845FBF4F@INDPRD01.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 81f5b38d-3b7c-4066-55e5-08dd62aa9937
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2025 03:45:01.0717
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA1PPF8F457A31C

From: Aditya Garg <gargaditya08@live.com>

Format specifiers for printing generic 32-bit FourCCs were recently added
to vsprintf. They are going through the DRM tree alongwith the appletbdrm
driver. Since the printf tests are being converted to kunit, this separate
patch for the tests should make it easier to rebase when the merge window
opens.

Link: https://lore.kernel.org/dri-devel/79FA3F41-FD7A-41D9-852B-D32606AF5EB=
4@live.com/T/#u
Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 lib/tests/printf_kunit.c | 39 ++++++++++++++++++++++++++++++++-------
 1 file changed, 32 insertions(+), 7 deletions(-)

diff --git a/lib/tests/printf_kunit.c b/lib/tests/printf_kunit.c
index 2c9f6170b..b1fa0dcea 100644
--- a/lib/tests/printf_kunit.c
+++ b/lib/tests/printf_kunit.c
@@ -701,21 +701,46 @@ static void fwnode_pointer(struct kunit *kunittest)
 	software_node_unregister_node_group(group);
 }
=20
+struct fourcc_struct {
+	u32 code;
+	const char *str;
+};
+
+static void fourcc_pointer_test(struct kunit *kunittest, const struct four=
cc_struct *fc,
+				size_t n, const char *fmt)
+{
+	size_t i;
+
+	for (i =3D 0; i < n; i++)
+		test(fc[i].str, fmt, &fc[i].code);
+}
+
 static void fourcc_pointer(struct kunit *kunittest)
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
+	fourcc_pointer_test(kunittest, try_cc, ARRAY_SIZE(try_cc), "%p4cc");
+	fourcc_pointer_test(kunittest, try_ch, ARRAY_SIZE(try_ch), "%p4ch");
+	fourcc_pointer_test(kunittest, try_cn, ARRAY_SIZE(try_cn), "%p4cn");
+	fourcc_pointer_test(kunittest, try_cl, ARRAY_SIZE(try_cl), "%p4cl");
+	fourcc_pointer_test(kunittest, try_cb, ARRAY_SIZE(try_cb), "%p4cb");
 }
=20
 static void
--=20
2.43.0



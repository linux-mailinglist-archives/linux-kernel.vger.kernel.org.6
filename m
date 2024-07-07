Return-Path: <linux-kernel+bounces-243705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DAB21929967
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 21:07:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98232281C27
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 19:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 145A56A022;
	Sun,  7 Jul 2024 19:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="BY8BipP5";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="Y3ipbB4V"
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B262E85E
	for <linux-kernel@vger.kernel.org>; Sun,  7 Jul 2024 19:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720379226; cv=none; b=TXPRGQQ3k4hQIOZzJYnpLAcjP4MBWOawdkrmSJm3goXJiA4OaB93HXodv37iDZ8RF/CQRvIxUV0zsV5GhvkJ0ifkardScPi+k4TKGI+7rVT753llsUPYiPVQ16kvXlxk4BbJ3WN5rwTJRN08gQxkmaZZFYyHhR3WpTdAP/fgCD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720379226; c=relaxed/simple;
	bh=y5E7OBngPfDkY3XfbPU8rxbUJdyujoY6VWRWe5uTCEA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eSfAf4oqBwdH1AUJIF0V8ikSoOgqEwdHQcrYJYKE/x/xRHkRnIiwQEpbB3/H9UIFXXeyro7t4kHMcc7oMW20UEKxsryd0zPdQe/5irbTEQi5kGbNLnjSAzyL8dWc+6VakgjPYecuPhofXbR+OPq7yUl4ytBQWHMrp5NM4Hi4S8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=BY8BipP5; dkim=fail (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=Y3ipbB4V reason="signature verification failed"; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id BF8351A0E3;
	Sun,  7 Jul 2024 15:06:55 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=y5E7OBngPfDkY3XfbPU8rxbUJ
	dyujoY6VWRWe5uTCEA=; b=BY8BipP5TRTQ70GdWG3xVEFfccYi+/8IGOV9Tm4ap
	1KcD6fL9h2NuxdGb17eaijUVh9Lf/LO7DMUlpMrGDynD+elKcEW/cpN2bBvJkK7Y
	RFX51n4WBFA7S1Q5k7KR6DudCPKoUp9gn+vvlFbcMz+lP/3GPnntTVywpfdUCEDT
	wc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B58091A0E2;
	Sun,  7 Jul 2024 15:06:55 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=from:to:cc:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=2016-12.pbsmtp; bh=tszzF1rafpYU6uyroSx0MMv1pkglcDvKtgmQW7oeGQ0=; b=Y3ipbB4V/o9XVKgMm7MFIIMn0MwuzClHi8jn8mBQhPvNJkQI6pxnruhuYND+PMPv95dck0/vZIym167cupxNRRRIBJktcLvNfSusNt/qIoAiScyfYcqfuGbjymI/VqL0qDW+iKdKV+e9wXjkDvRARnfm7qs8JZHczVD7oT0IV58=
Received: from yoda.fluxnic.net (unknown [184.162.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 072851A0E1;
	Sun,  7 Jul 2024 15:06:55 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
Received: from xanadu.lan (OpenWrt.lan [192.168.1.1])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id E7006D3B4E3;
	Sun,  7 Jul 2024 15:06:53 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: Andrew Morton <akpm@linux-foundation.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Nicolas Pitre <npitre@baylibre.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] mul_u64_u64_div_u64: basic sanity test
Date: Sun,  7 Jul 2024 15:05:20 -0400
Message-ID: <20240707190648.1982714-3-nico@fluxnic.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240707190648.1982714-1-nico@fluxnic.net>
References: <20240707190648.1982714-1-nico@fluxnic.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 136C90EC-3C94-11EF-8CC2-965B910A682E-78420484!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

From: Nicolas Pitre <npitre@baylibre.com>

Verify that edge cases produce proper results, and some more.

Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
---
 lib/Kconfig.debug                   | 10 +++
 lib/math/Makefile                   |  1 +
 lib/math/test_mul_u64_u64_div_u64.c | 98 +++++++++++++++++++++++++++++
 3 files changed, 109 insertions(+)
 create mode 100644 lib/math/test_mul_u64_u64_div_u64.c

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 59b6765d86..cc570c6f34 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2278,6 +2278,16 @@ config TEST_DIV64
=20
 	  If unsure, say N.
=20
+config TEST_MULDIV64
+	tristate "mul_u64_u64_div_u64() test"
+	depends on DEBUG_KERNEL || m
+	help
+	  Enable this to turn on 'mul_u64_u64_div_u64()' function test.
+	  This test is executed only once during system boot (so affects
+	  only boot time), or at module load time.
+
+	  If unsure, say N.
+
 config TEST_IOV_ITER
 	tristate "Test iov_iter operation" if !KUNIT_ALL_TESTS
 	depends on KUNIT
diff --git a/lib/math/Makefile b/lib/math/Makefile
index 91fcdb0c9e..981a26127e 100644
--- a/lib/math/Makefile
+++ b/lib/math/Makefile
@@ -6,4 +6,5 @@ obj-$(CONFIG_PRIME_NUMBERS)	+=3D prime_numbers.o
 obj-$(CONFIG_RATIONAL)		+=3D rational.o
=20
 obj-$(CONFIG_TEST_DIV64)	+=3D test_div64.o
+obj-$(CONFIG_TEST_MULDIV64)	+=3D test_mul_u64_u64_div_u64.o
 obj-$(CONFIG_RATIONAL_KUNIT_TEST) +=3D rational-test.o
diff --git a/lib/math/test_mul_u64_u64_div_u64.c b/lib/math/test_mul_u64_=
u64_div_u64.c
new file mode 100644
index 0000000000..a25640d349
--- /dev/null
+++ b/lib/math/test_mul_u64_u64_div_u64.c
@@ -0,0 +1,98 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2024 BayLibre SAS
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/printk.h>
+#include <linux/math64.h>
+
+typedef struct { u64 a; u64 b; u64 c; u64 result; } test_params;
+
+static test_params test_values[] =3D {
+/* this contains many edge values followed by a couple random values */
+{                0xb,                0x7,                0x3,           =
    0x19 },
+{         0xffff0000,         0xffff0000,                0xf, 0x1110eeef=
00000000 },
+{         0xffffffff,         0xffffffff,                0x1, 0xfffffffe=
00000001 },
+{         0xffffffff,         0xffffffff,                0x2, 0x7fffffff=
00000000 },
+{        0x1ffffffff,         0xffffffff,                0x2, 0xfffffffe=
80000000 },
+{        0x1ffffffff,         0xffffffff,                0x3, 0xaaaaaaa9=
aaaaaaab },
+{        0x1ffffffff,        0x1ffffffff,                0x4, 0xffffffff=
00000000 },
+{ 0xffff000000000000, 0xffff000000000000, 0xffff000000000001, 0xfffeffff=
ffffffff },
+{ 0x3333333333333333, 0x3333333333333333, 0x5555555555555555, 0x1eb851eb=
851eb851 },
+{ 0xffffffffffffffff,                0x2, 0x8000000000000000,           =
     0x3 },
+{ 0xffffffffffffffff,                0x2, 0xc000000000000000,           =
     0x2 },
+{ 0xffffffffffffffff, 0x4000000000000004, 0x8000000000000000, 0x80000000=
00000007 },
+{ 0xffffffffffffffff, 0x4000000000000001, 0x8000000000000000, 0x80000000=
00000001 },
+{ 0xffffffffffffffff, 0x8000000000000001, 0xffffffffffffffff, 0x80000000=
00000001 },
+{ 0xfffffffffffffffe, 0x8000000000000001, 0xffffffffffffffff, 0x80000000=
00000000 },
+{ 0xffffffffffffffff, 0x8000000000000001, 0xfffffffffffffffe, 0x80000000=
00000001 },
+{ 0xffffffffffffffff, 0x8000000000000001, 0xfffffffffffffffd, 0x80000000=
00000002 },
+{ 0x7fffffffffffffff, 0xffffffffffffffff, 0xc000000000000000, 0xaaaaaaaa=
aaaaaaa8 },
+{ 0xffffffffffffffff, 0x7fffffffffffffff, 0xa000000000000000, 0xcccccccc=
ccccccca },
+{ 0xffffffffffffffff, 0x7fffffffffffffff, 0x9000000000000000, 0xe38e38e3=
8e38e38b },
+{ 0x7fffffffffffffff, 0x7fffffffffffffff, 0x5000000000000000, 0xcccccccc=
ccccccc9 },
+{ 0xffffffffffffffff, 0xfffffffffffffffe, 0xffffffffffffffff, 0xffffffff=
fffffffe },
+{ 0xe6102d256d7ea3ae, 0x70a77d0be4c31201, 0xd63ec35ab3220357, 0x78f8bf8c=
c86c6e18 },
+{ 0xf53bae05cb86c6e1, 0x3847b32d2f8d32e0, 0xcfd4f55a647f403c, 0x42687f79=
d8998d35 },
+{ 0x9951c5498f941092, 0x1f8c8bfdf287a251, 0xa3c8dc5f81ea3fe2, 0x1d887cb2=
5900091f },
+{ 0x374fee9daa1bb2bb, 0x0d0bfbff7b8ae3ef, 0xc169337bd42d5179, 0x03bb2dba=
ffcbb961 },
+{ 0xeac0d03ac10eeaf0, 0x89be05dfa162ed9b, 0x92bb1679a41f0e4b, 0xdc5f5cc9=
e270d216 },
+};
+
+/*
+ * The above table can be verified with the following shell script:
+ *
+ * #!/bin/sh
+ * sed -ne 's/^{ \+\(.*\), \+\(.*\), \+\(.*\), \+\(.*\) },$/\1 \2 \3 \4/=
p' \
+ *     lib/math/test_mul_u64_u64_div_u64.c |
+ * while read a b c r; do
+ *   expected=3D$( printf "obase=3D16; ibase=3D16; %X * %X / %X\n" $a $b=
 $c | bc )
+ *   given=3D$( printf "%X\n" $r )
+ *   if [ "$expected" =3D "$given" ]; then
+ *     echo "$a * $b / $c =3D $r OK"
+ *   else
+ *     echo "$a * $b / $c =3D $r is wrong" >&2
+ *     echo "should be equivalent to 0x$expected" >&2
+ *     exit 1
+ *   fi
+ * done
+ */
+
+static int __init test_init(void)
+{
+	int i;
+
+	pr_info("Starting mul_u64_u64_div_u64() test\n");
+
+	for (i =3D 0; i < ARRAY_SIZE(test_values); i++) {
+		u64 a =3D test_values[i].a;
+		u64 b =3D test_values[i].b;
+		u64 c =3D test_values[i].c;
+		u64 expected_result =3D test_values[i].result;
+		u64 result =3D mul_u64_u64_div_u64(a, b, c);
+
+		if (result !=3D expected_result) {
+			pr_err("ERROR: 0x%016llx * 0x%016llx / 0x%016llx\n", a, b, c);
+			pr_err("ERROR: expected result: %016llx\n", expected_result);
+			pr_err("ERROR: obtained result: %016llx\n", result);
+		}
+	}
+
+	pr_info("Completed mul_u64_u64_div_u64() test\n");
+	return 0;
+}
+
+static void __exit test_exit(void)
+{
+}
+
+module_init(test_init);
+module_exit(test_exit);
+
+MODULE_AUTHOR("Nicolas Pitre");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("mul_u64_u64_div_u64() test module");
--=20
2.45.2



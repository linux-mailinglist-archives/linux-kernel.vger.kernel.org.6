Return-Path: <linux-kernel+bounces-551361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A041A56B72
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 16:14:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED333189B481
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 15:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D492206B1;
	Fri,  7 Mar 2025 15:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="HjxCflrF"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64C8223719
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 15:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741360223; cv=none; b=g7XiGbo8zE0mcOYcGmLJ4bK9Deg2WVyZdcSmMhw5+LP4gWeF35wb11yMnuQlXWH3srDllEGbmZwhrAOKf4MtmE/5DGaGjlka1qHNuZBBFDAQZndZ48u74gUGntrL+X2/z198NPLk7T/CUq/hlo1xkUPAei+73VwxWvrNHr6jIN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741360223; c=relaxed/simple;
	bh=QP9+eoKRN/NMz334w0ZmrqqRYAQoc9f3oUpqFfOrPZo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jf/91wBygjIXBertlmTpdB935+ygOgfEhoMelmoOeR6/Rrt89GjFu9dA6TGIRWHGwi6eRRQJMF/irpPIRb/ZEo32QQ+nU9Ii4np/9JWq+fpWm66oyO2oSBhBb8uY0wkRCATTlUH+hfXO3ONyjiQRdJpY6qt2fIfuNUfSk0tjV6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=HjxCflrF; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=6EAO8uTBGtadYxlyQOnCsLSswmw5qGux5GC8ytFY98w=; b=HjxCflrFLOrPpHnhfgz+hwrsOi
	YAz81t8erCt+kPWnVpkRBxqkriJSrEAnSOJazKiMDu/LzPKs6mwvoT8MJD4hDnl4o7Pm4tBL2PV2n
	K5aG8yTPveMfcteSajszP95hJ5fK+Ss33ODz1rjYNfR6tRejHHbaiInrZZD4HTOlT/f9i4fzNxOwh
	J4jG/Ys8037ZwNDIWjJ80P7w7L/p3sif6+tCNihVaijYmZYtFLR0Kg3J7B2MsaFwKNZ0ruHEunChv
	XJ1Ru7nAdvRrsMS8OcscnFh0sdSIhQ821XB1OaOFTUvjgSNNYUFVUW90kPX6o0cA8WTW5ew4ZX2wF
	mC6bwy4w==;
Received: from 179-125-91-70-dinamico.pombonet.net.br ([179.125.91.70] helo=[192.168.67.187])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1tqYrN-005OEr-FS; Fri, 07 Mar 2025 15:39:39 +0100
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Date: Fri, 07 Mar 2025 11:39:28 -0300
Subject: [PATCH v2 2/2] char: misc: add test cases
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250307-misc-dynrange-v2-2-6fe19032ef76@igalia.com>
References: <20250307-misc-dynrange-v2-0-6fe19032ef76@igalia.com>
In-Reply-To: <20250307-misc-dynrange-v2-0-6fe19032ef76@igalia.com>
To: Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 Dirk VanDerMerwe <dirk.vandermerwe@sophos.com>, 
 Vimal Agrawal <vimal.agrawal@sophos.com>, linux-kernel@vger.kernel.org, 
 Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
X-Mailer: b4 0.14.2

Add test cases for static and dynamic minor number allocation and
deallocation.

While at it, improve description and test suite name.

Some of the cases include:

- that static and dynamic allocation reserved the expected minors.

- that registering duplicate minors or duplicate names will fail.

- that failing to create a sysfs file (due to duplicate names) will
  deallocate the dynamic minor correctly.

- that dynamic allocation does not allocate a minor number in the static
  range.

- that there are no collisions when mixing dynamic and static allocations.

- that registering a static number in the dynamic range won't conflict with
  a dynamic allocation.

This last test verifies the bug fixed by commit 6d04d2b554b1 ("misc:
misc_minor_alloc to use ida for all dynamic/misc dynamic minors") has not
regressed.

Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
---
 drivers/misc/misc_minor_kunit.c | 509 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 507 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/misc_minor_kunit.c b/drivers/misc/misc_minor_kunit.c
index 293e0fb7e43edc330842722e1132d16cd23e3aa8..29f61531b27e737cf647f5ba20fb0422d95bdcbd 100644
--- a/drivers/misc/misc_minor_kunit.c
+++ b/drivers/misc/misc_minor_kunit.c
@@ -51,19 +51,524 @@ static void kunit_misc_dynamic_minor(struct kunit *test)
 	misc_deregister(&dev_misc_dynamic_minor);
 }
 
+struct miscdev_test_case {
+	const char *str;
+	int minor;
+};
+
+static struct miscdev_test_case miscdev_test_ranges[] = {
+	{
+		.str = "lower static range, top",
+		.minor = 15,
+	},
+	{
+		.str = "upper static range, bottom",
+		.minor = 130,
+	},
+	{
+		.str = "lower static range, bottom",
+		.minor = 0,
+	},
+	{
+		.str = "upper static range, top",
+		.minor = MISC_DYNAMIC_MINOR - 1,
+	},
+};
+
+KUNIT_ARRAY_PARAM_DESC(miscdev, miscdev_test_ranges, str);
+
+static int miscdev_find_minors(struct kunit_suite *suite)
+{
+	int ret;
+	struct miscdevice miscstat = {
+		.name = "miscstat",
+	};
+	int i;
+
+	for (i = 15; i >= 0; i--) {
+		miscstat.minor = i;
+		ret = misc_register(&miscstat);
+		if (ret == 0)
+			break;
+	}
+
+	if (ret == 0) {
+		kunit_info(suite, "found misc device minor %d available\n",
+				miscstat.minor);
+		miscdev_test_ranges[0].minor = miscstat.minor;
+		misc_deregister(&miscstat);
+	} else {
+		return ret;
+	}
+
+	for (i = 128; i < MISC_DYNAMIC_MINOR; i++) {
+		miscstat.minor = i;
+		ret = misc_register(&miscstat);
+		if (ret == 0)
+			break;
+	}
+
+	if (ret == 0) {
+		kunit_info(suite, "found misc device minor %d available\n",
+				miscstat.minor);
+		miscdev_test_ranges[1].minor = miscstat.minor;
+		misc_deregister(&miscstat);
+	} else {
+		return ret;
+	}
+
+	for (i = 0; i < miscdev_test_ranges[0].minor; i++) {
+		miscstat.minor = i;
+		ret = misc_register(&miscstat);
+		if (ret == 0)
+			break;
+	}
+
+	if (ret == 0) {
+		kunit_info(suite, "found misc device minor %d available\n",
+			miscstat.minor);
+		miscdev_test_ranges[2].minor = miscstat.minor;
+		misc_deregister(&miscstat);
+	} else {
+		return ret;
+	}
+
+	for (i = MISC_DYNAMIC_MINOR - 1; i > miscdev_test_ranges[1].minor; i--) {
+		miscstat.minor = i;
+		ret = misc_register(&miscstat);
+		if (ret == 0)
+			break;
+	}
+
+	if (ret == 0) {
+		kunit_info(suite, "found misc device minor %d available\n",
+			miscstat.minor);
+		miscdev_test_ranges[3].minor = miscstat.minor;
+		misc_deregister(&miscstat);
+	}
+
+	return ret;
+}
+
+static bool is_valid_dynamic_minor(int minor)
+{
+	if (minor < 0)
+		return false;
+	if (minor == MISC_DYNAMIC_MINOR)
+		return false;
+	if (minor >= 0 && minor <= 15)
+		return false;
+	if (minor >= 128 && minor < MISC_DYNAMIC_MINOR)
+		return false;
+	return true;
+}
+
+static void miscdev_test_static_basic(struct kunit *test)
+{
+	struct miscdevice misc_test = {
+		.name = "misc_test",
+	};
+	int ret;
+	const struct miscdev_test_case *params = test->param_value;
+
+	misc_test.minor = params->minor;
+
+	ret = misc_register(&misc_test);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_EQ(test, misc_test.minor, params->minor);
+	if (ret == 0)
+		misc_deregister(&misc_test);
+}
+
+static void miscdev_test_dynamic_basic(struct kunit *test)
+{
+	struct miscdevice misc_test = {
+		.minor = MISC_DYNAMIC_MINOR,
+		.name = "misc_test",
+	};
+	int ret;
+
+	ret = misc_register(&misc_test);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_TRUE(test, is_valid_dynamic_minor(misc_test.minor));
+	if (ret == 0)
+		misc_deregister(&misc_test);
+}
+
+static void miscdev_test_twice(struct kunit *test)
+{
+	struct miscdevice misc_test = {
+		.name = "misc_test",
+	};
+	int ret;
+	const struct miscdev_test_case *params = test->param_value;
+
+	misc_test.minor = params->minor;
+
+	ret = misc_register(&misc_test);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_EQ(test, misc_test.minor, params->minor);
+	if (ret == 0)
+		misc_deregister(&misc_test);
+
+	ret = misc_register(&misc_test);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_EQ(test, misc_test.minor, params->minor);
+	if (ret == 0)
+		misc_deregister(&misc_test);
+}
+
+static void miscdev_test_duplicate_minor(struct kunit *test)
+{
+	struct miscdevice misc1 = {
+		.name = "misc1",
+	};
+	struct miscdevice misc2 = {
+		.name = "misc2",
+	};
+	int ret;
+	const struct miscdev_test_case *params = test->param_value;
+
+	misc1.minor = params->minor;
+	misc2.minor = params->minor;
+
+	ret = misc_register(&misc1);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_EQ(test, misc1.minor, params->minor);
+
+	ret = misc_register(&misc2);
+	KUNIT_EXPECT_EQ(test, ret, -EBUSY);
+	if (ret == 0)
+		misc_deregister(&misc2);
+
+	misc_deregister(&misc1);
+}
+
+static void miscdev_test_duplicate_name(struct kunit *test)
+{
+	struct miscdevice misc1 = {
+		.minor = MISC_DYNAMIC_MINOR,
+		.name = "misc1",
+	};
+	struct miscdevice misc2 = {
+		.minor = MISC_DYNAMIC_MINOR,
+		.name = "misc1",
+	};
+	int ret;
+
+	ret = misc_register(&misc1);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_TRUE(test, is_valid_dynamic_minor(misc1.minor));
+
+	ret = misc_register(&misc2);
+	KUNIT_EXPECT_EQ(test, ret, -EEXIST);
+	if (ret == 0)
+		misc_deregister(&misc2);
+
+	misc_deregister(&misc1);
+}
+
+/*
+ * Test that after a duplicate name failure, the reserved minor number is
+ * freed to be allocated next.
+ */
+static void miscdev_test_duplicate_name_leak(struct kunit *test)
+{
+	struct miscdevice misc1 = {
+		.minor = MISC_DYNAMIC_MINOR,
+		.name = "misc1",
+	};
+	struct miscdevice misc2 = {
+		.minor = MISC_DYNAMIC_MINOR,
+		.name = "misc1",
+	};
+	struct miscdevice misc3 = {
+		.minor = MISC_DYNAMIC_MINOR,
+		.name = "misc3",
+	};
+	int ret;
+	int dyn_minor;
+
+	ret = misc_register(&misc1);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_TRUE(test, is_valid_dynamic_minor(misc1.minor));
+
+	/*
+	 * Find out what is the next minor number available.
+	 */
+	ret = misc_register(&misc3);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_TRUE(test, is_valid_dynamic_minor(misc3.minor));
+	dyn_minor = misc3.minor;
+	misc_deregister(&misc3);
+	misc3.minor = MISC_DYNAMIC_MINOR;
+
+	ret = misc_register(&misc2);
+	KUNIT_EXPECT_EQ(test, ret, -EEXIST);
+	if (ret == 0)
+		misc_deregister(&misc2);
+
+	/*
+	 * Now check that we can still get the same minor we found before.
+	 */
+	ret = misc_register(&misc3);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_TRUE(test, is_valid_dynamic_minor(misc3.minor));
+	KUNIT_EXPECT_EQ(test, misc3.minor, dyn_minor);
+	misc_deregister(&misc3);
+
+	misc_deregister(&misc1);
+}
+
+/*
+ * Try to register a static minor with a duplicate name. That might not
+ * deallocate the minor, preventing it from being used again.
+ */
+static void miscdev_test_duplicate_error(struct kunit *test)
+{
+	struct miscdevice miscdyn = {
+		.minor = MISC_DYNAMIC_MINOR,
+		.name = "name1",
+	};
+	struct miscdevice miscstat = {
+		.name = "name1",
+	};
+	struct miscdevice miscnew = {
+		.name = "name2",
+	};
+	int ret;
+	const struct miscdev_test_case *params = test->param_value;
+
+	miscstat.minor = params->minor;
+	miscnew.minor = params->minor;
+
+	ret = misc_register(&miscdyn);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_TRUE(test, is_valid_dynamic_minor(miscdyn.minor));
+
+	ret = misc_register(&miscstat);
+	KUNIT_EXPECT_EQ(test, ret, -EEXIST);
+	if (ret == 0)
+		misc_deregister(&miscstat);
+
+	ret = misc_register(&miscnew);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_EQ(test, miscnew.minor, params->minor);
+	if (ret == 0)
+		misc_deregister(&miscnew);
+
+	misc_deregister(&miscdyn);
+}
+
+static void miscdev_test_dynamic_only_range(struct kunit *test)
+{
+	int ret;
+	struct miscdevice *miscdev;
+	const int dynamic_minors = 256;
+	int i;
+
+	miscdev = kunit_kmalloc_array(test, dynamic_minors,
+					sizeof(struct miscdevice),
+					GFP_KERNEL | __GFP_ZERO);
+
+	for (i = 0; i < dynamic_minors; i++) {
+		miscdev[i].minor = MISC_DYNAMIC_MINOR;
+		miscdev[i].name = kasprintf(GFP_KERNEL, "misc_test%d", i);
+		ret = misc_register(&miscdev[i]);
+		if (ret != 0)
+			break;
+		/*
+		 * This is the bug we are looking for!
+		 * We asked for a dynamic minor and got a minor in the static range space.
+		 */
+		if (miscdev[i].minor >= 0 && miscdev[i].minor <= 15) {
+			KUNIT_FAIL(test, "misc_register allocated minor %d\n", miscdev[i].minor);
+			i++;
+			break;
+		}
+		KUNIT_EXPECT_TRUE(test, is_valid_dynamic_minor(miscdev[i].minor));
+	}
+
+	for (i--; i >= 0; i--) {
+		misc_deregister(&miscdev[i]);
+		kfree_const(miscdev[i].name);
+	}
+
+	KUNIT_EXPECT_EQ(test, ret, 0);
+}
+
+static void miscdev_test_collision(struct kunit *test)
+{
+	int ret;
+	struct miscdevice *miscdev;
+	struct miscdevice miscstat = {
+		.name = "miscstat",
+	};
+	const int dynamic_minors = 256;
+	int i;
+
+	miscdev = kunit_kmalloc_array(test, dynamic_minors,
+					sizeof(struct miscdevice),
+					GFP_KERNEL | __GFP_ZERO);
+
+	miscstat.minor = miscdev_test_ranges[0].minor;
+	ret = misc_register(&miscstat);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+	KUNIT_EXPECT_EQ(test, miscstat.minor, miscdev_test_ranges[0].minor);
+
+	for (i = 0; i < dynamic_minors; i++) {
+		miscdev[i].minor = MISC_DYNAMIC_MINOR;
+		miscdev[i].name = kasprintf(GFP_KERNEL, "misc_test%d", i);
+		ret = misc_register(&miscdev[i]);
+		if (ret != 0)
+			break;
+		KUNIT_EXPECT_TRUE(test, is_valid_dynamic_minor(miscdev[i].minor));
+	}
+
+	for (i--; i >= 0; i--) {
+		misc_deregister(&miscdev[i]);
+		kfree_const(miscdev[i].name);
+	}
+
+	misc_deregister(&miscstat);
+
+	KUNIT_EXPECT_EQ(test, ret, 0);
+}
+
+static void miscdev_test_collision_reverse(struct kunit *test)
+{
+	int ret;
+	struct miscdevice *miscdev;
+	struct miscdevice miscstat = {
+		.name = "miscstat",
+	};
+	const int dynamic_minors = 256;
+	int i;
+
+	miscdev = kunit_kmalloc_array(test, dynamic_minors,
+					sizeof(struct miscdevice),
+					GFP_KERNEL | __GFP_ZERO);
+
+	for (i = 0; i < dynamic_minors; i++) {
+		miscdev[i].minor = MISC_DYNAMIC_MINOR;
+		miscdev[i].name = kasprintf(GFP_KERNEL, "misc_test%d", i);
+		ret = misc_register(&miscdev[i]);
+		if (ret != 0)
+			break;
+		KUNIT_EXPECT_TRUE(test, is_valid_dynamic_minor(miscdev[i].minor));
+	}
+
+	KUNIT_EXPECT_EQ(test, ret, 0);
+
+	miscstat.minor = miscdev_test_ranges[0].minor;
+	ret = misc_register(&miscstat);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_EQ(test, miscstat.minor, miscdev_test_ranges[0].minor);
+	if (ret == 0)
+		misc_deregister(&miscstat);
+
+	for (i--; i >= 0; i--) {
+		misc_deregister(&miscdev[i]);
+		kfree_const(miscdev[i].name);
+	}
+}
+
+static void miscdev_test_conflict(struct kunit *test)
+{
+	int ret;
+	struct miscdevice miscdyn = {
+		.name = "miscdyn",
+		.minor = MISC_DYNAMIC_MINOR,
+	};
+	struct miscdevice miscstat = {
+		.name = "miscstat",
+	};
+
+	ret = misc_register(&miscdyn);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+	KUNIT_EXPECT_TRUE(test, is_valid_dynamic_minor(miscdyn.minor));
+
+	/*
+	 * Try to register a static minor with the same minor as the
+	 * dynamic one.
+	 */
+	miscstat.minor = miscdyn.minor;
+	ret = misc_register(&miscstat);
+	KUNIT_EXPECT_EQ(test, ret, -EBUSY);
+	if (ret == 0)
+		misc_deregister(&miscstat);
+
+	misc_deregister(&miscdyn);
+}
+
+static void miscdev_test_conflict_reverse(struct kunit *test)
+{
+	int ret;
+	struct miscdevice miscdyn = {
+		.name = "miscdyn",
+		.minor = MISC_DYNAMIC_MINOR,
+	};
+	struct miscdevice miscstat = {
+		.name = "miscstat",
+	};
+
+	/*
+	 * Find the first available dynamic minor to use it as a static
+	 * minor later on.
+	 */
+	ret = misc_register(&miscdyn);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+	KUNIT_EXPECT_TRUE(test, is_valid_dynamic_minor(miscdyn.minor));
+	miscstat.minor = miscdyn.minor;
+	misc_deregister(&miscdyn);
+
+	ret = misc_register(&miscstat);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_EQ(test, miscstat.minor, miscdyn.minor);
+
+	/*
+	 * Try to register a dynamic minor after registering a static minor
+	 * within the dynamic range. It should work but get a different
+	 * minor.
+	 */
+	miscdyn.minor = MISC_DYNAMIC_MINOR;
+	ret = misc_register(&miscdyn);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_NE(test, miscdyn.minor, miscstat.minor);
+	KUNIT_EXPECT_TRUE(test, is_valid_dynamic_minor(miscdyn.minor));
+	if (ret == 0)
+		misc_deregister(&miscdyn);
+
+	misc_deregister(&miscstat);
+}
+
 static struct kunit_case test_cases[] = {
 	KUNIT_CASE(kunit_dynamic_minor),
 	KUNIT_CASE(kunit_static_minor),
 	KUNIT_CASE(kunit_misc_dynamic_minor),
+	KUNIT_CASE_PARAM(miscdev_test_static_basic, miscdev_gen_params),
+	KUNIT_CASE(miscdev_test_dynamic_basic),
+	KUNIT_CASE_PARAM(miscdev_test_twice, miscdev_gen_params),
+	KUNIT_CASE_PARAM(miscdev_test_duplicate_minor, miscdev_gen_params),
+	KUNIT_CASE(miscdev_test_duplicate_name),
+	KUNIT_CASE(miscdev_test_duplicate_name_leak),
+	KUNIT_CASE_PARAM(miscdev_test_duplicate_error, miscdev_gen_params),
+	KUNIT_CASE(miscdev_test_dynamic_only_range),
+	KUNIT_CASE(miscdev_test_collision),
+	KUNIT_CASE(miscdev_test_collision_reverse),
+	KUNIT_CASE(miscdev_test_conflict),
+	KUNIT_CASE(miscdev_test_conflict_reverse),
 	{}
 };
 
 static struct kunit_suite test_suite = {
-	.name = "misc_minor_test",
+	.name = "miscdev",
+	.suite_init = miscdev_find_minors,
 	.test_cases = test_cases,
 };
 kunit_test_suite(test_suite);
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Vimal Agrawal");
-MODULE_DESCRIPTION("misc minor testing");
+MODULE_AUTHOR("Thadeu Lima de Souza Cascardo <cascardo@igalia.com>");
+MODULE_DESCRIPTION("Test module for misc character devices");

-- 
2.47.2



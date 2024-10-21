Return-Path: <linux-kernel+bounces-374464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9F949A6A9E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 15:41:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74687B28351
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 13:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDDE91F9418;
	Mon, 21 Oct 2024 13:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W4lhC3mE"
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B2D1F9434
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 13:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729517987; cv=none; b=Qgv0mI+zP1/MYmXTUmDM7wSXpf25pyFfAXwspDV/BuAes/oVNGLag8Ei3D2esdHOiL15xsPG/tnXYVFUGhcNM0vtC6uOnGQ6hU7zlm8dgQLEr77PB+eUeMUp4EtaKyt/4vH859dAaVtyDlj6raB1fCxN7E5RpEKWO25EwoljaVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729517987; c=relaxed/simple;
	bh=fFNrNbgbi0OoM+ELyEvhCsZ8eEjyMJ2HZ/5DmY7rB94=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=U0xMVwjZ6nQMnMYPw8A8fjeeTlrM5EHOOhzZZ9D/J1t/O9XlGbX2r4l87Vw29qgfbH8WoX2m6pm9Vd36iq7eeYZUBpE5Wejc2hxNWO+CMj8OuWfuaekL0l+T6ygs6m/wTvtf4xSLxF9yFGwrPp6bSzh9GVuMx+8wtpY4eX4gOng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W4lhC3mE; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3e6075cba82so909178b6e.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 06:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729517984; x=1730122784; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4A+ztF8SaPFSnt/8L4dXb5Yz21kqLHs5QfVa2rY521g=;
        b=W4lhC3mEK3NBgQ8xz1yh8s9eaaWgS6S3+7RkV1qzt6qyzv96yLsNlY1Xk0WES/GnLE
         GSsfbWPqu4aeUGyzkDonmOg38YcVpNipMwCI6oqFk906bhqA2YsuWTwWvxdPbU9o7QUB
         OoUQ3yqVsawK9xBHRzqcjw8gyS0VNicTF8U1vPuClAB9G8Q4DV8qkwAAkIJy6Yforyom
         RDLcLiMTF6hpvQPdK/sOIMjz43wYdWnaMMttwlhuEYSvI8wnV/brrg3y8ve+iDdt7n7Z
         u7IsdQW3/9mfn19m12bqKX3qlclbjulbntqx8MKyGaiiqgIeQnUGzqfKA1VbUrN4+91W
         GRzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729517984; x=1730122784;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4A+ztF8SaPFSnt/8L4dXb5Yz21kqLHs5QfVa2rY521g=;
        b=T1k5pXJ1oI4hRDjmUEDNjnD42gN1UGO6aVe30dE3v7JU62gbHHi/awU0mWF9M3rf4f
         b4Atkdl/G+yWRrAHHgOU/EcL1U/t2OG9nHZgsebsG0Uyxqw0MWI8An6h3zmcv7hTC1rM
         uKGKWd89s0Xy4ULfNWKT+WE3T8h+A9nGV8u5owYo3ALdAB9nEtr7GDuI2SKcpL3OkCRG
         n+Z/LLmrTxf1GM02KZib4y5DP5ecSKJWk/vfLk7gAdIxU4UCmicgxq7K54qywp5zB7gM
         ExO0T16lfo4mJXQplXQbeHJ9A4fooSLSzPzE7LKqw+TM6wQn/O4x6qvIAK9dXqaHlcv/
         OE+g==
X-Gm-Message-State: AOJu0YxIOu+Gu6E2mhF+SmuOx45dU4MWQKLzh6Pbo7xe7GNdaV0IHP4t
	u8792UQWGVnZb+8b3S9XPe/mM45Q7Myj5wfwD8mWoiegZ/Tts4f/Z5/yLRgs
X-Google-Smtp-Source: AGHT+IGgD4WTnUsc2NOdTUD1mkAc3r69esN90aIlM2BwuwyvNvXM2MAcjJ3ua8NUhC1wjvW/jOND2A==
X-Received: by 2002:a05:6870:440e:b0:277:f51d:3ed3 with SMTP id 586e51a60fabf-2892c2def2emr9147876fac.16.1729517983868;
        Mon, 21 Oct 2024 06:39:43 -0700 (PDT)
Received: from localhost.localdomain ([66.198.16.131])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b165a5c4c0sm166894485a.83.2024.10.21.06.39.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 06:39:43 -0700 (PDT)
From: avimalin@gmail.com
X-Google-Original-From: vimal.agrawal@sophos.com
To: linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org,
	arnd@arndb.de,
	quic_jjohnson@quicinc.com,
	dan.carpenter@linaro.org,
	dirk.vandermerwe@sophos.com
Cc: vimal.agrawal@sophos.com
Subject: [PATCH v5 2/2] misc:minor basic kunit tests
Date: Mon, 21 Oct 2024 13:39:26 +0000
Message-Id: <20241021133926.23774-1-vimal.agrawal@sophos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241017141329.95508-1-vimal.agrawal@sophos.com>
References: <20241017141329.95508-1-vimal.agrawal@sophos.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

From: Vimal Agrawal <vimal.agrawal@sophos.com>

basic kunit tests for misc minor

Signed-off-by: Vimal Agrawal <vimal.agrawal@sophos.com>
Reviewed-by: Dirk VanDerMerwe <dirk.vandermerwe@sophos.com>
---
v2: Split from previous patch
v3:
v4: Match patch version for whole patch series
v5: Moved kunit test code to drivers/misc/. Used corporate id in from: and Signed-off-by:

 drivers/misc/Makefile           |  1 +
 drivers/misc/misc_minor_kunit.c | 69 +++++++++++++++++++++++++++++++++
 lib/Kconfig.debug               | 11 ++++++
 3 files changed, 81 insertions(+)
 create mode 100644 drivers/misc/misc_minor_kunit.c

diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index a9f94525e181..22112861084c 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -22,6 +22,7 @@ obj-$(CONFIG_SENSORS_BH1770)	+= bh1770glc.o
 obj-$(CONFIG_SENSORS_APDS990X)	+= apds990x.o
 obj-$(CONFIG_ENCLOSURE_SERVICES) += enclosure.o
 obj-$(CONFIG_KGDB_TESTS)	+= kgdbts.o
+obj-$(CONFIG_TEST_MISC_MINOR)	+= misc_minor_kunit.o
 obj-$(CONFIG_SGI_XP)		+= sgi-xp/
 obj-$(CONFIG_SGI_GRU)		+= sgi-gru/
 obj-$(CONFIG_SMPRO_ERRMON)	+= smpro-errmon.o
diff --git a/drivers/misc/misc_minor_kunit.c b/drivers/misc/misc_minor_kunit.c
new file mode 100644
index 000000000000..293e0fb7e43e
--- /dev/null
+++ b/drivers/misc/misc_minor_kunit.c
@@ -0,0 +1,69 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <kunit/test.h>
+#include <kunit/test-bug.h>
+#include <linux/module.h>
+#include <linux/miscdevice.h>
+
+/* dynamic minor (2) */
+static struct miscdevice dev_dynamic_minor = {
+	.minor  = 2,
+	.name   = "dev_dynamic_minor",
+};
+
+/* static minor (LCD_MINOR) */
+static struct miscdevice dev_static_minor = {
+	.minor  = LCD_MINOR,
+	.name   = "dev_static_minor",
+};
+
+/* misc dynamic minor */
+static struct miscdevice dev_misc_dynamic_minor = {
+	.minor  = MISC_DYNAMIC_MINOR,
+	.name   = "dev_misc_dynamic_minor",
+};
+
+static void kunit_dynamic_minor(struct kunit *test)
+{
+	int ret;
+
+	ret = misc_register(&dev_dynamic_minor);
+	KUNIT_EXPECT_EQ(test, 0, ret);
+	KUNIT_EXPECT_EQ(test, 2, dev_dynamic_minor.minor);
+	misc_deregister(&dev_dynamic_minor);
+}
+
+static void kunit_static_minor(struct kunit *test)
+{
+	int ret;
+
+	ret = misc_register(&dev_static_minor);
+	KUNIT_EXPECT_EQ(test, 0, ret);
+	KUNIT_EXPECT_EQ(test, LCD_MINOR, dev_static_minor.minor);
+	misc_deregister(&dev_static_minor);
+}
+
+static void kunit_misc_dynamic_minor(struct kunit *test)
+{
+	int ret;
+
+	ret = misc_register(&dev_misc_dynamic_minor);
+	KUNIT_EXPECT_EQ(test, 0, ret);
+	misc_deregister(&dev_misc_dynamic_minor);
+}
+
+static struct kunit_case test_cases[] = {
+	KUNIT_CASE(kunit_dynamic_minor),
+	KUNIT_CASE(kunit_static_minor),
+	KUNIT_CASE(kunit_misc_dynamic_minor),
+	{}
+};
+
+static struct kunit_suite test_suite = {
+	.name = "misc_minor_test",
+	.test_cases = test_cases,
+};
+kunit_test_suite(test_suite);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Vimal Agrawal");
+MODULE_DESCRIPTION("misc minor testing");
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 7315f643817a..5a5d27284e0a 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2488,6 +2488,17 @@ config TEST_RHASHTABLE
 config TEST_IDA
 	tristate "Perform selftest on IDA functions"
 
+config TEST_MISC_MINOR
+	tristate "Basic misc minor Kunit test" if !KUNIT_ALL_TESTS
+	depends on KUNIT
+	default KUNIT_ALL_TESTS
+	help
+	  Kunit test for the misc minor.
+	  It tests misc minor functions for dynamic and misc dynamic minor.
+	  This include misc_xxx functions
+
+	  If unsure, say N.
+
 config TEST_PARMAN
 	tristate "Perform selftest on priority array manager"
 	depends on PARMAN
-- 
2.17.1



Return-Path: <linux-kernel+bounces-407812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 912429C74A8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 15:44:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 501B8284464
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 14:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F059F1F4705;
	Wed, 13 Nov 2024 14:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="Qt1vGPrK"
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EBB9273F9
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 14:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731509007; cv=none; b=JYYKJJ1eYrEBei0Eg1cCti0bAwvUgS3Qpa7q8Lobe3Z2Ul6p09IDkN+VZ8IZ9PUY9KWbFRK5fziznqu1V8uhYdSAfbC20/TwHpjKje+USY057gQU6vEGsmayUkXK2goibQz1hDsi7I74tA/eFgjE0tdDCEj30qsq7gReT8H14qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731509007; c=relaxed/simple;
	bh=tnLZCx4F5XGyk+e0O8FKWgFLwp9r4wc7K2Rkv61DB1I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=X693ty6xUs6+v0voNrEk96Zqlr1QhBZ8/qK4SzbsFTum1mJGzSxD6GAnNcDXCxPt6U9YUf4zwhBFsjKFcXRvsEPhMd4849gIrzx7XoM+q7TML4ujHqgeN/K7v7tFOOgcSqVcCLz9hE9j2S/M5BdPhv8S7Ko2+kvgWvEpcTSmSCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=Qt1vGPrK; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1731508897;
	bh=tcccd3hBahsewM/oREozkbOfOAC3JC5LE7jpoIyvSG0=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=Qt1vGPrKCGfpqSMpsfPk7r+lqjDleEgwRVdyPgqDjnEcB8EKBkYqUy45NkBqTIKnL
	 BO7oGzWdLDKIdv1oz3X+qe/8IFxoDAhFu31ljTU9Ww82/pxGpsyK6sdx3WchZO/wTh
	 sIG7P5TwJCJVqmYRxCS+iLDEKB3b6QzLaHvo3+1o=
X-QQ-mid: bizesmtpip3t1731508890tnsri50
X-QQ-Originating-IP: 72EAmLEmLHjrTNLhjiWJbsIPwPf8mNCoZufANwO7KbQ=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 13 Nov 2024 22:41:29 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 3136521576167551353
From: Gou Hao <gouhao@uniontech.com>
To: hsiangkao@linux.alibaba.com,
	xiang@kernel.org,
	chao@kernel.org
Cc: linux-erofs@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	gouhaojake@163.com
Subject: [PATCH V2] erofs: simplify definition of the log functions
Date: Wed, 13 Nov 2024 22:41:28 +0800
Message-Id: <20241113144128.16007-1-gouhao@uniontech.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz7a-0
X-QQ-XMAILINFO: MxDmZisZxeG6tejz1Ix4o5+kvAUB8JTogwiI965QF/2lwbUjKCxma7Tj
	rNSPUY11+fXVG84FZTChrLCKDw/UuzZuwR3OcsGzBdsXOYdB9h329dN5wdV+erG+BHRQiL7
	gbYp95n38ZsiFpUlIixPrqat/1wUYXMZI++O/WJ3zESSNIE5iohUdOSz/xvFwSQLhAFkwXz
	XR5x6HnqBm3OKTz1nhE1ZdNkmcxR0pN0XV4K7WPg7QoL3PJcLpwt80/MHta4wBhY05+lg/H
	Gnq5B2cWUE+p04cODLAmf5O7yMZEaH9BeTCfWTh231p8tEi+jB2RLnJNEVqpqlPdzuK6ztf
	nwxdYD2VtSPoSqn1YMmQRntZUk36wB9gHeOGSy8ZgBEob79IOyr2gaTz+Bcszsp2GeP4Xrf
	aXH0VF5hI9GOSjwAK5Q/joZnLUVqFQQbweRxYrVJRidcI7QigEQjGc9pZGB+nsJIsXSYxAU
	oW1AMpnxObr1itWyavbY1bZnR8ztDZHpXnEq7pVpDAKHPNcf83mR2vi2O5kvjn8pnkXLkFI
	wA6ed7yXUA+pTlLLYoTvvVWRDebHezW9jZKPCdIT6Z3aZTGCOIrTCvyx+dgEEDHhoeEygM1
	PHQX5+zfD5MwFACOTnz0eu4GeeVN7sntCOSo14I4aPTXwZpspkh/97NWj27YNoOh1IPOCoG
	tigIxrUB6iZZ9L0Gn6QbC+B0rjfzq0e6upsPe2rRqopP/ZXA3sKNklphATIyTLkZx+cNsIo
	foNtGsUlKmZ2Qw6/98B0nWT/aTARGyy2lnGKvuB+dShIjTjOEBmtCPam10roMUIXI+NaGhS
	zIYLCFCXK9FP4PH93jXty2C3FDqY7MS4ugBsc2hJ5OrtPyBUl4eT9UzjhbFUDSgyPXmhICU
	akftEJVo8Wwq+437VJz4qDRT1aKyd0C9frH5SY97j1gmQFDc7K1yBwjyvIgwvfx6YOW2z/V
	XzjSUZeehsklFPk3slOyAph79Qp0iAjloQNXLEZiVqFLdTydsLLZtY3RJcHn6UvQEyqNaJJ
	kouD0prg==
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0

Use printk instead of pr_info/err to reduce
redundant code.

Signed-off-by: Gou Hao <gouhao@uniontech.com>
---
 fs/erofs/internal.h | 14 ++++----------
 fs/erofs/super.c    | 28 +++++++---------------------
 2 files changed, 11 insertions(+), 31 deletions(-)

Changes:
V2:
- remove 'const char  *function' from _erofs_printk
- remove pr_fmt macro, put 'erofs' prefix into printk

diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 4efd578d7c62..116c82588661 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -20,18 +20,12 @@
 #include <linux/iomap.h>
 #include "erofs_fs.h"
 
-/* redefine pr_fmt "erofs: " */
-#undef pr_fmt
-#define pr_fmt(fmt) "erofs: " fmt
-
-__printf(3, 4) void _erofs_err(struct super_block *sb,
-			       const char *function, const char *fmt, ...);
+__printf(2, 3) void _erofs_printk(struct super_block *sb, const char *fmt, ...);
 #define erofs_err(sb, fmt, ...)	\
-	_erofs_err(sb, __func__, fmt "\n", ##__VA_ARGS__)
-__printf(3, 4) void _erofs_info(struct super_block *sb,
-			       const char *function, const char *fmt, ...);
+	_erofs_printk(sb, KERN_ERR fmt "\n", ##__VA_ARGS__)
 #define erofs_info(sb, fmt, ...) \
-	_erofs_info(sb, __func__, fmt "\n", ##__VA_ARGS__)
+	_erofs_printk(sb, KERN_INFO fmt "\n", ##__VA_ARGS__)
+
 #ifdef CONFIG_EROFS_FS_DEBUG
 #define DBG_BUGON               BUG_ON
 #else
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 666873f745da..93b44b77a41c 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -18,37 +18,23 @@
 
 static struct kmem_cache *erofs_inode_cachep __read_mostly;
 
-void _erofs_err(struct super_block *sb, const char *func, const char *fmt, ...)
+void _erofs_printk(struct super_block *sb, const char *fmt, ...)
 {
 	struct va_format vaf;
 	va_list args;
+	int level;
 
 	va_start(args, fmt);
 
-	vaf.fmt = fmt;
+	level = printk_get_level(fmt);
+	vaf.fmt = printk_skip_level(fmt);
 	vaf.va = &args;
 
 	if (sb)
-		pr_err("(device %s): %s: %pV", sb->s_id, func, &vaf);
+		printk("%c%cerofs: (device %s): %pV",
+				KERN_SOH_ASCII, level, sb->s_id, &vaf);
 	else
-		pr_err("%s: %pV", func, &vaf);
-	va_end(args);
-}
-
-void _erofs_info(struct super_block *sb, const char *func, const char *fmt, ...)
-{
-	struct va_format vaf;
-	va_list args;
-
-	va_start(args, fmt);
-
-	vaf.fmt = fmt;
-	vaf.va = &args;
-
-	if (sb)
-		pr_info("(device %s): %pV", sb->s_id, &vaf);
-	else
-		pr_info("%pV", &vaf);
+		printk("%c%cerofs: %pV", KERN_SOH_ASCII, level, &vaf);
 	va_end(args);
 }
 
-- 
2.43.0



Return-Path: <linux-kernel+bounces-408526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1511D9C8006
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 02:34:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 483F3B22DB9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 01:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAEF8157A48;
	Thu, 14 Nov 2024 01:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="g/v4M0GF"
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B292309B8
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 01:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731548055; cv=none; b=k0L6rXwB6U8ii4HibFHRuH5NV1Cvsy+qzupyRmPbRIfR4CDOad+hSl5SOd4cELRIxb0CGGajx7U+jGMSQRZkTMnboBWPRAlE6OEivhrjNzSJt8KYvhaky+kyz1gvy9IJiecq0qDOLt/P/j2MBMZIk9TNdAEJtOeNyc7pOWzMEQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731548055; c=relaxed/simple;
	bh=MkqEAy9rJygmI+u0JmmAatSa65N148hGK9JCmQrphIo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WmSmi81Yr+fZ0oyVBS1ZTC51YQ/wKhaB4F0KrFDvU3VFZTXgKv4CwZStvuUxs3D0fekwXxWJ6kY7ErJ+MlnR7urDgfHS6nvH4/+fFDX/q9988y3FQgVQq+Minw5LT3+R5l4erO0r9CbU3dl9CkjzKyBNPZqacQAyvaGkV5LmLuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=g/v4M0GF; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1731547974;
	bh=AwT/xsQdOK1ErrtmBGR2Ev8dEqXwL9El7iE9kODgv/w=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=g/v4M0GF2oJeMjNN7MXekNm3KzLOlp8TRDQ7ZPETO7G3kOC1AsBpfc6Tutb5UQm3W
	 vFvogZ67P2SWGkR3t1gCOVZO11iVuyzRy0O8Kas6UjVlvuSG+DNP2z6mP+N83fpkjk
	 +eWB9ibhuiJPVWjUTrsm6TtJi3dWh4G0wwLTbAXU=
X-QQ-mid: bizesmtp82t1731547969t9md095l
X-QQ-Originating-IP: loctKRkCEdTne9wB4ucN+gum6+Bu5hoPIGsSy+eNflk=
Received: from localhost.localdomain ( [125.76.217.162])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 14 Nov 2024 09:32:47 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 14376911624389434776
From: Gou Hao <gouhao@uniontech.com>
To: xiang@kernel.org,
	chao@kernel.org
Cc: linux-erofs@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	gouhaojake@163.com
Subject: [PATCH V3] erofs: simplify definition of the log functions
Date: Thu, 14 Nov 2024 09:32:47 +0800
Message-Id: <20241114013247.30821-1-gouhao@uniontech.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvrgz:qybglogicsvrgz7a-0
X-QQ-XMAILINFO: Nb3zvKU22AlHj27GfFdnWr0ypu4580MAOeU2CkcQtK1XpQEskr0jgL6J
	tO2tz1NOEm/Lv5uV54kU9fPwxsyYnXjSMsF0JmlIbDtcDDT5Wq23DUcUwbTX/HxaNHhG95w
	Xw6RZvlLGj8pxV1JfPuuMIq5H85x1nYNj1yr1+ezhrLNZrvGbdoj25s8MGYte4GVM4/BjX6
	prrWvgLWccqF7mGFRUcK33z4OGhk8/IK87jAESpsKLMaS/OaC2NsvVEGRG08ZxaHQvT/dyX
	kVhbMt0oh6LYj8fnNc8h6Rg3pJ7W0gWljDxYmi+UC0BDfww7uAPEQUyrV52TOP7wYPYML5O
	lBoFW24PhHChH/bKUyCnoCBE52eo1MarwvvBipiY4dO0dZo6SB70+R8m4nBV3netJQDBGWp
	y+L7JBVEvamGEsmJf5vghfh72KIV5TMML70lEVm1egsY4mjSc7LqlBSJmfB31Heo3KkLK1h
	usJDDgdCNXJyJSYw256Mb8GOA4bcsVgF246Xw1AxT3vH7Jln5bQgBPJdHUFhbf5FmKkumTD
	Uum+UuNFJBR1eun1TsjAW2upSGCXnjR3siBLKZi6J5RDnyyX65ahtI8NungQ9g9NifS46Q/
	PU03N3wXjxPAHt3SZfF++jvQYK2UCDg7IjkiIGBItT7zkqgLnVhvmZEf5p0IlhQXJLGoqHE
	fC51QkgdSTNjWbq4ij0+UnKSqSSXUDRpQCoPuB6bn1a3b62tBkh3I8IyGj6XcLzNsMSUmd2
	VqbERtu7d4xxjEeD1KCaX7IyS+NIK3wYexkDdhuOqAuYqM+O2Dakdm0aavxBj6hGkH1rU2q
	NHmbaNLsfJYSYpyRUvVToi5/h3XfXKNgHWiVvwuI6vum9iuLABixwFjUwWlxC6BDIsxDS7X
	JAy1PXf271fj9gcA5+KdFPWlZrVFcFeu4GjPskHTa4WBbhT+x+jPlqZVU+9FmP8t0K07bX4
	NSNgBHONfCKNRs4J2vMWS2LN9IfzZb6/4Ln7cEw1LEulZKokJwA4XWAOKq3NoqYZyt3W3S6
	NxJjOdtQ==
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-RECHKSPAM: 0

Use printk instead of pr_info/err to reduce
redundant code.

Signed-off-by: Gou Hao <gouhao@uniontech.com>
---
 fs/erofs/internal.h | 14 ++++----------
 fs/erofs/super.c    | 28 +++++++---------------------
 2 files changed, 11 insertions(+), 31 deletions(-)

Changes:
V3:
- optimize the printing format of device

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
index 666873f745da..8dcd543df0b8 100644
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
+		printk("%c%cerofs (device %s): %pV",
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



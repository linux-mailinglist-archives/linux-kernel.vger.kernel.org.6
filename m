Return-Path: <linux-kernel+bounces-368308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 831F29A0E19
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 17:26:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B49EF1C2259C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 15:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B530D20E02C;
	Wed, 16 Oct 2024 15:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="KIFF3QeQ"
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC50205E23
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 15:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729092358; cv=none; b=h4JqFebCDuNSdawMaltU14wltuR++EET7AkeAOkfRFVOVW6m16wRAKptrT8Wg06JptToj8Dw/8+mJAERRxZXvwcPKkynykgp+h1AnMkPVWiG25SDQTnDBqqt3f3kiNhvdJp8teFfZ7LAYKQX6giHWGsiUlVi49jzOA51mZC4c9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729092358; c=relaxed/simple;
	bh=0RzARDRlWc5+HtK+OH9hSAldj84leQRL8tbu2dOURic=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PaZi5vz6pn0LrHOS2jB5VWKvt78nv5z+Dx2j4m71+wWn1MBBXz53GUHVB2iEuhsfnwaNg9Ej9lx/LpBAh4XYoQ+vcEyVKSW5ysybkm1nMJ9txmco8V+s4FEvh5tQj+5ioX92J+FgZYf5hY7Y83XTxvewZtEu7aVhOHLoGqh4Wpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=KIFF3QeQ; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1729092281;
	bh=vB1hUB3M9LhQsGZAEMAIo3fk/xV7YVlDQIbsTTEu5No=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=KIFF3QeQHL5UIMFrwynrmzlmd4OlsCI1vfYURgMCW1LJc6S13XvLNdEnoPoDoARdQ
	 oZkQPV5dtgyt0L+/+jXEwCPJR6KbAgIH4ySqM0d1/lMfY6xQ/8eP5ZySvQB2YSCgRF
	 YvYBt7NouT655kEmRi9qVnGIVipEMnYLTsfEm0o8=
X-QQ-mid: bizesmtpsz6t1729092276t1b4xap
X-QQ-Originating-IP: GS+3cUN34jLeckU9KaN79l4tFlKPU7EVSqyZ6w9JNtw=
Received: from localhost.localdomain ( [125.76.217.162])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 16 Oct 2024 23:24:35 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 1428879770323960825
From: Gou Hao <gouhao@uniontech.com>
To: xiang@kernel.org,
	chao@kernel.org
Cc: linux-erofs@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	gouhaojake@163.com
Subject: [PATCH 2/2] erofs: simplify declaration of the log functions
Date: Wed, 16 Oct 2024 23:24:30 +0800
Message-Id: <20241016152430.3456-2-gouhao@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20241016152430.3456-1-gouhao@uniontech.com>
References: <20241016152430.3456-1-gouhao@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz7a-0
X-QQ-XMAILINFO: NamDlXnbz6wMX8l/4JNXYU+tFd8+3B8JtCWbKOmRaN4IQgugLpHG1G9j
	NdtVFbdI0zkpm96PWKWjeVkNexqiFV69jGEU8uSlW+Tqy1+Oh1HMVnBC/PLQt1vqmTfRHZB
	dPN4GhROl5fWvf619QWHFAq3W5HT2D0wCNo4QHLMbE7XA6heO3MSi+ds8JIQHDwxrXEZg39
	9UBJQGeLOYMTKEUAYowyyIPRpkHPXG0KBicMJL8YrvcY2KX3wBD6PxZVAub3dFq+pzWjkzW
	lC8aaa2tm3ZfTqkWd49K1b4Fnvs8CZwovnFkdJbNiP2AzatFI5QEtp2xOKQAXjNm+Wq9rsG
	JDUBtWEkoWzUbIW6NYi49OM+F/Oq7tsQpbSoiEegpfiNmMQHbDCnwOgd0zaq+xHRVwJD1lI
	hh7ElDCunWoLCArVpXTsSkABXePq/f6md4e1ipCmFqRhVwBRNOokm9gN1GHuTExXSZGy3ow
	fUaS2WNwJMzSpjtJbynNEROghk+zfUitOhVOhGkzBjgtJImFB/oA0r3Jq0PxQpXo6/3i3zJ
	wpNVUEQ8EplSRH8FuMqe7KSXoUuFY4mU4Yv8p1qvgKevONse/ggIxm5ya0ds9+PtRJqV7Bh
	vZ7SJgdheZaZYHYoSsXLojQH0uenbMlIFUmwCUtwAeZEM6Pc4rKKsxrHwQKXMNadzSq6Q1+
	lvKnVJuk2j9cz7bKQvZZNXQ7lD/kLj3MdFdmhNmTEpng9/0ks6WQqmVSAnYI7mAnCkz2Npv
	I/Dne7c1znn5J/2ZZ+daw2H68xYMlbrdsW0xw1Pr6jnMo4okBbwpY44/FOX0kHgd+33X+bH
	8keK1reX7qWPNmYYekGAjisjxsh1i1HAlGh5hbcM+2tYmDMNHclBcIzCZmCwM2nSWdSFAzV
	XhwU1NvHrGuw1Chl3QL3ClwRzJKZH62b0BWhOi6y3EkLp4UJAm89Spbwp8l4GYrw6yzrGpH
	ECXhAs9JxbOF5dsCxNuzR9996nG1gk5R+VQZfcPpbOajJBgURy5ObD7EQQCJ79d0InLmH3P
	6WUiOJP/1DhXnL0qVH0BcK5NHSpzo=
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
X-QQ-RECHKSPAM: 0

remove the macro of the log declarations.

Signed-off-by: Gou Hao <gouhao@uniontech.com>
---
 fs/erofs/internal.h | 13 +++++--------
 fs/erofs/super.c    | 12 ++++++------
 2 files changed, 11 insertions(+), 14 deletions(-)

diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 4efd578d7c62..0c3d6b9f85b5 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -24,14 +24,11 @@
 #undef pr_fmt
 #define pr_fmt(fmt) "erofs: " fmt
 
-__printf(3, 4) void _erofs_err(struct super_block *sb,
-			       const char *function, const char *fmt, ...);
-#define erofs_err(sb, fmt, ...)	\
-	_erofs_err(sb, __func__, fmt "\n", ##__VA_ARGS__)
-__printf(3, 4) void _erofs_info(struct super_block *sb,
-			       const char *function, const char *fmt, ...);
-#define erofs_info(sb, fmt, ...) \
-	_erofs_info(sb, __func__, fmt "\n", ##__VA_ARGS__)
+#define erofs_log_declare(name) \
+	__printf(2, 3) void erofs_##name(struct super_block *sb, const char *fmt, ...)
+erofs_log_declare(err);
+erofs_log_declare(info);
+
 #ifdef CONFIG_EROFS_FS_DEBUG
 #define DBG_BUGON               BUG_ON
 #else
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index b04f888c8123..587a56e390ff 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -18,8 +18,8 @@
 
 static struct kmem_cache *erofs_inode_cachep __read_mostly;
 
-#define _erofs_log_def(name) \
-	void _erofs_##name(struct super_block *sb, const char *func, const char *fmt, ...) \
+#define erofs_log_def(name) \
+	__printf(2, 3) void erofs_##name(struct super_block *sb, const char *fmt, ...) \
 	{ \
 		struct va_format vaf; \
 		va_list args; \
@@ -30,14 +30,14 @@ static struct kmem_cache *erofs_inode_cachep __read_mostly;
 		vaf.va = &args; \
 		\
 		if ((sb)) \
-			pr_##name("(device %s): %s: %pV", (sb)->s_id, (func), &vaf); \
+			pr_##name("(device %s): %s: %pV\n", (sb)->s_id, __func__, &vaf); \
 		else \
-			pr_##name("%s: %pV", (func), &vaf); \
+			pr_##name("%s: %pV\n", __func__, &vaf); \
 		va_end(args); \
 	}
 
-_erofs_log_def(err);
-_erofs_log_def(info);
+erofs_log_def(err);
+erofs_log_def(info);
 
 static int erofs_superblock_csum_verify(struct super_block *sb, void *sbdata)
 {
-- 
2.20.1



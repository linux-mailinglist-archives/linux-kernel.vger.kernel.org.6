Return-Path: <linux-kernel+bounces-370896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7113E9A3366
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 05:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A24271C23081
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 03:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB43115445B;
	Fri, 18 Oct 2024 03:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="U9YT4aHz"
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7E320E31F
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 03:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729222578; cv=none; b=rNx2qEjp4TmOfC7wsrV9pb2iPo+bTEDXJpswe4MyuRjef3AjuDtuo3e8UacXdB+wyNjFbz1CjR/FN6EnTpfpCTwQNGQuGa5LyXyyTLrFy59CTb1ex65dy1ptUV+qK9ntO/EOAvxF9RKL5HZIs7KYzg0Z9n8/rKxFO3yOSdLXtqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729222578; c=relaxed/simple;
	bh=qh46V5QJ0S5FbKr0cToN5MJ7FlTejE4OIsYSSNAKMQU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HqR3qKRCzHlJ7KE0V44WjVjQ3FyG5hLf87S2cvVTfuvb15TvYFCbC55UcauLKfcE5kkQnV7sV1wJ8ohSkOrfdLq37xjHvLTK+4Asx/+kl7+gn8tpZCtKr5HyM8pvZeUsXxL6RbT2YAHxvg/19LuAh+O0HkTmaTPi8XpKL9E4y/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=U9YT4aHz; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1729222514;
	bh=dJt0LZgs1we73SmL7597byDoDeUoixIoLW4Jf9xhQ1w=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=U9YT4aHztTFvJDbjXKHF3AstQ9Mns9MAcKxxQAw42sTi1nntUyYt9e23DmAQBYF+2
	 7Od3zBHbP3duCjHczD5RovqQY08wEtk+DaB850M5KuGeN2K+m8TZt4yW8/LDKU3wFh
	 v1TCDCwqq8He7TaFs+2Q/AXqcS5E3yWj80VJAi00=
X-QQ-mid: bizesmtpsz9t1729222508t4opddc
X-QQ-Originating-IP: N9SNgAW4on53IO1biD0K/z4f73woKuokm0dUG5+ll/s=
Received: from localhost.localdomain ( [125.76.217.162])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 18 Oct 2024 11:35:06 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 14635534401801183075
From: Gou Hao <gouhao@uniontech.com>
To: xiang@kernel.org,
	chao@kernel.org
Cc: linux-erofs@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	gouhaojake@163.com
Subject: [PATCH] erofs: simplify definition of the log functions
Date: Fri, 18 Oct 2024 11:35:00 +0800
Message-Id: <20241018033500.13833-1-gouhao@uniontech.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz7a-0
X-QQ-XMAILINFO: NDtUtlvFer7v2yh8T/W30O4bU1VmTNB0ZMtiFoIKuaiGGibea+vvG4yg
	0Vk9rJ3Tv7TTELH4YK38jQV8UNMc08bU9VqnyBB2jlxHY6ntLb2B3kxW13oZDft/nriicKe
	7lF77bQKOmXD8Vb5UL+I2qFoiSEtWNu6CEidytx9fwcvB95++wUdB3q8+CmuyT0NGaCpbn3
	YAp55ErMSAGtnOY9JU2lPMGJ00HZp/Es2UaemDNWlncm6yqCfy8US57IsJfAXlIp4L8GpJB
	eZzCHQrfn/MaF8bdnFOWDRgOfkip/cKDV609eI+Hl5spZNI7vhn9MbgUzMqjPUlna4YUNfS
	Yyr/FxkTJcK/TCnHkgzAjR4+aG3OoOyxOy+wX+A7Q6dq8FI9WfmIyTy2aGjE/wXTR3fbZ46
	fZ26zy6ZNqUv5qcMN7AATviCggaB+f9AKzGqu6p3KR1xq+hJeYR/SsYX4yFMVqlTG6OwMt2
	xNjZNzQFRFbhLC5eHymxQYtRnR7maWPRfFpNvsgSGoVPdhP0rZdfj/JbTRgGzU6knmU1UnW
	JO3Znv3U2iH9sYHQgpfR8CoUmQAzfV4t6LM2hGXRAi/Y6Yus1CZmsEuRVt//SYFfXgyVsS7
	Oq7am9iuiRhhrjEY4Otx4EPiyRtrBElUfeKkgFFj61q1jMyOlagmg4EAE+mQs8oqEedK9gn
	Ep5xU5fP6V5mpj1KzaEbr4j0YnNcDJqNtydQ2zBxHijKwAmJvipUurWRFSuMoSUKHRGRv52
	qNpjwjJywoPilQ/4077cNwtKAGqkcxcgc+CNJJ/Gb48Ekgm2X+4aNGtHuZA8yf3mE+Sf+fG
	PaD4S21ogawPw5nBfXAfaZlVM97X1Yd01kp1mTMbbq+irnhjMwhNQ3V9roIdKaL5CeZsavJ
	0P+B6akDwWJXEGcN2Jr3FuZYzpChRtvGQwe7e9JGYihR6SXcpkrVN5cjQqpQ2zY7cMiEPPV
	KRS5O8JZoi6vFx27yRupmP7h1
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
X-QQ-RECHKSPAM: 0

using printk instead of pr_info/err, reduce
redundant code.

Signed-off-by: Gou Hao <gouhao@uniontech.com>
---
 fs/erofs/internal.h |  9 ++++-----
 fs/erofs/super.c    | 28 +++++++---------------------
 2 files changed, 11 insertions(+), 26 deletions(-)

diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 4efd578d7c62..ae87e855e815 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -24,14 +24,13 @@
 #undef pr_fmt
 #define pr_fmt(fmt) "erofs: " fmt
 
-__printf(3, 4) void _erofs_err(struct super_block *sb,
+__printf(3, 4) void _erofs_printk(struct super_block *sb,
 			       const char *function, const char *fmt, ...);
 #define erofs_err(sb, fmt, ...)	\
-	_erofs_err(sb, __func__, fmt "\n", ##__VA_ARGS__)
-__printf(3, 4) void _erofs_info(struct super_block *sb,
-			       const char *function, const char *fmt, ...);
+	_erofs_printk(sb, __func__, KERN_ERR fmt "\n", ##__VA_ARGS__)
 #define erofs_info(sb, fmt, ...) \
-	_erofs_info(sb, __func__, fmt "\n", ##__VA_ARGS__)
+	_erofs_printk(sb, __func__, KERN_INFO fmt "\n", ##__VA_ARGS__)
+
 #ifdef CONFIG_EROFS_FS_DEBUG
 #define DBG_BUGON               BUG_ON
 #else
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 666873f745da..64c3258ddf9a 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -18,37 +18,23 @@
 
 static struct kmem_cache *erofs_inode_cachep __read_mostly;
 
-void _erofs_err(struct super_block *sb, const char *func, const char *fmt, ...)
+void _erofs_printk(struct super_block *sb, const char *func, const char *fmt, ...)
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
+		printk("%c%c(device %s): %s: %pV",
+				KERN_SOH_ASCII, level, sb->s_id, func, &vaf);
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
+		printk("%c%c%s: %pV", KERN_SOH_ASCII, level, func, &vaf);
 	va_end(args);
 }
 
-- 
2.43.0



Return-Path: <linux-kernel+bounces-339252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 96916986449
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 17:57:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9569B269B6
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 14:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9031118C335;
	Wed, 25 Sep 2024 14:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="hyO85nw+"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FBBC146D6E
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 14:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727274771; cv=none; b=Gc1UqlOMA9A1HQqOBKWzPIDglMH2ryPEWd71stR9teBI2wCcenGy8hf6b2wCWLKwatXb7eJrms8oNYHLBdrIZrKZB3MOP5M83o+TwIgfZ6dK2Sy3fgAU7FZYkbD5RhhTygPB3+0UgNXJnwl7fnPZ4SlRgI0Iwhx6vKvGvczfv10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727274771; c=relaxed/simple;
	bh=VGSRAlwxCU0J1GIEpYFTTROHcDFhL4lfwhRo/27QYkM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qjhlvYNPJqzfPQLCySJSA2ruAs2Dh+qETmFFiQil7GFLsGE8+GLXvhLPGO4ufIELQWlxPc7EnHUBdt3DXXW8+MuMYGhsWebmn5j9SxTFB3VKh6Ydij1fB15bo277FYfyAuCYkFvRKXSU71wwNE4bUniAYjQDWEnw01Q1isGRkv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=hyO85nw+; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=Q5Eiu
	Vc5mpkjolusR0Mp9uhxQxccRS+YA1w3NEqDb/o=; b=hyO85nw+BvCJMkG7tpCMg
	qnn68KB+tv2QYWDAo8q8r1KepVkbewAKriF+wVaO07eH5QPRx1miqXxoW5VPWy2u
	8pA8WGWxfp2KvVKlHeHF7Eo7WA34HE5EsMVB5hED08rptzGEJg1kwBqVwuEYfdTZ
	6aghPeJDSN0ES1wBDJyVTM=
Received: from localhost.localdomain (unknown [193.203.214.57])
	by gzga-smtp-mta-g2-2 (Coremail) with SMTP id _____wDn9EXeHvRmGMqpJA--.33673S6;
	Wed, 25 Sep 2024 22:32:08 +0800 (CST)
From: ran xiaokai <ranxiaokai627@163.com>
To: elver@google.com,
	tglx@linutronix.de,
	dvyukov@google.com
Cc: kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	Ran Xiaokai <ran.xiaokai@zte.com.cn>
Subject: [PATCH 2/4] kcsan, debugfs: refactor set_report_filterlist_whitelist() to return a value
Date: Wed, 25 Sep 2024 14:31:52 +0000
Message-Id: <20240925143154.2322926-3-ranxiaokai627@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240925143154.2322926-1-ranxiaokai627@163.com>
References: <20240925143154.2322926-1-ranxiaokai627@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDn9EXeHvRmGMqpJA--.33673S6
X-Coremail-Antispam: 1Uf129KBjvJXoW7KFy3GF13KFWUGrWDtr1UZFb_yoW8uF1fpa
	s8G3s8JryvqF1FyrW5CFW5W3yrKr95Xr12va47ur9rAF1qqr4q9a1fKF9Yv3yYgry0vr4D
	WFs0vFZ8AF4DJaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jqeHDUUUUU=
X-CM-SenderInfo: xudq5x5drntxqwsxqiywtou0bp/1tbiqRhlTGb0HXEZ0QAAsu

From: Ran Xiaokai <ran.xiaokai@zte.com.cn>

This is a preparation patch, when converted to rcu lock,
set_report_filterlist_whitelist() may fail due to memory alloction,
refactor it to return a value, so the error codes can be
passed to the userspace.

Signed-off-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
---
 kernel/kcsan/debugfs.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/kernel/kcsan/debugfs.c b/kernel/kcsan/debugfs.c
index ed483987869e..30547507f497 100644
--- a/kernel/kcsan/debugfs.c
+++ b/kernel/kcsan/debugfs.c
@@ -131,13 +131,14 @@ bool kcsan_skip_report_debugfs(unsigned long func_addr)
 	return ret;
 }
 
-static void set_report_filterlist_whitelist(bool whitelist)
+static ssize_t set_report_filterlist_whitelist(bool whitelist)
 {
 	unsigned long flags;
 
 	spin_lock_irqsave(&report_filterlist_lock, flags);
 	report_filterlist.whitelist = whitelist;
 	spin_unlock_irqrestore(&report_filterlist_lock, flags);
+	return 0;
 }
 
 /* Returns 0 on success, error-code otherwise. */
@@ -225,6 +226,7 @@ debugfs_write(struct file *file, const char __user *buf, size_t count, loff_t *o
 	char kbuf[KSYM_NAME_LEN];
 	char *arg;
 	const size_t read_len = min(count, sizeof(kbuf) - 1);
+	ssize_t ret;
 
 	if (copy_from_user(kbuf, buf, read_len))
 		return -EFAULT;
@@ -242,19 +244,19 @@ debugfs_write(struct file *file, const char __user *buf, size_t count, loff_t *o
 			return -EINVAL;
 		microbenchmark(iters);
 	} else if (!strcmp(arg, "whitelist")) {
-		set_report_filterlist_whitelist(true);
+		ret = set_report_filterlist_whitelist(true);
 	} else if (!strcmp(arg, "blacklist")) {
-		set_report_filterlist_whitelist(false);
+		ret = set_report_filterlist_whitelist(false);
 	} else if (arg[0] == '!') {
-		ssize_t ret = insert_report_filterlist(&arg[1]);
-
-		if (ret < 0)
-			return ret;
+		ret = insert_report_filterlist(&arg[1]);
 	} else {
 		return -EINVAL;
 	}
 
-	return count;
+	if (ret < 0)
+		return ret;
+	else
+		return count;
 }
 
 static const struct file_operations debugfs_ops =
-- 
2.15.2



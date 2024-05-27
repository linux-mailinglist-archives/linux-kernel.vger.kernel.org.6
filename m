Return-Path: <linux-kernel+bounces-190744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED848D0210
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 15:44:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64E0EB2C72A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 13:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0C8B15FA60;
	Mon, 27 May 2024 13:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="E+YWuJqJ"
Received: from out187-21.us.a.mail.aliyun.com (out187-21.us.a.mail.aliyun.com [47.90.187.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3EA15F402
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 13:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.187.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716817259; cv=none; b=KjIxbJ7QFVFPDVmBRqShSdknzTRUtdXFAzPZkDakOPYydUbII8txA0AG5zpIyZfdMUHEgXPq6pG66Fg5Qi5Ct6oVhwJ4TRxzI7uMZ5PV6ZeH15uJpHouikxkCNcH72Telj08t2e9cumzhf7R7TUXJ+XWhjW0PT5ZITJwXUxaLHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716817259; c=relaxed/simple;
	bh=BBlh1DPns5C2oAF8vnyB3bE/HFKCbRe/Qz+OCUEIZe4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ealgT3l5RLvv/DjHlNB6WH5g+LmLmB0BM3gmRh4Ao6rsL6B7zAuYRUb+HCZGUE+7LLilChpMvVPBZdEtbFJQNRzJtTwHufmexMe5mYJnVonIsjY3QCEOouE2wUqMo1I2pE6uClIjWiK4AR1s6FLUIVtD47tv05OLbM1tlK6NFmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=E+YWuJqJ; arc=none smtp.client-ip=47.90.187.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1716817239; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=aPhgJtNbevvD4n484o242Ca+ulgY/TKUr1VEB8WBEMY=;
	b=E+YWuJqJOgnlDsb5yAqrhFikW4MPZtR/A5qpE4Ns+YZ2jeMjMqrbsVJEhfSqGBO0ppb0lvPmxTk79Celpw9sy+gbIn68i0ccBrbO0uAwmIL59d4YeWfZhtrN+ji/nB1bBFB8gqoyZhj7j+4un+rFHxLMbeJQ+ok85w/0YaMmhJY=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033070021168;MF=tiwei.btw@antgroup.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---.XofsrHN_1716817238;
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.XofsrHN_1716817238)
          by smtp.aliyun-inc.com;
          Mon, 27 May 2024 21:40:38 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc:  <linux-um@lists.infradead.org>,
   <linux-kernel@vger.kernel.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH 2/2] um: Remove /proc/sysemu support code
Date: Mon, 27 May 2024 21:40:24 +0800
Message-Id: <20240527134024.1539848-3-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240527134024.1539848-1-tiwei.btw@antgroup.com>
References: <20240527134024.1539848-1-tiwei.btw@antgroup.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently /proc/sysemu will never be registered, as sysemu_supported
is initialized to zero implicitly and no code updates it. And there is
also nothing to configure via sysemu in UML anymore.

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/kernel/process.c | 67 ----------------------------------------
 1 file changed, 67 deletions(-)

diff --git a/arch/um/kernel/process.c b/arch/um/kernel/process.c
index d2134802f6a8..79f41f06a98f 100644
--- a/arch/um/kernel/process.c
+++ b/arch/um/kernel/process.c
@@ -237,73 +237,6 @@ int copy_from_user_proc(void *to, void __user *from, int size)
 	return copy_from_user(to, from, size);
 }
 
-static atomic_t using_sysemu = ATOMIC_INIT(0);
-int sysemu_supported;
-
-static void set_using_sysemu(int value)
-{
-	if (value > sysemu_supported)
-		return;
-	atomic_set(&using_sysemu, value);
-}
-
-static int get_using_sysemu(void)
-{
-	return atomic_read(&using_sysemu);
-}
-
-static int sysemu_proc_show(struct seq_file *m, void *v)
-{
-	seq_printf(m, "%d\n", get_using_sysemu());
-	return 0;
-}
-
-static int sysemu_proc_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, sysemu_proc_show, NULL);
-}
-
-static ssize_t sysemu_proc_write(struct file *file, const char __user *buf,
-				 size_t count, loff_t *pos)
-{
-	char tmp[2];
-
-	if (copy_from_user(tmp, buf, 1))
-		return -EFAULT;
-
-	if (tmp[0] >= '0' && tmp[0] <= '2')
-		set_using_sysemu(tmp[0] - '0');
-	/* We use the first char, but pretend to write everything */
-	return count;
-}
-
-static const struct proc_ops sysemu_proc_ops = {
-	.proc_open	= sysemu_proc_open,
-	.proc_read	= seq_read,
-	.proc_lseek	= seq_lseek,
-	.proc_release	= single_release,
-	.proc_write	= sysemu_proc_write,
-};
-
-static int __init make_proc_sysemu(void)
-{
-	struct proc_dir_entry *ent;
-	if (!sysemu_supported)
-		return 0;
-
-	ent = proc_create("sysemu", 0600, NULL, &sysemu_proc_ops);
-
-	if (ent == NULL)
-	{
-		printk(KERN_WARNING "Failed to register /proc/sysemu\n");
-		return 0;
-	}
-
-	return 0;
-}
-
-late_initcall(make_proc_sysemu);
-
 int singlestepping(void)
 {
 	return test_thread_flag(TIF_SINGLESTEP);
-- 
2.34.1



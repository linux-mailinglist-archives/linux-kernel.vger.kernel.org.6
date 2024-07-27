Return-Path: <linux-kernel+bounces-263977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE9393DD73
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 07:57:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5858A1F23B8A
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 05:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 733A51B974;
	Sat, 27 Jul 2024 05:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="UEQZC/KP"
Received: from out203-205-221-245.mail.qq.com (out203-205-221-245.mail.qq.com [203.205.221.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E96A4A15
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 05:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722059820; cv=none; b=bNZYKtyM/0dTJ+I/DpcpzlHA8Y6YZo3Vlff1rvTMPb3hWCty4jr1IHeyN2iZtP6ksi1w9RUvcNXblZFXp1D9Ud9nIOyOlVT+JNDDQNu/nMb1ODSx2EVPlemlrNfdOwrhaggJY+IaPgs8uckDRwCWipKyUS/IFRaxjc8Ajt02xZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722059820; c=relaxed/simple;
	bh=ZUPHT8xBRNd99Oh1SNWUpnaJeD+1yPzBqpvUcCOGHwA=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=nATomInh5kIN1s5M6WIrk6kFyTUucOZPEpJI4uI+a9s0zEUdTfCtPU75d3204U3pDDc+8WifSx92kwroTtcvX/G+yfpNQvD+Div7Tbug7x/At79nvIxO+VqXuupsXGU6qsVk7V6sQiFAzwxiOkU/Ak4hlN7eNS5/SWTegJtA09c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=UEQZC/KP; arc=none smtp.client-ip=203.205.221.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1722059815; bh=zbSS+ajYypXg92Z/q7nSeFt+R/QQz5CJOPsbYcOtdj0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UEQZC/KPG7t/x+wlaaU2qd6pCZ9MapP5JEAcRXnOH5UBDNJbYp8S9IWecO7vit/VH
	 St9Jvi8222Q+WNA1X2T4x7j7tYILcFxHT3mXZn80ohVUuDC3MrRPmo58Rg1kETXpRS
	 6zWo6ElYdfHtDnzNo9lqXm+2XYFYeAAOg7TpiZKg=
Received: from pek-lxu-l1.wrs.com ([111.198.228.103])
	by newxmesmtplogicsvrszb16-1.qq.com (NewEsmtp) with SMTP
	id E342E056; Sat, 27 Jul 2024 13:56:52 +0800
X-QQ-mid: xmsmtpt1722059812tjpbhik0q
Message-ID: <tencent_CA1DBB2E333C9E521B814B291BDA25D7BA08@qq.com>
X-QQ-XMAILINFO: MdoRYM9mYrydMDhbCpm8ury3tFQsl48ql/AgBElB1v2x9S06raK/RrIkgwRZfn
	 MYz5x0TEA+128JO8j7/zVqJvcdRCU1M0BkydoPJIlZTTAtQ1EJBxkJuBsRHxhlSm0ntZtKuuQn+Q
	 vdOvRFiRnZHMmsTBfPHtT9943DSwvAV+qv+8u6qKALJsbW6gbep4D5bprvs1MhebHzWvsMlHvugu
	 QlqcV0ZUVXp7uAgkPcuC3JQdUkmM1c67gm3NAO0XA6GR72/MxuuLSN8wQ2ssCp6yyo9HWUk4cMmM
	 S0LDEmqWMiFipHijj9lvEv4KPDGLJIO/ahCM6r4t0JE59bq0H8iHkfsYCNluNT74ilwhIAtBHqIv
	 BTbeLKOAvv3WL2yqOMpXPS0ezS7cIJ1ZML5oy2EKhalfezQRV4iZBo5IA2BPnwlA+sRjD1byV773
	 YTFZQm30vlKVcPjsCh/toesg/5xtbPLJhZp7VFVWxETIGK8EcIB8OIPp0GZHWCHJga8leIybsgzG
	 P3BPk4nHt4l7QrrSowyt92YJ/JdeN6gTZk3Ptdkad3FamnaA3NnguTht3WeGG04tJQ8jE4KqJrjR
	 Wf5Deo+Pq0FeuJ1aLPIC1QF9N4HkRW7qlqfE/yxa42IvflHi6/P9a389+/l6JHQsi8GAPM4P+C4d
	 hcJf74tIUepBjkurHpFWiVsjvCn6Xdg8nmtGzm+mqj1ynigYvtS8tP56E19d2LB5ih4cJzBONEYW
	 iHl4/dc+oOO7dcWUCO4R2JSu6mTgOA7GUE1WdR06lWFwkxwWP8NM4MT3UZ0MrczVjnJB7dJUqKkG
	 jVI9Qpeepz3ufF31gRGC7ZPmFLTuRYlld7KC7EOB3wg4w0AQmJqVPulcZqsGPVEV5jCgEawmG66Q
	 g5zilatLdRcWlgj3jnpj3ntQKfeWIDVIy/CVWhHdyIlvevSJGYry9PpSHjCN+pW7hYiXYiHPt4
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+1a8e2b31f2ac9bd3d148@syzkaller.appspotmail.com
Cc: chao@kernel.org,
	daehojeong@google.com,
	jaegeuk@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH] f2fs: Add mutex to prevent gc task from being accessed before initialization
Date: Sat, 27 Jul 2024 13:56:53 +0800
X-OQ-MSGID: <20240727055652.2700649-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <0000000000005c7ccb061e032b9b@google.com>
References: <0000000000005c7ccb061e032b9b@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot report null-ptr-deref Write in f2fs_stop_gc_thread, because 
shutdown and remount can cause multi-path entry into f2fs_stop_gc_thread,
resulting in incorrect access to f2fs_gc_task before it is properly
initialized.

Reported-and-tested-by: syzbot+1a8e2b31f2ac9bd3d148@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=1a8e2b31f2ac9bd3d148
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 fs/f2fs/gc.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 6066c6eecf41..a624e8271fbc 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -27,6 +27,7 @@ static struct kmem_cache *victim_entry_slab;
 
 static unsigned int count_bits(const unsigned long *addr,
 				unsigned int offset, unsigned int len);
+static DEFINE_MUTEX(gc_lock);
 
 static int gc_thread_func(void *data)
 {
@@ -203,10 +204,13 @@ int f2fs_start_gc_thread(struct f2fs_sb_info *sbi)
 
 void f2fs_stop_gc_thread(struct f2fs_sb_info *sbi)
 {
-	struct f2fs_gc_kthread *gc_th = sbi->gc_thread;
+	struct f2fs_gc_kthread *gc_th;
 
-	if (!gc_th)
+	guard(mutex)(&gc_lock);
+	gc_th = sbi->gc_thread;
+	if (!gc_th || gc_th->f2fs_gc_task < PAGE_OFFSET)
 		return;
+
 	kthread_stop(gc_th->f2fs_gc_task);
 	wake_up_all(&gc_th->fggc_wq);
 	kfree(gc_th);
-- 
2.43.0



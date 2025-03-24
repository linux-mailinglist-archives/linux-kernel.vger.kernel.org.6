Return-Path: <linux-kernel+bounces-573717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73802A6DB6A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 14:27:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 348301716DC
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 13:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 498DF25F785;
	Mon, 24 Mar 2025 13:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="Qrd00X1w"
Received: from forward101a.mail.yandex.net (forward101a.mail.yandex.net [178.154.239.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C3925EFBA
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 13:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742822737; cv=none; b=Fe9snZOlrE8S58FWTlAm0Sj4Y0tiZPlF9rFqc/1rp/wKD3pbt/ljBmiWstOBHNBOmXXRiOggY/QM7KZS/D5kWxidajhtmZgM4CLaCUOLqc8Y+8KqGSsa/ywsJOCrKEHA0NeDp0G//aSX7j5VIdsceNm0cfHPREDyMRRIJ5tdtEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742822737; c=relaxed/simple;
	bh=yL3lmgobLEBKRSsH+4V1Nb+xmQ7s1p+yCn95ZWhAPEY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oG4lP0JE8BJhlXLdIhx100Bkggm+19yYGiUgWt8GsCi0QQVP/4QNWQvUHo0+d7kGgfXFdy9+R8USzP9bUvVybadXgGdz4ZWo50wa15v/SY3Nj41dFOd3/uQ5wmmTRLDCi9fTxhaDzH6mK6T+SnK4Wbkrvw717GXF3paMZpu7dXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=Qrd00X1w; arc=none smtp.client-ip=178.154.239.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-95.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-95.vla.yp-c.yandex.net [IPv6:2a02:6b8:c1f:644d:0:640:2ef6:0])
	by forward101a.mail.yandex.net (Yandex) with ESMTPS id 73D9B60E8E;
	Mon, 24 Mar 2025 16:25:25 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-95.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id NPOHhg1LoeA0-FChmd9O9;
	Mon, 24 Mar 2025 16:25:24 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1742822724; bh=jgnev3j32nPtiW6Wpj/qKrnMsAM6tbWnUWS2Lh6tQ9Q=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=Qrd00X1wSSJZCq+foYGpKsA08Qc9dgyAbyP8L1ekEnnWoUi3CillELzip/qgVT5qg
	 Ff3Ii6ILN+z7QSB0ogdzJ1aTLBupmKIDKgpA1TwohkwA1Kw26PRI6A6dwz/IRe9ibP
	 EbovGOyuzbPwZEcaS27SIgOa91Weho6esvOwQiSI=
Authentication-Results: mail-nwsmtp-smtp-production-main-95.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: =?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>,
	Martijn Coenen <maco@android.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Christian Brauner <brauner@kernel.org>,
	Carlos Llamas <cmllamas@google.com>,
	Suren Baghdasaryan <surenb@google.com>
Cc: Colin Ian King <colin.i.king@gmail.com>,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>,
	syzbot+353d7b75658a95aa955a@syzkaller.appspotmail.com
Subject: [PATCH] binder: fix use-after-free in binderfs_evict_inode()
Date: Mon, 24 Mar 2025 16:24:27 +0300
Message-ID: <20250324132427.922495-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Running 'stress-ng --binderfs 16 --timeout 300' under KASAN-enabled
kernel, I've noticed the following:

BUG: KASAN: slab-use-after-free in binderfs_evict_inode+0x1de/0x2d0
Write of size 8 at addr ffff88807379bc08 by task stress-ng-binde/1699

CPU: 0 UID: 0 PID: 1699 Comm: stress-ng-binde Not tainted 6.14.0-rc7-g586de92313fc-dirty #13
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-3.fc41 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0x1c2/0x2a0
 ? __pfx_dump_stack_lvl+0x10/0x10
 ? __pfx__printk+0x10/0x10
 ? __pfx_lock_release+0x10/0x10
 ? __virt_addr_valid+0x18c/0x540
 ? __virt_addr_valid+0x469/0x540
 print_report+0x155/0x840
 ? __virt_addr_valid+0x18c/0x540
 ? __virt_addr_valid+0x469/0x540
 ? __phys_addr+0xba/0x170
 ? binderfs_evict_inode+0x1de/0x2d0
 kasan_report+0x147/0x180
 ? binderfs_evict_inode+0x1de/0x2d0
 binderfs_evict_inode+0x1de/0x2d0
 ? __pfx_binderfs_evict_inode+0x10/0x10
 evict+0x524/0x9f0
 ? __pfx_lock_release+0x10/0x10
 ? __pfx_evict+0x10/0x10
 ? do_raw_spin_unlock+0x4d/0x210
 ? _raw_spin_unlock+0x28/0x50
 ? iput+0x697/0x9b0
 __dentry_kill+0x209/0x660
 ? shrink_kill+0x8d/0x2c0
 shrink_kill+0xa9/0x2c0
 shrink_dentry_list+0x2e0/0x5e0
 shrink_dcache_parent+0xa2/0x2c0
 ? __pfx_shrink_dcache_parent+0x10/0x10
 ? __pfx_lock_release+0x10/0x10
 ? __pfx_do_raw_spin_lock+0x10/0x10
 do_one_tree+0x23/0xe0
 shrink_dcache_for_umount+0xa0/0x170
 generic_shutdown_super+0x67/0x390
 kill_litter_super+0x76/0xb0
 binderfs_kill_super+0x44/0x90
 deactivate_locked_super+0xb9/0x130
 cleanup_mnt+0x422/0x4c0
 ? lockdep_hardirqs_on+0x9d/0x150
 task_work_run+0x1d2/0x260
 ? __pfx_task_work_run+0x10/0x10
 resume_user_mode_work+0x52/0x60
 syscall_exit_to_user_mode+0x9a/0x120
 do_syscall_64+0x103/0x210
 ? asm_sysvec_apic_timer_interrupt+0x1a/0x20
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0xcac57b
Code: c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 f3 0f 1e fa 31 f6 e9 05 00 00 00 0f 1f 44 00 00 f3 0f 1e fa b8
RSP: 002b:00007ffecf4226a8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 00007ffecf422720 RCX: 0000000000cac57b
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00007ffecf422850
RBP: 00007ffecf422850 R08: 0000000028d06ab1 R09: 7fffffffffffffff
R10: 3fffffffffffffff R11: 0000000000000246 R12: 00007ffecf422718
R13: 00007ffecf422710 R14: 00007f478f87b658 R15: 00007ffecf422830
 </TASK>

Allocated by task 1705:
 kasan_save_track+0x3e/0x80
 __kasan_kmalloc+0x8f/0xa0
 __kmalloc_cache_noprof+0x213/0x3e0
 binderfs_binder_device_create+0x183/0xa80
 binder_ctl_ioctl+0x138/0x190
 __x64_sys_ioctl+0x120/0x1b0
 do_syscall_64+0xf6/0x210
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 1705:
 kasan_save_track+0x3e/0x80
 kasan_save_free_info+0x46/0x50
 __kasan_slab_free+0x62/0x70
 kfree+0x194/0x440
 evict+0x524/0x9f0
 do_unlinkat+0x390/0x5b0
 __x64_sys_unlink+0x47/0x50
 do_syscall_64+0xf6/0x210
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

This 'stress-ng' workload causes the concurrent deletions from
'binder_devices' and so requires full-featured synchronization
to prevent list corruption.

I've found this issue independently but pretty sure that syzbot did
the same, so Reported-by: and Closes: should be applicable here as well.

Reported-by: syzbot+353d7b75658a95aa955a@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=353d7b75658a95aa955a
Fixes: e77aff5528a18 ("binderfs: fix use-after-free in binder_devices")
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 drivers/android/binder.c          | 15 +++++++++++++--
 drivers/android/binder_internal.h |  8 ++++++--
 drivers/android/binderfs.c        |  2 +-
 3 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 76052006bd87..bf79a0e339fe 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -79,6 +79,8 @@ static HLIST_HEAD(binder_deferred_list);
 static DEFINE_MUTEX(binder_deferred_lock);
 
 static HLIST_HEAD(binder_devices);
+static DEFINE_SPINLOCK(binder_devices_lock);
+
 static HLIST_HEAD(binder_procs);
 static DEFINE_MUTEX(binder_procs_lock);
 
@@ -6929,7 +6931,16 @@ const struct binder_debugfs_entry binder_debugfs_entries[] = {
 
 void binder_add_device(struct binder_device *device)
 {
+	spin_lock(&binder_devices_lock);
 	hlist_add_head(&device->hlist, &binder_devices);
+	spin_unlock(&binder_devices_lock);
+}
+
+void binder_remove_device(struct binder_device *device)
+{
+	spin_lock(&binder_devices_lock);
+	hlist_del_init(&device->hlist);
+	spin_unlock(&binder_devices_lock);
 }
 
 static int __init init_binder_device(const char *name)
@@ -6956,7 +6967,7 @@ static int __init init_binder_device(const char *name)
 		return ret;
 	}
 
-	hlist_add_head(&binder_device->hlist, &binder_devices);
+	binder_add_device(binder_device);
 
 	return ret;
 }
@@ -7018,7 +7029,7 @@ static int __init binder_init(void)
 err_init_binder_device_failed:
 	hlist_for_each_entry_safe(device, tmp, &binder_devices, hlist) {
 		misc_deregister(&device->miscdev);
-		hlist_del(&device->hlist);
+		binder_remove_device(device);
 		kfree(device);
 	}
 
diff --git a/drivers/android/binder_internal.h b/drivers/android/binder_internal.h
index e4eb8357989c..c5d68c1d3780 100644
--- a/drivers/android/binder_internal.h
+++ b/drivers/android/binder_internal.h
@@ -584,9 +584,13 @@ struct binder_object {
 /**
  * Add a binder device to binder_devices
  * @device: the new binder device to add to the global list
- *
- * Not reentrant as the list is not protected by any locks
  */
 void binder_add_device(struct binder_device *device);
 
+/**
+ * Remove a binder device to binder_devices
+ * @device: the binder device to remove from the global list
+ */
+void binder_remove_device(struct binder_device *device);
+
 #endif /* _LINUX_BINDER_INTERNAL_H */
diff --git a/drivers/android/binderfs.c b/drivers/android/binderfs.c
index 94c6446604fc..44d430c4ebef 100644
--- a/drivers/android/binderfs.c
+++ b/drivers/android/binderfs.c
@@ -274,7 +274,7 @@ static void binderfs_evict_inode(struct inode *inode)
 	mutex_unlock(&binderfs_minors_mutex);
 
 	if (refcount_dec_and_test(&device->ref)) {
-		hlist_del_init(&device->hlist);
+		binder_remove_device(device);
 		kfree(device->context.name);
 		kfree(device);
 	}
-- 
2.49.0



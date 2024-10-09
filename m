Return-Path: <linux-kernel+bounces-357271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D99C996EC7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 16:54:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95A4F1F22E19
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 14:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 350521A0B00;
	Wed,  9 Oct 2024 14:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="jYOENVR9"
Received: from out203-205-221-239.mail.qq.com (out203-205-221-239.mail.qq.com [203.205.221.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E835C19DF5F;
	Wed,  9 Oct 2024 14:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728485535; cv=none; b=dG4AiQLDABew6Z+2SklIpXntidmoYTAD9AM+zzbfQfro5VYZWUZh+I+M7C57sobGWy9gMwADjhyJMYiNa7qVbpSW6VBN+gxHe+YoWlJx6jyHyJSN3yvtzrPUFKFO2h/e4vNOisl1qOstDFSnkDqfCalc7aHHWXaJjk2pGo63Szs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728485535; c=relaxed/simple;
	bh=72CYLbMVi9JQ4Mb9vBYipvbwdrEZ6H+V+gQX40uMlls=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=tBMP3WP4KDRCXyFi/P9L+BkDcl8LH8O8QldRvS8Dsf5KB9bB0DinqW2pco8d0DymKr/3TG2WNnsNVtr9kfskax5nlWThSrXIG77nzpkiPbONM3ArJioXCrriMTWw0+XZoJ69BP23X7jvFj/PAqrb1N5eZfkXpgVZS0Ap1XxBSr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=jYOENVR9; arc=none smtp.client-ip=203.205.221.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1728485529; bh=hgHVL5NnOC/ClHn4SY1oW6h7qi3QmawB0xBBAc4l4rM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jYOENVR9k2AMLRgf0UR7Pa5OZvXFNY5iWYNanHSgeJPM2IHogIjlY1HVXtHbMnAmG
	 C4dnnJHf4MDGW26k86LnFKeFO+2Q6e2nolp5Ik7nF0P+Qrn2J7ILVGpn6ihzbMGhZ+
	 h/KaqiY1hUrbQGYoe06E5dqGCDMvegQle64mOhq8=
Received: from pek-lxu-l1.wrs.com ([111.198.224.50])
	by newxmesmtplogicsvrszgpua4-0.qq.com (NewEsmtp) with SMTP
	id D06B36B8; Wed, 09 Oct 2024 22:52:06 +0800
X-QQ-mid: xmsmtpt1728485526tr96hr3sz
Message-ID: <tencent_84EB865C89862EC22EE94CB3A7C706C59206@qq.com>
X-QQ-XMAILINFO: NYqi3QrBgYD/tGwy2r6F2ZqgsXYJ9XWVQXQ0xL+jFkJhu7bqs6JVg1IbxxvGK3
	 B4NuoEArQBOixeQixzI1lwWWhGDeTioQpmj02eAZrDK+KHa7Z0RBofQAz/VV0v+wmHCOYnzRd1XS
	 aHzLFE9lMx1BrXAyd3cuL6Gb/Y8JJqxFpIqFfj0dxBK+OcuFSUFKrGmDz3YURs8oywKQ1d2qEY6d
	 wkea3y6xa8R18jgvTAGo76trn2//B6EQp3BAjsvXs3Y9yq+UBaIjsjU8jLePRI2hlan9m2Vk2wek
	 aXUbnHwvbqy/+pFv/UMEEUTrmWU3gHPDmDLxpU8wrnneyptOwO8AZ7Rz6PJhaW5cWAmqtTsJj1ni
	 ZhFBwV02QCUOgm1KcI2vb2LFuOHmAVGcBGYKCdbqYujgZbniV18j8PuuKI581KEoKFuz/GCtX38R
	 DUtRK4nz8/JrWOlihPRY/VWEdUb5ZWukU8ZU3kSDzdQ7ElECBG0CbllKU8/n4QZ5dPgM9o2IQvTI
	 kJFF7W3nNIlHjKwlemauWEbgPWZ0Hc7DqKpEtyL2QgdDJ71eN0LNUQthO3Rg8Hbpu7Efm/4UTZ2Y
	 eRUbeyxqyl5mVrOdAfUeTRwulvntotJ3aqM4IXWI93n9Z8pyzmvi0SECD0vIFshdmTDuL4WdeChj
	 CoNqWy/NV81/H1w3kT8+NnUdsy4Kg3c2iiX1707Im8Yn+mzFvuScIwFCV11hT/KkLbAxJz0TFBhj
	 Hw5rJoN9z5DEZGMkoSdicn+lFOFwhAVZuPDhwgpPo6Gtg0benn+DRsBYCmnlK6e/P1O2WlGtKoVs
	 QZUEOHF3OSMA/7ZHIXazqsTNhLjyyelXyGM//qCe+LxbcqjGWutdz4Euclms+CNQPPIs0XcVP68i
	 LcpjvxQfm1k/dhVftAFc2XQa1UZtEhzgNa6RoOKfLBaC+8bg2PeSj6wC8nFqvGXDDmi8PnDEpmnb
	 5EmWagAfkLVce6s06zeY/Z/PeFBvUbjnTZLQdeg4lFVn32ZCDCmw==
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+685e14d04fe35692d3bc@syzkaller.appspotmail.com
Cc: gregkh@linuxfoundation.org,
	keithp@keithp.com,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH next] USB: chaoskey: Fix possible deadlock chaoskey_list_lock
Date: Wed,  9 Oct 2024 22:52:07 +0800
X-OQ-MSGID: <20241009145206.1581080-2-eadavis@qq.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <6705f983.050a0220.22840d.000d.GAE@google.com>
References: <6705f983.050a0220.22840d.000d.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[Syzbot reported two possible deadlocks]
The first possible deadlock is:
WARNING: possible recursive locking detected
6.12.0-rc1-syzkaller-00027-g4a9fe2a8ac53 #0 Not tainted
--------------------------------------------
syz-executor363/2651 is trying to acquire lock:
ffffffff89b120e8 (chaoskey_list_lock){+.+.}-{3:3}, at: chaoskey_release+0x15d/0x2c0 drivers/usb/misc/chaoskey.c:322

but task is already holding lock:
ffffffff89b120e8 (chaoskey_list_lock){+.+.}-{3:3}, at: chaoskey_release+0x7f/0x2c0 drivers/usb/misc/chaoskey.c:299

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(chaoskey_list_lock);
  lock(chaoskey_list_lock);

 *** DEADLOCK ***

The second possible deadlock is:
WARNING: possible circular locking dependency detected
6.12.0-rc1-syzkaller-00027-g4a9fe2a8ac53 #0 Not tainted
------------------------------------------------------
kworker/0:2/804 is trying to acquire lock:
ffffffff899dadb0 (minor_rwsem){++++}-{3:3}, at: usb_deregister_dev+0x7c/0x1e0 drivers/usb/core/file.c:186

but task is already holding lock:
ffffffff89b120e8 (chaoskey_list_lock){+.+.}-{3:3}, at: chaoskey_disconnect+0xa8/0x2a0 drivers/usb/misc/chaoskey.c:235

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (chaoskey_list_lock){+.+.}-{3:3}:
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x175/0x9c0 kernel/locking/mutex.c:752
       chaoskey_open+0xdd/0x220 drivers/usb/misc/chaoskey.c:274
       usb_open+0x186/0x220 drivers/usb/core/file.c:47
       chrdev_open+0x237/0x6a0 fs/char_dev.c:414
       do_dentry_open+0x6cb/0x1390 fs/open.c:958
       vfs_open+0x82/0x3f0 fs/open.c:1088
       do_open fs/namei.c:3774 [inline]
       path_openat+0x1e6a/0x2d60 fs/namei.c:3933
       do_filp_open+0x1dc/0x430 fs/namei.c:3960
       do_sys_openat2+0x17a/0x1e0 fs/open.c:1415
       do_sys_open fs/open.c:1430 [inline]
       __do_sys_openat fs/open.c:1446 [inline]
       __se_sys_openat fs/open.c:1441 [inline]
       __x64_sys_openat+0x175/0x210 fs/open.c:1441
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (minor_rwsem){++++}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3161 [inline]
       check_prevs_add kernel/locking/lockdep.c:3280 [inline]
       validate_chain kernel/locking/lockdep.c:3904 [inline]
       __lock_acquire+0x250b/0x3ce0 kernel/locking/lockdep.c:5202
       lock_acquire.part.0+0x11b/0x380 kernel/locking/lockdep.c:5825
       down_write+0x93/0x200 kernel/locking/rwsem.c:1577
       usb_deregister_dev+0x7c/0x1e0 drivers/usb/core/file.c:186
       chaoskey_disconnect+0xb7/0x2a0 drivers/usb/misc/chaoskey.c:236
       usb_unbind_interface+0x1e8/0x970 drivers/usb/core/driver.c:461
       device_remove drivers/base/dd.c:569 [inline]
       device_remove+0x122/0x170 drivers/base/dd.c:561
       __device_release_driver drivers/base/dd.c:1273 [inline]
       device_release_driver_internal+0x44a/0x610 drivers/base/dd.c:1296
       bus_remove_device+0x22f/0x420 drivers/base/bus.c:576
       device_del+0x396/0x9f0 drivers/base/core.c:3864
       usb_disable_device+0x36c/0x7f0 drivers/usb/core/message.c:1418
       usb_disconnect+0x2e1/0x920 drivers/usb/core/hub.c:2304
       hub_port_connect drivers/usb/core/hub.c:5361 [inline]
       hub_port_connect_change drivers/usb/core/hub.c:5661 [inline]
       port_event drivers/usb/core/hub.c:5821 [inline]
       hub_event+0x1bed/0x4f40 drivers/usb/core/hub.c:5903
       process_one_work+0x9c5/0x1ba0 kernel/workqueue.c:3229
       process_scheduled_works kernel/workqueue.c:3310 [inline]
       worker_thread+0x6c8/0xf00 kernel/workqueue.c:3391
       kthread+0x2c1/0x3a0 kernel/kthread.c:389
       ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(chaoskey_list_lock);
                               lock(minor_rwsem);
                               lock(chaoskey_list_lock);
  lock(minor_rwsem);

 *** DEADLOCK ***
[Analysis]
The first is AA lock, it because wrong logic, it need a unlock.
The second is AB lock, it needs to rearrange the order of lock usage.

Fixes: 422dc0a4d12d ("USB: chaoskey: fail open after removal")
Reported-by: syzbot+685e14d04fe35692d3bc@syzkaller.appspotmail.com
Reported-by: syzbot+1f8ca5ee82576ec01f12@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=685e14d04fe35692d3bc
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 drivers/usb/misc/chaoskey.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/misc/chaoskey.c b/drivers/usb/misc/chaoskey.c
index e8b63df5f975..225863321dc4 100644
--- a/drivers/usb/misc/chaoskey.c
+++ b/drivers/usb/misc/chaoskey.c
@@ -232,10 +232,10 @@ static void chaoskey_disconnect(struct usb_interface *interface)
 	if (dev->hwrng_registered)
 		hwrng_unregister(&dev->hwrng);
 
-	mutex_lock(&chaoskey_list_lock);
 	usb_deregister_dev(interface, &chaoskey_class);
 
 	usb_set_intfdata(interface, NULL);
+	mutex_lock(&chaoskey_list_lock);
 	mutex_lock(&dev->lock);
 
 	dev->present = false;
@@ -319,7 +319,7 @@ static int chaoskey_release(struct inode *inode, struct file *file)
 bail:
 	mutex_unlock(&dev->lock);
 destruction:
-	mutex_lock(&chaoskey_list_lock);
+	mutex_unlock(&chaoskey_list_lock);
 	usb_dbg(interface, "release success");
 	return rv;
 }
-- 
2.43.0



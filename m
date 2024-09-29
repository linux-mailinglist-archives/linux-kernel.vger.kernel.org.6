Return-Path: <linux-kernel+bounces-342805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3805D989324
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 07:24:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 147C01C22657
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 05:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DB6A433A4;
	Sun, 29 Sep 2024 05:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="naXd/Po8"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC577225A8
	for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 05:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727587469; cv=none; b=O5vb+qFaDiLeu7AyPLsoxirUU6aG09bdV+u8ir7j9xNe+5CqY5pPaYF+CAVLHO+zoFh/xv/yc+md1WBoxlXkDYYW8MdYl/d6XeOk7QKczQE84trlaJYaEXijkPf7kKkaWNvWL0s1P0gwkvDvB5BuoawWh3pdmTroQtuI+bAQYkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727587469; c=relaxed/simple;
	bh=em1yTcugQSaJvYDloqS7wt8XieKEELOvyYfFVEq7V5c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DK6du7vrnOn1nxnLxdZayxkOLiCXS+Mc+IOMP6p+fiQFggIxwJpipmzORnEBASaYfI1DU977i455tonqyhvvJ2TgRxClOjv1SvCHQ92xebDEnyWNrMrYVUwGxY8RThLOceJJMi6rO3WHvIFpDJuszwxrkuAfU/UQ8uKZuHtQ9KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=naXd/Po8; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20b64584fd4so3791595ad.1
        for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 22:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727587467; x=1728192267; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=va2yTOZVKluI9hiL0a/o9BpM2KlXxfgYBc9J96GeleQ=;
        b=naXd/Po8FlqBnAW1ly1WpGF+55dtzu1qV1Zs8/EYiMqB3cLdiEm9wWhc4BMseiVYrI
         j1mShh5oRShNSwfd5kjCGkyakT2npS9YzibME8uDEorHnBneVuKAsXKhxBY+atn/v4bA
         XTCDxqTKUL4pWTH8Et2d0Mr4Vx+ec59lrymg0wRGbMXYtdrxNYQgLy1yUjhAigh+ckYI
         DlN01WGqhrlTcn4S5gK7LZrvrGNKh3fgnqABN8l9ijqYwW+0gm2g6jbMPSQ1k3JMKBqU
         pk/TOyBobmxMUNKJc+jRBpMMY6+ALxknUkGsNf01g/fFbMBW5bfeBpPow0GzgfTruIAd
         l/4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727587467; x=1728192267;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=va2yTOZVKluI9hiL0a/o9BpM2KlXxfgYBc9J96GeleQ=;
        b=BDWFEryDVBsxtTet+k3yC2e2DkdH8ZHBEWCX3J7Amp3QRgOaQTrTwhtVsZjhmD2j16
         bWHhhvEbPwoMovsa7VqbkPxeg+49FExWSF46XJ4NGVbrNKNMvCAs5SJwnth4SDH+lgSc
         +eS2SgFQaS8dbtv2Gj9UoybaLonlGkwYLzQbPa8h3k/P5hGstWUx92li6alWBKKlrodM
         9oNe8qf3OMdLHU6Lqq62nirRjSm1gMCY77TM11kgXjZDaewTCN2XXFsuF43vMivf4ERL
         m4MyIN+AJzmeDM15y+c2ses55JvP7Kg0ouMdXpGVFkxyy7+PPPaAVSVBy+Cc39+tnjAY
         xGag==
X-Gm-Message-State: AOJu0YwCa+KbtozVwjW97qKH5aOdC5BkkI8e8Tqq7jIdV82+CIF76d4E
	MUdXuzEwfD93ByRoVCdka2AnDqMMfwlr4Wy/TTnkmk/I2OOVJjegbeftYw==
X-Google-Smtp-Source: AGHT+IF++Gd5XPN0jufqL2xtTrfBH/YS3Zpqguxa5VzR+z0B6HeFa5/C1IzWyAV7r85VVoWj/zpq3g==
X-Received: by 2002:a17:902:e743:b0:207:18cc:f76 with SMTP id d9443c01a7336-20b3729c58amr130332785ad.23.1727587467010;
        Sat, 28 Sep 2024 22:24:27 -0700 (PDT)
Received: from localhost.localdomain ([20.37.103.148])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37e3542esm34389645ad.202.2024.09.28.22.24.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Sep 2024 22:24:26 -0700 (PDT)
From: Shu Han <ebpqwerty472123@gmail.com>
To: eadavis@qq.com
Cc: linux-kernel@vger.kernel.org,
	syzbot+1cd571a672400ef3a930@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [integrity?] [lsm?] possible deadlock in process_measurement (4)
Date: Sun, 29 Sep 2024 13:24:16 +0800
Message-Id: <20240929052416.52-1-ebpqwerty472123@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <tencent_8709932EFAAED0CCB0A7DEC6F592C9465306@qq.com>
References: <tencent_8709932EFAAED0CCB0A7DEC6F592C9465306@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

I wanna put some comments for this patch:
1. Once mmap_lock is released, the vma should never be accessed again.
   Otherwise, it may lead to a use-after-free issue.
   So `vma->vm_file` should be replaced by `file` after the first unlock.
   The test is attached at the end of this email.
2. Once the second mmap_write_lock_killable(mm) failed, the ret
   should be set to -EINTR.
3. Unlocking the mm->mmap_lock destroy the atomicity of
   remap_file_pages(), all checks performed during the first lock period
   may not meet in the second period. If some userspace code rely on it,
   it may lead to a TOCTOU issue.

Best regards.

To show how the UAF is triggered, we enlarge the race window by inserting
a usleep_range() after the first mmap_write_unlock(mm)

At the begin of mm/mmap.c, add

#include <linux/delay.h>

and add the usleep_range() in the patch position

	mmap_write_unlock(mm);
+	usleep_range(1000000, 1200000);
 	ret = security_mmap_file(file, prot, flags);

Then, run the following userspace code:

#define _GNU_SOURCE
#include <linux/aio_abi.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/mman.h>
#include <sys/syscall.h>
#include <err.h>
#include <sys/personality.h>
#include <stdio.h>
#include <errno.h>
#include <string.h>
#include <stdint.h>
#include <asm/prctl.h>
#include <sys/prctl.h>
#include <pthread.h>

size_t pagesz;
int mfd;

char *buf;

void *func(void*) {
	// ensure the order
	// call to remap_file_pages()
	// the first lock period in remap_file_pages()
	// ~500ms
	// this munmap
	// ~500ms
	// the second lock period in remap_file_pages()
	usleep(500000);
	munmap(buf, 4 * pagesz);
	return NULL;
}

int main(void) {
	pagesz = sysconf(_SC_PAGE_SIZE);
	mfd = syscall(SYS_memfd_create, "test", 0);
	buf = mmap(NULL, 4 * pagesz, PROT_READ | PROT_WRITE |
		   MAP_FIXED, MAP_SHARED, mfd, 0);
	pthread_t th;
	pthread_create(&th, NULL, func, NULL);
	pthread_detach(th);
	syscall(SYS_remap_file_pages, buf, pagesz, 0, 2, 0);
	return 0;
}

Will trigger the UAF as following KASAN report:

[    4.594781] ==================================================================
[    4.594794] BUG: KASAN: slab-use-after-free in __do_sys_remap_file_pages+0x8fc/0x950
[    4.594838] Read of size 8 at addr ffff888002035240 by task rwx_test/67
[    4.594847] 
[    4.594868] CPU: 1 UID: 0 PID: 67 Comm: rwx_test Not tainted 6.11.0-rc1-00041-g66661576d6d7-dirty #56
[    4.594880] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
[    4.594892] Call Trace:
[    4.594899]  <TASK>
[    4.594910]  dump_stack_lvl+0x55/0x70
[    4.594931]  print_report+0xcb/0x5d0
[    4.594944]  ? mtree_load+0x411/0x500
[    4.594953]  ? __do_sys_remap_file_pages+0x8fc/0x950
[    4.594965]  kasan_report+0xaf/0xe0
[    4.594975]  ? __do_sys_remap_file_pages+0x8fc/0x950
[    4.594988]  __do_sys_remap_file_pages+0x8fc/0x950
[    4.595001]  ? __pfx___do_sys_remap_file_pages+0x10/0x10
[    4.595013]  ? __x64_sys_rt_sigprocmask+0x164/0x230
[    4.595024]  ? __pfx___x64_sys_rt_sigprocmask+0x10/0x10
[    4.595034]  ? do_user_addr_fault+0x478/0x930
[    4.595047]  do_syscall_64+0xa6/0x1a0
[    4.595057]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[    4.595072] RIP: 0033:0x44b8ad
[    4.595086] Code: c3 e8 d7 1e 00 00 0f 1f 80 00 00 00 00 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 8
[    4.595096] RSP: 002b:00007ffc1117b2a8 EFLAGS: 00000246 ORIG_RAX: 00000000000000d8
[    4.595108] RAX: ffffffffffffffda RBX: 00007ffc1117b4b8 RCX: 000000000044b8ad
[    4.595116] RDX: 0000000000000000 RSI: 0000000000001000 RDI: 00007f9149ea7000
[    4.595123] RBP: 00007ffc1117b2c0 R08: 0000000000000000 R09: 00007f9149ea6640
[    4.595130] R10: 0000000000000002 R11: 0000000000000246 R12: 0000000000000001
[    4.595136] R13: 00007ffc1117b4a8 R14: 00000000004dc790 R15: 0000000000000001
[    4.595145]  </TASK>
[    4.595150] 
[    4.595154] Allocated by task 67 on cpu 1 at 3.394365s:
[    4.595163]  kasan_save_stack+0x24/0x50
[    4.595173]  kasan_save_track+0x17/0x60
[    4.595181]  __kasan_slab_alloc+0x59/0x70
[    4.595190]  kmem_cache_alloc_noprof+0xbf/0x240
[    4.595199]  vm_area_alloc+0x1b/0x1c0
[    4.595211]  mmap_region+0x290/0x1fe0
[    4.595221]  do_mmap+0x88a/0xd70
[    4.595231]  vm_mmap_pgoff+0x16c/0x2c0
[    4.595242]  ksys_mmap_pgoff+0x2e7/0x450
[    4.595252]  do_syscall_64+0xa6/0x1a0
[    4.595259]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[    4.595270] 
[    4.595274] Freed by task 0 on cpu 2 at 3.904339s:
[    4.595281]  kasan_save_stack+0x24/0x50
[    4.595289]  kasan_save_track+0x17/0x60
[    4.595301]  kasan_save_free_info+0x3b/0x60
[    4.595313]  __kasan_slab_free+0x10d/0x190
[    4.595321]  kmem_cache_free+0xa1/0x230
[    4.595330]  rcu_core+0x60f/0x1ab0
[    4.595342]  handle_softirqs+0x188/0x570
[    4.595353]  irq_exit_rcu+0x7f/0xb0
[    4.595362]  sysvec_apic_timer_interrupt+0x70/0x80
[    4.595374]  asm_sysvec_apic_timer_interrupt+0x1a/0x20
[    4.595383] 
[    4.595386] Last potentially related work creation:
[    4.595391]  kasan_save_stack+0x24/0x50
[    4.595399]  __kasan_record_aux_stack+0x8e/0xa0
[    4.595410]  __call_rcu_common.constprop.0+0x6a/0xaa0
[    4.595421]  do_vmi_align_munmap.constprop.0+0x8a0/0xe30
[    4.595431]  __vm_munmap+0x11e/0x270
[    4.595441]  __x64_sys_munmap+0x54/0x80
[    4.595450]  do_syscall_64+0xa6/0x1a0
[    4.595458]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[    4.595469] 
[    4.595472] The buggy address belongs to the object at ffff8880020351c0
[    4.595472]  which belongs to the cache vm_area_struct of size 160
[    4.595481] The buggy address is located 128 bytes inside of
[    4.595481]  freed 160-byte region [ffff8880020351c0, ffff888002035260)
[    4.595490] 
[    4.595494] The buggy address belongs to the physical page:
[    4.595500] page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x2035
[    4.595514] flags: 0x100000000000000(node=0|zone=1)
[    4.595527] page_type: 0xfdffffff(slab)
[    4.595538] raw: 0100000000000000 ffff888001196780 dead000000000122 0000000000000000
[    4.595546] raw: 0000000000000000 0000000080120012 00000001fdffffff 0000000000000000
[    4.595551] page dumped because: kasan: bad access detected
[    4.595557] 
[    4.595560] Memory state around the buggy address:
[    4.595566]  ffff888002035100: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    4.595573]  ffff888002035180: fc fc fc fc fc fc fc fc fa fb fb fb fb fb fb fb
[    4.595579] >ffff888002035200: fb fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
[    4.595584]                                            ^
[    4.595590]  ffff888002035280: fc fc fc fc 00 00 00 00 00 00 00 00 00 00 00 00
[    4.595596]  ffff888002035300: 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc
[    4.595601] ==================================================================



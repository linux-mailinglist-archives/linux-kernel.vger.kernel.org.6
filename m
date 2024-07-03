Return-Path: <linux-kernel+bounces-238971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD6A925450
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 09:01:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF93F1F23089
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 07:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 340ED3CF73;
	Wed,  3 Jul 2024 07:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infogain-com.20230601.gappssmtp.com header.i=@infogain-com.20230601.gappssmtp.com header.b="iuKUgAe3"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932CF2A1BB
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 07:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719990089; cv=none; b=bcYKLz8O6BaHv7Fcd73jxlHoX3LLYmBknjTeRpjG2nAkBlChP35KxFaBgB4I3txyNGp/eobKrvOvyWmGgODIsvHMte0noRTbHPCYXDnBFEG3fV2VnXfuR7BPfjK4+0kfRBZDqkaw1DIEG/0DnZgrtPc2vQBn3Q0w3xtVqJ9qTzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719990089; c=relaxed/simple;
	bh=omGJJJb+OJtoZKQo9YFXJYGUR8/wXD4d4bdnk5rBXlU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AyE9V3eIlHm3fEtAg7XTtMpRUIEf/TWf/PTDHjkuUX5HUwhF78/fFIlJYESD10d9SAvK1MgCdeeeD1zXDCVYfDDz+B4fIqW7ZDh3LN0dsrnw3sZWo3YOkyqc6LEnUDKJNTSsxLN4pyHTVnjYCpo71krqvypr6M8BNJZ7Cj0C10U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=infogain.com; spf=fail smtp.mailfrom=infogain.com; dkim=pass (2048-bit key) header.d=infogain-com.20230601.gappssmtp.com header.i=@infogain-com.20230601.gappssmtp.com header.b=iuKUgAe3; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=infogain.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=infogain.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a724cd0e9c2so506573566b.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 00:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=infogain-com.20230601.gappssmtp.com; s=20230601; t=1719990084; x=1720594884; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YUAP9uxm3PnSjMLbhttgQQwSpqvG0xjkaw0EQZ4lZwI=;
        b=iuKUgAe3YVfn/CCVzFzoWGVskUvq3UNyQWPx1NiuLr6XjiK54N3EKxZSloUrJDMcUD
         6eb11UXgzxkrsj1fkApS4koiGHfi0yC/fBxSknMwuB/0p77P9tyvL/5uFVoj4hBKSn05
         W/TajzoWfzb+uFm0Q5Lfhf+6bJTItT9hE+Ild1/B9gddqHvO6dDjVybv60F0KU9YtKyQ
         0lB+Gi0CihzSJdDzw357YoQ/kobYiBjG37sbLzvnZJAVvxmIF1yYp5TMVBRczNWXG0JQ
         nCxnGhXGsEG5D9LspMCJY0WP++HSUDCcFsRwBN3pY0JiPemhybXXYt9kfJEbU75VgJfs
         +FLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719990084; x=1720594884;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YUAP9uxm3PnSjMLbhttgQQwSpqvG0xjkaw0EQZ4lZwI=;
        b=wcpZz5frO+ln56vrb7qDO50XSfQPvFZG8+9Rg6/pAN4yVa9Ck2n2AaQCznCY5ev9K3
         8u74LqNUOsQh0mV3q0wEce2bQIvnbfSBCXSImKG9tgJC635lzTM1ZdLjOPjuRScvGlyf
         0Huz5uaUYBk2lleMsUuaEpgY1YGxWaoiBRTkngDPLnzqIE39yqow2nlttEafZTUEnBqN
         7DYDQjOs2QsSvXeJVpZ8ROd2Lyfv3XcPYPcEbTd22YywSN5UZkNb9ABB8zz+X6VX8QhH
         2YenHN3KlM7zWGVS7DdNzURRLM5PnB89sPN9/QdSC/xpqHXd0hOu3eeFKBlu8+CJzrP5
         yBfg==
X-Forwarded-Encrypted: i=1; AJvYcCXeXeRXa2YkXTDmHQ917sgD6IregAkPi22aKQA+/+DiT75tEhtDAU5km7whC+5VYVU+gmr8WbLAQ5UOyS8sZlzEoFh9iSRjBwcIvnyw
X-Gm-Message-State: AOJu0Yw9xCixt1tw2PKO3XbbMr5YkgO/eCUXowK7+tO0oR/Lj/9y6MC0
	IIcWXVMzOt+VbsDhTu2LcOxzJqGmIrs1OKzGDBAE+647smEQEq+t/hFf4Oo0znk=
X-Google-Smtp-Source: AGHT+IHlXRwS/8o4khwKGDkm4Y4zri08clxIkn2pE6cCqkBMlb7IO4o3elUvzm1mOCysu5UiNeaN3w==
X-Received: by 2002:a17:906:5851:b0:a72:6b08:ab1a with SMTP id a640c23a62f3a-a75144545f4mr603397266b.46.1719990083607;
        Wed, 03 Jul 2024 00:01:23 -0700 (PDT)
Received: from localhost.localdomain (apn-31-0-3-137.dynamic.gprs.plus.pl. [31.0.3.137])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a751561bb1bsm347310066b.37.2024.07.03.00.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 00:01:23 -0700 (PDT)
From: =?UTF-8?q?Wojciech=20G=C5=82adysz?= <wojciech.gladysz@infogain.com>
To: syzbot+18df508cf00a0598d9a6@syzkaller.appspotmail.com
Cc: adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	tytso@mit.edu,
	=?UTF-8?q?Wojciech=20G=C5=82adysz?= <wojciech.gladysz@infogain.com>
Subject: [PATCH] kernel/ext4: sanity check for NULL pointer after ext4_force_shutdown
Date: Wed,  3 Jul 2024 09:01:12 +0200
Message-Id: <20240703070112.10235-1-wojciech.gladysz@infogain.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <000000000000f19a1406109eb5c5@google.com>
References: <000000000000f19a1406109eb5c5@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Test case: 2 threads write short inline data to a file.
In ext4_page_mkwrite the resulting inline data is converted.
Handling ext4_grp_locked_error with description "block bitmap
and bg descriptor inconsistent: X vs Y free clusters" calls
ext4_force_shutdown. The conversion clears
EXT4_STATE_MAY_INLINE_DATA but fails for
ext4_destroy_inline_data_nolock and ext4_mark_iloc_dirty due
to ext4_forced_shutdown. The restoration of inline data fails
for the same reason not setting EXT4_STATE_MAY_INLINE_DATA.
Without the flag set a regular process path in ext4_da_write_end
follows trying to dereference page folio private pointer that has
not been set. The fix calls early return with -EIO error shall the
pointer to private be NULL.

Sample crash report:

Unable to handle kernel paging request at virtual address dfff800000000004
KASAN: null-ptr-deref in range [0x0000000000000020-0x0000000000000027]
Mem abort info:
  ESR = 0x0000000096000005
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x05: level 1 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000005, ISS2 = 0x00000000
  CM = 0, WnR = 0, TnD = 0, TagAccess = 0
  GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[dfff800000000004] address between user and kernel address ranges
Internal error: Oops: 0000000096000005 [#1] PREEMPT SMP
Modules linked in:
CPU: 1 PID: 20274 Comm: syz-executor185 Not tainted 6.9.0-rc7-syzkaller-gfda5695d692c #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __block_commit_write+0x64/0x2b0 fs/buffer.c:2167
lr : __block_commit_write+0x3c/0x2b0 fs/buffer.c:2160
sp : ffff8000a1957600
x29: ffff8000a1957610 x28: dfff800000000000 x27: ffff0000e30e34b0
x26: 0000000000000000 x25: dfff800000000000 x24: dfff800000000000
x23: fffffdffc397c9e0 x22: 0000000000000020 x21: 0000000000000020
x20: 0000000000000040 x19: fffffdffc397c9c0 x18: 1fffe000367bd196
x17: ffff80008eead000 x16: ffff80008ae89e3c x15: 00000000200000c0
x14: 1fffe0001cbe4e04 x13: 0000000000000000 x12: 0000000000000000
x11: 0000000000000001 x10: 0000000000ff0100 x9 : 0000000000000000
x8 : 0000000000000004 x7 : 0000000000000000 x6 : 0000000000000000
x5 : fffffdffc397c9c0 x4 : 0000000000000020 x3 : 0000000000000020
x2 : 0000000000000040 x1 : 0000000000000020 x0 : fffffdffc397c9c0
Call trace:
 __block_commit_write+0x64/0x2b0 fs/buffer.c:2167
 block_write_end+0xb4/0x104 fs/buffer.c:2253
 ext4_da_do_write_end fs/ext4/inode.c:2955 [inline]
 ext4_da_write_end+0x2c4/0xa40 fs/ext4/inode.c:3028
 generic_perform_write+0x394/0x588 mm/filemap.c:3985
 ext4_buffered_write_iter+0x2c0/0x4ec fs/ext4/file.c:299
 ext4_file_write_iter+0x188/0x1780
 call_write_iter include/linux/fs.h:2110 [inline]
 new_sync_write fs/read_write.c:497 [inline]
 vfs_write+0x968/0xc3c fs/read_write.c:590
 ksys_write+0x15c/0x26c fs/read_write.c:643
 __do_sys_write fs/read_write.c:655 [inline]
 __se_sys_write fs/read_write.c:652 [inline]
 __arm64_sys_write+0x7c/0x90 fs/read_write.c:652
 __invoke_syscall arch/arm64/kernel/syscall.c:34 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:48
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:133
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:152
 el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:712
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:730
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598
Code: 97f85911 f94002da 91008356 d343fec8 (38796908)
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	97f85911 	bl	0xffffffffffe16444
   4:	f94002da 	ldr	x26, [x22]
   8:	91008356 	add	x22, x26, #0x20
   c:	d343fec8 	lsr	x8, x22, #3
* 10:	38796908 	ldrb	w8, [x8, x25] <-- trapping instruction

Reported-by: syzbot+18df508cf00a0598d9a6@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=18df508cf00a0598d9a6
Link: https://lore.kernel.org/all/000000000000f19a1406109eb5c5@google.com/T/
Signed-off-by: Wojciech Gładysz <wojciech.gladysz@infogain.com>
---
 fs/buffer.c     | 5 ++++-
 fs/ext4/inode.c | 5 +++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 8c19e705b9c3..0d87d1f037e6 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -2186,7 +2186,10 @@ static void __block_commit_write(struct folio *folio, size_t from, size_t to)
 	unsigned blocksize;
 	struct buffer_head *bh, *head;
 
-	bh = head = folio_buffers(folio);
+	head = folio_buffers(folio);
+	if (!head)
+		return;
+	bh = head;
 	blocksize = bh->b_size;
 
 	block_start = 0;
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 4bae9ccf5fe0..f14e77c4a6de 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -2945,6 +2945,11 @@ static int ext4_da_do_write_end(struct address_space *mapping,
 	bool disksize_changed = false;
 	loff_t new_i_size;
 
+	if (unlikely(!folio_buffers(folio))) {
+		folio_unlock(folio);
+		folio_put(folio);
+		return -EIO;
+	}
 	/*
 	 * block_write_end() will mark the inode as dirty with I_DIRTY_PAGES
 	 * flag, which all that's needed to trigger page writeback.
-- 
2.35.3



Return-Path: <linux-kernel+bounces-172806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E88C28BF703
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 09:27:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E8D22854FE
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 07:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41D3E15E86;
	Wed,  8 May 2024 07:27:44 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC6B374C1
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 07:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715153262; cv=none; b=Swf9ZYEpm61ZXm887aJ50ZI2XatQuwxJqRzovXRtLkTQZFgG/GVoMHEU3o9E0q2j27q+wSI1bblC4Cz5uUVIrmrh+bz0wy3N/TNeug0BPBEayz93Pl4OP5CUJa8hM6YoQwJbQMyP20iygm4g57l4uO4t0X+zkTRLclTcH0h7SSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715153262; c=relaxed/simple;
	bh=zo7DEiwleLmos4JQB0vS5Htj4x1kN9S5+sgwlM3jiqE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=K217zZB9WHdR4VNZdDNhZtvM5wRh6nmH7FDCP1s3UrdipXNQQJZj67gJcE4nj1HNBcsWqYgbuqYnoDLpCMt2RW/G2WgJOSydZ2eB/gtinJ69aQ+a3OrXYLGzn4CMNF1dxRH0vJKbahvtOTIcm3kOmFXeFrAh5xkrHyF8aOJZeRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7e1849aee8cso168549139f.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 00:27:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715153247; x=1715758047;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XSlqj5hjPptRluWv+tMnKsoWxTjFnG/rw8Lx7VNs9fg=;
        b=r3aF+BZl5CFlgsEz4ShC+z3gw21x+vRstAA0l5i1qwjrCtCBZ03pLeXoBoTxGEaoQX
         yVHkUzOJ7fxP2eG90zGW53m6dyL5LWsCgFyJGuY7c095xhMaxaOrXtU6f7pidftYwGdS
         9hSH5faAtGc2NF+lOQD4Hoea3ja4IUM0rykFjVnL1IKVzM9M9Tij/3fVp90nJsIumnMy
         H8knP2zwAF/qcIWSI8qmOlmAd2RRC4I4hwbIDA39IqAFjsYDrAm8WGNhEsF0klLRnZ81
         +0+0CTVN/Eiz0c3Mmd+9UR/nuCmJDb59fqEyHhJkRFnzhb54zPPUwqjpqLZ46pbSR18E
         BPKQ==
X-Forwarded-Encrypted: i=1; AJvYcCW12+EPP8KMAoOg+JY7BaveEksKgRQ08cBYKU9z53My2TR96s8xIw8RRtEjN810kPnde3HCWC2hBGk7q0BMB0xKMyxGohhWcJ2ELmck
X-Gm-Message-State: AOJu0YwmJFNuwno/pY0DjmH/M8ILAYgwMmpnWW3s/ZmRJIKYpn3q8KJo
	FOkbq1WpZuMxavPJpf3rixa3j/fIE515B255TeqVRnCnafAvSDEISO5OJz9NEcf1FqhAjJwr09l
	W6UwZCm+7WMPqhk1ie0IqLILhxUhYE864s+gYkbefN4Y6jTX4pkMtSgA=
X-Google-Smtp-Source: AGHT+IHZIQJoDZQwDzoQUi2cRIw9kOUzllUOMk1BqVkK4eww1H+aamCQE7fV0WrGMKbm+mZz0wHoZIcYQhVNmYERoG3UygiSmJPz
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:138a:b0:36c:307b:7f08 with SMTP id
 e9e14a558f8ab-36caeb4e817mr546275ab.0.1715153247079; Wed, 08 May 2024
 00:27:27 -0700 (PDT)
Date: Wed, 08 May 2024 00:27:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000071b6f0617ec3c17@google.com>
Subject: [syzbot] [bcachefs?] BUG: MAX_LOCK_DEPTH too low! (4)
From: syzbot <syzbot+46405fa9afa07e6c8c40@syzkaller.appspotmail.com>
To: bfoster@redhat.com, kent.overstreet@linux.dev, 
	linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    9221b2819b8a Add linux-next specific files for 20240503
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=11a1d9df180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8ab537f51a6a0d98
dashboard link: https://syzkaller.appspot.com/bug?extid=46405fa9afa07e6c8c40
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11631754980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17e27a28980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/3e67dbdc3c37/disk-9221b281.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ade618fa19f8/vmlinux-9221b281.xz
kernel image: https://storage.googleapis.com/syzbot-assets/df12e5073c97/bzImage-9221b281.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/19d03db08a95/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+46405fa9afa07e6c8c40@syzkaller.appspotmail.com

bcachefs (loop0): resume_logged_ops... done
bcachefs (loop0): going read-write
bcachefs (loop0): done starting filesystem
BUG: MAX_LOCK_DEPTH too low!
turning off the locking correctness validator.
depth: 48  max: 48!
48 locks held by syz-executor356/5097:
 #0: ffff888023ae8420 (sb_writers#9){.+.+}-{0:0}, at: mnt_want_write+0x3f/0x90 fs/namespace.c:409
 #1: ffff888076ab88b8 (&sb->s_type->i_mutex_key#15){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:791 [inline]
 #1: ffff888076ab88b8 (&sb->s_type->i_mutex_key#15){+.+.}-{3:3}, at: do_truncate+0x20c/0x310 fs/open.c:63
 #2: ffff888077780ab8 (&c->snapshot_create_lock){.+.+}-{3:3}, at: bch2_truncate+0x16c/0x2c0 fs/bcachefs/io_misc.c:290
 #3: ffff888077784258 (&c->btree_trans_barrier){.+.+}-{0:0}, at: srcu_lock_acquire include/linux/srcu.h:116 [inline]
 #3: ffff888077784258 (&c->btree_trans_barrier){.+.+}-{0:0}, at: srcu_read_lock include/linux/srcu.h:215 [inline]
 #3: ffff888077784258 (&c->btree_trans_barrier){.+.+}-{0:0}, at: bch2_trans_srcu_lock+0xb1/0x220 fs/bcachefs/btree_iter.c:3024
 #4: ffff888023040870 (&dev->mutex){....}-{3:3}, at: six_relock_type fs/bcachefs/six.h:289 [inline]
 #4: ffff888023040870 (&dev->mutex){....}-{3:3}, at: __bch2_btree_node_relock+0x142/0x9c0 fs/bcachefs/btree_locking.c:506
 #5: ffff888023040870 (&dev->mutex){....}-{3:3}, at: btree_node_lock_increment fs/bcachefs/btree_locking.h:248 [inline]
 #5: ffff888023040870 (&dev->mutex){....}-{3:3}, at: __bch2_btree_node_relock+0x67c/0x9c0 fs/bcachefs/btree_locking.c:508
 #6: ffff888023040870 (&dev->mutex){....}-{3:3}, at: btree_node_lock_increment fs/bcachefs/btree_locking.h:248 [inline]
 #6: ffff888023040870 (&dev->mutex){....}-{3:3}, at: __bch2_btree_node_relock+0x67c/0x9c0 fs/bcachefs/btree_locking.c:508
 #7: ffff888023040870 (&dev->mutex){....}-{3:3}, at: btree_node_lock_increment fs/bcachefs/btree_locking.h:248 [inline]
 #7: ffff888023040870 (&dev->mutex){....}-{3:3}, at: __bch2_btree_node_relock+0x67c/0x9c0 fs/bcachefs/btree_locking.c:508
 #8: ffff888023040870 (&dev->mutex){....}-{3:3}, at: btree_node_lock_increment fs/bcachefs/btree_locking.h:248 [inline]
 #8: ffff888023040870 (&dev->mutex){....}-{3:3}, at: __bch2_btree_node_relock+0x67c/0x9c0 fs/bcachefs/btree_locking.c:508
 #9: ffff888023040870 (&dev->mutex){....}-{3:3}, at: btree_node_lock_increment fs/bcachefs/btree_locking.h:248 [inline]
 #9: ffff888023040870 (&dev->mutex){....}-{3:3}, at: __bch2_btree_node_relock+0x67c/0x9c0 fs/bcachefs/btree_locking.c:508
 #10: ffff888023040870 (&dev->mutex){....}-{3:3}, at: btree_node_lock_increment fs/bcachefs/btree_locking.h:248 [inline]
 #10: ffff888023040870 (&dev->mutex){....}-{3:3}, at: __bch2_btree_node_relock+0x67c/0x9c0 fs/bcachefs/btree_locking.c:508
 #11: ffff888023040870 (&dev->mutex){....}-{3:3}, at: btree_node_lock_increment fs/bcachefs/btree_locking.h:248 [inline]
 #11: ffff888023040870 (&dev->mutex){....}-{3:3}, at: __bch2_btree_node_relock+0x67c/0x9c0 fs/bcachefs/btree_locking.c:508
 #12: ffff888023040870 (&dev->mutex){....}-{3:3}, at: btree_node_lock_increment fs/bcachefs/btree_locking.h:248 [inline]
 #12: ffff888023040870 (&dev->mutex){....}-{3:3}, at: __bch2_btree_node_relock+0x67c/0x9c0 fs/bcachefs/btree_locking.c:508
 #13: ffff888076a78f38 (&dev->mutex){....}-{3:3}, at: six_relock_type fs/bcachefs/six.h:289 [inline]
 #13: ffff888076a78f38 (&dev->mutex){....}-{3:3}, at: __bch2_btree_node_relock+0x142/0x9c0 fs/bcachefs/btree_locking.c:506
 #14: ffff888076a79090 (&dev->mutex){....}-{3:3}, at: six_relock_type fs/bcachefs/six.h:289 [inline]
 #14: ffff888076a79090 (&dev->mutex){....}-{3:3}, at: __bch2_btree_node_relock+0x142/0x9c0 fs/bcachefs/btree_locking.c:506
 #15: ffff888076a791e8 (&dev->mutex){....}-{3:3}, at: six_relock_type fs/bcachefs/six.h:289 [inline]
 #15: ffff888076a791e8 (&dev->mutex){....}-{3:3}, at: __bch2_btree_node_relock+0x142/0x9c0 fs/bcachefs/btree_locking.c:506
 #16: ffff888076a79340 (&dev->mutex){....}-{3:3}, at: six_relock_type fs/bcachefs/six.h:289 [inline]
 #16: ffff888076a79340 (&dev->mutex){....}-{3:3}, at: __bch2_btree_node_relock+0x142/0x9c0 fs/bcachefs/btree_locking.c:506
 #17: ffff888076a79498 (&dev->mutex){....}-{3:3}, at: six_relock_type fs/bcachefs/six.h:289 [inline]
 #17: ffff888076a79498 (&dev->mutex){....}-{3:3}, at: __bch2_btree_node_relock+0x142/0x9c0 fs/bcachefs/btree_locking.c:506
 #18: ffff888076a795f0 (&dev->mutex){....}-{3:3}, at: six_relock_type fs/bcachefs/six.h:289 [inline]
 #18: ffff888076a795f0 (&dev->mutex){....}-{3:3}, at: __bch2_btree_node_relock+0x142/0x9c0 fs/bcachefs/btree_locking.c:506
 #19: ffff888076a79748 (&dev->mutex){....}-{3:3}, at: six_relock_type fs/bcachefs/six.h:289 [inline]
 #19: ffff888076a79748 (&dev->mutex){....}-{3:3}, at: __bch2_btree_node_relock+0x142/0x9c0 fs/bcachefs/btree_locking.c:506
 #20: ffff888076a798a0 (&dev->mutex){....}-{3:3}, at: six_relock_type fs/bcachefs/six.h:289 [inline]
 #20: ffff888076a798a0 (&dev->mutex){....}-{3:3}, at: __bch2_btree_node_relock+0x142/0x9c0 fs/bcachefs/btree_locking.c:506
 #21: ffff888023041070 (&dev->mutex){....}-{3:3}, at: six_trylock_type fs/bcachefs/six.h:207 [inline]
 #21: ffff888023041070 (&dev->mutex){....}-{3:3}, at: btree_node_lock fs/bcachefs/btree_locking.h:266 [inline]
 #21: ffff888023041070 (&dev->mutex){....}-{3:3}, at: btree_path_lock_root fs/bcachefs/btree_iter.c:760 [inline]
 #21: ffff888023041070 (&dev->mutex){....}-{3:3}, at: bch2_btree_path_traverse_one+0xa44/0x2930 fs/bcachefs/btree_iter.c:1180
 #22: ffff888023040070 (&dev->mutex){....}-{3:3}, at: six_relock_type fs/bcachefs/six.h:289 [inline]
 #22: ffff888023040070 (&dev->mutex){....}-{3:3}, at: __bch2_btree_node_relock+0x142/0x9c0 fs/bcachefs/btree_locking.c:506
 #23: ffff88807a4c9870 (&dev->mutex){....}-{3:3}, at: six_trylock_type fs/bcachefs/six.h:207 [inline]
 #23: ffff88807a4c9870 (&dev->mutex){....}-{3:3}, at: btree_node_lock fs/bcachefs/btree_locking.h:266 [inline]
 #23: ffff88807a4c9870 (&dev->mutex){....}-{3:3}, at: btree_path_lock_root fs/bcachefs/btree_iter.c:760 [inline]
 #23: ffff88807a4c9870 (&dev->mutex){....}-{3:3}, at: bch2_btree_path_traverse_one+0xa44/0x2930 fs/bcachefs/btree_iter.c:1180
 #24: ffff88807a4c9870 (&dev->mutex){....}-{3:3}, at: six_trylock_type fs/bcachefs/six.h:207 [inline]
 #24: ffff88807a4c9870 (&dev->mutex){....}-{3:3}, at: btree_node_lock fs/bcachefs/btree_locking.h:266 [inline]
 #24: ffff88807a4c9870 (&dev->mutex){....}-{3:3}, at: btree_path_lock_root fs/bcachefs/btree_iter.c:760 [inline]
 #24: ffff88807a4c9870 (&dev->mutex){....}-{3:3}, at: bch2_btree_path_traverse_one+0xa44/0x2930 fs/bcachefs/btree_iter.c:1180
 #25: ffff88807a4c9070 (&dev->mutex){....}-{3:3}, at: six_relock_type fs/bcachefs/six.h:289 [inline]
 #25: ffff88807a4c9070 (&dev->mutex){....}-{3:3}, at: __bch2_btree_node_relock+0x142/0x9c0 fs/bcachefs/btree_locking.c:506
 #26: ffff88807a4c9070 (&dev->mutex){....}-{3:3}, at: btree_node_lock_increment fs/bcachefs/btree_locking.h:248 [inline]
 #26: ffff88807a4c9070 (&dev->mutex){....}-{3:3}, at: __bch2_btree_node_relock+0x67c/0x9c0 fs/bcachefs/btree_locking.c:508
 #27: ffff88807a4c9070 (&dev->mutex){....}-{3:3}, at: btree_node_lock_increment fs/bcachefs/btree_locking.h:248 [inline]
 #27: ffff88807a4c9070 (&dev->mutex){....}-{3:3}, at: __bch2_btree_node_relock+0x67c/0x9c0 fs/bcachefs/btree_locking.c:508
 #28: ffff88807a4c9070 (&dev->mutex){....}-{3:3}, at: btree_node_lock_increment fs/bcachefs/btree_locking.h:248 [inline]
 #28: ffff88807a4c9070 (&dev->mutex){....}-{3:3}, at: __bch2_btree_node_relock+0x67c/0x9c0 fs/bcachefs/btree_locking.c:508
 #29: ffff88807a4c9070 (&dev->mutex){....}-{3:3}, at: btree_node_lock_increment fs/bcachefs/btree_locking.h:248 [inline]
 #29: ffff88807a4c9070 (&dev->mutex){....}-{3:3}, at: __bch2_btree_node_relock+0x67c/0x9c0 fs/bcachefs/btree_locking.c:508
 #30: ffff88807a4c9070 (&dev->mutex){....}-{3:3}, at: btree_node_lock_increment fs/bcachefs/btree_locking.h:248 [inline]
 #30: ffff88807a4c9070 (&dev->mutex){....}-{3:3}, at: __bch2_btree_node_relock+0x67c/0x9c0 fs/bcachefs/btree_locking.c:508
 #31: ffff88807a4c9070 (&dev->mutex){....}-{3:3}, at: btree_node_lock_increment fs/bcachefs/btree_locking.h:248 [inline]
 #31: ffff88807a4c9070 (&dev->mutex){....}-{3:3}, at: __bch2_btree_node_relock+0x67c/0x9c0 fs/bcachefs/btree_locking.c:508
 #32: ffff88807a4ce070 (&dev->mutex){....}-{3:3}, at: six_relock_type fs/bcachefs/six.h:289 [inline]
 #32: ffff88807a4ce070 (&dev->mutex){....}-{3:3}, at: __bch2_btree_node_relock+0x142/0x9c0 fs/bcachefs/btree_locking.c:506
 #33: ffff8880777a6858 (&c->gc_lock){.+.+}-{3:3}, at: bch2_btree_update_start+0x68d/0x1500 fs/bcachefs/btree_update_interior.c:1196
 #34: ffff888076a0c320 (&dev->mutex){....}-{3:3}, at: bch2_btree_path_traverse_cached+0x48d/0xd50
 #35: ffff888076a0c1c8 (&dev->mutex){....}-{3:3}, at: bch2_btree_path_traverse_cached+0x48d/0xd50
 #36: ffff88807a4c9870 (&dev->mutex){....}-{3:3}, at: btree_path_copy fs/bcachefs/btree_iter.c:1231 [inline]
 #36: ffff88807a4c9870 (&dev->mutex){....}-{3:3}, at: btree_path_clone fs/bcachefs/btree_iter.c:1239 [inline]
 #36: ffff88807a4c9870 (&dev->mutex){....}-{3:3}, at: __bch2_btree_path_make_mut+0x1ec/0x570 fs/bcachefs/btree_iter.c:1252
 #37: ffff888076a0c070 (&dev->mutex){....}-{3:3}, at: bch2_btree_path_traverse_cached+0x48d/0xd50
 #38: ffff888076a7be00 (&dev->mutex){....}-{3:3}, at: bch2_btree_path_traverse_cached+0x48d/0xd50
 #39: ffff88807a4c9870 (&dev->mutex){....}-{3:3}, at: btree_path_copy fs/bcachefs/btree_iter.c:1231 [inline]
 #39: ffff88807a4c9870 (&dev->mutex){....}-{3:3}, at: btree_path_clone fs/bcachefs/btree_iter.c:1239 [inline]
 #39: ffff88807a4c9870 (&dev->mutex){....}-{3:3}, at: __bch2_btree_path_make_mut+0x1ec/0x570 fs/bcachefs/btree_iter.c:1252
 #40: ffff888076a7bca8 (&dev->mutex){....}-{3:3}, at: bch2_btree_path_traverse_cached+0x48d/0xd50
 #41: ffff888076a7bb50 (&dev->mutex){....}-{3:3}, at: bch2_btree_path_traverse_cached+0x48d/0xd50
 #42: ffff8880769a25d0 (&dev->mutex){....}-{3:3}, at: bch2_btree_path_traverse_cached+0x48d/0xd50
 #43: ffff88802e8a7070 (&dev->mutex){....}-{3:3}, at: btree_node_lock_nopath_nofail fs/bcachefs/btree_locking.h:228 [inline]
 #43: ffff88802e8a7070 (&dev->mutex){....}-{3:3}, at: bch2_btree_node_alloc+0x114/0xe80 fs/bcachefs/btree_update_interior.c:393
 #44: ffff88802e8a7070 (&dev->mutex){....}-{3:3}, at: btree_split+0x1ba3/0x69e0 fs/bcachefs/btree_update_interior.c:1675
 #45: ffffffff8e333de0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:327 [inline]
 #45: ffffffff8e333de0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:839 [inline]
 #45: ffffffff8e333de0 (rcu_read_lock){....}-{1:2}, at: __queue_work+0x198/0xef0 kernel/workqueue.c:2283
 #46: ffff8880b943e378 (&pool->lock){-.-.}-{2:2}, at: __queue_work+0x6ec/0xef0
 #47: ffffffff8ea3ffa0 (fill_pool_map-wait-type-override){+.+.}-{3:3}, at: debug_objects_fill_pool+0x80/0x9b0 lib/debugobjects.c:614
INFO: lockdep is turned off.
CPU: 0 PID: 5097 Comm: syz-executor356 Not tainted 6.9.0-rc6-next-20240503-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 __lock_acquire+0x10c3/0x1fd0
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
 debug_objects_fill_pool+0x9f/0x9b0 lib/debugobjects.c:614
 debug_object_activate+0x135/0x510 lib/debugobjects.c:704
 debug_work_activate kernel/workqueue.c:664 [inline]
 insert_work+0x36/0x330 kernel/workqueue.c:2204
 __queue_work+0xc24/0xef0 kernel/workqueue.c:2359
 queue_work_on+0x1c2/0x380 kernel/workqueue.c:2410
 queue_work include/linux/workqueue.h:621 [inline]
 __bch2_btree_node_write+0x37b3/0x4640 fs/bcachefs/btree_io.c:2233
 bch2_btree_node_write+0x63/0x1f0 fs/bcachefs/btree_io.c:2309
 btree_split+0x51f9/0x69e0 fs/bcachefs/btree_update_interior.c:1707
 bch2_btree_split_leaf+0x158/0x810 fs/bcachefs/btree_update_interior.c:1858
 bch2_trans_commit_error+0x200/0x1210 fs/bcachefs/btree_trans_commit.c:918
 __bch2_trans_commit+0x6f6f/0x8a10 fs/bcachefs/btree_trans_commit.c:1138
 bch2_trans_commit fs/bcachefs/btree_update.h:170 [inline]
 bch2_extent_update+0x4c0/0xbb0 fs/bcachefs/io_write.c:318
 bch2_fpunch_at+0x87c/0x1020 fs/bcachefs/io_misc.c:184
 __bch2_resume_logged_op_truncate+0x715/0xaa0 fs/bcachefs/io_misc.c:260
 bch2_truncate+0x1cf/0x2c0 fs/bcachefs/io_misc.c:291
 bchfs_truncate+0x80f/0xc80 fs/bcachefs/fs-io.c:473
 notify_change+0xb9d/0xe70 fs/attr.c:497
 do_truncate+0x220/0x310 fs/open.c:65
 handle_truncate fs/namei.c:3308 [inline]
 do_open fs/namei.c:3654 [inline]
 path_openat+0x2a3d/0x3280 fs/namei.c:3807
 do_filp_open+0x235/0x490 fs/namei.c:3834
 do_sys_openat2+0x13e/0x1d0 fs/open.c:1405
 do_sys_open fs/open.c:1420 [inline]
 __do_sys_creat fs/open.c:1496 [inline]
 __se_sys_creat fs/open.c:1490 [inline]
 __x64_sys_creat+0x123/0x170 fs/open.c:1490
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f4ae26b8a39
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 61 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff20b52708 EFLAGS: 00000246 ORIG_RAX: 0000000000000055
RAX: ffffffffffffffda RBX: 00007f4ae270104b RCX: 00007f4ae26b8a39
RDX: 00007f4ae26b8a39 RSI: 0000000000000000 RDI: 0000000020000000
RBP: 00007f4ae2731610 R08: 00007fff20b528d8 R09: 00007fff20b528d8
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00007fff20b528c8 R14: 0000000000000001 R15: 0000000000000001
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup


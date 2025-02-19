Return-Path: <linux-kernel+bounces-521744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 156ACA3C1CA
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 15:18:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 225A73BEC58
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 14:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D2191F1538;
	Wed, 19 Feb 2025 14:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="ttczPi8U"
Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1F21EDA1A
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 14:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739974120; cv=none; b=KMXKdM2EKI/gsbVEWCv40Zz59dfLpGVw1HjnmaYePsMH4bpLcgDwkpMdomiwDEUhNWUTA40wCLFcuQNg5BU9kW/LNgV6memdWR2Afs+EuuHJAGBphGyzr71sB56cNLpzDWKMG5TNRUH2IWl5RB9LGv/9Kyk2xZ39OfySGb98elw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739974120; c=relaxed/simple;
	bh=On6UQ5PIVYWXg2TRlYXc2ylwk8HItltPnmNFKvQUTzk=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=KrA28kTr75Z6HDlI0HDkYslDViJG2fvLj5GCrksnDjtBpXXvytZEK65pj/sWOEvRVz2HybL8700KXVmvRbSlR3E8qGHvMaUjEaKku/5kzlFbiJpv5g75zS7IlDPWmwDu2W0DAy6m03xhvZDZBg58q2Xjqks5GJRdZPNPFG9XZG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=ttczPi8U; arc=none smtp.client-ip=162.62.57.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1739974112; bh=wkS7epA2A5s0pfsFXj5MssIur8auQ5akBvEzcoo0TMM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ttczPi8UI3TtYX5ns+d/b4GUUertymizOFyBsVeJEYfmyqQRcc+1kae9Qc+5y9EDJ
	 jotX7dCSYpfUzEjfo8bu3veaXVJfUj4yjLKxCIxYwoXcJTyCSg+fuQpPCKh/bSYMzH
	 5VJD26O8bdiJdTyjx2064M23s9UJ9TseCYzRlVnc=
Received: from pek-lxu-l1.wrs.com ([114.244.57.157])
	by newxmesmtplogicsvrsza36-0.qq.com (NewEsmtp) with SMTP
	id 21E8E872; Wed, 19 Feb 2025 22:08:30 +0800
X-QQ-mid: xmsmtpt1739974110tgo10yank
Message-ID: <tencent_83C97263B064441765B762E6CDD360637605@qq.com>
X-QQ-XMAILINFO: NBOcPERDMH3AumCsObGr+Qx4l4zN3gpDjrf7APL71K86202YEhR2Y6WPTtGEfZ
	 6nlnelOYcMeEI6j3sNPN/JPRJq6XZPyPL581jK9ZTTwjEO6mf7CaXvRRJArhD9/9zIvgpc8ABiRO
	 elvKPTXmttPi9OHFQS3BDuk3LqhYgCPrYhTqEMQTBrvCg/ULRpWMtKVoGFN07bMD6n56w6dPHeyH
	 PQ7g7Jym965CLVvEG2LjIR0O3/6QxAnCva/VO759VUHD4s/gqxfviYOcRvBV4/c8RE+hlPvJAKhO
	 SVMtHE2bzG2LIACvvnt3R5czT8ctVFSX1U7yv/uApN/ZLp9sz898AeUuIVseVD3CUxs68/E+t4mA
	 PIc+/OdDnT57OVlNU8ynD8g5lT2vrnW4j4AZ5U0L69rXGfmndOb53mB+j+ifEMaTPHt4dDf6rffR
	 2bSLXuE/kKovznF3ZEZn6YphuYly8k8QuM41pcbnZQ3Je06rzbHpvQqXRZz7K/QCXKmmVLE5bRtf
	 WnjRr7TT6hGSwf3FB5UJguNP+hLMHr3IgwOw9OAlCwK9gaC3d4M7CveFknU2qOQQryYs5AW8NLYM
	 OkBDcFZ8co6JO4LTTvKg4maitHXkRPilP59aAsvBz+455jHJ54rEAQS8upi7VCHKJnlgWW3HxLim
	 KLmyUguZ971FvzZn1JyhxF+65sCkHyg3jkaUhSO1smww2esAPI3sYi5nWxj9uJviTK7851aENfur
	 qO8x6/HuMmi6IKC4ZrEQnhWZhr6u+zZzmG+zrNwaCJyWhDj/tbM9fhOhsrTmRwazCaKOJj1UrSyL
	 U49HyAyYBD8BES/5UvFD5sZE4H0wTfk8KM7OLrayHJvr9Gonjt35LKFRysImiyN39McGXCHf36ER
	 KuSN1fJgS4+jeR9B7UKo+uJeUu6il9XpTEwEdlfNfwvDKaNc9NSnc=
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+df6cdcb35904203d2b6d@syzkaller.appspotmail.com
Cc: jfs-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	shaggy@kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH] jfs: set diskblock and maxag to zero when creating imap
Date: Wed, 19 Feb 2025 22:08:31 +0800
X-OQ-MSGID: <20250219140830.1594645-2-eadavis@qq.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <67b5d07e.050a0220.14d86d.00e6.GAE@google.com>
References: <67b5d07e.050a0220.14d86d.00e6.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot reported a uninit-value in diFree. [1]

When print_hex_dump() is called to print the first 32 bytes of imap, the
first 8 members in struct dinomap are the first 32 bytes of imap, because
in_diskblock and in_maxag are not initialized when imap is created.

When creating imap, set in_diskblock and in_maxag to 0 to prevent this
issue from happening.

[1]
BUG: KMSAN: uninit-value in hex_dump_to_buffer+0x888/0x1100 lib/hexdump.c:171
 hex_dump_to_buffer+0x888/0x1100 lib/hexdump.c:171
 print_hex_dump+0x13d/0x3e0 lib/hexdump.c:276
 diFree+0x5ba/0x4350 fs/jfs/jfs_imap.c:876
 jfs_evict_inode+0x510/0x550 fs/jfs/inode.c:156
 evict+0x723/0xd10 fs/inode.c:796
 iput_final fs/inode.c:1946 [inline]
 iput+0x97b/0xdb0 fs/inode.c:1972
 txUpdateMap+0xf3e/0x1150 fs/jfs/jfs_txnmgr.c:2367
 txLazyCommit fs/jfs/jfs_txnmgr.c:2664 [inline]
 jfs_lazycommit+0x627/0x11d0 fs/jfs/jfs_txnmgr.c:2733
 kthread+0x6b9/0xef0 kernel/kthread.c:464
 ret_from_fork+0x6d/0x90 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Uninit was created at:
 slab_post_alloc_hook mm/slub.c:4121 [inline]
 slab_alloc_node mm/slub.c:4164 [inline]
 __kmalloc_cache_noprof+0x8e3/0xdf0 mm/slub.c:4320
 kmalloc_noprof include/linux/slab.h:901 [inline]
 diMount+0x61/0x7f0 fs/jfs/jfs_imap.c:105
 jfs_mount+0xa8e/0x11d0 fs/jfs/jfs_mount.c:176
 jfs_fill_super+0xa47/0x17c0 fs/jfs/super.c:523
 get_tree_bdev_flags+0x6ec/0x910 fs/super.c:1636
 get_tree_bdev+0x37/0x50 fs/super.c:1659
 jfs_get_tree+0x34/0x40 fs/jfs/super.c:635
 vfs_get_tree+0xb1/0x5a0 fs/super.c:1814
 do_new_mount+0x71f/0x15e0 fs/namespace.c:3560
 path_mount+0x742/0x1f10 fs/namespace.c:3887
 do_mount fs/namespace.c:3900 [inline]
 __do_sys_mount fs/namespace.c:4111 [inline]
 __se_sys_mount+0x71f/0x800 fs/namespace.c:4088
 __x64_sys_mount+0xe4/0x150 fs/namespace.c:4088
 x64_sys_call+0x39bf/0x3c30 arch/x86/include/generated/asm/syscalls_64.h:166
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83

Reported-by: syzbot+df6cdcb35904203d2b6d@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=df6cdcb35904203d2b6d
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 fs/jfs/jfs_imap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/jfs/jfs_imap.c b/fs/jfs/jfs_imap.c
index a360b24ed320..ff32b614a09b 100644
--- a/fs/jfs/jfs_imap.c
+++ b/fs/jfs/jfs_imap.c
@@ -134,6 +134,8 @@ int diMount(struct inode *ipimap)
 		imap->im_agctl[index].numfree =
 		    le32_to_cpu(dinom_le->in_agctl[index].numfree);
 	}
+	imap->im_diskblock = 0;
+	imap->im_maxag = 0;
 
 	/* release the buffer. */
 	release_metapage(mp);
-- 
2.43.0



Return-Path: <linux-kernel+bounces-286518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16930951BF8
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 15:36:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 475B11C214FC
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 13:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 168781D52D;
	Wed, 14 Aug 2024 13:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="xsm7IsDf"
Received: from out203-205-221-205.mail.qq.com (out203-205-221-205.mail.qq.com [203.205.221.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B63B1AED35
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 13:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723642574; cv=none; b=RzGZYonqCmyMf9QagLA4LU4NyFZD9rmkeRyfxdXRzn8Ndb3CAqUQwC2dsbsX3d84/MHOqNZVkbtNmO98Mb7J6I7jl0HRjbmF9sEHpqAEk6XniAJKmRr+2WFz2EJBjbpaUXOkwT4z7vjnsioNXVzTj+jeWu4JOQ1jdNkyQDHQpyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723642574; c=relaxed/simple;
	bh=o1zvuyQHQbhqIbsgFb5goXzprR6YoWbIlH2Qs2aZ4uA=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=XZTCudjgzUFFVfUOudANG/Wuy7U3z1iqlzWZDSARRnquRdQBAJTL3xyohYnkQS9C0xW/+fMdEOPbX4wgS6YYsJn0ZgGIvZZ5OU5CbX0RsDRZgdZ2rz4bbltBIyEk3+Fo7Nmr0KOmX28nFs3osmR+DKPN+x4rY9aNOdaOPsH9+Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=xsm7IsDf; arc=none smtp.client-ip=203.205.221.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1723642568; bh=VxSJGLo3yAH3xdSnAqMQU9UizTBDY+DW2zMwtvtfbco=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=xsm7IsDf1K7vipGGOs5Cs7vyK3YQDo5M1QubfuhpBTBLA3n9ZGQZtKME+1Yy/TPJn
	 yOI6qs+9BMELVjr3kWKG4bzwcdm6tAr20U0Dzh1hep6IS0AVYegglAxvbDb3ytNkzq
	 pCvLfy2GZJnBLVElql59+frjR31lHgrKwcKOS63E=
Received: from pek-lxu-l1.wrs.com ([111.198.225.4])
	by newxmesmtplogicsvrszb16-1.qq.com (NewEsmtp) with SMTP
	id 9072BE97; Wed, 14 Aug 2024 21:36:07 +0800
X-QQ-mid: xmsmtpt1723642567tzaoh1r7x
Message-ID: <tencent_537623A0A452D778B77A26C4736243668905@qq.com>
X-QQ-XMAILINFO: MesT5uKpDagVlCR/nLjyJ1vbRrQ97wpfavf97mJzRwn4KWIXjPmtEokX6teU1V
	 mJ1vX+7Jpyz662LFU9d1nHyLRENucclaDYmFOAUr1ZluXLlkf4mTPndRaQqnARBclSNXzpbbcAV6
	 ys6Mcj9NxzBg0+IUWyoI8+kr9mTCEH9SIdAdBnXv6th4RuFGZlgVYu0ksq0DrM4T5UUSsuREbN9j
	 O9s8WrELugeYGTr9E0Nw8theKbNx+t2zkUFuf75mRv4dVLCGRYiqBWnxZ79wBliX2KIN6vpDYOSx
	 /EjodHdqC9GqzCr8zI63MgBXWdi5cymDqINFPhj/e8F3ZiJbSXO6/xk9zRLKUFGMsjKHdz4xNvaS
	 15Gzj87f1VCBVuXOvoLZNE9dX89DLENKglh2BH21xLbre0Kvhkki8eHz8Nr7uAkKidBlUU0WLTzV
	 Fk4Fmw5kiGMB6E578oZu8PKHhpco2jxgGUhwd2wJHYRxLg3/OiITUhvbJ+mddDzcszKVd27z0xI3
	 UGSopC6yGcLg7GEkhnRjM4H7Ot3OtgdduthMM37xZnVZyrts71LFFhVpsW6UdD1Em3qpRKJPvcYc
	 ip1ACMxvv9cbc8FCaPTl43eAEFGmlwcQIq7h0v+lQAbxRA9MemQFbWgv+HLZ45T1Pc7vwN99kDe+
	 dCyTnn/aKn1KKbN13+TlPLsmdWguFyb/S4zGsLFFk+uD+pzBWPaVONRLzW/oE23PrMAE3Vo7LmTv
	 ri8F6ofaSZ/Klb0Lifrf1ugqn07GcRaJEcS6I+iCQYe+hSGNZTb0W8KzaG8hAx4dmgfHCZjsmxZm
	 lIxjdW8Y74OYdUDpa6hVQykjBsxES+rBqpPyCmJc+0kCRtD9buZmIeOYEg5k2jYyysQNeDyVbGC6
	 diqcsLuCcdcRIS/6Ppfxqec0o3zWW5sxRbNp4AUe19ty4bGqaNI5nMVkkyaNBVgxnVYY00zcSnUo
	 l/92R6GgMjJRbD+aBu7g==
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+733300ca0a9baca7e245@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [f2fs?] WARNING: lock held when returning to user space in f2fs_commit_atomic_write
Date: Wed, 14 Aug 2024 21:36:07 +0800
X-OQ-MSGID: <20240814133606.1271621-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <0000000000007dfbdb061fa35855@google.com>
References: <0000000000007dfbdb061fa35855@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

unlock i_gc_rwsem[WRITE] before quiting f2fs_commit_atomic_write

Fixes: 7566a155c666 ("f2fs: atomic: fix to not allow GC to pollute atomic_file")
Reported-by: syzbot+78ff2855f26377625419@syzkaller.appspotmail.com

correct git tree to linux-next

#syz test: linux-next 9e6869691724

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 741e46f9d0fd..a43054ab0cf1 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -389,13 +389,13 @@ int f2fs_commit_atomic_write(struct inode *inode)
 
 	err = filemap_write_and_wait_range(inode->i_mapping, 0, LLONG_MAX);
 	if (err)
-		return err;
+		goto out;
 
 	/* writeback GCing page of cow_inode */
 	err = filemap_write_and_wait_range(fi->cow_inode->i_mapping,
 							0, LLONG_MAX);
 	if (err)
-		return err;
+		goto out;
 
 	filemap_invalidate_lock(inode->i_mapping);
 
@@ -407,6 +407,7 @@ int f2fs_commit_atomic_write(struct inode *inode)
 	f2fs_unlock_op(sbi);
 
 	filemap_invalidate_unlock(inode->i_mapping);
+out:
 	f2fs_up_write(&fi->i_gc_rwsem[WRITE]);
 
 	return err;



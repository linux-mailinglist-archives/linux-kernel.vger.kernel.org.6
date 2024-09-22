Return-Path: <linux-kernel+bounces-335025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AB83E97DFDD
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 04:20:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2F01B2118E
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 02:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A82F18F2FA;
	Sun, 22 Sep 2024 02:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="jScGLUyi"
Received: from out203-205-221-221.mail.qq.com (out203-205-221-221.mail.qq.com [203.205.221.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26A538397
	for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2024 02:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726971592; cv=none; b=PGTkZdZ16QSUhxjqY5pl4574tMHsEGTVNrgaEPIw3cMj3OpSHLKADmloun0UqRgEelXIOop/EqNHtgmveyxGacpi25qtH8HaYRuhOJYBGWJ5tq6htFA/kr3WzdrH/J0hREf8K5ZC8dUqm79spOr+y8IJvjv/g3zlXI4h61roB04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726971592; c=relaxed/simple;
	bh=SDLihd7UIIrFgwuVQzzLVs7ZIlVO9DU6GLo3SR23W5U=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=J6Pyxj2CYNXKPYN8qZ0D8K6jFqY8ApjdXAdkAGQMDVKt8D75HItZuD3Fl9Q0xwrMTAhHibBcA/jkKr5ue6N/7Jyu1YdhVuZo7U6fImZI6bfINmaUX73EO1biOjr8vO0nTYlzcoMCVte3220feciEykIogy+nALBYFAElIv3/L7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=jScGLUyi; arc=none smtp.client-ip=203.205.221.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1726971282; bh=bwI1R8XX91rMXWmdfJMzi37q35Axwa6iVFfplsEpLk0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jScGLUyiGFrUa1r8x8tKdZG/sCLZkGEVdCw8v5QFfLtJlBo3UhqDrE9LC5e+MgwDW
	 UI8NYHp9PjdBuR+MfWjqmjdk/6cRkwJmsMjSM7QCXTlH72x7qWxIooSKOYTOaTKl5m
	 mB3BaMX1Uj+1CkLKK01BsjCcf2atKuWot/YkG/M0=
Received: from pek-lxu-l1.wrs.com ([111.198.224.50])
	by newxmesmtplogicsvrszb9-1.qq.com (NewEsmtp) with SMTP
	id D158D4C6; Sun, 22 Sep 2024 09:52:21 +0800
X-QQ-mid: xmsmtpt1726969941twy56bx79
Message-ID: <tencent_8006C812E1C657C99D2EF6EECB4C9E67CA06@qq.com>
X-QQ-XMAILINFO: N5sfBKY/oC4kDparIFi/Ydyu6B8ixW5dzKwGrSI15n+0WDPX1Ze2Sc6s7uwZ2y
	 0Lq0CNsGc7ZQkIEeVNkkPq+Y48B68zKcuDXBeboV6/OYmHk+F9NdI/KXfmhDgk5t3BOfg9V6oeGI
	 jQvUGmgGFlTycUZKpPx5H/wf7yAolsScYcIfsS4cObpipZ8SiTEp5+9KMrwwF0PzfVF62LKm2PzF
	 tQov5ip39aFNdzFdj1QBA4zte7vTA5grzyjqZx7OuuLxFk8nEe9sbzaqsYa1pjdyKcd6SClnr5qu
	 o0E2bhon3YhAktwd0djNsbNXcFDg+E8i/IiGxsuC4VQhWP/G11sVhFOXdnk9T2NoEB9EAYNPdhC6
	 af/BM3/40A311GxZnI3pKArLCGKIl0/tdM2Inl2+vah7+UQEh+K2J91TzHx1/siY95qttINPXq/I
	 00yedxD0JNadZpetoafWr9pCuzMx+UgeRt29EkCV7n5oHpDHKEW1VYYUV7l73N/2MKdJ1K4eOGsx
	 wyYx/S9yvijFjQjfmxZnKdaqL5gVglSEIb667yUJxSyHbf4VDHU5ha6n2x7HR5Qnlvsea6RavjCF
	 C+xS0JfbZdOaCj9pDO/NVoaqy2Ht40u//gL1CcJlAN/tBto3WkRjZmVZt6M1pFvgjzOvc7f5TEr1
	 DRjV0G+JlBLp4COFS1AbvAr8HYYUxMVQkiBD1A6NYQYFrH55GIGebMVbi58fj2SeZPmuWwaVl9PC
	 EWskZyKDIq9OYsRjJ/fP6pnB8GQ9PyPNx+fHYMFSUYq9NzGfEFgka8nCY7wcBjUMsAqmwS9gBilr
	 tOj3PRbWhbjW9/Ce84UcvFVDtOG3r5x2+PF1aLMz5ZlAa4x8grPCuQ3tM/rAQD/ByYxGNJvhRUbl
	 V2y+L4Q7/a21Khouc8ddZnjzPFwEbVW3L0ravHTghYQrfD3XSjH3obmfOm3bZTBg==
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+6c55f725d1bdc8c52058@syzkaller.appspotmail.com
Cc: jlbec@evilplan.org,
	joseph.qi@linux.alibaba.com,
	linux-kernel@vger.kernel.org,
	mark@fasheh.com,
	ocfs2-devel@lists.linux.dev,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [ocfs2?] KMSAN: uninit-value in from_kuid (2)
Date: Sun, 22 Sep 2024 09:52:21 +0800
X-OQ-MSGID: <20240922015220.1606897-2-eadavis@qq.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <66ed92f2.050a0220.29194.005a.GAE@google.com>
References: <66ed92f2.050a0220.29194.005a.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

use vfsuid and vfsgid to replace

#syz test

diff --git a/fs/ocfs2/file.c b/fs/ocfs2/file.c
index ccc57038a977..beb4f241bdeb 100644
--- a/fs/ocfs2/file.c
+++ b/fs/ocfs2/file.c
@@ -1129,8 +1129,8 @@ int ocfs2_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 			    (unsigned long long)OCFS2_I(inode)->ip_blkno,
 			    dentry->d_name.len, dentry->d_name.name,
 			    attr->ia_valid, attr->ia_mode,
-			    from_kuid(&init_user_ns, attr->ia_uid),
-			    from_kgid(&init_user_ns, attr->ia_gid));
+			    from_kuid(&init_user_ns, attr->ia_vfsuid),
+			    from_kgid(&init_user_ns, attr->ia_vfsgid));
 
 	/* ensuring we don't even attempt to truncate a symlink */
 	if (S_ISLNK(inode->i_mode))



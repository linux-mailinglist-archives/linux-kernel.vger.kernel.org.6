Return-Path: <linux-kernel+bounces-319601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05FF996FF11
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 03:49:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3112D1C21F29
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 01:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA89FDDC5;
	Sat,  7 Sep 2024 01:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="ShPejgy0"
Received: from out203-205-221-231.mail.qq.com (out203-205-221-231.mail.qq.com [203.205.221.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663681171C
	for <linux-kernel@vger.kernel.org>; Sat,  7 Sep 2024 01:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725673751; cv=none; b=dqg+tXZlmTkaB+SFGm6nmopFHSx/+r9VWGFLGU+K/ilS3PbJ7ROZQiWKhlkd6NNwumhWTRGxZtCeJjoQt527g+KzcfAqaLbM/remp9TcSHaW6DUuVGVgjY+3tp6dcBnEmmqNgHQmBfILoqO1Qan+inc58L7WwMolAComTaNE38Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725673751; c=relaxed/simple;
	bh=eNt+p4t3mbxOaD2bqhmu3nNASkrt3YmWHvIyNhqNBlk=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=ioIkv+V0iBImQHgG7GW0cGDKOlv9TaIkppkq5pqqmHa9bk/bLBTTt5pg/oBhWZJHGPWOYJnk4pPZzo7CENvCPaJ/0VynsMDDDdnAFQjsiYQ+ahXWIMbuhsHzAVj7a/8VcljiN4R5xh+8H9LE6IrNM3W81X1poQd905HJ0CoiP8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=ShPejgy0; arc=none smtp.client-ip=203.205.221.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1725673741; bh=8G3qj1qfuwE8Fg1/n2YYsrJOIhTbCUMPT2rjZDmi3H8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ShPejgy0CkrHc0jPotBu3DPZYPUgD4IX/j3VoIc3GE2KXRZTYoKlMITc4A1fpvClk
	 a/TisDOiY3vS0fTst6ZNcT4s/KtpLl2zN1AxqU9PTf7z8jTJ2M7c04vmDIQSPChtzD
	 i9grteLfzg5oqxsh2cthqY9J27cJHu5/u/t89I7U=
Received: from pek-lxu-l1.wrs.com ([111.198.224.50])
	by newxmesmtplogicsvrsza29-0.qq.com (NewEsmtp) with SMTP
	id AB9B209F; Sat, 07 Sep 2024 09:42:57 +0800
X-QQ-mid: xmsmtpt1725673377twjjob309
Message-ID: <tencent_70204B621B682561BA47BB81339A9E031B08@qq.com>
X-QQ-XMAILINFO: MntsAqBg2ZZ5IG87yAobPGJfZFATKaIxgziRRP+pv9XsR2RJZzgrIOq9LCC7sH
	 mN+UTfTSmOrvXRedgXERDd7vn2gGDebpkTm0x0hwg462BwgN+5U5rc2He1DvtzGpMu2nEj8SHYkj
	 1YxVN51JxcfojXXinGPRR4wn8MkctQmSOu3ahxrnM79yg5B1reL0YSdu88rMqqoN657jnthFi6uG
	 bMN0nFgNf3iNlWIwsASnGaZ/+YAF78qemUW+sBR/RkyUBug4bP+tdoC7O+wNe7y4d3/n3Bnc23/I
	 PVAkO6+tuzr0Mz4Ev9DxlIpRQ1iWgKkxxkDfFRkMiOx2jpbEUyvA/JljnEVPi0NH6HmrtUDa4HpI
	 b9rvxm+OcpcokXVucKCwaEXL6zkek8PyeiygAJAAJXt0906bhGR+o9Sv/mX6bf9rTAccUJn17I5V
	 +d2tcvlVUZ75v9hHCQe0QnuS5gemH88JLfbc2tlE7d3ksIsd6Vi2LODUQTlRRXEYuHycR5hqat7M
	 JCBkRbYs6XsjiVtUn2XJ/eAwfOkBcq+mcg+sIFsJsTCDI8uAW+peYyje8/TgNXysZRU0kjA+7IgN
	 io/g/yDWWXo1d75ydg38l3owoSIm6TTNS5tM8n4bQK3M97428a9EqIVjKLdaRoZORgL8sTVbiJVF
	 c9AGybvZXgNey+P9owFEUnLSabhCTeJn9N6K3WhVbTknBA3hlYpCXATd9hlSKweTmT1p56pIYjs8
	 sWb43murbfHHUYKR4LBVPVm9mkV5hQcLzMmkojhJyzpLyxtXvJlMTJqtk+QyHpJowPqzVczI+qrh
	 rvg+2ASSj/729hi64K8t1RpzqIeQ/kl3sknut7H0mCJfWizikI7eAVGSGZXv4jxWnBOuKR75xX7j
	 tCg0Qe6u+xW9DF5YlE1yhGTeUlXy9VBgn+fi8ds0H0ZN54Y7g/IImpkMqxAVWfft86KF0n+MlP
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+3bfd2cc059ab93efcdb4@syzkaller.appspotmail.com
Cc: almaz.alexandrovich@paragon-software.com,
	linux-kernel@vger.kernel.org,
	ntfs3@lists.linux.dev,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH] fs/ntfs3: Move condition bitmap.sb to before run_unpack
Date: Sat,  7 Sep 2024 09:42:58 +0800
X-OQ-MSGID: <20240907014257.499390-2-eadavis@qq.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <0000000000007a66c5062140e8f9@google.com>
References: <0000000000007a66c5062140e8f9@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[Syzbot reported]
ntfs3: loop0: Different NTFS sector size (4096) and media sector size (512).
INFO: trying to register non-static key.
The code is fine but needs lockdep annotation, or maybe
you didn't initialize this object before use?
turning off the locking correctness validator.
CPU: 0 UID: 0 PID: 5231 Comm: syz-executor253 Not tainted 6.11.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:119
 assign_lock_key+0x238/0x270 kernel/locking/lockdep.c:975
 register_lock_class+0x1cf/0x980 kernel/locking/lockdep.c:1288
 __lock_acquire+0xf0/0x2040 kernel/locking/lockdep.c:5019
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5759
 down_write_nested+0xa2/0x220 kernel/locking/rwsem.c:1695
 mark_as_free_ex+0x3e/0x390 fs/ntfs3/fsntfs.c:2484
 run_unpack+0x7f3/0xda0 fs/ntfs3/run.c:1019
 run_unpack_ex+0x14b/0x7f0 fs/ntfs3/run.c:1060
 ni_delete_all+0x2d9/0x9a0 fs/ntfs3/frecord.c:1610
 ni_clear+0x28e/0x4b0 fs/ntfs3/frecord.c:106
 evict+0x534/0x950 fs/inode.c:704
 ntfs_loadlog_and_replay+0x2e8/0x4f0 fs/ntfs3/fsntfs.c:326
 ntfs_fill_super+0x2c38/0x4730 fs/ntfs3/super.c:1280
 get_tree_bdev+0x3f9/0x570 fs/super.c:1635
 vfs_get_tree+0x92/0x2b0 fs/super.c:1800
 do_new_mount+0x2be/0xb40 fs/namespace.c:3472
 do_mount fs/namespace.c:3812 [inline]
 __do_sys_mount fs/namespace.c:4020 [inline]
 __se_sys_mount+0x2d6/0x3c0 fs/namespace.c:3997
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

[Analysis]
Before call this path, sbi->used.bitmap.sb has not been initialized in
ntfs_fill_super.

Reported-and-tested-by: syzbot+3bfd2cc059ab93efcdb4@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=3bfd2cc059ab93efcdb4
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 fs/ntfs3/run.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/ntfs3/run.c b/fs/ntfs3/run.c
index cb8cf0161177..8970101147c7 100644
--- a/fs/ntfs3/run.c
+++ b/fs/ntfs3/run.c
@@ -1057,11 +1057,14 @@ int run_unpack_ex(struct runs_tree *run, struct ntfs_sb_info *sbi, CLST ino,
 	bool ok;
 	struct wnd_bitmap *wnd;
 
+	if (!sbi->used.bitmap.sb)
+		return -EINVAL;
+
 	ret = run_unpack(run, sbi, ino, svcn, evcn, vcn, run_buf, run_buf_size);
 	if (ret <= 0)
 		return ret;
 
-	if (!sbi->used.bitmap.sb || !run || run == RUN_DEALLOCATE)
+	if (!run || run == RUN_DEALLOCATE)
 		return ret;
 
 	if (ino == MFT_REC_BADCLUST)
-- 
2.43.0



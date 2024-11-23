Return-Path: <linux-kernel+bounces-419027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 684369D68AD
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 12:04:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65125281D71
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 11:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ADB317C7CE;
	Sat, 23 Nov 2024 11:03:45 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2F437171
	for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 11:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732359824; cv=none; b=sTQSKCpdnQw/xZI1zjGAeO8KEieKgdRSYo3X2yW/eMibMxAlKm4UQfv8xO0DU+LtCu3q2Y0FzeNQd5TeyqGt4Qvqm3tMe+ut9//qak9Damdl2xkfyJ5ER+FP/NO04RXe2DEMZ0Bx0SyWA9cu/LwScaXeM5j33vmRWdUGqIjbh9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732359824; c=relaxed/simple;
	bh=AcW1pzHRwc++yy4kwyJcko3+44BjcCB5q/uENXMqVls=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=WIUl+wx8Eyh4YZsozJyjIdeDtb6Fk+5SdtjpSWNxO6OzdER/JkFiTOWPfF0wOSeLD98Ifus6DU1e0G5zMSeAW154lKa1VcLizcKvk8l0AKn0jUTug569l87YYUmIREEqi+68NrysS4zcYxH08aWp3j77Urm289y85MsZG+YnKew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 4ANB3Sp4023236;
	Sat, 23 Nov 2024 20:03:28 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 4ANB3SoZ023233
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 23 Nov 2024 20:03:28 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <f1601b51-4c9a-4a99-ac04-9403f2939b37@I-love.SAKURA.ne.jp>
Date: Sat, 23 Nov 2024 20:03:29 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: syzbot+0af00f6a2cba2058b5db@syzkaller.appspotmail.com,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: Re: VFS: Busy inodes after unmount (use-after-free)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav203.rs.sakura.ne.jp
X-Virus-Status: clean

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git v6.12

 fs/ocfs2/namei.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/ocfs2/namei.c b/fs/ocfs2/namei.c
index 59c92353151a..5550f8afa438 100644
--- a/fs/ocfs2/namei.c
+++ b/fs/ocfs2/namei.c
@@ -200,8 +200,10 @@ static struct inode *ocfs2_get_init_inode(struct inode *dir, umode_t mode)
 	mode = mode_strip_sgid(&nop_mnt_idmap, dir, mode);
 	inode_init_owner(&nop_mnt_idmap, inode, dir, mode);
 	status = dquot_initialize(inode);
-	if (status)
+	if (status) {
+		iput(inode);
 		return ERR_PTR(status);
+	}
 
 	return inode;
 }
-- 
2.47.0


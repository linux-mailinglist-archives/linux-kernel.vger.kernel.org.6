Return-Path: <linux-kernel+bounces-290430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 599429553B9
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 01:17:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DFF7BB20D12
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 23:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB60A145A16;
	Fri, 16 Aug 2024 23:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="JhDfl4w/"
Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050C0B664
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 23:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723850221; cv=none; b=NlBpjApuaPsQaqMp8t6ZHR0R/rTMWMsPRkvekA/hw03ofRwdvBYlaRvVyO+LQQzXdcUBdcjX3DIFwa2fo4/MwCfoOAuk6PVAonf8u+XgO3zS4MbOPFCLypJ9SSh3eSKJl8X9LGB3W9IuBI92naZ5ddv+e9haZ+w7hnYYPovDy6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723850221; c=relaxed/simple;
	bh=roRvnMwEWZWDsXSMqVQw0j/j8y20FwYSvEpuhG751tI=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=KAbiqHL1AJenpiJKCGsWync2TUOASs6Cq8+KNe6i1xPt0ROm7GYtuC8uVCUBhsjYkHEOxdtBZ5M3RSuCd+RUmFJtuPf9DmcOJeLiEHAW+uL6eyqOlCmXh2WMRWxH34ojIoWvV28p6acfCSnNqaUST7o8fYbuOVQU0r+anct4LlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=JhDfl4w/; arc=none smtp.client-ip=162.62.57.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1723850207; bh=w4EDB6xIbYl4sweb0Ucwmvlm9pLvdkiDIhy2X+d1Y8E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JhDfl4w/Hy/7Y13LGHkFSKR5j87ngJaLGSvc46AJNC9nv3aY07ezgOVf7Bhlj4PL9
	 Kej5lzEnSrZXbO1sPWD0WdCKls+3jEsC1xu9k8jPmgS8eLNxjy5wMMoF/ihKIzzFr8
	 IahknQmF6qGwW1rY8l7WKvqFxN+znDfaLJM+LpBE=
Received: from pek-lxu-l1.wrs.com ([111.198.225.4])
	by newxmesmtplogicsvrszc5-2.qq.com (NewEsmtp) with SMTP
	id 42D3322D; Sat, 17 Aug 2024 07:16:45 +0800
X-QQ-mid: xmsmtpt1723850205tivmd9kqf
Message-ID: <tencent_656E089498E91AEFC2CFEC78566F042E410A@qq.com>
X-QQ-XMAILINFO: OdIVOfqOaVcrVz7lZ/6IcCsTq2d26SvflW5o0awemGjQOH5Az4hS9HNnlUilSS
	 HnyCxTJPGEFSTeK7CHOOndnrlrsAF06Ve22lESdKmdlLcVBvErSlgCrlFnkULoAJFFxU4GxMxgs2
	 AzIhqUxa8mT+5FWPZUflwHEHAVkH0PJyeAVzo7c7fEblAHLZ7ny+ZPRv9xZfNSGY07MxT8I7m++P
	 KhCvDj01dFgqfiexJLwMnZcxges0mpJPQ/aWF9xG/yZsnJ+i5j9xDGVF+Pev6aqkT8M6BPhy2S5z
	 cDpvLa8WaKk0JrDMPN4hK1Zryk/nFazZIrK3Gr+EeH5Qik6/DKdU8TK8/3L5S3gYFygR0sdHpUdA
	 B1hwJWjd3sdocGwwdFiKQny4auwCYY0o1/qb8xROI7DYOJx5tW9k2dYfnc+ETBl1LStBYH6XtDqX
	 xjzKATItC8F2TEx7fffgc6Ye4oI+i8jfvy27fy3B39QbKNe4zmpArWr9sAmWldf9a2yf02lTZDvT
	 pGfKA4LPTZFPhEY7PZxIMC6dCYcS+vA3bGUCise9o2QX+J4ZTcK8JI/I6h0dzVPk1bcZwFPZB9TJ
	 4G/je0dQtwKN4t25Gms7sOx9IQCMgb8RdlJZ0QP6M9hQ9/4zq1JhBTsQ52IpnyFPKwza0Vbuxt3L
	 jP6mMZMdYGUW4JRDI8wiIvUfP6Jq+lRQcgRtuT7do6UzU+MAt3utlSYS/8N0OJmOu7oPt+2Vzroc
	 DjrVf4f7At5EKSuutTHvqKNHiMQ3v24TBUPqu6mwHlzDT+ZkaGlNntIA35Zu5hKeknBAONJQJtZY
	 dvUy6CkGDMzGTZ9pRs7C+cLTgpXLVxlBkuzYwqVsmzfAJHDV0iLoLhdBCYSIv+bEOr01zdnZMKzn
	 DderMZEIZMv2LLKdwsk5tnXoUAq0kDiTI2XbbVwCa4
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+3c010e21296f33a5dc16@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: [syzbot] [jfs?] KASAN: slab-use-after-free Read in dbFreeBits
Date: Sat, 17 Aug 2024 07:16:44 +0800
X-OQ-MSGID: <20240816231643.1446092-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <00000000000012a63d061fccab65@google.com>
References: <00000000000012a63d061fccab65@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sync jfs remount and  jfs ioctrl with s_umount

#syz test: upstream master

diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
index cb3cda1390ad..a409ae18454a 100644
--- a/fs/jfs/jfs_dmap.c
+++ b/fs/jfs/jfs_dmap.c
@@ -1645,7 +1645,9 @@ s64 dbDiscardAG(struct inode *ip, int agno, s64 minlen)
 		 * call jfs_issue_discard() itself */
 		if (!(JFS_SBI(sb)->flag & JFS_DISCARD))
 			jfs_issue_discard(ip, tt->blkno, tt->nblocks);
+		down_read(&sb->s_umount);
 		dbFree(ip, tt->blkno, tt->nblocks);
+		up_read(&sb->s_umount);
 		trimmed += tt->nblocks;
 	}
 	kfree(totrim);



Return-Path: <linux-kernel+bounces-186246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B41838CC1A7
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 14:57:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C5C91F24711
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 12:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8062A13DBAC;
	Wed, 22 May 2024 12:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="pKayUhcT"
Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB6B7FBA3
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 12:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716382642; cv=none; b=uThq0IEg72gihWnHfFKVXyDCNCqVX0BlALor2vNjxx5vRm2Jhox58CBBwEU4Ec2I0ExtYQKbisQVB+RMyGdtxzpg3In6kCpeL4DCr4foPG+9Ane/T0iiWbtolXU8zfXXvF3ZtpmfHrZxBEjn4gkeZoepr6C7NSU9BkB2MTnycyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716382642; c=relaxed/simple;
	bh=xBud25eM4yR11aN5HGQxiH9+Sx2L4j+qJ0ynZTg8Wyg=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=Y0220i60SW/guwBJAYBWBVHeVbTqkIdMX60uWUGf1/h0sRmEtXl9EjPEdlZnR02MbJFn7la/9Ah0cWy0oHiGWmh78NxZydnBr5C8simHnh0f3hbgRm7TQuNV7ZQszhPSCjdyoSaejFoN6BcvxjvzNzln7teK0/VDVeX5rOAYtQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=pKayUhcT; arc=none smtp.client-ip=162.62.57.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1716382635; bh=5MvkZN3RDGcPo83rc0nLy9YS2nGjPGU9i1zaRaoeixo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=pKayUhcTjS4MN+9LeqgzveeOf1raDDx2hZbClL81MqpRzg7KY/ylImNfEsBR0hy89
	 G3D7n1C5UVVhXI8MYS1BqU+XfqXw8SwR2KfvLe2bnQnTL5xqmAQyn8PJZ+fZEfEYBG
	 dUPKSzqL8XKB/h/yOPYdjOCbFleM0vhSeqR8ncps=
Received: from pek-lxu-l1.wrs.com ([111.198.228.153])
	by newxmesmtplogicsvrsza15-1.qq.com (NewEsmtp) with SMTP
	id C42BA47A; Wed, 22 May 2024 20:49:02 +0800
X-QQ-mid: xmsmtpt1716382142tp2mrrr5d
Message-ID: <tencent_7BF20C9927C0C6D292CCC64BC994EEF92E06@qq.com>
X-QQ-XMAILINFO: Nfm/+M6ONQ57+EFywhSWNnLM+Js8SQ7R0Hanc8fKUO1LMjiwWxSYiL+CqMCihG
	 +512fUG6xrfsYSXQclBFKX3ZJob928gQSnYvnWvJxvzgq00SiEFaSI6TigDnb+eLbmHUaGzYJoj1
	 zh2+c4R2Nl1cIU2+tjIKppGdMopbuwa7jievTglZmWtfR3z1+KUajLJfRlqNaq3mSl3Vu7I6uK0V
	 BpTourEm1Srtf7jxrrrqL3qO35LfVz1e6VynpEBwUtNLciB53MkKQ9k0lSJz9Xf4j9bwxjqgFXi8
	 50Xrk0WTfnUsodHtFrb3TzUIcXfiW0v+RcOw9FViHZTcdNVoMCT9CjhFF5BOCQS2d8pbFXU2sze+
	 H6RmSxKExdXoGzdVFYkHCAPU3SJT2dlq6Y3wpodbYng3NddnvyPEF4G1pcJIq7RRh/+L2X/wgF+B
	 Y3pp80ZhAZVYO/lA00Qd+42HlEcml3qjexXH6TAxlxHxCaDchQIYSCWQ9jDhVDuTJZwyDrMa7Iew
	 VvlTmPT4ZSJ7kCy3EnkBhN5tIKS+C+gKjdx5pGvQ1otLHrU51+u9bgEAOXfZWFeVH9OXcib+Mlva
	 Ogy6coltYll/U1CbuWOqUpNPLS6yNYHyAbQccy25Vfe8nkeavRPYMuwyRapNzIplF9fwqFObaZR7
	 gMt9iLAJ7I+dh+uCY5X8zHeLhKdNpu9KTD0s9EFxD1ULH+GWtUb6bZrJdqynYphoW0rry2na5659
	 KR+2aWHIsJh8I1DF380xpbStreZKBZz7gNQPNL6NNQO7XmH9nFO/4cKGvPyPqc84EM9pi+jQfziK
	 TnF/ETyqfoEUlr6GJIIkNxS5i3w9D3u14whuvdFo1tFBc0PhkzeQZ6SqfNlo8G2bx8bn4EFuycrq
	 T3qt9clTnlYESF4n5miAYKAd9lOzLSB8nTU+9CJELl2jETYOIytMK7F5pUb+UIYUIlxapfK2ERTF
	 4y9B1iG08=
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+d2125fcb6aa8c4276fd2@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [fs?] general protection fault in iter_file_splice_write
Date: Wed, 22 May 2024 20:49:03 +0800
X-OQ-MSGID: <20240522124902.2296647-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <0000000000002fd2de0618de2e65@google.com>
References: <0000000000002fd2de0618de2e65@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

please test null ptr in iter_file_splice_write

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 33e02dc69afb

diff --git a/fs/splice.c b/fs/splice.c
index 60aed8de21f8..8ec408c40755 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -715,6 +715,7 @@ iter_file_splice_write(struct pipe_inode_info *pipe, struct file *out,
 
 		/* build the vector */
 		left = sd.total_len;
+		printk("total len: %lu, %s\n", left, __func__);
 		for (n = 0; !pipe_empty(head, tail) && left && n < nbufs; tail++) {
 			struct pipe_buffer *buf = &pipe->bufs[tail & mask];
 			size_t this_len = buf->len;
@@ -751,9 +752,16 @@ iter_file_splice_write(struct pipe_inode_info *pipe, struct file *out,
 
 		/* dismiss the fully eaten buffers, adjust the partial one */
 		tail = pipe->tail;
-		while (ret) {
+		printk("ret: %ld, nbufs: %d, %s\n", ret, nbufs, __func__);
+		n = 0;
+		while (ret > 0 && n < nbufs) {
 			struct pipe_buffer *buf = &pipe->bufs[tail & mask];
-			if (ret >= buf->len) {
+			if (!buf->len) {
+				tail++;
+				continue;
+			}
+			printk("buf len: %lu, %s\n", buf->len, __func__);
+			if (ret >= (ssize_t)buf->len) {
 				ret -= buf->len;
 				buf->len = 0;
 				pipe_buf_release(pipe, buf);
@@ -766,6 +774,7 @@ iter_file_splice_write(struct pipe_inode_info *pipe, struct file *out,
 				buf->len -= ret;
 				ret = 0;
 			}
+			n++;
 		}
 	}
 done:



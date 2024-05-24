Return-Path: <linux-kernel+bounces-188223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 926878CDF5A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 04:07:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47F4F282238
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 02:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB1F681F;
	Fri, 24 May 2024 02:07:23 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225BBA21
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 02:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716516443; cv=none; b=KgJTOKa6gTVcwThdw6Dxy2A0W3QX4/7LzXDL7SWlgxfqTqQneXCZmukf/dJ3421w+tCwJqi3BeH2a8imOL0/9HjxzsKZS0LwtEWnErMCMICCR7h63wXNtjpEU65fN3bW/ESlSxhu9JNf+aPk36CA28Q4pv7Zpb1hw9wDqWM65SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716516443; c=relaxed/simple;
	bh=MQ3gr4wLJPyqPsY72u8wT+GuL6maEnB+7O1Um7Rr6hM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=sLzC6fctOjGFPWgDp6dCXkKvZ6PTzrHleS2r6pxRwaOMj8EaHphX/INic/cAXyLfE22KYAOjJjKEeOwOwDwDQS943lzEWc24M6WQ8eeN/B23CTQxYXejar4nN4sEm5/V+SGNG2Cd3pIOa7CCXhOhJt0uD3yjGuCFBtDUaAkgvC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7e613a3a0e6so235195839f.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 19:07:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716516441; x=1717121241;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ctLSEuUVB/OTqTZOSOU++d9mlXqgnuzL2cILeiBiC7M=;
        b=hDsx0MRYAPbwaTfJ1glrzhcweWzDWjTKC3ngrphnATgn5f6aAa4kDBnmD2L5rBS3IG
         jevrFdlBOc/t1Om8446uvhMvG28TNJWl9LX5LsrqEm1rJfoDeL2grDU3tMFJ+MCbaMHc
         RTt4osYxL0Cb3+H0oadw+y/rhwFVZsdS7aJVEaLhmNTLCFtT+WojtfSK3LInW6iDU79X
         ctW2q3jAWvM3pNsJs8HYswYEkurwyYYkCR5NfL8/ih2FKaFgGGo/aGGLQBfjd6weCf6c
         r0EmQAHPLdk6aboufd1jdjP3p3sY8ImvCp1ZDAzuI6pnPHljBNPc+fge369sMFgnfbHN
         5WmQ==
X-Gm-Message-State: AOJu0YzzqzBiVj9MbyHozfnpogqZCLc88fmMXraM0tUYq7y0Wdy7A6aD
	HUjj5pIu3Sftd1+fQem0sMwu/oip3pKhqwIJSzVbTs4DeLv0HFOmdHntvyiK0HsBClQhsi8ZFdu
	hKK4CGKmvhuwHqUZbRqsVgSIwlm58fa8VClB9ZERGMb2SOr0xZWRcMlI=
X-Google-Smtp-Source: AGHT+IHCNx4AvsztoNy85YpSiaJneEb/0KvfP77lEvnBl211c6VvUmZz9Dw8fLkmV+32m298qT1VEtvvZyi4QEaMzcFzT9S8xV1q
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2924:b0:488:59cc:eb5b with SMTP id
 8926c6da1cb9f-4b03faa6be6mr22751173.3.1716516441283; Thu, 23 May 2024
 19:07:21 -0700 (PDT)
Date: Thu, 23 May 2024 19:07:21 -0700
In-Reply-To: <0000000000002fd2de0618de2e65@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bbef9e061929a017@google.com>
Subject: Re: [syzbot] [syzbot] [fs?] general protection fault in iter_file_splice_write
From: syzbot <syzbot+d2125fcb6aa8c4276fd2@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: [syzbot] [fs?] general protection fault in iter_file_splice_write
Author: lizhi.xu@windriver.com

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 33e02dc69afb

diff --git a/fs/splice.c b/fs/splice.c
index 60aed8de21f8..abf45d6184a5 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -745,14 +745,25 @@ iter_file_splice_write(struct pipe_inode_info *pipe, struct file *out,
 		if (ret <= 0)
 			break;
 
+		printk("ret: %zd, total len: %zu, %s\n", ret, sd.total_len, __func__);
+		if (ret > sd.total_len) {
+			ret = -EINVAL;
+			goto done;
+		}
 		sd.num_spliced += ret;
 		sd.total_len -= ret;
 		*ppos = sd.pos;
 
 		/* dismiss the fully eaten buffers, adjust the partial one */
 		tail = pipe->tail;
-		while (ret) {
+		n = 0;
+		while (ret > 0 && n < nbufs) {
 			struct pipe_buffer *buf = &pipe->bufs[tail & mask];
+			n++;
+			if (!buf->len) {
+				tail++;
+				continue;
+			}
 			if (ret >= buf->len) {
 				ret -= buf->len;
 				buf->len = 0;
diff --git a/fs/netfs/buffered_write.c b/fs/netfs/buffered_write.c
index 1121601536d1..f7c32835b094 100644
--- a/fs/netfs/buffered_write.c
+++ b/fs/netfs/buffered_write.c
@@ -510,6 +510,7 @@ ssize_t netfs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	netfs_end_io_write(inode);
 	if (ret > 0)
 		ret = generic_write_sync(iocb, ret);
+	printk("ret: %ld, %s\n", ret, __func__);
 	return ret;
 }
 EXPORT_SYMBOL(netfs_file_write_iter);
diff --git a/fs/netfs/direct_write.c b/fs/netfs/direct_write.c
index 608ba6416919..ecd57c4d0ecb 100644
--- a/fs/netfs/direct_write.c
+++ b/fs/netfs/direct_write.c
@@ -69,6 +69,7 @@ static ssize_t netfs_unbuffered_write_iter_locked(struct kiocb *iocb, struct iov
 		 */
 		if (async || user_backed_iter(iter)) {
 			n = netfs_extract_user_iter(iter, len, &wreq->iter, 0);
+			printk("ret: %zd, %s\n", n, __func__);
 			if (n < 0) {
 				ret = n;
 				goto out;
@@ -190,6 +191,7 @@ ssize_t netfs_unbuffered_write_iter(struct kiocb *iocb, struct iov_iter *from)
 			   FSCACHE_INVAL_DIO_WRITE);
 	ret = netfs_unbuffered_write_iter_locked(iocb, from, NULL);
 out:
+	printk("ret: %zd, %s\n", ret, __func__);
 	netfs_end_io_direct(inode);
 	return ret;
 }


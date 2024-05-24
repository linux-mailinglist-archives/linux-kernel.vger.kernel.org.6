Return-Path: <linux-kernel+bounces-188205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34B998CDF2D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 03:30:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADEFB283F2A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 01:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2A1BBA4B;
	Fri, 24 May 2024 01:30:03 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4C8816
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 01:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716514203; cv=none; b=DzppyPymf9T6UIJT9yBV6U1XYSItFuqR6jFngPIWmgT+gbyZ0ZOr+Z0AYctsv7VrxcMQF45EIjC9Cf6Ef7fZpMasIo21wPCjo1Nd6T1AWGO7qvnCK21jgMAymv5Ar7Nbnvdfer3Eu4yRXNbpZYzEnf6n8jrZvl1dcU0RMm+8+xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716514203; c=relaxed/simple;
	bh=ZYazWpvw+bYG2fMtlP5Np+WGO/BCQ2kjQM3P84QFgBI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=trPkt0biQMM/pcbza889Siq/VkwftxNKxMM6wmF5yIpDPTY+ibQlF7j/QXOYIlMm3Q3qr+JFmlHv3I3RfKzxseDXmE66GXKD9dKSkM6fAbhRrF1M7OGYWNLdMhEnjblHNWHjAHtQadLALV05GDe6IdepgynEiNfb3ySaxPfY1U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7e8e5d55441so41138139f.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 18:30:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716514200; x=1717119000;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xum07OyP8OraH8YJqAAJwk/gnN5NQ+dy8a44icFp1H4=;
        b=bU9lVZhtuUVjKnYFXxzqsAk2Y9A7G3l4ZjsSq91Nj02IdUQr2puHgBMKDhYAZsjb3R
         2JO1wNrewfmbsaCpBkrsc4eEsb1XYzwuON3YQIpLumjkrUA+nUzr1na4yHG60yWkuqff
         JThF38yUFJZVIO89OueXM5TPqqkSwG2w3rIrASFGVNi9OPzRVMIN0mMbEm5CF2IWuRMO
         xQRCMzvhQi+ds9Z8f7iqGO5WkKcqQhHq+p7yZr2hEkZfX+IVI8ErcxUBg/phhXuCD89C
         bwDAd12FRsvMXvj+Eh0tUEPU/dHDjIGJRgC1CdnsB3pW/A6tn6nQ3w+9Apz6oioFGrE7
         ssog==
X-Gm-Message-State: AOJu0YwbE5ArZY5K/nmX5QUdfXrVooHPzJLH7KJl8U5GNsj+4MY3B2Sb
	e0EnShR/FzcQJ14+5ma+5JV2oTVu9La2CeBHveNP6TuV82zZHVREAA55KJHUgK3Vj7NUzZAJ4MA
	WHRGu9wMkda5xJtwOJxQx8Rs1HHc4IHLK8LdUrNfs59lYFO1mkOv9loc=
X-Google-Smtp-Source: AGHT+IEB6iev4lnsp1UxByRr+cLYy3zwQhT+ZxXlBvqjhuKnYidwGwFqTzR8l7gr1poElwmbtMKnsHuOX4li1rN19PQnlAjxmMuq
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a02:c98e:0:b0:4b0:3631:7257 with SMTP id
 8926c6da1cb9f-4b03f6326a4mr20359173.1.1716514200500; Thu, 23 May 2024
 18:30:00 -0700 (PDT)
Date: Thu, 23 May 2024 18:30:00 -0700
In-Reply-To: <0000000000002fd2de0618de2e65@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002c52e50619291b07@google.com>
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
index 60aed8de21f8..c6d812684d4e 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -745,16 +745,30 @@ iter_file_splice_write(struct pipe_inode_info *pipe, struct file *out,
 		if (ret <= 0)
 			break;
 
+		printk("ret: %ld, total len: %lu, %s\n", ret, sd.total_len, __func__);
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
+			printk("ret: %ld, nbufs: %d, buf:%p, buf len: %u, m: %u, t: %u,ring size: %u, t&m: %u, n:%d, %s\n", 
+					ret, nbufs, buf, buf->len, mask, tail, pipe->ring_size, tail & mask, n, __func__);
+			n++;
+			if (!buf->len) {
+				tail++;
+				continue;
+			}
 			if (ret >= buf->len) {
 				ret -= buf->len;
+				printk("ret: %ld, %s\n", ret, __func__);
 				buf->len = 0;
 				pipe_buf_release(pipe, buf);
 				tail++;
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
index 608ba6416919..8157b4e6d7b3 100644
--- a/fs/netfs/direct_write.c
+++ b/fs/netfs/direct_write.c
@@ -190,6 +190,7 @@ ssize_t netfs_unbuffered_write_iter(struct kiocb *iocb, struct iov_iter *from)
 			   FSCACHE_INVAL_DIO_WRITE);
 	ret = netfs_unbuffered_write_iter_locked(iocb, from, NULL);
 out:
+	printk("ret: %ld, %s\n", ret, __func__);
 	netfs_end_io_direct(inode);
 	return ret;
 }


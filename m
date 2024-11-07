Return-Path: <linux-kernel+bounces-399592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D0419C013B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 10:36:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BE6F1C213CA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 09:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A88501E1043;
	Thu,  7 Nov 2024 09:36:00 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A548B1E0DED
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 09:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730972160; cv=none; b=aZd/XMDtuCn9gEV1kXm/7QqlDvLcs4uTOZNUzUhcohhGKCUq0j8/R6UYVPF2ZQV5/2yQyh45HUUevtfQ0WE7ID3H7i0a8THigepp8L/qITpxr3bqRB3vU9361IiQuT4IcSOi+WakiRT0P5Tp1RNdaQoFBf6yXkcyNjnuJ1+XbtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730972160; c=relaxed/simple;
	bh=VQi/YAj6fn3bpq7JZNWqkMSXEsRQrA/ULc92Lb/zmEU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=RQD9n8uEA8dfzPs7QoNgIF9op9m0Ztl3LNwiB9Hj6t8SZ9p8r49YyVwZHLHjuuzq19Qvwh64eycTY6Rl3d6WDaoHMws5a0Je3cM1gCRNBu8rjjYPuWCDgeET8wKH5T8jqvuuDA6zCYjKyv9kwU5Pm7QSqlI6cWtzlcy2rpu3Fu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a3c4554d29so8830255ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 01:35:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730972158; x=1731576958;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MOl0qqtOmTWHIbRQiST5WY9uhJbGKOWmM6OMiHRavwI=;
        b=XIE/KNnvoTj68+dKg2PWinaQf7y2EWiNfppaiGkwOOS6tQbw0HHss6CAD9ZkKtZYNP
         wLxwXv9nQ/5BkZakSSnP+jdq8dA2FQFk7UxI/yD8DVtwtYzrYy7M7lMPwhB9n+amEfVV
         vJw9cm4IQKxxWqymuqt+qiDiEmBjYAPRPIp5izdJr52BGChwfU4wh5+XcygXoDGY6YQ7
         rm1jvzKSRhjR6q6ISHxghlLmU/nRbfgziV7hUxB8aA8EzIsF2BW9zO65/evOK/EOCqeG
         0xDJ+u3H9jcEiQDYwaKSj5oCHXLvLqITJTY+Bv6UyL1Mu5ggr4zJm3H+9zkFzS80qmTv
         i4lw==
X-Gm-Message-State: AOJu0YzBTlE4N7PQYOYt1EguqmCY0UdcEDQtFg3fegjsVpAB7WnqEZ/0
	kAPCWTY2+DAt8EjSHhGtyLKZkpy2qjikKWCOkZU/awr1hcltO3hJqonA+TI2qFCjJPtywA88z1X
	hLUAVORE/uufFhX1Iofb8WK9kEY4x1wHhPqJ6tQ9ovxGVvQYeWGGKI5E=
X-Google-Smtp-Source: AGHT+IEWGX/E8xyQQ4aaNaX8OZPw42dlMRgUrwjRyJ9drUnixxUnsAFYnMYIr27y91RMaOyQrazH4WHyWios6w5Jjl8QUUvri8E7
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d11:b0:3a5:e7a5:afc with SMTP id
 e9e14a558f8ab-3a6b028898dmr258882275ab.2.1730972157945; Thu, 07 Nov 2024
 01:35:57 -0800 (PST)
Date: Thu, 07 Nov 2024 01:35:57 -0800
In-Reply-To: <672b7858.050a0220.350062.0256.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <672c89fd.050a0220.49393.0175.GAE@google.com>
Subject: Re: [syzbot] Re: [syzbot] [mm?] BUG: stack guard page was hit in v9fs_file_read_iter
From: syzbot <syzbot+1fc6f64c40a9d143cfb6@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [syzbot] [mm?] BUG: stack guard page was hit in v9fs_file_read_iter
Author: lizhi.xu@windriver.com

add limit to avoid retry too frequently when rreq need to retry

#syz test

diff --git a/fs/netfs/direct_read.c b/fs/netfs/direct_read.c
index b1a66a6e6bc2..1863258cd9db 100644
--- a/fs/netfs/direct_read.c
+++ b/fs/netfs/direct_read.c
@@ -87,6 +87,7 @@ static int netfs_dispatch_unbuffered_reads(struct netfs_io_request *rreq)
 
 		netfs_prepare_dio_read_iterator(subreq);
 		slice = subreq->len;
+		printk("subrq: %p, %s\n", subreq, __func__);
 		rreq->netfs_ops->issue_read(subreq);
 
 		size -= slice;
diff --git a/fs/netfs/iterator.c b/fs/netfs/iterator.c
index 72a435e5fc6d..ac9ca11b091f 100644
--- a/fs/netfs/iterator.c
+++ b/fs/netfs/iterator.c
@@ -63,6 +63,7 @@ ssize_t netfs_extract_user_iter(struct iov_iter *orig, size_t orig_len,
 	pg_size = array_size(max_pages, sizeof(*pages));
 	pages = (void *)bv + bv_size - pg_size;
 
+	printk("bvsize: %lu, pg_size: %lu, cnt: %lu, np: %u, max_p: %u, %s\n", bv_size, pg_size, count, npages, max_pages, __func__);
 	while (count && npages < max_pages) {
 		ret = iov_iter_extract_pages(orig, &pages, count,
 					     max_pages - npages, extraction_flags,
@@ -98,6 +99,7 @@ ssize_t netfs_extract_user_iter(struct iov_iter *orig, size_t orig_len,
 	}
 
 	iov_iter_bvec(new, orig->data_source, bv, npages, orig_len - count);
+	printk("ret: %d, npages: %u, orig len: %lu, count: %lu, %s\n", ret, npages, orig_len, count, __func__);
 	return npages;
 }
 EXPORT_SYMBOL_GPL(netfs_extract_user_iter);
diff --git a/fs/netfs/read_collect.c b/fs/netfs/read_collect.c
index b18c65ba5580..4e244dfb23bf 100644
--- a/fs/netfs/read_collect.c
+++ b/fs/netfs/read_collect.c
@@ -465,6 +465,7 @@ void netfs_read_subreq_terminated(struct netfs_io_subrequest *subreq,
 				  int error, bool was_async)
 {
 	struct netfs_io_request *rreq = subreq->rreq;
+	static int rtt = 0;
 
 	switch (subreq->source) {
 	case NETFS_READ_FROM_CACHE:
@@ -506,12 +507,18 @@ void netfs_read_subreq_terminated(struct netfs_io_subrequest *subreq,
 	if (!error && subreq->transferred < subreq->len) {
 		if (test_bit(NETFS_SREQ_HIT_EOF, &subreq->flags)) {
 			trace_netfs_sreq(subreq, netfs_sreq_trace_hit_eof);
+			rtt = 0;
 		} else {
 			trace_netfs_sreq(subreq, netfs_sreq_trace_short);
 			if (subreq->transferred > subreq->consumed) {
+				rtt++;
+				if (rtt < 50) {
 				__set_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags);
 				__clear_bit(NETFS_SREQ_NO_PROGRESS, &subreq->flags);
 				set_bit(NETFS_RREQ_NEED_RETRY, &rreq->flags);
+				}
+				printk("subreq: %p, 1async: %d, r: %p, transed: %lu, sub req length: %lu, retry times: %d, subreq consume: %d, subreq list empty: %d, %s\n",
+					subreq, was_async, rreq, subreq->transferred, subreq->len, rtt, subreq->consumed, list_empty(&rreq->subrequests), __func__);
 			} else if (!__test_and_set_bit(NETFS_SREQ_NO_PROGRESS, &subreq->flags)) {
 				__set_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags);
 				set_bit(NETFS_RREQ_NEED_RETRY, &rreq->flags);
diff --git a/fs/9p/vfs_addr.c b/fs/9p/vfs_addr.c
index 819c75233235..b7d22f04593c 100644
--- a/fs/9p/vfs_addr.c
+++ b/fs/9p/vfs_addr.c
@@ -83,6 +83,7 @@ static void v9fs_issue_read(struct netfs_io_subrequest *subreq)
 	if (!err)
 		subreq->transferred += total;
 
+	printk("subreq: %p, err: %d, total: %d, transfed: %d, %s\n", subreq, err, total, subreq->transferred, __func__);
 	netfs_read_subreq_terminated(subreq, err, false);
 }
 
diff --git a/net/9p/trans_virtio.c b/net/9p/trans_virtio.c
index 0b8086f58ad5..d80af1aa74e4 100644
--- a/net/9p/trans_virtio.c
+++ b/net/9p/trans_virtio.c
@@ -714,7 +714,7 @@ p9_virtio_create(struct p9_client *client, const char *devname, char *args)
 	mutex_unlock(&virtio_9p_lock);
 
 	if (!found) {
-		pr_err("no channels available for device %s\n", devname);
+		pr_err_ratelimited("no channels available for device %s\n", devname);
 		return ret;
 	}
 


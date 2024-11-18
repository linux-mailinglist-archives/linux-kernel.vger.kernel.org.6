Return-Path: <linux-kernel+bounces-412329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE7C9D07A9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 02:52:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DBC6B2180D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 01:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DF842F855;
	Mon, 18 Nov 2024 01:52:03 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32DC717991
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 01:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731894722; cv=none; b=a+XJ0AkBDBOaaCLrp3Gzu6IHJdxzPDf5i4A4Kpokd1RfrOxCE65J5UYc/AvGqszTC9cqNImz62A7hbO1tb1Iim9rkO7EYbSSIB2GjMEIIbueMeWhhxqpdaqBJe/m4EfY4XL0hoxj2Gdu/42OxkZjdTFvXqjGJXVWxADqXmIop3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731894722; c=relaxed/simple;
	bh=H061cTXQ8x2+zzrNTU0mwprc+HU3BKoAVEgeJu/an64=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=d7jLzHuc7JdeArtcQUz/SGZfS8AEVqda6uIYdXP8kPkUdQDcA5sm6mp2JvkpfzvKK8tsLjs4nwB3jjfO4lfdq9gdheZOq3o4U8I/FrKYZYTJIc8ha6ZGX9CWkGAYIywPul05BGsS/Zf+0aA2aSbevfx9g2u2M/pIm535scKqSkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a71d04b10eso17373975ab.2
        for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 17:52:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731894720; x=1732499520;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ztnol1DRPjKnFZYFY1ml4Usa2RJsVuF4qAT/1xaybSQ=;
        b=pt8LWH++3CsdsU0LySCqLgGnrCqvbJaydUIm+zRov8jya5ISH8I1pXhuvdyVFPUCQI
         jEgWbt/VJju+yT+SlF8PmFe4gpLrzOQ7jXypxNcf0Jpx6cF/5OfzAIaIPkmGWIY4ZGXE
         yGagJQ7euPibbEdAvjoXMcfqmEqkNhCsgYmQ2tNr29TAkLo8kCQeo2MmHiEfQzKzppx+
         f8NvQtLo8LHr1oswaVZqSm6E4E/vemnohxS8WfWtUOIvfWtiUG77lhw7tRdMdEGJSMoK
         9EAdPRLfK+dqGzgmzy3UHVGXqrJbqLVn2jJMdRO4kjRn39vit4RvW8YbHbxDhPbmICNj
         S3yg==
X-Gm-Message-State: AOJu0Yy6Lk9jmS69/0Bk+KYtW4B8bkIb+FUBQTEQ6KXqr7M9r3B8+kfm
	NDDOWY/e0YMwGz3D6KwUQvcnsQP2kEJMZDxIP0uGSctTGtIRKGVkI4wyJ+u1ry7JmEx9Qrrj2Dv
	sBAE4OPH+fJSdWPQwBOwPLEF7e5LhRtXGD1dElAPrAESrBNOdKvHp9nE=
X-Google-Smtp-Source: AGHT+IEGdSkkvZVIG9642B70hl60dmHHmtaCAR8zUB2237uiCGgHpzgN314dekek6OGMkzsdZ2h8O5Ws261hwB/E5IXOGBpoUxtE
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3c08:b0:3a0:a71b:75e5 with SMTP id
 e9e14a558f8ab-3a748027c23mr93938155ab.7.1731894720387; Sun, 17 Nov 2024
 17:52:00 -0800 (PST)
Date: Sun, 17 Nov 2024 17:52:00 -0800
In-Reply-To: <6731d39c.050a0220.1fb99c.014e.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <673a9dc0.050a0220.87769.001a.GAE@google.com>
Subject: Re: [syzbot] Re: [syzbot] [mm?] BUG: stack guard page was hit in v9fs_file_read_iter
From: syzbot <syzbot+885c03ad650731743489@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [syzbot] [mm?] BUG: stack guard page was hit in v9fs_file_read_iter
Author: lizhi.xu@windriver.com

if we didn't read new data then abandon retry

#syz test

diff --git a/fs/netfs/buffered_read.c b/fs/netfs/buffered_read.c
index c40e226053cc..a233412ba08f 100644
--- a/fs/netfs/buffered_read.c
+++ b/fs/netfs/buffered_read.c
@@ -233,6 +233,7 @@ static void netfs_read_to_pagecache(struct netfs_io_request *rreq)
 
 		subreq->start	= start;
 		subreq->len	= size;
+		subreq->rretry_times = 0;
 
 		atomic_inc(&rreq->nr_outstanding);
 		spin_lock_bh(&rreq->lock);
diff --git a/fs/netfs/direct_read.c b/fs/netfs/direct_read.c
index b1a66a6e6bc2..beb81e06d13b 100644
--- a/fs/netfs/direct_read.c
+++ b/fs/netfs/direct_read.c
@@ -66,6 +66,7 @@ static int netfs_dispatch_unbuffered_reads(struct netfs_io_request *rreq)
 		subreq->source	= NETFS_DOWNLOAD_FROM_SERVER;
 		subreq->start	= start;
 		subreq->len	= size;
+		subreq->rretry_times = 0;
 
 		atomic_inc(&rreq->nr_outstanding);
 		spin_lock_bh(&rreq->lock);
diff --git a/fs/netfs/read_collect.c b/fs/netfs/read_collect.c
index b18c65ba5580..b2c8d5df73f9 100644
--- a/fs/netfs/read_collect.c
+++ b/fs/netfs/read_collect.c
@@ -509,9 +509,15 @@ void netfs_read_subreq_terminated(struct netfs_io_subrequest *subreq,
 		} else {
 			trace_netfs_sreq(subreq, netfs_sreq_trace_short);
 			if (subreq->transferred > subreq->consumed) {
-				__set_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags);
-				__clear_bit(NETFS_SREQ_NO_PROGRESS, &subreq->flags);
-				set_bit(NETFS_RREQ_NEED_RETRY, &rreq->flags);
+				/* if we didn't read new data, abandon retry*/
+				if (subreq->rretry_times && subreq->fresh_len) {
+					__set_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags);
+					__clear_bit(NETFS_SREQ_NO_PROGRESS, &subreq->flags);
+					set_bit(NETFS_RREQ_NEED_RETRY, &rreq->flags);
+				}
+				printk("subreq: %p, 1async: %d, rreq: %p, rreq transferred: %lu, sub req transed: %lu, "
+					"sub req length: %lu, retry times: %d, subreq consume: %d, subreq list empty: %d, %s\n",
+					subreq, was_async, rreq, rreq->transferred, subreq->transferred, subreq->len, subreq->rretry_times, subreq->consumed, list_empty(&rreq->subrequests), __func__);
 			} else if (!__test_and_set_bit(NETFS_SREQ_NO_PROGRESS, &subreq->flags)) {
 				__set_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags);
 				set_bit(NETFS_RREQ_NEED_RETRY, &rreq->flags);
diff --git a/fs/netfs/read_retry.c b/fs/netfs/read_retry.c
index 0350592ea804..d549b54de6ec 100644
--- a/fs/netfs/read_retry.c
+++ b/fs/netfs/read_retry.c
@@ -23,6 +23,8 @@ static void netfs_reissue_read(struct netfs_io_request *rreq,
 	atomic_inc(&rreq->nr_outstanding);
 	__set_bit(NETFS_SREQ_IN_PROGRESS, &subreq->flags);
 	netfs_get_subrequest(subreq, netfs_sreq_trace_get_resubmit);
+	printk("rq: %p, subrq: %p, len: %lu, consumed: %d, transfed: %lu, %s\n",
+		rreq, subreq, subreq->len, subreq->consumed, subreq->transferred, __func__);
 	subreq->rreq->netfs_ops->issue_read(subreq);
 }
 
@@ -52,10 +54,12 @@ static void netfs_retry_read_subrequests(struct netfs_io_request *rreq)
 	    !test_bit(NETFS_RREQ_COPY_TO_CACHE, &rreq->flags)) {
 		struct netfs_io_subrequest *subreq;
 
+		printk("rrq: %p, %s\n", rreq, __func__);
 		list_for_each_entry(subreq, &rreq->subrequests, rreq_link) {
 			if (test_bit(NETFS_SREQ_FAILED, &subreq->flags))
 				break;
 			if (__test_and_clear_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags)) {
+				subreq->rretry_times++;
 				netfs_reset_iter(subreq);
 				netfs_reissue_read(rreq, subreq);
 			}
@@ -183,6 +187,7 @@ static void netfs_retry_read_subrequests(struct netfs_io_request *rreq)
 					goto abandon;
 				subreq->source = NETFS_DOWNLOAD_FROM_SERVER;
 				subreq->start = start;
+				subreq->rretry_times = 0;
 
 				/* We get two refs, but need just one. */
 				netfs_put_subrequest(subreq, false, netfs_sreq_trace_new);
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index 5eaceef41e6c..c0b1f058f09a 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -191,6 +191,8 @@ struct netfs_io_subrequest {
 	unsigned char		curr_folio_order; /* Order of folio */
 	struct folio_queue	*curr_folioq;	/* Queue segment in which current folio resides */
 	unsigned long		flags;
+	size_t			fresh_len;	/* The length of the data just read */
+	u8			rretry_times;   /* The times of retry read */
 #define NETFS_SREQ_COPY_TO_CACHE	0	/* Set if should copy the data to the cache */
 #define NETFS_SREQ_CLEAR_TAIL		1	/* Set if the rest of the read should be cleared */
 #define NETFS_SREQ_SEEK_DATA_READ	3	/* Set if ->read() should SEEK_DATA first */
diff --git a/fs/9p/vfs_addr.c b/fs/9p/vfs_addr.c
index 819c75233235..6e33a3dfec40 100644
--- a/fs/9p/vfs_addr.c
+++ b/fs/9p/vfs_addr.c
@@ -80,8 +80,13 @@ static void v9fs_issue_read(struct netfs_io_subrequest *subreq)
 	if (pos + total >= i_size_read(rreq->inode))
 		__set_bit(NETFS_SREQ_HIT_EOF, &subreq->flags);
 
-	if (!err)
+	if (!err) {
 		subreq->transferred += total;
+		subreq->fresh_len = total;
+	} else 
+		subreq->fresh_len = 0;
+
+	printk("subreq: %p, sub rq len: %lu, err: %d, total: %d, transfed: %d, %s\n", subreq, subreq->len, err, total, subreq->transferred, __func__);
 
 	netfs_read_subreq_terminated(subreq, err, false);
 }


Return-Path: <linux-kernel+bounces-400920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E9659C13F8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 03:19:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCEE0B23150
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 02:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FA4B8F58;
	Fri,  8 Nov 2024 02:18:56 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885361BD9D1
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 02:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731032336; cv=none; b=RRLKugRob8cTCoaJM13EH7Abvrwbug/CpYoW2L4nLYIvl1f/rJAaj+xhQwC3ksw7kkjR3z6QdjW1r/GbzBmz11MUIIFcj/ZkD8BQgBjb2Cr7C3PlegwHqWImjSwxkf34eG35eWR4bsFkDOgxx+tnAVStZplWpw2Lmlzy+XqO+h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731032336; c=relaxed/simple;
	bh=H061cTXQ8x2+zzrNTU0mwprc+HU3BKoAVEgeJu/an64=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=UhB2CPr0BIme3rGamPOBTgTGqg6/D8Wmsx6KEtnIXHh4KumS0Si+a5lqDbJaPqnthwFveZ+GKSRGUf/BZRSpQxS0cx/UOMAk8v2rLgjIk9ePQfh2DNGSLfRfTifTwpDXFJduZAhil08c8oSb3ETjtvwwRDT/ysusX+hgy9MAdp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a6bce8a678so18013045ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 18:18:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731032333; x=1731637133;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ztnol1DRPjKnFZYFY1ml4Usa2RJsVuF4qAT/1xaybSQ=;
        b=IUbvjQTer6HQs/f7A27JbpFwAM+htc4SXPUQEDAuNH5za1YeBsPIK0CLle1Kx65d+X
         391AN3FmnHQZZpyPABso+T3sArX+E6aCA+SalSPF9g3rWQ5twpjTW+kPXm5Mc+VBdgR2
         pC4KoWZOl+WoXw48gHQC80flPPBaceKNBmPxE+GlnzBaXELUCq3L0JXmSll2t0F9gBqi
         uAAumX7zIvun1RttImb4D851HvN1ZMp0jcAaXRaatMAEN/T37KRrqVlWoPPpu5RmqR5k
         /tqew6QB/KNtuYsMxYviTOmtm08DLAxHtpPXcxvXO+x76wKXflTB/M+uEzY3cveI1kO4
         A39w==
X-Gm-Message-State: AOJu0YwwYGB+QIzMHdFkNtg7hnuIuvA+Hov2sbyqYTqIU9Qq+IQn2krw
	OSPnZLuISj8EnK7Fvc+rvpNEeNBMzXZDDw8WxcXGt3FkKLMWWSPDkEZ36xQv5dVEA3dCKBpeOEf
	YKr+ekCMaym0vzSOcq+xWnhkKmh2sga+UFzF/eXs272vRKrXitZzqwm4=
X-Google-Smtp-Source: AGHT+IH8LdcLE151XJvz0Z0ocnciLSp22+YeY4aOquwfRC4vKYYMy9K6++IMEmdVO4g5NDiWUvdKTDPGfjk6YaXxmJJsuJ+qAqby
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2193:b0:3a4:e2f1:936b with SMTP id
 e9e14a558f8ab-3a6f199edcdmr18863605ab.5.1731032333560; Thu, 07 Nov 2024
 18:18:53 -0800 (PST)
Date: Thu, 07 Nov 2024 18:18:53 -0800
In-Reply-To: <672b7858.050a0220.350062.0256.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <672d750d.050a0220.15a23d.01a9.GAE@google.com>
Subject: Re: [syzbot] Re: [syzbot] [mm?] BUG: stack guard page was hit in v9fs_file_read_iter
From: syzbot <syzbot+1fc6f64c40a9d143cfb6@syzkaller.appspotmail.com>
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


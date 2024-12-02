Return-Path: <linux-kernel+bounces-427103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC4F69DFCB0
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 10:02:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B10A9281DE9
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 09:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C37591FA152;
	Mon,  2 Dec 2024 09:01:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74561F8AEE
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 09:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733130065; cv=none; b=ouC8HzPOAdC8T6dPGW73zwMMveiSoJezcsBBeJHv/sdaDFD3MOJc/blCSNMkALfJZ+16owhmdU/5NuPjUSd7I27Mrfece5u4l00ShekaTfZKGe9GEg0DVNg/4/7LI64WHFuro5JRoWYDmMHo7JA1sX5QDajbZViwRUjSjJrUHc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733130065; c=relaxed/simple;
	bh=JTvtG9sx2Y0GKxJGf0sSE/cq1zn64sz//XTBIF3P5J4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=h6lEOSjz5ieAvjMiyJUah++N38O69klJ95iZTLfpNce24YClzTHUoQmWYgdHdERBs5+HMHYCSGy1UDrFKY1j+pRNJz4oo2sC6bi41GdYg755CPuS5DSDxa+Tr71k5D4L0bvGCb6KvpIaM6rJLFEyT6Kim4t+qUqbkZIVnq2M5qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a7bdd00353so44097315ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 01:01:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733130063; x=1733734863;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DNXVAwiE/8yGMiilegsGJAPl32w9GzOq4koQMweD/ic=;
        b=O7ZRTm3t7AiQuSjw7IJd7xPJQO9NVKDe09O7Q+lCt3I+iT1relG3HV3fknKRDDMtpQ
         FkXsivCtUb3sV3AoxeXrLY+csmg6tLttl+6X6alKSlMS0QLcAmGV4H0+7cauiOQRykNj
         Zf/aigdOoP4eqxunzM0rnWWj5AV3i6Qg7UJGU2tke8opj9EQFMWCCf/7CTO6NI+3L0xL
         KIiGX9a4/spHyNBdiaFVokHYiNac8/fyK6EN9cJ0h/MUXCZUQfVB34pSMKwZSCYTq0z7
         DU6NuyKjLFqJZ7P/h5Nt0zZfkTAOcR6vrfYBSG4I2+fpHBo1fnGGxCXUpq4yBMeL1AsU
         0X8g==
X-Gm-Message-State: AOJu0YxCxsGn8erzQXcG6G4mnBVIucTvK/xsqlUfPYmt/enpDZ/BcHyQ
	J6Pj5FHW7i608Zb8v7nbbUhNHqVX2TrVmtPAkA/7EECo/qlQemETvCaazCdDujbV9164pUjm1T9
	jGRYGQZW50YpMe9ujBgkRANpUB78VNYFrZ1VzIOpK8YzbjKTv3tKl14M=
X-Google-Smtp-Source: AGHT+IGV4DBHCKg1xaNl4XqL7oZ6hLUqrELB8jAevlyV0wkN2wibakOP8TNJADJMIOPlFMLhKur8hDbXcygUUg4ZPh2+DGGZvC3D
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1cad:b0:3a7:a69c:9692 with SMTP id
 e9e14a558f8ab-3a7c55e2b67mr191756815ab.21.1733130062997; Mon, 02 Dec 2024
 01:01:02 -0800 (PST)
Date: Mon, 02 Dec 2024 01:01:02 -0800
In-Reply-To: <67238110.050a0220.35b515.015e.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <674d774e.050a0220.48a03.0022.GAE@google.com>
Subject: Re: [syzbot] Re: kernel BUG in iov_iter_revert()
From: syzbot <syzbot+404b4b745080b6210c6c@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: kernel BUG in iov_iter_revert()
Author: dmantipov@yandex.ru

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git e70140ba0d2b1a30467d4af6bcfe761327b9ec95

diff --git a/fs/netfs/buffered_read.c b/fs/netfs/buffered_read.c
index 7ac34550c403..4404f3c6ec3e 100644
--- a/fs/netfs/buffered_read.c
+++ b/fs/netfs/buffered_read.c
@@ -95,7 +95,7 @@ static size_t netfs_load_buffer_from_ra(struct netfs_io_request *rreq,
 }
 
 /*
- * netfs_prepare_read_iterator - Prepare the subreq iterator for I/O
+ * __netfs_prepare_read_iterator - Prepare the subreq iterator for I/O
  * @subreq: The subrequest to be set up
  *
  * Prepare the I/O iterator representing the read buffer on a subrequest for
@@ -109,7 +109,7 @@ static size_t netfs_load_buffer_from_ra(struct netfs_io_request *rreq,
  * [!] NOTE: This must be run in the same thread as ->issue_read() was called
  * in as we access the readahead_control struct.
  */
-static ssize_t netfs_prepare_read_iterator(struct netfs_io_subrequest *subreq)
+static ssize_t __netfs_prepare_read_iterator(struct netfs_io_subrequest *subreq)
 {
 	struct netfs_io_request *rreq = subreq->rreq;
 	size_t rsize = subreq->len;
@@ -174,6 +174,21 @@ static ssize_t netfs_prepare_read_iterator(struct netfs_io_subrequest *subreq)
 	return subreq->len;
 }
 
+/* Wrap the above by handling possible -ENOMEM and
+ * marking the corresponding subrequest as cancelled.
+ */
+static inline ssize_t netfs_prepare_read_iterator(struct netfs_io_subrequest *subreq)
+{
+	struct netfs_io_request *rreq = subreq->rreq;
+	ssize_t slice = __netfs_prepare_read_iterator(subreq);
+
+	if (unlikely(slice < 0)) {
+		atomic_dec(&rreq->nr_outstanding);
+		netfs_put_subrequest(subreq, false, netfs_sreq_trace_put_cancel);
+	}
+	return slice;
+}
+
 static enum netfs_io_source netfs_cache_prepare_read(struct netfs_io_request *rreq,
 						     struct netfs_io_subrequest *subreq,
 						     loff_t i_size)
@@ -285,9 +300,7 @@ static void netfs_read_to_pagecache(struct netfs_io_request *rreq)
 			}
 
 			slice = netfs_prepare_read_iterator(subreq);
-			if (slice < 0) {
-				atomic_dec(&rreq->nr_outstanding);
-				netfs_put_subrequest(subreq, false, netfs_sreq_trace_put_cancel);
+			if (unlikely(slice < 0)) {
 				ret = slice;
 				break;
 			}
@@ -302,6 +315,10 @@ static void netfs_read_to_pagecache(struct netfs_io_request *rreq)
 			trace_netfs_sreq(subreq, netfs_sreq_trace_submit);
 			netfs_stat(&netfs_n_rh_zero);
 			slice = netfs_prepare_read_iterator(subreq);
+			if (unlikely(slice < 0)) {
+				ret = slice;
+				break;
+			}
 			__set_bit(NETFS_SREQ_CLEAR_TAIL, &subreq->flags);
 			netfs_read_subreq_terminated(subreq, 0, false);
 			goto done;
@@ -310,6 +327,10 @@ static void netfs_read_to_pagecache(struct netfs_io_request *rreq)
 		if (source == NETFS_READ_FROM_CACHE) {
 			trace_netfs_sreq(subreq, netfs_sreq_trace_submit);
 			slice = netfs_prepare_read_iterator(subreq);
+			if (unlikely(slice < 0)) {
+				ret = slice;
+				break;
+			}
 			netfs_read_cache_to_pagecache(rreq, subreq);
 			goto done;
 		}
-- 
2.47.1



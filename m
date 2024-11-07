Return-Path: <linux-kernel+bounces-399355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B096A9BFDE6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 06:58:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E16AB1C21883
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 05:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53EAA192B73;
	Thu,  7 Nov 2024 05:58:24 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740F41373
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 05:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730959103; cv=none; b=ob+qK+Bqvxv1Lk7mkSCHeDBUqhznQSJVrthuNM6Py9ZDgV8K7RhW/jkReuomSBPi7hRiBERQX1I1mXrIPCe0m6ZRI+wu0mA9SzViE/pZwrG1v2wUrqfDZ8k8T3SjQHaJ4CP6ztsrtVGVM6Kdk8gQqHDuJW0h99SOSU34/gX1J3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730959103; c=relaxed/simple;
	bh=TtvNLsztBPy0zs8g+oV4hlOi8ytKwSEr88E7hTRbZQA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=WPSDC59SmwexYtSACjb3gkk6+GWBDOkSe2OimrnbVgKuD01AKPYYJuuV1yA7RbWPl+yZRP93Q3PG1DxIRcx/NnhQDEm/Q33sPj0LYOSevi1w7sp0ZuYjjpqPTl7UdI3viKI2tZntobmZ+A79H0BXunuciskl4vsQx3gUzDutn18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-83aed4f24a9so74259939f.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 21:58:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730959101; x=1731563901;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RyzH1+D1riYKLpQmd6S/+/x309u82v8WwRqkCXFXsVg=;
        b=YoiUHNNsYbONzK9zce8gizwVciS9CdKqNTByJVOvMIaS271kZwd87xtVa5lxBXmLnf
         aRynWpohjFHgsBhXy77rD6tr8bsx4JwszSmojoCMTMUuvvQPtGjfFAjtrfsj6itRNcYI
         57/AcwiTKKD6Es3acLknds28DIdvESgmMOoO5TXMVLeKKS5dSvQ4g4Q3a/68j41v6vh/
         Q6Slkwgb+x+nrXYYFU1Ep5YuyM1qIB5PjPMyYkQQsa3sv7A4mIQ51g1GRjyNLfVNF4dX
         ovuy5RV2NFHfXQeB4R3OfFystvj7yux6a63GX8t2D4ddeIY/VNtZPD5nsUbwR3a1LDQT
         tr0A==
X-Gm-Message-State: AOJu0Ywzyg9i/cJ3B+tJk0ucTtb4cqML6/Y5lq3C3WFbVVtdRDF3hkXs
	pE7hqUOiRffUz4tBXfzGipAAb8rj0OY2OVrisqlp/OzgiBFSjH4f5THF54cg7fakkaB34k2eLw9
	vyggFdIgjfoelJaB+P6X/PDRB57dHEoRmW/M8sDCaGiJBBCadk0q+8B0=
X-Google-Smtp-Source: AGHT+IEBd99IaXnejO31Y/Znxnnh5RBoGMe+haqctkOEMDqV8GY5Umyg2Rf4J8fyfeecP8qLU4OFFXTVVoZQx4YWpP2kA2bQG5Ep
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1707:b0:39f:5e18:239d with SMTP id
 e9e14a558f8ab-3a6b02fbee5mr225546495ab.15.1730959101663; Wed, 06 Nov 2024
 21:58:21 -0800 (PST)
Date: Wed, 06 Nov 2024 21:58:21 -0800
In-Reply-To: <672b7858.050a0220.350062.0256.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <672c56fd.050a0220.350062.028a.GAE@google.com>
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

diff --git a/fs/netfs/buffered_read.c b/fs/netfs/buffered_read.c
index c40e226053cc..b09a22442de6 100644
--- a/fs/netfs/buffered_read.c
+++ b/fs/netfs/buffered_read.c
@@ -182,6 +182,7 @@ static void netfs_cache_read_terminated(void *priv, ssize_t transferred_or_error
 {
 	struct netfs_io_subrequest *subreq = priv;
 
+	printk("subreq: %p, transfed: %ld, %s\n", priv, transferred_or_error, __func__);
 	if (transferred_or_error < 0) {
 		netfs_read_subreq_terminated(subreq, transferred_or_error, was_async);
 		return;
@@ -295,6 +296,7 @@ static void netfs_read_to_pagecache(struct netfs_io_request *rreq)
 			netfs_stat(&netfs_n_rh_zero);
 			slice = netfs_prepare_read_iterator(subreq);
 			__set_bit(NETFS_SREQ_CLEAR_TAIL, &subreq->flags);
+			printk("1subreq: %p, transfed: %ld, %s\n", subreq, __func__);
 			netfs_read_subreq_terminated(subreq, 0, false);
 			goto done;
 		}
@@ -302,6 +304,7 @@ static void netfs_read_to_pagecache(struct netfs_io_request *rreq)
 		if (source == NETFS_READ_FROM_CACHE) {
 			trace_netfs_sreq(subreq, netfs_sreq_trace_submit);
 			slice = netfs_prepare_read_iterator(subreq);
+			printk("subreq: %p, transfed: %ld, %s\n", subreq, __func__);
 			netfs_read_cache_to_pagecache(rreq, subreq);
 			goto done;
 		}
diff --git a/fs/netfs/read_collect.c b/fs/netfs/read_collect.c
index b18c65ba5580..f75429a4e743 100644
--- a/fs/netfs/read_collect.c
+++ b/fs/netfs/read_collect.c
@@ -465,6 +465,7 @@ void netfs_read_subreq_terminated(struct netfs_io_subrequest *subreq,
 				  int error, bool was_async)
 {
 	struct netfs_io_request *rreq = subreq->rreq;
+	static int rtt = 0;
 
 	switch (subreq->source) {
 	case NETFS_READ_FROM_CACHE:
@@ -506,15 +507,24 @@ void netfs_read_subreq_terminated(struct netfs_io_subrequest *subreq,
 	if (!error && subreq->transferred < subreq->len) {
 		if (test_bit(NETFS_SREQ_HIT_EOF, &subreq->flags)) {
 			trace_netfs_sreq(subreq, netfs_sreq_trace_hit_eof);
+			rtt = 0;
 		} else {
 			trace_netfs_sreq(subreq, netfs_sreq_trace_short);
 			if (subreq->transferred > subreq->consumed) {
+				rtt++;
+				if (rtt < 16) {
 				__set_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags);
 				__clear_bit(NETFS_SREQ_NO_PROGRESS, &subreq->flags);
 				set_bit(NETFS_RREQ_NEED_RETRY, &rreq->flags);
+				}
+				printk("1async: %d, r: %p, transed: %lu, sub req length: %lu, retry times: %d, %s\n", was_async, rreq, subreq->transferred, subreq->len, rtt, __func__);
 			} else if (!__test_and_set_bit(NETFS_SREQ_NO_PROGRESS, &subreq->flags)) {
+				rtt++;
+				if (rtt < 16) {
 				__set_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags);
 				set_bit(NETFS_RREQ_NEED_RETRY, &rreq->flags);
+				}
+				printk("async: %d, r: %p, transed: %lu, sub req length: %lu, retry times: %d, %s\n", was_async, rreq, subreq->transferred, subreq->len, rtt, __func__);
 			} else {
 				__set_bit(NETFS_SREQ_FAILED, &subreq->flags);
 				error = -ENODATA;
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
 


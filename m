Return-Path: <linux-kernel+bounces-392381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C68879B9367
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 15:37:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50E65B23A64
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 14:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B58551A727D;
	Fri,  1 Nov 2024 14:37:07 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A1049620
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 14:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730471827; cv=none; b=K2RZH8Yxds1ZOnmOkekOTSV0VWmzEqWJeLgJXw/zwHdlGh2SXe5FAc3DEBqsiMxWXPoQGyix4AdOfixbaw2ytyK2buvvpcOFcwAdw4/oCrbH8ze2LVPvovhDFFQXE7CwbSQTa/4+DSqVJLQ7MpUkhqbvM3PcFYe78NockkZKLuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730471827; c=relaxed/simple;
	bh=0E7//IECaKCgwv6pUWLla1sktUFZ8+LW2bupMTkRqMY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=KPkm2ok9fFoxUUC9waO3fKHjT0bUHw4yip7RPLwsov8QWDVaItPNl51hAY/eTsGsWjWOz29mbKWJBOii8oYiV+NVGiXSc9G1i++Ovwmk8eFH2G4/2g0d0OqSqHuzwZlW1PWN+uW/OjwrCH3KUqDHXoj3volz0Y7LSx0iS7fqbzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a4e41e2732so19823715ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 07:37:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730471824; x=1731076624;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u2q2gmEQT1K3GtIeoqKNEJpCermTaSq8JynaVGz2q4s=;
        b=CAdUVAIasSJ6DdWzngSIMBftdOPweg9bgk/hIoV7Ccd1p8x1Xs/CzXWdMtSswATqfO
         xeYonoE33WNJzDN78AmceTgGaQ3HZ19RGBsJorsqbIJ8rgHQC57QyKyg2rV2VzykX0m6
         qsDIUfXmJXk5NyBuh6zIWDy0kYV5J11DSfaa/h5IHafumdfSNP092afBBXKD+OiXZSsL
         CxUCfY2LdAkPk/0sfwwoJ2chbOq8zWSdCHg3YqL+Kvsp8Qoc7e6K3tvsMEESvVRxDg9E
         ftgXcpBjV/95K2mS1GLNhFzdQMqvlk8Ee2Q+tisC++Op9jRVgwrF+0w1tCree/0fnk48
         mtjQ==
X-Gm-Message-State: AOJu0YyFPjTmUVgjBRHltY8QTg7BPttyMlnFlcK0f+1jXiqAR4JOsGE0
	E/46iU3Smj1I5EZV/Fg0fHMBPIZGRw7YB/qfw+oCbcfFORaWrcJ3Is/jqEPkdmRuA8VvvTFQnBY
	jA+lzTo/ZC7Y1+I98015UqW3yODiRp5SW2xItwtivn3PSQM//AIDfBmk=
X-Google-Smtp-Source: AGHT+IHCXdptxwW/1xkgM0SUvk75yg20yLs8rWAOL/SIKdnKaZMpeYZp69hEQPdQPK5ag9+3hc5XRYlm8zsGFglDkizGx2UM8fYb
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12e1:b0:3a6:ac17:13e9 with SMTP id
 e9e14a558f8ab-3a6ac1717d3mr59963995ab.11.1730471824344; Fri, 01 Nov 2024
 07:37:04 -0700 (PDT)
Date: Fri, 01 Nov 2024 07:37:04 -0700
In-Reply-To: <67238110.050a0220.35b515.015e.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6724e790.050a0220.35b515.0172.GAE@google.com>
Subject: Re: [syzbot] Re: kernel BUG in iov_iter_revert (2)
From: syzbot <syzbot+404b4b745080b6210c6c@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: kernel BUG in iov_iter_revert (2)
Author: dmantipov@yandex.ru

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 6c52d4da1c742cd01a797a4d0a2d3c5a60dc9bfe

diff --git a/fs/netfs/buffered_read.c b/fs/netfs/buffered_read.c
index af46a598f4d7..706862094c49 100644
--- a/fs/netfs/buffered_read.c
+++ b/fs/netfs/buffered_read.c
@@ -174,6 +174,21 @@ static ssize_t netfs_prepare_read_iterator(struct netfs_io_subrequest *subreq)
 	return subreq->len;
 }
 
+/* Wrap the above by handling possible -ENOMEM and
+ * marking the corresponding subrequest as cancelled.
+ */
+static inline ssize_t netfs_wrap_read_iterator(struct netfs_io_subrequest *subreq)
+{
+	struct netfs_io_request *rreq = subreq->rreq;
+	ssize_t slice = netfs_prepare_read_iterator(subreq);
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
@@ -284,10 +299,8 @@ static void netfs_read_to_pagecache(struct netfs_io_request *rreq)
 				trace_netfs_sreq(subreq, netfs_sreq_trace_prepare);
 			}
 
-			slice = netfs_prepare_read_iterator(subreq);
-			if (slice < 0) {
-				atomic_dec(&rreq->nr_outstanding);
-				netfs_put_subrequest(subreq, false, netfs_sreq_trace_put_cancel);
+			slice = netfs_wrap_read_iterator(subreq);
+			if (unlikely(slice < 0)) {
 				ret = slice;
 				break;
 			}
@@ -301,7 +314,11 @@ static void netfs_read_to_pagecache(struct netfs_io_request *rreq)
 			subreq->source = NETFS_FILL_WITH_ZEROES;
 			trace_netfs_sreq(subreq, netfs_sreq_trace_submit);
 			netfs_stat(&netfs_n_rh_zero);
-			slice = netfs_prepare_read_iterator(subreq);
+			slice = netfs_wrap_read_iterator(subreq);
+			if (unlikely(slice < 0)) {
+				ret = slice;
+				break;
+			}
 			__set_bit(NETFS_SREQ_CLEAR_TAIL, &subreq->flags);
 			netfs_read_subreq_terminated(subreq, 0, false);
 			goto done;
@@ -309,7 +326,11 @@ static void netfs_read_to_pagecache(struct netfs_io_request *rreq)
 
 		if (source == NETFS_READ_FROM_CACHE) {
 			trace_netfs_sreq(subreq, netfs_sreq_trace_submit);
-			slice = netfs_prepare_read_iterator(subreq);
+			slice = netfs_wrap_read_iterator(subreq);
+			if (unlikely(slice < 0)) {
+				ret = slice;
+				break;
+			}
 			netfs_read_cache_to_pagecache(rreq, subreq);
 			goto done;
 		}


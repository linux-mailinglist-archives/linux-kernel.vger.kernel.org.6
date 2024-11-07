Return-Path: <linux-kernel+bounces-399307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B72FF9BFD32
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 05:10:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9A631C213A0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 04:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCDC1130A7D;
	Thu,  7 Nov 2024 04:10:26 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0819B383
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 04:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730952626; cv=none; b=BYWis9ar9HzejT0frsepWNHmSwQKPhHH3532ofyk/HjbKLBt/KCWrdxG7yBF116iBB56Z/heLHNgnuoGL8r5ENXP6DwljvRRtKHS+uLbw5j8yIITQUYl+n5TDsteprog+gyLvqKJhMQhu/wPKOTzCdibplsk8+/CdIhvtBc0fEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730952626; c=relaxed/simple;
	bh=Fkw0tJMdFi4Zy3vs0NNagndQtHC4ZbZf6DE8NMm5rOE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=HX4P7pA3KPAtbH7+Gxfh+kG63OZSM77v7Ysb3h67JNbkbPnbG87FK1LBWphdXH+/QcYifXXPxLLo09NO8kIImFi0BLF8cYMxoJZnHBW2gsMm7/w6abyoZOmOJTjidxOKk7sxF5nf465myjRY7U7wgJX3kUPIDlG6kTeq8jDEkvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a3b9c5bcd8so6806375ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 20:10:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730952624; x=1731557424;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+6/LrJjlVkbq0wGRG4AxgEB3nqGzOCqxVbrtipiOyL4=;
        b=TKAau7nVtQT1WmX0gGhuDNZx6yzOoJCcjBhZkqGlNQ0nLY463tY51eoZNdBxeXheQW
         v8eQtWG/xRwcm5OwbMLiZ77UT5+Uw95QK8cnMANqHEgKeEpR2cIp7j1EB4bk3Wl/A492
         2WI1EilqCTcdG6zGvoMGZhnn2IJS/3vinSAz39tBKtd0GjlMpEulWLMD4XdvTF5qntoD
         a8nFI/V2SNW3eFTn4xSOCbldhuxWFaucw6k9Jv7jjqeK0cw6T97VizCbtLxSqbje9yO0
         b9SsAiCtQq2CmddhPm5Hsz8o+VuSAYH/JKL/8AEZZE97CRS2vwMJZohLgTmodINPefVi
         BhCg==
X-Gm-Message-State: AOJu0Yxw6bledX7C0ykAOqr9WeC0EUINORIFByk2zzL4xDKZ4pddjj8s
	CglUSFSqyV04fPQ4r6qAb+bGVtFfD1AGOKSa9wQlCWSvKOCMo3MFzd1PoXeIjMjYnevSRXkbhkO
	YSvihFBi3njp4HKUq6iz3izmqzB7w/9aE0DgbOwEBHFmHiU46wBlBSC8=
X-Google-Smtp-Source: AGHT+IGTyRqRBV0mbMOFB4QfBbv6/SEJMbS7ba7OnljUFP8oRq8Tlpz0wUNnU8Yh8YtBFfQXwlgGXqewSsVo/XxOecAGJh/oZVpY
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1567:b0:3a6:b445:dc9e with SMTP id
 e9e14a558f8ab-3a6b445de24mr230301165ab.4.1730952624099; Wed, 06 Nov 2024
 20:10:24 -0800 (PST)
Date: Wed, 06 Nov 2024 20:10:24 -0800
In-Reply-To: <672b7858.050a0220.350062.0256.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <672c3db0.050a0220.350062.0286.GAE@google.com>
Subject: Re: [syzbot] Re: [syzbot] [mm?] BUG: stack guard page was hit in v9fs_file_read_iter
From: syzbot <syzbot+1fc6f64c40a9d143cfb6@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [syzbot] [mm?] BUG: stack guard page was hit in v9fs_file_read_iter
Author: lizhi.xu@windriver.com

add resched to avoid retry too frequently when rreq need to retry

#syz test

diff --git a/fs/netfs/read_collect.c b/fs/netfs/read_collect.c
index b18c65ba5580..eb4fc1f62000 100644
--- a/fs/netfs/read_collect.c
+++ b/fs/netfs/read_collect.c
@@ -366,6 +366,7 @@ static void netfs_rreq_assess(struct netfs_io_request *rreq)
 	//netfs_rreq_is_still_valid(rreq);
 
 	if (test_and_clear_bit(NETFS_RREQ_NEED_RETRY, &rreq->flags)) {
+		cond_resched();
 		netfs_retry_reads(rreq);
 		return;
 	}
@@ -512,9 +513,15 @@ void netfs_read_subreq_terminated(struct netfs_io_subrequest *subreq,
 				__set_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags);
 				__clear_bit(NETFS_SREQ_NO_PROGRESS, &subreq->flags);
 				set_bit(NETFS_RREQ_NEED_RETRY, &rreq->flags);
+				printk("async: %d, r: %p, %s\n", was_async, rreq, __func__);
+				if (!was_async)
+					cond_resched();
 			} else if (!__test_and_set_bit(NETFS_SREQ_NO_PROGRESS, &subreq->flags)) {
 				__set_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags);
 				set_bit(NETFS_RREQ_NEED_RETRY, &rreq->flags);
+				printk("async: %d, r: %p, %s\n", was_async, rreq, __func__);
+				if (!was_async)
+					cond_resched();
 			} else {
 				__set_bit(NETFS_SREQ_FAILED, &subreq->flags);
 				error = -ENODATA;


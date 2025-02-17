Return-Path: <linux-kernel+bounces-517099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19EE9A37C1E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 08:26:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EECD3188AE89
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 07:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87746190665;
	Mon, 17 Feb 2025 07:26:42 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F5228F3
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 07:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739777202; cv=none; b=hlkhRYCoB6kVHxtO00rjP338Mw8gKX3prl0MC2QjAEf/BV0izvPl3lbTqlVOtrt7dNVh8y7XO5bfmRLkDJNo2kAdpe1hKj6XAzwMVPp2CCLgiSq1cu56IBclSp5qxztEtuGM0sGFWD7AajbpeOJxqFSGDKIZ1n+kau2GSPnYcr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739777202; c=relaxed/simple;
	bh=p6IogSxJMzRt04vV8WEvg3QYM/jPUP2xTVyCkIAYnQc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Pw3o5ioViQ+fVcubX0lWtrcI1Y++Q7zgAsDmcuk36S/t+2HINDjEiNQN12bbfwY8yb3YF2c6AD1+oaL60MQSwxoX65Vmk4dloN+YbtNoBB6raezTMStvop7nSI0iyuyzF1m3kYTW3S1ox+wwAQCQqhO7aZ3kYxSW4sM5bgM4Z1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-851f02bbfd8so292919739f.2
        for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 23:26:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739777199; x=1740381999;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lqM3qi++a/dlK0DdkRmmZqC3xS0T6sYgA9Ehf2NVKdY=;
        b=MPMwBHASuxWO1bZcZakatNCDSiGv4pYI/dkf9IaXubPFgQsQbOPM9UJtXbu30Lo4Mn
         Z4S3Pbk8+ND6/5WEF5K5MutfMqHMb/xmSLMLGwUWEyNceanRcvF+a6WxyDGxEuzth09Y
         Dio31mJ4ntV8vtDD6IA447fpiAb8GFCCYgqE6HAzvuhCdEqPX1wGNt/BFI0vSMJpKENX
         uqSNamzwYv/so9eJlk6x4bnbgaeDhzIlNXfB6kC0P5hwDRl3D264vHncEmj4JC9zKzpv
         +gEKujtBILQ+aX6xKENp8qkhZj7j/L3YQNd3GlnbTbMEccpfi082lWCVwwHUEMm5Fl5L
         2mQw==
X-Gm-Message-State: AOJu0Yz0KdTjQ7CsuPOuDjjdvkG5xevbfdjXhJfD2Ml3zc8u2yhQugh0
	LC3xsciC09Y9kDZ5EVuJ1Dbgd6MFqbHfCDonYuKZfsl+82rF6vvm5YLPOcDXuNPIhQAMcFpEaOq
	3iEm135llNmEUbkdaRwO56SBrRQsoYOZoBfGekrVQCWq9psI0R46FWyU=
X-Google-Smtp-Source: AGHT+IFY2vebmAcATuQk6oRVBW1yHM9hZZRcU0kMeUTmlW6EIwpv9erjyRWDVV3peNKX63jZAdWDL3DBOLDQpa2BbSis1KdG2qIF
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a29:b0:3d0:1633:3138 with SMTP id
 e9e14a558f8ab-3d28076e4e2mr75410505ab.1.1739777199752; Sun, 16 Feb 2025
 23:26:39 -0800 (PST)
Date: Sun, 16 Feb 2025 23:26:39 -0800
In-Reply-To: <67917ed8.050a0220.15cac.02eb.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67b2e4af.050a0220.54b41.000e.GAE@google.com>
Subject: Re: [syzbot] Re: [syzbot] [fs?] BUG: corrupted list in
 remove_wait_queue (2)
From: syzbot <syzbot+4e21d5f67b886a692b55@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [syzbot] [fs?] BUG: corrupted list in remove_wait_queue (2)
Author: lizhi.xu@windriver.com

#syz test

diff --git a/fs/select.c b/fs/select.c
index 7da531b1cf6b..63dd2fb58447 100644
--- a/fs/select.c
+++ b/fs/select.c
@@ -977,6 +977,7 @@ static int do_sys_poll(struct pollfd __user *ufds, unsigned int nfds,
  	struct poll_list *walk = head;
 	unsigned int todo = nfds;
 	unsigned int len;
+	static DEFINE_MUTEX(syspoll_lock);
 
 	if (nfds > rlimit(RLIMIT_NOFILE))
 		return -EINVAL;
@@ -1005,9 +1006,11 @@ static int do_sys_poll(struct pollfd __user *ufds, unsigned int nfds,
 		}
 	}
 
+	mutex_lock(&syspoll_lock);
 	poll_initwait(&table);
 	fdcount = do_poll(head, &table, end_time);
 	poll_freewait(&table);
+	mutex_unlock(&syspoll_lock);
 
 	if (!user_write_access_begin(ufds, nfds * sizeof(*ufds)))
 		goto out_fds;


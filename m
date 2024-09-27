Return-Path: <linux-kernel+bounces-341363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D223D987F0A
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 09:00:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 050691C213AA
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 07:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 651FDEAC6;
	Fri, 27 Sep 2024 07:00:08 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15B917BB3C
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 07:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727420408; cv=none; b=YrDYX2LjPsBOWQWmOM0ngieJF0HK8Qya+oPtoaa281gc1THo4CcgQH084aM4J3xVzjQ8HOGuxhpxtJRX9orZpG6h89JCa8DG1Bt0TDhzIVAYLN8ASe/Ebj1t8wG/qC+H8+xo2Nsc298v1j7zwsTAizBcfl9AWGNO/Arx3CwcGbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727420408; c=relaxed/simple;
	bh=/6c69v8kF+rORs/tyaNB4+Mkzo+RBGkWLPFkvGmJyGU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=WQA1jMSVPvWesxQ0nxvFJVL1yb3bokA++DV1xPs4oTAHEMfxypPGiJAeVvaLyC7R8vFoxqGAN0w5wsTAdTrVRn6yCRh+q/fBtCP2YGDbJVfZQL7A3aP7kiW0oV4rJel98UbdSny2AONS9eb1NCxxj6y+ylUh6vE9iy9JVTwOWNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a344da7987so9564645ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 00:00:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727420405; x=1728025205;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yyWp6mRAoOfYletRLitDhOh/v6rvLyPF70e9fFrbrso=;
        b=EVrFZg2PFBNRPbgdRx4vVNEH7FvLBxOKerBzjd2Y6Mnu0ExukeD4ihzSopEMEdO41M
         qTNi9yPNUpmYIagcSvsA/EAwFL4tDbUudWE0DDxS3AICBkphkguGnGSf04EBGOcZ8onC
         VTtKFA55Hy/6okqtO199RlffvqCXYCfQzNd1EBNXV+EZ+al75HG2ezt5DTGHLvcU9FWY
         CTyznZ7XGyFfDdaJbCFQ2rB/LQFz08ETHXzEi9nn9n1KCZEQPUyLWvFf2jN5/2JMyW8z
         JiRI8Hh9UbWY7qbrwcIzUSoaDr1Qy8lv6EVYsr0kLvgSrw/WF/ZlMf3GIhxIYlUZVw72
         o3xw==
X-Gm-Message-State: AOJu0YxFLfAnmGerVnfryVA5m7NcvB+/Eo8OAqw4rl1c/8POk5UhJcXE
	ABJHyuXukJZy87C44CQqITj/ZllpLCCyq/aNK0rR4HJr/MkFyYhabMfdZJJJTaLAPO0tcyu8GyO
	3EHd2dNzgfhG1K7clPuxQOFMmjIlZYwOz/EuAxO9Qu+fRH5GSC6t0LWk=
X-Google-Smtp-Source: AGHT+IFn1B6T0TwgmCtid+Jlb+Xms+t4DIZG9+0vstITrN2NUI9W9W3bEqE7NyyHIkbcLOhj21X23sQVtv1wuu6VtYFTVsITlwhR
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1705:b0:39f:5efe:ae73 with SMTP id
 e9e14a558f8ab-3a34514af38mr25079335ab.5.1727420405687; Fri, 27 Sep 2024
 00:00:05 -0700 (PDT)
Date: Fri, 27 Sep 2024 00:00:05 -0700
In-Reply-To: <000000000000ae63710620417f67@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f657f5.050a0220.46d20.000f.GAE@google.com>
Subject: Re: [syzbot] Re: [syzbot] [squashfs?] possible deadlock in fsnotify_destroy_mark
From: syzbot <syzbot+c679f13773f295d2da53@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [syzbot] [squashfs?] possible deadlock in fsnotify_destroy_mark
Author: lizhi.xu@windriver.com

Use NOFS to replace

#syz test

diff --git a/fs/notify/inotify/inotify_user.c b/fs/notify/inotify/inotify_user.c
index c7e451d5bd51..3d0dde410b04 100644
--- a/fs/notify/inotify/inotify_user.c
+++ b/fs/notify/inotify/inotify_user.c
@@ -596,7 +596,7 @@ static int inotify_new_watch(struct fsnotify_group *group,
 	struct idr *idr = &group->inotify_data.idr;
 	spinlock_t *idr_lock = &group->inotify_data.idr_lock;
 
-	tmp_i_mark = kmem_cache_alloc(inotify_inode_mark_cachep, GFP_KERNEL);
+	tmp_i_mark = kmem_cache_alloc(inotify_inode_mark_cachep, GFP_NOFS);
 	if (unlikely(!tmp_i_mark))
 		return -ENOMEM;
 


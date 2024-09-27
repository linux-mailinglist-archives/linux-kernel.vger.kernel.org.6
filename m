Return-Path: <linux-kernel+bounces-341460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B2A988081
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 10:38:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 214D42826FC
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 08:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54698189B94;
	Fri, 27 Sep 2024 08:38:43 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9823B189B82
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 08:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727426323; cv=none; b=P3FMyILwaNSFgSvqC9990Z2dhMmP/Oc0W2xyePIR+NJtJDA6ES3MuWvZw0TY4oU/pQ7gv77qgP8vI3HohJLfTey4URrMVxGvUsF3OU7Rp6SL7fh5zb+j1UoB3AZ0b8Yh0d9ZiGjn5PGo5qUN6JV4+5BD576SwYKw1RaLCPPdxQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727426323; c=relaxed/simple;
	bh=vBbo3HB5Qz+3wCGbH67QnJuM4gRbAwSZPSMxhep5Ins=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=TE/slrbJmXmBLPJ3KlPCZuD6xAqUw3gV5988KTEPeBljDkPaVJ9Y+6kacoao1Mg1yeMV5EZIdbR16q5Mtcq1jPMirYYO/WARlyHvqHXDbvghcWdNb/KE4rFPzEeV81UX2i1arq1A/nOKll/ovHVsT3u/TUqEI0jaftndNJ6Oslg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a0ce4692a4so18548875ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 01:38:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727426321; x=1728031121;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QjhYMp+aHI+Y2MwKKNnj3/aFSAJBr/KYr7GS4EUAW9E=;
        b=JcXIEL2/PKCVHDm8xLKu+kD4MyoO/oYhdqhWVo0Ktd4qnN8otjsReEheA6cEfwMhuf
         yPoMGv+v9tO7sNFXTFV+lQ72nZBNzikmyjZ75rhRqYW1fMr1XjREfvh2fGT5hGqa5QS4
         yY17CiBGLwNjfQCfeLJI7dqYnu1plz3EH1mGfGFUwh4nH28KBLMg5vdH1uW7xxJLhDAE
         J+t9MbHgyD4nFPnz7tkvj3CTxHtsAb2nsxFYfkiriTCgilrwflxfVt4tRwQXoQ6Pf07q
         PfUJBSy4L1+q/fihFLMCqi2NJ/Pn2HE2MAZOehym4CPaDKgA0OM3w2DiDK6RcFvjvcAt
         4XNg==
X-Gm-Message-State: AOJu0YziygTNnUSl+ARMQ9sq2weShY3zsu2i+2ieO4v+IvkRB5BATdXF
	fDHp7fnYASpehrmHt+xK/uhZTO1S1SYBQtScFkqKDlwHUwdT/ImMjAKK01g5IlCBl5xHp8SO3SF
	erw5q0qNbpi2BNrkFAEYBeN6KH61YKWJeO01K3R6tUSNtR6iAJ2VjeUU=
X-Google-Smtp-Source: AGHT+IGctPAiBtzwErvDr0msRn4V4xSGxegC/4d7/ZIhNwEfzu5HHHR02fC2oJ6LBTBcmBpUFPRWvMHmGu+xZLpaRRC5EEV9s8eI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d1b:b0:3a2:763b:c83e with SMTP id
 e9e14a558f8ab-3a3446029c2mr21519705ab.5.1727426320798; Fri, 27 Sep 2024
 01:38:40 -0700 (PDT)
Date: Fri, 27 Sep 2024 01:38:40 -0700
In-Reply-To: <000000000000ae63710620417f67@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f66f10.050a0220.38ace9.0011.GAE@google.com>
Subject: Re: [syzbot] Re: [syzbot] [squashfs?] possible deadlock in fsnotify_destroy_mark
From: syzbot <syzbot+c679f13773f295d2da53@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [syzbot] [squashfs?] possible deadlock in fsnotify_destroy_mark
Author: lizhi.xu@windriver.com

Use memalloc_nofs_save/memalloc_nofs_restore to make sure we don't end
up with the fs reclaim dependency.

#syz test

diff --git a/fs/notify/inotify/inotify_user.c b/fs/notify/inotify/inotify_user.c
index c7e451d5bd51..70b77b6186a6 100644
--- a/fs/notify/inotify/inotify_user.c
+++ b/fs/notify/inotify/inotify_user.c
@@ -643,8 +643,13 @@ static int inotify_update_watch(struct fsnotify_group *group, struct inode *inod
 	/* try to update and existing watch with the new arg */
 	ret = inotify_update_existing_watch(group, inode, arg);
 	/* no mark present, try to add a new one */
-	if (ret == -ENOENT)
+	if (ret == -ENOENT) {
+		unsigned int nofs_flag;
+
+		nofs_flag = memalloc_nofs_save();
 		ret = inotify_new_watch(group, inode, arg);
+		memalloc_nofs_restore(nofs_flag);
+	}
 	fsnotify_group_unlock(group);
 
 	return ret;


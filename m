Return-Path: <linux-kernel+bounces-287451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E62CD9527EE
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 04:31:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 892DA1F227DF
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 02:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26F141863E;
	Thu, 15 Aug 2024 02:31:43 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606C718D654
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 02:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723689102; cv=none; b=rRd6OL6thLObitciqj8S2hLHK3jnMoXDiUq7CAW4qE+Jjn6//ftYxMMfhb9tynu1CZxLh2xmvCeqnol+rID/fFvmpfEEbVsxRr9ISm6nS7RLXy9RgMPc4gEI8NjQ3rNYpDGNYTsBDdrbx/UILQrTMrmwc8bHVlIjcGhJqZnStYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723689102; c=relaxed/simple;
	bh=0HvKFh0EECKIOk4ZhHBpgIqOy+A8qlpA7wGymPRdc6A=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=baZOroRoeij7/99zZhzhkkqrQ8rZKjirT45NEGgcSUvLRpJ+ClR0Tp+tKGjQVAPNPsKy8awX/9dOAEk4jUq4nPUJwXNvm1ddNc1WQtOd48d74JVDbrEIJfFWe7rr2Sp1rUMPR9KAZGu6D1n5ganhiss4XV/ebZGvhbWQIm+94+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-39a1f627b3dso6130965ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 19:31:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723689100; x=1724293900;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JszCRXEqLAQrGdNRiu9Ol1k+L2j/C1wQ21T6BCOn1Zc=;
        b=ucXSywG4Nu2LzDIis1EF5caBE7S9UDb9cJEDkFxgtEHHqg/ehjKl56rlIQ7eDOmEV8
         ITpdwZycGgf5QDAgFlCMH5NEOiFt99qd2oow+5SPkdX6aT1OiyZKMAtX5Vf5O51rjKMM
         SD9H9hHY7sw0u0C0GjFioyuqHhR+BJpiuVB8YfPzPEYG1SBT352j85pRa7DXORPsB/CE
         yJAhxfFGV8ykeunt2Qm07kImaZ1UEDBa02xGXqZZfcliw64LSS5QHOqDZqM6gEoisz1N
         mY7UndSUpS0kuDWpu7NUUvEasFaQQ9TaOUUZfk0f1cRakZXnlOEg1X6+P49mCIIhocZk
         pQUw==
X-Gm-Message-State: AOJu0YxltNaK11mM/EdcFdL0O3XuAa+7rjgA4Mj+gJALtf0lYxcCfKmQ
	HCigUyj0Pkt+uk36UjTA0Kca1PY91V5/YAOkQtLyT+OlrVob/fH/ZgKi6PsBxSF1GxK78MeS7b1
	uZno58TMySqwyxTgEpbtYKdrfi46LtVs+RXdGECjdta2K/KMRLdh95nY=
X-Google-Smtp-Source: AGHT+IGg69Y1O8JaCpPh3iDxmjYK+Bjb6F4lE8TY1dccOt+s41XhS8wH1p0BdPH+TZ0U76/0SVKTH0H1L4NGrNFRgsBcqpVkxd8e
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1ca6:b0:375:a55e:f5fc with SMTP id
 e9e14a558f8ab-39d12443709mr3408805ab.1.1723689100532; Wed, 14 Aug 2024
 19:31:40 -0700 (PDT)
Date: Wed, 14 Aug 2024 19:31:40 -0700
In-Reply-To: <0000000000007ec511061f00a7b2@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008a7106061fafa464@google.com>
Subject: Re: [syzbot] Re: [syzbot] [v9fs?] WARNING in v9fs_begin_writeback
From: syzbot <syzbot+0b74d367d6e80661d6df@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [syzbot] [v9fs?] WARNING in v9fs_begin_writeback
Author: lizhi.xu@windriver.com

clean dirty for the release inode, stop to worker wb it again.

#syz test: upstream c0ecd6388360

diff --git a/fs/9p/vfs_dir.c b/fs/9p/vfs_dir.c
index e0d34e4e9076..7f881506a68a 100644
--- a/fs/9p/vfs_dir.c
+++ b/fs/9p/vfs_dir.c
@@ -218,7 +218,9 @@ int v9fs_dir_release(struct inode *inode, struct file *filp)
 		if ((S_ISREG(inode->i_mode)) && (filp->f_mode & FMODE_WRITE))
 			retval = filemap_fdatawrite(inode->i_mapping);
 
+		printk("fid: %p, fidnum: %d, ino: %lx, %s\n", fid, fid->fid, inode->i_ino, __func__);
 		spin_lock(&inode->i_lock);
+		inode->i_state &= ~I_DIRTY;
 		hlist_del(&fid->ilist);
 		spin_unlock(&inode->i_lock);
 		put_err = p9_fid_put(fid);


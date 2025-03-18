Return-Path: <linux-kernel+bounces-565802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB86A66F5D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 10:11:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9414919A3AE9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 09:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 848AC205AD6;
	Tue, 18 Mar 2025 09:10:47 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9687B19C546
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 09:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742289047; cv=none; b=dbcEnQKz4GTwRSGMKJDM0RGB4Kyoj3UblMeF4Hw4Y8arOoN8bPMMzhNLQaV8UFEz+7mcHwqIOPxSz5Fxw2/r4HVOnk+6wDThEeUcrd5zuPJ4qDQcpxBvVEXPcm98ZRJbzSsgPn8Vo7H81ol7mSmiz5RZff5o9NyngdHHSmHtgKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742289047; c=relaxed/simple;
	bh=I4eTLgLoZR4oPCMiIn0ncNg0UoMDYkpccxlVfvLMT6M=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ddO0TyeXZdtmgul1m9eO6FnBVGowv/O+xb2J8x74oQAy3k9JW9FScSq0iT3bcEaSjRLAyc0fqKqq4rQf2rK/XQAIc4g9U+1ubfO+sK/iHgoAa9CCkOtalB4RUwu5HkGUZy8ZjKdQeaPu33iG1x+EfajPbpFcGt7RAvIUSDemXPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3ce8cdf1898so57990625ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 02:10:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742289043; x=1742893843;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v8/+wiAd2ufjdbehkeuEZmi9ea6FirCGp0XB1yOJ0tY=;
        b=tfUMcvCTWJLEUuaeBE7JNBZYKb9bW3Jw9kSLiXXD/XacCDx7Ih42op0A97w43BBYib
         1iRiP+41lV83w+pTzDAyIXwWT5eWGRyCVXw2GQLy/ZSRmRkBH9tzX2sJ00fiHe2kzjvz
         zKNmyXmns6f7WiE+c60kGnHf68T5GZ9FAUs/6rS7wSphOq99m5nUxZEsitBlNM3VwdNI
         hHnwGgVvK0A+nNJPeXYEWz1GGqA3WWJzCwQgIyLiFd4K82A08vcbesnyi3zQhjckIoG6
         CQPU/lIUzZsn1SLGxmU8u9+bw0K16LzbVFIOVyvX+U76yYl1O5YQPpHWBYKki5CH5rtx
         ZktQ==
X-Gm-Message-State: AOJu0YxLrzoHE0NiEIFR0kKqFLfmFiTmB8KnMQhjVOdgbJf4lKaJ/r5w
	QzvCM5xTBJhcstKwfseNnoEG/qoNWZtCg3Ityk274SQ8kynpiJcJ1KBsuwn3pu+hkK5LCVe0RI0
	/1iPHRL5R/quAAVo3uq43hGYPXFxJ1ykbTALrPIbcS6bSf5j2Yt9EtZs=
X-Google-Smtp-Source: AGHT+IHY07BYz99rA3e1quS/Bs3a0mG59xRKp/Ze+ejIUwAgerq2ddZGD5hnybNp1FoupKpfVmsxCR290oOVF3VD4JmVZrNvBsHM
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3c02:b0:3d4:36da:19a9 with SMTP id
 e9e14a558f8ab-3d57ba0e92emr29281745ab.15.1742289043751; Tue, 18 Mar 2025
 02:10:43 -0700 (PDT)
Date: Tue, 18 Mar 2025 02:10:43 -0700
In-Reply-To: <67d92a74.050a0220.2ca2c6.014f.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67d93893.050a0220.2ca2c6.0165.GAE@google.com>
Subject: Re: [syzbot] Re: [syzbot] [afs?] general protection fault in afs_atcell_get_link
From: syzbot <syzbot+76a6f18e3af82e84f264@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [syzbot] [afs?] general protection fault in afs_atcell_get_link
Author: enjuk@amazon.com

> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    b35233e7bfa0 Merge tag 'for-6.14/dm-fixes-2' of git://git...
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1232704c580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=317038cbd53153e8
> dashboard link: https://syzkaller.appspot.com/bug?extid=76a6f18e3af82e84f264
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17d3fc78580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=169fb874580000

#syz test

diff --git a/fs/afs/dynroot.c b/fs/afs/dynroot.c
index 9732a1e17db3..3ea5e388ee16 100644
--- a/fs/afs/dynroot.c
+++ b/fs/afs/dynroot.c
@@ -213,6 +213,9 @@ static const char *afs_atcell_get_link(struct dentry *dentry, struct inode *inod
 	if (!dentry) {
 		/* We're in RCU-pathwalk. */
 		cell = rcu_dereference(net->ws_cell);
+		if (!cell)
+			return ERR_PTR(-ENOENT);
+
 		if (dotted)
 			name = cell->name - 1;
 		else


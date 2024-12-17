Return-Path: <linux-kernel+bounces-449371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 339299F4DE5
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 15:36:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDA7E16F89B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 14:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC4261F543E;
	Tue, 17 Dec 2024 14:35:04 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016F91F4E49
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 14:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734446104; cv=none; b=iST9GM4didY2z7CX7nZIv5L/Z+IavDgiCgPuN5ziPmlg2DAqPojVJ7Iwv1LdjL3qB84rhezjkXM2jdFRKygQ0ywcrBS0FJSaWuZsAlipVL2DouGQS4PVr/sbY/AgKaXO4kXzMzQgkWCLeD1QYuq8i83A5q/vjTmIT8vvl22rYxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734446104; c=relaxed/simple;
	bh=pJKKRQMMk6n5IDXs4b/KINw9ATda0wHsIoznO/vkOaw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=APO5sX49zh0rQMGyWLRHe5bgCYJfmJv87noanAPssTpSifF4D2ewfaH9b1hHhRd/7l0pO4hLTq+lYcaRQ/ramFRQACsjWRiKoN+yX/bc9NKnhBoYbphLzqjAYqUHX/uw4lAhWpBxGkamGOdRhnOlpmjawrUjxvsIyC57fng4AXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a9d195e6e5so55005325ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 06:35:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734446102; x=1735050902;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NIeMy+hsZP73590GRiY4sQU2LODFp6EkvQJk4gt6eQM=;
        b=uV539uvbIqin5VWGVQ1NCUclQF/EdueaPNRmoNjl8aIANFT9x2gsRd9+Wr6uggG5EK
         QsxFzc9m3V0SIjVeBbc4qYyAnK0uEr8UasX1dGEGfY8h7/rbbYBtXAs1vHL9/m2S6oV4
         nq8EjTC/KNZWqLB+3UHUUB3lJF8SWUaOGLcaDKT5OxDfUIPX50Fscy05c+y1PIXO0hqb
         fF850CA1eyHv35emxkf97YSiQwlInRY2NkN0lWyL+JeXl2onnB5tX6fsyCUrTULvW3fG
         MdJ026tRUZrmFF3ddFeL8uk/hf2gt0OMtsCuTbojXD/RfpKaxWxWVuEps0cHjq8Hhf+U
         PqUA==
X-Forwarded-Encrypted: i=1; AJvYcCWGmc1pHudQovEDW20pPXDGB1q8Bu+WLrbJaR4BYO9c4FSsQr+PwdBloc9nBKQ/9qmSLzxjGppkucSg3vs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4KC28hqXQOANOxiJ5cMxLeUT7O4ke+j9WTTQVY6yJMr1VNrKc
	e06lsNKEqfiEpZIf6UfEFKW4Fo6MJwtGU/+rMpBA9qqGa1ubq6QZpEUk0BuJPKHXqzuAF1rVs/z
	eTbDY1t1u0dF8aMYjkA7TsQOCOLhfeYoihpRpRXvEkoQPdB9KF2TKEMw=
X-Google-Smtp-Source: AGHT+IHAEgscXePXWN79iyq6tD6Me7CrUi11jctcqyyCc1dUiPvYRvkB2f+WBDX0ToNEQXQblXMZ/o9M0zvckfQwqrSjgMsnRbcF
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c4d:b0:3a7:7a68:44e2 with SMTP id
 e9e14a558f8ab-3aff243f5acmr153137225ab.15.1734446102117; Tue, 17 Dec 2024
 06:35:02 -0800 (PST)
Date: Tue, 17 Dec 2024 06:35:02 -0800
In-Reply-To: <6741d52e.050a0220.1cc393.0010.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67618c16.050a0220.37aaf.019c.GAE@google.com>
Subject: Re: [syzbot] [ext4?] WARNING in __find_get_block (2)
From: syzbot <syzbot+3c9f079f8fb1d7d331be@syzkaller.appspotmail.com>
To: Yuezhang.Mo@sony.com, brauner@kernel.org, daniel.palmer@sony.com, 
	hirofumi@mail.parknet.co.jp, jack@suse.com, jack@suse.cz, 
	linkinjeon@kernel.org, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	sj1557.seo@samsung.com, syzkaller-bugs@googlegroups.com, tytso@mit.edu, 
	viro@zeniv.linux.org.uk, wataru.aoyama@sony.com, yuezhang.mo@sony.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 8a3f5711ad74db9881b289a6e34d7f3b700df720
Author: Yuezhang Mo <Yuezhang.Mo@sony.com>
Date:   Thu Sep 12 08:57:06 2024 +0000

    exfat: reduce FAT chain traversal

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=156b5730580000
start commit:   f44d154d6e3d Merge tag 'soc-fixes-6.13' of git://git.kerne..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=176b5730580000
console output: https://syzkaller.appspot.com/x/log.txt?x=136b5730580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1234f097ee657d8b
dashboard link: https://syzkaller.appspot.com/bug?extid=3c9f079f8fb1d7d331be
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15e302df980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1265b4f8580000

Reported-by: syzbot+3c9f079f8fb1d7d331be@syzkaller.appspotmail.com
Fixes: 8a3f5711ad74 ("exfat: reduce FAT chain traversal")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection


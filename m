Return-Path: <linux-kernel+bounces-436216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C33B79E828D
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 23:59:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 016AD281C0A
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 22:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BCBC156641;
	Sat,  7 Dec 2024 22:59:05 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8EC41F602
	for <linux-kernel@vger.kernel.org>; Sat,  7 Dec 2024 22:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733612345; cv=none; b=VX2GJb5ddXiuglkgm2l2vc2umK0VXOwqBvPV3QMRMJP8+/C17NO8fDGb7CzL+qOd5NvF6M8fs10MvdAoofs317oYWkIjdSdpw5xVSnR5JTfRoeB1bxIAuplkSUL3Qx7zO1kDUIhyOb+vvFUMyqmmJloR8WDujac6sFGGNJ6mwXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733612345; c=relaxed/simple;
	bh=VbfwDvpDkp4rqaMWSCWi7xCEr81XyjMqVFINXcn7O0U=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Nrsy4c1BJu4MWbfuOVd5dHtRMKIkOg7Td3SlE+WYoXP9jvxO6HMqEIA2nC3+mdjsy64ETEs/Zly4bbz2PLwXPKi3KqJTC5Lc4eY+TV4s15v2OPe1T8Vlqfv2I5wQSaVjyhCqbDRli9hmsTuwCLi0MI5HxE7VQUE/CDfz8YBFoao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a81777ab57so13427165ab.2
        for <linux-kernel@vger.kernel.org>; Sat, 07 Dec 2024 14:59:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733612343; x=1734217143;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R/VmBNzolQEI+3BQ4hjo9q3nxk8T9gmXnBExH9+rR2g=;
        b=PoXzwi3aqw4G7LCpvLUKKtHWjBe0FbPd57e29UFui9BZjaHGaRpdML7E/3ztnvgHqH
         co0tWFV6yRtyuWH/swCl4lh/d9d7wdtPTN6+h/g/YPmlW+pmMUOEvfeAfGcLcmmVFzEh
         c37cemsK1hxB33VbTlsTDfZpM49ncaO2V38F1H56lyM7y8RYmXmPsz6ch1c9Qr1SfWVK
         Bnsc1+ESXHYiq7JidDBChSwZAxNiAIlRw5L9+9QxoNbSGdmU5QVUlxRAd4rcCiCjsgZg
         bEWSmOrcFdVhNf0WztuSRtZPDxrdWxvz7XVB0CveZoQ76ARQcZBvABIshTanviDLIAWT
         dGvA==
X-Forwarded-Encrypted: i=1; AJvYcCWj5UaLME/AovN9Fj6UxjyvczEJESMKx3zEB842Ogn9/hPa0KqsOL6Zyr9w0UW7UiNXE7oaRjtaVl4CNFg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzovJTz9Vi3M407HU/IDCSYsYQ9iFsszgz7fGtMwd/DKCL3HJkc
	09JcagM/7/P10RNqN9L1/oS+KlnVaHivEttAknol8oSlYgQp1qlQYfrkOIZRdaQY8P0Cu+tcZ+Q
	GfdZf320WqdKC/Zf1mCGLiGIVqzbsZgM1QnrwnrlzIe+4OYMGz29LnAk=
X-Google-Smtp-Source: AGHT+IGlJLJ9elp4FLJhcyLSM6CNErXuufBhJOtN9fIxLINJ1c1Ag+4uv70DCO8ksH4V205lktYKJPZIPvzSVZfJhizmWkXy9fvC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b4a:b0:3a7:e67f:3c5b with SMTP id
 e9e14a558f8ab-3a811d775dfmr78128785ab.2.1733612342844; Sat, 07 Dec 2024
 14:59:02 -0800 (PST)
Date: Sat, 07 Dec 2024 14:59:02 -0800
In-Reply-To: <67388dcc.050a0220.bb738.0008.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6754d336.050a0220.2477f.0021.GAE@google.com>
Subject: Re: [syzbot] [f2fs?] kernel BUG in f2fs_evict_inode (4)
From: syzbot <syzbot+5c81eb8c0a380fa578b5@syzkaller.appspotmail.com>
To: chao@kernel.org, drosen@google.com, jaegeuk@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit acff9409dd40beaca2bd982678d222e2740ad84b
Author: Jaegeuk Kim <jaegeuk@kernel.org>
Date:   Tue Nov 12 01:04:58 2024 +0000

    Revert "f2fs: remove unreachable lazytime mount option parsing"

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=130903e8580000
start commit:   b8f52214c61a Merge tag 'audit-pr-20241205' of git://git.ke..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=108903e8580000
console output: https://syzkaller.appspot.com/x/log.txt?x=170903e8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=335e39020523e2ed
dashboard link: https://syzkaller.appspot.com/bug?extid=5c81eb8c0a380fa578b5
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=155bd0f8580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13cad330580000

Reported-by: syzbot+5c81eb8c0a380fa578b5@syzkaller.appspotmail.com
Fixes: acff9409dd40 ("Revert "f2fs: remove unreachable lazytime mount option parsing"")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection


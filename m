Return-Path: <linux-kernel+bounces-188305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81F188CE052
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 06:16:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85DE31C20643
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 04:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26DB6376E4;
	Fri, 24 May 2024 04:16:07 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509198485
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 04:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716524166; cv=none; b=TuN9Fcwqr3/6iJpuOouRNji/8BRhxfibMyy5gKrzLm84ofiIOsl4A2vZNpFz7ULeIGbbiM6jJjdYVXo2s6qbi6JBbBt6n0p/Hfj4X8Wvt4aVCcU7MBAl3A5pGC1XECXtbjCOVI31YpYtvH1gy3jGu6iSj4q/DYfm2ffWngkE644=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716524166; c=relaxed/simple;
	bh=NOxp04dV6l4aV7xM40JubsaMlTJsRil2ilpAi3Irgo4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=CwvVZhcii/CxhlGKTSYE9M1J8/SGfldGjeGLUvRVpmlLgzDCWeRysHJY7kjae8r0+kJDXwD4IJk0t96YFrWqIxAEdhvRsKzfgb5Zz4y4ay7oGs3UwaC0Q3uFidWWEncc7/3sNaW0pdVRP/4OdRMFm8wzGch0Wg+ZWwVwJdkcsnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3737d7d68d1so1495735ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 21:16:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716524164; x=1717128964;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HPvsxZCUKrKGqWh4Se6OyUJNH3cHqq0CTltQxJRFTCM=;
        b=bFjsqNqswLgMWOh2nwux73ejjtDWQDRB9FHJ62GNnEU643PaAL46Z7UAjaUdeBmi0n
         uSKC7r5CCKrTr8/bWC8v1NJINVGNpWy2GDiaOpu1qJZyFIMBAXZ9pc+bS6kdZewAF8rr
         daoWcktMVq+xuaqb3bU5HsQa58S4DzbEsbuQRWFFRKb9+MOrkgh4hk0jW6OzjRsUBmRX
         mkA8yPIxwMfH1Onx/oWxVREAoA5QaxANEO6FY42O5ATHP5P/P5VBa0+MvnCCT6/dWLoK
         37H8XcrGTwmjuEkm2oAHeqdm43fxUdRBxY79o06QDKOYfZWk8wtJKD5RwxO8ECqoXyOA
         DW5w==
X-Gm-Message-State: AOJu0YxiRlig2JWuJIsfkpIoKT7mxYH0kp2yiyxuqyqRbQx8ADDSx0CA
	hVvkoFMEKMjg/OgMLFB6DlCyCV3YgAbAXkjpXXOyv25avn132DPXq5Q7K8MI2FsQUA/rkAXh63h
	jOmoeXNNkUlftQwKZ8e3I6ruocTYKByo3lNfJtEKI8CVJjs+TBsh+L8Q=
X-Google-Smtp-Source: AGHT+IHsIg6I8GG20KG5scLdGWHPpDt2DsF+AkMW/xQAYLc/eT6K6EeHdDiOy9pXanGdrjLh+3Ig012lhJOJtqLvyIH9kI8VtOxA
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d81:b0:371:139d:ba7e with SMTP id
 e9e14a558f8ab-3737b37afe1mr791095ab.3.1716524164390; Thu, 23 May 2024
 21:16:04 -0700 (PDT)
Date: Thu, 23 May 2024 21:16:04 -0700
In-Reply-To: <20240524035136.1561347-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001139c706192b6dcf@google.com>
Subject: Re: [syzbot] [fs?] general protection fault in iter_file_splice_write
From: syzbot <syzbot+d2125fcb6aa8c4276fd2@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+d2125fcb6aa8c4276fd2@syzkaller.appspotmail.com

Tested on:

commit:         33e02dc6 Merge tag 'sound-6.10-rc1' of git://git.kerne..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=17192b3f180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=25544a2faf4bae65
dashboard link: https://syzkaller.appspot.com/bug?extid=d2125fcb6aa8c4276fd2
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17f2f392980000

Note: testing is done by a robot and is best-effort only.


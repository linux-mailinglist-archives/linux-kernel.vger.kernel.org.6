Return-Path: <linux-kernel+bounces-434460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C4A9E672F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 07:11:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6CE6188589E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 06:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1ADC1D90B1;
	Fri,  6 Dec 2024 06:11:04 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF691D8DE8
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 06:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733465464; cv=none; b=aslXTHggNs11SkvAAb223JUfA0rTJchZo81odBFxXD4W7f9+YHgAQz8Nynl7qgMaU9OMD9c4tm01lWihorTKDi/mYMPjgcMELB0m6mRdOWtm3iAWH+TL3b2ywB51CBt3+/zP+WvdVlUeO10mD+nOcsJiwSL+UnaXXVAbzvIm618=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733465464; c=relaxed/simple;
	bh=MBjj0dAZQ91LM+GKalVQvPREwDV2EQw40XbSGHtwPQo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=r5UPp7iXjQPmGXiaT01YeQtIyIVLkpx7n28nFsSc9EQSeyajR+27rX+XP+QOe+rXJ97M05j4mbfMwIA9ssw3f8wrfRcf5r7ktg3+A2dcAjdEX2ccdrv1Vf06Ogum67JJLBkdNiT3h4mNf3FUNsROQthBuXHxhn/tmgbFPQg33lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a814c7d58eso2214735ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 22:11:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733465462; x=1734070262;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hynB85QWUaqXvuaUinrYxAjUZnOP2rZjkeD3Kjfiybk=;
        b=Ua+3eJbTMYoXjILEOsVdRyJFZvLUY8vHBQgKzxBXA7D9PEYALNRsBLT0Ei0WhC56/l
         Ya3bJbUS6OHIDpSsdZY9l4/T+p/zC0maSETviBb5cwKz6EhdiyCEfAhIAe2sghiQ9bKA
         hxqnK1D8G/PwdaVemzFC8REYvmINkv3KySvDmN0wpvhTo7DXaj4hU0D8aodcig3IOlXA
         4Ig67SZH9cjv6hgMcQAeBBY/jbUEzPhHnRU+XQIh29Ka4j7YcqCqa1UDI4Qg6xr8tUlM
         Hfm5PKg89PW/CIpmtvJ3v/hF9yeLbVP1Rf33mOMffPnLbrCqth9eXeq8oWpRztvHXYZz
         8APw==
X-Forwarded-Encrypted: i=1; AJvYcCU5GWtgsGPxWH6AO1RVvwBWTTI9j1FvsO5OSOjZyphyTvtx2z9MVI8PN8diBam9aE88MFxBGwxD8BNMvrs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+ViQpkjLm+6hQykwH+pcdLDjRxqqs9gIRBlUpj7ydmwJyl74s
	dCfqhqqS8GiLJouID2WO7Ey1ISmtu7s5ifVg2lYlVYxoYCXL3o59fiJyEFuxZjkbH1Sh6jizJk9
	c6skevvTbTW5IFXdE/0Vsv2dnD2dpWTQXSs8KUjFM1Arxw7GkFBIOlRw=
X-Google-Smtp-Source: AGHT+IGkrPW2Nt1unJm5MKaU2EXZuiH4r5vIyjQNPX7z78aZdvL2K0aGwDFUJKoapWNJTeWsv95bwsnVpEXu0I/cPxHbjdt2fbk8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1447:b0:3a7:635e:d365 with SMTP id
 e9e14a558f8ab-3a811dc1d84mr25280065ab.6.1733465462263; Thu, 05 Dec 2024
 22:11:02 -0800 (PST)
Date: Thu, 05 Dec 2024 22:11:02 -0800
In-Reply-To: <6751e9fb.050a0220.b4160.01e2.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67529576.050a0220.a30f1.0131.GAE@google.com>
Subject: Re: [syzbot] [bcachefs?] KASAN: use-after-free Read in check_extent_overbig
From: syzbot <syzbot+fbc1f6040dd365cce0d8@syzkaller.appspotmail.com>
To: kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit bf4baaa087e2be0279991f1dbf9acaa7a4c9148c
Author: Kent Overstreet <kent.overstreet@linux.dev>
Date:   Sat Oct 5 21:37:02 2024 +0000

    bcachefs: Fix lockdep splat in bch2_accounting_read

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1147e8df980000
start commit:   feffde684ac2 Merge tag 'for-6.13-rc1-tag' of git://git.ker..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1347e8df980000
console output: https://syzkaller.appspot.com/x/log.txt?x=1547e8df980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=91c852e3d1d7c1a6
dashboard link: https://syzkaller.appspot.com/bug?extid=fbc1f6040dd365cce0d8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16804020580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12ed1330580000

Reported-by: syzbot+fbc1f6040dd365cce0d8@syzkaller.appspotmail.com
Fixes: bf4baaa087e2 ("bcachefs: Fix lockdep splat in bch2_accounting_read")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection


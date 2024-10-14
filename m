Return-Path: <linux-kernel+bounces-364752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42CB899D8D9
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 23:15:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74B811C2133C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 21:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9340C156661;
	Mon, 14 Oct 2024 21:15:06 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8E61D5AA7
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 21:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728940506; cv=none; b=bTS+2yNIKDwODIclUad2P/2gfgr0pZswuPSXklsnfKGhajcBDzYP9lwT/qXKDaMIysvz3xcPS/JVhh9oGeunMuNqYR2K+tJoRyqsnqtmFkzERbQMb86uPsqPN1trN00dcLosLxizNJeLeDXLf2c+I3uh+dce8o/WOPwdInI/BII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728940506; c=relaxed/simple;
	bh=EZ0v7J4oOMcOslFf4bKPZhcYqjd8zK4BtPViPW+0F9w=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=dCsk0p8muu2J03Cagzrd7fDO50R4V7d+w41IHIh7AJ3cCVhhZhOgAULb8HlhyBKJajD6Wq6pVsavTF3jATHFtuujD6nMORYEocWexsr8S6x4wtIJe47oYl/KCceFJorYq5Sys41l0o6ZZH09dihJOQ4ZAORkBZNfXvgUgTghNOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a3cb771556so22026955ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 14:15:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728940503; x=1729545303;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JbtytKxPtWo8qGp6PSNI1VKdxYyCl07qstxWqw8lXnM=;
        b=HSqGcp3tS1NSMqmHlP/l3PuZxf0ovQ2y4yyvFpUpQnqtIK3sYBEpE3oVep5BYSStey
         k19HbLxvZMgsNxFplKpwdMh2Cs6ikUGenEG+J2b3n+mS2gx4Ub3x7PV669y1sTAbI0Cd
         9JgtG+xUTaM7BJGs3YCECNVkVzrvzbPj2MIvtPIsTr4TC+XdggO/q8q0Ke6xes8n63cp
         I7uQUcp1EOG8Db621qeSrxrKWLgo2WT51FkOSQ+hxiAto6bfSkf1hR88/S6KFp+AY9/O
         BFMJB+IxZv2rPPZDtSYXHqLHagcX9HDROeqSGYeKGDWaswJYaqPRxB2EmTbJaoIwj7YP
         RX3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWyGGcOk+mP07Lt+kLXAMOskCYaOEhzUBYlJY+EriyPNwtLzrnrK0S4f8BtnL4nRFct48fIKanfqmtvG4o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxiosBwLEziv8voXtGHLhJ27B7pfU3JlNwxooJN8cbNajY/qTW
	EA6MVS7YE5dYpW3plsLlKZcb+fS6zinC8IU4rSRxMUgXZHprGzO564EdrMkokuh+Wa2Fn9qsl79
	yLiYqkhCrUVpR82uoPAA1Iv4LUj6ZcPv6fInoby//DK8ltJJshHIaJac=
X-Google-Smtp-Source: AGHT+IGrsZwrxcJrRmY2ubbDLziXaeejHf4eUJb1ONBndHg/ZQzSMOowXsKgTgtDAA5/aGB/zNoeHllgoly2vP75azbbKCMP2L6R
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1385:b0:3a2:7651:9864 with SMTP id
 e9e14a558f8ab-3a3bcdc6befmr68290185ab.12.1728940503359; Mon, 14 Oct 2024
 14:15:03 -0700 (PDT)
Date: Mon, 14 Oct 2024 14:15:03 -0700
In-Reply-To: <457510ec-d103-4fe9-82bd-293e66f48be6@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <670d89d7.050a0220.3798c8.0131.GAE@google.com>
Subject: Re: [syzbot] [fs?] BUG: unable to handle kernel NULL pointer
 dereference in read_cache_folio
From: syzbot <syzbot+4089e577072948ac5531@syzkaller.appspotmail.com>
To: gianf.trad@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

kernel clean failed: failed to run ["make" "-j" "0" "ARCH=arm64" "CROSS_COMPILE=aarch64-linux-gnu-" "distclean"]: exit status 2
make: the '-j' option requires a positive integer argument
Usage: make [options] [target] ...
Options:
  -b, -m                      Ignored for compatibility.
  -B, --always-make           Unconditionally make all targets.
  -C DIRECTORY, --directory=DIRECTORY
                              Change to DIRECTORY before doing anything.
  -d                          Print lots of debugging information.
  --debug[=FLAGS]             Print various types of debugging information.
  -e, --environment-overrides
                              Environment variables override makefiles.
  -E STRING, --eval=STRING    Evaluate STRING as a makefile statement.
  -f FILE, --file=FILE, --makefile=FILE
                              Read FILE as a makefile.
  -h, --help                  Print this message and exit.
  -i, --ignore-errors         Ignore errors from recipes.
  -I DIRECTORY, --include-dir=DIRECTORY
                              Search DIRECTORY for included makefiles.
  -j [N], --jobs[=N]          Allow N jobs at once; infinite jobs with no arg.
  -k, --keep-going            Keep going when some targets can't be made.
  -l [N], --load-average[=N], --max-load[=N]
                              Don't start multiple jobs unless load is below N.
  -L, --check-symlink-times   Use the latest mtime between symlinks and target.
  -n, --just-print, --dry-run, --recon
                              Don't actually run any recipe; just print them.
  -o FILE, --old-file=FILE, --assume-old=FILE
                              Consider FILE to be very old and don't remake it.
  -O[TYPE], --output-sync[=TYPE]
                              Synchronize output of parallel jobs by TYPE.
  -p, --print-data-base       Print make's internal database.
  -q, --question              Run no recipe; exit status says if up to date.
  -r, --no-builtin-rules      Disable the built-in implicit rules.
  -R, --no-builtin-variables  Disable the built-in variable settings.
  -s, --silent, --quiet       Don't echo recipes.
  --no-silent                 Echo recipes (disable --silent mode).
  -S, --no-keep-going, --stop
                              Turns off -k.
  -t, --touch                 Touch targets instead of remaking them.
  --trace                     Print tracing information.
  -v, --version               Print the version number of make and exit.
  -w, --print-directory       Print the current directory.
  --no-print-directory        Turn off -w, even if it was turned on implicitly.
  -W FILE, --what-if=FILE, --new-file=FILE, --assume-new=FILE
                              Consider FILE to be infinitely new.
  --warn-undefined-variables  Warn when an undefined variable is referenced.

This program built for x86_64-pc-linux-gnu
Report bugs to <bug-make@gnu.org>



Tested on:

commit:         eca631b8 Merge tag 'f2fs-6.12-rc4' of git://git.kernel..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=ba9c4620d9519d1f
dashboard link: https://syzkaller.appspot.com/bug?extid=4089e577072948ac5531
compiler:       
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10db8030580000



Return-Path: <linux-kernel+bounces-364759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9819999D8EB
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 23:23:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1670AB21839
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 21:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42B921D0438;
	Mon, 14 Oct 2024 21:23:07 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6672D156F44
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 21:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728940986; cv=none; b=kHWM4UghnEl0aVRkGG7NI2O7K9aVzBf+Rf5g2oj4xH8Gha4z6BZAitj+qFMHkLYOxQNZ0bRXR/FXP5rqbqUSpSE2IWNRttEltco/t77r5qiOz9A7dQefKmFyh/pjHKdXpvrXaM0m1ocMxM4zGY1xOzbR85CNz2U+E2PaIJPIZc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728940986; c=relaxed/simple;
	bh=/zmG+4Ahu2Oh6rAWmY1DjPXGKFMkekSG3GbrL2YNEG0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=LHZJFa3F0TwCfs05G6yTgf5AjMlcwk3AW0AfkXPApOg3HAihrAQyo2JO/qgjpiCyroGad7XySTFC5n5PCvkql4BS0Z3Z1lOU2LHstPQYhoA3v23kAlX9CsPvPLvIESLK3hk6B7DpcDnhq55uMTQCKNjOS+Jb7DOX07y6oMsj+PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a3c72d4ac4so15681825ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 14:23:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728940984; x=1729545784;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eNj4p2PibYEKaboukxJWUhc3R2Z+DNYbjhqO6RdKNfc=;
        b=XAlxaGtIh4CHrzNcIUhSroJGudzB/+L5RyaAF73/RVP4LF2aNuSZlxCLFk4gK9zG1P
         TfWz+kfXjPaZyAc3lMtjWzlldm4JpCVcCKLpd4Ozqp2iXeMPBCHzdZPo6HvkODaFno6T
         LZBWe79mKQP/f0f6Zy/vFYEozvsm6Q6iQCsxuJUtKOgNUXEMosxVexjeBRzIYce3+17L
         EA5oT8yRrg64di4dNWxYizt+NcFRYLxkXJZOy/2lTq2T4IxZvn55JgNacN5sql18bckU
         dV61sY2Q+K//+GdPxniA0vhVK6fR9syTB/jm19aGWi8Xo+Z31b6tgI4vyYhP4R8+k1fl
         s4zg==
X-Gm-Message-State: AOJu0YwzD1Bl+aXQ9dYAfaF7j6WX1B/bObgi+bErXyXrHg6hjlN+HFLB
	SqgTNN6sMXTLqzKmkuzOBjVvNZBDzvEsl4H0pZ/s2XJJmCImKM0rXyBFKIWSsY9wZzCeIxNcmCy
	1Lj6JdSojXEBNcuu43RcxGLTVra5EPpgL4UI0+ZbrM/przLd5Z1TC8Lk=
X-Google-Smtp-Source: AGHT+IEcvzPGoPzYqiVH/KnPpMsulES8YEWdgDTyIgQAHKhbJLyZ+eOy84L4VBznRJgAt9KHb5Kak1SAOnJSeqx70hZ25EtovFBl
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:b743:0:b0:3a3:c036:e3ab with SMTP id
 e9e14a558f8ab-3a3c036e518mr55048105ab.18.1728940984614; Mon, 14 Oct 2024
 14:23:04 -0700 (PDT)
Date: Mon, 14 Oct 2024 14:23:04 -0700
In-Reply-To: <ef6bdc0e-6de5-4be8-9b4d-8953d954f418@studenti.polito.it>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <670d8bb8.050a0220.f16b.0002.GAE@google.com>
Subject: Re: [syzbot] [fs?] BUG: unable to handle kernel NULL pointer
 dereference in read_cache_folio
From: syzbot <syzbot+4089e577072948ac5531@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, s323713@studenti.polito.it, 
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
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14078030580000



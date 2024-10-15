Return-Path: <linux-kernel+bounces-364904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7397999DACE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 02:45:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 110271F22443
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 00:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84F013399F;
	Tue, 15 Oct 2024 00:45:05 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E816231C88
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 00:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728953105; cv=none; b=gGmnLC9qclchxWyd16cKI+NxyS0OH+u7Y8C3kflVTdi0HWZ9JPCekmUp+orV2eKwDRUoIfrp77q7wTqs1RlrA0vuuB2CQGzXAtCZ8zUS9Anko7F922i4rGTOcpLLhlKIOuJYVrAXgGUL6qkW/ay1hlqzhv9oWuTpQXGFzD5n4Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728953105; c=relaxed/simple;
	bh=lQwu/KJWqs0juZ3O1c+JPNjqOBOsW/EPXwiu6AAIkaY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=XFHIwu0UOcXKpNf+6vJa+0lmJ25YmeReswvWM6DEqCpWZ8jo6/4lU3j903DKqepxs/1hQHJChNZLzJ4973DmZUHSa68LG6/S4cVgcjhhaeinLm4NYF4fQR6nN2UheoMfK7pjx9yPBVY1UPx572rF7yEBHx7F/aiT8pngqAU0Jd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a3b2aee1a3so35106575ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 17:45:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728953102; x=1729557902;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TQ2DsfOzMMURrLVeHlYycj6Un1NxkkNDGXKWpHDES00=;
        b=oSQlyon+xWoXdIGJvYloTF1ZJVnY4nOn49/U5iWXPwy6rHrndZYgJlekqMUuiEstP7
         VRj+mYOwDXeywuW8y+K4dOyMrkmXDDvZDjBf2ZnYXozFZvAykXITKxqu+b4uguLqo6Sx
         GoVdh2dn+D9FkzeSsl5tvOjgJ21dNTxbcYNyT+hmo2DmTi8CLrNHbEmklErvQGVnfzo9
         0l4hGrrAKSZ7/EqwJoNtCk/DxCnmK7qa80yQsX9o+LzuqV1R0/qzNvDh5IZB+usYJynO
         0hejMAUxrBcxXfDp1Vs4GanERiGwDnP3oa6BwTtbiv1Se5ws9DWAGscsMLQ26qJ0sZI/
         A3Qg==
X-Gm-Message-State: AOJu0YyfUNjVFbQkfD0mDRrvve2YrY+dLc4KNDTdXnptopdzS5daycYS
	9ZZHD7EHR6/I/2xxN0BiZNPutUx11mMKz1XhvN0t3T+I9AuEqNf77kURdBgRXX4JlLz3jPwFMkH
	XSux/8ajoWmocx/QzndS8NJnc2i3Y7YYf6r6/k4OohSfI3J2ClPLUGtM=
X-Google-Smtp-Source: AGHT+IGtHNKWw4KL67RiQlHmFm+3pOyZTZQQ04R5jaK+EfMFqW2s4x3ENMnccojsXsMRJLyFvtGuexKL8XZXdAcpcz9xxKDCK+OD
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:188e:b0:3a3:9461:66a4 with SMTP id
 e9e14a558f8ab-3a3b5f596ccmr107370075ab.10.1728953102616; Mon, 14 Oct 2024
 17:45:02 -0700 (PDT)
Date: Mon, 14 Oct 2024 17:45:02 -0700
In-Reply-To: <1336ee1b-cf5d-4081-b4f1-512e2b29dace@rowland.harvard.edu>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <670dbb0e.050a0220.3798c8.0134.GAE@google.com>
Subject: Re: [syzbot] [usb?] INFO: task hung in usb_port_suspend
From: syzbot <syzbot+f342ea16c9d06d80b585@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, stern@rowland.harvard.edu, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

kernel clean failed: failed to run ["make" "-j" "0" "ARCH=x86_64" "distclean"]: exit status 2
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

commit:         8e929cb5 Linux 6.12-rc3
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git v6.12-rc3
kernel config:  https://syzkaller.appspot.com/x/.config?x=4510af5d637450fb
dashboard link: https://syzkaller.appspot.com/bug?extid=f342ea16c9d06d80b585
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=162e785f980000



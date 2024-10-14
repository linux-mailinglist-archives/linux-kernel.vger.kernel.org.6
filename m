Return-Path: <linux-kernel+bounces-364815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B697599D9C9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 00:26:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A66D281E30
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 22:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0DF61B85C2;
	Mon, 14 Oct 2024 22:26:04 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0537E14659A
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 22:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728944764; cv=none; b=AJlzjxTiraU33C3pzGIU8a9PVi6QDnCo16pCkKgxgP8E58/XTnZtocrLKmh7Yx4HZ/LieiDqadrbHxZC41T2WXgTCtWsUjbL89p2Lm5PI0L8cd2lNPBMzMRQx9KAivFIGJCSqys+0Kr27j61epMN9867X/p5LATVIAyRxNBgopc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728944764; c=relaxed/simple;
	bh=uWaqpG1ABlx/htJNRJt+TDrXAemsRnzx82jB5ZIUmc4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=J3UxfiTxGPAHHGnLMidBuLpielCpAoX6vnuSKgoWBwbvx1yVqFTGM/iYLp3dYxGaQBEnjhTZzdaohPU2CHdoY1EWdS/MrYlE6KrDBgfZVlYtJH/5yccSUTqSkNpmgVWFcXdJ+IhbiyZLEN4HEYnhEu/gL+dsjR28warTTNYg9ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a39631593aso38851145ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 15:26:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728944762; x=1729549562;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JI/Fvo6ZyZIEYrYSuRA0jKaM2cKeviEN42pAJhZ4K9A=;
        b=a4rovAZa6AFAveRgMs8KPUbRFS/LRvDW2/5nlBuc9m40IHw26+oz+sXI14FyOkJV1D
         qLj9b7cmVHql2AXBzu7/cpq6RHiZSVzbGt0ApphgwKwglwg3SfGAXikcvi809bLx4bqh
         wR8QZVt2C7/cvis3shSTkj9vv8Jw1ku+Zif2GbHYrjuo5vtXuQpmSzKiKOfsKk3AC60/
         eaRi5Q/drFP6c70AnEpSS+NxvMijbFlvTHUfu/EQNhX4m9rBUc7zbsSOlF/aDZUfL7Ft
         7UiTelaudFjaJY4c4+zjIgjRe2B5/pWQ+7scIZkpfJUbPLtqWpQvptZ8W0sdyW35rlOS
         Ee7w==
X-Forwarded-Encrypted: i=1; AJvYcCWEW4vQQoDtEQ91jQr2oNnL5fagumhsRoEFn8Uz8e6K43GOmufz3JiXw9gvLihBMb3YEja1qfYM/lhjSvs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNLf8CtB1V3ifJAR65FKEPb5tEYF7R2gIrxu59p48MsjJ3rtda
	V3ZvBgXNa2JJF6RizM8aber/6FhiF019k+VyFKULaiKYDEy7o5UPyEWRIDSATC9K3s3uLQ7yJQ3
	11sxLrQjUK/K/ezc5fJCL+xIECLoCiOUyQoC8KwNL6YMUSCiZ784Eh38=
X-Google-Smtp-Source: AGHT+IHHoRmJHWp52W53Y8cu03zeSEcamXG69vRIJiJzyPmcnNdyZPzaOuTkk50WcpUEg+kWAoCor6vwHlktBnuSJrNWCoGLGg3L
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2163:b0:3a0:9c04:8047 with SMTP id
 e9e14a558f8ab-3a3b587bf91mr73465165ab.6.1728944762212; Mon, 14 Oct 2024
 15:26:02 -0700 (PDT)
Date: Mon, 14 Oct 2024 15:26:02 -0700
In-Reply-To: <d07fdb85-e867-4296-8582-d3ccb8c46a6a@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <670d9a7a.050a0220.d9b66.001d.GAE@google.com>
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
patch:          https://syzkaller.appspot.com/x/patch.diff?x=148fb85f980000



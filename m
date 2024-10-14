Return-Path: <linux-kernel+bounces-364826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CCCE99D9E9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 00:57:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC961282DE9
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 22:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8BDA1D90A4;
	Mon, 14 Oct 2024 22:57:05 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64E21D5AD8
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 22:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728946625; cv=none; b=WCTAv1pcmJK8sR+0qjm22/WHjMFrKxhM3MNRIRwv8xmW72rv5T7KyIzi6h0HuLMkepf5BY0Sn3qQz200Mp85LUpfFcBRS4PZzZUXkqHiQLnBB5CQcPt7dN5AxUbOX1d7JCwjrcywXLR5ET6YcpzJvR7MdIasyUq6CJ9pVKu4gFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728946625; c=relaxed/simple;
	bh=7OB7aQj+G7t79dnpT9VQ21yncHwdHmrzo77ALh4hy5k=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=HkmN0dEmDDzfFByehDgS13UZ0itwBqtmzaAIRHq8N+eFP/tr/4e3c+GMDTYYuGD4PyGhhXamy/v9UhSaO2ct+84O9X/qJWBQhhLLRLN83xGBeT4YcfYM2daXNyz/dLepjz+pbf+DDW+TJ4DWq8nwInBkKiX+kCKjkYHDEVah1QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a3b7129255so52406145ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 15:57:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728946623; x=1729551423;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t4Y2tkvFwgL+3Fd3UKk/Xg6HBDmHA9cHy+j8T2yHM4o=;
        b=bbTxXZHYS2X4VUtc6ByxRutdepUud4L8C15rH9o7YZ0AJg8CpugBDVnu8g2CrWJ65n
         fF+LLc1QHFJfMnplhqmaZ7U/u9JgLC5W7AigMyfpSvdizdC2XVP8SU6pMU+RnFNUOorV
         O3KbX+cWGVtB+JSqqdbp4DnU4sihUyGNBu2s1oy1bHLP4eAYa0Xzm8BqAIEwa1O2qF7j
         Dem3aSKQkuuNNlRhGdDpC5PrzQdJZ5u/L+Y7/S+zGGkK2nxAE0JUNjj7MSDsld8OnPF9
         2kqRCrEVze0R1u7bDDOQ5/uduThK1jYYqt/kYncmga7avFvXzaCmH/hppcJQqfDvpxs1
         oYGg==
X-Gm-Message-State: AOJu0Yw20zhU4ZmaTlJU9z0qhUl9v942PfVOXttu5WJ///rYOtacNzQe
	cE+RrOVVxfozyUtoKEHjEnhRamsT3WOqGF+aJbYR1pjNBCzRaTNYC0eI2pLxLKLwnx7xHkeldTA
	k2yY1CbzopS2RDNekBcnD0J9M6k9bbd8ewX9o+QaZw65Aye0OeCa3Otg=
X-Google-Smtp-Source: AGHT+IFns66AOZFAoX4MQ1+IPcw7TNYafcYK2BRPv8fmfGO9iUiLczbHfg7upnczDpeA6beT0qaUsa0BkhyfA/N5nR6FMzsNZO2G
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ca4e:0:b0:3a0:b631:76d4 with SMTP id
 e9e14a558f8ab-3a3b5f7a928mr93521655ab.1.1728946622744; Mon, 14 Oct 2024
 15:57:02 -0700 (PDT)
Date: Mon, 14 Oct 2024 15:57:02 -0700
In-Reply-To: <d662ba74-2c02-4298-adfe-f12b3d65471c@rowland.harvard.edu>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <670da1be.050a0220.f16b.0003.GAE@google.com>
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

commit:         64f3b5a6 Merge 6.12-rc3 into usb-next
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
kernel config:  https://syzkaller.appspot.com/x/.config?x=4510af5d637450fb
dashboard link: https://syzkaller.appspot.com/bug?extid=f342ea16c9d06d80b585
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=109f9727980000



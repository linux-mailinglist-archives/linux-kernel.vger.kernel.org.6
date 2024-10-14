Return-Path: <linux-kernel+bounces-364505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C72A99D581
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 19:20:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D52E21F24720
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 17:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 483121C6F70;
	Mon, 14 Oct 2024 17:20:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67CCC1C3050
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 17:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728926404; cv=none; b=o+FHVWFw+N/DP6jwe9PCurrLG3hAWRLteq0VWXLhNnRfYp0Ky5ZElzNigd6QDjtBUHctphc+x9ZdfGgT5/8IFI3hcyDLSf5eFokOVqKr4YqhP+h7ht/xCZsUua/JHoYJisMbKhk+Rx3fzL1WLaEL+TAxtndpPhnJ9M/m3fyWD/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728926404; c=relaxed/simple;
	bh=7DRgzsiTRB0ufC42IPlGsHgAEnDG4Zwu2YuUl4A/uEE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ulqklEGPIBNIZPcddlFopwlxIfBRbEWR3CsataaY5b/HLxhOnmBByYA9+wRb3WZgMWlJ7VyHIaYzf/bddMzlSAdMb5z+EXocduaFYcjvuq4dKX5DfmDC8VGBYAZP2OQ87JViCi+OQpXpRrf6cIjSear4fdm6mNOkyfLKnJC238c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a3b7ecad71so15888235ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 10:20:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728926402; x=1729531202;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FYZKa2Fu0jFaXXBO9cmaDpRA4k0UnSUc/ZKlK4l6X8Q=;
        b=dkPCEP16/N4Jf3xv4qy2AiUMlT3iP8EQIIKJgLy2iD4rXM0nOcn3UdjsfL4O2Y2EuE
         O3oNWd3GNCloAsegYw6+YvyM1N5YauGsvQvWLO8+TuJf7+qiGACSwyKW7ktsb5mX6GLB
         2rhdEzrTJOL/c4uARiaTDHM7SgZ/waToo5a0VaaWZXey8ohYx3Ab10TUgb0NWE2YARJ3
         KzWuD62vqDjiUF3ZQVqRYOl8MmORh5prcCOlfOimc6LUDeo8/OEOzFDF0lRqpG4wsw78
         45/Z8ngr9yY3BY5rfeEkccP+GvFoTdrkWWQesO45y3BnZnsKDhxAyowVQPF4Tb9h2qBm
         u8Ww==
X-Gm-Message-State: AOJu0Yzo8JSQrPjxqsMacYtysjiWhrKVAsya7c74KfSN49I1Y6HZhYLr
	asrcOcrZj0KCIMnP9nGy7q/rBGNJf0SWLQrzRxl6a8jQc5My+9qbSt8tKI6eysU63PFzIs8JOBZ
	oExSCO8LcvpixmM4Zv9Jb5RaXnUYEPK3NDkTPRHHm1R1utj7zgonbR/s=
X-Google-Smtp-Source: AGHT+IHhVBWGzT13KiXPWTYwEp3JMYhsdZgAK0rCE5JwVf1OPFQCLe8tiN7GnB8E/n0FDd4w0potxBiTlFYJHuShDeA33E2o/OiG
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c4b:b0:3a3:b3f4:af4c with SMTP id
 e9e14a558f8ab-3a3b5ffd784mr89235675ab.25.1728926402502; Mon, 14 Oct 2024
 10:20:02 -0700 (PDT)
Date: Mon, 14 Oct 2024 10:20:02 -0700
In-Reply-To: <f1a79484-2ee0-4160-a2f0-dbfa7b90eece@rowland.harvard.edu>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <670d52c2.050a0220.23975.026c.GAE@google.com>
Subject: Re: [syzbot] [usb?] INFO: task hung in usb_port_suspend
From: syzbot <syzbot+f342ea16c9d06d80b585@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, stern@rowland.harvard.edu, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+f342ea16c9d06d80b585@syzkaller.appspotmail.com
Tested-by: syzbot+f342ea16c9d06d80b585@syzkaller.appspotmail.com

Tested on:

commit:         64f3b5a6 Merge 6.12-rc3 into usb-next
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=16ff385f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9878fe11046ea2c6
dashboard link: https://syzkaller.appspot.com/bug?extid=f342ea16c9d06d80b585
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=178a2727980000

Note: testing is done by a robot and is best-effort only.


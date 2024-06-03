Return-Path: <linux-kernel+bounces-199017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 725208D8092
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 13:08:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E94D5B24550
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 11:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C369B83CD9;
	Mon,  3 Jun 2024 11:08:05 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0421D78C80
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 11:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717412885; cv=none; b=bOFCX4UkzH8G6ufo+SAg44xKt+zLdIdLMaFH/YyPguxaOmmfevwxv969uVV+I6xc9HAEIyJAINFaHgvI8UbvL4pLhyUW1Gnu9H6gXLy0bqMWpyKOwZ9YKq73nlVS4Y9NuDEQ0zPEEixm90W0JAVjABQfa5YXRIS0lJlcC4na5nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717412885; c=relaxed/simple;
	bh=sSnrdm6fiDMdh+mUriHCshz7fel1CQDzhH5UGPn5TcU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=U3KKkXBcf48O/YPJpxBwYbTqcOy37HNcfKuY4vGNdGbEMU3UTX4dgHPVdWWURov94dm+0fpjs8YiuRoz2K6GGJvuSqwVWPijElsez4z9j+6yMNXaPZQMPTOuO4SXrqNBMf5Unk3OMKEk9HU/7ULYk+yt7QOhxurCnUGzVn7OWVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7ea27057813so386878139f.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 04:08:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717412883; x=1718017683;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oKvFpMrg4A8MMwFB/KRbvRNv1mKGfqvNXY/PALqu65Q=;
        b=ng8/Z4YOcMwo6f2OhybdN5RzwkGqcjOE0UE+qZaCg+WSd4ZKMu9KhMHUlsiyzB3cfb
         uexSYh/NtXXNUoLdR92kEgvyDELOTniSL/uAq2x5YtuVj3qJP7i6wUrd3DnLSTAxyQD5
         8wmqaCVG1vg7gs9HN55GDo3ns6ITloGuwbAX+cPZK9nMPhmnOR0feQMUW3mn2DOX4/8v
         aRD6DzoZ4b1rrcZ9zSpeMOz/7g9r1krJnNNvxEZ2NdNwDxprqyRw/kqaL4IbZ1BLFfND
         aXHAzC7xVuJ3KyaMxcRKNAQQqaY2VxnjviSaWvynQbfSR6YmXNsuqGW3vK6nZ2gQDjNN
         2/dw==
X-Forwarded-Encrypted: i=1; AJvYcCXTvNl75d1BEy5mtjknUU9gK/rcZPKjg6l3p1WUIKmnnvurlvGTx6OEjd5Wpk5oIcRS0mH4eOyh59Dflcq1IZyl2StUTWZp9ybfRjiA
X-Gm-Message-State: AOJu0YxVFUc97C3fL94n54kcYm75jGpsUJM0ky/kEqR88xZCP2pr3U7I
	hn3qdzG4wYOKfgztxcVV94rmWNDPn/qxkUUAFf3MqLFA+mapcjRdNAn1dAdNDJ34nesyk7+BG0F
	ok3GbI9atMCItg/yxQo8vSUhiskoBdno5uYv5+pI4FL0PpPGGgiFwo0k=
X-Google-Smtp-Source: AGHT+IGPiEVOmTSdgPOa4JfrnGrlMsd7U3oUjbReyuXn+Abt9k1AH/sNxmNUUo/LBOr2UvbdwWIpvNqTXlcXtHrsyXhVALecwN34
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6415:b0:7cc:2522:f5fd with SMTP id
 ca18e2360f4ac-7eaffe956bbmr53266039f.1.1717412883162; Mon, 03 Jun 2024
 04:08:03 -0700 (PDT)
Date: Mon, 03 Jun 2024 04:08:03 -0700
In-Reply-To: <20240603104211.1526-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d5767c0619fa5845@google.com>
Subject: Re: [syzbot] [ext4?] INFO: task hung in vfs_rmdir (2)
From: syzbot <syzbot+42986aeeddfd7ed93c8b@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+42986aeeddfd7ed93c8b@syzkaller.appspotmail.com

Tested on:

commit:         c3f38fa6 Linux 6.10-rc2
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=12385cba980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=eb72437243175f22
dashboard link: https://syzkaller.appspot.com/bug?extid=42986aeeddfd7ed93c8b
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16784f14980000

Note: testing is done by a robot and is best-effort only.


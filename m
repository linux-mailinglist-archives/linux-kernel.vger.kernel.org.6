Return-Path: <linux-kernel+bounces-397611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C0B9BDE02
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 05:39:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B1BD1C21999
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 04:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2542518FDDC;
	Wed,  6 Nov 2024 04:39:06 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD5F76035
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 04:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730867945; cv=none; b=HItLgZepFARFLpg9Bcn88wioGDsDm4xm98+N0Do5Op+9Nytc8MkdgHarwCqDgbMamMjTGj8M0xkjCr/MrUl0cfZNsH4WSTyoSYAsE+kMS+O3CIURfZCXQZhs7u3o37pFNckOu0JT2I1ZHK+obt1IcUm5TP6zROJQI8NwmVjW8WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730867945; c=relaxed/simple;
	bh=rm1UBE0CqeZHg1Jk4aoaflriHOdb4zRQAcypzSQsKFc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=CWMvbK9bRZT8lVuB/wdS+0BfKR7okrZOGnydBsiyeGDlSrcg/j5iupV4dxP1siI8D3YVIYLxOyBxNxC1qzQ5NweO/WWavoJPoltC9i3pusV7jXTp8OmRZnEI0K961l7mTCIcpJ90CKlRcxc1cO8b+mwekFljBXMjYJrgrDRh3Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a6add3a52eso4638545ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 20:39:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730867943; x=1731472743;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EcZnI7H/Pxr0UqsUJcun+RXdk/Sg3hZT78LKpGEaC0k=;
        b=AcBBrTWi1ZYxGUqBlGXv1et4QSBYcVfOlmSlcvHcb/yK5gYONfYljzmhN98moq06XO
         MPU5IgZpor7jv8WaygsOeLMnSHzMs11ottV0TB+B36ClZ4fcOOI190qfndZ0VYh2jEjn
         sYiP2ZE+3gB7Ug7S4NwkEZZh45MBqJ2s3PqpFB5aWpAv9+UpaPt/u23TG6gdt4hxBw3A
         wtsn6DKPJJijcUcvdxpSNr6C0xlXKgqKfBbDHi2114xND5MTHzMhQTA8xS/4oCMIx5EX
         I/jRD7mY9TUQE1o4M9ONmbWiwgXwMyOv8EQpvNe4md3nYMu9sqqeIt5qIPD8/IVnSXUz
         LMvw==
X-Forwarded-Encrypted: i=1; AJvYcCVIw7l9A7oZ/pP4WmhDlQ3tTB3ZQJNV9P5M9gW9Dh2NLv1E9PCTDnVV1kU2HvYDi5MxcnqucMvECrYYMho=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyWIO2OdR2bz4O3rd2gmQORdVOdXaAMBYL5adLUTbSbDht6DAZ
	UIBpI0P0/OuVhbNEOVTWVLB+zltQLzfP+kMvqElau0vLTxVt/unj7T/eOMMd2MXRg68T7v9DnBO
	mU3V6PfIluD4n+Xip2hpllZTBknfk+7vBUmrAwJ5looBSezT17K4HLHc=
X-Google-Smtp-Source: AGHT+IG4XL9G/ifuAc5sYaDmLvA6D8ZYi4XBYf/FQ5JB1IfTP9XmdheFWB/itY7y28HmblSWCLXzrxyQM6JxrgNj/8hvVYfpnpxC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20e1:b0:3a6:c000:4490 with SMTP id
 e9e14a558f8ab-3a6e2a15bf7mr11210695ab.1.1730867943519; Tue, 05 Nov 2024
 20:39:03 -0800 (PST)
Date: Tue, 05 Nov 2024 20:39:03 -0800
In-Reply-To: <CAFj5m9+1dZtWufO0xzGgWPyMjD1NZ_a-kfeW+Q3ujH_rnR09hg@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <672af2e7.050a0220.2a847.1b38.GAE@google.com>
Subject: Re: [syzbot] [block?] [usb?] WARNING: bad unlock balance in blk_mq_update_tag_set_shared
From: syzbot <syzbot+5007209c85ecdb50b5da@syzkaller.appspotmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, ming.lei@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+5007209c85ecdb50b5da@syzkaller.appspotmail.com
Tested-by: syzbot+5007209c85ecdb50b5da@syzkaller.appspotmail.com

Tested on:

commit:         72697401 block: don't verify IO lock for freeze/unfree..
git tree:       https://github.com/ming1/linux.git for-next
console output: https://syzkaller.appspot.com/x/log.txt?x=109436a7980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=dfea72efa3e2aef2
dashboard link: https://syzkaller.appspot.com/bug?extid=5007209c85ecdb50b5da
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.


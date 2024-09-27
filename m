Return-Path: <linux-kernel+bounces-341264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D718D987D68
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 06:00:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EB242820F9
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 04:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8999171E43;
	Fri, 27 Sep 2024 04:00:07 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196761C01
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 04:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727409607; cv=none; b=cia1n7GIjLs5sxyLdjdqXD9d75wr3tdtBI3ZFLo91KCCAMpYEoMfgA5B4ilrpqkFQ5jn188K2AM9wockqGxy2DW8sA56bqiFjO29kAUPapeVbja/++2FFtBavKC0jCXVacAUEbMliFLH2cPaTaQieyE8+alV2oHZRU/55LfR9Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727409607; c=relaxed/simple;
	bh=RYy8CyEWcBSdrHr/r+lzZm8SfWgstJs2rf1y0S3C5qU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=QsAn8Sn6rMVUcG+iVyB9c/9WSwqz++Xu68SyWZXVErUJomLZpiCyCXblzimb8uPor8ixBP0qyNVQK0SmFWehxCmekyYWSa9eOgK6Zv3MHdJy/c2Y1vD46ld6IG2kmtJ3+VSMho8UlzTz8Ge2ceDbQ1FmD1+krHbSHMNPLgAyHYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a19534ac2fso20768895ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 21:00:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727409605; x=1728014405;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HEAFg3AScnvZ001p+VbgHZ3C1WnEaWn3zSkKleAo5Fk=;
        b=ohXw4VmQMfrRIc0rlnBHJ0kUIbdCOzWkSiHF9YWGTph2j3xYrPAdBlx8SVLCNyhIeL
         6iP6at0pRAq48wMQudlY4ALZgA90U6YFn2kIXb+prmER/Xxq5byBaoKUQquD72t7jrBO
         J1rX2qBMT6/YdOtqyq60caED0pjNsVkSXJyVaUUHwHUDyFAK5+w0sDzM8fv8wxfoac9Y
         1Cm+fNDp5AHhh88FU99cAHBpVfMY6d3WWLz+oDE9TWsp9FUy1ZdT3fj+HuusBU404TUw
         8idgxkH9vnx3O4cmIC9dF7P8hGbXKM3gnSuXopkQodu1Q4IjpC6AiABEotf8fBeMOUbv
         rT7Q==
X-Forwarded-Encrypted: i=1; AJvYcCX8PXsJ5RmUxDZAIXdVBlAry8q56bcXD1r0ToNO5ciBg3xpHMW8srHA0V9RTbPDGyvwPtfoV9hEn7azTQs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3NbWez/xsWn1gm07EKbKThivtkZDjpG334ji6aoXOVTX/ULPg
	sejUFm0vmbBZeO6sqanJPWr5W706KsiZdbTZER48iVigKBSpGND7gKLX2E8FsPhiSgSfYD3+aoN
	NQ9OfRGYI5b3fIFB9feSJpplRzqPRMb6UUuCjWvzs4RCkQXGOBkp6j6s=
X-Google-Smtp-Source: AGHT+IEhQltlpxmQQfXE9prJplXAErwRePVQ8P3vB0aYsuhg6BUT+HwvO8Bdx8qPF8DrOCRSSXoJm6WnoZ5QEzgvzPUsvwGP+sU/
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a08:b0:3a0:92b1:ec3c with SMTP id
 e9e14a558f8ab-3a345161e57mr15643585ab.4.1727409605322; Thu, 26 Sep 2024
 21:00:05 -0700 (PDT)
Date: Thu, 26 Sep 2024 21:00:05 -0700
In-Reply-To: <ff3f13ee-2356-4731-8534-5813800f3757@126.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f62dc5.050a0220.46d20.000b.GAE@google.com>
Subject: Re: [syzbot] [bcachefs?] UBSAN: shift-out-of-bounds in bch2_stripe_to_text
From: syzbot <syzbot+f8c98a50c323635be65d@syzkaller.appspotmail.com>
To: kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	zhaomzhao@126.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
BUG: Bad rss-counter state

BUG: Bad rss-counter state mm:ffff8880121d0980 type:MM_SWAPENTS val:2


Tested on:

commit:         1ec6d097 Merge tag 's390-6.12-1' of git://git.kernel.o..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=136e4507980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6265dd30e362bb47
dashboard link: https://syzkaller.appspot.com/bug?extid=f8c98a50c323635be65d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13564507980000



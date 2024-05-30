Return-Path: <linux-kernel+bounces-195735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A0028D510D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 19:30:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 973891C22BD4
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 17:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20223481D1;
	Thu, 30 May 2024 17:30:35 +0000 (UTC)
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46167481B9
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 17:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717090234; cv=none; b=loe0/CwaLJHIMKidB55pR39NPdpV8aZuxqmyLZjhy+5nG32fIhPUJJawFPC6MzUaPCp9Kp8aogrLOgrQJhhCJ5vlUPrggiXYuQk73jn5Ne7Pr2dxuWzr+UdjExRCJr9ogim5h3cLxPdAc49atGIFR5B5F83Wig3y3bhcqf/MQds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717090234; c=relaxed/simple;
	bh=2CJoXfun/q2IWV/Q3b1ITRNNlJr7ILQ8uLSuWvoWBf4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=i7omQj5cKJUqsZ9Fw81L7tSrrVndQXBCHEw1uN22LR1JDt8ydwoWiZFdY9Vg/X+f50VuhezbklPwKmNYxsGdRDfAxvZPi9Sl+idNusmUD3G2RVDLsYya56vWlTvhqNODKJCQ3O0Zak27H5PnEm5WI1T4ddvEX4ikk8D3BC2yoTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-7ead5f29d93so101670539f.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 10:30:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717090231; x=1717695031;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GnVbsVSwvxQjCHKqcGTUzj8U08k5vYYwUjGeN/tORlQ=;
        b=WvVOfXAzBRZoHECjSwJSXSEt7wirPJnNf6q3jbewhKF0RIWgkTEJ2FfRGMixBIloC/
         cse6jFcN/f6wAnLDz9Xf6sMzLZIrUHNdULQl80V4WkYrHLT608vpxMWYEatcBEuq9lKS
         5xtJdQkgKRcyVAEqXL9kzCQ6AZshvnRwSRcffkJePfr9Fb4iDdp3aekTLNWNbyXICPPu
         lGl98YlIZwI2h36Z0SeW9JX5PNoORR3fhsBpCWst0MeQ2A6qMZNi8bsJQCLrm7Sgg1x2
         N/BFcmW5r4jmTjPb7eFmQ7QEvTzo7D8Ka8ccpZ1fsOj5j/1xI8ZAK+cqfeG+lWXnuucm
         apvw==
X-Gm-Message-State: AOJu0YyGFBh/wTthAgIltwRVQJfPDn/6YiVlQPUSpm98sHqB0L7xhlak
	LHYVFWOCFo2S5KE8/4HnSelJ1hI/FSDdnDt6Gy6++kNAzdg4cAPk19jY9p0jlVRJHSwHOq4lLpG
	od2XFN/i8x7IdIDzlI9ckRAmGDNKsTGmEPWZxZE/OvfKiy/TxxESeBstWJw==
X-Google-Smtp-Source: AGHT+IHD/FLLKRtZnbkGbs+d3R9Wwadesba27m46httEayZ0zaQS/vrfAii1paOjEFIhC6IExh9N56ZTdEw7TC1kRrdkuvaG0eZB
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:9817:b0:4b1:8aa:af6b with SMTP id
 8926c6da1cb9f-4b1e4af177cmr101413173.1.1717090231350; Thu, 30 May 2024
 10:30:31 -0700 (PDT)
Date: Thu, 30 May 2024 10:30:31 -0700
In-Reply-To: <0000000000007a211706185338b0@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000498c140619af39bd@google.com>
Subject: Re: [syzbot] BUG: Bad rss-counter state (5)
From: syzbot <syzbot+f2bbbb592debc978d46d@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    4a4be1ad3a6e Revert "vfs: Delete the associated dentry whe..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17b8eeb4980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bd6024aedb15e15c
dashboard link: https://syzkaller.appspot.com/bug?extid=f2bbbb592debc978d46d
compiler:       aarch64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=114401aa980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=107eb5d2980000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/384ffdcca292/non_bootable_disk-4a4be1ad.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/75957361122b/vmlinux-4a4be1ad.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6c766b0ec377/Image-4a4be1ad.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f2bbbb592debc978d46d@syzkaller.appspotmail.com

BUG: Bad rss-counter state mm:00000000b0f34aa6 type:MM_SWAPENTS val:-78


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.


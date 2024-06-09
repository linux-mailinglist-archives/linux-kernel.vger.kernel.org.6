Return-Path: <linux-kernel+bounces-207248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6055B90146A
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2024 06:41:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC8AB1F21889
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2024 04:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 472A0EAE7;
	Sun,  9 Jun 2024 04:41:07 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A38FA3F
	for <linux-kernel@vger.kernel.org>; Sun,  9 Jun 2024 04:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717908066; cv=none; b=gFzryFNLHzHW/TE1vshlrrIGTPF3bOOpvD9F+iFxg+104LwK+/vvZevGdosCe0xP8m+nTtfQrUnhK6aMWh/7aUt7HJ9YRGoZE/sBG7THP85gRYBZZ2d45fHIuPn1cGQlXrTmdChaht1BTgfqV/rZ6Xy++16t2JiGNR40Vx0BDMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717908066; c=relaxed/simple;
	bh=oMo5GobQXzGdap9s+jyI+tRHo0yyTgD5Mqiv8yRX4LI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=MKf/A0sRztnRQBO3fN9qn+SyzI9UY++LjtEPiHe//FoUn0rArzXQ1SgA4SpYwRG39Swya2i5czx50/XuIhBPqb0Et3qsjpwAoiWm8BjwMrF/j1Uet22d7sjsx/AckvPzk3/VjuvSyDJI1iS4c4kwNpzB+qcQ0iB0xjrrxmufyZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7e92491e750so252957839f.1
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jun 2024 21:41:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717908064; x=1718512864;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=udHkC7tr/aEH2dvdw6F58Ka3OHsdXxA0DzrpTvQWMH8=;
        b=vhKDIE1oHH7b2SJoQvKk0vxjSYU4+ACF1sVf3Cn5bc3RTgFA901OuINNU6J5U7jAaT
         B4lP/hz9lMU7zf6PklU7PBUfysAmh19TsiA3FUR8m7WPdXT4Pr7YwnlltHEUcPjmQlWd
         PxPh7Aq+sWpwduf4PfV1eizUCQKU46cuSXVfs9jBCtEbhADH6SLJameSxuesf0v2ojAu
         gR4hOxkkIj4YVax1yQ8naxIFGEsoEA2/WXMa2ODAhMnc5VDPYoMXVcABRZD7Weo+eSTx
         HdbZDkf4PeNhVusGm9ZaXcLsVkcdjE0EOsY4SsPDhysyNOfuLpL2nzf0ERqdrUYCQUko
         SJJA==
X-Forwarded-Encrypted: i=1; AJvYcCWp5bAtGQitZprBpH0P/W3zR1c+M6szx1doz21mOp5xWI5x+KauxZhaX/PEXRsOEclTWOs9M/YFCldjJ8YdRBIgUUF8/eq+auV5JJEb
X-Gm-Message-State: AOJu0YxkcQWfzEO4plosjM9TJIurnCXY17JpXbZdZUm53ClRHGYg7SLG
	eM9UwWzBseETMgpZZLjLgA1rUU6qEy8sDIka80a/motRO+TKJB2hrMi6ql8Cg/T1iY0rbHfbKrz
	vRoqN6S3BEEwBf+VNM43JXyDEwoppeagwuJxRPmlNKk887oYVprqVNb8=
X-Google-Smtp-Source: AGHT+IGyT5s9AiaNS7J51UeSS7beO4rjaGEKCRuoUfxLu/b/X13e6VfFcMxBwr93nQLkqFoU/yClQLCvfq1VxBeHspq4dYiaTFkI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8524:b0:4b0:d2b1:1add with SMTP id
 8926c6da1cb9f-4b7afec77e1mr280382173.3.1717908064573; Sat, 08 Jun 2024
 21:41:04 -0700 (PDT)
Date: Sat, 08 Jun 2024 21:41:04 -0700
In-Reply-To: <8177975b-7eff-45db-9b4b-4a6d321ac7ab@rowland.harvard.edu>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f225de061a6da393@google.com>
Subject: Re: [syzbot] [usb?] INFO: rcu detected stall in raw_ioctl
From: syzbot <syzbot+5f996b83575ef4058638@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, stern@rowland.harvard.edu, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+5f996b83575ef4058638@syzkaller.appspotmail.com

Tested on:

commit:         8867bbd4 mm: arm64: Fix the out-of-bounds issue in con..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=11f0680a980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3b4350cf56c61c80
dashboard link: https://syzkaller.appspot.com/bug?extid=5f996b83575ef4058638
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=118743fc980000

Note: testing is done by a robot and is best-effort only.


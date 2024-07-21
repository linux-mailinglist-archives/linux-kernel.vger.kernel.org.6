Return-Path: <linux-kernel+bounces-258095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8805F938367
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 07:41:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90287B20E4D
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 05:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55AF2522F;
	Sun, 21 Jul 2024 05:41:08 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EAB71396
	for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2024 05:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721540467; cv=none; b=QehoRFUoEWBBfjZ6vZ7x7FIbPBevnb5BqOZsL22xMKfaP6O2henq8em0bPqJIegej+cQ72ro6ww1NP1GePf7pYgT83dGPhXIXjFv+ZJMx7JXHzQjx1UJqCPpdNhKEQoLggisq7rf/gO8cAFWT1AF5e260YCcfq0dHLaeTGa4pkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721540467; c=relaxed/simple;
	bh=eKkvXIRx9Q0MOXO1EqwH2epjGLn007Hoa8/Kail2N7s=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=SkLqbZTT0839L07UHkfvssO7HJbmRcrMhCgjFpL2lXJ3P5hgvMjJ716a/8kop/ph5iKxcfaH8+sUMdAbVM3Umija7+ZrPPsHsxs1NauyBd4qantr//b6CpkP1L7KVPYbEkgjI9V1+NtHYjCDeuLt98SH0yXPK+vqEmLN4DgUIB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-803621a51c9so540207339f.3
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jul 2024 22:41:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721540465; x=1722145265;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7rIkhlFz4AbSJcAJHXko2zOU2GPENzQaBBg8uYQiqVE=;
        b=eXdNqNZjSsVUPomQ5RgQssqFBUcq7mVlLGE9W5+xHbddbXafAS5e8rMkh3I2iyQPOx
         ohXBUPkCE2p3o+QZNZNTAlX9dJJEOxtsqcuiqXfB2J88SQJWgXcW8pt5P5ar1gFG3OLJ
         KVQf5xxWwEm8dMYov6fpirTtGgej5jnxPqMx3lLadcozKff8x7fxSRK7GGpT5D+p+2It
         kvrHiVxw6FYwEVG23h9fSAX/fJ297NJ5A49sSAwZiEpxAMaB59o7Exm/FcduS8UrxIJw
         r0iixbskRcOysMeQ8qTa92afBFKvw3ILRjyZ5GCKziDvgdYiIizVgaxjO8AFlRwbUVEl
         yz0w==
X-Forwarded-Encrypted: i=1; AJvYcCXZCMEywzvmfmif5avzaZtJY01bFRwqAQrhFw0xxZk8nt4etQdPn1J4wDxwNJkOIWRPkfqrS8mcmX/j2yCMTt0Ee2D9yBF3t7YMOZ99
X-Gm-Message-State: AOJu0YxB7RFWKUXvl/cwSlqj/T6c0jcCXeLUANqZJQ6jJEQXSfzWuGqy
	ZdjTpUpNzQSAZN61GA+ouO7nqQ6PvQ95nbcn0AYjtLPpOCRpCEmpM0vLHHc0NMDPKSuqyBJGt13
	rrQXftCiD0kBCganbU1+6I8Cy/0R1t86FSEJXcZuM9h6M1MPfeI8w50w=
X-Google-Smtp-Source: AGHT+IGTZ1OJTtKYrLtdyJEFMALVL8RJtP18Pd9h1A5mfwil5lam5766eTKGUntJYEQKdl+gTnzNDl5cBzvP/uRiyGx5bTQLgnF5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3486:b0:4c0:9a3e:c264 with SMTP id
 8926c6da1cb9f-4c23fc95e76mr281655173.2.1721540465524; Sat, 20 Jul 2024
 22:41:05 -0700 (PDT)
Date: Sat, 20 Jul 2024 22:41:05 -0700
In-Reply-To: <tencent_864C4BBC74D1772167023D5936EC96683609@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ea1249061dbb5f33@google.com>
Subject: Re: [syzbot] [fs?] BUG: unable to handle kernel NULL pointer
 dereference in path_from_stashed
From: syzbot <syzbot+34a0ee986f61f15da35d@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+34a0ee986f61f15da35d@syzkaller.appspotmail.com
Tested-by: syzbot+34a0ee986f61f15da35d@syzkaller.appspotmail.com

Tested on:

commit:         51835949 Merge tag 'net-next-6.11' of git://git.kernel..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1421b72d980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c1c1b0a8065e216
dashboard link: https://syzkaller.appspot.com/bug?extid=34a0ee986f61f15da35d
compiler:       arm-linux-gnueabi-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm
patch:          https://syzkaller.appspot.com/x/patch.diff?x=100ea8b1980000

Note: testing is done by a robot and is best-effort only.


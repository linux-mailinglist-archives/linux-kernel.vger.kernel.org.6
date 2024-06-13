Return-Path: <linux-kernel+bounces-212538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA3639062CE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 05:40:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD0C91C22559
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 03:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1858C135A53;
	Thu, 13 Jun 2024 03:40:07 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43CCE133406
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 03:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718250006; cv=none; b=HA1Z6a/cwTFIttvh55yMsHnEc926jsjo/ksDKGTc/HeOthmmP+M+eRb9KeYnxYx2oLMAXqSB4sbPlyYUlgQc3UC8yH7D8ltfdHTc64jzPeKh4ggSGr+67lObB+h7MeKaFFv/VlS46Ke4FiXsPqrn0mBxwV15wf/IHCfdVyaSqCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718250006; c=relaxed/simple;
	bh=U8wfKXZ6dXDuTnGtLn+oGkITmPDjqSK9YVtUdYEmccw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=hxMHQ9qsvxwHAolbHeyuu2nUvq743+2lxSk1qQIO7sACK0Xv/Bzuem/IAnPD6VKfcFx1V71yF4I5aXCAZKo16ywXWTvVKXtMNm7owqWG/jA/Aw+Nx8LRhJH2StvqjtxyAdFeHlC3u9kuPp5FipVP3aSo23GO5PIVj7UYVO3OhBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7eb4c4378c0so49519939f.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 20:40:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718250003; x=1718854803;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gwf8U+aeM/znZoLJ/KePv4osrbUt6PFY/I+1iIJ7DYw=;
        b=TvvnvpUYNorKq4abf+lUzcSwQVBMLCx3Vj0F4/lm3T6hEjfiH4ehCfJVJ6uCzKCBNi
         BaYmW6zOnKtXUBMnhyLJak123A/5ExVIWnEp4PYBZODnnhe8XSJ2hqBXfwV9lGcZzz6O
         yP3nSQSkZBk8SpHsUWAWXhOvL5Xsl/FFcuGr10964s35FqVeVnmUo1DBxqsb4I934IRf
         E9YfokSDnpMSYd+O4cd9j5qo9MaoydQj1AKr/Kw61ezXVZ7PvOcXCm4LDStg9FSFYTbR
         gY0CfJs7+HSKXmFGct+cPya6LJ0UK7eUZyA9maj/m7hptbK/DIkB/DmPc1azoiiKkFUE
         Vv5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVi+Vl8eZMw6GjlQUvBx4Mf/YGKrFrj2bc6oLP13J8urvG+9IFQNFuZhXqyDZIcQbGu7emqG/ZocjBBF3NaxXCk9hf3D6rVzDLZ+Vyj
X-Gm-Message-State: AOJu0YwkUGEWiInLDbXLEtZ3CHYx4alfMnA43ZJ0JS0difHEI3TLHyhq
	a56lS7pQFNRATU5xMGSICSS0lOvN+qIxYRcqgRFagFutTn1OFx4drjLxL1qcYUbAS7RUT3a57Bm
	G/0i/g65VW5vG708guYtB2xc1YjvJuBwjNncN3StHjDnH/MO1uiD8qGQ=
X-Google-Smtp-Source: AGHT+IE2dSvCixNi5QNUPAzHQTktaN00DZRyly7IMMNum1otnzGQYkd70dFBmlq6wef7VaY+UUAJd0mRwmJPGOVhu/1ngJbXFG3n
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c54a:0:b0:375:88ec:810d with SMTP id
 e9e14a558f8ab-375cd238b0fmr2195325ab.5.1718250003518; Wed, 12 Jun 2024
 20:40:03 -0700 (PDT)
Date: Wed, 12 Jun 2024 20:40:03 -0700
In-Reply-To: <871507d8-b4ff-4af8-8bba-9a3149c41e8a@rowland.harvard.edu>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000186749061abd412c@google.com>
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
console output: https://syzkaller.appspot.com/x/log.txt?x=179339ca980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3b4350cf56c61c80
dashboard link: https://syzkaller.appspot.com/bug?extid=5f996b83575ef4058638
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14ad2856980000

Note: testing is done by a robot and is best-effort only.


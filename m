Return-Path: <linux-kernel+bounces-288597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 408F1953C2F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 22:53:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D07E4B27B5A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 20:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5383214B965;
	Thu, 15 Aug 2024 20:52:05 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9E61459F9
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 20:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723755124; cv=none; b=Fm1LhJT6yrMEJtYzHzM1dQ88cScETrh8rVVtHbTMiUZKWNVJoKisaWNIM128/jaqUxd2+TlQciBfOshfKwfPJWbJGdF7QjeeGyS0yw6h/TXUescHyDES1J2lqzG9sdYbS93lLBZakYcCpa9ZItfEDGNPwR1ecE5HBBZTUxJ7VNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723755124; c=relaxed/simple;
	bh=rd1Cnjg8HqvTRUrkPSu71JAx37ijk2fo18kKgdeESyM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=geK/CvREhHJid9keuiaDaPDPpYullsg1t4yn5nDe/NJVgMDAJmsmTU7IvdzlPh/C7zfk2TQgf3Gj8YuUGISX8dm8bYBfJ1SaLjfnoGTFZy8u7A8ExIKdBx8CZSm3zZqoBGsH7toisl/7kLeuY2MmHv93I7FMhadagSVXnOBIL0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-821dabd4625so136601039f.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 13:52:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723755122; x=1724359922;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PmfgG2sEu8+G2CG0RoP+yWQdYWCMeIH1e2ClrHYdhNo=;
        b=t93WmpmHgL+dL3a4JM21gEKdPDSW9GnFrMWqDI6bDFNJINQi+Z+PDAoFyHLBnz0ypN
         Ac8bMt6qSCHw0DPdpSEKHZgA7r7g752Wnlc6mQZTP/0S/hiXI988kW2DQ5ZOvl9JrsJx
         4/KEOxH9GKLYA07qe9dRBUhiCij0Yuau2UPREf6VFyac+BkxHxNpW5kuNjE7IHWCmwxW
         byEVY2npWdpAekMS2Nn3SpeYKgFPc+jE7QyZXBb/1gxD9n4Cicm1iG5e8XI1TIDs8P6p
         S0gjOQ1+55epKT76vrAQIEermne5VkUzPHN8gpacd2uGjNW1noy2Xhg1qaO8HaOT3/3i
         Obyg==
X-Forwarded-Encrypted: i=1; AJvYcCU3RaHo/nQz/ijGvQZDn7G5JWpsnH1UUIjYiqx35DFrq/3YLJt6LCk3/HtTb/cqCLJYCWZCazLy0ZLi3Jw=@vger.kernel.org
X-Gm-Message-State: AOJu0YycmaDCh0ki1e4oT/i4r+Ezakz9NjD2xonKAW27smbfA+SIfXPH
	xmWptmv9JVEq8v5Bl+mPG2dmSxqojblIqeWhAg7nzQ3KoHGreaZtWMoCv+aF7I4t6nsDJtLgIEl
	HZ08DB06kHWUQCSLtv8il1aVKZYrL0Nshd16wVqDScVV9sDJ1TFZxvqQ=
X-Google-Smtp-Source: AGHT+IGs7lknKx7FKGwrwcQBq/RTU7sOk433dVOXfbde2SVdrkw8EbZkPKVZznsNhq50/MdKqJG7u++q10YXlQD/zoZGK+6GjHrO
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:370f:b0:4be:d44b:de24 with SMTP id
 8926c6da1cb9f-4cce15d4602mr24400173.2.1723755122515; Thu, 15 Aug 2024
 13:52:02 -0700 (PDT)
Date: Thu, 15 Aug 2024 13:52:02 -0700
In-Reply-To: <20240815200058.44124-1-kuniyu@amazon.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c1f1d4061fbf03cc@google.com>
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Read in kcm_release
From: syzbot <syzbot+b72d86aa5df17ce74c60@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	kuniyu@amazon.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+b72d86aa5df17ce74c60@syzkaller.appspotmail.com
Tested-by: syzbot+b72d86aa5df17ce74c60@syzkaller.appspotmail.com

Tested on:

commit:         9c5af2d7 Merge tag 'nf-24-08-15' of git://git.kernel.o..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git HEAD
console output: https://syzkaller.appspot.com/x/log.txt?x=1643f583980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=60413f696e3b4be4
dashboard link: https://syzkaller.appspot.com/bug?extid=b72d86aa5df17ce74c60
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=123cfde5980000

Note: testing is done by a robot and is best-effort only.


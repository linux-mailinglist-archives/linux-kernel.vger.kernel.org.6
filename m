Return-Path: <linux-kernel+bounces-177452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1934C8C3EF2
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 12:32:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E58F1C22CA3
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 10:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 831D51474AF;
	Mon, 13 May 2024 10:32:08 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D004437C
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 10:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715596328; cv=none; b=c7JPetvd+UY4/ZV+bnHDoxYmLRrPH8Y3thsAq4NAJIbgEQtAZax+NM7tnv+6Qc4DghYcKRMA3A99+Q2Gp2SBiZkzuRCkGIDjBaLQ9QFP4HWUFR419OLMmeMicvZmlT4ILqf0YC7ER4PeORLKMR8kx2ojsNT5bCpyXpZ7QWNipIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715596328; c=relaxed/simple;
	bh=DcufWOW1bMVSItTyucsTs5kKa842JhOM6CmqcmYflXE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=mf2uHnrXm2BH4HlC3FhxtQRFgCC0IzkXxxaQqhr6nIYadyYixQ3PvpEHHP/PpMS36nMF5DlJShMfs/G/SfhfC82rdDeZSLUUM7j+L3EC5QO++vtxmBpIS40cP75U6iuzEYApH83yI7MwlTHrrizb49KbZJOy0jUXgXe1PDmBL0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-36c60af9b4aso54543365ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 03:32:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715596326; x=1716201126;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/kjlWcI9+bBSRYC0OxwKm4yaxqKrE8qMEH2P7xNCpKE=;
        b=QnGneqPcCR4CWc1O7Oi1NXDPwlx+Wl5BY8P4+LQBEfj2KECpoxatcDsuu354KiQC9B
         KMpomqGwWurOKYAFxuHaQeQb4kBdyZs3yAvSYI5/7C5nmXhzIjYaw9IMB44/tecT5JQG
         W7x6tF6geqjzmMw1eloXYVA9g5ADJM+5/zCc7wAKvgA56QR/nTRf+VAX4CVMt/Z782Aj
         O+X4NCeYzNWNlZfjfR96s0/EKIKQy0M6kMjFQBNIW8gXt8PE7ozkx3CvWWCpcSaydwdz
         pymo33I93+y3AJlaxPLhqXEwui4Be9JZXMQprQ4ex6IV0qf8rKDpqzogM4NqlV4iCaIA
         dIBg==
X-Forwarded-Encrypted: i=1; AJvYcCXR7rPpGOh+aK9NvKzH7ArWdXj2HDt4OqQBS894IM+W68mi4vNmG71NFmgCDmrIG0QlH7jne8jwWcGVkhRNJIxEFnuROYo8HZgR+dKz
X-Gm-Message-State: AOJu0YxB9xbfI4wRXc7/6YDvsuYcvrpAueK4QkB48Kl8ABp7c4h3vAH3
	p25Tq7KnVhQbxkgH256F6EfnPKdQLT0EOJMoynCjoNKNYmzOK8LowCApANeuPChC8SHmyiX8BW2
	E0y0P7jZ/xBG9gJL7KlDwyAv74JlB9scUVstkAoAvhAPu4OpqMQGUEXE=
X-Google-Smtp-Source: AGHT+IFdtUpKMDyY9PImokR9PYPftsCwIkoVVWCGREK0FZooJzcJBe/Xu5MR/UHfT5cSBnpZSq2i2cuzQeTvmAUhTYF5MbKXznrc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2047:b0:488:75e3:f3e1 with SMTP id
 8926c6da1cb9f-48957eabe93mr668050173.0.1715596326108; Mon, 13 May 2024
 03:32:06 -0700 (PDT)
Date: Mon, 13 May 2024 03:32:06 -0700
In-Reply-To: <20240513100450.GA19654@breakpoint.cc>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000988dc006185365c1@google.com>
Subject: Re: [syzbot] [netfilter?] general protection fault in nf_tproxy_laddr4
From: syzbot <syzbot+b94a6818504ea90d7661@syzkaller.appspotmail.com>
To: fw@strlen.de, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+b94a6818504ea90d7661@syzkaller.appspotmail.com

Tested on:

commit:         5caed4a4 netfilter: tproxy: bail out if IP has been di..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/fwestphal/nf.git syz_b94a6818504ea90d7661
console output: https://syzkaller.appspot.com/x/log.txt?x=12dc507c980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3714fc09f933e505
dashboard link: https://syzkaller.appspot.com/bug?extid=b94a6818504ea90d7661
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.


Return-Path: <linux-kernel+bounces-203364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 845718FD9FA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 00:44:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0339DB23F11
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 22:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A0915FCFB;
	Wed,  5 Jun 2024 22:44:06 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684C4621
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 22:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717627445; cv=none; b=nk13dhmaO/A1ZgqfBWqZucIaimPkGmKUB9I25S2UZyLke+1TsstTNKXzT6zOKU9MUaNcQKvMS7HXRTlVjJ6ZQWdOVl97TmTRiVmulCa/81gsk6fkNbcJt2YBmLbFkvYideSD4+LCcbgXYnbOpDOaAcT0bHI4ng8MTHlt86jkHkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717627445; c=relaxed/simple;
	bh=ORkcv6Y9n8Es0E0tHJq9resD537oIxAPE7iC1U0RdaM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=UCDZquQcxwK//asHUv8Et3vXdaRyfVAOngnMoTDz7BMZ/hkyIsyqOopoSd2aUYFOPycgISTvpqNbI2yeG/i8UZV1+NUjf4mlAVAYBz9vpGtDwAZulk+O8Z1R7Ug7Sde4CHruBcWdAOKrtgb+EJyYWVkI5/953OwHB6wmAc72hy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-36db3bbf931so3571295ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 15:44:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717627443; x=1718232243;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=24sWgQ1RjDLnjXZVFazJO177TDFGsgIttN+V3lSGEqM=;
        b=ESk5eJoSUn82qg/5nCQvivsSC/5ftbQH89oKR4luLRuODEklj5KzF4kUXLTjsRmkDb
         FWwhuQBl2RQFZDvuoW0uzrPDkuw4wRTKJ+uwOrKBe1XsJDCPEk1Rhe50+ESz2I+nBxZg
         9UA9UxSz013FSQVI8xuR2T02pck+5Ra4uEbkQ+U4M5jjotBQ7jMNKOYLIr9igFYzE1Pe
         IyeYypPM7qCpY7E9N4MtyypPBoFlUQL7+GelwzxLWrbiiiY0N0glwMrdEMFEsliK+Nyc
         t2A5hmg1PvjSnicvClGkwqwvD+2YpI2a/au4H0KIdpzH4FPpZw+BnxVkDIuypAdIJKtK
         S68A==
X-Gm-Message-State: AOJu0YzV7wJGd/fzKo6W2k7uLs1kwcbvw0AlneOHBlD5+lZOkMHaQIMa
	bXeeGTPpIWlJJqo9+yN8hz889lORiyBwQ0zLJWPh4sc1QfOXE614phmcyQ7Gd/KlmJyrYDtiAkg
	BiQqkvkkr1Br0zM7MLpTRLvmp3c6VlleeZ4yOoAy2J/0GmFxXomx8qy8=
X-Google-Smtp-Source: AGHT+IEfbr4R7hJ85Uy1QsJto/6ESTCgjFFwpJbbaSPefZmWisqwC3EKUSpBAO9Kii90HBZRCvrSIhWgKbKPxXowguUO66BqHmU3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2141:b0:374:a76b:2c76 with SMTP id
 e9e14a558f8ab-374b1f768bemr2508935ab.5.1717627443689; Wed, 05 Jun 2024
 15:44:03 -0700 (PDT)
Date: Wed, 05 Jun 2024 15:44:03 -0700
In-Reply-To: <20240605201642.199699-1-norkam41@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a34c36061a2c4d76@google.com>
Subject: Re: [syzbot] [ext4] KMSAN: uninit-value in aes_encrypt (5)
From: syzbot <syzbot+aeb14e2539ffb6d21130@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, norkam41@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
SYZFAIL: NL802154_CMD_SET_SHORT_ADDR failed

2024/06/05 22:43:18 ignoring optional flag "sandboxArg"="0"
2024/06/05 22:43:18 parsed 1 programs
2024/06/05 22:43:18 [FATAL] failed to run ["./syz-executor" "setup" "fault" "binfmt_misc" "usb" "802154" "swap"]: exit status 67
mkdir(/syzcgroup) failed: 17
mount(binfmt_misc) failed: 16
SYZFAIL: NL802154_CMD_SET_SHORT_ADDR failed
 (errno 16: Device or resource busy)


Tested on:

commit:         45db3ab7 Merge tag '6.9-rc7-ksmbd-fixes' of git://git...
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=15a9ec0a980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=617171361dd3cd47
dashboard link: https://syzkaller.appspot.com/bug?extid=aeb14e2539ffb6d21130
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10414bc2980000



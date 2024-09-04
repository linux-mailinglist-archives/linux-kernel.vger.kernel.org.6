Return-Path: <linux-kernel+bounces-314832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C895396B9AF
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 13:10:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 727771F2303B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 11:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F27AF1CF7B7;
	Wed,  4 Sep 2024 11:10:04 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4550C126C01
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 11:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725448204; cv=none; b=MKT3eiNN+PZZ6uRQt58ocDwSCkSTwMf5P8EEZ+WTIX3ruBwC3IuqxARcemrO3C+Ax4nYn80bJTOhmR9VNtmIzbKjFPN6GgEW025Wn7/O46oxiUHQ6Gd/rQFjnt+px65Cw6TpcgaUjzGctd/p1R4FtDburPUgwNhzdK7cex8KBpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725448204; c=relaxed/simple;
	bh=w0dQGQQUpRLP7MPthQQR2dU8DrPpnmEoi03kisxqD5k=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=hCwSn3jdAVE8SPc4ryALywN0+xBa2TdlES+G4aLPfWl6isrE7SSjDf80D+vLgEa27IP3oLZCYsVQTTEDhZYrF0vDI945EdfPxhAaszBDaPKDg4UYGhqc6zaLpO5ErsYAjUbgIQbmhnbyey+BnU/ZyVayo6UJTQ9BFuA5VPHs5kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-39f53125f4eso36257365ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 04:10:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725448202; x=1726053002;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VaZMCWdrGYPm8RSJkOpx3y+vWH88P/t0e8HfUbr5D9I=;
        b=aZQQCXJ+yHAAnB2aznAAQcP2IroBSBphnmVOKtKX2nhMTKukLzWWh3fAf1ipcbG4Zz
         kiKchTctm/tPWjxmx0TqQSb4w+THgUf078x1CTfA7yuDV17tRq0Eh76fufHwcfylOzX9
         jXHh0YS7FU7pgOlEum1tViITtKeXoV8LZShs5pO5irkkdMZ+0tl1B2XoXUcQuHUCJdve
         TuwyegPloNgXC0R5AbrpPSsZKANwlWXDvW7A3KaaeCmCALYudKReLOMmvqizDY7hzuGX
         hVGHRNrrnE7FsoPYjWbol6WCnevVpcC0ikv9Wve63RK/b2JR9KDF2s+uUv9fSbCqKJq1
         P+Wg==
X-Forwarded-Encrypted: i=1; AJvYcCX6bWpxNyHdJ3JRD5UW5fThvcDGdMUALVfY86zH6nTl+om7FcnFHd3BzBami8V2op5qhApyvvgKaObdP0M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwP8+sTlKkwOmegajvn8KJs85eKfEBOB+iCrrtGOB7DCoRlasxH
	T1xVirXXuzrh7VBmAjOpR3h+ZSJSJKJGnWstj73UrZ/y1VJ3NJvIyzFMWkc9vBdyuE8XISmmab+
	tE66y9VHBN5Ha8RPtTu2ZppB5JlzYTGW1F5oSMbmAfGxBE4YI0wwjyEs=
X-Google-Smtp-Source: AGHT+IE1GG9dW+hCXGqF41Bov8o+oJLZw4qyTQaDiaiT0cSofS2o9M2++pRqA/Z9wB9jhC6+jnGqyAc1ytqk2hg2XIQuOrIJOsZ1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d87:b0:39f:549d:e39d with SMTP id
 e9e14a558f8ab-39f549de612mr7178655ab.5.1725448202286; Wed, 04 Sep 2024
 04:10:02 -0700 (PDT)
Date: Wed, 04 Sep 2024 04:10:02 -0700
In-Reply-To: <20240904104423.1852-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002d0b9a06214937b9@google.com>
Subject: Re: [syzbot] [wireless?] INFO: rcu detected stall in ieee80211_handle_queued_frames
From: syzbot <syzbot+1c991592da3ef18957c0@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+1c991592da3ef18957c0@syzkaller.appspotmail.com
Tested-by: syzbot+1c991592da3ef18957c0@syzkaller.appspotmail.com

Tested on:

commit:         67784a74 Merge tag 'ata-6.11-rc7' of git://git.kernel...
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=13bc531f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=660f6eb11f9c7dc5
dashboard link: https://syzkaller.appspot.com/bug?extid=1c991592da3ef18957c0
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12cb3163980000

Note: testing is done by a robot and is best-effort only.


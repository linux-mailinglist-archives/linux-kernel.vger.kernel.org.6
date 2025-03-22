Return-Path: <linux-kernel+bounces-572180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F13CA6C7C1
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 07:02:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 001B23B98A4
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 06:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62A06142659;
	Sat, 22 Mar 2025 06:02:07 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064BD1EA84
	for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 06:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742623327; cv=none; b=spClJOSz+zjC5duo4I2IbBIZcq9LSBmrFr49OXpg0RD++hx/ShyE6JlPzkKFcnHl37bcVs9RgI0YU2c0eBVCOkizy7YrgSE6SYKBq5fgj1edn5+7L3M7M5xD8D2P2y2ki26s8tryLIAuHBjGa1EXOZiao8BP1TZf0tTSCJEZ8xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742623327; c=relaxed/simple;
	bh=VDmG3BaVuJdYG70uwLgQp6Xk/LoJnrt9nZbO9Y5+VDU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=g2azMSAg/LoiDq8qg6JHqAU8QIj6s1dzBmV/32NwLH7oUa1NHey3g3/2P0mMNtFwZpkvxv81PM+HgxaulxuszP+IVu8vIryck7UFjhKsVemp9wIJT1NH16heCxd+yBFvVjbp4g3i5laguxQCDGMkWT+P65Isjx+yOD0de7CoJr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3ce843b51c3so68966845ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 23:02:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742623324; x=1743228124;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JMmjYKUph3vkLSANXC6jYvrd7AxY0QXJUkau12p/hBU=;
        b=FFs6PQv7LNbYqY/tzLh6ppwvSf+sG57xT4Y91uVpe4t+hotlXKFcPPqPozoc+vlvuU
         xWmmeJoR0ZOXB34w+ji34ly4tHR01NWHIkJMXdaOjsBYBiQgx13GYoZsFF2F14rJmGBI
         ui6gmpFaNhGDlpVi47wBf/kZJWfSRngPAcGuPYZDFMPqOt8C9ycSO1JbnqUkrjGqoZLT
         pg12WyX+rmg6vvG0e9Nyw8UpofnwN2wYcFG2nnUlmj+iziGZqlTA+iyjofmS0TMHUyl7
         +mQF1voWrCNcaDMelEYJNzuBPM7y86GDCN6hkbvsniW1nX8YJG2GRhn4y55ecAUTgvOd
         kOQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWohPcYKn2MUjtxCTqFkGDX5l9mk1Zd3Vkf39YUmJ+AYrtYrMdt0TTTEipisQDkpydGFmMuOAZVL2YYhaA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIwmAqlUeU+5Wtt2LBmIFCQWUNgSxokhz+sBXiUEarmZY/bo8R
	d/6Iw4naHsrBhH1j+3Eo/13ATTabCCXVSi+7f3+WU8mbgLP7wbZP/9RLOL4vg/tF+lowM0t7E4b
	BzW5pgLRejMU9kZN8HOdlum4OWmA1757ipEcNlNYl/EAWWiOMqRHkgss=
X-Google-Smtp-Source: AGHT+IEjvThR1pIMZ6p0EHX6N4U1vyWODQTERw7Ohdxk00DpRA/Wamfb+VS1HQMbSPu253ReC6aUwlfN9jzKY4D/PfIECxKQYp0p
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:320d:b0:3d0:4c9c:965f with SMTP id
 e9e14a558f8ab-3d5961cb4c7mr79589245ab.20.1742623324086; Fri, 21 Mar 2025
 23:02:04 -0700 (PDT)
Date: Fri, 21 Mar 2025 23:02:04 -0700
In-Reply-To: <tencent_688C7427774F66123C313646971437C04A09@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67de525c.050a0220.31a16b.0029.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] KMSAN: uninit-value in _find_next_bit
From: syzbot <syzbot+7ea0b96c4ddb49fd1a70@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+7ea0b96c4ddb49fd1a70@syzkaller.appspotmail.com
Tested-by: syzbot+7ea0b96c4ddb49fd1a70@syzkaller.appspotmail.com

Tested on:

commit:         88d324e6 Merge tag 'spi-fix-v6.14-rc7' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1316043f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1d4644c4063c5098
dashboard link: https://syzkaller.appspot.com/bug?extid=7ea0b96c4ddb49fd1a70
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12f2b3b0580000

Note: testing is done by a robot and is best-effort only.


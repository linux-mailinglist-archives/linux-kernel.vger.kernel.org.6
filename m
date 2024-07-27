Return-Path: <linux-kernel+bounces-264296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD63993E167
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 01:03:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCA7A1C20C1D
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 23:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F1CE41C64;
	Sat, 27 Jul 2024 23:03:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DCC21CFA9
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 23:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722121385; cv=none; b=W+eC1iGIQ90CM74aFWlC++9HCufePbKMqjwwLrcvTMU9cEs9bqF47lmn/9mmX+uPZgjGMn5IWxmaWUhZwumNmIqM5JXlEjfsgz1LYXKbm7dAJPS9dyuGXRk4z8b8E0DJwv4OjFTlW76iU4E38JbveDyfoqL5JNjFKtH8elyF+KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722121385; c=relaxed/simple;
	bh=CnrOS+Hh0ZbfN/lKTU1DtwZ/j97wPbixsjOV6bBxGN4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=RENYnZKN+BnjCF85/Fm5kxF8/Ch8tPQcoaLIOjIfRvw6YwFN7m/FoQ6rvMTcDc9rdAdnn7llUi9uINleY//yEhlLkZuFo6Q7QIlR8X+85WGSTJyCmETRoVJZy5zg9Y6NGvUsLMfpx+PUkRwpsum/3404bbTKkT+dUF9d7kgGMrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-39a1d269982so48641835ab.1
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 16:03:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722121382; x=1722726182;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Eo2GFGki5sxUGcDUKnzDDzv1+gAEA2AdvOHA2mm8kpw=;
        b=aUyq1fMY4vMMP7IrClLL2teNquoYl7OfD2rdrjjgnGKafsZoe+ZeG5a4y8RmowHApv
         XCKXtXEIZzRH9wG1grp6KfWL2/xNdSDVq2qNBY7xDZK1NKcgNzkVM5Q+ahNMivm+Lofh
         IcahSpQ72Id3qF9r8xlS7ghEvnlPslnWHZcSvM+q84x7Jm0HGcAeBriabCv+N6z/+94E
         MqA0y7arE2qtOVXgyjAiaVHmeMTo5Dve0ARPnum30ntXzMS5eC3Ck/mw0a1vHYg8dSr7
         PxCavSMw4mTaWpt7ZtLTkMua1kvF/8+yZlry34KlWK0gLqd1VNK8MHYeDEF9lDCKyz6C
         frkQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHJMAdGEpP6NoNq80nm5ZSHh4FAMOffQG7F5PKp7sz4jJO4+i0v6fqQrB5dicZSs54wl+lr47oWRGZTeonEMuZpxifAvSCa6lWNk4S
X-Gm-Message-State: AOJu0YwDSYHhGWTddW8Jvr0G+Y9IGatR5UEFX+S/7rkYZKp96DeKAUfx
	alAXpUhT3HvJXcUWdrn7BEdhkyi/3lVAL4XjtzwWSmulNHu+bqOzSENplE4dTnKzhtCectJkpoS
	dqFcCL3qGjvcvv6N50u3d/nqgtxkIVeitqv3aGmYq8JBzrp4H0Pn4zCU=
X-Google-Smtp-Source: AGHT+IEbW7zPLMZv/9p7FLHWsK1KfzQRKBd5d0msWvku5crL1hjwyJcq3/r2RXq7AOGCzSRKBZ9GAgRJNXUMVMlPQ7vy7Tey1erf
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2145:b0:380:fd76:29e4 with SMTP id
 e9e14a558f8ab-39aec419cedmr2439475ab.4.1722121382663; Sat, 27 Jul 2024
 16:03:02 -0700 (PDT)
Date: Sat, 27 Jul 2024 16:03:02 -0700
In-Reply-To: <20240727224040.2248-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000462ef2061e42a15a@google.com>
Subject: Re: [syzbot] [ntfs3?] possible deadlock in ntfs_file_mmap
From: syzbot <syzbot+c1751b6739d83d70bb75@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+c1751b6739d83d70bb75@syzkaller.appspotmail.com
Tested-by: syzbot+c1751b6739d83d70bb75@syzkaller.appspotmail.com

Tested on:

commit:         2f8c4f50 Merge tag 'auxdisplay-for-v6.11-tag1' of git:..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=14ad359d980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b698a1b2fcd7ef5f
dashboard link: https://syzkaller.appspot.com/bug?extid=c1751b6739d83d70bb75
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13533503980000

Note: testing is done by a robot and is best-effort only.


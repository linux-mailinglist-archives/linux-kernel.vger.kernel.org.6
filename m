Return-Path: <linux-kernel+bounces-411593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 031299CFC95
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 04:28:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 894FB1F2420F
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 03:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB7D218FDA5;
	Sat, 16 Nov 2024 03:28:04 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0336033EC
	for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2024 03:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731727684; cv=none; b=Omi325MHOoxIdgHKKK/jbhXnIGv9T9Z0nWCpcH1IpiixQqkTn4I4iXswszuajHvW8TScmmRW88kzwvo7zPGw9WIRJXkU5yyELhpiKHRdexULJLtDppgI+p5pc05VSt/QUrj8HQOeju9uILNY9QsbJvqpejfU8PLxL00i4ZkGgFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731727684; c=relaxed/simple;
	bh=EbXiYr+cU82nnoaNFcqfkYGGHPy+s8xeT6BOKorsFi0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=oW9wIgbJDILLpqQ19eWIPu5G4hQ9lGBg7mRg46kWvT88LAOIgsyQlQOgnzyT1ND3GejX4Zl8/N748R80iK5pAsK3j9HJGGNXNWY/L1uvZTYMvfqxoj/eS6BLNDcx9jRYxElbwfrfPdqQnLYla/iWW9/lEhKg2znwMKqFB3taWZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a71a9ed154so3770505ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 19:28:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731727682; x=1732332482;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qun1Ml3PfghljKWRPaaiQ4r+b19k0kGl7DSEIQtBt88=;
        b=tzHtpZSCKU3ZklCK4kqxxaZGXBnZYOfHcIVVwJZY9tkUPc67LnxEie+okDRcWivLJp
         YvXTThtgyZ71SzmnLdhM1i2+pMaYE9lzwEIMLd9CMO89EzDG37MNa295Sf0pr7UI7Yj1
         C7kAjy+4sVIYsCLGsZuZduVXHJAGlb1DUN7PXaqv2g/50o55xnFXkGzuKmlCOGl7aVep
         wggbum4+1H7AbCYj/ZLdelkaQr99ZEY+23U3yKSUWdeYpqSTw2u/7ZJRZwBIsScyLDgb
         fk9K///2xhVBC8b63ofpl2nxSmlPJsne177Ia2e3OwyvIs3Yxfs5cVNJS7WP3OAgn2IF
         VOsQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0c6DoLEVSLl6THWI+/2e8D2uTJz7fzBpaT5drFbNoWWP0Ew9WzK6zLCqfCQvzaeddu9RbEmyhbWZPyfA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkR55jhfuPIQs5rbpL3gQdhYTCM3vsHGIFVxYnEScgL+Vr6o4Y
	rf/QdPNdwSYW5fUk4Vzc1By8hM5N0yEB4RWyM8lez1fMA+vj4B8n7Ugtyf20I7YpJF+CchUAKX8
	Xt89uuaSlgDf0JT0K5XZnk9ljS9Go904X2oEt8m62m9mjDNb1LyUtt/A=
X-Google-Smtp-Source: AGHT+IGSCuC15zzCDaSO20SDTElbfF/LaiBjWr9fihytA7ZWK5YGfo6YO3Fh9fwMCW8CtCPip6PzLBs8K+4BWKvsF/MdnecZ0d72
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3083:b0:3a5:d2a:10e0 with SMTP id
 e9e14a558f8ab-3a748002e1bmr60439865ab.5.1731727682272; Fri, 15 Nov 2024
 19:28:02 -0800 (PST)
Date: Fri, 15 Nov 2024 19:28:02 -0800
In-Reply-To: <20241116030012.1036-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67381142.050a0220.57553.0044.GAE@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in set_powered_sync
From: syzbot <syzbot+03d6270b6425df1605bf@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+03d6270b6425df1605bf@syzkaller.appspotmail.com
Tested-by: syzbot+03d6270b6425df1605bf@syzkaller.appspotmail.com

Tested on:

commit:         2d5404ca Linux 6.12-rc7
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git v6.12-rc7
console output: https://syzkaller.appspot.com/x/log.txt?x=16bed130580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=db2ecab25173dcef
dashboard link: https://syzkaller.appspot.com/bug?extid=03d6270b6425df1605bf
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=176deb5f980000

Note: testing is done by a robot and is best-effort only.


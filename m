Return-Path: <linux-kernel+bounces-516391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3BFEA3708E
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 21:18:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD1347A21CE
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 20:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3D99192D9D;
	Sat, 15 Feb 2025 20:18:06 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7DC13DDAE
	for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 20:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739650686; cv=none; b=c68iQTTGgrkCfeEL42ksDVWsJw9sr6B5E4FZp7vpf+5PuH/42IRs5iTwp1FyI0gSa1Yz7TfvEvECscQ7iAqIQDDjzbk33PogFEbjd207iFZQfrZnGJ2aZzGuqiOzEOZvL8UPNE1EUUWgnsDSGK1+n9s93GcFuQDUDiH05L8cIkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739650686; c=relaxed/simple;
	bh=T1RlaPLgOKnZs+TtkLT941P+e+kfvtEFVPD4TSAUTJg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=RE+E8LBxcuUFiWwkp93UNg5vQabjjksJoJHE+NSma/H4PnkJM9wOV0E1SnnNOBX4DMIaPbNtH+JKk6UAfJJWOhyaytgu/F0Av8niktTfGJd13yFtIAuoefgOe+pWEsvRE51OTTjUZ1jdlsscZPRkCkyOGy4X5ABK9kSc1oACguA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3d190258f86so18375895ab.0
        for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 12:18:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739650684; x=1740255484;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L5a3aMOuE8lfeTNOP5ZUCE7S+Rz+mbUgxLBgbxASotQ=;
        b=ULaI9xMNtEJdkE7hh8aZpnirxeKFKnaLfYa2zr0um3nGxA6oVjYxYnJAO+sFiH0pgI
         yUbi3osbKgpyBgU26Np1dxLbfd9BHzGPGoRiCymWQ7/nQ02SvUnLP8FRo4YHbBZL8hqz
         MPYbOeL8VNQnkB84MKKER0b+7Wvex0I6PPHTwlOFELZ4t+Y98JBeZZh7j43VYkK0oapK
         I8HbEOmJkumk0dFS3S2r9d1KW4GkiIMHqY/S8Q3A+igjBLYhx0+mYsd5bxiyFMSRZcr8
         TWijUVSQpU2zBwEIdLLt21d700elgZBxxiONgOrFLOwIpb4HyH0C6vD3KrtxMe+63vw0
         EqVA==
X-Gm-Message-State: AOJu0YyaxEx2OZaXZcCTNpB+lylp34d5Uny7AGOa/cSC9slChpo1lV7x
	RhvpS6c3N03t21qSJo6OhgppHAcAPlCsbUle4HmOviciwEuqJhKE5DmmPg66d/D9D8no/LmFf5p
	0F9PsD4ugjOWaduoCJ30kMkz9i8dc2Vz84zxAMupKWOeVke7agQVH9y8=
X-Google-Smtp-Source: AGHT+IF9JV8w2vxcyWDaPR4fw6x9CRt5t2vwblL8c9HLbtWrO+iePbI+RrwUTYR7v/4lJLYAi/43mhkXXaxMwJEq+VuSL63vCKkI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1487:b0:3cd:d14c:be69 with SMTP id
 e9e14a558f8ab-3d282029e71mr23662265ab.11.1739650684281; Sat, 15 Feb 2025
 12:18:04 -0800 (PST)
Date: Sat, 15 Feb 2025 12:18:04 -0800
In-Reply-To: <CAMp3bLX0CeGa2+3=PzJGWqtsifVqMeA047E6uWtdU0Vi9c2Kkw@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67b0f67c.050a0220.6f0b7.001d.GAE@google.com>
Subject: Re: [syzbot] [ppp?] KMSAN: uninit-value in ppp_sync_send (2)
From: syzbot <syzbot+29fc8991b0ecb186cf40@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, purvayeshi550@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+29fc8991b0ecb186cf40@syzkaller.appspotmail.com
Tested-by: syzbot+29fc8991b0ecb186cf40@syzkaller.appspotmail.com

Tested on:

commit:         49665900 Merge tag 'i2c-for-6.14-rc3' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1380b9b0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=92e8820bdc5f2bf2
dashboard link: https://syzkaller.appspot.com/bug?extid=29fc8991b0ecb186cf40
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=118f39b0580000

Note: testing is done by a robot and is best-effort only.


Return-Path: <linux-kernel+bounces-342402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30D2F988E82
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 10:34:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 522871C20EB9
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 08:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D946619DF8D;
	Sat, 28 Sep 2024 08:34:04 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C72815A8
	for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 08:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727512444; cv=none; b=ErhT9OIJ3+IHa71aMj8pEv7FYAMvIWULC1RobQtsIGhzY5O9DaZL+8R5yq19qCRV1lEwdkrliCuxUSjYnn29Al4hXVmMt4uA0sRKjKVH44umoSz37qKbSCTEYT4iJ/knJu2Jg8G2GGexXawKvuRfMs4pTOb1HAWDKtdSEELbIng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727512444; c=relaxed/simple;
	bh=aHaAna3RYPFOPDrKgIubKL1nfo3OdQAF+Ie+z0mIuqk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=JuuvPtia0PyIRIcXFRWbr5GTJXqSzMl/NqyQHi1+VKWlLZDW0TToyndUfE61DdysA7QUyw9CfK/b2PAkxM2dYPUKCbOHD5feq5ACq0yHaDIWP5C0hWxRpZbVpIQn4glviJKmFhFkmSyDXwcqlLTRr9TaYPEWTPIUjbhv3Ul5n+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-82cdc7b7debso250594239f.3
        for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 01:34:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727512442; x=1728117242;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RFeM6rrslPV+PrW7DElZ+eS/9HA54IUmELYGT6F77/A=;
        b=eW9pLAlKrH88iYETbRedd+uVCePE3LDUNlzwZSytQLPXFap0VCn9++RNfTBuCzDPri
         qgBkYFFd0hVKtHFg5w8uO4fcrioQ52CP7PkTdp5lwqhyhWFUwPS8O/68hzQLh/rkJYyH
         WUw8yyfSPetsWIQ7zHungWPZT1qOrm9w4gxTi7FJUgKYd6T3psDqKhcu4hofRqqkaLm4
         9vN8NZ6coHaD6ZtUWUZhHsHI/gB6B59KOTWUHyKVUjvljVTzsfqWqwRYThk+URosjsdz
         oEfIP2s3kRJfiSChhYEkamW7LsqFgUdGVXC0UtNvdJGccpp5Ra1bvWqpw8tftP9cUc0s
         lckg==
X-Forwarded-Encrypted: i=1; AJvYcCVR49mBKcviVBD7LFdYyqXffhGIufGrxJkHVu7w2hGa5nsVRL0kjH1lCuq++A6Rl0Vyyiy6A5+rwhgf8qw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5JdeGKaJcQYme5l2i2Zx97jolrqbUJGEHJluyXMYeF9F1CPXD
	S5fmfAVDlE+XYpm5dUZSwTub8KT6fL389kUewKhnrfXY5wrySja5on239tC+HEcI6fYPr9UDr8l
	dtQDjdAKvHk9rRNmg5swmZ2u6/fHyLzKlvBEUab1lb/dvVW2How2+Uyw=
X-Google-Smtp-Source: AGHT+IGb+c7FgrqJYP3mGN2SSSQFp9sH54kO1Y/rQX/szd+L8goI/+HW8sL8MTJLvXwoYIuM0ZSzFKVH59lgw9kMm24t1LMuEkSQ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2d90:b0:82a:23b4:4c90 with SMTP id
 ca18e2360f4ac-834931ae471mr576288039f.1.1727512442287; Sat, 28 Sep 2024
 01:34:02 -0700 (PDT)
Date: Sat, 28 Sep 2024 01:34:02 -0700
In-Reply-To: <CAG-BmociJ6QqmQMmBdKEedg_+G-FUg8Vv=zpvP=brm52uQzsbQ@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f7bf7a.050a0220.46d20.003d.GAE@google.com>
Subject: Re: [syzbot] [jfs?] UBSAN: array-index-out-of-bounds in dtReadFirst
From: syzbot <syzbot+65fa06e29859e41a83f3@syzkaller.appspotmail.com>
To: ghanshyam1898@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+65fa06e29859e41a83f3@syzkaller.appspotmail.com
Tested-by: syzbot+65fa06e29859e41a83f3@syzkaller.appspotmail.com

Tested on:

commit:         ad46e8f9 Merge tag 'pm-6.12-rc1-2' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16cf3e27980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3415801570487c42
dashboard link: https://syzkaller.appspot.com/bug?extid=65fa06e29859e41a83f3
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=147c0d9f980000

Note: testing is done by a robot and is best-effort only.


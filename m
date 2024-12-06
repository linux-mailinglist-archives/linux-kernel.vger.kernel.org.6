Return-Path: <linux-kernel+bounces-435120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CE1B9E6FE8
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 15:16:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E19B3284376
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 14:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 834C02036FA;
	Fri,  6 Dec 2024 14:16:06 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B00322E
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 14:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733494566; cv=none; b=sMClbc7gNf4n9UCxkm2RkhT1U94+iP30NxtKTrqrEEY66EJGy3NnI3gMFINXmv20utDQyG8MoCU0E2VKoptVnYwZ0KDWXSiKwumgPLIpmzZrEMBS6XNqzszQ10uM6lSWGjsri6Qz9gWD5vIxTe7Ir10kKodu2cecWio5/pipN4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733494566; c=relaxed/simple;
	bh=Tkf99ZxUJD7B06TNovFBj5zWUG28OStkofgTtCr+JAw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=BQri9mfj+MlYZPhBdBOIgzvZgJ9u26lhiwy6WoOmI8u/EPSwzNx0bFkJXcYbs8WdikJt/d2CP6zJlT9IgAGVzBSO3ddY/sPJzWLYbqCTuzektEpRCGzQf5UZ+hPvYeeZ0QjqqMdZq83EFX0jQAu3AEN1v+i3vWfh43EmA8s8/TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a79afe7a0bso40854245ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 06:16:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733494564; x=1734099364;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gE1TesF6ZaizCblXTChTskphRlSEFQAeYDCiQuPDQKM=;
        b=j4wzTXxpAj0xKlguPI5noNOrXvQRj+pGYB1HRwTdWTHYCJpo+li9OXaQJuADYVZPra
         OQD1U6JIvG1PU1/Cd/zl4kOLPaxHP8Vzg/i+NQRB0/eVehScWf3cEMgrrjVysxZXkRQD
         lBQIcUhvRKJcNT2RjkfCCzGzabf4jTZMF6AEQD1/Y79LUFgEmXut0MV/uekB1BtZhnl+
         W6uLKJ0SXIht/2PsD3IOdk1R8BLK4yYpshRmqzAfmQtz80WAF/DYjLWRutZIJ3Lzue8C
         HDIrZOEUSmvoG4xVucJIUxzKyldTREYPGx13GCcKUSPaV1VaPd6fF+oaCGksQhZTcidw
         cNKg==
X-Forwarded-Encrypted: i=1; AJvYcCWq75dCq6PYKyHkBcw1CYrwtFpls1CluoYQBbzHGOrgNimFYBFA905SI2ceWLyIv8Bw2nbmKT0ytMvy7lY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoWuU1QXM+fp2h1+bXp9Spb6Yhcm4i35ebO8WZOhUyNq5jT6gP
	+v70m77rwb+GbaIRKgq/Vtlbw891C8ZfYAVMlOsoNKjR9znCdetF+FIHb7rD/NAvYWQJYy5xjCx
	ay8Ck3x0OCeX6ALP1MrH9W0XFJm12a8bAJ+g3GayJh0kTS5TJvULFQGI=
X-Google-Smtp-Source: AGHT+IFzPbqEOcrzl8qSgUO2fmGl5eDL+S3HaNIpt0JniopXGYcsXblVZr7ulGopiPZeoQ6SPpbeXxzInr2ShiHplzVMtFSR7yWO
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1448:b0:3a7:c5c8:aa53 with SMTP id
 e9e14a558f8ab-3a811d939a3mr36568285ab.13.1733494563834; Fri, 06 Dec 2024
 06:16:03 -0800 (PST)
Date: Fri, 06 Dec 2024 06:16:03 -0800
In-Reply-To: <000000000000d69fc4060c7d50a2@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67530723.050a0220.a30f1.013f.GAE@google.com>
Subject: Re: [syzbot] [hfs?] [mm?] KASAN: slab-out-of-bounds Write in shmem_file_read_iter
From: syzbot <syzbot+3e719fc23ab95580e4c2@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, brauner@kernel.org, bvanassche@acm.org, 
	cascardo@igalia.com, chao@kernel.org, hughd@google.com, josef@toxicpanda.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, rdunlap@infradead.org, sandeen@redhat.com, 
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 1c82587cb57687de3f18ab4b98a8850c789bedcf
Author: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Date:   Thu Nov 7 11:41:09 2024 +0000

    hfsplus: don't query the device logical block size multiple times

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=174098df980000
start commit:   fe46a7dd189e Merge tag 'sound-6.9-rc1' of git://git.kernel..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=4d90a36f0cab495a
dashboard link: https://syzkaller.appspot.com/bug?extid=3e719fc23ab95580e4c2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14903769180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14f25d81180000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: hfsplus: don't query the device logical block size multiple times

For information about bisection process see: https://goo.gl/tpsmEJ#bisection


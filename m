Return-Path: <linux-kernel+bounces-264465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FEB993E3A2
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 06:58:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7F49B21475
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 04:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE52D7470;
	Sun, 28 Jul 2024 04:58:05 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4DB3D62
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 04:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722142685; cv=none; b=fvI9ZroY+V3UcTg7IZ4gqWceeBBeaLB0vyShcDC2yBN8wHQfB7gWHgKgmgfWTf5UbZRgi2gc8jd2vgxLTAl/NsgB4xDM7lpnqytGSjXwng6aZzn+QL8z6I6P6SqBs7aUQFQafy/QBK+Eh54H2A1QT4K48g/+FgY7xzZof4V+5+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722142685; c=relaxed/simple;
	bh=IbrSvvlAuVWpRyVt503HCdAKdsw/imcw7dRXVOrIIXo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ivcJnLxx3/gWCJtXOc9TBwctj6nQ5/KeGEdqacd+f7urH2pRwojhie0IIz+ZEDbZFIb3JPKlaQAztXpWrF2fusZPJypyGm/FEagS3xkHircrl67ARFkV2DBupEWCD/JtExuwUwHAJRUlB5IE5F6FcibPa+MjQfUSehn1xFkxIug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-81f8293cdb1so440365039f.2
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 21:58:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722142683; x=1722747483;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MbkzvZddEg1A4kjBfD6t6gzWimHdaXcE7nKv0Ucadpw=;
        b=tR+IzaRmLOlu9BxQvtXf6ubBt4wCnh/NEZja6mJffmKoW2GSFQwGH8CuXXBJ41Q2DQ
         aZJZ6wINZLhzIQyJAwuwzuh0FWmzXHIJF677JQ7V5o85MjFCYAbOb9JBKxg+guwHp20x
         7a776RFN/O6FqIVZV+lOQB4kB397PjncyLTU6wfkzRdMVDkdP+tjJCuidVctnFK1i0cg
         BRhsEyySI/rdClh6DAKdgJKYcWpaLsfN4Hfezo9db59vljeb4MrG73BH16OagQNYq3J2
         jTXaxWzWA3SjdDuRz1darSCu9RCVGpRzGVjOjA6BXIq8qs9589wJtxHJuGBE3hG2d2JT
         y9ag==
X-Forwarded-Encrypted: i=1; AJvYcCUUuGrYszzRIUyDhfV9CY3X8YYgsIosc3hzCALZ4ky8ZAweGdaAP1gf+rHNo+NwlBI97Vz/9DVZE/2u14GqmXKYNspRYu7/Kl051tBb
X-Gm-Message-State: AOJu0YyQ3PNSLAgdt8w7wjKvE1zx9WYWpudVnnfzAuJSFBnHtff0VnoH
	5u0PH1xxPQVBPJLY1ndA2X2c2bN5ThwJlDoeVs/q0yMBGOQLtrU9CEkl/1GTt3Vdsawky4bITrf
	PEeV/qXRxXt2LsCTfXq7QDO6YF9sFLXUcoK6deqGj5ErN3wOIl3Nvxgw=
X-Google-Smtp-Source: AGHT+IG6xErq7qLh2sZGfnJuHz2lu1lKm2TX6M/tG4smEdEavuGEXP6J0T5LF5zAOdwjaSlS4ZZp48neiuquvO8nwgI/cuif72pz
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d95:b0:381:8fa5:3d9d with SMTP id
 e9e14a558f8ab-39aec28a270mr4046545ab.1.1722142683055; Sat, 27 Jul 2024
 21:58:03 -0700 (PDT)
Date: Sat, 27 Jul 2024 21:58:03 -0700
In-Reply-To: <tencent_697761F76E26CD3369437B6979E3ADC45A05@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e0593c061e4796b5@google.com>
Subject: Re: [syzbot] [btrfs?] kernel BUG in btrfs_folio_end_all_writers
From: syzbot <syzbot+a14d8ac9af3a2a4fd0c8@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

fs/btrfs/inode.c:1062:2: error: void function 'compress_file_range' should not return a value [-Wreturn-type]


Tested on:

commit:         b1bc554e Merge tag 'media/v6.11-1' of git://git.kernel..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=65e004fdd6e65e46
dashboard link: https://syzkaller.appspot.com/bug?extid=a14d8ac9af3a2a4fd0c8
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11b16d9d980000



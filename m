Return-Path: <linux-kernel+bounces-403653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BEED9C38A6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 07:52:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 898DCB2188E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 06:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D1D6152517;
	Mon, 11 Nov 2024 06:52:04 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61AA50276
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 06:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731307924; cv=none; b=KW3BlaqoEsp18Y8YQxavHRAY8yMnlYS4OPObLusZa3dDALbRV/S0KjUhJWL9fk6CI6MdSK2CpUmOpHqJ4d7c5EGfLRjzBAtRfGqDmGzGMSI53E0FhmM8cqVhMHUb1Z3jWqb5XtHkW0TGKBvDK7CFxlObRB29tf/OwvOuqq9E7FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731307924; c=relaxed/simple;
	bh=oyl4XPDYY3vPboPsdpuUEo1qVi/qyaAWii8od4Hm5Ls=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=rfZbtsBeh3Mhu6otd5jdtw03oqSm2tczJ+gHiv1xd3uB9m50WtdYzQMgb+Lfe/SBMTt/oZlJa8QpSkfU7S+L9+2/+C20OxKYQNGZDVHnWNwvnRNIfmawoSf4kWhEGtI7KmHJJT2Yc36NptQP27Uxh/dG9I2BcoiHoXRbsvUPY50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-83abb164a4fso483416839f.2
        for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2024 22:52:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731307922; x=1731912722;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2dJ6/nroVBGQUTS9OsOlK+5Ip3kuz8g+2uck6/CX5ZE=;
        b=dzUJuSRJujvEYq9rjInPk9kpUsPKaKmXfVafCywbBGofegHztxiWXpsIgzZmgyJUg2
         YKITVpaclf9Ck4iXR8PnoqBB0VFDSR/i2/ZRjN8A5b2YDAX2Eek55aa1RR/0E7CDw/na
         J8C/E7JtBIGti5ilLHqvkUhyzYSwBHISxFBJ2le4XB6zbwt6Mas08Z/4EJXAfAhMK0J1
         E9MvtjPYD072Qd55IWmeXqkP4cGK0k3QZNmQ5HSKHp8Afs849gNHkNpOQ+iKA8s4ffgP
         iDxCfS51Tyx0BIwoXTbiBEafshhRCd2HUiCTScmcoAsPxuz3QuD047IjB0ZTNEMFaVlS
         +V9g==
X-Forwarded-Encrypted: i=1; AJvYcCWE0jvWN1TgLurm33c3bAQUTxPG1YQ/MdHYl6eKHALePujc0lPSlBp0JSJpiIlRb8987DC3sYwKK4j1C1w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFaaxGUtEwOT7kwoUh6mDIZEVnlZIpu+iE1MNDO9JdEGjW6/u9
	G0ijZQqQgymzowPGpC9KGbgxAYpKYSomRnyEFnws4hQGTTLS5mvrB9YVKMNSaSIGCbHkjmhBmdg
	4uYIPJrhz7e8jOKmqemh8HBJZDpUleNga7MCC2S1WRMkg9Tl8EjQwt/8=
X-Google-Smtp-Source: AGHT+IEXp9sYzaWesql/z9O4tSb4Zgi9usWmqOEhAmcU5bKRQjtRtkdtyMRTw9f1kJqkKtYn6AMgVxyMgM82G9k0RT5jG/g94jgo
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1525:b0:3a6:c000:4443 with SMTP id
 e9e14a558f8ab-3a6f1a58d55mr122370185ab.20.1731307921830; Sun, 10 Nov 2024
 22:52:01 -0800 (PST)
Date: Sun, 10 Nov 2024 22:52:01 -0800
In-Reply-To: <671fb289.050a0220.21b2f.0005.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6731a991.050a0220.1fb99c.0149.GAE@google.com>
Subject: Re: [syzbot] [bcachefs?] kernel BUG in bch2_btree_write_buffer_flush_locked
From: syzbot <syzbot+4aff7bdaa254c1d9f008@syzkaller.appspotmail.com>
To: kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit bf4baaa087e2be0279991f1dbf9acaa7a4c9148c
Author: Kent Overstreet <kent.overstreet@linux.dev>
Date:   Sat Oct 5 21:37:02 2024 +0000

    bcachefs: Fix lockdep splat in bch2_accounting_read

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13a968c0580000
start commit:   a9cda7c0ffed Merge tag 'irq_urgent_for_v6.12_rc7' of git:/..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=106968c0580000
console output: https://syzkaller.appspot.com/x/log.txt?x=17a968c0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=347f0ef7656eeb41
dashboard link: https://syzkaller.appspot.com/bug?extid=4aff7bdaa254c1d9f008
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1480135f980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=153f54e8580000

Reported-by: syzbot+4aff7bdaa254c1d9f008@syzkaller.appspotmail.com
Fixes: bf4baaa087e2 ("bcachefs: Fix lockdep splat in bch2_accounting_read")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection


Return-Path: <linux-kernel+bounces-176494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92AC68C30BD
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 12:54:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEC6A1F2323F
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 10:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AEAD5466C;
	Sat, 11 May 2024 10:54:06 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD23B28E7
	for <linux-kernel@vger.kernel.org>; Sat, 11 May 2024 10:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715424846; cv=none; b=elw+PZTNE57i2RZkNFn7r5bL3g28fQeNOm4vX3Ascc8KhRnuA588XPp/li8rimhBOgIsYtYIwlFX13kXKqcl+KiMUDG+XfqBmAAWeXW1x4viADdR5NGBFSzBAOh/KccdbFtAVBx8yfKVZ85Cg5TkAR1DnKFW0qoB7AmIfdcFMlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715424846; c=relaxed/simple;
	bh=zb349U9QPT2D10/jxISpwmT3+Euyi+U2Pa4hgTHoEm4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Mv0u6Ncf3a/k7AI/dpq7MRi6+C7+Nc80I6kjW5UCkJMwUzYJnuWrzt8hdVlv6ByYxwTBZG3HXqs00oIcaMMFIzLzqyvM8Qv/Q5jJ4CtRxJXEVtn5kqWISp5Rwyt3yYbibbm6DClwjiAqoBwwKr3vQSia/OXetJWiVRpflVm3cA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7da52a99cbdso293707239f.1
        for <linux-kernel@vger.kernel.org>; Sat, 11 May 2024 03:54:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715424844; x=1716029644;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KISKyqi/eiZaHE3ia0a9T8f1/amBnbC/bDbbjPBZ1os=;
        b=EDmH0jYyqPB6/1od86OpIUeZBgXI4RLHybFy922KtrKTmkXYJM9mENlS16Nlg8Kc35
         8rwhj70ckn63eY8euiih+JwdhVOfKciPZBBV/9SuC0B+xE4byajDLYSjjR9irVRwj2Xo
         cU2P8f8gIea4BXktDaai6YKRD35aQWdSmaza7EkOLHIyYOIc5ugZhYkUu4nk8fdYzeLS
         4nKp8MCVwNEeVscwGjgYKHeM7jyEjFla0rW6iPx1DXFid6lF+iaX8K5zM95EJKVcI5Uq
         33dvPGa0darFd3dyf3FnROUQM6Dm2SVEjLXZe8TrSr1gcdWVjlycxgQdqdBcsYUsTUUw
         iCdw==
X-Forwarded-Encrypted: i=1; AJvYcCUJkSbK3uRswEwHRWfyVd2afCuaxmS0pZ9DN7B1V7tOk/4v5AabaWdNgjodHAqUpKQRK/YUKNK9t01mDnZ75R99ayiXYiZasaavht5i
X-Gm-Message-State: AOJu0Yy2w/dDquqUHerBCc+CTR6Dst+rsF2hbS0dIrj6CfmlY9hfhCwg
	GmlKs/F5DA9fyZyzko2j9BsyhVV2l9RMHtRzIlkpTFk5lpn2xluVGGEzahK+iEyteIFRq1bPx7h
	eTS6g9h+c0CHQjIwCB/QTzn4fqUQn7pgD6h0QIjDJ8Msrdpmsxt4TF70=
X-Google-Smtp-Source: AGHT+IEUc3VD15+b4Lcg217hTyTdseP2djSh0eM1/oo92Ok0Sb9LIay4074m/vXQoBrhF/WIlEnCr5yTBcR0TD2m6n0XUa+LSIjR
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:608c:b0:7de:3f44:a6fe with SMTP id
 ca18e2360f4ac-7e1b519cfb4mr17149439f.1.1715424844008; Sat, 11 May 2024
 03:54:04 -0700 (PDT)
Date: Sat, 11 May 2024 03:54:03 -0700
In-Reply-To: <00000000000090ebe40618212a25@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000077652906182b783f@google.com>
Subject: Re: [syzbot] [bcachefs?] WARNING in bch2_prt_printf
From: syzbot <syzbot+4e41a25632658c77b441@syzkaller.appspotmail.com>
To: bfoster@redhat.com, kent.overstreet@linux.dev, 
	linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit f39055220f6f98a180e3503fe05bbf9921c425c8
Author: Kent Overstreet <kent.overstreet@linux.dev>
Date:   Mon May 6 02:28:00 2024 +0000

    bcachefs: Add missing validation for superblock section clean

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17a16504980000
start commit:   75fa778d74b7 Add linux-next specific files for 20240510
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=14616504980000
console output: https://syzkaller.appspot.com/x/log.txt?x=10616504980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ccdd3ebd6715749a
dashboard link: https://syzkaller.appspot.com/bug?extid=4e41a25632658c77b441
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15f5ec3f180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=126cdfc0980000

Reported-by: syzbot+4e41a25632658c77b441@syzkaller.appspotmail.com
Fixes: f39055220f6f ("bcachefs: Add missing validation for superblock section clean")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection


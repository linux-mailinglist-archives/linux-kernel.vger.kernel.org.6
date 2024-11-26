Return-Path: <linux-kernel+bounces-421900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 937FE9D91B2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 07:18:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3149E1647C9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 06:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6C0515575F;
	Tue, 26 Nov 2024 06:18:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10E14C8E
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 06:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732601885; cv=none; b=hWbSJsp90pLA+qwQu0eSfvSxiyOH/CNnfHgdSc2NgxWxUOeuooG39M8KHwzEuFutjFKlKT9XSowLYf6pNPVF9U7/7ph4+oCm+7Vmo8mz1/dwSSjhxO1BxWFdO+zzVmrvAwMFhEB9oNfsVrAjF3tvL+WzZx+PHkUm5RJ/peG/zb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732601885; c=relaxed/simple;
	bh=Qpm9QckVXXb1I47uG9Cbd0F9B7qgMLOqlrzqwDWvSi0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=W1OCUVF4jeEoWrB+3XGCAf4hBmhUGJboFy5F89RSCjKJueaQsANVG+2bApruWq4aZbOf3ogvOwjdVv+3Z6v8+7+H8X5Qvce4LJ1XnSqwgsC3Slwks9Tw6WfWMInnWF3NPCqLkyODV5Gkn8eTS48bCqgGXdb/Bhj8aPLtoZ3bt/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a7bfddbfbdso1907965ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 22:18:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732601883; x=1733206683;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pL2C14kac8GxQPAK0YBWf+8pIClL7rO8LcoNOTLxqyw=;
        b=sZLZxy8bCXoDBIZLhv4GEaiJLuWhbe3uphRl61//P9wgjBrawqgVIJ4P/qD545Nqg9
         4vr4LKGwkfvHEVDywlV4SFWU7DNn+FS7vuds81RQ840Y0stu044VeUfspCW5qUXzusTF
         0JtjmASn6d6Rsa6LLq2JPjUXGF8+nPSB67sz+JCjiDHyW3irh0aqoA9bVklLYkSyb0Pz
         wBdN+9JaFgQAyj2nLnmhVWKjw16V16m9cjEUBjcPJIsl9BTKRPChT3Psl+3cUR+jGvOb
         Mi+LWRfp0BiIrlNPiFytIhTIZ4WT1kQ//ug2hz2UwPU1dGdc29MA6sAPmV/R7OTJnCuY
         Fc+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXMKO9RLnQAnHE/l7CWOMCDMYb0pxLql1IT5KLZvIsQamh+v1UgYsI9Bcq4oL2k3MQMNUz/GxXO9qZ1oig=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJKfoaN7w5fRUY1cHiHKUtsgPdrhCkvrCyaN29w1R3B17/QZnk
	VJ9ivaCugJyVP3VhDH07DVE8YSRiuxKD823jSd+YvIbQSJ1U0WmEx2o4XkUuPcHeHEYYS5S9Rt+
	F2nz8OPfKO0cxOpNIzgbEZvzi9AfTPi0Qi5hP/9Z9IrrdgyOw03qIELk=
X-Google-Smtp-Source: AGHT+IHHuq1eA3d/8v5iJGzp/2kIAPVqTOHn3ot2tTzc6xBRcSU0Ootp/4mSOLTvkGzObB+BmF/GaR+5C5nepmxcl8Pnkc+StMwI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:164d:b0:3a7:7811:1101 with SMTP id
 e9e14a558f8ab-3a79af1e894mr172826015ab.20.1732601883112; Mon, 25 Nov 2024
 22:18:03 -0800 (PST)
Date: Mon, 25 Nov 2024 22:18:03 -0800
In-Reply-To: <67447614.050a0220.1cc393.007f.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6745681b.050a0220.1286eb.0010.GAE@google.com>
Subject: Re: [syzbot] [bcachefs?] kernel BUG in bch2_evacuate_bucket
From: syzbot <syzbot+bd56952613b5dae47ca4@syzkaller.appspotmail.com>
To: bfoster@redhat.com, kent.overstreet@linux.dev, 
	linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 33dfafa90285c0873a24d633877d505ab8e3fc20
Author: Kent Overstreet <kent.overstreet@linux.dev>
Date:   Wed Jun 19 13:55:48 2024 +0000

    bcachefs: Fix safe errors by default

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=117715c0580000
start commit:   9f16d5e6f220 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=137715c0580000
console output: https://syzkaller.appspot.com/x/log.txt?x=157715c0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e92fc420ca55fe33
dashboard link: https://syzkaller.appspot.com/bug?extid=bd56952613b5dae47ca4
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=124c25c0580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=164c25c0580000

Reported-by: syzbot+bd56952613b5dae47ca4@syzkaller.appspotmail.com
Fixes: 33dfafa90285 ("bcachefs: Fix safe errors by default")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection


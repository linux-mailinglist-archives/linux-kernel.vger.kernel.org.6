Return-Path: <linux-kernel+bounces-393731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF7759BA48B
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 09:00:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74C2F1F2123A
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 08:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F198D15CD58;
	Sun,  3 Nov 2024 08:00:06 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFACD158219
	for <linux-kernel@vger.kernel.org>; Sun,  3 Nov 2024 08:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730620806; cv=none; b=GAX/MKZ3/KyUAaVouVi1vfyGP4B3UX6vgQAjG9GlAEg/SJc81WD6sOCDTjW7cJhz0GRZPQuT3mC3VFz4ejqtd/TPYCQDHh/96hxwX23ojAstGh5CacfPhOkzfG+2bdmo4wLCvuTnfkeOh/jOzOW568GKek8K59pK21J+MpdF4+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730620806; c=relaxed/simple;
	bh=Lqsft7adr0COfx9QvP8i+mZOqTv8xbTJfU1ig+o6UuE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=re636BxflAPx2tqG/nZuq2J7wLQBwE2GngRPEn0KUGUjSZ7oSTZsnq3tdbeeObjsrH6o8w85qjeE6GbnJDGHoRk+C0pWFDHRv0ACvtQqbpyfo/MVeyr4fFBx8yeoG7VW5qoPzmoicklskmjOM6c7HFJgkRyDT9OIuB3rUb5GO/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a3c5a6c5e1so44552515ab.2
        for <linux-kernel@vger.kernel.org>; Sun, 03 Nov 2024 01:00:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730620804; x=1731225604;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dmP+HGQUwPW0ypY8esrOjnmsI7a99i7CTGI0scCwH0I=;
        b=JJunGqtv1EsjrdTZgmpZ8MJR9TBf3f9SOO7K/kenFE+ztQZNkq0WYKxAKjQ62VEdGp
         eC50nd/diQtIcNLOkBaIf87hEAHWezz+DeTczIiZSMXcm8if8cRDPjeMITLozUIWhd21
         z16r6ZV3vzZRt2WmN//NS8bfKOiJf5ZVhtnPlWT/Zo4YOYGhzXu5fZREX6E9L/hSzKQC
         iVRgmjDC1ilSPwJQnaAn+h1IlYMWBMzBJRe1UYXSx6U/9BoleaMN3SNVv9YHNHEsuJO3
         sEpUmMLTb8twS13xH9v0IPQf0XyV5iEZwAdlklLfAkjPJ8R5YUlF04lCpTXYBXa9+Qbv
         /CJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwCzvUWZeE8u/nnvyrcoC1SF9WefWEVaaEszXtErh3z5kWFJSWOUd4x/h5KPyzLB7T3NmepEuOkX3A8c0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/XaLzxKjWyZBAJHUKgip3blCrbHKudBJ0wcC3qp58dg7LtynU
	aXaZ6oB0VDVM+frD+tpxrpOM3+WG783noYrN2pdc786y8zAfmaDgM6fdv3tK/yJ9YB9q79RsmHe
	2cTG9QyCwMmKnOIUyWMMcXpjbzN78O698R/gPtoKikTXFV9vandSgILQ=
X-Google-Smtp-Source: AGHT+IH0buP0zXdG32JSHCLOF/6Mgi+ie9pEBHNGOEtrKdJwcvzsE9Cjn15xg0v/QLD/Co46kwwx0BCzpHV46XxLmKQBIQE9CbBB
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:d98c:0:b0:3a6:bf1a:17d2 with SMTP id
 e9e14a558f8ab-3a6bf1a1a5emr27714515ab.1.1730620803983; Sun, 03 Nov 2024
 01:00:03 -0700 (PDT)
Date: Sun, 03 Nov 2024 01:00:03 -0700
In-Reply-To: <67253504.050a0220.3c8d68.08e1.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67272d83.050a0220.35b515.0198.GAE@google.com>
Subject: Re: [syzbot] [io-uring?] general protection fault in io_sqe_buffer_register
From: syzbot <syzbot+05c0f12a4d43d656817e@syzkaller.appspotmail.com>
To: asml.silence@gmail.com, axboe@kernel.dk, io-uring@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 661768085e99aad356ebc77d78ac41fd02eccbe3
Author: Jens Axboe <axboe@kernel.dk>
Date:   Wed Oct 30 15:51:58 2024 +0000

    io_uring/rsrc: get rid of the empty node and dummy_ubuf

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1586e987980000
start commit:   f9f24ca362a4 Add linux-next specific files for 20241031
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1786e987980000
console output: https://syzkaller.appspot.com/x/log.txt?x=1386e987980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=328572ed4d152be9
dashboard link: https://syzkaller.appspot.com/bug?extid=05c0f12a4d43d656817e
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15abc6f7980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10eb655f980000

Reported-by: syzbot+05c0f12a4d43d656817e@syzkaller.appspotmail.com
Fixes: 661768085e99 ("io_uring/rsrc: get rid of the empty node and dummy_ubuf")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection


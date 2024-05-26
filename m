Return-Path: <linux-kernel+bounces-189731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1C818CF432
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 14:20:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B53BD1C20ADD
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 12:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90801DDDC;
	Sun, 26 May 2024 12:20:08 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF61BB676
	for <linux-kernel@vger.kernel.org>; Sun, 26 May 2024 12:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716726008; cv=none; b=RcEpTBb6NT4Wz60PXENz/bwUJQq01G4/t+5tObCbFlQECb2wzRVaKgiqQKOkLRJXA0ux/7nX2Vf19UftcQ+S1wUvtzXG79fGDiuQQhxDZZPRvYx9FMAIUk6kx9KXOs4uWWZMLLtbIUspPJVHja7i4uyQW2G6YMustSvg6YNEv+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716726008; c=relaxed/simple;
	bh=WaRJ+rA5WgS3mFqo4k0lp8UErqbl9DIH6B/VqP7V0ao=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=uK2ofNJ7oL7m5kcDhh2bezqD8SrEsJoGpNgpYfoHk4cLlHY1o9aLiGh8EoEIE1R2t4JiyxHpQnQRz7TkAi5c02TC00yhtdIsYwFTF4u63vKTVnzqyiMGry/vCDyOyEEZ+fOjBDJPsjcBfIDtrwl6zAZFYBMMyAWbsqveheHRzy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-37456723385so1807325ab.0
        for <linux-kernel@vger.kernel.org>; Sun, 26 May 2024 05:20:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716726006; x=1717330806;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/As+RO3hUU+6RkkzFvyl958mmQkvQbWtdetCc5wnIJ4=;
        b=vQagfGmWe5GG8Q6woqrkI5CUVAiydRP3ZRssZK6sj2mFvphoiIKJAXkvWTyi7JfRks
         grDxOv44WgNP4VVy8Jf6bZUtET3MRCxSazI4oYkYlK2zrrB5JQTIm5S0p8/qpvqNMmK+
         Sv5g/mMaMJ0wNeYVploUHeZ0no/y/TFEQ+Kw74nGjtLBiH5CFEsNk0lSt3RwkwioEvhU
         LMy0B+vhH3pDCYX9bDPmmzVeO3/Rw4pTLNP1kYUE4qZl86qPC4u88eNINdwWFCRTQ9GX
         Lbct+lkct1JdQmX65DayIqMwFJOTIDd5sBrXV/egkaSnneghp+7rapO5s4oV8h6K1tg0
         Cc3Q==
X-Forwarded-Encrypted: i=1; AJvYcCX3lnB51MazUcQpnDQwyI7PVoJbFinMF4gUv5RC+JZzkPm+9P03Cw+fv3P8o6kKiqR+cJaER92rc1FuVVtIOD8kDxPr+rKhHUxwUBIH
X-Gm-Message-State: AOJu0YxeirNRimxPsY8pwpg+zfnd583dB9FB0P0BdlZiUCz3HGLGx8I+
	9VaAZWJPQLUcouxzhrjkL9mKxDjYuQN3dtygIwiAPBgyw9/9WASfYWJ8EA1hs85zYFnVaiEwhms
	i1rnkpfvw9CncAgNx9/XghIQeBQwGjs831pF4L+iNpdTOpebZyrjDHI0=
X-Google-Smtp-Source: AGHT+IH83hL1JYz01PPFxLm89qIIXnDgvitXVzrNi/f/Ty1yRl7x7r6QJdsIu+cMLbZ5D756XmkdT0lLxSX8k6f1/G4V3e54gqgl
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:160f:b0:373:fed2:d934 with SMTP id
 e9e14a558f8ab-373fed2dc57mr3307805ab.1.1716726006095; Sun, 26 May 2024
 05:20:06 -0700 (PDT)
Date: Sun, 26 May 2024 05:20:06 -0700
In-Reply-To: <0000000000005736990617c4fa63@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c53d3206195a6b38@google.com>
Subject: Re: [syzbot] [net?] WARNING in inet_csk_get_port (3)
From: syzbot <syzbot+2459c1b9fcd39be822b1@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, davem@davemloft.net, dsahern@kernel.org, 
	edumazet@google.com, jolsa@kernel.org, kuba@kernel.org, laoar.shao@gmail.com, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 3505cb9fa26cfec9512744466e754a8cbc2365b0
Author: Jiri Olsa <jolsa@kernel.org>
Date:   Wed Aug 9 08:34:14 2023 +0000

    bpf: Add attach_type checks under bpf_prog_attach_check_attach_type

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15dbe672980000
start commit:   977b1ef51866 Merge tag 'block-6.9-20240420' of git://git.k..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=17dbe672980000
console output: https://syzkaller.appspot.com/x/log.txt?x=13dbe672980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=85dbe39cf8e4f599
dashboard link: https://syzkaller.appspot.com/bug?extid=2459c1b9fcd39be822b1
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=126c6080980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11135520980000

Reported-by: syzbot+2459c1b9fcd39be822b1@syzkaller.appspotmail.com
Fixes: 3505cb9fa26c ("bpf: Add attach_type checks under bpf_prog_attach_check_attach_type")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection


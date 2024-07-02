Return-Path: <linux-kernel+bounces-238543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9116E924BE1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 00:51:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55652282005
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 22:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFA9817A599;
	Tue,  2 Jul 2024 22:51:04 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97456E5ED
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 22:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719960664; cv=none; b=ms0ynB2OWKi2aYeKcr+H23XUSa8BzTOfraVQnN5HIO7nh/0k7g32tLeq8j4I7kw5Vhp5uUe2K1y53tzuPOpaxeQGtGl52bXuoyGwphgdDx6TXERMDR/7ANPE9Vu1W32fI2epr8uHps/OFmWe5+vj5g2CTkBiPB2g8FUdblh/xeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719960664; c=relaxed/simple;
	bh=c2pljCvkDCrNdXi8dK8gDV1YRjNyJOZWcO0u3w0ZRO0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=DutiqMO4h9+4yzoXO4aAe4FmZj5ZQMwXHdjvDWSMMyDqxKs4A+giFkVa9mOEK+NHguBM31128B30JFrE38UhWcODesIDCTOIkdYb9meXB6DjFTLus10OSAxLP70BTUZND2gy+V6RwV08L+yJ1f8CcwbkdB/SDuYEez2Yovaw7YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-375d2ddeffbso52426585ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 15:51:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719960662; x=1720565462;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H1zcW/2g69j2qQoiRggn0QFp5HfBY19iLG4r8iDmR7o=;
        b=EQl3pxDKEJT8PmlV8VzlhQSlo9Y9cCGtqbOFGDMEpaAWdGRYlz8UxcgsObERDMaqVn
         /6uy1+7wD5WYU4qeRGXiXBs6VFoY9HmtrsxaxTOAxz7/hDC3xZ3Apu/L2Ya4AgFpHrav
         vBDFfoej9KZ+M2S4bcNV7I/glUzbdkGr+6KkNeOqObVw77bUeevuu9hQGwd7kaxmOGqC
         grvERqF4l3kUX1dsc7pe4KsBHQoYjkpiC3YKMcjkVRA9foSFBBMss7qgumnRiB7eW2Wm
         EXm7nFzGzF6byRU6p1i9Kzyz/aw+SCx7FioiAZFbZT3z8v0TgKZpB7E4ChlMarunDrMF
         qFCg==
X-Forwarded-Encrypted: i=1; AJvYcCUMHIz+9dj8IPIp5AClnzPMGafq1X1GBJq+96KQ+5/zCnZHmaQe9H7sYwXURQO3RNlGhZD2gnDOlz1SJI69iJeUg8hFsy070Uq9HT0a
X-Gm-Message-State: AOJu0YweGQY0eL/WDqg9zokkhbt513ifXSQnpksZSQR8f6iBlaIu3IqN
	dFXs5v5sEjrxPnOfdVA9VJdDYpKZzwx+yzEKHzaFBuDulwePhrV/c8SUJVvY75CLwhS6Zcos+/t
	nZ4SyHE5q8exmmnICnPgWn8tJRi8yXN1RLGGf8udnfR5a0Hp6XXWZJDo=
X-Google-Smtp-Source: AGHT+IGFYq+7YQH3JWUdJMQ0+E0mo8gA3VnnRcqAnxlLu4dlVKRiLZ9jwAtGOvpodFI7gcpr+3j4Hx4eplld8naDEf9gWYM3aKn7
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:14cd:b0:4b9:eee6:40d with SMTP id
 8926c6da1cb9f-4bbb703fba1mr542699173.4.1719960662062; Tue, 02 Jul 2024
 15:51:02 -0700 (PDT)
Date: Tue, 02 Jul 2024 15:51:02 -0700
In-Reply-To: <000000000000454110061bb48619@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004a4df5061c4b8cf3@google.com>
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Read in l2tp_tunnel_del_work
From: syzbot <syzbot+b471b7c936301a59745b@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, hdanton@sina.com, 
	jchapman@katalix.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, samuel.thibault@ens-lyon.org, 
	syzkaller-bugs@googlegroups.com, tparkin@katalix.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit d18d3f0a24fc4a3513495892ab1a3753628b341b
Author: James Chapman <jchapman@katalix.com>
Date:   Thu Jun 20 11:22:44 2024 +0000

    l2tp: replace hlist with simple list for per-tunnel session list

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=110dc9c6980000
start commit:   1c5fc27bc48a Merge tag 'nf-next-24-06-28' of git://git.ker..
git tree:       net-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=130dc9c6980000
console output: https://syzkaller.appspot.com/x/log.txt?x=150dc9c6980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5264b58fdff6e881
dashboard link: https://syzkaller.appspot.com/bug?extid=b471b7c936301a59745b
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1094f701980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16bf2361980000

Reported-by: syzbot+b471b7c936301a59745b@syzkaller.appspotmail.com
Fixes: d18d3f0a24fc ("l2tp: replace hlist with simple list for per-tunnel session list")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection


Return-Path: <linux-kernel+bounces-391548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB839B8880
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 02:30:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 990441F22995
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 01:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50AF473451;
	Fri,  1 Nov 2024 01:30:10 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2D15C603
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 01:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730424610; cv=none; b=pPlCH516q8OGdT8e/vvl6IpUnm1jMmY9DvccWeyeXHstW2NbWs7Pri1e3TgOYWjY9Y6mCTe4r/uf77Zw5ab7hSkU99T1ZDgIAPzmZi+ZWpQk2LZIIg5Hlw4xzoAW+il7X0jO61XzIwPXKuCBBXg5P9QZ/3dG58Pu3FSwHbb0VQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730424610; c=relaxed/simple;
	bh=zTHtoB3tKjutMlHY+vdDzuxJOZwG9Q2qF1gd5/dnSQ4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ODDh6q/wWRFv/sD05boYARjtbEVcouMhu8f1PNOOw9wdvUXQ+TqGwkJP+SlMFfZtZOkIVzYeEsx5EgHGh1Bo/tvb3T0PWzJJxCdVVssTCp0pEk5M0JHHE4LoSAOImVE0aTQcrh5JmSKgYqWwHsaAvi4Vav1IVmMn4Kl4gYpZWSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a3c3ecaaabso18380385ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 18:30:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730424603; x=1731029403;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TTx8Pkc/ULkMB25YnEZ2sz5xzsb50SUShkjtn2Uzgtk=;
        b=oDFhibwk/VbvRlIDVFBWvSjriDZqWI7imqbkpwvpxzM/s0K2dqi5w2L73e+PazTA4S
         0zSrlpw94xmfZOIl1PHEr3xNnljbD78fg01cnoHd53Cda01s24HBxxpmutyBGKKC6GLS
         AjZHCtN61mg+4wvKOWT3grILJD6/64pxilCh1n0eMg52p8nRPkKZgELZ6+js+2adahpq
         IPmY2CcnvMMfRl5EQlgHaEYnq3qvpKrDEm0gu92cskz3iR/xiZcsDaZRnHbTDf+Q7Zc7
         9HVLvpegifKnbE4HG58X7OjVkcvPgkCcZcD15Tv+8G7X6e911EsqqvF2X0XuCv1ORpNr
         zyCw==
X-Forwarded-Encrypted: i=1; AJvYcCUzgzGg3VdzLseD2rLMSYkYDPjgOdMSzXxQxwyrNbmbIf6OunZar/JstP5powCEbZdfY/MGk/or95vNE6U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/6uxNODJH6PzzTGJF896Fo02v4Hltwi14iJE1kMa3k6zEtEUa
	FWU+u5vzsACZnvIn/8fUGT2zFghjAjscHgGRjw/dSElpvWtTpMyimR4zXMw+rc9wK6ZLqqtN9gv
	2ogjyk502bkkK1K3E/gJzRMb7GfGthbB3smqzsvSHyXVZ/oLr+1MA0zE=
X-Google-Smtp-Source: AGHT+IF/iGjFSN3CX3FXliJcR+7/sefN9TRnsqo+hdrH+km5zgp622Jp80Ys88ISNfbFDe9cCPD2Fla0EDHTqw/Gd6zV0nQqPkjK
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1609:b0:3a4:e62b:4dfd with SMTP id
 e9e14a558f8ab-3a5e2458517mr111236185ab.7.1730424603451; Thu, 31 Oct 2024
 18:30:03 -0700 (PDT)
Date: Thu, 31 Oct 2024 18:30:03 -0700
In-Reply-To: <000000000000ce6fdb061cc7e5b2@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67242f1b.050a0220.529b6.005e.GAE@google.com>
Subject: Re: [syzbot] [netfilter] BUG: soft lockup in batadv_iv_send_outstanding_bat_ogm_packet
From: syzbot <syzbot+572f6e36bc6ee6f16762@syzkaller.appspotmail.com>
To: a@unstable.cc, b.a.t.m.a.n@lists.open-mesh.org, bsegall@google.com, 
	davem@davemloft.net, dietmar.eggemann@arm.com, edumazet@google.com, 
	juri.lelli@redhat.com, kadlec@netfilter.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, mareklindner@neomailbox.ch, mgorman@suse.de, 
	mingo@redhat.com, netdev@vger.kernel.org, netfilter-devel@vger.kernel.org, 
	pabeni@redhat.com, pablo@netfilter.org, peterz@infradead.org, 
	rostedt@goodmis.org, sven@narfation.org, sw@simonwunderlich.de, 
	syzkaller-bugs@googlegroups.com, vincent.guittot@linaro.org, 
	vschneid@redhat.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit c662e2b1e8cfc3b6329704dab06051f8c3ec2993
Author: Peter Zijlstra <peterz@infradead.org>
Date:   Thu Sep 5 15:02:24 2024 +0000

    sched: Fix sched_delayed vs sched_core

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14886e87980000
start commit:   a430d95c5efa Merge tag 'lsm-pr-20240911' of git://git.kern..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=44d46e514184cd24
dashboard link: https://syzkaller.appspot.com/bug?extid=572f6e36bc6ee6f16762
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1481cca9980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14929607980000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: sched: Fix sched_delayed vs sched_core

For information about bisection process see: https://goo.gl/tpsmEJ#bisection


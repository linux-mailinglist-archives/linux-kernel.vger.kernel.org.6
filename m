Return-Path: <linux-kernel+bounces-168933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DD3E08BBFE8
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 11:08:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3AB13B210BF
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 09:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF03479D8;
	Sun,  5 May 2024 09:08:04 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159A76FC7
	for <linux-kernel@vger.kernel.org>; Sun,  5 May 2024 09:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714900084; cv=none; b=nQ0MAe7X6DFX2NZ0MWgOzySchOPpuCJbENAydAjQF6JWDinBMp8+InCZ7+Nk47vbvB/92Uap4NaWY93LPCtNoiZkTvubk2XTIIVesZZQCEpObMYkEqvntkckgfFvjypTtMhsmogowD3SJfkPTZEHBQ8XBgqQKPOssn5uEm5i4gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714900084; c=relaxed/simple;
	bh=+kvNGsIf6cUqhl9egqdjJ1o07E9o3CD77g95IKWENsA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=aolLKg4zJSwb5JRmZFpIX6OzEqkJbfDOYldmyhjc+8+R6ObA0DFeV3mtjeVWwiwtJMVxL1SVmGFxwCuMgEkrQvbCa/MMm0HwpnE+rt2c5kp9NFW0cciSlGrMJuJECo3/fyDslzgtBAG8U9Lr4KYDavfLX+0tWXgqurhl/7f0ymY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-36c7533ed44so7964705ab.0
        for <linux-kernel@vger.kernel.org>; Sun, 05 May 2024 02:08:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714900082; x=1715504882;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rR9uYo4pUV9Ptwo8tFdHdWFFeBKlQtLIoXS25vEOSGs=;
        b=eNqZSItFhzn1rNhks4DwQl2vuJwYzDJvyTWomrf2jYgGsy0gKvQJjjElgFiQT4aHgt
         X+1xL/TBgoX6omlgalxbAVHz2qnIKSV9ageEVp3WFysv89QP6wDFvhIZeZqpeIh6T7Xi
         61TYhDPsP5wp058kevz42M4P+8/zZFYws67+DiiVLeRveyZ7cxN5MZIDLZNjmfTlSXr0
         9xYkpZVhHv+7n44Ow2Zu6XSwSxZrCfmELy9cEJTohdzvnqng7P791J5tukkpPiLGUUP4
         6S33Umbsc2wflLNtLp2TX/4r19lFefcWVoa+/VqOrWRgJk8nwpIeCVxGiwBHFm9A/GKP
         i+8g==
X-Forwarded-Encrypted: i=1; AJvYcCULwB8Syk5jda0sZB6DC4tn6eTMmV0DPAzjZztAu71hainjJDJ7RsogNYQbPm8rQAK5bhynuiCf6qKfP1Jyk8FzPyfIlsXj22PH+76v
X-Gm-Message-State: AOJu0YxpD79gMWr1gyH4a3eyaCN9YeNwSNAA4OcIO5FOvEQ1fGkdQIY0
	kpVQxhzF3EQUo6uV+LhXDqJz6EJlhVvlskSIeuS0d9F9oGEcCFX+DDqN4qX5eBjNlDXFMypo42o
	cMRShmTjQD3Mhb5grqe676UQE9KyoCK6oBz+W+MocIv3cvm6wnW/OIcI=
X-Google-Smtp-Source: AGHT+IFWDqLnTzsRcrBxqd5SqG2JiVps/sd0xHJP5/WtobEL4if6t3mOAZ+eSHsaUwj1B9Z/mqsH4Khq2dJl5U+pVISPV2pV1l3P
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:216e:b0:36c:4cc9:5923 with SMTP id
 s14-20020a056e02216e00b0036c4cc95923mr405376ilv.2.1714900082343; Sun, 05 May
 2024 02:08:02 -0700 (PDT)
Date: Sun, 05 May 2024 02:08:02 -0700
In-Reply-To: <000000000000c430800614b93936@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003bcdf30617b14ab6@google.com>
Subject: Re: [syzbot] [net?] possible deadlock in hsr_dev_xmit (2)
From: syzbot <syzbot+fbf74291c3b7e753b481@syzkaller.appspotmail.com>
To: bigeasy@linutronix.de, davem@davemloft.net, edumazet@google.com, 
	hdanton@sina.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 06afd2c31d338fa762548580c1bf088703dd1e03
Author: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Date:   Tue Nov 29 16:48:12 2022 +0000

    hsr: Synchronize sending frames to have always incremented outgoing seq nr.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=133c15f8980000
start commit:   5829614a7b3b Merge branch 'net-sysctl-sentinel'
git tree:       net-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=10bc15f8980000
console output: https://syzkaller.appspot.com/x/log.txt?x=173c15f8980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7c70a227bc928e1b
dashboard link: https://syzkaller.appspot.com/bug?extid=fbf74291c3b7e753b481
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=144d20e4980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1532ab38980000

Reported-by: syzbot+fbf74291c3b7e753b481@syzkaller.appspotmail.com
Fixes: 06afd2c31d33 ("hsr: Synchronize sending frames to have always incremented outgoing seq nr.")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection


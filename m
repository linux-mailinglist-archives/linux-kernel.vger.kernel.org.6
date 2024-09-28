Return-Path: <linux-kernel+bounces-342506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A9F6988FC3
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 16:47:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26448B215F0
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 14:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 991D11CD2A;
	Sat, 28 Sep 2024 14:47:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9AE917545
	for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 14:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727534825; cv=none; b=vBub5Id3sqKiPg0Py6G1yhkhh2SibBfjHvw/3Eg0B9it3t8Rj48uQN3g1ft6yf/rxNQvZW4w3y6KpxEhgRzjY//PlyRk5it/sjSIiN0LXWa64Dvps/4EZ/xE0LKnGUc0WIPUYI1dAbetIvbE9U9fkl3agIq6tTzl3ON8zCbrH2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727534825; c=relaxed/simple;
	bh=lx7Ifb9q719owpGrIkO2jtwN2HKzH6UEVno5u3b+iF4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=nWKxwkhIKKhpO8gy0B7gqUxcwZuSbxBrFHDlwjofYFTpoi89yRrOrZXgaE6yOnM6SN0O2zY/X0XrFQ+Tgq0fQuwA4y0uLzCh4Q5NYkWELG25CY5hKf87TahKFX5e3QFTIAJka26vX1z//IsyE+zLrYS+vMvf+mMqgnOu0YVFU4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a19534ac2fso40820515ab.2
        for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 07:47:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727534823; x=1728139623;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qS3n76UGkCFfSzpWf68kEL7cLIcUZy/Q42VybJ4lvPc=;
        b=hBCmrX6HAU4WYpkEU/CmxIQ452XY1lbZcBdueLRfG3Pp4KjYg5Uh5qbIaBtMgm43Nt
         x/XOWN6fpjv5se6yP90wENH4w0g2cXMBv660ILm015E8fLnPfDvainpX7yTQjHaghgD5
         tYef4PlLae4OWvN6IKEQQiHwixbNrv0chiGvhKY5dqd53L3H6KOHlqev1ZW5EgOVg/BI
         BBPIKJ2AB/dn45XhZlBwNhQRn46BGPOFKjF2QaMxJOWxBpWcQsVcniVxUovsNPmIWk3o
         FP1C4VqrjG++P1xwsatqB8gHg4UOeVsIeSo+U1Dhqx1G2O9FgDi0w4K00LUDPf/gPQoO
         RT5g==
X-Forwarded-Encrypted: i=1; AJvYcCXCoK47glWnVLpJlDDlOTYHCwyLXMU2ETuD16dPVrkVyyUPwTyfERYSiUqII1SoYEeJnY57Nn2/gDNr610=@vger.kernel.org
X-Gm-Message-State: AOJu0YydelI0rddAh0JU0nOurvG3w57o2RUq7A1+DeTxvX9YUgxR4cct
	nlKwX8AuoLhZFm5hr48vCnwnRGkosU/KECQAgMASGXNeYXGXY6c7uB/QksY3F4q/iE5LaUPyJ8C
	weTsd5+2GY3qMwbT45M+6vJn1Pzz6CAkIM/Ev8hJKuHC8o5E3IGhBIlU=
X-Google-Smtp-Source: AGHT+IFQPRWXJ8MlIWkc8iJvXKX8p5A6JpNeYO/NKPlG50WuJZZ4zc7BrIPosH16IdW8xqGLrFONOFk/JPLQ+xYj3mCLBIvJNAzl
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a08:b0:3a0:92b1:ec3c with SMTP id
 e9e14a558f8ab-3a345161e57mr58864265ab.4.1727534822873; Sat, 28 Sep 2024
 07:47:02 -0700 (PDT)
Date: Sat, 28 Sep 2024 07:47:02 -0700
In-Reply-To: <000000000000aefb4d061e34a346@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f816e6.050a0220.aab67.0004.GAE@google.com>
Subject: Re: [syzbot] [net?] INFO: task hung in linkwatch_event (4)
From: syzbot <syzbot+2ba2d70f288cf61174e4@syzkaller.appspotmail.com>
To: bsegall@google.com, davem@davemloft.net, dietmar.eggemann@arm.com, 
	edumazet@google.com, jiri@resnulli.us, johannes.berg@intel.com, 
	juri.lelli@redhat.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	mgorman@suse.de, mingo@redhat.com, netdev@vger.kernel.org, pabeni@redhat.com, 
	peterz@infradead.org, rostedt@goodmis.org, syzkaller-bugs@googlegroups.com, 
	vincent.guittot@linaro.org, vschneid@redhat.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit e8901061ca0cd9acbd3d29d41d16c69c2bfff9f0
Author: Peter Zijlstra <peterz@infradead.org>
Date:   Thu May 23 08:48:09 2024 +0000

    sched: Split DEQUEUE_SLEEP from deactivate_task()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13ce9e80580000
start commit:   075dbe9f6e3c Merge tag 'soc-ep93xx-dt-6.12' of git://git.k..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=102e9e80580000
console output: https://syzkaller.appspot.com/x/log.txt?x=17ce9e80580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b2d4fdf18a83ec0b
dashboard link: https://syzkaller.appspot.com/bug?extid=2ba2d70f288cf61174e4
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10e2c507980000

Reported-by: syzbot+2ba2d70f288cf61174e4@syzkaller.appspotmail.com
Fixes: e8901061ca0c ("sched: Split DEQUEUE_SLEEP from deactivate_task()")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection


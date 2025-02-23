Return-Path: <linux-kernel+bounces-527620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD13A40D5B
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 09:16:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7989189CD66
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 08:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6E8E1FC10C;
	Sun, 23 Feb 2025 08:16:04 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09321FC7C9
	for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 08:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740298564; cv=none; b=f9kTLxstlTCNIuvIz3eg96f3CctXtbqCIjylkPPkCoqVoVhBovE3LjlzygDbGkGlPVtr738WQ7PvxtjtvY6JoOgUdI2rjsUGVV1/yry4GFD80BpL9GjPPhxchICQp3m8sV/i6ZesG7pX8DxLGzeF+35jMFUFEnXaT1pw9Ipdff8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740298564; c=relaxed/simple;
	bh=9Vgyp4UC7Lkr9EKXhmowcS/TtlCW/7Og9GYbYG5MWVo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=GH7ZsabPxZwJ7wDFQUfCH1oKae5D2VK6fU70Dqeaxs0uQcPgbk3Myd7f4qq8q4EOD1gykW+VhU7LGjuE9JFn2RLLacNk52j+9jcmgy6luh8rlXnN59JPAUMbbsDGLId1hmYVLk4RndkSGWJMujblJnzMDCkMPmZg65M2zQ1cmF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-8558f28e005so696049239f.1
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 00:16:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740298562; x=1740903362;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nQ+4otSDBeDUmexmVHW857ZJ5T8kJoJYo8BJC0cLT60=;
        b=op/ijKSd/o2Z13PwV5GdUqYKKeugjd+T4r5i0bRWEQnTZJfQqeQbvWLkfju2lxOSGJ
         rDbqqLMgpnZJKW103W41iRzjvIITLVGmDkPM44qx0cKn6l4aTRDywC+XF59WUrlvbYzL
         XKKy7WD7pXmRyo9sZxyG+WITk6rxZjrV0xjoV6dIr1wXqX1ptv4rsshnIg6WFsDsIygZ
         oJIeoASVvuzAzAQJrftlmnwEFHhz7btLoizj+a51XeHXKKvoWBsX4sPTr/SP4IjWe5eu
         KXWa/tbSSBpH85pNQ5SxF1GjmLLG/NX32gCQZb7H+8QT/Nu2PhEJhRB4Nfj4hUaxD8Ne
         F4VA==
X-Forwarded-Encrypted: i=1; AJvYcCVkS7aUJeXwXbtrybqdmaXqG5oWZ5ikrFrgC9DeLANNoR9wwxm9CcgFRxadn6ScG2Sch3lCqbX0wLutQOk=@vger.kernel.org
X-Gm-Message-State: AOJu0YywF8VGUraT/M1SLhkqh6m6shChmHwdcvL5aecoqUrVzPttBjBg
	/8o07edEEPz/fbVqRIs04KI29eepcaWQStQtkxss+oERltWRL9BuZSsU47NYQsK41cXXwOeLRGH
	2NMY4egq/O9T26zqA7Xq2lAl4WY4ZrhFxKmpxsqr/QJ+hZ2fwh/hhwNA=
X-Google-Smtp-Source: AGHT+IG56GWEOjnEyuPlcE5AZ8PYXTkhW4aFR3TLLN8zrCAQ7vapNIVlQKuln6iV14gMIqD3lUcgnKyzGkcfLVlFKN4Mcr/+ISqI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1706:b0:3d2:b6e0:79b4 with SMTP id
 e9e14a558f8ab-3d2cae6b5a4mr86784545ab.8.1740298561939; Sun, 23 Feb 2025
 00:16:01 -0800 (PST)
Date: Sun, 23 Feb 2025 00:16:01 -0800
In-Reply-To: <67b44ef3.050a0220.173698.004c.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67bad941.050a0220.bbfd1.0011.GAE@google.com>
Subject: Re: [syzbot] [bcachefs] WARNING: locking bug in simple_recursive_removal
From: syzbot <syzbot+727c886b67040701c448@syzkaller.appspotmail.com>
To: dakr@kernel.org, gregkh@linuxfoundation.org, kent.overstreet@linux.dev, 
	linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rafael@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 14152654805256d760315ec24e414363bfa19a06
Author: Kent Overstreet <kent.overstreet@linux.dev>
Date:   Mon Nov 25 05:21:27 2024 +0000

    bcachefs: Bad btree roots are now autofix

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14dffae4580000
start commit:   2408a807bfc3 Merge tag 'vfs-6.14-rc4.fixes' of git://git.k..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=16dffae4580000
console output: https://syzkaller.appspot.com/x/log.txt?x=12dffae4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6cc40dfe827ffb85
dashboard link: https://syzkaller.appspot.com/bug?extid=727c886b67040701c448
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17982498580000

Reported-by: syzbot+727c886b67040701c448@syzkaller.appspotmail.com
Fixes: 141526548052 ("bcachefs: Bad btree roots are now autofix")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection


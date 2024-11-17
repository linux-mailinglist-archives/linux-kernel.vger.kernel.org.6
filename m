Return-Path: <linux-kernel+bounces-412128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 217819D042E
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 15:03:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B7CDB21A53
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 14:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23CC41D935E;
	Sun, 17 Nov 2024 14:03:06 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510011C8FC8
	for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 14:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731852185; cv=none; b=eqog9EQ5nX4ihZ5ulvNe5Mi7XFWG5+D1kNEk1/SQ5TU3TDAgbowe1WyqM3qMQt9FKIYCTQ2WaSXknSxw1jzTaH++QnlwBaG/lMiqeeEsrj7B0N4ED/PCMaG8gvvyuYEJ4nCoJvGb5NLI0/WOe24avaIUY4lgUi7ivw1Dk5vBFBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731852185; c=relaxed/simple;
	bh=t2uHVMYp7iXp+o0/F+cYkAZoh2d2psBzk/GeopJjg0M=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=XYZGxEPA4OJMOm++YSv8xPYHn/xwkGSWzawDT+rldPmoIiS2b1P9PC/aC3MMRJ0C0R61QWq8vVx74eci3cusVqOlNkAyb9UUG1h+5dGoMQ8s3ICZGIjkK28VJN4aQ2f/G4fBb6qkbgZALuHd7uGqfnH5CBdGxScHQeMtV1N2upc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a762c65543so4203265ab.3
        for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 06:03:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731852183; x=1732456983;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NUssD4OF1/0W4ulVXXYWglqzpn1NTprdCx53eur2zFw=;
        b=ttyHKPHZQNl9jnIcBfkQsBfjFi8vGzDhf+W8jL/sOn51M1R4vcAVR64w74nHUvrTxF
         LxKy0KgYmECKfJ2ikrP3k3hu1TG3jTi8b3iyxyftLaLXHTYL3Zhps2k4/X823LRpfiXb
         /3y8ZtXjLOuCuLofd1vbAWVEQF7tRw6gWPiHp7vjWu6rrqBAf0A9yNeFCXX06cdEmOCG
         JXef83GMUlzf5mC8balT43nwNFs0Co2dOfmFM66G85MnuPnIYcYc4jPjbZK+5GBy0wih
         x+7z7memzGoQM6wwnCqbSpvpw1stP0VvjUf8dnU0yMenGYyLXdQWe95Rg7LgUIB83iug
         xx4g==
X-Forwarded-Encrypted: i=1; AJvYcCUg2ETOy3PAq/kUd2WKOmit1QfC+sBHgxDXxN0/XDy/6XI6obp9GDvXiArIOWxqvf3elraVB/7SVVyIHAM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOKTHG1GDox42uKDvcZ75NFBNfshofoEXxKErnjJoida4kKjoa
	OR4/vcTcoNRWbT5uBJfWPRqjaz/+/ysF+v2tAnVBuRfmTovh6j8FJDbU5Q+goCmBucBBtQeyKg8
	ZLxJ/MMMX0MS8uSymdvHE2wYiXO7+9sdChmgxycZyVQJTyXeTK5sf8OY=
X-Google-Smtp-Source: AGHT+IGpPscsTKcEqBtvy667IuN2y2ojokY1wvLLrtmso7y8ucb+MsA5Aa7h+kCOP7Ws8bgrOxutXJzm1W2hGXSN+35UuaRYEzFV
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1aaf:b0:3a6:aa64:dc9 with SMTP id
 e9e14a558f8ab-3a74802f569mr80874525ab.13.1731852183560; Sun, 17 Nov 2024
 06:03:03 -0800 (PST)
Date: Sun, 17 Nov 2024 06:03:03 -0800
In-Reply-To: <0000000000006477b305f2b48b58@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6739f797.050a0220.87769.000f.GAE@google.com>
Subject: Re: [syzbot] [bluetooth?] possible deadlock in rfcomm_dlc_exists
From: syzbot <syzbot+b69a625d06e8ece26415@syzkaller.appspotmail.com>
To: axboe@kernel.dk, davem@davemloft.net, edumazet@google.com, 
	hdanton@sina.com, johan.hedberg@gmail.com, kuba@kernel.org, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luiz.dentz@gmail.com, luiz.von.dentz@intel.com, marcel@holtmann.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com, 
	yangyingliang@huawei.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 08d1914293dae38350b8088980e59fbc699a72fe
Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Date:   Mon Sep 30 17:26:21 2024 +0000

    Bluetooth: RFCOMM: FIX possible deadlock in rfcomm_sk_state_change

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11bcdb5f980000
start commit:   5847c9777c30 Merge tag 'cgroup-for-6.8-rc7-fixes' of git:/..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=70429b75d4a1a401
dashboard link: https://syzkaller.appspot.com/bug?extid=b69a625d06e8ece26415
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1097b049180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=168a5bde180000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: Bluetooth: RFCOMM: FIX possible deadlock in rfcomm_sk_state_change

For information about bisection process see: https://goo.gl/tpsmEJ#bisection


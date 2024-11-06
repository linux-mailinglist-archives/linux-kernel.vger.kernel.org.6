Return-Path: <linux-kernel+bounces-397405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE4B29BDBBC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 03:02:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6521E1F21E31
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 02:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5F7D18DF9B;
	Wed,  6 Nov 2024 02:02:07 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67CF15E8B
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 02:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730858527; cv=none; b=vDvOV0EXFKx7IRV6Ejnu4cSd4YwjDq/uTWV44udv1ypmQ0zxINN2/S55rKWRN5MeouHaCeucTFtfLzeqYbFJkp7EE6Woo/I62kjvdmRvDul/NN1Be2In0NX02EdrKLBgtUjxJd/Q+8CPj8qbmtASPwoBevsmI2jZhaxW8avy7zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730858527; c=relaxed/simple;
	bh=QPSj9TzTx/w7E92lfiJqkr2ZvP17xKfsRuwHbhVlDoo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=tOjRZKw/m+XxourpyjH3s0Nd5YallgIP66dZxJpU5MTN+pw+4OnVMDEeaAkZcKjkrH0Bw0zKUtIioxK8ufQ16Tlmp97VTHqVI8CW7XO2ximMzF2pNw+JkC6I8ycKzLipt66Z/mILGfqMsHFsnatprzmzziGZ+jn08halD+Q61AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a3c90919a2so69020235ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 18:02:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730858525; x=1731463325;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oMOa6jRUo2ZXBwpjhk3+n/PwKOkNaRL5lEcHxGjOUwo=;
        b=lghn9paI/WZJscmlRPSrN8QinmWvZgfRBGoKw8CDYkf3nexsSO1PzNnDFafEun9fOc
         z2UcUGUkgXHl4zxN4rhKxnbJSvhHFdHIZQ63HTrFycNeaewl3J5P3r09A67Q7Xh9xCIv
         SabGIZ1qrY7ObKL7Sh/PVD+cVla9HKJxEjIF3qTCsRX8lgOhtHq04CQTSXFcIwUxwaNo
         2iOxqCmVaKOnPhJCrAd18dAKAdzBIYzh3H+b6UYZDyepZ55puw/taOErFBrfCsdsHmUS
         V30IJi4B1nlMGHdkeXnJ0hEmx1mblXjcPfbM9x+ET1iTLuOGysJYOOz2AW0ZG5Opm6aM
         j4Jg==
X-Forwarded-Encrypted: i=1; AJvYcCW6bBDrjm8+JUIrYZR3OVhfLWDK8CAJdEXqot63fSxwr+dPKNdnAuZ8FN5iAJ3LwHGRmt6mONMwf4Phnb0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjtBiGuE01Zd+W+2quML6ieEfNuhh1ZJKpTGY7E04J6dFLgtmL
	/zwdVN/M8E+pJHBYvbyAxgRyF4sPQR5MT1NwMEyJbIuNxBoPuyWLGlB8NUOQgjs/v7SWIy5Sm9I
	8x5PEVn3or/JxFMaU5Xo6Gm8ND6lpNmEiJq1brYVZgQaFzS3CcS+1MqM=
X-Google-Smtp-Source: AGHT+IEOiWLw1T7mXT4loU7pPMGGNeah765srPZcg1Gt/R+swyZcIVlC0wNJmTUcdxW4UGciRFI/eTj0mntNJ0kAhI2902BApiL/
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2142:b0:3a4:e452:c42c with SMTP id
 e9e14a558f8ab-3a4ed27c5f0mr424843865ab.6.1730858525026; Tue, 05 Nov 2024
 18:02:05 -0800 (PST)
Date: Tue, 05 Nov 2024 18:02:05 -0800
In-Reply-To: <tencent_C01B2E4B191BB0251ABA8BBB47338C9E3508@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <672ace1d.050a0220.2a847.1a5a.GAE@google.com>
Subject: Re: [syzbot] [sound?] INFO: task hung in snd_card_free
From: syzbot <syzbot+73582d08864d8268b6fd@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+73582d08864d8268b6fd@syzkaller.appspotmail.com
Tested-by: syzbot+73582d08864d8268b6fd@syzkaller.appspotmail.com

Tested on:

commit:         2e1b3cc9 Merge tag 'arm-fixes-6.12-2' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11519d5f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2effb62852f5a821
dashboard link: https://syzkaller.appspot.com/bug?extid=73582d08864d8268b6fd
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10d24f40580000

Note: testing is done by a robot and is best-effort only.


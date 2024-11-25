Return-Path: <linux-kernel+bounces-420896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 544129D8417
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 12:10:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9A3B167929
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 11:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3060195B33;
	Mon, 25 Nov 2024 11:10:06 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF721192589
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 11:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732533006; cv=none; b=ZmHGSqxPMgY0wNW/90xQaWBPCEuN94ndL7SorKcl+3jsUrMH4IOohEEPztLJUCPbMKjorthMAbnnx8giwU/NrHNalr8LFNHuzdFMVfjZ1Hdt5xwSbTnPR+AzqwXV6axws0V9pnoywA/bGdK0Lj6p81l4SSQSCd1W5SjbLu2Yofk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732533006; c=relaxed/simple;
	bh=ag81pewKSJv1JzPBH/2FxoqSjfhawrLPaWjKhWo21w4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=NmA7WwYqjaIxiQPTIepXS1eDgzxAk5wkHDGUpuuwfgDjd4sywJh9/pAGrtu3mox1HjvEG20Oaavem3sBzPt9/cfhL5ZWfvC9kNSuRPeIu4YRsRVAnzZH1LRPLAOWSe3YsDEwmqkbkdsqPGhHcJqRZkM2CD5DJigb4SJ4Xh6lY8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a79f4c0729so35201185ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 03:10:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732533003; x=1733137803;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=azFZgkAznkGWRqKpayynp8wcnMLv0A5z/vByIfvuy2k=;
        b=un5kH0HDsuSQXSQHW1SFYWJH1RVTGHWjAx26Rd2YAjXoX9cGVnh/4H75vaDbj1hlYy
         SXZ5gKoTv9cQ3El2YTVB/97cn+rj24soJMIruhQHXCanodoHdH56uNSYQWHOpzBbYfQ4
         NH6FBiJOf4KFRePgkokdZQ1o9Gd1zUR2jMy5cUbGIhsziaB0RIvCs64zCwHTjqF8m5BB
         0tO3nJ1cbDHM7+KIE5uRvbX1XS5IBa36amKS+EIO1HncHW0R5RzEfyQgLLZfOSIOKVzi
         yXJj2YZLHn2BM0HntVWoZnv/4OdaBkBDhQRB0L0iZJwZabx/L4TtqgNk2ys/YdldchOp
         eoBA==
X-Forwarded-Encrypted: i=1; AJvYcCWTlR0lTY2YAtbcMdm41DGK3a0RCaX19QRfbZPKEyeihg3R/uV9q84v/RDW0ieQrqzoRqzwV8kqMoBHCAA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEH6LNoSkz/Y6iRjL+21zau9wub+nPMGSmrh3cJp/xol7P/EHg
	l53FsSPYvvUkFG7Ds2Xlg8iqH+pv9GSSPqqU64s2jvHLK9/kkmU/dOfJ0Pz08wdIiMIPqhKtGk6
	fdU5TxqEzn4JqB+4e1gwFieQAgamnvMRp1y8p//kmJs9QAi4kGUVCK1M=
X-Google-Smtp-Source: AGHT+IFoQkGe2TzK2Kv1xxLurWvC9RrhZntMaXija6nT4YFa6w3mmJCpaUpQEkmsq6sXRwrNPG2IXp0gEE5GZ7zEEkt949sm/a6m
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a88:b0:3a7:6566:1e8f with SMTP id
 e9e14a558f8ab-3a79aeade39mr92766535ab.16.1732533003096; Mon, 25 Nov 2024
 03:10:03 -0800 (PST)
Date: Mon, 25 Nov 2024 03:10:03 -0800
In-Reply-To: <20241125105220.1566-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67445b0b.050a0220.1cc393.0076.GAE@google.com>
Subject: Re: [syzbot] [ext4?] WARNING: locking bug in get_page_from_freelist
From: syzbot <syzbot+5abecb17ba9299033d79@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, bigeasy@linutronix.de, hdanton@sina.com, 
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+5abecb17ba9299033d79@syzkaller.appspotmail.com
Tested-by: syzbot+5abecb17ba9299033d79@syzkaller.appspotmail.com

Tested on:

commit:         9f16d5e6 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13a4dee8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7393f07275e8e571
dashboard link: https://syzkaller.appspot.com/bug?extid=5abecb17ba9299033d79
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15b46530580000

Note: testing is done by a robot and is best-effort only.


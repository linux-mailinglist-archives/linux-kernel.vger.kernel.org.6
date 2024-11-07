Return-Path: <linux-kernel+bounces-400734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A1189C118C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 23:15:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FE1A1C22181
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 22:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D828B21893F;
	Thu,  7 Nov 2024 22:15:05 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0FF218D77
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 22:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731017705; cv=none; b=EYVJcaBHXe0LeIvza7NNYxy+TsT84vPpQi0u9o46B6p3pJyV9LxDk4HS8D547gFB4z1ZgKXuafnZfrt2cQ+lgUMjhwnXC+xfATGlfWhpP2BgkrFvCCGdJUdWNP3UC3tBgS7lvoV4m+gUzg+/2xaEENsbRynTKHNdORwLRBbnk6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731017705; c=relaxed/simple;
	bh=Ck8FtwaaahcHdlfqlCHDFbpCs6WlWl/68pm3qng1nKY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=cuVp2n1OUG47h6SQOcetnJpY1ysuwfouZrxctPJo4Hj/ipfWBtm3p9sDPNvfpERNBLddwJLAY/I4eQyyIGYWPDbsqmFZ42VEZKwT/O+Ozeu/b958XJb6Xhm+UyZNlmJjnVtWh/2YgfdI0y0n5XeowoZNl1bgLEOOWMXhPtPONhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a3c27c72d5so17026015ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 14:15:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731017703; x=1731622503;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=80lg74MIOgAgDmVT8cJ8GU2h+nNuXRom2bkxV8sK6uY=;
        b=tHidg8yGL04IAjt4Pd38kBv4kpjMkdXxNBcwL831bdSYZXk4g24MbcVrZOPTg8WpD/
         Uf31G5MuplicPC0ph78JJh9XuMoW37qNGthRb1intPHlmZ/2Q0GUyxZGZGhaOlIT6TiV
         2G2vmL+rJRNvq5ewy8PqYlJ0PpmRZgBubgPup9xaRuj3ZaM0oxKcZa/qpJ1jwimPjQ4f
         Q+QQufCibGegq7dXHL4xasoJFtiyEwqBWhhPBs7dtoQEXtNvVcG/6lpOUv5rZJVnJbcI
         nG84re5nQ1bHRXVZsNgXij7Uabd4jaooVNY9XRH2BLUy2prxew/+mf2Mvaln9Si4+xr6
         AlgA==
X-Forwarded-Encrypted: i=1; AJvYcCXOORfJHZqbKGZtRvoisGknFVTgZ07ntCdFQPsaurRDPzZXjPHEuQd+/Uagq5GEfJPboKC83FBmoVWgHuU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1VWHyqBdPnb2tvrhLEUn58TJSM1dyjQsdJX4SCoIgfYhXhlca
	dErb7jFSyLO+ZftnnTtAcFaie4EPipnlfI1kuKi6H1mtA+GQTbJMoIlItKsMQDCACFxpbuNgSgk
	2fVvmnh/zno3fIBEkGqlpvii2iptrnZDdvKkRy2dxsqONESjuJQ5c+Bc=
X-Google-Smtp-Source: AGHT+IGHveAvyf9VQNMuaUeANYUoqVyEiqCBjuig3ttka+FXKr64NKcDsnzYcYyNFpL0+xAUIVSp18csP2T4NcfLfgptxT73HWsI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1f03:b0:3a5:e532:799d with SMTP id
 e9e14a558f8ab-3a6f19e86dcmr9853475ab.3.1731017703225; Thu, 07 Nov 2024
 14:15:03 -0800 (PST)
Date: Thu, 07 Nov 2024 14:15:03 -0800
In-Reply-To: <671b3f3e.050a0220.2eb763.00d4.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <672d3be7.050a0220.0db4.01af.GAE@google.com>
Subject: Re: [syzbot] [bcachefs?] general protection fault in bch2_btree_path_traverse_one
From: syzbot <syzbot+e22007d6acb9c87c2362@syzkaller.appspotmail.com>
To: kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit bf4baaa087e2be0279991f1dbf9acaa7a4c9148c
Author: Kent Overstreet <kent.overstreet@linux.dev>
Date:   Sat Oct 5 21:37:02 2024 +0000

    bcachefs: Fix lockdep splat in bch2_accounting_read

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1102fd5f980000
start commit:   ff7afaeca1a1 Merge tag 'nfs-for-6.12-3' of git://git.linux..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1302fd5f980000
console output: https://syzkaller.appspot.com/x/log.txt?x=1502fd5f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=921b01cbfd887a9b
dashboard link: https://syzkaller.appspot.com/bug?extid=e22007d6acb9c87c2362
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14d9ae30580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13003f40580000

Reported-by: syzbot+e22007d6acb9c87c2362@syzkaller.appspotmail.com
Fixes: bf4baaa087e2 ("bcachefs: Fix lockdep splat in bch2_accounting_read")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection


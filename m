Return-Path: <linux-kernel+bounces-512876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 238FEA33EBA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 13:05:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD5461884DDD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 12:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74BFD215059;
	Thu, 13 Feb 2025 12:05:06 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3FF227E9A
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 12:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739448306; cv=none; b=d8sp6r+Sp1K1zt2gSxfsHFYHm9Md0D5oKJdzeFoDUXYokZ6ukrP7Lo4g02/NHsFl8h/CHImsWr42bC26Nbca87ZvudF3mPxmAOl1wHqVp9Vnq9644rYVmoITBvW17U45U9yi3Rm+UPB8BTzd1VnUsfnSZN3opR4JGys7giAHeU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739448306; c=relaxed/simple;
	bh=O8t/ldwp3siSGItZwxAcPWnvaWGLc1lVPCIwZz/O7oA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Hl/8xmRT4Ru0a6cIXax6STs2/CIrUZsdZVTWMSEVph2Qy4V34PpiVfPwsGry8JR3F69+7zWZ8RYLYzuWMSsm6iUquwwfrb887bLOmqLxlx9LYvIodHiOd1WRGR9qze74jHyfHAqNv5TQ1WiNtsjuEOQPmqASdPUm8V9W56Ba/Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3d0225c44e8so12998375ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 04:05:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739448303; x=1740053103;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EM7QVr4uZnuIY2dLdv61pTvrr9JpAr0c8FMwLZg8lzg=;
        b=G0y2bknrE3hYkR7+x+07tw0rbLYRLzyWePsnL847uIOvCP16pyzBiqAVroLPvmzyrt
         KReU4QuB9n+MY3ANfiAf9OKb8BzOqnNERbifkvqOnlCt0sVPg+h8QP68NE2WV/ObuFUn
         3NRhm0/+N1xjpCYOEO0IGrojP1jUj6VvA38yOpsYQN1+j73yirG52eo0AqNf83E61YLL
         RyLUXMome1JEe6Xe9vsIadr4oYRJMdeGS1ytL+JjJDnmDXid52TKFTWnaBYVW/brpCwu
         edU7X9XSakK/BDaziJlyh1Kq/47yx5HTgzKSduQRIYfzU99qPKn/Ew7lFSpUPudmKvAr
         Kjhg==
X-Gm-Message-State: AOJu0YyBSTOUFjKCUWMKzTqRSgevly1cYcdTS3cMl20ZrsNJQamQArp/
	mSJ4hv7KTTzChqAT0WsZUXgBKcmLNV1WfT+wMrAF4PgbfGJESqtmzZCpSfSkKVCh4qolSruntsc
	zoA1FwotVeKb1LKqv4EonHHN5HMLIygIVLHb6Fs7h0kuVUsxWK70aCL4=
X-Google-Smtp-Source: AGHT+IEkjzwFMuoVluU/qGFH/qkW1pBqDJc8+CiWttk8xLHLrsd1sS2cnsyeDHE8TGLLFFR0fLnab2nGKEYHKZ0m0e68ENTd8E6i
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3e04:b0:3cf:b365:dcf8 with SMTP id
 e9e14a558f8ab-3d18c32562dmr30634215ab.21.1739448303732; Thu, 13 Feb 2025
 04:05:03 -0800 (PST)
Date: Thu, 13 Feb 2025 04:05:03 -0800
In-Reply-To: <20250213114144.727875-1-n.zhandarovich@fintech.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67addfef.050a0220.3d72c.01d0.GAE@google.com>
Subject: Re: [syzbot] [usb?] WARNING in cxacru_cm/usb_submit_urb (2)
From: syzbot <syzbot+ccbbc229a024fa3e13b5@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, n.zhandarovich@fintech.ru, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+ccbbc229a024fa3e13b5@syzkaller.appspotmail.com
Tested-by: syzbot+ccbbc229a024fa3e13b5@syzkaller.appspotmail.com

Tested on:

commit:         4dc1d1be Merge tag 'mfd-fixes-6.14' of git://git.kerne..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=13b97bdf980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=50bc644536f5e4f
dashboard link: https://syzkaller.appspot.com/bug?extid=ccbbc229a024fa3e13b5
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14337718580000

Note: testing is done by a robot and is best-effort only.


Return-Path: <linux-kernel+bounces-428966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B0FB29E1630
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 09:48:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84468B3298A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 08:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 853341D31B2;
	Tue,  3 Dec 2024 08:21:06 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDB01CCEE0
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 08:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733214066; cv=none; b=mhB+5o/MQ7WL2a7WkJvnhju9CSyplVWxVqq7XbE8iooRNywCjMkWcxxOpw2mqKV8xOXXWT3p79mBNhUhRaDNITlJ4f+2EZ6JA4iZ1o4OtIanw1s7/zEOcPUbRaBf7SxvTaHsWhWYgOUx2pluEzB9t5dlnsrALVeOs+nfoofARfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733214066; c=relaxed/simple;
	bh=ml2uHO4t7V8hBUvlBvRDiwQbbJ+06fLcl4INsm12114=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=fkY9BXLvS4yRZdSuo5ZNUEiqXY6zNvVlbo8U4kfR7ot+4I+x7OcU2Ewn7COBYTcUw74m3sVfQTZ6SyFbh5vTkB8nSInI1/ykI9DrYYpvvIkbwLwDwE3OB8mDy0OKY3itQNltbBLqhyaxgwHxsz6MBE+CqG92UpS7cQoQOelnwgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a743d76ed9so45917395ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 00:21:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733214064; x=1733818864;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pD9qz2IHK2pBeuWVDCIQigNJXeea/L4R4zID3bimFek=;
        b=om/X61AIayQ7sb7JagwO4Rrf0OsfIqQYpBNDAdHFInWybOKsGZT26vBPHCvcof7bFZ
         kc80giD7E9Bga+dE0gPOJitmFrD22BjPxaaGxALsbeoQUwIC08ncULWTE0aRM++72TOk
         iKHEt2tgRjWnZe9TzXWsAIWyUif2JMfZQpxoCIRAFcFLdbZXJzfdkEpxN/fWsXRTWlgj
         7Bc/t/LMIWOyiseR+YeCOGXiV8Lx5jsyXVa9lEifRYo88ObzvA1ntjs4rPSYivszDqZc
         6IG+5AIXram3gDcL1QTp8l4miBbutjq0/tY2e56bPem8aOpUhLX3L07jLZB+CWS/P7Mw
         oDSg==
X-Forwarded-Encrypted: i=1; AJvYcCUL6SOap2U7Z4KaA63J+4Eor+bTyrRWiB7VERGKOOC3cC33YZ4QQskp4EiI4bQNPgkanzyIoXhfJLG4vMk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkU7leGnL3Pe3e5bWK6RBZJY43iVgyZ6Au8acGaTeQMjY2m27L
	KEX6H1ALub7gIPJZnsy4bGA7ybSoo7F3tqxtaVJukOrpL+ojWf1Ju3D27Tj0HWUp6QZjWu6IKhH
	UNZpI6Vc0HRufn/GXWk5z3jQh7AzhDNb1xa6k6tEdy/YV4nmu33nW6jI=
X-Google-Smtp-Source: AGHT+IGf3eXoW0FMZB8US2fmFDnTRnZk6yDeMgC9hHQkkGTqUFo0lSBIRrVisiICdJf3u3jpqfNagT9kiDO49iANQ9iA9s/+xJBe
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1b01:b0:3a7:9b16:7b6c with SMTP id
 e9e14a558f8ab-3a7cbd45e72mr221625365ab.9.1733214063882; Tue, 03 Dec 2024
 00:21:03 -0800 (PST)
Date: Tue, 03 Dec 2024 00:21:03 -0800
In-Reply-To: <tencent_A26C496423B3445C97605771C6C67369C305@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <674ebf6f.050a0220.17bd51.0042.GAE@google.com>
Subject: Re: [syzbot] [jfs?] divide error in dbAllocAG
From: syzbot <syzbot+7c808908291a569281a9@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+7c808908291a569281a9@syzkaller.appspotmail.com
Tested-by: syzbot+7c808908291a569281a9@syzkaller.appspotmail.com

Tested on:

commit:         62cc82b7 jfs: check agwidth and agheight before alloca..
git tree:       https://github.com/ea1davis/linux jfs/syz
console output: https://syzkaller.appspot.com/x/log.txt?x=11a7afc0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=18d90fa8ec96d8b0
dashboard link: https://syzkaller.appspot.com/bug?extid=7c808908291a569281a9
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.


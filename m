Return-Path: <linux-kernel+bounces-405696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BB769C55D5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 12:11:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BF241F23D99
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 11:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35EEB21A6E4;
	Tue, 12 Nov 2024 10:47:08 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5727D21A4D7
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 10:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731408427; cv=none; b=jA8/j5WxWxUeaEGgNgJ3d/BO5resF8fvWYupKarV7hAzQChv2nhicQHwXj6sdufqA0EKQfjH9o60d6hNni0gBtkhm85B8e6vH9Lda/iRO9DlhNo+4JnkJ3BOMN1fe1CI2YmrBPgJK32R1z8A0UUUQy/hhQ6/+8VXnI/VrvfI9uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731408427; c=relaxed/simple;
	bh=rXIKhEU72H1RcLIFpAa7JunqYcnDVMViT+nYxnw87G0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=jCe8gHc42F0mhzWnyrkwhMivzDJUiwp4B19WV65rKry+GG0nEg8O19p+QVRj/U7GF7/Bn4IbphzoKDw3NWvVxMa+ZPYqqWjlLIXhMGXI6f2EBA4ufAxkRdT2zJjlryszAtqzlmgWAOfHJGtJYrWfKhvDTPn4uVQrP58PlSlK4c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a6bb827478so55508735ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 02:47:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731408425; x=1732013225;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HUEXXXbZsOV3K4ZOSzag31ZTriNveRJONabbIiA5GQ0=;
        b=rcRTsI/mJyzKCHMrFLV/CBSFG+XCGAh6mCReomJ9MVrYgjvq6t4wy0oLMNtPe6sTsB
         VZk551A5Dwmcx2EfvH6e83oqG6nRj0F1NxbZQF9VvRvlgo+kQW/ONF89/dTnSb8py1nJ
         BtmL0mdhFDbfK/ZL5r2QeC8vpXOajKkMO4Z6YAPGSr14UQsqTh8J1wq5hP+wtBGTzIk8
         gCnrmGjjMFcMGFbOR+6LSWGMHCobtInG4d/odY001f8BozYbqWuO0qjZxXWdOfatimBD
         pxze/fltYlSgwatxrU4xRaxdsaWdC1sW5I6wEylMFQ+Zq30pChEOEFMylwA2NUipFEKk
         v4CA==
X-Forwarded-Encrypted: i=1; AJvYcCUh/zeKvzMPG3oop07Bto88ebR8vssRdS/K1RYqYY4oJB6xw3g7/jHS9Dn4XGg9Vfe7eBsRkdvtiAaT5OQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+4wJEb2UUXNjryvNtQZKND32hzQZVg6tC1y04vs+bZKZdOiP3
	EZ8vSqFsAWr0j3JzLKvZyFDY+H8nuY/RpNpYjkseEYaegPwPLbQeQm3qQjMt14FsMjuy4blxQFd
	IEKLNttm7NApZcgwdwbw7SPzF8ySAjVPvRLmf8q8kuUmHxME4s5s5Ypw=
X-Google-Smtp-Source: AGHT+IHZGRC9Lswed6EUSybfxVqaJOf5Ywk+UOv55XUcMFxi/KOPeODSaFm/cPcMIYK8XkU96GoiE6/HP0bVsHLMvzgRGZBSw4xe
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1706:b0:3a0:a311:6773 with SMTP id
 e9e14a558f8ab-3a6f1a4ebd5mr139622835ab.21.1731408425421; Tue, 12 Nov 2024
 02:47:05 -0800 (PST)
Date: Tue, 12 Nov 2024 02:47:05 -0800
In-Reply-To: <0000000000001b6052062139be1c@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67333229.050a0220.5d845.0000.GAE@google.com>
Subject: Re: [syzbot] [btrfs?] general protection fault in btrfs_root_node
From: syzbot <syzbot+9c3e0cdfbfe351b0bc0e@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, dsterba@suse.cz, ghanshyam1898@gmail.com, 
	josef@toxicpanda.com, linux-btrfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, quwenruo.btrfs@gmx.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 42437a6386ffeaaf200731e73d723ea491f3fe7d
Author: Josef Bacik <josef@toxicpanda.com>
Date:   Fri Oct 16 15:29:18 2020 +0000

    btrfs: introduce mount option rescue=ignorebadroots

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16ef335f980000
start commit:   2d5404caa8c7 Linux 6.12-rc7
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=15ef335f980000
console output: https://syzkaller.appspot.com/x/log.txt?x=11ef335f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1503500c6f615d24
dashboard link: https://syzkaller.appspot.com/bug?extid=9c3e0cdfbfe351b0bc0e
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15a1935f980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=158934e8580000

Reported-by: syzbot+9c3e0cdfbfe351b0bc0e@syzkaller.appspotmail.com
Fixes: 42437a6386ff ("btrfs: introduce mount option rescue=ignorebadroots")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection


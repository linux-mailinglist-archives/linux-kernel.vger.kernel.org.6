Return-Path: <linux-kernel+bounces-393077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 050389B9B9C
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 01:43:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D9A4B21138
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 00:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F050F1B95B;
	Sat,  2 Nov 2024 00:43:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BDB1EAC6
	for <linux-kernel@vger.kernel.org>; Sat,  2 Nov 2024 00:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730508185; cv=none; b=cE/UAtKCgZ4w+VChUn7IVnO/9kSFLqFJGWnhlC3P5LIuhjipCVN/NCfh/H9Sz0f5CFHcI3Ws34nIKI8tobhgQ+/yVvjWZo57tND8J0lV4Vr215uMk087o4cMkyVNdU/6nfOqb8N40Rc7O6CY8VScMxpEXGTJ5amFJs0/vHaOJo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730508185; c=relaxed/simple;
	bh=t6+nYbWnTUcQph4dakhbCHXeYuREcutQ2Uw0L+Njw/c=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=mobUmzDDQi+bxbzZk6PZN9qjBg2As3xz6gJHxovUJhhteAF/fr/OOYzNtRP06S2gWGCEjyOaRYk9OjuUETwaqg0ua9B5fviEWe/aLp5OkLkco+pnERTvEY1eeev7uGxbICqMwpCuuuuhEiLrnBV2t2nZHPt1evadlwXeVB3pdsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a6b7974696so8931295ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 17:43:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730508182; x=1731112982;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=blDNl7p3TrZu+StGKdiZkS5V2Mkh+Znm08zp7zUtOfo=;
        b=YbI3+EDePQX4B4F1yrfIXiHYGfj/WwVfrgyFRRwM0K5XiHYacIuJbqvSei2uNLwJxz
         y65qjGW8yoobfhm7eGvy+r95Q/4urbZD68lhKRXPl+1wkJ9pYYcTznsnK9qa0lVLZfX7
         a0AqfD5FmqNSY3n9AoHONA66S42tCJEIJCIMmmkivAgztSLlSNnTiK+B47qQGmXmuyFu
         1MH8eylaL9A+iBz4s+sWsf2lPR13ve2DNya5ghdZ9rlCGRHyGDu1Kvbf7U8MxYk5RBfO
         tusRMD5SIbl7lmCx/vLHBBkVZgO2yBBoLgPjqx/DMY6cLbLHUHTiUoGvUCaLeBOHIBhK
         OZcg==
X-Forwarded-Encrypted: i=1; AJvYcCXkLfq7INuI9GKrbFC6B1aSMm1TLZB8lAgfAcRL0XoHuP9PgjG3FYHpiJZa+t5jM4KbDxNA6mLpwbq89ec=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9Ta2qAfqyErNW/Xy9yIfmGGTj9siwGXj8vRwp1OqCvb4OHGJl
	6yR/NDdNhLJLQ1ggcPQbA54JQxFoc+zGq1eW79ha66GGSVmYW5SOD4RTpRs5hfsvTrSQyY/z4HC
	SO75D5nS5X20qKsPHsVMb7Ks6bHLJBtebNQqkapYE8vNNuMmjuqMG4KA=
X-Google-Smtp-Source: AGHT+IHuX3D/YUJcxTR7pHn9w36Es3rDqsxXIZTtq6kdzV4AeD4s72qmH15UucBYNu62Uw0qCKqYE74K7+7IeY+fiSey2rl0X7Ah
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:218f:b0:3a6:af24:b8c4 with SMTP id
 e9e14a558f8ab-3a6b0354e19mr60407115ab.20.1730508182395; Fri, 01 Nov 2024
 17:43:02 -0700 (PDT)
Date: Fri, 01 Nov 2024 17:43:02 -0700
In-Reply-To: <ZyVs271blMTITWVZ@fedora>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67257596.050a0220.3c8d68.0912.GAE@google.com>
Subject: Re: [syzbot] [net?] general protection fault in put_page (3)
From: syzbot <syzbot+71abe7ab2b70bca770fd@syzkaller.appspotmail.com>
To: axboe@kernel.dk, davem@davemloft.net, dsahern@kernel.org, 
	edumazet@google.com, hch@lst.de, horms@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, ming.lei@redhat.com, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+71abe7ab2b70bca770fd@syzkaller.appspotmail.com
Tested-by: syzbot+71abe7ab2b70bca770fd@syzkaller.appspotmail.com

Tested on:

commit:         f7270670 lib/iov_iter.c: fix iov_iter_extract_bvec_pages
git tree:       https://github.com/ming1/linux.git for-next
console output: https://syzkaller.appspot.com/x/log.txt?x=12849630580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3ebcda5c61915e91
dashboard link: https://syzkaller.appspot.com/bug?extid=71abe7ab2b70bca770fd
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.


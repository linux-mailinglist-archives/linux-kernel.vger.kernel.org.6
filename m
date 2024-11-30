Return-Path: <linux-kernel+bounces-426017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A34A9DEDC7
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 01:21:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C30B1637F5
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 00:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39FBD1BDC3;
	Sat, 30 Nov 2024 00:21:05 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773DC9474
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 00:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732926064; cv=none; b=o/SpdPHnJqawQ4gvWE+2Yalwiy7Io4IVsDF08sfjXnXfpc2HwZ4Ihi94Pr64xRYVr8Ichd4/MmD+SycHs3LNxxA6RbHKXc4bUY/aLeTBk6skImXp7/zbBTtv/3TPBeLjYj7987JKYkiHyyxN0a1KHBce5Qu814NNBwX2YxsHJNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732926064; c=relaxed/simple;
	bh=0EV1a/PEqgBijVEwNPL6KCylvy2Zu2KPS5sJdNJ8kBQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=C2FVUByXlAZ2tvLN47+KDBNjCSvfqxkhLnvvweg2GkAJ/hzP0u7TO2knwaF/LSw1xOoReNWp9dk8WR5WWDStY857t1n+iwO7L/BLiyCpLFkS+gW3riMyQ61qqHucv1Y6EGE+Bg1UhJqYYzlxnjRC/Fj48bvbrjzJQ3mB+/y8VTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a7de3ab182so10681315ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 16:21:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732926062; x=1733530862;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FVfJflQw+zqDYWm6LdH2mWrvKmzl57FI/2or0aBkVqE=;
        b=klaxz5H/MJIsmLCQ+7C0TFgzsfZuYztIzw+w626tdHY2LEu+/B++fVCkx8PaZrUd2u
         SJlnjSfEGX3KWbrvRGD5EFFAeMXsPTg6y/mwkySt+bHx1Mx22jvEyw5dVndyITDLm0Tg
         U0ZQEMNnz/+/VmDgJRZygCwCnIHAwdUXsbps/0FWPZQw7zrf1l33uceGeuozScBOH8yc
         c/XgWirGdpzxLlXHz8nun4S/Vo2cv0h7Yaa2KzI7ltm3OaICPY5xzVzEpcareNZfv8qq
         NMYvG6ktisJiUbcB+QzT5hgL0bNoVE3ga6BClSmUyHIGymwX5Jq4Ax62m8FER8J7jvVj
         RJ+A==
X-Forwarded-Encrypted: i=1; AJvYcCXDSaCsAoA1njNM4+IK1O4Nkk4LwIUTglnBbMUYVYR7Xk8zlACdJDmq3wPQb6t7pDVQJVTjfEhqH+BbHoU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxO6th1EC/HYZkYz4R8FARRWDhWoj5Vui17e1fOvpE7d/3M+ahB
	jP9c7jZPhUNNFO3S1Je49YwRrWsGhbZGDMotIZj3stNRrl0noHWhyMB5YuLevC5wOAm76IR4ii9
	DeW/aZI5i0EC8agwYc46zArbNN6iyT2B0U1PsLYsEYWvScAOyDxE0AVY=
X-Google-Smtp-Source: AGHT+IFVKCt77VV9eIgoBFjrQ5FGd4u7RB7QruWUYFiSaKsKMQCsCEdI8hJAH/havveNDzJ2pYVF2QA5tIzx5GFl6ti8PZAgyMCD
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1aaf:b0:3a7:2b14:add8 with SMTP id
 e9e14a558f8ab-3a7c55da135mr159559955ab.18.1732926062688; Fri, 29 Nov 2024
 16:21:02 -0800 (PST)
Date: Fri, 29 Nov 2024 16:21:02 -0800
In-Reply-To: <66ed861b.050a0220.2abe4d.0016.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <674a5a6e.050a0220.253251.00d3.GAE@google.com>
Subject: Re: [syzbot] [netfs?] KASAN: slab-use-after-free Read in iov_iter_revert
From: syzbot <syzbot+2625ce08c2659fb9961a@syzkaller.appspotmail.com>
To: dhowells@redhat.com, jlayton@kernel.org, joannelkoong@gmail.com, 
	josef@toxicpanda.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, miklos@szeredi.hu, mszeredi@redhat.com, 
	netfs@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 3b97c3652d9128ab7f8c9b8adec6108611fdb153
Author: Joanne Koong <joannelkoong@gmail.com>
Date:   Thu Oct 24 17:18:08 2024 +0000

    fuse: convert direct io to use folios

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1033bf5f980000
start commit:   b86545e02e8c Merge tag 'acpi-6.13-rc1-2' of git://git.kern..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1233bf5f980000
console output: https://syzkaller.appspot.com/x/log.txt?x=1433bf5f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5f0b9d4913852126
dashboard link: https://syzkaller.appspot.com/bug?extid=2625ce08c2659fb9961a
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14534f78580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10c3d3c0580000

Reported-by: syzbot+2625ce08c2659fb9961a@syzkaller.appspotmail.com
Fixes: 3b97c3652d91 ("fuse: convert direct io to use folios")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection


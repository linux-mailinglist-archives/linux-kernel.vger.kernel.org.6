Return-Path: <linux-kernel+bounces-437390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E27C69E929C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 12:39:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C02CD1615CE
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 11:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1571722068A;
	Mon,  9 Dec 2024 11:39:07 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8C021E0B7
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 11:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733744346; cv=none; b=cn8E0yNsvGqJeotFr7UxDmQraJSzKSkL+UCyRZvAL2tG9q+P7lFZvB5nnR5CrETP6b4qhZaQxEZvOn9ocHgakPJrFHHN5bytXaTYe9yOfGPt5C+cOk6t+05JHfviK4J4oVMlTSjVy0527QMarXrWaKWKB0os5VoK7A2W86hvEJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733744346; c=relaxed/simple;
	bh=GU7SOjLnotPa8TduYqr8NJu1K+5bHJJ7InVWkzllNTc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Tw7srPVwDHfQQY+g7LIrUYABkmrgNKx+wpIJYPv73MBwVHtUx46RzsDbqtNdw+Gxfb0+Ycq+absAv3lPnnw/xg6SRyVEvoIu7eS/M5SZK3TyXx0v0d+BCRAxw1Q/cncGktO2+qY+3lVwfdREzRYo8ML8EjC68X8zfiJPGmZERmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-841a54a6603so792209139f.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 03:39:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733744344; x=1734349144;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qGJBfih2L09GjPmbfXgAmIq7oSncUePwS+DVdC+7iFE=;
        b=dg5qpnyZUqsPIyhCSkgdVl22fJf8x/DLK1sFOhePnujC7fbxmWZlqh4ft6m+hmnj4x
         nE+BNFAGSsbbQZeyejRWfecleq4Go/xM52T/gwdInhfOprmHu9dkoP7ZR76RIYrX+3uS
         EQLpn9D4/iCDfFu/4VGCFa1IJWNSl4oOz6zHa6g2jBIV8a0U3ak+lSPKmh09LCzZXRn2
         MgnERmJNoiTcRjW8UIxvYmYV8y/OWVwWlXPriEyemn3LOS52PEvRpHmeVZ42YNVF2Jg2
         TQJZhaPFplF8Rc7H0SeRyZ2parXiW4l1iWTkdMYq844OXz8KMnR3y4LfRa5YiDi2dU2l
         xm1w==
X-Forwarded-Encrypted: i=1; AJvYcCWdNXimWRsWWKUhHvA0lUdEvDlQNr04RAVvdL8yWI3cp6Gmwka7wdSQhzO8O/B1iMizB54jCDu1LddQID8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyL3/HigXdGF7l3TNhLYZ3de19ODT5q3dl5L+7UwT1LLPGMq5QE
	U83MLtAOJs3jXVH5/4cNptokAnMcZZ5ZlcLOk/HEnMnThUcgLB0iUsB7z8/mcAV+/d3NKEkSKhb
	eYRQwTdZfm1K6nNDACcIjNVKPCeK5rM8WWx2hT2cNREAjrctQLSTZjFs=
X-Google-Smtp-Source: AGHT+IEemdCmvMDvz48Wl1w5ZZ28ORluCAh8UU9moRm18uYk3uTLaJ2evTW/Un5UMkfXDY9CYh0nV1TkwWQzM9QIqeKtojMl3rGo
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3417:b0:843:ebf1:16df with SMTP id
 ca18e2360f4ac-8447e3bd09bmr1116952839f.10.1733744344478; Mon, 09 Dec 2024
 03:39:04 -0800 (PST)
Date: Mon, 09 Dec 2024 03:39:04 -0800
In-Reply-To: <ead9bcdc-0dbf-4b3b-adab-a5f37cd1a09f@bytedance.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6756d6d8.050a0220.a30f1.019f.GAE@google.com>
Subject: Re: [syzbot] [mm?] KASAN: slab-use-after-free Read in move_pages_pte
From: syzbot <syzbot+1c58afed1cfd2f57efee@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, bp@alien8.de, dave.hansen@linux.intel.com, 
	hpa@zytor.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	mingo@redhat.com, syzkaller-bugs@googlegroups.com, tglx@linutronix.de, 
	x86@kernel.org, zhengqi.arch@bytedance.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+1c58afed1cfd2f57efee@syzkaller.appspotmail.com
Tested-by: syzbot+1c58afed1cfd2f57efee@syzkaller.appspotmail.com

Tested on:

commit:         6e165f54 mm/page_isolation: fixup isolate_single_pageb..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-unstable
console output: https://syzkaller.appspot.com/x/log.txt?x=1760a3e8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3884fb5fa6f2533c
dashboard link: https://syzkaller.appspot.com/bug?extid=1c58afed1cfd2f57efee
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15aa5944580000

Note: testing is done by a robot and is best-effort only.


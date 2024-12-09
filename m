Return-Path: <linux-kernel+bounces-436864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ABA549E8BCA
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 08:02:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2A31188453A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 07:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C72AF189BB6;
	Mon,  9 Dec 2024 07:02:04 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4A51EB3D
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 07:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733727724; cv=none; b=dNn43AzCePEOx4d+QarPTQSXyYMNBpkt5kIi+SXio/JpgCxwy34nU0VkXs+epOox7Qzjp+XPYR3h6Dd8MiWIsoFpjab72bkRa5z7WrWNrkYfkDksaSYgmq4XKvtoJb7gpglabd4tBZXflxhSNwEwW/BMVkBOTIFRuy5W7BoNX6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733727724; c=relaxed/simple;
	bh=uXqaOZLYTSzqn38uTSnGASTw3xguX34IgAHXQaVldnY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=XFDzL+XNN9sXTIGDplenH1MxOHi4LF9tb6vDzwT6p22ZJxsvTylAbKhd8yBTP1jZv59Qe41A4f5gBuHd7vT58kd224hoNJznvoRpa3ndC8i5CfFB2VNdtnvWLmVMp+lOdWD9jVkkqBf4isdfu5hQE3t6W0V4OS1la3rK+lycfM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-841ac3f9391so377755339f.1
        for <linux-kernel@vger.kernel.org>; Sun, 08 Dec 2024 23:02:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733727722; x=1734332522;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zr+lwAUB29P2Bz5OdKQKeL1RwgIMuLsOdWcrCXkf3BA=;
        b=ph3+v07fAFl2pO131am4lWGxYWvIXkEogcHHLqk0iHFPpB/fJq2i/HI7TXsiD0PCal
         6slaeWr2VAkqFXN1VkMAA+IVHv+SJfGrmLdmpT+0JtN5k/tcgDMEneiP6YyceNTKraXN
         jQA5Jj0G8lgnrkSX0mn7tvgpmh9iIl5I6kulrXLXxGjShCTCxv9mAZTEpg9SbEABtDBL
         9ACvkrhG3lNugpMrelIXvzCtFZC7vyh/u9OgdgndScDvJ3Lz8qak1gIBYs+FG1Se1Dgi
         Qug/MV3phh5pmgUJg/HMDp79mh7kz2h7rgr1YccEU0oeX37F5CLGngCbkieywANpB29+
         /QBQ==
X-Forwarded-Encrypted: i=1; AJvYcCXDwqhF/p+J1wQqfN5i371OH3mPy6gOHKyFu/S0S1yUPuGsRemM0CjbzjiPTKmaojK+GG3CiJrl3SZWxXY=@vger.kernel.org
X-Gm-Message-State: AOJu0YweS8+YBEHPs2EkBuJPXl/9zXnOBl9O3Jn5NYmsfzylFlBUt8Zq
	7YFLrlnSyEyjxo489LPvBwgxY2ICU6CwRa6IhWeO5GW8BFDhq7s1hsSRvZcF8oBHVJxyULuYa3R
	QZGcSZohKy72U6n2h5tTvF49ucbh9YSm9IzEfOM7RUFzJC2CiShRjMDg=
X-Google-Smtp-Source: AGHT+IEIKycqAdN2iPadF3FhDNP9obHhwOyXaFfA9j14ld9K4tPd3HjioI9kQMSQDjoSByBYu50vb3h2JpeqSwts+/31fn+pKjcV
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2b84:b0:83d:e5e8:6fcd with SMTP id
 ca18e2360f4ac-8447e2f3afbmr1389918039f.15.1733727722210; Sun, 08 Dec 2024
 23:02:02 -0800 (PST)
Date: Sun, 08 Dec 2024 23:02:02 -0800
In-Reply-To: <c3379af4-cfc3-41e8-89fb-1ad5292d952a@bytedance.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <675695ea.050a0220.a30f1.0191.GAE@google.com>
Subject: Re: [syzbot] [mm?] KASAN: slab-use-after-free Read in move_pages_pte
From: syzbot <syzbot+1c58afed1cfd2f57efee@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, bp@alien8.de, dave.hansen@linux.intel.com, 
	david@redhat.com, hpa@zytor.com, hughd@google.com, jannh@google.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, mingo@redhat.com, 
	muchun.song@linux.dev, syzkaller-bugs@googlegroups.com, tglx@linutronix.de, 
	x86@kernel.org, zhengqi.arch@bytedance.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file mm/memory.c
Hunk #1 FAILED at 7023.
1 out of 1 hunk FAILED



Tested on:

commit:         6e165f54 mm/page_isolation: fixup isolate_single_pageb..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-unstable
kernel config:  https://syzkaller.appspot.com/x/.config?x=76f158395f6f15fd
dashboard link: https://syzkaller.appspot.com/bug?extid=1c58afed1cfd2f57efee
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=135d94df980000



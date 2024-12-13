Return-Path: <linux-kernel+bounces-445383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE2E9F154B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 19:53:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D6762849D9
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 18:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 129B11EC4D4;
	Fri, 13 Dec 2024 18:52:16 +0000 (UTC)
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DEAD1EBFEB
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 18:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734115935; cv=none; b=oX4XQ45+CnIJlrzKt/UTQAWH5FGjpTYTMyPxP9XkO8G7+WEVCpNYnbPe7nNCfkZYodLWvF4hHNAunT7NAqwmgkBQOTGWw3BTymG48cD6UjNdTlQeLoiiowbntQbsYdvOTcdClUDpARUNl0lPyEYzbA9BkXxSHPCvRDTOYFVgECo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734115935; c=relaxed/simple;
	bh=23Gjf9konJzi/Ip48N8QGnIMi5oXcbsgX6/s7AOn8pg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ofWZ1Bb48E+vSwVGY8VXYG/xRS4vOz+xJoZYsofTg6p7k/JwVhTSDJXpYC6iT/17nZZLRIjf551v6o10lhK4KUSbdcdOmmuURQwwLLXtS9sbrVhwHCi8yDIcJlNRe7Om3i4xz3ws60YNBu1nvuFN5LuslVRVGgevePVelIzbxyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.214.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-216717543b7so31342485ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 10:52:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734115933; x=1734720733;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z5TW7o4tu1FIGXp5hRq/0957PxrI+bJYgBBARrfFwa4=;
        b=o3jesZcW0qYbUqmT6BCJANitvq1uxJWQV+Y3M7GGKwC9DWrudCpPCNArUroDpKj2nQ
         7zU8LsdJfnM6SA42Z4dhlsKoQ7QUhkT6jPL4F/NjhRJQho06dpr31bmVAAkprePzTuIg
         YDC8zAc/LHeSM2WouwjRJHAglRyi0SNOZctAA/p+lSrouSR6R+wWu5JeRAQiVGCdIPd9
         WgJwrQeTUrmJYs59/lSToy39djPKHpvy0BFzQu6d3s8e92qi93FU1R6Sk93UK+roRgbD
         Wxbmj/2dAIWUw7oa++5/RXBZOdl72He2oEB1iCIMUmm95rUZRMj+KkDCQHAI32JqmvGQ
         lcCw==
X-Forwarded-Encrypted: i=1; AJvYcCWxRawnDGI/r9exEdH2Z1dVxQ78S5R0etbf87ofuKeiXEIJIzqA67ojQZx38zP5fTnc6J+qT68sqdL5jXw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/PO7OE4ylObgzxE0Erbv6cahqBxpKjo2B1FXmjiu/0mZLCvTn
	b6ZcKSl/8pnYefTfw63s5yxgBDGT3wtJ6uFEsOpxfIxXdq3b11/m0scCmKKvu/kuE+/7RKOm/TV
	cdTudYOkOlkgAX/jT0AFMP0pxEWj3IFTxAx9aRQdcMpGBOE2sbhpw+Mc=
X-Google-Smtp-Source: AGHT+IEdNDXjvyhHCcwjAoMxwBtaxR4ax4S2ngtkkPoSjsyW6CqCCGH1b4iGOdSKRP17T+vKfeoiKNNOa3orJTIb9LLDfVQxJf4L
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1561:b0:3a7:820c:180a with SMTP id
 e9e14a558f8ab-3aff243f6a5mr33809635ab.19.1734115622707; Fri, 13 Dec 2024
 10:47:02 -0800 (PST)
Date: Fri, 13 Dec 2024 10:47:02 -0800
In-Reply-To: <20241213141350.x4gSe%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <675c8126.050a0220.37aaf.00b4.GAE@google.com>
Subject: Re: [syzbot] [exfat?] general protection fault in exfat_get_dentry_cached
From: syzbot <syzbot+8f8fe64a30c50b289a18@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+8f8fe64a30c50b289a18@syzkaller.appspotmail.com
Tested-by: syzbot+8f8fe64a30c50b289a18@syzkaller.appspotmail.com

Tested on:

commit:         f932fb9b Merge tag 'v6.13-rc2-ksmbd-server-fixes' of g..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=130324f8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=df9504e360281ee5
dashboard link: https://syzkaller.appspot.com/bug?extid=8f8fe64a30c50b289a18
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11475be8580000

Note: testing is done by a robot and is best-effort only.


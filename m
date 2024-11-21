Return-Path: <linux-kernel+bounces-416628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7725B9D47FE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 07:55:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11DF9B222EA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 06:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82A8A1AB6F8;
	Thu, 21 Nov 2024 06:55:05 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E7817BD3
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 06:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732172105; cv=none; b=jJdZeXzffAwEbDFtqH5SPw8JfeB7Ve3HFWTgNgUz/MgrXBnexR5EgcTSWCWeSs/WpoaKeSfYnf95mE34VqnrnC8at271U5a7kwyI5XIG3051a/1oM/gLwFYutwVBBMdpmpZCkoJBISO1KMeBR7/0IqfyfPHmBa9UJtTet2vQlHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732172105; c=relaxed/simple;
	bh=C7cGIE7AQJrauoMKefRNl3xvo1l2sI8CHpg98japBI4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Fm6y91RXAXDhTWzv6EgIm46NOtGPfpBquE1fZ3wiCphHxqvDz5mVD6N+KdIuFb6EspHRw58k4PwiUm++Pj7wuSPoyhJPnawS2k7+LO0y4R11NSkDmcpkbf2tVXQOE0Gu/TeXfLvMDNT+H/E+lofsZEtFI2Oaq4Yv7FXO4OdRbBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-83dff8bc954so61847039f.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 22:55:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732172102; x=1732776902;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nlSMiK4c2nJW1z0useNTR2GNEXUW1ZkEhNgytzKAtqE=;
        b=N39NdKSPKBsffvCNytQaImURiH7dvg4U8nhLZm37Ne7sDa65aVJNZQXo1tNG/DdSu6
         AzieslNiEhSo/jM8V9JdalnmUxQFTQZGS8gQf0x4dZdZiCCIOHFkJj6nbLZujubGFoKB
         L80JbAMSgoZBee2cogUXIq2KN9WQVgamgX04n8uzMt6wUHoXaxEz6nCrPc+82GQSiEBw
         x7uvOVx/+eID6e0H2I3vtpWGsVij/efNtPumJMw2dcNEb5vDlypOOfhm7aNAxgX5nQZE
         F4YNNRKs5KNXmU8O3KDmJJ0A/BCFf8aoZOO0JOyK9eKohQG1/WSx7A5mhcJ0C+m0OLkl
         p6Nw==
X-Forwarded-Encrypted: i=1; AJvYcCXF+VocMy7X6Q/0jYLMxam/ewwSlT/d0u5o41/n+tsfujT3KPXtf9kjO7bkTssq2N37QSlFYyr/KIgFP/s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqErWl0Z8ZMagIwKSGOTl6b6BtiZyoG++Z6HW9NbV1vprblQrV
	3fBxRj+dvYGhJsiCy0tHC8G4+w27mdc29jbQLKejJfkrOcgwgFa7LQAbuq/MycKOeppTfpW10mV
	uGP9wTT5BMBrJ3Qf3YMNa+FE4GXkV0WVWUUPs6tAWJfBONVlBXVeU8zo=
X-Google-Smtp-Source: AGHT+IFIqMdsoXFfZY/PhHFxSxNBTVF5SKYVVFkorPTebwuTAdtnLR4mL8g2X9iirgxc0lPh0kOPBuco7w1u0c4TZFeyqnwOx/df
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b2b:b0:3a7:7fc0:ee16 with SMTP id
 e9e14a558f8ab-3a78642f030mr58861255ab.8.1732172102178; Wed, 20 Nov 2024
 22:55:02 -0800 (PST)
Date: Wed, 20 Nov 2024 22:55:02 -0800
In-Reply-To: <20241121054658.Y25c2%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <673ed946.050a0220.3c9d61.016a.GAE@google.com>
Subject: Re: [syzbot] [netfilter?] KASAN: slab-out-of-bounds Read in led_tg_check
From: syzbot <syzbot+6c8215822f35fdb35667@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+6c8215822f35fdb35667@syzkaller.appspotmail.com
Tested-by: syzbot+6c8215822f35fdb35667@syzkaller.appspotmail.com

Tested on:

commit:         dd720783 Merge git://git.kernel.org/pub/scm/linux/kern..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1472eb78580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e6d63a300b6a84a4
dashboard link: https://syzkaller.appspot.com/bug?extid=6c8215822f35fdb35667
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1501f6c0580000

Note: testing is done by a robot and is best-effort only.


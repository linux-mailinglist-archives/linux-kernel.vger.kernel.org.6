Return-Path: <linux-kernel+bounces-329216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CF2D978EBE
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 09:07:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4238D1F27016
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 07:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83B481CDFA1;
	Sat, 14 Sep 2024 07:03:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB4719A28D
	for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 07:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726297385; cv=none; b=ERhKjfapNkPzB/+eoc9+MYa8MrGI3OyhrtA7Shu0D9+C8jpW/Gnpw3l1T4oeKK5nijHoD7M5IE3iXZpzKvKobhTTFw81XeDtBSin+5/dqkq9j52Xqr4eJ0/M0AKYnl8o91ZPNBSqp151kwYaeaQVPr1zpiuoNzZXg35pJT1b7ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726297385; c=relaxed/simple;
	bh=a+gA+cCmzq3kDhPz9MnS1+QNhN2B8omnsY5KmZNJJ1I=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=D0LtL6HwS8I3QmvrD9uyBG0qBqvkiZSIvzqgVfVVuTdvesDute7f8JrC/BssHsKq/hdphwZV9jk+cuihsGSn57inZ29XMcepNnhRLeUjHqQwaxQCypx3o6nwLTGcW/03XqRlbrj0gCC/0aoBz1YCfZ5PjJK5NZ8Fzyqnm8tdrOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a0862f232fso49427215ab.0
        for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 00:03:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726297383; x=1726902183;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0cgYyxj1JymujBuy6kZGBfB6QpXUxYpKiCNt/km+idI=;
        b=bHDpCEptRvVhsG2FqudHyv2liZq0UP4SAbbFx7CFRJA+Ss+MfRHrpG0JNYLYXNxYE1
         3wiYIOd3HJYXff+EEGw/56Pdlb5Mqea4GqmenlkbmS1gFX9vWfllOYhEJMxLEax/dgSJ
         KACOgbKQ3Evba7H3+m7TXSh9OAQRy4nsfYiHCzBlSAryreZf8hWNrI+PR9EG5x5Sl1st
         oVKCbV2zDarjK+mhGM6qSQ2ClogKPySGUJuxO761Y75eZ469n7/NRCgIcdAwitK/PtnS
         3QMyJ/OX5H7tYKzWMAeVtT0iaHxnzZNM2YJ1ZK0+a8AiiNBky987W7fCa2vSE437MI4O
         +05Q==
X-Forwarded-Encrypted: i=1; AJvYcCWoYdYtkE3qBvjumdZhLOGzPRV1/zWvutNE0KsYm42ytWdMIKDoax+yxoRfQ53c6tppBCKXeCIqrffxYzg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBqVoL2ubZi7JWT1Yp2vXqKRgycHs/voT1IDs92ZQhoyMT1kMx
	l98qApgiRGFYbLjBZFawv/a5j+eL6jibIA3kmfBmxsScVh17q8vKez61tQ8u1WqVUSMtQitnEoA
	S+8zXAx8r10quD5FYaYbmJbjsZqDMf006SHXBlgaKSj0mD/GWGTJEGUI=
X-Google-Smtp-Source: AGHT+IGjxBa1Qe99S0Q75VIuQNI4uVBVunBwYCqjYx8ndy6tN8vrr2EIFSqk3ClCcEARcKcgxh9vdKkdKdTyvopPauPjRg6mGL/G
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:13a2:b0:39f:6180:afca with SMTP id
 e9e14a558f8ab-3a08491196bmr112412095ab.13.1726297382976; Sat, 14 Sep 2024
 00:03:02 -0700 (PDT)
Date: Sat, 14 Sep 2024 00:03:02 -0700
In-Reply-To: <20240914064158.75664-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66e53526.050a0220.1f4381.0001.GAE@google.com>
Subject: Re: [syzbot] [btrfs?] general protection fault in write_all_supers
From: syzbot <syzbot+56360f93efa90ff15870@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	lizhi.xu@windriver.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+56360f93efa90ff15870@syzkaller.appspotmail.com
Tested-by: syzbot+56360f93efa90ff15870@syzkaller.appspotmail.com

Tested on:

commit:         b7718454 Merge tag 'pci-v6.11-fixes-4' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=136150a9980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=61d235cb8d15001c
dashboard link: https://syzkaller.appspot.com/bug?extid=56360f93efa90ff15870
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1731349f980000

Note: testing is done by a robot and is best-effort only.


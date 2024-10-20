Return-Path: <linux-kernel+bounces-373269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B609A5477
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 16:00:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D272B1F22020
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 14:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F068A19259B;
	Sun, 20 Oct 2024 14:00:06 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24F7193078
	for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 14:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729432806; cv=none; b=gxz0zb5E7twK4/TpgJysYTtW35BC6KRGbLc9CG69+UAZ90cfoTH4p3KBidCxBj5/eb0USUC3KwNYQXmahTvQhw17+IMuCr/ksddvbxieXpUUpPv4nVj8rihZM0LTNBD/h1q5+krJbgj3APkB6tFOvwpTMPD8cfLBTaAWpOpbKTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729432806; c=relaxed/simple;
	bh=rUQrLhwWxKOY5jgPlr0oL4Y1sM2HEH6Mt7die/aH6ms=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=eejdBr905LkmXVHZpCa5oEn5RSEhx7cxZZ54Rr1fuCDDBS4PCz/ebZmoKPxTaS6tNC+8pG+CZF+3iVXAJXV4LekbXgvH4b7VXwjNa3Rc5M405273C4s4GfweGLw9d1HJUh1AJookqolydfS+UokDhUS26SKbvxPBTj0qly3BxKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a3b7129255so35151165ab.2
        for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 07:00:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729432804; x=1730037604;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fltwTQu3GyCKZz8VrMg8t1f9X/GDWSqqya0RcvyFpLc=;
        b=cG7x8qJM+WA8/eI0a8R4rVVIVMbLpiidbgqCczYQ+8NXvcBEe7+ENKdQGRps4SYDtG
         u9iD/ag3dJIQHMkDyV4GC99PHzHY5XT1x4vgDFeDtYbDYGaeTaCvSrlGIxEHnftIE6d/
         2u/XIcy6afrhVetZNEvaObiC+wtDdJBnWTezmFOlZFPgiB7V2Pe1AttAU2Apf7ysMhWJ
         JcViz6HfITxlv0mAUnsTOPqJeQWcjIW9VEuNDNKSVJ5UVbmgxv+hbKu8J1VajG5WP0n7
         YuOFNUw3xpm9uSWK8E/kfXi1g8ODP0ng5zQnGnO4c5eOXDyZyTH+cqrMWZz9WDxraUSa
         sbaQ==
X-Forwarded-Encrypted: i=1; AJvYcCWr/Ff8mXGkudHidLz82fy581n58qz0rCICT7eMQ/nFos/l1Dyj9fUM1qVRabbTnRL4ufXH09VjWekeVUc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTQxpRBDPMJ4+pPp7e5P9FjTnRG/XwWqSR6aiwH7UtTCqFXwFF
	BSKbg7ZPUzPsLSKnffFLVl7mo6Qzj+YJgJ/BFioMiqvLdGdzUIrhKeNWSM/y+kR5Zw3kzPfrJfJ
	6J+pYWOxn+vw1flTBdXRXTW/mR/WqUvnjY/ddsjSybtPCzSsXuhLiTvA=
X-Google-Smtp-Source: AGHT+IGsX9zyGeg3RfeBZEGPLpLwnpY83dn7l2cwczJbJApP341Na+vAeZGUEtQQANCNyiuQXPMqQ7MbJN3OeRJS1xc0K7lIxE1z
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a08:b0:3a2:7651:9846 with SMTP id
 e9e14a558f8ab-3a3f4060bd4mr77134315ab.13.1729432803784; Sun, 20 Oct 2024
 07:00:03 -0700 (PDT)
Date: Sun, 20 Oct 2024 07:00:03 -0700
In-Reply-To: <CAKwoAfrCsg9pB7SuCaNW=-MZqNGbULkLRq-jEzGMzW3HvfjM3w@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67150ce3.050a0220.10f4f4.0032.GAE@google.com>
Subject: Re: [syzbot] [usb?] WARNING in thrustmaster_probe/usb_submit_urb
From: syzbot <syzbot+040e8b3db6a96908d470@syzkaller.appspotmail.com>
To: karprzy7@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+040e8b3db6a96908d470@syzkaller.appspotmail.com
Tested-by: syzbot+040e8b3db6a96908d470@syzkaller.appspotmail.com

Tested on:

commit:         07b887f8 xhci: add helper to stop endpoint and wait fo..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=15998c87980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9878fe11046ea2c6
dashboard link: https://syzkaller.appspot.com/bug?extid=040e8b3db6a96908d470
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1000a430580000

Note: testing is done by a robot and is best-effort only.


Return-Path: <linux-kernel+bounces-376174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71D959AA125
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 13:29:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32B69283414
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 11:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B8CD19B5A5;
	Tue, 22 Oct 2024 11:29:07 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422DE6F066
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 11:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729596546; cv=none; b=eMUBEESv+PZCOsTHy1HrluozaXOC+b4Ca/0Gt8XSDWmB2IiK5KHxlSLNDRilywhG/PB2ymgl67b4rEFTTW07MJNJah1rTI/zjZu+ttEYqfm7YxTHXSC/Pu5qLjhJu1JgRp+hTTtyaKvP0VlCi1uJRj5lRjQNDgZRSwmSspR87U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729596546; c=relaxed/simple;
	bh=hevGWAsdfK8dk5DUe0PVrgnUZPBXsi6dVTyVeQ532jo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=BfYDRchinDL/NkEmNeNqDWvEFsduZbi1JXh39SNJgfvf2W1tnegZs2+IepZDU5neIqIduYQnxNglmxVEwHUEejBxGwv0XKO47utohMThy3xfCf3pQJzaFv0Z1wuP+nqC+RWh/DMTI/rjVsvVr+oVayxeMyt3xAMxtWfOGWRiICQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a3cc9fa12dso48131035ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 04:29:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729596544; x=1730201344;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=toD/Ny4ph962U4EoJ2Pxy8MXsX0tsUU9Wn32smRADak=;
        b=tnXLO9EBMpWgLWvYe1sl+XNoWR1Ko/cr4XhYceiydZWa91mGxdXJptTLPfy3Omnqgp
         v2hccysjH27Xj6VHGeh6EEe1XkEzZNQPa5rhZJbGq67hglnFK+KT8/kdz14o6Ubwds2m
         y03PtK8aQZLbWnj52dFCcQ2NEkJnpd0c1s7XhMFsjL37LtSqV0j8K+UWYoLrn9St1T8s
         Tex1eHK+hy2geHeFjPO6njYjcSDNxTrL4Uac1JLeBlsrmjTZOL7nj5MwPirSZtgt+kwE
         Ub0sgXl7EpZunptZtxKv+uZ0V3pTWu+VmnCsMWvww1LjqUXXIEqTnTy4E15vPPiS2Dzc
         OEHA==
X-Forwarded-Encrypted: i=1; AJvYcCVJV2c7emYDWQoQyvJr1Ga5B6KMhDk6hd+nzhAlipe6/eFiHVlyC0FRV6Ie+BSQJ0+RxbC/OGujz4sG1kE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzT3QKKT8kthUVc4vognleGcP9IgmkgBQM84r7StHGaRgyUHUj+
	vP9xLu2I41J8ocyhfaNThuxa/7xUfygUunDaglexSGC8I+6CSiJWcNIpK3E3U7BHjo6pxSLYszJ
	WJIJr039lFp1tB+cHhUwLSXwiBqa7L46rv0GTacxyI7vKZtmaS4y6UXk=
X-Google-Smtp-Source: AGHT+IEMuP4b7UKrLT5+CEbq0tgutoatABpi5HtgOp+vUzKfz1Poq3w7NNU8fMGEOalljN08wCi0fdAV83UtfGxPnqRPR26347Dq
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20cc:b0:3a0:bd91:3842 with SMTP id
 e9e14a558f8ab-3a3f40b1184mr132047155ab.24.1729596544335; Tue, 22 Oct 2024
 04:29:04 -0700 (PDT)
Date: Tue, 22 Oct 2024 04:29:04 -0700
In-Reply-To: <20241022104635.2252-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67178c80.050a0220.1e4b4d.0075.GAE@google.com>
Subject: Re: [syzbot] [usb?] INFO: task hung in usb_port_suspend
From: syzbot <syzbot+f342ea16c9d06d80b585@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+f342ea16c9d06d80b585@syzkaller.appspotmail.com
Tested-by: syzbot+f342ea16c9d06d80b585@syzkaller.appspotmail.com

Tested on:

commit:         8e929cb5 Linux 6.12-rc3
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git v6.12-rc3
console output: https://syzkaller.appspot.com/x/log.txt?x=11ed8a5f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9878fe11046ea2c6
dashboard link: https://syzkaller.appspot.com/bug?extid=f342ea16c9d06d80b585
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14ad0287980000

Note: testing is done by a robot and is best-effort only.


Return-Path: <linux-kernel+bounces-214016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21E7D907DEF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 23:15:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 357A51C229BF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 21:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB83A13BAE4;
	Thu, 13 Jun 2024 21:15:17 +0000 (UTC)
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA82712FB2F
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 21:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718313317; cv=none; b=ESeUh20NGzvvxKVniKN8Jsbho2oIcbyDjFcJhmot5VB4Wa4x6zgH3J6tVoouMHnBVd8lsiJeQcQPogegmL48xgDh/xF4w5pd/WNhQrEMVsQtXJ8f4IBT6HeMoKIxFGnio2l5FwMdCenCWez1hDTNY8MzKKZx+y62c9ZOIhJI6Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718313317; c=relaxed/simple;
	bh=jRCJn6pKK0raBeLscR5rO0fcRUe6TsRVT8ZrmD/VoN8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=U81xdipzelBLQq1XMFG+nr9LR3dSdgqSbx94yxN7PvOKMM4vh/z2VXkPEB6EzIrEMr/pO6T6cWXWi4EjPfi9XqJOLEV+fzci3b3NH2PFvFfdH9rCXPactk6te4dtPgt7Y4U6K0vIM+Ugm30KVTPF42qcdtJgX9iDhggkd853+qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3747f77bafcso14226225ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 14:15:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718313315; x=1718918115;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5p1KnB+2D55/YsDGcRX9ymfnMwBijEHG4ncB1kxeSsQ=;
        b=tOdBBwMcn0P/lrX2/Qov44d5ouAOzAto2mwcNqBF78hv3xMFMPEJJlZwhUo8yAy3WA
         ZJCXjWWNXhu9rg6aRdJrB2Gadx3l5cPTsBMyoyCELgI++H+lpTFC1IQJO5/1RyZq6m+U
         mlCaaMT1ilnj3XBVW+y7SKMRswoCoOnmxYWgDHgeUns+wjwaIef3jgrrIxA7sLlnCb/v
         DI5Cm3JI7IOvVes1HIXUJOu9eGhMNQa9wlXdu/vjyOl1mIr0F4VVPRGybxMamCbMp2uQ
         veYbpMxrA16m9fV8VtgBSdFhRH+FQTnpM8HiT3i2e7tVVdq9JWemeYUUHrcTtteNbULF
         E6dA==
X-Gm-Message-State: AOJu0YyTxUqdraQZaMH2ZJWadmofQdkfZaxsQWLiaNvXukxQZz15RU/6
	iaU6j4o/538gvhUZRbsZvU0wNA2Ai97hRtK3AjMh+Gxwp5ecf1inDMHSWWovJsZTSmGI+Q9Giyh
	FIO/MfQ0Hfj+4MdQv1ypBBYtAIE6DvEigUxbfgWJqOjiRLmU0hQO0wxTqyA==
X-Google-Smtp-Source: AGHT+IFV1XKEfEOUkEFRIdjPnJT+YbYnYqm2Jk6NOSjOJJGqedxB2NpO2OPz5unzFbIPGrFOdM6CdD9AhFErbnLoo05fRvoBfZWi
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:152b:b0:375:d7ba:4dd8 with SMTP id
 e9e14a558f8ab-375e10957afmr325755ab.5.1718313315156; Thu, 13 Jun 2024
 14:15:15 -0700 (PDT)
Date: Thu, 13 Jun 2024 14:15:15 -0700
In-Reply-To: <000000000000bf4687061269eb1b@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c35b60061acbfe99@google.com>
Subject: Re: [syzbot] Re: WARNING in hci_conn_del
From: syzbot <syzbot+b2545b087a01a7319474@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: WARNING in hci_conn_del
Author: paskripkin@gmail.com

> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit: 603c04e27c3e Merge tag 'parisc-for-6.8-rc6' of git://git.k..
> git tree: upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=12d065aa180000
> kernel config: https://syzkaller.appspot.com/x/.config?x=eff9f3183d0a20dd
> dashboard link: https://syzkaller.appspot.com/bug?extid=b2545b087a01a7319474
> compiler: Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro: https://syzkaller.appspot.com/x/repro.syz?x=17960122180000
> C reproducer: https://syzkaller.appspot.com/x/repro.c?x=15d70222180000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/ffe1f52b2e32/disk-603c04e2.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/76775e0b335d/vmlinux-603c04e2.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/8cd3c1c87eef/bzImage-603c04e2.xz
> 
> The issue was bisected to:
> 
> commit 181a42edddf51d5d9697ecdf365d72ebeab5afb0
> Author: Ziyang Xuan <william.x...@huawei.com>
> Date: Wed Oct 11 09:57:31 2023 +0000
> 
> Bluetooth: Make handle of hci_conn be unique
> 
> bisection log: https://syzkaller.appspot.com/x/bisect.txt?x=1357945c180000
> final oops: https://syzkaller.appspot.com/x/report.txt?x=10d7945c180000
> console output: https://syzkaller.appspot.com/x/log.txt?x=1757945c180000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+b2545b...@syzkaller.appspotmail.com
> Fixes: 181a42edddf5 ("Bluetooth: Make handle of hci_conn be unique") 

#syz test 
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master



-- 
With regards,
Pavel Skripkin


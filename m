Return-Path: <linux-kernel+bounces-412102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB9A99D03E6
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 13:53:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72A51B238FE
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 12:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBC3D1917E7;
	Sun, 17 Nov 2024 12:53:05 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20AA166F00
	for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 12:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731847985; cv=none; b=j6KnE89SCsymyYnSjZdsx5osUieYPflEgO57XI3TkEu0BP61pdAMVEjlmyM7NnRDegf/LPboQENvt1WnM44oNA216Nzdv4pfBQpJX8jUsbZayjXrEnqHVQTWnm03i+iLa3r+d9YXB282V77izi4Jiy7fQXAI2H5oPvMFD6npnyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731847985; c=relaxed/simple;
	bh=XrRdWMJXBrdN4f/8l6l7kAcSLbQ0kZAZKwgyHlkcuwI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=oEwnJrWRzBdB7E0CkfzeDrvii+Gkt0pUIw4seKZIyyq3MHxm8Y4Gbin8/MmfvWQNkzZCy69hB348JE0pJeekG1v0kun2MUDFq90lKvn/2VQeSd25mVMpzaJJ1NYyg5alBElzpXFoK2n3sBkYM+dqB8uLx7/9ioZgQvvdPZGohQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-83e5dd390bfso304241439f.1
        for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 04:53:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731847983; x=1732452783;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VQFhShpCFFfqPZwz2aZH0sjh2uJyuJz+k8kyZhQ1m2E=;
        b=sSBHED6XgoY1R7eHC10/MY4/9aQwIaDR7L7+QTc3FoT8yQWA/XGwRj839Wi7DUqlCP
         Ixax05MTUbY9yTc1+cu4bMJXoSJSkC6Qk7raifSzw57KXH32kkomnLBoPIhNQbw4wMfE
         PITDC0Vu25fEoFAPaUiWrd9D5qmAip5JkaTQ4SCKVYYbZTivoROHWlEeRy+MTwOzCmAw
         aGySDYEU4vqDZ2GaTzDU2DvAqsPq1sb9Kx682l0HHl2pZDc1K9tkNfUi7VhN4r9gnWzu
         1D6FkyNWOLAVckwa+E7jwgzYU+DnkySUVLFSxih8siWMu6P0EXukiEMLZk3OFMmretjv
         eMvg==
X-Forwarded-Encrypted: i=1; AJvYcCUm6ziXx+V057KKBzaeGwIb7cMUD97dnruLUV5miPWRdRMCVvFpRkabADClVc5yeCONGspvskSpAHO1dac=@vger.kernel.org
X-Gm-Message-State: AOJu0YybREEqwaGnXEtV68DqcukUt/55K+uG9l+rY8rhpEtFryHcTy77
	GfxSNUoJvA6aqGZ9hFmDQwJk1zjvgj+7sN9tg+70n/51MjEnhe6KCjiLmfs03Gf5O2J+m+TIaTw
	Z5Qx8Sijdy2pW3+wUp0KeEP19sxW3z1wSM8MSyjpg1E8d0gaSLZBUpYg=
X-Google-Smtp-Source: AGHT+IHH42tRIhFkR/AgZmPHwUk0sE72aX9yFGbSTU9HuCw52hfPuXvwon0zb3cTuC/NEMyQeriJMsyFdp7bupcvK2YJp/vVZLtN
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:dcc6:0:b0:3a7:47ff:546a with SMTP id
 e9e14a558f8ab-3a747ff559bmr70003765ab.0.1731847983117; Sun, 17 Nov 2024
 04:53:03 -0800 (PST)
Date: Sun, 17 Nov 2024 04:53:03 -0800
In-Reply-To: <79b938a8-ecb9-4d3a-b1a3-76f1a9c9f351@linux.alibaba.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6739e72f.050a0220.e1c64.0014.GAE@google.com>
Subject: Re: [syzbot] [iomap?] [erofs?] WARNING in iomap_iter (4)
From: syzbot <syzbot+6c0b301317aa0156f9eb@syzkaller.appspotmail.com>
To: brauner@kernel.org, chao@kernel.org, djwong@kernel.org, hch@infradead.org, 
	hsiangkao@linux.alibaba.com, linux-erofs@lists.ozlabs.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-xfs@vger.kernel.org, syzkaller-bugs@googlegroups.com, xiang@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+6c0b301317aa0156f9eb@syzkaller.appspotmail.com
Tested-by: syzbot+6c0b301317aa0156f9eb@syzkaller.appspotmail.com

Tested on:

commit:         2795294b erofs: handle NONHEAD !delta[1] lclusters gra..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev-test
console output: https://syzkaller.appspot.com/x/log.txt?x=1058db5f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=921b01cbfd887a9b
dashboard link: https://syzkaller.appspot.com/bug?extid=6c0b301317aa0156f9eb
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.


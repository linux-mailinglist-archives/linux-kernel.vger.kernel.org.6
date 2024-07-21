Return-Path: <linux-kernel+bounces-258286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 848A99385BD
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 19:53:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A59F528107D
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 17:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D67716848C;
	Sun, 21 Jul 2024 17:53:05 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72CCA4400
	for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2024 17:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721584384; cv=none; b=XeU9bxxfCZyeJ4fDTnqgpqbV3+O+rXjpVNLr4gKap/JS8smUsRINz5ciu3BRiXUn4++LGWjqYZ5PipGrgU+u7v9J2mB2X8cJQqehu1YERyC/hDOgVFoHuvPcnV+MYpux6U0UDhi90DjbMUFfUiet8b4OJmSOeNhUfZAtxsycspI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721584384; c=relaxed/simple;
	bh=g43d9J+6skYY2hr6m6ZjHgNLgMAqIPCavyEYVhlhBcg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=XywL8hohZEaDzHM/5WyP2olGnlKuQ2K/4RlAqLQMinHGRWqftfNSGy/l6yUqFk5KYspCt9j6gyUAe/MTj3LpicMnv5TPyC8KyCK4IT+HDIQfC498cNnBwJOr3xT/7trDXxxXTa+vE2VLGjUfhy+rX+lrrQCax9wXXyqHbMxtmNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7f682fb3b16so648357039f.1
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2024 10:53:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721584382; x=1722189182;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yKPRxT5u9qwVHlqNj2U0oc19ywY77eJSu6yOMLA8gLg=;
        b=M3Ay06qIW+BHrKOKyeVH/NKcXwAko7pdqa6WH6jI3woi4CmLgYTtBficHotNR7kl/p
         /I+xFnzDY7Z+arJIfsKnTVJOjlMJk/In136C+aDb0BLgznFGwBpZqkz7KwP7rOxHi/YV
         a32gs2c5jWhDjZu4P3ujxzvqBqxkfXGPZNHVl+GzYCwQgB5JNL/l5Hj4Sibkbr1K5oXL
         IGzGEBnvRX1ada0dhjaJyLgqK33vCBBiunocdCX5ViejgL4lHZ3m9OAjXBj7gFDy/hcJ
         syYRzZwXLEH25MvfyAFhad+Rja1yEv14olVkUAbLphb+1F+ZxCiMVFIGsUi3dUY27i2j
         a0ww==
X-Forwarded-Encrypted: i=1; AJvYcCXIXMQp+L8SsUth8s/BrbS/1gEkICbbPUsYsB35xcjiLZLF4nMg5XkR5n728yDQbykiee4BPtK2pDO4dZu5h35OiDau8QJwjriKTF5Z
X-Gm-Message-State: AOJu0YzIkz7xpB1l4a7qmh83tkoC8DNTBVwURdgJiKVQ+uTdexptsq6i
	t2QoP7JBiZkuqx/g0AnfDInjujooMM5cbZhgzXuGeZCUlBXTyDWyT5RbVHIprOgRGm3JocCqSgu
	lLji3etwv2lyw94Zbec76lsqBLdLXuchEmcvYNyOVUlFJStlzTsZ9Lx4=
X-Google-Smtp-Source: AGHT+IGVsPaWB+0kHXi4BpDdS2NDODKenU/6r/dNBEfI2c+1CYtyfNEetY7Zr3bEhaAxxFKGuOmNEF/TuYHTzB8c8ZPbNbmsCy1n
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:348a:b0:4c0:a8a5:81dc with SMTP id
 8926c6da1cb9f-4c23fe67e87mr369585173.6.1721584382644; Sun, 21 Jul 2024
 10:53:02 -0700 (PDT)
Date: Sun, 21 Jul 2024 10:53:02 -0700
In-Reply-To: <20240721163824.2543-1-aha310510@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000942441061dc5991a@google.com>
Subject: Re: [syzbot] [bpf?] [net?] KASAN: slab-use-after-free Read in bq_xmit_all
From: syzbot <syzbot+707d98c8649695eaf329@syzkaller.appspotmail.com>
To: aha310510@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+707d98c8649695eaf329@syzkaller.appspotmail.com
Tested-by: syzbot+707d98c8649695eaf329@syzkaller.appspotmail.com

Tested on:

commit:         a6fcd19d bpf: Defer work in bpf_timer_cancel_and_free
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=178fcfe9980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1ace69f521989b1f
dashboard link: https://syzkaller.appspot.com/bug?extid=707d98c8649695eaf329
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.


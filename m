Return-Path: <linux-kernel+bounces-529392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78485A42516
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 16:04:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8758426F1B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 14:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E879C254873;
	Mon, 24 Feb 2025 14:51:19 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D952C156F44
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 14:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740408679; cv=none; b=Zfhgw+pVKCTgAQeAGch5p4xLCgBrAzj4EEFSc3MN4j8IKCVN46mmTZC7mUYLNslU0c2ZynE/QCD62GT5aFHi+tNnTiucRx7bvyYYTdPLPzdzBPcx5PRAMqvKaRKcjRSoFpdAgScdc3o7i4U3NrsUmLG7/FZXgd4HT5Q9gfEDsWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740408679; c=relaxed/simple;
	bh=WHYbN9/AyM5Wfc5ZUi39uIR3gq4zirgVBh9ocXtA+bc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=QUQab5NY+dKlZfxD6xDFGj+pD76qSvtnP1UOH1RLFEI1uwuU9MgyQLHZKoU/0oY6LVWMamrephbC2V6MNUbrREJTGu0rcicOsj9AplKJHM3+RZom5/tK45V5l7lHE9E6J5FFN0jlqpYf/rPKLNzsrtS8uCmjA2Q3VTkje0TMBC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3d18a1a0f0eso90900485ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 06:51:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740408677; x=1741013477;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WHYbN9/AyM5Wfc5ZUi39uIR3gq4zirgVBh9ocXtA+bc=;
        b=Cs44Dc4Btgpj6TcVg7mPboaF97/LJN8F8rzL2uUw1tC76N4Se5zFbMALG67AQ0Fgzy
         E9vWUjliAcDSHbGKwn0kzD1nzvzWDa8DMNyguHxmrcxCP0fLLx2gtiOMDmrUcmeRRpU2
         epVM7YadChDea57oxen4PZtxIZoC21/7qaY32xOhx8EUeggPWvYGcJB8PHMaejeQuNSZ
         qhT4PBa0jAcADPojAT4khoxSAcxuSYcR+ZQ7pUMMQAHNIP9KLEz19wQRQ6zyrv/NETTs
         Q0+Q3vjecCAeH/1nOVmCd1YMU2sMEXkMrKcmBSN04vMski4aEWjA9DBaVi1JrO0jTQSm
         9lBg==
X-Forwarded-Encrypted: i=1; AJvYcCXdfgTqrMW/+jH7/jwddF6RLsx+YCbYEqoGwDK28TsudLh532L3fJHQwQGtA1Nw7LYeTyVVbkm4yk4PMXg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr8E3WNfQvtOWsNbTVnxuOw7qIs+rK/oFyqKU4VxzrO6IpJwyx
	eKoVjNFi04qnII0pepoKnoBzT5RC53x2DhluXiB0fmxyup6LDbbnVknrtVzDkAEY5ye++GcArVd
	ugINhYg2qYtAsvxNvz0xzfCIEMx90HnLBaSxp3hnco2YWMheh3MwCqvg=
X-Google-Smtp-Source: AGHT+IFBU7widGjmEz7cZDPNrguQdpGyuQ1TAilarnJLLrcoBg3mSrgkS4WA2yqbXF13p8Egh8LPbbVkhJYHrJnJ4qNz6GsVHQ6I
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:248b:b0:3d0:e6c:e9c5 with SMTP id
 e9e14a558f8ab-3d2caf099fcmr159588545ab.21.1740408676909; Mon, 24 Feb 2025
 06:51:16 -0800 (PST)
Date: Mon, 24 Feb 2025 06:51:16 -0800
In-Reply-To: <6738c3ba.050a0220.bb738.000d.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67bc8764.050a0220.bbfd1.0088.GAE@google.com>
Subject: Re: [syzbot] WARNING: locking bug in get_random_u8
From: syzbot <syzbot+7f4f9a43a9c78eaee04f@syzkaller.appspotmail.com>
To: Jason@zx2c4.com, bigeasy@linutronix.de, boqun.feng@gmail.com, 
	hdanton@sina.com, jason@zx2c4.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

This bug is marked as fixed by commit:
kasan: Make kasan_record_aux_stack_noalloc() the default behaviour

But I can't find it in the tested trees[1] for more than 90 days.
Is it a correct commit? Please update it by replying:

#syz fix: exact-commit-title

Until then the bug is still considered open and new crashes with
the same signature are ignored.

Kernel: Linux
Dashboard link: https://syzkaller.appspot.com/bug?extid=7f4f9a43a9c78eaee04f

---
[1] I expect the commit to be present in:

1. for-kernelci branch of
git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git

2. master branch of
git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git

3. master branch of
git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git

4. main branch of
git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git

The full list of 10 trees can be found at
https://syzkaller.appspot.com/upstream/repos


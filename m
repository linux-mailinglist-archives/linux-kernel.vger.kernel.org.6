Return-Path: <linux-kernel+bounces-337299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89EAC984858
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 17:15:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E4DC1F238BB
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 15:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C66951AB6ED;
	Tue, 24 Sep 2024 15:15:05 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A6C1AB6CA
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 15:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727190905; cv=none; b=pF98FvqD5ZA3KXI+6lljoKS2zZDvtxtd38gLfH3ya4wadWWFqUETyjFH1HgkJGwQ2mKYnVbBx9x7zvRsk60y0G6xmcGJh1MJVbWUjNj/cngJN7HpOi7VZ7VFeaD3kel14JAtpaJqqM5KjSruSdMvU1hvvZKYgyjBLQ4r7CNkAts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727190905; c=relaxed/simple;
	bh=2MyoKhrkPcuva4ba5f0pNhymM1FegZiXk3USoBTyG6k=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=EurCcdaAAflqBC5FCMsoOur2pG3yaNqVPmWKobN8NXOYg2zfxvyIkFkI3CSnKpsW0NyrPCyqlDSMjr2pL+ubHZ84SSuEzSGWwR9eeBuFyCVCQrFgIR008GExY9VskcQwksrl6yOVfRf+NWnpFklurTSp8icOworXqImZW1h1xNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a04c2472f6so56689335ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 08:15:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727190903; x=1727795703;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4LlIzufvKPHPSgV5C98D0GTUbqfGIrXyf5bxR2siUzk=;
        b=wGCFU/XNQSde9oUgIJbZhF99j4N+Z+R+d/Qgc83efduup7M4puBGZ2iZtcl3PpK90T
         9l+cIdUy8e1daODmHDSo8RW/3W5MZIQZox4H6vWqyv6/gEQHFfVGxg1Eg1EpJdlgO2ag
         6BWy1ECGLzJJ0gW+XKxKHgcnIhkMpn129IqDTZ+4rfn8nwXvxh2q01xUlA0leNc2c0ur
         Or41EKc0X0ZJVrHYpxIxebp60IPi5CwfWVgOnZP/LO+WtPIR5lmezBB44pyn4R/DnmGP
         DgaieuUPjF/huQS+13/0S+Na0kQbz/xN1l/KN828QUrLVkNnj5HgFX16MiqsUTpxGp1g
         UbOw==
X-Gm-Message-State: AOJu0Yzy/iIb0bctOM2uKfa1EGKAYljjXmMtofED7neeqQA+5iTbC09k
	x5Hzd9e/3Xw6vMkIceJOx9XVQBxQ3KDLt3LQA2SzmT0O6PNjuWQIB0YM1/+px7/SIf59IvlHPMr
	6KCNDmLLKhsIPCTHK7L93xth8gDjtKIKfMk7GSIdKcybqhF3I+9x5V5c=
X-Google-Smtp-Source: AGHT+IFW3p29ZvER/qFh7qaqiw88tHzkMTNLVN/JDcWNJjl1DzsQW8T7zm40HXVUtfVq/mSH8IBxlgJ9gQGlc21RYBSb8exf+aYb
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:19cb:b0:3a0:97df:997e with SMTP id
 e9e14a558f8ab-3a0c8cbb7fdmr149674545ab.14.1727190903139; Tue, 24 Sep 2024
 08:15:03 -0700 (PDT)
Date: Tue, 24 Sep 2024 08:15:03 -0700
In-Reply-To: <ZvLSQLuLLGIkDthp@thinkpad>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f2d777.050a0220.c23dd.002b.GAE@google.com>
Subject: Re: [syzbot] [btrfs?] [fbdev?] BUG: unable to handle kernel NULL
 pointer dereference in fbcon_putcs (3)
From: syzbot <syzbot+3d613ae53c031502687a@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, qianqiang.liu@163.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+3d613ae53c031502687a@syzkaller.appspotmail.com
Tested-by: syzbot+3d613ae53c031502687a@syzkaller.appspotmail.com

Tested on:

commit:         abf2050f Merge tag 'media/v6.12-1' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=150552a9980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=173d4d4bbf993577
dashboard link: https://syzkaller.appspot.com/bug?extid=3d613ae53c031502687a
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=106952a9980000

Note: testing is done by a robot and is best-effort only.


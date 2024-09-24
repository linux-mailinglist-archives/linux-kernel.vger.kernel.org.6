Return-Path: <linux-kernel+bounces-336876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DEB7A9841FC
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 11:25:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8845A1F21B07
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 09:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB8B115688C;
	Tue, 24 Sep 2024 09:25:06 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C8515624C
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 09:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727169906; cv=none; b=NKLYZ5nhAMxi+cKjXcJijrB7gHbqhqAtVqvaiCRvjRtzWoHiwoOD8sEQKQFINRr/pd7rYjYQ1pWvHJt1vK/b/KThhFy+9up4L1rXa4DE3915JaCJmMb7qYKC866Tms426xA5R7zY9k2HK6Xw1GoTrG411NGKmmIEgrzoyj/+36o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727169906; c=relaxed/simple;
	bh=YRt9zKr0u4xoS1HCh0RWXcUXXdLEqalxatp12QLZ9K4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=MS5nRH4IUQ7MDDc5IjPZCmjdFQ0S2MYf2WxD/Shzsex/TLph5efkerRj8MN6SiNGkKtnT4Pr1P7E5kKFCahPn0WJ4Wq97WhasXqp3Ljl9+g2g7sHlHFtCkbm4JFGhLe/6YAZGG1bRNHMJsaULGjen6OvGgeShG5ULFfWB8folHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a1a6d8bb03so5592695ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 02:25:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727169903; x=1727774703;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pO1EbOowlqgJwq+AScYLtThcTl1AOtxAHLI4szKkApk=;
        b=kMuQaxj2leqQZuWJFuc+7V9RXeJz3LaJ278WckE65Dg1a7HBaUUU4HHp5arwoKi2T1
         1M0aGXZmGXH+OiwwUgbJQgjf6GR4Dy/IACLrUWDUG2bs7g7W6kSOVypG1B2JpnSJmeAD
         ACYC6JDwiJXLWdjwjMISC/kV6DzfsRsj26akZ1bUvyu02QYyimWZkRoqbbIl9cw8A7sN
         vSwdfboqbi7N2bo8MOMpHGfma0rdcNEcXaZPL/KukiMuxJgmrWaYW3QxIzHnHkTJF+GF
         Kk6b8P7o0ji0VkfOdRxxmzyvwAbmqcJWJAjb1d2F8pLQH3C4qVsdeAa1zxMoaRuQKY6x
         KaqQ==
X-Gm-Message-State: AOJu0YyXbAPj2tyEQ6wnu6nfp4BYjN5X6rEez6txrmgpgpEtaRj1KmQS
	RNdDCzpcqDlaiuz5McXAPgRwdERMVhXmMtQjwKoOaTrvK3zyQBeDcSan4/4ScttEfGYfJDdFSnt
	WkpLAxndyOKUEWOtZmjBti+stWkadgAOn89UzCN7UbgU5hu0vOZoWMOQ=
X-Google-Smtp-Source: AGHT+IHiHBLoL/596X1mSqyRTSSyBfX/LKQs3e2qM1jWQNjoTY2DPNQHd8ha1vSsBxHkmU2QDx9M1Z+8HX/bhgr0k0E3tnMZgy+Y
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:214f:b0:3a0:8edc:d133 with SMTP id
 e9e14a558f8ab-3a0c8c9afcfmr124214255ab.9.1727169903401; Tue, 24 Sep 2024
 02:25:03 -0700 (PDT)
Date: Tue, 24 Sep 2024 02:25:03 -0700
In-Reply-To: <CAABpPxTRUTjc_S-i_Z+o9fDzi4JtGiKN2VeaXQngeioqh3d+zA@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f2856f.050a0220.c23dd.0026.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] possible deadlock in ocfs2_get_system_file_inode
From: syzbot <syzbot+e0055ea09f1f5e6fabdd@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, pvmohammedanees2003@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+e0055ea09f1f5e6fabdd@syzkaller.appspotmail.com
Tested-by: syzbot+e0055ea09f1f5e6fabdd@syzkaller.appspotmail.com

Tested on:

commit:         abf2050f Merge tag 'media/v6.12-1' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1622119f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2a8c36c5e2b56016
dashboard link: https://syzkaller.appspot.com/bug?extid=e0055ea09f1f5e6fabdd
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14192a27980000

Note: testing is done by a robot and is best-effort only.


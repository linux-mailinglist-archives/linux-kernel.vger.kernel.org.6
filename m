Return-Path: <linux-kernel+bounces-383543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D81ED9B1D0D
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 11:02:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 478D3B210B8
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 10:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 663AC4CB36;
	Sun, 27 Oct 2024 10:02:08 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2333578C9D
	for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 10:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730023328; cv=none; b=ro7BK1nFsqcxAlq+OUj1/UTtBCdo1HzeHP5b/5hfshvN7AWIu6VezFKnYu5JPxZJlXbhcburzSfehBfx7uRVScTDrH7fBNwZajIDH6a8owsa+180My+lKZ32xl69wXKWqUlD8CKg9pFaRR4L+Vig7V8nzt7hYBDHOvcvxSz73m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730023328; c=relaxed/simple;
	bh=0OpUnzKZRZobOtMrjLxgnYSB4ThIvYdxgODUjs4m/l8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ZhP6zs/mT3mW3QQqKldxc2K3hlE+ZLD+7U0dIaXrydz9i07SgW2fMj7B53cWZsQCgybxQaiZ9k5oRwvKRhqv6urzzxzcgpaetpXJVksGUuOwwNNPyPlbt1gOMj6KBjVoVGvWnQbEKZHQ+f/AMNVPUwZ4untbbeFf8QD8aZKyRGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a4eb49864dso14938805ab.3
        for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 03:02:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730023325; x=1730628125;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YoARu2CBO+0MqUaLvRk4fAdTO79s9BPMC/TOwXf6Qko=;
        b=PwNhZ7oYUs80T1PHg7XJLIR+CQtpo089GNqLH+BR+E+FOkBjaavvDJhR8wGN6fBbGw
         gfe+xlJ7pSobbGyI69J0PosUEVwxMRgWBoQStSBoiwVS81PkHVgCx1RFRbomshB1RwYQ
         uHBQVnW31ms9rGjYcaTr/dgEyiqVQLJ+Y/Pu3lPS5nlWi8uIpL3jLv2S9Aa+W+BDXCmy
         TlgENhYCziywzcVd9CPUJEntxrtaMOwX1Bqmy9UXzC6kU/bPIGu04JOY9uS/Rx9zrjRw
         GT6XcAWav/16MaQ5ibBQix0knBwyGYK7JIuybaVIvn/yGOtC6vqQXFhD+q98TjyzBmHm
         XpMg==
X-Forwarded-Encrypted: i=1; AJvYcCVpK5HrldhgxOAWxZLO9GQr8XTuCv3I8qGOy6tnP1SXuzTVZKpQgrIKemyOwLZVVHC+CXfKiQhrCJjq5Qc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0ii/M0UipVgljoQH9n2S2rZsP4jLqth9NDAwcBbRp64beq46z
	waJK9bBBcH8BQtaUyae3Eo+i14qge+MOyM7Vb3uBF8ebNT2+e5riwX4ATL7aCKEHgdyJDf2XB29
	uZ5Vn+zxkBRaWnefqH5vOAyknnubgNzeGuWgM8Ns4igzeRDRyp/gXzHk=
X-Google-Smtp-Source: AGHT+IFYoA9kWVCxMPGJha0Clvw9ynpnK48ljvQTgmAsZmE3BctYhDC58wLmPPkxWR8QTELxXM/yinmOM3FIjK47Y2xzvPGuuHfI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20c5:b0:3a4:e99a:bd41 with SMTP id
 e9e14a558f8ab-3a4ed2f3861mr39888345ab.12.1730023325277; Sun, 27 Oct 2024
 03:02:05 -0700 (PDT)
Date: Sun, 27 Oct 2024 03:02:05 -0700
In-Reply-To: <tencent_A56F5096F0E83AEC6ACE9478866F602D150A@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <671e0f9d.050a0220.2b8c0f.01ce.GAE@google.com>
Subject: Re: [syzbot] [ext4?] KASAN: use-after-free Write in ext4_insert_dentry
From: syzbot <syzbot+0c99c3f90699936c1e77@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

fs/ext4/inline.c:1025: undefined reference to `ext4_insert_dentry'


Tested on:

commit:         850925a8 Merge tag '9p-for-6.12-rc5' of https://github..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=fc6f8ce8c5369043
dashboard link: https://syzkaller.appspot.com/bug?extid=0c99c3f90699936c1e77
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=106a24a7980000



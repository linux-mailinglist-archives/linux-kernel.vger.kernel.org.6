Return-Path: <linux-kernel+bounces-518455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 493AEA38F54
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 23:56:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E601172A01
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 22:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FB071A9B3B;
	Mon, 17 Feb 2025 22:56:04 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A7A1A5B9D
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 22:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739832963; cv=none; b=e72dNIZt4e7mrgL8JXNIQWjSFTDlP/pHFNEOK1yYxoPcUpqFDIm0NbIo+hfr80nbMmwIKOWnQeG9hJ7u0O0kXvzRMlluxbxNic1Ie+S63RjJ+JrRkqzFqcfs8o7lJC674h6Sdqr2IJ1bPuFMvim50BjDckvYxGXXQrrP3nPpU9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739832963; c=relaxed/simple;
	bh=/aMUd1gxNEo3Wqe/4MyrFf5qU+vJp7haVhL7aMdC9fQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=NN4yOJmfvajsQ7TQ2LLbmhquMWKNAkORb3bIGkR/5eVUKtMRl3Pdw/7iD226iGrVq3lsFxzvBBFXDJpEm2ls2bmvAjud4mfC/YiMb+AlHXwcTMsiQ+9IJX97TQW1S6SbLsC0kW8NQiderC9/GgAx/ZfnW/Whpz40pdw/fEbyzyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-855959aa39dso223148639f.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 14:56:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739832961; x=1740437761;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2E+nd1u3GnCf4izEN55aQo4ClUIKm+f2lxPmjHl0omU=;
        b=RZ6zQhbie+NYtYcWCkYHR4pVhy8KTDqPE+LeQU8fSOP+HskAi9zThw/WQAmF7m7o4y
         PULitl/syRyTtTd5BD2krI+0fw5H6eQeFRmJzfFllWbJYhEP3BtqC6xXwDlep9ee4OOM
         ZwZD0ihGOqhDwVlN65+qbv6n0X5eX6QmJs2MAWGtEbHq3nq7hsybJEFd/seJZ1F/XJZS
         ZysqYsga96Ukx6WzJhIebKvjUBBctQ0MalLxdrsmSVkru3R/iw1uvdI86lNhHYqJHJVW
         zZ/8F7KTTuYaujF5R+gRlG2IhVkPA4oLPP/gsezIQTXdhxdo7SwIpKz7FrM90unYL2w7
         UpsA==
X-Gm-Message-State: AOJu0YziwsKCA77Rl7QwWYzbApMOkZgiJsyEydtiLRYv90gdzmouPVlj
	S+I4zZjLRQwMVMtGOzGfzk/8b5pDEHsoOTwI6U+XCtniq20QSf3QqNyR8kKUZgOBQF/sOxb0WHY
	lWnyc7BIvnUV2879+tkn8yy3KG3Wcc7vPx3Wdzy5VEF2bWnj0Xauq7e8=
X-Google-Smtp-Source: AGHT+IHX5iTrO0StciSpi4yTWcTi4JRgEVxaj6Zpy0yBPzxpTDMfDHOc622UqowoRSa3Gugklq2gGcU/NVTAHmNbXyPDQ48s6K2e
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2181:b0:3d0:3851:c3cc with SMTP id
 e9e14a558f8ab-3d2808f4b81mr78700005ab.16.1739832961486; Mon, 17 Feb 2025
 14:56:01 -0800 (PST)
Date: Mon, 17 Feb 2025 14:56:01 -0800
In-Reply-To: <Z7OjKrXLhbLzeifj@qasdev.system>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67b3be81.050a0220.173698.0040.GAE@google.com>
Subject: Re: [syzbot] [usb?] KMSAN: uninit-value in mii_nway_restart (2)
From: syzbot <syzbot+3361c2d6f78a3e0892f9@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, qasdev00@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+3361c2d6f78a3e0892f9@syzkaller.appspotmail.com
Tested-by: syzbot+3361c2d6f78a3e0892f9@syzkaller.appspotmail.com

Tested on:

commit:         2408a807 Merge tag 'vfs-6.14-rc4.fixes' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=120c1898580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8cf1217edc1cc7da
dashboard link: https://syzkaller.appspot.com/bug?extid=3361c2d6f78a3e0892f9
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11a0a5b0580000

Note: testing is done by a robot and is best-effort only.


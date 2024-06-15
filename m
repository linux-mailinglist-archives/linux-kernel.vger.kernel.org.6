Return-Path: <linux-kernel+bounces-215852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4EC9097E4
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 13:12:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B27FAB2145A
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 11:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA02B3A8CB;
	Sat, 15 Jun 2024 11:12:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD3E2E646
	for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 11:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718449925; cv=none; b=eQLTQRfmjzAvoMAVEwqC4zlJb6UEZkMUDhD0NrgKfwNebNR25Mpz45VDkL/IyxTVKcBKnQa5R08yOJu8wx8o9mweTDJo+3xql5AT+ZJjpmYAwvmewpyN9RV5t7v3cicQQpftro6EAR9TLIHIxy7KnmaBZszbkWZGt/041Q7EFvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718449925; c=relaxed/simple;
	bh=/FHU9VaJW8Mq9lL1KME4g/1hxZzGRw9eiDnBzsuIuc4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=TgDsPdyDn89SBHIjiB2A2C5U5q6yfECVH4Q3UM9gfjET9kF1nW/3SL9LuoSuzd4BglBYHw4nVPa5w2d56y807KfVKEmaJBoESeOeSC4fD0SIkcigcRysMwFDPEpCd25TW2fIpd4FaKN9/wq8CWRhmhn8WcqxwdYEgv6SAAiDoyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3738732f988so27606625ab.0
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 04:12:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718449923; x=1719054723;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iMWClww+BAjsQYuQYuJp5BnnMkcUu67xhLFJbtwJkSA=;
        b=kCQexeKI/mkQVtR7dH5JPl+PdEc1cjgrNpzwn2Y+7DQLN4hqqIb1NxW7gl5MNTgDUg
         VbGVeJQN18JCjSGAK7yZKlxx53A5RvUOANbKk23SlibYK+ZeZqTowXOr7T4gDBnF8qTI
         oeC5XWIQhEc9ylWza9NmeWDMEjfsf6rElFQR91vTdLrE70PkdPj5tzkEKboh5uwISvBj
         yNFbhDW2aIWhyMgkAvP2DzBo9EO1HeGLoU0oVa00/f3a7aqIbyp+xVW7rseMAwhyZDHo
         +im5CXyDy4uV7mBgFFAiHUSgpCcgYZVT6hanmaFOYffMYi51ZiKcPKY6Gz29Nueo+MBS
         4mLw==
X-Forwarded-Encrypted: i=1; AJvYcCXSVvaGKbQPkp9rithocfLrQNjAiYjI4VOfSr4t2J1p3UUR2mb37R+SLun/SVen5rFuvNfqOTQwXNQPCNzpoHYglDiryG3N+HyoEkDa
X-Gm-Message-State: AOJu0YydYgx8bEYgpCk39QomIfWYbjj1JslDpA3P5uVd9AKbmZfGGVRh
	s4wYeh9v0CzPreHh908jCtu/iuj8HoelEC7qcjpTI0f84uh0IGSVlJECpwAAbP7fyChs5T3qfE2
	kjHlmm0ur7V32F86h2aBSKEPepKVlb+zLsYByIZPXI4f814KBh+NZAkA=
X-Google-Smtp-Source: AGHT+IFdu7/1McCy0tNaopU14SBdd21+4YZvslGXmsYtxyaZ7Tk0cgTuuz5qHlFTiDU4efJwpzbe/psnGeGyru+XCiStxfq+l2wI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a6c:b0:374:a2db:d6b0 with SMTP id
 e9e14a558f8ab-375e0e18067mr3318365ab.2.1718449923235; Sat, 15 Jun 2024
 04:12:03 -0700 (PDT)
Date: Sat, 15 Jun 2024 04:12:03 -0700
In-Reply-To: <tencent_A2AE25998DF812235DBE5DFD99584FD18D07@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003d32d7061aebcd09@google.com>
Subject: Re: [syzbot] [bcachefs?] WARNING in bch2_fs_read_write_early
From: syzbot <syzbot+4366624c0b5aac4906cf@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+4366624c0b5aac4906cf@syzkaller.appspotmail.com

Tested on:

commit:         2ccbdf43 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=10f1ceda980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b8786f381e62940f
dashboard link: https://syzkaller.appspot.com/bug?extid=4366624c0b5aac4906cf
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16c8cbfe980000

Note: testing is done by a robot and is best-effort only.


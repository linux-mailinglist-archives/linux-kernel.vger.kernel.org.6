Return-Path: <linux-kernel+bounces-335973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 327DD97ED5E
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 16:51:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63B9A1C211F9
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 14:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A61C0155735;
	Mon, 23 Sep 2024 14:51:05 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89AE78C89
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 14:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727103065; cv=none; b=VSUW0dUW6zwN6yzXRufR39ZuSDajxPxADitfsB2A3fuWqssgOlTLtV4TG9YAkyRAxmmEZSCmP2sOCTvYHOdBK/YfdLKj9i4l9tPJa87JP8srJWlcsJ5K5qYEoW/n/jkWFNI8oQzRhEo1Rr58jZNY/tXV/rdO2Ce1W9t+Apy9SF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727103065; c=relaxed/simple;
	bh=YsLNiuzmi1wrmAuatVC6xslA+iYn5hgaujYclaNzQNk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=MsvAacfTwzDCiDXRr1elKTRdHojy4C48MfWQj2gFcE4vcBDJRgtnVvra4J3pUKNB6P3p8Dc0cqUd5aZ9MPJxGj1M7nrfqF3BN3Gkz1FytCc/hdMTPymdhb3JGDd9cOaE6FNSxyIJalXifoPie4AbiTlosZ7ShZJYurx19p6GFtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a04bf03b1aso53321295ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 07:51:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727103062; x=1727707862;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7AeTkDfohCw/ioRoFoMZY7YtsBLLJmfv+55fxk/LPGI=;
        b=dfwIPvqa1GBiQdKv6pP1FtAqL5l7XaQrZ0LBbXfbaQZ2JF9yv9U71MN/1SqrOUcG/4
         UlvyvjoyYxPK7j/eqy07ci8E9N7iNcicuvSnogUiqbT6dxIf7ZtUJGAEeQCUR18OZ0Oz
         sPUskPZs/NImTlw3YZ45TiEIgWHXLuuDG6DpCLu5sha/HIOzg/bEd96E6wtba3SInB6u
         7aFuZaW01yeoZNgYVbrFdJVAFCaaHATdTn9h4ZwsQSEoGLdTnZOxifpCeAk8mj+aGiCz
         /m0xg8235PoXJDFnUnE2u00shwjv5y2nk0HNGJSwX01pROERxPKlOybNNrKjak/FLKJO
         WDjg==
X-Forwarded-Encrypted: i=1; AJvYcCUXYE+mWf9l1R14X/GhCOcrB/K+9hAqo1fCbWDrWO9GdqaUAY5s+3rptYQtMxd7kp22x5evHCMA/2RHJtI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/l5U3HJXNRZ4SJASwTMx26U08FURNvM/H2Ztash10g90j1Aub
	mLd9XrmhpzY1pUTwIglKPVe1z/v7Ay3dRJG1fdSZPRJRlWt8sFboofteppXCfxdJ/C4TxLoHHAD
	9tPiGcUBp83h9fuWiuX8qBbmdHb1ajRUlkiW4K7HwcxETKkTm7VC6ybM=
X-Google-Smtp-Source: AGHT+IH9lk9hJ5CpOJ1knBbw04q5l9TGSb5ILPuW81vINoazoI9gxgu4rXH3nmHuWg+KiTAzWocxiuPWM9jrIO2nGvOao3NIMESk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1b0d:b0:3a0:9043:59ac with SMTP id
 e9e14a558f8ab-3a0c8d387bamr103314065ab.25.1727103062089; Mon, 23 Sep 2024
 07:51:02 -0700 (PDT)
Date: Mon, 23 Sep 2024 07:51:02 -0700
In-Reply-To: <tencent_E58DB7922A5DF0DDAB19394FA78D84A5FC07@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f18056.050a0220.c23dd.0010.GAE@google.com>
Subject: Re: [syzbot] [hfs?] KMSAN: uninit-value in hfs_iget
From: syzbot <syzbot+18dd03a3fcf0ffe27da0@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+18dd03a3fcf0ffe27da0@syzkaller.appspotmail.com
Tested-by: syzbot+18dd03a3fcf0ffe27da0@syzkaller.appspotmail.com

Tested on:

commit:         de5cb0dc Merge branch 'address-masking'
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1374619f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=547de13ee0a4d284
dashboard link: https://syzkaller.appspot.com/bug?extid=18dd03a3fcf0ffe27da0
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=178e858b980000

Note: testing is done by a robot and is best-effort only.


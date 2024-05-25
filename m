Return-Path: <linux-kernel+bounces-189285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22D368CEDF2
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 07:11:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 461201C20A84
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 05:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8018DBE4B;
	Sat, 25 May 2024 05:11:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B037A63BF
	for <linux-kernel@vger.kernel.org>; Sat, 25 May 2024 05:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716613865; cv=none; b=rrV4dqCkCrHsMXJx9fppZzaSV0OpjBjoCiVm8NyBGgAiyhaRyn8bC0Ue4CafllcltPEWgEjdQXeaC061ullcG0j/YTuknsjsmyIMqVvRrexoM9ytp7QxrGTzaIvRkroU42QTZiWiULoNTh2m4MOgtFNM3Iq10C/18QXbXL33ilo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716613865; c=relaxed/simple;
	bh=ChEzdL3+2gOHaf5Aw/yfnfdaUguDfZndQdJ72R/j/mQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=uiJZ+lP5x5dvT2j8CXrPxVsjT6R8QBuIIAxQIzlAyfKjqT6HQuZzQcRUKfEGhmYBMwtYs14sx4hysRZrxPIoTD02X3yZ2eLdlS7HpXV6jxdJ91kKuwTjThjZhcdR/WwO+qSJp0w62mjo4TrvCEztwRPx/xUUbUx8RMFtCEnmFRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3737b3276a0so17397935ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 22:11:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716613863; x=1717218663;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I8IyrQNJ0zAFLZsLTn91HX7IoDexMyQtJMtnbbiIgt0=;
        b=kywkOg79AhxtmFaP106hQYPyUjGElWSCB/hYfHWKZgWgcVnTaqq0iLmjV26gPAA4fV
         ItoZJwoNIVofz/yhdL9QXAZerkwtNYzT61364degwR3RpNCtW65/tndKfDmrxLgHQK8d
         amnDrDW2g7kV05WnKtveW59yqxL1iMyTrbKQMTdrUiklgk1YDpUmbnMoEKLynPY1u81Q
         Qb5fQURYo0C42eTz797rSxzX8SUVwZIlFAEq8TQCivblbuDvIG6zd0sH8WApgDR7vXuO
         d2f6Lue0GRIs4h6/zZ3L/vIcrAWCrjokyQa5+4z/pfbD6APf/mLrTWM8MZT6jRHKIZHO
         h+bA==
X-Forwarded-Encrypted: i=1; AJvYcCXN+MkqP5AaxOszOePCobVLdRp9mgkyrgwnfxnKm1NsrOgIa+jE0YBCUSHPHjiCpUg8lBA8QOgm4NCIkNJYBSIlEr7ammzQnkWFUbQ+
X-Gm-Message-State: AOJu0YzJgpw06TqnugoF9IfqpRH5jMMieYwfU2j27LrIOCEINRkxB/KN
	CA9yMQ439vNZXupp85IUKfw5ZGJ4lEhL5BgXBKFUp1dgW/OV3esWZntAqeT1ziQngybmk5uWOpB
	INAmRPz8vq2BsahaMocxawvD2Hlpj5X8FBwh8kogWw3+iSx+8H9xiaYE=
X-Google-Smtp-Source: AGHT+IEwpd5Ene7lFVYgVE0epmFBsfn5s2UO1jINS7zpgHxZEKqzT9qhLjfX+igNk2YQjqbsnny9VTdFYS/nCzzlC7H/KSJs3Gmi
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a4e:b0:373:8c59:d31b with SMTP id
 e9e14a558f8ab-3738c59d5c8mr455755ab.2.1716613863064; Fri, 24 May 2024
 22:11:03 -0700 (PDT)
Date: Fri, 24 May 2024 22:11:03 -0700
In-Reply-To: <20240524201212.mjMDljAc@linutronix.de>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000865ac60619404fa2@google.com>
Subject: Re: [syzbot] [staging?] [usb?] memory leak in _r8712_init_xmit_priv (2)
From: syzbot <syzbot+83763e624cfec6b462cb@syzkaller.appspotmail.com>
To: florian.c.schilhabel@googlemail.com, gregkh@linuxfoundation.org, 
	larry.finger@lwfinger.net, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-staging@lists.linux.dev, 
	linux-usb@vger.kernel.org, n.zhandarovich@fintech.ru, namcao@linutronix.de, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+83763e624cfec6b462cb@syzkaller.appspotmail.com

Tested on:

commit:         56fb6f92 Merge tag 'drm-next-2024-05-25' of https://gi..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=12817cb2980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b43fd1b132bcf5ba
dashboard link: https://syzkaller.appspot.com/bug?extid=83763e624cfec6b462cb
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=117c460c980000

Note: testing is done by a robot and is best-effort only.


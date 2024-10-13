Return-Path: <linux-kernel+bounces-362896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F73699BADB
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 20:38:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 338261C20B35
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 18:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C142E14900B;
	Sun, 13 Oct 2024 18:38:05 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0336C811E2
	for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2024 18:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728844685; cv=none; b=V5OF6V1Kk/UasHnQ89VNdJRsrra07NcFkqBE6ugJVut7Bv9L+KsOLrlyDUVBZnftMxxMPIf3JKy45QkmxJf4DMtSucRi8w0013OAZRUnDpZQ5J6L8zBwar4lhn76+qB+oER1HrR68HeoFTckiG57ccFSmrPB0YcliOZZGzQJrIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728844685; c=relaxed/simple;
	bh=T8Bs+Bag2nEMUGUiVHg5Gm9qqfkwmSc1T7fZDcTY5b8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=sBduS6QItbGkWsEHk+/l9dQULXxFh/0b2lgbN/dzGcJPxgFQ1OvTVwZQJFec0ahIDcz+i0ZiA2rnQ/hKUtzd+fZ29ijDj3Ogm00r04Wkvj5vM5BPrdd7iflSGZI3vcldEvWIVXUqomdTLKohmyt05I6rKsujD6JbwSiO71DAa9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a3b7129255so37507645ab.2
        for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2024 11:38:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728844683; x=1729449483;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VrbusO5Daiqr1INnkr6Gs/RfMr+LxK+TDXJ/iIrimnU=;
        b=C/aXtjVYsqBd13YRnuujuZiQSIz5l/Ak5sNz/c6sMWUFGEPdzBrr+WO3zPoTu+gupd
         dw8JKWe1SaxZCqnV6ARe+if/MgL0ZJOdYCLK62zuqayDbwMnRD25cdOiCLMOlhGrJXpc
         ZKqBi2B099ihw9s/afBPUiPzfzY4MLjBOpr3uzsyiLShUnh6Yz49VKpty8egqvsHFlmN
         2NtZkfTNQD/x6iI5dGMlrYtdzgpYGytIE9nMaT0/Wx8yw0D5zMpZAWaykFlwTprR4mKu
         Mk4ZLIOW1fdUickxo60DjAYqLoMx70Do05/HrIu5pBS8rOYLb7qF+4vKPx7ENh9t8ouJ
         bphQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXjqOy6QSg8CvXYmHIuhj3XSG+6iyy/MBbN2XdIC65cFjgNwhXcOk1hVpLX5qUzZ5AIXw/xoHP+S2pEZc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTbCo7pkYIUavitlmOKmJcS64n2b8yl+oxZqYSpsJovYm1YMSr
	gDxbQOzisdK8uRpSajpIiAD6bX0gIF2kh1vzpk7ponxBqwD2TD2GU3R0ivrYl/8EerUtVjaTNg8
	D2kzlq36SinOJIbu2dzN6mldsevoSpX6dUv4RkU7aaYR3+c0s4fWxmzo=
X-Google-Smtp-Source: AGHT+IGuv5ERMM9UiN2NSUstxnHlUzZClLL7/j5ZVwNyFsuZVuwRaviZFlWLE8PBc31MAH5Vnt657grivTmuZhWLettXC28tHpcF
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:138d:b0:39b:3894:9298 with SMTP id
 e9e14a558f8ab-3a3b5c73f8bmr66589675ab.0.1728844683220; Sun, 13 Oct 2024
 11:38:03 -0700 (PDT)
Date: Sun, 13 Oct 2024 11:38:03 -0700
In-Reply-To: <2329dfa9-ef76-491a-a4aa-277230a0a96a@rowland.harvard.edu>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <670c138b.050a0220.4cbc0.0038.GAE@google.com>
Subject: Re: [syzbot] [usb?] INFO: task hung in usb_port_suspend
From: syzbot <syzbot+f342ea16c9d06d80b585@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, stern@rowland.harvard.edu, sylv@sylv.io, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+f342ea16c9d06d80b585@syzkaller.appspotmail.com
Tested-by: syzbot+f342ea16c9d06d80b585@syzkaller.appspotmail.com

Tested on:

commit:         d73dc7b1 USB: chaoskey: Fix possible deadlock chaoskey..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=1150ffd0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4510af5d637450fb
dashboard link: https://syzkaller.appspot.com/bug?extid=f342ea16c9d06d80b585
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15df7fd0580000

Note: testing is done by a robot and is best-effort only.


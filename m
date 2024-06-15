Return-Path: <linux-kernel+bounces-215682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15AF39095CF
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 05:09:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8E501F236A5
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 03:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30478C2C6;
	Sat, 15 Jun 2024 03:09:05 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4EF3D60
	for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 03:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718420944; cv=none; b=YOsCgr6OsV+wLGHatCS5egbGu0VaRTkRWiXXtzsWV2ox5FPBRpLicutW7zVFsJTz6zAs6eZkbdsZtnuF762fYd3oxmrrgV41m68V/NpbI88R3aGIAmrcEAaGXo4CjMwphdEdHq5WYALg0zl53prx7iV0rufRXgTcrvbo9wImj5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718420944; c=relaxed/simple;
	bh=AlUQzceKYhFR8viGG4pP6jRgXnnKvOGiiFeL7J20gUQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=M4NdYNYHG9e4YbAbh1nC5ynWd5V80MI5vbvmCoERnLrvFAFvdGGJsXCEzn+p8bxjycx1IXMzkNWphUTNG3sy3ykxfgtB1FVIZMMznVk0HbcCTipSqeS5TgaIUHCocItVaYKCm+9oPf8F49f7lJgIMGnWZsQLZ62myCiHrfrONUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3759dc7d4f0so30481905ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 20:09:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718420942; x=1719025742;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Uk5t9tAROpS4Wa3sPWZWuQj35YlulbH2As6zClNwDzE=;
        b=fW44iVc6BPrgaINJ1+SFfWuvy6brCc8GyT3d4iJTiKglgbwGcrmyV/0uTM8Jr4I3bY
         dD5DJb5IC2WfLlmLIHSezknVXnvIhLnhr+0AGz7gKnp9Uuv7XF9Wgn17ze8ck5Q0tGlC
         WHtsGysIwFrx7hCwRZOJqDBMCDT8pyo9MCqHzA4xNlSZRqk8qHTgb9wtG30JBLOEXOzP
         ike53Rl/GZU3zSE5c2Zd/IIXb2PKjDyPd7pa86BpHkc680kkB7cmScs7tm5S+7A5eVvm
         2kaSHJnD9wJ4845JL8Jk8qwZWns5fr/DWPNUwcos6hZPtr/YVAqnX3rv21GCHYZDxhIy
         MW8w==
X-Gm-Message-State: AOJu0YwuWj457KzWWgUmuGyBARW5Yw34nFfdCX5LLYSyJSBBEWLBC2Cz
	vTKj4JHDNnjuBNwkZkcYLwrdgwrdXItJ1Hm5JAx0faZm432nf6PByloURfOMFJe5GzZYx21MSAm
	Rnpw6HMJpIEX51CV3+53Fg7KNAlKkwlQ9b6hOXDei7mUFfFnmnvc38N4=
X-Google-Smtp-Source: AGHT+IE14lv5FY9cG6UpFOwqIveTG8CllCGleGX+Cvd+y/Wk8aa2eE5PH5KO7nw/7d8XfqX16a3JQDVnmNqAU/7A80q+dyrvD5Zx
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ca4a:0:b0:375:a202:254d with SMTP id
 e9e14a558f8ab-375e0df97d8mr2195345ab.1.1718420942403; Fri, 14 Jun 2024
 20:09:02 -0700 (PDT)
Date: Fri, 14 Jun 2024 20:09:02 -0700
In-Reply-To: <0d900a20-0e9a-4b61-844e-df38b10bc4f2@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d8cc04061ae50da1@google.com>
Subject: Re: [syzbot] [bluetooth?] WARNING in hci_conn_del
From: syzbot <syzbot+b2545b087a01a7319474@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, paskripkin@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
SYZFAIL: NL802154_CMD_SET_SHORT_ADDR failed

2024/06/15 03:08:49 ignoring optional flag "sandboxArg"="0"
2024/06/15 03:08:49 parsed 1 programs
2024/06/15 03:08:49 [FATAL] failed to run ["./syz-executor" "setup" "fault" "binfmt_misc" "usb" "802154" "swap"]: exit status 67
mkdir(/syzcgroup) failed: 17
mount(binfmt_misc) failed: 16
SYZFAIL: NL802154_CMD_SET_SHORT_ADDR failed
 (errno 16: Device or resource busy)


Tested on:

commit:         c286c21f Merge tag 'block-6.10-20240614' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=144e93fe980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fa0ce06dcc735711
dashboard link: https://syzkaller.appspot.com/bug?extid=b2545b087a01a7319474
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14d0aede980000



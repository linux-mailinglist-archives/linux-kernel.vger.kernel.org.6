Return-Path: <linux-kernel+bounces-203660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03B408FDECA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 08:35:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C7FA28847E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 06:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CECC73445;
	Thu,  6 Jun 2024 06:35:04 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7360101CE
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 06:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717655704; cv=none; b=heCkX1abyrFMSJDmoEeZ8GOyYgQaEp6kanednIMbmMNCQ1/+knmYJfS7TCdzLI/8pt+Did6Ubi4RAGruKY9zFiGOJEdCVODtUUZvElcSNOEIjrpn8BtkfGylOURJuiL85fiwGRbFCutxk6egN8jP9iJGyYrsxfHseIgGXwbnchM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717655704; c=relaxed/simple;
	bh=ls6qIClvI8ASOR4gsM8jHGCMbviTBNUuDJYtMobTXCY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=vGc5J5kl9XaLm9S6EASAOR1TuBiqODoMGSeN0mNPlPuZFnQBYlGVmRyVnOOTJ4jayTK2wbcMpGMeBmYmuFvAiMVfnmiJc75oBKQs5Emxrqc9F7Uwo+WUKWnKwzAVzDQpRjsvz8+8CMm6UWqd1oG1cm9TgUYrwXDQTLWHzmgUMlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7e1fe2ba2e1so69515939f.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 23:35:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717655702; x=1718260502;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xJj8SpHZ3AK26zye3PjAjsbyQ9sFn5edKca5Lm2sMk8=;
        b=hJsWOkx+31KGTS3XA69KWYeiI4onx+1VMGnmlWtv1L6yp8v4EV9iVMaki93ATVdqsU
         x19ANOOsXqtqxwo2YhkFT5a2QP+IhdECO/5/Pfwa64YwI/dbLWVXGmqrWY6FaOXbPwZE
         Y9653fe27v8Qy4eFJf7tFKN46ulVQXgqbn4hZPAX9d9wLEV8LQoR6hh2RzSwTQtGoyKl
         N5PjeZfpTy6SsfcIyZ8gqs5J9XLD8eCLYbFdphQUx4jczJKAhXfTWvorjlgxA+kNYluR
         yh/IuAyy9nPSk5crsHZAcnTAeHVC05pykOSKbLughJvIEyCWZhWpuNs8bRKAt4nC9UOx
         f44A==
X-Gm-Message-State: AOJu0YwlH2CzdHljDWTdF03UC31gXgspzYE0x0KBAuLp5ZQ9owKBBkmF
	NCnIJIVuSzsCnDin/PxxWvZnuiqA8iGmdug91pMfGgzSgOPaQcHr/wagkL5bXk+GeBt5iDv133/
	LQdCk184P+o7l2rVFGtFYq7iAXYjHraPPgNYx2FO8TdB3ApYIOAp15X8=
X-Google-Smtp-Source: AGHT+IHls/gGIuDXCbpD732nqhfvkoBJGonxdRC8XS8dI0J9VwiFFGs4JLFQQFQkzmYO3b9UhLfipKT424YijfOmWWOk3hDqY+W/
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:6283:b0:4b0:ae06:24c1 with SMTP id
 8926c6da1cb9f-4b63c0194c0mr124892173.6.1717655702042; Wed, 05 Jun 2024
 23:35:02 -0700 (PDT)
Date: Wed, 05 Jun 2024 23:35:02 -0700
In-Reply-To: <20240606061456.13663-1-norkam41@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f78eb8061a32e1a9@google.com>
Subject: Re: [syzbot] [ext4] KMSAN: uninit-value in aes_encrypt (5)
From: syzbot <syzbot+aeb14e2539ffb6d21130@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, norkam41@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
SYZFAIL: NL802154_CMD_SET_SHORT_ADDR failed

2024/06/06 06:33:50 ignoring optional flag "sandboxArg"="0"
2024/06/06 06:33:51 parsed 1 programs
2024/06/06 06:33:52 [FATAL] failed to run ["./syz-executor" "setup" "fault" "binfmt_misc" "usb" "802154" "swap"]: exit status 67
mkdir(/syzcgroup) failed: 17
mount(binfmt_misc) failed: 16
SYZFAIL: NL802154_CMD_SET_SHORT_ADDR failed
 (errno 16: Device or resource busy)


Tested on:

commit:         45db3ab7 Merge tag '6.9-rc7-ksmbd-fixes' of git://git...
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1555cbaa980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=617171361dd3cd47
dashboard link: https://syzkaller.appspot.com/bug?extid=aeb14e2539ffb6d21130
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12cf4aac980000



Return-Path: <linux-kernel+bounces-289974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86789954DF3
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 17:39:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF9D928452E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 15:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19E131BDAA0;
	Fri, 16 Aug 2024 15:39:25 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9571BD50E
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 15:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723822764; cv=none; b=pYbpmEQLIhdjdmz7ss62q3xfXjZwV/xQ2uIwtodhKiLOahwuP78jTKGcvZ7orVygRpZOMkzHjqoEwulsBmblGCw/q1Xm/zn8wp+0KPbAjL0MZTzsylN5bQ1nqYPgSojIdCNmSCCR/HUfHyRe6qT/t9A8UiUZh1eGHEKDiIx8iNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723822764; c=relaxed/simple;
	bh=Qua74G8TmHMqzpDOApA3OP9bZzvNpc2IpkXeC8mI4y0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=SRADq47WpsFvxKGyHQB0s5yfep8fsxPKGsrCej4dEi2PXQT9pfaHcMvWJvYLegCIVqIh486X2PbEiJHiAMUsdptMerZin86+P50B7fWvDzR+8gUj2yseGfeyw6TuoPnkTGVDM6Si5ciEVzOAxHBuw5a7I89z5LmkFogiU9q6GHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-37642e69d7eso18806245ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 08:39:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723822762; x=1724427562;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N8JJez+0p2S8btQve7w0Pep7EZa2y6dLItyWBelrZsk=;
        b=xRu7uIOSO/7BYsv2LyrfxyLaIiefdd2fa+znqPfrvrnUTIkLfR/TwWoHzxtqPe8PdW
         E93EcDwqnou0axEbr3G06NCK4Zr+d7IrNk6zuqJb8ri49Yco/tD8QEBI384Tgcwj2kY2
         qtov9rX3ZWABNYsDBAdgDByFLY1c00QXhCQtJUtxCnMPy0WTq92Zo2Psh7maBcxYTlGs
         cHk29LPwu+9OJfueO3KCJNEYgOIlr+gGdNuiilD2y9oCbGiWXjQv0OVdcCQcC2ovFZHw
         ijiJiJl38+oykePYYDZTnz4wRtvq8RafaHJ03I9qShnbMd8Cq6Afx3dfa6XrMHeU74se
         YRZA==
X-Forwarded-Encrypted: i=1; AJvYcCWB1shu4bp0W0OpdtHO8sr2/U+4D+XL3uxBkmM85Ph5iifl/O0+IpZAROxeyJK6UKln/v8R3adnhFH1DBxtVADz3MhcCImaN4Ngkbpj
X-Gm-Message-State: AOJu0Yzg90G/PTSPSfF0XfS98oFVK9IeVnSf2G8NfdUNsMOknggi49WU
	trcZU9F27s3uN6Ss2PITzIr+Du6GF1IEXdVX/L8Srvf7pK97X8hXwi3bOuc3jcx+HAZ8COrCX9z
	FjkRjsdrj+qMk1Zbx75PS1p0wAnNwaWGnF2wIywe0UPPpsD4Kl/d3+1w=
X-Google-Smtp-Source: AGHT+IH+DNxcyVYu22+wS8Im7fRACul9MEEKcf/DaaIOWxOiPuPbKbPyVxVJwl69AVkF5DZTBZA4g3tZks/5IibMJpW6Uxz9Tdtz
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:170e:b0:39a:eb4d:23c5 with SMTP id
 e9e14a558f8ab-39d26c36cfamr3092675ab.0.1723822762159; Fri, 16 Aug 2024
 08:39:22 -0700 (PDT)
Date: Fri, 16 Aug 2024 08:39:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000065062c061fcec37b@google.com>
Subject: [syzbot] riscv/fixes test error: can't ssh into the instance
From: syzbot <syzbot+cfbcb82adf6d7279fd35@syzkaller.appspotmail.com>
To: aou@eecs.berkeley.edu, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, palmer@dabbelt.com, paul.walmsley@sifive.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    32d5f7add080 Merge patch series "RISC-V: hwprobe: Misalign..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git fixes
console output: https://syzkaller.appspot.com/x/log.txt?x=10e639f3980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e12019db89cebcd1
dashboard link: https://syzkaller.appspot.com/bug?extid=cfbcb82adf6d7279fd35
compiler:       riscv64-linux-gnu-gcc (Debian 12.2.0-13) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: riscv64

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/a741b348759c/non_bootable_disk-32d5f7ad.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/360b3f269693/vmlinux-32d5f7ad.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c6ef680b5e89/Image-32d5f7ad.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+cfbcb82adf6d7279fd35@syzkaller.appspotmail.com



---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup


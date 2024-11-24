Return-Path: <linux-kernel+bounces-419322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49E799D6C75
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 03:03:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86489B21498
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 02:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8FB7FC1D;
	Sun, 24 Nov 2024 02:03:05 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198171370
	for <linux-kernel@vger.kernel.org>; Sun, 24 Nov 2024 02:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732413785; cv=none; b=RgzAxBzD5eWRmW/Jked7uy44sssW7GCQ9jDiY52+snQsaufZ+mm8AB2+FQXrtc+TLHFs2db4dyskXwyeozkLyd9v3kkavAEBSiMTABQM1rBN6r2U5V9D21r+fZaFRBdTQLFw/zbAPReHr/Vu0XF5H7CRdPoCT2oEfCMJDC5ZM/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732413785; c=relaxed/simple;
	bh=wKOS6kuMRiKv0djqKJKO0SWL+0ljDjxFOJojfR//bXI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=dCkOB7k+yMQOVRPD1FZ3UEyOtRbIl6k40utGrDec7VK9AaQ5E8JkGLMfKAobEq+BZ4cQ7A6us6AV2yt1ns+DQ4Ekchq3nOa2t3AZ5Z8ZcpRq6kN2mLZvfclvYLt8omX8nbAbFxBIqKwarzss9b6yl5q26RQo1mYv2m1e+zWlNCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-83e07db6451so374886739f.1
        for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 18:03:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732413783; x=1733018583;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dsK2DDxX8/5s/4MDUlb+3ESwSOg8HpdPkz0O5YxTNSg=;
        b=JxSJPqGhNUlZ4js2Oaa33NeOQVPj0lLmZC5r1n2PIU6slgJjRIp/PicVynXiymkhAf
         jU/W268+c5MKB2u7uCg05LN1b4nG0c0sntqPHDA/gMO0n0wKIiPNIIzD61P67aO/fZeP
         4+U0rrlc9UI3Sz8oDpCtkKr4bnVbD2pweb111EBafmgRm+RIo9juBzLnGaylkHix4o13
         sznSxw61tIuSMFj+QwPHpfZyBV3gHpiBq9HMuD9mhe3f8fBa10FFTWlM8lKLl9HIvnRs
         ULbBqzqODdHyQwTkgnemOLpNpA0itG71A15z3ExQm6xOyADuCTvv3yf9nt3WFukwrBjL
         oolg==
X-Forwarded-Encrypted: i=1; AJvYcCX8JGg1yH5olMr1cjklEcbgb0Bx1bmnL3RdZzWOz41ukwYZpJXOezGkFldCisgyf5v8EX6s1PBRfezMmNI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYYUsoaRUdTbEPluSKV6rPE+JDJVhDh4RNtyehL0vEeJBQSBSC
	egRZjiAPYjPfoR+JgEk6d+3DLXh1iOFN0CgEsHy2fqJaw/Xv8EsdiBCkV+W2397Wbr331tOuKi2
	kEHQOoXbYKdGEqfL0vLCDOooOrr9WVekNWxbyHCV6z1nfkcHRyWYWdJc=
X-Google-Smtp-Source: AGHT+IF+DNWP+x0fg8StCR3ZpWzoweheSRJSQEQojHyIe5CRY+iwCnlT4H3kTAxC8fZXBBPQg5IYNddMZhSDp3EoHRKb6TYgmtki
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3890:b0:3a7:a29b:bf2f with SMTP id
 e9e14a558f8ab-3a7a29bc3d4mr69787105ab.9.1732413783359; Sat, 23 Nov 2024
 18:03:03 -0800 (PST)
Date: Sat, 23 Nov 2024 18:03:03 -0800
In-Reply-To: <20241124013441.23975-1-leocstone@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67428957.050a0220.1cc393.002b.GAE@google.com>
Subject: Re: [syzbot] [f2fs?] WARNING in f2fs_delete_entry
From: syzbot <syzbot+35a21b6aade7af3c7b3a@syzkaller.appspotmail.com>
To: leocstone@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+35a21b6aade7af3c7b3a@syzkaller.appspotmail.com
Tested-by: syzbot+35a21b6aade7af3c7b3a@syzkaller.appspotmail.com

Tested on:

commit:         7b1d1d4c Merge remote-tracking branch 'iommu/arm/smmu'..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=1213575f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=dfe1e340fbee3d16
dashboard link: https://syzkaller.appspot.com/bug?extid=35a21b6aade7af3c7b3a
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10e476e8580000

Note: testing is done by a robot and is best-effort only.


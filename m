Return-Path: <linux-kernel+bounces-410941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BA7889CF2A4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 18:17:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE888B3FF6C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 15:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E42681D5AD9;
	Fri, 15 Nov 2024 15:46:04 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26ED01D516C
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 15:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731685564; cv=none; b=m8FI13+zUjRRBi+AVJMCB/VrN9GV/nDAyxBN9MJbG90UyA9/EOHSWyhDf9pYk8By+k8hBjTtkmljVgxwRLUWnorRplAt+bmTd9l0uaCg6nVq7/8tY6rtC22RMPe4I/RsdWnrKuhSPVIzq3+DHXm4qe1t5jZ5dLuO90ZA4j9ovwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731685564; c=relaxed/simple;
	bh=C1z1wooVhnl49qSCCjkFI1Za3qKRPwccUwGvpwESo4A=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=SSC0WHdxtltLi+FoAScOdf6+NrBXPfHguwfJjkOn9rnU1Q2XM+qGX8a5CJj9A9zHZL3V2k8upzw+8qgBsynTdPlvR1p7NAbgW4k14Za3d0Crej/crC++suJ5to9QjQ9tbX/U+gzWHA6+02taippZjIoW0uOP7Q2u3Y7RmK3yCfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-83abe8804a5so184035439f.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 07:46:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731685562; x=1732290362;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aLmKfosMsC9Sc3lnR4BoLlReCzco68XgkzuND4GpLXI=;
        b=GEBkePJWAcQNXXHXBhwms9Nc53My5kVpzuuGjesXLTS9HdMIZHqopwtv9Vay/kA0K2
         tJ/tSZDIPG5I3NwHHhsGDr2yl2mPs2HKdV+AUEa5o91M/yihh8iCk70fygHeihViFN1B
         KSbN+uRe3cLZO0gvQOPRlIZSfWECXwnlsKW8TTMVu43US8Ksld4B6D3vYykU9/xJLf1K
         RQjWyZuHqypthD0hUGgvV1LWsT6JsE5nlEvZ1mvw+1R5eo7BQ5cFKG6da1ZfZF7sB/n3
         8jzkhyr+XqZuh++3g9zNeSZVxtGRCXWvmb648+UM74G+kHik5UVt3A54yoKPbUmdFT9i
         Jpbg==
X-Gm-Message-State: AOJu0Yz8KkhDA9zX4Jmh7tx44aQjTmdJQhCFCP5gAy/C8krslmYPF/WH
	lMTrOaUzK5Qzw29FzdZKDhZKxPLCr3zPNNZYkDc3XtpKdRt2WM2HcjkBbIsmb76LRJIu3Z6RINB
	5IGfjdL6GmMQrkZvMfKLHaQ4TWLUn8rlXOaJyLSxs5YM3OUUqSV0B6y8=
X-Google-Smtp-Source: AGHT+IGR1j+HiAGz+YLEpD3uPCk7qg/Rp4Egsm6zINGLK3dWVsvQ8P1UpK4Xa1EMOoCtQrAiqhpb/rkxQTQdxvAg6tFWMLYKifU0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:747:b0:3a0:49da:8f6d with SMTP id
 e9e14a558f8ab-3a7480a0695mr31156785ab.22.1731685562303; Fri, 15 Nov 2024
 07:46:02 -0800 (PST)
Date: Fri, 15 Nov 2024 07:46:02 -0800
In-Reply-To: <CAHiZj8g60jN3tbjaGDc4r8vYe0s5zmvxx74Ni3vEv8TKjYXB5g@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67376cba.050a0220.bb738.0004.GAE@google.com>
Subject: Re: [syzbot] [acpi?] [nvdimm?] KASAN: vmalloc-out-of-bounds Read in
 acpi_nfit_ctl (2)
From: syzbot <syzbot+7534f060ebda6b8b51b3@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, surajsonawane0215@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+7534f060ebda6b8b51b3@syzkaller.appspotmail.com
Tested-by: syzbot+7534f060ebda6b8b51b3@syzkaller.appspotmail.com

Tested on:

commit:         cfaaa7d0 Merge tag 'net-6.12-rc8' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13845130580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d2aeec8c0b2e420c
dashboard link: https://syzkaller.appspot.com/bug?extid=7534f060ebda6b8b51b3
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=172adcc0580000

Note: testing is done by a robot and is best-effort only.


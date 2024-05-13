Return-Path: <linux-kernel+bounces-177445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B5A28C3EBC
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 12:19:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDEE2B210EB
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 10:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDFC014A097;
	Mon, 13 May 2024 10:19:31 +0000 (UTC)
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A003148833
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 10:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715595571; cv=none; b=OnMKnnHyDXpI2fwsOUaHNGKaAOsMnln2XEYw9scYLzLVsR3YYW4YdJp+J/yLNoc4qY8hcvddMR26XHW2TtDyUSa47pm0hpUeUHDYDyKgkAbehpdLep+5xncgIc3kgMAFtgM2/beF03aAis0JSliCe9p084ezItU1efhgH76ZNOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715595571; c=relaxed/simple;
	bh=LgLvUqQFTlHdPf+eMHthlrcPpJOHVI3IkuBNpAkRH7A=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=q4azdfyXaVUFhnuWYo3B9y/PHY40HyTKuFExXpHnS+cjv594Q2zrSdzoBV9Iy6R93GCpOfWmVgBTNiA1xqMjXgb3SwR/S4hfgU+G86KMdkUg2qAp2taV2zUWGW5p/a/5rv7Doc49Jr5tLcVSXDRQZ9EZnJKdPYY1CCfkUe6l5Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-7da4360bbacso524577239f.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 03:19:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715595569; x=1716200369;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qetPokwS7CKawVpVrtieM2hQJFQt8OeOARGqckdkIAY=;
        b=cAZYSM7yP/AKvHyTH38emHteIqH3FnbbzpRiEOW9MYe5ZehQSYQdLvHtcLgKdL8/M8
         +bPGdjNPyBOXIPTtkPkf9PnjccMuIZ5PiSvOITL2P0pwdsZSbzgagjPy63RfIlKw6yw2
         ilBU2xqnvogjr6nGKOcKD/QbO5lTMLGFwrn8IrxmJRc8CgUiH00O1nf3GBLjEkF2OHiK
         DZI/ipzKykmVUYC0xz7Eb/BedUVue3GhP5lYfp98avisuFFMCeqpUmQrCuLA0Hdwv3Zx
         6byRM1joskUkBNBWh7d7SEcKqCCMB22yesDfsqpvZm1oAwQgOUMZims2Da1lO79odtUr
         h0mg==
X-Gm-Message-State: AOJu0YwC7hhT3DpWnYubT5vncYJ6CEo/Cg1nvKQYy/50A9npF5ouEWoE
	GOi4lF+uqqFkWE9gFDT8kjTFti1T4mZP685AZonNsLB5okK2v52Ktg7e5d/FnMFXJxiCWrVza6/
	dJbtjNL2ngyxqZ4PqB+43pHe59e14kG7pbGqJEyp5nivYvoh+CEOmiHMsxA==
X-Google-Smtp-Source: AGHT+IFKpmfatjP58VFWj2cgSFaBZ/fjLMzixR/YP2TaO4fjadBf8N8tAvaOb/df9+D4wyuUJdOTOtop8JrF2Bim6MJrEkgkAQQo
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8404:b0:488:c345:73c4 with SMTP id
 8926c6da1cb9f-48958e13eb1mr840876173.5.1715595569138; Mon, 13 May 2024
 03:19:29 -0700 (PDT)
Date: Mon, 13 May 2024 03:19:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007a211706185338b0@google.com>
Subject: [syzbot] BUG: Bad rss-counter state (5)
From: syzbot <syzbot+f2bbbb592debc978d46d@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    cf87f46fd34d Merge tag 'drm-fixes-2024-05-11' of https://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17e54084980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6d14c12b661fb43
dashboard link: https://syzkaller.appspot.com/bug?extid=f2bbbb592debc978d46d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/1aa5ad92dfce/disk-cf87f46f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/67c336f7c1c7/vmlinux-cf87f46f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/bb5b717bd2b8/bzImage-cf87f46f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f2bbbb592debc978d46d@syzkaller.appspotmail.com

BUG: Bad rss-counter state mm:ffff888079dd9300 type:MM_SWAPENTS val:6
loop2: detected capacity change from 0 to 256
exFAT-fs (loop2): failed to load upcase table (idx : 0x00017f3e, chksum : 0x0b83170a, utbl_chksum : 0xe619d30d)


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


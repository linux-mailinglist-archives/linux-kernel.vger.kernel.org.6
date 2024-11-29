Return-Path: <linux-kernel+bounces-412765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B89A9D0F44
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 12:09:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FB6BB308C6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 10:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8B45198853;
	Mon, 18 Nov 2024 10:38:28 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1406194AD8
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 10:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731926308; cv=none; b=VulTh7Fp4vE05Rzyw4Egf9p0gZAydRybg9S7wWCiZ7Vw8002gdGDQb5I/1YiudF4frP7+4hpUXZuKsAiEIyFCa7bfRAoGXTUhaCzUjd/43p70gzELem36bt9XD9TpZD1Ey15HDyJYWsb654U0GhR2NdHHjie0YaBFaHGjUAfsYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731926308; c=relaxed/simple;
	bh=ITDFOy8qFnR2lUNsyqrLaVvela4Cb4PkcyBT7iAdI40=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=UcpOaYxdyW4Xi6/U6ytN/WOCKVW+HthYoOdi85awI2terErmY7opwkJjp4Z9/wefRJbiG4HyB85Xhe2JecTT4cezGwtO2BAJdPW/W+wBFyeNt1t/yqFWf9PnDE7aUs4atUhSb1aOIVsfiIHDgmzzINOIgAjJ/r2A96BZowqudL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a71bdd158aso44783135ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 02:38:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731926305; x=1732531105;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mFzClR9rRwnSNoaIUMwAnsmtSbOwn2K1e9XWKJdM9u8=;
        b=XGgnU2fIRL0QFNlAqjUV8BRc6mUuhZ/RH28y74L2zVfWvWraAy+M2ckzeOBPPeBW9N
         BwDTP8nTecBfO7zbjnbMPCfPtDEkuirfMmxuDnNfMOPaYB3/CKQqOZ+0/bzGH5Wyk+nW
         CRR6Szz/Cy1rrA38t82PCH8f5kOc9e3xHGnzXMv7pRpHOgFyB7yvtNvJrt9PB1pWX22F
         krxSMbMkDZzu/jEpfiVFc/lrpIyRrfitZmRarI1QHI9nfLLtT2gYV81PuAEcxWU/SQZy
         igiBdpCGhSFsrTm4rrMxe+2U+4zelI8R1MiTv+4Ya7JlZ2HRT0i5RIU5I3Uo3SilJoxR
         imEA==
X-Forwarded-Encrypted: i=1; AJvYcCULK+NXEAfY1PZPdmTUl9WPJgl17AkVMm8htsld02a+wrjVfuFBR+vxftLyiRet4YAEEbA3Hvk/O6WuhLU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwG0xYc6B57nz7KXrIZQVKGhem7TycA0iANmrqwsBv3bAexgGmN
	Wo5aTlrhj4PA7wWNvD8Avde7wiSEOMcXmKyLo1rU244+zVi9JSDVNLX1yuefABgZ2GmE/S+2+xi
	Mh33vVcWMz+6EJ0PMHI/bRIUmnFmD2fuRrd4H8LkfsGeCY4vfREpeVPQ=
X-Google-Smtp-Source: AGHT+IHhfGWjuwN2xX9j9N46bbh0Dn1rgsbzvBnPug6Xt/d9guut26gu5JUeEAI5OLnsKetvUDwVJY8M/BOkhQqjgm43Uvu9Uclb
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1ca1:b0:3a7:635e:d372 with SMTP id
 e9e14a558f8ab-3a7635ed423mr41642965ab.5.1731926304921; Mon, 18 Nov 2024
 02:38:24 -0800 (PST)
Date: Mon, 18 Nov 2024 02:38:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <673b1920.050a0220.87769.002d.GAE@google.com>
Subject: [syzbot] Monthly serial report (Nov 2024)
From: syzbot <syzbot+list9f9a306663d445e9f873@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello serial maintainers/developers,

This is a 31-day syzbot report for the serial subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/serial

During the period, 0 new issues were detected and 0 were fixed.
In total, 16 issues are still open and 44 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 532     Yes   KMSAN: uninit-value in n_tty_receive_buf_standard
                  https://syzkaller.appspot.com/bug?extid=559c7fe4b8bac56d38c2
<2> 162     Yes   INFO: task can't die in show_free_areas
                  https://syzkaller.appspot.com/bug?extid=8f41dccfb6c03cc36fd6
<3> 72      Yes   BUG: soft lockup in tx
                  https://syzkaller.appspot.com/bug?extid=5e87db90e68fbc4707c6
<4> 53      Yes   KASAN: slab-use-after-free Read in tty_write_room (2)
                  https://syzkaller.appspot.com/bug?extid=2a81fdd5c6ddffee3894
<5> 37      No    KMSAN: uninit-value in n_tty_receive_buf_closing (3)
                  https://syzkaller.appspot.com/bug?extid=dd514b5f0cf048aec256
<6> 10      No    general protection fault in n_tty_receive_buf_common (2)
                  https://syzkaller.appspot.com/bug?extid=2dda672e146ff12ccb02
<7> 6       Yes   INFO: task hung in paste_selection (2)
                  https://syzkaller.appspot.com/bug?extid=275e275bd3f536725dd8
<8> 5       No    possible deadlock in tty_buffer_flush (3)
                  https://syzkaller.appspot.com/bug?extid=52cf91760dcb1dac6376

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.


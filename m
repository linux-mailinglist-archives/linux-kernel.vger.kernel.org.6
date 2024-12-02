Return-Path: <linux-kernel+bounces-427260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DC9939DFF2A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 11:42:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1A28B2938A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 10:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC5761FC10C;
	Mon,  2 Dec 2024 10:25:25 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C5C1FBEA4
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 10:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733135125; cv=none; b=mlE/yH5/m061uCUC/6B+utv1xEtx9Kd5Fi7tTF9P2SBwQk+gOijiwuaV8TNaElS0E8qZflcRqgaVcSMOUzjP7EQ+YY1yiDx/LsC2S9eUQUTCvgesPgnR8JshhgKPlSTb1LifhF2VVoOgWqRphBJVlauWrVM7YsiBWqZ67Xfn6LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733135125; c=relaxed/simple;
	bh=bwU+8Vz6+R85zrOlU8SH1G6SCKGlY2MSsNEldJi4Zlc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=gE2lIIaGdNgoYZfK9H7k1von7p3s2wS2mDDCGqQeWFQvaCuYhVUMdzdbGlztytkodXrXQmc5zG1YEB19mcWaZB/bP7fvFytE0GM23EC7oEmo8O3mR2RE2WHBI8uy0lJjSNiJ2B1FAAKIrDw0F7EqT8epmttVwDThCGikdVQ4+Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a77a808c27so48414765ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 02:25:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733135123; x=1733739923;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G7BvBK1k+7yzTwiL16aKjkj3lzK9QCpioNhQY+7cKWQ=;
        b=XCo65Kbhf18SsB4LltL8b45P97dmUNotA//CLXqUzw/CvLmxWUBDbgMLIhe8h+YHRS
         ZwumDGIchvzRfFm+oDahtjkQW2IJVfh4Pe8DJo3Pb1olX0EnUYJyOVli/hax//lfAVcC
         tQ9ogL3LaH+awJJS1RkxPa3HjjhJFV4sgSaE5zsQsvrH4uOZcgJvxU7C2cHwYu4+o283
         QVmebppQI+YxHQrnHdQO/eKPm55TNryqfUysL2h/4WOy2y7WhpSyWTlUAPGg8MRJR0DI
         hnTYAo0s/PVg+9bfLCofa2yJ4lv1EBZRtvc3fjL+80b692hC50SLkvCxIyoareR2sT9N
         H8gg==
X-Forwarded-Encrypted: i=1; AJvYcCW6/0/veJBwng7pGbXQ+vXEQ4sByiMdC06w0grt0Q0/9ftVmYWG7HaFGANzb/wKe9Fdg/KJIom3ZnNY5U4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLU16Dmpymfvj41LEDeZNwUbcrWQYrFiznE6NKtQ31E2TYXgs6
	MbwpEI0L9Ucoxs6S6UU6zLicLJEjpmgBxKGjcT8UowI/5+WacZy6awTnjH1rEhRWqyfxA+Z6AOg
	YvyRgbDfAQOqhADu+3MvpHVMATPh7URjRzOsSwFMCq1zRiA3KLBtV6r8=
X-Google-Smtp-Source: AGHT+IH3LIxnVeeh5wlBJugS0WttyQLB/huRt9dxiUbMi/2OagJ6D5L01Xwupne/kcxNt3P+h7wQy40tjnA8T2Xkkvfpm0bS0VJK
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:4515:20b0:3a7:c5ff:e5e2 with SMTP id
 e9e14a558f8ab-3a7c5ffe759mr131776685ab.0.1733135123386; Mon, 02 Dec 2024
 02:25:23 -0800 (PST)
Date: Mon, 02 Dec 2024 02:25:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <674d8b13.050a0220.ad585.004b.GAE@google.com>
Subject: [syzbot] Monthly v9fs report (Dec 2024)
From: syzbot <syzbot+list45a27aadcc5c46dbab45@syzkaller.appspotmail.com>
To: asmadeus@codewreck.org, ericvh@kernel.org, linux-kernel@vger.kernel.org, 
	lucho@ionkov.net, syzkaller-bugs@googlegroups.com, v9fs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello v9fs maintainers/developers,

This is a 31-day syzbot report for the v9fs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/v9fs

During the period, 1 new issues were detected and 0 were fixed.
In total, 11 issues are still open and 33 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 3691    Yes   WARNING in v9fs_fid_get_acl
                  https://syzkaller.appspot.com/bug?extid=a83dc51a78f0f4cf20da
<2> 27      Yes   WARNING in p9pdu_vwritef
                  https://syzkaller.appspot.com/bug?extid=94b73a3e8ea625efcd05
<3> 9       No    BUG: corrupted list in p9_fd_cancelled (3)
                  https://syzkaller.appspot.com/bug?extid=15a08eabe3d3838fb641

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.


Return-Path: <linux-kernel+bounces-527584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5CD9A40CE4
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 07:02:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 460CD189D80A
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 06:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87C48194A45;
	Sun, 23 Feb 2025 06:02:27 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC21A28F4
	for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 06:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740290547; cv=none; b=l78JGa/mJzws9DVnRIGntJgFgIROef6/juhWoMB29Zs8ZX/j3rMwZERjak1Uh0mMVyfId/3ut71vfZioSu5odsUHTHg+vmfdJFpZ/gj9TzVj9b/sLYKlMNqlmfBLkQoDA7C3HO8TB0M0HRLCLAFlPIA49E/nwtg2tnpviZgRhKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740290547; c=relaxed/simple;
	bh=OAtn2xTdO+cgvKJBjCddRRYCUOnG9EQgRwoUJf3hThM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Rvg9oeE79vO1AA9H1eMr+5wK1Ue+TLotVnpHY3b4RDI85aVLW61Wkez7KW75kIdXk+R85vjrwaXdrgC45LaxiXonteA756gc/O/mL1UqaYZLsfbWTzLFdP8smett/KMpyiX8NuhACzE9vXjmF8d99bs6vhynR9hCz1hTlM0RieI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3d2a6b4b2dbso63212165ab.2
        for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 22:02:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740290545; x=1740895345;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XpCKX5dC6Lp03zGCSnuSFhesEWR5oKdS40nv7EcsF7k=;
        b=ZJ0wnAD11jmmVhEJEExf8oQPZ/RLCRUoYFR8qdyX4j2ajtP1PP5Gj5OQgEhfk2UvqB
         8qxu08FpvcWIi2eKrR1fGrgNP8wrZ6DF2zl0+xGkB75u++l0m3cEOG6Gzx8B/SLfcRTU
         X6kUyFTnHex1AmTEOINqkMTMLY0P9Nj7bsaxOb3GnOm4/Ljaffk9svccXs4YiDHSx636
         kgSrofx4GwaP/k41TgBQRJ01mIsPwUIbUYsrBOGCn6/f3jfy2+A+7XIUnMdyE1TVsPX9
         CgefFqMcS4IdzjQd0pCHV4qgnHs6CrFwkL1WwxUiSNMrn5pECO3BEE//9tZIhJkkA+1F
         nfVA==
X-Gm-Message-State: AOJu0YwA66EwkOaFXtL3FEDEKgI5pxMvRN3NGr/BMFnaB5F24grrmID3
	5zTE/3BzkEaU9ot593FnYBg72uAfSc3BmzIZa5v2qUiBg5Vgs6dvk7pzHOzONnssWcXyq3OKcRy
	oLqmKKNEiPE1R9nVn0DnHH8+yQZF23V2v27kpTPA3VMoTfJspssU9zJE=
X-Google-Smtp-Source: AGHT+IF1suL4fPIdAP6uDdEQd8QQfsV1EO4MxtkXzNB9QUmDwwTG6JcFwL+uxWOqvUqLKWGRSG5z5oQSZu13CiwBPJq7RTBUqgYJ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3113:b0:3d2:b509:af44 with SMTP id
 e9e14a558f8ab-3d2cae6c9damr96832965ab.8.1740290544831; Sat, 22 Feb 2025
 22:02:24 -0800 (PST)
Date: Sat, 22 Feb 2025 22:02:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67bab9f0.050a0220.bbfd1.000e.GAE@google.com>
Subject: [syzbot] linux-next build error (20)
From: syzbot <syzbot+06fd1a3613c50d36129e@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-next@vger.kernel.org, 
	sfr@canb.auug.org.au, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    d4b0fd87ff0d Add linux-next specific files for 20250221
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=17a5bae4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=76d7299d72819017
dashboard link: https://syzkaller.appspot.com/bug?extid=06fd1a3613c50d36129e
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+06fd1a3613c50d36129e@syzkaller.appspotmail.com

<stdin>:4:15: error: use of undeclared identifier '__ref_stack_chk_guard'

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


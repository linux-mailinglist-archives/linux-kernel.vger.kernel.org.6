Return-Path: <linux-kernel+bounces-552843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2A9CA57F4C
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 23:17:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A825E3AFAA9
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 22:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B48120FA9B;
	Sat,  8 Mar 2025 22:17:23 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3FD01AA1F4
	for <linux-kernel@vger.kernel.org>; Sat,  8 Mar 2025 22:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741472243; cv=none; b=W2DRHfJS2XcdqSljt9cvkzSIjo25tPs1Mouf37/VLLr/50ickf3Jq+rKk1C2HI9U475k4nmnqvfvXZljygPbsNWuP/W87GJCx65xBdbED8NCaO2st0H+vP9wOrjyfA+8OUrWW8YIb7IewoccGHR4zwjngFw7gwNdDABibolN4rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741472243; c=relaxed/simple;
	bh=VIbf+LpxRASsny0dM7fDcE6Ap5R7QKEGn7yxJ67XwFY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=JU10zlQnvTgqcPX63bZYJmeEobVYEtUEm4s13s3otUG7OsD8EqlnJNdg1bdDpCwE++mHlYPPoY1uNQdM0E86O6HuSoC6498aLd360mKSowh6uuZpiEDRPyaViYzsQSpxxkN05r3RRVJJ/tYn2jLuV91CekSncurGeVGiNkZyNHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3d2b3882febso24540825ab.1
        for <linux-kernel@vger.kernel.org>; Sat, 08 Mar 2025 14:17:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741472241; x=1742077041;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N7Zk9cB3ZjVYppJmt/zIVvvTzDcjLPcmPA98lMqVoXY=;
        b=MZVb/5s5dA9HS5lvPFD1Na/hO69/WeefF4CHzOD9caN1+YrBeq1JrT8Iqg/GyQBWta
         oX3VcLFL/4T0SYgbcR0jH+JBv4spktTIsWZmMRxX4HRbcn7vM0BJ3uO2sCBMsKhZb2YR
         tlCnd5THkCVAAmxPLvr8K63aAor4TIha5eyOI17QglY1aWAHoSvh/VUFv8dJMHXcHq6I
         9g9/WwPc/BJ79GPaLBndPiBYknGE3puBo9Y03XbZf6Y34mzy8cy5ffkjeXT76NeHKuVa
         UZnXE0p76Z3tLuc6m1JY2aypSgZu3q8OeTNbNeeDkaxl6oUo+sqp1EbLG0RbsL/0zvAY
         Dmgg==
X-Forwarded-Encrypted: i=1; AJvYcCVEvg6i7HPXBkLJE8JEXaQ2pau9RWIRt2NXdEAoLgOC8CkrN6MO+v287M2n+w91dLw2fpSSc+vvxlrLhF4=@vger.kernel.org
X-Gm-Message-State: AOJu0YybfrCHcL6TwNe8VoBpgioMWzc9jETMQT6+++O65GAv72foQKMt
	5YcW4nQDKKtyAxnVyoISFQ6Uz3PDjMEHS9VUfneCOPJwUyML63jF/YAdiA+94s6uDjWzZjbQNnu
	Fgox5UmScJCyAi7gD6P9n/n/K1i+KVPUym1UaJTh4ssI+TpCoW3xzZis=
X-Google-Smtp-Source: AGHT+IG4jODR+Cz+704vQP4AW33j/NCHNWn2peiV2QKBCOeMSirU/8gnkop8VMYl7wuNL/D3jnggDiXJ21lIUGyKvzQu0vX0UKmy
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:18ce:b0:3d3:fa69:6763 with SMTP id
 e9e14a558f8ab-3d44194730cmr106170415ab.2.1741472240829; Sat, 08 Mar 2025
 14:17:20 -0800 (PST)
Date: Sat, 08 Mar 2025 14:17:20 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67ccc1f0.050a0220.14db68.005a.GAE@google.com>
Subject: [syzbot] Monthly s390 report (Mar 2025)
From: syzbot <syzbot+list5aa65644226f16002659@syzkaller.appspotmail.com>
To: agordeev@linux.ibm.com, linux-kernel@vger.kernel.org, 
	linux-s390@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello s390 maintainers/developers,

This is a 31-day syzbot report for the s390 subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/s390

During the period, 1 new issues were detected and 0 were fixed.
In total, 12 issues are still open and 43 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 23481   Yes   possible deadlock in smc_switch_to_fallback (2)
                  https://syzkaller.appspot.com/bug?extid=bef85a6996d1737c1a2f
<2> 2802    Yes   possible deadlock in smc_vlan_by_tcpsk
                  https://syzkaller.appspot.com/bug?extid=c75d1de73d3b8b76272f
<3> 236     Yes   general protection fault in smc_diag_dump_proto
                  https://syzkaller.appspot.com/bug?extid=f69bfae0a4eb29976e44
<4> 66      Yes   possible deadlock in smc_release
                  https://syzkaller.appspot.com/bug?extid=621fd56ba002faba6392
<5> 44      Yes   general protection fault in __smc_diag_dump (3)
                  https://syzkaller.appspot.com/bug?extid=271fed3ed6f24600c364
<6> 12      No    possible deadlock in smc_sendmsg
                  https://syzkaller.appspot.com/bug?extid=6cc62f8d77a830dba3a7
<7> 10      No    possible deadlock in smc_shutdown (2)
                  https://syzkaller.appspot.com/bug?extid=3667d719a932ebc28119
<8> 2       No    KASAN: slab-use-after-free Read in __pnet_find_base_ndev (2)
                  https://syzkaller.appspot.com/bug?extid=9c7519dcc554d2511da3

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.


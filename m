Return-Path: <linux-kernel+bounces-172908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75F2C8BF878
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 10:25:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B98F1C22D27
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 08:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7709F45C14;
	Wed,  8 May 2024 08:25:24 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE262BB11
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 08:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715156724; cv=none; b=vAa42dGGOIFeSlhyTB8UFT4kOujOse186AYeQFZzLafv8UHaamNlvO0u03GxyDxZw3nksA9lMhI+lfSoUnqkhjSunS+Unzvko29cF8tg3yCDJefUPGNZaH6oonwHBwJgWM8UvnUS7+ctMpwtJHKBvneUUeW57dGUpWHeTY56tC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715156724; c=relaxed/simple;
	bh=EDU6BYJKgTwBgmgJAmNIOPET2TqzGaUgJ6O6qTRYEDY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=M7PkZbMODVQ2ljBOsdDHke6Mm2YCcVSGDYkuUim5Yru50aD0b8JBYS7evAB4FdS+VQTNkCmjkbIb+reIlWHAxNK8pBLFiPGtFG27sTSkweddINPWzQa3JbncDiea4TS3V+0dIRAtuuSRKGrzcLlGAup/E92qkef8FY+pnW/9SAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-36b3c9c65d7so43608915ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 01:25:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715156722; x=1715761522;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=01um0m4r2R51n5/yLbJ8hlh10927UAuk+QC0neqhbM0=;
        b=WRLaYS6jttFmkT0Ho4HQmortlG9sX0fPBCznYh4LxYIYbgU+i78KU/HhJTQOPbfW00
         W1OLa7AUg9RNfajLhmT/PLIBrAJkVORWnk1cUZM4RUkO7Pb/CCoUdECBCx+rqdgK88/K
         M2XUmlBdJUgdc6DTPSWHIAs2+SSh+DBlwy0w9/w5eJU2bd0XJNnviSx4i35D0bX2z6nS
         J5Psz8FbQfFMw88/XT1gCGiQE+dwUQ7aZbPeIr533KG15w96o2lu49pyOMCbfypOTEaA
         HSwIgNe8FwHbwnWq7hOPlwqGFyLDMKW+WRH+9oWVJa9tYdX5fQSpx8ztZvBT6295SjmU
         P2kQ==
X-Forwarded-Encrypted: i=1; AJvYcCUT8fBp7dkjxq9L63zzOtfq3KgbwrTWiW30mtH+lEgoIgqZ+QTm/Di3RTFarCCOu0RJeQiPT2A8KRXdtHNwIRqxHdB6UMf5gw9wA8Fs
X-Gm-Message-State: AOJu0Yy9JcRs7rJMxXjt18HiSy9v7fAaBXNd8B/ErNiLDqLHU6x9qe+c
	azIJ4V5pTeTvjr0YADrgi7ETXR2JIiRqy4LNE/1Eke9T12dFEbmBLJEyh6xGTuQoskCn7DB4Vd0
	GoZO9BE5bmfLe/WcEhJnN5nX2bUG5Z/IG7PGSUwg0sNJRSVNr6orSUHU=
X-Google-Smtp-Source: AGHT+IGpLM69dWDGYhR27WT7kB0GIIM1iCzIcKztfZR7y9f+VoXcA8gjpctMFXUm8agyEHKh2u9MIH/VRO9J6dhg1AJhMdpM5Cva
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c549:0:b0:36c:5bd2:6b92 with SMTP id
 e9e14a558f8ab-36caeb3f298mr887375ab.0.1715156722012; Wed, 08 May 2024
 01:25:22 -0700 (PDT)
Date: Wed, 08 May 2024 01:25:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002660e60617ed0bde@google.com>
Subject: [syzbot] Monthly kernfs report (May 2024)
From: syzbot <syzbot+list5d8859cd80433a36df0d@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello kernfs maintainers/developers,

This is a 31-day syzbot report for the kernfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/kernfs

During the period, 2 new issues were detected and 0 were fixed.
In total, 14 issues are still open and 20 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 2916    Yes   possible deadlock in input_event (2)
                  https://syzkaller.appspot.com/bug?extid=d4c06e848a1c1f9f726f
<2> 282     No    possible deadlock in lookup_slow (3)
                  https://syzkaller.appspot.com/bug?extid=65459fd3b61877d717a3
<3> 246     Yes   WARNING in kernfs_remove_by_name_ns (3)
                  https://syzkaller.appspot.com/bug?extid=93cbdd0ab421adc5275d
<4> 40      Yes   INFO: rcu detected stall in sys_openat (3)
                  https://syzkaller.appspot.com/bug?extid=23d96fb466ad56cbb5e5
<5> 39      No    INFO: task hung in do_renameat2 (2)
                  https://syzkaller.appspot.com/bug?extid=39a12f7473ed8066d2ca
<6> 5       Yes   possible deadlock in kernfs_seq_start
                  https://syzkaller.appspot.com/bug?extid=4c493dcd5a68168a94b2
<7> 2       Yes   INFO: task hung in kernfs_remove_by_name_ns (2)
                  https://syzkaller.appspot.com/bug?extid=6d5664213a6db9a5a72c

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.


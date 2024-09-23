Return-Path: <linux-kernel+bounces-335612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B364897E80F
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 11:02:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E43D91C20CA7
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 09:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9F1A1946CA;
	Mon, 23 Sep 2024 09:02:24 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F7E1581E5
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 09:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727082144; cv=none; b=Espdec+Xh/OeynKH14jdToqerL3Nigmo++DJf+AkdO6w8+z8cmmtIqFPp8qvV8l96HGR+Q+GleK9aKEkc9Ls1YvO/tBDURorMX2hgdAGEiC6sGeDs65W2blAH5yBdVdvdJkTsyWGcmXFNka0BLocKKrK7wFmLZdBwNcNWQ70OV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727082144; c=relaxed/simple;
	bh=zjYN+6XNObuuD6Fgeuukf6MO590AzBoG+ZyBDnAYjHQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=XsMn7lDQJkokqVh6sFKaDQDpp+s3Mr9keQiEWFzjYmTa9BWO2KpQoT+dqYzjle0hwuw9haDc0JVjjEpVlVHIL0aUy2g5DwIO2nXH4Ibmb3BKFzldObe8LZLNGwyA++XF/ZinuFlPoD569jVdV/X69QsbyQK61NRlUoqCeir3abI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a047cb2e7dso51397125ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 02:02:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727082142; x=1727686942;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cWuOSJPdiAi2bYO8+Uv3jbCSpy3BYawpRw6/d3ft83A=;
        b=pPjmcSPG1qRn8RF294fUP/AvKULUba42BFjiFEgwUdtgo4dfGiiTclZbzx7D6WVexX
         XaKAo4JEPiyfCWo7LrgBa8o2YuKBZ1VbsMDM8E3ofJvuneuqLFPFmXj6Zl9GKQMvR7UY
         pK9JwqdlNLD4EQ2QFiDdDcXROWLCjIUksSWZ+8FcmsXyrjNPdrYJG0N0pCrhKwDaEqss
         1HqlYu9jcO701QBNR/QsX8U989vw3VXc4PeTYrgdrWBWfLn6loeBw/gNr0fQ1epzUY7M
         qu6nxgEq+BuDlcN4rLXMWFynLtbFtLU3/QgfqmcXUgwWCT9rNIvSxD4J+9mD7QL28nV2
         Zgqw==
X-Gm-Message-State: AOJu0YyBMYAb4/OxeYCMN8UDWCfsUPCWk+ffGniDk9+I6uw0suV2yfBx
	jJEOrC+BZRPzWnSduaUk++ule2TD9BeJcwONCx9oTmOcLFz+Wc8d5RhUP4oGNpc1nv8y46eiyWq
	FJaj0awQu39w95jHsq76hpeTzttX7IhB0Ob3OJuINXwnOtMzXKYmh47I=
X-Google-Smtp-Source: AGHT+IGpY1JfcOhf7M78o2gWPkVjnHWZjnOfDvV7XM6hmxug7L/cN8DTFKoD6Y275/LyHBWILVfa4UaPIsxt/qYK07JEGZKtd7fa
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b26:b0:3a0:9026:3b65 with SMTP id
 e9e14a558f8ab-3a0c8d3d77cmr82137435ab.25.1727082142225; Mon, 23 Sep 2024
 02:02:22 -0700 (PDT)
Date: Mon, 23 Sep 2024 02:02:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f12e9e.050a0220.3eed3.0009.GAE@google.com>
Subject: [syzbot] Monthly lsm report (Sep 2024)
From: syzbot <syzbot+listfc277c7cb94932601d96@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello lsm maintainers/developers,

This is a 31-day syzbot report for the lsm subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/lsm

During the period, 0 new issues were detected and 0 were fixed.
In total, 4 issues are still open and 27 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 306     No    INFO: task hung in process_measurement (2)
                  https://syzkaller.appspot.com/bug?extid=1de5a37cb85a2d536330
<2> 9       No    general protection fault in smack_inode_permission
                  https://syzkaller.appspot.com/bug?extid=4ac565a7081cc43bb185
<3> 3       Yes   WARNING in current_check_refer_path
                  https://syzkaller.appspot.com/bug?extid=34b68f850391452207df

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.


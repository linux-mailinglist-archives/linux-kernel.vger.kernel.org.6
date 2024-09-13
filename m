Return-Path: <linux-kernel+bounces-327938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CA849977CDB
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 12:04:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A84DB29B31
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 10:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E3061D9326;
	Fri, 13 Sep 2024 10:03:26 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794AC1D86F8
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 10:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726221805; cv=none; b=KPeWzuZ1wZkwJFoYgl2+ncSkc3Z5llDA6SkkARoYkH4mSKqxEmqvW5FYN3nFzzJ0HtZAAQTg4aKhAbBnoGnPgTsRK61uyG38jhe9MJg4GfI9/YQpqTBUvOGtBBtw0CN3vFBSmhD2R7nWzg7r8FNnQrx1ePjuO8ELK5GeX3ug5s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726221805; c=relaxed/simple;
	bh=hcG01ST8e45UuRcQW728YRd10XtpXJbuiMVFMVg+enY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=HcUdcRkqOpEKPRgfd6to4GogL41EYI7+XdW8x4lsVn5UNKq1yqBOCR5A3PMPhu7Fqlz9+82tL0xTXjL1OZCRcxYVKgLj4xeZwSA+XmxjFVFWc0722pfcFfUaV7AY+MDmJLDKR4bmvoXUtIHfsU0ZhQlC4yV0utDqttqgsKC9BaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a045e7ed57so23557415ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 03:03:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726221803; x=1726826603;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6MbNjnzGBD+c48nqOdaJX6Kfy5r3ApeW+WnnKbCaAOE=;
        b=hK2UmGFcjw3/VDkCbLHxiPBYMTKyZaRjJyYHPSRYuE38txBasNwGXEghEr/yKhxpkq
         MqVfYQrOpuN+CiGSsJxFnad09+Pz9qKEouJgl+2CKPTN1Jkxjc7J7c1rPSJjQumVyKOy
         UpJUV0d2V2xQb73cSZJxBeILIKOdekA5tjpbEL1WxwtcAkkW6YvtdAQ0yv3Ykm4lzNzJ
         dcbFY70BbFvYSmVLymycl8BWfOnNQC9NAJp3IBuhagNq6pg6v9CCMUeGmpekG5bXjrJv
         sVsF0+p0MjCQ6dZAf6C2x+/MPnW2nc60EMmSDcL+D5wl0vqw9sIK0L6tyXynytaKaqRf
         VVjQ==
X-Forwarded-Encrypted: i=1; AJvYcCXdthszx1DNlgA4dTmLdrHtZcPdF5UKM0wXh22/WO3EJSpgPd82PuXTDUr/XwxcNC0uPPuT6qcrdwwcoT8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzG+jg/2075zwhmD7NJXxP49F7lc1RhxVUlFGwirG8l2ODExEmm
	460WDgmDGe8cy6J43GhLHxDHEf2K3alDL/MwilaXbBrnlYlC8lofWuYD2o+0a2GBAaiF8Hfim31
	AubklniDHUSBVRhamDmhPLZFjaEyXrAq4pjNUAhhiNet26YJJo7Dcq9U=
X-Google-Smtp-Source: AGHT+IHV0q+2gAdFE5b7GHnfVLgMEhiugRjgmszAcWuWJvq+5tbsrfEa74JUfCulfRSXLpALkSsF2HhbQ5sfbPmdwecPkylm66al
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c56a:0:b0:3a0:8d8a:47c with SMTP id
 e9e14a558f8ab-3a08d8a07e8mr9091945ab.14.1726221803549; Fri, 13 Sep 2024
 03:03:23 -0700 (PDT)
Date: Fri, 13 Sep 2024 03:03:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006786970621fd5567@google.com>
Subject: [syzbot] Monthly jfs report (Sep 2024)
From: syzbot <syzbot+listda4fc358991102c9f36e@syzkaller.appspotmail.com>
To: jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	shaggy@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello jfs maintainers/developers,

This is a 31-day syzbot report for the jfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/jfs

During the period, 3 new issues were detected and 0 were fixed.
In total, 50 issues are still open and 43 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  19333   Yes   kernel BUG in jfs_evict_inode
                   https://syzkaller.appspot.com/bug?extid=9c0c58ea2e4887ab502e
<2>  8182    Yes   kernel BUG in txUnlock
                   https://syzkaller.appspot.com/bug?extid=a63afa301d1258d09267
<3>  3763    Yes   general protection fault in lmLogSync (2)
                   https://syzkaller.appspot.com/bug?extid=e14b1036481911ae4d77
<4>  2627    Yes   WARNING in dbAdjTree
                   https://syzkaller.appspot.com/bug?extid=ab18fa9c959320611727
<5>  2159    Yes   general protection fault in write_special_inodes
                   https://syzkaller.appspot.com/bug?extid=c732e285f8fc38d15916
<6>  2001    Yes   INFO: task hung in lock_metapage
                   https://syzkaller.appspot.com/bug?extid=1d84a1682e4673d5c4fb
<7>  1775    Yes   kernel BUG in dbFindLeaf
                   https://syzkaller.appspot.com/bug?extid=dcea2548c903300a400e
<8>  1542    Yes   KASAN: user-memory-access Write in __destroy_inode
                   https://syzkaller.appspot.com/bug?extid=dcc068159182a4c31ca3
<9>  839     Yes   general protection fault in jfs_flush_journal
                   https://syzkaller.appspot.com/bug?extid=194bfe3476f96782c0b6
<10> 756     Yes   KASAN: use-after-free Read in release_metapage
                   https://syzkaller.appspot.com/bug?extid=f1521383cec5f7baaa94

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.


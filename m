Return-Path: <linux-kernel+bounces-250657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E468792FAB2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 14:53:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 768E1B2233C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 12:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1F4016F838;
	Fri, 12 Jul 2024 12:53:23 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24EC516F297
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 12:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720788803; cv=none; b=edM8RHDtW9co8YJg+hbAhgyZxbxRS+WP4eDESYV9YY6UT9TLutDl026xHkcnRNuK9+ZbFGiPxHCuvs5jiQKeo8inhjrTk+Nw9hlXRgOQk8wVc9w2vxVElNj/kvdLjDCemB61jAekMvtaG2tOIyjRDCO+OMW4ADKmdMWkgh1djJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720788803; c=relaxed/simple;
	bh=0zU0dnesDNO6/UoaCmox2MOvYlnQ+ed6qQjU5rQWhTk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Z3HlzUW7DyYAzil1/sA50uoJO1fKsrO3I4Ss/QXlvtb9JWvQKU78SpOMNaqDh24YuJuZ7OJJQ7fkpWLuhZ+V87zTBkF5B261x+3fbLA4adK2dcu6C98I5N2a2s+ZqUSrfPLWfAi9oVMzrDrj21fxVZo/3Ag+GXN4rQp/BAy0yCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-807b123d985so207782539f.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 05:53:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720788801; x=1721393601;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NxqGbRT3LVL+0nPrwFQVVNOEcAeth5EOD0Me+bIoZgI=;
        b=WDeRbrdct4e+jIC5UDp/mvvDuJQdW75HyPsS3ksLymjfyPx+pQCeQWBcJT79QDoUh1
         SjVxESlNe64Udr6lrT9YeW81+7mpLrpP0pszjo1fH1H7/IUABy2iImyRo6YAzUuk6N0G
         rAhUIpuXNDHwXzK0htCDytiCuxikJ7cSATji14V+ajrqUSn16TiqP2StFktw9F+gNZm+
         Ut5nFeQsSOJP3O0L5Cm5PchNxlI3DfrESyYFJhPBZmhbA/+WHyOW4lkXOWBDIAISYSRG
         YRQ3uPmxAr2HYR6ogTaA+nXhfNi6502OdbV3A+Em/itzOIZ6+UmoBtNSWH5m/kinuMaV
         KKYQ==
X-Forwarded-Encrypted: i=1; AJvYcCV50XaD52LM5+KZBlgUZkBX5nh5XL2sTqSIDjaWDpfTfToFpqodjKp4TnNz5nKdJGnkvBx0VbBldXMGjLPIw3hoTJfGmGvGwnahyo6E
X-Gm-Message-State: AOJu0Yyt+MGI+0WVMy2Tp5flYoH8oOupNDyo97O79S2g5sRa2BlfBrvD
	Eep8hEFEYEsYzuVFcD2DwdgmoRuwm5Gt01S/t1Fp1y42D6hX4gMEjgixhQJG1DMr8XOFKBnkW7U
	aNWZeU6VNQd/jAxsdiip/2+oga/RV5v9jttv+eVlDvm45jH5Izxv/Y00=
X-Google-Smtp-Source: AGHT+IGjub6L3WCBvgOy2x0vV3c46oeVod9k9qcIbPFsr9/IXO96bBm9CyEelbZWlGaJJPVQfxle1JR4H443w2hVHyQENSx96/mD
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3797:b0:4bd:4861:d7f8 with SMTP id
 8926c6da1cb9f-4c0b2b3e265mr1027688173.4.1720788801253; Fri, 12 Jul 2024
 05:53:21 -0700 (PDT)
Date: Fri, 12 Jul 2024 05:53:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003b859a061d0c5d81@google.com>
Subject: [syzbot] Monthly bcachefs report (Jul 2024)
From: syzbot <syzbot+listb7d496953d366304c3b9@syzkaller.appspotmail.com>
To: kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello bcachefs maintainers/developers,

This is a 31-day syzbot report for the bcachefs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/bcachefs

During the period, 7 new issues were detected and 16 were fixed.
In total, 69 issues are still open and 50 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  2759    Yes   kernel BUG in bch2_fs_journal_stop
                   https://syzkaller.appspot.com/bug?extid=10b936c5eaee2819b49b
<2>  2696    Yes   WARNING in bch2_trans_srcu_unlock
                   https://syzkaller.appspot.com/bug?extid=1e515cab343dbe5aa38a
<3>  2424    Yes   INFO: task hung in __closure_sync
                   https://syzkaller.appspot.com/bug?extid=7bf808f7fe4a6549f36e
<4>  1100    Yes   BUG: MAX_LOCK_DEPTH too low! (4)
                   https://syzkaller.appspot.com/bug?extid=46405fa9afa07e6c8c40
<5>  240     No    INFO: task hung in bch2_readahead
                   https://syzkaller.appspot.com/bug?extid=a6060114362257e9798a
<6>  156     No    WARNING in bch2_trans_put
                   https://syzkaller.appspot.com/bug?extid=291aef749c5cbb9ca2fd
<7>  131     Yes   INFO: task hung in __bch2_fs_stop
                   https://syzkaller.appspot.com/bug?extid=6d3e28b33490b3085412
<8>  82      Yes   possible deadlock in bch2_gc_mark_key
                   https://syzkaller.appspot.com/bug?extid=050e797ad21ccc3f5d1a
<9>  80      Yes   WARNING in __bch2_truncate_folio
                   https://syzkaller.appspot.com/bug?extid=3d11e35eeafe176a6c5b
<10> 56      Yes   WARNING in bchfs_truncate
                   https://syzkaller.appspot.com/bug?extid=247ac87eabcb1f8fa990

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.


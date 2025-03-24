Return-Path: <linux-kernel+bounces-574264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C8EA6E2CC
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 19:56:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A53E518920B2
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 18:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27BE1267387;
	Mon, 24 Mar 2025 18:56:32 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36EB9266F03
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 18:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742842591; cv=none; b=dqk7pZNg7SkC3KJ+a6kX8U4BEaHFwKMJRnPZ7BSas6dY8vUfrd9tbxnM0CyCHyK1qbh6JMuftS/smN6KMMWuFHyo5oa404YRLZJanQOkLeukxSsruiGXz9VXVQq992+XuPX82/PAr0MVKJGv53NQb17eQ45U59YTlNtDfBXULy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742842591; c=relaxed/simple;
	bh=dGu8ZX7xORsOF8wWNZlRunghBJPEysAWFzcel8DWUz4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=NJ0LnZnWf1hdihQmtwbQ9ho++gXAS9+Z0d672wfQ76XHRCre32oANZnCs03NOuFjGHLXtb3umhPrf0UKmabaFTCRje3uscg7jj6z8R69eDj6I4ptuiDoLO0SWmDtQVPXhb9ROSgLh1AoTjDd4kA5bnAvm3a6Btg09SQCiSKuvHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3ce843b51c3so117494445ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 11:56:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742842589; x=1743447389;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hHEqM4s/n82u0+AHc6/WHpGzcmPow5ScOlUXqSyMHhc=;
        b=EDfdctGIw2FrCDPFBl9mmJZFklBsrn8HwmKLycvgZJs/TaUJWGGwRZEfPV51rpRtdV
         etdxe/Huu+lRSblNXg+SiggjU6t42Qq3kYBkx/r/8t0SIa6V6EtCS4J3JvZ+UhdFtqWU
         oTWIx3mMz98NHWiSlywlY8Zc3cR+eSTW83K5Ipmm0DxqcAWzcQtrjcgwFlMCkzxaduQW
         Dfyi1xQJiBTd5toDKuoXSBj9SA05YfVTCFMDT3OpK06h8aq4ufC7HVBL7NvlHkSjv9ic
         495JRtuaiGtzZnzlztigBnh21MIRtprM3ABZJM5oY0xSpGvQxubFkl9fagmKXlvd3ndJ
         VqVg==
X-Forwarded-Encrypted: i=1; AJvYcCXRpB1bxK7v1Z4JIVJS11zwyLLKnWG8iOPAJM6DS2LWl3gy7h8/lt1yg4VFs7Yxe0q6hemcJdLgbXQrOTM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywf+Bf1/afcIcKjiQicoJBAgWziWcV/vbFnhiCl4W1I50u049cY
	17VE+uHISKs92/BUcG1R2T3h+pA8PkO33iUbiRyx39N0c9gu6a+wYnyzEngq0QIChRQZPKSqGic
	hTTW4R8/02Pf7/ZFhfGsxp+JQyLIlhXnriA9Rn6hhqmqE4NO8EQf5mpE=
X-Google-Smtp-Source: AGHT+IHzLyC+7Jgi2/vD5BMI7zMaViS3yAQGImmRsLAOstVx7G+O0tdzNlbkVVkc4kM3S8VduVt+pEakeD+f60HgWrv7GCUc88pI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1525:b0:3d3:d4f0:271d with SMTP id
 e9e14a558f8ab-3d5961602a3mr156971435ab.12.1742842589229; Mon, 24 Mar 2025
 11:56:29 -0700 (PDT)
Date: Mon, 24 Mar 2025 11:56:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67e1aadd.050a0220.a7ebc.002d.GAE@google.com>
Subject: [syzbot] Monthly block report (Mar 2025)
From: syzbot <syzbot+listfe2d68429fd5e51f6083@syzkaller.appspotmail.com>
To: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello block maintainers/developers,

This is a 31-day syzbot report for the block subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/block

During the period, 0 new issues were detected and 0 were fixed.
In total, 42 issues are still open and 95 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  60676   Yes   possible deadlock in __submit_bio
                   https://syzkaller.appspot.com/bug?extid=949ae54e95a2fab4cbb4
<2>  5264    Yes   KMSAN: kernel-infoleak in filemap_read
                   https://syzkaller.appspot.com/bug?extid=905d785c4923bea2c1db
<3>  3626    Yes   KASAN: slab-use-after-free Read in percpu_ref_put (2)
                   https://syzkaller.appspot.com/bug?extid=905d719acdbd213bf67e
<4>  2498    Yes   INFO: task hung in bdev_release
                   https://syzkaller.appspot.com/bug?extid=4da851837827326a7cd4
<5>  1675    Yes   INFO: task hung in blkdev_fallocate
                   https://syzkaller.appspot.com/bug?extid=39b75c02b8be0a061bfc
<6>  962     Yes   possible deadlock in loop_set_status
                   https://syzkaller.appspot.com/bug?extid=9b145229d11aa73e4571
<7>  305     No    INFO: task hung in read_part_sector (2)
                   https://syzkaller.appspot.com/bug?extid=82de77d3f217960f087d
<8>  77      No    KCSAN: data-race in block_uevent / inc_diskseq (2)
                   https://syzkaller.appspot.com/bug?extid=c147f9175ec6cc7bd73b
<9>  43      Yes   WARNING in blk_register_tracepoints
                   https://syzkaller.appspot.com/bug?extid=c54ded83396afee31eb1
<10> 37      Yes   INFO: task hung in nbd_add_socket (2)
                   https://syzkaller.appspot.com/bug?extid=cbb4b1ebc70d0c5a8c29

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.


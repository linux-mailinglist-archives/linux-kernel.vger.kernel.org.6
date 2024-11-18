Return-Path: <linux-kernel+bounces-412764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8422C9D0EB8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 11:38:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20CE5281797
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 10:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5405B195F22;
	Mon, 18 Nov 2024 10:38:27 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E67A192D95
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 10:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731926306; cv=none; b=L3RqAHVt6KXeNK1otpaw5PcU9QoPRXMy7kX2LzBFH0+sf0bdtB0JaaMlce+BKVhztauzphu0ir2COSJffq53PFDxidQTsI0DwMQ5HlBf+wECy8HCgU0TF26o6pOG0rwGzBqqPY+dvN3joMaGejnkr/Rpt7DyEyXNUgzQohqSrW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731926306; c=relaxed/simple;
	bh=lyEVHi7boa6+42JktJuQBxCtcIyTYbecolg2zsmnpRs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Ag/9leeredkdIaHendOCGloTToBw9n3JLtl/94EuqJiLM7dJ45hBBtZ1cH/P5tqKe5T7KghZykI/rzCF7tVyi+7lU9oqJS70OS02/QjdL7D0IHnfdJmbpuiS97TntkN7FQSudLxHFQiGWjtb6LRH2jqVJq+56lERIYRoqMjX8aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a6bce8a678so35851405ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 02:38:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731926304; x=1732531104;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=08ogtEKcqzDtfuYA/LvivOvA8KPOKZ6Im/TfPJizZOo=;
        b=k1qo+38qlCmlJOgRkNboc0c8TsRIWZu5oWw78a0Khwu7yIhRrbaVagVjWjov2fY9QM
         J4/pefTbq9E3DJOPJ2EAWFpyJMRhXE02NT+c+0mxV6VidIYoF9R/p7H8+5K4H9WUTFg0
         1DaAtjj05l9igKtvtuRfALy46tzP13lNrgUC7Us8QLomMn6CGLPFhVg7X7iTWrV76e2Q
         oUFnfq/VtJohvnRiMgFksVP8rOAfO12HqfNPv896XDbUGvmmgflo4TCKGtjelLHxShxD
         s9erPcl6LviEKXUP8E+YDnRlYEpTA//KsMikG5UV1L8hxhRDLyx+zGZcQDMsKQmzIV6c
         NhOg==
X-Forwarded-Encrypted: i=1; AJvYcCVtjBCQGYBDnUCv9bmytf4c+l8GIx+IfvxmvWfxfAIkh1eIe8PEYWL43WQL0JOE5wHaePPxK4bpEmqb824=@vger.kernel.org
X-Gm-Message-State: AOJu0YxP0esUTXtPj0DhVrL1pINQ1rX7/c5HkqCVtVz/A7aIjOw4z6er
	vMrQ0p5LjJ3kINDfBJBdh+ijY/QFG1v6khfi6sTLg9NClAxIslA5geOHTHF4x5keQnbB/oPTr0S
	E0rSpi2bSy95dBSv4gqhfHBdyQmSZgu38sCBqXsB8dlO8pe53W1xXSGA=
X-Google-Smtp-Source: AGHT+IGkXnSzslqF7o0Dwg6YQ1iCwJF428jfkHy2lNlrgQToSRr0lemrPXX9zOz/8nQjZMDxI/UyYAOG7Dv3RCcBQmoyfMDzsd+5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b47:b0:3a0:4d1f:519c with SMTP id
 e9e14a558f8ab-3a747ff8c92mr119140425ab.3.1731926304717; Mon, 18 Nov 2024
 02:38:24 -0800 (PST)
Date: Mon, 18 Nov 2024 02:38:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <673b1920.050a0220.87769.002c.GAE@google.com>
Subject: [syzbot] Monthly block report (Nov 2024)
From: syzbot <syzbot+list462fc37593d30c75df84@syzkaller.appspotmail.com>
To: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello block maintainers/developers,

This is a 31-day syzbot report for the block subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/block

During the period, 8 new issues were detected and 0 were fixed.
In total, 33 issues are still open and 94 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  4450    Yes   KMSAN: kernel-infoleak in filemap_read
                   https://syzkaller.appspot.com/bug?extid=905d785c4923bea2c1db
<2>  2406    Yes   INFO: task hung in bdev_release
                   https://syzkaller.appspot.com/bug?extid=4da851837827326a7cd4
<3>  1643    Yes   INFO: task hung in blkdev_fallocate
                   https://syzkaller.appspot.com/bug?extid=39b75c02b8be0a061bfc
<4>  587     No    INFO: task hung in bdev_open
                   https://syzkaller.appspot.com/bug?extid=5c6179f2c4f1e111df11
<5>  335     Yes   KASAN: slab-use-after-free Read in percpu_ref_put (2)
                   https://syzkaller.appspot.com/bug?extid=905d719acdbd213bf67e
<6>  287     Yes   possible deadlock in blk_trace_setup
                   https://syzkaller.appspot.com/bug?extid=0d8542c90a512dc95185
<7>  40      No    INFO: task hung in set_blocksize
                   https://syzkaller.appspot.com/bug?extid=3c0a6dfa116ca1e1ad1c
<8>  37      Yes   INFO: task hung in nbd_add_socket (2)
                   https://syzkaller.appspot.com/bug?extid=cbb4b1ebc70d0c5a8c29
<9>  35      Yes   INFO: task hung in blk_trace_ioctl (4)
                   https://syzkaller.appspot.com/bug?extid=ed812ed461471ab17a0c
<10> 28      Yes   WARNING in blk_register_tracepoints
                   https://syzkaller.appspot.com/bug?extid=c54ded83396afee31eb1

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.


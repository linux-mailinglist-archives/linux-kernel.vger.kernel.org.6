Return-Path: <linux-kernel+bounces-196365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E97658D5AB9
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 08:48:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6E592851C6
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 06:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46CB481211;
	Fri, 31 May 2024 06:48:34 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662918062E
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 06:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717138113; cv=none; b=CF1cZsRcUR9KGedB3iUi9wTfy/5gk9ff7VFp6PcHkxubDBcIKIl9FfuHQKDktXghbzOCLA6zcyMc6ue48WIeyVbgKkLj3Iaxg7By/D77wsXKyOYKU5Kh5ankw6RQ//1X6BKqsRy5fEzVBqDUx2ysciimYvMT4h4f1eonDYyNlok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717138113; c=relaxed/simple;
	bh=IpHQ9pXBMLQwVnLeqFaCcD6lYgK0L2gpS0fDvq8+S74=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=th57q8SogWCDdHKQqXPBQwP1zIVRgvji28m16Slz/jmAqD8ePmajw3LYEjKaYsbtmFWPD8iXuhRGtJKbGHLF7pbJ6zCIvqWu/+3Cq4J09hTnfqtbZRfEuM635oyZEcp8v6iqZRbjY8ek/nT2qDB21NouYCgd8O2E7UdUzJq+aNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7e6e4a83282so216750439f.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 23:48:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717138111; x=1717742911;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4VPT2PQ2Se5tuiyJo6AYJJeaTgvUn7VCRuc9f1bOPYs=;
        b=vaknsnFrjIIJkNs34DcqqeVpDlOWN/4Ka3fr7o/nxh+f/ApcXNNH1IK4OoOaal3i3S
         nPEvuGJcvNDPOWjgY2zKX5llEYPBg6EdKzDusGpFoOz0JM0RtUQ1LhieSv4ULskJoXZ+
         92v7/aKRM0s/dbP66OBVWdaucqPCg0g9nEsulWl22kCxxYI+6TrXgB4rsRp0qI94IiqJ
         CZUh6AW5UyGmJ4T05sxVbrWcb40x6fCScxypKiQOnkQEdGrtYgzgpd5YtqNAw4Etfy6C
         kePsGDIKKycA+lT7jxMkPc0a8eP+gKTXIpPZH7e3azHFR7fIuQeK813SHAzCmisNPBAQ
         6wiw==
X-Gm-Message-State: AOJu0YzhKdl+lslN+a87YDRw3wZHM7323sN8t9swtnCANKmuZpCL7bne
	2X0aZSsv3l1PMss1VYuiE3BL1EkDBDCB44V7gz7e68vTpxWDxpNOj+AatLphznVtEUfFooqBLUK
	RClW2SP80NWavNEE9MMwVTX4AijKqS35KbDJ4M0rPYQiAByy8jwkq8Zg=
X-Google-Smtp-Source: AGHT+IHawgdtfdJHXnmbVaChxPF3fT6GQ5DxNIr2ZrJBKtLTUSGPY1gXJ7nGbG81xlJ2rWatp+sHSxg5oNc6xILQEa5dCzN85hCV
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3fc8:b0:7ea:ff9a:8420 with SMTP id
 ca18e2360f4ac-7eafff5276emr10056339f.3.1717138111572; Thu, 30 May 2024
 23:48:31 -0700 (PDT)
Date: Thu, 30 May 2024 23:48:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002bbe460619ba5f40@google.com>
Subject: [syzbot] Monthly mm report (May 2024)
From: syzbot <syzbot+list9b272dba49b70afcd21e@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello mm maintainers/developers,

This is a 31-day syzbot report for the mm subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/mm

During the period, 8 new issues were detected and 1 were fixed.
In total, 56 issues are still open and 242 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  10236   Yes   KASAN: slab-out-of-bounds Read in generic_perform_write
                   https://syzkaller.appspot.com/bug?extid=4a2376bc62e59406c414
<2>  7377    Yes   WARNING in ext4_dirty_folio
                   https://syzkaller.appspot.com/bug?extid=ecab51a4a5b9f26eeaa1
<3>  1078    Yes   possible deadlock in filemap_fault
                   https://syzkaller.appspot.com/bug?extid=7736960b837908f3a81d
<4>  720     Yes   KCSAN: data-race in generic_fillattr / shmem_mknod (2)
                   https://syzkaller.appspot.com/bug?extid=702361cf7e3d95758761
<5>  466     Yes   inconsistent lock state in __mmap_lock_do_trace_acquire_returned
                   https://syzkaller.appspot.com/bug?extid=76f802bc1dee8ba28a6e
<6>  390     Yes   WARNING in kunmap_local_indexed
                   https://syzkaller.appspot.com/bug?extid=691cb37358791bebebe6
<7>  93      Yes   BUG: unable to handle kernel NULL pointer dereference in __kmap_local_page_prot
                   https://syzkaller.appspot.com/bug?extid=b18872ea9631b5dcef3b
<8>  72      No    INFO: task hung in __lru_add_drain_all (2)
                   https://syzkaller.appspot.com/bug?extid=5294aa7d73bb0fa85bd0
<9>  49      Yes   BUG: unable to handle kernel paging request in list_lru_add
                   https://syzkaller.appspot.com/bug?extid=2403e3909382fbdeaf6c
<10> 46      Yes   INFO: rcu detected stall in sys_openat (3)
                   https://syzkaller.appspot.com/bug?extid=23d96fb466ad56cbb5e5

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.


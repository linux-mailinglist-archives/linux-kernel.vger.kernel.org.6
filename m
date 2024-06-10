Return-Path: <linux-kernel+bounces-208166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E4999021C8
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 14:42:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98A00282660
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 12:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D4A811FB;
	Mon, 10 Jun 2024 12:42:25 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E928005B
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 12:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718023344; cv=none; b=lDfZc7DXbkvMyEbYxPS1FBBst9cQH5ya2fk3UNtxwTIaMPZMjdiJnpajCjk9xQKW2Mlwgjz5WL8CwEuPAZ2UdHFpKQrpN8BmVskYyeOyi1Wmco069YRVpcjGTgx6zXKrY+ygDUfoN+0AwN9UtXLFCrUHqT7sICaXi8LRamhM1Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718023344; c=relaxed/simple;
	bh=xqvnRPhlHT1xb61PVDqRZOBg4oUZl5VxwhKpwXyI3NM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=DDp5A5i4KYn3d4g6GZDWQbDhHKxp6TLjmKVqFkfQINQDP5lhNxk+m9DSw93kpLkkblDNgCsNYndLWgaHm0ubfDLXgjXelzJ+/LsOOz4jMM9eSo+6MG5h/JrMVgZYskNH85vyvpy6QmUlz64AWDG+1ryTTYMNzAYl3wT5BCXUogo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7e6e4a83282so546521039f.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 05:42:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718023343; x=1718628143;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GpbMG2ETbMXj0gKo4wncWYWe1zxrquQJ0AP9UvXGvVE=;
        b=Sj1Kokgp63pSIk1v38EB75u4zojqlxA0aAIO5GPBmxStWX1VGWZYLbt6E5Bqdcegwe
         YX0deq/AAPa+Hr2A+Bk6NI3mNLLERb7nEilNzPIcSkG8N8a2MKOqmUdWIiYUNDCSyKTA
         o9bZP9CbKKqRdNpOBKRcmAhWExw5RGODdwxihO/XoPoErpm3i9qI8hr8gOqaaB3vS0XV
         KV9IM+vRXd1tEPfRLcq2kNBluOSVbMVT9XUNypPYUkI8TBzjZpyLkpLtL1pG08Pqp2I6
         pMQ3iTpxy9oIxSvwrNl/iZVa0zLPC6FkjxQSPbarrvTHoOlqm/0XeWdtoDckUqEjxZ/v
         6fuw==
X-Forwarded-Encrypted: i=1; AJvYcCWNjfz8JOWCju/IDO4KqPDDxNilX8ORk821e0IQkTaBvTFuRh5SxdMUVH9j+nuY9CbGeyj2M9qMX9GRZuyjn1xHP38W56LPX6ZhYmRa
X-Gm-Message-State: AOJu0Yy9w57fFKWbChVe4CUITGCewWXqq/iJTeKw4Cyo1h5zwQDwjdkz
	0pD9qCkbAejOonlUu3SJBxjg8VEvwbYpobjQpFsWG84+TPkzGoixPgWvrlhZlVRVwSJrDdv04iF
	Ej3ixqOyIzaqBR2SzhtVN4VLycXVPAnausM/kAxppokhDd9fvJ4D6ZNM=
X-Google-Smtp-Source: AGHT+IE9eZkNwX3TDsRRc1uDgc5CwSX0gyxWB9reSsooOC4mXuId0I6CFMMKG2mOGqlr+pZ9+G2QcNCZskuvhBtFk3pxpcNNSNla
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6c0e:b0:7eb:8ba1:af5 with SMTP id
 ca18e2360f4ac-7eb8ba11289mr11869939f.1.1718023342383; Mon, 10 Jun 2024
 05:42:22 -0700 (PDT)
Date: Mon, 10 Jun 2024 05:42:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000009f2fc061a887b35@google.com>
Subject: [syzbot] Monthly f2fs report (Jun 2024)
From: syzbot <syzbot+listd51a233164f971537e0f@syzkaller.appspotmail.com>
To: chao@kernel.org, jaegeuk@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello f2fs maintainers/developers,

This is a 31-day syzbot report for the f2fs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/f2fs

During the period, 3 new issues were detected and 0 were fixed.
In total, 7 issues are still open and 37 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 43      No    WARNING: locking bug in f2fs_getxattr
                  https://syzkaller.appspot.com/bug?extid=8f9e913ccc308e66c407
<2> 11      Yes   kernel BUG in f2fs_vm_page_mkwrite
                  https://syzkaller.appspot.com/bug?extid=f195123a45ad487ca66c
<3> 3       No    WARNING in f2fs_getxattr
                  https://syzkaller.appspot.com/bug?extid=3c58b51b764fa1f423b1

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.


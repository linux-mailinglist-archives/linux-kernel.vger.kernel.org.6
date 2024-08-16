Return-Path: <linux-kernel+bounces-290278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D6789551AD
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 21:58:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D80F21F22D2B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 19:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0DCC1C460B;
	Fri, 16 Aug 2024 19:58:25 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106D885283
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 19:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723838305; cv=none; b=QpYB0wdIJNz09wMbF8OKzIOQeA+ngWX6RJ3irXQWgZDvw8dej6GfDwFKBAoG91Hpi4+p4oCRJrNLKkGAqoeFgbTStcLPrjSfhCvwAySm4irQ7i1lX5Kqu8KJR9PsQ6stQIB8qiD1/ml4WVPS8MttGqqQGtNj0uBSrTOKXrm50aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723838305; c=relaxed/simple;
	bh=H9vh//VWzflLWcRpkU16TMxkNUSsitmPUcjiUugbVwY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=CkjjGeWxAfQx/q6eQXg2pu5iaBQddKQwKp6GIxhVePC+oTgwJU0ciqa9lDXHHngTOCzeZpITJ0+pJwppgoXig0ORzU3GgTprl6VAahUnzYHIThnCZSfSLntmH0UvIxG7Mk6WtZPJj9wi+fuPISim+VSyceCgh7EPhSCy7dRES4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-81f81da0972so244918139f.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 12:58:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723838303; x=1724443103;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=78+dl5LGKnr8YKWEYJeUtFp/Rrz0LOgHrhdp2PPMKtk=;
        b=FsZmidNyyOyQN/3+B0W64C/CWvSQf7wzNfUiQxLmKY0WDrk+R3dOrsfYWmdXoGIp+i
         Sv6wltfIKwwIGtLu0cf2iIcx33Ols4dNq7onQhQYBCZabVgJ5iKlGhu/j22me3eHD9Af
         8pU/Re66tEwlOKa4LYcPLCWArfhnUsep9vVmLqZjaBVtA4ai6CExylKIULRSrOhUwAyU
         gb1mwpNYTZFLKGbne14a23sDANy+qMVE6jGHtq4rfPNb+THnYs4qMiBbaxByBO+uNX+a
         UxUdtPTmFLpZvmHtoKjR7XMoEm5PcU9wtnNcnPfwLjUBHzLfa9+enNMMR8obawGLw84O
         X+/g==
X-Forwarded-Encrypted: i=1; AJvYcCX+QvB+eDFSTl29UczM258jGCVsy1Y6z2mdu+IVRn7BxLGYjbenZTRozUoQt+moL6t2xK904L1ydrjT8Z+tX3DcX4o+eJAReWBCz7RU
X-Gm-Message-State: AOJu0YztzXTK0tZSWFC2DnA4gIDhM4du54qe+DNQzse5vJbPExUqGdtD
	qi1uO5BA1UvB+uyWs3Uc4h0Eld/7241Rj/n12y7ifVkUvoM3Ff4ZrnEkyy/hPDDqADUKMfX2m7s
	d0up7rO+1StoLErDNYwOAsVhN9bL9lpaYe0FpOQmOW6UNIQBvzrpD0DU=
X-Google-Smtp-Source: AGHT+IEYuBTX7J/y0FAC61YM9mkan072gL+b5sT9Go3Rw8chVu/WRGx6V7S4j3onrXKfKLfK9LK3zv7EMr4JvatxldbIplXB+pxj
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:35a7:b0:4c8:d4bb:a0e with SMTP id
 8926c6da1cb9f-4cce168963emr168595173.3.1723838303182; Fri, 16 Aug 2024
 12:58:23 -0700 (PDT)
Date: Fri, 16 Aug 2024 12:58:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b62ec7061fd26144@google.com>
Subject: [syzbot] Monthly f2fs report (Aug 2024)
From: syzbot <syzbot+list2a48befeb90fd7d88a54@syzkaller.appspotmail.com>
To: chao@kernel.org, jaegeuk@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello f2fs maintainers/developers,

This is a 31-day syzbot report for the f2fs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/f2fs

During the period, 4 new issues were detected and 0 were fixed.
In total, 9 issues are still open and 40 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 663     Yes   INFO: task hung in f2fs_balance_fs
                  https://syzkaller.appspot.com/bug?extid=8b85865808c8908a0d8c
<2> 108     Yes   WARNING in rcu_sync_dtor
                  https://syzkaller.appspot.com/bug?extid=20d7e439f76bbbd863a7
<3> 4       Yes   KASAN: null-ptr-deref Write in f2fs_stop_gc_thread
                  https://syzkaller.appspot.com/bug?extid=1a8e2b31f2ac9bd3d148

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.


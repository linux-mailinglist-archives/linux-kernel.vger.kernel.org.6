Return-Path: <linux-kernel+bounces-310813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49918968182
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 10:17:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F36971F23BD6
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 08:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB412185957;
	Mon,  2 Sep 2024 08:17:23 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19FAF14D702
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 08:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725265043; cv=none; b=hHMpWBNYSXseco7ja6XW6EU5zj0i+AzGC9Bobl4mJCWpK8zee0OKTYBavH8esbo8VKJL/cDSHU5t6W6aP2yow/HSqjIXI2NMK9coPdOaalagwdK4PlHSxjCMcvxgFwqtmLlI1s47OE174XWvhowrZG9lLIF9f2UWE5EN6dJE7aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725265043; c=relaxed/simple;
	bh=g8Nq8R5TFnaGhdbVZIPwx7npHmrVGbcsdisPVs6ais8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=XL9ispJ5+20iMzNQFs73hn5B5WL1Ccnp0W4eV87bv4cKXg9svfAXBSVciSoUIoQaI+OsCmlgHkK7p+DNa3ciBuUngKmMNDtMcPM3MKV4zhJRGerFxS/+X8NvSOL76u0ExL/hCL94Rv9yElG6lpkMwsbEnH7r1eOY9XLEQ+l0Aso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-82a3fa4ecd3so197633539f.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 01:17:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725265041; x=1725869841;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+RHgZJy4TJS6MVNUX2I2ToNQAr8Q4JXSi6wdGTONFY4=;
        b=nfixVWJr6lA+rRPFG32Sbeb+5ISiANHFKen14JrJZ+twR/6cTAO2mf218HATInebYe
         Og+y/k2ae2g9L77KXPOa4uqdPHiphU115QDUBr3y/XadsxQjHJfGvu9dFOBMbWxGPd4S
         UhJJbmPCrnFibM1zh/KF73bVIraYWm8JbCpv81z0Ilr7fZcpEWR0aAnuHkC8dfrgPyvl
         eK/Uxp3pD1feimhZfnBLZSzmjiDh1ePdP+/yu6jhrbIPPhQca90Qx4HbDMgZGwCf1Dpr
         db95EwWfUsKx3k7K7DQyid1qpgkYgIyps70WmTOVlvmjjTDpmwBPaxReoHeLg5Oxk5bJ
         NgtQ==
X-Gm-Message-State: AOJu0YzggImJmwqj58bcc/z6wHGRUJUNR/0Xb6+vCDcoFGMAra0FBSeg
	IuHFOGCzha+ZFLkvDR4Xlbd3vTmsj2R4e5QiWoRC4ILmRZDhi/CKrkTg6sW65CxAVgIemLMa9hO
	EWYGr30Q39LhgC6FxmptP4anqBrAQpw5+zA2w75KHf4zaCQ5TK3hGg+M=
X-Google-Smtp-Source: AGHT+IFWdSNuIZZHFsZLtz2ogUMXN1xQvv7kyDuHuW7Lyj0BTCcEohYDKMiJSbqHHhktrrVtiv+xiJZTji5plLlfKy3s1bwzrFSy
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3494:b0:4b9:6f13:fb1a with SMTP id
 8926c6da1cb9f-4d017e9aedemr566539173.4.1725265041166; Mon, 02 Sep 2024
 01:17:21 -0700 (PDT)
Date: Mon, 02 Sep 2024 01:17:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ec1e7906211e914f@google.com>
Subject: [syzbot] Monthly mm report (Sep 2024)
From: syzbot <syzbot+listc7ad84bb8d65b663b9b1@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello mm maintainers/developers,

This is a 31-day syzbot report for the mm subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/mm

During the period, 7 new issues were detected and 0 were fixed.
In total, 69 issues are still open and 258 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  10269   Yes   KASAN: slab-out-of-bounds Read in generic_perform_write
                   https://syzkaller.appspot.com/bug?extid=4a2376bc62e59406c414
<2>  7381    Yes   WARNING in ext4_dirty_folio
                   https://syzkaller.appspot.com/bug?extid=ecab51a4a5b9f26eeaa1
<3>  1386    Yes   possible deadlock in filemap_fault
                   https://syzkaller.appspot.com/bug?extid=7736960b837908f3a81d
<4>  741     Yes   KCSAN: data-race in generic_fillattr / shmem_mknod (2)
                   https://syzkaller.appspot.com/bug?extid=702361cf7e3d95758761
<5>  432     Yes   memory leak in corrupted (2)
                   https://syzkaller.appspot.com/bug?extid=e1c69cadec0f1a078e3d
<6>  388     Yes   INFO: task hung in _vm_unmap_aliases (3)
                   https://syzkaller.appspot.com/bug?extid=fe8f8efd070d727de971
<7>  365     Yes   possible deadlock in gup_fast_fallback
                   https://syzkaller.appspot.com/bug?extid=63ba90b81c16b86379bd
<8>  276     No    KCSAN: data-race in __filemap_remove_folio / folio_mapping (2)
                   https://syzkaller.appspot.com/bug?extid=606f94dfeaaa45124c90
<9>  254     No    INFO: task hung in __lru_add_drain_all (2)
                   https://syzkaller.appspot.com/bug?extid=5294aa7d73bb0fa85bd0
<10> 142     Yes   INFO: rcu detected stall in dput (8)
                   https://syzkaller.appspot.com/bug?extid=eb9f416500ff134ab699

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.


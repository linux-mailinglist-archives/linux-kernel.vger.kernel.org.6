Return-Path: <linux-kernel+bounces-365505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C7D499E365
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 12:07:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A30F2B21B12
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 10:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A86181E2031;
	Tue, 15 Oct 2024 10:07:26 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E006B155CB0
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 10:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728986846; cv=none; b=qbAVUtjg7MV2Rj/He7i1RJn79byHenNqyyQptPzIrpUQXFRubAM0YUxkuyr2iBIPrelXQ/vo/4FHoWz4V2V6cJqDPLOx2Qb/BDehLmG0Q6DPZAbXYwMTnNvDg0Xo6arNDbRnaiqh5fehPFcrp2dftgpFUOMBMwbjOUruLRwQFfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728986846; c=relaxed/simple;
	bh=BJtB8MWXsIQNS0vTJNxQDJbVaeSTry/iBJdz0mO6874=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=AGN1pB6+GIZyd86mufDj5wZuCnLJDbqMUe+aeu9IHmfChDbW/urF2yx9j9OoEhpo42ogNkL1h82ZgcYbZziPQDpCY71wwf+WRewgMRhzMxFtZ+ARbYTDdxQcQL+RAI01pmzrFMztUdv+qIKUrYauyrJHo8T5WDy6gd0ai1Zjoto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a3ae775193so38528795ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 03:07:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728986844; x=1729591644;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HvLlDdzWlqELfwvc9RKRh3E/6y1R6ap4spML5744gV4=;
        b=K8AP8fc6iI+lsUwi3m6dCqmvaf6q0dpzHsku8eLLRr/L0qSGc3cxjXbE6/9thWjtnO
         Y7839ckqWHIwPv/hO/89qvjjzbHM0qI0tk1e4FwSG8d4WnVVNXbrr5erGRPo1gSgeSab
         Xuy8rGmJq3jfIxvo/mSZ0GW3XieMdVbQMiNivLOmsresbIdN1vS4mI9mhkbjd5O6aZ8G
         k17ZLHAtjEK8WGbX4r+cEJ93cL3k40SwxEddvkLrHswkKsRVUQ+VR9sZfF/TcWILz+PK
         Vrp+HoSVMGY0IHXwKVph5XuJuExUvMIfXqOwS0s6HSE84ikZu2Uv+j9dl84ZWM88hm3w
         Qraw==
X-Forwarded-Encrypted: i=1; AJvYcCWpPXYqmVnUbz+8tu+qcLYG5gR9XVNiKTPlr3/T4msNUuHcsqtc5itRdNwONtIxgo+QJx0XoVrAb/qOsqo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLoIojn2fS0grWBOLHtBqjXSHVTLf5oZJgYzNplQLgdd1JHDdS
	ff3mFgIT90Dexnzdh4ufXCDHfp8txl4Xj+5a6bFw2S2YpczuEcT54Ciue97poACTyRp2BtvYuEJ
	BE+8SBrUXuP1U8Myh9MZ1gmMCbvc3UG6lUjgx2BPllvFJD7hZqKX6JFE=
X-Google-Smtp-Source: AGHT+IFevwuuuwoQevOeV7O7PwoCtBDM6E8VUrattDKZ4QxsbBYhLe+yeMHezFwHW7trvTGH5wDgSv8tVeoGpTn8w2HdkBeBuJVq
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1489:b0:3a3:af94:461f with SMTP id
 e9e14a558f8ab-3a3bcd95e9emr92313395ab.1.1728986844074; Tue, 15 Oct 2024
 03:07:24 -0700 (PDT)
Date: Tue, 15 Oct 2024 03:07:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <670e3edc.050a0220.d9b66.014f.GAE@google.com>
Subject: [syzbot] Monthly kernfs report (Oct 2024)
From: syzbot <syzbot+list4a84ad01115222f5ebad@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello kernfs maintainers/developers,

This is a 31-day syzbot report for the kernfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/kernfs

During the period, 4 new issues were detected and 0 were fixed.
In total, 21 issues are still open and 21 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  264     Yes   WARNING in kernfs_remove_by_name_ns (3)
                   https://syzkaller.appspot.com/bug?extid=93cbdd0ab421adc5275d
<2>  183     No    possible deadlock in input_inject_event
                   https://syzkaller.appspot.com/bug?extid=79c403850e6816dc39cf
<3>  145     Yes   INFO: rcu detected stall in sys_openat (3)
                   https://syzkaller.appspot.com/bug?extid=23d96fb466ad56cbb5e5
<4>  92      Yes   WARNING in kernfs_get (5)
                   https://syzkaller.appspot.com/bug?extid=2f44671e54488d20f0e6
<5>  62      Yes   INFO: task hung in kernfs_dop_revalidate (4)
                   https://syzkaller.appspot.com/bug?extid=da20d108162166514db6
<6>  47      Yes   INFO: task hung in kernfs_add_one
                   https://syzkaller.appspot.com/bug?extid=e4804edf2708e8b7d2a5
<7>  44      Yes   INFO: task hung in fdget_pos
                   https://syzkaller.appspot.com/bug?extid=0ee1ef35cf7e70ce55d7
<8>  13      Yes   INFO: task hung in kernfs_remove_by_name_ns (2)
                   https://syzkaller.appspot.com/bug?extid=6d5664213a6db9a5a72c
<9>  7       Yes   INFO: rcu detected stall in kernfs_fop_read_iter (4)
                   https://syzkaller.appspot.com/bug?extid=c403e932e9c6662dd4f2
<10> 4       No    WARNING in kernfs_new_node (3)
                   https://syzkaller.appspot.com/bug?extid=306212936b13e520679d

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.


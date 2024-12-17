Return-Path: <linux-kernel+bounces-448982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC0A79F47F2
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 10:48:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E08B165C2C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 09:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE7591E1C11;
	Tue, 17 Dec 2024 09:47:27 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2ECD1DEFCD
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 09:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734428847; cv=none; b=c4VIeQfUovGQ2fFhVfOdGZUih1zpYbXJXIZD92qlW6k4JWsTYFcAkyuFp3HJjSLTDA++HK6i8OXjogwPQFTGBPBztWE45QkkcuTRDbwJQpa3zSmDIJfSO6ee0TmHPU/KtBYczUv+9MhzourcWrGNxJFnB/9BOEMW9WLd+6pzGOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734428847; c=relaxed/simple;
	bh=hOfImkAE2EFl4MZVd3hPvFr9MgN0yNbZ9A1uBeV3ZCc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=iTLnqwXtESUkjKUCgFwkYDsLoxqF8rQ8FP6He+eM/m7LDUKn/KlVgqMiB6J7dcHVGZX109M8tQ3FpWj0ikXDCOqfl5/yv4JH6g1EOdgMhM4g9EntT79jga3MwN5gFTVR6oHBHm8nJxBIicnnbV2HMobOaYtxLpC0PQDdIIcWuVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a7de3ab182so107420425ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 01:47:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734428845; x=1735033645;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3C6dwQcR8DXbDgPWAbTVRGbBXyNlVbX5Pvzym/aa2YE=;
        b=SNVqiCrwMuDeOOm2N+R97qswfJ/pGIOQjZED0W2y6zqIuR7RYXbV6hQopRq8IbqSyI
         sEtEtP6lJemorCzq5Yb+75TV63Pc/BpscQ9RF9/kJSeBvmh31QxynpkyXJ9Rn2jeGo+1
         U0a46fk9pvXT+NOn+WQqRIH/jvscOjTaQCvdid07+ON82X9vmocdhsVqSuMD9BLOPy6a
         ELFUJEdyHj3/ZMOkEot+ZNiIFY6JzNxNy7qqxO2JGnSMkJelM2cGktyR8UpJ71zB4eHX
         5n86+wWAVmvoY083qq1NmkkChSE5mkUiYymzWWWHZAj6d9pRgOJc1fu5xsE45ZpGJTxg
         IDgw==
X-Forwarded-Encrypted: i=1; AJvYcCUqy3nXT2XbGgHXJmfcMvmIf3ZqH2CnMF9QsGn8DJEo5iHyXxACJZgzd1xWArdJx2hkVoZ8Yb3NzGDFhBo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoCmv7lyvaUmQf3T4yyta6z+6932Kmhcow0HsK+SKc5Zh8rIUG
	K4nKCBvzB/AWVlih0Zr539Pcdvzz/kiXcaooN4r/8msg/XaGXFSYB5bXrHQB/ziDrnI/J/5oy48
	jyLzHFSUOfbcw2L3MNvXXG+MEkOdvs+el537YurZIBo+dznYHahoCfXE=
X-Google-Smtp-Source: AGHT+IE8yAkcoeaC0xqa7bhpt81THy6gblPyPnO88aZxjOf6qA0M1VWR9FZmjX1BW26CBU8qXtxIeYFhA3eDqqC8eZ4CRYZ+IyBi
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:174e:b0:3a7:66e0:a98a with SMTP id
 e9e14a558f8ab-3aff6020017mr139728465ab.9.1734428844941; Tue, 17 Dec 2024
 01:47:24 -0800 (PST)
Date: Tue, 17 Dec 2024 01:47:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <676148ac.050a0220.37aaf.0156.GAE@google.com>
Subject: [syzbot] Monthly serial report (Dec 2024)
From: syzbot <syzbot+list5c601fdf620a536bb95a@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello serial maintainers/developers,

This is a 31-day syzbot report for the serial subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/serial

During the period, 2 new issues were detected and 0 were fixed.
In total, 18 issues are still open and 44 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  651     Yes   KMSAN: uninit-value in n_tty_receive_buf_standard
                   https://syzkaller.appspot.com/bug?extid=559c7fe4b8bac56d38c2
<2>  257     No    INFO: task hung in console_callback (5)
                   https://syzkaller.appspot.com/bug?extid=1fb20cf68d15e7c2388d
<3>  167     Yes   INFO: task can't die in show_free_areas
                   https://syzkaller.appspot.com/bug?extid=8f41dccfb6c03cc36fd6
<4>  75      Yes   BUG: soft lockup in tx
                   https://syzkaller.appspot.com/bug?extid=5e87db90e68fbc4707c6
<5>  64      Yes   KASAN: slab-use-after-free Read in tty_write_room (2)
                   https://syzkaller.appspot.com/bug?extid=2a81fdd5c6ddffee3894
<6>  48      No    KMSAN: uninit-value in n_tty_receive_buf_closing (3)
                   https://syzkaller.appspot.com/bug?extid=dd514b5f0cf048aec256
<7>  17      Yes   INFO: rcu detected stall in console_callback
                   https://syzkaller.appspot.com/bug?extid=32af18ae7b894a681f2d
<8>  15      No    KMSAN: uninit-value in gsmld_receive_buf
                   https://syzkaller.appspot.com/bug?extid=2f64914d6a3a8ce91bdd
<9>  12      No    KMSAN: uninit-value in n_tty_lookahead_flow_ctrl (2)
                   https://syzkaller.appspot.com/bug?extid=290abdcd4f509377a0eb
<10> 11      No    general protection fault in n_tty_receive_buf_common (2)
                   https://syzkaller.appspot.com/bug?extid=2dda672e146ff12ccb02

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.


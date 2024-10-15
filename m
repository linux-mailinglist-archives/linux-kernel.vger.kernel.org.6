Return-Path: <linux-kernel+bounces-365363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C19299E130
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 10:33:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 079BF1F2303F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 08:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 145AB1D014E;
	Tue, 15 Oct 2024 08:33:30 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147691C57B1
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 08:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728981209; cv=none; b=a5COSYTK8kgY56ZGHHMWQ+0wk5SU2bkKTY8r9XlxvozWddJj4WT9inQ4IVefENsWxSuKFwJWVBO/waSv2EUJwYTe+5cchIdwpLtMNhi4KaqDYYuaxXk7oqf6GhrExSEGSGWZGEepcIulcOUfCUeaHgdzZWSs5OfJwPl+WnG5hOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728981209; c=relaxed/simple;
	bh=l0KnU1jEnOmVtqvVeeOzYzZ+gH3uccCWi6iDMciRvAw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=AaBZlzcoP11Bw8/8hUEBvqNTa1WK7SU9T3x2UyuqZpFrHcHdz463WmOzpXXw5ICbn8RYMgi63+gw78amDmV3ja85rSe5rX4vry32h93T6n/wsaQcY8AVlbrBg5HAjD7BuGkjtQHsQ2SARbmS3V7nmnlCzVJG97bSfKB3XLUGtDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a3ae3c2cacso44141885ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 01:33:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728981205; x=1729586005;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JG1+mKjuFX1R5St19IEjhFL/nfMVyVLuhi5QnUBNr2U=;
        b=snQLCA8msiDojRwiI3ECvGrqSNKNK8d4T2M5CJInxiInNXdeixnJw9y38p/nKCCoCZ
         dUsTMzseMr7S0VW7UkNmVYrLoBfmkH0QrNNcX4QFCoMWekwf67bO8q1mEQqFHpuqD+hP
         NiWZJpYOWWxZcqWscGxb9qSgArA+sKqQFbmMU10RkML+wquQ7KcCzEKS3Vx0K5Cgxvew
         vj/IHc1UHeMPpEMPW0avrH8vFedwMi4DM+c7bX1RLrcEck/juqB/Q+JiYr+mG4L1aOzO
         4ODoXkcS8tgj9JUnjLOelU6LkgZcdnAOjzSyIu1Q6NLmC5SH2nJvud0KSr3q1ZIwetz7
         BSrQ==
X-Forwarded-Encrypted: i=1; AJvYcCVCEumK6GzkSnp99dzf9OD8v9/1cUY/SwEBJoDdQJZW1amFDGRFTp2fnj2UHL1FBI8X+T/fhSXQhpa1XN8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzedegYJ5KZ9llAdXtzYYoKRKw0YozDzrnYUCBV98Y2A4li335Q
	Q4Y9N0+dFncEvaKdE3iEo0djZ7dlaqY5UR4LdD8n+IJ1txYnUZ0P8ExYk7eU3prYTkme8BLLbzL
	ZZkFFCm6LJ1SgykJnarLna6MFiDLM3BJb1x05z8YXh49kTdf/uwYRQow=
X-Google-Smtp-Source: AGHT+IEMyuaPYAGshOPlblIJqFJISjdqEEjpzojYE0wgROrTk5FGNj5JIoyMr/Oj7268qeO3d3r2lZh6bBYa9S14mGh5d4z4jkoG
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:13a7:b0:3a0:9159:1561 with SMTP id
 e9e14a558f8ab-3a3b5f233e1mr126389635ab.2.1728981205184; Tue, 15 Oct 2024
 01:33:25 -0700 (PDT)
Date: Tue, 15 Oct 2024 01:33:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <670e28d5.050a0220.f16b.0007.GAE@google.com>
Subject: [syzbot] Monthly serial report (Oct 2024)
From: syzbot <syzbot+list171ab5036cef2d0e0705@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello serial maintainers/developers,

This is a 31-day syzbot report for the serial subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/serial

During the period, 0 new issues were detected and 0 were fixed.
In total, 16 issues are still open and 42 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 494     Yes   KMSAN: uninit-value in n_tty_receive_buf_standard
                  https://syzkaller.appspot.com/bug?extid=559c7fe4b8bac56d38c2
<2> 156     Yes   KASAN: stack-out-of-bounds Read in sched_show_task
                  https://syzkaller.appspot.com/bug?extid=8d2757d62d403b2d9275
<3> 28      Yes   KASAN: slab-use-after-free Read in tty_write_room (2)
                  https://syzkaller.appspot.com/bug?extid=2a81fdd5c6ddffee3894
<4> 26      No    KMSAN: uninit-value in n_tty_receive_buf_closing (3)
                  https://syzkaller.appspot.com/bug?extid=dd514b5f0cf048aec256
<5> 10      Yes   INFO: rcu detected stall in console_callback
                  https://syzkaller.appspot.com/bug?extid=32af18ae7b894a681f2d
<6> 7       No    KMSAN: uninit-value in n_tty_lookahead_flow_ctrl (2)
                  https://syzkaller.appspot.com/bug?extid=290abdcd4f509377a0eb

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.


Return-Path: <linux-kernel+bounces-179157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2FAB8C5C7B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 22:49:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96C0F1F21C6A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 20:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A333718133E;
	Tue, 14 May 2024 20:49:36 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08FD1EA74
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 20:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715719776; cv=none; b=tJ9PH4w/SXGh8EdVIrP1Wjru84Wk4sDrNUtjKfamixs8ZVa5SzQNRELTWImur1CqnIMuUZowynCNkU2CkE0h8GWW/3Vesr4ctBH/FFAgRHYpN07nkMcyJKsQ+JvouuepAyF7RNdUIrcgwFAN+LPGIhV060bSSZ0WixmhCx2fi7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715719776; c=relaxed/simple;
	bh=IB69RAvqCOdOjg7nFJ4PG6OHmguovls0NLwI8SN34WY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=VuvDc2hSUcBM6jYKFg+Oj6UETxF/oZ2ZYaXXQg8LF7J83Y6dNs5A/CRivwZaH1up562V/RGbLhxvyd+awgNperLRi3E6KU3CyAunyjTGEkq7zcVJ8zHLjJgYhIh7vMHKjOR5O5GzHO1YG/qtLhMlZWZfvGDDi9DjFS6x+3VdZME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7e1d3928fd4so401689039f.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 13:49:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715719774; x=1716324574;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nVqW8S3ABFDk/zNJBkMLpZFKRsCOqY4qSaDAmMCsU4E=;
        b=VaBpH9v0jCD0ttiehb922xqKRKp8Mtm5ehDEw0MQ4a9Yx+lofIpHkPrS3EV9Nk8DdZ
         +sPLXKg9hqB6MEywRPmRUiZTTmidYITW9eYUxow8BPXYiewY3MS0Aq9yU7ymc+8ZWjG0
         Cz+heeh6S9hQmWGIkZ1MXpFNgwOuF1Zf3o1TZkie5nqQXYVStSF6KjUsAcU+rWviyycr
         sSlMtMCbYEm9OnQLuLwbO5N4BZpBMPeWqiMb5G9owGvWIVT3gqyIynXQSMGXckxDppD7
         jbj4oQTFBZeRdNKPl7tq/B832S273yh4g7SHoM3ThuAsujmjwTFCMfMb/hhn6A2uTLuO
         eSew==
X-Forwarded-Encrypted: i=1; AJvYcCWdFEnOT36J//44at4lQ464/B8wvyqi1q1aD4iXB0+wYRkK4OM+XGOH2sKCn1Ze50oR1iHG2kcGJ2h8RROJdlOvngYZCXrHjonYws9O
X-Gm-Message-State: AOJu0YyGD4HrOzL3s6u+T78dqZSmYNVLdT8lXCyd/yfd8h98xOo8x4ZS
	k9boeONlF0a3h29eqa+Kk8heyAwDImhiNQCedEtgPDxGkt3Jl4/ifYTz9+XmExRKgvVxTO72T7K
	Re2hxkw4PCBtkswCKQ0oCTui1SSt7Jvl7xbzT8+feCSxastLQwyq247U=
X-Google-Smtp-Source: AGHT+IHADF36HovZ4nEix/LNsmP7MIKXZTsQIoDpi9OF/S8o9O2BkcW3OdPN5ChDi98azQ4YeENsmszraj19HOLTwdeh6PAXoVX0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ad01:0:b0:36a:63dc:2009 with SMTP id
 e9e14a558f8ab-36cc1436c0fmr3440275ab.1.1715719774152; Tue, 14 May 2024
 13:49:34 -0700 (PDT)
Date: Tue, 14 May 2024 13:49:34 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ac3c84061870238f@google.com>
Subject: [syzbot] Monthly dccp report (May 2024)
From: syzbot <syzbot+list962db2fd5c4970f5379c@syzkaller.appspotmail.com>
To: dccp@vger.kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello dccp maintainers/developers,

This is a 31-day syzbot report for the dccp subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/dccp

During the period, 0 new issues were detected and 0 were fixed.
In total, 4 issues are still open and 7 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 102     Yes   KASAN: use-after-free Read in ccid2_hc_tx_packet_recv
                  https://syzkaller.appspot.com/bug?extid=554ccde221001ab5479a
<2> 57      Yes   BUG: "hc->tx_t_ipi == NUM" holds (exception!) at net/dccp/ccids/ccid3.c:LINE/ccid3_update_send_interval()
                  https://syzkaller.appspot.com/bug?extid=94641ba6c1d768b1e35e
<3> 17      Yes   BUG: stored value of X_recv is zero at net/dccp/ccids/ccid3.c:LINE/ccid3_first_li() (3)
                  https://syzkaller.appspot.com/bug?extid=2ad8ef335371014d4dc7

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.


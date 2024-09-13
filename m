Return-Path: <linux-kernel+bounces-327937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 923D2977CDA
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 12:04:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FE40B2984E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 10:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B6811D88B6;
	Fri, 13 Sep 2024 10:03:25 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3B31D86F2
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 10:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726221804; cv=none; b=NZwFPGjWxDHBPYoEatjYXKVP+thsFUK+YD6u2W5wu/Jzp1iT8rmgsO3R5upkn2/g8ta3yrtbM+b20JZ5H/Q5C6fpQcuU4lIthXuQgQRWqp+wybzqkXmjDeSsrSc+PP4vF+F8awLmZtbSaI7bGb4xxKJQtOD0d0nMMKfNUdB3W/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726221804; c=relaxed/simple;
	bh=FbUmRP2XHGZQhiOCWtw7JE6mpsESXDH4ur8n7VuSaiY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=M+PmRAGzGgHh3xNhcbxJ3arHDYN/07/T6yhnLLpduvsA9uiBrMQXqvKy1OylQIUsEC+8oR2zXcyz0yVkmFXPwIYV45E9h0IXq/5v7+iTGVIGO3shaHIWT6bulAc9zdPlM0N5EHpkZpLN2DcSb1yJj3F0uTsajhOo1cJNnHOn99U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a0629ed658so24082455ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 03:03:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726221802; x=1726826602;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EMSeyNmo4I5UKIr27ZSFVFOvJj/3uCTuGvzRA3OhzIM=;
        b=oSgym3at7KewA3soGfqz8tPSHMJ7dkCThlS2N2fm6A4quzZ/MrpOT4RlpyQ5gvgCpx
         2PolIZl2HhBLn+JX40F14VM2HcfaIsBMm4FMds7XDsMgNMFdP0M9QRRTo1A/n9EBSg/u
         v5oBJTN6oXTsyCocNWdseCcb/cAjOW8Wf4r6Sof4tchXMZvBGRmkHn/ih0zHIJfKpotT
         QlxgB1TjQyAAp0ea/3CvqvRMyBcws7ELkSYVpZkKrwNdnTMxkC9ncCP0iTsWas0aEXqi
         mY+LMduleANyA24AtcZ65rzXLPHIZYAAyLLUHTvbk1CeR7AjBu67P/n5EQFAiIrjj4L2
         T+9A==
X-Forwarded-Encrypted: i=1; AJvYcCXus9GDQO4cgwZzPmo61Q6HKjAc/I+/SqYSx3W0AsC/rtTgwr3l8wVUHJenwpJ2di1Nmkq/L4+cpKyZu2A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUeECHRMWKjMEbWBzKAXC2/f86+KwXfQQlb1NZMMgXoJP7NJ0D
	PquwgYlNSQZuGyZnT+Lxb/8Kg/pFxs1VWfD+D2EObtYWXlhKwNFn7gHB/IEcMdvsmRVKqo6IA8C
	jXEk9p7uNJ2uxn/G6zXvmDY8QDttvjTevfpxXF2jqThFD7u9cguscRh0=
X-Google-Smtp-Source: AGHT+IGUtAV7wYUEQOtWKgLLetpmFJnkMxMiloBQa0eQtht2JsrKsSBTlQgqXwlD1EtBNmyF24ElD7niM2jw2fYU953TyI4tkOdx
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d1a:b0:3a0:4bd1:c1ba with SMTP id
 e9e14a558f8ab-3a084924382mr47735975ab.16.1726221802575; Fri, 13 Sep 2024
 03:03:22 -0700 (PDT)
Date: Fri, 13 Sep 2024 03:03:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000058a7dd0621fd5528@google.com>
Subject: [syzbot] Monthly hams report (Sep 2024)
From: syzbot <syzbot+listd30be793d42f6338da3b@syzkaller.appspotmail.com>
To: linux-hams@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello hams maintainers/developers,

This is a 31-day syzbot report for the hams subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/hams

During the period, 0 new issues were detected and 0 were fixed.
In total, 6 issues are still open and 35 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 687     Yes   WARNING: refcount bug in ax25_release (3)
                  https://syzkaller.appspot.com/bug?extid=33841dc6aa3e1d86b78a
<2> 312     Yes   KMSAN: uninit-value in ax25cmp (3)
                  https://syzkaller.appspot.com/bug?extid=74161d266475935e9c5d
<3> 18      Yes   KMSAN: uninit-value in nr_route_frame
                  https://syzkaller.appspot.com/bug?extid=f770ce3566e60e5573ac

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.


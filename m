Return-Path: <linux-kernel+bounces-287809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB1FB952CD0
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 12:49:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A32EF2830F3
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 10:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 375601AC886;
	Thu, 15 Aug 2024 10:40:28 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6521AC885
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 10:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723718427; cv=none; b=kDMQior04ef8hUc/xP5vhlBY8hrhV8ot3dZSVFc3pi0gor+VWyvqQhDjHQ749ral46brmQzJDZacA2Lj9f+nzL3JjcgRo8W9Ft4xWLC0+P535G6A2/iu9Xv67udYHM3BfhyCcT8Gu/q0bZ7+io3y92A5WwlO9fu8kM2L7nQ4cUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723718427; c=relaxed/simple;
	bh=BCmmieNUI4lmEO0U6tUUzo6gPeh57OR7A4GuRgAbXMk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=DfkwfI6GeZDqxSPqpO960Odj3MDZjVC52KdllSm2CSPaTdtSB+TUjXe1wwRisB1kjRYxnmfe9bTJrO9PEZjqegXP/mTBtdMGUEBwBNUogas+1BmC0X4OXWlBEzcFIMVEC6tRsUBGtEO5oF8m0W/unLcgpgTA4v8Slw2dSB1Z4xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-824d69be8f7so85398239f.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 03:40:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723718425; x=1724323225;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7Yu9jYSVcnvbxIatxBmYFvoSLSb1OU99YNJNpjw3ik4=;
        b=Bi2KQdeEQThOZ26CUAGEYU5v6/pKvT+Kvvhn0rIeWTphhzNXiAUCaIVbJu6zrZvcxE
         z8n9n1JEjkuQpbpMXXdpgBzgv45sJujidnOJ8HE1FwKQP0Cd2XfmTEz2yBkHzFLeISfp
         A+yiTB1jdG/ke1rUm+YPxZ5Y2OHqsju0lv4ZLvFYdR4ddG2HrXBQesTMVm9QASZQlHLS
         HfOTDvZ+TCIrIWKq/y68C0k0e0oe9gObbs91+7nLKPUpwrnJjh69PjQCNgGOwlguSZbd
         fkL1ZkiZLYPSrehX/aGgnUKohwxUY0fUqkXydZipoSK9LTwRiDeqvXeoZqKIyUuSGpYE
         c9Lw==
X-Forwarded-Encrypted: i=1; AJvYcCWCwS8tBLWSU4fMZu4wrPemgC7ZBWrvVCJ4a9d2aHoqOX0HIwqFd1dBHqqii0SnfuCMbRvEVuIN87TSztonaJbqTxXCKTilnqOu9Hls
X-Gm-Message-State: AOJu0Ywro7TeTzOr7iTCcPzPnh3r4PTFTDG4hhSMOEGsxzoORiavxnyf
	aRwIrITQgskazPBIJxJUX0x5EdNLD6/S1fmGbnIeq/dL4zpP9i9s5oHbtnzlDXmeBEIA0HlqtWU
	tGjYqzOnYYNEUYQgI0SE/6yKEgGxqz16rI+3FavpuCq3Gd4vKH7QVFlA=
X-Google-Smtp-Source: AGHT+IH3nDNZkdMLYskbOXMf/HRcQdTHbUXHqKTI0sYkHX84dShX8bUE0h8qfkQlgTbsvnTWT+x/goGGP9OIYUhv2rhQvB5QFE1Y
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:22c3:b0:4bd:4861:d7f8 with SMTP id
 8926c6da1cb9f-4cab0a036efmr244210173.4.1723718425345; Thu, 15 Aug 2024
 03:40:25 -0700 (PDT)
Date: Thu, 15 Aug 2024 03:40:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006f9129061fb67866@google.com>
Subject: [syzbot] Monthly dccp report (Aug 2024)
From: syzbot <syzbot+listd5bb09218cb571c8dc9d@syzkaller.appspotmail.com>
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
<1> 106     Yes   KASAN: use-after-free Read in ccid2_hc_tx_packet_recv
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


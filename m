Return-Path: <linux-kernel+bounces-196368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E5AB8D5AC0
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 08:49:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6CC91F24D37
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 06:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C25B58063B;
	Fri, 31 May 2024 06:49:26 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00DFC80046
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 06:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717138166; cv=none; b=rPh46TVP4GATRxUA0w72ry/6XAFDkf5OZJSdoV5rmpyHORVUmhyK5yITNsUfL1nn7p6V4MtGfH81R/A5weTbnrgIPd71LrQ4pZpOy7+5H6Eqryh/bVC5tzdVCXcH0Xd9tf9O66mnUfwW1CHy8fRzQJXlawOa/h3fq4djuWJ1BPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717138166; c=relaxed/simple;
	bh=ucyZLx+dcNq0MD+BYcpKr9gJLBioFK6aiyD8XmcK6Ww=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=M/FtjyRyoyWJbcLxJSIsLYygWOcCXxyzm5jMJ5QKlc3zpF0t5glInPVKatv8jDV4u2eCnsLudJylUDsAS9HG3Oqv5rBn3IyzBpPk86pn39Du+asBfCFRd6J/fFWAegbaBNl6Pd41KF21FViHUak32ucVbVfKUFPwNn8qW6BdCEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7e212ee8008so227082139f.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 23:49:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717138164; x=1717742964;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OETLcamVayupj2CJ4Ypv0K6iuhlLpiVCriYowgbiKOc=;
        b=NyYAI+cP5e1UfPT7W7oR6DVXhCjj8KMl414MlFT/CSUFpcKR5r430wniR7ru0ROaFQ
         StxtfW7F4dfOYRIDBvEr8MEq/gBceRLOR1xsIF0oq7QRV1+xFDC7ZA3z1rGubyv2FCYY
         59SIMLaKM1SGPMRpPRpFH/l/OwjIWQ+thZIalLHqfr62yrkonZzEu/pW5Gbdm7MaA9rf
         hR5vaBowkMX/eOLhaEtdL/TIxgwnN/6sn7/gBUTKlrUC0rP2EGU5+6N01MkhcMxc+i0C
         ZVJL3Q870G/AShVu9VkFZZbe63XwiAeaBv5zdih5enstbqjHcRSHjF6otWqtb6JBKJp5
         LGaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVaV+psdwyFZTt85+u9Lr9xXswr7FePhYTxPV6jf7SqWrrt3pxTnBVMa1RiPth5UPtFGgK49STTkpyYQkoR1+P0TMlMD2gH9/vj518R
X-Gm-Message-State: AOJu0Yx38RqQNaOsHJjdB+8VynOgUH8o6O9iluvE9KYyFyWF+glygq8J
	ItikCirhM6nkeeq7nl5sqO2MTsia1TU3IwFypCpXT5L9+MCqza0zrMEcPN3IQaxQYtd5+lBe8LK
	WS2sKi4tGQEpqTAT5VbuTcxHNZABa5uuy3+qS5oulywDSZi9Brr2PyMY=
X-Google-Smtp-Source: AGHT+IEYiNSxdSbf/7LPOSaesM1l7rlTPMv+/6I8aRQOs7jfWM3gvWJMowUWQcM8g3NvHJea+pRLclKI0wRie4kcyRBwohXGDzk5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a02:9682:0:b0:488:cdbc:72c0 with SMTP id
 8926c6da1cb9f-4b541b78f90mr6972173.2.1717138164295; Thu, 30 May 2024 23:49:24
 -0700 (PDT)
Date: Thu, 30 May 2024 23:49:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000050378a0619ba62e3@google.com>
Subject: [syzbot] Monthly can report (May 2024)
From: syzbot <syzbot+liste4e0cd5f42b83d613fc3@syzkaller.appspotmail.com>
To: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
	mkl@pengutronix.de, netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello can maintainers/developers,

This is a 31-day syzbot report for the can subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/can

During the period, 1 new issues were detected and 0 were fixed.
In total, 6 issues are still open and 50 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 527     Yes   KMSAN: uninit-value in bpf_prog_run_generic_xdp
                  https://syzkaller.appspot.com/bug?extid=0e6ddb1ef80986bdfe64
<2> 99      Yes   KMSAN: kernel-infoleak in raw_recvmsg
                  https://syzkaller.appspot.com/bug?extid=5681e40d297b30f5b513
<3> 5       No    WARNING in j1939_xtp_rx_rts (2)
                  https://syzkaller.appspot.com/bug?extid=ce5405b9159db688fa37

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.


Return-Path: <linux-kernel+bounces-350157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0011990096
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 12:11:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 862781C23BF8
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 10:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B84514AD32;
	Fri,  4 Oct 2024 10:11:27 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B81E14A095
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 10:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728036686; cv=none; b=SFJ6FWicTnUEAeHB+v+XM0CRVLwskFYKMsRR0KaaXK9C9mXN7oAG1015Diu/wpZDDIS1rrwq9Ykzya2B3dkIW1wNu1LS55a9vWpC0th1m6E5RLJ+3IkxRtGVaniioOq1APsaP7nys9HM5WT/PbOXu7EDO4vNZ2H9v7TN6K8XNiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728036686; c=relaxed/simple;
	bh=x2O7TS00RicfPt6G+WI0X138zcI334CP9Dx2o5AECSg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=aIyBa7N2VtfTUZ5PYYgeEHjE0YuN90p+4okWD/qTUGVfJk/diXfuoJhxM8fWH5XKpy5RaDhP+/77pL4S/6dylLqIOQIpp+RmP0nI5GBdUOCIzB7aD97GmB65ZS/S+fWSv4dF8uYz+siNUdr44O/2xceOv/OwPUkmCWhb4XDL+JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a0ce3a623eso17126765ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2024 03:11:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728036684; x=1728641484;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vgrEqgbT4gTBIvHYHiHmpH8MQDGJqj6FO+l00kf1JG4=;
        b=UGOcpgJofc8FsQO3GPdBfy0kLPIcOVgSxFKJ43FJ4TobT1+pwA9LJ5lOyEay+oKZk2
         GTOlHDFvMaxtMKQa000ACT+i8guMjQEDvUOOOeDRrP6XwhxlwpfpAizrigkTFR4bdQDJ
         sXCZ2cd7VKZtA9K/TFprPxDyIteTCHKQ+iZpa14NXUXB97YKYwMAavdasJ12kSFLK/91
         oTc+6f0WMd6pzNl8AC9b0H0T02ZYvcoPiaNRcgMX1iZnyY+TVqTE3P+MbYRdxVa7LE5G
         firIr8kiMiUxS33PSHETWJJ5NeOGuDX7y+2TQNM5MYWaye0vsTgbvN+rvs2gPELcWvOk
         ZzoQ==
X-Forwarded-Encrypted: i=1; AJvYcCVh7xiVikkeboBZuk3DlPlNRfOXodTCaUMhfHSetbkiQGLNeUGSjG1Y3a7yRaNFcpyKraP4W2EF/QXVQbs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxC76tgKwPLDazZkG9lENHf5NVZAt7x59iHiMuOoRfEhLTjSPmy
	kK4zX6yNyhn6xxOYdyHXyAZTK8VCFuYbInvlptwz84lOPeER8+HCJFnN84VN5c5twGaUTsyXEaX
	fTAspo6EbEUXefCYFUP4XKek2fWI75QKcqD+PuhI4GCvwhu+6xQLzyN0=
X-Google-Smtp-Source: AGHT+IEgF5qLKJShXi+y0+519ebwQbROqt63ZqpT+BMHXJSu3IlAa1Ve+1roHFw52YWzrTjljzxhlo4344nJtZBgasj5o0CIA5MH
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c8b:b0:3a0:8d2f:2914 with SMTP id
 e9e14a558f8ab-3a375bd4f33mr21615385ab.23.1728036684412; Fri, 04 Oct 2024
 03:11:24 -0700 (PDT)
Date: Fri, 04 Oct 2024 03:11:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66ffbf4c.050a0220.49194.0485.GAE@google.com>
Subject: [syzbot] Monthly can report (Oct 2024)
From: syzbot <syzbot+list142a88e98c5a6a6358e7@syzkaller.appspotmail.com>
To: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
	mkl@pengutronix.de, netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello can maintainers/developers,

This is a 31-day syzbot report for the can subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/can

During the period, 1 new issues were detected and 1 were fixed.
In total, 5 issues are still open and 53 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 4408    Yes   WARNING: refcount bug in j1939_session_put
                  https://syzkaller.appspot.com/bug?extid=ad601904231505ad6617
<2> 2347    Yes   WARNING: refcount bug in j1939_xtp_rx_cts
                  https://syzkaller.appspot.com/bug?extid=5a1281566cc25c9881e0
<3> 2184    Yes   WARNING: refcount bug in sk_skb_reason_drop
                  https://syzkaller.appspot.com/bug?extid=d4e8dc385d9258220c31

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.


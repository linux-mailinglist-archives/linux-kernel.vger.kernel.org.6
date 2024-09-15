Return-Path: <linux-kernel+bounces-329898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 553EE97973E
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 16:39:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 053FD1F21981
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 14:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDD9C1C7B65;
	Sun, 15 Sep 2024 14:39:24 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E1E1EB35
	for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 14:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726411164; cv=none; b=u1UMQvojaG2oXAX8nQJjCy+fzZRJcTBkDQsAMxGx4uEpOYxWYSd/WnyOc8jpZiHXxZw9ZmcqSqM7f36QRYYzOYN+GpJ0Cjh9APaj23FXR+YiLPq3aOGxB36X11VQuYunzTmHReMYStBH11LtTV1Pxva43/wuVlMJj+4almtgkg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726411164; c=relaxed/simple;
	bh=sP4jgrmmfEBdugsBMtTm54HDqgh+RebnBva5M7bLO8k=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=PmmqAYncISh8QhfUEiSJf0pDoflG+wx1H9Aa0yaz+KlaYhjNo+bcpeE9oIViquKqa68+uCkbWGqpSq9fS1Fqg6UdafLD2l8ehmGuUThG8kNfKI768Rz1ygDkwYo24GOgnW7vX+tLVDTiDwtkwKhwfUCfe900uCUqK8KQO3jacd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a04c2472f6so63255585ab.0
        for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 07:39:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726411162; x=1727015962;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pRoQrrO88SaCzlahLfAtzhw8yyIVL+w80a86nD+hlh4=;
        b=Aww/gKLrGGDo5UiWxIVHxVfznCYgO1uyfXJWhlRdnAGhZzcya11OaLc7AmJYI1fBUE
         IHB9gwu33px3ETuO0Dy48b8qWoD5kkq5+AKjvkQXQLUQ/YPOuoaEX6f0ueueFPOSCZiQ
         jG3HL/Yt4K4VO+dIRGR7eszoQl7pj5ueh+VBCZc6Kq6yTCpX+gdiDooPTNCzSurp5l8D
         rFED7T00TLHebItR7JvXPt0K8O4T5WtoWQwP1y5IaJNT1qgu3JuhxRqG/oDfbbRtCpse
         2RCxe8A0UiVCyo3xR2aF+ch/uc8y9kU2L+Uy8M2z2WhFE67bPx20jy+qv64LAI+byIpH
         UxWA==
X-Forwarded-Encrypted: i=1; AJvYcCXUjTlf+frOdfQoY9f6bLzZi68VVbR/+5Ytg7v6J/jLMsn/ajmegXqcbz4Yrt3RL+TnLXamYpNIIfC5QX4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjnpgQv1+edetksJG7WpBvH1pTKklIaGrlEreLwy0120C+Z+rA
	wS4l+4SheqADJU+sWHjREBwpJ3QUCEuMdi09p4zfannrZzGz/R8bmIZY/QqwF5Y/8Ivzhculv6C
	h8qf73nCqqlKerzsxmuHZFpQrO46NP/gzB11U4nBAjdgssVMOCtgydVE=
X-Google-Smtp-Source: AGHT+IGmQKXv+bq140njVGpBEWOL2SN219VKri4+PIWgXDGb33Z1C7b6Xke3DzLHhzJod9BEerJISpoK8t5gpvnkw8OmJ2ay6r5n
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1543:b0:3a0:4a91:224f with SMTP id
 e9e14a558f8ab-3a08b6f87edmr83293015ab.1.1726411162152; Sun, 15 Sep 2024
 07:39:22 -0700 (PDT)
Date: Sun, 15 Sep 2024 07:39:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000e9a0e0622296c4c@google.com>
Subject: [syzbot] Monthly dccp report (Sep 2024)
From: syzbot <syzbot+list8e7646c17f00ffb612e5@syzkaller.appspotmail.com>
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
<1> 107     Yes   KASAN: use-after-free Read in ccid2_hc_tx_packet_recv
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


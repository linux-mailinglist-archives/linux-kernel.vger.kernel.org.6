Return-Path: <linux-kernel+bounces-208164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA3229021C2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 14:41:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42275282C8C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 12:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EF8880C16;
	Mon, 10 Jun 2024 12:41:34 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7B88005B
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 12:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718023294; cv=none; b=KKWk5fSc6UZ3Wf+fC044hlFCYHiR+F9Y+tQ7sHs5gdA0R9NNu/ZDLxqtoaaen4E43wjfPlaSjLPMByhbly24QtbkAdImk2V82nuFaNWR+94qBgxCF8wnGr1OpOXJMvYoHMcKAnRjoS039ZH0IsTwi55E/8hrhReASQX0St3iWNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718023294; c=relaxed/simple;
	bh=i5SCnc4e0NZWw/VPS0pUJHwWndBGQjsodMsy6pvjrQk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=QpvUZVqjBD2F0aulX4pKTo+pQUWdca+PtPG8MM8obRBKCqq5qEoQPNKywcM6XD1s0MH3Gg167TcpxjPfbL7zbUwJAK4ZBilUQx2b1BZbN7evlNoPIk3XkRxoUv7JlMLac3EjYjJICAosrWvmq8HnLlh7I7NCugLb3MgbwjrVqMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7eb50e42c6aso477107939f.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 05:41:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718023292; x=1718628092;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=64UVeaXcU6rsnutkNGl0Kz48RxK483/d1dkAYlFr9oo=;
        b=KY7RDCHCH54BOt47soBic3DmA5X/MdBPdSPKGdzIu9xKPrBu+P0kjCesZVBcSnIhl2
         rP9yTnxMPLQmqIDAYaN+Y12raF80hYoA0ZPh3Z20zpwdbkEOn8SKheI60xd/r9e5eWaw
         +K1kPevOmGEGcsfCPAhow/PmHa9fUcE8SQ5deUPtbWQMCB06hIbRiVDq6/v91RakDsSa
         oBRgOBiprrNOIVKCtBbb2fFggXZsoZkYA6uxIneqs3RiEHxhAXzfnnaABN0l/Qvk+FJn
         VSarZPEBC0epaNkwcVt9RYUnMKYjYfIU2LCmwAd03TYjXnI0Bf//opgR13rOMpfzdmVK
         zTIw==
X-Forwarded-Encrypted: i=1; AJvYcCUh7DO+L7ifL5okyGxUE342jZvIkSHhxATowGkU4GuAuDYWFIGvrXUidpqBVYcPPYvKQ3WFltMNLrsfbqcLBhOX1E+GYpQgLx8HHxNQ
X-Gm-Message-State: AOJu0YyAOy7tSjpEYyelt7tcQXEPvX/Gi0u1tpCxKLEQIoSz7kWHQx5r
	TPwx6JvDbN54g2FATDSfMmrU9KPQ2U/M9brWld5y6YuR2byO/+nYaZDgMVpoe7TynlY/CBmYIx6
	trxg3u3iwOsDOjR5RlmnYpx0CXBmdH/owHTHeJ7Naj3OnuZnZM+dPmLg=
X-Google-Smtp-Source: AGHT+IG+u4Iz7HCAOZu7wuHlIut3kfzPhMSERAfOihfD2YZeVQUKpeFV9CJ30GeUc+1nHZzBbvRPTCL3NxIVz23EGS9Pr4V18m/1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8919:b0:4b9:b15:5984 with SMTP id
 8926c6da1cb9f-4b90b155d3amr363281173.4.1718023291856; Mon, 10 Jun 2024
 05:41:31 -0700 (PDT)
Date: Mon, 10 Jun 2024 05:41:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000006f7e5061a887861@google.com>
Subject: [syzbot] Monthly serial report (Jun 2024)
From: syzbot <syzbot+list346a89a10f85c497d0e8@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello serial maintainers/developers,

This is a 31-day syzbot report for the serial subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/serial

During the period, 1 new issues were detected and 0 were fixed.
In total, 15 issues are still open and 42 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 213     Yes   KMSAN: uninit-value in n_tty_receive_buf_standard
                  https://syzkaller.appspot.com/bug?extid=559c7fe4b8bac56d38c2
<2> 91      Yes   INFO: task can't die in show_free_areas
                  https://syzkaller.appspot.com/bug?extid=8f41dccfb6c03cc36fd6
<3> 46      Yes   possible deadlock in uart_write (2)
                  https://syzkaller.appspot.com/bug?extid=57cc2f20a84cb4346354
<4> 5       No    WARNING in uart_write
                  https://syzkaller.appspot.com/bug?extid=a38f8e1908608d337bb3

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.


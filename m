Return-Path: <linux-kernel+bounces-553119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32B89A5841B
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 13:42:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02D653A9522
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 12:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FDBA1D63EF;
	Sun,  9 Mar 2025 12:42:31 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09FBE1D61B1
	for <linux-kernel@vger.kernel.org>; Sun,  9 Mar 2025 12:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741524151; cv=none; b=a3iP4dNIr7TwFKA9BQpnCpGwVJVgfP0eGo9IfcV9xGOwuVFzO9/OA2q5wHB125ClhxBxGXWNJbyR4oIPRxFhW3L5hNzx67BxDk0QNOfSFB6FuHrRipH8umWTE4B5I2kl/45ZBRlZVPzz2sLaO6bXbMWJqckV8SYQUEzyzghX5ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741524151; c=relaxed/simple;
	bh=dUY4igajBJSOU05hBpX0jx6ZIwrHBUSknInpJw8tohc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=BAPIR+iw1uIw/Szo2KuxEVzmEyxYosTeyMbw1uwQwK2ITEvDJ58zXD64SCqoivJ60JGIqn+pO1zRFV1wrQ4pPrlSP7MHam1IIA+HhbliQFqyS2c8hI5QqGVj2wrewlmVT2Eqn+WAuO5YrtM/+5C5mTlOWDbxHgwFvj9XUI3cB+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3d43c0dbe6aso65852975ab.1
        for <linux-kernel@vger.kernel.org>; Sun, 09 Mar 2025 05:42:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741524148; x=1742128948;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3ml1SgE3f0waN1sWwG+fhNgJQ1Ci3uDZVlghDuLRJ+U=;
        b=ItKtXplPjL6nJzKtD3zyOl+h4MAu85AFzmc17Yd2kYXLL2FRbvSilM04msBpcDOsNm
         asFI1seCUEgq3Ya0C1viPUfwv3KImyRNBK3Kwb4YLJl7cCuPT3GZLLSv/V0tYnIrWhaR
         390djZ+MACR8RfgHuyGgjnoQNVcw5XnTULgfpkyfymu7baM9Ccuw5NuPDeAitjxXEC/C
         V7F9Y+C63ZGyqK3Osw+eHfEgMd7InILq7l5n9MykMNj+jsh1QEskuDGd5LeJeNg853vG
         0JM/yi4gTk5NMiu1d9mmk3TcyoGNlN5+HUGM7i07FhCT9AYNWuooLJ1MAfrYVcLSrbE2
         xvLw==
X-Forwarded-Encrypted: i=1; AJvYcCVF4Y/6vQvf8ggPsRaDSug9e9TI+5iucLF1Cxsv3d2AzLUULdradoakGxPg89ifz6gYBoEy8xYVmUTgzHM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBRpaECsv8/yD35HxDojGjUf9KEDPx+oAxM60gm5jKbM8lwsH1
	N+MIPERDM0KYxaiHQeVF/By5SWLDbVl4gBpzj/7p19C5CakBHU1XYK3AsxOYnSSnPzAKuySM7Ln
	IDWUsoUYX6t7Tnh84Rq05qZq2z+fzLzWnyUkPaQjnTYjnTC8nrAoVP3k=
X-Google-Smtp-Source: AGHT+IGVFQ7a/Dj9bgaUAxoa893oGc/eseebP95wIMl/jYGyHV4ZZpxmjoRrBWrZF1nQdcnhJTNgx43SQE7abc/0g09SDXfWmTgo
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:174b:b0:3a7:88f2:cfa9 with SMTP id
 e9e14a558f8ab-3d44195a90fmr109227625ab.11.1741524148133; Sun, 09 Mar 2025
 05:42:28 -0700 (PDT)
Date: Sun, 09 Mar 2025 05:42:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67cd8cb4.050a0220.2eb24d.0002.GAE@google.com>
Subject: [syzbot] Monthly fbdev report (Mar 2025)
From: syzbot <syzbot+listd9518ecf1c4edbd09558@syzkaller.appspotmail.com>
To: deller@gmx.de, dri-devel@lists.freedesktop.org, 
	linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello fbdev maintainers/developers,

This is a 31-day syzbot report for the fbdev subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/fbdev

During the period, 1 new issues were detected and 0 were fixed.
In total, 7 issues are still open and 25 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 844     Yes   KASAN: vmalloc-out-of-bounds Write in imageblit (4)
                  https://syzkaller.appspot.com/bug?extid=c4b7aa0513823e2ea880
<2> 15      Yes   KASAN: global-out-of-bounds Read in bit_putcs (3)
                  https://syzkaller.appspot.com/bug?extid=793cf822d213be1a74f2
<3> 8       No    BUG: unable to handle kernel paging request in bitfill_aligned (4)
                  https://syzkaller.appspot.com/bug?extid=66bde8e1e4161d4b2cca
<4> 7       Yes   KASAN: slab-out-of-bounds Read in fbcon_prepare_logo
                  https://syzkaller.appspot.com/bug?extid=0c815b25cdb3678e7083

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.


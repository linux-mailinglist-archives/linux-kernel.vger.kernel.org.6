Return-Path: <linux-kernel+bounces-320892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9966E9711B2
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 10:19:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5BC61C225EC
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 08:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7CA71BAEE1;
	Mon,  9 Sep 2024 08:12:32 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB201B3B3E
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 08:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725869543; cv=none; b=OX+FLoldOjSm5IEWkI+c0CC+3C64GDJr63h1e8z3iTvMf9sm6xVhR4o6Ka8SrwNG19MY1zo6OzE7uCcEhRPCXwSuBRonN9PKuhAjmmsjfgVcHLQvZ7O3rvzlHHDStAWXgcW2VtDO3cmvB9RXp801nh694VZfVIbth+vQKRBikdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725869543; c=relaxed/simple;
	bh=hjeUtwsYFEvjuUdrzk+UuFsYL71dFyBuWRrsIgDZvhc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=lvaCNM6EZAG0KEv+n2Y9WwkPq4TGSlwU5V7zJP57X19JJgqIghfpJ6qvSuccpXKMgBySFZf0DPvAUboWekQbfsKPhmpc1RybDxS4F5WWzxm2xFlKYLvyOAV+CYlUCh6HneY95YjuW15c1QieUvJFtK87exyGObmIaboiBISvtBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-82cf147a566so37820339f.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 01:12:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725869541; x=1726474341;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XkAroIDoNJ0WenPL25dlGLCcH+w/aZaw1HL8G6mp5Vo=;
        b=YqhVGgPdzs74Rw63oNce9pwCPt9LxElzInR87ZwvR27nF0uB83Nw6XKAcw5+ve8eQ1
         lt9pm2MkStdYfqi/fJfbASzK7TRoWrdzmki5Rb+0j3URMJTbHA3M8Kig5vC87QvC3eoN
         2Wd+BpAVxNGYqjvEf+IE4NGJVvSZaWIg3Js3QYxpBzJP60YCzM9coyEpp5xpJnKTMHsp
         naDC5az6Z5IK6K1DbwxNiTkE7pxbYt8vFV31aQNWxsmF0SPv3JL7Qdix9ZyiphDXmOWZ
         sutvj3q1Hwci+gDhyCcJAjfPSIK6k8ICIw7HER4xrdyfRXcDMRIQYW2b6YAmJP28gy8f
         kD0A==
X-Gm-Message-State: AOJu0YyEQ8wezgzEyYhoZ6vKiBoJqTIt7a3UXfuwOr+E/077Sb/E47Sg
	um4NZnOwrb0+uwXqWlpN8lCCzd2hAyXjz0OGmkdHVRXSObRwJU/+KkSItbA0zy+xEm4ggwff/G6
	EITASzI8SLPsgRDhGOWa9OVvEDnx6FiRGFKKqj9S+qzFdKwjVyRESqQE=
X-Google-Smtp-Source: AGHT+IEEE7IO5eOfZo+sN3JF4WWVHKjRAp4zdPgHI0mxq2qIOzEXSIcN6aL3faP2JN5FMlrx9qmfCsZwqez/vIcyghDWYyE1kkhC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a6b:f602:0:b0:82a:4419:6156 with SMTP id
 ca18e2360f4ac-82aa4609c5emr737751039f.14.1725869540675; Mon, 09 Sep 2024
 01:12:20 -0700 (PDT)
Date: Mon, 09 Sep 2024 01:12:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e69f460621ab50f4@google.com>
Subject: [syzbot] Monthly trace report (Sep 2024)
From: syzbot <syzbot+list692d096cfc0c03673c30@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	mhiramat@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello trace maintainers/developers,

This is a 31-day syzbot report for the trace subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/trace

During the period, 1 new issues were detected and 0 were fixed.
In total, 8 issues are still open and 37 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 2278    Yes   possible deadlock in console_flush_all (3)
                  https://syzkaller.appspot.com/bug?extid=18cfb7f63482af8641df
<2> 1023    Yes   WARNING in format_decode (3)
                  https://syzkaller.appspot.com/bug?extid=e2c932aec5c8a6e1d31c
<3> 31      Yes   INFO: task hung in blk_trace_ioctl (4)
                  https://syzkaller.appspot.com/bug?extid=ed812ed461471ab17a0c
<4> 15      Yes   WARNING in bpf_get_stack_raw_tp
                  https://syzkaller.appspot.com/bug?extid=ce35de20ed6652f60652
<5> 11      Yes   WARNING in get_probe_ref
                  https://syzkaller.appspot.com/bug?extid=8672dcb9d10011c0a160

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.


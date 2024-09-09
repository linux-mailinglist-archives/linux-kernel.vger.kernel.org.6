Return-Path: <linux-kernel+bounces-320891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 792499711AF
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 10:19:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24CC71F22F7A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 08:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8ACD1BAED0;
	Mon,  9 Sep 2024 08:12:32 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5682D1B3B2E
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 08:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725869543; cv=none; b=XuQ3P3iCAPk8l93lUo+a3ysEStRHvg7wZt8M4kO4jSNasVDMqOx5BC0CMgnAiTt8Dt96E4zQB/RMT2iUhayomvXt8QWyo4rB8PedFXTOzbWRzbz20vkXgjIaEMcvnSq9YSDUmzj4yW+U3V3qcNSXC9vDkiEZ3fVlUC6bEXZommc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725869543; c=relaxed/simple;
	bh=lORbYzb1VyFJ8eNEKYUcfTx4ur5RDIvHaegbykC00Ec=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=i8W6sVlS+HUeBmgCWubsa11wxayiy+jDKNzoHAmgrVqf8+fQ9mZEgk8LbHsrqs9IUr4w0SBXtL7cBAkxyYpiXhyL4E70cgTRa6xP/GtaLhmO+RgmgnVrIBriwB4s6gmmM6trE7DAyEQyl7ADbEbpkKqadj/SZMKiV7hWlPx0q20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-82cdd759b8cso101822339f.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 01:12:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725869540; x=1726474340;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aBzsADE7wAvv4qzDRBCiIM7IGXakk3xrHFWAIbvePzw=;
        b=FxE0uQDUJw4RhR7cgnxG9vJvJ2pnUw7eIeXlYulqYIqavjLMKNo2TK3r8B5p0wUm0N
         WYFnTqruPcMQ9Mnt6kPhrVBf7eqrOxEK0gT92cMqXZhxaL+gOx3yCnVIyGB1m971x0uY
         6o1Zt0XrWVDcWdqnfrVhSvxOXN4g7qtkhGItiJmUOLRhshupwmIMR/Q4YwuKsLPnc2ai
         rqkdHUYQyepuzoi2Jpuhr4wpxdC2PvgPFl9L3gnJXWZbtaO2l3yLlocd7eiJlgBwJida
         m79iwZycj3YtFhmV8ZqIJJQkYv6cXd5xZ8NkB3ySwUmubguHk6Tj16VTDzeoaCGDmjXm
         tLnQ==
X-Forwarded-Encrypted: i=1; AJvYcCWm2ikfxuLSdH3GEmx7ra1qR5NeNO36wmO6nb9yliH5B1Me6j8I9AIcoH9KFh5MEGc3IvuW+7hXpegybOM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdZufUnChPmRJnSo7B/ZZJxl2VIrRgnhnRnAkxy/bIek1mqZ8e
	YzIfQkMPFXcAf5z3tujEwICRYQv76i/mLBZHUeNpBC47ui62UCxxPnke00XQWmaXS2BLje0p2BQ
	JMI51G6N8wMWbw8fAM0QrPQvgftMBcSzH5FLXOZi0VVswOkXaZxWxj3o=
X-Google-Smtp-Source: AGHT+IG8h5ubNHwxbEBVcvU+kMJDZzC/Me9UJrQzG1Fml/eTOkhW5WJxULANLFMhpVq6B9znhkKM/rOcQGK+B6oA0MvMLaKLQYI/
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:27c5:b0:7f6:8489:2679 with SMTP id
 ca18e2360f4ac-82a955c2fadmr971788739f.8.1725869540413; Mon, 09 Sep 2024
 01:12:20 -0700 (PDT)
Date: Mon, 09 Sep 2024 01:12:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e2a5680621ab50ac@google.com>
Subject: [syzbot] Monthly jffs2 report (Sep 2024)
From: syzbot <syzbot+list2fe8d8294fea7add3c1f@syzkaller.appspotmail.com>
To: dwmw2@infradead.org, linux-kernel@vger.kernel.org, 
	linux-mtd@lists.infradead.org, richard@nod.at, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello jffs2 maintainers/developers,

This is a 31-day syzbot report for the jffs2 subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/jffs2

During the period, 0 new issues were detected and 0 were fixed.
In total, 3 issues are still open and 1 has been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 730     Yes   kernel BUG in jffs2_del_ino_cache
                  https://syzkaller.appspot.com/bug?extid=44664704c1494ad5f7a0
<2> 13      Yes   KASAN: slab-use-after-free Read in jffs2_garbage_collect_pass
                  https://syzkaller.appspot.com/bug?extid=e84662c5f30b8c401437
<3> 3       Yes   kernel BUG in jffs2_start_garbage_collect_thread
                  https://syzkaller.appspot.com/bug?extid=61a9d95630970eece39d

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.


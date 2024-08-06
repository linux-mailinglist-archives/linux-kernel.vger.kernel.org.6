Return-Path: <linux-kernel+bounces-276152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FCD0948F1E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 14:39:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D16F31C23779
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 12:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C7691C4616;
	Tue,  6 Aug 2024 12:39:31 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6501BE240
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 12:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722947970; cv=none; b=gQKNcQXkv/0MOiFScjlLa3BxNmoX8x923/V6FwHx32kBpalqPpmpDYhtem9A2FE5o3kTMnp09+jGq5AsRQxEsW0nlZWRmjMRZX0BMY4vNNYvQpz1lOL3Kf2wLMWXYSyUrqP+MqdPWSdA1zZ4qAaT48L0/5Ppsl5RAPDdlA6/Kq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722947970; c=relaxed/simple;
	bh=1ZlfVR7vQURDb9BeWjxEDmJ8l6FtdZ58kNs4ybI0ucQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=sS9ECtW+n/gGs3AoyX/wKbNp+oRbpurhdVYukC4GKe76Rx2F87dynu5NGJP8NFhXhSRM7tYvY+ws4+O6c1sTRGhpwvnJqjPK4E1ltFobz+85L1BXR6pntM+IKu12scDBh+KeTW4UClPVz3b+7SR7M9nUDOYWWP4S7uchS3otfbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-81fa12a11b7so89577739f.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 05:39:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722947968; x=1723552768;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xIsK4Zhm8DeNTVyySFlh0qMMYw6ijS/N/XatwMsGdQE=;
        b=dhje7YSLIGbPtU9IsLC/gEL7Ecf42OfaAsfZhiZd01VF9bodkLyUUYhqK8xX83RedQ
         jg4JHgDUSehEsbYmnrElCyWuMH7Qk9WIzcKUo/ciOof4qUft7T2IpwfxZHXhnExso1pX
         9LR8s4J3Hl95StZRIJfk65oiAgkoNnzzLKm6ovpm7tjGTI/YbAoxzUZ0H/HOCuPe4A+q
         UCvwIE2I7e6J9O+Ix1HQUwSyxHS1d9P9eyPzuUjNqrLDUPjWd3oHLjEW17vX4b5qZzGN
         KBdzfxabYJ6qNASzvuSsgvNYrMsSNVU7Oah5HQKTeBGwyBmel92Ed5zXqhj/Vb8Zg0eN
         jWxQ==
X-Forwarded-Encrypted: i=1; AJvYcCXzro1yz1Kz0PpAYJbFOt60DCBhHH9PknIiZ7cBTj/ROv3heIrOdkBefvaDfb9nNCaGJJ/DZjs1qcDndfHvN4FEb4eEd02VaSGKLB7J
X-Gm-Message-State: AOJu0YwnhqaQ5SFoIA002DrEb8l7dCgxkIOb/u2izKUzLuSN385ClAdu
	PubYNljE1kDO4994hKcuPVtUBb8R851q725FguzQypOLETHCyrIjZL64L1dhDme1gqDy2jHrbo5
	NTez1VGfC2oKpgqWK4FHuwQgSzdd3i+wI9lp2DAan8oXHZjOAl6YhM+c=
X-Google-Smtp-Source: AGHT+IGFR/jSOji8KiIQk8A8GUKQozz6fTjGvhbdsdH+fAhCdZu6unNrrCGgXIDP/yPM76dGkcwgEOja1BoxJyAl4wQXa6SydWMd
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c561:0:b0:381:c14:70cf with SMTP id
 e9e14a558f8ab-39b1fb6bed1mr13341315ab.1.1722947968517; Tue, 06 Aug 2024
 05:39:28 -0700 (PDT)
Date: Tue, 06 Aug 2024 05:39:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a15b4e061f031536@google.com>
Subject: [syzbot] Monthly jffs2 report (Aug 2024)
From: syzbot <syzbot+list5279c8c444a08dc01075@syzkaller.appspotmail.com>
To: dwmw2@infradead.org, linux-kernel@vger.kernel.org, 
	linux-mtd@lists.infradead.org, richard@nod.at, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello jffs2 maintainers/developers,

This is a 31-day syzbot report for the jffs2 subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/jffs2

During the period, 0 new issues were detected and 0 were fixed.
In total, 4 issues are still open and 1 has been fixed so far.

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


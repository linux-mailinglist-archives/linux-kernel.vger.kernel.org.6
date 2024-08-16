Return-Path: <linux-kernel+bounces-289423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51321954611
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 11:47:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 071831F22B6C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 09:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AC9416F8EB;
	Fri, 16 Aug 2024 09:47:25 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F3B16C860
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 09:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723801644; cv=none; b=rRRYWb7tcbj8ZAiX47pKFBlp2QSYEoPQdX/f0RLw8k1ENQdWcPjFmwOZ6UtnXXr1xM9mVhVC0+D9quixAKJ5OAGr/NMuUr0R2uSlDwE7ePiJeouTez9R86LVLd2StCt7XjZ/T6oEGMdWutxqqaUE4SZ5dNfuvlRl2m1ELJjLi3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723801644; c=relaxed/simple;
	bh=TJ8oDlQdAJa+CBnEmZD/vFJCo8PGMOuTBJiVJ9Pg9SA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=cE8cJkMFnp8fNiCZ4yyWgb3tkqihbh95dqvOZdeBTn22eLC8yRK4L8A+De/YTJYfkaUFFF9PTyYDHNj4ejkQNOkaYYYxri/jQ5aQkP0SgzM/c7au9XUnCget6ob6nmqpI3kicfpaDKlalzyUQ589krcS+hnzwVHYEkVh8bAy02k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-821dabd4625so177137039f.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 02:47:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723801642; x=1724406442;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W5+QCnPGkuCl1oOssZ1AlEVYeyLwRhFVcj7kVJ+iQA4=;
        b=bXhmo71fEZLi7XR0tOVtMkcPYaQXNv6k6KVttOBQy3bhXPODQSPQCAcvwCNQ9jptq/
         cCjH6SpusMq72qUp9qfm760z1KVXcOiCMmmxcAYcJy6KlzWsB088VlA/tJ+z67mFvOHI
         TTrhWnLyf/SFon8oT2S8UOpdLKciEYwsqlHu+t+TZWMuyne1ojF8UgJjcPPUULo5IGqR
         ZD/RtG1mMbdTGVE0E9buqgZ4FDorLEYKSXEnr1Sg3p6zDX+m1rdM4+DCEMmxzZ60BYn9
         vyMB2xt/RIm7+lxDj9HSuaTyMggle0lGz/okNM3BJWjMeQkeEg9oQhqe70NnIiLH36YW
         4kRA==
X-Forwarded-Encrypted: i=1; AJvYcCVj4bINnialYfpgVgzcyK0ToUlwIn7GjfDn2laXUrOO/hs7kEtSCPU1+DpiVQjP76mj440SklxVK/PWT/w3+tUpXUmwR7but6h4V1uZ
X-Gm-Message-State: AOJu0YyYbV/yPIhJY5zFGbms5K6710/vizoEFYbDIrk7UeROpeo+ee1K
	7+vUKJgNIZQ6uGwGzCsrW1AbRHcHatRJW6yfyra+oChfaIB2M4xDTmNuNTdSawWXyf2lcG1YT8d
	NPEr/udjIQvniZ2aqiKL65cYwDgJhvgcGxr1x2f2qMZo0x1EjXU83G/8=
X-Google-Smtp-Source: AGHT+IG96NqYOk7+qwed/6IbRKmXdAf/k7WGw5ZIdTak5aekN16IGRmdKi99xaSXX69iHXNv+mEalpKDQ4yEZiDR4rtj5Z2WKaQk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2182:b0:4c2:7f96:6f4 with SMTP id
 8926c6da1cb9f-4cce16d0113mr90924173.4.1723801642373; Fri, 16 Aug 2024
 02:47:22 -0700 (PDT)
Date: Fri, 16 Aug 2024 02:47:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008ea4f0061fc9d81d@google.com>
Subject: [syzbot] Monthly udf report (Aug 2024)
From: syzbot <syzbot+list84b3706a4fe0878bd0bd@syzkaller.appspotmail.com>
To: jack@suse.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello udf maintainers/developers,

This is a 31-day syzbot report for the udf subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/udf

During the period, 0 new issues were detected and 0 were fixed.
In total, 6 issues are still open and 30 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 4284    Yes   WARNING in udf_truncate_extents
                  https://syzkaller.appspot.com/bug?extid=43fc5ba6dcb33e3261ca
<2> 2922    Yes   WARNING in drop_nlink (2)
                  https://syzkaller.appspot.com/bug?extid=651ca866e5e2b4b5095b
<3> 331     Yes   WARNING in __udf_add_aext (3)
                  https://syzkaller.appspot.com/bug?extid=799a0e744ac47f928024
<4> 29      Yes   WARNING in udf_setsize (2)
                  https://syzkaller.appspot.com/bug?extid=db6df8c0f578bc11e50e

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.


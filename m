Return-Path: <linux-kernel+bounces-376182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7766F9AA13B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 13:38:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4AA41C2224D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 11:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9551119C54F;
	Tue, 22 Oct 2024 11:38:35 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E1F19AD73
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 11:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729597115; cv=none; b=goOHiR1vG3YEaerPf722fxq2be3jlFneQu1+ARQTTpZQ2PwUnAWqORWB16d6r9KvCNYHi4lrxVWeQypTfFI4c0pl2BDglqDlvUDZMPTyg3zKOp/5ykvPzaDKiJgrfy+xVW9z8Rg0s4qKqHjV7BtU6zV+O2rhXT38cy3mJmBlPP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729597115; c=relaxed/simple;
	bh=aLBckF07mkjO60Kkz61QCu2+ek57S2l8PjSQYDAI5ao=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=tkRPyknzX2Kl13v/c7mjiuQeDQo+IaT7InGUm3gH75FjT7tcbPhEKo72UHMWGvSToBOW0ab6e3/F24JKBo2KyYi53SCX2LNGvw6gCaX/BETOgRvJujZSZXgc8tdfUPbTOzOg8SFx5cQ5fCoqFS6REDbfnHCRCFEj6L5QPmzEcYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a3b7129255so53502295ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 04:38:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729597113; x=1730201913;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ouSLg3Ywt/0X+H9vWv6sMqAnUnp/8br5o1Ob9ipfFN4=;
        b=jnUeeGr/VFUlH5Yn57r5jmIesiwNLgNKgQF2Rj2PoO07/knPfMOdZDFEKVS8LzQgxz
         cpB1p8vyOJtpLi5oC/jjeLMPWIKFOp1No1Wv3UMJZluXQ2j5Z4dZ1tt0zVR8qOYd3H4g
         YIayTArumxco8/mk09x2cfnmzIF8DA99WLxSXEakre9U0VIL8nVjW5DkmHU4/hF+cTd5
         vIC0mVNFZPXYbRClsJslBPkRcPTSIbmYt9cyPMPLIvqfYYYMFW1n8XSCQV0GzdskN6eJ
         hSyv4enutiss/MyCiaOIwJ398qQBqFrC/F9EXe8il4ZeGIxmZRw7aH8oqE7LEZ6WI8Fe
         /FSg==
X-Forwarded-Encrypted: i=1; AJvYcCVj3o3O9/maiPzU3gew6qycUwO6qwlOfvos3xBw9Ahn+86PKScmH7rBlMGyL/se47uDu2UaX0npOi95rpw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCiTdRv4LTBdLXglNxJXkJ9OZlSL0QnuLVN4OBgoiBX5moWMgp
	MQE5DYkwA+/G2ocPZ8nIvfm7sMkbW1qEMWof7XAs0Wi1JFUVEzhI2VsqIIU3P5gLGlvdfz5Q8/g
	9jJXBmNNGt30R3ImAqwE1bSywB7t4Zua2DVfrLNd4QgWE1qwB2jCG6+s=
X-Google-Smtp-Source: AGHT+IE3pkqG3W1GjwJfvFFXB+gff8e7Fh4t9+OSbjt329ZL6nPvFVEzDDUEErjXgMMmJaxUpGZAW97QKS6HSljIljBS85PjRzqc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c248:0:b0:3a3:f95f:2dd with SMTP id
 e9e14a558f8ab-3a3f95f0594mr89939355ab.19.1729597112998; Tue, 22 Oct 2024
 04:38:32 -0700 (PDT)
Date: Tue, 22 Oct 2024 04:38:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67178eb8.050a0220.10f4f4.011b.GAE@google.com>
Subject: [syzbot] Monthly cgroups report (Oct 2024)
From: syzbot <syzbot+list3160ce3179308d795218@syzkaller.appspotmail.com>
To: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello cgroups maintainers/developers,

This is a 31-day syzbot report for the cgroups subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/cgroups

During the period, 0 new issues were detected and 0 were fixed.
In total, 6 issues are still open and 38 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 2627    Yes   possible deadlock in console_flush_all (3)
                  https://syzkaller.appspot.com/bug?extid=18cfb7f63482af8641df
<2> 998     Yes   possible deadlock in task_rq_lock
                  https://syzkaller.appspot.com/bug?extid=ca14b36a46a8c541b509
<3> 35      Yes   possible deadlock in console_lock_spinning_enable (5)
                  https://syzkaller.appspot.com/bug?extid=622acb507894a48b2ce9

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.


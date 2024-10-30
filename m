Return-Path: <linux-kernel+bounces-388569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A6F49B6157
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 12:21:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 310091F222AC
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 11:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81D251E47D9;
	Wed, 30 Oct 2024 11:21:05 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180AD1E4908
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 11:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730287265; cv=none; b=e1hM3L816+KPYLr0ilWzHPflJTwkuWbegv4a/epZKSmf8LfIFDLsE0JVKf6iinU1CihYQIBD1fKltzCetQfn7jldZviVJ/ls7UT9+tz3WXm3/agMH28eggt5ojReTeXDdmVYm2PYpUqJ/jqKvosko0qwnOevv/qCfirjnsS1QUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730287265; c=relaxed/simple;
	bh=mqYd9M05WGYBVAVqpCleCMCXiGxhQhMBft/i2oNW82I=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=iie49NXbythGYVBsSn5ubH6pKguhnRH2p2+BHJCPEeBtjgkX8zA6LcIAX5rew1Lw3vI3t1B5n5kIEqdP8YVZh6WSJMvxNo8NI5mhOplfx9WSIf9u+fU6XsDb0iVkV+1F3ZFGmt5912C9ms6PT+f5dp/oegdWRVboVISdkw531Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a3c27c72d5so59435035ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 04:21:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730287262; x=1730892062;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0BYoxibK342+E9B+CcWmXJzU3QAOmgISMB1A3wZhUE0=;
        b=M91yO5et30Hil4De1HwlxoPlgCJ5zPTboHwteWPub+T9BcwKzf01xYeVPwWHbYoMDO
         p22V7PWwGIz/nddw/9lAUGvHEJ7ntcNzVOmvEvTjS21gKd5tFmI4U8u6q2XGvegXTYjA
         I6GCeK0BGS1L+1OcOkh1L7pw9oxFNfECgyQJVrA12dxu9PXsJ2DvYNTc17KBEoW1jv3J
         dsbRzASPPN6f1cLBP0KWrQuPKiqzomWPEfBRGf3D6XXKGjJk3YGQtkxc7IcyIx2+NDZK
         vbiBvkBK8Zy2to7nvk9dAYFUNR30Tzcf6DwNUyfQc05HAmSg8RGqUfdcb03zZj9zYcUN
         Y4Qg==
X-Forwarded-Encrypted: i=1; AJvYcCXavM9oaukcC4QLu2yl0sRwHbArbCjWkl8M2JYA+Gav0U+jPcT0WgVsT/fiFTLg6LPDit5o28sPDdBoN28=@vger.kernel.org
X-Gm-Message-State: AOJu0YwecsjDUHJeuesZsBE6Mtw+YKfkpVVTBvYV+FaYlynrC7qfDn8F
	ZFwBnu+Brg7+25GYJimC/JUSAvQ/BxDllZd+NX7RRmp5y0zHtDbCwYciG7NUNpuZv3HQElgstiv
	++OoKQsOwBJk9XIs4Wpaibj2C+VhWHhUvUhsFI+C5IDLNUwX7dSz2rtc=
X-Google-Smtp-Source: AGHT+IGs+4RhQotXd2hmMxOjyD4HqdqCg9iGhbt1cREp3UjhhrLKKvmaDtYGfHIYP9PIhJlqtkIIXq5fBj6kRVSUOe7TjIMkUy/h
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:190a:b0:3a5:e7e2:1f92 with SMTP id
 e9e14a558f8ab-3a5e7e22108mr2841685ab.25.1730287262175; Wed, 30 Oct 2024
 04:21:02 -0700 (PDT)
Date: Wed, 30 Oct 2024 04:21:02 -0700
In-Reply-To: <20241030105839.2547-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6722169e.050a0220.35b515.001a.GAE@google.com>
Subject: Re: [syzbot] [kernfs?] INFO: task hung in do_coredump (3)
From: syzbot <syzbot+a8cdfe2d8ad35db3a7fd@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: rcu detected stall in corrupted

rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: { P1029 } 3639 jiffies s: 9185 root: 0x0/T
rcu: blocking rcu_node structures (internal RCU debug):


Tested on:

commit:         c1e939a2 Merge tag 'cgroup-for-6.12-rc5-fixes' of git:..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1408e540580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1940f73a609bb874
dashboard link: https://syzkaller.appspot.com/bug?extid=a8cdfe2d8ad35db3a7fd
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1620e540580000



Return-Path: <linux-kernel+bounces-347071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A85C98CD69
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 08:54:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C66232861C9
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 06:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 230B1155735;
	Wed,  2 Oct 2024 06:54:06 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72CD842A80
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 06:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727852045; cv=none; b=Ybws4x8dy7zdxFEB9sEMU8coZWACM8qeCtkPxVmGEcWgL64OZo/w5Gag2CGhgpGGSDySvYYKqJQdXCzvPDTkgMuv2WsufivfmvjQ4uNhS6ol62tEUxDfzuiBeUtpRzIKDpOA2S6aBMpCMuoX1j2emyD8vBDxUNkl0SBe4tsIDDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727852045; c=relaxed/simple;
	bh=qa3infaQCAo057F7Q3AM/+WiiB9MI1QyjSlvDB9tifc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=mtKjMwpaBaaBtDGTuART307HVL5PI7HuzRvs0uvFEXlwRQ1l/aHmWrLrVDkUivCIw9BiR1FvpMot96ft1NlG1PfqdrkW/fFtRbpfXLs+vTWtCu6VsXgoMEwWtBMmmYxlelF2wEku/V40xvbQ3DL7Bvx8j5D+UNJInWZPhIz8ciQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-82ce2629e40so579064039f.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 23:54:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727852043; x=1728456843;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OAo2yMDD2BRuUPOels5Mo7AQowaBqVEM1zOH2WU7XjU=;
        b=g95nPgq1yXVL3hNOEQ1MhmH7jyJ3vvn/Bb7eXglpc1k75p5sUUHEsD/9Smqrr9QwWe
         BOHWxbg6pUo59djUNJXvsJWSIC0v+oRq/Cvjw5kRKuSJGoouvONR/4Z8K8OSb7tWARfO
         APvRyjPmpi2I1mvZ+p+7RNBJdRjYtBa16THz7MD5leGp11t5jq2v/S2R0aHSh0pz+i65
         Bmd1WqvOhdB5dYIGOJUp+CO2LYsHBspKWTMJEj09LMlCPEVNjZnefcNkAryE7m3jxzb6
         j5H4sbBrMVMhEVSKAze69cYjXHUekhw0d0xXv4XkNcFpoygvgUJNTLDAFwVC/pSc+vnR
         dT1g==
X-Forwarded-Encrypted: i=1; AJvYcCWonZQc936jJQnVWJO7HtWD87AygeBAukNOFM6jMzOmYUPK6E5PHYCIBmq0s5gyPqkqb+/QWfv1xhjyoo0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSncm6bVAKj/CtIpSl62LQNAzdSTXQwz/CPh8zJ3blajaF4ZTo
	iRt7Be6ep3TkBSttc2xfMFvTcZdFY6n3RKx6VZC9YOQmMCQSrODE9mB1dp13Xmmro++VdeD3x99
	y4+9cGkrqCHtDB3AsSBHzj/1DehXX4zzyFxPC0h+QVIfF5RhP/PNJMjE=
X-Google-Smtp-Source: AGHT+IEwUKkE6qT/FibZWUQl1zRTmkwHlgJFklLjNT9xLfKilC7YHJEl8j+wfeA4u0VwKv6ta/zYGiNuYsQ0Ps2OIofME+lrVMEm
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a6e:b0:3a0:ab71:ed38 with SMTP id
 e9e14a558f8ab-3a36592a7b6mr19288205ab.14.1727852043506; Tue, 01 Oct 2024
 23:54:03 -0700 (PDT)
Date: Tue, 01 Oct 2024 23:54:03 -0700
In-Reply-To: <Zvzo1RC8scv-muur@fedora>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66fcee0b.050a0220.f28ec.04f5.GAE@google.com>
Subject: Re: [syzbot] [ext4?] KASAN: out-of-bounds Read in ext4_xattr_set_entry
From: syzbot <syzbot+f792df426ff0f5ceb8d1@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com, qianqiang.liu@163.com, 
	syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+f792df426ff0f5ceb8d1@syzkaller.appspotmail.com
Tested-by: syzbot+f792df426ff0f5ceb8d1@syzkaller.appspotmail.com

Tested on:

commit:         e32cde8d Merge tag 'sched_ext-for-6.12-rc1-fixes-1' of..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13657dd0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=286b31f2cf1c36b5
dashboard link: https://syzkaller.appspot.com/bug?extid=f792df426ff0f5ceb8d1
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=122da580580000

Note: testing is done by a robot and is best-effort only.


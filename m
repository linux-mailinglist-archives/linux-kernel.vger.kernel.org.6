Return-Path: <linux-kernel+bounces-392157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92B7F9B9065
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 12:41:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EBEF1F222DD
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 11:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 704C319ABBD;
	Fri,  1 Nov 2024 11:41:05 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F4156199238
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 11:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730461265; cv=none; b=bJATkdx7Vt0N6maQxRClspZNYi3Djx91V09erBg0HoupmVEMmHMv1N9Y9imUisTnGGHGX/NqCDd7jDFd+DtagS2V27miIDuE//qaKbfa79g0IS72E4CQRZtMNRWoronwJFr3pMeQ2KcgV/A98Gm1AtZp2HqE0bAya8dfoZt9j8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730461265; c=relaxed/simple;
	bh=tz0AI+nrP/NYdrpultsyaBPG0ukpKwCdaZinJiCBoLY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=DmCSCwElt869hA/cxs1GKr00FtbdXtm4j66DrHHsv/MjG+iCtVLMPn2FJ7s6iKNtEtuYj2fGNpjx3pRFi8OBTlOwwP1NZ6My27T83oGy0dq6zU42u4y4OybrXUTR72vH+mpMEj0lM2GNl0iCXPK5ucq8cA43AXC3dJblbRPq6dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a3c4554d29so19208245ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 04:41:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730461262; x=1731066062;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TcFRQtE48UK+gQqnvcVWuzlA1lJZubnbju4eUXeCNCA=;
        b=e6OVPELCM8yXQdMlkoZZE5sEzOB7RV/ABBvhFr0/MuXEvtNcOZJn/0mMjx3HxgGT+C
         FQqPxpICwBGVGyZwccS3T3MPes6qtRaaIgiijb7MSA59ta4hpIX5ygA+qyioA0x4fd5e
         i5F1PusF/du1T6MJXqFwG1bg94yBUjesRVf7fSQc01ADbTDZ7rf2AoUlhqZFllv7PUzY
         MhHPfAHATweLFFfsoQUCXWQpB0aoiiwEp59QIbFO66mDun+KzK21OjxSSOow7gZa3pbp
         TRo6SatvRv0zeGACKbqfPNFA5D7xjQth/GG30TkvzI5tk40SbsiaaiIop4FbOGM3YnHm
         u0Lg==
X-Forwarded-Encrypted: i=1; AJvYcCV5fOAqW07PlTmQvEpkHx865StJDG+SP0EbNhZz8wEW3NeBGSoaZbSoWThRFQd4Dvuy/Icfl6uOyeLkZaw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQLuc92DJGqWOj13Jg0YNNO7nVepmSWFVy1dV4Wep1VpD4F/LG
	m53VCXKgegOkgCG2sg+FZhxsgmDI79L6ka3vkWuBUKyBXN/q5UOHzHEi5WRzm9WZ3pnKzLPJOig
	cGP51Gj8Od8gt08KbwSPuF+SUZeeRlYkvZTe9nczeAmY/fmOgF0oqEmk=
X-Google-Smtp-Source: AGHT+IHMrfLNlU2NgthZ2FUnP+AR0AUUGE2lvP2P4VDwu/4nMlO111hT1CxL/QO9e+kQMndG1sHydas6+72M6kmMEkpxe9ZuGUtb
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:214f:b0:3a0:9cd5:92f7 with SMTP id
 e9e14a558f8ab-3a6b0384e88mr36037405ab.17.1730461261908; Fri, 01 Nov 2024
 04:41:01 -0700 (PDT)
Date: Fri, 01 Nov 2024 04:41:01 -0700
In-Reply-To: <20241101111614.2670-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6724be4d.050a0220.529b6.00ec.GAE@google.com>
Subject: Re: [syzbot] [kernfs?] INFO: task hung in do_coredump (3)
From: syzbot <syzbot+a8cdfe2d8ad35db3a7fd@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: rcu detected stall in corrupted

rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: { P3585 } 2769 jiffies s: 8817 root: 0x0/T
rcu: blocking rcu_node structures (internal RCU debug):


Tested on:

commit:         270c32fa MAINTAINERS: remove Florian from DSA entry
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/ mm-hotfixes-unstable
console output: https://syzkaller.appspot.com/x/log.txt?x=12afe6f7980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1940f73a609bb874
dashboard link: https://syzkaller.appspot.com/bug?extid=a8cdfe2d8ad35db3a7fd
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15c9b2a7980000



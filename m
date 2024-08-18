Return-Path: <linux-kernel+bounces-290969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85F4D955BB9
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 09:05:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E8BF1F21D08
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 07:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B582E1805A;
	Sun, 18 Aug 2024 07:05:05 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C1A17C96
	for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2024 07:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723964705; cv=none; b=fiQus3eOgnO9Sk+kIaTYKvlVZZgmdYpOuTjHmvo6TAh2ec7dqbhI+/xMQfq2Xy6MurQzUiYU5xI/Wv4v/DTohJ+jQ6eY8g2cMv4khKyI/3y1yWWrjRua6PLlOC/Bt34D3zE0G6+EPG0qDAOBTqOhbrMX4fJIRVXq/SIWnvNym58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723964705; c=relaxed/simple;
	bh=H/XKGPPa4sk1xnoTIs+5dmtF9w8LaBWYETMI5xcE3ug=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=e58UIQTsSi9sFncfRpWJHGzPvOqgeSbLb4U405+EBM+C3ByFlElvnBgyefavxocReeGVmI+/imgq/NtjY85Sz2bmCn/C5aS/M4TJF6UBOboKlcJbn4AdxIl0cv7OadgTjf5wqVyYc750GD4/oPLVIFDiCd1LhoJrJW7MVKthg3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-39d2dee9722so20918985ab.0
        for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2024 00:05:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723964703; x=1724569503;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AAODbr3KNrQLgKG+w/bPHlAPvZQUfwQo38tYsLIe7pI=;
        b=jQg1FvYgG45vuzzNj+1xVrSuTLQht0QxwjhhZa9HRHT+B6jX17FGMzRh+c4XRo3ENE
         OVfvTHivtxJygTmb+jJVqYuQvAlV2/oTOCtI+yZKYc11F7DZCOzlGo6wndvxnvWQSmju
         Ew/+IggAhw5bLDaF4lLQFFtlY9eP1OxUOJZTAYbx6FV70EpbMJuv7DyGvZ6DM9K9OHip
         HperxZT/EbjHsMg+WougehpuswWCijIYo8VfYBNKVBt5Su1CVTuTPLAbcgSAACUq+rVG
         AiAVbGcEUHuRnRnWU8/jqSzs7hcHhZSMel+4ksNY7ruarGsAg0B31RpNFEFCGKaECCo2
         s8mg==
X-Forwarded-Encrypted: i=1; AJvYcCWV1t8wB0ZCiBh8AeI0J2R2GlgjLULARTU/B+KNH0CvhQwpWx8IVwTcKQceFZ7mYaYL33F6RWdMvXDQb8mf6e1up+mtEus9cHizCCk5
X-Gm-Message-State: AOJu0YzvghOizBPPny3jwT09mo4Uoqp8knljVjlgM7EzkWGoLctRuld6
	3LHMQj/yxvujlwEz/Z3w1DdnmUtkV8XKy1NYQ5wRCeB5Zx4G3E4QzQ0AKG2YcQdKv4Q4vPY65nH
	myCd3BJtqDv7vs+QJbkjx8DJVeTsDiSx/EpQoC2ziMs5syJqfohxe8EE=
X-Google-Smtp-Source: AGHT+IFIf/XAp6OAbWzSaPzmAnzIo5XNj4ClP9Ag5KxvX+Szm8WWVlR9sdtngHyBnGk1odrfmYyO4dPohFlbWPrGwinei1eqLvGH
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c23:b0:381:c14:70cf with SMTP id
 e9e14a558f8ab-39d26cec1bdmr6913475ab.1.1723964702919; Sun, 18 Aug 2024
 00:05:02 -0700 (PDT)
Date: Sun, 18 Aug 2024 00:05:02 -0700
In-Reply-To: <000000000000e540f3061fc68863@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b91f33061fefcfbb@google.com>
Subject: Re: [syzbot] [cgroups?] possible deadlock in task_rq_lock
From: syzbot <syzbot+ca14b36a46a8c541b509@syzkaller.appspotmail.com>
To: bristot@kernel.org, cgroups@vger.kernel.org, hannes@cmpxchg.org, 
	hdanton@sina.com, juri.lelli@redhat.com, linux-kernel@vger.kernel.org, 
	lizefan.x@bytedance.com, mkoutny@suse.com, peterz@infradead.org, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de, tj@kernel.org, 
	vincent.guittot@linaro.org, vineeth@bitbyteword.org
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 5f6bd380c7bdbe10f7b4e8ddcceed60ce0714c6d
Author: Peter Zijlstra <peterz@infradead.org>
Date:   Mon May 27 12:06:55 2024 +0000

    sched/rt: Remove default bandwidth control

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11a668dd980000
start commit:   367b5c3d53e5 Add linux-next specific files for 20240816
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=13a668dd980000
console output: https://syzkaller.appspot.com/x/log.txt?x=15a668dd980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=61ba6f3b22ee5467
dashboard link: https://syzkaller.appspot.com/bug?extid=ca14b36a46a8c541b509
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13d6dbf3980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=142413c5980000

Reported-by: syzbot+ca14b36a46a8c541b509@syzkaller.appspotmail.com
Fixes: 5f6bd380c7bd ("sched/rt: Remove default bandwidth control")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection


Return-Path: <linux-kernel+bounces-200709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35E338FB3CE
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 15:30:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6F241F215F4
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 13:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FAA3146D7F;
	Tue,  4 Jun 2024 13:30:06 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CAF9146D77
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 13:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717507805; cv=none; b=uzNRuJzFH3ukr4c3rM01ebJuKrRP02fFtBnZD/B3GMgsDl6KJXXWI8YSZsoxAZRDQ97gX0IgPinWMc7aaifEdD3zRVrqnbNsZJFxPRbTZh+qmUNO5QyM3ewC9J3+t/KhJ1w9zPZlhatKQJbqpvismPQwCjr8Rnxn6D1R7JbYMrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717507805; c=relaxed/simple;
	bh=mHhdF94b4ZnZG/rt8qqIGYhlHwv/Pdc+Y+AHFKVOwak=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=mWONA7xlfEjSZ1EgJA7i1x0u2nz7bbxHaQN2Vy/Wa8+v8YCgXakNWtswDWQTTQw0BAMK5iz5I1XIIwhoVdxHtTrNoZ0ujXLCI0wHvYoAu02aRtOXHNU3G3LW9eqQUqqbtuJKeFZIkEurM87QB0+WqmGCI28g5Jhp60eZR4DGh44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3748be0ae92so9955365ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 06:30:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717507803; x=1718112603;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oFTiTfe3hNJgwZs9HmKmaU3IvhsjzP38K8yAfv+j3T0=;
        b=UcHcpUsZ+cDRqjRIc+G1JZDQsr5kdK8YEOEPHjZLMo9z8UouOWGYvSfi043fTzMEEX
         /qlidahi0ZBafx3sOwQ894FqYawaTDMoy2oKwcLHCNNgfA0pZtT60ZI8JMcG8zC2eF+P
         3V8Rxglwx/mvA61A29t2XY8eRiLQjmyacmnPSmFzqdiq8yATGkDGFGKzIDbqAyhMMdDp
         hbVgY6C6yb8mGRLldaRlWLOxHIB/u6Bbe6F+nasLEzPxcYJBg53lngmTnK/qx4mm7dBz
         FMre1MXhKWeQ9+YZZf405W3e9V04l+0e9NwQsqPRnRsXt5t8Ht6akqaXI6ImVIkbs8eJ
         Ctvw==
X-Forwarded-Encrypted: i=1; AJvYcCXRr0Qb5oL7oJRPoQNEHsvpLAZX/IdbiXZtBvEijtq0wyozMXU9FNTM0Mw+bw/BAVbD435clmytv/UbmTo71qB1SMelBlvI8tiT2/xq
X-Gm-Message-State: AOJu0YwJU2ap/0bxdjfN30inCAirPOrw9gL+8NSFIpZ4Vb9Z705eZIIP
	8zOO/sMnZH6B6lp3fyI+9riyGQpdRM6xAep6f7ARs6Tb9N5q9Bzqe/hK71Z/lM1u0lRT0kFdUw4
	BeoSe5glUYuex3bNPa6I6T/z8sV+rES13jHTDiVao2X2kaEgLUkUrFSA=
X-Google-Smtp-Source: AGHT+IGntpKJZup7JPeTXE09pYMF+lxZyOC1ixCnn1Iq0fhSvSRdo2HKefFg85nyw+q7P4fm4ndcafJBWyk7jnWw+YpLLoIbBS/T
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d1e:b0:374:a422:ba7 with SMTP id
 e9e14a558f8ab-374a4220e6emr3190315ab.2.1717507803530; Tue, 04 Jun 2024
 06:30:03 -0700 (PDT)
Date: Tue, 04 Jun 2024 06:30:03 -0700
In-Reply-To: <20240604124522.1781-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000087580e061a1072ae@google.com>
Subject: Re: [syzbot] [kernel?] BUG: unable to handle kernel NULL pointer
 dereference in __hrtimer_run_queues
From: syzbot <syzbot+558f67d44ad7f098a3de@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+558f67d44ad7f098a3de@syzkaller.appspotmail.com

Tested on:

commit:         2ab79514 Merge tag 'cxl-fixes-6.10-rc3' of git://git.k..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=121dd4ac980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=48aeb395bedeb71f
dashboard link: https://syzkaller.appspot.com/bug?extid=558f67d44ad7f098a3de
compiler:       aarch64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1346c226980000

Note: testing is done by a robot and is best-effort only.


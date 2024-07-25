Return-Path: <linux-kernel+bounces-261621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A03993B9FE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 03:01:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C81CB21549
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 01:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D1FA79D1;
	Thu, 25 Jul 2024 01:01:04 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA396AB9
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 01:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721869263; cv=none; b=TWGKAUHe+SpxgTSWLQI9hFf3MUJGxxKCDJaOCOkx0aU2h/nlA57okeYtn9EXyOCU0bTY577/sY+cbppdoYoDMZpSMp28ivueLWN0Yj6wbAMh806iBh+uDMhE1mkkeFthiKTavBGOGEaGo0dUTNPUQVpPWPmFdPU/QxyfHF9Z8eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721869263; c=relaxed/simple;
	bh=8kk3Te+qLD44IUgYtWzAUtOnPox3lN0OuDxugG5oUXc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ZHe63GSpTDDV78mPJr9gKZGqdhrVL0W4fere91ba23GB3DnbIh1Q3Sbv5/HJpu328co5dOA2JO2mcZ57uh69nEUeWUkPxGrdPvriSANU9gxJLu57PbJ39O2EFFwyuI77TqskZum8kRDJuL6mjOdHKtw/QMi3iec/hcq5PxZRGTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-8041a66f2ebso61031439f.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 18:01:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721869261; x=1722474061;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X8irUD+IVqNvyfrm7fkCMoY6zNVcVbkqgFP/xxoo9XY=;
        b=vK3uQ33gPGXQDa6M4VadAdZ72U//XbYdNiQRSQVKhjDYhMVmod6il33FBB1wDY63nK
         v51KF5UEGsXcUY+hPxzrr+jQTE31D2CeGCOKGh45RIYh2rBXImJxXIoaNGQDJWxO+AD4
         MawqhvbZCFRa8h3sQjO3BaQG+wvFqOJ1bRMp/D55XGhUFZ4xS0iKiuUx7xFr0H5ABRt0
         L+7yFgPTIE/fp9dBAAp3+Ixpr5fcSiKC1aX17JaUmdLR68/7cyr21Bc1ROI0PNSES8kx
         FARY7y1PD1Z2Z5ZpuglMTQyyvIYcmqfpuZY+Ptzaqo7S19MMdOUoK5jqLYNuwIyqN4TY
         TWfQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtGXkk8x32rI9xM35nHLRJYTgvUslxA8Mwr4d71vKKnXWlEqI0BKfgZp1pR0wuiUjfrbmS+SUBoQCtzFXmUckwR1HczVhmctKeqQlI
X-Gm-Message-State: AOJu0YyheG1ApwbDOrd0xiltb92uZIYw1N647Ke9v93h0Ne96TKGrP+2
	Dn6w6qorIjgkAiAtdYNDk1Uh8WWKKlEyH49CyJoJenjq3i3wBzWkCE3OCpyH6u+ZeK3DYqN4+ZE
	b2R6lZ/zqyAsQnkuVd8oWMfatX7b3sXB0Z9kPT6ODdmD4EHSNkcGWuz0=
X-Google-Smtp-Source: AGHT+IEXAbpwASAdyHqialMw4BQ4JlpFFb82Tnj7Ly4W1eqe/AyPidKj5296l4HTxxvvEMhO9QlR6QmFXYJ5PRvV0GhPaFTj0yOa
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a6b:4419:0:b0:809:488:97f with SMTP id ca18e2360f4ac-81f7e4fc4e8mr427639f.4.1721869261495;
 Wed, 24 Jul 2024 18:01:01 -0700 (PDT)
Date: Wed, 24 Jul 2024 18:01:01 -0700
In-Reply-To: <0000000000006bca48061692b790@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ae7466061e07ed39@google.com>
Subject: Re: [syzbot] [mm?] possible deadlock in gup_fast_fallback
From: syzbot <syzbot+63ba90b81c16b86379bd@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, almaz.alexandrovich@paragon-software.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 69505fe98f198ee813898cbcaf6770949636430b
Author: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Date:   Thu May 30 07:54:07 2024 +0000

    fs/ntfs3: Replace inode_trylock with inode_lock

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=157ffac9980000
start commit:   786c8248dbd3 Merge tag 'perf-tools-fixes-for-v6.11-2024-07..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=177ffac9980000
console output: https://syzkaller.appspot.com/x/log.txt?x=137ffac9980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d732ba79a3d0331b
dashboard link: https://syzkaller.appspot.com/bug?extid=63ba90b81c16b86379bd
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=162862e3980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10d14ce3980000

Reported-by: syzbot+63ba90b81c16b86379bd@syzkaller.appspotmail.com
Fixes: 69505fe98f19 ("fs/ntfs3: Replace inode_trylock with inode_lock")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection


Return-Path: <linux-kernel+bounces-253172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFE35931DCE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 01:52:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE41F1C20E8A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 23:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59587143892;
	Mon, 15 Jul 2024 23:52:05 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DED21E890
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 23:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721087524; cv=none; b=ohSol0ix31U9cJYLmOc6CmYCNLWxv1tsHNAtEAmT4vW9wyR4KaXPEj7XdZIDbMImBs2+kZt2eL4SK5f0ccSBZ8aGxbbmE1M6OkGv8nD8owHTwdhDCbCsPZJj9/aQN85KdT7cGOi+rbS2zQB28m/T8NtVQzdXppHk4QDS5TnJwXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721087524; c=relaxed/simple;
	bh=AuRv+ixFzr3WJFdjYojC9WuJxeFJDgPIie5WLMhbDPg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=PCIFldVZ1X1Yh5gQgflZkz7gFd2rJTMPkiPFwp24LIRT5OZPeRGttmgwIwjZFl3PDsAmVtxeCXFoy30k18WN7RhlOFTbpUn3IKs1pv5Y0KugDlt9qeXdNRr3klOdFfOrkp2xv5PhaWxH84LFhWItv5/e74w4q8AgoscPzfEg9ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-37714b7f378so58789815ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 16:52:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721087522; x=1721692322;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZxjBgjbqm235y8LYzxWAk6dpFwDHzr+tigxB2IBFD4s=;
        b=oRwZ8JhrHvIhqq/zE7LgX4VTNNRD6xyV6/zPLaShHt/m4ksRfquaIK6ZCG1N63BEvf
         lzfXNUFMy5UAVu5qYAstFt+aEh0Y0gRBe9pmHKUH/4ti3k5Jz3T5CWRAV09wDv4ropzs
         jL4Jyfp/1GqaXVC97VOvWvU+Ua9EBdEPNqIuLvVHQVxcd74+goSLNuQo2FzAx1g9J53E
         RFj0SJn53OfDHjG3YMjGCmA8+D2Cp/cMNLN6atCK5hAqBF2yy0iMwFsiD/k0etdx/R1n
         vKOhPSsOv7jdR+vkIlZd85Es8iy69DoDyjl5tNDUKza+zkzny8OThyP0G2LQZRHeRGZM
         MPhA==
X-Forwarded-Encrypted: i=1; AJvYcCXIOMvT5F+o7uMrQXl6g32tDp8pj+SC7NTrdIKOKUkKp65UCFNpO9mY7sGPnidQWOvbq3J4BrlXFBq/V9Psd5CPE6atmmUgaExHR44t
X-Gm-Message-State: AOJu0YxTOo/5oLI43RJz5l4ezaemIi+HFKoTt5XrDwC0IRO03xxEnmwa
	LoABGC6elfHc/sPhtsl4h5/ob//gkFP69HRE+GQEQinStxOGrgPDGPkNlWd8tbi7f8E8WXH+7XE
	32RPhq02bRorISseZuOHYZShCLAW3/5xBvrKhsW8NWlRIQLdveYZA/Ck=
X-Google-Smtp-Source: AGHT+IFIGkjjLJ5uFLEXeRgq9CYGKiCDCoD8C32h4tUZuyjTn0qj2ewI1P8u6/cMgV9UNiSAV3uisownXIg3ntCTXRBsZ+2MRiwk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fc6:b0:36c:5c1b:2051 with SMTP id
 e9e14a558f8ab-393d402aec4mr571925ab.6.1721087521980; Mon, 15 Jul 2024
 16:52:01 -0700 (PDT)
Date: Mon, 15 Jul 2024 16:52:01 -0700
In-Reply-To: <ZpWFMgpbZipqyGfN@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000601513061d51ea72@google.com>
Subject: Re: [syzbot] [kernel?] kernel BUG in binder_inc_ref_for_node
From: syzbot <syzbot+3dae065ca76952a67257@syzkaller.appspotmail.com>
To: arve@android.com, brauner@kernel.org, cmllamas@google.com, 
	gregkh@linuxfoundation.org, joel@joelfernandes.org, 
	linux-kernel@vger.kernel.org, maco@android.com, surenb@google.com, 
	syzkaller-bugs@googlegroups.com, tkjos@android.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+3dae065ca76952a67257@syzkaller.appspotmail.com

Tested on:

commit:         82d01fe6 Add linux-next specific files for 20240709
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1339eb6e980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=95a20e7acf357998
dashboard link: https://syzkaller.appspot.com/bug?extid=3dae065ca76952a67257
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1198f85e980000

Note: testing is done by a robot and is best-effort only.


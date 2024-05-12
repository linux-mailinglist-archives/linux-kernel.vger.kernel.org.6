Return-Path: <linux-kernel+bounces-177053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BDB68C392B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 01:10:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D690828115E
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 23:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02A2958ADB;
	Sun, 12 May 2024 23:10:09 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E06228F5
	for <linux-kernel@vger.kernel.org>; Sun, 12 May 2024 23:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715555408; cv=none; b=iLVsi/27JPfH7azWHIULhcyHEhmwz4EHVR4pNdZ4me8hsbf5s7HJf/e1yFRUrBUZQmNMnRBIG4MSqPp+gMrT9iljPsKq8hgIRZjgr7ds8DzCm/4d3XM0SrPvWnCHicm6S/wAdb7OBtXO8zWpgs6cmcDGQ87ul/bbYu9eiH/oufQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715555408; c=relaxed/simple;
	bh=zf3BLuSMfBe0PXkKF6N0/MiJ+8NR3KUdSMiyzBmJVRc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=DoSFC979EU+Y8O5bguG5kvB8mHJw52rpKlqXxAx1UiOfowCDdwSCpJ8dTna1LRxQQ7b+5QfUiWAdvXqu4SdO1QZBFR31YRb8K4MJWsaC8Vv1Ag4ZgX+rgw1fnboTvSpbo2r7In//gXz9i7Y0StGPCKfvgIUXM06u70r13xXedUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7e1de4c052aso70508939f.0
        for <linux-kernel@vger.kernel.org>; Sun, 12 May 2024 16:10:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715555406; x=1716160206;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GbrCsTKdvgH9uMmvs6/bxEAqYO1Q8tZzqKfBUT/UfMw=;
        b=keu0DPeOppX9rsHL26JV7rw8sBGH7OnRc5l7XujTbC/PhapwmNOVxr04k9ZobftAfj
         8qHzVphYA1Yn6FYQJEqHsFEekOx/gfhn+gnpB/zlK+DV5XhU8zg8bESKE7R+INj5+OEP
         ioOBa9Syo9grjVNF0EMd9/eFboTrlzi4frusDelQnK2vZr7kqz7iqgM4IZZZOtm5lN/b
         +zu98ov+9ucoy2ChUJD2APXgnefdyHVnkr4aF6JF4oSwEFBYXgD9oWHOr79v0PGX6Jp3
         NPR1vhqDO1hD9XoeQ2znJjipBsuZSg2QEvnFagOhW0yf1lJAIgDV0MqYdetYD92k5kNM
         wrJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJgF9AQPHh6Z69vXfVDIU1ijHF2kA43vUuypmzzVzOHGToiwdDR7UOSynmDN1i36tftxTXmUnPD/5GJmL1ZAdyMxr/8TLvJZn8r2fd
X-Gm-Message-State: AOJu0YxQ/ZNgjlxZRWrmUyGZ4OVtz7q/67/Ax6PbyUzUtpNZ58x75Z2r
	lFkmw7IU3bpDIwVYz5VaddKow41okwAwk/Ms2Wx1/Igeuaae/GB7iEW3+YQjnpgN0/dMPpb942r
	Zrmr647dMSiR1EpfUd+xqjAlxiVC7l/LTY4wTDvdCduOsdgcrvyKy66A=
X-Google-Smtp-Source: AGHT+IFbF6/1U4ZjkbPt7/Ku066DSsvtVjZ1b39GrokssKVuwlu+ImcsZt/JAv4BK84kKFieycM7bTPSqsktD5UBtmepeapXr9cO
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2727:b0:488:b7c1:401b with SMTP id
 8926c6da1cb9f-48958e0d1e0mr729180173.4.1715555406365; Sun, 12 May 2024
 16:10:06 -0700 (PDT)
Date: Sun, 12 May 2024 16:10:06 -0700
In-Reply-To: <20240512223450.2890-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000096d570061849defe@google.com>
Subject: Re: [syzbot] [fs?] KASAN: slab-use-after-free Read in __fput (2)
From: syzbot <syzbot+5d4cb6b4409edfd18646@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+5d4cb6b4409edfd18646@syzkaller.appspotmail.com

Tested on:

commit:         a38297e3 Linux 6.9
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=175fec3f180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3f2ffcdf236c8fc3
dashboard link: https://syzkaller.appspot.com/bug?extid=5d4cb6b4409edfd18646
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.


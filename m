Return-Path: <linux-kernel+bounces-272056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 519F194564E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 04:29:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7304B22DD4
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 02:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F152D1A702;
	Fri,  2 Aug 2024 02:29:04 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29599B64E
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 02:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722565744; cv=none; b=sP30/FW13khnD2Y+vtDTcGQ9Zpzl0Oyjg0JZf+nsU2D4rrWkX+XA5fmKtKFxGci48rgb33YdCON225Ef1v0o/bQIpOA0uUCjVcNe2vyhAQtMQrzzVQx9nx3Jdcv1mNxdhXKyVvHGx7rRiBJ9zV+vsBgqcQw6Tc5zpPguf893tqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722565744; c=relaxed/simple;
	bh=4J2+OAbxH40EKWVmejNEtpmGtyb1n3CQYbIcGc3CEjE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=P9JqqTmd5qFG0ZdGcFfgAV6hYWMZeqfWapabwXYKl54zoWWQyC5FiID5RopyAA8MbAE2Vzl2L14tB/kAi9j3DzOAFOizu+VQFLkbkHqS7ixQvUW3TTCjvQrJngjTpON1c4hfD1PcguTW94OdFd+Xn0trFmz6D3WbgJelxXouIuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-81f8e43f0c1so1090951939f.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 19:29:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722565742; x=1723170542;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8Q/Ye9Z+jG5K6SsonreeVrYeesu+LELNnvv7iXUxYuw=;
        b=E/ai4iuthCRMZjI8thQbX8aPcFuyn+SejjOK/ORoYAgzIk80RrQkxp2sFU4bpBJxJq
         Bjl3DJLD3pyrlEePBKDeAy8VEOKywdFhplp7cAw0sdk/SW6tu532j4QtDw61rQKx2ebJ
         4QRTygQT3AsXwXlhxJ+TeE34xCvkw51KwdaEg3lFaYEVX81Wdw7KfR4+hkSAlyAWU7vk
         hwHRL0suEm8+a16nBgQ9wLOmvkYSrkLj7nDWmceakOZAuyOs42tMXSaa+q2q1E42JzjD
         O45RRqaQ684RSyyyK361uCOzqR11AHVQpUzM3EFcbnOBlrjDYMgHInyemsDz2uoMaUpp
         GTsw==
X-Gm-Message-State: AOJu0YwsT6Cojmqc9Id6QPAKVVIVrvMS01fvRKk7tUp0ZlRd/V+LT6od
	VHSZflErcx5bVFyW63XKykYVgSSBe0vuBA0LqEOF5wGxkMmIz7FXlKUSWujiNHNOzF9n2yW8AaO
	nQ5RsOWR4/FCh6SeuQwlb1RRHck5VfvntVxHJpxZLNHG4+mnrp8e27w8=
X-Google-Smtp-Source: AGHT+IGjnAJb8myQsAYlmFWEoHHmwUryv+Nmg5lAgJFKdnkH8f1eiqc94nL+cYiHl4t1QsvB6SC9O3RG1UXoGfr489gBsCPsOkJx
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c06:b0:39a:1b94:9733 with SMTP id
 e9e14a558f8ab-39b1fb8f0ccmr1533315ab.2.1722565742276; Thu, 01 Aug 2024
 19:29:02 -0700 (PDT)
Date: Thu, 01 Aug 2024 19:29:02 -0700
In-Reply-To: <20240802020037.976956-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002bc5f6061eaa1738@google.com>
Subject: Re: [syzbot] [squashfs?] KMSAN: uninit-value in pick_link
From: syzbot <syzbot+24ac24ff58dc5b0d26b9@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+24ac24ff58dc5b0d26b9@syzkaller.appspotmail.com
Tested-by: syzbot+24ac24ff58dc5b0d26b9@syzkaller.appspotmail.com

Tested on:

commit:         2f8c4f50 Merge tag 'auxdisplay-for-v6.11-tag1' of git:..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=12df3703980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ea3a063e5f96c3d6
dashboard link: https://syzkaller.appspot.com/bug?extid=24ac24ff58dc5b0d26b9
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13687e55980000

Note: testing is done by a robot and is best-effort only.


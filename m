Return-Path: <linux-kernel+bounces-411688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 67F3D9CFE37
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 11:38:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2D99B26E69
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 10:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D4C7194137;
	Sat, 16 Nov 2024 10:38:05 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76329194096
	for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2024 10:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731753484; cv=none; b=Xo427qDJ1swEOMASV5836sH98TcE43Fq5hiNhOK0zRW99t+MQVDfjhcks+A0O07WTxWL+dU/RNrWYxp5neHNnRk+uvyeoJQglOUqZCkrr9ONe+1Eun9eTn7GaCI4opbhTrW4b4mzIT4EtdCeMBLo3Qwl0RtGG/vf3YrCWlkvje8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731753484; c=relaxed/simple;
	bh=nnqogNynXOMA0QadwMHnOAX0FSBNZm1yoF39BZbwnJU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=gz5sQX9CmOft0iJSupBFAGWEsh3f4FTU9ItBXDTDDQl8OD2WkgL4QKQ5rvTo5iU5XpkhnhLNPv2pXN3+wOCBD1dZa44MAPdYdbHXDAjjHrX+FbrkRlMUSPV3rLAt0/Pw0Xu8vCHhlDNo9ffMquNnINQanwWP5XAb/5oTyHOIljc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a6b37c6dd4so30909935ab.3
        for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2024 02:38:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731753482; x=1732358282;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OAueTxdgAoViJAt82uzda7JpmlwOQ7bg6ANECTjo1xQ=;
        b=PVFdPYex/6Icd5eHDU3lDUp8kRK6QrP5245tJYVgN358R3MfU9dXbWyqv2GxBkpK6i
         KcyMv4lXKNBITESOp8GJ7e4claTqX+JFDLKAJwk7DAvVQgLPcZ1hJuTwPdHdAxpmJcAB
         k91fySD5+7Y4MztNz3THTWgiMwpL5DX7tmpToTDfxbZIJyvLzijYtIB6WiKIrtYpOW7u
         BkjAn2z2otpEKuES/n6LFKUGiaeaOrpJCSsnCmrZSKKF3kG+FMV4qbADxEkHLPPjVJ/F
         gHmXQSO5XXyYmBdeNRoyAcm6hWFxio7n6L9ouAPr80GvVVVWt+YJYR4WTuM14BFvjtLD
         4QPA==
X-Forwarded-Encrypted: i=1; AJvYcCVEcVf3NCPAwYGZ0vy31Tk8I9T39Z2rPajc46PlNcU+8BmqCGR/yu4+hUzCuApElHnwGYyycqF94HKVNG4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp+t4dINxs8+5A0gmNcwwJkerv1FexmmClLQkhntjlLgQFYbpM
	fjALuM/NKv30ABhy2F5A6fGAdis3N4VgnF/Qp3/tM8kXmvOiF6dStZoBsHoeG4ixRA4NpBQZlub
	cru7on0EaJHc/uDOzZXD7Fo0BKnfwDE2sZeRXQixkKg8sokbqP4sfbMI=
X-Google-Smtp-Source: AGHT+IFSqWbqPsFEJebjAPbB7M739W1+clCtsyBBoGxheG+D53bEoWaGQu5RBakPUDdg7o7J/5mS77EwdkNCTo3Ay9S9BoKA0K48
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:368f:b0:3a2:7651:9846 with SMTP id
 e9e14a558f8ab-3a748023851mr61926845ab.13.1731753482730; Sat, 16 Nov 2024
 02:38:02 -0800 (PST)
Date: Sat, 16 Nov 2024 02:38:02 -0800
In-Reply-To: <CAHiZj8iv2WBFHDdamhnOg+KTNqWrmNpDxshpEX7h4QdtF0Wb_g@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6738760a.050a0220.bb738.0006.GAE@google.com>
Subject: Re: [syzbot] [acpi?] [nvdimm?] KASAN: vmalloc-out-of-bounds Read in
 acpi_nfit_ctl (2)
From: syzbot <syzbot+7534f060ebda6b8b51b3@syzkaller.appspotmail.com>
To: dan.j.williams@intel.com, dave.jiang@intel.com, ira.weiny@intel.com, 
	lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	nvdimm@lists.linux.dev, rafael@kernel.org, surajsonawane0215@gmail.com, 
	syzkaller-bugs@googlegroups.com, vishal.l.verma@intel.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+7534f060ebda6b8b51b3@syzkaller.appspotmail.com
Tested-by: syzbot+7534f060ebda6b8b51b3@syzkaller.appspotmail.com

Tested on:

commit:         e8bdb3c8 Merge tag 'riscv-for-linus-6.12-rc8' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12a112c0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d2aeec8c0b2e420c
dashboard link: https://syzkaller.appspot.com/bug?extid=7534f060ebda6b8b51b3
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=109e12c0580000

Note: testing is done by a robot and is best-effort only.


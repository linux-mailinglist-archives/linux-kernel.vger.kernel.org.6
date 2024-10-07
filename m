Return-Path: <linux-kernel+bounces-353339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E28A2992C79
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 15:01:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E52828322D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 13:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFA3C1D3582;
	Mon,  7 Oct 2024 13:01:06 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0616C1D3194
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 13:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728306066; cv=none; b=HRgSQo+XrL2F8zpUc840V0KEKSmuRAKVjAgMOyi8g8R4RWsjLPnLUV/4hvbmLbN2D6zH6N7nQ5qMQ2v2gPasQ12aMLCuzWIs3sKndoHsBITO4L1UDW4b1WKQ2RXj+IROJMUi8ThjWfnmbXmmnxK5sCuVgNpa2RXaVKAE6oiR3Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728306066; c=relaxed/simple;
	bh=6ZDwpQNH8ruG29ftAYSNo+XG+3ZJSTwkrpdAFbPdnf8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=IGYyep3IsjVIDT+a7nv/uh9+jw8+9xxfbZGKI6uvn02I4GUafA5tCPzIyPRHSU/8y9U6Y59rHwPPbfVSbSMXPQD0EAKExB/MWAm4OLMSeFmqQdW+eiFovjnFCYPjw/LHYHVpeL7lwCTMV/+5+Tu1RxWuuT/+G9CJ3G4mK/4+V6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-82cda24c462so424104139f.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 06:01:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728306064; x=1728910864;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2b2W98oIBjEk4qhDVYV4zWMNL5u/aDLzl8zsUKuE1vk=;
        b=wdH3pwbg/5xVe/htXEPISV6rp0p7XLZGz5zo6L/PirQJXskfmyowrETmECEKLmgPGD
         5qw3m6Rev9zSmXiefqXadZNdGY2FbMEA0Pie5DKOquSPyQrQL57x6T3pW9lVAS38eUOY
         hJ02CZnyFUYdX7MCLONhCZgRMzbN/i8ooyt3pTGgt8uWaV7J5QWMeDzn3t7V9YmAd3w9
         Ar2zUq5L0FP7s0RmRyauKIBo9dCDpVtDe6NI/iFIG7SxeJpWpIPakYripPhR+1HCJdyI
         3V6wdbsqlUoVjoxUkRRHHAGbE1yTTiPuhfG9pyKoGYCTGEgZbyejMq61MWykQCLrGeVG
         yiuQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7QUv0I5j4CZMHewRlhuEyUe3ryzb6lDDUv9fexqF/VFWOAN8cHiIJh3gXfOY5RzRu5G0EZyRAuRjns50=@vger.kernel.org
X-Gm-Message-State: AOJu0YyC9q6Hh2jhe/8wY+H42JFJgWt6FFrnp3JRyH0V5SL1uqFcvXyw
	qk/Y+6Wf8qHDJb6vu3zxy54jOuUSx43KHApPYinSZK0W6xcFeKfcBP/LGhAIq9etKv6N9ZL65tq
	mSIwIUSE5v7ZG+RJfX2YpUEWoxyMgTqgthiMrIno/IW9Ih78TAW+wCRQ=
X-Google-Smtp-Source: AGHT+IES1c6ggIagGg+UIBXqrsUM9+WVC9F+mryIJZ0Jdo5NOMaY2S6vwhbvIKMxL3MgxpGJZclMcPVt0AQRKnED5528Ik1OJJp+
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:148c:b0:39f:5e18:239d with SMTP id
 e9e14a558f8ab-3a375a9ac5emr92835985ab.15.1728306063968; Mon, 07 Oct 2024
 06:01:03 -0700 (PDT)
Date: Mon, 07 Oct 2024 06:01:03 -0700
In-Reply-To: <tencent_E4F3C6420991AEE0AEEB4C80A7CB06CE5206@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6703db8f.050a0220.49194.0508.GAE@google.com>
Subject: Re: [syzbot] [bluetooth?] KMSAN: uninit-value in hci_rx_work
From: syzbot <syzbot+6ea290ba76d8c1eb1ac2@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KMSAN: uninit-value in hci_rx_work

=====================================================
BUG: KMSAN: uninit-value in hci_acldata_packet net/bluetooth/hci_core.c:3796 [inline]
BUG: KMSAN: uninit-value in hci_rx_work+0x1092/0x11f0 net/bluetooth/hci_core.c:4030
 hci_acldata_packet net/bluetooth/hci_core.c:3796 [inline]
 hci_rx_work+0x1092/0x11f0 net/bluetooth/hci_core.c:4030
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xae0/0x1c40 kernel/workqueue.c:3310
 worker_thread+0xea7/0x14f0 kernel/workqueue.c:3391
 kthread+0x3e2/0x540 kernel/kthread.c:389
 ret_from_fork+0x6d/0x90 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Uninit was created at:
 slab_post_alloc_hook mm/slub.c:4091 [inline]
 slab_alloc_node mm/slub.c:4134 [inline]
 kmem_cache_alloc_node_noprof+0x6bf/0xb80 mm/slub.c:4186
 kmalloc_reserve+0x13d/0x4a0 net/core/skbuff.c:587
 __alloc_skb+0x363/0x7b0 net/core/skbuff.c:678
 alloc_skb include/linux/skbuff.h:1322 [inline]
 bt_skb_alloc include/net/bluetooth/bluetooth.h:493 [inline]
 vhci_get_user drivers/bluetooth/hci_vhci.c:487 [inline]
 vhci_write+0x122/0x960 drivers/bluetooth/hci_vhci.c:608
 new_sync_write fs/read_write.c:590 [inline]
 vfs_write+0xb28/0x1540 fs/read_write.c:683
 ksys_write+0x24f/0x4c0 fs/read_write.c:736
 __do_sys_write fs/read_write.c:748 [inline]
 __se_sys_write fs/read_write.c:745 [inline]
 __x64_sys_write+0x93/0xe0 fs/read_write.c:745
 x64_sys_call+0x306a/0x3ba0 arch/x86/include/generated/asm/syscalls_64.h:2
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

CPU: 0 UID: 0 PID: 4561 Comm: kworker/u9:1 Tainted: G        W          6.12.0-rc2-syzkaller-g8cf0b93919e1-dirty #0
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Workqueue: hci0 hci_rx_work
=====================================================


Tested on:

commit:         8cf0b939 Linux 6.12-rc2
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=121adb80580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=981fe2ff8a1e457a
dashboard link: https://syzkaller.appspot.com/bug?extid=6ea290ba76d8c1eb1ac2
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=150fc707980000



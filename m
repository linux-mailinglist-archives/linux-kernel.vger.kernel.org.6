Return-Path: <linux-kernel+bounces-300600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43C5D95E5A9
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 01:16:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C224E1F2170B
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 23:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5249F7829C;
	Sun, 25 Aug 2024 23:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="EJiH5qul";
	dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="VJ3Zlz3G"
Received: from mx5.ucr.edu (mx.ucr.edu [138.23.62.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC19C78C7F
	for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 23:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=138.23.62.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724627804; cv=none; b=tHFPKJ+YmrbXQqYesw5SG1k0bVW5P8wX/iEGmCiXdknvYB+LSwhUJKWIosAtxEthVpGzOBZ+99ey46aprQfhuGtAqZ/ke8F2rJ92x11xHaTiJrfvDgTK640Mr/6ty1jVbyRpAz1sqRe6ConZI76ntTO3Np9tzKEu2DW/65J9Tac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724627804; c=relaxed/simple;
	bh=2CNvuJq1jafYAbeh8wn7nMoNRj0jb1xrtZcIn4eeKrA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=L5+r3O9EeEwFDHYkifCr3ORdtzzpL81Kg+a8dwOni/CGD3pViPQN2CyXq+oN9F9F2Gi8Q00av59qimLez37YCTxIxdUVQRCIaiqam6kqjOx7flzd0y0eK6o7ILFcK5TGdsP6a01g8qDFf+X/P7Nmg+1i+CLSDamArm8rN+YXYBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=email.ucr.edu; spf=pass smtp.mailfrom=ucr.edu; dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=EJiH5qul; dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=VJ3Zlz3G; arc=none smtp.client-ip=138.23.62.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=email.ucr.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucr.edu
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1724627801; x=1756163801;
  h=dkim-signature:x-google-dkim-signature:
   x-forwarded-encrypted:x-gm-message-state:
   x-google-smtp-source:mime-version:from:date:message-id:
   subject:to:content-type:x-cse-connectionguid:
   x-cse-msgguid;
  bh=2CNvuJq1jafYAbeh8wn7nMoNRj0jb1xrtZcIn4eeKrA=;
  b=EJiH5qulLGg1Y7rMdnyIsx6ZHiUjh4UIf2EDmR8wiRg8br0suCh0SJSd
   2QASW8SIaZzlKayoaADMhk66zdcfP+ZYpOprElpd+YnaLL1Um45kN+SyK
   M0lAjSu7xXkFOoApoCup09S/Q6mCN5+kExQ3mhrcOMZhnnFx7V/4G0G49
   pXywbUYK6AibD3tUFBD3HE/UqDOK9dIh2mRFCBbyKfH0T3dYO3COkvAWQ
   wPrI8H6qCd/eHi3hJ2NWPcUtQxUIEVnTNxFaPwEhaLPD11xVPUTu27IOQ
   jLJgRB3NF9NGYbQr84LgvJ06wlkHElsL+b5kwwVCvjKY7RcgdlWz4Bj3c
   Q==;
X-CSE-ConnectionGUID: thXjDsGBRRq/qnDNzeupaQ==
X-CSE-MsgGUID: c+iieBouSh6sNHz0WBCgzA==
Received: from mail-io1-f70.google.com ([209.85.166.70])
  by smtpmx5.ucr.edu with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 25 Aug 2024 16:16:34 -0700
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-827878b9901so216325839f.0
        for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 16:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail; t=1724627795; x=1725232595; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=x0xeq6LpLklBK0yaWgq6Z7AiPH7nzjCfoeVbCly1dPI=;
        b=VJ3Zlz3GYWlDgYr5ADazNEIQOJD7B3r7O3qpXAGLAIMX0skledIHO/L0vszO9IUy2Y
         q5NUTWur4hqlhe0ZIGZE168tHnFbUJHW2og3MmWI4yemYSrL+rvogbkZrW5jE5BD1Ft3
         32+5uTw2aZpYCT1xivb17ksanVhKZMoNet3yw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724627795; x=1725232595;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x0xeq6LpLklBK0yaWgq6Z7AiPH7nzjCfoeVbCly1dPI=;
        b=FiPXebK5/LyXrwcMBn2hBny3FSw3IKN4lPKpiJexsNQQbdYoZb60MAIWNwdiAfRRto
         KaWqSnl4oJpKsBajHOwB89o2jphjmkmlhjaR8JreInHOYJwB293dCvjZK/BwqqhWFiqQ
         LOGZqvKTwL+fYMV5wp6D97e7JMIbGSHbewPY5RbGSEJA6IKx5+9DC5vOo3eG81hkl4DL
         loxzFFbEvG/+clRrbQKLHxGL7xqBenum51dQenM78/aUb23xhqL0Fyh1fRiyVhFxQZvO
         oezf60Srrq+reN2alE9FYo+iyHT+jP/JI6o+thqnRNEgTzIzHPCVXGsMXwzDFNJ3yCLV
         bjHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFi6wbtswiAwF8UCdFDqwBBpECOGfKIC1AqfqTy+iTB658eqbrWG0+rVLYMq25PWbaJCbe4ZO8GVr3KcI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4gx8KthBUoTpvPtk+ohd1TBLujps5hn41QwvI3SE7nCshHZAb
	U1mXkxTIQ5v4y08VAK5XkvWyCSRJgsULvNho54roVIJht9rUfiDwlMKPtlGGb5I1rVMOsNIANpy
	K3IPD4BzdHsQlSqYUmKgU1XhmFc1du9/kYNQBDeMmV+a6zcgqYlMmUR7Dl1livXJ5OWBr5bC2PL
	pLpxte5cAhgFTQEzrG3JVIx2hxAPmYzquoKUx7EMaIE3ixzGDmr8c=
X-Received: by 2002:a05:6602:1352:b0:825:3a02:f935 with SMTP id ca18e2360f4ac-827873805c3mr989513239f.11.1724627795431;
        Sun, 25 Aug 2024 16:16:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFf4oYB0J0RiZ4aQ6UuDDbdCNUz/lDpfALZb2UqkV3vRHfpsNSY1rESUgPEICLgYpPlagJOqmk4p8VZNF4NyQ0=
X-Received: by 2002:a05:6602:1352:b0:825:3a02:f935 with SMTP id
 ca18e2360f4ac-827873805c3mr989512139f.11.1724627795063; Sun, 25 Aug 2024
 16:16:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Juefei Pu <juefei.pu@email.ucr.edu>
Date: Sun, 25 Aug 2024 16:16:23 -0700
Message-ID: <CANikGpfCepF2ds27yZc64i5T4P+MTjt4LCY7_rQ+zmSYmNZZWw@mail.gmail.com>
Subject: BUG: WARNING: ODEBUG bug in addrconf_ifdown
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,
We found the following issue using syzkaller on Linux v6.10.
In `addrconf_ifdown`, an ODEBUG warning was triggered when executing
`addrconf_del_rs_timer(idev)`. It seems that the function was called
without checking whether `idev`'s rs_timer is initialized.

Unfortunately, the syzkaller failed to generate a reproducer.
But at least we have the report:

netdevsim netdevsim0 netdevsim1 (unregistering): unset [1, 0] type 2
family 0 port 6081 - 0
------------[ cut here ]------------
ODEBUG: assert_init not available (active state 0) object:
ffff88801f4a6708 object type: timer_list hint:
addrconf_rs_timer+0x0/0x650
WARNING: CPU: 0 PID: 2798 at lib/debugobjects.c:517
debug_print_object+0x176/0x1e0 lib/debugobjects.c:514
Modules linked in:
CPU: 0 PID: 2798 Comm: kworker/u4:8 Not tainted 6.10.0 #13
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
Workqueue: netns cleanup_net
RIP: 0010:debug_print_object+0x176/0x1e0 lib/debugobjects.c:514
Code: df e8 6e e9 95 fd 4c 8b 0b 48 c7 c7 a0 61 a9 8b 48 8b 74 24 08
48 89 ea 44 89 e1 4d 89 f8 ff 34 24 e8 de 2c f7 fc 48 83 c4 08 <0f> 0b
ff 05 42 1e c6 0a 48 83 c4 10 5b 41 5c 41 5d 41 5e 41 5f 5d
RSP: 0000:ffffc900096e7058 EFLAGS: 00010282
RAX: f1e16416dd78e800 RBX: ffffffff8b4ee740 RCX: ffff888025689e00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffffff8ba96360 R08: ffffffff8155a25a R09: 1ffff1100c74519a
R10: dffffc0000000000 R11: ffffed100c74519b R12: 0000000000000000
R13: ffffffff8ba96248 R14: dffffc0000000000 R15: ffff88801f4a6708
FS:  0000000000000000(0000) GS:ffff888063a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f48b94e9080 CR3: 000000000d932000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 debug_object_assert_init+0x35f/0x420 lib/debugobjects.c:910
 debug_timer_assert_init kernel/time/timer.c:846 [inline]
 debug_assert_init kernel/time/timer.c:891 [inline]
 __timer_delete kernel/time/timer.c:1413 [inline]
 timer_delete+0x98/0x150 kernel/time/timer.c:1453
 del_timer include/linux/timer.h:202 [inline]
 addrconf_del_rs_timer net/ipv6/addrconf.c:315 [inline]
 addrconf_ifdown+0x6dd/0x1b50 net/ipv6/addrconf.c:3914
 addrconf_notify+0x3c4/0x1000
 notifier_call_chain kernel/notifier.c:93 [inline]
 raw_notifier_call_chain+0xe0/0x180 kernel/notifier.c:461
 call_netdevice_notifiers_extack net/core/dev.c:2030 [inline]
 call_netdevice_notifiers net/core/dev.c:2044 [inline]
 dev_close_many+0x352/0x4e0 net/core/dev.c:1585
 unregister_netdevice_many_notify+0x542/0x16d0 net/core/dev.c:11194
 unregister_netdevice_many net/core/dev.c:11277 [inline]
 unregister_netdevice_queue+0x2ff/0x370 net/core/dev.c:11156
 unregister_netdevice include/linux/netdevice.h:3119 [inline]
 nsim_destroy+0x17c/0x5b0 drivers/net/netdevsim/netdev.c:778
 __nsim_dev_port_del+0x14a/0x1b0 drivers/net/netdevsim/dev.c:1425
 nsim_dev_port_del_all drivers/net/netdevsim/dev.c:1437 [inline]
 nsim_dev_reload_destroy+0x282/0x480 drivers/net/netdevsim/dev.c:1658
 nsim_dev_reload_down+0x93/0xc0 drivers/net/netdevsim/dev.c:965
 devlink_reload+0x188/0x840 net/devlink/dev.c:461
 devlink_pernet_pre_exit+0x1ee/0x440 net/devlink/core.c:509
 ops_pre_exit_list net/core/net_namespace.c:163 [inline]
 cleanup_net+0x61e/0xcd0 net/core/net_namespace.c:620
 process_one_work kernel/workqueue.c:3248 [inline]
 process_scheduled_works+0x977/0x1410 kernel/workqueue.c:3329
 worker_thread+0xaa0/0x1020 kernel/workqueue.c:3409
 kthread+0x2eb/0x380 kernel/kthread.c:389
 ret_from_fork+0x49/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:244
 </TASK>


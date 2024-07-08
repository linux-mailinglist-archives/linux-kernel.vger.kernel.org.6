Return-Path: <linux-kernel+bounces-244371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F06392A35B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 14:57:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A66161C21104
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 12:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7613B13342F;
	Mon,  8 Jul 2024 12:57:07 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7113D12FB3B
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 12:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720443426; cv=none; b=FVZjYcwimRqjOv0gOajwTMhq0c5cKNQZgR59zxD3lBY41tbYvaU0FICQqbKvrl0Z6R1RCFUoxIIK1NyjhfOWbXfhPx+y4x9ptjZrw81jJFDseZxE2qu051D3ZkBFaD5j9RvKpjq9vwdrpdPkcKSnqs1ecBfhu5I50VNoA1rlSQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720443426; c=relaxed/simple;
	bh=doj3obbHJ1UksYfKnN8fVXTA1qZBJxqmiDF49Y36Vew=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=TzzLk4GMtraKfrk3oHSnN5ugFmVp4yAPf4+8fHV0XXAHmxxlQruYk1Ov6Yk3HONeIhio1gPA/JeVVBn6i6tHmj6dlOlOPs90VrqsKoj119FBO+75cd0TdFiTFoNAG60HhcV/8dwR0a7JVqaNpXYcrJSTSp895mA8v7a49QYYq1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7ec0802fd0dso492553639f.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 05:57:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720443423; x=1721048223;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wQezsNTH5jwxErF3ZN+OBzX4oxJfnyXPX/VVU0eZMjM=;
        b=WWlg52GLhhabCxPOg03HR4AsYe0S/z3E35yg88sRduEGIMIY9z3mXEO28w0UaA5yO8
         WholD050D6Hg24mrSfSFOlFL04oZ/pTjPgTUsyR8++z9LUXdoxVixh9DewbOCExO477R
         f18lDnLk5C70RJQ/gCIiLk5pKsqBhSKJuE8YECGsDBHtA4rSueTx2pxyrNXaMb9HO+42
         Lr5TBx7pCkY1gRy3Z1HzFC1uzazvt04rZ/KPv6xa6uxW9yMF31jz/qczoaAGSO8NqhEG
         /KGJJJXvFIThSxQllp9KKj/81TXqBBc8j8IQamXes0NrJ23wLbfLFrTLSh7VAq4v79kD
         1+Mg==
X-Gm-Message-State: AOJu0Yxp4+x4/zp8vnWkKTQmcENA/kGCKTjDCh4xarI96+Bf7cJY/Rwa
	bUatzNX0gmdPj/dBXjFFNTWnjEv4C1B8vdqc4r+X/HePzc3E11l7XJRtwwNx47tetmoglVLjF9G
	e76OnOrNod2awlRJ8vpQt4UJ67C76XiNjUdr+ueyJXT80SD5MxfDDp0Q=
X-Google-Smtp-Source: AGHT+IFao2VTI2vbi0GPu2g1wlKepZyQ+hmPSS6FTYFcr+h5zYbJoiNy6Y35o0Iz/jIyzZb4Adk5/2EWQN8g2FH93rb8bSQmGGvZ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6103:b0:7fb:ff2b:5116 with SMTP id
 ca18e2360f4ac-7fbff2b567bmr21596839f.4.1720443423605; Mon, 08 Jul 2024
 05:57:03 -0700 (PDT)
Date: Mon, 08 Jul 2024 05:57:03 -0700
In-Reply-To: <167e42c556fa9f7e59f8ada1957d17f950befa42.camel@9elements.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001ed7a3061cbbf360@google.com>
Subject: Re: [syzbot] [usb?] INFO: rcu detected stall in schedule_timeout (6)
From: syzbot <syzbot+c793a7eca38803212c61@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, marcello.bauer@9elements.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

ed and is inactive
[    8.065856][    T1] VMCI host device registered (name=3Dvmci, major=3D10=
, minor=3D118)
[    8.067088][    T1] Initialized host personality
[    8.068117][    T1] usbcore: registered new interface driver rtsx_usb
[    8.070125][    T1] usbcore: registered new interface driver viperboard
[    8.071892][    T1] usbcore: registered new interface driver dln2
[    8.073319][    T1] usbcore: registered new interface driver pn533_usb
[    8.078767][    T1] nfcsim 0.2 initialized
[    8.079834][    T1] usbcore: registered new interface driver port100
[    8.081361][    T1] usbcore: registered new interface driver nfcmrvl
[    8.088191][    T1] Loading iSCSI transport class v2.0-870.
[    8.105151][    T1] virtio_scsi virtio0: 1/0/0 default/read/poll queues
[    8.115364][    T1] ------------[ cut here ]------------
[    8.116193][    T1] refcount_t: decrement hit 0; leaking memory.
[    8.117360][    T1] WARNING: CPU: 0 PID: 1 at lib/refcount.c:31 refcount=
_warn_saturate+0xfa/0x1d0
[    8.118807][    T1] Modules linked in:
[    8.119367][    T1] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.9.0-rc2-=
syzkaller-00080-gf9cebdd4b3ae #0
[    8.121072][    T1] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 06/07/2024
[    8.122601][    T1] RIP: 0010:refcount_warn_saturate+0xfa/0x1d0
[    8.123564][    T1] Code: b2 00 00 00 e8 87 a5 e9 fc 5b 5d c3 cc cc cc c=
c e8 7b a5 e9 fc c6 05 a1 6d e7 0a 01 90 48 c7 c7 e0 2d 1f 8c e8 97 22 ac f=
c 90 <0f> 0b 90 90 eb d9 e8 5b a5 e9 fc c6 05 7e 6d e7 0a 01 90 48 c7 c7
[    8.126607][    T1] RSP: 0000:ffffc90000066e18 EFLAGS: 00010246
[    8.127651][    T1] RAX: 9b910bae5b922500 RBX: ffff888020c11c7c RCX: fff=
f8880166d0000
[    8.128884][    T1] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000=
0000000000000
[    8.130007][    T1] RBP: 0000000000000004 R08: ffffffff8157ffc2 R09: fff=
ffbfff1c39af8
[    8.131294][    T1] R10: dffffc0000000000 R11: fffffbfff1c39af8 R12: fff=
fea000083cdc0
[    8.132681][    T1] R13: ffffea000083cdc8 R14: 1ffffd40001079b9 R15: 000=
0000000000000
[    8.133862][    T1] FS:  0000000000000000(0000) GS:ffff8880b9400000(0000=
) knlGS:0000000000000000
[    8.135323][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    8.136308][    T1] CR2: ffff88823ffff000 CR3: 000000000e134000 CR4: 000=
00000003506f0
[    8.137722][    T1] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000=
0000000000000
[    8.138999][    T1] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000=
0000000000400
[    8.140319][    T1] Call Trace:
[    8.140799][    T1]  <TASK>
[    8.141321][    T1]  ? __warn+0x163/0x4e0
[    8.142184][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
[    8.143462][    T1]  ? report_bug+0x2b3/0x500
[    8.144778][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
[    8.145681][    T1]  ? handle_bug+0x3e/0x70
[    8.146414][    T1]  ? exc_invalid_op+0x1a/0x50
[    8.147536][    T1]  ? asm_exc_invalid_op+0x1a/0x20
[    8.148532][    T1]  ? __warn_printk+0x292/0x360
[    8.149212][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
[    8.150077][    T1]  ? refcount_warn_saturate+0xf9/0x1d0
[    8.151091][    T1]  __free_pages_ok+0xc60/0xd90
[    8.151926][    T1]  make_alloc_exact+0xa3/0xf0
[    8.152681][    T1]  vring_alloc_queue_split+0x20a/0x600
[    8.153912][    T1]  ? __pfx_vring_alloc_queue_split+0x10/0x10
[    8.155093][    T1]  ? vp_find_vqs+0x4c/0x4e0
[    8.155873][    T1]  ? virtscsi_probe+0x3ea/0xf60
[    8.156657][    T1]  ? virtio_dev_probe+0x991/0xaf0
[    8.157342][    T1]  ? really_probe+0x2b8/0xad0
[    8.158003][    T1]  ? driver_probe_device+0x50/0x430
[    8.158765][    T1]  vring_create_virtqueue_split+0xc6/0x310
[    8.159700][    T1]  ? ret_from_fork+0x4b/0x80
[    8.160390][    T1]  ? __pfx_vring_create_virtqueue_split+0x10/0x10
[    8.161411][    T1]  vring_create_virtqueue+0xca/0x110
[    8.162280][    T1]  ? __pfx_vp_notify+0x10/0x10
[    8.163017][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    8.163859][    T1]  setup_vq+0xe9/0x2d0
[    8.164548][    T1]  ? __pfx_vp_notify+0x10/0x10
[    8.165381][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    8.166164][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    8.166933][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    8.167732][    T1]  vp_setup_vq+0xbf/0x330
[    8.168623][    T1]  ? __pfx_vp_config_changed+0x10/0x10
[    8.169661][    T1]  ? ioread16+0x2f/0x90
[    8.170432][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    8.171351][    T1]  vp_find_vqs_msix+0x8b2/0xc80
[    8.172139][    T1]  vp_find_vqs+0x4c/0x4e0
[    8.172876][    T1]  virtscsi_init+0x8db/0xd00
[    8.173612][    T1]  ? __pfx_virtscsi_init+0x10/0x10
[    8.174332][    T1]  ? __pfx_default_calc_sets+0x10/0x10
[    8.175242][    T1]  ? scsi_host_alloc+0xa57/0xea0
[    8.176177][    T1]  ? vp_get+0xfd/0x140
[    8.176820][    T1]  virtscsi_probe+0x3ea/0xf60
[    8.177627][    T1]  ? __pfx_virtscsi_probe+0x10/0x10
[    8.178547][    T1]  ? kernfs_add_one+0x156/0x8b0
[    8.179550][    T1]  ? virtio_no_restricted_mem_acc+0x9/0x10
[    8.180421][    T1]  ? virtio_features_ok+0x10c/0x270
[    8.181247][    T1]  virtio_dev_probe+0x991/0xaf0
[    8.181952][    T1]  ? __pfx_virtio_dev_probe+0x10/0x10
[    8.182739][    T1]  really_probe+0x2b8/0xad0
[    8.183450][    T1]  __driver_probe_device+0x1a2/0x390
[    8.184253][    T1]  driver_probe_device+0x50/0x430
[    8.184939][    T1]  __driver_attach+0x45f/0x710
[    8.185658][    T1]  ? __pfx___driver_attach+0x10/0x10
[    8.186422][    T1]  bus_for_each_dev+0x239/0x2b0
[    8.187437][    T1]  ? __pfx___driver_attach+0x10/0x10
[    8.188193][    T1]  ? __pfx_bus_for_each_dev+0x10/0x10
[    8.189040][    T1]  ? do_raw_spin_unlock+0x13c/0x8b0
[    8.189802][    T1]  bus_add_driver+0x347/0x620
[    8.190543][    T1]  driver_register+0x23a/0x320
[    8.191437][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[    8.192230][    T1]  virtio_scsi_init+0x65/0xe0
[    8.192916][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[    8.193751][    T1]  do_one_initcall+0x248/0x880
[    8.194502][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[    8.195284][    T1]  ? __pfx_lockdep_hardirqs_on_prepare+0x10/0x10
[    8.196190][    T1]  ? __pfx_do_one_initcall+0x10/0x10
[    8.197127][    T1]  ? __pfx_parse_args+0x10/0x10
[    8.197999][    T1]  ? do_initcalls+0x1c/0x80
[    8.198670][    T1]  ? rcu_is_watching+0x15/0xb0
[    8.199361][    T1]  do_initcall_level+0x157/0x210
[    8.200179][    T1]  do_initcalls+0x3f/0x80
[    8.200925][    T1]  kernel_init_freeable+0x435/0x5d0
[    8.201758][    T1]  ? __pfx_kernel_init_freeable+0x10/0x10
[    8.202801][    T1]  ? __pfx_lockdep_hardirqs_on_prepare+0x10/0x10
[    8.203709][    T1]  ? __pfx_kernel_init+0x10/0x10
[    8.204550][    T1]  ? __pfx_kernel_init+0x10/0x10
[    8.205234][    T1]  ? __pfx_kernel_init+0x10/0x10
[    8.205954][    T1]  kernel_init+0x1d/0x2b0
[    8.206612][    T1]  ret_from_fork+0x4b/0x80
[    8.207259][    T1]  ? __pfx_kernel_init+0x10/0x10
[    8.208083][    T1]  ret_from_fork_asm+0x1a/0x30
[    8.208765][    T1]  </TASK>
[    8.209243][    T1] Kernel panic - not syncing: kernel: panic_on_warn se=
t ...
[    8.210243][    T1] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.9.0-rc2-=
syzkaller-00080-gf9cebdd4b3ae #0
[    8.210893][    T1] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 06/07/2024
[    8.210893][    T1] Call Trace:
[    8.210893][    T1]  <TASK>
[    8.210893][    T1]  dump_stack_lvl+0x241/0x360
[    8.210893][    T1]  ? __pfx_dump_stack_lvl+0x10/0x10
[    8.210893][    T1]  ? __pfx__printk+0x10/0x10
[    8.210893][    T1]  ? _printk+0xd5/0x120
[    8.210893][    T1]  ? vscnprintf+0x5d/0x90
[    8.210893][    T1]  panic+0x349/0x860
[    8.210893][    T1]  ? __warn+0x172/0x4e0
[    8.210893][    T1]  ? __pfx_panic+0x10/0x10
[    8.210893][    T1]  ? show_trace_log_lvl+0x4e6/0x520
[    8.210893][    T1]  ? ret_from_fork_asm+0x1a/0x30
[    8.210893][    T1]  __warn+0x346/0x4e0
[    8.210893][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
[    8.210893][    T1]  report_bug+0x2b3/0x500
[    8.210893][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
[    8.210893][    T1]  handle_bug+0x3e/0x70
[    8.210893][    T1]  exc_invalid_op+0x1a/0x50
[    8.210893][    T1]  asm_exc_invalid_op+0x1a/0x20
[    8.210893][    T1] RIP: 0010:refcount_warn_saturate+0xfa/0x1d0
[    8.210893][    T1] Code: b2 00 00 00 e8 87 a5 e9 fc 5b 5d c3 cc cc cc c=
c e8 7b a5 e9 fc c6 05 a1 6d e7 0a 01 90 48 c7 c7 e0 2d 1f 8c e8 97 22 ac f=
c 90 <0f> 0b 90 90 eb d9 e8 5b a5 e9 fc c6 05 7e 6d e7 0a 01 90 48 c7 c7
[    8.210893][    T1] RSP: 0000:ffffc90000066e18 EFLAGS: 00010246
[    8.210893][    T1] RAX: 9b910bae5b922500 RBX: ffff888020c11c7c RCX: fff=
f8880166d0000
[    8.210893][    T1] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000=
0000000000000
[    8.210893][    T1] RBP: 0000000000000004 R08: ffffffff8157ffc2 R09: fff=
ffbfff1c39af8
[    8.210893][    T1] R10: dffffc0000000000 R11: fffffbfff1c39af8 R12: fff=
fea000083cdc0
[    8.210893][    T1] R13: ffffea000083cdc8 R14: 1ffffd40001079b9 R15: 000=
0000000000000
[    8.210893][    T1]  ? __warn_printk+0x292/0x360
[    8.210893][    T1]  ? refcount_warn_saturate+0xf9/0x1d0
[    8.210893][    T1]  __free_pages_ok+0xc60/0xd90
[    8.210893][    T1]  make_alloc_exact+0xa3/0xf0
[    8.210893][    T1]  vring_alloc_queue_split+0x20a/0x600
[    8.210893][    T1]  ? __pfx_vring_alloc_queue_split+0x10/0x10
[    8.210893][    T1]  ? vp_find_vqs+0x4c/0x4e0
[    8.210893][    T1]  ? virtscsi_probe+0x3ea/0xf60
[    8.210893][    T1]  ? virtio_dev_probe+0x991/0xaf0
[    8.210893][    T1]  ? really_probe+0x2b8/0xad0
[    8.210893][    T1]  ? driver_probe_device+0x50/0x430
[    8.210893][    T1]  vring_create_virtqueue_split+0xc6/0x310
[    8.251039][    T1]  ? ret_from_fork+0x4b/0x80
[    8.251039][    T1]  ? __pfx_vring_create_virtqueue_split+0x10/0x10
[    8.251039][    T1]  vring_create_virtqueue+0xca/0x110
[    8.251039][    T1]  ? __pfx_vp_notify+0x10/0x10
[    8.251039][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    8.251039][    T1]  setup_vq+0xe9/0x2d0
[    8.251039][    T1]  ? __pfx_vp_notify+0x10/0x10
[    8.251039][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    8.251039][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    8.251039][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    8.251039][    T1]  vp_setup_vq+0xbf/0x330
[    8.251039][    T1]  ? __pfx_vp_config_changed+0x10/0x10
[    8.251039][    T1]  ? ioread16+0x2f/0x90
[    8.251039][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    8.251039][    T1]  vp_find_vqs_msix+0x8b2/0xc80
[    8.251039][    T1]  vp_find_vqs+0x4c/0x4e0
[    8.251039][    T1]  virtscsi_init+0x8db/0xd00
[    8.251039][    T1]  ? __pfx_virtscsi_init+0x10/0x10
[    8.251039][    T1]  ? __pfx_default_calc_sets+0x10/0x10
[    8.251039][    T1]  ? scsi_host_alloc+0xa57/0xea0
[    8.251039][    T1]  ? vp_get+0xfd/0x140
[    8.251039][    T1]  virtscsi_probe+0x3ea/0xf60
[    8.251039][    T1]  ? __pfx_virtscsi_probe+0x10/0x10
[    8.251039][    T1]  ? kernfs_add_one+0x156/0x8b0
[    8.251039][    T1]  ? virtio_no_restricted_mem_acc+0x9/0x10
[    8.251039][    T1]  ? virtio_features_ok+0x10c/0x270
[    8.251039][    T1]  virtio_dev_probe+0x991/0xaf0
[    8.251039][    T1]  ? __pfx_virtio_dev_probe+0x10/0x10
[    8.251039][    T1]  really_probe+0x2b8/0xad0
[    8.251039][    T1]  __driver_probe_device+0x1a2/0x390
[    8.251039][    T1]  driver_probe_device+0x50/0x430
[    8.251039][    T1]  __driver_attach+0x45f/0x710
[    8.251039][    T1]  ? __pfx___driver_attach+0x10/0x10
[    8.251039][    T1]  bus_for_each_dev+0x239/0x2b0
[    8.251039][    T1]  ? __pfx___driver_attach+0x10/0x10
[    8.251039][    T1]  ? __pfx_bus_for_each_dev+0x10/0x10
[    8.251039][    T1]  ? do_raw_spin_unlock+0x13c/0x8b0
[    8.251039][    T1]  bus_add_driver+0x347/0x620
[    8.251039][    T1]  driver_register+0x23a/0x320
[    8.251039][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[    8.251039][    T1]  virtio_scsi_init+0x65/0xe0
[    8.251039][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[    8.251039][    T1]  do_one_initcall+0x248/0x880
[    8.251039][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[    8.301021][    T1]  ? __pfx_lockdep_hardirqs_on_prepare+0x10/0x10
[    8.301021][    T1]  ? __pfx_do_one_initcall+0x10/0x10
[    8.301021][    T1]  ? __pfx_parse_args+0x10/0x10
[    8.301021][    T1]  ? do_initcalls+0x1c/0x80
[    8.301021][    T1]  ? rcu_is_watching+0x15/0xb0
[    8.301021][    T1]  do_initcall_level+0x157/0x210
[    8.301021][    T1]  do_initcalls+0x3f/0x80
[    8.301021][    T1]  kernel_init_freeable+0x435/0x5d0
[    8.301021][    T1]  ? __pfx_kernel_init_freeable+0x10/0x10
[    8.301021][    T1]  ? __pfx_lockdep_hardirqs_on_prepare+0x10/0x10
[    8.301021][    T1]  ? __pfx_kernel_init+0x10/0x10
[    8.301021][    T1]  ? __pfx_kernel_init+0x10/0x10
[    8.301021][    T1]  ? __pfx_kernel_init+0x10/0x10
[    8.301021][    T1]  kernel_init+0x1d/0x2b0
[    8.301021][    T1]  ret_from_fork+0x4b/0x80
[    8.301021][    T1]  ? __pfx_kernel_init+0x10/0x10
[    8.301021][    T1]  ret_from_fork_asm+0x1a/0x30
[    8.301021][    T1]  </TASK>
[    8.301021][    T1] Kernel Offset: disabled
[    8.301021][    T1] Rebooting in 86400 seconds..


syzkaller build log:
go env (err=3D<nil>)
GO111MODULE=3D'auto'
GOARCH=3D'amd64'
GOBIN=3D''
GOCACHE=3D'/syzkaller/.cache/go-build'
GOENV=3D'/syzkaller/.config/go/env'
GOEXE=3D''
GOEXPERIMENT=3D''
GOFLAGS=3D''
GOHOSTARCH=3D'amd64'
GOHOSTOS=3D'linux'
GOINSECURE=3D''
GOMODCACHE=3D'/syzkaller/jobs/linux/gopath/pkg/mod'
GONOPROXY=3D''
GONOSUMDB=3D''
GOOS=3D'linux'
GOPATH=3D'/syzkaller/jobs/linux/gopath'
GOPRIVATE=3D''
GOPROXY=3D'https://proxy.golang.org,direct'
GOROOT=3D'/usr/local/go'
GOSUMDB=3D'sum.golang.org'
GOTMPDIR=3D''
GOTOOLCHAIN=3D'auto'
GOTOOLDIR=3D'/usr/local/go/pkg/tool/linux_amd64'
GOVCS=3D''
GOVERSION=3D'go1.21.4'
GCCGO=3D'gccgo'
GOAMD64=3D'v1'
AR=3D'ar'
CC=3D'gcc'
CXX=3D'g++'
CGO_ENABLED=3D'1'
GOMOD=3D'/syzkaller/jobs/linux/gopath/src/github.com/google/syzkaller/go.mo=
d'
GOWORK=3D''
CGO_CFLAGS=3D'-O2 -g'
CGO_CPPFLAGS=3D''
CGO_CXXFLAGS=3D'-O2 -g'
CGO_FFLAGS=3D'-O2 -g'
CGO_LDFLAGS=3D'-O2 -g'
PKG_CONFIG=3D'pkg-config'
GOGCCFLAGS=3D'-fPIC -m64 -pthread -Wl,--no-gc-sections -fmessage-length=3D0=
 -ffile-prefix-map=3D/tmp/go-build1076745083=3D/tmp/go-build -gno-record-gc=
c-switches'

git status (err=3D<nil>)
HEAD detached at 9026e14289
nothing to commit, working tree clean


tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
Makefile:31: run command via tools/syz-env for best compatibility, see:
Makefile:32: https://github.com/google/syzkaller/blob/master/docs/contribut=
ing.md#using-syz-env
go list -f '{{.Stale}}' ./sys/syz-sysgen | grep -q false || go install ./sy=
s/syz-sysgen
make .descriptions
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
Makefile:31: run command via tools/syz-env for best compatibility, see:
Makefile:32: https://github.com/google/syzkaller/blob/master/docs/contribut=
ing.md#using-syz-env
bin/syz-sysgen
touch .descriptions
GOOS=3Dlinux GOARCH=3Damd64 go build "-ldflags=3D-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3D9026e14289eaf45a00ddddb8730f2092b956d99a -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20240510-174117'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-fuzzer=
 github.com/google/syzkaller/syz-fuzzer
GOOS=3Dlinux GOARCH=3Damd64 go build "-ldflags=3D-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3D9026e14289eaf45a00ddddb8730f2092b956d99a -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20240510-174117'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-execpr=
og github.com/google/syzkaller/tools/syz-execprog
mkdir -p ./bin/linux_amd64
gcc -o ./bin/linux_amd64/syz-executor executor/executor.cc \
	-m64 -std=3Dc++11 -I. -Iexecutor/_include -O2 -pthread -Wall -Werror -Wpar=
entheses -Wunused-const-variable -Wframe-larger-than=3D16384 -Wno-stringop-=
overflow -Wno-array-bounds -Wno-format-overflow -Wno-unused-but-set-variabl=
e -Wno-unused-command-line-argument -static-pie -fpermissive -w -DGOOS_linu=
x=3D1 -DGOARCH_amd64=3D1 \
	-DHOSTGOOS_linux=3D1 -DGIT_REVISION=3D\"9026e14289eaf45a00ddddb8730f2092b9=
56d99a\"


Error text is too large and was truncated, full error text is at:
https://syzkaller.appspot.com/x/error.txt?x=3D12219041980000


Tested on:

commit:         f9cebdd4 usb: gadget: dummy_hcd: make hrtimer expire i..
git tree:       https://github.com/9elements/linux.git test_patch_dummy_hcd=
_hrtimer_fix
kernel config:  https://syzkaller.appspot.com/x/.config?x=3D12fe7aa3e6d549f=
1
dashboard link: https://syzkaller.appspot.com/bug?extid=3Dc793a7eca38803212=
c61
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debia=
n) 2.40

Note: no patches were applied.


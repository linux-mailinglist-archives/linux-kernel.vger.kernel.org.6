Return-Path: <linux-kernel+bounces-181529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 586678C7D21
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 21:25:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8C192813AE
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 19:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FD8C156F42;
	Thu, 16 May 2024 19:25:08 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4857DD271
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 19:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715887507; cv=none; b=rhxfr5cLOViDl8VzydOyAcrAtKLerT0e4I2aJMs8Zsy2FjPYVxa2iFGXc9cS5u6qOC69mniv++qCJIUTQlyjc3EHmj838kbeKQxwKT8CzYmC0TvDppM2/2S5iFHPCQvuUQk2n6gWlDsfUHxhbCkTww/Cf9DU115ZDP2asLkAUP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715887507; c=relaxed/simple;
	bh=DjY8wqIbZWkZJAj7CD4HsKugS8kU3e9wJE8YeKP8XGQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=PnB3pW6weHmmxBXyC31tiN3zvQ1P2ZqyuUqGLIHr9DlcovUxxwq5tnrZV9d967vz8cCMb7qSygcNWpFHZv9/tZ9BwHrw+BfBi/H2JvZMILAyYaHKFseaWnt0Og5LHXgX4+hXg1tzzybV+qkWEQI4bVCBKAeXKvh3YdGTvZfLWtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7e1d807cfbaso651354539f.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 12:25:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715887504; x=1716492304;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sYOlTGYV7bLR9MdzqfXtlPNNmqvPyJ3mRt7v4BUQkSs=;
        b=kO5l59P5Nlg1shdpXomzNW0nbiB8BsQ0Ol+j/cKXCObtyTN67E/YVgDjA1VcbOcpON
         anFTD2b0EYso7NYbvLXlEpulqCPIF5D3zBZCdDNb0Sf2mrQcwHTyfqaUO9ecC86NB8b8
         smbGf38DlfaNlT1K7CawS2RdsdC1UqdIos0SsYU1jy1LGR8QG7Lo3ZlXcqsuuM2HJX/g
         qU5xUq3bJPSbse7dV9tmLEF0el8OIZxvDxIwG+unMoj1Z9J+M5fP4T0iv8prIPy4Rs6o
         hy5Jbv6IHjrYhPXs4SVsluzC6YK4BKcNrqMO1Jp76h8wXkt6gS+CczuZPM2bEfXQuuq5
         779Q==
X-Gm-Message-State: AOJu0YzKc03yttbjKOT14HKujVg1brvSByfhqrjhLhBzPKw5tveRVi/3
	UOSbyh7rFgL6Ows7scOOgsQYKR/CeI7IaKZ04O+BEHbLqEukdqObPApKUZS79l9OAF1gCt5kp+Z
	pQ62ZrnHZAdBDiltAhZVGZYmyfiqM4RaSiCLcEIGjit0vJ1h5Q6K8Vhs=
X-Google-Smtp-Source: AGHT+IEuQk52HYty4mTAFd5hFF6hnxU66zOJEXEaJUgYCVWa+ax2Q7mCe6nq57bbKO49xjAG7RrcygETNRrshvy5l83J+VcznBLp
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:210d:b0:488:c345:73bf with SMTP id
 8926c6da1cb9f-48958576d7dmr1659249173.1.1715887504479; Thu, 16 May 2024
 12:25:04 -0700 (PDT)
Date: Thu, 16 May 2024 12:25:04 -0700
In-Reply-To: <20240516183454.GA287325@mit.edu>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002de17706189731fd@google.com>
Subject: Re: [syzbot] [ext4?] KASAN: use-after-free Read in
 __ext4_check_dir_entry (2)
From: syzbot <syzbot+11af34d3c0711f233fd4@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

[    T1] Guest personality initialized and is inactive
[    8.065736][    T1] VMCI host device registered (name=3Dvmci, major=3D10=
, minor=3D118)
[    8.066898][    T1] Initialized host personality
[    8.067968][    T1] usbcore: registered new interface driver rtsx_usb
[    8.069719][    T1] usbcore: registered new interface driver viperboard
[    8.071465][    T1] usbcore: registered new interface driver dln2
[    8.073269][    T1] usbcore: registered new interface driver pn533_usb
[    8.080360][    T1] nfcsim 0.2 initialized
[    8.081593][    T1] usbcore: registered new interface driver port100
[    8.083254][    T1] usbcore: registered new interface driver nfcmrvl
[    8.090665][    T1] Loading iSCSI transport class v2.0-870.
[    8.107172][    T1] virtio_scsi virtio0: 1/0/0 default/read/poll queues
[    8.119694][    T1] ------------[ cut here ]------------
[    8.120886][    T1] refcount_t: decrement hit 0; leaking memory.
[    8.122941][    T1] WARNING: CPU: 1 PID: 1 at lib/refcount.c:31 refcount=
_warn_saturate+0xfa/0x1d0
[    8.124604][    T1] Modules linked in:
[    8.125320][    T1] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 6.9.0-rc1-=
syzkaller #0
[    8.127017][    T1] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 04/02/2024
[    8.128730][    T1] RIP: 0010:refcount_warn_saturate+0xfa/0x1d0
[    8.129741][    T1] Code: b2 00 00 00 e8 57 79 f2 fc 5b 5d c3 cc cc cc c=
c e8 4b 79 f2 fc c6 05 01 fb ce 0a 01 90 48 c7 c7 e0 54 fe 8b e8 a7 f7 b4 f=
c 90 <0f> 0b 90 90 eb d9 e8 2b 79 f2 fc c6 05 de fa ce 0a 01 90 48 c7 c7
[    8.133290][    T1] RSP: 0000:ffffc90000066e18 EFLAGS: 00010246
[    8.134369][    T1] RAX: b8e9523c774d7100 RBX: ffff8880203d0a8c RCX: fff=
f8880166c8000
[    8.135762][    T1] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000=
0000000000000
[    8.137141][    T1] RBP: 0000000000000004 R08: ffffffff8157ffe2 R09: fff=
ffbfff1bf96e0
[    8.138764][    T1] R10: dffffc0000000000 R11: fffffbfff1bf96e0 R12: fff=
fea000502edc0
[    8.141948][    T1] R13: ffffea000502edc8 R14: 1ffffd4000a05db9 R15: 000=
0000000000000
[    8.144186][    T1] FS:  0000000000000000(0000) GS:ffff8880b9500000(0000=
) knlGS:0000000000000000
[    8.146310][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    8.147355][    T1] CR2: 0000000000000000 CR3: 000000000df32000 CR4: 000=
00000003506f0
[    8.149092][    T1] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000=
0000000000000
[    8.150505][    T1] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000=
0000000000400
[    8.151931][    T1] Call Trace:
[    8.152557][    T1]  <TASK>
[    8.153004][    T1]  ? __warn+0x163/0x4e0
[    8.154626][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
[    8.156204][    T1]  ? report_bug+0x2b3/0x500
[    8.156899][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
[    8.158521][    T1]  ? handle_bug+0x3e/0x70
[    8.159414][    T1]  ? exc_invalid_op+0x1a/0x50
[    8.160449][    T1]  ? asm_exc_invalid_op+0x1a/0x20
[    8.161415][    T1]  ? __warn_printk+0x292/0x360
[    8.162726][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
[    8.164466][    T1]  ? refcount_warn_saturate+0xf9/0x1d0
[    8.165736][    T1]  __free_pages_ok+0xc54/0xd80
[    8.166494][    T1]  make_alloc_exact+0xa3/0xf0
[    8.167154][    T1]  vring_alloc_queue_split+0x20a/0x600
[    8.168021][    T1]  ? __pfx_vring_alloc_queue_split+0x10/0x10
[    8.168973][    T1]  ? vp_find_vqs+0x4c/0x4e0
[    8.169799][    T1]  ? virtscsi_probe+0x3ea/0xf60
[    8.170503][    T1]  ? virtio_dev_probe+0x991/0xaf0
[    8.172229][    T1]  ? really_probe+0x2b8/0xad0
[    8.173145][    T1]  ? driver_probe_device+0x50/0x430
[    8.175331][    T1]  vring_create_virtqueue_split+0xc6/0x310
[    8.176580][    T1]  ? ret_from_fork+0x4b/0x80
[    8.177623][    T1]  ? __pfx_vring_create_virtqueue_split+0x10/0x10
[    8.178852][    T1]  vring_create_virtqueue+0xca/0x110
[    8.179950][    T1]  ? __pfx_vp_notify+0x10/0x10
[    8.181275][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    8.182572][    T1]  setup_vq+0xe9/0x2d0
[    8.184410][    T1]  ? __pfx_vp_notify+0x10/0x10
[    8.185361][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    8.186662][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    8.188204][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    8.190228][    T1]  vp_setup_vq+0xbf/0x330
[    8.191078][    T1]  ? __pfx_vp_config_changed+0x10/0x10
[    8.192362][    T1]  ? ioread16+0x2f/0x90
[    8.193064][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    8.194742][    T1]  vp_find_vqs_msix+0x8b2/0xc80
[    8.196215][    T1]  vp_find_vqs+0x4c/0x4e0
[    8.197081][    T1]  virtscsi_init+0x8db/0xd00
[    8.198316][    T1]  ? __pfx_virtscsi_init+0x10/0x10
[    8.200122][    T1]  ? __pfx_default_calc_sets+0x10/0x10
[    8.200874][    T1]  ? scsi_host_alloc+0xa57/0xea0
[    8.201727][    T1]  ? vp_get+0xfd/0x140
[    8.202349][    T1]  virtscsi_probe+0x3ea/0xf60
[    8.203024][    T1]  ? __pfx_virtscsi_probe+0x10/0x10
[    8.204543][    T1]  ? kernfs_add_one+0x156/0x8b0
[    8.205433][    T1]  ? virtio_no_restricted_mem_acc+0x9/0x10
[    8.206402][    T1]  ? virtio_features_ok+0x10c/0x270
[    8.207289][    T1]  virtio_dev_probe+0x991/0xaf0
[    8.208213][    T1]  ? __pfx_virtio_dev_probe+0x10/0x10
[    8.209222][    T1]  really_probe+0x2b8/0xad0
[    8.210139][    T1]  __driver_probe_device+0x1a2/0x390
[    8.210945][    T1]  driver_probe_device+0x50/0x430
[    8.211643][    T1]  __driver_attach+0x45f/0x710
[    8.212336][    T1]  ? __pfx___driver_attach+0x10/0x10
[    8.214017][    T1]  bus_for_each_dev+0x239/0x2b0
[    8.215024][    T1]  ? __pfx___driver_attach+0x10/0x10
[    8.216260][    T1]  ? __pfx_bus_for_each_dev+0x10/0x10
[    8.217520][    T1]  ? do_raw_spin_unlock+0x13c/0x8b0
[    8.218492][    T1]  bus_add_driver+0x347/0x620
[    8.219338][    T1]  driver_register+0x23a/0x320
[    8.220395][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[    8.221416][    T1]  virtio_scsi_init+0x65/0xe0
[    8.222076][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[    8.222889][    T1]  do_one_initcall+0x248/0x880
[    8.223972][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[    8.225067][    T1]  ? __pfx_lockdep_hardirqs_on_prepare+0x10/0x10
[    8.226207][    T1]  ? __pfx_do_one_initcall+0x10/0x10
[    8.227041][    T1]  ? __pfx_parse_args+0x10/0x10
[    8.227810][    T1]  ? do_initcalls+0x1c/0x80
[    8.228630][    T1]  ? rcu_is_watching+0x15/0xb0
[    8.229515][    T1]  do_initcall_level+0x157/0x210
[    8.230699][    T1]  do_initcalls+0x3f/0x80
[    8.231545][    T1]  kernel_init_freeable+0x435/0x5d0
[    8.232482][    T1]  ? __pfx_kernel_init_freeable+0x10/0x10
[    8.233398][    T1]  ? __pfx_lockdep_hardirqs_on_prepare+0x10/0x10
[    8.234520][    T1]  ? __pfx_kernel_init+0x10/0x10
[    8.236078][    T1]  ? __pfx_kernel_init+0x10/0x10
[    8.236866][    T1]  ? __pfx_kernel_init+0x10/0x10
[    8.237618][    T1]  kernel_init+0x1d/0x2b0
[    8.238281][    T1]  ret_from_fork+0x4b/0x80
[    8.238919][    T1]  ? __pfx_kernel_init+0x10/0x10
[    8.239745][    T1]  ret_from_fork_asm+0x1a/0x30
[    8.240541][    T1]  </TASK>
[    8.241009][    T1] Kernel panic - not syncing: kernel: panic_on_warn se=
t ...
[    8.241978][    T1] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 6.9.0-rc1-=
syzkaller #0
[    8.243074][    T1] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 04/02/2024
[    8.244259][    T1] Call Trace:
[    8.244259][    T1]  <TASK>
[    8.244259][    T1]  dump_stack_lvl+0x241/0x360
[    8.244259][    T1]  ? __pfx_dump_stack_lvl+0x10/0x10
[    8.244259][    T1]  ? __pfx__printk+0x10/0x10
[    8.244259][    T1]  ? _printk+0xd5/0x120
[    8.244259][    T1]  ? vscnprintf+0x5d/0x90
[    8.244259][    T1]  panic+0x349/0x860
[    8.244259][    T1]  ? __warn+0x172/0x4e0
[    8.244259][    T1]  ? __pfx_panic+0x10/0x10
[    8.244259][    T1]  ? show_trace_log_lvl+0x4e6/0x520
[    8.244259][    T1]  ? ret_from_fork_asm+0x1a/0x30
[    8.244259][    T1]  __warn+0x346/0x4e0
[    8.253569][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
[    8.253569][    T1]  report_bug+0x2b3/0x500
[    8.253569][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
[    8.253569][    T1]  handle_bug+0x3e/0x70
[    8.253569][    T1]  exc_invalid_op+0x1a/0x50
[    8.253569][    T1]  asm_exc_invalid_op+0x1a/0x20
[    8.253569][    T1] RIP: 0010:refcount_warn_saturate+0xfa/0x1d0
[    8.253569][    T1] Code: b2 00 00 00 e8 57 79 f2 fc 5b 5d c3 cc cc cc c=
c e8 4b 79 f2 fc c6 05 01 fb ce 0a 01 90 48 c7 c7 e0 54 fe 8b e8 a7 f7 b4 f=
c 90 <0f> 0b 90 90 eb d9 e8 2b 79 f2 fc c6 05 de fa ce 0a 01 90 48 c7 c7
[    8.253569][    T1] RSP: 0000:ffffc90000066e18 EFLAGS: 00010246
[    8.263675][    T1] RAX: b8e9523c774d7100 RBX: ffff8880203d0a8c RCX: fff=
f8880166c8000
[    8.263675][    T1] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000=
0000000000000
[    8.263675][    T1] RBP: 0000000000000004 R08: ffffffff8157ffe2 R09: fff=
ffbfff1bf96e0
[    8.263675][    T1] R10: dffffc0000000000 R11: fffffbfff1bf96e0 R12: fff=
fea000502edc0
[    8.263675][    T1] R13: ffffea000502edc8 R14: 1ffffd4000a05db9 R15: 000=
0000000000000
[    8.263675][    T1]  ? __warn_printk+0x292/0x360
[    8.263675][    T1]  ? refcount_warn_saturate+0xf9/0x1d0
[    8.263675][    T1]  __free_pages_ok+0xc54/0xd80
[    8.273618][    T1]  make_alloc_exact+0xa3/0xf0
[    8.273618][    T1]  vring_alloc_queue_split+0x20a/0x600
[    8.273618][    T1]  ? __pfx_vring_alloc_queue_split+0x10/0x10
[    8.273618][    T1]  ? vp_find_vqs+0x4c/0x4e0
[    8.273618][    T1]  ? virtscsi_probe+0x3ea/0xf60
[    8.273618][    T1]  ? virtio_dev_probe+0x991/0xaf0
[    8.273618][    T1]  ? really_probe+0x2b8/0xad0
[    8.273618][    T1]  ? driver_probe_device+0x50/0x430
[    8.273618][    T1]  vring_create_virtqueue_split+0xc6/0x310
[    8.273618][    T1]  ? ret_from_fork+0x4b/0x80
[    8.273618][    T1]  ? __pfx_vring_create_virtqueue_split+0x10/0x10
[    8.283681][    T1]  vring_create_virtqueue+0xca/0x110
[    8.283681][    T1]  ? __pfx_vp_notify+0x10/0x10
[    8.283681][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    8.283681][    T1]  setup_vq+0xe9/0x2d0
[    8.283681][    T1]  ? __pfx_vp_notify+0x10/0x10
[    8.283681][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    8.283681][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    8.283681][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    8.283681][    T1]  vp_setup_vq+0xbf/0x330
[    8.293704][    T1]  ? __pfx_vp_config_changed+0x10/0x10
[    8.293704][    T1]  ? ioread16+0x2f/0x90
[    8.293704][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    8.293704][    T1]  vp_find_vqs_msix+0x8b2/0xc80
[    8.293704][    T1]  vp_find_vqs+0x4c/0x4e0
[    8.293704][    T1]  virtscsi_init+0x8db/0xd00
[    8.293704][    T1]  ? __pfx_virtscsi_init+0x10/0x10
[    8.293704][    T1]  ? __pfx_default_calc_sets+0x10/0x10
[    8.293704][    T1]  ? scsi_host_alloc+0xa57/0xea0
[    8.293704][    T1]  ? vp_get+0xfd/0x140
[    8.293704][    T1]  virtscsi_probe+0x3ea/0xf60
[    8.303715][    T1]  ? __pfx_virtscsi_probe+0x10/0x10
[    8.303715][    T1]  ? kernfs_add_one+0x156/0x8b0
[    8.303715][    T1]  ? virtio_no_restricted_mem_acc+0x9/0x10
[    8.303715][    T1]  ? virtio_features_ok+0x10c/0x270
[    8.303715][    T1]  virtio_dev_probe+0x991/0xaf0
[    8.303715][    T1]  ? __pfx_virtio_dev_probe+0x10/0x10
[    8.303715][    T1]  really_probe+0x2b8/0xad0
[    8.303715][    T1]  __driver_probe_device+0x1a2/0x390
[    8.303715][    T1]  driver_probe_device+0x50/0x430
[    8.303715][    T1]  __driver_attach+0x45f/0x710
[    8.303715][    T1]  ? __pfx___driver_attach+0x10/0x10
[    8.313586][    T1]  bus_for_each_dev+0x239/0x2b0
[    8.313586][    T1]  ? __pfx___driver_attach+0x10/0x10
[    8.313586][    T1]  ? __pfx_bus_for_each_dev+0x10/0x10
[    8.313586][    T1]  ? do_raw_spin_unlock+0x13c/0x8b0
[    8.313586][    T1]  bus_add_driver+0x347/0x620
[    8.313586][    T1]  driver_register+0x23a/0x320
[    8.313586][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[    8.313586][    T1]  virtio_scsi_init+0x65/0xe0
[    8.313586][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[    8.313586][    T1]  do_one_initcall+0x248/0x880
[    8.313586][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[    8.323752][    T1]  ? __pfx_lockdep_hardirqs_on_prepare+0x10/0x10
[    8.323752][    T1]  ? __pfx_do_one_initcall+0x10/0x10
[    8.323752][    T1]  ? __pfx_parse_args+0x10/0x10
[    8.323752][    T1]  ? do_initcalls+0x1c/0x80
[    8.323752][    T1]  ? rcu_is_watching+0x15/0xb0
[    8.323752][    T1]  do_initcall_level+0x157/0x210
[    8.323752][    T1]  do_initcalls+0x3f/0x80
[    8.323752][    T1]  kernel_init_freeable+0x435/0x5d0
[    8.323752][    T1]  ? __pfx_kernel_init_freeable+0x10/0x10
[    8.323752][    T1]  ? __pfx_lockdep_hardirqs_on_prepare+0x10/0x10
[    8.323752][    T1]  ? __pfx_kernel_init+0x10/0x10
[    8.333607][    T1]  ? __pfx_kernel_init+0x10/0x10
[    8.333607][    T1]  ? __pfx_kernel_init+0x10/0x10
[    8.333607][    T1]  kernel_init+0x1d/0x2b0
[    8.333607][    T1]  ret_from_fork+0x4b/0x80
[    8.333607][    T1]  ? __pfx_kernel_init+0x10/0x10
[    8.333607][    T1]  ret_from_fork_asm+0x1a/0x30
[    8.333607][    T1]  </TASK>
[    8.333607][    T1] Kernel Offset: disabled
[    8.333607][    T1] Rebooting in 86400 seconds..


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
GOMODCACHE=3D'/syzkaller/jobs-2/linux/gopath/pkg/mod'
GONOPROXY=3D''
GONOSUMDB=3D''
GOOS=3D'linux'
GOPATH=3D'/syzkaller/jobs-2/linux/gopath'
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
GOMOD=3D'/syzkaller/jobs-2/linux/gopath/src/github.com/google/syzkaller/go.=
mod'
GOWORK=3D''
CGO_CFLAGS=3D'-O2 -g'
CGO_CPPFLAGS=3D''
CGO_CXXFLAGS=3D'-O2 -g'
CGO_FFLAGS=3D'-O2 -g'
CGO_LDFLAGS=3D'-O2 -g'
PKG_CONFIG=3D'pkg-config'
GOGCCFLAGS=3D'-fPIC -m64 -pthread -Wl,--no-gc-sections -fmessage-length=3D0=
 -ffile-prefix-map=3D/tmp/go-build414264796=3D/tmp/go-build -gno-record-gcc=
-switches'

git status (err=3D<nil>)
HEAD detached at de979bc20
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
/syzkaller/prog.GitRevision=3Dde979bc20b2b73242b7d6fbbdf614a8cb4c574f4 -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20240509-085021'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-fuzzer=
 github.com/google/syzkaller/syz-fuzzer
GOOS=3Dlinux GOARCH=3Damd64 go build "-ldflags=3D-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3Dde979bc20b2b73242b7d6fbbdf614a8cb4c574f4 -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20240509-085021'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-execpr=
og github.com/google/syzkaller/tools/syz-execprog
mkdir -p ./bin/linux_amd64
gcc -o ./bin/linux_amd64/syz-executor executor/executor.cc \
	-m64 -std=3Dc++11 -I. -Iexecutor/_include -O2 -pthread -Wall -Werror -Wpar=
entheses -Wunused-const-variable -Wframe-larger-than=3D16384 -Wno-stringop-=
overflow -Wno-array-bounds -Wno-format-overflow -Wno-unused-but-set-variabl=
e -Wno-unused-command-line-argument -static-pie -fpermissive -w -DGOOS_linu=
x=3D1 -DGOARCH_amd64=3D1 \
	-DHOSTGOOS_linux=3D1 -DGIT_REVISION=3D\"de979bc20b2b73242b7d6fbbdf614a8cb4=
c574f4\"


Error text is too large and was truncated, full error text is at:
https://syzkaller.appspot.com/x/error.txt?x=3D15f49684980000


Tested on:

commit:         4cece764 Linux 6.9-rc1
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.gi=
t origin
kernel config:  https://syzkaller.appspot.com/x/.config?x=3De98db3f73f65c23=
2
dashboard link: https://syzkaller.appspot.com/bug?extid=3D11af34d3c0711f233=
fd4
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debia=
n) 2.40

Note: no patches were applied.


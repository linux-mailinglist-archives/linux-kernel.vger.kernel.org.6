Return-Path: <linux-kernel+bounces-180503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D1F18C6F60
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 02:01:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A66A1F232AA
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 00:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A70E37E1;
	Thu, 16 May 2024 00:01:06 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9CC819F
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 00:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715817665; cv=none; b=YAWi1jVcFVEx4syzRNXgaW0KXlgt27H3cG1pXwCduy7YyAdcAWE8It6Nsx6CHJJQfJFkjw2GRO8DFFtCJEQ9IdRHghDcdyEAPAkI9JbDPKvjfkRW7RNKQiso/s0OW1n3eCwbthhVsqvi2Vqy9Oo6+lw2vGosvr8sp8BoBPqP5bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715817665; c=relaxed/simple;
	bh=4LgWre3vLWtlRT8hVPRmkXufc9U7GB/h/ZENIDGq1yY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=UuiGrGPVnJ5ZHPP9Q53QvisVTj77V9ozYOvXdKcVrdFOJ3dHwRe0npXceCSqpiUpfW606FK1c8zfA6f90LyWfdGRGXYq4wmqj4kCMDVT4E12YH6vtFADoCMqTg+EGKH4yS3LERwoa9GwgxrPlAVbAm42oRi7cXUN8cMihZjvg0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-36db3bbf931so21412155ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 17:01:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715817663; x=1716422463;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t8+KhH7+TQECvhc9HG4tv5yWCZDJF/f0A8DPKlOw1p8=;
        b=hTGaPu3zD9E89HhPHpy30VMwp//4UfQlgBkuohSUOek7HOCBu+n2WFes/lSo6MqCEa
         lnIyYJucCIclhV1sjSu4YO95z9dW0SuSikgwxW5poogDWJGGeceGxrAaBIGDyhkWp21t
         qcKpAU3bt0axAYfzzXg0XxfdZd0NxpZH3xR5IDrzafa7UtIcwrnx8HZjTqqja6cgWMy0
         5GJew9qWJ5WCcoDeayxb0wP+swjLSw3Grn3soU4W9pXHeIrIrJ+JiwZqYdiDLUEIo0qU
         4E6Qg49lyE9ysRViSD9UNPfxqS48xi1RhUsAwWheoWHVoss5kF/XShmOwkhm7J3UEf5Q
         MyXA==
X-Gm-Message-State: AOJu0YwlnFAMCUIOWY9BKQEDgsuta3iDb7ywMRxkFAqnUS4vn3fB+Dpd
	6cipgISjH9mMBicwWngOXs6wSl92L1xO2yU7FlY2lSliY2EyRQPNJ11tHq9ktX5WAoL2FjMSRb5
	9gEAOeN2jinmFzLhaDNNuCqsip3xUzQrXDsw19fn6Kao3hL3GM0xCgYc=
X-Google-Smtp-Source: AGHT+IHINDidc22UNJaOaZcWBZl/yH8Ny1YQ7zwh0aAD6ZlKXCjbWt6zw1dc6KnPDFCMUBLlIuEo5cmP5WXKNdswseMu2KI6VST+
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:d0f:0:b0:36d:a106:18df with SMTP id
 e9e14a558f8ab-36da1061c7fmr2514385ab.4.1715817663034; Wed, 15 May 2024
 17:01:03 -0700 (PDT)
Date: Wed, 15 May 2024 17:01:03 -0700
In-Reply-To: <20240515230145.GB202157@mit.edu>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004e0b1e061886ee54@google.com>
Subject: Re: [syzbot] [ext4?] KASAN: use-after-free Read in
 __ext4_check_dir_entry (2)
From: syzbot <syzbot+11af34d3c0711f233fd4@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

e=3Dvmci, major=3D10, minor=3D118)
[    7.595612][    T1] Initialized host personality
[    7.597261][    T1] usbcore: registered new interface driver rtsx_usb
[    7.599908][    T1] usbcore: registered new interface driver viperboard
[    7.603226][    T1] usbcore: registered new interface driver dln2
[    7.605088][    T1] usbcore: registered new interface driver pn533_usb
[    7.611678][    T1] nfcsim 0.2 initialized
[    7.613262][    T1] usbcore: registered new interface driver port100
[    7.614710][    T1] usbcore: registered new interface driver nfcmrvl
[    7.622445][    T1] Loading iSCSI transport class v2.0-870.
[    7.640265][    T1] virtio_scsi virtio0: 1/0/0 default/read/poll queues
[    7.650480][    T1] ------------[ cut here ]------------
[    7.651656][    T1] refcount_t: decrement hit 0; leaking memory.
[    7.653009][    T1] WARNING: CPU: 0 PID: 1 at lib/refcount.c:31 refcount=
_warn_saturate+0xfa/0x1d0
[    7.654567][    T1] Modules linked in:
[    7.655274][    T1] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.9.0-rc4-=
syzkaller-00039-g26770a717cac #0
[    7.656739][    T1] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 04/02/2024
[    7.658271][    T1] RIP: 0010:refcount_warn_saturate+0xfa/0x1d0
[    7.659267][    T1] Code: b2 00 00 00 e8 57 49 f0 fc 5b 5d c3 cc cc cc c=
c e8 4b 49 f0 fc c6 05 4c 96 ec 0a 01 90 48 c7 c7 40 5d 1e 8c e8 c7 c5 b2 f=
c 90 <0f> 0b 90 90 eb d9 e8 2b 49 f0 fc c6 05 29 96 ec 0a 01 90 48 c7 c7
[    7.662662][    T1] RSP: 0000:ffffc90000066e18 EFLAGS: 00010246
[    7.663683][    T1] RAX: 6a628a5cb0f41700 RBX: ffff8881401ae78c RCX: fff=
f888016ac0000
[    7.665039][    T1] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000=
0000000000000
[    7.666341][    T1] RBP: 0000000000000004 R08: ffffffff81587fc2 R09: fff=
ffbfff1c39b48
[    7.667553][    T1] R10: dffffc0000000000 R11: fffffbfff1c39b48 R12: fff=
fea0000858dc0
[    7.669559][    T1] R13: ffffea0000858dc8 R14: 1ffffd400010b1b9 R15: 000=
0000000000000
[    7.671059][    T1] FS:  0000000000000000(0000) GS:ffff8880b9400000(0000=
) knlGS:0000000000000000
[    7.672346][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    7.673289][    T1] CR2: ffff88823ffff000 CR3: 000000000e134000 CR4: 000=
00000003506f0
[    7.674581][    T1] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000=
0000000000000
[    7.675775][    T1] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000=
0000000000400
[    7.676905][    T1] Call Trace:
[    7.677523][    T1]  <TASK>
[    7.678310][    T1]  ? __warn+0x163/0x4e0
[    7.679650][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
[    7.680990][    T1]  ? report_bug+0x2b3/0x500
[    7.681762][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
[    7.682951][    T1]  ? handle_bug+0x3e/0x70
[    7.683875][    T1]  ? exc_invalid_op+0x1a/0x50
[    7.684757][    T1]  ? asm_exc_invalid_op+0x1a/0x20
[    7.686125][    T1]  ? __warn_printk+0x292/0x360
[    7.687439][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
[    7.688770][    T1]  ? refcount_warn_saturate+0xf9/0x1d0
[    7.689853][    T1]  __free_pages_ok+0xc54/0xd80
[    7.690752][    T1]  make_alloc_exact+0xa3/0xf0
[    7.691436][    T1]  vring_alloc_queue_split+0x20a/0x600
[    7.692294][    T1]  ? __pfx_vring_alloc_queue_split+0x10/0x10
[    7.693145][    T1]  ? vp_find_vqs+0x4c/0x4e0
[    7.693988][    T1]  ? virtscsi_probe+0x3ea/0xf60
[    7.694794][    T1]  ? virtio_dev_probe+0x991/0xaf0
[    7.695541][    T1]  ? really_probe+0x2b8/0xad0
[    7.696410][    T1]  ? driver_probe_device+0x50/0x430
[    7.698097][    T1]  vring_create_virtqueue_split+0xc6/0x310
[    7.699062][    T1]  ? ret_from_fork+0x4b/0x80
[    7.699790][    T1]  ? __pfx_vring_create_virtqueue_split+0x10/0x10
[    7.700886][    T1]  vring_create_virtqueue+0xca/0x110
[    7.701895][    T1]  ? __pfx_vp_notify+0x10/0x10
[    7.703155][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    7.704118][    T1]  setup_vq+0xe9/0x2d0
[    7.704736][    T1]  ? __pfx_vp_notify+0x10/0x10
[    7.705391][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    7.706755][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    7.708116][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    7.708982][    T1]  vp_setup_vq+0xbf/0x330
[    7.709609][    T1]  ? __pfx_vp_config_changed+0x10/0x10
[    7.710370][    T1]  ? ioread16+0x2f/0x90
[    7.711005][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    7.711861][    T1]  vp_find_vqs_msix+0x8b2/0xc80
[    7.712762][    T1]  vp_find_vqs+0x4c/0x4e0
[    7.713463][    T1]  virtscsi_init+0x8db/0xd00
[    7.714142][    T1]  ? __pfx_virtscsi_init+0x10/0x10
[    7.715032][    T1]  ? __pfx_default_calc_sets+0x10/0x10
[    7.715928][    T1]  ? scsi_host_alloc+0xa57/0xea0
[    7.716710][    T1]  ? vp_get+0xfd/0x140
[    7.717535][    T1]  virtscsi_probe+0x3ea/0xf60
[    7.718252][    T1]  ? __pfx_virtscsi_probe+0x10/0x10
[    7.719062][    T1]  ? vm_set+0xdd/0x3a0
[    7.720396][    T1]  ? __pfx_vp_set_status+0x10/0x10
[    7.721514][    T1]  ? vp_set_status+0x1a/0x40
[    7.722164][    T1]  ? virtio_no_restricted_mem_acc+0x9/0x10
[    7.723108][    T1]  ? virtio_features_ok+0x10c/0x270
[    7.723887][    T1]  virtio_dev_probe+0x991/0xaf0
[    7.724709][    T1]  ? __pfx_virtio_dev_probe+0x10/0x10
[    7.725729][    T1]  really_probe+0x2b8/0xad0
[    7.726650][    T1]  __driver_probe_device+0x1a2/0x390
[    7.727503][    T1]  driver_probe_device+0x50/0x430
[    7.728243][    T1]  __driver_attach+0x45f/0x710
[    7.729022][    T1]  ? __pfx___driver_attach+0x10/0x10
[    7.729890][    T1]  bus_for_each_dev+0x239/0x2b0
[    7.730601][    T1]  ? __pfx___driver_attach+0x10/0x10
[    7.731421][    T1]  ? __pfx_bus_for_each_dev+0x10/0x10
[    7.732219][    T1]  ? do_raw_spin_unlock+0x13c/0x8b0
[    7.733309][    T1]  bus_add_driver+0x347/0x620
[    7.733992][    T1]  driver_register+0x23a/0x320
[    7.734667][    T1]  virtio_scsi_init+0x69/0xe0
[    7.735752][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[    7.736692][    T1]  do_one_initcall+0x248/0x880
[    7.737732][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[    7.738937][    T1]  ? __pfx_do_one_initcall+0x10/0x10
[    7.739803][    T1]  ? lockdep_hardirqs_on_prepare+0x43d/0x780
[    7.740876][    T1]  ? __pfx_parse_args+0x10/0x10
[    7.741838][    T1]  ? do_initcalls+0x1c/0x80
[    7.742731][    T1]  ? rcu_is_watching+0x15/0xb0
[    7.743513][    T1]  do_initcall_level+0x157/0x210
[    7.744299][    T1]  do_initcalls+0x3f/0x80
[    7.745007][    T1]  kernel_init_freeable+0x435/0x5d0
[    7.746216][    T1]  ? __pfx_kernel_init_freeable+0x10/0x10
[    7.747097][    T1]  ? __pfx_lockdep_hardirqs_on_prepare+0x10/0x10
[    7.748009][    T1]  ? __pfx_kernel_init+0x10/0x10
[    7.748782][    T1]  ? __pfx_kernel_init+0x10/0x10
[    7.749752][    T1]  ? __pfx_kernel_init+0x10/0x10
[    7.750548][    T1]  kernel_init+0x1d/0x2b0
[    7.751404][    T1]  ret_from_fork+0x4b/0x80
[    7.752121][    T1]  ? __pfx_kernel_init+0x10/0x10
[    7.752911][    T1]  ret_from_fork_asm+0x1a/0x30
[    7.753697][    T1]  </TASK>
[    7.754133][    T1] Kernel panic - not syncing: kernel: panic_on_warn se=
t ...
[    7.755272][    T1] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.9.0-rc4-=
syzkaller-00039-g26770a717cac #0
[    7.757227][    T1] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 04/02/2024
[    7.759031][    T1] Call Trace:
[    7.759506][    T1]  <TASK>
[    7.759733][    T1]  dump_stack_lvl+0x241/0x360
[    7.759733][    T1]  ? __pfx_dump_stack_lvl+0x10/0x10
[    7.759733][    T1]  ? __pfx__printk+0x10/0x10
[    7.759733][    T1]  ? _printk+0xd5/0x120
[    7.759733][    T1]  ? vscnprintf+0x5d/0x90
[    7.759733][    T1]  panic+0x349/0x860
[    7.759733][    T1]  ? __warn+0x172/0x4e0
[    7.759733][    T1]  ? __pfx_panic+0x10/0x10
[    7.759733][    T1]  ? show_trace_log_lvl+0x4e6/0x520
[    7.759733][    T1]  ? ret_from_fork_asm+0x1a/0x30
[    7.759733][    T1]  __warn+0x346/0x4e0
[    7.759733][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
[    7.759733][    T1]  report_bug+0x2b3/0x500
[    7.769119][    T1]  ? refcount_warn_saturate+0xfa/0x1d0
[    7.769119][    T1]  handle_bug+0x3e/0x70
[    7.769119][    T1]  exc_invalid_op+0x1a/0x50
[    7.769119][    T1]  asm_exc_invalid_op+0x1a/0x20
[    7.769119][    T1] RIP: 0010:refcount_warn_saturate+0xfa/0x1d0
[    7.769119][    T1] Code: b2 00 00 00 e8 57 49 f0 fc 5b 5d c3 cc cc cc c=
c e8 4b 49 f0 fc c6 05 4c 96 ec 0a 01 90 48 c7 c7 40 5d 1e 8c e8 c7 c5 b2 f=
c 90 <0f> 0b 90 90 eb d9 e8 2b 49 f0 fc c6 05 29 96 ec 0a 01 90 48 c7 c7
[    7.769119][    T1] RSP: 0000:ffffc90000066e18 EFLAGS: 00010246
[    7.769119][    T1] RAX: 6a628a5cb0f41700 RBX: ffff8881401ae78c RCX: fff=
f888016ac0000
[    7.769119][    T1] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000=
0000000000000
[    7.778978][    T1] RBP: 0000000000000004 R08: ffffffff81587fc2 R09: fff=
ffbfff1c39b48
[    7.778978][    T1] R10: dffffc0000000000 R11: fffffbfff1c39b48 R12: fff=
fea0000858dc0
[    7.778978][    T1] R13: ffffea0000858dc8 R14: 1ffffd400010b1b9 R15: 000=
0000000000000
[    7.778978][    T1]  ? __warn_printk+0x292/0x360
[    7.778978][    T1]  ? refcount_warn_saturate+0xf9/0x1d0
[    7.778978][    T1]  __free_pages_ok+0xc54/0xd80
[    7.778978][    T1]  make_alloc_exact+0xa3/0xf0
[    7.778978][    T1]  vring_alloc_queue_split+0x20a/0x600
[    7.789051][    T1]  ? __pfx_vring_alloc_queue_split+0x10/0x10
[    7.789051][    T1]  ? vp_find_vqs+0x4c/0x4e0
[    7.789051][    T1]  ? virtscsi_probe+0x3ea/0xf60
[    7.789051][    T1]  ? virtio_dev_probe+0x991/0xaf0
[    7.789051][    T1]  ? really_probe+0x2b8/0xad0
[    7.789051][    T1]  ? driver_probe_device+0x50/0x430
[    7.789051][    T1]  vring_create_virtqueue_split+0xc6/0x310
[    7.789051][    T1]  ? ret_from_fork+0x4b/0x80
[    7.789051][    T1]  ? __pfx_vring_create_virtqueue_split+0x10/0x10
[    7.789051][    T1]  vring_create_virtqueue+0xca/0x110
[    7.789051][    T1]  ? __pfx_vp_notify+0x10/0x10
[    7.789051][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    7.798967][    T1]  setup_vq+0xe9/0x2d0
[    7.798967][    T1]  ? __pfx_vp_notify+0x10/0x10
[    7.798967][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    7.798967][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    7.798967][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    7.798967][    T1]  vp_setup_vq+0xbf/0x330
[    7.798967][    T1]  ? __pfx_vp_config_changed+0x10/0x10
[    7.798967][    T1]  ? ioread16+0x2f/0x90
[    7.798967][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    7.798967][    T1]  vp_find_vqs_msix+0x8b2/0xc80
[    7.798967][    T1]  vp_find_vqs+0x4c/0x4e0
[    7.798967][    T1]  virtscsi_init+0x8db/0xd00
[    7.798967][    T1]  ? __pfx_virtscsi_init+0x10/0x10
[    7.809054][    T1]  ? __pfx_default_calc_sets+0x10/0x10
[    7.809054][    T1]  ? scsi_host_alloc+0xa57/0xea0
[    7.809054][    T1]  ? vp_get+0xfd/0x140
[    7.809054][    T1]  virtscsi_probe+0x3ea/0xf60
[    7.809054][    T1]  ? __pfx_virtscsi_probe+0x10/0x10
[    7.809054][    T1]  ? vm_set+0xdd/0x3a0
[    7.809054][    T1]  ? __pfx_vp_set_status+0x10/0x10
[    7.809054][    T1]  ? vp_set_status+0x1a/0x40
[    7.809054][    T1]  ? virtio_no_restricted_mem_acc+0x9/0x10
[    7.809054][    T1]  ? virtio_features_ok+0x10c/0x270
[    7.809054][    T1]  virtio_dev_probe+0x991/0xaf0
[    7.809054][    T1]  ? __pfx_virtio_dev_probe+0x10/0x10
[    7.818989][    T1]  really_probe+0x2b8/0xad0
[    7.818989][    T1]  __driver_probe_device+0x1a2/0x390
[    7.818989][    T1]  driver_probe_device+0x50/0x430
[    7.818989][    T1]  __driver_attach+0x45f/0x710
[    7.818989][    T1]  ? __pfx___driver_attach+0x10/0x10
[    7.818989][    T1]  bus_for_each_dev+0x239/0x2b0
[    7.818989][    T1]  ? __pfx___driver_attach+0x10/0x10
[    7.818989][    T1]  ? __pfx_bus_for_each_dev+0x10/0x10
[    7.818989][    T1]  ? do_raw_spin_unlock+0x13c/0x8b0
[    7.818989][    T1]  bus_add_driver+0x347/0x620
[    7.818989][    T1]  driver_register+0x23a/0x320
[    7.818989][    T1]  virtio_scsi_init+0x69/0xe0
[    7.818989][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[    7.828983][    T1]  do_one_initcall+0x248/0x880
[    7.829040][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[    7.829040][    T1]  ? __pfx_do_one_initcall+0x10/0x10
[    7.829040][    T1]  ? lockdep_hardirqs_on_prepare+0x43d/0x780
[    7.829040][    T1]  ? __pfx_parse_args+0x10/0x10
[    7.829040][    T1]  ? do_initcalls+0x1c/0x80
[    7.829040][    T1]  ? rcu_is_watching+0x15/0xb0
[    7.829040][    T1]  do_initcall_level+0x157/0x210
[    7.829040][    T1]  do_initcalls+0x3f/0x80
[    7.829040][    T1]  kernel_init_freeable+0x435/0x5d0
[    7.829040][    T1]  ? __pfx_kernel_init_freeable+0x10/0x10
[    7.829040][    T1]  ? __pfx_lockdep_hardirqs_on_prepare+0x10/0x10
[    7.829040][    T1]  ? __pfx_kernel_init+0x10/0x10
[    7.838961][    T1]  ? __pfx_kernel_init+0x10/0x10
[    7.838961][    T1]  ? __pfx_kernel_init+0x10/0x10
[    7.838961][    T1]  kernel_init+0x1d/0x2b0
[    7.838961][    T1]  ret_from_fork+0x4b/0x80
[    7.838961][    T1]  ? __pfx_kernel_init+0x10/0x10
[    7.838961][    T1]  ret_from_fork_asm+0x1a/0x30
[    7.838961][    T1]  </TASK>
[    7.838961][    T1] Kernel Offset: disabled
[    7.838961][    T1] Rebooting in 86400 seconds..


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
 -ffile-prefix-map=3D/tmp/go-build2122882332=3D/tmp/go-build -gno-record-gc=
c-switches'

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
https://syzkaller.appspot.com/x/error.txt?x=3D168a0e20980000


Tested on:

commit:         26770a71 jbd2: add prefix 'jbd2' for 'shrink_type'
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.gi=
t dev
kernel config:  https://syzkaller.appspot.com/x/.config?x=3Df47e5e015c177e5=
7
dashboard link: https://syzkaller.appspot.com/bug?extid=3D11af34d3c0711f233=
fd4
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debia=
n) 2.40

Note: no patches were applied.


Return-Path: <linux-kernel+bounces-562436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08362A627A8
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 07:52:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 258938800C5
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 06:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BF1A1946C3;
	Sat, 15 Mar 2025 06:52:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837E22E3392
	for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 06:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742021524; cv=none; b=I8ro5W5VBTYGRgx9JjoH1FFFiSu0rVyAWdsKpv+sP1zRUPylH89yzySmx8ft+sl2QbUmJGYWAKK1XD01+BAQakhsfPJJC7ZTwP0djmcpUDf0MB+Z2G4kh3BWWA8S5NRSfR0z0rcOJlK5O/lapw5twZOdt73Ff9mBtbXNnIPZpIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742021524; c=relaxed/simple;
	bh=MCrPFpJD3kkzJXD0oop3KJcUGeAVQvpn7TD7bxgCqDg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=dhiS9g6quIbYerzb9CwQDB/mOm+9PWCe45b1MI0rFdBOQepVsXNvt6Xb8GrWQ14vsqcboVsTt2u1OmX3ft0BDg6jC/et+dkMV2pbH/421JfNOZJsUtGJBDBxzhrNgfaEV6HMkkST6LrV8I4HlctWkRFZ3Hyq5mRvwiUIIehVgIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3d44b221f0dso53907925ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 23:52:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742021521; x=1742626321;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yk3CAAUdcqcJvk0ldHeK2ycX2rMDwwPMwgiZ9n4r9p0=;
        b=N0+EtuzArtFxJKd/IKWEZmJ3yp8BQGnHK5GUlwTznttk42I40J3tG73sRbZXgcCrPb
         pBwZ/3TaYpMepuKmt2ftVes6EDJkt8hnpt1/y7iL//9d+g4WLwRYmRF8Ey14J9O5ZzRV
         ZNLU56k4z3njV3qzS6wPdFght9DxFdYpglizqWpp5KH/LxY6w99AnCyke/4e/zc/NmZk
         +HkRW3I3tf+BqkpcdLpHqSd9kTqHmvUEWPrxkgMQRVDZm6MzlSHtnhEsM+YStGtZmf6I
         bbQjE6l/Kj89/TEMiJShW2OyqMG3dlo/vi6q0oFU8MzfPkRuTbNiBkbxrTtb5CKKsTob
         tRAA==
X-Forwarded-Encrypted: i=1; AJvYcCXJlfnCBKYHKpn4HrZeleWJhEm0R2kqdfQy2jGz23IRl2WAwzqtMKEsi5bhnmnf8mFtqzmj3dclxb43eg4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHJtHDxqgHRtXrEO7GiJgCxFd0FMJCmnV/y5huciU6VrKtZFJw
	djRNRq68lbLQhHxCFS5xtfL6a/m8kl4aUcI8hLEfpmADOROOPkc68Hi28rlSXbsGOUN8a81Rxfx
	sMvYTPc69FyISvN6I9WD0tE2SMlRc9on1cLVBL06bwc4Sytp3H9q8Q2Y=
X-Google-Smtp-Source: AGHT+IHWfj6LYzronjqAlWmBmmdlYPpmbCW1t3Tv2t2eiVXKmDxfegXZT07zKh7UTuqKR5GzuwuMjgohSjTOV/vrPkijfZO2F7Pa
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3498:b0:3d4:700f:67e7 with SMTP id
 e9e14a558f8ab-3d483a6ed9emr53751175ab.17.1742021521696; Fri, 14 Mar 2025
 23:52:01 -0700 (PDT)
Date: Fri, 14 Mar 2025 23:52:01 -0700
In-Reply-To: <tencent_8819BA58BBC933889E4C1B684BB91BAE2508@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67d52391.050a0220.14e108.0052.GAE@google.com>
Subject: Re: [syzbot] [wireless?] possible deadlock in ieee80211_change_mac (3)
From: syzbot <syzbot+30de9d963fdd95d745f8@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

08][    T1]  ? __pfx_kernel_init+0x10/0x10
[    8.036708][    T1]  ret_from_fork_asm+0x1a/0x30
[    8.036708][    T1]  </TASK>
[    8.134385][    C0] vkms_vblank_simulate: vblank timer overrun
[    8.221915][   T36] sd 0:0:1:0: Attached scsi generic sg0 type 0
[    8.221924][   T73] sd 0:0:1:0: [sda] 4194304 512-byte logical blocks: (=
2.15 GB/2.00 GiB)
[    8.221951][   T73] sd 0:0:1:0: [sda] 4096-byte physical blocks
[    8.225939][   T73] sd 0:0:1:0: [sda] Write Protect is off
[    8.227274][   T73] sd 0:0:1:0: [sda] Mode Sense: 1f 00 00 08
[    8.228765][   T73] sd 0:0:1:0: [sda] Write cache: enabled, read cache: =
enabled, doesn't support DPO or FUA
[    8.268565][   T73]  sda: sda1
[    8.269923][   T73] sd 0:0:1:0: [sda] Attached SCSI disk
[  286.896359][   T31] INFO: task swapper/0:1 blocked for more than 143 sec=
onds.
[  286.898632][   T31]       Not tainted 6.14.0-rc6-syzkaller-gbfc6c67ec2d6=
-dirty #0
[  286.900152][   T31] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" d=
isables this message.
[  286.902226][   T31] task:swapper/0       state:D stack:17232 pid:1     t=
gid:1     ppid:0      task_flags:0x0140 flags:0x00004002
[  286.904319][   T31] Call Trace:
[  286.905255][   T31]  <TASK>
[  286.906061][   T31]  __schedule+0x190e/0x4c90
[  286.907166][   T31]  ? rcu_is_watching+0x15/0xb0
[  286.908672][   T31]  ? schedule+0x90/0x320
[  286.909576][   T31]  ? lock_release+0xbf/0xa30
[  286.910712][   T31]  ? __pfx___schedule+0x10/0x10
[  286.912865][   T31]  ? __pfx_lock_release+0x10/0x10
[  286.913717][   T31]  ? rcu_is_watching+0x15/0xb0
[  286.914523][   T31]  ? _raw_spin_unlock_irqrestore+0xdd/0x140
[  286.915779][   T31]  ? __pfx__raw_spin_unlock_irqrestore+0x10/0x10
[  286.918633][   T31]  ? schedule+0x90/0x320
[  286.922896][   T31]  schedule+0x14b/0x320
[  286.927117][   T31]  schedule_preempt_disabled+0x13/0x30
[  286.932667][   T31]  __mutex_lock+0x817/0x1010
[  286.937764][   T31]  ? __mutex_lock+0x602/0x1010
[  286.942558][   T31]  ? cfg80211_netdev_notifier_call+0x71e/0x1490
[  286.949056][   T31]  ? __pfx___mutex_lock+0x10/0x10
[  286.954109][   T31]  ? _raw_spin_unlock_irqrestore+0xdd/0x140
[  286.960296][   T31]  ? __pfx__raw_spin_unlock_irqrestore+0x10/0x10
[  286.966969][   T31]  cfg80211_netdev_notifier_call+0x71e/0x1490
[  286.973158][   T31]  ? __asan_memset+0x23/0x50
[  286.977945][   T31]  ? __pfx_cfg80211_netdev_notifier_call+0x10/0x10
[  286.984555][   T31]  ? __asan_memset+0x23/0x50
[  286.989221][   T31]  ? lockdep_init_map_type+0xa1/0x910
[  286.994812][   T31]  ? __pfx_lockdep_init_map_type+0x10/0x10
[  287.001153][   T31]  ? __pfx_igmp_ifc_timer_expire+0x10/0x10
[  287.007380][   T31]  ? init_timer_key+0x197/0x320
[  287.012266][   T31]  ? __raw_spin_lock_init+0x45/0x100
[  287.017927][   T31]  ? inetdev_init+0x39d/0x4e0
[  287.022631][   T31]  ? inetdev_event+0x398/0x1620
[  287.027555][   T31]  ? igmp_netdev_event+0x7c/0x770
[  287.032601][   T31]  notifier_call_chain+0x1a5/0x3f0
[  287.038157][   T31]  register_netdevice+0x16c5/0x1b70
[  287.043551][   T31]  ? __pfx_register_netdevice+0x10/0x10
[  287.049369][   T31]  ? ieee80211_debugfs_recreate_netdev+0x104b/0x14d0
[  287.056080][   T31]  cfg80211_register_netdevice+0x129/0x2d0
[  287.062180][   T31]  ieee80211_if_add+0x119d/0x1780
[  287.067240][   T31]  ieee80211_register_hw+0x3708/0x42e0
[  287.072718][   T31]  ? ieee80211_register_hw+0x1601/0x42e0
[  287.078518][   T31]  ? __pfx_ieee80211_register_hw+0x10/0x10
[  287.084343][   T31]  ? __asan_memset+0x23/0x50
[  287.089050][   T31]  ? __hrtimer_init+0x170/0x250
[  287.094023][   T31]  mac80211_hwsim_new_radio+0x2a89/0x49f0
[  287.099859][   T31]  ? kasan_quarantine_put+0xdc/0x230
[  287.105426][   T31]  ? __pfx_mac80211_hwsim_new_radio+0x10/0x10
[  287.111612][   T31]  ? sysfs_create_groups+0x9b/0x120
[  287.116835][   T31]  ? class_register+0x302/0x380
[  287.121675][   T31]  init_mac80211_hwsim+0x87a/0xb00
[  287.127111][   T31]  ? __pfx_init_mac80211_hwsim+0x10/0x10
[  287.132757][   T31]  ? usb_register_driver+0x2e2/0x380
[  287.138309][   T31]  ? __pfx_init_mac80211_hwsim+0x10/0x10
[  287.143994][   T31]  do_one_initcall+0x248/0x930
[  287.148836][   T31]  ? __pfx_init_mac80211_hwsim+0x10/0x10
[  287.154490][   T31]  ? __pfx_lockdep_hardirqs_on_prepare+0x10/0x10
[  287.160903][   T31]  ? __pfx_do_one_initcall+0x10/0x10
[  287.166282][   T31]  ? __pfx_parse_args+0x10/0x10
[  287.171134][   T31]  ? rcu_is_watching+0x15/0xb0
[  287.176393][   T31]  do_initcall_level+0x157/0x210
[  287.181652][   T31]  do_initcalls+0x71/0xd0
[  287.185982][   T31]  kernel_init_freeable+0x435/0x5d0
[  287.191255][   T31]  ? __pfx_kernel_init_freeable+0x10/0x10
[  287.197321][   T31]  ? __pfx_lockdep_hardirqs_on_prepare+0x10/0x10
[  287.203746][   T31]  ? __pfx_kernel_init+0x10/0x10
[  287.208961][   T31]  ? __pfx_kernel_init+0x10/0x10
[  287.214115][   T31]  ? __pfx_kernel_init+0x10/0x10
[  287.219424][   T31]  kernel_init+0x1d/0x2b0
[  287.223762][   T31]  ret_from_fork+0x4b/0x80
[  287.228231][   T31]  ? __pfx_kernel_init+0x10/0x10
[  287.233343][   T31]  ret_from_fork_asm+0x1a/0x30
[  287.238220][   T31]  </TASK>
[  287.241494][   T31] INFO: task kworker/u8:5:222 blocked for more than 14=
3 seconds.
[  287.249373][   T31]       Not tainted 6.14.0-rc6-syzkaller-gbfc6c67ec2d6=
-dirty #0
[  287.257124][   T31] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" d=
isables this message.
[  287.265793][   T31] task:kworker/u8:5    state:D stack:23952 pid:222   t=
gid:222   ppid:2      task_flags:0x4208060 flags:0x00004000
[  287.278105][   T31] Workqueue: events_unbound linkwatch_event
[  287.284753][   T31] Call Trace:
[  287.288096][   T31]  <TASK>
[  287.291045][   T31]  __schedule+0x190e/0x4c90
[  287.295605][   T31]  ? rcu_is_watching+0x15/0xb0
[  287.300391][   T31]  ? schedule+0x90/0x320
[  287.304619][   T31]  ? lock_release+0xbf/0xa30
[  287.309226][   T31]  ? __pfx___schedule+0x10/0x10
[  287.314070][   T31]  ? __pfx_lock_release+0x10/0x10
[  287.319165][   T31]  ? rcu_is_watching+0x15/0xb0
[  287.323955][   T31]  ? kthread_data+0x52/0xd0
[  287.328675][   T31]  ? schedule+0x90/0x320
[  287.333173][   T31]  ? wq_worker_sleeping+0x66/0x240
[  287.338509][   T31]  ? schedule+0x90/0x320
[  287.342779][   T31]  schedule+0x14b/0x320
[  287.347003][   T31]  schedule_preempt_disabled+0x13/0x30
[  287.352459][   T31]  __mutex_lock+0x817/0x1010
[  287.357333][   T31]  ? __mutex_lock+0x602/0x1010
[  287.362101][   T31]  ? linkwatch_event+0xe/0x60
[  287.367185][   T31]  ? __pfx___mutex_lock+0x10/0x10
[  287.372266][   T31]  ? __pfx_debug_object_deactivate+0x10/0x10
[  287.378693][   T31]  ? rcu_is_watching+0x15/0xb0
[  287.383653][   T31]  ? process_scheduled_works+0x9c6/0x18e0
[  287.389423][   T31]  linkwatch_event+0xe/0x60
[  287.394020][   T31]  process_scheduled_works+0xabe/0x18e0
[  287.399648][   T31]  ? __pfx_process_scheduled_works+0x10/0x10
[  287.405648][   T31]  ? __pfx__raw_spin_lock_irq+0x10/0x10
[  287.411257][   T31]  ? assign_work+0x364/0x3d0
[  287.415874][   T31]  worker_thread+0x870/0xd30
[  287.420596][   T31]  ? _raw_spin_unlock_irqrestore+0xdd/0x140
[  287.426679][   T31]  ? __kthread_parkme+0x169/0x1d0
[  287.431809][   T31]  ? __pfx_worker_thread+0x10/0x10
[  287.436977][   T31]  kthread+0x7a9/0x920
[  287.441160][   T31]  ? __pfx_kthread+0x10/0x10
[  287.445738][   T31]  ? __pfx_worker_thread+0x10/0x10
[  287.451040][   T31]  ? __pfx_kthread+0x10/0x10
[  287.455720][   T31]  ? __pfx_kthread+0x10/0x10
[  287.460356][   T31]  ? __pfx_kthread+0x10/0x10
[  287.464943][   T31]  ? _raw_spin_unlock_irq+0x23/0x50
[  287.470301][   T31]  ? lockdep_hardirqs_on+0x99/0x150
[  287.475688][   T31]  ? __pfx_kthread+0x10/0x10
[  287.480418][   T31]  ret_from_fork+0x4b/0x80
[  287.484977][   T31]  ? __pfx_kthread+0x10/0x10
[  287.489904][   T31]  ret_from_fork_asm+0x1a/0x30
[  287.494692][   T31]  </TASK>
[  287.498653][   T31] INFO: task kworker/1:2:976 blocked for more than 143=
 seconds.
[  287.506556][   T31]       Not tainted 6.14.0-rc6-syzkaller-gbfc6c67ec2d6=
-dirty #0
[  287.514318][   T31] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" d=
isables this message.
[  287.523264][   T31] task:kworker/1:2     state:D stack:26680 pid:976   t=
gid:976   ppid:2      task_flags:0x4208060 flags:0x00004000
[  287.535539][   T31] Workqueue: events_power_efficient reg_check_chans_wo=
rk
[  287.542680][   T31] Call Trace:
[  287.546032][   T31]  <TASK>
[  287.549043][   T31]  __schedule+0x190e/0x4c90
[  287.553747][   T31]  ? do_raw_spin_lock+0x14f/0x370
[  287.558882][   T31]  ? schedule+0x90/0x320
[  287.563160][   T31]  ? schedule+0x90/0x320
[  287.567703][   T31]  ? lock_release+0xbf/0xa30
[  287.572411][   T31]  ? __pfx___schedule+0x10/0x10
[  287.577351][   T31]  ? _raw_spin_lock_irq+0xdf/0x120
[  287.582452][   T31]  ? __pfx_lock_release+0x10/0x10
[  287.587679][   T31]  ? kick_pool+0x1bd/0x620
[  287.592411][   T31]  ? schedule+0x90/0x320
[  287.596792][   T31]  ? rcu_is_watching+0x15/0xb0
[  287.601681][   T31]  ? schedule+0x90/0x320
[  287.605958][   T31]  schedule+0x14b/0x320
[  287.610173][   T31]  schedule_preempt_disabled+0x13/0x30
[  287.615794][   T31]  __mutex_lock+0x817/0x1010
[  287.620589][   T31]  ? __mutex_lock+0x602/0x1010
[  287.625344][   T31]  ? reg_check_chans_work+0x99/0xfb0
[  287.630639][   T31]  ? __pfx___mutex_lock+0x10/0x10
[  287.635660][   T31]  ? do_raw_spin_unlock+0x13c/0x8b0
[  287.640904][   T31]  ? rcu_is_watching+0x15/0xb0
[  287.645692][   T31]  ? process_scheduled_works+0x9c6/0x18e0
[  287.651535][   T31]  reg_check_chans_work+0x99/0xfb0
[  287.656703][   T31]  ? process_scheduled_works+0x9c6/0x18e0
[  287.662621][   T31]  ? lock_acquire+0xe3/0x550
[  287.667297][   T31]  ? __pfx_lock_acquire+0x10/0x10
[  287.672336][   T31]  ? debug_object_deactivate+0x2d5/0x390
[  287.678057][   T31]  ? __pfx_lock_release+0x10/0x10
[  287.683094][   T31]  ? __pfx_reg_check_chans_work+0x10/0x10
[  287.689044][   T31]  ? __pfx_lockdep_hardirqs_on_prepare+0x10/0x10
[  287.695474][   T31]  ? rcu_is_watching+0x15/0xb0
[  287.700564][   T31]  ? process_scheduled_works+0x9c6/0x18e0
[  287.706359][   T31]  process_scheduled_works+0xabe/0x18e0
[  287.712027][   T31]  ? __pfx_process_scheduled_works+0x10/0x10
[  287.718078][   T31]  ? __pfx__raw_spin_lock_irq+0x10/0x10
[  287.724200][   T31]  ? assign_work+0x364/0x3d0
[  287.729082][   T31]  worker_thread+0x870/0xd30
[  287.733860][   T31]  ? _raw_spin_unlock_irqrestore+0xdd/0x140
[  287.740034][   T31]  ? __kthread_parkme+0x169/0x1d0
[  287.745113][   T31]  ? __pfx_worker_thread+0x10/0x10
[  287.750290][   T31]  kthread+0x7a9/0x920
[  287.754445][   T31]  ? __pfx_kthread+0x10/0x10
[  287.759346][   T31]  ? __pfx_worker_thread+0x10/0x10
[  287.764565][   T31]  ? __pfx_kthread+0x10/0x10
[  287.769211][   T31]  ? __pfx_kthread+0x10/0x10
[  287.774224][   T31]  ? __pfx_kthread+0x10/0x10
[  287.778935][   T31]  ? _raw_spin_unlock_irq+0x23/0x50
[  287.784151][   T31]  ? lockdep_hardirqs_on+0x99/0x150
[  287.789546][   T31]  ? __pfx_kthread+0x10/0x10
[  287.794422][   T31]  ret_from_fork+0x4b/0x80
[  287.798905][   T31]  ? __pfx_kthread+0x10/0x10
[  287.803525][   T31]  ret_from_fork_asm+0x1a/0x30
[  287.808466][   T31]  </TASK>
[  287.811849][   T31] INFO: lockdep is turned off.
[  287.816688][   T31] Kernel panic - not syncing: hung_task: blocked tasks
[  287.823719][   T31] CPU: 1 UID: 0 PID: 31 Comm: khungtaskd Not tainted 6=
.14.0-rc6-syzkaller-gbfc6c67ec2d6-dirty #0
[  287.826639][   T31] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 02/12/2025
[  287.826639][   T31] Call Trace:
[  287.826639][   T31]  <TASK>
[  287.826639][   T31]  dump_stack_lvl+0x241/0x360
[  287.826639][   T31]  ? __pfx_dump_stack_lvl+0x10/0x10
[  287.826639][   T31]  ? __pfx__printk+0x10/0x10
[  287.826639][   T31]  ? show_trace_log_lvl+0x3b2/0x410
[  287.826639][   T31]  ? vscnprintf+0x5d/0x90
[  287.826639][   T31]  panic+0x349/0x880
[  287.826639][   T31]  ? __wake_up_klogd+0xcc/0x110
[  287.826639][   T31]  ? __pfx_panic+0x10/0x10
[  287.826639][   T31]  ? watchdog+0x100f/0x10a0
[  287.826639][   T31]  watchdog+0x1097/0x10a0
[  287.826639][   T31]  ? watchdog+0x1ea/0x10a0
[  287.826639][   T31]  ? __pfx_watchdog+0x10/0x10
[  287.826639][   T31]  kthread+0x7a9/0x920
[  287.826639][   T31]  ? __pfx_kthread+0x10/0x10
[  287.826639][   T31]  ? __pfx_watchdog+0x10/0x10
[  287.826639][   T31]  ? __pfx_kthread+0x10/0x10
[  287.826639][   T31]  ? __pfx_kthread+0x10/0x10
[  287.826639][   T31]  ? __pfx_kthread+0x10/0x10
[  287.826639][   T31]  ? _raw_spin_unlock_irq+0x23/0x50
[  287.826639][   T31]  ? lockdep_hardirqs_on+0x99/0x150
[  287.826639][   T31]  ? __pfx_kthread+0x10/0x10
[  287.826639][   T31]  ret_from_fork+0x4b/0x80
[  287.826639][   T31]  ? __pfx_kthread+0x10/0x10
[  287.826639][   T31]  ret_from_fork_asm+0x1a/0x30
[  287.826639][   T31]  </TASK>
[  287.826639][   T31] Kernel Offset: disabled
[  287.826639][   T31] Rebooting in 86400 seconds..


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
GOROOT=3D'/syzkaller/jobs-2/linux/gopath/pkg/mod/golang.org/toolchain@v0.0.=
1-go1.23.6.linux-amd64'
GOSUMDB=3D'sum.golang.org'
GOTMPDIR=3D''
GOTOOLCHAIN=3D'auto'
GOTOOLDIR=3D'/syzkaller/jobs-2/linux/gopath/pkg/mod/golang.org/toolchain@v0=
.0.1-go1.23.6.linux-amd64/pkg/tool/linux_amd64'
GOVCS=3D''
GOVERSION=3D'go1.23.6'
GODEBUG=3D''
GOTELEMETRY=3D'local'
GOTELEMETRYDIR=3D'/syzkaller/.config/go/telemetry'
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
 -ffile-prefix-map=3D/tmp/go-build2577400997=3D/tmp/go-build -gno-record-gc=
c-switches'

git status (err=3D<nil>)
HEAD detached at e28266709d
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
/syzkaller/prog.GitRevision=3De28266709dd2a1d1452d4a5bbf271700e10335c6 -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20250313-150626'" -o ./b=
in/linux_amd64/syz-execprog github.com/google/syzkaller/tools/syz-execprog
mkdir -p ./bin/linux_amd64
g++ -o ./bin/linux_amd64/syz-executor executor/executor.cc \
	-m64 -O2 -pthread -Wall -Werror -Wparentheses -Wunused-const-variable -Wfr=
ame-larger-than=3D16384 -Wno-stringop-overflow -Wno-array-bounds -Wno-forma=
t-overflow -Wno-unused-but-set-variable -Wno-unused-command-line-argument -=
static-pie -std=3Dc++17 -I. -Iexecutor/_include   -DGOOS_linux=3D1 -DGOARCH=
_amd64=3D1 \
	-DHOSTGOOS_linux=3D1 -DGIT_REVISION=3D\"e28266709dd2a1d1452d4a5bbf271700e1=
0335c6\"
go: downloading golang.org/x/net v0.36.0
go: downloading golang.org/x/crypto v0.35.0
/usr/bin/ld: /tmp/cctp6ird.o: in function `Connection::Connect(char const*,=
 char const*)':
executor.cc:(.text._ZN10Connection7ConnectEPKcS1_[_ZN10Connection7ConnectEP=
KcS1_]+0x104): warning: Using 'gethostbyname' in statically linked applicat=
ions requires at runtime the shared libraries from the glibc version used f=
or linking


Error text is too large and was truncated, full error text is at:
https://syzkaller.appspot.com/x/error.txt?x=3D11e4ae54580000


Tested on:

commit:         bfc6c67e net/smc: use the correct ndev to find pnetid ..
git tree:       net-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=3Daeeec842a6bdc8b=
9
dashboard link: https://syzkaller.appspot.com/bug?extid=3D30de9d963fdd95d74=
5f8
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debia=
n) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D11fb8fa85800=
00



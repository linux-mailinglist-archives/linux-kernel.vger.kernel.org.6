Return-Path: <linux-kernel+bounces-241179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FC059277E6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 16:12:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9714285DD6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 14:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EEED1AEFE8;
	Thu,  4 Jul 2024 14:11:59 +0000 (UTC)
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B011AE87F
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 14:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720102318; cv=none; b=JsvKpRiPo/TZ7eHd1vs7nVYNJCm+fJLXLWfNKVI1iU5LzbRvjpYzlVNdPFLb13MZnVcyXge3IjpAJv5QqsCiWb2QgN+egBdS8Yo0sGawsqxUBegJtVQLEEM9SfxmsGcKXfgvUYd+sllbhYCiNQ1b60zKTPWt/gSdDYrj8OlSp0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720102318; c=relaxed/simple;
	bh=cPX++j2S4Jk/GmeKf+5cVvytg9xauOiavPcAKYsMmxY=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=owLl/8LzHn7iwQ8/1VRLMG4hprbXkqtTcoA6BzCD4IsQlg5VKrWlhvUZv5maLapZ2UPXbeL80L61/4v2MbiCNQWlWt6CfgcHJYfJgNNn4tmZP5hmbFKLLmZbGXm0/AXfqovzxeu6yiBhiwapNLjY2mADu5vrj1m47aWlqGyiWpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.45] (g45.guest.molgen.mpg.de [141.14.220.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 822E461E6477A;
	Thu,  4 Jul 2024 16:11:21 +0200 (CEST)
Message-ID: <7666eb01-b609-4eee-b331-8fbf689a1961@molgen.mpg.de>
Date: Thu, 4 Jul 2024 16:11:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org
From: Paul Menzel <pmenzel@molgen.mpg.de>
Subject: Freezing user space processes failed after 20.006 seconds
 (systemd-journal, udev-worker)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Linux folks,


Using Linux 6.10-rc6 on the Intel Kaby Lake laptop Dell XPS 13 9360, I 
was unable to suspend the system:

```
[    0.000000] Linux version 6.10.0-rc6 
(build@bohemianrhapsody.molgen.mpg.de) (gcc (Debian 13.3.0-1) 13.3.0, 
GNU ld (GNU Binutils for Debian) 2.42.50.20240625) #211 SMP 
PREEMPT_DYNAMIC Mon Jul  1 08:23:19 CEST 2024
[    0.000000] Command line: BOOT_IMAGE=/vmlinuz-6.10.0-rc6 
root=UUID=32e29882-d94d-4a92-9ee4-4d03002bfa29 ro quiet pci=noaer 
mem_sleep_default=deep log_buf_len=8M cryptomgr.notests
[…]
[42576.003324] Freezing user space processes
[42596.009937] Freezing user space processes failed after 20.006 seconds 
(2 tasks refusing to freeze, wq_busy=0):
[42596.010034] task:systemd-journal state:D stack:0     pid:405 
tgid:405   ppid:1      flags:0x00000006
[42596.010060] Call Trace:
[42596.010068]  <TASK>
[42596.010082]  __schedule+0x3e8/0xb10
[42596.010117]  schedule+0x27/0xe0
[42596.010137]  schedule_preempt_disabled+0x15/0x20
[42596.010157]  __mutex_lock.constprop.0+0x335/0x620
[42596.010183]  uevent_show+0xa6/0x120
[42596.010208]  dev_attr_show+0x19/0x50
[42596.010225]  sysfs_kf_seq_show+0xa1/0xf0
[42596.010248]  seq_read_iter+0x1c5/0x490
[42596.010262]  ? security_file_permission+0x30/0x40
[42596.010284]  vfs_read+0x289/0x360
[42596.010312]  ksys_read+0x6f/0xf0
[42596.010333]  do_syscall_64+0x82/0x160
[42596.010351]  ? syscall_exit_to_user_mode+0x73/0x200
[42596.010373]  ? do_syscall_64+0x8e/0x160
[42596.010383]  ? do_sys_openat2+0x93/0xe0
[42596.010404]  ? syscall_exit_to_user_mode+0x73/0x200
[42596.010423]  ? do_syscall_64+0x8e/0x160
[42596.010434]  ? __mod_memcg_state+0x95/0x130
[42596.010452]  ? __memcg_slab_free_hook+0xf9/0x140
[42596.010470]  ? kmem_cache_free+0x256/0x4b0
[42596.010490]  ? syscall_exit_to_user_mode+0x73/0x200
[42596.010508]  ? do_syscall_64+0x8e/0x160
[42596.010519]  ? kmem_cache_free+0x256/0x4b0
[42596.010536]  ? syscall_exit_to_user_mode+0x73/0x200
[42596.010554]  ? do_syscall_64+0x8e/0x160
[42596.010564]  ? do_syscall_64+0x8e/0x160
[42596.010574]  ? do_syscall_64+0x8e/0x160
[42596.010583]  ? exc_page_fault+0x81/0x190
[42596.010602]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
[42596.010621] RIP: 0033:0x7f0883b19a5c
[42596.010704] RSP: 002b:00007ffdb5179de0 EFLAGS: 00000246 ORIG_RAX: 
0000000000000000
[42596.010720] RAX: ffffffffffffffda RBX: 000055d7fa3042a0 RCX: 
00007f0883b19a5c
[42596.010731] RDX: 0000000000001008 RSI: 000055d7fa3042a0 RDI: 
0000000000000026
[42596.010741] RBP: 0000000000000026 R08: 0000000000000000 R09: 
0000000000000001
[42596.010749] R10: 0000000000000003 R11: 0000000000000246 R12: 
0000000000001007
[42596.010758] R13: 0000000000001008 R14: ffffffffffffffff R15: 
0000000000000002
[42596.010777]  </TASK>
[42596.011098] task:(udev-worker)   state:D stack:0     pid:109961 
tgid:109961 ppid:426    flags:0x00000006
[42596.011120] Call Trace:
[42596.011126]  <TASK>
[42596.011133]  __schedule+0x3e8/0xb10
[42596.011158]  schedule+0x27/0xe0
[42596.011175]  schedule_preempt_disabled+0x15/0x20
[42596.011194]  __mutex_lock.constprop.0+0x335/0x620
[42596.011219]  uevent_show+0xa6/0x120
[42596.011240]  dev_attr_show+0x19/0x50
[42596.011256]  sysfs_kf_seq_show+0xa1/0xf0
[42596.011277]  seq_read_iter+0x1c5/0x490
[42596.011289]  ? security_file_permission+0x30/0x40
[42596.011307]  vfs_read+0x289/0x360
[42596.011334]  ksys_read+0x6f/0xf0
[42596.011355]  do_syscall_64+0x82/0x160
[42596.011366]  ? do_readlinkat+0x105/0x140
[42596.011384]  ? syscall_exit_to_user_mode+0x73/0x200
[42596.011404]  ? do_syscall_64+0x8e/0x160
[42596.011414]  ? syscall_exit_to_user_mode+0x73/0x200
[42596.011432]  ? do_syscall_64+0x8e/0x160
[42596.011441]  ? do_syscall_64+0x8e/0x160
[42596.011450]  ? do_syscall_64+0x8e/0x160
[42596.011458]  ? do_syscall_64+0x8e/0x160
[42596.011467]  ? exc_page_fault+0x81/0x190
[42596.011486]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
[42596.011501] RIP: 0033:0x7eff70fefa1d
[42596.011532] RSP: 002b:00007ffcfc8777a8 EFLAGS: 00000246 ORIG_RAX: 
0000000000000000
[42596.011546] RAX: ffffffffffffffda RBX: 0000561c75620fc0 RCX: 
00007eff70fefa1d
[42596.011555] RDX: 0000000000001008 RSI: 0000561c75620fc0 RDI: 
0000000000000015
[42596.011563] RBP: 0000000000000015 R08: 0000000000000000 R09: 
00007eff710c7b50
[42596.011571] R10: 0000000000000010 R11: 0000000000000246 R12: 
0000000000001007
[42596.011579] R13: 0000000000001008 R14: ffffffffffffffff R15: 
0000000000000002
[42596.011594]  </TASK>
```

The system came back (took some time to get GNOME’s screensaver screen 
to show) and powering off the system seems to have worked, but the 
journal does not contain these messages due to being impacted by the error:

```
[…]
Jul 04 09:03:23 abreu kernel: ACPI: EC: interrupt unblocked
Jul 04 09:03:23 abreu kernel: xhci_hcd 0000:39:00.0: Unable to change 
power state from D3hot to D0, device inaccessible
Jul 04 09:03:23 abreu kernel: ACPI: EC: event unblocked
Jul 04 09:03:23 abreu kernel: xhci_hcd 0000:39:00.0: Unable to change 
power state from D3cold to D0, device inaccessible
Jul 04 09:03:23 abreu kernel: xhci_hcd 0000:39:00.0: Controller not 
ready at resume -19
Jul 04 09:03:23 abreu kernel: xhci_hcd 0000:39:00.0: PCI post-resume 
error -19!
Jul 04 09:03:23 abreu kernel: xhci_hcd 0000:39:00.0: HC died; cleaning up
Jul 04 09:03:23 abreu kernel: xhci_hcd 0000:39:00.0: PM: 
dpm_run_callback(): pci_pm_resume returns -19
Jul 04 09:03:23 abreu kernel: xhci_hcd 0000:39:00.0: PM: failed to 
resume async: error -19
Jul 04 09:03:23 abreu kernel: nvme nvme0: 4/0/0 default/read/poll queues
Jul 04 09:03:23 abreu kernel: i915 0000:00:02.0: [drm] [ENCODER:98:DDI 
A/PHY A] is disabled/in DSI mode with an ungated DDI clock, gate it
Jul 04 09:03:23 abreu kernel: i915 0000:00:02.0: [drm] [ENCODER:106:DDI 
B/PHY B] is disabled/in DSI mode with an ungated DDI clock, gate it
Jul 04 09:03:23 abreu kernel: i915 0000:00:02.0: [drm] [ENCODER:117:DDI 
C/PHY C] is disabled/in DSI mode with an ungated DDI clock, gate it
Jul 04 09:03:23 abreu kernel: usb 1-5: reset high-speed USB device 
number 4 using xhci_hcd
Jul 04 09:03:23 abreu kernel: usb 1-3: reset full-speed USB device 
number 2 using xhci_hcd
Jul 04 09:03:23 abreu kernel: usb 1-4: reset full-speed USB device 
number 3 using xhci_hcd
Jul 04 09:03:23 abreu kernel: OOM killer enabled.
Jul 04 09:03:23 abreu kernel: Restarting tasks ... done.
Jul 04 09:03:23 abreu kernel: random: crng reseeded on system resumption
-- Boot cd4eeb2265834de6ba3c3b5d747d9481 --
Jul 04 09:09:36 abreu kernel: Linux version 6.10.0-rc6 
(build@bohemianrhapsody.molgen.mpg.de) (gcc (Debian 13.3.0-1) 13.3.0, 
GNU ld (GNU Binutils for Debian) 2.42.50.20240625) #211 SMP 
PREEMPT_DYNAMIC Mon Jul  1 08:23:19 CEST 2024
[…]
```

I think it is *not* a regression, but – as the logs do not contain any 
hints – I am not sure.


Kind regards,

Paul


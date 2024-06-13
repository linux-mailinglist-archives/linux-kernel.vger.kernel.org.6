Return-Path: <linux-kernel+bounces-213434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF90A90754C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 16:38:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 341661F22637
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 14:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEE7B145B12;
	Thu, 13 Jun 2024 14:38:06 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2FF7145A02
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 14:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718289485; cv=none; b=FHXGKchs5muPQMr3Um2ezzvgQIkgue1E88tHkwP+5G6CPm+XTBRYvoFyqoCmpUw8cwXAbVU04N04IHryUBp57xVxnNEP4hCr7m5H47Wmq4B/pkbJAvHFpKLzvrpAI6Hjw0JkpsRqPNNk1sMys7nwSzx1sg0KOr8DF39shM/MI+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718289485; c=relaxed/simple;
	bh=BnVR8vzGHh2J/oL/ahbqr79LhRTdhQTrUGTjI/EJfrU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=nUghM4e7F+tfIwh7aIANvAJx/NuvGOvMIWMZHEG3iJhG0LjEMU6e/tRiusGtzZ6ZYGRklBZPFuJWh1JZP4yD1WhuC0ODcAoNQplrdqdXXUMtuulYBQYDoJJJodZ/A32jFNvWxj42tshyKSrA83wmVMVCJFjMxqTHbVTuPEsAgk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7eb69c65e9aso102662139f.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 07:38:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718289483; x=1718894283;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tlGosivK99xfULBDwDjf3EiSFLoqom/9ba5Xgj7OdqQ=;
        b=Pvn9BZAFG5O8DyZLHxydfSsv5SNuMMdwqZrE1itdlUeBJNvRzYe3A7NT9uIuCx66R6
         kDn70Efkx/QBZE0MZGvPMVy0q9/1o1puJw08kxrT5KyJlbFUmEZd5lIh41rQ3f83CofB
         Ae0j4l4GPyhsZyEh8JHc045mHIwjNZ/YXFccWIVBrVQlq4P5t9p22p7hTjFPu7XV5Lj2
         G6MO0MKYIpi6GupimKHqraEZzWyuQ1ZHrgH9P5hag1XNIsIOYylf8upqz6N5o/eNl+as
         zQbJVDdBfGT22xpEOGUCAUYTstuudpbulYW4xdhm/j4jOXT3RqFnzBhWxYcL/Px+0D0o
         892A==
X-Gm-Message-State: AOJu0Yyi3ah4JlFwo2mJ4sdESz7dKM3maE6cThyIjr96THtLlm/4Cpg3
	pAe8nVZPHxv/9Kcxz5KUd2EAoQi/qkE3qjpz6jPvpq1zdQacZ+M0dkZdQq0+RsF3s5tKiTq3Ejt
	wPOJDxEOFNG9OCT0bbQhDaHHjtbpfrTGbpOnt9oqilsWAECGp9I2CGwk=
X-Google-Smtp-Source: AGHT+IFobXHWibBsKAwWcbNGiMbAmk6UUVb6sVpFOUW8Wo3kFBiVEPZlDgMqZAaWyIoi+fHMHwcKx9DyLtCkquglDZE/7S4lSEnP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:629b:b0:4b7:c557:1613 with SMTP id
 8926c6da1cb9f-4b93ee38efbmr176760173.3.1718289483066; Thu, 13 Jun 2024
 07:38:03 -0700 (PDT)
Date: Thu, 13 Jun 2024 07:38:03 -0700
In-Reply-To: <PN2PR01MB48912834FC1742DCE6033E1FFCC12@PN2PR01MB4891.INDPRD01.PROD.OUTLOOK.COM>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004288c0061ac672f6@google.com>
Subject: Re: [syzbot] [bpf?] KMSAN: uninit-value in htab_lru_percpu_map_lookup_percpu_elem
From: syzbot <syzbot+1971e47e5210c718db3c@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	wojciech.gladysz@infogain.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

61ee5452e1b2df'
[   49.565928][    T1] ima: Allocated hash algorithm: sha256
[   49.572049][    T1] ima: No architecture policies found
[   49.578974][    T1] evm: Initialising EVM extended attributes:
[   49.585220][    T1] evm: security.selinux (disabled)
[   49.590764][    T1] evm: security.SMACK64 (disabled)
[   49.595968][    T1] evm: security.SMACK64EXEC (disabled)
[   49.601835][    T1] evm: security.SMACK64TRANSMUTE (disabled)
[   49.608506][    T1] evm: security.SMACK64MMAP (disabled)
[   49.614038][    T1] evm: security.apparmor
[   49.618451][    T1] evm: security.ima
[   49.622436][    T1] evm: security.capability
[   49.627502][    T1] evm: HMAC attrs: 0x1
[   49.636597][    T1] PM:   Magic number: 12:387:485
[   49.642665][    T1] usb usb18-port6: hash matches
[   49.648999][    T1] usb usb17-port7: hash matches
[   49.655774][    T1] printk: legacy console [netcon0] enabled
[   49.662095][    T1] netconsole: network logging started
[   49.669345][    T1] gtp: GTP module loaded (pdp ctx size 128 bytes)
[   49.678657][    T1] rdma_rxe: loaded
[   49.684488][    T1] cfg80211: Loading compiled-in X.509 certificates for=
 regulatory database
[   49.706425][    T1] Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[   49.724152][    T1] Loaded X.509 cert 'wens: 61c038651aabdcf94bd0ac7ff06=
c7248db18c600'
[   49.733298][    T1] clk: Disabling unused clocks
[   49.739237][    T1] ALSA device list:
[   49.743250][    T1]   #0: Dummy 1
[   49.747040][    T1]   #1: Loopback 1
[   49.750957][    T1]   #2: Virtual MIDI Card 1
[   49.761414][   T43] platform regulatory.0: Direct firmware load for regu=
latory.db failed with error -2
[   49.771525][   T43] platform regulatory.0: Falling back to sysfs fallbac=
k for: regulatory.db
[   49.781327][    T1] md: Waiting for all devices to be available before a=
utodetect
[   49.789841][    T1] md: If you don't use raid, use raid=3Dnoautodetect
[   49.796709][    T1] md: Autodetecting RAID arrays.
[   49.801753][    T1] md: autorun ...
[   49.805475][    T1] md: ... autorun DONE.
[   49.898217][    T1] EXT4-fs (sda1): mounted filesystem 5941fea2-f5fa-4b4=
e-b5ef-9af118b27b95 ro with ordered data mode. Quota mode: none.
[   49.911801][    T1] VFS: Mounted root (ext4 filesystem) readonly on devi=
ce 8:1.
[   49.935132][    T1] devtmpfs: mounted
[   50.190758][    T1] Freeing unused kernel image (initmem) memory: 37036K
[   50.202710][    T1] Write protecting the kernel read-only data: 262144k
[   50.249033][    T1] Freeing unused kernel image (rodata/data gap) memory=
: 1808K
[   51.885170][    T1] x86/mm: Checked W+X mappings: passed, no W+X pages f=
ound.
[   51.895531][    T1] x86/mm: Checking user space page tables
[   53.391911][    T1] x86/mm: Checked W+X mappings: passed, no W+X pages f=
ound.
[   53.401141][    T1] Failed to set sysctl parameter 'kernel.hung_task_all=
_cpu_backtrace=3D1': parameter not found
[   53.422983][    T1] Failed to set sysctl parameter 'max_rcu_stall_to_pan=
ic=3D1': parameter not found
[   53.434940][    T1] Run /sbin/init as init process
[   54.937583][ T4446] mount (4446) used greatest stack depth: 8144 bytes l=
eft
[   55.037752][ T4447] EXT4-fs (sda1): re-mounted 5941fea2-f5fa-4b4e-b5ef-9=
af118b27b95 r/w. Quota mode: none.
mount: mounting smackfs on /sys/fs/smackfs failed: No such file or director=
y
mount: mounting selinuxfs on /sys/fs/selinux failed: No such file or direct=
ory
[   55.371085][ T4450] mount (4450) used greatest stack depth: 5568 bytes l=
eft
Starting syslogd: OK
Starting acpid: OK
Starting klogd: OK
Running sysctl: OK
Populating /dev using udev: [   59.193733][ T4480] udevd[4480]: starting ve=
rsion 3.2.11
[   62.697884][ T4481] udevd[4481]: starting eudev-3.2.11
[   62.710663][ T4480] udevd (4480) used greatest stack depth: 5264 bytes l=
eft
done
Starting system message bus: done
Starting iptables: OK
Starting network: OK
Starting dhcpcd...
dhcpcd-9.4.1 starting
dev: loaded udev
DUID 00:04:98:24:4c:28:99:7c:d9:70:fe:51:ca:fe:56:33:2c:7d
forked to background, child pid 4693
no interfaces have a carrier
[  110.077072][ T4694] 8021q: adding VLAN 0 to HW filter on device bond0
[  110.114606][ T4694] eql: remember to turn off Van-Jacobson compression o=
n your slave devices
Starting sshd: [  111.638151][   T43] cfg80211: failed to load regulatory.d=
b
OK


syzkaller

syzkaller login: [  115.668614][    C0] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[  115.675770][    C0] BUG: KMSAN: uninit-value in receive_buf+0x25e3/0x5fd=
0
[  115.682913][    C0]  receive_buf+0x25e3/0x5fd0
[  115.687725][    C0]  virtnet_poll+0xd1c/0x23c0
[  115.692508][    C0]  __napi_poll+0xe7/0x980
[  115.697035][    C0]  net_rx_action+0x82a/0x1850
[  115.701947][    C0]  handle_softirqs+0x1ce/0x800
[  115.706920][    C0]  __irq_exit_rcu+0x68/0x120
[  115.711977][    C0]  irq_exit_rcu+0x12/0x20
[  115.716495][    C0]  common_interrupt+0x94/0xa0
[  115.721393][    C0]  asm_common_interrupt+0x2b/0x40
[  115.726789][    C0]  kmsan_metadata_is_contiguous+0x11/0x1e0
[  115.732777][    C0]  kmsan_get_shadow_origin_ptr+0x2a/0xb0
[  115.738611][    C0]  __msan_metadata_ptr_for_load_8+0x24/0x40
[  115.744707][    C0]  kmem_cache_alloc_noprof+0x1b0/0xb20
[  115.750434][    C0]  anon_vma_fork+0x2c8/0xad0
[  115.755224][    C0]  copy_mm+0x1b57/0x3ca0
[  115.759770][    C0]  copy_process+0x26f7/0x5b90
[  115.764746][    C0]  kernel_clone+0x401/0x1040
[  115.769622][    C0]  __x64_sys_clone+0x25c/0x360
[  115.774688][    C0]  x64_sys_call+0x2a45/0x3b90
[  115.779774][    C0]  do_syscall_64+0xcd/0x1e0
[  115.784469][    C0]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  115.790699][    C0]=20
[  115.793105][    C0] Uninit was created at:
[  115.797720][    C0]  __alloc_pages_noprof+0x9d6/0xe70
[  115.803195][    C0]  alloc_pages_mpol_noprof+0x299/0x990
[  115.808997][    C0]  alloc_pages_noprof+0x1bf/0x1e0
[  115.814258][    C0]  skb_page_frag_refill+0x2bf/0x7c0
[  115.819691][    C0]  virtnet_rq_alloc+0x43/0xbb0
[  115.824701][    C0]  try_fill_recv+0x3f0/0x2f50
[  115.829565][    C0]  virtnet_open+0x1cc/0xb00
[  115.834627][    C0]  __dev_open+0x546/0x6f0
[  115.839151][    C0]  __dev_change_flags+0x309/0x9a0
[  115.844358][    C0]  dev_change_flags+0x8e/0x1d0
[  115.849310][    C0]  devinet_ioctl+0x13ec/0x22c0
[  115.854298][    C0]  inet_ioctl+0x4bd/0x6d0
[  115.858825][    C0]  sock_do_ioctl+0xb7/0x540
[  115.863572][    C0]  sock_ioctl+0x727/0xd70
[  115.868115][    C0]  __se_sys_ioctl+0x261/0x450
[  115.872978][    C0]  __x64_sys_ioctl+0x96/0xe0
[  115.877780][    C0]  x64_sys_call+0x18c0/0x3b90
[  115.882898][    C0]  do_syscall_64+0xcd/0x1e0
[  115.887598][    C0]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  115.894138][    C0]=20
[  115.896697][    C0] CPU: 0 PID: 4833 Comm: dhcpcd-run-hook Not tainted 6=
.10.0-rc3-syzkaller-00022-g78161c936167 #0
[  115.907699][    C0] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 06/07/2024
[  115.918263][    C0] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[  115.925284][    C0] Disabling lock debugging due to kernel taint
[  115.931598][    C0] Kernel panic - not syncing: kmsan.panic set ...
[  115.938121][    C0] CPU: 0 PID: 4833 Comm: dhcpcd-run-hook Tainted: G   =
 B              6.10.0-rc3-syzkaller-00022-g78161c936167 #0
[  115.951147][    C0] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 06/07/2024
[  115.961392][    C0] Call Trace:
[  115.964735][    C0]  <IRQ>
[  115.967631][    C0]  dump_stack_lvl+0x216/0x2d0
[  115.972463][    C0]  ? kmsan_get_shadow_origin_ptr+0x4d/0xb0
[  115.978480][    C0]  dump_stack+0x1e/0x30
[  115.982741][    C0]  panic+0x4e2/0xcd0
[  115.986784][    C0]  ? kmsan_get_metadata+0x81/0x1d0
[  115.992099][    C0]  kmsan_report+0x2d5/0x2e0
[  115.996714][    C0]  ? kmsan_get_metadata+0x146/0x1d0
[  116.002010][    C0]  ? __msan_warning+0x95/0x120
[  116.007035][    C0]  ? receive_buf+0x25e3/0x5fd0
[  116.011916][    C0]  ? virtnet_poll+0xd1c/0x23c0
[  116.016876][    C0]  ? __napi_poll+0xe7/0x980
[  116.021526][    C0]  ? net_rx_action+0x82a/0x1850
[  116.026608][    C0]  ? handle_softirqs+0x1ce/0x800
[  116.031670][    C0]  ? __irq_exit_rcu+0x68/0x120
[  116.036542][    C0]  ? irq_exit_rcu+0x12/0x20
[  116.041163][    C0]  ? common_interrupt+0x94/0xa0
[  116.046211][    C0]  ? asm_common_interrupt+0x2b/0x40
[  116.051608][    C0]  ? kmsan_metadata_is_contiguous+0x11/0x1e0
[  116.057724][    C0]  ? kmsan_get_shadow_origin_ptr+0x2a/0xb0
[  116.063734][    C0]  ? __msan_metadata_ptr_for_load_8+0x24/0x40
[  116.069923][    C0]  ? kmem_cache_alloc_noprof+0x1b0/0xb20
[  116.075660][    C0]  ? anon_vma_fork+0x2c8/0xad0
[  116.080547][    C0]  ? copy_mm+0x1b57/0x3ca0
[  116.085158][    C0]  ? copy_process+0x26f7/0x5b90
[  116.090122][    C0]  ? kernel_clone+0x401/0x1040
[  116.095009][    C0]  ? __x64_sys_clone+0x25c/0x360
[  116.100114][    C0]  ? x64_sys_call+0x2a45/0x3b90
[  116.105088][    C0]  ? do_syscall_64+0xcd/0x1e0
[  116.109969][    C0]  ? entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  116.116530][    C0]  ? kmsan_internal_memmove_metadata+0x17b/0x230
[  116.123065][    C0]  ? kmsan_get_metadata+0x146/0x1d0
[  116.128453][    C0]  ? kmsan_get_metadata+0x146/0x1d0
[  116.133856][    C0]  ? page_to_skb+0xdae/0x1620
[  116.138636][    C0]  ? kmsan_get_metadata+0x146/0x1d0
[  116.143993][    C0]  __msan_warning+0x95/0x120
[  116.148713][    C0]  receive_buf+0x25e3/0x5fd0
[  116.153414][    C0]  ? kmsan_get_metadata+0x146/0x1d0
[  116.158922][    C0]  ? kmsan_get_shadow_origin_ptr+0x4d/0xb0
[  116.164985][    C0]  virtnet_poll+0xd1c/0x23c0
[  116.169720][    C0]  ? __pfx_virtnet_poll+0x10/0x10
[  116.174942][    C0]  __napi_poll+0xe7/0x980
[  116.179431][    C0]  ? kmsan_get_metadata+0x146/0x1d0
[  116.184754][    C0]  net_rx_action+0x82a/0x1850
[  116.189579][    C0]  ? sched_clock_cpu+0x55/0x870
[  116.194593][    C0]  ? __pfx_net_rx_action+0x10/0x10
[  116.199846][    C0]  handle_softirqs+0x1ce/0x800
[  116.204734][    C0]  __irq_exit_rcu+0x68/0x120
[  116.209452][    C0]  irq_exit_rcu+0x12/0x20
[  116.213891][    C0]  common_interrupt+0x94/0xa0
[  116.218689][    C0]  </IRQ>
[  116.221668][    C0]  <TASK>
[  116.224666][    C0]  asm_common_interrupt+0x2b/0x40
[  116.229996][    C0] RIP: 0010:kmsan_metadata_is_contiguous+0x11/0x1e0
[  116.236882][    C0] Code: 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 9=
0 90 90 90 90 90 90 90 90 90 66 0f 1f 00 55 48 89 e5 41 57 41 56 41 55 41 5=
4 53 <48> 83 ec 28 41 b7 01 48 85 f6 0f 84 fa 00 00 00 49 89 f6 49 89 fd
[  116.256797][    C0] RSP: 0018:ffff88811798b800 EFLAGS: 00000202
[  116.263179][    C0] RAX: 0000000000000000 RBX: 0000000000000286 RCX: 000=
000023fd2eed8
[  116.271335][    C0] RDX: 0000000000000000 RSI: 0000000000000008 RDI: fff=
f88813fcaaed0
[  116.279678][    C0] RBP: ffff88811798b828 R08: ffffea000000000f R09: 000=
0000000000000
[  116.287830][    C0] R10: ffff88811718b8e0 R11: 0000000000000004 R12: 000=
0000000000000
[  116.296069][    C0] R13: 00000000000aaed0 R14: 0000000000000000 R15: fff=
f88813fcaaed0
[  116.304176][    C0]  kmsan_get_shadow_origin_ptr+0x2a/0xb0
[  116.309957][    C0]  __msan_metadata_ptr_for_load_8+0x24/0x40
[  116.315975][    C0]  kmem_cache_alloc_noprof+0x1b0/0xb20
[  116.321559][    C0]  ? anon_vma_fork+0x2c8/0xad0
[  116.326458][    C0]  anon_vma_fork+0x2c8/0xad0
[  116.331167][    C0]  ? kmsan_get_shadow_origin_ptr+0x4d/0xb0
[  116.337093][    C0]  ? kmsan_get_metadata+0x146/0x1d0
[  116.342519][    C0]  copy_mm+0x1b57/0x3ca0
[  116.346908][    C0]  copy_process+0x26f7/0x5b90
[  116.351896][    C0]  kernel_clone+0x401/0x1040
[  116.356596][    C0]  ? kmsan_get_metadata+0x146/0x1d0
[  116.361896][    C0]  ? kmsan_get_metadata+0x146/0x1d0
[  116.367640][    C0]  ? __msan_memset+0xf5/0x1b0
[  116.372457][    C0]  __x64_sys_clone+0x25c/0x360
[  116.377377][    C0]  x64_sys_call+0x2a45/0x3b90
[  116.382201][    C0]  do_syscall_64+0xcd/0x1e0
[  116.386840][    C0]  ? clear_bhb_loop+0x25/0x80
[  116.391663][    C0]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  116.397791][    C0] RIP: 0033:0x7f5286b82a12
[  116.402300][    C0] Code: 41 5d 41 5e 41 5f c3 64 48 8b 04 25 10 00 00 0=
0 45 31 c0 31 d2 31 f6 bf 11 00 20 01 4c 8d 90 d0 02 00 00 b8 38 00 00 00 0=
f 05 <48> 3d 00 f0 ff ff 76 10 48 8b 15 e7 43 0f 00 f7 d8 64 89 02 48 83
[  116.422246][    C0] RSP: 002b:00007ffc58a2d428 EFLAGS: 00000246 ORIG_RAX=
: 0000000000000038
[  116.430864][    C0] RAX: ffffffffffffffda RBX: 000055b776464901 RCX: 000=
07f5286b82a12
[  116.438942][    C0] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000=
0000001200011
[  116.447162][    C0] RBP: 000055b776465ba0 R08: 0000000000000000 R09: 3c0=
0000000001001
[  116.455213][    C0] R10: 00007f5286a48650 R11: 0000000000000246 R12: 000=
055b776468368
[  116.463463][    C0] R13: 0000000000000000 R14: 0000000000000000 R15: 000=
0000000000000
[  116.471794][    C0]  </TASK>
[  116.475163][    C0] Kernel Offset: disabled
[  116.479655][    C0] Rebooting in 86400 seconds..


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
 -ffile-prefix-map=3D/tmp/go-build572936856=3D/tmp/go-build -gno-record-gcc=
-switches'

git status (err=3D<nil>)
HEAD detached at c8349e4853
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
/syzkaller/prog.GitRevision=3Dc8349e48534ea6d8f01515335d95de8ebf5da8df -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20240412-102842'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-fuzzer=
 github.com/google/syzkaller/syz-fuzzer
GOOS=3Dlinux GOARCH=3Damd64 go build "-ldflags=3D-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3Dc8349e48534ea6d8f01515335d95de8ebf5da8df -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20240412-102842'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-execpr=
og github.com/google/syzkaller/tools/syz-execprog
GOOS=3Dlinux GOARCH=3Damd64 go build "-ldflags=3D-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3Dc8349e48534ea6d8f01515335d95de8ebf5da8df -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20240412-102842'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-stress=
 github.com/google/syzkaller/tools/syz-stress
mkdir -p ./bin/linux_amd64
gcc -o ./bin/linux_amd64/syz-executor executor/executor.cc \
	-m64 -O2 -pthread -Wall -Werror -Wparentheses -Wunused-const-variable -Wfr=
ame-larger-than=3D16384 -Wno-stringop-overflow -Wno-array-bounds -Wno-forma=
t-overflow -Wno-unused-but-set-variable -Wno-unused-command-line-argument -=
static-pie -fpermissive -w -DGOOS_linux=3D1 -DGOARCH_amd64=3D1 \
	-DHOSTGOOS_linux=3D1 -DGIT_REVISION=3D\"c8349e48534ea6d8f01515335d95de8ebf=
5da8df\"


Error text is too large and was truncated, full error text is at:
https://syzkaller.appspot.com/x/error.txt?x=3D11313a2e980000


Tested on:

commit:         78161c93 kernel/bpf: KMSAN: uninit-value in htab_lru_p..
git tree:       https://linux.googlesource.com/linux/kernel/git/torvalds/li=
nux
kernel config:  https://syzkaller.appspot.com/x/.config?x=3D3486f1660f47f85=
5
dashboard link: https://syzkaller.appspot.com/bug?extid=3D1971e47e5210c718d=
b3c
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debia=
n) 2.40

Note: no patches were applied.


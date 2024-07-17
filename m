Return-Path: <linux-kernel+bounces-255424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AEE493408F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 18:36:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82654B22B48
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 16:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B532D181CEF;
	Wed, 17 Jul 2024 16:36:07 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2CD1CF8A
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 16:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721234166; cv=none; b=pZWxrwOo/DvUiwg4//Hr/9ECysIcHtgf6BCYNOxLBah7vYyzMU63p1FIq4zUCnGvkhI9cGAZdHBaO7JL07fZY3vWVuxgT8lRegKo5OdXGHQJqwE7cCaT+LNxg4rxKviWBuo3O+wkwhFbC1JQ/0w502ljJv7F9V++7Zeogg6eLmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721234166; c=relaxed/simple;
	bh=TtyVsmfDnH2ZEM6uy49k6aJ+AY6pnmkX5MGwOPU96Nk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=pqaT00SOZJBFIxEwxw1CE6Jrk24m1GXB/f/6cK9Cm18CjyQUYZTo5EAb8S3cNd612NsM2X6DQhuX4HHDNkvQhRcEy7hTGsYLqeVnAXQntmVgpRTglfOiSDXw+VN2KDfv5FoelXBhxTPRyLvZpUVQd34QG2xGtYKaV0nAhXKYjnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7fb15d52c5cso192210439f.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 09:36:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721234164; x=1721838964;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NlPG3pHZ5htpdarEcohF6MCQdXFH3me5tD9OLoHlj/I=;
        b=dPUPDQXL63AcUvCpPDyiEku3wlJ/mXPlHlRHtG8UFTLujoes4pk2AC/xx2W99aae7c
         UNGhI7u4zcjUkhCrIiQho0MFWo3M+TUIkYfd0L+i8UskVzsCCO2mvHz1nEYZn6VNa2kx
         ILEnbXo5wqVxqXj2xyUVsurMfE2qEXfyuPvuhRky42jQThdj5U6pfRCXoX7N/lBa9njw
         EQwO7PQz0fpXN+CYTv9HMkcIOLLavfFpGyWTLg7Eh8JCG8Ywjzo+FKpJCCJvZ0QRIt16
         Zhl4HP8VmQccznokC2GV3cARxJ1woGDgvhyHkogxyjS3dlBnQ/T4kwe2SAEt+vAlLn02
         l5/g==
X-Forwarded-Encrypted: i=1; AJvYcCWvHSfkfgxUDtTQFvIioUp+WvwAsQpb+fIqCKiv3jNLzyMycOLSsvKKo4X7kUGI5VZ/h6g8vjHJ/2j/uqPVzyViRH3/dWnyFEc7ESc0
X-Gm-Message-State: AOJu0YyWDVYkrmPqaRCXkA9FDKn5HKaIaTYWQwMx93eVzDMVqXyn6G6B
	Xb1QeY8MI9/nU31N1SJ3yDCYnhBpWe0oWdBOp3v0x9AcjIv6ueScH/ymXBhmwYcPE9M9WU9ADtK
	bRu7xtpfApE+Jxtic76KAnRVT37np1dHm+wk/Stl75wVkHkcQXokXEkQ=
X-Google-Smtp-Source: AGHT+IHkD7xA5ZQcqz29Oxg4IiuMgFJnDdcTaeC0IA9/IIVSHJhTtzmI/3mvkcoKO07P6dhorvOhYo7oEo7WavZ/xPkmiyK92m+f
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ca46:0:b0:375:9cb9:9d04 with SMTP id
 e9e14a558f8ab-395574243f5mr1844825ab.3.1721234164160; Wed, 17 Jul 2024
 09:36:04 -0700 (PDT)
Date: Wed, 17 Jul 2024 09:36:04 -0700
In-Reply-To: <20240717145115.9515-1-aha310510@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ee2f20061d740ed4@google.com>
Subject: Re: [syzbot] [net?] KMSAN: uninit-value in hsr_get_node (3)
From: syzbot <syzbot+a81f2759d022496b40ab@syzkaller.appspotmail.com>
To: aha310510@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

48.966940][    T1] Timer migration: 1 hierarchy levels; 8 children per grou=
p; 0 crossnode level
[   49.476665][    T1] registered taskstats version 1
[   49.903659][    T1] Loading compiled-in X.509 certificates
[   49.948716][    T1] Loaded X.509 cert 'Build time autogenerated kernel k=
ey: 7a9f7c0e186ee0aeb7cac048f6481049478c3b01'
[   50.193178][    T1] zswap: loaded using pool lzo/zsmalloc
[   50.202395][    T1] Demotion targets for Node 0: null
[   50.207808][    T1] Demotion targets for Node 1: null
[   50.215494][    T1] Key type .fscrypt registered
[   50.220532][    T1] Key type fscrypt-provisioning registered
[   50.227797][    T1] kAFS: Red Hat AFS client v0.1 registering.
[   50.261264][    T1] Btrfs loaded, assert=3Don, ref-verify=3Don, zoned=3D=
yes, fsverity=3Dyes
[   50.287630][    T1] Key type encrypted registered
[   50.292626][    T1] AppArmor: AppArmor sha256 policy hashing enabled
[   50.299502][    T1] ima: No TPM chip found, activating TPM-bypass!
[   50.307180][    T1] Loading compiled-in module X.509 certificates
[   50.350409][    T1] Loaded X.509 cert 'Build time autogenerated kernel k=
ey: 7a9f7c0e186ee0aeb7cac048f6481049478c3b01'
[   50.361855][    T1] ima: Allocated hash algorithm: sha256
[   50.368263][    T1] ima: No architecture policies found
[   50.374819][    T1] evm: Initialising EVM extended attributes:
[   50.380893][    T1] evm: security.selinux (disabled)
[   50.386225][    T1] evm: security.SMACK64 (disabled)
[   50.391519][    T1] evm: security.SMACK64EXEC (disabled)
[   50.397102][    T1] evm: security.SMACK64TRANSMUTE (disabled)
[   50.403132][    T1] evm: security.SMACK64MMAP (disabled)
[   50.408774][    T1] evm: security.apparmor
[   50.413106][    T1] evm: security.ima
[   50.417038][    T1] evm: security.capability
[   50.421495][    T1] evm: HMAC attrs: 0x1
[   50.430616][    T1] PM:   Magic number: 0:906:489
[   50.437158][    T1] bdi 43:128: hash matches
[   50.443197][    T1] printk: legacy console [netcon0] enabled
[   50.449358][    T1] netconsole: network logging started
[   50.456386][    T1] gtp: GTP module loaded (pdp ctx size 128 bytes)
[   50.465653][    T1] rdma_rxe: loaded
[   50.471498][    T1] cfg80211: Loading compiled-in X.509 certificates for=
 regulatory database
[   50.492635][    T1] Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[   50.510300][    T1] Loaded X.509 cert 'wens: 61c038651aabdcf94bd0ac7ff06=
c7248db18c600'
[   50.519733][    T1] clk: Disabling unused clocks
[   50.524657][    T1] ALSA device list:
[   50.528687][    T1]   #0: Dummy 1
[   50.532268][    T1]   #1: Loopback 1
[   50.536369][    T1]   #2: Virtual MIDI Card 1
[   50.546627][   T10] platform regulatory.0: Direct firmware load for regu=
latory.db failed with error -2
[   50.557233][   T10] platform regulatory.0: Falling back to sysfs fallbac=
k for: regulatory.db
[   50.566838][    T1] md: Waiting for all devices to be available before a=
utodetect
[   50.574890][    T1] md: If you don't use raid, use raid=3Dnoautodetect
[   50.581546][    T1] md: Autodetecting RAID arrays.
[   50.587056][    T1] md: autorun ...
[   50.590820][    T1] md: ... autorun DONE.
[   50.731901][    T1] EXT4-fs (sda1): mounted filesystem 5941fea2-f5fa-4b4=
e-b5ef-9af118b27b95 ro with ordered data mode. Quota mode: none.
[   50.745418][    T1] VFS: Mounted root (ext4 filesystem) readonly on devi=
ce 8:1.
[   50.827185][    T1] devtmpfs: mounted
[   51.097752][    T1] Freeing unused kernel image (initmem) memory: 37116K
[   51.109692][    T1] Write protecting the kernel read-only data: 262144k
[   51.156794][    T1] Freeing unused kernel image (rodata/data gap) memory=
: 1752K
[   52.824942][    T1] x86/mm: Checked W+X mappings: passed, no W+X pages f=
ound.
[   52.835392][    T1] x86/mm: Checking user space page tables
[   54.345909][    T1] x86/mm: Checked W+X mappings: passed, no W+X pages f=
ound.
[   54.354936][    T1] Failed to set sysctl parameter 'kernel.hung_task_all=
_cpu_backtrace=3D1': parameter not found
[   54.376222][    T1] Failed to set sysctl parameter 'max_rcu_stall_to_pan=
ic=3D1': parameter not found
[   54.387939][    T1] Run /sbin/init as init process
[   56.033419][ T4451] mount (4451) used greatest stack depth: 8144 bytes l=
eft
[   56.138109][ T4452] EXT4-fs (sda1): re-mounted 5941fea2-f5fa-4b4e-b5ef-9=
af118b27b95 r/w. Quota mode: none.
mount: mounting smackfs on /sys/fs/smackfs failed: No such file or director=
y
mount: mounting selinuxfs on /sys/fs/selinux failed: No such file or direct=
ory
[   56.471743][ T4455] mount (4455) used greatest stack depth: 5536 bytes l=
eft
Starting syslogd: OK
Starting acpid: OK
Starting klogd: OK
Running sysctl: OK
Populating /dev using udev: [   60.408422][ T4485] udevd[4485]: starting ve=
rsion 3.2.11
[   64.035314][ T4486] udevd[4486]: starting eudev-3.2.11
[   64.047218][ T4485] udevd (4485) used greatest stack depth: 5328 bytes l=
eft
done
Starting system message bus: done
Starting iptables: OK
Starting network: OK
Starting dhcpcd...
dhcpcd-9.4.1 starting
dev: loaded udev
DUID 00:04:98:24:4c:28:99:7c:d9:70:fe:51:ca:fe:56:33:2c:7d
[  111.696683][   T10] cfg80211: failed to load regulatory.db
forked to background, child pid 4699
[  112.850716][ T4700] 8021q: adding VLAN 0 to HW filter on device bond0
[  112.877161][ T4700] eql: remember to turn off Van-Jacobson compression o=
n your slave devices
Starting sshd: [  115.050362][ T4785] sshd (4785) used greatest stack depth=
: 4360 bytes left
OK


syzkaller

syzkaller login: [  116.643435][    C0] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[  116.650771][    C0] BUG: KMSAN: uninit-value in receive_buf+0xba1/0x25d0
[  116.657866][    C0]  receive_buf+0xba1/0x25d0
[  116.662559][    C0]  virtnet_poll+0x529c/0x6a20
[  116.667462][    C0]  __napi_poll+0xe7/0x980
[  116.671960][    C0]  net_rx_action+0xa5a/0x19b0
[  116.676848][    C0]  handle_softirqs+0x1ce/0x800
[  116.681888][    C0]  __irq_exit_rcu+0x68/0x120
[  116.686694][    C0]  irq_exit_rcu+0x12/0x20
[  116.691222][    C0]  common_interrupt+0x94/0xa0
[  116.696212][    C0]  asm_common_interrupt+0x2b/0x40
[  116.701531][    C0]  acpi_safe_halt+0x25/0x30
[  116.706292][    C0]  acpi_idle_do_entry+0x22/0x40
[  116.711361][    C0]  acpi_idle_enter+0xa1/0xc0
[  116.716198][    C0]  cpuidle_enter_state+0xcb/0x250
[  116.721427][    C0]  cpuidle_enter+0x7f/0xf0
[  116.726170][    C0]  do_idle+0x551/0x750
[  116.730471][    C0]  cpu_startup_entry+0x65/0x80
[  116.735581][    C0]  rest_init+0x1e8/0x260
[  116.740082][    C0]  start_kernel+0x92c/0xa70
[  116.744831][    C0]  x86_64_start_reservations+0x2e/0x30
[  116.750479][    C0]  x86_64_start_kernel+0x98/0xa0
[  116.755835][    C0]  common_startup_64+0x12c/0x137
[  116.761043][    C0]=20
[  116.763470][    C0] Uninit was created at:
[  116.768120][    C0]  __alloc_pages_noprof+0x9d6/0xe70
[  116.773563][    C0]  alloc_pages_mpol_noprof+0x299/0x990
[  116.779504][    C0]  alloc_pages_noprof+0x1bf/0x1e0
[  116.784868][    C0]  skb_page_frag_refill+0x2bf/0x7c0
[  116.790292][    C0]  virtnet_rq_alloc+0x43/0xbb0
[  116.795404][    C0]  try_fill_recv+0x89c/0x3bc0
[  116.800317][    C0]  virtnet_open+0x1d8/0xd00
[  116.805145][    C0]  __dev_open+0x546/0x6f0
[  116.809680][    C0]  __dev_change_flags+0x309/0x9a0
[  116.815032][    C0]  dev_change_flags+0x8e/0x1d0
[  116.820028][    C0]  devinet_ioctl+0x13ec/0x22c0
[  116.825116][    C0]  inet_ioctl+0x4bd/0x6d0
[  116.829651][    C0]  sock_do_ioctl+0xb7/0x540
[  116.834365][    C0]  sock_ioctl+0x727/0xd70
[  116.839197][    C0]  __se_sys_ioctl+0x261/0x450
[  116.844107][    C0]  __x64_sys_ioctl+0x96/0xe0
[  116.848999][    C0]  x64_sys_call+0x18bf/0x3b90
[  116.853894][    C0]  do_syscall_64+0xcd/0x1e0
[  116.859293][    C0]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  116.865586][    C0]=20
[  116.868032][    C0] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.10.0-syz=
kaller-04472-g51835949dda3 #0
[  116.878152][    C0] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 06/07/2024
[  116.888572][    C0] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[  116.895809][    C0] Disabling lock debugging due to kernel taint
[  116.902113][    C0] Kernel panic - not syncing: kmsan.panic set ...
[  116.908671][    C0] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G    B       =
       6.10.0-syzkaller-04472-g51835949dda3 #0
[  116.919740][    C0] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 06/07/2024
[  116.929999][    C0] Call Trace:
[  116.933421][    C0]  <IRQ>
[  116.936413][    C0]  dump_stack_lvl+0x216/0x2d0
[  116.941336][    C0]  ? kmsan_get_shadow_origin_ptr+0x4d/0xb0
[  116.947440][    C0]  dump_stack+0x1e/0x30
[  116.951880][    C0]  panic+0x4e2/0xcd0
[  116.955996][    C0]  ? kmsan_get_metadata+0x61/0x1d0
[  116.961602][    C0]  kmsan_report+0x2d5/0x2e0
[  116.966223][    C0]  ? kmsan_get_metadata+0x146/0x1d0
[  116.971532][    C0]  ? kmsan_get_metadata+0x146/0x1d0
[  116.976858][    C0]  ? __msan_warning+0x95/0x120
[  116.981727][    C0]  ? receive_buf+0xba1/0x25d0
[  116.986505][    C0]  ? virtnet_poll+0x529c/0x6a20
[  116.991508][    C0]  ? __napi_poll+0xe7/0x980
[  116.996160][    C0]  ? net_rx_action+0xa5a/0x19b0
[  117.001182][    C0]  ? handle_softirqs+0x1ce/0x800
[  117.006255][    C0]  ? __irq_exit_rcu+0x68/0x120
[  117.011134][    C0]  ? irq_exit_rcu+0x12/0x20
[  117.015844][    C0]  ? common_interrupt+0x94/0xa0
[  117.020805][    C0]  ? asm_common_interrupt+0x2b/0x40
[  117.026140][    C0]  ? acpi_safe_halt+0x25/0x30
[  117.030962][    C0]  ? acpi_idle_do_entry+0x22/0x40
[  117.036126][    C0]  ? acpi_idle_enter+0xa1/0xc0
[  117.041004][    C0]  ? cpuidle_enter_state+0xcb/0x250
[  117.046344][    C0]  ? cpuidle_enter+0x7f/0xf0
[  117.051083][    C0]  ? do_idle+0x551/0x750
[  117.055489][    C0]  ? cpu_startup_entry+0x65/0x80
[  117.060596][    C0]  ? rest_init+0x1e8/0x260
[  117.065142][    C0]  ? start_kernel+0x92c/0xa70
[  117.069942][    C0]  ? x86_64_start_reservations+0x2e/0x30
[  117.075704][    C0]  ? x86_64_start_kernel+0x98/0xa0
[  117.080927][    C0]  ? common_startup_64+0x12c/0x137
[  117.086177][    C0]  ? kmsan_internal_memmove_metadata+0x17b/0x230
[  117.092679][    C0]  ? kmsan_get_metadata+0x146/0x1d0
[  117.098052][    C0]  ? kmsan_get_metadata+0x146/0x1d0
[  117.103402][    C0]  ? page_to_skb+0xdae/0x1620
[  117.108232][    C0]  __msan_warning+0x95/0x120
[  117.112999][    C0]  receive_buf+0xba1/0x25d0
[  117.117693][    C0]  virtnet_poll+0x529c/0x6a20
[  117.122498][    C0]  ? kmsan_get_metadata+0x146/0x1d0
[  117.127843][    C0]  ? kmsan_get_shadow_origin_ptr+0x4d/0xb0
[  117.133900][    C0]  ? kmsan_get_metadata+0x146/0x1d0
[  117.139362][    C0]  ? kmsan_get_metadata+0x146/0x1d0
[  117.144736][    C0]  ? __pfx_virtnet_poll+0x10/0x10
[  117.149900][    C0]  __napi_poll+0xe7/0x980
[  117.154356][    C0]  ? kmsan_get_metadata+0x146/0x1d0
[  117.159745][    C0]  net_rx_action+0xa5a/0x19b0
[  117.164549][    C0]  ? kmsan_get_metadata+0x146/0x1d0
[  117.170150][    C0]  ? kmsan_get_shadow_origin_ptr+0x4d/0xb0
[  117.176230][    C0]  ? __pfx_net_rx_action+0x10/0x10
[  117.181495][    C0]  handle_softirqs+0x1ce/0x800
[  117.186493][    C0]  __irq_exit_rcu+0x68/0x120
[  117.191354][    C0]  irq_exit_rcu+0x12/0x20
[  117.195812][    C0]  common_interrupt+0x94/0xa0
[  117.200765][    C0]  </IRQ>
[  117.203745][    C0]  <TASK>
[  117.206740][    C0]  asm_common_interrupt+0x2b/0x40
[  117.212031][    C0] RIP: 0010:acpi_safe_halt+0x25/0x30
[  117.217509][    C0] Code: 90 90 90 90 90 55 48 89 e5 65 48 8b 04 25 80 5=
e 0a 00 48 f7 00 08 00 00 00 75 10 66 90 0f 00 2d 8b fb 4f 00 f3 0f 1e fa f=
b f4 <fa> 5d c3 cc cc cc cc 0f 1f 40 00 90 90 90 90 90 90 90 90 90 90 90
[  117.237256][    C0] RSP: 0018:ffffffff91003ce8 EFLAGS: 00000246
[  117.243550][    C0] RAX: ffffffff9102bdc0 RBX: ffffffff9148a9b0 RCX: 000=
0000000000001
[  117.251879][    C0] RDX: ffff88810358e464 RSI: ffffffff9148a9b0 RDI: fff=
f88810358e464
[  117.260877][    C0] RBP: ffffffff91003ce8 R08: ffffea000000000f R09: 000=
00000000000ff
[  117.268965][    C0] R10: ffff88823f164dc2 R11: ffffffff8f8d7d30 R12: fff=
f888104e71c00
[  117.277283][    C0] R13: ffffffff9148aa30 R14: 0000000000000001 R15: 000=
0000000000001
[  117.285349][    C0]  ? __pfx_acpi_idle_enter+0x10/0x10
[  117.290848][    C0]  acpi_idle_do_entry+0x22/0x40
[  117.295937][    C0]  acpi_idle_enter+0xa1/0xc0
[  117.300690][    C0]  cpuidle_enter_state+0xcb/0x250
[  117.305878][    C0]  cpuidle_enter+0x7f/0xf0
[  117.310558][    C0]  do_idle+0x551/0x750
[  117.314882][    C0]  cpu_startup_entry+0x65/0x80
[  117.319980][    C0]  rest_init+0x1e8/0x260
[  117.324364][    C0]  start_kernel+0x92c/0xa70
[  117.329121][    C0]  x86_64_start_reservations+0x2e/0x30
[  117.334968][    C0]  x86_64_start_kernel+0x98/0xa0
[  117.340049][    C0]  common_startup_64+0x12c/0x137
[  117.345172][    C0]  </TASK>
[  117.348544][    C0] Kernel Offset: disabled
[  117.352967][    C0] Rebooting in 86400 seconds..


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
 -ffile-prefix-map=3D/tmp/go-build865784958=3D/tmp/go-build -gno-record-gcc=
-switches'

git status (err=3D<nil>)
HEAD detached at 0d592ce46e
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
/syzkaller/prog.GitRevision=3D0d592ce46ebc504d579c07e5bc3f7f3f2038c4cf -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20240415-175759'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-fuzzer=
 github.com/google/syzkaller/syz-fuzzer
GOOS=3Dlinux GOARCH=3Damd64 go build "-ldflags=3D-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3D0d592ce46ebc504d579c07e5bc3f7f3f2038c4cf -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20240415-175759'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-execpr=
og github.com/google/syzkaller/tools/syz-execprog
GOOS=3Dlinux GOARCH=3Damd64 go build "-ldflags=3D-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3D0d592ce46ebc504d579c07e5bc3f7f3f2038c4cf -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20240415-175759'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-stress=
 github.com/google/syzkaller/tools/syz-stress
mkdir -p ./bin/linux_amd64
gcc -o ./bin/linux_amd64/syz-executor executor/executor.cc \
	-m64 -O2 -pthread -Wall -Werror -Wparentheses -Wunused-const-variable -Wfr=
ame-larger-than=3D16384 -Wno-stringop-overflow -Wno-array-bounds -Wno-forma=
t-overflow -Wno-unused-but-set-variable -Wno-unused-command-line-argument -=
static-pie -fpermissive -w -DGOOS_linux=3D1 -DGOARCH_amd64=3D1 \
	-DHOSTGOOS_linux=3D1 -DGIT_REVISION=3D\"0d592ce46ebc504d579c07e5bc3f7f3f20=
38c4cf\"


Error text is too large and was truncated, full error text is at:
https://syzkaller.appspot.com/x/error.txt?x=3D1215a959980000


Tested on:

commit:         51835949 Merge tag 'net-next-6.11' of git://git.kernel..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dec91e4c9ea460c2=
a
dashboard link: https://syzkaller.appspot.com/bug?extid=3Da81f2759d022496b4=
0ab
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debia=
n) 2.40

Note: no patches were applied.


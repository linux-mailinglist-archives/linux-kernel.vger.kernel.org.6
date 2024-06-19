Return-Path: <linux-kernel+bounces-221080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD83190EBA1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 14:59:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61ED11F21CE6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 12:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E11E8146599;
	Wed, 19 Jun 2024 12:59:06 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05FBA14388C
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 12:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718801945; cv=none; b=hjJgBtpfSRJbQ0r1wOHvVZuAeZXEwJgUkbRBbtXZwORJ1GIg2hjwX5sJ80GIyU+zCKxHX6pLNdbMojnQCZpMP/kCkcMXjGI/0qJQnJocHYdnVYv3OzglMUf2h189udBM0/YaJ60Tw3RgWG6eybnG1pTDKuYMcbbomLDyKDr+jjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718801945; c=relaxed/simple;
	bh=xftBowWSRK/rsUrwlB8oUMBpAQSvHXZkl8wb7JOBVGs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=i9q6ui9DmujLX6+CJT4XRmSLEmj/rYRHbgFlvWEriWokG9+qt4vT0F7TS3ZMQaOqnDHiPXa2TnoN4Kb1pfXteiTmjkyH5DbGIokEATTDDWla/kPwqdI7Gu2tt/10JC/8NtElOGcnViAP1IfyxS7Mtwcx22fmPLyJQxB8b+Qul4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7eee7741583so375177039f.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 05:59:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718801942; x=1719406742;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h2/rnmWrc/57buZ8AIOCjTgdG9QRFmKiIiT5leFXjHc=;
        b=OOCwNEf9odD1kCya4puItuTMrUoddbDcJp27AoXOk0aNV/ZzKuys0R+891v+qi8BKt
         R5C1xWJ313Rckh4ZiqNJBde7u5xWkZKH4/QLilk1Y5Gz29eedDWoKRagWT5LTIw07Mxk
         NRYTiDitySvljCglSZRLQqv1qSWeqq3kGd20bt6usFQONnrOsh77KET62S7NGU+s0q8A
         39Jx1v91aH/FJgXbRFZ4p6EuS4xDGTNe6Zha4cxSDlN1wKYc1xEDI33XvTpJOXTpx5T+
         +FYtTz7MWUMoM4/p7Zjet9INDhCbzewhp+CODRLp2RBgVdbpMGLtMPWAdTt4MOuCLccy
         +0uw==
X-Gm-Message-State: AOJu0YwDxk0JyUlorYqo94BCvisczVCw2XOyhryXLnerwir5cvBPUv/A
	gKWZ8MrFZxlXkuMFu1XCPSNclWB9xlHoMzyduigio8CfHCD0ROPv2fBTFWWl+mXw+KouWy4MekC
	c+0eyahf9MulUgxH2DaNNaIZKXyb6EXkQyz8o8+Ok+j9sMSorSZfEXJQ=
X-Google-Smtp-Source: AGHT+IGZbN3Vn0xpqXS/4Uf6vQihpVQvdV5PbYiVy6MRdgOHQaw5RAtB6a1Irx+c8X9gORhi75ku17KSr7gVY/V8Ms0mXdjsc2jF
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cd8b:0:b0:375:b52f:3367 with SMTP id
 e9e14a558f8ab-3761d7eda8amr1628855ab.5.1718801942094; Wed, 19 Jun 2024
 05:59:02 -0700 (PDT)
Date: Wed, 19 Jun 2024 05:59:02 -0700
In-Reply-To: <ZnJDJaVcYWhKVGMq@x13.lan>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000032b967061b3dc37b@google.com>
Subject: Re: [syzbot] [bpf?] KMSAN: uninit-value in strnchr (2)
From: syzbot <syzbot+33bce7b14333572224b2@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, luis.hernandez093@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

N. advanced 2024.2 (compatibility version 15) loaded
[   46.257439][    T1] openvswitch: Open vSwitch switching datapath
[   46.275433][    T1] NET: Registered PF_VSOCK protocol family
[   46.282742][    T1] mpls_gso: MPLS GSO support
[   46.396317][    T1] IPI shorthand broadcast: enabled
[   47.876251][    T1] sched_clock: Marking stable (47840050059, 27827397)-=
>(47867108527, 768929)
[   48.611333][    T1] Timer migration: 1 hierarchy levels; 8 children per =
group; 0 crossnode level
[   48.941961][    T1] registered taskstats version 1
[   49.059098][    T1] Loading compiled-in X.509 certificates
[   49.112592][    T1] Loaded X.509 cert 'Build time autogenerated kernel k=
ey: 5bb7b7b65f626f6db8a5ee6d69ad93beb438f94f'
[   49.376337][    T1] zswap: loaded using pool lzo/zsmalloc
[   49.385556][    T1] Demotion targets for Node 0: null
[   49.391129][    T1] Demotion targets for Node 1: null
[   49.400253][    T1] Key type .fscrypt registered
[   49.405302][    T1] Key type fscrypt-provisioning registered
[   49.412815][    T1] kAFS: Red Hat AFS client v0.1 registering.
[   49.443560][    T1] Btrfs loaded, assert=3Don, ref-verify=3Don, zoned=3D=
yes, fsverity=3Dyes
[   49.470127][    T1] Key type encrypted registered
[   49.475125][    T1] AppArmor: AppArmor sha256 policy hashing enabled
[   49.482127][    T1] ima: No TPM chip found, activating TPM-bypass!
[   49.489164][    T1] Loading compiled-in module X.509 certificates
[   49.531400][    T1] Loaded X.509 cert 'Build time autogenerated kernel k=
ey: 5bb7b7b65f626f6db8a5ee6d69ad93beb438f94f'
[   49.542728][    T1] ima: Allocated hash algorithm: sha256
[   49.549021][    T1] ima: No architecture policies found
[   49.555814][    T1] evm: Initialising EVM extended attributes:
[   49.562155][    T1] evm: security.selinux (disabled)
[   49.567636][    T1] evm: security.SMACK64 (disabled)
[   49.572946][    T1] evm: security.SMACK64EXEC (disabled)
[   49.578680][    T1] evm: security.SMACK64TRANSMUTE (disabled)
[   49.584648][    T1] evm: security.SMACK64MMAP (disabled)
[   49.590376][    T1] evm: security.apparmor
[   49.594786][    T1] evm: security.ima
[   49.598857][    T1] evm: security.capability
[   49.603339][    T1] evm: HMAC attrs: 0x1
[   49.612283][    T1] PM:   Magic number: 12:487:835
[   49.617517][    T1] video4linux swradio14: hash matches
[   49.624635][    T1] usb usb22-port3: hash matches
[   49.630675][    T1] tty ptyu1: hash matches
[   49.635971][    T1] printk: legacy console [netcon0] enabled
[   49.642017][    T1] netconsole: network logging started
[   49.649176][    T1] gtp: GTP module loaded (pdp ctx size 128 bytes)
[   49.658391][    T1] rdma_rxe: loaded
[   49.664069][    T1] cfg80211: Loading compiled-in X.509 certificates for=
 regulatory database
[   49.684944][    T1] Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[   49.702203][    T1] Loaded X.509 cert 'wens: 61c038651aabdcf94bd0ac7ff06=
c7248db18c600'
[   49.711655][    T1] clk: Disabling unused clocks
[   49.716595][    T1] ALSA device list:
[   49.720534][    T1]   #0: Dummy 1
[   49.724080][    T1]   #1: Loopback 1
[   49.728089][    T1]   #2: Virtual MIDI Card 1
[   49.738481][   T43] platform regulatory.0: Direct firmware load for regu=
latory.db failed with error -2
[   49.748665][   T43] platform regulatory.0: Falling back to sysfs fallbac=
k for: regulatory.db
[   49.748944][    T1] md: Waiting for all devices to be available before a=
utodetect
[   49.765903][    T1] md: If you don't use raid, use raid=3Dnoautodetect
[   49.773649][    T1] md: Autodetecting RAID arrays.
[   49.778750][    T1] md: autorun ...
[   49.782593][    T1] md: ... autorun DONE.
[   49.891614][    T1] EXT4-fs (sda1): mounted filesystem 5941fea2-f5fa-4b4=
e-b5ef-9af118b27b95 ro with ordered data mode. Quota mode: none.
[   49.905115][    T1] VFS: Mounted root (ext4 filesystem) readonly on devi=
ce 8:1.
[   49.928519][    T1] devtmpfs: mounted
[   50.185501][    T1] Freeing unused kernel image (initmem) memory: 37040K
[   50.197206][    T1] Write protecting the kernel read-only data: 262144k
[   50.243509][    T1] Freeing unused kernel image (rodata/data gap) memory=
: 1808K
[   51.878624][    T1] x86/mm: Checked W+X mappings: passed, no W+X pages f=
ound.
[   51.889065][    T1] x86/mm: Checking user space page tables
[   53.382675][    T1] x86/mm: Checked W+X mappings: passed, no W+X pages f=
ound.
[   53.391766][    T1] Failed to set sysctl parameter 'kernel.hung_task_all=
_cpu_backtrace=3D1': parameter not found
[   53.413473][    T1] Failed to set sysctl parameter 'max_rcu_stall_to_pan=
ic=3D1': parameter not found
[   53.425614][    T1] Run /sbin/init as init process
[   55.075516][ T4447] mount (4447) used greatest stack depth: 8144 bytes l=
eft
[   55.183926][ T4448] EXT4-fs (sda1): re-mounted 5941fea2-f5fa-4b4e-b5ef-9=
af118b27b95 r/w. Quota mode: none.
mount: mounting smackfs on /sys/fs/smackfs failed: No such file or director=
y
mount: mounting selinuxfs on /sys/fs/selinux failed: No such file or direct=
ory
[   55.553694][ T4451] mount (4451) used greatest stack depth: 5568 bytes l=
eft
Starting syslogd: OK
Starting acpid: OK
Starting klogd: OK
Running sysctl: OK
Populating /dev using udev: [   59.312068][ T4481] udevd[4481]: starting ve=
rsion 3.2.11
[   62.832837][ T4482] udevd[4482]: starting eudev-3.2.11
[   62.844709][ T4481] udevd (4481) used greatest stack depth: 5280 bytes l=
eft
done
Starting system message bus: done
Starting iptables: OK
Starting network: OK
Starting dhcpcd...
dhcpcd-9.4.1 starting
dev: loaded udev
DUID 00:04:98:24:4c:28:99:7c:d9:70:fe:51:ca:fe:56:33:2c:7d
forked to background, child pid 4694
[  110.073698][ T4695] 8021q: adding VLAN 0 to HW filter on device bond0
[  110.116155][ T4695] eql: remember to turn off Van-Jacobson compression o=
n your slave devices
Starting sshd: [  111.650504][   T43] cfg80211: failed to load regulatory.d=
b
OK


syzkaller

syzkaller login: [  112.830745][    C0] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[  112.838192][    C0] BUG: KMSAN: uninit-value in receive_buf+0x25e3/0x5fd=
0
[  112.845252][    C0]  receive_buf+0x25e3/0x5fd0
[  112.850023][    C0]  virtnet_poll+0xd1c/0x23c0
[  112.854780][    C0]  __napi_poll+0xe7/0x980
[  112.859423][    C0]  net_rx_action+0x82a/0x1850
[  112.864341][    C0]  handle_softirqs+0x1ce/0x800
[  112.869293][    C0]  __irq_exit_rcu+0x68/0x120
[  112.874065][    C0]  irq_exit_rcu+0x12/0x20
[  112.878661][    C0]  common_interrupt+0x94/0xa0
[  112.883558][    C0]  asm_common_interrupt+0x2b/0x40
[  112.888792][    C0]  acpi_safe_halt+0x25/0x30
[  112.893497][    C0]  acpi_idle_do_entry+0x22/0x40
[  112.898556][    C0]  acpi_idle_enter+0xa1/0xc0
[  112.903584][    C0]  cpuidle_enter_state+0xcb/0x250
[  112.908887][    C0]  cpuidle_enter+0x7f/0xf0
[  112.913700][    C0]  do_idle+0x551/0x750
[  112.918136][    C0]  cpu_startup_entry+0x65/0x80
[  112.923057][    C0]  rest_init+0x1e8/0x260
[  112.927422][    C0]  start_kernel+0x92c/0xa70
[  112.932648][    C0]  x86_64_start_reservations+0x2e/0x30
[  112.938501][    C0]  x86_64_start_kernel+0x98/0xa0
[  112.943712][    C0]  common_startup_64+0x12c/0x137
[  112.948828][    C0]=20
[  112.951252][    C0] Uninit was created at:
[  112.955641][    C0]  __alloc_pages_noprof+0x9d6/0xe70
[  112.961079][    C0]  alloc_pages_mpol_noprof+0x299/0x990
[  112.966831][    C0]  alloc_pages_noprof+0x1bf/0x1e0
[  112.972095][    C0]  skb_page_frag_refill+0x2bf/0x7c0
[  112.977469][    C0]  virtnet_rq_alloc+0x43/0xbb0
[  112.982427][    C0]  try_fill_recv+0x3f0/0x2f50
[  112.987358][    C0]  virtnet_open+0x1cc/0xb00
[  112.992043][    C0]  __dev_open+0x546/0x6f0
[  112.996517][    C0]  __dev_change_flags+0x309/0x9a0
[  113.001724][    C0]  dev_change_flags+0x8e/0x1d0
[  113.006652][    C0]  devinet_ioctl+0x13ec/0x22c0
[  113.012019][    C0]  inet_ioctl+0x4bd/0x6d0
[  113.016592][    C0]  sock_do_ioctl+0xb7/0x540
[  113.021357][    C0]  sock_ioctl+0x727/0xd70
[  113.025895][    C0]  __se_sys_ioctl+0x261/0x450
[  113.030765][    C0]  __x64_sys_ioctl+0x96/0xe0
[  113.035526][    C0]  x64_sys_call+0x18c0/0x3b90
[  113.040407][    C0]  do_syscall_64+0xcd/0x1e0
[  113.045084][    C0]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  113.051284][    C0]=20
[  113.053783][    C0] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.10.0-rc4=
-syzkaller-00045-g92e5605a199e-dirty #0
[  113.064242][    C0] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 06/07/2024
[  113.074513][    C0] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[  113.081755][    C0] Disabling lock debugging due to kernel taint
[  113.088206][    C0] Kernel panic - not syncing: kmsan.panic set ...
[  113.094764][    C0] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G    B       =
       6.10.0-rc4-syzkaller-00045-g92e5605a199e-dirty #0
[  113.106844][    C0] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 06/07/2024
[  113.117095][    C0] Call Trace:
[  113.120554][    C0]  <IRQ>
[  113.123479][    C0]  dump_stack_lvl+0x216/0x2d0
[  113.128337][    C0]  ? kmsan_get_shadow_origin_ptr+0x4d/0xb0
[  113.134276][    C0]  dump_stack+0x1e/0x30
[  113.138587][    C0]  panic+0x4e2/0xcd0
[  113.143039][    C0]  ? kmsan_get_metadata+0xc1/0x1d0
[  113.148300][    C0]  kmsan_report+0x2d5/0x2e0
[  113.152921][    C0]  ? kmsan_get_metadata+0x146/0x1d0
[  113.158278][    C0]  ? __msan_warning+0x95/0x120
[  113.163324][    C0]  ? receive_buf+0x25e3/0x5fd0
[  113.168295][    C0]  ? virtnet_poll+0xd1c/0x23c0
[  113.173165][    C0]  ? __napi_poll+0xe7/0x980
[  113.177783][    C0]  ? net_rx_action+0x82a/0x1850
[  113.182750][    C0]  ? handle_softirqs+0x1ce/0x800
[  113.187802][    C0]  ? __irq_exit_rcu+0x68/0x120
[  113.192767][    C0]  ? irq_exit_rcu+0x12/0x20
[  113.197509][    C0]  ? common_interrupt+0x94/0xa0
[  113.202704][    C0]  ? asm_common_interrupt+0x2b/0x40
[  113.208118][    C0]  ? acpi_safe_halt+0x25/0x30
[  113.213025][    C0]  ? acpi_idle_do_entry+0x22/0x40
[  113.218184][    C0]  ? acpi_idle_enter+0xa1/0xc0
[  113.223078][    C0]  ? cpuidle_enter_state+0xcb/0x250
[  113.228499][    C0]  ? cpuidle_enter+0x7f/0xf0
[  113.233193][    C0]  ? do_idle+0x551/0x750
[  113.237517][    C0]  ? cpu_startup_entry+0x65/0x80
[  113.242633][    C0]  ? rest_init+0x1e8/0x260
[  113.247507][    C0]  ? start_kernel+0x92c/0xa70
[  113.252667][    C0]  ? x86_64_start_reservations+0x2e/0x30
[  113.258696][    C0]  ? x86_64_start_kernel+0x98/0xa0
[  113.264017][    C0]  ? common_startup_64+0x12c/0x137
[  113.269447][    C0]  ? kmsan_internal_memmove_metadata+0x17b/0x230
[  113.275901][    C0]  ? kmsan_get_metadata+0x146/0x1d0
[  113.281225][    C0]  ? kmsan_get_metadata+0x146/0x1d0
[  113.286533][    C0]  ? page_to_skb+0xdae/0x1620
[  113.291318][    C0]  ? kmsan_get_metadata+0x146/0x1d0
[  113.296722][    C0]  __msan_warning+0x95/0x120
[  113.301495][    C0]  receive_buf+0x25e3/0x5fd0
[  113.306417][    C0]  ? kmsan_get_metadata+0x146/0x1d0
[  113.311752][    C0]  ? kmsan_get_shadow_origin_ptr+0x4d/0xb0
[  113.317917][    C0]  virtnet_poll+0xd1c/0x23c0
[  113.322794][    C0]  ? __pfx_virtnet_poll+0x10/0x10
[  113.328179][    C0]  __napi_poll+0xe7/0x980
[  113.332633][    C0]  ? kmsan_get_metadata+0x146/0x1d0
[  113.338004][    C0]  net_rx_action+0x82a/0x1850
[  113.343182][    C0]  ? sched_clock_cpu+0x55/0x870
[  113.348249][    C0]  ? __pfx_net_rx_action+0x10/0x10
[  113.353485][    C0]  handle_softirqs+0x1ce/0x800
[  113.358560][    C0]  __irq_exit_rcu+0x68/0x120
[  113.363262][    C0]  irq_exit_rcu+0x12/0x20
[  113.367767][    C0]  common_interrupt+0x94/0xa0
[  113.372628][    C0]  </IRQ>
[  113.375629][    C0]  <TASK>
[  113.379321][    C0]  asm_common_interrupt+0x2b/0x40
[  113.384494][    C0] RIP: 0010:acpi_safe_halt+0x25/0x30
[  113.390214][    C0] Code: 90 90 90 90 90 55 48 89 e5 65 48 8b 04 25 80 5=
e 0a 00 48 f7 00 08 00 00 00 75 10 66 90 0f 00 2d 6b 2e 57 00 f3 0f 1e fa f=
b f4 <fa> 5d c3 cc cc cc cc 0f 1f 40 00 90 90 90 90 90 90 90 90 90 90 90
[  113.410147][    C0] RSP: 0018:ffffffff91003ce8 EFLAGS: 00000246
[  113.416513][    C0] RAX: ffffffff9102bdc0 RBX: ffffffff914873c0 RCX: 000=
0000000000001
[  113.424790][    C0] RDX: ffff8881035b4064 RSI: ffffffff914873c0 RDI: fff=
f8881035b4064
[  113.433157][    C0] RBP: ffffffff91003ce8 R08: ffffea000000000f R09: 000=
00000000000ff
[  113.441237][    C0] R10: ffff88823f16cdc2 R11: ffffffff8f863610 R12: fff=
f88810350ec00
[  113.449677][    C0] R13: ffffffff91487440 R14: 0000000000000001 R15: 000=
0000000000001
[  113.457842][    C0]  ? __pfx_acpi_idle_enter+0x10/0x10
[  113.463475][    C0]  acpi_idle_do_entry+0x22/0x40
[  113.468662][    C0]  acpi_idle_enter+0xa1/0xc0
[  113.473421][    C0]  cpuidle_enter_state+0xcb/0x250
[  113.478680][    C0]  cpuidle_enter+0x7f/0xf0
[  113.483206][    C0]  do_idle+0x551/0x750
[  113.487421][    C0]  cpu_startup_entry+0x65/0x80
[  113.492306][    C0]  rest_init+0x1e8/0x260
[  113.496795][    C0]  start_kernel+0x92c/0xa70
[  113.501446][    C0]  x86_64_start_reservations+0x2e/0x30
[  113.507105][    C0]  x86_64_start_kernel+0x98/0xa0
[  113.512315][    C0]  common_startup_64+0x12c/0x137
[  113.517383][    C0]  </TASK>
[  113.520775][    C0] Kernel Offset: disabled
[  113.525185][    C0] Rebooting in 86400 seconds..


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
 -ffile-prefix-map=3D/tmp/go-build2390608020=3D/tmp/go-build -gno-record-gc=
c-switches'

git status (err=3D<nil>)
HEAD detached at 121701b623
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
go fmt ./sys/... >/dev/null
touch .descriptions
GOOS=3Dlinux GOARCH=3Damd64 go build "-ldflags=3D-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3D121701b62358a454bbfdccfadfcce9bb843602d6 -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20240605-134717'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-fuzzer=
 github.com/google/syzkaller/syz-fuzzer
GOOS=3Dlinux GOARCH=3Damd64 go build "-ldflags=3D-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3D121701b62358a454bbfdccfadfcce9bb843602d6 -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20240605-134717'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-execpr=
og github.com/google/syzkaller/tools/syz-execprog
mkdir -p ./bin/linux_amd64
g++ -o ./bin/linux_amd64/syz-executor executor/executor.cc \
	-m64 -O2 -pthread -Wall -Werror -Wparentheses -Wunused-const-variable -Wfr=
ame-larger-than=3D16384 -Wno-stringop-overflow -Wno-array-bounds -Wno-forma=
t-overflow -Wno-unused-but-set-variable -Wno-unused-command-line-argument -=
static-pie -std=3Dc++17 -I. -Iexecutor/_include -fpermissive -w -DGOOS_linu=
x=3D1 -DGOARCH_amd64=3D1 \
	-DHOSTGOOS_linux=3D1 -DGIT_REVISION=3D\"121701b62358a454bbfdccfadfcce9bb84=
3602d6\"


Error text is too large and was truncated, full error text is at:
https://syzkaller.appspot.com/x/error.txt?x=3D15f01146980000


Tested on:

commit:         92e5605a Merge tag 'linux_kselftest-fixes-6.10-rc5' of..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=3D39eef4641322dda=
7
dashboard link: https://syzkaller.appspot.com/bug?extid=3D33bce7b1433357222=
4b2
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debia=
n) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D14ba34fa9800=
00



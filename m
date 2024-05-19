Return-Path: <linux-kernel+bounces-183036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A04AF8C93A3
	for <lists+linux-kernel@lfdr.de>; Sun, 19 May 2024 09:06:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21CDF1F21382
	for <lists+linux-kernel@lfdr.de>; Sun, 19 May 2024 07:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A132515ACB;
	Sun, 19 May 2024 07:06:08 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB883EAC7
	for <linux-kernel@vger.kernel.org>; Sun, 19 May 2024 07:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716102367; cv=none; b=oe9IvP0qXUMiuHhG+ZOpUrfWssk9iNovip9bsxHn6JS/rGDoVg3/1nwQXBARntVEbFuNWEp1Mbr1L6A0fmjfFjnhCvNKX8exTy93H7iXKFJVdfqrRkpIZ7bof9//8Zd9IaLXlh8SqYZq7EsL78W0RCBtfx9O+xCsFHHrEzjSI+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716102367; c=relaxed/simple;
	bh=m3wLkZoxM81e3+Lr4T2NQOFe1cco8HJhdSlXTOEC6sE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=alymSZYwXb28w+EqHetlvYFqiXtf92S+O+0pyHZm/VKiEXNJI430t9S/x5MGNltOVmJCgT/VJ40ra//4bYA2UgBbq/d000LoHjYX3UdErwazPniYotu3/u7EqSWf4siRBC6nxMBzno9ylZ/vDAZzuibAZSO2yaB8K0ulL9M4u7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7e1b97c1b19so1068721939f.3
        for <linux-kernel@vger.kernel.org>; Sun, 19 May 2024 00:06:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716102365; x=1716707165;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/vABlMtEKwyAWY+trhW6lutO/ovNuviaXIoCiai74uc=;
        b=dLGoxB/Q5te/IcmG0cQdRWr+HyDn+tbWJ6Ft6kmGSjiZITLZyw+gt9PNHJrHKo3pTi
         bF7/u2at5p3Q8/Ou3O6mzs3ocmUy32zmG6JlItzibABfvpSAePHEeUg5+2DGUuHuJs6d
         1Rru7EFMC4h3DhuctirxvxH2wnd2gq0aNkKCRMkRnDvKc8AlqdGxqY1XPYH0J8sPU8rf
         Xu/T5HPXplSQOp9iYgqq1pyNV+Tou5HZhWoCClHk78tN8GGp57pcHhEhCdYGudLvNKpe
         ldYezcSDJ7Mcky2eGhSgxr0C9aUtPVBXs9/QbIMJLJwQ7tz1tfCjBV20SFwijR3mQqwL
         hQTA==
X-Gm-Message-State: AOJu0Yyhes83i2nfmd0FGKlnun/i3Y/XCSZVnEBQRVyzc5suLhZNHYks
	LjPAcl1fSZ+iR0JrZn3R1e4nCF3HeeoBlmYrOANc4+rWbAXl0y5wKVKYUVZmANHNha8O1QqLlQT
	xcoH12JnK+xT2rI2lnht9MQAJ1sxQiILVpF6cwN1U4kn5xHHix3wiXxY=
X-Google-Smtp-Source: AGHT+IEGO9tC480jtyAJf679onQcDuUfDy9NzeHQjrDgTb/Bv1MuSZvOuNpl6Iixn8GrqomS0tCwno+ZkoetYeunFMjGRORjTzOF
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12ed:b0:36d:bb86:f6a7 with SMTP id
 e9e14a558f8ab-36dbb86f6e9mr3753415ab.2.1716102365059; Sun, 19 May 2024
 00:06:05 -0700 (PDT)
Date: Sun, 19 May 2024 00:06:05 -0700
In-Reply-To: <ZkmfWXLoU21OdLcw@zeus>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000de2f5f0618c937ca@google.com>
Subject: Re: [syzbot] [net?] [nfc?] KMSAN: uninit-value in nci_rx_work
From: syzbot <syzbot+d7b4dc6cd50410152534@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, ryasuoka@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

d
[   49.833473][    T1] Key type fscrypt-provisioning registered
[   49.840611][    T1] kAFS: Red Hat AFS client v0.1 registering.
[   49.871444][    T1] Btrfs loaded, assert=3Don, ref-verify=3Don, zoned=3D=
yes, fsverity=3Dyes
[   49.899097][    T1] Key type encrypted registered
[   49.904196][    T1] AppArmor: AppArmor sha256 policy hashing enabled
[   49.911103][    T1] ima: No TPM chip found, activating TPM-bypass!
[   49.918186][    T1] Loading compiled-in module X.509 certificates
[   49.958925][    T1] Loaded X.509 cert 'Build time autogenerated kernel k=
ey: a4798651021c2e94b01e09517f19b030d6efdca0'
[   49.972127][    T1] ima: Allocated hash algorithm: sha256
[   49.978232][    T1] ima: No architecture policies found
[   49.984979][    T1] evm: Initialising EVM extended attributes:
[   49.991015][    T1] evm: security.selinux (disabled)
[   49.996257][    T1] evm: security.SMACK64 (disabled)
[   50.001522][    T1] evm: security.SMACK64EXEC (disabled)
[   50.007098][    T1] evm: security.SMACK64TRANSMUTE (disabled)
[   50.013294][    T1] evm: security.SMACK64MMAP (disabled)
[   50.018826][    T1] evm: security.apparmor
[   50.023190][    T1] evm: security.ima
[   50.027058][    T1] evm: security.capability
[   50.031546][    T1] evm: HMAC attrs: 0x1
[   50.040411][    T1] PM:   Magic number: 8:498:974
[   50.045711][    T1] net rose12: hash matches
[   50.051619][    T1] tty ttyc1: hash matches
[   50.057624][    T1] memory memory21: hash matches
[   50.063084][    T1] printk: legacy console [netcon0] enabled
[   50.069642][    T1] netconsole: network logging started
[   50.076563][    T1] gtp: GTP module loaded (pdp ctx size 128 bytes)
[   50.085358][    T1] rdma_rxe: loaded
[   50.091037][    T1] cfg80211: Loading compiled-in X.509 certificates for=
 regulatory database
[   50.112091][    T1] Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[   50.129871][    T1] Loaded X.509 cert 'wens: 61c038651aabdcf94bd0ac7ff06=
c7248db18c600'
[   50.138379][    T1] clk: Disabling unused clocks
[   50.143379][    T1] ALSA device list:
[   50.147270][    T1]   #0: Dummy 1
[   50.150844][    T1]   #1: Loopback 1
[   50.154858][    T1]   #2: Virtual MIDI Card 1
[   50.165056][   T10] platform regulatory.0: Direct firmware load for regu=
latory.db failed with error -2
[   50.175016][   T10] platform regulatory.0: Falling back to sysfs fallbac=
k for: regulatory.db
[   50.187170][    T1] md: Waiting for all devices to be available before a=
utodetect
[   50.195642][    T1] md: If you don't use raid, use raid=3Dnoautodetect
[   50.202700][    T1] md: Autodetecting RAID arrays.
[   50.207733][    T1] md: autorun ...
[   50.211457][    T1] md: ... autorun DONE.
[   50.353528][    T1] EXT4-fs (sda1): mounted filesystem 5941fea2-f5fa-4b4=
e-b5ef-9af118b27b95 ro with ordered data mode. Quota mode: none.
[   50.366915][    T1] VFS: Mounted root (ext4 filesystem) readonly on devi=
ce 8:1.
[   50.424949][    T1] devtmpfs: mounted
[   50.699460][    T1] Freeing unused kernel image (initmem) memory: 37080K
[   50.711336][    T1] Write protecting the kernel read-only data: 262144k
[   50.758319][    T1] Freeing unused kernel image (rodata/data gap) memory=
: 1828K
[   52.395352][    T1] x86/mm: Checked W+X mappings: passed, no W+X pages f=
ound.
[   52.405685][    T1] x86/mm: Checking user space page tables
[   53.902901][    T1] x86/mm: Checked W+X mappings: passed, no W+X pages f=
ound.
[   53.912063][    T1] Failed to set sysctl parameter 'kernel.hung_task_all=
_cpu_backtrace=3D1': parameter not found
[   53.933254][    T1] Failed to set sysctl parameter 'max_rcu_stall_to_pan=
ic=3D1': parameter not found
[   53.945343][    T1] Run /sbin/init as init process
[   55.451627][ T4457] mount (4457) used greatest stack depth: 8080 bytes l=
eft
[   55.544800][ T4458] EXT4-fs (sda1): re-mounted 5941fea2-f5fa-4b4e-b5ef-9=
af118b27b95 r/w. Quota mode: none.
mount: mounting smackfs on /sys/fs/smackfs failed: No such file or director=
y
mount: mounting selinuxfs on /sys/fs/selinux failed: No such file or direct=
ory
[   55.887872][ T4461] mount (4461) used greatest stack depth: 5536 bytes l=
eft
Starting syslogd: OK
Starting acpid: OK
Starting klogd: OK
Running sysctl: OK
Populating /dev using udev: [   59.736174][ T4491] udevd[4491]: starting ve=
rsion 3.2.11
[   63.326118][ T4492] udevd[4492]: starting eudev-3.2.11
[   63.339616][ T4491] udevd (4491) used greatest stack depth: 5296 bytes l=
eft
[   96.282221][ T1217] net_ratelimit: 2 callbacks suppressed
[   96.288457][ T1217] aoe: packet could not be sent on lo.  consider incre=
asing tx_queue_len
[   96.297759][ T1217] aoe: packet could not be sent on bond0.  consider in=
creasing tx_queue_len
[   96.306994][ T1217] aoe: packet could not be sent on dummy0.  consider i=
ncreasing tx_queue_len
[   96.316324][ T1217] aoe: packet could not be sent on eql.  consider incr=
easing tx_queue_len
[   96.325251][ T1217] aoe: packet could not be sent on ifb0.  consider inc=
reasing tx_queue_len
[   96.334334][ T1217] aoe: packet could not be sent on ifb1.  consider inc=
reasing tx_queue_len
[   96.343322][ T1217] aoe: packet could not be sent on eth0.  consider inc=
reasing tx_queue_len
[   96.352454][ T1217] aoe: packet could not be sent on wlan0.  consider in=
creasing tx_queue_len
[   96.361456][ T1217] aoe: packet could not be sent on wlan1.  consider in=
creasing tx_queue_len
[   96.370791][ T1217] aoe: packet could not be sent on hwsim0.  consider i=
ncreasing tx_queue_len
done
Starting system message bus: done
Starting iptables: OK
Starting network: OK
Starting dhcpcd...
dhcpcd-9.4.1 starting
dev: loaded udev
DUID 00:04:ee:6e:2e:e3:62:a1:1e:1b:9d:a6:87:1c:6e:7e:27:0f
forked to background, child pid 4705
[  111.221467][ T4706] 8021q: adding VLAN 0 to HW filter on device bond0
[  111.265683][ T4706] eql: remember to turn off Van-Jacobson compression o=
n your slave devices
[  111.628301][   T10] cfg80211: failed to load regulatory.db
Starting sshd: OK


syzkaller

syzkaller login: [  114.143712][    C0] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[  114.151005][    C0] BUG: KMSAN: uninit-value in receive_buf+0x25e3/0x5fd=
0
[  114.158338][    C0]  receive_buf+0x25e3/0x5fd0
[  114.163226][    C0]  virtnet_poll+0xd1c/0x23c0
[  114.168041][    C0]  __napi_poll+0xe7/0x980
[  114.172623][    C0]  net_rx_action+0x82a/0x1850
[  114.177758][    C0]  handle_softirqs+0x1d8/0x810
[  114.182781][    C0]  __irq_exit_rcu+0x68/0x120
[  114.187568][    C0]  irq_exit_rcu+0x12/0x20
[  114.192171][    C0]  common_interrupt+0x94/0xa0
[  114.197187][    C0]  asm_common_interrupt+0x2b/0x40
[  114.202485][    C0]  acpi_safe_halt+0x25/0x30
[  114.207199][    C0]  acpi_idle_do_entry+0x22/0x40
[  114.212502][    C0]  acpi_idle_enter+0xa1/0xc0
[  114.217275][    C0]  cpuidle_enter_state+0xcb/0x250
[  114.222538][    C0]  cpuidle_enter+0x7f/0xf0
[  114.227114][    C0]  do_idle+0x551/0x750
[  114.231384][    C0]  cpu_startup_entry+0x65/0x80
[  114.236432][    C0]  rest_init+0x1e8/0x260
[  114.240862][    C0]  start_kernel+0x927/0xa70
[  114.245558][    C0]  x86_64_start_reservations+0x2e/0x30
[  114.251188][    C0]  x86_64_start_kernel+0x98/0xa0
[  114.257089][    C0]  common_startup_64+0x12c/0x137
[  114.262194][    C0]=20
[  114.264659][    C0] Uninit was created at:
[  114.269028][    C0]  __alloc_pages+0x9d6/0xe70
[  114.273784][    C0]  alloc_pages_mpol+0x299/0x990
[  114.278842][    C0]  alloc_pages+0x1bf/0x1e0
[  114.283456][    C0]  skb_page_frag_refill+0x2bf/0x7c0
[  114.288835][    C0]  virtnet_rq_alloc+0x43/0xbb0
[  114.293812][    C0]  try_fill_recv+0x3f0/0x2f50
[  114.298693][    C0]  virtnet_open+0x1cc/0xb00
[  114.303390][    C0]  __dev_open+0x546/0x6f0
[  114.307892][    C0]  __dev_change_flags+0x309/0x9a0
[  114.313123][    C0]  dev_change_flags+0x8e/0x1d0
[  114.318070][    C0]  devinet_ioctl+0x13ec/0x22c0
[  114.323032][    C0]  inet_ioctl+0x4bd/0x6d0
[  114.327536][    C0]  sock_do_ioctl+0xb7/0x540
[  114.332144][    C0]  sock_ioctl+0x727/0xd70
[  114.336671][    C0]  __se_sys_ioctl+0x261/0x450
[  114.341481][    C0]  __x64_sys_ioctl+0x96/0xe0
[  114.346265][    C0]  x64_sys_call+0x1883/0x3b50
[  114.351150][    C0]  do_syscall_64+0xcf/0x1e0
[  114.355849][    C0]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  114.361963][    C0]=20
[  114.364413][    C0] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.9.0-syzk=
aller-08544-g4b377b4868ef-dirty #0
[  114.374429][    C0] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 04/02/2024
[  114.385301][    C0] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[  114.392482][    C0] Disabling lock debugging due to kernel taint
[  114.398789][    C0] Kernel panic - not syncing: kmsan.panic set ...
[  114.405265][    C0] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G    B       =
       6.9.0-syzkaller-08544-g4b377b4868ef-dirty #0
[  114.416655][    C0] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 04/02/2024
[  114.426788][    C0] Call Trace:
[  114.430125][    C0]  <IRQ>
[  114.433020][    C0]  dump_stack_lvl+0x216/0x2d0
[  114.437823][    C0]  ? kmsan_get_shadow_origin_ptr+0x4d/0xb0
[  114.443852][    C0]  dump_stack+0x1e/0x30
[  114.448123][    C0]  panic+0x4e2/0xcd0
[  114.452123][    C0]  ? kmsan_get_metadata+0x91/0x1d0
[  114.457373][    C0]  kmsan_report+0x2d5/0x2e0
[  114.461994][    C0]  ? kmsan_get_metadata+0x146/0x1d0
[  114.467326][    C0]  ? __msan_warning+0x95/0x120
[  114.472344][    C0]  ? receive_buf+0x25e3/0x5fd0
[  114.477270][    C0]  ? virtnet_poll+0xd1c/0x23c0
[  114.482168][    C0]  ? __napi_poll+0xe7/0x980
[  114.486819][    C0]  ? net_rx_action+0x82a/0x1850
[  114.491807][    C0]  ? handle_softirqs+0x1d8/0x810
[  114.496881][    C0]  ? __irq_exit_rcu+0x68/0x120
[  114.501854][    C0]  ? irq_exit_rcu+0x12/0x20
[  114.506463][    C0]  ? common_interrupt+0x94/0xa0
[  114.511407][    C0]  ? asm_common_interrupt+0x2b/0x40
[  114.516827][    C0]  ? acpi_safe_halt+0x25/0x30
[  114.521642][    C0]  ? acpi_idle_do_entry+0x22/0x40
[  114.526872][    C0]  ? acpi_idle_enter+0xa1/0xc0
[  114.531752][    C0]  ? cpuidle_enter_state+0xcb/0x250
[  114.537063][    C0]  ? cpuidle_enter+0x7f/0xf0
[  114.541755][    C0]  ? do_idle+0x551/0x750
[  114.546289][    C0]  ? cpu_startup_entry+0x65/0x80
[  114.551346][    C0]  ? rest_init+0x1e8/0x260
[  114.555884][    C0]  ? start_kernel+0x927/0xa70
[  114.560670][    C0]  ? x86_64_start_reservations+0x2e/0x30
[  114.566418][    C0]  ? x86_64_start_kernel+0x98/0xa0
[  114.571740][    C0]  ? common_startup_64+0x12c/0x137
[  114.577097][    C0]  ? kmsan_internal_memmove_metadata+0x17b/0x230
[  114.583544][    C0]  ? kmsan_get_metadata+0x146/0x1d0
[  114.588860][    C0]  ? kmsan_get_metadata+0x146/0x1d0
[  114.594216][    C0]  ? page_to_skb+0xdae/0x1620
[  114.599030][    C0]  ? kmsan_get_metadata+0x146/0x1d0
[  114.604348][    C0]  __msan_warning+0x95/0x120
[  114.609032][    C0]  receive_buf+0x25e3/0x5fd0
[  114.613763][    C0]  ? kmsan_get_metadata+0x146/0x1d0
[  114.619119][    C0]  ? kmsan_get_shadow_origin_ptr+0x4d/0xb0
[  114.625151][    C0]  virtnet_poll+0xd1c/0x23c0
[  114.629890][    C0]  ? __pfx_virtnet_poll+0x10/0x10
[  114.635162][    C0]  __napi_poll+0xe7/0x980
[  114.639626][    C0]  ? kmsan_get_metadata+0x146/0x1d0
[  114.644985][    C0]  net_rx_action+0x82a/0x1850
[  114.649776][    C0]  ? sched_clock_cpu+0x55/0x870
[  114.654740][    C0]  ? __pfx_net_rx_action+0x10/0x10
[  114.659963][    C0]  handle_softirqs+0x1d8/0x810
[  114.665187][    C0]  __irq_exit_rcu+0x68/0x120
[  114.669904][    C0]  irq_exit_rcu+0x12/0x20
[  114.674347][    C0]  common_interrupt+0x94/0xa0
[  114.679140][    C0]  </IRQ>
[  114.682136][    C0]  <TASK>
[  114.685126][    C0]  asm_common_interrupt+0x2b/0x40
[  114.690296][    C0] RIP: 0010:acpi_safe_halt+0x25/0x30
[  114.695727][    C0] Code: 90 90 90 90 90 55 48 89 e5 65 48 8b 04 25 c0 5=
c 0a 00 48 f7 00 08 00 00 00 75 10 66 90 0f 00 2d 8b f2 50 00 f3 0f 1e fa f=
b f4 <fa> 5d c3 cc cc cc cc 0f 1f 40 00 90 90 90 90 90 90 90 90 90 90 90
[  114.715481][    C0] RSP: 0018:ffffffff91003ce8 EFLAGS: 00000246
[  114.721640][    C0] RAX: ffffffff9102be00 RBX: ffffffff914830f0 RCX: 000=
0000000000001
[  114.729711][    C0] RDX: ffff888103536464 RSI: ffffffff914830f0 RDI: fff=
f888103536464
[  114.737788][    C0] RBP: ffffffff91003ce8 R08: ffffea000000000f R09: 000=
00000000000ff
[  114.745861][    C0] R10: ffff88823f170e02 R11: ffffffff8f8c6600 R12: fff=
f888104f29800
[  114.755574][    C0] R13: ffffffff91483170 R14: 0000000000000001 R15: 000=
0000000000001
[  114.763645][    C0]  ? __pfx_acpi_idle_enter+0x10/0x10
[  114.769080][    C0]  acpi_idle_do_entry+0x22/0x40
[  114.774059][    C0]  acpi_idle_enter+0xa1/0xc0
[  114.778766][    C0]  cpuidle_enter_state+0xcb/0x250
[  114.784045][    C0]  cpuidle_enter+0x7f/0xf0
[  114.788595][    C0]  do_idle+0x551/0x750
[  114.792810][    C0]  cpu_startup_entry+0x65/0x80
[  114.797746][    C0]  rest_init+0x1e8/0x260
[  114.802132][    C0]  start_kernel+0x927/0xa70
[  114.806754][    C0]  x86_64_start_reservations+0x2e/0x30
[  114.812354][    C0]  x86_64_start_kernel+0x98/0xa0
[  114.817515][    C0]  common_startup_64+0x12c/0x137
[  114.822596][    C0]  </TASK>
[  114.826121][    C0] Kernel Offset: disabled
[  114.830501][    C0] Rebooting in 86400 seconds..


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
 -ffile-prefix-map=3D/tmp/go-build1133093471=3D/tmp/go-build -gno-record-gc=
c-switches'

git status (err=3D<nil>)
HEAD detached at 9026e1428
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
https://syzkaller.appspot.com/x/error.txt?x=3D1133df6c980000


Tested on:

commit:         4b377b48 kprobe/ftrace: fix build error due to bad fun..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.gi=
t main
kernel config:  https://syzkaller.appspot.com/x/.config?x=3D39dc6d181fb71e3=
a
dashboard link: https://syzkaller.appspot.com/bug?extid=3Dd7b4dc6cd50410152=
534
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debia=
n) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D102cc5929800=
00



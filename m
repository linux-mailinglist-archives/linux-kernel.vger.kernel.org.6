Return-Path: <linux-kernel+bounces-215915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0754B9098C0
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 17:12:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A848283480
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 15:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F02DD49635;
	Sat, 15 Jun 2024 15:12:07 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1255117BC9
	for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 15:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718464327; cv=none; b=RDAPnil2nk5hhqk2lVU1XVWfSQuQKYbgFhpL2cOVjH2KH2I/jgJqSorLgGgoRBcXbR9N0ejYbw+PTiqnhvJYp+kYwQ4dr69rlkyvmie+QHkSvuhiM/sD41mCqsCPSafhPKt8CNYqGHxg65/EgXGWi8Fn/CxCnLJ1oNMmitCMLNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718464327; c=relaxed/simple;
	bh=BeNl+q7r76/3F9DY29eK/+QHZSLi0UG6CWJDA08GUcE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=fMmC0Fo1/Q3QzmbPN7/LT9g1tE7VWEd3SMYrYJ2K4TGE3tCQGVOKABZgc+9s6083z0RFBalLaJzcmKRv1Z1elYt18TmboNF1fpxY4oixhBLCIAWztkrqvWAPqZSauSaadFI4CUgNwQAvDA//5MSdxlIX3s3LODbi+eSc24VTk6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7eb846f49adso329184939f.3
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 08:12:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718464324; x=1719069124;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ItukAEmxnBHTiwyKVY2S8god10ufbIKSeUBh653weGw=;
        b=uiOY74Ha6EcOSpzQVoX6MJwUhh+s6UTzI+dFPKbEg3zoCmJqh4yUbHxQ7UlheLHUdm
         +tztznmHcusn+ZZ7ROXDp7RxAQSvUglRelfSKXHSIElwt0VmA/TnWGaHn4ch2HBmRfiq
         n+JlTHM+X9EjkfIG85fajmRaINFBY/YTT4TxdfHdQzR3gW4bk+r1oKHuKMrrHC6Dj6kS
         P4NCi56xuae7BauDMTYEwvRyRWavvufqeeba5sh8V0oBlc/eGvX29Bww4s5X9/IL1sFs
         VW+uUy/qS26b8qWwzMW/4o1ds9ZCng2979/77+qw34a0AOONm6jaKpi/3UmxfPBnQyTu
         ah9Q==
X-Gm-Message-State: AOJu0Yxwef5sa/8bRsKSvV6Pg4rcjBP3kjiuMeOUhzqDY6BkP3Wmf8KR
	MeOSjXLTgDc88SjQp0mufFcJspctLVfaP26PGPYiPkC2TOH8og4XMVODHFUHqM4xSNSfdAJWIl2
	4m22O0nTDWvIYyjVB8UBaYoLDqUKO2rfjxoyS4kmqzIdE+5bavD+0ZCU=
X-Google-Smtp-Source: AGHT+IGbAv7pvaH3CE9TfTQLmLcATn/M72hbf0EQCd5tzJJ5ODov54QYlZ04JUqTl5lmomIxOACUHQ9Rk0mSxiWji/CnB3mjWRUn
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8524:b0:488:75e3:f3c5 with SMTP id
 8926c6da1cb9f-4b963bf7fd4mr165667173.0.1718464324115; Sat, 15 Jun 2024
 08:12:04 -0700 (PDT)
Date: Sat, 15 Jun 2024 08:12:04 -0700
In-Reply-To: <20240614120407.28400-1-wojciech.gladysz@infogain.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000992dcc061aef27c9@google.com>
Subject: Re: [syzbot] [net?] [bpf?] KMSAN: uninit-value in sock_hash_delete_elem
From: syzbot <syzbot+c33bff5d5da1391df027@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	wojciech.gladysz@infogain.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

 46.862565][    T1] IPI shorthand broadcast: enabled
[   48.390695][    T1] sched_clock: Marking stable (48370050826, 17960846)-=
>(48402924943, -14913271)
[   49.493182][    T1] Timer migration: 1 hierarchy levels; 8 children per =
group; 0 crossnode level
[   49.645015][    T1] registered taskstats version 1
[   49.719060][    T1] Loading compiled-in X.509 certificates
[   49.757838][    T1] Loaded X.509 cert 'Build time autogenerated kernel k=
ey: 0721be491b560242240f4d386be31dadacd83fb9'
[   49.999690][    T1] zswap: loaded using pool lzo/zsmalloc
[   50.009346][    T1] Demotion targets for Node 0: null
[   50.014859][    T1] Demotion targets for Node 1: null
[   50.024245][    T1] Key type .fscrypt registered
[   50.029139][    T1] Key type fscrypt-provisioning registered
[   50.036215][    T1] kAFS: Red Hat AFS client v0.1 registering.
[   50.067479][    T1] Btrfs loaded, assert=3Don, ref-verify=3Don, zoned=3D=
yes, fsverity=3Dyes
[   50.093752][    T1] Key type encrypted registered
[   50.098879][    T1] AppArmor: AppArmor sha256 policy hashing enabled
[   50.105629][    T1] ima: No TPM chip found, activating TPM-bypass!
[   50.112793][    T1] Loading compiled-in module X.509 certificates
[   50.155555][    T1] Loaded X.509 cert 'Build time autogenerated kernel k=
ey: 0721be491b560242240f4d386be31dadacd83fb9'
[   50.166713][    T1] ima: Allocated hash algorithm: sha256
[   50.172789][    T1] ima: No architecture policies found
[   50.179427][    T1] evm: Initialising EVM extended attributes:
[   50.185545][    T1] evm: security.selinux (disabled)
[   50.190767][    T1] evm: security.SMACK64 (disabled)
[   50.196020][    T1] evm: security.SMACK64EXEC (disabled)
[   50.201593][    T1] evm: security.SMACK64TRANSMUTE (disabled)
[   50.207535][    T1] evm: security.SMACK64MMAP (disabled)
[   50.213128][    T1] evm: security.apparmor
[   50.217595][    T1] evm: security.ima
[   50.221508][    T1] evm: security.capability
[   50.225972][    T1] evm: HMAC attrs: 0x1
[   50.234955][    T1] PM:   Magic number: 12:678:32
[   50.241542][    T1] tty ttydf: hash matches
[   50.247287][    T1] printk: legacy console [netcon0] enabled
[   50.254497][    T1] netconsole: network logging started
[   50.261482][    T1] gtp: GTP module loaded (pdp ctx size 128 bytes)
[   50.270457][    T1] rdma_rxe: loaded
[   50.276235][    T1] cfg80211: Loading compiled-in X.509 certificates for=
 regulatory database
[   50.295946][    T1] Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[   50.313521][    T1] Loaded X.509 cert 'wens: 61c038651aabdcf94bd0ac7ff06=
c7248db18c600'
[   50.322130][    T1] clk: Disabling unused clocks
[   50.327068][    T1] ALSA device list:
[   50.331121][    T1]   #0: Dummy 1
[   50.334711][    T1]   #1: Loopback 1
[   50.339143][    T1]   #2: Virtual MIDI Card 1
[   50.350432][    T1] md: Waiting for all devices to be available before a=
utodetect
[   50.350717][   T25] platform regulatory.0: Direct firmware load for regu=
latory.db failed with error -2
[   50.358332][    T1] md: If you don't use raid, use raid=3Dnoautodetect
[   50.358393][    T1] md: Autodetecting RAID arrays.
[   50.358434][    T1] md: autorun ...
[   50.358473][    T1] md: ... autorun DONE.
[   50.388342][   T25] platform regulatory.0: Falling back to sysfs fallbac=
k for: regulatory.db
[   50.481647][    T1] EXT4-fs (sda1): mounted filesystem 5941fea2-f5fa-4b4=
e-b5ef-9af118b27b95 ro with ordered data mode. Quota mode: none.
[   50.495006][    T1] VFS: Mounted root (ext4 filesystem) readonly on devi=
ce 8:1.
[   50.507343][    T1] devtmpfs: mounted
[   50.770936][    T1] Freeing unused kernel image (initmem) memory: 36920K
[   50.782607][    T1] Write protecting the kernel read-only data: 260096k
[   50.830503][    T1] Freeing unused kernel image (rodata/data gap) memory=
: 1876K
[   52.482845][    T1] x86/mm: Checked W+X mappings: passed, no W+X pages f=
ound.
[   52.493217][    T1] x86/mm: Checking user space page tables
[   53.998271][    T1] x86/mm: Checked W+X mappings: passed, no W+X pages f=
ound.
[   54.007467][    T1] Failed to set sysctl parameter 'kernel.hung_task_all=
_cpu_backtrace=3D1': parameter not found
[   54.031284][    T1] Failed to set sysctl parameter 'max_rcu_stall_to_pan=
ic=3D1': parameter not found
[   54.043107][    T1] Run /sbin/init as init process
[   55.620910][ T4446] mount (4446) used greatest stack depth: 8144 bytes l=
eft
[   55.692569][ T4447] EXT4-fs (sda1): re-mounted 5941fea2-f5fa-4b4e-b5ef-9=
af118b27b95 r/w. Quota mode: none.
mount: mounting smackfs on /sys/fs/smackfs failed: No such file or director=
y
mount: mounting selinuxfs on /sys/fs/selinux failed: No such file or direct=
ory
[   56.030947][ T4450] mount (4450) used greatest stack depth: 5568 bytes l=
eft
Starting syslogd: OK
Starting acpid: OK
Starting klogd: OK
Running sysctl: OK
Populating /dev using udev: [   59.860978][ T4480] udevd[4480]: starting ve=
rsion 3.2.11
[   63.448534][ T4481] udevd[4481]: starting eudev-3.2.11
[   63.461355][ T4480] udevd (4480) used greatest stack depth: 5376 bytes l=
eft
done
Starting system message bus: done
Starting iptables: OK
Starting network: OK
Starting dhcpcd...
dhcpcd-9.4.1 starting
dev: loaded udev
DUID 00:04:c7:fd:4a:df:9d:a6:e9:60:55:7b:b4:5b:1f:77:00:5c
no interfaces have a carrier
forked to background, child pid 4694
[  111.282058][ T4695] 8021q: adding VLAN 0 to HW filter on device bond0
[  111.333940][ T4695] eql: remember to turn off Van-Jacobson compression o=
n your slave devices
[  111.851180][   T25] cfg80211: failed to load regulatory.db
Starting sshd: OK


syzkaller

syzkaller login: [  113.999622][    C0] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[  114.006947][    C0] BUG: KMSAN: uninit-value in receive_buf+0x25e3/0x5fd=
0
[  114.014214][    C0]  receive_buf+0x25e3/0x5fd0
[  114.019047][    C0]  virtnet_poll+0xd1c/0x23c0
[  114.023845][    C0]  __napi_poll+0xe7/0x980
[  114.028437][    C0]  net_rx_action+0x82a/0x1850
[  114.033296][    C0]  handle_softirqs+0x1ce/0x800
[  114.038238][    C0]  __irq_exit_rcu+0x68/0x120
[  114.042976][    C0]  irq_exit_rcu+0x12/0x20
[  114.047393][    C0]  common_interrupt+0x94/0xa0
[  114.052272][    C0]  asm_common_interrupt+0x2b/0x40
[  114.057547][    C0]  acpi_safe_halt+0x25/0x30
[  114.062420][    C0]  acpi_idle_do_entry+0x22/0x40
[  114.067438][    C0]  acpi_idle_enter+0xa1/0xc0
[  114.072234][    C0]  cpuidle_enter_state+0xcb/0x250
[  114.077501][    C0]  cpuidle_enter+0x7f/0xf0
[  114.082119][    C0]  do_idle+0x551/0x750
[  114.086349][    C0]  cpu_startup_entry+0x65/0x80
[  114.091272][    C0]  rest_init+0x1e8/0x260
[  114.095675][    C0]  start_kernel+0x92c/0xa70
[  114.100384][    C0]  x86_64_start_reservations+0x2e/0x30
[  114.106047][    C0]  x86_64_start_kernel+0x98/0xa0
[  114.111263][    C0]  common_startup_64+0x12c/0x137
[  114.116564][    C0]=20
[  114.119010][    C0] Uninit was created at:
[  114.123471][    C0]  __alloc_pages_noprof+0x9d6/0xe70
[  114.128864][    C0]  alloc_pages_mpol_noprof+0x299/0x990
[  114.134532][    C0]  alloc_pages_noprof+0x1bf/0x1e0
[  114.139774][    C0]  skb_page_frag_refill+0x2bf/0x7c0
[  114.145167][    C0]  virtnet_rq_alloc+0x43/0xbb0
[  114.150208][    C0]  try_fill_recv+0x3f0/0x2f50
[  114.155069][    C0]  virtnet_open+0x1cc/0xb00
[  114.159814][    C0]  __dev_open+0x546/0x6f0
[  114.164339][    C0]  __dev_change_flags+0x309/0x9a0
[  114.169581][    C0]  dev_change_flags+0x8e/0x1d0
[  114.174515][    C0]  devinet_ioctl+0x13ec/0x22c0
[  114.179650][    C0]  inet_ioctl+0x4bd/0x6d0
[  114.184217][    C0]  sock_do_ioctl+0xb7/0x540
[  114.188902][    C0]  sock_ioctl+0x727/0xd70
[  114.193366][    C0]  __se_sys_ioctl+0x261/0x450
[  114.198305][    C0]  __x64_sys_ioctl+0x96/0xe0
[  114.203035][    C0]  x64_sys_call+0x18c0/0x3b90
[  114.208102][    C0]  do_syscall_64+0xcd/0x1e0
[  114.212760][    C0]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  114.218840][    C0]=20
[  114.221299][    C0] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.10.0-rc3=
-syzkaller-00022-g90302a82de09 #0
[  114.231270][    C0] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 06/07/2024
[  114.241487][    C0] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[  114.248662][    C0] Disabling lock debugging due to kernel taint
[  114.254904][    C0] Kernel panic - not syncing: kmsan.panic set ...
[  114.261375][    C0] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G    B       =
       6.10.0-rc3-syzkaller-00022-g90302a82de09 #0
[  114.272855][    C0] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 06/07/2024
[  114.283040][    C0] Call Trace:
[  114.286385][    C0]  <IRQ>
[  114.289279][    C0]  dump_stack_lvl+0x216/0x2d0
[  114.294091][    C0]  ? kmsan_get_shadow_origin_ptr+0x4d/0xb0
[  114.300049][    C0]  dump_stack+0x1e/0x30
[  114.304329][    C0]  panic+0x4e2/0xcd0
[  114.308315][    C0]  ? kmsan_get_metadata+0xb1/0x1d0
[  114.313630][    C0]  kmsan_report+0x2d5/0x2e0
[  114.318244][    C0]  ? kmsan_get_shadow_origin_ptr+0x4d/0xb0
[  114.324165][    C0]  ? kmsan_get_metadata+0x146/0x1d0
[  114.329472][    C0]  ? __msan_warning+0x95/0x120
[  114.334350][    C0]  ? receive_buf+0x25e3/0x5fd0
[  114.339235][    C0]  ? virtnet_poll+0xd1c/0x23c0
[  114.344129][    C0]  ? __napi_poll+0xe7/0x980
[  114.348859][    C0]  ? net_rx_action+0x82a/0x1850
[  114.353823][    C0]  ? handle_softirqs+0x1ce/0x800
[  114.358872][    C0]  ? __irq_exit_rcu+0x68/0x120
[  114.363742][    C0]  ? irq_exit_rcu+0x12/0x20
[  114.368333][    C0]  ? common_interrupt+0x94/0xa0
[  114.373295][    C0]  ? asm_common_interrupt+0x2b/0x40
[  114.378595][    C0]  ? acpi_safe_halt+0x25/0x30
[  114.383390][    C0]  ? acpi_idle_do_entry+0x22/0x40
[  114.388528][    C0]  ? acpi_idle_enter+0xa1/0xc0
[  114.393384][    C0]  ? cpuidle_enter_state+0xcb/0x250
[  114.398680][    C0]  ? cpuidle_enter+0x7f/0xf0
[  114.403397][    C0]  ? do_idle+0x551/0x750
[  114.407738][    C0]  ? cpu_startup_entry+0x65/0x80
[  114.412803][    C0]  ? rest_init+0x1e8/0x260
[  114.417343][    C0]  ? start_kernel+0x92c/0xa70
[  114.422151][    C0]  ? x86_64_start_reservations+0x2e/0x30
[  114.427913][    C0]  ? x86_64_start_kernel+0x98/0xa0
[  114.433238][    C0]  ? common_startup_64+0x12c/0x137
[  114.438556][    C0]  ? kmsan_internal_memmove_metadata+0x17b/0x230
[  114.444994][    C0]  ? kmsan_get_metadata+0x146/0x1d0
[  114.450384][    C0]  ? kmsan_get_metadata+0x146/0x1d0
[  114.455777][    C0]  ? page_to_skb+0xdae/0x1620
[  114.460590][    C0]  ? kmsan_get_metadata+0x146/0x1d0
[  114.466005][    C0]  __msan_warning+0x95/0x120
[  114.470702][    C0]  receive_buf+0x25e3/0x5fd0
[  114.475415][    C0]  ? kmsan_get_metadata+0x146/0x1d0
[  114.480723][    C0]  ? kmsan_get_shadow_origin_ptr+0x4d/0xb0
[  114.486658][    C0]  virtnet_poll+0xd1c/0x23c0
[  114.491392][    C0]  ? __pfx_virtnet_poll+0x10/0x10
[  114.496535][    C0]  __napi_poll+0xe7/0x980
[  114.500975][    C0]  ? kmsan_get_metadata+0x146/0x1d0
[  114.506376][    C0]  net_rx_action+0x82a/0x1850
[  114.511264][    C0]  ? sched_clock_cpu+0x55/0x870
[  114.516222][    C0]  ? __pfx_net_rx_action+0x10/0x10
[  114.521456][    C0]  handle_softirqs+0x1ce/0x800
[  114.526340][    C0]  __irq_exit_rcu+0x68/0x120
[  114.531117][    C0]  irq_exit_rcu+0x12/0x20
[  114.535538][    C0]  common_interrupt+0x94/0xa0
[  114.540324][    C0]  </IRQ>
[  114.543335][    C0]  <TASK>
[  114.546400][    C0]  asm_common_interrupt+0x2b/0x40
[  114.551563][    C0] RIP: 0010:acpi_safe_halt+0x25/0x30
[  114.557004][    C0] Code: 90 90 90 90 90 55 48 89 e5 65 48 8b 04 25 80 5=
e 0a 00 48 f7 00 08 00 00 00 75 10 66 90 0f 00 2d eb b8 44 00 f3 0f 1e fa f=
b f4 <fa> 5d c3 cc cc cc cc 0f 1f 40 00 90 90 90 90 90 90 90 90 90 90 90
[  114.576730][    C0] RSP: 0018:ffffffff90e03ce8 EFLAGS: 00000246
[  114.582968][    C0] RAX: ffffffff90e2bdc0 RBX: ffffffff91286bb0 RCX: 000=
0000000000001
[  114.591022][    C0] RDX: ffff88810322e064 RSI: ffffffff91286bb0 RDI: fff=
f88810322e064
[  114.599114][    C0] RBP: ffffffff90e03ce8 R08: ffffea000000000f R09: 000=
00000000000ff
[  114.607295][    C0] R10: ffff88823f173dc2 R11: ffffffff8f78a590 R12: fff=
f888103ce3c00
[  114.615378][    C0] R13: ffffffff91286c30 R14: 0000000000000001 R15: 000=
0000000000001
[  114.623533][    C0]  ? __pfx_acpi_idle_enter+0x10/0x10
[  114.628953][    C0]  acpi_idle_do_entry+0x22/0x40
[  114.633915][    C0]  acpi_idle_enter+0xa1/0xc0
[  114.638600][    C0]  cpuidle_enter_state+0xcb/0x250
[  114.643752][    C0]  cpuidle_enter+0x7f/0xf0
[  114.648302][    C0]  do_idle+0x551/0x750
[  114.652474][    C0]  cpu_startup_entry+0x65/0x80
[  114.657345][    C0]  rest_init+0x1e8/0x260
[  114.661722][    C0]  start_kernel+0x92c/0xa70
[  114.666326][    C0]  x86_64_start_reservations+0x2e/0x30
[  114.671913][    C0]  x86_64_start_kernel+0x98/0xa0
[  114.676985][    C0]  common_startup_64+0x12c/0x137
[  114.682081][    C0]  </TASK>
[  114.685493][    C0] Kernel Offset: disabled
[  114.689884][    C0] Rebooting in 86400 seconds..


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
 -ffile-prefix-map=3D/tmp/go-build3847290796=3D/tmp/go-build -gno-record-gc=
c-switches'

git status (err=3D<nil>)
HEAD detached at 53df08b6d9
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
/syzkaller/prog.GitRevision=3D53df08b6d9d1467aa178b49a550c7b722fd9aa42 -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20240408-113412'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-fuzzer=
 github.com/google/syzkaller/syz-fuzzer
GOOS=3Dlinux GOARCH=3Damd64 go build "-ldflags=3D-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3D53df08b6d9d1467aa178b49a550c7b722fd9aa42 -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20240408-113412'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-execpr=
og github.com/google/syzkaller/tools/syz-execprog
GOOS=3Dlinux GOARCH=3Damd64 go build "-ldflags=3D-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3D53df08b6d9d1467aa178b49a550c7b722fd9aa42 -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20240408-113412'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-stress=
 github.com/google/syzkaller/tools/syz-stress
mkdir -p ./bin/linux_amd64
gcc -o ./bin/linux_amd64/syz-executor executor/executor.cc \
	-m64 -O2 -pthread -Wall -Werror -Wparentheses -Wunused-const-variable -Wfr=
ame-larger-than=3D16384 -Wno-stringop-overflow -Wno-array-bounds -Wno-forma=
t-overflow -Wno-unused-but-set-variable -Wno-unused-command-line-argument -=
static-pie -fpermissive -w -DGOOS_linux=3D1 -DGOARCH_amd64=3D1 \
	-DHOSTGOOS_linux=3D1 -DGIT_REVISION=3D\"53df08b6d9d1467aa178b49a550c7b722f=
d9aa42\"


Error text is too large and was truncated, full error text is at:
https://syzkaller.appspot.com/x/error.txt?x=3D159dd4fa980000


Tested on:

commit:         90302a82 kernel/bpf: KMSAN: uninit-value in htab_lru_p..
git tree:       https://linux.googlesource.com/linux/kernel/git/torvalds/li=
nux
kernel config:  https://syzkaller.appspot.com/x/.config?x=3Db97faf4c225206c=
d
dashboard link: https://syzkaller.appspot.com/bug?extid=3Dc33bff5d5da1391df=
027
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debia=
n) 2.40

Note: no patches were applied.


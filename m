Return-Path: <linux-kernel+bounces-231747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C079919D36
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 04:20:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0545285A62
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 02:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0651813AD8;
	Thu, 27 Jun 2024 02:20:12 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04DFC134A9
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 02:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719454811; cv=none; b=hiAc4prACf4vjnVFvMK/6FrYPm5vq+L1HNQIVDW4EUi4DuGjRc4EO6WGgl1ztnMWADqQ7QSvNDQVqY6IEb17dn6eONFWa1AyiHsZ5Ktce7MJgSep7PDxzDxdtM3hP4EIqsjqCEVd2kiNac7MMZP2CsiFdSVyesn1DeRmswHTBME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719454811; c=relaxed/simple;
	bh=JOAlAco0Jy47CDrSlN9bLCjPPabNSJ1WqH3fs1BGlxA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=sxqOXRGd+2Dx417nMig8LjjdwKfNiQonigy4/ax0eWzM5TNeivDCSwRyKSW5t8ZbsV4xkv6RMZLFADVg9J5gKeIBME3UtZdBCO6L8bo2mTwVh43TZYI42xtYDxIgVeAm3JYAz0l57MSggRHTM9/a1/NZncw3L+6QuvOBYer/+6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7ec00e71ab9so1151154339f.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 19:20:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719454808; x=1720059608;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9LxrnvCDqfLvH8Rpg1oFwShs0ZysV7BvHr4GAQUcIVk=;
        b=sU++5of0CJ+E8URRxnF1xwq7XmXdd4sPbNT6xRGZWdPETYArGBMN7e1JPSi0L961xv
         RQ26aHk/8F6pg7VU/RmT9Sc8xOwEdu0fyuwmBRau3IRoAzZFr6sSL4Si6S1Lnc+g7dfW
         GmX+126elASze7zw+KkEOcLkLY8ZrDBRIhMgoVVnJprlqP3xHGKAZMoD7vz4Kx7HoWFO
         FcjQgFxYQG4b8csrKHaCMi3oU/MaRcDfvBh3FZU0X6xP4DGE773nEhBvJQUDuQz3GNtA
         oWf0iJ4Zx+V9ZA9OWdWCpvHIdfgEicGpi1actaAVxJHR5sOqKVA1cyn08/qD5zVhfUcr
         ydAg==
X-Gm-Message-State: AOJu0YwFRci2Y6o8tkLyU0JAgEjUb0cCqbmV+s4xl8mqzB0EP3HxxX4i
	w3rF8bEHQkRMMP6dqsGtmOQsOQaKuH3f/Kw/YAUyMi0KjKDsl0v8P9wWRmUAxDAAMVQ1QPBcQWQ
	9jRR3jTO4zcfoq/845T5/4YYz8L/mT1X1X3nulQx5+TVfiQdAb17R4LI=
X-Google-Smtp-Source: AGHT+IGxcqOujfLlqk8kWZZhZfMDCBuJNQDehFu934zMFp4BNoU1IKgcRU3OdsavIwdiKPR2hhTNWmpXym17wWY8Ld81LnqTkL/O
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3791:b0:4b7:c9b5:6765 with SMTP id
 8926c6da1cb9f-4b9efc7989fmr1113159173.5.1719454803699; Wed, 26 Jun 2024
 19:20:03 -0700 (PDT)
Date: Wed, 26 Jun 2024 19:20:03 -0700
In-Reply-To: <20240627015934.1159978-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c84078061bd5c43f@google.com>
Subject: Re: [syzbot] [jfs?] INFO: task hung in txBegin
From: syzbot <syzbot+eda89a33c5856f66f823@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

itialized
[   12.450194][    T1] Bluetooth: RFCOMM socket layer initialized
[   12.456398][    T1] Bluetooth: RFCOMM ver 1.11
[   12.461045][    T1] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[   12.467274][    T1] Bluetooth: BNEP filters: protocol multicast
[   12.473507][    T1] Bluetooth: BNEP socket layer initialized
[   12.479400][    T1] Bluetooth: CMTP (CAPI Emulation) ver 1.0
[   12.485274][    T1] Bluetooth: CMTP socket layer initialized
[   12.491147][    T1] Bluetooth: HIDP (Human Interface Emulation) ver 1.2
[   12.498194][    T1] Bluetooth: HIDP socket layer initialized
[   12.507632][    T1] NET: Registered PF_RXRPC protocol family
[   12.513531][    T1] Key type rxrpc registered
[   12.518063][    T1] Key type rxrpc_s registered
[   12.523550][    T1] NET: Registered PF_KCM protocol family
[   12.530117][    T1] lec:lane_module_init: lec.c: initialized
[   12.536001][    T1] mpoa:atm_mpoa_init: mpc.c: initialized
[   12.541990][    T1] l2tp_core: L2TP core driver, V2.0
[   12.547437][    T1] l2tp_ppp: PPPoL2TP kernel driver, V2.0
[   12.553068][    T1] l2tp_ip: L2TP IP encapsulation support (L2TPv3)
[   12.559736][    T1] l2tp_netlink: L2TP netlink interface
[   12.565426][    T1] l2tp_eth: L2TP ethernet pseudowire support (L2TPv3)
[   12.572210][    T1] l2tp_ip6: L2TP IP encapsulation support for IPv6 (L2=
TPv3)
[   12.579806][    T1] NET: Registered PF_PHONET protocol family
[   12.586291][    T1] 8021q: 802.1Q VLAN Support v1.8
[   12.605218][    T1] DCCP: Activated CCID 2 (TCP-like)
[   12.610742][    T1] DCCP: Activated CCID 3 (TCP-Friendly Rate Control)
[   12.617954][    T1] DCCP is deprecated and scheduled to be removed in 20=
25, please contact the netdev mailing list
[   12.629617][    T1] sctp: Hash tables configured (bind 32/56)
[   12.637290][    T1] NET: Registered PF_RDS protocol family
[   12.643689][    T1] Registered RDS/infiniband transport
[   12.650504][    T1] Registered RDS/tcp transport
[   12.655260][    T1] tipc: Activated (version 2.0.0)
[   12.661683][    T1] NET: Registered PF_TIPC protocol family
[   12.668462][    T1] tipc: Started in single node mode
[   12.674475][    T1] NET: Registered PF_SMC protocol family
[   12.680577][    T1] 9pnet: Installing 9P2000 support
[   12.686466][    T1] NET: Registered PF_CAIF protocol family
[   12.696408][    T1] NET: Registered PF_IEEE802154 protocol family
[   12.702904][    T1] Key type dns_resolver registered
[   12.708146][    T1] Key type ceph registered
[   12.713281][    T1] libceph: loaded (mon/osd proto 15/24)
[   12.720605][    T1] batman_adv: B.A.T.M.A.N. advanced 2024.2 (compatibil=
ity version 15) loaded
[   12.730351][    T1] openvswitch: Open vSwitch switching datapath
[   12.739867][    T1] NET: Registered PF_VSOCK protocol family
[   12.746313][    T1] mpls_gso: MPLS GSO support
[   12.768127][    T1] IPI shorthand broadcast: enabled
[   12.773633][    T1] AVX2 version of gcm_enc/dec engaged.
[   12.779675][    T1] AES CTR mode by8 optimization enabled
[   14.227701][    T1] sched_clock: Marking stable (14190061000, 35522337)-=
>(14229701277, -4117940)
[   14.241866][    T1] Timer migration: 1 hierarchy levels; 8 children per =
group; 0 crossnode level
[   14.253943][    T1] registered taskstats version 1
[   14.270550][    T1] Loading compiled-in X.509 certificates
[   14.280599][    T1] Loaded X.509 cert 'Build time autogenerated kernel k=
ey: 4d8a14ab1354649e588ef893344f8a054513da14'
[   14.601155][    T1] zswap: loaded using pool lzo/zsmalloc
[   14.608936][    T1] Demotion targets for Node 0: null
[   14.614169][    T1] Demotion targets for Node 1: null
[   14.628617][    T1] debug_vm_pgtable: [debug_vm_pgtable         ]: Valid=
ating architecture page table helpers
[   17.258079][    T1] Key type .fscrypt registered
[   17.263049][    T1] Key type fscrypt-provisioning registered
[   17.276013][    T1] kAFS: Red Hat AFS client v0.1 registering.
[   17.300345][    T1] Btrfs loaded, assert=3Don, ref-verify=3Don, zoned=3D=
yes, fsverity=3Dyes
[   17.309004][    T1] Key type big_key registered
[   17.323034][    T1] Key type encrypted registered
[   17.328323][    T1] ima: No TPM chip found, activating TPM-bypass!
[   17.334853][    T1] Loading compiled-in module X.509 certificates
[   17.344084][    T1] Loaded X.509 cert 'Build time autogenerated kernel k=
ey: 4d8a14ab1354649e588ef893344f8a054513da14'
[   17.354904][    T1] ima: Allocated hash algorithm: sha256
[   17.360822][    T1] ima: No architecture policies found
[   17.366993][    T1] evm: Initialising EVM extended attributes:
[   17.372956][    T1] evm: security.selinux (disabled)
[   17.378069][    T1] evm: security.SMACK64
[   17.382213][    T1] evm: security.SMACK64EXEC
[   17.386715][    T1] evm: security.SMACK64TRANSMUTE
[   17.391638][    T1] evm: security.SMACK64MMAP
[   17.396145][    T1] evm: security.apparmor (disabled)
[   17.401333][    T1] evm: security.ima
[   17.405130][    T1] evm: security.capability
[   17.409889][    T1] evm: HMAC attrs: 0x1
[   17.416387][    T1] PM:   Magic number: 12:853:157
[   17.421445][    T1] usb usb36-port8: hash matches
[   17.426621][    T1] bdi 1:9: hash matches
[   17.431495][    T1] printk: legacy console [netcon0] enabled
[   17.437427][    T1] netconsole: network logging started
[   17.443443][    T1] gtp: GTP module loaded (pdp ctx size 128 bytes)
[   17.451315][    T1] rdma_rxe: loaded
[   17.455890][    T1] cfg80211: Loading compiled-in X.509 certificates for=
 regulatory database
[   17.468001][    T1] Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[   17.477349][    T1] Loaded X.509 cert 'wens: 61c038651aabdcf94bd0ac7ff06=
c7248db18c600'
[   17.487009][  T786] platform regulatory.0: Direct firmware load for regu=
latory.db failed with error -2
[   17.499048][    T1] clk: Disabling unused clocks
[   17.503984][    T1] ALSA device list:
[   17.507873][  T786] platform regulatory.0: Falling back to sysfs fallbac=
k for: regulatory.db
[   17.515939][    T1]   #0: Dummy 1
[   17.520114][    T1]   #1: Loopback 1
[   17.523819][    T1]   #2: Virtual MIDI Card 1
[   17.531956][    T1] md: Waiting for all devices to be available before a=
utodetect
[   17.539623][    T1] md: If you don't use raid, use raid=3Dnoautodetect
[   17.546155][    T1] md: Autodetecting RAID arrays.
[   17.551160][    T1] md: autorun ...
[   17.554815][    T1] md: ... autorun DONE.
[   17.623375][    T1] EXT4-fs (sda1): mounted filesystem 5941fea2-f5fa-4b4=
e-b5ef-9af118b27b95 ro with ordered data mode. Quota mode: none.
[   17.636264][    T1] VFS: Mounted root (ext4 filesystem) readonly on devi=
ce 8:1.
[   17.649480][    T1] devtmpfs: mounted
[   17.737799][    T1] Freeing unused kernel image (initmem) memory: 25888K
[   17.748732][    T1] Write protecting the kernel read-only data: 212992k
[   17.766778][    T1] Freeing unused kernel image (rodata/data gap) memory=
: 756K
[   17.872267][    T1] x86/mm: Checked W+X mappings: passed, no W+X pages f=
ound.
[   17.880469][    T1] x86/mm: Checking user space page tables
[   17.972322][    T1] x86/mm: Checked W+X mappings: passed, no W+X pages f=
ound.
[   17.985697][    T1] Failed to set sysctl parameter 'max_rcu_stall_to_pan=
ic=3D1': parameter not found
[   17.995475][    T1] Run /sbin/init as init process
[   18.362152][ T4502] mount (4502) used greatest stack depth: 23680 bytes =
left
[   18.417722][ T4503] EXT4-fs (sda1): re-mounted 5941fea2-f5fa-4b4e-b5ef-9=
af118b27b95 r/w. Quota mode: none.
[   18.432004][ T4503] mount (4503) used greatest stack depth: 23608 bytes =
left
mount: mounting selinuxfs on /sys/fs/selinux failed: No such file or direct=
ory
[   18.598864][ T4506] mount (4506) used greatest stack depth: 20672 bytes =
left
Starting syslogd: OK
Starting acpid: OK
Starting klogd: OK
Running sysctl: OK
Populating /dev using udev: [   19.589483][ T4536] udevd[4536]: starting ve=
rsion 3.2.11
[   19.881043][ T4537] udevd[4537]: starting eudev-3.2.11
[   19.883595][ T4536] udevd (4536) used greatest stack depth: 18776 bytes =
left
[   23.456570][ T2487] Oops: general protection fault, probably for non-can=
onical address 0xdffffc000000001c: 0000 [#1] PREEMPT SMP KASAN PTI
[   23.469312][ T2487] KASAN: null-ptr-deref in range [0x00000000000000e0-0=
x00000000000000e7]
[   23.477745][ T2487] CPU: 0 PID: 2487 Comm: kworker/u8:9 Not tainted 6.10=
.0-rc4-syzkaller-00148-g50736169ecc8-dirty #0
[   23.488606][ T2487] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 06/07/2024
[   23.498891][ T2487] Workqueue: writeback wb_workfn (flush-8:0)
[   23.504940][ T2487] RIP: 0010:__lock_acquire+0x6a/0x1fd0
[   23.510524][ T2487] Code: df 0f b6 04 30 84 c0 0f 85 4b 16 00 00 83 3d c=
8 e1 39 0e 00 0f 84 1c 11 00 00 83 3d bf 9d ad 0c 00 74 2c 4c 89 e0 48 c1 e=
8 03 <80> 3c 30 00 74 12 4c 89 e7 e8 28 1d 86 00 48 be 00 00 00 00 00 fc
[   23.530239][ T2487] RSP: 0018:ffffc900097874f0 EFLAGS: 00010002
[   23.536424][ T2487] RAX: 000000000000001c RBX: 0000000000000000 RCX: 000=
0000000000000
[   23.544419][ T2487] RDX: 0000000000000000 RSI: dffffc0000000000 RDI: 000=
00000000000e0
[   23.552415][ T2487] RBP: 0000000000000000 R08: 0000000000000001 R09: 000=
0000000000000
[   23.560670][ T2487] R10: dffffc0000000000 R11: fffffbfff1f58356 R12: 000=
00000000000e0
[   23.568661][ T2487] R13: 0000000000000000 R14: ffff88802a7a3c00 R15: 000=
0000000000000
[   23.576662][ T2487] FS:  0000000000000000(0000) GS:ffff8880b9400000(0000=
) knlGS:0000000000000000
[   23.585609][ T2487] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   23.592299][ T2487] CR2: 00007f77ff6ed907 CR3: 000000001f0a4000 CR4: 000=
00000003506f0
[   23.600343][ T2487] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000=
0000000000000
[   23.608338][ T2487] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000=
0000000000400
[   23.616341][ T2487] Call Trace:
[   23.619811][ T2487]  <TASK>
[   23.622841][ T2487]  ? __die_body+0x88/0xe0
[   23.627291][ T2487]  ? die_addr+0x108/0x140
[   23.631844][ T2487]  ? exc_general_protection+0x3dd/0x5d0
[   23.637448][ T2487]  ? asm_exc_general_protection+0x26/0x30
[   23.643205][ T2487]  ? __lock_acquire+0x6a/0x1fd0
[   23.648379][ T2487]  lock_acquire+0x1ed/0x550
[   23.653004][ T2487]  ? wb_writeback+0x13a/0xd80
[   23.657730][ T2487]  ? __pfx_lock_acquire+0x10/0x10
[   23.662789][ T2487]  ? __lock_acquire+0x1346/0x1fd0
[   23.667840][ T2487]  ? __pfx___might_resched+0x10/0x10
[   23.673653][ T2487]  ? __asan_memset+0x23/0x50
[   23.678272][ T2487]  down_write+0x3a/0x50
[   23.682535][ T2487]  ? wb_writeback+0x13a/0xd80
[   23.687231][ T2487]  wb_writeback+0x13a/0xd80
[   23.691774][ T2487]  ? mark_lock+0x9a/0x350
[   23.696126][ T2487]  ? __pfx_wb_writeback+0x10/0x10
[   23.701173][ T2487]  ? lockdep_hardirqs_on_prepare+0x43d/0x780
[   23.707179][ T2487]  wb_workfn+0xba1/0x1090
[   23.711621][ T2487]  ? __pfx_wb_workfn+0x10/0x10
[   23.716432][ T2487]  ? lockdep_hardirqs_on_prepare+0x43d/0x780
[   23.722440][ T2487]  ? __pfx_lockdep_hardirqs_on_prepare+0x10/0x10
[   23.728884][ T2487]  ? process_scheduled_works+0x945/0x1830
[   23.734721][ T2487]  process_scheduled_works+0xa2c/0x1830
[   23.740393][ T2487]  ? __pfx_process_scheduled_works+0x10/0x10
[   23.746411][ T2487]  ? assign_work+0x364/0x3d0
[   23.751113][ T2487]  worker_thread+0x86d/0xd70
[   23.755744][ T2487]  ? _raw_spin_unlock_irqrestore+0xdd/0x140
[   23.761710][ T2487]  ? __kthread_parkme+0x169/0x1d0
[   23.766764][ T2487]  ? __pfx_worker_thread+0x10/0x10
[   23.772004][ T2487]  kthread+0x2f0/0x390
[   23.776101][ T2487]  ? __pfx_worker_thread+0x10/0x10
[   23.781334][ T2487]  ? __pfx_kthread+0x10/0x10
[   23.786212][ T2487]  ret_from_fork+0x4b/0x80
[   23.790664][ T2487]  ? __pfx_kthread+0x10/0x10
[   23.795373][ T2487]  ret_from_fork_asm+0x1a/0x30
[   23.800262][ T2487]  </TASK>
[   23.803312][ T2487] Modules linked in:
[   23.807246][ T2487] ---[ end trace 0000000000000000 ]---
[   23.812972][ T2487] RIP: 0010:__lock_acquire+0x6a/0x1fd0
[   23.818459][ T2487] Code: df 0f b6 04 30 84 c0 0f 85 4b 16 00 00 83 3d c=
8 e1 39 0e 00 0f 84 1c 11 00 00 83 3d bf 9d ad 0c 00 74 2c 4c 89 e0 48 c1 e=
8 03 <80> 3c 30 00 74 12 4c 89 e7 e8 28 1d 86 00 48 be 00 00 00 00 00 fc
[   23.838435][ T2487] RSP: 0018:ffffc900097874f0 EFLAGS: 00010002
[   23.844527][ T2487] RAX: 000000000000001c RBX: 0000000000000000 RCX: 000=
0000000000000
[   23.852515][ T2487] RDX: 0000000000000000 RSI: dffffc0000000000 RDI: 000=
00000000000e0
[   23.860505][ T2487] RBP: 0000000000000000 R08: 0000000000000001 R09: 000=
0000000000000
[   23.868584][ T2487] R10: dffffc0000000000 R11: fffffbfff1f58356 R12: 000=
00000000000e0
[   23.876574][ T2487] R13: 0000000000000000 R14: ffff88802a7a3c00 R15: 000=
0000000000000
[   23.884566][ T2487] FS:  0000000000000000(0000) GS:ffff8880b9400000(0000=
) knlGS:0000000000000000
[   23.893785][ T2487] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   23.900586][ T2487] CR2: 00007f77ff6ed907 CR3: 000000001f0a4000 CR4: 000=
00000003506f0
[   23.908579][ T2487] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000=
0000000000000
[   23.916664][ T2487] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000=
0000000000400
[   23.924658][ T2487] Kernel panic - not syncing: Fatal exception
[   23.931104][ T2487] Kernel Offset: disabled
[   23.935520][ T2487] Rebooting in 86400 seconds..


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
 -ffile-prefix-map=3D/tmp/go-build1113195296=3D/tmp/go-build -gno-record-gc=
c-switches'

git status (err=3D<nil>)
HEAD detached at dac2aa43b4
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
/syzkaller/prog.GitRevision=3Ddac2aa43b4dbdbffa2c5e24a736096a6d928f633 -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20240620-104534'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-fuzzer=
 github.com/google/syzkaller/syz-fuzzer
GOOS=3Dlinux GOARCH=3Damd64 go build "-ldflags=3D-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3Ddac2aa43b4dbdbffa2c5e24a736096a6d928f633 -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20240620-104534'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-execpr=
og github.com/google/syzkaller/tools/syz-execprog
mkdir -p ./bin/linux_amd64
g++ -o ./bin/linux_amd64/syz-executor executor/executor.cc \
	-m64 -O2 -pthread -Wall -Werror -Wparentheses -Wunused-const-variable -Wfr=
ame-larger-than=3D16384 -Wno-stringop-overflow -Wno-array-bounds -Wno-forma=
t-overflow -Wno-unused-but-set-variable -Wno-unused-command-line-argument -=
static-pie -std=3Dc++17 -I. -Iexecutor/_include -fpermissive -w -DGOOS_linu=
x=3D1 -DGOARCH_amd64=3D1 \
	-DHOSTGOOS_linux=3D1 -DGIT_REVISION=3D\"dac2aa43b4dbdbffa2c5e24a736096a6d9=
28f633\"


Error text is too large and was truncated, full error text is at:
https://syzkaller.appspot.com/x/error.txt?x=3D15ee7dfa980000


Tested on:

commit:         50736169 Merge tag 'for-6.10-rc4-tag' of git://git.ker..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linu=
x.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=3D12f98862a3c0c79=
9
dashboard link: https://syzkaller.appspot.com/bug?extid=3Deda89a33c5856f66f=
823
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debia=
n) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D12ee231e9800=
00



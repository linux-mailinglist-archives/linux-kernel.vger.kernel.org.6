Return-Path: <linux-kernel+bounces-213091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC867906AF6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 13:27:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74EFA282E8D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 11:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2322313D511;
	Thu, 13 Jun 2024 11:27:07 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41305605C6
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 11:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718278026; cv=none; b=gqyNXLRdfFlKHxjBfSiiSeASH8LmeOY1S/UQ1ZLyKp5NE4xHZ8cUoWGnovI6cbH8lQpZsyWc4BkYZYgHhUC++qy6rf8JXIYLkJcbGAoSh+V4Uk1revWASZcBQwr/JrgRP+D77bwHnpKLi4ZBhqIA439V2rg0g975+EuYYscHI8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718278026; c=relaxed/simple;
	bh=4ZocuKkuzySf4glD4rKhDYDWTzUwrhh1WMlRAdt4Cfs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=pFIN+GdFk4jWPbJGGK9+HXIR2hUIso/lWjtDm5HrcMZUFlpltt2NXIi03c0+LK3tdVUqe1qYUwNR7DE/QRFeFZE7pMdPFlou+Wp889PQadF86gc3IK2n2laYzsbVTXvY50qCh6Y7m6hRXaZmhPFRsBVF3MRtu9Kn5PrZC/H1qnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7e6e4a83282so85629539f.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 04:27:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718278023; x=1718882823;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N+B7vLgmO9lz/eKFerpiEUpYgbOi6uck/6QqXVKaXn4=;
        b=Hu088E9Y7k/nCr52RDxv7tpGauigDPOYAOCpky9iBXx9PtySYacOc/+EFH5DxhJxOb
         SgOOTI+eIWXpe4bA9ko1dqCosTOCahBI53U5nz1Cy0qzyjpaL1Jfa7EVg3+l9Vb69+Cl
         eti69vdg9RXTw30bJRZL/7TiOLn9hcwP6JVcQl1orHJQzQQbX21gj5hV3gdnsSVZW1R9
         ap92Ic2XT/JNmx7rUmnl6T0IDUowYnEUZQ8SGCV3eX24xNrtChpngZE+9+1jk1/XBdwq
         GIqoQDn297DYWG8UGs5e794Gmhpm0WDY2JWAtXpRRqw9LIc5EAW3DzF7hRthKaPWMHL9
         RCGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbFzeXDL4OZY/G/JCpj2y0A7uoDX4u2Wu49+1NCj292VZumEfJgjNiTBgSW6dDOX0RQ/OvC5fFmtWa405OtU9a+MXDfNgDGraFdA68
X-Gm-Message-State: AOJu0Yx82RX0gH1p6ERMt/7W2IOuwrNCvCUTUM4EaLz/PN4H3z5RR/uf
	GaTFw9TsAj7wrue7gR3G4m+3q6pdjT+GBKCoRzGIoInrsM7eaNhKa+ENzehSibhgMx4uaO8Qye0
	Hbx/JYpXH1ze9vxJ9kbsNrL9MwqLza/cRlCInmtCsxSX8BEAZXCKMstw=
X-Google-Smtp-Source: AGHT+IH5hNuf9b/pNahktsAHylV24whdnX646/O3fX18VhUaUBhquKclGWZv7adR9jg5QP9Ee1G3jw3th/kjL+4/qP2mEdE69Kt3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2191:b0:375:b52f:3367 with SMTP id
 e9e14a558f8ab-375cd21b49amr2893245ab.5.1718278023431; Thu, 13 Jun 2024
 04:27:03 -0700 (PDT)
Date: Thu, 13 Jun 2024 04:27:03 -0700
In-Reply-To: <20240613105741.2380-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000365d4f061ac3c73e@google.com>
Subject: Re: [syzbot] [nilfs?] [mm?] KASAN: slab-use-after-free Read in lru_add_fn
From: syzbot <syzbot+d79afb004be235636ee8@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

rtificates
[   27.498273][    T1] Loaded X.509 cert 'Build time autogenerated kernel k=
ey: 4a58c6313a714cb9b62e9bbc978ba4e72aaa8139'
[   28.076996][    T1] zswap: loaded using pool lzo/zsmalloc
[   28.085428][    T1] Demotion targets for Node 0: null
[   28.089493][    T1] Demotion targets for Node 1: null
[   28.093331][    T1] debug_vm_pgtable: [debug_vm_pgtable         ]: Valid=
ating architecture page table helpers
[   28.129195][    T1] Key type .fscrypt registered
[   28.132498][    T1] Key type fscrypt-provisioning registered
[   28.149209][    T1] kAFS: Red Hat AFS client v0.1 registering.
[   28.176975][    T1] Btrfs loaded, assert=3Don, ref-verify=3Don, zoned=3D=
yes, fsverity=3Dyes
[   28.183012][    T1] Key type big_key registered
[   28.195418][ T4643] cryptomgr_probe (4643) used greatest stack depth: 26=
640 bytes left
[   28.203402][    T1] Key type encrypted registered
[   28.208063][    T1] ima: No TPM chip found, activating TPM-bypass!
[   28.213408][    T1] Loading compiled-in module X.509 certificates
[   28.223552][    T1] Loaded X.509 cert 'Build time autogenerated kernel k=
ey: 4a58c6313a714cb9b62e9bbc978ba4e72aaa8139'
[   28.231885][    T1] ima: Allocated hash algorithm: sha256
[   28.237241][    T1] ima: No architecture policies found
[   28.241738][    T1] evm: Initialising EVM extended attributes:
[   28.245792][    T1] evm: security.selinux
[   28.248896][    T1] evm: security.SMACK64 (disabled)
[   28.252724][    T1] evm: security.SMACK64EXEC (disabled)
[   28.256489][    T1] evm: security.SMACK64TRANSMUTE (disabled)
[   28.261651][    T1] evm: security.SMACK64MMAP (disabled)
[   28.266334][    T1] evm: security.apparmor (disabled)
[   28.270097][    T1] evm: security.ima
[   28.272869][    T1] evm: security.capability
[   28.275934][    T1] evm: HMAC attrs: 0x1
[   28.283244][    T1] PM:   Magic number: 12:860:276
[   28.287484][    T1] usb usb16: hash matches
[   28.290744][    T1] usb usb1-port4: hash matches
[   28.294300][    T1] tty ttyy4: hash matches
[   28.297451][    T1] tty tty13: hash matches
[   28.301166][    T1] printk: legacy console [netcon0] enabled
[   28.305399][    T1] netconsole: network logging started
[   28.309897][    T1] gtp: GTP module loaded (pdp ctx size 128 bytes)
[   28.315953][    T1] rdma_rxe: loaded
[   28.320305][    T1] cfg80211: Loading compiled-in X.509 certificates for=
 regulatory database
[   28.330077][    T1] Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[   28.336293][    T1] Loaded X.509 cert 'wens: 61c038651aabdcf94bd0ac7ff06=
c7248db18c600'
[   28.342579][    T1] clk: Disabling unused clocks
[   28.344843][   T57] platform regulatory.0: Direct firmware load for regu=
latory.db failed with error -2
[   28.345671][    T1] ALSA device list:
[   28.352355][   T57] platform regulatory.0: Falling back to sysfs fallbac=
k for: regulatory.db
[   28.354733][    T1]   #0: Dummy 1
[   28.363206][    T1]   #1: Loopback 1
[   28.365609][    T1]   #2: Virtual MIDI Card 1
[   28.374509][    T1] md: Waiting for all devices to be available before a=
utodetect
[   28.377950][    T1] md: If you don't use raid, use raid=3Dnoautodetect
[   28.380791][    T1] md: Autodetecting RAID arrays.
[   28.383158][    T1] md: autorun ...
[   28.384821][    T1] md: ... autorun DONE.
[   28.430411][    T1] EXT4-fs (sda1): mounted filesystem 5941fea2-f5fa-4b4=
e-b5ef-9af118b27b95 ro with ordered data mode. Quota mode: none.
[   28.438090][    T1] VFS: Mounted root (ext4 filesystem) readonly on devi=
ce 8:1.
[   28.445428][    T1] devtmpfs: mounted
[   28.550661][    T1] Freeing unused kernel image (initmem) memory: 26024K
[   28.554436][    T1] Write protecting the kernel read-only data: 204800k
[   28.587539][    T1] Freeing unused kernel image (rodata/data gap) memory=
: 1656K
[   28.749059][    T1] x86/mm: Checked W+X mappings: passed, no W+X pages f=
ound.
[   28.762706][    T1] Failed to set sysctl parameter 'max_rcu_stall_to_pan=
ic=3D1': parameter not found
[   28.769324][    T1] Run /sbin/init as init process
[   29.111224][    T1] SELinux:  Class mctp_socket not defined in policy.
[   29.114525][    T1] SELinux:  Class anon_inode not defined in policy.
[   29.117531][    T1] SELinux:  Class io_uring not defined in policy.
[   29.120566][    T1] SELinux:  Class user_namespace not defined in policy=
.
[   29.123879][    T1] SELinux: the above unknown classes and permissions w=
ill be denied
[   29.262598][    T1] SELinux:  policy capability network_peer_controls=3D=
1
[   29.265456][    T1] SELinux:  policy capability open_perms=3D1
[   29.268086][    T1] SELinux:  policy capability extended_socket_class=3D=
1
[   29.271171][    T1] SELinux:  policy capability always_check_network=3D0
[   29.274533][    T1] SELinux:  policy capability cgroup_seclabel=3D1
[   29.277510][    T1] SELinux:  policy capability nnp_nosuid_transition=3D=
1
[   29.280588][    T1] SELinux:  policy capability genfs_seclabel_symlinks=
=3D0
[   29.283870][    T1] SELinux:  policy capability ioctl_skip_cloexec=3D0
[   29.286828][    T1] SELinux:  policy capability userspace_initial_contex=
t=3D0
[   29.445219][    T1] ------------[ cut here ]------------
[   29.447605][    T1] WARNING: CPU: 3 PID: 1 at fs/super.c:111 super_lock+=
0x25a/0x3f0
[   29.450968][    T1] Modules linked in:
[   29.452766][    T1] CPU: 3 PID: 1 Comm: init Not tainted 6.10.0-rc3-syzk=
aller-g2ccbdf43d5e7-dirty #0
[   29.456852][    T1] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), =
BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[   29.461336][    T1] RIP: 0010:super_lock+0x25a/0x3f0
[   29.463998][    T1] Code: 00 00 00 be ff ff ff ff e8 23 fd ed 08 bf 01 0=
0 00 00 89 c5 89 c6 e8 a5 e3 93 ff 83 fd 01 0f 85 5e fe ff ff e8 97 e8 93 f=
f 90 <0f> 0b 90 e9 50 fe ff ff e8 89 e8 93 ff 48 89 ef e8 c1 bf 6d ff b9
[   29.472303][    T1] RSP: 0018:ffffc90000047940 EFLAGS: 00010293
[   29.474836][    T1] RAX: 0000000000000000 RBX: ffff88801d7c2000 RCX: fff=
fffff81f9fcab
[   29.478733][    T1] RDX: ffff8880166f8000 RSI: ffffffff81f9fcb9 RDI: 000=
0000000000005
[   29.482754][    T1] RBP: 0000000000000001 R08: 0000000000000005 R09: 000=
0000000000001
[   29.486209][    T1] R10: 0000000000000001 R11: 0000000000000003 R12: 000=
0000000000000
[   29.489719][    T1] R13: ffff88801d7c2108 R14: ffffffff843c8000 R15: 000=
0000000000001
[   29.493572][    T1] FS:  00007fa990752500(0000) GS:ffff88806b300000(0000=
) knlGS:0000000000000000
[   29.497349][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   29.499994][    T1] CR2: 0000000000000000 CR3: 000000002d31c000 CR4: 000=
0000000350ef0
[   29.503268][    T1] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000=
0000000000000
[   29.506485][    T1] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000=
0000000000400
[   29.510003][    T1] Call Trace:
[   29.511547][    T1]  <TASK>
[   29.513131][    T1]  ? show_regs+0x8c/0xa0
[   29.515097][    T1]  ? __warn+0xe5/0x3c0
[   29.517449][    T1]  ? super_lock+0x25a/0x3f0
[   29.519930][    T1]  ? report_bug+0x3c0/0x580
[   29.522377][    T1]  ? handle_bug+0x3d/0x70
[   29.524428][    T1]  ? exc_invalid_op+0x17/0x50
[   29.526474][    T1]  ? asm_exc_invalid_op+0x1a/0x20
[   29.528544][    T1]  ? __pfx_delayed_superblock_init+0x10/0x10
[   29.531076][    T1]  ? super_lock+0x24b/0x3f0
[   29.533337][    T1]  ? super_lock+0x259/0x3f0
[   29.535613][    T1]  ? super_lock+0x25a/0x3f0
[   29.537958][    T1]  ? __pfx_super_lock+0x10/0x10
[   29.539985][    T1]  ? __pfx_lock_release+0x10/0x10
[   29.542146][    T1]  ? do_raw_spin_lock+0x12d/0x2c0
[   29.544241][    T1]  ? __pfx_do_raw_spin_lock+0x10/0x10
[   29.546860][    T1]  ? __pfx_delayed_superblock_init+0x10/0x10
[   29.549606][    T1]  iterate_supers+0xb9/0x240
[   29.551299][    T1]  selinux_policy_commit+0x8cf/0xb50
[   29.553913][    T1]  ? __pfx_selinux_policy_commit+0x10/0x10
[   29.556233][    T1]  sel_write_load+0xc17/0x1c60
[   29.558255][    T1]  ? __pfx_sel_write_load+0x10/0x10
[   29.560434][    T1]  ? __pfx_lock_acquire+0x10/0x10
[   29.562504][    T1]  ? __pfx_down_read_trylock+0x10/0x10
[   29.565016][    T1]  ? __pfx_sel_write_load+0x10/0x10
[   29.567861][    T1]  vfs_write+0x30e/0x11e0
[   29.569822][    T1]  ? __pfx_vfs_write+0x10/0x10
[   29.572138][    T1]  ? do_sys_openat2+0xb1/0x1e0
[   29.574299][    T1]  ? __pfx_do_sys_openat2+0x10/0x10
[   29.576739][    T1]  ? __fget_light+0x173/0x210
[   29.578933][    T1]  ksys_write+0x12f/0x260
[   29.581014][    T1]  ? __pfx_ksys_write+0x10/0x10
[   29.583566][    T1]  do_syscall_64+0xcd/0x250
[   29.585811][    T1]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   29.588505][    T1] RIP: 0033:0x7fa9908a6bf2
[   29.590427][    T1] Code: 89 c7 48 89 44 24 08 e8 7b 34 fa ff 48 8b 44 2=
4 08 48 83 c4 28 c3 c3 64 8b 04 25 18 00 00 00 85 c0 75 20 b8 01 00 00 00 0=
f 05 <48> 3d 00 f0 ff ff 76 6f 48 8b 15 07 a2 0d 00 f7 d8 64 89 02 48 83
[   29.599851][    T1] RSP: 002b:00007fff0724f798 EFLAGS: 00000246 ORIG_RAX=
: 0000000000000001
[   29.603501][    T1] RAX: ffffffffffffffda RBX: 000000000000001f RCX: 000=
07fa9908a6bf2
[   29.607062][    T1] RDX: 00000000000415ce RSI: 00007fa990673000 RDI: 000=
0000000000004
[   29.610435][    T1] RBP: 0000000000000004 R08: 0000000000000005 R09: 000=
0000000000000
[   29.614021][    T1] R10: 0000000000000000 R11: 0000000000000246 R12: 000=
07fa990673000
[   29.617946][    T1] R13: 00000000000415ce R14: 00007fa990673000 R15: 000=
07fa9906ec16d
[   29.621423][    T1]  </TASK>
[   29.622972][    T1] Kernel panic - not syncing: kernel: panic_on_warn se=
t ...
[   29.626195][    T1] CPU: 3 PID: 1 Comm: init Not tainted 6.10.0-rc3-syzk=
aller-g2ccbdf43d5e7-dirty #0
[   29.630064][    T1] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), =
BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[   29.634065][    T1] Call Trace:
[   29.635583][    T1]  <TASK>
[   29.637030][    T1]  dump_stack_lvl+0x3d/0x1f0
[   29.639218][    T1]  panic+0x6f5/0x7a0
[   29.641169][    T1]  ? __pfx_panic+0x10/0x10
[   29.643238][    T1]  ? show_trace_log_lvl+0x363/0x500
[   29.645594][    T1]  ? check_panic_on_warn+0x1f/0xb0
[   29.647902][    T1]  ? super_lock+0x25a/0x3f0
[   29.649860][    T1]  check_panic_on_warn+0xab/0xb0
[   29.652103][    T1]  __warn+0xf1/0x3c0
[   29.653742][    T1]  ? super_lock+0x25a/0x3f0
[   29.655782][    T1]  report_bug+0x3c0/0x580
[   29.657433][    T1]  handle_bug+0x3d/0x70
[   29.658883][    T1]  exc_invalid_op+0x17/0x50
[   29.660432][    T1]  asm_exc_invalid_op+0x1a/0x20
[   29.662230][    T1] RIP: 0010:super_lock+0x25a/0x3f0
[   29.664395][    T1] Code: 00 00 00 be ff ff ff ff e8 23 fd ed 08 bf 01 0=
0 00 00 89 c5 89 c6 e8 a5 e3 93 ff 83 fd 01 0f 85 5e fe ff ff e8 97 e8 93 f=
f 90 <0f> 0b 90 e9 50 fe ff ff e8 89 e8 93 ff 48 89 ef e8 c1 bf 6d ff b9
[   29.671842][    T1] RSP: 0018:ffffc90000047940 EFLAGS: 00010293
[   29.674411][    T1] RAX: 0000000000000000 RBX: ffff88801d7c2000 RCX: fff=
fffff81f9fcab
[   29.677961][    T1] RDX: ffff8880166f8000 RSI: ffffffff81f9fcb9 RDI: 000=
0000000000005
[   29.681331][    T1] RBP: 0000000000000001 R08: 0000000000000005 R09: 000=
0000000000001
[   29.684832][    T1] R10: 0000000000000001 R11: 0000000000000003 R12: 000=
0000000000000
[   29.687874][    T1] R13: ffff88801d7c2108 R14: ffffffff843c8000 R15: 000=
0000000000001
[   29.691398][    T1]  ? __pfx_delayed_superblock_init+0x10/0x10
[   29.693916][    T1]  ? super_lock+0x24b/0x3f0
[   29.695826][    T1]  ? super_lock+0x259/0x3f0
[   29.697741][    T1]  ? __pfx_super_lock+0x10/0x10
[   29.699789][    T1]  ? __pfx_lock_release+0x10/0x10
[   29.701976][    T1]  ? do_raw_spin_lock+0x12d/0x2c0
[   29.703627][    T1]  ? __pfx_do_raw_spin_lock+0x10/0x10
[   29.705590][    T1]  ? __pfx_delayed_superblock_init+0x10/0x10
[   29.708029][    T1]  iterate_supers+0xb9/0x240
[   29.709711][    T1]  selinux_policy_commit+0x8cf/0xb50
[   29.711603][    T1]  ? __pfx_selinux_policy_commit+0x10/0x10
[   29.713750][    T1]  sel_write_load+0xc17/0x1c60
[   29.715547][    T1]  ? __pfx_sel_write_load+0x10/0x10
[   29.717449][    T1]  ? __pfx_lock_acquire+0x10/0x10
[   29.719811][    T1]  ? __pfx_down_read_trylock+0x10/0x10
[   29.722372][    T1]  ? __pfx_sel_write_load+0x10/0x10
[   29.724678][    T1]  vfs_write+0x30e/0x11e0
[   29.726426][    T1]  ? __pfx_vfs_write+0x10/0x10
[   29.728360][    T1]  ? do_sys_openat2+0xb1/0x1e0
[   29.729992][    T1]  ? __pfx_do_sys_openat2+0x10/0x10
[   29.731819][    T1]  ? __fget_light+0x173/0x210
[   29.733440][    T1]  ksys_write+0x12f/0x260
[   29.734819][    T1]  ? __pfx_ksys_write+0x10/0x10
[   29.736566][    T1]  do_syscall_64+0xcd/0x250
[   29.738441][    T1]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   29.740554][    T1] RIP: 0033:0x7fa9908a6bf2
[   29.742049][    T1] Code: 89 c7 48 89 44 24 08 e8 7b 34 fa ff 48 8b 44 2=
4 08 48 83 c4 28 c3 c3 64 8b 04 25 18 00 00 00 85 c0 75 20 b8 01 00 00 00 0=
f 05 <48> 3d 00 f0 ff ff 76 6f 48 8b 15 07 a2 0d 00 f7 d8 64 89 02 48 83
[   29.748513][    T1] RSP: 002b:00007fff0724f798 EFLAGS: 00000246 ORIG_RAX=
: 0000000000000001
[   29.751715][    T1] RAX: ffffffffffffffda RBX: 000000000000001f RCX: 000=
07fa9908a6bf2
[   29.754465][    T1] RDX: 00000000000415ce RSI: 00007fa990673000 RDI: 000=
0000000000004
[   29.757170][    T1] RBP: 0000000000000004 R08: 0000000000000005 R09: 000=
0000000000000
[   29.760005][    T1] R10: 0000000000000000 R11: 0000000000000246 R12: 000=
07fa990673000
[   29.762865][    T1] R13: 00000000000415ce R14: 00007fa990673000 R15: 000=
07fa9906ec16d
[   29.765759][    T1]  </TASK>
[   29.767583][    T1] Kernel Offset: disabled
[   29.769327][    T1] Rebooting in 86400 seconds..


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
GOMODCACHE=3D'/syzkaller/jobs/linux/gopath/pkg/mod'
GONOPROXY=3D''
GONOSUMDB=3D''
GOOS=3D'linux'
GOPATH=3D'/syzkaller/jobs/linux/gopath'
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
GOMOD=3D'/syzkaller/jobs/linux/gopath/src/github.com/google/syzkaller/go.mo=
d'
GOWORK=3D''
CGO_CFLAGS=3D'-O2 -g'
CGO_CPPFLAGS=3D''
CGO_CXXFLAGS=3D'-O2 -g'
CGO_FFLAGS=3D'-O2 -g'
CGO_LDFLAGS=3D'-O2 -g'
PKG_CONFIG=3D'pkg-config'
GOGCCFLAGS=3D'-fPIC -m64 -pthread -Wl,--no-gc-sections -fmessage-length=3D0=
 -ffile-prefix-map=3D/tmp/go-build3794894381=3D/tmp/go-build -gno-record-gc=
c-switches'

git status (err=3D<nil>)
HEAD detached at c2e072610
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
/syzkaller/prog.GitRevision=3Dc2e0726105cc811a456d900c62443159acc29c32 -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20240516-163404'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-fuzzer=
 github.com/google/syzkaller/syz-fuzzer
GOOS=3Dlinux GOARCH=3Damd64 go build "-ldflags=3D-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3Dc2e0726105cc811a456d900c62443159acc29c32 -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20240516-163404'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-execpr=
og github.com/google/syzkaller/tools/syz-execprog
mkdir -p ./bin/linux_amd64
gcc -o ./bin/linux_amd64/syz-executor executor/executor.cc \
	-m64 -std=3Dc++11 -I. -Iexecutor/_include -O2 -pthread -Wall -Werror -Wpar=
entheses -Wunused-const-variable -Wframe-larger-than=3D16384 -Wno-stringop-=
overflow -Wno-array-bounds -Wno-format-overflow -Wno-unused-but-set-variabl=
e -Wno-unused-command-line-argument -static-pie -fpermissive -w -DGOOS_linu=
x=3D1 -DGOARCH_amd64=3D1 \
	-DHOSTGOOS_linux=3D1 -DGIT_REVISION=3D\"c2e0726105cc811a456d900c62443159ac=
c29c32\"


Error text is too large and was truncated, full error text is at:
https://syzkaller.appspot.com/x/error.txt?x=3D16473b02980000


Tested on:

commit:         2ccbdf43 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/li=
nux.git master
kernel config:  https://syzkaller.appspot.com/x/.config?x=3Db8786f381e62940=
f
dashboard link: https://syzkaller.appspot.com/bug?extid=3Dd79afb004be235636=
ee8
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Deb=
ian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D132d1b369800=
00



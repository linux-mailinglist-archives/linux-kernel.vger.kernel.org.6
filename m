Return-Path: <linux-kernel+bounces-231727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 88C55919CEE
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 03:24:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F9A91F23AD1
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 01:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41EB8DDA1;
	Thu, 27 Jun 2024 01:24:10 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44FFBC8E9
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 01:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719451449; cv=none; b=rQPR9CKw2nQAo1wDAaBgWUueELVjjPQWYvJ+GAM4FZ5U8Zyj2lS1/ui16wL8kLztD7TfdNFAk3J4shkysAwGU+O3r7cKojjzkKIHmqbrPCWlMrY9qb32nGttsLbGlQjbVsxiryhPVNcZf9DOISOa1fjTILfn8mM8+GdyrPc7PZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719451449; c=relaxed/simple;
	bh=zt7ZcMwCvNwIq6Xvk/TTWleKVRzUrLYAitUft64vEKY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=pQPN8tEN+2ZypPhIzPimXVtOLGqWIYd+iOH8lGESO222gzZqUFttQ79808PjQguXa2WolsubiMzFgdbD4XIl0NqTOVdIcqgVf2xUvMkDBKPxfj6uk54Zhiv5xdOtDL5Dxyxu51EdeybZCRcxvWjyoMzoQI4IgtminlDioOKpwd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-376117f5fcfso92774475ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 18:24:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719451446; x=1720056246;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0xbtyf/UQu2AKwiRAxnRw8rDZCmV7AP2FTWmJUP+jPg=;
        b=ka7SXjWgpEg+Eb0nUfKLjjG8DwP3GqZodOEwQ2PuSL6ZRNDYND0gHYSP7S/NWewu+m
         WOVLfOb23vmSnmZz22jHauq4NwGUKbyXWGjovdoblS70YEZkJApi0Hfwn+Di41/fHcSI
         BmdMUt1ppQQ7JcM/bDvNQcQBo4RFX/zPnobH0Kaq9wGvwKxajXWlWyg71u9rJg8oO3j7
         tEPckEtmZ6B/uoerQHZloOWpj1PlNR76jiH+Gdo5R/cdnC64YOaEIwe1TMzveHIosN6l
         udDnLfUR6xCiiwEFA1kzn00hsezCg6A6Q2SVjcl89fHa49ufGkiRmGt2GsbJuasM1CU9
         qzCg==
X-Gm-Message-State: AOJu0YzUr4yJQrbCYVKIOUI/IamJ4tGPQ/ndBSiz3V8g+uqlp/6tNMK0
	ZuBsjFXs8ibycNjym8Q/kOuhlKhJcut8/vP4Lwrk3dRqiagaJQsaxvQLJ5Ev08vBFGNeDbkrePQ
	dEchmhP/ax9XkNcgSATCmxhZu1QBEp/6Zh2gNcyB4Hah0X6R9YLdXf1E=
X-Google-Smtp-Source: AGHT+IEv58cS+/fMhZ43NbkXFa/HxjjTHm+UIoiuGGkAoIChBeTO+SuWgq3O8gc7LIjU1aTYyFoURjlhoA/A1ORubAM4n1ySIUF1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d01:b0:375:a535:f7ad with SMTP id
 e9e14a558f8ab-3763de07610mr11107135ab.0.1719451444350; Wed, 26 Jun 2024
 18:24:04 -0700 (PDT)
Date: Wed, 26 Jun 2024 18:24:04 -0700
In-Reply-To: <20240627005133.770565-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008ca64b061bd4fcba@google.com>
Subject: Re: [syzbot] [jfs?] INFO: task hung in txBegin
From: syzbot <syzbot+eda89a33c5856f66f823@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

] sched_clock: Marking stable (15250029932, 36185301)->(15287226125, -10108=
92)
[   15.298765][    T1] Timer migration: 1 hierarchy levels; 8 children per =
group; 0 crossnode level
[   15.310198][    T1] registered taskstats version 1
[   15.329828][    T1] Loading compiled-in X.509 certificates
[   15.340885][    T1] Loaded X.509 cert 'Build time autogenerated kernel k=
ey: d166f013ab7b5f705951ab1c608c6a6dfb658aa3'
[   15.661847][    T1] zswap: loaded using pool lzo/zsmalloc
[   15.670437][    T1] Demotion targets for Node 0: null
[   15.675655][    T1] Demotion targets for Node 1: null
[   15.681002][    T1] debug_vm_pgtable: [debug_vm_pgtable         ]: Valid=
ating architecture page table helpers
[   18.073034][    T1] Key type .fscrypt registered
[   18.077881][    T1] Key type fscrypt-provisioning registered
[   18.091455][    T1] kAFS: Red Hat AFS client v0.1 registering.
[   18.115633][    T1] Btrfs loaded, assert=3Don, ref-verify=3Don, zoned=3D=
yes, fsverity=3Dyes
[   18.124399][    T1] Key type big_key registered
[   18.138791][    T1] Key type encrypted registered
[   18.143916][    T1] ima: No TPM chip found, activating TPM-bypass!
[   18.150666][    T1] Loading compiled-in module X.509 certificates
[   18.160083][    T1] Loaded X.509 cert 'Build time autogenerated kernel k=
ey: d166f013ab7b5f705951ab1c608c6a6dfb658aa3'
[   18.171536][    T1] ima: Allocated hash algorithm: sha256
[   18.177605][    T1] ima: No architecture policies found
[   18.183789][    T1] evm: Initialising EVM extended attributes:
[   18.189828][    T1] evm: security.selinux (disabled)
[   18.194960][    T1] evm: security.SMACK64
[   18.199198][    T1] evm: security.SMACK64EXEC
[   18.203935][    T1] evm: security.SMACK64TRANSMUTE
[   18.209359][    T1] evm: security.SMACK64MMAP
[   18.213937][    T1] evm: security.apparmor (disabled)
[   18.219172][    T1] evm: security.ima
[   18.223027][    T1] evm: security.capability
[   18.227718][    T1] evm: HMAC attrs: 0x1
[   18.234253][    T1] PM:   Magic number: 12:850:256
[   18.239435][    T1] sound controlC0: hash matches
[   18.244901][    T1] vhci_hcd vhci_hcd.3: hash matches
[   18.250600][    T1] tty ttytf: hash matches
[   18.255802][    T1] printk: legacy console [netcon0] enabled
[   18.261717][    T1] netconsole: network logging started
[   18.267921][    T1] gtp: GTP module loaded (pdp ctx size 128 bytes)
[   18.275848][    T1] rdma_rxe: loaded
[   18.280657][    T1] cfg80211: Loading compiled-in X.509 certificates for=
 regulatory database
[   18.291523][    T1] Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[   18.299806][    T1] Loaded X.509 cert 'wens: 61c038651aabdcf94bd0ac7ff06=
c7248db18c600'
[   18.310214][    T1] clk: Disabling unused clocks
[   18.315369][    T1] ALSA device list:
[   18.320941][   T45] platform regulatory.0: Direct firmware load for regu=
latory.db failed with error -2
[   18.326362][    T1]   #0: Dummy 1
[   18.330739][   T45] platform regulatory.0: Falling back to sysfs fallbac=
k for: regulatory.db
[   18.334034][    T1]   #1: Loopback 1
[   18.346869][    T1]   #2: Virtual MIDI Card 1
[   18.354968][    T1] md: Waiting for all devices to be available before a=
utodetect
[   18.362861][    T1] md: If you don't use raid, use raid=3Dnoautodetect
[   18.369494][    T1] md: Autodetecting RAID arrays.
[   18.374524][    T1] md: autorun ...
[   18.378180][    T1] md: ... autorun DONE.
[   18.453031][    T1] EXT4-fs (sda1): mounted filesystem 5941fea2-f5fa-4b4=
e-b5ef-9af118b27b95 ro with ordered data mode. Quota mode: none.
[   18.466879][    T1] VFS: Mounted root (ext4 filesystem) readonly on devi=
ce 8:1.
[   18.563174][    T1] devtmpfs: mounted
[   18.648281][    T1] Freeing unused kernel image (initmem) memory: 25888K
[   18.659532][    T1] Write protecting the kernel read-only data: 212992k
[   18.676292][    T1] Freeing unused kernel image (rodata/data gap) memory=
: 756K
[   18.782315][    T1] x86/mm: Checked W+X mappings: passed, no W+X pages f=
ound.
[   18.790468][    T1] x86/mm: Checking user space page tables
[   18.882494][    T1] x86/mm: Checked W+X mappings: passed, no W+X pages f=
ound.
[   18.896143][    T1] Failed to set sysctl parameter 'max_rcu_stall_to_pan=
ic=3D1': parameter not found
[   18.906366][    T1] Run /sbin/init as init process
[   19.536334][ T4501] mount (4501) used greatest stack depth: 23680 bytes =
left
[   19.574177][ T4502] EXT4-fs (sda1): re-mounted 5941fea2-f5fa-4b4e-b5ef-9=
af118b27b95 r/w. Quota mode: none.
mount: mounting selinuxfs on /sys/fs/selinux failed: No such file or direct=
ory
[   19.682917][ T4505] mount (4505) used greatest stack depth: 20432 bytes =
left
Starting syslogd: OK
Starting acpid: OK
Starting klogd: OK
Running sysctl: OK
Populating /dev using udev: [   20.560303][ T4535] udevd[4535]: starting ve=
rsion 3.2.11
[   20.864707][ T4536] udevd[4536]: starting eudev-3.2.11
[   20.867564][ T4535] udevd (4535) used greatest stack depth: 18776 bytes =
left
[   24.630142][   T35] BUG: sleeping function called from invalid context a=
t kernel/locking/rwsem.c:1578
[   24.640074][   T35] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pi=
d: 35, name: kworker/u8:2
[   24.649231][   T35] preempt_count: 1, expected: 0
[   24.654121][   T35] RCU nest depth: 0, expected: 0
[   24.659688][   T35] 3 locks held by kworker/u8:2/35:
[   24.665009][   T35]  #0: ffff88801aef1148 ((wq_completion)writeback){+.+=
.}-{0:0}, at: process_scheduled_works+0x90a/0x1830
[   24.676546][   T35]  #1: ffffc90000ab7d00 ((work_completion)(&(&wb->dwor=
k)->work)){+.+.}-{0:0}, at: process_scheduled_works+0x945/0x1830
[   24.689351][   T35]  #2: ffff888022f160d8 (&wb->list_lock){+.+.}-{2:2}, =
at: wb_writeback+0x29f/0xd90
[   24.699132][   T35] Preemption disabled at:
[   24.699147][   T35] [<0000000000000000>] 0x0
[   24.708275][   T35] CPU: 1 PID: 35 Comm: kworker/u8:2 Not tainted 6.10.0=
-rc4-syzkaller-00148-g50736169ecc8-dirty #0
[   24.719246][   T35] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 06/07/2024
[   24.729422][   T35] Workqueue: writeback wb_workfn (flush-8:0)
[   24.735469][   T35] Call Trace:
[   24.738795][   T35]  <TASK>
[   24.741764][   T35]  dump_stack_lvl+0x241/0x360
[   24.746593][   T35]  ? __pfx_dump_stack_lvl+0x10/0x10
[   24.751997][   T35]  ? __pfx__printk+0x10/0x10
[   24.756629][   T35]  __might_resched+0x5d4/0x780
[   24.761435][   T35]  ? __pfx___might_resched+0x10/0x10
[   24.766849][   T35]  ? do_raw_spin_lock+0x14f/0x370
[   24.771922][   T35]  ? rcu_is_watching+0x15/0xb0
[   24.776730][   T35]  down_write+0x19/0x50
[   24.780962][   T35]  wb_writeback+0x46d/0xd90
[   24.785615][   T35]  ? queue_io+0x3b1/0x5a0
[   24.790076][   T35]  ? __pfx_wb_writeback+0x10/0x10
[   24.795277][   T35]  ? lockdep_hardirqs_on_prepare+0x43d/0x780
[   24.801400][   T35]  wb_workfn+0xba1/0x1090
[   24.805787][   T35]  ? __pfx_wb_workfn+0x10/0x10
[   24.810612][   T35]  ? lockdep_hardirqs_on_prepare+0x43d/0x780
[   24.816631][   T35]  ? __pfx_lockdep_hardirqs_on_prepare+0x10/0x10
[   24.823192][   T35]  ? process_scheduled_works+0x945/0x1830
[   24.829118][   T35]  process_scheduled_works+0xa2c/0x1830
[   24.834746][   T35]  ? __pfx_process_scheduled_works+0x10/0x10
[   24.840783][   T35]  ? assign_work+0x364/0x3d0
[   24.845504][   T35]  worker_thread+0x86d/0xd70
[   24.850226][   T35]  ? _raw_spin_unlock_irqrestore+0xdd/0x140
[   24.856176][   T35]  ? __kthread_parkme+0x169/0x1d0
[   24.861349][   T35]  ? __pfx_worker_thread+0x10/0x10
[   24.866766][   T35]  kthread+0x2f0/0x390
[   24.871147][   T35]  ? __pfx_worker_thread+0x10/0x10
[   24.876294][   T35]  ? __pfx_kthread+0x10/0x10
[   24.881000][   T35]  ret_from_fork+0x4b/0x80
[   24.885712][   T35]  ? __pfx_kthread+0x10/0x10
[   24.890344][   T35]  ret_from_fork_asm+0x1a/0x30
[   24.895164][   T35]  </TASK>
[   24.898489][   T35] Oops: general protection fault, probably for non-can=
onical address 0xdffffc000000001c: 0000 [#1] PREEMPT SMP KASAN PTI
[   24.911278][   T35] KASAN: null-ptr-deref in range [0x00000000000000e0-0=
x00000000000000e7]
[   24.919719][   T35] CPU: 1 PID: 35 Comm: kworker/u8:2 Tainted: G        =
W          6.10.0-rc4-syzkaller-00148-g50736169ecc8-dirty #0
[   24.932070][   T35] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 06/07/2024
[   24.942545][   T35] Workqueue: writeback wb_workfn (flush-8:0)
[   24.948754][   T35] RIP: 0010:__lock_acquire+0x6a/0x1fd0
[   24.954267][   T35] Code: df 0f b6 04 30 84 c0 0f 85 4b 16 00 00 83 3d c=
8 e1 39 0e 00 0f 84 1c 11 00 00 83 3d bf 9d ad 0c 00 74 2c 4c 89 e0 48 c1 e=
8 03 <80> 3c 30 00 74 12 4c 89 e7 e8 28 1d 86 00 48 be 00 00 00 00 00 fc
[   24.974168][   T35] RSP: 0018:ffffc90000ab74f0 EFLAGS: 00010002
[   24.980269][   T35] RAX: 000000000000001c RBX: 0000000000000000 RCX: 000=
0000000000000
[   24.988696][   T35] RDX: 0000000000000000 RSI: dffffc0000000000 RDI: 000=
00000000000e0
[   24.996955][   T35] RBP: 0000000000000000 R08: 0000000000000001 R09: 000=
0000000000000
[   25.004950][   T35] R10: dffffc0000000000 R11: fffffbfff1f58356 R12: 000=
00000000000e0
[   25.013039][   T35] R13: 0000000000000000 R14: ffff88801b681e00 R15: 000=
0000000000000
[   25.021122][   T35] FS:  0000000000000000(0000) GS:ffff8880b9500000(0000=
) knlGS:0000000000000000
[   25.030088][   T35] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   25.036701][   T35] CR2: 0000556986fc54d0 CR3: 00000000182a6000 CR4: 000=
00000003506f0
[   25.044884][   T35] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000=
0000000000000
[   25.053744][   T35] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000=
0000000000400
[   25.061994][   T35] Call Trace:
[   25.065274][   T35]  <TASK>
[   25.068217][   T35]  ? __die_body+0x88/0xe0
[   25.072557][   T35]  ? die_addr+0x108/0x140
[   25.076910][   T35]  ? exc_general_protection+0x3dd/0x5d0
[   25.082477][   T35]  ? asm_exc_general_protection+0x26/0x30
[   25.088247][   T35]  ? __lock_acquire+0x6a/0x1fd0
[   25.093088][   T35]  ? dump_stack_lvl+0x301/0x360
[   25.097954][   T35]  ? __pfx_dump_stack_lvl+0x10/0x10
[   25.103247][   T35]  ? __pfx__printk+0x10/0x10
[   25.107831][   T35]  lock_acquire+0x1ed/0x550
[   25.112421][   T35]  ? wb_writeback+0x46d/0xd90
[   25.117117][   T35]  ? __pfx_lock_acquire+0x10/0x10
[   25.122288][   T35]  ? __pfx___might_resched+0x10/0x10
[   25.127589][   T35]  ? do_raw_spin_lock+0x14f/0x370
[   25.132730][   T35]  ? rcu_is_watching+0x15/0xb0
[   25.137508][   T35]  down_write+0x3a/0x50
[   25.141748][   T35]  ? wb_writeback+0x46d/0xd90
[   25.146528][   T35]  wb_writeback+0x46d/0xd90
[   25.151051][   T35]  ? queue_io+0x3b1/0x5a0
[   25.155403][   T35]  ? __pfx_wb_writeback+0x10/0x10
[   25.160438][   T35]  ? lockdep_hardirqs_on_prepare+0x43d/0x780
[   25.166596][   T35]  wb_workfn+0xba1/0x1090
[   25.170929][   T35]  ? __pfx_wb_workfn+0x10/0x10
[   25.175866][   T35]  ? lockdep_hardirqs_on_prepare+0x43d/0x780
[   25.181870][   T35]  ? __pfx_lockdep_hardirqs_on_prepare+0x10/0x10
[   25.188738][   T35]  ? process_scheduled_works+0x945/0x1830
[   25.194447][   T35]  process_scheduled_works+0xa2c/0x1830
[   25.200280][   T35]  ? __pfx_process_scheduled_works+0x10/0x10
[   25.206513][   T35]  ? assign_work+0x364/0x3d0
[   25.212499][   T35]  worker_thread+0x86d/0xd70
[   25.217342][   T35]  ? _raw_spin_unlock_irqrestore+0xdd/0x140
[   25.223233][   T35]  ? __kthread_parkme+0x169/0x1d0
[   25.228357][   T35]  ? __pfx_worker_thread+0x10/0x10
[   25.233743][   T35]  kthread+0x2f0/0x390
[   25.237985][   T35]  ? __pfx_worker_thread+0x10/0x10
[   25.243209][   T35]  ? __pfx_kthread+0x10/0x10
[   25.247808][   T35]  ret_from_fork+0x4b/0x80
[   25.252226][   T35]  ? __pfx_kthread+0x10/0x10
[   25.257349][   T35]  ret_from_fork_asm+0x1a/0x30
[   25.262136][   T35]  </TASK>
[   25.265145][   T35] Modules linked in:
[   25.269128][   T35] ---[ end trace 0000000000000000 ]---
[   25.274926][   T35] RIP: 0010:__lock_acquire+0x6a/0x1fd0
[   25.280593][   T35] Code: df 0f b6 04 30 84 c0 0f 85 4b 16 00 00 83 3d c=
8 e1 39 0e 00 0f 84 1c 11 00 00 83 3d bf 9d ad 0c 00 74 2c 4c 89 e0 48 c1 e=
8 03 <80> 3c 30 00 74 12 4c 89 e7 e8 28 1d 86 00 48 be 00 00 00 00 00 fc
[   25.300315][   T35] RSP: 0018:ffffc90000ab74f0 EFLAGS: 00010002
[   25.306627][   T35] RAX: 000000000000001c RBX: 0000000000000000 RCX: 000=
0000000000000
[   25.314710][   T35] RDX: 0000000000000000 RSI: dffffc0000000000 RDI: 000=
00000000000e0
[   25.322714][   T35] RBP: 0000000000000000 R08: 0000000000000001 R09: 000=
0000000000000
[   25.331044][   T35] R10: dffffc0000000000 R11: fffffbfff1f58356 R12: 000=
00000000000e0
[   25.339723][   T35] R13: 0000000000000000 R14: ffff88801b681e00 R15: 000=
0000000000000
[   25.347961][   T35] FS:  0000000000000000(0000) GS:ffff8880b9500000(0000=
) knlGS:0000000000000000
[   25.357437][   T35] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   25.364092][   T35] CR2: 0000556986fc54d0 CR3: 00000000182a6000 CR4: 000=
00000003506f0
[   25.372259][   T35] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000=
0000000000000
[   25.380762][   T35] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000=
0000000000400
[   25.388774][   T35] Kernel panic - not syncing: Fatal exception
[   25.395138][   T35] Kernel Offset: disabled
[   25.399763][   T35] Rebooting in 86400 seconds..


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
 -ffile-prefix-map=3D/tmp/go-build2587984659=3D/tmp/go-build -gno-record-gc=
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
https://syzkaller.appspot.com/x/error.txt?x=3D15d203a6980000


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
patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D1423533e9800=
00



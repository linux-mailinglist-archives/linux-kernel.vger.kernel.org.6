Return-Path: <linux-kernel+bounces-202031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED388FC6D8
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 10:46:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56B0A1C20DC2
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 08:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C8311494CA;
	Wed,  5 Jun 2024 08:45:51 +0000 (UTC)
Received: from proxmox-new.maurer-it.com (proxmox-new.maurer-it.com [94.136.29.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993B01946BE;
	Wed,  5 Jun 2024 08:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.136.29.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717577150; cv=none; b=g0ot0mtEYwHXTU0gTll3H+Tw9gZdY69hlmH4jheT7ehqhyYjVh8CEipcFNBQrzAAK2CiesFUANaH66KZMIBT8yY6E/b/sMbnD6IRKEHhK5BYSo7n8RqMbFxsNkR8Lao3jIRgP7qkFj+h7HRZ5lE7gnJOdkZ13lxRECEvCnfCZ5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717577150; c=relaxed/simple;
	bh=YEOpsdHHq6I5JBM3c1MylljJlTQL7qXCqWOU+JPKB04=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DmuzW10aECJC6l3gM6PwErXrNgssizb5OO03rAhxoDluW0R+DZqPSAWONB/048vTK1hbkFg4mGxbnqSwtffVQDJXCWkDTYJDhzxG4o2j5tnK61VwR2h5fkqPbyZA2odYrRgDEBkylq6lfPVUr+PRIzUQBcp5tO9Vb0NTzQKlwCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com; spf=pass smtp.mailfrom=proxmox.com; arc=none smtp.client-ip=94.136.29.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proxmox.com
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
	by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 0EDBF44D00;
	Wed,  5 Jun 2024 10:45:44 +0200 (CEST)
Message-ID: <c9d03ff7-27c5-4ebd-b3f6-5a90d96f35ba@proxmox.com>
Date: Wed, 5 Jun 2024 10:45:42 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: fix request.queuelist usage in flush
To: Chengming Zhou <chengming.zhou@linux.dev>, axboe@kernel.dk,
 ming.lei@redhat.com, hch@lst.de, bvanassche@acm.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 zhouchengming@bytedance.com
References: <20240604064745.808610-1-chengming.zhou@linux.dev>
Content-Language: en-US
From: Friedrich Weber <f.weber@proxmox.com>
In-Reply-To: <20240604064745.808610-1-chengming.zhou@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 04/06/2024 08:47, Chengming Zhou wrote:
> Friedrich Weber reported a kernel crash problem and bisected to commit
> 81ada09cc25e ("blk-flush: reuse rq queuelist in flush state machine").
> 
> The root cause is that we use "list_move_tail(&rq->queuelist, pending)"
> in the PREFLUSH/POSTFLUSH sequences. But rq->queuelist.next == xxx since
> it's popped out from plug->cached_rq in __blk_mq_alloc_requests_batch().
> We don't initialize its queuelist just for this first request, although
> the queuelist of all later popped requests will be initialized.
> 
> Fix it by changing to use "list_add_tail(&rq->queuelist, pending)" so
> rq->queuelist doesn't need to be initialized. It should be ok since rq
> can't be on any list when PREFLUSH or POSTFLUSH, has no move actually.
> 
> Please note the commit 81ada09cc25e ("blk-flush: reuse rq queuelist in
> flush state machine") also has another requirement that no drivers would
> touch rq->queuelist after blk_mq_end_request() since we will reuse it to
> add rq to the post-flush pending list in POSTFLUSH. If this is not true,
> we will have to revert that commit IMHO.

Unfortunately, with this patch applied to kernel 6.9 I get a different
crash [2] on a Debian 12 (virtual) machine with root on LVM on boot (no
software RAID involved). See [1] for lsblk and findmnt output. addr2line
says:

# addr2line -f -e /usr/lib/debug/vmlinux-6.9.0-patch0604-nodebuglist+
blk_mq_request_bypass_insert+0x20
blk_mq_request_bypass_insert
[...]/linux/block/blk-mq.c:2456

No crashes seen so far if the root is on LVM on top of software RAID, or
if the root partition is directly on disk.

If I can provide any more information, just let me know.

Thanks!

Best,

Friedrich

[1]

# lsblk -o name,fstype,label --ascii
NAME                          FSTYPE      LABEL
sda
|-sda1                        ext2
|-sda2
`-sda5                        LVM2_member
  |-kernel684--deb--vg-root   ext4
  `-kernel684--deb--vg-swap_1 swap
sr0                           iso9660     Debian 12.5.0 amd64 n
# findmnt --ascii
TARGET                       SOURCE     FSTYPE    OPTIONS
/                            /dev/mapper/kernel684--deb--vg-root
                                        ext4
rw,relatime,errors=remount-ro
|-/sys                       sysfs      sysfs
rw,nosuid,nodev,noexec,relatime
| |-/sys/kernel/security     securityfs securityf
rw,nosuid,nodev,noexec,relatime
| |-/sys/fs/cgroup           cgroup2    cgroup2
rw,nosuid,nodev,noexec,relatime,nsdelegate,memory_recursive
| |-/sys/fs/pstore           pstore     pstore
rw,nosuid,nodev,noexec,relatime
| |-/sys/fs/bpf              bpf        bpf
rw,nosuid,nodev,noexec,relatime,mode=700
| |-/sys/kernel/debug        debugfs    debugfs
rw,nosuid,nodev,noexec,relatime
| |-/sys/kernel/tracing      tracefs    tracefs
rw,nosuid,nodev,noexec,relatime
| |-/sys/fs/fuse/connections fusectl    fusectl
rw,nosuid,nodev,noexec,relatime
| `-/sys/kernel/config       configfs   configfs
rw,nosuid,nodev,noexec,relatime
|-/proc                      proc       proc
rw,nosuid,nodev,noexec,relatime
| `-/proc/sys/fs/binfmt_misc systemd-1  autofs
rw,relatime,fd=30,pgrp=1,timeout=0,minproto=5,maxproto=5,di
|-/dev                       udev       devtmpfs
rw,nosuid,relatime,size=4040780k,nr_inodes=1010195,mode=755
| |-/dev/pts                 devpts     devpts
rw,nosuid,noexec,relatime,gid=5,mode=620,ptmxmode=000
| |-/dev/shm                 tmpfs      tmpfs     rw,nosuid,nodev,inode64
| |-/dev/hugepages           hugetlbfs  hugetlbfs rw,relatime,pagesize=2M
| `-/dev/mqueue              mqueue     mqueue
rw,nosuid,nodev,noexec,relatime
|-/run                       tmpfs      tmpfs
rw,nosuid,nodev,noexec,relatime,size=813456k,mode=755,inode
| |-/run/lock                tmpfs      tmpfs
rw,nosuid,nodev,noexec,relatime,size=5120k,inode64
| |-/run/credentials/systemd-sysctl.service
| |                          ramfs      ramfs
ro,nosuid,nodev,noexec,relatime,mode=700
| |-/run/credentials/systemd-sysusers.service
| |                          ramfs      ramfs
ro,nosuid,nodev,noexec,relatime,mode=700
| |-/run/credentials/systemd-tmpfiles-setup-dev.service
| |                          ramfs      ramfs
ro,nosuid,nodev,noexec,relatime,mode=700
| |-/run/user/0              tmpfs      tmpfs
rw,nosuid,nodev,relatime,size=813452k,nr_inodes=203363,mode
| `-/run/credentials/systemd-tmpfiles-setup.service
|                            ramfs      ramfs
ro,nosuid,nodev,noexec,relatime,mode=700
`-/boot                      /dev/sda1  ext2      rw,relatime

[2]
[    1.137443] BUG: kernel NULL pointer dereference, address:
0000000000000000
[    1.137951] #PF: supervisor write access in kernel mode
[    1.138332] #PF: error_code(0x0002) - not-present page
[    1.138695] PGD 0 P4D 0
[    1.138697] Oops: 0002 [#1] PREEMPT SMP NOPTI
[    1.138702] CPU: 1 PID: 27 Comm: kworker/1:0H Tainted: G            E
     6.9.0-patch0604-nodebuglist+ #35
[    1.138703] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
[    1.138705] Workqueue: kblockd blk_mq_requeue_work
[    1.141021] RIP: 0010:_raw_spin_lock+0x13/0x60
[    1.141336] Code: 31 db c3 cc cc cc cc 90 90 90 90 90 90 90 90 90 90
90 90 90 90 90 90 0f 1f 44 00 00 65 ff 05 bc 94 cb 69 31 c0 ba 01 00 00
00 <f0> 0f b1 17 75 1b 31 c0 31 d2 31 c9 31 f6 31 ff 45 31 c0 45 31 c9
[    1.142670] RSP: 0018:ffffa42a40103d78 EFLAGS: 00010246
[    1.143032] RAX: 0000000000000000 RBX: ffff91c4c0357c00 RCX:
00000000ffffffe0
[    1.143545] RDX: 0000000000000001 RSI: 0000000000000001 RDI:
0000000000000000
[    1.144037] RBP: ffffa42a40103d98 R08: 0000000000000000 R09:
0000000000000000
[    1.144548] R10: 0000000000000000 R11: 0000000000000000 R12:
0000000000000000
[    1.145036] R13: 0000000000000001 R14: ffff91c5f7cc1d80 R15:
ffff91c4c153eb54
[    1.145542] FS:  0000000000000000(0000) GS:ffff91c5f7c80000(0000)
knlGS:0000000000000000
[    1.146092] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    1.146511] CR2: 0000000000000000 CR3: 000000010e514001 CR4:
0000000000370ef0
[    1.147003] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
0000000000000000
[    1.147507] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
0000000000000400
[    1.147997] Call Trace:
[    1.148177]  <TASK>
[    1.148332]  ? show_regs+0x6c/0x80
[    1.148603]  ? __die+0x24/0x80
[    1.148824]  ? page_fault_oops+0x175/0x5b0
[    1.149111]  ? do_user_addr_fault+0x311/0x680
[    1.149420]  ? exc_page_fault+0x82/0x1b0
[    1.149718]  ? asm_exc_page_fault+0x27/0x30
[    1.150013]  ? _raw_spin_lock+0x13/0x60
[    1.150282]  ? blk_mq_request_bypass_insert+0x20/0xe0
[    1.150663]  blk_mq_insert_request+0x120/0x1e0
[    1.150975]  blk_mq_requeue_work+0x18f/0x230
[    1.151277]  process_one_work+0x19b/0x3f0
[    1.151562]  worker_thread+0x32a/0x500
[    1.151847]  ? __pfx_worker_thread+0x10/0x10
[    1.152148]  kthread+0xe1/0x110
[    1.152373]  ? __pfx_kthread+0x10/0x10
[    1.152640]  ret_from_fork+0x44/0x70
[    1.152906]  ? __pfx_kthread+0x10/0x10
[    1.153169]  ret_from_fork_asm+0x1a/0x30
[    1.153449]  </TASK>
[    1.153608] Modules linked in: efi_pstore(E) dmi_sysfs(E)
qemu_fw_cfg(E) ip_tables(E) x_tables(E) autofs4(E) psmouse(E) bochs(E)
uhci_hcd(E) crc32_pclmul(E) drm_vram_helper(E) drm_ttm_helper(E)
i2c_piix4(E) ttm(E) ehci_hcd(E) pata_acpi(E) floppy(E)
[    1.155135] CR2: 0000000000000000
[    1.155370] ---[ end trace 0000000000000000 ]---
[    1.155694] RIP: 0010:_raw_spin_lock+0x13/0x60
[    1.156024] Code: 31 db c3 cc cc cc cc 90 90 90 90 90 90 90 90 90 90
90 90 90 90 90 90 0f 1f 44 00 00 65 ff 05 bc 94 cb 69 31 c0 ba 01 00 00
00 <f0> 0f b1 17 75 1b 31 c0 31 d2 31 c9 31 f6 31 ff 45 31 c0 45 31 c9
[    1.157306] RSP: 0018:ffffa42a40103d78 EFLAGS: 00010246
[    1.157669] RAX: 0000000000000000 RBX: ffff91c4c0357c00 RCX:
00000000ffffffe0
[    1.158172] RDX: 0000000000000001 RSI: 0000000000000001 RDI:
0000000000000000
[    1.158682] RBP: ffffa42a40103d98 R08: 0000000000000000 R09:
0000000000000000
[    1.159311] R10: 0000000000000000 R11: 0000000000000000 R12:
0000000000000000
[    1.159992] R13: 0000000000000001 R14: ffff91c5f7cc1d80 R15:
ffff91c4c153eb54
[    1.160575] FS:  0000000000000000(0000) GS:ffff91c5f7c80000(0000)
knlGS:0000000000000000
[    1.161186] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    1.161618] CR2: 0000000000000000 CR3: 000000010e514001 CR4:
0000000000370ef0
[    1.162158] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
0000000000000000
[    1.162691] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
0000000000000400



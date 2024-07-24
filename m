Return-Path: <linux-kernel+bounces-261031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7FCA93B1D4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 15:42:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F2251F24376
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 13:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1FDA158DD8;
	Wed, 24 Jul 2024 13:41:27 +0000 (UTC)
Received: from queue02a.mail.zen.net.uk (queue02a.mail.zen.net.uk [212.23.3.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02898158DBC
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 13:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.23.3.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721828487; cv=none; b=Jnhp7MwdxoPhQUbKmZH8nR0c/k/qojOJ2S1d8m5gXJjAArPJ1CqBe+ZOcrr9LXLWK28pcoc8fF2hlz310utn1QCjTgnrmSjqt9pVRWtnpo68b87QvzaOGT1l5Dh59cdUUnIsMfWRBlt/F1MonUqytXS/B8UtVbPC4NDDnuor/80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721828487; c=relaxed/simple;
	bh=haiFIvkLcXgNufFVP+JqAXWjG9hI9Enz+DkXMt3uXTw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=JwBKXVT0Hf9re2/SO2s0vMGRF2rdpj8mDMYAsLDQ7oKIsMgddh5KhqSIN0tKEYiVMQGu34cExlJYnMYuPfE4ltWPJT2K7dtYmA24lLSMBj4ifA1lHsq/LpJJTyZjgzFiw34sQcrEh7pKVzhcR2pPy2wozyGVc7yFS/RgjsoTXX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dingwall.me.uk; spf=pass smtp.mailfrom=dingwall.me.uk; arc=none smtp.client-ip=212.23.3.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dingwall.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dingwall.me.uk
Received: from [212.23.1.5] (helo=smarthost01c.sbp.mail.zen.net.uk)
	by queue02a.mail.zen.net.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <james@dingwall.me.uk>)
	id 1sWc0K-0029wg-D1
	for linux-kernel@vger.kernel.org;
	Wed, 24 Jul 2024 13:26:04 +0000
Received: from [217.155.64.189] (helo=mail0.xen.dingwall.me.uk)
	by smarthost01c.sbp.mail.zen.net.uk with esmtpsa  (TLS1.0) tls TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA
	(Exim 4.95)
	(envelope-from <james@dingwall.me.uk>)
	id 1sWc0B-002NI0-OE;
	Wed, 24 Jul 2024 13:25:56 +0000
Received: from localhost (localhost [IPv6:::1])
	by mail0.xen.dingwall.me.uk (Postfix) with ESMTP id 91B4CA58C8E;
	Wed, 24 Jul 2024 14:25:56 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at dingwall.me.uk
Received: from mail0.xen.dingwall.me.uk ([127.0.0.1])
	by localhost (mail0.xen.dingwall.me.uk [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bEOORP5vMfvT; Wed, 24 Jul 2024 14:25:56 +0100 (BST)
Received: from behemoth.dingwall.me.uk (behemoth.dingwall.me.uk [192.168.1.5])
	by dingwall.me.uk (Postfix) with ESMTP id 6FB4BA58C8B;
	Wed, 24 Jul 2024 14:25:56 +0100 (BST)
Received: by behemoth.dingwall.me.uk (Postfix, from userid 1000)
	id 59BB6D7A314; Wed, 24 Jul 2024 14:25:56 +0100 (BST)
Date: Wed, 24 Jul 2024 14:25:56 +0100
From: James Dingwall <james@dingwall.me.uk>
To: linux-kernel@vger.kernel.org
Cc: Juergen Gross <jgross@suse.com>
Subject: xen/evtchn.c: Interrupt for port 32, but apparently not enabled;
 per-user 0000000012b765d1
Message-ID: <ZqEA5BnhTYsxMq/f@dingwall.me.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Originating-smarthost01c-IP: [217.155.64.189]
Feedback-ID: 217.155.64.189

Hi,

I have built a kernel derived from Ubuntu's Ubuntu-hwe-6.8-6.8.0-40.40_22.04.1
tag.  The logs are quiet until I start the first guest which has two network
cards passed through.  At this point the kernel log gets flooded with the
warning below.  This appears to the same warning which this commit was
supposed to suppress:

51c23bd691c0f1fb95b29731c356c6fd69925d17: xen/evtchn: avoid WARN() when unbinding an event channel

The tag already includes that commit and in my config:

$ grep CONFIG_DEBUG_SHIRQ /boot/config-6.8.0-40-generic 
# CONFIG_DEBUG_SHIRQ is not set

Could there be a related change which also needs to be picked or is there
the possibility that there is another trigger?

Thanks,
James


Ubuntu source repository:
https://git.launchpad.net/~ubuntu-kernel/ubuntu/+source/linux/+git/jammy/log/drivers/xen/evtchn.c?h=Ubuntu-hwe-6.8-6.8.0-40.40_22.04.1


For this particular hardware we've found we need to use pci=nomsi for the dom0
kernel otherwise passthrough is unstable but the same warning is emitted with
that removed.

[  207.342964] pciback 0000:65:00.0: xen_pciback: error enabling MSI-X for guest 2: err -22!
[  207.343249] pciback 0000:65:00.0: xen_pciback: error enabling MSI for guest 2: err -22
[  207.343515] pciback 0000:65:00.0: xen_pciback: error enabling MSI-X for guest 2: err -22!
[  207.343758] pciback 0000:65:00.0: xen_pciback: error enabling MSI for guest 2: err -22
[  207.417164] pciback 0000:65:00.1: xen_pciback: error enabling MSI-X for guest 2: err -22!
[  207.417457] pciback 0000:65:00.1: xen_pciback: error enabling MSI for guest 2: err -22
[  207.417698] pciback 0000:65:00.1: xen_pciback: error enabling MSI-X for guest 2: err -22!
[  207.418039] pciback 0000:65:00.1: xen_pciback: error enabling MSI for guest 2: err -22
[  210.246175] ------------[ cut here ]------------
[  210.246185] Interrupt for port 32, but apparently not enabled; per-user 0000000012b765d1
[  210.246228] WARNING: CPU: 5 PID: 0 at drivers/xen/evtchn.c:172 evtchn_interrupt+0xf1/0x100 [xen_evtchn]
[  210.246243] Modules linked in: drbd(OE) lru_cache bridge stp llc nvme_fabrics nvme_core nvme_auth xt_owner xt_multiport xt_hl xt_tcpudp xt_state xt_conntrack xt_NFLOG nft_compat nft_chain_nat nf_nat dell_rbu nf_tables dcdbas nfnetlink_log nfnetlink i40e joydev input_leds cmdlinepart ipmi_ssif igb spi_nor mei_me ioatdma mtd intel_pch_thermal mei dca acpi_power_meter ipmi_si acpi_ipmi ipmi_devintf mac_hid ipmi_msghandler binfmt_misc sch_fq_codel xen_pciback xen_netback xen_blkback xen_gntalloc xen_gntdev xen_evtchn xenfs ip_tables x_tables autofs4 raid10 raid0 zstd zram zfs(POE) spl(OE) xen_privcmd nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 aufs hid_generic usbhid hid raid1 dm_raid raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq libcrc32c efi_pstore ast i2c_i801 spi_intel_pci spi_intel i2c_smbus i2c_algo_bit ahci xhci_pci libahci xhci_pci_renesas wmi
[  210.246363] CPU: 5 PID: 0 Comm: swapper/5 Tainted: P           OE      6.8.0-40-generic #40~22.04.1
[  210.246367] Hardware name: Supermicro SYS-5019D-FN8TP-5-NC041/X11SDV-4C-TP8F, BIOS 2.1 01/18/2024
[  210.246369] RIP: e030:evtchn_interrupt+0xf1/0x100 [xen_evtchn]
[  210.246376] Code: 01 00 00 00 be 1d 00 00 00 49 8d bc 24 88 00 00 00 e8 83 5b a1 c0 eb 95 8b 73 20 4c 89 e2 48 c7 c7 38 c2 ae c0 e8 6f 8b 61 c0 <0f> 0b e9 4b ff ff ff 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90
[  210.246379] RSP: e02b:ffffc90040280d68 EFLAGS: 00010046
[  210.246382] RAX: 0000000000000000 RBX: ffff88810b5ec6c0 RCX: 0000000000000000
[  210.246385] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
[  210.246387] RBP: ffffc90040280d80 R08: 0000000000000000 R09: 0000000000000000
[  210.246389] R10: 0000000000000000 R11: 0000000000000000 R12: ffff888101b21f00
[  210.246391] R13: 0000000000000000 R14: 0000000000000057 R15: ffff888133156c00
[  210.246399] FS:  0000000000000000(0000) GS:ffff889046e80000(0000) knlGS:0000000000000000
[  210.246402] CS:  10000e030 DS: 002b ES: 002b CR0: 0000000080050033
[  210.246404] CR2: 00007bd4822ba000 CR3: 0000000174538000 CR4: 0000000000050660
[  210.246410] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  210.246412] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  210.246414] Call Trace:
[  210.246417]  <IRQ>
[  210.246421]  ? show_regs+0x6d/0x80
[  210.246428]  ? __warn+0x89/0x160
[  210.246434]  ? evtchn_interrupt+0xf1/0x100 [xen_evtchn]
[  210.246441]  ? report_bug+0x17e/0x1b0
[  210.246447]  ? handle_bug+0x46/0x90
[  210.246453]  ? exc_invalid_op+0x18/0x80
[  210.246456]  ? asm_exc_invalid_op+0x1b/0x20
[  210.246463]  ? evtchn_interrupt+0xf1/0x100 [xen_evtchn]
[  210.246468]  ? evtchn_interrupt+0xf1/0x100 [xen_evtchn]
[  210.246474]  __handle_irq_event_percpu+0x4c/0x1c0
[  210.246480]  handle_irq_event+0x39/0x80
[  210.246483]  try_one_irq+0xa3/0xd0
[  210.246487]  note_interrupt+0xe9/0x320
[  210.246492]  handle_irq_event+0x79/0x80
[  210.246495]  handle_fasteoi_irq+0x7d/0x200
[  210.246499]  handle_irq_desc+0x3d/0x60
[  210.246502]  generic_handle_irq+0x1f/0x30
[  210.246504]  handle_irq_for_port+0x69/0x120
[  210.246511]  __evtchn_fifo_handle_events+0x1cf/0x2e0
[  210.246515]  evtchn_fifo_handle_events+0xe/0x20
[  210.246518]  xen_evtchn_do_upcall+0x68/0xc0
[  210.246523]  __xen_pv_evtchn_do_upcall+0x21/0x40
[  210.246527]  xen_pv_evtchn_do_upcall+0xa5/0xc0
[  210.246532]  </IRQ>
[  210.246533]  <TASK>
[  210.246535]  exc_xen_hypervisor_callback+0x8/0x20
[  210.246539] RIP: e030:xen_hypercall_sched_op+0xa/0x20
[  210.246542] Code: 51 41 53 b8 1c 00 00 00 0f 05 41 5b 59 c3 cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc 51 41 53 b8 1d 00 00 00 0f 05 <41> 5b 59 c3 cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc
[  210.246545] RSP: e02b:ffffc90040167e60 EFLAGS: 00000246
[  210.246547] RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff822003aa
[  210.246549] RDX: 0000000000000000 RSI: deadbeefdeadf00d RDI: deadbeefdeadf00d
[  210.246551] RBP: ffffc90040167e78 R08: 0000000000000000 R09: 0000000000000000
[  210.246553] R10: 0000000000000000 R11: 0000000000000246 R12: ffff888100acaf00
[  210.246555] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[  210.246558]  ? xen_hypercall_sched_op+0xa/0x20
[  210.246562]  ? xen_safe_halt+0x10/0x30
[  210.246565]  default_idle+0x9/0x30
[  210.246569]  arch_cpu_idle+0x9/0x10
[  210.246572]  default_idle_call+0x2c/0xf0
[  210.246575]  cpuidle_idle_call+0x153/0x190
[  210.246581]  do_idle+0x87/0xf0
[  210.246585]  cpu_startup_entry+0x2a/0x30
[  210.246589]  cpu_bringup_and_idle+0xa1/0xc0
[  210.246594]  asm_cpu_bringup_and_idle+0x5/0x10
[  210.246601]  </TASK>
[  210.246602] ---[ end trace 0000000000000000 ]---


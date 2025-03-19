Return-Path: <linux-kernel+bounces-568533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E2F3A696EE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 18:56:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C22719C665C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 17:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B03E920A5F8;
	Wed, 19 Mar 2025 17:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=internode.on.net header.i=@internode.on.net header.b="CyiwqSEz"
Received: from omr04.pc5.atmailcloud.com (omr04.pc5.atmailcloud.com [52.64.86.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20B51C1F02
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 17:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.64.86.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742406931; cv=none; b=lwtrQEtNI3o/eN0+z+VHGRSgiItqAIz2eKxKoOFluKQrcW2+OlIZwTMGfI6pSa12otNOCmXR66+skvAXS4L+eObXrCjb6tDv6oOSJMOh+8kfbUd/GeB79xE+EZXI0GBvFbUDR3+5ysjZOyx+xm5EXT+sdW0AR+XiRZS4Q4Gqf8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742406931; c=relaxed/simple;
	bh=yo767fd7E+Z11oD4wnLkDlH82k3JRs6UqFCRxuHPe4I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FS1t2CuayuNIo8WAxoVYZFdOftUmC/k3rwe8AwFI1SEiDImLb2/jnkBv1pk3bxwI4kft1cFsFuPSal2gBbt/Oh34hNHx/1KpIKOPmKjY/guoydKlX4wnq/eJx7/0oEvMe72DTt4tjR3fapXMjPNRoohTu8eNL1EEPevTVRorj74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=internode.on.net; spf=pass smtp.mailfrom=internode.on.net; dkim=pass (2048-bit key) header.d=internode.on.net header.i=@internode.on.net header.b=CyiwqSEz; arc=none smtp.client-ip=52.64.86.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=internode.on.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=internode.on.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=internode.on.net; s=202309; h=MIME-Version:Message-ID:Date:Subject:To:From:
	content-type; bh=aEm4Z9hKWFW4PYM2ulSm6QgaBQUiniCKNJZYjddh1uw=; b=CyiwqSEzdZcg
	TFWCv4ap0XygbCvqqjYykv41sHH6CHjpZeVRvk39KO4Kd78jMadeLQPDTrL+SC/2BGkFnYrYj8fPD
	ye3HXBSi+IIt4DM80ZgPeNR6pNWGsjpjFrK+YXldnRlKjMAXBfrHJvrtVj4FW8fnCinM4xuuIIJ8k
	WXn//+qSWqFS6Bf+yYdYZXk2C69bDzR5GJU4qsSF1cAS1soHl6fh09rjgRRsq42Fvmz9pK1c+J0O1
	7C1jHmbLoP3QzBoqMK6cyaZCivXEFdc0Q4tqEu5tjn7RUm4niGrwKVuAffjNARuLPKtS0d6x3bYZ1
	3WJq9C3C5L3F2ocWJMWnxA==;
Received: from cmr-kakadu01.internal.pc5.atmailcloud.com (cmr-kakadu01.internal.pc5.atmailcloud.com [192.168.1.3]) 
	by omr.internal.pc5.atmailcloud.com (Exim/cmr-kakadu01.i-0b69cadbf102e5891) with ESMTPS
	(envelope-from <arthur.marsh@internode.on.net>)
	id 1tux7A-000000008St-1hX6 ;
	Wed, 19 Mar 2025 17:22:00 +0000
Received: from  (localhost [14.2.113.215]) 
	by cmr-kakadu01.internal.pc5.atmailcloud.com (Exim/localhost) with ESMTPSA
	(envelope-from <arthur.marsh@internode.on.net>)
	id 1tux79-000000007uf-3bYf ;
	Wed, 19 Mar 2025 17:21:59 +0000
Received: from amarsh04 by localhost with local (Exim 4.98.1)
	(envelope-from <arthur.marsh@internode.on.net>)
	id 1tux74-000000001Dy-0izB;
	Thu, 20 Mar 2025 03:51:54 +1030
From: Arthur Marsh <arthur.marsh@internode.on.net>
To: mawupeng1@huawei.com
Cc: akpm@linux-foundation.org,
	david@redhat.com,
	linmiaohe@huawei.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	mhocko@suse.com,
	nao.horiguchi@gmail.com,
	osalvador@suse.de
Subject: mm: memory-failure: update ttu flag inside unmap_poisoned_folio
Date: Thu, 20 Mar 2025 03:51:52 +1030
Message-ID: <20250319172153.4702-1-user@am64>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250217014329.3610326-2-mawupeng1@huawei.com>
References: <20250217014329.3610326-2-mawupeng1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Atmail-Id: arthur.marsh@internode.on.net
X-atmailcloud-spam-action: no action
X-Cm-Analysis: v=2.4 cv=X8RUKnTe c=1 sm=1 tr=0 ts=67dafd37 a=Wf/tQxuurhLsNL74MDa1ZA==:117 a=Wf/tQxuurhLsNL74MDa1ZA==:17 a=Vs1iUdzkB0EA:10 a=x7bEGLp0ZPQA:10 a=F_iRiheNdQ-88eDPA80A:9
X-Cm-Envelope: MS4xfKfRGbruu8LXVxbD0btreq1XCJpYJBOvWVS7dD/Y7hnVxJ05Pclcn1FjI9ZWjCBr3Hu94KOhTArzKsemRBAq2YYZEt/40JL1FRtESP4iO6msWAp8VFvO 0NqQvMKmER1Tvdzn9CvUY3QTuP8+owhoidDozaTmHogzQjATCt/s7mDl8+h8BOgrJzHPj4MbD3u/Sw==
X-atmailcloud-route: unknown

On recent kernel builds on a system with the following CPU with integrated =
GPU:

AMD Ryzen 5 5500GT with Radeon Graphics=20

using the integrated GPU, on the following motherboard:

System manufacturer System Product Name/PRIME B350M-A, BIOS 6232 09/29/2024

I've been getting the error below on the initial loading of chromium after
booting, which I git-bisected back to commit

b81679b1633aa43c0d973adfa816d78c1ed0d032 (which I am replying to now):

:

[  281.651311] WARNING: CPU: 4 PID: 3525 at mm/util.c:674 __kvmalloc_node_n=
oprof+0xc8/0xe0
[  281.651322] Modules linked in: snd_seq_dummy snd_hrtimer snd_seq_midi sn=
d_seq_midi_event snd_rawmidi snd_seq snd_seq_device fuse bnep bluetooth rfk=
ill cpufreq_userspace cpufreq_conservative cpufreq_powersave binfmt_misc nf=
_tables scsi_transport_iscsi nfnetlink sch_fq_codel exfat parport_pc ppdev =
lp parport rtl2832_sdr videobuf2_vmalloc videobuf2_memops videobuf2_v4l2 vi=
deobuf2_common videodev fc0012 rtl2832 i2c_mux regmap_i2c dvb_usb_rtl28xxu =
amdgpu dvb_usb_v2 dvb_core mc amdxcp gpu_sched snd_hda_codec_realtek snd_hd=
a_codec_hdmi drm_panel_backlight_quirks cec snd_hda_codec_generic drm_buddy=
 drm_ttm_helper ttm snd_hda_scodec_component snd_hda_intel drm_client_lib d=
rm_exec drm_suballoc_helper snd_intel_dspcfg drm_display_helper snd_hda_cod=
ec intel_rapl_msr intel_rapl_common snd_hda_core drm_kms_helper tpm_crb tpm=
_tis tpm_tis_core snd_hwdep drm snd_pcm tpm edac_mce_amd sha512_ssse3 sha3_=
generic jitterentropy_rng hmac drbg libaescfb snd_timer ansi_cprng sha512_g=
eneric i2c_algo_bit ecdh_generic snd sha256_ssse3 sha1_ssse3
[  281.651387]  ccp aesni_intel ecc video mfd_core gf128mul crypto_simd cry=
ptd button evdev soundcore wmi pcspkr rng_core k10temp ext4 crc16 mbcache j=
bd2 hid_generic usbhid sg uas sr_mod hid usb_storage cdrom sd_mod sp5100_tc=
o ahci libahci xhci_pci r8169 xhci_hcd libata realtek mdio_devres serio_raw=
 i2c_piix4 usbcore scsi_mod i2c_smbus libphy scsi_common usb_common
[  281.651424] CPU: 4 UID: 1000 PID: 3525 Comm: chromium Tainted: G        =
W          6.14.0-rc3+ #6448
[  281.651429] Tainted: [W]=3DWARN
[  281.651430] Hardware name: System manufacturer System Product Name/PRIME=
 B350M-A, BIOS 6232 09/29/2024
[  281.651433] RIP: 0010:__kvmalloc_node_noprof+0xc8/0xe0
[  281.651436] Code: 64 24 08 41 89 d8 be 01 00 00 00 48 89 ef 48 01 d1 48 =
89 44 24 10 48 c7 04 24 00 04 00 00 e8 6f 25 04 00 eb 87 80 e7 20 75 82 <0f=
> 0b 90 0f 1f 44 00 00 e9 75 ff ff ff 66 66 2e 0f 1f 84 00 00 00
[  281.651438] RSP: 0018:ffffb1334837fc40 EFLAGS: 00010246
[  281.651440] RAX: 0000000000000000 RBX: 00000000000000c0 RCX: 00000000000=
00016
[  281.651442] RDX: 0000000000000016 RSI: ffffffffbe164ba8 RDI: 00000000000=
52cc0
[  281.651443] RBP: 0000000498843b00 R08: ffffb1334837fda8 R09: ffffb133483=
7fdb8
[  281.651444] R10: 0000000000000018 R11: 0000000000000000 R12: 00000000fff=
fffff
[  281.651445] R13: ffffb1334837fcb8 R14: 0000000000000000 R15: ffff997e756=
80010
[  281.651446] FS:  00007fda628ef500(0000) GS:ffff99854e700000(0000) knlGS:=
0000000000000000
[  281.651447] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  281.651448] CR2: 00007fda6554b302 CR3: 000000013df40000 CR4: 00000000007=
50ef0
[  281.651449] PKRU: 55555558
[  281.651450] Call Trace:
[  281.651451]  <TASK>
[  281.651453]  ? __kvmalloc_node_noprof+0xc8/0xe0
[  281.651455]  ? __warn.cold+0xad/0x109
[  281.651459]  ? __kvmalloc_node_noprof+0xc8/0xe0
[  281.651461]  ? report_bug+0x102/0x190
[  281.651470]  ? handle_bug+0x59/0xa0
[  281.651474]  ? exc_invalid_op+0x1f/0x90
[  281.651477]  ? asm_exc_invalid_op+0x16/0x20
[  281.651481]  ? __kmalloc_node_noprof+0x278/0x360
[  281.651487]  ? __kvmalloc_node_noprof+0xc8/0xe0
[  281.651489]  ? srso_alias_return_thunk+0x5/0xfbef5
[  281.651491]  ? chrdev_open+0xad/0x220
[  281.651496]  amdgpu_bo_create_list_entry_array+0x47/0x120 [amdgpu]
[  281.651729]  amdgpu_bo_list_ioctl+0x4e/0x330 [amdgpu]
[  281.651823]  ? __pfx_amdgpu_bo_list_ioctl+0x10/0x10 [amdgpu]
[  281.651914]  drm_ioctl_kernel+0xa6/0x100 [drm]
[  281.651942]  drm_ioctl+0x236/0x540 [drm]
[  281.651954]  ? __pfx_amdgpu_bo_list_ioctl+0x10/0x10 [amdgpu]
[  281.652047]  ? srso_alias_return_thunk+0x5/0xfbef5
[  281.652049]  ? preempt_count_add+0x51/0xd0
[  281.652053]  ? srso_alias_return_thunk+0x5/0xfbef5
[  281.652054]  ? migrate_enable+0xc0/0xf0
[  281.652058]  amdgpu_drm_ioctl+0x58/0xa0 [amdgpu]
[  281.652138]  __x64_sys_ioctl+0x55f/0xab0
[  281.652143]  ? srso_alias_return_thunk+0x5/0xfbef5
[  281.652145]  ? do_sys_openat2+0x74/0xb0
[  281.652148]  ? do_user_addr_fault+0x3a0/0x660
[  281.652153]  do_syscall_64+0x47/0x110
[  281.652155]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  281.652157] RIP: 0033:0x7fda65ad08db
[  281.652159] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 =
00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89=
> c2 3d 00 f0 ff ff 77 1c 48 8b 44 24 18 64 48 2b 04 25 28 00 00
[  281.652160] RSP: 002b:00007ffc93108640 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000010
[  281.652162] RAX: ffffffffffffffda RBX: 00003cfc000ac640 RCX: 00007fda65a=
d08db
[  281.652162] RDX: 00007ffc931086f0 RSI: 00000000c0106443 RDI: 00000000000=
00014
[  281.652163] RBP: 00007ffc931086f0 R08: 0000000000000000 R09: 00000000000=
00000
[  281.652164] R10: 000000000000006c R11: 0000000000000246 R12: 00000000c01=
06443
[  281.652165] R13: 0000000000000014 R14: 00007ffc93108760 R15: 00003cfc000=
ac658
[  281.652168]  </TASK>
[  281.652168] ---[ end trace 0000000000000000 ]---

chromium still loads and runs fine, but I am left wondering why this message
is appearing.

I can supply full dmesg and .config if required.

Arthur.



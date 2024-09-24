Return-Path: <linux-kernel+bounces-336546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB127983C29
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 06:59:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00E401C2259B
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 04:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3467C2EAE6;
	Tue, 24 Sep 2024 04:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=internode.on.net header.i=@internode.on.net header.b="NdPvSPh5"
Received: from omr008.pc5.atmailcloud.com (omr008.pc5.atmailcloud.com [103.150.252.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6D71B85D1
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 04:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.150.252.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727153988; cv=none; b=NrqFzblYZvfa6QMQ1Bgb34CYzFLr5hVRtJHytHbpyW2nAA/1s92kGYmL1cmyY6jlIOhIGvQviCHwkVckzo4vgbfaxWL4G6sIfIpHB0k6faPlTyF3XwzInQoTjNLAPSwmcZbpmQSq9nYeWPO4ecse7Ykwc/t+zKy/AqPn4VyQEoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727153988; c=relaxed/simple;
	bh=HcR+oObdG5Uq4lvXWamWtYHcbohbHVyeAALd+MAhtxU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TiXf8ZusyjOHXYI2Lhp35xtaC/YXAlLUaMf92U6VrPAN8epl8fuW1LFj/VAYfHzToX2UsDiTDJ/mfHeqdQT3blznDJLYmsT5AsWp7jzH5HLa45u7EQ65rXV1VtBK2ofxfFpYXF5MF04M2KRJdEUKDzGB97bI+DXsI8llKN+2AyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=internode.on.net; spf=pass smtp.mailfrom=internode.on.net; dkim=pass (2048-bit key) header.d=internode.on.net header.i=@internode.on.net header.b=NdPvSPh5; arc=none smtp.client-ip=103.150.252.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=internode.on.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=internode.on.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=internode.on.net; s=202309; h=MIME-Version:Message-ID:Date:Subject:To:From:
	content-type; bh=Bd0m0lKahx0ufG2Rg4LSJmArdikJCL/clIHRL7DlP3E=; b=NdPvSPh5aQmo
	PAalmnv2byHXa3VXWJclc33FCeXzDf6Z5eG50zR+H8rKGGAf0sQacmTt1DIbJ/Z4buw04qhglDNVi
	/PERjo4aBFi5wOLxsaQHXVBnWiIAZ1l8JYsSR6w0Suww6iya0dy/leClNPoEp/YWiOIDhAKT3gliA
	hN2kw/PmxifbCTdToyMkozsqv0Y4cuCSn5C1qqcpbPcP96nOs4MdeygVVfe12MbUZA4DQ/WbQuuTI
	QsEVOYpZ7RXHSxIJCNh1504TwNLbaFnnteMIh7IOGwwtPKe+vZnRX47NEpNBQLEPyOWQ+jQiUwAnl
	munj67f7rwH82JYMEDMSnA==;
Received: from CMR-KAKADU01.i-0937858876fe97fce
	 by OMR.i-0927050fc0a7aad87 with esmtps
	(envelope-from <arthur.marsh@internode.on.net>)
	id 1ssuyb-000000000hS-14Xr;
	Tue, 24 Sep 2024 02:08:29 +0000
Received: from [118.210.167.213] (helo=localhost)
	 by CMR-KAKADU01.i-0937858876fe97fce with esmtpsa
	(envelope-from <arthur.marsh@internode.on.net>)
	id 1ssuya-000000001K3-2fzg;
	Tue, 24 Sep 2024 02:08:28 +0000
Received: from amarsh04 by localhost with local (Exim 4.98)
	(envelope-from <arthur.marsh@internode.on.net>)
	id 1ssuyW-000000001dA-1SmT;
	Tue, 24 Sep 2024 11:38:24 +0930
From: Arthur Marsh <arthur.marsh@internode.on.net>
To: arthur.marsh@internode.on.net
Cc: Xinhui.Pan@amd.com,
	airlied@gmail.com,
	alexander.deucher@amd.com,
	amd-gfx@lists.freedesktop.org,
	christian.koenig@amd.com,
	daniel@ffwll.ch,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	tzimmermann@suse.de,
	wuhoipok@gmail.com
Subject: radeon ARUBA NULL pointer dereference
Date: Tue, 24 Sep 2024 11:38:23 +0930
Message-ID: <20240924020824.6264-1-user@am64>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240919165641.4632-1-user@am64>
References: <20240919165641.4632-1-user@am64>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Atmail-Id: arthur.marsh@internode.on.net
X-atmailcloud-spam-action: no action
X-Cm-Analysis: v=2.4 cv=IbSBW3qa c=1 sm=1 tr=0 ts=66f21f1c a=Kh1sbcNhzywcxpuRN39Emg==:117 a=Kh1sbcNhzywcxpuRN39Emg==:17 a=EaEq8P2WXUwA:10 a=x7bEGLp0ZPQA:10 a=uY4uPcPNCCVrO73jntUA:9
X-Cm-Envelope: MS4xfMbd8kSXzSJezy0Fe8TZ0Ri+5deRCZkDPadwmew6AfuNVLbojUroncvZCWA14zSUTFv5+SnfwO6pNxypt1J6NmVEYjUkEyjvAK73h94tXJ8AvHSbHnmX LAhPe+oOAS/q92ww/wdBQKwUVpotG7Wd2LoVLdc7IkxcTsqr5/v8EgJKntomAAqcoPfIU7bqOwpuqIk8l8A/tL8I2ZbUE13p8bE=
X-atmailcloud-route: unknown

Using current Linus git head kernel, I was able to save the dmesg output:

[   17.218724] [drm] radeon kernel modesetting enabled.
[   17.218778] radeon 0000:00:01.0: vgaarb: deactivate vga console
[   17.219509] Console: switching to colour dummy device 80x25
[   17.219700] [drm] initializing kernel modesetting (ARUBA 0x1002:0x990C 0x1002:0x0123 0x00).
[   17.219773] ATOM BIOS: 113
[   17.219838] radeon 0000:00:01.0: VRAM: 768M 0x0000000000000000 - 0x000000002FFFFFFF (768M used)
[   17.219841] radeon 0000:00:01.0: GTT: 1024M 0x0000000030000000 - 0x000000006FFFFFFF
[   17.219844] [drm] Detected VRAM RAM=768M, BAR=256M
[   17.219845] [drm] RAM width 64bits DDR
[   17.219851] BUG: kernel NULL pointer dereference, address: 00000000000000a0
[   17.219852] #PF: supervisor read access in kernel mode
[   17.219853] #PF: error_code(0x0000) - not-present page
[   17.219854] PGD 0 P4D 0 
[   17.219856] Oops: Oops: 0000 [#1] PREEMPT_RT SMP NOPTI
[   17.219858] CPU: 0 UID: 0 PID: 451 Comm: udevd Not tainted 6.11.0+ #6121
[   17.219860] Hardware name: Gigabyte Technology Co., Ltd. To be filled by O.E.M./F2A78M-HD2, BIOS F2 05/28/2014
[   17.219862] RIP: 0010:dma_get_required_mask+0x11/0x50
[   17.219868] Code: 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f 44 00 00 48 8b 87 68 02 00 00 48 85 c0 74 11 <48> 8b 80 a0 00 00 00 48 85 c0 74 1f e9 ee ed 94 00 f6 87 2c 03 00
[   17.219870] RSP: 0018:ffffa54bc13a7b00 EFLAGS: 00010202
[   17.219871] RAX: 0000000000000000 RBX: 000000ffffffffff RCX: 0000000000000000
[   17.219872] RDX: 0000000000000000 RSI: 0000000000000027 RDI: ffff976f44e720c8
[   17.219873] RBP: ffff976f44e720c8 R08: 00000000ffffefff R09: ffffffffab2aab08
[   17.219874] R10: 00000000fffff000 R11: 0000000000000002 R12: 0000000000000000
[   17.219875] R13: ffff976f48a4aa30 R14: 0000000000000000 R15: 0000000000000028
[   17.219876] FS:  00007f59a070d840(0000) GS:ffff97726f800000(0000) knlGS:0000000000000000
[   17.219878] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   17.219879] CR2: 00000000000000a0 CR3: 00000001053b4000 CR4: 00000000000406f0
[   17.219880] Call Trace:
[   17.219881]  <TASK>
[   17.219882]  ? __die_body.cold+0x19/0x1e
[   17.219885]  ? page_fault_oops+0xa8/0x230
[   17.219889]  ? search_module_extables+0x4f/0x90
[   17.219891]  ? fixup_exception+0x36/0x2f0
[   17.219894]  ? exc_page_fault+0x88/0x1b0
[   17.219897]  ? asm_exc_page_fault+0x22/0x30
[   17.219900]  ? dma_get_required_mask+0x11/0x50
[   17.219902]  dma_addressing_limited+0x6c/0xb0
[   17.219905]  radeon_ttm_init+0x3f/0x210 [radeon]
[   17.219977]  cayman_init+0x97/0x290 [radeon]
[   17.220057]  radeon_device_init+0x5e9/0xb40 [radeon]
[   17.220115]  radeon_driver_load_kms+0xb0/0x260 [radeon]
[   17.220174]  radeon_pci_probe+0xff/0x170 [radeon]
[   17.220231]  pci_device_probe+0xbe/0x1a0
[   17.220234]  really_probe+0xde/0x350
[   17.220237]  ? pm_runtime_barrier+0x61/0xb0
[   17.220240]  ? __pfx___driver_attach+0x10/0x10
[   17.220242]  __driver_probe_device+0x78/0x110
[   17.220245]  driver_probe_device+0x2d/0xc0
[   17.220247]  __driver_attach+0xc9/0x1c0
[   17.220249]  bus_for_each_dev+0x6a/0xb0
[   17.220251]  ? migrate_enable+0xbf/0xf0
[   17.220254]  bus_add_driver+0x139/0x220
[   17.220256]  driver_register+0x6e/0xc0
[   17.220258]  ? __pfx_radeon_module_init+0x10/0x10 [radeon]
[   17.220315]  do_one_initcall+0x42/0x210
[   17.220318]  ? __kmalloc_cache_noprof+0x89/0x230
[   17.220321]  do_init_module+0x60/0x210
[   17.220324]  init_module_from_file+0x89/0xc0
[   17.220326]  __x64_sys_finit_module+0x142/0x390
[   17.220329]  do_syscall_64+0x47/0x110
[   17.220331]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   17.220334] RIP: 0033:0x7f59a0625279
[   17.220336] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 77 6b 0d 00 f7 d8 64 89 01 48
[   17.220337] RSP: 002b:00007ffd15ee7df8 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[   17.220339] RAX: ffffffffffffffda RBX: 00005578ae660840 RCX: 00007f59a0625279
[   17.220340] RDX: 0000000000000000 RSI: 00005578ae677fc0 RDI: 0000000000000011
[   17.220341] RBP: 0000000000000000 R08: 00007f59a06fcb20 R09: 00005578ae640550
[   17.220342] R10: 0000000000000040 R11: 0000000000000246 R12: 00005578ae677fc0
[   17.220342] R13: 0000000000020000 R14: 00005578ae651750 R15: 0000000000000000
[   17.220344]  </TASK>
[   17.220345] Modules linked in: radeon(+) snd_hda_codec_hdmi snd_seq_midi snd_seq_midi_event snd_seq snd_hda_intel snd_intel_dspcfg snd_emu10k1 snd_hda_codec drm_ttm_helper ttm snd_util_mem drm_suballoc_helper snd_ac97_codec snd_hda_core drm_display_helper ac97_bus snd_rawmidi snd_hwdep snd_seq_device snd_pcm drm_kms_helper edac_mce_amd sha512_ssse3 sha512_generic k10temp sha256_ssse3 sha1_ssse3 drm aesni_intel snd_timer gf128mul crypto_simd cryptd acpi_cpufreq evdev pcspkr serio_raw emu10k1_gp gameport at24 regmap_i2c i2c_algo_bit snd video soundcore wmi button sp5100_tco ext4 crc32c_generic crc16 mbcache jbd2 uas usb_storage hid_generic usbhid hid sg sr_mod sd_mod cdrom ata_generic firewire_ohci crc32_pclmul crc32c_intel firewire_core crc_itu_t pata_atiixp i2c_piix4 i2c_smbus ahci r8169 libahci xhci_pci ohci_pci realtek libata mdio_devres ehci_pci ohci_hcd xhci_hcd scsi_mod ehci_hcd scsi_common usbcore libphy usb_common
[   17.220388] CR2: 00000000000000a0
[   17.220390] ---[ end trace 0000000000000000 ]---

Happy to provide additional information and run tests.

Regards,

Arthur Marsh.


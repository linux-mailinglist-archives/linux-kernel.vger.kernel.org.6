Return-Path: <linux-kernel+bounces-329397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5F2C9790C9
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 14:32:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21BFA2858A8
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 12:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD9441CEE80;
	Sat, 14 Sep 2024 12:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=m3y3r.de header.i=@m3y3r.de header.b="EeLV4cWE"
Received: from www17.your-server.de (www17.your-server.de [213.133.104.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39BEC1482F3
	for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 12:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726317147; cv=none; b=rSafs5MpqIDGW1sU0LY/aRC869En6IGg8SHIX/r9fJ7yMvxaKj37QI2fYeOG0ydNUWxZIazCZbFy8LbjyRfuwsp0qDGDlgqaB9dgcMYcmKQ0lsbg5zr6nqqv10Ya2+3hfDQIQbF16Ge61vfmp1kBDwrhQmIgD0e5BDlYAjgGVtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726317147; c=relaxed/simple;
	bh=8fj3M84w2TPEljv7FUUanoJi2KRCPcOHzJGG6NtVOAw=;
	h=Date:Message-Id:From:To:Subject; b=ddYN58/0TbjXK6BGAW3ln4SRmScmCc0BtgFJ3yL8sQNFbvoc1IY7io67cAbqX/137KkmwqtmfUV3bhfwb1Y+6tVFsNWugQOxIU/RhZFPqcA4klf9yHR7NvsUSTYc6/xrf1UGlJHg8KLnDjYJRTFn/YD+0gz/LPMIuSP7bxBWz5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=m3y3r.de; spf=pass smtp.mailfrom=m3y3r.de; dkim=pass (2048-bit key) header.d=m3y3r.de header.i=@m3y3r.de header.b=EeLV4cWE; arc=none smtp.client-ip=213.133.104.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=m3y3r.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=m3y3r.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=m3y3r.de;
	s=default2402; h=Subject:To:From:Message-Id:Date:Sender:Reply-To:Cc:
	MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=oHo7UDZ7mFJCyXoCYBSTpl+jmG+KeoxnyE+SwZdNHQQ=; b=EeLV4cWEfeOoETa7yO5n5SEnYa
	QRGGK/XBru5zvEu+X0VE2KE2H4ZNMfl9JVqoEE3lx5zHFEiCPf1szq1i21XkO5+/0h2+mME8z8Nir
	1y1T7UX60cQuahbPMXnhG7cNAJtfpL6D53vJjtGY1u9Mu2/2TAY0lgYzy9LxGOr9TEbNHiQJcMzpT
	3RgHwCoyEtpq9WYxUyAiB745VX3+dGx37qLQS8tGiypVOP7f+yrNdUFb7rcelLgJEVx7XrmCjFL7z
	vhYM1ZZ7naBjNKMNwXvxLpCyR2yrjZTI0GbqROETcl/pIaKeDP29tNfnPvjN18k0d5RJiEZD88JiA
	Ng/f4IwA==;
Received: from sslproxy07.your-server.de ([78.47.199.104])
	by www17.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <thomas@m3y3r.de>)
	id 1spRcU-00059I-2t;
	Sat, 14 Sep 2024 14:11:18 +0200
Received: from [2a00:6020:509f:6000:216:cbff:fe8c:b265] (helo=maria.m3y3r.de)
	by sslproxy07.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <thomas@m3y3r.de>)
	id 1spRcU-000Phj-0u;
	Sat, 14 Sep 2024 14:11:18 +0200
Date: Sat, 14 Sep 2024 14:10:47 +0200
Message-Id: <ypeffrq2306w.fsf@maria>
From: thomas <thomas@m3y3r.de>
To: akpm@linux-foundation.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [BUG] 6.10.10: Bad page state in process xyz
X-Authenticated-Sender: thomas@m3y3r.de
X-Virus-Scanned: Clear (ClamAV 1.0.5/27398/Sat Sep 14 10:42:15 2024)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Hi,

in 6.10.10 kernel on x86 I see those BUGs:

[   19.131851] BUG: Bad page state in process update-exim4.co  pfn:06dd0
[   19.136660] page: refcount:0 mapcount:-1 mapping:00000000 index:0x0 pfn:0x6dd0
[   19.136672] flags: 0x40000014(referenced|dirty|zone=1)
[   19.136686] raw: 40000014 00000000 00000122 00000000 00000000 00000000 fffffffe 00000000
[   19.136691] raw: 00000000 00000000
[   19.136694] page dumped because: nonzero mapcount
[   19.136697] Modules linked in: btusb btrtl btintel btbcm btmtk bluetooth ecdh_generic ecc hid_appleir input_leds af_packet mousedev hid_apple hid_generic usbmouse usbkbd usbhid appletouch joydev sr_mod cfg80211 cdrom rfkill snd_hda_codec_idt snd_hda_codec_generic radeon snd_hda_intel drm_suballoc_helper i2c_algo_bit snd_intel_dspcfg drm_ttm_helper ttm snd_hda_codec snd_hwdep snd_hda_core drm_display_helper snd_pcm i2c_i801 applesmc acpi_cpufreq i2c_smbus ata_piix rng_core drm_kms_helper ehci_pci snd_timer snd soundcore sky2 uhci_hcd ehci_hcd rtc_cmos apple_bl video wmi mac_hid sg binfmt_script binfmt_misc fuse drm dm_mod configfs efivarfs ip_tables ipv6 autofs4
[   19.136862] CPU: 1 PID: 1747 Comm: update-exim4.co Tainted: G        W          6.10.10+ #1
[   19.136870] Hardware name: Apple Computer, Inc. MacBookPro1,1/Mac-F425BEC8, BIOS    MBP11.88Z.0055.B08.0610121325 10/12/06
[   19.136875] Call Trace:
[   19.136880]  ? dump_stack_lvl+0x51/0x60
[   19.136896]  ? dump_stack+0xa/0xc
[   19.136904]  ? bad_page+0x5f/0xf0
[   19.136915]  ? free_unref_folios+0x24b/0x5a0
[   19.136926]  ? folios_put_refs+0x108/0x14c
[   19.136936]  ? free_pages_and_swap_cache+0x130/0x138
[   19.136953]  ? tlb_batch_pages_flush+0xb6/0xf0
[   19.136960]  ? unmap_page_range+0xaec/0x1214
[   19.136973]  ? do_wp_page+0x6d5/0xf38
[   19.136983]  ? unmap_vmas+0x74/0xf0
[   19.136993]  ? exit_mmap+0x94/0x1f8
[   19.137004]  ? __mmput+0x31/0xec
[   19.137012]  ? do_exit+0x2a8/0x900
[   19.137022]  ? do_group_exit+0x21/0x68
[   19.137031]  ? __ia32_sys_exit_group+0xd/0x10
[   19.137040]  ? ia32_sys_call+0x211a/0x222c
[   19.137047]  ? __do_fast_syscall_32+0x50/0xd0
[   19.137057]  ? do_fast_syscall_32+0x26/0x58
[   19.137065]  ? entry_SYSENTER_32+0x98/0xf8
[   19.137077] Disabling lock debugging due to kernel taint
[   19.137315] BUG: Bad rss-counter state mm:696603f8 type:MM_FILEPAGES val:-1

In my previous kernel I didn't see such BUGs, besides thisWARNING:

Sep 12 10:31:54 maria kernel: ------------[ cut here ]------------
Sep 12 10:31:54 maria kernel: DEBUG_LOCKS_WARN_ON(val > preempt_count())
Sep 12 10:31:54 maria kernel: WARNING: CPU: 0 PID: 2894 at preempt_count_sub+0x56/0x90
Sep 12 10:31:54 maria kernel: Modules linked in: crypto_simd cryptd xts dm_crypt rfcomm bnep btusb btrtl btintel btbcm btmtk bluetooth ecdh_generic ecc hid_appleir input_leds hid_apple mousedev hid_generic usbkbd usbmouse af_packet appletouch usbhid cfg80211 rfkill joydev sr_mod cdrom snd_hda_codec_idt snd_hda_codec_generic ledtrig_audio radeon snd_hda_intel drm_suballoc_helper snd_intel_dspcfg i2c_algo_bit snd_hda_codec drm_ttm_helper snd_hwdep snd_hda_core ttm i2c_i801 applesmc snd_pcm drm_display_helper snd_timer acpi_cpufreq i2c_smbus ata_piix drm_kms_helper rng_core sky2 snd ehci_pci rtc_cmos soundcore apple_bl uhci_hcd video ehci_hcd wmi mac_hid sg binfmt_script binfmt_misc fuse drm dm_mod configfs efivarfs ip_tables ipv6 autofs4
Sep 12 10:31:54 maria kernel: CPU: 0 PID: 2894 Comm: kworker/0:0 Tainted: G        W          6.7.12+ #2
Sep 12 10:31:54 maria kernel: Hardware name: Apple Computer, Inc. MacBookPro1,1/Mac-F425BEC8, BIOS    MBP11.88Z.0055.B08.0610121325 10/12/06
Sep 12 10:31:54 maria kernel: Workqueue: events ata_scsi_dev_rescan
Sep 12 10:31:54 maria kernel: EIP: preempt_count_sub+0x56/0x90
Sep 12 10:31:54 maria kernel: Code: 9b c3 8d b6 00 00 00 00 e8 4b 12 34 00 85 c0 74 f0 8b 0d 40 e3 3f 9b 85 c9 75 e6 68 7b cb 22 9b 68 cd e7 21 9b e8 6a 9c fd ff <0f> 0b 58 5a c3 8d b4 26 00 00 00 00 66 90 84 d2 75 bc e8 17 12 34
Sep 12 10:31:54 maria kernel: EAX: 0000002a EBX: 81d9da40 ECX: 00000002 EDX: 80000002
Sep 12 10:31:54 maria kernel: ESI: 81d9eddc EDI: 81d9ee1c EBP: 00400000 ESP: a4043f08
Sep 12 10:31:54 maria kernel: DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00010286
Sep 12 10:31:54 maria kernel: CR0: 80050033 CR2: 77e42868 CR3: 1b4ce000 CR4: 000006f0
Sep 12 10:31:54 maria kernel: Call Trace:
Sep 12 10:31:54 maria kernel:  ? show_regs+0x54/0x58
Sep 12 10:31:54 maria kernel:  ? __warn+0x6b/0xd4
Sep 12 10:31:54 maria kernel:  ? preempt_count_sub+0x56/0x90
Sep 12 10:31:54 maria kernel:  ? report_bug+0x103/0x158
Sep 12 10:31:54 maria kernel:  ? exc_overflow+0x30/0x30
Sep 12 10:31:54 maria kernel:  ? handle_bug+0x20/0x48
Sep 12 10:31:54 maria kernel:  ? exc_invalid_op+0x18/0x54
Sep 12 10:31:54 maria kernel:  ? handle_exception+0xf9/0xf9
Sep 12 10:31:54 maria kernel:  ? exc_overflow+0x30/0x30
Sep 12 10:31:54 maria kernel:  ? preempt_count_sub+0x56/0x90
Sep 12 10:31:54 maria kernel:  ? exc_overflow+0x30/0x30
Sep 12 10:31:54 maria kernel:  ? preempt_count_sub+0x56/0x90
Sep 12 10:31:54 maria kernel:  ? _raw_spin_unlock_irqrestore+0x13/0x30
Sep 12 10:31:54 maria kernel:  ? ata_scsi_dev_rescan+0x13f/0x16c
Sep 12 10:31:54 maria kernel:  ? process_one_work+0xf6/0x204
Sep 12 10:31:54 maria kernel:  ? worker_thread+0x2b8/0x3ac
Sep 12 10:31:54 maria kernel:  ? preempt_count_add+0x59/0x88
Sep 12 10:31:54 maria kernel:  ? _raw_spin_lock_irqsave+0x11/0x38
Sep 12 10:31:54 maria kernel:  ? kthread+0xd8/0x100
Sep 12 10:31:54 maria kernel:  ? mod_delayed_work_on+0x74/0x74
Sep 12 10:31:54 maria kernel:  ? kthread_complete_and_exit+0x14/0x14
Sep 12 10:31:54 maria kernel:  ? ret_from_fork+0x27/0x38
Sep 12 10:31:54 maria kernel:  ? kthread_complete_and_exit+0x14/0x14
Sep 12 10:31:54 maria kernel:  ? ret_from_fork_asm+0xf/0x14
Sep 12 10:31:54 maria kernel:  ? entry_INT80_32+0xf0/0xf0
Sep 12 10:31:54 maria kernel: ---[ end trace 0000000000000000 ]---

Any help appreciated!

mfg
thomas


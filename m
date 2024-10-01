Return-Path: <linux-kernel+bounces-345108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BA5E98B21B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 04:34:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75B661C21A36
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 02:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 350C11CFB9;
	Tue,  1 Oct 2024 02:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="JZ7qUid2"
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1A33F9EC
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 02:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727750058; cv=none; b=EUVyCacNQ1nelUrOnMLHQOM5JYPOxrskGC694FVEs07tYw6cBa6wdIdvnkYvwKgo4JBuasZz3cxYttM93Yi2PUFxhr8AQ8n5TOnhU3Btt5A3lftK+1b1HEPD87Z6fGh53hujeeCS4tVgEoshXpn07/vMc1o3fGkDVlkuD7xzFDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727750058; c=relaxed/simple;
	bh=NDBZTY2AlIH4+Fz/OiD7/Z2DVe+0l9ifCC5C+dSOtzc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T6QPJf581jG894ZshY+pRX/q08eLXkoynzr5holKLvyaqane2DeXDJ3m9JDmpFHZvVUEWt4xjYFJoSfAnMXu5N2+SHco2zery1RGSk55OzHzLhEwqi/d8WyJAIwzbRFKhk4EwrjjCfw536vyENCWCiBYx3wDd6uBTbBftcrvHic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=JZ7qUid2; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1727750044; x=1728354844; i=spasswolf@web.de;
	bh=bbh5HUDBOaaa/UdLKTLJO05YFL0xC/xrU3ibQLD58+g=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=JZ7qUid29NtUxFAndK6fhBj0iR5evwEWE0rVtyAnB1Qo0TN5pXSPpjrKUWLsge8e
	 xBpvn5T7YgH1K6ZETCcLkY1h79Kf26T6By+K7dRBzvPSP2WDyP/FmzwSYX8y4oJ7P
	 IB5NgeqUefLSrLDzyLkYienKs9oHEUzCxgS/18YNjLYb71Pbx8yTw2M1y1ZXJ2Dfb
	 RJqO0+DBxuVAqSAf9oB6ogMNFC7ZI4AXeSDvFt/hTQjy7IgnfFg5MlXxT3LNFzC51
	 iZctHuGJn1FeHM4kN87nNgN8wuwlSCctqNbRP06+d6U4yg+OY/FCWylYMeWQd/Chw
	 o8NNyYtMQVM9VLd1JQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost.localdomain ([84.119.92.193]) by smtp.web.de
 (mrweb005 [213.165.67.108]) with ESMTPSA (Nemesis) id
 1MlsON-1sCoAh0dGd-00jbYd; Tue, 01 Oct 2024 04:34:04 +0200
From: Bert Karwatzki <spasswolf@web.de>
To: "Liam R . Howlett" <Liam.Howlett@oracle.com>
Cc: Bert Karwatzki <spasswolf@web.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 14/21] mm/mmap: Avoid zeroing vma tree in mmap_region()
Date: Tue,  1 Oct 2024 04:34:00 +0200
Message-ID: <20241001023402.3374-1-spasswolf@web.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: 20240830040101.822209-15-Liam.Howlett@oracle.com
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GUFcmiR+bUHmRa3KIzb88Naz1mt6x6to1o1mEXKWhYjraYmIxn3
 KyeQg3L3Dovg6tJ2hBcpUMoJCWQKthlaoxxLuAirVq2ANTTvBT6awgL/dN7S4Z2mjRfCvn+
 DgqUcs7FefPpBxPQ43SP2bkJyZB8vW8YFquleSWxtONnHmEto1q3e0DLbKttB9q/Osd5FLW
 iiUxL8jV8FeOGySkksxvQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:nAKVdcZLtXw=;gYpw4vXvfurHWkfjeUC/kCT0UgS
 xzOi/x1bkn/rt9HyOA1CayPhPNQKL6dbaz1gs9om+cp5eVKXxSFwyt2+Z9QV2er+B5KwVtH7I
 Fel/HPQgV4U75yxWNBbqsPLCc4IISeaTnGfXZt447SCLnOiugV5UbZPK+CdXLUAX/p18qB+W1
 hgEaMzPDujbsVm0F6sYaTAQMoIqqJEqd84/EK6dk5sM0f/DLSOyJLmNkOiR5ph+mV0ohke62S
 0JzEMyuTXptDN0pIpeqyKoTW88J4/iB2/MUOQ1EDB0WVTkFKAuOIWiW8C/KAmmKlLXArI6SFv
 EJAn/LcpXITZyjmRFpPuc1quQ+R94IYljSJeL9kAZxdnkAXJ7nnyGkxYHNSnMx1qYWsjMFMf5
 zD4yUaj9zA9+wI59p5AltOdjYxvNhjrB6kx4k6jBkGlnXoTntodDSQ70WgcPvlyh+UXPzN4ur
 o6SrHOlqopNlgq7/dON49Jz4OMl7Gh5qVa3DrCYX/TpmStQZDLnAYrsgQD4CF8v7Znk2GQ8ow
 vHP7gJtzrhNbtZmZ09PeXOFrcVgElM/5LnNH+ojEtYxyzQRMe+IbDuc27pf0PKktWYgqPa+Ig
 iXIxzv0qM+nHLjjRcmoa8FYtOk1bcr6wunoAP6/M7SDiDoyd7zP03NNfjntkcfEcGdTBhnZnW
 qxsKIRf9WqeF1oOMUxawvMizX6a2zGBq7+nbS3JICyqgD878cNVv0iwTuJmUcDNsvzS4UfPDX
 HZikYGVgnDLGSUrVx34jP3rPE6cSOk9Mz+A89iuB4un4zO03zoLa8qM63QSzcfNijfN+LqQic
 Ktn1FEBBSxQgyWq1IWdlDB3A==

I just noticed (via a bisect between v6.11 and v6.12-rc1) that this patch=20
(commit f8d112a4e657 in linux-next tree) leads to a severe memory corruptio=
n=20
error under these (rather rare) circumstances:
1. Start a 32bit windows game via steam (which uses proton, steam's version=
 of wine)
2. When starting the game you the proton version used has to be updated

The effect is the following: The updating process of proton hangs and the g=
ame does
not start and even after an exit from steam two processes remain, one of th=
em at=20
100% CPU:
$ ps aux | grep rundll
bert      222638  1.7  0.1 2054868 87492 ?       Ss   23:14   0:01 C:\windo=
ws\syswow64\rundll32.exe setupapi,InstallHinfSection Wow64Install 128 \\?\Z=
:\mnt\data\.steam\debian-installation\steamapps\common\Proton - Experimenta=
l\files\share\wine\wine.inf
bert      222639 99.8  0.0 2054868 2380 ?        R    23:14   1:01 C:\windo=
ws\syswow64\rundll32.exe setupapi,InstallHinfSection Wow64Install 128 \\?\Z=
:\mnt\data\.steam\debian-installation\steamapps\common\Proton - Experimenta=
l\files\share\wine\wine.inf

When trying to kill those processes with "killall rundll32.exe", these erro=
r happen:

[ T4313] ------------[ cut here ]------------
[ T4313] WARNING: CPU: 6 PID: 4313 at include/linux/rwsem.h:85 free_pgtable=
s+0x233/0x250
[ T4313] Modules linked in: ccm snd_seq_dummy snd_hrtimer snd_seq_midi snd_=
seq_midi_event snd_rawmidi snd_seq snd_seq_device rfcomm bnep nls_ascii nls=
_cp437 vfat fat snd_ctl_led snd_hda_codec_realtek snd_hda_codec_generic snd=
_hda_scodec_component snd_hda_codec_hdmi snd_hda_intel btusb snd_intel_dspc=
fg btrtl snd_hda_codec btintel uvcvideo btbcm btmtk snd_acp3x_pdm_dma snd_s=
oc_dmic snd_acp3x_rn videobuf2_vmalloc snd_hwdep uvc videobuf2_memops bluet=
ooth snd_soc_core snd_hda_core videobuf2_v4l2 snd_pcm_oss videodev snd_mixe=
r_oss snd_pcm snd_rn_pci_acp3x videobuf2_common snd_acp_config snd_timer ms=
i_wmi snd_soc_acpi ecdh_generic amd_atl ecc mc sparse_keymap edac_mce_amd s=
nd wmi_bmof ccp soundcore snd_pci_acp3x k10temp ac battery button hid_senso=
r_prox hid_sensor_gyro_3d hid_sensor_accel_3d hid_sensor_magn_3d hid_sensor=
_als hid_sensor_trigger industrialio_triggered_buffer kfifo_buf industriali=
o hid_sensor_iio_common joydev amd_pmc evdev serio_raw mt7921e mt7921_commo=
n mt792x_lib mt76_connac_lib mt76 mac80211 libarc4
[ T4313]  cfg80211 rfkill msr fuse nvme_fabrics efi_pstore configfs efivarf=
s autofs4 ext4 crc32c_generic mbcache jbd2 usbhid amdgpu amdxcp i2c_algo_bi=
t drm_ttm_helper ttm drm_exec gpu_sched xhci_pci hid_sensor_hub drm_suballo=
c_helper xhci_hcd nvme i2c_piix4 drm_buddy mfd_core hid_multitouch hid_gene=
ric crc32c_intel psmouse usbcore drm_display_helper i2c_hid_acpi i2c_smbus =
amd_sfh usb_common i2c_hid nvme_core crc16 r8169 hid i2c_designware_platfor=
m i2c_designware_core
[ T4313] CPU: 6 UID: 1000 PID: 4313 Comm: rundll32.exe Not tainted 6.11.0-r=
c6-bisect-00259-gf8d112a4e657 #539
[ T4313] Hardware name: Micro-Star International Co., Ltd. Alpha 15 B5EEK/M=
S-158L, BIOS E158LAMS.107 11/10/2021
[ T4313] RIP: 0010:free_pgtables+0x233/0x250
[ T4313] Code: f3 5d 02 00 49 8b 57 08 e9 74 fe ff ff 48 8b 53 10 31 ed 48 =
8b 8a a8 00 00 00 83 e1 01 0f 85 51 ff ff ff 0f 0b e9 4a ff ff ff <0f> 0b e=
9 80 fe ff ff 4c 89 f7 4c 89 fb e8 bb 5d 02 00 e9 7b ff ff
[ T4313] RSP: 0018:ffffb21c0775bbe0 EFLAGS: 00010246
[ T4313] RAX: ffffa02298d5f8c0 RBX: ffffa023b115b780 RCX: 0000000000000000
[ T4313] RDX: ffffa022be442200 RSI: ffffa02290460d00 RDI: ffffa023b115b780
[ T4313] RBP: ffffa025b102ab40 R08: 0000000000000001 R09: 0000000000000008
[ T4313] R10: ffffa02284b42500 R11: 0000000000000000 R12: 0000000000000001
[ T4313] R13: ffffffffffffffff R14: ffffb21c0775bc08 R15: ffffa025b102ab40
[ T4313] FS:  0000000000000000(0000) GS:ffffa0312e780000(0000) knlGS:000000=
0000000000
[ T4313] CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
[ T4313] CR2: 00007f326de7e328 CR3: 0000000202832000 CR4: 0000000000750ef0
[ T4313] PKRU: 55555554
[ T4313] Call Trace:
[ T4313]  <TASK>
[ T4313]  ? __warn+0x83/0xb5
[ T4313]  ? free_pgtables+0x233/0x250
[ T4313]  ? report_bug+0xfa/0x140
[ T4313]  ? handle_bug+0x3a/0x70
[ T4313]  ? exc_invalid_op+0x17/0x70
[ T4313]  ? asm_exc_invalid_op+0x1a/0x20
[ T4313]  ? free_pgtables+0x233/0x250
[ T4313]  exit_mmap+0x14d/0x2a0
[ T4313]  mmput+0x3e/0xf0
[ T4313]  do_exit+0x283/0x9b0
[ T4313]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T4313]  do_group_exit+0x2b/0x80
[ T4313]  get_signal+0x78d/0x7d0
[ T4313]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T4313]  ? __do_wait+0x13d/0x250
[ T4313]  arch_do_signal_or_restart+0x29/0x230
[ T4313]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T4313]  ? kernel_wait4+0xa7/0x140
[ T4313]  syscall_exit_to_user_mode+0x154/0x1a0
[ T4313]  do_int80_emulation+0x94/0x140
[ T4313]  asm_int80_emulation+0x1a/0x20
[ T4313] RIP: 0023:0xf7ef9bc2
[ T4313] Code: Unable to access opcode bytes at 0xf7ef9b98.
[ T4313] RSP: 002b:000000000050f9ec EFLAGS: 00000246 ORIG_RAX: 000000000000=
0072
[ T4313] RAX: fffffffffffffe00 RBX: 00000000000010da RCX: 0000000000000000
[ T4313] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
[ T4313] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
[ T4313] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
[ T4313] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[ T4313]  </TASK>
[ T4313] ---[ end trace 0000000000000000 ]---
[ T4313] BUG: kernel NULL pointer dereference, address: 0000000000000000
[ T4313] #PF: supervisor write access in kernel mode
[ T4313] #PF: error_code(0x0002) - not-present page
[ T4313] PGD 0 P4D 0=20
[ T4313] Oops: Oops: 0002 [#1] PREEMPT SMP NOPTI
[ T4313] CPU: 6 UID: 1000 PID: 4313 Comm: rundll32.exe Tainted: G        W =
         6.11.0-rc6-bisect-00259-gf8d112a4e657 #539
[ T4313] Tainted: [W]=3DWARN
[ T4313] Hardware name: Micro-Star International Co., Ltd. Alpha 15 B5EEK/M=
S-158L, BIOS E158LAMS.107 11/10/2021
[ T4313] RIP: 0010:__rb_erase_color+0x19e/0x260
[ T4313] Code: 48 89 ee 48 89 df 4c 89 e5 2e e8 ed 16 06 00 e9 a2 fe ff ff =
48 89 68 10 eb e6 4c 8b 65 08 48 8d 43 01 4c 89 63 10 48 89 5d 08 <49> 89 0=
4 24 48 8b 03 48 89 45 00 48 89 2b 48 83 f8 03 76 27 48 83
[ T4313] RSP: 0018:ffffb21c0775bb78 EFLAGS: 00010246
[ T4313] RAX: ffffa0228380ef39 RBX: ffffa0228380ef38 RCX: 00000000000000fb
[ T4313] RDX: 0000000000000000 RSI: ffffa02352021d80 RDI: ffffa0228380ef38
[ T4313] RBP: ffffa0228380e678 R08: 00000000000000fc R09: 0000000000000001
[ T4313] R10: 0000000000400035 R11: 0000000000000000 R12: 0000000000000000
[ T4313] R13: ffffffff83c46b90 R14: ffffa02352021d80 R15: ffffb21c0775bc08
[ T4313] FS:  0000000000000000(0000) GS:ffffa0312e780000(0000) knlGS:000000=
0000000000
[ T4313] CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
[ T4313] CR2: 0000000000000000 CR3: 0000000202832000 CR4: 0000000000750ef0
[ T4313] PKRU: 55555554
[ T4313] Call Trace:
[ T4313]  <TASK>
[ T4313]  ? __die+0x51/0x92
[ T4313]  ? page_fault_oops+0x99/0x210
[ T4313]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T4313]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T4313]  ? vprintk_emit+0xc1/0x270
[ T4313]  ? exc_page_fault+0x35e/0x660
[ T4313]  ? asm_exc_page_fault+0x26/0x30
[ T4313]  ? __pfx_vma_interval_tree_augment_rotate+0x10/0x10
[ T4313]  ? __rb_erase_color+0x19e/0x260
[ T4313]  ? __rb_erase_color+0x183/0x260
[ T4313]  unlink_file_vma_batch_add+0x8a/0xc0
[ T4313]  free_pgtables+0x124/0x250
[ T4313]  exit_mmap+0x14d/0x2a0
[ T4313]  mmput+0x3e/0xf0
[ T4313]  do_exit+0x283/0x9b0
[ T4313]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T4313]  do_group_exit+0x2b/0x80
[ T4313]  get_signal+0x78d/0x7d0
[ T4313]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T4313]  ? __do_wait+0x13d/0x250
[ T4313]  arch_do_signal_or_restart+0x29/0x230
[ T4313]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T4313]  ? kernel_wait4+0xa7/0x140
[ T4313]  syscall_exit_to_user_mode+0x154/0x1a0
[ T4313]  do_int80_emulation+0x94/0x140
[ T4313]  asm_int80_emulation+0x1a/0x20
[ T4313] RIP: 0023:0xf7ef9bc2
[ T4313] Code: Unable to access opcode bytes at 0xf7ef9b98.
[ T4313] RSP: 002b:000000000050f9ec EFLAGS: 00000246 ORIG_RAX: 000000000000=
0072
[ T4313] RAX: fffffffffffffe00 RBX: 00000000000010da RCX: 0000000000000000
[ T4313] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
[ T4313] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
[ T4313] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
[ T4313] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[ T4313]  </TASK>
[ T4313] Modules linked in: ccm snd_seq_dummy snd_hrtimer snd_seq_midi snd_=
seq_midi_event snd_rawmidi snd_seq snd_seq_device rfcomm bnep nls_ascii nls=
_cp437 vfat fat snd_ctl_led snd_hda_codec_realtek snd_hda_codec_generic snd=
_hda_scodec_component snd_hda_codec_hdmi snd_hda_intel btusb snd_intel_dspc=
fg btrtl snd_hda_codec btintel uvcvideo btbcm btmtk snd_acp3x_pdm_dma snd_s=
oc_dmic snd_acp3x_rn videobuf2_vmalloc snd_hwdep uvc videobuf2_memops bluet=
ooth snd_soc_core snd_hda_core videobuf2_v4l2 snd_pcm_oss videodev snd_mixe=
r_oss snd_pcm snd_rn_pci_acp3x videobuf2_common snd_acp_config snd_timer ms=
i_wmi snd_soc_acpi ecdh_generic amd_atl ecc mc sparse_keymap edac_mce_amd s=
nd wmi_bmof ccp soundcore snd_pci_acp3x k10temp ac battery button hid_senso=
r_prox hid_sensor_gyro_3d hid_sensor_accel_3d hid_sensor_magn_3d hid_sensor=
_als hid_sensor_trigger industrialio_triggered_buffer kfifo_buf industriali=
o hid_sensor_iio_common joydev amd_pmc evdev serio_raw mt7921e mt7921_commo=
n mt792x_lib mt76_connac_lib mt76 mac80211 libarc4
[ T4313]  cfg80211 rfkill msr fuse nvme_fabrics efi_pstore configfs efivarf=
s autofs4 ext4 crc32c_generic mbcache jbd2 usbhid amdgpu amdxcp i2c_algo_bi=
t drm_ttm_helper ttm drm_exec gpu_sched xhci_pci hid_sensor_hub drm_suballo=
c_helper xhci_hcd nvme i2c_piix4 drm_buddy mfd_core hid_multitouch hid_gene=
ric crc32c_intel psmouse usbcore drm_display_helper i2c_hid_acpi i2c_smbus =
amd_sfh usb_common i2c_hid nvme_core crc16 r8169 hid i2c_designware_platfor=
m i2c_designware_core
[ T4313] CR2: 0000000000000000
[ T4313] ---[ end trace 0000000000000000 ]---
[ T4313] RIP: 0010:__rb_erase_color+0x19e/0x260
[ T4313] Code: 48 89 ee 48 89 df 4c 89 e5 2e e8 ed 16 06 00 e9 a2 fe ff ff =
48 89 68 10 eb e6 4c 8b 65 08 48 8d 43 01 4c 89 63 10 48 89 5d 08 <49> 89 0=
4 24 48 8b 03 48 89 45 00 48 89 2b 48 83 f8 03 76 27 48 83
[ T4313] RSP: 0018:ffffb21c0775bb78 EFLAGS: 00010246
[ T4313] RAX: ffffa0228380ef39 RBX: ffffa0228380ef38 RCX: 00000000000000fb
[ T4313] RDX: 0000000000000000 RSI: ffffa02352021d80 RDI: ffffa0228380ef38
[ T4313] RBP: ffffa0228380e678 R08: 00000000000000fc R09: 0000000000000001
[ T4313] R10: 0000000000400035 R11: 0000000000000000 R12: 0000000000000000
[ T4313] R13: ffffffff83c46b90 R14: ffffa02352021d80 R15: ffffb21c0775bc08
[ T4313] FS:  0000000000000000(0000) GS:ffffa0312e780000(0000) knlGS:000000=
0000000000
[ T4313] CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
[ T4313] CR2: 0000000000000000 CR3: 000000043109c000 CR4: 0000000000750ef0
[ T4313] PKRU: 55555554
[ T4313] note: rundll32.exe[4313] exited with irqs disabled
[ T4313] Fixing recursive fault but reboot is needed!
[ T4313] BUG: scheduling while atomic: rundll32.exe/4313/0x00000000
[ T4313] Modules linked in: ccm snd_seq_dummy snd_hrtimer snd_seq_midi snd_=
seq_midi_event snd_rawmidi snd_seq snd_seq_device rfcomm bnep nls_ascii nls=
_cp437 vfat fat snd_ctl_led snd_hda_codec_realtek snd_hda_codec_generic snd=
_hda_scodec_component snd_hda_codec_hdmi snd_hda_intel btusb snd_intel_dspc=
fg btrtl snd_hda_codec btintel uvcvideo btbcm btmtk snd_acp3x_pdm_dma snd_s=
oc_dmic snd_acp3x_rn videobuf2_vmalloc snd_hwdep uvc videobuf2_memops bluet=
ooth snd_soc_core snd_hda_core videobuf2_v4l2 snd_pcm_oss videodev snd_mixe=
r_oss snd_pcm snd_rn_pci_acp3x videobuf2_common snd_acp_config snd_timer ms=
i_wmi snd_soc_acpi ecdh_generic amd_atl ecc mc sparse_keymap edac_mce_amd s=
nd wmi_bmof ccp soundcore snd_pci_acp3x k10temp ac battery button hid_senso=
r_prox hid_sensor_gyro_3d hid_sensor_accel_3d hid_sensor_magn_3d hid_sensor=
_als hid_sensor_trigger industrialio_triggered_buffer kfifo_buf industriali=
o hid_sensor_iio_common joydev amd_pmc evdev serio_raw mt7921e mt7921_commo=
n mt792x_lib mt76_connac_lib mt76 mac80211 libarc4
[ T4313]  cfg80211 rfkill msr fuse nvme_fabrics efi_pstore configfs efivarf=
s autofs4 ext4 crc32c_generic mbcache jbd2 usbhid amdgpu amdxcp i2c_algo_bi=
t drm_ttm_helper ttm drm_exec gpu_sched xhci_pci hid_sensor_hub drm_suballo=
c_helper xhci_hcd nvme i2c_piix4 drm_buddy mfd_core hid_multitouch hid_gene=
ric crc32c_intel psmouse usbcore drm_display_helper i2c_hid_acpi i2c_smbus =
amd_sfh usb_common i2c_hid nvme_core crc16 r8169 hid i2c_designware_platfor=
m i2c_designware_core
[ T4313] CPU: 3 UID: 1000 PID: 4313 Comm: rundll32.exe Tainted: G      D W =
         6.11.0-rc6-bisect-00259-gf8d112a4e657 #539
[ T4313] Tainted: [D]=3DDIE, [W]=3DWARN
[ T4313] Hardware name: Micro-Star International Co., Ltd. Alpha 15 B5EEK/M=
S-158L, BIOS E158LAMS.107 11/10/2021
[ T4313] Call Trace:
[ T4313]  <TASK>
[ T4313]  dump_stack_lvl+0x58/0x90
[ T4313]  __schedule_bug.cold+0x3e/0x4a
[ T4313]  __schedule+0xed3/0x12d0
[ T4313]  ? irq_work_queue+0x2d/0x50
[ T4313]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T4313]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T4313]  ? vprintk_emit+0xc1/0x270
[ T4313]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T4313]  ? _printk+0x57/0x72
[ T4313]  do_task_dead+0x3d/0x40
[ T4313]  make_task_dead.cold+0xcc/0xd8
[ T4313]  rewind_stack_and_make_dead+0x16/0x20
[ T4313] RIP: 0023:0xf7ef9bc2
[ T4313] Code: Unable to access opcode bytes at 0xf7ef9b98.
[ T4313] RSP: 002b:000000000050f9ec EFLAGS: 00000246 ORIG_RAX: 000000000000=
0072
[ T4313] RAX: fffffffffffffe00 RBX: 00000000000010da RCX: 0000000000000000
[ T4313] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
[ T4313] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
[ T4313] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
[ T4313] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[ T4313]  </TASK>

After that sometimes a kernel panic happen sometimes trying to reboot is st=
ill
possible but even then the reboot fails due to the mentioned processes bein=
g=20
unkillable.

Bert Karwatzki




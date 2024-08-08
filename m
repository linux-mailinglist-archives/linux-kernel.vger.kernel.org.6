Return-Path: <linux-kernel+bounces-278781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD0DC94B4C9
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 03:58:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64C9B1F22597
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 01:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88B05BE4A;
	Thu,  8 Aug 2024 01:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="nIBoCcBU"
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89AF5BA2D
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 01:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723082328; cv=none; b=UAB5OBdQQIaRhihpsRhvmgd4FIIOU2u57PmH9x2jRDovQ1kjEiJHt22lT2PKer4cjwGL3c36NBS688Uc0VY3QsODipSMmUPrKuLw6PjLvGG8HlQWbX29mkjmYIJYGtrUUx/uUtkCyf2Jkh5erD8uG0QX6YGI4hJE+UAHFehl+Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723082328; c=relaxed/simple;
	bh=tHXpH4QaZmTOC3bI9hA4JX0lEVc04K8k7qOHKgALQTo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O4E1iKbJvksJ1lu3sFljrMcsu9Po9PUcQ55MlARg/2N+NtxnaI1Mn2R1M1JJkpWa8qPgc/DkqXbz1i5q5JgULHBV0x1TcxKdfBxuk6otAWjBgZZSqjowqIvwWHxMGoB5P8h+jDPmvl1hXg9SoUOwR55oKyAD2ZVf99ebMpNFvMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=nIBoCcBU; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1723082278; x=1723687078; i=spasswolf@web.de;
	bh=CkDZjUhGkBJvTmhgaBQ3ZNpFy8rTzxw2NML9rUxG5pY=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=nIBoCcBU3St3KVA9OY0EEyip3DtKb9wkhFl2XRdtdOxXw2zPkQYQ52Q2I7NyaJz3
	 3FV5MDp1U4nBACsjEsqbw1GEDNA3m9OzJFQIS0gK08msagVngBRg2N9/Zl03mstut
	 Q1GuQsu/b82bfNGLGGG7eVR8zj9pceqwG1/q2NAlrok7UBPj+ZWGxFoA4MvVkxlQR
	 V8QtbBiAASeQ9Ca4cz/8jCWvj7M5J598/ld8E89kyCzTONYnex18CYYfEvoOmOuFq
	 n41+XLtn+eT/2gn/g1z8XHxiH2gXwxXCg1m4Uh3iMTYr1Y8CN6BafYTKYTdzKxxXG
	 c06QGW0ZzZNNxgNBpg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost.localdomain ([84.119.92.193]) by smtp.web.de
 (mrweb006 [213.165.67.108]) with ESMTPSA (Nemesis) id
 1MwR05-1sJelv0zO1-00tfQo; Thu, 08 Aug 2024 03:57:58 +0200
From: Bert Karwatzki <spasswolf@web.de>
To: mingo@kernel.org
Cc: Bert Karwatzki <spasswolf@web.de>,
	akpm@linux-foundation.org,
	Oleg Nesterov <oleg@redhat.com>,
	Andy Lutomirski <luto@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Fenghua Yu <fenghua.yu@intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Uros Bizjak <ubizjak@gmail.com>,
	linux-kernel@vger.kernel.org,
	peterz@infradead.org
Subject: commit 81106b7e0b13 can break asm_int80_emulation on x86_64
Date: Thu,  8 Aug 2024 03:57:50 +0200
Message-ID: <20240808015752.65088-1-spasswolf@web.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: 20240605083557.2051480-2-mingo@kernel.org
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vorSSJBgJ+MWiNnk7sBzlGFrwiy6RvoCMwOVBJOtSeBsjqFsbHS
 xb2S+4TsJatGuvmUaEH3J6pjX/kuMko4y+mZekTrIMbC1cCyHrSBEZA9fS9/QlrXiNPbNMy
 7D4uL8+rwGDDDPiculPA04F++A2zeCp6beGlUeFmKpXbihKOSt/Q5V8ODo2zzH6zR898uy6
 mTZpYg1cq8XBwzYJyAWwg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:oPZUkGHfjD4=;xhPAqNVF+gyVuVmJPmIXc2VGpPI
 fgJ1BGPtKdJvj94kIOVGAZkp9jI57CI7pfQvgtQpsMEJf+k24Ocy/SJu4VM14fG9TQLPRz8wt
 9igPYQlogr/ZxApC44vDbh5mpjm+I5qtOx/ozilYytvsyvKZFfYO5Ij7VTxArLG+pwZiqSyQX
 c91VQYBaNJ7Msq7fFVwgbtDp72I/ZcM3Pov4UdmdEgn5HNLJVsXI4BJRqUejiOjpkgQBpaziy
 5OzCFEcLGC7p3tXGYRBiLKKpRoTJY457n+XN8kEYy/3QV19js4eeJ/uKGCxLZ+M4maflMwwJg
 kroMVIMEIorgC8VoiBluS+oLvLD8j3jQH0yMJVNvU3prWRUKUhki0WRatSRFAK97iDxzptnbG
 Jtj73vyJgbpg3bKxk7W/8X0w9Xuzm13kI043IKWvR4H4GJTTzL7EyI++yNaEgd7nMmmSIt9YT
 wxSlVLZiJZlTCw2gTIcx7NAyHc2iskDNSvLbPtFfdguxwyzfzcfLc+yryjS7vBhEcoeZyLY88
 hA6jqSGSx1yIwfnoWgTZwqN1OFl+gPOSpccr407/n9sk4UwXLKZvIaN3eEdbl8K7Py9nPOdyw
 iIV8vf9PaMWIbW/APC9FMMaSP5lqzzjdPBO5/cRXoldgYbizjDh4SeCG/bYzO71MuQWe2fQ0f
 XFl7n4G4uUyoyf6Nl5UfuYgQo8+N9PSPbe3IX07CHFKXN3A02Lp1BzjRZdElwfHIe68dUHHzf
 dtsRYc1X+2JN48AHOHXkFXs8uNNybnj4EEp97POVAujT14T30VPY+rrNDboU0WUUm5adSCsoZ
 +H6XTyTGtTJ+/G+IZTiTbmUg==

Since linux-next-20240730 and in versions next-202408{05,06} the  error bel=
ow
can appear when trying to start a game using wine. The error does not always
appear but after some failed attempts at bisecting this I found a way to
reliably trigger this by first creating high system load (by compiling a ke=
rnel
with make -j 16) and then trying to start the game until the error occurs. =
If the
error does not occur during the time it take to compile the kernel (about ~=
6.5min)
I declared the commit as good. Usually the bad commit did not take more than
three attempts of starting wine to trigger the error.
With this I bisected the problem to commit 81106b7e0b13.

To revert this commit in next-20240806 the following commits have to be rev=
erted:
(HEAD -> wine_usercopy_bug) Revert "x86/fpu: Make task_struct::thread const=
ant size"=20
Revert "x86/fpu: Remove the thread::fpu pointer"
Revert "x86/fpu: Remove init_task FPU state dependencies, add debugging war=
ning for PF_KTHREAD tasks"
Revert "x86/CPU/AMD: Always inline amd_clear_divider()"

After reverting these commit the next-20240806 seems to be free from the er=
ror.
The machine used is an Ryzen 5800H (Msi Alpha15 Laptop) running a fully upd=
ated
(as of 20240807) debian sid.

Bert Karwatzki

Error message:
[T34926] usercopy: Kernel memory overwrite attempt detected to SLUB object =
'task_struct' (offset 3072, size 160)!
[T34926] ------------[ cut here ]------------
[T34926] kernel BUG at mm/usercopy.c:102!
[T34926] Oops: invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
[T34926] CPU: 12 UID: 1000 PID: 34926 Comm: start.exe Not tainted 6.11.0-rc=
2-next-20240806-master-dirty #178
[T34926] Hardware name: Micro-Star International Co., Ltd. Alpha 15 B5EEK/M=
S-158L, BIOS E158LAMS.107 11/10/2021
[T34926] RIP: 0010:usercopy_abort+0x73/0x75
[T34926] Code: e0 f2 06 86 eb 0e 48 c7 c2 81 6b 08 86 48 c7 c7 e9 f2 06 86 =
56 48 89 fe 48 c7 c7 d8 47 0c 86 51 48 89 c1 41 52 e8 6d 70 ff ff <0f> 0b 4=
8 89 d9 49 89 e8 44 89 e2 31 f6 48 81 e9 00 00 20 85 48 c7
[T34926] RSP: 0000:ffffa58a47e73cd0 EFLAGS: 00010246
[T34926] RAX: 0000000000000068 RBX: ffff8e1eec1a4a00 RCX: 0000000000000000
[T34926] RDX: 0000000000000000 RSI: ffff8e2cae9177c0 RDI: ffff8e2cae9177c0
[T34926] RBP: 00000000000000a0 R08: 0000000000000000 R09: ffffa58a47e73b78
[T34926] R10: ffffffff8627fe88 R11: 0000000000000003 R12: 0000000000000000
[T34926] R13: ffff8e1eec1a4aa0 R14: ffff8e1eec1a4a00 R15: 0000000000000001
[T34926] FS:  000000003ffe2000(006b) GS:ffff8e2cae900000(0063) knlGS:000000=
00f7ed20c0
[T34926] CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
[T34926] CR2: 000000003ffed324 CR3: 00000002a58da000 CR4: 0000000000750ef0
[T34926] PKRU: 55555554
[T34926] Call Trace:
[T34926]  <TASK>
[T34926]  ? __die+0x51/0x92
[T34926]  ? die+0x29/0x50
[T34926]  ? do_trap+0x105/0x110
[T34926]  ? do_error_trap+0x60/0x80
[T34926]  ? usercopy_abort+0x73/0x75
[T34926]  ? exc_invalid_op+0x4d/0x70
[T34926]  ? usercopy_abort+0x73/0x75
[T34926]  ? asm_exc_invalid_op+0x1a/0x20
[T34926]  ? usercopy_abort+0x73/0x75
[T34926]  ? __check_heap_object+0x7d/0xa0
[T34926]  ? __check_object_size+0x1f9/0x210
[T34926]  ? copy_from_buffer+0x40/0x60
[T34926]  ? copy_uabi_to_xstate+0xe1/0x1e0
[T34926]  ? __fpu_restore_sig+0x403/0x480
[T34926]  ? fpu__restore_sig+0x4c/0x90
[T34926]  ? ia32_restore_sigcontext+0x129/0x170
[T34926]  ? __do_compat_sys_rt_sigreturn+0x68/0xc0
[T34926]  ? do_int80_emulation+0x88/0x140
[T34926]  ? asm_int80_emulation+0x1a/0x20
[T34926]  </TASK>
[T34926] Modules linked in: ccm snd_seq_dummy snd_hrtimer snd_seq_midi snd_=
seq_midi_event snd_rawmidi snd_seq snd_seq_device rfcomm bnep nls_ascii nls=
_cp437 vfat fat snd_ctl_led snd_hda_codec_realtek snd_hda_codec_generic snd=
_hda_scodec_component snd_hda_codec_hdmi btusb btrtl btintel snd_hda_intel =
btbcm btmtk snd_intel_dspcfg snd_acp3x_pdm_dma snd_soc_dmic snd_acp3x_rn uv=
cvideo bluetooth snd_hda_codec videobuf2_vmalloc snd_soc_core uvc snd_hwdep=
 videobuf2_memops videobuf2_v4l2 snd_hda_core snd_pcm_oss videodev snd_mixe=
r_oss snd_pcm snd_rn_pci_acp3x videobuf2_common snd_acp_config msi_wmi snd_=
soc_acpi ecdh_generic amd_atl ecc mc sparse_keymap edac_mce_amd wmi_bmof sn=
d_timer snd ccp snd_pci_acp3x k10temp soundcore battery ac joydev button hi=
d_sensor_accel_3d hid_sensor_prox hid_sensor_als hid_sensor_magn_3d hid_sen=
sor_gyro_3d hid_sensor_trigger industrialio_triggered_buffer kfifo_buf indu=
strialio amd_pmc hid_sensor_iio_common evdev hid_multitouch serio_raw mt792=
1e mt7921_common mt792x_lib mt76_connac_lib mt76
[T34926]  mac80211 libarc4 cfg80211 rfkill msr fuse nvme_fabrics efi_pstore=
 configfs efivarfs autofs4 ext4 crc32c_generic mbcache jbd2 usbhid amdgpu i=
2c_algo_bit drm_ttm_helper xhci_pci ttm drm_exec drm_suballoc_helper xhci_h=
cd amdxcp drm_buddy hid_sensor_hub usbcore mfd_core nvme gpu_sched i2c_piix=
4 hid_generic crc32c_intel psmouse drm_display_helper amd_sfh usb_common i2=
c_smbus nvme_core crc16 r8169 i2c_hid_acpi i2c_hid hid i2c_designware_platf=
orm i2c_designware_core
[T34926] ---[ end trace 0000000000000000 ]---




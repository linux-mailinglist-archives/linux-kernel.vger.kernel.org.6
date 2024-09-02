Return-Path: <linux-kernel+bounces-311423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC8749688F7
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 15:35:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 743B9284452
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 13:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D59B720127E;
	Mon,  2 Sep 2024 13:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="CGSDNvnH"
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388BF200118
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 13:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725284109; cv=none; b=OG4HWtFq7ov6hl0yV/Ra293O2d2jFaQUYts1pnQkRTba7nSTWxGr9vmMQnRyiwZG4+u4nFR/0CdCPgOQJTqHzcpQOK1EYUTtc+C5TFgO4FW8I1NZ4hC+cfbNULPEaCnD7Xp1Cf2rbjRJvqexNxts+LoEDmf4fR7A43R3BWNCf78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725284109; c=relaxed/simple;
	bh=Tv6Z72ugnm3O993wJJoR+tmrIo5kUTFWn7kR5yAj+GM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hfWeS4Ljsg4Uo+9gNgPVIN6CyHBW2csg5+wKkxp+1kPJe5YMrpfOeyDgYjQhp8bRvdGe8sQlA/tGCux6WfCYsPFVH7IUUV5y2NpgH3VIjngLOC2I6g0Uqqjwt32xHyR2u7yZH9psa65KQ8eym+MnMCG4AX4J2Lz7BT08RPJvrYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=CGSDNvnH; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1725284090; x=1725888890; i=spasswolf@web.de;
	bh=Xot7YJnSYkkddvL42DIZVUdezEoOFifH9s6Z2vcI8ek=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=CGSDNvnHns+77MCmVuraB0aZXoGEmRxHW9f1C12J3x+lVa8VY4R5IrJ/CT822arU
	 sZb0CkeVD0Ei/4F3eFkXpRz8QEhqPnBetbuMX8AkfFCYymRLnqGOyku+IqZ852GzG
	 bE5kSRhmlZXA+1G1wU5Z/vHAE0Kg3b3mZfX1ugbBtOWqz9I3p5juri6JWlonUiFWk
	 aALBf5qEcBFa1oI0uMOLreNhW/5YfisLiEAZ+GwxEVSoLhtsaxTirHvSvR831bre1
	 HmwI3SdFUo9GREy9loKSwXthJ77fVc3QUwhEBmBXRq1z1nvsB7/rms7yzx9VBNxs9
	 sYViu+fvz7NBysmpwg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost.localdomain ([84.119.92.193]) by smtp.web.de
 (mrweb105 [213.165.67.124]) with ESMTPSA (Nemesis) id
 1MDv9a-1ssmAY1Bzw-00GOpX; Mon, 02 Sep 2024 15:34:50 +0200
From: Bert Karwatzki <spasswolf@web.de>
To: yangyun <yangyun50@huawei.com>
Cc: Bert Karwatzki <spasswolf@web.de>,
	linux-kernel@vger.kernel.org,
	Miklos Szeredi <mszeredi@redhat.com>
Subject: commit 5fb9c98e9d8d causes deadlock
Date: Mon,  2 Sep 2024 15:34:46 +0200
Message-ID: <20240902133447.2853-1-spasswolf@web.de>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:u2UK7Nwq6ICN7vNlvQEdWA8A61Q0/wFiQL8FxyDqhBqwgzAzzgr
 kQ8Nz/lg2aieDxyoYmFulzIjazDvY0VHfH+dCOGbpYlwgTuzfNqCdXQZLCnwcosGM2Ry7kU
 O3ei+nZJuDn8fpCbvAdGTOXhaQGj6IUf2NOJ4ZKKGh8a1eYdWhuOIWprrX+HCFPGfKY2b0X
 J/cWl8z/l3i7lI2YMw/9A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:d3BDyy5YWoA=;mLhPNakQvWw/v2jTzZu+BTijGeu
 dl0jdJ0cQGFhpdbYwrt14w2RyA5jF0r7LXISC1Tfc/F81ARqwrAOJ/8CMuf27IBQ10HGSZOwA
 DNLTsDbCU+xWHmCqskz1TuUv57LCQqJgQLKJP0QuOMN/vA0J9fRY6OGQcIgg3SSlCjbxnEOz9
 AW5x/WiB74dbjmJcYiilAjoG2nIepCJmySC3c0uMoVCe9HD15Ua5LR5ylSGGC5Zq7ZXHx1c10
 sbZJePN0tiu4GwNvKDD55BV5yjOeVwKb6gt9GbGc2Mb3eLsMFBjlWFV82z0lN+SB30QdbSzGW
 Is8Nd+70kbpbkdi0at/bBj2rsLFN6jGe7d1rIbozhl5SBUf9i6wW62kGJxPuZ+dyKsdQzeM+H
 jKVumWEyycFmMy7614sFIgeKj6nTnIggQJLnntlPo5nzOhOs1SLPRGaN6OuHPBT1cudglV5xI
 W8ts2YJz2LypjQCnyRE2CWbMFcGfDvG/Qou6EMSi+dVYfYHriqKm9hZ5Q99oRz3NP8Gy9jOv/
 biphge4nIRsZsfO1XarpCqNlQ1zsihqW8dGY4WXcmx5VqP4NMruEh2pvgGSTyOONAe1ho2bm4
 B6eOxTlZEqoQk+ZwKT3RCADWtGfF7BSdLTDteik9MYmEtcDB0I1KwE9vIdHvcUr6iORa0F57H
 a1uF3RePGT3ot9FERgQOVJjCDLqz9B5nIHt16UscduhJyJaxZ2Cckf3X8midtuLau5XXL4+i7
 YbSSj5W1iroGAnHc4Rlgh6j/fkhGd5qs1ckL9qKxwVKq9VqHCcnm4n8TWrNHV+EF+rS3TLbFr
 sB36c/DjdezSsgYPfzqOdHEg==

Since linux next-20240902 starting debian sid on my MSI Alpha 15 Laptop han=
gs
before the GUI is enabled. After rebooting into a working kernel (v6.11-rc6)
the following messages can be found in /var/log/kern.log:

2024-09-02T11:15:06.501185+02:00 lisa kernel: [    C4] rcu: INFO: rcu_preem=
pt self-detected stall on CPU
2024-09-02T11:15:06.501190+02:00 lisa kernel: [    C4] rcu: 	4-....: (20994=
 ticks this GP) idle=3D2214/1/0x4000000000000000 softirq=3D968/968 fqs=3D45=
61
2024-09-02T11:15:06.501192+02:00 lisa kernel: [    C4] rcu: 	(t=3D21001 jif=
fies g=3D993 q=3D8719 ncpus=3D16)
2024-09-02T11:15:06.501193+02:00 lisa kernel: [    C4] CPU: 4 UID: 0 PID: 1=
282 Comm: fusermount3 Not tainted 6.11.0-rc6-next-20240902-master #366
2024-09-02T11:15:06.501196+02:00 lisa kernel: [    C4] Hardware name: Micro=
-Star International Co., Ltd. Alpha 15 B5EEK/MS-158L, BIOS E158LAMS.107 11/=
10/2021
2024-09-02T11:15:06.501198+02:00 lisa kernel: [    C4] RIP: 0010:queued_spi=
n_lock_slowpath+0x43/0x1b0
2024-09-02T11:15:06.501201+02:00 lisa kernel: [    C4] Code: ba 2a 08 0f 92=
 c1 8b 02 0f b6 c9 c1 e1 08 30 e4 09 c8 3d ff 00 00 00 0f 87 e9 00 00 00 85=
 c0 74 10 0f b6 02 84 c0 74 09 f3 90 <0f> b6 02 84 c0 75 f7 b8 01 00 00 00 =
66 89 02 e9 54 dd 1d 00 8b 37
2024-09-02T11:15:06.501203+02:00 lisa kernel: [    C4] RSP: 0018:ffffb64a45=
267d08 EFLAGS: 00000202
2024-09-02T11:15:06.501206+02:00 lisa kernel: [    C4] RAX: 000000000000000=
1 RBX: ffff9f0cd1187a38 RCX: 0000000000000000
2024-09-02T11:15:06.501208+02:00 lisa kernel: [    C4] RDX: ffff9f0cd1187a3=
8 RSI: 0000000000000001 RDI: ffff9f0cd1187a38
2024-09-02T11:15:06.501210+02:00 lisa kernel: [    C4] RBP: 000000000000000=
0 R08: 0000000000000001 R09: ffffffff8b0261c8
2024-09-02T11:15:06.501211+02:00 lisa kernel: [    C4] R10: 000000000000000=
1 R11: 0000000000000005 R12: ffffb64a45267d58
2024-09-02T11:15:06.501213+02:00 lisa kernel: [    C4] R13: ffff9f0cd118770=
0 R14: 0000000000000000 R15: ffff9f0c89b73c00
2024-09-02T11:15:06.501215+02:00 lisa kernel: [    C4] FS:  00007fde155f074=
0(0000) GS:ffff9f1b2e700000(0000) knlGS:0000000000000000
2024-09-02T11:15:06.501234+02:00 lisa kernel: [    C4] CS:  0010 DS: 0000 E=
S: 0000 CR0: 0000000080050033
2024-09-02T11:15:06.501236+02:00 lisa kernel: [    C4] CR2: 00007fde157327b=
0 CR3: 000000018167a000 CR4: 0000000000750ef0
2024-09-02T11:15:06.501238+02:00 lisa kernel: [    C4] PKRU: 55555554
2024-09-02T11:15:06.501239+02:00 lisa kernel: [    C4] Call Trace:
2024-09-02T11:15:06.501252+02:00 lisa kernel: [    C4]  <IRQ>
2024-09-02T11:15:06.501254+02:00 lisa kernel: [    C4]  ? rcu_dump_cpu_stac=
ks+0xd6/0x100
2024-09-02T11:15:06.501256+02:00 lisa kernel: [    C4]  ? rcu_sched_clock_i=
rq+0x31d/0xb20
2024-09-02T11:15:06.501259+02:00 lisa kernel: [    C4]  ? srso_alias_return=
_thunk+0x5/0xfbef5
2024-09-02T11:15:06.501260+02:00 lisa kernel: [    C4]  ? update_load_avg+0=
x77/0x6b0
2024-09-02T11:15:06.501261+02:00 lisa kernel: [    C4]  ? srso_alias_return=
_thunk+0x5/0xfbef5
2024-09-02T11:15:06.501263+02:00 lisa kernel: [    C4]  ? update_process_ti=
mes+0x69/0xa0
2024-09-02T11:15:06.501264+02:00 lisa kernel: [    C4]  ? tick_nohz_handler=
+0x8a/0x140
2024-09-02T11:15:06.501266+02:00 lisa kernel: [    C4]  ? tick_do_update_ji=
ffies64+0xd0/0xd0
2024-09-02T11:15:06.501268+02:00 lisa kernel: [    C4]  ? __hrtimer_run_que=
ues+0x110/0x1a0
2024-09-02T11:15:06.501270+02:00 lisa kernel: [    C4]  ? hrtimer_interrupt=
+0xf5/0x210
2024-09-02T11:15:06.501272+02:00 lisa kernel: [    C4]  ? __sysvec_apic_tim=
er_interrupt+0x4e/0x60
2024-09-02T11:15:06.501274+02:00 lisa kernel: [    C4]  ? sysvec_apic_timer=
_interrupt+0x64/0x80
2024-09-02T11:15:06.501275+02:00 lisa kernel: [    C4]  </IRQ>
2024-09-02T11:15:06.501277+02:00 lisa kernel: [    C4]  <TASK>
2024-09-02T11:15:06.501279+02:00 lisa kernel: [    C4]  ? asm_sysvec_apic_t=
imer_interrupt+0x1a/0x20
2024-09-02T11:15:06.501280+02:00 lisa kernel: [    C4]  ? queued_spin_lock_=
slowpath+0x43/0x1b0
2024-09-02T11:15:06.501283+02:00 lisa kernel: [    C4]  ? srso_alias_return=
_thunk+0x5/0xfbef5
2024-09-02T11:15:06.501284+02:00 lisa kernel: [    C4]  ? fuse_iget+0x11c/0=
x250 [fuse]
2024-09-02T11:15:06.501286+02:00 lisa kernel: [    C4]  ? fuse_fill_super_c=
ommon+0x362/0x480 [fuse]
2024-09-02T11:15:06.501288+02:00 lisa kernel: [    C4]  ? fuse_fill_super_c=
ommon+0x480/0x480 [fuse]
2024-09-02T11:15:06.501291+02:00 lisa kernel: [    C4]  ? fuse_fill_super+0=
x54/0x90 [fuse]
2024-09-02T11:15:06.501293+02:00 lisa kernel: [    C4]  ? get_tree_nodev+0x=
64/0x90
2024-09-02T11:15:06.501294+02:00 lisa kernel: [    C4]  ? fget+0x75/0xb0
2024-09-02T11:15:06.501297+02:00 lisa kernel: [    C4]  ? fuse_get_tree+0xb=
d/0x190 [fuse]
2024-09-02T11:15:06.501298+02:00 lisa kernel: [    C4]  ? vfs_get_tree+0x24=
/0xd0
2024-09-02T11:15:06.501300+02:00 lisa kernel: [    C4]  ? srso_alias_return=
_thunk+0x5/0xfbef5
2024-09-02T11:15:06.501302+02:00 lisa kernel: [    C4]  ? path_mount+0x472/=
0xab0
2024-09-02T11:15:06.501303+02:00 lisa kernel: [    C4]  ? __x64_sys_mount+0=
x103/0x140
2024-09-02T11:15:06.501305+02:00 lisa kernel: [    C4]  ? do_syscall_64+0x5=
f/0x170
2024-09-02T11:15:06.501308+02:00 lisa kernel: [    C4]  ? entry_SYSCALL_64_=
after_hwframe+0x55/0x5d
2024-09-02T11:15:06.501310+02:00 lisa kernel: [    C4]  </TASK>
[..]
2024-09-02T11:15:32.315047+02:00 lisa kernel: [    C4] watchdog: BUG: soft =
lockup - CPU#4 stuck for 45s! [fusermount3:1282]
2024-09-02T11:15:32.315052+02:00 lisa kernel: [    C4] Modules linked in: s=
nd_seq_dummy snd_hrtimer snd_seq_midi snd_seq_midi_event snd_rawmidi snd_se=
q snd_seq_device rfcomm cpufreq_userspace cpufreq_powersave cpufreq_conserv=
ative bnep nls_ascii nls_cp437 vfat fat snd_ctl_led snd_hda_codec_realtek s=
nd_hda_codec_generic snd_hda_scodec_component snd_hda_codec_hdmi snd_hda_in=
tel snd_intel_dspcfg btusb snd_hda_codec snd_soc_dmic snd_acp3x_rn snd_acp3=
x_pdm_dma uvcvideo btrtl snd_hwdep videobuf2_vmalloc snd_soc_core btintel u=
vc snd_hda_core videobuf2_memops btbcm snd_pcm_oss videobuf2_v4l2 btmtk snd=
_mixer_oss videodev snd_pcm bluetooth snd_rn_pci_acp3x snd_acp_config snd_t=
imer videobuf2_common snd_soc_acpi msi_wmi ecdh_generic amd_atl ecc mc spar=
se_keymap edac_mce_amd wmi_bmof snd k10temp snd_pci_acp3x ac soundcore ccp =
battery hid_sensor_accel_3d hid_sensor_gyro_3d hid_sensor_magn_3d hid_senso=
r_als hid_sensor_prox button hid_sensor_trigger industrialio_triggered_buff=
er kfifo_buf amd_pmc industrialio hid_sensor_iio_common evdev joydev serio_=
raw mt7921e mt7921_common
2024-09-02T11:15:32.315056+02:00 lisa kernel: [    C4]  mt792x_lib mt76_con=
nac_lib mt76 mac80211 libarc4 cfg80211 rfkill msr nvme_fabrics fuse efi_pst=
ore configfs efivarfs autofs4 ext4 crc32c_generic mbcache jbd2 usbhid amdgp=
u i2c_algo_bit drm_ttm_helper ttm xhci_pci drm_exec drm_suballoc_helper amd=
xcp xhci_hcd drm_buddy gpu_sched hid_sensor_hub usbcore nvme drm_display_he=
lper mfd_core i2c_piix4 hid_multitouch hid_generic crc32c_intel psmouse amd=
_sfh i2c_smbus usb_common nvme_core crc16 r8169 i2c_hid_acpi i2c_hid hid i2=
c_designware_platform i2c_designware_core
2024-09-02T11:15:32.315059+02:00 lisa kernel: [    C4] CPU: 4 UID: 0 PID: 1=
282 Comm: fusermount3 Not tainted 6.11.0-rc6-next-20240902-master #366
2024-09-02T11:15:32.315061+02:00 lisa kernel: [    C4] Hardware name: Micro=
-Star International Co., Ltd. Alpha 15 B5EEK/MS-158L, BIOS E158LAMS.107 11/=
10/2021
2024-09-02T11:15:32.315063+02:00 lisa kernel: [    C4] RIP: 0010:queued_spi=
n_lock_slowpath+0x46/0x1b0
2024-09-02T11:15:32.315065+02:00 lisa kernel: [    C4] Code: 0f 92 c1 8b 02=
 0f b6 c9 c1 e1 08 30 e4 09 c8 3d ff 00 00 00 0f 87 e9 00 00 00 85 c0 74 10=
 0f b6 02 84 c0 74 09 f3 90 0f b6 02 <84> c0 75 f7 b8 01 00 00 00 66 89 02 =
e9 54 dd 1d 00 8b 37 b8 00 02
2024-09-02T11:15:32.315068+02:00 lisa kernel: [    C4] RSP: 0018:ffffb64a45=
267d08 EFLAGS: 00000202
2024-09-02T11:15:32.315070+02:00 lisa kernel: [    C4] RAX: 000000000000000=
1 RBX: ffff9f0cd1187a38 RCX: 0000000000000000
2024-09-02T11:15:32.315072+02:00 lisa kernel: [    C4] RDX: ffff9f0cd1187a3=
8 RSI: 0000000000000001 RDI: ffff9f0cd1187a38
2024-09-02T11:15:32.315074+02:00 lisa kernel: [    C4] RBP: 000000000000000=
0 R08: 0000000000000001 R09: ffffffff8b0261c8
2024-09-02T11:15:32.315076+02:00 lisa kernel: [    C4] R10: 000000000000000=
1 R11: 0000000000000005 R12: ffffb64a45267d58
2024-09-02T11:15:32.315077+02:00 lisa kernel: [    C4] R13: ffff9f0cd118770=
0 R14: 0000000000000000 R15: ffff9f0c89b73c00
2024-09-02T11:15:32.315080+02:00 lisa kernel: [    C4] FS:  00007fde155f074=
0(0000) GS:ffff9f1b2e700000(0000) knlGS:0000000000000000
2024-09-02T11:15:32.315082+02:00 lisa kernel: [    C4] CS:  0010 DS: 0000 E=
S: 0000 CR0: 0000000080050033
2024-09-02T11:15:32.315084+02:00 lisa kernel: [    C4] CR2: 00007fde157327b=
0 CR3: 000000018167a000 CR4: 0000000000750ef0
2024-09-02T11:15:32.315086+02:00 lisa kernel: [    C4] PKRU: 55555554
2024-09-02T11:15:32.315088+02:00 lisa kernel: [    C4] Call Trace:
2024-09-02T11:15:32.315090+02:00 lisa kernel: [    C4]  <IRQ>
2024-09-02T11:15:32.315092+02:00 lisa kernel: [    C4]  ? watchdog_timer_fn=
.cold+0x3d/0x9c
2024-09-02T11:15:32.315094+02:00 lisa kernel: [    C4]  ? softlockup_fn+0x5=
0/0x50
2024-09-02T11:15:32.315097+02:00 lisa kernel: [    C4]  ? __hrtimer_run_que=
ues+0x110/0x1a0
2024-09-02T11:15:32.315099+02:00 lisa kernel: [    C4]  ? hrtimer_interrupt=
+0xf5/0x210
2024-09-02T11:15:32.315101+02:00 lisa kernel: [    C4]  ? __sysvec_apic_tim=
er_interrupt+0x4e/0x60
2024-09-02T11:15:32.315104+02:00 lisa kernel: [    C4]  ? sysvec_apic_timer=
_interrupt+0x64/0x80
2024-09-02T11:15:32.315106+02:00 lisa kernel: [    C4]  </IRQ>
2024-09-02T11:15:32.315108+02:00 lisa kernel: [    C4]  <TASK>
2024-09-02T11:15:32.315111+02:00 lisa kernel: [    C4]  ? asm_sysvec_apic_t=
imer_interrupt+0x1a/0x20
2024-09-02T11:15:32.315113+02:00 lisa kernel: [    C4]  ? queued_spin_lock_=
slowpath+0x46/0x1b0
2024-09-02T11:15:32.315115+02:00 lisa kernel: [    C4]  ? srso_alias_return=
_thunk+0x5/0xfbef5
2024-09-02T11:15:32.315117+02:00 lisa kernel: [    C4]  ? fuse_iget+0x11c/0=
x250 [fuse]
2024-09-02T11:15:32.315120+02:00 lisa kernel: [    C4]  ? fuse_fill_super_c=
ommon+0x362/0x480 [fuse]
2024-09-02T11:15:32.315122+02:00 lisa kernel: [    C4]  ? fuse_fill_super_c=
ommon+0x480/0x480 [fuse]
2024-09-02T11:15:32.315124+02:00 lisa kernel: [    C4]  ? fuse_fill_super+0=
x54/0x90 [fuse]
2024-09-02T11:15:32.315126+02:00 lisa kernel: [    C4]  ? get_tree_nodev+0x=
64/0x90
2024-09-02T11:15:32.315128+02:00 lisa kernel: [    C4]  ? fget+0x75/0xb0
2024-09-02T11:15:32.315129+02:00 lisa kernel: [    C4]  ? fuse_get_tree+0xb=
d/0x190 [fuse]
2024-09-02T11:15:32.315132+02:00 lisa kernel: [    C4]  ? vfs_get_tree+0x24=
/0xd0
2024-09-02T11:15:32.315134+02:00 lisa kernel: [    C4]  ? srso_alias_return=
_thunk+0x5/0xfbef5
2024-09-02T11:15:32.315136+02:00 lisa kernel: [    C4]  ? path_mount+0x472/=
0xab0
2024-09-02T11:15:32.315138+02:00 lisa kernel: [    C4]  ? __x64_sys_mount+0=
x103/0x140
2024-09-02T11:15:32.315139+02:00 lisa kernel: [    C4]  ? do_syscall_64+0x5=
f/0x170
2024-09-02T11:15:32.315140+02:00 lisa kernel: [    C4]  ? entry_SYSCALL_64_=
after_hwframe+0x55/0x5d
2024-09-02T11:15:32.315142+02:00 lisa kernel: [    C4]  </TASK>
2024-09-02T11:15:34.520022+02:00 lisa kernel: [   T18] rcu: INFO: rcu_preem=
pt detected expedited stalls on CPUs/tasks: { 4-.... } 21130 jiffies s: 965=
 root: 0x10/.
2024-09-02T11:15:34.520027+02:00 lisa kernel: [   T18] rcu: blocking rcu_no=
de structures (internal RCU debug):
2024-09-02T11:15:34.520029+02:00 lisa kernel: [   T18] Sending NMI from CPU=
 0 to CPUs 4:
2024-09-02T11:15:34.520030+02:00 lisa kernel: [    C4] NMI backtrace for cp=
u 4
2024-09-02T11:15:34.520032+02:00 lisa kernel: [    C4] CPU: 4 UID: 0 PID: 1=
282 Comm: fusermount3 Tainted: G             L     6.11.0-rc6-next-20240902=
-master #366
2024-09-02T11:15:34.520033+02:00 lisa kernel: [    C4] Tainted: [L]=3DSOFTL=
OCKUP
2024-09-02T11:15:34.520036+02:00 lisa kernel: [    C4] Hardware name: Micro=
-Star International Co., Ltd. Alpha 15 B5EEK/MS-158L, BIOS E158LAMS.107 11/=
10/2021
2024-09-02T11:15:34.520038+02:00 lisa kernel: [    C4] RIP: 0010:queued_spi=
n_lock_slowpath+0x46/0x1b0
2024-09-02T11:15:34.520040+02:00 lisa kernel: [    C4] Code: 0f 92 c1 8b 02=
 0f b6 c9 c1 e1 08 30 e4 09 c8 3d ff 00 00 00 0f 87 e9 00 00 00 85 c0 74 10=
 0f b6 02 84 c0 74 09 f3 90 0f b6 02 <84> c0 75 f7 b8 01 00 00 00 66 89 02 =
e9 54 dd 1d 00 8b 37 b8 00 02
2024-09-02T11:15:34.520041+02:00 lisa kernel: [    C4] RSP: 0018:ffffb64a45=
267d08 EFLAGS: 00000202
2024-09-02T11:15:34.520044+02:00 lisa kernel: [    C4] RAX: 000000000000000=
1 RBX: ffff9f0cd1187a38 RCX: 0000000000000000
2024-09-02T11:15:34.520046+02:00 lisa kernel: [    C4] RDX: ffff9f0cd1187a3=
8 RSI: 0000000000000001 RDI: ffff9f0cd1187a38
2024-09-02T11:15:34.520048+02:00 lisa kernel: [    C4] RBP: 000000000000000=
0 R08: 0000000000000001 R09: ffffffff8b0261c8
2024-09-02T11:15:34.520049+02:00 lisa kernel: [    C4] R10: 000000000000000=
1 R11: 0000000000000005 R12: ffffb64a45267d58
2024-09-02T11:15:34.520050+02:00 lisa kernel: [    C4] R13: ffff9f0cd118770=
0 R14: 0000000000000000 R15: ffff9f0c89b73c00
2024-09-02T11:15:34.520052+02:00 lisa kernel: [    C4] FS:  00007fde155f074=
0(0000) GS:ffff9f1b2e700000(0000) knlGS:0000000000000000
2024-09-02T11:15:34.520054+02:00 lisa kernel: [    C4] CS:  0010 DS: 0000 E=
S: 0000 CR0: 0000000080050033
2024-09-02T11:15:34.520056+02:00 lisa kernel: [    C4] CR2: 00007fde157327b=
0 CR3: 000000018167a000 CR4: 0000000000750ef0
2024-09-02T11:15:34.520057+02:00 lisa kernel: [    C4] PKRU: 55555554
2024-09-02T11:15:34.520058+02:00 lisa kernel: [    C4] Call Trace:
2024-09-02T11:15:34.520060+02:00 lisa kernel: [    C4]  <NMI>
2024-09-02T11:15:34.520062+02:00 lisa kernel: [    C4]  ? nmi_cpu_backtrace=
.cold+0x32/0x63
2024-09-02T11:15:34.520064+02:00 lisa kernel: [    C4]  ? nmi_cpu_backtrace=
_handler+0xc/0x20
2024-09-02T11:15:34.520066+02:00 lisa kernel: [    C4]  ? nmi_handle+0x53/0=
xc0
2024-09-02T11:15:34.520068+02:00 lisa kernel: [    C4]  ? default_do_nmi+0x=
40/0x260
2024-09-02T11:15:34.520069+02:00 lisa kernel: [    C4]  ? exc_nmi+0xe0/0x110
2024-09-02T11:15:34.520072+02:00 lisa kernel: [    C4]  ? end_repeat_nmi+0x=
f/0x41
2024-09-02T11:15:34.520074+02:00 lisa kernel: [    C4]  ? queued_spin_lock_=
slowpath+0x46/0x1b0
2024-09-02T11:15:34.520075+02:00 lisa kernel: [    C4]  ? queued_spin_lock_=
slowpath+0x46/0x1b0
2024-09-02T11:15:34.520077+02:00 lisa kernel: [    C4]  ? queued_spin_lock_=
slowpath+0x46/0x1b0
2024-09-02T11:15:34.520078+02:00 lisa kernel: [    C4]  </NMI>
2024-09-02T11:15:34.520080+02:00 lisa kernel: [    C4]  <TASK>
2024-09-02T11:15:34.520081+02:00 lisa kernel: [    C4]  ? fuse_iget+0x11c/0=
x250 [fuse]

I bisected the error to commit 5fb9c98e9d8d ("fuse: add support for no forg=
et requests").

As a locking issue seemed likely I recompiled next-20240902 with CONFIG_LOC=
KDEP=3Dy
and got this (in addition to the messages above)

2024-09-02T14:57:03.788867+02:00 lisa kernel: [ T1283] =3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
2024-09-02T14:57:03.788870+02:00 lisa kernel: [ T1283] WARNING: possible re=
cursive locking detected
2024-09-02T14:57:03.788871+02:00 lisa kernel: [ T1283] 6.11.0-rc6-next-2024=
0902-debug #383 Not tainted
2024-09-02T14:57:03.788873+02:00 lisa kernel: [ T1283] --------------------=
------------------------
2024-09-02T14:57:03.788875+02:00 lisa kernel: [ T1283] fusermount3/1283 is =
trying to acquire lock:
2024-09-02T14:57:03.788877+02:00 lisa kernel: [ T1283] ffff951a718dfb40 (&f=
i->lock){+.+.}-{2:2}, at: fuse_iget+0x11c/0x250 [fuse]
2024-09-02T14:57:03.788880+02:00 lisa kernel: [ T1283]=20
2024-09-02T14:57:03.788882+02:00 lisa kernel: [ T1283] but task is already =
holding lock:
2024-09-02T14:57:03.788884+02:00 lisa kernel: [ T1283] ffff951a718dfb40 (&f=
i->lock){+.+.}-{2:2}, at: fuse_iget+0x10c/0x250 [fuse]
2024-09-02T14:57:03.788886+02:00 lisa kernel: [ T1283]=20
2024-09-02T14:57:03.788888+02:00 lisa kernel: [ T1283] other info that migh=
t help us debug this:
2024-09-02T14:57:03.788889+02:00 lisa kernel: [ T1283]  Possible unsafe loc=
king scenario:
2024-09-02T14:57:03.788891+02:00 lisa kernel: [ T1283]=20
2024-09-02T14:57:03.788893+02:00 lisa kernel: [ T1283]        CPU0
2024-09-02T14:57:03.788895+02:00 lisa kernel: [ T1283]        ----
2024-09-02T14:57:03.788897+02:00 lisa kernel: [ T1283]   lock(&fi->lock);
2024-09-02T14:57:03.788899+02:00 lisa kernel: [ T1283]   lock(&fi->lock);
2024-09-02T14:57:03.788900+02:00 lisa kernel: [ T1283]=20
2024-09-02T14:57:03.788903+02:00 lisa kernel: [ T1283]  *** DEADLOCK ***
2024-09-02T14:57:03.788905+02:00 lisa kernel: [ T1283]=20
2024-09-02T14:57:03.788906+02:00 lisa kernel: [ T1283]  May be due to missi=
ng lock nesting notation
2024-09-02T14:57:03.788908+02:00 lisa kernel: [ T1283]=20
2024-09-02T14:57:03.788910+02:00 lisa kernel: [ T1283] 2 locks held by fuse=
rmount3/1283:
2024-09-02T14:57:03.788912+02:00 lisa kernel: [ T1283]  #0: ffff951a82ca70e=
0 (&type->s_umount_key#54/1){+.+.}-{3:3}, at: alloc_super+0xd4/0x3d0
2024-09-02T14:57:03.788913+02:00 lisa kernel: [ T1283]  #1: ffff951a718dfb4=
0 (&fi->lock){+.+.}-{2:2}, at: fuse_iget+0x10c/0x250 [fuse]
2024-09-02T14:57:03.788914+02:00 lisa kernel: [ T1283]=20
2024-09-02T14:57:03.788916+02:00 lisa kernel: [ T1283] stack backtrace:
2024-09-02T14:57:03.788918+02:00 lisa kernel: [ T1283] CPU: 0 UID: 0 PID: 1=
283 Comm: fusermount3 Not tainted 6.11.0-rc6-next-20240902-debug #383
2024-09-02T14:57:03.788920+02:00 lisa kernel: [ T1283] Hardware name: Micro=
-Star International Co., Ltd. Alpha 15 B5EEK/MS-158L, BIOS E158LAMS.107 11/=
10/2021
2024-09-02T14:57:03.788939+02:00 lisa kernel: [ T1283] Call Trace:
2024-09-02T14:57:03.788942+02:00 lisa kernel: [ T1283]  <TASK>
2024-09-02T14:57:03.788944+02:00 lisa kernel: [ T1283]  ? dump_stack_lvl+0x=
6d/0xb0
2024-09-02T14:57:03.788945+02:00 lisa kernel: [ T1283]  ? print_deadlock_bu=
g.cold+0xbd/0xcc
2024-09-02T14:57:03.788948+02:00 lisa kernel: [ T1283]  ? __lock_acquire+0x=
14e6/0x2780
2024-09-02T14:57:03.788951+02:00 lisa kernel: [ T1283]  ? lock_acquire+0xd5=
/0x300
2024-09-02T14:57:03.788953+02:00 lisa kernel: [ T1283]  ? fuse_iget+0x11c/0=
x250 [fuse]
2024-09-02T14:57:03.788956+02:00 lisa kernel: [ T1283]  ? fuse_iget+0x23c/0=
x250 [fuse]
2024-09-02T14:57:03.788959+02:00 lisa kernel: [ T1283]  ? srso_alias_return=
_thunk+0x5/0xfbef5
2024-09-02T14:57:03.788961+02:00 lisa kernel: [ T1283]  ? _raw_spin_lock+0x=
2b/0x40
2024-09-02T14:57:03.788979+02:00 lisa kernel: [ T1283]  ? fuse_iget+0x11c/0=
x250 [fuse]
2024-09-02T14:57:03.788981+02:00 lisa kernel: [ T1283]  ? fuse_iget+0x11c/0=
x250 [fuse]
2024-09-02T14:57:03.788996+02:00 lisa kernel: [ T1283]  ? fuse_fill_super_c=
ommon+0x32a/0x450 [fuse]
2024-09-02T14:57:03.788998+02:00 lisa kernel: [ T1283]  ? fuse_fill_super_c=
ommon+0x450/0x450 [fuse]
2024-09-02T14:57:03.789001+02:00 lisa kernel: [ T1283]  ? fuse_fill_super+0=
x57/0x90 [fuse]
2024-09-02T14:57:03.789004+02:00 lisa kernel: [ T1283]  ? get_tree_nodev+0x=
67/0x90
2024-09-02T14:57:03.789006+02:00 lisa kernel: [ T1283]  ? fuse_get_tree+0xc=
3/0x1a0 [fuse]
2024-09-02T14:57:03.789008+02:00 lisa kernel: [ T1283]  ? vfs_get_tree+0x27=
/0xe0
2024-09-02T14:57:03.789011+02:00 lisa kernel: [ T1283]  ? path_mount+0x483/=
0xba0
2024-09-02T14:57:03.789014+02:00 lisa kernel: [ T1283]  ? __x64_sys_mount+0=
x103/0x140
2024-09-02T14:57:03.789015+02:00 lisa kernel: [ T1283]  ? do_syscall_64+0x7=
2/0x180
2024-09-02T14:57:03.789017+02:00 lisa kernel: [ T1283]  ? entry_SYSCALL_64_=
after_hwframe+0x55/0x5d
2024-09-02T14:57:03.789020+02:00 lisa kernel: [ T1283]  </TASK>

Reverting commit 5fb9c98e9d8d cleanly in next-20240902 is not possible, but=
 I found
that the following patch fixes the issue for me:

diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index f4fe9199c706..d62eb6edc0aa 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -484,7 +484,9 @@ struct inode *fuse_iget(struct super_block *sb, u64 nod=
eid,
 		}
 	}
 	fi =3D get_fuse_inode(inode);
-	fuse_inc_nlookup(fc, fi);
+	spin_lock(&fi->lock);
+	fi->nlookup++;
+	spin_unlock(&fi->lock);
 done:
 	fuse_change_attributes(inode, attr, NULL, attr_valid, attr_version);


Bert Karwatzki


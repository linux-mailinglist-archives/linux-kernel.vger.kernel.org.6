Return-Path: <linux-kernel+bounces-569087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69EF8A69E64
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 03:41:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87A8C8A6FE4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 02:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C5731EC014;
	Thu, 20 Mar 2025 02:40:48 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140E31EBA03
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 02:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742438448; cv=none; b=W+xv9O2FcgwmnHE++Ak/Apg66htEcFCTpvEnNgnDXQ8wmooH+2BR8XOB+8jP5zFY8gR3IBIb4yTWT24Kw77MN/JXU6GZQSkldHIlj9wZ4U9gYLgKaaxqio4frDarxyhL0XqNZnnnIYr77moexyoWNI0+f9lAV1pLwQq1fOC2QQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742438448; c=relaxed/simple;
	bh=mON+KisWxB4g1I75lAd7XFzn/S5kHveMIkUcOOwfTKw=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=F67mbOjUzCZDjFirQmnzy5Lk3qxUxaBhj0Pnkq7j3JLtwuVB9DBNhzEwTW2B69bd5XRiaPVBDz4RaIggUF4fdaeeyN6iRHUxabPTMMq8x9p2Fm0E8K26hcMlxIN/DH/7kvuMKPddd8WQOkp3LgZecOlVoQjhlDaertTbUCaZlO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4ZJ8vH2Ln7z13Kmd;
	Thu, 20 Mar 2025 10:40:27 +0800 (CST)
Received: from kwepemg100017.china.huawei.com (unknown [7.202.181.58])
	by mail.maildlp.com (Postfix) with ESMTPS id DB9FA18007F;
	Thu, 20 Mar 2025 10:40:41 +0800 (CST)
Received: from [10.174.178.114] (10.174.178.114) by
 kwepemg100017.china.huawei.com (7.202.181.58) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 20 Mar 2025 10:40:40 +0800
Message-ID: <844a1a1b-c9f3-48c2-b5d2-239037fa0b3b@huawei.com>
Date: Thu, 20 Mar 2025 10:40:40 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <mawupeng1@huawei.com>, <akpm@linux-foundation.org>, <david@redhat.com>,
	<linmiaohe@huawei.com>, <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<mhocko@suse.com>, <nao.horiguchi@gmail.com>, <osalvador@suse.de>
Subject: Re: mm: memory-failure: update ttu flag inside unmap_poisoned_folio
To: <arthur.marsh@internode.on.net>
References: <20250217014329.3610326-2-mawupeng1@huawei.com>
 <20250319172153.4702-1-user@am64>
From: mawupeng <mawupeng1@huawei.com>
In-Reply-To: <20250319172153.4702-1-user@am64>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemg100017.china.huawei.com (7.202.181.58)



On 2025/3/20 1:21, Arthur Marsh wrote:
> On recent kernel builds on a system with the following CPU with integra=
ted GPU:
>=20
> AMD Ryzen 5 5500GT with Radeon Graphics=20
>=20
> using the integrated GPU, on the following motherboard:
>=20
> System manufacturer System Product Name/PRIME B350M-A, BIOS 6232 09/29/=
2024
>=20
> I've been getting the error below on the initial loading of chromium af=
ter
> booting, which I git-bisected back to commit
>=20
> b81679b1633aa43c0d973adfa816d78c1ed0d032 (which I am replying to now):
>=20
> :
>=20
> [  281.651311] WARNING: CPU: 4 PID: 3525 at mm/util.c:674 __kvmalloc_no=
de_noprof+0xc8/0xe0
> [  281.651322] Modules linked in: snd_seq_dummy snd_hrtimer snd_seq_mid=
i snd_seq_midi_event snd_rawmidi snd_seq snd_seq_device fuse bnep bluetoo=
th rfkill cpufreq_userspace cpufreq_conservative cpufreq_powersave binfmt=
_misc nf_tables scsi_transport_iscsi nfnetlink sch_fq_codel exfat parport=
_pc ppdev lp parport rtl2832_sdr videobuf2_vmalloc videobuf2_memops video=
buf2_v4l2 videobuf2_common videodev fc0012 rtl2832 i2c_mux regmap_i2c dvb=
_usb_rtl28xxu amdgpu dvb_usb_v2 dvb_core mc amdxcp gpu_sched snd_hda_code=
c_realtek snd_hda_codec_hdmi drm_panel_backlight_quirks cec snd_hda_codec=
_generic drm_buddy drm_ttm_helper ttm snd_hda_scodec_component snd_hda_in=
tel drm_client_lib drm_exec drm_suballoc_helper snd_intel_dspcfg drm_disp=
lay_helper snd_hda_codec intel_rapl_msr intel_rapl_common snd_hda_core dr=
m_kms_helper tpm_crb tpm_tis tpm_tis_core snd_hwdep drm snd_pcm tpm edac_=
mce_amd sha512_ssse3 sha3_generic jitterentropy_rng hmac drbg libaescfb s=
nd_timer ansi_cprng sha512_generic i2c_algo_bit ecdh_generic snd sha256_s=
sse3 sha1_ssse3
> [  281.651387]  ccp aesni_intel ecc video mfd_core gf128mul crypto_simd=
 cryptd button evdev soundcore wmi pcspkr rng_core k10temp ext4 crc16 mbc=
ache jbd2 hid_generic usbhid sg uas sr_mod hid usb_storage cdrom sd_mod s=
p5100_tco ahci libahci xhci_pci r8169 xhci_hcd libata realtek mdio_devres=
 serio_raw i2c_piix4 usbcore scsi_mod i2c_smbus libphy scsi_common usb_co=
mmon
> [  281.651424] CPU: 4 UID: 1000 PID: 3525 Comm: chromium Tainted: G    =
    W          6.14.0-rc3+ #6448
> [  281.651429] Tainted: [W]=3DWARN
> [  281.651430] Hardware name: System manufacturer System Product Name/P=
RIME B350M-A, BIOS 6232 09/29/2024
> [  281.651433] RIP: 0010:__kvmalloc_node_noprof+0xc8/0xe0
> [  281.651436] Code: 64 24 08 41 89 d8 be 01 00 00 00 48 89 ef 48 01 d1=
 48 89 44 24 10 48 c7 04 24 00 04 00 00 e8 6f 25 04 00 eb 87 80 e7 20 75 =
82 <0f> 0b 90 0f 1f 44 00 00 e9 75 ff ff ff 66 66 2e 0f 1f 84 00 00 00
> [  281.651438] RSP: 0018:ffffb1334837fc40 EFLAGS: 00010246
> [  281.651440] RAX: 0000000000000000 RBX: 00000000000000c0 RCX: 0000000=
000000016
> [  281.651442] RDX: 0000000000000016 RSI: ffffffffbe164ba8 RDI: 0000000=
000052cc0
> [  281.651443] RBP: 0000000498843b00 R08: ffffb1334837fda8 R09: ffffb13=
34837fdb8
> [  281.651444] R10: 0000000000000018 R11: 0000000000000000 R12: 0000000=
0ffffffff
> [  281.651445] R13: ffffb1334837fcb8 R14: 0000000000000000 R15: ffff997=
e75680010
> [  281.651446] FS:  00007fda628ef500(0000) GS:ffff99854e700000(0000) kn=
lGS:0000000000000000
> [  281.651447] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  281.651448] CR2: 00007fda6554b302 CR3: 000000013df40000 CR4: 0000000=
000750ef0
> [  281.651449] PKRU: 55555558
> [  281.651450] Call Trace:
> [  281.651451]  <TASK>
> [  281.651453]  ? __kvmalloc_node_noprof+0xc8/0xe0
> [  281.651455]  ? __warn.cold+0xad/0x109
> [  281.651459]  ? __kvmalloc_node_noprof+0xc8/0xe0
> [  281.651461]  ? report_bug+0x102/0x190
> [  281.651470]  ? handle_bug+0x59/0xa0
> [  281.651474]  ? exc_invalid_op+0x1f/0x90
> [  281.651477]  ? asm_exc_invalid_op+0x16/0x20
> [  281.651481]  ? __kmalloc_node_noprof+0x278/0x360
> [  281.651487]  ? __kvmalloc_node_noprof+0xc8/0xe0
> [  281.651489]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  281.651491]  ? chrdev_open+0xad/0x220
> [  281.651496]  amdgpu_bo_create_list_entry_array+0x47/0x120 [amdgpu]
> [  281.651729]  amdgpu_bo_list_ioctl+0x4e/0x330 [amdgpu]
> [  281.651823]  ? __pfx_amdgpu_bo_list_ioctl+0x10/0x10 [amdgpu]
> [  281.651914]  drm_ioctl_kernel+0xa6/0x100 [drm]
> [  281.651942]  drm_ioctl+0x236/0x540 [drm]
> [  281.651954]  ? __pfx_amdgpu_bo_list_ioctl+0x10/0x10 [amdgpu]
> [  281.652047]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  281.652049]  ? preempt_count_add+0x51/0xd0
> [  281.652053]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  281.652054]  ? migrate_enable+0xc0/0xf0
> [  281.652058]  amdgpu_drm_ioctl+0x58/0xa0 [amdgpu]
> [  281.652138]  __x64_sys_ioctl+0x55f/0xab0
> [  281.652143]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  281.652145]  ? do_sys_openat2+0x74/0xb0
> [  281.652148]  ? do_user_addr_fault+0x3a0/0x660
> [  281.652153]  do_syscall_64+0x47/0x110
> [  281.652155]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [  281.652157] RIP: 0033:0x7fda65ad08db
> [  281.652159] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10=
 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f =
05 <89> c2 3d 00 f0 ff ff 77 1c 48 8b 44 24 18 64 48 2b 04 25 28 00 00
> [  281.652160] RSP: 002b:00007ffc93108640 EFLAGS: 00000246 ORIG_RAX: 00=
00000000000010
> [  281.652162] RAX: ffffffffffffffda RBX: 00003cfc000ac640 RCX: 00007fd=
a65ad08db
> [  281.652162] RDX: 00007ffc931086f0 RSI: 00000000c0106443 RDI: 0000000=
000000014
> [  281.652163] RBP: 00007ffc931086f0 R08: 0000000000000000 R09: 0000000=
000000000
> [  281.652164] R10: 000000000000006c R11: 0000000000000246 R12: 0000000=
0c0106443
> [  281.652165] R13: 0000000000000014 R14: 00007ffc93108760 R15: 00003cf=
c000ac658
> [  281.652168]  </TASK>
> [  281.652168] ---[ end trace 0000000000000000 ]---

It seems there is no connection with this patch.

>=20
> chromium still loads and runs fine, but I am left wondering why this me=
ssage
> is appearing.
>=20
> I can supply full dmesg and .config if required.
>=20
> Arthur.
>=20
>=20



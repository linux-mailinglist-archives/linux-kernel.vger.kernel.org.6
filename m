Return-Path: <linux-kernel+bounces-418915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CFC7A9D6724
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 02:56:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 528F8B21E85
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 01:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D37C07CF16;
	Sat, 23 Nov 2024 01:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FHmMsX5o"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9592F5A
	for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 01:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732327007; cv=none; b=Z+zts8E7UWki+mi+lckI7qZzVJ+/PiKNy0lkAd817SkqCo0sxjb3VTGAXGRapqfnlMMZG3Ztam/Y3SMjIAjjao/F6xehmDWmPIiszyvOLYT9EC/VdRWH2tp01fJcRvly/NnkNVMPFcXlw6qOmyhhBiiU18Hfx0bwy7xdR1jFvNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732327007; c=relaxed/simple;
	bh=2UDGQoQx9oChYIABIm69GFJAfB6+zIqA5cj8CJhwxH4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=uzohSdk+zbw2EcZjcKPcABb27qVn1cKlzd7nIngkHuDrfeE1vaLGNgEmFRwAnjqi22AygW1zzkVt6jaDpKW5eH2L0/368t5J1acNjZ1pTO7GOH+KyNwNnwybgSOygjZF5Fg46rkE/lKRWcAdjEqY8hgVHCQBcLLdW/V7qGK6US4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FHmMsX5o; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-46097806aaeso17987431cf.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 17:56:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732327004; x=1732931804; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SbWHakUX9ZtEgnqPU/NswGuac0NLhWtUUtku6WlLLAk=;
        b=FHmMsX5oNzV3ljna13FyqTORLaORJBF+I7eilKsGDcUpuGPKCustJz3ohUdSqeSAwV
         cxnmqCea2MvYjgyKBSGV7scudLxdlaDilFRzzbqaGY2AUMX+k2XQl6XDUGkt/VHXEC9d
         SzO+t00UEMqAaYbjq47gfS+NqFvc2UUyjUpqUGB9xAnJdtCZHVB3TLy6ETDkyAQhA3+E
         XmaOoedRdaPncGfaSFQ/bWUBVHSZQFyZlzwVTnmJhiNr0z9xAmuDfk+qfAuoZoOyiR1v
         JmxAUPLRKsZ/sl2BJCJDo6dWQCCQ9uYcaAQrhUjGJ3Ry0b2UryKQVJg02oqXvpBLUQBm
         7xfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732327004; x=1732931804;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SbWHakUX9ZtEgnqPU/NswGuac0NLhWtUUtku6WlLLAk=;
        b=W9RkT2GcrhaMDF61eJAUN2pj6/18/ndE5zK5+C2mZPNig7SPcYX1Pb8wmlyzB23TvA
         Q50ZfR75TiFtW9prF3YKJALTXTqhKm/h1I/1ty5CdK9x98vV+CzMWW5jVSFAB5kGBgor
         qE8jDHSrR+dthcs5NlLLSXmSynVGW9T+drR9DXkOUE7FpW5yA1/1RSNdFHYNyYRHR3m6
         zpvX/yz+MG/kw0QPCskecobGLWE5cmSArc1FvsInZfM7tff/ErXs/uDaWKOdnyD7x5pN
         NQx6Fvwbx6AiqxXQPKjegkcVuJypYI3oVWOoQv5U97Gq4QOepSgTlkOe4r9CmJ1GplSi
         uq5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUesb94quophbkq8DGhdaSiszrppsFfFHNW6O5EbHzHqqKMwYeypVmEB5yz8V0dyrUZee4w3QCVH0Zs8Os=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDhXkpO23AbALCMdoX8JqoQMQ+0ERzqrrvHliMwtG2k/u2uX0c
	g6lTlE7nmSgChsTreXDseIqgc5dk+CBeLLSzmu3e2ar+s9nO/wtK38cX46CMZBfWogY9amDBuuP
	E3/5MP59MtHAv4jsOeW6FxQnW3TJ9LZXA
X-Gm-Gg: ASbGnct6x5XakvXzzz4OzTUoyIo+KiOMkskzFx4WPbll/94WIRH/8NjOa3/+N0h+Zop
	RR6ykY8TleEL1pLY9U96spBL7gHWj0u4=
X-Google-Smtp-Source: AGHT+IH5Fr+sZz4ivcPBKChPrt0U8V00z85wYBlkns1ZmbO0KyN5E4Wne4c9VY5F9GW5Ke0M2gnvhqdoh+YlxAUf+h4=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:622a:10e:b0:462:aac9:56bd with SMTP id
 d75a77b69052e-4653d5222c6mr77267211cf.4.1732327004147; Fri, 22 Nov 2024
 17:56:44 -0800 (PST)
Received: from 377903785069 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 22 Nov 2024 20:56:43 -0500
From: Forest Crossman <cyrozap@gmail.com>
Date: Fri, 22 Nov 2024 20:56:43 -0500
Message-ID: <CAO3ALPyC20qhCV4J93gxsiaovgXY_DWh7D2=mVK-YKAV=9sXQA@mail.gmail.com>
Subject: Kernel warning in dcn30_dpp.c; short freezing, crashes in KWin
To: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, all. I have a laptop with an AMD Radeon 780M, and I'm getting a
warning message shortly after boot (see the end of this email for the
message). I noticed the message while investigating some issues that I
began to experience after performing some software updates.

The first issue I noticed was that the screen will have very short
freezes--like it's failing to refresh--when the mouse isn't moving,
which is immediately noticeable when typing. I've been able to work
around this issue by dropping my displays refresh rate from its native
120 Hz to 60 Hz (which according to the EDID isn't actually changing the
refresh rate of the screen so much as increasing the blanking period so
the screen only gets updated 60 times per second), but I still
experience the issue when entering my password at the login screen
(SDDM), which I think is still running the display at its native 120 Hz.

Coincidentally (or perhaps not), I've also been getting very consistent
crashes in KWin (Wayland) whenever I run a Vulkan game (specifically,
Baldur's Gate 3 version 4.1.1.6072089). KWin doesn't crash if I instead
run the game in DirectX 11 mode, with Wine performing the translation to
OpenGL. Using DXVK to translate the DirectX calls to Vulkan causes the
same crash in KWin.

If you need any more information from me to find the source of these
warning messages, freezing, and crashes, or if you have any suggestions
as to how I can troubleshoot further, please let me know.

My system information and the warning message itself can be found at the
end of this message.

Regards,
Forest

---

System information:

Operating System: Arch Linux
KDE Plasma Version: 6.2.3
KDE Frameworks Version: 6.8.0
Qt Version: 6.8.0
Kernel Version: 6.11.9-arch1-1 (64-bit)
Graphics Platform: Wayland
Processors: 16 =C3=97 AMD Ryzen 7 PRO 8840HS w/ Radeon 780M Graphics
Memory: 58.5 GiB of RAM
Graphics Processor: AMD Radeon Graphics
Manufacturer: LENOVO
Product Name: 21ME001MUS
System Version: ThinkPad P14s Gen 5 AMD

Display: 2880x1800 120 Hz HDR OLED (eDP), set to 60 Hz with HDR enabled

---

Kernel warning message:

[   22.335551] ------------[ cut here ]------------
[   22.335557] WARNING: CPU: 8 PID: 537 at
drivers/gpu/drm/amd/amdgpu/../display/dc/dpp/dcn30/dcn30_dpp.c:534
dpp3_deferred_update+0x101/0x330 [amdgpu]
[   22.335904] Modules linked in: snd_seq_dummy rfcomm snd_hrtimer
snd_seq snd_seq_device wireguard curve25519_x86_64 libchacha20poly1305
chacha_x86_64 poly1305_x86_64 libcurve25519_generic libchacha
ip6_udp_tunnel udp_tunnel nft_masq nft_reject_ipv4 nf_nat_tftp
nf_conntrack_tftp bridge stp llc nft_fib_inet nft_fib_ipv4
nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6
nft_reject nft_ct nft_chain_nat ip6table_nat ip6table_mangle
ip6table_raw ip6table_security iptable_nat nf_nat nf_conntrack
nf_defrag_ipv6 nf_defrag_ipv4 iptable_mangle iptable_raw
iptable_security nf_tables libcrc32c ip6table_filter ip6_tables
iptable_filter cmac algif_hash algif_skcipher af_alg bnep qrtr_mhi
vfat fat amd_atl intel_rapl_msr intel_rapl_common amdgpu
snd_soc_ps_mach snd_soc_dmic snd_ps_pdm_dma snd_sof_amd_acp63
snd_sof_amd_vangogh snd_sof_amd_rembrandt snd_sof_amd_renoir joydev
snd_sof_amd_acp mousedev snd_sof_pci snd_sof_xtensa_dsp qrtr snd_sof
snd_sof_utils ath11k_pci btusb snd_pci_ps btrtl snd_amd_sdw_acpi
btintel ath11k
[   22.335963]  uvcvideo soundwire_amd btbcm
soundwire_generic_allocation videobuf2_vmalloc snd_hda_codec_realtek
btmtk uvc soundwire_bus qmi_helpers snd_hda_codec_generic
videobuf2_memops snd_hda_scodec_component snd_hda_codec_hdmi
videobuf2_v4l2 amdxcp snd_soc_core drm_exec mac80211 gpu_sched
videodev snd_compress snd_hda_intel drm_buddy ac97_bus hid_multitouch
snd_intel_dspcfg i2c_algo_bit snd_pcm_dmaengine videobuf2_common
snd_intel_sdw_acpi snd_rpl_pci_acp6x think_lmi kvm_amd spd5118
hid_generic drm_suballoc_helper libarc4 bluetooth mc wmi_bmof
firmware_attributes_class snd_hda_codec snd_ctl_led snd_acp_pci
drm_ttm_helper snd_acp_legacy_common snd_hda_core ttm kvm
snd_pci_acp6x snd_hwdep cfg80211 snd_pcm drm_display_helper
thinkpad_acpi snd_pci_acp5x r8169 snd_rn_pci_acp3x snd_timer
sparse_keymap sp5100_tco cec ucsi_acpi snd_acp_config realtek rapl snd
typec_ucsi video i2c_piix4 snd_soc_acpi rfkill mdio_devres psmouse
typec pcspkr amd_pmf thunderbolt snd_pci_acp3x soundcore mhi i2c_smbus
k10temp libphy roles amdtee
[   22.336033]  wmi i2c_hid_acpi amd_sfh i2c_hid platform_profile
amd_pmc mac_hid usbip_host usbip_core i2c_dev sg crypto_user loop
nfnetlink ip_tables x_tables ext4 crc32c_generic crc16 mbcache jbd2
dm_crypt cbc encrypted_keys trusted asn1_encoder tee dm_mod
crct10dif_pclmul crc32_pclmul crc32c_intel polyval_clmulni
polyval_generic ghash_clmulni_intel serio_raw sha512_ssse3 atkbd
sha256_ssse3 libps2 sha1_ssse3 vivaldi_fmap aesni_intel nvme gf128mul
crypto_simd nvme_core cryptd xhci_pci i8042 ccp xhci_pci_renesas
nvme_auth serio
[   22.336077] CPU: 8 UID: 0 PID: 537 Comm: kworker/u64:9 Not tainted
6.11.9-arch1-1 #1 1400000003000000474e55001d863d1de79e869f
[   22.336081] Hardware name: LENOVO 21ME001MUS/21ME001MUS, BIOS
R2LET29W (1.10 ) 09/25/2024
[   22.336083] Workqueue: events_unbound commit_work
[   22.336089] RIP: 0010:dpp3_deferred_update+0x101/0x330 [amdgpu]
[   22.336242] Code: 83 78 e1 00 00 0f b6 90 a8 02 00 00 48 8b 83 70
e1 00 00 8b b0 78 04 00 00 e8 bb bf 11 00 8b 74 24 04 85 f6 0f 84 5d
01 00 00 <0f> 0b 0f b6 83 48 96 00 00 83 e0 f7 88 83 48 96 00 00 a8 01
0f 84
[   22.336244] RSP: 0018:ffff9e9800ce3ba0 EFLAGS: 00010202
[   22.336246] RAX: 0000000000000066 RBX: ffff8b3230d60000 RCX: 00000000000=
00004
[   22.336247] RDX: 0000000000000000 RSI: 0000000000000002 RDI: ffff8b323de=
00000
[   22.336248] RBP: ffff8b3252d80000 R08: ffff9e9800ce3ba4 R09: ffff9e9800c=
e3bd0
[   22.336249] R10: ffff9e9800ce3b48 R11: 0000000000000000 R12: 00000000000=
00000
[   22.336250] R13: ffff8b3252d840a8 R14: ffff8b3252d85f78 R15: ffff8b323f4=
ab800
[   22.336251] FS:  0000000000000000(0000) GS:ffff8b4061e00000(0000)
knlGS:0000000000000000
[   22.336252] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   22.336253] CR2: 000075470cd2ff80 CR3: 0000000dd0822000 CR4: 0000000000f=
50ef0
[   22.336254] PKRU: 55555554
[   22.336255] Call Trace:
[   22.336259]  <TASK>
[   22.336261]  ? dpp3_deferred_update+0x101/0x330 [amdgpu
1400000003000000474e5500c4a6d1c766d8f3ae]
[   22.336383]  ? __warn.cold+0x8e/0xe8
[   22.336387]  ? dpp3_deferred_update+0x101/0x330 [amdgpu
1400000003000000474e5500c4a6d1c766d8f3ae]
[   22.336539]  ? report_bug+0xff/0x140
[   22.336542]  ? handle_bug+0x58/0x90
[   22.336545]  ? exc_invalid_op+0x17/0x70
[   22.336546]  ? asm_exc_invalid_op+0x1a/0x20
[   22.336551]  ? dpp3_deferred_update+0x101/0x330 [amdgpu
1400000003000000474e5500c4a6d1c766d8f3ae]
[   22.336667]  dc_post_update_surfaces_to_stream+0x1b1/0x2b0 [amdgpu
1400000003000000474e5500c4a6d1c766d8f3ae]
[   22.336799]  amdgpu_dm_atomic_commit_tail+0x2c9b/0x3a50 [amdgpu
1400000003000000474e5500c4a6d1c766d8f3ae]
[   22.336959]  commit_tail+0x91/0x130
[   22.336963]  process_one_work+0x17b/0x330
[   22.336968]  worker_thread+0x2ce/0x3f0
[   22.336970]  ? __pfx_worker_thread+0x10/0x10
[   22.336972]  kthread+0xcf/0x100
[   22.336975]  ? __pfx_kthread+0x10/0x10
[   22.336978]  ret_from_fork+0x31/0x50
[   22.336981]  ? __pfx_kthread+0x10/0x10
[   22.336983]  ret_from_fork_asm+0x1a/0x30
[   22.336989]  </TASK>
[   22.336989] ---[ end trace 0000000000000000 ]---


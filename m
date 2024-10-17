Return-Path: <linux-kernel+bounces-370025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4508C9A2613
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 17:06:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91DC0B28DA0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 15:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86F491DED72;
	Thu, 17 Oct 2024 15:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=toralf.foerster@gmx.de header.b="nFvYK+13"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA1E1DE3D3
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 15:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729177534; cv=none; b=m46IDF0N1OizHLyH8GrfBOflGL4jRQLfcGgUzsr67Cv09ed6YoBqf4X4mvq7oKENpz6lBLDoh25HJ7bfF0vR53uxZAVHBu1X6HJLU+rsfAFsuMeYPLoXHw6J8XSitYrsrZmSygFyeytXjmHIMj0iiSzQjrSikOeytf6it4juMhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729177534; c=relaxed/simple;
	bh=csBJ7ycu9hIHpCh3vXXc89zaXph5ymuIlKU+C6Ae5kQ=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=sweXKOCOvc9HOffA+bSsSFics+uqsEgT6RaeTOCNidkYVeBqdwV2BQv6nIoTRPQgWXg85eVSF4g8t0SbhP3a2BmjT+hQML4ZPjHGWuTkagUcToKY9xQjbF4LIEeOt1jjdfVx87QHB8+m1xWwhpA7RDEe2Ds/EKsKXvAs4WdMm2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=toralf.foerster@gmx.de header.b=nFvYK+13; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1729177527; x=1729782327; i=toralf.foerster@gmx.de;
	bh=wA8F1S9ibllx4J9EVK74x0NTQrRxrGP0jGQIhW0ELgw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=nFvYK+13/B1PvSOHvsUvHugqj2P+ohMwKe9ajKHhJin70/y8KzQjZp3cMBmn/cq0
	 +HrBsWENRi4Nmtn9eQbfPvwK//gfySwcVFnQmP9jERsYd+Lyy6dtke+8fsKdnRE82
	 p9ZINHbBcVIIijPuMzd1vttT5OioZhJJ/9+AqI0n+A3mvGGJzT19wbOcw49TCmHoY
	 trYiDDCV9utQ0vSK7xiu0AnR08MDjhaHW+77afBHXescewFqgi+smw+4GRSoPz+O9
	 2ns9e93T5ZNYBED5WbrN3CNkiadQNRe7GUKbnXS7AnaRo4Dj/nQ8XWYvYnqOrjIp+
	 UFfauDPC6Ptq0jjRrg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.178.33] ([77.0.54.39]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MQe9s-1tGNe51kRS-00Ix2w; Thu, 17
 Oct 2024 17:05:27 +0200
Message-ID: <b110ad59-f503-492d-9758-1634c1277b5d@gmx.de>
Date: Thu, 17 Oct 2024 17:05:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: amd-gfx@lists.freedesktop.org
From: =?UTF-8?Q?Toralf_F=C3=B6rster?= <toralf.foerster@gmx.de>
Subject: 6.6.57 has a new WARNING: amdgpu/../display/dc/dcn30/dcn30_dpp.c:501
 dpp3_deferred_update+0x106/0x330 [amdgpu
Autocrypt: addr=toralf.foerster@gmx.de; keydata=
 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
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bNeN24Z1N7cSdA5y7jAFuAsnWoaHZaBL7YMHAO9JsvH/qy+FofZ
 rJSrqjJduhGWRo1xa5rp1AsYN1WJGQMiN0e+wjDhXbzTMgDGzQG8tKR60YoUPabaXK4IdPz
 wXXnsk/JCkJUlo/NQK6HxHc0A8ME5slmxLUf5MtYAVPVZwWzzYS6WkWpW8evj6WHivsdhC5
 zoMR89XtM7ZjGDu4k24MQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:lnMHk+Yvda4=;cFvaiZVBeOqRfohjftgjBSfViLE
 gBjviZxekmUNYeGWYanOckC6HoccMR8j6dWDOotfb9h0Dtea9Tu7xVfqFvihJuv0pe+hyAPGS
 LKllk71O7rJty0N9dc4OnR5gnDdDt701jRe3dInHbxDAnDlMibY37/dtyWoOC3ubRuEfY5jfL
 0Vn1Pf7kCDEmOVBj160BkR4ekt5VowO9i05S0/+6PgQ1HkAq5IFYK5tV1FvzJCUMWSMum933h
 DezOcRS7hbhQzfUVtVc4iAYwYTSWzNGef1beCg10GeJUIYK136oMkFZ205H4JgPo/bn0/ACeG
 OnN6fa9l2Abcy4EvS59NRRrYsgLmwNFoxE/dSUywnmE0hCu3LsOCoT1o7sroFoIwHulmce1AI
 68i2RQa7JTE1dGri5t+tYxikDMvxZG9wLJ3SuPuQTSTTuycAXfrHJXvt5Nbf/UTVmRHiZN9lR
 vRUpuAWCHD99S4MyaqCf1U8Fw6QBPDfcwKk1ej4bVurIDsoBwHBy8BFOq5x74jAioVFM2OohU
 AJ1SS731bBILcb7KdaIGJ37NMVIfvVhoowM7RGMJxEdeVctQKi2EVP5AHJuvNu6tVGcWQf+Zf
 TNWa7V+RId1RM5ApXK/+WhxyaXSLCfQDMXnhZjIF/VG+8odMsUjGDEgqmaar6gonnQyuhlpbV
 yKMi6inJihAalJShM8lsjIOQiIPzeM42lnOvFt/ZOlC+Vlqp4UoMUpZr/DHgPY1I9y1zeNHmp
 5r9d+LLPnP0cV7l2t8K+PDZyXy7Ct1z9wxVcb8hLJCFoQRS3manez6i1BaJnign4Nge9YxL3F
 VFk7E9gYosrm3b/dVqrRs8lQ==

[   22.120385] ------------[ cut here ]------------
[   22.120389] WARNING: CPU: 13 PID: 11 at
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_dpp.c:501
dpp3_deferred_update+0x106/0x330 [amdgpu]
[   22.120484] Modules linked in: fuse michael_mic hid_jabra
ip6table_filter ip6_tables xt_LOG nf_log_syslog xt_recent xt_multiport
xt_limit xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4
iptable_filter xt_comment ip_tables 8021q r8153_ecm cdc_ether usbnet
r8152 mii hid_logitech_hidpp snd_usb_audio snd_usbmidi_lib snd_rawmidi
bnep hid_logitech_dj btusb qrtr_mhi btrtl btintel btbcm btmtk bluetooth
ecdh_generic dm_crypt trusted asn1_encoder uvcvideo videobuf2_vmalloc
videobuf2_memops uvc videobuf2_v4l2 videodev videobuf2_common mc qrtr
ath11k_pci mhi snd_ctl_led ath11k amdgpu snd_hda_codec_realtek
qmi_helpers snd_hda_codec_generic snd_hda_codec_hdmi snd_hda_intel
i2c_algo_bit snd_intel_dspcfg drm_ttm_helper ttm hid_multitouch
snd_hda_codec agpgart drm_exec intel_rapl_msr hid_generic
drm_suballoc_helper snd_hwdep amdxcp think_lmi mac80211 wmi_bmof
firmware_attributes_class drm_buddy snd_hda_core libarc4 thinkpad_acpi
snd_pcm gpu_sched snd_pci_acp5x ledtrig_audio drm_display_helper
snd_timer platform_profile
[   22.120565]  snd_rn_pci_acp3x cfg80211 intel_rapl_common
snd_acp_config drm_kms_helper snd xhci_pci edac_mce_amd sp5100_tco video
snd_soc_acpi xhci_pci_renesas kvm_amd kvm irqbypass crct10dif_pclmul
crc32_pclmul crc32c_intel ghash_clmulni_intel rapl serio_raw ucsi_acpi
cec rfkill r8169 i2c_piix4 xhci_hcd ccp soundcore k10temp typec_ucsi
i2c_hid_acpi snd_pci_acp3x i2c_hid roles typec drm wmi amd_pmc acpi_tad
[   22.120606] CPU: 13 PID: 11 Comm: kworker/u32:0 Tainted: G
     T  6.6.57 #12
[   22.120609] Hardware name: LENOVO 21J5002FGE/21J5002FGE, BIOS
R23ET60W (1.30 ) 09/14/2022
[   22.120611] Workqueue: events_unbound commit_work [drm_kms_helper]
[   22.120628] RIP: 0010:dpp3_deferred_update+0x106/0x330 [amdgpu]
[   22.120709] Code: 83 78 e1 00 00 0f b6 90 a7 02 00 00 48 8b 83 70 e1
00 00 8b b0 78 04 00 00 e8 f6 9e 09 00 8b 74 24 04 85 f6 0f 84 5d 01 00
00 <0f> 0b 0f b6 83 48 96 00 00 83 e0 f7 88 83 48 96 00 00 a8 01 0f 84
[   22.120712] RSP: 0018:ffffc900000f7b88 EFLAGS: 00010202
[   22.120714] RAX: 0000000000000066 RBX: ffff888113e60000 RCX:
0000000000000000
[   22.120716] RDX: 0000000000000000 RSI: 0000000000000002 RDI:
0000000000000000
[   22.120717] RBP: 0000000000000000 R08: 0000000000000000 R09:
0000000000000000
[   22.120719] R10: 0000000000000000 R11: 0000000000000000 R12:
ffff88813e100000
[   22.120720] R13: ffff88813e102608 R14: ffff88813e1037e8 R15:
ffff8881050be800
[   22.120722] FS:  0000000000000000(0000) GS:ffff88881ee80000(0000)
knlGS:0000000000000000
[   22.120723] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   22.120725] CR2: 000055d896379fe0 CR3: 0000000017216000 CR4:
0000000000f50ee0
[   22.120727] PKRU: 55555554
[   22.120728] Call Trace:
[   22.120731]  <TASK>
[   22.120733]  ? __warn+0x6f/0xd0
[   22.120739]  ? dpp3_deferred_update+0x106/0x330 [amdgpu]
[   22.120820]  ? report_bug+0x148/0x190
[   22.120825]  ? handle_bug+0x40/0x80
[   22.120828]  ? exc_invalid_op+0x17/0x80
[   22.120830]  ? asm_exc_invalid_op+0x1a/0x20
[   22.120835]  ? dpp3_deferred_update+0x106/0x330 [amdgpu]
[   22.120907]  ? dpp3_deferred_update+0xfa/0x330 [amdgpu]
[   22.120988]  dc_post_update_surfaces_to_stream+0x196/0x1e0 [amdgpu]
[   22.121070]  amdgpu_dm_atomic_commit_tail+0x2a25/0x3950 [amdgpu]
[   22.121166]  ? srso_alias_return_thunk+0x5/0xfbef5
[   22.121169]  ? newidle_balance+0x335/0x3f0
[   22.121173]  ? finish_task_switch.isra.0+0x30/0x280
[   22.121179]  commit_tail+0x8f/0x130 [drm_kms_helper]
[   22.121189]  process_one_work+0x17c/0x2a0
[   22.121192]  worker_thread+0x318/0x460
[   22.121195]  ? rescuer_thread+0x5f0/0x5f0
[   22.121196]  kthread+0xcb/0xf0
[   22.121200]  ? kthread_complete_and_exit+0x20/0x20
[   22.121202]  ret_from_fork+0x2f/0x50
[   22.121206]  ? kthread_complete_and_exit+0x20/0x20
[   22.121208]  ret_from_fork_asm+0x11/0x20
[   22.121212]  </TASK>
[   22.121215] ---[ end trace 0000000000000000 ]---


=2D-
Toralf



Return-Path: <linux-kernel+bounces-367261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7FAA9A0047
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 06:46:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A807B2864CB
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 04:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FDAC18732A;
	Wed, 16 Oct 2024 04:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=preining.info header.i=@preining.info header.b="Pb+IUdRj"
Received: from hz.preining.info (hz.preining.info [95.216.25.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E877A21E3BA
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 04:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.216.25.247
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729053962; cv=none; b=CG5XcPcH41P6oKe3dnN/6aFgsKgUgOugbtlQaIR0Z9ORDYGsEsqSmge8vQSDd3IXCaAnGzpZEFfbpXoHclC4cGOm61ZHQ1gGbZyV53jlvdvkudpsq+mOY6+KGqQJk8sj1BeL45D4tkzQ79KTTSfPC1iIcoJUDBmZ6grf99a92KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729053962; c=relaxed/simple;
	bh=2OvgtKKJdmfZ2JFKs79om0uELk6w4jzX7hwCLE99I70=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=AHPoBwmOamkn7VJSR9XFoz6JMHvDeDR1H5okRhbuiO4fLV0raB9ruhtKGmaKakkhEgnoTLLAstOCFRfuP+2QCQYXLB0gHup4bteMuXLrFsEm0TbJZn9v6tse9txeA2CJ/KcmPA8Joo69GZ0yTBimJjrrP/tTOzH4hoqKMxgNiQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=preining.info; spf=pass smtp.mailfrom=preining.info; dkim=pass (2048-bit key) header.d=preining.info header.i=@preining.info header.b=Pb+IUdRj; arc=none smtp.client-ip=95.216.25.247
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=preining.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=preining.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=preining.info; s=201909; h=Content-Type:MIME-Version:Message-ID:Subject:To:
	From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=WRvG431BGAx6cBamINXa0BxuzU16aIJ6OCdTVcQuxv0=; b=Pb+IUdRjVnrDiDhKrpeR2XddhG
	ZG2urCllnDNS3AYHohwMmiadu3B6FwGDAW1vJ9T7Y6/5tS27YtcQo8z9V7VUbNNQKbeYUCEbMgy0R
	T1Ko5m59lWRF1+fl7s/OWGGvKGcfihcKVKe3fajxzYWk6ayI1UNoYFTUtWxssdrbhd7j43eKG4+5g
	O52n94Dwb53U33LFSv+M3XOm+d+HIqJlSbWIBKtSP3xhMF/qYMKMPS28uHDJkS0Z8NMS3LsOtzWLT
	xW0pOWkznN31Xjf1u8NGEK9HPjrg7W2g8kfFbnm9WKRw5jzQ4byDxAauQWDfMyLrAH7BchuCbg7J6
	x2LZu6iw==;
Received: from tvk215040.tvk.ne.jp ([180.94.215.40] helo=burischnitzel.preining.info)
	by hz.preining.info with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <norbert@preining.info>)
	id 1t0vMF-00B772-0w
	for linux-kernel@vger.kernel.org;
	Wed, 16 Oct 2024 04:09:59 +0000
Received: by burischnitzel.preining.info (Postfix, from userid 1000)
	id 23947164376B; Wed, 16 Oct 2024 13:09:54 +0900 (JST)
Date: Wed, 16 Oct 2024 13:09:54 +0900
From: Norbert Preining <norbert@preining.info>
To: linux-kernel@vger.kernel.org
Subject: Ops/kernel bug in swapops and more on 6.11.3
Message-ID: <Zw88ksaaQbPL51Qb@burischnitzel>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="i56kqW4ISUQUQyOH"
Content-Disposition: inline


--i56kqW4ISUQUQyOH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all

(please cc)

I got a rather strange kernelbug related to memory(?) etc.

Hardware: Lenovo ThinkPad X1 Carbon Gen 10, model 21CBCTO1WW
OS: Arch Linux
Kernel: linux-zen as distributed by Arch, 6.11.3-zen1-1-zen

Not sure I can reproduce it, I was working in PyCharm on some
programming tasks. The PyCharm IDE frooze completely, but the rest
somehow worked, at least I could capture the logs and shut down.

Output of journalctl from when the ops happened is attached.

(please cc)

Best regards

Norbert


--
PREINING Norbert                              https://www.preining.info
arXiv / Cornell University   +   IFMGA Guide   +   TU Wien  +  TeX Live
GPG: 0x860CDC13   fp: F7D8 A928 26E3 16A1 9FA0 ACF0 6CAC A448 860C DC13

--i56kqW4ISUQUQyOH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="kernel-bug.log"
Content-Transfer-Encoding: quoted-printable

[53447.193177] BUG: Bad page state in process kswapd0  pfn:63986a
[53447.193193] page: refcount:0 mapcount:1 mapping:0000000000000000 index:0=
x70d06a pfn:0x63986a
[53447.193200] flags: 0x2ffff8000040018(uptodate|dirty|swapbacked|node=3D0|=
zone=3D2|lastcpupid=3D0x1ffff)
[53447.193211] raw: 02ffff8000040018 dead000000000100 dead000000000122 0000=
000000000000
[53447.193214] raw: 000000000070d06a 0000000000000000 0000000000000000 0000=
000000000000
[53447.193215] page dumped because: nonzero mapcount
[53447.193217] Modules linked in: snd_seq_dummy snd_hrtimer snd_seq snd_seq=
_device nf_tables bnep tun btusb btrtl btintel btbcm btmtk bluetooth i2c_lj=
ca gpio_ljca joydev hid_sensor_custom_intel_hinge hid_sensor_trigger indust=
rialio_triggered_buffer kfifo_buf hid_sensor_iio_common industrialio snd_ct=
l_led snd_soc_skl_hda_dsp snd_soc_hdac_hdmi hid_sensor_custom snd_soc_intel=
_hda_dsp_common snd_sof_probes hid_sensor_hub hid_multitouch hid_generic in=
tel_ishtp_hid snd_hda_codec_hdmi snd_hda_codec_realtek snd_hda_codec_generi=
c snd_hda_scodec_component snd_soc_dmic snd_sof_pci_intel_tgl snd_sof_pci_i=
ntel_cnl snd_sof_intel_hda_generic soundwire_intel soundwire_cadence snd_so=
f_intel_hda_common snd_sof_intel_hda_mlink snd_sof_intel_hda vfat fat snd_s=
of_pci snd_sof_xtensa_dsp snd_sof snd_sof_utils snd_soc_hdac_hda snd_soc_ac=
pi_intel_match soundwire_generic_allocation snd_soc_acpi soundwire_bus ext4=
 iwlmvm intel_uncore_frequency snd_soc_avs intel_uncore_frequency_common cr=
c16 snd_soc_hda_codec mbcache intel_tcc_cooling ntfs3 jbd2
[53447.193293]  x86_pkg_temp_thermal snd_hda_ext_core intel_powerclamp mac8=
0211 coretemp snd_soc_core snd_compress ac97_bus kvm_intel snd_pcm_dmaengin=
e libarc4 ptp mousedev snd_hda_intel pps_core snd_intel_dspcfg intel_ipu6_i=
sys snd_intel_sdw_acpi kvm videobuf2_dma_contig processor_thermal_device_pc=
i snd_hda_codec processor_thermal_device videobuf2_memops iTCO_wdt videobuf=
2_v4l2 processor_thermal_wt_hint iwlwifi snd_hda_core intel_pmc_bxt process=
or_thermal_rfim spi_nor videobuf2_common iTCO_vendor_support rapl intel_lps=
s_pci snd_hwdep mei_wdt think_lmi ucsi_acpi mei_hdcp processor_thermal_rapl=
 mei_pxp intel_rapl_msr intel_cstate i2c_i801 intel_uncore psmouse pcspkr m=
td intel_rapl_common snd_pcm typec_ucsi intel_lpss firmware_attributes_clas=
s mei_me wmi_bmof intel_ish_ipc processor_thermal_wt_req cfg80211 i2c_smbus=
 thunderbolt mei snd_timer idma64 i2c_mux typec intel_ishtp intel_ipu6 proc=
essor_thermal_power_floor igen6_edac ipu_bridge processor_thermal_mbox ov27=
40 roles intel_skl_int3472_tps68470 v4l2_fwnode nxp_nci_i2c
[53447.193372]  tps68470_regulator v4l2_async nxp_nci int3403_thermal intel=
_pmc_core mei_vsc_hw clk_tps68470 soc_button_array int340x_thermal_zone nci=
 videodev i2c_hid_acpi intel_vsec nfc i2c_hid mc int3400_thermal pmt_teleme=
try intel_hid intel_skl_int3472_discrete pinctrl_tigerlake acpi_tad pmt_cla=
ss acpi_pad acpi_thermal_rel mac_hid i2c_dev corefreqk(OE) sg crypto_user l=
oop nfnetlink ip_tables x_tables btrfs blake2b_generic libcrc32c crc32c_gen=
eric xor raid6_pq dm_crypt cbc encrypted_keys trusted asn1_encoder tee dm_m=
od xe drm_ttm_helper gpu_sched drm_suballoc_helper drm_gpuvm drm_exec spi_l=
jca usb_ljca i915 crct10dif_pclmul crc32_pclmul crc32c_intel i2c_algo_bit p=
olyval_clmulni polyval_generic serio_raw drm_buddy ghash_clmulni_intel thin=
kpad_acpi ttm sha512_ssse3 atkbd sha256_ssse3 intel_gtt libps2 sparse_keyma=
p sha1_ssse3 nvme vivaldi_fmap platform_profile aesni_intel drm_display_hel=
per snd nvme_core gf128mul crypto_simd soundcore spi_intel_pci cryptd xhci_=
pci rfkill spi_intel nvme_auth cec i8042 xhci_pci_renesas
[53447.193461]  video serio wmi
[53447.193470] CPU: 6 UID: 0 PID: 163 Comm: kswapd0 Tainted: G           OE=
      6.11.3-zen1-1-zen #1 1400000003000000474e5500d4154c511b9cdca1
[53447.193478] Tainted: [O]=3DOOT_MODULE, [E]=3DUNSIGNED_MODULE
[53447.193480] Hardware name: LENOVO 21CBCTO1WW/21CBCTO1WW, BIOS N3AET82W (=
1.47 ) 06/25/2024
[53447.193483] Call Trace:
[53447.193488]  <TASK>
[53447.193494]  dump_stack_lvl+0x5d/0x80
[53447.193504]  bad_page.cold+0x7a/0x91
[53447.193510]  free_page_is_bad+0xc4/0xd0
[53447.193514]  free_unref_page+0x18a/0x330
[53447.193520]  split_huge_page_to_list_to_order+0xb6d/0x11c0
[53447.193529]  deferred_split_scan+0x205/0x300
[53447.193533]  do_shrink_slab+0x13e/0x350
[53447.193538]  shrink_slab+0x2bb/0x3b0
[53447.193542]  shrink_one+0x100/0x1e0
[53447.193549]  shrink_node+0xa43/0xcf0
[53447.193553]  kswapd+0x7df/0xef0
[53447.193556]  ? psi_task_switch+0xe2/0x2d0
[53447.193563]  ? finish_task_switch.isra.0+0x99/0x2e0
[53447.193568]  ? __pfx_kswapd+0x10/0x10
[53447.193571]  kthread+0xcf/0x100
[53447.193577]  ? __pfx_kthread+0x10/0x10
[53447.193581]  ret_from_fork+0x31/0x50
[53447.193588]  ? __pfx_kthread+0x10/0x10
[53447.193592]  ret_from_fork_asm+0x1a/0x30
[53447.193598]  </TASK>
[53447.193600] Disabling lock debugging due to kernel taint
[53518.703290] ------------[ cut here ]------------
[53518.703296] kernel BUG at include/linux/swapops.h:508!
[53518.703310] Oops: invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
[53518.703319] CPU: 6 UID: 1000 PID: 37165 Comm: Notification Th Tainted: G=
    B      OE      6.11.3-zen1-1-zen #1 1400000003000000474e5500d4154c511b9=
cdca1
[53518.703330] Tainted: [B]=3DBAD_PAGE, [O]=3DOOT_MODULE, [E]=3DUNSIGNED_MO=
DULE
[53518.703332] Hardware name: LENOVO 21CBCTO1WW/21CBCTO1WW, BIOS N3AET82W (=
1.47 ) 06/25/2024
[53518.703335] RIP: 0010:zap_pte_range+0x10ea/0x12b0
[53518.703346] Code: 3d 01 00 ff ff 0f 8c 28 fe ff ff 85 c0 0f 89 20 fe ff =
ff 48 8b 3c 24 48 89 e9 4c 89 e2 4c 89 ee e8 5b cd ff ff e9 09 fe ff ff <0f=
> 0b 31 c0 48 87 03 49 89 c4 41 83 fe 01 0f 84 8e 01 00 00 41 8d
[53518.703350] RSP: 0018:ffff9e70a9ce7708 EFLAGS: 00010246
[53518.703357] RAX: ffffd4c918e63a80 RBX: ffff88b9a174c350 RCX: 00000000000=
00000
[53518.703361] RDX: 0000000000000000 RSI: ffff88b97b0e3000 RDI: ffffd4c918e=
63a80
[53518.703364] RBP: 0000000000000000 R08: ffffd4c918e61a40 R09: 00000000000=
00011
[53518.703367] R10: ffffd4c918e61a40 R11: ffff88bdd8d158f8 R12: c7ffefff38c=
e2a02
[53518.703369] R13: 000000070d06a000 R14: 00000000fffffffd R15: ffff9e70a9c=
e7940
[53518.703373] FS:  0000000000000000(0000) GS:ffff88bdff300000(0000) knlGS:=
0000000000000000
[53518.703377] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[53518.703380] CR2: 000078353ea00990 CR3: 000000000ac22000 CR4: 0000000000f=
50ef0
[53518.703383] PKRU: 55555554
[53518.703386] Call Trace:
[53518.703389]  <TASK>
[53518.703392]  ? __die_body.cold+0x8/0x12
[53518.703402]  ? die+0x2e/0x50
[53518.703409]  ? do_trap+0xca/0x110
[53518.703414]  ? zap_pte_range+0x10ea/0x12b0
[53518.703420]  ? exc_invalid_op+0x92/0xc0
[53518.703424]  ? zap_pte_range+0x10ea/0x12b0
[53518.703429]  ? asm_exc_invalid_op+0x1a/0x20
[53518.703436]  ? zap_pte_range+0x10ea/0x12b0
[53518.703442]  ? zap_pte_range+0xcee/0x12b0
[53518.703448]  unmap_page_range+0x3f2/0xbd0
[53518.703456]  unmap_vmas+0x12d/0x280
[53518.703462]  ? lru_add_fn+0x224/0x420
[53518.703468]  exit_mmap+0xf6/0x430
[53518.703475]  mmput+0x5f/0x140
[53518.703480]  do_exit+0x2d1/0xb60
[53518.703486]  do_group_exit+0x30/0x80
[53518.703491]  get_signal+0x893/0x930
[53518.703495]  ? futex_wait+0x79/0x120
[53518.703500]  arch_do_signal_or_restart+0x3f/0x260
[53518.703506]  syscall_exit_to_user_mode+0x1a4/0x1e0
[53518.703511]  do_syscall_64+0x8e/0x190
[53518.703515]  ? update_cfs_rq_load_avg+0x29/0x1c0
[53518.703520]  ? __cgroup_account_cputime+0x2f/0x50
[53518.703525]  ? sched_clock+0x10/0x30
[53518.703529]  ? sched_clock_cpu+0xb/0x30
[53518.703533]  ? psi_group_change+0x173/0x360
[53518.703538]  ? psi_task_switch+0xe2/0x2d0
[53518.703543]  ? finish_task_switch.isra.0+0x99/0x2e0
[53518.703546]  ? __schedule+0x40a/0x1a70
[53518.703550]  ? futex_unqueue+0x51/0x80
[53518.703554]  ? dequeue_signal+0x57/0x4c0
[53518.703559]  ? get_signal+0x7d2/0x930
[53518.703562]  ? futex_wait+0x79/0x120
[53518.703566]  ? __rseq_handle_notify_resume+0x23f/0x510
[53518.703570]  ? arch_do_signal_or_restart+0x3f/0x260
[53518.703574]  ? switch_fpu_return+0x4e/0xd0
[53518.703577]  ? syscall_exit_to_user_mode+0x14e/0x1e0
[53518.703581]  ? do_syscall_64+0x8e/0x190
[53518.703585]  ? syscall_exit_to_user_mode+0x14e/0x1e0
[53518.703587]  ? do_syscall_64+0x8e/0x190
[53518.703592]  ? do_syscall_64+0x8e/0x190
[53518.703595]  ? exc_page_fault+0x81/0x190
[53518.703598]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[53518.703602] RIP: 0033:0x783632c7ba19
[53518.703650] Code: Unable to access opcode bytes at 0x783632c7b9ef.
[53518.703652] RSP: 002b:00007835fe9f8b20 EFLAGS: 00000246 ORIG_RAX: 000000=
00000000ca
[53518.703657] RAX: fffffffffffffe00 RBX: 0000000000000000 RCX: 0000783632c=
7ba19
[53518.703660] RDX: 0000000000000000 RSI: 0000000000000189 RDI: 00007836327=
2c118
[53518.703662] RBP: 00007835fe9f8b50 R08: 0000000000000000 R09: 00000000fff=
fffff
[53518.703664] R10: 0000000000000000 R11: 0000000000000246 R12: 00000000000=
00000
[53518.703666] R13: 0000000000000000 R14: 0000000000000000 R15: 00007836327=
2c118
[53518.703671]  </TASK>
[53518.703672] Modules linked in: snd_seq_dummy snd_hrtimer snd_seq snd_seq=
_device nf_tables bnep tun btusb btrtl btintel btbcm btmtk bluetooth i2c_lj=
ca gpio_ljca joydev hid_sensor_custom_intel_hinge hid_sensor_trigger indust=
rialio_triggered_buffer kfifo_buf hid_sensor_iio_common industrialio snd_ct=
l_led snd_soc_skl_hda_dsp snd_soc_hdac_hdmi hid_sensor_custom snd_soc_intel=
_hda_dsp_common snd_sof_probes hid_sensor_hub hid_multitouch hid_generic in=
tel_ishtp_hid snd_hda_codec_hdmi snd_hda_codec_realtek snd_hda_codec_generi=
c snd_hda_scodec_component snd_soc_dmic snd_sof_pci_intel_tgl snd_sof_pci_i=
ntel_cnl snd_sof_intel_hda_generic soundwire_intel soundwire_cadence snd_so=
f_intel_hda_common snd_sof_intel_hda_mlink snd_sof_intel_hda vfat fat snd_s=
of_pci snd_sof_xtensa_dsp snd_sof snd_sof_utils snd_soc_hdac_hda snd_soc_ac=
pi_intel_match soundwire_generic_allocation snd_soc_acpi soundwire_bus ext4=
 iwlmvm intel_uncore_frequency snd_soc_avs intel_uncore_frequency_common cr=
c16 snd_soc_hda_codec mbcache intel_tcc_cooling ntfs3 jbd2
[53518.703743]  x86_pkg_temp_thermal snd_hda_ext_core intel_powerclamp mac8=
0211 coretemp snd_soc_core snd_compress ac97_bus kvm_intel snd_pcm_dmaengin=
e libarc4 ptp mousedev snd_hda_intel pps_core snd_intel_dspcfg intel_ipu6_i=
sys snd_intel_sdw_acpi kvm videobuf2_dma_contig processor_thermal_device_pc=
i snd_hda_codec processor_thermal_device videobuf2_memops iTCO_wdt videobuf=
2_v4l2 processor_thermal_wt_hint iwlwifi snd_hda_core intel_pmc_bxt process=
or_thermal_rfim spi_nor videobuf2_common iTCO_vendor_support rapl intel_lps=
s_pci snd_hwdep mei_wdt think_lmi ucsi_acpi mei_hdcp processor_thermal_rapl=
 mei_pxp intel_rapl_msr intel_cstate i2c_i801 intel_uncore psmouse pcspkr m=
td intel_rapl_common snd_pcm typec_ucsi intel_lpss firmware_attributes_clas=
s mei_me wmi_bmof intel_ish_ipc processor_thermal_wt_req cfg80211 i2c_smbus=
 thunderbolt mei snd_timer idma64 i2c_mux typec intel_ishtp intel_ipu6 proc=
essor_thermal_power_floor igen6_edac ipu_bridge processor_thermal_mbox ov27=
40 roles intel_skl_int3472_tps68470 v4l2_fwnode nxp_nci_i2c
[53518.703821]  tps68470_regulator v4l2_async nxp_nci int3403_thermal intel=
_pmc_core mei_vsc_hw clk_tps68470 soc_button_array int340x_thermal_zone nci=
 videodev i2c_hid_acpi intel_vsec nfc i2c_hid mc int3400_thermal pmt_teleme=
try intel_hid intel_skl_int3472_discrete pinctrl_tigerlake acpi_tad pmt_cla=
ss acpi_pad acpi_thermal_rel mac_hid i2c_dev corefreqk(OE) sg crypto_user l=
oop nfnetlink ip_tables x_tables btrfs blake2b_generic libcrc32c crc32c_gen=
eric xor raid6_pq dm_crypt cbc encrypted_keys trusted asn1_encoder tee dm_m=
od xe drm_ttm_helper gpu_sched drm_suballoc_helper drm_gpuvm drm_exec spi_l=
jca usb_ljca i915 crct10dif_pclmul crc32_pclmul crc32c_intel i2c_algo_bit p=
olyval_clmulni polyval_generic serio_raw drm_buddy ghash_clmulni_intel thin=
kpad_acpi ttm sha512_ssse3 atkbd sha256_ssse3 intel_gtt libps2 sparse_keyma=
p sha1_ssse3 nvme vivaldi_fmap platform_profile aesni_intel drm_display_hel=
per snd nvme_core gf128mul crypto_simd soundcore spi_intel_pci cryptd xhci_=
pci rfkill spi_intel nvme_auth cec i8042 xhci_pci_renesas
[53518.703910]  video serio wmi
[53518.703968] ---[ end trace 0000000000000000 ]---
[53518.703971] RIP: 0010:zap_pte_range+0x10ea/0x12b0
[53518.703977] Code: 3d 01 00 ff ff 0f 8c 28 fe ff ff 85 c0 0f 89 20 fe ff =
ff 48 8b 3c 24 48 89 e9 4c 89 e2 4c 89 ee e8 5b cd ff ff e9 09 fe ff ff <0f=
> 0b 31 c0 48 87 03 49 89 c4 41 83 fe 01 0f 84 8e 01 00 00 41 8d
[53518.703980] RSP: 0018:ffff9e70a9ce7708 EFLAGS: 00010246
[53518.703983] RAX: ffffd4c918e63a80 RBX: ffff88b9a174c350 RCX: 00000000000=
00000
[53518.703985] RDX: 0000000000000000 RSI: ffff88b97b0e3000 RDI: ffffd4c918e=
63a80
[53518.703987] RBP: 0000000000000000 R08: ffffd4c918e61a40 R09: 00000000000=
00011
[53518.703989] R10: ffffd4c918e61a40 R11: ffff88bdd8d158f8 R12: c7ffefff38c=
e2a02
[53518.703991] R13: 000000070d06a000 R14: 00000000fffffffd R15: ffff9e70a9c=
e7940
[53518.703994] FS:  0000000000000000(0000) GS:ffff88bdff300000(0000) knlGS:=
0000000000000000
[53518.703996] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[53518.703999] CR2: 000078353ea00990 CR3: 000000000ac22000 CR4: 0000000000f=
50ef0
[53518.704001] PKRU: 55555554
[53518.704003] note: Notification Th[37165] exited with preempt_count 1
[53518.704006] Fixing recursive fault but reboot is needed!
[53518.704054] BUG: scheduling while atomic: Notification Th/37165/0x000000=
00
[53518.704057] Modules linked in: snd_seq_dummy snd_hrtimer snd_seq snd_seq=
_device nf_tables bnep tun btusb btrtl btintel btbcm btmtk bluetooth i2c_lj=
ca gpio_ljca joydev hid_sensor_custom_intel_hinge hid_sensor_trigger indust=
rialio_triggered_buffer kfifo_buf hid_sensor_iio_common industrialio snd_ct=
l_led snd_soc_skl_hda_dsp snd_soc_hdac_hdmi hid_sensor_custom snd_soc_intel=
_hda_dsp_common snd_sof_probes hid_sensor_hub hid_multitouch hid_generic in=
tel_ishtp_hid snd_hda_codec_hdmi snd_hda_codec_realtek snd_hda_codec_generi=
c snd_hda_scodec_component snd_soc_dmic snd_sof_pci_intel_tgl snd_sof_pci_i=
ntel_cnl snd_sof_intel_hda_generic soundwire_intel soundwire_cadence snd_so=
f_intel_hda_common snd_sof_intel_hda_mlink snd_sof_intel_hda vfat fat snd_s=
of_pci snd_sof_xtensa_dsp snd_sof snd_sof_utils snd_soc_hdac_hda snd_soc_ac=
pi_intel_match soundwire_generic_allocation snd_soc_acpi soundwire_bus ext4=
 iwlmvm intel_uncore_frequency snd_soc_avs intel_uncore_frequency_common cr=
c16 snd_soc_hda_codec mbcache intel_tcc_cooling ntfs3 jbd2
[53518.704100]  x86_pkg_temp_thermal snd_hda_ext_core intel_powerclamp mac8=
0211 coretemp snd_soc_core snd_compress ac97_bus kvm_intel snd_pcm_dmaengin=
e libarc4 ptp mousedev snd_hda_intel pps_core snd_intel_dspcfg intel_ipu6_i=
sys snd_intel_sdw_acpi kvm videobuf2_dma_contig processor_thermal_device_pc=
i snd_hda_codec processor_thermal_device videobuf2_memops iTCO_wdt videobuf=
2_v4l2 processor_thermal_wt_hint iwlwifi snd_hda_core intel_pmc_bxt process=
or_thermal_rfim spi_nor videobuf2_common iTCO_vendor_support rapl intel_lps=
s_pci snd_hwdep mei_wdt think_lmi ucsi_acpi mei_hdcp processor_thermal_rapl=
 mei_pxp intel_rapl_msr intel_cstate i2c_i801 intel_uncore psmouse pcspkr m=
td intel_rapl_common snd_pcm typec_ucsi intel_lpss firmware_attributes_clas=
s mei_me wmi_bmof intel_ish_ipc processor_thermal_wt_req cfg80211 i2c_smbus=
 thunderbolt mei snd_timer idma64 i2c_mux typec intel_ishtp intel_ipu6 proc=
essor_thermal_power_floor igen6_edac ipu_bridge processor_thermal_mbox ov27=
40 roles intel_skl_int3472_tps68470 v4l2_fwnode nxp_nci_i2c
[53518.704150]  tps68470_regulator v4l2_async nxp_nci int3403_thermal intel=
_pmc_core mei_vsc_hw clk_tps68470 soc_button_array int340x_thermal_zone nci=
 videodev i2c_hid_acpi intel_vsec nfc i2c_hid mc int3400_thermal pmt_teleme=
try intel_hid intel_skl_int3472_discrete pinctrl_tigerlake acpi_tad pmt_cla=
ss acpi_pad acpi_thermal_rel mac_hid i2c_dev corefreqk(OE) sg crypto_user l=
oop nfnetlink ip_tables x_tables btrfs blake2b_generic libcrc32c crc32c_gen=
eric xor raid6_pq dm_crypt cbc encrypted_keys trusted asn1_encoder tee dm_m=
od xe drm_ttm_helper gpu_sched drm_suballoc_helper drm_gpuvm drm_exec spi_l=
jca usb_ljca i915 crct10dif_pclmul crc32_pclmul crc32c_intel i2c_algo_bit p=
olyval_clmulni polyval_generic serio_raw drm_buddy ghash_clmulni_intel thin=
kpad_acpi ttm sha512_ssse3 atkbd sha256_ssse3 intel_gtt libps2 sparse_keyma=
p sha1_ssse3 nvme vivaldi_fmap platform_profile aesni_intel drm_display_hel=
per snd nvme_core gf128mul crypto_simd soundcore spi_intel_pci cryptd xhci_=
pci rfkill spi_intel nvme_auth cec i8042 xhci_pci_renesas
[53518.704210]  video serio wmi
[53518.704215] CPU: 6 UID: 1000 PID: 37165 Comm: Notification Th Tainted: G=
    B D    OE      6.11.3-zen1-1-zen #1 1400000003000000474e5500d4154c511b9=
cdca1
[53518.704222] Tainted: [B]=3DBAD_PAGE, [D]=3DDIE, [O]=3DOOT_MODULE, [E]=3D=
UNSIGNED_MODULE
[53518.704223] Hardware name: LENOVO 21CBCTO1WW/21CBCTO1WW, BIOS N3AET82W (=
1.47 ) 06/25/2024
[53518.704225] Call Trace:
[53518.704228]  <TASK>
[53518.704230]  dump_stack_lvl+0x5d/0x80
[53518.704235]  __schedule_bug.cold+0x42/0x4e
[53518.704239]  __schedule+0x1044/0x1a70
[53518.704242]  ? vprintk_emit+0x132/0x320
[53518.704247]  ? zap_pte_range+0x10ea/0x12b0
[53518.704251]  ? _printk+0x6c/0x87
[53518.704254]  ? zap_pte_range+0x10ea/0x12b0
[53518.704257]  do_task_dead+0x42/0x50
[53518.704262]  make_task_dead.cold+0xd9/0xe5
[53518.704267]  rewind_stack_and_make_dead+0x16/0x20
[53518.704271] RIP: 0033:0x783632c7ba19
[53518.704279] Code: Unable to access opcode bytes at 0x783632c7b9ef.
[53518.704281] RSP: 002b:00007835fe9f8b20 EFLAGS: 00000246 ORIG_RAX: 000000=
00000000ca
[53518.704284] RAX: fffffffffffffe00 RBX: 0000000000000000 RCX: 0000783632c=
7ba19
[53518.704287] RDX: 0000000000000000 RSI: 0000000000000189 RDI: 00007836327=
2c118
[53518.704289] RBP: 00007835fe9f8b50 R08: 0000000000000000 R09: 00000000fff=
fffff
[53518.704291] R10: 0000000000000000 R11: 0000000000000246 R12: 00000000000=
00000
[53518.704293] R13: 0000000000000000 R14: 0000000000000000 R15: 00007836327=
2c118
[53518.704296]  </TASK>
[53518.704298] ------------[ cut here ]------------
[53518.704299] Voluntary context switch within RCU read-side critical secti=
on!
[53518.704303] WARNING: CPU: 6 PID: 37165 at kernel/rcu/tree_plugin.h:330 r=
cu_note_context_switch+0x575/0x5d0
[53518.704311] Modules linked in: snd_seq_dummy snd_hrtimer snd_seq snd_seq=
_device nf_tables bnep tun btusb btrtl btintel btbcm btmtk bluetooth i2c_lj=
ca gpio_ljca joydev hid_sensor_custom_intel_hinge hid_sensor_trigger indust=
rialio_triggered_buffer kfifo_buf hid_sensor_iio_common industrialio snd_ct=
l_led snd_soc_skl_hda_dsp snd_soc_hdac_hdmi hid_sensor_custom snd_soc_intel=
_hda_dsp_common snd_sof_probes hid_sensor_hub hid_multitouch hid_generic in=
tel_ishtp_hid snd_hda_codec_hdmi snd_hda_codec_realtek snd_hda_codec_generi=
c snd_hda_scodec_component snd_soc_dmic snd_sof_pci_intel_tgl snd_sof_pci_i=
ntel_cnl snd_sof_intel_hda_generic soundwire_intel soundwire_cadence snd_so=
f_intel_hda_common snd_sof_intel_hda_mlink snd_sof_intel_hda vfat fat snd_s=
of_pci snd_sof_xtensa_dsp snd_sof snd_sof_utils snd_soc_hdac_hda snd_soc_ac=
pi_intel_match soundwire_generic_allocation snd_soc_acpi soundwire_bus ext4=
 iwlmvm intel_uncore_frequency snd_soc_avs intel_uncore_frequency_common cr=
c16 snd_soc_hda_codec mbcache intel_tcc_cooling ntfs3 jbd2
[53518.704354]  x86_pkg_temp_thermal snd_hda_ext_core intel_powerclamp mac8=
0211 coretemp snd_soc_core snd_compress ac97_bus kvm_intel snd_pcm_dmaengin=
e libarc4 ptp mousedev snd_hda_intel pps_core snd_intel_dspcfg intel_ipu6_i=
sys snd_intel_sdw_acpi kvm videobuf2_dma_contig processor_thermal_device_pc=
i snd_hda_codec processor_thermal_device videobuf2_memops iTCO_wdt videobuf=
2_v4l2 processor_thermal_wt_hint iwlwifi snd_hda_core intel_pmc_bxt process=
or_thermal_rfim spi_nor videobuf2_common iTCO_vendor_support rapl intel_lps=
s_pci snd_hwdep mei_wdt think_lmi ucsi_acpi mei_hdcp processor_thermal_rapl=
 mei_pxp intel_rapl_msr intel_cstate i2c_i801 intel_uncore psmouse pcspkr m=
td intel_rapl_common snd_pcm typec_ucsi intel_lpss firmware_attributes_clas=
s mei_me wmi_bmof intel_ish_ipc processor_thermal_wt_req cfg80211 i2c_smbus=
 thunderbolt mei snd_timer idma64 i2c_mux typec intel_ishtp intel_ipu6 proc=
essor_thermal_power_floor igen6_edac ipu_bridge processor_thermal_mbox ov27=
40 roles intel_skl_int3472_tps68470 v4l2_fwnode nxp_nci_i2c
[53518.704403]  tps68470_regulator v4l2_async nxp_nci int3403_thermal intel=
_pmc_core mei_vsc_hw clk_tps68470 soc_button_array int340x_thermal_zone nci=
 videodev i2c_hid_acpi intel_vsec nfc i2c_hid mc int3400_thermal pmt_teleme=
try intel_hid intel_skl_int3472_discrete pinctrl_tigerlake acpi_tad pmt_cla=
ss acpi_pad acpi_thermal_rel mac_hid i2c_dev corefreqk(OE) sg crypto_user l=
oop nfnetlink ip_tables x_tables btrfs blake2b_generic libcrc32c crc32c_gen=
eric xor raid6_pq dm_crypt cbc encrypted_keys trusted asn1_encoder tee dm_m=
od xe drm_ttm_helper gpu_sched drm_suballoc_helper drm_gpuvm drm_exec spi_l=
jca usb_ljca i915 crct10dif_pclmul crc32_pclmul crc32c_intel i2c_algo_bit p=
olyval_clmulni polyval_generic serio_raw drm_buddy ghash_clmulni_intel thin=
kpad_acpi ttm sha512_ssse3 atkbd sha256_ssse3 intel_gtt libps2 sparse_keyma=
p sha1_ssse3 nvme vivaldi_fmap platform_profile aesni_intel drm_display_hel=
per snd nvme_core gf128mul crypto_simd soundcore spi_intel_pci cryptd xhci_=
pci rfkill spi_intel nvme_auth cec i8042 xhci_pci_renesas
[53518.704461]  video serio wmi
[53518.704466] CPU: 6 UID: 1000 PID: 37165 Comm: Notification Th Tainted: G=
    B D W  OE      6.11.3-zen1-1-zen #1 1400000003000000474e5500d4154c511b9=
cdca1
[53518.704472] Tainted: [B]=3DBAD_PAGE, [D]=3DDIE, [W]=3DWARN, [O]=3DOOT_MO=
DULE, [E]=3DUNSIGNED_MODULE
[53518.704473] Hardware name: LENOVO 21CBCTO1WW/21CBCTO1WW, BIOS N3AET82W (=
1.47 ) 06/25/2024
[53518.704475] RIP: 0010:rcu_note_context_switch+0x575/0x5d0
[53518.704480] Code: ff 49 89 8d a8 00 00 00 e9 f0 fc ff ff 45 85 ff 75 ef =
e9 e6 fc ff ff 48 c7 c7 e8 bd 67 b9 c6 05 51 93 22 02 01 e8 eb 28 f2 ff <0f=
> 0b e9 d6 fa ff ff c6 45 11 00 48 8b 75 20 ba 01 00 00 00 48 8b
[53518.704483] RSP: 0018:ffff9e70a9ce7e18 EFLAGS: 00010082
[53518.704486] RAX: 0000000000000000 RBX: ffff88bb48ffa380 RCX: 00000000000=
00027
[53518.704488] RDX: ffff88bdff321a48 RSI: 0000000000000001 RDI: ffff88bdff3=
21a40
[53518.704490] RBP: ffff88bdff337740 R08: ffff88be1f778868 R09: 00000000fff=
fdfff
[53518.704492] R10: 0000000000000003 R11: 0000000000000001 R12: 00000000000=
00000
[53518.704494] R13: ffff88bb48ffa380 R14: ffff9e70a9ce7658 R15: ffffffffb7f=
f80ba
[53518.704496] FS:  0000000000000000(0000) GS:ffff88bdff300000(0000) knlGS:=
0000000000000000
[53518.704498] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[53518.704500] CR2: 000078353ea00990 CR3: 000000000ac22000 CR4: 0000000000f=
50ef0
[53518.704503] PKRU: 55555554
[53518.704504] Call Trace:
[53518.704506]  <TASK>
[53518.704507]  ? rcu_note_context_switch+0x575/0x5d0
[53518.704512]  ? __warn.cold+0x8e/0xf5
[53518.704516]  ? rcu_note_context_switch+0x575/0x5d0
[53518.704520]  ? report_bug+0xe7/0x210
[53518.704523]  ? handle_bug+0x3c/0x80
[53518.704526]  ? exc_invalid_op+0x19/0xc0
[53518.704530]  ? asm_exc_invalid_op+0x1a/0x20
[53518.704533]  ? zap_pte_range+0x10ea/0x12b0
[53518.704537]  ? rcu_note_context_switch+0x575/0x5d0
[53518.704542]  ? rcu_note_context_switch+0x575/0x5d0
[53518.704546]  ? zap_pte_range+0x10ea/0x12b0
[53518.704549]  __schedule+0xaa/0x1a70
[53518.704552]  ? vprintk_emit+0x132/0x320
[53518.704556]  ? zap_pte_range+0x10ea/0x12b0
[53518.704559]  ? _printk+0x6c/0x87
[53518.704562]  ? zap_pte_range+0x10ea/0x12b0
[53518.704565]  do_task_dead+0x42/0x50
[53518.704570]  make_task_dead.cold+0xd9/0xe5
[53518.704574]  rewind_stack_and_make_dead+0x16/0x20
[53518.704577] RIP: 0033:0x783632c7ba19
[53518.704583] Code: Unable to access opcode bytes at 0x783632c7b9ef.
[53518.704585] RSP: 002b:00007835fe9f8b20 EFLAGS: 00000246 ORIG_RAX: 000000=
00000000ca
[53518.704588] RAX: fffffffffffffe00 RBX: 0000000000000000 RCX: 0000783632c=
7ba19
[53518.704590] RDX: 0000000000000000 RSI: 0000000000000189 RDI: 00007836327=
2c118
[53518.704592] RBP: 00007835fe9f8b50 R08: 0000000000000000 R09: 00000000fff=
fffff
[53518.704593] R10: 0000000000000000 R11: 0000000000000246 R12: 00000000000=
00000
[53518.704595] R13: 0000000000000000 R14: 0000000000000000 R15: 00007836327=
2c118
[53518.704599]  </TASK>
[53518.704600] ---[ end trace 0000000000000000 ]---
[53578.706964] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[53578.707009] rcu: 	Tasks blocked on level-1 rcu_node (CPUs 0-9): P37165/1=
:b..l
[53578.707026] rcu: 	(detected by 0, t=3D60002 jiffies, g=3D1546357, q=3D96=
752 ncpus=3D20)
[53579.438107] rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tas=
ks: { P37165 } 60730 jiffies s: 1821 root: 0x1/.
[53579.438138] rcu: blocking rcu_node structures (internal RCU debug): l=3D=
1:0-9:0x0/T

--i56kqW4ISUQUQyOH--


Return-Path: <linux-kernel+bounces-211959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03E9290596A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 19:02:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86344B27E3A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 17:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0A84181D06;
	Wed, 12 Jun 2024 17:01:20 +0000 (UTC)
Received: from smtp232.sjtu.edu.cn (smtp232.sjtu.edu.cn [202.120.2.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34828181317
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 17:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.120.2.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718211679; cv=none; b=doHMupj6uBonFjFsK0XYjKd6oOISU38hMMHB8qi1duO8U+gp4qSrmhNx6wJXmPnZgoVQ2KZ5jM4sUhe2fiABjsuGMi3F3fuA8p2XiE926+DWBXnj/akdfn3Mhe+4KS2WBk0MdB2QEQkPptR6oYbXS9eb2gmJtCvchiEZso7weW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718211679; c=relaxed/simple;
	bh=Nstmz9rtt8OLXGPYlhx8od7aibn/CD1o05enNke08EE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dSiCrR/lvYFf8LkqyzzuQ8DjhQ/Ta3dgUsgSEzAKluihH0Wn2peuVkKUNgFkUrvn+Ru+3qcWDXboH9UvfIMrIsoUK5L5Fii0Rx9NEtC6B61l2XbhW6CuyTFoT7H98pUfzKHtZm4/ADqbOMJlcZAxy49LX+xaM/NO94uXeJLagnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sjtu.edu.cn; spf=pass smtp.mailfrom=sjtu.edu.cn; arc=none smtp.client-ip=202.120.2.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sjtu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sjtu.edu.cn
Received: from proxy188.sjtu.edu.cn (smtp188.sjtu.edu.cn [202.120.2.188])
	by smtp232.sjtu.edu.cn (Postfix) with ESMTPS id C768B1008BEA1;
	Thu, 13 Jun 2024 00:55:50 +0800 (CST)
Received: from [192.168.1.120] (unknown [59.78.30.29])
	by proxy188.sjtu.edu.cn (Postfix) with ESMTPSA id 4320437C91F;
	Thu, 13 Jun 2024 00:55:43 +0800 (CST)
Message-ID: <44dc1df5f5a1b740b76d1efbf607c49f9d50dda0.camel@sjtu.edu.cn>
Subject: Re: [bug report] drm/amdgpu: amdgpu crash on playing videos, linux
 6.10-rc
From: Wang Yunchen <mac-wang@sjtu.edu.cn>
To: Linux regressions mailing list <regressions@lists.linux.dev>, Winston Ma
	 <winstonhyypia@gmail.com>
Cc: Felix.Kuehling@amd.com, Xinhui.Pan@amd.com, alexander.deucher@amd.com, 
	amd-gfx@lists.freedesktop.org, christian.koenig@amd.com, LKML
	 <linux-kernel@vger.kernel.org>
Date: Thu, 13 Jun 2024 00:55:41 +0800
In-Reply-To: <4ce90767-7d85-47b0-9187-4eb8d257e7e0@leemhuis.info>
References: 
	<CAMOvFfkQscju1spNKHmEC_Rut+2=qfhKGZSvGhCk_nd5VhuDkg@mail.gmail.com>
	 <4ce90767-7d85-47b0-9187-4eb8d257e7e0@leemhuis.info>
Organization: Shanghai Jiao Tong University
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-06-12 at 15:14 +0200, Linux regression tracking (Thorsten Leem=
huis) wrote:
> On 06.06.24 05:06, Winston Ma wrote:
> > Hi I got the same problem on Linux Kernel 6.10-rc2. I got the problem b=
y
> > following the procedure below:
> >=20
> > =C2=A01. Boot Linux Kernel 6.10-rc2
> > =C2=A02. Open Firefox (Any browser should work)
> > =C2=A03. Open a Youtube Video
> > =C2=A04. On the playing video, toggle fullscreen quickly Then after 10-=
20
> > =C2=A0=C2=A0=C2=A0 times of fullscreen toggling, the screen would enter=
 freeze mode.
> > =C2=A0=C2=A0=C2=A0 This is the log that I captured using the above meth=
od.
>=20
> Hmm, seems nothing happened here for a while. Could you maybe try to
> bisect this
> (https://docs.kernel.org/admin-guide/verify-bugs-and-bisect-regressions.h=
tml
> )?
>=20
> @amd-gfx devs: Or is this unneeded, as the cause found or maybe even
> fixed meanwhile?
>=20
> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> --
> Everything you wanna know about Linux kernel regression tracking:
> https://linux-regtracking.leemhuis.info/about/#tldr
> If I did something stupid, please tell me, as explained on that page.
>=20
> #regzbot poke
>=20
> > This is the kernel log
> >=20
> > 2024-06-06T10:26:40.747576+08:00 kernel: gmc_v10_0_process_interrupt: 6=
 callbacks suppressed
> > 2024-06-06T10:26:40.747618+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: [=
mmhub] page fault (src_id:0 ring:8 vmid:2
> > pasid:32789)
> > 2024-06-06T10:26:40.747623+08:00 kernel: amdgpu 0000:03:00.0: amdgpu:=
=C2=A0 in process RDD Process pid 39524 thread
> > firefox-bi:cs0 pid 40342
> > 2024-06-06T10:26:40.747625+08:00 kernel: amdgpu 0000:03:00.0: amdgpu:=
=C2=A0=C2=A0 in page starting at address
> > 0x0000800106ffe000 from client 0x12 (VMC)
> > 2024-06-06T10:26:40.747628+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: M=
MVM_L2_PROTECTION_FAULT_STATUS:0x00203811
> > 2024-06-06T10:26:40.747629+08:00 kernel: amdgpu 0000:03:00.0: amdgpu:=
=C2=A0	 Faulty UTCL2 client ID: VCN (0x1c)
> > 2024-06-06T10:26:40.747631+08:00 kernel: amdgpu 0000:03:00.0: amdgpu:=
=C2=A0	 MORE_FAULTS: 0x1
> > 2024-06-06T10:26:40.747651+08:00 kernel: amdgpu 0000:03:00.0: amdgpu:=
=C2=A0	 WALKER_ERROR: 0x0
> > 2024-06-06T10:26:40.747653+08:00 kernel: amdgpu 0000:03:00.0: amdgpu:=
=C2=A0	 PERMISSION_FAULTS: 0x1
> > 2024-06-06T10:26:40.747655+08:00 kernel: amdgpu 0000:03:00.0: amdgpu:=
=C2=A0	 MAPPING_ERROR: 0x0
> > 2024-06-06T10:26:40.747656+08:00 kernel: amdgpu 0000:03:00.0: amdgpu:=
=C2=A0	 RW: 0x0
> > 2024-06-06T10:26:40.747658+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: [=
mmhub] page fault (src_id:0 ring:8 vmid:2
> > pasid:32789)
> > 2024-06-06T10:26:40.747660+08:00 kernel: amdgpu 0000:03:00.0: amdgpu:=
=C2=A0 in process RDD Process pid 39524 thread
> > firefox-bi:cs0 pid 40342
> > 2024-06-06T10:26:40.747662+08:00 kernel: amdgpu 0000:03:00.0: amdgpu:=
=C2=A0=C2=A0 in page starting at address
> > 0x0000800106e00000 from client 0x12 (VMC)
> > 2024-06-06T10:26:40.747663+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: M=
MVM_L2_PROTECTION_FAULT_STATUS:0x00000000
> > 2024-06-06T10:26:40.747664+08:00 kernel: amdgpu 0000:03:00.0: amdgpu:=
=C2=A0	 Faulty UTCL2 client ID: MP0 (0x0)
> > 2024-06-06T10:26:40.747666+08:00 kernel: amdgpu 0000:03:00.0: amdgpu:=
=C2=A0	 MORE_FAULTS: 0x0
> > 2024-06-06T10:26:40.747667+08:00 kernel: amdgpu 0000:03:00.0: amdgpu:=
=C2=A0	 WALKER_ERROR: 0x0
> > 2024-06-06T10:26:40.747668+08:00 kernel: amdgpu 0000:03:00.0: amdgpu:=
=C2=A0	 PERMISSION_FAULTS: 0x0
> > 2024-06-06T10:26:40.747670+08:00 kernel: amdgpu 0000:03:00.0: amdgpu:=
=C2=A0	 MAPPING_ERROR: 0x0
> > 2024-06-06T10:26:40.747671+08:00 kernel: amdgpu 0000:03:00.0: amdgpu:=
=C2=A0	 RW: 0x0
> > 2024-06-06T10:26:40.747674+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: [=
mmhub] page fault (src_id:0 ring:8 vmid:2
> > pasid:32789)
> > 2024-06-06T10:26:40.747677+08:00 kernel: amdgpu 0000:03:00.0: amdgpu:=
=C2=A0 in process RDD Process pid 39524 thread
> > firefox-bi:cs0 pid 40342
> > 2024-06-06T10:26:40.747680+08:00 kernel: amdgpu 0000:03:00.0: amdgpu:=
=C2=A0=C2=A0 in page starting at address
> > 0x0000800106e07000 from client 0x12 (VMC)
> > 2024-06-06T10:26:40.747683+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: M=
MVM_L2_PROTECTION_FAULT_STATUS:0x00000000
> > 2024-06-06T10:26:40.747686+08:00 kernel: amdgpu 0000:03:00.0: amdgpu:=
=C2=A0	 Faulty UTCL2 client ID: MP0 (0x0)
> > 2024-06-06T10:26:40.747688+08:00 kernel: amdgpu 0000:03:00.0: amdgpu:=
=C2=A0	 MORE_FAULTS: 0x0
> > 2024-06-06T10:26:40.747691+08:00 kernel: amdgpu 0000:03:00.0: amdgpu:=
=C2=A0	 WALKER_ERROR: 0x0
> > 2024-06-06T10:26:40.747693+08:00 kernel: amdgpu 0000:03:00.0: amdgpu:=
=C2=A0	 PERMISSION_FAULTS: 0x0
> > 2024-06-06T10:26:40.747696+08:00 kernel: amdgpu 0000:03:00.0: amdgpu:=
=C2=A0	 MAPPING_ERROR: 0x0
> > 2024-06-06T10:26:40.747698+08:00 kernel: amdgpu 0000:03:00.0: amdgpu:=
=C2=A0	 RW: 0x0
> > 2024-06-06T10:26:40.747700+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: [=
mmhub] page fault (src_id:0 ring:8 vmid:2
> > pasid:32789)
> > 2024-06-06T10:26:40.747703+08:00 kernel: amdgpu 0000:03:00.0: amdgpu:=
=C2=A0 in process RDD Process pid 39524 thread
> > firefox-bi:cs0 pid 40342
> > 2024-06-06T10:26:40.747705+08:00 kernel: amdgpu 0000:03:00.0: amdgpu:=
=C2=A0=C2=A0 in page starting at address
> > 0x0000800107001000 from client 0x12 (VMC)
> > 2024-06-06T10:26:40.747707+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: M=
MVM_L2_PROTECTION_FAULT_STATUS:0x00000000
> > 2024-06-06T10:26:40.747710+08:00 kernel: amdgpu 0000:03:00.0: amdgpu:=
=C2=A0	 Faulty UTCL2 client ID: MP0 (0x0)
> > 2024-06-06T10:26:40.747713+08:00 kernel: amdgpu 0000:03:00.0: amdgpu:=
=C2=A0	 MORE_FAULTS: 0x0
> > 2024-06-06T10:26:40.747716+08:00 kernel: amdgpu 0000:03:00.0: amdgpu:=
=C2=A0	 WALKER_ERROR: 0x0
> > 2024-06-06T10:26:40.747718+08:00 kernel: amdgpu 0000:03:00.0: amdgpu:=
=C2=A0	 PERMISSION_FAULTS: 0x0
> > 2024-06-06T10:26:40.747721+08:00 kernel: amdgpu 0000:03:00.0: amdgpu:=
=C2=A0	 MAPPING_ERROR: 0x0
> > 2024-06-06T10:26:40.747723+08:00 kernel: amdgpu 0000:03:00.0: amdgpu:=
=C2=A0	 RW: 0x0
> > 2024-06-06T10:26:51.094991+08:00 kernel: [drm:amdgpu_job_timedout [amdg=
pu]] *ERROR* ring vcn_dec_0 timeout,
> > signaled seq=3D24897, emitted seq=3D24898
> > 2024-06-06T10:26:51.095023+08:00 kernel: [drm:amdgpu_job_timedout [amdg=
pu]] *ERROR* Process information: process
> > RDD Process pid 39524 thread firefox-bi:cs0 pid 40342
> > 2024-06-06T10:26:51.095025+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: G=
PU reset begin!
> > 2024-06-06T10:26:52.305509+08:00 kernel: [drm] Register(0) [mmUVD_POWER=
_STATUS] failed to reach value 0x00000001
> > !=3D 0x00000002n
> > 2024-06-06T10:26:52.586019+08:00 kernel: [drm] Register(0) [mmUVD_RBC_R=
B_RPTR] failed to reach value 0x000003c0 !=3D
> > 0x00000360n
> > 2024-06-06T10:26:52.639506+08:00 kernel: [drm] Register(0) [mmUVD_POWER=
_STATUS] failed to reach value 0x00000001
> > !=3D 0x00000002n
> > 2024-06-06T10:26:52.639521+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: M=
ODE2 reset
> > 2024-06-06T10:26:52.650614+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: G=
PU reset succeeded, trying to resume
> > 2024-06-06T10:26:52.650633+08:00 kernel: [drm] PCIE GART of 1024M enabl=
ed (table at 0x000000F41FC00000).
> > 2024-06-06T10:26:52.650637+08:00 kernel: [drm] VRAM is lost due to GPU =
reset!
> > 2024-06-06T10:26:52.650641+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: P=
SP is resuming...
> > 2024-06-06T10:26:52.673474+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: r=
eserve 0xa00000 from 0xf41e000000 for PSP
> > TMR
> > 2024-06-06T10:26:53.001513+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: R=
AS: optional ras ta ucode is not available
> > 2024-06-06T10:26:53.013802+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: R=
AP: optional rap ta ucode is not available
> > 2024-06-06T10:26:53.013816+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: S=
ECUREDISPLAY: securedisplay ta ucode is not
> > available
> > 2024-06-06T10:26:53.013819+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: S=
MU is resuming...
> > 2024-06-06T10:26:53.016519+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: S=
MU is resumed successfully!
> > 2024-06-06T10:26:53.017502+08:00 kernel: [drm] DMUB hardware initialize=
d: version=3D0x04000044
> > 2024-06-06T10:26:53.677511+08:00 kernel: [drm] kiq ring mec 2 pipe 1 q =
0
> > 2024-06-06T10:26:53.958512+08:00 kernel: amdgpu 0000:03:00.0: [drm:amdg=
pu_ring_test_helper [amdgpu]] *ERROR* ring
> > vcn_dec_0 test failed (-110)
> > 2024-06-06T10:26:53.958536+08:00 kernel: [drm:amdgpu_device_ip_resume_p=
hase2 [amdgpu]] *ERROR* resume of IP block
> > <vcn_v3_0> failed -110
> > 2024-06-06T10:26:53.958539+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: G=
PU reset(1) failed
> > 2024-06-06T10:26:53.958541+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: G=
PU reset end with ret =3D -110
> > 2024-06-06T10:26:53.959180+08:00 kernel: [drm:amdgpu_job_timedout [amdg=
pu]] *ERROR* GPU Recovery Failed: -110
> > 2024-06-06T10:26:55.261509+08:00 kernel: [drm] Register(0) [mmUVD_POWER=
_STATUS] failed to reach value 0x00000001
> > !=3D 0x00000002n
> > 2024-06-06T10:26:55.540507+08:00 kernel: [drm] Register(0) [mmUVD_RBC_R=
B_RPTR] failed to reach value 0x00000010 !=3D
> > 0x00000000n
> > 2024-06-06T10:27:04.407149+08:00 kernel: [drm] Register(0) [mmUVD_POWER=
_STATUS] failed to reach value 0x00000001
> > !=3D 0x00000002n
> > 2024-06-06T10:27:04.407252+08:00 kernel: [drm:amdgpu_job_timedout [amdg=
pu]] *ERROR* ring vcn_dec_0 timeout,
> > signaled seq=3D24898, emitted seq=3D24898
> > 2024-06-06T10:27:04.407257+08:00 kernel: [drm:amdgpu_job_timedout [amdg=
pu]] *ERROR* Process information: process
> > RDD Process pid 39524 thread firefox-bi:cs0 pid 40342
> > 2024-06-06T10:27:04.407259+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: G=
PU reset begin!
> > 2024-06-06T10:27:05.033745+08:00 kernel: ------------[ cut here ]------=
------
> > 2024-06-06T10:27:05.033773+08:00 kernel: WARNING: CPU: 8 PID: 47039 at =
drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:630
> > amdgpu_irq_put+0x9c/0xb0 [amdgpu]
> > 2024-06-06T10:27:05.033777+08:00 kernel: Modules linked in: nft_reject_=
inet nf_reject_ipv4 nf_reject_ipv6
> > nft_reject xt_conntrack nft_chain_nat xt_MASQUERADE nf_nat nf_conntrack=
_netlink nf_conntrack nf_defrag_ipv6
> > nf_defrag_ipv4 xt_addrtype nft_compat nf_tables libcrc32c br_netfilter =
bridge stp llc hid_logitech_hidpp usbhid
> > xfrm_interface xfrm6_tunnel tunnel4 tunnel6 xfrm_user xfrm_algo uhid rf=
comm snd_seq_dummy snd_hrtimer cmac
> > algif_hash algif_skcipher af_alg overlay qrtr bnep binfmt_misc uvcvideo=
 videobuf2_vmalloc uvc videobuf2_memops
> > videobuf2_v4l2 btusb btrtl videodev btintel btbcm snd_acp6x_pdm_dma snd=
_soc_dmic snd_soc_acp6x_mach amd_atl
> > intel_rapl_msr btmtk videobuf2_common bluetooth mc intel_rapl_common sn=
d_sof_amd_acp63 snd_sof_amd_vangogh
> > snd_sof_amd_rembrandt iwlmvm snd_sof_amd_renoir snd_sof_amd_acp snd_sof=
_pci snd_sof_xtensa_dsp amdgpu snd_sof
> > edac_mce_amd mac80211 snd_sof_utils snd_pci_ps snd_hda_codec_realtek sn=
d_amd_sdw_acpi kvm_amd soundwire_amd
> > snd_hda_codec_generic soundwire_generic_allocation soundwire_bus
> > 2024-06-06T10:27:05.033782+08:00 kernel:=C2=A0 snd_hda_scodec_cs35l41_s=
pi nls_iso8859_1 snd_hda_codec_hdmi
> > snd_hda_scodec_component libarc4 kvm snd_soc_core snd_hda_intel snd_ctl=
_led snd_intel_dspcfg snd_compress
> > snd_intel_sdw_acpi amdxcp snd_seq_midi ac97_bus crct10dif_pclmul drm_ex=
ec snd_hda_codec polyval_clmulni
> > snd_pcm_dmaengine snd_seq_midi_event gpu_sched polyval_generic iwlwifi =
ghash_clmulni_intel snd_rpl_pci_acp6x
> > drm_buddy sha256_ssse3 snd_hda_core snd_rawmidi snd_acp_pci drm_suballo=
c_helper snd_hda_scodec_cs35l41_i2c
> > sha1_ssse3 drm_ttm_helper snd_acp_legacy_common snd_hwdep snd_hda_scode=
c_cs35l41 aesni_intel snd_pci_acp6x amd_pmf
> > snd_hda_cs_dsp_ctls ttm crypto_simd snd_pci_acp5x snd_soc_cs_amp_lib as=
us_nb_wmi cs_dsp cryptd amdtee snd_seq
> > snd_rn_pci_acp3x drm_display_helper snd_pcm asus_wmi snd_acp_config rap=
l wmi_bmof sparse_keymap snd_seq_device
> > cfg80211 snd_soc_cs35l41_lib cec snd_soc_acpi ccp rc_core snd_timer i2c=
_algo_bit i2c_piix4 snd_pci_acp3x k10temp
> > amd_sfh tee snd platform_profile soundcore serial_multi_instantiate amd=
_pmc acpi_tad
> > 2024-06-06T10:27:05.033784+08:00 kernel:=C2=A0 joydev input_leds mac_hi=
d serio_raw parport_pc ppdev lp parport
> > efi_pstore nfnetlink dmi_sysfs ip_tables x_tables autofs4 hid_multitouc=
h nvme video ucsi_acpi hid_generic
> > crc32_pclmul nvme_core typec_ucsi xhci_pci i2c_hid_acpi xhci_pci_renesa=
s nvme_auth typec i2c_hid wmi hid 8250_dw
> > 2024-06-06T10:27:05.033785+08:00 kernel: CPU: 8 PID: 47039 Comm: kworke=
r/u64:0 Tainted: G=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 W=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> > 6.10.0-061000rc2-generic #202406022333
> > 2024-06-06T10:27:05.033787+08:00 kernel: Hardware name: ASUSTeK COMPUTE=
R INC. Zenbook UM5302TA_UM5302TA/UM5302TA,
> > BIOS UM5302TA.311 01/17/2023
> > 2024-06-06T10:27:05.033788+08:00 kernel: Workqueue: amdgpu-reset-dev dr=
m_sched_job_timedout [gpu_sched]
> > 2024-06-06T10:27:05.033789+08:00 kernel: RIP: 0010:amdgpu_irq_put+0x9c/=
0xb0 [amdgpu]
> > 2024-06-06T10:27:05.033790+08:00 kernel: Code: 31 f6 31 ff e9 c0 05 2f =
e6 44 89 e2 48 89 de 4c 89 f7 e8 97 fc ff
> > ff 5b 41 5c 41 5d 41 5e 5d 31 d2 31 f6 31 ff e9 9f 05 2f e6 <0f> 0b b8 =
ea ff ff ff eb c3 b8 fe ff ff ff eb bc 0f
> > 1f 40 00 90 90
> > 2024-06-06T10:27:05.033791+08:00 kernel: RSP: 0018:ffffb65847227c18 EFL=
AGS: 00010246
> > 2024-06-06T10:27:05.033793+08:00 kernel: RAX: 0000000000000000 RBX: fff=
f9ac0a0280c60 RCX: 0000000000000000
> > 2024-06-06T10:27:05.033794+08:00 kernel: RDX: 0000000000000000 RSI: 000=
0000000000000 RDI: 0000000000000000
> > 2024-06-06T10:27:05.033796+08:00 kernel: RBP: ffffb65847227c38 R08: 000=
0000000000000 R09: 0000000000000000
> > 2024-06-06T10:27:05.033797+08:00 kernel: R10: 0000000000000000 R11: 000=
0000000000000 R12: 0000000000000000
> > 2024-06-06T10:27:05.033798+08:00 kernel: R13: 0000000000000001 R14: fff=
f9ac0a0280000 R15: ffff9ac0a0280000
> > 2024-06-06T10:27:05.033799+08:00 kernel: FS:=C2=A0 0000000000000000(000=
0) GS:ffff9ac38e600000(0000)
> > knlGS:0000000000000000
> > 2024-06-06T10:27:05.033800+08:00 kernel: CS:=C2=A0 0010 DS: 0000 ES: 00=
00 CR0: 0000000080050033
> > 2024-06-06T10:27:05.033802+08:00 kernel: CR2: 00007d1a5edfe000 CR3: 000=
000001863c000 CR4: 0000000000f50ef0
> > 2024-06-06T10:27:05.033803+08:00 kernel: PKRU: 55555554
> > 2024-06-06T10:27:05.033805+08:00 kernel: Call Trace:
> > 2024-06-06T10:27:05.033806+08:00 kernel:=C2=A0 <TASK>
> > 2024-06-06T10:27:05.033807+08:00 kernel:=C2=A0 ? show_regs+0x6c/0x80
> > 2024-06-06T10:27:05.033845+08:00 kernel:=C2=A0 ? __warn+0x88/0x140
> > 2024-06-06T10:27:05.034598+08:00 kernel:=C2=A0 ? amdgpu_irq_put+0x9c/0x=
b0 [amdgpu]
> > 2024-06-06T10:27:05.034615+08:00 kernel:=C2=A0 ? report_bug+0x182/0x1b0
> > 2024-06-06T10:27:05.034618+08:00 kernel:=C2=A0 ? handle_bug+0x51/0xa0
> > 2024-06-06T10:27:05.034619+08:00 kernel:=C2=A0 ? exc_invalid_op+0x18/0x=
80
> > 2024-06-06T10:27:05.034620+08:00 kernel:=C2=A0 ? asm_exc_invalid_op+0x1=
b/0x20
> > 2024-06-06T10:27:05.034621+08:00 kernel:=C2=A0 ? amdgpu_irq_put+0x9c/0x=
b0 [amdgpu]
> > 2024-06-06T10:27:05.034623+08:00 kernel:=C2=A0 ? amdgpu_irq_put+0x55/0x=
b0 [amdgpu]
> > 2024-06-06T10:27:05.035573+08:00 kernel:=C2=A0 gmc_v10_0_hw_fini+0x67/0=
xe0 [amdgpu]
> > 2024-06-06T10:27:05.035580+08:00 kernel:=C2=A0 gmc_v10_0_suspend+0xe/0x=
20 [amdgpu]
> > 2024-06-06T10:27:05.035581+08:00 kernel:=C2=A0 amdgpu_device_ip_suspend=
_phase2+0x251/0x480 [amdgpu]
> > 2024-06-06T10:27:05.035582+08:00 kernel:=C2=A0 amdgpu_device_ip_suspend=
+0x49/0x80 [amdgpu]
> > 2024-06-06T10:27:05.036529+08:00 kernel:=C2=A0 amdgpu_device_pre_asic_r=
eset+0xd1/0x490 [amdgpu]
> > 2024-06-06T10:27:05.036546+08:00 kernel:=C2=A0 amdgpu_device_gpu_recove=
r+0x406/0xa30 [amdgpu]
> > 2024-06-06T10:27:05.036548+08:00 kernel:=C2=A0 amdgpu_job_timedout+0x14=
1/0x200 [amdgpu]
> > 2024-06-06T10:27:05.036550+08:00 kernel:=C2=A0 drm_sched_job_timedout+0=
x70/0x110 [gpu_sched]
> > 2024-06-06T10:27:05.036551+08:00 kernel:=C2=A0 process_one_work+0x186/0=
x3e0
> > 2024-06-06T10:27:05.036552+08:00 kernel:=C2=A0 worker_thread+0x304/0x44=
0
> > 2024-06-06T10:27:05.036554+08:00 kernel:=C2=A0 ? srso_alias_return_thun=
k+0x5/0xfbef5
> > 2024-06-06T10:27:05.036555+08:00 kernel:=C2=A0 ? _raw_spin_lock_irqsave=
+0xe/0x20
> > 2024-06-06T10:27:05.036556+08:00 kernel:=C2=A0 ? __pfx_worker_thread+0x=
10/0x10
> > 2024-06-06T10:27:05.036557+08:00 kernel:=C2=A0 kthread+0xe4/0x110
> > 2024-06-06T10:27:05.036558+08:00 kernel:=C2=A0 ? __pfx_kthread+0x10/0x1=
0
> > 2024-06-06T10:27:05.036559+08:00 kernel:=C2=A0 ret_from_fork+0x47/0x70
> > 2024-06-06T10:27:05.036561+08:00 kernel:=C2=A0 ? __pfx_kthread+0x10/0x1=
0
> > 2024-06-06T10:27:05.036562+08:00 kernel:=C2=A0 ret_from_fork_asm+0x1a/0=
x30
> > 2024-06-06T10:27:05.036563+08:00 kernel:=C2=A0 </TASK>
> > 2024-06-06T10:27:05.036564+08:00 kernel: ---[ end trace 000000000000000=
0 ]---
> > 2024-06-06T10:27:05.036565+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: M=
ODE2 reset
> > 2024-06-06T10:27:05.046502+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: G=
PU reset succeeded, trying to resume
> > 2024-06-06T10:27:05.047516+08:00 kernel: [drm] PCIE GART of 1024M enabl=
ed (table at 0x000000F41FC00000).
> > 2024-06-06T10:27:05.047533+08:00 kernel: [drm] VRAM is lost due to GPU =
reset!
> > 2024-06-06T10:27:05.047538+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: P=
SP is resuming...
> > 2024-06-06T10:27:05.070481+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: r=
eserve 0xa00000 from 0xf41e000000 for PSP
> > TMR
> > 2024-06-06T10:27:05.397519+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: R=
AS: optional ras ta ucode is not available
> > 2024-06-06T10:27:05.409509+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: R=
AP: optional rap ta ucode is not available
> > 2024-06-06T10:27:05.409517+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: S=
ECUREDISPLAY: securedisplay ta ucode is not
> > available
> > 2024-06-06T10:27:05.409518+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: S=
MU is resuming...
> > 2024-06-06T10:27:05.411482+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: S=
MU is resumed successfully!
> > 2024-06-06T10:27:05.413504+08:00 kernel: [drm] DMUB hardware initialize=
d: version=3D0x04000044
> > 2024-06-06T10:27:06.055474+08:00 kernel: [drm] kiq ring mec 2 pipe 1 q =
0
> > 2024-06-06T10:27:06.335476+08:00 kernel: amdgpu 0000:03:00.0: [drm:amdg=
pu_ring_test_helper [amdgpu]] *ERROR* ring
> > vcn_dec_0 test failed (-110)
> > 2024-06-06T10:27:06.335495+08:00 kernel: [drm:amdgpu_device_ip_resume_p=
hase2 [amdgpu]] *ERROR* resume of IP block
> > <vcn_v3_0> failed -110
> > 2024-06-06T10:27:06.335498+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: G=
PU reset(2) failed
> > 2024-06-06T10:27:06.335499+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: G=
PU reset end with ret =3D -110
> > 2024-06-06T10:27:06.335631+08:00 kernel: [drm:amdgpu_job_timedout [amdg=
pu]] *ERROR* GPU Recovery Failed: -110
> >=20
Hi Thorsten,

It seems that the issue persists on 6.10 rc3.


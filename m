Return-Path: <linux-kernel+bounces-562123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD8BA61CBC
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 21:31:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F19B5460A00
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 20:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67D391A23B7;
	Fri, 14 Mar 2025 20:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="mdWx8pid"
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F1913F434
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 20:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741984292; cv=none; b=DOkqV7SB26I0WdjryUgjyXd3H9JI+Du/C3WgSIE+noR9v3vYeTgBbNBOaHGHrbAyvYEL/0GE1XThSO9tgmWkmERRXe/TagwK8/Vx4WYm1IgjXCQnCIKLp7IKv0hFBNj1hXPKNt21jOONLS38scPzXsPiHsdZXUMnbVX/1GVM0dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741984292; c=relaxed/simple;
	bh=GS6KWoxcrIqWb27u/UUSX/VjzymRrg6YSfuDTVZY2Uc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sMK0RiVBbIoJYqA/YYmxxVMl0WntRUy2xutJbHMQ72vRl36PnX1Sxoi1rhyO8DJMrGKFPg+fU5N8h5jtLrXfCpa6GTorbiV63auQz2ms7fRjuwFtbSP7X7z1orZI+ZLiG1lQ4CVChhszrDq8ogfwniPQ/4CwJJP5crVwzQ2u50Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=mdWx8pid; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1741984268; x=1742589068; i=spasswolf@web.de;
	bh=rauU860nFp711ZgROm01zC3YyhauBkPOzGb1o3DznzU=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=mdWx8piddP+SwxrhwUTWkQk7my698hf9eLf6pauXhOWozMEuvDfTPGI2RG9lHUFe
	 hqyhie0S6z8HGYaS0+mPLkY1et/9PB1hG04APGbb2WN09OqfLADN7d/Gy3UM6nhUr
	 bcG0rX/iNbLRkbtUMDpbgy7evjNOLq3eE190WAJElXLh6loFDCO+oRyEcykGGQxjx
	 bTP0hqLHHSeXm/Act8rl6ibRLkoOS/LLFlDL0xS8QnciTn4VNgAxhXJh0zmhlfG5e
	 /do+m8KGEuP5wrKYidn31gXrsQjkp1piIkp7TaHEWsM59Et3R7iV7nPP5Dg00/FVB
	 9VKfVsR50qeLxB0/bw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost.localdomain ([95.223.134.88]) by smtp.web.de
 (mrweb006 [213.165.67.108]) with ESMTPSA (Nemesis) id
 1MKM5z-1tdauC2nRH-00J09p; Fri, 14 Mar 2025 21:31:07 +0100
From: Bert Karwatzki <spasswolf@web.de>
To: Olivier Moysan <olivier.moysan@foss.st.com>
Cc: Bert Karwatzki <spasswolf@web.de>,
	Mark Brown <broonie@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: commit d3321a20b511 gives NULL pointer dereference on MSI laptop
Date: Fri, 14 Mar 2025 21:31:02 +0100
Message-ID: <20250314203104.3571-1-spasswolf@web.de>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SMyB1YqmhJ22VtHDVBlzhFDInGKOTNAqgpTdBGDi/IVPZEU2hJs
 wKdKgkm0PNvXFhp6DSyIsQYbkQ8g7pMVzxTjzEIJ7P7WfstfSXc1pSmjJSLVwIatUrAExat
 3UO6wxj7XRlXlT6Lmi1d4HrdM5GqBSTlNLtQkxxLGfbRViELxwxHMjSLy5KwC6KWpYEuHOk
 92Y741f01Hi/6VwiduUGA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:/WjIMZizgRo=;t2fG/hBxrahfoP89Hju8+KinU/b
 IyyL2cWosRHqDUpsVZDWQJfwqEwbyINlz020PMZfAygvknbV78ymC4cEJlTei7z9wEKGtjTjn
 +xFz1hkUzCWRpoCKPq8hNJspZVh8E7SJph/Hg1xBZgf/PdoN/eu2B03v3i4fKR1hdfLF9GwVI
 HOs5i5sNtEbYmdy5B7kAAESK6ChQZO/BR8cF86OGZ7gNbQvO1PxvHDypBxR6Xz6ma9YNtgkIg
 NTW5ib75WyrFd8e5MnZI56WGg7q2GwgtABG1LikYX65PRxU7jUOty/r+YF4dpPTksJckB9D1b
 MizgDJLltYR05CkPm5Dd4jo/HM0ACYRaqbcqRhcBw39O8FtnM4Ny76zt6MtqaInGA6gjC+KpP
 Th1KLPgBFJ6IlwX/EVnJ+Qnj4Qu6SkpoiVYcqffL4uZhylQ1NUPPyxDp1m+hWDP+KPUFoQ8Ay
 3oPwDwhtKf6VbaMN/IUweaW0VVJGFkF/pAfEIY4J3NNSrYEEiEav/WOg1cDYZnE4w0RHCwQ9J
 vunCMm7TQzxFxUBBWLtLdMS4rPoLLcEqh2+F4qIUYzQ38stsy42nUhWMXlR21Yp5GVj4HzQzm
 Cb+0/cwu75byLW9DWWSUxPV4psMhiQvcCWZ1vtPUjBcBdLku2Om86ers5GRKi2vP1NXQmiSyv
 NoFmsGfUh2SIG9ME8ebwrw5H9OcPQbdDcLGPmERYyLEK/TrYngVvbOqCEiO5PoxDHGVW49sQz
 GHeRZ2ZIjCQNap9d1UykSNDlnwHR/aAzM+mj3g7oaxEU8+lh0QkU5zfJiif4PNriH7MM1xhVj
 iC8Ksnd9IqWFf5d8quxF5Dd6cNgH9Z80MUpU8VicpFfMpTu3HC04KDFnwSjSivPN6Pg/V/64w
 QUxludJ5dLHEyhYSQ5cI2KdI3BNjnkTraPGFdGXskvoSrej7l1Zc7+spYWw9jKuUIdz8TZZ9N
 aNKIFNLueZyHZmsrUVWHBC4giGs3CQiQU/evT4NTidyDdNAi0gnrRt+wliww7oSMU8HlPwyVg
 yCx0e5I1EZiEi83uj7Rpf2BJGvqzI363pUil7k83MIuAdi3u1Qd8SYRsy8B48XqOhHithnIyh
 TywGNYBriQy22Iioz8Xw8+7BkqUZRSzdcUYnibImFCrZBEuqICHZ6LOYqch9DiIe4drgpQHu3
 j0opy3BQOZvCUtjzXbOa8CHYthGY2UOFPxYp6qZFc55kaC5vXT66dcyL2yYturCRkF1Yq1P8U
 nglxvR3EpinvOy2ETbApqd4IOpXglcWUvqLIADloQVNXfAWdVqXctogyTjDyaCbrMNAeGjVCI
 5Mg6VyiYVP2hzJTezKE0fkzsvQmEKkd88Cva6OxTZe6smIhfk3icSsbEX7zAAxDt2wIkIAHyY
 PnoO9JlyWJIBiJplrvky++W4Q5Y/MhEmLpvamRnT9D7ESCsvm/CrE6tate+hATAlNBqbNFYtp
 kUhsFNg==

Since next-20250313 I get a NULL pointer dereference on boot. I bisected th=
is to
commit d3321a20b511 ("ASoC: dmic: add regulator support")

[ T1343] BUG: kernel NULL pointer dereference, address: 0000000000000065
[ T1343] #PF: supervisor read access in kernel mode
[ T1343] #PF: error_code(0x0000) - not-present page
[ T1343] PGD 0 P4D 0=20
[ T1343] Oops: Oops: 0000 [#1] PREEMPT_RT SMP NOPTI
[ T1343] CPU: 14 UID: 1000 PID: 1343 Comm: wireplumber Not tainted 6.14.0-r=
c5-bisect-00458-gd3321a20b511 #749
[ T1343] Hardware name: Micro-Star International Co., Ltd. Alpha 15 B5EEK/M=
S-158L, BIOS E158LAMS.107 11/10/2021
[ T1343] RIP: 0010:regulator_enable+0xa/0x70
[ T1343] Code: 4e 9d ff 66 66 2e 0f 1f 84 00 00 00 00 00 66 90 90 90 90 90 =
90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 55 53 48 83 ec 20 <48> 8b 6=
f 78 65 48 8b 1c 25 28 00 00 00 48 89 5c 24 18 48 89 fb 48
[ T1343] RSP: 0018:ffff99f044ad7c58 EFLAGS: 00010282
[ T1343] RAX: ffff8ebe59c10010 RBX: ffff8ebe4a21cde8 RCX: ffff8ebe4740fcd0
[ T1343] RDX: 0000000000000002 RSI: 0000000000000000 RDI: ffffffffffffffed
[ T1343] RBP: ffff8ebe4159ec00 R08: ffffffffc1aca45f R09: 0000000000000001
[ T1343] R10: 00000000ffffffff R11: 0000000000000000 R12: ffffffffc1aca45f
[ T1343] R13: 00000000ffffffff R14: 0000000000000001 R15: 0000000000000001
[ T1343] FS:  00007fcd4ce04c80(0000) GS:ffff8eccee980000(0000) knlGS:000000=
0000000000
[ T1343] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ T1343] CR2: 0000000000000065 CR3: 0000000108782000 CR4: 0000000000750ef0
[ T1343] PKRU: 55555554
[ T1343] Call Trace:
[ T1343]  <TASK>
[ T1343]  ? __die+0x51/0x92
[ T1343]  ? page_fault_oops+0x99/0x210
[ T1343]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1343]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1343]  ? get_nohz_timer_target+0x21/0x140
[ T1343]  ? exc_page_fault+0x367/0x5f0
[ T1343]  ? __remove_hrtimer+0x34/0x90
[ T1343]  ? asm_exc_page_fault+0x26/0x30
[ T1343]  ? regulator_enable+0xa/0x70
[ T1343]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T1343]  dmic_aif_event+0x64/0x80 [snd_soc_dmic]
[ T1343]  dapm_seq_check_event+0xd1/0xe0 [snd_soc_core]
[ T1343]  dapm_seq_run_coalesced+0x111/0x1c0 [snd_soc_core]
[ T1343]  dapm_seq_run+0xa9/0x3a0 [snd_soc_core]
[ T1343]  dapm_power_widgets+0x5fe/0x820 [snd_soc_core]
[ T1343]  ? __wake_up+0x36/0x50
[ T1343]  snd_soc_dapm_stream_event+0xf1/0x140 [snd_soc_core]
[ T1343]  __soc_pcm_prepare+0x54/0xe0 [snd_soc_core]
[ T1343]  soc_pcm_prepare+0x28/0x50 [snd_soc_core]
[ T1343]  snd_pcm_do_prepare+0x28/0x40 [snd_pcm]
[ T1343]  snd_pcm_action_single+0x31/0x80 [snd_pcm]
[ T1343]  snd_pcm_action_nonatomic+0x87/0xa0 [snd_pcm]
[ T1343]  snd_pcm_ioctl+0x26/0x40 [snd_pcm]
[ T1343]  __x64_sys_ioctl+0x92/0xc0
[ T1343]  do_syscall_64+0x5f/0x1a0
[ T1343]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ T1343] RIP: 0033:0x7fcd4d3f58db
[ T1343] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 00 00 =
48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89> c2 3=
d 00 f0 ff ff 77 1c 48 8b 44 24 18 64 48 2b 04 25 28 00 00
[ T1343] RSP: 002b:00007ffdf3e6a610 EFLAGS: 00000246 ORIG_RAX: 000000000000=
0010
[ T1343] RAX: ffffffffffffffda RBX: 000055d98bb878d0 RCX: 00007fcd4d3f58db
[ T1343] RDX: 0000000000000000 RSI: 0000000000004140 RDI: 0000000000000026
[ T1343] RBP: 0000000000000026 R08: 0000000000000000 R09: 0000000000001000
[ T1343] R10: 0000000000000004 R11: 0000000000000246 R12: 00007ffdf3e6adf4
[ T1343] R13: 00007fcd4575ccc0 R14: 00007ffdf3e6a740 R15: 00007ffdf3e6a9b0
[ T1343]  </TASK>
[ T1343] Modules linked in: rfcomm bnep nls_ascii nls_cp437 vfat fat snd_ct=
l_led snd_hda_codec_realtek snd_hda_codec_generic snd_hda_scodec_component =
snd_hda_codec_hdmi btusb btrtl btintel snd_hda_intel btbcm btmtk snd_intel_=
dspcfg snd_hda_codec snd_acp3x_pdm_dma snd_soc_dmic uvcvideo snd_acp3x_rn s=
nd_hwdep bluetooth snd_soc_core snd_hda_core videobuf2_vmalloc videobuf2_me=
mops uvc videobuf2_v4l2 snd_pcm_oss snd_mixer_oss videodev snd_pcm snd_rn_p=
ci_acp3x snd_acp_config videobuf2_common snd_timer msi_wmi snd_soc_acpi ecd=
h_generic ecc mc sparse_keymap wmi_bmof snd edac_mce_amd soundcore k10temp =
ccp snd_pci_acp3x battery ac button joydev hid_sensor_magn_3d hid_sensor_gy=
ro_3d hid_sensor_accel_3d hid_sensor_als hid_sensor_prox hid_sensor_trigger=
 industrialio_triggered_buffer kfifo_buf evdev industrialio amd_pmc hid_sen=
sor_iio_common mt7921e mt7921_common mt792x_lib mt76_connac_lib mt76 mac802=
11 libarc4 cfg80211 rfkill msr fuse nvme_fabrics efi_pstore configfs efivar=
fs autofs4 ext4 mbcache jbd2 usbhid amdgpu amdxcp
[ T1343]  i2c_algo_bit drm_client_lib drm_ttm_helper ttm drm_exec gpu_sched=
 drm_suballoc_helper drm_panel_backlight_quirks hid_sensor_hub cec hid_mult=
itouch mfd_core xhci_pci drm_buddy hid_generic xhci_hcd drm_display_helper =
i2c_hid_acpi psmouse amd_sfh nvme i2c_hid usbcore hid drm_kms_helper serio_=
raw r8169 nvme_core i2c_piix4 i2c_smbus usb_common crc16 i2c_designware_pla=
tform i2c_designware_core
[ T1343] CR2: 0000000000000065
[ T1343] ---[ end trace 0000000000000000 ]---
[ T1343] RIP: 0010:regulator_enable+0xa/0x70
[ T1343] Code: 4e 9d ff 66 66 2e 0f 1f 84 00 00 00 00 00 66 90 90 90 90 90 =
90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 55 53 48 83 ec 20 <48> 8b 6=
f 78 65 48 8b 1c 25 28 00 00 00 48 89 5c 24 18 48 89 fb 48
[ T1343] RSP: 0018:ffff99f044ad7c58 EFLAGS: 00010282
[ T1343] RAX: ffff8ebe59c10010 RBX: ffff8ebe4a21cde8 RCX: ffff8ebe4740fcd0
[ T1343] RDX: 0000000000000002 RSI: 0000000000000000 RDI: ffffffffffffffed
[ T1343] RBP: ffff8ebe4159ec00 R08: ffffffffc1aca45f R09: 0000000000000001
[ T1343] R10: 00000000ffffffff R11: 0000000000000000 R12: ffffffffc1aca45f
[ T1343] R13: 00000000ffffffff R14: 0000000000000001 R15: 0000000000000001
[ T1343] FS:  00007fcd4ce04c80(0000) GS:ffff8eccee980000(0000) knlGS:000000=
0000000000
[ T1343] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ T1343] CR2: 0000000000000065 CR3: 0000000108782000 CR4: 0000000000750ef0
[ T1343] PKRU: 55555554
[ T1343] note: wireplumber[1343] exited with irqs disabled

Hardware MSI Alpha 15 (AMD Ryzen 7 5800H) laptop
$ lspci
00:00.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Renoir/Cezanne Root=
 Complex
00:00.2 IOMMU: Advanced Micro Devices, Inc. [AMD] Renoir/Cezanne IOMMU
00:01.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Renoir PCIe Dummy H=
ost Bridge
00:01.1 PCI bridge: Advanced Micro Devices, Inc. [AMD] Renoir PCIe GPP Brid=
ge
00:02.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Renoir PCIe Dummy H=
ost Bridge
00:02.1 PCI bridge: Advanced Micro Devices, Inc. [AMD] Renoir/Cezanne PCIe =
GPP Bridge
00:02.2 PCI bridge: Advanced Micro Devices, Inc. [AMD] Renoir/Cezanne PCIe =
GPP Bridge
00:02.3 PCI bridge: Advanced Micro Devices, Inc. [AMD] Renoir/Cezanne PCIe =
GPP Bridge
00:02.4 PCI bridge: Advanced Micro Devices, Inc. [AMD] Renoir/Cezanne PCIe =
GPP Bridge
00:08.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Renoir PCIe Dummy H=
ost Bridge
00:08.1 PCI bridge: Advanced Micro Devices, Inc. [AMD] Renoir Internal PCIe=
 GPP Bridge to Bus
00:14.0 SMBus: Advanced Micro Devices, Inc. [AMD] FCH SMBus Controller (rev=
 51)
00:14.3 ISA bridge: Advanced Micro Devices, Inc. [AMD] FCH LPC Bridge (rev =
51)
00:18.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Cezanne Data Fabric=
; Function 0
00:18.1 Host bridge: Advanced Micro Devices, Inc. [AMD] Cezanne Data Fabric=
; Function 1
00:18.2 Host bridge: Advanced Micro Devices, Inc. [AMD] Cezanne Data Fabric=
; Function 2
00:18.3 Host bridge: Advanced Micro Devices, Inc. [AMD] Cezanne Data Fabric=
; Function 3
00:18.4 Host bridge: Advanced Micro Devices, Inc. [AMD] Cezanne Data Fabric=
; Function 4
00:18.5 Host bridge: Advanced Micro Devices, Inc. [AMD] Cezanne Data Fabric=
; Function 5
00:18.6 Host bridge: Advanced Micro Devices, Inc. [AMD] Cezanne Data Fabric=
; Function 6
00:18.7 Host bridge: Advanced Micro Devices, Inc. [AMD] Cezanne Data Fabric=
; Function 7
01:00.0 PCI bridge: Advanced Micro Devices, Inc. [AMD/ATI] Navi 10 XL Upstr=
eam Port of PCI Express Switch (rev c3)
02:00.0 PCI bridge: Advanced Micro Devices, Inc. [AMD/ATI] Navi 10 XL Downs=
tream Port of PCI Express Switch
03:00.0 Display controller: Advanced Micro Devices, Inc. [AMD/ATI] Navi 23 =
[Radeon RX 6600/6600 XT/6600M] (rev c3)
03:00.1 Audio device: Advanced Micro Devices, Inc. [AMD/ATI] Navi 21/23 HDM=
I/DP Audio Controller
04:00.0 Network controller: MEDIATEK Corp. MT7921K (RZ608) Wi-Fi 6E 80MHz
05:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8111/8168/8=
211/8411 PCI Express Gigabit Ethernet Controller (rev 15)
06:00.0 Non-Volatile memory controller: Kingston Technology Company, Inc. K=
C3000/FURY Renegade NVMe SSD [E18] (rev 01)
07:00.0 Non-Volatile memory controller: Micron/Crucial Technology P1 NVMe P=
CIe SSD[Frampton] (rev 03)
08:00.0 VGA compatible controller: Advanced Micro Devices, Inc. [AMD/ATI] C=
ezanne [Radeon Vega Series / Radeon Vega Mobile Series] (rev c5)
08:00.1 Audio device: Advanced Micro Devices, Inc. [AMD/ATI] Renoir Radeon =
High Definition Audio Controller
08:00.2 Encryption controller: Advanced Micro Devices, Inc. [AMD] Family 17=
h (Models 10h-1fh) Platform Security Processor
08:00.3 USB controller: Advanced Micro Devices, Inc. [AMD] Renoir/Cezanne U=
SB 3.1
08:00.4 USB controller: Advanced Micro Devices, Inc. [AMD] Renoir/Cezanne U=
SB 3.1
08:00.5 Multimedia controller: Advanced Micro Devices, Inc. [AMD] ACP/ACP3X=
/ACP6x Audio Coprocessor (rev 01)
08:00.6 Audio device: Advanced Micro Devices, Inc. [AMD] Family 17h/19h/1ah=
 HD Audio Controller
08:00.7 Signal processing controller: Advanced Micro Devices, Inc. [AMD] Se=
nsor Fusion Hub

Bert Karwatzki


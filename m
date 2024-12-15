Return-Path: <linux-kernel+bounces-446520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C22309F2563
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 19:34:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 041E7161647
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 18:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD75E1B85D7;
	Sun, 15 Dec 2024 18:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b6gl/aCV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30DF5F9D6;
	Sun, 15 Dec 2024 18:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734287654; cv=none; b=XtOUgVE1EeKO5ttu8gnoeVqQa6Yvgjc28CTYm7rDdvRBcjNk7+QDxVcebCjG5ApyxwKDkdBU8ym3s7kr9vceY9n1kNkWPb6/qJVrwnT+orzUWdIV4Fxnictd5UqaWR1DzkneDLw8rqaBfRpsY3Lee4bcboVG9mQsAOD3rOTn5Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734287654; c=relaxed/simple;
	bh=7GR7uUXM0Hi4hkrEWcbKTCezznRqJdvESl8lw6uJjjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k3VFEKM+6EUzsZyvrhrR3wPNnUZQD8fHBZIs1sjeOmcBlF8AptpGeDvP5KGKj2TE2feXHWnvm4MNyOSGo9P37x71NV05MYv5czGX9Is6I3YXL5xHAds00Dfax9guzBjDX0kCtlL5hylbQzjl3IA/Nqbjg32xfsGcUP6yFxQXDBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b6gl/aCV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8967C4CECE;
	Sun, 15 Dec 2024 18:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734287654;
	bh=7GR7uUXM0Hi4hkrEWcbKTCezznRqJdvESl8lw6uJjjc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b6gl/aCVXHTpOq2ZDxQu/1RcWt0kGnK2Po53gkrmPCjHzsQkGdTtGMeOEKPUaZGv9
	 nrROXPZNxewQnQYOUevvi571aHnlt1/y5yTMDg+JNPlBuCPS+PcTn7orY01CUdSnhh
	 1sQpaforK43wMipBzRHafPay0GaQ4FHWc8OiUZ5GRYSKoQ8qhwUIfcBXPyZnwxfP31
	 fAEXANBE4152KhJMI223OOCiQougRO4ZzGRhd3cRYWp1WK/T0C5OsW44N+OjmETnLB
	 HBazI6HD2SJjE8c98lfPyxAU0zt6P7qocR2aaylXd4/elvny7mO3zjXjK4vj3QSRaw
	 vwJkcsjH01jxQ==
Date: Sun, 15 Dec 2024 13:34:12 -0500
From: Sasha Levin <sashal@kernel.org>
To: "Christian A. Ehrhardt" <lk@c--e.de>
Cc: linux-kernel@vger.kernel.org,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Prashant Malani <pmalani@chromium.org>,
	Jameson Thies <jthies@google.com>,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Samuel =?utf-8?B?xIxhdm9q?= <samuel@cavoj.net>,
	linux-usb@vger.kernel.org, Kenneth Crudup <kenny@panix.com>
Subject: Re: [PATCH 5/5] usb: typec: ucsi: Clear UCSI_CCI_RESET_COMPLETE
 before reset
Message-ID: <Z18hJM55ED2hYJ6D@lappy>
References: <20240320073927.1641788-1-lk@c--e.de>
 <20240320073927.1641788-6-lk@c--e.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240320073927.1641788-6-lk@c--e.de>

On Wed, Mar 20, 2024 at 08:39:26AM +0100, Christian A. Ehrhardt wrote:
>Check the UCSI_CCI_RESET_COMPLETE complete flag before starting
>another reset. Use a UCSI_SET_NOTIFICATION_ENABLE command to clear
>the flag if it is set.

Hi Christian,

It looks like kernelci is able to trigger the warning added by this
commit:

[   15.988528] WARNING: CPU: 0 PID: 8 at drivers/usb/typec/ucsi/ucsi.c:1377=
 ucsi_reset_ppm+0x1af/0x1c0 [typec_ucsi]
[   15.999924] Modules linked in: snd_sof_pci_intel_cnl snd_sof_intel_hda_g=
eneric snd_sof_intel_hda_common snd_soc_hdac_hda snd_sof_intel_hda_mlink sn=
d_sof_intel_hda snd_sof_pci snd_sof_xtensa_dsp snd_sof snd_sof_utils snd_so=
c_acpi_intel_match snd_soc_acpi snd_soc_acpi_intel_sdca_quirks snd_soc_sdca=
 snd_soc_avs snd_soc_hda_codec snd_hda_ext_core btusb btrtl snd_soc_core in=
tel_pmc_core_pltdrv iTCO_wdt intel_ish_ipc snd_compress btintel btbcm intel=
_pmc_bxt intel_pmc_core btmtk ucsi_acpi bluetooth gsmi wilco_charger wilco_=
ec_telem typec_ucsi intel_vsec pmt_telemetry roles pmt_class i2c_hid_acpi i=
wlmvm x86_pkg_temp_thermal snd_pcm_dmaengine iwlwifi watchdog i2c_hid intel=
_ishtp idma64 rtc_wilco_ec wilco_ec_debugfs uvcvideo processor_thermal_devi=
ce_pci_legacy videobuf2_vmalloc elan_i2c intel_soc_dts_iosf videobuf2_memop=
s uvc videobuf2_v4l2 videobuf2_common processor_thermal_device processor_th=
ermal_wt_hint processor_thermal_rfim processor_thermal_wt_req processor_the=
rmal_power_floor processor_thermal_mbox int3403_thermal
[   16.000010]  int340x_thermal_zone typec memconsole_coreboot memconsole v=
pd_sysfs wilco_ec pinctrl_cannonlake intel_vbtn int3400_thermal wilco_ec_ev=
ents chromeos_pstore coreboot_table acpi_thermal_rel
[   16.120093] CPU: 0 UID: 0 PID: 8 Comm: kworker/0:0 Not tainted 6.13.0-rc=
2 #1
[   16.127972] Hardware name: Dell Inc. Arcada/Arcada, BIOS Google_Arcada.1=
2200.103.0 07/29/2020
Linux debian-bookworm-amd64 6.13.0-rc2 #1 SMP PREEMPT_DYNAMIC Su[   16.1374=
99] Workqueue: events_long ucsi_init_work [typec_ucsi]
[   16.150229] RIP: 0010:ucsi_reset_ppm+0x1af/0x1c0 [typec_ucsi]
[   16.156654] Code: 44 24 04 a9 00 00 00 08 0f 85 36 ff ff ff 4c 89 74 24 =
10 48 8b 05 b1 fe f1 e1 49 39 c4 79 8d bb 92 ff ff ff e9 1b ff ff ff 90 <0f=
> 0b 90 e9 4c ff ff ff e8 74 72 f9 df 0f 1f 40 00 90 90 90 90 90
[   16.177649] RSP: 0018:ffffa62bc0053dd0 EFLAGS: 00010206
[   16.189709] RAX: 0000000008000000 RBX: 0000000000000000 RCX: 00000000000=
00002
[   16.203899] RDX: 00000000fffba9c0 RSI: ffffa62bc0053dd4 RDI: ffff91f6016=
10200
[   16.211860] RBP: ffff91f601610200 R08: 0000000000000400 R09: 00000000000=
00001
[   16.219831] R10: 0000000000000001 R11: 00000000000ee6b2 R12: 00000000fff=
ba9be
[   16.227801] R13: ffff91f6016102c0 R14: ffff91f60006f605 R15: ffff91f6001=
b8000
[   16.235770] FS:  0000000000000000(0000) GS:ffff91f764400000(0000) knlGS:=
0000000000000000
[   16.244810] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   16.251226] CR2: 00007f5bcc93b030 CR3: 000000022542e001 CR4: 00000000003=
706f0
[   16.259195] Call Trace:
[   16.261923]  <TASK>
[   16.264261]  ? __warn+0x84/0x130
[   16.267862]  ? ucsi_reset_ppm+0x1af/0x1c0 [typec_ucsi]
[   16.273600]  ? report_bug+0x164/0x190
[   16.277679]  ? handle_bug+0x54/0x90
[   16.281572]  ? exc_invalid_op+0x17/0x70
[   16.285853]  ? asm_exc_invalid_op+0x1a/0x20
[   16.290523]  ? ucsi_reset_ppm+0x1af/0x1c0 [typec_ucsi]
[   16.296261]  ucsi_init_work+0xaa/0xb20 [typec_ucsi]
[   16.301709]  process_one_work+0x160/0x390
[   16.306185]  worker_thread+0x2a0/0x3b0
[   16.310359]  ? __pfx_worker_thread+0x10/0x10
[   16.315126]  kthread+0xc8/0xf0
[   16.318533]  ? __pfx_kthread+0x10/0x10
[   16.322706]  ret_from_fork+0x2c/0x50
[   16.326687]  ? __pfx_kthread+0x10/0x10
[   16.330869]  ret_from_fork_asm+0x1a/0x30
[   16.335238]  </TASK>

--=20
Thanks,
Sasha


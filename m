Return-Path: <linux-kernel+bounces-178961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 80D118C59D6
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 18:41:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8EA7B20FD2
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 16:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B5D517BB3A;
	Tue, 14 May 2024 16:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="1xm2Sqky"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67CCE5FEE4
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 16:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715704893; cv=none; b=WPoSA14vT5vG8UJjKOtQsERTJfR9eJ9RP5cozAi6xENQ8yhidQMyfaCrfrXTc7vNyEgKEcivRBgG+H956DjTvRjYKQiVkefP2A/5th7iLunEm7jqtP2m9w2sa+tKqU2Gtwa8cq5CeoVx+35tArLTn8Q25mK6l4BUOu0H+I1ScIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715704893; c=relaxed/simple;
	bh=lG1OQJmBcv8tL2oIn052tQh7hAyitXUyQc2gqfMNmA4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=HTHWy30jgkcCOD3FBMktbJQQQuV/Z/pT3EEnDGF8x3dn+vyLM0vOK/7cKR8E60URnkVbPLG9LMffFY1XI4vCRAjpog53VkVdBTqjWSkjegOZ0eQ+DpsKnbBwIyus7n8+zKdyInv1Wp0RWxK9hIvK44z13rMtEOI0aYXEPwPInZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=1xm2Sqky; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1715704889;
	bh=lG1OQJmBcv8tL2oIn052tQh7hAyitXUyQc2gqfMNmA4=;
	h=Date:From:To:Cc:Subject:From;
	b=1xm2SqkyIrAXL2t4Vr0FX1OzEXb206uy/Or2TvRoETGiLiuGIj94wLDoxOOxPCIhZ
	 +hXg3gfVH9jaltOgByzs1B9ixUW86UQCup1CUvXhoogxV6W/36fKB7bcI4lj+iR7CK
	 GA7VMbZSFuxw1Na5bTaI9YgoyLfj3b2rbw8yOdQnJsqHTtUQ6USGZmERvMV+/vIE/0
	 Pg6eUPtFcLG26SjcHJICpTNx1alB90W4KUpoweFoX8f6lZpqE5cBfdnzfPB+HZqsUz
	 isTFxFe6/k7T93JSuu9p9d+UJSUfHYtBf3XGOVKj/kdDH2ggzbqvKJyivaZllTUuFz
	 loJjh8MzLQUgg==
Received: from notapiano (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 7B33637820FA;
	Tue, 14 May 2024 16:41:28 +0000 (UTC)
Date: Tue, 14 May 2024 12:41:26 -0400
From: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
To: regressions@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: [REGRESSION] boot regression on linux-next on sc7180 platforms -
 null pointer dereference on iommu_dma_sync_sg_for_device
Message-ID: <6d0da90d-f405-4b5d-b7f9-238cc9405ebe@notapiano>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi,

KernelCI has identified a new boot regression on linux-next. It affects the
following platforms:
* sc7180-trogdor-kingoftown
* sc7180-trogdor-lazor-limozeen

The regression was introduced in next-20240509, and still affects today's
(next-20240514) release.

The config used was the upstream arm64 defconfig with a config fragment on top
[1].

The following stack traces are produced during boot and a usable shell is never
reached:

[    0.381981] Unable to handle kernel NULL pointer dereference at virtual address 000000000000001c
[    0.381989] Mem abort info:
[    0.381991]   ESR = 0x0000000096000004
[    0.381994]   EC = 0x25: DABT (current EL), IL = 32 bits
[    0.381997]   SET = 0, FnV = 0
[    0.382000]   EA = 0, S1PTW = 0
[    0.382003]   FSC = 0x04: level 0 translation fault
[    0.382006] Data abort info:
[    0.382008]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
[    0.382011]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
[    0.382014]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[    0.382017] [000000000000001c] user address but active_mm is swapper
[    0.382021] Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
[    0.382025] Modules linked in:
[    0.382032] CPU: 4 PID: 68 Comm: kworker/u32:2 Not tainted 6.9.0-next-20240514-dirty #380
[    0.382038] Hardware name: Google Kingoftown (DT)
[    0.382042] Workqueue: async async_run_entry_fn
[    0.382055] pstate: 80400009 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    0.382061] pc : iommu_dma_sync_sg_for_device+0x28/0x100
[    0.382070] lr : __dma_sync_sg_for_device+0x28/0x4c
[    0.382080] sp : ffff800080943740
[    0.382082] x29: ffff800080943740 x28: ffff36ee44280000 x27: ffff36ee40bd7810
[    0.382092] x26: ffff800080943998 x25: ffff36ee44280480 x24: ffffb54600bcf0e8
[    0.382101] x23: ffff36ee40bd7810 x22: 0000000000000001 x21: 0000000000000000
[    0.382110] x20: ffffb54600f3d098 x19: 0000000000000000 x18: ffffb54601c1a210
[    0.382118] x17: 000000040044ffff x16: 0000000000000000 x15: ffff36efb6d95580
[    0.382126] x14: ffff36ee409156c0 x13: 0000000000001797 x12: 0000000000000002
[    0.382134] x11: 0000000000000004 x10: ffff36ee4308b3d8 x9 : ffff36ee44280469
[    0.382143] x8 : ffff36ee4308b304 x7 : 00000000ffffffff x6 : 0000000000000001
[    0.382151] x5 : ffffb5460033a740 x4 : ffffb545ff50375c x3 : 0000000000000001
[    0.382159] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff36ee40bd7810
[    0.382167] Call trace:
[    0.382170]  iommu_dma_sync_sg_for_device+0x28/0x100
[    0.382176]  __dma_sync_sg_for_device+0x28/0x4c
[    0.382183]  spi_transfer_one_message+0x378/0x6e4
[    0.382193]  __spi_pump_transfer_message+0x190/0x4a4
[    0.382199]  __spi_sync+0x2a0/0x3c4
[    0.382205]  spi_sync_locked+0x10/0x1c
[    0.382211]  tpm_tis_spi_transfer_full+0x160/0x2fc
[    0.382217]  tpm_tis_spi_transfer+0x34/0x40
[    0.382221]  tpm_tis_spi_cr50_read_bytes+0x5c/0x90
[    0.382226]  tpm_tis_core_init+0xfc/0x7e0
[    0.382231]  tpm_tis_spi_init+0x54/0x70
[    0.382236]  cr50_spi_probe+0xf4/0x27c
[    0.382241]  tpm_tis_spi_driver_probe+0x34/0x64
[    0.382245]  spi_probe+0x84/0xe4
[    0.382251]  really_probe+0xbc/0x2a0
[    0.382258]  __driver_probe_device+0x78/0x12c
[    0.382264]  driver_probe_device+0x40/0x160
[    0.382269]  __device_attach_driver+0xb8/0x134
[    0.382275]  bus_for_each_drv+0x84/0xe0
[    0.382280]  __device_attach_async_helper+0xac/0xd0
[    0.382286]  async_run_entry_fn+0x34/0xe0
[    0.382291]  process_one_work+0x154/0x298
[    0.382300]  worker_thread+0x304/0x408
[    0.382307]  kthread+0x118/0x11c
[    0.382313]  ret_from_fork+0x10/0x20
[    0.382324] Code: 2a0203f5 2a0303f6 a90363f7 aa0003f7 (b9401c20)
[    0.382328] ---[ end trace 0000000000000000 ]---

[    0.393379] spi_master spi6: will run message pump with realtime priority
[    0.393896] Unable to handle kernel NULL pointer dereference at virtual address 000000000000001c
[    0.393903] Mem abort info:
[    0.393905]   ESR = 0x0000000096000004
[    0.393908]   EC = 0x25: DABT (current EL), IL = 32 bits
[    0.393912]   SET = 0, FnV = 0
[    0.393915]   EA = 0, S1PTW = 0
[    0.393917]   FSC = 0x04: level 0 translation fault
[    0.393920] Data abort info:
[    0.393922]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
[    0.393925]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
[    0.393928]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[    0.393931] [000000000000001c] user address but active_mm is swapper
[    0.393935] Internal error: Oops: 0000000096000004 [#2] PREEMPT SMP
[    0.393939] Modules linked in:
[    0.393946] CPU: 2 PID: 103 Comm: cros_ec_spi_hig Tainted: G      D            6.9.0-next-20240514-dirty #380
[    0.393953] Hardware name: Google Kingoftown (DT)
[    0.393956] pstate: 80400009 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    0.393962] pc : iommu_dma_sync_sg_for_device+0x28/0x100
[    0.393975] lr : __dma_sync_sg_for_device+0x28/0x4c
[    0.393985] sp : ffff800080de3aa0
[    0.393988] x29: ffff800080de3aa0 x28: ffff36ee44281800 x27: ffff36ee40ff8010
[    0.393997] x26: ffff800080de3cf8 x25: ffff36ee44281c80 x24: ffffb54600bcf0e8
[    0.394006] x23: ffff36ee40ff8010 x22: 0000000000000001 x21: 0000000000000000
[    0.394014] x20: ffffb54600f3d3d8 x19: 0000000000000000 x18: ffffb54601c1a210
[    0.394023] x17: 0000000000010108 x16: 0000000000000000 x15: 000000000000000c
[    0.394031] x14: 0000000000000000 x13: ffff36ee40b962b0 x12: 0000000000000000
[    0.394039] x11: 0000000000000000 x10: 0000000000003fff x9 : ffff36ee44281c69
[    0.394047] x8 : ffff36ee4103e704 x7 : 00000000ffffffff x6 : 0000000000000001
[    0.394055] x5 : ffffb5460033a740 x4 : ffffb545ff50375c x3 : 0000000000000001
[    0.394063] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff36ee40ff8010
[    0.394071] Call trace:
[    0.394074]  iommu_dma_sync_sg_for_device+0x28/0x100
[    0.394081]  __dma_sync_sg_for_device+0x28/0x4c
[    0.394088]  spi_transfer_one_message+0x378/0x6e4
[    0.394096]  __spi_pump_transfer_message+0x190/0x4a4
[    0.394103]  __spi_sync+0x2a0/0x3c4
[    0.394109]  spi_sync_locked+0x10/0x1c
[    0.394115]  do_cros_ec_pkt_xfer_spi+0x108/0x530
[    0.394122]  cros_ec_xfer_high_pri_work+0x20/0x34
[    0.394127]  kthread_worker_fn+0xcc/0x184
[    0.394134]  kthread+0x118/0x11c
[    0.394140]  ret_from_fork+0x10/0x20
[    0.394150] Code: 2a0203f5 2a0303f6 a90363f7 aa0003f7 (b9401c20)
[    0.394154] ---[ end trace 0000000000000000 ]---

[    3.654117] Unable to handle kernel NULL pointer dereference at virtual address 000000000000001c
[    3.663154] Mem abort info:
[    3.666032]   ESR = 0x0000000096000004
[    3.669943]   EC = 0x25: DABT (current EL), IL = 32 bits
[    3.675417]   SET = 0, FnV = 0
[    3.678563]   EA = 0, S1PTW = 0
[    3.681792]   FSC = 0x04: level 0 translation fault
[    3.686808] Data abort info:
[    3.689765]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
[    3.695399]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
[    3.700592]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[    3.706050] [000000000000001c] user address but active_mm is swapper
[    3.712576] Internal error: Oops: 0000000096000004 [#3] PREEMPT SMP
[    3.719017] Modules linked in:
[    3.722162] CPU: 6 PID: 11 Comm: kworker/u32:0 Tainted: G      D            6.9.0-next-20240514-dirty #380
[    3.732067] Hardware name: Google Kingoftown (DT)
[    3.736904] Workqueue: events_unbound deferred_probe_work_func
[    3.742907] pstate: 80400009 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    3.750052] pc : iommu_dma_sync_sg_for_device+0x28/0x100
[    3.755526] lr : __dma_sync_sg_for_device+0x28/0x4c
[    3.760548] sp : ffff8000800ab0b0
[    3.763953] x29: ffff8000800ab0b0 x28: ffff36ee43a6a000 x27: ffff36ee41012010
[    3.771279] x26: ffff8000800ab2e8 x25: ffff36ee43a6a480 x24: ffffb54600bcf0e8
[    3.778604] x23: ffff36ee41012010 x22: 0000000000000001 x21: 0000000000000000
[    3.785928] x20: ffffb54600f3d718 x19: 0000000000000000 x18: ffffb54601c19c48
[    3.793258] x17: 0000000000010108 x16: 0000000000000000 x15: 000000000000000c
[    3.800589] x14: 0000000000000000 x13: ffff36ee40b962b0 x12: 0000000000000000
[    3.807921] x11: 071c71c71c71c71c x10: 0000000000003fff x9 : ffff36ee43a6a469
[    3.815254] x8 : ffff36ee4101cf04 x7 : 00000000ffffffff x6 : 0000000000000001
[    3.822587] x5 : ffffb5460033a740 x4 : ffffb545ff50375c x3 : 0000000000000001
[    3.829910] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff36ee41012010
[    3.837234] Call trace:
[    3.839750]  iommu_dma_sync_sg_for_device+0x28/0x100
[    3.844853]  __dma_sync_sg_for_device+0x28/0x4c
[    3.849517]  spi_transfer_one_message+0x378/0x6e4
[    3.854360]  __spi_pump_transfer_message+0x190/0x4a4
[    3.859462]  __spi_sync+0x2a0/0x3c4
[    3.863048]  spi_sync+0x30/0x54
[    3.866283]  spi_mem_exec_op+0x26c/0x41c
[    3.870321]  spi_nor_read_id+0x7c/0xc4
[    3.874180]  spi_nor_detect+0x34/0x158
[    3.878039]  spi_nor_scan+0x1f0/0xef8
[    3.881813]  spi_nor_probe+0x94/0x2ec
[    3.885587]  spi_mem_probe+0x6c/0xac
[    3.889262]  spi_probe+0x84/0xe4
[    3.892579]  really_probe+0xbc/0x2a0
[    3.896262]  __driver_probe_device+0x78/0x12c
[    3.900747]  driver_probe_device+0x40/0x160
[    3.905046]  __device_attach_driver+0xb8/0x134
[    3.909619]  bus_for_each_drv+0x84/0xe0
[    3.913568]  __device_attach+0xa8/0x1b0
[    3.917515]  device_initial_probe+0x14/0x20
[    3.921814]  bus_probe_device+0xa8/0xac
[    3.925761]  device_add+0x590/0x750
[    3.929351]  __spi_add_device+0x138/0x208
[    3.933476]  of_register_spi_device+0x394/0x57c
[    3.938139]  spi_register_controller+0x394/0x760
[    3.942888]  qcom_qspi_probe+0x328/0x390
[    3.946928]  platform_probe+0x68/0xd8
[    3.950701]  really_probe+0xbc/0x2a0
[    3.954384]  __driver_probe_device+0x78/0x12c
[    3.958869]  driver_probe_device+0x40/0x160
[    3.963169]  __device_attach_driver+0xb8/0x134
[    3.967734]  bus_for_each_drv+0x84/0xe0
[    3.971682]  __device_attach+0xa8/0x1b0
[    3.975628]  device_initial_probe+0x14/0x20
[    3.979927]  bus_probe_device+0xa8/0xac
[    3.983873]  deferred_probe_work_func+0x88/0xc0
[    3.988536]  process_one_work+0x154/0x298
[    3.992663]  worker_thread+0x304/0x408
[    3.996525]  kthread+0x118/0x11c
[    3.999847]  ret_from_fork+0x10/0x20
[    4.003534] Code: 2a0203f5 2a0303f6 a90363f7 aa0003f7 (b9401c20)
[    4.009788] ---[ end trace 0000000000000000 ]---

Searching on lore I could only find the following series that caused another
regression, and its subsequent fix:
https://lore.kernel.org/lkml/20240507112026.1803778-1-aleksander.lobakin@intel.com/
https://lore.kernel.org/all/20240509144616.938519-1-aleksander.lobakin@intel.com/

But even after reverting both the issue was still there, so I've concluded
that's unrelated.

Thanks,
Nícolas

#regzbot introduced: next-20240509

[1] https://pastebin.com/raw/sx4bPAa6


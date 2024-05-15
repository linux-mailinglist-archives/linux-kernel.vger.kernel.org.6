Return-Path: <linux-kernel+bounces-180364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B71EF8C6D78
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 23:06:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D726E1C21E39
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 21:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E71215B10E;
	Wed, 15 May 2024 21:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="eDPbJsqb"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A5A158DD8
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 21:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715807159; cv=none; b=ufmOww+ykDY+4DLjcQekzWp+DaWlQg5IjGEDpzVzyFpJdkn/A0HXJbel6+tVPMql5VGqfuCAZDzqv9/w3XC7KghJ5upPmdjkU3mmdp5Z0ilKDpfQZCI8xc7ir2yRs29zpdoimOdv3Kici3E6ZHhtyX/fbIdk3r3UALPi3vbPwCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715807159; c=relaxed/simple;
	bh=iN03rd3d4EZyhs+QzicrL8vsy+qOike2tTT7G70zsNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kG504Wd0TCqGpXaUbvB6LH9UnFAAX8cv/x/HBsqEnreCqr0aJcvAtompZESXL2BReWDTLruohDMhXbm80nGs7v9WTxi56La5hkGRamEY2c+VEDYWrlyk8Wt0hthbVKHsw0kNcqvR9yqgKB1aaz15+F5srIr+WTprpM4vB1EEBQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=eDPbJsqb; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1715807156;
	bh=iN03rd3d4EZyhs+QzicrL8vsy+qOike2tTT7G70zsNY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eDPbJsqbwrbUiZuH1hkZy0y4qUNQPCOMA/zhWRfb74CP3L6hO/EZ6V1A66k0EiS55
	 DL34G6e4Jlb7VCHu85+S1TXqmSyIMHjhld+fnixHIq0JjcKPOnlgZD6XMsrRrDzpzC
	 DJqJDsSWpzfCqGGAXev/5DaECPyEHYXLzkP/Vksc5L1DVpDjB8U4/nRBp2lSlrmGFF
	 MfN4KZuOdJSRi7i/Pj75hFK6tWngLjT/Pgj97gRShnSNUun45DXaooCl4R/vjrIbDy
	 8xR8IiYL8MjdMbBsgDZw6Sz06il6Kitu5nTbpERFvRJI94ky3InP8L6DsdXuVpCXxS
	 mqGBEcJsDvAOg==
Received: from notapiano (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 7FC6B378218D;
	Wed, 15 May 2024 21:05:55 +0000 (UTC)
Date: Wed, 15 May 2024 17:05:53 -0400
From: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
To: regressions@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [REGRESSION] boot regression on linux-next on sc7180 platforms -
 null pointer dereference on iommu_dma_sync_sg_for_device
Message-ID: <d3679496-2e4e-4a7c-97ed-f193bd53af1d@notapiano>
References: <6d0da90d-f405-4b5d-b7f9-238cc9405ebe@notapiano>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6d0da90d-f405-4b5d-b7f9-238cc9405ebe@notapiano>

On Tue, May 14, 2024 at 12:41:29PM -0400, Nícolas F. R. A. Prado wrote:
> Hi,
> 
> KernelCI has identified a new boot regression on linux-next. It affects the
> following platforms:
> * sc7180-trogdor-kingoftown
> * sc7180-trogdor-lazor-limozeen
> 
> The regression was introduced in next-20240509, and still affects today's
> (next-20240514) release.
> 
> The config used was the upstream arm64 defconfig with a config fragment on top
> [1].
> 
> The following stack traces are produced during boot and a usable shell is never
> reached:
> 
> [    0.381981] Unable to handle kernel NULL pointer dereference at virtual address 000000000000001c
> [    0.381989] Mem abort info:
> [    0.381991]   ESR = 0x0000000096000004
> [    0.381994]   EC = 0x25: DABT (current EL), IL = 32 bits
> [    0.381997]   SET = 0, FnV = 0
> [    0.382000]   EA = 0, S1PTW = 0
> [    0.382003]   FSC = 0x04: level 0 translation fault
> [    0.382006] Data abort info:
> [    0.382008]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
> [    0.382011]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
> [    0.382014]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> [    0.382017] [000000000000001c] user address but active_mm is swapper
> [    0.382021] Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
> [    0.382025] Modules linked in:
> [    0.382032] CPU: 4 PID: 68 Comm: kworker/u32:2 Not tainted 6.9.0-next-20240514-dirty #380
> [    0.382038] Hardware name: Google Kingoftown (DT)
> [    0.382042] Workqueue: async async_run_entry_fn
> [    0.382055] pstate: 80400009 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [    0.382061] pc : iommu_dma_sync_sg_for_device+0x28/0x100
> [    0.382070] lr : __dma_sync_sg_for_device+0x28/0x4c
> [    0.382080] sp : ffff800080943740
> [    0.382082] x29: ffff800080943740 x28: ffff36ee44280000 x27: ffff36ee40bd7810
> [    0.382092] x26: ffff800080943998 x25: ffff36ee44280480 x24: ffffb54600bcf0e8
> [    0.382101] x23: ffff36ee40bd7810 x22: 0000000000000001 x21: 0000000000000000
> [    0.382110] x20: ffffb54600f3d098 x19: 0000000000000000 x18: ffffb54601c1a210
> [    0.382118] x17: 000000040044ffff x16: 0000000000000000 x15: ffff36efb6d95580
> [    0.382126] x14: ffff36ee409156c0 x13: 0000000000001797 x12: 0000000000000002
> [    0.382134] x11: 0000000000000004 x10: ffff36ee4308b3d8 x9 : ffff36ee44280469
> [    0.382143] x8 : ffff36ee4308b304 x7 : 00000000ffffffff x6 : 0000000000000001
> [    0.382151] x5 : ffffb5460033a740 x4 : ffffb545ff50375c x3 : 0000000000000001
> [    0.382159] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff36ee40bd7810
> [    0.382167] Call trace:
> [    0.382170]  iommu_dma_sync_sg_for_device+0x28/0x100
> [    0.382176]  __dma_sync_sg_for_device+0x28/0x4c
> [    0.382183]  spi_transfer_one_message+0x378/0x6e4
> [    0.382193]  __spi_pump_transfer_message+0x190/0x4a4
> [    0.382199]  __spi_sync+0x2a0/0x3c4
> [    0.382205]  spi_sync_locked+0x10/0x1c
> [    0.382211]  tpm_tis_spi_transfer_full+0x160/0x2fc
> [    0.382217]  tpm_tis_spi_transfer+0x34/0x40
> [    0.382221]  tpm_tis_spi_cr50_read_bytes+0x5c/0x90
> [    0.382226]  tpm_tis_core_init+0xfc/0x7e0
> [    0.382231]  tpm_tis_spi_init+0x54/0x70
> [    0.382236]  cr50_spi_probe+0xf4/0x27c
> [    0.382241]  tpm_tis_spi_driver_probe+0x34/0x64
> [    0.382245]  spi_probe+0x84/0xe4
> [    0.382251]  really_probe+0xbc/0x2a0
> [    0.382258]  __driver_probe_device+0x78/0x12c
> [    0.382264]  driver_probe_device+0x40/0x160
> [    0.382269]  __device_attach_driver+0xb8/0x134
> [    0.382275]  bus_for_each_drv+0x84/0xe0
> [    0.382280]  __device_attach_async_helper+0xac/0xd0
> [    0.382286]  async_run_entry_fn+0x34/0xe0
> [    0.382291]  process_one_work+0x154/0x298
> [    0.382300]  worker_thread+0x304/0x408
> [    0.382307]  kthread+0x118/0x11c
> [    0.382313]  ret_from_fork+0x10/0x20
> [    0.382324] Code: 2a0203f5 2a0303f6 a90363f7 aa0003f7 (b9401c20)
> [    0.382328] ---[ end trace 0000000000000000 ]---

Tracked down the issue to commit 8cc3bad9d9d6 ("spi: Remove unneded check for
orig_nents").

#regzbot introduced: 8cc3bad9d9d6

The issue happens because in spi_dma_sync_for_device(), the line

	dma_sync_sgtable_for_device(tx_dev, &xfer->tx_sg, DMA_TO_DEVICE);

is passing a scatterlist table (xfer->tx_sg) that hasn't been initialized, so
the sgl pointer inside it is null. Before the patch, the check would prevent it
from being called since orig_nents is 0.

This initialization of the scatterlist table should happen in
spi_map_buf_attrs(), which should be called in __spi_map_msg(), however some
debugging revealed that the previous check

		if (!ctlr->can_dma(ctlr, msg->spi, xfer))
	
is failing, which is why the scatterlist table isn't initialized. Despite that,
ctlr->cur_msg_mapped is set to true, so spi_dma_sync_for_device() doesn't return
early, which would completely avoid the issue. At this point I'm confused why
that flag tracks DMA mapping per message, if the mapping is done per transfer
(and a message can contain multiple transfers). Maybe that's what needs to
change, though I'd like the input from someone who is familiar with this code.

Thanks,
Nícolas


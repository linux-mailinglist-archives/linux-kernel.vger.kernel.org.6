Return-Path: <linux-kernel+bounces-320095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 748CB970617
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 11:44:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CF2C1F21DC1
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 09:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C3A113BAF1;
	Sun,  8 Sep 2024 09:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rHaEmaBi"
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E972E634
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 09:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725788658; cv=none; b=d7WqOfTvu96327rSUp0KiSnnQpFHPoz6ox9nPN+Udg/97UBfwTci1wlH8aDIMCRbKsh8TZOlTpVO2+SDk3sGdKdWXwCpGj1kgjKL1ha1aMh5niE7bSxplrzDKo6QYSNmxvqM19Esj4gjkO6Gn7ENp6XgoIqOPLRKCjDH5hhla8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725788658; c=relaxed/simple;
	bh=h2Y7DN7i00hmHpiRGedcAo6/ZSy2lb2/ftAZcUJWNHE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Sz7+hH7NXKXDEXiWlBFxpI5BLXuK9jn3cXGRWt0d/5qyHpLnTEjQcYB7ev/1jQoGHNoKkwwMWcJm0o7PWJwuQ9l7vX4f/RmgU6vI/q3Z8ihR1IciPE5EAudH+OAZGTsFD8e0JpigMcnv8d+ievuIKwbI1Ld/kf97D7ThrrvQ/8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rHaEmaBi; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725788649;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=iKnfMiLB9a0irdtB/pTgb8p6Wd2qUK1Juyy7jyAjfjI=;
	b=rHaEmaBicjBGAmqWhHkyYqdYs01Q6y4bCAls4YnFnT9zwYVLf0hloQCPz+A9zRYxDMFlmc
	9PSeDg8TU2ARUZwu+gJbJR/DUTue8a4SXBVOm6Ra763oB2C6edY1pGmsawHSIRdgIw8931
	9NNhBa6nOfGaOwC5Bsy6JHC4sOoPB04=
From: Sui Jingfeng <sui.jingfeng@linux.dev>
To: Lucas Stach <l.stach@pengutronix.de>
Cc: Christian Gmeiner <christian.gmeiner@gmail.com>,
	Russell King <linux+etnaviv@armlinux.org.uk>,
	dri-devel@lists.freedesktop.org,
	etnaviv@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Sui Jingfeng <sui.jingfeng@linux.dev>
Subject: [PATCH v15 00/19] drm/etnaviv: Add driver wrapper for vivante GPUs attached on PCI(e) device
Date: Sun,  8 Sep 2024 17:43:38 +0800
Message-ID: <20240908094357.291862-1-sui.jingfeng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

drm/etnaviv use the component framework to bind multiple GPU cores to a
virtual master, the virtual master is manually create during driver load
time. This may works well for SoCs, yet there are some PCIe card has the
vivante GPU cores integrated. The driver lacks support for PCIe devices
currently.

Adds PCIe driver wrapper on the top of drm/etnaviv, the component
framework is still being used to bind subdevices, even though there is
only one GPU core. But the process is going to be reversed, we create
virtual platform device for each of the vivante GPU IP core that is
shipped by the PCIe card. Select the PCIe device as parent, generate a
virtual platform device as component master to take over the bind actions.

Sui Jingfeng (19):
  drm/etnaviv: Implement drm_gem_object_funcs::print_info()
  drm/etnaviv: Export drm_gem_print_info() and use it
  drm/etnaviv: Implement drm_gem_object_funcs::vunmap()
  drm/etnaviv: Make etnaviv_gem_prime_vmap() a static function
  drm/etnaviv: Add contructor and destructor for etnaviv_gem_get_mapping
    structure
  drm/etnaviv: Prefer drm_device based drm_WARN_ON() over regular
    WARN_ON()
  drm/etnaviv: Add a dedicated helper function to get various clocks
  drm/etnaviv: Fix wrong caching mode being used for non writecombine
    buffers
  drm/etnaviv: Add constructor and destructor for the
    etnaviv_drm_private structure
  drm/etnaviv: Embed struct drm_device into struct etnaviv_drm_private
  drm/etnaviv: Add etnaviv_gem_obj_remove() helper
  drm/etnaviv: Add support for cached coherent caching mode
  drm/etnaviv: Add support for vivante GPU cores attached via PCIe
    device
  drm/etnaviv: Add PCIe IP setup code
  drm/etnaviv: Make more use of the etnaviv_gem_new_private() function
  drm/etnaviv: Call etnaviv_gem_obj_add() in ernaviv_gem_new_private()
  drm/etnaviv: Support to manage dedicated VRAM base on drm_mm
  drm/etnaviv: Allow userspace specify the domain of etnaviv GEM buffer
    object
  drm/etnaviv: Expose basic sanity tests via debugfs

v10:
	* Add one more cleanup patch
	* Resolve the conflict with a patch from Rob
	* Make the dummy PCI stub inlined
	* Print only if the platform is dma-coherrent
V11:
	* Process reviews since V10.
	* Provide a side by side implement

V12:
	* Create a virtual platform device for the subcomponent GPU cores
	* Bind all subordinate GPU cores to the real PCI master via component.

V13:
	* Drop the non-component code path, always use the component framework
	  to bind subcomponent GPU core. Even though there is only one core.
	* Defer the irq handler register.
	* Rebase and improve the commit message

V14:
	* Rebase onto etnaviv-next and improve commit message.

V15:
	* Plug in a drm-mm based dedicated VRAM range allocator.

 drivers/gpu/drm/drm_gem.c                    |   1 +
 drivers/gpu/drm/etnaviv/Kconfig              |   9 +
 drivers/gpu/drm/etnaviv/Makefile             |   5 +
 drivers/gpu/drm/etnaviv/etnaviv_debugfs.c    | 118 +++++++++
 drivers/gpu/drm/etnaviv/etnaviv_debugfs.h    |  15 ++
 drivers/gpu/drm/etnaviv/etnaviv_drv.c        | 183 +++++++++----
 drivers/gpu/drm/etnaviv/etnaviv_drv.h        |  40 ++-
 drivers/gpu/drm/etnaviv/etnaviv_gem.c        | 224 ++++++++++++----
 drivers/gpu/drm/etnaviv/etnaviv_gem.h        |  21 +-
 drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c  |  31 +--
 drivers/gpu/drm/etnaviv/etnaviv_gem_submit.c |   2 +-
 drivers/gpu/drm/etnaviv/etnaviv_gem_vram.c   | 264 +++++++++++++++++++
 drivers/gpu/drm/etnaviv/etnaviv_gem_vram.h   |  14 +
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c        | 136 +++++++---
 drivers/gpu/drm/etnaviv/etnaviv_gpu.h        |   4 +
 drivers/gpu/drm/etnaviv/etnaviv_mmu.c        |  11 +-
 drivers/gpu/drm/etnaviv/etnaviv_pci_drv.c    | 217 +++++++++++++++
 drivers/gpu/drm/etnaviv/etnaviv_pci_drv.h    |  63 +++++
 drivers/gpu/drm/etnaviv/pcie_ip_setup.c      | 109 ++++++++
 include/drm/drm_gem.h                        |   2 +
 include/uapi/drm/etnaviv_drm.h               |  13 +
 21 files changed, 1308 insertions(+), 174 deletions(-)
 create mode 100644 drivers/gpu/drm/etnaviv/etnaviv_debugfs.c
 create mode 100644 drivers/gpu/drm/etnaviv/etnaviv_debugfs.h
 create mode 100644 drivers/gpu/drm/etnaviv/etnaviv_gem_vram.c
 create mode 100644 drivers/gpu/drm/etnaviv/etnaviv_gem_vram.h
 create mode 100644 drivers/gpu/drm/etnaviv/etnaviv_pci_drv.c
 create mode 100644 drivers/gpu/drm/etnaviv/etnaviv_pci_drv.h
 create mode 100644 drivers/gpu/drm/etnaviv/pcie_ip_setup.c

-- 
2.43.0



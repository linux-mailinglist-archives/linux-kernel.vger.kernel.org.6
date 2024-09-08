Return-Path: <linux-kernel+bounces-320048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBB87970571
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 09:49:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1182E1C21290
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 07:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CC454CB36;
	Sun,  8 Sep 2024 07:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BAse+IEW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C49B1B85F2
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 07:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725781772; cv=none; b=Uy9AhCZOaYBgoVavkxoTsMSXYUSodJLINN8eb0vRXurG92BL89He2OLjTlE0p70cOr0AoZUTI5QFKKr4SmXaxhAw+WtKMJwdchJJYkROe3wbt3PVYHS4UlaB8D3j23pRLtZ8RCAdFZILQGhVj7Vljm3SaoseFOTRnlT5Zm95OaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725781772; c=relaxed/simple;
	bh=ZaFwJ3mZbKQK3sWYP8D9iDTGCj9GrATcuNCENKstKyc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=BjPFG1E5Ql+1KTZivN3Azw753o2cc0/vjXnwAwUOipWT8SBRWfuIesyM8YS3YwRm7QoZu0/dMNU8FVZe6x+NSpBenhTfv7+go29ST/LrISvhNJxMvBd9zEhB56kAp4npokY8QDJsQ8aI/TFPnH+3ceJhWCry4zYXk/2o211tD/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BAse+IEW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91AFCC4CEC3;
	Sun,  8 Sep 2024 07:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725781771;
	bh=ZaFwJ3mZbKQK3sWYP8D9iDTGCj9GrATcuNCENKstKyc=;
	h=Date:From:To:Cc:Subject:From;
	b=BAse+IEWLXYmUzqaOXV2Rp9cq2R+JavYpbX5r8unv1mdEiHJABYD1BURtYVplbOtx
	 9mZ/yuqGUM7A1kC5hTqj811VvpxvGrnxSwccUiL1h6uoSOdGiqzSYQXl3X8IuxZSvh
	 LzouOB6b0lpi5EJU47egG6TaSzUOVQVZQT5lkfZM=
Date: Sun, 8 Sep 2024 09:49:29 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Char/Misc driver fixes for 6.11-rc7
Message-ID: <Zt1XCZ_1hdVsi5mJ@kroah.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 47ac09b91befbb6a235ab620c32af719f8208399:

  Linux 6.11-rc4 (2024-08-18 13:17:27 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.11-rc7

for you to fetch changes up to 48b9a8dabcc3cf5f961b2ebcd8933bf9204babb7:

  VMCI: Fix use-after-free when removing resource in vmci_resource_remove() (2024-09-03 13:16:42 +0200)

----------------------------------------------------------------
Char/Misc driver fixes for 6.11-rc7

Here are some small char/misc/other driver fixes for 6.11-rc7.  It's
nothing huge, just a bunch of small fixes of reported problems,
including:
  - lots of tiny iio driver fixes
  - nvmem driver fixex
  - binder UAF bugfix
  - uio driver crash fix
  - other small fixes

All of these have been in linux-next this week with no reported
problems.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Aleksandr Mishin (1):
      staging: iio: frequency: ad9834: Validate frequency parameter value

Carlos Llamas (1):
      binder: fix UAF caused by offsets overwrite

David Fernandez Gonzalez (1):
      VMCI: Fix use-after-free when removing resource in vmci_resource_remove()

David Lechner (1):
      iio: buffer-dmaengine: fix releasing dma channel on error

Dumitru Ceclan (5):
      iio: adc: ad7173: Fix incorrect compatible string
      iio: adc: ad7124: fix chip ID mismatch
      iio: adc: ad7124: fix config comparison
      iio: adc: ad7124: fix DT configuration parsing
      iio: adc: ad7173: fix GPIO device info

Francesco Dolcini (1):
      iio: adc: ads1119: Fix IRQ flags

Geert Uytterhoeven (1):
      nvmem: Fix return type of devm_nvmem_device_get() in kerneldoc

Gerhard Engleder (1):
      misc: keba: Fix sysfs group creation

Greg Kroah-Hartman (1):
      Merge tag 'iio-fixes-for-6.11a' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/jic23/iio into char-misc-linus

Guillaume Stols (1):
      iio: adc: ad7606: remove frstdata check for serial mode

Jean-Baptiste Maneyrol (1):
      iio: imu: inv_mpu6050: fix interrupt status read for old buggy chips

John Thomson (1):
      nvmem: u-boot-env: error if NVMEM device is too small

Matteo Martelli (1):
      iio: fix scale application in iio_convert_raw_to_processed_unlocked

Michal Simek (1):
      dt-bindings: nvmem: Use soc-nvmem node name instead of nvmem

Naman Jain (1):
      Drivers: hv: vmbus: Fix rescind handling in uio_hv_generic

Nuno Sa (1):
      iio: adc: ad_sigma_delta: fix irq_flags on irq request

Saurabh Sengar (1):
      uio_hv_generic: Fix kernel NULL pointer dereference in hv_uio_rescind

Sukrut Bellary (1):
      misc: fastrpc: Fix double free of 'buf' in error path

 .../bindings/nvmem/xlnx,zynqmp-nvmem.yaml          |  2 +-
 drivers/android/binder.c                           |  1 +
 drivers/hv/vmbus_drv.c                             |  1 +
 drivers/iio/adc/ad7124.c                           | 30 ++++++++------
 drivers/iio/adc/ad7173.c                           | 13 +++---
 drivers/iio/adc/ad7606.c                           | 28 +------------
 drivers/iio/adc/ad7606.h                           |  2 +
 drivers/iio/adc/ad7606_par.c                       | 46 +++++++++++++++++++++-
 drivers/iio/adc/ad_sigma_delta.c                   |  2 +-
 drivers/iio/adc/ti-ads1119.c                       |  2 +-
 drivers/iio/buffer/industrialio-buffer-dmaengine.c |  4 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c      | 13 +++++-
 drivers/iio/inkern.c                               |  8 ++--
 drivers/misc/fastrpc.c                             |  5 +--
 drivers/misc/keba/cp500.c                          | 14 ++-----
 drivers/misc/vmw_vmci/vmci_resource.c              |  3 +-
 drivers/nvmem/core.c                               |  6 +--
 drivers/nvmem/u-boot-env.c                         |  7 ++++
 drivers/staging/iio/frequency/ad9834.c             |  2 +-
 drivers/uio/uio_hv_generic.c                       | 11 +++++-
 20 files changed, 122 insertions(+), 78 deletions(-)


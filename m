Return-Path: <linux-kernel+bounces-216239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E261909D00
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 12:50:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC4D7281856
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 10:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AD78186E58;
	Sun, 16 Jun 2024 10:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ua1F+xCH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E701862BC
	for <linux-kernel@vger.kernel.org>; Sun, 16 Jun 2024 10:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718535045; cv=none; b=tnYOosTZWWBrZq6pC4rca8QxWBijg/woFX1qt/f6NJnePbyCVxmNO4G+D/ZCeQSHtV2pRA2iQvqSoUKli8rDL1vews0VzhY+MGlD5ZkZmp5ekDkWrXm1pzMGZIEv23eQdJzuAAsWWvvYhamMC8dRKIk33/P0CQYMWTOERs3FbMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718535045; c=relaxed/simple;
	bh=DEkvJ0RjCaS0J92lA7j9thUF0DjAx6uLgtPnmjVoSkw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=CXy4BmJ+O7vTakWA83E9TsmxTX+WSjGHKKV1bvId0/L6kiB1kipWbYnpr+6ux9WwTom/MqPwbx78r7ZetZsICYkCVcUCJNId7jfDIK9JOkKwCGqOmT26DOryf9p5za2fIEb+PHkMDfbwvnQKiw7ORUfE343LsiqmKixfQrLiqQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ua1F+xCH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64A2CC2BBFC;
	Sun, 16 Jun 2024 10:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718535044;
	bh=DEkvJ0RjCaS0J92lA7j9thUF0DjAx6uLgtPnmjVoSkw=;
	h=Date:From:To:Cc:Subject:From;
	b=ua1F+xCHIrR5HND/1Ack3AH+LqMVmTwT2caE+1eWTKJrQ53Z77pdVuFvh7EmMqWKd
	 bHlnYbGcun/o7y25TC0Fngwo/1dnH57YL6lxj9heP33eVKSrPblPUZVFRE2QLJRmqJ
	 S6QOdeFG+zB8pXa8o7lEJeBAfj5T+T8rhBvoJRrs=
Date: Sun, 16 Jun 2024 12:50:42 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Char/Misc driver fixes for 6.10-rc4
Message-ID: <Zm7DgsGWt90hFznF@kroah.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

The following changes since commit c3f38fa61af77b49866b006939479069cd451173:

  Linux 6.10-rc2 (2024-06-02 15:44:56 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.10-rc4

for you to fetch changes up to 7da9dfdd5a3dbfd3d2450d9c6a3d1d699d625c43:

  .editorconfig: remove trim_trailing_whitespace option (2024-06-13 16:47:52 +0200)

----------------------------------------------------------------
Char/Misc driver fixes for 6.10-rc4

Here are a number of small char/misc and iio driver fixes for 6.10-rc4.
Included in here are the following:
  - iio driver fixes for a bunch of reported problems.
  - mei driver fixes for a number of reported issues.
  - amiga parport driver build fix.
  - .editorconfig fix that was causing lots of unintended whitespace
    changes to happen to files when they were being edited.  Unless we
    want to sweep the whole tree and remove all trailing whitespace at
    once, this is needed for the .editorconfig file to be able to be
    used at all.  This change is required because the original
    submitters never touched older files in the tree.
  - jfs bugfix for a buffer overflow

The jfs bugfix is in here as I didn't know where else to put it, and
it's been ignored for a while as the filesystem seems to be abandoned
and I'm tired of seeing the same issue reported in multiple places.

All of these have been in linux-next with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Adam Rizkalla (1):
      iio: pressure: bmp280: Fix BMP580 temperature reading

Alexander Usyskin (1):
      mei: demote client disconnect warning on suspend to debug

Angelo Dureghello (1):
      dt-bindings: iio: dac: fix ad354xr output range

David Lechner (1):
      iio: adc: ad9467: fix scan type sign

Dumitru Ceclan (5):
      iio: adc: ad7173: fix buffers enablement for ad7176-2
      iio: adc: ad7173: Add ad7173_device_info names
      iio: adc: ad7173: Remove index from temp channel
      iio: adc: ad7173: Clear append status bit
      iio: adc: ad7173: Fix sampling frequency setting

Greg Kroah-Hartman (3):
      jfs: xattr: fix buffer overflow for invalid xattr
      Merge tag 'iio-fixes-for-6.10a' of https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into char-misc-linus
      .editorconfig: remove trim_trailing_whitespace option

Hans de Goede (1):
      mei: vsc: Fix wrong invocation of ACPI SID method

Harshit Mogalapalli (1):
      iio: temperature: mlx90635: Fix ERR_PTR dereference in mlx90635_probe()

Jean-Baptiste Maneyrol (4):
      iio: invensense: fix odr switching to same value
      iio: imu: inv_icm42600: stabilized timestamp in interrupt
      iio: imu: inv_icm42600: delete unneeded update watermark call
      iio: imu: inv_mpu6050: stabilized timestamping in interrupt

Johan Hovold (1):
      iio: inkern: fix channel read regression

Marc Ferland (1):
      iio: dac: ad5592r: fix temperature channel scaling value

Tomas Winkler (1):
      mei: me: release irq in mei_me_pci_resume error path

Uwe Kleine-König (1):
      parport: amiga: Mark driver struct with __refdata to prevent section mismatch

Vasileios Amoiridis (1):
      iio: imu: bmi323: Fix trigger notification in case of error

Wentong Wu (1):
      mei: vsc: Don't stop/restart mei device during system suspend/resume

Yongzhi Liu (2):
      misc: microchip: pci1xxxx: fix double free in the error handling of gp_aux_bus_probe()
      misc: microchip: pci1xxxx: Fix a memory leak in the error handling of gp_aux_bus_probe()

 .editorconfig                                      |  3 --
 .../devicetree/bindings/iio/dac/adi,ad3552r.yaml   |  2 +-
 drivers/iio/adc/ad7173.c                           | 37 ++++++++++----------
 drivers/iio/adc/ad9467.c                           |  4 +--
 .../iio/common/inv_sensors/inv_sensors_timestamp.c |  6 +++-
 drivers/iio/dac/ad5592r-base.c                     |  2 +-
 drivers/iio/imu/bmi323/bmi323_core.c               |  5 +--
 drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c  |  4 ---
 drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c | 19 +++++++++--
 drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.h |  2 ++
 drivers/iio/imu/inv_icm42600/inv_icm42600_core.c   |  1 +
 drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c   |  4 ---
 drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c         |  4 +--
 drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c      |  1 +
 drivers/iio/inkern.c                               |  2 +-
 drivers/iio/pressure/bmp280-core.c                 | 10 +++---
 drivers/iio/temperature/mlx90635.c                 |  6 ++--
 drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.c      |  9 +++--
 drivers/misc/mei/main.c                            |  2 +-
 drivers/misc/mei/pci-me.c                          |  4 ++-
 drivers/misc/mei/platform-vsc.c                    | 39 +++++++++-------------
 drivers/misc/mei/vsc-fw-loader.c                   |  2 +-
 drivers/parport/parport_amiga.c                    |  8 ++++-
 fs/jfs/xattr.c                                     |  4 ++-
 24 files changed, 100 insertions(+), 80 deletions(-)


Return-Path: <linux-kernel+bounces-168925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 840C68BBFCF
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 10:35:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2573E1F21652
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 08:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2175C6FB6;
	Sun,  5 May 2024 08:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="C2fco+Mi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C86186A
	for <linux-kernel@vger.kernel.org>; Sun,  5 May 2024 08:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714898142; cv=none; b=QEIkj8AAmqW9CSIc8Vw1ALs9HNQZygRbASfIlnh275PT4/EqDRIBt3DBOrfk7rFubrEsDQgUxHpsvlvlIVGiEx6LPhMrWPYnSML9bTcJx4vA4nn7Jhfz5+rUs6ED+oP/GTCIzNCtb0L08fDxwsOnIZyEytzGPp4pn1QTIRKkrak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714898142; c=relaxed/simple;
	bh=ZQ88QZihUyP/rwFP3gPP60mEMZO3Ifd6+copEtXSy38=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=vEKA0bfWIMe+Vhd0878IH54QjQOy8/1jpoHmi9JTmA7EigR1fzz+nztEj11SdNQF0L6o0JlBRu5niBDpO/rnicWsUUzZoV3/8ASj13APaTUCtZOP5gsuYD5+Y82TYstegLrheqK2WqMcsVKYZlH5H7qbezzM1q4c0/pkAZGZgJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=C2fco+Mi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C8AEC113CC;
	Sun,  5 May 2024 08:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714898142;
	bh=ZQ88QZihUyP/rwFP3gPP60mEMZO3Ifd6+copEtXSy38=;
	h=Date:From:To:Cc:Subject:From;
	b=C2fco+MiD031W+QX0sFLFvu/6AURYw0dBvpVZYhDX40izbhP17BK4aP/b/9iI1cMa
	 c5+E+jV5i1uOyNEOE1dUwM+qx79h0PR4bg+zifx2h7ZlU+nDskJ77LXVRVSif/Lura
	 0h4O4Ai3peo7taLqHIFHrgx5HQ6VPWenUvWXVhfg=
Date: Sun, 5 May 2024 09:35:39 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Char/Misc driver fixes for 6.9-rc7
Message-ID: <ZjdE2yWk-I3YmLf1@kroah.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

The following changes since commit ed30a4a51bb196781c8058073ea720133a65596f:

  Linux 6.9-rc5 (2024-04-21 12:35:54 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.9-rc7

for you to fetch changes up to 98241a774db49988f25b7b3657026ce51ccec293:

  slimbus: qcom-ngd-ctrl: Add timeout for wait operation (2024-05-03 07:30:32 +0200)

----------------------------------------------------------------
Char/Misc driver fixes for 6.9-rc7

Here are some small char/misc/other driver fixes and new device ids for
6.9-rc7 that resolve some reported problems.

Included in here are:
  - iio driver fixes
  - mei driver fix and new device ids
  - dyndbg bugfix
  - pvpanic-pci driver bugfix
  - slimbus driver bugfix
  - fpga new device id

All have been in linux-next with no reported problems.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alexander Usyskin (1):
      mei: me: add lunar lake point M DID

Daniele Ceraolo Spurio (1):
      mei: pxp: match against PCI_CLASS_DISPLAY_OTHER

Greg Kroah-Hartman (2):
      Merge tag 'iio-fixes-for-6.9a' of https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into char-misc-linus
      Merge tag 'fpga-for-6.9-final' of git://git.kernel.org/pub/scm/linux/kernel/git/fpga/linux-fpga into char-misc-linus

Hans de Goede (2):
      iio: accel: mxc4005: Interrupt handling fixes
      iio: accel: mxc4005: Reset chip on probe() and resume()

Javier Carrasco (1):
      dt-bindings: iio: health: maxim,max30102: fix compatible check

Jim Cromie (1):
      dyndbg: fix old BUG_ON in >control parser

Peter Colberg (1):
      fpga: dfl-pci: add PCI subdevice ID for Intel D5005 card

Ramona Gradinariu (1):
      iio:imu: adis16475: Fix sync mode setting

Thomas Weiﬂschuh (1):
      misc/pvpanic-pci: register attributes via pci_driver

Vasileios Amoiridis (2):
      iio: pressure: Fixes BME280 SPI driver data
      iio: pressure: Fixes SPI support for BMP3xx devices

Viken Dadhaniya (1):
      slimbus: qcom-ngd-ctrl: Add timeout for wait operation

 .../bindings/iio/health/maxim,max30102.yaml        |  2 +-
 drivers/fpga/dfl-pci.c                             |  3 +
 drivers/iio/accel/mxc4005.c                        | 92 ++++++++++++++++++++--
 drivers/iio/imu/adis16475.c                        |  4 +-
 drivers/iio/pressure/bmp280-core.c                 |  1 +
 drivers/iio/pressure/bmp280-spi.c                  | 13 +--
 drivers/iio/pressure/bmp280.h                      |  1 +
 drivers/misc/mei/hw-me-regs.h                      |  2 +
 drivers/misc/mei/pci-me.c                          |  2 +
 drivers/misc/mei/pxp/mei_pxp.c                     |  7 +-
 drivers/misc/pvpanic/pvpanic-pci.c                 |  4 +-
 drivers/slimbus/qcom-ngd-ctrl.c                    |  6 +-
 lib/dynamic_debug.c                                |  6 +-
 13 files changed, 118 insertions(+), 25 deletions(-)


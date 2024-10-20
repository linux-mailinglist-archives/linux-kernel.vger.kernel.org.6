Return-Path: <linux-kernel+bounces-373258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2341F9A5460
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 15:38:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F2051C20321
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 13:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90AF419259F;
	Sun, 20 Oct 2024 13:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="prGQaYTn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C956FB674
	for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 13:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729431515; cv=none; b=qDTj1/8zLwz14z9fg6IcNg/aFyixyjPoMbMJ0b9HSUinLzsdMvk/zmBz20CkgOJIKGEUTmxizSKgbyyvpj34upuIHUlUciMJtZO5mL16u2w6izMt1aabrNYQmu8Pv2xMMJnTbca7S8ZOZ49X5zrXbsqiX74CqfvVFsRe8PYilLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729431515; c=relaxed/simple;
	bh=8uFQFLvSa2mDp9GOzl7dkH89sp92ve8LttZLgsJBsh0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=SyG90HlRTLw93vKhij0yo+9qgfo0qabn2aD3Alxjvfx7ycbk0k6yvzoxSZGQ+WIfRJEdZgpi2kdAzTwOBLSH6lTDcaZM0P6Kimhb4bL+h9IfqS+YmPuV8WExOYPbB0ewe/sA1vAUj3j9ROZpFS7gUQ+3/LvMuHWVijfJcbR7JoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=prGQaYTn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0889CC4CEC6;
	Sun, 20 Oct 2024 13:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729431515;
	bh=8uFQFLvSa2mDp9GOzl7dkH89sp92ve8LttZLgsJBsh0=;
	h=Date:From:To:Cc:Subject:From;
	b=prGQaYTndxZb40KAgbO0Ylc0U3J31LkTDWB6GAN0bK1YXwTOkQ89iEwJs/ToIxut2
	 R9lNN22VaGcY8ZT+a/s0H0Y4e92kTBkqfHDh4Q7zHQx1Vf+ytMaC1o6llgRVKtkdXg
	 GBYIRaOsbSMsqpkW4/MWNM2PygRkPsH81Fr8H/OU=
Date: Sun, 20 Oct 2024 15:38:32 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Char/Misc driver fixes for 6.12-rc4
Message-ID: <ZxUH2J0BL3FCV6Hr@kroah.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 8cf0b93919e13d1e8d4466eb4080a4c4d9d66d7b:

  Linux 6.12-rc2 (2024-10-06 15:32:27 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.12-rc4

for you to fetch changes up to 9b673c7551e6881ee0946be95e21ba290c8ac45e:

  misc: rtsx: list supported models in Kconfig help (2024-10-18 13:40:17 +0200)

----------------------------------------------------------------
Char/Misc/IIO fixes for 6.12-rc4

Here are a number of small char/misc/iio driver fixes for 6.12-rc4.
Included in here are the following:
  - loads of small iio driver fixes for reported problems
  - parport driver out-of-bounds fix
  - Kconfig description and MAINTAINERS file updates

All of these, except for the Kconfig and MAINTAINERS file updates have
been in linux-next all week.  Those other two are just documentation
changes and will have no runtime issues and were merged on Friday.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Christophe JAILLET (1):
      iio: hid-sensors: Fix an error handling path in _hid_sensor_set_report_latency()

Dan Carpenter (2):
      iio: bmi323: fix copy and paste bugs in suspend resume
      iio: bmi323: fix reversed if statement in bmi323_core_runtime_resume()

David Lechner (1):
      iio: adc: ad4695: Add missing Kconfig select

Emil Gedenryd (1):
      iio: light: opt3001: add missing full-scale range value

Greg Kroah-Hartman (2):
      Merge tag 'iio-fixes-for-6.12a' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/jic23/iio into char-misc-linus
      MAINTAINERS: Remove some entries due to various compliance requirements.

Heiko Thiery (2):
      misc: microchip: pci1xxxx: add support for NVMEM_DEVID_AUTO for EEPROM device
      misc: microchip: pci1xxxx: add support for NVMEM_DEVID_AUTO for OTP device

Javier Carrasco (24):
      iio: light: veml6030: fix IIO device retrieval from embedded device
      iio: light: veml6030: fix ALS sensor resolution
      iio: accel: kx022a: add missing select IIO_(TRIGGERED_)BUFFER in Kconfig
      iio: adc: ad7944: add missing select IIO_(TRIGGERED_)BUFFER in Kconfig
      iio: adc: ti-ads124s08: add missing select IIO_(TRIGGERED_)BUFFER in Kconfig
      iio: adc: ti-lmp92064: add missing select REGMAP_SPI in Kconfig
      iio: adc: ti-lmp92064: add missing select IIO_(TRIGGERED_)BUFFER in Kconfig
      iio: dac: ad3552r: add missing select IIO_(TRIGGERED_)BUFFER in Kconfig
      iio: dac: ad5766: add missing select IIO_(TRIGGERED_)BUFFER in Kconfig
      iio: chemical: ens160: add missing select IIO_(TRIGGERED_)BUFFER in Kconfig
      iio: light: bu27008: add missing select IIO_(TRIGGERED_)BUFFER in Kconfig
      iio: magnetometer: af8133j: add missing select IIO_(TRIGGERED_)BUFFER in Kconfig
      iio: pressure: bm1390: add missing select IIO_(TRIGGERED_)BUFFER in Kconfig
      iio: proximity: mb1232: add missing select IIO_(TRIGGERED_)BUFFER in Kconfig
      iio: resolver: ad2s1210 add missing select REGMAP in Kconfig
      iio: resolver: ad2s1210: add missing select (TRIGGERED_)BUFFER in Kconfig
      iio: frequency: adf4377: add missing select REMAP_SPI in Kconfig
      iio: amplifiers: ada4250: add missing select REGMAP_SPI in Kconfig
      iio: dac: ad5770r: add missing select REGMAP_SPI in Kconfig
      iio: dac: ltc1660: add missing select REGMAP_SPI in Kconfig
      iio: dac: stm32-dac-core: add missing select REGMAP_MMIO in Kconfig
      iio: adc: ti-ads8688: add missing select IIO_(TRIGGERED_)BUFFER in Kconfig
      iio: frequency: {admv4420,adrf6780}: format Kconfig entries
      iio: frequency: admv4420: fix missing select REMAP_SPI in Kconfig

Jonathan Cameron (1):
      iio: pressure: sdp500: Add missing select CRC8

Mikhail Lobanov (1):
      iio: accel: bma400: Fix uninitialized variable field_value in tap event handling.

Mohammed Anees (1):
      iioc: dac: ltc2664: Fix span variable usage in ltc2664_channel_config()

Nathan Chancellor (1):
      iio: bmi323: Drop CONFIG_PM guards around runtime functions

Rob Herring (Arm) (1):
      dt-bindings: iio: dac: adi,ad56xx: Fix duplicate compatible strings

Takashi Iwai (1):
      parport: Proper fix for array out-of-bounds access

Yo-Jung (Leo) Lin (1):
      misc: rtsx: list supported models in Kconfig help

 .../devicetree/bindings/iio/dac/adi,ad5686.yaml    |  53 ++----
 .../devicetree/bindings/iio/dac/adi,ad5696.yaml    |   3 +-
 MAINTAINERS                                        | 178 ---------------------
 drivers/iio/accel/Kconfig                          |   2 +
 drivers/iio/accel/bma400_core.c                    |   3 +-
 drivers/iio/adc/Kconfig                            |  11 ++
 drivers/iio/amplifiers/Kconfig                     |   1 +
 drivers/iio/chemical/Kconfig                       |   2 +
 .../iio/common/hid-sensors/hid-sensor-trigger.c    |   2 +-
 drivers/iio/dac/Kconfig                            |   7 +
 drivers/iio/dac/ltc2664.c                          |  17 +-
 drivers/iio/frequency/Kconfig                      |  32 ++--
 drivers/iio/imu/bmi323/bmi323_core.c               |  23 ++-
 drivers/iio/light/Kconfig                          |   2 +
 drivers/iio/light/opt3001.c                        |   4 +
 drivers/iio/light/veml6030.c                       |   5 +-
 drivers/iio/magnetometer/Kconfig                   |   2 +
 drivers/iio/pressure/Kconfig                       |   4 +
 drivers/iio/proximity/Kconfig                      |   2 +
 drivers/iio/resolver/Kconfig                       |   3 +
 drivers/misc/cardreader/Kconfig                    |   3 +-
 drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_otpe2p.c  |   2 +
 drivers/parport/procfs.c                           |  22 +--
 23 files changed, 116 insertions(+), 267 deletions(-)


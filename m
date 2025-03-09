Return-Path: <linux-kernel+bounces-553252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7756A5865B
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 18:42:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 739D33A9A9C
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 17:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9F761E8325;
	Sun,  9 Mar 2025 17:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="e7QpZQb9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1FA3D528
	for <linux-kernel@vger.kernel.org>; Sun,  9 Mar 2025 17:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741542156; cv=none; b=GVQN6fubOzJ/jO71ZXOcketR7BUAuZ2KxluqA4iX54tgATFoWb+Peh724R0dUXTJPePSgrwpUUZqOYL3H+ClVt5b7QvtEmOnWKdscQX7q3m3jCJ6hO2IDkl9ECUNC3cy3BK59NQENXY/zkc20bi6bCNjqcwnJermKq8kcWdSv7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741542156; c=relaxed/simple;
	bh=UEZpr9eOIGxN0JgxywxFymcfK0GqLpA1f0L96sX226M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=F+ZAQLgundiLVf9piNmq6izo5iXI9d8+5iKy12vHxBF20McSj4iHR+ixk+uiADmAVwkWlS7Hgs4mv8eWI/JAyldKSLtD3di4UN/TZcmOkKCvZFM48DbI16fyQwQA8QpUUUscf54JdZRYJ9s8Sr0vudpdgUVDi7KvXEXxpPl+nls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=e7QpZQb9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A4EEC4CEEC;
	Sun,  9 Mar 2025 17:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741542155;
	bh=UEZpr9eOIGxN0JgxywxFymcfK0GqLpA1f0L96sX226M=;
	h=Date:From:To:Cc:Subject:From;
	b=e7QpZQb9tqb4EnqKG5Yi43Lmv9jqz3ucwnUGvBtE1P0MsEKHKumabkDmNSyTs1oHc
	 eRsf2Oi/yCkCaD516LcdCwTcQhLXk8CmpG1RSKBvKne5NfLkjJ6Jr33S+TszgMz5QQ
	 jMdloAwcNU1eCudP8WpWv8/Jrw71Nyx55QsYsuSI=
Date: Sun, 9 Mar 2025 18:42:32 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Char/Misc/IIO driver fixes for 6.14-rc6
Message-ID: <Z83TCEMlzC7MlW77@kroah.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit a64dcfb451e254085a7daee5fe51bf22959d52d3:

  Linux 6.14-rc2 (2025-02-09 12:45:03 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.14-rc6

for you to fetch changes up to 2397d61ee45cddb8f3bd3a3a9840ef0f0b5aa843:

  Revert "drivers/card_reader/rtsx_usb: Restore interrupt based detection" (2025-02-27 12:24:53 -0800)

----------------------------------------------------------------
Char/Misc/IIO driver fixes for 6.14-rc6

Here are a number of misc and char and iio driver fixes that have been
sitting in my tree for way too long, and should be merged for 6.14-rc6.
They contain:
  - iio driver fixes for reported issues
  - regression fix for rtsx_usb card reader
  - mei and mhi driver fixes
  - small virt driver fixes
  - ntsync permissions fix
  - other tiny driver fixes for reported problems.

All of these have been in linux-next for quite a while with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alexander Shishkin (3):
      intel_th: msu: Fix less trivial kernel-doc warnings
      intel_th: pci: Add Panther Lake-H support
      intel_th: pci: Add Panther Lake-P/U support

Alexander Usyskin (1):
      mei: me: add panther lake P DID

Andy Shevchenko (2):
      intel_th: msu: Fix kernel-doc warnings
      eeprom: digsy_mtc: Make GPIO lookup table match the device

Angelo Dureghello (3):
      iio: dac: ad3552r: clear reset status flag
      dt-bindings: iio: dac: adi-axi-adc: fix ad7606 pwm-names
      iio: adc: ad7606: fix wrong scale available

Arnd Bergmann (1):
      vbox: add HAS_IOPORT dependency

Carlos Llamas (1):
      binderfs: fix use-after-free in binder_devices

Christian Heusel (1):
      Revert "drivers/card_reader/rtsx_usb: Restore interrupt based detection"

Dheeraj Reddy Jonnalagadda (1):
      iio: proximity: Fix use-after-free in hx9023s_send_cfg()

Eddie James (1):
      MAINTAINERS: change maintainer for FSI

Elizabeth Figura (1):
      ntsync: Check wait count based on byte size.

Greg Kroah-Hartman (2):
      Merge tag 'iio-fixes-for-6.14a' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/jic23/iio into char-misc-linus
      Merge tag 'mhi-fixes-for-v6.14' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/mani/mhi into char-misc-linus

Hans de Goede (1):
      mei: vsc: Use "wakeuphostint" when getting the host wakeup GPIO

Haoyu Li (1):
      drivers: virt: acrn: hsm: Use kzalloc to avoid info leak in pmcmd_ioctl

Javier Carrasco (1):
      iio: light: apds9306: fix max_scale_nano values

Johan Hovold (1):
      bus: simple-pm-bus: fix forced runtime PM use

Manivannan Sadhasivam (1):
      bus: mhi: host: pci_generic: Use pci_try_reset_function() to avoid deadlock

Markus Burri (1):
      iio: adc: ad7192: fix channel select

Mike Lothian (1):
      ntsync: Set the permissions to be 0666

Nayab Sayed (1):
      iio: adc: at91-sama5d2_adc: fix sama7g5 realbits value

Pawel Chmielewski (1):
      intel_th: pci: Add Arrow Lake support

Qiu-ji Chen (1):
      cdx: Fix possible UAF error in driver_override_show()

Ricardo Ribalda (1):
      iio: hid-sensor-prox: Split difference from multiple channels

Sam Winchenbach (1):
      iio: filter: admv8818: Force initialization of SDO

Thadeu Lima de Souza Cascardo (1):
      char: misc: deallocate static minor in error path

Victor Duicu (1):
      iio: adc: pac1921: Move ACPI_FREE() to cover all branches

Visweswara Tanuku (1):
      slimbus: messaging: Free transaction ID in delayed interrupt scenario

 .../devicetree/bindings/iio/adc/adi,ad7606.yaml    |  1 +
 MAINTAINERS                                        |  7 +--
 drivers/android/binderfs.c                         |  1 +
 drivers/bus/mhi/host/pci_generic.c                 |  5 +-
 drivers/bus/simple-pm-bus.c                        | 22 ++++++-
 drivers/cdx/cdx.c                                  |  6 +-
 drivers/char/misc.c                                |  2 +-
 drivers/hwtracing/intel_th/msu.c                   | 13 ++++-
 drivers/hwtracing/intel_th/pci.c                   | 15 +++++
 drivers/iio/adc/ad7192.c                           |  2 +-
 drivers/iio/adc/ad7606.c                           |  2 +-
 drivers/iio/adc/at91-sama5d2_adc.c                 | 68 +++++++++++++---------
 drivers/iio/adc/pac1921.c                          |  2 +-
 drivers/iio/dac/ad3552r.c                          |  6 ++
 drivers/iio/filter/admv8818.c                      | 14 ++---
 drivers/iio/light/apds9306.c                       |  4 +-
 drivers/iio/light/hid-sensor-prox.c                |  7 ++-
 drivers/iio/proximity/hx9023s.c                    |  3 +-
 drivers/misc/cardreader/rtsx_usb.c                 | 15 -----
 drivers/misc/eeprom/digsy_mtc_eeprom.c             |  2 +-
 drivers/misc/mei/hw-me-regs.h                      |  2 +
 drivers/misc/mei/pci-me.c                          |  2 +
 drivers/misc/mei/vsc-tp.c                          |  2 +-
 drivers/misc/ntsync.c                              |  7 ++-
 drivers/slimbus/messaging.c                        |  5 +-
 drivers/virt/acrn/hsm.c                            |  6 +-
 drivers/virt/vboxguest/Kconfig                     |  3 +-
 27 files changed, 139 insertions(+), 85 deletions(-)


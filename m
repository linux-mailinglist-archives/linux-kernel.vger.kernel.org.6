Return-Path: <linux-kernel+bounces-216243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85B8F909D06
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 12:52:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F3E6280ECC
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 10:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 569E118733B;
	Sun, 16 Jun 2024 10:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kGPNfhV0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B59349635;
	Sun, 16 Jun 2024 10:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718535138; cv=none; b=iwTU/pvx3piI3cPYiRETUKYamJhYDYu9XkZWTMFajVDfJy1wLtxnWpKgp5YjTNl7ntndfJ15ZA1N7vB7piSvmZ/txEHS58JV+7zLzr7v6zTh1f9SxGjK0XuI207xEHEIafUk8vhrbpXgjYAHR0/kcpzKYMtNnbS4KOR20daEVx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718535138; c=relaxed/simple;
	bh=aUAPC0HV8LaLH2VVEJdjSNkfPiNhNZMqCIfD7JiVzak=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=sXUpEL8W+b/JOAjC5eY/AO30I2EPbZosd9wHfgyjtTfjRUURi8uDvhSv55R2ydQ1dPJsi+aGcNfndNnmAE4pEHsIIcGS03wANS6Rg1jCsXr7J7HzxuovrWQE9ApXI3SN4+3GzMYOn8urvHLKmsAIoOX/aFmUlYqtgcONVkYkfQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kGPNfhV0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18DA5C2BBFC;
	Sun, 16 Jun 2024 10:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718535138;
	bh=aUAPC0HV8LaLH2VVEJdjSNkfPiNhNZMqCIfD7JiVzak=;
	h=Date:From:To:Cc:Subject:From;
	b=kGPNfhV0j2yZB7TfAvEcwDiozz0MglQ88ZIvtPh+SYscjVVNPq0sXl3IlAeZj6mQ0
	 VeCCQCHxhEv3Uso0H5mVvAM8GL3XmLlcasBuUXkk9Qnm1rNnFYvVaqh9WrLy4R5kss
	 OSKP8jdJp5iLvZoTNCA94zwLTT/aR+k/5b3DNRXA=
Date: Sun, 16 Jun 2024 12:52:15 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: [GIT PULL] USB/Thunderbolt driver fixes for 6.10-rc4
Message-ID: <Zm7D3-lc4t1sEinN@kroah.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit c3f38fa61af77b49866b006939479069cd451173:

  Linux 6.10-rc2 (2024-06-02 15:44:56 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.10-rc4

for you to fetch changes up to 22f00812862564b314784167a89f27b444f82a46:

  USB: class: cdc-wdm: Fix CPU lockup caused by excessive log messages (2024-06-14 08:47:59 +0200)

----------------------------------------------------------------
USB / Thunderbolt fixes for 6.10-rc4

Here are some small USB and Thunderbolt driver fixes for 6.10-rc4.
Included in here are:
  - thunderbolt debugfs bugfix
  - USB typec bugfixes
  - kcov usb bugfix
  - xhci bugfixes
  - usb-storage bugfix
  - dt-bindings bugfix
  - cdc-wdm log message spam bugfix

All of these, except for the last cdc-wdm log level change, have been in
linux-next for a while with no reported problems.  The cdc-wdm bugfix
has been tested by syzbot and proved to fix the reported cpu lockup
issues when the log is constantly spammed by a broken device.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Aapo Vienamo (1):
      thunderbolt: debugfs: Fix margin debugfs node creation condition

Alan Stern (1):
      USB: class: cdc-wdm: Fix CPU lockup caused by excessive log messages

Amit Sunil Dhamne (1):
      usb: typec: tcpm: fix use-after-free case in tcpm_register_source_caps

Andrey Konovalov (1):
      kcov, usb: disable interrupts in kcov_remote_start_usb_softirq

Greg Kroah-Hartman (1):
      Merge tag 'thunderbolt-for-v6.10-rc3' of git://git.kernel.org/pub/scm/linux/kernel/git/westeri/thunderbolt into usb-next

Hector Martin (1):
      xhci: Handle TD clearing for multiple streams case

Heikki Krogerus (1):
      usb: typec: ucsi: Ack also failed Get Error commands

Johan Hovold (1):
      usb: typec: ucsi: glink: increase max ports for x1e80100

John Ernberg (1):
      USB: xen-hcd: Traverse host/ when CONFIG_USB_XEN_HCD is selected

Kuangyi Chiang (2):
      xhci: Apply reset resume quirk to Etron EJ188 xHCI host
      xhci: Apply broken streams quirk to Etron EJ188 xHCI host

Kyle Tso (1):
      usb: typec: tcpm: Ignore received Hard Reset in TOGGLING state

Mathias Nyman (1):
      xhci: Set correct transferred length for cancelled bulk transfers

Peter Chen (1):
      Revert "usb: chipidea: move ci_ulpi_init after the phy initialization"

Rob Herring (Arm) (1):
      dt-bindings: usb: realtek,rts5411: Add missing "additionalProperties" on child nodes

Shichao Lai (1):
      usb-storage: alauda: Check whether the media is initialized

 .../devicetree/bindings/usb/realtek,rts5411.yaml   |  1 +
 drivers/thunderbolt/debugfs.c                      |  5 +-
 drivers/usb/Makefile                               |  1 +
 drivers/usb/chipidea/core.c                        |  8 +--
 drivers/usb/chipidea/ulpi.c                        |  5 ++
 drivers/usb/class/cdc-wdm.c                        |  4 +-
 drivers/usb/core/hcd.c                             | 12 +++--
 drivers/usb/host/xhci-pci.c                        |  7 +++
 drivers/usb/host/xhci-ring.c                       | 59 +++++++++++++++++-----
 drivers/usb/host/xhci.h                            |  1 +
 drivers/usb/storage/alauda.c                       |  9 ++--
 drivers/usb/typec/tcpm/tcpm.c                      |  5 +-
 drivers/usb/typec/ucsi/ucsi.c                      |  7 ++-
 drivers/usb/typec/ucsi/ucsi_glink.c                |  2 +-
 include/linux/kcov.h                               | 47 +++++++++++++----
 15 files changed, 131 insertions(+), 42 deletions(-)


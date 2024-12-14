Return-Path: <linux-kernel+bounces-446062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 702C69F1F60
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 15:36:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F376161E43
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 14:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F54A194A43;
	Sat, 14 Dec 2024 14:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NsoF+c5W"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88C3DDCD;
	Sat, 14 Dec 2024 14:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734186981; cv=none; b=m5ZQbZX3J24XHJZT9HVhDHa5epkdeMS3/xIWtwXaE1k+eP5n/27d1bOieFoCFqGJXqaqerSzENvrAtMqD0bkoBdeETZ+b3YnRl3bbaDS3Q6S85ftJvOJBhQbNEwHGM0/MevWPvE/gx1XkHeZzcFPlyX1UQi8noLCB5bJ2bOf1/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734186981; c=relaxed/simple;
	bh=gVANuzFDMvQJwwdQ69e2mepdO3dsfXwf2E5Rfp+9YwY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=b6fyxmxnH+PqW/MPqVc8bpNlyaDPZjGDtRP3urFfbMuqwu8mz8BslYmgKh5b4SxTatroBokODLQ0Soulle4adZ4cwSv9Jayto6jumYVHjKvA0Rprr6cFde4E2WSA1xtpyl3yZaCIYbaxVsecfwVT86TmDMEZWe7N6QjxJXOg3NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NsoF+c5W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C01BC4CED1;
	Sat, 14 Dec 2024 14:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734186981;
	bh=gVANuzFDMvQJwwdQ69e2mepdO3dsfXwf2E5Rfp+9YwY=;
	h=Date:From:To:Cc:Subject:From;
	b=NsoF+c5WInpk4Kd8MpG2RfylYTyCvt11cfITEmkdz01N9ChAkQN2EQs8BOGl8IHLb
	 qbrJpDRyP2pMg1EWv+aHw09G1g9tcbbX9gTLK+ZLYeLb37YF1gLL3Cn7cLeF327CsL
	 /T4jW9zgBYWREleFtiND60HnyKvydD7zRJNfVOiY=
Date: Sat, 14 Dec 2024 15:36:18 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: [GIT PULL] USB fixes for 6.13-rc3
Message-ID: <Z12X4vb79DECg-w2@kroah.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

The following changes since commit cdd30ebb1b9f36159d66f088b61aee264e649d7a:

  module: Convert symbol namespace to string literal (2024-12-02 11:34:44 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.13-rc3

for you to fetch changes up to 33ead7e538183b1348ba60af90027240a10de751:

  usb: typec: ucsi: Fix connector status writing past buffer size (2024-12-04 16:30:28 +0100)

----------------------------------------------------------------
USB driver fixes for 6.13-rc3

Here are some small USB driver fixes for some reported issues.  Included
in here are:
  - typec driver bugfixes
  - u_serial gadget driver bugfix for much reported and discussed issue
  - dwc2 bugfixes
  - midi gadget driver bugfix
  - ehci-hcd driver bugfix
  - other small bugfixes

All of these have been in linux-next for over a week with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Joe Hattori (2):
      usb: typec: anx7411: fix fwnode_handle reference leak
      usb: typec: anx7411: fix OF node reference leaks in anx7411_typec_switch_probe()

Lianqin Hu (1):
      usb: gadget: u_serial: Fix the issue that gs_start_io crashed due to accessing null pointer

Lucas De Marchi (1):
      usb: typec: ucsi: Fix connector status writing past buffer size

Mark Tomlinson (1):
      usb: host: max3421-hcd: Correctly abort a USB request.

Neal Frager (1):
      usb: dwc3: xilinx: make sure pipe clock is deselected in usb2 only mode

Radhey Shyam Pandey (1):
      usb: misc: onboard_usb_dev: skip suspend/resume sequence for USB5744 SMBus support

Stefan Wahren (3):
      usb: dwc2: Fix HCD resume
      usb: dwc2: hcd: Fix GetPortStatus & SetPortFeature
      usb: dwc2: Fix HCD port connection race

Takashi Iwai (1):
      usb: gadget: midi2: Fix interpretation of is_midi1 bits

Vitalii Mordan (1):
      usb: ehci-hcd: fix call balance of clocks handling routines

Xu Yang (3):
      dt-bindings: phy: imx8mq-usb: correct reference to usb-switch.yaml
      usb: dwc3: imx8mp: fix software node kernel dump
      usb: core: hcd: only check primary hcd skip_phy_initialization

Łukasz Bartosik (1):
      usb: typec: ucsi: Fix completion notifications

 .../bindings/phy/fsl,imx8mq-usb-phy.yaml           |  7 +--
 drivers/usb/core/hcd.c                             |  8 ++-
 drivers/usb/dwc2/hcd.c                             | 19 +++----
 drivers/usb/dwc3/dwc3-imx8mp.c                     | 30 +++++-----
 drivers/usb/dwc3/dwc3-xilinx.c                     |  5 +-
 drivers/usb/gadget/function/f_midi2.c              |  6 +-
 drivers/usb/gadget/function/u_serial.c             |  9 ++-
 drivers/usb/host/ehci-sh.c                         |  9 ++-
 drivers/usb/host/max3421-hcd.c                     | 16 ++++--
 drivers/usb/misc/onboard_usb_dev.c                 |  4 +-
 drivers/usb/typec/anx7411.c                        | 66 ++++++++++++++--------
 drivers/usb/typec/ucsi/ucsi.c                      |  9 ++-
 12 files changed, 116 insertions(+), 72 deletions(-)


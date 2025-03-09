Return-Path: <linux-kernel+bounces-553255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21841A58666
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 18:43:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F11B160C59
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 17:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 895681EDA2F;
	Sun,  9 Mar 2025 17:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eoM2n4m7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7161E32D4;
	Sun,  9 Mar 2025 17:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741542213; cv=none; b=Yi+t6pW8qPLEEraLAKExa7u+oKQRRNTQH3mVIk0MnsiJJd9IBss84IpPrOxOakq9DIebVU9Q3uzzmvUkCMkc2MlyN5zZAftp0+TW5L04H5243uHRRO/Z+lMjPopSWqGavoOKOiJ+yp6J510Se57YwUS+IKkv+dwz8UG/4BE6YLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741542213; c=relaxed/simple;
	bh=kooIwOa6gEwB7oowS6HnKkkk+bXe9+cqX/oG5DutbCI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=p82HAW9CLUDiL3fbnIM/5FOzxaJTyIhdSWsv2OKZPWbrJT0aM+25OJu0QPx+bDYlu52amcJSE0ftLX4pBL4pXbtu/Z5OFGqputpBRdFCfr+01s9xSaL8MhIP9SFdDq/KuFjEg5x7EONFL8+u2xyxIi3qzOU41F7Gs07cZ4aeq8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eoM2n4m7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57DA3C4CEE3;
	Sun,  9 Mar 2025 17:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741542212;
	bh=kooIwOa6gEwB7oowS6HnKkkk+bXe9+cqX/oG5DutbCI=;
	h=Date:From:To:Cc:Subject:From;
	b=eoM2n4m7hMlsupBdio1sV6TdFuFaJb59mZseqCvOGjPfAQmlAvSk06Xg2GMtLXzd6
	 Py6HhqhNqDk8AwcDXOmuoNFMwKgVtnFZuEHNoG5RMsYKpugscXTR2hvpeS9li0Kv5e
	 TlJKUpUwFezap/iS5kmQ8/FrlkOQEiBs6pKuXROU=
Date: Sun, 9 Mar 2025 18:43:29 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: [GIT PULL] USB driver fixes for 6.14-rc6
Message-ID: <Z83TQTyh4u64yFKF@kroah.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 0ad2507d5d93f39619fc42372c347d6006b64319:

  Linux 6.14-rc3 (2025-02-16 14:02:44 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.14-rc6

for you to fetch changes up to b13abcb7ddd8d38de769486db5bd917537b32ab1:

  usb: typec: ucsi: Fix NULL pointer access (2025-03-06 16:55:46 +0100)

----------------------------------------------------------------
USB fixes for 6.14-rc6

Here are some small USB driver fixes for some reported issues for
6.14-rc6.  These contain:
  - typec driver fixes
  - dwc3 driver fixes
  - xhci driver fixes
  - renesas controller fixes
  - gadget driver fixes
  - a new USB quirk added

All of these have been in linux-next with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Andrei Kuchynski (1):
      usb: typec: ucsi: Fix NULL pointer access

AngeloGioacchino Del Regno (1):
      usb: typec: tcpci_rt1711h: Unmask alert interrupts to fix functionality

Badhri Jagan Sridharan (1):
      usb: dwc3: gadget: Prevent irq storm when TH re-executes

Christian A. Ehrhardt (1):
      acpi: typec: ucsi: Introduce a ->poll_cci method

Claudiu Beznea (3):
      usb: renesas_usbhs: Call clk_put()
      usb: renesas_usbhs: Use devm_usb_get_phy()
      usb: renesas_usbhs: Flush the notify_hotplug_work

Fedor Pchelkin (1):
      usb: typec: ucsi: increase timeout for PPM reset operations

Marc Zyngier (1):
      xhci: Restrict USB4 tunnel detection for USB3 devices to Intel hosts

Marek Szyprowski (1):
      usb: gadget: Fix setting self-powered state on suspend

Miao Li (1):
      usb: quirks: Add DELAY_INIT and NO_LPM for Prolific Mass Storage Card Reader

Michal Pecio (2):
      usb: xhci: Enable the TRB overfetch quirk on VIA VL805
      usb: xhci: Fix host controllers "dying" after suspend and resume

Nikita Zhandarovich (1):
      usb: atm: cxacru: fix a flaw in existing endpoint checks

Pawel Laszczak (1):
      usb: hub: lack of clearing xHC resources

Prashanth K (3):
      usb: gadget: u_ether: Set is_suspend flag if remote wakeup fails
      usb: gadget: Set self-powered based on MaxPower and bmAttributes
      usb: gadget: Check bmAttributes only if configuration is valid

Thinh Nguyen (1):
      usb: dwc3: Set SUSPENDENABLE soon after phy init

 drivers/usb/atm/cxacru.c                | 13 ++---
 drivers/usb/core/hub.c                  | 33 +++++++++++++
 drivers/usb/core/quirks.c               |  4 ++
 drivers/usb/dwc3/core.c                 | 85 +++++++++++++++++++--------------
 drivers/usb/dwc3/core.h                 |  2 +-
 drivers/usb/dwc3/drd.c                  |  4 +-
 drivers/usb/dwc3/gadget.c               | 10 ++--
 drivers/usb/gadget/composite.c          | 17 +++++--
 drivers/usb/gadget/function/u_ether.c   |  4 +-
 drivers/usb/host/xhci-hub.c             |  8 ++++
 drivers/usb/host/xhci-mem.c             |  3 +-
 drivers/usb/host/xhci-pci.c             | 10 ++--
 drivers/usb/host/xhci.c                 |  6 ++-
 drivers/usb/host/xhci.h                 |  2 +-
 drivers/usb/renesas_usbhs/common.c      |  6 ++-
 drivers/usb/renesas_usbhs/mod_gadget.c  |  2 +-
 drivers/usb/typec/tcpm/tcpci_rt1711h.c  | 11 +++++
 drivers/usb/typec/ucsi/ucsi.c           | 25 +++++-----
 drivers/usb/typec/ucsi/ucsi.h           |  2 +
 drivers/usb/typec/ucsi/ucsi_acpi.c      | 21 +++++---
 drivers/usb/typec/ucsi/ucsi_ccg.c       |  1 +
 drivers/usb/typec/ucsi/ucsi_glink.c     |  1 +
 drivers/usb/typec/ucsi/ucsi_stm32g0.c   |  1 +
 drivers/usb/typec/ucsi/ucsi_yoga_c630.c |  1 +
 24 files changed, 189 insertions(+), 83 deletions(-)


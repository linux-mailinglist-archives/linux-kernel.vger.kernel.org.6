Return-Path: <linux-kernel+bounces-516627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB302A374F1
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 16:12:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 556E93AE84F
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 15:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD61919AD8C;
	Sun, 16 Feb 2025 15:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Q2XsXAk0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00AEB19922F;
	Sun, 16 Feb 2025 15:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739718691; cv=none; b=lUbfiSaRqRvcaTyBB3Cc8JyDGrA4Oc91EwzqlaAs1REre2Umv6vSeeEWDm/tt6rkPjok236CqM5x+3JP12QBZ7B9ozmoZ6ld4Q87M4BnAzEa/AkRZ7zQfUcr5c2Mszl36iJTzRXx5/NX3wMjyy7J7vfvjcnOWh4RYduCnmTbNE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739718691; c=relaxed/simple;
	bh=z/OLY4YRzvkNUpCZOdt95MpYesHqy52Km8Xx8k2b+v4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=HeXtC55zpAtqILcVU2adlYitYjIjiScVBZuNxhZGxaYQZPpYndldjSejQCQYehTRM4MCBk12zZSadjjBTsRxwaOI+RgEwSHlT0MbEkBPZHnvHb4vkKw/Z2JQpvXuN7GJ4uFAwDDtuMsC8GD6JrBc2OQbwhTSeT+Q5Ots+A8dSbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Q2XsXAk0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38C1CC4CEDD;
	Sun, 16 Feb 2025 15:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739718690;
	bh=z/OLY4YRzvkNUpCZOdt95MpYesHqy52Km8Xx8k2b+v4=;
	h=Date:From:To:Cc:Subject:From;
	b=Q2XsXAk091+8BHDP/O1Y8ja+2niZFEW4q7L1jiOZDex46cVl8wcaHVBTbFULcAowW
	 GllSTYbCNmKZtEfD9lWkPdvZAZUwGaIAoyB5F/FoIGYnLSK7o07izIc13CcDw4UcL8
	 nQPksRfK7o1V9ldbtkCVUfYmuDzKxnwz0SFmQXE0=
Date: Sun, 16 Feb 2025 16:11:27 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: [GIT PULL] USB driver fixes for 6.14-rc3
Message-ID: <Z7IAH0twfNXO-j_m@kroah.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 2014c95afecee3e76ca4a56956a936e23283f05b:

  Linux 6.14-rc1 (2025-02-02 15:39:26 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.14-rc3

for you to fetch changes up to 659f5d55feb75782bd46cf130da3c1f240afe9ba:

  usb: typec: tcpm: PSSourceOffTimer timeout in PR_Swap enters ERROR_RECOVERY (2025-02-14 09:26:44 +0100)

----------------------------------------------------------------
USB fixes for 6.14-rc3

Here are some small USB driver fixes, and new device ids, for 6.14-rc3.
Lots of tiny stuff for reported problems, including:
  - new device ids and quirks
  - usb hub crash fix found by syzbot
  - dwc2 driver fix
  - dwc3 driver fixes
  - uvc gadget driver fix
  - cdc-acm driver fixes for a variety of different issues
  - other tiny bugfixes

Almost all of these have been in linux-next this week, and all have
passed 0-day testing.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alan Stern (1):
      USB: hub: Ignore non-compliant devices with too many configs or interfaces

Alexander Stein (1):
      usb: phy: generic: Use proper helper for property detection

Chester A. Unal (1):
      USB: serial: option: add MeiG Smart SLM828

Elson Roy Serrao (1):
      usb: roles: set switch registered flag early on

Fabio Porcedda (2):
      USB: serial: option: add Telit Cinterion FN990B compositions
      USB: serial: option: fix Telit Cinterion FN990A name

Fabrice Gasnier (1):
      usb: dwc2: gadget: remove of_node reference upon udc_stop

Frederic Weisbecker (1):
      usb: gadget: uvc: Fix unstarted kthread worker

Greg Kroah-Hartman (1):
      Merge tag 'usb-serial-6.14-rc3' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial into usb-linus

Guo Ren (1):
      usb: gadget: udc: renesas_usb3: Fix compiler warning

Huacai Chen (1):
      USB: pci-quirks: Fix HCCPARAMS register error for LS7A EHCI

Jann Horn (2):
      usb: cdc-acm: Check control transfer buffer size before access
      usb: cdc-acm: Fix handling of oversized fragments

Jill Donahue (1):
      USB: gadget: f_midi: f_midi_complete to call queue_work

Johan Hovold (1):
      USB: serial: option: drop MeiG Smart defines

John Keeping (1):
      usb: gadget: f_midi: fix MIDI Streaming descriptor lengths

Jos Wang (1):
      usb: typec: tcpm: PSSourceOffTimer timeout in PR_Swap enters ERROR_RECOVERY

Lei Huang (1):
      USB: quirks: add USB_QUIRK_NO_LPM quirk for Teclast dist

Marek Vasut (1):
      USB: cdc-acm: Fill in Renesas R-Car D3 USB Download mode quirk

Mathias Nyman (1):
      USB: Add USB_QUIRK_NO_LPM quirk for sony xperia xz1 smartphone

Michal Pecio (1):
      usb: xhci: Restore xhci_pci support for Renesas HCs

Roy Luo (1):
      usb: gadget: core: flush gadget workqueue after device removal

Selvarasu Ganesan (2):
      usb: gadget: f_midi: Fixing wMaxPacketSize exceeded issue during MIDI bind retries
      usb: dwc3: Fix timeout issue during controller enter/exit from halt state

Stefan Eichenberger (1):
      usb: core: fix pipe creation for get_bMaxPacketSize0

Thinh Nguyen (1):
      usb: dwc3: Document nostream_work

 drivers/usb/class/cdc-acm.c             | 28 ++++++++++++++-----
 drivers/usb/core/hub.c                  | 14 ++++++++--
 drivers/usb/core/quirks.c               |  6 ++++
 drivers/usb/dwc2/gadget.c               |  1 +
 drivers/usb/dwc3/core.h                 |  1 +
 drivers/usb/dwc3/gadget.c               | 34 +++++++++++++++++++++++
 drivers/usb/gadget/function/f_midi.c    | 19 +++++++++----
 drivers/usb/gadget/function/uvc_video.c |  2 +-
 drivers/usb/gadget/udc/core.c           |  2 +-
 drivers/usb/gadget/udc/renesas_usb3.c   |  2 +-
 drivers/usb/host/pci-quirks.c           |  9 ++++++
 drivers/usb/host/xhci-pci.c             |  7 +++--
 drivers/usb/phy/phy-generic.c           |  2 +-
 drivers/usb/roles/class.c               |  5 ++--
 drivers/usb/serial/option.c             | 49 +++++++++++++++++++--------------
 drivers/usb/typec/tcpm/tcpm.c           |  3 +-
 16 files changed, 139 insertions(+), 45 deletions(-)


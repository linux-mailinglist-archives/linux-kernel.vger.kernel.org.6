Return-Path: <linux-kernel+bounces-168924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6BEC8BBFCE
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 10:35:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D86301C20AA1
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 08:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE146FBF;
	Sun,  5 May 2024 08:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wpPJP+9k"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88253186A;
	Sun,  5 May 2024 08:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714898123; cv=none; b=IJRXcKcAfzPDPE0nO0dhHuld5io5PbjNssYay32QfFPkFPBF8/4A6dEZujEocyjCtM5wRzwLpZWqtalUy0MjVyssSmgFsEE2xUA6QnJZ7dYCUPc9h9ctbVdkuSPYDflXLROWAlZ59QR5n0aj5z9t9P0SmIIGCWbNhrR1JIEoTSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714898123; c=relaxed/simple;
	bh=kfRg1x/iwrvmpSvQGJJsu2tMA5F4zShZabXJ/5yEDE0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=PVPGuCOxqPzUl0BRWDeEvXE0pRm2k1Lb6VnOilBBrGdRen8FAIxjSdWg0VCNu/IuuJCKKLfXTvYAtAbVp+P3ZbBApUItY3kqfHk9AV3YTb2JxOSvkR+g48cK+Sjf8f5yRsuoLPFDYPaD2FXPJjg9a2qnlecw8XTfs38cSJItLbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wpPJP+9k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9595FC113CC;
	Sun,  5 May 2024 08:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714898123;
	bh=kfRg1x/iwrvmpSvQGJJsu2tMA5F4zShZabXJ/5yEDE0=;
	h=Date:From:To:Cc:Subject:From;
	b=wpPJP+9k5j0phuTQaHp1hB9lX+0LzVmgvIn9qGxLIEg+3+8iwy4O9SXccFkUF4QDF
	 NJtcl19abkd5xRVV6gftDsdtI7Hqlc6WiIqjzFG/uyYkYHIiSaBFrViKfKEA5Dgqai
	 cr2oNb/yOh13LcQuKfe+EYWjCDtFzn5f2n8JhRoo=
Date: Sun, 5 May 2024 09:35:20 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: [GIT PULL] USB driver fixes for 6.9-rc7
Message-ID: <ZjdEyLmMIZ1_TPA3@kroah.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit ed30a4a51bb196781c8058073ea720133a65596f:

  Linux 6.9-rc5 (2024-04-21 12:35:54 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.9-rc7

for you to fetch changes up to ae11f04b452b5205536e1c02d31f8045eba249dd:

  usb: typec: tcpm: Check for port partner validity before consuming it (2024-04-30 19:44:45 +0200)

----------------------------------------------------------------
USB driver fixes for 6.9-rc7

Here are some small USB driver fixes for reported problems for 6.9-rc7.
Included in here are:
  - usb core fixes for found issues
  - typec driver fixes for reported problems
  - usb gadget driver fixes for reported problems
  - xhci build fixes
  - dwc3 driver fixes for reported issues

All of these have been in linux-next this past week with no reported
problems.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alan Stern (2):
      USB: core: Fix access violation during port device removal
      usb: Fix regression caused by invalid ep0 maxpacket in virtual SuperSpeed device

Amit Sunil Dhamne (1):
      usb: typec: tcpm: unregister existing source caps before re-registration

Badhri Jagan Sridharan (1):
      usb: typec: tcpm: Check for port partner validity before consuming it

Chris Wulff (1):
      usb: gadget: f_fs: Fix a race condition when processing setup packets.

Guenter Roeck (1):
      usb: ohci: Prevent missed ohci interrupts

Ivan Avdeev (1):
      usb: gadget: uvc: use correct buffer size when parsing configfs lists

Johan Hovold (2):
      usb: typec: qcom-pmic: fix use-after-free on late probe errors
      usb: typec: qcom-pmic: fix pdphy start() error handling

Peter Korsgaard (1):
      usb: gadget: composite: fix OS descriptors w_value logic

RD Babiera (3):
      usb: typec: tcpm: queue correct sop type in tcpm_queue_vdm_unlocked
      usb: typec: tcpm: clear pd_event queue in PORT_RESET
      usb: typec: tcpm: enforce ready state when queueing alt mode vdm

Thinh Nguyen (2):
      usb: xhci-plat: Don't include xhci.h
      usb: dwc3: core: Prevent phy suspend during init

Wesley Cheng (1):
      usb: gadget: f_fs: Fix race between aio_cancel() and AIO request complete

 drivers/usb/core/hub.c                             |  5 +-
 drivers/usb/core/port.c                            |  8 +-
 drivers/usb/dwc3/core.c                            | 90 +++++++++-------------
 drivers/usb/dwc3/core.h                            |  1 +
 drivers/usb/dwc3/gadget.c                          |  2 +
 drivers/usb/dwc3/host.c                            | 27 +++++++
 drivers/usb/gadget/composite.c                     |  6 +-
 drivers/usb/gadget/function/f_fs.c                 |  9 ++-
 drivers/usb/gadget/function/uvc_configfs.c         |  4 +-
 drivers/usb/host/ohci-hcd.c                        |  8 ++
 drivers/usb/host/xhci-plat.h                       |  4 +-
 drivers/usb/host/xhci-rzv2m.c                      |  1 +
 drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c      |  8 +-
 .../usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy.c    | 11 ++-
 drivers/usb/typec/tcpm/tcpm.c                      | 42 +++++++---
 15 files changed, 147 insertions(+), 79 deletions(-)


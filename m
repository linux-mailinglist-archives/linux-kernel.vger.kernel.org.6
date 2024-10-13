Return-Path: <linux-kernel+bounces-362809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD16599B982
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 15:07:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 727491F217C3
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 13:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38A46144D01;
	Sun, 13 Oct 2024 13:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VK9miEWS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CEC41E51D;
	Sun, 13 Oct 2024 13:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728824854; cv=none; b=U4LgtjTuifFR1SttqB7SL1MXOs1upHdDUj+PgChOHISPhmWxF1Bqx/qkgZpaTwCnJfkLzEeKo72Adb0gdBGBQi3kf8sf8Ic1QuLVs29S22LOVMah5Buvnzdi7i1l9jKAB64DP3qKq8Q7CLberBu0bwGVWQt7ghfC2BnNKrtIXEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728824854; c=relaxed/simple;
	bh=S0emHyOBplzudHjncpQHCCSowxt0qEptdekaohNEJHw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=igHPDsO5QtfMELcTfV+IPNDs/8Dipwm9guC13BenvliMTnB17NiKnifREvD1a46IQg3WuIUIM/eW8NQ7kHvxWuW6pkrS01io2/nr7hC45tTCCS+GGgk6cfgeYrdSbOr4pVzgPRUsQPS2JZYyRS5asfCUAky/WrFoiqqPqREMapM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VK9miEWS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBAADC4CEC5;
	Sun, 13 Oct 2024 13:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728824854;
	bh=S0emHyOBplzudHjncpQHCCSowxt0qEptdekaohNEJHw=;
	h=Date:From:To:Cc:Subject:From;
	b=VK9miEWSCHWM824iwRxvDPz8whHzImjg4vByt/0KJTQ8LaTtndNs9TnLD1QZpYxOR
	 89gqvtXLO4TkjzO0yxFeBDAGDKpA1uwB0hPokD7cVYyBZaLJKgVR0cGPVIoASE8opl
	 zlGzIKO8y8NqJmhwxB/EgV2laKa72ptAcUjvJzDA=
Date: Sun, 13 Oct 2024 15:07:29 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: [GIT PULL] USB fixes for 6.12-rc3
Message-ID: <ZwvGEV3LouMEb3L1@kroah.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 9852d85ec9d492ebef56dc5f229416c925758edc:

  Linux 6.12-rc1 (2024-09-29 15:06:19 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.12-rc3

for you to fetch changes up to faa34159d08089036b6119c85e279fb36abb8bb5:

  net/9p/usbg: Fix build error (2024-10-09 09:56:40 +0200)

----------------------------------------------------------------
USB fixes for 6.12-rc3

Here are some small USB fixes for some reported problems for 6.12-rc3.
Include in here is:
  - fix for yurex driver that was caused in -rc1
  - build error fix for usbg network filesystem code
  - onboard_usb_dev build fix
  - dwc3 driver fixes for reported errors
  - gadget driver fix
  - new USB storage driver quirk
  - xhci resume bugfix

All of these have been in linux-next for a while with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Icenowy Zheng (1):
      usb: storage: ignore bogus device raised by JieLi BR21 USB sound chip

Jinjie Ruan (1):
      net/9p/usbg: Fix build error

John Keeping (1):
      usb: gadget: core: force synchronous registration

Jose Alberto Reguero (1):
      usb: xhci: Fix problem with xhci resume from suspend

Oliver Neukum (2):
      Revert "usb: yurex: Replace snprintf() with the safer scnprintf() variant"
      USB: yurex: kill needless initialization in yurex_read

Radhey Shyam Pandey (1):
      usb: misc: onboard_usb_dev: introduce new config symbol for usb5744 SMBus support

Roy Luo (1):
      usb: dwc3: re-enable runtime PM after failed resume

Selvarasu Ganesan (1):
      usb: dwc3: core: Stop processing of pending events if controller is halted

 drivers/usb/dwc3/core.c            | 30 ++++++++++++++++++++++--------
 drivers/usb/dwc3/core.h            |  4 ----
 drivers/usb/dwc3/gadget.c          | 11 -----------
 drivers/usb/gadget/udc/core.c      |  1 +
 drivers/usb/host/xhci-pci.c        |  5 +++++
 drivers/usb/misc/Kconfig           | 12 ++++++++++++
 drivers/usb/misc/onboard_usb_dev.c |  6 ++++--
 drivers/usb/misc/yurex.c           | 21 +++++++++------------
 drivers/usb/storage/unusual_devs.h | 11 +++++++++++
 net/9p/Kconfig                     |  2 ++
 10 files changed, 66 insertions(+), 37 deletions(-)


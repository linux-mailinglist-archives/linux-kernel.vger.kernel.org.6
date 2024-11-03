Return-Path: <linux-kernel+bounces-393797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC9E19BA558
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 13:02:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E4BD1C20958
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 12:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15CB416E895;
	Sun,  3 Nov 2024 12:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GwBfeXi/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A031632DF;
	Sun,  3 Nov 2024 12:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730635345; cv=none; b=E/+alLZEo6rNGvgPZdwzKWJ0TvYGLMfgN1djCWLcV4baumEBcCjNK2nycMf22p+UP0rSDOusxS8DvEU4GxIfyIlO0vC2yy+Nvn5NccLUEBgnMDKpm1MWzrwkslz7l/eHL2JVj+u2tHDaXXtCgMZ1XwpBjuH8tayH+chJFBvkzzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730635345; c=relaxed/simple;
	bh=Y4qG3SXaAVQ+YzeZZ3XeJ6pdiwxgT2z0KZ92aiDC474=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=kD5Z1xvwNoJdaZUfkcYReXMwkt48vkq8SyG9nkD01+nY7OLJ/75qLKt0IJXnHuTndfwIbqLUllW4Dx+rVl08EvXcBU17BgedbplxONfeXipzJlcg5608AZYnsWrV1D2cwICXKntfioClGrcPiCQ3oRanji99zghYkSPj/eynLiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GwBfeXi/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2E5DC4CECD;
	Sun,  3 Nov 2024 12:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730635345;
	bh=Y4qG3SXaAVQ+YzeZZ3XeJ6pdiwxgT2z0KZ92aiDC474=;
	h=Date:From:To:Cc:Subject:From;
	b=GwBfeXi/XPHHNDMheuWWCahNMr0fBVdXoYo2Jw2DP5wEhhoF1otuvwcCSXzgHfR27
	 2ksiFISJX2KzrAcn7gaEKZJtXri07tLrJHxOReqT6d9yYI0es639Z4/Qt3gFCiFAge
	 5YsETtcLETaYHVCW7UCDKI8Htz+UB+GpKSc9gADI=
Date: Sun, 3 Nov 2024 13:02:09 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: [GIT PULL] USB fixes for 6.12-rc6
Message-ID: <ZydmQblqRdfE3dZ5@kroah.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 42f7652d3eb527d03665b09edac47f85fb600924:

  Linux 6.12-rc4 (2024-10-20 15:19:38 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.12-rc6

for you to fetch changes up to afb92ad8733ef0a2843cc229e4d96aead80bc429:

  usb: typec: tcpm: restrict SNK_WAIT_CAPABILITIES_TIMEOUT transitions to non self-powered devices (2024-10-29 04:38:00 +0100)

----------------------------------------------------------------
USB / Thunderbolt fixes for 6.12-rc6

Here are some small USB and Thunderbolt driver fixes for 6.12-rc6 that
have been sitting in my tree this week.  Included in here are the
following:
  - thunderbolt driver fixes for reported issues
  - USB typec driver fixes
  - xhci driver fixes for reported problems
  - dwc2 driver revert for a broken change
  - usb phy driver fix
  - usbip tool fix

All of these have been in linux-next this week with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Amit Sunil Dhamne (1):
      usb: typec: tcpm: restrict SNK_WAIT_CAPABILITIES_TIMEOUT transitions to non self-powered devices

Basavaraj Natikar (1):
      xhci: Use pm_runtime_get to prevent RPM on unsupported systems

Faisal Hassan (1):
      xhci: Fix Link TRB DMA in command ring stopped completion event

Gil Fine (1):
      thunderbolt: Honor TMU requirements in the domain when setting TMU mode

Greg Kroah-Hartman (1):
      Merge tag 'thunderbolt-for-v6.12-rc5' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/westeri/thunderbolt into usb-linus

Javier Carrasco (4):
      usb: typec: qcom-pmic-typec: use fwnode_handle_put() to release fwnodes
      usb: typec: qcom-pmic-typec: fix missing fwnode removal in error path
      usb: typec: fix unreleased fwnode_handle in typec_port_register_altmodes()
      usb: typec: use cleanup facility for 'altmodes_node'

Mathias Nyman (1):
      usb: acpi: fix boot hang due to early incorrect 'tunneled' USB3 device links

Mika Westerberg (1):
      thunderbolt: Fix KASAN reported stack out-of-bounds read in tb_retimer_scan()

Stefan Wahren (1):
      Revert "usb: dwc2: Skip clock gating on Broadcom SoCs"

Zijun Hu (1):
      usb: phy: Fix API devm_usb_put_phy() can not release the phy

Zongmin Zhou (1):
      usbip: tools: Fix detach_port() invalid port error path

 drivers/thunderbolt/retimer.c                 |  5 +--
 drivers/thunderbolt/tb.c                      | 48 +++++++++++++++++++++++----
 drivers/usb/core/usb-acpi.c                   |  4 +--
 drivers/usb/dwc2/params.c                     |  1 -
 drivers/usb/host/xhci-pci.c                   |  6 ++--
 drivers/usb/host/xhci-ring.c                  | 16 ++++-----
 drivers/usb/phy/phy.c                         |  2 +-
 drivers/usb/typec/class.c                     |  6 ++--
 drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c | 10 +++---
 drivers/usb/typec/tcpm/tcpm.c                 | 10 ++++--
 tools/usb/usbip/src/usbip_detach.c            |  1 +
 11 files changed, 78 insertions(+), 31 deletions(-)


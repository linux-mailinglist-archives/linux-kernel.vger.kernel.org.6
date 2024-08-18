Return-Path: <linux-kernel+bounces-291097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DAE3955D37
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 17:38:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95529B20EDA
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 15:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2C4614375A;
	Sun, 18 Aug 2024 15:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YNPjGdUA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E226E23AD;
	Sun, 18 Aug 2024 15:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723995515; cv=none; b=HmumZZEgqyW5vo6prhHbQrUofpDAni94GgB7Jhp6g/7rdcqPV3zdL3zLYXBAsQIMOH8qF/dOlnICrsbVP2QiHD3h7cUeAZe8WIefBYg2+ZAHOahG/QvjFvjn1F6XaPw74m1MPxIwguWRkDuCv+KoG360XMDAG8+bWQfAsGAtF28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723995515; c=relaxed/simple;
	bh=ikNGWPWpIGBhSNPr3Cal2HGGnnrBGMuA6NvSuDnS8CU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=gJnRfFEHCwdV3beOtm4Ku/DrFv1IPAA6q+4XYFATAQ4qAw69ZBHdns8lb5iIz3kg54pDR3DUBUQaTtubnntFkWi693Z6A39fWxkHmOTHIrc3pHTtNsSHPGiOWfdOAcnigamKG9JG4bCH01zJVcg7oyFw8PGqhu6Acz+onm4I+js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YNPjGdUA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DAF6C32786;
	Sun, 18 Aug 2024 15:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723995514;
	bh=ikNGWPWpIGBhSNPr3Cal2HGGnnrBGMuA6NvSuDnS8CU=;
	h=Date:From:To:Cc:Subject:From;
	b=YNPjGdUASF0K46DBefCXEZTfYXxeIFr6McHjspuBkJzQ20y/+erjKnepVUi+H7SFl
	 ynv7k+WgWQwQ3NJV2dlM7T2P52kWzHahwOOHlrBdrSAytQJu0NoYDKpnngpQBi9eP0
	 r/Nc9SUkHlj598mGjL+V1iZgtCNBgJgvlzGPBHPE=
Date: Sun, 18 Aug 2024 17:38:31 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: [GIT PULL] USB / Thunderbolt driver fixes for 6.11-rc4
Message-ID: <ZsIVd2smm0EX27rL@kroah.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 7c626ce4bae1ac14f60076d00eafe71af30450ba:

  Linux 6.11-rc3 (2024-08-11 14:27:14 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.11-rc4

for you to fetch changes up to af8e119f52e9c13e556be9e03f27957554a84656:

  xhci: Fix Panther point NULL pointer deref at full-speed re-enumeration (2024-08-15 16:29:46 +0200)

----------------------------------------------------------------
USB / Thunderbolt driver fixes for 6.11-rc4

Here are some small USB and Thunderbolt driver fixes for 6.11-rc4 to
resolve some reported issues.  Included in here are:
  - thunderbolt driver fixes for reported problems
  - typec driver fixes
  - xhci fixes
  - new device id for ljca usb driver

All of these have been in linux-next this week with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Aapo Vienamo (1):
      thunderbolt: Fix memory leaks in {port|retimer}_sb_regs_write()

Greg Kroah-Hartman (1):
      Merge tag 'thunderbolt-for-v6.11-rc3' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/westeri/thunderbolt into usb-linus

Hans de Goede (1):
      usb: misc: ljca: Add Lunar Lake ljca GPIO HID to ljca_gpio_hids[]

Heikki Krogerus (1):
      usb: typec: ucsi: Fix the return value of ucsi_run_command()

Marc Zyngier (1):
      usb: xhci: Check for xhci->interrupters being allocated in xhci_mem_clearup()

Mathias Nyman (1):
      xhci: Fix Panther point NULL pointer deref at full-speed re-enumeration

Mika Westerberg (1):
      thunderbolt: Mark XDomain as unplugged when router is removed

Niklas Neronin (1):
      usb: xhci: fix duplicate stall handling in handle_tx_event()

Xu Yang (1):
      Revert "usb: typec: tcpm: clear pd_event queue in PORT_RESET"

 drivers/thunderbolt/debugfs.c | 10 ++++++----
 drivers/thunderbolt/switch.c  |  1 +
 drivers/usb/host/xhci-mem.c   |  2 +-
 drivers/usb/host/xhci-ring.c  |  1 +
 drivers/usb/host/xhci.c       |  8 +++++---
 drivers/usb/misc/usb-ljca.c   |  1 +
 drivers/usb/typec/tcpm/tcpm.c |  1 -
 drivers/usb/typec/ucsi/ucsi.c |  2 +-
 8 files changed, 16 insertions(+), 10 deletions(-)


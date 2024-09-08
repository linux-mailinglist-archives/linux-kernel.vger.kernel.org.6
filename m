Return-Path: <linux-kernel+bounces-320047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DFB397056F
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 09:49:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB2451F21ACA
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 07:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A92CA76410;
	Sun,  8 Sep 2024 07:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pY0m3qx+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE861B85F2;
	Sun,  8 Sep 2024 07:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725781747; cv=none; b=VANYF0mNs/jGcGafYpj2ZpbepfY+cNTWiIOT65fe2rW0fAInwaS/nDhZa3cGbee1UZf1h82rxO+99Bfa7c9Ym47aUDR5SZcJuyHsQ+0JbojIMuRSE+j28w+XObNepS94dUa7EQQZAGFzbuqjs1fd3TCM37xtYpQkqav2e+glSj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725781747; c=relaxed/simple;
	bh=jfRlReIDXQnYNay0fnkibvuBgNImTEwhhxtSRnxwvqg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Cd+gfpg+e7z08Qkgf/UkCpwc9nCCiNz8ufuNX8xP/nDMztwo8q9Z0GHB0x93OoXDhVR01cqQF1ksoOClQbx/ei2RgVcZvdyASMGEhx+7l2vzT2MfxxnphfFcMAJqC2MFJ4vzYhUP9+ItiyiD1NtDht8R3/5lc8tNEIfjOkraRFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pY0m3qx+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0E22C4CEC3;
	Sun,  8 Sep 2024 07:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725781746;
	bh=jfRlReIDXQnYNay0fnkibvuBgNImTEwhhxtSRnxwvqg=;
	h=Date:From:To:Cc:Subject:From;
	b=pY0m3qx+ig9PYQ5o2TjY2vlmSNgQXVgITlhd7IRL/TiVVO24XMP7IelWpuUGo9Tyb
	 cr8q9EbUdOMqSBd7zwdyv/JxSUhOzVpyk5uCliPQTVvhHvip9x3EzjoZkpBqcuEfLi
	 b4So9VBnZuaFire/goG/ydymhbT80EgpO/Sqm5Aw=
Date: Sun, 8 Sep 2024 09:49:03 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: [GIT PULL] USB driver fixes for 6.11-rc7
Message-ID: <Zt1W7_sJsYEfHDLu@kroah.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 431c1646e1f86b949fa3685efc50b660a364c2b6:

  Linux 6.11-rc6 (2024-09-01 19:46:02 +1200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.11-rc7

for you to fetch changes up to 87eb3cb4ec619299cd5572e1d5eb68aef4074ac2:

  usb: typec: ucsi: Fix cable registration (2024-09-03 19:26:18 +0200)

----------------------------------------------------------------
USB fixes for 6.11-rc7

Here are a handful of small USB fixes for 6.11-rc7.  Included in here
are:
  - dwc3 driver fixes for two reported problems
  - two typec ucsi driver fixes
  - cdns2 controller reset fix

All of these have been in linux-next this week with no reported
problems.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Faisal Hassan (1):
      usb: dwc3: core: update LC timer as per USB Spec V3.2

Heikki Krogerus (2):
      usb: typec: ucsi: Fix the partner PD revision
      usb: typec: ucsi: Fix cable registration

Pawel Laszczak (1):
      usb: cdns2: Fix controller reset issue

Prashanth K (1):
      usb: dwc3: Avoid waking up gadget during startxfer

 drivers/usb/dwc3/core.c                     | 15 ++++++
 drivers/usb/dwc3/core.h                     |  2 +
 drivers/usb/dwc3/gadget.c                   | 41 ++++++---------
 drivers/usb/gadget/udc/cdns2/cdns2-gadget.c | 12 ++---
 drivers/usb/gadget/udc/cdns2/cdns2-gadget.h |  9 ++++
 drivers/usb/typec/ucsi/ucsi.c               | 80 +++++++++++++++--------------
 drivers/usb/typec/ucsi/ucsi.h               |  1 -
 7 files changed, 87 insertions(+), 73 deletions(-)


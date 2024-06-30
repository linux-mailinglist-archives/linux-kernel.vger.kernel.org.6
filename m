Return-Path: <linux-kernel+bounces-235237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 13B7C91D1FA
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 16:12:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98E37B20C9A
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 14:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95F0814E2CC;
	Sun, 30 Jun 2024 14:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="axmNJQY9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3CFD1474B4;
	Sun, 30 Jun 2024 14:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719756714; cv=none; b=ZhvXicXl2lcLV6ZryktV+miBYjP0e3gT67rKRodXOM0ko/yF08m2sY2EqoUe9HmsI1DAeZOjMJWC2a07B4ns6jPaRtJNCkJvZOpVWPvb5jSpHTI01a0aKE4GTgrLhfIW7QaHevywpDrM0LOV53QlsgCB1tfixBfUfIAItUhZOjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719756714; c=relaxed/simple;
	bh=00tTz6jiapt35L8jKidRiTBV5oh83sFn0omMIT1H/yM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=JNcPSJB45LJYTL22QhpiX9qBKqVxPmRLLFkw8Lo2y3g79tbKfhcYQgPQN++sI4Go7BNuipNPskbUDITesd2JE9AM0SURhyHqX1nH0GjXQ9T4ud0U7g5A33HPxS1KiIH0x2O74BQ/nQM+CQqYhDBbjh8r75fdX+4Olj6XVaWuSvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=axmNJQY9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C80D6C2BD10;
	Sun, 30 Jun 2024 14:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719756714;
	bh=00tTz6jiapt35L8jKidRiTBV5oh83sFn0omMIT1H/yM=;
	h=Date:From:To:Cc:Subject:From;
	b=axmNJQY9Bm3D6yzxa1VNUUNUQUHgKLWGP94U3NFljpAsk8M4dvYEXnoKGFOa4HZqH
	 EE86DIqaC2yj6kaVdpTogMA8AYa9HIhkLApLtgCjifL6JxOLPGRcEmWYUXgm3+FrWO
	 KZQO0qMe0RfDSuxoIVnqUUIhipkR6CWg8aGm5rKY=
Date: Sun, 30 Jun 2024 16:11:46 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: [GIT PULL] USB driver fixes for 6.10-rc6
Message-ID: <ZoFnokzotlrCPKfs@kroah.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 6ba59ff4227927d3a8530fc2973b80e94b54d58f:

  Linux 6.10-rc4 (2024-06-16 13:40:16 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.10-rc6

for you to fetch changes up to fc1d1a712b517bbcb383b1f1f7ef478e7d0579f2:

  usb: dwc3: core: Workaround for CSR read timeout (2024-06-27 16:25:38 +0200)

----------------------------------------------------------------
USB fixes for 6.10-rc6

Here are a handful of small USB driver fixes for 6.10-rc6 to resolve
some reported issues.  Included in here are:
  - typec driver bugfixes
  - usb gadget driver reverts for commits that were reported to have
    problems
  - resource leak bugfix
  - gadget driver bugfixes
  - dwc3 driver bugfixes
  - usb atm driver bugfix for when syzbot got loose on it

All of these have been in linux-next this week with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Dan Carpenter (1):
      usb: musb: da8xx: fix a resource leak in probe()

Diogo Ivo (1):
      usb: typec: ucsi_acpi: Add LG Gram quirk

Fabrice Gasnier (1):
      usb: ucsi: stm32: fix command completion handling

Ferry Toth (2):
      Revert "usb: gadget: u_ether: Re-attach netif device to mirror detachment"
      Revert "usb: gadget: u_ether: Replace netif_stop_queue with netif_device_detach"

Javier Carrasco (1):
      usb: typec: ucsi: glink: fix child node release in probe function

Jeremy Kerr (1):
      usb: gadget: aspeed_udc: fix device address configuration

Jos Wang (1):
      usb: dwc3: core: Workaround for CSR read timeout

Meng Li (1):
      usb: dwc3: core: remove lock of otg mode during gadget suspend/resume to avoid deadlock

Nikita Zhandarovich (1):
      usb: atm: cxacru: fix endpoint checking in cxacru_bind()

Oliver Neukum (2):
      usb: gadget: printer: SS+ support
      usb: gadget: printer: fix races against disable

 drivers/usb/atm/cxacru.c                | 14 ++++++++
 drivers/usb/dwc3/core.c                 | 26 ++++++++++----
 drivers/usb/gadget/function/f_printer.c | 40 +++++++++++++++------
 drivers/usb/gadget/function/u_ether.c   |  4 +--
 drivers/usb/gadget/udc/aspeed_udc.c     |  4 +--
 drivers/usb/musb/da8xx.c                |  8 +++--
 drivers/usb/typec/ucsi/ucsi_acpi.c      | 61 +++++++++++++++++++++++++++++++++
 drivers/usb/typec/ucsi/ucsi_glink.c     |  5 ++-
 drivers/usb/typec/ucsi/ucsi_stm32g0.c   | 19 +++++++---
 9 files changed, 152 insertions(+), 29 deletions(-)


Return-Path: <linux-kernel+bounces-282263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3870A94E16C
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 15:25:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 078791C2097B
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 13:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2028114A602;
	Sun, 11 Aug 2024 13:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ru0Wcn2K"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF8014A0A0;
	Sun, 11 Aug 2024 13:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723382664; cv=none; b=NoFEsBi+Y6p6bHbmg9r20Kxj8NL60m4COzF+SUBPlC572Ive2dIFqGBUSXoPzYBXd3s3slPrPKIjDPmRJMIZhoxvTrh7EwLPUQ140sDQrdmSquK3UkSB3AU4zUcxbriS6gYOa2DEdhBd46+EgYmmVLPKImDtwkKqNNdq9VQxfOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723382664; c=relaxed/simple;
	bh=zFkf5A0SCILJybBzNgZN7vOViti+xx2JoLKzkJ4gsQk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=arRNZnukWq3H4aaq0lSonvK/Rh48C7B5h1UOueN+SCsAYHAp74uez+hxuLpTPd+ZzdpbxOL/myfb7MrTE3yVEdERcjS9/09xbRjooVer+Aim/YVOK8CBfB/8tmKWNY2yMW/0PM9/y0C3FMbxSGl89wmn/j6VETMQRafM6d9Ns0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ru0Wcn2K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61EE1C4AF0E;
	Sun, 11 Aug 2024 13:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723382663;
	bh=zFkf5A0SCILJybBzNgZN7vOViti+xx2JoLKzkJ4gsQk=;
	h=Date:From:To:Cc:Subject:From;
	b=Ru0Wcn2K4oYhLkw54tTkjMHvuEYyoNljeFQH437r8YF6fjd4hbmvijM0fxWk72pW/
	 7qvgtrkEcr+THj0dOLHTowKj5a+wNMM/8B8aBiYl8teYCrCJn0kAwEW8Yn35oHk1JB
	 Zl4lQ0n6jPTASZdIp7XhsPxe+H0hq/KWO2y29Jps=
Date: Sun, 11 Aug 2024 15:24:20 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: [GIT PULL] USB driver fixes for 6.11-rc3
Message-ID: <Zri7hMbzgp6fZeAa@kroah.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

The following changes since commit 8400291e289ee6b2bf9779ff1c83a291501f017b:

  Linux 6.11-rc1 (2024-07-28 14:19:55 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.11-rc3

for you to fetch changes up to 65ba8cef0416816b912c04850fc2468329994353:

  usb: typec: ucsi: Fix a deadlock in ucsi_send_command_common() (2024-08-07 12:48:30 +0200)

----------------------------------------------------------------
USB fixes for 6.11-rc3

Here are a number of small USB driver fixes for reported issues for
6.11-rc3.  Included in here are:
  - usb serial driver MODULE_DESCRIPTION() updates
  - usb serial driver fixes
  - typec driver fixes
  - usb-ip driver fix
  - gadget driver fixes
  - dt binding update

All of these have been in linux-next with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alexander Stein (1):
      dt-bindings: usb: microchip,usb2514: Add USB2517 compatible

Chris Wulff (2):
      usb: gadget: u_audio: Check return codes from usb_ep_enable and config_ep_by_speed.
      usb: gadget: core: Check for unset descriptor

Dan Carpenter (1):
      usb: typec: tcpci: Fix error code in tcpci_check_std_output_cap()

Dr. David Alan Gilbert (1):
      USB: serial: spcp8x5: remove unused struct 'spcp8x5_usb_ctrl_arg'

Greg Kroah-Hartman (2):
      Merge tag 'usb-serial-6.11-rc1' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial into usb-linus
      Merge tag 'usb-serial-6.11-rc2' of https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial into usb-linus

Harshit Mogalapalli (2):
      usb: typec: tipd: Fix dereferencing freeing memory in tps6598x_apply_patch()
      usb: typec: tipd: Delete extra semi-colon

Heikki Krogerus (1):
      usb: typec: ucsi: Fix a deadlock in ucsi_send_command_common()

Javier Carrasco (2):
      USB: serial: garmin_gps: annotate struct garmin_packet with __counted_by
      USB: serial: garmin_gps: use struct_size() to allocate pkt

Jeff Johnson (1):
      USB: serial: add missing MODULE_DESCRIPTION() macros

Konrad Dybcio (1):
      usb: typec: fsa4480: Check if the chip is really there

Marek Marczykowski-Górecki (1):
      USB: serial: debug: do not echo input by default

Oliver Neukum (1):
      usb: vhci-hcd: Do not drop references before new references are gained

Prashanth K (1):
      usb: gadget: u_serial: Set start_delayed during suspend

Takashi Iwai (1):
      usb: gadget: midi2: Fix the response for FB info with block 0xff

Tudor Ambarus (2):
      usb: gadget: f_fs: restore ffs_func_disable() functionality
      usb: gadget: f_fs: pull out f->disable() from ffs_func_set_alt()

Xu Yang (1):
      usb: typec: tcpm: avoid sink goto SNK_UNATTACHED state if not received source capability message

 .../devicetree/bindings/usb/microchip,usb2514.yaml |  1 +
 drivers/usb/gadget/function/f_fs.c                 | 32 ++++++++++-------
 drivers/usb/gadget/function/f_midi2.c              | 21 +++++++----
 drivers/usb/gadget/function/u_audio.c              | 42 +++++++++++++++++-----
 drivers/usb/gadget/function/u_serial.c             |  1 +
 drivers/usb/gadget/udc/core.c                      | 10 +++---
 drivers/usb/serial/ch341.c                         |  1 +
 drivers/usb/serial/garmin_gps.c                    |  5 ++-
 drivers/usb/serial/mxuport.c                       |  1 +
 drivers/usb/serial/navman.c                        |  1 +
 drivers/usb/serial/qcaux.c                         |  1 +
 drivers/usb/serial/spcp8x5.c                       | 10 ------
 drivers/usb/serial/symbolserial.c                  |  1 +
 drivers/usb/serial/usb-serial-simple.c             |  1 +
 drivers/usb/serial/usb_debug.c                     |  8 +++++
 drivers/usb/typec/mux/fsa4480.c                    | 14 ++++++++
 drivers/usb/typec/tcpm/tcpci.c                     |  2 +-
 drivers/usb/typec/tcpm/tcpm.c                      |  2 +-
 drivers/usb/typec/tipd/core.c                      |  4 +--
 drivers/usb/typec/ucsi/ucsi.c                      | 11 +++---
 drivers/usb/usbip/vhci_hcd.c                       |  9 +++--
 21 files changed, 119 insertions(+), 59 deletions(-)


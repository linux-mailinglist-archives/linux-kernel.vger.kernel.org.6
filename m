Return-Path: <linux-kernel+bounces-562900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 09179A63450
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 07:30:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49F6D172ED7
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 06:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C5C539A;
	Sun, 16 Mar 2025 06:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qquSHbMX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FCE62770B;
	Sun, 16 Mar 2025 06:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742106645; cv=none; b=PoBgTaQq/8NoeBvA9gEb09TBqS1bfMDyLj+whNiboBLB9HnOZZX3ftSFms7FlB7a+Hs8dj/LYhcYuKhmdgPJfiDWdcRAChghlAR/ShD7klhSdkdexJQir/PLxxg1jtiRWRbLankBjyIzgQ47uTq7evEQyP6IwKLNq8W83aVYjBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742106645; c=relaxed/simple;
	bh=raxiYwZUsxydXQsIsm3cGyAdb9IidnzShXs0ffe11OQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=lSanFy+fO/tWfzVDgK5qFb9NXFrCuiozo+XZeGnv3n5OYzE56EfkRpbT3yDAh8i2yRstNkvIgWsATUtjTINIlJnmmzDw4xfO99ORC7n2mVoLWanM4xmplDlm32u9MFqs6GDeQ/KYUsqitkjoYHszm7xgn9EjlW5CNK/aa/mB80c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qquSHbMX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32407C4CEDD;
	Sun, 16 Mar 2025 06:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742106644;
	bh=raxiYwZUsxydXQsIsm3cGyAdb9IidnzShXs0ffe11OQ=;
	h=Date:From:To:Cc:Subject:From;
	b=qquSHbMX+um+2K3eSOyA5jeqGQA3oeBKMqXDpbLSzxmezJAMYtZPEozwgC76D3RPa
	 TuIdppT24JyqNl/gJubZFrt8nEA+QJHQf/mwRQao5zm00MsCd36AzB/TZwZdHmp5MG
	 38zMHn7S8j6uLJS5dQ3Mfxhpv9RcQ3kjFuE7ctw4=
Date: Sun, 16 Mar 2025 07:30:41 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: [GIT PULL] USB / Thunderbolt driver fixes for 6.14-rc7
Message-ID: <Z9ZwEQ1io5PjNaAc@kroah.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 80e54e84911a923c40d7bee33a34c1b4be148d7a:

  Linux 6.14-rc6 (2025-03-09 13:45:25 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.14-rc7

for you to fetch changes up to f2865c6300d75a9f187dd7918d248e010970fd44:

  usb: typec: tcpm: fix state transition for SNK_WAIT_CAPABILITIES state in run_state_machine() (2025-03-14 09:15:20 +0100)

----------------------------------------------------------------
USB / Thunderbolt driver fixes and device ids for 6.14-rc7

Here are some small USB and Thunderbolt driver fixes and new usb-serial
device ids for 6.14-rc7.  Included in here are:
  - new usb-serial device ids
  - typec driver bugfix
  - thunderbolt driver resume bugfix

All of these have been in linux-next with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Amit Sunil Dhamne (1):
      usb: typec: tcpm: fix state transition for SNK_WAIT_CAPABILITIES state in run_state_machine()

Boon Khai Ng (1):
      USB: serial: ftdi_sio: add support for Altera USB Blaster 3

Fabio Porcedda (2):
      USB: serial: option: add Telit Cinterion FE990B compositions
      USB: serial: option: fix Telit Cinterion FE990A name

Greg Kroah-Hartman (2):
      Merge tag 'thunderbolt-for-v6.14-rc7' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/westeri/thunderbolt into usb-linus
      Merge tag 'usb-serial-6.14-rc7' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial into usb-linus

Johan Hovold (1):
      USB: serial: option: match on interface class for Telit FN990B

Mika Westerberg (1):
      thunderbolt: Prevent use-after-free in resume from hibernate

 drivers/thunderbolt/tunnel.c      | 11 ++++++---
 drivers/thunderbolt/tunnel.h      |  2 ++
 drivers/usb/serial/ftdi_sio.c     | 14 ++++++++++++
 drivers/usb/serial/ftdi_sio_ids.h | 13 +++++++++++
 drivers/usb/serial/option.c       | 48 ++++++++++++++++++++++++++-------------
 drivers/usb/typec/tcpm/tcpm.c     |  8 +++----
 6 files changed, 73 insertions(+), 23 deletions(-)


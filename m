Return-Path: <linux-kernel+bounces-247893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 580D192D604
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 18:15:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 010761F275E1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 16:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9188B198836;
	Wed, 10 Jul 2024 16:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eXWM/zA2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C925A1953AD;
	Wed, 10 Jul 2024 16:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720627928; cv=none; b=ZD7hygkk1Ufv/s6lMW1AbE3jci1Ivn8c07KWotCbfcMppeuQcpQgB+xL3/gas/H5HDe2rRUlqQkt82U3n6n7V8wo9hWgGNMB4GQ6E+YTWN4Z3YBDVrmgGNJ7P4mzwXpHsPDwsRvg5y6Na2FlApaUn61cpM2r+LawC2CMYNZKInU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720627928; c=relaxed/simple;
	bh=Bo6jSUGrFl7y8kG+fkYVw7mVgxl5zMIK0SOiQDtMkmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=bQ/f/8ZSMEa+btAhfB/lhNKQLp/2RwM/DMWhTvoHHDj4XOVluZULeA1b4qEvDSnSH5MQW/PUU7d8HrjV19/adJ3udr9yIoddS7pUJaU4QavtsW9f7QQ6xgUC7fNa6Y2pfvRNDFgqqTmDMhPiLEAzUUnEH2C5mz1wSRJG2esKYFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eXWM/zA2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62708C32786;
	Wed, 10 Jul 2024 16:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720627928;
	bh=Bo6jSUGrFl7y8kG+fkYVw7mVgxl5zMIK0SOiQDtMkmQ=;
	h=Date:From:To:Cc:Subject:From;
	b=eXWM/zA28dbGK775L917k6Q4E9SLMndj3HgogXhPHPlc8mmJGEsUngLcvEbWsHnBe
	 94EkXio1mj0acfXNBZ45uNOyI+EyL7MuRe0MFS++qJXGb1fQfkOAnubwxrKMyQPuEq
	 2kZxUC5FzNw4s/y/fxCsn/eZmTeDzk83kYjGAVcQ7hYSVZnp+60dt/EsY5MHkXb9au
	 jzbj9XZFkhkB/h/uVe0WpMko2qbwyXXtgXYQGRShwrU2ar+k7hUqMLZDtM/Qv4E2Qq
	 YeAkSX1mjO50H95pNVjPfqjas0j4/fEoHdmoUm2yRvFHyZDUjAW2pGmzS/5TnEEs+t
	 N656pxTENLuGA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1sRZvJ-000000006o7-3RIh;
	Wed, 10 Jul 2024 18:12:05 +0200
Date: Wed, 10 Jul 2024 18:12:05 +0200
From: Johan Hovold <johan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] USB-serial fixes for 6.10-rc8
Message-ID: <Zo6y1Y8IkNDlgqBf@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Greg,

I noticed that you still have some fixes queued for 6.10-rc8/final so figured
I'd send this now even if this addresses a really old bug. I've verified that
the issue is real and have tested the fix here myself. Feel free to queue it up
for 6.11-rc1 if you prefer.

Johan


The following changes since commit 4298e400dbdbf259549d69c349e060652ad53611:

  USB: serial: option: add Telit generic core-dump composition (2024-06-27 12:04:33 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git tags/usb-serial-6.10-rc8

for you to fetch changes up to c15a688e49987385baa8804bf65d570e362f8576:

  USB: serial: mos7840: fix crash on resume (2024-07-09 18:10:04 +0200)

----------------------------------------------------------------
USB-serial fixes for 6.10-rc8

Here's a fix for a long-standing issue in the mos7840 driver that can trigger
a crash when resuming from system suspend.

Included are also some new modem device ids.

All have been in linux-next with no reported issues.

----------------------------------------------------------------
Dmitry Smirnov (1):
      USB: serial: mos7840: fix crash on resume

Mank Wang (1):
      USB: serial: option: add Netprisma LCUK54 series modules

Slark Xiao (1):
      USB: serial: option: add support for Foxconn T99W651

Vanillan Wang (1):
      USB: serial: option: add Rolling RW350-GL variants

 drivers/usb/serial/mos7840.c | 45 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/usb/serial/option.c  | 28 +++++++++++++++++++++++++++
 2 files changed, 73 insertions(+)


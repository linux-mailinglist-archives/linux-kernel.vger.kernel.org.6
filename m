Return-Path: <linux-kernel+bounces-260347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C4493A79A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 21:13:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78AD01C21BEF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 19:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B205513DDB8;
	Tue, 23 Jul 2024 19:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kZj9Qdok"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017E813C9D3;
	Tue, 23 Jul 2024 19:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721761984; cv=none; b=Ryl3fWt2aQK6A4pySJpE/WMUTVj8y/w5NGONtmGSzvfj8xGmePx1+lhvVVC7MJZX+HixlJwU9DJ9+d+U9+wXl3BRj2nS59VSasGRapEf7v8rkmow0JJF3KfZdkjNTV0/ok3hPVpYXAeY/G2iimmQT2k+dVxlzVFEEEpOsDBxkOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721761984; c=relaxed/simple;
	bh=MNrLXLTSWXiOAR2IGZ7ZEM7ged6ey/Xto2hXwJ3G1og=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AE0ju6jQASqV6+2JirkI00khVp/IsUvsvebZwf8/BvAuIB7O613YbLOT9SJlt+paeJ46I4wYPaDtLN6SIIQqW7rZXNdieev4pujPIcv27Mv7LJ0DNo4U6EIo6rt0EiHTCSyEV4+U7F+LZZe6oAnf0fXqTszOLytUiWG+wXnd19A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kZj9Qdok; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C974C4AF09;
	Tue, 23 Jul 2024 19:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721761983;
	bh=MNrLXLTSWXiOAR2IGZ7ZEM7ged6ey/Xto2hXwJ3G1og=;
	h=From:To:Cc:Subject:Date:From;
	b=kZj9QdokioCHBqu0yPYv5w7yuGuzBROeYs22qnpuPZ56UsopIxYl9tk82EmfpjJZS
	 RdmalbxECgjdb9ixpV80QDd05hMLgW9xU5PMrCetRaKANji51lpe+OzoytTJB1XZDX
	 tE+1D0BYWekHtEDaUAb1bmsMPE7lmYkC5qjPstiWCGfLWtjs0yEBt0OnXQqS3Z3u+b
	 ezkUDMBIBiqvPCkffIOpHdsV1ES42ZdrEjPitmwJ3s2wq/zUtcPhZbzPMG4zOCJMqq
	 ONC+aza0Uz0izIKwELrggar7H8vbS+BHz4k2bW95eDZ6LkcwwDRLWUjxL1wcbo8khR
	 smwgnFVAXuq2g==
From: Bjorn Andersson <andersson@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-remoteproc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
	Gwenael Treuveur <gwenael.treuveur@foss.st.com>,
	Jeff Johnson <quic_jjohnson@quicinc.com>
Subject: [GIT PULL] rpmsg updates for v6.11
Date: Tue, 23 Jul 2024 12:17:49 -0700
Message-ID: <20240723191750.3703388-1-andersson@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


The following changes since commit 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0:

  Linux 6.10-rc1 (2024-05-26 15:20:12 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux.git tags/rpmsg-v6.11

for you to fetch changes up to 36862eab884d997e182aad9163cc6ca953614a68:

  rpmsg: char: add missing MODULE_DESCRIPTION() macro (2024-06-10 11:11:59 -0600)

----------------------------------------------------------------
rpmsg updates for v6.11

This corrects interrupt handling in the stm32 remoteproc driver when
being attached to an already running remote processor.
It fixes invalid kernel-doc and adds missing MODULE_DESCRIPTION() in the
rpmsg char driver.

----------------------------------------------------------------
Arnaud Pouliquen (1):
      rpmsg: char: Fix rpmsg_eptdev structure documentation

Gwenael Treuveur (1):
      remoteproc: stm32_rproc: Fix mailbox interrupts queuing

Jeff Johnson (1):
      rpmsg: char: add missing MODULE_DESCRIPTION() macro

 drivers/remoteproc/stm32_rproc.c | 2 +-
 drivers/rpmsg/rpmsg_char.c       | 5 +++--
 2 files changed, 4 insertions(+), 3 deletions(-)


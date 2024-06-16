Return-Path: <linux-kernel+bounces-216241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 022B4909D02
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 12:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FCEC1F213ED
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 10:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8CE9187329;
	Sun, 16 Jun 2024 10:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="U2EhW2K2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C2D1862BC;
	Sun, 16 Jun 2024 10:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718535092; cv=none; b=stHALAzLqRY84Br0iQId+XTvbiIFVqvmHKJsAl4i4ZaxyLdSnjWu7E96z6XsBcOIwEPoX2AvCypNNabaSeATcCMqhxn5k9VruuhQISocGz4ruNA0ocfjC8eQKy7OoRGcfDq+DydlOiqDLqo6pzBFm6LicBtO39IcIFXoqBmv6Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718535092; c=relaxed/simple;
	bh=0eELrSJysNrNj6umF99zEZ4yybfNsK9EaRxvQPW7/IU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=nvFmebzLlF+qkoW9TU6gqZxRXUxx+o+sFW3KlayO9jum7qhVTgrP3fiH7XsYHDki8dEclM9g2hMtFiE1xi01/dQb4Zhk3XKRtOSaiW1Ls9kPlUFWANOFlPudOlvYLwA/f5dGRPOQKh4tAKWc7GBSl55wIs6TPOZbMth6OxDGwww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=U2EhW2K2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20492C2BBFC;
	Sun, 16 Jun 2024 10:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718535091;
	bh=0eELrSJysNrNj6umF99zEZ4yybfNsK9EaRxvQPW7/IU=;
	h=Date:From:To:Cc:Subject:From;
	b=U2EhW2K2rsc+npZA4oAAUlMMxyGaFYO0rNHeYZ1HC0lTXrV7cII8mj0rQGDepY1uC
	 ilDNJkViX71m0YF18Db39sEsE9c3S6YD7EQ5BNC716MUM8Weex4Q+D/jcqiZDJfia0
	 Uf7MtkbpgYL3f9qaEHy7Sov+UV3DXrvRyajJaMcU=
Date: Sun, 16 Jun 2024 12:51:28 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [GIT PULL] Staging driver fix for 6.10-rc4
Message-ID: <Zm7DsDUAGWwEE6Lf@kroah.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit c3f38fa61af77b49866b006939479069cd451173:

  Linux 6.10-rc2 (2024-06-02 15:44:56 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-6.10-rc4

for you to fetch changes up to c3552ab19aeb8101b751e7c7ad45deab9e1134e1:

  staging: vchiq_debugfs: Fix NPD in vchiq_dump_state (2024-06-04 13:36:44 +0200)

----------------------------------------------------------------
Staging driver fix for 6.10-rc4

Here is a single staging driver fix, for the vc04 driver, for 6.10-rc4.
It resolves a reported problem that showed up in the 6.10-rc1 set of
changes.

It's been in linux-next for over a week with no reported problems.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Stefan Wahren (1):
      staging: vchiq_debugfs: Fix NPD in vchiq_dump_state

 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c     | 2 +-
 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.c | 8 ++++----
 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.h | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)


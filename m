Return-Path: <linux-kernel+bounces-205918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D48E8900227
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 13:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6BE21C21911
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 11:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A8B518C324;
	Fri,  7 Jun 2024 11:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LoP7mMCW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C48187329
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 11:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717759823; cv=none; b=i79IUOF1FqWOS+MCMZFl7c/CVzU4DBXH4p4GyU79hZ+nEr7M6PfKMJ/S7BRjojmbKcD28MqJPaqdZTRMN96KrJWnry+0wcF5EZrKgd9OHCo2nAcaDIN7M9+z0paHGYRM1eHF8Jd+43kz/zjNZ4ZWShzK/mCtE1h1nXdyb4Shpyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717759823; c=relaxed/simple;
	bh=o9nHKyarRr6J/3ejRnvxUC2BzvWsttfSZ01al77jjjE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=pOWtwKWCHYnJc8IbGScWm7DXu+29WTuVMcJFqjm4BrnjqdAmUVKo39MTBSQw0H9WZMx+HDQph/Zy1LyqMP5YwESqKysj3I+v2t6qJUUnpGtE3bD4Vldrotr7KptPELW/ooal3BZGLay2xqnx5NXRQcDEkYpnwG6qMzk/zfJOeWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LoP7mMCW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27678C2BBFC;
	Fri,  7 Jun 2024 11:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717759823;
	bh=o9nHKyarRr6J/3ejRnvxUC2BzvWsttfSZ01al77jjjE=;
	h=Date:From:To:Cc:Subject:From;
	b=LoP7mMCWy4ZsyS3uaHCQKijiaQS7JfdLoLLXvC4IRye8BK+3F2WASzIBZSR8xzBhl
	 GQSA9tOiTUbuzkRa7mXlNOq8LbffI2HSXSGtOSKmeoF/dHmRB3t1IuwMkrGe+3T0hE
	 aiTbj1MoVokl7+2dgHLStmsX8+WgZ3g84ruiP7bBf+SeJ645j+nMJazFnBB9eVKynN
	 xLlWXDmRX4BQ5mMtcb2TmOh6GhYOer5KoFnr3DLOPUfkizI9vj4N5MLq4TcpEPVAEC
	 tI7Wyx5pZ/lKb1IngVIdn0ZibzozPpqMhePUTlu24CrrG6SpYs8S+t0D9gnNVdJn02
	 O5YAS7lj7Wekg==
Date: Fri, 7 Jun 2024 12:30:18 +0100
From: Will Deacon <will@kernel.org>
To: torvalds@linux-foundation.org
Cc: catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: [GIT PULL] arm64 fixes for -rc3
Message-ID: <20240607113018.GA24475@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)

Hi Linus,

Please pull these couple of minor fixes for -rc3. The summary's in the
tag, but neither are hugely interesting.

The main bug we have at the moment is an out-of-bounds access in the
contiguous pte code; Andrew should send you the fix via -mm shortly.

Cheers,

Will

--->8

The following changes since commit c3f38fa61af77b49866b006939479069cd451173:

  Linux 6.10-rc2 (2024-06-02 15:44:56 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

for you to fetch changes up to 5c40e428aea644c9d924e491b1bc22fa9f272bcc:

  arm64/io: add constant-argument check (2024-06-05 13:30:58 +0100)

----------------------------------------------------------------
arm64 fix for -rc3

- Fix spurious CPU hotplug warning message from SETEND emulation code

- Fix the build when GCC wasn't inlining our I/O accessor internals

----------------------------------------------------------------
Arnd Bergmann (1):
      arm64/io: add constant-argument check

Wei Li (1):
      arm64: armv8_deprecated: Fix warning in isndep cpuhp starting process

 arch/arm64/include/asm/io.h          | 36 ++++++++++++++++--------------------
 arch/arm64/kernel/armv8_deprecated.c |  3 +++
 2 files changed, 19 insertions(+), 20 deletions(-)


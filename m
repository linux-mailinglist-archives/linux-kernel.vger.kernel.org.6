Return-Path: <linux-kernel+bounces-234202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 495F091C39D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 18:17:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 064932825DC
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 16:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD1BA1C8FB1;
	Fri, 28 Jun 2024 16:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YvW7s8iX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02CE8135A4A
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 16:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719591436; cv=none; b=C0qRmWKyJIxOisaGsU89plvyGEUthQ3ZO7+himvl2Qv3riEpoqyi3pb89+l9JZHOUL8m8IapgwGdAuLPT1s9ABz0feRAJzD5dVUSzh2JC6lH07vqDGoQWX2fRZb4fkiUgSBNsF1c+H26swWI5SfVjqJNyX9d5EWDj1YQleZhZxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719591436; c=relaxed/simple;
	bh=7GCvCVeQAzLxZxb8s5ctuFDRLxMM51i5QRKhOq519D8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=lf9UESV/jQP/mSAesk4ThFIsoVV/DWCDpjirfmzehPfqb6nj4unCTjvy62Aa/u3EMRvm1Y3nBrA7YdfXLObIfEtIIqx+Zfw618ecL7xY4m1L33R9v3k8A9XkkMwd7GwaEo9JVTLN8zD+tVrOgnLfaTC0jAJNcKA6mgQK2T/dAyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YvW7s8iX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86774C116B1;
	Fri, 28 Jun 2024 16:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719591435;
	bh=7GCvCVeQAzLxZxb8s5ctuFDRLxMM51i5QRKhOq519D8=;
	h=Date:From:To:Cc:Subject:From;
	b=YvW7s8iXNm/upmYgqavTZqIRgP34NGqydvYndlZtkHTM8fOkGt24yW/+eyzR8MmkX
	 OXmtrslNSubTAZfc3h+7Z5W5RLGPIoix83OEhR0tN3SvyjmcC7MI/4uilQTZ4ro5AT
	 WbnaXydb1iQgL1nBQ/usWaxxL0aZk5leV3Payy1QOIHwp3x6Y+CGegYGjauhjcjs7I
	 jnBe0dfU0ikS1mRdOYLQHC13OzKl+dxrULt9Dm4tEWnk17YTpoiVc5DqUEkSfGVcTU
	 6gLERHU+PT0khVvT0LGq+q/GnLj4GCRd0XZeKNKZz5MVUauSLpkmi28b6oBtt6iefy
	 dYjpwJtpjUhfg==
Date: Fri, 28 Jun 2024 09:17:14 -0700
From: Kees Cook <kees@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	Heiko Carstens <hca@linux.ibm.com>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Kees Cook <kees@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Yuntao Liu <liuyuntao12@huawei.com>
Subject: [GIT PULL] hardening fixes for v6.10-rc6
Message-ID: <202406280915.FFE303A3@keescook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Please pull these few hardening fixes for v6.10-rc6.

Thanks!

-Kees

The following changes since commit 1ab1a422c0daedbd76f9f25c297eca48986ddea0:

  MAINTAINERS: Update entries for Kees Cook (2024-06-17 11:14:06 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/hardening-v6.10-rc6

for you to fetch changes up to 1c07c9be87dd3dd0634033bf08728b32465f08fb:

  tty: mxser: Remove __counted_by from mxser_board.ports[] (2024-06-28 08:54:56 -0700)

----------------------------------------------------------------
hardening fixes for v6.10-rc6

- Remove invalid tty __counted_by annotation (Nathan Chancellor)

- Add missing MODULE_DESCRIPTION()s for KUnit string tests (Jeff Johnson)

- Remove non-functional per-arch kstack entropy filtering

----------------------------------------------------------------
Jeff Johnson (1):
      string: kunit: add missing MODULE_DESCRIPTION() macros

Kees Cook (1):
      randomize_kstack: Remove non-functional per-arch entropy filtering

Nathan Chancellor (1):
      tty: mxser: Remove __counted_by from mxser_board.ports[]

 arch/arm64/kernel/syscall.c          | 16 +++++++---------
 arch/s390/include/asm/entry-common.h |  2 +-
 arch/x86/include/asm/entry-common.h  | 15 ++++++---------
 drivers/tty/mxser.c                  |  2 +-
 lib/string_helpers_kunit.c           |  1 +
 lib/string_kunit.c                   |  1 +
 6 files changed, 17 insertions(+), 20 deletions(-)

-- 
Kees Cook


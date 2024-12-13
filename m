Return-Path: <linux-kernel+bounces-445288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28AC79F141C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 18:41:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBC51283B4F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 17:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 382071E8824;
	Fri, 13 Dec 2024 17:41:42 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D390217B505
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 17:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734111701; cv=none; b=CHUqxUFEVZnk7oVaqx3dTISqDy0SKoMk0Qu1kDqeJoVICqnlNaqjq432w++pJxzhA5WHXSoaf17CYGftCAAkxuOhaq7huL9+eX58Tti0Sp6L2ofJZsJGhX2nRQbz3b3CBkcREpBr2Jzvin+MZd0oHvvI7Sh07+dKyUX7WD5uAiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734111701; c=relaxed/simple;
	bh=AEmhRcDU0N2QBBtqEqBkb4elL0aIkQEUym9KRTtO7Kg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=g/WACUXdBj+AkkvM86MjaUCklFBPa/ynsOulIDq0wrbbeQXy43KoB3R17NMagvG39t4uSTee8zHvu7aJoL1IRKnoqb3st8QH11qTTAN3ZZXSsXM3WmbrmZCzLc8zZTBh6CigRZ8nopRrlrsiag6t8tDqa7XUTPIytQhd8kTx6lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8842BC4CED6;
	Fri, 13 Dec 2024 17:41:40 +0000 (UTC)
Date: Fri, 13 Dec 2024 17:41:38 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] arm64 fixes for 6.13-rc3
Message-ID: <Z1xx0ha7lbKkdhRC@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Please pull the arm64 fixes below. Thanks.

The following changes since commit fac04efc5c793dccbd07e2d59af9f90b7fc0dca4:

  Linux 6.13-rc2 (2024-12-08 14:03:39 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

for you to fetch changes up to ce03573a1917532da06057da9f8e74a2ee9e2ac9:

  kselftest/arm64: abi: fix SVCR detection (2024-12-13 14:59:37 +0000)

----------------------------------------------------------------
arm64 fixes for 6.13-rc3:

- arm64 stacktrace: address some fallout from the recent changes to
  unwinding across exception boundaries

- Ensure the arm64 signal delivery failure is recoverable - only
  override the return registers after all the user accesses took place

- Fix the arm64 kselftest access to SVCR - only when SME is detected

----------------------------------------------------------------
Kevin Brodsky (1):
      arm64: signal: Ensure signal delivery failure is recoverable

Mark Rutland (2):
      arm64: stacktrace: Skip reporting LR at exception boundaries
      arm64: stacktrace: Don't WARN when unwinding other tasks

Weizhao Ouyang (1):
      kselftest/arm64: abi: fix SVCR detection

 arch/arm64/kernel/signal.c                         | 48 +++++++++++++++-------
 arch/arm64/kernel/stacktrace.c                     | 32 ++++-----------
 .../testing/selftests/arm64/abi/syscall-abi-asm.S  | 32 +++++++--------
 3 files changed, 55 insertions(+), 57 deletions(-)

-- 
Catalin


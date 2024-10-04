Return-Path: <linux-kernel+bounces-350748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BCA09908FC
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 18:22:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D45B2818BF
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 16:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB8341C7293;
	Fri,  4 Oct 2024 16:22:22 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B5C1C7275
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 16:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728058942; cv=none; b=g4YvD1AwV9haTXFJ3vjJYg8WCVcv+0XZ2FlyFYWxdjG7RAsbp/44ocIJgRo8UUzWdVmk2+iiPkBybyUufMVr0dBH3lv0xkLG1T18A215oLo0CQbxgQuxqlqX2AMTSZtW7juLXqiFxAzqCM8i4XNH168sCqerOrFpVmJOLlwrxmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728058942; c=relaxed/simple;
	bh=7OpRoevpJbix4iuVlEtm05ohk77G22wzip6rWIMpWro=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Rbo99Nhrx0pCh6BLMC7QdOKy3H034d5HtIN15Ge1crXIrV7Et46gG/zErZ+/NJt1soBYn4rUTMzOon0U6MdWGAKPpXhM7fP61w4FwbtsFrCVEB+9XyjSxk1rl+1OdunwxqhfACM7n5tXcv828y9MhEmSUQWTwr8L7GPp/29xVGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49BB5C4CEC7;
	Fri,  4 Oct 2024 16:22:21 +0000 (UTC)
Date: Fri, 4 Oct 2024 17:22:18 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] arm64 fixes for 6.12-rc2
Message-ID: <ZwAWOkX7bBvhXP6m@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

As Will is gone fishing this week, I'm sending some fixes for the arm64
tree: a couple of build/config issues and expanding the speculative SSBS
workaround to more CPUs. Thanks.

The following changes since commit 9852d85ec9d492ebef56dc5f229416c925758edc:

  Linux 6.12-rc1 (2024-09-29 15:06:19 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

for you to fetch changes up to 3eddb108abe3de6723cc4b77e8558ce1b3047987:

  arm64: Subscribe Microsoft Azure Cobalt 100 to erratum 3194386 (2024-10-04 12:38:03 +0100)

----------------------------------------------------------------
arm64 fixes for 6.12-rc2:

- Expand the speculative SSBS workaround to cover Cortex-A715,
  Neoverse-N3 and Microsoft Azure Cobalt 100

- Force position-independent veneers - in some kernel configurations,
  the LLD linker generates position-dependent veneers for otherwise
  position-independent code, resulting in early boot-time failures

- Fix Kconfig selection of HAVE_DYNAMIC_FTRACE_WITH_ARGS so that it is
  not enabled when not supported by the combination of clang and GNU ld

----------------------------------------------------------------
Easwar Hariharan (1):
      arm64: Subscribe Microsoft Azure Cobalt 100 to erratum 3194386

Mark Rutland (4):
      arm64: Force position-independent veneers
      arm64: cputype: Add Neoverse-N3 definitions
      arm64: errata: Expand speculative SSBS workaround once more
      arm64: fix selection of HAVE_DYNAMIC_FTRACE_WITH_ARGS

 Documentation/arch/arm64/silicon-errata.rst | 6 ++++++
 arch/arm64/Kconfig                          | 7 ++++---
 arch/arm64/Makefile                         | 2 +-
 arch/arm64/include/asm/cputype.h            | 2 ++
 arch/arm64/kernel/cpu_errata.c              | 3 +++
 5 files changed, 16 insertions(+), 4 deletions(-)

-- 
Catalin


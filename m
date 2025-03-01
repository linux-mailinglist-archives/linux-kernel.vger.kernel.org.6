Return-Path: <linux-kernel+bounces-540126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B5D9A4AE04
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 22:21:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FDD33ACB5D
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 21:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 510361D2F53;
	Sat,  1 Mar 2025 21:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BeRktjRs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F5E33E1
	for <linux-kernel@vger.kernel.org>; Sat,  1 Mar 2025 21:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740864081; cv=none; b=j+yDIq4pp7H3i+nlly6Zk9Fkc9Ku86LzWZTiDh282b8IbkaSNsW7c7mOL+vq+l55ADkPSQ3NlnahAkmeinCt8bDjoGnvEpkXuUvOaa27UGlEvfSIM3PuYt08HiSptBtggfWfEL5YxFqtNheBue1SnESScMbNkVS9+ilPslbkFa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740864081; c=relaxed/simple;
	bh=Er7lTRaEi35ienkDUi7oOPwdYCL796Gg4xtCpcd7D7g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=WyPSXNnM9ZUWEEUR01Jd8PonTD0KeDcsgDr8m1SHxuGHAAVIpjgflgpkehqyzSlWDPxSBkNi0VGnzIPzx2RLPCwZ4XrMR0SEqn7RpIgW9+k5rEdsFRdfQwAyBes0/sKRpWAfsH2mrhlQQTaL5umSg7LAjJAymexHHyarXsNGcmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BeRktjRs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D6D8C4CEE6;
	Sat,  1 Mar 2025 21:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740864081;
	bh=Er7lTRaEi35ienkDUi7oOPwdYCL796Gg4xtCpcd7D7g=;
	h=Date:From:To:Cc:Subject:From;
	b=BeRktjRsdbEjxlK7vbinucOO3Ieg9/CMfVhjOVX5R9hzuCsRcoEweJol9Gkaphypq
	 3kyWLkNB3jHYCs0tAelo8GJeiLQuQ7j9RLPYa4xSumoAuAU+Q/CJa4d4d/tW4v8I57
	 6WJj868T85KCSTE26r/AnntsM/k2Du//TUvojyPJQJHCiv+uRNJgbAX0Kq0cADU8Ww
	 GCbvKeYZ2E90JiBk5j1zUcTz5lz+HfiG9F6nYVxmX5tEAVjJi2IdqlE14bGva7L3Ec
	 3xj5yMNKrD/fR6kOpYBeNAl+gND2OzQ5cKhybe9L8CrarFuXw4L/tQvlKLRqUEzUQv
	 qMHAv3vuoEOpA==
Date: Sat, 1 Mar 2025 21:21:16 +0000
From: Will Deacon <will@kernel.org>
To: torvalds@linux-foundation.org
Cc: catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, kernel-team@android.com,
	ryan.roberts@arm.com, akpm@linux-foundation.org
Subject: [GIT PULL] arm64 fixes for -rc5
Message-ID: <20250301212116.GA29069@willie-the-truck>
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

Ryan's been hard at work finding and fixing mm bugs in the arm64 code,
so here's a small crop of fixes for -rc5. The main changes are to fix
our zapping of non-present PTEs for hugetlb entries created using the
contiguous bit in the page-table rather than a block entry at the level
above. Prior to these fixes, we were pulling the contiguous bit back out
of the PTE in order to determine the size of the hugetlb page but this
is clearly bogus if the thing isn't present and consequently both the
clearing of the PTE(s) and the TLB invalidation were unreliable.

Although the problem was found by code inspection, we really don't want
this sitting around waiting to trigger and the changes are CC'd to stable
accordingly.

Note that the diffstat looks a lot worse than it really is;
huge_ptep_get_and_clear() now takes a size argument from the core code
and so all the arch implementations of that have been updated in a
pretty mechanical fashion. The patches have been in linux-next without
problems and Andrew is aware that they're coming via arm64 [1].

Cheers, and please pull.

Will

[1] https://lore.kernel.org/all/20250205235219.3c3a4b968087d1386d708b04@linux-foundation.org/

--->8

The following changes since commit 0ad2507d5d93f39619fc42372c347d6006b64319:

  Linux 6.14-rc3 (2025-02-16 14:02:44 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

for you to fetch changes up to eed6bfa8b28230382b797a88569f2c7569a1a419:

  arm64: hugetlb: Fix flush_hugetlb_tlb_range() invalidation level (2025-02-27 17:40:58 +0000)

----------------------------------------------------------------
arm64 fixes for -rc5

- Fix a sporadic boot failure due to incorrect randomization of the
  linear map on systems that support it

- Fix the zapping (both clearing the entries *and* invalidating the TLB)
  of hugetlb PTEs constructed using the contiguous bit

----------------------------------------------------------------
Ryan Roberts (4):
      arm64/mm: Fix Boot panic on Ampere Altra
      mm: hugetlb: Add huge page size param to huge_ptep_get_and_clear()
      arm64: hugetlb: Fix huge_ptep_get_and_clear() for non-present ptes
      arm64: hugetlb: Fix flush_hugetlb_tlb_range() invalidation level

 arch/arm64/include/asm/hugetlb.h     | 26 +++++++++++-----
 arch/arm64/mm/hugetlbpage.c          | 59 +++++++++++++++---------------------
 arch/arm64/mm/init.c                 |  7 +----
 arch/loongarch/include/asm/hugetlb.h |  6 ++--
 arch/mips/include/asm/hugetlb.h      |  6 ++--
 arch/parisc/include/asm/hugetlb.h    |  2 +-
 arch/parisc/mm/hugetlbpage.c         |  2 +-
 arch/powerpc/include/asm/hugetlb.h   |  6 ++--
 arch/riscv/include/asm/hugetlb.h     |  3 +-
 arch/riscv/mm/hugetlbpage.c          |  2 +-
 arch/s390/include/asm/hugetlb.h      | 16 +++++++---
 arch/s390/mm/hugetlbpage.c           |  4 +--
 arch/sparc/include/asm/hugetlb.h     |  2 +-
 arch/sparc/mm/hugetlbpage.c          |  2 +-
 include/asm-generic/hugetlb.h        |  2 +-
 include/linux/hugetlb.h              |  4 ++-
 mm/hugetlb.c                         |  4 +--
 17 files changed, 82 insertions(+), 71 deletions(-)


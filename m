Return-Path: <linux-kernel+bounces-561749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33C96A615B5
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 17:05:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 784C616F615
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 16:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1316B200BBE;
	Fri, 14 Mar 2025 16:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u8tAqGa9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758981339A4
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 16:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741968304; cv=none; b=eBqZS9MInrS5e9WjNixsI1PBj9PVNdW4Q6jklllHg84ebCQYQTiDmeP/jD8xW0ni9FGNVisXGthu5VMZltZzIEnv+heWa21OKcDwwaDKwRRI8l07PXnA52jU+g52DjLpHA2j8bdrehI6Q+7gesIVt8h/PDp6Y/TlAvj85bwk/Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741968304; c=relaxed/simple;
	bh=Ta9k0fUFkF12PTa91lP+YCJcKC0H52dUXuAZotRTJvA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=WHqx5DPcEEsKRWwQNjP7Fy057F4Gk8NE3qo5YOCXRSjKe2qbNgaCQooK9g5+lWMzA10CTc1YOL4C6py7p/grRycryRwhW8ddE5oLrgpfqNT7PTY/CWXCc05av5fooaNzpGQhJHYTP5OuHD8Sqwvv0aZdle7ZfjjXBTf+FOhR28c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u8tAqGa9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB7DEC4CEE3;
	Fri, 14 Mar 2025 16:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741968303;
	bh=Ta9k0fUFkF12PTa91lP+YCJcKC0H52dUXuAZotRTJvA=;
	h=Date:From:To:Cc:Subject:From;
	b=u8tAqGa9bhEIECQIBlEv9g6B6qZ7Y5H/9JBa5b0TQMLpSkByxyxzgCccJOnEBFaJi
	 dd67nB5jdJmrkiNtBJC4XD6vD9J3VXNRvaoPJv+OnPlKnyBrLxr6CQW2eniXbIS2ej
	 G2NfLkLKG6oxz5Gl/AfbeCwbtvw/6L6AbsxjwHpSXgrshKnopilnu1xOHSZuhLD4y7
	 kjqm/f44h+1/dYfPvCrFYlLR9SLEERWI24zTIlt8ADGZDU0dn8viqsBgqrCtwC4Llz
	 /A9jjNO4Jhtig+Qfnr6p2HYaAO04XKlM5tm/dpyrWtOj3hlwAkcAnICTHFoO4q9ZQ5
	 yCmFiXmt2/5rQ==
Date: Fri, 14 Mar 2025 16:04:59 +0000
From: Will Deacon <will@kernel.org>
To: torvalds@linux-foundation.org
Cc: catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: [GIT PULL] arm64 fixes for -rc7
Message-ID: <20250314160458.GA9438@willie-the-truck>
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

Please pull this pair of arm64 mm fixes for -rc7.

Summary in the tag, but the main one is a horrible macro fix for our
TLB flushing code which resulted in over-invalidation on the MMU
notifier path.

Cheers,

Will

--->8

The following changes since commit eed6bfa8b28230382b797a88569f2c7569a1a419:

  arm64: hugetlb: Fix flush_hugetlb_tlb_range() invalidation level (2025-02-27 17:40:58 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

for you to fetch changes up to f7edb07ad7c66eab3dce57384f33b9799d579133:

  Fix mmu notifiers for range-based invalidates (2025-03-11 11:37:43 +0000)

----------------------------------------------------------------
arm64 fixes for -rc7

- Fix population of the vmemmap for regions of memory that are smaller
  than a section (128 MiB)

- Fix range-based TLB over-invalidation when invoked via a MMU notifier

----------------------------------------------------------------
Piotr Jaroszynski (1):
      Fix mmu notifiers for range-based invalidates

Zhenhua Huang (1):
      arm64: mm: Populate vmemmap at the page level if not section aligned

 arch/arm64/include/asm/tlbflush.h | 22 ++++++++++++----------
 arch/arm64/mm/mmu.c               |  5 ++++-
 2 files changed, 16 insertions(+), 11 deletions(-)


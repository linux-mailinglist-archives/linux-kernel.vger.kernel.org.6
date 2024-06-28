Return-Path: <linux-kernel+bounces-233641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D5C5991BA9C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 11:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24D58B22B1B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 09:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66F0414E2F4;
	Fri, 28 Jun 2024 08:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PHU1/CmL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A607B15252C
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 08:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719565174; cv=none; b=gokG1bGMFZpmsjN/zwn+IGGgPNjxgsUS3eI53dRcwcb5BIjpBE8WXOXabtAAorObbyxZ1e5UqOJMJRd/AeW0FFpgz8ZK5AQp13VnFzxfFc6v/rHkyXkQXbSGSSUMj/l0uOOgYH3QTMuhd607UjUKnEj6n4+oeR+IzOfMCa9EpmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719565174; c=relaxed/simple;
	bh=Tzi/G+a5CDQDPwSJ90qqFEIkE/wkGYuBcX/dDaobTmo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=rcm2hfZ6vXqaI65TbtrGY+SK66vVWEkgscdhdmMbq24ctDYJGm2EoAwGT17FRtAN6ngb8/0+IQWTlRZLo0qNl06cJvkDmGyCaPmtZy8N7vSNTfgQJL3KndyTVNUIu/CvzryxXKWB5ZP0WGoT7ByPXM9bBDQStKSJljyAVE0c5A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PHU1/CmL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C704C116B1;
	Fri, 28 Jun 2024 08:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719565174;
	bh=Tzi/G+a5CDQDPwSJ90qqFEIkE/wkGYuBcX/dDaobTmo=;
	h=Date:From:To:Cc:Subject:From;
	b=PHU1/CmL55oi4rwwfy2FVOGwVVKD0r1YWzAA22UAMZtvr9AgIuJF/igDcePO5AKHV
	 3TuE/6Mzfllh5DRxnnfktg+9WoyAb3akO96jISeU/pyv9eoWC8B3QfeZ5kf5nPEBMn
	 KC2mQvsAP5eQxfUFP4a2M1qsYP2TFVV/Tyg3zKbtKKIbEKh8jEYJ70YWIGFP3ggb0u
	 ALcVEJjSA2Ko5CjFvBRv7nuuPPIxPVNywX1bb4upCzO+PKM8TAueLa7M+WP5i0eaHP
	 9eSjs46lvRVWvtg+9TBKKgDAwbQUJCdEGrDnPeono+mJMS6htPnyGxWKYa5Nw4OcgJ
	 2FQbRZLM7Sl9A==
Date: Fri, 28 Jun 2024 09:59:29 +0100
From: Will Deacon <will@kernel.org>
To: torvalds@linux-foundation.org
Cc: catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: [GIT PULL] arm64 fixes for -rc6
Message-ID: <20240628085928.GA13251@willie-the-truck>
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

Please can you pull this pair of small arm64 fixes for -rc6?

One is a fix for the recently merged uffd-wp support (which was
triggering a spurious warning) and the other is a fix to the clearing
of the initial idmap pgd in some configurations.

Cheers,

Will

--->8

The following changes since commit 83a7eefedc9b56fe7bfeff13b6c7356688ffa670:

  Linux 6.10-rc3 (2024-06-09 14:19:43 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

for you to fetch changes up to ecc54006f158ae0245a13e59026da2f0239c1b86:

  arm64: Clear the initial ID map correctly before remapping (2024-06-24 12:37:46 +0100)

----------------------------------------------------------------
arm64 fixes for -rc6

- Fix spurious page-table warning when clearing PTE_UFFD_WP in a live
  pte

- Fix clearing of the idmap pgd when using large addressing modes

----------------------------------------------------------------
Ryan Roberts (1):
      arm64: mm: Permit PTE SW bits to change in live mappings

Zenghui Yu (1):
      arm64: Clear the initial ID map correctly before remapping

 arch/arm64/include/asm/pgtable-hwdef.h | 1 +
 arch/arm64/kernel/pi/map_kernel.c      | 2 +-
 arch/arm64/mm/mmu.c                    | 3 ++-
 3 files changed, 4 insertions(+), 2 deletions(-)


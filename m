Return-Path: <linux-kernel+bounces-263012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5132A93CFCA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 10:45:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E809CB23069
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 08:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45A9B5674D;
	Fri, 26 Jul 2024 08:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SwaLNg3i"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846405588B;
	Fri, 26 Jul 2024 08:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721983536; cv=none; b=l6887suHxuKEGQnbT53ZmhCWRtKzGz0mzIuJeiRzEkjNYEPtjzsnVB5GfPPTuj9kAvCx7nr3hqyqH2he9kBoJs5kAPnW96SI45Cq8+HPmpXoORKZDnckvX/JjDkNGZHcnEo6f3xMzY2eZ/Iqg4DnVS4IhyWZMl0qG16rHQOaCCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721983536; c=relaxed/simple;
	bh=1TeGzKPagOTld8WQwvFUE7lovbJ5dPIYN/BT/ChenqI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=GfDfJ/r4++T+m12t5IuomoQB8Wh8fjYtQU76lo+zDpUI9I2x+kuLgD2ImJejuPohqPw5S8Uf6ebC0HWDLu1FoW/xrTVCklQgNkbgXR/qpBfhDl/gwa/FtLtaMFVg1FgRB3tNKjEYLzmG3mvO6yUuQS3tskjP/i++ZTJ3J1p62HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SwaLNg3i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71919C4AF0A;
	Fri, 26 Jul 2024 08:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721983536;
	bh=1TeGzKPagOTld8WQwvFUE7lovbJ5dPIYN/BT/ChenqI=;
	h=Date:From:To:Cc:Subject:From;
	b=SwaLNg3il7nq++e16zlmp0ikZzr6PHwACd9HDE74ViE6TQPSx6DbiKrkFiRibdMqD
	 kXjeuyXe+tS2lcsfJr2j2mo8GZthmDqcr1Zq4F8WLQmjp4/9wRILTNR7m7nkhkwY+N
	 4VeIGexUn5zbxuBh85ZumfAvq8EqwLtRNEzoJueyj1inxoaoaBEzl7MUIeDGtssIoZ
	 7tTOeVOzzXhYi9139BE/f+xjo/bTpxQir/6Q1s+DnA7+ZNPv5JvLHC10vvZhYxG0/6
	 E3c4WrebxxK6bAFkSu7aRou8V+gpwhYmq1VyBKYvjrh8P9pGciPyAPChuqqsnFRpsL
	 EcxyF1J/uNCPw==
Date: Fri, 26 Jul 2024 09:45:32 +0100
From: Will Deacon <will@kernel.org>
To: torvalds@linux-foundation.org
Cc: joro@8bytes.org, linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Subject: [GIT PULL] IOMMU fixes for -rc1
Message-ID: <20240726084532.GB29687@willie-the-truck>
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

Please pull this small collection of IOMMU driver fixes for -rc1. The
summary is in the tag.

We're still resolving a regression with the handling of unexpected page
faults on SMMUv3, but we're not quite there with a fix yet.

Cheers,

Will

--->8

The following changes since commit 8b6c32e831ef4496b51a68ddc5be9bb9e8d2337d:

  Merge branch 'iommu/iommufd/paging-domain-alloc' into iommu/next (2024-07-12 16:57:47 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git tags/iommu-fixes-v6.11-rc1

for you to fetch changes up to 726d4f528dbc98a84d9ce3c749dfdada3dcdd5ca:

  iommu: arm-smmu: Fix Tegra workaround for PAGE_SIZE mappings (2024-07-25 13:08:44 +0100)

----------------------------------------------------------------
IOMMU Fixes for Linux v6.11-rc1

- Fix NULL dereference when freeing domain in Unisoc SPRD driver.

- Separate assignment statements with semicolons in AMD page-table code.

- Fix Tegra erratum workaround when the CPU is using 16KiB pages.

----------------------------------------------------------------
Artem Chernyshev (1):
      iommu: sprd: Avoid NULL deref in sprd_iommu_hw_en

Ashish Mhetre (1):
      iommu: arm-smmu: Fix Tegra workaround for PAGE_SIZE mappings

Chen Ni (1):
      iommu/amd: Convert comma to semicolon

 drivers/iommu/amd/io_pgtable.c               | 6 +++---
 drivers/iommu/arm/arm-smmu/arm-smmu-nvidia.c | 2 +-
 drivers/iommu/sprd-iommu.c                   | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)


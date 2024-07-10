Return-Path: <linux-kernel+bounces-247600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6748F92D1BB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 14:39:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18307286D13
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 12:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6BF6191F95;
	Wed, 10 Jul 2024 12:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kF0X6NM5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3AD191496;
	Wed, 10 Jul 2024 12:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720615151; cv=none; b=OlM3VpC9uq4mIiyqE/ZoFdndxwzEpE4IKL0/uMNQn9D84EusjLqIhltXZ85FLZzvIl5jojkiK/M6vj2rotRrwnVrPZcLfDvl/PcOQozZXUqxPHzGgoccGsfNlBrdudzBie1Weqq6ZO6Iy1JnrIZ0wgyA7dEh+K3l5fb8Z9kaStc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720615151; c=relaxed/simple;
	bh=Pkl0N61cIs16sTy1Os3VUMkDmIplUrRbwQp3A+pBqhE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I8sppV8gfIeWKtm4S5FU440NnNVwloxw/iIZXVwo/ECcsS3ch+v5+8Fco3eP+gBj5WMEvn4tnobeCXx2F61+pKqqvjJPfKPEasrwxBeSjvimolHFPmgjVtyQXaiDcVlHBQu4t8RhhoN6qI7zJ1SV7h+Q2PeXEQ7yQrGCG3dMCVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kF0X6NM5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5897C32786;
	Wed, 10 Jul 2024 12:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720615150;
	bh=Pkl0N61cIs16sTy1Os3VUMkDmIplUrRbwQp3A+pBqhE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kF0X6NM5ZQ6RVrRPG917AZ8uI6AafaDCw3KdxlvPfNpNvKLlldS1zjMwHH702yM2g
	 Tb8Df5XunssFakljELmc/lNx0NNP95YO2XXJONWcPsJ21WGww+UWjatLAEy/iWPrIl
	 AIJy8x9ZQ4gBb57r0G1NQKUOCcX2LPlNWyY8eRX0Sihz5K68hYpdjv5shzK670Niif
	 UU8L68Nug/l4hn6Fzgt372IRMtrgAtJ+NOZMFPuAJIRqprwERICtOiuV3BwsVTyrzv
	 z44X1Vk7rjrirBw23CQ9nmW80ZBbzo1ZObOKx8SqD9MM2ftz+4CNHZRavkRyBgaq+0
	 Ic+b9wDlLGHqQ==
From: Will Deacon <will@kernel.org>
To: Joerg Roedel <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Louis Maliyam <louispm@google.com>,
	Lu Baolu <baolu.lu@linux.intel.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] iommu/vt-d: Fix aligned pages for cache invalidation
Date: Wed, 10 Jul 2024 13:39:03 +0100
Message-Id: <172061321610.624103.9680592794561118105.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240709152643.28109-1-baolu.lu@linux.intel.com>
References: <20240709152643.28109-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 09 Jul 2024 23:26:41 +0800, Lu Baolu wrote:
> The aligned pages for cache invalidation returned by
> calculate_psi_aligned_address() are incorrect if the start pfn is not
> aligned, which can lead to cache inconsistencies when qi_flush_piotlb()
> uses the number of pages to flush caches for the first-stage
> translation.
> 
> Fix this by updating the aligned pages once the address mask is adjusted.
> 
> [...]

Applied to iommu (intel/vt-d), thanks!

[1/2] iommu/vt-d: Limit max address mask to MAX_AGAW_PFN_WIDTH
      https://git.kernel.org/iommu/c/c420a2b4e8be
[2/2] iommu/vt-d: Fix aligned pages in calculate_psi_aligned_address()
      https://git.kernel.org/iommu/c/0a3f6b346301

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev


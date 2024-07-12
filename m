Return-Path: <linux-kernel+bounces-250867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B00A92FDCA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 17:44:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B7B41F22062
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 15:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8837174EE7;
	Fri, 12 Jul 2024 15:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ExqbIcLw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24AEA174EC9;
	Fri, 12 Jul 2024 15:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720799053; cv=none; b=phEK2wanxIZgFvjyzbUh+G1w9HqgCpMhLEtDy6iM/w6VwB/hKA3GMmlaXbkp8Dbjn6S7euCuKqe///cQT/YWisgPEe6UO93Iu411v4Ds0EY7ZXHfquwP9jiYQEmtEBKKSiZfd6bEi9lEn5IPbg6VOlJeIq03YCy+0MYtQxvG5OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720799053; c=relaxed/simple;
	bh=cOUFX4c2fSsz68SjVzxaOmscLnWW0visE9C5nosSnRo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NFDrLnoAE8JCfKCvyXsRyadBhqHVLKMRDI7N8f5Uw3g5YbxGHkflPi756eTRU8HY1VgJ4BvM/hZaySrXgYDvfUz5wE+1bQPgd+KOrYiRJWU6IXjQf2MiL8uGyIOGIZMlybh2dH3a48R/WeiY0+JNJapUbfezY5qJloiWFg5tWQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ExqbIcLw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CCA7C4AF07;
	Fri, 12 Jul 2024 15:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720799052;
	bh=cOUFX4c2fSsz68SjVzxaOmscLnWW0visE9C5nosSnRo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ExqbIcLwJ061XB1A3zDA5rEYD65W8w5JMo1u1NCaUC8V4AtO+cxbLCgzAyotNklKt
	 8nd+GMPwVuLGhZmSKDZUoPoJkgLrPdigBAX5GHYNQaKnTsu4hkT5smW0lhOEnxXFAw
	 0nXfjHwO85iUKIvDWwPcxdztWMNDwfbaDvFUBb5l7VdpjmeeoTU7j1Bh21hokSsmfl
	 bTvEXHZCUona9dqdWeXVfUCFnJ1+unrcaz8vXFOTyEye9b2bGfsM2QhWiL4N4g0xls
	 I69TYfcwYCFRrTVixKtKkOOFwDq0Y9Jm/ppQGkmU9Ih8g+xmCWsRvQc54lX68Vg8Jg
	 2SdtBGiuhkVag==
From: Will Deacon <will@kernel.org>
To: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	robin.murphy@arm.com,
	joro@8bytes.org,
	ryan.roberts@arm.com,
	kevin.tian@intel.com,
	joao.m.martins@oracle.com,
	linuxarm@huawei.com,
	Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH] iommu: Move IOMMU_DIRTY_NO_CLEAR define
Date: Fri, 12 Jul 2024 16:44:04 +0100
Message-Id: <172079759303.1697813.7772154521250184478.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240712113132.45100-1-shameerali.kolothum.thodi@huawei.com>
References: <20240712113132.45100-1-shameerali.kolothum.thodi@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 12 Jul 2024 12:31:32 +0100, Shameer Kolothum wrote:
> Fixes the compile issue when CONFIG_IOMMU_API is not set.
> 
> 

Applied to iommu (arm/smmu), thanks!

[1/1] iommu: Move IOMMU_DIRTY_NO_CLEAR define
      https://git.kernel.org/iommu/c/9b2bc6b9a264

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev


Return-Path: <linux-kernel+bounces-323750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07EAE9742E2
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 21:01:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33B611C25679
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 19:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9302D1A38F4;
	Tue, 10 Sep 2024 19:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="K4XLX4aT"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61525208A5
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 19:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725994874; cv=none; b=lsKGi8KdfaS+B6+Lz2Jov5Aq/xF1OlcOBFcrO4nDioj59affVoHu3HnK11UYS2VXsHwhB7EIkxjMOrbhnSRz0VXl10i/Ho9NWEo01kcGlTboKQl3qZtp/v+jYeOlP4c40PAdO0Boh4GvfnpRYl9BsQUIjNzwglRknfiWEpKOHXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725994874; c=relaxed/simple;
	bh=hh5w6rIe7rNy/wwj7FpYCm/U+aeO2aTCL6aLNjS7yrU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lo4kn24l1tHI8DxwHzZ1nJxP5yqRZMsGgbG+LE3I87CbQuIQTE9QUKLDWs1YiO4W5P/sWcqO+B7JDoZGxB89XwAFrAdbDyOIPY68MhH3rNq1VpmhBORI7jmlO6ZGDmMGCQzntXurG9vhCAukVwfySy2okDwGyTSYWZinS7ehVd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=K4XLX4aT; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1725994869;
	bh=hh5w6rIe7rNy/wwj7FpYCm/U+aeO2aTCL6aLNjS7yrU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K4XLX4aTkimSEe8z8RLCzEpTcJako4CFEL4hjEdInPoZKNDgSCZ77AJRYHjoR9Ce/
	 1Ta/wIS48C0uOh+85kKzUdt1/KCG8wKc8zt+KN2oIOqrjtpaeO+QQV2NQaA7OwN+N7
	 oZVEpUZDya2pm7RDCmqqOcdmJQ9xELdwprD/HR9/bhABMkh2cAN37AFmLlyd+nd0wP
	 /7mZf+/xCSmDIfxOBluq/1GhWwWtgBH0YhGG3Q8qlTj8ZXwTdm/Xe3T78BujtJ7kJV
	 KHZN9ah72ilkCN80oUNjwQhzmq8FzYV/Gf3z/hy3sFUv53ncZlMmEG+1XhkpLuTWXA
	 vfVI6p/LZ5GUA==
Received: from notapiano (pool-100-2-116-133.nycmny.fios.verizon.net [100.2.116.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 971BF17E3603;
	Tue, 10 Sep 2024 21:01:07 +0200 (CEST)
Date: Tue, 10 Sep 2024 15:01:05 -0400
From: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Easwar Hariharan <eahariha@linux.microsoft.com>,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	Jason Gunthorpe <jgg@nvidia.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	regressions@lists.linux.dev, kernelci@lists.linux.dev,
	kernel@collabora.com
Subject: Re: [PATCH v4 2/2] dma: add IOMMU static calls with clear default ops
Message-ID: <181e06ff-35a3-434f-b505-672f430bd1cb@notapiano>
References: <cover.1721818168.git.leon@kernel.org>
 <c3179690b16d790d5bfd7d0afabac9b90922ec28.1721818168.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c3179690b16d790d5bfd7d0afabac9b90922ec28.1721818168.git.leon@kernel.org>

On Wed, Jul 24, 2024 at 09:04:49PM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Most of the arch DMA ops (which often, but not always, involve
> some sort of IOMMU) are using the same DMA operations, but for all
> modern platforms dma-iommu implementation is really matters.
> 
> So let's make sure to call them directly without need to perform
> function pointers dereference.
> 
> During system initialization, the arch can set its own DMA and in such
> case, the default DMA operations will be overridden.
> 
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> Signed-off-by: Leon Romanovsky <leon@kernel.org>

Hi,

KernelCI has identified another regression originating from this patch. It
affects the same platforms:
* sc7180-trogdor-kingoftown
* sc7180-trogdor-lazor-limozeen

But this time the issue is that the venus video codecs are failing to probe as
indicated by the DT kselftest:

  not ok 184 /soc@0/video-codec@aa00000
  ok 185 /soc@0/video-codec@aa00000/opp-table # SKIP
  not ok 186 /soc@0/video-codec@aa00000/video-decoder
  not ok 187 /soc@0/video-codec@aa00000/video-encoder

The kernel logs show the error:

  qcom-venus aa00000.video-codec: probe with driver qcom-venus failed with error -5

A quick ftrace run showed that the error comes from dma_set_mask_and_coherent()
in venus_probe():

  7)               |  venus_probe() {
  ...
  7)               |    dma_set_mask() {
  7)               |      dma_supported() {
  7)   0.989 us    |        dma_direct_supported(); /* = 0x0 */
  7)   2.864 us    |      } /* dma_supported = 0x0 */
  7)   4.636 us    |    } /* dma_set_mask = -5 */

For comparison, here is the ftrace run with the commit reverted:

  7)               |  venus_probe() {
  ...
  7)   1.093 us    |    dma_set_mask(); /* = 0x0 */
  7)   1.041 us    |    dma_set_coherent_mask(); /* = 0x0 */

The issue is still present as of next-20240909 and reverting this commit fixes
it.

Happy to provide any other details necessary.

Please add
Reported-by: N�colas F. R. A. Prado <nfraprado@collabora.com> #KernelCI
when fixing this.

#regzbot introduced: next-20240822..20240823
#regzbot title: Venus codec probe regression for sc7180 platforms in dma_set_mask_and_coherent()

Thanks,
N�colas


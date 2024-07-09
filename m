Return-Path: <linux-kernel+bounces-245709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EB3792B704
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 13:19:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 440E21F21189
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 11:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A8DD157E78;
	Tue,  9 Jul 2024 11:19:07 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695F855E4C
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 11:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720523946; cv=none; b=D+Ly/+b7zuAsNBMRLZapmSSxMhJqI7IC0APBzceLDfyfVvi2T7JghQyIj0Zk5hvoF20QBOtG93oU1FpFqrAbPo6i5k6Gb8p19GbvIKoeulGS6IyzEJp3MjSexw/CIN1fuZFPqewKHmeAt2htKM/3GgryrhSDrz4WBgf26zN5PFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720523946; c=relaxed/simple;
	bh=QRkcc0hh47W83wRJLKAdnrFTrF5uWtuMvFbG0s3iWaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eCOmvQ9ldfpDPALDYpzZNLxaU6vuwjy16PdAJeHZYAAsBrhRZu/WhzgXPrXHm05t7ZWHALOrbDCCaSrV0uJwqyqk2ADgHyhdUksjPr8tTe4PDOpaCjIjNvhJXbrSrE+cbloJpLAhBT0D1zHawXBcvj5x4x2cudVfP4hO8s6zEnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9BBA168CFE; Tue,  9 Jul 2024 13:19:01 +0200 (CEST)
Date: Tue, 9 Jul 2024 13:19:01 +0200
From: Christoph Hellwig <hch@lst.de>
To: Yangyu Chen <cyy@cyyself.name>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH -fixes] dma-mapping: add default implementation to
 arch_dma_{set|clear}_uncached
Message-ID: <20240709111901.GC4421@lst.de>
References: <tencent_A5ED71472ADCAF18F59085464CBE23C12A07@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_A5ED71472ADCAF18F59085464CBE23C12A07@qq.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Jul 09, 2024 at 05:25:29PM +0800, Yangyu Chen wrote:
> Currently, we have some code in kernel/dma/direct.c which references
> arch_dma_set_uncached and arch_dma_clear_uncached. However, many
> architectures do not provide these symbols, and the code currently
> relies on compiler optimization to cut the unnecessary code. When the
> compiler fails to optimize it, the code will reference the symbol and
> cause a link error. I found this bug when developing some new extensions
> for RISC-V on LLVM. The error message is shown below:

Same comment as for the last one.  I think your compiler misbehaves,
and the typical reason for that would be if you disable all
optimizations.



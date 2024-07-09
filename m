Return-Path: <linux-kernel+bounces-245700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB24C92B68A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 13:14:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 967BE285530
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 11:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8D971586C1;
	Tue,  9 Jul 2024 11:14:38 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9D31581E4
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 11:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720523678; cv=none; b=GpcVFHXVQimbb1lOHUyIFxI9mWe4lia4hjSVWbutyXeek/xki9ZhIVaKwdsEqrnbiBIX54JoR12wLwqThqh7hqN69CgXqhO1pnr8DyaTiKMSmEG7zOVrrxkVRsCzMrio66QDvLnj7h57i7lVojzsPVS1Bmo15wlmjpyymglN6v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720523678; c=relaxed/simple;
	bh=79+Ybb6l7EsckyfcPFYID1dTZBjtHp3IDtd7E4iYaAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A7BtnfH+JhK6Pxko0aiMDaMT7CBoWc0dQz2XFFRz8JCbVuEBvIR0ejYQksr/jYZIkxlptlMDYJtnftU1ocF0FPZ5N+8v+EqpYWvMZ1C2NNzAR8mXjXmGdwcfvwlb3Tf+z95PIlJOhOkNFAOvGrU6ZNxF/mnIFVp7aGEKnCU0C9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3B21268BEB; Tue,  9 Jul 2024 13:14:26 +0200 (CEST)
Date: Tue, 9 Jul 2024 13:14:25 +0200
From: Christoph Hellwig <hch@lst.de>
To: Yangyu Chen <cyy@cyyself.name>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH -fixes] dma-direct: only reference
 arch_dma_set_uncached symbol when usable
Message-ID: <20240709111425.GA4421@lst.de>
References: <tencent_5E4637BE7BC1256D39C73ADCA118BD908507@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_5E4637BE7BC1256D39C73ADCA118BD908507@qq.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Jul 09, 2024 at 04:32:48PM +0800, Yangyu Chen wrote:
> The arch_dma_set_uncached symbol is only used when the architecture
> provides it. However, many architectures do not provide it, and the
> code currently relies on compiler optimization to cut the unnecessary
> code. When the compiler fails to optimize it, the code will reference
> the symbol and cause a link error. I found this bug when developing
> some new extensions for RISC-V on LLVM.
> 
> This patch adds a check to avoid the reference to the symbol when it is
> not provided.

arch_dma_set_uncached is only called from dma_direct_alloc when the
set_uncached variable is set to true.   The variable is only set to
true if CONFIG_ARCH_HAS_DMA_SET_UNCACHED is set.

Are you running the compiler without basic optimizations? Because even
the most basic compile time constant propagation would make it
unreachable



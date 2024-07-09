Return-Path: <linux-kernel+bounces-245756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6E6292B8BF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 13:46:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D1B4282422
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 11:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 000BF1514DE;
	Tue,  9 Jul 2024 11:46:35 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15497AE5D
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 11:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720525595; cv=none; b=gtclK0AryiOb1zQQPnwTq5wHkNVLdJpE3+/zRBi70pGjmHl4wZ9dFlsTOy3oYPEAu8EiEX4wsM8KMC86gxhBwlpC+5ZbMOj2ypb0yNTBtB47xeSksyhKZlJEfjnEyp8SY9gZpwsw7SliqH1KJRn9oGXiubqC+kGpGtnSRLMP2bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720525595; c=relaxed/simple;
	bh=O2N1XmoS4hW50BuoLjiToM0vBzmjgZDmycqiQvhpqe4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PVt+BqBzyz0aDpiLqjDkjgNQdTL8esN7rpc1jC0KM92IGR8io/eI02xNyMr5BfNGwHvwEznb3KVbI/Ydgb7fFoTqby359aC4I7HCOIxhu/StrMa5d8dPpjQof4083vG3VbDNaJCsbJITyRCIywBxMGWylP4LaNVUO0OgOFc0nao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 60B7168BEB; Tue,  9 Jul 2024 13:46:30 +0200 (CEST)
Date: Tue, 9 Jul 2024 13:46:29 +0200
From: Christoph Hellwig <hch@lst.de>
To: Yangyu Chen <cyy@cyyself.name>
Cc: Christoph Hellwig <hch@lst.de>, iommu@lists.linux.dev,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH -fixes] dma-mapping: add default implementation to
 arch_dma_{set|clear}_uncached
Message-ID: <20240709114629.GB6959@lst.de>
References: <tencent_A5ED71472ADCAF18F59085464CBE23C12A07@qq.com> <20240709111901.GC4421@lst.de> <tencent_651BC4D11C9730062064ACB186AF4A904005@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_651BC4D11C9730062064ACB186AF4A904005@qq.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Jul 09, 2024 at 07:39:29PM +0800, Yangyu Chen wrote:
> The reason is that some optimizations failed to apply after adding
> some passes. I will fix the compiler later. Whatever, we should not
> rely on this optimization to get the code being successfully compiled.

The Linux kernel relies on constant propagation and dead code
eliminiation a lot to make code simpler and more readable.


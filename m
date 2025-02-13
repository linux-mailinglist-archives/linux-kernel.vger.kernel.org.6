Return-Path: <linux-kernel+bounces-512329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 218FFA337A3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 06:58:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05AA618801DE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 05:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 062C7207640;
	Thu, 13 Feb 2025 05:58:32 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09BC513CF9C
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 05:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739426311; cv=none; b=YhFlsFu+XAeC+KuOF+cqd7UbkvI7rQ9R8lbIRRZOX2S89/nDXvln1Dqrxv/ZAnZWdcMoPjPiwPE8bSvldMcbw6zkFzyYgsKdsXddG8ZcJybcnUFOwq6pzKemxFY9CigdhXwJR13khYTDOzOp1pCmmHr7kwf72y/DaVZcOW1g+lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739426311; c=relaxed/simple;
	bh=gsEYLWgwS4GFzaEBCOqnK9FZFsDTSj16sWYIdYyyt7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S0MjbmGwLOuhcI3wJkguds1opEVATHd6IeNu6qJG7USXtDDGG9hyV5rPjJp8HFz/Fuyw+WinPP2JBIErG/n8fi+RbJjjwWhKpa1fQlTB2SIAOoCihtwdewj09phjBC8AHW1RDRuOg+bTNDa9KjGlPbFsJZxnw9C0lK8cJtAb840=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 364FF67373; Thu, 13 Feb 2025 06:58:25 +0100 (CET)
Date: Thu, 13 Feb 2025 06:58:25 +0100
From: Christoph Hellwig <hch@lst.de>
To: Icenowy Zheng <uwu@icenowy.me>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] nvme-pci: skip CMB blocks incompatible with PCI
 P2P DMA
Message-ID: <20250213055825.GD19370@lst.de>
References: <20250212170444.16138-1-uwu@icenowy.me> <20250212170444.16138-3-uwu@icenowy.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212170444.16138-3-uwu@icenowy.me>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Feb 13, 2025 at 01:04:44AM +0800, Icenowy Zheng wrote:
> +	/*
> +	 * Controllers may support a CMB size larger than their BAR,
> +	 * for example, due to being behind a bridge. Reduce the CMB to
> +	 * the reported size of the BAR
> +	 */
> +	if (size > bar_size - offset)
> +		size = bar_size - offset;

Nit: use up the full 80 characters for the comment, and maybe switch
the above expression to use the min() helper.

> +	if (!IS_ALIGNED(size, memremap_compat_align()) ||
> +	    !IS_ALIGNED(pci_resource_start(pdev, bar),
> +			memremap_compat_align()))

These compat names looked odd to me, but it looks like they are indeed
the proper interface here.  So modulo the little style things above
this looks good, thanks a lot!



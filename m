Return-Path: <linux-kernel+bounces-176029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB4288C28F0
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 18:48:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 858F3283260
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 16:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA1C31758D;
	Fri, 10 May 2024 16:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WY/crXVN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B06314F90
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 16:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715359674; cv=none; b=ILz3e23Mvn2vRSx6nv6xEtaG9PZUzPee7y1zboPiKaqPCEPzx9GnDjv+n9aUXbIC2YLMSoUcjc5C9O3S6YUfZdy+CtMe+49Bw8zaVIurUmz2YDW6CaYqrqgb71lnk/3mBQ8W0YoJegKLB+J47GbG9pWA9o1EBGzc/ojbVwWxWMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715359674; c=relaxed/simple;
	bh=AXvy8iePiTOupLl+xIgUoqVuOZkGTeicUhCyXcPDZvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=czKI5cVCj/Nk1qQaAE8Vj7RXtqAj3/fu3oU5nI2vNsza1fVhyuK8R17aZQ4CwbCHGFgiK2Ln9BnNnU4EOMLKk08e4ZY3PKh0+4SA2c4LmQ5vfihBObHQPp49lqdlye93fX7dfloevz+or07M2zO0mNEwB/FZBSvBQ0YkRn157eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WY/crXVN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 296F3C113CC;
	Fri, 10 May 2024 16:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715359673;
	bh=AXvy8iePiTOupLl+xIgUoqVuOZkGTeicUhCyXcPDZvg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WY/crXVN7AYFzKzJa0xILepwhVwlZt+UG7mUNyhm1z69vKhAukhsbMzIhESPUEGCi
	 EynVeviFFA+ua3hcDOIxZcnBjObuhmdgWuYUX8lPHchn8UnTYTWV96DPSZT1jZhJuB
	 /PcB00x+G6GEUs6uBkt/wXayQ/qBg93ZCY/lH88yhCzSHH+x56WwygcSzoobhXsxgR
	 iNBhIdozZpH1K4/tNEjbSj5AfzWYXYhlSzVwxTlsq6pEgOC7fVgW3eq0ApPmbii/df
	 SwrW+TpR2ErPEVNLft+9c/+ag3fAxJS+QbYz+LHDQu378sPb8rooTdb+ABZfJBx3us
	 XYIINZ3CB+h0A==
Date: Fri, 10 May 2024 10:47:50 -0600
From: Keith Busch <kbusch@kernel.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, hch@lst.de, tglx@linutronix.de
Subject: Re: [PATCH 1/2] genirq/affinity: remove rsvd check against minvec
Message-ID: <Zj5PtvnSMoLPjg0o@kbusch-mbp.dhcp.thefacebook.com>
References: <20240510141459.3207725-1-kbusch@meta.com>
 <Zj46KiMO5trL09RA@fedora>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zj46KiMO5trL09RA@fedora>

On Fri, May 10, 2024 at 11:15:54PM +0800, Ming Lei wrote:
> On Fri, May 10, 2024 at 07:14:58AM -0700, Keith Busch wrote:
> > From: Keith Busch <kbusch@kernel.org>
> > 
> > The reserved vectors are just the desired vectors that don't need to be
> > managed.
> > 
> > Signed-off-by: Keith Busch <kbusch@kernel.org>
> > ---
> >  kernel/irq/affinity.c | 3 ---
> >  1 file changed, 3 deletions(-)
> > 
> > diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
> > index 44a4eba80315c..74b7cccb51a16 100644
> > --- a/kernel/irq/affinity.c
> > +++ b/kernel/irq/affinity.c
> > @@ -113,9 +113,6 @@ unsigned int irq_calc_affinity_vectors(unsigned int minvec, unsigned int maxvec,
> >  	unsigned int resv = affd->pre_vectors + affd->post_vectors;
> >  	unsigned int set_vecs;
> >  
> > -	if (resv > minvec)
> > -		return 0;
> > -
> 
> This behavior is introduced in 6f9a22bc5775 ("PCI/MSI: Ignore affinity if pre/post
> vector count is more than min_vecs"), which is one bug fix.

Thanks for the pointer. Probably best I avoid messing with irq code just
for this use case, so I can have the driver disable the PCI_IRQ_AFFINTY
flag instead ... assuming hch doesn't "nak" it.  :)


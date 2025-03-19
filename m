Return-Path: <linux-kernel+bounces-567776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3831A68A77
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 12:03:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 356091B600F3
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 11:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD8C5253B60;
	Wed, 19 Mar 2025 11:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NbN7wrIR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194FC251788;
	Wed, 19 Mar 2025 11:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742382096; cv=none; b=nniNHM55d8jPzy6JmYClRxKC1d1D2lSOY/LQFc6yU6hVaIKVtz0bX7DG+0Rl6JDsqm6y5e8pl3WGrN8a9qFuoX84pwo/T6jeZW1M/8eMtJweyxS/yjSBABDCn8Yl4y6ZP1GdHXxpl85fTlLd97vndLw8HR9UK+FPP7rB+n8nd60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742382096; c=relaxed/simple;
	bh=GLdsrNqm0xpWfytoZj4zWqe5umr31yWmJUYmClP7Xtk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rgrS2A3Y7Vgm5Y+t4yjSNC9iOboyGbpjyoINoEsybTmutt2EFdxhoIOzhTxXFEFU51ieeZ1odrL7PFLLNut3o93djuQ6+Mzz6B1Tr/VTJPNZwoAmY07izouTEqZwR79yPk6iBH76EUZk9smvzACVP6pd3YUCxsg7yPL/ei0VxcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NbN7wrIR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12BDAC4CEE9;
	Wed, 19 Mar 2025 11:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742382095;
	bh=GLdsrNqm0xpWfytoZj4zWqe5umr31yWmJUYmClP7Xtk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NbN7wrIR3xsHlQDh8tmTXdKhDgAdkR/v1tOxKMSSQG0iVAPyi+znAeKLsW0JPG88U
	 RHWFZ+WhZLteM+lfmEZKpvxl2LpERUJtnWqpceMHu2+BlM1XQ6Nxzt3nPqVcN+ynbn
	 TxBVnHG7THkErFNAHlBQRk3RO/P+ERDXFpZu9gNLAqFrXvA9UKjB5ah0GCiz9FkQc3
	 bSgoRQIfKlBrhXtisDeUMMDl14lBNbZL8SzzsoSm6eGTbmLMn0tETDExv8gAIWxVUy
	 ySV6vbJ7KfGZm9+cerE2LtqBo69BetEFB3T6/I8nqS8XoI1cXva4JcTttIjaIx5jul
	 WNijdzsdGCF4Q==
Date: Wed, 19 Mar 2025 12:01:29 +0100
From: Ingo Molnar <mingo@kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
	xingwei lee <xrivendell7@gmail.com>,
	yuxin wang <wang1315768607@163.com>,
	Marius Fleischer <fleischermarius@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Rik van Riel <riel@surriel.com>, "H. Peter Anvin" <hpa@zytor.com>,
	Peter Xu <peterx@redhat.com>, x86@kernel.org,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [tip: x86/mm] x86/mm/pat: Fix VM_PAT handling when fork() fails
 in copy_page_range()
Message-ID: <Z9qkCQE9dsXdlsKn@gmail.com>
References: <20241029210331.1339581-1-david@redhat.com>
 <174100624258.10177.4534865061014070904.tip-bot2@tip-bot2>
 <fe0a67dc-d7cb-42ff-9b20-9527af7f6a94@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe0a67dc-d7cb-42ff-9b20-9527af7f6a94@redhat.com>


* David Hildenbrand <david@redhat.com> wrote:

> > +void untrack_pfn_copy(struct vm_area_struct *dst_vma,
> > +		struct vm_area_struct *src_vma)
> > +{
> > +	resource_size_t paddr;
> > +	unsigned long size;
> > +
> > +	if (!(dst_vma->vm_flags & VM_PAT))
> > +		return;
> > +
> > +	/*
> > +	 * As the page tables might not have been copied yet, the PAT
> > +	 * information is obtained from the src VMA, just like during
> > +	 * track_pfn_copy().
> > +	 */
> > +	if (get_pat_info(src_vma, &paddr, NULL)) {
> > +		size = src_vma->vm_end - src_vma->vm_start;
> > +		free_pfn_range(paddr, size);
> >   	}
> 
> @Ingo, can you drop this patch for now?

Done.

> I'll resend once I get to it. Thanks!

Great, thanks!

	Ingo


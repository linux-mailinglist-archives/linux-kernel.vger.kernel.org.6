Return-Path: <linux-kernel+bounces-268314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15DF2942318
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 00:48:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF4511F24D8C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 22:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC56718FC9A;
	Tue, 30 Jul 2024 22:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B6t53Oel"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F375C18CBFB
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 22:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722379684; cv=none; b=nZ4rDCRdZ/uOOxbbtkz44f8KRrKuwkEfocpacvYy62vtuDWEKKRRnNc45laFPgOLDR4lZ3XmtIczMBvSRFp1irVFcgsIAazI45numu5dKtLdsNPQ98GngkdcO6LvYLbdYK2kpPtZzB06Su/FCuKDdv0YAAC7IPL1wnJKOiqXH7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722379684; c=relaxed/simple;
	bh=WNxTFcwd+P8aGMCFG3m0x18YYSZtwqBSZQ2LZ+l/IOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sHy4K9eMPzgHB57RcfltOYpXPFcH/9qozcZaetdOCKqw+b5+2OWPSgTbMVoFQWliMTg8fqNBpxQp/LvpwWQp4n6HFQG5cgemOqS2mXNysYDF4YCJxCE43J9spXKRvLUixdgDivNpbaq2ifIY8tzw2lffyUGVoT+0g4ajV9J0JHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B6t53Oel; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1A46C32782;
	Tue, 30 Jul 2024 22:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722379683;
	bh=WNxTFcwd+P8aGMCFG3m0x18YYSZtwqBSZQ2LZ+l/IOI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B6t53OelgE1TtEQQOFEh3zyoFoGfxUt0+CWt0Ag+hSW3vorO0mk5V5ahqQexHbwqZ
	 DMp4PohERmoaEQ06Kmtv3nYZunlpz0syNLW0qsXHna9RdNGHZgcMQjAjGid/ag/0UD
	 Tj5DHIF/AXcvzj2GaJXNwLfE82AY5P7ev3IUv0plq5l2OcbpCwViYDFvhfyqxrZ7da
	 VGSiIt8NT9FhAI8USMAY98y45uw+egttlUOnZ9L82LIZkciVHFxN4pED1DHNZMMxMO
	 IXcvR3I1OdW9ywaymHOMe9FR47I423ylw7NAgh0vWsizk6wYWSJ2fCeGzpX/qX5Fxh
	 qKJS69r7RwN6w==
Date: Wed, 31 Jul 2024 00:47:59 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: urezki@gmail.com, hch@infradead.org, vbabka@suse.cz, mhocko@suse.com,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 1/4] mm: kvrealloc: disable KASAN when switching to
 vmalloc
Message-ID: <Zqltn2PH1oZ7cEqJ@pollux.localdomain>
References: <20240730185049.6244-1-dakr@kernel.org>
 <20240730185049.6244-2-dakr@kernel.org>
 <20240730141508.2da2194a2faacfabb6030c18@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240730141508.2da2194a2faacfabb6030c18@linux-foundation.org>

On Tue, Jul 30, 2024 at 02:15:08PM -0700, Andrew Morton wrote:
> On Tue, 30 Jul 2024 20:49:41 +0200 Danilo Krummrich <dakr@kernel.org> wrote:
> 
> > Disable KASAN accessibility checks when switching from a kmalloc buffer
> > to a vmalloc buffer.
> 
> This text tells us "what", which was utterly evident from a cursory
> read of the code.
> 
> Please tell us the "why".  Completely.

As mentioned in the other reply. Since this is a fixup series for stuff that's
in mm-unstable already, and hence gets squashed in later on, I treated this more
like the list of changes one would also append when sending the next version of
a series.

If you expect such fixup commits to have the same detail than regular ones, I'll
surely add those details and resend. Please let me know.

> 
> > Fixes: 923a26b4c679 ("mm: kvmalloc: align kvrealloc() with krealloc()")
> 
> For those who are following along, this patch in mm-unstable so this
> patch will be squished into the above.
> 


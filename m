Return-Path: <linux-kernel+bounces-516723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB37A37640
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 18:22:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB55B188FC13
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 17:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA3E119C574;
	Sun, 16 Feb 2025 17:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="QdUZXIQD"
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA3AD299;
	Sun, 16 Feb 2025 17:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739726559; cv=none; b=M0zSXqiNREaL/mztreAo76t529EYCgnOTIhqyMPiQbGnnpL0QhKav03yodMWszjx2VrayUCihXOjHVO3sEgAqt9yPHOakpwuh0oRBYxc5KjGXN03cq7dnHFpVr4CxbEtcZ3nJWXPwXlpC3kqYIkIOv+WiSLiXGtlm15I9YKW0d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739726559; c=relaxed/simple;
	bh=sbVTzp/aswZC9d4F2sy5ZqtotgGiFEnB+GOs2yOh1hw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nqtk6gB8gsjEL81xZt3JbiL/6qB3Bqz5/IGnqApaEtX45m5YvSIohlsbozhLCjlQfEqjTB0j+y6rMDTgdWFBFFfFfrsI3joNYbKNjrwkAQrVaAY40vD/73NRm5Xvmcj5u3XD+ZozmaxjUcvngpzvXPTmPYs72M70sYwH83u/6fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=QdUZXIQD; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=C3NYI4M2D6dwE52ZoZ0uhhAoWlcFjeRkijtSlVl8rCw=; b=QdUZXIQDj1CvWPFT4RlV40fM70
	xVVA+ebyhYGjjHlNPIfhIlq9C6FQg4XS4P4H0PeiXQOKRiXcPzk6GlZD6O25ZOb8IJt+bJDO6iq2l
	6GRV2kKWppONJqKfzNybnfd8+LAkWrNgi9Evjuhp7dB2SwUegqtNH13jICdbcmmz2Li3asRfW5LEX
	dP7ZVIAKxwagxBFap9GB44qznj2V2XY1hGSo7CbQdzfifrkphwespKkJD2DxmCKknCV4WdDepxfLM
	L3kEiiK7qSzlLOMaUHfrmwPZm7eHBGUMkJCEYVfOMGCD/5yYr1+cP1Ib9iIVHGFEP0CAtyyd9+HFU
	sJezaALQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tjiLi-0000000G1L4-34Rp;
	Sun, 16 Feb 2025 17:22:34 +0000
Date: Sun, 16 Feb 2025 17:22:34 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Magnus Lindholm <linmag7@gmail.com>
Cc: richard.henderson@linaro.org, mattst88@gmail.com,
	glaubitz@physik.fu-berlin.de, ink@unseen.parts, kees@kernel.org,
	arnd@arndb.de, linux-kernel@vger.kernel.org,
	linux-alpha@vger.kernel.org
Subject: Re: [PATCH 1/1] alpha: Fix pte_swp_exclusive on alpha
Message-ID: <20250216172234.GH1977892@ZenIV>
References: <20250216170748.2258-1-linmag7@gmail.com>
 <20250216170748.2258-2-linmag7@gmail.com>
 <20250216171741.GG1977892@ZenIV>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250216171741.GG1977892@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sun, Feb 16, 2025 at 05:17:41PM +0000, Al Viro wrote:
> On Sun, Feb 16, 2025 at 06:04:53PM +0100, Magnus Lindholm wrote:
> > Function pte_swp_exclusive() checks if _PAGE_SWP_EXCLUSIVE bit is set in
> > PTE but returns lower 32-bits only. Shift bits right by 32 to return upper
> > 32-bits of PTE which contain the _PAGE_SWP_EXCLUSIVE bit. On alpha this is
> > bit 39 but on most other architectures this bit already resides somewhere
> > in the first 32-bits and hence a shift is not necessary on those archs.
> 
> Just make it return bool and be done with that - all users are either
> if (pte_swp_exclusive(...)) or if (!pte_swp_exclusive(...)) or assignments
> to bool variable.
> 
> No need to shift anything - compiler probably will figure out that
> 	if ((int)((x & (1UL<<39)>>32)))
> is equivalent to
> 	if (x & (1UL<<39))
> but why bother with such convolutions in the first place?
> 
> Seriously, just make it
> 
> bool pte_swp_exclusive(pte_t pte)
> {
> 	return pte_val(pte) & _PAGE_SWP_EXCLUSIVE;
> }
> 
> and that's it - conversion from arithmetical types to bool will do the right thing.

FWIW,

sed -i -e '/pte_swp_exclusive/s/int/bool/' `git grep -l pte_swp_exclusive arch/`

will do the right thing - check and you'll see.


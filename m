Return-Path: <linux-kernel+bounces-287518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F21779528B4
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 07:02:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D4681F237FD
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 05:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B856647F6B;
	Thu, 15 Aug 2024 05:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LTST7chL"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A273145948
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 05:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723698167; cv=none; b=eKWlPETPkj5FAfnx//V1PI0fPw/IbTWqKMaNUywtDSLydBLf3omgR/FONxMnElqrxdGXXo0TzfOUmWgGZxggvf90zK0wvA7pDHoBu6j7/sTDybzAh6SLRRaQmviHxvjE9QKLAAhVoehl9Iz6pe1hhMYuXoj3gL5oOra84sR2Grc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723698167; c=relaxed/simple;
	bh=oHbmbnewF1E6YYmkh2g6KIO9ik/mTeUuh7mn5Q/Pdc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f8TM19T9FD4H8B1NPAE9VLs/2xjR9BxRw8+8G2OmN7N0vDRlv7tWR1rT5nbAr/nh3jGMNDVGEjptfFUXEMayDDABvkLQujseQ81DR/XeWBGLDUpO758NjxPgbLlh/4TcZzKml4RIMpeqvGQmEmXRd8qzLvIBOKFCQc/t2Acc51Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=LTST7chL; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=2W5XBTTcn/I+V3oQ5FiJK9Bnvhu/WhbWQrogDVbs2cY=; b=LTST7chLP1ATK0E4FQjjad272f
	g16xPEzQ7w2Y/kztiKO3xl1FuY9NpZWYbSqHBG/eh1yh3jJxbOM8ApZr4URmneDoKQoPYsd985fzr
	WfP7LxkLgeSF0PARE1D55KvfTD6IiChF5bYmEbhKoXvmJzsmYbIOfac7I3Q+R9GeChngmX3ZiN/4x
	MwegQ8Sy6BDKbI7aocmbKrH7oW1rwHnx1uvcz/PkgRlRebxyPJFT7K7/IcRjXZkIzp1Q4OJwBJm+g
	MB83s094F11jYzqi1jnCnrKgkt1tOB86q65R8LMjnlCG6n31rQed8jp6j4WSCLK2Pm0kz1eWwwiqA
	4O0xbnjA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1seSdE-000000091xw-31ne;
	Thu, 15 Aug 2024 05:02:40 +0000
Date: Wed, 14 Aug 2024 22:02:40 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Christoph Hellwig <hch@infradead.org>,
	Alistair Popple <apopple@nvidia.com>,
	Max Ramanouski <max8rr8@gmail.com>, x86@kernel.org,
	dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
	linux-kernel@vger.kernel.org, jniethe@nvidia.com,
	jhubbard@nvidia.com, linux-mm@kvack.org
Subject: Re: [PATCH v2] x86/ioremap: Use is_ioremap_addr() in iounmap()
Message-ID: <Zr2L8PUglYWzFTic@infradead.org>
References: <20240812203538.82548-1-max8rr8@gmail.com>
 <Zrwyh9bKGVzkLzeA@infradead.org>
 <878qwzpfbi.ffs@tglx>
 <87le0zmhdp.fsf@nvdebian.thelocal>
 <ZrygJqIAz_AqqjcT@infradead.org>
 <87wmkjnqi4.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wmkjnqi4.ffs@tglx>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Aug 14, 2024 at 04:11:31PM +0200, Thomas Gleixner wrote:
> > Various architectures had either an early ioremap variant that got
> > silently ignored here, or magic carveout that don't get remapped at all.
> > None of this should currently apply to x86, though.
> 
> So I'm inclined to have:
> 
>        if (WARN_ON_ONCE(is_ioremap_addr(addr)))
>        		return;
> 
> in the x86 variant then.

And we should do the same for the generic code eventually after
accounting for all exceptions.  Those should these days mostly be
handled before hand and have explicit address ranges as well, but it'll
need some time to figure all that out.



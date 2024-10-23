Return-Path: <linux-kernel+bounces-377379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8C8C9ABE1B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 07:47:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CF6A284D17
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 05:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C4C3145323;
	Wed, 23 Oct 2024 05:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="R2Sy36+T"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018BC8825;
	Wed, 23 Oct 2024 05:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729662432; cv=none; b=LePUPwQbJqhzTMpuMfn0DMH29bLKxqGoTgktD5ARQaXUEY41gjlpUYok671CEGfFWfeKfuaDGVp3fMY9b5t0yMuXQ8AfFZgDG1dV8pksjeVY20GfSFdxxF7zjdFPndQ102Gcb1zAOOXha3NxWx2GhkJdT2wz+pedObgXCmTNXrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729662432; c=relaxed/simple;
	bh=VQgSmAK/JG+j3V7JYXzHNKI73TIsVs0oTJmANFnSi8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MW86yzYdciJZuotAZJVFKIDPv7AGb4SDI6WaKH+RKOsD6HfjU+RrbSgIdhIgULxh3o+FtJFwap5C1Shz9KhfdAwTl4LXxSCWNywvbehcXf7Hlk/J2EoMbW+HxxLo8EwmZp+t19mK/ksy8QYHUj4UbNtFeN5h5UIZsBdd8aoKGQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=R2Sy36+T; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=j8vsn0PL6aLGlTipI28qvN0zE8qrOLsX2TXQbg3aqio=; b=R2Sy36+TAfZOxT1iBiJSXWAM/0
	LxANdmZWVUVZuf9K8fAl+MbOoWH3E+QPi2KeX1g+NMx7ZSHMsFAT3eZI91epb6H0ri8UMExtoYQkL
	UrLdXVt7zAq2inscdFnQQoDtm4z/VxbyoZiqMi5dQ26bOQxvFrXclaoQIRW0gSKRJoUkEPQhbEkV5
	Ep+eOr6u7BIB5tD/cdOPj5mQOX8q838DVTCRjuZaPiHcWXkG+sleic59GJoi0h9uEn9PiUYgDFJfZ
	5Ba95JBvkHqFpNcWt9Fx1ugKAl6jvnoFvnGxartOb3SmCpFZ5NwmSjrkiAyhuAP7kNfqdbB9QnfYL
	gWu/zxwg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t3UD7-0000000D5x0-0QqV;
	Wed, 23 Oct 2024 05:47:09 +0000
Date: Tue, 22 Oct 2024 22:47:09 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Christoph Hellwig <hch@infradead.org>, Kees Cook <kees@kernel.org>,
	Sasha Levin <sashal@kernel.org>, torvalds@linux-foundation.org,
	ksummit@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: linus-next: improving functional testing for to-be-merged pull
 requests
Message-ID: <ZxiN3aINYI4u8pRx@infradead.org>
References: <ZxZ8MStt4e8JXeJb@sashalap>
 <792F4759-EA33-48B8-9AD0-FA14FA69E86E@kernel.org>
 <ZxdKwtTd7LvpieLK@infradead.org>
 <20241022041243.7f2e53ad@rorschach.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241022041243.7f2e53ad@rorschach.local.home>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Oct 22, 2024 at 04:12:43AM -0400, Steven Rostedt wrote:
> You mean have everything go into linux-next before going to Linus after -rc1?
> 
> I'm one that doesn't do this. That's because my code in linux-next
> after -rc1 is for the next merge window, and the code I send to Linus
> is only fixes for code I sent before -rc1. I tend to keep an "urgent"
> and "core" branch. My "core" branch is everything I plan to send in the
> next merge window and goes into linux-next (via being pulled into my
> for-next branch). After I send my pull request to Linus, and he pulls
> it in the merge window, that "core" branch becomes my "urgent" branch.

You can easily have two branches in linux-next.  Many trees do that.
It is also a really nice warning about self-conflicts.



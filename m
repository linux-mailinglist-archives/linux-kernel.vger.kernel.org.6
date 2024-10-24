Return-Path: <linux-kernel+bounces-380516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 837469AEFCE
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 20:47:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39AB22822BE
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 18:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B077D1FBF67;
	Thu, 24 Oct 2024 18:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jdj5qo9F"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182B7482EF
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 18:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729795667; cv=none; b=IUjR0sbySozx1cQqOS0mflNky9LKkw5LcBcMgGtYJBc8lSGwlELsSceiHNon016JMnPgtrqJzs1ZGObiYOP/708s9DqAjbwl9mj+bXs6y25PNqAfqpLx2BsHqxeBwhUqgtB6mgbo8+SIPVe9ceyITv8Blyq1feqYVffUgWorGqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729795667; c=relaxed/simple;
	bh=vCFwkBhwKSkWgSnLKxCYwPdqUx5G3ANj3+T3uNLLhgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PsnA0/6KM8JhEA2JExh2r57lyhc5KD+WrxFUVR3sCnTBnw9dyohS58FiT+dfrYU+9mHpeu+Qo9qw2kG7zbar4+v4H6/pPYOCUihs1TSqVifPoRokUevT9v+eplmbiHJJWCcmJv6fZ6u0rgFzTczz4pAro+BmI4SKBMcIAXnMSTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jdj5qo9F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 443DBC4CEC7;
	Thu, 24 Oct 2024 18:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729795666;
	bh=vCFwkBhwKSkWgSnLKxCYwPdqUx5G3ANj3+T3uNLLhgY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Jdj5qo9FWSM3kY6pzCBIIpLtmDHUY9ms19Cz2hBcIfjSqMDTC2/yzzi7AxgGpeZ74
	 e5iPiC2DFarSBGvOVNzGC3pSSU1T4Ojdy28DbASJL42qQLhyUjDsw3ziMYNEZ1hESG
	 vAYBZWvPorw2iUZA8O3i65cQ21YEMhLvQH1pr27tFej0thmscpK/xEKdOwH6bHYVY1
	 f0M0pY8EnZk/KAUBHg60IkxHrWNRQJL4mAW2DOS85AFgGlOnKMm1SyVkcU2z0w1Esy
	 Slsnyv5JnHNQQNOZ+5UZWtHnMq33f9MBeNJhJ/5cuI0QdRsoDDA3ve/pjuilmHKF1X
	 ulZp1k5VM5beg==
Date: Thu, 24 Oct 2024 11:47:44 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	x86@kernel.org, Andrew Cooper <andrew.cooper3@citrix.com>,
	Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH] x86: fix user address masking non-canonical speculation
 issue
Message-ID: <20241024184744.l3575coe4sx26hgl@treble.attlocal.net>
References: <20241024013214.129639-1-torvalds@linux-foundation.org>
 <20241024061300.l5y4ng5gmkfrfdht@treble.attlocal.net>
 <CAHk-=wihBAdfL+OgaO71H_n4NFVyDdTXWEA_fjrdEFUc-=D1Sg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wihBAdfL+OgaO71H_n4NFVyDdTXWEA_fjrdEFUc-=D1Sg@mail.gmail.com>

On Thu, Oct 24, 2024 at 10:35:33AM -0700, Linus Torvalds wrote:
> >  i.e. when bit 47/56 is
> > set and 63 is cleared, would it not go untouched by mask_user_address()
> > and thus be speculatively interpreted by AMD as a kernel address?
> 
> AMD doesn't _have_ LAM. When they do, they had better not
> speculatively mis-interpret addresses.

Ok.  I was thinking AMD had its own version of LAM, though all I can
find is UAI which is actually quite different since it ignores bit 63
altogether (and isn't supported in Linux anyway).

> > Also, the comment above __access_ok() now seems obsolete:
> >
> > /*
> >  * User pointers can have tag bits on x86-64.  This scheme tolerates
> >  * arbitrary values in those bits rather then masking them off.
> 
> No. The comment is still correct. The scheme tolerates exactly the LAM
> kind of hardware-based address masking.

The comment doesn't seem right to me at all.

With LAM enabled, USER_PTR_MAX is PAGE_SIZE away from the sign change
boundary.  So __access_ok() no longer has size check slop and that whole
discussion about the sign change boundary can go away.

AFAICT #GP can only happen when LAM is enabled and bit 47 (or 56 for
LA57) doesn't match bit 63.

-- 
Josh


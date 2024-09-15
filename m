Return-Path: <linux-kernel+bounces-330070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EB6E979938
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 23:39:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D782B20BA0
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 21:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25AC771B3A;
	Sun, 15 Sep 2024 21:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qTqfmSy7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81DC4101EE;
	Sun, 15 Sep 2024 21:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726436369; cv=none; b=g0PtIxtp0kcDh6aPZpbZ/BFAIGz4kze4jjtnG0HWd93GuFVC/hPZ3mPcoUC6iRAtDAj90cFkZrzGT7EXDWu7wyhxlaT8m9iBowgIS/pT15ZiUBMYeihSYNAnUJizerKSfsKrVp/Hj9yetdW+HaFlcZVnW399eLaJH3L0Js3o8Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726436369; c=relaxed/simple;
	bh=2tMEMi7GDfUlc10rGRCBy0hqCwf35bAn1XHWgMvXlAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nf7+pxymEzt4BuNP7SN72EHOxyW2dh6ee1JwAOWYaaXeD21vvlx4j9iKgse3JDojahJdHe0KnJ85kLqv4de4RrxbCCRbp52AfFkZhR1vDWehwuwCj2QNd1CvtLxdqJ8RrCwIH4BO9BafLskglMj00mYTu+PhK5YFQSwtebtEfmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qTqfmSy7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45890C4CEC3;
	Sun, 15 Sep 2024 21:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726436369;
	bh=2tMEMi7GDfUlc10rGRCBy0hqCwf35bAn1XHWgMvXlAQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qTqfmSy7Lm/hqHWNxGA2z+JlpAn/bHpscxEWXY+VjA9ub2iEnlU044M/b2uJAZImI
	 0fHM6e/uCVbPbvi2L6hF1rExcgvK9S2eHr3qKX2MO+L4EDuzIJgU+zCZ5HnR+EfeHF
	 NkdXxH+14HMuV0PVKjDrf/9DlmJ37UHO53JoIrmBK5en2uAMuBv1pAgxXKVO4+ExLt
	 64hezwzEcegWfmTKzMMJRfKT30hIDPY7AFORMd105TfOZToWhlsmjrtLYGPjY8dSZn
	 7+5XBczmDeleb98FVY2wNvkBmcz+EInr1Be4kUBQAxPEmfADgpv6gklL1rlvTAs2xS
	 FbLOR/sATvhzQ==
Date: Sun, 15 Sep 2024 23:39:21 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Gary Guo <gary@garyguo.net>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com,
	boqun.feng@gmail.com, bjorn3_gh@protonmail.com,
	benno.lossin@proton.me, a.hindborg@samsung.com,
	aliceryhl@google.com, akpm@linux-foundation.org,
	daniel.almeida@collabora.com, faith.ekstrand@collabora.com,
	boris.brezillon@collabora.com, lina@asahilina.net,
	mcanal@igalia.com, zhiw@nvidia.com, cjia@nvidia.com,
	jhubbard@nvidia.com, airlied@redhat.com, ajanulgu@redhat.com,
	lyude@redhat.com, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v7 01/26] rust: alloc: add `Allocator` trait
Message-ID: <ZudUCRYAYpS3U5ky@pollux>
References: <20240911225449.152928-1-dakr@kernel.org>
 <20240911225449.152928-2-dakr@kernel.org>
 <20240915162813.149e21f2.gary@garyguo.net>
 <ZucTMDCcoVH4oGs1@pollux>
 <20240915202242.7a16b3d3.gary@garyguo.net>
 <20240915210827.3ee9adcd.gary@garyguo.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240915210827.3ee9adcd.gary@garyguo.net>

On Sun, Sep 15, 2024 at 09:08:27PM +0100, Gary Guo wrote:
> Just to add that if you *really* want to avoid the old layout param,
> another approach accceptable to me is to have a `NonZeroLayout` and have
> `alloc` only accept that.

That is a good idea, I like that.

> 
> Either `Allocator` trait handles ZST well or it refuses to handle them
> at all. No "it works for alloc but not for free" please.

I agree with that, then we shouldn't handle them at all.

> 
> Best,
> Gary
> 
> > > >     
> > > > > 
> > > > > Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> > > > > Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> > > > > ---
> > > > >  rust/kernel/alloc.rs | 112 +++++++++++++++++++++++++++++++++++++++++++
> > > > >  1 file changed, 112 insertions(+)  
> > 
> 


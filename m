Return-Path: <linux-kernel+bounces-260054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B37E893A249
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 16:05:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEFA11C228BF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 14:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4399B153BF8;
	Tue, 23 Jul 2024 14:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YQIxUIv0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849A113698E;
	Tue, 23 Jul 2024 14:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721743519; cv=none; b=o7oDO0WoacQaIkgUmZRSFmOXf3tdX2PQ6mdAqcDgqxpQ0poHbyJOiVsehWIE64NgAsY4xZc6bRhDncdIUqGxNGWuSsJE2QVtZNKgwNyy6bDB4uYZcL2AdFzDQt6J38w/rYLerorWQ3Me0zbiSm2VgMhVQCvK0oqn45GNzvUyuCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721743519; c=relaxed/simple;
	bh=EGgf5pTY410KJ67p39mnjqLgRrmTHb+HFz152ObkjIo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hDK81FgyBOcwFaSGThS7AI0nSiSQpxukF1795cW55+YXrxzOhgbXN/vDB/PGkS94/Bub9wUQpQAYO+JTAuMjTcpfIsLWAxX2TynnbC+WNpxi9So+NAfsQHc1sesTbd8e0zaRVK2UpQEWr1AFFvzlyWEnds8I5ps28XVdDHpOjc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YQIxUIv0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D10ACC4AF11;
	Tue, 23 Jul 2024 14:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721743519;
	bh=EGgf5pTY410KJ67p39mnjqLgRrmTHb+HFz152ObkjIo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YQIxUIv03F43BFfAm/TPO/aKoz5jkUBYzBBf6/5tCIH6syJMSf2mfcevW9EpLH+HA
	 RGMjWDsSwDFVc9QJApdcP4Iren6uJ+OwBsBpPYncgWhr3VwRg7YHSwEOKisCe1bPJq
	 gKIyZWf6jMdmhuImPeEJI83C4FMDzdJwdP9MpwJQntTlaZra5L2IEpkKvKgPh1qvSW
	 06d7W9RqXAp8bM3c6jyOZiFzhWhW7rPWY4gNT9GcecTsvsVO9JxvjjMt34aRTjxXJG
	 0k21hUObt3ziLpsxkAmT9xcqqmLv9aKjVEtb6G+Tiae/t/zt76S4MKvulhmJR5Wsca
	 m/Uh3bXtAZgCw==
Date: Tue, 23 Jul 2024 16:05:11 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: cl@linux.com, penberg@kernel.org, rientjes@google.com,
	iamjoonsoo.kim@lge.com, vbabka@suse.cz, roman.gushchin@linux.dev,
	42.hyeyoo@gmail.com, urezki@gmail.com, hch@infradead.org,
	kees@kernel.org, ojeda@kernel.org, wedsonaf@gmail.com,
	mhocko@kernel.org, mpe@ellerman.id.au, chandan.babu@oracle.com,
	christian.koenig@amd.com, maz@kernel.org, oliver.upton@linux.dev,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v2 2/2] mm: kvmalloc: align kvrealloc() with krealloc()
Message-ID: <Zp-4l4ARjzVyDUvH@pollux>
References: <20240722163111.4766-1-dakr@kernel.org>
 <20240722163111.4766-3-dakr@kernel.org>
 <20240722184348.3df3b433c8f49f123e1c8d9e@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240722184348.3df3b433c8f49f123e1c8d9e@linux-foundation.org>

On Mon, Jul 22, 2024 at 06:43:48PM -0700, Andrew Morton wrote:
> On Mon, 22 Jul 2024 18:29:24 +0200 Danilo Krummrich <dakr@kernel.org> wrote:
> 
> > Besides the obvious (and desired) difference between krealloc() and
> > kvrealloc(), there is some inconsistency in their function signatures
> > and behavior:
> > 
> >  - krealloc() frees the memory when the requested size is zero, whereas
> >    kvrealloc() simply returns a pointer to the existing allocation.
> 
> The old kvrealloc() behavior actually sounds somewhat useful.  You've
> checked that no existing sites were relying on this?

Yes, I did.

> 
> And that all existing kvrealloc() callers were (incorrectly) checking
> for NULL?  Seems that way.

You mean for the initial allocation? Yes, but I also noticed that as long as the
old kvrealloc() is called with p == NULL and oldsize == 0 it should work as
well.


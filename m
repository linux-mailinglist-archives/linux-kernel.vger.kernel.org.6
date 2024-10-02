Return-Path: <linux-kernel+bounces-347013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0825798CC42
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 07:14:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CB7D285E21
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 05:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C8921AACA;
	Wed,  2 Oct 2024 05:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MONFU4x7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBED89473
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 05:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727846084; cv=none; b=Pnrq7CGPDC+oDAfppv3K1msDsHu7ie/aoP7GBbZbaIh+Dg0O2SvueIoFOsP3zCkdtVl/o2VuwqQoB9WOOnsMY12DO9ZUflnImdqOwh8lKTyZpwTbma2WKR7VgJZs7K8OyMdXd+AFbhotbV/6cS12S4dyVis5iVqX7oQ9f0y/JyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727846084; c=relaxed/simple;
	bh=c7rLB5/VUrdk7s0iqLe6pI3/lO8W2J+Xm4Qz1OG3pIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bzd/7ICgNXnnSHe3yuOOvqETxvLit2fHpYVH1dRnysR38VTKiRhjSeTH1rHIOOP7tw2qoPAephZlysNBwCbTvrUBmdguFmo05r621/AM4+smHOI5ZsadwbTvwcjx+TeJgzpEmbJhjVqFth19CW4Xv2ys/EBOGzfNCcB/Psyx+Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MONFU4x7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2048C4CEC5;
	Wed,  2 Oct 2024 05:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727846084;
	bh=c7rLB5/VUrdk7s0iqLe6pI3/lO8W2J+Xm4Qz1OG3pIk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MONFU4x7aUZpBQGcC9QkuqMs5GS0f081TWEgWJBNjGa8kpRB7Kf9yR5RoqF4JMR2E
	 U4yFZ67CUbdlxs24pFdWLuyAOwEA+O2hkxy2FkbT0goi6yqL2TI9VPUB55s0w4sUvU
	 quusMxxiDAN/8FmPJiJi1a+rVv/vNk25zoJnglaNz2LCyPJiPvGuxvBQ7HQba9mI0N
	 0ezBozSMWrbnhgQTlHiADfULxRPSaNRe4QHxWJQIHT+X24kQVDjS9AwigkWi8KIGrl
	 GNzlzPCuG2PLltnjs4qxnRpaDamvRlu3wvfkzKoq2L3o1LZyxpOAbMgJcOEg0Nc4Sr
	 mD2cROEy0sAGw==
Date: Wed, 2 Oct 2024 08:11:24 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Patrick Roy <roypat@amazon.co.uk>, david@redhat.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, graf@amazon.com, jgowans@amazon.com
Subject: Re: [PATCH] secretmem: disable memfd_secret() if arch cannot set
 direct map
Message-ID: <ZvzV_GVjp05rcqxj@kernel.org>
References: <20241001080056.784735-1-roypat@amazon.co.uk>
 <20241001150438.017b7bb4cd1baceb53a764bf@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241001150438.017b7bb4cd1baceb53a764bf@linux-foundation.org>

On Tue, Oct 01, 2024 at 03:04:38PM -0700, Andrew Morton wrote:
> On Tue, 1 Oct 2024 09:00:41 +0100 Patrick Roy <roypat@amazon.co.uk> wrote:
> 
> > Return -ENOSYS from memfd_secret() syscall if !can_set_direct_map().
> > This is the case for example on some arm64 configurations, where marking
> > 4k PTEs in the direct map not present can only be done if the direct map
> > is set up at 4k granularity in the first place (as ARM's
> > break-before-make semantics do not easily allow breaking apart
> > large/gigantic pages).
> > 
> > More precisely, on arm64 systems with !can_set_direct_map(),
> > set_direct_map_invalid_noflush() is a no-op, however it returns success
> > (0) instead of an error. This means that memfd_secret will seemingly
> > "work" (e.g. syscall succeeds, you can mmap the fd and fault in pages),
> > but it does not actually achieve its goal of removing its memory from
> > the direct map.
> > 
> > Note that with this patch, memfd_secret() will start erroring on systems
> > where can_set_direct_map() returns false (arm64 with
> > CONFIG_RODATA_FULL_DEFAULT_ENABLED=n, CONFIG_DEBUG_PAGEALLOC=n and
> > CONFIG_KFENCE=n), but that still seems better than the current silent
> > failure. Since CONFIG_RODATA_FULL_DEFAULT_ENABLED defaults to 'y', most
> > arm64 systems actually have a working memfd_secret() and aren't be
> > affected.
> > 
> > >From going through the iterations of the original memfd_secret patch
> > series, it seems that disabling the syscall in these scenarios was the
> > intended behavior [1] (preferred over having
> > set_direct_map_invalid_noflush return an error as that would result in
> > SIGBUSes at page-fault time), however the check for it got dropped
> > between v16 [2] and v17 [3], when secretmem moved away from CMA
> > allocations.
> > 
> > [1]: https://lore.kernel.org/lkml/20201124164930.GK8537@kernel.org/
> > [2]: https://lore.kernel.org/lkml/20210121122723.3446-11-rppt@kernel.org/#t
> > [3]: https://lore.kernel.org/lkml/20201125092208.12544-10-rppt@kernel.org/
> 
> Thanks.
> 
> > Fixes: 1507f51255c9 ("mm: introduce memfd_secret system call to create "secret" memory areas")
> 
> So I'm thinking this fix should be backported into kernels which
> contain 1507f51255c9, agree?

Yes 

-- 
Sincerely yours,
Mike.


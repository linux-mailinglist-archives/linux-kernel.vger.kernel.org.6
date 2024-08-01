Return-Path: <linux-kernel+bounces-271231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCFBD944B54
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 14:32:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77DD0B25922
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 12:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FE411A0712;
	Thu,  1 Aug 2024 12:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p/qOH4gQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F43218950D;
	Thu,  1 Aug 2024 12:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722515497; cv=none; b=dNg1vjUojDrqQPmJH1BtFhSRtBkIg05xoqgBIS5izQaIHXCxCvmY8bxI4RcxATJXyP0dRZzyv8CPskkkV0qL56W9wYpeZfdkBThJDVW0flxrNgJr1AloSKbLKq+OapLRMBOGo2gFv3FJ8OvrRSAzTkq2UXH+fldf9Mned7VbYfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722515497; c=relaxed/simple;
	bh=UK3PAqMjw979wx5Ie0BBTgUW7P1oxUk5LvST6rJ/ctY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j0mPd1PP3AvGjQ8QLIeefHb6gzA6Wyt4agUwBmpJU23inQFQ+2HPsVXlHUuAChD34JKac5KkjIDdOPVSCqrrhkPT+rm6fXB9feQHLB+k/CwHMuwmOeC9J7kjs6oHv/g0/TwAocyOzt4rvgMPoYhqTfs2RKkyw9bDRcBTP4J2wg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p/qOH4gQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F73AC32786;
	Thu,  1 Aug 2024 12:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722515497;
	bh=UK3PAqMjw979wx5Ie0BBTgUW7P1oxUk5LvST6rJ/ctY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p/qOH4gQEmTdcjwrP926auEMzokTQWEJWVzEZSW3aNPE357oUPqYBM9V3CytErj6x
	 yFd5GXClcORsfuZESaRL4G8pkggB6D6f7jnts08B8xqtJV4pdRUyd4RHypLe0HKlZo
	 AscXUgSSKXx0uBZAg/kZ+pPT5rKcz1oaBT7ee//CFRE73H4eJg8rOcwtKyyGXp3p4L
	 lz0SwLxzwSwRCCcGoZt6SAN+fs0YujvU47f1SSRdL42KgIxCOegVU0svu/oDgjbLxt
	 bmvgX7CbZsno2vZxvu4xqgVqjFriSVDL+Jw1xgHSPUKMpUZr9D0RZbvZj0tyTUWwsd
	 r9kwcPnGux0fQ==
Date: Thu, 1 Aug 2024 14:31:29 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com,
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	benno.lossin@proton.me, a.hindborg@samsung.com,
	akpm@linux-foundation.org, daniel.almeida@collabora.com,
	faith.ekstrand@collabora.com, boris.brezillon@collabora.com,
	lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com,
	acurrid@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com,
	airlied@redhat.com, ajanulgu@redhat.com, lyude@redhat.com,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v3 07/25] rust: alloc: implement `KVmalloc` allocator
Message-ID: <ZquAIT_ULTmRIyos@pollux>
References: <20240801000641.1882-1-dakr@kernel.org>
 <20240801000641.1882-8-dakr@kernel.org>
 <CAH5fLggy5ngdaEFe1oqO4wgZHTNsx=2A9a+5HNeA6GiUKrHPOw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH5fLggy5ngdaEFe1oqO4wgZHTNsx=2A9a+5HNeA6GiUKrHPOw@mail.gmail.com>

On Thu, Aug 01, 2024 at 10:43:44AM +0200, Alice Ryhl wrote:
> On Thu, Aug 1, 2024 at 2:07 AM Danilo Krummrich <dakr@kernel.org> wrote:
> >
> > Implement `Allocator` for `KVmalloc`, an `Allocator` that tries to
> > allocate memory wth `kmalloc` first and, on failure, falls back to
> > `vmalloc`.
> >
> > All memory allocations made with `KVmalloc` end up in
> > `kvrealloc_noprof()`; all frees in `kvfree()`.
> >
> > Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> 
> The nit from vrealloc also applies here, but:

Yes, I will add the invariant comment for both.

> 
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> 


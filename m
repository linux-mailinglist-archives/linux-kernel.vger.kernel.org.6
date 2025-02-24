Return-Path: <linux-kernel+bounces-530132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 741B5A42F7B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 22:50:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27921177676
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 21:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B74C21E0DE4;
	Mon, 24 Feb 2025 21:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HbHhh+1O"
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450CA1E0DD8
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 21:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740433777; cv=none; b=lW4kuv07QsPh7MRhpMqr8GIRat/fWGgrOpUybJkuy155kArkdvoODUkMPswsn5PsRE4ik03UlJhl3q1gi4ly9nNapnAOHkzMjNZqGy31fSx0FjpU1LeKZdj4OQ/Z+bmeah1p3I/wx814wztmCuHmuAxdZx/ttZvaJo4UJuKjWQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740433777; c=relaxed/simple;
	bh=wFxgtDoeoe31jZ22+x+D/UbVDmhmAr6BjAfhfFfbwZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RSyCvYIgkFK8l5fFf6LZ2NhnyIQHOAAx6Q0ZaqjvENtk4Ec8GQKXRM6dnzppp+9IBNV6g6K/yweztW0Bi+Y673Tdvf0ujZh40M+mOuj2i7KSum558grxbGCfU2/hyyMsN+JqgkpO7H3+5cmUVuDEqYqRE1v1q35DsMOYOUOXBL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HbHhh+1O; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 24 Feb 2025 21:49:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740433773;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n2f5hf7hxUD5ewFdsNAsjOnJ49wB0U6nGcYqVKwEfKc=;
	b=HbHhh+1OHi8c9eqwewWNl1lgd12nNgByFLByUUmHpEbYHF7P2BOgA6a2LLDlgHfzBYzdUO
	WIJj1z1gIT95LtlhA3pT+DaE6SIx8d/YnC2bzFWXUk2v4QkbsvoUwBXgMorOJeah4kE17W
	DZSJhXxDxvSsPYFLPXqnIftUUfNCFjU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Barry Song <21cnbao@gmail.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
	Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	"Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"hannes@cmpxchg.org" <hannes@cmpxchg.org>,
	"nphamcs@gmail.com" <nphamcs@gmail.com>,
	"chengming.zhou@linux.dev" <chengming.zhou@linux.dev>,
	"usamaarif642@gmail.com" <usamaarif642@gmail.com>,
	"ryan.roberts@arm.com" <ryan.roberts@arm.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"clabbe@baylibre.com" <clabbe@baylibre.com>,
	"ardb@kernel.org" <ardb@kernel.org>,
	"ebiggers@google.com" <ebiggers@google.com>,
	"surenb@google.com" <surenb@google.com>,
	"Accardi, Kristen C" <kristen.c.accardi@intel.com>,
	"Feghali, Wajdi K" <wajdi.k.feghali@intel.com>,
	"Gopal, Vinodh" <vinodh.gopal@intel.com>
Subject: Re: [PATCH v5 02/12] crypto: acomp - Define new interfaces for
 compress/decompress batching.
Message-ID: <Z7zpZlWmSV15EUVV@google.com>
References: <CAJD7tkbRHkb7Znzto6=RRDQA9zXZSva43GukhBEfjrgm1qOxHw@mail.gmail.com>
 <Z3yMNI_DbkKBKJxO@gondor.apana.org.au>
 <CAJD7tkaTuNWF42+CoCLruPZks3F7H9mS=6S74cmXnyWz-2tuPw@mail.gmail.com>
 <Z7F1B_blIbByYBzz@gondor.apana.org.au>
 <Z7dnPh4tPxLO1UEo@google.com>
 <CAGsJ_4yVFG-C=nJWp8xda3eLZENc4dpU-d4VyFswOitiXe+G_Q@mail.gmail.com>
 <Z7lv6JLax4S8vTtD@gondor.apana.org.au>
 <CAGsJ_4yAQxjTnSALZHAJZDdUnXKAYFvQCcjQjHiQSUip6cJGKg@mail.gmail.com>
 <Z7l0Hf-CFFjeKaZY@gondor.apana.org.au>
 <CAGsJ_4zFdHUPELSYDkrN4ie2c73L6e=FEdQbDL3JckS4unKFpg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGsJ_4zFdHUPELSYDkrN4ie2c73L6e=FEdQbDL3JckS4unKFpg@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Sat, Feb 22, 2025 at 08:13:13PM +1300, Barry Song wrote:
> On Sat, Feb 22, 2025 at 7:52 PM Herbert Xu <herbert@gondor.apana.org.au> wrote:
> >
> > On Sat, Feb 22, 2025 at 07:41:54PM +1300, Barry Song wrote:
> > >
> > > probably no, as an incompressible page might become compressible
> > > after changing an algorithm. This is possible, users may swith an
> > > algorithm to compress an incompressible page in the background.
> >
> > I don't understand the difference.  If something is wrong with
> > the system causing the compression algorithm to fail, shouldn't
> > zswap just hobble along as if the page was incompressible?
> >
> > In fact it would be quite reasonble to try to recompress it if
> > the admin did change the algorithm later because the error may
> > have been specific to the previous algorithm implementation.
> >
> 
> Somehow, I find your comment reasonable. Another point I want
> to mention is the semantic difference. For example, in a system
> with only one algorithm, a dst_buf overflow still means a successful
> swap-out. However, other errors actually indicate an I/O failure.
> In such cases, vmscan.c will log the relevant error in pageout() to
> notify the user.
> 
> Anyway, I'm not an authority on this, so I’d like to see comments
> from Minchan, Sergey, and Yosry.

From a zswap perspective, things are a bit simpler. Currently zswap
handles compression errors and pages compressing to above PAGE_SIZE in
the same way (because zs_pool_malloc() will fail for sizes larger than
PAGE_SIZE). In both cases, zswap_store() will err out, and the page will
either go to the underlying swap disk or reclaim of that page will fail
if writeback is disabled for this cgroup.

Zswap currently does not do anything special about incompressible pages,
it just passes them along to disk. So if the Crypto API can guarantee
that compression nevers writes past PAGE_SIZE, the main benefit for
zswap would be reducing the buffer size from PAGE_SIZE*2 to PAGE_SIZE.

If/when zswap develops handling of incompressible memory (to avoid LRU
inversion), I imagine we would handle compression errors and
incompressible pages similarly. In both cases we'd store the page as-is
and move th LRU along to write more pages to disk. There is no point to
fail the reclaim operation in this case, because unlike zram we do have
a choice :)


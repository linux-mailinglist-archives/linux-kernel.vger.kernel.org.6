Return-Path: <linux-kernel+bounces-364726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4E5D99D871
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 22:40:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0230A1C22195
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 20:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2B381CFED2;
	Mon, 14 Oct 2024 20:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HFuElu+S"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BBBA142E77
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 20:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728938405; cv=none; b=q/WXK9t4xdue0e5oWLBxmYNSvK/qSpSoYLqDF9/Y9GOs9L1kwUWCCNKUzxqSfujuy3/sKST1CH9+DTobhdtEIKdlwlqg9pALTHo1B9lIbBg2FDu1yshyz3uE1HkVA/4A8R0DhCTQoRGYzZM8pXRFFxPV7Bb11eDLnjVw1q4OmLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728938405; c=relaxed/simple;
	bh=jdA4urDUlX9oa+27zIWMzrgqKWEUDdFIx4Fo/O7KlvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wc/uN2nM5goUTp31uE8uTnc6GbLR1qI/R/7P7JdOhv9YN3LR688c0O4pD56EoaitcuRlG+tzZkVbgXrUweRmh4qEipEI6CjGGLaSACWmvVAFEVyBEG8h9iLj7ukiFY1vqFpQElzDXJm99PwF0ziKLVsqs1B3tZvjq23gCGxvjnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HFuElu+S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A439C4CEC3;
	Mon, 14 Oct 2024 20:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728938404;
	bh=jdA4urDUlX9oa+27zIWMzrgqKWEUDdFIx4Fo/O7KlvM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HFuElu+SVtzqwDgmjeU1JWKQYmuKgX4GnzMG0gCTsAibTA3nYyf2G9LcNiOVxosrV
	 pxYYnhvaSOmS5iC83oVC3Te+yxCqwp6RrVWNGH88FsSyK+nCD7k4OF3SbAQ3IC2Yze
	 AeZNsPo9OHZB0sDGcV6DAIztS5qc7HKTzR2qvGIYsGCcgeY+eELAaTol7cQew3gZsJ
	 F5yLuyd8UHb6k6j0nUBVioY9Jbgdg+m4oQJn/4uCz4tLThrIIygVFRqqt1ZrkLNReU
	 N7JDUaPXmrIPGpp1S/zpIXddTHOPchTtSSQ9cmi8E6pdqCGsVVa+s/X5JeNV/55QGf
	 1osOivDFVCT7g==
Date: Mon, 14 Oct 2024 13:40:01 -0700
From: Kees Cook <kees@kernel.org>
To: Feng Tang <feng.tang@intel.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, Marco Elver <elver@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	David Gow <davidgow@google.com>, Danilo Krummrich <dakr@kernel.org>,
	Alexander Potapenko <glider@google.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH v2 0/5] mm/slub: Improve data handling of krealloc() when
 orig_size is enabled
Message-ID: <202410141338.EA1D30F3@keescook>
References: <20240911064535.557650-1-feng.tang@intel.com>
 <d3dd32ba-2866-40ce-ad2b-a147dcd2bf86@suse.cz>
 <CANpmjNM5XjwwSc8WrDE9=FGmSScftYrbsvC+db+82GaMPiQqvQ@mail.gmail.com>
 <49ef066d-d001-411e-8db7-f064bdc2104c@suse.cz>
 <2382d6e1-7719-4bf9-8a4a-1e2c32ee7c9f@suse.cz>
 <ZwzNtGALCG9jUNUD@feng-clx.sh.intel.com>
 <a34e6796-e550-465c-92dc-ee659716b918@suse.cz>
 <Zw0UKtx5d2hnHvDV@feng-clx.sh.intel.com>
 <0e8d49d2-e89b-44df-9dff-29e8f24de105@suse.cz>
 <Zw0otGNgqPUeTdWJ@feng-clx.sh.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zw0otGNgqPUeTdWJ@feng-clx.sh.intel.com>

On Mon, Oct 14, 2024 at 10:20:36PM +0800, Feng Tang wrote:
> On Mon, Oct 14, 2024 at 03:12:09PM +0200, Vlastimil Babka wrote:
> > On 10/14/24 14:52, Feng Tang wrote:
> > > On Mon, Oct 14, 2024 at 10:53:32AM +0200, Vlastimil Babka wrote:
> > >> On 10/14/24 09:52, Feng Tang wrote:
> > > OK, originally I tried not to expose internals of __ksize(). Let me
> > > try this way.
> > 
> > ksize() makes assumptions that a user outside of slab itself is calling it.
> > 
> > But we (well mostly Kees) also introduced kmalloc_size_roundup() to avoid
> > querying ksize() for the purposes of writing beyond the original
> > kmalloc(size) up to the bucket size. So maybe we can also investigate if the
> > skip_orig_size_check() mechanism can be removed now?
> 
> I did a quick grep, and fortunately it seems that the ksize() user are
> much less than before. We used to see some trouble in network code, which
> is now very clean without the need to skip orig_size check. Will check
> other call site later.

Right -- only things that are performing a reallocation should be using
ksize(). e.g. see __slab_build_skb()

-- 
Kees Cook


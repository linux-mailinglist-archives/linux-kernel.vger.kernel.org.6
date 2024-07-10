Return-Path: <linux-kernel+bounces-247796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B058E92D4A4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 17:02:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7B531C211F5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 15:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC28193475;
	Wed, 10 Jul 2024 15:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nkjc4JAM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB624404;
	Wed, 10 Jul 2024 15:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720623717; cv=none; b=DSCWjRfrgx/fcce9R8zBUYbuMbRrp9uD3d4tRqlCe/dOwT/2A7P+3nuCm/M/yun2/RF5oOU00MaRIbZ8bCLc5fuEtq1UpAMQaTmlPdDoxPiIOQWwzTsYCPwgO6E+ARZO6vaICD71stzgDR94utV04SZw8UtXkPiREZEdYpQ4Zf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720623717; c=relaxed/simple;
	bh=9GpPEqrxGU8rpTktXRrEpW0O4vhd27+dwvUB6phuEy4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F2hraoHcsmq+CY4Q+hA9LKSu6bxTeCO6onbGsMKb0Co4tUsMGDmjkqrMNTp/u+2CVbfeuu8niukeay1W4ydZjV4ReQZ4YWZ7Xc3xxOGoiFwxGH6D/I6fSIii0er4prh5Wi2AbbwBT+n3iwzRZjJhSLhwaKJHtEvIuMfGxHf0Ijc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nkjc4JAM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A002CC32781;
	Wed, 10 Jul 2024 15:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720623717;
	bh=9GpPEqrxGU8rpTktXRrEpW0O4vhd27+dwvUB6phuEy4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nkjc4JAMA17eXOiiHeFs87S3AMp9M+/UjmcPP/IGhNbVqoL+QNTUja2xZSgqr0uF4
	 udATUrC2e25rsvJD8PahWekPC4oFMy7KTwATCCqG/vdHnD3qV55QACdY00Qqimxa3W
	 vpVlAXZhElyxPDjnr0OLufSue09fpVgsnA5MBiMfJSsmt17I5PIWzkp9Vncslc5bBU
	 K6LM2/24AMX9Ry6/EvkkUb9XXm0dxWjpbhkVmYnDD335SBGRZuOp/tdX3HZwhc+CYR
	 8VSPqDudePAd3V0Wd8II1OdeW08maHc6wPceaSIGFUZHDW/nR+5xSXvTsvkDu38qow
	 sat8AmF00dEkA==
Date: Wed, 10 Jul 2024 08:01:54 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: sxwjean@me.com, vbabka@suse.cz, surenb@google.com, cl@linux.co,
	penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
	akpm@linux-foundation.org, roman.gushchin@linux.dev,
	42.hyeyoo@gmail.com, xiongwei.song@linux.dev, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
	llvm@lists.linux.dev, Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH] mm/slub: quiet the clang warning with -Wunused-function
 enabled
Message-ID: <20240710150154.GA1684801@thelio-3990X>
References: <20240710025418.394321-1-sxwjean@me.com>
 <Zo36BTqhzGkukyT_@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zo36BTqhzGkukyT_@casper.infradead.org>

On Wed, Jul 10, 2024 at 04:03:33AM +0100, Matthew Wilcox wrote:
> On Wed, Jul 10, 2024 at 10:54:18AM +0800, sxwjean@me.com wrote:
> > From: Xiongwei Song <xiongwei.song@linux.dev>
> > 
> > The only user of prepare_slab_obj_exts_hook() is
> > alloc_tagging_slab_alloc_hook(), which can build with
> > CONFIG_MEM_ALLOC_PROFILING enabled. So, the warning was triggerred
> > when disabling CONFIG_MEM_ALLOC_PROFILING. Let's add "__maybe_unused"
> > for prepare_slab_obj_exts_hook().
> 
> Perhaps instead clang can be fixed to match gcc's behaviour?

Clang only differs from GCC on warning for unused static inline functions in .c
files, not .h files. The kernel already handles this in
include/linux/compiler_types.h but it disables this workaround for W=1 to catch
unused functions like this as a result of commit 6863f5643dd7 ("kbuild: allow
Clang to find unused static inline functions for W=1 build"):

/*
 * GCC does not warn about unused static inline functions for -Wunused-function.
 * Suppress the warning in clang as well by using __maybe_unused, but enable it
 * for W=1 build. This will allow clang to find unused functions. Remove the
 * __inline_maybe_unused entirely after fixing most of -Wunused-function warnings.
 */
#ifdef KBUILD_EXTRA_WARN1
#define __inline_maybe_unused
#else
#define __inline_maybe_unused __maybe_unused
#endif

So I don't really think there is much for clang to do here and I think having
the ability to find unused static inline functions in .c files is useful (you
might disagree, perhaps a revert could still be discussed). I guess
IS_ENABLED() can't be used there, so it seems like either taking this patch,
ignoring the warning, or refactoring the code in some other way are the only
options I see.

> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202407050845.zNONqauD-lkp@intel.com/
> > Signed-off-by: Xiongwei Song <xiongwei.song@linux.dev>
> > ---
> >  mm/slub.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/mm/slub.c b/mm/slub.c
> > index ce39544acf7c..2e26f20759c0 100644
> > --- a/mm/slub.c
> > +++ b/mm/slub.c
> > @@ -2027,7 +2027,7 @@ static inline bool need_slab_obj_ext(void)
> >  	return false;
> >  }
> >  
> > -static inline struct slabobj_ext *
> > +static inline struct slabobj_ext * __maybe_unused
> >  prepare_slab_obj_exts_hook(struct kmem_cache *s, gfp_t flags, void *p)
> >  {
> >  	struct slab *slab;
> > @@ -2068,7 +2068,7 @@ static inline bool need_slab_obj_ext(void)
> >  	return false;
> >  }
> >  
> > -static inline struct slabobj_ext *
> > +static inline struct slabobj_ext * __maybe_unused
> >  prepare_slab_obj_exts_hook(struct kmem_cache *s, gfp_t flags, void *p)
> >  {
> >  	return NULL;
> > -- 
> > 2.34.1
> > 
> > 


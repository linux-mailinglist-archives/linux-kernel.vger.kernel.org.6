Return-Path: <linux-kernel+bounces-229499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D8DA8917028
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 20:28:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DE2F1F226BB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 18:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80B2917B438;
	Tue, 25 Jun 2024 18:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oTtgaTsJ"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E6917837A
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 18:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719340083; cv=none; b=d/17q+M/UdeuTL54hZDb5Sj+lBU8bhNNL5ddysxaAb8iMJthQGm/atlA/EQWdxTI5XGrgYcoIqmmVj6huTLFTOYm/EMoOy5W+aYUZX40wJZSBFmv+B5z/69Ed2KN0kzAHQbzclX1AhEWeMnB8IfuxvDzb+qLk00E0gYNSqXWVrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719340083; c=relaxed/simple;
	bh=A+/Ky2PN9IRsbjU8WUJktiVC5R8r38dialqHvwCVtYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rOHW+D3Hz8rBB2MuRoQ7vU4/oqdyZ6PRfdE6tnL/LOVHiiUKuLBzsg9pZU3Y1MN/ivXbvQj6l4chS3qi9hMErBMyLr3Ow2fQs+0TrQgIS3mq389O3XcPcdA3oxfTIkdq+cKauqCzyRexNQXxPDqWFm2IpZJZ+QhtTSFK2qX0IoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=oTtgaTsJ; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-70666aceb5bso2811350b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 11:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1719340082; x=1719944882; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1vIU7FbHMAgqLqLMnCvHjiT4tfZr4IV9QAKsdnjusbk=;
        b=oTtgaTsJTRUqVqBBYS+BSVjSvJBj6mYNO2sOr47rlHNuBc4vt9/D5lI/KGHvZrBsDH
         k0wMZCzLRtpOM7Y+vrwUb3gke715jO8fB6affNKlUoDtFVAW0fqZVt8oy/8zgXSNXLZs
         g+kTibI9sKDAkc+QHaSuPIQjAPRkIMLRZv60M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719340082; x=1719944882;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1vIU7FbHMAgqLqLMnCvHjiT4tfZr4IV9QAKsdnjusbk=;
        b=pMcIKRFkur+lSu0CwgJ+ZnXTGTL+pCnmU7IcnzuPoD8UJamJGGfRmJlsF3nLwzHJ7Q
         Fh4NeTLxOcBQNLYnIYRhtjW52SQi0H1RGmxFw/Iu7cQoD2QiTPGy1QLu0SihHhnBEXK9
         FrfgmtSdTfS8lzR7mpa/qaTMjBN8L4jon90jx1ybBfjfMcITG1Ml0swvuPbxQxyETg4j
         RKQ4PqMDYWwX1wk9wmPtpc0HJ0h4BKr9C4YNcslLwaL1YFfZJvgSkNKvgmM/gUkZ7w2q
         s9+cmboB4oFsOEovFZbUBODCvMy+XlRi/r4MWHe5mbWSkMiQG/glpQCXEt+7QJR8iS13
         soeA==
X-Forwarded-Encrypted: i=1; AJvYcCWcJToCpC6kLhSnW8vAeDTQOEzFV3xTcXGe4XQNMU7A+b3xkkmIMZcu6mWrwoAVfRiV80oIPwMhz1wo1VWdGqQhdmwzWE9Km5VaP/kn
X-Gm-Message-State: AOJu0YwDVNGotzilwecPf8b6FOeEkhRPvGXx5ljvztZENNPMfZM7hR7g
	+xIPQOR8qhNuXzEy0A6OrFkt9fhWaShFJ/6qLsHwjOg9yrHw0I3ArAigwFT4dzBPS+1iSiz3Kj0
	=
X-Google-Smtp-Source: AGHT+IEXU1A5mwPtAo/Q+OSf1rs0m//a4+MO0yyqLqDWDlRWJxcLz/D0LOTpOHslhiGSNzIzpioYzA==
X-Received: by 2002:a05:6a21:6d9a:b0:1b6:1a81:5dad with SMTP id adf61e73a8af0-1bcf7e7f88amr10256587637.14.1719340081619;
        Tue, 25 Jun 2024 11:28:01 -0700 (PDT)
Received: from localhost ([2620:15c:9d:2:64b9:a46b:e2d1:27d7])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7066c7fb9casm6466474b3a.94.2024.06.25.11.28.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jun 2024 11:28:01 -0700 (PDT)
Date: Tue, 25 Jun 2024 11:27:59 -0700
From: Brian Norris <briannorris@chromium.org>
To: Yury Norov <yury.norov@gmail.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>, llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org, Justin Stitt <justinstitt@google.com>,
	Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH] cpumask: Switch from inline to __always_inline
Message-ID: <ZnsML1RYMmEhhdPP@google.com>
References: <20240514204910.1383909-1-briannorris@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240514204910.1383909-1-briannorris@chromium.org>

Hi Yuri, Rasmus,

On Tue, May 14, 2024 at 01:49:01PM -0700, Brian Norris wrote:
> On recent (v6.6+) builds with Clang (based on Clang 18.0.0) and certain
> configurations [0], I'm finding that (lack of) inlining decisions may
> lead to section mismatch warnings like the following:
> 
>   WARNING: modpost: vmlinux.o: section mismatch in reference:
>   cpumask_andnot (section: .text) ->
>   cpuhp_bringup_cpus_parallel.tmp_mask (section: .init.data) ERROR:
>   modpost: Section mismatches detected.
> 
> or more confusingly:
> 
>   WARNING: modpost: vmlinux: section mismatch in reference:
>   cpumask_andnot+0x5f (section: .text) -> efi_systab_phys (section:
>   .init.data)
> 
> The first warning makes a little sense, because
> cpuhp_bringup_cpus_parallel() (an __init function) calls
> cpumask_andnot() on tmp_mask (an __initdata symbol). If the compiler
> doesn't inline cpumask_andnot(), this may appear like a mismatch.
> 
> The second warning makes less sense, but might be because efi_systab_phys
> and cpuhp_bringup_cpus_parallel.tmp_mask are laid out near each other,
> and the latter isn't a proper C symbol definition.
> 
> In any case, it seems a reasonable solution to suggest more strongly to
> the compiler that these cpumask macros *must* be inlined, as 'inline' is
> just a recommendation.
> 
> This change (plus more) has been previously proposed for other reasons
> -- that some of the bitmask 'const' machinery doesn't work without
> inlining -- in the past as:
> 
>   Subject: [PATCH 1/3] bitmap: switch from inline to __always_inline
>   https://lore.kernel.org/all/20221027043810.350460-2-yury.norov@gmail.com/
> 
> It seems like a good idea to at least make all cpumask functions use
> __always_inline; several already do.
> 
> According to bloat-o-meter, my ~29MB vmlinux increases by a total of 61
> bytes (0.00%) with this change.
> 
> [0] CONFIG_HOTPLUG_PARALLEL=y ('select'ed for x86 as of [1]) and
>     CONFIG_GCOV_PROFILE_ALL.
> 
> [1] commit 0c7ffa32dbd6 ("x86/smpboot/64: Implement
>     arch_cpuhp_init_parallel_bringup() and enable it")
> 
> Cc: Yury Norov <yury.norov@gmail.com>
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---
> 
>  include/linux/cpumask.h | 214 +++++++++++++++++++++-------------------
>  1 file changed, 113 insertions(+), 101 deletions(-)

Any thoughts here? scripts/get_maintainer.pl suggests you are
maintainer/reviewer here.

Regards,
Brian


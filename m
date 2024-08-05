Return-Path: <linux-kernel+bounces-275066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFAA894803F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 19:26:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A217283BE2
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 17:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 650D115E5D6;
	Mon,  5 Aug 2024 17:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WMS7ER2M"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB61C155749
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 17:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722878797; cv=none; b=T5qCWZWDGHDOh45pZATzJHXmLApaew3Uld5sxS53+DUO6eJ3w42xZrDQrM08L8YGUbMBFrDX7bJvIpVtwaB107mWKgHG6X4k5ETEVv65jWY+NY2XNivM0jklicuQMyvDNpw2yP60EwOnLPnOPm4ZwjocuKPleGsgiPBYtrc01c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722878797; c=relaxed/simple;
	bh=O2CB6rBEhu4NPb7P1V0duKORxnAkoxB5yHW2RdhWdm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EnmqV3qvXx+G6tRFHwauW3k8Oa8sRAH/edxALM2LM2aSykM0AwdeAPy5LkTM4oy4bZRvK4YVGSVllBv2gLMzJLs/VCOq5J/1BX3bssZecLcTbmqirAWuSdFL4wityUmJPcsuDna0OLQ3vw3l04myzsxis3fg9rnoUkuuokPZF2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WMS7ER2M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ED30C32782;
	Mon,  5 Aug 2024 17:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722878797;
	bh=O2CB6rBEhu4NPb7P1V0duKORxnAkoxB5yHW2RdhWdm4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WMS7ER2M6Z2koFW9a18Ae/3nWSPJneSjgvK/5/Ydnxgf9okBs5Cee9IFS/sYos2pE
	 wPtyRTdw0a5EuK7BLvm0OrUs+2UKcF9KSoMyn9yQ6IaLgsbAvsaXqd3aYuZgoznuOU
	 YBB5NWDe65BlODpBqPhumGLYymm00SjBj5+FwASxRzHPcbDe8fUi0e0j5PrMqDnWp4
	 V5tCXMm/qTvdAwYw1ayNhtp3kxCOdusphzr5/J8ZIWpdojUVxMOVpJs4DpuLDL0+oq
	 0ue4qtnXFqTmj5n6sS9i7aeB1i7dCui7I7sAucsR/YsC5+CEPeFQrCmN/1qobD5Yhx
	 mh3Mo0CH+WdTw==
Date: Mon, 5 Aug 2024 10:26:36 -0700
From: Kees Cook <kees@kernel.org>
To: David Gow <davidgow@google.com>
Cc: Alexandre Ghiti <alex@ghiti.fr>, Luis Chamberlain <mcgrof@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Mark Rutland <mark.rutland@arm.com>, linux-mm@kvack.org,
	linux-arm-kernel@lists.infradead.org, kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: Only enforce minimum stack gap size if it's sensible
Message-ID: <202408051025.33CA44DEE6@keescook>
References: <20240803074642.1849623-2-davidgow@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240803074642.1849623-2-davidgow@google.com>

On Sat, Aug 03, 2024 at 03:46:41PM +0800, David Gow wrote:
> The generic mmap_base code tries to leave a gap between the top
> of the stack and the mmap base address, but enforces a minimum
> gap size (MIN_GAP) of 128MB, which is too large on some setups. In
> particular, on arm tasks without ADDR_LIMIT_32BIT, the STACK_TOP
> value is less than 128MB, so it's impossible to fit such a gap in.
> 
> Only enforce this minimum if MIN_GAP < MAX_GAP, as we'd prefer to honour
> MAX_GAP, which is defined proportionally, so scales better and always
> leaves us with both _some_ stack space and some room for mmap.
> 
> This fixes the usercopy KUnit test suite on 32-bit arm, as it doesn't
> set any personality flags so gets the default (in this case 26-bit)
> task size. This test can be run with:
> ./tools/testing/kunit/kunit.py run --arch arm usercopy --make_options LLVM=1
> 
> Fixes: dba79c3df4a2 ("arm: use generic mmap top-down layout and brk randomization")
> Signed-off-by: David Gow <davidgow@google.com>
> ---
> 
> This is one possible fix for an issue with the usercopy_kunit suite
> (and, indeed, the KUnit user_alloc features) on 32-bit arm. The other
> options are to:
> - hack the KUnit allocation to force ADDR_LIMIT_32BIT or
>   ADDR_COMPAT_LAYOUT; or
> - similarly, use an unlimited stack, which forces the legacy layout
>   behind the scenes; or
> - adjust MIN_GAP based on either STACK_TOP or architecture.
> 
> Of them, I made the arbitrary call that this was least hacky, but am
> happy to go with something else if someone who actually knows what's
> going on suggests it.
> 
> (Also, does this issue actually mean some strange legacy binaries have
> been broken with an rlimit-ed stack for ages? Or am I missing something?)
> 
> Cheers,
> -- David

I see akpm already snagged this, but yeah, this looks like a totally
sane fix. Thanks for digging in and finding the problem!

Reviewed-by: Kees Cook <kees@kernel.org>

-Kees

> 
> ---
>  mm/util.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/util.c b/mm/util.c
> index bd283e2132e0..baca6cafc9f1 100644
> --- a/mm/util.c
> +++ b/mm/util.c
> @@ -463,7 +463,7 @@ static unsigned long mmap_base(unsigned long rnd, struct rlimit *rlim_stack)
>  	if (gap + pad > gap)
>  		gap += pad;
>  
> -	if (gap < MIN_GAP)
> +	if (gap < MIN_GAP && MIN_GAP < MAX_GAP)
>  		gap = MIN_GAP;
>  	else if (gap > MAX_GAP)
>  		gap = MAX_GAP;
> -- 
> 2.46.0.rc2.264.g509ed76dc8-goog
> 

-- 
Kees Cook


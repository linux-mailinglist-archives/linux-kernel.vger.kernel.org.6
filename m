Return-Path: <linux-kernel+bounces-201016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E1D8FB82E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 17:56:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 460501C20994
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 15:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F307143C7B;
	Tue,  4 Jun 2024 15:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KnSJePGC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D018D12B17A
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 15:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717516542; cv=none; b=u8P1IZSc7e24AnVvOL2WxbsxOWnQCkBzZSDwPpNWHxfj8BdL1ZHsG3Rhj8M1iKgyBccNcYxveAmXUDT/CSQJ0lpkn2KZrubWQ6m2JzAS0YCg44nAUG/ioC/Q5LP2wSJ8nTUtJs6mHd1sn4fgz8qIv31EMqOXO7e7dMu1cIUeQoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717516542; c=relaxed/simple;
	bh=d9xupwVDLSm6tV2FshRNHXaiUYZUrqvz6XXtUmlyJn4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oF1oaNQkr07DXaKC17aaL9qLgcWOLFdNggwmlPFMLGtJao3ZhUCYDcUZ4zqIw6KwKbmpFY+tSslcFPNAL8yDl+mvOXmkPsUC2VPxq6HEgqf/s7oD1R6OMz+C3SZtpksGC7DjJCE1FegJbd8lxCFKbT4F+IbG6jLbPWJh6ZohjnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KnSJePGC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D6DEC2BBFC;
	Tue,  4 Jun 2024 15:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717516542;
	bh=d9xupwVDLSm6tV2FshRNHXaiUYZUrqvz6XXtUmlyJn4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KnSJePGCdkPtmadAOeftoHNsZRFheJvrrtSuAFR6wZ9VvWbK9e9E6fv42x8BEE8f6
	 xSwG2F5Lvla5s+EWlagUjwMJJlsungUVG50fA3+Kp8odzf3mRKvhtGj+2rglELWRfD
	 BeOwuKPlEwiEfZ1EhBuTSQ34QEVvUIuzPTC+AODN5n1Io8Chh7Q+IbD0z+pREb2nvJ
	 mz33KDJSBESl6nppAUQTQWk7kfIgif7X98FMWcswcjwmjs5FuWOHM3paBzk6We7Bb9
	 nJqzyGy8sSkv4Ik6cumR7uVV1RS9zTPg/t8B1J+7JHnHZ5h9ne8JW4CigUslM0D3Sd
	 vDff2HgZ/j8rg==
Date: Tue, 4 Jun 2024 16:55:37 +0100
From: Will Deacon <will@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
	Baoquan He <bhe@redhat.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v2] arm64/io: add constant-argument check
Message-ID: <20240604155536.GA20674@willie-the-truck>
References: <20240528153717.2439910-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528153717.2439910-1-arnd@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Tue, May 28, 2024 at 05:37:11PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> In some configurations __const_iowrite32_copy() does not get inlined
> and gcc runs into the BUILD_BUG():
> 
> In file included from <command-line>:
> In function '__const_memcpy_toio_aligned32',
>     inlined from '__const_iowrite32_copy' at arch/arm64/include/asm/io.h:203:3,
>     inlined from '__const_iowrite32_copy' at arch/arm64/include/asm/io.h:199:20:
> include/linux/compiler_types.h:487:45: error: call to '__compiletime_assert_538' declared with attribute error: BUILD_BUG failed
>   487 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>       |                                             ^
> include/linux/compiler_types.h:468:25: note: in definition of macro '__compiletime_assert'
>   468 |                         prefix ## suffix();                             \
>       |                         ^~~~~~
> include/linux/compiler_types.h:487:9: note: in expansion of macro '_compiletime_assert'
>   487 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>       |         ^~~~~~~~~~~~~~~~~~~
> include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
>    39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
>       |                                     ^~~~~~~~~~~~~~~~~~
> include/linux/build_bug.h:59:21: note: in expansion of macro 'BUILD_BUG_ON_MSG'
>    59 | #define BUILD_BUG() BUILD_BUG_ON_MSG(1, "BUILD_BUG failed")
>       |                     ^~~~~~~~~~~~~~~~
> arch/arm64/include/asm/io.h:193:17: note: in expansion of macro 'BUILD_BUG'
>   193 |                 BUILD_BUG();
>       |                 ^~~~~~~~~
> 
> Move the check for constant arguments into the inline function to ensure
> it is still constant if the compiler decides against inlining it.
> 
> Fixes: ead79118dae6 ("arm64/io: Provide a WC friendly __iowriteXX_copy()")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> v2:
>  - fix both 32-bit and 64-bit copies
>  - remove now-redundant macros
> ---
>  arch/arm64/include/asm/io.h | 24 +++++++++---------------
>  1 file changed, 9 insertions(+), 15 deletions(-)

I think this is superseded by Mark's diff in reply to v1, right?

https://lore.kernel.org/r/ZlcODqVXTDh6n0h-@J2N7QTR9R3

If so, Mark, please can you post that as a proper patch so that we can
get this fixed?

Cheers,

Will


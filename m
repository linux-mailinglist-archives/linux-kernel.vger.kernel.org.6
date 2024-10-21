Return-Path: <linux-kernel+bounces-374843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B7B9A70EF
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 19:21:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E77A91F2287E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 17:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FBC41EBA1E;
	Mon, 21 Oct 2024 17:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SVanfBgo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768EC1C460D;
	Mon, 21 Oct 2024 17:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729531265; cv=none; b=S9aerAj0BT2u9QCVOWyf5JGcy8//rmXvs2fMxVY0fJ1QcRB+fcQBHz9PkAicf18/8ymWlLb1161d/qa6r15+5lEsktw0lOs1iyyf0ecDuZgrJo7CYhb4sFf5RW1ETFCWwRmS6kcKhhgV4s2hs/wrOcseQF9gIH3KPsLtAdQtLZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729531265; c=relaxed/simple;
	bh=kMXeZIpXM7sC3/QEQMq1e9Or1+dWxzqxwpK3CW3xgDU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g7CHSfySRXWospyDIXyVLTrPHw1C6yP3oOgedRPKRz4L9xfOo6Pay1vSxs7r2KznPJ+OfC4vhDNzDOj1v2T1YOVQ4eKVN0bS9BZ3vOGjvTRH5vTrgOteshZY7q6Gt1NvLoTsAAfA/XSeTMoEUaEkcJeTO9anFkFxkHx1Jz4hCPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SVanfBgo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D808BC4CEC3;
	Mon, 21 Oct 2024 17:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729531265;
	bh=kMXeZIpXM7sC3/QEQMq1e9Or1+dWxzqxwpK3CW3xgDU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SVanfBgojh0ugSqZopDI64x+T7G4e2E8JGbO5z0e09S9aT27WVB55y43rVs91bmBI
	 /PtHH8urHdWhG2NrAwCLXJwjZyewN60PwgphKU71VealCFYzhk10WEWvFr8Q7xd1Vt
	 7PkyMATYxIxFOXpgoVkXU1bVemp9UVy9qxdfi8zwgP78f6+VpXkS6QjXk+PUWJ+De/
	 CqNfSZhQv3US3xkps11q7Uxr3wesdj2UV6t8W1XL8h49+adlA0tFPzm+V5YhXZEkMB
	 t9Cy6RkTt3na2jYi2ADMwCO2ymRk4BFEilU9AvjgN49UJIGUrUdmqZjrRIjPXBsYId
	 SLU5NcJgyGBCA==
Date: Mon, 21 Oct 2024 18:20:59 +0100
From: Will Deacon <will@kernel.org>
To: Marco Elver <elver@google.com>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org,
	kasan-dev@googlegroups.com, llvm@lists.linux.dev,
	syzbot+908886656a02769af987@syzkaller.appspotmail.com,
	Andrew Pinski <pinskia@gmail.com>
Subject: Re: [PATCH 1/2] kasan: Fix Software Tag-Based KASAN with GCC
Message-ID: <20241021172058.GB26179@willie-the-truck>
References: <20241021120013.3209481-1-elver@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021120013.3209481-1-elver@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Mon, Oct 21, 2024 at 02:00:10PM +0200, Marco Elver wrote:
> Per [1], -fsanitize=kernel-hwaddress with GCC currently does not disable
> instrumentation in functions with __attribute__((no_sanitize_address)).
> 
> However, __attribute__((no_sanitize("hwaddress"))) does correctly
> disable instrumentation. Use it instead.
> 
> Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=117196 [1]
> Link: https://lore.kernel.org/r/000000000000f362e80620e27859@google.com
> Link: https://lore.kernel.org/r/ZvFGwKfoC4yVjN_X@J2N7QTR9R3
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=218854
> Reported-by: syzbot+908886656a02769af987@syzkaller.appspotmail.com
> Tested-by: Andrey Konovalov <andreyknvl@gmail.com>
> Cc: Andrew Pinski <pinskia@gmail.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Signed-off-by: Marco Elver <elver@google.com>
> ---
>  include/linux/compiler-gcc.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
> index f805adaa316e..cd6f9aae311f 100644
> --- a/include/linux/compiler-gcc.h
> +++ b/include/linux/compiler-gcc.h
> @@ -80,7 +80,11 @@
>  #define __noscs __attribute__((__no_sanitize__("shadow-call-stack")))
>  #endif
>  
> +#ifdef __SANITIZE_HWADDRESS__
> +#define __no_sanitize_address __attribute__((__no_sanitize__("hwaddress")))
> +#else
>  #define __no_sanitize_address __attribute__((__no_sanitize_address__))
> +#endif

Does this work correctly for all versions of GCC that support
-fsanitize=kernel-hwaddress?

Will


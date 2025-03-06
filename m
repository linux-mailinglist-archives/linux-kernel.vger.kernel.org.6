Return-Path: <linux-kernel+bounces-549389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59CFFA551F0
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 17:56:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C960167796
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 16:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2D1E25C6E6;
	Thu,  6 Mar 2025 16:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="lqBlCPtW"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B18D2144BC
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 16:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741280182; cv=none; b=BZBUPyGA2KpnHU+baXncEijUDBQ7IjDxeY0Vo8c2geae6AQ9XA+sk4D2h+JtUKe7GYg0PC2GEnMqadBaTOwPLyAQOIF8ZvxGPdH4Pxg5vDYmlUnnNoi4Dho9G3eURqX7P/hvTZIF270ROIoiIPKMFv1eK5YAIHbfYuDwmMlTuCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741280182; c=relaxed/simple;
	bh=xBrd/QwtU/9Zub72/Q44gMSmsrzf4ZQwItEZp7u7jrM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b9C09b1wO93ohdQ//TEA9qH6Y/kGVxJTIR1vHt3uzK60ozhiQanOCY9vQhYTpXTYKlsde64n+GsXpmKtxCUy3RWHwh9svJ7XUzuKKiuR2xRMHffuYIhzNcyXc+969Fx6lmQs8DXjtfBfc5z8IR6N8h8CKoxgQ+5x5bOukE79wfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=lqBlCPtW; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1741280172;
	bh=xBrd/QwtU/9Zub72/Q44gMSmsrzf4ZQwItEZp7u7jrM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lqBlCPtWsL2/OF2DkmFYoukSvnUJXba2+z6KSLmFnN9KWVAzH8M6lkzRfQWj6nQBq
	 z08QBDZS/vl1mU2AQFMhMUs6JGziZbmo9rtLkEr9lVWgssnMsztWtFlMCzMeE04emD
	 5zbGLa7MJIrr006xmh+f+SirJ6ih079slgLQBoiA=
Date: Thu, 6 Mar 2025 17:56:12 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Louis Taylor <louis@kragniz.eu>
Cc: Willy Tarreau <w@1wt.eu>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/5] tools/nolibc: always use openat(2) instead of
 open(2)
Message-ID: <ac0e325b-4882-4c23-8507-cef3b86d3469@t-8ch.de>
References: <20250304075846.66563-1-louis@kragniz.eu>
 <20250304075846.66563-2-louis@kragniz.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250304075846.66563-2-louis@kragniz.eu>

On 2025-03-04 07:58:16+0000, Louis Taylor wrote:
> All architectures support openat, so we don't need to make its use
> conditional.
> 
> Signed-off-by: Louis Taylor <louis@kragniz.eu>
> ---
>  tools/include/nolibc/sys.h | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
> index 3cd938f9abda..a8dca5ac6542 100644
> --- a/tools/include/nolibc/sys.h
> +++ b/tools/include/nolibc/sys.h
> @@ -798,13 +798,7 @@ int openat(int dirfd, const char *path, int flags, ...)
>  static __attribute__((unused))
>  int sys_open(const char *path, int flags, mode_t mode)
>  {
> -#ifdef __NR_openat
>  	return my_syscall4(__NR_openat, AT_FDCWD, path, flags, mode);
> -#elif defined(__NR_open)
> -	return my_syscall3(__NR_open, path, flags, mode);
> -#else
> -	return __nolibc_enosys(__func__, path, flags, mode);
> -#endif

Linus at some point was unhappy with usage of the *at() system calls
over the regular ones for perfomance reasons.
But that probably doesn't matter for nolibc and we are preferring
openat() anyways.

So:

Acked-by: Thomas Weißschuh <linux@weissschuh.net>

>  }
>  
>  static __attribute__((unused))
> -- 
> 2.45.2
> 


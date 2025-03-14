Return-Path: <linux-kernel+bounces-562034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F89DA61AD1
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 20:39:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 457D64200A9
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 19:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB0F61FF1AF;
	Fri, 14 Mar 2025 19:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IhukAQGd"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65374190678
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 19:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741981134; cv=none; b=BiyH6mXntCUms7hS8tyoqHaO+YJni6Q6wemMnQf0kXQ/ddSLUFOSLWbtpFjoOZfcT8WTLnG+URley1raWXG7g6qSBvsHJiVsIhz1eOqKYyASt2ZB7i/ADslCd8W+g/1V84R3j0RPXsby6vTljaeWv89xnwDhMI3XOLj+fgxv/m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741981134; c=relaxed/simple;
	bh=ExFXyaqrz41vrDcaD+bz6tA5Abqg2qEiBgaNOeRWvqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SBJL7PzxBP0SbieoVGI8Mw0u6a046UjzDL3F0umUrQIzKUXimRUjLvZts9VgRDpBuLGzWXtRmCVu7OYliYrNaSKX+DeKGSkzry/7gYyJjshEm4gPxiXtMinCdCCitvkf42TgrkPg8CbdyruciZpHPmRD/3iNTc3lGBd4OUTKRmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=IhukAQGd; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=egNB+R+BV2t876Q/5MMm+o7bPUDS9T+6cymtdQUameY=; b=IhukAQGdS9meL53sN39G7N9qaC
	5IRKj6LS0R4dkP4EQZvl7QhH4MAy1PKUJk77SI5uvkuSM7SSZVIS42DTnwp0rEd/6iGfvygbjiDTC
	UGq7CpMKj7GQfsNSotFoq8bZoE2+jEVBjEEJlMg8d9qZxWe6r3rlDnylvwgSRsaotK6xuL2/6EXJu
	H6OSZDfn6IhIbrS9b/+qWTSEQzPwdOVsnTfUeV0SRbvIH1rkWpYEufzamwRgZ1t9O36t2yoIovIml
	S/7od6fZZ3OkkxMAvkw1cwXJZ/9w/QjFe+vs/TOJfx4QFny7PqoXXNvhYV3NHaCOIYsaq8gfH8eln
	BAd+0VgQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1ttArq-00000002wS0-0Mxy;
	Fri, 14 Mar 2025 19:38:50 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 874A4300599; Fri, 14 Mar 2025 20:38:48 +0100 (CET)
Date: Fri, 14 Mar 2025 20:38:48 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	Brendan Jackman <jackmanb@google.com>,
	Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH 06/13] objtool: Remove --unret dependency on --rethunk
Message-ID: <20250314193848.GE36322@noisy.programming.kicks-ass.net>
References: <cover.1741975349.git.jpoimboe@kernel.org>
 <c6f5635784a28ed4b10ac4307b1858e015e6eff0.1741975349.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c6f5635784a28ed4b10ac4307b1858e015e6eff0.1741975349.git.jpoimboe@kernel.org>

On Fri, Mar 14, 2025 at 12:29:04PM -0700, Josh Poimboeuf wrote:
> With unret validation enabled and IBT/LTO disabled, objtool runs on TUs
> with --rethunk and on vmlinux.o with --unret.  So this dependency isn't
> valid as they don't always run on the same object.
> 
> This error never triggered before because --unret is always coupled with
> --noinstr, so the first conditional in opts_valid() returns early due to
> opts.noinstr being true.
> 
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> ---
>  tools/objtool/builtin-check.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/tools/objtool/builtin-check.c b/tools/objtool/builtin-check.c
> index 387d56a7f5fb..c7275cf7641b 100644
> --- a/tools/objtool/builtin-check.c
> +++ b/tools/objtool/builtin-check.c
> @@ -151,11 +151,6 @@ static bool opts_valid(void)
>  		return true;
>  	}
>  
> -	if (opts.unret && !opts.rethunk) {
> -		ERROR("--unret requires --rethunk");
> -		return false;
> -	}

But but but, the whole UNTRAIN_RET stuff relies on return thunks. Even
though objtool can do that VALUDATE_UNRET_BEGIN -> VALIDATE_UNRET_END
check without there being return thunks, it simply doesn't make sense.


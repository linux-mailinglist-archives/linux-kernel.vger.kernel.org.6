Return-Path: <linux-kernel+bounces-522199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38816A3C74C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 19:21:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 176291780C0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 18:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C61AB214814;
	Wed, 19 Feb 2025 18:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jQrRAT46"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F76214802
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 18:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739989300; cv=none; b=PkHVcq5V3C3hZT03NCvBrYOljiq/clC7UbQwIQHvy1H8ETb1F2G8CgHrHmJG+rBqhIGq7cpHiepolZMqxLyRNZt6xgBokllXnSqjfgghmwcKJX/IBrfLYyX6S+dN8Z4HKkKB6GZzn27j6sRHVhfSBJscxxf88eGAepJd62q4jz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739989300; c=relaxed/simple;
	bh=rYLfHGjiVPpGeu/6tXg0uKDaWoEHwBjESCC4elu7OY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E04I6y6o0Daet7GGznEwzvpEcVZPWk30heMktRuG3HVgkFmHQUjyJaCygo68xnnlMp+3dCJiX8ICxxNdPvtOpd+oZCy1mrOesHMmsNcgQw6XH0LxytoFsL3p4FnznlYQUCMzgLNcYyzAn4vtjcE9Q0Vp8F08AAroiDraDMDJZX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jQrRAT46; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E4F1C4CED1;
	Wed, 19 Feb 2025 18:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739989299;
	bh=rYLfHGjiVPpGeu/6tXg0uKDaWoEHwBjESCC4elu7OY4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jQrRAT46xjGirKw1Q3L59CgJQ+ypZnXJ7jssd/GcG/zM3W/XFsfKd62nSROsEka6B
	 mLyb8QYGTfnzY6Mt0/xc8Sr3OvVUS4hOHe9iTg7s9ix67nnUVlq3GFo7/WafBjpqD4
	 wpmlwJ4pq/MAHUb4TvQ4l12/i9+142zjRZQESOSZaVxpaq+jxnQ9Yyk0epjzkTeR+p
	 vKsbaITBg0Tr1UrZdFONbuBsYfZvlWTSJwvb8DaTch7xN0hBsXH8ilngsRLIvCLS9f
	 3AuHgzmGjUyAXKw2p9rLQBFmVWDG7t6Bfht4PV1VJcz4qn2PdH/oKv9lfkbVbEs+Bm
	 2x1xGNGGTbE1g==
Date: Wed, 19 Feb 2025 10:21:36 -0800
From: Kees Cook <kees@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, alyssa.milburn@intel.com,
	scott.d.constable@intel.com, joao@overdrivepizza.com,
	andrew.cooper3@citrix.com, jpoimboe@kernel.org,
	jose.marchesi@oracle.com, hjl.tools@gmail.com,
	ndesaulniers@google.com, samitolvanen@google.com, nathan@kernel.org,
	ojeda@kernel.org, alexei.starovoitov@gmail.com, mhiramat@kernel.org,
	jmill@asu.edu
Subject: Re: [PATCH v3 10/10] x86/ibt: Optimize fineibt-bhi arity 1 case
Message-ID: <202502191021.2BB61F8684@keescook>
References: <20250219162107.880673196@infradead.org>
 <20250219163515.368430004@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219163515.368430004@infradead.org>

On Wed, Feb 19, 2025 at 05:21:17PM +0100, Peter Zijlstra wrote:
> Saves a CALL to an out-of-line thunk for the common case of 1
> argument.
> 
> Suggested-by: Scott Constable <scott.d.constable@intel.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/x86/include/asm/ibt.h    |    4 ++
>  arch/x86/kernel/alternative.c |   61 +++++++++++++++++++++++++++++++++++-------
>  2 files changed, 56 insertions(+), 9 deletions(-)
> 
> --- a/arch/x86/include/asm/ibt.h
> +++ b/arch/x86/include/asm/ibt.h
> @@ -70,6 +70,10 @@ static inline bool __is_endbr(u32 val)
>  	if (val == gen_endbr_poison())
>  		return true;
>  
> +	/* See cfi_fineibt_bhi_preamble() */
> +	if (IS_ENABLED(CONFIG_FINEIBT_BHI) && val == 0x001f0ff5)
> +		return true;

Does this magic value need some better documentation?

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook


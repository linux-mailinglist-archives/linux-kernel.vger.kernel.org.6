Return-Path: <linux-kernel+bounces-522176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2451BA3C705
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 19:07:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02CC41757AA
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 18:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 320B221420A;
	Wed, 19 Feb 2025 18:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WuiG6/kv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94AC48F7D
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 18:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739988427; cv=none; b=HF8Gj9iDifeto9kEjznLL5N4ErKUFhdQmWxYCD5ybdvfreg+sVEUQO5pZGnr44rI4gXW4TYhL9T9hT3qMe5Gh1J0T+Uf90zcdO8c3HCgyU5MujKRjgcLLZWh/QOyOBq4CTsouTmEmZQEHokiuwr9tN0QsJGtLinOaqpKhwMQ6DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739988427; c=relaxed/simple;
	bh=Skh2wJ04F5Kr2nHySTRk+8wz68hyI06FRmvz74fCBME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SZC4Q/PhRvFkkOxQ2wXPnHxGBKuqPRsgdZDkTYqBVQdBI/ovOuMSRo4N4tWVcQnxVvsuCWDP02Zxa5luRYj5CpZZI3ZQQ/YxsWsS05Ft0xKNKLqbnsZzLYNt+FQiMz8HcdPB69bmN2q1yzILu8q8FrIODEyYASz55eN9pm0mVCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WuiG6/kv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F346C4CED1;
	Wed, 19 Feb 2025 18:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739988427;
	bh=Skh2wJ04F5Kr2nHySTRk+8wz68hyI06FRmvz74fCBME=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WuiG6/kvAHVaC3VcqttYoHg1dZFUnl5QegNc1NeUQmBU8DM8bk3CqtOT0AitQEmbu
	 bSBiJPcaDExA+ASX5rDD7O3trol6WTLwLz2usqn10HrEDSI8TqSx7E14mmpHE0IkCZ
	 qUw3KdNIi2eOYP7wNY6CQ2YoM0ti5VKe5NfrnsxXhhlr+eoCtAF5k0yKvaJxBX9D4P
	 N/2XtOtMtaHR+D5oFcqw7g1ql4//eT9dCz8K0CasltrJMPC/ZaT95KwijRQWtPk5rV
	 8xOXtVIOT6B7Wt65D98g72jnIlxK3TEMnJoRgwLy0moOOKYYopBc/Mz0SryD9sl4Yt
	 CP1S9unbAvK5w==
Date: Wed, 19 Feb 2025 10:07:04 -0800
From: Kees Cook <kees@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, alyssa.milburn@intel.com,
	scott.d.constable@intel.com, joao@overdrivepizza.com,
	andrew.cooper3@citrix.com, jpoimboe@kernel.org,
	jose.marchesi@oracle.com, hjl.tools@gmail.com,
	ndesaulniers@google.com, samitolvanen@google.com, nathan@kernel.org,
	ojeda@kernel.org, alexei.starovoitov@gmail.com, mhiramat@kernel.org,
	jmill@asu.edu
Subject: Re: [PATCH v3 08/10] x86: BHI stubs
Message-ID: <202502191006.923E600C3@keescook>
References: <20250219162107.880673196@infradead.org>
 <20250219163515.150619755@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219163515.150619755@infradead.org>

On Wed, Feb 19, 2025 at 05:21:15PM +0100, Peter Zijlstra wrote:
> --- a/arch/x86/lib/Makefile
> +++ b/arch/x86/lib/Makefile
> @@ -66,5 +66,6 @@ endif
>          lib-y += clear_page_64.o copy_page_64.o
>          lib-y += memmove_64.o memset_64.o
>          lib-y += copy_user_64.o copy_user_uncached_64.o
> -	lib-y += cmpxchg16b_emu.o
> +        lib-y += cmpxchg16b_emu.o
> +        lib-y += bhi.o
>  endif

Unrelated whitespace fix?

-- 
Kees Cook


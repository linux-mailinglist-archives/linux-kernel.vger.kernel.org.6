Return-Path: <linux-kernel+bounces-519993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C23B9A3A479
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 18:40:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C9C116D00A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 17:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 604FE26FD97;
	Tue, 18 Feb 2025 17:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b13DpfpM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD43F2676C5
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 17:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739900310; cv=none; b=hXR9quEs01TFlTqxgTeZ3xTvU0cUh/UchLPYVPmG6o2jMnLT64allG1hTo8i2s1k3EMrwmMPRynpOhxuD66Gre06RMen25S/oJxBwXmpBZKYHv53gyLggqoNy/+gp5wEtsKv7ZhTVwjJpICY+9kUJuhCDAMB7gkJ2HB+cNruwyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739900310; c=relaxed/simple;
	bh=XdBZDRg0vfIGsy5TW559KUyXj6F/kzbOlj3oX4llMSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d4cL24oUINex2Mb2KWo7dgd5mi1duDFzchF2W7vJxzd6HxiHSqEaA3GOu0Zu3oBfloPRrdiVTga57SLiKL0E1J+RPEfvk5nM3AqCx7PsZ5FiiEchoQ9gR7raWqvlSbACVxkD16FZCT7PnL3OyBz/NLpOYgmOTMN/pR3asU1sGLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b13DpfpM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACC70C4CEE2;
	Tue, 18 Feb 2025 17:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739900310;
	bh=XdBZDRg0vfIGsy5TW559KUyXj6F/kzbOlj3oX4llMSo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b13DpfpM0GhK3g6tyYl9Zn4o8K416NdSHfikOylpqLLs+OgTHIxhq53FebnHbm9/f
	 nhSoLpq6asHHBHiBuzq/vVt7UW+KiRpth6zXAZgIQ7aUwBqBPRvgX5PCwjU7cBPgvZ
	 icAPv4yIYvQ+uU64Xkfzu6GA2S7ki7uwbLK/MCR7V33xG85oliLeJrIFEK4moWzvGB
	 lqQcYnhUZCXtXCwgPZNtW0sIhzb7IjDuNLYpWU1xtbvVz2HOGO7bFQHdzH9jOh2IbI
	 T9ls8BdM4C1/IQWXk6e1cTHWWUU2kNKZHkvpbB3RzHQ4AopGhAO3y/qkXVw/DeETIr
	 s0mTMPOjLpLxw==
Date: Tue, 18 Feb 2025 09:38:27 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	Huacai Chen <chenhuacai@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Tiezhu Yang <yangtiezhu@loongson.cn>
Subject: Re: [PATCH] objtool: Use idiomatic section name for relocatable
 rodata under PIE
Message-ID: <20250218173827.vk4gplulq3pjdnn6@jpoimboe>
References: <20250218092538.1903204-2-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250218092538.1903204-2-ardb+git@google.com>

On Tue, Feb 18, 2025 at 10:25:39AM +0100, Ard Biesheuvel wrote:
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> index 91a7e824ed8b..337d3336e175 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -457,7 +457,7 @@ defined(CONFIG_AUTOFDO_CLANG) || defined(CONFIG_PROPELLER_CLANG)
>  	. = ALIGN((align));						\
>  	.rodata           : AT(ADDR(.rodata) - LOAD_OFFSET) {		\
>  		__start_rodata = .;					\
> -		*(.rodata) *(.rodata.*) *(..rodata.*)			\
> +		*(.rodata) *(.rodata.*) *(.data.rel.ro*)		\

If I understand correctly, this is fixing an existing bug in loongarch
and any other arches using PIE, right?  And it has nothing to do with
objtool?

If so, it feels like this needs to be its own patch, described as a fix.

>  		SCHED_DATA						\
>  		RO_AFTER_INIT_DATA	/* Read only after init */	\
>  		. = ALIGN(8);						\
> diff --git a/include/linux/compiler.h b/include/linux/compiler.h
> index 3d013f1412e0..27024a128a6a 100644
> --- a/include/linux/compiler.h
> +++ b/include/linux/compiler.h
> @@ -110,7 +110,11 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
>  /* Unreachable code */
>  #ifdef CONFIG_OBJTOOL
>  /* Annotate a C jump table to allow objtool to follow the code flow */
> -#define __annotate_jump_table __section("..rodata.c_jump_table")
> +#ifndef __pie__
> +#define __annotate_jump_table __section(".rodata.c_jump_table")
> +#else
> +#define __annotate_jump_table __section(".data.rel.ro.c_jump_table")
> +#endif

Why have two different section names, does .data.rel.ro.* not work for
non-PIE?

-- 
Josh


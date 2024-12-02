Return-Path: <linux-kernel+bounces-427201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E64499DFDFF
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 11:01:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 590D9B25C66
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 10:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B92691FA147;
	Mon,  2 Dec 2024 10:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rcyJI9m3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2428F15A8
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 10:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733133692; cv=none; b=osDMi4PQgDyIpPXmt+2qjocbnB7adESLKJJeyOn+oxn2pMiWH9vhlo7iU/7wkJ592iuwGEWUoOy7mn2YJoW33+F3JYbogpEl0fipyeDFqKv1uDljnk5hbiUxgFv0jxOYpqMdNT52G7Wchk6Xk0QyHssa86S/ppHt7tKi0XTPTgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733133692; c=relaxed/simple;
	bh=Twzy5O/7e/TnnFaz97lCq4W6R1qv7ZP6CBG1FCn0gys=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WloyeWw0HKgxkdqoADThuf/xOO07X9JR0ee0BcKBuRnJvDcQa8LFKvHImK1hiNjAMNNwc32XwKnrEjC6jVD9EVo5a+0/CB5oqYK7RkMNBTxk8BbyPuGjE39DIOTxg70iDO2NDA3/EvxzNHwOWQ7j3zqMaOs/JEXsPe+P8cJ4U1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rcyJI9m3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CD58C4CED6
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 10:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733133691;
	bh=Twzy5O/7e/TnnFaz97lCq4W6R1qv7ZP6CBG1FCn0gys=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=rcyJI9m3ykA6ZtrNpdF+lhVGu5IvufUSSEfEKVAOikTgShTvKErVkgV21MjYAFNXO
	 qRBytU/W7/J0E3JXgp9jaZajQ5414bM1Z/vsxcM2g8b0+xPh/L7Xj0XmLHU0gMxBZ7
	 fvIqaii79+l7Sg10zj50s7lSjrUAeiZYNGqk8K9UiiTfneVdl/k2lJSGDmIMNP2XSq
	 PP3oR7eqggAofpU9l+Kyyv8RMSh6ejxLOsxL5niTgj1iwKZlA8CW7FC+JlSSK+ppS5
	 2uIXfIVBvcwggXluQnTJwIJv7tGPX9MGzz7gAfGVk2nH+Xd5WQHAoBt9qa8SyclfBG
	 LOcgAfXR4T1wA==
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2ffb5b131d0so40020371fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 02:01:31 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWzoJvs0TMHR2hvTbd/3wLMK8BGELmC3zKSnGhKY/r1PVAyPEkXXLmE/AeNsyyRRvK0QX2YqzI9yUseluw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEeYeKI2mCD7rUiU+EfrKau8XcQ+v6EZmXhjsKEP7pKSRdXiTB
	RXQrGxrclza12Bjdu1XiozcyYXEqUrafnLPPma2fSDREQytCfHgthU1X8U3x9QbtfwnlDGwWMC3
	WuXUOm2LICnjkHlfKu1v3lebeFp0=
X-Google-Smtp-Source: AGHT+IFVat+c+J7F0U+ulBavPviZFzk0YTK+UMlqTQSIoOaRkzhHNFubZtaueag5yYSMkQexIoToQuyrzoKIDatOxsg=
X-Received: by 2002:a2e:bd04:0:b0:2ff:ce49:111e with SMTP id
 38308e7fff4ca-2ffd60fad19mr74658641fa.39.1733133689960; Mon, 02 Dec 2024
 02:01:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241202043553.29592-1-anshuman.khandual@arm.com>
In-Reply-To: <20241202043553.29592-1-anshuman.khandual@arm.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 2 Dec 2024 11:01:18 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGPcMYsJV9w_fBXEyxUJFGZhSpn2etWie9wKA_HS3kF_g@mail.gmail.com>
Message-ID: <CAMj1kXGPcMYsJV9w_fBXEyxUJFGZhSpn2etWie9wKA_HS3kF_g@mail.gmail.com>
Subject: Re: [PATCH] arm64/mm: Drop INIT_MM_CONTEXT()
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Ryan Roberts <ryan.roberts@arm.com>, Mark Rutland <mark.rutland@arm.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 2 Dec 2024 at 05:36, Anshuman Khandual
<anshuman.khandual@arm.com> wrote:
>
> Platform override for INIT_MM_CONTEXT() is redundant because swapper_pg_dir
> always gets assigned as the pgd during init_mm initialization. So just drop
> this override on arm64.
>
> Originally this override was added via the 'commit 2b5548b68199 ("arm64/mm:
> Separate boot-time page tables from swapper_pg_dir")' because non standard
> init_pg_dir was assigned as the pgd. Subsequently it was changed as default
> swapper_pg_dir by the 'commit ba5b0333a847 ("arm64: mm: omit redundant
> remap of kernel image")', which might have also just dropped this override.
>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

Acked-by: Ard Biesheuvel <ardb@kernel.org>

> ---
> This patch applies on v6.13-rc1
>
>  arch/arm64/include/asm/mmu.h | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
> index 2ec96d91acc6..662471cfc536 100644
> --- a/arch/arm64/include/asm/mmu.h
> +++ b/arch/arm64/include/asm/mmu.h
> @@ -109,8 +109,5 @@ static inline bool kaslr_requires_kpti(void)
>         return true;
>  }
>
> -#define INIT_MM_CONTEXT(name)  \
> -       .pgd = swapper_pg_dir,
> -
>  #endif /* !__ASSEMBLY__ */
>  #endif
> --
> 2.30.2
>


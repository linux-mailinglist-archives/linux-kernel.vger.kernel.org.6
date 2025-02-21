Return-Path: <linux-kernel+bounces-525607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F40DA3F22B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 11:32:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13A7A3BD7A0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 10:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3561A205AA0;
	Fri, 21 Feb 2025 10:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="StkpjZ7/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958551F0E24
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 10:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740133823; cv=none; b=n1HswET9Q+5BGkxj3pZGksaM2xw/DljpCAxYgdolovUEMjecFu9c9Ione4qqj+wwm5yUCkOl2wnmBKL5+ojOLTdkw2SI3Jk6OS9dOosolta9pUi5vqCRcVrAFe2A80AwM5f1xjokuMikIaKbai1c8Fy7M9FZz9ENWAFPDf3/+Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740133823; c=relaxed/simple;
	bh=L4Yn8ZNJ5TtwsvtpvN3glzvTSSxENY7L3myfnaahI4A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ugBTf3Kxe8vMOKNygmtyCiW+NrBoXiJ4sEVXfTbqewm5t4bBb3aNam/XMMCkM6kQCHxIvjTfLJ2rQ/FzqacsyqsR11GNiHgxVeBRIGRHPy+uxZB0hvpYkghYNa8IsdNKqcR6DCIMpZ3+WihRBXOAiJJxYV0u7ZGcAzhCh6kYPLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=StkpjZ7/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2251EC4CEE8
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 10:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740133823;
	bh=L4Yn8ZNJ5TtwsvtpvN3glzvTSSxENY7L3myfnaahI4A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=StkpjZ7/enUGI5y7ARIOLtCsC0n1PEfdZOGHroPcEP1iUGlTLHzy6YbuLz5gI4S6W
	 FFa/y9OHuZP7vUdQcAmMiL5YFiVaL8TNxRS9Xn8IaW1RT8qtdVLDah20NFt0eN3g3l
	 9BPA9XZMTYPQy8C4pzm4u9iN4HHCItOHC1lVlK3j2e0Fh1AVcSQK5tGcc0D9G9cn26
	 XKIUOCrh7703QqXx58tCKEbuhAIXimj8D1iUE2HS8kuUYUKPa1SmIygI7wQCe+A+J+
	 74Za4mGGBYqCIz9TVX3kWr4YjQykQ7D/wAMQ4XETSPbye6D5rMrQSfRNWb0/JdTfEi
	 w5NjZyHABeBng==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-30a2dfcfd83so19026941fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 02:30:23 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVK+CxZanvkY+2z/r0hb3TLgKdVG3CbIAg4UFDIdMot/uQTb1/2cWiLEP+viUoVRPHK6Ozy0filHrGe4cs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8OiVgTEJzXvg5CL6YF9D3GHM13jvD/RSB5EACbk838fwvUcZM
	i34dDlyAYjpBhQwJzMcz13MZRb1jUJHJJ61uZcXtbNz2At76dZCCKJfs8ySzXEcDmpdBwq7eHDc
	AK2DKy+vnVFyIDKu04/bIwmsjiag=
X-Google-Smtp-Source: AGHT+IGBcJneX920k1Lzm84AjRPIaDaeLEbpUhX6kKQnbs/QmX66HaXqAnIzb4QrHONRgBbectt6YgqaTjoY8F69ZqY=
X-Received: by 2002:a2e:740c:0:b0:309:2377:b42d with SMTP id
 38308e7fff4ca-30a598f43b2mr7956341fa.18.1740133821449; Fri, 21 Feb 2025
 02:30:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220-x86-bump-min-llvm-for-stackp-v1-1-ecb3c906e790@kernel.org>
In-Reply-To: <20250220-x86-bump-min-llvm-for-stackp-v1-1-ecb3c906e790@kernel.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 21 Feb 2025 11:30:09 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGOdRXpAJT8ujpaWzcLXAJd=NOLXcRYWBKrt=oZ21EeVw@mail.gmail.com>
X-Gm-Features: AWEUYZlt20sEsNn9gGPbY6Nk16BcL4mLWLkJgTgTxIZ-cgqpft6KwG_ZCTZyxMA
Message-ID: <CAMj1kXGOdRXpAJT8ujpaWzcLXAJd=NOLXcRYWBKrt=oZ21EeVw@mail.gmail.com>
Subject: Re: [PATCH] x86/build: Raise the minimum LLVM version to 15.0.0
To: Nathan Chancellor <nathan@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, x86@kernel.org, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Uros Bizjak <ubizjak@gmail.com>, 
	Brian Gerst <brgerst@gmail.com>, linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Thu, 20 Feb 2025 at 21:08, Nathan Chancellor <nathan@kernel.org> wrote:
>
> In a similar vein as commit a3e8fe814ad1 ("x86/build: Raise the minimum
> GCC version to 8.1"), bump the minimum supported version of LLVM for
> building x86 kernels to 15.0.0, as that is the first version that has
> support for '-mstack-protector-guard-symbol', which is used
> unconditionally after commit 80d47defddc0 ("x86/stackprotector/64:
> Convert to normal per-CPU variable"):
>
>   clang-14: error: unknown argument: '-mstack-protector-guard-symbol=__ref_stack_chk_guard'
>
> Fixes: 80d47defddc0 ("x86/stackprotector/64: Convert to normal per-CPU variable")
> Link: https://github.com/llvm/llvm-project/commit/efbaad1c4a526e91b034e56386e98a9268cd87b2
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
>  scripts/min-tool-version.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>


> diff --git a/scripts/min-tool-version.sh b/scripts/min-tool-version.sh
> index 06c4e410ecab..787868183b84 100755
> --- a/scripts/min-tool-version.sh
> +++ b/scripts/min-tool-version.sh
> @@ -26,7 +26,7 @@ gcc)
>         fi
>         ;;
>  llvm)
> -       if [ "$SRCARCH" = s390 ]; then
> +       if [ "$SRCARCH" = s390 -o "$SRCARCH" = x86 ]; then
>                 echo 15.0.0
>         elif [ "$SRCARCH" = loongarch ]; then
>                 echo 18.0.0
>
> ---
> base-commit: 929ce2d9f919967fe8edf7e840165e43612c2576
> change-id: 20250220-x86-bump-min-llvm-for-stackp-9e358db476e2
>
> Best regards,
> --
> Nathan Chancellor <nathan@kernel.org>
>


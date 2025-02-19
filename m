Return-Path: <linux-kernel+bounces-522132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4168DA3C668
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 18:41:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DF543B23CB
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 17:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 188B22144D7;
	Wed, 19 Feb 2025 17:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nC/KdewT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50973214226;
	Wed, 19 Feb 2025 17:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739986893; cv=none; b=XUyc9ru/Lo0leczBCO6s347npG6pTDNHbe0AtFQ37RlTrKRf2ySwVoHSs6S5DJc0eJOC5Yx/hea6zHcmBzqmoqZhuyVBrT+9jnUlfDJUSONHd8ZbgfuNHb8d/mMPSeUM5eibZzj0gUk18qbHYCzsPsyAwPWa9bC9Q/TLhYp2CII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739986893; c=relaxed/simple;
	bh=kIkXxFdDl1vputqcWWA/PGngcXIL7N9KY7LhHR64CNg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fxfpmE4e+EHG0mX7ZKJsOyng0J1PQmDwwt0JLv5vBiHxl+mdE1075ziUgefp4ZJppP2uiIjJFML2ypHpN03yoThtzSYQmPZO3VB/OLaQifwgIrihmEHt55PX6K0ZZAHb193/JzGPsDCJkx0/6mYDuSzRSUf2ajNzI5PisKajdFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nC/KdewT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B940AC4CEEC;
	Wed, 19 Feb 2025 17:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739986892;
	bh=kIkXxFdDl1vputqcWWA/PGngcXIL7N9KY7LhHR64CNg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=nC/KdewTBAob2JJ1uqMwVsBBzE8m/TwQa2UUkrzR1wbB+TmeoXa4Nw13KbhS/5EqF
	 W7Z6VHUBcp/13jIZIMD/YiYUh8/sQLkkljM+rQjbkTWuvyE/murE9n1wF3wD8eCpiK
	 80SrE4pwpKM8FFav0gmUyu/zXrN80vr+OgQhU0iL6tql3oaENPPEQS1ptWsRM2tuOl
	 S07xKvSvnnnHNHtEk75UmTNq/yKrOfk+VCXc6IeMk0tsjyIV0BHz/NUYTrS8IQgbCB
	 PuMFpyTQLjRJO79a4LysY4gCx2Pp8VyD4WWlXcl2CPfvHeTwAKlv2ZQToeqehQnzpy
	 eM2rMogfgWkBQ==
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3d2acdea3acso54415ab.0;
        Wed, 19 Feb 2025 09:41:32 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWzPaFgJkMR2KdWndYyZ1DySWr9gI+XaBZJ1AiBW7jGFu+PLOYhYWRMx1ny6mkHntvlLDuXYDaWrEuXUPWD@vger.kernel.org, AJvYcCXA8D8V8kynNxhLiOjTw20c/WFjcI0tGi4uVZTuc7jZTzwzhAkgDcP0vBOEmtPU3ShnvIU6EooSAbbEVLpTFGw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZVKTwhpuqbio+UgNhfdlH23HMnW8HikXFYlDdGcmu1sGL1SiE
	mNEERL7Z95PdGAvLnTNokFP6A71ZUWqocFPGguZ8ZszsSKRgMJ3WOWDxALwA62GZJnxvKAbHp05
	Ee2C9twIplJyVD9vpqCHG9hecyJE=
X-Google-Smtp-Source: AGHT+IHb2AivR32bAhoSImkfZXBTi8hepDC23rVgdSlJiw648cpS3OEqQW4LY10/pxCZAXe2LrWKJDC73oUpaG0w3po=
X-Received: by 2002:a05:6e02:1a8b:b0:3d0:10a6:99b9 with SMTP id
 e9e14a558f8ab-3d2b526d97dmr47301155ab.3.1739986891944; Wed, 19 Feb 2025
 09:41:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <fcbb2f57-0714-4139-b441-8817365c16a1@stanley.mountain>
In-Reply-To: <fcbb2f57-0714-4139-b441-8817365c16a1@stanley.mountain>
From: Song Liu <song@kernel.org>
Date: Wed, 19 Feb 2025 09:41:21 -0800
X-Gmail-Original-Message-ID: <CAPhsuW7z=rQoGRmWaEihtmxb=QNcuiM8aTgtaR0wZ6G049YjkQ@mail.gmail.com>
X-Gm-Features: AWEUYZl3TM-I84V7hE6jNxKt7ipYmmXW-aQkPh2AuOoX7b837qicOk9GqelBzsM
Message-ID: <CAPhsuW7z=rQoGRmWaEihtmxb=QNcuiM8aTgtaR0wZ6G049YjkQ@mail.gmail.com>
Subject: Re: [PATCH] x86/module: remove unnecessary check in module_finalize()
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, "Mike Rapoport (Microsoft)" <rppt@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org, 
	kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 19, 2025 at 5:48=E2=80=AFAM Dan Carpenter <dan.carpenter@linaro=
.org> wrote:
>
> The "calls" pointer can no longer be NULL after commit ab9fea59487d
> ("x86/alternative: Simplify callthunk patching") was merged.  Delete
> this unnecessary check.
>
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Acked-by: Song Liu <song@kernel.org>

> ---
>  arch/x86/kernel/module.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/arch/x86/kernel/module.c b/arch/x86/kernel/module.c
> index cb9d295e67cb..615f74c4bd6c 100644
> --- a/arch/x86/kernel/module.c
> +++ b/arch/x86/kernel/module.c
> @@ -278,10 +278,8 @@ int module_finalize(const Elf_Ehdr *hdr,
>         if (calls) {
>                 struct callthunk_sites cs =3D {};
>
> -               if (calls) {
> -                       cs.call_start =3D (void *)calls->sh_addr;
> -                       cs.call_end =3D (void *)calls->sh_addr + calls->s=
h_size;
> -               }
> +               cs.call_start =3D (void *)calls->sh_addr;
> +               cs.call_end =3D (void *)calls->sh_addr + calls->sh_size;
>
>                 callthunks_patch_module_calls(&cs, me);
>         }
> --
> 2.47.2
>


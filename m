Return-Path: <linux-kernel+bounces-369215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ECCB69A1A6D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 08:05:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F2B7B2522F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 06:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D09817084F;
	Thu, 17 Oct 2024 06:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h6E59cY7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69F920E3;
	Thu, 17 Oct 2024 06:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729145102; cv=none; b=YjrTctQzX9/JmkwzNxfMEQ9RCFP3sddOHCFQcFdCHRRz7CWpLSVhRw8jPtJLhKA+jBOHdm8Y4eRtQfz4HcdMzto+7RANJ38n1tPocxyWhFLSEBOoJH78G8SEtA1c5bwOMtBpB3nFszV3BJq/fGcpQPYRBgE+7KRchjOF5ZblO9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729145102; c=relaxed/simple;
	bh=t1HnCydS0atSYI/AGcOQFR+eukRX/dfYhPbg8mMxkOg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SecwDDtGsC5uL86q/TlI7E/SbNNjM8Ppe3cfHMCYoqqb7b9m0LkK2nfLGM03aQuGGSSVvlNs7KsFv3bobCwiUiCjMXccJxzVV/ewWHuvLI94QFk3eSnNVQFSbPi4iZscT1xbrCIKipAlcxv6VwRkrdq1aU/r3Uyhi5994DyXLm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h6E59cY7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D5B4C4CEC3;
	Thu, 17 Oct 2024 06:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729145102;
	bh=t1HnCydS0atSYI/AGcOQFR+eukRX/dfYhPbg8mMxkOg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=h6E59cY7HtIXuLhOF5NPKvzWs8TyfwU49D0uYv4Uo7rO8jlkoVuzKsXChW5PE559d
	 B7NJLAFbE3ZwhqAfcYrGvA6yrCHaoTt0x7S6TvT/jmC6JoMK4gwDmo2uYFz24iH+NG
	 t4kF4L8umcwrQZ4vysQuSkZHsERht0eT+PmHSzT16w5c27WZUUCC7KXGFNliFn4X7w
	 ICnU+uGc4G/vOIBJJ0NqJeCm+0FMyGNpEtzh8aJxkAeEaUJTVtYLF2ua80ui/ZXcLv
	 TsS1nX202kpEZkrl+/WxYMWduhHIiQsb7UX6BOJw13tmvbVBoH+ZHutnYjKkyEWmlg
	 zJsbrPzJbHLVg==
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5c96df52c52so695164a12.1;
        Wed, 16 Oct 2024 23:05:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUoz16WgJRi9s0dkISg4+laanzb+T7FGo+nH27Or7fOW9f52idn1Afel2Oy5CjCA2Rnv4VRRVBBVZcsV+o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm2qPyaxHsVAtytyHd8L+NzwLty3b9DJuP3zQFNvDxsH3r4fVb
	82CHgu+WUDoKSbbeuPtuAa3D1VzsltxE1X0TpvjTE50lr4atsoBSsObbqZ5pzhd86i9H9AjcDDD
	Vbk0A9Fm0qYHkJR5Tb58b0FywaF8=
X-Google-Smtp-Source: AGHT+IFy9ktPvvSG7d7EbKwJZdWQWk4IaHwQ/GuH/sYXtfkd2At0LwgewwZ53gH+DCidLAld2f1Q0TR2Ufq61untAYA=
X-Received: by 2002:a05:6402:13c3:b0:5c9:218d:7071 with SMTP id
 4fb4d7f45d1cf-5c95ac1776cmr14288236a12.20.1729145100724; Wed, 16 Oct 2024
 23:05:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008054615.43062-1-yang.li85200@gmail.com> <20241016095626.8162-1-yang.li85200@gmail.com>
In-Reply-To: <20241016095626.8162-1-yang.li85200@gmail.com>
From: Guo Ren <guoren@kernel.org>
Date: Thu, 17 Oct 2024 14:04:49 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQ5D8fU9rSs7V28S9c5+ZPuQSJW7inQtoFsM6X6gBgOKg@mail.gmail.com>
Message-ID: <CAJF2gTQ5D8fU9rSs7V28S9c5+ZPuQSJW7inQtoFsM6X6gBgOKg@mail.gmail.com>
Subject: Re: [PATCH v2] csky: fix csky_cmpxchg_fixup not working
To: Yang Li <yang.li85200@gmail.com>
Cc: linux-csky@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 16, 2024 at 5:56=E2=80=AFPM Yang Li <yang.li85200@gmail.com> wr=
ote:
>
> In the csky_cmpxchg_fixup function, it is incorrect to use the global
>  variable csky_cmpxchg_stw to determine the address where the exception
>  occurred.The global variable csky_cmpxchg_stw stores the opcode at the
>  time of the exception, while &csky_cmpxchg_stw shows the address where
>  the exception occurred.
>
> Signed-off-by: Yang Li <yang.li85200@gmail.com>
> ---
> V1 -> V2:Eliminate compilation warnings
>
>  arch/csky/mm/fault.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/csky/mm/fault.c b/arch/csky/mm/fault.c
> index a885518ce1dd..5226bc08c336 100644
> --- a/arch/csky/mm/fault.c
> +++ b/arch/csky/mm/fault.c
> @@ -45,8 +45,8 @@ static inline void csky_cmpxchg_fixup(struct pt_regs *r=
egs)
>         if (trap_no(regs) !=3D VEC_TLBMODIFIED)
>                 return;
>
> -       if (instruction_pointer(regs) =3D=3D csky_cmpxchg_stw)
> -               instruction_pointer_set(regs, csky_cmpxchg_ldw);
> +       if (instruction_pointer(regs) =3D=3D (unsigned long)&csky_cmpxchg=
_stw)
> +               instruction_pointer_set(regs, (unsigned long)&csky_cmpxch=
g_ldw);
csky_cmpxchg_ldw(stw) is a label symbol, not a variable.

arch/csky/kernel/atomic.S:
GLOBAL(csky_cmpxchg_ldw)
GLOBAL(csky_cmpxchg_stw)

Your modification does not affect the ASM output.

(gdb) p main
$1 =3D {void (void)} 0x5fa <main>
(gdb) p &main
$2 =3D (void (*)(void)) 0x5fa <main>

>         return;
>  }
>  #endif
> --
> 2.34.1
>


--=20
Best Regards
 Guo Ren


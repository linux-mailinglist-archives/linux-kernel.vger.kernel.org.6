Return-Path: <linux-kernel+bounces-398614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C149BF39E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 17:52:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A7562845EA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 16:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04A8020514C;
	Wed,  6 Nov 2024 16:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Af5kfJ0w"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D2A204090
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 16:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730911902; cv=none; b=aFg8NZsQwbBrBgiEF0fBbVEft3i1cKV5Z8SCI7wUL81Sgdm19efRfIK5w6t7Podpj6lvJ7kXOD9fPcXpP88RHqFW8fe4L4APViw//xoWDd0WalmSD1lzdJIUn4TnD/Zt3BWetRhAnjBc+5q9sMsoCyeLEE6F623VOGeFD4B3SlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730911902; c=relaxed/simple;
	bh=gVv323OZ+FWKhAZOlvkImozHb4NHkf+Vtas7NKnF8b0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=tTVzPEZMUBpUr+Z1uT8w4MDA1SwXVkjXmoj7LAAt/2g8laLDBepS3COnUsHFU40k77r2WUiSj2d7wcGyoqqPNLvq28oddZjx7WdRL3fLmxFY97qu6g3n6pfO1V/2HPtQVfaVl018Mn7QAsJ1iA7GoKA4AT2XPCilc/Oww+jo62g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Af5kfJ0w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A569C4CECD
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 16:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730911902;
	bh=gVv323OZ+FWKhAZOlvkImozHb4NHkf+Vtas7NKnF8b0=;
	h=References:In-Reply-To:From:Date:Subject:To:From;
	b=Af5kfJ0wLmsWIm5khsS1r7GHy6Ez70N0YNKvloP5+IrYo6NqUSPFkk1mvMaq/UTtD
	 9/frhkGMcrNTuFHGnfrbMKjW9r48Y/ktcWoVWFR8DBTggip63eU89fD9MHImP+t2ch
	 G77RnemYvb5wA6gb5K+fCjp8m7VDUKZzh34IyIB2PZllaIw5NyxjUzVLZ0N7eU85DR
	 p6DcoroCz69lGJP29nPeJ2OGKuS76Ot+hMTExH7Kz2lCiSxASJ5/cVmj2LSVCKvl5R
	 uUZJC76RyUZW8V55rC7A3C1N0rk5XBPLD+tLJNb6s6ncml2nsMqk9qBg/fQWARotkC
	 wPxxPSyEPHI0Q==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-539f58c68c5so12581569e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 08:51:42 -0800 (PST)
X-Gm-Message-State: AOJu0YzrZLpk0qInMHALC8Xn6383cu3DAd/nyrlHwhLA4gi1236dMnlj
	cG9gyEjr9tPOHoTUghUawyayZX5idfTSTV1GC0kaGzcGNalmYD4MK2p2XTo3F49CPHoNkS2DZ5J
	pnsjfMO8JfpHNqgGtCZUK5bXyIqo=
X-Google-Smtp-Source: AGHT+IGiRbvuAkkBXRVM3azbWzKeSSn//vdNnafbF7BrcxUXNryPgOyXovxZnaPbV0bRTmkvJIRFeeUpGFARxYB0PpM=
X-Received: by 2002:a05:6512:b98:b0:53b:2105:18bb with SMTP id
 2adb3069b0e04-53d65e16271mr16468636e87.51.1730911900924; Wed, 06 Nov 2024
 08:51:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240918031537.588965-1-masahiroy@kernel.org>
In-Reply-To: <20240918031537.588965-1-masahiroy@kernel.org>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Thu, 7 Nov 2024 01:51:04 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQjKNrAK8ffZiz7qOKRFcUqQds5bMjdOXKPd0gedzhjYw@mail.gmail.com>
Message-ID: <CAK7LNAQjKNrAK8ffZiz7qOKRFcUqQds5bMjdOXKPd0gedzhjYw@mail.gmail.com>
Subject: Re: [PATCH] xtensa: annotate dtb_start variable as static __initdata
To: linux-kernel@vger.kernel.org, Chris Zankel <chris@zankel.net>, 
	Max Filippov <jcmvbkbc@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 18, 2024 at 12:15=E2=80=AFPM Masahiro Yamada <masahiroy@kernel.=
org> wrote:
>
> The 'dtb_start' variable is only used within arch/xtensa/kernel/setup.c.
> Mark it as 'static'.
>
> It is only used by parse_tag_fdt() and init_arch(), both of which are
> annotated as __init. Therefore, dtb_start can be annotated as __initdata,
> so it will discarded after boot.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---

Ping?

>
>  arch/xtensa/kernel/setup.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/xtensa/kernel/setup.c b/arch/xtensa/kernel/setup.c
> index bdec4a773af0..3e076b64cc61 100644
> --- a/arch/xtensa/kernel/setup.c
> +++ b/arch/xtensa/kernel/setup.c
> @@ -55,7 +55,7 @@ extern int initrd_below_start_ok;
>  #endif
>
>  #ifdef CONFIG_USE_OF
> -void *dtb_start =3D __dtb_start;
> +static void *dtb_start __initdata =3D __dtb_start;
>  #endif
>
>  extern unsigned long loops_per_jiffy;
> --
> 2.43.0
>


--=20
Best Regards
Masahiro Yamada


Return-Path: <linux-kernel+bounces-225355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7146F912F87
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 23:27:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C77E28692B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 21:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 012CD17C227;
	Fri, 21 Jun 2024 21:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rktJcpWa"
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C731B81AC1
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 21:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719005261; cv=none; b=nZuJB31cKbBlcqYUlgZjNRW1J8sf6poDjNYDCl7r5lwN6AWxcIu17bq7i77YK50MHT0uSoVsGDtRDbb4K+yTswQE3M0/AmYwVE5pkiiNqVidPmi0yXmag5xQkO9T9nIT5InWQUbRlLdBD/LopI1yLdS4OuEx04D6Ehn+9HcFHMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719005261; c=relaxed/simple;
	bh=uMNzYRIgleMfYnwYF+a0ZGkYj4KN0oRJZLd7rVFB5WU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tIpgob7H6uhTZfAPR70wJlSUsoxL7SzmYEzDAkbJsn67uQ6dR4HH1Pkr+vCBMm+M75eqkuKI8lLS0mZg0UAWCIpidP0Vp28ZkGp9bkBnd/OBB1NEj5Mg9D2xq9N6YhLCd5yihQkERRs/IrJtUvXZkeaUj8tkctg352NJiAzInls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rktJcpWa; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-48c2d01994eso744491137.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 14:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719005257; x=1719610057; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B9YYJN6gO8sKB5sQbYzsaO+MvxbhNg/Nzd2XouVD5g0=;
        b=rktJcpWaL9+43LdIemRNDkcDdDjrv+RRCH26Di6a+AOiDnRrLUx1nk6JzUh22uFojI
         rsTzcwqEwt56cYEjSKnvQpJIne26igR3Y6L/706L5QEN3xynoaajPd0BsYyhWxk3a7Ls
         60rnqfeFBpk6QJWWZIPk6maIIIVz+mTkYY+9Mpy/yZ968FDA3oXeJ8+dbsWqoiSTYwly
         73VeanyDtECRlwK1+/oD5obRLTe4S6Nkxwj0d0xETHSDgIZboPUeHJoDaAAX1UCKnuNe
         hVALuNzpmMMgdWVv47cS5uqcP67uhLF5ove5gR1zD+Abk0Bmeitm2f0TZ9FUYQP++bs3
         oaBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719005257; x=1719610057;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B9YYJN6gO8sKB5sQbYzsaO+MvxbhNg/Nzd2XouVD5g0=;
        b=w7kF9IiSkuNJ2HFEPcDsPIq/seKwJhlxi7UjFWQdJ0kj7wjg2LLTUj1zFkh6E1IBMi
         oP1hT79G2o8Xpd9hweJN7G6VT+c5F4/HZ4P3vHPDbMYT1/0aS8EIH5HIrdqr1HJEeIY5
         A2S6s+CUJ+U4u1abY7eCGovYQUBqQm2Zx2VIVsAuVcnOt8lknYDjZnxL7Hu6vTVkGSMF
         O7Dkn7Km7/O3g5qruD6FWAoWqfFhX8q32vXXK7MfZtEKX4d9xZhswavCwEXJKRqtyciv
         T52vB/IAPgcF3m8Xk5ux9GTFAlHIuqPTYTM4p1UPIGDQIw+K/NMas6weLtbWqmMllmnc
         326A==
X-Forwarded-Encrypted: i=1; AJvYcCXSGxMhPp6pxdbI4HssP/Az6yIJ1VbPboHMTkUvPfGq0/jOCPpFoJOPGgOJkvMaOHQor8m2LIHSzKmKIupkFIYFwA/OVAb6GpdANQGZ
X-Gm-Message-State: AOJu0YxJnhAf5fDvkSxd/faOpuJs/KixdaAMczK2zRzTPg4pWRdV9daz
	2FqH0sBmoL9VtGEYZ8Vt8gfxBfN6sOijb+o5Qow7/NWAbEzcZWO3jIAT2Ndqzh7TIWbnPHuas0Q
	+9Gm9OqMErVAc52OFpLjfMj4sWaG/JHTIUdiH
X-Google-Smtp-Source: AGHT+IFJsXHscUZN1ArxTSIV4VXg2gnQo9OEeHipRr4oFQUE6eYw6FyYq4qABzIJaAuPwBpxGEH9hruTNr2gkbg4xXw=
X-Received: by 2002:a67:e20c:0:b0:48f:3fe2:1560 with SMTP id
 ada2fe7eead31-48f3fe21584mr2043664137.11.1719005257518; Fri, 21 Jun 2024
 14:27:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240621211819.1690234-1-yabinc@google.com>
In-Reply-To: <20240621211819.1690234-1-yabinc@google.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Fri, 21 Jun 2024 14:27:25 -0700
Message-ID: <CAKwvOdmYWEp8SaksnereMRPBq1q614kWJAWtcSyAeTVZ=geQfg@mail.gmail.com>
Subject: Re: [PATCH v2] Fix initializing a static union variable
To: Yabin Cui <yabinc@google.com>
Cc: Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Nathan Chancellor <nathan@kernel.org>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 21, 2024 at 2:18=E2=80=AFPM Yabin Cui <yabinc@google.com> wrote=
:
>
> saddr_wildcard is a static union variable initialized with {}.
>
> Empty brace initialization of union types is unspecified prior to C23,
> and even in C23, it doesn't guarantee zero initialization of all fields
> (see sections 4.5 and 6.2 in
> https://www.open-std.org/jtc1/sc22/wg14/www/docs/n2900.htm).
>
> Clang currently only initializes the first field to zero, leaving other
> fields undefined. This can lead to unexpected behavior and optimizations
> that produce random values (with some optimization flags).
> See https://godbolt.org/z/hxnT1PTWo.
>
> The issue has been reported to Clang upstream (
> https://github.com/llvm/llvm-project/issues/78034#issuecomment-2183233517=
).
> This commit mitigates the problem by avoiding empty brace initialization
> in saddr_wildcard.

Thanks for the patch. The links add a lot more context.

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>
> Fixes: 08ec9af1c062 ("xfrm: Fix xfrm_state_find() wrt. wildcard source ad=
dress.")
> Signed-off-by: Yabin Cui <yabinc@google.com>
>
> ---
>
> Changes in v2:
> - Update commit message to add/update links.
>
> ---
>  net/xfrm/xfrm_state.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
> index 649bb739df0d..9bc69d703e5c 100644
> --- a/net/xfrm/xfrm_state.c
> +++ b/net/xfrm/xfrm_state.c
> @@ -1139,7 +1139,7 @@ xfrm_state_find(const xfrm_address_t *daddr, const =
xfrm_address_t *saddr,
>                 struct xfrm_policy *pol, int *err,
>                 unsigned short family, u32 if_id)
>  {
> -       static xfrm_address_t saddr_wildcard =3D { };
> +       static const xfrm_address_t saddr_wildcard;
>         struct net *net =3D xp_net(pol);
>         unsigned int h, h_wildcard;
>         struct xfrm_state *x, *x0, *to_put;
> --
> 2.45.2.741.gdbec12cfda-goog
>


--=20
Thanks,
~Nick Desaulniers


Return-Path: <linux-kernel+bounces-269908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE7D943860
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 23:59:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF9122815A3
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 21:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D7E216D325;
	Wed, 31 Jul 2024 21:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UFxFUISD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8461607B0;
	Wed, 31 Jul 2024 21:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722463133; cv=none; b=N7hiUFZEFMLRuL/aWQ4J8ZLJt6PAkVPQNvqNJ9BUzkiQ4tiHgsRZl4s0GAvAJfy4gka5UF9H6d0oXqux2u8lNq7sEd9+wCKO6r5e80obKxKwWPxzgRpisa6hE/pf/6JFPzRWCh5JWQ1oUTRC6WOu9+D6FzfJB3jQkkFVG9PHplA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722463133; c=relaxed/simple;
	bh=t2MyTV5Di8+XYcZPEOSgqvHOVGXfSYCXA8g1hjnUKgM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iqQ8tFaK5l2wf4eyqCvBMFW0OORyfLOWYD2eRZPTj2z+OOwmFhWZ0bx67tKw5YVmoEND+dbxISdocpjyZ/M/luP0bXh59YxPj9JRD2/xk/xG02GR/2ENtrn7HVRzhJL6BasedACm71aZNTOoc+Bqo0djsCQWphTjee6fN/a8cLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UFxFUISD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F387C4AF0C;
	Wed, 31 Jul 2024 21:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722463133;
	bh=t2MyTV5Di8+XYcZPEOSgqvHOVGXfSYCXA8g1hjnUKgM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=UFxFUISDsVVR1PnEo0+if+nnDSkeIOsWNVY0j/1HO1pKg3brKZ/AaYzlXuZiC9DmN
	 TTLGeuOzXb5SoQpn4qfacCYVebYPrwXXkxIVNRSlk1R1am39P30tGGiQOdOsPAsJ3J
	 RT83auSlh03CqGqSWhREPc/c20qSAXocWhXzgPIq1pNU9GBWwCFEr7sLCCkZC+w4Wl
	 Zx7yM8tOwv3B14xffHImliQ5PVUnRwqciyVU/zdKP4AJeD7rbl1SkU5j9zg0O59qLW
	 3xWMB+7iVBap9toqtAOhQcdqFvv3FMhA0QlVxRVhwIK3jOIb7GfaAxotm8km0TVjGF
	 NK2I+QHD2fj/Q==
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2ef2cce8c08so67545181fa.0;
        Wed, 31 Jul 2024 14:58:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVMGQS8gr/CvJnY3DgZLprePJ09z0HSVxMoGLpRfuYpUCWpHrJI6ZVogShP7AEOO7QgoCuonl43nx/gkeG/Qik+WEz8jPznODUSefP0BJ7mZ5UfZd5sZUt6ocef1NbPcuvOUzUVbLI/5g==
X-Gm-Message-State: AOJu0Yy8kAfuswK4zFENC9NkLtY+ERWLWw5VqBTRmfz3EfnMzvMKMbpK
	EjQWwbGaupLcDLJ+xfgV1130X2y4Zwfat6TZZ6N5nZ80pva21jT70wvFb5PYmFHLN6MiDlXDA51
	pTcRK+NdP/JYm342vE71AviK24Q==
X-Google-Smtp-Source: AGHT+IHfEm3FCejVoH42G2fr88q6T7YZhdTVOZtI5mhvYzgPZNxjGe9arcigvArAMB3LMzwmkzq5yB+nJtww9EMej5Q=
X-Received: by 2002:a2e:320e:0:b0:2ef:2c6b:818 with SMTP id
 38308e7fff4ca-2f1531162b2mr4209661fa.24.1722463131655; Wed, 31 Jul 2024
 14:58:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2046da39e53a8bbca5166e04dfe56bd5.squirrel@_>
In-Reply-To: <2046da39e53a8bbca5166e04dfe56bd5.squirrel@_>
From: Rob Herring <robh@kernel.org>
Date: Wed, 31 Jul 2024 15:58:38 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKpTKv-fthwD9bFHiVESJyNP6uMg7Px7Rh+-k583oz76g@mail.gmail.com>
Message-ID: <CAL_JsqKpTKv-fthwD9bFHiVESJyNP6uMg7Px7Rh+-k583oz76g@mail.gmail.com>
Subject: Re: [PATCH v2] of/irq: Make sure to update out_irq->np to the new
 parent in of_irq_parse_raw
To: WHR <whr@rivoreo.one>
Cc: Saravana Kannan <saravanak@google.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 29, 2024 at 11:54=E2=80=AFPM WHR <whr@rivoreo.one> wrote:
>
> Commit 935df1bd40d43c4ee91838c42a20e9af751885cc has removed an
> assignment statement for 'out_irq->np' right after label 'skiplevel',
> causing the new parent acquired from function of_irq_find_parent didn't
> being stored to 'out_irq->np' as it supposed to. Under some conditions
> this can resuit in multiple corruptions and leakages to device nodes.

Under what conditions? Please provide a specific platform and DT.

>
> Update 'out_irq->np' before jumping to label 'skiplevel'.
>
> Fixes: 935df1bd40d4 ("of/irq: Factor out parsing of interrupt-map parent
> phandle+args from of_irq_parse_raw()")
> Signed-off-by: WHR <whr@rivoreo.one>

Need a name here.

> ---
> v2:
> Add 'Fixes:' line, and update subject.
>
>  drivers/of/irq.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/of/irq.c b/drivers/of/irq.c
> index c94203ce65bb..580b33ce60d2 100644
> --- a/drivers/of/irq.c
> +++ b/drivers/of/irq.c
> @@ -263,6 +263,7 @@ int of_irq_parse_raw(const __be32 *addr, struct
> of_phandle_args *out_irq)
>                 if (imap =3D=3D NULL) {
>                         pr_debug(" -> no map, getting parent\n");
>                         newpar =3D of_irq_find_parent(ipar);
> +                       out_irq->np =3D newpar;

Honestly, I think the DT is wrong if you get to this point. We'd have
to have the initial interrupt parent with #interrupt-cells, but not an
interrupt-controller nor interrupt-map property to get here. Maybe
that happens in some ancient platform, but if so, I want to know which
one and what exactly we need to handle.

Rob


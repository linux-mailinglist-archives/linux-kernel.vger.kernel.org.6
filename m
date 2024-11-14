Return-Path: <linux-kernel+bounces-409909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE97B9C932E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 21:25:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF4F628529A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 20:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45BD21AB6ED;
	Thu, 14 Nov 2024 20:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UI2bZWvg"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0DD81AA7B4
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 20:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731615914; cv=none; b=fNYFv7UewZz2cKhAv4XJBryJ4Fyo9OiWRJTj0OLGOiHttJ2KKEDoOQqaQGac5LU5v+toNH82bIotoZ2ItJetTDnAqxNLYJu48XNAZO9tlVsPrQ6unetn5YxQnIW9PBtYSU158SmUK7Aj8IhMcxwxTCZlEROx9f7qq3m84NIfxG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731615914; c=relaxed/simple;
	bh=HbNWwSN2HYVfMqwLHWHDAYGuQJXGlO6/e8ox1aUj7JA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FknVMbf2rmoaITQnJMlkgXTwFPX8CdrRWJ5dBvuji7Acsreckz/Bgd9xVFVA+5eXlJ3+kZke2WcgKby6TX1zyaXFOjqCZKuviqGJjhAdVRyMpnVUBtnib0lGvxTN7MIDGlmJaLmaenkZbs3DzpuVGh+ynHijB7+WAmG1aElvIf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UI2bZWvg; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-71ec997ad06so819098b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 12:25:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731615912; x=1732220712; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u5iBO4dT/lhV+birZRBoe/g+Rhn+x/t+6ZledOJLwKQ=;
        b=UI2bZWvgg+p1n/INm/KA3eKZveCS8EeLixG9RCm9dZewURKleo3zFVINFSyKVyIZdZ
         p8Dp7lrfRuHjShc76cO0iPIB8P3nrIczx/9mvdgZYThhuK9g+fF6UAn8LuPJXX3pM7fR
         eEzW6w4OQtUwh8NpdvejWdO+i5G8v3vHge4vBpWK2NqR9vyJdKsshiFkDmeNJAZ3Y9mM
         bhSbv61vgLsJ/bOxc3czLgUu9afUv1Oq4ceJiOGuG9Yi+t60LiUVUsdHKZ/rQ6Rh+ZPa
         jTRGAV/0lO0Scy/7MBsWfWWlzk0NDKSRkNMmmIH8gruD2g5z6bn1WYZOfcL1b3D3VMX9
         hR9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731615912; x=1732220712;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u5iBO4dT/lhV+birZRBoe/g+Rhn+x/t+6ZledOJLwKQ=;
        b=Lw6qw2qvTzGHKwNuGGQ/yvYwWj0vr9yexOZcYvFwEjoGI0lnjjZZ9xbztIyEK6WwIK
         voYsAhlxtwcKS2GUjLXXJWHmftcjxqKApzx2TZGpdxbmYNY6vjVEobz/YetZA8H5Ck90
         mXSy/zfPygf87g2J8m99vVsxhUqdZNLJyRczlnE3HtGdesjq2FeY3Z9ui8DoErSBpzEo
         davKTJ31neI94LbIFxEp9+28iHHR05GEyGg6kqAqgBF4YNsnDnmUbjMQKgWcWyEVqGpW
         sHMXzwcScktt2pB1PYqqjU45FgRhgtnYIqx/jC8CH4EYVz74PpZQ61SpWP2Oy+xa+UTB
         DgOg==
X-Forwarded-Encrypted: i=1; AJvYcCX29Guey4LGDUluELNOUhYni3Mj1heLV/4c9hYibj+f2N2Xzi34AfaCBUwIFSeyZWTFj44l6NoXbNhxnTI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2kRDR2oqdtwp4LdX36cdz+rwykCvc1Dk639oQoMHy1bUZJOHw
	ZcFcnVBCRQwkBrkek7cugOUIKxDFaNO/4/zJh2NvlKH6nuPZr5UZhzMyA+lbhgxXcJygLe26Drg
	QwQfM+FiAG71VU3wd3EONB7jiHRLSw6DyjHbN
X-Google-Smtp-Source: AGHT+IEQYYyGqieX2ZSmE3AoDpo5biU07zkfh04TMzpWDK3tBk7ShrhdDDi7lJyqTNHx9S4MtIh/1gM926Gl8cwVlJM=
X-Received: by 2002:a05:6a00:4fc9:b0:71e:6489:d06 with SMTP id
 d2e1a72fcca58-72476a0075fmr271809b3a.0.1731615911642; Thu, 14 Nov 2024
 12:25:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241114195652.3068725-1-samuel.holland@sifive.com>
In-Reply-To: <20241114195652.3068725-1-samuel.holland@sifive.com>
From: Saravana Kannan <saravanak@google.com>
Date: Thu, 14 Nov 2024 12:24:34 -0800
Message-ID: <CAGETcx9hLPxtE94cKiM==+Ep8k=d+HP4q3FCMKMbeFAjt7XW7Q@mail.gmail.com>
Subject: Re: [PATCH] of: property: fw_devlink: Do not use interrupt-parent directly
To: Samuel Holland <samuel.holland@sifive.com>, Marc Zyngier <maz@kernel.org>
Cc: Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 14, 2024 at 11:56=E2=80=AFAM Samuel Holland
<samuel.holland@sifive.com> wrote:
>
> commit 7f00be96f125 ("of: property: Add device link support for
> interrupt-parent, dmas and -gpio(s)") started adding device links for
> the interrupt-parent property. Later, commit f265f06af194 ("of:
> property: Fix fw_devlink handling of interrupts/interrupts-extended")
> added full support for parsing the interrupts and interrupts-extended
> properties, which includes looking up the node of the parent domain.
> This made the handler for the interrupt-parent property redundant.
>
> In fact, creating device links based solely on interrupt-parent is
> problematic, because it can create spurious cycles. A node may have
> this property without itself being an interrupt controller or consumer.
> For example, this property is often present in the root node or a /soc
> bus node to set the default interrupt parent for child nodes. However,
> it is incorrect for the bus to depend on the interrupt controller, as
> some of the bus's childre may not be interrupt consumers at all or may
> have a different interrupt parent.
>
> Resolving these spurious dependency cycles can cause an incorrect probe
> order for interrupt controller drivers. This was observed on a RISC-V
> system with both an APLIC and IMSIC under /soc, where interrupt-parent
> in /soc points to the APLIC, and the APLIC msi-parent points to the
> IMSIC. fw_devlink found three dependency cycles and attempted to probe
> the APLIC before the IMSIC. After applying this patch, there were no
> dependency cycles and the probe order was correct.

Rob/Marc,

If the claim about the interrupt parent interpretation is correct
across the board, I'm ok with this patch.

I remember the RISC-V DT for interrupts being a mess. So, want to make
sure you agree with these claims before I Ack it.

Thanks,
Saravana

>
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> ---
>
>  drivers/of/property.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/of/property.c b/drivers/of/property.c
> index 11b922fde7af..7bd8390f2fba 100644
> --- a/drivers/of/property.c
> +++ b/drivers/of/property.c
> @@ -1213,7 +1213,6 @@ DEFINE_SIMPLE_PROP(iommus, "iommus", "#iommu-cells"=
)
>  DEFINE_SIMPLE_PROP(mboxes, "mboxes", "#mbox-cells")
>  DEFINE_SIMPLE_PROP(io_channels, "io-channels", "#io-channel-cells")
>  DEFINE_SIMPLE_PROP(io_backends, "io-backends", "#io-backend-cells")
> -DEFINE_SIMPLE_PROP(interrupt_parent, "interrupt-parent", NULL)
>  DEFINE_SIMPLE_PROP(dmas, "dmas", "#dma-cells")
>  DEFINE_SIMPLE_PROP(power_domains, "power-domains", "#power-domain-cells"=
)
>  DEFINE_SIMPLE_PROP(hwlocks, "hwlocks", "#hwlock-cells")
> @@ -1359,7 +1358,6 @@ static const struct supplier_bindings of_supplier_b=
indings[] =3D {
>         { .parse_prop =3D parse_mboxes, },
>         { .parse_prop =3D parse_io_channels, },
>         { .parse_prop =3D parse_io_backends, },
> -       { .parse_prop =3D parse_interrupt_parent, },
>         { .parse_prop =3D parse_dmas, .optional =3D true, },
>         { .parse_prop =3D parse_power_domains, },
>         { .parse_prop =3D parse_hwlocks, },
> --
> 2.45.1
>


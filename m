Return-Path: <linux-kernel+bounces-254588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2AF79334F8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 03:25:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA94A1C21CBE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 01:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D76DD17FF;
	Wed, 17 Jul 2024 01:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UHyQ6+RU"
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4451ED8
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 01:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721179524; cv=none; b=EEn9iKLTG6zs9L7zZLVoI+AOqW4ZuD4Jg0N9DAeLRjhkUlaqzOEJRtscInWVpXEmByzjPzGl0qb1OQEQg5ogcV2JB2utiahmz8RJgD2OvU9+aQuDI8i2OH5HtvYmz8cJNPnGmW6Brpa1VSdTBVJJjeIhhuiykj+0b5zabD3Dfr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721179524; c=relaxed/simple;
	bh=xiZ18NVnc+hut2m3fj97F6NANmrgBFk6Cn9vxzT7KYE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=frZ28zAvnHoQL8cV9HOtwVluYdUXE5GiVaX9A1lwtkGQVLHDRGhN7mOBOe3dpiK6GgE7QYK9yimbzBy6KABEumZjpvz0xixE6p65dYC7CAn8CuD0lkAhQHbLDvEBuGOvRe49CPP3ozJpCyRrj/UbTkoKmSTrLX7GW+A616ccv7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UHyQ6+RU; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e03a0faee1eso5687837276.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 18:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721179522; x=1721784322; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=db9MQNUkHGqFxH0dNVRfvWIPRPmLM4mkmoBNBUFlvik=;
        b=UHyQ6+RUii2knX6wMhxXqQnl++OmvmePeHGgKOv0wvwXzyG9Kp6Lc1knoefaonh8ov
         1Bvds8XtEmndu6Z9v2RDvGKiQowzDwcKHBmJTWkSsFn+KqslGDk+lzKe5phdC8vhhfgI
         YtVSnpC1Vw533H3ippCWkM+8x1GNQVAl/n6s8ToNAnbxOsaINFKJco9BBVlaqQUpPt3Z
         alm0SDFwqwy9r/FAxO3hLjZv2xErp8qZ0zygHDvV9ai6AaHWw8bixjtfzx18nNZVVNhw
         5+notVQwIUjQDcNvTCFRHive/nyCGApPb23WqcSgSfhlnkeVYeHKAXPLQkEcmtRR2GBv
         3C0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721179522; x=1721784322;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=db9MQNUkHGqFxH0dNVRfvWIPRPmLM4mkmoBNBUFlvik=;
        b=gTtoSuaddH22m3zsAJ7P0Ek26ewAenE8OyHOHmH6UHqHxwur0jeMNcRMRZ89gCQsGp
         U3dCxmVyQodDubotDEiT0nf/E/zGQOfdXJn5XPi2qiep+9rkVzH5CM1W7P5ghUHSIZ6S
         TksqoUDyAXj4g+E7QEPCo/h8fcZkbHigHxVcVFw+2k22dvKHQl2Q7mrt7WslA6Pm2hRB
         D9V451lGV9yXWDyCJr47atGb5Z/0TGZrMD6fZyIHKqDlenPatfmtBZRcIyU2a0I3lApN
         gwhkSivftXKlhWfV2UT3ypwY4bohrkJVfttpgpyiRLrHBbpeMRNh9c4YSXKx04W9aT9r
         3WDA==
X-Forwarded-Encrypted: i=1; AJvYcCVtciqcYyFn23Jk7cnZJKnsOYnVkZuMgKQ1UYifmgu6j+yfEBVSm2e38A6oryFyu9kE17CBtWXuBQEIpR78JAxedT1tbP4bZBzbqDE4
X-Gm-Message-State: AOJu0Yz0yDhk59mWvFMiDqY21VAU7XRrI5yhUt4pJBkXmBbB1PYhO/WO
	j392w6nm3BBHn9OD7KmJZ6MyuyodkoquzKaXnJXh/8eEvosK4oS3EmIACFtbvuMbh8atz9E/eYJ
	1L2payyOxPMnT4fB+tduA64SoY4injxnnAU6Y
X-Google-Smtp-Source: AGHT+IHq3+u2wCg3FTo9mhc2bb/++TKpjchuoRgbAcRjLqo6T3Sky7AZIlM17vdyA4QbBhRN6EvL6EuzVPUJD4hYY5w=
X-Received: by 2002:a05:6902:2b88:b0:e03:b2e6:2c00 with SMTP id
 3f1490d57ef6-e05ed6e4724mr319079276.14.1721179521393; Tue, 16 Jul 2024
 18:25:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240717011631.2150066-1-surenb@google.com>
In-Reply-To: <20240717011631.2150066-1-surenb@google.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 16 Jul 2024 18:25:08 -0700
Message-ID: <CAJuCfpE6pWySZ6d-6T1Wh2uBTQ8bNKEu-gxByA414emhy5e2Ng@mail.gmail.com>
Subject: Re: [PATCH 1/2] alloc_tag: export mem_alloc_profiling_key used by modules
To: akpm@linux-foundation.org
Cc: kent.overstreet@linux.dev, hch@infradead.org, vbabka@suse.cz, 
	pasha.tatashin@soleen.com, souravpanda@google.com, keescook@chromium.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 16, 2024 at 6:16=E2=80=AFPM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> Export mem_alloc_profiling_key as it is used by modules (indirectly via
> mem_alloc_profiling_enabled()).
>
> Fixes: 22d407b164ff ("lib: add allocation tagging support for memory allo=
cation profiling")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202407080044.DWMC9N9I-lkp@i=
ntel.com/
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

This patchset should replace
https://lore.kernel.org/all/20240711204626.1669138-1-surenb@google.com
patch which was objected to by Christoph. I think this version should
be acceptable.
Thanks,
Suren.

> ---
>  lib/alloc_tag.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/lib/alloc_tag.c b/lib/alloc_tag.c
> index 81e5f9a70f22..832f79a32b3e 100644
> --- a/lib/alloc_tag.c
> +++ b/lib/alloc_tag.c
> @@ -15,6 +15,7 @@ EXPORT_SYMBOL(_shared_alloc_tag);
>
>  DEFINE_STATIC_KEY_MAYBE(CONFIG_MEM_ALLOC_PROFILING_ENABLED_BY_DEFAULT,
>                         mem_alloc_profiling_key);
> +EXPORT_SYMBOL(mem_alloc_profiling_key);
>
>  struct allocinfo_private {
>         struct codetag_iterator iter;
>
> base-commit: 0434dbe32053d07d658165be681505120c6b1abc
> --
> 2.45.2.993.g49e7a77208-goog
>


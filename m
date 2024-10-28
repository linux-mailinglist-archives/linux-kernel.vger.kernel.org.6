Return-Path: <linux-kernel+bounces-385635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9043F9B39B0
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 19:54:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F67C1F22F10
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 18:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 794281DFE13;
	Mon, 28 Oct 2024 18:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PnN2vto5"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68031DF26E
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 18:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730141632; cv=none; b=iymxkv5ODoqV9Xl74p/RF6R215dfroIV57mD6jo2KR2YmhWOijtezZfHD+eVZi6Cfb1zpiSIH3QznfeI7PFVBx5Kgn+coCrSIKyoOPYOux24gcm63l6AfsJfBerMmLxj6fMEhohXuXokZOf+XY+Ug9zRPRA652RexGT3gqjmweM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730141632; c=relaxed/simple;
	bh=eS7+S3uqQ1XNiG9hyOSvVSRouF8aWgkjZ3B3kF35MWQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nc5TGhzFLlD7AO83i9HtS3sruVjEetH7sUNxXTht9jIdMtEYG57H853WaHz04xJpjgsHfmm/saaWYzpHCVewSutbud7XwQxh5OGkR9/wfl7goItPOM6L8GKr/n3RwEoT2QQW3sfYEz+yh+zKKsO+o5AuVI4BqM2+iqQKhsthgek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PnN2vto5; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4608dddaa35so53711cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 11:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730141630; x=1730746430; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0WYzRLqjtoNVpnvujNH3r86fmSnTKoOusQ6Ao6DO1IE=;
        b=PnN2vto5hrVXpurt9webFiWmCYEql2f5L2QyypHoIJmOs4f9QyO6jn5xC9joG5HxBe
         xfDhqv61SYos+Kqdh2Gut8qEx6qd2Uzmdpp29SIlthUfOxmnwM2ryBavv+eUEOMSz/8a
         sewKT1I5OFhUiJvn8SnliOTrAyoY6hu/+d+hYgNLf6IoZKRQPxLavoUFyi2y+01q5iO1
         S8K0Ev+b7w1dS8ACAd4Ag5MawEDFyYd1e/dWlRpMwxrl5Xg3OnFWzz8wR4pWBUyh9gt1
         t5bjA2JCQ0q6nH6CbP41zRvvJj926viEf+67tmSe81LtBcaAIXkLUHvJDcExvsdgHw4j
         E/Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730141630; x=1730746430;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0WYzRLqjtoNVpnvujNH3r86fmSnTKoOusQ6Ao6DO1IE=;
        b=kR4CUfLOSy71bPZeU9BG71Jq57cinrTKJCh2Fic5LLwNA4yt1W/qSFHOoDo7mKYlvY
         2NCT/sexmOI4615EAW/oO5unSLwKhmFeKiZ9lP6YWqOgG204sMUjNR0mSQ3/byHNFHZf
         ULSMzEpT7gSRDMb+aCZcPm8lf5mBrOfdckO7XH226J2FfglccYb8AFSgKTKOREA0qnoS
         GkFKe8txEPfLJaaf9jyspN7kYSMV4LlYAXZTfOzOPLXllLDZA3qHrIrUuGTnJBncX1jw
         gQ1bLy/LJElxagWf/IOydXazjKgdFyQOqIUlUl/k6Gwbb7VrRT81PtsVkIjwELutK/q2
         SuvQ==
X-Forwarded-Encrypted: i=1; AJvYcCXgnxyZvbKrRgHDuCqn8rewB8KOXxT7x4b4H+XxdUHXkGYA+CsLLhxZe5cHR+H7oaH3VBCfcmNUJH0jsLE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyZ92SVseRssUgIPHnGCZP1HCZfn8q6CYCISEgEX5aWGAjqzlt
	ROz2BkXHIVCT5kthKXo1HJkiM6uiAtVhtsv2sWxv8ZbjvKh6wNl+CicRfIyIwrV4Md2r0oNU5nD
	GpD+QKbGOsmBrOAO35yNAHJF5xS6hVWzSbouS
X-Google-Smtp-Source: AGHT+IHOcJzO/GxOF61GZqPQpmPwZnfinL5k+ypLPUEksqRc2JZLbUVkl/3HRPaq20wnCeXp5eLhCJB+1QFa+hA9KW0=
X-Received: by 2002:a05:622a:5d3:b0:460:4aa1:78d6 with SMTP id
 d75a77b69052e-46164fcea00mr456441cf.20.1730141629162; Mon, 28 Oct 2024
 11:53:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241028150355.2574425-1-arnd@kernel.org>
In-Reply-To: <20241028150355.2574425-1-arnd@kernel.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 28 Oct 2024 11:53:38 -0700
Message-ID: <CAJuCfpFqTBnY10HUzBf3Xbqg0iAe2-=GegU4RSpysBgXX9+H9w@mail.gmail.com>
Subject: Re: [PATCH] [v2] alloc_tag: hide execmem_vmap() on !MMU
To: Arnd Bergmann <arnd@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Arnd Bergmann <arnd@arndb.de>, Mike Rapoport <rppt@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Song Liu <song@kernel.org>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 28, 2024 at 8:04=E2=80=AFAM Arnd Bergmann <arnd@kernel.org> wro=
te:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> The newly added function fails to link on nommu kernels, but is also
> not needed there:
>
> ld.lld-20: error: undefined symbol: __get_vm_area_node
> >>> referenced by execmem.c
> >>>               mm/execmem.o:(execmem_vmap) in archive vmlinux.a
> >>> referenced by execmem.c
> >>>               mm/execmem.o:(execmem_vmap) in archive vmlinux.a
>
> Move it into the #ifdef block along with execmem_vmalloc().
>
> Fixes: 57bc3834fb6f ("alloc_tag: populate memory for module tags as neede=
d")
> Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Sorry, replied to your older version. Copying here:

Thanks for the fix but execmem_vmap() is used if
CONFIG_MEM_ALLOC_PROFILING=3Dy. Please give me an hour to post a fix
dealing with that.

> ---
>  mm/execmem.c | 32 ++++++++++++++++----------------
>  1 file changed, 16 insertions(+), 16 deletions(-)
>
> diff --git a/mm/execmem.c b/mm/execmem.c
> index 5c0f9f2d6f83..317b6a8d35be 100644
> --- a/mm/execmem.c
> +++ b/mm/execmem.c
> @@ -64,6 +64,22 @@ static void *execmem_vmalloc(struct execmem_range *ran=
ge, size_t size,
>
>         return p;
>  }
> +
> +struct vm_struct *execmem_vmap(size_t size)
> +{
> +       struct execmem_range *range =3D &execmem_info->ranges[EXECMEM_MOD=
ULE_DATA];
> +       struct vm_struct *area;
> +
> +       area =3D __get_vm_area_node(size, range->alignment, PAGE_SHIFT, V=
M_ALLOC,
> +                                 range->start, range->end, NUMA_NO_NODE,
> +                                 GFP_KERNEL, __builtin_return_address(0)=
);
> +       if (!area && range->fallback_start)
> +               area =3D __get_vm_area_node(size, range->alignment, PAGE_=
SHIFT, VM_ALLOC,
> +                                         range->fallback_start, range->f=
allback_end,
> +                                         NUMA_NO_NODE, GFP_KERNEL, __bui=
ltin_return_address(0));
> +
> +       return area;
> +}
>  #else
>  static void *execmem_vmalloc(struct execmem_range *range, size_t size,
>                              pgprot_t pgprot, unsigned long vm_flags)
> @@ -368,22 +384,6 @@ void execmem_free(void *ptr)
>                 vfree(ptr);
>  }
>
> -struct vm_struct *execmem_vmap(size_t size)
> -{
> -       struct execmem_range *range =3D &execmem_info->ranges[EXECMEM_MOD=
ULE_DATA];
> -       struct vm_struct *area;
> -
> -       area =3D __get_vm_area_node(size, range->alignment, PAGE_SHIFT, V=
M_ALLOC,
> -                                 range->start, range->end, NUMA_NO_NODE,
> -                                 GFP_KERNEL, __builtin_return_address(0)=
);
> -       if (!area && range->fallback_start)
> -               area =3D __get_vm_area_node(size, range->alignment, PAGE_=
SHIFT, VM_ALLOC,
> -                                         range->fallback_start, range->f=
allback_end,
> -                                         NUMA_NO_NODE, GFP_KERNEL, __bui=
ltin_return_address(0));
> -
> -       return area;
> -}
> -
>  void *execmem_update_copy(void *dst, const void *src, size_t size)
>  {
>         return text_poke_copy(dst, src, size);
> --
> 2.39.5
>


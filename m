Return-Path: <linux-kernel+bounces-385798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA4C49B3BDC
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 21:35:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 115CC1F22D60
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 20:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EBFC1FF61C;
	Mon, 28 Oct 2024 20:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R3nLJBi7"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C4F192B6F
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 20:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730147495; cv=none; b=lR2L/Ualmy7lH+4h1a55VeEeiwjNQNq7hac5o6VOnlM8s7gy0JK8WlM3DW+L/a2HF3L4m5LGyKiNc3Mb1FXsF33kz0etQGNv0c4cgfgJj/xA7vpbYMMdbZhHZA6WxIkdTUu6t1yXwXYmJ4sPA9df9FWI45rKiCi7SiMlh7vr8RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730147495; c=relaxed/simple;
	bh=QGKXTG4XFA+OPISeaq6IAhrVGh0Ky8hF8DWgzxsNA/0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uX3YJHiTWrJDXOsosnbb6juwnPAGy3Nrw8QJqXXYCuQ0qJc3Vf35A7RaqvT4rPDFlpsILfRE/jhL3WXbbeHJVMb4c+J/MZAqdzknpEAuFTb+s8DENHwxAEOHmFeaaCLLOG1rf6cBmbH/JJ70WlhZA98cr/M8OBYkiHitfHTEZwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R3nLJBi7; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4608dddaa35so16901cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 13:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730147492; x=1730752292; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GF9szpIXKk0pyaUuLvU1W3Er0NYdTC6TQkwxbtHT3qA=;
        b=R3nLJBi71EO7rsF3GktBFhc8kGOo5FbY0TI0viVzebW70G2e3J/yRoODslvNG4O5Op
         bH20M8WpE3XOhfAMFDgI75WFYaFS6cK4gKIEcKeFMPtOBd/ptNa/ISsdQeq126Mc1Kui
         ugiPTPitApHJfi94NmFKD2yr2deaVXXol2ybcEpmIVv0dl+YBC7AkaqXW3jH2dUxChKF
         MfqdVm6pmxdy/9j3lUQfWcqnpVjuKiRHcwIPoqR3UnQRvIVse7Rt6TyKRwC1Dt444U7C
         Ze1kqDWCMJoLyFkir/kRbhYqlDNur2fDXhjUEXiDWLAfF1YfJW8ZIlVGj0NgtXzRljpL
         vXtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730147492; x=1730752292;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GF9szpIXKk0pyaUuLvU1W3Er0NYdTC6TQkwxbtHT3qA=;
        b=RMBjHAbTQ58jqcUSibDDYZ1/oJVTlb0XwL0yWQTRl/wOA/gJJYnPZh0PSI5aMgSkm7
         u2Jo3c1VR4VAWlLw/G0XJUEFvoL4hFNshjgJSa7Dvyt0N13yf8piizENQdTaNE/Xr+ZE
         5TXTJb9lKQmDJVZAyC6CmeOH8I3hA+1lfmc17lN1Wi7qEJ/5/+R1RduMilXGs6oEPvxR
         FcUNecWXBJQ7D+sUH6ZTVh2gfgxKt/kPVb39ICN5LGmpVC/zmZwOOnrHsPfqW4xBUnsh
         5GXSDMWzbdjqTS/nW6RHgVTeuREjxKkEmfdinLrz9KvGJx4YmGtDvDKiIm018MH0iMZz
         GyQA==
X-Forwarded-Encrypted: i=1; AJvYcCV+SwJ50oeJKMGPTH/aChbslB2xWKev0XUm6u8kvTAPiXvSJGXUY6tzERZTIbA5w5YKr+dnR5wSuN2kJ1s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjaGSPAnpSddZLRwfIFjZfmLJR5tZsfqRJMQ/c7ErB6dOBBG4L
	vPsIGtgKi/RgDS0DYQI3Mps+pPQU45hiJpZuRVCYpPN4gylFgXA63uTwcUwTOuv6SZv+My+EIRi
	G8FhtggzGLSmOrgDwyKelIbm5YPj4jgg7BaibX4SWzC875EChNlXv
X-Google-Smtp-Source: AGHT+IH6yxdE5IoaMRqlwrn/esRQWarNZbvXXwHdwnnJHhhuSxHtnyb3KLF9645D/axo9a50SE4ORUKnduqqGEtVX+M=
X-Received: by 2002:ac8:5f8e:0:b0:461:4467:14c7 with SMTP id
 d75a77b69052e-46164d96892mr897831cf.0.1730147492009; Mon, 28 Oct 2024
 13:31:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241028150355.2574425-1-arnd@kernel.org> <CAJuCfpFqTBnY10HUzBf3Xbqg0iAe2-=GegU4RSpysBgXX9+H9w@mail.gmail.com>
In-Reply-To: <CAJuCfpFqTBnY10HUzBf3Xbqg0iAe2-=GegU4RSpysBgXX9+H9w@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 28 Oct 2024 13:31:19 -0700
Message-ID: <CAJuCfpFyERAN40UAsKqugODBX=G+s+87w0LiBgWP2nUqdboh3g@mail.gmail.com>
Subject: Re: [PATCH] [v2] alloc_tag: hide execmem_vmap() on !MMU
To: Arnd Bergmann <arnd@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Arnd Bergmann <arnd@arndb.de>, Mike Rapoport <rppt@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Song Liu <song@kernel.org>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 28, 2024 at 11:53=E2=80=AFAM Suren Baghdasaryan <surenb@google.=
com> wrote:
>
> On Mon, Oct 28, 2024 at 8:04=E2=80=AFAM Arnd Bergmann <arnd@kernel.org> w=
rote:
> >
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > The newly added function fails to link on nommu kernels, but is also
> > not needed there:
> >
> > ld.lld-20: error: undefined symbol: __get_vm_area_node
> > >>> referenced by execmem.c
> > >>>               mm/execmem.o:(execmem_vmap) in archive vmlinux.a
> > >>> referenced by execmem.c
> > >>>               mm/execmem.o:(execmem_vmap) in archive vmlinux.a
> >
> > Move it into the #ifdef block along with execmem_vmalloc().
> >
> > Fixes: 57bc3834fb6f ("alloc_tag: populate memory for module tags as nee=
ded")
> > Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> Sorry, replied to your older version. Copying here:
>
> Thanks for the fix but execmem_vmap() is used if
> CONFIG_MEM_ALLOC_PROFILING=3Dy. Please give me an hour to post a fix
> dealing with that.

The fix that will work with CONFIG_MEM_ALLOC_PROFILING is posted at
https://lore.kernel.org/all/20241028202935.1047017-1-surenb@google.com/

>
> > ---
> >  mm/execmem.c | 32 ++++++++++++++++----------------
> >  1 file changed, 16 insertions(+), 16 deletions(-)
> >
> > diff --git a/mm/execmem.c b/mm/execmem.c
> > index 5c0f9f2d6f83..317b6a8d35be 100644
> > --- a/mm/execmem.c
> > +++ b/mm/execmem.c
> > @@ -64,6 +64,22 @@ static void *execmem_vmalloc(struct execmem_range *r=
ange, size_t size,
> >
> >         return p;
> >  }
> > +
> > +struct vm_struct *execmem_vmap(size_t size)
> > +{
> > +       struct execmem_range *range =3D &execmem_info->ranges[EXECMEM_M=
ODULE_DATA];
> > +       struct vm_struct *area;
> > +
> > +       area =3D __get_vm_area_node(size, range->alignment, PAGE_SHIFT,=
 VM_ALLOC,
> > +                                 range->start, range->end, NUMA_NO_NOD=
E,
> > +                                 GFP_KERNEL, __builtin_return_address(=
0));
> > +       if (!area && range->fallback_start)
> > +               area =3D __get_vm_area_node(size, range->alignment, PAG=
E_SHIFT, VM_ALLOC,
> > +                                         range->fallback_start, range-=
>fallback_end,
> > +                                         NUMA_NO_NODE, GFP_KERNEL, __b=
uiltin_return_address(0));
> > +
> > +       return area;
> > +}
> >  #else
> >  static void *execmem_vmalloc(struct execmem_range *range, size_t size,
> >                              pgprot_t pgprot, unsigned long vm_flags)
> > @@ -368,22 +384,6 @@ void execmem_free(void *ptr)
> >                 vfree(ptr);
> >  }
> >
> > -struct vm_struct *execmem_vmap(size_t size)
> > -{
> > -       struct execmem_range *range =3D &execmem_info->ranges[EXECMEM_M=
ODULE_DATA];
> > -       struct vm_struct *area;
> > -
> > -       area =3D __get_vm_area_node(size, range->alignment, PAGE_SHIFT,=
 VM_ALLOC,
> > -                                 range->start, range->end, NUMA_NO_NOD=
E,
> > -                                 GFP_KERNEL, __builtin_return_address(=
0));
> > -       if (!area && range->fallback_start)
> > -               area =3D __get_vm_area_node(size, range->alignment, PAG=
E_SHIFT, VM_ALLOC,
> > -                                         range->fallback_start, range-=
>fallback_end,
> > -                                         NUMA_NO_NODE, GFP_KERNEL, __b=
uiltin_return_address(0));
> > -
> > -       return area;
> > -}
> > -
> >  void *execmem_update_copy(void *dst, const void *src, size_t size)
> >  {
> >         return text_poke_copy(dst, src, size);
> > --
> > 2.39.5
> >


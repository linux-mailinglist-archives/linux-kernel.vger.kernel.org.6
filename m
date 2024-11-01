Return-Path: <linux-kernel+bounces-391466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A42049B8786
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 01:14:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B672F1C21028
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 00:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04087211C;
	Fri,  1 Nov 2024 00:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lnaya2eI"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A704380
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 00:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730420056; cv=none; b=MOeeosBYSKpfqGI/mwLPCeTYxJKqAfoKUF1BSfPoJrhkiWblgEkI0eigPGX/x9Ml44LXYMkfnWQC+qB8FhYv23IHaN4y7iT0FjtT10+mUBT6wCp2/vd8+lxVH0Qf8t/ov071Mydep1xjUplXYFse58dgD6EsQJMWh2pLQ4odXNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730420056; c=relaxed/simple;
	bh=vKY7d9+2COamoB8XhNGVEVovtGY7P7ZNGhIeg7VzkJw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sRGydE8oRez2a5u5ReTNx21log7Y1KrazewO1vfmYaPLbX7reHHGWS+zZwU7hKO2/gmn/8Ac+WZB8KClpo9X82XbYiqs6p5u3W9LeDfCFOETM6CKjJ0btT3hrGB0b3XRKq8cU1FSlUWibnSOvpeRSe0IDaLnNS25EXKeZo0Qwps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lnaya2eI; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-460a8d1a9b7so62781cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 17:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730420049; x=1731024849; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gDJhXEmGr1M/HN6h03M51446H+AHW6BogDU2GvRtVHY=;
        b=lnaya2eIwqqtsWwEDoeu/hjzlIsSVxpvUEs7GZwK9InsumgV2EJYsZGpee6zoT25Cb
         KGGrgu7dJ+IwFi/L7RvsEQwQAENom/bYyyzUzqUTm8BWwMBsRZ0RABZMI5kYgp2Fzyps
         6nEsdGvcKTV15Gfrj1NGlp7sB5v83tEsxxcdhvx3vtbcCDSexnMlyDcu3xGzhCtdXRYo
         7ss5cJ/jQztXaKmMCU9twgwiXBFrW56u2S9mawTiUjMLlzdiPPw/byIx+FbhKHq9kiTz
         KBxDqt5vyMwWpc93AZTv7Ut49uZWuqKPPuqjeeBG5fEAt0dL/CL9HIf8UgaYHJIWMPhP
         H6eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730420049; x=1731024849;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gDJhXEmGr1M/HN6h03M51446H+AHW6BogDU2GvRtVHY=;
        b=RraIZHPq638PmiKoUV7GjXcKgrKCDiJF/S3igMBi4PNrPptklr9cd5tDtaVrxAJRka
         tskZ1svgtBLu6dXZrS9ZvyGnG8mAjcaDthXVgu/NAC7i8KQNFq1Pu9NQIl+/86IVBnbq
         Uuj9Vun10+o2ckZALY7moy+o/Te3i8CtXUonJdJEqYxqtAjhXa7GB7apYFvZ67N4SouC
         q8/PKXY/kixU4qMKLj/nLizYMK4rLrtPCt7jW99OxuiCQNUbISXQmBePgR6VsySMwNCS
         n4onczlB4TPgI6ht8PeBKCwbRSnN1G7IITaOm3Cbo9J4zfm9cEDaawdcQoPoeK4KJr6n
         OWsA==
X-Forwarded-Encrypted: i=1; AJvYcCU1VCSuCMclNljIJxc+lysPKHoJ8aPS58ecXZUVX5NVxrAsasSP5BkgCqq3EDqhVcSsvHdD/J3Gwd3lEuI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNgD9C4M7Xz6O7IAi58hHb+P0IDU5+uVTBkOQJUe3ebMIdsI5B
	BgHOSaaPZmAV58oeG3xOlAMIo7tOupVjf7Mqh0WLayLByNZlX0EsrWsjVi5PHEOSOhecLSeHrYE
	uGIQ9KG8f9d69jKdgBnftUgUuR/oP6IhTXoUh
X-Gm-Gg: ASbGncuKOQ8v++Ct5PCCqUzxUAiTySkWBeVO1nvjyMBgOR0UXGiZFlGOHlGNS2OScWw
	0o16YyuzY32LxSuC5/Xb5Ds+d47k/Fwk=
X-Google-Smtp-Source: AGHT+IGn/0z3SSIWnwroupLQbYlOwmQT+qm7h63zxWeTpVdmBEtPlDixbl8Mxme95HJO4jGzsyI8c3SZosyYXn+zvm0=
X-Received: by 2002:ac8:5748:0:b0:460:46a8:9e67 with SMTP id
 d75a77b69052e-462aba3818cmr5571951cf.10.1730420049098; Thu, 31 Oct 2024
 17:14:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241101000017.3856204-1-surenb@google.com>
In-Reply-To: <20241101000017.3856204-1-surenb@google.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 31 Oct 2024 17:13:58 -0700
Message-ID: <CAJuCfpGiFDPArB-3_oTvuMSy3=MVQWFW2K8f-k+M9G2EA0L+Mw@mail.gmail.com>
Subject: Re: [PATCH 1/1] alloc_tag: fix empty codetag module section handling
To: akpm@linux-foundation.org
Cc: kent.overstreet@linux.dev, dan.carpenter@linaro.org, rppt@kernel.org, 
	mcgrof@kernel.org, petr.pavlu@suse.com, samitolvanen@google.com, 
	da.gomez@samsung.com, yuzhao@google.com, souravpanda@google.com, 
	pasha.tatashin@soleen.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 31, 2024 at 5:00=E2=80=AFPM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> When a module does not have any allocations, it's allocation tag section
> is empty and codetag_alloc_module_section() returns NULL. However this
> condition should never happen because codetag_needs_module_section() will
> detect an empty section and avoid calling codetag_alloc_module_section().
> Change codetag_alloc_module_section() to never return NULL, which should
> prevent static checker warnings. Add a WARN_ON() and a proper error
> reporting in case codetag_alloc_module_section() returns NULL, to prevent
> future codetag type implementations from returning NULL from their
> cttype->desc.alloc_section_mem() operation.
>
> Fixes: 61c9e58f3a10 ("alloc_tag: load module tags into separate contiguou=
s memory")
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/all/50f12fa1-17c1-4940-a6bf-beaf61f6b17a@=
stanley.mountain/
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

Andrew, I was going to respin v5 of my patchset and include all these
small fixes in it but it's a bit tricky because I would have to revert
another unrelated patch [1] from mm-unstable which refactors relevant
code. So far the fixes are rather small, so I think you should not
have much trouble folding them into the original patchset when the
time comes, but if that becomes a problem I can prepare a new version.

[1] d0d77a256a75 ("mm/codetag: uninline and move pgalloc_tag_copy and
pgalloc_tag_split")

> ---
>  kernel/module/main.c | 4 ++++
>  lib/alloc_tag.c      | 2 +-
>  lib/codetag.c        | 2 +-
>  3 files changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index 129c98e6380d..00c16f5c5568 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -2316,6 +2316,10 @@ static int move_module(struct module *mod, struct =
load_info *info)
>                 if (codetag_needs_module_section(mod, sname, shdr->sh_siz=
e)) {
>                         dest =3D codetag_alloc_module_section(mod, sname,=
 shdr->sh_size,
>                                         arch_mod_section_prepend(mod, i),=
 shdr->sh_addralign);
> +                       if (WARN_ON(!dest)) {
> +                               ret =3D -EINVAL;
> +                               goto out_err;
> +                       }
>                         if (IS_ERR(dest)) {
>                                 ret =3D PTR_ERR(dest);
>                                 goto out_err;
> diff --git a/lib/alloc_tag.c b/lib/alloc_tag.c
> index 1c74942e6dfd..00ab18ea452a 100644
> --- a/lib/alloc_tag.c
> +++ b/lib/alloc_tag.c
> @@ -437,7 +437,7 @@ static void *reserve_module_tags(struct module *mod, =
unsigned long size,
>
>         /* If no tags return NULL */
>         if (size < sizeof(struct alloc_tag))
> -               return NULL;
> +               return ERR_PTR(-EINVAL);
>
>         /*
>          * align is always power of 2, so we can use IS_ALIGNED and ALIGN=
.
> diff --git a/lib/codetag.c b/lib/codetag.c
> index 4949511b4933..42aadd6c1454 100644
> --- a/lib/codetag.c
> +++ b/lib/codetag.c
> @@ -244,7 +244,7 @@ void *codetag_alloc_module_section(struct module *mod=
, const char *name,
>  {
>         const char *type_name =3D name + strlen(CODETAG_SECTION_PREFIX);
>         struct codetag_type *cttype;
> -       void *ret =3D NULL;
> +       void *ret =3D ERR_PTR(-EINVAL);
>
>         mutex_lock(&codetag_lock);
>         list_for_each_entry(cttype, &codetag_types, link) {
>
> base-commit: 758db9ca0107bc6c00f0ed4808974d66c8dc2fea
> --
> 2.47.0.163.g1226f6d8fa-goog
>


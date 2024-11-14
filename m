Return-Path: <linux-kernel+bounces-409383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6887C9C8C34
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 14:54:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C82EB25BCD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 13:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B16E518028;
	Thu, 14 Nov 2024 13:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="auEM5454"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A5C171C9
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 13:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731591544; cv=none; b=koRnshjBpj9ptUX2OX6W0qb1RP1YarW6f9NKnI8eVFyaRxmczXmbswF0CQCe48gNNm3Helg5A5YN2panbVc/zR3BJVIPbDH5m00lhEyeJQQCV2Pdku2jUejgLDo4jfSEJSiKOWlmBCyARSrfGlGEsD7IR/xhtr+TexL2YCRapKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731591544; c=relaxed/simple;
	bh=3KSibIhh5D72qLuv7+J9ugRaTpaiOca/5e8P2qWxPfU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G5hgUwQauDUatNmRkk9QPOs+VQBfnLVb8rmy/WiAyNzMOPMldWjVIbF08j2xLX6A8m27TsJd2QpjdfiH0dHkz57QPlPjfa0OUX4+UOhbOj9IOZLfwjZxfI0i3BbLbw7LKrjSyLomLiwJ/bipkHnBJKrBZMnWXEDrEafoZmbTanY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=auEM5454; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-539e4b7409fso561284e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 05:39:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731591541; x=1732196341; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=plbMqImFhCJ0rUEwt/xe5Y/dkXS3RPMYT6mE75jOpVE=;
        b=auEM5454Mfac5QEExu45FsdTh5xnrX81g576Xr5PdPeOCobZMAXOjRNrw+5bvD298i
         cEGLZDIUicOSa8rXHkKiD702OljEamN7MWHQHefIuQQNg6rNOmDM34NJbgTN8+4ysc7q
         ZYRw7KA34lofju7aaTkwBUhNnpSvBfPoOBeVDjMJiYDqw6fcN2hChUJsCf+D9RKAeg/O
         Rg1D2kXiwZpkU6GJnGHt17r5RsguI57PGDVGG+IIZSawngN2Sv9Iu33ghEomP5+a37MG
         zNwHvb+iummuAv5/ma+NOuXOLlXu2vMpkRDLnKDE61mzOEy2irY89c2QzLjVcKOM8Khz
         1owg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731591541; x=1732196341;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=plbMqImFhCJ0rUEwt/xe5Y/dkXS3RPMYT6mE75jOpVE=;
        b=qnTNaQQADyKPma2l3hD4FyeWSRLKol2u0dmiyi5Gc40mhPGncMm/E1j2gqYC8+XGHb
         XoWZJCUhz9dwRfRmpL+W+yd3tLE6co+3PLFEi98l8b13p71lKFjzqNQJEY+JgX5efrGo
         sRsptslBQ6IOYIFeTywd5W8SvHjncD7y+i8fvSXOJK0VDJ7Z9BkzwsB/P4HA1Rx3/4NS
         bj9A8Fx1ciJwAwjQs9KcVTQ/+3uaEWwix1NzHka5hNya6gkjIXwGgPwVOg7/KiiEkXHw
         wqYy2/nB+vSKPR4Fh5fWTa4+2gjKlAUtqJyN34WFQYZnEBWmEt9/elTu3S6gKGorDypu
         4cOA==
X-Forwarded-Encrypted: i=1; AJvYcCV2n+MjEnNVwOeuZgLelaPjIUj2tQEOeW4qqYiNwGsclk/vza3PQKneodu3/4pZDL9e+DXNnjeZQqWnJFI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdNbV1P2Ux10Yd1pbv4SFfWDw44nMISZsBXCtwQ2/N0eguoiwm
	cLz0tewLJdMSD0qQdLl9OCLcWW7ao2vcDmwWqHKqRYIOWGctEu/NVCfm0y6/v6YeamA6dWo+yED
	YFoLSFvCkDkBk0uRD/lthg5vGwO0=
X-Google-Smtp-Source: AGHT+IEQJPPkaZenJ6oUItKeQ+Gc0nglFVvGLtAYAqzBmfCiIYqPyrENOvUqyilf8OxJD2ATIO6EG49gK5io82VJUDE=
X-Received: by 2002:a05:6512:4014:b0:53d:8c0d:8513 with SMTP id
 2adb3069b0e04-53da47a57cbmr1114776e87.8.1731591540635; Thu, 14 Nov 2024
 05:39:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241016154152.1376492-1-feng.tang@intel.com> <20241016154152.1376492-2-feng.tang@intel.com>
In-Reply-To: <20241016154152.1376492-2-feng.tang@intel.com>
From: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Date: Thu, 14 Nov 2024 22:38:47 +0900
Message-ID: <CAB=+i9TBMmq5EScWnNMHJAFqSxT3_wWkgJe20d3_w2D148gDVg@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] mm/slub: Consider kfence case for get_orig_size()
To: Feng Tang <feng.tang@intel.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, 
	Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>, 
	Joonsoo Kim <iamjoonsoo.kim@lge.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Andrey Konovalov <andreyknvl@gmail.com>, Marco Elver <elver@google.com>, 
	Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Danilo Krummrich <dakr@kernel.org>, Narasimhan.V@amd.com, linux-mm@kvack.org, 
	kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2024 at 12:42=E2=80=AFAM Feng Tang <feng.tang@intel.com> wr=
ote:
>
> When 'orig_size' of kmalloc object is enabled by debug option, it
> should either contains the actual requested size or the cache's
> 'object_size'.
>
> But it's not true if that object is a kfence-allocated one, and the
> data at 'orig_size' offset of metadata could be zero or other values.
> This is not a big issue for current 'orig_size' usage, as init_object()
> and check_object() during alloc/free process will be skipped for kfence
> addresses. But it could cause trouble for other usage in future.
>
> Use the existing kfence helper kfence_ksize() which can return the
> real original request size.
>
> Signed-off-by: Feng Tang <feng.tang@intel.com>
> ---

Looks good to me,
Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

>  mm/slub.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/mm/slub.c b/mm/slub.c
> index af9a80071fe0..1d348899f7a3 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -768,6 +768,9 @@ static inline unsigned int get_orig_size(struct kmem_=
cache *s, void *object)
>  {
>         void *p =3D kasan_reset_tag(object);
>
> +       if (is_kfence_address(object))
> +               return kfence_ksize(object);
> +
>         if (!slub_debug_orig_size(s))
>                 return s->object_size;
>
> --
> 2.27.0
>


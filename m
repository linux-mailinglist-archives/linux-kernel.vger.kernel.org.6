Return-Path: <linux-kernel+bounces-199516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3FD58D87FF
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 19:32:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EFC128B2CC
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 17:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C387137925;
	Mon,  3 Jun 2024 17:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="opYuUqrK"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF34136E28
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 17:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717435940; cv=none; b=mwpUdrEvdwdxMEOofhSyzMch/Db1dZrF1x4rHNKDJpF8obEYYe816s5twr8lkpZhkdUzLmHZC0uEf8+zkW9uQimtJjwfKuBxrTES1B5EMVqVg870SvWREnkySPBap9DXwJw6iKs1p1cGoASFDzN5y4oVA3qUQNH80IqUxkz1VcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717435940; c=relaxed/simple;
	bh=O6GhZotd2BYZDip5JDutiTFpsVWFbSZQ3i1oM5jDl/o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tK9ebUPD0cv4M5w6RIyQCV140GMt9KbypCAZLR22+UScR1BEb7wh4BnZCw+GjNT8DUBceb9DwuEwppfL47sg2zkv2pbYRRWAhnsHi/hg8BJu7pCBe+tV86wc9ZXdBDHbLhtDIwKwBKKXPte3QOistTPD2wFdm6ZmO5VaUS+wc/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=opYuUqrK; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42108856c33so27278265e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 10:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717435937; x=1718040737; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I6lZeLqXe3ejNVp6NkHTGb2agg9ZhMGoWIbA4FuiQCE=;
        b=opYuUqrKr/AS8k2ujbYCyKLJ4qNZwoSoXnSY9mwfj5D42Ysa12qJvSeBwNz2uxEVYn
         CEbn/mMrY38vZ2CLDSxFasJmkaziEYTvk4PPjYna1AIRB2ycy/MtnYouzFrRnnByAsJ8
         R654BfuxVdIOnSRsg1cmjJV/agsjqrme09qtYjAQEPLPPlgHG5meJhRlAE+OfAFQs/wg
         6rLae9ZN265E18yVgFUUsjFS1kDv1zJjM8U23sxNwRH37pNPNEaCEhfDhJuxUr0kHXAG
         qG8T8HWcj+NcJQQWKVLgFx29DcstJ47Q3O9SdqXNLVSakffYZW9EEptcBifvOfwX2CLy
         +eoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717435937; x=1718040737;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I6lZeLqXe3ejNVp6NkHTGb2agg9ZhMGoWIbA4FuiQCE=;
        b=AJVVIFctjgD36jhZ3V5B449GskTnIymBHQxqZDmbsdXQGcCFuf7u+scHrU2eszpktC
         WHMOgPJL+WnSfmo3UA5xhStYQxbdHx0OoEjyYPzlZDzwg61SJG876zIxxmuL1Tmr2Mhw
         GCEkC9E6WiBRQzxdzo3TPusSJEB5WoCjGACHkrlUQlVFASGqN1ggFAYDX4gp0PvE69WG
         dF3woAEhV7E7dfCVhHrjZ28ntmab3JJQU4+NYYJokHIFhvIDqhUrTcLDgD/jgAPtcU8T
         cieUB/k4sIXyQMwQ+O7D5S4pY1zlqmf3r2NFU4cVROZFr61jIJ9x9S/gMGmyoHuIxwfP
         WbZg==
X-Forwarded-Encrypted: i=1; AJvYcCXXP9D6aN+m2OURGPO1JBI3Py2dqVZwmgyCXS3am1qFtrusrTrAmnHdyBT5c1n1Ohl33y/aDF8CdiEnKpSRzGWqklNinIGkDVc0XfXY
X-Gm-Message-State: AOJu0YxUPVPXAnI/v9+4AIkJ7qEhZMkjkSeDd1ov0IxpLemcp+hNQ2QW
	cO7CUewidupz2fLSpAkI+r3ALR9SF4bh1Eo1ZORS03vWMI8RTJC0/5XatNLCsKKmmfRAnaT3vY1
	O7Wd+ZLWnL8VRXI7BPRphIo6zEGs8HygtY7yc
X-Google-Smtp-Source: AGHT+IHPBSr6Q08XNRaq9LIuJApuhMEdcTWJilasTuQLDU/lTHvec1E4BlQkV7G8xapO9IL44goXuhFn5/lUGnCOjHI=
X-Received: by 2002:adf:e3d1:0:b0:354:db90:6df4 with SMTP id
 ffacd0b85a97d-35e7c56ba79mr346084f8f.23.1717435936987; Mon, 03 Jun 2024
 10:32:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGFP0L+BaNAtCF7c7cJ1bvbjomp03Fy0=6=w6dj29Fnr0ygSCA@mail.gmail.com>
In-Reply-To: <CAGFP0L+BaNAtCF7c7cJ1bvbjomp03Fy0=6=w6dj29Fnr0ygSCA@mail.gmail.com>
From: Axel Rasmussen <axelrasmussen@google.com>
Date: Mon, 3 Jun 2024 10:31:38 -0700
Message-ID: <CAJHvVchjzxLVfg844SNjK9EWmC+yhVneGaf1vVscmjomH_aaow@mail.gmail.com>
Subject: Re: [PATCH] fix: Prevent memory leak by checking for NULL buffer
 before calling css_put()
To: Geunsik Lim <geunsik.lim@gmail.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, Ingo Molnar <mingo@elte.hu>, 
	Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Peter Zijlstra <a.p.zijlstra@chello.nl>, Hugh Dickins <hughd@google.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, Steven Rostedt <rostedt@goodmis.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 3, 2024 at 5:33=E2=80=AFAM Geunsik Lim <geunsik.lim@gmail.com> =
wrote:
>
> This commit addresses a potential memory leak in the
> `get_mm_memcg_path()` function
> by explicitly checking if the allocated buffer (`buf`) is NULL before
> calling the
> `css_put()` function. The prefix 'css' means abbreviation of cgroup_subsy=
s_state
>
> Previously, the code would directly call `css_put()` without checking
> the value of
> `buf`, which could lead to a memory leak if the buffer allocation failed.
> This commit introduces a conditional check to ensure that `css_put()`
> is only called
> if `buf` is not NULL.
>
> This change enhances the code's robustness and prevents memory leaks, imp=
roving
> overall system stability.
>
> **Specific Changes:**
>
> * In the `out_put` label, an `if` statement is added to check
>   if `buf` is not NULL before calling `css_put()`.
>
> **Benefits:**
>
> * Prevents potential memory leaks
> * Enhances code robustness
> * Improves system stability
>
> Signed-off-by: Geunsik Lim <leemgs@gmail.com>
> Signed-off-by: Geunsik Lim <geunsik.lim@samsung.com>
> ---
>  mm/mmap_lock.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/mm/mmap_lock.c b/mm/mmap_lock.c
> index 1854850b4b89..7314045b0e3b 100644
> --- a/mm/mmap_lock.c
> +++ b/mm/mmap_lock.c
> @@ -213,7 +213,8 @@ static const char *get_mm_memcg_path(struct mm_struct=
 *mm)
>         cgroup_path(memcg->css.cgroup, buf, MEMCG_PATH_BUF_SIZE);
>
>  out_put:
> -       css_put(&memcg->css);
> +        if (buf !=3D NULL)
> +                css_put(&memcg->css);
>  out:
>         return buf;
>  }

I think the existing code is correct, and this change actually
introduces a memory leak where there was none before.

In the case where get_memcg_path_buf() returns NULL, we *still* need
to css_put() what we got from get_mem_cgroup_from_mm() before.

NAK, unless I'm missing something.

> --
> 2.34.1
> ----
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


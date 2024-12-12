Return-Path: <linux-kernel+bounces-444043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC0519EFFF8
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 00:18:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25CED1888C0A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 23:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE1921DE3D8;
	Thu, 12 Dec 2024 23:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t5+s/8aV"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3921AC891
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 23:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734045496; cv=none; b=LvW3QrWKAIE4eCmR+NcDKJNfQhnGOSszQo8ib0eOVVPITYXBKU8IjUq5H/EN9okYxu0cSkTgics3hAg/cEEKLd4AT6bOEZMDF3YFJzOO2zlG6XHhYotuSLJv7CO0VuUMZjN6KaRX0DjHv2Vm/y/bh98z5Gc03JrxFAD8jc34z6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734045496; c=relaxed/simple;
	bh=RE27v71rDFO4U2xlFWx7xqoEPDOJQkdShgyiZkdcDYg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CJMDrRJVqppPpldgTasaM3plDSMVAI9s28+hdJazDJNUulkb+CQkjrTW7TRYzE0JcSc+FRO9YFDTm/zzDtRk7b1d8/kYCs5BYb2sZQf9hyn2R6ySoJBuQ520FLBTsJbkeieGR/qf3QV4e18GRvoPffHUcmP07GuTUAeuhgZqPh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t5+s/8aV; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4679b5c66d0so35741cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 15:18:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734045493; x=1734650293; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G37KeGVU6MeLruI7xGjEHGxgNFoI6KkR5tULmzViKWE=;
        b=t5+s/8aVsFcOuXiD4vqEo9MIJBHwwBpODCRcPKfYED/PE7+NbfOAxLcqdYh7Tw16Oe
         ch6F3jbVIJMCjLfFzjUJbbABOMEG16k5Z/OAD0QbC8kB+IbrQ2pYU8lDGggvwBFDh6pl
         qlOIgEPSTaUcjJV2F9/VzCeHFHmeVW3L4CfbGCKcJe1gFp22t+se/bZzuEkJ592R1Y/y
         cddnbxa/rBl501B0xgV+tVezSjigzcq3hOwIV3ww4LqwKsBmlu162sdoVkh/YFxIXuIV
         hnqzmqSEL7Acek7NdBWug5JNr2MtvA/MoBwgC0uiHYg+iianWphAimtpZXEjK+m8Fz8+
         0OVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734045493; x=1734650293;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G37KeGVU6MeLruI7xGjEHGxgNFoI6KkR5tULmzViKWE=;
        b=HsoucjWSZR7ZksqEMd6EsgDYgaFn9yDKCqFcrJD6i74W7lC2rgYn3x0Uzd5pubyu9d
         WghaUVwTzP+mHYXsABPgnugEeDVKRPuIhJE0Ir0mQ/i0T81X+8csPYDa4zsyYoakLi+l
         Ndq1uPIqHeJ/Q8stFvilKMMm62L4E/kgyD6V2039qZvY2m+UeqY6oDxgE1jZf/sPVhot
         NJtANBJaMykyUGj/yWOS7xpkpLa1KML6LDNJ0GtiWmRIONG3Za3nJyXR7E9KdLZyyN98
         NrpunzghFxQQGZzDWKYLQYlKCfX/wwfs33fv6O+mWPP32uwuiJABc+X6V7CDgqOOuZsr
         4gEg==
X-Forwarded-Encrypted: i=1; AJvYcCUHfQdZkZSxEs5v3XVVZZnlHtx5MRakIHaZ1cXCJUIuMhdQ0Co4aNO7dfe4U5m+6c78oGGWVWYR9x2ff7I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1FPEMeYy1eT4TDGGy1uMeAgxpLqCKbF3tIwTd/hHHYfC77aeN
	EWLN4hJRQZpJfvE3YmEzsXmxL6t9oiVfNf6yfPNzJ9A1L+9DwdyF95u0/z7wpUAcEqB3NreA/NN
	2sBkfXKEhyqwl4WOdy/DgX4GIkgNvQS+54rnO
X-Gm-Gg: ASbGncuPu6MSX8G8uMmtcUra645VUETEtulhMGqsJInShgH8JYaboNjuA1eJZhUlcrq
	hJIXhLoSpzPWgd96VeCpe7IbiZIGzGj3LIsFID4SVCSpYxuz5SH5xRyFUs16Q29Y88uTj
X-Google-Smtp-Source: AGHT+IHXbfzaYFKE9ku+DcAM7Ci5nnWCXllAeHKK+6mWf5Oyzgov9oKeDhH5wen2fbJZH5ZdLmfgxld+nyBk3WZixDA=
X-Received: by 2002:a05:622a:258a:b0:467:8416:d99e with SMTP id
 d75a77b69052e-467a59d2e1emr411601cf.21.1734045492400; Thu, 12 Dec 2024
 15:18:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJuCfpGJp-U3t_SHRhuSRTu7Hjkz23oqKSNbVL79O1OQhgJndw@mail.gmail.com>
 <20241212082910.30826-1-00107082@163.com>
In-Reply-To: <20241212082910.30826-1-00107082@163.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 12 Dec 2024 15:18:01 -0800
Message-ID: <CAJuCfpF2e7niEbR=nX2u0HZHq-7tjRGB=xV397pFpjdzBqUGfQ@mail.gmail.com>
Subject: Re: [PATCH v2] mm/codetag: clear tags before swap
To: David Wang <00107082@163.com>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, lkp@intel.com, 
	oe-lkp@lists.linux.dev, oliver.sang@intel.com, yuzhao@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 12, 2024 at 12:29=E2=80=AFAM David Wang <00107082@163.com> wrot=
e:
>
> When CONFIG_MEM_ALLOC_PROFILING_DEBUG is set, kernel WARN would be
> triggered when calling __alloc_tag_ref_set() during swap:
>
>         alloc_tag was not cleared (got tag for mm/filemap.c:1951)
>         WARNING: CPU: 0 PID: 816 at ./include/linux/alloc_tag.h...
>
> Clear code tags before swap can fix the warning. And this patch also fix
> a potential invalid address dereference in alloc_tag_add_check() when
> CONFIG_MEM_ALLOC_PROFILING_DEBUG is set and ref->ct is CODETAG_EMPTY,
> which is defined as ((void *)1).
>
> Signed-off-by: David Wang <00107082@163.com>
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202412112227.df61ebb-lkp@intel.com
> Suggested-by: Suren Baghdasaryan <surenb@google.com>

I didn't really suggest much in this patch, so please replace above
Suggested-by with:

Acked-by: Suren Baghdasaryan <surenb@google.com>

Thanks for fixing this!

> ---
>  include/linux/alloc_tag.h | 2 +-
>  lib/alloc_tag.c           | 7 +++++++
>  2 files changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/alloc_tag.h b/include/linux/alloc_tag.h
> index 7c0786bdf9af..cba024bf2db3 100644
> --- a/include/linux/alloc_tag.h
> +++ b/include/linux/alloc_tag.h
> @@ -135,7 +135,7 @@ static inline struct alloc_tag_counters alloc_tag_rea=
d(struct alloc_tag *tag)
>  #ifdef CONFIG_MEM_ALLOC_PROFILING_DEBUG
>  static inline void alloc_tag_add_check(union codetag_ref *ref, struct al=
loc_tag *tag)
>  {
> -       WARN_ONCE(ref && ref->ct,
> +       WARN_ONCE(ref && ref->ct && !is_codetag_empty(ref),
>                   "alloc_tag was not cleared (got tag for %s:%u)\n",
>                   ref->ct->filename, ref->ct->lineno);
>
> diff --git a/lib/alloc_tag.c b/lib/alloc_tag.c
> index 35f7560a309a..3a0413462e9f 100644
> --- a/lib/alloc_tag.c
> +++ b/lib/alloc_tag.c
> @@ -209,6 +209,13 @@ void pgalloc_tag_swap(struct folio *new, struct foli=
o *old)
>                 return;
>         }
>
> +       /*
> +        * Clear tag references to avoid debug warning when using
> +        * __alloc_tag_ref_set() with non-empty reference.
> +        */
> +       set_codetag_empty(&ref_old);
> +       set_codetag_empty(&ref_new);
> +
>         /* swap tags */
>         __alloc_tag_ref_set(&ref_old, tag_new);
>         update_page_tag_ref(handle_old, &ref_old);
> --
> 2.39.2
>


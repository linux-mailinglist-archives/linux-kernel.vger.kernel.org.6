Return-Path: <linux-kernel+bounces-400193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94DF79C0A27
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 16:33:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26F92283167
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 15:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E65D213158;
	Thu,  7 Nov 2024 15:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HMno9U1J"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5E029CF4
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 15:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730993608; cv=none; b=LfyY4ReFve3HDxrCiRjx/dmmWGBJsOc6pARLg2VMxXn0cwiMRD1Xnt0zTdtEVitxec6eH52HXiH5ILBpZXAh+Mp9Ha6lyhRdenxetedWub0bFVkvfg87FZDuQbZzkqGgnha8sPVNW+vLbSY5wpJi5T5xGe1OjPzAZawcU1Xkluo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730993608; c=relaxed/simple;
	bh=QqH4UmZGzFa+O6hRiXH1mntDJJlD9MM7SBq4uvxCNds=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t4AZ91iYMNf+Kzd2xuQlbBh0okdQaQWMJQH0H4KKqMSsOSJvQI9969U17WzPQCc5gIoskCYK/Od+luNLMa4Be015uGVut56R8EIBdmXkSMTh3Hsmghr6EUroaKBUEuyDeLzvRdwyEzJUVusfhsOcCQuAMtSVYyqPYebhHqzLHtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HMno9U1J; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4608dddaa35so354471cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 07:33:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730993606; x=1731598406; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oYFSj9j/G13LpC6FOywjJdeniNG1mGSLgzAIh/zOFJ0=;
        b=HMno9U1J8GQ6+PTnxB7lziuqiWgte8SYghvNcQdB3Et2Tj+tJPXwjH36I06WxhKKfU
         lBPPUX41QG+kCf6m6ng94dVkmbyFAw+W+RecSacqWTcsSAVHkx5e6Fkvhn8+0owNbBQv
         0b2ZB/73fPxzWHQMD/O0yQPp/3fq1eIL78Zbhw2VWP5sS5pOA4KFEWHj8NLOm/iqdR0S
         0Rsf8311D9fX3ET+X8mdBD+cZS8B4yj/NgKXO9ztyezuzEpfh/DVxrmDMVPUzAO5+AHi
         iyFeRocs3McgqtlxiSztvnhZBVmqSnqneXFOIl70RDR3C5BGwCuBppsFwmpmG7m5KCNz
         uEQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730993606; x=1731598406;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oYFSj9j/G13LpC6FOywjJdeniNG1mGSLgzAIh/zOFJ0=;
        b=NENcuJQ2IQfjzqfJg4NZlg1VQ8otMNRL9OIzoGvICo3ELqnpBxzVOL7W8nVISPPKoK
         LAlQ387t2xTidqBmh1ssHx6drjBpF7ciiB4n4dC5hqxmgEpXUtuC2IrHV34ay0dQ/wK1
         7P2Mgbwl/Jgd30KO3zCdDXwXdsTA9Qv8mgWiHqoUo0xMmQdU+CYrofjZMuAGWykCusAj
         s2RCRc1e9BUSVqznbckvFokhu17jtBRZy7+FrV4PM4bPW+wTrKsG+yOKmvFuDSW/ILbb
         qRwIki/dGCr3sM2Nf/XZC4oCQNKbRUsVs5YDKSVKBMtUEZbXxPjscZCqJBVWpl11Odk5
         y/Ug==
X-Forwarded-Encrypted: i=1; AJvYcCW2dXEeon0CciIhBNnA+Lfidis9bm+bQyKHFra+SUBD7b5cgSZaLx6R7Fw65JQfDkJ6NdsNPvhsdLcNqSs=@vger.kernel.org
X-Gm-Message-State: AOJu0YznTMxr0QObQbBKopcdoJ/oFgAgid2vFPeS2a2BwTamTuJiqoqn
	WQ0aRlvV+RYTN4ygMuH/UKLMNQ4GndPA72Y9U/V+SC7eDh1Tb8SzSLoRoyM8T5DwW9f+UCRuZC8
	UzCtmhYXGEOBgE6Bov5JM8FOR+VLY4eZW3H+f
X-Gm-Gg: ASbGncv6cDvjVbuP/RTRaVgy8C2L96TPv5/V7qQ67dTc+XGCUXN452gddxOW/pgBDUE
	U5V6mz50ihOkLddXmhkOloOkBSoRNo8AMh3HwJpnSMs4QZDV7Sc1kq8eXQGws
X-Google-Smtp-Source: AGHT+IESjzKHsF7QCTHsNVsuRot6YsG58SIS3kSm97zxwFuWtoo6jlxFhuQIcXjg06eU1tfA7GbtvDyQZ5G4uvqXAmQ=
X-Received: by 2002:a05:622a:14d4:b0:462:9e4:de13 with SMTP id
 d75a77b69052e-462fa58dddcmr5001921cf.9.1730993604706; Thu, 07 Nov 2024
 07:33:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107040239.2847143-1-cmllamas@google.com> <20241107040239.2847143-7-cmllamas@google.com>
In-Reply-To: <20241107040239.2847143-7-cmllamas@google.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 7 Nov 2024 07:33:13 -0800
Message-ID: <CAJuCfpG=zMHGGEw36dPHQs08iHmzNi5Ze5Rwcr85RqavsHP=cw@mail.gmail.com>
Subject: Re: [PATCH v2 6/8] binder: remove cached alloc->vma pointer
To: Carlos Llamas <cmllamas@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Christian Brauner <brauner@kernel.org>, 
	linux-kernel@vger.kernel.org, kernel-team@android.com, 
	Minchan Kim <minchan@kernel.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 6, 2024 at 8:03=E2=80=AFPM Carlos Llamas <cmllamas@google.com> =
wrote:
>
> All usage of the alloc->vma pointer has been removed from binder.
> Instead, paths has been refactored to use either vma_lookup() or the
> alloc->mapped state. Using the alloc->vma was unsafe and required the
> mmap_sem in exclusive mode, which caused several performance and
> security issues in the past.

nit: I think this can be safely squashed with the previous patch and
call it a replacement.

>
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Liam R. Howlett <Liam.Howlett@oracle.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Suren Baghdasaryan <surenb@google.com>
> Signed-off-by: Carlos Llamas <cmllamas@google.com>
> ---
>  drivers/android/binder_alloc.c | 14 --------------
>  drivers/android/binder_alloc.h |  3 ---
>  2 files changed, 17 deletions(-)
>
> diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_allo=
c.c
> index 7239b92ef20a..13b476cc5b62 100644
> --- a/drivers/android/binder_alloc.c
> +++ b/drivers/android/binder_alloc.c
> @@ -377,20 +377,6 @@ static void binder_lru_freelist_del(struct binder_al=
loc *alloc,
>         }
>  }
>
> -static inline void binder_alloc_set_vma(struct binder_alloc *alloc,
> -               struct vm_area_struct *vma)
> -{
> -       /* pairs with smp_load_acquire in binder_alloc_get_vma() */
> -       smp_store_release(&alloc->vma, vma);
> -}
> -
> -static inline struct vm_area_struct *binder_alloc_get_vma(
> -               struct binder_alloc *alloc)
> -{
> -       /* pairs with smp_store_release in binder_alloc_set_vma() */
> -       return smp_load_acquire(&alloc->vma);
> -}
> -
>  static void debug_no_space_locked(struct binder_alloc *alloc)
>  {
>         size_t largest_alloc_size =3D 0;
> diff --git a/drivers/android/binder_alloc.h b/drivers/android/binder_allo=
c.h
> index 89f6fa25c670..b9e2e9dc90b3 100644
> --- a/drivers/android/binder_alloc.h
> +++ b/drivers/android/binder_alloc.h
> @@ -61,8 +61,6 @@ struct binder_buffer {
>  /**
>   * struct binder_alloc - per-binder proc state for binder allocator
>   * @mutex:              protects binder_alloc fields
> - * @vma:                vm_area_struct passed to mmap_handler
> - *                      (invariant after mmap)
>   * @mm:                 copy of task->mm (invariant after open)
>   * @buffer:             base of per-proc address space mapped via mmap
>   * @buffers:            list of all buffers for this proc
> @@ -86,7 +84,6 @@ struct binder_buffer {
>   */
>  struct binder_alloc {
>         struct mutex mutex;
> -       struct vm_area_struct *vma;
>         struct mm_struct *mm;
>         unsigned long buffer;
>         struct list_head buffers;
> --
> 2.47.0.199.ga7371fff76-goog
>


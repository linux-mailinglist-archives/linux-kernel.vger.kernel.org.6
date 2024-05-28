Return-Path: <linux-kernel+bounces-192314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C28CE8D1B6F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 14:38:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 613871F2233E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 12:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4855C16D4EB;
	Tue, 28 May 2024 12:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="liblJAFs"
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14008502B9
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 12:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716899928; cv=none; b=Lbq8rM0MMwNeCl2CBoFgvd7sfXXDrYikrMfMq/BqkmuhiwI2pIn5IIujjicqgF88nPSsCdOzEbjb0laGZ9B+TKCyhn2XqY5Usk7HSlQLPnfRWm5hTvGUfj6RAN1etigXlObEBW7EGYzsWTl98/RW8NxwBI88V8egO/OKfD8+jZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716899928; c=relaxed/simple;
	bh=T0smRcebK1ec2lSC1dD+4TfYLvoGkMzOKr4xJ8hxjEc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EVSNL9xoLFoJwaAjg77WQJ/d5mID4PSiTi/YeRigFNSNbpMZaCGvve04UZALldFRgw0huiIvwRr6lTl6a/mozclWFtZSolp1985yiIVa/lx6G6ZWve0Aiet9aXUunlKxiB5zR/z9M990eFoJ+8W/int/GGsLuWOe0Bo7UklqDwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=liblJAFs; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-4e1c721c040so321150e0c.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 05:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716899926; x=1717504726; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=K2yOu7S394kYY/a0W/YaDXm8nhL73Hm/MC9DzzKzcks=;
        b=liblJAFsthmtOwtLC59DdUMNySRMHpCMLsqUTjVHJJzrb+s3+eQVPbSDYZ6HI6Zil5
         pxUeDoL3wiAeK73BWL7/SiR/+2cbeMuBglWp2ASywNKvpmnhmH3OQqenE1rjw6EASwRT
         77+2SzY7Q1UBHXm4U+bNZfh0UQZnLIQDdnH+6DVPzkMnohqcrmx7GVsbLNfgIZz1jAKm
         ruqyqwzcnaIkLHponnhVIhY+R1UB/JrYOib5b3BKZ+WREQf3J9JZHyJLFPkatrrDFT0y
         +0eLyi/wBzCyyLIpye6gz+wjJ9UfMsUPIt+cOuDdw31cfDAs8WXXUtZjpMyBrL/4d2sv
         gEuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716899926; x=1717504726;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K2yOu7S394kYY/a0W/YaDXm8nhL73Hm/MC9DzzKzcks=;
        b=PvJ31KI4ZcqlAybduHKyFtjfpBbx9NhmxWRYt1fEkzZIru5dyDtO1joNXzSjhNDNmv
         kILh+SAWw7tbe9P8E003A9H5Ye4faONAqyiT/jMnilWMMmurzsAk+QqoXNQeve5Qt0Tc
         dhXlJSj/RKGpplhxxZ4k/12oivABDwyTDY0a6zoDk0L5nA4iMQmHA84Dw3sg1so6yDxa
         V2FsQ3Rhhv6oJFXWLAcOXwBbGYtmEexL/xE6zADTFFApSNxCxxDkSaiEVHjuNAEQCnvZ
         4JGoX9oqypo0tQp+TJqCUip2CmfpBUohsHBT7npTRbg35SEuGZtfhH40SOcwdzM4GDJ/
         aMJw==
X-Forwarded-Encrypted: i=1; AJvYcCUpRwF6cAr6o2tLWGPc+3c0diiIbiKhn9NFViTCfSAMtTScp9Wz8c0NXFcFc50gOHmZb+Frz88mz12oea1PIl/9ByTiQJ00e14Yvzms
X-Gm-Message-State: AOJu0YwYzoi0pZUsFfeKNA0c8ya33eLci687WTDv7Ut7KchAXA3viZNn
	lqfONexVhudAvCutYaoEDQNQo8NTlvboABKZti32IDjvynl3B0FdM5kfczGz+SKBtBoBwgqt2fs
	ROCdoDUyuNzLCN5iz0yGrmsWmzg3hx19HMYqM
X-Google-Smtp-Source: AGHT+IHhpCFC2ppGca+Q9ly9BhuExXpqJYQW66tPB8V/Y8sevhG9hHDhtb3sA3mSYn+eXFk4goUGUDSRFcvz2TMJoE4=
X-Received: by 2002:a05:6122:3c91:b0:4dc:d7b4:5f7d with SMTP id
 71dfb90a1353d-4e4f0283c61mr11666919e0c.8.1716899924298; Tue, 28 May 2024
 05:38:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240528104807.738758-1-glider@google.com>
In-Reply-To: <20240528104807.738758-1-glider@google.com>
From: Marco Elver <elver@google.com>
Date: Tue, 28 May 2024 14:38:05 +0200
Message-ID: <CANpmjNP=GFdp49Cqa+n3GEC5sb3EWkBaYeMWqwLH7vA=NJyNbA@mail.gmail.com>
Subject: Re: [PATCH 1/2] kmsan: do not wipe out origin when doing partial unpoisoning
To: Alexander Potapenko <glider@google.com>
Cc: dvyukov@google.com, akpm@linux-foundation.org, bjohannesmeyer@gmail.com, 
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 28 May 2024 at 12:48, Alexander Potapenko <glider@google.com> wrote:
>
> As noticed by Brian, KMSAN should not be zeroing the origin when
> unpoisoning parts of a four-byte uninitialized value, e.g.:
>
>     char a[4];
>     kmsan_unpoison_memory(a, 1);
>
> This led to false negatives, as certain poisoned values could receive zero
> origins, preventing those values from being reported.
>
> To fix the problem, check that kmsan_internal_set_shadow_origin() writes
> zero origins only to slots which have zero shadow.
>
> Reported-by: Brian Johannesmeyer <bjohannesmeyer@gmail.com>
> Link: https://lore.kernel.org/lkml/20240524232804.1984355-1-bjohannesmeyer@gmail.com/T/
> Fixes: f80be4571b19 ("kmsan: add KMSAN runtime core")
> Signed-off-by: Alexander Potapenko <glider@google.com>
> ---
>  mm/kmsan/core.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
>
> diff --git a/mm/kmsan/core.c b/mm/kmsan/core.c
> index cf2d70e9c9a5f..95f859e38c533 100644
> --- a/mm/kmsan/core.c
> +++ b/mm/kmsan/core.c
> @@ -196,8 +196,7 @@ void kmsan_internal_set_shadow_origin(void *addr, size_t size, int b,
>                                       u32 origin, bool checked)
>  {
>         u64 address = (u64)addr;
> -       void *shadow_start;
> -       u32 *origin_start;
> +       u32 *shadow_start, *origin_start;
>         size_t pad = 0;
>
>         KMSAN_WARN_ON(!kmsan_metadata_is_contiguous(addr, size));
> @@ -225,8 +224,16 @@ void kmsan_internal_set_shadow_origin(void *addr, size_t size, int b,
>         origin_start =
>                 (u32 *)kmsan_get_metadata((void *)address, KMSAN_META_ORIGIN);
>
> -       for (int i = 0; i < size / KMSAN_ORIGIN_SIZE; i++)
> -               origin_start[i] = origin;
> +       /*
> +        * If the new origin is non-zero, assume that the shadow byte is also non-zero,
> +        * and unconditionally overwrite the old origin slot.
> +        * If the new origin is zero, overwrite the old origin slot iff the
> +        * corresponding shadow slot is zero.
> +        */
> +       for (int i = 0; i < size / KMSAN_ORIGIN_SIZE; i++) {
> +               if (origin || !shadow_start[i])
> +                       origin_start[i] = origin;
> +       }

Reviewed-by: Marco Elver <elver@google.com>


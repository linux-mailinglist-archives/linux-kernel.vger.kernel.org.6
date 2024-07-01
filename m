Return-Path: <linux-kernel+bounces-236377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D5D91E151
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 15:53:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A25661F245E6
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 13:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1A5215EFC4;
	Mon,  1 Jul 2024 13:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZiVUxe8k"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEBBB15EFB2
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 13:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719842004; cv=none; b=mjFB+OKSSfBRqsBBuuo5G+UFm3xO34w4BMPNKn2/uqNnVrIN0yGkbz544xc9ZP41MX0joZXpuH4Q+NnsjlmoH7MtP0DOlv/44TEJa7UH178xWmr9FZFIFIJOSiqdSPICaEogrR4Cfxt/pF9aJ3fDoDHAl/jyXxmYRhLz98Yj9bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719842004; c=relaxed/simple;
	bh=zjuZI/RFeK2Siq2kWbAvBkYtD32DKM3oKMl75XMrw0I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SJTJ6w9eSr1jFquLCE5YJEzXJuqSVVkyI3rzS/L616ynssp3fw5XoLqXwvOsa8EfFZZAM7Sitfr+N695tGGmy/EtZHp6JsSzJju0SX+/uB6C478ttz0DCHqgJpfj4agoaLiP3PSQVa1V9iFr6EOZfgYDxHfINV/Bsiizpu4PEaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZiVUxe8k; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a724b3a32d2so343209666b.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 06:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719842001; x=1720446801; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GtxGfK4yLjwSTonSngrkMxlYB6Z35sREqX9RHajOJwI=;
        b=ZiVUxe8kVQHqM71u7d10VVitzTEbr0epW9EKXop9L+aoxPsvDlTtTaVAppEaTroOBs
         R2xAlbRUwgqxrGlAUpgjvbw3PLS7SlLebHIG83QIoK1AKx2LYowryZ2zGqQ8l9YAFsUP
         EEl8hG3bbVL9/5S8xI+dmJefdZIkUBHqVfkAl2ppS9JubOL7y2sqDdmnHKKb3z1DYVlH
         CLnyLjC0rmoDEnsPW1RSpxyKdBLNWCAiYjTF/MbruFNBlJWMjs1MHhTAiHoNNMrwszOp
         V1JE1iMhO34r58EzUkGQ/h10TvE1HN1MwNXJDwrGh/GS0C3VthTvM7aeERE9/EhGmC7o
         G58Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719842001; x=1720446801;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GtxGfK4yLjwSTonSngrkMxlYB6Z35sREqX9RHajOJwI=;
        b=aNkrUyLrHsdTtFpjxm9OixfaTC5IMbHy9+EpE4Qyr1xbcetZnUy8WkQls3jt+QqkaW
         S8bEoYuhLw9HKxSy0nJxLcy1V2TB2Wg3Laap7/dnuIT5mNMmIzOFuf8I9UaTPLuvYsPO
         JbWMVOCkZVECL8sopZgbUu6OSn9g2C0niMJ6yl34R1UN5stPYndkaEfoiUhN8o30hCzR
         GWt7rHVKp0RHtvIWKYxFY2NUmD+0a8wxc8qJXHfPSHGlVPdnbK8tv0mTPvrdI0f2PIJA
         PG8BKtAWs1PY7cb7ub0jC2VsLhGcTTWfsqF6hGkWogPSg0jjyxas9NLmAOS2qbCMN/5v
         ZNvg==
X-Forwarded-Encrypted: i=1; AJvYcCWyMS11pinRR7kOGUbO4Y10LZMnJy8ptu5eZaoV/7kcWqq0g/6mFRoVdeN1EcyZ13sk5yYZuqL6hZzD5ACU8DjitqPJ1F+rsGPDfjdo
X-Gm-Message-State: AOJu0YyEkGEkoYH73+Ja2JKnnEVnHg5FAV9pcdPYy8xkKNWA03giFLDG
	FAVJIXpgA7HbzLE7FFjF/VFgaySeiUyesIJVmSF02ObOhQhkyXYAdVtcjtN0BFNEMFpN2DsLlv3
	BMCly6lA4zKE1MEkXTSXVfHQIIsdS0iylsLSRkk3TZmsibWoLU+i2
X-Google-Smtp-Source: AGHT+IEj/WEjMM90CqMbsBXDQszqWHwvtMWOSFUvdlbqfaAyuUVnOKSlS8P7Xlvi4rDSBfas+oUPjqXu/50ji0L2W90=
X-Received: by 2002:a17:906:7d2:b0:a72:4b31:13b5 with SMTP id
 a640c23a62f3a-a75144f61a2mr370014766b.54.1719842000514; Mon, 01 Jul 2024
 06:53:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240629111010.230484-1-21cnbao@gmail.com> <20240629111010.230484-3-21cnbao@gmail.com>
In-Reply-To: <20240629111010.230484-3-21cnbao@gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 1 Jul 2024 06:52:44 -0700
Message-ID: <CAJD7tkZ4FQr6HZpduOdvmqgg_-whuZYE-Bz5O2t6yzw6Yg+v1A@mail.gmail.com>
Subject: Re: [PATCH RFC v4 2/2] mm: support large folios swapin as a whole for
 zRAM-like swapfile
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, chrisl@kernel.org, 
	david@redhat.com, hannes@cmpxchg.org, kasong@tencent.com, 
	linux-kernel@vger.kernel.org, mhocko@suse.com, nphamcs@gmail.com, 
	ryan.roberts@arm.com, shy828301@gmail.com, surenb@google.com, 
	kaleshsingh@google.com, hughd@google.com, v-songbaohua@oppo.com, 
	willy@infradead.org, xiang@kernel.org, ying.huang@intel.com, 
	baolin.wang@linux.alibaba.com, shakeel.butt@linux.dev, 
	senozhatsky@chromium.org, minchan@kernel.org, 
	Chuanhua Han <hanchuanhua@oppo.com>
Content-Type: text/plain; charset="UTF-8"

[..]
> +static struct folio *alloc_swap_folio(struct vm_fault *vmf)
> +{
> +       struct vm_area_struct *vma = vmf->vma;
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +       unsigned long orders;
> +       struct folio *folio;
> +       unsigned long addr;
> +       spinlock_t *ptl;
> +       pte_t *pte;
> +       gfp_t gfp;
> +       int order;
> +
> +       /*
> +        * If uffd is active for the vma we need per-page fault fidelity to
> +        * maintain the uffd semantics.
> +        */
> +       if (unlikely(userfaultfd_armed(vma)))
> +               goto fallback;
> +
> +       /*
> +        * a large folio being swapped-in could be partially in
> +        * zswap and partially in swap devices, zswap doesn't
> +        * support large folios yet, we might get corrupted
> +        * zero-filled data by reading all subpages from swap
> +        * devices while some of them are actually in zswap
> +        */

If we read all subpages from swap devices while some of them are
actually in zswap, the corrupted data won't be zero-filled AFAICT, it
could be anything (old swapped out data). There are also more ways
this can go wrong: if the first page is in zswap, we will only fill
the first page and leave the rest of the folio uninitialized.

How about a more generic comment? Perhaps something like:

A large swapped out folio could be partially or fully in zswap. We
lack handling for such cases, so fallback to swapping in order-0
folio.

> +       if (!zswap_never_enabled())
> +               goto fallback;
> +


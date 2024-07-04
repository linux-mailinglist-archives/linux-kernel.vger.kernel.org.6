Return-Path: <linux-kernel+bounces-241268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DD7A927937
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 16:49:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C608EB25AAF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 14:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F2D61B010C;
	Thu,  4 Jul 2024 14:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bm7ZRajf"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75BBC1A0721
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 14:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720104523; cv=none; b=FZpSkCgSClZ1N6AfXv6ABOAZIQleP6eYaNB4s3Js9vYP2qTCdGfM3TxqZPIgG2BNsFSHdNLmlLsbz0xZMzzf0Wg1vbWBgdrpot/A/zKZw4KMUBDMnBJa5JsBINqDr5ibfCsB6InYYt5IFH0RJtyHWsjIt77ThAoPh1i2sDYJ6Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720104523; c=relaxed/simple;
	bh=NF9VhcfY2kP2qNky7RDCR2XtVIfpxkQd9KpLvuUa1x4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yxl4yQ5sC1W9sbPyZI6DOZF88VVIW+8kyNwSc0GlhjvtYteZjA7JeYd06xVTyIb3qfEj1us5VMmGxh/y+L6qdYeC6GdBHbgyJlMJLphAaR1pEjPgjq3Fa1uVKuTYLyFyrOBoELC70puMFnMG4Fwk4G2KgsRqRoe6L8j/+AoRqg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bm7ZRajf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720104520;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vXECjDJrtIl4BpVTyYC6fwJS8w+7LK06QJNYlI1sP8Y=;
	b=Bm7ZRajfsLaY1QQV7VFpRVsCp0krxkVBh8qXXjTY8Ta1WJCip4VXN/mQoe5wMaSLfvXB1L
	UkhlOEU6uJhY12ATPlfYMFGo7A1iysMC4Uu4au3RkGQXYXllXJ9x7QiqvQ8XjUR1Sea+0M
	nQqCWpk/Dbq7JR1jBwrA7HTZ/O7IDs4=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590--K2qquZfNRSZycdr5iT1eg-1; Thu, 04 Jul 2024 10:48:38 -0400
X-MC-Unique: -K2qquZfNRSZycdr5iT1eg-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-444f87a6c3cso1749631cf.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 07:48:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720104518; x=1720709318;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vXECjDJrtIl4BpVTyYC6fwJS8w+7LK06QJNYlI1sP8Y=;
        b=ugZuPCJv+xsMfqL29Kg6x42/jT/TGd9D9qQzLRTZg44ZcviTgCBFaCj2jtwrMQHQES
         CSCljJ4EZgTKfrybvFaHp2chMjAt2R66BJ5f4qGm25hGzBxQz4pVTmP/f4NuM2geBd55
         z++g/uIaQUbA30jcrm/vvaF1npSGXIohAErAjG3gQXx2vxyLMBDnmTo26bVbn7+408cn
         CTQJcFWCc+v/T1qW2bi8c2296GisIyrpLnSjna9RozD+EbNAXrJYiO1lVKd1yE/PGZar
         8KUQodgbdMb8022aBKDooUwqDSt7RPur7vPIYEKOxet8Gs6ndVc2dtB3UG2z0MjoIqlK
         qUNw==
X-Forwarded-Encrypted: i=1; AJvYcCUfnDNrfKZkO61ep03+c502YcYEjKi6lWtDDMpvGyLwJQeKk7yTxRVaPPI6nt61EMyc04jtehXqi8YbrDM0F+fXw6q+6TH8U48HMaNT
X-Gm-Message-State: AOJu0YzKZaknvHP/l2lmJDHYmKMoAH2BC24zON4vPAH4J2wnCrwa/9Rl
	KQc6guTR6jShydxN9iYuMXeMMJp4NNeQshqgO+UW+Ua8LsBPLjLRFPaGKIDzvdrmFmKkEoWDtgH
	3Im6SMwms+GHlUN6ibRKcgaNQAPiy5kRxKneBUjtUzMlhM5yqcNfxiq5xoFLrSQ==
X-Received: by 2002:a05:6214:19ca:b0:6b5:de38:d6ee with SMTP id 6a1803df08f44-6b5ed25fef8mr17983536d6.3.1720104518271;
        Thu, 04 Jul 2024 07:48:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHbfJ4Dl8q9Di4ADjKh3fKHELg53QNLbtDJ7V6Dfgq9r/AZUi3Tjq7eYCPt4FX3A5juSme39A==
X-Received: by 2002:a05:6214:19ca:b0:6b5:de38:d6ee with SMTP id 6a1803df08f44-6b5ed25fef8mr17983356d6.3.1720104517861;
        Thu, 04 Jul 2024 07:48:37 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b5f04c9fdcsm3194276d6.34.2024.07.04.07.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 07:48:37 -0700 (PDT)
Date: Thu, 4 Jul 2024 10:48:34 -0400
From: Peter Xu <peterx@redhat.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, x86@kernel.org, linux-riscv@lists.infradead.org,
	Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH 3/3] mm: Add p{g/4}d_leaf() in
 asm-generic/pgtable-nop{4/u}d.h
Message-ID: <Zoa2Qnpzl97hmpHC@x1n>
References: <b601e1a88e3a5d4d93b130fa20184b555e2a2bea.1720074307.git.christophe.leroy@csgroup.eu>
 <c8cb83b709740f7ac835997b88c5ddda610f66ab.1720074307.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c8cb83b709740f7ac835997b88c5ddda610f66ab.1720074307.git.christophe.leroy@csgroup.eu>

On Thu, Jul 04, 2024 at 08:30:05AM +0200, Christophe Leroy wrote:
> Commit 2c8a81dc0cc5 ("riscv/mm: fix two page table check related
> issues") added pud_leaf() in include/asm-generic/pgtable-nopmd.h
> 
> Do the same for p4d_leaf() and pgd_leaf() to avoid getting them
> erroneously defined by architectures that do not implement the
> related page level.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  include/asm-generic/pgtable-nop4d.h | 1 +
>  include/asm-generic/pgtable-nopud.h | 1 +
>  include/linux/pgtable.h             | 6 +++---
>  3 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/include/asm-generic/pgtable-nop4d.h b/include/asm-generic/pgtable-nop4d.h
> index 03b7dae47dd4..75c96bbc5a96 100644
> --- a/include/asm-generic/pgtable-nop4d.h
> +++ b/include/asm-generic/pgtable-nop4d.h
> @@ -21,6 +21,7 @@ typedef struct { pgd_t pgd; } p4d_t;
>  static inline int pgd_none(pgd_t pgd)		{ return 0; }
>  static inline int pgd_bad(pgd_t pgd)		{ return 0; }
>  static inline int pgd_present(pgd_t pgd)	{ return 1; }
> +static inline int pgd_leaf(pgd_t pgd)		{ return 0; }
>  static inline void pgd_clear(pgd_t *pgd)	{ }
>  #define p4d_ERROR(p4d)				(pgd_ERROR((p4d).pgd))
>  
> diff --git a/include/asm-generic/pgtable-nopud.h b/include/asm-generic/pgtable-nopud.h
> index eb70c6d7ceff..14aeb8ef2d8a 100644
> --- a/include/asm-generic/pgtable-nopud.h
> +++ b/include/asm-generic/pgtable-nopud.h
> @@ -28,6 +28,7 @@ typedef struct { p4d_t p4d; } pud_t;
>  static inline int p4d_none(p4d_t p4d)		{ return 0; }
>  static inline int p4d_bad(p4d_t p4d)		{ return 0; }
>  static inline int p4d_present(p4d_t p4d)	{ return 1; }
> +static inline int p4d_leaf(p4d_t p4d)		{ return 0; }
>  static inline void p4d_clear(p4d_t *p4d)	{ }
>  #define pud_ERROR(pud)				(p4d_ERROR((pud).p4d))
>  
> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index 2a6a3cccfc36..b27e66f542d6 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -1882,13 +1882,13 @@ typedef unsigned int pgtbl_mod_mask;
>   * - It should cover all kinds of huge mappings (e.g., pXd_trans_huge(),
>   *   pXd_devmap(), or hugetlb mappings).
>   */
> -#ifndef pgd_leaf
> +#if !defined(__PAGETABLE_P4D_FOLDED) && !defined(pgd_leaf)
>  #define pgd_leaf(x)	false
>  #endif
> -#ifndef p4d_leaf
> +#if !defined(__PAGETABLE_PUD_FOLDED) && !defined(p4d_leaf)
>  #define p4d_leaf(x)	false
>  #endif
> -#ifndef pud_leaf
> +#if !defined(__PAGETABLE_PMD_FOLDED) && !defined(pud_leaf)
>  #define pud_leaf(x)	false
>  #endif
>  #ifndef pmd_leaf

Is it possible to do it the other way round, so that we can still rely on
"ifdef pxx_leaf" to decide whether to provide a fallback, and define them
properly when needed?

IMHO it was a neat way to avoid worrying on any macro defined; it'll be as
simple as "if function xxx not defined, let's define a fallback for xxx".
Per my limited experience it helped a lot on avoid compile issues here and
there..

Thanks,

-- 
Peter Xu



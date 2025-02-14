Return-Path: <linux-kernel+bounces-515339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6320A3636B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 17:46:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17F0A16E279
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 16:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08B00267738;
	Fri, 14 Feb 2025 16:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="aSA6vkDU"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A79D264F9F
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 16:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739551551; cv=none; b=a87wBrbum4TGNTyfJqb4dkt70I8TRjHhZQqVs2o1L1iLoiGFIP1ibjHuKgj3fNL+WpPw2sNY/iWvbASsqljC8REYjM+t+A+1SVXeVxk0iMwS//P/uOrQsM66nnZWvBVrBsuuIiSnTm16xU6rgbSyvoHWAMfg5x1pROahGuMlkmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739551551; c=relaxed/simple;
	bh=2+gPs/G2DsMv2jgXbuexZyaxMhN/oqMsiDAKGgmtnPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OByy1nKP6lXcmOBAXokz9ZkVM1hqxeVqun1BDG8iAI2RgRBTrbfR16SGecsDZmZQ0L5UGgBbTE/M72xScA6ipVJuZRFpyYxyAyQZV6Mp+kyPeuE6XrIzGrNk//WvZhk0ubR8i3HLEnMeZRoFsFlNgoE7DYqmDXQrdSnZRcXzFR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=aSA6vkDU; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-471cfac91a4so6982091cf.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 08:45:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1739551546; x=1740156346; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ngroD9vi3+Uljzg3R1uHsM+zWtaFeoRiAMLeO+Fv5uo=;
        b=aSA6vkDUiHfAIFe0ssO/Y3p15Giwu3whGoxZvQNl1EDCRzLtQ4WrgwSxlcN6DiJiJx
         D5v7dw0Fb4ZKnVlOSmG7Xv+RcepJQuIX0qpsiThxyORNAZXMZFGBvmJE9UHiy2bIwKqu
         4W6qmmxeswNst1FlOgq4ZZo1ypZSc3GbHejJxe14rl5tQOPwHMp3fz6E+3exGkWE38As
         JlSfGybaDxBfnLmdMljaMpTjwkVPzDENYGRD1HAMh2wv5It55CwTn6///wwK1fCzu8Ji
         z3smTnR1c7kYDqF80bj25409tjOV0+9sLQXbZJK3xFXEOCNFpKv9960z1L/+WayvoiDB
         4Wfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739551546; x=1740156346;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ngroD9vi3+Uljzg3R1uHsM+zWtaFeoRiAMLeO+Fv5uo=;
        b=st9jDfaQiuiIMLZVEn9aPwsFP7XP6lUN42fEnEccFfu9v+wVhHnl4BvJZJxInDklae
         +14DmKSh3leqNRmdygC+PDKOr1xJLSurvAQ+/kqtdQbVRFI2a54JIp9wmforud06KkkN
         yBFr7cc6foIN8dL89aBulSmwVZtONZUlO/CD2MiAIt3NGtqZeGzcW9mi1kuI+MyVVCZk
         H0NuLMLSKKHmYcMbnQcqqNZ5EbXXFGjcgCT+mXsK7Bai5iUW9Fg6V3MeebnClpcNYm+y
         hCK1sHQBoiVKfIBNdMbCwUUO433jSUqyMPxdGJd7gjZLzcUvRS0CU0j227AuDgqBh2tu
         sarQ==
X-Forwarded-Encrypted: i=1; AJvYcCWyNS8hFkKMwLKAugtLibgo5qyx6zy59YKzU55LLJLPsFbsvgGqtPXaBIX0lHZCQgIY3WzIuimO+QvopWM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/67Z9kvNiTStXtI5s9b26LiwlFJqNLw0pHGiOyPA5OUeY4xrE
	MlbZvQDJdebjNkixk/PW8xgx8IdDNxu8nWhVG1FDyom1vXi6QBAbS5+yFMm6hyY=
X-Gm-Gg: ASbGncvvTnjkbXOPt/K1oVOdMvOTihyUnP4BWa00XqbekCdm9Q6jIXbdKEZ8wrCkR0S
	+iCcB9rvZxNoZ8WbB6M0FvRRtWDck84xOoHN7p49+ywtv6s6VdFoZInjBRZvtPdCzKot4yod4ge
	QqzqxYUSIxkfD06ZHlcSh6nqyiu8C9Yy95tjmxTSqO3BiIZslDf25bo7uMeJ7ZZ7WmcJrq7KZ9V
	gO/q7fKtUIlC2VLssv2f0fcbzuiMGEuzN5KzzkVC/SRAH9AzOMbOc8yJm3do5dIcXEpm2K7PHpb
	mRwyFJCSMY4JKA==
X-Google-Smtp-Source: AGHT+IHLiyAZD+OEUbtpbB5HAJMOScUjybQrh233VZ0NaF3TDsAi1xa3b7qp2N0oFxqTB4jbuwrTSg==
X-Received: by 2002:a05:622a:11c1:b0:471:aee9:dedd with SMTP id d75a77b69052e-471afe034efmr181771441cf.5.1739551546620;
        Fri, 14 Feb 2025 08:45:46 -0800 (PST)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-471c2a125b1sm19458431cf.24.2025.02.14.08.45.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 08:45:45 -0800 (PST)
Date: Fri, 14 Feb 2025 11:45:41 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Zi Yan <ziy@nvidia.com>
Cc: linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
	Oscar Salvador <osalvador@suse.de>,
	Vlastimil Babka <vbabka@suse.cz>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Mel Gorman <mgorman@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] mm/page_isolation: make page isolation a
 standalone bit.
Message-ID: <20250214164541.GA233399@cmpxchg.org>
References: <20250214154215.717537-1-ziy@nvidia.com>
 <20250214154215.717537-2-ziy@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214154215.717537-2-ziy@nvidia.com>

On Fri, Feb 14, 2025 at 10:42:12AM -0500, Zi Yan wrote:
> During page isolation, the original migratetype is overwritten, since
> MIGRATE_* are enums. Change MIGRATE_ISOLATE to be a standalone bit like
> PB_migrate_skip. pageblock bits needs to be word aligned, so expand
> the number of pageblock bits from 4 to 8 and make migrate isolate bit 7.
> 
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> ---
>  include/linux/mmzone.h          | 18 +++++++++++++-----
>  include/linux/page-isolation.h  |  2 +-
>  include/linux/pageblock-flags.h | 33 ++++++++++++++++++++++++++++++++-
>  mm/page_alloc.c                 | 21 +++++++++++++++++++--
>  4 files changed, 65 insertions(+), 9 deletions(-)
> 
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index 8aecbbb0b685..3c7d3f22ccb2 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -106,14 +106,22 @@ static inline bool migratetype_is_mergeable(int mt)
>  
>  extern int page_group_by_mobility_disabled;
>  
> -#define MIGRATETYPE_MASK ((1UL << PB_migratetype_bits) - 1)
> +#ifdef CONFIG_MEMORY_ISOLATION
> +#define MIGRATETYPE_NO_ISO_MASK (BIT(PB_migratetype_bits) - 1)
> +#define MIGRATETYPE_MASK (MIGRATETYPE_NO_ISO_MASK | PB_migrate_isolate_bit)
> +#else
> +#define MIGRATETYPE_NO_ISO_MASK (BIT(PB_migratetype_bits) - 1)
> +#define MIGRATETYPE_MASK (BIT(PB_migratetype_bits) - 1)
> +#endif

There is no user of the NO_ISO_MASK until the last patch. Can you
please defer introduction until then?

> -#define get_pageblock_migratetype(page)					\
> -	get_pfnblock_flags_mask(page, page_to_pfn(page), MIGRATETYPE_MASK)
> +#define get_pageblock_migratetype(page) \
> +		get_pfnblock_flags_mask(page, page_to_pfn(page), \
> +			MIGRATETYPE_MASK)
>  
> -#define folio_migratetype(folio)				\
> -	get_pfnblock_flags_mask(&folio->page, folio_pfn(folio),		\
> +#define folio_migratetype(folio) \
> +		get_pfnblock_flags_mask(&folio->page, folio_pfn(folio), \
>  			MIGRATETYPE_MASK)

That's a spurious change currently. I assume you tweaked the
MIGRATETYPE_MASK parameter during development, but I can't see a
functional difference now.

> @@ -373,7 +374,13 @@ unsigned long get_pfnblock_flags_mask(const struct page *page,
>  	 * racy, are not corrupted.
>  	 */
>  	word = READ_ONCE(bitmap[word_bitidx]);
> -	return (word >> bitidx) & mask;
> +	flags = (word >> bitidx) & mask;
> +
> +#ifdef CONFIG_MEMORY_ISOLATION
> +	if (flags & PB_migrate_isolate_bit)
> +		return MIGRATE_ISOLATE;
> +#endif
> +	return flags;
>  }
>  
>  static __always_inline int get_pfnblock_migratetype(const struct page *page,
> @@ -397,8 +404,18 @@ void set_pfnblock_flags_mask(struct page *page, unsigned long flags,
>  	unsigned long bitidx, word_bitidx;
>  	unsigned long word;
>  
> +#ifdef CONFIG_MEMORY_ISOLATION
> +	BUILD_BUG_ON(NR_PAGEBLOCK_BITS != 8);
> +	/* keep other migratetype bits if MIGRATE_ISOLATE is set */
> +	if (flags == MIGRATE_ISOLATE) {
> +		mask &= ~((1UL << PB_migratetype_bits) - 1);
> +		flags = PB_migrate_isolate_bit;
> +	}

Please change the callers in both cases to pass the appropriate masks
of interest instead.

That's likely a bit of churn in the allocator code, but adding caller
specifics to this function violates abstraction layering rules.


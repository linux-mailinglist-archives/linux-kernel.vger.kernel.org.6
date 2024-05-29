Return-Path: <linux-kernel+bounces-193912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D4178D33FB
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 12:05:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C0DA1C232D8
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 10:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 734F117A91B;
	Wed, 29 May 2024 10:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="HgjZ8rqT"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C04331A60
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 10:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716977127; cv=none; b=Bjga9swqcZwOsN+QT9z4Byvqmed8Pf6dLfk2NJft2xppz5JSULOFrZ6aUtBCX0oHLSzlLRbeEyLrI+lUSvO/4xvd0rRD0Sd+M7Vjm8cuPwDzdJWA83VxQy5nFCM+ofnzPk4xqMbtR/nVTGaJQFkeNhga560eFnwp7LWAPEm6Lvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716977127; c=relaxed/simple;
	bh=jdIfZWjSZqNLyhkQVFjBgRz33vWk9mB2ZcWv52+zLio=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R/Xk9Wxd4BL30aGAf5TwLCdqMprXMNKN2OeYWRSyN1qi66Mm/UW3osn5inJiNxTEfjREMt9LgXTZqv8hQHdwnLONZZSUWjQMnUoRye3x8jOOeImbKn+ln7+3XS0USpjlA/jeh6dFPv+RuG0Ghm21rZoxUgELRMl1Smj5ZDdUZRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=HgjZ8rqT; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-357d533b744so1886374f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 03:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1716977124; x=1717581924; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SjBeXRP3NZPNEtnVExWiEQg1GcbJkpp6fTKGUuZKI9Y=;
        b=HgjZ8rqT5Sz51UcORpAVgY9dMU/4ufJnGkHiT9HTDoW4aQWUGaLDfisQauGiG4WAMz
         TG/EOZXja5i1dwp243Wh/Qwa0vOVaSn9F/M4nr42TdgfqFipu3BWVb6IG2FR1NDnS7Pk
         qX9pKNCV9Q8ElTobJ3adYLhjq+rtO5XwTFkklJKQrZBRHFCcSajVjQtrBXfZuQdflnmt
         GCSIgAOtf7pFIsrUBqltFmTVnocVTckkUcFYs7nYfjPJsHlh+zbBZtoI1dbYxNSzNCsq
         Glw9L/YVCXGUjnXRWpPgSurUnupX03MuAGOEy4n4us0ksglkBJ3iudEWIbVGf76CuiRS
         y/kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716977124; x=1717581924;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SjBeXRP3NZPNEtnVExWiEQg1GcbJkpp6fTKGUuZKI9Y=;
        b=DiAm7WVgZIkmGSdyVOR/zDt/GBskjJJFuoK2ywHlmGTXDgKpN4mNmetJhiNuWkB3nv
         5qjjbjqkj2+xxIm5LO9o5uyUdHP4G3lDlDib22CnHeS2kBfCVwh7Fvhb5szrNOM8fCVS
         3ar9bh7uyhbmUdJYPcBov/KtoSkiWuy8LBwu6xda0U1JouQtfDfr5FuJtegJwQM+ujdC
         XjRMg926RCPTQ+SOO2q1UKKtcWrvln1FBltbtQ6HdLqGtmlO/b0mBsHQRQVmF/fsRSO3
         hYOfc/HL2e29sf1unUtuoGDr2DeLIP4nTlBKqH1KZFMLgfSmUF3NBcPVh4vdyk1n9acd
         9rZA==
X-Forwarded-Encrypted: i=1; AJvYcCWYzJZX5GcuoyxHGcElIGgyg2gRAbdTsN+N0t20pIKAghQQIYVT2s54V+MM1mnTdLGMNSmB+rhP6P0nm6/+bmtsA5ZaPYBYzUJOqBm5
X-Gm-Message-State: AOJu0Yz72A+r/mjPK1kCQ6iksPA0HX6MZPAIepLGt+2eL8pv0QUAs7xP
	5az+cPvNDN+gPepchC4DFnZopPevRvcQhjLzAfbN4zePfTAo/xgQ7acwuubG2FM=
X-Google-Smtp-Source: AGHT+IEJ9/f6hxMe3hU/z8uaPfO55G1vDC0ZTRYQcECOhnmYBWOWQIQjQ/blRPGbEK5l+LkpPlv2TA==
X-Received: by 2002:a5d:4748:0:b0:356:a46b:7369 with SMTP id ffacd0b85a97d-356a46b766bmr8129108f8f.24.1716977123830;
        Wed, 29 May 2024 03:05:23 -0700 (PDT)
Received: from localhost.localdomain (62.83.84.125.dyn.user.ono.com. [62.83.84.125])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35579d7db23sm14697759f8f.23.2024.05.29.03.05.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 03:05:23 -0700 (PDT)
From: Oscar Salvador <osalvador@suse.com>
X-Google-Original-From: Oscar Salvador <osalvador@suse.de>
Date: Wed, 29 May 2024 12:05:21 +0200
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Oscar Salvador <osalvador@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jason Gunthorpe <jgg@nvidia.com>, Peter Xu <peterx@redhat.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [RFC PATCH v4 13/16] powerpc/e500: Use contiguous PMD instead of
 hugepd
Message-ID: <Zlb94UyBx0s-Vavj@localhost.localdomain>
References: <cover.1716815901.git.christophe.leroy@csgroup.eu>
 <56cf925576285e2b97550f4f7317183d98d596c5.1716815901.git.christophe.leroy@csgroup.eu>
 <ZlbsEb_T2eQYO-g4@localhost.localdomain>
 <b95f61ea-b40c-4d7c-9a39-7bf927f7b0cd@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b95f61ea-b40c-4d7c-9a39-7bf927f7b0cd@csgroup.eu>

On Wed, May 29, 2024 at 09:58:35AM +0000, Christophe Leroy wrote:
 
> Yes I now have :
> 
> +#define _PAGE_HSIZE_MSK (_PAGE_U0 | _PAGE_U1 | _PAGE_U2 | _PAGE_U3)
> +#define _PAGE_HSIZE_SHIFT              14
> +#define _PAGE_HSIZE_SHIFT_OFFSET       20
> 
> and have added a helper to avoid doing the calculation at several places:
> 
> +static inline unsigned long pte_huge_size(pte_t pte)
> +{
> +       pte_basic_t val = pte_val(pte);
> +
> +       return 1UL << (((val & _PAGE_HSIZE_MSK) >> _PAGE_HSIZE_SHIFT) + 
> _PAGE_HSIZE_SHIFT_OFFSET);
> +}

Great, this looks much better.

> That's what I did before but it didn't work. The problem is that 
> pte_advance_pfn() takes a long not a long long:
> 
> static inline pte_t pte_advance_pfn(pte_t pte, unsigned long nr)
> {
> 	return __pte(pte_val(pte) + (nr << PFN_PTE_SHIFT));
> }
> 
> And when I called it with nr = PMD_SIZE / PAGE_SIZE = 2M / 4k = 512, as 
> we have PFN_PTE_SHIFT = 24, I got 512 << 24 = 0

Ah, I missed that trickery with the types.

Thanks!


-- 
Oscar Salvador
SUSE Labs


Return-Path: <linux-kernel+bounces-389370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 326DD9B6C1F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 19:30:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6D54282563
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 18:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 271141CC152;
	Wed, 30 Oct 2024 18:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="sk0crNhO"
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16461C9B77
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 18:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730313055; cv=none; b=nq/SXq6VlJ60Kd0F0253Jwim5JymSzHme0gJwoGGXHXj2wiisnEhVAqAcihJZKUSLfmIPzWsMYsa09euFzJCcv4swUPVt7Iebad/URRyoLSRWjDtRLN129HvDj9YWoq7EeNP96O22GG2DR6cWzVd0lzQFvildV7cg2cShXReYjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730313055; c=relaxed/simple;
	bh=GnnDat3QvnrXqEoFk6xpze7bEpG/u62miW9QnQi8ldw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WkCcHunlGEDwtpqr0eEx4jD3yxSIPqOS40d1Ln9aPJfTAZnMESEU8OcV232vDCGycBZYfoZTDoOVNR0dQB5Y+m9prRSVAi2ANPytnmeD/VpxXSu8FGccSjzIjEQlzUXsCdhXyEsrOz6Hwe7gmYpi6xMZysVT/8JKgN7TseJN8w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=sk0crNhO; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6cbce8d830dso1013486d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 11:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1730313051; x=1730917851; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+BQyFvetyfEonBkCQfY0fCLeQcMCAqYlLQEbyNnwUY8=;
        b=sk0crNhO/N0WY9ZOVgJHiC01NiunYxmY9ZYb2WzSkTcIWw8rTTs+Hpaz6Xk2V/s2aL
         mHgIckPnvnUCCmLUFXGyPwRJoBcg1iV/IRveNKP40/c3OMiD3xAemCr6LjK+YKTQz6aP
         Nsag7RxBYptS4Buwburm8Yerh5VN2PeNAzkybBM9XIBFVF5E/bT6LRNTCc79lGNu4K5o
         FElod3L1noofhELhrii7ms/+PbI3/tlpqtGhFth8zoRnBh5BW6ZnTLW+0Gh9UQRoG5yo
         Dni7kdxfrVjtJ4k5gsgmSM6QRzNbvuGge1i9qx3zin+cMiL3OxnMjS401S5DYtgiv7D0
         /zLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730313051; x=1730917851;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+BQyFvetyfEonBkCQfY0fCLeQcMCAqYlLQEbyNnwUY8=;
        b=H4EAkzq3CQh/QIrzx3jWUY1m4Pu7VxbR26XgMT4sGCFwhzBv4VdYtbaHsXTbZVa8wG
         hCHxJIJQEou15mvU0IuGDvvmVwWoXdNyWTkzav0upW+p3nI/MgbKIMKj1uGjQmEiUc5m
         KXwONgIKPanQDCtjn1iTnLfQqJRL1HJ5Rvbi7InG+PsNJv5wSNWghwHWLSVB9EQ00f+s
         UlohSO4cOJeN5FVYgwHmBclWTij+q51L76wnzcFFDtTnglY/dKMmnZ0j5xFCD7tVomvE
         2v4JIFZLF9GkvKwQaF159+Joi8PdCPVNILLR91D6g6w+GEusmkRw3dbA2j9iVgQu3zLM
         2Img==
X-Forwarded-Encrypted: i=1; AJvYcCWZt0BaNoLxToGzpWoY+0eCMN0Z5kmKYjSP96tpugjhsEkzJBWS+W+ajHd+JX33Vfbx0YCpK2cwDoE31jc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw70TY9aZVRmZB2R5kUgWLsZpm50QH75Bw07JhNydTNt8rx9iKi
	Vm+mOqau32++79a6TvgDFReV2NV23ZVMK/d+bHN7XOZgHlYeYWZDJ98mZdlDlXM=
X-Google-Smtp-Source: AGHT+IFZKq2rPrctMfcx/ODZimdpPiE5Sd/oXmeAfoYjzVnlrEmEOTepjdE4Eu92d40qrV5Ks/x7Ag==
X-Received: by 2002:a05:6214:5b01:b0:6d3:5187:bcf8 with SMTP id 6a1803df08f44-6d35187be34mr12861026d6.17.1730313049656;
        Wed, 30 Oct 2024 11:30:49 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d179a2c829sm54520496d6.121.2024.10.30.11.30.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 11:30:48 -0700 (PDT)
Date: Wed, 30 Oct 2024 14:30:44 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Michal Hocko <mhocko@suse.com>
Cc: Joshua Hahn <joshua.hahnjy@gmail.com>, nphamcs@gmail.com,
	shakeel.butt@linux.dev, roman.gushchin@linux.dev,
	muchun.song@linux.dev, tj@kernel.org, lizefan.x@bytedance.com,
	mkoutny@suse.com, corbet@lwn.net, lnyng@meta.com,
	akpm@linux-foundation.org, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v3 1/1] memcg/hugetlb: Adding hugeTLB counters to memcg
Message-ID: <20241030183044.GA706387@cmpxchg.org>
References: <20241028210505.1950884-1-joshua.hahnjy@gmail.com>
 <ZyIZ_Sq9D_v5v43l@tiehlicka>
 <20241030150102.GA706616@cmpxchg.org>
 <ZyJQaXAZSMKkFVQ2@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZyJQaXAZSMKkFVQ2@tiehlicka>

On Wed, Oct 30, 2024 at 04:27:37PM +0100, Michal Hocko wrote:
> On Wed 30-10-24 11:01:02, Johannes Weiner wrote:
> > On Wed, Oct 30, 2024 at 12:35:25PM +0100, Michal Hocko wrote:
> > > On Mon 28-10-24 14:05:05, Joshua Hahn wrote:
> > > [...]
> > > > Changelog
> > > > v3:
> > > >   * Removed check for whether CGRP_ROOT_HUGETLB_ACCOUNTING is on, since
> > > >     this check is already handled by lruvec_stat_mod (and doing the
> > > >     check in hugetlb.c actually breaks the build if MEMCG is not
> > > >     enabled.
> > > [...]
> > > > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > > > index 190fa05635f4..fbb10e52d7ea 100644
> > > > --- a/mm/hugetlb.c
> > > > +++ b/mm/hugetlb.c
> > > > @@ -1925,6 +1925,7 @@ void free_huge_folio(struct folio *folio)
> > > >  				     pages_per_huge_page(h), folio);
> > > >  	hugetlb_cgroup_uncharge_folio_rsvd(hstate_index(h),
> > > >  					  pages_per_huge_page(h), folio);
> > > > +	lruvec_stat_mod_folio(folio, NR_HUGETLB, -pages_per_huge_page(h));
> > > >  	mem_cgroup_uncharge(folio);
> > > >  	if (restore_reserve)
> > > >  		h->resv_huge_pages++;
> > > > @@ -3093,6 +3094,7 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
> > > >  
> > > >  	if (!memcg_charge_ret)
> > > >  		mem_cgroup_commit_charge(folio, memcg);
> > > > +	lruvec_stat_mod_folio(folio, NR_HUGETLB, pages_per_huge_page(h));
> > > >  	mem_cgroup_put(memcg);
> > > >  
> > > >  	return folio;
> > > 
> > > I do not see any specific checks for CGRP_ROOT_MEMORY_HUGETLB_ACCOUNTING
> > > in these paths. I guess you wanted to say that you rely on
> > > mem_cgroup_commit_charge setting memcg pointer which then __lruvec_stat_mod_folio
> > > relies on when updating stats.
> > 
> > Yes, this is what Shakeel pointed out here:
> > 
> > https://lore.kernel.org/lkml/il346o3nahawquum3t5rzcuuntkdpyahidpm2ctmdibj3td7pm@2aqirlm5hrdh/
> 
> It belongs to the changelog.

Joshua, can you please include something like this at the end:

lruvec_stat_mod_folio() keys off of folio->memcg linkage, which is
only set up if CGRP_ROOT_MEMORY_HUGETLB_ACCOUNTING is switched
on. This ensures that memory.stat::hugetlb is in sync with the hugetlb
share of memory.current.


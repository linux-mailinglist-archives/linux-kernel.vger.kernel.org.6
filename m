Return-Path: <linux-kernel+bounces-342490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2FE6988F94
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 16:15:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97148281EEF
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 14:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 040501885B7;
	Sat, 28 Sep 2024 14:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="Ph10BNP1"
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E6F18454C
	for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 14:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727532924; cv=none; b=XGBz0vSNCG7kc/OHMtivi5SYisv6iFCaT2h8xWyCDz01JLR1cbmOO3MsAAidO0PVhoLzlgJDMi0NxQ8kV7Pj24Uq9LQAlColQu32ZZzSmQjBB4MDyTk8y6QIdU1tRZ8qAHQoAgm8NQk8uXiZRnSNpxAYIknfQm30r7/IAxeZrIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727532924; c=relaxed/simple;
	bh=aqM3BBrmcjoH0ekW+TeKiFR7j39XYgP3dsJCtSlSdmc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uvemCJXnDSeqlKlKNovkr//rTI9rA3AvebVDtRvvTlp8WXJoCryvAtdyFRAiFbBPJrq6jtB9rO6V++v9WwsWs+x7Uc+mQqHBaiHST0IDK/pfHgJHq7ABVVruhd6WkKgZyqTDkTMrCodOLCxAWV5kqJWD3h5hxKq/teRSIhh1Hzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=Ph10BNP1; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6cb321145easo23587676d6.1
        for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 07:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1727532920; x=1728137720; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1n1yhYZ2jePqstMxv83IrNQpWfd5taqozmZvKKkqosE=;
        b=Ph10BNP1D2et8a3/n5RD4wMs5b8ULD3f3U4lcHcZiWNIwrzQdarYI8HpYWEtXcxCKw
         QFHunPPphrwKw9vm+FabESjrnm1VncHqu0+UCsMPmpuNQRPNAkIK8E8i/FJ7HfxrK10H
         pr6om7+dAS4caW/22zgU+80BXbzMAdKYo2wFh+hzyHzGhIaRC1e7cYpAQPi/bMRDsgCB
         DkNTnJjHOir2IxzOgnfShnJd5bduww65exYHDWOG6tWcu2f0Eq7kzLq6+8vpOnl/KFCB
         BnM/aFekpLA/DDcSVGI/A9ayLaXDrtkJRqCsQH2eg6LtO9+YSWjELrXzSqIyFyvxIBx8
         q1GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727532920; x=1728137720;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1n1yhYZ2jePqstMxv83IrNQpWfd5taqozmZvKKkqosE=;
        b=xKO2nl8I78rJVLJyOpcUl5mSDgWE7EwVF+A8y3VevFDipdaEilZxirWhrUy/tYqjwC
         qYG4junu/Bt4o+1HKW4QeQrykWPblvs1xbE849HNMlNMGGpGA6CYYUdaEtVqKxdZn9sV
         IlS0u2f8xn5sGiODb5Gh0AnXFl6dDGPEIj9bZebLBIlH2QxG+EU5JFoMD1UsSq6k+VHD
         66c5OurGWedUyNNacsorO/oY5W4AOO8nseExYQ7o6LcDONg9o4tWajIbAmw/Vu7VZvZe
         h0bPAqqZDSm6NdFZHiXEGWEMxdjQdRMk8Xk05nEd0dnFjaTpu1gaW/leBysriSkLh/bl
         XfMQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMwz3rVnzrh5GRL1/b2Pjuo7kxZgiwhGOH4hP/S18WopLtTeiLs9l9lyXbth+EaVQF8c/XZyV199O3RNY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk39w9mtHuA93QZItlMb6fVPF9gIBqz1oUtpP1gQcq0IgHPIEL
	u5FIzv5LNDhKyx/Ee2x00ZEEAlgPJburQ4uRX72OTYgNeoXFJg86bMAK0tNTMnQ=
X-Google-Smtp-Source: AGHT+IHd3wDhlYhXVZ+88k2ZjgoreOFUU3e+oUfQyAaHR5koWFTiMsugOsIxve2cJUf4gyU3Uemsbw==
X-Received: by 2002:a05:6214:4b11:b0:6c3:5c75:d2b1 with SMTP id 6a1803df08f44-6cb3b32d1ebmr109084796d6.5.1727532919982;
        Sat, 28 Sep 2024 07:15:19 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cb3b60fbf0sm19761396d6.37.2024.09.28.07.15.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Sep 2024 07:15:18 -0700 (PDT)
Date: Sat, 28 Sep 2024 10:15:14 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, nphamcs@gmail.com,
	chengming.zhou@linux.dev, usamaarif642@gmail.com,
	shakeel.butt@linux.dev, ryan.roberts@arm.com, ying.huang@intel.com,
	21cnbao@gmail.com, akpm@linux-foundation.org, nanhai.zou@intel.com,
	wajdi.k.feghali@intel.com, vinodh.gopal@intel.com
Subject: Re: [PATCH v8 6/8] mm: zswap: Support large folios in zswap_store().
Message-ID: <20240928141514.GE957841@cmpxchg.org>
References: <20240928021620.8369-1-kanchana.p.sridhar@intel.com>
 <20240928021620.8369-7-kanchana.p.sridhar@intel.com>
 <CAJD7tkZRTAiEJQpg96zqDye3ViCfvBsMM1Ozmcs75e__WcF0kQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJD7tkZRTAiEJQpg96zqDye3ViCfvBsMM1Ozmcs75e__WcF0kQ@mail.gmail.com>

On Fri, Sep 27, 2024 at 08:42:16PM -0700, Yosry Ahmed wrote:
> On Fri, Sep 27, 2024 at 7:16 PM Kanchana P Sridhar
> >  {
> > +       struct page *page = folio_page(folio, index);
> >         swp_entry_t swp = folio->swap;
> > -       pgoff_t offset = swp_offset(swp);
> >         struct xarray *tree = swap_zswap_tree(swp);
> > +       pgoff_t offset = swp_offset(swp) + index;
> >         struct zswap_entry *entry, *old;
> > -       struct obj_cgroup *objcg = NULL;
> > -       struct mem_cgroup *memcg = NULL;
> > -
> > -       VM_WARN_ON_ONCE(!folio_test_locked(folio));
> > -       VM_WARN_ON_ONCE(!folio_test_swapcache(folio));
> > +       int type = swp_type(swp);
> 
> Why do we need type? We use it when initializing entry->swpentry to
> reconstruct the swp_entry_t we already have.

It's not the same entry. folio->swap points to the head entry, this
function has to store swap entries with the offsets of each subpage.

Given the name of this function, it might be better to actually pass a
page pointer to it; do the folio_page() inside zswap_store().

Then do

		entry->swpentry = page_swap_entry(page);

below.

> >         obj_cgroup_put(objcg);
> > -       if (zswap_pool_reached_full)
> > -               queue_work(shrink_wq, &zswap_shrink_work);
> > -check_old:
> > +       return false;
> > +}
> > +
> > +bool zswap_store(struct folio *folio)
> > +{
> > +       long nr_pages = folio_nr_pages(folio);
> > +       swp_entry_t swp = folio->swap;
> > +       struct xarray *tree = swap_zswap_tree(swp);
> > +       pgoff_t offset = swp_offset(swp);
> > +       struct obj_cgroup *objcg = NULL;
> > +       struct mem_cgroup *memcg = NULL;
> > +       struct zswap_pool *pool;
> > +       size_t compressed_bytes = 0;
> 
> Why size_t? entry->length is int.

In light of Willy's comment, I think size_t is a good idea.


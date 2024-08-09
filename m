Return-Path: <linux-kernel+bounces-280654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B1D894CD56
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 11:32:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4813B1C20E21
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 09:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 625C619046B;
	Fri,  9 Aug 2024 09:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="MxBWp2dv"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A710018CBF5
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 09:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723195914; cv=none; b=YtjeqhKOyAcxIm9/vtYW3Wh34TVG4rOUzJXIsiUaD4qJLUTnhcFLWZi9Dp1CqEyD99BI5tG94T61ATWIgrmpDL6bEJXUnKVn1LYk4Uou0EHJDOxlbX8QlWRdDVQBuBhxFe7xsVs487xDn6Kqi0gfH9/i5kh8xqIulgaG79nr8LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723195914; c=relaxed/simple;
	bh=J1P+RNACgbwnImtFni0dLd/+tzpURUZtk5K+rIK+VHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rh7RgklsB/83+km99cjr61S8aNG8B8nNbJPZVDHZaMwB/Auv97bo1g2yX/LoRNMItDno3GO+rRbyWKjlFWCqpT9ZrAXimKtYuVKDPNoaZMmsmkEuHZQFxadhGUuBpNBituNPrzlggCPckUUtcV6D0c+I9QNtPWv84yHJsyR4CGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=MxBWp2dv; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a7a843bef98so206523766b.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 02:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1723195911; x=1723800711; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zNbaepAcuh1uOoVIl5NbzLuq//ai16vzEXAREzK9k2E=;
        b=MxBWp2dvto7eDvzxKZK0/tGGefBj+PRLByZ6TcqYWo6AuaVX/NyJZnEvhFgwY96I0v
         4zeqfGiwRbdN8T+rwSqcl/xQKI323Rc5fMNu0JJEAHPdvWnPYApXSujItd/Hvj2S2/NR
         qk0IGiCwIEtEJI05MmwLIjwu0tDScBLhFKueyRgFKZMrYEwsRQb3d7tXGaaf1EI5BAfs
         BBrRrmIs8djvBkz1+Wb5mQpliX8D6ctUCxVGP+rnBuuDnaFGbRIyPbHtSp2y4sfC7CFq
         Bmbt6TAPF2r+QtZGT2NsOq06BrcmDfhx+4gNqRn9lKVHkCgwBSaNMxNK4tK4EId3zbeV
         vhsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723195911; x=1723800711;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zNbaepAcuh1uOoVIl5NbzLuq//ai16vzEXAREzK9k2E=;
        b=SK9yUemqcucRfeNFhBXNtt/X6My2BODlvy8LmWrD8hBxJcr0ZQE4bDeK6Affh09KIl
         CnPFikUjNtRh0tu2fcJ/p8mi/y4Aan213gpXtuK4o1k1UNkSqTVBIV0vgmlQUHvonawE
         4qNMi4/AFELfgEsVj55k8jnO1S+gyAg17bCLbPpaY/yvSvP3wWMFfV92+Z1n78RD6LLZ
         4AmO1Zrmg8xiIMYu55qNSekQogQLghTyZjwdL98ErLxAQAU4/suiWul5FhJ91Nq4Qd1v
         bqoR6Fp+WSlBJIVtv/R2mVAbCOnUKYk+dl4uw6C0WLRKjZJ3QxIRJfCWKOrlFbEZd0jf
         A0JA==
X-Forwarded-Encrypted: i=1; AJvYcCUU1S5jI+3OFA7tQZyT/AQycE8S88Z2i+vGUpioSaK07pvu/z+7cFimLQGXddUdjY/tb8FTecmj6ppqjxZpfg/qDPq5B+DJ5R0KOnUU
X-Gm-Message-State: AOJu0Yw0/urnFsn2wlmw/av2mGPR7GK1cy5VEzACPkz/VjRRRmrv1QqG
	2B067B0VS4f+qdSXb15a4/q3IGZ7raQhWvQPslBYiHjzWaOBwNZv9CU2LzE4/7U=
X-Google-Smtp-Source: AGHT+IHAIMaBHg4JzZJAXLYjFpR/mjiI1/cbeLj1NwNJkTlOJvpkL9lvhUk59mzSP9BW1C0d8esogQ==
X-Received: by 2002:a17:907:c7c5:b0:a7a:9f0f:ab26 with SMTP id a640c23a62f3a-a80aa59b3dfmr88746566b.23.1723195910794;
        Fri, 09 Aug 2024 02:31:50 -0700 (PDT)
Received: from localhost (109-81-83-166.rct.o2.cz. [109.81.83.166])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9c0cc4fsm830237866b.77.2024.08.09.02.31.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 02:31:50 -0700 (PDT)
Date: Fri, 9 Aug 2024 11:31:49 +0200
From: Michal Hocko <mhocko@suse.com>
To: Hailong Liu <hailong.liu@oppo.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	"Tangquan . Zheng" <zhengtangquan@oppo.com>, stable@vger.kernel.org,
	Barry Song <21cnbao@gmail.com>, Baoquan He <bhe@redhat.com>,
	Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v1] mm/vmalloc: fix page mapping if vm_area_alloc_pages()
 with high order fallback to order 0
Message-ID: <ZrXiBfS-Mv53gFO9@tiehlicka>
References: <20240808120121.2878-1-hailong.liu@oppo.com>
 <ZrXhtprBHew7SL_v@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZrXhtprBHew7SL_v@tiehlicka>

On Fri 09-08-24 11:30:32, Michal Hocko wrote:
> On Thu 08-08-24 20:00:58, Hailong Liu wrote:
> > The __vmap_pages_range_noflush() assumes its argument pages** contains
> > pages with the same page shift. However, since commit e9c3cda4d86e
> > (mm, vmalloc: fix high order __GFP_NOFAIL allocations), if gfp_flags
> > includes __GFP_NOFAIL with high order in vm_area_alloc_pages()
> > and page allocation failed for high order, the pages** may contain
> > two different page shifts (high order and order-0). This could
> > lead __vmap_pages_range_noflush() to perform incorrect mappings,
> > potentially resulting in memory corruption.
> > 
> > Users might encounter this as follows (vmap_allow_huge = true, 2M is for PMD_SIZE):
> > kvmalloc(2M, __GFP_NOFAIL|GFP_X)
> >     __vmalloc_node_range_noprof(vm_flags=VM_ALLOW_HUGE_VMAP)
> >         vm_area_alloc_pages(order=9) ---> order-9 allocation failed and fallback to order-0
> >             vmap_pages_range()
> >                 vmap_pages_range_noflush()
> >                     __vmap_pages_range_noflush(page_shift = 21) ----> wrong mapping happens
> > 
> > We can remove the fallback code because if a high-order
> > allocation fails, __vmalloc_node_range_noprof() will retry with
> > order-0. Therefore, it is unnecessary to fallback to order-0
> > here. Therefore, fix this by removing the fallback code.
> > 
> > Fixes: e9c3cda4d86e ("mm, vmalloc: fix high order __GFP_NOFAIL allocations")
> > Signed-off-by: Hailong Liu <hailong.liu@oppo.com>
> > Reported-by: Tangquan.Zheng <zhengtangquan@oppo.com>
> > Cc: <stable@vger.kernel.org>
> > CC: Barry Song <21cnbao@gmail.com>
> > CC: Baoquan He <bhe@redhat.com>
> > CC: Matthew Wilcox <willy@infradead.org>
> > ---
> >  mm/vmalloc.c     | 11 ++---------
> >  mm/vmalloc.c.rej | 10 ++++++++++
> 
> What is this?
> 
> >  2 files changed, 12 insertions(+), 9 deletions(-)
> >  create mode 100644 mm/vmalloc.c.rej
> > 
> > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > index 6b783baf12a1..af2de36549d6 100644
> > --- a/mm/vmalloc.c
> > +++ b/mm/vmalloc.c
> > @@ -3584,15 +3584,8 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
> >  			page = alloc_pages_noprof(alloc_gfp, order);
> >  		else
> >  			page = alloc_pages_node_noprof(nid, alloc_gfp, order);
> > -		if (unlikely(!page)) {
> > -			if (!nofail)
> > -				break;
> > -
> > -			/* fall back to the zero order allocations */
> > -			alloc_gfp |= __GFP_NOFAIL;
> > -			order = 0;
> > -			continue;
> > -		}
> > +		if (unlikely(!page))
> > +			break;
> 
> This just makes the NOFAIL allocation fail. So this is not a correct
> fix.

OK, I can see a newer version
-- 
Michal Hocko
SUSE Labs


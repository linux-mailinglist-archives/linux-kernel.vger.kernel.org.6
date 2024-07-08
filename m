Return-Path: <linux-kernel+bounces-244610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C2492A6D0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 18:07:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD804B20C31
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 16:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E26F143C47;
	Mon,  8 Jul 2024 16:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="etDppFs1"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BDE2EC7
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 16:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720454820; cv=none; b=ljBQpvheNXcBIDaU17yVZZpQk/N/ke0PgTMW/j0BMSpZz/3k7jUhP/4lDlAOieYxkPZIuD5SasY2CMvyMt5CVPCOPugYXNKmXAng6aw79zNin8h4YKdN+9/fErQAQCT0dCvZx0PNfc49OaKIwIalXYyqpbbQHjbcuhtet1Krxxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720454820; c=relaxed/simple;
	bh=Oj3hsdILNOBqYksTF24ZCDK0pPDq/s+08dH78BrsdaQ=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rVkFJh3zNnBhYdpwkNm8BBlsOaaTQ+k5iWv+/g1gQyDkrvIma/ywG8bvPyKepuxF9hYol5oYuJHZGbPP/tHldPUsZuuHZ8BIIBVXs451LMXyt61IIeRdjVr0iAice0p7K7b4AcNe9s5jL8mQXI/do4xV3WHSM+wmd2GxGMQV+e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=etDppFs1; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-52ea5765e75so4133535e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 09:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720454817; x=1721059617; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ij25sqUdevns5tkTNnYc8JRUONkaiwAFtKXPJUw+bLU=;
        b=etDppFs1itQgPCBbPnJA08SWNN/20ePIf0LZAKuPfOb4vb9BMJ9XszlFRulGxT5/AT
         BKp5fJFvfbr53I38GoOGz3k1D7rJuoq6PxkH6m6QmHmTGy7NBc9gpECjt7r0yJ//4j1l
         kCZoxgsP01RFAFvxEkOUY/vNPGacfwIfUeCZdY2U/qIyxseJ8DEpSMa6p0lfVJc3QpSK
         piGvxiEpUcQycGukjpTp+RJSO4vwgLH2+Alp2lhksIc7/g384kJIXnw9PLzZ/SpWETAG
         zE/nmb5U/j7RYcgWLeNij6HvTyu/oH5ZcespQYde31Dvc6BZWXEjIWIh0U3TPobrMs+P
         SFJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720454817; x=1721059617;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ij25sqUdevns5tkTNnYc8JRUONkaiwAFtKXPJUw+bLU=;
        b=K5aWgfLTB4skMwHUnT9wFbyoh3Hi2Wm/LWkNJeNxNLcqn3OH00N7Gn624WUnJyRaYJ
         MnsoekHl5l5AlJ0z9YNASjgCHXqc4avynWZu8CBKvHC8O54d+QDM8roHxjirFQX9tAuA
         fgWqtELeFXPDyWZB1kFlg4m2ct7oFn4HpTUyyWZFdoFVfOBoxWVKACw82CGTzC+VHkmg
         VezKVm4RC+0llEMuH1uvY3HFhf+v/gjU03XVlqUVjvpAH+0f+R0P12EfkXRYUJ0x60xX
         56IWNHlTEpag4CNl9wicFNpbWw3hO3dNp/p9hjjUXiW09uKpcswyiEY0Ri4SlwXGPudh
         7cfQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+LuoyXAhqEBrkRdBdgVd6gfT+IFrzwMgRk8s4wd8uDIQCFYhQavpX+goKJ6OOK5SeqNIbPP6Yl93n6pJd1DHg1TT56Q1xLpk+i1lu
X-Gm-Message-State: AOJu0YzJwCbpYpKSKUIDdglf2QJcxI6YWABSQcs8b9Jd75PA941b8fWq
	eAGesyk2R4MSViPSf2mMYYlHRlCUzQShMCflcEMXEOYuLdFCeZy0OnuCoQ==
X-Google-Smtp-Source: AGHT+IF/hrw4dhXyNpsl+U7poN/yPOjQGKFeq3B2IbiPefe0FzqELZ9Ys2LIlNm3+EGL+ueuEfb9HQ==
X-Received: by 2002:a19:6a10:0:b0:52e:9b68:d2d4 with SMTP id 2adb3069b0e04-52ea06e76afmr7735829e87.56.1720454817039;
        Mon, 08 Jul 2024 09:06:57 -0700 (PDT)
Received: from pc636 (host-90-233-219-252.mobileonline.telia.com. [90.233.219.252])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52eb8e346a5sm12760e87.35.2024.07.08.09.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 09:06:56 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Mon, 8 Jul 2024 18:06:54 +0200
To: Adrian Huang12 <ahuang12@lenovo.com>
Cc: Uladzislau Rezki <urezki@gmail.com>,
	Adrian Huang <adrianhuang0701@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@infradead.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Jiwei JW10 Sun <sunjw10@lenovo.com>
Subject: Re: [External] Re: [PATCH 1/1] mm/vmalloc: Add preempt point in
 purge_vmap_node() when enabling kasan
Message-ID: <ZowOnkxaFbqxv6sW@pc636>
References: <20240705130808.1581-1-ahuang12@lenovo.com>
 <ZogS_04dP5LlRlXN@pc636>
 <TYZPR03MB619290520C6552B540870C32B3DA2@TYZPR03MB6192.apcprd03.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYZPR03MB619290520C6552B540870C32B3DA2@TYZPR03MB6192.apcprd03.prod.outlook.com>

On Mon, Jul 08, 2024 at 01:39:57PM +0000, Adrian Huang12 wrote:
> Hi,
> 
> > Could you please test it:
> > 
> > <snip>
> > diff --git a/mm/vmalloc.c b/mm/vmalloc.c index 03b82fb8ecd3..6dc204b8495a
> > 100644
> > --- a/mm/vmalloc.c
> > +++ b/mm/vmalloc.c
> > @@ -2190,10 +2190,12 @@ static void purge_vmap_node(struct work_struct
> > *work)  {
> >  	struct vmap_node *vn = container_of(work,
> >  		struct vmap_node, purge_work);
> > +	unsigned long resched_threshold;
> >  	struct vmap_area *va, *n_va;
> >  	LIST_HEAD(local_list);
> > 
> >  	vn->nr_purged = 0;
> > +	resched_threshold = lazy_max_pages() << 1;
> > 
> >  	list_for_each_entry_safe(va, n_va, &vn->purge_list, list) {
> >  		unsigned long nr = (va->va_end - va->va_start) >> PAGE_SHIFT; @@
> > -2210,6 +2212,9 @@ static void purge_vmap_node(struct work_struct *work)
> >  		atomic_long_sub(nr, &vmap_lazy_nr);
> >  		vn->nr_purged++;
> > 
> > +		if (atomic_long_read(&vmap_lazy_nr) < resched_threshold)
> > +			cond_resched();
> > +
> >  		if (is_vn_id_valid(vn_id) && !vn->skip_populate)
> >  			if (node_pool_add_va(vn, va))
> >  				continue;
> > <snip>
> 
> This patch can fix the issue. Feel free to add my tested-by.
> Tested-by: Adrian Huang <ahuang12@lenovo.com>
> 
Thank you. I will add you tested-by!

--
Uladzislau Rezki


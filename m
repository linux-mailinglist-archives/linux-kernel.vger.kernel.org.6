Return-Path: <linux-kernel+bounces-318102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A0F96E85F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 05:45:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A920C1F23B32
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 03:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B13BF3CF74;
	Fri,  6 Sep 2024 03:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SMA7I7Hd"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6A82209F
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 03:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725594329; cv=none; b=Aoj6OJjnlKDuJh+wrYtxxHKF2rrT67NwSXaKWep/XpRfu0qAQV2DqOmHAKuuA6o+my8UTFiGcwxsQ/j1PcE07S5sOu3bw/HTf5nlZ4Wp5tV5DwEMzFnA6hRu8eh4Xk4q0jLdRh+RKqG5ZB0Yo3aU5olyjok99GKS/fOMl3nddm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725594329; c=relaxed/simple;
	bh=tmS0Iuxn7FUKjqUaP7Cnv/FG4YiAn8pcvTwnrjFZ4b4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GKJQ+i3TnMGppUTYVMaPo/t5Q9oLigNSZcBIpWt3cqC8avfk/PlDxPKOjwPfSAnoxKjYuyj0GNyCAUVMmuTodQ1+WHnm2MvTh5OQ/isFDlrDeWu8q4GCM7G3Liplryr5/XGdAOptzs47jTeK0Rjy8X5JEs6mpJcLUdV5jJyZ37Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=SMA7I7Hd; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2021c08b95cso21410635ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 20:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1725594327; x=1726199127; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BRiE3j2lWWDNonCtzpfytk7Skh2+MjpLY1r3ytLzBfM=;
        b=SMA7I7HdPsP71AlbfWN/yfEUeTc0eUlQc1CbBBIlfuTIZ5mUdh1B9mNYkmkRN/zd49
         DWAHFdh1mgMBH8agQButdNzmYPB3HUXyurQftxhjq081FKGxlZfOMvqZa4+80iPx+OLE
         ftpl728UReWLvq5c9U5Reykc2Iy/OeaotVnPQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725594327; x=1726199127;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BRiE3j2lWWDNonCtzpfytk7Skh2+MjpLY1r3ytLzBfM=;
        b=ZlODpYQ3GTa6v0FeGanVkfODNIxEJkY7CG2rYTnl4z0HdDn4ufRrNqaqLnvM1PAEUw
         n3KbI51uE/do6+mPDS4Kwkdz63hqTUe1N7tA/pkVURBZqNGeQrQjvApgLdFs2CPvtkqs
         ToBQomB6yBAJzjvcZ7srD1sHQgQNA4WW9SMpNjSXmc/9dRZgj18o3Hs5gJUf+bW4njHD
         luwHD+t0Eibu0uvrfgR2u+tiTe2g5NaBLYiduktYdRuE6PcOj6mFjd0fmGkIQUmJzWAV
         3Mp09usGDdKyHxKqScZr8hRHijjmzUXlDf1WRzgTByeLnPm0sRWb4uuJY48q+Gi6M6G3
         7Y5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUXdXJsLZZwMlDRIE1dkXevCRiuqiyUTUbnMzYR4yyaWjwsHc5EWfzMTMFgIbsJCV1Wq+p7WIIX2UZwRJ4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8Ap91mD37V840Ez9ddxztZyPvmucLD24OuVfccLzD+frsAHi0
	MocYcCHN18nl7AGUvY9atotPblBMMPHRWrCIDVxq1itKft5SLc1r2xtpmKy48hhxH0F8mtDGtm/
	Nlg==
X-Google-Smtp-Source: AGHT+IG2i7gtVLgmcNdWYpECf0cB9SD4IVkgPpMxdP0UQkDOvw6MrofJ2n4xAc+lfE3VJ7546HG7FQ==
X-Received: by 2002:a17:902:c94e:b0:205:59b7:69c2 with SMTP id d9443c01a7336-206ee93964dmr25225015ad.7.1725594326978;
        Thu, 05 Sep 2024 20:45:26 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:734f:d85:4585:b52d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206ae9131f2sm35553765ad.18.2024.09.05.20.45.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 20:45:26 -0700 (PDT)
Date: Fri, 6 Sep 2024 12:45:22 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Minchan Kim <minchan@kernel.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: use unique zsmalloc caches names
Message-ID: <20240906034522.GA2413563@google.com>
References: <20240905064736.2250735-1-senozhatsky@chromium.org>
 <20240905145209.641c8f127ba353832a1be778@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240905145209.641c8f127ba353832a1be778@linux-foundation.org>

On (24/09/05 14:52), Andrew Morton wrote:
> > Each zsmalloc pool maintains several named kmem-caches for
> > zs_handle-s and  zspage-s.  On a system with multiple zsmalloc
> > pools and CONFIG_DEBUG_VM this triggers kmem_cache_sanity_check():
> > 
> >   kmem_cache of name 'zspage' already exists
> >   WARNING: at mm/slab_common.c:108 do_kmem_cache_create_usercopy+0xb5/0x310
> >   ...
> > 
> >   kmem_cache of name 'zs_handle' already exists
> >   WARNING: at mm/slab_common.c:108 do_kmem_cache_create_usercopy+0xb5/0x310
> >   ...
> 
> This is old code.  Did something recently change to trigger this warning?

The kmem_cache WARN_ON() seems to be a new thing 4c39529663b93
and I think for the past week or so my test box has been running
with DEBUG_VM disabled.

[..]
> >  static int create_cache(struct zs_pool *pool)
> >  {
> > -	pool->handle_cachep = kmem_cache_create("zs_handle", ZS_HANDLE_SIZE,
> > -					0, 0, NULL);
> > +	char name[32];
> > +
> > +	snprintf(name, sizeof(name), "zs_handle-%s", pool->name);
> 
> Always scary seeing code making such assumptions about it arguments in
> this fashion.  Can we use kasprintf() and sleep well at night?

Sure, I'll switch to kasprintf() "pillow" in v2.

[..]
> >  	if (!pool->zspage_cachep) {
> >  		kmem_cache_destroy(pool->handle_cachep);
> >  		pool->handle_cachep = NULL;
> 
> I guess we want to backport this into earlier kernels?  If so, what
> would be a suitable Fixes:?

So this doesn't affect zsmalloc, it's only some user-space tools that
can get confused.  The code in question has been around since forever.
The first kmem-cache has been introduced by 2e40e163a25a in 2015.

I'll add Fixes: 2e40e163a25af3 in v2, but I'm not certain if we are
in urge to backport anything.


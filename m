Return-Path: <linux-kernel+bounces-311712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D70968CA0
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 19:03:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE1EF1F2302B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 17:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E4561AB6E0;
	Mon,  2 Sep 2024 17:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="heMRINIw"
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81EDF13D50A
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 17:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725296576; cv=none; b=fm1CM2kf6EDJ+SxvEmMtbB7tS/KUrtj3jtW+dv0eRDAxPPo24oOrn9kkFZ+B1X91fals7t+jQhlCORrTkhOYcWexyt94uZNk9RjEHOYdZ6/BcCGkAxDesNfqBd/gbCSzBoX59yz4/tgbDLgwn1mZCkSDtJO7z1gmoXyyDbtCBXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725296576; c=relaxed/simple;
	bh=GItaJCFiStFIeQKRW1d8zEZ3Oh3HVvfv05HzW+SIQR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UgDvbuEhai6MHOLCif1RG3RTttA1MmWKG2aDrehTTUFzlJp/pTPaf70owx1NzAPY7oGYoDAzMn6B4MLeT3p4GSYCmiYbiQZqopmHagktmXqHF2fPf2prK3/ytBP6/2qDNkDLFOZjYsFlKgFd4g08JKXzwkrUcnNpA+aUsBOfLsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=heMRINIw; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-82a205810ccso213548739f.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 10:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725296575; x=1725901375; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CZVOdmbajPOyilhVT2ENHokoQg+1tObNsMtDHCqaHb8=;
        b=heMRINIwubreoy4AXUhpWqYO24FjKsG9xFDyFd4twnphDjlXi6xhixbVInqnM9XhCq
         EF0k8/L6ziFNjfEQgBVcC8ZkSu8DlKI6NjXZd8u68EMrWDcEkYO9QvqDs+jd9kkNEumG
         BFVRSgDIC5Dcf2BzwiTeUQcMq7xbdBwYeAqaezCr5Eni1xXGqmZ/Xkpdtx6t5buZnY6S
         uFexlMz/vw8tby5s3tnfw6RjH8nYOq1Afu/IwpE5JeVHm3oMl3mNyFAtGJkcNn5I+vhe
         m+H1qUCt/VlRrxbX0OoQSX/lWr605U4ykei0xlWzCIwP9MxMBA2vjxkCgObk8wJlnfMn
         t6oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725296575; x=1725901375;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CZVOdmbajPOyilhVT2ENHokoQg+1tObNsMtDHCqaHb8=;
        b=fZnojd8Kk7mILE9wyALYs2TRXSbmr94M4BFXJJ+UCxfYyubZC645n2qwPfIT0QX9nU
         tOc2+BIKgYk+hJ6yHGRH/iFytF42qhM/WuIYCzcQtRvtpXwwYdvf8cWhaEQZES2LP7Rz
         8SGsXlIlqT1VCES/MW48lo7cEndJaOec6unxwlxF6E5ur+Qeu1Xf5lbOB2y5bddPPLOP
         0BHAmX19Zqfm+YMoJ/c5yGWZtv8C+JxJGaw4Tt18qEEWC1VsFN9Fo3kEUW1tWq3Cr3vA
         WvL/n5rvV8Y9d2zaFnGjvHpXFcMNFpkAt5OW/Y331h893owu+kq/8c1U23FrluyvaXJJ
         20Bg==
X-Forwarded-Encrypted: i=1; AJvYcCWlz6M0ufxDWbRJR01U+FGUIuLH9UL9PgpK2DFEaejoisY/5gx4qQy1e4Wwxe9Hq8/FkM1BbNJSDYUNeS4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxT5K4U2Dzf/AT7TxR/Rax+b4V/qvXtYTfLViEeGqm5C2ZfzTYJ
	jiGfJNuEF0W5k2lX6tIT7EtRv53/D4HDiJHzC2IT/TghCRkO67JKy7pm2+lMAg==
X-Google-Smtp-Source: AGHT+IEMq7TZba2SLvaof/QHOP04CrSz+gFKDPNws1yOGU0WvsF0B64Ea9P5fwxfXowGNjz7299f3g==
X-Received: by 2002:a05:6e02:2196:b0:39e:3952:6dd4 with SMTP id e9e14a558f8ab-39f4f55eedbmr91478485ab.20.1725296574248;
        Mon, 02 Sep 2024 10:02:54 -0700 (PDT)
Received: from google.com ([2a00:79e0:2e28:6:485e:a0d2:7c59:d251])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ced2dcdfbcsm2228970173.29.2024.09.02.10.02.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 10:02:53 -0700 (PDT)
Date: Mon, 2 Sep 2024 11:02:46 -0600
From: Yu Zhao <yuzhao@google.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Muchun Song <muchun.song@linux.dev>, Zi Yan <ziy@nvidia.com>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH mm-unstable v2 1/3] mm/contig_alloc: support __GFP_COMP
Message-ID: <ZtXvtnc2Cf8xWU7d@google.com>
References: <20240814035451.773331-1-yuzhao@google.com>
 <20240814035451.773331-2-yuzhao@google.com>
 <Zsdz-NFl4oqZ37_h@google.com>
 <ZseGjKXaZIvgu9vQ@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZseGjKXaZIvgu9vQ@casper.infradead.org>

On Thu, Aug 22, 2024 at 07:42:20PM +0100, Matthew Wilcox wrote:
> On Thu, Aug 22, 2024 at 11:23:04AM -0600, Yu Zhao wrote:
> > Andrew, could you patch up the line above? This is what it's supposed
> > to check:
> > 
> > diff --git a/include/linux/gfp.h b/include/linux/gfp.h
> > index 59266df56aeb..03ba9563c6db 100644
> > --- a/include/linux/gfp.h
> > +++ b/include/linux/gfp.h
> > @@ -452,7 +452,7 @@ static inline struct folio *folio_alloc_gigantic_noprof(int order, gfp_t gfp,
> >  {
> >  	struct page *page;
> >  
> > -	if (WARN_ON(!order || !(gfp | __GFP_COMP)))
> > +	if (WARN_ON(!order || !(gfp & __GFP_COMP)))
> >  		return NULL;
> 
> I don't think we should do this at all.  Just this should be enough:
> 
> 	gfp |= __GFP_COMP;
> 
> same as folio_alloc() (or now folio_alloc_noprof()).
> Do we really caree if somebody tries to allocate a gigantic page with an
> order of 0?

If this ever happens, I'd bet it's a bug.

> It's weird, but would work, so I don't see the need for the
> warning.

So the warning could catch that, but if we think it's verbose, then
please fold the following in:

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index a951de920e20..b43934d79dd9 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -452,10 +452,7 @@ static inline struct folio *folio_alloc_gigantic_noprof(int order, gfp_t gfp,
 {
 	struct page *page;
 
-	if (WARN_ON(!order || !(gfp & __GFP_COMP)))
-		return NULL;
-
-	page = alloc_contig_pages_noprof(1 << order, gfp, nid, node);
+	page = alloc_contig_pages_noprof(1 << order, gfp | __GFP_COMP, nid, node);
 
 	return page ? page_folio(page) : NULL;
 }


Return-Path: <linux-kernel+bounces-535972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28016A479E5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 11:13:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 178973A7677
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 10:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7CE9228C99;
	Thu, 27 Feb 2025 10:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nfJv8Rw/"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA57335C7
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 10:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740651209; cv=none; b=QDwRZLK3MGT6vUloqNi2F4GHHTf9Ki9qbc7MhASht3r+yI8nxWmgAd4ACjqcmu9+DPWucR6L7ukS6l19pPNZr6vX7QMUM1SogxQHvvGLBvdOXagAv38EekkhUH80rbQPy8CE2IJzc1eFXHN33zeBMDvCU4li+jlnBdM/VCrfCRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740651209; c=relaxed/simple;
	bh=Q4E8tgpzEj+Dck5Mr6oTcUb+18z1y2x916AODIIt5Nk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QB7Kh/QwP4mjM+aY8zFz6mkYTb6c0hQpbNxXpNwhksgEaIfSr1wDG1Amc9ZJ2I5PsVXeQ3blYNCNxQNE1ULL60j1U652TvRHI1VLVX+NIUOYHIsw6VBEexlafnaR2BOZwYHnnl9U/ayaSH2JpjmGiZ4j1RZi56SzkcJIlpG3U/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nfJv8Rw/; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-438d9c391fcso44745e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 02:13:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740651206; x=1741256006; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OVuAlhVfTzJKU2iFaYa/qiEZ8SOesoanaitSjfgOFaM=;
        b=nfJv8Rw/WwOns2l7syPnPK0BY1xqxzMCGTDGBN76O+EqBV1hlt2p6xMngMBFdqbBTQ
         T0cJhM0nIp2pB1OE2spMoPteumkpH2bcjNEVYutmpRR/SAvezti4d5iYC29kYHVOqmYM
         J+vrmr131SzMB/cril2hR0bWUv48b79chBT8+fb91Jw7zM+NrYj1hxV1ZQ++69GQrN6P
         KygKzfLt9wceSfnAAzji9jpXtmnsM/f3+eTdJlYGLJZjFF4NP1QMwtRVp5RtMgn2IgPz
         K5gwv3p724J6a+NpuiK5uwTqTVw9A/iZZh5Utq59vEA2GkiV+0hEDxdoAei8ZlLAumTw
         Rydw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740651206; x=1741256006;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OVuAlhVfTzJKU2iFaYa/qiEZ8SOesoanaitSjfgOFaM=;
        b=VrlvXe9oMVLsvpbzJe4r2s0RI5xc/WUedXZkQ5wpKl6BgDNoeHh9OlklTHv4hKR2x8
         PW4N8VhLn9PlpWBR5lGfCIgAU75p25YKrE5zbcq9iWkfsGVwS8mdeD/cm/WiPLoqwGPH
         uf/XBDwnTcaVPeu1xFplt12OepPbxa9rHK9tLnDDDtqNOMNNMXN7sQXq/1drgY5ahbsk
         noJBLHeRA3/1kyBPA8ufcPxBMp87r2YoIEtGMvBCJwGQbnQTrCI8jYlAq57Di5K1/0NJ
         SiWgrkiPOJ505O4v7l+oYyu6p2ln7NgAbVUKx1f6aoh2PtFcWuvy4rnLgV/WopMewDg3
         hXBA==
X-Forwarded-Encrypted: i=1; AJvYcCXdS8WcpHABWCFIu/VC20/SVNaY3FF7daS5avSKbYL9ClsHtNrWHZum+0bIycFF2K8FZpYLxyGS5T9572s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZl24GRnJ8/8x5S3OJ4qjp4v//N+JgSdEAboKpVENHEWF2J0j9
	VzBH5p4aNX3Vpg/w4EFz7+XALklDOYtNmDOvm5Wl9GODeVmTIJklYir4F3kM1g==
X-Gm-Gg: ASbGncuAyIRqZJ7jXYDtX6a63mnoycp0oE1rhu4+LPwjp8TVdNlBZL4rvhF/0gkaIor
	m16PKFZg1J7t0NGqhgKRbhUXiG87GtqS59n1/utNqAJKjf7xCXDTSQnosGeU22caKIgolaFUk24
	haT/3wy/thKygylWl2LOlCbd0MyjSmbwiJwa3PRheMwDQ4h2SZ1Nj3f7YpLRn9XFBH2TfNTkZAq
	fDnkfONC6sNfVG1SF9LgSi6RImlrrZdUwZmMue0ipcfctrjuJuukRJSd+uuM6FndbVQDQG8GXty
	Z0+Dj3QnLJAaOmrPhdu+DIyVnp9NZH2pzvp9hOLrxJdaC6FaqHZbSHkpmn0RuQ==
X-Google-Smtp-Source: AGHT+IFb7iEscj4MTGrmiEQToaJSvpkhlzspgfd6Jz4xpwx75rGqasMK8FmypS0Tw2qVP0knB/rUbg==
X-Received: by 2002:a05:600c:8a8:b0:439:8c80:6b0c with SMTP id 5b1f17b1804b1-43b38674dc0mr879725e9.0.1740651205681;
        Thu, 27 Feb 2025 02:13:25 -0800 (PST)
Received: from google.com (44.232.78.34.bc.googleusercontent.com. [34.78.232.44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47a6a6csm1565808f8f.30.2025.02.27.02.13.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 02:13:24 -0800 (PST)
Date: Thu, 27 Feb 2025 10:13:19 +0000
From: Brendan Jackman <jackmanb@google.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Mel Gorman <mgorman@techsingularity.net>,
	Michal Hocko <mhocko@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Yosry Ahmed <yosry.ahmed@linux.dev>
Subject: Re: [PATCH v3 1/2] mm/page_alloc: Clarify terminology in migratetype
 fallback code
Message-ID: <Z8A6v2V8l8c4VaSA@google.com>
References: <20250225-clarify-steal-v3-0-f2550ead0139@google.com>
 <20250225-clarify-steal-v3-1-f2550ead0139@google.com>
 <dae2179c-1562-447c-a4fc-d415b4a9ebfc@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dae2179c-1562-447c-a4fc-d415b4a9ebfc@suse.cz>

On Wed, Feb 26, 2025 at 04:08:09PM +0100, Vlastimil Babka wrote:
> On 2/25/25 4:29 PM, Brendan Jackman wrote:
> >  /*
> >   * When we are falling back to another migratetype during allocation, try to
> > - * steal extra free pages from the same pageblocks to satisfy further
> > - * allocations, instead of polluting multiple pageblocks.
> > + * claim entire blocks to satisfy further allocations, instead of polluting
> > + * multiple pageblocks.
> >   *
> > - * If we are stealing a relatively large buddy page, it is likely there will
> > - * be more free pages in the pageblock, so try to steal them all. For
> > - * reclaimable and unmovable allocations, we steal regardless of page size,
> > - * as fragmentation caused by those allocations polluting movable pageblocks
> > - * is worse than movable allocations stealing from unmovable and reclaimable
> > - * pageblocks.
> > + * If we are stealing a relatively large buddy page, it is likely there will be
> > + * more free pages in the pageblock, so try to claim the whole block. For
> > + * reclaimable and unmovable allocations, we claim the whole block regardless of
> 
> It's also "try to claim" here as it may still fail due to not enough
> free/compatible pages even for those migratetypes. 

Yeah thanks, I seems worthwhile to be precise about this.

> Maybe the question
> (out of scope of the patch) if they should get a lower threshold than
> half. Before migratetype hygiene, the "we steal regardless" meant that
> we really would steal all free pages even if not claiming the pageblock.

I wonder if there's some benefit to deciding when to claim blocks also
based on the count of blocks per type or something? Like, if we're
under memory pressure so all the freelists are empty, but there are
already a bunch of unmovable blocks (that currently have movable pages
in them), there's not much point in claiming a block, instead we'd
prefer to reclaim/migrate those movable pages?

> > + * page size, as fragmentation caused by those allocations polluting movable
> > + * pageblocks is worse than movable allocations stealing from unmovable and
> > + * reclaimable pageblocks.
> >   */
> > -static bool can_steal_fallback(unsigned int order, int start_mt)
> > +static bool should_claim_block(unsigned int order, int start_mt)
> 
> So technically it's should_try_claim_block() if we want to be precise
> (but longer).

Yep, that seems worth it (especially given the function is effectively
just an internal block of find_suitable_fallback()).

> >  {
> >  	/*
> >  	 * Leaving this order check is intended, although there is
> >  	 * relaxed order check in next check. The reason is that
> > -	 * we can actually steal whole pageblock if this condition met,
> > +	 * we can actually claim the whole pageblock if this condition met,
> 
> try claiming

But I think in this case we really do claim unconditionally.


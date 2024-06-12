Return-Path: <linux-kernel+bounces-211043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4338904C76
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 09:13:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50B9B1F22758
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 07:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADA41167270;
	Wed, 12 Jun 2024 07:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1qArx1gZ"
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E5E10E3
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 07:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718176376; cv=none; b=i67NQM/+zb2f+izwgdOrHsZt0rwhakHpMAvRM9DcBg0AvSdAYPN3s6or7+vl4eR9CiVqW5gz3o5Z1c5APtN9Yk2e6iYfRQQR5zbVqYn3gx6VL+64cMDmFGAbRkOAjuQYy1RSvSCsKpIR4spri0Ik580qeM7wffeJ1bQ5zvb8K8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718176376; c=relaxed/simple;
	bh=bWmPV6zH+00LNRa/Lq/Qu/NJkeEUZA0PBXWUxkT45sc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Q1QhKeOOEXDScsGRyn5xrgNF5ImU35Ca9p0G2nEu78DElHqI1GGAhNKuN13NV74xHKB5TAaYIE1Jn7YdKxy+LJratGNOjJ4BASyKvpOBU/0vMM2SOfwJubDOLnnWrxf3ow7uWldtTSlmDCUUJ6UY+O3VUmX3/YeOR/ls10ViB6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1qArx1gZ; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-627ebbefd85so74805037b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 00:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718176373; x=1718781173; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TMOlbMWIhtv5ZW8KP7JxP56vtG6g5t81RVE9Y7uaV7Y=;
        b=1qArx1gZXgR3Fb+JBPOUBxY/NHXRtNJqTxs52GcTmo5zEJrpH4TnnR8IfX67qcsynV
         kNX7fzQbX5OiY26vFCaB3DDmMjpFHDMJondoeYW3BQnmZi1kJC+U56YtPDUO1vM25bsK
         xrSIx9hQjb+ocg8u/BVAmm/v/Yza/NbJ8zbpROzb0fff4KkLTsK5hsFpI+QEcECqMz/E
         yR3+tgYNYSuH9SNx3eQxniSoAC2jBG4E0xyoq4mM3layjN9gMazCM5+0rbhSzjU1RPFf
         BDNnWF8WhMpXyjtTqo2iER6wnMNtEwJzaSQKbIrVjVqAOjOxhLTDMw2k6aLJ2AE0KJGK
         YguA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718176373; x=1718781173;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TMOlbMWIhtv5ZW8KP7JxP56vtG6g5t81RVE9Y7uaV7Y=;
        b=WpXNqB/jtk7DqmPl45vpUppHeFZ3lZMC7Q63gdsumQS7DX1jVhvOB+k8xGjnyYFvpu
         coYryY6R+8mlrJH38UO2a2TnVIRYG2P0uAR0q7pY15tQTSel/Z8bN3E1pI8iR/LXVALD
         +p5ZRM7VfcDwaUq1tr64I9OL23fztSSL1TzV062RpzSjnBXadxJuZk52DJYjKHBPJ/A4
         gAuGEeFGlNQfmF/mSaohlsDn0JALk4oXXdlT18KA+e5aAphftIdZdZvkg+8gKBpzoPP5
         hcYnVO0s4HvT4BXACr7xb1U4g51eZkSM2UCoO4epqTAEz5ygRhK+xpJIwE3D9mt95k99
         fpEA==
X-Forwarded-Encrypted: i=1; AJvYcCUDnOXLlndVxetmE7OAREdPgdZ3jqLm3JEFeDhD6boh8yOTDmLl4YW5DyzkYTtg67YIb0KLDsYhfs8pjEsFuVrF2LB81YYEsrlQ4uLv
X-Gm-Message-State: AOJu0Yz2lwlhdWLE6B6UvX0f36A4DVD1zVLYccSjSyLBfuABy/8YgXnF
	LC+7eOb6h3e4XTpKx2QDwGnbpd0z0lBqVX+GskmfqRFPwSbowMCVld3mYQ/J+A==
X-Google-Smtp-Source: AGHT+IH0dmFmSjBcBYJtXLX0exAkEh9EbUtyjH05fvRAz6s6k57nB3NLMTAcldBKNgeVxbCzwIVzzA==
X-Received: by 2002:a81:e204:0:b0:627:e16f:ecf with SMTP id 00721157ae682-62fbc3dc394mr9487627b3.30.1718176372872;
        Wed, 12 Jun 2024 00:12:52 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-62d73441eafsm7464457b3.62.2024.06.12.00.12.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 00:12:52 -0700 (PDT)
Date: Wed, 12 Jun 2024 00:11:44 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: "Huang, Ying" <ying.huang@intel.com>
cc: Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
    Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
    David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org, 
    linux-mm@kvack.org
Subject: Re: [PATCH hotfix] mm/migrate: fix kernel BUG at
 mm/compaction.c:2761!
In-Reply-To: <87msnq7key.fsf@yhuang6-desk2.ccr.corp.intel.com>
Message-ID: <c3136c09-5120-1ca3-3470-0c947605a816@google.com>
References: <46c948b4-4dd8-6e03-4c7b-ce4e81cfa536@google.com> <87msnq7key.fsf@yhuang6-desk2.ccr.corp.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 12 Jun 2024, Huang, Ying wrote:
> Hugh Dickins <hughd@google.com> writes:
> 
> > I hit the VM_BUG_ON(!list_empty(&cc->migratepages)) in compact_zone();
> > and if DEBUG_VM were off, then pages would be lost on a local list.
> >
> > Our convention is that if migrate_pages() reports complete success (0),
> > then the migratepages list will be empty; but if it reports an error or
> > some pages remaining, then its caller must putback_movable_pages().
> >
> > There's a new case in which migrate_pages() has been reporting complete
> > success, but returning with pages left on the migratepages list: when
> > migrate_pages_batch() successfully split a folio on the deferred list,
> > but then the "Failure isn't counted" call does not dispose of them all.
> >
> > Since that block is expecting the large folio to have been counted as 1
> > failure already, and since the return code is later adjusted to success
> > whenever the returned list is found empty, the simple way to fix this
> > safely is to count splitting the deferred folio as "a failure".
> >
> > Fixes: 7262f208ca68 ("mm/migrate: split source folio if it is on deferred split list")
> > Signed-off-by: Hugh Dickins <hughd@google.com>
> > ---
> > A hotfix to 6.10-rc, not needed for stable.
> >
> >  mm/migrate.c | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> >
> > --- a/mm/migrate.c
> > +++ b/mm/migrate.c
> > @@ -1654,7 +1654,12 @@ static int migrate_pages_batch(struct list_head *from,
> >  
> >  			/*
> >  			 * The rare folio on the deferred split list should
> > -			 * be split now. It should not count as a failure.
> > +			 * be split now. It should not count as a failure:
> > +			 * but increment nr_failed because, without doing so,
> > +			 * migrate_pages() may report success with (split but
> > +			 * unmigrated) pages still on its fromlist; whereas it
> > +			 * always reports success when its fromlist is empty.
> > +			 *
> >  			 * Only check it without removing it from the list.
> >  			 * Since the folio can be on deferred_split_scan()
> >  			 * local list and removing it can cause the local list
> > @@ -1669,6 +1674,7 @@ static int migrate_pages_batch(struct list_head *from,
> >  			if (nr_pages > 2 &&
> >  			   !list_empty(&folio->_deferred_list)) {
> >  				if (try_split_folio(folio, split_folios) == 0) {
> > +					nr_failed++;
> 
> It appears better to add
> 
>         stats->nr_thp_failed++;
> 
> too.  Otherwise, if migrate_pages_batch() is called via migrate_pages(,
> MIGRATE_ASYNC, ), nr_thp_failed will not increase.  But if
> migrate_pages_batch() is called via migrate_pages(, MIGRATE_SYNC*, ),
> nr_thp_failed will increase in migrate_pages_sync() via
> 
>         stats->nr_thp_failed += astats.nr_thp_split;
> 
> That is, they are not consistent.  The issue exists since commit
> 7262f208ca68 ("mm/migrate: split source folio if it is on deferred split
> list").

Sorry, I'll have to let you take over and send your own patch instead
of mine - thanks. Those stats, and any attempt at consistency there,
is way beyond me! I thought consistency was impossible, unless all
the numbers were changed to order-0 counts.

Hugh

> 
> Otherwise, this looks good to me.  Thanks!
> 
> >  					stats->nr_thp_split += is_thp;
> >  					stats->nr_split++;
> >  					continue;
> 
> --
> Best Regards,
> Huang, Ying


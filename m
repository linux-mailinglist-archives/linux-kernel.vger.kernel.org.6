Return-Path: <linux-kernel+bounces-210607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9C5390462F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 23:18:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 572471F250A5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 21:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C9A3152E17;
	Tue, 11 Jun 2024 21:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xBJFypon"
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56453101E2
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 21:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718140722; cv=none; b=u9RDQedNLPqEoEYCIFzhoEEts7XnrmqJHRYu2c6jH21ZRYZ1Qo4oGFmqk9tSS286gtlOHpun1QOG+AaKQCFOjIg8bbtnuiGEo2uIktlPbHhMtKVz2BaKeXWC3LlmVzpxhy5Tav0RpH/RlMBtGR2qc/UKR4hqMCqSH09l1FoEzY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718140722; c=relaxed/simple;
	bh=zu3/9zQK0TUjqXDR0TedIcN8aVtw+181ffBvhey+mLk=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=rulKTfjyQ3CurvUFtONfmWAhSBfN/a6TGMYOxATrmBcUmFR0SujBvyv/TW+cncsigq30RAVvQUFkt2ey1YfhgRBv9nGd3bwtKp5lt3ncgCILTmxlSPlMMJP3n7ZLmsYROILoMXJa4WLKspMr70KqXS5Hd4AQzlu0rjAv/Ul0imU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xBJFypon; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6f8ffe1b65dso142301a34.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 14:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718140720; x=1718745520; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fvB+gfoJoXeVl+lhhEV3yEXvt6h862UlHHqZzX45oE4=;
        b=xBJFypon7q+lRRpL7krxix6LrO6rhYRT0c1cGbnlJkP11KTzi/Vuu4b2qRT0lxvzLC
         otFnKF2Cp0WCBsKgb/qUM9j0cQJRSoB7wM9JJjbOxTADnxQ4k3y3URAP3ITngy66Byil
         7jqeoCPNAwAEjAwe/uLkoxcRRwnkWlwleGClqvRyXCJc2+oU3+y92SibcVUt48NwKSWG
         bqwW98btsjTDcBvslalGNgq8pBui0VJDr6AadWD/5p7I2wYWo9afxqV7gc7vQymW2HwA
         cSOjgquA9XZUud2iHZlKxvCBhGZpUgM7yqzWt1fEVsILSDj+7wnxImmmzxghk0hjryqG
         pHBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718140720; x=1718745520;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fvB+gfoJoXeVl+lhhEV3yEXvt6h862UlHHqZzX45oE4=;
        b=q0pZhNzBJhKfFtPh30DfmWMXP3WHGf9m5y3ZyQ/CGDKI9Jjl8Kv1FPVAw/FhrXBw3o
         r5mB9Rg+FxwQaabg36FV7i5zZ7tJsR2Nsaj7TDlRYpN6RzggsSgwhKkkt5CWQu5l3s3Z
         JtIJzM3Gw6UsueFajZ5b9nhAe+iRcVifjTvBcE2B+T+VtduwyzRzChpkL5j1WuSrUZ8L
         OJmjyiweolo+CxnGZrbqivp3rO3r8zRtstJQCVNnTBG5HjBDRM120P2VjwqyE3D0FgCf
         IwC/5f8XBDQFDxhjUBqFE/FFBoDV2G7wkagAl8kFi9HrvCl4fifkAB/LZuw7PfXDPkSP
         0W3Q==
X-Forwarded-Encrypted: i=1; AJvYcCV+hiTfB2vBeeATvdAkqgfPt2uLuBSqpqCkuMJisMop8CwwMi3sQJnaxHc14D0SUroHjFFcLm99MBsFc8ZO/F8XvEiE6bMp95HiA/16
X-Gm-Message-State: AOJu0Yy/n/1miRFvbweBD8wOphP+VoDyfclz630ISYOnyNz1zhgLw20h
	ndLO4WuWX4nVe2VeNJBbsQ3hh29TfmvoyRAQDk/VBpVp39zM6nwX/B4tvW55bA==
X-Google-Smtp-Source: AGHT+IHtI6HyTJGjUFNRinlcNeOITCqdXEyYKuxKDcRqQ0rmDDupDA0s7u85tzBm1kDjKvsJ+e+YQw==
X-Received: by 2002:a9d:6e08:0:b0:6f9:afdc:8554 with SMTP id 46e09a7af769-6fa19a0d88cmr76471a34.15.1718140720107;
        Tue, 11 Jun 2024 14:18:40 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-6f9c7f4572csm769491a34.10.2024.06.11.14.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 14:18:39 -0700 (PDT)
Date: Tue, 11 Jun 2024 14:18:27 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
cc: Matthew Wilcox <willy@infradead.org>, David Hildenbrand <david@redhat.com>, 
    Andrew Bresticker <abrestic@rivosinc.com>, linux-mm@kvack.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/memory: Don't require head page for do_set_pmd()
In-Reply-To: <20240611130729.d53cbcd1767f917b47540cca@linux-foundation.org>
Message-ID: <1786b46a-ab24-6032-6a60-93b3e3870c7c@google.com>
References: <20240611153216.2794513-1-abrestic@rivosinc.com> <8040793f-e9e9-4a2e-807c-afcb310a48f5@redhat.com> <20240611110622.8e9892e92618ddc36bca11b7@linux-foundation.org> <ZmiVy8iE93HGkBWv@casper.infradead.org>
 <20240611130729.d53cbcd1767f917b47540cca@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 11 Jun 2024, Andrew Morton wrote:
> On Tue, 11 Jun 2024 19:22:03 +0100 Matthew Wilcox <willy@infradead.org> wrote:
> > On Tue, Jun 11, 2024 at 11:06:22AM -0700, Andrew Morton wrote:
> > > On Tue, 11 Jun 2024 17:33:17 +0200 David Hildenbrand <david@redhat.com> wrote:
> > > 
> > > > On 11.06.24 17:32, Andrew Bresticker wrote:
> > > > > The requirement that the head page be passed to do_set_pmd() was added
> > > > > in commit ef37b2ea08ac ("mm/memory: page_add_file_rmap() ->
> > > > > folio_add_file_rmap_[pte|pmd]()") and prevents pmd-mapping in the
> > > > > finish_fault() and filemap_map_pages() paths if the page to be inserted
> > > > > is anything but the head page for an otherwise suitable vma and pmd-sized
> > > > > page.
> > > > > 
> > > > > Fixes: ef37b2ea08ac ("mm/memory: page_add_file_rmap() -> folio_add_file_rmap_[pte|pmd]()")
> > > > > Signed-off-by: Andrew Bresticker <abrestic@rivosinc.com>
> > > > > ---
> > > > >   mm/memory.c | 3 ++-
> > > > >   1 file changed, 2 insertions(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/mm/memory.c b/mm/memory.c
> > > > > index 0f47a533014e..a1fce5ddacb3 100644
> > > > > --- a/mm/memory.c
> > > > > +++ b/mm/memory.c
> > > > > @@ -4614,8 +4614,9 @@ vm_fault_t do_set_pmd(struct vm_fault *vmf, struct page *page)
> > > > >   	if (!thp_vma_suitable_order(vma, haddr, PMD_ORDER))
> > > > >   		return ret;
> > > > >   
> > > > > -	if (page != &folio->page || folio_order(folio) != HPAGE_PMD_ORDER)
> > > > > +	if (folio_order(folio) != HPAGE_PMD_ORDER)
> > > > >   		return ret;
> > > > > +	page = &folio->page;
> > > > >   
> > > > >   	/*
> > > > >   	 * Just backoff if any subpage of a THP is corrupted otherwise
> > > > 
> > > > Acked-by: David Hildenbrand <david@redhat.com>

Acked-by: Hugh Dickins <hughd@google.com>

> > > 
> > > You know what I'm going to ask ;) I'm assuming that the runtime effects
> > > are "small performance optimization" and that "should we backport the
> > > fix" is "no".
> > 
> > We're going to stop using PMDs to map large folios unless the fault is
> > within the first 4KiB of the PMD.  No idea how many workloads that
> > affects, but it only needs to be backported as far as v6.8, so we
> > may as well backport it.
> 
> OK, thanks, I pasted the above text and added the cc:stable.

Yes please. My interest in this being that yesterday I discovered
the large drop in ShmemPmdMapped between v6.7 and v6.8, bisected,
and was testing overnight with a patch very much like this one of
Andrew's. I'd been hoping to send mine today, but now no need.

> 
> I didn't move it into the hotfixes queue - it's a non-trivial
> behavioral change and extra test time seems prudent(?).

It is certainly worth some test soak time, and the bug might have
been masking other issues which may now emerge; but the fix is
just reverting to the old pre-v6.8 behaviour.

Thanks,
Hugh


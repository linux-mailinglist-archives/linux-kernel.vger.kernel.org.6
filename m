Return-Path: <linux-kernel+bounces-385192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9C649B33CC
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 15:39:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC78B1C21C5E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 14:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 742D51DDC36;
	Mon, 28 Oct 2024 14:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="P/wM7bKN"
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473EB1DB350
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 14:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730126370; cv=none; b=jRH9GXfM+hfUPhE1jyrtU3v6lUIgZQwU6CM2KyhKXaUxahlN6S0h1QaZaA5HKpFu4KjWyY9GC9gFHIswtpFXhAQlO1d9jhrbg165cvurMNv4ACAmlo/lUo7X+cL091f36/Ma59vSIgYbv6QyGjn1JuIXY4fnN5sEtDw+tVlxxIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730126370; c=relaxed/simple;
	bh=nnjEKXE9CLpAUhrOtzPdJiPSKnNn5eJZkaCo6zvcaJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HY8zJ7eb70Yybz5/2D2dohz6BxIM0FyLbvjjQMcohQLZHtNnSg3usjvXqHdQW9TEqrmJ3co5PqfePMmwCnp78jhK/Xq3Vs274lfd5UdGnyp/10uTmIPLqBG3mdYruMT4850mK9A35I+z5+PO5HwDnPAFeM3/utrXgkrcMPjOZ6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=P/wM7bKN; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7b1601e853eso347019385a.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 07:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1730126367; x=1730731167; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ugG/qQ91MoDgp/XfSym9AwO2ZJCFXAJqXvA7n9+izLE=;
        b=P/wM7bKNp6y1+uvuxzcPnuZk1WECPu65rEacczpa7hBM8Mft2wxQNdjNWRLkdRoGvo
         RlTz7UvOQSW1m3hoGhRD3kLab1FSEMhVVz1iuZ0SDvxpu1ry1nUjpZ3Uy5A6dE7M8ZQI
         af/15Ve9AN87iG8z976omZxodmAcx4O0m1H1Anxd9DAUyEA8Yis1OQAIezgGihNotqEu
         OO95u6JtcbE03wcGirrmIxIfgaI2OW/c3z4fNonJ55S3PS67GsJSMjPPWBijUTf4BpPg
         dXCyGsTLltXG9wxWzob/PUSeO5zMTbSmH3k8keGPqn58MKdIG3l/iS+r6EoQ4J+XpVZO
         wZRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730126367; x=1730731167;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ugG/qQ91MoDgp/XfSym9AwO2ZJCFXAJqXvA7n9+izLE=;
        b=idwtlQf00HtqTE3ykUYyGsXGkah8xPujllMfDD7aPeQeUIuVNZ8l8niH5GjYreQ7JK
         4LjoDy4HQWGg0yo2YVOuisnAepDagnBt1QMK+C5NNfNf+U/Ijm6PHsH8hcEepIRiMjrb
         NvaAZ97vU8shflIFj/0ZPYZAGTtVNYoH3TG/EoD/Y0TseuiNjxU0CuVvNRWLa9/DRWwN
         1Ningbhm9iWOHCOxZ3c20MgPhdJl8JmQZ7VqpT5QXyUJpX+/JJAv9/A/f2bkRUGUkYlF
         HN7bPJaImF3s5xN0MppnjqI+r4A0nSPuLlxUeLg8iAhpomLGx30kKv4fSGJVx7nuudGi
         pOhw==
X-Gm-Message-State: AOJu0Yx6v6jzK1Jgi0j433smnJE7x6LcouSuB2uOjWFoxa7c52V3dbvw
	iMEM3tDTzzkOa0kTM0RI7LUftuEdIA79bX/OCHQkz3a7+Iqu/zXCFfVMabIpvK4=
X-Google-Smtp-Source: AGHT+IEK686cLan9wZ/Ri6zx93A/eMAWg77IfwvrBwtwRpqtwNCNZxaNf/uMbabpGOd/ZmNyFfpvxA==
X-Received: by 2002:a05:620a:4249:b0:7b1:35f4:fe19 with SMTP id af79cd13be357-7b193f5d7ccmr1171250485a.58.1730126367131;
        Mon, 28 Oct 2024 07:39:27 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b18d27a555sm325528685a.14.2024.10.28.07.39.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 07:39:26 -0700 (PDT)
Date: Mon, 28 Oct 2024 10:39:31 -0400
From: Gregory Price <gourry@gourry.net>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, kernel-team@meta.com,
	akpm@linux-foundation.org, ying.huang@intel.com, weixugc@google.com,
	dave.hansen@linux.intel.com, osalvador@suse.de, shy828301@gmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] vmscan,migrate: fix double-decrement on node stats when
 demoting pages
Message-ID: <Zx-iI33-I4YYOEbB@PC2K9PVX.TheFacebook.com>
References: <20241025141724.17927-1-gourry@gourry.net>
 <mjfsmy5naqj2oimgelvual6zpfinbugmbqy7kmbs2c2f7ll5jr@z4rl5zzdvrat>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mjfsmy5naqj2oimgelvual6zpfinbugmbqy7kmbs2c2f7ll5jr@z4rl5zzdvrat>

On Sun, Oct 27, 2024 at 10:24:10PM -0700, Shakeel Butt wrote:
> On Fri, Oct 25, 2024 at 10:17:24AM GMT, Gregory Price wrote:
> > When numa balancing is enabled with demotion, vmscan will call
> > migrate_pages when shrinking LRUs.  Successful demotions will
> > cause node vmstat numbers to double-decrement, leading to an
> > imbalanced page count.  The result is dmesg output like such:
> > 
> > $ cat /proc/sys/vm/stat_refresh
> > 
> > [77383.088417] vmstat_refresh: nr_isolated_anon -103212
> > [77383.088417] vmstat_refresh: nr_isolated_file -899642
> > 
> > This negative value may impact compaction and reclaim throttling.
> > 
> > The double-decrement occurs in the migrate_pages path:
> > 
> > caller to shrink_folio_list decrements the count
> >   shrink_folio_list
> >     demote_folio_list
> >       migrate_pages
> >         migrate_pages_batch
> >           migrate_folio_move
> >             migrate_folio_done
> >               mod_node_page_state(-ve) <- second decrement
> > 
> > This path happens for SUCCESSFUL migrations, not failures. Typically
> > callers to migrate_pages are required to handle putback/accounting for
> > failures, but this is already handled in the shrink code.
> > 
> > When accounting for migrations, instead do not decrement the count
> > when the migration reason is MR_DEMOTION. As of v6.11, this demotion
> > logic is the only source of MR_DEMOTION.
> > 
> > Signed-off-by: Gregory Price <gourry@gourry.net>
> > Fixes: 26aa2d199d6f2 ("mm/migrate: demote pages during reclaim")
> > Cc: stable@vger.kernel.org
> 
> Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>
> 
> This patch looks good for stable backports. For future I wonder if
> instead of migrate_pages(), the caller providing the isolated folios,
> manages the isolated stats (increments and decrements) similar to how
> reclaim does it.
>

Note that even if you provided the folios, you'd likely still end up in
migrate_pages_batch/migrate_folio_move and subsequently the same accounting
path.  Probably there's some refactoring we can do to make the accounting
more obvious - it is very subtle here.
 
> > ---
> >  mm/migrate.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/mm/migrate.c b/mm/migrate.c
> > index 923ea80ba744..e3aac274cf16 100644
> > --- a/mm/migrate.c
> > +++ b/mm/migrate.c
> > @@ -1099,7 +1099,7 @@ static void migrate_folio_done(struct folio *src,
> >  	 * not accounted to NR_ISOLATED_*. They can be recognized
> >  	 * as __folio_test_movable
> >  	 */
> > -	if (likely(!__folio_test_movable(src)))
> > +	if (likely(!__folio_test_movable(src)) && reason != MR_DEMOTION)
> >  		mod_node_page_state(folio_pgdat(src), NR_ISOLATED_ANON +
> >  				    folio_is_file_lru(src), -folio_nr_pages(src));
> >  
> > -- 
> > 2.43.0
> > 


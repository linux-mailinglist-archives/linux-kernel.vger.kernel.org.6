Return-Path: <linux-kernel+bounces-402162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE80F9C248D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 19:03:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E1D9289A79
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 18:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1D501F26CA;
	Fri,  8 Nov 2024 18:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="HBtjhEQD"
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A6D1F26C0
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 18:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731088876; cv=none; b=iqIPA3/0PIT7f1PdhAp0f6uN6rAv2rVctCPUSztc3xQDdJg59Y4+Z2Z/siLwQC4LgH6smLLxiMFnNyDBPKcTR3eJL77n4X5tIY97WHu9G6s172WgYdHUQheyoXRCSVg0y+TEv2gGaO+9WhQYaepKf/mkgPCzvcgjlsoTswfGoP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731088876; c=relaxed/simple;
	bh=oezwSahqeVo98aIQ1EJ74ByiQozxrqkdnj7+JbWeTYk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KYyQlLZram8Fh5VOkD60/mshU7oPw4nC0msqLKRN7NDmHVywBe4qm1BCN4l/N9AxL4szJYDPzNWORL6SjL3awIDW/ezQlyBlCZ95Q9xsA3iHgYTn9QwL0df3uEoo6aFdaCsB8XUuuNXKGVzoKS9UqWT+ZK+lJHXWaowqwTSpGFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=HBtjhEQD; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6cbceb321b3so15512696d6.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 10:01:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1731088873; x=1731693673; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Zs23C+5/amwqfDvV9LtWZn4mgzjfoDFSDR2Scoi1E+Y=;
        b=HBtjhEQDfhaJtFN3+hQoXOfiuM3DRM0MNsyXQzEa9KFnZn/khLbVWeli2hjYa6TgxL
         P9NUMp044O72bA5hyHLv/T2dGgcTaABImul1CMTpMYosduHHhgDqC6lHm3/e6lCgmURz
         pT9cmdT5KZnsFdNnI0FagTgmyt06rUFNr9YrdLu4A6Swrjd+UNDQj80WSFoRms4dHsbE
         iEBLVbSPBI4Z5CwsdqE0GAACM3Y7JIKOWsABaDSHqFyWxAeo226ONeHSETVFbSdTwu+Q
         gwbHEMJ0fxRjzr6C2AjIQKyQFIwJYZrSkpBcxuG6KEk45YbMEKaoCFSvh2SL1AuJqozj
         C5dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731088873; x=1731693673;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zs23C+5/amwqfDvV9LtWZn4mgzjfoDFSDR2Scoi1E+Y=;
        b=gp6foYEAJ5Kz8WPaKng25GLIUkp503FLEcaJL5vpQ8kun4Jfg0mIjDf4NLWsJu7PvX
         Q9FKyP9eqRiMlhkZCnUAhCAXFdCUoprYPvDZ2sS46AVGiCNJalCEpARsMFNDW1fuXTwO
         LICuVxcdFuxXKd6Vl2vJPMD2RdmImP3byxPE+I+HPMUQWQJDdkJW5j7D8cYVkwYypeeG
         5+P0/K61/bxv3kTfQWRqAJgZFWYssoBSeicqCIt48WrBGsCuQLCJoEfG7+8wbW9XKiUW
         pXLDiKeURc42yMzSq4xPSavAHPlnx406yWkWK9qJ0a3yTJ39wh5jfH5XddD+Q+yZkeBx
         9Tvw==
X-Forwarded-Encrypted: i=1; AJvYcCW64qQXplcUe6A2J/Xyokva2rbItK/cwcxIaJDU24pfaXc+NXVdTJ06V60z6rnsdXROYLluPfHo1o4Mz5Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxThuYXT7JyL5PdwZDRhLxGyupcYEq3whePXPaS/8nMYLu13imj
	ciwnQ6nWPhR5HJNdx1uA5ObuJN5fgqnwsdjNAqpcjbcCEBO8GC45yEygjcFc6RM=
X-Google-Smtp-Source: AGHT+IEPJrXsNFfGXnjpLXjxgjcfwfpF1PgAEkcM7oPTJS9Mf06xfBmic5tTTDSyk700PE5cHO04lg==
X-Received: by 2002:a05:6214:46a1:b0:6cb:f79a:cb38 with SMTP id 6a1803df08f44-6d39e107cfcmr48997816d6.5.1731088872653;
        Fri, 08 Nov 2024 10:01:12 -0800 (PST)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d3966317f3sm21688726d6.118.2024.11.08.10.01.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 10:01:11 -0800 (PST)
Date: Fri, 8 Nov 2024 13:00:56 -0500
From: Gregory Price <gourry@gourry.net>
To: "Huang, Ying" <ying.huang@intel.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org, david@redhat.com, nphamcs@gmail.com,
	nehagholkar@meta.com, abhishekd@meta.com,
	Johannes Weiner <hannes@cmpxchg.org>,
	Feng Tang <feng.tang@intel.com>
Subject: Re: [PATCH 0/3] mm,TPP: Enable promotion of unmapped pagecache
Message-ID: <Zy5R2JvXvhFoJzeY@PC2K9PVX.TheFacebook.com>
References: <20240803094715.23900-1-gourry@gourry.net>
 <875xrxhs5j.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <ZsNhgU-TiTz2WKg5@PC2K9PVX.TheFacebook.com>
 <87ikvefswp.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <ZykOqYJpgL4lw7mw@PC2K9PVX.TheFacebook.com>
 <87jzdi782s.fsf@yhuang6-desk2.ccr.corp.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87jzdi782s.fsf@yhuang6-desk2.ccr.corp.intel.com>

On Tue, Nov 05, 2024 at 10:00:59AM +0800, Huang, Ying wrote:
> Hi, Gregory,
> >> 
> >> Several years ago, we have tried to use the access time tracking
> >> mechanism of NUMA balancing to track the access time latency of unmapped
> >> file cache folios.  The original implementation is as follows,
> >> 
> >> https://git.kernel.org/pub/scm/linux/kernel/git/vishal/tiering.git/commit/?h=tiering-0.8&id=5f2e64ce75c0322602c2ec8c70b64bb69b1f1329
> >> 
> >> What do you think about this?
> >> 
> >
> > Coming back around to explore this topic a bit more, dug into this old
> > patch and the LRU patch by Keith - I'm struggling find a good option
> > that doesn't over-complicate or propose something contentious.
> >
> >
> > I did a browse through lore and did not see any discussion on this patch
> > or on Keith's LRU patch, so i presume discussion on this happened largely
> > off-list.  So if you have any context as to why this wasn't RFC'd officially
> > I would like more information.
> 
> Thanks for doing this.  There's no much discussion offline.  We just
> don't have enough time to work on the solution.
> 

Exploring and testing this a little further, I brought this up to current
folio work in 6.9 and found this solution to be unstable as-is.

After some work to fix lock/reference issues, Johannes pointed out that
__filemap_get_folio can be called from an atomic context - which means it
may not be safe to do migrations in this context.

We're back to looking at something like an LRU-esque system, but now we're
thinking about isolating the folios in folio_mark_accessed into a task-local
list, and then process the list on resume.

Basically we're thinking

1) hook folio_mark_accessed and use PG_ACTIVE/PG_ACCESSED to determine whether
   the page is a promotion candidate.
2) if it is, isolate it from the LRU - which is safe because folio_mark_accessed
   already does this elsewhere, and place it onto current->promo_queue
3) set_notify_resume
4) add logic to resume_user_mode_work() to run through current->promo_queue and
   either promote the pages accordingly, or do folio_putback_lru on failure.

Going to RFC this up

~Gregory


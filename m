Return-Path: <linux-kernel+bounces-313020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63DEE969F22
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 15:37:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96E7A1C23BD1
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 13:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4C4F7462;
	Tue,  3 Sep 2024 13:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="YEy6xRW3"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D135B63CB
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 13:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725370639; cv=none; b=GsIlcKTdVUmOvtUf3co8x3uHEsXZYc2WG0piTGiqeqIl7ExSj6uncj5AYVw8X7SLBGTcxR7YBktvtFLsy6E9lOc+ypiC7r/6y38Nt3Y0iszPDMkFdmPlQS4E0mZyegKF5rHGa9khxgHo+4c83laIhtzKvzwZG3Rl+uA+peVjJLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725370639; c=relaxed/simple;
	bh=zK4sxTzKS9zno4bDB1GFZG25ka8k5P4lmUmsy43LBUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LP73zwMAuyKMDgHSGmvxTqzIW0CwbMJkmB4U88GPqL2EVUK9RjJqiKiObUVKwat8Y31+4G/89CDMICuLxBUUTwLGF7KdyzW0suL84ZPTC2/JbKaSHgTowEeKExUsDWeRSeDpGTgJruziqFcWFqy6FNZNtILRahpb3B0dK4/XpkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=YEy6xRW3; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4568571de47so25738841cf.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 06:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1725370636; x=1725975436; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3JF7HWNoOErj8MlWsrCPxI4aMhOK2ReOgZKcSkTwbsQ=;
        b=YEy6xRW3g+izcuYNL78lgXbqlHub+rLTh7/QGM5GwsKj9eCcnw8d3pn1B7vRMMKgY4
         +zB6w5TIiHFvq3x8h+9fOLlnqaI+xoXRgufDzki4XmvgtSNW2HPGmdiU9enM2+h4vj2R
         3c+ZpfuBKjIUux2ULCRFfLiFM/txTdOBteiPWhnAR86CJRo/bPML7p5wZ/PS14jC0fxo
         udqMoZVEG6eOMuy5I/ZiZXZh328RH8IxAoNZQY0v8elak97rzabMEU3S9f/RqlbELnyv
         LDkpLW2ZgMgi1D/vpMGh+pcV7+4p3DKORJXqb5yaKUDleK/Cx/VAgk0J48dxOiiK7XDn
         kzaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725370636; x=1725975436;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3JF7HWNoOErj8MlWsrCPxI4aMhOK2ReOgZKcSkTwbsQ=;
        b=FMRw0pUeffqOrgjxo0m1M7M/cLgQOnmkdzPvqabV1tsYIV0RyvKpnMD9ksoGHrsQLS
         Ofek279Z9iGFXx/+98WHxBaS3h6Xiqe9pIgWp9koen3530nf3JzMjTFdr4uqd9Qs9NG2
         b3emkfdXR6oDp1e9XL2uut3OV8AQ1MxxXd7q7iWQFCecB+cVut5XoJCeizhY7GYJDqpa
         kWU9TxJXjnjJa1gDuMltJ8rQXpVu2oLos3yjZ9V0XAq1bc9/wHcHMG06FHpso2bkRSb6
         8RMacclbwJB8hF36ZbZvYnDQD5VECUFZa0uLHJMZn5q5pSyD+2dGKUlQjTbbMlhBOWsK
         YqnQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7DSw56ocpEZB1oPG5fVIBsemOIuQFSK/B3n2DvLoKGabpkT5py2Pr32+938UxvG/W2XSgRZvXRDkmov0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxI/OQlZLzyeP8UC6O9LPt/G94nYtGyMqQknRGe/8TMkA8dS/re
	TvfQxGV6EID0dJ1I2qhWkjmea9t+mHSKsWyPbE3D5DcM2V9egpnjhAr9qFg4QqY=
X-Google-Smtp-Source: AGHT+IFbHa7o20qp9c+PMcvFFBJrJFRlDIPpShG96ziR0pYYFpBTDIwKUMfBGqIoY0lzHhFD85PCPQ==
X-Received: by 2002:a05:622a:580d:b0:447:f922:64fd with SMTP id d75a77b69052e-456fd7e531fmr123363691cf.35.1725370636441;
        Tue, 03 Sep 2024 06:37:16 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-457ca0d55f2sm28229081cf.66.2024.09.03.06.37.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 06:37:16 -0700 (PDT)
Date: Tue, 3 Sep 2024 09:36:50 -0400
From: Gregory Price <gourry@gourry.net>
To: "Huang, Ying" <ying.huang@intel.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org, david@redhat.com, nphamcs@gmail.com,
	nehagholkar@meta.com, abhishekd@meta.com,
	Johannes Weiner <hannes@cmpxchg.org>,
	Feng Tang <feng.tang@intel.com>
Subject: Re: [PATCH 0/3] mm,TPP: Enable promotion of unmapped pagecache
Message-ID: <ZtcQ8sgr_Wgu3pB0@PC2K9PVX.TheFacebook.com>
References: <20240803094715.23900-1-gourry@gourry.net>
 <875xrxhs5j.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <ZsNhgU-TiTz2WKg5@PC2K9PVX.TheFacebook.com>
 <87ikvefswp.fsf@yhuang6-desk2.ccr.corp.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ikvefswp.fsf@yhuang6-desk2.ccr.corp.intel.com>

On Mon, Sep 02, 2024 at 02:53:26PM +0800, Huang, Ying wrote:
> Gregory Price <gourry@gourry.net> writes:
> 
> > On Mon, Aug 19, 2024 at 03:46:00PM +0800, Huang, Ying wrote:
> >> Gregory Price <gourry@gourry.net> writes:
> >> 
> >> > Unmapped pagecache pages can be demoted to low-tier memory, but 
> >> > they can only be promoted if a process maps the pages into the
> >> > memory space (so that NUMA hint faults can be caught).  This can
> >> > cause significant performance degradation as the pagecache ages
> >> > and unmapped, cached files are accessed.
> >> >
> >> > This patch series enables the pagecache to request a promotion of
> >> > a folio when it is accessed via the pagecache.
> >> >
> >> > We add a new `numa_hint_page_cache` counter in vmstat to capture
> >> > information on when these migrations occur.
> >> 
> >> It appears that you will promote page cache page on the second access.
> >> Do you have some better way to identify hot pages from the not-so-hot
> >> pages?  How to balance between unmapped and mapped pages?  We have hot
> >> page selection for hot pages.
> >> 
> >> [snip]
> >> 
> >
> > I've since explored moving this down under a (referenced && active) check.
> >
> > This would be more like promotion on third access within an LRU shrink
> > round (the LRU should, in theory, hack off the active bits on some decent
> > time interval when the system is pressured).
> >
> > Barring adding new counters to folios to track hits, I don't see a clear
> > and obvious way way to track hotness.  The primary observation here is 
> > that pagecache is un-mapped, and so cannot use numa-fault hints.
> >
> > This is more complicated with MGLRU, but I'm saving that for after I
> > figure out the plan for plain old LRU.
> 
> Several years ago, we have tried to use the access time tracking
> mechanism of NUMA balancing to track the access time latency of unmapped
> file cache folios.  The original implementation is as follows,
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/vishal/tiering.git/commit/?h=tiering-0.8&id=5f2e64ce75c0322602c2ec8c70b64bb69b1f1329
> 
> What do you think about this?
>

Also seems like an interesting option. I've been looking at another old
proposal to simply add a new LRU that was implemented by kbusch a few
years back.

https://git.kernel.org/pub/scm/linux/kernel/git/kbusch/linux.git/commit/?h=lru-promote&id=6616afe9a722f6ebedbb27ade3848cf07b9a3af7

I may spend a little time to add a few different methods in with a switch
I can flip to test them side by side / with each other and see what results
we can get.
 
> --
> Best Regards,
> Huang, Ying


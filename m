Return-Path: <linux-kernel+bounces-292366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF460956E83
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 17:16:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D6EB282947
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 15:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 760CC482EB;
	Mon, 19 Aug 2024 15:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="WaGQqCyD"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF1345C14
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 15:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724080526; cv=none; b=f071rM8apiseZUxHBsLYjxzKVxFnCsXBnifAEncK1E788obfa6NW6Xu09mFWoj0VD9qvyuyfXsV4rgi2iMikrMpJXSAvJSSshtHSS4/CrcP4X7A8PGDoXysclEqNdMzY4VmfESSdOyKyUL/iUy2QZI/4BUYOfuVbsEcsm0hadJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724080526; c=relaxed/simple;
	bh=yVBb0jTWBpA5fy81DEGjUeDImJ3sllOY1ueUdopcNQA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iFLtnKscsaF6VFYECfxqv72ma//KYzS/Z95Q7wR8zu1vl75oV4jTLpSMkJfg3nU5FMgG0INLP0S8qCUsW7AF7ip+ldnXqkwWqwjcp5uBi0Kjx3eb0tu1v2+lKLjb3OsU42jMKyXgBin/J4k4Kk73kSvpaS0YacDkubGRBEx4SuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=WaGQqCyD; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4503ccbc218so46736361cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 08:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1724080523; x=1724685323; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GNTbc0F2dMBvNbFHEwMBdeuxTmUA8ws/rkRWGeGRoPk=;
        b=WaGQqCyDea2wT86P0AcFasuinPehxHk42tl62NTPxNAzwlDcMmNJG0lchr8DL9TB5N
         JFYyPSQlrz1FAchec0MaAvTC8ZwI/rAw7LGezsAhMLXn8Hgp26CfUzgyo3AaYahRgi7I
         i/Ass1aZRB85sCbjBV836h5d7sN5q0F1osaBbMbUbZgjTJH9rMGNbg8+22FpT88pc2tO
         WeB4XFxsLK54vTaZad6Z9iCo8DtBMNcaGg5H/S99gEJm2pgLy5MWARjOoVV5tUcdYdji
         c3SIfXVW8AFeI9jiuR6kUMvdYzCVUzIPPTXupfBeEgqNnDVz+JMHAFjzYKYXZEDGQske
         iOXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724080523; x=1724685323;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GNTbc0F2dMBvNbFHEwMBdeuxTmUA8ws/rkRWGeGRoPk=;
        b=tx8MORztHZYIQpjFAnp778/UXGfVOuWTGx0tBmQBWMZRo5ElQxEGaIZ/uz52WR3ToE
         1HIl3SWo/R9DeAYrYCnzEq0+llGca9gDE0rbjyaD2ogj6CbGuHxjbVXCWtKsAp6MDTWj
         E76RGuUvacQIFEbFrf/82D037wT3/u2c5S64roS0InQAkBYIxUiNZfIUnBWS/Wc2iGD7
         FwdcbPkTlK7KcETDxb7HwNkrJplEMB5A9MFDTKRlf2XjH0q0n5JXLkwWRNAWbOWshiNB
         smnLwyctvU6KT9bdFV4N0uLHyhVeJ+M3+3MLWiQRmvLJaJkvV6ZAgaM2tGetO4jidDpC
         QOnQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkA8Q4V9yxtQWZ2Tu8oN4W9ix+y5Hr8XLES5nGETset6nk75zEpZnaDaSCJJBeYGK3GJuBQdIUZ6VRS7If1PwC7XZ0p5qOT+e++BFH
X-Gm-Message-State: AOJu0YxSr11+sxZAc29IqgS2Cpl/Zp5XQuniamZ8HRMvMD1PFgiQ0rzd
	1LQyM0LeUAYjZ70SfV3JPk7X0oU7ITU2lAUaN0NAtewnForgC3JeWkePLprasWA=
X-Google-Smtp-Source: AGHT+IEIa+Un4OYZorcrrStpEMRUkTPJX8l/7RbD8QT6GjJwWrYqUQc3OlRirNW7Azsn1PCxBhv51Q==
X-Received: by 2002:a05:622a:1787:b0:44f:fceb:fd4b with SMTP id d75a77b69052e-453678f2e5cmr261406711cf.29.1724080522915;
        Mon, 19 Aug 2024 08:15:22 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45369fec96bsm41190591cf.25.2024.08.19.08.15.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 08:15:22 -0700 (PDT)
Date: Mon, 19 Aug 2024 11:15:13 -0400
From: Gregory Price <gourry@gourry.net>
To: "Huang, Ying" <ying.huang@intel.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org, david@redhat.com, nphamcs@gmail.com,
	nehagholkar@meta.com, abhishekd@meta.com,
	Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH 0/3] mm,TPP: Enable promotion of unmapped pagecache
Message-ID: <ZsNhgU-TiTz2WKg5@PC2K9PVX.TheFacebook.com>
References: <20240803094715.23900-1-gourry@gourry.net>
 <875xrxhs5j.fsf@yhuang6-desk2.ccr.corp.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875xrxhs5j.fsf@yhuang6-desk2.ccr.corp.intel.com>

On Mon, Aug 19, 2024 at 03:46:00PM +0800, Huang, Ying wrote:
> Gregory Price <gourry@gourry.net> writes:
> 
> > Unmapped pagecache pages can be demoted to low-tier memory, but 
> > they can only be promoted if a process maps the pages into the
> > memory space (so that NUMA hint faults can be caught).  This can
> > cause significant performance degradation as the pagecache ages
> > and unmapped, cached files are accessed.
> >
> > This patch series enables the pagecache to request a promotion of
> > a folio when it is accessed via the pagecache.
> >
> > We add a new `numa_hint_page_cache` counter in vmstat to capture
> > information on when these migrations occur.
> 
> It appears that you will promote page cache page on the second access.
> Do you have some better way to identify hot pages from the not-so-hot
> pages?  How to balance between unmapped and mapped pages?  We have hot
> page selection for hot pages.
> 
> [snip]
> 

I've since explored moving this down under a (referenced && active) check.

This would be more like promotion on third access within an LRU shrink
round (the LRU should, in theory, hack off the active bits on some decent
time interval when the system is pressured).

Barring adding new counters to folios to track hits, I don't see a clear
and obvious way way to track hotness.  The primary observation here is 
that pagecache is un-mapped, and so cannot use numa-fault hints.

This is more complicated with MGLRU, but I'm saving that for after I
figure out the plan for plain old LRU.

~Gregory


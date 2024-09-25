Return-Path: <linux-kernel+bounces-339598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EFE4C986776
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 22:13:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13A321C212BB
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 20:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CE6D146A68;
	Wed, 25 Sep 2024 20:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="AS7u7IUk"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233F95C603
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 20:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727295212; cv=none; b=X1EkCvM8Htjglwf8aiOD4dkF2nzkJ8udT5TEqzm8LLAdAe42L7GzIMIWQnV/522c4XXobqI2nERakjLkHFkGIuvFGNHc3VWXBmbq32IpqiJLvFCpZcNVI3Tbm/ZGcKwYjNfsV6AE4O6sU8jTOEBTts1TYcTmsUs+gzI9ODDEWOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727295212; c=relaxed/simple;
	bh=ZBuOVfJeVde+5uTdq/6pHDT/Gh+/LwzzH2DAUMaeg3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S/RZDUoklglt5/WICCwA7XriC31WgfiN2U2lCn+dcUYzctoIGNQSCXSn0Gihi0joR1TMn/74UeakvDm5TZ0ZTsi2e88i9qvCDga+Z40zw1r1wQF53xxOi3jmsfI9Pxrl9KMZLYLYAPzWOo4XtP9HBlAsK1qyItTDcTAyqXKF58Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=AS7u7IUk; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7a9ac2d50ffso25300985a.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 13:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1727295208; x=1727900008; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VYNmL5Nz2IGiW+6k4omOwHhouBSuRJXQCnWJUMwNVM4=;
        b=AS7u7IUkGNgF3g8FJ17CsR56Wglx5CY/qh0sUWFBurS3m31qA/nHkcgJisBMShAcC8
         HT44LO0zhVBDpfAh87gz/8/WeEBhBidPL21VTlajI/Eqge/W6J1n+NZtUCTMLWKf60UZ
         SOX79j+knDUpy7NOVzDJ3/yDnGf/O9+F7QUu67oY6nG9sayqw+fpZEwfrGy1J9+BRkxF
         CLGjEA+cEpFe4fh9Vr0q/V236m/0mm6TKcfvyATjxJvk7OtQjLmPN30YSx5ASpwdG9Zr
         AEkehALpE152LxkC5jUtja+H4igncEh58anvu2QHRvGJhiLbPI/sY0NKdfI/NNtDjnsZ
         YalA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727295208; x=1727900008;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VYNmL5Nz2IGiW+6k4omOwHhouBSuRJXQCnWJUMwNVM4=;
        b=vDyQU4b3Et45dGCkVdYJv7Yt+94FsBhMr8FtUEDXg3HsJIM9k30cf5P+vhgNeGiyRg
         +hJAhjM5/5lxb3hgHWFHJvELLZ6KC7jr6q8DpUPqnc6++hbhPSVxOWc/3FRE+EDYx3PS
         cqHZAe6H2chwC503d2pPJvLWhoNCEpgxRPwYGw3zqoIVWJ2Nr4OFxkMvKIGL+a9ktweN
         9Jjl65UJJB56GgRw6u2e+4XiRAiSfKQygU0GOvypuqfkicLbpz3rq9hh5kvnvvFspxcU
         EYIaszuvey4XDerNaxidSiQ/gJIiWYbC32NQ5sJhpPufLGK3hSplqm+VG5xpG+jmWfy5
         RJLw==
X-Forwarded-Encrypted: i=1; AJvYcCWK3WRiOCtwJBIP/wVy6Zv+/dXHR9PXQr3aeNPoE1Q4kaHleKG1dc8Lo3hpgQL3u2tbIQnZkhsiZVP0714=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9PYNE1kicoeZAjnxpqQ/D4Lcx2kU5GFa9shOLRnM+qbghwoiA
	tiJU/5Vwn9KaQ7TJ32AfulWrMVxDinjfmUY8aRCSm9n4LcTl0zbSzn013YMCcd8=
X-Google-Smtp-Source: AGHT+IG4Vb4ysACeO8FGcvcgPBjMzf2q2sh3Vq/KejA2l4TWGimd0hH3nuavd85up3JPeR81Phj47Q==
X-Received: by 2002:a05:620a:17a4:b0:7a9:b56a:3e09 with SMTP id af79cd13be357-7ae2c64f913mr147155185a.24.1727295207639;
        Wed, 25 Sep 2024 13:13:27 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7acde62562bsm201951285a.130.2024.09.25.13.13.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 13:13:27 -0700 (PDT)
Date: Wed, 25 Sep 2024 16:13:23 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, nphamcs@gmail.com,
	chengming.zhou@linux.dev, usamaarif642@gmail.com,
	shakeel.butt@linux.dev, ryan.roberts@arm.com, ying.huang@intel.com,
	21cnbao@gmail.com, akpm@linux-foundation.org, nanhai.zou@intel.com,
	wajdi.k.feghali@intel.com, vinodh.gopal@intel.com
Subject: Re: [PATCH v7 6/8] mm: zswap: Support mTHP swapout in zswap_store().
Message-ID: <20240925201323.GA880690@cmpxchg.org>
References: <20240924011709.7037-1-kanchana.p.sridhar@intel.com>
 <20240924011709.7037-7-kanchana.p.sridhar@intel.com>
 <CAJD7tkbd=H+=wx0gnu8sh44hOmx7BE3G3oSxi7zt+o3HKJthkA@mail.gmail.com>
 <20240925134008.GA875661@cmpxchg.org>
 <CAJD7tkY8D14j-e6imW9NxZCjTbx8tu_VaKDbRRQMdSeKX_kBuw@mail.gmail.com>
 <20240925192006.GB876370@cmpxchg.org>
 <CAJD7tkY-ayU3Ld+dKTLEEG3U72fGnCbiQgZursK+eGMXif_uzA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJD7tkY-ayU3Ld+dKTLEEG3U72fGnCbiQgZursK+eGMXif_uzA@mail.gmail.com>

On Wed, Sep 25, 2024 at 12:39:02PM -0700, Yosry Ahmed wrote:
> On Wed, Sep 25, 2024 at 12:20 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
> >
> > On Wed, Sep 25, 2024 at 11:30:34AM -0700, Yosry Ahmed wrote:
> > > Johannes wrote:
> > > > If this ever becomes an issue, we can handle it in a fastpath-slowpath
> > > > scheme: check the limit up front for fast-path failure if we're
> > > > already maxed out, just like now; then make obj_cgroup_charge_zswap()
> > > > atomically charge against zswap.max and unwind the store if we raced.
> > > >
> > > > For now, I would just keep the simple version we currently have: check
> > > > once in zswap_store() and then just go ahead for the whole folio.
> > >
> > > I am not totally against this but I feel like this is too optimistic.
> > > I think we can keep it simple-ish by maintaining an ewma for the
> > > compression ratio, we already have primitives for this (see
> > > DECLARE_EWMA).
> > >
> > > Then in zswap_store(), we can use the ewma to estimate the compressed
> > > size and use it to do the memcg and global limit checks once, like we
> > > do today. Instead of just checking if we are below the limits, we
> > > check if we have enough headroom for the estimated compressed size.
> > > Then we call zswap_store_page() to do the per-page stuff, then do
> > > batched charging and stats updates.
> >
> > I'm not sure what you gain from making a non-atomic check precise. You
> > can get a hundred threads determining down precisely that *their*
> > store will fit exactly into the last 800kB before the limit.
> 
> We just get to avoid overshooting in cases where we know we probably
> can't fit it anyway. If we have 4KB left and we are trying to compress
> a 2MB THP, for example. It just makes the upfront check to avoid
> pointless compression a little bit more meaningful.

I think I'm missing something. It's not just an upfront check, it's
the only check. The charge down the line doesn't limit anything, it
just counts. So if this check passes, we WILL store the folio. There
is no pointless compression.

We might overshoot the limit by about one folio in a single-threaded
scenario. But that is negligible in comparison to the overshoot we can
get due to race conditions.

Again, I see no no practical, meaningful difference in outcome by
making that limit check any more precise. Just keep it as-is.


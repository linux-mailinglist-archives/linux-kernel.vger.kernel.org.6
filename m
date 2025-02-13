Return-Path: <linux-kernel+bounces-512117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE27EA33447
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 01:52:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBC061889046
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 00:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB1567082D;
	Thu, 13 Feb 2025 00:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="D11bsx0M"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2AFE41A8F
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 00:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739407935; cv=none; b=nn3e8SQ1dKGfGJcHkbXZUm4qDRBAKF7LBAJy8JjivrNPwVhD4HHZ+wl/QZAsAxkK+qb6UeTKghQsum6X0BG8BtkEM7egS/HnrvVjcRTPXSnNpybQWglV60DRqCurMSndX2Ik3SbplroARa2DLtUJlE8eHNCXhpZWIda/YmDvKao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739407935; c=relaxed/simple;
	bh=AKqN+d11WvXBdn1D3RT0yIO8U+Fxa/umBSUJK1xaSOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TT3XO9qFTAJonhlAmtQoLrJpzxrmjh0tDgPb7faxwks/2CQ0BvVi6Q0Ta9ihFfDuo/yhN9oEZXLFdqY3j+Bd/1YLWlkgyQ+7Y7cYCePUIltC5H/lFTX2swbfS2p1y9Lt/PYZkJuoIDLfsieaSZWuqqtxJgOTqBc7KblTDn8XD7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=D11bsx0M; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2fbfc9ff0b9so574362a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 16:52:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1739407933; x=1740012733; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vdYcJdmlJ+mWdpTTpZl2pIT3/xl6BBjB0QV7cYAWqNo=;
        b=D11bsx0MNUG1l92gxKSdUcQxFuQP4kqf1MzPIvSw0Gw4FzcBE2ENDDAfJ4ddafGEcv
         p3OijQsBCb/c6QQc4qaZBBsiHqAIuuop6XmSEzwpTfpYiY+6kQ2PaP8NoTxRj+ZcAVDR
         S9bHhF8EQ34vu2NB6Hu8AC/wn0x+dSIWXAKVo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739407933; x=1740012733;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vdYcJdmlJ+mWdpTTpZl2pIT3/xl6BBjB0QV7cYAWqNo=;
        b=G/7mBmQx8J8r9GWkD7vv+G4ivV/AWvvUoSjYOrBbfs/rvnew8SUcgndRDQUMq/Jt38
         iVM8rYedZ3vfY4jZtcur0HlzdT/UBNsTZ6Aadi642PgPa/Tl3JusNsFKBl5FddZcm3dW
         +guBbwtJpp4vKgTjCtsd3H11thXRgHenQo1tGSCt6qrUABHvPHGEo0/LJOVa+UOK54DS
         Ssk6yjYL2JmN0h6XlM+Nu+KbDssj+EPm6V1YSHWvMy8KAaJ/YxEJGaBk/fQPWb+v0h44
         Ug37Z9cfblrMg7vfCea/2ZExYYRjV+1M83IdYAYsbRgOj2vnGsNVvsdd+AI/cvgHUEXE
         R9IQ==
X-Forwarded-Encrypted: i=1; AJvYcCUiwlDEGlddJwmVSVHDZoE+BIxSQ+hK2ncw7Vrk/Zzmux3iFi1Kf2hchHvh52xl7QMDr8zJvRU7sG4bAOM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzM1qOOBMELGbFkV1lN6iU7R0K0b14lj7b7+jutt19iRQEifWmi
	wSVz8ko82cCSAy8wodidLihIe1k1PwauHsQbVIgERlGfPHKs7gu6eq3fYfng/A==
X-Gm-Gg: ASbGnctWLK+S77EI8dvIPeYRhBpHmJ5JqJd6qYhZFxMI2XxVlRj8rD+IwjXr1mhMS3J
	N3fF5E34DO7ot0qn2qeZS4Ts/T9kr5j60GZVAIxPQvo79iYuexYtxjjaRVa/tv0xAgerQw4c246
	eQzX84wmNNv8m/1Bf4lozkBrKu+cWHLvJg+PwwVKWKSc1kPrfP67kJABbXIysvzrVuatq2RsGp7
	NtfOtQumWgznkfRhpu3+CV1ctjrK82IsW1tyTiaOaul6klzjE4qnxDbsj4aCNW7C7s+7L9VZxtG
	rFT7iehWI9QvFhzVc18=
X-Google-Smtp-Source: AGHT+IGsJSkPhpNC3vMURP6Jrk49JHXtGteNQQY0IjdOo0yQ0F4a/BGPQv4nx/pYEnUi4f0M45E8VA==
X-Received: by 2002:a17:90b:180b:b0:2ee:693e:ed7a with SMTP id 98e67ed59e1d1-2fc0f0fedf0mr1719585a91.35.1739407932953;
        Wed, 12 Feb 2025 16:52:12 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:69f5:6852:451e:8142])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fbf999b60dsm2100358a91.39.2025.02.12.16.52.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 16:52:12 -0800 (PST)
Date: Thu, 13 Feb 2025 09:52:07 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Yosry Ahmed <yosry.ahmed@linux.dev>, Kairui Song <ryncsn@gmail.com>, Minchan Kim <minchan@kernel.org>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 01/18] zram: sleepable entry locking
Message-ID: <t6w7bzhdy6vywc4gzowdoe2vliwl7sdju6umrti5rscjyd2uns@pquelrkaywjn>
References: <20250212063153.179231-1-senozhatsky@chromium.org>
 <20250212063153.179231-2-senozhatsky@chromium.org>
 <20250212160830.730a199935e907c2498b28d4@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212160830.730a199935e907c2498b28d4@linux-foundation.org>

On (25/02/12 16:08), Andrew Morton wrote:
> > Concurrent modifications of meta table entries is now handled
> > by per-entry spin-lock.  This has a number of shortcomings.
> > 
> > First, this imposes atomic requirements on compression backends.
> > zram can call both zcomp_compress() and zcomp_decompress() under
> > entry spin-lock, which implies that we can use only compression
> > algorithms that don't schedule/sleep/wait during compression and
> > decompression.  This, for instance, makes it impossible to use
> > some of the ASYNC compression algorithms (H/W compression, etc.)
> > implementations.
> > 
> > Second, this can potentially trigger watchdogs.  For example,
> > entry re-compression with secondary algorithms is performed
> > under entry spin-lock.  Given that we chain secondary
> > compression algorithms and that some of them can be configured
> > for best compression ratio (and worst compression speed) zram
> > can stay under spin-lock for quite some time.
> > 
> > Having a per-entry mutex (or, for instance, a rw-semaphore)
> > significantly increases sizeof() of each entry and hence the
> > meta table.  Therefore entry locking returns back to bit
> > locking, as before, however, this time also preempt-rt friendly,
> > because if waits-on-bit instead of spinning-on-bit.  Lock owners
> > are also now permitted to schedule, which is a first step on the
> > path of making zram non-atomic.
> > 
> > ...
> >
> > -static int zram_slot_trylock(struct zram *zram, u32 index)
> > +static void zram_slot_lock_init(struct zram *zram, u32 index)
> >  {
> > -	return spin_trylock(&zram->table[index].lock);
> > +#ifdef CONFIG_DEBUG_LOCK_ALLOC
> > +	lockdep_init_map(&zram->table[index].lockdep_map, "zram-entry->lock",
> > +			 &zram->table_lockdep_key, 0);
> > +#endif
> > +}
> > +
> >  
> > ...
> >
> > +#ifdef CONFIG_DEBUG_LOCK_ALLOC
> > +	lockdep_register_key(&zram->table_lockdep_key);
> > +#endif
> > +
> 
> Please check whether all the ifdefs are needed - some of these things
> have CONFIG_LOCKDEP=n stubs.

Will do.


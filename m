Return-Path: <linux-kernel+bounces-512506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9717A33A42
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 09:49:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A01787A2689
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 08:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7222120B20E;
	Thu, 13 Feb 2025 08:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="X1LL0Kqn"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709E4200112
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 08:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739436548; cv=none; b=KReKLtHrERMV7Q/hK8iKaerRLZZPRozdWvE4m2wqRq3moVEEIP5/QgGrIQi/FFT4TfE1mKmP9AlGRyUkdTewySlzRCmv2QVYhqWgdAaPYC3EX/82yhcaWagDEgkl1BCyI5PZG2Hvp6zfNNoN0CtC3EmM/Op9JMjnZ/ey5V8Eb2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739436548; c=relaxed/simple;
	bh=9V6a56FV+vzy9W1wj4NZLe7Hx5ugDprV/TsGL0s61EU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ClmHQfJW6noYpcLBKvRaeqX7MSArq6AEmiFYsEuw++2l9WPDYV38YEo+syxJdGOfNIZruZ/D3VU5FGmh1Kf+earEHGcOsKxnysJDpyaRSRHxjddqnTE4cbU7OsoCszZfyu9T3ZWcq/1E9rMbs+enH0JkQZyWUGTITi3WTbNYk2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=X1LL0Kqn; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-21f5660c2fdso11230475ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 00:49:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1739436546; x=1740041346; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=b0+V8t8JAMKSPJxJM8ynvsFzXOsDDoMW6px3qewAf3Q=;
        b=X1LL0KqneO1IdJOtU8by/S7d4NfymJ+j6x1EkN98oClkbRBggFKbQLOl54FmY3KGPv
         XCguijVb22RB0qOXX4ISJpKEIt1rZqBIlT9d1VBqMW4U8etUsWlFe0jZGZx2h/Z/t8yL
         +vNrJCbu1jf8jrYNVWR4603tculPoqxTOamsw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739436546; x=1740041346;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b0+V8t8JAMKSPJxJM8ynvsFzXOsDDoMW6px3qewAf3Q=;
        b=CYXzY0JU4UenU5wzsMlxYcTR/wvqYWetFFVxgQVHbM2dl+4dzWNVCVLD3Zfz3epep5
         GtPbskY5d8tW8emYEsR5ySUiMsPHxNsaCiwJBr1jZu5JkajuHJhxuMEzpx0YKp+e4gsd
         6CLshSh+v+SjEzJUGIBPBYaNKhDzGLt/rZuigrFkKghcVvp0v19MURlu1Nz6j6ww0dMX
         9ZR0NjwahXuC4l3FmgihIh9n6O9ZPim0NGl5WQIl1TJo4gQ3R4obIl5aFzc1sWzisIBK
         KMGUReRyMAHs/NsjGkzx98Tn8o7pU5k6bZb35Zt/j99UJz3wPr7QQHxDA5idDohAxEsW
         UbGw==
X-Forwarded-Encrypted: i=1; AJvYcCUp0areFEnvPJMfPHqVXTdbtkFlPhKSwPI1jRUrSVg+jIOHPizflw3kxK4CSjsWAcxThT2d8q7pU/0K9wU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTvZ59fUaZeY0oBDIvSoco1o3fUbF+uXBev0fakFSp7ES0ED5h
	TCEwrXchv9rt0e53WmsuCb65sQK+00OvoyvJ+FXhIRLS2CuJKN5jkkhrsIOgRw==
X-Gm-Gg: ASbGncs5AAWyD9FzITAhyRvycBPH+WF3JlUhzgNAzyXb5YCTQavyEftuuxbT97z0w9i
	pD8p0ZQJHu7BzWc9JU+h/oYx1IIi1IlikUgFsOU/548x4JjaSE1oZkelcZHpcaUMUBpQL55/Mtl
	i8NoBO1DSbNz/1Amf5FwHc61JuvFd0LYiHlagfY78tfNOH7JPty9Ja98QMyCya5l7pD9CmFBHpH
	Y6QboJuc9KbWV0tPLEv+PLk3M/fT5qSkpJUUp6eQvYkjzb6vPLM29R0vXdH29++8MDW8iC7Sca0
	Fyh3RRTSOgYJMbI8xv4=
X-Google-Smtp-Source: AGHT+IHS/5GdKtXgG2/jmhrz0MJD2ke7RDQ6mckkojx+1Hv5HNvAwf4lX7XwhqVSZkbsoNfX55SgYA==
X-Received: by 2002:a17:902:f683:b0:21f:5cd8:c67 with SMTP id d9443c01a7336-220d20e8aa3mr36220065ad.31.1739436545640;
        Thu, 13 Feb 2025 00:49:05 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:3ed3:97ce:5f5f:1f61])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d558591asm7818045ad.224.2025.02.13.00.49.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 00:49:05 -0800 (PST)
Date: Thu, 13 Feb 2025 17:49:00 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Yosry Ahmed <yosry.ahmed@linux.dev>, Kairui Song <ryncsn@gmail.com>, 
	Minchan Kim <minchan@kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH v5 01/18] zram: sleepable entry locking
Message-ID: <ifhsimzwxwsthkwniv4o6rzi54yj34g2yl4ontzdsapufhi2vc@uaamvirr3533>
References: <20250212063153.179231-1-senozhatsky@chromium.org>
 <20250212063153.179231-2-senozhatsky@chromium.org>
 <20250212160830.730a199935e907c2498b28d4@linux-foundation.org>
 <t6w7bzhdy6vywc4gzowdoe2vliwl7sdju6umrti5rscjyd2uns@pquelrkaywjn>
 <ma5b36tdfdclkcd3ncp3bi7cnrcv2z5ju36h5ovugagp626xpd@kofvqoyhcc3p>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ma5b36tdfdclkcd3ncp3bi7cnrcv2z5ju36h5ovugagp626xpd@kofvqoyhcc3p>

On (25/02/13 10:42), Sergey Senozhatsky wrote:
> On (25/02/13 09:52), Sergey Senozhatsky wrote:
> > > > -static int zram_slot_trylock(struct zram *zram, u32 index)
> > > > +static void zram_slot_lock_init(struct zram *zram, u32 index)
> > > >  {
> > > > -	return spin_trylock(&zram->table[index].lock);
> > > > +#ifdef CONFIG_DEBUG_LOCK_ALLOC
> > > > +	lockdep_init_map(&zram->table[index].lockdep_map, "zram-entry->lock",
> > > > +			 &zram->table_lockdep_key, 0);
> > > > +#endif
> > > > +}
> > > > +
> > > >  
> > > > ...
> > > >
> > > > +#ifdef CONFIG_DEBUG_LOCK_ALLOC
> > > > +	lockdep_register_key(&zram->table_lockdep_key);
> > > > +#endif
> > > > +
> > > 
> > > Please check whether all the ifdefs are needed - some of these things
> > > have CONFIG_LOCKDEP=n stubs.
> 
> The problem is that while functions have LOCKDEP=n stubs, struct members
> don't - we still declare table_lockdep_key and lockdep_map only when
> DEBUG_LOCK_ALLOC is enabled.

I rewrote those bits (in zram and in zsmalloc), given that we also
need lock-contended/lock-acquired in various branches, which require
even more ifdef-s.  So I factored out debug-enabled variants.


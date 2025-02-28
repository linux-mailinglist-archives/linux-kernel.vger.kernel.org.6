Return-Path: <linux-kernel+bounces-538114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3388BA494B7
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 10:21:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B130F170FFE
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 09:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E4DF256C78;
	Fri, 28 Feb 2025 09:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zJ2Cqbpz"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7CF2566EB
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 09:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740734432; cv=none; b=cx7jtuXZopkHJPfjAeOE6I5ayrSvusyAE0aGYDfjPQ3Ga2E8d3fRfsTJwSxmuDLGjstUfkSCCmzsGn6OC3VDZeqvNHFk6Y8h4AnY+deh+kRR4IoPZQjKM2LxEAR2h2SVB+KDOhADNSAb21SyVQb32inATiVKibXP/gzy9ZAQVWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740734432; c=relaxed/simple;
	bh=TDWSGkN3NubGDFSP14LaIE2KzfLm+1ADC/+MvNbcWbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lIsv8Ne9/JCoIQi6ywkqqSndAdzE7iEehCBbM8s9UH63fbwWnHfVkGWGpLFeUrHTt/q0mmXorp8YsDtch7wFxQuntBexd3RLw3K/9CIh5A7hNAtzdehzGsL15XwdIlXUdDzuE5OeWqgLiL+oTFO3Wxymod/RdlK8d1mvFzXu4Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zJ2Cqbpz; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-438d9c391fcso42245e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 01:20:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740734429; x=1741339229; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sc/rFdhCs8ryT6ky50ep7UWZ/tEv7+DxhHl4CwzDRvQ=;
        b=zJ2Cqbpz751uyg66VIfBY0O2PT3C0el4YvbqAUBOPUA2n2plyeLvsnf9KVDHmUB7Us
         4Xw/zvncJ/DE5DtRlJImi2TelyVwsS+V3Q3dkrcvC1+XAzKCtn6n+mkUfpALRlz440Hf
         VaPYhWLueMYbEVZDFyL/c/tQsHI16vT/x/p/X/tBPqrMkgEjQltovpDKpwtSZA4R/2KW
         cG4hFISIv4S9VLO09MRwa1ZTRaNDDZMosMoiYyrGfFRj7nl4gX3AOGIdF2AUfN4RHvcZ
         BuCw/KcwXBVpUUNZDLvnkbJtdGUkbyZn5h6UeDc7hrf+ETV/54MqWY1dkih/TvG/Ur7/
         xyqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740734429; x=1741339229;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sc/rFdhCs8ryT6ky50ep7UWZ/tEv7+DxhHl4CwzDRvQ=;
        b=fPblH55lUZ0gdKqbVmVfBB5fiSDdM5DZtHI7RL8mPVSuijzRQI4CSueinIIMlbNkgD
         0kszL2cKCtO5uCP/iTVnrbb7MD6aJBF4jUfcm3JY/BsbZX71X69yb6XBUrKCGmfRyBqa
         zSSjvjRRTwrSuZs5jZF8qfn73Q11c33qOT5d2boCI13Pv3z4CxxtXEJc3VOy7Qs3Uk6u
         DjlzT/Ol4O0uywc18KQRJ3/4alErXAYpV2G/eAM/FiS3fJJn/SdtCZoguZjk3OBudWrJ
         ps0OQhAfVFxm9fE5jr8knms+8HQlpQkTGN5QfFj0bx1TvW1Nfh2JGnTjBNmGMVC0uGi5
         doJA==
X-Forwarded-Encrypted: i=1; AJvYcCUrXeBXZkn5Y4GNOkUBG/KMrJmm+U16zYFmwsBsP4/QqDNYuXjGDIkybugUvEm8XYbA4ISqpyDABEfsWOw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxJyBtEEdC9JZpIqieykEyzOmlxW61e1ojTWxZhCtKir/9S1U5
	5j5KpSaQlQG++34DwJnXW7piKvM1MHEVMhRXVJx4bvUNnZFnO6jfhfFmL6ydKw==
X-Gm-Gg: ASbGnctbwAkpP7/l2iPjsY/ZKWgbGStFSlhHzyl12q0aNriSgybdPdG45I+u4T+MXn6
	l6t0EzpA7GpX+bqcOF5vvqHR4LCVqKAXPOueVxmeR5Yedi8Vn9ZxqI0XkITdMbWIxd8KXarj2NB
	0HhSMprWG/5k3330qevjik7+SZwsawA0BlfTIGuSIv/867eY/KVmK668FkvMWf9LT0/uJ5ZsZwl
	WhJlbEKYNlka/7WJnyR5id4blyGjbDbrUFZWjK81wqKfFSv3/dn9uAsrpr3/C2SBfLc4kNgDx35
	SYzeE79q5AD5t9mJZwbMArYrw02rkd/8DsUTuqE2Zxl1zSVFLf3xz/30nmsZvg==
X-Google-Smtp-Source: AGHT+IFm+iilWyjxC1XPFcJ/1TDrVhPbDpKHPwRPFsYeQGLAJ1FnOgobaGgyAW4Mc9lQ5kLRwLuvXQ==
X-Received: by 2002:a05:600c:5618:b0:439:8739:b82b with SMTP id 5b1f17b1804b1-43ba6edd7bbmr852505e9.4.1740734428932;
        Fri, 28 Feb 2025 01:20:28 -0800 (PST)
Received: from google.com (44.232.78.34.bc.googleusercontent.com. [34.78.232.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43b73718de4sm51645805e9.23.2025.02.28.01.20.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 01:20:28 -0800 (PST)
Date: Fri, 28 Feb 2025 09:20:23 +0000
From: Brendan Jackman <jackmanb@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>,
	Oscar Salvador <osalvador@suse.de>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/page_alloc: Add lockdep assertion for pageblock type
 change
Message-ID: <Z8F_16DEb1j-aAcB@google.com>
References: <20250227-pageblock-lockdep-v1-1-3701efb331bb@google.com>
 <20250227143302.2338b1cf15919c64a6c1eb27@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227143302.2338b1cf15919c64a6c1eb27@linux-foundation.org>

On Thu, Feb 27, 2025 at 02:33:02PM -0800, Andrew Morton wrote:
> On Thu, 27 Feb 2025 16:15:47 +0000 Brendan Jackman <jackmanb@google.com> wrote:
> 
> > Since the migratetype hygiene patches [0], the locking here is
> > a bit more formalised, so write it down with an assert.
> > 
> > ...
> >
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -417,6 +417,10 @@ void set_pfnblock_flags_mask(struct page *page, unsigned long flags,
> >  
> >  void set_pageblock_migratetype(struct page *page, int migratetype)
> >  {
> > +	lockdep_assert_once(system_state == SYSTEM_BOOTING ||
> > +		in_mem_hotplug() ||
> > +		lockdep_is_held(&page_zone(page)->lock));
> > +
> >  	if (unlikely(page_group_by_mobility_disabled &&
> >  		     migratetype < MIGRATE_PCPTYPES))
> >  		migratetype = MIGRATE_UNMOVABLE;
> > 
> 
> We could add such assertions all over the place.  Why this place in
> particular?

For the other stuff, it's pretty obvious that it would be protected by
the zone lock (or, I don't know about it!). But it didn't seem totally
self-evident to me that it should protect the pageblock type. So it
seems particularly helpful to have it written in the code.

I may be heavily biased about this though, because of the code I'm
working on for [0]. I use the pageblock type to remember whether it's
mapped in the ASI restricted address space.

[0] https://lore.kernel.org/linux-mm/CA+i-1C1gOBLxRxE5YFGzeayYWBYyE_X6oH4D=9eVePt4=ehTig@mail.gmail.com/T/



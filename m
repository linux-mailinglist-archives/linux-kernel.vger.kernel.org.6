Return-Path: <linux-kernel+bounces-511559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61C6BA32C9E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 17:57:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23FB6161F4B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 16:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D929F253B63;
	Wed, 12 Feb 2025 16:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UNoeakOW"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181011DEFDD
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 16:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739379429; cv=none; b=t76KUNO+bZ0N8OEQ5HOtN+gyy5bXNhCCIswIVRHfIWFol9J04J4VXxhuqLLSAI3Eq88yiacPK/viQtB7R3vAQDRM5uHHxv5Vufb9bomE0ZOV7oL5MtZ8SXgbdzcpy5KBNJ+FVj9HSFUjaeIESwvFbgCJZIf+zi2FA16OhSjwXq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739379429; c=relaxed/simple;
	bh=z/moxQQycRkyIrr2vHuWwr2DfpHrMqkr/yZdiQwGcwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ltd2Rc3mNjJVmWKU7/dQfI1X7lH/OIrhP0lu5Uvo7qjpqbzqyt4MHkIOi31vXk3S4qff7/C6nQciLgXi30xSWKxgkPKOeyuzIgm/nGof9K9YtZFanRinfHoHznZMwZb0A2Qb/gaq1OSM5/O1Tl9tNR7I3cp7b1m82LxrvleQ87s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=UNoeakOW; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ab7fa1bc957so111910966b.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 08:57:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1739379425; x=1739984225; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JjsYFCJJEHZxSzckcIzfcbuaPZal5Jzp1D2k19Zbpnk=;
        b=UNoeakOWzzzi3raW20R3L/FVC57nNrUfe3MIEivZX4appVWozAAJpebx0BoGAtj3xF
         9hpUjBpiLnpTlQBxu9/46VONh8bvgAvmZlLR+j2YUtVl6Wq6M8EUS34/KQeZVujaQxkT
         cQNKpgF8uUgudT6XNhuNHETrMjkDb7tqG9IisjeOJzZiDKLUOhLv94kGMRrAg/Jk6BNB
         gw/QYwOV1DmdDQ3xqLFRHnk7hXrSeyNjig7A/i4eXX9N5zoi5Sulj4r+Tb76MnQaIoay
         KTgAI1eC5A/Xrq0tizbH1dBhfbFuAYqSdDkMgve9tdpITdlL0k+DzwxaTu+vx83T6WOC
         WukA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739379425; x=1739984225;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JjsYFCJJEHZxSzckcIzfcbuaPZal5Jzp1D2k19Zbpnk=;
        b=i/Q6+liL4mfmMFCru+nLsCRBOwDdBhyy1oUYzY41R+Sg/O35jprsTVlxzQEzY8o+fO
         ULFO+BLvDa4n8WxQzB0kacYTauSEkIzC2N22fZ2+Vp5gA/Cr6s3kBrGvWuZkcvkOqG4m
         Ds9euHZPwPGk/f72oogbbasRqyyHqiWWbQJP7gYnAaImdMzegPcYY+pMeJfx9/kVCj86
         funU/mOES+3W3xVuh4W1vyPZjab4ycX4Wm8Ea0XNBkQDsdSqwHTaFO4lXK1OB9x83IOZ
         B5Jp8MjuAHbAsyzSfThhPu9fTysTsoPVaWG49FOKG+Uxsr2SkZ3DjcZVVVVH3o3uU5PJ
         z4EQ==
X-Forwarded-Encrypted: i=1; AJvYcCWsuvIwj9S5U58yZEf57VneoFv/LI5hkEpjUyPNZZgMyLzNiMf44bdddfmG8m7kF+/1vOi9XbygxhCeUBg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5JEImGSdIE1x1djQUP3MSnWmFIOlotl7bsJrCGyTOjhbFCCCp
	hHp/Odcgu06tOZFaaK/uMNxfpxn5DyLY8yQnNHEc6s42hkvgI04Ld+uo57R7P34=
X-Gm-Gg: ASbGncvrJxSeIQjWwI0jtuAwtygRiPjwuz/oAKyXxcrZwnucLAui4XR6QskQlkD32FK
	IVdgEGmtpOqsW64megll1CxEFQ8193nzKRsJh4sT3E7FXjgm1jveBjcmXV0o0S3a9kDehuhwUks
	1E48Q/DuJ9HTFloI1syQMfarI48fIkfUOArfOX5m1nocS+CyoAgsgltxMlRfvhviIQJPuAyzJ/M
	sPpFH1ZMbJ7dAyt9yXoIHicGFW+ixCAvz9RGd3A42NeX2s2qwekflVrgBEJbPaiXqoIihjzr98Q
	bqfD9BjEv/ZRIa6MuaNGIcmk1lpJ
X-Google-Smtp-Source: AGHT+IH7LlfK74B8VvYBHknSdhrm92vGSyA95nxZa/qMjbiRpSunsF+OUjP8S86GVgK+ZMWNOar0ww==
X-Received: by 2002:a17:907:1c14:b0:ab7:b30:42ed with SMTP id a640c23a62f3a-ab7f31944c1mr340818066b.0.1739379425293;
        Wed, 12 Feb 2025 08:57:05 -0800 (PST)
Received: from localhost (109-81-84-135.rct.o2.cz. [109.81.84.135])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-ab7f7ee8686sm137024766b.22.2025.02.12.08.57.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 08:57:05 -0800 (PST)
Date: Wed, 12 Feb 2025 17:57:04 +0100
From: Michal Hocko <mhocko@suse.com>
To: Tejun Heo <tj@kernel.org>
Cc: Dennis Zhou <dennis@kernel.org>, Filipe Manana <fdmanana@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm, percpu: do not consider sleepable allocations atomic
Message-ID: <Z6zS4Dtyway78Gif@tiehlicka>
References: <20250206122633.167896-1-mhocko@kernel.org>
 <Z6u5OJIQBw8QLGe_@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6u5OJIQBw8QLGe_@slm.duckdns.org>

On Tue 11-02-25 10:55:20, Tejun Heo wrote:
> Hello, Michal.
> 
> On Thu, Feb 06, 2025 at 01:26:33PM +0100, Michal Hocko wrote:
> ...
> > It has turned out that iscsid has worked around this by dropping
> > PR_SET_IO_FLUSHER (https://github.com/open-iscsi/open-iscsi/pull/382)
> > when scanning host. But we can do better in this case on the kernel side
> 
> FWIW, requiring GFP_KERNEL context for probing doesn't sound too crazy to
> me.
> 
> > @@ -2204,7 +2204,12 @@ static void pcpu_balance_workfn(struct work_struct *work)
> >  	 * to grow other chunks.  This then gives pcpu_reclaim_populated() time
> >  	 * to move fully free chunks to the active list to be freed if
> >  	 * appropriate.
> > +	 *
> > +	 * Enforce GFP_NOIO allocations because we have pcpu_alloc users
> > +	 * constrained to GFP_NOIO/NOFS contexts and they could form lock
> > +	 * dependency through pcpu_alloc_mutex
> >  	 */
> > +	unsigned int flags = memalloc_noio_save();
> 
> Just for context, the reason why the allocation mask support was limited to
> GFP_KERNEL or not rather than supporting full range of GFP flags is because
> percpu memory area expansion can involve page table allocations in the
> vmalloc area which always uses GFP_KERNEL. memalloc_noio_save() masks IO
> part out of that, right? It might be worthwhile to explain why we aren't
> passing down GPF flags throughout and instead depending on masking.

I have gone with masking because that seemed easier to review and more
robust solution. vmalloc does support NOFS/NOIO contexts these days (it
will just uses scoped masking in those cases). Propagating the gfp
throughout the worker code path is likely possible, but I haven't really
explored that in detail to be sure. Would that be preferable even if the
fix would be more involved?

> Also, doesn't the above always prevent percpu allocations from doing fs/io
> reclaims? 

Yes it does. Probably worth mentioning in the changelog. These
allocations should be rare so having a constrained reclaim didn't really
seem problematic to me. There should be kswapd running in the background
with the full reclaim power.

> ie. Shouldn't the masking only be used if the passed in gfp
> doesn't allow fs/io?

This is a good question. I have to admit that my understanding might be
incorrect but wouldn't it be possible that we could get the lock
dependency chain if GFP_KERNEL and scoped NOFS alloc_pcp calls are
competing? 

					fs/io lock
					pcpu_alloc_noprof(NOFS/NOIO)
pcpu_alloc_noprof(GFP_KERNEL)
  pcpu_schedule_balance_work
    pcpu_alloc_mutex
    					  pcpu_alloc_mutex
      allocation_deadlock throgh fs/io lock

This is currently not possible because constrained allocations only do
trylock.

Makes sense?
-- 
Michal Hocko
SUSE Labs


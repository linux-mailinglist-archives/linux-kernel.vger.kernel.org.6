Return-Path: <linux-kernel+bounces-306281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D0C0963C9C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 09:19:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F6DA286708
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 07:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD76617277F;
	Thu, 29 Aug 2024 07:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JxEVMcCN"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09FF71547E3
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 07:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724915959; cv=none; b=cKaa8PB2GkX7tl7o1p7z/QAtSKq6D4uREk25gNrZDGpbYsZPj6LbDt4SHSPXSOC++mu3oWdTXCH5oZOlWeXgTXBn0qNd3DHcK5iMRQIF7gVOSK1rMSUmxSqB4c8Gvvqt8D+UUscwDiNF13SC6JG7QDddn0bG2CtGM9L2jUqaiVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724915959; c=relaxed/simple;
	bh=TISxj6nsuiWrdhbb47Ec6ZP2r5NbItH83bfghYORogE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MsQYILtVONbyV8/z6e6Q8tshxGjeXt6wJioSFqi9ksRD6ipELo1RPBJV7gTIxbX92Gw5VfR1tATiu2z3582IaveeMDWQvXx7XYgfnaHhAFFk2bWBycG+LM1UpooO3XXRmwk6cOELTbSVZn8SpoEfXF0GUUsoXhH5COMZNf8u6mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JxEVMcCN; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-367990aaef3so197087f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 00:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724915955; x=1725520755; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cZZ5Dfz1N7noCUMuVJV0Kdu8cyfE+FvZY+c2JPzrzUQ=;
        b=JxEVMcCNMVnAsfgSK8HAvKnOH1CQBceoxZehw7bB7oXPtVjQoui8R/tEuMyLdbRhEY
         BDiL39AeCL+8LLMjU9hFG0F/m2Gn1UZUQGc1flmkw1TWy1Rc676YFfZu76phiGcupGfN
         CUxX4VKfza71DKDeRBnmclH3YWjGAwnztlBCWBVcmWdMa3atoBfSxKN6w/6kDGSNZB2B
         6G2mxB0uk7rXQUJFVm6jEWycLi5jznTLAT8BjiCbpkyq39NE2pUNyfNZ9y9QMV4Wb6kG
         xGCeuyq1sDQHyojVadNI2kGTUfYHmA5VO4qR7rw4w+9TRKqPxGhw++dA5EHq4KE9JJVp
         Z30g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724915955; x=1725520755;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cZZ5Dfz1N7noCUMuVJV0Kdu8cyfE+FvZY+c2JPzrzUQ=;
        b=CCR/TfT6afAjloFtjzMgo61FcYjlt/87z52C5RHAjUbFEnn6p0cX9uaAcXgbTwPFv5
         aG888fAPUAycxRC9ReGX5IkGGCzkKkil3qopaPmyWqldKedHocjOZP3ltMacUbWGYygE
         B160MQo7duW9vdm1cGjDdaz/YvG85ZRqLlY9FoFwHS5NcciFS06ACnssMmhGM3iwjIUY
         As/uzJMXJyto7fZRQ2c/IiypQBfwLuyhiVX01r4yfA9nXr30pxk+8qI7XTuGjGm0Ni5R
         waaEOsk5L+jmC4VUBphrfgZRGe59OD0GelcB00aZIowm89s/wIvCTFgEQ/JkEQPLz1jb
         Yi4w==
X-Forwarded-Encrypted: i=1; AJvYcCU6aaK42J/XCkc/TLlcC8YtqREO+jEaG9yYXNnDVX35jvvNd0a7zvadFPeMUHMZ3a4ru+0aZUDBxUsk97s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDQKMFxugAr2t+uFV2BcF2sIljIjHSkaRq98i224ywaR/g4AYE
	UdOoCqmVd8PGHVwl+rh0x0M1TZMZTFVzWJTJfHmk3VPhSOneRGKsSjyrocx+sGw=
X-Google-Smtp-Source: AGHT+IGWX48blvuHIVWdw3Bdns41uj8z9ckLX+g7N99SFM42wMeFHQFkVqKqWrh8ih/Ez3xgeQ7kyg==
X-Received: by 2002:adf:b312:0:b0:371:82bc:7d93 with SMTP id ffacd0b85a97d-3749b526ec0mr1284850f8f.12.1724915955164;
        Thu, 29 Aug 2024 00:19:15 -0700 (PDT)
Received: from localhost (109-81-82-19.rct.o2.cz. [109.81.82.19])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3749ee9ba83sm665280f8f.54.2024.08.29.00.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 00:19:14 -0700 (PDT)
Date: Thu, 29 Aug 2024 09:19:13 +0200
From: Michal Hocko <mhocko@suse.com>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Dave Chinner <dchinner@redhat.com>
Subject: Re: [PATCH] bcachefs: Switch to memalloc_flags_do() for vmalloc
 allocations
Message-ID: <ZtAg8Slmclt8jm4a@tiehlicka>
References: <20240828140638.3204253-1-kent.overstreet@linux.dev>
 <Zs9xC3OJPbkMy25C@casper.infradead.org>
 <gutyvxwembnzaoo43dzvmnpnbmj6pzmypx5kcyor3oeomgzkva@6colowp7crgk>
 <Zs959Pa5H5WeY5_i@tiehlicka>
 <xxs3s22qmlzby3ligct7x5a3fbzzjfdqqt7unmpih64dk3kdyx@vml4m27gpujw>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xxs3s22qmlzby3ligct7x5a3fbzzjfdqqt7unmpih64dk3kdyx@vml4m27gpujw>

On Wed 28-08-24 18:58:43, Kent Overstreet wrote:
> On Wed, Aug 28, 2024 at 09:26:44PM GMT, Michal Hocko wrote:
> > On Wed 28-08-24 15:11:19, Kent Overstreet wrote:
> > > On Wed, Aug 28, 2024 at 07:48:43PM GMT, Matthew Wilcox wrote:
> > > > On Wed, Aug 28, 2024 at 10:06:36AM -0400, Kent Overstreet wrote:
> > > > > vmalloc doesn't correctly respect gfp flags - gfp flags aren't used for
> > > > > pte allocation, so doing vmalloc/kvmalloc allocations with reclaim
> > > > > unsafe locks is a potential deadlock.
> > > > 
> > > > Kent, the approach you've taken with this was NACKed.  You merged it
> > > > anyway (!).  Now you're spreading this crap further, presumably in an effort
> > > > to make it harder to remove.
> > > 
> > > Excuse me? This is fixing a real issue which has been known for years.
> > 
> > If you mean a lack of GFP_NOWAIT support in vmalloc then this is not a
> > bug but a lack of feature. vmalloc has never promissed to support this
> > allocation mode and a scoped gfp flag will not magically make it work
> > because there is a sleeping lock involved in an allocation path in some
> > cases.
> > 
> > If you really need this feature to be added then you should clearly
> > describe your usecase and listen to people who are familiar with the
> > vmalloc internals rather than heavily pushing your direction which
> > doesn't work anyway.
> 
> Michal, I'm plenty familiar with the vmalloc internals. Given that you
> didn't even seem to be aware of how it doesn't respect gfp flags, you
> seem to be the person who hasn't been up to speed in this discussion.

GFP_NOWAIT is explicitly documented as unsupported
(__vmalloc_node_range_noprof). vmalloc internals are using
vmap_purge_lock and blocking notifiers (vmap_notify_list) in rare cases
so PF_MEMALLOC_NORECLAIM is not really sufficient to provide NOWAIT
semantic (this is really not just about page tables allocations). There
might be other places that require blocking - I do not claim to be an
expert on the vmalloc allocator.

Just my 2 cents do whatever you want with this information. 

It seems that this discussion is not going to be really productive so I
will leave you here.

If you reconsider and realize that a productive discussion realy
requires also listening and respect then get back and we can try again.

Good luck!
-- 
Michal Hocko
SUSE Labs


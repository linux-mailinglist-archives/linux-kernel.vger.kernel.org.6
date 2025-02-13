Return-Path: <linux-kernel+bounces-512124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75D09A3345D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 02:04:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A2031659D5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 01:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1DC16F2F2;
	Thu, 13 Feb 2025 01:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nQCQxvT9"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA50B6FC3
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 01:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739408654; cv=none; b=J7g6JDRPfjxlW4pKVBODrQNJNNV+Aqp4LJyeQgHgAwDU8LM0bFvrAQW34FrKG6tbQFHiiECgyFH4zXTP04tGPigll+3EaFEqV4lsW1IGk+4dWhWabY6iWxIVC1SB4d4Xajjk4lTP4OUtiybY8kEKtzFIThiDn7Ib+ody7UCa1PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739408654; c=relaxed/simple;
	bh=g3fe0jDXcZCS3mUVQP+qhAvs9oAGxv2IZAXBclP3B3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MC/7gFNsgQjuLnhMDE4S43Z+eiV5bDokgaiTOEK54sHZv7oWcivff1uQK4GnFqXuA63OZgupxEjxDspsl6mLwyMCYlHxFCRN7vyKfDPFQ7DDXsXjX1GBWDLXlBs1vn6NNmJB0c83s80y/eMfGQ79mbUGWBx9om1Mdjf0u63sSpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=nQCQxvT9; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-220bfdfb3f4so5490575ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 17:04:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1739408652; x=1740013452; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YNBKlfsVmtlHTkH9IZhvvajaLh8zkK9XIaf8ryQGr5E=;
        b=nQCQxvT9uQARTXQJKbKqllooPSaJLV6vu8NaraSK3aUeqImjGt3xX6NQ/tMU4rciZr
         bQWaE0WmKC4K6msFpPHw6RCaP3V7ryggFzjtgyZmSjB1twD1bPcrMR3Ns5jAmBNPYiOx
         rTuzR6/qrqo54iNQ3bhd5pOjICY2OtyJxurrY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739408652; x=1740013452;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YNBKlfsVmtlHTkH9IZhvvajaLh8zkK9XIaf8ryQGr5E=;
        b=oDvR70ir/i1wZjjwH7J4WJxnTjiiMtOoLfEjUWMYOLyLs8Qpc/51o1m04ZuA6d05/f
         OFMi6NKxop0QwY5mfEk5ooX0s2ndFylmJZBI8Qn2urWKQ+ecjm1EYK9rUFRIycNu/C69
         LxpOlgfPC2j4cvLJ5ox8DXvskSluPoVi8rVVvB7PvjPn3TkB1PrvQfcrOtd+DUm9mp5c
         Q07q+brGDEf2PDdXPx7okiPx4aXrPOMq4OdASVcc+wDTH+9Ai5IO1nJ83+y6Bgk4K49X
         3UkOrZceoO2iu/rqAj4BnA/TZhD05//jl7aHUDeO5CSNpiYBtfDH8GpGvEvDjdQjuRQR
         8MmQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0S4t1DWkc38L8aX2ep3EUIx8eYjfYIyt+jfdi7F5LgQQkKFWZEl8hpz5ED76USCOF6qC0gS5IFry71p8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgPw9usq1e6g1rASkpx/gEInjpSDLKifOnVVsdc87UhHPpP33l
	uylqrTM+8K8lPT0wkuXod9EUqFRIMm4Vqj+QJ0fLrdTNC37+/YkoN5TG9Pu2jg==
X-Gm-Gg: ASbGncvXnmRGptw/5NrBxmvEyIcY2iLlItAGgBn/90lL07oawTX5QhRk4INKXb/MdEd
	2j8nPaOmwQOjirjfmKT4YkJI0+1C7xHs8j81PbxDE8bNDTWtBBJSPcoPF1f9iLRNaoZLHn4bPIM
	jeNKTZIJ84UFjMDC24VRFon5aWoa89if8yr3WJ/5sX5SXQaflfcJreUwZG3Q8kSuueYix5XKYZg
	FXzOGld6K1lux/wI2iYo2Zq3eBagr6QZymc6g2aaGTFiaZx1LE+9oLeUeoL36wY3p+htusEW+Hs
	odaAt7VmAmutksY8q1c=
X-Google-Smtp-Source: AGHT+IEsXd7pTwSdHVb6/w5n0BoUOPkwr/sRjXyRUZKPV0O4FUJWx/q+Ok9ezXMZIpRjdgj7hmkV+A==
X-Received: by 2002:a05:6a20:914d:b0:1ee:6b16:983e with SMTP id adf61e73a8af0-1ee6b169967mr2949103637.11.1739408651929;
        Wed, 12 Feb 2025 17:04:11 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:69f5:6852:451e:8142])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-adb5a5304a9sm61241a12.52.2025.02.12.17.04.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 17:04:11 -0800 (PST)
Date: Thu, 13 Feb 2025 10:04:05 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Kairui Song <ryncsn@gmail.com>, Minchan Kim <minchan@kernel.org>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 02/18] zram: permit preemption with active compression
 stream
Message-ID: <js555qtbh76tq3wn4o3qcnwbwddv3l7xyob35iszjw3ifvoyi2@kupe2ii762cu>
References: <20250212063153.179231-1-senozhatsky@chromium.org>
 <20250212063153.179231-3-senozhatsky@chromium.org>
 <Z6zF5QvTQwVoAhMP@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6zF5QvTQwVoAhMP@google.com>

On (25/02/12 16:01), Yosry Ahmed wrote:
> On Wed, Feb 12, 2025 at 03:27:00PM +0900, Sergey Senozhatsky wrote:
> > Currently, per-CPU stream access is done from a non-preemptible
> > (atomic) section, which imposes the same atomicity requirements on
> > compression backends as entry spin-lock, and makes it impossible
> > to use algorithms that can schedule/wait/sleep during compression
> > and decompression.
> > 
> > Switch to preemptible per-CPU model, similar to the one used
> > in zswap.  Instead of a per-CPU local lock, each stream carries
> > a mutex which is locked throughout entire time zram uses it
> > for compression or decompression, so that cpu-dead event waits
> > for zram to stop using a particular per-CPU stream and release
> > it.
> > 
> > Suggested-by: Yosry Ahmed <yosry.ahmed@linux.dev>
> > Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> > ---
> >  drivers/block/zram/zcomp.c    | 36 +++++++++++++++++++++++++----------
> >  drivers/block/zram/zcomp.h    |  6 +++---
> >  drivers/block/zram/zram_drv.c | 20 +++++++++----------
> >  3 files changed, 39 insertions(+), 23 deletions(-)
> > 
> > diff --git a/drivers/block/zram/zcomp.c b/drivers/block/zram/zcomp.c
> > index bb514403e305..e83dd9a80a81 100644
> > --- a/drivers/block/zram/zcomp.c
> > +++ b/drivers/block/zram/zcomp.c
> > @@ -7,6 +7,7 @@
> >  #include <linux/wait.h>
> >  #include <linux/sched.h>
> >  #include <linux/cpu.h>
> > +#include <linux/cpuhotplug.h>
> 
> What code changes prompt this?

Just a missing header include.  We use cpuhotplug.
I actually think I wanted to replace cpu.h with it.

> >  #include <linux/crypto.h>
> >  #include <linux/vmalloc.h>
> >  
> > @@ -54,6 +55,7 @@ static int zcomp_strm_init(struct zcomp *comp, struct zcomp_strm *zstrm)
> >  {
> >  	int ret;
> >  
> > +	mutex_init(&zstrm->lock);
> 
> I don't think we can initialize the mutex in the hotplug callback. I
> think the following scenario is possible:
> 
> CPU #1					CPU #2
> zcomp_stream_get()
>   zstrm = raw_cpu_ptr()
> /* task migrated to CPU 2 */
> 
> CPU goes offline
>   zcomp_cpu_dead()
>     mutex_lock()
>     ..
>     mutex_unlock()
> 					/* migrated task continues */
> 					zcomp_stream_get()
> 					  mutex_lock()
> CPU goes online
>   mutex_init()
>   					  mutex_unlock() /* problem */
> 					
> In this case we'll end up initializing the mutex on CPU #1 while CPU #2
> has it locked. When we unlocked it on CPU #2 we will corrupt it AFAICT.
> 
> This is why I moved the mutex initialization out of the hotplug callback
> in zswap. I suspect to do something similar for zram we'd need to do it
> in zcomp_init()?

Yeah, I think you are right.  Let me take a look.

> >  	ret = comp->ops->create_ctx(comp->params, &zstrm->ctx);
> >  	if (ret)
> >  		return ret;
> > @@ -109,13 +111,29 @@ ssize_t zcomp_available_show(const char *comp, char *buf)
> >  
> >  struct zcomp_strm *zcomp_stream_get(struct zcomp *comp)
> >  {
> > -	local_lock(&comp->stream->lock);
> > -	return this_cpu_ptr(comp->stream);
> > +	for (;;) {
> > +		struct zcomp_strm *zstrm = raw_cpu_ptr(comp->stream);
> > +
> > +		/*
> > +		 * Inspired by zswap
> > +		 *
> > +		 * stream is returned with ->mutex locked which prevents
> > +		 * cpu_dead() from releasing this stream under us, however
> > +		 * there is still a race window between raw_cpu_ptr() and
> > +		 * mutex_lock(), during which we could have been migrated
> > +		 * to a CPU that has already destroyed its stream.  If so
> 
> "we could have been migrated from** a CPU that has already destroyed its
> stream"? Right?

"from", "to"... what's the difference :)


Return-Path: <linux-kernel+bounces-532963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E229A45433
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 04:57:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 517777A32BE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 03:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96AC025E44B;
	Wed, 26 Feb 2025 03:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="Lu6Nx4Ry"
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63BD253F05
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 03:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740542259; cv=none; b=CiHbXgWkCuJcBoC0k7rNgZlaFZ+9Hk+AcnqWBJe1G+NHTqaa83IiI00RIuDfwwjavplqkIBl163rVVnu59WPGfjuzaGZppMPcH7Liocl3iyqCVUHD0E3mT4ygMlNQTqNyc6YCCSjAThnPgKyFdNwgnDgNPxhp+fILGahgJwcm/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740542259; c=relaxed/simple;
	bh=S8CueGnUhBX+InO7Ps5YZ8Q5A2f6RMU32xQPe/HsHj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hgr/BFaT7Coolo3J3Np/wB6TydMicUEgPDHNfCnRVRKuAAuEu5BIw0jZ8FxWNkh6AJ5UZHOnY/gymZC7I1K0sOEIKdCGSt/SZacdf+3BJhXCOTA81+7nE2Cv3EvdR2+N3HjZl69l5GblkO7fhQbLnLpjTjPAc1lwAUX14lkx5Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=Lu6Nx4Ry; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7c0ade6036aso50710985a.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 19:57:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1740542255; x=1741147055; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GezmTNX8+C8WiOApS4hZZNlcHuSlvsEOcsQtDlYSxss=;
        b=Lu6Nx4Ryk8nwaS6nCNkR0ojNqPcfvKFTGiN9NKseLarZMcypDPfG4bc9u8bpZ/e0P4
         Zs81fxiE2C/ey3oQfozfs1qatcKIgbjqoQubDX0y6AKshPTi4VI+XTlrhdsW+IE3WotM
         AZ6K7177CeOWxYrdQlPZ5hpY0octWlR8g1vuX+N7e3Hp7qM4fB79dM6pbY/Qgqw4dwhV
         m+BCha7zCQ3TlF6jdvyrrVluKmY4EBmbu+GMfYXzYo0hh/jX1n5jLM1+GnqYt6kaZTSv
         wfahDyo8TOvCoH/TlkG9v8UGhRdf23UtuzeBU3vse2FtoxCbXC0AJnHerEV9erVjkjJO
         uggw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740542255; x=1741147055;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GezmTNX8+C8WiOApS4hZZNlcHuSlvsEOcsQtDlYSxss=;
        b=rKcR6UF9UJjwLM1f+DI5DtUGVuvtp/o08SW6yBor4l32MQHTN2PoqtgtEwmXoTeMhK
         r0x/L3jiLSAk5R6SEOFhOIPF4e8zU5F+vVausU2C3o6W4Ff1Csu6thxggcnpxgyPJN2Z
         w3IQ9w6HMHGK+AmBj/XF8LP3WSdhfjYEjib4i6Wy9qJpj1hOr6/6HiLkuRk+MYvEFzg6
         qcqfHg+4ZVw4b8V8bifG0jZiBMzrFwE5ac/UzXdcc6TTuTTCf0IZ8h+Qbfhk75uo9CG+
         38HOxjuxCzrrBH3IIaRKLMSZ2fHikN8rAi4fIZNVaHJfABwY0+wHizl8xMIyjHMYnWPJ
         qz2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXPWbr5QzZ7brSosl/KWnvJWTTqlsQDXL4WRhRqbhbAbtSMBCIKtoHdDAu0cp8HoJY+5gYlKoTTZvtoF/U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvL4/3hK92m1tRUoU5qrdA0QDuo9n0HGfvuXaEYKJ3og88E54P
	3Yk/AardZVTeeM90hL5pXV+gDlA40+alGwSrL5FwGENsXkFW9B5qk7gVaw9DqUPlGFh4jfcadsn
	A
X-Gm-Gg: ASbGncv/JBPJsewWEHPoD2tZ8ypihysZe//M/eMIw5I3JKo8YVHosJ0QCVA/RTLIFuX
	88RVLu5Az9oY7PR9GgLg7AnSDtkgKHQ64WUM2JxAfGvvVkJ6YEh9bJ087rhk5Rr+MyC1QVoODWM
	jzBBHNZenVuHn5WMLuaN8cNJNAJG2WSMO9VCTOLJkh71IX7gccBXzuqnkvH7tb4faC0UkdGgFzz
	FpICFHkKOkErTXpcKU9VdPWq94chj/GtoN6wCGKgcFprmtG5vCAc20Y/J8GuJtAUcn62xuEhTK0
	rSTUZkSheACQJEpbhmPw9xPe
X-Google-Smtp-Source: AGHT+IFxVs7WaOj9SrpMU2Qpcc6TtLkLZ68EjS+bv1tuwu7c6k3k8VtnWZ6bWvllrdQzwoexERXttw==
X-Received: by 2002:a05:620a:1a8a:b0:7c0:a9ee:e6c1 with SMTP id af79cd13be357-7c0c2190e26mr3207066685a.7.1740542255247;
        Tue, 25 Feb 2025 19:57:35 -0800 (PST)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c23c2a5bedsm193006685a.26.2025.02.25.19.57.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 19:57:33 -0800 (PST)
Date: Tue, 25 Feb 2025 22:57:30 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org,
	chengming.zhou@linux.dev, linux-mm@kvack.org, kernel-team@meta.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] zswap: do not crash the kernel on decompression failure
Message-ID: <20250226035730.GA1775487@cmpxchg.org>
References: <20250225213200.729056-1-nphamcs@gmail.com>
 <20250226005149.GA1500140@cmpxchg.org>
 <Z76AVZ_tjq2NvmLT@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z76AVZ_tjq2NvmLT@google.com>

On Wed, Feb 26, 2025 at 02:45:41AM +0000, Yosry Ahmed wrote:
> On Tue, Feb 25, 2025 at 07:51:49PM -0500, Johannes Weiner wrote:
> > On Tue, Feb 25, 2025 at 01:32:00PM -0800, Nhat Pham wrote:
> > > +	}
> > >  	mutex_unlock(&acomp_ctx->mutex);
> > >  
> > >  	if (src != acomp_ctx->buffer)
> > >  		zpool_unmap_handle(zpool, entry->handle);
> > > +	return ret;
> > >  }
> > >  
> > >  /*********************************
> > > @@ -1018,6 +1028,7 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
> > >  	struct writeback_control wbc = {
> > >  		.sync_mode = WB_SYNC_NONE,
> > >  	};
> > > +	int ret = 0;
> > >  
> > >  	/* try to allocate swap cache folio */
> > >  	mpol = get_task_policy(current);
> > > @@ -1034,8 +1045,8 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
> > >  	 * and freed when invalidated by the concurrent shrinker anyway.
> > >  	 */
> > >  	if (!folio_was_allocated) {
> > > -		folio_put(folio);
> > > -		return -EEXIST;
> > > +		ret = -EEXIST;
> > > +		goto put_folio;
> > >  	}
> > >  
> > >  	/*
> > > @@ -1048,14 +1059,17 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
> > >  	 * be dereferenced.
> > >  	 */
> > >  	tree = swap_zswap_tree(swpentry);
> > > -	if (entry != xa_cmpxchg(tree, offset, entry, NULL, GFP_KERNEL)) {
> > > -		delete_from_swap_cache(folio);
> > > -		folio_unlock(folio);
> > > -		folio_put(folio);
> > > -		return -ENOMEM;
> > > +	if (entry != xa_load(tree, offset)) {
> > > +		ret = -ENOMEM;
> > > +		goto fail;
> > >  	}
> > >  
> > > -	zswap_decompress(entry, folio);
> > > +	if (!zswap_decompress(entry, folio)) {
> > > +		ret = -EIO;
> > > +		goto fail;
> > > +	}
> > > +
> > > +	xa_erase(tree, offset);
> > >  
> > >  	count_vm_event(ZSWPWB);
> > >  	if (entry->objcg)
> > > @@ -1071,9 +1085,14 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
> > >  
> > >  	/* start writeback */
> > >  	__swap_writepage(folio, &wbc);
> > > -	folio_put(folio);
> > > +	goto put_folio;
> > >  
> > > -	return 0;
> > > +fail:
> > > +	delete_from_swap_cache(folio);
> > > +	folio_unlock(folio);
> > > +put_folio:
> > > +	folio_put(folio);
> > > +	return ret;
> > >  }
> > 
> > Nice, yeah it's time for factoring out the error unwinding. If you
> > write it like this, you can save a jump in the main sequence:
> > 
> > 	__swap_writepage(folio, &wbc);
> > 	ret = 0;
> > put:
> > 	folio_put(folio);
> > 	return ret;
> > delete_unlock:
> 
> (I like how you sneaked the label rename in here, I didn't like 'fail'
> either :P)
> 
> > 	delete_from_swap_cache(folio);
> > 	folio_unlock(folio);
> > 	goto put;
> 
> I would go even further and avoid gotos completely (and make it super
> clear what gets executed in the normal path vs the failure path):
> 
> 	__swap_writepage(folio, &wbc);
> 	folio_put(folio);
> 	if (ret) {
> 		delete_from_swap_cache(folio);
> 		folio_unlock(folio);
> 	}
> 	return ret;

The !folio_was_allocated case only needs the put. I guess that could
stay open-coded.

And I think you still need one goto for the other two error legs to
jump past the __swap_writepage.

> > Something like this?
> > 
> > 	if (!zswap_decompress(entry, folio)) {
> > 		/*
> > 		 * The zswap_load() return value doesn't indicate success or
> > 		 * failure, but whether zswap owns the swapped out contents.
> > 		 * This MUST return true here, otherwise swap_readpage() will
> > 		 * read garbage from the backend.
> > 		 *
> > 		 * Success is signaled by marking the folio uptodate.
> > 		 */
> 
> We use the same trick in the folio_test_large() branch, so maybe this
> should be moved to above the function definition. Then we can perhaps
> refer to it in places where we return true wihout setting uptodate for
> added clarity if needed.

That makes sense to me. Nhat, what do you think?


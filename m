Return-Path: <linux-kernel+bounces-404209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A089C40D6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 15:26:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B52C281A22
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 14:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FB8C1A01BD;
	Mon, 11 Nov 2024 14:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="HeKvQTMS"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72C619F487
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 14:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731335169; cv=none; b=YBf3gp9WajqfqNWzX3au68ux/ojKHOqjyhAaqF1o7JS8RcGQKT/5/vPUYqyCeznA1aSSLJNum4fie8PZjtLiUhiPF2eVJkYILo4FibS3Htdq71tlk3SzT7nfWnMB6rgdwrA5mv1FmXA4lXam1HlSGibihLH3Bi0EodsArNP4NN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731335169; c=relaxed/simple;
	bh=vVv0qLGf0PhSSslgQFpHSGSc230cQNAyYtYD8MTpOBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MgmsYxqvzN1R3rmCa8iFLPk9SXHBqDUQU3igyCsmvZArHl+XOv1R4C/ae2bUGWvOIu1e0TmgS7quyPkDBlPkYBXCW3CYhf852AjEu6maR7LWGJttDLJVMYdPYxzDUxCx09Tps/FePZNiKSqvtHGy0hNuKOuVXvWXlWfiz8UH8lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=HeKvQTMS; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-460da5a39fdso35150711cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 06:26:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1731335166; x=1731939966; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=C2yryb5aLrrxVSROpkdAf94RmItE+hzldVGe+/Wk7W8=;
        b=HeKvQTMS9RlIWRAGUZRZHCqRuSqiVtIYNZdLFnRhlzpHXPBvns8RfxvhaAGz1ktIDD
         iy+quT/iS/pto38umt0asau5qeUoPSAQsHdpfsMAc/PIqoAQpIBLay4qKIxS5hAERVT/
         1Sg+8OfEeeCluFYpjCjWZUbvP5Qsk8zRZn3F4UDTmRHB/qhhSdHfR8/Xob8/Dxmc1BXm
         z5AHOFipOp1C83G3edxHkMgkuSu07/OU4eEHruGsr1LxAQx4e2SAiRCb4ByINz6TdU9E
         6IM2YO7gxT3Z1/1mZX2DgzwoIIvNRMs9bW45WrrZ2JIltKc8AluVSHf7rEODmqtxghWT
         ZlOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731335166; x=1731939966;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C2yryb5aLrrxVSROpkdAf94RmItE+hzldVGe+/Wk7W8=;
        b=E994f8etHVKKc8UGxzfa0QS2fljyHDKpQZHXHoq8aGu60AdRLG4hNAEALgpbeT0c+L
         Qr/kpkqCOi4izJ9YMPFsSUM3LxJfCxDTXF28Ff4D49QINRhkVJxPd4Ilz0eX6UvIJo07
         SoPuyWUXFz7wOg57tTEle4ujOkHfImOOo/Fv03zUp6e257TW0GvsKyLLpl9lu3EVyIbb
         4IBImAPPFiagRjCmWFCE3TBzbjYmdUTC9T/V1fzsTeJic0s6AWBPPJ7BCNxGUkEUJCKc
         qLXtQkhyE5a+atvXNk1PsVsPTQTS7sIcwooVU/8TkLGqlVIjPPHxurS8PX5i19mKlII4
         yc3A==
X-Forwarded-Encrypted: i=1; AJvYcCW22tdnTlle1xz2FKgW7P336My18uQVITHQNtGEaDQuvIJX1QkbTuYt8XkThms91fXx899vKVNr+3t43Ms=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmcvJEboiJ/inOw1Nsh8OhI2b4OTxOMTOzkdyAdfMmR/mi1NI+
	UQCBwXkCu3Tcr6p0ZKFfRUqn0xdwx02Cy5iNMDZSlEQ1C3B5+QkckR+c8yzvIRI=
X-Google-Smtp-Source: AGHT+IFPdYEpcKfecpWu0FQOfeCgLNf7UC9dknpW5konBKA13v5oKoN1DYrUxOBelYHyRyIAlmdnpw==
X-Received: by 2002:ac8:7dd3:0:b0:461:1c54:5bc9 with SMTP id d75a77b69052e-463094250cfmr169188541cf.51.1731335166583;
        Mon, 11 Nov 2024 06:26:06 -0800 (PST)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-462ff41148esm63083251cf.19.2024.11.11.06.26.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 06:26:05 -0800 (PST)
Date: Mon, 11 Nov 2024 09:25:45 -0500
From: Gregory Price <gourry@gourry.net>
To: "Huang, Ying" <ying.huang@intel.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org, david@redhat.com, nphamcs@gmail.com,
	nehagholkar@meta.com, abhishekd@meta.com,
	Johannes Weiner <hannes@cmpxchg.org>,
	Feng Tang <feng.tang@intel.com>
Subject: Re: [PATCH 0/3] mm,TPP: Enable promotion of unmapped pagecache
Message-ID: <ZzIT6eYeGXxhyG4g@PC2K9PVX.TheFacebook.com>
References: <20240803094715.23900-1-gourry@gourry.net>
 <875xrxhs5j.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <ZsNhgU-TiTz2WKg5@PC2K9PVX.TheFacebook.com>
 <87ikvefswp.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <ZykOqYJpgL4lw7mw@PC2K9PVX.TheFacebook.com>
 <87jzdi782s.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <Zy5R2JvXvhFoJzeY@PC2K9PVX.TheFacebook.com>
 <871pzi5z8y.fsf@yhuang6-desk2.ccr.corp.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871pzi5z8y.fsf@yhuang6-desk2.ccr.corp.intel.com>

On Mon, Nov 11, 2024 at 09:35:09AM +0800, Huang, Ying wrote:
> Gregory Price <gourry@gourry.net> writes:
> 
> >
> > Exploring and testing this a little further, I brought this up to current
> > folio work in 6.9 and found this solution to be unstable as-is.
> >
> > After some work to fix lock/reference issues, Johannes pointed out that
> > __filemap_get_folio can be called from an atomic context - which means it
> > may not be safe to do migrations in this context.
> 
> Sorry, I don't understand this, the above patch changes
> filemap_get_pages() and grab_cache_page_write_begin() instead of
> __filemap_get_folio().
>

on newer kernels, grab_cache_page_write_begin is a compat wrapper for
__filemap_get_folio and folio_file_page.  This chunk of code has changed
somewhat significantly, actually.
 
> > We're back to looking at something like an LRU-esque system, but now we're
> > thinking about isolating the folios in folio_mark_accessed into a task-local
> > list, and then process the list on resume.
> 
> If necessary, we can use a similar method for above solution too.  And
> we can filter accessed once folios with folio_mark_accessed() firstly.
> That is, only promote a page if,
> 
> - record the folio access time in folio_mark_accessed() only
> - when the folio are accessed again, and "access_time - record_time <
>   threshold", promote the folio.
> 

yes this was the thought.

> > Basically we're thinking
> >
> > 1) hook folio_mark_accessed and use PG_ACTIVE/PG_ACCESSED to determine whether
> >    the page is a promotion candidate.
> > 2) if it is, isolate it from the LRU - which is safe because folio_mark_accessed
> >    already does this elsewhere, and place it onto current->promo_queue
> > 3) set_notify_resume
> > 4) add logic to resume_user_mode_work() to run through current->promo_queue and
> >    either promote the pages accordingly, or do folio_putback_lru on failure.
> 
> Use a task_work?
> 

probably more correct, had a discussion about kernel threads accessing
file cache and we weren't sure if that situation even existed - so probably
going to try task_work first.

~Gregory


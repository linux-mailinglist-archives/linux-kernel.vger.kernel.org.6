Return-Path: <linux-kernel+bounces-259895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2A37939F09
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 12:55:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4C5C1C2200C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 10:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 270E114F122;
	Tue, 23 Jul 2024 10:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YYcLCW0C"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774543D6A
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 10:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721732150; cv=none; b=fCqzBRRyiGuAshnKWsDOehtdzc0jEeld5pPuW0n9KSL+j+9SygEu4gP++cLJnrpFIqaNYq6LMz9Za/9pQNK0eC3hFbylAb3koLweVtjC0cLMgg17GINkIzB8tkbxjGaes7rdmLt4FHEMJtF5pBFiW4VLqcRVgQZ2FQ9DErqirUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721732150; c=relaxed/simple;
	bh=qbgHZWjhOWkvRT4sxDgzHnN4j1pNIGBs0utjpq/oJ6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fWSKF85gkG8n9X2i9sSx161EbghJQWHGxD2z4kJk2iFE4YBwmzu+jXCdd8UYlAZU3+JfdVqsg5q3WfKN38XnLeKDtUAETcrVZ23DyCUBO2w+Q754Irf2n7OiRe4a03upJMEMEBSOH5u7f+cSe/gfcqzQ6LO/Ljbm3xVKICfKXr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=YYcLCW0C; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5a3b866ebc9so3470606a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 03:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1721732147; x=1722336947; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pe9A/KmjRfnSqmJTo8amFeX5jdsHC7+ce4ctbtBqkTM=;
        b=YYcLCW0C9TsDdVwHEkqsEyhTY1ZEpHncwHp5OzuN8Lw/suMIegv8BcuSE1WIbU8EXM
         4V9E+kf0Fzcnhk79xT95Ss8juRZ+pNHamE6coU39w1a6yDqAdr2jgjkgqNsLoC+FmH/j
         +H+e0rnFzZfRc7TR/V9rhFENsM7ICYnk+N3LCgwXx9f9KP9zsuifhF28kf9g/0twB3Hu
         BwGDOY4EMPLDipJimy1WzkF7ospuKvgwiCKB+hQpUyl4F2KP4oEwPefMtfaG7An0o1bD
         VNaLGtwfzPmv/92v8X65Q3777KsY0vcLwF3pwI8DCm+1Bj68Dq2LVQD8WgqqXDMH5Vrg
         4f1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721732147; x=1722336947;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pe9A/KmjRfnSqmJTo8amFeX5jdsHC7+ce4ctbtBqkTM=;
        b=rF1p9uQjKKhOqkzWbmRs6AafyS4VNpoXDKGuk/cRfF/fH1Ir/YwqPN4MvaJE8zPOdc
         sfpwG8bQnB6sVDKcic7xQBQfTfwRBj3bi/7+A1jlctm0JDn/I9+rBL2EKOV2XzvEli9v
         oCwO6aRb2fAclEeT0WGddu4KYznmNVRYjELUBPDo+wsdCFDWn/HaP7V7YtedTfDuGAIc
         ET2LE5Yho2eQ8RHBfIfQEqODJ7P8Rjffy9buIRX2KRwZvDKjiWJ0zIyFVi6rDgjzioJ7
         NvIdzuPaRYI2ihtOTis6MGGujB+cHNcq/TglduGNHWPHJsCo+m9T5TDQvFYISx/LBW5y
         qiYw==
X-Forwarded-Encrypted: i=1; AJvYcCX8KYYgN2JDdWaNRdTgPj16LHSLLp6ySUkbXVZ46WUH91Y/Me0OCDBEMqUE3ib4PFgOdqducK15eQEtGiJm/MsO66RC5dn1zLopz7IP
X-Gm-Message-State: AOJu0YwyHApewPUnW69M0JdeQwCVggdr5huQL3t8CXEPaFmI2gLIjvUR
	VHtMwIdqjz1K2wxSJeJzOUzgE7pWrGnixsf0+gVaZH4MtPU9SeoxO+q++YE3s+E=
X-Google-Smtp-Source: AGHT+IFnu1CtSD7NI8cX8oy1/s1fO3b09mRCXmn4chmnOxeVXYHzEOoS0aY4v6bJfNvEOu6l0cBSsg==
X-Received: by 2002:a50:c316:0:b0:5a2:d411:89fa with SMTP id 4fb4d7f45d1cf-5a47b3ce4c4mr5373936a12.36.1721732146651;
        Tue, 23 Jul 2024 03:55:46 -0700 (PDT)
Received: from localhost (109-81-94-157.rct.o2.cz. [109.81.94.157])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5a30c9beccesm7307633a12.96.2024.07.23.03.55.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 03:55:46 -0700 (PDT)
Date: Tue, 23 Jul 2024 12:55:45 +0200
From: Michal Hocko <mhocko@suse.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: cl@linux.com, penberg@kernel.org, rientjes@google.com,
	iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, vbabka@suse.cz,
	roman.gushchin@linux.dev, 42.hyeyoo@gmail.com, urezki@gmail.com,
	hch@infradead.org, kees@kernel.org, ojeda@kernel.org,
	wedsonaf@gmail.com, mpe@ellerman.id.au, chandan.babu@oracle.com,
	christian.koenig@amd.com, maz@kernel.org, oliver.upton@linux.dev,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v2 2/2] mm: kvmalloc: align kvrealloc() with krealloc()
Message-ID: <Zp-MMcf1xUgqtFGS@tiehlicka>
References: <20240722163111.4766-1-dakr@kernel.org>
 <20240722163111.4766-3-dakr@kernel.org>
 <Zp9gtelmvzN5tfpS@tiehlicka>
 <Zp-JCWCPbDLkzRVw@pollux>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zp-JCWCPbDLkzRVw@pollux>

On Tue 23-07-24 12:42:17, Danilo Krummrich wrote:
> On Tue, Jul 23, 2024 at 09:50:13AM +0200, Michal Hocko wrote:
> > On Mon 22-07-24 18:29:24, Danilo Krummrich wrote:
[...]
> > > Besides that, implementing kvrealloc() by making use of krealloc() and
> > > vrealloc() provides oppertunities to grow (and shrink) allocations more
> > > efficiently. For instance, vrealloc() can be optimized to allocate and
> > > map additional pages to grow the allocation or unmap and free unused
> > > pages to shrink the allocation.
> > 
> > This seems like a change that is independent on the above and should be
> > a patch on its own.
> 
> The optimizations you mean? Yes, I intend to do this in a separate series. For
> now, I put TODOs in vrealloc.

No I mean, that the change of the signature and semantic should be done along with
update to callers and the new implementation of the function itself
should be done in its own patch.

[...]
> > > +void *kvrealloc_noprof(const void *p, size_t size, gfp_t flags)
> > >  {
> > > -	void *newp;
> > > +	void *n;
> > > +
> > 
> > 	if (!size && p) {
> > 		kvfree(p);
> > 		return NULL;
> > 	}
> > 
> > would make this code flow slightly easier to read because the freeing
> > path would be shared for all compbinations IMO.
> 
> Personally, I like it without. For me the simplicity comes from directing things
> to either krealloc() or vrealloc(). But I'd be open to change it however.

I would really prefer to have it there because it makes the follow up
code easier.

> > > +	if (is_vmalloc_addr(p))
> > > +		return vrealloc_noprof(p, size, flags);
> > > +
> > > +	n = krealloc_noprof(p, size, kmalloc_gfp_adjust(flags, size));
> > > +	if (!n) {
> > > +		/* We failed to krealloc(), fall back to kvmalloc(). */
> > > +		n = kvmalloc_noprof(size, flags);
> > 
> > Why don't you simply use vrealloc_noprof here?
> 
> We could do that, but we'd also need to do the same checks kvmalloc() does, i.e.
> 
> 	/*
> 	 * It doesn't really make sense to fallback to vmalloc for sub page
> 	 * requests
> 	 */
> 	if (ret || size <= PAGE_SIZE)
> 		return ret;

With the early !size && p check we wouldn't right?

> 
> 	/* non-sleeping allocations are not supported by vmalloc */
> 	if (!gfpflags_allow_blocking(flags))
> 		return NULL;
> 
> 	/* Don't even allow crazy sizes */
> 	if (unlikely(size > INT_MAX)) {
> 		WARN_ON_ONCE(!(flags & __GFP_NOWARN));
> 		return NULL;
> 	}

I do not see why kvrealloc should have different set of constrains than
vrealloc in this regards.

> Does the kmalloc() retry through kvmalloc() hurt us enough to do that? This
> should only ever happen when we switch from a kmalloc buffer to a vmalloc
> buffer, which we only do once, we never switch back.

This is effectively open coding part of vrealloc without any good
reason. Please get rid of that.

-- 
Michal Hocko
SUSE Labs


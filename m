Return-Path: <linux-kernel+bounces-286742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C8ED951E78
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 17:23:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EAD81F22E9E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 15:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3E6A1B4C23;
	Wed, 14 Aug 2024 15:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="etPLlZmR"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC981B3754
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 15:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723649029; cv=none; b=iAZ5tzP8oFwn933P2PfLsSNbuq/jLgsDO9wGAdK5s5g/8CXSCY3k+wZp8OV5BZoNSFK3YnqmNxJLAVsTiWNcxURz+u5IQxjmYQT+ws2s9f2ylkfyYDL8XrCO+HEAw/8ZqMkkCNf5NjSUUjcwHO6h6lxIsdSL/af6Ips3qCUsc40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723649029; c=relaxed/simple;
	bh=Nwu6AOyIY+9XqqBV4jzy/iBi3h/hn7gajGWpFixPvmk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HSFaPnE8G9bZbK2bd/6WW7tBj3+LfvrQC+4JszL7iR5eR4aNYP0XB7GUUsq+emkWkJnfIF96OBKGReoO4Oy+aBcC7G4rMhQyQT6NjPJII9GrMGo3znZHtlGMQA9zfW2UGnHw0JbeAvz3kLybFhAjJq0ZL3oHjaoEqhFnCiTuz+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=etPLlZmR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723649026;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rj2ZyeWKjea3ZB5hLuY/mn/YSKMmrc3bYlHWoh9tPIo=;
	b=etPLlZmRxVlTktOzHIktQtPIhsLgI3oSsLdY+naSAEPBC6vwRkxT4lRIGppTkofwe+401F
	qetOTMLcsXN2qmnS1jBQTJxndNjm2zjBPMHKzmgyKUBJUyZfe51TXAvt8q8cyyXqpd36Eo
	Ke3/P8La2zSTmXKpuXVrLDQRwrU4sIQ=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-269-USnt9CYqMZaWhHud4Mupfw-1; Wed, 14 Aug 2024 11:23:45 -0400
X-MC-Unique: USnt9CYqMZaWhHud4Mupfw-1
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-3db3874fe0fso1064247b6e.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 08:23:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723649024; x=1724253824;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rj2ZyeWKjea3ZB5hLuY/mn/YSKMmrc3bYlHWoh9tPIo=;
        b=sQCEaX2+WPttsT7yqICJOgOmhtqGP6hsuDQD5WdNjqwz0YR8z+/k2vOoKc1gHGjp8K
         U0HK4X4lhkjlq5kdWJN+31Tt3sDkeaUcE4yTId11Dea0lL6m1tpEhkMEMw5GvgI4h1kR
         PawcnELxEw+SHK6CYw3JStO/lD4aL8t9j5mKp5jlldtuLJDIOXmz7htAKEsOFuZygZUF
         g5WfZ2l4LHiyMUFkbMI7Yzd3M+kZFlYSeVzghAeEj89q0AjAWzckTNY3YvwNTO/ZJ6HF
         sSdMzuSaV4gJpBIfTkoJTK3j7u0um5WF/VC87Iur8WD+fryKMqZ5na9VC3UmNQSQK+JI
         4pYA==
X-Forwarded-Encrypted: i=1; AJvYcCV3BELuJKXe2tAyQV11R3V/949BKx99mJfUjMAW0q5KxffSSZmuSPr+EV6qHLprMiBjER2xuXegnCBFBRfxt6Nnve7t1NHyGuriZfJD
X-Gm-Message-State: AOJu0YwNaiiT8u9gQ8WTsno8aTBqpVhd5cgLgINi6LValnjsio0/Txis
	+BrpH7XCx/MouW1TEV1mRztAz+WytHQ6KhXWLXpDhg/hyE6KaufwlP22LYieMGYEGcVJHuKKswa
	sGSOCZICHgQcYkIlZz8TIV9uGNYvYz3CWrD/ugihSYzXwkXvrpFvE7Pww8cJS2Q==
X-Received: by 2002:a05:6830:90d:b0:703:5c3e:c134 with SMTP id 46e09a7af769-70c9d982a41mr2127146a34.2.1723649024473;
        Wed, 14 Aug 2024 08:23:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFGKA0i3nrg2nuMRX62k+dnMOQIF1k4Xa29cLk2aSCaOULEklqxi3Psl4Me7eY1Bt4qi3az3A==
X-Received: by 2002:a05:6830:90d:b0:703:5c3e:c134 with SMTP id 46e09a7af769-70c9d982a41mr2127112a34.2.1723649024175;
        Wed, 14 Aug 2024 08:23:44 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bd82c7eb2fsm45155866d6.40.2024.08.14.08.23.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 08:23:43 -0700 (PDT)
Date: Wed, 14 Aug 2024 11:23:41 -0400
From: Peter Xu <peterx@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Sean Christopherson <seanjc@google.com>,
	Oscar Salvador <osalvador@suse.de>,
	Axel Rasmussen <axelrasmussen@google.com>,
	linux-arm-kernel@lists.infradead.org, x86@kernel.org,
	Will Deacon <will@kernel.org>, Gavin Shan <gshan@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>, Zi Yan <ziy@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Ingo Molnar <mingo@redhat.com>,
	Alistair Popple <apopple@nvidia.com>,
	Borislav Petkov <bp@alien8.de>,
	David Hildenbrand <david@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>, kvm@vger.kernel.org,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Yan Zhao <yan.y.zhao@intel.com>
Subject: Re: [PATCH 03/19] mm: Mark special bits for huge pfn mappings when
 inject
Message-ID: <ZrzL_Yljjw0w9ZSi@x1n>
References: <20240809160909.1023470-1-peterx@redhat.com>
 <20240809160909.1023470-4-peterx@redhat.com>
 <20240814124000.GD2032816@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240814124000.GD2032816@nvidia.com>

On Wed, Aug 14, 2024 at 09:40:00AM -0300, Jason Gunthorpe wrote:
> On Fri, Aug 09, 2024 at 12:08:53PM -0400, Peter Xu wrote:
> > We need these special bits to be around to enable gup-fast on pfnmaps.
> 
> It is not gup-fast you are after but follow_pfn/etc for KVM usage
> right?

Gup-fast needs it to make sure we don't pmd_page() it and fail early.  So
still needed in some sort..

But yeah, this comment is ambiguous and not describing the whole picture,
as multiple places will so far rely this bit, e.g. fork() to identify a
private page or pfnmap. Similarly we'll do that in folio_walk_start(), and
follow_pfnmap.  I plan to simplify that to:

  We need these special bits to be around on pfnmaps.  Mark properly for
  !devmap case, reflecting that there's no page struct backing the entry.

> 
> GUP family of functions should all fail on pfnmaps.
> 
> > Mark properly for !devmap case, reflecting that there's no page struct
> > backing the entry.
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  mm/huge_memory.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

So I'll tentatively take this with the amended commit message, unless
there's objection.

Thanks,

-- 
Peter Xu



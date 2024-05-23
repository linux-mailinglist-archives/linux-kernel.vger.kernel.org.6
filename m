Return-Path: <linux-kernel+bounces-188095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0732C8CDD1C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 01:07:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8793EB21479
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 23:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E673128389;
	Thu, 23 May 2024 23:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TKOYZL+L"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1B6763E6
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 23:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716505635; cv=none; b=aTsk6ktiBXSCC3P82A3ey3nBCIH5J7+kA8/1ae41caKds2PWQ47gb5FCusY2tcwgABarO4Ir8g9T/dWPJJwm466YKF7BCvTJlnJBuNGUa5ycf+WJe/wgQSK+WR1oecI8ef3fgOAxxYq88z7lXKHyKpPVKYxlSo4uMkV0pdUw/jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716505635; c=relaxed/simple;
	bh=IVN/mtqfTzSQz5DOSJd2FkfrtcnQCqUA3LMLgp5J74w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O6m8HWbWfAvU+Jrvr6C3jbTnTAbChZ3Op3mAiIN5pl8osJcd6xh7oC/SWC05hlsiNAgqzMj/bXoMkv6PbE4NCIkNXznh9B8vYJa1wLywRI+yg5AHxhXMhpZppkjqYKC2Yb4FWkq2tRvesfgJx6xHD8LKtSleQcnLLJB+kCWzvGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TKOYZL+L; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716505633;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9qOKzlr6EnmYdUBbeyGsYX+lnRnuf7tx0Aba9aPBtzo=;
	b=TKOYZL+LOEh/5NHOi3PA38DFsQtWX+/h5lT1IAD/6EoXZ3VsEs/k6RsZeFK2MxNJsmKocZ
	giacGBajqRh8NBN8pEBdD6kkys0TKPJs3uXBE10ahLC0jhvOMVSXpnk6m1RvGAZWBdkOmy
	z7uchTXEJaYOc5rqIf9eyydIqpAvxV8=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-b1QWOzH8MyOEXg-l_JzWBA-1; Thu, 23 May 2024 19:07:11 -0400
X-MC-Unique: b1QWOzH8MyOEXg-l_JzWBA-1
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-5b96a7cc02dso55782eaf.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 16:07:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716505631; x=1717110431;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9qOKzlr6EnmYdUBbeyGsYX+lnRnuf7tx0Aba9aPBtzo=;
        b=CnJBTtUz2AaO7DxzzZK2P5cxUZh0ScGyj7MF/WdfHqZCH008lSWT0J5YhDLHjO3Qq3
         4sd2We615oSr9b6lphEmE78V97wS9f07xzmqt5E7jldgnrX+IpK6S2ITJ8a/B3FUyidg
         7YAAm1tA3vkcK37SCxnU/b3/yGCDH4hEiWuQVH+EZ4CNxjYVXWZsyOtqsk/kdauw29sd
         Etzct1Hj6rO/1a/F8YbTpMDgUpIhFWqhO/aRMLhY/LrMRki2IsH+c2gafhcvS1/MsiD+
         kkLS+w49mMZ38h8SsFTgQXK3/U69Bqpxzq2tRJU7OdeURamqmT83AZZw50AMJaQzYxc2
         QESA==
X-Forwarded-Encrypted: i=1; AJvYcCXdnaZ/t06qoCEy06Hn4clAMlW3lRJCTFxgFvRCE+0Y3tE34GTZ9bRdifGWXW/FA3Nh6/qVosPJeD1HRjAr1OGrmW9MGphf7NkXNOcP
X-Gm-Message-State: AOJu0YzUJtXh5tJDDAA52iOawym8q8BG9yxAUi68h2MMyP1Tp1cnZEEj
	mrQ9vGq/Mc3b6EIyU7N8t5JdBru1HDIi3psJzBy/fut6ziS3GoTNo9a3nypBYjyH+pD1aY+HLXF
	ie9Ztgn956+pGlM4PVWrC+yCZI3ZzTF42zOck3qan0Bmtr+l7EJVR1SrFBx3Epg==
X-Received: by 2002:a05:6358:895:b0:191:f9d:3468 with SMTP id e5c5f4694b2df-197e4844d1cmr101528555d.0.1716505630326;
        Thu, 23 May 2024 16:07:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHkP8dUkBKBmrDPjNCP4ODSid8uay1YJsaPr84UgiuUBd25LP9SzmvCs1fRe5ULhTEy/LrP7Q==
X-Received: by 2002:a05:6358:895:b0:191:f9d:3468 with SMTP id e5c5f4694b2df-197e4844d1cmr101525455d.0.1716505629618;
        Thu, 23 May 2024 16:07:09 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ac070f3298sm1303906d6.66.2024.05.23.16.07.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 16:07:09 -0700 (PDT)
Date: Thu, 23 May 2024 19:07:06 -0400
From: Peter Xu <peterx@redhat.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	"Kirill A . Shutemov" <kirill@shutemov.name>,
	Mike Rapoport <rppt@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Michal Hocko <mhocko@suse.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Borislav Petkov <bp@alien8.de>, x86@kernel.org
Subject: Re: [PATCH RFC 2/2] mm/x86/pat: Do proper PAT bit shift for large
 mappings
Message-ID: <Zk_MGmfYsY9dt2Uo@x1n>
References: <20240523223745.395337-1-peterx@redhat.com>
 <20240523223745.395337-3-peterx@redhat.com>
 <f19f63ba-c436-4e39-ab86-78c80b1af667@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f19f63ba-c436-4e39-ab86-78c80b1af667@intel.com>

On Thu, May 23, 2024 at 03:48:22PM -0700, Dave Hansen wrote:
> On 5/23/24 15:37, Peter Xu wrote:
> > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > index 317de2afd371..c4a2356b1a54 100644
> > --- a/mm/huge_memory.c
> > +++ b/mm/huge_memory.c
> > @@ -1135,7 +1135,7 @@ static void insert_pfn_pmd(struct vm_area_struct *vma, unsigned long addr,
> >  		goto out_unlock;
> >  	}
> >  
> > -	entry = pmd_mkhuge(pfn_t_pmd(pfn, prot));
> > +	entry = pmd_mkhuge(pfn_t_pmd(pfn, pgprot_4k_2_large(prot)));
> >  	if (pfn_t_devmap(pfn))
> >  		entry = pmd_mkdevmap(entry);
> >  	if (write) {
> 
> Does this even compile on non-x86 architectures?

Probably not..  I think I can define a pgprot_to_large() globally, pointing
that to pgprot_4k_2_large() on x86 and make the fallback to be noop.  And
if there's a new version I'll guarantee to run over my cross compilers.

Any comments on the idea itself?  Do we have a problem, or maybe I
overlooked something?

Thanks,

-- 
Peter Xu



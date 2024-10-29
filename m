Return-Path: <linux-kernel+bounces-386854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 633D19B48A8
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 12:52:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCE6D1F23DEF
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 11:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25700205AAA;
	Tue, 29 Oct 2024 11:52:41 +0000 (UTC)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA981EE014
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 11:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730202760; cv=none; b=qh0TG5G+GxIuYxs7waYYq82rDAahp3+3Mh39q+hKPbovIqz3bELSH0e1LKqO3XsVrzAjoYX7xf2+Pql5OApBmKgMW18bx/JBKqysDq3VOD8WckgKjmWhudMvwllEuEg5cFlwr4IhSKR2fxEk1Iz2bjkwVh4jL3GDd1XmN4ZPjYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730202760; c=relaxed/simple;
	bh=yspFzMFy6GtPmfuugJ2b9qhTgnoXX1imo7QAbEUtnDU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YZPmf+sU+kobhgocK1vmc7ZkKmVjg5Dax01vFpOgsc0MDL+VUb/gX/EFVG0RomfGvFUfHovvPPyYOL1WzQa933yZLBXxA6wPKl+fwRtlCqpyqpDbthLlPxJJjhQnfhvb4e21kHzxNO6TsyXdcH9q7ahwlbMUlqP4nI197utJBZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a9a26a5d6bfso822862766b.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 04:52:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730202756; x=1730807556;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ai+cIbtgQ7yQvilNgvPeFEHFRDsKY7CEjZmgbBMDi18=;
        b=oTvFgz68TV4aVX8Oe+1HOd3PpLhi/SaJDOAWCJyicIvVXsXSC93rfLgqrZMQlZ7bpL
         JccF6YPyKKURCBwrDbo3+Wd4sIiF92Js9ToDjBiKShP+sD6gcm35n2ZtaQDcfshJ/rSY
         ZnvVA1e7v2EUeLoGMzaqXJyHlr+HzLqtkjtPXsSNjty5UlUVndXAs3AgS/Wi2Olk3YuV
         7cv0uaeUuQ3+lg0vxSpoyw+ds+FVmA1LHaYJqbLn8jLMH9mKxoIx2HeqiE4CsSb1iUmO
         oFFA2LOM5lSiTQ9scspFV8edinLynSDucH1WDnmoJQqRxiDsWkvSnHmgkNM999Pm3Msp
         DHuA==
X-Forwarded-Encrypted: i=1; AJvYcCWkbRKYGmskRKPoGftmD3mQkA2Q7IFoJzZsv6snNpeoRRZCllVUNKosCv0jnYlWNS/QcAxMnZ0sP2aydGg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxgI3vSYa3GoW5Tu36mhqwxGdtVOs5ppaAtnk+ow8l1zHOqHLQ
	hiOrYu1dCbGOjPMJx3exIyTTNTcCGV+eHYvyEseGEaeNCAE0Duqw
X-Google-Smtp-Source: AGHT+IFUCCQnzXhPIYVaEn9VnvmByYgfDRscXsGuypBsXwD6UWBZW4TAVB5CRwK82jxXmRGrIEG2UA==
X-Received: by 2002:a17:907:3f23:b0:a8a:8d81:97ac with SMTP id a640c23a62f3a-a9de5c9f5f9mr1070376566b.4.1730202755736;
        Tue, 29 Oct 2024 04:52:35 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-000.fbsv.net. [2a03:2880:30ff::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b1dec7b90sm466962966b.28.2024.10.29.04.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 04:52:35 -0700 (PDT)
Date: Tue, 29 Oct 2024 04:52:32 -0700
From: Breno Leitao <leitao@debian.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Liam.Howlett@oracle.com
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, kernel-team@meta.com,
	"open list:VMA" <linux-mm@kvack.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: Remove misleading 'unlikely' hint in
 vms_gather_munmap_vmas()
Message-ID: <20241029-discerning-outstanding-badger-6376bd@leitao>
References: <20241004164832.218681-1-leitao@debian.org>
 <71b7cbeb-1301-491c-9637-e6d48938ddaf@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71b7cbeb-1301-491c-9637-e6d48938ddaf@lucifer.local>

On Fri, Oct 04, 2024 at 06:01:07PM +0100, Lorenzo Stoakes wrote:
> On Fri, Oct 04, 2024 at 09:48:31AM -0700, Breno Leitao wrote:
> > Performance analysis using branch annotation on a fleet of 200 hosts
> > running web servers revealed that the 'likely' hint in
> 
> To be pedantic: *unlikely
> 
> > vms_gather_munmap_vmas() was 100% consistently incorrect. In all
> > observed cases, the branch behavior contradicted the hint.
> 
> OK so this is probably because vm_mmap_pgoff() declares the userfaultfd
> list head on the stack then passes it into do_mmap() and threads all the
> way to this code... and yeah, so that would be 100%.
> 
> There are other code paths that aren't 100%, but the system call one is.
> 
> Nice spot!
> 
> >
> > Remove the 'unlikely' qualifier from the condition checking 'vms->uf'.
> > By doing so, we allow the compiler to make optimization decisions based
> > on its own heuristics and profiling data, rather than relying on a
> > static hint that has proven to be inaccurate in real-world scenarios.
> 
> Yeah I'm generally not in favour of 'vibes' based likely()/unlikely(), I
> think it should always be based on profiling.
> 
> It's understandable that there would be this expectation, and it may have
> migrated from other code that already had this check in where perhaps it
> wasn't always referencing a stack object, but yeah this is just wrong.
> 
> >
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> 
> Liam will want a look too when he's back next week.

Liam, are you OK with this one? I suspect that Andrew is waiting for
your review before merging it.

> 
> Looks good to me though!
> 
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> 
> > ---
> >  mm/vma.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/mm/vma.c b/mm/vma.c
> > index 4737afcb064c..9d4fe794dd07 100644
> > --- a/mm/vma.c
> > +++ b/mm/vma.c
> > @@ -1250,7 +1250,7 @@ int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
> >  		else if (is_data_mapping(next->vm_flags))
> >  			vms->data_vm += nrpages;
> >
> > -		if (unlikely(vms->uf)) {
> > +		if (vms->uf) {
> >  			/*
> >  			 * If userfaultfd_unmap_prep returns an error the vmas
> >  			 * will remain split, but userland will get a
> > --
> > 2.43.5
> >


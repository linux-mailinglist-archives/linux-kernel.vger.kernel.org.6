Return-Path: <linux-kernel+bounces-261161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E27993B372
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 17:15:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 787781C212F1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 15:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E59815921D;
	Wed, 24 Jul 2024 15:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CD9yKg1U"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30A0383AB
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 15:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721834140; cv=none; b=i6u8yUmHqTJiZoYie5Csl5FkQPvuBxwUATm7BleitJ4iu2mdG0qs6vJqw+qg/hjgcp6EyOiVszDGu378MgJwBnzi3/C1W+5RODWFttBz6IgxLX0yImwMpgkIrGyREJ+/fx7zUGsP49YacacjMuKkyechwterd5y+bLjTRiRL+Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721834140; c=relaxed/simple;
	bh=36cMmVz/8kJ0ctacbsKjv2bghTG6ARSvXGogjhOvJaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qn+f6+jooCc3s1oKQqS3mlvHTXSqeC+IBK2XDN2T23W065iIJqHN37+CD0282YYMgbzFkR1hRTx28NU/67LqkR77XM/U0z1oMKAB7ofWjVitB98pEe5H/SrJRVc3OmfgmlLXMrv8hkiWlSwOB8Y7H9HMw7MLzOC1jf0Xmjzrynw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CD9yKg1U; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721834137;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RUkRMF0WARuhu/29TKm6k3lHbJ84nYZGVBuX5dht2/s=;
	b=CD9yKg1UbPQRK204geiIVHL3E9laxOStOnyCux/KQPlB8PodPUBZZ9J7nrNp0u5FTvaGjZ
	HnNzGrC1djGtk0KHR+RPddy3FXrM0nsAyPRqVc1dbqVyxIPK2v7kyjm34KI7FNWtFyCFW7
	vWFXlfF00DfWOluJ9LHhBsggYPJhz4c=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-7VdM88mnN_uIYshGN5jEow-1; Wed, 24 Jul 2024 11:15:34 -0400
X-MC-Unique: 7VdM88mnN_uIYshGN5jEow-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-44b30403b90so3910821cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 08:15:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721834134; x=1722438934;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RUkRMF0WARuhu/29TKm6k3lHbJ84nYZGVBuX5dht2/s=;
        b=mTh7RyuvwK30oanBKl9NYvKR9mZ2b0LtHTGafRmq5HyqJ68/QARaeK0UWnLYD7nrKM
         zvgzc8etFOmCxhlWyVsnEinwFRToFEoD8IwV+1m9hCwj/X5vDNPiSuCXN8in+G981iuZ
         RlHJGf91iBEpZKMb8I1ckBzH7v1GuzxGo4HGsDXsGKY0QB47xFDOWrqT8XucAIuKja2h
         BdY4nbOVAHOs+5V0v4/bbhMc5+S58UF+jmqxiHXvpKMWPfVJcu+OIyQeNyh7+UGmQnyO
         xKRWSneXKl2d6fRB/3L66EIhDwXlJ4IO/fYkqHvMVOOLG+upAyj1DJQBkExvVwxc939e
         mweQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5a8JgLIUsbtsmFS796rvK+i1+kGTqPydiEPC+j6NeC8wREpG6aN0CrpUl4BqoMQfF3wGAvvZ69n5y7K/EdF3xs8H4UQmQAS3kW14W
X-Gm-Message-State: AOJu0YwNIdgcHSGJIcsJtLR33NOZ+ODTn/hOLWLkABHj82imoLoYn+OR
	ug+p++AdiywR9YCB2Ndg22F4CXR65W/PJM6igOxtqncSzdgLkm11tlJKFTHw1gk6TPTRbmEAokg
	qfuReqAvZKkeChAU/Qp7KucGa6V8lX3izRFIVEwg/TlJgJPAyGfz3kdZdR7wPJg==
X-Received: by 2002:a05:622a:1b9e:b0:44e:d016:ef9 with SMTP id d75a77b69052e-44fa5387fb4mr104228211cf.9.1721834133795;
        Wed, 24 Jul 2024 08:15:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHg7QRjC9p2RRivLgKhyMUlPKC9on06KG9o9HrmhOfrljMwx/vxFCI8Gd5BGr39JQzDkkckHQ==
X-Received: by 2002:a05:622a:1b9e:b0:44e:d016:ef9 with SMTP id d75a77b69052e-44fa5387fb4mr104227901cf.9.1721834133260;
        Wed, 24 Jul 2024 08:15:33 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44f9cdbe223sm54733741cf.83.2024.07.24.08.15.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 08:15:32 -0700 (PDT)
Date: Wed, 24 Jul 2024 11:15:29 -0400
From: Peter Xu <peterx@redhat.com>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Dave Jiang <dave.jiang@intel.com>, Rik van Riel <riel@surriel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	linuxppc-dev@lists.ozlabs.org, Matthew Wilcox <willy@infradead.org>,
	Rick P Edgecombe <rick.p.edgecombe@intel.com>,
	Oscar Salvador <osalvador@suse.de>,
	Mel Gorman <mgorman@techsingularity.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Borislav Petkov <bp@alien8.de>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Huang Ying <ying.huang@intel.com>,
	"Kirill A . Shutemov" <kirill@shutemov.name>,
	"Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Hugh Dickins <hughd@google.com>, x86@kernel.org,
	Nicholas Piggin <npiggin@gmail.com>,
	Vlastimil Babka <vbabka@suse.cz>, Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH v3 0/8] mm/mprotect: Fix dax puds
Message-ID: <ZqEakeCfr3rVrUz6@x1n>
References: <20240715192142.3241557-1-peterx@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240715192142.3241557-1-peterx@redhat.com>

On Mon, Jul 15, 2024 at 03:21:34PM -0400, Peter Xu wrote:
> [Based on mm-unstable, commit 31334cf98dbd, July 2nd]
> 
> v3:
> - Fix a build issue on i386 PAE config
> - Moved one line from patch 8 to patch 3
> 
> v1: https://lore.kernel.org/r/20240621142504.1940209-1-peterx@redhat.com
> v2: https://lore.kernel.org/r/20240703212918.2417843-1-peterx@redhat.com
> 
> Dax supports pud pages for a while, but mprotect on puds was missing since
> the start.  This series tries to fix that by providing pud handling in
> mprotect().  The goal is to add more types of pud mappings like hugetlb or
> pfnmaps.  This series paves way for it by fixing known pud entries.
> 
> Considering nobody reported this until when I looked at those other types
> of pud mappings, I am thinking maybe it doesn't need to be a fix for stable
> and this may not need to be backported.  I would guess whoever cares about
> mprotect() won't care 1G dax puds yet, vice versa.  I hope fixing that in
> new kernels would be fine, but I'm open to suggestions.
> 
> There're a few small things changed to teach mprotect work on PUDs. E.g. it
> will need to start with dropping NUMA_HUGE_PTE_UPDATES which may stop
> making sense when there can be more than one type of huge pte.  OTOH, we'll
> also need to push the mmu notifiers from pmd to pud layers, which might
> need some attention but so far I think it's safe.  For such details, please
> refer to each patch's commit message.
> 
> The mprotect() pud process should be straightforward, as I kept it as
> simple as possible.  There's no NUMA handled as dax simply doesn't support
> that.  There's also no userfault involvements as file memory (even if work
> with userfault-wp async mode) will need to split a pud, so pud entry
> doesn't need to yet know userfault's existance (but hugetlb entries will;
> that's also for later).
> 
> Tests
> =====
> 
> What I did test:
> 
> - cross-build tests that I normally cover [1]
> 
> - smoke tested on x86_64 the simplest program [2] on dev_dax 1G PUD
>   mprotect() using QEMU's nvdimm emulations [3] and ndctl to create
>   namespaces with proper alignments, which used to throw "bad pud" but now
>   it'll run through all fine.  I checked sigbus happens if with illegal
>   access on protected puds.
> 
> - vmtests.
> 
> What I didn't test:
> 
> - fsdax: I wanted to also give it a shot, but only until then I noticed it
>   doesn't seem to be supported (according to dax_iomap_fault(), which will
>   always fallback on PUD_ORDER).  I did remember it was supported before, I
>   could miss something important there.. please shoot if so.
> 
> - userfault wp-async: I also wanted to test userfault-wp async be able to
>   split huge puds (here it's simply a clear_pud.. though), but it won't
>   work for devdax anyway due to not allowed to do smaller than 1G faults in
>   this case. So skip too.
> 
> - Power, as no hardware on hand.

Ping - any review comments or even tests would be greatly welcomed.

I'm not sure whether this matters for anyone yet so far.  I hope this still
makes sense for DAX even if this is an extremely corner case...

Just to mention the follow up users of this path:

  - huge pfnmap 1G may use this, when VM_PFNMAP can be mapped with 1G too,
    then we should hit similar "bad pud" here.

  - hugetlb rework will use this, when we want this path to process 1G
    hugetlb pages too.

The 1st user is not a must in my initial plan, as VFIO + VM use case
doesn't use mprotect(), so we can keep (1) broken together with DAX 1G
here.  But for the long term we should still fix this, IMHO.

Thanks,

-- 
Peter Xu



Return-Path: <linux-kernel+bounces-408025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A099C7960
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 17:56:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BE40B360B9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 16:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A959617C9E8;
	Wed, 13 Nov 2024 16:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XGzFLZZL"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA1A14AD20
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 16:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731515979; cv=none; b=SoVsX43PaizzItyf0lP2NZI/uDH1xznGeDbjzwN2Tu3ENJUi+v/Nwm4ApMywy8PB4Ja1eyTXRr1p887c+OWk74cynxqgO2MqTZ5+u4ePgpJlLEo0xQViWoWe9KAVzxrlQAVCnB7qBiHbf0LUBitcCxlhJfdD3tffvvGRCPHUElk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731515979; c=relaxed/simple;
	bh=LrMuzXcuzWlSzjwKgvFvIvn8Rs59/WHb8Hu8CksLxwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j3JOL9WGJM4hSw8N/3KR7hZHvgJIEmd+DoEBtPP+vcymFL0iQ2zsHS7ru1SBlxxR8WOwiCx3aiBHGAa1gbIzlGRisbkxAY6nb5E/6ez+OwfdsGy/VdsFheMSSaTjbZqRrY70Iky6810P8lzj+cQ+71w0xy9ED4ghyK17wzY0G7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XGzFLZZL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731515976;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=32X9w96j/6luUoMGo5UFRFt7UJIdq29Ups7kfYJnJ7Q=;
	b=XGzFLZZLWJ1DRbxMpSGOipCYZ+jgjYJhqe8cNpPYfeQHT6PHMFnMw2NzL/+w5W9p+FLXS0
	UfxU9w8nPtfZlaaRlz4hx9QPzGaIocP28PvHfsoODUq/bzCcZxVFzWpuEpZa2wcu7dX06+
	YHBI+2RX+AFwOJspV7etJAJ3IP7D80I=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-0N4RnbwzNaGCiWQqtmNGtA-1; Wed, 13 Nov 2024 11:39:35 -0500
X-MC-Unique: 0N4RnbwzNaGCiWQqtmNGtA-1
X-Mimecast-MFC-AGG-ID: 0N4RnbwzNaGCiWQqtmNGtA
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6d35062e1fcso110341176d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 08:39:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731515974; x=1732120774;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=32X9w96j/6luUoMGo5UFRFt7UJIdq29Ups7kfYJnJ7Q=;
        b=jxTxJYg3X/m9dloqeGWrO8t/MjmPUhvgrRLRVR29Z6XD29xaWPymbc/NDI142Qk/6c
         0D68Aqmk0qxQeq2lEJXoJZ/SfmMxC70blBGbompEnSvaBhs6o9YCyIgqKjfv6enlRBX1
         iNvn57foCkYQp3Ycakh5A8mGkHDnlY7tUnFB49HkToinwX7wjMaKv60OKu2ANdBvc6Hp
         jiSV9C3KGb4ZgSOWp0chEq3sgCzpPiaLVxNHT5o8njqY5d27RiPt8Rwzi4FBUBm5+YxW
         BcQ5GMPYR11yEJG8HmFC/3vtgIeLPtCkc+lX2qJ4UThIzpcm+/AbARsDiO5FUlgM4cE1
         cD4w==
X-Gm-Message-State: AOJu0YxcjgybAolmR5FnT80C0a5UcrSZ0bgtiaunLAY91diDs75ltXEt
	xTfgWyRxNxwQwARQxvugN52sKZ0d46MATiHnxn158Xw04yMYDFBg06nEDb46lWrEK5FPkT4qWgn
	qFMwcuuTy1KR6S8/hFIjXEirLHtOKSNvI7SofmyIUT2BeijwZQTIyoG2tLq479w==
X-Received: by 2002:a05:6214:3987:b0:6ce:34d5:8882 with SMTP id 6a1803df08f44-6d39e19e2a1mr283778356d6.39.1731515974473;
        Wed, 13 Nov 2024 08:39:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGDKo6Iqu9xjWDgAQhCuGtni17bdPjeCzIpnbYgct2pKE70TzMw5IDOMnCe9a1WfloQWLLrHw==
X-Received: by 2002:a05:6214:3987:b0:6ce:34d5:8882 with SMTP id 6a1803df08f44-6d39e19e2a1mr283777986d6.39.1731515974173;
        Wed, 13 Nov 2024 08:39:34 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com. [99.254.114.190])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d3961dfad2sm86443686d6.1.2024.11.13.08.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 08:39:33 -0800 (PST)
Date: Wed, 13 Nov 2024 11:39:30 -0500
From: Peter Xu <peterx@redhat.com>
To: Jann Horn <jannh@google.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	"Kirill A . Shutemov" <kirill@shutemov.name>,
	Nicholas Piggin <npiggin@gmail.com>,
	David Hildenbrand <david@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	James Houghton <jthoughton@google.com>,
	Huang Ying <ying.huang@intel.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Rick P Edgecombe <rick.p.edgecombe@intel.com>,
	Hugh Dickins <hughd@google.com>, Borislav Petkov <bp@alien8.de>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Rik van Riel <riel@surriel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Mel Gorman <mgorman@techsingularity.net>, x86@kernel.org,
	Ingo Molnar <mingo@redhat.com>, linuxppc-dev@lists.ozlabs.org,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Oscar Salvador <osalvador@suse.de>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v5 0/7] mm/mprotect: Fix dax puds
Message-ID: <ZzTWQqr-zFQz0HHY@x1n>
References: <20240812181225.1360970-1-peterx@redhat.com>
 <CAG48ez0NNph0Zp2aZ+c1T+U940CvwxcQ+jyEhp3KYZLSWPSrNw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez0NNph0Zp2aZ+c1T+U940CvwxcQ+jyEhp3KYZLSWPSrNw@mail.gmail.com>

On Mon, Nov 11, 2024 at 10:20:59PM +0100, Jann Horn wrote:
> On Mon, Aug 12, 2024 at 8:12 PM Peter Xu <peterx@redhat.com> wrote:
> > Dax supports pud pages for a while, but mprotect on puds was missing since
> > the start.  This series tries to fix that by providing pud handling in
> > mprotect().  The goal is to add more types of pud mappings like hugetlb or
> > pfnmaps.  This series paves way for it by fixing known pud entries.
> 
> Do people actually use hardware where they can use PUD THP mappings
> for DAX? I thought that was just some esoteric feature that isn't
> actually usable on almost any system.
> Was I wrong about that?

I did run it with a qemu emulated nvdimm device.  Though in reality I've no
idea on how many people are using it..

> 
> I think another example that probably doesn't play entirely nice with
> PUD THP mappings is mremap()'s move_page_tables(). If
> dax_get_unmapped_area() allows creating a VMA at an unaligned start
> address (which I think it does?), move_page_tables() can probably end
> up copying from an aligned address mapped with a huge PUD entry to an
> unaligned address that needs to be mapped at the PTE level, and I
> think that will probably cause it to call into get_old_pmd() while a
> huge PUD entry is still present, which will probably get us a
> pud_bad() error or such?

I think you're probably right, that we have other places that may not work
well with pud mappings.

I also wonder whether dax_get_unmapped_area() needs to properly handle
MAP_FIXED, even for PMD mappings.

It looks like it always fallbacks to the default mm_get_unmapped_area()
with FIXED, which have no idea on dax->alignment so it'll always allow
it.. The issue is I'm not sure dax pmd can be split at all, while I think
split-able is needed when mremap from a pmd-aligned address to a
!pmd-aligned address.

Thanks,

-- 
Peter Xu



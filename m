Return-Path: <linux-kernel+bounces-278598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50A4F94B253
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 23:47:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 699DD1C20FC3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 21:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5718214A09F;
	Wed,  7 Aug 2024 21:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LjcGnRqa"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C5F77F1B
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 21:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723067248; cv=none; b=rtqbNxxh013nBoA9aIoFoLtWBieyzt+IRHaVhBlRorYtmDenADUZGL9lVJ/jp37i97jM61oVU/sqWofuJpb1ps5IrrDesI8gcQXgQCaHVJ3muoChd4ql4LiahoYnszSU5LvHHv5FqNXuAScEccujF3VzoC1IkiowhgPtdqmDgk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723067248; c=relaxed/simple;
	bh=QQI7nvs1pKmJOC+Cwy1kRsAJQEceRHmQjeZQF0hOFJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iIUFmVoyYuDSDwl3cEqd1vGkRLdFhABVPkqesDJLqscqc4fEk0KLAADJk9WKrkW8W80Q7ZQjeb8RaMsssiKdkL8IECmfhVCC2V3INrHlYiPEGVuqlnaOzKcHF10LxIpIhpgrYGtw7uiL6E0vnOgidTpta69ojh9mo/xqIYKGwuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LjcGnRqa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723067244;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aCiVKpNiLqOePBRGHLX/OUQr3iDeTroqagJLNDFWCWE=;
	b=LjcGnRqawBM+s6MlFo9AkT6CxOtM8VZx1Hhw5kR7VfRWbaBThLEau1xzONjVxj1Pg/H0lG
	4mUDZ9bA06MI6fyza7lyBB4zZs2a3LRgwDm2LN/h7iVmlEib9i0qdqPIFL9JKLAlB7WStU
	kIj3vzbJphPRgomQvrE4tNvCMMSPfCM=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-263-6iuxZSKVMUax1Tc9Airrqw-1; Wed, 07 Aug 2024 17:47:23 -0400
X-MC-Unique: 6iuxZSKVMUax1Tc9Airrqw-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-45009e27b83so630991cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 14:47:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723067243; x=1723672043;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aCiVKpNiLqOePBRGHLX/OUQr3iDeTroqagJLNDFWCWE=;
        b=QGNl4ba/9+vQalN79Omdaif1CylfwTuKZ+ycdHCjwaywMsp67x6aVhTyJKGSVcObeZ
         bxHqfB9o75najadYgJOdwklf6wSPraTuo5FgHqUZD8Z71Rrx63douZCXKaguK3TugUdv
         C86OhODdVkhENNMUPg0Pjpr7AZZqzDclgErS71KBJG+/0ENGGGmPnTLrST1gazTfVw08
         hLa0XOvwhRVP98YR5/xgVlpKm5AxqAUHy+dgcrnmfF5T1EfxkfbH4RvYza7SKg6lBBVu
         tH9bAu9bxicPfY4+mlIaace9DTmxBYNln28LExHJvq86/3gbzqeSmW8vSD/6STD4OO0a
         jAqw==
X-Gm-Message-State: AOJu0Yx/Gzm/ku97RMseieocdkdOUEGoQvwgmfVwEb8GEGt60apQqH8S
	he1PnDt2UzOsX6nIhUi3HS3xkfhev+aiKB2wCah8lF+QmbipIh66gJqCQgmg4ttZvgPA2YS3Muw
	Gg7GQtJubLzwnKtR0rtvThruDwHxp4d5Gh/qIA7iebXSq2H9LT8O/iQxfG3YLVg==
X-Received: by 2002:ac8:7dc6:0:b0:44e:cff7:3741 with SMTP id d75a77b69052e-451d42e8e13mr45551cf.7.1723067242639;
        Wed, 07 Aug 2024 14:47:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9bw5zA2mwygXKj1TGJFqzB/idtoA3I89YV20jwaY21AqDhG6xaZ18FG34XF9AfNZNBTawgg==
X-Received: by 2002:ac8:7dc6:0:b0:44e:cff7:3741 with SMTP id d75a77b69052e-451d42e8e13mr45301cf.7.1723067242218;
        Wed, 07 Aug 2024 14:47:22 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-451c87344desm7823491cf.50.2024.08.07.14.47.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 14:47:16 -0700 (PDT)
Date: Wed, 7 Aug 2024 17:47:13 -0400
From: Peter Xu <peterx@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	"Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Oscar Salvador <osalvador@suse.de>,
	Dan Williams <dan.j.williams@intel.com>,
	James Houghton <jthoughton@google.com>,
	Matthew Wilcox <willy@infradead.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	Rik van Riel <riel@surriel.com>, Dave Jiang <dave.jiang@intel.com>,
	x86@kernel.org, Ingo Molnar <mingo@redhat.com>,
	Rick P Edgecombe <rick.p.edgecombe@intel.com>,
	"Kirill A . Shutemov" <kirill@shutemov.name>,
	linuxppc-dev@lists.ozlabs.org,
	Mel Gorman <mgorman@techsingularity.net>,
	Hugh Dickins <hughd@google.com>, Borislav Petkov <bp@alien8.de>,
	David Hildenbrand <david@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vlastimil Babka <vbabka@suse.cz>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Huang Ying <ying.huang@intel.com>
Subject: Re: [PATCH v4 0/7] mm/mprotect: Fix dax puds
Message-ID: <ZrPrYdmyUDRdz1QN@x1n>
References: <20240807194812.819412-1-peterx@redhat.com>
 <20240807142316.bbad141a106093b6f36249e2@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240807142316.bbad141a106093b6f36249e2@linux-foundation.org>

On Wed, Aug 07, 2024 at 02:23:16PM -0700, Andrew Morton wrote:
> On Wed,  7 Aug 2024 15:48:04 -0400 Peter Xu <peterx@redhat.com> wrote:
> 
> > 
> > Tests
> > =====
> > 
> > What I did test:
> > 
> > - cross-build tests that I normally cover [1]
> > 
> > - smoke tested on x86_64 the simplest program [2] on dev_dax 1G PUD
> >   mprotect() using QEMU's nvdimm emulations [3] and ndctl to create
> >   namespaces with proper alignments, which used to throw "bad pud" but now
> >   it'll run through all fine.  I checked sigbus happens if with illegal
> >   access on protected puds.
> > 
> > - vmtests.
> > 
> > What I didn't test:
> > 
> > - fsdax: I wanted to also give it a shot, but only until then I noticed it
> >   doesn't seem to be supported (according to dax_iomap_fault(), which will
> >   always fallback on PUD_ORDER).  I did remember it was supported before, I
> >   could miss something important there.. please shoot if so.
> 
> OK.  Who are you addressing this question to?

Anyone who is familiar with fsdax + 1g.  Maybe Matthew would be the most
suitable, but I didn't track further on fsdax.

> 
> > - userfault wp-async: I also wanted to test userfault-wp async be able to
> >   split huge puds (here it's simply a clear_pud.. though), but it won't
> >   work for devdax anyway due to not allowed to do smaller than 1G faults in
> >   this case. So skip too.
> 
> Sounds OK.  So that's an additional project if anyone cares enough?

Right.

> 
> > - Power, as no hardware on hand.
> 
> Hopefully the powerpc people can help with that.  What tests do you ask
> that they run?

The test program [2] in cover letter should work as a very basic test; one
needs to setup the dax device to use 1g mapping first, though:

[2] https://github.com/xzpeter/clibs/blob/master/misc/dax.c

At least per my experience not much fancy things we can do there, e.g., I
think at least dev_dax has a limitation on vma split that it must be 1g
aligned when use 1g mappings, so even split can't happen (as iirc I used to
try some random mprotect on smaller ranges)..

Thanks,

-- 
Peter Xu



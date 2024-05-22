Return-Path: <linux-kernel+bounces-186035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 282458CBF09
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 12:10:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E2A41F2272D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 10:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E3B781AC7;
	Wed, 22 May 2024 10:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kaovamyy"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF5381AA7
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 10:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716372648; cv=none; b=msjUhEjXP1acjdKVz4FF4UKvlL9xgONwq1BVn5sE+9d9J0nTqgeYw/44rl8966HalC0G8YCVQABbOedeFPhxFkfPb0Kgeenx5VNLbvgjC4Cf6GEnvTpNk8mWK9SPWU3JaAhDIY/k8/m5EQkMOtTrWbKT91K5//3xM39ODnP+DwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716372648; c=relaxed/simple;
	bh=rI9+//CQe3BIN31GpKwyrp9VCzL6IHM4yXjse3nqq3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fXZo8CROHlbsOepwaoq7FpAYiRJNOK+VVZttttOPsRuGvnhx+i9QLiSygrJGNv+pUxR7aw/YeMm4pvMJnfR8m7gYOATmYsGeu890whiQu8TY1n4LsV1F4bpuJkycsT5J60ZEQWArJW7hqtdgIMwgGPCW4H/DPQmgZBKh9o3K1Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kaovamyy; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5750a8737e5so10748a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 03:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716372644; x=1716977444; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qdT6rhi0h+EmeLy7ClXWAbx1ie9OvMrFw3EuHRJ+BIU=;
        b=kaovamyyvb/DnzMdtogyFIjxT9EbDmlBfjGLMxaUeoiOUFaERaihy630RjCi1BImjm
         sKBn1jkEDg89J/+U6zvdsvTUMb46jn0tVw2uSb5jJ9BZhs3tx2WGF/0Yapp1q9agrPtJ
         gZtjkF0a+kMmJ1DIzzVvz9U3CjMugSZnjYA4nq+5bqp3+UVjlgfmd+gQ/7f2m9nIzMzE
         cvUCZKPk0J1LkC2DLKmSSNt/vKkf0Xr0H45K91lgtWPctVMfuvhhRDdg36vjOD/g7kWI
         3K9Y64MksQRdYq/DvKebb4RKEq5ZSoDczGTyMyOF77YZMq3KMa+kUPrmB6feajPpdYBW
         UaUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716372644; x=1716977444;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qdT6rhi0h+EmeLy7ClXWAbx1ie9OvMrFw3EuHRJ+BIU=;
        b=QuIudGU4hXCSqxQx3cSJ0prmpwXen7xzVTLLRghjF5F3RXFqFZKf4nkPTZdcvhCZpW
         liDaqs422IxID/VydnwY3bxWn0JnyxGeEzuEadjUdk/N1cMHDeYrTsHalGRvy02izloa
         irumyO7gGn3gGqN/nMeY/3SQmGOlopxBCtEgj/3paY3fpHKcgkTfRLoiD+tLSaNRlZTn
         o/YyerRj8FQiCmcMHviEpM6vXB7hWMoo0z3xxufiThQV1KfiMYJQzs4G/O2DGcXERMyJ
         p19SXBOxDrvtwvUlNrtKLSgehir7qs++lFBNjvtBB5s2M6Q7zcRJyormIK6sfY4fz2CH
         TKlw==
X-Forwarded-Encrypted: i=1; AJvYcCUGGlxs4eNiM0B3lmI7s9YLbhjPH2SbA39cL/+xde6wd/C4Dbrd8lyQYonKEqBfLNtKGfMk12RxzWNmKLrHdN/dRaLfby/LQQU9bRig
X-Gm-Message-State: AOJu0YwwQCVSDkba3noFPOA4xDT/GfOe8JD3bOIlmgqPXZ5li1Rnw0md
	AdlFGumRmWLQbf9wF1XXscOMYcX/Hg90NZnSqL4KzwPdl5j0BboCjXRuLdfmfA==
X-Google-Smtp-Source: AGHT+IFftKuo9IctI2aRgHUnvA1H6YsT85pIezEQpHtWjZ+eQcqGGf821zmRki5Rn64NsPFVcuTitw==
X-Received: by 2002:aa7:c0da:0:b0:573:438c:7789 with SMTP id 4fb4d7f45d1cf-57831f8f90emr91785a12.1.1716372644337;
        Wed, 22 May 2024 03:10:44 -0700 (PDT)
Received: from google.com (49.240.189.35.bc.googleusercontent.com. [35.189.240.49])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502baacfb9sm33786732f8f.68.2024.05.22.03.10.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 03:10:43 -0700 (PDT)
Date: Wed, 22 May 2024 10:10:40 +0000
From: Brendan Jackman <jackmanb@google.com>
To: Lance Yang <ioworker0@gmail.com>
Cc: David Hildenbrand <david@redhat.com>,
	Oscar Salvador <osalvador@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Pavel Tatashin <pasha.tatashin@soleen.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mm,memory_hotplug: {READ,WRITE}_ONCE unsynchronized
 zone data
Message-ID: <Zk3EoLOvRhSO9ScG@google.com>
References: <20240521-mm-hotplug-sync-v1-0-6d53706c1ba8@google.com>
 <20240521-mm-hotplug-sync-v1-2-6d53706c1ba8@google.com>
 <CABzRoyZXq3u4DYxO39Fcezo56HAbkNh6xLuK9jnuiNK5gVmV1w@mail.gmail.com>
 <Zk2vDeQ3feZ3hsf0@google.com>
 <CAK1f24=fNFPyGCh+sxsq-Gg6BkD5qH=z+Ur2UD8+4CRZYoZc6g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK1f24=fNFPyGCh+sxsq-Gg6BkD5qH=z+Ur2UD8+4CRZYoZc6g@mail.gmail.com>

On Wed, May 22, 2024 at 05:20:08PM +0800, Lance Yang wrote:
> On Wed, May 22, 2024 at 4:38 PM Brendan Jackman <jackmanb@google.com> wrote:
> >
> > Hi Lance, thanks for taking a look.
> >
> > On Wed, May 22, 2024 at 12:25:30PM +0800, Lance Yang wrote:
> > > Hi Brendan,
> > >
> > > On Tue, May 21, 2024 at 8:57 PM Brendan Jackman <jackmanb@google.com> wrote:
> > > > @@ -1077,7 +1081,7 @@ void adjust_present_page_count(struct page *page, struct memory_group *group,
> > > >          */
> > > >         if (early_section(__pfn_to_section(page_to_pfn(page))))
> > > >                 zone->present_early_pages += nr_pages;
> > > > -       zone->present_pages += nr_pages;
> > > > +       WRITE_ONCE(zone->present_pages, zone->present_pages + nr_pages);
> > >
> > > I'm not sure that using the WRITE_ONCE() wrapper would prevent load tearing
> > > on 'zone->present_pages', but it's probably just me overthinking it :)
> >
> > Hmm.. this isn't for load-tearing, it's for store-tearing. I have a
> > feeling I might be missing your pont here though, can you elaborate?
> 
> Sorry, my explanation wasn't clear :(
> 
> I'm a bit confused about whether 'WRITE_ONCE(zone->present_pages,
> zone->present_pages + nr_pages);'
> is equivalent to the following:
> 
> 1 a = zone->present_pages + nr_pages;
> 2 WRITE_ONCE(zone->present_pages, a);
> 
> If so, is there any possibility of load tearing on
> 'zone->present_pages' in line 1?

Ah gotcha, thanks for clarifying. Loads are protected by
mem_hotplug_lock here, so it's fine for them to get split up (because
the value can't change between loads). This is what I was referring to
in the bit of the commit message about not needing READ_ONCE.


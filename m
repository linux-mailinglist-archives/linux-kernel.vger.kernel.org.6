Return-Path: <linux-kernel+bounces-304096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B2D961A2E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 00:57:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C878D285225
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 22:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 167331D45E0;
	Tue, 27 Aug 2024 22:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="agCNzYOY"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92E81442E8
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 22:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724799451; cv=none; b=A7DGC9VrcsYYr3rR0x1iyjauZdQx5sAB1plpyvGIqQJbDqrzRIlg26ZG74FeEdIAcIN71sS5CJwDYnJLuLk3hJOrBKChD/B6e7iZIZdPW8bj3wjeVRKnp98rM5uD+AZ4F4sxpJUmllxTb8ucyntokHmbROeMQklehlAWwEqTwko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724799451; c=relaxed/simple;
	bh=+5KSSJmpv92zQCwlRGk1Ci3RpieYCmpb/rqeFlbM700=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pc94cmgc89uRIoO58ZXjJDZ6P7X8E08sl423Wwq4CXfNUtVkfMhvpwPtmd8kzsx0x/NodXE6DgaqWtJSxMZgTyMfgnu/1NL2AFYH78f2vI3FIGDYDPqXh9t9UF8aHNER4CQnH+/5rIzFRbMhWsiHlweSo9wkqT3F30hwY0HlyzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=agCNzYOY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724799448;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AK6C3A50tnsGBsRCbow729A4DBuHr+gMMuMlTEw8uyc=;
	b=agCNzYOYWvxGwNXXvuwggo4YdvckjkcYhCJdO/aZX/WrOoI2Pjs+ajQaMwqB3dkFFbnRud
	HWVoJv1G7PyQKe5733qH6wrnPFOfF2PiqXGctO4Xe3zjntg4TPrgAKmIq2t+bs7wn1Zv+a
	ISSy8A6onLSkB797PizT2d3EbQ3Sppo=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-384-6mXWMUKJNJaE-hjzkr5fqw-1; Tue, 27 Aug 2024 18:57:27 -0400
X-MC-Unique: 6mXWMUKJNJaE-hjzkr5fqw-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7a1d40f49f5so767120885a.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 15:57:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724799446; x=1725404246;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AK6C3A50tnsGBsRCbow729A4DBuHr+gMMuMlTEw8uyc=;
        b=fJSS/3SLKLf5zY5yLQqNHN/Gu6aiEkneay8lBMgFFLIK666oC2mKtr6+QNn1pSuU+1
         /ZTxf8hw4JbAroZmF6GvMw4iIxqOm++sQA9sWEZ+jUCCWvWxyR94Q5iYzMNp9tAgt+jo
         hk5xt35dQ1HQTiwpwaVlHE1WIytnIFNi00VLG4zmRg2poi3wrmKtuAx13n17vxPqBizQ
         eiDixrV/K2UrTXsI6IiK+Cfj7nungBhjI09++p99H0O0D+5lr+ivky5RaeF/QTNDQ/RP
         5etpH1jSvIWMG1nRyQaj2Ry6OflP3WEi58ZSBrzLiWpqe11UD6kNaSOQNSZoKOj84OVZ
         KFbQ==
X-Gm-Message-State: AOJu0Yz8NuXW8V8KXbPeUQCrtfvCsNN0b0YbHJ28trO/iCpJnhgwqx2N
	CxQ0RPNFH89baNfT6ceiOokAuQJt3aqeYmYO94qVDqSK46YKfOPODU/4QG2cFKbRGG/jasXrXMO
	bZnwr7J9KlzZ1Eaps6OwNt6ZBcLJ5g9q/c4tXQyZFqd1gOr4wSsLlhB8btANvJ6MSIy5wCze3
X-Received: by 2002:a05:620a:294a:b0:79f:d0f:2b19 with SMTP id af79cd13be357-7a6897ac51amr1874150485a.68.1724799446099;
        Tue, 27 Aug 2024 15:57:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFI4+OTLE/+AELbN/FBXKKldemh+MzRZdeNQ6HQxBpbtU51+fjlWi4bBqNnU0zHwgoZ09GhcQ==
X-Received: by 2002:a05:620a:294a:b0:79f:d0f:2b19 with SMTP id af79cd13be357-7a6897ac51amr1874149285a.68.1724799445728;
        Tue, 27 Aug 2024 15:57:25 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a67f3dc360sm590479185a.88.2024.08.27.15.57.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 15:57:25 -0700 (PDT)
Date: Tue, 27 Aug 2024 18:57:21 -0400
From: Peter Xu <peterx@redhat.com>
To: Jiaqi Yan <jiaqiyan@google.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Gavin Shan <gshan@redhat.com>,
	Catalin Marinas <catalin.marinas@arm.com>, x86@kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Alistair Popple <apopple@nvidia.com>, kvm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Sean Christopherson <seanjc@google.com>,
	Oscar Salvador <osalvador@suse.de>,
	Jason Gunthorpe <jgg@nvidia.com>, Borislav Petkov <bp@alien8.de>,
	Zi Yan <ziy@nvidia.com>, Axel Rasmussen <axelrasmussen@google.com>,
	David Hildenbrand <david@redhat.com>,
	Yan Zhao <yan.y.zhao@intel.com>, Will Deacon <will@kernel.org>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH v2 00/19] mm: Support huge pfnmaps
Message-ID: <Zs5Z0Y8kiAEe3tSE@x1n>
References: <20240826204353.2228736-1-peterx@redhat.com>
 <CACw3F50Zi7CQsSOcCutRUy1h5p=7UBw7ZRGm4WayvsnuuEnKow@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACw3F50Zi7CQsSOcCutRUy1h5p=7UBw7ZRGm4WayvsnuuEnKow@mail.gmail.com>

On Tue, Aug 27, 2024 at 03:36:07PM -0700, Jiaqi Yan wrote:
> Hi Peter,

Hi, Jiaqi,

> I am curious if there is any work needed for unmap_mapping_range? If a
> driver hugely remap_pfn_range()ed at 1G granularity, can the driver
> unmap at PAGE_SIZE granularity? For example, when handling a PFN is

Yes it can, but it'll invoke the split_huge_pud() which default routes to
removal of the whole pud right now (currently only covers either DAX
mappings or huge pfnmaps; it won't for anonymous if it comes, for example).

In that case it'll rely on the driver providing proper fault() /
huge_fault() to refault things back with smaller sizes later when accessed
again.

> poisoned in the 1G mapping, it would be great if the mapping can be
> splitted to 2M mappings + 4k mappings, so only the single poisoned PFN
> is lost. (Pretty much like the past proposal* to use HGM** to improve
> hugetlb's memory failure handling).

Note that we're only talking about MMIO mappings here, in which case the
PFN doesn't even have a struct page, so the whole poison idea shouldn't
apply, afaiu.

Thanks,

-- 
Peter Xu



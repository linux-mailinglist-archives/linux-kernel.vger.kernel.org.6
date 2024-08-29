Return-Path: <linux-kernel+bounces-307442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EA1E964DA0
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 20:26:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E06DAB21A81
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 18:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 236F41B86D0;
	Thu, 29 Aug 2024 18:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EsUFxf1D"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4931B1D41
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 18:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724955990; cv=none; b=AtDQQoWIyAdIiZ5ZjUiH6/0qgyLTmYVMSAhMZw4iMGCBNSJgXTNGAt8JxnVMQOA+rwTh1aNKqUZAQ8uL0RG4wml3pkrqFYF11aDmj+aVw24LYn1FUcMEaAZgMUxez7SGVlZNgSgkZwVWS9TEG2ybzcBYjvK6lJbiS+OsdujAJHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724955990; c=relaxed/simple;
	bh=fjkHY08fUPxq/rg8AhHY5r6YbGUpJpaohkKFoXudyxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DNhtv9rORWEe3rUZT6toWIeLXnBheD1V3nRytSq8pg/4QrGsmsBuTwSp7yriIlHwi+gdgJJV4b78tIQlQQz9PwEOgsyYQqGVjCgceKE0zcup3S50QEuuB2CzslCdprnxsCNFBwutT3eQst+ejDzAlgHQEpvf3AyT8pV8BdJ4tng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EsUFxf1D; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724955987;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3WuSlRBbAE14ViqgSTitGeyCxk0WS9L/CSL99pAIvUI=;
	b=EsUFxf1DZaMP1dx+/cdHw2zVWLHtxJZVKSzSwbTVIDhxqUo/pEk5byQUUmuXOzkPn52RyF
	BxNJ4uYGKJC/FV6+DYOAV4OEE8OiBw35UwfgNQIO4POk6mtD5dsk665RjtmpKvT/kWBv9u
	7rsdBmqAlAXMqpx/ppnDqFk+m8hWxYY=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-156-0Cri52jxO0aENh_L2Mtl1A-1; Thu, 29 Aug 2024 14:26:26 -0400
X-MC-Unique: 0Cri52jxO0aENh_L2Mtl1A-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4500d2fe009so20582131cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 11:26:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724955986; x=1725560786;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3WuSlRBbAE14ViqgSTitGeyCxk0WS9L/CSL99pAIvUI=;
        b=ZUGuQ9SQeDhBoaqlWGs6CP2Y51wBRjGeX+busFAvzaC5t94q1mVVmKa4TbeZsqk9oe
         L4/ojaUbfIxoOs9f1lBEteKkQ/MCqmdDUfQbNmNxQwcrU+brWk8jRZ4sbwcon6fJhGIT
         REpqHIu9DxJ4yM1sKVHcp3lLjKrHzR5qDLLzy4IU5dj2bOQtNHdgprVZIKycbjAl5UQJ
         eVu3yVVVwigHTvrZY7FWk3Ai69THT7ytDFMNImQtPzRzepgStRHw3j0b17nh09Gt9Uz0
         E+3aN8M2p7vmh7fU4nUH4pjzUiKgE4b19nGRzgccmaqlOpsqM/YKtKwoz8i2em8W619m
         zQFw==
X-Gm-Message-State: AOJu0Ywls4P8xbeR9DOJI5ahSM3NunjqNCLZhR3RgGwyUMG8hWLiWuns
	sUHdkS+d5BvM6FR+B2ThLsde5OvQd5NuFJE5wTm3znzL+bFAe+xlD/77oe7F1ij/5m1UN9ml7Pf
	mEX6FATASqPqnOwEwRRN05UPLk6sHDpA6A2ndznsiJZcZ1zx7oGva5P6EyqCNBQ==
X-Received: by 2002:a05:622a:4819:b0:456:45cc:2b5a with SMTP id d75a77b69052e-45680261427mr70106521cf.25.1724955985961;
        Thu, 29 Aug 2024 11:26:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEzclADxCb1u5q8U+Sk7zwoAJ25wF2K4UbrNY0LglvkHgW5dZaI/1Ur1kfLF9ykMtA/fsqWzw==
X-Received: by 2002:a05:622a:4819:b0:456:45cc:2b5a with SMTP id d75a77b69052e-45680261427mr70106031cf.25.1724955985521;
        Thu, 29 Aug 2024 11:26:25 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45682c82a52sm7101381cf.16.2024.08.29.11.26.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 11:26:24 -0700 (PDT)
Date: Thu, 29 Aug 2024 14:26:22 -0400
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
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
	Yan Zhao <yan.y.zhao@intel.com>, Will Deacon <will@kernel.org>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH v2 07/19] mm/fork: Accept huge pfnmap entries
Message-ID: <ZtC9ThIs7aSK7gdK@x1n>
References: <20240826204353.2228736-1-peterx@redhat.com>
 <20240826204353.2228736-8-peterx@redhat.com>
 <78d77162-11df-4437-b70b-fa04f868a494@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <78d77162-11df-4437-b70b-fa04f868a494@redhat.com>

On Thu, Aug 29, 2024 at 05:10:42PM +0200, David Hildenbrand wrote:
> On 26.08.24 22:43, Peter Xu wrote:
> > Teach the fork code to properly copy pfnmaps for pmd/pud levels.  Pud is
> > much easier, the write bit needs to be persisted though for writable and
> > shared pud mappings like PFNMAP ones, otherwise a follow up write in either
> > parent or child process will trigger a write fault.
> > 
> > Do the same for pmd level.
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >   mm/huge_memory.c | 29 ++++++++++++++++++++++++++---
> >   1 file changed, 26 insertions(+), 3 deletions(-)
> > 
> > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > index e2c314f631f3..15418ffdd377 100644
> > --- a/mm/huge_memory.c
> > +++ b/mm/huge_memory.c
> > @@ -1559,6 +1559,24 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
> >   	pgtable_t pgtable = NULL;
> >   	int ret = -ENOMEM;
> > +	pmd = pmdp_get_lockless(src_pmd);
> > +	if (unlikely(pmd_special(pmd))) {
> 
> I assume I have to clean up your mess here as well?

Can you leave meaningful and explicit comment?  I'll try to address.

-- 
Peter Xu



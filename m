Return-Path: <linux-kernel+bounces-268300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 571999422F3
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 00:30:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2CD81F21D80
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 22:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ED2A157466;
	Tue, 30 Jul 2024 22:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XpfEXB3S"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10441AA3E8
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 22:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722378616; cv=none; b=McKmlrl6Cy7+LeQgNNzdDpixYWfqR8eJYkU94W498Gsar5dZZwINmL3bhYi5IwtWZ5mgUmDS7exv2Du27oOc1WfF9lJ7QmFBufxtIpomzpYqn3QpDp9Ey8oiCKod13QHzk8ZTm86JI9CqQW8cC/oS+tKIyPMzekJb2rSK8w+nM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722378616; c=relaxed/simple;
	bh=lukyko6WhLd86bIprzKWnfPyMYA0WNaoHkIQZi8WLTc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kfypYwazzRDqMd+M1cHIL/3v4lFwKMGPAiBKwyyFq7jK9EFFK6aTWcI/Pf/euSwP/R388dCVf+mKcflppFWD03V0I8KAiri2VNe7aak3H0X5J06JPZgERSPdXjqFR/7Fp+sFcSKdOBbqM6CnmDSaszu+24rV0d1uOXEvvj8uykM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XpfEXB3S; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722378613;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y5kNYpg9eUUfaVFQlHs3iXOjdZpeVmxNiRg//4lRozI=;
	b=XpfEXB3SzQ8Y4UEQYGQ2olq0xkLmBVtRXIvglB8OpAgJ0GWdftYpKze0Z6bhcJH4W7oSKT
	95oFUwA6S+tLegCevjmSoCPJFvRHnqztryBy4vmz5ZTS5K3JmzwPn3jBv9zJw4XFv7cNh7
	4b/4mTmnVjP4DzhQm6udxW4DOCebXWY=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-313-x1VUQTxWPT6O7nMry64tRA-1; Tue, 30 Jul 2024 18:30:10 -0400
X-MC-Unique: x1VUQTxWPT6O7nMry64tRA-1
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-5d5b4ffa0c8so1027348eaf.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 15:30:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722378609; x=1722983409;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y5kNYpg9eUUfaVFQlHs3iXOjdZpeVmxNiRg//4lRozI=;
        b=jhD3M9nETrMbKb7ujGHWdWtzMpe1vjL4Qog/BI2uj40uJXXJX95CeAbn6xdE1l2z3F
         22bgHUO7nAga9az9SMDbGZuCmeHjsNZFlBnaCONliHI07rRr9CpjLdCbMrn0T3ZFZSt6
         sT5VgWQtgxV4r9U1P/nCDNjicBgYuaw7VY5UKTST4JHuKLcIbvQB4zJlG3OOC70bEwIB
         uwFJuWQ/WH3slRNZLZ50maoCOtP80lNlYEmMzBLSuK9w8J3jMLQuycExY9jf1vTY2LbQ
         B5tZiVYSOf8kULtiryw6/a/SC7aVlsZ9UnsS4Y8UJrZctrJU6rQKhTXP9r4+BO/Y6sAf
         x1fQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6M8xfhFUZfgDfOT+rYHvLxzhFlg6xHDcdA4/6AIJOe4ce7QKbCiplKvtu5E2XoDaHReInH7hUVvuox/IaGBpZduLK6ENlfbhKdo4n
X-Gm-Message-State: AOJu0YwyH1lGJYqHF59d682rCAPjLVzwHzFV0QER9JT2iFLJ40RRSge3
	cltzenNSlxrgSkI0AqCfX3y+0gjs3dLAE4MBaISs9f5ymT9v8X2y9ZdIWoPLE8XS03ultGe2Py0
	QJQo2I+zh+zqsHLtcjXXJStarkcWGqd9kt2IUfDjHLDHFh79/xqi2bmhChjtmag==
X-Received: by 2002:a4a:a542:0:b0:5c7:b587:40a7 with SMTP id 006d021491bc7-5d5b15373c5mr10749399eaf.1.1722378609511;
        Tue, 30 Jul 2024 15:30:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJByCxdD1t4UZwfqqPdgCZsn2gbVDdIJGfCxxyPNKDP8T1DbcoLV+Wd5i1D2Eds9HHRRl71Q==
X-Received: by 2002:a4a:a542:0:b0:5c7:b587:40a7 with SMTP id 006d021491bc7-5d5b15373c5mr10749390eaf.1.1722378609089;
        Tue, 30 Jul 2024 15:30:09 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb5bcffd18sm45807036d6.15.2024.07.30.15.30.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 15:30:08 -0700 (PDT)
Date: Tue, 30 Jul 2024 18:30:06 -0400
From: Peter Xu <peterx@redhat.com>
To: James Houghton <jthoughton@google.com>
Cc: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, stable@vger.kernel.org,
	Oscar Salvador <osalvador@suse.de>,
	Muchun Song <muchun.song@linux.dev>,
	Baolin Wang <baolin.wang@linux.alibaba.com>
Subject: Re: [PATCH v2] mm/hugetlb: fix hugetlb vs. core-mm PT locking
Message-ID: <ZqlpbuJ7bXE_r9dO@x1n>
References: <20240730200341.1642904-1-david@redhat.com>
 <CADrL8HXRCNFzmg67p=j0_0Y_NAFo5rUDmvnr40F5HGAsQMvbnw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADrL8HXRCNFzmg67p=j0_0Y_NAFo5rUDmvnr40F5HGAsQMvbnw@mail.gmail.com>

On Tue, Jul 30, 2024 at 01:43:35PM -0700, James Houghton wrote:
> On Tue, Jul 30, 2024 at 1:03 PM David Hildenbrand <david@redhat.com> wrote:
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index b100df8cb5857..1b1f40ff00b7d 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -2926,6 +2926,12 @@ static inline spinlock_t *pte_lockptr(struct mm_struct *mm, pmd_t *pmd)
> >         return ptlock_ptr(page_ptdesc(pmd_page(*pmd)));
> >  }
> >
> > +static inline spinlock_t *ptep_lockptr(struct mm_struct *mm, pte_t *pte)
> > +{
> > +       BUILD_BUG_ON(IS_ENABLED(CONFIG_HIGHPTE));
> > +       return ptlock_ptr(virt_to_ptdesc(pte));
> 
> Hi David,
> 
> Small question: ptep_lockptr() does not handle the case where the size
> of the PTE table is larger than PAGE_SIZE, but pmd_lockptr() does.
> IIUC, for pte_lockptr() and ptep_lockptr() to return the same result
> in this case, ptep_lockptr() should be doing the masking that
> pmd_lockptr() is doing. Are you sure that you don't need to be doing
> it? (Or maybe I am misunderstanding something.)

I was just curious and looked at pte_alloc_one(), not too much archs
implemented it besides the default (which calls pte_alloc_one_noprof(), and
should be order=0 there).  I didn't see any arch that actually allocated
with non-zero orders.

The motorola/m68k one is slightly involved, but still.. nothing I spot yet.

Thanks,

-- 
Peter Xu



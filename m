Return-Path: <linux-kernel+bounces-542775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D8334A4CD80
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 22:29:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC19C1884A99
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 21:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C16F022F3AB;
	Mon,  3 Mar 2025 21:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BOsuytW7"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD821EFFA4
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 21:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741037379; cv=none; b=DFqfU+lfLRYZ7pvUM/eCkfAiPOx6Sr1p6yPYvtPlAJuzZ5GtARHZwGMzPb5dgy68TKCmc8BoQIc+dLzBSUjwkGEgfInjWO9p4OWEjIL35n0/gpZPOJWYTU+y4LGe2Ka6+VLLxmBPg2AZzrTurKkaTJNjRcU+ahCSembB1Y2yxI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741037379; c=relaxed/simple;
	bh=uGCOquydQMu7XE8XjxA6YgTbUc8YWG3dslP5N8e1NUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VoISrywqa60Lq0ZXkeM3NM1sF3EfvQZOXBc4YkUUa/J98Gh/HcPAxHiNe/KxJekSZJRnL69wxsC3LLGHOswkXn4X5mZ93PDAc6lkCxm8angnG11mB8SvaY6h98hyFgfFuzA+ixtIcXtgvgAAGCD+k/aM/k7D31iAt3fCz8D9h1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BOsuytW7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741037376;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4XHKmdvqQLV0kinajoxf6W7WfTOeuSd3If/M5JQf010=;
	b=BOsuytW72PYstEr5G6OlpBdsaU5z9DHGqNHEI/KaMbZsC1qQlQRdmJzXxWtn/vRkYdJD4P
	ILug+orfom1Vxpi6KFVPE/b/v+ti27xt5YuA5Eo1KubvkWOvpm1QrvgVQLcDSBeISl+NBy
	Eh4inooW7ElUhaEalsZcxz/KXc0hYuk=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-mgFQP80uOO2MNEys_AaAQg-1; Mon, 03 Mar 2025 16:29:35 -0500
X-MC-Unique: mgFQP80uOO2MNEys_AaAQg-1
X-Mimecast-MFC-AGG-ID: mgFQP80uOO2MNEys_AaAQg_1741037374
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-471fa9d2854so99876961cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 13:29:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741037374; x=1741642174;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4XHKmdvqQLV0kinajoxf6W7WfTOeuSd3If/M5JQf010=;
        b=tsxtzYHsCGMMib6TVzqhuOlf/o0L8Nwe5W5SOKLOLWQgcQ+V6KQ7clMWdzfkiOLw8O
         TVs/a11nZ9SaTC7krVsmScbQ9OQIRfELbjERyxyAJcILbUEJUohlNk77WDBIHjVL7n01
         F8jy9bBSodxFuuZ0vdjdfb13yAv6B0FevsKjCluLkmmSLgwgp5mJuGk61CeT9oM2O25j
         x0eVJy0cZoj7IpBBA2T3qYvMrRAjMiesNeTW7RNROUR2sRi8S7PWvqwHJvhS8HLJEoDN
         js1wDJvXR+u5q+fNhO07Us8AIOTdN4i05nD53JdAxOoAw52K7wOnlrb/ITrEL+iMuwJi
         A0+g==
X-Forwarded-Encrypted: i=1; AJvYcCVH3Xm5cIgpl94Q9VH8wM7KIiiTuEJzHzMZlOJtA74+aUbrvyKWS2TQN3xn8TxAlQYaUxZd50qXnIETjrk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfxO7mx0uoRIUJ5NZr2EYUd0GbnNj2yrtvq1AD+rUJ0I3vCbEH
	4XicWUbxON6rgTSSdfDSMGIRQaaD1d0xNaPgGGpQZDIMfA6AeSsf4v4w3BNzRTa4LYvO4Smuo2T
	qUlhX/bxeaBoMMWpPn1FqmTKuXXnki81IpFhBo9FzfTOY9zdOKy/EYzUB6saG7w==
X-Gm-Gg: ASbGncslnXT7HCuXw808YPOQIA7/7oCBfMkqqs0ngRSzB8rgjJxKYscg4cSfSzL9oNM
	9TJ7tN/Ke8+E5pydX7YG6SrDmKBraRw/80IEXWG5ynovQLDS+2AvYz5513VHNm3/AxQUBgppUE4
	lP3pFYFCAOYBnr5whvR3AxVRJO4Ga0324KZH/2TpoUQ69gRMDegsFH79SEeHRr74Q69f+Lg57ma
	cBc8Hv3hVjrj2DrKjf6Dl99wi+c9djb4RrObkYEN/gL/H8EyXtzbVRD5adV8RM8k0tbw7oHaGcL
	pN518qk=
X-Received: by 2002:a05:622a:1195:b0:471:f1c6:54a6 with SMTP id d75a77b69052e-474bbf8989cmr203598881cf.0.1741037374583;
        Mon, 03 Mar 2025 13:29:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGyEWewqQv6y2LaIpicJJ1HPCHenu4T0jWbilaFvqyXO2dsNaQSyH7LiAJDW9m7DNjxLw6PZg==
X-Received: by 2002:a05:622a:1195:b0:471:f1c6:54a6 with SMTP id d75a77b69052e-474bbf8989cmr203598501cf.0.1741037374182;
        Mon, 03 Mar 2025 13:29:34 -0800 (PST)
Received: from x1.local ([85.131.185.92])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-474fd3a8bdasm603971cf.74.2025.03.03.13.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 13:29:33 -0800 (PST)
Date: Mon, 3 Mar 2025 16:29:29 -0500
From: Peter Xu <peterx@redhat.com>
To: Nikita Kalyazin <kalyazin@amazon.com>
Cc: akpm@linux-foundation.org, pbonzini@redhat.com, shuah@kernel.org,
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	lorenzo.stoakes@oracle.com, david@redhat.com, ryan.roberts@arm.com,
	quic_eberman@quicinc.com, jthoughton@google.com, graf@amazon.de,
	jgowans@amazon.com, roypat@amazon.co.uk, derekmn@amazon.com,
	nsaenz@amazon.es, xmarcalx@amazon.com
Subject: Re: [RFC PATCH 0/5] KVM: guest_memfd: support for uffd missing
Message-ID: <Z8YfOVYvbwlZST0J@x1.local>
References: <20250303133011.44095-1-kalyazin@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250303133011.44095-1-kalyazin@amazon.com>

On Mon, Mar 03, 2025 at 01:30:06PM +0000, Nikita Kalyazin wrote:
> This series is built on top of the v3 write syscall support [1].
> 
> With James's KVM userfault [2], it is possible to handle stage-2 faults
> in guest_memfd in userspace.  However, KVM itself also triggers faults
> in guest_memfd in some cases, for example: PV interfaces like kvmclock,
> PV EOI and page table walking code when fetching the MMIO instruction on
> x86.  It was agreed in the guest_memfd upstream call on 23 Jan 2025 [3]
> that KVM would be accessing those pages via userspace page tables.  In
> order for such faults to be handled in userspace, guest_memfd needs to
> support userfaultfd.
> 
> This series proposes a limited support for userfaultfd in guest_memfd:
>  - userfaultfd support is conditional to `CONFIG_KVM_GMEM_SHARED_MEM`
>    (as is fault support in general)
>  - Only `page missing` event is currently supported
>  - Userspace is supposed to respond to the event with the `write`
>    syscall followed by `UFFDIO_CONTINUE` ioctl to unblock the faulting
>    process.   Note that we can't use `UFFDIO_COPY` here because
>    userfaulfd code does not know how to prepare guest_memfd pages, eg
>    remove them from direct map [4].
> 
> Not included in this series:
>  - Proper interface for userfaultfd to recognise guest_memfd mappings
>  - Proper handling of truncation cases after locking the page
> 
> Request for comments:
>  - Is it a sensible workflow for guest_memfd to resolve a userfault
>    `page missing` event with `write` syscall + `UFFDIO_CONTINUE`?  One
>    of the alternatives is teaching `UFFDIO_COPY` how to deal with
>    guest_memfd pages.

Probably not..  I don't see what protects a thread fault concurrently
during write() happening, seeing partial data.  Since you check the page
cache it'll let it pass, but the partial page will be faulted in there.

I think we may need to either go with full MISSING or full MINOR traps.

One thing to mention is we probably need MINOR sooner or later to support
gmem huge pages.  The thing is for huge folios in gmem we can't rely on
missing in page cache, as we always need to allocate in hugetlb sizes.

>  - What is a way forward to make userfaultfd code aware of guest_memfd?
>    I saw that Patrick hit a somewhat similar problem in [5] when trying
>    to use direct map manipulation functions in KVM and was pointed by
>    David at Elliot's guestmem library [6] that might include a shim for that.
>    Would the library be the right place to expose required interfaces like
>    `vma_is_gmem`?

Not sure what's the best to do, but IIUC the current way this series uses
may not work as long as one tries to reference a kvm symbol from core mm..

One trick I used so far is leveraging vm_ops and provide hook function to
report specialties when it's gmem.  In general, I did not yet dare to
overload vm_area_struct, but I'm thinking maybe vm_ops is more possible to
be accepted.  E.g. something like this:

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 5e742738240c..b068bb79fdbc 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -653,8 +653,26 @@ struct vm_operations_struct {
         */
        struct page *(*find_special_page)(struct vm_area_struct *vma,
                                          unsigned long addr);
+       /*
+        * When set, return the allowed orders bitmask in faults of mmap()
+        * ranges (e.g. for follow up huge_fault() processing).  Drivers
+        * can use this to bypass THP setups for specific types of VMAs.
+        */
+       unsigned long (*get_supported_orders)(struct vm_area_struct *vma);
 };
 
+static inline bool vma_has_supported_orders(struct vm_area_struct *vma)
+{
+       return vma->vm_ops && vma->vm_ops->get_supported_orders;
+}
+
+static inline unsigned long vma_get_supported_orders(struct vm_area_struct *vma)
+{
+       if (!vma_has_supported_orders(vma))
+               return 0;
+       return vma->vm_ops->get_supported_orders(vma);
+}
+

In my case I used that to allow gmem report huge page supports on faults.

Said that, above only existed in my own tree so far, so I also don't know
whether something like that could be accepted (even if it'll work for you).

Thanks,

-- 
Peter Xu



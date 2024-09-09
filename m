Return-Path: <linux-kernel+bounces-321641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73606971D6E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 17:03:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 297F11F23F19
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 15:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61B1D1B947;
	Mon,  9 Sep 2024 15:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W2sTnyTy"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61ABA17C8B
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 15:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725894198; cv=none; b=raGnP1I/ZI6V20gkjGZ40VEY0lcv4pEW4e42slQ+fLUYfYwhfhWhWgFYPT0Ax5DD9YIh5whPXrglnP2Cz2BvvH49ORsTMK76EYOH+ht+nQx9k+D9p2U/oeo6jHsX4uyQXIAFxgyV8NoD/ZXPwlC20xMUhoeQ8I/yCcJuOvu4Aqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725894198; c=relaxed/simple;
	bh=L0M1mffjiRIPOCuH2OrIjQfgVOyprWyp9psV4eYNvAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lDqgRg5Vh9fzd/3NQhf/4XQqVZ5Ug8CpOiRsNmKCaxIpG5CDHFaOyqB8gDNAZVqKF6eYLc3T1NfnHuY0A4Zu1kfGCqX6pTLyoqAqKj1yIb5XI0a37dQPNtAVGtmdz5xE2Rve7kSSWoIVGr4X7g1bUgk6tjlJHvLOn4s+JYnHCvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W2sTnyTy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725894196;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6l+xHNqXTthDlFZ3K9cVgVJ/sPPZ9HvpzFqB6gZQUko=;
	b=W2sTnyTy2pAfWFx9mHhIKVHryWY2jcJdVWgE8SUOSALoabAxHFkYHiZaGnyIHp0vVWjMBM
	7jif6mwRqwzZw00vTy+YOADfMGXJ+nQSgQzJLaW0PutWjYGK0cNCamKTuCbCi2nnpf7gMW
	cnfMf+urSXac5CCEsaJAfSrBpBQLq+0=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-ls9EpZ-YMui2cDjE3O252A-1; Mon, 09 Sep 2024 11:03:14 -0400
X-MC-Unique: ls9EpZ-YMui2cDjE3O252A-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6c3540067b1so54548046d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 08:03:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725894193; x=1726498993;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6l+xHNqXTthDlFZ3K9cVgVJ/sPPZ9HvpzFqB6gZQUko=;
        b=YWqfBHRSvVkbMvuLtgqWFLRkTlhM5UmwdGaCyehLj3DNsiH3t9FIN7RBmjrUVf3XAV
         bl6eCQdypGLDUIVclHTArux4atsBezQYoCLzTNowPugV3ApM+OpMGHdSRIPfEZpXwyV4
         H0qk6jMA7i7OWyt0fKeJH8Qe/5hHmSXBWC4kPDgA4Bi3ChYRuC6UjNhc0kmP1eUYaVt4
         J9acXJVYnN0T2fxJPJVl3IuqcS+d321ynCb2YfLZLM2k3xLUeISxfCpiPU8YxM/+Uka4
         ZkwgdxpszZzF4/m1zyBp5icMT6qZpuLg9jA4ttQrRLxeqY7Emb049gsPgdYBNemp4R7o
         OdOg==
X-Gm-Message-State: AOJu0YxxMfsIURVzY7FKUXXd7bhC6/8mR+6kxjKBkXGp/QoHiGSqygG6
	/X4Rtm7bgwgqHoqmjQ+M0s0QxGP6JnuP/gY3EJoLwNwjq67oYaEnbw9JtxdYJ9yYhZrXFusTX1N
	GEdZfn1rjXOe0R9fjUJjk7Pfk0NywykVVYliRX4EYOuUTQzzwm226pxF6Ww57DLgdFF9nvnvh
X-Received: by 2002:a05:6214:5b84:b0:6c3:5789:62f8 with SMTP id 6a1803df08f44-6c5323fe2b4mr100989496d6.19.1725894193165;
        Mon, 09 Sep 2024 08:03:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHXyNgnw3o/IQrxRWaaUJgRseDSr7DTlug9i0O8HD+tnUNFFXmzQMuc9otVGIFfDiIY6ds48Q==
X-Received: by 2002:a05:6214:5b84:b0:6c3:5789:62f8 with SMTP id 6a1803df08f44-6c5323fe2b4mr100988886d6.19.1725894192696;
        Mon, 09 Sep 2024 08:03:12 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c53432dfb8sm21272326d6.24.2024.09.09.08.03.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 08:03:12 -0700 (PDT)
Date: Mon, 9 Sep 2024 11:03:09 -0400
From: Peter Xu <peterx@redhat.com>
To: Ankit Agrawal <ankita@nvidia.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	Gavin Shan <gshan@redhat.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	"x86@kernel.org" <x86@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Alistair Popple <apopple@nvidia.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	Sean Christopherson <seanjc@google.com>,
	Oscar Salvador <osalvador@suse.de>,
	Jason Gunthorpe <jgg@nvidia.com>, Borislav Petkov <bp@alien8.de>,
	Zi Yan <ziy@nvidia.com>, Axel Rasmussen <axelrasmussen@google.com>,
	David Hildenbrand <david@redhat.com>,
	Yan Zhao <yan.y.zhao@intel.com>, Will Deacon <will@kernel.org>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH v2 00/19] mm: Support huge pfnmaps
Message-ID: <Zt8OLSI3e3K8tFpU@x1n>
References: <20240826204353.2228736-1-peterx@redhat.com>
 <SA1PR12MB7199DE6F9F63EEAD93F66249B0992@SA1PR12MB7199.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SA1PR12MB7199DE6F9F63EEAD93F66249B0992@SA1PR12MB7199.namprd12.prod.outlook.com>

On Mon, Sep 09, 2024 at 04:03:55AM +0000, Ankit Agrawal wrote:
> > More architectures / More page sizes
> > ------------------------------------
> > 
> > Currently only x86_64 (2M+1G) and arm64 (2M) are supported.  There seems to
> > have plan to support arm64 1G later on top of this series [2].
> > 
> > Any arch will need to first support THP / THP_1G, then provide a special
> > bit in pmds/puds to support huge pfnmaps.
> 
> Just to confirm, would this also not support 512M for 64K pages on aarch64
> with special PMD? Or am I missing something?

I don't think it's properly tested yet, but logically it should be
supported indeed, as here what matters is "pmd/pud", not the explicit size
that it uses.

> 
> > remap_pfn_range() support
> > -------------------------
> > 
> > Currently, remap_pfn_range() still only maps PTEs.  With the new option,
> > remap_pfn_range() can logically start to inject either PMDs or PUDs when
> > the alignment requirements match on the VAs.
> >
> > When the support is there, it should be able to silently benefit all
> > drivers that is using remap_pfn_range() in its mmap() handler on better TLB
> > hit rate and overall faster MMIO accesses similar to processor on hugepages.
> 
> Does Peter or other folks know of an ongoing effort/patches to extend
> remap_pfn_range() to use this?

Not away of any from my side.

Thanks,

-- 
Peter Xu



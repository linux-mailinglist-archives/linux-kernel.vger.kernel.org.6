Return-Path: <linux-kernel+bounces-281302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1373894D543
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 19:15:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F0801C20ACF
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 17:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1C6F49649;
	Fri,  9 Aug 2024 17:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Uum4qQ7g"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4EFDA41
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 17:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723223730; cv=none; b=ToYokQ17t9Wjguv7lMlk0Cv3vjf7kY2MZeiKJ/+gddf1hpsiC7L8GQXi+2QX3dX5TIrkyjMnmcPcikc3U9C6tr+M4XbBdVuqvepQbAuaDeAwdavGHkLq1o2Gq5tcgkx1YelNoGkg677q0blTDLYn/KzJaFqHGUxYxRV61O1Tfx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723223730; c=relaxed/simple;
	bh=BwpEztdg48zmsEANvHGayRgeJ5ktdIC0d0lY+MyHVg0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JE5c2AYcmaQTlvOuKgOWkYTKWhzYgp0MIoKFgFJWLEPXf1Di812mXZX6Z/HB6Tb8odr8aV+DgpSJYa2pYFnK6ShuRl/Vww+RF37cE25a2l+YGeM5jrI2Sxwo7VX/VcepvPcGf7JiQjLPm9Cv80dOzbKeVc3cLL2rH+O6RbzY7bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Uum4qQ7g; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723223727;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k1RM34U80cBuoBEaB3XScsq2LvIzrQPbOvXLfubi1Yw=;
	b=Uum4qQ7g4woKGEJ/mzhRq3R8CRHLomDq16UHTaY5U3O7Y4N7izmhvbDdwh1l9AccXuVs8n
	10MnzJuwG6DCJWeXSf2NcUxeZUUAG4JdzN22NmqphdsR7IMOcbkSzBAjHudmsZGacO8N0F
	WOgu8Ab72ddWG9ZfA+V2L8d0+v7mM1A=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-79-ObIZUXgtNpyO1WazQk1row-1; Fri, 09 Aug 2024 13:15:25 -0400
X-MC-Unique: ObIZUXgtNpyO1WazQk1row-1
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-3dc29db029cso600862b6e.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 10:15:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723223725; x=1723828525;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k1RM34U80cBuoBEaB3XScsq2LvIzrQPbOvXLfubi1Yw=;
        b=a7wO2ESz5UbYJ9EtWmIdQ7WwsqSp6o/t8PdZF1FEWvm+rX1NjIaQp2eeo6Iu4L+NpL
         7AS9c4tBf0uMjPKiORxFs8YAg5Qgn+WYlGUpUiTD8uzt9pkoltz9VBfXTICWyW+SZiUo
         PQr13szB9DJF8/HwTiPOzkplWE02atqvt3XHmwKoM0k9Vinj8TSWFId78H5CGFPmZ0n4
         BxN90kzKcMOHq2BY+Lkj8tPQvx0y/hZ4xhFXC/hq8nNQKOGdw6fQsYoKkZ4AoEQgarop
         HE4UUE0EGLy0a+sOWK/WpI5JH3Dt0UggGGo41B1Be9QNlyGt6yL41KuosIc24DjOqHtL
         /ZpQ==
X-Forwarded-Encrypted: i=1; AJvYcCU49pOeWDlNzO2xzjCyXFXfFzzJhb0IOzOocF6pwpDY0U/u3kuzPJ4/P5QTnNqcrf+PxLu/23rkARuIL+tC0DwyfR/YvTnomt4gmEEl
X-Gm-Message-State: AOJu0YxmyLaZbVmGSRMC1Pfk2JKD/+TgFlIzUhRO3cJN9zjKt6x/1Fxh
	kjtN6ZRoMcMuPuRTIXIzPuxecyWG0oRLRhpD7Ao8fUK4OIgW/zxAo6Rvy5RuPXLPP8y6iyKD49/
	vA4p4LMa/N2vOFRPLr0na5RRllowyGeSi5oA7d0g+5GEeXFegkGS0ueqWNh1GMQ==
X-Received: by 2002:a05:6830:4113:b0:70b:2a0f:d2d8 with SMTP id 46e09a7af769-70b7c47ca90mr1694643a34.4.1723223724965;
        Fri, 09 Aug 2024 10:15:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHDZ8AG8hkigQJRUf5X9BYk1irDNCGK0SoMgTlS1KNGbXDLrarAMaXAoHbkQ/XXZWQbMY2eQg==
X-Received: by 2002:a05:6830:4113:b0:70b:2a0f:d2d8 with SMTP id 46e09a7af769-70b7c47ca90mr1694631a34.4.1723223724644;
        Fri, 09 Aug 2024 10:15:24 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a3785e67easm276234285a.52.2024.08.09.10.15.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 10:15:24 -0700 (PDT)
Date: Fri, 9 Aug 2024 13:15:21 -0400
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Sean Christopherson <seanjc@google.com>,
	Oscar Salvador <osalvador@suse.de>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	linux-arm-kernel@lists.infradead.org, x86@kernel.org,
	Will Deacon <will@kernel.org>, Gavin Shan <gshan@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>, Zi Yan <ziy@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Ingo Molnar <mingo@redhat.com>,
	Alistair Popple <apopple@nvidia.com>,
	Borislav Petkov <bp@alien8.de>,
	Thomas Gleixner <tglx@linutronix.de>, kvm@vger.kernel.org,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Yan Zhao <yan.y.zhao@intel.com>
Subject: Re: [PATCH 07/19] mm/fork: Accept huge pfnmap entries
Message-ID: <ZrZOqbS3bcj52JZP@x1n>
References: <20240809160909.1023470-1-peterx@redhat.com>
 <20240809160909.1023470-8-peterx@redhat.com>
 <d7fcec73-16f6-4d54-b334-6450a29e0a1d@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d7fcec73-16f6-4d54-b334-6450a29e0a1d@redhat.com>

On Fri, Aug 09, 2024 at 06:32:44PM +0200, David Hildenbrand wrote:
> On 09.08.24 18:08, Peter Xu wrote:
> > Teach the fork code to properly copy pfnmaps for pmd/pud levels.  Pud is
> > much easier, the write bit needs to be persisted though for writable and
> > shared pud mappings like PFNMAP ones, otherwise a follow up write in either
> > parent or child process will trigger a write fault.
> > 
> > Do the same for pmd level.
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >   mm/huge_memory.c | 27 ++++++++++++++++++++++++---
> >   1 file changed, 24 insertions(+), 3 deletions(-)
> > 
> > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > index 6568586b21ab..015c9468eed5 100644
> > --- a/mm/huge_memory.c
> > +++ b/mm/huge_memory.c
> > @@ -1375,6 +1375,22 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
> >   	pgtable_t pgtable = NULL;
> >   	int ret = -ENOMEM;
> > +	pmd = pmdp_get_lockless(src_pmd);
> > +	if (unlikely(pmd_special(pmd))) {
> > +		dst_ptl = pmd_lock(dst_mm, dst_pmd);
> > +		src_ptl = pmd_lockptr(src_mm, src_pmd);
> > +		spin_lock_nested(src_ptl, SINGLE_DEPTH_NESTING);
> > +		/*
> > +		 * No need to recheck the pmd, it can't change with write
> > +		 * mmap lock held here.
> > +		 */
> > +		if (is_cow_mapping(src_vma->vm_flags) && pmd_write(pmd)) {
> > +			pmdp_set_wrprotect(src_mm, addr, src_pmd);
> > +			pmd = pmd_wrprotect(pmd);
> > +		}
> > +		goto set_pmd;
> > +	}
> > +
> 
> I strongly assume we should be using using vm_normal_page_pmd() instead of
> pmd_page() further below. pmd_special() should be mostly limited to GUP-fast
> and vm_normal_page_pmd().

One thing to mention that it has this:

	if (!vma_is_anonymous(dst_vma))
		return 0;

So it's only about anonymous below that.  In that case I feel like the
pmd_page() is benign, and actually good.

Though what you're saying here made me notice my above check doesn't seem
to be necessary, I mean, "(is_cow_mapping(src_vma->vm_flags) &&
pmd_write(pmd))" can't be true when special bit is set, aka, pfnmaps.. and
if it's writable for CoW it means it's already an anon.

I think I can probably drop that line there, perhaps with a
VM_WARN_ON_ONCE() making sure it won't happen.

> 
> Again, we should be doing this similar to how we handle PTEs.
> 
> I'm a bit confused about the "unlikely(!pmd_trans_huge(pmd)" check, below:
> what else should we have here if it's not a migration entry but a present
> entry?

I had a feeling that it was just a safety belt since the 1st day of thp
when Andrea worked that out, so that it'll work with e.g. file truncation
races.

But with current code it looks like it's only anonymous indeed, so looks
not possible at least from that pov.

Thanks,

> 
> Likely this function needs a bit of rework.
> 
> -- 
> Cheers,
> 
> David / dhildenb
> 

-- 
Peter Xu



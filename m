Return-Path: <linux-kernel+bounces-188190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E86B28CDF04
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 02:54:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 179911C20DDD
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 00:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD85263CB;
	Fri, 24 May 2024 00:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M5GIG0IB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A93881F
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 00:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716512040; cv=none; b=VheIXM7J1QmaOWAt4PP5rOn1HpIUcFBYbX/1FnA9h+SLUQS8r3t+B3wkyH/7AAndfJJzVv5JPflnD56lSDfa86lsCb/CIakSgVk8ay6nf54YHSwq5q6DAjuk0cO+wBuZ8hirPbCHCN6kV/EZHMQqgmFT9TxySmqonXeoV32RVe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716512040; c=relaxed/simple;
	bh=WnYni0shLvKwaxSzjMVR9xdLiquBjJKTYrs7ynos6pg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YxLKYsXgifnV62oB54++VuNux408fSZigQO4jX3f6Ic+PWYuDwjwe/tccNJjioee4akwvrJhBUNOZtgqL/WfocsYJ3EnBsxxPszClw3WMGRyAE1iyLoGwcpzvThS9FKse+RlHddD/8bGN9b+1bf+X/pw0tSSKHe8cnUXPu8rQgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M5GIG0IB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716512037;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4bXsqkd30FAf+6qBmC705wVMq3rXSqyst/TAidoHN74=;
	b=M5GIG0IB82Fw1XEZL43/6wwLxsDDzlEqJ9sWiQfBpDlmLkR76LohmGFr3e+TgooUG2Lv6l
	dnjbjAHxs3BrQahRB+DdEiJYjriPSZTlmwW/AmLhICpxlgO8WSudVW8HRCMjXy2lxe8Gw4
	ES0tf92MdgLGeIHkJRhGdn87bYVHO6w=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-330-DQwixp-DNvqdz-6v2iTeBA-1; Thu, 23 May 2024 20:53:55 -0400
X-MC-Unique: DQwixp-DNvqdz-6v2iTeBA-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6ab89f69cd8so1797266d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 17:53:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716512035; x=1717116835;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4bXsqkd30FAf+6qBmC705wVMq3rXSqyst/TAidoHN74=;
        b=BmLzjrX1uIZknbMLLuO4XtCkF3NjWSs72HIc+tQT6aU9Y+MeuQbbqtojjQsP+59oo8
         /yNOxugG/MUrrLESTMIG0KXiM1QAcGrB4LsymLPFq9Xb7og2J5wdXw03h8zVEMNk42Xs
         z9A1zT51kE9LrLQvhkSoLCAVJuPMn86hC8NNiwxkVN1EVv5hGCYBH54ghVYxxrf3EaZc
         37HpASGXHix45W58LRso/FEncay1VeZPui0OWGYar0ppQUuukWq6PXskstB1iRSGhqmH
         UDiPnp0as1TuT/fiP3hyQifqi2+RuLpDATaD4MqW2PNvDQIvrfOp89SLgBN/hxhZQQpH
         EzZg==
X-Forwarded-Encrypted: i=1; AJvYcCWi+DVY0p5dYhYGkN2Oz1Lbigw5rE0r43SYCXyzp5vI/mzd4P3DqQMyWygx5KKvPd/89xmyefMoGRvd9ZzhlZCNPD1LU7Rs/5SAHk1/
X-Gm-Message-State: AOJu0YzJZTvlI8ejLjF+xXoZGFuoQv3tFUiXvlgGORNm0SA1iM7Pos8s
	Us34VtOeKEC6O26bIHt+xmSQzNaqy0NSTWgfXRuDz+NapToYdazTJbF4g9jODpoyzD9U9SolnYF
	YhqQqMlTL+0SWtJALHHZqv8ZJKO3wKtIOhERTORtgRBvcrqFelT1tXWzZDObchw==
X-Received: by 2002:a05:6214:c2e:b0:6a3:3ea4:7156 with SMTP id 6a1803df08f44-6abbbcc044fmr7203926d6.1.1716512034877;
        Thu, 23 May 2024 17:53:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGAR7s5N9/YYw7UFaVUWvL696U4+4Y6JhWUXYWMH4Lg/8zPuLfIrzHk6ojc+TjPP6pa9eibvQ==
X-Received: by 2002:a05:6214:c2e:b0:6a3:3ea4:7156 with SMTP id 6a1803df08f44-6abbbcc044fmr7203636d6.1.1716512034081;
        Thu, 23 May 2024 17:53:54 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ac162ef94fsm2001796d6.82.2024.05.23.17.53.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 17:53:53 -0700 (PDT)
Date: Thu, 23 May 2024 20:53:51 -0400
From: Peter Xu <peterx@redhat.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	"Kirill A . Shutemov" <kirill@shutemov.name>,
	Mike Rapoport <rppt@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Michal Hocko <mhocko@suse.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Borislav Petkov <bp@alien8.de>, x86@kernel.org
Subject: Re: [PATCH RFC 2/2] mm/x86/pat: Do proper PAT bit shift for large
 mappings
Message-ID: <Zk_lHyR3QqcC-XTW@x1n>
References: <20240523223745.395337-1-peterx@redhat.com>
 <20240523223745.395337-3-peterx@redhat.com>
 <f19f63ba-c436-4e39-ab86-78c80b1af667@intel.com>
 <Zk_MGmfYsY9dt2Uo@x1n>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zk_MGmfYsY9dt2Uo@x1n>

On Thu, May 23, 2024 at 07:07:06PM -0400, Peter Xu wrote:
> On Thu, May 23, 2024 at 03:48:22PM -0700, Dave Hansen wrote:
> > On 5/23/24 15:37, Peter Xu wrote:
> > > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > > index 317de2afd371..c4a2356b1a54 100644
> > > --- a/mm/huge_memory.c
> > > +++ b/mm/huge_memory.c
> > > @@ -1135,7 +1135,7 @@ static void insert_pfn_pmd(struct vm_area_struct *vma, unsigned long addr,
> > >  		goto out_unlock;
> > >  	}
> > >  
> > > -	entry = pmd_mkhuge(pfn_t_pmd(pfn, prot));
> > > +	entry = pmd_mkhuge(pfn_t_pmd(pfn, pgprot_4k_2_large(prot)));
> > >  	if (pfn_t_devmap(pfn))
> > >  		entry = pmd_mkdevmap(entry);
> > >  	if (write) {
> > 
> > Does this even compile on non-x86 architectures?
> 
> Probably not..  I think I can define a pgprot_to_large() globally, pointing
> that to pgprot_4k_2_large() on x86 and make the fallback to be noop.  And
> if there's a new version I'll guarantee to run over my cross compilers.
> 
> Any comments on the idea itself?  Do we have a problem, or maybe I
> overlooked something?

I also attached one new version of patch 2 that should pass the cross
builds.  Please reviewers feel free to look at this one instead.  From x86
perspective they should be the same thing.

Thanks,

===8<===
From 1cce12c872cb01aaa8686d8f5c7cd6b266ca4e38 Mon Sep 17 00:00:00 2001
From: Peter Xu <peterx@redhat.com>
Date: Thu, 23 May 2024 18:19:35 -0400
Subject: [PATCH rfcv1.1] mm/x86/pat: Do proper PAT bit shift for large mappings

For large mappings, the pgtable PAT is set on bit 12 (_PAGE_PAT_LARGE)
rather than bit 9 (_PAGE_PAT), while bit 9 is used as PAE hint.  Do proper
shifting when inject large pfn pgtable mappings to make cache mode alright.

Cc: Alex Williamson <alex.williamson@redhat.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Kirill A. Shutemov <kirill@shutemov.name>
Cc: x86@kernel.org
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/x86/include/asm/pgtable_types.h | 1 +
 include/linux/pgtable.h              | 4 ++++
 mm/huge_memory.c                     | 4 ++--
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
index b78644962626..f9edb2bb1512 100644
--- a/arch/x86/include/asm/pgtable_types.h
+++ b/arch/x86/include/asm/pgtable_types.h
@@ -512,6 +512,7 @@ static inline pgprot_t pgprot_large_2_4k(pgprot_t pgprot)
 	return __pgprot(protval_large_2_4k(pgprot_val(pgprot)));
 }
 
+#define  pgprot_to_large(pgprot)  pgprot_4k_2_large(pgprot)
 
 typedef struct page *pgtable_t;
 
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 18019f037bae..54487d2b3e40 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1956,4 +1956,8 @@ pgprot_t vm_get_page_prot(unsigned long vm_flags)			\
 }									\
 EXPORT_SYMBOL(vm_get_page_prot);
 
+#ifndef  pgprot_to_large
+#define  pgprot_to_large(pgprot)  pgprot
+#endif
+
 #endif /* _LINUX_PGTABLE_H */
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 317de2afd371..4c134a60fb64 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1135,7 +1135,7 @@ static void insert_pfn_pmd(struct vm_area_struct *vma, unsigned long addr,
 		goto out_unlock;
 	}
 
-	entry = pmd_mkhuge(pfn_t_pmd(pfn, prot));
+	entry = pmd_mkhuge(pfn_t_pmd(pfn, pgprot_to_large(prot)));
 	if (pfn_t_devmap(pfn))
 		entry = pmd_mkdevmap(entry);
 	if (write) {
@@ -1233,7 +1233,7 @@ static void insert_pfn_pud(struct vm_area_struct *vma, unsigned long addr,
 		goto out_unlock;
 	}
 
-	entry = pud_mkhuge(pfn_t_pud(pfn, prot));
+	entry = pud_mkhuge(pfn_t_pud(pfn, pgprot_to_large(prot)));
 	if (pfn_t_devmap(pfn))
 		entry = pud_mkdevmap(entry);
 	if (write) {
-- 
2.45.0

-- 
Peter Xu



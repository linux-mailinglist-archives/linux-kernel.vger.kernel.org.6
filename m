Return-Path: <linux-kernel+bounces-279762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 963C494C187
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 17:34:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 509DE28A0BF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 15:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 154E4190068;
	Thu,  8 Aug 2024 15:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YHLLRHLs"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE2618FC80
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 15:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723131243; cv=none; b=kULToR//GDJ6FU7CoFuKx1gMX8Hoc2oCn/jq4ZHIVb5t5jayp0WIAwD7rT1XgctH55eIdMJqW2Z54mK8E93p+2HxbiQLqnh6aMuxfgTf46w6QekWlSXHToqPq/T1/psqUTcC30+tf8+nAbZj00QM033mA22HpOQ5tkU2bE8HN/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723131243; c=relaxed/simple;
	bh=j1vWtFBL6/Bq2Nrq7Tgq+YdOnOPtz0YO0ot8zae8pjc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ADKWfUoLqSu156B7IfaEkuJKoLqCj4xuY4uUnu6EGJAbgNLAzkBYAN2sVWWYNxj1brm+ow1j0Mkc6cuSDKcMgVeUqf7aIFFqJG26/eAVX2fJslFIsBKga7HGM2o1R5GK33ovB1IgOI9d8wYlrihpYfQOkXSjUxGavgwE3FWWU/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YHLLRHLs; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-70d1831ae05so1036732b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 08:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723131241; x=1723736041; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lZ0wde8if6L/uO3sLYu5HFWeUlZmqm4xvJMbv4zJJuU=;
        b=YHLLRHLskDevcpjYPr/YoPgdPdntFLFotc//duhu3e/Ga/zNiqkE2+NcbYzptGSi1O
         T2/Ur0dmR3q8YA3uM9jW3DwQ2ijvYbnYtjTrlx8lDRoiuB+rr7TZd4+75laylcrTFZjV
         slQldGT9BTVSGOQx1KBNLxbemZpcCee1QXzKho5mbt1Eh86mSKkONmouUb5wQiRZoZ4M
         ZVyAxZGQrK2g3hLyXXTMXRkAIjJkHX7cBR+cUwmcdL7MlooMtgoow5k7MJsbcStbzPTQ
         yFvUKtvbpMlQd3WTdWickyNi8x1r+Q52jLU0V56y2vgl3E+Cpes9tjDz698OYmTfI+TN
         aqnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723131241; x=1723736041;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lZ0wde8if6L/uO3sLYu5HFWeUlZmqm4xvJMbv4zJJuU=;
        b=P5QCyoFQdYbkQkg3MoF0pVBCyJk33fVYVjXzkXIROb8ZHyJA/td4lqf1+YFBT8glrt
         c+ndeFfKvMnkn3uo4ReFRm18Xmo7xjH5dCYARH97k32noQgFZ0YZFI3TAeyQo/Ta28fP
         PCX7BP3iyaoqOd7eP8R8QaEjQIaLblpJ2/CaorO44B552b2k4yHyOWRNNcKf8QG5bcWi
         F4vZYDXTiEsq2bMmSCK3/Igq/I+8SJlWzmMYc2Icl3u+MOZHailT3AQ9GaVovz8XtdQn
         UF6etz9SNfCR57+xLKYLzl0SkbxK/x0L7ckgn445FMKDClDltjxrGzCPxR8FUOhwueeG
         WTug==
X-Gm-Message-State: AOJu0YyO7wKvDOteuiRIjT4qoGOaIGNff3HyEDWEN6o+bVNKz6cOLv5S
	1L+s3WXMq20+8TejbNiom3oulC2h4Dymac6S/OGcD6Vc1ZwODzMSva4RIwClD0SOUkQGYM/OZ7n
	/4A==
X-Google-Smtp-Source: AGHT+IFW12G/8DTseTogt5MhAKcrgi/3fN+1gRYM4X6/jrZk3eDJGH2Gd3Qqt40eZzOvum4F7HsKf9TeReU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:6f25:b0:70d:3548:bb59 with SMTP id
 d2e1a72fcca58-710caf2dba9mr8014b3a.4.1723131241056; Thu, 08 Aug 2024 08:34:01
 -0700 (PDT)
Date: Thu, 8 Aug 2024 08:33:59 -0700
In-Reply-To: <20240807194812.819412-3-peterx@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240807194812.819412-1-peterx@redhat.com> <20240807194812.819412-3-peterx@redhat.com>
Message-ID: <ZrTlZ4vZ74sK8Ydd@google.com>
Subject: Re: [PATCH v4 2/7] mm/mprotect: Push mmu notifier to PUDs
From: Sean Christopherson <seanjc@google.com>
To: Peter Xu <peterx@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	"Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Oscar Salvador <osalvador@suse.de>, Dan Williams <dan.j.williams@intel.com>, 
	James Houghton <jthoughton@google.com>, Matthew Wilcox <willy@infradead.org>, 
	Nicholas Piggin <npiggin@gmail.com>, Rik van Riel <riel@surriel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Ingo Molnar <mingo@redhat.com>, 
	Rick P Edgecombe <rick.p.edgecombe@intel.com>, "Kirill A . Shutemov" <kirill@shutemov.name>, 
	linuxppc-dev@lists.ozlabs.org, Mel Gorman <mgorman@techsingularity.net>, 
	Hugh Dickins <hughd@google.com>, Borislav Petkov <bp@alien8.de>, David Hildenbrand <david@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Vlastimil Babka <vbabka@suse.cz>, 
	Dave Hansen <dave.hansen@linux.intel.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Huang Ying <ying.huang@intel.com>, kvm@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, David Rientjes <rientjes@google.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, Aug 07, 2024, Peter Xu wrote:
> mprotect() does mmu notifiers in PMD levels.  It's there since 2014 of
> commit a5338093bfb4 ("mm: move mmu notifier call from change_protection to
> change_pmd_range").
> 
> At that time, the issue was that NUMA balancing can be applied on a huge
> range of VM memory, even if nothing was populated.  The notification can be
> avoided in this case if no valid pmd detected, which includes either THP or
> a PTE pgtable page.
> 
> Now to pave way for PUD handling, this isn't enough.  We need to generate
> mmu notifications even on PUD entries properly.  mprotect() is currently
> broken on PUD (e.g., one can easily trigger kernel error with dax 1G
> mappings already), this is the start to fix it.
> 
> To fix that, this patch proposes to push such notifications to the PUD
> layers.
> 
> There is risk on regressing the problem Rik wanted to resolve before, but I
> think it shouldn't really happen, and I still chose this solution because
> of a few reasons:
> 
>   1) Consider a large VM that should definitely contain more than GBs of
>   memory, it's highly likely that PUDs are also none.  In this case there

I don't follow this.  Did you mean to say it's highly likely that PUDs are *NOT*
none?

>   will have no regression.
> 
>   2) KVM has evolved a lot over the years to get rid of rmap walks, which
>   might be the major cause of the previous soft-lockup.  At least TDP MMU
>   already got rid of rmap as long as not nested (which should be the major
>   use case, IIUC), then the TDP MMU pgtable walker will simply see empty VM
>   pgtable (e.g. EPT on x86), the invalidation of a full empty region in
>   most cases could be pretty fast now, comparing to 2014.

The TDP MMU will indeed be a-ok.  It only zaps leaf SPTEs in response to
mmu_notifier invalidations, and checks NEED_RESCHED after processing each SPTE,
i.e. KVM won't zap an entire PUD and get stuck processing all its children.

I doubt the shadow MMU will fair much better than it did years ago though, AFAICT
the relevant code hasn't changed.  E.g. when zapping a large range in response to
an mmu_notifier invalidation, KVM never yields even if blocking is allowed.  That 
said, it is stupidly easy to fix the soft lockup problem in the shadow MMU.  KVM
already has an rmap walk path that plays nice with NEED_RESCHED *and* zaps rmaps,
but because of how things grew organically over the years, KVM never adopted the
cond_resched() logic for the mmu_notifier path.

As a bonus, now the .change_pte() is gone, the only other usage of x86's
kvm_handle_gfn_range() is for the aging mmu_notifiers, and I want to move those
to their own flow too[*], i.e. kvm_handle_gfn_range() in its current form can
be removed entirely.

I'll post a separate series, I don't think it needs to block this work, and I'm
fairly certain I can get this done for 6.12 (shouldn't be a large or scary series,
though I may tack on my lockless aging idea as an RFC).

https://lore.kernel.org/all/Zo137P7BFSxAutL2@google.com


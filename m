Return-Path: <linux-kernel+bounces-280142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD9694C64A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 23:31:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFE731F24FFD
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 21:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 538F415AAD6;
	Thu,  8 Aug 2024 21:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fKU4CAtu"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299372575F
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 21:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723152683; cv=none; b=Wa1uzm+GR2pzo7rHxhQ9fhv8/YFiv4y7WGjWfOUiUAGKh+Aa5kNlzHKmCxgXtVVrqa41MtjWJvOokBcbKAKRS4emi28x2JCb+AU4HMG1OtAoIXtMG5u4MmsXVeiAziBRaCF30cTcLl4MyKib47MyzS0VtLUYLIHvwmIqr6WV+Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723152683; c=relaxed/simple;
	bh=3XZtyGNlZXDt7eNoA4oyrfYWL2zKbyb0O6wqXlfUMFs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EQ57ilBFxhK/YnppmRB9SyPlzGiF82aMuEbhXyJZePCPLCQv95f6KXJI0W4AQch1ZMRp1HI0Gc7t19BgbwzBFXLb7V6wI7XTHXf51pvh5E/Y4IhFyXXKbsrNBs48y/AJK7L2z3sQQIpWJial+INdHMDMkSF3mpzoqAnPz/H/QS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fKU4CAtu; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-5e4df21f22dso1238270a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 14:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723152681; x=1723757481; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YuGkjDtUlaXTtwi32m/glrLrjhcbyitEhoCA9sFmL3A=;
        b=fKU4CAtu65pXgGmld0UGr1lx8mu1vEmCvuUnLMwbed035yM7u+oE4XWo4e9smQZ1Ye
         ZYssDDXKDV3ygbTtxPBavcst+sMDNJWoA/b13ucQvaEJxe/2GU16kvxeEWBrlVsTR8pB
         mdBV2McPrOQfak4gu9tV2VU6tVA55U/72or0Gj+TGt6ZFtQ9XGuu34Q8xaCh98IBBBQG
         AxYL9l6Z++aQvbt4Zkn/Pu0qnTUSo6I+uFeGvt3nG8IWMPg02Dh8XZa9fsioom9nPFl5
         gaX8n3bBlPdBHXgHSaBdWhVLTuQU2seYFmkKuB9I9+2Xi3Fo98vIWmKlt44lfs+odlLq
         RGgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723152681; x=1723757481;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YuGkjDtUlaXTtwi32m/glrLrjhcbyitEhoCA9sFmL3A=;
        b=gh79up04Iy7v66Mj0CAmfjX/uiNv4aUlqMfPTtP6F1P1X/rGWq9ZvcitPCrv7YoEgH
         CBACPynu0IItjQC1vP175kRpftFZnuDXmPA0UIPQ3qd0xpFQ3iD2QoJgNo9zbwceSqKn
         Ksj2Nkyh5IyutizJo3fENu3OvsdQDNPT7OQjE9RchbBU7DR1TUX4A6UHhkxGra7QgQaq
         V8fA0+3c2sJoT8SNKl5kGhQDDo3+5Fn/oXFx67t52lnj1SjmZ5c5dzRiMSeWJNUZ25NZ
         ZMvbHtsdAVm0QvTAJUU47SxtLbof3YynBGKuxXt1t4lRMKEXOx4+hZ4WjlFxI2Wk1k0m
         9k/g==
X-Gm-Message-State: AOJu0YwRMX6KHBcJ0uaRNWgIV1bCzWAi+HTvlXT+sARygAfI3QUUGMV5
	u+puBRt2xplObHCVe13423XUnOEy+iQqq6Oz9yWPy1Bi9LPMbxL/IuOeWtTLS5F+OtnmNcJ5dAq
	8PQ==
X-Google-Smtp-Source: AGHT+IEP73Lm+ojwFY0B1vludlYBr1Am2NVgxUI9/0Rde9EmSF7EgK1uLnCg73xCWYIY67KH9l4Ygd6Hklk=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a63:6685:0:b0:7a1:1b9f:2b16 with SMTP id
 41be03b00d2f7-7c268c1d3d2mr6887a12.2.1723152681108; Thu, 08 Aug 2024 14:31:21
 -0700 (PDT)
Date: Thu, 8 Aug 2024 14:31:19 -0700
In-Reply-To: <ZrU20AqADICwwmCy@x1n>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240807194812.819412-1-peterx@redhat.com> <20240807194812.819412-3-peterx@redhat.com>
 <ZrTlZ4vZ74sK8Ydd@google.com> <ZrU20AqADICwwmCy@x1n>
Message-ID: <ZrU5JyjIa1CwZ_KD@google.com>
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

On Thu, Aug 08, 2024, Peter Xu wrote:
> Hi, Sean,
> 
> On Thu, Aug 08, 2024 at 08:33:59AM -0700, Sean Christopherson wrote:
> > On Wed, Aug 07, 2024, Peter Xu wrote:
> > > mprotect() does mmu notifiers in PMD levels.  It's there since 2014 of
> > > commit a5338093bfb4 ("mm: move mmu notifier call from change_protection to
> > > change_pmd_range").
> > > 
> > > At that time, the issue was that NUMA balancing can be applied on a huge
> > > range of VM memory, even if nothing was populated.  The notification can be
> > > avoided in this case if no valid pmd detected, which includes either THP or
> > > a PTE pgtable page.
> > > 
> > > Now to pave way for PUD handling, this isn't enough.  We need to generate
> > > mmu notifications even on PUD entries properly.  mprotect() is currently
> > > broken on PUD (e.g., one can easily trigger kernel error with dax 1G
> > > mappings already), this is the start to fix it.
> > > 
> > > To fix that, this patch proposes to push such notifications to the PUD
> > > layers.
> > > 
> > > There is risk on regressing the problem Rik wanted to resolve before, but I
> > > think it shouldn't really happen, and I still chose this solution because
> > > of a few reasons:
> > > 
> > >   1) Consider a large VM that should definitely contain more than GBs of
> > >   memory, it's highly likely that PUDs are also none.  In this case there
> > 
> > I don't follow this.  Did you mean to say it's highly likely that PUDs are *NOT*
> > none?
> 
> I did mean the original wordings.
> 
> Note that in the previous case Rik worked on, it's about a mostly empty VM
> got NUMA hint applied.  So I did mean "PUDs are also none" here, with the
> hope that when the numa hint applies on any part of the unpopulated guest
> memory, it'll find nothing in PUDs. Here it's mostly not about a huge PUD
> mapping as long as the guest memory is not backed by DAX (since only DAX
> supports 1G huge pud so far, while hugetlb has its own path here in
> mprotect, so it must be things like anon or shmem), but a PUD entry that
> contains pmd pgtables.  For that part, I was trying to justify "no pmd
> pgtable installed" with the fact that "a large VM that should definitely
> contain more than GBs of memory", it means the PUD range should hopefully
> never been accessed, so even the pmd pgtable entry should be missing.

Ah, now I get what you were saying.

Problem is, walking the rmaps for the shadow MMU doesn't benefit (much) from
empty PUDs, because KVM needs to blindly walk the rmaps for every gfn covered by
the PUD to see if there are any SPTEs in any shadow MMUs mapping that gfn.  And
that walk is done without ever yielding, which I suspect is the source of the
soft lockups of yore.

And there's no way around that conundrum (walking rmaps), at least not without a
major rewrite in KVM.  In a nested TDP scenario, KVM's stage-2 page tables (for
L2) key off of L2 gfns, not L1 gfns, and so the only way to find mappings is
through the rmaps.


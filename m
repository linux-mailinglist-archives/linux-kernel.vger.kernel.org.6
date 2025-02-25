Return-Path: <linux-kernel+bounces-532571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E502A44F62
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 23:00:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED7E918942EF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 22:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19EFA2135D9;
	Tue, 25 Feb 2025 22:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LuLWil9I"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898881DC997
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 22:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740520808; cv=none; b=A9uQdZijFpGCgapF4nEaYBAJvZ1i0HOAfDeskiz3ZchB0OrmuUpfiSJDWZ7qvAhMKn1yXp6Fq3tBS3W3jmq4kyK/+gxfNQIDQP+3P3xPTFr177N4uMsVc1R+gXMwEqyBhayh/STCVVBv4ILNw7vhxQWdEC51VHU1fPT5P9k1j/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740520808; c=relaxed/simple;
	bh=LGdXOz1Z3oleLe2XFRI65us3attlCYpRc59iXFHvP88=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Jq/0YChw6hn8rua0IJQye+3nhYQBppiegLGX6yM2K3HP+pFYSjWD+xFlr0nh12VwXt2nxNYOSdvgPJvxEA93VrqsQcM8u04WW5OColV+45JsfeMsvAPvQZd8rFqcMK2sVvTS4ep9zbS+cTnUDCb6I2NDyzW1pGYNierkgEjLXlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LuLWil9I; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740520805;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0Bb2V+mbnJJoInEW5Wm2LB6yv6+Wa0umig9olpTiRHM=;
	b=LuLWil9IPzcvya7pqUh8SmEopCnShVlX1DaPD5XP1cO6/CL04YNHcQvuQnIYXifG0hSwet
	AjymbueG4vA/y/ZEaFXqp93ru3uigcLduLZv+h4vH/QvRVjiMxRDtm+4SRG20AeYRb4E3V
	eKLJvhY2SOp+A+5Z2gFLFV5xErIg908=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-294-lOF8JZonPlKlczE5WljAIA-1; Tue, 25 Feb 2025 17:00:04 -0500
X-MC-Unique: lOF8JZonPlKlczE5WljAIA-1
X-Mimecast-MFC-AGG-ID: lOF8JZonPlKlczE5WljAIA_1740520803
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-471fc73b941so185534771cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 14:00:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740520803; x=1741125603;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0Bb2V+mbnJJoInEW5Wm2LB6yv6+Wa0umig9olpTiRHM=;
        b=svFo9lh5EQfEKhOY8E4SfOSoeIixsmw64sh+LAJ8HdsVj6e6BOD/4OCKOOlF2iOlhO
         A95z424ncL1Wy/J2EcwnVl2CvPUUfi/spxBFFul45NAu4BwjIro9TJx5qo+26z6+Wc0X
         O1+SVkCcuYfKfYwvffzrtW1nHpoMiy0JIsOp8XPPVPeJ7QxxllnxbIMHFj8sAZGuyfhJ
         jgACBiYWWlK8anqsaYSTMK82kGrW4KKx+9Rf2ij9ztMZv8VW4t7YQcIhv9i0gT7w4Ekj
         7dLvJ2DDwMg1Ade4ZmBD5Bv99YczOUy09fWR9yzXl9C302vG9RJ9VCYwdUPFH/dtFSQ/
         M3Vg==
X-Forwarded-Encrypted: i=1; AJvYcCVGdDCrfH/KJbBlWJpWgFj1WvofRzOdnJ/nVBPnlt/owvckwPR1J7zYyHO5UCixYg3XGWmxCe44Pd/cEKQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5gQqFsvEab87k0BeFZ/TSzj8VTXLKZ/1xCX9W3TET1l1kVtZM
	rBA7HeZ8z1Vk0cSen/rmivw0Szn8Hfgp/5vNklUC8D0TFECRHrl2cCqpk55BQexDL174wT8lUTf
	e/pmHo5JDnzsdQCbjuQv2eAGXzmK04WreXeIuB2PIrQIsIuoBPahxs6gDZCAkWA==
X-Gm-Gg: ASbGncuxL4UCSR+h74vpShSrZBaKXhBI6WyggqHra1lMHTmCJz+s86D/mz3mru6srUU
	5SNyXdKbPtV0arRiHZkYDDP7IqLfTTg6TzqG09hLq+3ynaME1nZJuqSDazL1DWZm+iJlCU8MNNJ
	TDfspHnmczR8Mjh9Erk3AuAmiqbac9rmqSmDnYuNp7e1Ku5KpdLJCiTzz23Sq2ULFUN93Xj7jsk
	vSW7BqQabcbxQaitJbSDj8SXH7PquJuv0CkTvHDseMlUW4za/byGU/ead7Ywe3LGCPECuuHVlBf
	gpEJjZp00K0/5cY=
X-Received: by 2002:ac8:5fcd:0:b0:471:f272:9862 with SMTP id d75a77b69052e-4737725ccd8mr80673481cf.41.1740520803178;
        Tue, 25 Feb 2025 14:00:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGKcJI9jny77dfDG0KDTNvU6C4CH9BV0kPcSk7G/tFKXoyZJlHMLOdxm3hpfh33e+GECWyEuQ==
X-Received: by 2002:ac8:5fcd:0:b0:471:f272:9862 with SMTP id d75a77b69052e-4737725ccd8mr80672761cf.41.1740520802597;
        Tue, 25 Feb 2025 14:00:02 -0800 (PST)
Received: from starship ([2607:fea8:fc01:8d8d:6adb:55ff:feaa:b156])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47378082f55sm15049841cf.65.2025.02.25.14.00.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 14:00:02 -0800 (PST)
Message-ID: <07788b85473e24627131ffe1a8d1d01856dd9cb5.camel@redhat.com>
Subject: Re: [PATCH v9 00/11] KVM: x86/mmu: Age sptes locklessly
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Sean Christopherson <seanjc@google.com>
Cc: James Houghton <jthoughton@google.com>, Paolo Bonzini
 <pbonzini@redhat.com>,  David Matlack <dmatlack@google.com>, David Rientjes
 <rientjes@google.com>, Marc Zyngier <maz@kernel.org>,  Oliver Upton
 <oliver.upton@linux.dev>, Wei Xu <weixugc@google.com>, Yu Zhao
 <yuzhao@google.com>, Axel Rasmussen <axelrasmussen@google.com>,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 25 Feb 2025 17:00:00 -0500
In-Reply-To: <Z7UwI-9zqnhpmg30@google.com>
References: <20250204004038.1680123-1-jthoughton@google.com>
	 <025b409c5ca44055a5f90d2c67e76af86617e222.camel@redhat.com>
	 <Z7UwI-9zqnhpmg30@google.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

On Tue, 2025-02-18 at 17:13 -0800, Sean Christopherson wrote:
> On Tue, Feb 18, 2025, Maxim Levitsky wrote:
> > On Tue, 2025-02-04 at 00:40 +0000, James Houghton wrote:
> > > By aging sptes locklessly with the TDP MMU and the shadow MMU, neither
> > > vCPUs nor reclaim (mmu_notifier_invalidate_range*) will get stuck
> > > waiting for aging. This contention reduction improves guest performance
> > > and saves a significant amount of Google Cloud's CPU usage, and it has
> > > valuable improvements for ChromeOS, as Yu has mentioned previously[1].
> > > 
> > > Please see v8[8] for some performance results using
> > > access_tracking_perf_test patched to use MGLRU.
> > > 
> > > Neither access_tracking_perf_test nor mmu_stress_test trigger any
> > > splats (with CONFIG_LOCKDEP=y) with the TDP MMU and with the shadow MMU.
> > 
> > Hi, I have a question about this patch series and about the
> > access_tracking_perf_test:
> > 
> > Some time ago, I investigated a failure in access_tracking_perf_test which
> > shows up in our CI.
> > 
> > The root cause was that 'folio_clear_idle' doesn't clear the idle bit when
> > MGLRU is enabled, and overall I got the impression that MGLRU is not
> > compatible with idle page tracking.
> > 
> > I thought that this patch series and the 'mm: multi-gen LRU: Have secondary
> > MMUs participate in MM_WALK' patch series could address this but the test
> > still fails.
> > 
> > 
> > For the reference the exact problem is:
> > 
> > 1. Idle bits for guest memory under test are set via /sys/kernel/mm/page_idle/bitmap
> > 
> > 2. Guest dirties memory, which leads to A/D bits being set in the secondary mappings.
> > 
> > 3. A NUMA autobalance code write protects the guest memory. KVM in response
> >    evicts the SPTE mappings with A/D bit set, and while doing so tells mm
> >    that pages were accessed using 'folio_mark_accessed' (via kvm_set_page_accessed (*) )
> >    but due to MLGRU the call doesn't clear the idle bit and thus all the traces
> >    of the guest access disappear and the kernel thinks that the page is still idle.
> > 
> > I can say that the root cause of this is that folio_mark_accessed doesn't do
> > what it supposed to do.
> > 
> > Calling 'folio_clear_idle(folio);' in MLGRU case in folio_mark_accessed()
> > will probably fix this but I don't have enough confidence to say if this is
> > all that is needed to fix this.  If this is the case I can send a patch.
> 
> My understanding is that the behavior is deliberate.  Per Yu[1], page_idle/bitmap
> effectively isn't supported by MGLRU.
> 
> [1] https://lore.kernel.org/all/CAOUHufZeADNp_y=Ng+acmMMgnTR=ZGFZ7z-m6O47O=CmJauWjw@mail.gmail.com

Hi,

Reading this mail makes me think that the page idle interface isn't really used anymore.

Maybe we should redo the access_tracking_perf_test to only use the MGLRU specific interfaces/mode,
and remove its classical page_idle mode altogher?

The point I am trying to get across is that currently access_tracking_perf_test main 
purpose is to test that page_idle works with secondary paging and the fact is that it doesn't work 
well due to more that one reason:

The mere fact that we don't flush TLB already necessitated hacks like the 90% check,
which for example doesn't work nested so another hack was needed, to skip the check
completely when hypervisor is detected, etc, etc.

And now as of 6.13, we don't propagate accessed bit when KVM zaps the SPTE at all, 
which can happen at least in theory due to other reasons than NUMA balancing.


Tomorrow there will be something else that will cause KVM to zap the SPTEs, and the test will fail again,
and again...

What do you think?


> 
> > This patch makes the test pass (but only on 6.12 kernel and below, see below):
> > 
> > diff --git a/mm/swap.c b/mm/swap.c
> > index 59f30a981c6f..2013e1f4d572 100644
> > --- a/mm/swap.c
> > +++ b/mm/swap.c
> > @@ -460,7 +460,7 @@ void folio_mark_accessed(struct folio *folio)
> >  {
> >         if (lru_gen_enabled()) {
> >                 folio_inc_refs(folio);
> > -               return;
> > +               goto clear_idle_bit;
> >         }
> >  
> >         if (!folio_test_referenced(folio)) {
> > @@ -485,6 +485,7 @@ void folio_mark_accessed(struct folio *folio)
> >                 folio_clear_referenced(folio);
> >                 workingset_activation(folio);
> >         }
> > +clear_idle_bit:
> >         if (folio_test_idle(folio))
> >                 folio_clear_idle(folio);
> >  }
> > 
> > 
> > To always reproduce this, it is best to use a patch to make the test run in a
> > loop, like below (although the test fails without this as well).
> 
> ..
> 
> > With the above patch applied, you will notice after 4-6 iterations that the
> > number of still idle pages soars:
> > 
> > Populating memory             : 0.798882357s
> 
> ...
> 
> > vCPU0: idle pages: 132558 out of 262144, failed to mark idle: 0 no pfn: 0
> > Mark memory idle              : 2.711946690s
> > Writing to idle memory        : 0.302882502s
> > 
> > ...
> > 
> > (*) Turns out that since kernel 6.13, this code that sets accessed bit in the
> > primary paging structure, when the secondary was zapped was *removed*. I
> > bisected this to commit:
> > 
> > 66bc627e7fee KVM: x86/mmu: Don't mark "struct page" accessed when zapping SPTEs
> > 
> > So now the access_tracking_test is broken regardless of MGLRU.
> 
> Just to confirm, do you see failures on 6.13 with MGLRU disabled?  

Yes. The test always fails.

> 
> > Any ideas on how to fix all this mess?
> 
> The easy answer is to skip the test if MGLRU is in use, or if NUMA balancing is
> enabled.  In a real-world scenario, if the guest is actually accessing the pages
> that get PROT_NONE'd by NUMA balancing, they will be marked accessed when they're
> faulted back in.  There's a window where page_idle/bitmap could be read between
> making the VMA PROT_NONE and re-accessing the page from the guest, but IMO that's
> one of the many flaws of NUMA balancing.
> 
> That said, one thing is quite odd.  In the failing case, *half* of the guest pages
> are still idle.  That's quite insane.
> 
> Aha!  I wonder if in the failing case, the vCPU gets migrated to a pCPU on a
> different node, and that causes NUMA balancing to go crazy and zap pretty much
> all of guest memory.  If that's what's happening, then a better solution for the
> NUMA balancing issue would be to affine the vCPU to a single NUMA node (or hard
> pin it to a single pCPU?).

Nope. I pinned main thread to  CPU 0 and VM thread to  CPU 1 and the problem persists.
On 6.13, the only way to make the test consistently work is to disable NUMA balancing.


Best regards,
	Maxim Levitsky





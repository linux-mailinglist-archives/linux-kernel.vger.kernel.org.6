Return-Path: <linux-kernel+bounces-298938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF1195CDBB
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 15:27:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34F701F243D9
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 13:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0916F186E39;
	Fri, 23 Aug 2024 13:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2rcjfzw5"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3949186601
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 13:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724419647; cv=none; b=USrlDeFgTNShtC81GU7ujLWa+nPx7nGpiyt4PtWUWR63MSR1nwe/thl9pBz42p7LNfsjrDD5iZXZBgS9FFS4hJEFfFmsi1t5zOkSj3cv0N4/pQv//mhmhluaoV3zePrLAy6x5LqQAFsAe3vVhAe1atBu/HEM4hEtfPjTRA9T74Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724419647; c=relaxed/simple;
	bh=gkV7L0xgIqdS75BR6FVfM70ki27PozW4gYl9NIpEHV8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sI6bblptIuzRP56SMZV8QXcFrD/Ho49n3zNElfka1u2XoURJjKbUsmZcJpFOwMgZ49sD8FwbqBTFmDzUgS9vhIZ7XW1ooxNw3O5EMZtDuhpsZYl2XpG1+eAF7Owh8hYjwolZXEmNCV/10Q7y6YFluNO2vQJ9kPtNFc/IePQ/ZUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2rcjfzw5; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2d3c008e146so2257595a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 06:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724419645; x=1725024445; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=N8Ef0ixVq1Ssftzpz2CrTSL5ehMj86hkYQziGH0NMvY=;
        b=2rcjfzw54+/6U9eIBShqmiNCsswdc1w+bhHQNRivjaIiuURprDUGrUMuoTV7vEuWHc
         fOGnbJ/pioTBa7e+a4Q3TYc5LK2OmOUaMG0f84U0B42nmkUZfOXBx+1LTiIdwCC1aZg1
         PsT06QuDVrNnX63p2dkG6A/4p7zKEAxolE6l0sb/hYZmGZriHYmTEhEGHk9Ke1ubum+f
         XGSxG+Cg7aZDRkmRfD1idPE/Ff9KElELSsOy0ULwfvvlS7ZQpX7ggoGDDzhPSDVNihpx
         HVZDWkGlk1P19/TgaUs0RseQklFM3B/iTzTHvvBbSNQpYB+y7HH5YISlmerOFE/cWzhV
         wIkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724419645; x=1725024445;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N8Ef0ixVq1Ssftzpz2CrTSL5ehMj86hkYQziGH0NMvY=;
        b=LSp8wqzwQHqcHprjRYRLDrfrVUJSm+wMKwdECA2aDdCs5wn3WO6iDWRV7xcNicFQEF
         jtSYkbq6isx4dEbl9yuo2hOOWMOh+TwHgyKcnUyAkkTS1bH4SQpKPsCms+vWqXEftSCH
         mUEhmjOV3hc/WTlkSkJvQqS1aD9Y9/4olA3nEf9h4BX28OIVOEruQK6BXToJhAs2w7Zj
         7Mr6ysS3H1EyHRvNBcqXUFjnKVpqw0c6Ene0Cr1Xj69tm6hBC9rQYIm2XYynWP9Qw/l/
         1UrFf1VBhstH29YxEN0fOWAM71JQhzFzLKIb4BFKY6c+DRHYm5Nqv6bLSKHwulMBZnfa
         uqSw==
X-Forwarded-Encrypted: i=1; AJvYcCU0Q4S7/OQm4H/PLCDtmcHji0K/wUJRDk3ohzKdrZXG+41demd8w87Zkz5P8xiC9FExJFnCcib1bTuED54=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCglAbyz/+N63bIsJNeLv+cuFeANhwebcj88h5HFA3aDrLsjTf
	Vh/wYwrpHqdGMia0ZOJO6VYmMVHctzvMDE1qYxciKoYtg91Ehj/lEzrVjo8i5DUuK+/SlspbYdt
	40w==
X-Google-Smtp-Source: AGHT+IEzZfO+fuHrj0fYDVlO89QIfXwRZDOmuttI6MD7uqhT8MwWlZma1Qq3IQN8e5TlXvR8nSwA5lT5Hf0=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90b:1b51:b0:2cd:1e0d:a4c7 with SMTP id
 98e67ed59e1d1-2d646b8fa5dmr36595a91.1.1724419644812; Fri, 23 Aug 2024
 06:27:24 -0700 (PDT)
Date: Fri, 23 Aug 2024 06:27:23 -0700
In-Reply-To: <20240823121538.GA32110@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240802191617.312752-1-seanjc@google.com> <20240820154150.GA28750@willie-the-truck>
 <ZsS_OmxwFzrqDcfY@google.com> <20240820163213.GD28750@willie-the-truck>
 <ZsTM-Olv8aT2rql6@google.com> <20240823121538.GA32110@willie-the-truck>
Message-ID: <ZsiOO88d7O8lpQoV@google.com>
Subject: Re: [PATCH] KVM: Use precise range-based flush in mmu_notifier hooks
 when possible
From: Sean Christopherson <seanjc@google.com>
To: Will Deacon <will@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="us-ascii"

On Fri, Aug 23, 2024, Will Deacon wrote:
> On Tue, Aug 20, 2024 at 10:06:00AM -0700, Sean Christopherson wrote:
> > On Tue, Aug 20, 2024, Will Deacon wrote:
> > > On Tue, Aug 20, 2024 at 09:07:22AM -0700, Sean Christopherson wrote:
> > > > On Tue, Aug 20, 2024, Will Deacon wrote:
> > > > > handler could do the invalidation as part of its page-table walk (for
> > > > > example, it could use information about the page-table structure such
> > > > > as the level of the leaves to optimise the invalidation further), but
> > > > > this does at least avoid zapping the whole VMID on CPUs with range
> > > > > support.
> > > > > 
> > > > > My only slight concern is that, should clear_flush_young() be extended
> > > > > to operate on more than a single page-at-a-time in future, this will
> > > > > silently end up invalidating the entire VMID for each memslot unless we
> > > > > teach kvm_arch_flush_remote_tlbs_range() to return !0 in that case.
> > > > 
> > > > I'm not sure I follow the "entire VMID for each memslot" concern.  Are you
> > > > worried about kvm_arch_flush_remote_tlbs_range() failing and triggering a VM-wide
> > > > flush?
> > > 
> > > The arm64 implementation of kvm_arch_flush_remote_tlbs_range()
> > > unconditionally returns 0, so we could end up over-invalidating pretty
> > > badly if that doesn't change. It should be straightforward to fix, but
> > > I just wanted to point it out because it would be easy to miss too!
> > 
> > Sorry, I'm still not following.  0==success, and gfn_range.{start,end} is scoped
> > precisely to the overlap between the memslot and hva range.  Regardless of the
> > number of pages that are passed into clear_flush_young(), KVM should naturally
> > flush only the exact range being aged.  The only hiccup would be if the hva range
> > straddles multiple memslots, but if userspace creates multiple memslots for a
> > single vma, then that's a userspace problem.
> 
> Fair enough, but it's not a lot of effort to fix this (untested diff
> below) and if the code were to change in future so that
> __kvm_handle_hva_range() was more commonly used to span multiple
> memslots we probably wouldn't otherwise notice the silent
> over-invalidation for a while.
> 
> Will
> 
> --->8
> 
> diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
> index 6981b1bc0946..1e34127f79b0 100644
> --- a/arch/arm64/kvm/mmu.c
> +++ b/arch/arm64/kvm/mmu.c
> @@ -175,6 +175,9 @@ int kvm_arch_flush_remote_tlbs(struct kvm *kvm)
>  int kvm_arch_flush_remote_tlbs_range(struct kvm *kvm,
>                                       gfn_t gfn, u64 nr_pages)
>  {
> +       if (!system_supports_tlb_range())
> +               return -EOPNOTSUPP;

Oooh, now your comments make a lot more sense.  I didn't catch on that range-based
flushing wasn't universally supported.

Agreed, not doing the above would be asinine.

> +
>         kvm_tlb_flush_vmid_range(&kvm->arch.mmu,
>                                 gfn << PAGE_SHIFT, nr_pages << PAGE_SHIFT);
>         return 0;
> 


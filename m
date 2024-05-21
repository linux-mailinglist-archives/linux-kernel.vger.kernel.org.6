Return-Path: <linux-kernel+bounces-185242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B58C98CB290
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 18:58:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6CE71C215CC
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 16:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E29B61474B3;
	Tue, 21 May 2024 16:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rqD/OJ1J"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1889482D0
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 16:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716310720; cv=none; b=XtMoQ0rZcLkvgHu2pb8mD5nivENugaNbsiSkkwSRBUfV2StMtkGpl8/YO52Fg7QBQeIeGYMGC/bRkQq7EA40NVyY9hjHoRaIoeMqGLbKAPpRaOaG+zrOP4Vz6AZP96R8U6yPFStnfAeuNy63qHrwQiWjWp4UdhqjtYInylxb41w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716310720; c=relaxed/simple;
	bh=7k2kWL58JjVh4nVVVWtUiXq68vYdV+B+sjmnMACeFXY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RBejL/38bMEgm/KAcJWjW9rV8T+qknxvE0DMYplFXsHemihLYhYVJMEBNJhoKvZY5hilS33TOXnVz4qvqwfgpN8Cn2X8elXOXv7i5RTk6dScDGntcvqI4fxZvxj50EOGG46eNjoR5kY/oD3cIZk/chEVJEENw0uYthA/DbMpMZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rqD/OJ1J; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-6f45487858eso8791199b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 09:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716310718; x=1716915518; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=23Va6tBLKyrT6+rYe1Dwuy5+S+h8Qtz8qDJTWfCf654=;
        b=rqD/OJ1JnrH7jXviVhBTzvlbzoqWoftnyGaMLsR4RDltOJtqA5FSS9fSdGN2xQswzY
         usjR7Z3jRBD9SvA1H/MeohuX7QsADawAYDy/nJtwLCCr6tizTYAvPZIjIuQwkRUOr9nj
         Gr60bU3C2+eDUoSC9NZ635g38d/YdE3iha3Z/R4QMvN4x3NskfRlFSSGeSCc/nkmkj5Y
         HjcQsDJ+EKkBfb8A5opBIqcWuPaDIbxVOT2D+Nor+6FGbu61F/0f+KzifiJsdCm2i6ZV
         SXBP6oNTjAIv8OWuKAo/0K6iq8ToHKCb+9+LDXeSmUqly2x9aZJHrsUEIsMnqyJw++hB
         lHuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716310718; x=1716915518;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=23Va6tBLKyrT6+rYe1Dwuy5+S+h8Qtz8qDJTWfCf654=;
        b=W4xPp2aHKOT5z7LZ3g5/I4A0V5Bmgg1asG6rq+KQ281X+xJe4eRyoIDfPkm9FtihUW
         O51zDD2/clC5amii3tbe2QNI53l9IbIVjyheQwIsIyzpxhI/vqSa1f0xEixf/p9Qg3gv
         lllB5RxOHpxFty4A1AsIRSnBIkjVkQh8RxbEoXejRHPqdhueGjBVuDr3RTqtgOnKK8mi
         551nh5VIJWrixtntU5b4AXriVVPO/goIMMw3stDywQik0OX3Y0oO18NwA98zYGnxQKYO
         49cY5lQPmdc6u/rmJ7gHApVCSTn7TUj9pxeel9JeZTqHWkksrBMzG6AMl5JAv1krNKfN
         1c4g==
X-Forwarded-Encrypted: i=1; AJvYcCXlF381c9CUg/Xg4deyvKosJQ+LEoDyuHquV1r4o9/zmzS+ISFatSVWRpZu+isghLR7FrBkxb7PfxbKfXbsl1UCrW+xwsxADak2CFvx
X-Gm-Message-State: AOJu0YzTND2zV6oAAIaCXpR4lbe/a0GQ+g+bNzbIgf3lImNpvlOTAmtH
	p+H0LrG+KiiELWtzSdRq9nroW+V3lh51MOOvza2NQaFQcbiCDgzQOW2YO4Qoe/IQkqmnFV1BhYJ
	ERQ==
X-Google-Smtp-Source: AGHT+IFvONb8srr3+xxmvcHKpYLr60Bhkuaprz/B1jPuBNbGhMT70+iD6UVhEdu6lLYdg8HqCCvOlFn9Zu0=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:1144:b0:6f3:e9c0:a195 with SMTP id
 d2e1a72fcca58-6f4e03cae91mr854337b3a.5.1716310717552; Tue, 21 May 2024
 09:58:37 -0700 (PDT)
Date: Tue, 21 May 2024 09:58:36 -0700
In-Reply-To: <qgzgdh7fqynpvu6gh6kox5rnixswtu2ewl3hiutohpndmbdo6x@kfwegt625uqh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <58492a1a-63bb-47d2-afef-164557d15261@redhat.com>
 <20240518150457.1033295-1-michael.roth@amd.com> <ZktbBRLXeOp9X6aH@google.com>
 <iqzde53xfkcpqpjvrpyetklutgqpepy3pzykwpdwyjdo7rth3m@taolptudb62c>
 <ZkvddEe3lnAlYQbQ@google.com> <20240521020049.tm3pa2jdi2pg4agh@amd.com>
 <ZkyrAETobNEjI4Tr@google.com> <qgzgdh7fqynpvu6gh6kox5rnixswtu2ewl3hiutohpndmbdo6x@kfwegt625uqh>
Message-ID: <ZkzSvPGass4z4u9p@google.com>
Subject: Re: [PATCH] KVM: SEV: Fix guest memory leak when handling guest requests
From: Sean Christopherson <seanjc@google.com>
To: Michael Roth <michael.roth@amd.com>
Cc: Michael Roth <mdroth@utexas.edu>, pbonzini@redhat.com, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ashish.kalra@amd.com, thomas.lendacky@amd.com, 
	rick.p.edgecombe@intel.com
Content-Type: text/plain; charset="us-ascii"

On Tue, May 21, 2024, Michael Roth wrote:
> On Tue, May 21, 2024 at 07:09:04AM -0700, Sean Christopherson wrote:
> > On Mon, May 20, 2024, Michael Roth wrote:
> > > On Mon, May 20, 2024 at 04:32:04PM -0700, Sean Christopherson wrote:
> > > > On Mon, May 20, 2024, Michael Roth wrote:
> > > > > But there is a possibility that the guest will attempt access the response
> > > > > PFN before/during that reporting and spin on an #NPF instead though. So
> > > > > maybe the safer more repeatable approach is to handle the error directly
> > > > > from KVM and propagate it to userspace.
> > > > 
> > > > I was thinking more along the lines of KVM marking the VM as dead/bugged.  
> > > 
> > > In practice userspace will get an unhandled exit and kill the vcpu/guest,
> > > but we could additionally flag the guest as dead.
> > 
> > Honest question, does it make sense from KVM to make the VM unusable?  E.g. is
> > it feasible for userspace to keep running the VM?  Does the page that's in a bad
> > state present any danger to the host?
> 
> If the reclaim fails (which it shouldn't), then KVM has a unique situation
> where a non-gmem guest page is in a state. In theory, if the guest/userspace
> could somehow induce a reclaim failure, then can they potentially trick the
> host into trying to access that same page as a shared page and induce a
> host RMP #PF.
> 
> So it does seem like a good idea to force the guest to stop executing. Then
> once the guest is fully destroyed the bad page will stay leaked so it
> won't affect subsequent activities.
> 
> > 
> > > Is there a existing mechanism for this?
> > 
> > kvm_vm_dead()
> 
> Nice, that would do the trick. I'll modify the logic to also call that
> after a reclaim failure.

Hmm, assuming there's no scenario where snp_page_reclaim() is expected fail, and
such a failure is always unrecoverable, e.g. has similar potential for inducing
host RMP #PFs, then KVM_BUG_ON() is more appropriate.

Ah, and there are already WARNs in the lower level helpers.  Those WARNs should
be KVM_BUG_ON(), because AFAICT there's no scenario where letting the VM live on
is safe/sensible.  And unless I'm missing something, snp_page_reclaim() should
do the private=>shared conversion, because the only reason to reclaim a page is
to move it back to shared state.

Lastly, I vote to rename host_rmp_make_shared() to kvm_rmp_make_shared() to make
it more obvious that it's a KVM helper, whereas rmp_make_shared() is a generic
kernel helper, i.e. _can't_ bug the VM because it doesn't (and shouldn't) have a
pointer to the VM.

E.g. end up with something like this:

/*
 * Transition a page to hypervisor-owned/shared state in the RMP table. This
 * should not fail under normal conditions, but leak the page should that
 * happen since it will no longer be usable by the host due to RMP protections.
 */
static int kvm_rmp_make_shared(struct kvm *kvm, u64 pfn, enum pg_level level)
{
	if (KVM_BUG_ON(rmp_make_shared(pfn, level), kvm)) {
		snp_leak_pages(pfn, page_level_size(level) >> PAGE_SHIFT);
		return -EIO;
	}

	return 0;
}

/*
 * Certain page-states, such as Pre-Guest and Firmware pages (as documented
 * in Chapter 5 of the SEV-SNP Firmware ABI under "Page States") cannot be
 * directly transitioned back to normal/hypervisor-owned state via RMPUPDATE
 * unless they are reclaimed first.
 *
 * Until they are reclaimed and subsequently transitioned via RMPUPDATE, they
 * might not be usable by the host due to being set as immutable or still
 * being associated with a guest ASID.
 *
 * Bug the VM and leak the page if reclaim fails, or if the RMP entry can't be
 * converted back to shared, as the page is no longer usable due to RMP
 * protections, and it's infeasible for the guest to continue on.
 */
static int snp_page_reclaim(struct kvm *kvm, u64 pfn)
{
	struct sev_data_snp_page_reclaim data = {0};
	int err;

	data.paddr = __sme_set(pfn << PAGE_SHIFT);
	
	if (KVM_BUG_ON(sev_do_cmd(SEV_CMD_SNP_PAGE_RECLAIM, &data, &err), kvm)) {
		snp_leak_pages(pfn, 1);
		return -EIO;
	}

	if (kvm_rmp_make_shared(kvm, pfn, PG_LEVEL_4K))
		return -EIO;

	return 0;
}


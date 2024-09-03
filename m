Return-Path: <linux-kernel+bounces-313654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C19F96A83B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 22:23:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9DC6285593
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 20:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9213B1D0DD3;
	Tue,  3 Sep 2024 20:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="006y8Qbf"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9907D18EFDB
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 20:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725395028; cv=none; b=YABxFzN4ck5++YVQh+Zw0pav9yAPVTy65ISMcXs/1JHQbcUwRzKRt76opBXaKwQd9jqLDcu7YJ7fSM3+13sGFLRtptQIm814BEB3mo2DsBc9eQLm9eqrTIn4foLLYpNKojo2Q1ECTGnqBG51c888g3wHyYlwzZ2zNuD7WVwPsX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725395028; c=relaxed/simple;
	bh=8gOe8SgkgFl79JRNbZ1px6ikd6VAHRUETQTteZr2MG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r8zYEZRq9lTbzAE1l3D+c6kMdqYs91chWusPGbIykT/0z7QhpxjxjdYxUFt08j3YIrNTV9zGoICHrpXb9b+ipnTvdjPA2qpv1NHCj6ZlZr7ayEFQiD3guHjJQZBK0/jK2i/7nS9J1yeVHvj0efD89Z8gDaCnns36BBuv7WYWid0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=006y8Qbf; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2056aa5cefcso11675ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 13:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725395026; x=1725999826; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qbuCKGzwQIE8OQvh3Ibqt9ERvbhH85xBPEVndwdEVXI=;
        b=006y8QbfS+ddx+dL5ctIgOp/s/I6ztuARpzadBoVFuTfnsYgs1+6h/F4Cnk0hXa1w1
         swhi1Sv1Pxxpa5YFf0gelDESv+DxpNMV/hJopax9bOqTG50Ec8WETARqK5/IVPxAfqJe
         crh+lA83FhW1811iV/F0OX806jIz6/YVHNbtwUtzOb1MjNRrCwupTnfmV/xfQ3Axeg5T
         1wGPlwodaddGjL0uKU4l8TELK+baF8MTPqcmU5CGCrEaDtlsym+IEfNWbJrHh41MIsuT
         odl5uBtGRDXi7ME3ol5G670pknr6Zc/gvieiq/0lOrBZzLOv0JwPg5F0Vj8AxcVlOwxR
         /8jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725395026; x=1725999826;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qbuCKGzwQIE8OQvh3Ibqt9ERvbhH85xBPEVndwdEVXI=;
        b=htZLhKSQ2mEnCl/ItvsWX5huzZfXvdLBFZklzhPkwzOWAAqhKJLjBGNsVK3hjj7FLC
         Ujwr5ercpeqAuDqgldUEGta3DoTBd46crFJj8o5vgtfLbRgKN/OZ6P39JF/AxneB6fzW
         e1A+LYn0h1E6BFPGUH//fOFVW9h3GEcoXTuN6fo89UTjZ3Zt/KNacBCbbJPTqbBluBnb
         pGILgv1G7HEnk+U33Q8Ja9hrc9Htitx0QySmRMlKdfr7pYSrt09j11P18YFS7fEJ0xP1
         6ZMdLETdiYk1h36iUr5PNd2k0EYQzpTTpJzDCByKwcgD5pMe9zWnxFaAF7j0oHPU661l
         DbwQ==
X-Forwarded-Encrypted: i=1; AJvYcCXsX8z5N3a7+5EL3QpjfBW3XfnTpZjeMSQYST/mJy2Pp0piqy3YDbGw3FeF4kxe2FqRd6Ek76Qi//z86kw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZSaMeOX2WDBM9pr7mU6zL0Xe/O3DX9rAcKFr/cqJDewMLQSGK
	/uGXlLAgMXA3FPKothQprqeuWvsoNpjN6ed9y+tWHFlfhZ3ugOQ/+zc+ofOHBg==
X-Google-Smtp-Source: AGHT+IG1fM5PFFRTAfAeBqxcHt3GhgHnkwns3s2TeeDNrmCSJMIlcxI0UzdRK/x0l8+D8J03VvAhCA==
X-Received: by 2002:a17:902:db01:b0:1f9:dc74:6c2b with SMTP id d9443c01a7336-206b5b776aamr23665ad.29.1725395024452;
        Tue, 03 Sep 2024 13:23:44 -0700 (PDT)
Received: from google.com (176.13.105.34.bc.googleusercontent.com. [34.105.13.176])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71778522926sm279379b3a.44.2024.09.03.13.23.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 13:23:43 -0700 (PDT)
Date: Tue, 3 Sep 2024 13:23:39 -0700
From: Vipin Sharma <vipinsh@google.com>
To: Sean Christopherson <seanjc@google.com>
Cc: pbonzini@redhat.com, dmatlack@google.com, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] KVM: x86/mmu: Recover TDP MMU NX huge pages using
 MMU read lock
Message-ID: <20240903202339.GA378741.vipinsh@google.com>
References: <20240829191135.2041489-1-vipinsh@google.com>
 <20240829191135.2041489-5-vipinsh@google.com>
 <ZtDU3x9t66BnpPt_@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZtDU3x9t66BnpPt_@google.com>

On 2024-08-29 13:06:55, Sean Christopherson wrote:
> On Thu, Aug 29, 2024, Vipin Sharma wrote:
> >  		if (need_resched() || rwlock_needbreak(&kvm->mmu_lock)) {
> 
> Tsk, tsk.  There's a cond_resched_rwlock_write() lurking here.

I'm gonna order a dunce cap.

> 
> Which is a decent argument/segue for my main comment: I would very, very strongly
> prefer to have a single flow for the control logic.  Almost all of the code is
> copy+pasted to the TDP MMU, and there unnecessary and confusing differences between
> the two flows.  E.g. the TDP MMU does unaccount_nx_huge_page() preemptively, while
> the shadow MMU does not.
> 
> The TDP MMU has a few extra "locks" (rcu_read_lock() + tdp_mmu_pages_lock), but
> I don't see any harm in taking those in the shadow MMU flow.  KVM holds a spinlock
> and so RCU practically is meaningless, and tdp_mmu_pages_lock will never be
> contended since it's only ever taken under mmu_lock.
> 
> If we _really_ wanted to bury tdp_mmu_pages_lock in the TDP MMU, it could be
> passed in as an optional paramter.  I'm not super opposed to that, it just looks
> ugly, and I'm not convinced it's worth the effort.  Maybe a middle ground would
> be to provide a helper so that tdp_mmu_pages_lock can stay 64-bit only, but this
> code doesn't need #ifdefs?

How about declaring in tdp_mmu.h and providing different definitions
similar to is_tdp_mmu_page(), i.e. no-op for 32bit and actual lock usage
for 64 bit build?

> 
> Anyways, if the helper is __always_inline, there shouldn't be an indirect call
> to recover_page().  Completely untested, but this is the basic gist.
> 

One more way I can do is to reuse "shared" bool to decide which
nx_recover_page_t to call. Something like:

static __always_inline void kvm_recover_nx_huge_pages(...)
{
...
    if (!kvm_mmu_sp_dirty_logging_enabled(kvm, sp))
	if (shared)
		flush |= tdp_mmu_zap_possible_nx_huge_page(kvm, sp);
	else
		kvm_mmu_prepare_zap_page(kvm, sp, &invalid_list);

}

tdp_mmu_zap_possible_nx_huge_page() can print WARN_ONCE() and return if
shadow MMU page is passed to it. One downside is now that "shared" bool
and "pages" list are dependent on each other.

This way we don't need to rely on __always_inline to do the right thing
and avoid function pointer call.

I think using bool is more easier to understand its uage compared to
understanding why we used __always_inline. What do you think?


> ---
> typedef bool (*nx_recover_page_t)(struct kvm *kvm, struct kvm_mmu_page *sp,
> 				  struct list_head *invalid_pages);
> 
> static __always_inline void kvm_recover_nx_huge_pages(struct kvm *kvm,
> 						      bool shared,
> 						      spinlock_t *list_lock;
> 						      struct list_head *pages,
> 						      unsigned long nr_pages,
> 						      nx_recover_page_t recover_page)


Return-Path: <linux-kernel+bounces-292643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 378BF95723B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 19:35:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7B152838A9
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 17:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E9B1187FFF;
	Mon, 19 Aug 2024 17:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bO+TtUrL"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846EF17557E
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 17:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724088899; cv=none; b=CkN9wxL6E6SkU2fJqDOH2/mdGH/+F3IZ9OqXldyw1nQ9OPGVe2oOXBhBgI/kYjHS2tsyPlsyuJ6W2m/xwQCMVXoXleGcLRHC2IB0mlvZhU2IR8I07uKSQ67GolQKGGwFDKEoeCAo80fY20MX/+l53wbyfGYOBKBqsxPlO9W8Rds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724088899; c=relaxed/simple;
	bh=vnrUWXWCOxACC1SXhMDLY2OVG8VD6mjQwafYN4cxxew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EckGoew+zbX1RZ7RgEp9au1UcN29LvgtsVWCCejHSV+9O0njLqzOjU1zL9PjQO5GiWcvUmXzSFL4lCKig3R6rbtH5cyFHqv3sYD1MDhPOxWj1I6BsHo7JABkUt28aa5dabI9b6urcjBK8Qv1yfEfNrbuHRIaoz/kpsjHtGcT/M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bO+TtUrL; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-713e460f920so1274797b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 10:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724088898; x=1724693698; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hvr0J9ZuG3UW48C7b98BBRwz779hzA2BA91eRAwrF3w=;
        b=bO+TtUrL1OZ0Bde3LgPnMhLuFjT02eH5P8CXgJ0VIIkErPW/gn9tlKwY2/QQDYDTbM
         lit9c3HQ3LGbB+CqcFYVPOCwwLH5xNGWW66anQ+SZd0xWF/KfugGVvmrYWG9Led8Kx5c
         7Ue017LeJ3pMoa5G/MGNTAg5H5I4Ka4HN3IQbUro6tALwSuQ6ALc21GTrAG59rhGySjS
         mU4Lt08PKCrXKybcM5gJgbzRiJXH35/hd7mXUjPJNYsBgK6ymrMZ9E3aWYMo+yhioEyA
         hu6wfX/C50LpW973Ra6uZVZxYQ4mZunq5FIA9iFB6nEHX957ViSFNqBpbJXJol4TJ46+
         mMSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724088898; x=1724693698;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hvr0J9ZuG3UW48C7b98BBRwz779hzA2BA91eRAwrF3w=;
        b=C7PAXTzaSJprw5Yo3IOXzuZgilItW3AoHvBWy58+pjXWzUTs1+S8bACnP+VLUC9SA9
         0EzXv1KEabpdJ6x7bekW4QozR/Ilw0TCPJfzxvSyQXVvScSxUUQDJEO4kj9y2URBMgQv
         AC2Ul/XmPzxhNZc+GigaR/Bq0jBpdijvrjX2zXyXX/k8hA6ez7XEbL86F9Orr7Xb7UuY
         23sRG6uX50Ewl4viRq46m9Eo6jFegoMMIif0p1fmKHOM6G/AUkim3ATkPCUV6X1CDUOr
         kmTCo30DfjrktD98pW2wtTwDSOKSbYng2uKE+9AOygIfSHKeiC8wbJ20mvC3f9qmkSBr
         gnIw==
X-Forwarded-Encrypted: i=1; AJvYcCV9MVYDmLg5htDqufqNSPiCru36xYNq0pSXQdH3qr5zeBxf7QHYQMPSwLre+QE7exa+Bd2knShWLLwLGZEy4QBO0pyYepXTFV7hUYG1
X-Gm-Message-State: AOJu0YwxvMDL9LJg3kiVS0qAW6QvNdLbt7MEzZrChkGMSeF3cUr2grPL
	CDGoRoF06RV3P2vw0hs5Rt5QmgGgXF3CLS8bF2yB0u3SvsK7kGDVHsRfWLQTdQ==
X-Google-Smtp-Source: AGHT+IHSoVrZbK8JKRKcOoOO6pqNJPsdr5vFIHI2GSN+NXwnDc1LHQrZdggbtz7zdm7l5Hb3Ce2aKA==
X-Received: by 2002:a05:6a00:6f6a:b0:706:742a:1c3b with SMTP id d2e1a72fcca58-713c4dff651mr9673380b3a.8.1724088897429;
        Mon, 19 Aug 2024 10:34:57 -0700 (PDT)
Received: from google.com (60.89.247.35.bc.googleusercontent.com. [35.247.89.60])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127addcc5fsm6826137b3a.9.2024.08.19.10.34.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 10:34:56 -0700 (PDT)
Date: Mon, 19 Aug 2024 10:34:53 -0700
From: Vipin Sharma <vipinsh@google.com>
To: Sean Christopherson <seanjc@google.com>
Cc: pbonzini@redhat.com, dmatlack@google.com, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] KVM: x86/mmu: Recover NX Huge pages belonging to TDP
 MMU under MMU read lock
Message-ID: <20240819173453.GB2210585.vipinsh@google.com>
References: <20240812171341.1763297-1-vipinsh@google.com>
 <20240812171341.1763297-3-vipinsh@google.com>
 <Zr_i3caXmIZgQL0t@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zr_i3caXmIZgQL0t@google.com>

On 2024-08-16 16:38:05, Sean Christopherson wrote:
> On Mon, Aug 12, 2024, Vipin Sharma wrote:
> > @@ -1831,12 +1845,17 @@ ulong kvm_tdp_mmu_recover_nx_huge_pages(struct kvm *kvm, ulong to_zap)
> >  		 * recovered, along with all the other huge pages in the slot,
> >  		 * when dirty logging is disabled.
> >  		 */
> > -		if (kvm_mmu_sp_dirty_logging_enabled(kvm, sp))
> > +		if (kvm_mmu_sp_dirty_logging_enabled(kvm, sp)) {
> > +			spin_lock(&kvm->arch.tdp_mmu_pages_lock);
> >  			unaccount_nx_huge_page(kvm, sp);
> > -		else
> > -			flush |= kvm_tdp_mmu_zap_sp(kvm, sp);
> > -
> > -		WARN_ON_ONCE(sp->nx_huge_page_disallowed);
> > +			spin_unlock(&kvm->arch.tdp_mmu_pages_lock);
> > +			to_zap--;
> > +			WARN_ON_ONCE(sp->nx_huge_page_disallowed);
> > +		} else if (tdp_mmu_zap_sp(kvm, sp)) {
> > +			flush = true;
> > +			to_zap--;
> 
> This is actively dangerous.  In the old code, tdp_mmu_zap_sp() could fail only
> in a WARN-able scenario, i.e. practice was guaranteed to succeed.  And, the
> for-loop *always* decremented to_zap, i.e. couldn't get stuck in an infinite
> loop.
> 
> Neither of those protections exist in this version.  Obviously it shouldn't happen,
> but it's possible this could flail on the same SP over and over, since nothing
> guarnatees forward progress.  The cond_resched() would save KVM from true pain,
> but it's still a wart in the implementation.
> 
> Rather than loop on to_zap, just do
> 
> 	list_for_each_entry(...) {
> 
> 		if (!to_zap)
> 			break;
> 	}
> 
> And if we don't use separate lists, that'll be an improvement too, as it KVM
> will only have to skip "wrong" shadow pages once, whereas this approach means
> every iteration of the loop has to walk past the "wrong" shadow pages.

TDP MMU accesses possible_nx_huge_pages using tdp_mmu_pages_lock spin
lock. We cannot hold it for recovery duration.

In this patch, tdp_mmu_zap_sp() has been modified to retry failures,
which is similar to other retry mechanism in TDP MMU. Won't it be the
same issue with other TDP MMU retry flows?

> 
> But I'd still prefer to use separate lists.


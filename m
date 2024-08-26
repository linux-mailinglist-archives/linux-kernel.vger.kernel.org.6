Return-Path: <linux-kernel+bounces-302083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5F5A95F99C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 21:24:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BF9A281141
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 19:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A786199234;
	Mon, 26 Aug 2024 19:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sU24m04b"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789B65644E
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 19:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724700257; cv=none; b=Ajgfl3iauF2w0HXv+FWjv1pOwhvrTAjeMWC2VC4LYrbtidL4WU1Om4jy39rzA/guTXtijbCtxbXdYNjtEZE5Iagam9w8YOIeMR8Hr7iQPF2pIVL0qdRsvmay7F2VM7NcPYPkgYAVjw31hcuA60BkV1johbLZDJm5V/di9ip9V+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724700257; c=relaxed/simple;
	bh=1A+nVYG0Tb1c8dvEfK7/p1phh3Y/XKar3e86BArYU8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pJLjgYpqjkgL5727oRIwh9tXZ6ur5uwLdbkeIQIHpvRPhSwBkgymbt5jYPdVgvde93mqX/UUYLVxzPqVvHhI5P3UU62STbDwRJLxQiKO8ct0rYoSmZTf1okDs53IivT8DbqgKoF2pOxmdyEAYCyrPnFnCyd5Fhyz8WvH9xwpC0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sU24m04b; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-201fed75b38so2365ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 12:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724700256; x=1725305056; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5cAiW0RTaY38kbRY+UHtLrLxwjiEwXvtezS5fYGVIqk=;
        b=sU24m04b54hoKrISeoHh97jMaF4xoaLyN5uC7gSY4PELpfYVF6TD0O3av9KuTaPU4/
         EIH0Gy+1259ajH4U3mv5HBsayeJ46gKla+aL1zVf29NNXtVXvbbY/zlv9lIOgbt7E+XK
         Uk2Onth921wlyG9AfSXFz8T+0nVM11rvvXdEiexqHIi/sD7tz8z/vJDz5OYGif/Axucw
         y59ppumo3aREj3ygkwKn9H9u9U5qwexgkcjkx2IJ7Vox96XaP2oSlOii8nf9OedB87cP
         OTdVDwzFnBj7uqbZX849jajJsQGJH+rcJfAOTiZ9jw+dMNBseI4d66jjBxOoX+OUbYIk
         pvGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724700256; x=1725305056;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5cAiW0RTaY38kbRY+UHtLrLxwjiEwXvtezS5fYGVIqk=;
        b=IijGIrQC944GpipJMilItvlG+JP1DA/AGO7JJgC76swZKQiBmKmTvRVQdNtCttTzLF
         cFxmNPqZOzCjZG/llFB/kq8udHUfU2t04GygyFyRyt+vUNHtHCp7pY0rPwFLPjEKenK/
         nIoiF4K/pv03epIOdh7bmcSJfdOoM5e63Fiw4qpRozD/rjfuaWaVV6nneNgQloPxV4Hh
         4T6GJIbPrqAXjxkwFn/TmDJPUEY5RWYMnv6XxQoY9122MkJigUQGfHc1vxLO2NfBWPG/
         danWvR29RoVImSOeLZboS9Nc2tfFvYbhs9IoF6bMkBVWa6YxZy+UkEFghSiykDTJBt9q
         srdA==
X-Forwarded-Encrypted: i=1; AJvYcCUNEDHkzVTgNAG1zep19TCL7zCPX3YIAy4REBfginMzBffDnjSD0wyKY3PBQ4p+B1mtkp74fvUO1Cb2DuQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQghXlYUwHyS4wQWpGZ6fH253aDv+vPfDHQmjWysOhPu+ZFvLi
	aid7UKj2m0CSHHKctgqe03E991AGQE6A06LeTgDx1x6CNLBU8x50M36pF6sNSg==
X-Google-Smtp-Source: AGHT+IHQZ+zENXR4aDwLapjt+4g/L+sPziKTRAY7OHVMbgkoIp09kMb8ctJOVPxwLy2A8+zM0Wqhnw==
X-Received: by 2002:a17:902:db01:b0:1fb:52b1:27ca with SMTP id d9443c01a7336-204e19466e9mr389335ad.9.1724700255434;
        Mon, 26 Aug 2024 12:24:15 -0700 (PDT)
Received: from google.com (60.89.247.35.bc.googleusercontent.com. [35.247.89.60])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71434335fc6sm7378514b3a.199.2024.08.26.12.24.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 12:24:14 -0700 (PDT)
Date: Mon, 26 Aug 2024 12:24:10 -0700
From: Vipin Sharma <vipinsh@google.com>
To: Sean Christopherson <seanjc@google.com>
Cc: pbonzini@redhat.com, dmatlack@google.com, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] KVM: x86/mmu: Recover NX Huge pages belonging to TDP
 MMU under MMU read lock
Message-ID: <20240826192410.GA2182008.vipinsh@google.com>
References: <20240812171341.1763297-1-vipinsh@google.com>
 <20240812171341.1763297-3-vipinsh@google.com>
 <Zr_i3caXmIZgQL0t@google.com>
 <20240819173453.GB2210585.vipinsh@google.com>
 <ZsPDWqOiv_g7Wh_H@google.com>
 <20240823223800.GB678289.vipinsh@google.com>
 <ZsySe8tpDyZAvb6l@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZsySe8tpDyZAvb6l@google.com>

On 2024-08-26 07:34:35, Sean Christopherson wrote:
> On Fri, Aug 23, 2024, Vipin Sharma wrote:
> > On 2024-08-19 15:12:42, Sean Christopherson wrote:
> > > On Mon, Aug 19, 2024, Vipin Sharma wrote:
> > > Huh.  Actually, after a lot of fiddling and staring, there's a simpler solution,
> > > and it would force us to comment/document an existing race that's subly ok.
> > > 
> > > For the dirty logging case, the result of kvm_mmu_sp_dirty_logging_enabled() is
> > > visible to the NX recovery thread before the memslot update task is guaranteed
> > > to finish (or even start) kvm_mmu_zap_collapsible_sptes().  I.e. KVM could
> > > unaccount an NX shadow page before it is zapped, and that could lead to a vCPU
> > > replacing the shadow page with an NX huge page.
> > > 
> > > Functionally, that's a-ok, because the accounting doesn't provide protection
> > > against iTLB multi-hit bug, it's there purely to prevent KVM from bouncing a gfn
> > > between an NX hugepage and an execute small page.  The only downside to the vCPU
> > > doing the replacement is that the vCPU will get saddle with tearing down all the
> > > child SPTEs.  But this should be a very rare race, so I can't imagine that would
> > > be problematic in practice.
> > 
> > I am worried that whenever this happens it might cause guest jitter
> > which we are trying to avoid as handle_changed_spte() might be keep a
> > vCPU busy for sometime.
> 
> That race already exists today, and your series already extends the ways in which
> the race can be hit.  My suggestion is to (a) explicit document that race and (b)
> expand the window in which it can occur to also apply to dirty logging being off.
> 

I was not clear about vCPU doing the replacement part. I see how this
change is expanding the window.

> > 	} else {
> > 		/*
> > 		 * Try again in future if the page is still in the
> > 		 * list
> > 		 */
> > 		spin_lock(&kvm->arch.tdp_mmu_pages_lock);
> > 		if (!list_empty(&sp->possible_nx_huge_page_link))
> > 			list_move_tail(&sp->possible_nx_huge_page_link,
> > 			kvm-> &kvm->arch.possible_nx_huge_pages);
> 
> This is unsafe.  The only thing that prevents a use-after-free of "sp" is the fact
> that this task holds rcu_read_lock().  The sp could already been queued for freeing
> via call_rcu().

Before call_rcu() happens, that page will be removed from
kvm->arch.possible_nx_huge_pages list in handle_remove_pt() via
tdp_mmu_unlink_sp() using kvm->arch.tdp_mmu_pages_lock. Here, we are
using the same lock and checking if page is in the list or not. If it is
in the list move to end and if it is not then don't do anything.

Am I missing something else? Otherwise, this logic seems correct to me.

Overall, I will be using your example code, so you won't see this code
in next version but just want to understand the concern with this else
part.

> 
> > 		spin_unlock(&kvm->arch.tdp_mmu_pages_lock);
> > 	}
> > 
> > 	/* Resched code below */
> > }


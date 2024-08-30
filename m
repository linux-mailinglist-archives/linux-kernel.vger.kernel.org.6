Return-Path: <linux-kernel+bounces-309218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE9FC9667A3
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 19:09:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F16BC1C2317B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 17:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 793FA1BA86D;
	Fri, 30 Aug 2024 17:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D/63zj5w"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C30F13BAF1
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 17:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725037774; cv=none; b=PKhiHzwK/HVHWshzIsfwbpvvaxEjJlCt/tlTOX6wb9e+YLd3btasp0d97fycDwqjTT1113FZfIcevPANxZg7ul/EfasEeXfjZMBNQMzwefpgItXaOrUlgHjWK1v3vCrkcIMi5ea7H+lH5MFeAWmIvsHbuJACLxKgvxECqFZ5j/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725037774; c=relaxed/simple;
	bh=CU346vDOqsSTaU3Zni7xFPxbjTXZB+6lE4+IxGvIin4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GfQJCeW63RcdrZw92SEVtFTiRA4zDzT3nLJekeRri2jf7RbttDouBsN5jgbytuZklSNQYx9nbxb0788ZI2yxEuDBzsbdHJurlsL3D3jlPSoo8o7rmxhGMc75STngHZks7I8wL7MiQFzX+iSWh3qE5gUrRl3cMNMHULbk/H449YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D/63zj5w; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7141d43582cso2128208b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 10:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725037773; x=1725642573; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U/DqUd03uLisJ+lBV6coVazHA/8Mv1E9hChZqzhDQx4=;
        b=D/63zj5wPjlolrfCsivNV3IWEtLug/VbFwPjgd4Grl18gAGH3T2yFT23KhktRRXjk9
         JNObrTVBsWDh3K4fZwVuVBXouFNXdEmpf7bcZ9eaxH4OVVxB3fWwwnqmUedwTpxlPG1L
         jbCN2F7z8ucVzrTmBUs6VbheAYNk1JTLRsppP9oBB/pG1y/BhlcD1SRUPeUaKGM2zvHo
         U6+BSkUsl3B5IH4+V5z43Kr9VfNu930FEiMp8jaM+9r1vvYpPMcmUHhsNpBwSY5rpleV
         6cHYGfjLB8bCH30xmM4MYmwHq4UswAPNM+y9d01owjKSF3bCkVVl3HUibHjRd3qimz8U
         QvGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725037773; x=1725642573;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=U/DqUd03uLisJ+lBV6coVazHA/8Mv1E9hChZqzhDQx4=;
        b=AOhlF0cKmgKDg/64Fb7A3/0DMPrJOVtyP+9DjOFvSrmX37WYMzcmBWSrzIepjR1UvU
         eGBWUa3hMIRmDR8sIyEyuPmmjNmNhGFXkguFOorRK53RbBC9lEPOqFq4hZUTn7cVM8+g
         N4zKx7g+PrV6sa54eP3tTqUoyJoiyfj7UPzl8bAUzRV+3FUFkHet6gXTJqszgpEX/2Lw
         hnLfRWuNxaAeZpUy3OfvpGvThrY9RHySvWIs/syMjAJTjbfFgV2hD1EpK9ETtVjjc+JT
         W1yyzOKM1OsLdet/+KIs3jdmlc/FgNUR3HBJVaOZ5AX+JqRTwcr65ByqAG1wbtaJZKkl
         0ydQ==
X-Forwarded-Encrypted: i=1; AJvYcCWjhRJeXvxbCvOcjuInrURzTQIOD5zZ/oDJT5aYlb0KjiIlw0I86iK+XjfvoqHslX+naFoRYBdUFHV45gc=@vger.kernel.org
X-Gm-Message-State: AOJu0YycPAdFFyIZ4i2ySXojWuTa2Opm3RhGm/I7uGBC2YZDsFXUyfOZ
	qP36WboUumweVwBeHPvqumFu4v0OS0KmH5yCA/S1hamS5xogLTW99fcYS096ciHnQhBLmDAraZS
	mAQ==
X-Google-Smtp-Source: AGHT+IFFKP/thrpWlcd7MMBTCnnTgAMVFprrx6gPBFzwzuc79yk0sgtRNBZcK7vPcXyz945EdY+xAc0UhR8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:9467:b0:714:24bf:eaf5 with SMTP id
 d2e1a72fcca58-717307852dcmr5463b3a.5.1725037772263; Fri, 30 Aug 2024 10:09:32
 -0700 (PDT)
Date: Fri, 30 Aug 2024 10:09:30 -0700
In-Reply-To: <20240830124720.GX3468552@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240724011037.3671523-1-jthoughton@google.com>
 <20240724011037.3671523-3-jthoughton@google.com> <Zr_3Vohvzt0KmFiN@google.com>
 <CADrL8HWQqVm5VbNnR6iMEZF17+nuO_Y25m6uuScCBVSE_YCTdg@mail.gmail.com>
 <ZtFA79zreVt4GBri@google.com> <20240830124720.GX3468552@ziepe.ca>
Message-ID: <ZtH8yv5AabMEpBoj@google.com>
Subject: Re: [PATCH v6 02/11] KVM: x86: Relax locking for kvm_test_age_gfn and kvm_age_gfn
From: Sean Christopherson <seanjc@google.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: James Houghton <jthoughton@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, Ankit Agrawal <ankita@nvidia.com>, 
	Axel Rasmussen <axelrasmussen@google.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	David Matlack <dmatlack@google.com>, David Rientjes <rientjes@google.com>, 
	James Morse <james.morse@arm.com>, Jonathan Corbet <corbet@lwn.net>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Raghavendra Rao Ananta <rananta@google.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Shaoqin Huang <shahuang@redhat.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Wei Xu <weixugc@google.com>, 
	Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	kvmarm@lists.linux.dev, kvm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 30, 2024, Jason Gunthorpe wrote:
> On Thu, Aug 29, 2024 at 08:47:59PM -0700, Sean Christopherson wrote:
> > On Thu, Aug 29, 2024, James Houghton wrote:
> > > On Fri, Aug 16, 2024 at 6:05=E2=80=AFPM Sean Christopherson <seanjc@g=
oogle.com> wrote:
> > > > > +static __always_inline bool kvm_tdp_mmu_handle_gfn_lockless(
> > > > > +             struct kvm *kvm,
> > > > > +             struct kvm_gfn_range *range,
> > > > > +             tdp_handler_t handler)
> > > >
> > > > Please burn all the Google3 from your brain, and code ;-)
> > >=20
> > > I indented this way to avoid going past the 80 character limit. I've
> > > adjusted it to be more like the other functions in this file.
> > >=20
> > > Perhaps I should put `static __always_inline bool` on its own line?
> >=20
> > Noooo. Do not wrap before the function name.  Linus has a nice explanat=
ion/rant
> > on this[1].
>=20
> IMHO, run clang-format on your stuff and just be happy with 99% of
> what it spits out. Saves *so much time* and usually arguing..

Heh, nope, not bending on this one.  The time I spend far hunting for imple=
mentations
because of wraps before the function name far exceeds the time it takes me =
to
push back on these warts in review.


Return-Path: <linux-kernel+bounces-307857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A62AB965408
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 02:35:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D95B31C221E6
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 00:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5EBD4A32;
	Fri, 30 Aug 2024 00:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MDmnWAng"
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B131E3224
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 00:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724978092; cv=none; b=XJNUispG0q6rbPkVB3zSP2KMFxG4qWUB8Ytk8pA8MhwkGtF2YwLTT3uAJdDerguCueQo1Jy5rXBrWr38mulxsc2bc/NRwqAsVQmBTPdlPBajdcEUnAJuShjfHiMW5zVCykwIOA/M3S4wnURhrQucdLr+9EScWh1MM3uef6KgelQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724978092; c=relaxed/simple;
	bh=FqpnbV2f9pzqLhpgsHuN0fCsazH+X/gkpf6dLbPjAVo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AHvBol5yYe5hJ9envIpQU6lmV8LCBCxALeMTOJiSFBk2OLcBdJnj4LEggiCZa8DZ/50w1gK3vaPMo21ocZkxskHiZimqzoFznMm3r40yCp3GpyZzgwRk2ruCyxoL+TBagL9KMKW+fZ2LVKn4RUzc7kkYYNXfXYKs6BU5uf2VP1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MDmnWAng; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6b8d96aa4c3so10834997b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 17:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724978089; x=1725582889; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ScuyZghAxUsq77xlIUmB3FT5rIh3r/8m9ZVZaLG04YU=;
        b=MDmnWAngL+nP73hzjjGKxpceEJdM8OWOTpTgpjSmyW0UaKUesZu3hB2zTJNwQmijRW
         RXyM860vWZyJ6YXD/fJrbR7SLtAd+XxwZMntcu2IKITfj5G1/cCBoVBJgRWPeCzeLRWV
         AYroBUfc2cTinfa3XrpjakCY2EF6JOU4jAIJCUWux4KFKTs3LN3jh4vnUfvgN7gJoHAq
         k7b7PeX0xpEy4zHd2WIMhkSv7m78+GptqGcsWHl971cA3yHTr14zWPZwUWIgF4eTc4nU
         XNiyq/A7gEnR7q5o5F1+79jS0GsBExfhhvYPFyKgd2ufZ+KyZeYMZYtCfkykO4KmSnbJ
         2a+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724978089; x=1725582889;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ScuyZghAxUsq77xlIUmB3FT5rIh3r/8m9ZVZaLG04YU=;
        b=BIdhH7zy88sfQ0Bd0tVTzWjo2BM6lAz2bpyB/53oCfsnrQBXOQqzcnO1UqKsKeoX/k
         0ShIvr7oioCyFmW2EDVT9Ns/P4A88fIHFMBLfctk3yomVTWm7rPmzG17jKmUY1c68bst
         mK/g2NbF5ESR3ULXRsGgbziYVAlqS0+SjjNgKPKGs6YjsgciFuQAQ+3dqtFXadJZoD/1
         zTNw/I9PM0nGhHKWifP464cDyVFI3oSbRMH79afrGYzg7xgX6EFd4aeKkTFiqOkFBJX4
         q+hLvyKqIRCrX7N7SR7PF1Od94aG8JZysQWKb2C3U96KWzvB/CfXJF2ybb6oQGSI6pih
         GVRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVzOfWShFAK3AXTQUN88zsZ+XCQqS1nDSiZj+yFLPChx81uvhSXeM01GqO6xSqh1t6H1mEPHSnN38MgYLk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7kCy62I0l65CSVRwpWcQLR4rHMBVZH0rQIeKqZnha7zlcsqrQ
	8OUaqzlXaf050/lqIEyzG8S8tCSTfSdKSJbrhg+t0NzyQdXDmk2puyZpExuXX8qqvzr5GoX+UCv
	OYaVqxt9Om7GEduIRhmnl/sJkW2Sp+vq77F8E
X-Google-Smtp-Source: AGHT+IEHfgQ7ITmpC9nLKgn2p9q5pKXn+MuPyh1yHF6iMxunaqm5ZCNB9dh715WRCvs589w6aHZcopQzVWBPqtznylA=
X-Received: by 2002:a05:690c:7409:b0:6ae:d19f:8b62 with SMTP id
 00721157ae682-6d40ff0ca84mr4280747b3.43.1724978089470; Thu, 29 Aug 2024
 17:34:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240724011037.3671523-1-jthoughton@google.com>
 <20240724011037.3671523-9-jthoughton@google.com> <ZqKWxfqRoJzUWroG@google.com>
 <Zr_2Qhflx5xBhFCY@google.com>
In-Reply-To: <Zr_2Qhflx5xBhFCY@google.com>
From: James Houghton <jthoughton@google.com>
Date: Thu, 29 Aug 2024 17:34:13 -0700
Message-ID: <CADrL8HXnV8cmpytBSvGPvqvhjryWwT__MwWLbjzxX6hbd2UxFQ@mail.gmail.com>
Subject: Re: [PATCH v6 08/11] KVM: x86: Optimize kvm_{test_,}age_gfn a little bit
To: Sean Christopherson <seanjc@google.com>
Cc: David Matlack <dmatlack@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, Ankit Agrawal <ankita@nvidia.com>, 
	Axel Rasmussen <axelrasmussen@google.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	David Rientjes <rientjes@google.com>, James Morse <james.morse@arm.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Jonathan Corbet <corbet@lwn.net>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Raghavendra Rao Ananta <rananta@google.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Shaoqin Huang <shahuang@redhat.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Wei Xu <weixugc@google.com>, 
	Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	kvmarm@lists.linux.dev, kvm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 16, 2024 at 6:00=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Thu, Jul 25, 2024, David Matlack wrote:
> > On 2024-07-24 01:10 AM, James Houghton wrote:
> > > Optimize both kvm_age_gfn and kvm_test_age_gfn's interaction with the
> >
> > nit: Use () when referring to functions.
> >
> > > shadow MMU by, rather than checking if our memslot has rmaps, check i=
f
> > > there are any indirect_shadow_pages at all.
> >
> > What is optimized by checking indirect_shadow_pages instead of
> > have_rmaps and what's the benefit? Smells like a premature optimization=
.
>
> Checking indirect_shadow_pages avoids taking mmu_lock for write when KVM =
doesn't
> currently have shadow MMU pages, but did at some point in the past, where=
as
> kvm_memslots_have_rmaps() is sticky and will return true forever.

Thanks for the clear explanation.

> > > Also, for kvm_test_age_gfn, reorder the TDP MMU check to be first. If=
 we
> > > find that the range is young, we do not need to check the shadow MMU.
> >
> > This should be a separate commit since it's a logically distinct change
> > and no dependency on the other change in this commit (other than both
> > touch the same function).

Done.

> > Splitting the commits up will also make it easier to write more specifi=
c
> > short logs (instead of "optimize a little bit" :)
>
> +1.  Especially code movement and refactoring, e.g. factoring out
> tdp_mmu_clear_spte_bits_atomic() would ideally be in a standalone patch t=
hat's
> dead simple to review.

I have now split out the creation of tdp_mmu_clear_spte_bits_atomic()
into its own patch. Though I'm not entirely convinced splitting out
every refactor like that is always a good thing.


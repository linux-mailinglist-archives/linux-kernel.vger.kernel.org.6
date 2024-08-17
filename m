Return-Path: <linux-kernel+bounces-290475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CAAF795545D
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 02:46:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1187D1C21559
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 00:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 968DE33F7;
	Sat, 17 Aug 2024 00:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qq7egttM"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827FF65C
	for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2024 00:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723855599; cv=none; b=glGmY/wU96RoiiQB7TB7Dvzly0tZHuFJk3qOh32ekH0seEvp+74AWz/FMP57vM1PcRkGbdvqtz+uN/xDP52hDjt88fztpZ34d41R8lj1lerC71W5QbkHLfn7tAWYDlrrIfH7r7IvghAdHQm1TxZH5Mwzon0mCXI76Uzens0paa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723855599; c=relaxed/simple;
	bh=bb1MWnkDkGldXADxQf3JhyfD+gBzbYqcRmbOgpBPRRw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CIMuI05O9S3op7cKvPkwV4AnAJgkY3v5uKY5I5pHJ9WMWs/udqxD7ia+Q/W/4dFhBhEXHHZ4Vy5vU1vXexRGAXnyGCxqCTdQA5IFIZ1ZXOcdLmmFwuwuEdKn6UfizxmP5tlvOwzZbXLsXnOBHztuadVTojoPRqOk4KBE/IcGOhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qq7egttM; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2d40752d653so290098a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 17:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723855598; x=1724460398; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pUVcDB/UhVzyJRPGgEdwjLq8K5rZucutDkBEkag+mUI=;
        b=qq7egttMsILHjzkAjNf4ddTpyCt/A5hQinyzmDreKFmjxMTVSjK7+AzhogW731Y4Rt
         dMQLEuZDVVwShl96EyIpFy4Kz/LAHHP36dy7Sr1pDpBcgoEwu9rhmaqDfxC4sMl5fk0X
         33T8wlG4wWHvrHNGkuYQHIybbGiFCREQlEHJxfb3DyCjVmrfysfkNP7yXQx8GslrBzmD
         Ozh4pfeZ/85lNYBeQC+a85juLqIdB668jplcwAL3zWLb2XUdYY1PfQKw6KHGJQgeYJSV
         aKkwZi3bTACi7tMaTySwBz+T2v5xd/EorX9VYUAI0NqO3mSryKCOdNhfGl4LXLNr6J1W
         oAMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723855598; x=1724460398;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pUVcDB/UhVzyJRPGgEdwjLq8K5rZucutDkBEkag+mUI=;
        b=v5Ztrum4Wa0elxX2qpG+xUhEP1KKvAnQ8XGM5axQspwydsQ+sh514cAOqMSgUddIRu
         4kjR0gTGhtiyRlQmF4i0APYVvJAoh34K0pySQItaATDuCyJPcoS21yZAQ42B/TejZQps
         +/pE/XweeWYhA36pk6I1qLvyFNz9qfEPo65KonqAEh4zjR4df6Xo30jP6Eu3Qk3QBvsR
         Ew2HdOr/AfmyqWScUx8LUvNY5XMSTBrm8ZiedFeQ9yXag8nZPe1BHtHVF0EgQ7ajBM+t
         2J75vrJ55NA+5B8Dy8yCMQFAWxacXKintA21QTmlAdi/OpYl/2TY9GP9yVyJWDh0y851
         5SwA==
X-Forwarded-Encrypted: i=1; AJvYcCUbfdn1hf46coP3HphY6EVn8GkdrJTsv7hIWjOYRl8rTljwHGjsKgISC0uKXz0ETzMohTU4T8VYa0NS27u0khbjPRDVvOoLBVINhJKw
X-Gm-Message-State: AOJu0Yx21LnTzXOHwSqsIpC2ONZYxD4PQDlbKbbD3Axu+40vN9aBFv7W
	3WUlELxxVVsZqkf0hkbkN8CFb6vdxaVsnf/kYMj7UYOd53M/gUN9TuMhKcjfJpDXP+chempAPag
	HXw==
X-Google-Smtp-Source: AGHT+IF8ePhNFPsi5W3jK4xS3om0njOksRe8S5j87v+OHTQjcpd6pz36Ai21gNWSPDXmyrWg15yLm3dMmPg=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90b:fcb:b0:2d3:c00d:b362 with SMTP id
 98e67ed59e1d1-2d3dfc1310cmr13127a91.1.1723855597709; Fri, 16 Aug 2024
 17:46:37 -0700 (PDT)
Date: Fri, 16 Aug 2024 17:46:36 -0700
In-Reply-To: <CADrL8HV5M-n72KDseDKWpGrUVMjC147Jqz98PxyG2ZeRVbFu8g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240724011037.3671523-1-jthoughton@google.com>
 <20240724011037.3671523-4-jthoughton@google.com> <CADrL8HV5M-n72KDseDKWpGrUVMjC147Jqz98PxyG2ZeRVbFu8g@mail.gmail.com>
Message-ID: <Zr_y7Fn63hdowfYM@google.com>
Subject: Re: [PATCH v6 03/11] KVM: arm64: Relax locking for kvm_test_age_gfn
 and kvm_age_gfn
From: Sean Christopherson <seanjc@google.com>
To: James Houghton <jthoughton@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Ankit Agrawal <ankita@nvidia.com>, Axel Rasmussen <axelrasmussen@google.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, David Matlack <dmatlack@google.com>, 
	David Rientjes <rientjes@google.com>, James Morse <james.morse@arm.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Jonathan Corbet <corbet@lwn.net>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Raghavendra Rao Ananta <rananta@google.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Shaoqin Huang <shahuang@redhat.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Wei Xu <weixugc@google.com>, 
	Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	kvmarm@lists.linux.dev, kvm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 25, 2024, James Houghton wrote:
> On Tue, Jul 23, 2024 at 6:11=E2=80=AFPM James Houghton <jthoughton@google=
.com> wrote:
> >
> > Replace the MMU write locks (taken in the memslot iteration loop) for
> > read locks.
> >
> > Grabbing the read lock instead of the write lock is safe because the
> > only requirement we have is that the stage-2 page tables do not get
> > deallocated while we are walking them. The stage2_age_walker() callback
> > is safe to race with itself; update the comment to reflect the
> > synchronization change.
> >
> > Signed-off-by: James Houghton <jthoughton@google.com>
> > ---
>=20
> Here is some data to show that this patch at least *can* be helpful:
>=20
> # arm64 patched to do aging (i.e., set HAVE_KVM_MMU_NOTIFIER_YOUNG_FAST_O=
NLY)
> # The test is faulting memory in while doing aging as fast as possible.
> # taskset -c 0-32 ./access_tracking_perf_test -l -r /dev/cgroup/memory
> -p -v 32 -m 3
>=20
> # Write lock
> vcpu wall time                : 3.039207157s
> lru_gen avg pass duration     : 1.660541541s, (passes:2, total:3.32108308=
3s)
>=20
> # Read lock
> vcpu wall time                : 3.010848445s
> lru_gen avg pass duration     : 0.306623698s, (passes:11, total:3.3728606=
88s)
>=20
> Aging is able to run significantly faster, but vCPU runtime isn't
> affected much (in this test).

Were you expecting vCPU runtime to improve (more)?  If so, lack of movement=
 could
be due to KVM arm64 taking mmap_lock for read when handling faults:

https://lore.kernel.org/all/Zr0ZbPQHVNzmvwa6@google.com


Return-Path: <linux-kernel+bounces-290482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93043955478
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 03:04:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6FFA1C2228C
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 01:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE1C94C6C;
	Sat, 17 Aug 2024 01:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4xmK5PRf"
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0A02107
	for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2024 01:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723856650; cv=none; b=gSXfT2t8wx771+JuqxT3A6VyfrfnRvOtwtH7pRzL5aQ1V9OwOuNwceOZ85vCqc73tAn08lnUUGC30U95gLCxq5hTe4FXn3eTP8Eg+Aoq472bfRnk5622/RXDVjIkPU8alI92ln+cMJiK5iImnultJMLhRoK3BqwS3bc/J/WSI/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723856650; c=relaxed/simple;
	bh=WCZrkUgQEbVisIjIvmosSf/ZV8hiR799Km9gEhjpk4c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tatDYEZzgcc3jZWWpHK0Rucokp732F3SkYh1d3OenecWqyQ6+jgNBSTETh1S7ziVj+TGf5JALN2hyUreNtX0jjOPZplj8XI/QF2sfeTHdMoHR0fI20eAulU9YGDhwKM7NXcnXVRcBIC7d61eKEYAVQtjFGrdhphuHsBJmL2+cOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4xmK5PRf; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-492aae5fd78so882654137.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 18:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723856646; x=1724461446; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ZkT/FAH8t+UEeZZlsBiF2qoKJwELVKvUU9sus3nhBA=;
        b=4xmK5PRfQGsNo+nxrwxz8aY1iYGRXPtVlq8baI3aoUD9R3OWg46iBoVhwzvvuIux0v
         QusATmhFV78vsqVrhH1vGOUQ2FreuixmS1jxylHXWPqq4Pl5Lf6c2XDpSAPhCyo2k0gJ
         jVUrv7cs5JvNlp8yEXcj77XjhzbY3IGxeqy6Alz0PpZ7uX+p8E/+VqnGbzsrDVPdYCbZ
         LeRwvVrOViZ1AJSjGraWjr8yJ9xz9XKVfhy/IKdNxhC8HqUh+eAqqAZC3c4pyk8I7jVK
         Q/5glxwLFTPOVZ+kZtfGp2S0cnYhB5ayWx3LcgTYK4aKYNxdvjdYHivRtAPLGmPyx7HG
         H7/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723856646; x=1724461446;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1ZkT/FAH8t+UEeZZlsBiF2qoKJwELVKvUU9sus3nhBA=;
        b=PhXQVMfDJl7lTlw91NwYlP4K3xiFnNHXHdFes+gfCQorLO9Grr+Vof+K4CtwP7zR7I
         2yEH92/e91g4z4BolTeaF6FiP4m0+28tDGgouSHZLa8jM+xqsrvMZvaL9jXHAVQriFpz
         4YdqznEoLd8KgR9pMuVRCAylIFCzP3gkD/MBYDwWbE4Qb7YaczxQblgxA9TYngLt2wMO
         ICzCpKA535jIsLWoqw9qmU8nkP1Cuwsg9lSBSemTbQKniYUge9nJi4HIVZ3y7inn7/pJ
         VFcTgTmnQDc4L5pgVtETPmCuNXwl0XoKGUfSTujoDxGtYrtAxRL5J6p6HLtnicHxX7GL
         slWw==
X-Forwarded-Encrypted: i=1; AJvYcCUQ/PxKSZN/2tshUGO8+j4qMJuQSxJ2uWqYMrxLm5/c6TG5vl2yEUjGdsjJH9Pf7UT1+6LR+w9PjJg4Kjgls1ozC2jfuuPwhsFXqtYP
X-Gm-Message-State: AOJu0Ywr/JkhpMLOihDuAifI1lAwxXahEAmDEEVrDMbRC6WbXI/nG5rW
	022MEgX+bQckC13f5Gyu/yG91Aw1DsR8fkTDpzzGLyR1YSkJmK44lbxLtcB6oqV/pRJrLnJhYfH
	y1bCbTEFmJL7YI9x1OLineBKaukcnUiUKzFFe
X-Google-Smtp-Source: AGHT+IH+z/yVUCGn/kvsFe3FWe5Y4PrsBx6c3aNhHuqGExQKF6hhvvYIWba1m2Vl5PvAw0UlZYeqJffhxIB+o44gihE=
X-Received: by 2002:a05:6102:3e85:b0:48f:e7c2:1faf with SMTP id
 ada2fe7eead31-497799a0eb9mr6016565137.28.1723856645893; Fri, 16 Aug 2024
 18:04:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240724011037.3671523-1-jthoughton@google.com>
 <20240724011037.3671523-4-jthoughton@google.com> <CADrL8HV5M-n72KDseDKWpGrUVMjC147Jqz98PxyG2ZeRVbFu8g@mail.gmail.com>
 <Zr_y7Fn63hdowfYM@google.com>
In-Reply-To: <Zr_y7Fn63hdowfYM@google.com>
From: Yu Zhao <yuzhao@google.com>
Date: Fri, 16 Aug 2024 19:03:27 -0600
Message-ID: <CAOUHufYc3hr-+fp14jgEkDN++v6t-z-PRf1yQdKtnje6SgLiiA@mail.gmail.com>
Subject: Re: [PATCH v6 03/11] KVM: arm64: Relax locking for kvm_test_age_gfn
 and kvm_age_gfn
To: Sean Christopherson <seanjc@google.com>
Cc: James Houghton <jthoughton@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, Ankit Agrawal <ankita@nvidia.com>, 
	Axel Rasmussen <axelrasmussen@google.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	David Matlack <dmatlack@google.com>, David Rientjes <rientjes@google.com>, 
	James Morse <james.morse@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Jonathan Corbet <corbet@lwn.net>, 
	Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Raghavendra Rao Ananta <rananta@google.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	Shaoqin Huang <shahuang@redhat.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Wei Xu <weixugc@google.com>, Will Deacon <will@kernel.org>, Zenghui Yu <yuzenghui@huawei.com>, 
	kvmarm@lists.linux.dev, kvm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 16, 2024 at 6:46=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Thu, Jul 25, 2024, James Houghton wrote:
> > On Tue, Jul 23, 2024 at 6:11=E2=80=AFPM James Houghton <jthoughton@goog=
le.com> wrote:
> > >
> > > Replace the MMU write locks (taken in the memslot iteration loop) for
> > > read locks.
> > >
> > > Grabbing the read lock instead of the write lock is safe because the
> > > only requirement we have is that the stage-2 page tables do not get
> > > deallocated while we are walking them. The stage2_age_walker() callba=
ck
> > > is safe to race with itself; update the comment to reflect the
> > > synchronization change.
> > >
> > > Signed-off-by: James Houghton <jthoughton@google.com>
> > > ---
> >
> > Here is some data to show that this patch at least *can* be helpful:
> >
> > # arm64 patched to do aging (i.e., set HAVE_KVM_MMU_NOTIFIER_YOUNG_FAST=
_ONLY)
> > # The test is faulting memory in while doing aging as fast as possible.
> > # taskset -c 0-32 ./access_tracking_perf_test -l -r /dev/cgroup/memory
> > -p -v 32 -m 3
> >
> > # Write lock
> > vcpu wall time                : 3.039207157s
> > lru_gen avg pass duration     : 1.660541541s, (passes:2, total:3.321083=
083s)
> >
> > # Read lock
> > vcpu wall time                : 3.010848445s
> > lru_gen avg pass duration     : 0.306623698s, (passes:11, total:3.37286=
0688s)
> >
> > Aging is able to run significantly faster, but vCPU runtime isn't
> > affected much (in this test).
>
> Were you expecting vCPU runtime to improve (more)?  If so, lack of moveme=
nt could
> be due to KVM arm64 taking mmap_lock for read when handling faults:
>
> https://lore.kernel.org/all/Zr0ZbPQHVNzmvwa6@google.com

For the above test, I don't think it's mmap_lock -- the reclaim path,
e.g., when zswapping guest memory, has two stages: aging (scanning
PTEs) and eviction (unmapping PTEs). Only testing the former isn't
realistic at all. IOW, for a r/w lock use case, only testing the read
lock path would be bad coverage.


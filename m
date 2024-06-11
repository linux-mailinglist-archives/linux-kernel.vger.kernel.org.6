Return-Path: <linux-kernel+bounces-210583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EBAE9045D9
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 22:40:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CABC2862EE
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 20:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADDC91527A3;
	Tue, 11 Jun 2024 20:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CXhBu0FG"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8061514F5
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 20:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718138389; cv=none; b=c3Lr6hVD4h2qEp0LqnAeijHuVX81PkJJkSr0QoN1+hxbzzYFTNLYfUilx+t5JX0su+tWjBAnimAk3PtSn0k59L8Gqnu+Y141JGzomQFNutdqAKruTiWL/e46h3b/6HbnHlhTuF38TCLt+8zVzKup59f/OELL9nZ+R3kDatIPO1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718138389; c=relaxed/simple;
	bh=Uwv7P+rpbL3D4lWasBXzA1FdWhb0FlRL25Aj/PT5ky8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RVfU/tGl9Bs65nkhaYxGXUxsxhjzmDDtnlGRbnMHG+WcXYCGjwVtF7iwAxN8SFUhjpmUZxViZXE+V1Vv/4eTU6Biiz20H/sJ/w1s9CACXhMkvjS8Wv+jFEKDP84flTjhZhfLEBK4fKpJu5u4akTson5v/rHJ1fnaLbWySWzNSM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CXhBu0FG; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42175bce556so2305e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 13:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718138386; x=1718743186; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uwv7P+rpbL3D4lWasBXzA1FdWhb0FlRL25Aj/PT5ky8=;
        b=CXhBu0FGXtgkEy11Lid9NMC8XBoNUxYHMTPO6jBo++AeJc0N3ZfzjG5XZA/oSwkTrS
         9oKifm8BtLS/DBWdQUhPiZeNED376lnnSrm0JiihIroSRDqw8tbHecBhCtFTT7VmvPRs
         x953xeSAypdHU5GFF4krzn2U2ZDebziXyX6oFkFdo2wzudqFEMd2XFXQnD7WrV0EFHNT
         1QsD2GhtXvlNKXYUeuHq6yuiVigCl/3l9hW/6tOOdAxnx/RmfEOaXaMbmmEuotnVlPZL
         VinPFecKQxaQF1fQYx0pfzv9UN8A6Zyz/xtJlOyaY8iSK43y1YqX4WQcDH1ogIp7/MLu
         grtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718138386; x=1718743186;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uwv7P+rpbL3D4lWasBXzA1FdWhb0FlRL25Aj/PT5ky8=;
        b=IPfnzCl+slXBTR5/rpbFYmGLdzni1jMiouxPnpKojwEYWeSmdrfiZyYLwSGHmuC5cu
         YGRbSMPdq02a/JKJo9t55GjPja/4DsqhN0ozFQZ2wOXulf4EKZ1sM6RPTFdUeQl2ngMw
         5uIjhBNxIm8doAaicQqEgvj7myBFGY2QOLoKcMwrDPJZF94Bk93E8fnbEl1gfwX4lqja
         S4beFoOzcTgKva4oCdsrZFX9QpfPfomjUROnidBebCx6mwqfuvlLMYZPkdUN7tvbQfrm
         ctdOxv3cl+Upo1bnaXuaazGrLGuO6cWoxIHlmXxQm5xDrYFNK11bm+jKzWN9pDpbu9m3
         FuBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWlx72mMVjW/vz1QxqAjlRDvCZwHtBDFRxb22o/HOmuMWQbxH+5ry1NRxKmtyNCZeLppv323OJE1XwzZBDPg5yxY16Cto/FJ5EeD0uy
X-Gm-Message-State: AOJu0Yx7Y6P25Jd5EqujTah5BQXSshvx99nk42UrEkONejqZ9OSStQ80
	obEsGfo4tFKlp2rNM1JXB8Vo94GshMqcB90TIYlHEAxSymaJ/SIJ9eU/w39aT0sOUs0DFqARYQr
	tKVpv88+5I0iXSYBb56ck/lmbLoVpL+hrZR3J
X-Google-Smtp-Source: AGHT+IH+CbdX5Jd916IabrKfbqeWvGCL7LL9WXw1sJsxc+uDAViKu6aEHqBlAMyLtMyJTX4kNPtqpJKHeoLv1yDsgn0=
X-Received: by 2002:a05:600c:3d0a:b0:41a:444b:e1d9 with SMTP id
 5b1f17b1804b1-42281b927b6mr453365e9.4.1718138385453; Tue, 11 Jun 2024
 13:39:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240611002145.2078921-1-jthoughton@google.com>
 <20240611002145.2078921-5-jthoughton@google.com> <CAOUHufYGqbd45shZkGCpqeTV9wcBDUoo3iw1SKiDeFLmrP0+=w@mail.gmail.com>
 <CADrL8HVHcKSW3hiHzKTit07gzo36jtCZCnM9ZpueyifgNdGggw@mail.gmail.com>
In-Reply-To: <CADrL8HVHcKSW3hiHzKTit07gzo36jtCZCnM9ZpueyifgNdGggw@mail.gmail.com>
From: Yu Zhao <yuzhao@google.com>
Date: Tue, 11 Jun 2024 14:39:07 -0600
Message-ID: <CAOUHufbRhAXXNtvGaYiGM2jkhGAeiFR7n0kSUZJ3ixQen=d4LQ@mail.gmail.com>
Subject: Re: [PATCH v5 4/9] mm: Add test_clear_young_fast_only MMU notifier
To: James Houghton <jthoughton@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Ankit Agrawal <ankita@nvidia.com>, Axel Rasmussen <axelrasmussen@google.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, David Matlack <dmatlack@google.com>, 
	David Rientjes <rientjes@google.com>, James Morse <james.morse@arm.com>, 
	Jonathan Corbet <corbet@lwn.net>, Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Raghavendra Rao Ananta <rananta@google.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	Sean Christopherson <seanjc@google.com>, Shaoqin Huang <shahuang@redhat.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Wei Xu <weixugc@google.com>, 
	Will Deacon <will@kernel.org>, Zenghui Yu <yuzenghui@huawei.com>, kvmarm@lists.linux.dev, 
	kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 11, 2024 at 10:50=E2=80=AFAM James Houghton <jthoughton@google.=
com> wrote:
>
> On Mon, Jun 10, 2024 at 10:34=E2=80=AFPM Yu Zhao <yuzhao@google.com> wrot=
e:
> >
> > On Mon, Jun 10, 2024 at 6:22=E2=80=AFPM James Houghton <jthoughton@goog=
le.com> wrote:
> > >
> > > This new notifier is for multi-gen LRU specifically
> >
> > Let me call it out before others do: we can't be this self-serving.
> >
> > > as it wants to be
> > > able to get and clear age information from secondary MMUs only if it =
can
> > > be done "fast".
> > >
> > > By having this notifier specifically created for MGLRU, what "fast"
> > > means comes down to what is "fast" enough to improve MGLRU's ability =
to
> > > reclaim most of the time.
> > >
> > > Signed-off-by: James Houghton <jthoughton@google.com>
> >
> > If we'd like this to pass other MM reviewers, especially the MMU
> > notifier maintainers, we'd need to design a generic API that can
> > benefit all the *existing* users: idle page tracking [1], DAMON [2]
> > and MGLRU.
> >
> > Also I personally prefer to extend the existing callbacks by adding
> > new parameters, and on top of that, I'd try to consolidate the
> > existing callbacks -- it'd be less of a hard sell if my changes result
> > in less code, not more.
> >
> > (v2 did all these, btw.)
>
> I think consolidating the callbacks is cleanest, like you had it in
> v2. I really wasn't sure about this change honestly, but it was my
> attempt to incorporate feedback like this[3] from v4. I'll consolidate
> the callbacks like you had in v2.

Only if you think updating the MMU notifier API is overall the best option.

As I said earlier, I don't mind not doing the extra work, i.e., the
bitmap/_fast_only parameters and the _FAST_YOUNG return value, as long
as we know where we win and lose, i.e., simplicity and regressions. I
would call all the potential regressions (the nested VM case, the
arm64 case and the memcached benchmark) minor, compared with what we
got from v2. But my opinion doesn't really matter much because I'm not
your customer :)


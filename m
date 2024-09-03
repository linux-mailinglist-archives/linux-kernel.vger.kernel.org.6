Return-Path: <linux-kernel+bounces-313834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98AAE96AA75
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 23:41:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EAFA1F25FBD
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 21:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D771419ABDD;
	Tue,  3 Sep 2024 21:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rOK8OIDy"
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F0213F43E
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 21:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725399676; cv=none; b=QADK2Qz13Xxtmyy/0Rllx3iiP7yh+Qd4vl+Qw171GrtsJ7W4ZwKqNyb6fIUVe1qmwEg42NSCuGz6p8tz3flSUYO/H5h+yrLVbRp0NiCNlwkUtM0/uGYbfxv/sf+x6dBCkIbyaRM1qiPj68zvPxSk0HeJLh+pTbvyrlJYdmaHFOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725399676; c=relaxed/simple;
	bh=e1h7zTR9/S25Fd3D7+oznWXEX729eyTG7XRG+ROQ+5Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JRBL4J3huse4J8AgZ3c3R+Vu0fwHtdxEDDChbqFPXUTPBm/Bcf6COa2nCBePi11IdL40UuFO7aKsZUnMqQroYEh5Kfxck/oYaPpKTI/ACD/nfnzK3Hknjw9Q5Z2hfM2RoDt6lQVr/2ehPwAiALJDLvhlIhnHSBTbbxhqsxI+zqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rOK8OIDy; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e1a8ae00f5eso4032471276.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 14:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725399673; x=1726004473; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KTDnuKwd75FUnpcfChbe8v1J7QDzpMPR82p5HLmU/tQ=;
        b=rOK8OIDy4K9e9pqabDKRE2oB4OasFy7ya6YOYrV3T9T9mQEaMCeBmb+yo92UQfqElS
         gRzdlFIMp+/3FvHJJ3HG8UXWPw9ks3Ap6rah9Wj5iA735CCaTVjbMCN346u9ZroRP9su
         txru6x7bRnL/BaW1EaF6Ohdn7MRu7yCLI0J4P8rG1bdTJI8y1JZv/oxFKMdkMZEysLsm
         2aD+p+FDZhenab5DSN/WIthigK2TlbuyX5MeftffhdhkiBC9+G0+M0aex4AGIpbZKzW0
         6tw2eVG3fzxJJF7CkilDpIjamQd36sxg3MXlMMZHqhBc3jJ0TRzLL+5eUNW0U2sSsvih
         V0Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725399673; x=1726004473;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KTDnuKwd75FUnpcfChbe8v1J7QDzpMPR82p5HLmU/tQ=;
        b=HIgHTlADfV5BQi+A3YoLzQRy5dXSweSo/9V7tsQIGejhspFkXkgrI7SK07jAd4w3EX
         y3YcQUSDR6ZDOgwAZaHzYLasFYxTlfH6FxbPwUHcvjcA59POoPWIeQLhmLR8MwE6V68b
         uP8n3aLUzcgeKnHLIJgzY4/LIfz4TQudLkNoMPGrWKePhCZbUq0fKdieq04B5POg+Rrg
         IiaNxKX0fQaM/XOsnNA94IBEaDz//QFGFKwI0QmqTqLcOaUaJKDxNhfxLN7yQmdYtDpa
         QODyEyem21LlGLuoGULP9HWIV4YcwO8nxrdWKgxk6RLcn7M7kVKsGkjRwKXHQxigx337
         qzGw==
X-Forwarded-Encrypted: i=1; AJvYcCWxLZFjke0jRwN7kgZmocWL5ChTC0Muv8aeKpWnQ91P1AwaxCM7tyiQQ4b92uUuJbfX8BGXzq221oAQ53g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWE8J85yz6vWtAL9N/Dz+AUYUi75vkxcf5UcPN/5euSNbDZmc2
	aMEOwtPId9XkFFPABiKOGPfXkS3ZWzNakVmjqsJBeHldRLLdcmCp5bJSUB08VGoGrp2KwzuMr/T
	lkq2BGDKv4ms8stPd+5dgVgtX7MiQEqc4X7L3
X-Google-Smtp-Source: AGHT+IEq+la7fPI+jIUHIuVIxCQYY3gRR0EF+qaAb/jS0UgdTzRMeA/McH6lpLLI1QRVjuVO9S5Kgb3LHQb8oJYs9N4=
X-Received: by 2002:a05:6902:2406:b0:e1a:b361:4d9b with SMTP id
 3f1490d57ef6-e1ab36153f7mr8782208276.24.1725399673389; Tue, 03 Sep 2024
 14:41:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240809194335.1726916-1-seanjc@google.com> <20240809194335.1726916-20-seanjc@google.com>
 <CADrL8HUvmbtmfcLzqLOVhj-v7=0oEA+0DPrGnngtWoA50=eDPg@mail.gmail.com> <Ztd_N7KfcRBs94YM@google.com>
In-Reply-To: <Ztd_N7KfcRBs94YM@google.com>
From: James Houghton <jthoughton@google.com>
Date: Tue, 3 Sep 2024 14:40:36 -0700
Message-ID: <CADrL8HVpPOBkM4tD0xBpxWzYMiAoE5Gcg8Cg0=Xi5mvgeqR0gA@mail.gmail.com>
Subject: Re: [PATCH 19/22] KVM: x86/mmu: Add infrastructure to allow walking
 rmaps outside of mmu_lock
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Oliver Upton <oliver.upton@linux.dev>, Marc Zyngier <maz@kernel.org>, Peter Xu <peterx@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 3, 2024 at 2:27=E2=80=AFPM Sean Christopherson <seanjc@google.c=
om> wrote:
>
> On Tue, Sep 03, 2024, James Houghton wrote:
> > On Fri, Aug 9, 2024 at 12:44=E2=80=AFPM Sean Christopherson <seanjc@goo=
gle.com> wrote:
> > > +/*
> > > + * rmaps and PTE lists are mostly protected by mmu_lock (the shadow =
MMU always
> > > + * operates with mmu_lock held for write), but rmaps can be walked w=
ithout
> > > + * holding mmu_lock so long as the caller can tolerate SPTEs in the =
rmap chain
> > > + * being zapped/dropped _while the rmap is locked_.
> > > + *
> > > + * Other than the KVM_RMAP_LOCKED flag, modifications to rmap entrie=
s must be
> > > + * done while holding mmu_lock for write.  This allows a task walkin=
g rmaps
> > > + * without holding mmu_lock to concurrently walk the same entries as=
 a task
> > > + * that is holding mmu_lock but _not_ the rmap lock.  Neither task w=
ill modify
> > > + * the rmaps, thus the walks are stable.
> > > + *
> > > + * As alluded to above, SPTEs in rmaps are _not_ protected by KVM_RM=
AP_LOCKED,
> > > + * only the rmap chains themselves are protected.  E.g. holding an r=
map's lock
> > > + * ensures all "struct pte_list_desc" fields are stable.
> > > + */
> > > +#define KVM_RMAP_LOCKED        BIT(1)
> > > +
> > > +static unsigned long kvm_rmap_lock(struct kvm_rmap_head *rmap_head)
> > > +{
> > > +       unsigned long old_val, new_val;
> > > +
> > > +       old_val =3D READ_ONCE(rmap_head->val);
> > > +       if (!old_val)
> > > +               return 0;
> >
> > I'm having trouble understanding how this bit works. What exactly is
> > stopping the rmap from being populated while we have it "locked"?
>
> Nothing prevents the 0=3D>1 transition, but that's a-ok because walking r=
maps for
> aging only cares about existing mappings.  The key to correctness is that=
 this
> helper returns '0' when there are no rmaps, i.e. the caller is guaranteed=
 to do
> nothing and thus will never see any rmaps that come along in the future.
>
> > aren't holding the MMU lock at all in the lockless case, and given
> > this bit, it is impossible (I think?) for the MMU-write-lock-holding,
> > rmap-modifying side to tell that this rmap is locked.
> >
> > Concretely, my immediate concern is that we will still unconditionally
> > write 0 back at unlock time even if the value has changed.
>
> The "readonly" unlocker (not added in this patch) is a nop if the rmap wa=
s empty,
> i.e. wasn't actually locked.

Ah, that's what I was missing. Thanks! This all makes sense now.

>
> +static void kvm_rmap_unlock_readonly(struct kvm_rmap_head *rmap_head,
> +                                    unsigned long old_val)
> +{
> +       if (!old_val)
> +               return;
> +
> +       KVM_MMU_WARN_ON(old_val !=3D (rmap_head->val & ~KVM_RMAP_LOCKED))=
;
> +       WRITE_ONCE(rmap_head->val, old_val);
> +}
>
> The TODO in kvm_rmap_lock() pretty much sums things up: it's safe to call=
 the
> "normal", non-readonly versions if and only if mmu_lock is held for write=
.
>
> +static unsigned long kvm_rmap_lock(struct kvm_rmap_head *rmap_head)
> +{
> +       /*
> +        * TODO: Plumb in @kvm and add a lockdep assertion that mmu_lock =
is
> +        *       held for write.
> +        */
> +       return __kvm_rmap_lock(rmap_head);
> +}


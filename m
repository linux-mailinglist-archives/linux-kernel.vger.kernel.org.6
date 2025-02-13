Return-Path: <linux-kernel+bounces-512098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F87A333FB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 01:27:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA7303A734B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 00:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E68B2A1D7;
	Thu, 13 Feb 2025 00:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="barvS0VC"
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB971804A
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 00:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739406414; cv=none; b=IgBtC42CKtSMBa0yG6Za6mJ/8mQQJHcaxx4fyMbGHaR4n9v9WmqBfHNm+ev1Loywj4jbHHpCl//hI9yNUEIMbfNHbNtDQ3c31KJI/ANG/fYWBLofcz+rxO9hpie84jrZe8AHTfrm0edK+h7sP1tjtk9BuFeLBPtbiU1E6xgYS+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739406414; c=relaxed/simple;
	bh=btBR5N7uRHHuw3ht8npwHcy0kScz5qPCp2DfQ4EoDaA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IGkRJmy+7JdQiaaqEnJFDdqS1lDULCBDNWykf9CUJ5HMTSjnhplWjofhRUEOBbTbfpMGZ8nbRQxFWBXiHn89iSLvwua9yDBBMtOcsXv479J5oVPgoWQX/aFw9Sr/q0A/stzo3k3MR3HDi0tLaGbb3WbZ3wC+zjEW2/O5Pdm4rbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=barvS0VC; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6f9cc6fefa8so2354597b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 16:26:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739406411; x=1740011211; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T1lQra2BGRqr8BJ2tXCVKhfWYo8wxpCnBIWRVHL8S1U=;
        b=barvS0VCutBXeRNxi2W+7FmdXcYxT5tBeZlANHQ9FpSzuZDs6dSZMEgB0T3kqhqLdz
         MFFl28gwq3W4W1IqTCsOyx6D0cIBIH31jIgZa09hIDfcKi1FEVS+Y9BIPnHvmUjmK54e
         h+d6XlRUaUjlXxzgdAfmD20ALBSt5OEixd+fudxLrZmCnEvdscAfzvlWJt7RXuw3w89L
         uKfpOr6fKhDZXzLoaf3CYJrkS9I+2Ow8UjafnPBu/5nyxI64kqcIee6+yFlQ569/4IjQ
         nuBBRYLwXTkRXvVlnXDbcMFRMREnQXlYxzghk9cGZYum/BzrFVRGUGsTcpxr6D/i7U1T
         +soA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739406411; x=1740011211;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T1lQra2BGRqr8BJ2tXCVKhfWYo8wxpCnBIWRVHL8S1U=;
        b=nhPeE/DTf4r7+OHwcRapQ46ZsywfGahpvYXG4caPfm4yrE1/hxWDKGidjmmcnpGezP
         uBPxYfcpNISmLO4rpzDMPw6j2K0D77W0um2wODEEB9MSpYeRhS6kB9X7wyLihNjwGCD4
         PS2o2RVzJrYAX7GJxTt788tBwHI37wlvYrErkeoVjTnO9jyQ7mFBrEb6QwRLj621tnS5
         jdOzd8R9caEYzMpzsnlBtGXcqMQug2pXTBpu59KYSSFBch6nwhLj27U6kMtvfnEzgiHS
         C3IxiAx9TXFNbtlfy5n02MxF3Iy4H86NfzNYL2vg9lPLL1WlbrYRF0gDNxT7SNrEOnvk
         bV2w==
X-Forwarded-Encrypted: i=1; AJvYcCWSdDvRbqIA2eDp78hECJ0OaX2ZH2vwSP8PToR413D+ohyYeDpTjKvBXKXg+NXocvF21FFiWjTd3k7fucA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPIVFyPmwXr0j2j8cd2y5WT6192GDFOLs1Q+DLZagL03YKjvRY
	pTNiopL8evHiJeTIRKsBwdkGj/nykkm34mxAngYdt2QvZTV/hpMc9r0d8WZ4nnzCJ4izGID6gvn
	TnRAaGqw9HjK52mQTxhbYl3SpmyrXOLbjaCZC
X-Gm-Gg: ASbGncsbOfd3DGZguCpZ2rllNiop2mgAvkp6SzUU2C7I+nMTciMmFeqg1KvhEgQWnN2
	9Y0MXpJc93iD2ST423RJWjvBEW+iOQCuGXRVPqtviGpmfCczCgA8x1MFoGippEvmcmK+8s19Bze
	jyBZxZjlQNicu13fB6YEW8jxQQ4Q==
X-Google-Smtp-Source: AGHT+IHF7oWRUxJv7dCUpYW2IfmB3aCv+yjHjliJNpKqm7wi+IQ41sadVcf4u51Avvxozru5EBha7WCpmy+tM7d3Ufk=
X-Received: by 2002:a05:690c:6988:b0:6f6:cad6:6b5a with SMTP id
 00721157ae682-6fb1f19ba28mr70396737b3.13.1739406411154; Wed, 12 Feb 2025
 16:26:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250204004038.1680123-1-jthoughton@google.com>
 <20250204004038.1680123-6-jthoughton@google.com> <Z60cEcQ0P1G7oyFK@google.com>
In-Reply-To: <Z60cEcQ0P1G7oyFK@google.com>
From: James Houghton <jthoughton@google.com>
Date: Wed, 12 Feb 2025 16:26:15 -0800
X-Gm-Features: AWEUYZlW0xEqFDzX78EQEAIp-JOIdOgFVbgwEl-2uovs7RNjvbMVfq0Tz6WW5Vc
Message-ID: <CADrL8HXchc0XVK3JVP17mhvzy9Ga9eKMEi-U8ibah2xBy=2bSg@mail.gmail.com>
Subject: Re: [PATCH v9 05/11] KVM: x86/mmu: Rename spte_has_volatile_bits() to spte_needs_atomic_write()
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, David Matlack <dmatlack@google.com>, 
	David Rientjes <rientjes@google.com>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Wei Xu <weixugc@google.com>, Yu Zhao <yuzhao@google.com>, 
	Axel Rasmussen <axelrasmussen@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 12, 2025 at 2:09=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Tue, Feb 04, 2025, James Houghton wrote:
> > spte_has_volatile_bits() is now a misnomer, as the an SPTE can have its
> > Accessed bit set or cleared without the mmu_lock held, but the state of
> > the Accessed bit is not checked in spte_has_volatile_bits().
> > Even if a caller uses spte_needs_atomic_write(), Accessed bit
> > information may still be lost, but that is already tolerated, as the TL=
B
> > is not invalidated after the Accessed bit is cleared.
> >
> > Signed-off-by: James Houghton <jthoughton@google.com>
> > ---
>
> ...
>
> > diff --git a/arch/x86/kvm/mmu/spte.h b/arch/x86/kvm/mmu/spte.h
> > index 59746854c0af..4c290ae9a02a 100644
> > --- a/arch/x86/kvm/mmu/spte.h
> > +++ b/arch/x86/kvm/mmu/spte.h
> > @@ -519,7 +519,7 @@ static inline u64 get_mmio_spte_generation(u64 spte=
)
> >       return gen;
> >  }
> >
> > -bool spte_has_volatile_bits(u64 spte);
> > +bool spte_needs_atomic_write(u64 spte);
> >
> >  bool make_spte(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp,
> >              const struct kvm_memory_slot *slot,
> > diff --git a/arch/x86/kvm/mmu/tdp_iter.h b/arch/x86/kvm/mmu/tdp_iter.h
> > index 05e9d678aac9..b54123163efc 100644
> > --- a/arch/x86/kvm/mmu/tdp_iter.h
> > +++ b/arch/x86/kvm/mmu/tdp_iter.h
> > @@ -55,7 +55,7 @@ static inline bool kvm_tdp_mmu_spte_need_atomic_write=
(u64 old_spte, int level)
> >  {
> >       return is_shadow_present_pte(old_spte) &&
> >              is_last_spte(old_spte, level) &&
> > -            spte_has_volatile_bits(old_spte);
> > +            spte_needs_atomic_write(old_spte);
>
> Unless you object, I'll change this to spte_needs_atomic_update(), and tw=
eak
> kvm_tdp_mmu_spte_need_atomic_write() accordingly.  "write" was a bad choi=
ce by
> me.  It's not just the store/write that needs to be atomic, it's the enti=
re
> read-modify-write.  E.g. KVM needs to preserve the existing value, but fo=
r many
> flows, it's even more important that KVM's snapshot of the old SPTE is ac=
curate.

No objections, please make that change. Thanks!


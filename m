Return-Path: <linux-kernel+bounces-194912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ABBE8D4420
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 05:27:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7CCC1C222ED
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 03:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11F0556B65;
	Thu, 30 May 2024 03:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qsEGJAf2"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C836BB5D
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 03:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717039642; cv=none; b=dLXVV9kmerB8C82RTTSwqYoHvvkgy5yVNBJEH6qDk6ssJEMY/7OzAYopfi0ya+fSkIoUrGC+kITw5N0/yT52QDZwxsyEvvyuqTpVm7MLTN3kOns/Tt56ObFmJLCrvRLS1meNyiEx7lqQu/LjVm1kKNEE1nl+3ulH2pLW5wIFfR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717039642; c=relaxed/simple;
	bh=xwqfvipxZXJK+B/0mrTj9cWb8eP7mVNihD2LXTHfaSk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iMiWQS/H7lfHEKLWUSHCvBn0Zgu19C5bGMhyhHxThyRrGOxvN8Z6Ibp2gdJA9Yr0dhpiR5OEke610+3jJFfbo6gEKz9Rdaiek625wHxecPGzWj0dhSNXpg063aYQTQfX7b90DWaMN5OqNCLIrSXUr0WUCvT4m+yQjxt3SHPV45o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qsEGJAf2; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-43e14f0bd75so110911cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 20:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717039638; x=1717644438; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kzO8DZyZzCqrZIAMGt7yPpLcZJsj3wUliJt03pVmX2A=;
        b=qsEGJAf22FtK1T9YmxDUPjIaTDS2NZnp9Fb63aWXEdLh11vy9K3GUtRHVQ2OvSxy4W
         YOIngawcKAbQ22m7NWqo4A8AJsQ+8jNEsKEeg0cLMRtvfnisqYRy0CT841KLKkbrALaE
         umy4gwWYR0Szf3ttiYYY2CXOia0EyA84rDpG3wbq14ytUoqM9mfqFZQ2jAsEK0K4QYYa
         HGsYbUTAh++b/ElOnZaM8/TvE/1jF87HOOYAHzJ0j1spyV53vdz00+1WV1OfO5eaza6U
         qSeNHoybqgSlvRqzY9z4RhStBbyyvzCLzNVZO9bmWhRKHjuj6+5t73jdH2Rdr/jpchlK
         uU9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717039638; x=1717644438;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kzO8DZyZzCqrZIAMGt7yPpLcZJsj3wUliJt03pVmX2A=;
        b=g8RelapmK6yRdTFbjpTJN8ealkft0lQDaAYIU+K7os24g3EOGgZ7rCNnlVkfL8mku+
         RPP6OrpJaq16xZlNsSl3WJy6eRG8/98nnmFD3Do/2T8TfK4tspUkFylBFi1tiler5/qY
         K1QyD5HEZ9Q8GDUP89NaCxsqZl/8VKuvtzJIR6XPjT777K0qkbB+LSsNottD+vWHz8S5
         WNmRbFoEGkbcfyjVrEvWHm+jHktmo2YE4EvGRO9eSh2EMESujeHj0KYXuxmkV/zPFNk9
         b8/TCehyUzy902zJARecXyCoCTaCuNHkmeP5HxWxYz9QOlPACm3CdhYwFxlqEVyb47Kw
         FHtg==
X-Forwarded-Encrypted: i=1; AJvYcCWUA2A64r13aieqvDODZD8cSvDZ++VraHPMo6A7SnKLaYip40i2v+ITi5B7AsvsTnD8htggRgdgTytPEDbsG8iQuhZVm4sVFWRP+558
X-Gm-Message-State: AOJu0YxzklIbtANWQQ470cEcRBFh0HiIIOcm8ApO76Wsnj5APwW8Y5x9
	lVnMG6be+UZnnx/QGar087n11goq0PdH60htrU7U3t3hXoyBtnWhlHcAG0+kPPO1dFllCGsWMMw
	OFQnaJY8tx/NWyEYChzDl9yuEdAXshP6pfi0t
X-Google-Smtp-Source: AGHT+IFVU+i/PACo9p4/Bfxh1CqiMIWSQeR950pdjWP8hj1BhsXnC5rRHtunLNirP/Gyt4FL6G7AiU0HcN3VuQYeCls=
X-Received: by 2002:a05:622a:a313:b0:43f:ebce:be50 with SMTP id
 d75a77b69052e-43febcebe65mr835941cf.16.1717039638165; Wed, 29 May 2024
 20:27:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240529180510.2295118-1-jthoughton@google.com>
 <20240529180510.2295118-4-jthoughton@google.com> <ZlejXCYIuJ7_DlwL@google.com>
In-Reply-To: <ZlejXCYIuJ7_DlwL@google.com>
From: James Houghton <jthoughton@google.com>
Date: Wed, 29 May 2024 20:26:41 -0700
Message-ID: <CADrL8HUa9o+G6-Yn9oWt2LUgoVYGU=sYE2-JhkpoRgrS6Wi57g@mail.gmail.com>
Subject: Re: [PATCH v4 3/7] KVM: Add lockless memslot walk to KVM
To: Sean Christopherson <seanjc@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Ankit Agrawal <ankita@nvidia.com>, 
	Anup Patel <anup@brainfault.org>, Atish Patra <atishp@atishpatra.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Bibo Mao <maobibo@loongson.cn>, 
	Catalin Marinas <catalin.marinas@arm.com>, David Matlack <dmatlack@google.com>, 
	David Rientjes <rientjes@google.com>, Huacai Chen <chenhuacai@kernel.org>, 
	James Morse <james.morse@arm.com>, Jonathan Corbet <corbet@lwn.net>, Marc Zyngier <maz@kernel.org>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Oliver Upton <oliver.upton@linux.dev>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Raghavendra Rao Ananta <rananta@google.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Shaoqin Huang <shahuang@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Tianrui Zhao <zhaotianrui@loongson.cn>, Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, kvm-riscv@lists.infradead.org, kvm@vger.kernel.org, 
	kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mips@vger.kernel.org, 
	linux-mm@kvack.org, linux-riscv@lists.infradead.org, 
	linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2024 at 2:51=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Wed, May 29, 2024, James Houghton wrote:
> > @@ -686,10 +694,12 @@ static __always_inline int kvm_handle_hva_range(s=
truct mmu_notifier *mn,
> >       return __kvm_handle_hva_range(kvm, &range).ret;
> >  }
> >
> > -static __always_inline int kvm_handle_hva_range_no_flush(struct mmu_no=
tifier *mn,
> > -                                                      unsigned long st=
art,
> > -                                                      unsigned long en=
d,
> > -                                                      gfn_handler_t ha=
ndler)
> > +static __always_inline int kvm_handle_hva_range_no_flush(
> > +             struct mmu_notifier *mn,
> > +             unsigned long start,
> > +             unsigned long end,
> > +             gfn_handler_t handler,
> > +             bool lockless)
>
> Unnecessary and unwanted style change.

Sorry -- this will be fixed.

>
> >  {
> >       struct kvm *kvm =3D mmu_notifier_to_kvm(mn);
> >       const struct kvm_mmu_notifier_range range =3D {
> > @@ -699,6 +709,7 @@ static __always_inline int kvm_handle_hva_range_no_=
flush(struct mmu_notifier *mn
> >               .on_lock        =3D (void *)kvm_null_fn,
> >               .flush_on_ret   =3D false,
> >               .may_block      =3D false,
> > +             .lockless       =3D lockless,
>
> Why add @lockess to kvm_handle_hva_range_no_flush()?  Both callers immedi=
ately
> pass %false, and conceptually, locking is always optional for a "no flush=
" variant.

Right, this isn't needed in this patch. But I think I need it
eventually (like, in the next patch), so I'll move it where it is
really needed.



>
> >       };
> >
> >       return __kvm_handle_hva_range(kvm, &range).ret;
> > @@ -889,7 +900,8 @@ static int kvm_mmu_notifier_clear_young(struct mmu_=
notifier *mn,
> >        * cadence. If we find this inaccurate, we might come up with a
> >        * more sophisticated heuristic later.
> >        */
> > -     return kvm_handle_hva_range_no_flush(mn, start, end, kvm_age_gfn)=
;
> > +     return kvm_handle_hva_range_no_flush(mn, start, end,
> > +                                          kvm_age_gfn, false);
> >  }
> >
> >  static int kvm_mmu_notifier_test_young(struct mmu_notifier *mn,
> > @@ -899,7 +911,7 @@ static int kvm_mmu_notifier_test_young(struct mmu_n=
otifier *mn,
> >       trace_kvm_test_age_hva(address);
> >
> >       return kvm_handle_hva_range_no_flush(mn, address, address + 1,
> > -                                          kvm_test_age_gfn);
> > +                                          kvm_test_age_gfn, false);
> >  }
> >
> >  static void kvm_mmu_notifier_release(struct mmu_notifier *mn,
> > --
> > 2.45.1.288.g0e0cd299f1-goog
> >


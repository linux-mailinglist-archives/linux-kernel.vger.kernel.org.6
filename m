Return-Path: <linux-kernel+bounces-201456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 432B48FBECC
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 00:21:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1A06282BC7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 22:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CE3D14C58E;
	Tue,  4 Jun 2024 22:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IA3BDoh4"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B091442FE
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 22:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717539660; cv=none; b=LiRstSCcN8buFK9d2JH+i3NSVx9XZSd0/WXCdyDSLQd03CUhbkXAj1dvo6SlsaWmYDHJKsWnYFb6hpwHMoN+jwuEYGVHarnNtBJwXMKYgIL5mFTg9QeU29FSv4JkWM5oc8qC4d31LNpvE8kkqJ14hOIsbTOegx16LqvR9xF0zx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717539660; c=relaxed/simple;
	bh=PEwtsHuB5I4aiO3jiKouMVnFQZ+bv8RQ/fbI3oGiDcE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VMfs3m9KZTVNqRgK1W8MjmmDYZnZoqk6M9CxfVkta72NZCowMFsmp4CLf9HdwSHO1KnUy1HslWzhUVvEGgfv7W+sqoyC/aQeTztOdA4jNc56horryUDzrpRoPErd62Ohb/tmImSk8V8wEgBqwDrzneWVIfYoaGSF7U9cfZIxkfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IA3BDoh4; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-43dfe020675so137741cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 15:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717539656; x=1718144456; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AIBmj4SOCWbNZTcEJ36wTOG253WABX8+/zZKq57PG38=;
        b=IA3BDoh41QbII5/51gETpHN3tQmqumLEBtU03HGvR2buAutTMZLhn2XOS727DURXP9
         mm+CkSzoy0MnlwjM25EamvaEuAHEybz+ZzCYaV2uhGkEYEJmlflRkuOvHoh/R9aXdALr
         AqTX1tPmwiKj6DB0TqVYETU05FduCslg13+jaYxoIw1IiIzgnNpo+ClOkW+4Priy4TZg
         7NOv5Mgjm1fO3oaoXKE23V2t4KaowBNbxeDzNuMsdEl8GQuYjl+GxW2rDLPUAZC/UjG6
         xbfKdoWJGEnnidbzJ4uKM5j2B4U7XPLmaWaNclFix88oXT5iS9VA6sLZj8SSjoJ4gPfm
         ZUdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717539656; x=1718144456;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AIBmj4SOCWbNZTcEJ36wTOG253WABX8+/zZKq57PG38=;
        b=Vg2QwaFCo02PSSeIVSAnJxyVqY4teLWzWAyRzyo2RN3tLIZcSx52YU1Um+7ASUPUj6
         dHKqhRQyCfmLWix3K7mzHF0MZsFpamRUuduR9SSG1lYiscsAiQW+6PtTUq9UU3Lt4oKr
         I1JP4nctxK9cuzxMATuhTHAWXlK+DEUeX7zsQl79kOVp7neDSO8E9HxCDEYR9uLhozJB
         WpuRbu23O+N8NPJ2aD0C5d9FHgATldNv9wV60yJ2LvFvLhpXNGCVWyBxdCjCAVha4g7j
         lq3WmDPjxlNN0IL0Mrl1OJpk7RrfLj/zgJa+M6WJqHnm/IApPcH4BUNLKSCIkxzGfwO/
         a2Uw==
X-Forwarded-Encrypted: i=1; AJvYcCVEkHkZmCBNCbEXK0EBE422tv8+at9NPpQJDiV6iYp/tobtWPbGW6CQzDAtmlgTiq99OCK+Iasp/n+uqlOVQvYDhYo3ZwWBB5oHZwg3
X-Gm-Message-State: AOJu0YzjdgLtlqOhHueAUBwpIAuo0nncfUJxVH1f25jf6CT1SPUaAAeX
	+IZUwovGfTdUzFy0KOrOYCdBVCiTu448O9LPjgKWUExqacZHbh8oZb02uvBZeBBy8DY5jVqik28
	Dl98AHP7/w41B97ok5QSD3M2cxm5ybNk3Fiwx
X-Google-Smtp-Source: AGHT+IFqQR6wV0ldEWSB61hJVaO5R3FbfhfGJ/jL2Y1RO1QFt4uPcpp04yR87XJA3WIv/pXl4si2o71lLJw9aUuCxfc=
X-Received: by 2002:a05:622a:5a98:b0:43d:dc3b:518c with SMTP id
 d75a77b69052e-4402ce13c55mr332451cf.11.1717539656344; Tue, 04 Jun 2024
 15:20:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240529180510.2295118-1-jthoughton@google.com>
 <20240529180510.2295118-7-jthoughton@google.com> <Zlog5Yk_Pjq0jQhC@linux.dev> <Zloicw4IU8_-V5Ns@linux.dev>
In-Reply-To: <Zloicw4IU8_-V5Ns@linux.dev>
From: James Houghton <jthoughton@google.com>
Date: Tue, 4 Jun 2024 15:20:20 -0700
Message-ID: <CADrL8HV4SZ9BEQg1j3ojG-v5umL_d3sa4e1k2vMQCMmBEgeFpQ@mail.gmail.com>
Subject: Re: [PATCH v4 6/7] KVM: arm64: Relax locking for kvm_test_age_gfn and kvm_age_gfn
To: Oliver Upton <oliver.upton@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Ankit Agrawal <ankita@nvidia.com>, 
	Anup Patel <anup@brainfault.org>, Atish Patra <atishp@atishpatra.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Bibo Mao <maobibo@loongson.cn>, 
	Catalin Marinas <catalin.marinas@arm.com>, David Matlack <dmatlack@google.com>, 
	David Rientjes <rientjes@google.com>, Huacai Chen <chenhuacai@kernel.org>, 
	James Morse <james.morse@arm.com>, Jonathan Corbet <corbet@lwn.net>, Marc Zyngier <maz@kernel.org>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Raghavendra Rao Ananta <rananta@google.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	Sean Christopherson <seanjc@google.com>, Shaoqin Huang <shahuang@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Tianrui Zhao <zhaotianrui@loongson.cn>, 
	Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	kvm-riscv@lists.infradead.org, kvm@vger.kernel.org, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-mm@kvack.org, 
	linux-riscv@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, 
	loongarch@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 31, 2024 at 12:18=E2=80=AFPM Oliver Upton <oliver.upton@linux.d=
ev> wrote:
>
> On Fri, May 31, 2024 at 12:11:33PM -0700, Oliver Upton wrote:
> > On Wed, May 29, 2024 at 06:05:09PM +0000, James Houghton wrote:
> >
> > [...]
> >
> > > diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtabl=
e.c
> > > index 9e2bbee77491..eabb07c66a07 100644
> > > --- a/arch/arm64/kvm/hyp/pgtable.c
> > > +++ b/arch/arm64/kvm/hyp/pgtable.c
> > > @@ -1319,10 +1319,8 @@ static int stage2_age_walker(const struct kvm_=
pgtable_visit_ctx *ctx,
> > >     data->young =3D true;
> > >
> > >     /*
> > > -    * stage2_age_walker() is always called while holding the MMU loc=
k for
> > > -    * write, so this will always succeed. Nonetheless, this delibera=
tely
> > > -    * follows the race detection pattern of the other stage-2 walker=
s in
> > > -    * case the locking mechanics of the MMU notifiers is ever change=
d.
> > > +    * This walk may not be exclusive; the PTE is permitted to change
> > > +    * from under us.
> > >      */
> > >     if (data->mkold && !stage2_try_set_pte(ctx, new))
> > >             return -EAGAIN;
> >
> > It is probably worth mentioning that if there was a race to update the
> > PTE then the GFN is most likely young, so failing to clear AF probably
> > isn't even consequential.

Thanks Oliver.

>
> Oh, and the WARN_ON() in kvm_pgtable_stage2_test_clear_young() is bogus
> now. Maybe demote it to:
>
>   r =3D kvm_pgtable_walk(...);
>   WARN_ON_ONCE(r && r !=3D -EAGAIN);

Oh, indeed, thank you. Just to make sure -- does it make sense to
retry the cmpxchg if it fails? For example, the way I have it now for
x86[1], we retry the cmpxchg if the spte is still a leaf, otherwise we
move on to the next one having done nothing. Does something like that
make sense for arm64?

[1]: https://lore.kernel.org/linux-mm/20240529180510.2295118-6-jthoughton@g=
oogle.com/


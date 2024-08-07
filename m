Return-Path: <linux-kernel+bounces-278112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AFDDA94AB2D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 17:04:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59E061F25623
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 15:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06BC982499;
	Wed,  7 Aug 2024 15:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EG+mZLEb"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF5882488
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 15:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723042986; cv=none; b=OtjJNcRxaCnAOaGPApi8HtTLUpXRFCMV/F74yyR4q1nx3Y9R2NtHjkGtbH5v99+PFRHOg1Cod/9vfyqPUKPfgwZiYmQACL3YJRYVXR3W7xqnvr21CODxaPB3W1RCEMjNRwe3BWfcEasFg0pcCIzOHpj2VS/unH6LppXxYWRqWYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723042986; c=relaxed/simple;
	bh=i+cKN7kvlmSwCbheJAMEk6ZSnnzPsXRqTPu/u16iMjk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bnOpEbd7x/wEiCtG9zKJNFz/hngNlD7QA/a7tAVMniohV1eKBQxQUCgv93/Rf5ng3dizcEnMS4qAfmcnRSxW+GeFR2XnHNGbqtnMTx5pA10ou+1W3fzywLYHP8ywMJsawHa2G2n+db75a7HpDOBzlWEeic10efspnYgilCthchM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EG+mZLEb; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1fc4aff530dso545115ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 08:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723042983; x=1723647783; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kl+B4ZpfEXlczthXYPnKJxRHMc3GQi5TyNP+ymJuxKA=;
        b=EG+mZLEbaT3VFrKjoBA4rnhDFCsVUYDtbW5eXWP0KEBc+bqXPU/BlUL5JRbzhT4rMS
         Sc4ygkpSSJ0+wt1MAYP1WzpaTFgyGveKsuVs7H9m50NzkjOBtEX1eeWIVqJE8YRGg3wy
         PDbyeSK4obJF60B1USCt4aKkhlCwxSYbXfktUiWP9FF2MqZWbR5mWUzItB1c8eIIaOKL
         R7uVO6cxJSxNDu9DHLCgNuGAZ0FxCx7+W2+xd4XFoTN1HBb55rxuXJPqMtIpEVq5Tv9r
         77jt+iJioUEkz1QvpNlSgf/Fmtpb0d4ZDdE3Db7yXXnClgGg8mCAYzgvI/On2H1/cTYO
         cSQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723042983; x=1723647783;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kl+B4ZpfEXlczthXYPnKJxRHMc3GQi5TyNP+ymJuxKA=;
        b=dlyRLzp2rOzbs4WJnCve8B2hx+vJf1/0hzmd0v4NpaSf9lfPB3jrnyu3m+4wPzImpL
         Tlb42BOajaYj9EV4bwjX6CY7FQ/z4Gr3x09PMr/tWK1DqUSTMrxhTmrDP8NrFTtpPY7T
         oKbCCEsNgPjx9SuYoLZ7rnpDbymzqpvk4EeVJwFr5x4ZcKbtGiBfTnwIi+tj1KSX+ZRK
         7SGO61z9AOBqM6d6NN4FZrT9jgRJ+uZmHwuFjGszs/TaV/daWyRnaExYtn2zwEDlIhp2
         aH4+8DP7u+NEbE4vhlrsfBW9V6esfJqOkaXRpJV5sN+ZxVxIC3f2cvt26mKv41eXPA83
         oitA==
X-Forwarded-Encrypted: i=1; AJvYcCUuv5qXrSECGFxAWX8f/N8ZFxmxa8Mw24XIfZvgt7IO8cdjC/TSI6VLXJmwgWfRJFb/lEXxALvxxbjAIuSYgvct5PQ96C6WwzKu4G08
X-Gm-Message-State: AOJu0YyDRsj4foKDA1uBZvTFCIrmExdYMhrvmtjZEOcgReVbeTz3uxYG
	yC2IJB4xHXjb0NIyiYA8NLaTaHvh2i6FoEoykg2V9WD4WcCumFK+L52nrRirM7mjVeQoaTjhMSU
	mSW1MGxQr10onZIxCwAe7mBrDjH04HpoygypA
X-Google-Smtp-Source: AGHT+IEr49aHCdjCgL7YLIeYK1keo+SAW0FFZJxDENp6M5+q2ZuFNNnSP3R4yjqSv3wfAioC7aVTpFhpJO2Or0Jv1jg=
X-Received: by 2002:a17:902:f547:b0:1fb:563:3c25 with SMTP id
 d9443c01a7336-20083799d8emr3462625ad.18.1723042982895; Wed, 07 Aug 2024
 08:03:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240724011037.3671523-1-jthoughton@google.com>
 <20240724011037.3671523-6-jthoughton@google.com> <37ae59f2-777a-4a58-ae58-4a20066364dd@redhat.com>
 <CADrL8HUmQWDc-75p=Z2KZzHkyWCCh8xnX=+ZXm5MZ-drALjKTA@mail.gmail.com> <20240806172349.GQ676757@ziepe.ca>
In-Reply-To: <20240806172349.GQ676757@ziepe.ca>
From: James Houghton <jthoughton@google.com>
Date: Wed, 7 Aug 2024 08:02:26 -0700
Message-ID: <CADrL8HXFK=1cUS+0Z5k048U4rzpTNL634f57VtJ7TD_umrbNiA@mail.gmail.com>
Subject: Re: [PATCH v6 05/11] mm: Add fast_only bool to test_young and
 clear_young MMU notifiers
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: David Hildenbrand <david@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, Ankit Agrawal <ankita@nvidia.com>, 
	Axel Rasmussen <axelrasmussen@google.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	David Matlack <dmatlack@google.com>, David Rientjes <rientjes@google.com>, 
	James Morse <james.morse@arm.com>, Jonathan Corbet <corbet@lwn.net>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Raghavendra Rao Ananta <rananta@google.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Sean Christopherson <seanjc@google.com>, 
	Shaoqin Huang <shahuang@redhat.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Wei Xu <weixugc@google.com>, Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, kvmarm@lists.linux.dev, kvm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 6, 2024 at 10:23=E2=80=AFAM Jason Gunthorpe <jgg@ziepe.ca> wrot=
e:
>
> On Thu, Aug 01, 2024 at 04:13:40PM -0700, James Houghton wrote:
> > --- a/include/linux/mmu_notifier.h
> > +++ b/include/linux/mmu_notifier.h
> > @@ -106,6 +106,18 @@ struct mmu_notifier_ops {
> >          * clear_young is a lightweight version of clear_flush_young. L=
ike the
> >          * latter, it is supposed to test-and-clear the young/accessed =
bitflag
> >          * in the secondary pte, but it may omit flushing the secondary=
 tlb.
> > +        *
> > +        * The fast_only parameter indicates that this call should not =
block,
> > +        * and this function should not cause other MMU notifier calls =
to
> > +        * block. Usually this means that the implementation should be
> > +        * lockless.
> > +        *
> > +        * When called with fast_only, this notifier will be a no-op un=
less
> > +        * has_fast_aging is set on the struct mmu_notifier.
>
> If you add a has_fast_aging I wonder if it is better to introduce new
> ops instead? The semantics are a bit easier to explain that way

v5 implemented these with a new op[1]. *Just* having the new op is
kind of problematic -- we have yet another op to do something very
similar to what already exists. We are left with two options:
consolidate everything into a single notifier[2] or add a new
parameter to test/clear_young()[3]. The latter, implemented in this
v6, is somewhat simpler to implement (fewer LoC, reduces some
duplication in KVM), though it does indeed make the explanation for
test/clear_young() slightly more complex. I don't feel very strongly,
but unless you do, I think I just ought to stick with how the v6 does
it. :)

Thanks Jason!

[1]: https://lore.kernel.org/linux-mm/20240611002145.2078921-5-jthoughton@g=
oogle.com/
[2]: https://lore.kernel.org/linux-mm/CADrL8HVHcKSW3hiHzKTit07gzo36jtCZCnM9=
ZpueyifgNdGggw@mail.gmail.com/
[3]: https://lore.kernel.org/linux-mm/CADrL8HXhGFWwHt728Bg15x1YxJmS=3DWD8z=
=3DKJc_Koaah=3DOvHDwg@mail.gmail.com/


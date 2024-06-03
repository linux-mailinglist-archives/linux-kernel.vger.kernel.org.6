Return-Path: <linux-kernel+bounces-199696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B84418D8AFB
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 22:38:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43EDAB266BA
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 20:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C221E13B7BC;
	Mon,  3 Jun 2024 20:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cyfWXK4q"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2CC13B592
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 20:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717447115; cv=none; b=T5m2ZcelRhkpr/qzltaBZ70FWxL9gWqAT4qyUVwxQZ/1yGvG11zrI0PVO36TFI4BPwHJzMkyjeuKVZBAdQetnS5EVHiXUi8XPYHeMfNqsI065DmfCbw3cxwXnbIWW9NG1bBaz/mjl09MFc/6JUx6cT9/wVBAdbTQgdm2zx+5+7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717447115; c=relaxed/simple;
	bh=nOajvElT2YxRSgkUc7uVk4PH7rZHafyM7iXn3jIYzKs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DeYL61Vx9zoDutdYmnHJjwa5DBHsP641w7mRcOQ2ButadkEzr9dxfMj6aO4MugCTcWQ7WZWk9s0eRb3FlKJYWGWndP7JEMNdPUgb20WE26clYzHHuBGctkP+aZeVdl8SBJjfpn1daeo56EccpvH/8j08AqQiUtBnkiCUDL8VpPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cyfWXK4q; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-1f302bf0c29so29527855ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 13:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717447113; x=1718051913; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XO5yZdhwE2fDtj4hYaOddgQwqaOtsUzsgmBHSrtqiuw=;
        b=cyfWXK4qp6dry/mYPzxtFdlZALtIbi1ldCrYVnFDDMFQ/bwDXefEB57jEfIP0Qqh9o
         6jIhgYfxNCaSZ93iWvofZQAyF9nuK7CoJC2iC+XiCMTUexnQ6FGY9MO0xtiVya+wsVju
         80/VbOCL+3PkzHqQr0NRB8SfsQca8Qr5C2HR18qmXy4yF1grCNHSZmvoMs9kMLpQl33a
         WJ9iPQdKU6WIoRNyo/6Z1ScNNmHoz3CJ0LXhchX3+ZlmPgJaYo9PtHgTxVTLSdfcIuf1
         mwD+1gpbGdq7TNR0AHxgr/bHdRhr1T4zjwTcazmwCIfsCw3MrpA6JCfKH1um/TLn+WMl
         Hu+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717447113; x=1718051913;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XO5yZdhwE2fDtj4hYaOddgQwqaOtsUzsgmBHSrtqiuw=;
        b=TiWcq7pCwgaLnFosMroQ5bB+EU73wDUf5jOoOq8dvQ0C2Zq/xxTicBZPCYaYI3+Nxm
         YNayzMW32m+26gxgqco4uJbka21M4F+LSdLUoatj61S2mHbSkok2Jp8NohGOzypdXi2x
         xmxqgv94P4K/xhzSwsOcB1tyD+xDhAM4HgafF1jO5/kE2bE/DwvNyrea/MYo+NbkTb84
         Z6vb8BtSeDVPZV7U5TJkbNB2ba+OLxwIZkzTb9rBlkHNqBoqEtkh8UR9YYz3FleRDP+c
         jEtCTYOQxS9mTE5b1SrkFF80Njw2PxyrFUVrw+KcS4Dl7U3nK0QSHRSYAS+cYs2XzSSi
         lxuA==
X-Forwarded-Encrypted: i=1; AJvYcCXjghtbp29LPXL+2JONuTVbECUltkA1TaBeAn47e2AfygNW8FmiUL06coed9xsIqGaxFoGvhABvA4Anj2jeawLuvgJWizD2gEkh7yN7
X-Gm-Message-State: AOJu0Yzzp95fBRusWUrUOg2M+RRJKU/epFcksQEMMJy0PlJhoEE+JEjO
	BzUlrWZ/QazWnWxyB+pb5BAYvfKXxCUPebyaykrmmurVnFTFLn0tkeH2ltJhSiJ0DwkuK4KcoWi
	68Q==
X-Google-Smtp-Source: AGHT+IExdolKE/hY98W+ja0EGqBrXw6wGDQhTRxEkbZVRfK2Y4yJSHL+gAUKdUpiFhN7lu/Fxb6BAhUIS8Y=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:903:124a:b0:1f6:d4b:3507 with SMTP id
 d9443c01a7336-1f6370c132dmr287075ad.13.1717447112817; Mon, 03 Jun 2024
 13:38:32 -0700 (PDT)
Date: Mon, 3 Jun 2024 13:38:31 -0700
In-Reply-To: <CABgObfY5athiQKdV8LQt3b=yKEgydOXRdfXeLz1C8Ho=ZrqOaQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <98ad0dab3a2c66834e50e6d465dcae47dd80758b.1717436464.git.babu.moger@amd.com>
 <Zl4DQauIgkrjuBjg@google.com> <CABgObfY5athiQKdV8LQt3b=yKEgydOXRdfXeLz1C8Ho=ZrqOaQ@mail.gmail.com>
Message-ID: <Zl4px2yauHdvDUbR@google.com>
Subject: Re: [PATCH] KVM: Fix Undefined Behavior Sanitizer(UBSAN) error
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Babu Moger <babu.moger@amd.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 03, 2024, Paolo Bonzini wrote:
> On Mon, Jun 3, 2024 at 7:54=E2=80=AFPM Sean Christopherson <seanjc@google=
.com> wrote:
> > > However, VM boots up fine without any issues and operational.
>=20
> Yes, the caller uses kvm_handle_hva_range() as if it returned void.
>=20
> > Ah, the "break" will only break out of the memslot loop, it won't break=
 out of
> > the address space loop.  Stupid SMM.
> >
> > diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> > index b312d0cbe60b..70f5a39f8302 100644
> > --- a/virt/kvm/kvm_main.c
> > +++ b/virt/kvm/kvm_main.c
> > @@ -651,7 +651,7 @@ static __always_inline kvm_mn_ret_t __kvm_handle_hv=
a_range(struct kvm *kvm,
> >                                         range->on_lock(kvm);
> >
> >                                 if (IS_KVM_NULL_FN(range->handler))
> > -                                       break;
> > +                                       goto mmu_unlock;
> >                         }
> >                         r.ret |=3D range->handler(kvm, &gfn_range);
> >                 }
> > @@ -660,6 +660,7 @@ static __always_inline kvm_mn_ret_t __kvm_handle_hv=
a_range(struct kvm *kvm,
> >         if (range->flush_on_ret && r.ret)
> >                 kvm_flush_remote_tlbs(kvm);
> >
> > +mmu_unlock:
> >         if (r.found_memslot)
> >                 KVM_MMU_UNLOCK(kvm);
>=20
> Yep. If you want to just reply with Signed-off-by I'll mix the
> original commit message and your patch.

Signed-off-by: Sean Christopherson <seanjc@google.com>


Return-Path: <linux-kernel+bounces-446925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CC039F2AFE
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 08:37:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48F177A1C74
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 07:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7B901F7093;
	Mon, 16 Dec 2024 07:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j9pYYGzR"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77CDD1F708D
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 07:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734334664; cv=none; b=chbymB88SPw7hwqUPu4I0/5OM8iXGT0phQZGawaBUBxqmYM2BI7XwAcvLGOLpd8QwzyNSQCDXPewon/CGGl4OCIX/6F/uSeR2uzsl0PYqwOCM0x+ZTlhthnPCo5kXrA2f+8jvQ0oe3jXrJObDdd7AXUB3WdP6Si4U1IkpeBEqEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734334664; c=relaxed/simple;
	bh=YHUFA9xaQ6bsnplQVZac7SfeAp7cYlfroZAmph+ZtNk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CLKMu7PZYW/NCmDPmH4U2zMyj13U7vD+ELHHqTijYwXqlaC3q6Hua202hBWsglXKC42qe4B+04uooUL5k0gUwv7ovJywwHscEGuKiDFDmrmECGL6gxl1QYE0GOJq92GxveO5DsgVI20SClRwNFtXNOl7XvtHLUPANCZ9XoupOsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j9pYYGzR; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-3035210e2d1so7222801fa.2
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 23:37:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734334660; x=1734939460; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5iPuGa5HCPzSMoHYKVJCU6quqj6Ftm6FTmJ8Y7jrKjY=;
        b=j9pYYGzR33YcjPyLlYDeJDlDE5Wh1YL8rZuxjRxLDDc5rex9+ZmHJgJRdavU2FYhDX
         nUIf1NWguIgqypeIiim9aTOE+4S2+CUCCCljtMYRm+cLbHfSbjn26nmhqXyV4vbcf7oF
         BfAdzJ/BhrAqOKUpxvccpTGEWdE7Gl7xi5EvwCpX5MAFxF1jABgW8u23YfqfdM3sD9HF
         jpZkevYEFxX3gJs44YeX3UNdDH0ud1MUfOQIb/gNHphzHoPjT11sSDex+bPKqq0tNkjm
         kviZEUKVCdnP/eoVJ6LqZ/+IYZmaYCiwVE+Rc7WIJ6Z149P9e8OW6svHyusVifBrwifT
         7w0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734334660; x=1734939460;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5iPuGa5HCPzSMoHYKVJCU6quqj6Ftm6FTmJ8Y7jrKjY=;
        b=Rw+QKSb3Q8FJBR+VxzXf2K6HPgTWOVNFi87G1fNg1LLVVMeyI5zkcro1uVgrE+XcUq
         3xrZVYP5h1df4MWmIB0W7GrLJtwCm+MyvI0IPJG+cFf1IFaTaEHzwnR+3uZpYdoK7vjW
         GyG1N08EvKI5vKJGA9qi6nvhh2gkKhxduJkzfRu4rCNtIqPA4wzJUBWWTN7UyX5BvM0P
         oKZlbsKf3zOXZJsiz3bDO0yJncT1VFRZBtnEEFDVPrMvjVKftm0NElwdHlEmtDmFBphB
         WzHlvYciATmssgeHjdvreAHRiOZWz2iNRBOw4NxAaxbh0wid5ei2jLO79JTANwi+jhJs
         cL7w==
X-Forwarded-Encrypted: i=1; AJvYcCVOJKJuoPz4bYnvK4QEf33qOL4hL0WmR5MdBj5ouAWjiNqpBpcizgnZLGEXGKeAeaetkgNf+hL41nN0wq4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yymz9F3qI6iTPL3NW7ExkbCVRF1HN9lFM+K8RscH8vnHcth16CS
	zMw15n89SJJvUVoQFcNBFGlOlB2NBI6EXGdyumCJ0foEmdj9hoD4q5MdTO6PmUROsw1NTFirvDy
	Qpb5B9etATOHdNLtjVpVjj06PZhE=
X-Gm-Gg: ASbGncv70/Zaj7UKiFv571Z7KWqWz7BbdixGnmywQOhmyGa5vBs0cx7pVqC6Ox66fwj
	KtCiHqL3ItldOGS9mHYD155N4JE0R4vs4+H0xhg==
X-Google-Smtp-Source: AGHT+IHS63Q6kudZHLBAZ4BJhW4K+vF5Mpn4FrFYNUREmn4GTgSj6jzvQ7PEVfOwJXgStCjHnEBU1/pcbfhxC5Tz9oc=
X-Received: by 2002:a2e:8608:0:b0:300:1bf1:df23 with SMTP id
 38308e7fff4ca-3025443fccbmr27413781fa.12.1734334660233; Sun, 15 Dec 2024
 23:37:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241213145809.2918-1-ubizjak@gmail.com> <86bjxfsdw0.wl-maz@kernel.org>
In-Reply-To: <86bjxfsdw0.wl-maz@kernel.org>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Mon, 16 Dec 2024 08:37:28 +0100
Message-ID: <CAFULd4YY0BvbjtF=6wG9CoZo7ZLpAOFCk_fzuQ5gVOQ2D3SR=A@mail.gmail.com>
Subject: Re: [PATCH 1/3] KVM: arm64: timers: Fix percpu address space issues
 in kvm_timer_hyp_init()
To: Marc Zyngier <maz@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Oliver Upton <oliver.upton@linux.dev>, 
	Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 13, 2024 at 6:15=E2=80=AFPM Marc Zyngier <maz@kernel.org> wrote=
:
>
> On Fri, 13 Dec 2024 14:57:52 +0000,
> Uros Bizjak <ubizjak@gmail.com> wrote:
> >
> > Cast return value from kvm_get_running_vcpus() in the __percpu
> > address space to the generic address space via uintptr_t [1]
> > to fix a couple of:
> >
> > arch_timer.c:1395:66: warning: incorrect type in argument 2 (different =
address spaces)
> > arch_timer.c:1395:66:    expected void *vcpu_info
> > arch_timer.c:1395:66:    got struct kvm_vcpu *[noderef] __percpu *
> >
> > sparse warnings.
> >
> > There were no changes in the resulting object files.
> >
> > [1] https://sparse.docs.kernel.org/en/latest/annotations.html#address-s=
pace-name
> >
> > Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> > Cc: Marc Zyngier <maz@kernel.org>
> > Cc: Oliver Upton <oliver.upton@linux.dev>
> > Cc: Joey Gouly <joey.gouly@arm.com>
> > Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> > Cc: Zenghui Yu <yuzenghui@huawei.com>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Will Deacon <will@kernel.org>
> > ---
> >  arch/arm64/kvm/arch_timer.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm64/kvm/arch_timer.c b/arch/arm64/kvm/arch_timer.c
> > index 1215df590418..a13bb9e8dc19 100644
> > --- a/arch/arm64/kvm/arch_timer.c
> > +++ b/arch/arm64/kvm/arch_timer.c
> > @@ -1392,7 +1392,7 @@ int __init kvm_timer_hyp_init(bool has_gic)
> >
> >       if (has_gic) {
> >               err =3D irq_set_vcpu_affinity(host_vtimer_irq,
> > -                                         kvm_get_running_vcpus());
> > +                                         (void *)(uintptr_t)kvm_get_ru=
nning_vcpus());
> >               if (err) {
> >                       kvm_err("kvm_arch_timer: error setting vcpu affin=
ity\n");
> >                       goto out_free_vtimer_irq;
> > @@ -1416,7 +1416,7 @@ int __init kvm_timer_hyp_init(bool has_gic)
> >
> >               if (has_gic) {
> >                       err =3D irq_set_vcpu_affinity(host_ptimer_irq,
> > -                                                 kvm_get_running_vcpus=
());
> > +                                                 (void *)(uintptr_t)kv=
m_get_running_vcpus());
> >                       if (err) {
> >                               kvm_err("kvm_arch_timer: error setting vc=
pu affinity\n");
> >                               goto out_free_ptimer_irq;
>
> I think the fix is worse than the current code, because there is no
> real semantics behind the pointer being passed to
> irq_set_vcpu_affinity(). All that is required is that it is a non-NULL
> pointer.
>
> I expect the following hack to work just as well and not suffer from
> any sparse indigestion. Untested though.

The proposed hack also fixes sparse warnings and fixes my percpu
checker errors, but as a functional change, I have no means of testing
the proposed change on a target processor. So, I can just give:

Acked-by: Uros Bizjak <ubizjak@gmail.com>

from a percpu checker perspective.

Thanks,
Uros.


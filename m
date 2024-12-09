Return-Path: <linux-kernel+bounces-436955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8C059E8D0D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 09:10:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9347128148D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 08:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1223A214809;
	Mon,  9 Dec 2024 08:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="PTjMWAR9"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5526215079
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 08:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733731807; cv=none; b=V8hXzedO0pmvWQXBli4fnn69ZSm9YyM4UWsH/x/7YqRPweSjaCrRUZHomDJTGOGSKQg00eyvyxwLuQsTjmHty1+E4BY2KfxnsdW9NXkarL4nc5QVXzhXoupUmk/flugPN/6YBYEmbmKfcTL3bLzG78ohYaaaVklUBLTOpcYXSJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733731807; c=relaxed/simple;
	bh=e9T1tqdjsB2hx8LoVxJobchZWtItWdr11EkDA8I/jmk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qGsnP0dSQ00yjWEoE14M/I5UhiiDRbdosYUl9PHhLJFhhHVMx2uhCWJ0oBvwtp7tzcmsc/8r2U2tzVs+L1TIdnxr9hlXvL7ofM9GtKSHUpJ/v0n6LYCOJTXqFdDu2b6mf/UFPua5kJj/ms1YrZcuD/mAui1ZzgaL/eKlC3VAjaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=PTjMWAR9; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5d3ea065b79so1957015a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 00:10:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1733731804; x=1734336604; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WOdGE0llx04cHDIB0WcrC/Ji09jqKKAXDGd/eNwLnL0=;
        b=PTjMWAR9MSWkih4EngALJqbP7DguEmG0EXZ5lgpO6c+tk5P5xAPjnRmF0/4f/kW0fW
         Oee7kt3ZExZhPblbhivejZtnZ0LiMv3u8l3umyZsWUCBC4PPo1k1u8hW3y5nO5w7YT/h
         x5RbOiDliHvBjGOUvaO5sfB8ccuqKXCK96sFfDx5Tyb3XIAw4GydVCU6m408ag58hKtA
         b1Pho6ugXRa8jDB1MWb2lXb6Ud6G0PUrexDzuhRxAmAPhskH5ha+xOD+y2i1f6+OisZb
         NWa+jaB4DxLJGv0MQ2R9VXqZ+onbCPYMm2D+gNt3kj4zAzRj2R90ozoAL1foGviyQAT9
         aHbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733731804; x=1734336604;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WOdGE0llx04cHDIB0WcrC/Ji09jqKKAXDGd/eNwLnL0=;
        b=dqrVPhQmQozex5g6mPd64Bn86/AyB9GQT0qCmAAulVR0fYE9QEqVDU6p6g5mhKPuod
         IKMFJBOQ84ap51P6Q2XUPTz8YVVXYdG+MgosMtzZgSBvkfP7dLeJMDAOi1DG4bgwPzeB
         w9iOmO0J9q1w/Bq66L+S67htNmRZl/aECLiDeQwCkuoQC9HMGLBkMTAAhxn/XoqisrJo
         x9tUuG1WO0p3pUlS4rsl0iKFz21WbEOnqAcYNhhSdqu3WXDc6iCSDl8oy6gMlJOa49sT
         hAPKr4xTsUTYbt0tc0CsbxomKZjsvI0seU0U18STCBchcbnVuCQpIPxRb7agYoHE8UNc
         IJfg==
X-Forwarded-Encrypted: i=1; AJvYcCUAPdzZL6NSL+FGdwKEGlNd4Pf1JiW0nN1giAiUxmDvcKEQWH9ZorLCFQCcJ4/E2z5JNbi2WHapUT6s7FU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfYX2wjSfslwe6HnjDxiP8IbwW9LcTo2GTDnSF5BPxrsf18Gib
	pfBMLeTfNRQSrfT9TSpYbOj+hMssGHuGhHq5b094l4SixJMTLbIx/2Iil2zdMneiY51z8m/1zJa
	QEXFLFGxhTP3Z0twb/KcX+w5lS986m+ygqE57Xg==
X-Gm-Gg: ASbGncuZ924nzyTO7dyR5+VoSnXVB1dxI1wY62u/1HAJNtIwl2obir4Yr9i6SrSeWq5
	VM98ktPaaQHvVifgmqUBEIYJ+SRA4eQfgG1ZQ
X-Google-Smtp-Source: AGHT+IGNck5i4vPd2OxR76eBBx6zUGhGMnAu9BdeT9Vh0NpmJctj2kl8Ojqzeyx0WmJshY5K/xlMG+5FLizyFcfrOBI=
X-Received: by 2002:a05:6402:520d:b0:5d2:723c:a577 with SMTP id
 4fb4d7f45d1cf-5d3be6d07famr11938931a12.14.1733731803826; Mon, 09 Dec 2024
 00:10:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241120-dev-maxh-svukte-v3-v3-0-1e533d41ae15@sifive.com>
 <20241120-dev-maxh-svukte-v3-v3-3-1e533d41ae15@sifive.com> <20241125-7cfad4185ec1a66fa08ff0f0@orel>
In-Reply-To: <20241125-7cfad4185ec1a66fa08ff0f0@orel>
From: Max Hsu <max.hsu@sifive.com>
Date: Mon, 9 Dec 2024 16:09:51 +0800
Message-ID: <CAHibDyztkj3vFmZ7Gg=0QFoauO7pdm4+c16y8hQiaTkCQPc=LQ@mail.gmail.com>
Subject: Re: [PATCH RFC v3 3/3] riscv: KVM: Add Svukte extension support for Guest/VM
To: Andrew Jones <ajones@ventanamicro.com>
Cc: Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Anup Patel <anup@brainfault.org>, Atish Patra <atishp@atishpatra.org>, 
	Palmer Dabbelt <palmer@sifive.com>, linux-riscv@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, Samuel Holland <samuel.holland@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Okay, I understand it now, since the Guest OS may utilize the Svukte
extension simply by setting the senvcfg.UKTE without any trap.
In the view of VMM, the Svukte extension should be always presented.

I'll add the extra entry in the kvm_riscv_vcpu_isa_disable_allowed()
for the v4 patches.

Thanks, Anup, Paul, and Andrew for the patience and detailed
explanation.

Best,
Max Hsu

On Mon, Nov 25, 2024 at 8:08=E2=80=AFPM Andrew Jones <ajones@ventanamicro.c=
om> wrote:
>
> On Wed, Nov 20, 2024 at 10:09:34PM +0800, Max Hsu wrote:
> > Add KVM_RISCV_ISA_EXT_SVUKTE for VMM to detect the enablement
> > or disablement the Svukte extension for Guest/VM
> >
> > Reviewed-by: Samuel Holland <samuel.holland@sifive.com>
> > Signed-off-by: Max Hsu <max.hsu@sifive.com>
> > ---
> >  arch/riscv/include/uapi/asm/kvm.h | 1 +
> >  arch/riscv/kvm/vcpu_onereg.c      | 1 +
> >  2 files changed, 2 insertions(+)
> >
> > diff --git a/arch/riscv/include/uapi/asm/kvm.h b/arch/riscv/include/uap=
i/asm/kvm.h
> > index 4f24201376b17215315cf1fb8888d0a562dc76ac..158f9253658c4c28a533b2b=
da179fb48bf41e1fc 100644
> > --- a/arch/riscv/include/uapi/asm/kvm.h
> > +++ b/arch/riscv/include/uapi/asm/kvm.h
> > @@ -177,6 +177,7 @@ enum KVM_RISCV_ISA_EXT_ID {
> >       KVM_RISCV_ISA_EXT_ZAWRS,
> >       KVM_RISCV_ISA_EXT_SMNPM,
> >       KVM_RISCV_ISA_EXT_SSNPM,
> > +     KVM_RISCV_ISA_EXT_SVUKTE,
> >       KVM_RISCV_ISA_EXT_MAX,
> >  };
> >
> > diff --git a/arch/riscv/kvm/vcpu_onereg.c b/arch/riscv/kvm/vcpu_onereg.=
c
> > index 5b68490ad9b75fef6a18289d8c5cf9291594e01e..4c3a77cdeed0956e21e53d1=
ab4e948a170ac5c5c 100644
> > --- a/arch/riscv/kvm/vcpu_onereg.c
> > +++ b/arch/riscv/kvm/vcpu_onereg.c
> > @@ -43,6 +43,7 @@ static const unsigned long kvm_isa_ext_arr[] =3D {
> >       KVM_ISA_EXT_ARR(SVINVAL),
> >       KVM_ISA_EXT_ARR(SVNAPOT),
> >       KVM_ISA_EXT_ARR(SVPBMT),
> > +     KVM_ISA_EXT_ARR(SVUKTE),
> >       KVM_ISA_EXT_ARR(ZACAS),
> >       KVM_ISA_EXT_ARR(ZAWRS),
> >       KVM_ISA_EXT_ARR(ZBA),
> >
> > --
> > 2.43.2
>
> Anup raised the missing entry in kvm_riscv_vcpu_isa_disable_allowed() in
> the last review. An additional paragraph was added to the cover letter fo=
r
> this review, but I think there's still a misunderstanding. If the guest
> can always use the extension (whether it's advertised in its ISA string
> or not), then that means it cannot be disabled from the perspective of
> the VMM. The only ISA extensions which may be disabled are the ones that
> trap on their use, allowing KVM to emulate responses which a physical har=
t
> without the extension would produce.
>
> Thanks,
> drew


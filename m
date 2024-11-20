Return-Path: <linux-kernel+bounces-415804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6A49D3CC8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 14:53:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E3CF2847B1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 13:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 365581A0AF5;
	Wed, 20 Nov 2024 13:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="CSrzyvwe"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8AC31A2C19
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 13:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732110748; cv=none; b=Pj3M7ZMbPg4L4JYEjk+z0l47iL5T0RDhgqhTNvCNSOFmhGlEBcEp7xFeHlpjvYpds38of9am5Ybw/3VhyHN5usRIqOIhYtJROiZ/r0UMkxdfSygmxuKE6NM7IGj+yzW+sXm3sta1Z7H8LT6CmR/GxT/50CNR+BVWpmq0lJ3MpnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732110748; c=relaxed/simple;
	bh=DOSQQjHa5fYjdBFPaZqktVFE57KFQTPVxcxUoIrmOe8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JfpcbJmxhHElOEwHHjJfvrR0KSzPma1XunhFreJlttcpeuaBFCvT033KC1VZ99vQTFimhnZPw7P9hbWvVy6zYcZhhbFHEX5v7Ro7UDnh79Zz/T3v7+24fDkGNTTwmjB2WyE35H0ZoiwWOeGZwDfocqPoVxxhpydk25mVENSWQXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=CSrzyvwe; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a9eb3794a04so812606266b.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 05:52:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1732110744; x=1732715544; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oF1WJd5o8NNk5bxo210yPA8z3YQUEtaEDUj0L4ZArio=;
        b=CSrzyvweCuGbm4hPJ6EOxOiLc/4EQ40loA3Q8zpgMlLMjV1MkAtH6e9sb0dHEARNJv
         U1FHDHng00Ozo1HczbCXnsi7uoe/S2a4Zjv+QTbbZByA2oOH1hT6QajssMjLhKX+2jx/
         AeEJ9rAIzPkNa+WRfUh1V9vtalsWrJ04504zZsy5geB8CGjrUR71I7L3KmElwnMxPEgX
         n6Y+5Gi3hFyDHigl58I3EdYJPRwvQwQ6QSP07wzGWUXtNnMRZpVZFUVbDldu4+HMVSGO
         TaC0hAeqhJAoTGGEgnuWZh6U5mvsDcOBy81efhHZap+6erX0fWDBxDODDy+KyKeEPVte
         GFvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732110744; x=1732715544;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oF1WJd5o8NNk5bxo210yPA8z3YQUEtaEDUj0L4ZArio=;
        b=OqzUFSdBVeTVObylip8GLb5aUUjCoOo7W6qKCxcz/P5CSiKPUXU47hoLD40b7a3a+Z
         og2Mlm+MNCLQlXzA93ko+Hs4gMiGjFjyYuFEFI6+4Mbw1TnOKhvQG9ModbdYcSHwLqYf
         W4XkDNCb8RAukpVaS5Vzv1yLvUHlCYEwnCFGymWGlfy7GlFutVYn039PhluZ3ZxI20yx
         +CO8UswWAB+shzYSC02262QOTmI6bk8EEQgxYvxD7nFrHs8TOR+zGgYoVt2VlsO+4pdt
         iSxAeOnbfLF6tKddrQLOYESvaKTKaMDQJaXXAxpH0M98us6v89xltuQULBdZZYN2Ry/F
         BXaw==
X-Forwarded-Encrypted: i=1; AJvYcCUks8dWR0ydpOKoO9+HWzxsmNpI53KaUGc8ahQC/oWRxzuQ0eq1G3rxYMdZYdxxKyrlCxXV+IT5g5Gy6IA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5OSzosZGf4kzJduqZ/QQSWJvbXzXF+4XIb7fcCK2XnXFvxvBc
	Sq3pcV6cfKsLd8tHzuB7erdNNd5pSlwl6Ka6DEtO57BYYfrZ7Sss6xNo9KLq2wVsdklJvCn0fhp
	MJotULiGaxLcbtAg4UzfTs6hnW5FCfa3zltEd4A==
X-Google-Smtp-Source: AGHT+IHQbSPmIRk+nyxcCDhL6psKoFpre2KnuKJw0d51DE1Qt3M4MVBURAlZdsR8Cf/ZQ8CcHiCj6EIuYVVKQP3ds8U=
X-Received: by 2002:a17:906:dac8:b0:a9a:6b4c:9d2c with SMTP id
 a640c23a62f3a-aa4dd761c7dmr250067266b.59.1732110744083; Wed, 20 Nov 2024
 05:52:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240927-dev-maxh-svukte-rebase-2-v2-0-9afe57c33aee@sifive.com>
 <20240927-dev-maxh-svukte-rebase-2-v2-3-9afe57c33aee@sifive.com>
 <CAAhSdy0ncLTAjEE1s-GWL95sscxwQFsKn1rXyA1_VVfk1bQBiw@mail.gmail.com>
 <CAHibDywpKUE7r4UfcudDSBZCM=JAC5s40uf+PwQE+oMvZy4aVA@mail.gmail.com> <CAK9=C2WEU53TD+tnWRLC1iLRf+j607s=bZXevkogTnr-cmhPGw@mail.gmail.com>
In-Reply-To: <CAK9=C2WEU53TD+tnWRLC1iLRf+j607s=bZXevkogTnr-cmhPGw@mail.gmail.com>
From: Max Hsu <max.hsu@sifive.com>
Date: Wed, 20 Nov 2024 21:52:13 +0800
Message-ID: <CAHibDyxWBHeKOx=sT63EmEwhwyAYMQ3TE2tkOSK8V45PhjztPA@mail.gmail.com>
Subject: Re: [PATCH RFC v2 3/3] riscv: KVM: Add Svukte extension support for Guest/VM
To: Anup Patel <apatel@ventanamicro.com>
Cc: Anup Patel <anup@brainfault.org>, Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Atish Patra <atishp@atishpatra.org>, Palmer Dabbelt <palmer@sifive.com>, 
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, Samuel Holland <samuel.holland@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Anup,

From your reply, I think my commit message was misleading.
Therefore, I will send RFC v3 patches and explain the guest scenario in the
cover letter.

Thanks for the suggestion.

Best regards,
Max Hsu

On Mon, Nov 4, 2024 at 9:19=E2=80=AFPM Anup Patel <apatel@ventanamicro.com>=
 wrote:
>
> On Mon, Nov 4, 2024 at 1:14=E2=80=AFPM Max Hsu <max.hsu@sifive.com> wrote=
:
> >
> > Hi Anup,
> >
> > Thank you for the suggestion.
> >
> > I=E2=80=99m not entirely sure if I fully understand it, but I believe t=
he
> > hypervisor should be able to disable the Svukte extension.
> >
> > Inside the switch-case of kvm_riscv_vcpu_isa_disable_allowed(),
> > the default case breaks and returns true.
> >
> > So that means when the KVM_RISCV_ISA_EXT_SVUKTE passed into
> > kvm_riscv_vcpu_isa_disable_allowed() it will return true.
> >
> > If I've misunderstood, please let me know.
>
> I don't see any code in this patch which disables/enables Svukte for
> Guest based on KVM ONE_REG interface.
>
> Regards,
> Anup
>
> >
> > Best regards,
> > Max Hsu
> >
> > On Fri, Oct 25, 2024 at 3:17=E2=80=AFAM Anup Patel <anup@brainfault.org=
> wrote:
> > >
> > > On Fri, Sep 27, 2024 at 7:12=E2=80=AFPM Max Hsu <max.hsu@sifive.com> =
wrote:
> > > >
> > > > Add KVM ISA extension ONE_REG interface to allow VMM tools to
> > > > detect and enable Svukte extension for Guest/VM.
> > > >
> > > > Reviewed-by: Samuel Holland <samuel.holland@sifive.com>
> > > > Signed-off-by: Max Hsu <max.hsu@sifive.com>
> > > > ---
> > > >  arch/riscv/include/uapi/asm/kvm.h | 1 +
> > > >  arch/riscv/kvm/vcpu_onereg.c      | 1 +
> > > >  2 files changed, 2 insertions(+)
> > > >
> > > > diff --git a/arch/riscv/include/uapi/asm/kvm.h b/arch/riscv/include=
/uapi/asm/kvm.h
> > > > index e97db3296456e19f79ca02e4c4f70ae1b4abb48b..41b466b7ffaec421e83=
89d3f5b178580091a2c98 100644
> > > > --- a/arch/riscv/include/uapi/asm/kvm.h
> > > > +++ b/arch/riscv/include/uapi/asm/kvm.h
> > > > @@ -175,6 +175,7 @@ enum KVM_RISCV_ISA_EXT_ID {
> > > >         KVM_RISCV_ISA_EXT_ZCF,
> > > >         KVM_RISCV_ISA_EXT_ZCMOP,
> > > >         KVM_RISCV_ISA_EXT_ZAWRS,
> > > > +       KVM_RISCV_ISA_EXT_SVUKTE,
> > > >         KVM_RISCV_ISA_EXT_MAX,
> > > >  };
> > > >
> > > > diff --git a/arch/riscv/kvm/vcpu_onereg.c b/arch/riscv/kvm/vcpu_one=
reg.c
> > > > index b319c4c13c54ce22d2a7552f4c9f256a0c50780e..67237d6e53882a9fcd2=
cf265aa1704f25cc4a701 100644
> > > > --- a/arch/riscv/kvm/vcpu_onereg.c
> > > > +++ b/arch/riscv/kvm/vcpu_onereg.c
> > > > @@ -41,6 +41,7 @@ static const unsigned long kvm_isa_ext_arr[] =3D =
{
> > > >         KVM_ISA_EXT_ARR(SVINVAL),
> > > >         KVM_ISA_EXT_ARR(SVNAPOT),
> > > >         KVM_ISA_EXT_ARR(SVPBMT),
> > > > +       KVM_ISA_EXT_ARR(SVUKTE),
> > > >         KVM_ISA_EXT_ARR(ZACAS),
> > > >         KVM_ISA_EXT_ARR(ZAWRS),
> > > >         KVM_ISA_EXT_ARR(ZBA),
> > >
> > > The KVM_RISCV_ISA_EXT_SVUKTE should be added to the
> > > switch-case in kvm_riscv_vcpu_isa_disable_allowed() because
> > > hypervisor seems to have no way to disable Svukte for the Guest
> > > when it's available on the Host.
> > >
> > > Regards,
> > > Anup
> >


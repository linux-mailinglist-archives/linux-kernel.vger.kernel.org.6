Return-Path: <linux-kernel+bounces-394906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC579BB5C1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 14:20:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7338B1C21320
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 13:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DD7D42A91;
	Mon,  4 Nov 2024 13:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="RHM0y5Ap"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1BD82AF0E
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 13:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730726369; cv=none; b=K9JYNzpLoqpe4gHaGGFMM20e7bfC2RwD3RvrjPiEmTgkNKEiiL+8/1biDcBDv4ZKVERaWgDxS/jF+nO00AByCAaz/RiLU+jctSjtAzeCb6Ro2mtguC0naQRcTEdQLnnitrux6Q7Juh6GPkPxJYF7AkWNtx5G0p140qz67vE7CME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730726369; c=relaxed/simple;
	bh=scUb7SAwqAl5EEyO2kXhSL71Qki0G03FL4CcVLoFIho=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sTwBdX6jgl/S1EbErvCpBQ64WvAPt5dTZvkNCycRDj9Wgl9X2qtLKvFv12kd19/X7/vPclgpXUuPCM6c4bFF6xtR6b3IvE/UX02FL13Fd0P+ZdH9FHIRqj4+7c/vwveotFyP2zd7GKJr8v1y+mZcP2vp7HYYaBkbqW6JqmmOEn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=RHM0y5Ap; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2fb3ce15172so49960331fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 05:19:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1730726366; x=1731331166; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lARrYvZxE2uyY6URVf+ZDkFNyhIinmek/ei9ImL8GSc=;
        b=RHM0y5ApaBLTa21bykgZ6lN+4MQOatomuHvR+RMSHUhjOqiYpJCjsdWRsXsufSj7yK
         iJlYte9fdREFH6ZVkEDsQPl5ldwWnZHJ/FQLGU4BUpbIHjbyc+Qzm/etMXvN+j5RdsAy
         2rpdvhnVemZQa/1NOafqAJ6R/k0qbCtzRVgT9ohc6S2C6MeLhmA+0kBt/cYiMnA40sUI
         yKTTABYAborJ2FJt49TKuD2DaDJP5UCZItvIoVPnY7euIxJiJLTynx1CtX0aeWdaSDfI
         3Hjv3Q6/4X+uPu/rAw9rAA0awE9lhVWma5/QlTkXgNtR4Ln9FbXUIe+/xBgBB62CSkXD
         l9nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730726366; x=1731331166;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lARrYvZxE2uyY6URVf+ZDkFNyhIinmek/ei9ImL8GSc=;
        b=a4Qb/a9p6aJE4+eCZLKGK9LO1wfg3CQbzsF21fUgN4lJVSXn2THM8pY4rLyXfN+TiZ
         jGwriVbG7SRNAFijET9n++d2xFhxwOSQMzvNLzNGIgrmPcsU108OH8nmtE8zU5qPZpLp
         0UXl7ZL3LMG/vmJfkxVE7Z3bFtFjv7EXWp+2eqtBOi3foVsKZHayVDMRry4COpcb8AA1
         HB1YUF1tE/o3HzVgo2QFXYEqXi/Vfpp31k4BupKws8Ahb8M2nFHZYY1NNKtXyWbMd2zq
         TfkkCDrsSgkF9Zyu+gEoSph8tlOHdRldD8M9aeSQNEX9oJoQnmCaFRevBrm0hZioTKco
         gcFA==
X-Forwarded-Encrypted: i=1; AJvYcCXGEyxw3rTNaTm0dGgW7qEi32hRHWYTGrsMxh4imlg2plcf/IFCce6FY4e+ms7BTJ0ZQB8UaguKqhxYUjk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx26LPlfeSeVqbLYYaPC7MFdyRtBnTAlLZnbgj3jRls7I4ap1iV
	r4VkliJWVyOUUG7sa8ROCZQMrXW4in8Dv9bku6hV2nYLmakZmFdQNymekxmVdYImDy1wXNhth1e
	lxLyKB+1DWqFix8sTIZnNurHzTnMTdvY8w4WkSA==
X-Google-Smtp-Source: AGHT+IGhPab8jh+uf869h58p1p0BRB4pFjO0xN4TR4JkldBqulhRLCRm6iMFCtQY3hH8h2hEmFSyTlBKp0y/jc43UKM=
X-Received: by 2002:a2e:a908:0:b0:2fa:d464:32d3 with SMTP id
 38308e7fff4ca-2fedb488ad0mr44010011fa.20.1730726365811; Mon, 04 Nov 2024
 05:19:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240927-dev-maxh-svukte-rebase-2-v2-0-9afe57c33aee@sifive.com>
 <20240927-dev-maxh-svukte-rebase-2-v2-3-9afe57c33aee@sifive.com>
 <CAAhSdy0ncLTAjEE1s-GWL95sscxwQFsKn1rXyA1_VVfk1bQBiw@mail.gmail.com> <CAHibDywpKUE7r4UfcudDSBZCM=JAC5s40uf+PwQE+oMvZy4aVA@mail.gmail.com>
In-Reply-To: <CAHibDywpKUE7r4UfcudDSBZCM=JAC5s40uf+PwQE+oMvZy4aVA@mail.gmail.com>
From: Anup Patel <apatel@ventanamicro.com>
Date: Mon, 4 Nov 2024 18:49:15 +0530
Message-ID: <CAK9=C2WEU53TD+tnWRLC1iLRf+j607s=bZXevkogTnr-cmhPGw@mail.gmail.com>
Subject: Re: [PATCH RFC v2 3/3] riscv: KVM: Add Svukte extension support for Guest/VM
To: Max Hsu <max.hsu@sifive.com>
Cc: Anup Patel <anup@brainfault.org>, Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Atish Patra <atishp@atishpatra.org>, Palmer Dabbelt <palmer@sifive.com>, 
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, Samuel Holland <samuel.holland@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 4, 2024 at 1:14=E2=80=AFPM Max Hsu <max.hsu@sifive.com> wrote:
>
> Hi Anup,
>
> Thank you for the suggestion.
>
> I=E2=80=99m not entirely sure if I fully understand it, but I believe the
> hypervisor should be able to disable the Svukte extension.
>
> Inside the switch-case of kvm_riscv_vcpu_isa_disable_allowed(),
> the default case breaks and returns true.
>
> So that means when the KVM_RISCV_ISA_EXT_SVUKTE passed into
> kvm_riscv_vcpu_isa_disable_allowed() it will return true.
>
> If I've misunderstood, please let me know.

I don't see any code in this patch which disables/enables Svukte for
Guest based on KVM ONE_REG interface.

Regards,
Anup

>
> Best regards,
> Max Hsu
>
> On Fri, Oct 25, 2024 at 3:17=E2=80=AFAM Anup Patel <anup@brainfault.org> =
wrote:
> >
> > On Fri, Sep 27, 2024 at 7:12=E2=80=AFPM Max Hsu <max.hsu@sifive.com> wr=
ote:
> > >
> > > Add KVM ISA extension ONE_REG interface to allow VMM tools to
> > > detect and enable Svukte extension for Guest/VM.
> > >
> > > Reviewed-by: Samuel Holland <samuel.holland@sifive.com>
> > > Signed-off-by: Max Hsu <max.hsu@sifive.com>
> > > ---
> > >  arch/riscv/include/uapi/asm/kvm.h | 1 +
> > >  arch/riscv/kvm/vcpu_onereg.c      | 1 +
> > >  2 files changed, 2 insertions(+)
> > >
> > > diff --git a/arch/riscv/include/uapi/asm/kvm.h b/arch/riscv/include/u=
api/asm/kvm.h
> > > index e97db3296456e19f79ca02e4c4f70ae1b4abb48b..41b466b7ffaec421e8389=
d3f5b178580091a2c98 100644
> > > --- a/arch/riscv/include/uapi/asm/kvm.h
> > > +++ b/arch/riscv/include/uapi/asm/kvm.h
> > > @@ -175,6 +175,7 @@ enum KVM_RISCV_ISA_EXT_ID {
> > >         KVM_RISCV_ISA_EXT_ZCF,
> > >         KVM_RISCV_ISA_EXT_ZCMOP,
> > >         KVM_RISCV_ISA_EXT_ZAWRS,
> > > +       KVM_RISCV_ISA_EXT_SVUKTE,
> > >         KVM_RISCV_ISA_EXT_MAX,
> > >  };
> > >
> > > diff --git a/arch/riscv/kvm/vcpu_onereg.c b/arch/riscv/kvm/vcpu_onere=
g.c
> > > index b319c4c13c54ce22d2a7552f4c9f256a0c50780e..67237d6e53882a9fcd2cf=
265aa1704f25cc4a701 100644
> > > --- a/arch/riscv/kvm/vcpu_onereg.c
> > > +++ b/arch/riscv/kvm/vcpu_onereg.c
> > > @@ -41,6 +41,7 @@ static const unsigned long kvm_isa_ext_arr[] =3D {
> > >         KVM_ISA_EXT_ARR(SVINVAL),
> > >         KVM_ISA_EXT_ARR(SVNAPOT),
> > >         KVM_ISA_EXT_ARR(SVPBMT),
> > > +       KVM_ISA_EXT_ARR(SVUKTE),
> > >         KVM_ISA_EXT_ARR(ZACAS),
> > >         KVM_ISA_EXT_ARR(ZAWRS),
> > >         KVM_ISA_EXT_ARR(ZBA),
> >
> > The KVM_RISCV_ISA_EXT_SVUKTE should be added to the
> > switch-case in kvm_riscv_vcpu_isa_disable_allowed() because
> > hypervisor seems to have no way to disable Svukte for the Guest
> > when it's available on the Host.
> >
> > Regards,
> > Anup
>


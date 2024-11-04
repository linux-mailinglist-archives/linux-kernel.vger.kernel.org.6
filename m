Return-Path: <linux-kernel+bounces-394321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F1889BAD5F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 08:44:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03EE7280FED
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 07:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19B9519DF53;
	Mon,  4 Nov 2024 07:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="IuFEQVEg"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94E719993E
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 07:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730706277; cv=none; b=K8xR+7/ozT97SgLWZM+rq98rSSjx1eIrFBtYqj/eL5tCob2BXqKwr8s9axHz2EYFVwcqzHzllNdIyUpkkA9yBL+dYXvmW/VxbCd8jr9lzXntET0Ntgy/g6nTcBUCaQMIvuAO3E+xpZcS0lpS+qOzy1tDmsjp5cVCFvdCtVbZWqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730706277; c=relaxed/simple;
	bh=3KHj8uEqJirMKpCWT5YbQY/pJhcJbQL7gGQaWllcVwg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uYRpKG2zfNhoeIXseCixH5pYNmPbwEB0ID6nrbojv2WOfJDFb4Mgw8/1wG393RnRTdjmVteVE5WmwcCrwewz/ifmeQFRyVnwerR3BjIBi6RqeLUlRgnWi0JmRnbvLJxxxYuLPZgb8PI/aLk416UPKILWGr5LO34xGunnr7Bd+zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=IuFEQVEg; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a9a4031f69fso617286266b.0
        for <linux-kernel@vger.kernel.org>; Sun, 03 Nov 2024 23:44:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1730706273; x=1731311073; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C1UzoUW+225YzvqE1f3m2N8UQrWxc0odLIz4t11IfNg=;
        b=IuFEQVEgTUtMCdc/caf7utELN3o6xuugv9D9LoqelYYb7SdbItupOH4Z2+9XThBimF
         ejTD6DIELWIzmRJK9+Eg46TaMzYiTZCg5XeteyTTzWZK6pRI/3pTlELFkOmdnzicorOZ
         ROIxpXSRVDL3SxKF72mtNWhW3ukMFvASJ4gfugZEMVNdOya+kKf/H+rWforoH7NgJXWI
         c1zErMGoiXPyhYFu38AGjWT6NicIZpTQcADnoUUCgmL6xHhRbUOnqKx4aH6LLOn+AnW8
         LMyFZGkLidj5M10yFCXf29qzyLkqHbwPrMsqCOG+8lfnFmRVxpNUbbAIsFm/S5gBW4Mn
         TF6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730706273; x=1731311073;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C1UzoUW+225YzvqE1f3m2N8UQrWxc0odLIz4t11IfNg=;
        b=XdmpTZbsFo9PdSeE1j+Sq0E2UUD7Nk5Cp0+smWpGxShNmNWkdD1wZjA2OYMw11hlmV
         VqioA74tp0ilw+pVDl91d4difYIMMKc+xqwj5a1rOnSdFWzbWPC6QDwMvBc5BZ9FekbL
         y10w44NQ3OBdBIaeH82OGC2P7rGzOFCyxRfKud1xv7qAmoofeHaTex672Ge69KU7byTJ
         3KIfh70WyA7ljmU+uzEyUseE3mQ6EVMkipod4nL6p6RjluGR0BRVJ7FEy5TenfHx7fqg
         Oi8PRLzg7DUxqgo1GL2NHQwTkhcY6xUI66zaNcxKHDh74vMO+ag6PKBX2uR51Nl7Rk5W
         i+yw==
X-Forwarded-Encrypted: i=1; AJvYcCXPXiPvg7vAQSPBU2oYnJvOL9XbqeY54YXEdTotnWdXl8QR1KWkMeRF4EkcOnxvcBV1gvqWDFJve1u6IAQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6RsUxmBo64LivLq1evK3BqPCRsrh6hs+lUz2yKqW6kf8KJeIE
	I3F1Uve60Fj1xpimMXIXKR5hobwY6wKRJtSi2uyr0JoUdLrCI+odbaWAHfxOVwCB8m06BHl5IIX
	HznHaCaU/lBGf+8PGFwB/DKKaKd4ZWsvOvYh5NQ==
X-Google-Smtp-Source: AGHT+IEksnR3vuhAnQrwH3mab69+1/DkM6JOYCLAfgomVfAxSyJ+/4yRefXDNLq7hexWVnxdTSNFTCh1cLhgy0PD5yI=
X-Received: by 2002:a17:907:7245:b0:a99:f8e2:edec with SMTP id
 a640c23a62f3a-a9de5d6f21cmr3120143866b.21.1730706273092; Sun, 03 Nov 2024
 23:44:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240927-dev-maxh-svukte-rebase-2-v2-0-9afe57c33aee@sifive.com>
 <20240927-dev-maxh-svukte-rebase-2-v2-3-9afe57c33aee@sifive.com> <CAAhSdy0ncLTAjEE1s-GWL95sscxwQFsKn1rXyA1_VVfk1bQBiw@mail.gmail.com>
In-Reply-To: <CAAhSdy0ncLTAjEE1s-GWL95sscxwQFsKn1rXyA1_VVfk1bQBiw@mail.gmail.com>
From: Max Hsu <max.hsu@sifive.com>
Date: Mon, 4 Nov 2024 15:44:21 +0800
Message-ID: <CAHibDywpKUE7r4UfcudDSBZCM=JAC5s40uf+PwQE+oMvZy4aVA@mail.gmail.com>
Subject: Re: [PATCH RFC v2 3/3] riscv: KVM: Add Svukte extension support for Guest/VM
To: Anup Patel <anup@brainfault.org>
Cc: Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Atish Patra <atishp@atishpatra.org>, Palmer Dabbelt <palmer@sifive.com>, 
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, Samuel Holland <samuel.holland@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Anup,

Thank you for the suggestion.

I=E2=80=99m not entirely sure if I fully understand it, but I believe the
hypervisor should be able to disable the Svukte extension.

Inside the switch-case of kvm_riscv_vcpu_isa_disable_allowed(),
the default case breaks and returns true.

So that means when the KVM_RISCV_ISA_EXT_SVUKTE passed into
kvm_riscv_vcpu_isa_disable_allowed() it will return true.

If I've misunderstood, please let me know.

Best regards,
Max Hsu

On Fri, Oct 25, 2024 at 3:17=E2=80=AFAM Anup Patel <anup@brainfault.org> wr=
ote:
>
> On Fri, Sep 27, 2024 at 7:12=E2=80=AFPM Max Hsu <max.hsu@sifive.com> wrot=
e:
> >
> > Add KVM ISA extension ONE_REG interface to allow VMM tools to
> > detect and enable Svukte extension for Guest/VM.
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
> > index e97db3296456e19f79ca02e4c4f70ae1b4abb48b..41b466b7ffaec421e8389d3=
f5b178580091a2c98 100644
> > --- a/arch/riscv/include/uapi/asm/kvm.h
> > +++ b/arch/riscv/include/uapi/asm/kvm.h
> > @@ -175,6 +175,7 @@ enum KVM_RISCV_ISA_EXT_ID {
> >         KVM_RISCV_ISA_EXT_ZCF,
> >         KVM_RISCV_ISA_EXT_ZCMOP,
> >         KVM_RISCV_ISA_EXT_ZAWRS,
> > +       KVM_RISCV_ISA_EXT_SVUKTE,
> >         KVM_RISCV_ISA_EXT_MAX,
> >  };
> >
> > diff --git a/arch/riscv/kvm/vcpu_onereg.c b/arch/riscv/kvm/vcpu_onereg.=
c
> > index b319c4c13c54ce22d2a7552f4c9f256a0c50780e..67237d6e53882a9fcd2cf26=
5aa1704f25cc4a701 100644
> > --- a/arch/riscv/kvm/vcpu_onereg.c
> > +++ b/arch/riscv/kvm/vcpu_onereg.c
> > @@ -41,6 +41,7 @@ static const unsigned long kvm_isa_ext_arr[] =3D {
> >         KVM_ISA_EXT_ARR(SVINVAL),
> >         KVM_ISA_EXT_ARR(SVNAPOT),
> >         KVM_ISA_EXT_ARR(SVPBMT),
> > +       KVM_ISA_EXT_ARR(SVUKTE),
> >         KVM_ISA_EXT_ARR(ZACAS),
> >         KVM_ISA_EXT_ARR(ZAWRS),
> >         KVM_ISA_EXT_ARR(ZBA),
>
> The KVM_RISCV_ISA_EXT_SVUKTE should be added to the
> switch-case in kvm_riscv_vcpu_isa_disable_allowed() because
> hypervisor seems to have no way to disable Svukte for the Guest
> when it's available on the Host.
>
> Regards,
> Anup


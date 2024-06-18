Return-Path: <linux-kernel+bounces-219079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC9390C9A4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 13:35:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85635282EE9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 11:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F18516CD32;
	Tue, 18 Jun 2024 10:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="H3b3JD1U"
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7278D16CD1A
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 10:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718707108; cv=none; b=G2tcKNevIatp9hSNel8uHNpamcd+gwSu9amcPMj/gZI3SoNyDfkycMpsEEQ7sdn6JdTqHrtXxZxdUaTxfOu8oiVx1yNNnRCTIxpppOziKoBtHQlUSI6B6ZfPs7PPTYtpSXLfrcOd7ND6emww+DCnolQWV/tBebxuavb+JGag+4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718707108; c=relaxed/simple;
	bh=AZdoksxUtXRL1JEsmNkEFGPiEJ6sXnqW05agL++pjYA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UFUXJcMzpuqEMEDdWu6bcwcmEYdqFHrYSPBxegbkFc2h0u5Kg/JzLq1ksuIbb3166mmYIYbBYzPRqUr4mKQEqXg/ywcAijn+Lrhc7Ypg9/yRoa6stjjBKZgBfFbSBT9rnKJhzrZ3SF8jQ1FlR/GDo9EsqfDdeB8MuAcyA33/Z+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=H3b3JD1U; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6f9611fc320so2331399a34.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 03:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1718707104; x=1719311904; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qq1vFxMrgUe3BHqjNbGzwCUUF1/CTlGHAYljkroSrGs=;
        b=H3b3JD1UjPuoFpTD5eJBtWFpvPHTxvbJ6DHa66eUhR4hQcLcg0WLURUpCNr9pfM54v
         qLk4SrcsN7BcZlvTawATX7/4vGvcip1D3ctm8Y95a10XO1rt+TvNA5THtBWBWn1fDkLs
         Nsc+NpuXIRCLgtl7H09UqZXE7f8H344EdkyRpYn4vPAiwbx1n9RQaG8Fr1tsrs4SqCbE
         mqXHbCAIIzTO1r8pAxPggZuIUDKX/cM82OKTuwthBIoC/boGNnN4eYWGeY4MPh12n3OS
         4SbywuA55v1Zm4N3Pnppzyp3v4BoGAolPrvLFys59y6VQzd16KiQkk5XQLpJRC5Ipo4H
         ir9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718707104; x=1719311904;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qq1vFxMrgUe3BHqjNbGzwCUUF1/CTlGHAYljkroSrGs=;
        b=dRg6q1JRz12kW4lF9AAVYKDLi7TAzxSSRh8qeOifq1h4xAPkt+o+Q71CI4rJXTjewo
         GCoVsPfMPXfDrnDfiVyrb6Aabv+QkNWU2e1Xbw+tMZrdOrfjXY2kSGkbP2VD0Bd0j/2t
         HKh9gAEE7/AhAOK1Ub7a+wcsKhZ4AjbFqg19h3uVDrW9/Mk8wEq05RaPR+9CY17ti1q3
         AMN7yYmz2h0P3RjOQ4M/yK9HNP9cwlJ5PgRjfwTwaI9swr40sbVBzE0FZiwQbYU/gVPW
         FrHYM929jlwMe+9TXZY0/i4u22f0XL1psqY/7BEltY9HKPWOSpbTkOYzyrfuGQDTfgNP
         n9OQ==
X-Gm-Message-State: AOJu0Yxzh4SunOZ6jdrl6hzvdb2pPRjeAw0ow+P3uFNMmVeJyXspQaJz
	pWnZgpNipe4lrd2fyNmqQ+6fn/M7x6F55m2oVwXr9viWWG5XRSNsw3ffzIgsL0JO/KWjOQicI8t
	cZa5jqNi7JC4RTYG6vGqu6zY4dQXoGDv5tWqHbg==
X-Google-Smtp-Source: AGHT+IH2vZAzENDjSgV/6akmRJ7c2RZBHzcy/7oyoiwK4Myt+lBo2Y7nfaUbFeJ8Be+9iC0edhHwfsXFlrWYewHshLA=
X-Received: by 2002:a05:6870:b4a2:b0:254:88ea:6d90 with SMTP id
 586e51a60fabf-2584285855cmr13792436fac.2.1718707104411; Tue, 18 Jun 2024
 03:38:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240605121512.32083-1-yongxuan.wang@sifive.com>
 <20240605121512.32083-3-yongxuan.wang@sifive.com> <20240605-atrium-neuron-c2512b34d3da@spud>
In-Reply-To: <20240605-atrium-neuron-c2512b34d3da@spud>
From: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Date: Tue, 18 Jun 2024 18:38:13 +0800
Message-ID: <CAMWQL2gQpHPD=bPenjD+=NP47k8n26+6KP05zogxUtsD6zY6GQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/4] dt-bindings: riscv: Add Svade and Svadu Entries
To: Conor Dooley <conor@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	kvm-riscv@lists.infradead.org, kvm@vger.kernel.org, apatel@ventanamicro.com, 
	alex@ghiti.fr, ajones@ventanamicro.com, greentime.hu@sifive.com, 
	vincent.chen@sifive.com, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 6, 2024 at 12:55=E2=80=AFAM Conor Dooley <conor@kernel.org> wro=
te:
>
> On Wed, Jun 05, 2024 at 08:15:08PM +0800, Yong-Xuan Wang wrote:
> > Add entries for the Svade and Svadu extensions to the riscv,isa-extensi=
ons
> > property.
> >
> > Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
> > ---
> >  .../devicetree/bindings/riscv/extensions.yaml | 30 +++++++++++++++++++
> >  1 file changed, 30 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/=
Documentation/devicetree/bindings/riscv/extensions.yaml
> > index 468c646247aa..1e30988826b9 100644
> > --- a/Documentation/devicetree/bindings/riscv/extensions.yaml
> > +++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
> > @@ -153,6 +153,36 @@ properties:
> >              ratified at commit 3f9ed34 ("Add ability to manually trigg=
er
> >              workflow. (#2)") of riscv-time-compare.
> >
> > +        - const: svade
> > +          description: |
> > +            The standard Svade supervisor-level extension for raising =
page-fault
> > +            exceptions when PTE A/D bits need be set as ratified in th=
e 20240213
> > +            version of the privileged ISA specification.
> > +
> > +            Both Svade and Svadu extensions control the hardware behav=
ior when
> > +            the PTE A/D bits need to be set. The default behavior for =
the four
> > +            possible combinations of these extensions in the device tr=
ee are:
> > +            1. Neither svade nor svadu in DT: default to svade.
>
> I think this needs to be expanded on, as to why nothing means svade.
>
> > +            2. Only svade in DT: use svade.
>
> That's a statement of the obvious, right?
>
> > +            3. Only svadu in DT: use svadu.
>
> This is not relevant for Svade.
>
> > +            4. Both svade and svadu in DT: default to svade (Linux can=
 switch to
> > +               svadu once the SBI FWFT extension is available).
>
> "The privilege level to which this devicetree has been provided can switc=
h to
> Svadu if the SBI FWFT extension is available".
>
> > +        - const: svadu
> > +          description: |
> > +            The standard Svadu supervisor-level extension for hardware=
 updating
> > +            of PTE A/D bits as ratified at commit c1abccf ("Merge pull=
 request
> > +            #25 from ved-rivos/ratified") of riscv-svadu.
> > +
> > +            Both Svade and Svadu extensions control the hardware behav=
ior when
> > +            the PTE A/D bits need to be set. The default behavior for =
the four
> > +            possible combinations of these extensions in the device tr=
ee are:
>
> @Anup/Drew/Alex, are we missing some wording in here about it only being
> valid to have Svadu in isolation if the provider of the devicetree has
> actually turned on Svadu? The binding says "the default behaviour", but
> it is not the "default" behaviour, the behaviour is a must AFAICT. If
> you set Svadu in isolation, you /must/ have turned it on. If you set
> Svadu and Svade, you must have Svadu turned off?
>
> > +            1. Neither svade nor svadu in DT: default to svade.
> > +            2. Only svade in DT: use svade.
>
> These two are not relevant to Svadu, I'd leave them out.
>
> > +            3. Only svadu in DT: use svadu.
>
> Again, statement of the obvious?
>
> > +            4. Both svade and svadu in DT: default to svade (Linux can=
 switch to
> > +               svadu once the SBI FWFT extension is available).
>
> Same here as in the Svade entry.
>
> Thanks,
> Conor.
>

Hi Conor,

I will update the description. Thank you!

Regards,
Yong-Xuan


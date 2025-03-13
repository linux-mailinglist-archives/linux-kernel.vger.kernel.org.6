Return-Path: <linux-kernel+bounces-558949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0B5FA5ED71
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 08:58:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DDE67A56F0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 07:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27247260361;
	Thu, 13 Mar 2025 07:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="bKf/X3bY"
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C4425F992
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 07:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741852699; cv=none; b=EjcPO+e415kSmYMOXj3ckCxdSTb81d4CJrOhQIW+KM7zML3Jsf6sf+q5wRvk6nbzAVJxs8Yf5yjFQjSBNAcy4Sq3WjNz/RSJ6fovE5eQeBqD0aHlyxd9HRdZ1MXzVaJewJQPrCupaTSEbozomxDHmHnHc3XwjJqmfuphXxQkv00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741852699; c=relaxed/simple;
	bh=upe+9WxKZinmpC3grjMLBliDqkaOdmUiq5sSYDHVSoQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rR7jHWTYj8uom2zJRTda5sbWl6P2IM7oGZMrmS2aXJEL741/ZOvYWzPIfVWOj+LxeWWNMcpP78C8EcNIg+tKjpV/hetuydsh0pftJNL+8HpSbKxF2EZ37ETFFUSKqMV0Rug9FsAP+wCivDXyT6yBXeK+HMFL12RPMAWGBRvjWTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=bKf/X3bY; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6f666c94285so6005047b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 00:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1741852696; x=1742457496; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SMNUjuT0sEsFCRID3lsOG1TNPZy1x50YvG+37FVE2ig=;
        b=bKf/X3bYE5+ikvRwopepcXVxxeFt215CHSg4PzSrw/605sFEugQHSscAaqLCpOExqO
         Qc9I6VIK+9f1V0dneFWXoDk5DvSaHGqcnoIugUvSnaBDBjjqOTvp258tAYXXdgXk13j0
         FoxaNWtFIfZFuNU5SeIbkfYYEcqImiaqeb6+qe1JTxnzrlcb1Ay9gVo7ywgOpfA5Cgjd
         8hlD/zfMRlmCGHVcAgeiGoVYHpWY0wanxUjUdeYOngFGwfRGVdCAgPbSNCJ+lPJM1T9D
         Etos0IirTOH3+I+Ciu9USiqZ2Bbsyy6smxojDaoURLp0cDTRrDBRNz+YytNu9jj0SMUQ
         TmDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741852696; x=1742457496;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SMNUjuT0sEsFCRID3lsOG1TNPZy1x50YvG+37FVE2ig=;
        b=gUu4TjFox0YXeH0//4gHgDH5bCXbQd6W3OXSizfxCTPawBPi+ikuD/eMEUjUoYJXJ9
         PLOTDYu84tJ/Q/dVEUPqaA9Bq/ivgX+Vq6DHmW/s/bLvlKfIwdK1FCP73kVDad7sBnsE
         wg5es1EVEyK3HPB1JcpPZ3HjwjKybMoDX4krvakzjoW1u9+uMjogbnKT8pdP6rJvNF1h
         bShD1F00utfbJwaNog/2+nsPoNm+rQIzSSVl+sf1LNvrGmZUlrIR9dIK5uwRGgttj98R
         xtY6DKeLezAqw8pQ4sYxghbaNB5eiLYJRJjN9kJHWgSdDY4F2QoiuMKB5NTHMGqOPZ2n
         Ct0A==
X-Forwarded-Encrypted: i=1; AJvYcCX5ZRIh+/H5/Qbi2O2hdiITt0uiADyZVgdpfCmnEm6FS6aFd6PBDdj1pO0uj7JQSM8Vg4sSyhTraS2xfNk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQiwwRDpSCp5bCjkfG0GLRM3fj7lYZfkDEaztF8du4Tysup/kn
	n2aiWYGJphoExRp+GlhXh3W13MajObwnWyDXZZm7DaRS66yRXHgTaqa6AzBfK7lfUanDxIJoJbq
	qyiZjHKDzT+U3FGOsTPSeUVmDF2PnV+LWzCDHvQ==
X-Gm-Gg: ASbGnct1Ljfx+/3ycexPb61YNy3jGneulOMLJNRdTMxPXlTSU5AsjYIn7v/e86XbTvL
	3awQ9a13PwVCodX805vljc4DOeCf7eV7MvVXzrN4wlRvHf3oP/6fTosCRqIyX4jpd2nvd654nTM
	dwbW3w2l5tmvBxOoWHL9u3hV8aTeFR
X-Google-Smtp-Source: AGHT+IGp6MvYk8pn8cuSFH/tJh1fjFagxxuHGQs84LN+E9bj1UCyjQ4i+yvES1TFbTwOnp2qVaqV1mIETgiHMesQ98o=
X-Received: by 2002:a05:690c:6412:b0:6fb:9450:b0d1 with SMTP id
 00721157ae682-6ff091ac15amr152290817b3.2.1741852695922; Thu, 13 Mar 2025
 00:58:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250311051903.3825-1-nick.hu@sifive.com> <20250311195953.GA14239-robh@kernel.org>
 <20250311-erasure-rival-f68525c21742@spud>
In-Reply-To: <20250311-erasure-rival-f68525c21742@spud>
From: Nick Hu <nick.hu@sifive.com>
Date: Thu, 13 Mar 2025 15:58:05 +0800
X-Gm-Features: AQ5f1JoArwz67rimlbvntQFgrzGWz_0QdYrn-hsKZwEE72YS-5NkcDfMe2HMQIE
Message-ID: <CAKddAkBwkVQS7UtVvXCdLxEz6bz1=_X1u1CGUPm-OHiyAD4Dsw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: timer: Add SiFive CLINT2
To: Conor Dooley <conor@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Samuel Holland <samuel.holland@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Anup Patel <anup@brainfault.org>, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Rob and Conor

Thanks to all your feedback.

On Wed, Mar 12, 2025 at 4:46=E2=80=AFAM Conor Dooley <conor@kernel.org> wro=
te:
>
> On Tue, Mar 11, 2025 at 02:59:53PM -0500, Rob Herring wrote:
> > On Tue, Mar 11, 2025 at 01:19:03PM +0800, Nick Hu wrote:
> > > Add compatible string and property for the SiFive CLINT v2.
> > >
> > > Signed-off-by: Nick Hu <nick.hu@sifive.com>
> > > Reviewed-by: Samuel Holland <samuel.holland@sifive.com>
> > > ---
> > >  .../bindings/timer/sifive,clint.yaml          | 19 +++++++++++++++++=
++
> > >  1 file changed, 19 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/timer/sifive,clint.yam=
l b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
> > > index 76d83aea4e2b..93d74c504b5f 100644
> > > --- a/Documentation/devicetree/bindings/timer/sifive,clint.yaml
> > > +++ b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
> > > @@ -36,6 +36,9 @@ properties:
> > >                - starfive,jh7110-clint   # StarFive JH7110
> > >                - starfive,jh8100-clint   # StarFive JH8100
> > >            - const: sifive,clint0        # SiFive CLINT v0 IP block
> >
> > Notice that we don't allow clint0 by itself. We shouldn't start now.
> >
> > > +      - items:
> >
> > If you don't have a specific one yet, then add '- {}' for the first
> > entry.
> >
Do you suggest something like the following?
     - items:
          - {}
          - const: sifive,clint2        # SiFive CLINT v2 IP block
        description: SiFive CLINT v2 is the HRT that supports the Zicntr

> > > +          - const: sifive,clint2        # SiFive CLINT v2 IP block
> > > +        description: SiFive CLINT v2 is the HRT that supports the Zi=
cntr
> > >        - items:
> > >            - enum:
> > >                - allwinner,sun20i-d1-clint
> > > @@ -62,6 +65,22 @@ properties:
> > >      minItems: 1
> > >      maxItems: 4095
> > >
> > > +  sifive,fine-ctr-bits:
> > > +    description: The width in bits of the fine counter.
> >
> > maximum: 15
> >
> > Unless you know of a different maximum in which case why aren't you
> > documenting that too?
>
You are right. It's my bad. The maximum width should always be 15 in
sifive,clint2.
I should update to:
 sifive,fine-ctr-bits:
    maximum: 15
    description: The width in bits of the fine counter.

if:
  not:
    properties:
      compatible:
        contains:
          const: sifive,clint2
then:
  properties:
    sifive,fine-ctr-bits: false

> I'm curious why this is not something that can be discerned from the
> compatible. It's max 15, but are there actually versions of this with a
> less-than-15-bit width?
>
The width may be various on different platforms so it is possible to
have a less-than-15-bit width.

> >
> > > +
> > > +if:
> > > +  properties:
> > > +    compatible:
> > > +      contains:
> > > +        const: sifive,clint2
> > > +then:
> > > +  properties:
> > > +    sifive,fine-ctr-bits:
> > > +      maximum: 15
> > > +else:
> > > +  properties:
> > > +    sifive,fine-ctr-bits: false
> > > +
> > >  additionalProperties: false
> > >
> > >  required:
> > > --
> > > 2.17.1
> > >

Best Regards,
Nick


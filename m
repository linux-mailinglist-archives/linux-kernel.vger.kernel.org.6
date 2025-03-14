Return-Path: <linux-kernel+bounces-560625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ADA2A60769
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 03:15:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C1AE7A5679
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 02:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EC9032C85;
	Fri, 14 Mar 2025 02:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="ESVu82dv"
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05D42E337F
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 02:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741918528; cv=none; b=iReh8ek4ipK5JWYmkpEyev4Y9rEWZzx/nzicWA1Qm0RpLgw/9W0eAOGygf8nbkKQA5mCObwRomhW1Sm47OgQhEOzGatcJWJH4eLSGoomCzqtCVGIvk+UVdCzqeKDFqFQFRCgWA38QPtj5Xo3wilbhL8f/UBMDhUBSFmhMk4zcLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741918528; c=relaxed/simple;
	bh=BKOJoz4jMZK3Ye9l6nyGiIeaObm2P8rqQcuaIeKOwbE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z+0n0JwNBq8AACij/L8ssu6tBns1FXX218jsYQh6dUFQ2lWx5/vXURGd4k8eehgRAsLw71L+o8+PJf10SADKjTqg7DijHj/c9NvSswucrdc6kOwi/GhuYoiDsNPIZaAjgro54TovkbBtwLue0HoE0ZrP4gnHE61KuRX/HMPrwrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=ESVu82dv; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e5ad75ca787so1592890276.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 19:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1741918526; x=1742523326; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T99dV3Uq7aEWaCkVGWwvQtt3V/o9AKuRHiK8eGHc9PU=;
        b=ESVu82dv6bBIU0KKkNWkFqImWWvM+tHX8aWBGAt0T55/4ekgoHM3mysqdx5kunupZB
         EsjOgbMv8g7CZ8TFEPuRxAwKAZVXb1l30f0zcsIMdI8502e4vUOzjvip1aem7NPxjN6S
         ZaeBEpr2j0uHMUyKcK9t/MIth+N2n6tT0+Nus4zyLsnEoexEKQLGbY+36SsRf+W9cuaw
         m30onRKCCuA3uOQf3seGtCvcRFTGrV286Ymg7kjmFgvFOS++hBZrhErtJvAVejY+bqrR
         hvYzNcZmhSwZG+RCln54VvAKtoCkUw04l42zlXrCiqu7yogl6hb8vQ5z8Pn2+9ykHo5V
         3mxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741918526; x=1742523326;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T99dV3Uq7aEWaCkVGWwvQtt3V/o9AKuRHiK8eGHc9PU=;
        b=e/avXTCWIWTEPqDHovGXhB7/hDT0Tb9UZ7Etd0q7S46CSiVN1DC4hS6NQryNoD4MEL
         LzOhm07oCyDpYLu7mIqbDaUJlhSlK9yBgx1968MM2qPrsrzUqZIrHdJdDflSTDxvrFhX
         BEiYxEQSLIgnsYas4Hx5fDp/LPljeCXMSTv3IDrgugRsZ4f0Ch0C7tPrIRZy5PXP+5sh
         XKJmPCnS+KKaF63eiT0FZJT9POzZBzZbcMgNHy8if+EfToBD8AVLnU54OPsxaQu8E3Fk
         VY0CzfI/XaWmpakJAXjty+3DQlTDTPFPbVDunvGZHEBRW+0i2/Mxx48mHQHtGW4M0ikz
         KpKA==
X-Forwarded-Encrypted: i=1; AJvYcCXoLoB3+UZ284+NVpOgopKooKfn4Q4QtF9eHh5PfO/sR69UtDBdCKvy4pz28z8QKh4sic2NLi7G99Uv/gE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCVYplPEuEA5ZPPzzjXjYpAVr9HEre1pKd8FIMkKsVJvRoHQEH
	ieupep/WuV3yMTgOnMKwU/s18sYfjkhSJo0TPf+Dkfk1aMO4dWqBFzwb58eoCRcjshNzWRtck4P
	siuWH1MKSz9N/wHmrixdn9JIGCQRvyr41OBMNFw==
X-Gm-Gg: ASbGncu+JC+2vWei2ERQSCYpEaAq3flfIlPO/D/xugi5oEC9gAapcdW3IT+GhM2C14s
	EUZAEiiFqF9yeth+etHl5NaQulVRLwny7kw0KCCN7PmncVk1ySuBTd1PgDj0Ww/xnRZFoVgfjYf
	MHYWc7UZ76Is0O8cdf1QaVdIxEOs5Z
X-Google-Smtp-Source: AGHT+IHZJIA2sGuuLpw4nu/kd5eWiOVpCXCqNzwuBqabCwda6Hqeys5Dm5JRzxWzQFqS/5g8VYhcKp6/4iL47c09Ssc=
X-Received: by 2002:a05:6902:2741:b0:e63:f497:6c56 with SMTP id
 3f1490d57ef6-e63f870c84fmr758036276.5.1741918525736; Thu, 13 Mar 2025
 19:15:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250311051903.3825-1-nick.hu@sifive.com> <20250311195953.GA14239-robh@kernel.org>
 <20250311-erasure-rival-f68525c21742@spud> <CAKddAkBwkVQS7UtVvXCdLxEz6bz1=_X1u1CGUPm-OHiyAD4Dsw@mail.gmail.com>
 <20250313-kimono-passport-496a312a849c@spud>
In-Reply-To: <20250313-kimono-passport-496a312a849c@spud>
From: Nick Hu <nick.hu@sifive.com>
Date: Fri, 14 Mar 2025 10:15:15 +0800
X-Gm-Features: AQ5f1JqO6TLaKc51TXJ4bdfuCtPc_Kic86Fu4xccYBge3lE03TGoc4P7PcGLanE
Message-ID: <CAKddAkCb+wAT3EcvmpoD57LFYGd8LOOUDEreFvdTnRtDjynD=g@mail.gmail.com>
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

Hi Conor

On Fri, Mar 14, 2025 at 6:34=E2=80=AFAM Conor Dooley <conor@kernel.org> wro=
te:
>
> On Thu, Mar 13, 2025 at 03:58:05PM +0800, Nick Hu wrote:
> > Hi Rob and Conor
> >
> > Thanks to all your feedback.
> >
> > On Wed, Mar 12, 2025 at 4:46=E2=80=AFAM Conor Dooley <conor@kernel.org>=
 wrote:
> > >
> > > On Tue, Mar 11, 2025 at 02:59:53PM -0500, Rob Herring wrote:
> > > > On Tue, Mar 11, 2025 at 01:19:03PM +0800, Nick Hu wrote:
> > > > > Add compatible string and property for the SiFive CLINT v2.
> > > > >
> > > > > Signed-off-by: Nick Hu <nick.hu@sifive.com>
> > > > > Reviewed-by: Samuel Holland <samuel.holland@sifive.com>
> > > > > ---
> > > > >  .../bindings/timer/sifive,clint.yaml          | 19 +++++++++++++=
++++++
> > > > >  1 file changed, 19 insertions(+)
> > > > >
> > > > > diff --git a/Documentation/devicetree/bindings/timer/sifive,clint=
.yaml b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
> > > > > index 76d83aea4e2b..93d74c504b5f 100644
> > > > > --- a/Documentation/devicetree/bindings/timer/sifive,clint.yaml
> > > > > +++ b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
> > > > > @@ -36,6 +36,9 @@ properties:
> > > > >                - starfive,jh7110-clint   # StarFive JH7110
> > > > >                - starfive,jh8100-clint   # StarFive JH8100
> > > > >            - const: sifive,clint0        # SiFive CLINT v0 IP blo=
ck
> > > >
> > > > Notice that we don't allow clint0 by itself. We shouldn't start now=
.
> > > >
> > > > > +      - items:
> > > >
> > > > If you don't have a specific one yet, then add '- {}' for the first
> > > > entry.
> > > >
> > Do you suggest something like the following?
> >      - items:
> >           - {}
> >           - const: sifive,clint2        # SiFive CLINT v2 IP block
> >         description: SiFive CLINT v2 is the HRT that supports the Zicnt=
r
> >
> > > > > +          - const: sifive,clint2        # SiFive CLINT v2 IP blo=
ck
> > > > > +        description: SiFive CLINT v2 is the HRT that supports th=
e Zicntr
> > > > >        - items:
> > > > >            - enum:
> > > > >                - allwinner,sun20i-d1-clint
> > > > > @@ -62,6 +65,22 @@ properties:
> > > > >      minItems: 1
> > > > >      maxItems: 4095
> > > > >
> > > > > +  sifive,fine-ctr-bits:
> > > > > +    description: The width in bits of the fine counter.
> > > >
> > > > maximum: 15
> > > >
> > > > Unless you know of a different maximum in which case why aren't you
> > > > documenting that too?
> > >
> > You are right. It's my bad. The maximum width should always be 15 in
> > sifive,clint2.
> > I should update to:
> >  sifive,fine-ctr-bits:
> >     maximum: 15
> >     description: The width in bits of the fine counter.
> >
> > if:
> >   not:
> >     properties:
> >       compatible:
> >         contains:
> >           const: sifive,clint2
> > then:
> >   properties:
> >     sifive,fine-ctr-bits: false
>
> I think this should be inverted, to
>
> if: properties: compatible: contains: const: sifive,clint2
> then: required: - sifive,fine-counter-bits
> else: sifive,fine-counter-bits: false
>
> since the property has no default.
>
Will update it in the next version. Thanks for the advice.

> >
> > > I'm curious why this is not something that can be discerned from the
> > > compatible. It's max 15, but are there actually versions of this with=
 a
> > > less-than-15-bit width?
> > >
> > The width may be various on different platforms so it is possible to
> > have a less-than-15-bit width.
> >
> > > >
> > > > > +
> > > > > +if:
> > > > > +  properties:
> > > > > +    compatible:
> > > > > +      contains:
> > > > > +        const: sifive,clint2
> > > > > +then:
> > > > > +  properties:
> > > > > +    sifive,fine-ctr-bits:
> > > > > +      maximum: 15
> > > > > +else:
> > > > > +  properties:
> > > > > +    sifive,fine-ctr-bits: false
> > > > > +
> > > > >  additionalProperties: false
> > > > >
> > > > >  required:
> > > > > --
> > > > > 2.17.1
> > > > >
> >
> > Best Regards,
> > Nick

Best Regards,
Nick


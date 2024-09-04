Return-Path: <linux-kernel+bounces-315307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3CC896C0D6
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 16:37:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CAB12886E4
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 14:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 920AD1DC05B;
	Wed,  4 Sep 2024 14:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SY5G7Srt"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED4A63D
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 14:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725460636; cv=none; b=HQYbGr9mbTxDgkeL8J5aedyN+kZy4CNmBDy9M2slyLnIy0Dmus5G1Zq2m8mkKMSOo+mjOfp6GVPVDPQJeXwDu3njSm1ZgBVSkzm9rOG795mmhD1OinJ2OgKhRHu2nSpjV6k+DqUZNiZspEZKmSGS72sflgD+G8uOuiq33zb97lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725460636; c=relaxed/simple;
	bh=3frdzSjr8OtlZ7o6d3n+iy4OJbVPlLX87k3pqWL5ORI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JJNDhaFYKIldHo6yOO5R8N+2dZR731uXoVrx4SpfxG6THDd1N7KW2DxsYaSXDRQ5zz40xLd5PQx54WbKeTanjYs/Bzm59i+py0KDMs5MyXL4FojjSOrMAyjcsbAZlhuq/r9ulCgPMgyB3EA8J83xXq2/PI0uK60mt24Cb5jU6lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SY5G7Srt; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a869332c2c2so146252366b.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 07:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725460633; x=1726065433; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c6Nv+IxsaEoLAT+kUwAJld/NlsgkjqcbfHigaVzrzGA=;
        b=SY5G7SrtIOSX0tfJ5KNeO3xQb+3cYg+IMyd4yWcguNlwTlCcJ2VQKXWxFXsizU/gDD
         cByP6uxcO3ltjzHzH882G2FUDNHthVLZpCwTPtMmuU6YrYiJlQLbWLqn2i+nwl/rYcKy
         hP6wHgUFTUWe+7cfbrpj9csjLiOmqiz+WuNdPbBQePVHglf6/dM+xFLOVEn/y1GUnj63
         ju52B4fSBHP0YC3ya7SYuejnUyVUczmHb9wplXM5MwvrC4Gg+fLfHXq3QHxQks4TPO/E
         L6mJ6IL9NjuGolZr1PMMxXq1qGVgMTKLMzdXixQ/UfUZmFthjPwhhnY49t4/R6o/SQkF
         wZvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725460633; x=1726065433;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c6Nv+IxsaEoLAT+kUwAJld/NlsgkjqcbfHigaVzrzGA=;
        b=Krz7/ebOKMlYgCEUNt7miFsLKgcXqJF7RevWHHPv3MVRl2XI0JL6c4faYpkseqWjKI
         nkfzT9z+49BYjL/cF81lT06mgtaWHqgVG4nD0xDSIytnMzv1Hwwc5BBDfSaVJ58UmSEO
         jT0qoKYmvk3tr6V9dUnm2TXR9np8EXduxfH5s/VbXiDkxd4O94v4A7Oc35bg+GJ8KTx5
         NC0fX+dDEJw00YId5kHuPLvWN7bkeq7SDbDMMXBXyWgJ+fJ3jRh7OpxkqTpBoGiUjr6s
         ItqT6G0Nt97zazNZMJU685eKbSZf+PxqJ81lcSliMZVIwsw51BZxlqENRQnRStUlTnrm
         dE/g==
X-Forwarded-Encrypted: i=1; AJvYcCUdZVj8WJ3dScTuq+idAZPbQ1aSXZQWik3Cp2byWkRrRUYuLnr8ROa0DT7rrbmeix3zETQBqThvy4qrob8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8KOwXLv3INjFoxsu67F+Xg/+OZ2BOq+Ed0lL2vJL0QqRHybTU
	GVGq2sNZKpIlyXWVxaUyvxTH32ktuKuRkqk1kNDUoOEAMcSnEvFpisDnJ+4lcVqmGlyxuEZmEcm
	tkP8lxyjgHVB+/VQTKy7sH44P/dI=
X-Google-Smtp-Source: AGHT+IHBWXO0INtBPk9la2bX8+Qt21D06NGd2Q2DfVZPOE4wA8vGYWeXmnkMPUAIQ1JCRFy6K+LO3LR8lrJD41puBZA=
X-Received: by 2002:a17:907:2d8e:b0:a6f:996f:23ea with SMTP id
 a640c23a62f3a-a8a430adb51mr287526366b.15.1725460632286; Wed, 04 Sep 2024
 07:37:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <TY2PR01MB3322FEDCDC048B7D3794F922CDBA2@TY2PR01MB3322.jpnprd01.prod.outlook.com>
 <ZrYMne34hVa33qKf@smile.fi.intel.com> <TY2PR01MB33222D8BE4B1107EB3A1917FCDBA2@TY2PR01MB3322.jpnprd01.prod.outlook.com>
 <ZrYjLdPryElDubaM@smile.fi.intel.com> <TY2PR01MB33224CE088EF01D57DE1BABFCD9C2@TY2PR01MB3322.jpnprd01.prod.outlook.com>
In-Reply-To: <TY2PR01MB33224CE088EF01D57DE1BABFCD9C2@TY2PR01MB3322.jpnprd01.prod.outlook.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 4 Sep 2024 17:36:35 +0300
Message-ID: <CAHp75VeMp9C04iDW5_c9owq3HP=5wvccoOuHwrSQ5SFeV+SRVA@mail.gmail.com>
Subject: Re: mfd: intel_soc_pmic_bxtwc: irq 0 issue, tmu and typec components
 fail to probe.
To: Zhang Ning <zhangn1985@outlook.com>
Cc: Andy Shevchenko <andy@kernel.org>, gregkh@linuxfoundation.org, rafael@kernel.org, 
	linux-kernel@vger.kernel.org, lee@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 4, 2024 at 5:29=E2=80=AFPM Zhang Ning <zhangn1985@outlook.com> =
wrote:
> On Fri, Aug 09, 2024 at 05:09:49PM +0300, Andy Shevchenko wrote:
> > On Fri, Aug 09, 2024 at 08:53:24PM +0800, Zhang Ning wrote:
> > > On Fri, Aug 09, 2024 at 03:33:33PM +0300, Andy Shevchenko wrote:
> > > > On Fri, Aug 09, 2024 at 08:02:43PM +0800, Zhang Ning wrote:
> > > > > Hi, Greg & Rafael
> > > > >
> > > > > recently, when I try to enable mfd components for intel_soc_pmic_=
bxtwc
> > > > > for debian kernel[0]. I find tmu and typec failed to probe.
> > > > >
> > > > > after check source code, I find irq for these two devices are 0, =
when
> > > > > use platform_get_irq, it will alway fail.
> > > > >
> > > > >         if (WARN(!ret, "0 is an invalid IRQ number\n"))
> > > > >                 return -EINVAL;
> > > > >         return ret;
> > > > >
> > > > > My workaround for debian is to hardcode irq to 0, instead to use =
api.
> > > > >
> > > > > I don't know how to write a good solution, thus send an email to =
you.
> > > >
> > > > Hold on, how the heck you got 0 in the first place?A
> > >
> > > use tmu as an example
> > >
> > > enum bxtwc_irqs_tmu {
> > >         BXTWC_TMU_IRQ =3D 0,
> > > };
> > >
> > > static const struct regmap_irq bxtwc_regmap_irqs_tmu[] =3D {
> > >         REGMAP_IRQ_REG(BXTWC_TMU_IRQ, 0, GENMASK(2, 1)),
> > > };
> > >
> > > static const struct resource tmu_resources[] =3D {
> > >         DEFINE_RES_IRQ_NAMED(BXTWC_TMU_IRQ, "TMU"),
> > > };
> > >
> > >         {
> > >                 .name =3D "bxt_wcove_tmu",
> > >                 .num_resources =3D ARRAY_SIZE(tmu_resources),
> > >                 .resources =3D tmu_resources,
> > >         },
> > >
> > > this is why I got 0, and I don't do any hack.
> >
> > Thanks for elaboration, I will look at this a bit later (may be next or=
 one
> > after next week, just returned from vacations).

>    could you share the patch link to the fix? then I could port it to
>    debian.

Sorry I was busy with other stuff (as well), I am still in the middle
of debugging that.
The issue is that the leaf drivers for some reason do not request
proper vIRQ (that should come from the secondary IRQ chip). OTOH there
is only one _similar_ design in the kernel besides this one. And when
I tried to test the version where all this appears, I couldn't boot
(yeah, I spent some time on bisecting things) the board I have (One of
pre-production variants of Intel Joule SoM).

Do you have any (most recent) kernel version that works as expected?

> > > > > [0]: https://salsa.debian.org/kernel-team/linux/-/merge_requests/=
1156/diffs

--=20
With Best Regards,
Andy Shevchenko


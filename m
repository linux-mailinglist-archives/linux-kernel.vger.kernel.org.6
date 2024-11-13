Return-Path: <linux-kernel+bounces-407378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C95AC9C6CC5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 11:23:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6459B2E603
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 10:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C16E1FB89E;
	Wed, 13 Nov 2024 10:16:02 +0000 (UTC)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5152B18A6DE;
	Wed, 13 Nov 2024 10:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731492962; cv=none; b=qaK9tKkrn/Tc8jcNu8xdHFEEM7XUyqvUCs2+x8owEYxfZsYfS9mZ6fLV3q2Pg0q+ysBg/JwSujk5kQAMTbeNvn6AdAOEEB1EP1WvnIWAAaE1T23vzGZLWSZSJ62qCRqLJpoKqb88nKERwQgRZzTYxDiECvv+M1qaok3aQa5F20w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731492962; c=relaxed/simple;
	bh=8zKUrMnMRzDAMBUHJQHzWOsN10KZz08WEg+SvH++MtE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KgUcUjYcPEAJICCX1c8G0JAFhOph2XZtZIGR41XLPqGl8tQRwtPMtyhXCcm8Ejue4NQSrCzIKrLBpUOIoeMkG5izIHNPsaYIwmR0UEUu4iEjt86rNi86T/DwGPgkicNNglDgJZ2j8M9UwrE4ef/m414bmu/s5riwjpXu//q4fhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e35e0543b07so1651944276.2;
        Wed, 13 Nov 2024 02:15:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731492957; x=1732097757;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=km5VKNF+KUEDoH6tmM2tqgAPxy8fVSjcu9J5PorMtVg=;
        b=P6IlBB1Iwc+dIHnirek5tygFWX7U0Np/uadQ4zXtzH+Eyo2aCgY5GM/RT5e9e8fcUw
         rxir/oOonV0x4VIPFLgM/RhWnwYP/Sasg+hTBnuCNTBin5raFNoBa9OIeGYZstVGzP9D
         EsWqwzRysLA27aumF0U8euGxyHxvpSlQQymo0SMqhoegDFnI5/iEOy94as8qVQkWXypH
         SiyMqJdc/GWEoNmbziR2xb5nE7p3oVA264Hr6ifwhdIuK6AkRVVSizAhi7EBLsMc09/l
         bZ3seaXxWkM2NQqGEYiDuj8iyoyR3BZjNLjh7DZhOqfW/A+vwgKwxPlGsO+yYj8J7VeS
         J6dw==
X-Forwarded-Encrypted: i=1; AJvYcCVdCXxKLsLoj5Poo9X1eFZIimCSMJdwAdffZxayWw6DZKPG2yvyKkL4b4sN8XdcJ6BX83d0QINS9CnC@vger.kernel.org, AJvYcCWa0TfzM0yEXgWsxLM4hym90cy5bMEnqf19oqtxiEXIcVDd2e83QwhpWPalaCbYcFHDl0DEwcwqlEpfgi5q@vger.kernel.org
X-Gm-Message-State: AOJu0YylA1ZeUb1djE1YayVMTdhAMMuAtePMOSgd+P+Q2pSW9KL2j6kW
	P6mRfBtzl0TlB12OYC2PJYbTs5ZKsvzImES4i5rxY+kcGJdbo4U86oN69jdt
X-Google-Smtp-Source: AGHT+IFKgX06FyGkJf7uyCmYKNh9UI+r324BqO1EXdjX7f3Co+sDRKuRLboQzePPuhFt7mrtvHifJw==
X-Received: by 2002:a05:690c:9c0a:b0:6e2:7dd:af66 with SMTP id 00721157ae682-6eca4684497mr65436877b3.19.1731492957679;
        Wed, 13 Nov 2024 02:15:57 -0800 (PST)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com. [209.85.128.174])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6ecb1088369sm4868977b3.90.2024.11.13.02.15.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Nov 2024 02:15:55 -0800 (PST)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6ea7c9226bbso67155427b3.3;
        Wed, 13 Nov 2024 02:15:55 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU1ZYvu8qTNSv4GmMy+fjG73CitifclQAQMAEndsv5GbQufejIMKaJhqgMazRVDVpPw5v4/ovJj/KNa@vger.kernel.org, AJvYcCXpUZ4x+NpinA0RvXG0ZMhKtYXhwKcP2/0lKijOkkQCZVK9+9m2yP/Y+E2hQda4LFVP3bweo3QMrhsjhXiQ@vger.kernel.org
X-Received: by 2002:a05:690c:445:b0:6e3:8760:29ba with SMTP id
 00721157ae682-6eca4c04f0bmr65699147b3.36.1731492955605; Wed, 13 Nov 2024
 02:15:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241112-am64-overlay-bool-v1-0-b9d1faff444e@solid-run.com>
 <CAL_JsqJAQswTo2eWxLw62wqb-2i=_9W84_v_tW+TSW4kgNK3_A@mail.gmail.com> <288deac4-5387-4492-9e9c-cabf77b9c0ba@solid-run.com>
In-Reply-To: <288deac4-5387-4492-9e9c-cabf77b9c0ba@solid-run.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 13 Nov 2024 11:15:44 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWUJ-nQkD-tm07uWX_TTy5Fy5JLsvedcoJ50Hi7=WnEpg@mail.gmail.com>
Message-ID: <CAMuHMdWUJ-nQkD-tm07uWX_TTy5Fy5JLsvedcoJ50Hi7=WnEpg@mail.gmail.com>
Subject: Re: [PATCH 0/2] of: add support for value "false" to of_property_read_bool
To: Josua Mayer <josua@solid-run.com>
Cc: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, Nishanth Menon <nm@ti.com>, 
	Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Jon Nettleton <jon@solid-run.com>, 
	Yazan Shhady <yazan.shhady@solid-run.com>, Rabeeh Khoury <rabeeh@solid-run.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Josua,

On Wed, Nov 13, 2024 at 10:41=E2=80=AFAM Josua Mayer <josua@solid-run.com> =
wrote:
> Am 12.11.24 um 14:46 schrieb Rob Herring:
> > On Tue, Nov 12, 2024 at 12:41=E2=80=AFAM Josua Mayer <josua@solid-run.c=
om> wrote:
> >> Boolean type properties are usually considered true if present and fal=
se
> >> when they do not exist. This works well for many in-tree board dts and
> >> existing drivers.
> >>
> >> When users need to overrride boolean values from included dts,
> >> /delete-property/ is recommend. This however does not work in overlays
> >> (addons).
> > As soon as someone needs to delete a non-boolean property, we're back
> > to the same problem.
>
> Properties can be reassigned any value, e.g. a driver default if needed.
> It should never be necessary to delete a property,
> since a suitable value may be specified instead.
>
> Booleans have two valid values, true and false,
> but somehow we cannot assign false, we can just delete the property.
>
> > If you want to fix it, you need to fix it for any
> > property.
> /delete-property/ is a language keyword used during compilation.
> When inspecting a .dtbo no trace of /delete-property/ is left.

That is the current behavior. But dtc could be modified to emit new
special __deleted_properties__ and __deleted_nodes__ nodes, just like
it already creates special __symbols__, __fixups__, and __local_fixups__
nodes.

> Hence we can't "fix" deleting properties through overlays.
> We can only "fix" (re-)assigning false to a boolean property.

So nothing prevents adding a way for a .dtbo to contain a list of
properties and/or nodes to delete...

> >> Geert pointed out [1] that there are several invitations for using
> >> strings "true" and "false" on boolean properties: [1], [2], [3].
>
> > There's always bad examples...
> >
> >> Add support for a string value "false" to be considered false on boole=
an
> >> properties by changing of_property_read_bool implementation.
>
> > Any existing s/w will treat 'foo =3D "false"' as true. It's an ABI.
>
> I was reading through the device-tree specification, it makes absolutely
> no mention of a boolean type.
>
> I believe of_property_read_bool should be capable of deriving false
> from a present property.
>
> What is up to now called bool in the kernel / device-tree,
> is actually of_property_present, or conversationally of_node_has_flag.

Indeed, so of_property_read_bool() is a misnomer, as it does
not read the actual value from the property, unlike all other
of_property_read_*() methods.

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds


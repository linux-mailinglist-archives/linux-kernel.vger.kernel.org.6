Return-Path: <linux-kernel+bounces-526796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 585DAA4036D
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 00:25:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E55719C0543
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 23:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F92A208960;
	Fri, 21 Feb 2025 23:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gcgtA5OL"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D0E17CA17
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 23:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740180348; cv=none; b=M+Dg6GeuDjseVm7tyTWqBRkq6lZLyjbNvZGruWQk7w4XUR8e5LX50+hKhjytBSm+75UuMxGLdxNPfWSmrH4EGu3r3INo+SVw6yEGp71dyCVoyrOhOWfg7HYIi7YP3g/HRqg3K2sUJ1b0cuPHs/xrLVow0ZbP96/qsavnGnPN360=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740180348; c=relaxed/simple;
	bh=SS2xJajvnKh6Chr/51nGTew/YKSyBH+KHgcj8HO8GsM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FYFRNZkGQm6T4zg7YuMUeKE2MatjyaB1+Ch7mGspT1b3HdG8VYX4bqMZZiKSaMQxIXBqhGZKCLE1Ad8UFQmYTviw1lWHaJZdSeFtd2eULAseF+iYMEXUSYyT7O9vcuR9E6T/RUBagQePC0C182l2buuUmcyx/6Z4mRCdAXZpZ/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=gcgtA5OL; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5e033c2f106so3407769a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 15:25:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740180345; x=1740785145; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JhwPcG9HO8s7xfZGsNbCdX7AUd1yrCVvMmNnJPXS/oY=;
        b=gcgtA5OLtMoL3zxfX9fbdnv7CTBoo7BTcxTmedP47nW2N3lPlZBTTJ2+IH9QHIxxGu
         qSypon65aBiq3hhsHbOpIFCNfK2oZNiNhYIrVGKcS+Yu26vPCMEjnwaMj+4B6dd9mRrt
         jDlyvsv0TTJSAc16GBK850syUKY7rC3ke88U4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740180345; x=1740785145;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JhwPcG9HO8s7xfZGsNbCdX7AUd1yrCVvMmNnJPXS/oY=;
        b=cuAHMeot6+wIGexmDq/vNCgsdj7SVfvYN9OG1U6d0D8wuwCNFJoGlSwenSI3f7KOmS
         5/VuRl0RWSWTz8EBSwNQQFPchTSSwstRXCLj0i7pNjUq8v1ObywbxM2lI0F7NeT+HcYe
         /0tTBgyhKHjcZqNp70cj2z8oE4pRb9Ygdes35F6goO06Vd4gTDmoJcdcrGwmtOWIWbM4
         7FRn3PhFgjCzgvT8WkT3xJRh+8NlpnS37L/+Rcr0zLnwPP86GCGTC+fddhyZqKC9bZLv
         PGkarsB+zl2fy7uALDmxj0myIGXIBakETwWFyX/LP6q/VtV4rQ3aDORlK7krqCdd6e/a
         EWaQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhuMy+AkKNZyGiZ/hNS/wspYC2kHb35PaAQ4J1IAmOHxzeu3dZKFHmt7q3hq14spCXy95nmjrMU3D2EeY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+sf3YXHop0SzISu722EjjmMkkJ7VN3Xsca3Hk2Ho7tYcuL4SK
	NRT2z+TglJhZ2EXXThlWm6g21f3hkaiP/KXf/8UDELO6aiheoF1WmUHdh0K41KFQLf4PhtWBq86
	+CTQI
X-Gm-Gg: ASbGncuFxDmNisjQZ4YP/L8DD7T4UNnyuFMPpdObsHgCGitFQURPbUURhNAyxf7l1M+
	JMx+yKzfzXkgwokml6mWKYuDueT/sYk43ljyiT4cu1Nc9MeA3ibBrkJsDh8opMjg/0oNm7FEMkN
	TVd+Sai1Vkj/vokoOMN5rpFzkaIflZWLT6vdFrRRrB0JHykAZxfAPXEw3G6mccoI8QYDiVIiBfi
	WWreW5IewpahEAha4jEE4Rym/o4h3Zo4dGqaI4fnXaDDJ9OnbP4hx3/ukkI7kgeE6+Irf0It/mK
	o0cjRUYxNVEL4/4odj9nj9PIk7syh3XdHlk4uaHpv+wEXqhv9nm9jaFCpUGyhw==
X-Google-Smtp-Source: AGHT+IHxClIDUuw9pfqzl/8WQnR/UvH1u87CsssvbxTc4JPvV0D5GQCbfWwyXAXjw0mQ/4koHN6YtQ==
X-Received: by 2002:a05:6402:3815:b0:5de:b438:1fdb with SMTP id 4fb4d7f45d1cf-5e0b7266b9amr10278703a12.30.1740180344932;
        Fri, 21 Feb 2025 15:25:44 -0800 (PST)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abbbbc95288sm785558866b.158.2025.02.21.15.25.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2025 15:25:44 -0800 (PST)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5deb956aa5eso3283729a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 15:25:44 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUf+W+Gqgj2TzZWYLZLb3nRN4AgqG1nIEbDS+mPE9AJAh6xXhDBMYDjFU9oOK7U+jKn3ZsfuqwBnjkCggo=@vger.kernel.org
X-Received: by 2002:a5d:47c2:0:b0:38f:2856:7dc4 with SMTP id
 ffacd0b85a97d-38f6f0c670bmr5093469f8f.55.1740180334106; Fri, 21 Feb 2025
 15:25:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250219-fix-thermal-of-v1-1-de36e7a590c4@chromium.org>
 <CAJZ5v0i=Ehi1icm4Tx6cXmdhjq-Qj8Vwv1SwzCyx5oBj-5y9hQ@mail.gmail.com> <CAJZ5v0gJGxWA=7zHYU5h=ueqQcXNt94wOAg7sqrphOUb++mAyw@mail.gmail.com>
In-Reply-To: <CAJZ5v0gJGxWA=7zHYU5h=ueqQcXNt94wOAg7sqrphOUb++mAyw@mail.gmail.com>
From: Yu-Che Cheng <giver@chromium.org>
Date: Sat, 22 Feb 2025 07:24:57 +0800
X-Gmail-Original-Message-ID: <CAKchOA0gnq8i7UFApTfaUQx=DJWAF3NkQAc10aZhW0+zctw3Vg@mail.gmail.com>
X-Gm-Features: AWEUYZl7-vzHaC1P8Qd4xK_Pd8d7lHdEurf2U-XeOtWmEgUBp7Z6JuPcQdGy4bQ
Message-ID: <CAKchOA0gnq8i7UFApTfaUQx=DJWAF3NkQAc10aZhW0+zctw3Vg@mail.gmail.com>
Subject: Re: [PATCH] thermal: of: Fix logic in thermal_of_should_bind
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Yu-Che Cheng <giver@chromium.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Chen-Yu Tsai <wenst@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Yes, it works on my side, as they look functionally equivalent.
Moving into a new function makes the control flow look more intuitive indee=
d.





On Fri, Feb 21, 2025 at 4:22=E2=80=AFAM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Wed, Feb 19, 2025 at 10:40=E2=80=AFPM Rafael J. Wysocki <rafael@kernel=
.org> wrote:
> >
> > On Wed, Feb 19, 2025 at 8:06=E2=80=AFAM Yu-Che Cheng <giver@chromium.or=
g> wrote:
> > >
> > > The current thermal_of_should_bind will stop iterating cooling-maps o=
n
> > > the first matched trip point, leading to subsequent cooling devices
> > > binding to the same trip point failing to find the cooling spec.
> > >
> > > The iteration should continue enumerating subsequent cooling-maps if =
the
> > > target cooling device is not found.
> > >
> > > Fix the logic to break only when a matched cooling device is found.
> >
> > OK, but ->
> >
> > > Fixes: 94c6110b0b13 ("thermal/of: Use the .should_bind() thermal zone=
 callback")
> > > Signed-off-by: Yu-Che Cheng <giver@chromium.org>
> > > ---
> > >  drivers/thermal/thermal_of.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_o=
f.c
> > > index 5ab4ce4daaeb..69c530e38574 100644
> > > --- a/drivers/thermal/thermal_of.c
> > > +++ b/drivers/thermal/thermal_of.c
> > > @@ -312,7 +312,8 @@ static bool thermal_of_should_bind(struct thermal=
_zone_device *tz,
> > >                                 break;
> >
> > -> I'd prefer to do a jump from here, that is
> >
> > -                                 break;
> > +                                goto put_cm_np;
> > >                 }
> > >
> > > -               break;
> >
> > and remove the break statement above altogether.
> >
> > > +               if (result)
> > > +                       break;
> > >         }
> > >
> >
> > And of course the label needs to be added too:
> >
> > +put_cm_np:
> > >         of_node_put(cm_np);
> > >
> > > ---
>
> Or even, to avoid adding a new label, move the loop from
> thermal_of_should_bind() into a new function that will be called by it
> do carry out the cooling-maps lookup, like in the attached patch.
>
> Can you check if it works for you, please?


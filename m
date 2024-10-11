Return-Path: <linux-kernel+bounces-360211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10C5C9995F1
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 02:05:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A616228497F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 00:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA44D7E1;
	Fri, 11 Oct 2024 00:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GXN37i3o"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669BB366;
	Fri, 11 Oct 2024 00:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728605140; cv=none; b=CUioKIJvDXWCZY0MS78QlnrkdLNXqY9p/WrShBHZdr/UgbmYa+/Uh+ehI9GY96mmp9uR9yI/32P1iEY1hXZQ8Iqe5O07QiPcXBq9kD393gnbxE7EEFM9THYE06mWfTvU25DvHGrWe+1flkjilVd3HHXcK3O+tKN7mOcKTVS3vC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728605140; c=relaxed/simple;
	bh=Xm/FWl+xu0YOGG+kySDr/1ytGcLKcxzic5ONZXrVc4E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zct6UrAGwK860NT/3IzdmKCziS8/qTbrOzjN1WQ9kH+MvFdBPlizPwB6Gm4P3OcGdvxExT4ib2UgeN7zCNDYwg7A4u6SSYNBMhXZe8SX/0VcCOxU/ee8b2WbQtHuvhLSecdRX3+4O7QiBhuyODD4GPRbSVQ81XHgsTKd2YrjArI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GXN37i3o; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5c935d99dc5so1425299a12.1;
        Thu, 10 Oct 2024 17:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728605137; x=1729209937; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sf7V8r5HK3udmg4PXTFWlyhTEIgEcd1NxvdHS3A9s7M=;
        b=GXN37i3oULKOBOa8kiyCWwWDH26Z3XhL+Hkig4o9PefQCiy8ANKaXnIAp6kx28SerC
         j4vKqMUdwEIK80Wf3YZP+tbxWLSUiiCocBRXsdeCmx+30NkBznRUiVXJyLwzqJqQC02e
         FcJzgZ6/04YCIfAk7ZxNJiSIrmi1IyP/lRRNVIZYHD9AvIlhWVnY1Lp7rDkQhqdMKjgL
         yZ4DpAAOjg/2HzTOyfVY8OU+Sp8Y1j+BvbLnOqLt5Seqy9XJNVQI5aruTZ8A/L+s6+Ia
         Z8ld0VuhItp428waViwCB3dwhYa8HZxQMHATy/MrGHD7T5v2JtQZ+6IXCUIwROs0i7+E
         tBbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728605137; x=1729209937;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sf7V8r5HK3udmg4PXTFWlyhTEIgEcd1NxvdHS3A9s7M=;
        b=MKOT6q8mMfsrO7MvRF28gJftY+ulTFo6L1fDVY9k9BfEjGX9U40YSj0LD5Q5iTaDQ8
         aNSf5UEgOy6Skapt95kbYmju6McNYxOY4W2eGDqPZGncjixQgMi5TAsTeMQN3uQ7cF3U
         IFvqoQ+89WpHSwLEDqNZZJCK3tj8TKPxjrcrhk9jmpkRpjEcAIxQE/hqzk7nsnFu7Ce9
         wdPaIZ9V9hyGsL+2KzGctWdD/oDeex46Br7AehMa/YD8mePk8s3Zpu2JkzEwkdmtnqFy
         TvJBl7vYzbnflC0a721i4cP7Rf0PYBUPQOpt6vVHY2xmQIiGf8jNIU8t6c3xCywyOYyP
         KNUg==
X-Forwarded-Encrypted: i=1; AJvYcCUCqIgvW3kuaDdpvVrLUrQJFkdN32P8oWPq0S06QFQ81iPAeh54yNKdpZsuxg63EftbenC7zqBEhQyk@vger.kernel.org, AJvYcCVdWHUlMVoRHpZxI+xvryF/pYnvUevhtWm2p0kzM7EPXsd0fqLhohyM1haSRGRSxicO3G3g25OtMN3aAJ3a@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1Iw4xBsAySAgyQ36wPrq0A+WvtAfderHslh9hQlbfNcf4neiN
	yQkDyIEl77MCG2ZpThgi504F++0R3IeJkHz4b+YwPr5VxdtbZkj1xZWwqUSnt8moZWBcZupKjj0
	/IzsLlY0NK1n3OFgx1bo+th7TsW8=
X-Google-Smtp-Source: AGHT+IHcWSRHmaRvrv3nzx9uKEKja1uko+ZHjWtuZTl0i8kEEFv3LovSUPiAOd0AGgCqc0oS8blEXfFcKGio/KV7iMI=
X-Received: by 2002:a05:6402:d0b:b0:5c9:16e2:4db1 with SMTP id
 4fb4d7f45d1cf-5c948c95b97mr321200a12.8.1728605136416; Thu, 10 Oct 2024
 17:05:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241005050155.61103-1-CFSworks@gmail.com> <20241005050155.61103-2-CFSworks@gmail.com>
 <ccc78255-a2c4-4144-b580-9a16aada09c2@broadcom.com>
In-Reply-To: <ccc78255-a2c4-4144-b580-9a16aada09c2@broadcom.com>
From: Sam Edwards <cfsworks@gmail.com>
Date: Thu, 10 Oct 2024 17:05:25 -0700
Message-ID: <CAH5Ym4jgadgT=7NDULOZt4VaeoP8TFDcgxCsTdDcA0+AM-H=fw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] arm64: dts: broadcom: bcmbca: bcm4908: Reserve CFE
 stub area
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>, 
	William Zhang <william.zhang@broadcom.com>, Anand Gore <anand.gore@broadcom.com>, 
	Kursad Oney <kursad.oney@broadcom.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 10, 2024 at 3:57=E2=80=AFPM Florian Fainelli
<florian.fainelli@broadcom.com> wrote:
>
> On 10/4/24 22:01, Sam Edwards wrote:
> > The CFE bootloader places a stub program in the first page of physical
> > memory to hold the secondary CPUs until the boot CPU writes the release
> > address, but does not splice a /reserved-memory node into the FDT to
> > protect it. If Linux overwrites this program before execution reaches
> > smp_prepare_cpus(), the secondary CPUs may become inaccessible.
> >
> > This is only a problem with CFE, and then only until the secondary CPUs
> > are brought online. Ideally, there would be some hypothetical mechanism
> > we could use to indicate that this area of memory is sensitive only
> > during boot. But as there is none, and since it is such a small amount
> > of memory, it is easiest to reserve it unconditionally.
>
> If we supported CPU hotplug on those platforms (do we?) then it actually
> does matter that this memory remains protected, and it cannot be
> reclaimed. This does not invalidate the commit message and I will take
> it as-is, but it it is not memory that we can necessarily reclaim that
> easily, if we did things properly.

I am looking at only one build of CFE, so don't take what I'm saying
as gospel, but as I understand it:

CFE implements only the spin-table method, which isn't dynamic. Once
the kernel calls for the secondary CPUs to be released, it cannot shut
them down and bring them up again, so they have no need to reenter the
spin stub.

With U-Boot+ATF, it's of course a different story: ATF needs to stay
resident in memory to implement PSCI (which _is_ dynamic), but U-Boot
inserts/overwrites the necessary DT structures to protect ATF and tell
Linux to use PSCI, so we don't need to be thinking about that here.

But, again, that's just my understanding. If there's a version of CFE
out there that loads ATF/similar or implements PSCI itself, then,
well, that'd invalidate this patch('s commit message). I doubt such a
variant of CFE exists, but you're much better equipped to confirm or
refute that possibility, given your familiarity with the platform and
internal details.

Best wishes,
Sam

>
> >
> > Therefore, add a /reserved-memory node to bcm4908.dtsi to protect the
> > first 4KiB of physical memory.
> >
> > Signed-off-by: Sam Edwards <CFSworks@gmail.com>
> > ---
> >   arch/arm64/boot/dts/broadcom/bcmbca/bcm4908.dtsi | 10 ++++++++++
> >   1 file changed, 10 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/broadcom/bcmbca/bcm4908.dtsi b/arch/ar=
m64/boot/dts/broadcom/bcmbca/bcm4908.dtsi
> > index 8b924812322c..c51b92387fad 100644
> > --- a/arch/arm64/boot/dts/broadcom/bcmbca/bcm4908.dtsi
> > +++ b/arch/arm64/boot/dts/broadcom/bcmbca/bcm4908.dtsi
> > @@ -68,6 +68,16 @@ l2: l2-cache0 {
> >               };
> >       };
> >
> > +     reserved-memory {
> > +             #address-cells =3D <2>;
> > +             #size-cells =3D <2>;
> > +             ranges;
> > +
> > +             cfe-stub@0 {
> > +                     reg =3D <0x0 0x0 0x0 0x1000>;
> > +             };
> > +     };
> > +
> >       axi@81000000 {
> >               compatible =3D "simple-bus";
> >               #address-cells =3D <1>;
>
>
> --
> Florian


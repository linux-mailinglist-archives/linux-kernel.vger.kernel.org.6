Return-Path: <linux-kernel+bounces-194229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 243228D38AF
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 16:06:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B1EBB22DAC
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 14:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8D651DFCB;
	Wed, 29 May 2024 14:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D3G6vjwL"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCEC61CF9C;
	Wed, 29 May 2024 14:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716991573; cv=none; b=cqhJ31I/kjU8vJPlS+PdQX48vHph9w7Z9/2JJ74JnH9piPe4EH9YtWtkT+1fqCEx3zF6gYimigkTNo9cv92dHo1ff9p5miP1Ec/7yvJRcpTfZQS/RcfQ08/uhr9COlcZXdnMtWFzmG4OPvdstw16SJMjn8OsuU7R2kjI5K5bc+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716991573; c=relaxed/simple;
	bh=D0lKbhKuVUmH0yMXwfFVZdRazFxdRecCFFs+6t9BndI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NssXhHS7QkmnbGPadvUrV+QZIpBy6nsHQJ1tH+hdM7tZiSGnssSnarRgVGa3AT11uxZzys5NR+g47b5q2N6G9KgRb+JkRhqFwr4Zh6uNf0+52iJ87pLVurhBGyg2imc7v6ajBl8a5+TN4wSl0oFkUJVsMiBRTe7XI2E/kDk7ODM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D3G6vjwL; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a59a609dd3fso1020566b.0;
        Wed, 29 May 2024 07:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716991570; x=1717596370; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o+M/1yUI1paNZie6p8I3ru5M/VcdpO9GSdVmTNBzjRw=;
        b=D3G6vjwLuSuI55dKtPqpas40KJCJ0ITS6OhiQBJdYeXe/7STQD8rDvu9E4NBv5nchB
         beGPVYiHLLuKkhKQ75BeJ4hCZvh9tJkZBL1bbrGqglYy22inN4WYc8hI4MHXpNtLQeo5
         Auw1GRO2TmuzH3AOj3Hogo3SdkZHdkgftFDdBo91GOj3Oqq9QqgKwLbgPL69pfcff5rc
         6Ue7oEucOidOJQs+Jw7s3t62hOQWik4GDO+puSjvHkpW6L5b/UvKbWBbDSmi8zeQqAcq
         e8f/RkTh8N/7EynJeTbIjyj6Ecvz5t44QdKUx8+JxpgSMeqd+YUcDoSIGDyhozFwbYRs
         2QTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716991570; x=1717596370;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o+M/1yUI1paNZie6p8I3ru5M/VcdpO9GSdVmTNBzjRw=;
        b=dbtxvmNCcTFJUNl5PfMdnkGfe4V5dQco/sUpFMXL1MeNylyy/bTyCphM/8CmdOGBF5
         VnPl+LRJ0T9isOyqEKzuQQHveZ6ignp3eQIbEA7ycS2CNPn2GE4xAoG7dQPShT0ezcoL
         x4+Qyiq7iKBmdLP1Y7v7NQL/qRFh27CZ0jaSekl9uoI71XR9yNszFg97Zr1QlYqwDxmb
         Gm1ylYGCwUkIArdLR5EnfiRzmqjwfUXLvg1awBVbJy0DApfVHH8fbeTXOWkOjjHEVG7Z
         pMasoLNW/JZky/cn9dDaGIFnw+K/2WmhRphTF+ukSoUZg+crDh5mdnbEDC1AFS6dKyOr
         ho4Q==
X-Forwarded-Encrypted: i=1; AJvYcCW6SOVwIUslmUeZv17QbhKayn6dqrtwHkZf6ikG0FbLrNIRwf9cdJqkrn36axuqzrYeotiCYN0hkGvYZ2Tvp+C6+DFU/hSp7B4zhkbHLHIKTZpZm/KoAuAuwnEHBjBXFEWieUgQUUPBmA==
X-Gm-Message-State: AOJu0YwA4C6FfIC2qD63lBAqM4vS8QEEo+NTDwUDvi/Gm5dw/whB6IQ/
	ZopVTD7nAJsSnT9oGK5sWBK+M6hxq+inlAVv21YQRD29g2wx1T54NWrHiEHbREBD4sGJ1oheNSt
	pg5ELbK4EFr5ZNBfQvePkFavvN6Dp349vgBPbKXw0
X-Google-Smtp-Source: AGHT+IHvn89sjSDXO4+mGl5RdI7DhHSLiXo+PsaMWuDAxskAA27o7d2dZXgUKXuozUH+wj6e4fC5jE08LKCrtkf7DPc=
X-Received: by 2002:a17:906:578a:b0:a61:7f85:e31c with SMTP id
 a640c23a62f3a-a642d5806f8mr180319166b.12.1716991569898; Wed, 29 May 2024
 07:06:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <673dcf47596e7bc8ba065034e339bb1bbf9cdcb0.1716948159.git.dsimic@manjaro.org>
 <CABjd4YxD41DEkBCZfkznLboEY9ZVOfTCLcj4S_kkcsVswbANyQ@mail.gmail.com>
 <8f8623e29a479c4108141302e708dc3b@manjaro.org> <CABjd4Yy4RMg+6-4ygV0MSwJj5LReY-ymbctq4PPfVZ6L+c1tsw@mail.gmail.com>
 <166cc4e46f31644a50306625b2ab18a6@manjaro.org>
In-Reply-To: <166cc4e46f31644a50306625b2ab18a6@manjaro.org>
From: Alexey Charkov <alchark@gmail.com>
Date: Wed, 29 May 2024 18:05:58 +0400
Message-ID: <CABjd4YzDNQa45=KC_t0xnTDrH+g-oUrcpgP55oOj7JcAuu7uFw@mail.gmail.com>
Subject: Re: [RFC PATCH] arm64: dts: rockchip: Make preparations for
 per-RK3588-variant OPPs
To: Dragan Simic <dsimic@manjaro.org>
Cc: linux-rockchip@lists.infradead.org, heiko@sntech.de, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	robh+dt@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	linux-kernel@vger.kernel.org, quentin.schulz@cherry.de, wens@kernel.org, 
	daniel.lezcano@linaro.org, didi.debian@cknow.org, 
	krzysztof.kozlowski+dt@linaro.org, viresh.kumar@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2024 at 4:22=E2=80=AFPM Dragan Simic <dsimic@manjaro.org> w=
rote:
>
> On 2024-05-29 14:04, Alexey Charkov wrote:
> > On Wed, May 29, 2024 at 2:45=E2=80=AFPM Dragan Simic <dsimic@manjaro.or=
g>
> > wrote:
> >> On 2024-05-29 11:57, Alexey Charkov wrote:
> >> > On Wed, May 29, 2024 at 6:14=E2=80=AFAM Dragan Simic <dsimic@manjaro=
org>
> >> > wrote:
> >> >>
> >> >> Rename and modify the RK3588 dtsi files a bit, to make preparations
> >> >> for
> >> >> the ability to specify different CPU and GPU OPPs for each of the
> >> >> supported
> >> >> RK3588 SoC variants, including the RK3588J.
> >> >>
> >> >> As already discussed, [1][2][3] some of the different RK3588 SoC
> >> >> variants
> >> >> require different OPPs, and it makes more sense to have the OPPs
> >> >> already
> >> >> defined when a board dts includes one of the SoC dtsi files
> >> >> (rk3588.dtsi,
> >> >> rk3588j.dtsi or rk3588s.dtsi), rather than requiring the board dts
> >> >> file to
> >> >> also include a separate rk3588*-opp.dtsi file.  The choice of the S=
oC
> >> >> variant
> >> >> is already made by the inclusion of the SoC dtsi file, and it doesn=
't
> >> >> make
> >> >> much sense to, effectively, allow the board dts file to include and
> >> >> use an
> >> >> incompatible set of OPPs for the already selected SoC variant.
> >> >
> >> > Indeed, including just one .dtsi for the correct SoC variant and not
> >> > having to bother about what other bits and pieces are required to us=
e
> >> > the full SoC functionality sounds great! Thanks for putting this
> >> > together so promptly!
> >>
> >> You're welcome. :)
> >>
> >> > Some considerations below.
> >> >
> >> >> No intended functional changes are introduced.  (Still to be
> >> >> additionally
> >> >> verified if the patch moves forward from the RFC state.)
> >> >>
> >> >> [1]
> >> >> https://lore.kernel.org/linux-rockchip/646a33e0-5c1b-471c-8183-2c0d=
f40ea51a@cherry.de/
> >> >> [2]
> >> >> https://lore.kernel.org/linux-rockchip/CABjd4Yxi=3D+3gkNnH3BysUzzYs=
ji-=3D-yROtzEc8jM_g0roKB0-w@mail.gmail.com/
> >> >> [3]
> >> >> https://lore.kernel.org/linux-rockchip/035a274be262528012173d463e25=
b55f@manjaro.org/
> >> >>
> >> >> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
> >> >> ---
> >> >>  ...inctrl.dtsi =3D> rk3588-common-pinctrl.dtsi} |    0
> >> >
> >> > Renaming the pinctrl includes seems superfluous - maybe keep them as
> >> > they were to minimize churn?
> >>
> >> Believe it or not, the same thoughts crossed my mind.  However,
> >> after thinking a bit about it, I concluded that renaming the pinctrl
> >> .dtsi files as well makes the overall naming of the reworked RK3588
> >> .dtsi files more consistent.
> >>
> >> It's also rather neat to have the "common" and "fullfat" file pairs
> >> together in the arch/arm64/boot/dts/rockchip directory listing, when
> >> it's sorted by the file name, which is the default in most (if not
> >> all) environments.
> >>
> >> >>  .../{rk3588s.dtsi =3D> rk3588-common.dtsi}      |    2 +-
> >> >>  ...nctrl.dtsi =3D> rk3588-fullfat-pinctrl.dtsi} |    0
> >> >>  .../{rk3588.dtsi =3D> rk3588-fullfat.dtsi}      |    4 +-
> >> >
> >> > To me, "fullfat" doesn't look super descriptive, albeit fun :)
> >>
> >> Yeah, I resorted to "fullfat" as some kind of a funny option. :)
> >> That's for the "beefy" SoC variants, so it kind of fits well. :)
> >>
> >> > How about we rename the existing rk3588.dtsi and rk3588s.dtsi to
> >> > something like rk3588-devices.dtsi and rk3588s-devices.dtsi
> >> > (preserving the inheritance between them), and then I add
> >> > rk3588s-opp.dtsi and rk3588j-opp.dtsi in a follow-up patch?
> >>
> >> The trouble with including "devices" into the filenames is, well,
> >> the fact that those files isn't about any devices, but about the
> >> SoC variants.  Thus, "devices" simply wouldn't fit there.
> >
> > My thinking was along the lines of "here is the file that contains all
> > DT nodes for built-in _devices_ (as in on-chip IP blocks) on RK3588 -
> > thus it's called rk3588-devices.dtsi", and "here's the file that
> > contains operating parameters that distinguish RK3588 and RK3588s from
> > RK3588j - it's called rk3588s-opp.dtsi"
>
> Hmm...  I see, but a device is usually though of as some standalone
> computer, at least in this context.  Surely, an SoC is also some kind
> of a device, for example, but I'm pretty sure we'll very rarely call
> an SoC a device.  It's always good to adhere to the usual meaning of
> the words in a particular lingo.

Agreed, and calling the SoC itself a device is not what I implied by
the suggested naming.

> When it comes to rk3588s-opp.dtsi, it would be more of a file that
> completes the rk3588s.dtsi by adding the OPPs, but we can in fact
> add the OPPs directly into rk3588s.dtsi, because in the new layout
> rk3588s.dtsi isn't a parent to any other file.
>
> >> Moreover, in the envisioned scheme there should be no separate
> >> OPP .dtsi files;  the OPP data should go directly into the new
> >> rk3588.dtsi, rk3588s.dtsi and rk3588j.dtsi files, where it actually
> >> belongs.  That's why those .dtsi files exist and are mostly empty,
> >> at least the way I see it.  I'll get back to this below.
> >>
> >> > Then we keep "thin" versions of rk3588.dtsi, rk3588s.dtsi and
> >> > rk3588j.dtsi for board files to include. The mix-and-match of
> >> > different on-chip devices and different OPPs then gets transparently
> >> > represented within those "thin" .dtsi, something like this:
> >> >
> >> > rk3588.dtsi:
> >> > #include "rk3588-devices.dtsi"
> >> > #include "rk3588s-opp.dtsi"
> >> >
> >> > rk3588s.dtsi:
> >> > #include "rk3588s-devices.dtsi"
> >> > #include "rk3588s-opp.dtsi"
> >> >
> >> > rk3588j.dtsi:
> >> > #include "rk3588-devices.dtsi"
> >> > #include "rk3588j-opp.dtsi"
> >>
> >> Such a layout, in general, has also crossed my mind, but my conclusion
> >> was that having the per-SoC-variant OPP data specified directly in the
> >> reworked rk3588.dtsi, rk3588s.dtsi and rk3588j.dtsi files is a better
> >> option in the long term, even if we end up that way with rk3588.dtsi
> >> and
> >> rk3588s.dtsi repeating most (if not all) of the same OPP data.
> >
> > From all the info we have available so far, RK3588 and RK3588s share
> > identical OPPs, so having one file with OPPs that both variants refer
> > to should be more maintainable (and fewer lines of DT code).
>
> Hmm.  Perhaps we can have rk3588-opp.dtsi as a separate file with the
> OPPs shared between the RK3588 and the RK3588S, which would be included
> from rk3588.dtsi and rk3588s.dtsi.
>
> Though, the OPPs for the RK3588J should go directly into rk3588j.dtsi;
> if we ever split the OPPs for the RK3588 and the RK3588S, the new OPPs
> should also go directly into rk3588.dtsi and rk3588s.dtsi.

Sounds good to me!

> > All in all, it appears that RK3588 and RK3588j have an identical set
> > of built-in devices, but different OPPs due to RK3588j being spec'd
> > for industrial use which apparently has different requirements. At the
> > same time, RK3588s uses an identical set of OPPs as RK3588 but a
> > reduced set of built-in devices. The combination of includes I
> > proposed above makes this explicit.
>
> Again, calling IP blocks devices is, AFAIK, very uncommon.

Perhaps. Shall we settle on something like "-devicenodes.dtsi" or
"-hwblocks.dtsi"? :) This will delineate what goes to which .dtsi:
things that describe the hardware composition go to "-hwblocks.dtsi",
things that describe performance parameters for that hardware go to
"-opp.dtsi" (or directly to the SoC .dtsi if there is only one SoC
variant that uses a particular OPP table).

The problem I have with -common is that there are several layers of
"common" even among just the three of these chip revisions, and a
clear inheritance hierarchy between them (i.e. RK3588j and RK3588 also
have a sizeable chunk of their IP blocks that is "common" between
these two variants, in addition to those shared among all three
variants)

> > As for RK3588m, it seems to include all the same devices as RK3588 and
> > RK3588j, but a slightly modified set of OPPs compared to RK3588j. We
> > don't have any boards using that variant in the mainline tree right
> > now, but it would be easy, when the need arises, to add something
> > along the lines of:
> >
> > rk3588m.dtsi:
> > #include "rk3588-devices.dtsi"
> > #include "rk3588m-opp.dtsi"
> >
> > rk3588m-opp.dtsi:
> > #include "rk3588j-opp.dtsi"
> > &cluster0_opp_table {
> >         /delete-node/ opp-1296000000;
> > };
>
> I don't think that deleting nodes that way is a good option.  It's
> rather error-prone and hard to track, so it would be better to have
> the OPPs for RK3588M specified directly (and fully) in the future
> rk3588m.dtsi file, just like in rk3588j.dtsi.

You're right, that does indeed look fishy upon further thought.

> >> That way we'll have no roadblocks if, at some point, we end up with
> >> having
> >> different OPPs defined for the RK3588 and the RK3588S variants.  Or
> >> maybe
> >> even for the RK3582, which we don't know much about yet.
> >
> > Guess we'll deal with that one once we stumble upon an actual RK3582
> > board out in the wild and heading to the mainline kernel tree :)
>
> Of course, that was just an example for the future use.

In fact, I've just discovered that Radxa has recently released Rock 5C
Lite which is based on RK3582, and starts at just $29 for the 1GB
version, making it interesting for tinkering. Especially given that
its GPU, one of the big-core clusters and one of the VPU cores seem to
be disabled in software (u-boot) rather than in hardware, which means
there is some chance that a particular SoC specimen would actually
have them in a working condition and possible to re-enable at no cost.
Ordered myself one to investigate :)

Best regards,
Alexey


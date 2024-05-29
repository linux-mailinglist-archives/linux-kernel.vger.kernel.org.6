Return-Path: <linux-kernel+bounces-194054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8613A8D35F3
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 14:04:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C66D2884B2
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 12:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF0AB13F43A;
	Wed, 29 May 2024 12:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eF8NPNK8"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC8E819;
	Wed, 29 May 2024 12:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716984259; cv=none; b=lC1IjpI7XIucDpCD3W3VI6hYiOYH8I4H1OhrDJHD2XKoxNrCNnDeJW71Vq+ThgMA7BsFh/RpNp+ugpiEmUiDWHCO2PId/on7N2PaVAb57w7Th2GGVT/rm7z5AXRWxZt/PTqMo5rl9bSEqtYqypCNpyqhMvM+ylYLmJOm4lDdJhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716984259; c=relaxed/simple;
	bh=O1R2SJ7r7jYwqi8pWiT2IHVCOFWMFqiCpostLZBKHyk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bEogNqQCdm7v2q/e7gz61Xji/rbGb4uP0jibuWSdLVY020NMMudvAndz8bdaVaA67TFshgkmi7cWr8kDb8cAHq6kIvhkF1mwhPLd5ix1dN0u35XmFttT+CP34x2ovY5nOAOZ4TP5pOnHFQ2NwV922LJai4wgEkyBX2+kqrL7urE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eF8NPNK8; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a634e03339dso233871466b.3;
        Wed, 29 May 2024 05:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716984256; x=1717589056; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GuiwU9w62NI6NKRRYB/Qv/rhsUcpT2BppjaI/CYmfuw=;
        b=eF8NPNK8ON8TP9/er/kB5AQtV055HsMC6Q5HE608bDy15cuw/6ZII91Ah1gfTgTSdh
         XP7lgt+R9S1FBWGopQKRmNjAr5b/9mijgN3AfAYMverjC3zZpaEaVHxBfUnuDlD31BFr
         iFQ2/MJbeycedH5WF4sIYCmbjxpU3ERBZq/D0RXkw44qcrREPuf0QRY3htMfPTcdQtlR
         WffD3PFj+0stahEq19lzx8K5Fw6YrWrNjCNXjCMsZjq5P2yji4BQnFiSGFp7ZpaG9SFB
         THjWRZazK0WPALzQLkT4c48vHiEgP2Hbw2x/ahUrNssdGbQzU23FsjO5rczdSe6quGsq
         eKGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716984256; x=1717589056;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GuiwU9w62NI6NKRRYB/Qv/rhsUcpT2BppjaI/CYmfuw=;
        b=cGKgKVHkvja2KRFTDejIVI3+378d+OUr1Fk1hECoM4vhjo+0XGARxZ/9pxlWTnELQS
         eZU7Sh74pwL5WSwibSRh3LZmFW8Mv1wQfmrHaaRadJ6faczXTacHZg6z6fyh4jKiAceR
         Qp47AeOxGRvlPDwj4ZdHtqeQjxDyGF21xmZl6dzL16eSwVRLtEie48XsGSt9ppQt67Ol
         1AberZZwolGG9Dr3HUfCFYvZG5njdTxxGtSGJ1gyKhHn+tCFASAna1fyjGfjgYY/s0LA
         5GbhpdNxyyBg1mVfbs+Hw02hiekM3X9maqsc4wPu4NADhTusaeuHBcsumR21Rikq20Pq
         kH6A==
X-Forwarded-Encrypted: i=1; AJvYcCWnjpuxExpKzCdRQeSIDR21W8tG1r2rSQHX0EhgUImg0vSqpcs6jOoKs/RvO/EFjjQY4ycfApEWRCxL9M8N4RbEZGH2bIyrv1aHmduL3qFWpxWMP6IPMukdzZW0H8VFtFpwHu6cRM0i6w==
X-Gm-Message-State: AOJu0Yzjlvnnl9BxGXm8WwpYaoDWwFZQVOIu3a/pIc4fG7+gEfOoJu6o
	lZx3hcr0aM6KEE/GWZkkd4fhu0VlPUOPJSfLZ0Cs7WI57VTQgYaVTY63u0E1Q7i92ScQtQ7kgd4
	MTij3EAlZTaCe82XRAfdGia975ok=
X-Google-Smtp-Source: AGHT+IGLh5xSuVtxvqocIhk3ifGSHFOvhBmHvBbSayrWr2HA/wSiOcyCmSKtbEGzUnofoc8rmTOudOyTUkMk4p8+t0U=
X-Received: by 2002:a17:907:9384:b0:a65:d73b:f919 with SMTP id
 a640c23a62f3a-a65d73bfc40mr11829166b.11.1716984255957; Wed, 29 May 2024
 05:04:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <673dcf47596e7bc8ba065034e339bb1bbf9cdcb0.1716948159.git.dsimic@manjaro.org>
 <CABjd4YxD41DEkBCZfkznLboEY9ZVOfTCLcj4S_kkcsVswbANyQ@mail.gmail.com> <8f8623e29a479c4108141302e708dc3b@manjaro.org>
In-Reply-To: <8f8623e29a479c4108141302e708dc3b@manjaro.org>
From: Alexey Charkov <alchark@gmail.com>
Date: Wed, 29 May 2024 16:04:04 +0400
Message-ID: <CABjd4Yy4RMg+6-4ygV0MSwJj5LReY-ymbctq4PPfVZ6L+c1tsw@mail.gmail.com>
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

On Wed, May 29, 2024 at 2:45=E2=80=AFPM Dragan Simic <dsimic@manjaro.org> w=
rote:
>
> Hello Alexey.
>
> On 2024-05-29 11:57, Alexey Charkov wrote:
> > On Wed, May 29, 2024 at 6:14=E2=80=AFAM Dragan Simic <dsimic@manjaro.or=
g>
> > wrote:
> >>
> >> Rename and modify the RK3588 dtsi files a bit, to make preparations
> >> for
> >> the ability to specify different CPU and GPU OPPs for each of the
> >> supported
> >> RK3588 SoC variants, including the RK3588J.
> >>
> >> As already discussed, [1][2][3] some of the different RK3588 SoC
> >> variants
> >> require different OPPs, and it makes more sense to have the OPPs
> >> already
> >> defined when a board dts includes one of the SoC dtsi files
> >> (rk3588.dtsi,
> >> rk3588j.dtsi or rk3588s.dtsi), rather than requiring the board dts
> >> file to
> >> also include a separate rk3588*-opp.dtsi file.  The choice of the SoC
> >> variant
> >> is already made by the inclusion of the SoC dtsi file, and it doesn't
> >> make
> >> much sense to, effectively, allow the board dts file to include and
> >> use an
> >> incompatible set of OPPs for the already selected SoC variant.
> >
> > Indeed, including just one .dtsi for the correct SoC variant and not
> > having to bother about what other bits and pieces are required to use
> > the full SoC functionality sounds great! Thanks for putting this
> > together so promptly!
>
> You're welcome. :)
>
> > Some considerations below.
> >
> >> No intended functional changes are introduced.  (Still to be
> >> additionally
> >> verified if the patch moves forward from the RFC state.)
> >>
> >> [1]
> >> https://lore.kernel.org/linux-rockchip/646a33e0-5c1b-471c-8183-2c0df40=
ea51a@cherry.de/
> >> [2]
> >> https://lore.kernel.org/linux-rockchip/CABjd4Yxi=3D+3gkNnH3BysUzzYsji-=
=3D-yROtzEc8jM_g0roKB0-w@mail.gmail.com/
> >> [3]
> >> https://lore.kernel.org/linux-rockchip/035a274be262528012173d463e25b55=
f@manjaro.org/
> >>
> >> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
> >> ---
> >>  ...inctrl.dtsi =3D> rk3588-common-pinctrl.dtsi} |    0
> >
> > Renaming the pinctrl includes seems superfluous - maybe keep them as
> > they were to minimize churn?
>
> Believe it or not, the same thoughts crossed my mind.  However,
> after thinking a bit about it, I concluded that renaming the pinctrl
> .dtsi files as well makes the overall naming of the reworked RK3588
> .dtsi files more consistent.
>
> It's also rather neat to have the "common" and "fullfat" file pairs
> together in the arch/arm64/boot/dts/rockchip directory listing, when
> it's sorted by the file name, which is the default in most (if not
> all) environments.
>
> >>  .../{rk3588s.dtsi =3D> rk3588-common.dtsi}      |    2 +-
> >>  ...nctrl.dtsi =3D> rk3588-fullfat-pinctrl.dtsi} |    0
> >>  .../{rk3588.dtsi =3D> rk3588-fullfat.dtsi}      |    4 +-
> >
> > To me, "fullfat" doesn't look super descriptive, albeit fun :)
>
> Yeah, I resorted to "fullfat" as some kind of a funny option. :)
> That's for the "beefy" SoC variants, so it kind of fits well. :)
>
> > How about we rename the existing rk3588.dtsi and rk3588s.dtsi to
> > something like rk3588-devices.dtsi and rk3588s-devices.dtsi
> > (preserving the inheritance between them), and then I add
> > rk3588s-opp.dtsi and rk3588j-opp.dtsi in a follow-up patch?
>
> The trouble with including "devices" into the filenames is, well,
> the fact that those files isn't about any devices, but about the
> SoC variants.  Thus, "devices" simply wouldn't fit there.

My thinking was along the lines of "here is the file that contains all
DT nodes for built-in _devices_ (as in on-chip IP blocks) on RK3588 -
thus it's called rk3588-devices.dtsi", and "here's the file that
contains operating parameters that distinguish RK3588 and RK3588s from
RK3588j - it's called rk3588s-opp.dtsi"

> Moreover, in the envisioned scheme there should be no separate
> OPP .dtsi files;  the OPP data should go directly into the new
> rk3588.dtsi, rk3588s.dtsi and rk3588j.dtsi files, where it actually
> belongs.  That's why those .dtsi files exist and are mostly empty,
> at least the way I see it.  I'll get back to this below.
>
> > Then we keep "thin" versions of rk3588.dtsi, rk3588s.dtsi and
> > rk3588j.dtsi for board files to include. The mix-and-match of
> > different on-chip devices and different OPPs then gets transparently
> > represented within those "thin" .dtsi, something like this:
> >
> > rk3588.dtsi:
> > #include "rk3588-devices.dtsi"
> > #include "rk3588s-opp.dtsi"
> >
> > rk3588s.dtsi:
> > #include "rk3588s-devices.dtsi"
> > #include "rk3588s-opp.dtsi"
> >
> > rk3588j.dtsi:
> > #include "rk3588-devices.dtsi"
> > #include "rk3588j-opp.dtsi"
>
> Such a layout, in general, has also crossed my mind, but my conclusion
> was that having the per-SoC-variant OPP data specified directly in the
> reworked rk3588.dtsi, rk3588s.dtsi and rk3588j.dtsi files is a better
> option in the long term, even if we end up that way with rk3588.dtsi and
> rk3588s.dtsi repeating most (if not all) of the same OPP data.

From all the info we have available so far, RK3588 and RK3588s share
identical OPPs, so having one file with OPPs that both variants refer
to should be more maintainable (and fewer lines of DT code).

All in all, it appears that RK3588 and RK3588j have an identical set
of built-in devices, but different OPPs due to RK3588j being spec'd
for industrial use which apparently has different requirements. At the
same time, RK3588s uses an identical set of OPPs as RK3588 but a
reduced set of built-in devices. The combination of includes I
proposed above makes this explicit.

As for RK3588m, it seems to include all the same devices as RK3588 and
RK3588j, but a slightly modified set of OPPs compared to RK3588j. We
don't have any boards using that variant in the mainline tree right
now, but it would be easy, when the need arises, to add something
along the lines of:

rk3588m.dtsi:
#include "rk3588-devices.dtsi"
#include "rk3588m-opp.dtsi"

rk3588m-opp.dtsi:
#include "rk3588j-opp.dtsi"
&cluster0_opp_table {
        /delete-node/ opp-1296000000;
};
..

> That way we'll have no roadblocks if, at some point, we end up with
> having
> different OPPs defined for the RK3588 and the RK3588S variants.  Or
> maybe
> even for the RK3582, which we don't know much about yet.

Guess we'll deal with that one once we stumble upon an actual RK3582
board out in the wild and heading to the mainline kernel tree :)

Best regards,
Alexey


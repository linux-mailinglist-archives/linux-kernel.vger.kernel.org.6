Return-Path: <linux-kernel+bounces-196742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB42A8D60F3
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 13:44:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C1C42850F1
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 11:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04A1D157A7C;
	Fri, 31 May 2024 11:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="azpfS43w"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B56156967;
	Fri, 31 May 2024 11:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717155873; cv=none; b=J7F6l48gliXIMJz8bqvbSoqoIl/Ua9s64JmA2wm5jwsk1hTaf+9w7izEnvDT5j776BQmm7tBc/FDGM2lx0ukoS+u5kYLHscIEf3sVZ4ZByyLBkDr6wa4kD7GuEipsOWpqyFEhUHl8UcPPIlqGt5rs/JJzRvGTAud9NKoqI5YT5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717155873; c=relaxed/simple;
	bh=gTkrPFcPFjPmNl4EMeRF67ICZfuMGtOJ+smcsmDI0GA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VeyvzGLHqrfTwddurEO4inwslB8HRWag6P2ujKj8IZrkff0wOJedI79ItQHN/e3XUQD+VHFNoqkKarERd8JU0WAqVsaI5GSb3soKhBYefE4wzc0JF5VVtqC2i5GY0u16M1D8rW94v8X2zalqYFvuD6MT54Da8LKm97U0Il7omrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=azpfS43w; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a6762109c06so189166066b.0;
        Fri, 31 May 2024 04:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717155869; x=1717760669; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wqd5CJWs8bzLK+RMndMHq317X+gT2llkhqAxoGBYvLU=;
        b=azpfS43wN2KCH4RBOJ8Do/P3ub61nW5hP2jpq/pOk+jyN2gL7bF15zpNR/wF0VhPdh
         PYFv2+4XDBl0UHUNAqTrpxR33aDQ9uISi4/NLtoDNBZF7giY8kG0SNPxz7CHhqH7F7Wp
         ijT+BLmesAgM9dsK9p8KFhmonKM8sdiannY0lC/6/Jlg6qAYlTH7F8CJ8A/7QT406b3+
         Ng6MbFLgtSWEwi9a0LdVCxrcLWO/4hbZKi6yyP0ONWER4CwA9Yiop7Gz4MBIDugtfEgU
         S9iPxuDi+Wa392gt94m0bZ0WGO2ChY8wHzC/84aqV739aHKzjHQdvsQgk0O5AMKIQdy/
         +q6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717155869; x=1717760669;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wqd5CJWs8bzLK+RMndMHq317X+gT2llkhqAxoGBYvLU=;
        b=X/dxeuS5uopxZNDS9Ig4POPsg6K2XUe2koRqoyaE6qbBdbEGMyvixrC7xwlOTy/DpG
         1/mTR5k7SNF89cZaZuequAfGYCRsLXOVpuvJfwR/CZYHPO2b/ISS64eyORvM9P10hepu
         oQU7iLbFhA9ThEXUkF2+FlNDmUWzh18xBqQkI002AcZfsRtLMf/RgGvx9xvWygdf7/6d
         81gKNONlYSGPUXWUGs0ibOHDwr/9/RJn/6yVn7X3A3peiJZnRosLiWC+TfB/hPHNuiwD
         e4IB/5FeXz+8vFuc5h6pLvwJ0b9XKiSoxRSVdawTaPY2VaUYaHLaTiOWmNj8jVxiquWE
         670Q==
X-Forwarded-Encrypted: i=1; AJvYcCXTLrGVz1PI9h4ytUpE/xa4HrLoHHoSBFPEkBFrjnFLGQ+Fq1Nlqod3y12LLrmn+ZLyL2f+tJ6gyb9hCRJoFs7MJEXZeFQTorUzfCI7XKPZPI3fkBAHyzG0NK+ZVfewN8XoIZNSiufiVQ==
X-Gm-Message-State: AOJu0YzeqQzQOuTQ2FLaHm2T525EnsvIcWeqrNBn0374SkUFw72SJR2Z
	XeGKGCX7OBXbA+s6Q8R+HiwOXBuYsy/qxMxhzOgwcD1pU5xPtww/wq6NTQzZSkQVedgBvctFkdX
	zAmyE9+36byVHfwIu8+ertJWh+WI=
X-Google-Smtp-Source: AGHT+IF0Qcu9EJQr44+eGVBolIVBmGWoyCtqb1nUMq+iFXyzHjYzB1XGjgJZdgvl6m/6O9x6S/jQYc6TUKvIW8vbQQU=
X-Received: by 2002:a17:907:1044:b0:a68:8cf2:4985 with SMTP id
 a640c23a62f3a-a688cf249f7mr56590066b.37.1717155868742; Fri, 31 May 2024
 04:44:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <673dcf47596e7bc8ba065034e339bb1bbf9cdcb0.1716948159.git.dsimic@manjaro.org>
 <CABjd4YxD41DEkBCZfkznLboEY9ZVOfTCLcj4S_kkcsVswbANyQ@mail.gmail.com>
 <8f8623e29a479c4108141302e708dc3b@manjaro.org> <CABjd4Yy4RMg+6-4ygV0MSwJj5LReY-ymbctq4PPfVZ6L+c1tsw@mail.gmail.com>
 <166cc4e46f31644a50306625b2ab18a6@manjaro.org> <CABjd4YzDNQa45=KC_t0xnTDrH+g-oUrcpgP55oOj7JcAuu7uFw@mail.gmail.com>
 <82db817a908b761d8c3d73ea04714314@manjaro.org> <607f4da8-99b2-4379-9567-4bfd2744eab3@kwiboo.se>
In-Reply-To: <607f4da8-99b2-4379-9567-4bfd2744eab3@kwiboo.se>
From: Alexey Charkov <alchark@gmail.com>
Date: Fri, 31 May 2024 15:44:17 +0400
Message-ID: <CABjd4YxdM+cM+z7ou3=DF2SrFM0235DSTZ45o0NsKBwGrgW8Bg@mail.gmail.com>
Subject: Re: [RFC PATCH] arm64: dts: rockchip: Make preparations for
 per-RK3588-variant OPPs
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Dragan Simic <dsimic@manjaro.org>, linux-rockchip@lists.infradead.org, heiko@sntech.de, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	robh+dt@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	linux-kernel@vger.kernel.org, quentin.schulz@cherry.de, wens@kernel.org, 
	daniel.lezcano@linaro.org, didi.debian@cknow.org, 
	krzysztof.kozlowski+dt@linaro.org, viresh.kumar@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

On Fri, May 31, 2024 at 3:27=E2=80=AFPM Jonas Karlman <jonas@kwiboo.se> wro=
te:
>
> Hi Alexey and Dragan,
>
> On 2024-05-30 21:31, Dragan Simic wrote:
> > Hello Alexey,
> >
>
> [snip]
>
> >>>>> That way we'll have no roadblocks if, at some point, we end up with
> >>>>> having
> >>>>> different OPPs defined for the RK3588 and the RK3588S variants.  Or
> >>>>> maybe
> >>>>> even for the RK3582, which we don't know much about yet.
> >>>>
> >>>> Guess we'll deal with that one once we stumble upon an actual RK3582
> >>>> board out in the wild and heading to the mainline kernel tree :)
> >>>
> >>> Of course, that was just an example for the future use.
> >>
> >> In fact, I've just discovered that Radxa has recently released Rock 5C
> >> Lite which is based on RK3582, and starts at just $29 for the 1GB
> >> version, making it interesting for tinkering. Especially given that
> >> its GPU, one of the big-core clusters and one of the VPU cores seem to
> >> be disabled in software (u-boot) rather than in hardware, which means
> >> there is some chance that a particular SoC specimen would actually
> >> have them in a working condition and possible to re-enable at no cost.
> >> Ordered myself one to investigate :)
> >
> > Yes, I also saw the RK3582-based ROCK 5C Lite a couple of days ago. :)
> > It seems that the disabled IP blocks are detected as defective during
> > the manufacturing, which means that they might work correctly, or might
> > actually misbehave.  It seems similar to the way old three-core AMD
> > Phenom II CPUs could sometimes be made quad-core.
> >
>
> I can confirm that the RK3582 include ip-state in OTP indicating
> unusable cores, any unusable cpu core cannot be taken online and stalls
> Linux kernel a few extra seconds during boot.
>
> Started working on a patch for U-Boot to remove any broken cpu core
> and/or cluster nodes, similar to what vendor U-Boot does, adopted to
> work with a mainline DT for RK3588.

Superb - it's great to have a patch for it already, thank you for working o=
n it!

> On one of my ROCK 5C Lite board one of the cpu cores is unusable, U-Boot
> removes the related cpu cluster nodes. On another ROCK 5C Lite board one
> rkvdec core is only marked unusable and all cpu cores can be taken
> online, U-Boot does nothing in this case. Guessing we should apply
> similar policy as vendor U-Boot and disable cores anyway.

Is there any misbehavior / instability if you just keep all the
unmarked cores online?

I think from an end-user perspective it would be better to just enable
everything that works, as the reason to unconditionally disable some
IP blocks even when they are "good" is quite likely not a technical
one but rather a marketing one. It's hard to justify selling chips
with different sets of working IP blocks under the same label and the
same price, making it easier to just trim them all to a lowest common
denominator. On the other hand, once a person has already bought a
device where some IP blocks work even if they are not supposed to, why
not make use of them? It costs nothing, hurts noone...

Best regards,
Alexey


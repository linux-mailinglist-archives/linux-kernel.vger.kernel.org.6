Return-Path: <linux-kernel+bounces-172984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 047798BF9B4
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 11:43:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 292751C21AE9
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 09:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1480E77620;
	Wed,  8 May 2024 09:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fzF7lLk/"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C15075803;
	Wed,  8 May 2024 09:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715161413; cv=none; b=irZDoI5KWdiygs1IZ5p0jHSOBq8agX4zLy597JbbOgPtEDJ47gs2uvHkmCgU5/QEyy/Qv5Q1AYUKV1cDlUaDvh/dIggqFa0mLDZkgk9Q0JaaDBAjvDzTWak4548u2AX8hniUtglisVkbaPHr76L9qvaQSSD3/VJ7X07K1edYm+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715161413; c=relaxed/simple;
	bh=bhBk+CL6O4PHEbgabhGALs+AmmheycGZz7VgHbFJWhI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B2dZmDiMCMNC7sskDg4+dhR/1tDh02W/yTWUKXlL3QIrGO861ip9WtNXcJqUWcs9zR62XgBdvaNAfCXrCJSMVNDNX4uu7JO2g3RERPZ1jZfvRMwdKwRYEjiEgMvVGjRc2abzBXLpb+Yw31QxXDH8YQxikZ6oE+cHU1tWR60Oleo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fzF7lLk/; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a59d0810f59so650566366b.0;
        Wed, 08 May 2024 02:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715161410; x=1715766210; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bhBk+CL6O4PHEbgabhGALs+AmmheycGZz7VgHbFJWhI=;
        b=fzF7lLk/3JdB8OShYuW0aNIu9ZqQ7OCAC0k/28tqFNc014i07zwr890XXrO+rBC8u+
         dhWtG2OgjAHv9ybjWmSyBflOqw/Qn2y+mOzKuD9M1AU9lnNPVWy1qbmBlpRQyV0K+F/+
         AZ1vVTDD0Kt5Rnux/b7qbis7c3GZH5GTGSVjJ5lnSO8Vb9I0r6dmIZcIDF6+NIU9V0Ed
         Y20RAqzsnM24p+2vf6fvhXcaiU4KT9FZfkpmJh+zc0hz+4XQzFPXmca9opikEKNtB/Sk
         Z/r6Y0hxGLqaYXb8YFx+gyKf/uY0bSa1iOjh2J6KghFFhkeGat425hAnbOReMlUnlW/g
         MrBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715161410; x=1715766210;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bhBk+CL6O4PHEbgabhGALs+AmmheycGZz7VgHbFJWhI=;
        b=QdVBDqdxA2l67F3D7sKR9xCq97h2LygUniyN+V92hD3f9cncJxbWM8VX18c50QhIN1
         f6ks3m0g6ns60A9neDVbBfL6vLc4BmaYnrM0DWfSjUBGQZYU9pctBb5mxuGWBG1sQ992
         MMVKGVZ5xCVdeUyyAyV/WzYloS7FTMK/QPKsE8WjMySlnuS2kiLEsq1DpWziyhgoyjjy
         2+kXUcBKiEq4sMrWkG9ZM3wHzQElv+OSAR3E4vjP6Og7M7pKEBGFFmno9WTrgya6g4v7
         Ylvr+NFuujq0uJhVj/UKUSg3JNJfZUV8Vyo7hnHNRHbkyW6+xweSMUSryz/VGJmAzF9l
         c5vg==
X-Forwarded-Encrypted: i=1; AJvYcCVGR7lSbhbeop8Ng5XNUlh7jEFtdVsy7dn3QtSAMV2QuaHAFhxixS68bbH4upvMnYqMriuX9UdMkwt+URMqnxEUu5bGs4Dp/mAuEpvqcVDACAHB9V7HH4Fmi+ZGzlKBvqFBqKR+f1OCTg==
X-Gm-Message-State: AOJu0Yw53cEs4jbSq4HYpVcZuEiDQ+UACm8mowQA7Z9/sw0eUARtQRji
	Aor7a9q9wcNM8ud6E/fw7LPTunptGoV2dYe7qN8QOlszyL1WmSl6v54V6auyCK9R/sfeC9M1RmH
	gYBBEAwa9aPQ+gRry22h1r8gDbYI=
X-Google-Smtp-Source: AGHT+IG9Ur8aKpxy/1GBhO/DShgr59Isue9VUNFe5pUz/i1FIXiq3GWJ2HIj1INZvrps44bCi4GeLI+P+cHjU62+xLQ=
X-Received: by 2002:a17:906:f856:b0:a59:afdd:590d with SMTP id
 a640c23a62f3a-a59fb9b8abbmr106370366b.51.1715161409546; Wed, 08 May 2024
 02:43:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240506-rk-dts-additions-v4-0-271023ddfd40@gmail.com>
 <20240506-rk-dts-additions-v4-6-271023ddfd40@gmail.com> <e220061e-0bb5-4fa4-9a91-aefd81e6636c@cherry.de>
In-Reply-To: <e220061e-0bb5-4fa4-9a91-aefd81e6636c@cherry.de>
From: Alexey Charkov <alchark@gmail.com>
Date: Wed, 8 May 2024 13:43:17 +0400
Message-ID: <CABjd4YweBc_0d=ej-=0o6FPdHxh-i3FSbSp5bDs9cZcmosEMeA@mail.gmail.com>
Subject: Re: [PATCH v4 6/6] arm64: dts: rockchip: Add OPP data for CPU cores
 on RK3588
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Dragan Simic <dsimic@manjaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Chen-Yu Tsai <wens@kernel.org>, Diederik de Haas <didi.debian@cknow.org>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Kever Yang <kever.yang@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Quentin,

On Wed, May 8, 2024 at 1:12=E2=80=AFPM Quentin Schulz <quentin.schulz@cherr=
y.de> wrote:
>
> Hi Alexey,
>
> On 5/6/24 11:36 AM, Alexey Charkov wrote:
> > By default the CPUs on RK3588 start up in a conservative performance
> > mode. Add frequency and voltage mappings to the device tree to enable
> > dynamic scaling via cpufreq.
> >
> > OPP values are adapted from Radxa's downstream kernel for Rock 5B [1],
> > stripping them down to the minimum frequency and voltage combinations
> > as expected by the generic upstream cpufreq-dt driver, and also droppin=
g
> > those OPPs that don't differ in voltage but only in frequency (keeping
> > the top frequency OPP in each case).
> >
> > Note that this patch ignores voltage scaling for the CPU memory
> > interface which the downstream kernel does through a custom cpufreq
> > driver, and which is why the downstream version has two sets of voltage
> > values for each OPP (the second one being meant for the memory
> > interface supply regulator). This is done instead via regulator
> > coupling between CPU and memory interface supplies on affected boards.
> >
>
> I'm not sure this is everything we need though.
>
> For the LITTLE cores cluster, all OPPs up to 1.416GHz are using the same
> opp-supported-hw, however the ones above, aren't.

Thanks a lot for pointing this out - could you please elaborate which
downstream kernel you referred to?

> 1.608GHz, 1.704GHz and 1.8GHz are all using different opp-supported-hw.

In Radxa's downstream kernel source that I looked at [1] the LITTLE
core cluster has all OPPs listed with opp-supported-hw =3D <0xff
0xffff>;

> Similarly, for the big cores clusters, all OPPs up to 1.608GHz are using
> the same opp-supported-hw, but not the ones above.
>
> 1.8GHz and 2.016GHz, 2.208GHz, 2.256GHz, 2.304GHz, 2.352GHz and 2.4GHz
> all have a different opp-supported-hw.

Hmm, only 2.256GHz, 2.304GHz and 2.352GHz in the sources I'm looking
at have a different opp-supported-hw =3D <0xff 0x0>; (but note that I
dropped them all from my patch here)

> The values in that array are coming from cpu leakage (different for
> LITTLE, big0 and big1 clusters) and "specification serial number"
> (whatever that means), those are coming from the SoC OTP. In the
> downstream kernel from Rockchip, the former value is called "SoC
> Version" and the latter "Speed Grade".

From what I understood by studying Radxa's downstream kernel sources
and TF-A sources [2], the "leakage" in NVMEM cells drives the
selection of power-optimized voltage levels (opp-microvolt-L1 through
opp-microvolt-L7) for each OPP depending on a OTP-programmed silicon
quality metric, whereas in my patch I only kept the most conservative
voltage values for each OPP (i.e. highest-voltage default ones) and
not the power-optimized ones.

So the proposed patch should (supposedly?) work on any silicon, only
the heat death of the universe becomes marginally closer :)

> I think this may have something to do with "binning" and I would see the
> ones above the "common" OPPs as "overclocking". Not all CPUs would
> support them and some may not run stable at some lower frequency than
> their stable max. Adding Kever from Rockchip in Cc to have some input on
> the need to support those.

Would be great to understand those in more detail, indeed!

Thanks a lot,
Alexey

[1] https://github.com/radxa/kernel/blob/c428536281d69aeb2b3480f65b2b227210=
b61535/arch/arm64/boot/dts/rockchip/rk3588s.dtsi#L588
[2] https://lore.kernel.org/linux-rockchip/CABjd4YzTL=3D5S7cS8ACNAYVa730WA3=
iGd5L_wP1Vn9=3Df83RCORA@mail.gmail.com/


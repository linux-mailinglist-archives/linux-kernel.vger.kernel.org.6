Return-Path: <linux-kernel+bounces-558472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF6E5A5E65D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 22:17:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD7113AB0EB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 21:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 192E71EFF80;
	Wed, 12 Mar 2025 21:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="le1zkwAD"
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65CE41EE7C2
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 21:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741814222; cv=none; b=j+2NBUznfoeAJ7iT1O3oSxho5tYp7tjOJbYhAG14mdkZbJ1S0AzmPpSamcfEMHKaeFaN9yzh9xu+8LEUPjk82DEHe0OV/Hp7gz9qbKMtZLOMya9Yd6WqE9fKlSFhu6nYXS8dP7DfSm66I/xkVy33hXRhKEewrF/mI/hjkfQiq6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741814222; c=relaxed/simple;
	bh=wPzK4zBNUgtZDWoviPcVV3sisFQVwXRO4Clib2QCtvA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kRgvBn/jXy6N/0rNDdo9nsFeApLQ2r9MfhkQP5tIj7ubUbdVfocoEODkQzOf8qCKR69fbOShtMHL++hb8RgFmY6JJQGnun6Vb8TCRssen4Mslvc9mKsyeFXOm0ANjAxoUNJH7klHjdKzUwAdDrEWBR8S0PPHyxa158mybvjsPa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=le1zkwAD; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6e8ec399427so2631666d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 14:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741814219; x=1742419019; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XxDKgr5VuN6noi0Wfhw4cTV3jZ9TmVruadjdpxToKRg=;
        b=le1zkwADDKWP8OkSlyweV1riHXhsqubTrAKSkyLsEdjZ4DnE15BzGDS7V+2V8kuqXy
         esE2va7uYx3tRx4urUfkVsY5iuBuThpcPO567tEL4GdtNp2BBsTsPvoIQfOs0aoARwfz
         FM/C+GBxe98A24/YWhFb3QFE/SdllVH8oeqtzNKv8MX1/RSZDwb1gPfVFyCrn2T8wftL
         swrOV1xrmKeUbRe2GuJqwcD0VeiQYJsHqvYz25RTK4Clj3aO4imISdr222eXJus+0Yov
         a1zW/QAhw1uivmWdvgHA8oBa6ixrEKnB/vuXySYayNiid2QNpDMUXchkgMdXPn2KY6tA
         r9qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741814219; x=1742419019;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XxDKgr5VuN6noi0Wfhw4cTV3jZ9TmVruadjdpxToKRg=;
        b=gbIubSPHsQmul046AvTekY0Zi34rYjUlP5V4xvv72qdf95CUEgMa0G3MPxAVvpW/4e
         s+waHNDYkLHZKQXy8aQiCW9l8+Bx9PWerUznXuoytgUXXlSp+TULYSCzShEIw2W4aQQp
         LnehYSb8cakzF7/p73pmN2bLc+JpLdZtBNNV9zZfGqFy3mUf+u4snWpX9gk+mT76HUm3
         1npPzjYPCSDFJt2I1uiJt+3J/NCU7G+Mk4/9KfXdlQl34+Ds6i55w7xkYWGQwNoHKooh
         b9W3FSrkGR7REbnL1HQ9H8Q7p7tJhuvSuvIhAVL3UwKs+zL732lL7vUYtNgf3tsIVpCj
         vTLA==
X-Forwarded-Encrypted: i=1; AJvYcCWja1kSVfXk7z/rmdcQn+j84SQrVtT84SIRgeEgoeGInP4jb4b1cPpQi8jTLSQ95QoHiP3Zan1zxEy9hgA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYwZAWB6WXlj1RPn8Y4BPr16/P8bHhOMZeEr+HqeaE26v8Z0dK
	i50WvVgpBRbSUAv9zVYxvEAuK0lnufD9kmNVquRTvr2SDZWHAQjDJqnXW5cfeNO2tBm4h3z0YLb
	L7czOA6Ks9PS6ql2w8rNZTLmbJKIALBhvv9NNaA==
X-Gm-Gg: ASbGncv88eF7FhV7HDRqLnpluYg42kaqKRdgwjuYoLR4+wBWrgifYXIewpjTB17l4ai
	nHSM4V2oykZ4K/G2hmPmTM3hd0ygYVWVARtGAVQ6XVnQcDciRK76Vrdbmn3WAGU7NMAnh3nBWgO
	SXvnLiikfDh3IiS25DJO2qR+djaw==
X-Google-Smtp-Source: AGHT+IE8URVhSLvPJIFsnTX7Z5pSwgsdAxYcwLbP1+O/xS7LPEmPA9PmITKDBxz3rcylfz6xQGMlbZxbKqtozlnBWHY=
X-Received: by 2002:ad4:5b84:0:b0:6e6:698f:cafd with SMTP id
 6a1803df08f44-6e900681c65mr390346036d6.37.1741814219178; Wed, 12 Mar 2025
 14:16:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250311234109.136510-1-alex.vinarskis@gmail.com>
In-Reply-To: <20250311234109.136510-1-alex.vinarskis@gmail.com>
From: Stefan Schmidt <stefan.schmidt@linaro.org>
Date: Wed, 12 Mar 2025 22:16:48 +0100
X-Gm-Features: AQ5f1JpPzCg_wcL5Oq5TpalUho1WYNfDBRHd08R0PtwUoX5vs0HUJe7LYQzHVM0
Message-ID: <CAEvtbusre2PUwNiD42d-xTCVf4dV0npN-5UxxwrjriVOsbj0Fg@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] drm/msm/dp: Introduce link training per-segment
 for LTTPRs
To: Aleksandrs Vinarskis <alex.vinarskis@gmail.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, Rob Clark <robdclark@gmail.com>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, laurentiu.tudor1@dell.com, abel.vesa@linaro.org, 
	johan@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello Aleksandrs,

On Wed, 12 Mar 2025 at 00:41, Aleksandrs Vinarskis
<alex.vinarskis@gmail.com> wrote:
>
> Recently added Initial LTTPR support in msm/dp has configured LTTPR(s)
> to non-transparent mode to enable video output on X1E-based devices
> that come with LTTPR on the motherboards. However, video would not work
> if additional LTTPR(s) are present between sink and source, which is
> the case for USB Type-C docks (eg. Dell WD19TB/WD22TB4), and at least
> some universal Thunderbolt/USB Type-C monitors (eg. Dell U2725QE).
>
> First, take into account LTTPR capabilities when computing max link
> rate, number of lanes. Take into account previous discussion on the
> lists - exit early if reading DPCD caps failed. This also fixes
> "*ERROR* panel edid read failed" on some monitors which seems to be
> caused by msm_dp_panel_read_sink_caps running before LTTPR(s) are
> initialized.
>
> Finally, implement link training per-segment. Pass lttpr_count to all
> required helpers.
> This seems to also partially improve UI (Wayland) hanging when
> changing external display's link parameters (resolution, framerate):
> * Prior to this series, via direct USB Type-C to display connection,
>   attempt to change resolution or framerate hangs the UI, setting does
>   not stick. Some back and forth replugging finally sets desired
>   parameters.
> * With this series, via direct USB Type-C to display connection,
>   changing parameters works most of the time, without UI freezing. Via
>   docking station/multiple LTTPRs the setting again does not stick.
> * On Xorg changing link paramaters works in all combinations.
>
> These appear to be mainlink initialization related, as in all cases LT
> passes successfully.
>
> Test matrix:
> * Dell XPS 9345, Ubuntu 24.10, Gnome 47, Wayland
>         * Left USB Type-C, Right USB Type-C
>         * Direct monitor connection, Dell WD19TB, Dell WD22TB4, USB
>           Type-C to HDMI dongle, USB Type-C to DP dongle
>         * Dell AW3423DWF, Samsung LS24A600, dual Samsung LS24A600 (one
>           monitor per USB Type-C connector)
> * Dell XPS 9345, Ubuntu 24.10, Gnome 47, Wayland
>         * Left USB Type-C, Right USB Type-C
>         * Direct monitor connection
>         * Samsung S34BG85 (USB Type-C), Dell U2725QE (universal
>           Thunderbolt/USB Type-C, probes with an LTTPR when in USB
>           Type-C/DP Alt mode)

You can  add the following:
* Dell XPS 9345, Debian trixie/sid, Gnome 48, Wayland
        * Left USB Type-C, Right USB Type-C
        * Dell WD15 Dock with DisplayPort connected
        * Dell HD22Q dock with HDMI connected
        * USB Type-C to HDMI dongle
        * Dell U3417W

> In both cases, "Thunderbot Support"/"USB4 PCIE Tunneling" was disabled
> in UEFI to force universal Thunderbolt/USB Type-C devices to work in
> DP Alt mode.
> In both cases laptops had HBR3 patches applied [1], resulting in
> maximum successful link at 3440x1440@100hz and 4k@60hz respectively.
> When using Dell WD22TB4/U2725QE, USB Type-C pin assigment D got enabled
> and USB3.0 devices were working in parallel to video ouput.
>
> Known issues:
> * As mentioned above, it appears that on Gnome+Wayland framerate and
>   resolution parameter adjustment is not stable.

I can confirm this on Gnome 48 + Wayland as well. Sometimes the resolution
change from gnome settings gets stuck and does not apply. It normally works
here around every third try or so when using a dock.

> Due to lack of access to the official DisplayPort specfication, changes
> were primarily inspired by/reverse engineered from Intel's i915 driver.
>
> [1] https://lore.kernel.org/all/20250226231436.16138-2-alex.vinarskis@gmail.com/
>
> Signed-off-by: Aleksandrs Vinarskis <alex.vinarskis@gmail.com>

Tested-by: Stefan Schmidt <stefan.schmidt@linaro.org>

regards
Stefan Schmidt


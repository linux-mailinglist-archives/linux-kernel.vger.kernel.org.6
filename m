Return-Path: <linux-kernel+bounces-353331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC958992C58
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 14:48:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A17B1C2297E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 12:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D82821D415D;
	Mon,  7 Oct 2024 12:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dl443a54"
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF891D3183
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 12:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728305235; cv=none; b=iNxgU20bdO7qs3Dt9+nGVt3k8Gfm0BJljpvdppIPjp0FbaEmP4FZ2We3kGZXtA/wNE3hTe3MqVxHem7HGVlYa1Zr77IByDglKPMKT46EkcJLLePClDY3LUrlT6PTdNqNCOhBHAlFG+y95QBSBMPswQ9qPgZi1LMRuq1T18+eQ6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728305235; c=relaxed/simple;
	bh=jo6zA17WYEVKD4kAqrD5bI/uK/hqU/C2jgKYXrjvDXw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u4Vn2KIbcSCFA1vhdmDJQu47yoFwe17rkvSci46fr1ppF5BXSzvH+VdbFuYFjPgCcGaB6cJCtufArKUDAtYxXp7UgKIXWQ+vZon01eVzDkwulsnEbiq/7eyBON3+X9pOp2+1Q6g7CaHy7DHOxpPzm2kxFjqCEQS8Zeh81B+hORw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dl443a54; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6db836c6bd7so40092357b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 05:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728305231; x=1728910031; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OCFd3AswX/UvsHDjGk8fmcWJKuiqqQyLNfZu18RpBKc=;
        b=dl443a54a0VaC4qwaIDne7ufYge0BK6G6DjDTACR6ZyR40oJpVBnQk0FVnC05L9qkB
         lpGH8K1T92tCZ1mnQmfFPlIybdYCQOM+RGg+9pyiqL51qBUDxOJ64H196UVcA2YxgknA
         TybBNuK3rD3KUD5ltU6pItFrBxi1eHVL/SNgMuveGP3w1i3XM4Z8oCcSQn8KE6HYc2tz
         UsmGb+difN4H6wAvvW/DoO3BcUmrw7vqFDJzhQ3nOmr/WQZwnpLkBMkIh6w+VdRqvWiJ
         zlMVrf7E1kjXcWUXweGAh3uYZDr47J+xIcz2WIt5Yylkwmzt6/bOzPtC+huJCEOHYjt1
         rVqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728305231; x=1728910031;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OCFd3AswX/UvsHDjGk8fmcWJKuiqqQyLNfZu18RpBKc=;
        b=BXegw42utQtxlgwZg1oSzsR44y5OAIUIBXARbagzQ24zcc6xWQWVsVVMujqLqMS2nj
         OPt/tn4ulXY0n398jYmwtKaEWW2IVZ+MEBtdDnoaqeNunpG7cP6m7bh80FNu14vwW4oy
         EA+i+vPnAEsZADSCxYOjJ/6XdS2OpU9MGKdTj1M2c2vTMm7sXqJ7PPlmRk2b3yfq+l0V
         qkXP9WC2mkZGq3HwkatbEc8zMCcDnfTwgdkuRiJ7E+Dq1brPgYMeaJ2g3mS15WrVLryU
         2rqHURSILKYiI60GuvbDORppEfCqpa2jdOURimS2h7ng4J7h2Yi41C/mptoJRmrihc65
         9LHA==
X-Forwarded-Encrypted: i=1; AJvYcCXkdzD7Y6jrduMdzWBiGvSIvuyUjtj6kND5+R8SV9gbvbROKzY/2YTekH3YQnYmO1SSKAHXzis48uyZCOc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8Ufw0EZxJmzQ/tiqGZHTzg4YS6hJ0AL5UR4NuLsmpdW2FDKWY
	GmqzaDnQiuCkHx1tfFOlDWH0lVWP1QKQI5aKHWZGB1l/Tout2ejZ8nRIjr/gA54uVvrSMX9XCun
	kSjQFMFsBOMon+eqLmlhAWiwLKGmfQnczy20OHw==
X-Google-Smtp-Source: AGHT+IHcN86fNTn9NJS9sEdYsHveChw5c5a4u8Q17Bg6k1OV8AmiweKXXUKwE6aCQZaVkcm5WHu+zP0RnPEZbICAVoo=
X-Received: by 2002:a05:690c:6609:b0:6d1:41:5b35 with SMTP id
 00721157ae682-6e2c6ff649amr82400577b3.13.1728305230862; Mon, 07 Oct 2024
 05:47:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241002-fp5-ufs-therm-v1-1-1d2d8c1f08b5@fairphone.com>
 <fshhw6lknar4z36rc2sjjcgkiixpp7hak7gq3j373mjvbokax3@7s7kmzlmtjal> <D4PE64JTYDCL.3MC81CYK49TI0@fairphone.com>
In-Reply-To: <D4PE64JTYDCL.3MC81CYK49TI0@fairphone.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 7 Oct 2024 14:46:59 +0200
Message-ID: <CAA8EJpoYpiuVkD3ohoVhd9VXvCxpHPPfXfY0YqrQhABUc3WPdw@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: qcm6490-fairphone-fp5: Add thermistor
 for UFS/RAM
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 7 Oct 2024 at 09:22, Luca Weiss <luca.weiss@fairphone.com> wrote:
>
> On Sun Oct 6, 2024 at 10:26 PM CEST, Dmitry Baryshkov wrote:
> > On Wed, Oct 02, 2024 at 03:01:08PM GMT, Luca Weiss wrote:
> > > Configure the ADC and thermal zone for the thermistor next to the
> > > UFS+RAM chip which is connected to GPIO_12 of PM7250B. It is used to
> > > measure the temperature of that area of the PCB.
> > >
> > > Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> > > ---
> > >  arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts | 40 ++++++++++++++++++++++
> > >  1 file changed, 40 insertions(+)
> > >
> > > diff --git a/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts b/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
> > > index 8ab30c01712e0b7c0cc1b403e0fe01650315b9e2..fdc62f1b1c5a398abaa71818fdf2858fdc445d28 100644
> > > --- a/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
> > > +++ b/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
> > > @@ -207,6 +207,20 @@ active-config0 {
> > >                     };
> > >             };
> > >
> > > +           mem-thermal {
> > > +                   polling-delay-passive = <0>;
> > > +
> > > +                   thermal-sensors = <&pm7250b_adc_tm 2>;
> > > +
> > > +                   trips {
> > > +                           active-config0 {
> > > +                                   temperature = <125000>;
> > > +                                   hysteresis = <1000>;
> > > +                                   type = "passive";
> >
> > Is it really just "passive"? Especially with no cooling devices it
> > sounds more like "critical". LGTM otherwise.
>
> Hi Dmitry,
>
> To be clear, I'm adding the thermal zones now as a first step so that
> that they are declared and that they show up in /sys.
>
> This is for sure not the complete thermal configuration. Most other
> thermal zones in this dts also currently have 125 degC "passive" trip
> point, which I'd hope the device would never ever reach.

Sounds sane.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry


Return-Path: <linux-kernel+bounces-308374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D87FF965C26
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 10:54:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95120287329
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 08:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57A6D16EBF2;
	Fri, 30 Aug 2024 08:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tULGSbLv"
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064B616EB7E
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 08:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725008073; cv=none; b=EjJata9Wg96MK122kpKIFjw/C5qPbz+gBwt4E//EjmaDltMbwThF8UZO/scD6fS16/Bzy01dKIGgboa6gu6aCx32T+plMdAXJ/aoTVUp4O10gE//g7Xxae21LyaPGP8oHBykOQL0EYwna3p6aW8I1KRvbOfKHkveI/JgnBbbd4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725008073; c=relaxed/simple;
	bh=HDIME7t6dWh6Y/SJ6jARFKoMpQBsQiZFHIm/1CUWZ68=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YWRcTErzKaphXtHrGkejZQl0f8bdHOMgbiclGcxQuw6yiVke4+zONqU3zx5oDp1ybhivX7txxx6I192HGpwS+VEdQ4kBTuIkOy5IcA0pfOu+6f4G3IjKiSZon8qVPPXFjj1iZG+3uq6Mp71lgShBu0sIXiH1p6CqQoEMv4+3y3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tULGSbLv; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6ca1d6f549eso18387567b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 01:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725008071; x=1725612871; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iOs+ydvRJ2qhJNCxQ73aTsVT+NTo9Ltkz1jj00XSnt4=;
        b=tULGSbLvDjopNRFtNSi1GTVZUN0sn4LN/iQtKrEM0PtuDaaw5gFybVzbdwNOOzRY3t
         y3Cg79rXhTI1b5rdrbRk0WkQ7QFLJ3LAiAB+yAY7w2/RZDUe9XdylKdeeWW8XeFrZUNi
         sio0vmUCIoPewWzTJSgo6DxJSb3yXAlODkUw0ZtiXjqFWhwMkQzvPyxpAqAmhWZ/TREm
         0kj/cKxuBM4y1Lch13013iwv2ow7K+locYmP27CldeffRNSOMc2TNlJoTqLnWyckaIS1
         63WswQO4FDVKLnIVn2PQhRj/I9KxcTyyBvVQpkCVhsmfoNxiaWM632kq11GN0+GLSVmw
         R5Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725008071; x=1725612871;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iOs+ydvRJ2qhJNCxQ73aTsVT+NTo9Ltkz1jj00XSnt4=;
        b=k1zCPqXRhcN6ILPHud5jwZJH9MZ6LN4DVnkpragptxiNglJ7tg1Ki+s7N2KL20rSnh
         HQBFFege1XYwoCU/XJKmupaWeeuUoTP0N+qbSSp+iPzZF4Yd8w8QdCXCJY0Db/paZ35C
         VRLKS4ncDI0rVE3lEldZ07psN9dE0Edml29cxE3NfzZi1j3306Xk9rHKb4tMljw/qSkc
         5erGgkAM2Iiw/08EhMY+sW8kNAhsnKvzQ/MlVZNGXidFHXSRPLufq1b4oHBdE2C/L80G
         hrP+dT6d7Dwpp5haSMV3A8RCIBWZNUAKlapRLTiyfxpd6ZZgYp8fWcpmBZdGu0FNePT3
         pPJA==
X-Forwarded-Encrypted: i=1; AJvYcCUrm6sOs4Mz7W/1t+w0kPSrq5EHUg5Nwgyoo2O0Up+iTf3y2NMR00dwI/Y1mHlu3/NN4mzJqLUInF8XfQ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQLRabPKLE8OnrKFGnTedpGTlE0jglPE/EAUgoWWVmwcXIf2kj
	Jf0WMeY2V1dwqcF3uuzZAEB0SR0yJq+h0cdu3Ru0U14Om4CQ0Gy/w7yTMQZAsJSqj6tObOsy+o+
	kpeZI56Vr+lGKXdQ+Q6RIwvbjGHfn+frJFhp/ew==
X-Google-Smtp-Source: AGHT+IHpCk9Ie3tjfELqhlCu2x/52PgQgPKGQSoJw/xeowtbhkwR5jsEK8Pk9v8JuuAsJqiDSu6hAEek5J+97ycmVZE=
X-Received: by 2002:a05:690c:3412:b0:6b1:3bf8:c161 with SMTP id
 00721157ae682-6d40de6aceemr10973717b3.13.1725008070745; Fri, 30 Aug 2024
 01:54:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240818192905.120477-1-danila@jiaxyga.com> <5gmsbbnuc7sbkpptomvpl6aarw5poutvjfav5rilgogb7727vi@nhtr5m24tkmt>
 <ZtGCJincjO7z-WFm@linaro.org>
In-Reply-To: <ZtGCJincjO7z-WFm@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 30 Aug 2024 11:54:19 +0300
Message-ID: <CAA8EJpopMPSBmxJHbatfF+fNoSWipbepyj+7qJRG23WYOCCWzg@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: sc7280.dtsi: Fix PMU nodes for Cortex
 A55 and A78
To: Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: Danila Tikhonov <danila@jiaxyga.com>, andersson@kernel.org, konradybcio@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux@mainlining.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 30 Aug 2024 at 11:26, Stephan Gerhold
<stephan.gerhold@linaro.org> wrote:
>
> On Fri, Aug 30, 2024 at 11:13:28AM +0300, Dmitry Baryshkov wrote:
> > On Sun, Aug 18, 2024 at 10:29:05PM GMT, Danila Tikhonov wrote:
> > > The SC7280, SM7325, and QCM6490 platforms feature an 8-core setup
> > > consisting of:
> > > - 1x Kryo 670 Prime (Cortex-A78) / Kryo 670 Gold Plus (Cortex-A78)
> > > - 3x Kryo 670 Gold (Cortex-A78)
> > > - 4x Kryo 670 Silver (Cortex-A55)
> > > (The CPU cores in the SC7280 are simply called Kryo, but are
> > > nevertheless based on the same Cortex A78 and A55).
> > >
> > > Use the correct compatibility.
> > >
> > > Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
> > > ---
> > >  arch/arm64/boot/dts/qcom/sc7280.dtsi | 9 +++++++--
> > >  1 file changed, 7 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> > > index 91cc5e74d8f5..ab024a3c3653 100644
> > > --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> > > +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> > > @@ -845,8 +845,13 @@ wlan_smp2p_in: wlan-wpss-to-ap {
> > >             };
> > >     };
> > >
> > > -   pmu {
> > > -           compatible = "arm,armv8-pmuv3";
> > > +   pmu-a55 {
> > > +           compatible = "arm,cortex-a55-pmu";
> > > +           interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW>;
> > > +   };
> > > +
> > > +   pmu-a78 {
> > > +           compatible = "arm,cortex-a78-pmu";
> > >             interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW>;
> >
> > Shouldn't these two entries have GIC_CPU_MASK_RAW(), limiting interrupts
> > to the corresponding cores? I see that in [1] Rob used masks for older
> > SoCs, but skipped them for newer ones.
> >
> > [1] https://lore.kernel.org/all/20240417204247.3216703-1-robh@kernel.org/
> >
>
> According to the bindings, the cpu mask bits apply only to gic-v2, but
> not gic-v3. It looks correct in Rob's changes. And here too, since
> SC7280 uses gic-v3.

Ack, thanks for the clarification.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry


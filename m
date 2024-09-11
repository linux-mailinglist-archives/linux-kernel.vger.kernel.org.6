Return-Path: <linux-kernel+bounces-324243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 554CE974A10
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 08:03:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1B7D1F258CD
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 06:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2E9F6A33B;
	Wed, 11 Sep 2024 06:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lSQ0zyCz"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A02A40849
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 06:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726034585; cv=none; b=FWmVw0b/Ysw4Mkgiw+cX43rC9T7KZvVIiRBkzVHBrPJy1VtrFxJGrThhuNdpxXacB09MFfPAjOgWu9lVrlt6Q1j1jmFzmH96HAS9SMOFlDfG4Pv1naTF6Apkyk4Co13HQpUa0+f8KkDyKSxN0fNnQrftJTq8qUlglbp7VOYvaZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726034585; c=relaxed/simple;
	bh=IWXyZX/BABhVqPURZnfbPjqaTPRUyX55KWrYSuLB7sc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WaRzFot5WqJPiwEa+RPbr9XgIRBMLmvkKVJuHXt+QUuJVxeKHSsWWyHoODh/PIoir6IR9XdiBI19NJBlPgWJHvSX3oZhydaLcBZoWc3xDxNC/qYIxdAVjQPZkMCg7Pzggu1+LU8NNVFYZkzQ2eeR+Gngvrvacn3DWwuY4hYm3Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lSQ0zyCz; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2f75f116d11so45650581fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 23:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726034582; x=1726639382; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IWXyZX/BABhVqPURZnfbPjqaTPRUyX55KWrYSuLB7sc=;
        b=lSQ0zyCzwcD+XVTPE0Jz5i+LWQ0iKqHNyJVhiu0pFqYeSlmDFtdTFM7XZixf/m0jms
         bUWcmRF7+FKw/E8eVqkzSMVs79CLAxJG04iDZDr/tar1S2gAWfGsQ9EI76gC83j3enMP
         mOxzdtoLjPOEHD5sJ2dXi+rWfUZQRkTUjQZrTwYFFTzFc7wgvm4ZS8o8AUSTaNgAUf8D
         nNRF6TjV8YcLKb5tVCTWxsaNbMi85QyaBac3LDU5+7vjtNnf/qNtfrLlyWwcPKFFWmH3
         23rfgdRiXGu/h8lFmOiP8EU+CLAG9bzvO0sbRJGH62uDtfFRytPRnsvlwsA7fyDVd3l3
         hrjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726034582; x=1726639382;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IWXyZX/BABhVqPURZnfbPjqaTPRUyX55KWrYSuLB7sc=;
        b=lw+ZGNHYUkQGpzWed0VE0H/eMfH9doyeYRS0OGaJI3I7Nx2xze54mKIhADuwZt2E7R
         5vgRhbfMHW64jQ/iEKRQXhpSjCaskaywdo0dF3UxAg9Zx3rQvkGhbgw7OUmZyhl+kGrV
         IbEP1kH2u+3ECVsgIpewtykInSl4au/gFcFJRKst2MC2+Ggou5reUojM7wsrBP1OghoK
         SZv1kDBdnWLHibWsNt1RYj+iSLCLxO5j/g2Yvidqi9m46RGXdiCaBK/nhIfLDxJCMUWt
         3rpLtOSYUlnlzKItDZzF7slKjmU45yNjCwKo78qpAMQoQEmoqYNGZCGqD95wsBjBsd4G
         +WwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUInwh6q56El/Sf3cm3n8Nn7JosKVed3IFs1/Nn7h/gvD6MWxADLSEuzh+4I3jiK5TrT+5KlfqorV5ff5E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAN9gfJX4aqG80bVy/YXNqaQieCj3EiN7drDpZEQkqZCXTKw3d
	zGIvbAnCL/nzPjpelhsThQtkBF2J1sTkhOl2EFQIlvrCLwf4gsrGBGVq06tjjrfHecMwSPmDtC2
	y+fgYPqLOvOTqqQk1ix66EE2CggekoQxzVtGqgg==
X-Google-Smtp-Source: AGHT+IEKcEc0vkUi3kt06ur7l2/NI35YiF76L8/yOuPvizN/uielWZMSkoot3CwU47jveoRhzpyaTCSYSRo83HxrpU0=
X-Received: by 2002:a05:651c:1546:b0:2f7:5b47:ac1f with SMTP id
 38308e7fff4ca-2f75b47aee9mr77759211fa.29.1726034581202; Tue, 10 Sep 2024
 23:03:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240902224815.78220-1-ulf.hansson@linaro.org>
 <20240902224815.78220-3-ulf.hansson@linaro.org> <20240903071638.bedt3gllqdacf43a@vireshk-i7>
 <CAPDyKFoqEAHns0nrXT6dJR3sRd5VWidK_rzXGHzJiZtk_p0cKw@mail.gmail.com>
 <20240903105321.suosbhkkkylfw4bv@vireshk-i7> <CAPDyKFrh4VASFzMxEg3Q8SrhVbt1vH8QJM0rCdfxo+-L1+CN_g@mail.gmail.com>
 <20240904064004.7hwfom4nrqzfkvlo@vireshk-i7> <CAPDyKFqZiX=F4oNa3H+fUCO9cRzapxMaAphdx+JFXuR-Tgv3Cw@mail.gmail.com>
 <20240906061405.bz7y3erlz4v5fvvd@vireshk-i7> <CAPDyKFpbA-fopq11Lc0j9hgM86DjveNh+Q=w=nEn2fvcFyp93w@mail.gmail.com>
In-Reply-To: <CAPDyKFpbA-fopq11Lc0j9hgM86DjveNh+Q=w=nEn2fvcFyp93w@mail.gmail.com>
From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Wed, 11 Sep 2024 11:32:49 +0530
Message-ID: <CAKohponJsqOYAvQqU2qrBCXv_P0+0zKAm7-5gkKGPsF_kT7L0w@mail.gmail.com>
Subject: Re: [PATCH 2/2] OPP/pmdomain: Fix the assignment of the required-devs
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, 
	Dikshita Agarwal <quic_dikshita@quicinc.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <quic_kdybcio@quicinc.com>, Nikunj Kela <nkela@quicinc.com>, 
	"Bryan O'Donoghue" <bryan.odonoghue@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, 
	Mikko Perttunen <mperttunen@nvidia.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Stephan Gerhold <stephan@gerhold.net>, Ilia Lin <ilia.lin@kernel.org>, 
	Stanimir Varbanov <stanimir.k.varbanov@gmail.com>, Vikash Garodia <quic_vgarodia@quicinc.com>, 
	linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

FYI, I am on holidays now :)

On Fri, 6 Sept 2024 at 14:19, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > How do we differentiate between two cases where the required-opps can
> > be defined as either of these:
> >
> > required-opps = <&opp_pd_50, &opp_pd_51>; //corresponds to pd_perf1 and pd_perf0 (in reverse order)
> >
> > OR
> >
> > required-opps = <&opp_pd_51, &opp_pd_50>; //corresponds to pd_perf0 and pd_perf1
> >
> > I thought this can't be fixed without some platform code telling how
> > the DT is really configured, i.e. order of the power domains in the
> > required-opps.
>
> I don't think we need platform code for this.
>
> When registering a genpd provider, an OPP table gets assigned to it.

So we will create a real OPP table in code, which will point to the common
OPP table in DT. Fine.

> When hooking up a device to one of its genpd providers, that virtual
> device then also gets a handle to its genpd's OPP table.

Right.

If there are two genpds required for a device from the same genpd provider, the
picture isn't very clear at this point. i.e. which required OPP
belongs to which genpd,
as both have same table in DT.

> Each of the phandles in the required-opps points to another OPP table,
> which OPP table should be associated with a specific genpd.

Yes, but a simple order reversal in DT (which I sent in my last
email), will not be picked
by code at all. i.e. DT doesn't give the order in which required OPPs
are present.

> In other words, the information is there, we should not need anything
> additional in DT.


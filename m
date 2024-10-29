Return-Path: <linux-kernel+bounces-386983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AB689B4A6F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 14:01:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B609728460C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 13:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD2C7206055;
	Tue, 29 Oct 2024 13:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y7KpE/W2"
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4F1205AD2
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 13:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730206834; cv=none; b=Ob+fdAi/asyd+QiSoK43hiL8KVWBUrA3zzdF3WXrQF8lulc9nuExPDZS465/5dymENnsCd9C18p8PV04K1d4wOJctQIibJ7Zp2w0Rve+z4gwx/I9arjsEu+cSw8GbX8ZRGEmWCl5Yr3s+E31C7bG02szERNAaT5D1RsWP4PWVtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730206834; c=relaxed/simple;
	bh=YmsNP2KTqCdcVBZwhpdMQVUtMGwCTgWv9lgMj09bDmQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CwCFa8dNemtBPDq4TBg1uyL+Zaruq+5nVGLbfMURELJaXbN/PPDzf2ES+QsumROODgGkcrUU4KCD1nwz7eBu+jkiM90zbr8lKLR1i4QGx8mAHcnC1uZSqU9VMvBS0nAGg0pMGpxvtBIaCg698NvMZ+RjnOPCNjKjKRMYnNkZy2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=y7KpE/W2; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6e5e5c43497so45272147b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 06:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730206831; x=1730811631; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9olNTqPKz+laBr1M4W4FfYgdBmMaq3StAwgPxtx+j7k=;
        b=y7KpE/W2J/V0XD9GX9GmgPy8CUx/KHXFf2sQ4k06bZ7l9/NriFqUGUvXgYTxJ9Lihx
         jYIGdVoAKMPJAftYqxPdjYB0LJ3DF+yTcGUsgF0A1u+vPivG1RjnSCtNT8rOMyS1h8Uc
         Xn/ihMR7nMS5XwK4csTc6fX0xOneZWjbvBplDpujZwR3nj+UmSlkzWRuIkJWpahjieJb
         XLrVsqRIteaYU2j6XEcMcwQeArsWRwD19hSJ9Ktl5KAmPaKql+B9zE63Ci6caPiLU3eM
         ig/DNRU8OqdNDgZXfbdgM2yKE9bZxfWZXun2bXubkUZgtHvMvkNB1uNiF4qz4Qanohde
         +UXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730206831; x=1730811631;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9olNTqPKz+laBr1M4W4FfYgdBmMaq3StAwgPxtx+j7k=;
        b=uQZhTkgvA1fXM1MUvDM30BadJ5k+nz5tzH50xv/NUWmnHGw7DwFtJo4sYNsUaTvePi
         1V25iE3lADIJcK8y2yvYtU4IVC+2vQJ1RGjGrilYG4A5ltT7v89teBL9JpepMUnsGqtd
         7ysmgULwikjgctYSu5Meacm+2arhfDnQ9vQWDWAylYsFhqkdyHG2fVV0mriznh3G3jdD
         P0PPo7lXZm3bX8qBe9Hw8+cMuS4/V2DFxzgAz4Mh2m5DMt3Rg7ZX+nZhuY5S2QoczI01
         2d37jRE71duldyzABnJ1CRH8B4jIPkVRfDhpEz29IbekgOQIdAM4F1yx3nsf2e6LaqvG
         Q21A==
X-Forwarded-Encrypted: i=1; AJvYcCXyRVLC74nthZBBdh8JpiwpLDi9vIdA8mtOwnM8a+Ns8DL0n47I2NDJXBM+qkcG3MFTMIwnf9ixkxdCunQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXYnGfvmDvjFCOPiibTgAT/M15F0pVgTBbompB9h5uBDmP52TG
	tGYmyjmX6FxZwmDegRNaMxMTCeJuCGpSwnkRoK+EmkgUNWjdmOe1M6REQabURmOojwH2+mbJbqu
	SdlYK3fohyDcrJO+um8tkmSdLGKcTVZULB8bW8A==
X-Google-Smtp-Source: AGHT+IFbKndRQHp+7RzFAeO0rylRtbyrpK9kh0Zw4o5eR2NycLUcgLYSm3N60gfqGUIcaqo/gsLqHGbK1ZMtf/8ZCd0=
X-Received: by 2002:a05:690c:385:b0:64b:5cc7:bcbc with SMTP id
 00721157ae682-6e9d8aa8014mr135400007b3.32.1730206826513; Tue, 29 Oct 2024
 06:00:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008112516.17702-1-quic_mukhopad@quicinc.com>
 <20241008112516.17702-3-quic_mukhopad@quicinc.com> <zluuezrywecffsh3f7yzrtvd2sa3nyzl52sk6bluvjch5icvuu@noecozosseko>
 <e7543055-316e-447e-ab0e-15d2fdd19dca@quicinc.com> <CAA8EJpqcnxbZAUJm0fdbQNjZ3Dw189oDMkC+0pMLz1XGO7HhnQ@mail.gmail.com>
 <fad3508a-bb02-4162-8803-fba5de25e752@quicinc.com>
In-Reply-To: <fad3508a-bb02-4162-8803-fba5de25e752@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 29 Oct 2024 15:00:11 +0200
Message-ID: <CAA8EJprTc=kviF=MYQFqnE4g0Xk+jmT96=ihm3D75Me1Yw-WQA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] arm64: dts: qcom: sa8775p-ride: Enable Display Port
To: Soutrik Mukhopadhyay <quic_mukhopad@quicinc.com>
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	quic_riteshk@quicinc.com, quic_vproddut@quicinc.com, 
	quic_abhinavk@quicinc.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 29 Oct 2024 at 08:08, Soutrik Mukhopadhyay
<quic_mukhopad@quicinc.com> wrote:
>
>
> On 10/28/2024 3:15 PM, Dmitry Baryshkov wrote:
> > On Mon, 28 Oct 2024 at 10:49, Soutrik Mukhopadhyay
> > <quic_mukhopad@quicinc.com> wrote:
> >>
> >> On 10/8/2024 5:46 PM, Dmitry Baryshkov wrote:
> >>> On Tue, Oct 08, 2024 at 04:55:16PM GMT, Soutrik Mukhopadhyay wrote:
> >>>> Enable DPTX0 and DPTX1 along with their corresponding PHYs for
> >>>> sa8775p-ride platform.
> >>> What is connected to those DP lanes? If they are routed directly to the
> >>> DisplayPort connectors, please add corresponding devices (see
> >>> dp-connector).
> >>
> >> We are defining the functionality of gpio101 and gpio102 as "edp0_hot"
> >> and "edp1_hot"
> >>
> >> respectively. This ensures that the hot plug will be directly routed via
> >> the display interrupt
> >>
> >> line "mdss0" to the display port driver and no external dependencies on
> >> dp-connector is
> >>
> >> necessary.
> > Please describe the hardware, not the driver necessities.
> > If the board has a DP connector, please add the node. E.g. it allows
> > one to specify the label and the type used by the connector.
> >
> > Also could you please fix your email client so that you don't have
> > strange/unnecessary line wraps and empty lines?
>
> Addition of DP connector node with the hpd-gpio property does not allow
> hpd to be detected since the gpio
>
> 101/102 have the "edp0_hot" as function. If the hpd-gpio property is
> removed from the DP connector node,
>
> the probe of DP connector will fail.

No, it wont. It uses devm_gpiod_get_optional(). And if it does fail,
it is a bug which needs to be fixed.

And please, fix your email client so that it doesn't insert stray empty lines.

-- 
With best wishes
Dmitry


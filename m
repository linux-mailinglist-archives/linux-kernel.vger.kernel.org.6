Return-Path: <linux-kernel+bounces-336800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 840DA984106
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 10:48:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39CBE1F211E1
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 08:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4F70149DF0;
	Tue, 24 Sep 2024 08:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ANZswWB4"
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B7C1514CE
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 08:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727167709; cv=none; b=TqHU3cBPNKm/5m+PErbhyApNJ6ubLkdP9iObsipuCgNqkh0Z/DsNKAzgENLA0hnyosBmKuLAiGT2csqUqLyGIUFkXvxrbf89PPT8rCA1n/Rkd+SlmERq+6OKfSV6u64Osblx6ICrx3/v4KG5RWKdzoPt7poWyGKeycvSI88dfAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727167709; c=relaxed/simple;
	bh=0yqEWSs7GVnNVj9B86DTJColxU1Lh2YPeaXfonjzaq4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PryhrKOqm0p1E3KzE4QXzWiyLazm7hoR5vKMXLGagpwoPFPZH5dJ/lEMQUtXfzjAuC5vB6BOrBCVZBKqaSvQnZa9JvmeBHiw6cDZF5K1PhGA7Bmx4bNSb1rbNA7O/2y9OvBw+f4zltrUwHwlr5y3Pu4L0PjGtwbSCADPbj69QjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ANZswWB4; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6dfff346a83so30145607b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 01:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727167706; x=1727772506; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=O2BW7rW1FYVjlIde6zrnL8EA7RyRxs80o9NImTHzZY0=;
        b=ANZswWB41hz+1U4yP2nFLn48z/Y3iaDEX5SZHJnD/eP/lMRsBsrTI7DU2A8Q09+NTd
         jOWMYaMfbHA2+wxItI7jKAJzM3C2uhH3wGXF6YQgiPPSYVk5w5TGeqlHz1LgS4O7ygeM
         XUiL6GWPXYDuPqivk064mcB3lRFDGI4XlnH6T/1rGhMgWzIFBKweEnZKEqFqCab9+O31
         gdSykt1bAkBgpoRhic9aCwvheAOn0jY+xO6PxZ7vAVXQLEexWW5P16BEEW1pTXo0VpNk
         dH/K2nF8Rr8CWP+I4LlUepuBNpKcMRQkuk/C3ghzgfAk25Z+uAnv0d/Bu2JquWrLOZFl
         TMag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727167706; x=1727772506;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O2BW7rW1FYVjlIde6zrnL8EA7RyRxs80o9NImTHzZY0=;
        b=ZUqspYfQw+FMqInoNuGknA+9ohstXpB0ibzluW+lbj3ke0MD0FE93ZRaAgtHVsYRwy
         QwTqp7m6rfGvArZbFTqvy8RgnB81MYl3b7hoDbVIMwQMiIEoaA8SX9cYrl7+kGWLNNd4
         ooHCzUhvuobnl02INPoHjeoBl3duwxNgVTQVfiVuspGW0MGPCAHOB8aaEn/2W0tIB9I0
         3NUc/C9saTywZ/SkXaTapain8ejyqmDtP0Kudn9ZXebv5VTIhCm95FESi3AfdBgDi6kp
         Bh6gdVzG5cn7m7/TdpA8Ej8FBv6fU6130N98xik/CD2KTM3mJl22cc23kTuC18FQ7uQo
         Vy/w==
X-Forwarded-Encrypted: i=1; AJvYcCU8yi9EbrA/AAZw0LzkNiw1u8gTWVc/4Yy5Zz4xWKm9T5TVNLusNdYdh0YsKvX+Grj2Dl5ptd6Cv4rMzcY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnA3sKtenIVfdj+IHa18iTbUpjmxc3+Q7f47uA+qqaQC0xbxhA
	rUKabHCMj7YVBT3qeagaGqRHp6aWk1xSTPrK4HE9ZDmkySVFN6XHVvgrQD07OMx9E0n6iHnr8WA
	pWVQOSad2fAAA9BM9RTButyiCsyLLUdWW4GS5YA==
X-Google-Smtp-Source: AGHT+IFCb5BRAlbLnAzwWjcBmVLE/ekCw6xTHW2PJeqbqJNzwemf1kqX/aZu6O5ynInq2xTnD+jZsJNpJ4482s31YGo=
X-Received: by 2002:a05:690c:3005:b0:6dc:45ef:d933 with SMTP id
 00721157ae682-6dfeefe56famr87702667b3.43.1727167706566; Tue, 24 Sep 2024
 01:48:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240912071437.1708969-1-quic_mahap@quicinc.com>
 <7fcbvouzb7gq6lclrkgs6pxondvj5wvutyw3swg55ugvzfpvd4@2ph7x7ulxoyv> <013459fd-fbb0-4225-90e3-a16115154646@quicinc.com>
In-Reply-To: <013459fd-fbb0-4225-90e3-a16115154646@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 24 Sep 2024 10:48:16 +0200
Message-ID: <CAA8EJpooSPgUbZdvDeQcrauAU80sL98uVojVhrK++8=+atsj7g@mail.gmail.com>
Subject: Re: [PATCH 0/5] Add display support for Qualcomm SA8775P platform
To: Mahadevan P <quic_mahap@quicinc.com>
Cc: robdclark@gmail.com, quic_abhinavk@quicinc.com, sean@poorly.run, 
	marijn.suijten@somainline.org, airlied@gmail.com, daniel@ffwll.ch, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, swboyd@chromium.org, 
	konrad.dybcio@linaro.org, danila@jiaxyga.com, bigfoot@classfun.cn, 
	neil.armstrong@linaro.org, mailingradian@gmail.com, quic_jesszhan@quicinc.com, 
	andersson@kernel.org, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	quic_kalyant@quicinc.com, quic_jmadiset@quicinc.com, 
	quic_vpolimer@quicinc.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 24 Sept 2024 at 09:16, Mahadevan P <quic_mahap@quicinc.com> wrote:
>
>
> On 9/12/2024 1:26 PM, Dmitry Baryshkov wrote:
> > On Thu, Sep 12, 2024 at 12:44:32PM GMT, Mahadevan wrote:
> >> Add support for mdss and dpu driver on Qualcomm SA8775P platform.
> >>
> >> ---
> >> This series depends on following series:
> >> https://lore.kernel.org/all/20240816-sa8775p-mm-v3-v1-0-77d53c3c0cef@quicinc.com/
> > As such, it probably can not be merged before 6.14 (the mentioned series
> > will go on 6.13, we usually don't do cross-tree merges into drm). Please
> > rework the bindings to drop the dependency (it is possible, use fake
> > nodes instead of using dispcc + ID). Then you can specify that only the
> > DTS patch depends on the dispcc support, allowing driver changes to go
> > in first.
>
>
> Can we use clocks = <&dummy_dispcc 0>, <&dummy_dispcc 1>,
> <&dummy_dispcc 2>; instead of  clocks =  <&dispcc0
> MDSS_DISP_CC_MDSS_AHB_CLK>, <&dispcc0 MDSS_DISP_CC_MDSS_MDP_LUT_CLK>,
> <&dispcc0 MDSS_DISP_CC_MDSS_MDP_CLK>; in dt bindings?

Please take a look at how other platforms solved that already rather
than inventing a new way. For example, see sm7150, sm8650, x1e80100.

>
> >
> >> ---
> >>
> >> Mahadevan (5):
> >>    dt-bindings: display/msm: Document MDSS on SA8775P
> >>    dt-bindings: display/msm: Document the DPU for SA8775P
> >>    drm/msm: mdss: Add SA8775P support
> >>    drm/msm/dpu: Add SA8775P support
> >>    arm64: dts: qcom: sa8775p: add display dt nodes
> >>
> >>   .../display/msm/qcom,sa8775p-dpu.yaml         | 120 +++++
> >>   .../display/msm/qcom,sa8775p-mdss.yaml        | 225 ++++++++
> >>   arch/arm64/boot/dts/qcom/sa8775p.dtsi         |  85 +++
> >>   .../msm/disp/dpu1/catalog/dpu_8_4_sa8775p.h   | 485 ++++++++++++++++++
> >>   .../gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c    |   3 +-
> >>   .../gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h    |   3 +-
> >>   drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c       |   3 +-
> >>   drivers/gpu/drm/msm/msm_mdss.c                |  10 +
> >>   8 files changed, 931 insertions(+), 3 deletions(-)
> >>   create mode 100644 Documentation/devicetree/bindings/display/msm/qcom,sa8775p-dpu.yaml
> >>   create mode 100644 Documentation/devicetree/bindings/display/msm/qcom,sa8775p-mdss.yaml
> >>   create mode 100644 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_8_4_sa8775p.h
> >>
> >> --
> >> 2.34.1
> >>



-- 
With best wishes
Dmitry


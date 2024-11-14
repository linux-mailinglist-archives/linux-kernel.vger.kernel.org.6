Return-Path: <linux-kernel+bounces-409385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3311A9C8C01
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 14:41:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A06328A040
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 13:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC55A17588;
	Thu, 14 Nov 2024 13:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DS8qgtwE"
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E1BF9C0
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 13:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731591703; cv=none; b=kQ4PAcIGK0zFrZrVlRtl+XS0TRaAVvsWwV3NsdW1C1sVsag+UEa8Qzp8qadBKFJspVrYm2KuZCoqe5/x85oxKJb9XvGJ7fwzDID/VoAmz5preFqwfAwye69mcZpmai5EsqYo9ANmSY4V/QD/7Ew5U3s5/S3Z2yMl+LSTCFRFAs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731591703; c=relaxed/simple;
	bh=PkTf6Oyh2G9dE6OdDYSy/zHRxjObUWUPqodlEvn612c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ltq5tBF+9FE73EUEomsSR/1cUl0SRU//gaqu83P9yzvukeGp34StOZAek16QBUkGnjw4EydBXcDhzx0OnUQw16BVH2Xgw9naCZg8oGPLWbZ0xIyERcNEVUQ+ql62muAacxjY6quyBxQjZgpTJCJnrPyikjLMqs+M44XczFkb5YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DS8qgtwE; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e381bfce6a4so349363276.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 05:41:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731591701; x=1732196501; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Spz/FLEs6rhZtrhf3mKJTQa4j7O7N/nH4uWZ4nNC+/E=;
        b=DS8qgtwEx39FNr6LSgM9Hh74T59n05wADeMabPAZTb8aaKzg+8hnT/U0c8nbkbf4D5
         saJnDWjoZ0m+t5zC7+fA2rqskK7xhaIiz7OhCV+DNNDXl927jB43Bt/cg4YJHSBjqFKA
         meOP6n36MA71c6onKGkvzY364LuKn6qbY5CMoqW3WbpqYFEKJedfEr1hv+HSGYNoVBMR
         QsiTrrK3VHb7WQK00PeXDj5HjsrPkr/Y38RZxMZMBwxiS09ZmmzqJ8IhOwwJq8cxDkzZ
         yShrA9Ml/Iwb80cx8D1zazGHssaTByGa0b2JQsAaCsLfRfEDX3szGdmCRJlYmIPKXI7A
         NSeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731591701; x=1732196501;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Spz/FLEs6rhZtrhf3mKJTQa4j7O7N/nH4uWZ4nNC+/E=;
        b=iJIIhAAxowXyFxheTps4vIs7llo5qkHYkqA3Alt7R7qaz3OPlmkdyAJ6OIqMj7XRES
         LZ3V/64xM434463zCatE21uXtzBjsUx5RRXyJSM+hwFnLNgD+oruk+t8Mitdk7TFGZd9
         0Yzat4jAzRQTSqhBVpoP5GaF/lyOsr+vwygn4a0J9xJLUqqpy7jixuiqv5pmk/VjCDvX
         l8silQaAb3NVtf9y9dkC8u8eyXFEU/7VksLS539HGQQYSQLXce/vniJ2TXdZ5ga+nubJ
         7gXGDrpBOTjnRcD3Li1OT2rhOm9jH5ZbwehvfnaCt+ZrbOrsBs+5kyWCiFbAAynA52Gr
         wsFg==
X-Forwarded-Encrypted: i=1; AJvYcCWmTIj3bA/7oEseSCCu915zdGN22/6aGCwgGHFRX/UCET7pcsDsdiWiR2HJWhvDm4niBvKl22iX2yS7ym0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk1atrDAvxIp2/YQf5J/aV5zvjtbwKRLVfwmmiFf4g+e6gQNfq
	RpM5gyu1F0NgnesJW7afa+pxVVvuEkoPb5cx921BIljDcfPWoixDKmCe4+5G8dQbWSzP3ZJXLXX
	0ZwiPnN/BtCsteFk8B4GuuBFWHtJsDLrYo6V8yA==
X-Google-Smtp-Source: AGHT+IE9OBhWPTuVNohC5WRAGntCMa66vHJnC0GsF9hH0ovM6xYCWXHrFVChjjSq9tv9jWS0r9j8CiJ3oX8Geq2uOGI=
X-Received: by 2002:a05:6902:2c02:b0:e38:1364:7075 with SMTP id
 3f1490d57ef6-e381364718fmr1343941276.29.1731591700646; Thu, 14 Nov 2024
 05:41:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241113-add-display-support-for-qcs615-platform-v2-0-2873eb6fb869@quicinc.com>
 <20241113-add-display-support-for-qcs615-platform-v2-6-2873eb6fb869@quicinc.com>
 <404f006b-46e5-44db-9f22-ec2139468ecc@oss.qualcomm.com>
In-Reply-To: <404f006b-46e5-44db-9f22-ec2139468ecc@oss.qualcomm.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 14 Nov 2024 15:41:29 +0200
Message-ID: <CAA8EJpqQSp5eXoKHHEchKpGq9ZpU0k0RDASA8T+t+SENNx+_fQ@mail.gmail.com>
Subject: Re: [PATCH v2 6/9] drm/msm/dsi: Add support for QCS615
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Fange Zhang <quic_fangez@quicinc.com>, Rob Clark <robdclark@gmail.com>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Krishna Manikandan <quic_mkrishn@quicinc.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Li Liu <quic_lliu6@quicinc.com>, 
	Xiangxu Yin <quic_xiangxuy@quicinc.com>, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 14 Nov 2024 at 15:32, Konrad Dybcio
<konrad.dybcio@oss.qualcomm.com> wrote:
>
> On 13.11.2024 12:51 PM, Fange Zhang wrote:
> > From: Li Liu <quic_lliu6@quicinc.com>
> >
> > Add support for DSI 2.3.1 (block used on QCS615).
> > Add phy configuration for QCS615
> >
> > Signed-off-by: Li Liu <quic_lliu6@quicinc.com>
> > Signed-off-by: Fange Zhang <quic_fangez@quicinc.com>
> > ---
> >  drivers/gpu/drm/msm/dsi/dsi_cfg.c          | 17 +++++++++++++++++
> >  drivers/gpu/drm/msm/dsi/dsi_cfg.h          |  1 +
> >  drivers/gpu/drm/msm/dsi/phy/dsi_phy.c      |  2 ++
> >  drivers/gpu/drm/msm/dsi/phy/dsi_phy.h      |  1 +
> >  drivers/gpu/drm/msm/dsi/phy/dsi_phy_14nm.c | 21 +++++++++++++++++++++
> >  5 files changed, 42 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/msm/dsi/dsi_cfg.c b/drivers/gpu/drm/msm/dsi/dsi_cfg.c
> > index 10ba7d153d1cfc9015f527c911c4658558f6e29e..edbe50305d6e85fb615afa41f3b0db664d2f4413 100644
> > --- a/drivers/gpu/drm/msm/dsi/dsi_cfg.c
> > +++ b/drivers/gpu/drm/msm/dsi/dsi_cfg.c
> > @@ -221,6 +221,21 @@ static const struct msm_dsi_config sc7280_dsi_cfg = {
> >       },
> >  };
> >
> > +static const struct regulator_bulk_data qcs615_dsi_regulators[] = {
> > +     { .supply = "vdda", .init_load_uA = 21800 },
> > +};
>
> I believe refgen is also present here and you can reuse dsi_v2_4_regulators

This was in feedback for v1... And the patch should be further split,
having DSI and PHY parts separately.

-- 
With best wishes
Dmitry


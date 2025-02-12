Return-Path: <linux-kernel+bounces-510944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57357A323E8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 11:51:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACC62188A053
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 10:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69228209F56;
	Wed, 12 Feb 2025 10:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nE8qgmOA"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC464209F24
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 10:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739357476; cv=none; b=tmrjJax3VlPKz6f8q9WTTcu6L0mwDzvuGetIRuxIYC8pRk7+FUyg0oUWVk2TznsShCe/Ct5a7ZODNNDqVvi+pd0leFave2b5WIlTcsUAAAif9ngWGIfizRSxDIbA/cBUgrKpmfz6d0ubwljvaBdYeNLmJiq0gf+00o6yyz1Tf9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739357476; c=relaxed/simple;
	bh=icla1TpQOFmiFDBsQYkHvOp8ZGI082xL7fkqAzRQ030=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M6tin1kTHPCQ1VwH6mkVK2IyoNRR3ypiv19myjJvCt1XgfE30NNZ/jaxCLodj0IkOYL17DNiXDYecd/Pk88R2h+6+aKfys50TMSqGrSmxZZoJ5yCnPVsZ35aTa+t2NsRvswPBlUgwqXQotlUGPyn/C+b7I6nMQXuhUHXJvkW2yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nE8qgmOA; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-545064389d3so4202217e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 02:51:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739357473; x=1739962273; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kFIw2XQTnE5Os4Qc/8wjpDzMXcpRDMes9ZJKySbiInI=;
        b=nE8qgmOAFXm+Ud60sknh92LhhiT4ndc9McaU/62bJiI7mRBZEk6nn4YBOcOumBXjke
         MUt6UCIFoLXjqbufYFxJdHUAcznjA+IdqZmUHMOYQhK5AYxfKAI2yZm+xA980s+O48G/
         /xywndHQQJyqMI1oT7Izx32SUJDqATLnnInVH7M5VOI0Rzw/Olq7/geZW1tsogAOlrkR
         UPyRlPpyn2slHHkgB4w8Xlp5KkYZSJWuKncLqQDA9g9sQ6jCFrmjI7johs12gxfRMSzQ
         Jxi+Qw/g3kSxV0FSTvwK6kv172ZMczPmhn02DXZLF2Cs6gVX8gWakzHsAh5KscZ2seX3
         b+FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739357473; x=1739962273;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kFIw2XQTnE5Os4Qc/8wjpDzMXcpRDMes9ZJKySbiInI=;
        b=a2OJa3kOOhbogHBeP7u59K3nX//3MryF0KMabQlgHBThg5nCXku2ZBbps9WTpzLom3
         ve7Wbi7HWbQTvqjUrHwMN0Q4IcmDAGsOjJyISOj4LsvqcOUbIAh41BjXqP0j+b6q/UH5
         oJCeKl7wmkT9gAfOMrmWDlNPbuEvdYrfk2HSCBolR52jjGFHmO1PYsfX/5OaQ2XZ2cD7
         z1xA740rxBbiVxB+Xv0QMATZLmySmIm4sD+zyi8R1kGTY43m8007k5LIk3GxoNow/JiR
         YlHWJLY9UbO0dA9tFWqE51KGy6/w/l+Ut18UoBBWUyGldqca1z3WoJ2CM0+mLWNVGC3I
         HdbQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYTpfb3cOYqN0pizDD2/a6vWufy1SxNeXsKu6jCBVF/2OiQlAbFzHJDGYafpgN2NzLkmwDOB1QhDZBsw8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxO3hjCHgRbgz5xMUQyAN7VhQlp4mVg+OABXytptafHPs8GaxDY
	3MSwBrHErHjvkOQQDdobX1hhRsDuV7gfhs28GaorIgUvGFsWOz7/EFOcurwGgoc=
X-Gm-Gg: ASbGncttsU1fXZ3UB8L5llMvyZJJoEwqe5U7TaRC5AGvcwDUMPai8I2I6vTVAvBQRb9
	G4mk7Lq7JNEaYsR7Ryj7uP+tgfZImfKpudJbSVeJuU4ousbDaqWb9tg+XLLBuzNDnOS32pcDVoC
	osnyoaKXwJZxLBe9Ak9VJUZ6sLV3B36fYSwW4FNCqxOPukqqEUdDraSIntl2ErPoMZADOqFmeTT
	NZLAj5GpJR4KwARK3zi0SjZwa+p74KionaS7wC0ymyGt6z8S/sI1PvUBCKVsSOF0t+hHh5Olka8
	jae/nyhVzcYMtf+Vzfhx2nEnSZe1BDBzsnGKo2a/wrDDDOS0Kja6nGJbYhSYsU4dmUDd6W0=
X-Google-Smtp-Source: AGHT+IEDzcPRrcce5UnawSDEarFr9+DzePDbU8ly6wk16sOl8kdhRUbYe8aGObQlOg8I3bS4B63NyQ==
X-Received: by 2002:a05:6512:3155:b0:545:10e1:b1c9 with SMTP id 2adb3069b0e04-545180ef774mr625448e87.20.1739357472850;
        Wed, 12 Feb 2025 02:51:12 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-545166da063sm353803e87.77.2025.02.12.02.51.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 02:51:12 -0800 (PST)
Date: Wed, 12 Feb 2025 12:51:10 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Yongxing Mou <quic_yongmou@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Kuogee Hsieh <quic_khsieh@quicinc.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] Add MST support for qcs8300 platform
Message-ID: <iwr7hcavp43u2yoif5fefd7y3q3rlfx73gxdyfotfuz5s2jalo@kzyt4kotpawh>
References: <20250212-mst_qcs8300-v1-0-38a8aa08394b@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212-mst_qcs8300-v1-0-38a8aa08394b@quicinc.com>

On Wed, Feb 12, 2025 at 03:12:23PM +0800, Yongxing Mou wrote:
> This series of patches introduces how to enable MST functionality on
> the qcs8300 platform.

> The qcs8300 platform uses dpu_8_4 hardware, which
> is the same as the sa8775p, but it only has one DPU. So it only has one
> DP0 controller, supporting 4-stream MST.

This is irrelevant, unless you want to point out something else.

> This patch only enables 
> 2-stream MST, using intf0 and intf3. The first and second patches are
> modifications to the correspond dt-bindings, third patch is the dp 
> controller driver after not reuse sm8650, fourth patch is the qcs8300
> dts modification which add the clk support for stream 1.

This is obvious. Really. Instead you must explain why QCS8300 isn't
compatible with SM8650. How many streams are supported by the SM8650?

> 
> Signed-off-by: Yongxing Mou <quic_yongmou@quicinc.com>
> ---
> This patch depends on following series:
> https://lore.kernel.org/all/20250120-mdssdt_qcs8300-v4-0-1687e7842125@quicinc.com/
> https://lore.kernel.org/all/20250114-dts_qcs8300-v3-0-d114cc5e4af9@quicinc.com/
> https://lore.kernel.org/all/20241202-dp_mst_bindings-v1-0-9a9a43b0624a@quicinc.com
> https://lore.kernel.org/all/20241205-dp_mst-v1-0-f8618d42a99a@quicinc.com/
> 

Please don't patches against series which were requested to be changed
singificantly. Don't spam mailing lists just to be able to 'FROMLIST'
them. Instead work with Abhinav to get this patchset integrated into his
next iteration of the series.

> ---
> Yongxing Mou (4):
>       dt-bindings: display/msm: Redocument the dp-controller for QCS8300
>       dt-bindings: display/msm: Add stream 1 pixel clock for QCS8300
>       drm/msm/dp: Populate the max_streams for qcs8300 mst controller
>       arm64: dts: qcom: qcs8300: Add support for stream 1 clk for DP MST
> 
>  .../devicetree/bindings/display/msm/dp-controller.yaml     |  5 +----
>  .../devicetree/bindings/display/msm/qcom,qcs8300-mdss.yaml | 14 ++++++++------
>  arch/arm64/boot/dts/qcom/qcs8300.dtsi                      | 12 ++++++++----
>  drivers/gpu/drm/msm/dp/dp_display.c                        |  8 ++++++++
>  4 files changed, 25 insertions(+), 14 deletions(-)
> ---
> base-commit: 7ba9bcc5090556c007d9a718d7176e097fe54f19
> change-id: 20250211-mst_qcs8300-4c18a5179165
> 
> Best regards,
> -- 
> Yongxing Mou <quic_yongmou@quicinc.com>
> 

-- 
With best wishes
Dmitry


Return-Path: <linux-kernel+bounces-407567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2FE39C6F58
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 13:44:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85FDFB2C66B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 12:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E29D220127D;
	Wed, 13 Nov 2024 12:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IFFeFxte"
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87827201032
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 12:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731500492; cv=none; b=Whli/1MFAlwKaI6+RWICFydVb0VeD58TkTKqeXjKZGhapXx0y3d4Tz3eqtPjq8mG+wVbp0a+ShnutJMNrsjvdM97TeN0qSeAc0kjMi4uUGCNKNqVpY7lMNlwNtybJh9ZvogZB3oSgduGq990p6VVYTh2FxekEUOpfZPt7Ts3CLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731500492; c=relaxed/simple;
	bh=Fjca1LWzFAdCd0y6iIxSu0s0Obt4f3zGnd1zEofN2SQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FLaOt2FzZ+znBpjI5KUFClFfjEMcxO4KdzdRKB+UdOXWJ+DiQisVUtFTVPUwOWGd8yaggdCxXyZzeE8KbVBJV2kJcQdaTuwvDrCAmjhqT66DHdtUEeIkZEkU+h2z5icL9ozApjDTTs4dgux/CyGZpoWGOq0VoehaGC+oIMHLzOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IFFeFxte; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e28fd8cdfb8so6533596276.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 04:21:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731500489; x=1732105289; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JsE6HZ0BDIdFm8pHUV9wjAijdgzctcE9O8piDmD3bwk=;
        b=IFFeFxte1uY32jKGhbDsyIdhtHi7tULp16Fe7422DFwk6FR4gOK6WbpC0mXh+jjcZB
         Cj1nXPLNBAngJVnV5N8mXMpgREZQqI7L3Ey9haiiM7+Ey1xMIkgLyFA7W7PdaENhOEm1
         EpODEMLFQiqW8JYty/Qti3C3a/YwlH7N9JpPjmk9KWGOOQuH0lx63OUX2oBLrKWXBEFE
         kZYn0DyviLtnhaGLziA388+iLjpbn01hpubtmm8/c41prnHwPjFWPE3xuE6PdPVMhW1H
         4zjaV7L7jyw81NQ05uqbhx95cQCiFjoR2HU9hE27EECHZesItmsctj1CL92OiV0wXwtA
         K/4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731500489; x=1732105289;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JsE6HZ0BDIdFm8pHUV9wjAijdgzctcE9O8piDmD3bwk=;
        b=W0sDHVc6/zEj6YpZw333SF4yyVweQXAfH4fU1Y2mUf/6qfvAr56I05u3kUkdVTxDnu
         0onOIRDKxp60ooGTzFrYEcB+lKSa35VD6p3rg2nTibXHkdeRvLgOHTgEY+pkn2wiRJm9
         0FwA0UCdLbHwrC6oJt1b/QR/TGDC2E82S68tKX2SIK+l7Ce45DEJvVzifBi/3IRPjHNz
         BO7iBpOYdOv5BWc+/nWT5qD++mLoa7v3EqDvC1QE2jFZFEApIpWVocIGhyjrQTbbWMU7
         ehBk85A11RZxDIA2qrsORIt8xm9vFVIs8uIuYOCwH/Y6yyip8Q3zfkym7KORRZLBcydj
         ZVew==
X-Forwarded-Encrypted: i=1; AJvYcCVjnRIHCDA6Dm9VgD47UMCuwgWCKr3nnE5HR7SEtTpnOQcBKo54LTd5kQoDXP5KGfakPibHqb20CD2HW54=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxgk7Vap5JCJr7Cj2+fbJ+4VPxHjm4PlEq70guGiFP2x7lIoFzq
	Pk1HQuaBhwPqTnGk4V6P+gbbZsa9woWeLnup5JERkekrO9Qc7u/uE2NO/GAYodSRh57yRA6bjsl
	g2JRt8tGNRy0Bc7A79K6p4R/lzYvnH7x67db9+g==
X-Google-Smtp-Source: AGHT+IHlEW9Y6a6VKxz7Rj8wBbFwf85y1XuiF8DPZGiTfkNkpU73TSXFVeGlAI184r1k/vIlZa0la+oK03iLvn2Otwg=
X-Received: by 2002:a05:6902:1101:b0:e30:d443:8490 with SMTP id
 3f1490d57ef6-e337f8c6c9bmr18265860276.40.1731500489516; Wed, 13 Nov 2024
 04:21:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241113-add-display-support-for-qcs615-platform-v2-0-2873eb6fb869@quicinc.com>
 <20241113-add-display-support-for-qcs615-platform-v2-9-2873eb6fb869@quicinc.com>
In-Reply-To: <20241113-add-display-support-for-qcs615-platform-v2-9-2873eb6fb869@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 13 Nov 2024 14:21:18 +0200
Message-ID: <CAA8EJpok20-7HXJJbcJi8YZYCU68g_DGThR_ckjBEz0e+gGBSA@mail.gmail.com>
Subject: Re: [PATCH v2 9/9] arm64: defconfig: Enable SX150X for QCS615 ride board
To: Fange Zhang <quic_fangez@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
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

On Wed, 13 Nov 2024 at 13:53, Fange Zhang <quic_fangez@quicinc.com> wrote:
>
> From: Li Liu <quic_lliu6@quicinc.com>
>
> For the QCS615 ride board, enable the SX150X to activate the ANX7625
> allowing the DSI to output to the mDP through the external bridge.
> The ANX7625 relies on the SX150X chip to perform reset and HPD.
>
> Signed-off-by: Li Liu <quic_lliu6@quicinc.com>
> Signed-off-by: Fange Zhang <quic_fangez@quicinc.com>
> ---
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index c0b8482ac6ad7498487718ba01d11b1c95e7543d..599a339a19435efbee7a5ef80c093b0e8c65f7ff 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -631,6 +631,7 @@ CONFIG_PINCTRL_SM8350=y
>  CONFIG_PINCTRL_SM8450=y
>  CONFIG_PINCTRL_SM8550=y
>  CONFIG_PINCTRL_SM8650=y
> +CONFIG_PINCTRL_SX150X=y

Your commit message doesn't describe why it needs to be disabled as a
built-in. You are trying to enable it for all defconfig users.
Also the placement of the symbol is not correct. You've added it to
the section with msm pinctrl drivers, while the chip has nothing to do
with msm.

>  CONFIG_PINCTRL_X1E80100=y
>  CONFIG_PINCTRL_QCOM_SPMI_PMIC=y
>  CONFIG_PINCTRL_LPASS_LPI=m
>
> --
> 2.34.1
>


-- 
With best wishes
Dmitry


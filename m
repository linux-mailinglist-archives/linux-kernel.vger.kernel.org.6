Return-Path: <linux-kernel+bounces-518228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D800AA38BCA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 19:59:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0B1E3B45F6
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 18:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB716235C0F;
	Mon, 17 Feb 2025 18:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qa0ZFdQi"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8323F235C03
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 18:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739818710; cv=none; b=dFh0i8MY6wzXM+mDP+jx41iuCdL/XLwPgg/zJhjeEnwLQ+7xFYmT1c1BGn9C2UoQXY5Men+aXwRALPyaC/5HA1ZtHXXB0hoqxmB4dZ1vXsvUxKwWV+xzqklZjDLrHDnP3mA50gGF2344Blnb06jRN6dXitTpl1tE7vI/5mjOUlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739818710; c=relaxed/simple;
	bh=i9y/eEy23jfhgPUBAgQy5vBOmFfjjgXQoJXn7Jktotk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KuJUGeOob5mM19R5Lcc+YT98IoUIinw4kBTqpaJYDHKaY8xIDG5Oa5dAfw9z2TB7P+T15lK1Rgoir7fDkskE9KAR61JlDd+9VDLbzuIUcRgYSkY8J6F9o+AC1XmklsuPfyePVHkCF0rnE4GYxHvIE6x16Y2OwO6D6ll9Qu2/GFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qa0ZFdQi; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5461cb12e39so1608215e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 10:58:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739818707; x=1740423507; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mfEQeSw7ZYdARp3yhUKPkDoI2uTibzTnfRpNUooOXAI=;
        b=qa0ZFdQi8GXJSHX2uTfkFOZZXXjIfrEhaJNm2GdAg0cCH/XZrccK5mkxsMkf2wwuJJ
         SbePkMfOy0p8RuZ0wWOR9Ghu06UAciI/ELvwDAPqaG2Ln/8r33vNg+mi1hVOpEl5aWFA
         x/rGjMXiq5O9OsBwLIJkyEV6FpNrEwGX/QwQfz+a5IdIPxUlmRa6sG/kjXKHimeFnrCk
         zMdAD4c3dFWEAHSphAj6cU/2i1rv/vtHVT7MYEn9W+HYLESrVaQT8wGsPj/It4WA/fBT
         cV7iK+ZIAUj+GifQbFoxQmPt1gSL/O+ZTzRfAd7x21qHlpsIdH9KDWFcA+RPWSO0WiDQ
         Yk2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739818707; x=1740423507;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mfEQeSw7ZYdARp3yhUKPkDoI2uTibzTnfRpNUooOXAI=;
        b=NuSf3ZDXvJRlQ2LfC9q0xiE2ZIufLROM4JbWBqVmvK4JuPdgHx6a5OHt2JlFAUyIHp
         uEZIBeW+E5fs8si2PqYxQ2/Za3ONzVZpN753LhU+7MS0WhQ3ArGYVJvT7udZYKfmUzs0
         0opJfj6DojwkBzlwqPXihM0lNeGSh38j+jzLppc/nVUMZJbTsyWouqfQaWyHRrIFrTG8
         W1GpiKQpyvfTdWqOvjHrIwtYrMm//pHyD8jhR+UbeTv+XBLxHJ6QrakWymc5ncS/odZv
         KVE8Q7/Z9pb5Cb6w0gOddtVx+EPXzto3Km0DDmNde+EDSTZsiErtk9P1aJRzgICo6UV6
         t81g==
X-Forwarded-Encrypted: i=1; AJvYcCX2xLPnNMu5+6epm4zZdplTTm8ZQhm25miIuLTasEA4WTleJfET+fT1BXVIrVpNzHjxysTNrIuM9MpdhR4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2Wf5zUIhTP+sj8oVQRTIK2vzZi/LTw3ioO1VA1rLGtOtliMYM
	IaeUTLNvR0CrF+8YpwdSEbkd84MTvlQOK4l+k+17lUXz1mAbN3nK9ig26RFIGUs=
X-Gm-Gg: ASbGncvX26peagrngK+7ZFEZuAceXLFBx3yCsmGc4fPjF22YI+W4mLyTRfu9d4IJHRk
	i8Y80Pzo4Z5lRb3pgZvO77S+4y5YydNqhXIbjLh2mhHFbOBbOt/Ob6Sx8CBSEezAQEVEacTvLXa
	v1/H3aj9LNR4Z7GWpg2xSjV4G1Mub9YAPKNabTFZrQdfZs7jpPzjfrNnxq0KGfbqB2ILN+gjumN
	+N/93XiLtUw8Zsljpn/cjq9b+a6bxJO17UDt1mw/KWnChvI1sKN8aoaAbVkK4CN2KUrTfkStS+C
	6qgw/FxGbzguwr4T3xHJfM/JKphoEdVfZtWyIiYNXEbT/rRBveSNpL++B65EcQ/dgz8oDKg=
X-Google-Smtp-Source: AGHT+IEeMZ8fqELxvhpQNGcI5FA5HN3p7pDhUbzSFXQMFatRwo9m4DM5TDLR93eSFY/NJzp3zGXAHg==
X-Received: by 2002:a05:6512:ba6:b0:545:2c6a:ff6 with SMTP id 2adb3069b0e04-5452fe450c9mr4006392e87.16.1739818706708;
        Mon, 17 Feb 2025 10:58:26 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5452f9aac11sm1131324e87.231.2025.02.17.10.58.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 10:58:25 -0800 (PST)
Date: Mon, 17 Feb 2025 20:58:23 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Clark <robdclark@gmail.com>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Krishna Manikandan <quic_mkrishn@quicinc.com>, 
	Jonathan Marek <jonathan@marek.ca>, Kuogee Hsieh <quic_khsieh@quicinc.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Srini Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v2 05/16] dt-bindings: display/msm: dp-controller: Add
 SM8750
Message-ID: <aqpuik4zitdfuk4pahn4wyzxdvxldy4dcqjs3mhr6fqtxpoxhf@ssfzzbfce2nu>
References: <20250217-b4-sm8750-display-v2-0-d201dcdda6a4@linaro.org>
 <20250217-b4-sm8750-display-v2-5-d201dcdda6a4@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250217-b4-sm8750-display-v2-5-d201dcdda6a4@linaro.org>

On Mon, Feb 17, 2025 at 05:41:26PM +0100, Krzysztof Kozlowski wrote:
> Add DisplayPort controller for Qualcomm SM8750 SoC which so far looks
> fully compatible with earlier SM8650 variant.

As that became a question for QCS8300, does SM8750 also support exactly
two MST streams?

> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/display/msm/dp-controller.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
> index e00b88332f2fed2fc33f6d72c5cc3d827cd7594e..a4bf9e07a28355c0391d1757fab16ebe5ff14a44 100644
> --- a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
> +++ b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
> @@ -37,6 +37,10 @@ properties:
>                - qcom,sm8450-dp
>                - qcom,sm8550-dp
>            - const: qcom,sm8350-dp
> +      - items:
> +          - enum:
> +              - qcom,sm8750-dp
> +          - const: qcom,sm8650-dp
>  
>    reg:
>      minItems: 4
> 
> -- 
> 2.43.0
> 

-- 
With best wishes
Dmitry


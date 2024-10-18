Return-Path: <linux-kernel+bounces-371551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CC2A9A3CA2
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 13:04:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19266B29D92
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 11:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F6C62038BE;
	Fri, 18 Oct 2024 11:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TebpSgHE"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A01420126E
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 10:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729249200; cv=none; b=GshwHMOlvzZu/FnHj3G0ZUdV7/NX0tvwpPiz4X6v2DL4BAbj4DMuS8173TTrSfWik/zfnSMPo+Hs2l5vNDd0D5Xsy9ld+sSHr3dh3+lpGIWF50DRL2zWVOM5Uuu1q28SxsX/s8Op/WU5lGTod7S1jrS1nSojWoShC3MYlAwpmfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729249200; c=relaxed/simple;
	bh=Wnk4mh2j81RCLrthBqAg8IdLJJy2b3UuoDWmwxzcnZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n8K5GrSq7vHTe3Ipix2SGgz/pegYNGfF2s+5dJupubRYpNMQw4RaQtNqe9fQqokOniJp5MFt8Mu6CsP5abFV+rY/wVcyq8nuQ1q4fxL4gSaPbn/Uk2I32CxZQoypYWWz2M9VsNnS0MmEVFAM+4HRHgNsiEUTJLXmvclspMjSK38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TebpSgHE; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-539fe02c386so3105301e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 03:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729249197; x=1729853997; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BDn3B2qj/hHbMDyr6HsfzwkGACEwdcb5vmYA2V4zZBg=;
        b=TebpSgHEqPHxss9fOjEkPe5CW8Hp7AbTsgieWqlG8u6aKMShYpj/nn+chahaMe1Iw8
         gq1GzF7Hmo7f+GF+qud2PpIlGSIswaKCm5IepAeM1IugpoaqsmgyZxuwJ7lOZXSh0KcP
         LnZVhu0Qvx1YhLzP4TOXjQTLAXjK6V5PAwh+1Q7qTd6RyffLxJUB/z6H92ZZxvpiVCV0
         Co3xYhzRBILsY7x/oUk6IxrQjp1qDk0jLMw8NHv9LXMKLDuAxRzg+MGcCQv7d41X/c3i
         Nt9g2n3OC7lmLwGhWL+zvGIJn0C9vbqAgIgs1PL5jIcmhKQIjfaEVZ/KGOxR0WO4wKrV
         P/iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729249197; x=1729853997;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BDn3B2qj/hHbMDyr6HsfzwkGACEwdcb5vmYA2V4zZBg=;
        b=f6CMn9cLGv1UXG3p+2H1F6wZOgAnRZy2R+FYgGU0AIYrIRO75eyOiBoToJT0tTOaQs
         iZbvvkF3fh1q6dLt8GVDW6BIIt6jA28pfyB5jE5ZksEyc8zVt++rnYCWSFOjTbFu2iXL
         nQwYceWMSvd2+bvFuFQn2RWQGNwd9saY8Vm/72cciKmHcxHH/BcjUVapcaeoXmXEMEWZ
         kL312Tgv2fGlwk9WiktdOm2wejMv292n85oYRDlsOHu/f23NMGn1eY/SdHTFIRy+kmWa
         oWIrDUKxMJjUPEIdyeS3poyzc8ZJV9AHyRH9r5S6Fupzop5v9rbg0hizK8ztpKAc8aEf
         4VfQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAQsccHE/E8Ra3wSCzQ0MaYoNnXwOwhIQhKb9JXMulE4Xt3e0SX/Pthr+NbimJieouZih7+GmatJtV1QA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVvWPLntBpTVsQth/behNjPHCcLF2zcCKTvis6yX2tmrYYO/NG
	3y8HAUyFmOghkYkSqZ4M+q2wygILc0fxnPKXR6qd3QU/SWgpoiOj4AmwCJm9Xb0=
X-Google-Smtp-Source: AGHT+IFBl+2v8OAQ2fIrh0HeP3N6htiMXETE/IwmKI/CVl5P5tYrY6ccHdNQQtQ0wLclVVrPfSoqVg==
X-Received: by 2002:a05:6512:3094:b0:539:f539:73b2 with SMTP id 2adb3069b0e04-53a15845c77mr582804e87.12.1729249196684;
        Fri, 18 Oct 2024 03:59:56 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a151f0d71sm185759e87.166.2024.10.18.03.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 03:59:55 -0700 (PDT)
Date: Fri, 18 Oct 2024 13:59:52 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Mahadevan <quic_mahap@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kalyan Thota <quic_kalyant@quicinc.com>, Jayaprakash Madisetty <quic_jmadiset@quicinc.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v4 1/5] dt-bindings: display/msm: Document MDSS on SA8775P
Message-ID: <ugkiv4m3etpydvosjkyzwr4qus74xnwccow7xrpvr77kzcx6bv@odlz7dzldqc5>
References: <20241009-patchv3_1-v4-0-cd683a9ca554@quicinc.com>
 <20241009-patchv3_1-v4-1-cd683a9ca554@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009-patchv3_1-v4-1-cd683a9ca554@quicinc.com>

On Wed, Oct 09, 2024 at 08:02:01PM +0530, Mahadevan wrote:
> Document the MDSS hardware found on the Qualcomm SA8775P platform.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Mahadevan <quic_mahap@quicinc.com>
> ---
>  .../bindings/display/msm/qcom,sa8775p-mdss.yaml    | 241 +++++++++++++++++++++
>  1 file changed, 241 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sa8775p-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sa8775p-mdss.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..37c04ae6876f873c2cddc51b5160b1f54e2b5118
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/msm/qcom,sa8775p-mdss.yaml

[...]

> +
> +        display-controller@ae01000 {
> +            compatible = "qcom,sa8775p-dpu";
> +            reg = <0x0ae01000 0x8f000>,
> +                  <0x0aeb0000 0x2008>;
> +            reg-names = "mdp", "vbif";
> +
> +            clocks = <&gcc GCC_DISP_HF_AXI_CLK>,
> +                     <&dispcc_ahb_clk>,
> +                     <&dispcc_mdp_lut_clk>,
> +                     <&dispcc_mdp_clk>,
> +                     <&dispcc_mdp_vsync_clk>;
> +            clock-names = "bus",
> +                          "iface",
> +                          "lut",
> +                          "core",
> +                          "vsync";
> +

It's been more than a week since Rob reported issues with the bindings.
Any updates? Obviously I can not pick up patches with binding errors.

> +            assigned-clocks = <&dispcc_mdp_vsync_clk>;
> +            assigned-clock-rates = <19200000>;
> +
> +            operating-points-v2 = <&mdss0_mdp_opp_table>;
> +            power-domains = <&rpmhpd RPMHPD_MMCX>;
> +
> +            interrupt-parent = <&mdss0>;
> +            interrupts = <0>;
> +

-- 
With best wishes
Dmitry


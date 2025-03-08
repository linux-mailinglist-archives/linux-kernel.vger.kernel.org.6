Return-Path: <linux-kernel+bounces-552326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AA72A5786C
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 06:09:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CC1B3B6138
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 05:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DFC4187FE4;
	Sat,  8 Mar 2025 05:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m0gXOMsR"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467FC17A313
	for <linux-kernel@vger.kernel.org>; Sat,  8 Mar 2025 05:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741410559; cv=none; b=XDPr18t3rW3VwfU4eRUSRXiQyCtnhelZzcuT/jGuHm8urdUBmEa9lLPSGctxlDCMIUnhRs1Fd8bHKRgKUE7dmM5fsriLxORxJaSvakkjVmvXaPXYFxyAr31pVj1ySj0PiIhBIsgqFlgcX1S2uPKvcuGzzQPyAnj2nHCHw9pqcXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741410559; c=relaxed/simple;
	bh=ptCcDRtuDzbTjjE4m2PHHQvXnqToeWz1+GhetT24juk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rPknMX1s/w0edSvlo8qAm+Zt9yyFejPWV8wi0BSSu6WxS4DKHRni03+/Fdy2uh6DgL4VPXc0ucyVGHm+Ds+y7QstCCifm0hj9zzMA3dRuEG9jOWRhU6+gVyfMQy6lTQ7SeFZlpTfYVLlzjkSx89jY0uofEJlrXoKO4ckbNrN3vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=m0gXOMsR; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-307c13298eeso30219711fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 21:09:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741410555; x=1742015355; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ulAMfJbRFBT/fSAG0Qg9z+1DBNf6VyZHT1tEXJwkloQ=;
        b=m0gXOMsRmOE6nqheCVUiEbBGxsp0INCWwAHDxfsg83DlwZwv31TjLObGWlHKixuwV8
         i+GCYhDWKShRenWQnT1rW87zezRFlgNDDpdTWYVBwb0sWj11gzr/p07UGHthsWw6CjCv
         fgG9b6KYhWh0WWcc/UnhKnebDJNmjN60671FKjPojGpgepYQ3ckJlG5F6jGFFhkXXS8p
         VOZiV2hUNtLXFT0m8foKbKQX9cFjSF3xVPsIMBHk69edvBG9q0TqaGxyoOvS7z/74T3L
         ztQ2+oJPF/8WE+xcKCY1kQA9/lCuYNyAFXwHzId8dkTbHxd9GKzfmIJcQhRdW3XOZGgO
         iFnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741410555; x=1742015355;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ulAMfJbRFBT/fSAG0Qg9z+1DBNf6VyZHT1tEXJwkloQ=;
        b=wcu5z/Iw+nIzIGclbXCFkfNbFFMZvLjR+YVBV9ThFyuzQCfMIM7h4CbnzYj4prg2/z
         3cN8saNetbnT26u5WHR57XlR9Ye/IkxezHEYE2AWhjCeF6Qbw1c+6IPE76SZkd3vDij9
         MIudLJdn46MJhxsxSvv0csu2Ba2x4+PAU/jGFv6rylfV9j1bPkg4OEUGgIxk7fPSCXzg
         ilx6jyLWhxdxpjeTtco1toWLNXMITEVbA5mA40gneMjzv+yxhYO/68fQsDhw6LKwrAED
         oLN1RRL+yTHGAiNLfrdGxMFdjkjdmrJhYUM2sM4iOwwT28VxoWyMQTFag9Bs4xjvITai
         q5Kw==
X-Forwarded-Encrypted: i=1; AJvYcCWYr6zIpiqh8Ky/+ANNJnZTVVKhjJO+50iKw0dNMg20AnGSQQyesWpT8Ty4D8UlcvUKVVBo0pzion7ZAQ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEwa3m9qCUaUVnYuKVSmqQjCOdB1mpqhB9kpJnEwNts/dF3vso
	tBgQz1iPh8+SCuDFcGKbRI+WHcqk/Ha1y3XsMgKfzdCJExj4lh4/ocCEXArHLAc=
X-Gm-Gg: ASbGncvvFM2KROjh3Us+u03BvVxuv7L1gKupfE9BFJ+p3NqNQpxwG2RArT/6Gw6cFiZ
	DT1ZJix+1BNl9MiBByBngfXvF/tKyAhMUPCVVNEhjvZzmgyHDkHEqJOra+wztlaQUGuQLAqEXLQ
	3l5jHp1GlAJhQbtZRWGBF0ulwqPidAuC3q3E/sugsXrZo7ZalZCP0mkYDqnk6LOwHlhuGr1RvEF
	WdVva4Ie8oHeQdu9xJlf2s9DzECfm/reLSe89t3Ce6eV72BuinSnvs1A/Wz0ULCPWv2bKBNZ+7Y
	RzjMp0A45XqZhCGgq3Ju0d/8E2MIVhGAwGqot51MqepqmNLbwtsXOUwRBh18zFjhJ5JoEaGtcTs
	uffohs64ZUaa2QXFPXXDKsNzR
X-Google-Smtp-Source: AGHT+IF7bjBB5aMjSIOWPIZXx3se8ZXwg6KEPXnQgNtkefZ48n8buFCzC0ExNuYMF9We4+jwIP9GuA==
X-Received: by 2002:a2e:be91:0:b0:30b:c608:22bf with SMTP id 38308e7fff4ca-30bfe429ce8mr7170571fa.9.1741410555213;
        Fri, 07 Mar 2025 21:09:15 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30be98d0bf3sm7872791fa.8.2025.03.07.21.09.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 21:09:13 -0800 (PST)
Date: Sat, 8 Mar 2025 07:09:11 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Dmitry Baryshkov <lumag@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, Sean Paul <sean@poorly.run>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Conor Dooley <conor+dt@kernel.org>, 
	Marijn Suijten <marijn.suijten@somainline.org>, dri-devel@lists.freedesktop.org, 
	David Airlie <airlied@gmail.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, devicetree@vger.kernel.org, 
	Neil Armstrong <neil.armstrong@linaro.org>, Rob Clark <robdclark@gmail.com>, 
	Kuogee Hsieh <quic_khsieh@quicinc.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Simona Vetter <simona@ffwll.ch>, freedreno@lists.freedesktop.org, 
	Bjorn Andersson <andersson@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Joerg Roedel <joro@8bytes.org>, Jonathan Marek <jonathan@marek.ca>, 
	Maxime Ripard <mripard@kernel.org>, iommu@lists.linux.dev, 
	Krishna Manikandan <quic_mkrishn@quicinc.com>, linux-arm-kernel@lists.infradead.org, 
	Will Deacon <will@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>
Subject: Re: [PATCH 05/10] dt-bindings: display/msm: Add Qualcomm SAR2130P
Message-ID: <nddxntwmiyurqew75gc6yoj2dcinhjqu36cdujhruqyrz62ry5@4e2y76ghmo4h>
References: <20250308-sar2130p-display-v1-0-1d4c30f43822@linaro.org>
 <20250308-sar2130p-display-v1-5-1d4c30f43822@linaro.org>
 <174140525677.1770282.3232695979994091275.robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <174140525677.1770282.3232695979994091275.robh@kernel.org>

On Fri, Mar 07, 2025 at 09:40:56PM -0600, Rob Herring (Arm) wrote:
> 
> On Sat, 08 Mar 2025 03:42:23 +0200, Dmitry Baryshkov wrote:
> > From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > 
> > Describe the Mobile Display SubSystem (MDSS) device present on the
> > Qualcomm SAR2130P platform. It looks pretty close to SM8550 on the
> > system level. SAR2130P features two DSI hosts and single DisplayPort
> > controller.
> > 
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > ---
> >  .../bindings/display/msm/qcom,sar2130p-mdss.yaml   | 445 +++++++++++++++++++++
> >  1 file changed, 445 insertions(+)
> > 
> 
> My bot found errors running 'make dt_binding_check' on your patch:
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sar2130p-mdss.example.dtb: dsi@ae94000: compatible: 'oneOf' conditional failed, one must be fixed:
> 	['qcom,sar2130p-dsi-ctrl', 'qcom,mdss-dsi-ctrl'] is too long
> 	'qcom,sar2130p-dsi-ctrl' is not one of ['qcom,apq8064-dsi-ctrl', 'qcom,msm8226-dsi-ctrl', 'qcom,msm8916-dsi-ctrl', 'qcom,msm8953-dsi-ctrl', 'qcom,msm8974-dsi-ctrl', 'qcom,msm8976-dsi-ctrl', 'qcom,msm8996-dsi-ctrl', 'qcom,msm8998-dsi-ctrl', 'qcom,qcm2290-dsi-ctrl', 'qcom,sc7180-dsi-ctrl', 'qcom,sc7280-dsi-ctrl', 'qcom,sdm660-dsi-ctrl', 'qcom,sdm670-dsi-ctrl', 'qcom,sdm845-dsi-ctrl', 'qcom,sm6115-dsi-ctrl', 'qcom,sm6125-dsi-ctrl', 'qcom,sm6150-dsi-ctrl', 'qcom,sm6350-dsi-ctrl', 'qcom,sm6375-dsi-ctrl', 'qcom,sm7150-dsi-ctrl', 'qcom,sm8150-dsi-ctrl', 'qcom,sm8250-dsi-ctrl', 'qcom,sm8350-dsi-ctrl', 'qcom,sm8450-dsi-ctrl', 'qcom,sm8550-dsi-ctrl', 'qcom,sm8650-dsi-ctrl']
> 	'qcom,sar2130p-dsi-ctrl' is not one of ['qcom,dsi-ctrl-6g-qcm2290', 'qcom,mdss-dsi-ctrl']
> 	from schema $id: http://devicetree.org/schemas/display/msm/dsi-controller-main.yaml#

It looks like the patch 2 could not be applied and was skipped. Is the
bot parsing the dependencies from the cover letter?

> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sar2130p-mdss.example.dtb: dsi@ae94000: Unevaluated properties are not allowed ('compatible' was unexpected)
> 	from schema $id: http://devicetree.org/schemas/display/msm/dsi-controller-main.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sar2130p-mdss.example.dtb: dsi@ae96000: compatible: 'oneOf' conditional failed, one must be fixed:
> 	['qcom,sar2130p-dsi-ctrl', 'qcom,mdss-dsi-ctrl'] is too long
> 	'qcom,sar2130p-dsi-ctrl' is not one of ['qcom,apq8064-dsi-ctrl', 'qcom,msm8226-dsi-ctrl', 'qcom,msm8916-dsi-ctrl', 'qcom,msm8953-dsi-ctrl', 'qcom,msm8974-dsi-ctrl', 'qcom,msm8976-dsi-ctrl', 'qcom,msm8996-dsi-ctrl', 'qcom,msm8998-dsi-ctrl', 'qcom,qcm2290-dsi-ctrl', 'qcom,sc7180-dsi-ctrl', 'qcom,sc7280-dsi-ctrl', 'qcom,sdm660-dsi-ctrl', 'qcom,sdm670-dsi-ctrl', 'qcom,sdm845-dsi-ctrl', 'qcom,sm6115-dsi-ctrl', 'qcom,sm6125-dsi-ctrl', 'qcom,sm6150-dsi-ctrl', 'qcom,sm6350-dsi-ctrl', 'qcom,sm6375-dsi-ctrl', 'qcom,sm7150-dsi-ctrl', 'qcom,sm8150-dsi-ctrl', 'qcom,sm8250-dsi-ctrl', 'qcom,sm8350-dsi-ctrl', 'qcom,sm8450-dsi-ctrl', 'qcom,sm8550-dsi-ctrl', 'qcom,sm8650-dsi-ctrl']
> 	'qcom,sar2130p-dsi-ctrl' is not one of ['qcom,dsi-ctrl-6g-qcm2290', 'qcom,mdss-dsi-ctrl']
> 	from schema $id: http://devicetree.org/schemas/display/msm/dsi-controller-main.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sar2130p-mdss.example.dtb: dsi@ae96000: Unevaluated properties are not allowed ('compatible' was unexpected)
> 	from schema $id: http://devicetree.org/schemas/display/msm/dsi-controller-main.yaml#
> 
> doc reference errors (make refcheckdocs):
> 
> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250308-sar2130p-display-v1-5-1d4c30f43822@linaro.org
> 
> The base for the series is generally the latest rc1. A different dependency
> should be noted in *this* patch.
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
> 
> pip3 install dtschema --upgrade
> 
> Please check and re-submit after running the above command yourself. Note
> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> your schema. However, it must be unset to test all examples with your schema.
> 

-- 
With best wishes
Dmitry


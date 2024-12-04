Return-Path: <linux-kernel+bounces-431043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A4AF69E3948
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 12:53:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E77EB39CCE
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 11:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D2911B395B;
	Wed,  4 Dec 2024 11:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Eo6o3eCW"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85081B218A
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 11:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733310601; cv=none; b=BUi0rgtzgWN7SpCvRrP9722ukU2wL+HKvHW3+BVX2Fcgfhk/hgTmipoh1yhXwXrbTgqHR1usJm1FkmwRcCrS/pFtmzvcKgc0C3sYkEhs4ot8ubqQLnY77xSqoWTEIs4ZiYzEVipVnaPvOW6NrdnRe9XNTb8n8AOHNdLsJbDuuYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733310601; c=relaxed/simple;
	bh=5na65Rr2ZBuv2qk9oz23hGN0UByp9n3wkKc0ZvHdZTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ficz1YcuJPTncXLrLPUO+218dGhFGNo/EdHHI9gmKn1Q/7bAGUzN71/LAogj9/dA/hoSWTMT2VxzTvfioX7lmTajvV6Qa5ZgQCIeKMr5862r8O7tnWeY9EacSoUCh1rV0Hi9fWXgWoirOTIm9E4cffYByZAWYRSMaoGXIx0ZUuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Eo6o3eCW; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2ffced84ba8so64389901fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 03:09:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733310598; x=1733915398; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qmvDv+aJXodq+mhX0D5y6kJ1JtvDvnKdqZyOWQy8lzc=;
        b=Eo6o3eCW4ss9k45ks2jdxeTq/yyrgFLRsUpH0CxfgTn0CYp0NS+XRrdQPRob+5QZBS
         A3WtVWCmIOFxmuaOoF0gKwggYUgJbdulA//PTHcr7Nn1TOZ7yby0uezNgZ4asCaJcqn9
         H8C8htoimzgedp6Tc1MlelJSnxH9UuTFhJ6Nz+k92axq4CPasAWQiDvtZ+M9NfgYV4v1
         IhX7+ehGeVeeMxS0bolxRIFowGjgRxj4sIBpIHgydcgTv6ahkyDCKLNL7Nwlbf9DeIfV
         cLeMHUcB7AugqdAwWvq3nvjj6Xs/BrHmszpD+zfOe/3STyk1GmAKVJp/XYRLHKrcuXqU
         HdfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733310598; x=1733915398;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qmvDv+aJXodq+mhX0D5y6kJ1JtvDvnKdqZyOWQy8lzc=;
        b=ghgN8Naq4idk9wAWw5XNaIhzuZV9JL7diJGANBjPLHCVaOp85Eme7X/DrYwBETI+Mw
         OjOrLVT+0KPWLK92QU5euZriO+y7qPzLSa15+p8Wrhtq+LzM2tgVbiXmlgkhJgGltSYh
         EhKWLUGTIQs6ifoBBK9NO614Azxfep7f15MzxFA7T9anqTkyGciJpcLTlQrgKYAKEipZ
         kVtZsYrS62dRpQexb0ykqslixPK6Fn8nz44hbva1NKIPlq73Oa4ALaTfQABRO1kx2kgW
         /d4dfnveCeHSimwMIql/WgAoYF8Kzyn1x4W1ZaBN4DF2pV0Bmyl0d7leDwIbS2XZ1Ewd
         KzNQ==
X-Forwarded-Encrypted: i=1; AJvYcCXKIyA+qyRfTSVBV1/RlQX/zqRbKCPXMkH1N6Bqp4B9To4DXWvSjBfJpGdAmbIpIzDVb8chVZcVoxUY+wg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxOil4jQEAsqAUsA1cX5Au5ESjX17FlImXCWBaiOmQTOECuFn4
	XXgSx5nu+3JQKYK0P7J47Lax9Jjr3fnligMeb7Wp+a4LQbn6KSv0XOp17f2P/ek=
X-Gm-Gg: ASbGncsWHJGcImfTQzATNQkfLbgoJBF2skU3qZdGCsD+Va4niunZXRBSShuWRwCWFh6
	E1T1cCjh1i7Wzn205hQv6LdyFTgEyQ52l1TDzQN0W3emGRwI9EIAwSJy6FvAc7A/1kMcd7zpEmr
	Ls0LqINw6cEBFlDrrMKEvQnMA85lzK65vg11Woysyg6Nlfvbs9hcrSeY7BGMLzefBsL4D1ugib1
	/yBzlR6ECFmo/RS8/mJfJAq91UgQISYigOC0vVZVX3PdNSb5waLIjB1+o/RYP/wIqw1d3Y9X7Ss
	JnQ9VENk6pGwFeqjikLAmKD6BfZg0A==
X-Google-Smtp-Source: AGHT+IFyqI3egCOEc9OzhfUKK2S/yE8XPBtr9AUCyqUOlyCRKeSwjfIHLpWDvtQ93zwWyBHTRLlv9g==
X-Received: by 2002:a05:651c:b1f:b0:2ff:d81f:2d34 with SMTP id 38308e7fff4ca-30009c0de15mr41820741fa.8.1733310597934;
        Wed, 04 Dec 2024 03:09:57 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ffdfca12b8sm19252051fa.99.2024.12.04.03.09.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 03:09:56 -0800 (PST)
Date: Wed, 4 Dec 2024 13:09:54 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Rob Clark <robdclark@gmail.com>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Robert Foss <rfoss@kernel.org>, linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: display: msm: sm8350-mdss: document the
 third interconnect path
Message-ID: <e2ldpjkymkqz7twlhfthba3datrdunacay23znikdregd5p5mb@vwzpwhushgmw>
References: <20241204-topic-misc-sm8350-mdss-bindings-fix-v1-1-aa492a306bdb@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241204-topic-misc-sm8350-mdss-bindings-fix-v1-1-aa492a306bdb@linaro.org>

On Wed, Dec 04, 2024 at 11:36:37AM +0100, Neil Armstrong wrote:
> Document the missing third "cpu-cfg" interconnect path for the MDSS hardware
> found on the Qualcomm SM8350 platform.
> 
> This fixes:
> display-subsystem@ae00000: interconnects: [[121, 7, 0, 77, 1, 0], [121, 8, 0, 77, 1, 0], [78, 2, 3, 79, 16, 3]] is too long
> 	from schema $id: http://devicetree.org/schemas/display/msm/qcom,sm8350-mdss.yaml#
> display-subsystem@ae00000: interconnect-names: ['mdp0-mem', 'mdp1-mem', 'cpu-cfg'] is too long
> 	from schema $id: http://devicetree.org/schemas/display/msm/qcom,sm8350-mdss.yaml#
> 
> Fixes: 430e11f42bff ("dt-bindings: display: msm: Add qcom, sm8350-mdss binding")
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  Documentation/devicetree/bindings/display/msm/qcom,sm8350-mdss.yaml | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry


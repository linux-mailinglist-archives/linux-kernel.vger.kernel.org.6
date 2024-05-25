Return-Path: <linux-kernel+bounces-189524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D6888CF136
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 22:11:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92FC9B20F19
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 20:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DC5A128818;
	Sat, 25 May 2024 20:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k+v8kcaL"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF5C127B70
	for <linux-kernel@vger.kernel.org>; Sat, 25 May 2024 20:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716667872; cv=none; b=Cey6OXJsTwMAWZAZOX1a6yaurn7iZdEMJ18tWSprSHB9Qk46wj62jMbA6qoHPotbZQTZG0blgWR11B3QULzsXPaK++iYo5+m2OwW431wXOqa7bTdJ1uLUtmlpB6arBm1iw2Ouq9BtJLH0hZHYAoczlshuYg4W9pcs7cX6nEWDWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716667872; c=relaxed/simple;
	bh=dQI/5SlCCSGM8/NujvD3m7waqzbqicwkfZxpKUg2ZCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uu0VBycXlPCj13m7tqrd7BKULRW7c5/F4YmvffS5nnuZqWJgrqeBkIIljUG5G6XOIPbS1eFP/bcWgZzrlcm4ELiZQO4FMST1zbPVe3IRoYqV4eZQibfrnZLzSFUQDRoKvQZYVQ++Iv1kemd3vljxgMplGLWZB3mqwfqz9XSOL04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=k+v8kcaL; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2e95a883101so24311071fa.3
        for <linux-kernel@vger.kernel.org>; Sat, 25 May 2024 13:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716667868; x=1717272668; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yaoDKdjFI3h12KWVoOCk4ZnWaN/cN1Wp9VMoWd3wrgM=;
        b=k+v8kcaLAo13lnMqfrRnf7vaHJUaoc69rOUO64StiFMbn7FgJD09d7LN/QXUIAElWA
         AZ+P+ZUPo/4qEhX2lcFRt/sbGkg6miL2yO1NHb29ZWMGGOpDKNrym/WERMHaYjyWH4Hs
         EOYrwsCFodMs5PO9/6EYadF10hFMrywf5YyZ6+tMUuyIwUWeiEGGo2Qu7NS3jVYR76TX
         bs7T53YhU4esn4z9AWbaLzLBb9co+/Qvl5+gkuOFRUODFQ6w1SI5ryDhpvlBpkH3YDNW
         bxOa22qerJpF3RU4J0fYElWYWZYrJPIax7d8EwsOiVn/usq9reRS5dFit+7MSeVWcp81
         NYmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716667868; x=1717272668;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yaoDKdjFI3h12KWVoOCk4ZnWaN/cN1Wp9VMoWd3wrgM=;
        b=PmQ0IcgbTo0Va3M1kgqPDHejRCbAb+mWZ/xaXr8rr8RBmbQwIjiRJf/rX9VsSs5p3x
         MBh72PR8XVL3U6ZwLbB4FgiJbcRtACwjsL5HYYOggugLcJ9Bet3NFwVzL3Od+KcdOIz4
         PIzzUC069ez9oSWtxbgOAgw+1HdZmc9MUAla4u9dqos/xvAOFHNd9eqnwDQxe+PTOcuz
         0oazfRgep2+deQS4BDjFnomexB844koXiuG8GcE5lFZrZQXK2iEaINXHuXGMbExChnKn
         nhhM4WFjJFNF4IdZlqiZfOQacNIzuPLR2pSInMy/0XJkEcXtoR0gnFvrdBK2nJQ64WqF
         kjAw==
X-Forwarded-Encrypted: i=1; AJvYcCVoYBOcwbprtoy6Hv14703UMz/uH4c8XWBG3RyswGIxxhRG+OTHwESzUmmrUnhXDj0h70ABz1sfb/pjDZFWSbneRG44GaXT02CYJLy1
X-Gm-Message-State: AOJu0YxGOuskIeVEne8Fr1PVT2V7s4GWTjbypygko6HfS3PBXSrgiBMc
	ijaF4M5Ti+a9VgSXLJTvrMUOSzlriEVfi9eFEH+Y0eBn0EOxI44eN9NwLp48WJc=
X-Google-Smtp-Source: AGHT+IHeXsRN5GYKWEn/GYdf0fZpg3A6I3Q1YApzT1j4NmJTvIFz1B63NRRCeikpUyZExi/Ir/p/5Q==
X-Received: by 2002:a2e:b60f:0:b0:2e6:fec1:dd75 with SMTP id 38308e7fff4ca-2e95b07038fmr40415881fa.8.1716667867949;
        Sat, 25 May 2024 13:11:07 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2e95bcf47a4sm8779641fa.57.2024.05.25.13.11.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 May 2024 13:11:07 -0700 (PDT)
Date: Sat, 25 May 2024 23:11:06 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, Bjorn Andersson <quic_bjorande@quicinc.com>
Subject: Re: [PATCH 2/2] arm64: dts: qcom: sc8180x: Correct cpufreq compatible
Message-ID: <sjmrxhb6e73yydvb2w2tnb5crgulyajjxht2zfxozfflrexfam@h5yelxej2hvu>
References: <20240525-sc8180x-cpufreq-compatible-v1-0-febf0f17909c@quicinc.com>
 <20240525-sc8180x-cpufreq-compatible-v1-2-febf0f17909c@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240525-sc8180x-cpufreq-compatible-v1-2-febf0f17909c@quicinc.com>

On Sat, May 25, 2024 at 10:48:51AM -0700, Bjorn Andersson wrote:
> From: Bjorn Andersson <quic_bjorande@quicinc.com>
> 
> The Qualcomm EPSS CPUfreq binding requires a platform-specific
> compatible, add this.
> 
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sc8180x.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry


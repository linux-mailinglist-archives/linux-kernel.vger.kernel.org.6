Return-Path: <linux-kernel+bounces-510924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D832A323A6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 11:41:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C7293A2BE7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 10:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05502208978;
	Wed, 12 Feb 2025 10:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ldgtC9Pg"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E82B79C2
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 10:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739356870; cv=none; b=fL+vRiA4Rq/VE3bEwv2gcYIS7gTkZgcjtykTm/pcyQPH/c/MelfiYTWiNpqCYyBLBUdK8y+0c89OjWlS7JpmHhBtDwSiyCTp5MW8wen9cuX+ozShmZYQ3KldCAf2k3KkPHgWRsD5Kq7pYNMeXuK7hPWyNqqUTZ1nGlR7DElpq8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739356870; c=relaxed/simple;
	bh=HPiAWGGn9V3rjB/jGEe+4xyyXn//f8nUQh5na9jeQEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=duw/Yt3qgoTAbQ7/jcf9WxnpI7qhpwuZjqTdNHWwdRrOCdwgVLvAM0rF6qxPgs/CzPRCfNIkNLtLhUjGD91pLkXPLblgw/LxRnrDn9qyQxfKDB1gCEwsG0Agql+UzqRF3u19JU7kJXA3FfvXZoRGcmbKwl316MckJ4DCvccIGb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ldgtC9Pg; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-308f32984bdso24436601fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 02:41:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739356865; x=1739961665; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=l1iDkFXJdTLoJv5QQSzaQMxwjFb0WaoMFN/yVr47274=;
        b=ldgtC9Pg00q4T4piXD2BEFWhemsLQDolWmdLMA+3SpcbvRSUkvkx751Aq5WwH/nFfH
         KWzLFSnkXqPsx7yprWGPN3fjoNT3LKFnFfkxhcWXEkBIYoii+UOlyW8eNMaSqLEN1xHV
         qt5/isnB2rX7hDEkw7FRKWXWazaQv6ccVIA5smdYFo/CWJxwObLvYqPpzv1zycpK9cE7
         geCuRwk09oSoCIOdLKlaA4EwP+amIuxVkX5Lsg1JgxkKD6qf292nowYi0DIkoXaJCyOe
         fKPXwuY7K29qcbb5skJKS6M3vK+1MhI7SeJgeuRIDSQsikvll7iN9bulRExKkVexEHH5
         kLIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739356865; x=1739961665;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l1iDkFXJdTLoJv5QQSzaQMxwjFb0WaoMFN/yVr47274=;
        b=Gg2WDfZeQ/UvZlEpa8bmmEAY1fK1Fuxyh2ahgC7PVUylFjdSzUpu3Q/cqUbZzrbxnv
         A+bpvm2Pwr8Y18L2vR6MxR2uPd86GlE9eIpO3aOXlR7yBEDfKZzSUs3vGQAR2Z0lFhu1
         7X30TrNlTF4Um9m14J7QkhnQ5Frb7ZPGrzo5F9BjI5QYifh5wYzCvygTmTdfVrHbx/UE
         WK/yHZaXe8OusPYhD3fSBIOGFV1xc9SJjCmS3wIJPVx8XLz4l4RHiFgWC+huPz2WvkGo
         CNKDwxL4eCMLxq+Bk1UihSNF7AeSFz/zaLCtUwe817YGAJurx6lCB7nF9GHWdT1l6Q7L
         3pXg==
X-Forwarded-Encrypted: i=1; AJvYcCU2qtX43k+giXJ4yeyQsiL1fL4ZNXJlYrSIGl5IhIK8FqwgBImDdKFgEILdc1EB/aTHIrIS/8CboTcIEpo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzF8Pp2NpNqRc9HBxg2EgBaxvZMogXYHLa+GeNWGdTMa5Asos4y
	0BTrynMTR6tDNCK+smWDhJQoJOqJuCQrl6IaihlnVxaVk03TPeMYW0kilSEzl3M=
X-Gm-Gg: ASbGncui3FF24CxI53VtVP3VxqOToBmKUTTxDXMPCrCl53XIY7FaYwMPKpvS5M1H/wK
	0ss2CpT6KCw4C+YtOG8phZScpgxYl5kukVs5ERThVOQbsUld6GwZXkvjjYgaRyl5LvgJuIgMNrZ
	Y1zs1FBMhp1LUiXucV7EPpNDsRWSzq+fyl3IReAYeWl5r5K7mKM5IvaEZOgdQJZ6n0IJq4LsHlO
	5vHqDO4rfojDBqOVyJH6uuauY5zPJY0Nf2UEROda60mJmPRX8Q9Oj5JyyTb9WdwRpz1fT9zr5m2
	FqPFkBrsNFuooHVnEOmg6WVJccYj0szdbAJCy/I6Dum6u1/blAWEAv372A8uRNrNBl9MySw=
X-Google-Smtp-Source: AGHT+IFSoauwUmjTLIfP8x5XTTgpa0CFQaxSPV+VulxRisj6BoyUTlqKfWl0RYYwgy038tCn23zfGQ==
X-Received: by 2002:a05:6512:3054:b0:545:b49:f96d with SMTP id 2adb3069b0e04-54517f86bf8mr848075e87.0.1739356865416;
        Wed, 12 Feb 2025 02:41:05 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54504a2d1d9sm1310680e87.56.2025.02.12.02.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 02:41:04 -0800 (PST)
Date: Wed, 12 Feb 2025 12:41:01 +0200
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
Subject: Re: [PATCH 1/4] dt-bindings: display/msm: Redocument the
 dp-controller for QCS8300
Message-ID: <wyd7i47pkafa7n2yjohuvlh4btasxle4rw5xm55h4bhv24yvah@pfo224xz4xfl>
References: <20250212-mst_qcs8300-v1-0-38a8aa08394b@quicinc.com>
 <20250212-mst_qcs8300-v1-1-38a8aa08394b@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212-mst_qcs8300-v1-1-38a8aa08394b@quicinc.com>

On Wed, Feb 12, 2025 at 03:12:24PM +0800, Yongxing Mou wrote:
> We need to enable mst for qcs8300, dp0 controller will support 2 streams
> output. So not reuse sm8650 dp controller driver and will add a new driver
> patch for qcs8300 mst feature. Modify the corresponding dt-bingding file
> to compatible with the qcs8300-dp.

NAK for a different reason: QCS8300 is still compatible with SM8650.
Enable features instead of randomly reshuffle compats. In this case,
enable MST for both architectures.

> 
> Signed-off-by: Yongxing Mou <quic_yongmou@quicinc.com>
> ---
>  Documentation/devicetree/bindings/display/msm/dp-controller.yaml | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
> index 359e364d79b20469d41cd8416a55b6a5d5c7d8ce..59075d7f05147f1f477f236a76fee6ec5d8c5ad8 100644
> --- a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
> +++ b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
> @@ -18,6 +18,7 @@ properties:
>    compatible:
>      oneOf:
>        - enum:
> +          - qcom,qcs8300-dp
>            - qcom,sa8775p-dp
>            - qcom,sc7180-dp
>            - qcom,sc7280-dp
> @@ -37,10 +38,6 @@ properties:
>                - qcom,sm8450-dp
>                - qcom,sm8550-dp
>            - const: qcom,sm8350-dp
> -      - items:
> -          - enum:
> -              - qcom,qcs8300-dp
> -          - const: qcom,sm8650-dp
>  
>    reg:
>      minItems: 4
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry


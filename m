Return-Path: <linux-kernel+bounces-412796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 283ED9D0F48
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 12:11:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C065BB29597
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 11:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65F23194C9D;
	Mon, 18 Nov 2024 11:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QUdew4si"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F8938B
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 11:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731927637; cv=none; b=F7EFCMgXf/qW8uL0RzXzKKi2M331Qx7eUwdJCju5e6W/O3jSoeAZsXyAIRfKvENak9GWbD3gMHvNSS7Gmko3Qm/icUGorT7K3d/UiFvESqvyeQoucBPzWqcLyaCLjYtkK5UeH4LFl5WpJLHSPku8REbmgIzWtLhAP/YxO6lcbLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731927637; c=relaxed/simple;
	bh=VJvuF7SBVNs8klphpPE9k1L/tXRRQqdZWZIsf70UmxI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mbjxysB/rIYkPJgUFZicVIRijli9TJ2bgER5GX5I8iAZuRrsztvUtQX2lFSrzyaX2OHr7QRwRwB8BKjl0mPkpaKYaRtES8ZbLFZw3mdOcBgmTgeTT//8khVJ0a2rEQzUXtqf1BxjBS+B+Z8uJXvIa2NqL7mXZpjsfLp+M8sR6Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QUdew4si; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2fb584a8f81so35684561fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 03:00:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731927633; x=1732532433; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/+qxRVlwU99jdO72TMXnMzWfyKpW+x3AZmsGZ6Fs4eM=;
        b=QUdew4sidz/LtFQ0C/smCLssAcdtwD06kEsMxFHugMzQsqR9q1SL1O29jc3cM+VxdQ
         cscW9Qj+/Ns0nn00ukjFj/ZFMhZpVqmvqFvv0pvlz37arwuunbZUOYDRe398kVrFccUG
         NK66RKpTiNpsg6DxWg924E1wc4aX13zT6NjI4v1KOWXgWZ3oZVBEyMC3KvmLHbK3QR0d
         ZMH3fhSGErnh41id0kOaUYOdDLo9NEUzP5guIh+MyWRICcD85n8LpW0u1JtIo4tnUIf4
         t9xjEnvPn/9kKLphwVWFMBtpftqLBO6nO4x1nPYzezAcbOmPqEkACSp1ZnT+Tz9OtYTK
         oX/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731927633; x=1732532433;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/+qxRVlwU99jdO72TMXnMzWfyKpW+x3AZmsGZ6Fs4eM=;
        b=ZrZriY4grSHlX0+2ZUIgnB4DAb1buIztmvebJBanhpbWw+DZElvOJo3xGmoLpHgJ8S
         VbC5EQYByy+g34g+/1B5sUoq9md9t1N+wvupAn9nTbz1eZjzoUewZBws/nuggfqp0ziT
         RV8uL4eVcT3nQtF7RG8+oH18M389PrPSgrJytcVOdDgJUcZE37oY2YS4gtleb5fLkQvh
         OKOHAhmRK1wW08HY+hzS3U5VhqFz+3PsXz4nCAfuqMcLw32OY8m1jTT6MU2L1i1gt1uN
         AlE/mcZbFZPvQzzS7PhaQLd9IzEqXNjVSML3VIjo+UtZ8Jc1OVh6y68RsZS8f/z1DoZX
         GR6w==
X-Forwarded-Encrypted: i=1; AJvYcCXpfvsPG/F5jZuQo0yWnD0sGhYerMmfAPbLkZeO/mARwQ78e/lWwAQvy8RvU2lOJjRy2z8IMqkm8uCALjE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYkCoB9rzSM6ZMuB1mCwfzxyU3GX4de6aqwUpPUqpgU01r5ePr
	kxzh70pbXsgigwmjmUWs/nob8ZrBmjq6cs7Abh+6efMkgvasEBpHZfdIQdQc8xs=
X-Google-Smtp-Source: AGHT+IHgBjzO0bYRymV00U269jkhlwnbzUI5K4iYYfXbN3cZHW+Pwz1T7tfP5PHVJf3EORkPXLCIsQ==
X-Received: by 2002:a05:651c:243:b0:2fb:4ff6:eb0d with SMTP id 38308e7fff4ca-2ff6095e985mr43909861fa.22.1731927633080;
        Mon, 18 Nov 2024 03:00:33 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ff69ae7f35sm9042351fa.91.2024.11.18.03.00.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 03:00:32 -0800 (PST)
Date: Mon, 18 Nov 2024 13:00:30 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
Cc: vkoul@kernel.org, kishon@kernel.org, robh+dt@kernel.org, 
	manivannan.sadhasivam@linaro.org, bhelgaas@google.com, kw@linux.com, lpieralisi@kernel.org, 
	quic_qianyu@quicinc.com, conor+dt@kernel.org, neil.armstrong@linaro.org, 
	andersson@kernel.org, konradybcio@kernel.org, quic_shashim@quicinc.com, 
	quic_kaushalk@quicinc.com, quic_tdas@quicinc.com, quic_tingweiz@quicinc.com, 
	quic_aiquny@quicinc.com, kernel@quicinc.com, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, 
	Krishna chaitanya chundru <quic_krichai@quicinc.com>
Subject: Re: [PATCH 1/5] dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy:
 Document the QCS615 QMP PCIe PHY Gen3 x1
Message-ID: <b4srulghkbgrx65n64tsyhbdhn6xqv6gjhmovtozc5hjzmq2nm@aq5onb5fv3ks>
References: <20241118082619.177201-1-quic_ziyuzhan@quicinc.com>
 <20241118082619.177201-2-quic_ziyuzhan@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241118082619.177201-2-quic_ziyuzhan@quicinc.com>

On Mon, Nov 18, 2024 at 04:26:15PM +0800, Ziyue Zhang wrote:
> From: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> 
> Add dedicated schema for the PCIe controllers found on QCS615.

In which sense using qcom,sc8280xp-qmp-pcie-phy.yaml is considered to be
a dedicated schema?

> 
> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> Signed-off-by: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
> ---
>  .../devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml     | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
> index dcf4fa55fbba..d13eb46adbbb 100644
> --- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
> @@ -16,6 +16,7 @@ description:
>  properties:
>    compatible:
>      enum:
> +      - qcom,qcs615-qmp-gen3x1-pcie-phy
>        - qcom,sa8775p-qmp-gen4x2-pcie-phy
>        - qcom,sa8775p-qmp-gen4x4-pcie-phy
>        - qcom,sc8180x-qmp-pcie-phy
> @@ -168,6 +169,7 @@ allOf:
>          compatible:
>            contains:
>              enum:
> +              - qcom,qcs615-qmp-gen3x1-pcie-phy
>                - qcom,sc8280xp-qmp-gen3x1-pcie-phy
>                - qcom,sc8280xp-qmp-gen3x2-pcie-phy
>                - qcom,sc8280xp-qmp-gen3x4-pcie-phy
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry


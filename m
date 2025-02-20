Return-Path: <linux-kernel+bounces-523440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37D13A3D6D2
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 11:34:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B89D170EB7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 10:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7872F1F12F4;
	Thu, 20 Feb 2025 10:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e0NcaPsd"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081861EC00D
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 10:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740047618; cv=none; b=DRrQZVEc2b2yu9x8z/PjSJKGLswB1dKGmdNMemakPvF3mNyxj1mw4NJB5pFiZmHsFYm48RKp2H/yFDSF2Xab42jpsUcYBIbCx+1jInKA9eCmCcoxr4mgB/Mod+1gudAL4qdShmwwoUnmFKAjHkJVugvWiM+5yBxcwOo7cT8Sqr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740047618; c=relaxed/simple;
	bh=RzfeUZD0FlZO5/5K3v7wSpYsgAvSIsVwgaDHKGedw6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sm1iRwKQCT9J5RssHFsN332IUvDMvsGA6s3IZp3rJAdzqzudVmUTguf15jnhUTtEUZdYZf8UFEaCA3Ql1xkVt8yJzuwRDu5PC+nhxfX+YA5AdCmDk8G+/KqunKiya2MZCor8dq8GnM095Sf2pdUJNFtzYz3dAbIPQBVKlrgg4pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=e0NcaPsd; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-54622e97753so770779e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 02:33:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740047614; x=1740652414; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nOULWVV8S2WJWFH7D0olvt+CcxnnRMsdjMYkB3pg9sU=;
        b=e0NcaPsdqLi0h8+NRttO82+h+TnK4QpyPUXdT+T6Qwk75PQNVwD9OMtS+IfOHXjLq/
         XgxHHdsNqH07SwdCAtTIATWMK1An3czy4R64pZ0BCEEfUKT+tuYV2BExka6xg+TLvO1Q
         0MpBs6Y+2LWd16zY8r7swOUpESMYzvuRkrbFkQYDHORZtdAZYTEl5IELeudE7MgTkwOr
         6MHNHI5rhr3qlqreLEFDeMN7dyT1g0gYodlEFpbBVenyIqil+HZcXnkgKBl79Tqk6kbh
         eb3P4L4sFOw2QvfCrWJT7I2gm5GcQuxdf1KHG5UE1JH8Vt9zQq7ZZx7gg6Esvrk0Tvqk
         Fa/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740047614; x=1740652414;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nOULWVV8S2WJWFH7D0olvt+CcxnnRMsdjMYkB3pg9sU=;
        b=k/mhybCOpU/MALHpQWLlxQAnvrcXpYV/4QddaXkwsUx+rNT7jzZ/DChA2aBiIcpzwJ
         TJsC/cev+ueRhkXZwWUj2PN+Epd+9jyfJVjsBAocjYIMrFu1NolruEftMEg0qdlGUAdw
         TMPubG8K6SsrIcTXRdvwxDU0SP6C9jr+Imz1RZptSA25BSSnTd0bf4qoZ1kPm25AUA/P
         HiNTlYI2nz1EY4xMnDqkaDEIVyWQ2xP8ZMwUZJdvZ6k4wG3cGtqeJvhw9eXlvBbToHuB
         Ug4LzYBdjBL8VAo5P1CrJxelBfFMEbkM0h83SSVQa19mNTDVxuw3fAlVA5tuvBZ8usbj
         WOSA==
X-Forwarded-Encrypted: i=1; AJvYcCUlwVAG1mM0kf3GSKkZ/fh6yvL8pxcMIZOCMjY0uWHcbY/yDF3+mff6U8wd8iem6kplvDraqK4ZpIAQZX0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo2InZxE4dtON8gEwIoqtN1XkUPkT5/grAg+uJPeXa7MSX53Gl
	0s5bfKfaMsmxZkbsj2LYIjPDU4usfSGAScdRLEY7m71HjAv/Wwpi/qMompQdmq8=
X-Gm-Gg: ASbGnctJccdQaV0xlwGyJ9Sgt9YRpEFWotDyrrjDjMW0IYGQdzHqY0fO4kcnkjC8i+m
	UMoI9nI5QHIxBNjF12Ftz0vmBEc7tGja+KAHT0/cHeW+rbChWsmtp8FamXNeOrdzQZe16dF9/+9
	cEJjxTgLyGVUCTGfPLA+DUVvgvK4BudVRbm+ormlJSu+RiMBdTe6MZWd5Rl//afAWzLVEHEpGLM
	d3uGDmwpPSaBproa4i0ycMQ3h4DaFORbMQ/8hvI/m+Xoj0bMAX3d40gAiiARjpgZMzTPtKRIeb5
	uAn2MXVcx16mNslKUXrmpNqljNH2qHHKgMwDrbLBrafhN6sEx7c0flhej1Fd6JuUIcO2dW0=
X-Google-Smtp-Source: AGHT+IGUUcYwMWrswexilTub+9t7uGS/voZUkkMFCSEUbJmmonP/3ieTF/+EZ9nECI5YUhJLWrjddQ==
X-Received: by 2002:a05:6512:2387:b0:545:9e4:e823 with SMTP id 2adb3069b0e04-546e58bacd7mr835355e87.16.1740047613925;
        Thu, 20 Feb 2025 02:33:33 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54595e38064sm1632621e87.126.2025.02.20.02.33.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 02:33:32 -0800 (PST)
Date: Thu, 20 Feb 2025 12:33:31 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Jun Nie <jun.nie@linaro.org>
Cc: Rob Clark <robdclark@gmail.com>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Krishna Manikandan <quic_mkrishn@quicinc.com>, linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 4/5] dt-bindings: display/msm: dsi-controller-main:
 Document dual panel property
Message-ID: <grdadzunaabzg5jxpsiasgzbioy24tctlhhyxg6zwdkpv5vjwe@7k2di2myu4k6>
References: <20250220-dual-dsi-v2-0-6c0038d5a2ef@linaro.org>
 <20250220-dual-dsi-v2-4-6c0038d5a2ef@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250220-dual-dsi-v2-4-6c0038d5a2ef@linaro.org>

On Thu, Feb 20, 2025 at 06:07:55PM +0800, Jun Nie wrote:
> The DSI interface can be connected to a panel that has a dual DSI channel,
> or to two separate panels, each equipped with a single DSI channel. To
> prevent the DSC configuration for the dual panel setup from disrupting the
> current configuration of a single panel with a dual DSI channel, add a dual
> panel property to support the use of two panels.

Please use the terms from the standard. The "channel" is mostly used for
the "Virtual Channel" or the "logical channel".

Also I don't follow how DSC configuration for a dual panel setup can
disrupt current (?) configuration of a single panel.

> 
> Signed-off-by: Jun Nie <jun.nie@linaro.org>
> ---
>  .../devicetree/bindings/display/msm/dsi-controller-main.yaml      | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
> index ffbd1dc9470e2091b477b0c88392d81802119f48..e3f2eabde27609a66d6d81fafcb14e1bc014613c 100644
> --- a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
> +++ b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
> @@ -88,9 +88,15 @@ properties:
>    qcom,dual-dsi-mode:
>      type: boolean
>      description: |
> -      Indicates if the DSI controller is driving a panel which needs
> +      Indicates if the DSI controller is driving display device which needs

Unrelated change

>        2 DSI links.
>  
> +  qcom,dual-panel:
> +    type: boolean
> +    description: |
> +      Indicates if the DSI controller is driving display device that composed
> +      with 2 independent panels and needs 2 DSI links.

How is tht different from qcom,dual-dsi-mode?

> +
>    qcom,master-dsi:
>      type: boolean
>      description: |
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry


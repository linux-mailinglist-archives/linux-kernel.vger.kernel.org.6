Return-Path: <linux-kernel+bounces-510363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4317A31BB6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 03:04:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D0F918895D6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 02:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1F2727183E;
	Wed, 12 Feb 2025 02:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lUMwcZ5C"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E1C35956
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 02:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739325891; cv=none; b=unMA409b1BRM4V0gsHxdXtbII1osenzBL+n6dI5WKspFUgXh49DxV8HFskP3eoq81jyiOdv6Zs22+ZuKo/Xu+bW/FO4j9HBs+VWdgqeVYP2eUdR/CfmRcE+HdjUm8lMftMHxv8wEFgOVPsAIneHRcpCE+XwB7xehF0aifXzk4Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739325891; c=relaxed/simple;
	bh=WA6sJGQJcrkuPH75N+HttzYq9YuDprAODfLZpxk84fI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aVny3Z3y0G4Ge/KNAgROkdecUpmQUm8lPRYMwZ78wIRC6C0ol2Uo2b2tF6eRnb2gG3NXQK+wP+ZuGLPSKE89LzoL9V7Y3F5tyQPLYvk9I3e5UmrhiHdZeVzjnXxkiKXHNvF3HpvwOltl26VjMPmFH7ileDsXyT1WJxxKFzK4JY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lUMwcZ5C; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-308edbc368cso28974431fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2025 18:04:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739325887; x=1739930687; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R7IdEZG18Q5o8KZmHsmgbkFSx+Id/bmIXHGqNyb+pxU=;
        b=lUMwcZ5Cg+lnHOf8w/l1QiZT5c03hJdA0YnmGZwFnr+KNvLKpRtf/CCxeEg318b9Q7
         TIiwcgmBbzkBj3m5uZvw0QcmmeAzvOCsF9R6g9il8izRGcAufZFKvV3roeA1WBhDde5V
         Xb8xFohGnAl8jyNUbJWXcrR8vrlLcFEp/MfRiZq91/2skJnWZBQq+GA+3zv6XJM6b1pd
         BXQd+FZnuo1SSIHDt8PvWiQ3/Wf2ZDKfhqH0SRA0nMmprYs03YMt8sNwF/ytCIa9pin8
         akev8iOg8UrmFvw6lQ/FwkWWLKhw7q/q5qvE2zZA1r8KAgO7q9zXaIb1NnxDtX+nQFdi
         /sVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739325887; x=1739930687;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R7IdEZG18Q5o8KZmHsmgbkFSx+Id/bmIXHGqNyb+pxU=;
        b=ELlHq2hJrX4XxTrgtGpPJgO9MD7bYdIWWTNcm0ZfrReeGOT0C86ImrDrSlYnMOD8kY
         lHoMQ5Qwuw40yCmz+UtqhGEd9KcWb4eOz7GX/f8qZpvaJO8Dqx8CnspLUL3bquR4ZeCT
         /pQtEjzwK3i5l1gqV4bfp1DvSZU63mLVUjRO+8tX9oOtdN0/LWYwcx5EGZR8hZkcvEGY
         HMFnnh+u4ahd602fmIofxiBFlPqJmuji43rVdmCpVEzdJfwUQOVa9mF2a+xLdZD+HgV/
         SL2CVZYM5eDJdmngpqmUwM9wtVYizAsp7ODtsQQsKfPI5ndx69GMzDhmBRl/MTgjbsDw
         15kA==
X-Forwarded-Encrypted: i=1; AJvYcCXj1y2Y0r0FMJqAx6s5LHLlGQX3dppoBu0juXM/DMRoRHBKEhElHEIjJFSmevRMtznHE+lwb/3Urkr3SSc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGoQlfzOdn1d4e+3oiKMgnN8tl5IbrtXPx3HjbqElhsEJI45ma
	NYQFfMQ7yK3pS73y8LAIBlUIq/9vxtz7W2cgvednV4R/Z3aDO8eUiaoXjpUFbE4=
X-Gm-Gg: ASbGncv932uPhI/eqdDVh40iXyc+9KzA41vQZwHz7R6lrNjq8Z6HjFcZwHxM6RipvU3
	yfoIiIcCNconsPYDmPcZK3nxw4kJUE8xv1HwuldhXtZbT6vI9WafIviodwc9qEu0MUtAc+r2V+B
	kJ8SFETRr7h9/mfOAy9vHGETAzWxtKhFDxD0yNqCLaXBtIBsvjmtyovWz3cfKMNMgyP58jEnGNW
	T8Ak3+EqJpmYIKHQpzpMagG1AcZsAXpOpSR69A4F9Z0TlrTSI+IVFWqclN3tZyAUJqQWpqs38QJ
	ctTBfWd/VhdlpCQMM5TyxbKbsXAICvHUMlGD66SFYSM4m836bcaWaExOk7ys+Tg9dfjKOfM=
X-Google-Smtp-Source: AGHT+IHGUvsASRUyI95s8c5HVDgpz80tj1nMIWLN+2DiNgGjlKM64Zw9WLqCuK72ugaPx+jKk/2hRQ==
X-Received: by 2002:ac2:4e05:0:b0:545:aaf:13f5 with SMTP id 2adb3069b0e04-545184a3aa5mr299522e87.37.1739325887460;
        Tue, 11 Feb 2025 18:04:47 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5441060400asm1712383e87.218.2025.02.11.18.04.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 18:04:46 -0800 (PST)
Date: Wed, 12 Feb 2025 04:04:43 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: "James A. MacInnes" <james.a.macinnes@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, andersson@kernel.org, konradybcio@kernel.org, 
	quic_wcheng@quicinc.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	lgirdwood@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 1/3] regulator: qcom_usb_vbus: Update DTS binding for
 PMI8998 support
Message-ID: <ffe2jzm6buz73wqkrqdf4wm7xihv2sdxuqmwop3lfqhneypajx@mwd2oidfoqh5>
References: <20250212010744.2554574-1-james.a.macinnes@gmail.com>
 <20250212010744.2554574-2-james.a.macinnes@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212010744.2554574-2-james.a.macinnes@gmail.com>

On Tue, Feb 11, 2025 at 05:07:42PM -0800, James A. MacInnes wrote:
> Update the binding in
> Documentation/devicetree/bindings/regulator/qcom,usb-vbus-regulator.yaml
> to include the compatible string "qcom,pmi8998-vbus-reg".
> This change adds PMI8998 support to the Qualcomm USB VBUS regulator
> bindings.

The second phrase is obvious.

> 
> With this patch, device trees that describe a PMI8998 USB VBUS regulator
> using the "qcom,pmi8998-vbus-reg" compatible string will now validate
> correctly. This is required to support hardware based on PMI8998, which
> has different current limit tables and other regulator-specific
> configurations.

All of this is also obvious

> 
> Tested: The next patch contains the driver and has been tested with
> Lantronix SOM.

Drop

> 
> Signed-off-by: James A. MacInnes <james.a.macinnes@gmail.com>
> ---
>  .../devicetree/bindings/regulator/qcom,usb-vbus-regulator.yaml   | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/regulator/qcom,usb-vbus-regulator.yaml b/Documentation/devicetree/bindings/regulator/qcom,usb-vbus-regulator.yaml
> index fcefc722ee2a..6092560e9048 100644
> --- a/Documentation/devicetree/bindings/regulator/qcom,usb-vbus-regulator.yaml
> +++ b/Documentation/devicetree/bindings/regulator/qcom,usb-vbus-regulator.yaml
> @@ -22,6 +22,7 @@ properties:
>      oneOf:
>        - enum:
>            - qcom,pm8150b-vbus-reg
> +          - qcom,pmi8998-vbus-reg
>        - items:
>            - enum:
>                - qcom,pm4125-vbus-reg
> -- 
> 2.43.0
> 

-- 
With best wishes
Dmitry


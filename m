Return-Path: <linux-kernel+bounces-422425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 239B29D9985
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 15:21:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD61C282A02
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 14:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61DEE3398E;
	Tue, 26 Nov 2024 14:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OKryEOr0"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0668E1B87D0
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 14:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732630892; cv=none; b=iajaJw1zdLz57YHKFxxHO/eBVuXfQhJXWRNRFxInrltITDrBBUPWigG+fyD7pumNNXBuPE8uyf8SI0YyfMT3VWYss6fJMMn+zVi/XQ6DlnGCCt5posmFV3b18x2Ubn6MNaEFkoVxJNCifjnd3HkFqizEqknR0tK3TUbhcmHt9P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732630892; c=relaxed/simple;
	bh=hSchZdne2yL1Me73QcTXHzIkfVLw00TjinA2YwxeHME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nbdr9UUbeb31wTKmieLzhE5f6VDtsMo4xibAKn6oA0yjaL/39wlRLMLztz2WBK23rEI8qokMeJdbXFIrplj0t3wEHOJYwOCPJfV/bKs2pjTjn4HSYJFwf/Y13AXaXGjaeMsJUc2nxQdjW6lAR9ImKKm75RaO3LU6lmMUU0/47zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OKryEOr0; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-53dd668c5easo4217917e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 06:21:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732630889; x=1733235689; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WsqG/pbjaTDjdBrbE8Gh7QedJI2HzzUU10Z4g5bMrfU=;
        b=OKryEOr0m46uCzQTwvHekXmTO56lqHguIFD64EYMVJZva/Jb6AWRHP31hFcSLTKM97
         Z7aPdshopn9MQKWLRyl/L5Pv6zCjCBDIq0aM9Wo+wt9/23fDhIt9Qy61LV9EgPsWG/It
         q+rRzdHZpGuzc8jN88ROARMWcksixPwYsY2FjfJAh5CG6GdI6J1BWVa9NkUmDamMcvq2
         6sbupb1A0gSUI4Q8OEY8D7sI83sFBci/csRtTvRdVd46pLuWYev+tmsL11UFU2FGlAy0
         lCPxL93pP/ceC+bLX+98hHrISBnHEHJO1acpPyHn+vPfowUgvhVZjU42YN46/HPL+dMN
         K29Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732630889; x=1733235689;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WsqG/pbjaTDjdBrbE8Gh7QedJI2HzzUU10Z4g5bMrfU=;
        b=hcJWOCxVZbHbDeXyqt0CtXrc9qPrHMJxiVR0qBSmVzzne/LEndy6HX5u9CGqBHL3RQ
         WvOgM+ynBy5ujDiTOAkdvicRo9JbaDK7JTG6sk19hAcSvUpCQ3oF+2tmp+ZtXSbndcfe
         pJ90ZRRynJeacP8LtzW5VoJJdZ6NnlNTSe/GIZY1vm9sLdl+MblLhbCJR558ojS+t+LW
         RkU2lP3Rlo9zk95uP/uLDLB7kmbNQLZulz5eEKkgdO8JlaA9tr6li4njOpxfDsEGdxmM
         p/KJ4bmkfPVcT6jKB3rOizUdbCDp2UOh6vdk9rebgdG5TE7G94SULXlioYp1kwIcpqXb
         T3ng==
X-Forwarded-Encrypted: i=1; AJvYcCXJQMUSRndGsVKK+RCplDD3ORZGoAuNCBtgpYSOkGuJAY1MI1jxm16GLe4R4Jg5bO5jTzgr1NKkYTt2Mjw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/O2FaZjeIdqXTLYm7ezm2YPNejYcmQmbn+RQT30wn1JO50z+E
	O5JKdWcBGYepxVQVpfyNsFqXJsaSqL2YMXruyqCDJuXsHu5V+kNGEQoLVI/kQZk=
X-Gm-Gg: ASbGnctGkjqcDzOl0N5k4jki/k1sykIxjehADfJ7NLBuDBuLVL3gjzgZopZWCtieEPS
	dxOIO7C+1tw6ZD/9pwsT2+BzwsEtFMEdg3NCYWX2Idl4mtOgxtjer2B1v9YLjxYSB+w+GrBzd6c
	reW4ToYhKs4NDGXPkbRzp7J8nTR+gTWIYwgzoE4y4+COItb7hb4DP10cnrOTDz5lv426jrXOnj3
	AO9Vw298DcWZw6VJ48zTokQsJOBVzXa32uUSwpEWYQYpKL6DTyzdyQg2NZ/KvqbH4BWq9NYBEW2
	MXVk4OoEyp51f/yPXtqNJ4UyBLnjuw==
X-Google-Smtp-Source: AGHT+IEJeByCvQlDqy1R+C0A81cHp1AJ1H0PojsXjN2ky6dVBr3C2B16XhZSVyi5c5B271VuJ9O4Kw==
X-Received: by 2002:a05:6512:318b:b0:53d:eda7:6981 with SMTP id 2adb3069b0e04-53deda76a69mr556144e87.27.1732630889153;
        Tue, 26 Nov 2024 06:21:29 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53dd24518d7sm2025711e87.80.2024.11.26.06.21.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 06:21:28 -0800 (PST)
Date: Tue, 26 Nov 2024 16:21:26 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Akhil P Oommen <quic_akhilpo@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, 
	Konrad Dybcio <konradybcio@kernel.org>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Marijn Suijten <marijn.suijten@somainline.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jie Zhang <quic_jiezh@quicinc.com>
Subject: Re: [PATCH 3/3] arm64: dts: qcom: qcs615-ride: Enable Adreno 612 GPU
Message-ID: <x3jgyvzkb2p5txzmqvj2qdhj7ag5css7qgbynxlohbypz53dq2@io64rzakgmkd>
References: <20241126-qcs615-gpu-dt-v1-0-a87782976dad@quicinc.com>
 <20241126-qcs615-gpu-dt-v1-3-a87782976dad@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241126-qcs615-gpu-dt-v1-3-a87782976dad@quicinc.com>

On Tue, Nov 26, 2024 at 07:36:49PM +0530, Akhil P Oommen wrote:
> From: Jie Zhang <quic_jiezh@quicinc.com>
> 
> Enable GPU for qcs615-ride platform and provide path for zap
> shader.
> 
> Signed-off-by: Jie Zhang <quic_jiezh@quicinc.com>
> Signed-off-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/qcs615-ride.dts | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry


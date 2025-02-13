Return-Path: <linux-kernel+bounces-513530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 929E4A34B45
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 18:08:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E6A2188296B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 17:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C217200120;
	Thu, 13 Feb 2025 17:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B6c9+SMx"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D142A200115
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 17:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739466014; cv=none; b=m1tvFS8gRMSRyL4D+lZcck6MP1tEtyUxwCD0EqPTl8+NhfF238SDC3GZYleHs16stKyiJlxtioALJy+OMVTR5j5yscmhsAslk5ARl8KZSlJPV60HdNQWoQkAd2Kjq3U6gDhy4xOETD+iGdmIYgJrMAcFnHJDavZGpjqQZd1VC90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739466014; c=relaxed/simple;
	bh=BtRN7n4xGXk239SdRnSmUkBejNJDYu6BWsjQYOPuYjI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oswvdnkd6dXKnDggrKJUFCb5e5lS8QFIV3yLiSm+gX1dAa7PQnNIX5lqvrl3yQO2SVT5Owal0K6QsomBQKV1BdWwK9x/NG2NlKwmXe4gFLs12oYiQp1xESk9+fvjn5xxk7qStuuAWT4KJ81AgNG2MGuF1oqZjEjOs2qtiXP9Ryc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=B6c9+SMx; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-545064389d3so1167171e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 09:00:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739466011; x=1740070811; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eLTdc0mnszW35pcuuPl/ETu0QFfOhGZjVUBzq1yxI/g=;
        b=B6c9+SMxWWo0B2lSykEu6ugROGyeyZqmYZwGGFJt9vLn/SIJwPto5rHrVW/tfCO9Bp
         s1D3mzUGJKpZjbnCU84VcVAQwcJPj5nMObD87XfsjKGA/yH/yxFpyCx1nC0hP063lRGS
         G0CsUucqLayhdADQi3sWrF6FhqmQHKX65SItV3GuvsUzli1vYZYUopRH+VsgEieHoqje
         gVO/bSV7gFBKJu7s7Wyen9wkKtwr/Qe9UgNG8lyoOjr8qqFGSI35lS50CNgWACaesaBj
         clQ3l94wd6ahuOY+DU9tMLXFS3U7GaFIr6BM+PMD8/pQdiYtUztkZkSa6Qq0XE6N22HP
         wlAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739466011; x=1740070811;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eLTdc0mnszW35pcuuPl/ETu0QFfOhGZjVUBzq1yxI/g=;
        b=jA/m46d9hrhreDpG71+WP3PvwgNZ+Kc1VSVGTaAWlT+rjEI493EgpzpgcbHsHgQKuu
         D95UigVk62S09fBoopm2gOHzcosFi9Bw6CB/Ry0QD5gjUR3i8+BKdh/j0Q+ZcBDXQVeL
         709coVyIfRh0/HPkIeaMPRGqMTun/XPKEhif9aXxaK/nw3qWdLiucxyJ1Mq1MQOony/z
         H5X6S5ZJ25TFkni40jdeNyyLDw5zenswUMfbnrgYPuF1GW+qZvbxR4nClF3wCOJj63eO
         trtqics5yR0sZa7c+E0+7fvVFN2CL9npjbldiVe49J+EuwmLGJ9TuzkAbeo4fpMYY/+Q
         dG/g==
X-Forwarded-Encrypted: i=1; AJvYcCUPW7D3AsAIDmeL+d52Lu6nLpjEPn23YVqrNrmTmiw8Rtu8cd2gsu3Wg6AVr8mBiTvxwyftASR10gjmnHg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2Xfb0Ei81XIq5MX3KwKD9pDBTBryE2hooIO8HcDi+KWxh5+pt
	KDE57IdL1pezJwEVw/kS5zVTs8ZtAjAjOFB/erLqw+hCDjYtHSnRYLr3RTnQC54=
X-Gm-Gg: ASbGncvmeCfNRPU6PK2rV6QNb+2DomhP+9Xv5PfLpABWfXs2swLy7j/NI+DX2BI041G
	XftKIKpwg1q9m6+T1w9JtJt25vzL8dP7xAfqD83jcWNzU/YmzvN1qDJaEM8F75SHAxcHj9Gs4A7
	RsPH20/oKI/5fSp19QcLJjz9JvOHwHtQ39O2v1Fj6gchtYUABeHNMzz0+p3O+Nc/dp1zcBQ6mbj
	8YMaGvUYMOMZ0Be8StdbWoUXVrP7thOSFykqadRt6o7mnwdZTTKnRNqU36uXKA4Epsz90hX9J77
	iAqAKd+7snAcqj7h/SbCSt1PFrSAscPemEW5KdERmBNYgcwD3SFh+0H3pD8211xOZ7aZfeQ=
X-Google-Smtp-Source: AGHT+IECjSH9vRJLStWd+xD1ybGS+qcgRaQJyWQXD6FBqkvSQHj2aTj5q7HpRowg32NwdODaOMXJGw==
X-Received: by 2002:a05:6512:224a:b0:545:fad:a757 with SMTP id 2adb3069b0e04-5451dd99d0bmr1143047e87.29.1739466010776;
        Thu, 13 Feb 2025 09:00:10 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5451f105e4csm219176e87.111.2025.02.13.09.00.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 09:00:09 -0800 (PST)
Date: Thu, 13 Feb 2025 19:00:07 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Rob Clark <robdclark@gmail.com>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v4 3/4] arm64: dts: qcom: sm8550: add missing cpu-cfg
 interconnect path in the mdss node
Message-ID: <pgwuzwohvnvrw7ism5zuaigjjsljvqylej2tyjxeo7cpcsycfk@lusbxdvvbetz>
References: <20250213-topic-sm8x50-mdss-interconnect-bindings-fix-v4-0-3fa0bc42dd38@linaro.org>
 <20250213-topic-sm8x50-mdss-interconnect-bindings-fix-v4-3-3fa0bc42dd38@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213-topic-sm8x50-mdss-interconnect-bindings-fix-v4-3-3fa0bc42dd38@linaro.org>

On Thu, Feb 13, 2025 at 05:27:58PM +0100, Neil Armstrong wrote:
> The bindings requires the mdp0-mem and the cpu-cfg interconnect path,
> add the missing cpu-cfg path to fix the dtbs check error.

I'd say that this is not just to 'fix dtbs check', but also to ensure
that MDSS has enough bandwidth to let HLOS write config registers.

> 
> Fixes: b8591df49cde ("arm64: dts: qcom: sm8550: correct MDSS interconnects")
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sm8550.dtsi | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry


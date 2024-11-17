Return-Path: <linux-kernel+bounces-412107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3267B9D03F5
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 14:11:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC1E1282ED7
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 13:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC337183CD1;
	Sun, 17 Nov 2024 13:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FFNCUqcD"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620B783A17
	for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 13:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731849078; cv=none; b=Xk7pqY5YHsjQ8P4/qVmOyiFHNRJaKzarb2nMa155cYurqKCfNRdrPUZwZ2oSeRdOUhDQzjxSIwgmQJoXa11K9teRheQ31tIYTQN4jKeB7Ruc8DREz1lkcTMHgkicns6VsVAwb+uBPivUeHsW6tyuw/2fcKjlzyX8m0P/fjTSq+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731849078; c=relaxed/simple;
	bh=nSwj3A8/ForjeKffUwizb7noaejgig1pPhnISFTHpWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gCg4UUBlxQOzYst6givulg42V0DxrEbDoQGmjZFz7cGx9m9v9EWerXWRv2kYj6KjPLebjoTHXHM3mdZcCBj6QZnI6bDTK9LjsEqiAoDqXUnI/tdYgqSMtFe+tE6pp7e+RCxmi9ScgdmX+oPVpNZpL8jfIUisNeRwxV886tAmXic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FFNCUqcD; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-53da5a27771so1215761e87.2
        for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 05:11:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731849074; x=1732453874; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NVTB5fgW0CIPrQ9J8AICgZwfqKYac/1UcCg9s2HGvdI=;
        b=FFNCUqcD/6uAxaCGxwUSXFs0ySP2qm+JEADJpfQ6yluAcuMWiEyafezrmLs4Ndq+0x
         R0DGVJgL1GPjWNyYN/jew9X/YmIJGuL8hBk/hi+GuxKYoe81eMuDf4VIDByruw79OL8/
         mqACKXNpe2oP86OMVGY9PE/lAEzoOjaGfBH9LbxiIisVEtlDQj02bNHfAcv9WyDENgiG
         Pf6wgMiM4nP6g6YkE871PZZZZEo1dNDKDh70myodcv8wv5fPr/nsmKFY3Vx2O4rJ/5dB
         2jyOVLoEfvaV2IWfnwuX0yq6bwfdquGXbpDa7UkfumJxNjkDhUDa5iL1L8A2bF6B4kTS
         5i5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731849074; x=1732453874;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NVTB5fgW0CIPrQ9J8AICgZwfqKYac/1UcCg9s2HGvdI=;
        b=CljVWkWf7fvJ4X3oYFC39YtLGUdZ372XRLhJvi+yIeplNCgks/Pa5KJ5KH5jtjUi5G
         Di1MhpkkDsfgdgxSGT20G5GV8qrwOQVF17Fo/nF0LYI6cizdJ2pvyVZ7zasKC84YOd+Q
         1BNipjh92Q3f6QMFLZno1f6Eo6uIOMNYvSf48NAXPzLx94QX9/PAPqxHRfHLI/tamfHW
         46rxYoxc10jnijxdD1DoH2rXBG2x/fOeRlBMQI3MxJf6z/KIl0/lYI2J8tJf2dUlqQn5
         ZFSrv1EfOXiR3d2J7Ct971Vbyn+yTQG27IHi2cp7utzxhJUaiaI22R0RUzs2IetLkl4P
         Uv7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVkyJZrw7DEYdt9SrPzWm5AsO5NUZXmacPq3dwtw0i1n2z6o9G7NVUlH/tuk837ie6FcmwYaLh3u8k4oQk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9TTff2UY+j0Oaf9cH/HyKlhbvdRLFOxsYReg5x7MNcLNqBDbW
	AZh01FsP5gSolZ3KBkcO6J8UlkHaxpItcuOC/t7nJu8xUeabvU+bXlE/l4FuXGo=
X-Google-Smtp-Source: AGHT+IG575J6WcG9hzhULgqTQtjUCp+Yew1GGtVJdfAdD7iB6t7lRgirF640uMkUJ3IZlpLMdP65gA==
X-Received: by 2002:a05:6512:1195:b0:53d:a1cd:4d2 with SMTP id 2adb3069b0e04-53dab2b4216mr4246336e87.44.1731849074309;
        Sun, 17 Nov 2024 05:11:14 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53da64ffc6dsm1269110e87.59.2024.11.17.05.11.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Nov 2024 05:11:13 -0800 (PST)
Date: Sun, 17 Nov 2024 15:11:11 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Bjorn Andersson <andersson@kernel.org>, 
	Vinod Koul <vkoul@kernel.org>, Marijn Suijten <marijn.suijten@somainline.org>, 
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH 2/2] arm64: dts: qcom: sc8180x: Add a SoC-specific
 compatible to cpufreq-hw
Message-ID: <7gftvwwc267za5jgyhw4yxmlw6rh7wkb2am5zx6cgl72x45hc7@eetgqavlalpd>
References: <20241116-topic-sc8180x_cpufreq_bindings-v1-0-e7db627da99c@oss.qualcomm.com>
 <20241116-topic-sc8180x_cpufreq_bindings-v1-2-e7db627da99c@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241116-topic-sc8180x_cpufreq_bindings-v1-2-e7db627da99c@oss.qualcomm.com>

On Sat, Nov 16, 2024 at 12:31:18PM +0100, Konrad Dybcio wrote:
> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> Comply with bindings guidelines and get rid of errors such as:
> 
> cpufreq@18323000: compatible: 'oneOf' conditional failed, one must be fixed:
>         ['qcom,cpufreq-hw'] is too short
> 
> Fixes: 8575f197b077 ("arm64: dts: qcom: Introduce the SC8180x platform")
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/sc8180x.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry


Return-Path: <linux-kernel+bounces-513526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08352A34B36
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 18:06:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B82851886975
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 16:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5C4E28A2C3;
	Thu, 13 Feb 2025 16:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KtZ4c/5m"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79DE528A2B3
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 16:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739465862; cv=none; b=nsWBynua168ri7fYoNwvOOVp3m7Gvb68pfO7+F64tmmyD67jeOYr+cGLhNXM7fTDWHPdJUkgNVWyD2XynJreXaTK+dCddkGQBqyc4utDZnSJtszZaQ7bjeuG4MGXIroXcHsvOhGwuA5YwElmKcW41ygz8y79WB1r59xKXn+TXtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739465862; c=relaxed/simple;
	bh=NbnxWrMS7KgynfdJrNOB8JKZBra1lv3mAs7164xHJsU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iBmVGtgF6YfDJ29ynp456hruuOP4S93M8SmIxfwsIuxHARD7LcrELuFnKnZwnQG1KOD9jF3Cs8eH3gpLvtESTBFKu6kHyPBBR+favu5v1DEfjbDcZ1BsrS3xit4l+iLnvftWuF7xV4R2849+R76BbtQAV8BBDgX4hTkFSnd8MTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KtZ4c/5m; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-30918c29da2so3491641fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 08:57:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739465858; x=1740070658; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6DncLcX9aKkMb7TYzbSn7LrwA/nLBwK9XSdK3BMFQDQ=;
        b=KtZ4c/5mB5TzWqAfANcHl3GFT0I3m/civvODy2724FMnqN5QpNiAfZnqRWe6xga7DB
         hY099syvBJkq6bsfEXStGBp5nAfNX+U3stQWa4EgHh6dFDrQm3orJYRGW47OBs+4Yt/X
         vHu2zMwRWUNQ8uphK/v/xOI8YHe1JE+mSQZLkgFN+XbKZWVyMWO2fHhUcCSVmBmi+2WW
         i4XTBq934R+adNxZKG2TQF/CoJmr2BgHC3t9AzCu89mFSH+DxODJHP73Tlc1WwgpaVek
         4lAPFZXfqYdqFPnX+3d7UlqFrBeych40n68X2VVYkMkR5n5gh77kAdU18p+iTF4I4VHV
         0wJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739465858; x=1740070658;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6DncLcX9aKkMb7TYzbSn7LrwA/nLBwK9XSdK3BMFQDQ=;
        b=blGi2JKNdGZeUy3QSvwt9XE/UKSNj5/MblN5QbCquuA1Mfxj170QV3zJD1ijXWEtzM
         4IF7ZaDJB66VMtr32khVt9yfou3bAHbbeXlcOlPZ8WE0uJGLTRi1R8r8rCFl5dJ4hGOw
         U+ySYv2XujLdqsw+C5MZMODHbfZx5CxbIFdNUx4sANETuv02owwGEhPVcUPTfnQ9VE0b
         ggXaU5z9yCw0NnBfBO/E18YOvwAxz/YGtbsCk/8Qq2Fqql6OkzLWKacrIlfk6NOzUJId
         kuzZHN+kMjmA286kQ2Ol1IGhRBmNxJuTu84oKU0CPePbFY42IyDM80jagQ10vtJRf9Zw
         tQPA==
X-Forwarded-Encrypted: i=1; AJvYcCW06wBmlkbL2QKIFvUjA2BZ7vJtuY1p2yjNmXR1rV2uNMesKeF/cs50J06pBMhoLBxyWREUlX85QSvjsOw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcmeZQv2dwWgd0y0akzm5yiSw4y2e8xpOp2dQv5Qv6/lVVliur
	C7SB91A3k5OLFAYEdHW2l8+h5SZb4kcXdCmN9H0ZbOXM4UqdELyAkQ1LZNRDtY8=
X-Gm-Gg: ASbGncvV9VLM02XdjM5eAwG3urmgLWjLtWzHpDUfcMNY3pvz8xHr/9XvqQgfSYCAYd6
	MoptSmWfcuhit5C8CMgHNq8EhUr4SLLojjHfVbpoS6oW3HCFI0n1iLWpKHrF4Ilp5EIo5L8znMT
	7hRJ46ze98v+aukduSMwYoqmNvziDLGDnvP8W3aC2Le8DxPhJjfnr5p8VDiivh1u8i5rT4L1dL1
	fCI5QgWxnwY1oWc3VMpTCr7QpiDfZAswoFVppsCbJ+U1MpDvAqUVsaL+rBBwwS9ctj0HOvYFmmv
	/Czr2K2OowTKU59RW+oHPtoo48XRzPb98i4qHF1IylsVgjYywYZnBAB3zDrkCVSNvMUpmr0=
X-Google-Smtp-Source: AGHT+IGmG7vAzEnhXHlQo3207L4CmELRiyNhJ3wUUEyMyFbBXvRHz97NRmkBrfrhecbVrZ+I7yOf1Q==
X-Received: by 2002:a05:651c:4108:b0:309:bc3:3a56 with SMTP id 38308e7fff4ca-309148017bdmr6741931fa.0.1739465858543;
        Thu, 13 Feb 2025 08:57:38 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30910276efasm2467321fa.85.2025.02.13.08.57.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 08:57:37 -0800 (PST)
Date: Thu, 13 Feb 2025 18:57:34 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Akhil P Oommen <quic_akhilpo@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, 
	Konrad Dybcio <konradybcio@kernel.org>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Jie Zhang <quic_jiezh@quicinc.com>
Subject: Re: [PATCH 5/5] arm64: dts: qcom: qcs8300-ride: Enable Adreno 623 GPU
Message-ID: <gberjl2wv5tafnemlagidyrulhiqtfwri254swv7zoc22dnzns@2obwq2rzcnap>
References: <20250213-a623-gpu-support-v1-0-993c65c39fd2@quicinc.com>
 <20250213-a623-gpu-support-v1-5-993c65c39fd2@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213-a623-gpu-support-v1-5-993c65c39fd2@quicinc.com>

On Thu, Feb 13, 2025 at 09:40:10PM +0530, Akhil P Oommen wrote:
> From: Jie Zhang <quic_jiezh@quicinc.com>
> 
> Enable GPU for qcs8300-ride platform and provide path for zap
> shader.
> 
> Signed-off-by: Jie Zhang <quic_jiezh@quicinc.com>
> Signed-off-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/qcs8300-ride.dts | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry


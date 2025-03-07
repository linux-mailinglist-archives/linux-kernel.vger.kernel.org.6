Return-Path: <linux-kernel+bounces-550492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD65EA56046
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 06:48:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 098841761D8
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 05:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8378B19AA56;
	Fri,  7 Mar 2025 05:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wA76UBfZ"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF0D193084
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 05:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741326517; cv=none; b=rJUJtVe/c4iWH6JNYVbJ+pYa6NgmB0vn2ZhYv30IjWX1eZMNFOIPUBFlmTac6lC0cMHgI2l9fmklvL936abdjs8VxVbp6VjAtfep8QPFcEIhhePNJD2cZecESHwTjy8qMiDRyDq6UvlAzju3NDD25rkuH/DML4ln3knx3lSWYtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741326517; c=relaxed/simple;
	bh=f6dKyFo3BkLrXoBHgGJQ+69N8B1GLf2n1hpUnfgTQTk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OQYZyE4OgFwCw38H2sxLoOF3+w+anBm5mvupiAW2vYEG3fqmjDg/879WNb4eTEWvHkrrAySsgmIsr+mlqdK6Y+VKlSgyyY9d9+YVXnavRH2E/3JzI2JCfBQYtD5BcjpcbEeC41ETgW8RuCcgzvfn9lSA4JJ2yfgqhGOwliqt/NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wA76UBfZ; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-30bf8f5dde5so584221fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 21:48:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741326514; x=1741931314; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xIUlPQiEEjx7lB+nUPvIprXpkiiTW4hGNlxewbBn0Vo=;
        b=wA76UBfZpYjk3rMu1lPVCt20u3LkrLhjUqtW/0ulvv1aXaEyt4xK34uptr2jT+wNMF
         XydQjwgtFbYhWqHGaGXns9j49UDtxlpCkYpOVFs0KHPmai0POchOfkAOdrgi4WDyw4zA
         FIFutKWbUYv/XA++uzyM6Ho7K0LLuwk+gNTqVfCuHWSvEQd8mq+TiCwSKZ1bDnh9gl6v
         2lV5gkdQXpqqKocIVfcfTfKe8cX+/HGHQnMATr0uprSfS8NgRPtP0aXt5jD7nfXPLC/o
         tR8n0F+39fxZqYKjpvkv3kkLa9XBRotA2f1kp9LFpYRLk8TozZsJX8ZGdr56CL6LJU7a
         0QnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741326514; x=1741931314;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xIUlPQiEEjx7lB+nUPvIprXpkiiTW4hGNlxewbBn0Vo=;
        b=j58wRRAK4rC7snhjEXQ2hYIRGmjh1tEfrWeho5B1UUTgrGXbHwcWeGLuk+ew+WBBl2
         BPdVSaIfiQ/iUyTN2p3nMJ8L0IDJRs1a7bTMCjAfCBGWlv1GqMLJZeGV2WXKy7ySb+aB
         bHQFJK01155RTQIGLUeLq28CR/tKdlZydPhgxsZDB3EhhyvFALNLroRZPRoeBeOXtCJz
         rUnZxL9Rjjec6kveKVvx3mgGR1XWJg60Bsh/l+LiU3jLpfkrANDDNFQoggtywJw4ODt0
         iCrt78I4Hlqbi5VzMWOhsZdFF32PQRa3VLKTY1lQ44wcXOH25lv+oZMAxS60i3hogZNg
         pzMw==
X-Forwarded-Encrypted: i=1; AJvYcCUUYS7/XGve/5lgLJ5futVPHLbDVLuTWnXApErcoFnTb3oPsiNmiIAufYn1LZo64/zshJT99ZxNIfBYp+E=@vger.kernel.org
X-Gm-Message-State: AOJu0YykHNGTQYyWHjlLK8wzYyQAw1DfZpUTg3d7Da9aL3GgIY4r1rxI
	GnIXv2w9yCkzYW1WysPEl0Y8xaVv0XgqIghfImRk4GOuH50uWJx+IhMzeDJlIfY=
X-Gm-Gg: ASbGncsj5oJk/5zKjEG99YUlodq9Hn1xeiQXcTvZFaa7RgKaf+xb1kgd1sTnOgIhOnI
	FWmfWnp459L0tErnZbxfRcJDF9l9MXi+UpQrgnONY1dE20JHN/thNcX/hFWBgcFo+hNG2B6zPj6
	hxjUi9PTrUYPd3J19y4tnm9RWc74HDyzLCR9rsKZCtxcpSnj/bNsxHrxrmbfQBrWBGVSer8H6tV
	YVxWf+xOrEEkg5NSHuUIOMAESXgANJdAp+7PQaYVdJzx7BgLjYMkmIVfGyYDKqSJKsStK1P4MwB
	0GI3Pg2m3MLD4T7HqGElupkBRTnPmYs8XY80yiaGMxAdEX/Q8kXtttDmbHNYwtLsko/vNvs/c4r
	13qiO6Fz2jBuURFMslt3LUsPX
X-Google-Smtp-Source: AGHT+IFLgCjDUK+ssfV3W8fYXWF3IcyBRSZKJMxl/h3Pqf22SL2LHsOB83+2OXk5a+mSVQE5lVC+4w==
X-Received: by 2002:a05:651c:b2c:b0:300:2a29:d47c with SMTP id 38308e7fff4ca-30bf4606942mr5189011fa.24.1741326514230;
        Thu, 06 Mar 2025 21:48:34 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30be9a07204sm4342721fa.114.2025.03.06.21.48.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 21:48:33 -0800 (PST)
Date: Fri, 7 Mar 2025 07:48:31 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Robert Foss <rfoss@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Wesley Cheng <quic_wcheng@quicinc.com>, Christian Marangi <ansuelsmth@gmail.com>, 
	Bjorn Andersson <andersson@kernel.org>, Rohit Agarwal <quic_rohiagar@quicinc.com>, 
	Kyle Deng <quic_chunkaid@quicinc.com>, Vinod Koul <vkoul@kernel.org>, 
	Marijn Suijten <marijn.suijten@somainline.org>, linux-arm-msm@vger.kernel.org, iommu@lists.linux.dev, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	linux-usb@vger.kernel.org, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH 06/11] arm64: dts: qcom: sdx75: Rename AOSS_QMP to
 power-management
Message-ID: <zmy54zmhuai5vip7fvdjkf5hr2tsnmmh6ts2labnh3amkg4s2l@6pjfprdfxn56>
References: <20250306-topic-dt_bindings_fixups-v1-0-0c84aceb0ef9@oss.qualcomm.com>
 <20250306-topic-dt_bindings_fixups-v1-6-0c84aceb0ef9@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306-topic-dt_bindings_fixups-v1-6-0c84aceb0ef9@oss.qualcomm.com>

On Thu, Mar 06, 2025 at 07:11:18PM +0100, Konrad Dybcio wrote:
> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> The node is currently named power-controller, which requires the device
> underneath is a power domain provider. Rename it to align with other
> SoCs and resolve this sort of warnings:
> 
> power-controller@c310000: '#power-domain-cells' is a required property
> 
> Fixes: 91f767eb6938 ("arm64: dts: qcom: sdx75: Add AOSS node")
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/sdx75.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry


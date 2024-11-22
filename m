Return-Path: <linux-kernel+bounces-418105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FED09D5D44
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 11:27:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBD031F24E73
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 10:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 347201DE2AB;
	Fri, 22 Nov 2024 10:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eZGhi/jk"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B27171088
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 10:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732271235; cv=none; b=QOsV7rnv+jjMBiqPb+Uwj2jDZji0jv4RdZP/WDSQhLeAbzGkTQKBGBwc5ACsEzUcVoytwaVLTl40vKagdSGmNwvD6G52NzBkflVwhlDzHPfrz1PnlGCtF9nbKdiOwzstbZZh7YEJ0IDPouK+x8GASUdb0esORA0CSham/Y3WuoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732271235; c=relaxed/simple;
	bh=9rnoHHf3OGi/eM3PFl0xOISrBSYIaWx3KevI8ScfJOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K9p3DBOv+lD3ACxTbKAK1iN0etcsA8GEKMm3MZwcltNDvKaG3ZlSZxNcjkj92JJ3ZZJMdHyo4fn559mHPN6tD9F/sjD0/No3+s+eWIpPq7ahcTkEyvdoiZbZNpwubdCtdLxvsZcOE8DEr3xUjX0ed+0M1M4q2SpbJBDGotJgsns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eZGhi/jk; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2fc968b3545so21601881fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 02:27:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732271231; x=1732876031; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CaM32T9+cjWvYMHqhuUqWhjRL+hOdvCIE9xX19bPtjY=;
        b=eZGhi/jkeNormbm7r05AXsRa66h6vhrXVJ77ImSpaBc3Qn6a6AF5SGxRhiT5oya8H0
         jy9lGh3rJfAAUkFYy5DT6BUYl2l/f/d1/VuXsKU89bhSpDIM0Z2oJCA5s2pG4SiQGDJG
         QVtBDh4CfcCv3A4e+wlu/LyWSGGv6kCtSPhW9rW4ypaJ3cD3sjxE5f1ZUIovn8uAcEbp
         gIFUaTKlIwm/iyBgeEG/TETHoGQBmJNYyYqkZNlpr/4xRojOgD4GVhgDvZMOJQlLMDZq
         Y1LUpHtPFSg9tFOcFOzufHChHsnKG7PFa3G2hO597pl4m5TDMzllfVpCusjjC9CGN36I
         V4VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732271231; x=1732876031;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CaM32T9+cjWvYMHqhuUqWhjRL+hOdvCIE9xX19bPtjY=;
        b=G26ALnDFDVtR5YfzpIc1eqQH+/H2f0luOjjiu9FRuWrBG2C/2Mm4oPje0NGZRdhESK
         HvX9NFgMPZexYOoRFAg4Ly3iP4HB3zhN4MXezrRSfn4B1qf1qPMp95xIb5fZZv3icyeH
         fXJRkSPZmBn1xTrJBllRCL1gKQ8XZdLOcbygvfz2MDYCq+n3EqTu3olXcvmvtJOFfZ4v
         Di9N92CLnlmdZPEkMoMkJbevHW9XkUcYOJAE58lM2McMOYNNHsLjqNo85j+3SMO3sm6f
         HfgJiqYbQPks949F8p4cc5VqnDIaYIqu15sWTjGh0Oo8d8ru+rof4LQgVcuYedkieGoG
         gaxg==
X-Forwarded-Encrypted: i=1; AJvYcCVEiaA7CrQdt5dgWkXQ4IIBQ1HRxjerlGCqHOFCMm7KFw7ByJ136w11G+txQBf8jzF4hlsxnvTB/vbbrzQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxG1qyBemfM1RIOpztPMXvmTHqtaDUQV9LFd+pJJKFz4S+1e9V7
	G+ttZxxRyA/5/brXJLeWN/oEk5z8+mWHXl7bPq+DtBLGvl41dRGVBFKpTI3+Kno=
X-Gm-Gg: ASbGnctt2mzVQT5K8A0vmbVd8xJ+uqBsk9tNp5KN6DF2fswCH4KSrde4GlzVjazcRWe
	BIf3CLyJEcBecaBfWx3qNagFaMzmOpWlfmX9gd1irVb0lh6+tfQ6gK1cwm2Jq/6AraoH5PKS/Et
	pm1XhJlYrBdTvClX03V69ojWMshdL5QDXcJ7maCjIEsGyzqUDN8zVwak0IB+7C5BxkdYxotoWgU
	yeJ69a3PsYmGnXUpPheU8w8ErN1JJbyYWzTx0NLFnoPOQQGPUm+ua0Nx+unIsIIp1eA8HYcnB22
	Pd6xhkSVHE/N6XFcQCCApxbO2V5b9g==
X-Google-Smtp-Source: AGHT+IG3oQHashA6tpFb+9+NmJi4GpOI+M8h9JPqYyxeNcEzdxQdY5O2kg12XYaqyKtAV7A8h+5UvA==
X-Received: by 2002:a05:651c:198d:b0:2fb:5b23:edba with SMTP id 38308e7fff4ca-2ffa712dcb8mr11465241fa.23.1732271231158;
        Fri, 22 Nov 2024 02:27:11 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ffa7a65786sm2280291fa.63.2024.11.22.02.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 02:27:09 -0800 (PST)
Date: Fri, 22 Nov 2024 12:27:07 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Fange Zhang <quic_fangez@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Krishna Manikandan <quic_mkrishn@quicinc.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Li Liu <quic_lliu6@quicinc.com>, 
	Xiangxu Yin <quic_xiangxuy@quicinc.com>, linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 8/9] arm64: dts: qcom: Add display support for QCS615
Message-ID: <n7mnldqd2td2cm4uup6mlnmbzyg7unbzvert6kyweopplbfssz@vm3egater24k>
References: <20241122-add-display-support-for-qcs615-platform-v3-0-35252e3a51fe@quicinc.com>
 <20241122-add-display-support-for-qcs615-platform-v3-8-35252e3a51fe@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241122-add-display-support-for-qcs615-platform-v3-8-35252e3a51fe@quicinc.com>

On Fri, Nov 22, 2024 at 05:56:51PM +0800, Fange Zhang wrote:
> From: Li Liu <quic_lliu6@quicinc.com>
> 
> Add display MDSS and DSI configuration for QCS615 platform.
> QCS615 has a DP port, and DP support will be added in a later patch.
> 
> Signed-off-by: Li Liu <quic_lliu6@quicinc.com>
> Signed-off-by: Fange Zhang <quic_fangez@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/qcs615.dtsi | 186 ++++++++++++++++++++++++++++++++++-
>  1 file changed, 185 insertions(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry


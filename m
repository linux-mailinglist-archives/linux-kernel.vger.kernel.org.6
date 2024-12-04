Return-Path: <linux-kernel+bounces-431039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8D5F9E3867
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 12:10:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A59B9161CD3
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 11:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA83616F851;
	Wed,  4 Dec 2024 11:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AwF6CUim"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441271B218B
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 11:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733310421; cv=none; b=cQ7yLnWIVy5fjyzCrB3HZbeRtBGYfYMB7zziDRmu1oLSe6pPL3uoeit5mBrxO2sM/4IbqwMJN3Uzd+z27fJboC2KSLPtP10V+VnofBf7LTi49Coj8zZh/GlMLz2ei6rs8sGU7M3NU/THN1MtYG6lHTCv58Bgc+BzrS2twWWX2e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733310421; c=relaxed/simple;
	bh=E65WWkwNgLnXFkVJhkwVsz00upPotmr4Pfe+PM77E68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mUi0ElRaIiDuOVoRfKsiRCEex3eDQG/4fKnoMBLZdeYyMkAue5cT56xKsbhdYks+nVFOW/MlAsD3u9sG38c8mP7XC8Z6I61F164InTs+gxj2DgaM9gcMJF5nK8S5Ts1d7APMCqsGiQZcKyda5vVLTtFfdQCp0SIxrnYCe7oBAX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AwF6CUim; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-3001699fbabso5346651fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 03:06:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733310417; x=1733915217; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Frwodt7e80iVestTvU82jBPF1mauExxFI6AqVijqEjg=;
        b=AwF6CUimdgFE5Pc5NTsfZ2kgva8lQYAofkJAciTJcm8hk8fp7oo5Jut2rkh6NnILtH
         LKMQ16ThbY0cXsTsHxeZ3D7vbPI4kbi4zRFz+mjBZjBS39l9pOyD4tAh4wld3o7IzAMd
         Aa2lKHphSl9t3Dz7gwTpVQZD8MLZ9zRoaHyoD4wXh+WknS2QUzcvMUlh9m0kxDTcZAYf
         qIzjjmKw4w+R/58I7xulE5A5TbBC6xZVRvLyI37weeymWHnQurBCqGGIJnetYVhhB+q8
         JxTY+DnbQZim5mLgcVJA+b7J0FtXMzH2X5un2BZzo7SgZnMDdPE5HQqXjABV2XYT1Dyf
         yChA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733310417; x=1733915217;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Frwodt7e80iVestTvU82jBPF1mauExxFI6AqVijqEjg=;
        b=bvDlmx38+dlrbLBMpdoqfl0ZmnWDbCoYU37uYiAH5ntRHGhKLWBx5RtoMelV93PJ3J
         vX3R1ST0NDIQga8NQnExUr7pj3yJABKur+foGpUgQJ9uXTqrHXe7XC8j4HiS8HbsAq7Z
         Fdbi5ZUIpnbQwPMaoVREozdrG7GUo7+yCauNmARDzbyHHCBZPoScA75qxeUZe7cePenp
         8gGtmeaW1TdgXIntg7mjabplk8UHb6NA3KNHEopC5llCha47e4ibl1TISHOMiKSZT4zw
         w/tWH8/DRiFUun+67jc2fVFjpxlUeyMdMqD7lAO5B59p3z4Mv/yeHWv6FWwgCvJ1wiVx
         XJgA==
X-Forwarded-Encrypted: i=1; AJvYcCUu1+z8XNQTbrTEve25iYTL3SxWDS8iaDYyqLoY83Jbmjalz2a1oOch+YMAmWCwIeDft+6TyPROnVKW4GM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7s19ciD2D4hPf08NhmxNdvC+V3yk8zdXujjuVtQQ/WRpnL4C5
	kKVmFpmc0/R8WxOslmlFlEYKPjSYe8y+J6m+xSREiB8yV04PEZV1v80ceitMAcI=
X-Gm-Gg: ASbGncveNDhgFrnMSaQDxAIxDGFObzSB7NIhjoeww4TGXDgD3q9Fsa8PZPtaE4auFU2
	3G5d5bFRjVPbFr/JbHy0FqfAFSuN4NFzi3I1MWZAF0HafsXhqNu9zTRPgBIRjkeI5uvioafshrS
	iksB7G3EinKVjO1HIe7Lnkrh731CithU+cgdDZO8SdC/gjEvpZXH7Rk/c3Ugrzeksk3pT/XSEnX
	CLQMVNObeDbOg08tVjiqNbcMCDdc5UmIEJ2T4ABuIOQlfNmDmoIIA6sWkFiKICn+Bbs5sb9HPb1
	Wp3FLEn4bOmxgaf1brF4mES99Coq5Q==
X-Google-Smtp-Source: AGHT+IEMk4pFxAlr3TGP6UdHEhLOi9fl1THCZj9kUnw9vcRnkqFukVuUyiWzLySwmier7TkiwbynLw==
X-Received: by 2002:a2e:b8c9:0:b0:2ff:d81f:2d33 with SMTP id 38308e7fff4ca-30009ca9f84mr30152041fa.28.1733310417470;
        Wed, 04 Dec 2024 03:06:57 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ffdfca1c6esm19213481fa.104.2024.12.04.03.06.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 03:06:56 -0800 (PST)
Date: Wed, 4 Dec 2024 13:06:53 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] arm64: dts: qcom: sc7180-trogdor-pompom: rename
 5v-choke thermal zone
Message-ID: <b7ayn6kejzh3uaxcn5kfvrjdl5isiqei3uelf6yma7ap5c4gul@4qmnbdb6bix3>
References: <20241204-topic-misc-dt-fixes-v1-0-6d320b6454e6@linaro.org>
 <20241204-topic-misc-dt-fixes-v1-4-6d320b6454e6@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241204-topic-misc-dt-fixes-v1-4-6d320b6454e6@linaro.org>

On Wed, Dec 04, 2024 at 11:56:56AM +0100, Neil Armstrong wrote:
> Rename the 5v-choke thermal zone to satisfy the bindings.
> 
> This fixes:
> sc7180-trogdor-pompom-r2-lte.dts: thermal-zones: '5v-choke-thermal' does not match any of the regexes: '^[a-zA-Z][a-zA-Z0-9\\-]{1,10}-thermal$', 'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/thermal/thermal-zones.yaml#
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry


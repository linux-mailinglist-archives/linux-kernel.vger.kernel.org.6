Return-Path: <linux-kernel+bounces-306642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C4279641A2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 12:26:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD8FFB25FBB
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 10:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D47661B0118;
	Thu, 29 Aug 2024 10:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Kb0p23dP"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59449192B9F
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 10:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724926819; cv=none; b=Aqh6bFlV1KYwPwa4A+4SVH87fe2sjjwUlqAGa0HwABq8E+agLbrfl3fjE7N2TKFAJs88i740RS3EBEyok3UYF5l/iVehF2K0TYNlZGxpvMhFNP1ShaD4oOCZzEEnJPCunxM6jD0M33BgSZ/16llvA5SM6vgh2PZMCE8VRRZ6jPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724926819; c=relaxed/simple;
	bh=tgOcpVmvQXCxu7NePh+8gwUtN7BPJc+rBt5TEt61bec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=exnGQWoucsKQu4Cdxxm+s1Lyt2r4CsiLHlV9R8OtTK2BKOwtT5qOq09jgpt8FLyMBiVtsHx0AvYRGC0D82uoX5fTka/GJXXJL9YLsifb5UDf8T3dVyC95UsShAzsnrHk5d1SVOyL2Ab+UJw4y2f77HZShJjDgpKPs7hFGAtotWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Kb0p23dP; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-533488ffaddso652011e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 03:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724926815; x=1725531615; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wrajIhXQaQopFLKnkZnXz2AG7oLMmP4+sgXVgOrxL/U=;
        b=Kb0p23dPu84WVUqZLQv4ikqkvb7L8Ktec/6PHcJGd8YggWyugcaXnlqW/fAERsHazA
         yBOxRfv59ldQhfzYhd3wiZwP7kXia2sn2vdALWsJN7ApWYngzaWgE9wYzxy20pq7Ueda
         RPReQ0so8LJlnR7FF79zZsn7lXVNxpcreNem2XJLcf0zQuEYzI7B1oImg7wpuOIpRWF/
         RWdVTqekJyWqd2ARDwuXVvqnXFrsmuNYBrrSGKb6WMsprV2oTXEZHUKwDs6w/bh0zd+t
         HXv+LoAcj8w2Ip/VWjF5eaYocqN32NEWzvWFwKlCXHNX38AyvztmgFQXBL4BT0gkqn4e
         CUGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724926815; x=1725531615;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wrajIhXQaQopFLKnkZnXz2AG7oLMmP4+sgXVgOrxL/U=;
        b=RirEh0EHmH5vFs1ivWmzhPcNtKTDjkTd0dUwLlqdQt34CNqG/jIcek/Eo9GPrw9bnF
         tA7zWRVE63UCtOqs2215HjMwCz79Mhz19GZR/SVpAcqA1GpOb11PtRHygS4zN+M1qbLN
         2pMJpUG0TCQ4gpjtAW9krvpPuinZ+kHra+4ZkBZQ1VUTc/BrkH4k756qls3rr5gsAvhr
         VOjv4Hcg4uFY8TWZyykDG2RF45Oy6CuTeR5cEYw6Ytu/waHNsOy0o56vnwvJcXOii83N
         79aIxBx18E/NcQfLCAcSbWi/GP5nrGjk2GbYqNbFw9ha6RiLIQrcuGMe8bs1ThOKglsB
         QS6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUs4sbwSg5C3kf1l5mh1Vf2pg2LJjm6N0OTSG/5XvTb6y4xc3HFS9vOa7gRUQFCtk36SFVZfrSBwh6CaT4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuNob0RNwGXOBtNzHfglNKsOLZfQY5i79k7/rijWhXWFeSMdzB
	XiLnIg/j1PzgJHoL5/LWwuexoKbgdBXaVabzsCgIxk4KN5lY6kEBvbiDYgfDqqs=
X-Google-Smtp-Source: AGHT+IGbJEe7YyslXtC3ydJW1Ixn9oufFRsrPtJ5vi79qDwZh7xsZono3dYyuXuMnRBWgg+555Oeug==
X-Received: by 2002:ac2:4c54:0:b0:533:532:7857 with SMTP id 2adb3069b0e04-5353e5737b2mr1924088e87.22.1724926814809;
        Thu, 29 Aug 2024 03:20:14 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5354084176bsm113791e87.219.2024.08.29.03.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 03:20:14 -0700 (PDT)
Date: Thu, 29 Aug 2024 13:20:12 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: andersson@kernel.org, mturquette@baylibre.com, sboyd@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, konradybcio@kernel.org, 
	catalin.marinas@arm.com, will@kernel.org, djakov@kernel.org, richardcochran@gmail.com, 
	geert+renesas@glider.be, neil.armstrong@linaro.org, arnd@arndb.de, 
	nfraprado@collabora.com, linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, netdev@vger.kernel.org, 
	Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v5 8/8] arm64: defconfig: build NSS Clock Controller
 driver for Qualcomm IPQ5332
Message-ID: <63weij3x2gcss7dpatxeyx4xlqmjwc6cy2kqqlntxdz2ivbqlb@ljb4r4vw3zdm>
References: <20240829082830.56959-1-quic_varada@quicinc.com>
 <20240829082830.56959-9-quic_varada@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829082830.56959-9-quic_varada@quicinc.com>

On Thu, Aug 29, 2024 at 01:58:30PM GMT, Varadarajan Narayanan wrote:
> From: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
> 
> NSSCC driver is needed to enable the ethernet interfaces and not
> necessary for the bootup of the SoC, hence build it as a module.

On which devices?

> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 81ca46e3ab4b..2962bc079ddb 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -1307,6 +1307,7 @@ CONFIG_IPQ_GCC_5332=y
>  CONFIG_IPQ_GCC_6018=y
>  CONFIG_IPQ_GCC_8074=y
>  CONFIG_IPQ_GCC_9574=y
> +CONFIG_IPQ_NSSCC_5332=m
>  CONFIG_MSM_GCC_8916=y
>  CONFIG_MSM_MMCC_8994=m
>  CONFIG_MSM_GCC_8994=y
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry


Return-Path: <linux-kernel+bounces-308285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A2C9659CE
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 10:14:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6C9E2877DB
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 08:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B79C515099A;
	Fri, 30 Aug 2024 08:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GnTfo3jM"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA2E166F3F
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 08:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725005615; cv=none; b=Kn/oVXIaJe5ApQZY70amy3p4cualZHOjz880/7rtQikkoPRg7OBCG4yePCUyo7aN1NO4XtknDchzFbbky5Bbg6QONdV0h435ZJoETiRf2oepAkCpez9fYy3f+loG9j4SajLQKFrtI8uu2HOCtlosjcu4/da1Wbh2Klh+p2JJx0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725005615; c=relaxed/simple;
	bh=9lAJkqgaWF31Wo4W4580wuECtRVzMN8l2oXT5n9PbkM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FYWH6CAfX2pE4j0N84iNNeSujXvOAZ0yCC0fVkRj1/I0DlpbX8h54DVyXb63nLsQtwQfLHbRWr+4JIS0BtW69RTvGLAq7zhyBWmxw3YD/ULB0l7uqadlt+ybYIOrO7gJJ2j93d++4kuiS6DTDduzmyT9toSxtxokCOsYDfL6HYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GnTfo3jM; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2f504652853so17142841fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 01:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725005611; x=1725610411; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0Rd3vrhfsJ6l74liSsK8uI//rJ+lt5QFYUiOIWgOEvw=;
        b=GnTfo3jMU/SmEmvhgqJa/1KW0uVKTPR+FIXhvXq0Ms3qi2rgUboIyLRd+/PhK/2F/x
         VS3hLKP5fXov93AXJJChiWh8BjtkWA/53qTpnzFg/lp6FQUXoUcRXWE/qtMuROefBd0+
         blZ0AGDN4iXbpxGuGan1CLV0MDvpCmnOjnT8IZowrOpZLBdegBMtAcJ/0lLZqdP0kuvT
         v4wsGOOJJB76VzduOkfyNkMDiHVi+NurF/qRjvrspEVK74cB5YWhih64sUgE6ikeM6e2
         gC3LAnmBGk5tRbh4LCCb1WVX+C3wRUgJyNWKD1twaf/Ix1NUkdLvr92SX8TFZ0xx+kRn
         eVnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725005611; x=1725610411;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Rd3vrhfsJ6l74liSsK8uI//rJ+lt5QFYUiOIWgOEvw=;
        b=I91oGDi76iZ+FY88ETjDlQJn9z0nTGDvsxoolJ786Cle2TtNs6LKvsp2gPHEpz+3jG
         5EILGWjW34dQXlBCVIncoHeUDdtfeexyD8KsNU9d3bvTtORtOE8S9xDYIUlnHL8kn5XV
         NPOz7ROpAmvtrga8rIL4nxXQCKStUWCS8Ko7nRG5EJgHOnuKtIMav6mpvoxVvO/jM8OH
         U/xFWU+el21EqW9t22ZE/KvdRzb4aknb7j+bgyQXa8Vk4323QwciNkf86y35CuFIKq7M
         zYVM0LNUFRshMT9uEJVQwepuoB2DFG4jy6zzEKl9+A/XBVJOHhy/ij8Htyvw1LfP5+UQ
         iPhQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5XVM4G4sFrhv2rqUlN3YejXiPoT5P3IjNyZx0+Y+hNGot9Dji0ruuxAXd59DHQigZdjE2I2g3Yylspe4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTu2x5d2A6D2QmnIXK6cO43mEQqLrqEyyPcYM5rcGDZcRE9r+3
	RwiArytzPdG7LUsqPlNanRnfUFq5apNNEu4LEinWm4tlr+PJBgAR6JFFS/DE60fJGR0AgOviGHF
	L
X-Google-Smtp-Source: AGHT+IHxc5+G0BndaGsL2vRM9TegLDOnMydgCuBJSqgNQZJbkJofQqj7sLvluos8dVwzgjwNY2Lk4Q==
X-Received: by 2002:a2e:bea1:0:b0:2f4:f279:36d3 with SMTP id 38308e7fff4ca-2f61e0258f3mr11052511fa.4.1725005610510;
        Fri, 30 Aug 2024 01:13:30 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f615171c70sm5280001fa.85.2024.08.30.01.13.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 01:13:30 -0700 (PDT)
Date: Fri, 30 Aug 2024 11:13:28 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Danila Tikhonov <danila@jiaxyga.com>
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, cros-qcom-dts-watchers@chromium.org, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux@mainlining.org
Subject: Re: [PATCH] arm64: dts: qcom: sc7280.dtsi: Fix PMU nodes for Cortex
 A55 and A78
Message-ID: <5gmsbbnuc7sbkpptomvpl6aarw5poutvjfav5rilgogb7727vi@nhtr5m24tkmt>
References: <20240818192905.120477-1-danila@jiaxyga.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240818192905.120477-1-danila@jiaxyga.com>

On Sun, Aug 18, 2024 at 10:29:05PM GMT, Danila Tikhonov wrote:
> The SC7280, SM7325, and QCM6490 platforms feature an 8-core setup
> consisting of:
> - 1x Kryo 670 Prime (Cortex-A78) / Kryo 670 Gold Plus (Cortex-A78)
> - 3x Kryo 670 Gold (Cortex-A78)
> - 4x Kryo 670 Silver (Cortex-A55)
> (The CPU cores in the SC7280 are simply called Kryo, but are
> nevertheless based on the same Cortex A78 and A55).
> 
> Use the correct compatibility.
> 
> Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
> ---
>  arch/arm64/boot/dts/qcom/sc7280.dtsi | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> index 91cc5e74d8f5..ab024a3c3653 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> @@ -845,8 +845,13 @@ wlan_smp2p_in: wlan-wpss-to-ap {
>  		};
>  	};
>  
> -	pmu {
> -		compatible = "arm,armv8-pmuv3";
> +	pmu-a55 {
> +		compatible = "arm,cortex-a55-pmu";
> +		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW>;
> +	};
> +
> +	pmu-a78 {
> +		compatible = "arm,cortex-a78-pmu";
>  		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW>;

Shouldn't these two entries have GIC_CPU_MASK_RAW(), limiting interrupts
to the corresponding cores? I see that in [1] Rob used masks for older
SoCs, but skipped them for newer ones.

[1] https://lore.kernel.org/all/20240417204247.3216703-1-robh@kernel.org/


>  	};
>  
> -- 
> 2.46.0
> 

-- 
With best wishes
Dmitry


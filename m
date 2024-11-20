Return-Path: <linux-kernel+bounces-415641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B5E89D3970
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 12:23:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55857B2C0C4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 11:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 187D719E7E3;
	Wed, 20 Nov 2024 11:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jkOrSKNO"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AAD618EFC1
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 11:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732101143; cv=none; b=WW7+rX7gkwu9ctAjvMr1tpMiKhF3Rq2hRKN1GNTBKWL36PP1uIyulGFTXYmJt9/TPQQN5jIU+PJWdCJUAt2hbhOqc1osngKv/K+dM0G1hsuj23JLKYCmpyJ/hTBqJL1yg124uHv4S9N3/DqPKUBvL1Eht+DjEyildMRqPkiWYXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732101143; c=relaxed/simple;
	bh=sTIrY2sJNGWGUmHnCcr7JTspPdLcIuOEoGsMA3vi/Ac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sdacjpu2xsabwwvSlz8/Zo29s+aeyEjtNjgK29YWDXzHiLxhWrw6Uo9qILVbI2RBc7YdM3HLCrb+Zm0Ia+Ayq1yGx/Y1j5u8wT1Nous0id43CkvaHiESOFWDRUxzZsK071HpcwixNdhMhAYTGs5lFI3Eo/4OqaAH6PPatHVwdbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jkOrSKNO; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-539ee1acb86so4365219e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 03:12:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732101139; x=1732705939; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9rAN4nKbft5CXDCdEJ1vMSCwtZ3Xk9NEt+75Eio0hiY=;
        b=jkOrSKNOvhd4KEmR05+JcOOPANZBIjnVsJdMvjwLEph05EQFcMGLE0e8+XeXVmjGtR
         XK8u+JrsXjTfUexcYymHY184p/H7IhF5Jfkb2hDtp87O2nH4SDf1gnz8X0bYVu9wtSQ4
         1LWQAf4KTAnmCzjjVkdrIxQvb3Tfv8MuLkiyxiDz4maNS6rJ/Eq8V/rSfS1T4kIV91g+
         o8fdj80JSkIj+PCItTRh4r8eFlyvVHALoCTM5avbZI/Iw0NntHfl2VZvllmodAHURJoc
         puR4Ka4pGBUbAA4FoUamN4OpFYFT1Sn5FgWWnC9PgdUOI/YoJhLPnz1cZ/pd3blpEpXL
         3hfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732101139; x=1732705939;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9rAN4nKbft5CXDCdEJ1vMSCwtZ3Xk9NEt+75Eio0hiY=;
        b=J3tl1oYYGkJ9pBAvGKRUK1WdROd5pqDeIEHX8lpLCwD1vfUsrOaduBND8x0JQS4qW/
         sZLkGTqWbMCSlcnDNvMnOJtt5nsR7SO2stUdWCZS3jBt6IKsymgMvq5B117dtS9MZu/B
         TdjPCKVEjNO+s9FrAXxhBJs9iIWMe9s04IsPQUwa/Zt6ui/mCB20G35GE1Z59yS4+kvZ
         RQoZaMMKfhzL58YWT2VFbcGixwem/vvUwdEp4E62S2tgCTE2+ir16hQgWtKTzIZXTIRR
         R7JhL42IKaVEySklWvLXLtGNfGctf7z0lyGqxcJcZfTutUj33ryS0P+kpc2SXnIsADGP
         FCyg==
X-Forwarded-Encrypted: i=1; AJvYcCVQ0AAgTTSZwtW46qdjcb66cFL1/slPYG1tAakmBMnMCfWBAJXtwOVxKzS5KefCBdasDgKKr4dGlI6AfCE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJTIX7KVWe9QTC/KHbOENDiTZhPZ4syyuri8vhByAlM2Hmnx6+
	PKdFoGwvkgovlRS6UJMpriUAax/wL1w/Ld2dAhyb4isKPLvkrh7PWDcQMPOOs0WUm+nMKsmwKxJ
	h
X-Google-Smtp-Source: AGHT+IEluENj384Eah3BgM0n5k4aswo8bBzu/OLNpizzi4AQu1mRHvzrFAFcSCe5MSGLZJ52zq+atg==
X-Received: by 2002:ac2:4c26:0:b0:536:a275:9d61 with SMTP id 2adb3069b0e04-53dc1333a6dmr800517e87.21.1732101138711;
        Wed, 20 Nov 2024 03:12:18 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53dbd472335sm593024e87.184.2024.11.20.03.12.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 03:12:17 -0800 (PST)
Date: Wed, 20 Nov 2024 13:12:14 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Soutrik Mukhopadhyay <quic_mukhopad@quicinc.com>
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, quic_riteshk@quicinc.com, 
	quic_vproddut@quicinc.com, quic_abhinavk@quicinc.com
Subject: Re: [PATCH v4 2/2] arm64: dts: qcom: sa8775p-ride: Enable Display
 Port
Message-ID: <lkovymvjsbd44v2huij7paikvnmo7i7rrmkmvpha2wn5sc4hr3@ppr2dgvhzy6d>
References: <20241120105954.9665-1-quic_mukhopad@quicinc.com>
 <20241120105954.9665-3-quic_mukhopad@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241120105954.9665-3-quic_mukhopad@quicinc.com>

On Wed, Nov 20, 2024 at 04:29:54PM +0530, Soutrik Mukhopadhyay wrote:
> Enable DPTX0 and DPTX1 along with their corresponding PHYs for
> sa8775p-ride platform.
> 
> Signed-off-by: Soutrik Mukhopadhyay <quic_mukhopad@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sa8775p-ride.dtsi | 80 ++++++++++++++++++++++
>  1 file changed, 80 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sa8775p-ride.dtsi b/arch/arm64/boot/dts/qcom/sa8775p-ride.dtsi
> index adb71aeff339..4847e4942386 100644
> --- a/arch/arm64/boot/dts/qcom/sa8775p-ride.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sa8775p-ride.dtsi
> @@ -27,6 +27,30 @@
>  	chosen {
>  		stdout-path = "serial0:115200n8";
>  	};
> +
> +	dp0-connector {
> +		compatible = "dp-connector";
> +		label = "DP0";

Thundercomm's SA8775p RIDE platform doesn't show such a connector. At
least not on a device advertised on the web pages.

> +		type = "full-size";
> +
> +		port {
> +			dp0_connector_in: endpoint {
> +				remote-endpoint = <&mdss0_dp0_out>;
> +			};
> +		};
> +	};
> +
> +	dp1-connector {
> +		compatible = "dp-connector";
> +		label = "DP1";

Same comment here.

> +		type = "full-size";
> +
> +		port {
> +			dp1_connector_in: endpoint {
> +				remote-endpoint = <&mdss0_dp1_out>;
> +			};
> +		};
> +	};
>  };
>  
>  &apps_rsc {

-- 
With best wishes
Dmitry


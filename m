Return-Path: <linux-kernel+bounces-194106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFB868D36AD
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 14:47:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E93D28614C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 12:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA6694C70;
	Wed, 29 May 2024 12:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sg5GxleY"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41466DDC9
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 12:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716986863; cv=none; b=tcxECSdEYoXLVmIkM5F5b2nePZzIcFMTSc00FESFz9IcJPhdJjl/bo0IAG/DpWnHYN6UQF4cs5dRI/IXknXSK8J+CljtHwGdtHpkuwuSxTfuJRM+gRNNfhXZMh8yU0VTZSXlEwcJQmBTxF2YQgdZ7s3I3caAOffcEKdFMo5dsm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716986863; c=relaxed/simple;
	bh=jcMBfdCk8jTQZro4OJJak9oCrCRDjhhjc86nMkCgIdk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hEfazWejKlye/GR/OGBp12CVnyRS7vo63ZxSrXD7wSNGWKK86It0svD4GQLiszMmUYQLu6D7XGSfbL5yMe98lp5s7XxaViS5w1Swke/1LYrpArP6c2ixg2E/SiKt5Y9KN+8d20w7nw+QEE9rKZyysGbaoCySUPS0HhO+aE/TOcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sg5GxleY; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-52a54d664e3so969949e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 05:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716986859; x=1717591659; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QG9S5GCq0rk0/aIqTkyWvwtUd6kWwmDiBTyVJ1zhLEs=;
        b=sg5GxleYsseQ4aXjw6eXYkhPcRGESBXIhIwcO9nY+30YY0Th2++cNehQQ/Z4LCHSTb
         JWWZUN8E7vOCcS9Z7V7MN49yfn7jHHsiBmTbek801j364DWlcHm+y2eRNyPBaqDLTzWH
         xDNSapC9ieG9bC0hOqsef8JJUQtrpuQD+csLu6UGntresVLBmWTLrmIy+rw9281YcNPh
         szcj3RF+QyYrV1DA7uIEgNVWCmnophLCNqhNpl5SAGr6AN4Muicdm4BNLoUq+JFHMjDf
         IIR1nY2u5t4kNeKAYb1a5P53pvtUYr8NwjLwwZhr39b3m6t7c5q0SliXTxw333/S4EE5
         urow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716986859; x=1717591659;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QG9S5GCq0rk0/aIqTkyWvwtUd6kWwmDiBTyVJ1zhLEs=;
        b=V9Y98QI2jx4xGw+8p/zt8VwHrG2pMHVXYQ4LKC1pGk2DTWkh5mjpKRCaiOp/MjcwmO
         HGNeWEZ10Rry8n0FCaLiYeoVhkXlqhtii5SoRx3gUudgyLAXbM//HaEq/kXcauuJwXHo
         Ds5GZe6Q3gH3yM+NQFUciYawJLGI5FyU4x1m3at1STDAOz3+rJnNCSq+SZ2RTKqD1rkE
         cJi+rZiVhCrItountV3pOvII7wZnjN820m4esRMMVkMW1seDQnd2IVt7FuOUqxKYXU+T
         mBXKg3NT/UFPq/3XCEZ2egQCyJFGOkX35pRxx16H4OeQ1UM4M0J/tI5Br7FSqhWcC53M
         IBaA==
X-Forwarded-Encrypted: i=1; AJvYcCXjtVsZNmVoaNuNiFlW5Kpx29B1XjGUJLFaKE2+4xgqJPEg4fgVms1yozh5JrPr9oMXYaxLI6rLnbeg7U80RqrMu5Cvt8CnOPbDwG00
X-Gm-Message-State: AOJu0YziBF3g+bOw0RngczwWBw3x2gDVZDw46hvnLo01s/B+pQxjJiWj
	T7q/CSUOKa0/iAmWnVDlxrS4oKkN6mge0p66OxEmTdVy/KVmQyybfC5mvs+W5v0=
X-Google-Smtp-Source: AGHT+IE82XWdPiGv9vygcZmvhos4VtSHC4qhhCVstpP+iimngdvKDpuoCuYWp8vrcqOHOldc3cHYEg==
X-Received: by 2002:a05:6512:32c9:b0:523:9747:4920 with SMTP id 2adb3069b0e04-52964bb1750mr11083799e87.36.1716986859316;
        Wed, 29 May 2024 05:47:39 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52970c332c5sm1264770e87.189.2024.05.29.05.47.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 05:47:38 -0700 (PDT)
Date: Wed, 29 May 2024 15:47:37 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Tengfei Fan <quic_tengfan@quicinc.com>
Cc: andersson@kernel.org, konrad.dybcio@linaro.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@quicinc.com
Subject: Re: [PATCH v2 1/2] arm64: dts: qcom: sm8550: Move usb-role-switch to
 SoC dtsi
Message-ID: <ljwkn7ilsixrww4vt7cmnmtot6qgihqglasoaftuil6i37qsxi@ia4bpqhkulwo>
References: <20240529100256.3158447-1-quic_tengfan@quicinc.com>
 <20240529100256.3158447-2-quic_tengfan@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240529100256.3158447-2-quic_tengfan@quicinc.com>

On Wed, May 29, 2024 at 06:02:55PM +0800, Tengfei Fan wrote:
> The usb-role-switch is SA8775p SoC property, so move it from board dts
> to SA8775p SoC dtsi.

The commit message doesn't match patch contents. Other than that LGTM

> 
> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sm8550-hdk.dts                     | 1 -
>  arch/arm64/boot/dts/qcom/sm8550-mtp.dts                     | 1 -
>  arch/arm64/boot/dts/qcom/sm8550-qrd.dts                     | 1 -
>  arch/arm64/boot/dts/qcom/sm8550-sony-xperia-yodo-pdx234.dts | 1 -
>  arch/arm64/boot/dts/qcom/sm8550.dtsi                        | 1 +
>  5 files changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8550-hdk.dts b/arch/arm64/boot/dts/qcom/sm8550-hdk.dts
> index 31f52df6b67e..411de3451db8 100644
> --- a/arch/arm64/boot/dts/qcom/sm8550-hdk.dts
> +++ b/arch/arm64/boot/dts/qcom/sm8550-hdk.dts
> @@ -1255,7 +1255,6 @@ &usb_1 {
>  
>  &usb_1_dwc3 {
>  	dr_mode = "otg";
> -	usb-role-switch;
>  };
>  
>  &usb_1_dwc3_hs {
> diff --git a/arch/arm64/boot/dts/qcom/sm8550-mtp.dts b/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
> index 42d4d558b7aa..84d16227ef80 100644
> --- a/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
> +++ b/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
> @@ -948,7 +948,6 @@ &usb_1 {
>  
>  &usb_1_dwc3 {
>  	dr_mode = "otg";
> -	usb-role-switch;
>  };
>  
>  &usb_1_dwc3_hs {
> diff --git a/arch/arm64/boot/dts/qcom/sm8550-qrd.dts b/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
> index 2ed1715000c9..e20c6240f76d 100644
> --- a/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
> +++ b/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
> @@ -1117,7 +1117,6 @@ &usb_1 {
>  
>  &usb_1_dwc3 {
>  	dr_mode = "otg";
> -	usb-role-switch;
>  };
>  
>  &usb_1_dwc3_hs {
> diff --git a/arch/arm64/boot/dts/qcom/sm8550-sony-xperia-yodo-pdx234.dts b/arch/arm64/boot/dts/qcom/sm8550-sony-xperia-yodo-pdx234.dts
> index 92a88fb05609..6dd5232da9f9 100644
> --- a/arch/arm64/boot/dts/qcom/sm8550-sony-xperia-yodo-pdx234.dts
> +++ b/arch/arm64/boot/dts/qcom/sm8550-sony-xperia-yodo-pdx234.dts
> @@ -739,7 +739,6 @@ &usb_1 {
>  
>  &usb_1_dwc3 {
>  	dr_mode = "otg";
> -	usb-role-switch;
>  };
>  
>  &usb_1_dwc3_hs {
> diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
> index 79311a6bd1ad..8e3ce1152211 100644
> --- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
> @@ -3264,6 +3264,7 @@ usb_1_dwc3: usb@a600000 {
>  				snps,has-lpm-erratum;
>  				tx-fifo-resize;
>  				dma-coherent;
> +				usb-role-switch;
>  
>  				ports {
>  					#address-cells = <1>;
> -- 
> 2.25.1
> 

-- 
With best wishes
Dmitry


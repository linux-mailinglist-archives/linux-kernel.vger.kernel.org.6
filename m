Return-Path: <linux-kernel+bounces-412997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF739D1280
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 14:57:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 242E6B2A6A7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 13:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4CCA1BD9F2;
	Mon, 18 Nov 2024 13:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wWSbWPK+"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536711BD9CF
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 13:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731936800; cv=none; b=iQvJqxkv+hOP/KpYTxYpPA39awElGhYUlpOtZrHHrChDIymcgDSqPlBHmCbyRpnYEopCda+HfEbr02SK6jwzhDSod75yL87+WTwVR+Tx4zZ/Z+Z0glMBjZbJYKaYxbcVt398qKl/XR3TBV/GTmDE5lQLnPCH4bKSz4bFJZawc+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731936800; c=relaxed/simple;
	bh=TgmUVsPMSMHETM7FdaiksN0XJk3FK3AbAIFHD0azkQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sArlnBhs2OnjmQwYo957SLZUb6Lcc7nZHOqi6Zx4mMYozU9b6Jvrx+hRR7CF4tCOy6OdEolhBcbq0YLd+sMWrihvEcgRSWqLG1unrnSTEFwCqPbTXmYJPT5rjBqGHDpODYmjhj2ATC2IqtupNFL5BrFEJXUSa63CcvKL56cHX8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wWSbWPK+; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-539e59dadebso4974112e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 05:33:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731936796; x=1732541596; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=i+Vhl0S++O1wuqZ1GQhDM+LsTf+4mTogEFPpDCg1R9A=;
        b=wWSbWPK+Er04JEJlX1GNCNHI2OUGkoWMgRY44L7ZS2XFKEFOoyUcrkaxeNaAlrBp7V
         ZWWc5fww2F6OfyHv1hOgEzE1vDBDCSS7stVIg3D/qEVLagyPPMVnAs3c7l/2aLS3r49M
         PApe8K2lZieg7BX5plECimTnd+WglCWkOp4Q3+SOfsJmQYM61EhRvV5nyKl5bZsbxLMZ
         VIsFGZedPJ+iLF4sab8fz0QeFMX6nb2gea0wzrWtJ4IExomm+9XFqcVKoKyWqRNiUNRm
         6ygpg9fIhdTb2OYSGGfg5F5j0hFjxa+0Mu44+Oaq8UyTW9EQtZXGNkBiJeKcJFEt4IM6
         iAFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731936796; x=1732541596;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i+Vhl0S++O1wuqZ1GQhDM+LsTf+4mTogEFPpDCg1R9A=;
        b=LW3+8WudYM5iTBifOf2CMF0X/L+kVngZfyoLd1GCyGaib50xRFWRmTYLxUkLRBmGU2
         wni26uQMmutWG29qIG11Jkd69Y4T96kJgGN7zaj/lkvTAGaEC5gZvRilnErM8lGDe/7o
         nsFBZjBkUPvq4B5sjfTCO8ei2sNNPaSZOKQ8RO83afPNV7tdGXbUHS5dgyi9YtXVxTjh
         8vUnGLn82ztuLff8pe642YkfESBMAbHRUcHQs5zdgmpfhxDhexzdEwQtJaEW2DT0Zba1
         4Nyk/tY3TUQoZa9kxVtrd7IV+n5X1okaFIck8Xcx3DLrHvacS7ga3a5Gii1jH9SmF1+f
         Jtkw==
X-Forwarded-Encrypted: i=1; AJvYcCWPjAZMnx/HftnTnhGCJjgJtoptIa+XZ/zSM0ijEIUQdKLbq8XktSLz6j/9KSV6PRMx/1js2/HfFsXHKck=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtindCs3yqeuVvZxm0s7D0GNUDqebqB1NBIkBz/HfP6srHlUeo
	jwIXZjms7pu2tXU2Emy8S56ONhb7anT+eNt1jkwFQixrG8lDKVstDL43HNyaxcxHSRO2yPFyBi+
	v
X-Google-Smtp-Source: AGHT+IHu40yDxzITrCG6MZokxNtKNL4VtYlvcUKgdjRSp6+abmjx6Xy0uqkTzl1mkiLfFZT8QaxvXw==
X-Received: by 2002:a05:651c:158f:b0:2fb:5168:1a0c with SMTP id 38308e7fff4ca-2ff6095e53emr53044441fa.19.1731936796455;
        Mon, 18 Nov 2024 05:33:16 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ff69ae80basm9646601fa.81.2024.11.18.05.33.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 05:33:15 -0800 (PST)
Date: Mon, 18 Nov 2024 15:33:12 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Ling Xu <quic_lxu5@quicinc.com>
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, quic_kuiw@quicinc.com, 
	quic_ekangupt@quicinc.com, kernel@quicinc.com, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: qcom: qcs8300: Add ADSP and CDSP0 fastrpc nodes
Message-ID: <rzecwzfvywp7rtjtdhtyajmfquvpwwyrcyzegzxb2djuw7ml7i@uldmr35hwnjn>
References: <20241118130343.3675277-1-quic_lxu5@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241118130343.3675277-1-quic_lxu5@quicinc.com>

On Mon, Nov 18, 2024 at 06:33:43PM +0530, Ling Xu wrote:
> Add ADSP and CDSP0 fastrpc nodes for QCS8300 platform.
> 
> Signed-off-by: Ling Xu <quic_lxu5@quicinc.com>
> ---
> This patch depends on patch https://lore.kernel.org/all/20240904-qcs8300_initial_dtsi-v1-0-d0ea9afdc007@quicinc.com/#t
> Changes since v1:
>  - Remove duplicate cdsp fastrpc nodes
>  - Add adsp memory-region and vmids
> ---
>  arch/arm64/boot/dts/qcom/qcs8300.dtsi | 81 +++++++++++++++++++++++++++
>  1 file changed, 81 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcs8300.dtsi b/arch/arm64/boot/dts/qcom/qcs8300.dtsi
> index 2c35f96c3f28..fdfec15f606e 100644
> --- a/arch/arm64/boot/dts/qcom/qcs8300.dtsi
> +++ b/arch/arm64/boot/dts/qcom/qcs8300.dtsi
> @@ -5,6 +5,7 @@
>  
>  #include <dt-bindings/clock/qcom,qcs8300-gcc.h>
>  #include <dt-bindings/clock/qcom,rpmh.h>
> +#include <dt-bindings/firmware/qcom,scm.h>
>  #include <dt-bindings/interconnect/qcom,icc.h>
>  #include <dt-bindings/interconnect/qcom,qcs8300-rpmh.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
> @@ -762,6 +763,38 @@ IPCC_MPROC_SIGNAL_GLINK_QMP
>  
>  				label = "lpass";
>  				qcom,remote-pid = <2>;
> +
> +				fastrpc {
> +					compatible = "qcom,fastrpc";
> +					qcom,glink-channels = "fastrpcglink-apps-dsp";
> +					label = "adsp";
> +					memory-region = <&adsp_rpc_remote_heap_mem>;
> +					qcom,vmids = <QCOM_SCM_VMID_LPASS
> +						      QCOM_SCM_VMID_ADSP_HEAP>;
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +
> +					compute-cb@3 {
> +						compatible = "qcom,fastrpc-compute-cb";
> +						reg = <3>;
> +						iommus = <&apps_smmu 0x2003 0x0>;
> +						dma-coherent;
> +					};
> +
> +					compute-cb@4 {
> +						compatible = "qcom,fastrpc-compute-cb";
> +						reg = <4>;
> +						iommus = <&apps_smmu 0x2004 0x0>;
> +						dma-coherent;
> +					};
> +
> +					compute-cb@5 {
> +						compatible = "qcom,fastrpc-compute-cb";
> +						reg = <5>;
> +						iommus = <&apps_smmu 0x2005 0x0>;
> +						dma-coherent;
> +					};
> +				};
>  			};
>  		};
>  
> @@ -1361,6 +1394,54 @@ IPCC_MPROC_SIGNAL_GLINK_QMP
>  
>  				label = "cdsp";
>  				qcom,remote-pid = <5>;
> +
> +				fastrpc {
> +					compatible = "qcom,fastrpc";
> +					qcom,glink-channels = "fastrpcglink-apps-dsp";
> +					label = "cdsp";
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +
> +					compute-cb@1 {
> +						compatible = "qcom,fastrpc-compute-cb";
> +						reg = <1>;
> +						iommus = <&apps_smmu 0x19c1 0x0440>,
> +							 <&apps_smmu 0x1dc1 0x0440>,
> +							 <&apps_smmu 0x1961 0x0400>,
> +							 <&apps_smmu 0x1d61 0x0400>;

This still doesn't look correct:

(gdb) print/x 0x19c1 & ~0x440
$1 = 0x1981
(gdb) print/x 0x1dc1 & ~0x440
$2 = 0x1981
(gdb) print/x 0x1961 & ~0x400
$3 = 0x1961
(gdb) print/x 0x1d61 & ~0x400
$4 = 0x1961

> +						dma-coherent;
> +					};
> +
> +					compute-cb@2 {
> +						compatible = "qcom,fastrpc-compute-cb";
> +						reg = <2>;
> +						iommus = <&apps_smmu 0x19c2 0x0440>,
> +							 <&apps_smmu 0x1dc2 0x0440>,
> +							 <&apps_smmu 0x1962 0x0400>,
> +							 <&apps_smmu 0x1d62 0x0400>;
> +						dma-coherent;
> +					};
> +
> +					compute-cb@3 {
> +						compatible = "qcom,fastrpc-compute-cb";
> +						reg = <3>;
> +						iommus = <&apps_smmu 0x19c3 0x0440>,
> +							 <&apps_smmu 0x1dc3 0x0440>,
> +							 <&apps_smmu 0x1963 0x0400>,
> +							 <&apps_smmu 0x1d63 0x0400>;
> +						dma-coherent;
> +					};
> +
> +					compute-cb@4 {
> +						compatible = "qcom,fastrpc-compute-cb";
> +						reg = <4>;
> +						iommus = <&apps_smmu 0x19c4 0x0440>,
> +							 <&apps_smmu 0x1dc4 0x0440>,
> +							 <&apps_smmu 0x1964 0x0400>,
> +							 <&apps_smmu 0x1d64 0x0400>;
> +						dma-coherent;
> +					};
> +				};
>  			};
>  		};
>  	};
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry


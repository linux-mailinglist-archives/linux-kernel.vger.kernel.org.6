Return-Path: <linux-kernel+bounces-433206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 881AF9E551F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 13:13:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2726E18838D3
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 12:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB38B217F43;
	Thu,  5 Dec 2024 12:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bXITlRob"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A796B217718
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 12:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733400791; cv=none; b=Yq1eZKjG0BiAiTUZYLNPxJAOFtlRkrI3jMIhm9Nw4fDGP45neyo7tGFgzRLfxY7CVh4jvQG+kjC9N6dILLEPiF5qS5UMVt5xYP8F6F7NrGkg6/lU+xdOExzji3cCi/zsBBjx1E8DYtejHh6A1SOOlenJV/CjuDOjLdRu+kVOAvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733400791; c=relaxed/simple;
	bh=sHboXScQQp3WVNf3+fBRjPqQ6bd3yAYGJGxj1YWQxLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kBmM7wRK0MqD3beaUfHRjLvgJV9p9L7DBsYT6Jf8fXTMxJvmskp4rYpA4h5OY4xuU3aFKV7K9SsBe51Mu0Z18X3WG5SCxNRKrkl9WV82g/RYhgo+q4u7kd4g3dnrsH0xyse6sGTDXCxlE+U5m85m5t5ASnYHmaCoSEFrNwJYfYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bXITlRob; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2ffa974b2b0so6984401fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 04:13:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733400788; x=1734005588; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vwrzwX+VjMp3rjgyMNnFp0aWkMg9bE4xU/GitUl2qDI=;
        b=bXITlRobOZZnemPXHadM7zA38iH8zx9yqh4fFNPtCJuJNwr2DDB0yEaU9mkq1RH2nD
         7O8aOCyT8k+HWqjNmdI9LkwtPHF/ryXUcSBLE9ar6bXCPOpNVxqKnNuVE09/Bny3K2vJ
         TozLQPr0GYj3BJZoAJju9E0RKUCXMy7e7jwk+jPu5rk9DDlGZopkvlpOgn4vh+ui2Mud
         jJE214tnlfJgCoFHdsZV5ICzUH1PnzB9XNMUAh+kGJemCb08rcwxdfLax8/c4uAXVayw
         pWVGiV51HwbUbOF5RaXoPbaVKElP/pNRQAM+rxoxM8Tbh8gYri7yK6GDFIgzsy3PM4jb
         72RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733400788; x=1734005588;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vwrzwX+VjMp3rjgyMNnFp0aWkMg9bE4xU/GitUl2qDI=;
        b=ijVPl0MXBXdYkhn3yyOyomOB6l+FDmPU9iNez4U4MOqM1NWi1JWVYPI119yTm6mtFQ
         SvGxw0xHjDDGmN38XD/Poehy3qYFENR9y6i1b+tPuocO2kBdC1qwQIiHsaHDjZe9fIM1
         Oan8seVKJ3NqAJ7J6nUxTcHm25GutKsXSUFuJIrf4PxCUHNJki/VyuGJPfIJpUlU7nSy
         f7heduR2Oa+jSqvWUf5/sdRzXCdqx23Uxc3g4PHQGCtBNw9Uef4cE4EunURvAY7J3eBd
         MCPbtXuSktGVJW75+rpWFYbP3LWBBnCqK40OdSSeC82eUxJbcZaEJvrd4pckmJuNLwiA
         hNzA==
X-Forwarded-Encrypted: i=1; AJvYcCVlFnf5VfTi2TcEMUlz7rnXEH97px98AsUKF8OHgkCx/q7WOEjhiDC8IPv1cDl4MJSReaxpCzWfyhU6gJQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKH4pQyneLM23gWUTU5FYihGeIsrrrCIHTf6YRhesu0bSWkk1q
	6Py6kOfPVkmedeGQ1VtEUFHecy6PFoAyHtuvGrGlE1uoLuwE5dHnZ7kUlLtMmgw=
X-Gm-Gg: ASbGnctBVcv2UoPeWGwF5fo6xkv5euzOv3H8GhZdEpDblAL9k54KRdYunNr2on9hEQG
	qwlxIyRpdAJKeponcQf2ZKt4cdq3FMsADB9YC5LIva/LYCOpa0C4Fe6D8SofjGDs0lYdx9MLZI9
	h7ojvjGHcGSvA/Eap9VMJUsv8h5umsMFCtbdf/nUpJdiZmbUawydLBoHOo1BdVgzI7fPu6/Z8gq
	fbwea2SnorRgxZpUHB/p5AuSRx0PYtD2YXwNuDuN9AXqUyTiRpiLR99RGBEvcUPxDKpU8BiSGgC
	HY28Z0SktyxeFlwq6tPXy9PCEsWUCg==
X-Google-Smtp-Source: AGHT+IGIy5upWqQ/8rBXR0DSluBGUFaFQ1r+E84LOe3qMZ/THup3+2GJi7v+gFPtvdOWb134Dp/BPg==
X-Received: by 2002:a2e:b8c7:0:b0:2ff:c69c:db0f with SMTP id 38308e7fff4ca-30009c8abf3mr63428231fa.34.1733400787878;
        Thu, 05 Dec 2024 04:13:07 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30020da27f1sm2063141fa.37.2024.12.05.04.13.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 04:13:06 -0800 (PST)
Date: Thu, 5 Dec 2024 14:13:04 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Cheng Jiang <quic_chejiang@quicinc.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, Rocky Liao <quic_rjliao@quicinc.com>, 
	linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, quic_jiaymao@quicinc.com, quic_shuaz@quicinc.com, 
	quic_zijuhu@quicinc.com, quic_mohamull@quicinc.com
Subject: Re: [PATCH v3 3/3] arm64: dts: qcom: sa8775p-ride: Add firmware-name
 in BT node
Message-ID: <kgxxykbogtdfsnkyk3f5mpht54o3siqkhkfji5nqo7cyck44rf@x7kb2otqdo7n>
References: <20241205102213.1281865-1-quic_chejiang@quicinc.com>
 <20241205102213.1281865-4-quic_chejiang@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241205102213.1281865-4-quic_chejiang@quicinc.com>

On Thu, Dec 05, 2024 at 06:22:13PM +0800, Cheng Jiang wrote:
> The sa8775p-ride platform uses the QCA6698 Bluetooth chip. While the
> QCA6698 shares the same IP core as the WCN6855, it has different RF
> components and RAM sizes, requiring new firmware files. Use the
> firmware-name property to specify the NVM and rampatch firmware to load.
> 
> Signed-off-by: Cheng Jiang <quic_chejiang@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sa8775p-ride.dtsi | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sa8775p-ride.dtsi b/arch/arm64/boot/dts/qcom/sa8775p-ride.dtsi
> index 3fc62e123..e7fe53d95 100644
> --- a/arch/arm64/boot/dts/qcom/sa8775p-ride.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sa8775p-ride.dtsi
> @@ -857,6 +857,7 @@ &uart17 {
>  
>  	bluetooth {
>  		compatible = "qcom,wcn6855-bt";
> +		firmware-name = "QCA6698/hpnv21", "QCA6698/hpbtfw21.tlv";

And the rampatch is not going to be board-specific?

>  
>  		vddrfacmn-supply = <&vreg_pmu_rfa_cmn>;
>  		vddaon-supply = <&vreg_pmu_aon_0p59>;
> -- 
> 2.25.1
> 

-- 
With best wishes
Dmitry


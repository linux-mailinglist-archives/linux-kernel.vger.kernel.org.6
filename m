Return-Path: <linux-kernel+bounces-359036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 150D29986A6
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 14:52:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3AAA1F22DF8
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 12:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4A561C6F57;
	Thu, 10 Oct 2024 12:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dk3NdRHO"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CFE21C2DC0
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 12:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728564733; cv=none; b=h5CjUzd3w7kyqvDum8ofeTcp6BpQbeVjjJ0H/OSC9JsUY70z79vaceAB+QGTOwa5pv5W3TrkbQOE94aXWXi1yaAlbD6I+tQCuFL+iDFYED9fsmrVTwsco1cCW780IT/F05rUuE19fUHD8ravwAfwX6Rpc2Nn2nMQat+4QDGgt8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728564733; c=relaxed/simple;
	bh=EwmZ5/Z+UThPK21bqO00znJM+uCq1XTHwYWQ1A/6uZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KByhBQLViFoh+3BHcdKhvWkUuS1mnpNMWjsanTf3w7STPFmey6j2KeaLTVEKqTuA1vSzGa2WS4gxHhSp/Er+y8q+fFDkm43wSbX7Tbye2bAZkZZRA4Tgu5mUrcjjVX0zalNWr59bFkatDBMve2DF9bLwsejcHoRFcF01ccXqQeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dk3NdRHO; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2fabfc06c26so7500721fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 05:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728564729; x=1729169529; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gbPdTZYOr9+jukOclQOWDxW0Bv1v/+wCabMme/SKc0A=;
        b=dk3NdRHO8XtT4a9GWtRoI+c+n8hgrtcQJRVmHzHxZCTAV1zL2ZQ/hsICbK8TP8yaX3
         lyzNAYBnOolt8DJyiTKnrIFFsD6ERQ+GNleHXy+NWt1McW0ppyKddEBFidR9UQcRA08g
         aC1TVBxMcosxGqHau8SG0VTLieDbw/iFJovTLnZxdJaUacN2/z9i6v+ZsnBOWSIc31Vt
         8vbTEY+UOJdn3zj9rhvY2Ava5/WMXZjC/fx2C4/RQS5usex0hu9jFtAU3fB9caN728tU
         Q6sK843AXSXWyvTe3QqhqE6An8VuIAnqR1DliClAzSdC0/u8ySbJP2w+C/i2ToL83J12
         Owrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728564729; x=1729169529;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gbPdTZYOr9+jukOclQOWDxW0Bv1v/+wCabMme/SKc0A=;
        b=FRl3Xpuv769Q3UJg8Zet6wQT2dYQnUh9sELC2/AGvE7ZTdw6r5CsLvTH5aFmoCycTr
         7kNip2/2dyFA/U5swDC3HlZrrKe489mYq4SID/15eGJbCgndx/i8uq8OykvzNAiszBx4
         AEVMCpwXtAXgB2h/H3AobVGAFKmqPx6+Pr+K5QDjY8PjbK7Kr+a8ehj1vlGUR5KwQ8VY
         it+M2iUDe78vRjgzPhNWC/OJh3CkMUVAGjzJrcis2iWEW7xyYbMeY/MATIgxsmemao6S
         1LBhQNA1BNtNb3mDgcXrAliONvTQ/OhBEmwYsHBiQfwb4YyRvu0Lz/5XZr8M3ecboRuj
         2cnA==
X-Forwarded-Encrypted: i=1; AJvYcCUOFplh0D784X6WxCt/D2i+m8P0bO+Q7j2hn3Yw01gITznec1IbdJKj8kY4z1wvrlhCuSODzTwZM+YHjOo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzzaJSyiqL2+0vuoU2WhkNwuDtvyikRvx1GLKvARxLIhlJ5gEf
	xdPJxE9MPmaHGElq54eaZKQzahcm4vcPJsV6Xq4DOqwqEeR3Q/11o77kN+QJmPQ=
X-Google-Smtp-Source: AGHT+IEEUTMX/pk5a4HSxBwIZWeBdAoCHQB/aKBVK7puY4U8VBsgKnZURDJmHJIdHOxBWR82hPQ6ug==
X-Received: by 2002:a05:651c:2126:b0:2fa:c9ad:3d36 with SMTP id 38308e7fff4ca-2fb1872bd83mr41533031fa.7.1728564729444;
        Thu, 10 Oct 2024 05:52:09 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fb24707028sm1944381fa.80.2024.10.10.05.52.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 05:52:08 -0700 (PDT)
Date: Thu, 10 Oct 2024 15:52:05 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Miaoqing Pan <quic_miaoqing@quicinc.com>, 
	Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org, 
	agross@kernel.org, andersson@kernel.org, linux-kernel@vger.kernel.org, 
	konrad.dybcio@linaro.org, mchehab@kernel.org, quic_vgarodia@quicinc.com, 
	stanimir.k.varbanov@gmail.com, ath11k@lists.infradead.org
Subject: Re: [PATCH v3] arm64: dts: qcom: sa8775p-ride: add WiFi/BT nodes
Message-ID: <qf3wwrluqsytrlwclnp6limdnrsqs3odbk3cg67hyk6fad6zcf@yujf46ltsaad>
References: <20241009012738.2840558-1-quic_miaoqing@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009012738.2840558-1-quic_miaoqing@quicinc.com>

On Wed, Oct 09, 2024 at 09:27:38AM GMT, Miaoqing Pan wrote:
> Add a node for the PMU module of the WCN6855 present on the sa8775p-ride
> board. Assign its LDO power outputs to the existing WiFi/Bluetooth module.
> 
> Signed-off-by: Miaoqing Pan <quic_miaoqing@quicinc.com>
> ---
> v2:
>   - fix wcn6855-pmu compatible to "qcom,wcn6855-pmu".
>   - relocate pcieport0 node in alphabetical order.
> v3:
>   - add 'qcom,ath11k-calibration-variant = "SA8775P"'.
> 
>  arch/arm64/boot/dts/qcom/sa8775p-ride.dtsi | 121 +++++++++++++++++++++
>  arch/arm64/boot/dts/qcom/sa8775p.dtsi      |   2 +-
>  2 files changed, 122 insertions(+), 1 deletion(-)
> 

[...]

> @@ -702,6 +793,25 @@ &pcie1_phy {
>  	status = "okay";
>  };
>  
> +&pcieport0 {
> +	wifi@0 {
> +		compatible = "pci17cb,1101";
> +		reg = <0x10000 0x0 0x0 0x0 0x0>;
> +
> +		qcom,ath11k-calibration-variant = "SA8775P";

SA8775P what? Is it going to be the only device using SA8775P?  Please
take a look around how other calibration variants are defined.

Also please cc Kalle, Jeff and ath11k ML in future submissions

> +
> +		vddrfacmn-supply = <&vreg_pmu_rfa_cmn>;
> +		vddaon-supply = <&vreg_pmu_aon_0p59>;
> +		vddwlcx-supply = <&vreg_pmu_wlcx_0p8>;
> +		vddwlmx-supply = <&vreg_pmu_wlmx_0p85>;
> +		vddrfa0p8-supply = <&vreg_pmu_rfa_0p8>;
> +		vddrfa1p2-supply = <&vreg_pmu_rfa_1p2>;
> +		vddrfa1p7-supply = <&vreg_pmu_rfa_1p7>;
> +		vddpcie0p9-supply = <&vreg_pmu_pcie_0p9>;
> +		vddpcie1p8-supply = <&vreg_pmu_pcie_1p8>;
> +	};
> +};
> +
>  &remoteproc_adsp {
>  	firmware-name = "qcom/sa8775p/adsp.mbn";
>  	status = "okay";

-- 
With best wishes
Dmitry


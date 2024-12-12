Return-Path: <linux-kernel+bounces-443579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58E8A9EF811
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 18:39:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 193A6292D68
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 17:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F99B22333D;
	Thu, 12 Dec 2024 17:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nPore93d"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C243B2210F1
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 17:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734025147; cv=none; b=fsuoMB2uy8eJPBiRt18dX0AI4qSzXSjvp6WwGLoYaDkJBEn6GgiBfid5K628aZdR/PmhD8feGuWcl7S/Lm61ALitFnJ3hok7WnkSeNEc4hpePAybXC1JZ5dgMEzZZaVY7iUR44m4KHN9gNE/kAWlqpFPVDx0EN+ab3D/wMWSSks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734025147; c=relaxed/simple;
	bh=eMaa+1s6Oic+vVrJQSezrnGXV/UwpVx0e4bkfGVOXxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WgLAbRfa9be4R6Zz77saubKrY5oeeFUNbxRgIL/jNHDa7j5yOCsy/CO3y4AKBwUAPsAfzJ+DrWXwOsvAnql1OgahImeBcxRfDu2nktbmWHy1FozWPgV0hnVPZKlDq2lJOesd6FXCIXO59fmay8g+GRrzX/9BbD3PNOHFit+WVLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nPore93d; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-435004228c0so11696915e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 09:39:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734025143; x=1734629943; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RdPPbRbtOCRVKhqUGeFsn5kZ9oH7JqJR4etx+rwghdA=;
        b=nPore93dEANJsEg2OKBvSY3ymc8yyZlkD6KWRJof844YprztL46LhpnT4NcIn3Q9E9
         UT2vIO9AIZRUiz6vDK83dCrs5fLm8DGriEAzc1fHlB2i6fhhBOqdWiLWlpkjo6FwBo+5
         3hhT8X8CsJGv8yiYZhvhbGeo38KBglhRxjj7aYRWUyy+5kxmV3upcKwUkEZzO5ypNMz7
         BYh4fDt0Uq5T/9HbPc4U2zWMlkqYhJ13zszw05X/vZXSqqv5xWBP7WaCQM/S+Onpx0Pv
         flY/S5xFbjbeuIkGS94ttAZfILAJ85ny2S4UZskQCKPuz6SJ3fj6nEIZBLYWQRD4KJGX
         aMaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734025143; x=1734629943;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RdPPbRbtOCRVKhqUGeFsn5kZ9oH7JqJR4etx+rwghdA=;
        b=sWGh1GbCKT6lghl+Gd0AQUsN7yPnavToHpx4hSfzzP7HjcdrcQJ4XioAfXZso1XUPw
         eIvlSuQffmcoGmoHheskpGo7sLbN1Pnli4iMTrp3Xz1j08I6ETBOhE1rwCD5LvAjl8Qz
         a3LASsEnjoC/nAT31sTPdpqUWDWyVZdu4MKEgdETgt4Zsvq3XSsIJpXL8b8rTtkIywCf
         OgzME/+YZFkKx0upOoTrfmB3lxZdYrlZv2c1M5W74+q3dmikwAfWEgsrUnqb5XFLqKX5
         zt4OCKTDgzyNHChO21x/tF3JCtL/o7x5nzRnuTSOfo6Ryt2kmxLo5bpPQkJhRYxp921R
         BJSA==
X-Forwarded-Encrypted: i=1; AJvYcCVh1xGpoEWZjsDvARrIFe9Ufcw/zTyoemyjB9NdZsKRK8oJ84nEdA3KF1gMjGeRPs2SaX5wFTcDVtJy6To=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLU06P5OnlUuRQfWGBtEWMrZYR+8dPivxVWEtNQOb2OCsoaDN9
	za97h4e4KeeQhSKy6E0AKg/scxL2GwqdHyhrO10csmVZ6tukONkbVgHOSs3PlRs=
X-Gm-Gg: ASbGncut3uM1kwL5XJXWZKRZYT3I7kbAGdeV00dQoM1TI1YLaJFF5HF3QZVxrbaZRt4
	pUIC0bN2gFdAzKZh6GYnDwE21oM3kjNiOa9pQ7wrlSEkj3kpBxlg4+xtFi4FPqnWCptSu3QVsxp
	o2sKUq9CNx+NrVKRYfNq9GvnnYq2iFBzoMHilli32GXPQdYimK0PiB2thWjg3cZC9IJXFxPAJ/I
	cVx8KM2P8Z3+frDp0HCB2fUxloDox90QrHyR+Al0Z1MxIZEc96vAlE=
X-Google-Smtp-Source: AGHT+IE7M7KWizuTlmdXgepOOA1ZHa8E1i/d7gI8YHUlTjMROy7G2A2HxSU/h0+zZY2Hehz8nbuVQQ==
X-Received: by 2002:a05:600c:34cc:b0:434:fbe2:4f with SMTP id 5b1f17b1804b1-4361c430b5cmr72148245e9.23.1734025141596;
        Thu, 12 Dec 2024 09:39:01 -0800 (PST)
Received: from linaro.org ([82.76.168.176])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3878251bcabsm4731291f8f.87.2024.12.12.09.39.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 09:39:01 -0800 (PST)
Date: Thu, 12 Dec 2024 19:38:59 +0200
From: Abel Vesa <abel.vesa@linaro.org>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Johan Hovold <johan@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v4 1/2] arm64: dts: qcom: x1e80100: Describe the SDHC
 controllers
Message-ID: <Z1sfs2L49LqTtYSs@linaro.org>
References: <20241212-x1e80100-qcp-sdhc-v4-0-a74c48ee68a3@linaro.org>
 <20241212-x1e80100-qcp-sdhc-v4-1-a74c48ee68a3@linaro.org>
 <f2964623-63e9-44cd-b328-d502b5fddcd2@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2964623-63e9-44cd-b328-d502b5fddcd2@oss.qualcomm.com>

On 24-12-12 18:34:37, Konrad Dybcio wrote:
> On 12.12.2024 5:50 PM, Abel Vesa wrote:
> > The X Elite platform features two SDHC v5 controllers.
> > 
> > Describe the controllers along with the pin configuration in TLMM
> > for the SDC2, since they are hardwired and cannot be muxed to any
> > other function. The SDC4 pin configuration can be muxed to different
> > functions, so leave those to board specific dts.
> > 
> > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > ---
> >  arch/arm64/boot/dts/qcom/x1e80100.dtsi | 142 +++++++++++++++++++++++++++++++++
> >  1 file changed, 142 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> > index c18b99765c25c901b3d0a3fbaddc320c0a8c1716..1584df66ea915230995f0cf662cde813f4ae02a1 100644
> > --- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> > @@ -4094,6 +4094,108 @@ lpass_lpicx_noc: interconnect@7430000 {
> >  			#interconnect-cells = <2>;
> >  		};
> >  
> > +		sdhc_2: mmc@8804000 {
> > +			compatible = "qcom,x1e80100-sdhci", "qcom,sdhci-msm-v5";
> > +			reg = <0 0x08804000 0 0x1000>;
> > +
> > +			interrupts = <GIC_SPI 207 IRQ_TYPE_LEVEL_HIGH>,
> > +				     <GIC_SPI 223 IRQ_TYPE_LEVEL_HIGH>;
> > +			interrupt-names = "hc_irq", "pwr_irq";
> > +
> > +			clocks = <&gcc GCC_SDCC2_AHB_CLK>,
> > +				 <&gcc GCC_SDCC2_APPS_CLK>,
> > +				 <&rpmhcc RPMH_CXO_CLK>;
> > +			clock-names = "iface", "core", "xo";
> > +			iommus = <&apps_smmu 0x520 0>;
> > +			qcom,dll-config = <0x0007642c>;
> > +			qcom,ddr-config = <0x80040868>;
> > +			power-domains = <&rpmhpd RPMHPD_CX>;
> > +			operating-points-v2 = <&sdhc2_opp_table>;
> > +
> > +			interconnects = <&aggre2_noc MASTER_SDCC_2 0 &mc_virt SLAVE_EBI1 0>,
> > +					<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_SDCC_2 0>;
> 
> The comment regarding ICC defines from v3 still stands

Urgh, missed that one. Will respin next week with that addressed as
well.

> 
> the rest of the patch looks good
> 
> Konrad

Thanks for reviewing!

Abel


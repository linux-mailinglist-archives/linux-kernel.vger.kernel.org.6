Return-Path: <linux-kernel+bounces-201786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 886518FC324
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 07:51:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46A42283192
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 05:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E24D21C183;
	Wed,  5 Jun 2024 05:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U1FltmsK"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96F4D529
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 05:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717566678; cv=none; b=mbnT+wj9L9vijtRnDoAfziq5XEUdqSx6YJ8JvOLoafQRgx+AVbjvRgBi6AEfbzdInDWBrln2oQyY/okkPMtRZMgVFyokPK343eHj1FC7UQfPNX/Xt49No1sSjiytAarVaWTr9k6gPKp8r9JXBRz8tLns7L5EUuqCPZN3pS41m8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717566678; c=relaxed/simple;
	bh=ITeDx0OqlgB7NiL0mf7tKEd1JYGKzgJ1DJzTY6KYISc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eyUeapdVZ2a0y329aR6FVgC5tWNpVMUNcvEcRLfTkCw+qoho+FWMwZDxWpmw08kwNWXDoero+NCddO8X0NFQqWs+bRoj7nGK1IUGhRUGv6UhYHZ9UPMEBUzS4gm+P/VDevRSQbLIoqAyL6PFTsda+FZSSZafcGM/NAISIR4cpe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=U1FltmsK; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1f658800344so27679135ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 22:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717566675; x=1718171475; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rCWSUQImHGilToURCyAOpdWvaa8ql6HejyzXJyuEZoo=;
        b=U1FltmsKqAmHOcgos8Ff6I6BwrczuMCgFtZVJYkqFM9ibIk2N7/kQFu4pYcKfk2+3i
         H7FCeH274i4PM1PKonsO6gPw3HxA9LgTNo0RSWoph5OVrdTcE1O5ciY6igTcBGU7/oGK
         q3L7bBA5tbiTFHA7gsdikMCfRGRlkqGRPzAeHu126y0D0QB8NZVaSt/X0JKMMwvpr+yq
         JnNaokH5JFnbWKJ46XV519AxD1drzrg4pQldYkXBnNS0kOLJNe9DmAagqfllXAuC51JD
         zRz7Pd59I1EG9EM5x4g/zFns079mo+0OC2t0jep79kfzPIP8GetknuR/eDNH4YT5xF6R
         enZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717566675; x=1718171475;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rCWSUQImHGilToURCyAOpdWvaa8ql6HejyzXJyuEZoo=;
        b=NdmIF+2+K/BuEcj53UboeWnndL3uvl20wUni5nfDROsoFl8k/83zOgvEoLzgW0H/u1
         v8532DL6zVhm9cm5vxTprwnXRc1PYszFUBiBwEeetdFI7A/Nnwwf2Daqlr3zRow1kI35
         6ZspDq7yQqshZ39k3bcE+FsrpA1qYqpRJfVKnMUt13lRI8o6I5MJqTyENSGUQok5+5np
         abYhVnDndBAXpAkLqaovuxUVqlXyUMzQ34jM7iS235UdowxtUoR3wonI6Agt0FVV+jTL
         deBrj39PYT1jnGz1O/rVIHgXp6XbhGDItbVjtQIsaUHiFro88jr2x1lWsdBV/djOA+Mi
         nD4g==
X-Forwarded-Encrypted: i=1; AJvYcCU3QQRPk1WrSzIT0Pw9/J7FTjIKCzXPelHGZi2QVhQUV6JYRSAPAY5nqz7WzaAUAhPHb22UKxj5uZI3iyxEzZb7xecXnwa32E09JdeA
X-Gm-Message-State: AOJu0YxURWY/JQYw/OZRGsKjhnTap7mZg10pNXwzS3YNERlu93POsGiZ
	NFNS6cToaprkAYxdcdaIDbgySJHJx8bi315jVLPojlnPJKEMs02O2hZv8j6vxAtaj6RJX8JVk7A
	=
X-Google-Smtp-Source: AGHT+IGV/MUBr4KlZCCtOhFeci3Ojt9DYoBNyrDOC3FmQoMHqR7+aHEIhtbKxi29Rzfm8hP/wXa/IQ==
X-Received: by 2002:a17:902:9896:b0:1f6:3750:527f with SMTP id d9443c01a7336-1f6a5a20654mr17233275ad.31.1717566674957;
        Tue, 04 Jun 2024 22:51:14 -0700 (PDT)
Received: from thinkpad ([120.60.137.11])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6a5060788sm9513775ad.130.2024.06.04.22.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 22:51:14 -0700 (PDT)
Date: Wed, 5 Jun 2024 11:21:09 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Abel Vesa <abel.vesa@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Rajendra Nayak <quic_rjendra@quicinc.com>,
	Sibi Sankar <quic_sibis@quicinc.com>,
	Johan Hovold <johan@kernel.org>, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: qcom: x1e80100: Fix PCIe 6a reg offsets
 and add MHI
Message-ID: <20240605055109.GC2417@thinkpad>
References: <20240604-x1e80100-dts-fixes-pcie6a-v2-1-0b4d8c6256e5@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240604-x1e80100-dts-fixes-pcie6a-v2-1-0b4d8c6256e5@linaro.org>

On Tue, Jun 04, 2024 at 06:20:24PM +0300, Abel Vesa wrote:
> The actual size of the DBI region is 0xf20 and the start of the
> ELBI region is 0xf40, according to the documentation. So fix them.
> While at it, add the MHI region as well.
> 
> Fixes: 5eb83fc10289 ("arm64: dts: qcom: x1e80100: Add PCIe nodes")
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>

Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
> Changes in v2:
> - Dropped the 4-lane mode switch patch entire.
> - Fetched Konrad's R-b tag
> - Link to v1: https://lore.kernel.org/r/20240531-x1e80100-dts-fixes-pcie6a-v1-0-1573ebcae1e8@linaro.org
> ---
>  arch/arm64/boot/dts/qcom/x1e80100.dtsi | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> index cf8d8d5b1870..fe7ca2a73f9d 100644
> --- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> +++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> @@ -2818,15 +2818,17 @@ pcie6a: pci@1bf8000 {
>  			device_type = "pci";
>  			compatible = "qcom,pcie-x1e80100";
>  			reg = <0 0x01bf8000 0 0x3000>,
> -			      <0 0x70000000 0 0xf1d>,
> -			      <0 0x70000f20 0 0xa8>,
> +			      <0 0x70000000 0 0xf20>,
> +			      <0 0x70000f40 0 0xa8>,
>  			      <0 0x70001000 0 0x1000>,
> -			      <0 0x70100000 0 0x100000>;
> +			      <0 0x70100000 0 0x100000>,
> +			      <0 0x01bfb000 0 0x1000>;
>  			reg-names = "parf",
>  				    "dbi",
>  				    "elbi",
>  				    "atu",
> -				    "config";
> +				    "config",
> +				    "mhi";
>  			#address-cells = <3>;
>  			#size-cells = <2>;
>  			ranges = <0x01000000 0 0x00000000 0 0x70200000 0 0x100000>,
> 
> ---
> base-commit: d97496ca23a2d4ee80b7302849404859d9058bcd
> change-id: 20240531-x1e80100-dts-fixes-pcie6a-0cf5b75a818e
> 
> Best regards,
> -- 
> Abel Vesa <abel.vesa@linaro.org>
> 
> 

-- 
மணிவண்ணன் சதாசிவம்


Return-Path: <linux-kernel+bounces-361867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AB8499AE20
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 23:38:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4C182855C2
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 21:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D6D21D1739;
	Fri, 11 Oct 2024 21:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Yi2qCv7P"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E580D1CF7BC
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 21:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728682681; cv=none; b=hQ1OY6UhTdhDC2P7TofCi5wJ9t+/AZDcS/LlY31yiqDn45gas4CY7VmZnw/GXORzItqYFLIaiR6n/jLHsLCei/2OF41HEwvUmwys3MlXyx030FCctpKdMRkeqDwy6I8J0PS41wjXR+OAWW9fPHlLyD9Yu/diDwXRHzHmnN8Lyo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728682681; c=relaxed/simple;
	bh=Oc8Dx+FMqT5hJ/EG4SegithSm0HDW1G7NKRjFC/WrTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oS08ICBbiqV82y+TOhiK510zepT3Y1AuM3tNfziVtmJ7aBvaqarnuAINGEdmKv1om7a59mxDK+G68vVE1fVhkrDpQHODRRmsw9KAZMh+uISZQPIbbGijsWKvUzQyEmA6VXe3xeoaAtmdR7f2uX17bW9QAU7IuLE1/fD49zesIoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Yi2qCv7P; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5398e7dda5fso2542778e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 14:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728682677; x=1729287477; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aUIYU2FMPqvolUwnyRnf122VNl/tacRTAERvHN2HFBc=;
        b=Yi2qCv7Phz6U5drvNJk8yNv+yJUTEA5lx2G5yZokxPhv/vxwu97hlp1CyP74E+WpTd
         oODcnlGAswtZr2943MDqtpIA5XMs9/0EcEdC9HVwKyNQCmQLSIP+iHkBrcW1WG0hiFln
         pjbIvD2Gxg+CwgUGcXx3/q4B3EGZLAXBzQHNBNMd8VTe9m9D+CwpQM3sMU4+im3MShVp
         1Ecxa0EUhF1kSmfIVwjnsbCTKXxjQVptHYpzyOWB9cJjfdsyBiSVxdHnnVUVpTUaaWJK
         6BRKutkc+ZMz6laRc6pmd8R4zdOdp5VleU6L7ybQi30eu+93qHsxBrjyKjw3J6hr00Fn
         RUnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728682677; x=1729287477;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aUIYU2FMPqvolUwnyRnf122VNl/tacRTAERvHN2HFBc=;
        b=GbIk8Slh/8xnBkc2ZPKhMqdyQHzE0FtJ5fT2SswcmEIc4IG6zrb8vQ8IOcqhhCyOOX
         hFh6/hU/0LUua9Axg7aa5XtbQpR8ajoIQXbTarrSjHoCiz4klQ7SAqTwifxF7QAJk9us
         Xsqc5q47GAw55rbiv1DOUctN/6gOoXP9WEH51eQ/8L7iBHMfFUi33RvxnWp7/h0U0oib
         dxw33qjvFmAglc1sLZo/biD9BO0Um8Q71Nlq++XTGRY6N9UqWZq7uQrYKcfoXTr5LPyJ
         uryHRfkfkzs+tf7M4czibhCeUybJwAqN52OalXUpizhprU/xcBknD5xe2vdbsBMpoAc1
         bWJg==
X-Forwarded-Encrypted: i=1; AJvYcCV+MV34H3P+L7+R/lqisjkYv/JCMugKDp5DVUHOwtw0jprwjslth7YjI2qYV0ZbnjDx18d+ycjz/cFKVTY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSCJhGT+8FOlwteo7E75jcagg2U6XKw035Sb8wV80uxCHFmDt/
	JYLEZkdBz80RdQIAY/tmvXdYuaEgJL1va8JyULs3zNfLg9t+Xsc4vYxQqUEyvKU=
X-Google-Smtp-Source: AGHT+IHkvpXjqQ4Ntwp3RR3/h9wtPR8YEE/iYV3c+819m9jN+n9MkfDaHKh907oVKkugoVP+yWN5zw==
X-Received: by 2002:a05:6512:3ca8:b0:536:741a:6bad with SMTP id 2adb3069b0e04-539e54d816amr482141e87.12.1728682676957;
        Fri, 11 Oct 2024 14:37:56 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539cb6c8543sm712354e87.98.2024.10.11.14.37.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 14:37:55 -0700 (PDT)
Date: Sat, 12 Oct 2024 00:37:54 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Jonathan Marek <jonathan@marek.ca>
Cc: linux-arm-msm@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] arm64: dts: qcom: x1e80100-crd: enable otg on usb
 ports
Message-ID: <eknpk3z3isudjqa2a74cqvicrthjs6us7gx7z3itox4utkpobr@cxbxkx5h64x5>
References: <20241011152712.31571-1-jonathan@marek.ca>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241011152712.31571-1-jonathan@marek.ca>

On Fri, Oct 11, 2024 at 11:27:11AM -0400, Jonathan Marek wrote:
> The 3 USB ports on x1e80100-crd are OTG-capable, change dr_mode and add
> usb-role-switch flag to enable OTG.
> 
> Signed-off-by: Jonathan Marek <jonathan@marek.ca>
> ---
>  arch/arm64/boot/dts/qcom/x1e80100-crd.dts | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/x1e80100-crd.dts b/arch/arm64/boot/dts/qcom/x1e80100-crd.dts
> index 6dfc85eda3540..53e76b3f0c831 100644
> --- a/arch/arm64/boot/dts/qcom/x1e80100-crd.dts
> +++ b/arch/arm64/boot/dts/qcom/x1e80100-crd.dts
> @@ -1558,7 +1558,8 @@ &usb_1_ss0 {
>  };
>  
>  &usb_1_ss0_dwc3 {
> -	dr_mode = "host";
> +	dr_mode = "otg";

There should be no need to specify "otg", it is a default if I remember
correctly.

> +	usb-role-switch;

Please move usb-role-switch to the x1e80100.dtsi instead.

>  };
>  
>  &usb_1_ss0_dwc3_hs {
> @@ -1590,7 +1591,8 @@ &usb_1_ss1 {
>  };
>  
>  &usb_1_ss1_dwc3 {
> -	dr_mode = "host";
> +	dr_mode = "otg";
> +	usb-role-switch;
>  };
>  
>  &usb_1_ss1_dwc3_hs {
> @@ -1622,7 +1624,8 @@ &usb_1_ss2 {
>  };
>  
>  &usb_1_ss2_dwc3 {
> -	dr_mode = "host";
> +	dr_mode = "otg";
> +	usb-role-switch;
>  };
>  
>  &usb_1_ss2_dwc3_hs {
> -- 
> 2.45.1
> 

-- 
With best wishes
Dmitry


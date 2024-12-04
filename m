Return-Path: <linux-kernel+bounces-430820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA2859E3605
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 09:57:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88BC1165DB6
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 08:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CFAD190676;
	Wed,  4 Dec 2024 08:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h6DmflNQ"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB989194AC7
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 08:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733302624; cv=none; b=BwbT+StwVtmHMZ9GyeCV5gobtWMnWJGbsdBamF6GOMm7iNPoHWPZrUUXmzBKpID7mGgjEXiKqaMs5+qPHUijkaCBeolIcr6KBcHj4arljOe2AAuNQR3rNpoiUJBkV+Ar5wn9auledMira6sZRbQLkpvTTThzrtMMja/sgF2RA/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733302624; c=relaxed/simple;
	bh=XovRSLJcJrkgKnqQHL2dtBbKpGLTWQYdhbHAYoGI6K0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kX5zsk0PxomyJYPBl4Dr9c6YLoLIl2SI8LG/Tvp6rYsUEz8OjEZOdcGsXhZlZs39ZtUmc0PLyP4FTIyd78sd1E8R85uepNGA/JRbJkSIcrlp9NpMrjiR3sMUpvmr65FnSgc9tVnziLs+z9VG/MAfBImXwBUj2R1PBPGybkkvkEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=h6DmflNQ; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-385dbf79881so355255f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 00:57:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733302621; x=1733907421; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=x3udTRP1EmvcYK+3KX+PJEF33kcxBVvuwqsBYxgRLws=;
        b=h6DmflNQF9gM/XJ9rHjXNFRLlhaE6mXxVkwgDABEFEf4n5f11SXI4OKVwnbRpTh9AQ
         8Y/XPEE4RlANCsYeGeyTPV1Jt41JMoQ4a/IBymzOQf6UKV5seioqbd7O1ZOpprrDAkgF
         iUBgeVRH+2+w8FxteTQLw+MqUueNBBYK+6RtoaF04A4r+FQyhbcJ5AnkkPm3otSHcE10
         Xbi+44BI1/yMJ0RQy4AbRm1epPN8Xdp8a7LGB7UqWeM5CQ9oWgUhzQKMtvcImJi8y5SA
         olG7a2x5Zd+7lJgAUaFRjQxbgZgh1uTT4Nx+085DqH2xOfmkFS0S2I1V0Bmk6dNjujOh
         gjyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733302621; x=1733907421;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x3udTRP1EmvcYK+3KX+PJEF33kcxBVvuwqsBYxgRLws=;
        b=uLktf3COTXQz3OvucTW4EG/bOBenr0ObB01AVh9RgA9yBxe4HGyvDgdyiLRPU+OMi6
         /dIYmmr90jGS0KCO4+LzNGkzjQAPhlKPx0wduEg8lvZdl0O5T/LxEqVFuk8PegYUalhS
         WMcLE3u//wiuRufB03zw78sok9RHjSZU78rXFURz/8BCMXqJSQeUokmM4pL3MmIhoUJr
         NjHAqf4SrK/O35kJqhfNoc1XJB1QlTma0K4RjbbFukNy+sVqgPYjwPZXPkhvPZgO9kgn
         NfRw6PLv6qcr5dljvYlCDYjA9bMQQ5Q3AeuSd5v0jYTSA0HxCl//G4z8eS/YZaJkcDGY
         dVyw==
X-Forwarded-Encrypted: i=1; AJvYcCV9ox52njwtRlzX74kpsHZ3c+uFnNLYrQF2E5h48nl6AribT0MI+aJj9yi1o1Khi0sSW1VKc1jUmX5Pro4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0f9kGWuGs8pRS2qwGxOav77n1flfy6ajRaoU+8iNQpPj8dFUC
	zFSWTMQ0Fie+cJZ2nBfkaCIb9G9+CtP3CrL33NZUtSJWRUwuZhpUHMI2r2/PmqE=
X-Gm-Gg: ASbGnctiULPI66vi4JzyWhwB7XYehoaTlnEiTbuF9yTDyOSDmiXqDQjMi8xg7CS7NXs
	FY1nf4dvklCASdKXC71q4OqbZSdaeJslJJzOCvp/sJyJhBjc+NMKA5VHXJQMwrraPvTEhMdcbI/
	Sd9vkswEEH9jAo6ali5URzUjh0fFa5XhLd+D0cxCmV8qrix8r9zsGlWDr27MEfi+Lz8nVjvOFcF
	Rt68rYAwJTAntR9InKEQgrDOpzJCOv5n9WQyW7ydqZoOCt8
X-Google-Smtp-Source: AGHT+IHWv/Vvn6WcKtZi5xbe1xQqIgeGr6GZ1C1eNAeh1pzIBCjPuUG/ScNqaDZdz48vJ5BAym811g==
X-Received: by 2002:a5d:6c62:0:b0:385:f010:e5f4 with SMTP id ffacd0b85a97d-385fd9b6c06mr3760311f8f.28.1733302621140;
        Wed, 04 Dec 2024 00:57:01 -0800 (PST)
Received: from linaro.org ([82.76.168.176])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385e391656csm12513507f8f.47.2024.12.04.00.56.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 00:57:00 -0800 (PST)
Date: Wed, 4 Dec 2024 10:56:59 +0200
From: Abel Vesa <abel.vesa@linaro.org>
To: Johan Hovold <johan@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v2 1/2] arm64: dts: qcom: x1e78100-t14s: Enable support
 for both Type-A USB ports
Message-ID: <Z1AZW/ZXzCOVi1Zy@linaro.org>
References: <20241202-x1e80100-qcp-t14-enable-usb-type-a-ports-v2-0-7360ed65c769@linaro.org>
 <20241202-x1e80100-qcp-t14-enable-usb-type-a-ports-v2-1-7360ed65c769@linaro.org>
 <Z03PzTsTi3EwaXcE@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z03PzTsTi3EwaXcE@hovoldconsulting.com>

On 24-12-02 16:18:37, Johan Hovold wrote:
> On Mon, Dec 02, 2024 at 11:23:17AM +0200, Abel Vesa wrote:
> > The Thinkpad T14s has 2 USB-A ports, both connected to the USB
> > multiport controller, each one via a separate NXP PTN3222 eUSB2-to-USB2
> > redriver to the eUSB2 PHY for High-Speed support, with a dedicated QMP
> > PHY for SuperSpeed support.
> > 
> > Describe each redriver and then enable each pair of PHYs and the
> > USB controller itself, in order to enable support for the 2 USB-A ports.
> > 
> > Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > ---
> >  .../dts/qcom/x1e78100-lenovo-thinkpad-t14s.dts     | 86 ++++++++++++++++++++++
> >  1 file changed, 86 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dts b/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dts
> > index 975550139e1024420ed335a2a46e4d54df7ee423..f936e3246ec87972746a60080c3a48d646a356f2 100644
> > --- a/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dts
> > +++ b/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dts
> > @@ -495,6 +495,40 @@ keyboard@3a {
> >  	};
> >  };
> >  
> > +&i2c5 {
> > +	clock-frequency = <400000>;
> > +
> > +	status = "okay";
> > +
> > +	eusb3_repeater: redriver@47 {
> > +		compatible = "nxp,ptn3222";
> > +		reg = <0x47>;
> 
> The driver doesn't seem to actually communicate with these devices
> currently and the addresses you specify here do not match what the
> schematics says.

Schematics have the addressess left shifted for the wr/rd bit.

> 
> Have you verified that these addresses are correct?

Reading the chip id regs confirms the addresses are correct.

> 
> > +		#phy-cells = <0>;
> > +
> > +		vdd3v3-supply = <&vreg_l13b_3p0>;
> > +		vdd1v8-supply = <&vreg_l4b_1p8>;
> > +
> > +		reset-gpios = <&tlmm 6 GPIO_ACTIVE_LOW>;
> > +
> > +		pinctrl-0 = <&eusb3_reset_n>;
> > +		pinctrl-names = "default";
> > +	};
> > +
> > +	eusb6_repeater: redriver@4f {
> > +		compatible = "nxp,ptn3222";
> > +		reg = <0x4f>;
> 
> Same here.
> 
> > +		#phy-cells = <0>;
> > +
> > +		vdd3v3-supply = <&vreg_l13b_3p0>;
> > +		vdd1v8-supply = <&vreg_l4b_1p8>;
> > +
> > +		reset-gpios = <&tlmm 184 GPIO_ACTIVE_LOW>;
> > +
> > +		pinctrl-0 = <&eusb6_reset_n>;
> > +		pinctrl-names = "default";
> > +	};
> > +};
> > +
> >  &i2c8 {
> >  	clock-frequency = <400000>;
> >  
> > @@ -651,6 +685,22 @@ &tlmm {
> >  			       <72 2>, /* Secure EC I2C connection (?) */
> >  			       <238 1>; /* UFS Reset */
> >  
> > +	eusb3_reset_n: eusb3-reset-n-state {
> > +		pins = "gpio6";
> > +		function = "gpio";
> > +		drive-strength = <2>;
> > +		bias-disable;
> > +		output-low;
> 
> I don't think the pin configuration should assert reset, that should be
> left up to the driver to decide, that is,  when (and if) it's an
> appropriate thing to do.

Yep. The driver needs changes for that.

> 
> > +	};
> > +
> > +	eusb6_reset_n: eusb6-reset-n-state {
> > +		pins = "gpio184";
> > +		function = "gpio";
> > +		drive-strength = <2>;
> > +		bias-disable;
> > +		output-low;
> 
> Same here.
> 
> > +	};
> > +
> >  	tpad_default: tpad-default-state {
> >  		pins = "gpio3";
> >  		function = "gpio";
> > @@ -808,3 +858,39 @@ &usb_1_ss1_dwc3_hs {
> >  &usb_1_ss1_qmpphy_out {
> >  	remote-endpoint = <&pmic_glink_ss1_ss_in>;
> >  };
> 
> And last, but not least, the T14s may hard reset if you disconnect a
> thumb drive connected to one of these ports while suspended (6.13-rc1).

Wasn't able to reproduce this issue yet. Will spend some more time on it
in the following days.

> 
> Once it survived with a lockdep splat indicating a circular locking
> dependency. I see that on the CRD as well, so possibly not related to
> the hard reset.

This is most definitely the same splat triggered by the repeater PHY ops
being called from the eUSB2 PHY driver. We are already in discussion
with Vinod on how to handle multi PHY levels in the generic framework.

> 
> No such issues with a FullSpeed keyboard.
> 
> Johan

Thanks for reviewing,

Abel



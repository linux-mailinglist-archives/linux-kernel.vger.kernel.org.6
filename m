Return-Path: <linux-kernel+bounces-423548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CED539DA98A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 15:03:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F2EE281CF1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 14:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C9CF1FCF41;
	Wed, 27 Nov 2024 14:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Kdp0xkxj"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B828B3232
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 14:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732716177; cv=none; b=e2hbqlieKz+foTD94u2wnQkLrKvsR3JNogPQ+FQ4JkWkXR1KLPT3L8qLhnEgkggjY47XWlHWLqiE2hZIwBI2T5PQvbwsKhNBflhZ1KlF3AaZrhWaXSwwDT4uU5DTnPdtk6tKn4hK4ZP02xq4jdM3v0Zay9DlapGXBEK/z2C6RRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732716177; c=relaxed/simple;
	bh=TUPT2Vj93/kyEbrXqfOFEH096hxvwGyIPajMGlJp8xA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LmeYYlU50rWOHtVXjbts1z+EcUoD3GASquya61YoOxrF9eHRDNSXdaEY7SJnsNoDRCelDCP4o0jgToWLWoXMHazKwpvTOFzeyaiFJzw81zyiHfRo9762g07yKzGZOTzLX/8mQR4ZCRt8IPUZwh7hS7UJWQittGaxY3nOVIzSAII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Kdp0xkxj; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-53de8ecb39bso2231130e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 06:02:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732716174; x=1733320974; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T01FX8+ifMzh7FdT/3RYrXgZQjd2w/xyGf35CNWYzZw=;
        b=Kdp0xkxjdipnSnpoAfJH/ID8ZhUz7QlJIUqtiA1lA7sRn3lZE2FRl8Wrie5RLWOZOu
         +nS/edCDmeyaq6snRRuK47idAH0i4+ndakXWNoY5h7O1iIkknPi3mZOa/KrVFhlBHC40
         L8KYFJB80qc1pNrOdOQpW1/bIq6mvXztylLU6LUwAQD84JnjiFV7RYjrnYxqanNvBF06
         zj7W44eIHmVCQUUCj3aJMGE6LfDJbwthLCobJBjdakXOzwHOiYOHMeEoI4f1tiWila8D
         W+xYIJAOjnYjlswYnL8K32uyFyJZ93JGD8Wu9DVlmjo2tMqsiQ9pTChj1oFDK8ncTB2N
         HsGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732716174; x=1733320974;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T01FX8+ifMzh7FdT/3RYrXgZQjd2w/xyGf35CNWYzZw=;
        b=Lm38Yw5ixFJMjd/aRs03Wf3w5b/MvASxjuZ74smsjS0m2rJ1iNvZ/zOZhUqTGsk9Bz
         YyG/SKhEMWDg5c8R/adSTwm4xca76IXS+P1HZ/jD51Q8XK4NpqbQGCRtvw4k4uQtL9pz
         B0D/d58ZZeIJ8PYKpdel/Hp04UB01IMmOG7BubSUub2PUbTCX/tg9fHFZpObNYp3q68a
         4aSe8XSDT5mP8O3W5kAauwNCVKdhNeRW/7u5nWNk+B/4ri2utp0R09Pzbz8eIvm3NafE
         b69jB2UOsexY4Q8ypOjhPEJrQmFYY2Rm57b5uS/ic9YOWcSdX9QlUM4setU8Cz7qhSgq
         UMVA==
X-Forwarded-Encrypted: i=1; AJvYcCX/zYSt+Wlh8sPSUueaTMgHoHmYaFK0sLdpE/Uv+yYoMJ1hdIzDF3VLaaYvtcvgN0bljeMjGoDQ2yIfUKw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLp9PH1/3VwEHJBTU7qOjAspIKKWSl0xJATv3n1qq2HrIMiRaN
	HXUBI4V+omp56y4Gmh16Lrt05ZItlbz+Rih29GtsEj7tv3vWE9CQLmjnGkfrdxE=
X-Gm-Gg: ASbGncskip+C2NC88QuvuuBAe0xGYGHjJ3FIxPorh0RneyioWlBZ5iJv7rAe1RauaS4
	h65RrP51VXsfsKOLsdI4PUScchm8kmoNhKHHpufN0uh55iTMAtYVFcYNNokx/85/3hBrdGx1wDX
	gPwbigrMyxTk0Q5swgKQIqSSC0IRkbvB1DEAgg51fFtHGZRQpx4Z89Yj+bFWWfFPe4cmcwQhJIR
	YohKJqFsTZvnKVfnrmYLhPbRQnp+ROFbegJxIZexcmcqr2ao0YeEv2tJA/b8e2NdSOUDfxdKIyz
	xy33hFODfqS4LnSZvdMGjjgN5s0kcA==
X-Google-Smtp-Source: AGHT+IE4PFY/jEkiwyrm8o+Db9OLNXgxUMj7QvjWWz6uR+5Fh5KVZpx+UZJ77BHMmy7vJiZ7cMIV8g==
X-Received: by 2002:a05:6512:398c:b0:53d:ea3c:2ba0 with SMTP id 2adb3069b0e04-53df00d12afmr2027772e87.16.1732716173570;
        Wed, 27 Nov 2024 06:02:53 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53dd3c852ccsm2274613e87.253.2024.11.27.06.02.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 06:02:52 -0800 (PST)
Date: Wed, 27 Nov 2024 16:02:50 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Krishna Kurapati <quic_kriskura@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>
Subject: Re: [PATCH v4 2/3] arm64: dts: qcom: sar2130p: add support for
 SAR2130P
Message-ID: <2hka5j3iyml32czhv6k2gr6ss2jthsgaljva5izhzzcoc3l4eq@slsmyp7s6ars>
References: <20241102-sar2130p-dt-v4-0-60b7220fd0dd@linaro.org>
 <20241102-sar2130p-dt-v4-2-60b7220fd0dd@linaro.org>
 <ff7c9b83-0ac7-43a0-a86a-2fed66728a32@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff7c9b83-0ac7-43a0-a86a-2fed66728a32@quicinc.com>

On Tue, Nov 26, 2024 at 11:32:59PM +0530, Krishna Kurapati wrote:
> 
> 
> On 11/2/2024 8:33 AM, Dmitry Baryshkov wrote:
> > Add DT file for the Qualcomm SAR2130P platform.
> > 
> > Co-developed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> > Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > ---
> >   arch/arm64/boot/dts/qcom/sar2130p.dtsi | 3123 ++++++++++++++++++++++++++++++++
> >   1 file changed, 3123 insertions(+)
> > 
> 
> [...]
> 
> > +		usb_dp_qmpphy: phy@88e8000 {
> > +			compatible = "qcom,sar2130p-qmp-usb3-dp-phy";
> > +			reg = <0x0 0x088e8000 0x0 0x3000>;
> > +
> > +			clocks = <&gcc GCC_USB3_PRIM_PHY_AUX_CLK>,
> > +				 <&rpmhcc RPMH_CXO_CLK>,
> > +				 <&gcc GCC_USB3_PRIM_PHY_COM_AUX_CLK>,
> > +				 <&gcc GCC_USB3_PRIM_PHY_PIPE_CLK>;
> > +			clock-names = "aux", "ref", "com_aux", "usb3_pipe";
> > +
> > +			power-domains = <&gcc USB3_PHY_GDSC>;
> > +
> > +			resets = <&gcc GCC_USB3_PHY_PRIM_BCR>,
> > +				 <&gcc GCC_USB3_DP_PHY_PRIM_BCR>;
> > +			reset-names = "phy", "common";
> > +
> > +			#clock-cells = <1>;
> > +			#phy-cells = <1>;
> > +
> > +			orientation-switch;
> > +
> > +			status = "disabled";
> > +
> 
> Hi Dmitry,
> 
>  Sorry for asking this question after code got merged. I forgot about asking
> this last time when I commented on your patch and provided the HS Phy IRQ
> value.
> 
>  In SAR2130P, I remember that the lane orientation is reversed. As in on
> normal targets, if the orientatin GPIO reads "0" it means LANE_A but on
> SAR2130 it means LANE_B. Can you confirm if superspeed was tested only in
> one orientation only.

Thanks for the notice. I don't remember if I had USB3 or just USB2
connected to the USB-C connector. I will take a look and report
afterwards, but it might take some time.

> 
>  I can push code for setting orienation properly for this target if you can
> confirm that orienation is read reverse on SAR2130P.
> 
> Regards,
> Krishna,

-- 
With best wishes
Dmitry


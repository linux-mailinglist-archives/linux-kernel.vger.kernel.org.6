Return-Path: <linux-kernel+bounces-410329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 311439CD9FE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 08:36:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F2A5B225DA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 07:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 231D4188CD8;
	Fri, 15 Nov 2024 07:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lK+32Qas"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997621862B8
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 07:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731656178; cv=none; b=MrWcJyF5ZUdRb9G9s95R4JqXVNb1Kyybh4P+ZTVkyQkhR0z5/7jxvrA+UXLuBPeEujl2fyrCPZvykKODDzq7KUyM2WbVM8x+A+ogKHDOpQjkydtlduIoMOHSBNJhAsn6+OSUA9gdX3wRxx1J+1IuA1UcGY7D8GCRj5Ovqsdy3lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731656178; c=relaxed/simple;
	bh=SIEo8s5hFS6DUYrU3deosBF91zXunNrtoBkPt0/ZWIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t8BCqMzufFy0z5jQr5g7Cl/4lOTS5HMVA7kwSaPdRwbx+q1YvIY9sHmvqEBBqQRwfUWVY8ZSfGQmKL/slN/oZBBPkMUKHNhTxyH+k8ySPD2BP28aOpNBph5LDuZvoki0YFsSlePcg/jt+Mv3bC5IdX73Gwkt1j2nap2SMjNkyN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lK+32Qas; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-539e8607c2aso1534593e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 23:36:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731656175; x=1732260975; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=f/zaNJXsl01a5zNIwyl9L4dlmA9eGCe/qLUK5CKx19E=;
        b=lK+32QasuWXjOaanOgx+r4bgIECKTotq9nyq6CrRJpgSdUvF70mX5FYTmKenid80LL
         zB8E16rqLHV/kw5EheFruIGWpTMzu0edzj7AyEDn4VrxtFQOuCykg5pRf7Zk/UcpXGiz
         xv15QsGPz014I9eZvIUlad45uEzEoxMaoFuHD4P4bnUJiTyDW+c0g3ncKn4RH7GH5Scd
         LB47PSiq4wGqFTeHn9T2jjBMfOu/u83aE5FEMI0WVgE2hLLkqcjCzAAbFT/25KWXhatd
         oP7hZ01KX3iLYJockrYyheYawJWlSNdHRN19tn1BxusWpIxWc058ZyH1WDaDXrPEoIyy
         k+2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731656175; x=1732260975;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f/zaNJXsl01a5zNIwyl9L4dlmA9eGCe/qLUK5CKx19E=;
        b=DDVTVFmPq93s/fysAWncx52YE8NFW0e8rs4GbKp5E6wqavo+06XwfTpG120e1mbcV3
         mH2nmLQfPUx3+kuvpX3OmOeNTatFnVzBzXHF2UjQCtGfM821tsUMSUlI2Krrdvqqs+gs
         Zh5tpKC5WX1zQwlWf77LQqJ+mpHMzz0Z2J1xSD8nNW4gX5fCiuhGP47uE1q9Nzz9jTs7
         3WPxo4BiE+k53mAmOHsKrBNX7jJFYKav4+rFBgomgd7Moyw5+/RqMQmmP+xZhygZuSmM
         Xl/f8lBOLIrtpGlFTPAB6oaZ+NFRC7iq982lu1m9w1yPodK4Tn3MxqI9qbhj1TtgKmCs
         8+UA==
X-Forwarded-Encrypted: i=1; AJvYcCUztBuGkgbWpYRkjEpqY6ns8+NtV1C7WumvYZ5KbG5VRsZZliq/BqVoe9jBRdArj5OjyG+K0jHaHx7+LnM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxV8YJicHaPF9kko4lp/KqOT4IguJZqtL0m+1+0F0N6wW4+N513
	4Foe99JmwUYaWFshVwbkva9mm/GQJQwffWILBB4nMOkJO5P9rC4Jsz1cLKS7670=
X-Google-Smtp-Source: AGHT+IELxNr42kTGq86yNt7HpRgRuLDZHJp2+y0D3HJbNVFtEX+4EYZRDRiqgDM2tZ7bw4WDChznfA==
X-Received: by 2002:a05:6512:3b25:b0:536:554a:24c2 with SMTP id 2adb3069b0e04-53dab2a04dfmr512452e87.13.1731656174673;
        Thu, 14 Nov 2024 23:36:14 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53da6530d32sm473369e87.139.2024.11.14.23.36.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 23:36:13 -0800 (PST)
Date: Fri, 15 Nov 2024 09:36:10 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Tingwei Zhang <quic_tingweiz@quicinc.com>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
	Ziyue Zhang <quic_ziyuzhan@quicinc.com>, vkoul@kernel.org, kishon@kernel.org, robh+dt@kernel.org, 
	manivannan.sadhasivam@linaro.org, bhelgaas@google.com, kw@linux.com, lpieralisi@kernel.org, 
	quic_qianyu@quicinc.com, conor+dt@kernel.org, neil.armstrong@linaro.org, 
	andersson@kernel.org, konradybcio@kernel.org, quic_shashim@quicinc.com, 
	quic_kaushalk@quicinc.com, quic_tdas@quicinc.com, quic_aiquny@quicinc.com, 
	kernel@quicinc.com, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org
Subject: Re: [PATCH 4/5] arm64: dts: qcom: qcs8300: enable pcie0 for QCS8300
Message-ID: <273fm6dpwt3xzdm5khzipdqiqzpo7zy5jsc4iesd3dt72ldhdw@wd2urfqyt6fn>
References: <20241114095409.2682558-1-quic_ziyuzhan@quicinc.com>
 <20241114095409.2682558-5-quic_ziyuzhan@quicinc.com>
 <rg4isufmnhnbsiljm34rfdsn46gfpatbsiscynaqtsnykbhnm3@ovcaulkfj4nk>
 <26943ea3-109c-473d-818b-2a08dba859ab@oss.qualcomm.com>
 <288be342-952b-4210-afe7-6e194dfd54a9@quicinc.com>
 <cp2g6j43zlx2njou5qz5tmwsnnzahqtk2hsxkj2ftrzbcmy742@ysca5ica4mvr>
 <bb6ae010-5dbf-455c-a53c-6c0e688f0ebc@quicinc.com>
 <nr4xt5pefd3jngml6bkbgrfhsuxmre44v3qs6uyxz7qp5dzqad@6dss6lwhb35n>
 <af6ca3d2-54da-49bb-940a-69855ab2a7b0@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af6ca3d2-54da-49bb-940a-69855ab2a7b0@quicinc.com>

On Fri, Nov 15, 2024 at 03:16:29PM +0800, Tingwei Zhang wrote:
> On 11/15/2024 3:03 PM, Dmitry Baryshkov wrote:
> > On Fri, Nov 15, 2024 at 02:42:47PM +0800, Tingwei Zhang wrote:
> > > On 11/15/2024 2:26 PM, Dmitry Baryshkov wrote:
> > > > On Fri, Nov 15, 2024 at 12:59:12PM +0800, Tingwei Zhang wrote:
> > > > > On 11/14/2024 9:03 PM, Konrad Dybcio wrote:
> > > > > > On 14.11.2024 1:10 PM, Dmitry Baryshkov wrote:
> > > > > > > On Thu, Nov 14, 2024 at 05:54:08PM +0800, Ziyue Zhang wrote:
> > > > > > > > Add configurations in devicetree for PCIe0, including registers, clocks,
> > > > > > > > interrupts and phy setting sequence.
> > > > > > > > 
> > > > > > > > Signed-off-by: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
> > > > > > > > ---
> > > > > > > >     arch/arm64/boot/dts/qcom/qcs8300-ride.dts |  44 +++++-
> > > > > > > >     arch/arm64/boot/dts/qcom/qcs8300.dtsi     | 176 ++++++++++++++++++++++
> > > > > > > >     2 files changed, 219 insertions(+), 1 deletion(-)
> > > > > > > > 
> > > > > > > > diff --git a/arch/arm64/boot/dts/qcom/qcs8300-ride.dts b/arch/arm64/boot/dts/qcom/qcs8300-ride.dts
> > > > > > > > index 7eed19a694c3..9d7c8555ed38 100644
> > > > > > > > --- a/arch/arm64/boot/dts/qcom/qcs8300-ride.dts
> > > > > > > > +++ b/arch/arm64/boot/dts/qcom/qcs8300-ride.dts
> > > > > > > > @@ -213,7 +213,7 @@ vreg_l9c: ldo9 {
> > > > > > > >     &gcc {
> > > > > > > 
> > > > > > > The patch doesn't seem to update the gcc node in qcs8300.dtsi. Is there
> > > > > > > any reason to have the clocks property in the board data file?
> > > > > > 
> > > > > > Definitely not. Ziyue, please move that change to the soc dtsi
> > > > > 
> > > > > Gcc node is updated in board device tree due to sleep_clk is defined in
> > > > > board device tree. Sleep_clk is from PMIC instead SoC so we were requested
> > > > > to move sleep_clk to board device tree in previous review [1].
> > > > 
> > > > Note, the review doesn't talk about sleep_clk at all. The recent
> > > > examples (sm8650, x1e80100, sa8775p) still pull the clocks into the SoC
> > > > dtsi, but without the freq.
> > > > 
> > > It's begining of the discussion of the PMIC clock for SoC. Sleep clock
> > > specific discussion is here [2].
> > > [2]https://lore.kernel.org/all/be8b573c-db4e-4eec-a9a6-3cd83d04156d@kernel.org/
> > 
> > Please note how the recent platforms describe those clocks: the node in
> > the SoC dtsi, the frequency in the board dtsi. X1E80100 is a step
> > backwards, the clock are completely defined in the x1e80100.dtsi. There
> > seems to be no strict rule on how to handle board clocks. I've sent an
> > RFC patchset, trying to move them to a single logical location. Let's
> > see what kind of response it will get. We probably need to define and
> > follow a common rule for all Qualcomm platforms. Please give it a couple
> > of days for the dust to settle. However, I think there should be no
> > reason to keep GCC's clock definitions in the board DTS.
> > 
> Thanks for the clean up patch and make it consistent.
> 
> Is it reasonable for GCC's clock definition to refer xo_clk/sleep_clk in
> board device tree? Theoretically, can we have another board has different
> xo_clk say xo1_clk defined in board device tree?

That's a question for that series. I'd say, no. Some older platforms had
separate CXO and PXO clocks, newer platforms have single CXO.

> > > > > 
> > > > > [1]https://lore.kernel.org/all/10914199-1e86-4a2e-aec8-2a48cc49ef14@kernel.org/
> > > > > > 
> > > > > > Konrad
> > > > > 
> > > > > 
> > > > > -- 
> > > > > Thanks,
> > > > > Tingwei
> > > > > 
> > > > > -- 
> > > > > linux-phy mailing list
> > > > > linux-phy@lists.infradead.org
> > > > > https://lists.infradead.org/mailman/listinfo/linux-phy
> > > > 
> > > 
> > > 
> > > -- 
> > > Thanks,
> > > Tingwei
> > 
> 
> 
> -- 
> Thanks,
> Tingwei

-- 
With best wishes
Dmitry


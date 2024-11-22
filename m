Return-Path: <linux-kernel+bounces-418541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 086F69D62CF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 18:14:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53494B245AE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 17:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8BE21DF96C;
	Fri, 22 Nov 2024 17:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nk8/ZEKW"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29471DDA32
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 17:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732295628; cv=none; b=eyaIjAr+l/4kFcD/hG7h01ayb1VdmeaH+PD1nbITXKUoRB8mavpMK3mS3V0OvYzEBQqwN5y+XD6m58HG0+y85rQDNWk5/NSLFp9voZzdcrj6EZfcn/QgVNFsOU+MUH/R0B2KD5N4gVkjwaXMxBqraMqlv9yllfb1qkbgS8v3xNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732295628; c=relaxed/simple;
	bh=9Utb13MynaifzSiCb+13ADGTdToHf99pkQJS+1gzmyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L7/tS0wwXv9aqU6qpmqUP9tfdics8puQPJycj4HHN7pnZ5VXKjoPs2vMzuHtzerEmqb5lI/pZ9MeCeNRZCICr6VCUILzCriJxWKK8icehdtAF+G9ydTHMhcDktY3oGRZzrx2BU1wuLlcLDIBsGizHG0H0dbATU2Z9FAcswgarSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nk8/ZEKW; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-724d23df764so1659209b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 09:13:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732295626; x=1732900426; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=J3Ifp0rGPbm/e/7rhcYVsj05S6iHCWRwu0XzDIJa52Y=;
        b=nk8/ZEKW2PV3KjMJXctgOrzTlgaBZUgzJz3Bex6+Zg4TREgegX7hDHKGr90Y1mSOTq
         eySz0LamewHMbLT9WEoerK6BnyfPr7BbVv+wUIW8kv4WxprTnyf9XPfC98RkQwQJxu5n
         SW08zcnHCoKpUNLqU54xXPAEbi2UyodstPc12E5k6m3wNIbG37ve+Psgk5X2LJS0oLgS
         02YPD8Rswdf8+Q+ncJampQ3ceL0PHCwK7V3FhczW38z9sEP5JGPxjU/mB/p8wIWbvXG6
         yBZVtvd17n0MkUhFghg/MRvrO2A/MtkdyReAym5XpINNNpeVoF+SWq3CQ51BAxQxHQUL
         NarQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732295626; x=1732900426;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J3Ifp0rGPbm/e/7rhcYVsj05S6iHCWRwu0XzDIJa52Y=;
        b=YGwGJf8KvfC/9TGdkNGRHtdQA7dp1uzc8crMGyrijthG7rlovwJ45/M/u5JRLOycl3
         JLuq4nb5GYa5ggi8Ujq3+KDilAmGGvNkueilAkrPJy37HERQqTyuO4xwmQOnEeky1m0X
         1XARLxY1PNgdSp2/AbPPGvGG+3siod8wwnX5LImPYTLqBTVutCUk7H86eFniicLvhL47
         C6cw4ILD0fktgoxInxFvpH/Irk89uZPgKw2C+7NbFCwRQjIerZ8Pknm57WP0jkXCf5dl
         xDZG7K48uZTfWCqXpD9NcdAhlrRzRlGKanDbtBse5fApWH6cfGiH3h3/Kg2fZHazMMmL
         NJuw==
X-Forwarded-Encrypted: i=1; AJvYcCWsF0nn28DE3kSCtkihQf014ztRfnc8fhhubZwRkRMVmPXN9IOzt0+kengSEuoxH+lauC+tJrPLQYIkDCs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtAlyZErQ9/fQSLVSQdkeGtX4XzFHbdZTZZt7KmPcBUMCVvOSY
	f1IHgfuFwn1VPEMrJoWCtlB1jBIk+BwvMHhDAv5WyOTeFmhW6DMzbAJSie+jgQ==
X-Gm-Gg: ASbGncu8CgcZaSAtIs9cpQ7VjTTQJaPe618B4WHyssMIEd1dQlTzKIzab/5TO8G1xlg
	zft22v1eX9lhfb8QpXkI4LkY3S0ZjbZsCsJ6YuswIP0QeoJKa2KZDT7YHhDp0w1NMmluZSeVJqV
	mymoULAVPNAfyZ64dsuS0eKUU2vzpy34IpLxz4zsIVS1cCOuXuXoyuIDDE9X4PhH6VhmIwmMua0
	aAdgRdo72jdOnhATQEC5RP848qZ7Z+rzdV3l2A3WjUxiacXBBG1hkgEU+ny
X-Google-Smtp-Source: AGHT+IFSLoW5PIBSR6LBkAITjbzrM29xeBOvFQPIeej5XJi4ofiDVZntpwn9iotOelT7YjAqhB/X7A==
X-Received: by 2002:a05:6a00:a8f:b0:724:62b3:58da with SMTP id d2e1a72fcca58-724df5de418mr4726297b3a.6.1732295626152;
        Fri, 22 Nov 2024 09:13:46 -0800 (PST)
Received: from thinkpad ([49.207.202.49])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724e0fca304sm1684411b3a.175.2024.11.22.09.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 09:13:45 -0800 (PST)
Date: Fri, 22 Nov 2024 22:43:40 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Richard Zhu <hongxing.zhu@nxp.com>, l.stach@pengutronix.de,
	bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
	imx@lists.linux.dev, kernel@pengutronix.de,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 10/10] arm64: dts: imx95: Add ref clock for i.MX95 PCIe
Message-ID: <20241122171340.4uwlddrwadg3vyz4@thinkpad>
References: <20241101070610.1267391-1-hongxing.zhu@nxp.com>
 <20241101070610.1267391-11-hongxing.zhu@nxp.com>
 <20241115071605.qwy4hfqmrnaknokl@thinkpad>
 <ZzeE0lR8DGG214qq@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZzeE0lR8DGG214qq@lizhi-Precision-Tower-5810>

On Fri, Nov 15, 2024 at 12:28:50PM -0500, Frank Li wrote:
> On Fri, Nov 15, 2024 at 12:46:05PM +0530, Manivannan Sadhasivam wrote:
> > On Fri, Nov 01, 2024 at 03:06:10PM +0800, Richard Zhu wrote:
> > > Add ref clock for i.MX95 PCIe here, when the internal PLL is used as
> > > PCIe reference clock.
> > >
> > > Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> > > Reviewed-by: Frank Li <Frank.Li@nxp.com>
> > > ---
> > >  arch/arm64/boot/dts/freescale/imx95.dtsi | 18 ++++++++++++++----
> > >  1 file changed, 14 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/arch/arm64/boot/dts/freescale/imx95.dtsi b/arch/arm64/boot/dts/freescale/imx95.dtsi
> > > index 03661e76550f..5cb504b5f851 100644
> > > --- a/arch/arm64/boot/dts/freescale/imx95.dtsi
> > > +++ b/arch/arm64/boot/dts/freescale/imx95.dtsi
> > > @@ -1473,6 +1473,14 @@ smmu: iommu@490d0000 {
> > >  			};
> > >  		};
> > >
> > > +		hsio_blk_ctl: syscon@4c0100c0 {
> > > +			compatible = "nxp,imx95-hsio-blk-ctl", "syscon";
> > > +			reg = <0x0 0x4c0100c0 0x0 0x4>;
> > > +			#clock-cells = <1>;
> > > +			clocks = <&dummy>;
> >
> > What does this 'dummy' clock do? Looks like it doesn't have a frequency at all.
> > Is bootloader updating it? But the name looks wierd.
> 
> dummy clock is not used for this instance, which needn't at all. Leave here
> just keep compatible with the other instance.
> 
> Some instance of "nxp,imx95-hsio-blk-ctl" required input clocks. but this
> one is not, so put dummy here.
> 

DT should describe the hardware and hardware cannot have dummy clock. If the IP
requires a clock, then pass relevant clock (even if it is a fixed-clock).

- Mani

-- 
மணிவண்ணன் சதாசிவம்


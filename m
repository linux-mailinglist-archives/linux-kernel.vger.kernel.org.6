Return-Path: <linux-kernel+bounces-515758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D8549A36898
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 23:44:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 560781898C3D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 22:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E97A1FCCE5;
	Fri, 14 Feb 2025 22:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d7ZyvHwn"
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C041DC99C;
	Fri, 14 Feb 2025 22:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739572941; cv=none; b=p8hT+aheMVsUw4FyXOQNCBnB6ioi+vHvvRb+abmMmXi33dVLsuV2EvNAf1NNA1fP4k0CFJpZFtcPbBt0hhSLS/B6ETJBhctaBydcgTeDc2dDtkN2aYTI0wP32yXMUNa3qUJNJEitPRTOmJTfXD1m8Cx4f9hxBhAhWi0rD0XkahM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739572941; c=relaxed/simple;
	bh=jVleaiTKKT3enhSOUBbAGdgywhYGplbMOXpA7X64DAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uk7FufdmkDP9uJqOhi4YoHtikFwtRwbCZi4oQ4nmKmwL8L82zwzOHdr5ktdzZSRsVqdsem3Zp+hQV2NRDmbY9u8gHrZSkUTBbLO7ng2GOozAPWFE3bKgqsa8uiTvbJ9+HOXIw0XBIs1LclFdMTBVBCR4S+YfhSYYe+LsyUioT2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d7ZyvHwn; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6dcdf23b4edso22733596d6.0;
        Fri, 14 Feb 2025 14:42:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739572938; x=1740177738; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5A68drbhTTSVvgdcUc66bx9dD4R166dRvm9VrghY4Q4=;
        b=d7ZyvHwnKBfNRg+WomFu4aFkzW/Bx/EKEtfRlxAFNliqT6Yo1hFL7css3KdAwtabdn
         xs3oCH8eWTZnP6YYi1gMnGOqN9Fed32mOYoAaieQMjzsI+S2vnxzH8K4GF/sLfKvpfNV
         L6apf7MVkv68MYNNUmE4eQxDJgsCHfiPoCNDRcMdT3AGYI9dhLE8O9RJMxmEfif4FuYA
         xFcrWdYqJ42GD13YfMCCcLS0UrZKol42UXX9v9M9QegQEY7xTAI4g9fAEv/2EKf8hz3n
         gcUKYe0IWHeujfLijnR+hGQ+ECAK+b4lNsiKIBWGjFQzdPxQuBziC9uhZCZ7rBM2EWfi
         svUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739572938; x=1740177738;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5A68drbhTTSVvgdcUc66bx9dD4R166dRvm9VrghY4Q4=;
        b=rG2QPCisygsQyUtEctvDZW4TauGbAl6fyk/REk92ovVZbqc5g6VHFO0pnNl8CL2FW5
         M93VEaBZR4MqfRh2Os4jWTy5NeeJ8GComzG4Nt9tZpSV0Y5SDpuhWu4ehedQ2l5ZyM0F
         5w1zwFgVu6uXRaTXj4iJo0Q5jHJ/t0kuC2pIkSLhUJ06/XQnHveusSjulaRa3SNQApgl
         mk6z+F231zvjP3Y6ClMU6kVbXFNAILZlgydCS265M77DbiU+INaK9YvVnbovw26fsoZQ
         5qjtYwfP1HlxRg4EgRmDjJcQrV1/86k+w/8Ne9DUWR5p+48vBemlJCMBMplYADZUSP0d
         yTRg==
X-Forwarded-Encrypted: i=1; AJvYcCV27W9HGzDlwpaheWKAxPxgpMv6F0Ww7G0om+bzKIGgptlJkEJfgcZdyFCbA4fHrKY9MX4X3FArkgVb4EaU@vger.kernel.org, AJvYcCWDFadY7uYd/lH59+YhFofG0DZhb6sRKcm7D/3Ejq6JGpgBaorBKYZwma31qYPkYxDWbnTLC1Ue/S9l@vger.kernel.org
X-Gm-Message-State: AOJu0YzVEpbI9pwwdmgffasfJQeYJRVkqbq7PeMqJY/ESSE0GkIVIXZG
	AbgxybSt1H1/VfQreoY78PZwoepgCjwyfXncrsaxx4Ib1BRmIHzZ
X-Gm-Gg: ASbGnct9AdLJOIT+X6cb9QC+85XhNsLhRj0LgsOUpJqm+pQPai7aUF5E7bKNEwWnDiQ
	Z3dpp2RfDbbtl59oV75PWZKyRYD+TMWdZ7s5iuH/mvZuAetTGPICzwDA9jcWoF2I7jecZ6lCEbW
	c/KruIotwm5R8gOJ8TSvM8WWCoe6Rx2JLE6LThwAc2B5Ak4+jSvbLimHQwhb5w3qbkvSxQ2+lHk
	eW5QnonDSWy3oMGHivqqlm+t5zhN+fhdOLurU5hfO2i+p0P1DkSfRM8b1XoqW5U55g=
X-Google-Smtp-Source: AGHT+IFdJBJx2BDqksUVhrXVBeP3mAIbgqag9A/szv08TB1nkvkX1A9nZ3tUFl+z87iK3zUv5bUi/A==
X-Received: by 2002:a05:6214:da1:b0:6e6:60f6:56cf with SMTP id 6a1803df08f44-6e66cc7ff70mr19801366d6.5.1739572938525;
        Fri, 14 Feb 2025 14:42:18 -0800 (PST)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6e65d9f36f5sm25582586d6.75.2025.02.14.14.42.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 14:42:18 -0800 (PST)
Date: Sat, 15 Feb 2025 06:42:08 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Alexander Sverdlin <alexander.sverdlin@gmail.com>, 
	AnnanLiu <annan.liu.xdu@outlook.com>, chao.wei@sophgo.com, unicorn_wang@outlook.com, 
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	Inochi Amaoto <inochiama@gmail.com>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] riscv: dts: sophgo: add watchdog dt node for CV1800
Message-ID: <dxxc42mcdw6jlpk4lffyxqci7d6bamc7q5wsfdcx62snacbw2e@jrvrllwdb6t6>
References: <DM6PR20MB2316366FC9ADCBC7B6E9C289AB7A2@DM6PR20MB2316.namprd20.prod.outlook.com>
 <f6b036acada7686e1bfd814bd62782890bf35a50.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f6b036acada7686e1bfd814bd62782890bf35a50.camel@gmail.com>

On Fri, Feb 14, 2025 at 01:58:15PM +0100, Alexander Sverdlin wrote:
> Hi Annan, Inochi,
> 
> On Thu, 2024-01-25 at 17:46 +0800, AnnanLiu wrote:
> > Add the watchdog device tree node to cv1800 SoC.
> > 
> > Signed-off-by: AnnanLiu <annan.liu.xdu@outlook.com>
> > ---
> > This patch depends on the clk driver and reset driver.
> > Clk driver link:
> > https://lore.kernel.org/all/IA1PR20MB49539CDAD9A268CBF6CA184BBB9FA@IA1PR20MB4953.namprd20.prod.outlook.com/
> > Reset driver link:
> > https://lore.kernel.org/all/20231113005503.2423-1-jszhang@kernel.org/
> > 
> > Changes since v1:
> > - Change the name of the watchdog from watchdog0 to watchdog.
> > - Change the status of watchdog.
> > v1 link:
> > https://lore.kernel.org/all/DM6PR20MB23160B8499CC2BFDAE6FCACDAB9EA@DM6PR20MB2316.namprd20.prod.outlook.com/
> > 
> > 
> >  arch/riscv/boot/dts/sophgo/cv1800b-milkv-duo.dts |  4 ++++
> >  arch/riscv/boot/dts/sophgo/cv1800b.dtsi          | 16 ++++++++++++++++
> >  2 files changed, 20 insertions(+)
> > 
> > diff --git a/arch/riscv/boot/dts/sophgo/cv1800b-milkv-duo.dts b/arch/riscv/boot/dts/sophgo/cv1800b-milkv-duo.dts
> > index 3af9e34b3bc7..75469161bfff 100644
> > --- a/arch/riscv/boot/dts/sophgo/cv1800b-milkv-duo.dts
> > +++ b/arch/riscv/boot/dts/sophgo/cv1800b-milkv-duo.dts
> > @@ -36,3 +36,7 @@ &osc {
> >  &uart0 {
> >  	status = "okay";
> >  };
> > +
> > +&watchdog {
> > +	status = "okay";
> > +};
> 
> It would be necessary in all SoCs unless... [1]
> 
> > diff --git a/arch/riscv/boot/dts/sophgo/cv1800b.dtsi b/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
> > index aec6401a467b..03ca32cd37b6 100644
> > --- a/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
> > +++ b/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
> > @@ -1,6 +1,7 @@
> >  // SPDX-License-Identifier: (GPL-2.0 OR MIT)
> >  /*
> >   * Copyright (C) 2023 Jisheng Zhang <jszhang@kernel.org>
> > + * Copyright (C) 2024 Annan Liu <annan.liu.xdu@outlook.com>
> >   */
> >  
> >  #include <dt-bindings/interrupt-controller/irq.h>
> > @@ -103,6 +104,21 @@ uart4: serial@41c0000 {
> >  			status = "disabled";
> >  		};
> >  
> > +		watchdog: watchdog@3010000{
> > +			compatible = "snps,dw-wdt";
> > +			reg = <0x3010000 0x100>;
> > +			interrupts = <58 IRQ_TYPE_LEVEL_HIGH>;
> > +			clocks = <&pclk>;
> 
> &osc ?
> 

This patch is submitted to early, before the clock driver is
applied. This reason applies to your all question.

> > +			resets = <&rst RST_WDT>;
> > +			status = "disabled";
> 
> [1] ... the status here is dropped. What is the reason for disabling it in the first place?
> 
> > +		};
> > +
> > +		pclk: pclk {
> > +			#clock-cells = <0>;
> > +			compatible = "fixed-clock";
> > +			clock-frequency = <25000000>;
> > +		};
> > +
> >  		plic: interrupt-controller@70000000 {
> >  			compatible = "sophgo,cv1800b-plic", "thead,c900-plic";
> >  			reg = <0x70000000 0x4000000>;
> 
> Why didn't it go into cv18xx.dtsi?
> 
> -- 
> Alexander Sverdlin.
> 


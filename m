Return-Path: <linux-kernel+bounces-383906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DC9D9B21A9
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 02:01:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1D53B20D3F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 01:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A72B612B17C;
	Mon, 28 Oct 2024 01:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DsWGjqbL"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1128BEC;
	Mon, 28 Oct 2024 01:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730077287; cv=none; b=cr/kEVkVN7jmiXWx9f5acGyuDBG2be93Zl0mpXKKkUKQ0HOl0OUjDvId2ADe+YkZYDNgksTtvnh9+8EFb76KwmerxvubHNNihb4gbHAXjrsIkvcRtg5P08xyasvhCRUZLPi5GtgewDOskqtqYUp/tAgk9r73eVrcYz5sCB7ZrnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730077287; c=relaxed/simple;
	bh=da4+/YbrvNCEbtsdpOKnAV+F4+7H7ikQs4VE0NFYecg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=usr7eLzMafTS3BLyIdklGwuDdXEB3Zh+L7pVs8bMIW6BvCKAseEeJvGln0iQjyvkfDvSoTrwcm4X83tBtrPFmiVPiSRg/UgfB7S9wk5HzR4NtViws9HeNH4apHCoD5KbEASWcFBI49z9plS3umb5VEGP6+11jiyKHYgccEc1Uzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DsWGjqbL; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-20cb7139d9dso31966985ad.1;
        Sun, 27 Oct 2024 18:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730077284; x=1730682084; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TGuyzdjNbGUg4wkS1hddfWef9vyA9xzodf4AE2EckOY=;
        b=DsWGjqbLgT3kpAy9YIn2nFORmMJFLkZ5kAeqYiLvrFQuckwZ4AGMJq0q/HceKJk3Ci
         OyT/S8IBeyYEJxSxRVPSLRHPcfjBYebl2uO52Qhcxla4JAEH28cqUO8L7W/b8f9fHkGu
         A2FZPmuslxLeAYZtUfnLF1mx871SeQr7nK5sQIs+QpWQxh1d5FmHR6FNPL5ZIefw45KT
         DXIdrniBTb9fyOu018mShkP+7HoDEFBkuTEF0YjNj1D5GnjfVvXIKioxCcDEVQ4mGh+l
         c4ji2HboPjM136tihTgBMX4tINvj3Dfxdz//KkoOMF/KrIhqkUeLxj6I4ggQ3DHRbFiE
         Mh5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730077284; x=1730682084;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TGuyzdjNbGUg4wkS1hddfWef9vyA9xzodf4AE2EckOY=;
        b=u9FVOXO0BwHMCrYOilOG/lgEx7iATaKPDJ2/5H0ckQq9Hp7bpT0Ot266pdrBOwyget
         TaXa3AiBPFaYfuyPSAsEzVgQ8jl8c8QF3nnkEUu1TgzVagTPXeT6Fc17e2xnKf7Ij380
         rbjJ0G1hbeoJ4lSogeegpWzNBQI+xaHKFzcnwApZNdSkn1aXxH0Evj2pZH0678AdqeUq
         SKAWYvYr/dZ1j4ikruq6R7T43Q9NdL2lFOjE41GTG3cklP0w+aXOLZGAECmr2a2+GVn1
         JZPHS5JQWyA3PjZjyw33xwAff1SE4JZjnCOq+AFYLyNoTdPVhBwOPqpe5RxXEe47eFSR
         KwVw==
X-Forwarded-Encrypted: i=1; AJvYcCW9SPYzEAvyyCwddiQpDdB5Tf1Z48FNh3H1vePbgcEzfGxSyELgCKVIVfYhsKW/XOPWzlg5UMrfQ4jxOGfZ@vger.kernel.org, AJvYcCXAmDHGB//eigCUhIM5L1m4mryWVHTK4kou+AXoy/fVz6BrlDo5JfrRWm9jDzeV72RVfGp1s8Z828qj@vger.kernel.org
X-Gm-Message-State: AOJu0YwcnJ4hpzqi3NeiwxaJ9uNVqQOPm5yC/fBvyzXDPuoKJPQl47gL
	WTVSDq9lW15rxpD1+5mDSPq35oCdJlDV02I8ln5r09PxhOFrWwYj
X-Google-Smtp-Source: AGHT+IHsjV0smfvIDlYkmXNEvrusWQRxls/Itp84biZuwx87rVzyEPjTIFEByyu7uUH8BnSuAyfbfA==
X-Received: by 2002:a17:90a:d481:b0:2e0:d957:1b9d with SMTP id 98e67ed59e1d1-2e8f1071c8dmr9314209a91.13.1730077284426;
        Sun, 27 Oct 2024 18:01:24 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e77e515126sm7846162a91.30.2024.10.27.18.01.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2024 18:01:24 -0700 (PDT)
Date: Mon, 28 Oct 2024 09:00:59 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Thomas Bonnefille <thomas.bonnefille@bootlin.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Chen Wang <unicorn_wang@outlook.com>, Inochi Amaoto <inochiama@outlook.com>, 
	Chao Wei <chao.wei@sophgo.com>, Conor Dooley <conor@kernel.org>
Cc: Albert Ou <aou@eecs.berkeley.edu>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Samuel Holland <samuel.holland@sifive.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	=?utf-8?Q?Miqu=C3=A8l?= Raynal <miquel.raynal@bootlin.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v5 1/2] riscv: dts: sophgo: Add initial SG2002 SoC device
 tree
Message-ID: <3vn2m4cgntx6c4y3rgkq7eqdlmlddgzi5w76nyprsle56h6sbh@j4liekhs42av>
References: <20241010-sg2002-v5-0-a0f2e582b932@bootlin.com>
 <20241010-sg2002-v5-1-a0f2e582b932@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241010-sg2002-v5-1-a0f2e582b932@bootlin.com>

On Thu, Oct 10, 2024 at 05:07:06PM +0200, Thomas Bonnefille wrote:
> Add initial device tree for the SG2002 RISC-V SoC by SOPHGO.
> 
> Signed-off-by: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
> ---
> The commit adding the bindings for the compatible "sophgo,sg2002-clint"
> has been applied to Daniel Lezcano git tree. This commit may trigger the
> bots because of this missing binding.
> ---
>  arch/riscv/boot/dts/sophgo/sg2002.dtsi | 42 ++++++++++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
> 
> diff --git a/arch/riscv/boot/dts/sophgo/sg2002.dtsi b/arch/riscv/boot/dts/sophgo/sg2002.dtsi
> new file mode 100644
> index 0000000000000000000000000000000000000000..242fde84443f0d6a2c8476666dfa3d72727071b1
> --- /dev/null
> +++ b/arch/riscv/boot/dts/sophgo/sg2002.dtsi
> @@ -0,0 +1,42 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Copyright (C) 2024 Thomas Bonnefille <thomas.bonnefille@bootlin.com>
> + */
> +
> +#include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/pinctrl/pinctrl-sg2002.h>
> +#include "cv18xx.dtsi"
> +
> +/ {
> +	compatible = "sophgo,sg2002";
> +
> +	memory@80000000 {
> +		device_type = "memory";
> +		reg = <0x80000000 0x10000000>;
> +	};
> +
> +	soc {
> +		pinctrl: pinctrl@3008000 {

I got the following waring:
arch/riscv/boot/dts/sophgo/sg2002.dtsi:20.28-25.5: Warning (simple_bus_reg): /soc/pinctrl@3008000: simple-bus unit address format error, expected "3001000"

Could you send a fix patch?

Regards,
Inochi

> +			compatible = "sophgo,sg2002-pinctrl";
> +			reg = <0x03001000 0x1000>,
> +			      <0x05027000 0x1000>;
> +			reg-names = "sys", "rtc";
> +		};
> +	};
> +};
> +
> +&plic {
> +	compatible = "sophgo,sg2002-plic", "thead,c900-plic";
> +};
> +
> +&clint {
> +	compatible = "sophgo,sg2002-clint", "thead,c900-clint";
> +};
> +
> +&clk {
> +	compatible = "sophgo,sg2000-clk";
> +};
> +
> +&sdhci0 {
> +	compatible = "sophgo,sg2002-dwcmshc";
> +};
> 
> -- 
> 2.47.0
> 


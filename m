Return-Path: <linux-kernel+bounces-367706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0E549A05A6
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 11:37:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B26CD28A156
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 09:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19B57205158;
	Wed, 16 Oct 2024 09:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EAx/kyrR"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03EF3205E08
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 09:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729071414; cv=none; b=BbRejvhhKsxrFZtV46aExEAvmx6pj86VBezrzPFu/PFAFRYdvjUXRelOk1KZvis/9y8DGAmdopwlZ47R4/2Im9ehRDZ/ds3GYDYcIitgTsl1qm5aQqN/Ny2gsaC7UNRD+4R+0Rn+2cqXgjnjJ+xgg9ihA5oEZ8VXk5ya+2iFFfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729071414; c=relaxed/simple;
	bh=AF2PqunK1k+XUN3mW+Re5acyYvzfPCvF2Hb4iVv5SHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LhSjzSm5UcOW8TTiea3kVuaclyg4JZE3dWPCrRcwjDsJsdGwDPu5scnZLnSLTVjbq2+6W+EER3BEQsV9U0yA7iE9cg8OJKXe9sD1IVKrv/Y0ZrDELuD2OGjVEa6NXTkGZ8EUQU6QxfptSrrF4sQD75Yw/vtYqJHeW/iEBfvmfaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EAx/kyrR; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43118c9a955so53790815e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 02:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729071411; x=1729676211; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fxIP+503HmacKr52hF4cwN6vKpq9JVczVJoJF+op9ME=;
        b=EAx/kyrR+Av9RHjIel0Zk3ZKOguBI9KYZ6RbiPrEEYx2C+2zc6dvaNTdxpell8VDdl
         pFWF6ADVL/tlDRE0jIXOH13tDqy1cuRUBvFHCz8CO2eYbGL/fzcsV09s2MFr2WsLupHw
         QPOtADxtEgWUH9Cm2o2t1deJokwjiFGtcHPkW4sodffi+UGP2kqJGZDv1Jh6vl/y8Cem
         EgO/ALORlGfXAx6ttwtVpSkyfIqvIp2zmOdSf2cdjLYAbBjIJCSRUGKeMYX7uw96pGAI
         416T0+sobZRvZrop9E/MCsxs+SGCpjwsdoyK8kN4iSgvvCjO8ZUijJ/vJv40a+nFcISu
         c2tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729071411; x=1729676211;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fxIP+503HmacKr52hF4cwN6vKpq9JVczVJoJF+op9ME=;
        b=AU1sVrxfOigiEmQumm0i684sg+HUqUl32oGcZNkQiDHYHu9CMBurrqiDWVoAJDMU4T
         dGUV/jGL3OQLGWRh7nsy2yyOvIlW+O2vxNH+waS2FvX9bABJijZPMvRRPFgcRpI2nDJp
         Bgk0APz0RDMHzKpLOdpmxhcVTLbM7fbNMqyVi99e+d06T+9fk3ELCVN8M7ZlmafkvNic
         rn8vXlS+PhhEhl2V4nwQBU7j3xniSo/IgrOrX0TxzPQy3AFzacyy9hLrCRQ2++LccZCF
         3UwFsF7lrWI0KnpfEPjfvfyksSAkg4BkEfEUPOmac8iaDVRzsTIXCp885WfvRoeoScOO
         TwEg==
X-Forwarded-Encrypted: i=1; AJvYcCUF6PVy6oXmo03jOeTqfesSjuPv9vdvxynDFO6ur+G6MMBPEMIoS+xDHexQBkbmDEku0I2cv1K+8yTDbxw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdIVlHGomQJXKpNiLtVzslgnhWnxmcbpSaFGM4r50/6+6SgtYN
	ABspLUsDAoM8aaEKQL4TJOa9/jZAGnxuCj0JoXUVZKbqVV4eh4lHD578rB5NfzE=
X-Google-Smtp-Source: AGHT+IG6fNHMCd9wfwMroBHIryaVFXQVYfqJpieR0jsQIFDOAiMSqq1/ES6dB3VtdNGRUPAFimGMVw==
X-Received: by 2002:a05:600c:3555:b0:42c:bb96:340e with SMTP id 5b1f17b1804b1-4311df56158mr144236185e9.31.1729071411221;
        Wed, 16 Oct 2024 02:36:51 -0700 (PDT)
Received: from linaro.org ([82.76.168.176])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d7fc123dasm3798064f8f.94.2024.10.16.02.36.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 02:36:50 -0700 (PDT)
Date: Wed, 16 Oct 2024 12:36:48 +0300
From: Abel Vesa <abel.vesa@linaro.org>
To: Pengfei Li <pengfei.li_1@nxp.com>
Cc: krzk+dt@kernel.org, robh@kernel.org, abelvesa@kernel.org,
	mturquette@baylibre.com, sboyd@kernel.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, ping.bai@nxp.com,
	ye.li@nxp.com, peng.fan@nxp.com, aisheng.dong@nxp.com,
	frank.li@nxp.com, kernel@pengutronix.de, festevam@gmail.com,
	linux-clk@vger.kernel.org, imx@lists.linux.dev,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/4] clk: imx93: Move IMX93_CLK_END macro to clk driver
Message-ID: <Zw+JMMUOErRKqEH1@linaro.org>
References: <20241014182438.732444-1-pengfei.li_1@nxp.com>
 <20241014182438.732444-2-pengfei.li_1@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241014182438.732444-2-pengfei.li_1@nxp.com>

On 24-10-14 11:24:35, Pengfei Li wrote:
> IMX93_CLK_END was previously defined in imx93-clock.h to indicate
> the number of clocks. However, it is not part of the ABI. For starters
> it does no really appear in DTS. But what's more important - new clocks
> are described later, which contradicts this define in binding header.
> So move this macro to clock driver.
> 
> Signed-off-by: Pengfei Li <pengfei.li_1@nxp.com>
> ---
>  drivers/clk/imx/clk-imx93.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/clk/imx/clk-imx93.c b/drivers/clk/imx/clk-imx93.c
> index c6a9bc8ecc1f..c8b65146e76e 100644
> --- a/drivers/clk/imx/clk-imx93.c
> +++ b/drivers/clk/imx/clk-imx93.c
> @@ -15,6 +15,8 @@
>  
>  #include "clk.h"
>  
> +#define IMX93_CLK_END 202
> +

Sorry for this back and forth.

I've been discussing this off-list with Krzysztof and others and
now I think this is actually not wrong.

So:

Reviewed-by: Abel Vesa <abel.vesa@linaro.org>

>  enum clk_sel {
>  	LOW_SPEED_IO_SEL,
>  	NON_IO_SEL,
> -- 
> 2.34.1
> 


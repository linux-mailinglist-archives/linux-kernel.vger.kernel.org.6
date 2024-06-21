Return-Path: <linux-kernel+bounces-223862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69AFD911985
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 06:35:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DA2D1C217D6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 04:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2866612C7FB;
	Fri, 21 Jun 2024 04:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bZt6ex5o"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1B9EBE
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 04:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718944546; cv=none; b=beqXFWr22u43NUV7u1XYlIsa68cuL1X7EyBP2m4nXuqb1fF3zUbRQQto0KiMLhhnqTuabZ2vlXeRTP5yk1wLWCtRb+OBVpMh8U6O4QhrFyf273etCmO0Ju/Yon4SB+OLK/7mBYzNBswBG5boPfNg8hR1dlozcw8DTFQaWNno0kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718944546; c=relaxed/simple;
	bh=F0/IEQHK4NYukk9YktmoTxchz1Hr9pucQDHiX73lGMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eECyZvbJrFUjK1WIq7tuBHVFaR7FIaZSxUmAMHYQrPT8NtCLoB4EtQE/uH26dPiox2ztrMF3kC1qmyx+Gx3i52VLcvrLFvQf9cFS2Sjoqpv+OTWhrW+NZwA7q5Ur3B2hPGCQneL37z9805mhwNn6LDt1g/mNzABbf5xKNnruzBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bZt6ex5o; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52bc335e49aso1759269e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 21:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718944543; x=1719549343; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qQx67tCsQc9ncbiFWlfbAhhvQ0ez57Hz7TCMM1DLrFE=;
        b=bZt6ex5ovoXxUamgFEX14ZKMs7p9c6HGYoxu3eCZN+Kc4jS2K27V/yHtRQhupb/6hX
         Wh0hLa+u9L5Va9KQYa5/lcd6xCB9gusm23Stt23JrHVugglMDwx4uKEfW3mn8TrpGVyx
         PExOLXnGbgRCLlYVg8flWK14BEcvOMMTnbW3pXx3gJ9am+MApOOQzKSDSXRvuFBSTePY
         5jgj2Inq80pQdur4FDwcKjlTomXUX5eks8KCIyxbbk7WkhtqQOkvzClS557uwVklhRwh
         vN0GHpnp2lV/+S0pcq+LMW99U2NyyYIv29AMfuI19RKHWPRoZR2nqh/jrIzHlikexwoq
         T6UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718944543; x=1719549343;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qQx67tCsQc9ncbiFWlfbAhhvQ0ez57Hz7TCMM1DLrFE=;
        b=atD8KMyU3v0nUB09OU3QC8qi29T2BomhAUUJi998Gy6nE9ikxvEvbaKJ/g3WSILBlE
         pqNBteQmOmWHmF95/599qifsrzi6OCe63IOjRJvIgJrfEOHEiP5GTpeCiAV7ozAFEZTo
         S5SBKq/OFawsdo4V3e67o79eyYtT4wTIIHDT5YETibubYPHUnc+Sy6020fakBCmuyVLk
         C6AUav8zrUwloUDoBMCL68j0A7EkgjTmJ6cJjmiBHc+OAehynKDd23qXZeJZkoDhX4uu
         UobQDfdHRe/k+UWzNDWy+js35jq4dCMyo9hv671j57W+PyfUvpxfyVr7qZdafMHlY0WU
         nWdQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCch0bm8I72i4Nxnn6/vb4Zn/SU/HbuoiRuyJEXioi+ltA0hRtDHxRTx4GYo6Z0SF5vswxY+Sa1dxrlkyb6rpobZN0zCgwEJreF0FN
X-Gm-Message-State: AOJu0Yx9Xh8c35Sh74dYL8zc8e58Qda/WeXI49xThjXsGhEaFuTGbVjY
	gBuOr+nqbLVfUNtYh2tkWz1hP8XrOomEryBbVGqyux0udkrGwO219rIPVz5hjfw=
X-Google-Smtp-Source: AGHT+IHLs9cD/51RoIAFFl2xG3t848k8TnB+ORN3BmrfiSJJIYHz/ijJxpMNl2c0/ckODh2VcfGGGg==
X-Received: by 2002:a05:6512:3e21:b0:52c:95d1:87ae with SMTP id 2adb3069b0e04-52ccaa5954cmr5112985e87.12.1718944542591;
        Thu, 20 Jun 2024 21:35:42 -0700 (PDT)
Received: from linaro.org ([82.79.124.209])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4247b608f94sm27434495e9.0.2024.06.20.21.35.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 21:35:42 -0700 (PDT)
Date: Fri, 21 Jun 2024 07:35:40 +0300
From: Abel Vesa <abel.vesa@linaro.org>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: abelvesa@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, imx@lists.linux.dev, linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V3 00/15] clk: imx: misc update/fix
Message-ID: <ZnUDHCHbA6izeV6B@linaro.org>
References: <20240607133347.3291040-1-peng.fan@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240607133347.3291040-1-peng.fan@oss.nxp.com>

On 24-06-07 21:33:32, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 

Whole series LGTM.

Reviewed-by: Abel Vesa <abel.vesa@linaro.org>


> Changes in v3:
> - Drop two patches
>       clk: imx: pll14xx: Add constraint for fvco frequency
>       clk: imx: pll14xx: use rate_table for audio plls
> - Update 8ULP PCC check to not return Error
> - Update commit log and Add R-b for 
>   "clk: imx: imx8mp: fix clock tree update of TF-A managed clocks"
> - Link to v2: https://lore.kernel.org/all/20240510-imx-clk-v2-0-c998f315d29c@nxp.com/
> 
> 
> Changes in v2:
> - Drop "clk: imx: pll14xx: potential integer overflow eliminated by
>        casting to u64"
> - Add Fixes tag  "clk: imx: imx8mp-audiomix: remove sdma root clock"
> - Link to v1: https://lore.kernel.org/r/20240504-imx-clk-v1-0-f7915489d58d@nxp.com
> 
> Upstream several patches landed in NXP downstream repo for some time.
> - i.MX8M/93/7ULP composite clk update
> - Fix Fracn-gppll MFN got lost
> - PLL14xx update
> - i.MX8MP DRAM CLK fix
> - i.MX8MM/N misc update
> - Init i.MX8QXP parent clk before child clk
> 
> Downstream tags are kept for the patches got R-b
> 
> Although there are a few fixes, non-urgent for 6.10.
> 
> Adrian Alonso (1):
>   clk: imx: imx8mn: add sai7_ipg_clk clock settings
> 
> Jacky Bai (2):
>   clk: imx: composite-93: keep root clock on when mcore enabled
>   clk: imx: imx8mm: Change the 'nand_usdhc_bus' clock to non-critical
>     one
> 
> Oliver F. Brown (1):
>   clk: imx: imx8qxp: Add clock muxes for MIPI and PHY ref clocks
> 
> Peng Fan (8):
>   clk: imx: composite-8m: Enable gate clk with mcore_booted
>   clk: imx: imx8mp-audiomix: remove sdma root clock
>   clk: imx: Remove CLK_SET_PARENT_GATE for DRAM mux for i.MX7D
>   clk: imx: add CLK_SET_RATE_PARENT for lcdif_pixel_src for i.MX7D
>   clk: imx: imx8qxp: Add LVDS bypass clocks
>   clk: imx: imx8qxp: Register dc0_bypass0_clk before disp clk
>   clk: imx: imx8qxp: Parent should be initialized earlier than the clock
>   clk: imx: fracn-gppll: update rate table
> 
> Pengfei Li (1):
>   clk: imx: fracn-gppll: fix fractional part of PLL getting lost
> 
> Ye Li (1):
>   clk: imx: composite-7ulp: Check the PCC present bit
> 
> Zhipeng Wang (1):
>   clk: imx: imx8mp: fix clock tree update of TF-A managed clocks
> 
>  drivers/clk/imx/clk-composite-7ulp.c  |  7 ++++
>  drivers/clk/imx/clk-composite-8m.c    | 53 +++++++++++++++++++++------
>  drivers/clk/imx/clk-composite-93.c    | 15 ++++----
>  drivers/clk/imx/clk-fracn-gppll.c     |  6 +++
>  drivers/clk/imx/clk-imx7d.c           |  6 +--
>  drivers/clk/imx/clk-imx8mm.c          |  2 +-
>  drivers/clk/imx/clk-imx8mn.c          |  1 +
>  drivers/clk/imx/clk-imx8mp-audiomix.c |  1 -
>  drivers/clk/imx/clk-imx8mp.c          |  4 +-
>  drivers/clk/imx/clk-imx8qxp.c         | 51 +++++++++++++++++---------
>  10 files changed, 103 insertions(+), 43 deletions(-)
> 
> -- 
> 2.37.1
> 


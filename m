Return-Path: <linux-kernel+bounces-517687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D3EA38474
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 14:22:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67ACA3B7DF8
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 13:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12BEB21D591;
	Mon, 17 Feb 2025 13:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X7JPNx5c"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C4021D3CF
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 13:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739798044; cv=none; b=aGufaB3ivtkPi+yksaILliUtq5g8FI4OwHJlq6avT7ZuGQVdaGfM6v90RZ0VER3z5r1rwXl02cQPI18dTmqOiC8+9cR82smce/jkJXbAVJuoaL1XIyboUE77ptFTNfxw2TW8JDZsodqjkX9x2iLnJll5NdRr09h1J5W9NJ8eoqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739798044; c=relaxed/simple;
	bh=v53bveOasZX2OiI2BS6B6x9DX4sZM1Fga2RltdlQcS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zeed0CaL4pvmj9+Gmp/vI4Z6Jdow6PYVliFBH3CJvz2LUT4Z+TKAO3mSBAYbPEWPwD5QViYeSkhqXOBEiGs59w6b4BHeih4psRvefEtcrfPZXYRtYXOQjDQZr9z6EOWTdxgOAT0NZNNCyrjX4yTFdLzCAvXFY3GCgDENG1S+t5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=X7JPNx5c; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5452d9d0d47so2382827e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 05:14:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739798040; x=1740402840; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vZutIcnMmP6iI6i3LYjXGBl6USSBwuenG5p8HEpR4ZU=;
        b=X7JPNx5cJAFzS5TlL0Xn6XexXVkO6p/uArZPoIoJ0Ggw7W7Qy3JrLA7hI4azpgAfZB
         WF1iit6kQWoRbmbjqUZQrf1MFOT8tz6T5u348Nrbn4I5KtLqoj/BcYsOw0AY1juHfISA
         HUoyAHgDGwHsvmfiHD2z+xO5EnldLVOmk1hbRqzoe2SUsefp+Gs4TjFUKdHaw9c9juIr
         KpKnL0d3JAOfICz6PlN6Xrn58MuVNRTZwKKVzJxpRBp0zYdZ/Z61pRUan8Wp0bZdJ9GZ
         RBNoYgeMal1cy6so/Jw6wjiYAnwtoNA0HUXeypRBx9gTPPyqJniKp/QW/i5T4hipNNaP
         X8MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739798040; x=1740402840;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vZutIcnMmP6iI6i3LYjXGBl6USSBwuenG5p8HEpR4ZU=;
        b=gmSq6lY5bZDUhSwpYyGjmwzIaNwPnakAuCW05ahDPkF1rNkEGLFx+/cB9SLl5HuIEv
         +iOpmw1edwHcMxMqGFu+Y5NSzX/Cg7OoAoVdNmBEpvRJmPoc3+YoAQ9bUSfBT3wXeIXP
         5Sh/vicZQLRiZ7SPAjaVQ4Qb6B18Ok+fBxCuEYH+fXpdFk8Ur4SerKbUhbPFF52VQQ4q
         KIrd1N3c1LMyj920wlhq6Yo3ML4PHXlUDuOERc7eixNxmzUG2CTpio9DTFBECJ7RFKEg
         ewzAlr0PmoAi0O2NbxfyBAREq+jRBYXhGA7S6RekUCldpCYeFMkmY+F5K2MWP3wyBN1N
         youA==
X-Forwarded-Encrypted: i=1; AJvYcCXGwrCkQLwo6oPNfGUmKY4licO5IlF9rmkT5yeHOCabSwjqVzd6DlcWHtO41lFg/NcL3VTIze2QmkMW/7Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBTXiB9DJCRV5DMqHorgo54JB5a4Dz5MRJ5OpxZsvo8+f5qLP5
	TwAlcP6yK8qf95KIV4TCY2oy7x78qa9jWI0Luld71n+ebaZVYHe3uGg429FKNnc=
X-Gm-Gg: ASbGncun7IVbmDfrYZlNrgYi4+lx2eGYgc/ejn77F7X39NeBWmjvju5BCzGlq9xrwYS
	kJpc0W7yds3LZ8ExvMq4rtXs3YK5ueiNgB1x2NLpXbCaPe8gTxliGkuzG+ZoCml2bFzyMg2P/m5
	iNvyiqo5n5pRrjPudKsNB0cQITVDdPo+1NaXZf6bILt7NGPcaggbVjx3NkCibbkONKXrI0DlIlH
	VXEkOTjqVnX0XlwOE9qzHOc8xQdL8HUcagDgx1mMNdKROJFazO3weVuc3vz9WyHHMuFQ+MpugtG
	SYQEw8GOwkal3LqZb24Qd15j6c0sX8LZ4JI8zZ1iI8rIR2Ah5fexzisjILGy6Dhx1AijcQo=
X-Google-Smtp-Source: AGHT+IGqa8xFmHNzImtW+A+QLQpzg9FHImgPsXMU8Ep2PbCLqkenGCdKllB7ykd8l9t74TkwpnVpHQ==
X-Received: by 2002:a05:6512:1593:b0:545:85f:6a46 with SMTP id 2adb3069b0e04-5452fe8fc2amr3163114e87.52.1739798040527;
        Mon, 17 Feb 2025 05:14:00 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5461f0d74e6sm536349e87.170.2025.02.17.05.13.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 05:14:00 -0800 (PST)
Date: Mon, 17 Feb 2025 15:13:58 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Clark <robdclark@gmail.com>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Jonathan Marek <jonathan@marek.ca>, 
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, Rob Clark <robdclark@chromium.org>
Subject: Re: [PATCH v4 4/4] drm/msm/dsi/phy: Define PHY_CMN_CLK_CFG[01]
 bitfields and simplify saving
Message-ID: <ocxifv24wxghio3gfoychilmmjsxpeypxkzidspoq2e4dor7ja@wc54pryzyjge>
References: <20250217-drm-msm-phy-pll-cfg-reg-v4-0-106b0d1df51e@linaro.org>
 <20250217-drm-msm-phy-pll-cfg-reg-v4-4-106b0d1df51e@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250217-drm-msm-phy-pll-cfg-reg-v4-4-106b0d1df51e@linaro.org>

On Mon, Feb 17, 2025 at 12:53:17PM +0100, Krzysztof Kozlowski wrote:
> Add bitfields for PHY_CMN_CLK_CFG0 and PHY_CMN_CLK_CFG1 registers to
> avoid hard-coding bit masks and shifts and make the code a bit more
> readable.  While touching the lines in dsi_7nm_pll_save_state()
> resulting cached->pix_clk_div assignment would be too big, so just
> combine pix_clk_div and bit_clk_div into one cached state to make
> everything simpler.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Changes in v4:
> 1. Add mising bitfield.h include
> 2. One more FIELD_GET and DSI_7nm_PHY_CMN_CLK_CFG1_DSICLK_SEL (Dmitry)
> 
> Changes in v3:
> 1. Use FIELD_GET
> 2. Keep separate bit_clk_div and pix_clk_div
> 3. Rebase (some things moved to previous patches)
> 
> Changes in v2:
> 1. New patch
> ---
>  drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c             | 13 ++++++++-----
>  drivers/gpu/drm/msm/registers/display/dsi_phy_7nm.xml |  1 +
>  2 files changed, 9 insertions(+), 5 deletions(-)
> 
> @@ -739,7 +741,8 @@ static int pll_7nm_register(struct dsi_pll_7nm *pll_7nm, struct clk_hw **provide
>  		u32 data;
>  
>  		data = readl(pll_7nm->phy->base + REG_DSI_7nm_PHY_CMN_CLK_CFG1);
> -		writel(data | 3, pll_7nm->phy->base + REG_DSI_7nm_PHY_CMN_CLK_CFG1);
> +		writel(data | DSI_7nm_PHY_CMN_CLK_CFG1_DSICLK_SEL(3),
> +		       pll_7nm->phy->base + REG_DSI_7nm_PHY_CMN_CLK_CFG1);

Nit: should this also be using dsi_pll_cmn_clk_cfg1_update() ?

>  
>  		phy_pll_out_dsi_parent = pll_post_out_div;
>  	} else {

-- 
With best wishes
Dmitry


Return-Path: <linux-kernel+bounces-517913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DEE3A38754
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 16:16:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30DF93A95BD
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 15:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35ED02236F6;
	Mon, 17 Feb 2025 15:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VGliM71j"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA10223BB
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 15:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739805394; cv=none; b=QyqdoXGQFZ7qdu2J9hCWICdssTie6pY3wk5FbiSKUZFZSVzwW/U6t4e9Lvc7OgEzTz94U5oSpePvLRaXqOFHH5hhbqNxqfuFLSlArLAUND2LKCdwjGckeCCa4xs/BHsTRnDwz5Ipat//yqnRPIPbc7Oxy98BZz0XWh5W0Q8nGC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739805394; c=relaxed/simple;
	bh=G2gQZTBQ4WkAjjo748dOhOV1vedDR35EheFeys46r78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oOHLcDzPf+ASba61wjetRfekdIFaI5T6TiVNd4yii5v2O7hto60tSFeJ8pErvSgrcJOg6ziGxcXwZDW8sPYZnahBk71cUeJ2i4fTlHYJga4qzUZTdVuRoyTqHEvmbOG7dpGKXipANkY+ppMggsUeRavYt7f3NN/lSUxh+LWTa7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VGliM71j; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5453153782aso1961890e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 07:16:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739805391; x=1740410191; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PsHNJZf4gBUaXZ8wW29cD/eT1WPiatSWZEkxIO7LMjQ=;
        b=VGliM71jSvWNFiJk3wdfEYcv+fsXNjsjxiFJBVEtJA91EY2VE2pv8UnHSv4gLtNg2X
         HLqNlgMTxxlYvGVcDndWf0lkiWkBy2drQenF0VDKXjn+0zQBT+0g/DOwzKC+Eyt8/tFT
         LD+Qr2OHs8M+khs0QrvN9N8rN/Nx5mU2EUBafCgRNz413vSN6JLE/wjQybtgmHhq3M5u
         al0GWLQIc0k3V84IpYXv6TdGq5rsXbLxYYIdK88boYh3LwwBe4S1NunSfuTAawqnFFO5
         InP08qb7DH3ezwLufE4jVbIIPB3abMTM1aPbb3fPWzFjPx4UH2WQso5EBmBW3W3KSzro
         h03g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739805391; x=1740410191;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PsHNJZf4gBUaXZ8wW29cD/eT1WPiatSWZEkxIO7LMjQ=;
        b=TNRs2eCiG6E+pL6MXKccn6nqTWMvyM+8aLPSZqaoMQBkRIvwj4XWeFZ+SJAPmJnCrN
         IiD2sDXJsRdCQ85bToclbQyVt+ZVnvVRpdWVzGPztGOk6zJ0Ysz80nUEcm0bNafZE/he
         OXyk65vkF+OlSZ1RaB1XRPX6vAfdBssjV3ssgj2+dHQZN8UuRWP4RjrYag+zEk3km68P
         2fI039EKeGSrxm1pNyjCMHLGRC1PmTuNA22xYR/Xfso4124/V/HXejzchWnaBaDwM5gd
         QK57a0tWZBUzKH4TkD9sj6JqbrxU8NmXBouYjb8eRM6vYupBn4BFzYHL2IBKkO9q1eLI
         f/1w==
X-Forwarded-Encrypted: i=1; AJvYcCXvl75RSOIaevBQekuEmEcDCJa4GCTpJ88z+KP+1yXqYhE2SLmqV1CbMMlr3uZbSVfl8JeLE0dAqnKbImc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu3fo9t3E5qL/T9rW8hKs6NyhtnMMiIYRW3o830N36ZXN2iSil
	YvYaMdoifpjhXEEbekpQJT/m0PDlcJ5zKgXJ4uG1qtuLyhGSqFrlTXZhY/qXL5M=
X-Gm-Gg: ASbGncsFK3lucMDjHXs+tyka4GCTx1bhfouekhd4kg2IrsA7q3HgLBvdbBrTDC/n0a3
	WxeRZhE4gUDlEC//OY17ps1VY68SU6Trn+SAldOFdbx6K/n5wd2LbBrRBaYBVScAKi8lWOWf5Xx
	u5oxSWp80KX1RcrlwOoHz0O9P9V6wC9H5nlef7UCGz6tZVI5YFHUD4ROIp7K5VaoHsC5f3Wk4fH
	s+9E/2lePio1aBEQZWAXV2ZcoKxxTFzuWHcFPydAFoJLGUYXr1sMXtuzjdemM6QwwERCBjBglf/
	ukM3BDz5ThmITleOfqgXsdqU1ISmh+c3G7B37eyE+2P+cQCslF/iucKWTfmEu01jgR14++Q=
X-Google-Smtp-Source: AGHT+IFYw6tpGjpP7jPGRzku+1SoU+IGeFXOMCovWE5Iolwo1XU7UJdyi6AK5Q+nHB2rwXLxH+SKuQ==
X-Received: by 2002:a05:6512:238a:b0:545:381:70a with SMTP id 2adb3069b0e04-5452fe42483mr3989060e87.15.1739805390495;
        Mon, 17 Feb 2025 07:16:30 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5452fb59e8bsm1043600e87.173.2025.02.17.07.16.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 07:16:30 -0800 (PST)
Date: Mon, 17 Feb 2025 17:16:27 +0200
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
Message-ID: <waevglqatvykntxnmaahjpgbhipxhtcfpn7gfwud4sdidqh3dz@bfm7foignlm4>
References: <20250217-drm-msm-phy-pll-cfg-reg-v4-0-106b0d1df51e@linaro.org>
 <20250217-drm-msm-phy-pll-cfg-reg-v4-4-106b0d1df51e@linaro.org>
 <ocxifv24wxghio3gfoychilmmjsxpeypxkzidspoq2e4dor7ja@wc54pryzyjge>
 <df4cfdb1-66be-4264-aed3-0d5567e721f7@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df4cfdb1-66be-4264-aed3-0d5567e721f7@linaro.org>

On Mon, Feb 17, 2025 at 02:37:31PM +0100, Krzysztof Kozlowski wrote:
> On 17/02/2025 14:13, Dmitry Baryshkov wrote:
> > On Mon, Feb 17, 2025 at 12:53:17PM +0100, Krzysztof Kozlowski wrote:
> >> Add bitfields for PHY_CMN_CLK_CFG0 and PHY_CMN_CLK_CFG1 registers to
> >> avoid hard-coding bit masks and shifts and make the code a bit more
> >> readable.  While touching the lines in dsi_7nm_pll_save_state()
> >> resulting cached->pix_clk_div assignment would be too big, so just
> >> combine pix_clk_div and bit_clk_div into one cached state to make
> >> everything simpler.
> >>
> >> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >>
> >> ---
> >>
> >> Changes in v4:
> >> 1. Add mising bitfield.h include
> >> 2. One more FIELD_GET and DSI_7nm_PHY_CMN_CLK_CFG1_DSICLK_SEL (Dmitry)
> >>
> >> Changes in v3:
> >> 1. Use FIELD_GET
> >> 2. Keep separate bit_clk_div and pix_clk_div
> >> 3. Rebase (some things moved to previous patches)
> >>
> >> Changes in v2:
> >> 1. New patch
> >> ---
> >>  drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c             | 13 ++++++++-----
> >>  drivers/gpu/drm/msm/registers/display/dsi_phy_7nm.xml |  1 +
> >>  2 files changed, 9 insertions(+), 5 deletions(-)
> >>
> >> @@ -739,7 +741,8 @@ static int pll_7nm_register(struct dsi_pll_7nm *pll_7nm, struct clk_hw **provide
> >>  		u32 data;
> >>  
> >>  		data = readl(pll_7nm->phy->base + REG_DSI_7nm_PHY_CMN_CLK_CFG1);
> >> -		writel(data | 3, pll_7nm->phy->base + REG_DSI_7nm_PHY_CMN_CLK_CFG1);
> >> +		writel(data | DSI_7nm_PHY_CMN_CLK_CFG1_DSICLK_SEL(3),
> >> +		       pll_7nm->phy->base + REG_DSI_7nm_PHY_CMN_CLK_CFG1);
> > 
> > Nit: should this also be using dsi_pll_cmn_clk_cfg1_update() ?
> 
> 
> This is before clocks are registered so there is really no chance for
> simultaneous access.
> 
> It is rather then question of code readability or obviousness.

That's why I added it as a nit. I don't think that it's required, but I
think it might improve the patch.

-- 
With best wishes
Dmitry


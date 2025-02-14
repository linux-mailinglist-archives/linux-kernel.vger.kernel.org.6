Return-Path: <linux-kernel+bounces-515188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD95A3617A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 16:22:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2794C189408C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 15:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E755A2673AD;
	Fri, 14 Feb 2025 15:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UGi5HpTG"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC71E266EFE
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 15:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739546353; cv=none; b=mg9hbW1mOqtiQJNEMqEvtdzRPmF77YknLJ4lqzDNkZ8XQmLvV5GFux7BPZ94oY5aBfdfwhIPuIykZTwyVIdTKqqw807s5K1QpzVOwiVy6gDkdbq+yx88xwtRst3ODh7HGB6v9kAb6tKw3IKHOd8wuQCHjluqc9zE6zglg0Kh5rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739546353; c=relaxed/simple;
	bh=QI34gneP6eeV8Oq7CHom0A3/L+8ood8Y1cC/vLDPlGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qm3xBluwYY3ehedewZVvPfqM7bkE3FJQw2zTQx02+loVEBAZzpTRALGmUuvThM69m3K40uvGcnqD19jgiWHQ5WQXAYZFLnlI6XW7jZdUNoDyPuTUpiwwOLxAfBHNFP6gsr5LNiteF/B2R0aA6fdhcaiGpdCew5mHvSxQsisgsAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UGi5HpTG; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-30227c56b11so22361141fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 07:19:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739546350; x=1740151150; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iazVnHSVmXcB7TiTuN2+wvNduJRAxfMyPBRb2NxJE08=;
        b=UGi5HpTG0GdWrgt5mG7o8PXKS43djCblRZJD8oIXwtIW05nbQsqtjjIwEjUva5XIWm
         ACr+NjsWETH7yqkACiaMS/HocT5a/GrcjXVJ/SlFfVgrkky9RAT6WycBXjy9yAAt0yem
         Uw42tCYW13JlNTnycdOZWOtQmLW898v3t/ffu1+mDbcfKoNSKQevCBZIjXMdEBAWDKQO
         fPI/Q+HAtvfF2hHVLtxJ+RL5/cmRBoJTD987Fi91pKUZRNjOd+k2LzvX+r10GV8qM4Vg
         1JJ87kIv9CuhKAKaJHRMb/PXi2bHtRgOG9t49hr1MjaJOJxujcXIrIa8LCf0w3B6a1iG
         7pcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739546350; x=1740151150;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iazVnHSVmXcB7TiTuN2+wvNduJRAxfMyPBRb2NxJE08=;
        b=BNsjjl8+kdVHmu/VbDY0O9LelxgrDcqd8OmI1dBRo27G3aA7ShQrz9WfO2UlQTcZSZ
         iWmOp5KgpvDdBuVfzOHgJ4XXAYWVwkaHVnvCWVlKdFejj16wJbJAbO1LQnAbxB0VNG0O
         BubhSJD+aU2VW+rT3gjLhrwTGmAZXBGDJOv9fKCQ2wcz5IRWgRILHE/r+ns63ftCTCvA
         ugVtH56lC7f+bxWkM/1Md1O4md51+wWkWM/po3oY+Q+689RwzHDA1BWOxuZ7ogz+v9C9
         kKaBtWPyKjzZHNPCDxtonUnKVng/KXbBtpZlJRgfEtkdPqmwHajO7Xre0QNSw0TpD6Do
         P0hg==
X-Forwarded-Encrypted: i=1; AJvYcCUxVe5kNpouDxu5Qr4RJOGaC2C6+CUQo4reDKSQgD5Y7+HHBeoYt+FDAM8fFka4eOzNnYhax0A7U/rZfsw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVr2LqaH3ammSGQhqkuSzxfammF/AVq4WmApUTZSBq+PUFLNbm
	eFprBr8XPi1fNgwS4wDBIa/4Q/YAe4g1QAqZleolhX+A+IgydAluxosROc/t4KQ=
X-Gm-Gg: ASbGncsCWDQkAv84da6B6RQOTf7De4fCgfor+rEtHodW6nsQ6wH7Sazs1r0hgNdTL3B
	jvRuO7WOZTYLuzRwcExUJsx7uhqiRkVzs7zcYAE6+Otn+eF0PTU72VU9eyONRVkL/FM5sNwdf5T
	oQCAtsP3t/2hduWkz48L8L/DdCUOHSt3TIHRQZZ7veKVBaw5k+xdFvA5TKPkqxXPXUCjgFegwSV
	sQtDF0YUOw/iEbyIILNKRI+GhmBkZ3BRiVuL/EiBpDFERQghtTawO+mIn0DNGcvFy0hMb1x0hI2
	j9Ha3wm6yuiRACymlJjMn9Kp/ScE5kebnh3s1o68lDlZtFHd7SD5BpOMkF9IMobN9l+UXD8=
X-Google-Smtp-Source: AGHT+IH4shqyBncbJWQ5+kQEmxXsyHynCpre9rBcdgpBSO7ycHWzcV+vcZr39orzd4H2/RKGIH2RfA==
X-Received: by 2002:a05:651c:1546:b0:308:eb34:1012 with SMTP id 38308e7fff4ca-309050915ebmr41358031fa.30.1739546349771;
        Fri, 14 Feb 2025 07:19:09 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-309100c52f8sm6085611fa.8.2025.02.14.07.19.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 07:19:08 -0800 (PST)
Date: Fri, 14 Feb 2025 17:19:07 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Clark <robdclark@gmail.com>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Jonathan Marek <jonathan@marek.ca>, 
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, Rob Clark <robdclark@chromium.org>
Subject: Re: [PATCH v3 3/4] drm/msm/dsi/phy: Do not overwite PHY_CMN_CLK_CFG1
 when choosing bitclk source
Message-ID: <5mdw46egzwzyozejgofuw2cgntznovjpzkkkkxd76s5y4ol44x@zfa5ydz6ta5s>
References: <20250214-drm-msm-phy-pll-cfg-reg-v3-0-0943b850722c@linaro.org>
 <20250214-drm-msm-phy-pll-cfg-reg-v3-3-0943b850722c@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214-drm-msm-phy-pll-cfg-reg-v3-3-0943b850722c@linaro.org>

On Fri, Feb 14, 2025 at 04:08:43PM +0100, Krzysztof Kozlowski wrote:
> PHY_CMN_CLK_CFG1 register has four fields being used in the driver: DSI
> clock divider, source of bitclk and two for enabling the DSI PHY PLL
> clocks.
> 
> dsi_7nm_set_usecase() sets only the source of bitclk, so should leave
> all other bits untouched.  Use newly introduced
> dsi_pll_cmn_clk_cfg1_update() to update respective bits without
> overwriting the rest.
> 
> While shuffling the code, define and use PHY_CMN_CLK_CFG1 bitfields to
> make the code more readable and obvious.
> 
> Fixes: 1ef7c99d145c ("drm/msm/dsi: add support for 7nm DSI PHY/PLL")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Changes in v3:
> 1. Define bitfields (move here parts from patch #4)
> ---
>  drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c             | 4 ++--
>  drivers/gpu/drm/msm/registers/display/dsi_phy_7nm.xml | 1 +
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry


Return-Path: <linux-kernel+bounces-190298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E1428CFC8C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 11:14:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0AC0AB20FCC
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 09:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E6C912F398;
	Mon, 27 May 2024 09:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KGJ/1+qU"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA1643AC1
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 09:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716801240; cv=none; b=cIu3//vaLQR+SVU7uVVrfdK1AQjsRynn1L1GCU0Fe/4+ZjQ90ekSzzWerBy/ffNmHENVMexdhkD6ZVYTEQWGZLS2VTIkOTDudkZ8OPkmj1+BMJCFtx+WfrzEsZM6Hy9xHz+r/CbT6nfa/qQLGg/xmo5nt0oKrZGNkhmHdHlqG+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716801240; c=relaxed/simple;
	bh=JsRHev1Ql+06KUhRx46fWyhIYNRL9SDHIC1akpSgRY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TVyW3rBS20xO+sV5hxeXekIEisJdOEr6yGpsmwipm1iReQ4b8pO3H4TC5jRj1piT0RLI4xPqHYBWh9kdZDwOh1q+H9Rhcksj25gPJJ5GC55Z+KCjqxRyVNvUiB6YLl8dxbgvNlgRTAQQyCXhyCbMoMdfT0kMcdmEJoj1oiz0iXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KGJ/1+qU; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-529597d77b4so2935553e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 02:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716801236; x=1717406036; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fU7wt3RoJ/ZRhVzR1OvMGpUkhRA7vQQ7+ZvSLIkQePg=;
        b=KGJ/1+qUKQdBNzF9JckUusqTx1HeNcYOaHewHYClltozMuVmv1UT72zlzwOjOFIkxu
         vxghFXG9U3FNuzfTpCo6LrnmunwUy9arI8SUgiFu0Zo1NbCvf7UKrT3h1Erui/H8cz6C
         DR1wXro6IN9J9hdU+iSxKrqbQijqGyQu6E8p1r6Gz/OeeRb2W+H7z4Cp2VO6NQxa3k3i
         NzEIfI+VL6LPBA7NaxxsTCDhFxJt8I2DM6sNiZhn/dB3aRe/BZCKHXFD0P409G1jujdj
         hjF/4y3ZsJeJG46aMZ78niI4eShy30uZAWcSB1b4+Rs32CPcV8C+4SpkyqnngCGX/IgF
         2rOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716801236; x=1717406036;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fU7wt3RoJ/ZRhVzR1OvMGpUkhRA7vQQ7+ZvSLIkQePg=;
        b=wNa3Q3eUgKL3k5u6vZMAp2LeVQlbatytBX1TwYhLwwAZRFsGsSEnfIkzib1q0Cx7Mq
         fJp/iUyIdAiYuXuQTlMXjuruSPZz76sPSrQp35sJBXh2s7z3R/32M0KYtvzln9/RlnpQ
         5S77eYgh7ZL1QfNBx/TjtiH/e8hpCyA1d0Y4Cu7Gs+qFSHH+vXISEiNK/d1/ULSuuKmi
         pDz3oZlYSqRcHNhj51DnYkpKLiWz7EhlUNwl6DdyKQ4hYriMPO6PkIpmWcnx997SjtO9
         s1rWjubDRcdi3ikSSaKOdiGt/xmRufEUxpjg0Qs2wPrlqTdtid89FdUpv/cvBzyAuRt/
         IOcw==
X-Forwarded-Encrypted: i=1; AJvYcCVekSGJP2Fy/xZxRPMWcCoOqbWDW6QqmnabVjxaAHgT1jq5Nj0F40XsiN5pzgiAOPI42VDkh+KpHm3kKungoikkE6UPOSQedUIV6wP1
X-Gm-Message-State: AOJu0YzweJ00wjbyQ+LuBiHjqPG2fpIGJpCBV8GX/65iasDD618bsyZl
	ATJ3dnj+iwHIfjmPbFy4X0jOolVnvrdpYs+R7VhIJTrDIO/3pjQ6FgA1GhnK2WI=
X-Google-Smtp-Source: AGHT+IFVa65amKWg0sDvxcneN95XLq2oAjYgTo5y33Nlr/ZBV8Jie8NEAzCjb5dV3ztVi9w84Tah4A==
X-Received: by 2002:a19:7502:0:b0:524:68f8:9566 with SMTP id 2adb3069b0e04-52964bb2c9dmr4994304e87.30.1716801236570;
        Mon, 27 May 2024 02:13:56 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5296ee4ad1asm500411e87.95.2024.05.27.02.13.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 02:13:56 -0700 (PDT)
Date: Mon, 27 May 2024 12:13:54 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Abel Vesa <abel.vesa@linaro.org>
Cc: Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Kuogee Hsieh <quic_khsieh@quicinc.com>
Subject: Re: [PATCH 3/3] phy: qcom: qmp-combo: Switch from V6 to V6 N4
 register offsets
Message-ID: <zbveo2mdozzumc3gekvochcemfhy3e4eo4dc3sgyfivlxpjbzx@if6svye4wvhz>
References: <20240527-x1e80100-phy-qualcomm-combo-fix-dp-v1-0-be8a0b882117@linaro.org>
 <20240527-x1e80100-phy-qualcomm-combo-fix-dp-v1-3-be8a0b882117@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240527-x1e80100-phy-qualcomm-combo-fix-dp-v1-3-be8a0b882117@linaro.org>

On Mon, May 27, 2024 at 10:20:37AM +0300, Abel Vesa wrote:
> Currently, none of the X1E80100 supported boards upstream have enabled
> DP. As for USB, the reason it is not broken when it's obvious that the
> offsets are wrong is because the only difference with respect to USB is
> the difference in register name. The V6 uses QPHY_V6_PCS_CDR_RESET_TIME
> while V6 N4 uses QPHY_V6_N4_PCS_RX_CONFIG. Now, in order for the DP to
> work, the DP serdes tables need to be added as they have different
> values for V6 N4 when compared to V6 ones, even though they use the same
> V6 offsets. While at it, switch swing and pre-emphasis tables to V6 as
> well.
> 
> Fixes: d7b3579f84f7 ("phy: qcom-qmp-combo: Add x1e80100 USB/DP combo phys")
> Co-developed-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 189 +++++++++++++++++++++++++-----
>  drivers/phy/qualcomm/phy-qcom-qmp.h       |   2 +
>  2 files changed, 162 insertions(+), 29 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry


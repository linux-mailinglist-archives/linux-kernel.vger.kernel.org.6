Return-Path: <linux-kernel+bounces-251674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 822F19307F8
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 00:56:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20F1FB2258F
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 22:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE76516B395;
	Sat, 13 Jul 2024 22:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sFbAZW2J"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E236F147C74
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jul 2024 22:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720911340; cv=none; b=coZVqaQdlIup37wtqUSYfLgokRh2kQ5JMFKXAF2aSADF7Bg6Un4rkj32M3GXXinVZQXUsL9eTvABqzdahY8/1dEaOtCsgYPBRhKCdYVPWtcw24ZuFY7Gekzo+WLWk6S4LB7BLoDz7vBID1WQLF4YU2b8ePk4C1CmrCcdeeIM/Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720911340; c=relaxed/simple;
	bh=OaF95Y3KK01YXpum7eYHBcI3ryjO8sJWgVjZqJgDRPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rfuMdh+FhlOb4SxG1TNULodqoZ7wlk0BWl8eOb/IEot4nvVksV4k24RPIialMZTFCHpw5MsQf2mCN7ReLpR56zHD4jD6kg0sh+nXfeFonduekbbHUEqW5GaiyNRRAXlDvTsJ1V0IpX8DwGxQUgSA5YEJWjpWXZbVtMWK/tQfvZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sFbAZW2J; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-52caebc6137so2541487e87.0
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jul 2024 15:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720911336; x=1721516136; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1ncYPX+7Asq9PPYrO1DJYNdoPMBQuM8Zo8xSB8y/YwE=;
        b=sFbAZW2Jr+Q3eEEyWpaX55Lbe7JAysZvvFCG2ZIPF2QAxkHBQVyrpMb/cw+cV3rvWC
         ccEi6QoHisrwu1fsPhTDriqIpLcFa7YMqW3BlL2FvUKK/SLMd/UKYtOFA4WZPi3Ck7PG
         Ty+MgcRYLinOGo8uQLchhkDIcVLrK3S2zRuj7u4ZNN/sUjzkYkVJ9l6ES1lnHunKOlzn
         7iQ1PbsK44IJ/q5XwyCxtZ1sQ3zuO8aIa5ka5NLJ4u6vAqwPI92Lu8AIi2ZHetdP43wp
         h6+9m0iidDIFfTrPOYcZHCVHXsF7RZCEhqs/oRorgh6edJIqiCmQ+kHU3pp1pphEdl7c
         JRsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720911336; x=1721516136;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ncYPX+7Asq9PPYrO1DJYNdoPMBQuM8Zo8xSB8y/YwE=;
        b=O3fqZeXr7tSRhJKXiab0a3C7yvFzuNWYdD1AsbILLNmLiS0RBBMa0GGQJNopALjMll
         UqTmWK+l+SL3I6bZwEbCNBzPA8mX44LRp83yb3em1PvJVen6vrGepd2NHOUnkJ6FiK5x
         5cRXFVcobrWbpCpRb7XIOUgdGa2NCL9VMiW4GM+eDQpgM1GBC53b0cgUvXx/zvkVppJG
         aq/jVkFzOMHKLqEpKLXEYtdUfSMyQNb/vqt4o/07L9oUj9adF7W35iSjGxecz7H2QiWE
         W/447JQ6VTymsh6AnbyYSGGD/aVuSXsxCMPoYTPgD2VZEcs0L87ruheS5xDWOCF39MWd
         ytlw==
X-Forwarded-Encrypted: i=1; AJvYcCVPD6IWeyLNYSWC6UGT39BXWJ6XY50GDpob9YWXsBXiiOKKNWMNgKA4hcWkADxu2FuDTJNqrnR11zsNEVGwVKn4yFyTX7XMCncGUKqS
X-Gm-Message-State: AOJu0YwlJE6NIyfki0RaEEBskq5ngc5pqxR89qxdgSLVJOCZVDuBf5Oy
	SeOIAyxKejEQSZNkpdXJWfFvSDnKaRntEeRgHzgtsDtFsrlqymFyecT6A4UPK+s=
X-Google-Smtp-Source: AGHT+IEhwHVC3K0rEjJohPz1JS1RmLGBZWld5R1IufdJk0BRYdLg0pMSt+FKcRLiIV3Hgn5icbbQ6Q==
X-Received: by 2002:a05:6512:1384:b0:52e:be1f:bf7f with SMTP id 2adb3069b0e04-52ebe1fbfd5mr7917903e87.27.1720911334977;
        Sat, 13 Jul 2024 15:55:34 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ed252d543sm308907e87.155.2024.07.13.15.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jul 2024 15:55:34 -0700 (PDT)
Date: Sun, 14 Jul 2024 01:55:32 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc: freedreno@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org, 
	quic_jesszhan@quicinc.com, swboyd@chromium.org, dianders@chromium.org, 
	neil.armstrong@linaro.org, andersson@kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/msm/dp: enable widebus on all relevant chipsets
Message-ID: <xmkcy7xjoaodxnyzbskjb7y5xne444qx4jdrtcgoqwh45aqjn2@4rnbkhr5uuby>
References: <20240711224850.1672662-1-quic_abhinavk@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240711224850.1672662-1-quic_abhinavk@quicinc.com>

On Thu, Jul 11, 2024 at 03:48:50PM GMT, Abhinav Kumar wrote:
> Hardware document indicates that widebus is recommended on DP on all
> MDSS chipsets starting version 5.x.x and above.
> 
> Follow the guideline and mark widebus support on all relevant
> chipsets for DP.
> 
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_display.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 

Although it doesn't seem to fix the 4k screen corruption, I think it's
still a proper patch (and we should be following hardware
documentation).

With the Fixes tags in place:

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry


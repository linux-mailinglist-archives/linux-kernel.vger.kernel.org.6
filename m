Return-Path: <linux-kernel+bounces-261896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4670193BD8C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 10:01:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2B291F225FE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 08:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E54A172BDC;
	Thu, 25 Jul 2024 08:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EuXXDmD3"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582FC172BD8
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 08:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721894489; cv=none; b=tQYqPsLOp3anQB3QwnZB5WYutUq23zirX5a1BakhYuigqemEcm5NCHjg7+F20ErHH/9OKWjxdPPQ6Doxbag//g2OKhBtxADA6PkbPoXNtIwE5I3PdAlCIvUxnjfXYL5H3Y9AyyALtP2QacIkz7us9pDAPt8ffKiG2ub4ipg6YK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721894489; c=relaxed/simple;
	bh=bqtvZKpkX2ndCdEsKZV3b4UVOmkkdVl+Xk4IbYS4A1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eXSaQR+suHlAwoNdWfiofuyQyWRa5c0VxwOoYmIODANU7Ey+Q2jC3V88F4KxX4/UtJpN6u9sPvW6Q+JfkUTSNCCueOvud50pjH6LvbuuZ7Vh//AJXGogiM6M05YSwSeCYZKj6R5nPx1M1mpniGiJaZYBk/Dopq/+14BNcJcI+C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EuXXDmD3; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-70d316f0060so1203855b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 01:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721894488; x=1722499288; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2c7ggsoOSLdU9DiOS/frhmaIqR3+SdwRnRwQB87GU3U=;
        b=EuXXDmD3WJ3sGa2FCe0SrrAGhwE5VCWnpq3W2Vyxp5Ki6zZXsio50JsAKHbAau4fPp
         R3+ShYhKv75QsAgK/oU3Tli61TmsitlnpUvKJdCu1Q4p1iHIrm+hxSUf35nHVD/48TG3
         UM4ewR3KYYztMecOpwd4gICHlTewRVK9WhydDBe47Ao+ksZD6SoGzyvHpERh5b22r/S1
         Flih9qyl8x7KHi8HQzj8IkuZJdrO9wABowuhaUkmSv9ziI3SeDfW09Ml46Cb6X8wUGaS
         Xo4Wa8klMLBygt0DHPreszMGRwHrZ1ZtESFq2yObfiqOvvOnWRnw7P7s8zupZouQOson
         KpnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721894488; x=1722499288;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2c7ggsoOSLdU9DiOS/frhmaIqR3+SdwRnRwQB87GU3U=;
        b=MDxpVRduh90beksY7t0B7nGImW788LiGAnB2QlZmftcTheou8PtsB7DwxHzlx/ctOU
         K6WFpATICE8IhFLkwdPFme9hP19fUz+j9rSD+02UM5olD2UYfKzYF4ZzUggD18XdJgTH
         webX98i+EG/w6vgu3qX3KPQxnv5SRF7ADvrWsDpn/pZEbmXrKI+PZkKhz8pfscboJ5fA
         KlWWkBB3iSLotxWcNL2VyBBz8LLbFKwebSl/ZgLP6egWmXo3Yhk3J4jGeaMo3tUYC5/K
         SlbmwBfMHPtcaxF9QmupyNAoWKZG4YWtdD6nesZw8gVY8JghrrUuDxQycolGJsUmP5QU
         c2gw==
X-Forwarded-Encrypted: i=1; AJvYcCVNlFIh+XTLjITO63Ex0J4NCAtqdO0lujlhzblvVXImRWye+xhULxuWwCCLdtzYG7oF06ugXylwxFqubGOqy5+h6ZcAg/rsXGCfFTCi
X-Gm-Message-State: AOJu0YxHI8Ykh0A3U9z+OqwsDuoZJwayHGJ8XqRVWkXmIMk9V+iIlB0d
	qewlpvYjJxeb7O95iC3qG7uw/3Jq0bkrrjHAE8J6+O/oik9cKNXE3zj5FJy6bg==
X-Google-Smtp-Source: AGHT+IFmvJyqahoU02kPAEWANanSJCeYxaO1E1XGFkFJWmSQRgcWigI4sZuhSewH3maEyGNqF8nq9Q==
X-Received: by 2002:a05:6a20:a10b:b0:1c2:8d44:d42d with SMTP id adf61e73a8af0-1c4634cda5dmr8263701637.0.1721894487569;
        Thu, 25 Jul 2024 01:01:27 -0700 (PDT)
Received: from thinkpad ([2409:40f4:1015:1102:1950:b07b:3704:5364])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7a9f8273af7sm589703a12.30.2024.07.25.01.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 01:01:27 -0700 (PDT)
Date: Thu, 25 Jul 2024 13:31:19 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Mrinmay Sarkar <quic_msarkar@quicinc.com>
Cc: fancer.lancer@gmail.com, vkoul@kernel.org, quic_shazhuss@quicinc.com,
	quic_nitegupt@quicinc.com, quic_ramkri@quicinc.com,
	quic_nayiluri@quicinc.com, quic_krichai@quicinc.com,
	quic_vbadigan@quicinc.com, stable@vger.kernel.org,
	Cai Huoqing <cai.huoqing@linux.dev>, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dmaengine: dw-edma: Fix unmasking STOP and ABORT
 interrupts for HDMA
Message-ID: <20240725080119.GC2770@thinkpad>
References: <1721740773-23181-1-git-send-email-quic_msarkar@quicinc.com>
 <1721740773-23181-2-git-send-email-quic_msarkar@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1721740773-23181-2-git-send-email-quic_msarkar@quicinc.com>

On Tue, Jul 23, 2024 at 06:49:31PM +0530, Mrinmay Sarkar wrote:
> The current logic is enabling both STOP_INT_MASK and ABORT_INT_MASK
> bit. This is apparently masking those particular interrupts rather than
> unmasking the same. If the interrupts are masked, they would never get
> triggered.
> 
> So fix the issue by unmasking the STOP and ABORT interrupts properly.
> 
> Fixes: e74c39573d35 ("dmaengine: dw-edma: Add support for native HDMA")
> cc: stable@vger.kernel.org
> Signed-off-by: Mrinmay Sarkar <quic_msarkar@quicinc.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/dma/dw-edma/dw-hdma-v0-core.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> index 10e8f07..fa89b3a 100644
> --- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
> +++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> @@ -247,10 +247,11 @@ static void dw_hdma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
>  	if (first) {
>  		/* Enable engine */
>  		SET_CH_32(dw, chan->dir, chan->id, ch_en, BIT(0));
> -		/* Interrupt enable&unmask - done, abort */
> -		tmp = GET_CH_32(dw, chan->dir, chan->id, int_setup) |
> -		      HDMA_V0_STOP_INT_MASK | HDMA_V0_ABORT_INT_MASK |
> -		      HDMA_V0_LOCAL_STOP_INT_EN | HDMA_V0_LOCAL_ABORT_INT_EN;
> +		/* Interrupt unmask - STOP, ABORT */
> +		tmp = GET_CH_32(dw, chan->dir, chan->id, int_setup) &
> +		      ~HDMA_V0_STOP_INT_MASK & ~HDMA_V0_ABORT_INT_MASK;
> +		/* Interrupt enable - STOP, ABORT */
> +		tmp |= HDMA_V0_LOCAL_STOP_INT_EN | HDMA_V0_LOCAL_ABORT_INT_EN;
>  		if (!(dw->chip->flags & DW_EDMA_CHIP_LOCAL))
>  			tmp |= HDMA_V0_REMOTE_STOP_INT_EN | HDMA_V0_REMOTE_ABORT_INT_EN;
>  		SET_CH_32(dw, chan->dir, chan->id, int_setup, tmp);
> -- 
> 2.7.4
> 

-- 
மணிவண்ணன் சதாசிவம்


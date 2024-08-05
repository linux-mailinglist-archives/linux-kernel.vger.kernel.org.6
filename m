Return-Path: <linux-kernel+bounces-275112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 810AA9480B7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 19:52:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D358282ABF
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 17:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BAE815F3E8;
	Mon,  5 Aug 2024 17:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XK0NxcvA"
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D454115ECD4
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 17:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722880313; cv=none; b=OOV4mkwx44P2inv38aXUQ4J5IN5CnHxaXgOLcvjUhXpqUADtSQUlWS7I1xrxNxnTPZzRrFjC1lKq0o7wXK4LKPLwS24ZUE0r08n24a+dTCoIlSt7SoFwCbFcQD9vfcLaJDqnDEUvOsgccGgqEmf1JZUj1llihpFzEeYXARWI/lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722880313; c=relaxed/simple;
	bh=YVccmBciA80CmnKPcW5V2A+OyOPhY5DRWGANxRvBnPU=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C2uxOOyKYiDJlUThccNUsYMpEfE3yKKM7sBEm4/ft033KNssCExozmd6CslF1b6aDCiaUKF0BTxbKeSduuESJza6At4yu+s5/OS7bQl1R0DFPAe15WYlvD5kGv8sOUjdTElKmZFZcVc1Fs9CvI1dRqovhoIUgkRGB0p3LkdmKjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=XK0NxcvA; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-83120879efcso2515553241.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 10:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1722880311; x=1723485111; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6nbW348xf8GM2iQnl+TbCKX6Ev0PICegcIqwB4d0fQU=;
        b=XK0NxcvAn1OSB+YuA3Sw01VEKLjeV5kqvSQ3Pk95+elX/hpRJS8Tp/0r6GpqnicN+/
         gkOq6+eHMy7/lra+v6rt7Etl8skkXlBIq6VD8pXtrVWfs6rNj0JehNUiASQ3Lr4Y5oVq
         I0SmUdpBhI0CirNd8cOvhmsvAzOrcuEfRZSUA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722880311; x=1723485111;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6nbW348xf8GM2iQnl+TbCKX6Ev0PICegcIqwB4d0fQU=;
        b=je/xAe55MzmJxm0DvOs3AcIPbn8Adf+/rUl6D29XpVtAAdHHvlyBG//0ni5BH5RCEZ
         nFdnqNz412zI0PWHritTo354zDAQFMAwK7yO/B6Owe4A6J5OFkyRF1jAY/I4HHUT3kL1
         YJDCWgGGDjpUlF0WoLYFfMETNZfq+DAoVygrl7QNzM+84dQ9suFxxuKmU6+Gv5g1Mivb
         TH8pilO0d3XAmWAepjVsvLM5CAxXC68esVYQNSNHPZI+B0JRZyIg9p7hH5dBNMwU8C96
         6Ob8Bhv6TTCVhN5IKCDBwMgkw/wFZ88ALJiOPCaoHL7MSTHmT/uOOwfJTQTp+HiM6L4/
         gp1w==
X-Forwarded-Encrypted: i=1; AJvYcCUaQIcSaj+srUtQohWR3kYrS8mN/ucPlAexDECzo8jkPt5rp8wQyaSAOOOQeW3/TQTVfBmxCFdWMh+eWVwvvTefK6xwSFZUb2i2X93b
X-Gm-Message-State: AOJu0YxunwXeyB6vo7X/TXeCyxVk3ZyyWrgPRj4a2ObnpZl8VKYpJ1ts
	/6jUWbDxzzCoYUuStKsVUMpADl+ZSTobH3v4fwp+CFqyAIa7nNEP/dScCtcZK0PN1Sf2Xzf7mVb
	ArLOrE2oF9AukDsRp2X+30QjqBHpy1XMpmLIE
X-Google-Smtp-Source: AGHT+IHtSv7JoCebCjJD4wZkVA0SCLR4fN1TlmZof6Lk/RoveBtf7mPpjJXL0Ok2+pD7uFaqEK6RArc9McfQGRl5hOg=
X-Received: by 2002:a05:6122:915:b0:4f5:2c0c:8528 with SMTP id
 71dfb90a1353d-4f8a0018979mr10177984e0c.11.1722880310637; Mon, 05 Aug 2024
 10:51:50 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 5 Aug 2024 10:51:49 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240730175541.2549592-1-quic_abhinavk@quicinc.com>
References: <20240730175541.2549592-1-quic_abhinavk@quicinc.com>
From: Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date: Mon, 5 Aug 2024 10:51:49 -0700
Message-ID: <CAE-0n50jN+XivRX8D7cHff26P-kM8hNsQEpj=VBf=bEs9vESGw@mail.gmail.com>
Subject: Re: [PATCH v2] drm/msm/dp: fix the max supported bpp logic
To: Abhinav Kumar <quic_abhinavk@quicinc.com>, Chandan Uddaraju <chandanu@codeaurora.org>, 
	Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Guenter Roeck <groeck@chromium.org>, 
	Kuogee Hsieh <quic_khsieh@quicinc.com>, Marijn Suijten <marijn.suijten@somainline.org>, 
	Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, 
	Tanmay Shah <tanmay@codeaurora.org>, freedreno@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, quic_jesszhan@quicinc.com, 
	dianders@chromium.org, neil.armstrong@linaro.org, andersson@kernel.org, 
	abel.vesa@linaro.org, Vara Reddy <quic_varar@quicinc.com>, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Quoting Abhinav Kumar (2024-07-30 10:55:40)
> Fix the dp_panel_get_supported_bpp() API to return the minimum
> supported bpp correctly for relevant cases and use this API
> to correct the behavior of DP driver which hard-codes the max supported
> bpp to 30.
>
> This is incorrect because the number of lanes and max data rate
> supported by the lanes need to be taken into account.
>
> Replace the hardcoded limit with the appropriate math which accounts
> for the accurate number of lanes and max data rate.
>
> changes in v2:
>         - Fix the dp_panel_get_supported_bpp() and use it
>         - Drop the max_t usage as dp_panel_get_supported_bpp() already
>           returns the min_bpp correctly now
>
> Fixes: c943b4948b58 ("drm/msm/dp: add displayPort driver support")
> Closes: https://gitlab.freedesktop.org/drm/msm/-/issues/43
> Reported-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Tested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org> # SM8350-HDK
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> ---

One note below,

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

> diff --git a/drivers/gpu/drm/msm/dp/dp_panel.c b/drivers/gpu/drm/msm/dp/dp_panel.c
> index a916b5f3b317..3777b1abacad 100644
> --- a/drivers/gpu/drm/msm/dp/dp_panel.c
> +++ b/drivers/gpu/drm/msm/dp/dp_panel.c
> @@ -90,22 +90,22 @@ static int dp_panel_read_dpcd(struct dp_panel *dp_panel)
>  static u32 dp_panel_get_supported_bpp(struct dp_panel *dp_panel,
>                 u32 mode_edid_bpp, u32 mode_pclk_khz)
>  {
> -       struct dp_link_info *link_info;
> +       const struct dp_link_info *link_info;
>         const u32 max_supported_bpp = 30, min_supported_bpp = 18;
> -       u32 bpp = 0, data_rate_khz = 0;
> +       u32 bpp, data_rate_khz;
>
>         bpp = min_t(u32, mode_edid_bpp, max_supported_bpp);

This can be min() because all types are u32.

>
>         link_info = &dp_panel->link_info;
>         data_rate_khz = link_info->num_lanes * link_info->rate * 8;
>
> -       while (bpp > min_supported_bpp) {
> +       do {
>                 if (mode_pclk_khz * bpp <= data_rate_khz)
> -                       break;
> +                       return bpp;
>                 bpp -= 6;
> -       }
> +       } while (bpp > min_supported_bpp);
>
> -       return bpp;
> +       return min_supported_bpp;
>  }
>
>  int dp_panel_read_sink_caps(struct dp_panel *dp_panel,


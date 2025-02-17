Return-Path: <linux-kernel+bounces-518236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02E89A38BE7
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 20:05:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE75C16E12A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 19:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0ABC236455;
	Mon, 17 Feb 2025 19:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Au0qDLfI"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B66235C16
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 19:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739819134; cv=none; b=UvAmUZIsTDEhz9j5J7uSVUjkIfMxmr4CwloQxuO2ZcldJdQ6f2q4Te9cWRac1BpbuX+DUJrNSe2XhRFlDCf1c7zxsXKEL44LSlBCix4plni8nvmUH1lS7aQaZ6UJIEOBVMYY7q4z7c/x0myBKDPrUVNMi5Zv6/IGhVceQ29ICgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739819134; c=relaxed/simple;
	bh=uWj9xvnYhttiRunyS9x6npFqm7MB67cKebszu8LBe2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K2sH8vH4gpvjvik/yn7vafeCDykrhqIUug/FX+Z69aGRpvAF8fKAH5DuFquqea2oBlrv5Cig+aSQxz3zkGeebJ3DKhToLzWAfrtXL9tDgWBSCSPQfQbtSGsiljkp9szu424HYojATMZSw/gCvQEwPI7RGw6vUvdB+Gd3de8vNtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Au0qDLfI; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5439e331cceso5574843e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 11:05:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739819129; x=1740423929; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ht4Pghdo7uLCRP78An2YAFjRBxhnNPD/6He7H1tEdog=;
        b=Au0qDLfIRBfpChgGy2zVvVeBGQs/41AVtxhkvNAJp+uFOUOBlfK6mkYQdEKXuud8Zj
         qI8eQY+q9c9TmPupSkExLWXUqpvnyOxQlYep3KmcIphVB6JU1mcKnA2j3pVkKtsCouyx
         cfWH9HxejBrnojkdWkjwdmWz1Xvq60NXrBRYrcUs8wHZjLDO42xp6tAPre1Tox7sfgHb
         2seMVeSC7rJbqosM8wGydvh8RbdHngPSLfZvv0PxffYlNzquF/3Su3t5BZSzAFb5D/0O
         F9Ta3iYgCPiqFANkdfIjg9Rc+ldYbughR3d0F8AIUVpTEI4IfrpuehXQ4TbVWBtao9D9
         A3BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739819129; x=1740423929;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ht4Pghdo7uLCRP78An2YAFjRBxhnNPD/6He7H1tEdog=;
        b=Cs0RIJ9XasTBkVtosUhMWCuLnUBxwVVR5YsbXwqVDIeOqS+1j+Su+cmYGKErIPJZ2f
         CsgNRcCcbICBErT2RR5/mYA1nGcU4RQcKjRB7W7s1eqUifDKDDxwVjnyw1kh+hW4H8Hh
         hvMriFzXAue9bewyEn8vw1iKKGYRBZDkfMlo9+OU19Pnp6G8qjAzkBUkQg5myE3gFgKF
         5aorgj+gteYIgwxSy6OGGQgnqBMszHzIj2DXdgFbg2WvIjAd9LI9iz/w21xm5ODpNDs4
         9+B3sExRAOo2/hH7qU0XzvUcOlQFu6ABw+5ORctLfqFwNx3F5KWxa9Q+rRfz0vearzhh
         PCLw==
X-Forwarded-Encrypted: i=1; AJvYcCU3+LVfsjKtq7rXKAWLYjVjMLCeyyXe7rY8ddHUTpbY8aZVnZjFGHmq8t41nLcf8zxuVCoiRvvLwh/Nw8Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyt4QWI8Du1oI/MLDzlbRz9FBUTMeXMqY9g8vm/N3ilH7tFA8cw
	fJdZOQQerJ1CK8fByck/cbjky+UE+0nn6OJO1GM/vD+6lVCb5D6m3ZNSK/079Qs=
X-Gm-Gg: ASbGncsmJQM55mRVRaKAT7+nwovg53bJLuO/C8Y3dqqV1nw9Bh8Pnqt+5Q5oXf+AgcB
	NmehflEsp6EnVZ6YyTw8qYiGyy5xi/pktBJQYnRN4vRtVQgwWAjjUm2MdXNM2vXjTXd1RbGNDoJ
	OUzgL9JcdriCShql/AmtqXg2cbxjyNXQ4+bKV11U1P0fMbDMZGFzsnO0n/94MFgHcwTpC6v+QS1
	CgjcusM+g1CuJJx19ZYpWg8qrZQEBq2I3XwVmZRVf7ghgrYURrs0iHIwln+c74uWbvj15n35Fj1
	lwhrevPS7GQ9S97b0fop4All0LRblEwTZSl3qxXyU3yEGcg+rcfDp58nG4326VDYkWbwmt8=
X-Google-Smtp-Source: AGHT+IFEbhrM0nWi82cCaGvwSYXj6LdzEaAz+2hRFf9rrqKf6VFlvlNtTYi7/LSYD5QH5IDU/5M5yw==
X-Received: by 2002:a05:6512:108a:b0:545:5d:a5e2 with SMTP id 2adb3069b0e04-5452fe2b38amr3782879e87.10.1739819129100;
        Mon, 17 Feb 2025 11:05:29 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-545d1b9c30fsm862532e87.15.2025.02.17.11.05.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 11:05:27 -0800 (PST)
Date: Mon, 17 Feb 2025 21:05:25 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Clark <robdclark@gmail.com>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Krishna Manikandan <quic_mkrishn@quicinc.com>, 
	Jonathan Marek <jonathan@marek.ca>, Kuogee Hsieh <quic_khsieh@quicinc.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Srini Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v2 12/16] drm/msm/dsi: Add support for SM8750
Message-ID: <bvxw6btyefw67owjeke7edxk67dhq56ewu63cw57ckpupcunng@v7oq7knhaukm>
References: <20250217-b4-sm8750-display-v2-0-d201dcdda6a4@linaro.org>
 <20250217-b4-sm8750-display-v2-12-d201dcdda6a4@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250217-b4-sm8750-display-v2-12-d201dcdda6a4@linaro.org>

On Mon, Feb 17, 2025 at 05:41:33PM +0100, Krzysztof Kozlowski wrote:
> Add support for DSI on Qualcomm SM8750 SoC with notable difference:
> 
> DSI PHY PLLs, the parents of pixel and byte clocks, cannot be used as
> parents before DSI PHY is configured and the PLLs are prepared with
> initial rate is set.  Therefore assigned-clock-parents are not working
> here and driver is responsible for reparenting clocks with proper
> procedure: see dsi_clk_init_6g_v2_9().
> 
> Part of the change is exactly the same as CLK_OPS_PARENT_ENABLE, however
> CLK_OPS_PARENT_ENABLE won't work here because assigned-clock-parents are
> executed way too early - before DSI PHY is configured.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> SM8750 DSI PHY also needs Dmitry's patch:
> https://patchwork.freedesktop.org/patch/542000/?series=119177&rev=1
> (or some other way of correct early setting of the DSI PHY PLL rate)
> ---
>  drivers/gpu/drm/msm/dsi/dsi.h      |  2 +
>  drivers/gpu/drm/msm/dsi/dsi_cfg.c  | 25 ++++++++++++
>  drivers/gpu/drm/msm/dsi/dsi_cfg.h  |  1 +
>  drivers/gpu/drm/msm/dsi/dsi_host.c | 80 ++++++++++++++++++++++++++++++++++++++
>  4 files changed, 108 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/dsi/dsi.h b/drivers/gpu/drm/msm/dsi/dsi.h
> index 87496db203d6c7582eadcb74e94eb56a219df292..93c028a122f3a59b1632da76472e0a3e781c6ae8 100644
> --- a/drivers/gpu/drm/msm/dsi/dsi.h
> +++ b/drivers/gpu/drm/msm/dsi/dsi.h
> @@ -98,6 +98,7 @@ int msm_dsi_host_init(struct msm_dsi *msm_dsi);
>  int msm_dsi_runtime_suspend(struct device *dev);
>  int msm_dsi_runtime_resume(struct device *dev);
>  int dsi_link_clk_set_rate_6g(struct msm_dsi_host *msm_host);
> +int dsi_link_clk_set_rate_6g_v2_9(struct msm_dsi_host *msm_host);
>  int dsi_link_clk_set_rate_v2(struct msm_dsi_host *msm_host);
>  int dsi_link_clk_enable_6g(struct msm_dsi_host *msm_host);
>  int dsi_link_clk_enable_v2(struct msm_dsi_host *msm_host);
> @@ -115,6 +116,7 @@ int dsi_dma_base_get_6g(struct msm_dsi_host *msm_host, uint64_t *iova);
>  int dsi_dma_base_get_v2(struct msm_dsi_host *msm_host, uint64_t *iova);
>  int dsi_clk_init_v2(struct msm_dsi_host *msm_host);
>  int dsi_clk_init_6g_v2(struct msm_dsi_host *msm_host);
> +int dsi_clk_init_6g_v2_9(struct msm_dsi_host *msm_host);
>  int dsi_calc_clk_rate_v2(struct msm_dsi_host *msm_host, bool is_bonded_dsi);
>  int dsi_calc_clk_rate_6g(struct msm_dsi_host *msm_host, bool is_bonded_dsi);
>  void msm_dsi_host_snapshot(struct msm_disp_state *disp_state, struct mipi_dsi_host *host);
> diff --git a/drivers/gpu/drm/msm/dsi/dsi_cfg.c b/drivers/gpu/drm/msm/dsi/dsi_cfg.c
> index 7754dcec33d06e3d6eb8a9d55e53f24af073adb9..e2a8d6fcc45b6c207a3018ea7c8744fcf34dabd2 100644
> --- a/drivers/gpu/drm/msm/dsi/dsi_cfg.c
> +++ b/drivers/gpu/drm/msm/dsi/dsi_cfg.c
> @@ -205,6 +205,17 @@ static const struct msm_dsi_config sm8650_dsi_cfg = {
>  	},
>  };
>  
> +static const struct msm_dsi_config sm8750_dsi_cfg = {

Can we use sm8650_dsi_cfg instead? What is the difference?

> +	.io_offset = DSI_6G_REG_SHIFT,
> +	.regulator_data = sm8650_dsi_regulators,
> +	.num_regulators = ARRAY_SIZE(sm8650_dsi_regulators),
> +	.bus_clk_names = dsi_v2_4_clk_names,
> +	.num_bus_clks = ARRAY_SIZE(dsi_v2_4_clk_names),
> +	.io_start = {
> +		{ 0xae94000, 0xae96000 },
> +	},
> +};
> +

The rest LGTM. I'm not very happy regarding the clock handling, but it
seems we jave to live with it.

-- 
With best wishes
Dmitry


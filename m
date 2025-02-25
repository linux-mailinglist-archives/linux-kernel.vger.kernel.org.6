Return-Path: <linux-kernel+bounces-532135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36869A4495A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 19:02:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 188863B14D4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 17:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EB8819C554;
	Tue, 25 Feb 2025 17:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LQ4YezyB"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB90F19B3EE
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 17:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740506205; cv=none; b=jvpDdFTzrkx1Iz3JY6IGEm8+F6/0IWR5RQLaS/iD4fTGa3l7oUP3Wa7pTyLNrCMZF7KBEQXfsSyNWSTY4aXbPrIFOeB/oOGeYMj0i/XoYzrPOG23HELUy3xY9VaY/FjJsBKQYASi2VhiSEGRBdUF7LS4ZghRM/IzFasKkkAx8KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740506205; c=relaxed/simple;
	bh=qSjVnqw0ClAZgaxrRwxr4jTG+YrP6X57Cz8R8eCo864=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r9K1u0EHlA+4voqh4HJ206JCeFjJiLfbxiZihMQFrLHq7GJI5JijzTY7DKuLOpLf9pIN6LT+eDIfOZzhfxhyWPt/6guheq2tNv2KZns22M3oktgjsx/ZzawCKM3kFmTXGSriNOnMmq5xkI2kIQyMANlFvBy5tev4CaEdCC+Csa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LQ4YezyB; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-30795988ebeso61478591fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 09:56:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740506201; x=1741111001; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xVWp9Ja2Rjz3r7Z6XrBcybwSqNljM6TcrY1ydtVaEeA=;
        b=LQ4YezyBLXTIrL3L6HcQSC4ckM8kpwaBCfMloWtSIlkwtnxGRkTXxt71N6waO8Ngtk
         ZL0R27A3GcEDCI7tZgiMV5WJxnGTBIO+WAizj0y8NyoGaml0rP+TBLt/6kBnOfFnWUah
         5qiqFF9SmE3mxCKVh0GQjf3xqkLcMuCLBRGpYKI4+06BmYGQJpsuMgCRh+c1QzPuuxQc
         uQNXZiwQXjlN6Mcq+FnaWT5BElKb7m9HRWbbjeWLA3cqQhYawqS4B/himYpJZajlCerK
         Hn/U+pBZdJvA0sI/3/5f3MNRhg8OgydKuQ5J8bGJhEC1f6JIIlwO55ERktqzziM/6pHI
         IBtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740506201; x=1741111001;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xVWp9Ja2Rjz3r7Z6XrBcybwSqNljM6TcrY1ydtVaEeA=;
        b=MuOWHaUv0vGS5zTJ6KZ3BmI+Wf0Ls2/nyE9PtsJ/kU0rGpGlOkx5C4+vWu2Z2Yhj+U
         DyyrXTEWXU1wV0Cr5OhM/laOp0xYhpU3BB3PPw3vkl/pDDP/lbmCLkN5eSAX2fNunCsc
         BxmnyEmARGR87ZDgyQuzF50/xfAT21+CHbiR643nFyzE3NrtivO5Heb5STafZ9fTtkFd
         dn7008X3g2y+BqPY4ok7ZK6Nv3/fSWb6aM4JJNEe3hZwP4xrg/Gg6uBtZ16+OXBmkqrj
         os9rn6/9QnFeNylLKSeyic9aVgchN6tVNmITcT/tkxanKC+e2Y2zeBmyL1xkk74HX7n/
         jCtA==
X-Forwarded-Encrypted: i=1; AJvYcCWg0Jwi0bz0UtEccaaHxeeBtMbO1QnU5tLM5p0y7B6+i8F3RWA+CaiEctsDDAsO3e8lazlP0A+ubMD+jHQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeFvGiJLL17RaDfy5qjIVpEjQSmXAR0sLbVsP2nS9ofRds3NvY
	o4w9XULPVqXEusroIy2E7s2BMX+gu4D6x1YDEoKVC9vNJjsnQrUasu+ZeQFtuG0=
X-Gm-Gg: ASbGnctiK5wDnHpbGu2ECC7eHVz7H20raWkjQK+6iKk9KDrypzmVtFZCXVUgjrUYEZ9
	rByl7yimeorSVzb+SVmcUe04Wh4L3dAGjpCzXNgbTSBkkTKUNh7DgyejH0SN/wzBY1+x7b5ceun
	MXdG9isf0mmL0sVbzgAl+M2HL0lEv+eTgfcVllWMbVSCxsLcR3kRH574m5X9/V9N0jQbYYMnIc0
	gmEvxxIkn+bJTfizyJCRbdyBR3ZBx1BfB1hL8N9tq6IwVAlr7gVzrZlVTmQ1DACCYI6gV410feI
	RjL7BfdvknLLp5N/wM+xcpbcaGgeq5x/qC3fzZbTmghociYPFr0yqINuuV5SE3wksQOwzMpCBaQ
	S6AD3Pw==
X-Google-Smtp-Source: AGHT+IHXypG52wXkYLxSSmyf4bbr7jeX4L7AiMB7t5V529YkEH03E02hDurhAMGW0udAqKDM+HrsUg==
X-Received: by 2002:a2e:321a:0:b0:309:bc3:36b4 with SMTP id 38308e7fff4ca-30a80c0f0c9mr19594681fa.6.1740506200764;
        Tue, 25 Feb 2025 09:56:40 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30a819e0a5asm2883591fa.19.2025.02.25.09.56.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 09:56:39 -0800 (PST)
Date: Tue, 25 Feb 2025 19:56:37 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Ayushi Makhija <quic_amakhija@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	robdclark@gmail.com, sean@poorly.run, marijn.suijten@somainline.org, 
	andersson@kernel.org, robh@kernel.org, robh+dt@kernel.org, krzk+dt@kernel.org, 
	konradybcio@kernel.org, conor+dt@kernel.org, andrzej.hajda@intel.com, 
	neil.armstrong@linaro.org, rfoss@kernel.org, Laurent.pinchart@ideasonboard.com, 
	jonas@kwiboo.se, jernej.skrabec@gmail.com, quic_abhinavk@quicinc.com, 
	quic_rajeevny@quicinc.com, quic_vproddut@quicinc.com, quic_jesszhan@quicinc.com
Subject: Re: [PATCH 09/11] drm/bridge: anx7625: enable HPD interrupts
Message-ID: <l34eya75nmzh5j6jyw6ne4unwnemw4lrjdf2q5hm3d6jji6pvr@rav2vgfwioeu>
References: <20250225121824.3869719-1-quic_amakhija@quicinc.com>
 <20250225121824.3869719-10-quic_amakhija@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225121824.3869719-10-quic_amakhija@quicinc.com>

On Tue, Feb 25, 2025 at 05:48:22PM +0530, Ayushi Makhija wrote:
> When device enters the suspend state, it prevents
> HPD interrupts from occurring. To address this,
> add an additional PM runtime vote during bridge
> attach for DisplayPort. This vote is removed on
> bridge detach.

Well.. You can guess. The bridges have .hpd_enable() and .hpd_disable()
callbacks. Please use those instead.

> 
> Signed-off-by: Ayushi Makhija <quic_amakhija@quicinc.com>
> ---
>  drivers/gpu/drm/bridge/analogix/anx7625.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
> index 4be34d5c7a3b..d2655bf46842 100644
> --- a/drivers/gpu/drm/bridge/analogix/anx7625.c
> +++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
> @@ -2168,6 +2168,9 @@ static int anx7625_bridge_attach(struct drm_bridge *bridge,
>  
>  	ctx->bridge_attached = 1;
>  
> +	if (ctx->pdata.panel_bridge->type == DRM_MODE_CONNECTOR_DisplayPort)
> +		pm_runtime_get_sync(dev);
> +
>  	return 0;
>  }
>  
> @@ -2175,6 +2178,9 @@ static void anx7625_bridge_detach(struct drm_bridge *bridge)
>  {
>  	struct anx7625_data *ctx = bridge_to_anx7625(bridge);
>  
> +	if (ctx->pdata.panel_bridge->type == DRM_MODE_CONNECTOR_DisplayPort)
> +		pm_runtime_put_sync(ctx->dev);
> +
>  	drm_dp_aux_unregister(&ctx->aux);
>  }
>  
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry


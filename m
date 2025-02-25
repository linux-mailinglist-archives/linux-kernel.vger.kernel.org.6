Return-Path: <linux-kernel+bounces-532133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49231A44951
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 19:01:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7888F3B391D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 17:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDF5819B3EE;
	Tue, 25 Feb 2025 17:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JZVtUhek"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6FD199FB0
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 17:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740506145; cv=none; b=nLP+jGBh8mRlzBIfT2LMaiDdQ0mLwypO7roi/3D+Y7UUjA08ru2q/xjGCPxHy8Drd8ZMEePPXsn0SwIvlovkvaahHt6sxqxqWqOeANHocW85cP1M5xY64YS7NB/aw/u1BtzyYNDiQTOr/n/Zi48hv5bdYn5oOmMmk+msFQuKPFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740506145; c=relaxed/simple;
	bh=ASfDaNLZIFf+zIGofhH6WgCbGbuLF+xCSiQVDoXkU/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q719TySO1AcshGXh12MCwAZ38s0ObOs5NbzI4RskFOIhPVUNzSPZKLXJZt9+lIrHGb6Sd1Zu5NI52fCR4o6JKj7YHkgB/oiz1DkrhXbHx6AKUIaxW23kijOcMVXangmeq2ph/uEr+/gOgIca//i0UmlLLInulEB4S/vonXmYDh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JZVtUhek; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-30a2f240156so61105851fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 09:55:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740506141; x=1741110941; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eq3mOy20yNbp2lX3RjGrzkzUuuAverI0Nvq0Wo8uGL8=;
        b=JZVtUhekRCDVuQ5lZOkgRpkDbH1O36VOBeiLd8iQlxfo4aRh548p6i2VqpyMvhUYNl
         JeO2zu1LI0OrZn1L/0g1jCZwA1wpI3iGqy6Be5eOZe5Z0fcRFcXu9ouh2p0QpXXjfb/y
         ARLxK+LewTHuHYOAICzOsdk0YlOuOwG8lj+AJ12+FQIuGp5aAHS0DjFyXqEUxp2FyO4E
         az9W96z5EgtySKWar3oJSfX0jZ6Qy1Mulzvex2QclL77GHNuNkWqeVothAh2o5bcADMi
         dcMUmUMnPD/LQPVChqhXW8axhGO8IuFQkFzWK7XCK/49nd/2KLBcWyTREUCPqmtDov9j
         SW9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740506141; x=1741110941;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eq3mOy20yNbp2lX3RjGrzkzUuuAverI0Nvq0Wo8uGL8=;
        b=puUsqJrS0yquoRaUjA+eHe0QXr633Rfgvj6JBKEW4glIMYoWfxGPTYioyt7xrYoJa6
         6uK7qkrWMUhhDuQKEYotcvsEGxZAwjq+WWja4u2M4O0WclVNMt3CJmxXy7H2zBi0jtXr
         trpC6/5whEnOm1WVzs/pY7Fry0qjDMp1oRljCgClq8f71zNVJGUNEL2jCOupEceY2TN9
         gFsZlQh7l/rGoCHPh5kO42f2Wvw816QgI6HRCI+BT61rFzmbHVyJSoRVMOBw+THHfjC7
         4lIrLxbHtCB/9CbJ2sIQdryVoSF5wfra/JUx8wSUpKPE1OpNlRbkBL60VB4gC41QwI6p
         t1/A==
X-Forwarded-Encrypted: i=1; AJvYcCUFmhDnzMwuPIDLbjTKb3Rq7+5ITgUUGXPDRvUqHXO1xIhLsi/rnDRQiCjHHlKT5j+32RM3J3/PynFnokU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxTze2DW4BaYCsawhETEEGUOAZ/T9AKld7CTc2D+n2B9yD5HE1
	Y9Bi39B5mrYWjMZbaxWMR/Gj7tFHnZXevtNeJKcKpsTPbQ9d6cqcG2p/xwFY6Z0=
X-Gm-Gg: ASbGncty1NUmYL9JzuFMhI4fHkHYF/HAcZ4/D1xjSdzRm7I+p8Z8wgWwFQF2CCVSsH4
	0cG+mRtl/Hw2+qDaWuSoRc/5D+tnNdhk7tVde5rgGDyRtyN36MIJIY1XSEVyeimo9NwJcdoptdG
	VC4ZP/NEWYVbchgbnDbXr5oLx0QTrPqeY8NU2riQXauL5NgaY7d+yJeCEhvehjfG2kiUqX3bRu2
	A0mP2Ceds9jxCaiGrTXMIW9hG1zndKoqmidAVJFFjg7KgB4/ie9/SxHQgJcEkito5Pe+ZpKUKnQ
	MGZUODEkU0ntTfcj+o8yZJiT+PYGchXRM+k4enWw/F0W4JwQcNQoHp6fx0qps+ABec2yS8MNtyl
	1y2xqvg==
X-Google-Smtp-Source: AGHT+IEtBPGhJEFmYORVcpbY565FvoQ1gkddd4xE4WqD8kbOZNOXiopkLnrRw1ytEuGRZvYQRQselw==
X-Received: by 2002:a05:6512:3a82:b0:545:271d:f92 with SMTP id 2adb3069b0e04-5493c57ef04mr234185e87.25.1740506140684;
        Tue, 25 Feb 2025 09:55:40 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-548514ba1d5sm243569e87.98.2025.02.25.09.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 09:55:40 -0800 (PST)
Date: Tue, 25 Feb 2025 19:55:37 +0200
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
Subject: Re: [PATCH 08/11] arm64: dts: qcom: sa8775p-ride: enable Display
 serial interface
Message-ID: <tfd27qk543dt4sqcawogoszsjax3cqxmi6mcy3qd2mwzauedpf@l6xmy5okswrd>
References: <20250225121824.3869719-1-quic_amakhija@quicinc.com>
 <20250225121824.3869719-9-quic_amakhija@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225121824.3869719-9-quic_amakhija@quicinc.com>

On Tue, Feb 25, 2025 at 05:48:21PM +0530, Ayushi Makhija wrote:
> Enable both DSI to DP bridge ports on SA8775P Ride plaftrom.
> 
> Signed-off-by: Ayushi Makhija <quic_amakhija@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sa8775p-ride.dtsi | 66 +++++++++++++++++++++-
>  1 file changed, 64 insertions(+), 2 deletions(-)

Please squash into the previous patch. It doesn't make a lot of sense separately.

> 
> diff --git a/arch/arm64/boot/dts/qcom/sa8775p-ride.dtsi b/arch/arm64/boot/dts/qcom/sa8775p-ride.dtsi
> index 151f66512303..02d8a9c2c909 100644
> --- a/arch/arm64/boot/dts/qcom/sa8775p-ride.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sa8775p-ride.dtsi
> @@ -128,6 +128,30 @@ dp1_connector_in: endpoint {
>  			};
>  		};
>  	};
> +
> +	dsi0-connector {

dpN-connector. It is not DSI.

> +		compatible = "dp-connector";
> +		label = "DSI0";

Is it an actual label on it?

> +		type = "full-size";
> +
> +		port {
> +			dsi0_connector_in: endpoint {
> +				remote-endpoint = <&anx7625_1_out>;
> +			};
> +		};
> +	};
> +
-- 
With best wishes
Dmitry


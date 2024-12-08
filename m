Return-Path: <linux-kernel+bounces-436352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 694959E84D2
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 12:51:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19A221651BB
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 11:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 041AA145B26;
	Sun,  8 Dec 2024 11:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hzv4VF/w"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82F113D896
	for <linux-kernel@vger.kernel.org>; Sun,  8 Dec 2024 11:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733658671; cv=none; b=UQpP4/Bh+iboVUa0VsMH4C6xsU6GAv1Ftqi40O53hx8DJ1cuRcHvtas+J5BrN8peIzhbbid//Pmy1py9ood93tzmzmIfJztgvTwzEbH/PzLtGtb+muazEFkRYTjRPynMebAq7g+5sjNEG7VsYCo0n7ivaEeYcu7FNoQGOc028zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733658671; c=relaxed/simple;
	bh=EJBI7ckWwHleaAAyKHfoAVyz5AfHC8lsTPOMhnMxmcM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ge/R0YYyB+e+Pc+sp+7cPk6dPihfZMV4udfPdpvDEWCPHYVxMqkSzgDQInpsPWsQr7w+jmytGgQCFFlynPYyaGBbSly8RCGr3zaQHNj1DYvYMxphBFb4DPA3CZmTFI3daCH8nqiyk76JbnMEoWmgTxufTiAY8qiDjokYqJlIkCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hzv4VF/w; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2ffd6af012eso39006501fa.2
        for <linux-kernel@vger.kernel.org>; Sun, 08 Dec 2024 03:51:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733658668; x=1734263468; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BjiC5PAenMu08TFijRNbc2fm2ozHjMgrzs8cxLgoxyE=;
        b=hzv4VF/wW0EAuiuJJuGwbbry2w/uj7Ix/MKQaFz6KkozvVMJIuA1eCM/8xfLb4WlZJ
         r1whh9t4lA4c40b4X+96kKZtePlrdniygyOhpKXcFzQm1f/gBgOXuii3KNPYLG6JmIgl
         2DVckgPAEXiLkQX3un4oASUDk/zA4NIO8wK8x41Jb3Vd2PvJnAk2j1VD6/HbiYCOzhhF
         VwKJWb6YSjD5cLeS3scyC5zgaRHJAPDZ7ZmWfI3mTJydWYcRN8WU+cvCDJ0yoFcTu499
         ya8ksPnyGFhSq5UtBauxNk5ZYIFyLbzeKrBGo6tU6mAkRdYNZjap1qpenIH/Cyv0scx1
         OLrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733658668; x=1734263468;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BjiC5PAenMu08TFijRNbc2fm2ozHjMgrzs8cxLgoxyE=;
        b=j8ApGmz0E3dsU/jmcLSZv8XolUdTvva9lcEgaJf6s8TKHRxkf4qzsZCaPsHguTzvQo
         6frwkWjAuh7hnpg9pr1+CXcLkfhVW99w8oT5JkRgc4fET14TgxKnFw+WDMxGLi3wOv9Z
         2L1mOcHheV8/G31mZNqqAcrBqabn/KXAxpOA5uOq5mXyKI2YkLHlSnn5zl3JIpcS/WZh
         QXIi8coHlbuhvSzuHwV2WNnkqg3CNHgDIWi9T8Pq7O/QA7V3kjWUVdPZHZ010FlZIcA8
         QbIf/EJ7duSkkKFqLYuZEwQoz0uXaftJF3AwBOFhFc7ACKJOH+eBPvtRfl0f0bf3II3t
         DMLA==
X-Forwarded-Encrypted: i=1; AJvYcCVK0CKzI+V0Jtv8N5G2+YP9P0o4iERzoOeq8lkpy7eGDyjfNPKwXKg8KJ1xJhLMNn7lvWtISdgS7r+5yTs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/Dtn7WTPFgftczOm9WRth+w2MTxNIyXebzKP0XV4nmh+FN4zp
	25g+eW8mefiQDj80ySBwbTKlT8ueSXkL7HMWuYQjjv8jyN2ivhXUdT1LXJvt2ho=
X-Gm-Gg: ASbGnctDWnfJ7rTNnp/CLBOpMcqt9N0A/HdHZJJKD/3SvOuKQLOqMzHwiYIbhSJ9zPn
	lusV0p02Dq2Np1590px9NFJaZzh+IqTa4BiVSAH8iwFwQnOv2M28Ty/2oN9N3rfpEkRnozV3QBH
	fcmzD/u5Eu9/TkU+zIAqt0dP7U3mrwE967rHWdIE7V6G4s1ckZNjLeSCgaETiq1sp2x35SSrXA+
	4mDW2n8aJcZYg5HJRhDvOEXAfGPl5ikdU3pm8vQrLo7Vvyb0toAGlEeOHuVCBM+MVkJQ0+0OCh9
	SZqtvsElsfacPaps3cVFn8XmQSEWLw==
X-Google-Smtp-Source: AGHT+IETn40N7+7crT4iVG8T/A8ynVmzE/UWImTWcqofhQT1b5XaQk0o+SD2OB6XC+TybBpfRfOZsQ==
X-Received: by 2002:a05:6512:12c1:b0:540:1be6:f15e with SMTP id 2adb3069b0e04-5401be6f545mr507128e87.0.1733658667917;
        Sun, 08 Dec 2024 03:51:07 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53f93369b98sm354427e87.280.2024.12.08.03.51.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Dec 2024 03:51:06 -0800 (PST)
Date: Sun, 8 Dec 2024 13:51:04 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Stephen Boyd <swboyd@chromium.org>, 
	Chandan Uddaraju <chandanu@codeaurora.org>, Guenter Roeck <groeck@chromium.org>, 
	Kuogee Hsieh <quic_khsieh@quicinc.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Vara Reddy <quic_varar@quicinc.com>, Rob Clark <robdclark@chromium.org>, 
	Tanmay Shah <tanmay@codeaurora.org>, linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 27/45] drm/msm/dp: make the SST bridge disconnected when
 mst is active
Message-ID: <mzo5hjocxp666mfadqdmzzbkcbzcga3aatqtv7p5jfrlfeide2@hmmamwhvbfik>
References: <20241205-dp_mst-v1-0-f8618d42a99a@quicinc.com>
 <20241205-dp_mst-v1-27-f8618d42a99a@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241205-dp_mst-v1-27-f8618d42a99a@quicinc.com>

On Thu, Dec 05, 2024 at 08:31:58PM -0800, Abhinav Kumar wrote:

missing commit message

> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_drm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_drm.c b/drivers/gpu/drm/msm/dp/dp_drm.c
> index 920392b3c688821bccdc66d50fb7052ac3a9a85a..225858c6240512cf2c5ca3b5eb52cf9b7f4db3e3 100644
> --- a/drivers/gpu/drm/msm/dp/dp_drm.c
> +++ b/drivers/gpu/drm/msm/dp/dp_drm.c
> @@ -27,7 +27,7 @@ static enum drm_connector_status msm_dp_bridge_detect(struct drm_bridge *bridge)
>  	drm_dbg_dp(dp->drm_dev, "link_ready = %s\n",
>  		(dp->link_ready) ? "true" : "false");
>  
> -	return (dp->link_ready) ? connector_status_connected :
> +	return (dp->link_ready && !dp->mst_active) ? connector_status_connected :
>  					connector_status_disconnected;
>  }
>  
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry


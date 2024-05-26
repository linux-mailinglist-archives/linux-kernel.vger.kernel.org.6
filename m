Return-Path: <linux-kernel+bounces-189874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B81978CF613
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 23:19:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 162FB1F21083
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 21:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96DD6139D00;
	Sun, 26 May 2024 21:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E7jt2jSa"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E91D2F46
	for <linux-kernel@vger.kernel.org>; Sun, 26 May 2024 21:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716758351; cv=none; b=e8E3vF90fAC4EKnHZeh0yy/n3za8Lg2W6wAnGSL9aymT8XOHa41Gq+iQkRDmwcCVlfamW7+ZpuXIdHYsQqWYltLlRF59aKAeerMpddqofqBATVKv+j27cNySAjyzBvE+tijS21tZHu2oRdTwhMBWNcMjocqq2iXfHd6h7UZH6Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716758351; c=relaxed/simple;
	bh=Pn8FslhbcHCMf78r21xAL7hMjz7SqSvFvE3Vdll6SFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LBtAvyMfB2BvszAvWJ+4ykMKKvRyAOEodaVv/rNTmEn8hUH1I1Lhgl8jkVO7J7il3kKfWe5rkm8Fpn/d8V+3eY0OeW6STYgcnOZVxmm+f8OYk2PS3xUvEVMxc3gvyHx5UgXWHoFY+dDbkk26zWmT1wsggYYgPUOUywwssQWFZPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=E7jt2jSa; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2e72224c395so83137771fa.3
        for <linux-kernel@vger.kernel.org>; Sun, 26 May 2024 14:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716758348; x=1717363148; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OEIFM+ukt26ot774C0FBgnpAZ7Ab3pUhoDY2KfgwdKw=;
        b=E7jt2jSabwkEocc9SDeyqYkTOoCDSNIonyrSui7KLjFNKSzgVCGl5UQOIejDWXNgeU
         v737TomtRjG/+5MXW9hgNudUt3dtUz8QsfHL4xF3Hz3IjB3uK8P6WUTUpBKSyh5r4EJ2
         yJttPfF3Hi86kY432Ci9GhMWK+neAXk8j2CiiuouED0tO51yt01OBEjfAznA6nVJZXO6
         zPtjuNLV1Aux0cbB/uVBUQjAy9DCI6/KAYE70oSPKOJKSbideFp1mgEmdBmePDf9tqbn
         M2AvI7LsylE6KC2xkEV0fzsHRjaIEZyDl04AyOynL2u2JVwSWP35MhndVUb+iMKKWD9i
         RnIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716758348; x=1717363148;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OEIFM+ukt26ot774C0FBgnpAZ7Ab3pUhoDY2KfgwdKw=;
        b=NRR5J40tWUZkvnPV8/Zid0W1hUtTBME6zDZxhxKglR1E4zUSiPikeaxnFRcSDsON4t
         p+HwouShk6J02vodUgvG8hlMqiEWRttlAF6UOqvtTPBayIRgKCIg0ODJRWpcVs9hA0A6
         ZYVIVWohxdMJHkT44dcTi8DqI7YOe6MhT4ooMyU7+fxJ1/oryA1H9fhbWTVgZOTpnbGK
         S8qvGI21mZW0y4hNKIEdrlx8UUah8fusWHVtxms6BCWenmRoqml1qAcLsHKcYncR4/ag
         6T/PZ1iaRwHFSnqxzawAGdLdfUExGP0E8HzJVnwT964QyPUFBMsFqa5xlR5J/rlH8oqe
         JvXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVV51AyObiH5e4c+Wf1L7hW6314F3zM7iX1NKtJY/CrxHN8Rl+IleCxQJCKC7daSIkRKujQIMVYNvcT5DtBA23XT5oCPp2B7zm5AU3E
X-Gm-Message-State: AOJu0YyThuk1/uX/Fy/XqCSa8NQWPZPcm1NPr0D22o+4Rr6vyVH43OVC
	/2jvLwuyQgtBEUP/++61bY/25t2dr5fzehtWHJAUgykWNC+k+bipuPQzug853d8=
X-Google-Smtp-Source: AGHT+IFrJTTBkEiw1EI5YgPKR8vkpSp697fOmBeacYJpaNOQSuBqiiQeMhcGuKW0GUoctcDWYbgGhg==
X-Received: by 2002:a2e:2e10:0:b0:2e5:87c1:e845 with SMTP id 38308e7fff4ca-2e95b278a70mr44542691fa.48.1716758348145;
        Sun, 26 May 2024 14:19:08 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2e95bcf47dasm15796671fa.55.2024.05.26.14.19.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 May 2024 14:19:07 -0700 (PDT)
Date: Mon, 27 May 2024 00:19:06 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Sui Jingfeng <sui.jingfeng@linux.dev>
Cc: Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 02/10] drm/bridge: Set firmware node of drm_bridge
 instances automatically
Message-ID: <lfgb24qv22sohgizlmt7kq3ymnshjeawlkwwcndivbeiloip55@x3qnu4ss3x4y>
References: <20240526202115.129049-1-sui.jingfeng@linux.dev>
 <20240526202115.129049-3-sui.jingfeng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240526202115.129049-3-sui.jingfeng@linux.dev>

On Mon, May 27, 2024 at 04:21:07AM +0800, Sui Jingfeng wrote:
> Normally, the drm_bridge::of_node won't be used by bridge driver instances
> themselves. Rather, it is mainly used by other modules to find associated
> drm bridge drvier. Therefore, adding a drm bridge to the global bridge list
> and setting 'of_node' field of a drm bridge share the same goal. Both are
> for finding purpose, therefore better to group them to one function.
> 
> Update the drm_bridge_add() interface and implementation to achieve such
> goal atomically, new implementation will fetch the device node from the
> backing device of the drm bridge driver automatically. For the majority
> cases, which is one device backing one drm bridge driver, this model works
> well. Drivers still can set it manually by passing NULL if this model
> doesn't fit.
> 
> While at it, Add a 'struct device *' pointer to the drm_bridge structure.
> As it already being passed in by both of drm_bridge_add() and
> devm_drm_bridge_add(). A lot of driver instances has already added it into
> their derived structure, promote it into drm_bridge core helps to reduce
> a batch of boilerplates.
> 
> Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
> ---

[trimmed]

> @@ -231,7 +243,7 @@ static void drm_bridge_remove_void(void *bridge)
>   */
>  int devm_drm_bridge_add(struct device *dev, struct drm_bridge *bridge)
>  {
> -	drm_bridge_add(bridge);
> +	drm_bridge_add(bridge, dev);
>  	return devm_add_action_or_reset(dev, drm_bridge_remove_void, bridge);

This breaks aux-hpd-bridge, which gets of_node as an external pointer
rather than dev->of_node.


-- 
With best wishes
Dmitry


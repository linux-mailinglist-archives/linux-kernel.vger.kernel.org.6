Return-Path: <linux-kernel+bounces-447757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52C359F36BB
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 17:56:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06556167AF2
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 16:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB27420457E;
	Mon, 16 Dec 2024 16:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="KZnBJp+4"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F306200BB4
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 16:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734367827; cv=none; b=jkAgWV4wWTFU2eq+4RrjFAJvEFjYxOi33tzOhOb6HQ6ZQpWJ1cYSTQHYbnQeo3CJJ6Gpg599CxM1pqxPIfHulimF8B5jDD8TpAusJw7C5bNoRy0sHlDmrBtVAt5aDWyujT43xGQex/swT1Pcw9A90c3r6sOa4RVDZA7UKDbOqp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734367827; c=relaxed/simple;
	bh=ON/QpB5w0my+fDFQkxt+TZMcyYKzzIqArv8m3H7N30k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kQ1GhBviAGAB6EpCaL53yc6ewjlEsgUxzbPZIxRTdHx7+FNQPg/wVWbmK28mZhfm2cItOPD0hKYJ1IQLjFMyszbsdfk7Qw02JIatnmFYTtoqwO8bE69p/5EPsQatwpcKXyO2KfDzpeoeQR15+XaAgkdgyzKUZkKEZIfMSe6jLDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=KZnBJp+4; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 586B5FF808;
	Mon, 16 Dec 2024 16:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1734367823;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=te7DXBJEFmkw4wLK7+D8XCmSvwdHasl+YkrbIAWRIuM=;
	b=KZnBJp+4gUYWYsyot7di5lM7/foj5AZcdQF/ialAKIa60nENDPGhS2p/dJ7ZxafwwJ7Xrj
	nEzzg3c7t7AEnN/elTuMuoCLzl7c0V96l31xpw4K4mptcPxwIwGbkUc0tQRvr5KNhYjJmg
	IlvS6qLTPJwlvcMsZavLv9wyJLZexokbQrkwUgvQoPgA1cLvzaZl5HN5U4Je8jpoge2uyT
	tXQdceLLLbG3uQfkQ/hB1rBSShUNNQn7YH9+piATy8ybAmfVioOauL5iwJIasa5+sLEd0Z
	BESGLBP5h+SLANk6y69qQos4Ujhj8I9s+Kt5JPl3ME6DMVMlaHRdcCU0cFQ5Ow==
Date: Mon, 16 Dec 2024 17:50:21 +0100
From: Louis Chauvet <louis.chauvet@bootlin.com>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v3 2/4] drm/atomic-helper: improve CRTC
 enabled/connectors mismatch logging message
Message-ID: <Z2BaTT25YfQMzy9c@louis-chauvet-laptop>
Mail-Followup-To: Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20241216-drm-small-improvements-v3-0-78bbc95ac776@bootlin.com>
 <20241216-drm-small-improvements-v3-2-78bbc95ac776@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241216-drm-small-improvements-v3-2-78bbc95ac776@bootlin.com>
X-GND-Sasl: louis.chauvet@bootlin.com

On 16/12/24 - 17:40, Luca Ceresoli wrote:
> This message reports a mismatch between new_crtc_state->enable and
> has_connectors, which should be either both true or both false. However it
> does not mention which one is true and which is false, which can be useful
> for debugging. Add the value of both avriables to the log message.
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

Acked-by: Louis	Chauvet	<louis.chauvet@bootlin.com>

> ---
>  drivers/gpu/drm/drm_atomic_helper.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
> index 43cdf39019a44537794cc5a519d139b0cb77073c..3c3bdef9bcf3c4ffcd861744f6607f317ab0c041 100644
> --- a/drivers/gpu/drm/drm_atomic_helper.c
> +++ b/drivers/gpu/drm/drm_atomic_helper.c
> @@ -666,8 +666,9 @@ drm_atomic_helper_check_modeset(struct drm_device *dev,
>  		}
>  
>  		if (new_crtc_state->enable != has_connectors) {
> -			drm_dbg_atomic(dev, "[CRTC:%d:%s] enabled/connectors mismatch\n",
> -				       crtc->base.id, crtc->name);
> +			drm_dbg_atomic(dev, "[CRTC:%d:%s] enabled/connectors mismatch (%d/%d)\n",
> +				       crtc->base.id, crtc->name,
> +				       new_crtc_state->enable, has_connectors);
>  
>  			return -EINVAL;
>  		}
> 
> -- 
> 2.34.1
> 

-- 
Louis Chauvet, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


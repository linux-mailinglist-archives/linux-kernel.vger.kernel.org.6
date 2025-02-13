Return-Path: <linux-kernel+bounces-513466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CB88A34B1D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 18:01:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1E023BB9EF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 16:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3622324500D;
	Thu, 13 Feb 2025 16:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W9nYBn4l"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F5224293C
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 16:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739464702; cv=none; b=mh/+GH+yKgkdghkcEs2XxDwTt4pAtzthFo5u+iU0RajI22cJiYphsRc86yaJyjqXRhpxVEJoueVs5zTSKgPs+ggdBtQ0Id410vqMu+eb1q56MKBJNCMplevHfNNnQQM/D5bqFIg+/5Dx9L9Cdt/tSm5N6JuyjIMYBe/kOovxogE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739464702; c=relaxed/simple;
	bh=B5qWNfoYlBUiLxITY+9+aauApKTPG+g5BRSPRnoh8jg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hfT+Gr1n13iIji/pXJaJO5WtYkV1Kg+F5f5HE3E9uNAumkDrP3ubiRd8E+AppcAs7z68RYMd1KsPKr3yVRU5t3iVjgnb0LkTOuZ1nKubz7TcQ9/ua+CRLXArTBHtJTTvZYzdstSD20Smmj/W01VoTrrvyrPiS/ca/rBEN7VmNl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=W9nYBn4l; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-307d1ab59c6so11438821fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 08:38:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739464699; x=1740069499; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=H7oNCp/RNw3t/6zsGfDVg/YzDuWbFw2qOHPXbSLVPyM=;
        b=W9nYBn4lgLCcIBYQerBHFujHHOJ3XcJLsxoZDBzXbWMIIcjHIcxI/ZGhrweg/prXll
         b2Guacgl8kzDCeH7NmaOPM531okS2Tpi1b+ujz70wEGrp8fUMoeEY/2f+uFBTFccBUEE
         d4JpCKOu3Xyfs8wH5vEcYsgIqz04YPX2XVug68HAoBVG7JZTCZWWvUlAD6y28VY+Pj+N
         u+wwuNAv09tGq5OVQapyUYfJMdYMr6jfdLmvobi3WyEbaSw8AbqAbgX7ZyQpjTWJUNvd
         0IhQjYHHO00gn1EmhW4EHgGjfqCjKoAC+mXYpLB14YIgx0xFvqCHbeZUZDhLDSBVOToF
         LzYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739464699; x=1740069499;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H7oNCp/RNw3t/6zsGfDVg/YzDuWbFw2qOHPXbSLVPyM=;
        b=pfIOcjZjM9LnwqUyYQ0PgD2kwWkFG/T/Bc043gxwbtkQ5VngZYqPcjdOo3+0bIpt6X
         SCVVLqHKyCznbvGcwP2kWm0dEFSxRxrUyaaKZJ6mxjyQeAirmPNj9Fan4q6qExC7/zRk
         DWfQNUl9GitYgKQegXggOI0tosP5ETu1awGMqwqAV6r7BmZPmYM+RKpP027AbFnzg7dJ
         GUOrUgxSNSSOEjuwRzZ2OXHGtNNL/WNZ9Xs4+RgyFJjjw0y2q9TkXEHef5LBYT8zjviO
         GDMzQ/CMNAxqidcQp//6Pj9opDoHIwTs7ab8XdD7vdJddRiiUIiO0wrxmoE5xEwJUsZd
         BUQw==
X-Forwarded-Encrypted: i=1; AJvYcCVvAHkorRdF2jqhrISnfFSw9YvZOTGcMlrrOo5jvZ+OprUsUJ1BaAFzV3/m8Y7Zole2OM4yBeluc71/ldw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxALS5oQunJYAfA3DxYpRz0fU3yNPCiJCKfnHu22Rc1Bi0+qMu9
	dP53MLmYR7LbpLlNDMUdZK4qWFY4nFywxbMO/rR+sbG5zVOc+C0k+Vf/zDwunTM=
X-Gm-Gg: ASbGncsu1QpYzvstFRTpSomX+ABRYn7D7IK/Q69lQjmI96fZ194lkMGSyLcgA4zPUOo
	WUwcPKGx73uSesECCi3zud5BI13CzKv8r+6BtV8vHEdU9+PuddQVQhk8WXOBLMXRZ0/9/mWf/32
	XHik3bLUtMyWBZ4ShthNzSW9dh4aG9Vsbcpi22MVRI1xDEMjyCDUVH3DMZ6z8LOYu2S/xi/KnKh
	xPrvxoz5V6eiguB5uITb8pDj6AzOvPe/XVEo9mqj3MUKlySdeFOUZtuWXhelP58meEjmZRv77Xg
	4dzN7LqpCBaI7y9g0xz2qKV6qgYV4KfxP5gr4Ra08hyFfUSOZqCpdy4Ope3YYgS/JuYFDm4=
X-Google-Smtp-Source: AGHT+IGW0S6KCFdTWz+vmS0HhCwPaLiMVHP6qtL5u7XOftiqOSqmrNbkzxLuEikhD4tCSFf2PgGIuA==
X-Received: by 2002:a05:6512:3e14:b0:544:1093:ee3a with SMTP id 2adb3069b0e04-545181165a8mr3170001e87.24.1739464699023;
        Thu, 13 Feb 2025 08:38:19 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5451f09aa6csm220892e87.60.2025.02.13.08.38.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 08:38:17 -0800 (PST)
Date: Thu, 13 Feb 2025 18:38:15 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Douglas Anderson <dianders@chromium.org>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 34/37] drm/bridge: tc358775: Switch to atomic commit
Message-ID: <ydee2uig6zpjzmvbprz74z2yhsxrfqh6wvtr573ajzpkx7dfqp@me5npf22nypv>
References: <20250213-bridge-connector-v3-0-e71598f49c8f@kernel.org>
 <20250213-bridge-connector-v3-34-e71598f49c8f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213-bridge-connector-v3-34-e71598f49c8f@kernel.org>

On Thu, Feb 13, 2025 at 03:43:53PM +0100, Maxime Ripard wrote:
> The tc358775 driver follows the drm_encoder->crtc pointer that is
> deprecated and shouldn't be used by atomic drivers.
> 
> This was due to the fact that we did't have any other alternative to
> retrieve the CRTC pointer. Fortunately, the CRTC pointer is now provided
> in the bridge state, so we can move to atomic callbacks and drop that
> deprecated pointer usage.
> 
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
>  drivers/gpu/drm/bridge/tc358775.c | 41 +++++++++++++++++----------------------
>  1 file changed, 18 insertions(+), 23 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry


Return-Path: <linux-kernel+bounces-191600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA4318D114A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 03:02:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC16A1C21528
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 01:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A4718F70;
	Tue, 28 May 2024 01:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vu8PyfGX"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8D4567D
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 01:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716858130; cv=none; b=ZWp+fa9ajXa61/sE1eZub0X/E4KEuFLqNlrS6oo2f68Q9H7uPiLHl9Ie1Sy8Go2j+J/Kye6tUnXRkHGzGExxdF5XNXWhYNIwLuoFECTieB5ib4RbfkyN7FA2BEJ8hVAsSg5mEr77QLZFG4XJh8X3E9PvlgFnOM+FnPjbRom693U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716858130; c=relaxed/simple;
	bh=KOa3mB4OmQi59T0Ompo2h1ZmaG3aUD5FQbKMxzTpfs8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RfhiwALt/XCWh/GW5d8uL9gD7ifhoI6nsfrkCWPtmHMK5YgN1D66+sxXMyBwX9ZF8WicmWrFwIPUIjL2jee8NLr5AWD70QjjiwyhLavluoX2Fnoq9RHp0M75QnolHwt+qz/brZDIYSZ/RVxod2kdKIiJg5dW8e6iwQeIq3UIIJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vu8PyfGX; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5241b49c0daso357893e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 18:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716858127; x=1717462927; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YyAxoHilgrk8yTu5a6z1lAdisdBZ34CZ+2kOXUlJDWg=;
        b=vu8PyfGX3OfyFAX/aeKK/pvTTaW8gVeR/WNL3U6EQ7UJgK6s6vcOcdGjkulVV1iFQh
         TlBCashbnFXD4y9JDGDB1KH8bcNaDk7kLptw5n4LVbBYJe3SD/FPdWPtUMUDjlomIVft
         ekV4A3JGGzlogrO+59bAVZyIo8mi7IbU314+PTvGgP1HWJHggJNWlQfvxsiuHYzTcNqj
         vL87anpWxpzmDOAVs3A4/a1MoymvhRzqw8puPHgWHASDzpAJRMjbcIqmsnRu0UF9PBtf
         pU84tQQEf4ptUgyF8nHqeRoukWqHy3wum9PMNtjDJ9zwJGIzvXbs6u8mbmByxuonjsll
         raWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716858127; x=1717462927;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YyAxoHilgrk8yTu5a6z1lAdisdBZ34CZ+2kOXUlJDWg=;
        b=baBWxZH6GmSRRSGVq16y4HZK6K8iljptoU5S9RsZ+w3Kjw37l+HQ5jigw9F4G3lQu2
         RVJ83PBwqQYZrnGOSwxIlhNdszMVJkWlVjpU7qTBTW4jxwLhWYReamGBUTpaD9bbbRvu
         FLBgneMzaE+Nd+JfZReLWctE5DL1UlLIjx0E/DjV6i6ReijeDLbEUEC6Vh+2V8RP892Y
         cjTsGtgFhaJtRRPAOXR8MnhVPPpbz7qdLurlEqbXFhsC25tZVffudi+4ouMXtN24nI8B
         9AJdCACBGmj2N0izlZt58n5R6xliZAAgGfcnUfAVzO6fBZSAG7GcJEg5Z8HFbZBpAIpW
         yYTQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbzUXa38fat1O0I/ckOIdruZ4sapeQ2HQ7zGaQvHIZxsuGzE5CS62MB5/c6/1RRKwRklToZ7PcqVTqQBb7+bS82GrT6CK4q67DMacq
X-Gm-Message-State: AOJu0YzUoogsjwnWsUbqR4zBgln635PuYlP9LYb+43QrjBcgaXtY8KI9
	MGpu+qREBxaZ1eDTLuzB8LxnwRiFTCzrbfSbkeZJ384eXKMFIhahu+aXc2RincfrODmnPtG/RM3
	S
X-Google-Smtp-Source: AGHT+IEQ1go2DE2vSmAmNQguv151cKtPHWKixqKjqFT5FdpVV7xbcj5tzLUBy3oX+M3iCDABhJj8OA==
X-Received: by 2002:a19:2d56:0:b0:51f:452f:927b with SMTP id 2adb3069b0e04-52966ca6423mr6095364e87.45.1716858126970;
        Mon, 27 May 2024 18:02:06 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5296e887a56sm819467e87.23.2024.05.27.18.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 18:02:06 -0700 (PDT)
Date: Tue, 28 May 2024 04:02:05 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Jonathan Corbet <corbet@lwn.net>, 
	Sandy Huang <hjc@rock-chips.com>, Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>, 
	Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, Andy Yan <andy.yan@rock-chips.com>, 
	Hans Verkuil <hverkuil@xs4all.nl>, Sebastian Wick <sebastian.wick@redhat.com>, 
	Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, dri-devel@lists.freedesktop.org, 
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v15 17/29] drm/doc: Remove unused Broadcast RGB Property
Message-ID: <pybexd4vummb2mgn3kgfc52hcbsk7nb6eumizsoschfbevgevd@4i53cplvtbtq>
References: <20240527-kms-hdmi-connector-state-v15-0-c5af16c3aae2@kernel.org>
 <20240527-kms-hdmi-connector-state-v15-17-c5af16c3aae2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240527-kms-hdmi-connector-state-v15-17-c5af16c3aae2@kernel.org>

On Mon, May 27, 2024 at 03:58:06PM +0200, Maxime Ripard wrote:
> The Broadcast RGB property has been documented as three separate entries
> so far, each with a different set of values.
> 
> The first one is pretty much the generic one: it's used by i915 and vc4,
> and is the one used by all the compositors.
> 
> The second one is used by the gma500 driver, and is a subset of the
> first one: it can have the values "Full" or "Limited 16:235", but lack
> the "Automatic" value.
> 
> The third one however isn't used by any driver and documents the values
> "off", "auto" and "on".
> 
> It's unclear where the last one comes from. It was first documented in
> commit 6c6a3996f2c5 ("Documentation: drm: describing drm properties
> exposed by various drivers") which adds a number of properties used by
> drivers, but without mentioning which driver was using what property.
> 
> Grepping at the 6c6a3996f2c5 commit however, it looks like no driver is
> actually using it, and a quick look at the entire kernel history doesn't
> show any match either.
> 
> At the time though, gma500 had an "audio" property used right next to
> Broadcast RGB that did have the "off", "auto" and "on" values in the
> same order.
> 
> As such, it was probably a copy/paste or scripting error back then, and
> there's never been such property used in the kernel.
> 
> Either way, it certainly hasn't been used in a decade or two so we can
> just get rid of it.
> 
> Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
>  Documentation/gpu/kms-properties.csv | 1 -
>  1 file changed, 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry


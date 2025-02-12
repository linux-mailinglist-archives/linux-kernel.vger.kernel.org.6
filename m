Return-Path: <linux-kernel+bounces-511898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F38A33129
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 21:59:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D0021883954
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 20:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF55D202F8F;
	Wed, 12 Feb 2025 20:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ss9ABUeM"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85DC7202F68
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 20:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739393974; cv=none; b=tScZkXVF3TwpvQCLTcRqPyW1dZGrVjYxStc6ctpyMSUm9sTqDGgDJBxHNfBnOts7Olc1DvJcWc8of7nqECMg+9K5ev/LWbbFO09JBONVeT/T8T+tcbc4s2/7OU09hCqgbC4Y8f0HMB2h5NuLqlQB5d3CIY1Xioj249l25jGi7sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739393974; c=relaxed/simple;
	bh=sKI0vLNVhAmeaIjFu9+Bt3XY4WiDbFQ5R37qD+xyL1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tRngc8IXgjFJriegrKU/zdjDntpJa49TPAN8dmiQdVTHqevJDnbawUiIz4xC0LVT2iccFzbBN3pn2QKmcwWiA6JCN/5wHM7aPa9vi3b5TRGlghmS0KDC6+KIjLYiaivBRyMDFP7lgwJZIBMAX//LWt2nk179+DrCmDH1/FvlFU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ss9ABUeM; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-30613802a59so1895111fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 12:59:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739393970; x=1739998770; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kAeorjfeT+F7+M8JM4C+sVVtADje7c1d5OIpx9HNApo=;
        b=ss9ABUeM647d663Q6uWHjTT0FDiu9Pvn843K4DqGhkfB02byt88cGRotJS8+7bOKn0
         0WfWy9eKV6bjcETcfe+Cf5KOWqNumwlEp0Zulam7l8Cfl++HOY734Ed1VoWDXOhDZHps
         u3XHREgSpz2algvI05sFgBlsL+nQHTUnnUjKQ+Jw3e8yPrhgJLLJH7qvrJ0qHsZrcXCr
         Gy5vX50Dezo1CStp/sn/m3qQjz0lqrp+6rIE1rz6+vDfi4JToPJz7yb2UPqMILX5E+kM
         6tWlZU3wlf3+rnHy/T9yPQX3G+joVxBQrTgcUvb+Zu38SiFMhr7feTU0c3rt1kjQXpia
         XGBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739393970; x=1739998770;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kAeorjfeT+F7+M8JM4C+sVVtADje7c1d5OIpx9HNApo=;
        b=gb1kcwt4+SinpwtdbHKf7b2SNXgbzVudrECfVpV2MVIhblIIJTspHWA9OW8bQ3evpe
         veRt/NbEBCPvVNTkXVIJzcNuVtNPmOwGTyq52qj32Fj/Tin8UNjKFon4ijKUHfHh8wDs
         1BWSsP8xp7aR9YTxA/YYRKdUuNCgpipXQNOvTaLl43nxkm1tCxsfw+WmSG+wq8SNJA5N
         AFzgY3xPT1CP9c8WuX6efUsHKmORAKTwrZalbGpdRIjg6z1Ckpas1ivPu51FPvMu661Y
         sOAJ6NF41JE2hJDEQ085HBz7z4X5GP6/97z3JXYLE27IiOkiQ1Ytv0P83mil42o8G/FH
         BL2g==
X-Forwarded-Encrypted: i=1; AJvYcCX3k6NlQ5O0SKEfUqelYlnmUs617I6Vc6A2lwe3D+6kHLVSZeGVazQqKr+hMxi8h8cThx8jU8DOfivCun8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRRFlNqHIROREM372/SEvYZDN4CcX86pWbBnM9Y+CCSL3zPu6b
	VymGxi9aAqGrDmgeXmKr59rgD77IXarg2vlSjemttFgsgm81SodvZNfY8A/edDE=
X-Gm-Gg: ASbGncudWTn6Om1BS/x2UyNWypOLJ+tl1GqzoMasSmCitzZz93T6ggzjAO8IEoo9ejS
	YFYlR8xn3IZ1SCThDHN50Ww/V/No/WLJwdIcbbJvuuwpG96kai7B/VL0fpqk/MWflD82TlC9U1c
	a0Fbvj83JrHc/elgb6LsTcqViXHD0j6nRqxwe4uA0W1X9tE6y5N64v+tqJx6EkIpVY8ZDMZCyDd
	B3N3SQmCMVrnINhKUYhrhgST5i5L8Hn8HO2kFv8Fzw3yj7UhwAOUot79+Z7jHCZUNecipbE7W6L
	xiyLP2AFUmktj1Cwo48RxOyQz3WCFDnB4+pa/j6byG+JQqFfeUXZwKE7cVYx1mezfXPAaio=
X-Google-Smtp-Source: AGHT+IGChs7eHa5zRInuSJK19SwStAtnpkYkKhpcmEqmNGCW83MiqEgl21ooIzHv9HbzfRFXz88PHA==
X-Received: by 2002:a2e:a58a:0:b0:308:fd11:7705 with SMTP id 38308e7fff4ca-3090363079amr18485971fa.2.1739393970449;
        Wed, 12 Feb 2025 12:59:30 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-308e5ece169sm13217001fa.32.2025.02.12.12.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 12:59:29 -0800 (PST)
Date: Wed, 12 Feb 2025 22:59:26 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Louis Chauvet <louis.chauvet@bootlin.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH next] drm: writeback: Fix use after free in
 drm_writeback_connector_cleanup()
Message-ID: <bzcdg7wclj4moorz6f2hqkoycl6z7vqzsonok6h7s4wc3pfeo5@whduc52pided>
References: <78abd541-71e9-4b3b-a05d-2c7caf8d5b2f@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78abd541-71e9-4b3b-a05d-2c7caf8d5b2f@stanley.mountain>

On Wed, Feb 12, 2025 at 06:23:48PM +0300, Dan Carpenter wrote:
> The drm_writeback_cleanup_job() function frees "pos" so call
> list_del(&pos->list_entry) first to avoid a use after free.
> 
> Fixes: 1914ba2b91ea ("drm: writeback: Create drmm variants for drm_writeback_connector initialization")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/gpu/drm/drm_writeback.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry


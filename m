Return-Path: <linux-kernel+bounces-335256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22C1597E327
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 22:15:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F14D1C20E2A
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 20:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84AA342047;
	Sun, 22 Sep 2024 20:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P0yKFh1c"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F556AA7
	for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2024 20:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727036142; cv=none; b=KkHDjNwxPbfkVEE6xhO83qY+g8idSSEfHU0VmSnRMrhx7+M7eQevpoHRhTFz7bF2ROnAzmvld3qW/GHW3FiQ82BKvp38dwy+FnHjU5KUxdTY9A+ANTRrNkcsTQurOK7bQgUOKQeqDS3eLGce4wNMUQSa0eTS8CyM1nIn5PGxO5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727036142; c=relaxed/simple;
	bh=Zs+cLw08UG8BxQ4Q1tDWAsuNQvUjJ9t3Z/gl7ixu5g0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jqda82uHgDCdjjlk5rcrDAWCX31K+yCHMLkz0qcoo0quKhRzFRQRUEA/OwsS4ahtPH4U5CBeAazltVOqdvm7lLwW4BkuD5/mROHn08M3IzGUY0nrsB3eXOyMMii/MCNTMsGExoRA1v9s5NZzpM/rR0Q24ZdtWgh6LbmZPrIyghw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=P0yKFh1c; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2f75aa08a96so38801131fa.1
        for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2024 13:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727036139; x=1727640939; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eJsTZ+fGWzXXDKSrSngpUpGtXjiwp5GwNrKRxzMEJb4=;
        b=P0yKFh1caiWwXwPyEB9c3yoS9kLAKOpBw6qwq3hQXMOMtu+qs2M2lUr+o3DPX4dRu3
         zFGOyLwyjLF/ias2Tv3kEk1Xsu1QH83EC3chBsSgjCqdjw8m16V9w6T10q6zvIJsj++S
         VnqXV/kEqafWywQfIyJpMtAOH5F/U8q0kxD1KGuQOspTFXemL49EeJ6RRBGEfmyrZMOX
         kMcOu1PlYaXsEnFa6gmQkGvHT1XFJkb/l1+i1ZmE1qoUSshmOZbIb4B/61JsA4P8yTuC
         2W6nTFaVrnpWYnJTwNzoBSKFfCeX0fvljEr3v+M1q/Ig8taNM45Ndz8D7wM9fiLIk/92
         x5uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727036139; x=1727640939;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eJsTZ+fGWzXXDKSrSngpUpGtXjiwp5GwNrKRxzMEJb4=;
        b=gamO7wRPvV7jyNwn9kFcZ0+vLb1bzk3k6YlOlUQdoHzyfn5J/P0r/DTk0MdbTm0rgI
         +0xHpeoBHRtFzXlh4uOlxzTqGXnmh+mv0nwFUlMtNwOsQnDLjT0x/5HuLZd126Fl694G
         XPYcsyCozs23+kgn7YeOsjn7zJkrKAUsddTq/wcBd+Zr9y6dhnbaQ+w6usjJsMPkUlNp
         OsPb3Bu6/zzSCb6LLotBMV1h969yfSua0mqv8jUkPTH0QhnzQ6TsZByvUwvv2+hDxx23
         gswpaEqlPapM8Qf7no1nv5bJ84XgWXVOtnJ0XecoT5Ff1xPEYqYBs+7spz/YYXbUGSu3
         z0FQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAsAmtDv0nkRxcSNboIH/zxy1ow7Z61s0vrIcpiOcjI4bMhEj9UARajAEsWYmB/EIiZ/WtSAaIR1vH1J0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxD/eN1tuoMKtKFr8wcvyJMjy11gBPDzbGKSy2/pSYQ3U57287q
	9XfXcNydDN+G73yoXQQY1+fsoY8PQUzUuZWz1QI50cSzC2QGSZuz0PVOObVqtS8=
X-Google-Smtp-Source: AGHT+IE8Z3bqAVsYlxzrsQyZTx1dyP/WVnF//ZUsQidajA2RmozHRC+rqTFmK7pyFw1iTwYRorOusw==
X-Received: by 2002:a05:6512:1092:b0:533:4689:973c with SMTP id 2adb3069b0e04-536ac2e5127mr4824141e87.23.1727036138691;
        Sun, 22 Sep 2024 13:15:38 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-536870a89d7sm3083383e87.239.2024.09.22.13.15.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Sep 2024 13:15:37 -0700 (PDT)
Date: Sun, 22 Sep 2024 23:15:35 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Stefan Agner <stefan@agner.ch>, Alison Wang <alison.wang@nxp.com>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Matthias Schiffer <matthias.schiffer@tq-group.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND 1/2] drm: fsl-dcu: Use dev_err_probe
Message-ID: <42xybemeaf7ob7a57tbeqjmuhriu7f3eplopkozhizim6ldbm4@japyd7wvmsal>
References: <20240904115135.1843274-1-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904115135.1843274-1-alexander.stein@ew.tq-group.com>

On Wed, Sep 04, 2024 at 01:51:34PM GMT, Alexander Stein wrote:
> fsl_dcu_drm_modeset_init can return -EPROBE_DEFER, so use dev_err_probe
> to remove an invalid error message and add it to deferral description.
> 
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> ---
>  drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> 
-- 
With best wishes
Dmitry


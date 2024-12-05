Return-Path: <linux-kernel+bounces-433932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C338F9E5EEF
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 20:37:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4567516D7CF
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 19:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FB0A22D4E3;
	Thu,  5 Dec 2024 19:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KMTTDvZr"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A1422D4C2
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 19:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733427441; cv=none; b=G9GX9M2aBQePMqn8zv/ucJlQiDH2m1xA8cIBvNKycyBUhMsh3qiD48latN2fNky6TEUgi4varkjL8kk0eOx/ewBpK8IAiEl1HAQDSmnCa0piJEzD2V882Nu2dIBOo17g6fu10RXeOX7Hv/L4Bju19HDKTRXwm5e8f7fFyBwO8f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733427441; c=relaxed/simple;
	bh=/8mWs+LsHg5t40Hdzas9ylAMup4YyUOMJMRhO6YgBdE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZePjGf4zE+ak6xugGt7oJyxf9PAuAnXpuNuGqYNhjhiQmj6CPJ/ECNhfSQJkh/fKZW5fIz3LVcSbol+nIjnf0bD5lfyfocScDOh7RnkvpPQRnUc9Y0KIVpPAyloN3l6+pbWtXIMG6K4wS6C6mpD+crAl1MZ/q8io5eJy38RReqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KMTTDvZr; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-53e274f149fso1301833e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 11:37:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733427437; x=1734032237; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FU/EUHsit16rikYcJKnQECWispe+WbkZdRTRsFjxo4M=;
        b=KMTTDvZrpFOooCDsMKtgClP9reBquFs7ZsGeBa5HmgrsW+fGz9NHdJ2bWHcwFwnhwy
         UEb9uuxETSzMOvv1sOUI+IUvFQLcCfdFJyD/TeaZsUV6+1xa5a+KIS56Aocdnf9rWn8q
         RVs7SrzdY7aHj2Ufm5a6REFtLd7xyBlKSS1broLRnzz301okYzYyYO8Aw5YZos4fMJJw
         ppNfzXN5GkOPpq4QkrRzn5OLclCh6zYy5mBoTlaIq9xQCwtrozK5gmbeOgRlEGTRVGeD
         FpiU5lu+zk4q5KmvQ5uEkOGTyshYaDLA1Cx0qZVdAYiN2lc1AZrdfqxHJJOuG4KaDmwP
         7yog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733427437; x=1734032237;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FU/EUHsit16rikYcJKnQECWispe+WbkZdRTRsFjxo4M=;
        b=JJFUsnvIAbAs/hCEj0Dht1WbCEnxn+5ypqy1sSOjXKKxK2sOeAj3L5lZ7lus5o1KN2
         rR0z0R+Nhg54YxQ0S5cOd/xW8Wch8R1ytCu6ThKOR2pO+/53AoHJUpv4aLQLJeSYEv47
         rKjSY9pBkF/MgN7LonDCxLH9YD2mkDa/i0Ei4Ty/CHqxQ/MmDQaWcOpiba0n4vEwvPAS
         Zntt+moz3KdhSN3cByWOXpuWJcRgWmQlaWUluLpoP7y9ZGiYznYVTrz/M/p2XtIdpZhb
         7QPeQJ9AD9hxVgiD6mt43JurLewGOXDCDYAmBKZS2B+/BLqHil2UK9nT9OPGGJZNcDtU
         IpMQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgO2B6N1IrVSC+HdDqWGIj4R+tnijUb/6eRY0yMf55mEB0zt/HGS02G5W3Ps4Qg8Bn4F5eevLUTzsMeWc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmkrYlva5xBiE0Un4aWXFhiclKRnDOIkd2SeMaKeDTinCQkQl3
	qPLFaIIwet7oo31YAZrJBP+IKouPtEMYJLCcrqXP3yc/KDGOZSgKuoPpMnIK9gk=
X-Gm-Gg: ASbGncu6QJK45Ht2N54eNI3WR8sB6OIr3ehKtoxGSSr5Y8nYmtu4mp06Nm6U0cMPk0e
	9vXXcOu4U9Sfp5b9u5TAHJB3cg6upYJdiPVBOWI/7ElQ3na+XkXuLwrr5s4rxFPnQ2X7okIBUXk
	h4i9rn3ipABDngi1GL4sRDDJCbGtx6OGJw9E2glh52nl/uf6S0OS9SzNWeQdoMGfhB/Nh1ltJGA
	wkg4ATnVvKun6xQr+HulHhBPjfH2j8pXTsJplkP3cgSrAFa+cIJx4AzgGXqiIkholpvmYj6kiNF
	+aojikVWPGjGFDP76YdtcsxLSdw2QQ==
X-Google-Smtp-Source: AGHT+IERXOKhrQS1SGs1D5VgGlJZNknfg8nNxxBg0Nz/3rd8qLiDCnCB7kUCHN8FpkTx1vIxjtpeoA==
X-Received: by 2002:a05:6512:3083:b0:53d:e324:11c9 with SMTP id 2adb3069b0e04-53e2c504b81mr84578e87.54.1733427436612;
        Thu, 05 Dec 2024 11:37:16 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53e229ba760sm320223e87.155.2024.12.05.11.37.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 11:37:15 -0800 (PST)
Date: Thu, 5 Dec 2024 21:37:12 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Liu Ying <victor.liu@nxp.com>
Cc: tomm.merciai@gmail.com, linux-renesas-soc@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, biju.das.jz@bp.renesas.com, 
	Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm/bridge: ite-it6263: Support VESA-24 input format
Message-ID: <lpkbkayu5hlwhbzxhez47gob5zed27z7ced7vkadqfmxneh54w@6zwd3xvskooc>
References: <20241205080210.1285385-1-tommaso.merciai.xr@bp.renesas.com>
 <3bab95ae-ba66-4aed-9cce-13498f2f50e6@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3bab95ae-ba66-4aed-9cce-13498f2f50e6@nxp.com>

On Thu, Dec 05, 2024 at 04:54:09PM +0800, Liu Ying wrote:
> On 12/05/2024, tomm.merciai@gmail.com wrote:
> > From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> > 
> > Introduce it6263_is_input_bus_fmt_valid() and refactor the
> > it6263_bridge_atomic_get_input_bus_fmts() function to support VESA-24
> > format by selecting the LVDS input format based on the LVDS data mapping
> > and thereby support both JEIDA-24 and VESA-24 input formats.
> > 
> > Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> > ---
> > Changes since v1:
> >  - Inline it6263_is_input_bus_fmt_valid() as suggested by LYing
> >  - Fixed it6263_is_input_bus_fmt_valid() param from u32 to int as suggested by LYing
> >  - Fixed commit msg as suggested by LYing
> >  - Fixed commit body as suggested by LYing
> >  - Collected DBaryshkov tag
> > 
> >  drivers/gpu/drm/bridge/ite-it6263.c | 25 ++++++++++++++++++++++---
> >  1 file changed, 22 insertions(+), 3 deletions(-)
> 
> Reviewed-by: Liu Ying <victor.liu@nxp.com>
> 
> Since I have no drm-misc push right, Neil, Robert, Laurent or
> Dmitry, can you help push this?  Ofc, no rush. It's fine to wait
> for a period of time for potential comments.

I'll wait for a few days and apply the patch if nobody else beats me on
it.

-- 
With best wishes
Dmitry


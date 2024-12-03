Return-Path: <linux-kernel+bounces-429726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D66479E24AA
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 16:51:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9696AB42D10
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 15:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 807001F76AD;
	Tue,  3 Dec 2024 15:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NrE3L91t"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D7C1F75B1
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 15:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733238556; cv=none; b=aJX3ABz7q0IW6SUBIbfv+oYWajhMn6YsGWiDN2USq5sJz8rTuQ+mtEkRnwy0RvqjToEroaFWqfwthjzwzNkGauohuiSId+oB0AF7oiiyQnZQjTNrdAWaSN7UymIobla2ndMMe8ke/lbAbtTmKb5EEksmkoyv9P09co7CKp1726s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733238556; c=relaxed/simple;
	bh=hClaAh2hG+fl4q8Wxap5/MCIGXH/gdtXL08wBlBbQhk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qXkftEjvX+OuH+relCjWEW8i8BgiiFXIDrGmFO6z5zv4NgCNI9m+qA2BiLAY/c4Z2AhsTdmDW5JpfRQit9bIfx2K+DXJk940+7Ny76nJOblzEBiap0Z0Xw112JBkJGZ+ueCKBjNQQMvLWIkXiDjBTnP/GUSqF1K3mK0A2PH8anU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NrE3L91t; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-53df119675dso6889527e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 07:09:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733238553; x=1733843353; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=W8QM3peqYBpltbi1DIHb+zoz79Kj1Hf/KKrtdC4QJc4=;
        b=NrE3L91t8V8conzf5PkSEnRNofaruFQ8NmqocNBolhmf1uWETKwiBoQ63rt2AxQuIe
         SRON2M5jhoZiGqFdDwIUBShrk2NeXLGUH0GFp2GPtb9i9HZ/ou3gk78eyr7bPeHSdBvX
         hE1T9AgbewN3aDNOP2XZltpfJuBxuFZCVQfGGvXXAGmOP6t5Ozxb0BDnVseds09eDChB
         NraIX7TvDZnDawgrQsza1eTvnA5uhkFWEecZbh4oWvOct57i+sNAr6ozLcuwOJAKtvqr
         IUxBcKsbkOz2bGjObpz1jV4s2nQ6gilGIezTn07hjfWA8YBaHqp9IpffBZs1ivSt1NfX
         6g4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733238553; x=1733843353;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W8QM3peqYBpltbi1DIHb+zoz79Kj1Hf/KKrtdC4QJc4=;
        b=BV3Kjy3V6mWKaiBj1/iQR5Nfbs1tYgDtUHHtDeo4iZH1LvD7DOTOFg2MrRsOQHSJtp
         BlObD1khAGbyWDRa47qic61Nt6I18kbFKTfn7tYZ9T4abdFzN2QXO14Bkwl2O7UlRwNv
         gIBoEzET8/c+BdMb6i6sOGZTW9K1v2vVNOFCTO/lB10J40fmA3s8CD1QcptXYVpj9WRG
         P04Gp6S33kri4PNSr0+mA1qXlUzvKLNCOtl6PIO/7+MxNne7JiUUyFeBdglRl5EBWFCL
         dHq5ENxJLxJSCUHIhs1fWrgFuo/nX6YwQx8FDC6x5NS6gCplP6jKmsuqcufyQkgOr5mY
         fdFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUO6qYJrM+fj7mhUZ7hjGcaA03dRa9tUhSmsjVEEvuIAzBIWJqtA4CgPKX4xZauVmvFQ2Avth5eKA6TP2k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmVCpkmsfBJ4VDSCN729Z0Ui+vvPq347CrayRu6hAvbqlo2o0u
	7wa/uLX/TgKESnS+b5ovh1hbZyzVm7aUfJ0ql7U/HyNfcKT0dbzJVLthni1gDrw=
X-Gm-Gg: ASbGncu9tNzD7dObSqmPE4M4dEZ6XZoKuZz4Kjd56yhUiwqZaL87ZDZH5/5M8g/MrBf
	hmDAF/25633uBzuNbiebyJ+0Wyb6jeHiB9PY2Lqf9GK5PY53U3URZPV1ez4MxyNCgSYph76qCHU
	/EP2CiTcMDshYNeZftUvzv4KxK+a4bAP76nUuiQdsvUQbZCAT/H4SgkApSWyj7rnO5aF2CRcE1U
	amdzC8UDsuu9n7P39cjxeWSdYs5Pj/s8+L/6zaGP1aXDHXYXKjEtnO7eIPCO3Dn0e+ahYHlmYYi
	PoruNPB3fuQD8gYFPKxCz+IWidE4/Q==
X-Google-Smtp-Source: AGHT+IEjlfUflJI02ZJGU+Y+a8G3HUQsKv6NYL+aTiOcebMKzBeRoE8K/ZaRgeCLnat3VtUDppoaYQ==
X-Received: by 2002:a05:6512:31ca:b0:53e:1b79:ada3 with SMTP id 2adb3069b0e04-53e1b79aea5mr687508e87.6.1733238551539;
        Tue, 03 Dec 2024 07:09:11 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53df646f08csm1852548e87.164.2024.12.03.07.09.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 07:09:10 -0800 (PST)
Date: Tue, 3 Dec 2024 17:09:08 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Stephen Boyd <swboyd@chromium.org>, 
	Kuogee Hsieh <quic_khsieh@quicinc.com>, linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Jessica Zhang <quic_jesszhan@quicinc.com>
Subject: Re: [PATCH 2/3] drm/msm/dp: do not touch the MMSS_DP_INTF_CONFIG for
 tpg
Message-ID: <fieuuhtisu6ztpuzks32rvnjdfnusywmmcyj2oz7rg36ablo6l@thq5p2xha6jx>
References: <20241202-tpg-v1-0-0fd6b518b914@quicinc.com>
 <20241202-tpg-v1-2-0fd6b518b914@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241202-tpg-v1-2-0fd6b518b914@quicinc.com>

On Mon, Dec 02, 2024 at 12:41:59PM -0800, Abhinav Kumar wrote:
> MMSS_DP_INTF_CONFIG has already been setup by the main datapath
> for DP to account for widebus to be used/unused etc.
> 
> In current implementation, TPG only switches the DP controller
> to use the main datapath stream OR use the test pattern but expects
> the rest of the controller to be already setup.
> 
> Keeping the same behavior intact, drop the clearing of MMSS_DP_INTF_CONFIG
> from the msm_dp_catalog_panel_tpg_enable() API.
> 
> Fixes: 757a2f36ab09 ("drm/msm/dp: enable widebus feature for display port")
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_catalog.c | 1 -
>  1 file changed, 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry


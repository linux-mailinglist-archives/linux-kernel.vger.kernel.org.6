Return-Path: <linux-kernel+bounces-298512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8956695C840
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 10:40:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27ADBB24C47
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 08:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40C58149007;
	Fri, 23 Aug 2024 08:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J9+gWLXg"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A96147C7D
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 08:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724402431; cv=none; b=V2cWNZuQ/jhi1pXzV+zYicHu6DQU9JBy84nMS0gj6UxVaIh3rAgJ/EKaRUAYisd0OLgR5V6cTW0sMQUK+STAo0UI+6y0cHIQlo0Qk+gQy2a0WYHpt0zq/qokY3hNabaRGAjaAabm7MWTEg7pLTz2J+1RunqnqsDBO+OB4jf9ICw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724402431; c=relaxed/simple;
	bh=4MFsLweXpcj4nF6A04h1Qu5QFvXdA/Hqoh0p9msZQiI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E7lF5yr2EX8aXqrpfT3HOx2pv8TZzTZgn4QVygo6lmYqGmy8bmjY3YH7lfXaFJSSyWzPUH3sEeDLWx/0z+QNevilPr7GPkyr3r8ZHW7DRMZjP4mUB+jOv4uatabgSPuAfrzhf42pEBzJPBvuLkb+IzDf59DIwwAjyVo6G4eo1+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=J9+gWLXg; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a7aa086b077so199841066b.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 01:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724402428; x=1725007228; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=U1pa7E49sl/YII5qs1pBYw/u3WGyDMldXse0AluXJUc=;
        b=J9+gWLXgMnzYAz5ymBGI+Kqc0eLViHoVWfpxHohvUkW3MYFzxOQUwSKkNA6uc6KFbG
         MNYAUXMbdJMCHt5/a56vazlJCK86dTMbSzJwS+CWCd1dHTXgp/Ba+WJBaU4Fur3y6A1F
         EpiJY821E49fP+UOast8WLX6tPaaMySwTtqfpqRah3G0fuhtRmK2z+X19MQfrpEcZeh3
         VTtOEbpp2hwzyyKqvwOLWx1C1g3CN7V/6DYTYiiATnoFlCrRbQc/+qEUENC63WTlBFcX
         37QmgY+WFeoqelctqCknl8MdAVJx78CkOXqvIk7GnKROEzRDjEK0934Z8i4++t8dAEw5
         XkPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724402428; x=1725007228;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U1pa7E49sl/YII5qs1pBYw/u3WGyDMldXse0AluXJUc=;
        b=ncyYCzTiSsEwjGXulr6PzaLyIzaArDI0ifARJiKTjntSgODsZ/7b0+3CDtdN6/StrU
         GaKQaTrVFavJwvSCxOAKiVwDVy9Bv0MTi16LrEoFTPkxRLfayYfPNsXQBnpz6D0HT02s
         RPd3pIL2dz5bWUH5TZC8OE8TEAp7SMBv3ADdCqMeQ2lHCAAgwV2iELtxKheKQuXWmLSh
         aHCZqJAfUYcXxlCdNBQ02/S3sjHUvweko0EI0atQj330ZCgytC8WYdZ8f0cqx/khszf+
         xAOBZUHWiPL+C2Jf2PLBQHLI+cJ1VNukkGchBiFV1SjIv1VTUlVG+OXJ0aCH6/NbdlEI
         45xw==
X-Forwarded-Encrypted: i=1; AJvYcCV/y352bKh/MgLWPujGFsWSiV2h734sB64DNSlxy6uJSS8emcv4IXBPPQdNo7H5wchxW/U7XcmycXeYJ24=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCpwQEcMofmlnmoQINoJyvHzwWKLyEQEd5Tf9wgKz0mTeVWJ0/
	sWxTNhblJAWtEqnTLA/hZ6m5L2BYjb9CxkzUNU3l1rkIknRdAIlQ9TUuzkEXz4I=
X-Google-Smtp-Source: AGHT+IEU3rH8SLxwgdg/b9g1i8nA4dWuV71n2Fukh8RIHu5yiqMPwi1HVt1y+bWUu3W19Xi8e5L9SA==
X-Received: by 2002:a17:907:c7c3:b0:a86:843e:b3e3 with SMTP id a640c23a62f3a-a86a52eb624mr104449866b.33.1724402427990;
        Fri, 23 Aug 2024 01:40:27 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f507facsm228074366b.225.2024.08.23.01.40.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 01:40:27 -0700 (PDT)
Date: Fri, 23 Aug 2024 11:40:23 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Gabriel Maciel Raad <ffunctor@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	~lkcamp/patches@lists.sr.ht
Subject: Re: [PATCH v2 1/2] Staging: rtl8192e: Fix parenthesis alignment
Message-ID: <5b063faf-f882-4f3c-bd11-9695d1ba9917@stanley.mountain>
References: <20240823000838.8207-1-ffunctor@gmail.com>
 <20240823000838.8207-2-ffunctor@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240823000838.8207-2-ffunctor@gmail.com>

On Thu, Aug 22, 2024 at 09:08:37PM -0300, Gabriel Maciel Raad wrote:
> Fix parenthesis alingment in rtl92e_leisure_ps_enter to silence the
> following checkpatch.pl warning:
> 
> CHECK: Alignment should match open parenthesis
> 
> Signed-off-by: Gabriel Maciel Raad <ffunctor@gmail.com>
> ---
> Changes in v2:
> - Split the changes in two patches
> ---
>  drivers/staging/rtl8192e/rtl8192e/rtl_ps.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_ps.c b/drivers/staging/rtl8192e/rtl8192e/rtl_ps.c
> index 5aac9110bff6..1f881c27d4b4 100644
> --- a/drivers/staging/rtl8192e/rtl8192e/rtl_ps.c
> +++ b/drivers/staging/rtl8192e/rtl8192e/rtl_ps.c
> @@ -204,7 +204,7 @@ void rtl92e_leisure_ps_enter(struct net_device *dev)
>  					&priv->rtllib->pwr_save_ctrl;
>  
>  	if (!((priv->rtllib->iw_mode == IW_MODE_INFRA) &&
> -	    (priv->rtllib->link_state == MAC80211_LINKED)))
> +	      (priv->rtllib->link_state == MAC80211_LINKED)))
>  		return;

It would be nicer to write this as:

        if (priv->rtllib->iw_mode != IW_MODE_INFRA ||
            priv->rtllib->link_state != MAC80211_LINKED)
                return;
regards,
dan carpenter



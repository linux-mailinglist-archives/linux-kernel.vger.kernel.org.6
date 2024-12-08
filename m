Return-Path: <linux-kernel+bounces-436333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B796F9E8488
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 11:27:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FA181884AAF
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 10:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 711B913D291;
	Sun,  8 Dec 2024 10:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zlmkNBUh"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6F1130499
	for <linux-kernel@vger.kernel.org>; Sun,  8 Dec 2024 10:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733653644; cv=none; b=iGQfHSOQokTornG4fs2qBLkXTacq4W2pWNo/+2ZBKySG3l/f5I96m+vU+L8vOX7D063OjfX1QEOc24v61V8Obvscv0LOvENoCwtOWblDWXzaGuBrPrP/W8GibtuvjxgyMT8UUEtbnLAcaPR5tc7H+HSZZfDSFWw8EXJKSWcpOus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733653644; c=relaxed/simple;
	bh=43QPSXP07EKZyV7T4JoNOYWykPBWTjQq3mvEzDAEXME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VOsX1q3lLSwLx8pfdKEQhGdthgr5y0vjvYUYIGYdBRgEe2oBmpLe/EOSaOoCsFtgwSkp8yeWd/ilgbza6Miz3hUG+Nb1OSIhUB+UFLI7dE914GENxEqNXKzFGSY959aabt6t86lLKUaGawkp7hQm2npcQ7Rh9dukhe4dBhmLEAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zlmkNBUh; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3862d16b4f5so1135537f8f.0
        for <linux-kernel@vger.kernel.org>; Sun, 08 Dec 2024 02:27:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733653640; x=1734258440; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+XgVysOF3i6TtaEuaqKhK4jZgdb33XhdYEvJd6wftbw=;
        b=zlmkNBUh+1gJujuEZp1/i3MmeK+loOIZ3NcvLAsTZjUJWrXFlTNjMNyGJh9V+tUCza
         dSxiGEpu1ZY4Oqgz0aMV3mdg8QCwkL5r0qc9I/QMxYnyXRGNx3ggtjVeJWKVkSCCje3z
         s3M/D6VhXHWMrc7z7eC1bYnTEToQ+Ws1k2w7eXoMbDwmpc1CalgqjcraU+NAXZllU9KA
         2lUjPq0zBS5QltoShsawgdPOExJo/gAbaGcMkuP7UoMD/bYa6qCoJcQyqVQ6WXkoKyjR
         ZowbkVqtxbPtAOsOVnSpsn3QpV7IOHXgmKJBVM74cURhaVezYC/oM6GzN7QT/0zQEhLk
         Fz1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733653640; x=1734258440;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+XgVysOF3i6TtaEuaqKhK4jZgdb33XhdYEvJd6wftbw=;
        b=E53UXver3b31jNUY/YQqxzUg+K4IEQmXugTk9D1bJDU3+shl+woxhfj8sPMrbn83rl
         tJ8YWYeQdotdNnn1xcJTnKRbEZIMhCrZl4ywxlW7ro/tEzyjTXuNQrxheS2HmTuw/5iH
         feE4BaAuykn2H25+XCACY2xNq44z4gnA2M+W1tDxhj93tdwXL978wAWkh5T6ZC+lsmc6
         E3sapcwOf4pFHgMw8xpFra+mlhawgXpAW4wmPGLhf9+qnaUONqu82jBfgF7DluijrpIM
         sbkMSMd9Oa9kmoEwsZs84hoXAztFkz7A98zlBn+gjcX+UVEoP7z2kdNoNlWk27++KBOF
         QeZg==
X-Forwarded-Encrypted: i=1; AJvYcCX/veDyATJN0IGwQ5Yf1pjh8tcBVRGF4PyMsbujP2EhsHvbgnQyRPINWYBUtCoZm3JIPHxoD8hGzgK25JE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8HqZBcxfzw9aYPHxVD/OXtX/hevVVlQIbd/Dum8aHHzuBPelO
	fdR/xztcBjltrTMXB+xpd619Ympx9sudzYmgC/9iuKAsZvOV8MJHExQ+4hSwSOo=
X-Gm-Gg: ASbGncsS02sp7YwmcNrdXkWXLWJMNd5sCqfFjn1CCrUZD/r32M8SmkTlICVsp3hA7/E
	ycWPbxQ/7WgnmtZHnJhvNAaMi1Q3ItPi0eWCVVdNeN2p6PzzQFP7VxOTjNsjl8YiLQAc+JgdBhX
	+iWZrIElcSFjbI5iNf03MowxNie4IYzID5bnGRQAnI8VMAJWdD0Rrzmu8nnlkUtyxxCV70JbmBs
	SU/P2MXOVe5Ptt4vV6uqARDlNk6oYrGJnwFnsakxOmka4IOeV1jgOY=
X-Google-Smtp-Source: AGHT+IFafUqTyHZB+bp4EdtMwhm1qHbOJFTadaDBmWtEiOKgUBIvCZ9iEuyTTNGVjtAv3wTQGjtJTg==
X-Received: by 2002:a05:6000:1ac9:b0:385:fa30:4f87 with SMTP id ffacd0b85a97d-3862a4ad280mr7117003f8f.0.1733653639844;
        Sun, 08 Dec 2024 02:27:19 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3861ecf4164sm9794923f8f.9.2024.12.08.02.27.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Dec 2024 02:27:19 -0800 (PST)
Date: Sun, 8 Dec 2024 13:27:15 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
Cc: gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com,
	~lkcamp/patches@lists.sr.ht, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] staging: rtl8723bs: remove code depending on cflag
Message-ID: <42d24db0-b403-4c4b-8607-38f3cd55cf63@stanley.mountain>
References: <20241206230110.11893-1-rodrigo.gobbi.7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241206230110.11893-1-rodrigo.gobbi.7@gmail.com>

On Fri, Dec 06, 2024 at 07:53:15PM -0300, Rodrigo Gobbi wrote:
> Remove code that is depending on DBG_RX_SIGNAL_DISPLAY_RAW_DATA cflag
> since it's not compiling and there is no reference for it's usage;
> 
> Signed-off-by: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
> ---
> The previous version suggested to fix the tiny error over the cflag usage.
> Greg pointed at [1] that is not common to build using cflags. Since there
> is no reference about this debug usage flag, I'm removing all the code depending on it.
> Tks and regards.
> 
> [1] https://lore.kernel.org/lkml/20241125225308.8702-1-rodrigo.gobbi.7@gmail.com/t/#med5299468bc43fa89d18892d6d869a93d6138475
> ---
> Changelog
> v3: remove code as suggested;
> v2: https://lore.kernel.org/lkml/20241125225308.8702-1-rodrigo.gobbi.7@gmail.com/t/#mf22f30a9c689bd793988d7e7a58c0b119206116c
> v1: https://lore.kernel.org/linux-staging/2024112500-authentic-primarily-b5da@gregkh/T/#mea4fba3775a1015f345dfe322854c55db0cddf43
> ---
>  drivers/staging/rtl8723bs/core/rtw_mlme_ext.c |  1 -
>  drivers/staging/rtl8723bs/hal/hal_com.c       | 55 -------------------
>  .../staging/rtl8723bs/hal/rtl8723b_rxdesc.c   |  4 --
>  drivers/staging/rtl8723bs/include/hal_com.h   |  5 --
>  drivers/staging/rtl8723bs/include/rtw_recv.h  | 18 ------
>  5 files changed, 83 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
> index 317f3db19397..952ce6dd5af9 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
> @@ -4959,7 +4959,6 @@ void _linked_info_dump(struct adapter *padapter)
>  					rtw_hal_get_def_var(padapter, HW_DEF_RA_INFO_DUMP, &i);
>  			}
>  		}
> -		rtw_hal_set_def_var(padapter, HAL_DEF_DBG_RX_INFO_DUMP, NULL);

When I'm reading this commit I think, "How is this related to removing the
ifdef?"  The commit message should answer any kind of reasonable questions
a review is probably going to ask but it doesn't give any information on
this.  I figured it out by reviewing the code, but I shouldn't *have* to.
It should be in the commit message.

This commit would easier to review if it were broken up in a different
way.

[patch 1] just delete DBG_RX_SIGNAL_DISPLAY_RAW_DATA ifdefed code
[patch 2] delete HAL_DEF_DBG_RX_INFO_DUMP and related code
[patch 3] delete SetHalDefVar() and all the callers

>  	}
>  }
>  
> diff --git a/drivers/staging/rtl8723bs/hal/hal_com.c b/drivers/staging/rtl8723bs/hal/hal_com.c
> index 95fb38283c58..b41ec89932af 100644
> --- a/drivers/staging/rtl8723bs/hal/hal_com.c
> +++ b/drivers/staging/rtl8723bs/hal/hal_com.c
> @@ -682,14 +682,6 @@ u8 SetHalDefVar(
>  	u8 bResult = _SUCCESS;
>  
>  	switch (variable) {
> -	case HAL_DEF_DBG_RX_INFO_DUMP:
> -
> -		if (odm->bLinked) {
> -			#ifdef DBG_RX_SIGNAL_DISPLAY_RAW_DATA
> -			rtw_dump_raw_rssi_info(adapter);
> -			#endif
> -		}
> -		break;

So just leave this like:

	case HAL_DEF_DBG_RX_INFO_DUMP:
		break;

Otherwise I have to wonder, are there any other callers which pass
HAL_DEF_DBG_RX_INFO_DUMP?  Because if there are, then now they go
to the default case and that triggers a bug.

patch 2 would delete all HAL_DEF_DBG_RX_INFO_DUMP related code.
That is an easy patch to review.  There are probably other unused
values in the enum.

patch 3 would delete SetHalDefVar() and all related code.  Again
pretty easy to review because any missed callers would trigger a
build error.

regards,
dan carpenter



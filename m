Return-Path: <linux-kernel+bounces-441020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D83E9EC825
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 10:01:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75C8F1886428
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 09:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC0A5216E14;
	Wed, 11 Dec 2024 09:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nlD/PJmy"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45240215710
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 09:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733907655; cv=none; b=fEe/uZZdRc/8z4BRqa20dWYFXode1Y6mC9cWrAAgdrIbROsMPa+26uskXtt648CVXZ4JiDlR/+mutZh/dc/306/a5QwDNqloQNmWfF054i/zG+2Okhz+Ew/Hmw+w02p9Ckx7Y278tK0n6liT1T5WmwlKcR+0UNA9Q8LeU02GaaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733907655; c=relaxed/simple;
	bh=rOgeUWSp6bFTjRYXEmRP5Xg9oywmiCVNYTXOjviZUf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n4tyt6Va2iJNnMPqIbvLaw04JAfjLMAUCf3Ej8cTMSp/AYV9TABmFPdmzSusCZOqxD0Nbo5+wCBqEyIdv5BTIP0txZrgU5Q7kHCwgIInydEXLL6OmhAYxmulf4MK35yyagUMrmUfgiWroTJQAMDtzw7/RphqjoBkcT3xc1r04TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nlD/PJmy; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4361f65ca01so2257295e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 01:00:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733907651; x=1734512451; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ehgtAI9FILi9H1ERbtTxfeQX/RXwTuwJwbHxNT8tUfM=;
        b=nlD/PJmy/wMi4Evqi5ovj64VCsZg6jCpvhWGFft091WBv+5yMMBTp1Z6FAmi0SP0Ut
         BF7/9Y3agKYNuSMV9Cq4rhH07fncHWgtwexaHsqAdsAO8D64rebJGVC/VSY+W0N0TU5D
         dtuliPa7mH5tcg/H52iPiAbNbrbTnKvSbIasqpbAB/JmROrh8h7FSwriEQGHQJC2LVlo
         CB6V1Rcgd8BhrtYszn4rTpcpb4iilu2zuQCCKTUaX0KPMZ3mR3UF3/s083ySMsw3WXKm
         DKzydzTtABEWZVYbBjkMMp/HkP2lsKdOpepUMYHUQA+vTHVYQQ1hHRzRhcI6b259eT8S
         5hig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733907651; x=1734512451;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ehgtAI9FILi9H1ERbtTxfeQX/RXwTuwJwbHxNT8tUfM=;
        b=YBI0xXhpkka5x9Emvr5jf7rBYELha3yNhlwo/0/o3f+y/JA+fV0UohEli7uXSPE0tn
         qet4J+Xg+Vfm+JDWV4LRZ66rbcsYH8vsC/DTNuwZCCAtzHnYgvbk9oQEsTRAzIsqTMLm
         h8TDjJh8pWjxRIEWZmMgm1hOcoatuIQDk74b/Lq3rUtcK0lvocywLbJuDdcw37TyQJw2
         6tQd/jnGcLe+4YiJYKKrFHOgAZwyISSbrr/cW5Tmjvrd/zImM3ddydD0j0ENcNohFz8X
         1KjZlGiv+dg0u005T7K7LlbXwhHMOeYYq7ynEvyKHijEfeCobJurjr85momlNwFnweCM
         eqIA==
X-Forwarded-Encrypted: i=1; AJvYcCXCf4hosKSQtZUmFZRTBLyIj8IHIAJzj6Fz4DxRjisPRqnfBDQNodVTj2Vd5HK4lxVi7sMD1PlZNcnp90o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeTuG4PMuxjhT2yQbt56z6Bq/J3z1fUa+puJf3e1bFbQAsa1A/
	wSvJ2PXNgxZkahVgXrQb08njjirNRwaJgB10PJO0vV659J5xPGd3e89bkZJ52JQ=
X-Gm-Gg: ASbGncvCc1xyWdDejjuu8/vc3TRaF5F8dkeFSe9OcRNQTZObrLfrtUuvim0ZQ8K+4bV
	yLu1wzC+ilmeZPpT3vV+hUf/rIvw2Df0/PxOLQYYZagtHaGrPsysfQY30FhQCy//SbmuS0OrmtX
	PbhegQMsUZbWpVvZuG6DzTV5kq3NfdiHDSSLQVDmvkmAz7kd8xx9tZF05ioCCrRKhcCCqHr+Qve
	nEH9GYtJXF4QiUgwai1EhpcIa6+9xi0JD1jQmrudevaVdMABIEo2Vf8+j4=
X-Google-Smtp-Source: AGHT+IFrbT6yUxTVKlbXZAWJjA6u6YhH7qTzIBw1u2o+5qJHy+OJ03YHoWeo2ICrxH825yoy49qOMQ==
X-Received: by 2002:a05:6000:156d:b0:385:fa26:f0d9 with SMTP id ffacd0b85a97d-3864cdec006mr1484907f8f.0.1733907651524;
        Wed, 11 Dec 2024 01:00:51 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38782514f29sm805341f8f.77.2024.12.11.01.00.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 01:00:51 -0800 (PST)
Date: Wed, 11 Dec 2024 12:00:47 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
Cc: gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com,
	~lkcamp/patches@lists.sr.ht, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] staging: rtl8723bs: delete
 HAL_DEF_DBG_RX_INFO_DUMP enum
Message-ID: <6a5f8451-32cb-4784-b8c0-ca4a07df8764@stanley.mountain>
References: <20241210210741.17101-1-rodrigo.gobbi.7@gmail.com>
 <20241210210741.17101-3-rodrigo.gobbi.7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241210210741.17101-3-rodrigo.gobbi.7@gmail.com>

On Tue, Dec 10, 2024 at 05:48:19PM -0300, Rodrigo Gobbi wrote:
> After removing code isolated by DBG_RX_SIGNAL_DISPLAY_RAW_DATA cflag,
> HAL_DEF_DBG_RX_INFO_DUMP enum lost it's use.
> 
> Signed-off-by: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
> ---
>  drivers/staging/rtl8723bs/hal/hal_com.c      | 2 --
>  drivers/staging/rtl8723bs/include/hal_intf.h | 1 -
>  2 files changed, 3 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/hal/hal_com.c b/drivers/staging/rtl8723bs/hal/hal_com.c
> index 1803c0cd3a7e..b41ec89932af 100644
> --- a/drivers/staging/rtl8723bs/hal/hal_com.c
> +++ b/drivers/staging/rtl8723bs/hal/hal_com.c
> @@ -682,8 +682,6 @@ u8 SetHalDefVar(
>  	u8 bResult = _SUCCESS;
>  
>  	switch (variable) {
> -	case HAL_DEF_DBG_RX_INFO_DUMP:
> -		break;
>  	case HW_DEF_ODM_DBG_FLAG:
>  		ODM_CmnInfoUpdate(odm, ODM_CMNINFO_DBG_COMP, *((u64 *)value));
>  		break;
> diff --git a/drivers/staging/rtl8723bs/include/hal_intf.h b/drivers/staging/rtl8723bs/include/hal_intf.h
> index 282e141616b0..85de862823c2 100644
> --- a/drivers/staging/rtl8723bs/include/hal_intf.h
> +++ b/drivers/staging/rtl8723bs/include/hal_intf.h
> @@ -144,7 +144,6 @@ enum hal_def_variable {
>  	HAL_DEF_PCI_AMD_L1_SUPPORT,
>  	HAL_DEF_PCI_ASPM_OSC, /*  Support for ASPM OSC, added by Roger, 2013.03.27. */
>  	HAL_DEF_MACID_SLEEP, /*  Support for MACID sleep */
> -	HAL_DEF_DBG_RX_INFO_DUMP,

You have to combine patch 2 and 3 together otherwise it breaks the build.
The fact that any mistakes break the build is what makes this sort of patch
easy to review.

regards,
dan carpenter



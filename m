Return-Path: <linux-kernel+bounces-510640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B95A31FE3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 08:21:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29132167812
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 07:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F34E20458B;
	Wed, 12 Feb 2025 07:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a+XVS0uP"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27A62040A4
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 07:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739344906; cv=none; b=aNCiKafHiJyyu2NoSUkduFqaJWhPxfFbi0/c7UxDAgrS34EEcokCKZ+yWSz7O1sJY15DqPwgJcUr+9L0HZa5kafYM2uXNGmbYn3SaoJXm3NyZm17xNvMMlCMftjNhhUF2+1g5hR5dAt5y/IB02al+IBr25uJiEdzLGx6bDbuwO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739344906; c=relaxed/simple;
	bh=GX2Bo920yza7SAo4ieMuOLncMS2btUetGyMlP7Ii+n0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mRZqQjAX9U+JF5HgWA8FeBweFxNcIiR6NTavxvtROybclvif6J2zAi0DN05Ww3IxBKtTIT9etnoEfuMJvl+QDGMFDxFjefXfu7u7Fa9X+GTpGa9smRilBOR6RJfii1GDZ1PCK2RUA1HP59hEsOZHqwRQrz+ObuxKvhZ/Qmv6Fa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=a+XVS0uP; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5deb0ea1129so558464a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2025 23:21:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739344903; x=1739949703; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=I1XA/sda8QNaELrl3C+Fgi3gSSESl0xT3B7//5s8Fkw=;
        b=a+XVS0uPZ5JWILbPbG5OLe8fbOVqOprHvRZE3moAN7OuQnybFH2ZmkRumwJG2x40t+
         0OvkCPF3M3STereU/01vVEDMXhYn7wC+atxbbQxh6cLLBQk8N7YwVXXC0HXRwCLKXTcL
         thE/osVfk/j+uDwX2oLX41L3RvAbCLzOz5HytghP6CXBN/XLlyt5IeiZfp8pTty2jRA/
         MwxXrEcJpk1tdenp95fGpBKLhOut9OUyaZebm+MbSkyGkRmmeeeYaN/T+fFsBTRTDLai
         phlLfMrbqEzKJy6kFGAYDd1jZEWP+HAiCufekMo2HtPqoeCILrC9w7yY6fKhSURtmepV
         9/dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739344903; x=1739949703;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I1XA/sda8QNaELrl3C+Fgi3gSSESl0xT3B7//5s8Fkw=;
        b=q4OiG88DWk00XZ0fAjx3n5qJh4oEWHOkdQM6niL6gBb4iEPVw5SSZLNeMz5FutPXqG
         0Tc33j2b6oRLQK1O8IyMmyhCse7/+WgDJfPP7gs8bsTi0De66929UDxMPVvqPCp35HMJ
         WNcISn31rzQlaLbRs25IiI2pkZ/W1CZ5Olo76HgSNyZC05aWB4VcMIjkHk9CEIlpemuB
         85etgbiDX1rFIzgT1pA25zBRzeRjmP6aBk3DihLp77dzg1QHebwj3CpzEB54t3I8pGW4
         83DFXq35jM7jXGWeJz7MTCBIaXOY0lawE3DWygdg4INzoAh/+H2fxl4MQHoIyhvfVand
         15ug==
X-Forwarded-Encrypted: i=1; AJvYcCWQ8/AyF4YRKLjHPEumwp5jr36zA7mim5eFlq+S5tUO5CHrK/fa16U6dqNgFh6i1MM7XopIOKXyVTVDCI4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCOQNUH8cx6P+/K9tyhCt98ROvQMVa1pvcFPB3+JwE+zgb/sTi
	lfiFOJM2I9UaP1h/dU2MI33z4Nd8384VJRUHlNJlBO3qneoVbAjheKc+WPmV5lpqE6JbFKoAx/y
	E
X-Gm-Gg: ASbGnctFnI1ZQ+MBmtLVAWjGi+5qzKXgM9oCzC/SDWk88OqQf0HI5Ikztl3i35Wy/cR
	Coe8UnZZZKPrTFnNG8fLwKZ+BgaHNws2u4hZ+AhJhHFXJuAX3U3LIKfySvKKfvZ8kAe50VVaCey
	phNpd3c2rqwb3c3Co8g9vGlKOAwHnHcVrFdR1XpkCsipq3eIDh2RoMT6pm6mtf589/6/GySasGz
	WcBcEepLmWOLDXX+OwTRTwEEftAXv97JsF2CFrzGenHbN6vuNybUvlIO99YhkZ6EQawoDdTkdOs
	oFTT41grNULY0+4akyRc
X-Google-Smtp-Source: AGHT+IFbJH6iVjLwp8uJnuQIc1OwsoBuQCq0ElnDpSJ9Ye+j/v1LlJ0uv2hVXznwRiz6v7Cbww+2GA==
X-Received: by 2002:a05:6402:4024:b0:5d0:efaf:fb73 with SMTP id 4fb4d7f45d1cf-5deaddc10acmr1962398a12.15.1739344903041;
        Tue, 11 Feb 2025 23:21:43 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-5de4805a0b2sm9653626a12.48.2025.02.11.23.21.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 23:21:42 -0800 (PST)
Date: Wed, 12 Feb 2025 10:21:39 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Ian To <onlyian4981@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] staging: rtl8723bs: format comments
Message-ID: <1052fff0-b503-4b47-9897-fe7c26c14126@stanley.mountain>
References: <cover.1739001527.git.onlyian4981@gmail.com>
 <b58a9f5b579e17f70681f8419b54d7d9864d1730.1739001527.git.onlyian4981@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b58a9f5b579e17f70681f8419b54d7d9864d1730.1739001527.git.onlyian4981@gmail.com>

On Sat, Feb 08, 2025 at 12:15:54AM -0800, Ian To wrote:
> Some comments were not formatted correctly. Reported by checkpatch.
> 
> Signed-off-by: Ian To <onlyian4981@gmail.com>
> ---
>  drivers/staging/rtl8723bs/core/rtw_security.c | 102 +++++++++---------
>  1 file changed, 51 insertions(+), 51 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/core/rtw_security.c b/drivers/staging/rtl8723bs/core/rtw_security.c
> index 1e9eff01b1aa..3281751436fd 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_security.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_security.c
> @@ -30,10 +30,10 @@ const char *security_type_str(u8 value)
>  /* WEP related ===== */
>  
>  /*
> -	Need to consider the fragment  situation
> -*/
> + *	Need to consider the fragment  situation
> + */
>  void rtw_wep_encrypt(struct adapter *padapter, u8 *pxmitframe)
> -{																	/*  exclude ICV */
> +{								/*  exclude ICV */

What does this comment even mean?

> @@ -374,39 +374,38 @@ static void phase1(u16 *p1k, const u8 *tk, const u8 *ta, u32 iv32)
>  	/* size on the 80-bit block P1K[], using the 128-bit key TK[] */
>  	for (i = 0; i < PHASE1_LOOP_CNT; i++) {
>  		/* Each add operation here is mod 2**16 */
> -		p1k[0] += _S_(p1k[4] ^ TK16((i&1)+0));
> -		p1k[1] += _S_(p1k[0] ^ TK16((i&1)+2));
> -		p1k[2] += _S_(p1k[1] ^ TK16((i&1)+4));
> -		p1k[3] += _S_(p1k[2] ^ TK16((i&1)+6));
> -		p1k[4] += _S_(p1k[3] ^ TK16((i&1)+0));
> +		p1k[0] += _S_(p1k[4] ^ TK16((i & 1) + 0));
> +		p1k[1] += _S_(p1k[0] ^ TK16((i & 1) + 2));
> +		p1k[2] += _S_(p1k[1] ^ TK16((i & 1) + 4));
> +		p1k[3] += _S_(p1k[2] ^ TK16((i & 1) + 6));
> +		p1k[4] += _S_(p1k[3] ^ TK16((i & 1) + 0));

These aren't comments.

regards,
dan carpenter


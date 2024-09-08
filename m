Return-Path: <linux-kernel+bounces-320403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C6BE9709BB
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 22:33:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAA801F232DE
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 20:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6EEB17A59B;
	Sun,  8 Sep 2024 20:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jF5SBPN4"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF5C175D4C
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 20:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725827624; cv=none; b=GjOhkkamkXQW8NwsHR0Xb8Ga1pZ7YckiAXlNk2175O8/PHMm1Os3/9VRTJHJv2kpFF/apLQWANlcxNAHYFXLif8KJMngffXWC/XRJQaUobR6RT7hNeCoDlGrK5gv0LKN5xV72VJ8vTb3hwLo5j8rktpPai7VJ3vrMQ73vwPeusA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725827624; c=relaxed/simple;
	bh=xwD4m181/ghlyX16sIsZDzu4zhFafGG1cb7UM3VEeS0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=af/KkpHon7rgt+v//nQMxulCRh/EGesdoZOltjjs5hRLvdHbychkSJonQtV5eTICNu/75I5f52Mc+YA2Qq7dtF9e1Xy4cCGA2i4OSd8DB5GuPuJWdoP/PQ7nSoyLiiS9PdMwetsJWbmu3WFn4H07TFZ2VLzv3Qz/RMFeGTgImeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jF5SBPN4; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a8d29b7edc2so168276166b.1
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2024 13:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725827620; x=1726432420; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kF2uO3WLFmIzAKWxOZE3qObArcTQBZD6pgoNP5m+nYs=;
        b=jF5SBPN4OAZkx5G0x+i9zVc4TGC3xBoOBqIHLQRLMw4DYiZYu5Y+KW5HfMPOXd4mfQ
         nVuaMfIL+XzPkXn23c9U03PD8Z4PLnzXDUP81N7S7rkRyKpHBboXVUnUBAM6jl9znyHq
         9fW5k+Pg7O6q2wKE057cFpqSjXCBQ7k1JUzZHlUCf/YHobq5ppozIxBQSf/+lDxTwN9s
         dQenC+5HN1qCDyNSYF1gaPrF1JktpDbAXyFGSXyyzzTGoIwUc0eZLGv7wvsfdjHu7apA
         NNfytbpZO7sBwwtGVTBmtPgDkOqFxY9U3FwxQLRFVlnISw1f0RN2cVSjcj8iphlF0uvw
         HO/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725827620; x=1726432420;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kF2uO3WLFmIzAKWxOZE3qObArcTQBZD6pgoNP5m+nYs=;
        b=VKWs4LksqJ+kKoaXuEU46Yk7v3YKoarq/7qN7Sicy1bxmolo0LF51jAdc+9PUpJ/Ay
         ZA+WeLsup++1ijqc4GTQn/1bE5Us9Gmaa79u58ITrlsCfOigt/JSks67W4V/Emkgk7Ws
         t/+4n4Li6ObBGIPhTVVOWf/163R3OKKxy4J/whx4SNE3ewBzXaIcJvppu6UTbjZEPOTV
         /klyGfrqIBgks1pXYTM16xnJqtKLKFdkYqNWOw1LcPirQ0HMsM2QiWmTw/0gwy3mQfAb
         ngjq2zUJLZGPk+nVB5ekgzMysSJBKbtWGV897fv+HAAM1Hje2N0c4tjSOKyVqM2IfvPe
         bkIg==
X-Forwarded-Encrypted: i=1; AJvYcCXMIRtQ60+UFvD9bDS4k9JQ7qDSmi3twzbHPX/0PhCOEkCnh0mjBFV7jsOy2BNmR86i+QSSnZO/4p1qwCo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDRRTNdRaYWq8UMgaas5bgQRr3ugRl6q/NPt9RDYRyxAPIxpFQ
	sRanAMGwBnsdESFdHM7U3k1+C7ACKAqsiCjCBXE5FyY5Ga8NQkSC
X-Google-Smtp-Source: AGHT+IHkhLuRJsXaIsWySKb1wYWCss338DDk4msZoEw3vDmi8KE+93iuiZd4yfSMTfIOpsAjfe1ewQ==
X-Received: by 2002:a17:907:2daa:b0:a8d:489a:d23 with SMTP id a640c23a62f3a-a8d489a0f42mr361532566b.25.1725827620292;
        Sun, 08 Sep 2024 13:33:40 -0700 (PDT)
Received: from ?IPV6:2003:c7:8f2a:8576:4416:5fef:fc17:c89e? (p200300c78f2a857644165feffc17c89e.dip0.t-ipconnect.de. [2003:c7:8f2a:8576:4416:5fef:fc17:c89e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d2595117dsm246784566b.63.2024.09.08.13.33.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Sep 2024 13:33:40 -0700 (PDT)
Message-ID: <b335b3dc-61b4-4e39-8627-76bd4acc82c2@gmail.com>
Date: Sun, 8 Sep 2024 22:33:39 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] staging: rtl8723bs: fix position of opening braces
To: Sayyad Abid <sayyad.abid16@gmail.com>, linux-staging@lists.linux.dev
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
References: <20240908101110.1028931-1-sayyad.abid16@gmail.com>
 <20240908101110.1028931-3-sayyad.abid16@gmail.com>
Content-Language: en-US
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20240908101110.1028931-3-sayyad.abid16@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/8/24 12:11, Sayyad Abid wrote:
> This patch fixes the coding style issue of opening bracket "{" being on
> the next line.
> 
> Signed-off-by: Sayyad Abid <sayyad.abid16@gmail.com>
> 
> ---
>   drivers/staging/rtl8723bs/include/rtw_security.h | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/include/rtw_security.h b/drivers/staging/rtl8723bs/include/rtw_security.h
> index 487d69460cec..3ccbccf92417 100644
> --- a/drivers/staging/rtl8723bs/include/rtw_security.h
> +++ b/drivers/staging/rtl8723bs/include/rtw_security.h
> @@ -170,8 +170,7 @@ struct security_priv {
>   
>   #define GET_ENCRY_ALGO(psecuritypriv, psta, encry_algo, bmcst)\
>   do {\
> -	switch (psecuritypriv->dot11AuthAlgrthm)\
> -	{\
> +	switch (psecuritypriv->dot11AuthAlgrthm) {\
>   		case dot11AuthAlgrthm_Open:\
>   		case dot11AuthAlgrthm_Shared:\
>   		case dot11AuthAlgrthm_Auto:\
> @@ -191,8 +190,7 @@ do {\
>   
>   #define SET_ICE_IV_LEN(iv_len, icv_len, encrypt)\
>   do {\
> -	switch (encrypt)\
> -	{\
> +	switch (encrypt) {\
>   		case _WEP40_:\
>   		case _WEP104_:\
>   			iv_len = 4;\


Hi Sayyad,

I cannot apply this patch. Please rebase.

Thanks for your support.

Bye Philipp


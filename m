Return-Path: <linux-kernel+bounces-268513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B2989425A2
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 07:11:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B59761F24E0D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 05:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46CA54963C;
	Wed, 31 Jul 2024 05:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XgQiWxCf"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5AA81AAA5
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 05:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722402676; cv=none; b=UnEKv+hcubCBbxSju15od5v2tp/IdfIzWK6mptKf0hUr7drK7RpEOvzKivk8dOHzvWHHARpaOSaSPyCn+HVf2S+jYcYvJGVLjYh1vbnKGXt7wb9cJHbyue/7Yk/PLONiUTr6ncotetWmc+XWj0pIK0gLn5eenZ+NQ9Jt7zcPMMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722402676; c=relaxed/simple;
	bh=8arqm9uivniBVrkX3K1+hWxUe6R6dbHXmuySzxkS+Rg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Im5couC8LMT9bz9qfNOKn+zGlx1UQd20vZH5TgXEUarea7igwCaqXydxukQeXRrhu/x/ncnVRyO3HmHOvv+U7qlSFywB8WCPbYEKqVyHU4NDx6JQltp3H0CSPnb58n4QhT9u2VnaN7T6Tu4GYSoBo8PnnF53/+bzGkWQBAAqqSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XgQiWxCf; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5b1a0075074so447408a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 22:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722402672; x=1723007472; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JyyJ0zpn0TPgwRfHAQUoo9coDlF7OiJbaymCzyth/ys=;
        b=XgQiWxCfo2pPWCWMq0RCEkV66OvvUYqmutWd4zPVF8fSH+gPIoGE9dV4DzSOZhn4QZ
         Hev3/DqJEk8ox1rsA7Ibwq/OA5kaccV+OWTsLPQuoFFBtMiYJcO9+HOzMZvEiKxfYXSF
         9ONq6v3+8Ro8DWGh4BZbUh0KchfmUXCxbD69vVLHNEGzcYnYMqy6BoMpxLKpAfv9cZmt
         AGgJsyFSU09d2eWgRP6UD9fb+aonirNse0PJl1iHU4697hysOYUQyf5WNrKoUNRaepwJ
         SmQ77979xvt/KB6psZssawZ+3pIko266sVtFDYPVra6wsaPGL3o1CWiEr6Kc15UJS3wK
         q9gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722402672; x=1723007472;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JyyJ0zpn0TPgwRfHAQUoo9coDlF7OiJbaymCzyth/ys=;
        b=mUltPKhTSPRculAUs5XyEko7i+PofhK6jYMTuAVy35hok8trPdAClNdXfWg01M9Zvf
         IXOQ9x0PocDlUmYofBwkplIJ3G1BPJ2Z+/bPTCtOae4hYVMKoZQHQ2bjiUyrUGrFOkdg
         yu9IcwgnpW4x/SHJaXFgNmXrQP5PVRGw5ifCaHc1AiUoeibQvmXGA7Rgb3mTLYw87yQO
         AjFtQeKu7bmMXMwCbgS9gIBWih8IQjWmV3lT+f6ooZtOEv28p85jSJCgdqzGD1DpU4RP
         lswfxgIX/3qE5SmKTTEifOYspr2Fk4ecVS6XB8X6kA+NjVIiOPnYsCXG+kFLTAvMTjpj
         ElnA==
X-Forwarded-Encrypted: i=1; AJvYcCUUnS67erTBgLJqSaB0shtzchGxWJ8aHaimHGSlAOHdjAomxfU/ZGrpZaIbo3qHmXauBTryN+xQC77Snaz41xKmSH7YRBHYlUv70Vui
X-Gm-Message-State: AOJu0YyBtRPhkP8EpII8v+zLmtbj/NUviFbBSiE0/rkmdGGoR8pSGyiI
	aBNN4zUcW/FA0aer6qqBNPTrS3eih3dQwkVGSJaezUbibvjyMi2OzAF1bw==
X-Google-Smtp-Source: AGHT+IEdU3f68hnYxvpVWBsO5cx8sYbe2/mhX6gs+rL6BbXVHhuO1biabC7Qb8I3ZOJ1IlwYyM0OAQ==
X-Received: by 2002:a05:6402:34d5:b0:58b:e3b:c5de with SMTP id 4fb4d7f45d1cf-5ac2ce66a84mr8283061a12.4.1722402671821;
        Tue, 30 Jul 2024 22:11:11 -0700 (PDT)
Received: from [192.168.0.104] (p57ba2f9b.dip0.t-ipconnect.de. [87.186.47.155])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ac64eb7c0fsm8169852a12.62.2024.07.30.22.11.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jul 2024 22:11:11 -0700 (PDT)
Message-ID: <b53178f1-1b52-4fea-9edf-092e6961c96d@gmail.com>
Date: Wed, 31 Jul 2024 07:11:10 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] staging: rtl8192e: remove duplicate macros from rtllib.h
To: Michael Straube <straube.linux@gmail.com>, gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240730082928.62284-1-straube.linux@gmail.com>
Content-Language: en-US
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20240730082928.62284-1-straube.linux@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/30/24 10:29, Michael Straube wrote:
> These macros just duplicate macros from include/linux/ieee80211.h.
> We can safely remove them from rtllib.h.
> 
> Signed-off-by: Michael Straube <straube.linux@gmail.com>
> ---
> compile-tested only
> 
>   drivers/staging/rtl8192e/rtllib.h | 11 -----------
>   1 file changed, 11 deletions(-)
> 
> diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
> index 022851b7f1a9..e87313a30741 100644
> --- a/drivers/staging/rtl8192e/rtllib.h
> +++ b/drivers/staging/rtl8192e/rtllib.h
> @@ -414,17 +414,6 @@ enum _REG_PREAMBLE_MODE {
>   #define WLAN_GET_SEQ_FRAG(seq) ((seq) & RTLLIB_SCTL_FRAG)
>   #define WLAN_GET_SEQ_SEQ(seq)  (((seq) & RTLLIB_SCTL_SEQ) >> 4)
>   
> -/* Authentication algorithms */
> -#define WLAN_AUTH_OPEN 0
> -#define WLAN_AUTH_SHARED_KEY 1
> -#define WLAN_AUTH_LEAP 128
> -
> -#define WLAN_CAPABILITY_ESS (1<<0)
> -#define WLAN_CAPABILITY_IBSS (1<<1)
> -#define WLAN_CAPABILITY_PRIVACY (1<<4)
> -#define WLAN_CAPABILITY_SHORT_PREAMBLE (1<<5)
> -#define WLAN_CAPABILITY_SHORT_SLOT_TIME (1<<10)
> -
>   #define RTLLIB_STATMASK_SIGNAL (1<<0)
>   #define RTLLIB_STATMASK_RSSI (1<<1)
>   #define RTLLIB_STATMASK_NOISE (1<<2)


Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>


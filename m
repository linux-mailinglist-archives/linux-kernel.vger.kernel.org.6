Return-Path: <linux-kernel+bounces-300549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D475695E4FA
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 21:44:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A9851C21173
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 19:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 181CD156C63;
	Sun, 25 Aug 2024 19:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IGIkaKl8"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5D14A2C
	for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 19:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724615077; cv=none; b=C3sBTyfZNmKG9cF/flweQ9TN0ce613CV9WjsbGD5cOXWSwsAkyMQyRpkaaOfaJ9rBg227QOlZSFpcrvVmHJ5jPOu+NCdPaI7yC8LoYpvGZZ58c9oBkYNYaMBzK+ID1D711urp2ygbPIWVOUTeN+BZwlPvA6HZ1AR40F5zhT/YK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724615077; c=relaxed/simple;
	bh=3aSgmy2z4pausqZBDFYJruBHjeDB2tWoXHMVkZB36YY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=t+bPnbN0ILjohwPZKcHVSbHHP1aU1b/Dbk8s5jVNESCx3FvNTIwZS/a9IxcJ/sLem1hftvA2//NyIoOVptMrVuHlx3hhJMV/K0axwpuSeWY3YpCbEZkmCMnaSUfPExIAtraTxDPOJ+6qGUXY02Z8zh3qRitErQRXO94AwvsqTD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IGIkaKl8; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5becc379f3fso3954121a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 12:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724615074; x=1725219874; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YRw0/BmZA1JaNPxfbsuBNaktJ+Y30bFXZTx3rW6j/Es=;
        b=IGIkaKl8RRvyEe+CQygw/gCKF0leit7AS6qESstc9uGXmufP/95QHHFvMaQQJ0eaL7
         xhiMWujaRkWLuXSHKdVmVEhMLW/MbXI3Ba833UfxP+shvLoFjbzv0/BB2p7kPvFmtmg9
         nbeYE/oaoVDH5MgOwQQsvZraCGxVg1V3o/aXWhstPVKd6mLSBRds7yE27EIH6E0p+rXs
         luG1R+2nVnVG2Jjc2mwEAL0EOs3/5PxbVXo6W5bRBi+g2L64QsS658betF9oEHaqU6xP
         Ed9zaNevjjyQYia1RT5PAeLYhoq6rvoDk5vecC/eqWiksY7aGJZYK4RxTBWLBKEK+Zr9
         98MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724615074; x=1725219874;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YRw0/BmZA1JaNPxfbsuBNaktJ+Y30bFXZTx3rW6j/Es=;
        b=VtkCAO8RkS7F+A2+zCx/kj6iRPJ1rTbjv8Aj8ltevL2MDKP+YgTk+fvAV/A9jBqEUv
         4C4ApOMhaYqcp3xQq5eaJetgRae6kpnD0b1AiAoWxHAtpnNhAJwMyFHbrlxzgKFtXmZA
         jOuMAqBlpYWgtMjnHf8nyimXy6Hvlo75rLnzIb4QH8DDQhHd82aDOZis/Ex7klIpSfzf
         w3/RIDgVsB+NbjREisHLRKiezmt1+nVi6GY4Yciyw5sKtiWGw46tHYy2Bq6Qt61RLMsj
         lC4ecGKzivHSCEXGZYfIrJUzX12oXDz97CkQsi+UKWeZeZK+OgQ41aJXj4bewpV2+EBK
         sf5A==
X-Forwarded-Encrypted: i=1; AJvYcCXUleEoQwyUlKMHy3YAtxlqR/VsdIANNh16WQM2WZKVEUEkuPqjmuZjBaopVoXSF9CFlal+k3CfsgCvaFI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLYvJbJiesd9gSTIMe4KQWMUbSuC7J/PK8JXcrT+rYtmDg2YIF
	MAwqKFk/xb0O4nGuR23BphCfZhI3E30kHqGAhTYBncZObRLj9rhlIXto4w==
X-Google-Smtp-Source: AGHT+IHdZzIXvWAwVnqVi7nwuR8NFGLFih+D3hWUgh/Fk+yqokxyjBn8tVBsCU7Y1FDf8XecZ7SYZQ==
X-Received: by 2002:a05:6402:5187:b0:5a3:3cfd:26f7 with SMTP id 4fb4d7f45d1cf-5c0891abad5mr5926380a12.32.1724615073776;
        Sun, 25 Aug 2024 12:44:33 -0700 (PDT)
Received: from [192.168.0.104] (p57ba2f9b.dip0.t-ipconnect.de. [87.186.47.155])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c044ddc0dbsm4720390a12.20.2024.08.25.12.44.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Aug 2024 12:44:33 -0700 (PDT)
Message-ID: <f514b1db-154e-4450-88e9-cbfb8c66a69e@gmail.com>
Date: Sun, 25 Aug 2024 21:44:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] staging: rtl8192e: Fix Assignment operator '=' in
 rtl_wx.c:681
To: Alien Wesley <alienwesley51@gmail.com>, gregkh@linuxfoundation.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
 ~lkcamp/patches@lists.sr.ht
References: <20240825161335.21737-1-alienwesley51@gmail.com>
Content-Language: en-US
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20240825161335.21737-1-alienwesley51@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/25/24 18:13, Alien Wesley wrote:
> Separated assignments for pairwise_key_type and group_key_type
> in order to silence the following checkpatch warning.
> 
> CHECK: Assignment operator '=' should be on the previous line.
> 
> Signed-off-by: Alien Wesley <alienwesley51@gmail.com>
> ---
>   drivers/staging/rtl8192e/rtl8192e/rtl_wx.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c b/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
> index 47f1adf30ab4..2d42e7a5bcdb 100644
> --- a/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
> +++ b/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
> @@ -677,8 +677,8 @@ static int _rtl92e_wx_set_encode_ext(struct net_device *dev,
>   
>   		if ((encoding->flags & IW_ENCODE_DISABLED) ||
>   		    ext->alg == IW_ENCODE_ALG_NONE) {
> -			ieee->pairwise_key_type = ieee->group_key_type
> -						= KEY_TYPE_NA;
> +			ieee->pairwise_key_type = KEY_TYPE_NA;
> +			ieee->group_key_type = KEY_TYPE_NA;
>   			rtl92e_cam_reset(dev);
>   			memset(priv->rtllib->swcamtable, 0,
>   			       sizeof(struct sw_cam_table) * 32);


Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>


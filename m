Return-Path: <linux-kernel+bounces-305561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE6596307C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 20:54:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B917D1F21F53
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 18:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 141B31AB53F;
	Wed, 28 Aug 2024 18:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MZq/nSSb"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46CA1AB52F
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 18:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724871223; cv=none; b=KGdpQUmPLuBBnRwgI2wwfZnZYNzQISzWMVdmRZmy8g/LYLezKlLYO0Pb7npzp56MOk7bev0aAkhKTzmrE65ficlZpdlOUCPrAHcjhMOvOzUO+NQkoTnauVNKUD8qh1J5qfYK76l4T5J7f/ZSymHq9RwP3I2bGIHhkcRQQrYBVCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724871223; c=relaxed/simple;
	bh=mWWhHr5FhcCsGIpe/vAFA3YyUUBlhickxBm3OS4+PxA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=sL1GRuGoXYjCgS/xfkm0Tu4aC9CIk7P8+XbgNzDCr7jrizx75POC+EXlTjLmk4HJtOREr8aTfDUDZdJJncUcglAm/zQ7CsOGf+JSpG2GaZO483lRNh2D+ghwkC4V6x3E+YF5k5v1NadZXaXzBBJoiQiBFmh2ZHGJyR3vWhlNcvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MZq/nSSb; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2f3ffc7841dso64887631fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 11:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724871220; x=1725476020; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XS+8S0ryMFAMWQssmQoYU8z7iU7cHo9/4lod3SR7u64=;
        b=MZq/nSSbc5eJ7tJkWLjIcbLznkFLi9e5cuIeRVBuiZZVOSbuLcULuc/iYxHoy10eIk
         rcJyP6sX5WoApSILj8X4zJ/kTwQ9CQZVW+6B2HVhR+mQa9grOlum6Fa9FuYn+Sae+pT6
         V3QaJHEBeLroAVImw1zMnYL40O48CWrxXDypKzRFbBnTnLiNgF5+XGUrmaw4hV+QPvDc
         HZTzjYzr3XMStKYifPd+A4UjiAj75iywaOhFHIfbCPUjtEWBND3INnwGJeJCjFoSCB3a
         oBymFxSxH/D2x0mPtvQcnAsVhS89DLN4Q35UgMPSyWzd3fc4ZWf8jirsGqdve0lFjRQ4
         6YLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724871220; x=1725476020;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XS+8S0ryMFAMWQssmQoYU8z7iU7cHo9/4lod3SR7u64=;
        b=eXF5Fs+kBqnwCYS7JHcg9QnySDjQLKXEe/YPwYwPQnJO5enDdpGLpMiokpBiy/rTL3
         rkjb6qodQd0rNWSb/yCMLVQHhfEo1nkmeHApArfAE0Th8SUkpczI2CsOvP+WiUwkuvwv
         tg0aHHtQvAaGOnki4JZXW7LIuS48cVPoe4yH5T/D9KfSldsEwpmpPeY3DE8gxvm8wVc0
         NPCruCxrG/duZ6uAy/xQTynAlsJkqC6qsIao7pGk3HssF2FXbsCN4OcbpUPhRqpAXBvK
         yO9/CX0Q7FRJDgd8qly7/joHoMPR1TMIn6v/O1yTFFmTfqO+wsa+8HbiSF9b0PCwrtwP
         Y7fw==
X-Forwarded-Encrypted: i=1; AJvYcCWPzWD/hsv7G+fjjXb8IypQy6UKPAaPqqh2yZL/Tk8V0wjI5PJ1/rndx+516Os17HltDyr9l2LWRlsFAr8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVH7DyXEml57i6XUp+3K638H8W9T6Ks5znDayjT1wQaULy0G0e
	yqm/wjoLEG/wl9GbjKWKITGu1AC48w2IXl9pKpso9pFD5J24cWKT
X-Google-Smtp-Source: AGHT+IGG1KK9bNlqKjmboXudHmFDGuox8xPH09r64BmCcLIP8gPu76NJnOkXeQjD/ZJEV/1LrvnSPQ==
X-Received: by 2002:a05:651c:2221:b0:2ef:2525:be90 with SMTP id 38308e7fff4ca-2f610922d15mr4064731fa.31.1724871219235;
        Wed, 28 Aug 2024 11:53:39 -0700 (PDT)
Received: from ?IPV6:2003:c7:8f2a:8553:4dd4:7649:c4c2:f4e3? (p200300c78f2a85534dd47649c4c2f4e3.dip0.t-ipconnect.de. [2003:c7:8f2a:8553:4dd4:7649:c4c2:f4e3])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c0bb21975csm2593766a12.57.2024.08.28.11.53.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Aug 2024 11:53:38 -0700 (PDT)
Message-ID: <efe13a61-1607-419d-b330-9a7061511719@gmail.com>
Date: Wed, 28 Aug 2024 20:53:38 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] staging: rtl8192e: Fix parenthesis alignment in
 r8192E_dev.c 325
To: Nilo Alexandre <n1lux.comp@gmail.com>, gregkh@linuxfoundation.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
 ~lkcamp/patches@lists.sr.ht
References: <20240828011842.67611-1-n1lux.comp@gmail.com>
Content-Language: en-US
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20240828011842.67611-1-n1lux.comp@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/28/24 03:18, Nilo Alexandre wrote:
> Remove linebreak to improve readability
> 
Hi Nilo,

please end the above sentences with a ".".


> CHECK: Alignment should match open parenthesis
Why do we need the above line?

Thanks for your support.

Bye Philipp
> 
> Signed-off-by: Nilo Alexandre <n1lux.comp@gmail.com>
> ---
> v4: Remove linebreak to improve readability
> v3: Fix typo in commit message.
> v2: Using tabs instead of spaces.
> ---
>   drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
> index b25e83743956d..a80efe6c7c209 100644
> --- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
> +++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
> @@ -321,8 +321,7 @@ static void _rtl92e_read_eeprom_info(struct net_device *dev)
>   
>   		if (priv->epromtype == EEPROM_93C46) {
>   			if (!priv->autoload_fail_flag) {
> -				usValue = rtl92e_eeprom_read(dev,
> -					  EEPROM_TxPwDiff_CrystalCap >> 1);
> +				usValue = rtl92e_eeprom_read(dev, EEPROM_TxPwDiff_CrystalCap >> 1);
>   				priv->eeprom_ant_pwr_diff = usValue & 0x0fff;
>   				priv->eeprom_crystal_cap = (usValue & 0xf000)
>   							 >> 12;



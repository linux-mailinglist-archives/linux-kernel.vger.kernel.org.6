Return-Path: <linux-kernel+bounces-366873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD78B99FBA3
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 00:47:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52653288D47
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 22:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41D331B0F31;
	Tue, 15 Oct 2024 22:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hd0duANA"
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A1E146A9B
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 22:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729032467; cv=none; b=WHmV08LgdLDHsXCxAru+NjWitYYIiUC6FeIhNr9LoAEtO0KjAoEgevNY7gcG/y7YrAP5P6rwiONG+PIq+MKkPvtZhorIflhGRbVZxIi8ly3DXydWL8MVB5fZjvEFegJ/0rdBiKm2buhHi8FO+m8t1MI6+1MsZz1iojZdAmvg9D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729032467; c=relaxed/simple;
	bh=9/yMpBDQ4MgXG2JF/M1DyXAd4P4K7E/pFGhOwQo8lLY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U8HpWzLequKXJep+RptDOq6EQpzLvk8bFb8roz41+53S0rdVtIJ8zSyEWMM5ltoEub+4pmoOy1pGj201aSXPVqhjp7l0QsDvuL2h4dW3gRlqC4+JVl0ZdUjmJCG5U6rYmvqt1hVMgRcqRpNBeNrRyyZYYbDe0xxDU6hGb86Kj30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hd0duANA; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-836f1b47cdfso286059339f.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 15:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1729032464; x=1729637264; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DI+wbwBHXGEyEuVIdZAIUUyrgbXUSc33fVGVN+YkPw4=;
        b=hd0duANA11l9RH77saVrl6fEIV3u9woZPIhgHXK5Xc24iBvV0VSxhVlyzfkLIfiXQe
         bp1f2794cJfe8a0IulX0iUnh9lV1MtWXJZ7xLloj2npgrEUY42+YqokogsZf/qu2Ge6p
         dMMcy6Y/jlIqURAjXWGYBol44q09UuUW0avxc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729032464; x=1729637264;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DI+wbwBHXGEyEuVIdZAIUUyrgbXUSc33fVGVN+YkPw4=;
        b=fdeePkGi14zGRErV+kgrlADx5BS7iu8AXKsphCI8YnfOvPdY6Rdm2kcsWAg7b+LhK9
         yDnNdyFY6zqcV5XBKmE4NST52K2Xd9AFMiEBI54AwO1egCCfEUFWqPVAuIAblb5dyOyA
         jwVDN2losidSRiN5Q9wnrbil7nPL3i/zljIw5qnrS6nHS13xWoyf41lvG5AEQCEMzJhW
         Ld8FNdFQS+iEeuaG3PN7v2kOeDpMMaS5eBU1u3NlCxYNCszuOyKuNj2zGbfsLeO9Mc+i
         FmJZ2a6W8l523hpFEOEyuoycGWlWk4j/FQ72MtAuxQWYa6dU/+dQRn80funcueRcR0MG
         /Thg==
X-Forwarded-Encrypted: i=1; AJvYcCWHG1rhN02tw+iEUcvlBGZXWVmyHTg7tg18fAfmG1Mx+XBAhOV6/uTPxZzJqllpLArIAQ3zQl5I0E+GGRQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSHPJiH/hAHnOFmLnnQFADu+1fg/eiaQ7GfQgjP5xJLHfwo1Is
	wGHphMboBltohRy8K3zcHWC2CwMCjstwcz6VY8nL15SCfgEy/LJKZ31ovEWsayk=
X-Google-Smtp-Source: AGHT+IHJV0rzbHJHrUk9jakRVl53VDfEC+90zTQZ/dU8ydWTUn7uTDUdVw+xqFWw3ZDBaqvrD73k9A==
X-Received: by 2002:a05:6602:60c9:b0:837:6dae:207b with SMTP id ca18e2360f4ac-837956f9631mr1436289139f.16.1729032463609;
        Tue, 15 Oct 2024 15:47:43 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4dbecb38deasm531415173.106.2024.10.15.15.47.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Oct 2024 15:47:43 -0700 (PDT)
Message-ID: <59521671-db23-42ba-8db3-ed48cef53c05@linuxfoundation.org>
Date: Tue, 15 Oct 2024 16:47:42 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] staging: gpib: Remove a dead condition in if statement
To: "Everest K.C." <everestkc@everestkc.com.np>, dpenkler@gmail.com,
 gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241015200655.17444-1-everestkc@everestkc.com.np>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241015200655.17444-1-everestkc@everestkc.com.np>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/15/24 14:06, Everest K.C. wrote:
> The variable `residue` is an unsigned int, also the function
> `fluke_get_dma_residue` returns an unsigned int. The value of
> an unsigned int can only be 0 at minimum.
> The less-than-zero comparision can never be true.
> Fix it by removing the dead condition in the if statement.
> 
> This issue was reported by Coverity Scan.
> Report:
> CID 1600782: (#1 of 1): Macro compares unsigned to 0 (NO_EFFECT)
> unsigned_compare: This less-than-zero comparison of an unsigned value
> is never true. residue < 0U.
> 
> Fixes: 55936779f496 ("staging: gpib: Add Fluke cda based cards GPIB driver")
> Signed-off-by: Everest K.C. <everestkc@everestkc.com.np>
> ---
>   drivers/staging/gpib/eastwood/fluke_gpib.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/gpib/eastwood/fluke_gpib.c b/drivers/staging/gpib/eastwood/fluke_gpib.c
> index f9f149db222d..51b4f9891a34 100644
> --- a/drivers/staging/gpib/eastwood/fluke_gpib.c
> +++ b/drivers/staging/gpib/eastwood/fluke_gpib.c
> @@ -644,7 +644,7 @@ static int fluke_dma_read(gpib_board_t *board, uint8_t *buffer,
>   	 */
>   	usleep_range(10, 15);
>   	residue = fluke_get_dma_residue(e_priv->dma_channel, dma_cookie);
> -	if (WARN_ON_ONCE(residue > length || residue < 0))
> +	if (WARN_ON_ONCE(residue > length))

Are you sure this is the right fix? length is size_t
fluke_get_dma_residue() returns unsigned int - yes
the coverity report is correct, but should fluke_get_dma_residue()
return size_t?

>   		return -EFAULT;
>   	*bytes_read += length - residue;

bytes_read is also size_t

>   	dmaengine_terminate_all(e_priv->dma_channel);

The patch should indicate it is against next. [PATCH next].

thanks,
-- Shuah



